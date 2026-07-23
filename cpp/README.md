# BluefinDecryptx C++ SDK



The C++ SDK for the BluefinDecryptx API — a header-only,
entity-oriented client following idiomatic modern C++ (C++17) conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client->decrypt()` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low. Every value flows through a single dynamic
`sdk::Value` type (a JSON-like variant), so there is no schema-driven code to
regenerate when the API changes.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
The C++ SDK is **header-only** — there is no package to install
from a registry. Vendor the `cpp/` directory into your project (or add the
repository as a git submodule) and put it on your compiler's include path.
Releases are cut as the git tag `cpp/vX.Y.Z` (see
[Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases)).

```bash
# Add the SDK as a submodule (or copy the cpp/ directory into your tree).
git submodule add <repo-url> third_party/bluefindecryptx-sdk
```

Then include the umbrella header and compile with C++17:

```cpp
#include "core/sdk.hpp"
```

```bash
g++ -std=c++17 -Ithird_party/bluefindecryptx-sdk/cpp your_app.cpp -o your_app
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```cpp
#include <cstdlib>
#include "core/sdk.hpp"

using namespace sdk;

const char* apikey = std::getenv("BLUEFIN_DECRYPTX_APIKEY");
auto client = std::make_shared<BluefinDecryptxSDK>(vmap({
    {"apikey", Value(apikey ? apikey : "")},
}));
```

### 2. List decrypt records

`list()` returns an `sdk::Value` list and throws `sdk::SdkErrorPtr`
on error — iterate it directly.

```cpp
try {
  Value decrypts = client->decrypt()->list(Value::undef(), Value::undef());
  for (const auto& decrypt : *decrypts.as_list()) {
    std::cout << Struct::jsonify(decrypt) << std::endl;
  }
} catch (const SdkErrorPtr& err) {
  std::cerr << "list failed: " << err->msg << std::endl;
}
```

### 4. Create, update, and remove

```cpp
// Create — returns the bare created record.
Value created = client->decrypt()->create(vmap({{"decryption_parameter", vmap()}, {"encrypted", vlist()}, {"has_cc_data", Value(true)}, {"message_id", Value("example_message_id")}, {"name", Value("example_name")}, {"reference", Value("example_reference")}, {"serial", Value("example_serial")}, {"success", Value(true)}}), Value::undef());

```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const decrypts = await client.Decrypt().list()
  console.log(decrypts)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```cpp
Value result = client->direct(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("GET")},
    {"params", vmap({{"id", Value("example")}})},
}));

if (getp(result, "ok") == Value(true)) {
  std::cout << Helpers::toInt(getp(result, "status")) << std::endl;  // 200
  std::cout << Struct::jsonify(getp(result, "data")) << std::endl;   // response body
} else {
  // A non-2xx response carries status + data (the error body); a
  // transport-level failure carries err instead. Only one is present.
  std::cerr << Helpers::toInt(getp(result, "status")) << " "
            << Struct::jsonify(getp(result, "err")) << std::endl;
}
```

`direct()` is the escape hatch: it never throws — branch on
`getp(result, "ok")`.

### Prepare a request without sending it

```cpp
// prepare() returns the fetch definition and throws on error.
Value fetchdef = client->prepare(vmap({
    {"path", Value("/api/resource/{id}")},
    {"method", Value("DELETE")},
    {"params", vmap({{"id", Value("example")}})},
}));

std::cout << Struct::stringify(getp(fetchdef, "url")) << std::endl;
std::cout << Struct::stringify(getp(fetchdef, "method")) << std::endl;
std::cout << Struct::jsonify(getp(fetchdef, "headers")) << std::endl;
```

### Use test mode

Create a mock client for unit testing — no server required. The test
feature installs an in-memory mock transport:

```cpp
auto client = BluefinDecryptxSDK::testSDK();

// Entity ops return the bare record and throw on error.
Value decrypt = client->decrypt()->list(Value::undef(), Value::undef());
// decrypt contains the mock response record
std::cout << Struct::jsonify(decrypt) << std::endl;
```

You can seed the mock store by passing test options — see the generated
`test/` suite for worked examples.

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then build and run the test suite:

```bash
cd cpp && make test
```


## Reference

### BluefinDecryptxSDK

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<BluefinDecryptxSDK>(options);
```

Creates a new SDK client. `options` is an `sdk::Value` map.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `std::string` | API key for authentication. |
| `base` | `std::string` | Base URL of the API server. |
| `prefix` | `std::string` | URL path prefix prepended to all requests. |
| `suffix` | `std::string` | URL path suffix appended to all requests. |
| `feature` | `Value` | Feature activation flags. |
| `system` | `Value` | System overrides. |

### testSDK

```cpp
auto client = BluefinDecryptxSDK::testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`Value::undef()`; a no-arg `BluefinDecryptxSDK::testSDK()` overload is
also provided.

### BluefinDecryptxSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Value` | Deep copy of current SDK options. |
| `getUtility` | `() -> UtilityPtr` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Value` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> Value` | Build and send an HTTP request. Returns a result Value (branch on `ok`). |
| `decrypt` | `(entopts) -> std::shared_ptr<DecryptEntity>` | Create a Decrypt entity instance. |
| `decrypt_ext` | `(entopts) -> std::shared_ptr<DecryptExtEntity>` | Create a DecryptExt entity instance. |
| `validation` | `(entopts) -> std::shared_ptr<ValidationEntity>` | Create a Validation entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch, ctrl) -> Value` | List entities matching the criteria (a Value list). Throws on error. |
| `create` | `(reqdata, ctrl) -> Value` | Create a new entity. Throws on error. |
| `data` | `(arg) -> Value` | Get (no arg) or set (with arg) entity data. |
| `match` | `(arg) -> Value` | Get (no arg) or set (with arg) entity match criteria. |
| `make` | `() -> EntityPtr` | Create a new instance with the same options. |
| `getName` | `() -> std::string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a map `Value` for
single-entity ops, a list `Value` for `list`) and throw
`sdk::SdkErrorPtr` on error. Wrap calls in `try`/`catch` to handle
failures.

The `direct()` escape hatch never throws — it returns a result `Value`
you branch on via `getp(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Value` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

### Entities

#### Decrypt

| Field | Description |
| --- | --- |
| `client_id` |  |
| `code` |  |
| `decrypted` |  |
| `decryption_parameter` |  |
| `encrypted` |  |
| `failed` |  |
| `firmware` |  |
| `has_cc_data` |  |
| `message` |  |
| `message_id` |  |
| `name` |  |
| `partner_id` |  |
| `partner_key` |  |
| `reference` |  |
| `serial` |  |
| `success` |  |
| `value` |  |

Operations: Create, List.

API path: `/decrypt`

#### DecryptExt

| Field | Description |
| --- | --- |
| `client_id` |  |
| `completed` |  |
| `decrypted` |  |
| `encrypted` |  |
| `ip` |  |
| `message_id` |  |
| `partner_id` |  |
| `partner_key` |  |
| `reference` |  |
| `serial` |  |
| `success` |  |

Operations: Create.

API path: `/decrypt-ext`

#### Validation

| Field | Description |
| --- | --- |
| `client_id` |  |
| `firmware` |  |
| `message_id` |  |
| `partner_id` |  |
| `partner_key` |  |
| `reference` |  |
| `serial` |  |
| `success` |  |

Operations: Create.

API path: `/device/validate`



## Entities


### Decrypt

Create an instance: `auto decrypt = client->decrypt();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |
| `list(match, ctrl)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `std::string` |  |
| `code` | `int64_t` |  |
| `decrypted` | `std::vector<Value>` |  |
| `decryption_parameter` | `std::map<std::string, Value>` |  |
| `encrypted` | `std::vector<Value>` |  |
| `failed` | `bool` |  |
| `firmware` | `std::string` |  |
| `has_cc_data` | `bool` |  |
| `message` | `std::string` |  |
| `message_id` | `std::string` |  |
| `name` | `std::string` |  |
| `partner_id` | `std::string` |  |
| `partner_key` | `std::string` |  |
| `reference` | `std::string` |  |
| `serial` | `std::string` |  |
| `success` | `bool` |  |
| `value` | `std::string` |  |

#### Example: List

```cpp
Value decrypts = client->decrypt()->list(Value::undef(), Value::undef());
```

#### Example: Create

```cpp
Value decrypt = client->decrypt()->create(vmap({
    {"decryption_parameter", vmap()},  // std::map<std::string, Value>
    {"encrypted", vlist()},  // std::vector<Value>
    {"has_cc_data", Value(true)},  // bool
    {"message_id", Value("example_message_id")},  // std::string
    {"name", Value("example_name")},  // std::string
    {"reference", Value("example_reference")},  // std::string
    {"serial", Value("example_serial")},  // std::string
    {"success", Value(true)},  // bool
}), Value::undef());
```


### DecryptExt

Create an instance: `auto decrypt_ext = client->decrypt_ext();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `std::string` |  |
| `completed` | `std::string` |  |
| `decrypted` | `double` |  |
| `encrypted` | `double` |  |
| `ip` | `std::string` |  |
| `message_id` | `std::string` |  |
| `partner_id` | `std::string` |  |
| `partner_key` | `std::string` |  |
| `reference` | `std::string` |  |
| `serial` | `std::string` |  |
| `success` | `bool` |  |

#### Example: Create

```cpp
Value decrypt_ext = client->decrypt_ext()->create(vmap({
    {"encrypted", Value(1)},  // double
    {"partner_id", Value("example_partner_id")},  // std::string
    {"serial", Value("example_serial")},  // std::string
}), Value::undef());
```


### Validation

Create an instance: `auto validation = client->validation();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `std::string` |  |
| `firmware` | `std::string` |  |
| `message_id` | `std::string` |  |
| `partner_id` | `std::string` |  |
| `partner_key` | `std::string` |  |
| `reference` | `std::string` |  |
| `serial` | `std::string` |  |
| `success` | `bool` |  |

#### Example: Create

```cpp
Value validation = client->validation()->create(vmap({
    {"message_id", Value("example_message_id")},  // std::string
    {"reference", Value("example_reference")},  // std::string
    {"serial", Value("example_serial")},  // std::string
    {"success", Value(true)},  // bool
}), Value::undef());
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as `Value`

The C++ SDK uses a single dynamic `sdk::Value` type (a JSON-like variant
over string / number / bool / list / map) throughout rather than generated
typed structs. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema changes.

Build maps with `sdk::vmap({{"key", sdk::Value("v")}})` and lists with
`sdk::vlist({...})`; read fields back with `sdk::getp(value, "key")`. Use
`sdk::to_map()` to safely coerce a value that should be a map, and
`sdk::Struct::jsonify(value)` to render it as JSON.

### Directory structure

```
cpp/
├── core/                        -- Runtime type graph, config, generated client
├── entity/                      -- Per-entity client headers
├── feature/                     -- Built-in features (Base, Test, Log, ...)
├── utility/                     -- Operation pipeline + vendored struct library
├── test/                        -- Test suites
├── Makefile                     -- Build & run the tests (C++17)
└── VERSION                      -- SDK version
```

Include the umbrella header `core/sdk.hpp` to pull in the whole SDK: the
runtime types, the pipeline utilities, the vendored struct, the generated
config, the per-entity clients and the generated `BluefinDecryptxSDK`
client class. Everything lives in the `sdk` namespace.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const decrypt = client.Decrypt()
await decrypt.list()

// decrypt.data() now returns the decrypt data from the last `list`
// decrypt.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
