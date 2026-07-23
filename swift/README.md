# BluefinDecryptx Swift SDK



The Swift SDK for the BluefinDecryptx API — an entity-oriented client following idiomatic Swift conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Decrypt()` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to a SwiftPM registry. The generated SDK
is a dependency-free SwiftPM package (Foundation only, plus the vendored
Voxgig Struct port). Depend on it from the GitHub release tag
(`swift/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases)) by adding it to
your `Package.swift`:

```swift
dependencies: [
    // From the git release tag:
    .package(url: "<repo-url>", exact: "0.0.1"),
],
```

Or build from a source checkout with SwiftPM:

```bash
cd swift && swift build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```swift
import BluefinDecryptxSdk

let options = VMap()
options.entries["apikey"] = .string(
    ProcessInfo.processInfo.environment["BLUEFIN_DECRYPTX_APIKEY"] ?? "")
let client = BluefinDecryptxSDK(options)
```

### 2. List decrypt records

`list(nil, nil)` returns a `Value` list of records and throws on error —
iterate its items.

```swift
do {
    let decryptList = try client.Decrypt().list(nil, nil)
    for decrypt in decryptList.asList?.items ?? [] {
        print(decrypt)
    }
}
catch {
    print("list failed: \(error)")
}
```

### 4. Create, update, and remove

```swift
// Create — returns the bare created record (a Value)
let created = try client.Decrypt().create(VMap([("decryption_parameter", .map(VMap())), ("encrypted", .list([])), ("has_cc_data", .bool(true)), ("message_id", .string("example_message_id")), ("name", .string("example_name")), ("reference", .string("example_reference")), ("serial", .string("example_serial")), ("success", .bool(true))]), nil)

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

```swift
let result = client.direct(VMap([
    ("path", .string("/api/resource/{id}")),
    ("method", .string("GET")),
    ("params", .map([("id", .string("example"))])),
]))

if result.entries["ok"] == .bool(true) {
    print(result.entries["status"] ?? .noval)  // 200
    print(result.entries["data"] ?? .noval)     // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // an absent key simply reads as .noval.
    print(result.entries["status"] ?? .noval, result.entries["err"] ?? .noval)
}
```

### Prepare a request without sending it

```swift
// prepare() returns the fetch definition and throws on error.
let fetchdef = try client.prepare(VMap([
    ("path", .string("/api/resource/{id}")),
    ("method", .string("DELETE")),
    ("params", .map([("id", .string("example"))])),
]))

print(fetchdef.entries["url"] ?? .noval)
print(fetchdef.entries["method"] ?? .noval)
print(fetchdef.entries["headers"] ?? .noval)
```

### Use test mode

Create a mock client for unit testing — no server required:

```swift
let client = BluefinDecryptxSDK.testSDK(nil, nil)

// Entity ops return the bare record and throw on error.
let decrypt = try client.Decrypt().list(nil, nil)
// decrypt holds the mock response record
print(decrypt)
```

### Use a custom fetch function

Replace the HTTP transport with your own `SystemFetch` closure:

```swift
let fetch: SystemFetch = { url, _ in
    let m = VMap()
    m.entries["status"] = .int(200)
    m.entries["statusText"] = .string("OK")
    m.entries["headers"] = .map(VMap())
    m.entries["json"] = .nat({ () -> Value in .map(VMap([("id", .string("mock01"))])) } as NativeCall0)
    return .map(m)
}

let system = VMap()
system.entries["fetch"] = .nat(fetch)
let options = VMap()
options.entries["base"] = .string("http://localhost:8080")
options.entries["system"] = .map(system)
let client = BluefinDecryptxSDK(options)
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run:

```bash
cd swift && make test
```


## Reference

### BluefinDecryptxSDK

```swift
let client = BluefinDecryptxSDK(options)
```

Creates a new SDK client. `options` is a `VMap` of `Value`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `VMap` | Feature activation flags. |
| `extend` | `VList` | Additional Feature instances to load. |
| `system` | `VMap` | System overrides (e.g. custom `fetch` function). |

### testSDK

```swift
let client = BluefinDecryptxSDK.testSDK(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### BluefinDecryptxSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> VMap` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) throws -> VMap` | Build an HTTP request definition without sending. Throws on error. |
| `direct` | `(fetchargs) -> VMap` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `Decrypt` | `(entopts) -> BluefinDecryptxEntityBase` | Create a Decrypt entity instance. |
| `DecryptExt` | `(entopts) -> BluefinDecryptxEntityBase` | Create a DecryptExt entity instance. |
| `Validation` | `(entopts) -> BluefinDecryptxEntityBase` | Create a Validation entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch, ctrl) throws -> Value` | List entities matching the criteria (a Value list). Throws on error. |
| `create` | `(reqdata, ctrl) throws -> Value` | Create a new entity. Throws on error. |
| `data` | `(newdata?) -> Value` | Get or set entity data. |
| `matchv` | `(newmatch?) -> Value` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `Value` map for
single-entity ops, a `Value` list for `list`) and throw on error. Wrap
calls in `do`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `VMap` you
branch on via `result.entries["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `true` if the HTTP status is 2xx. |
| `status` | `Int` | HTTP status code. |
| `headers` | `VMap` | Response headers. |
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

Create an instance: `let decrypt = client.Decrypt()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |
| `list(nil, nil)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `code` | `Int` |  |
| `decrypted` | `[Value]` |  |
| `decryption_parameter` | `VMap` |  |
| `encrypted` | `[Value]` |  |
| `failed` | `Bool` |  |
| `firmware` | `String` |  |
| `has_cc_data` | `Bool` |  |
| `message` | `String` |  |
| `message_id` | `String` |  |
| `name` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Bool` |  |
| `value` | `String` |  |

#### Example: List

```swift
let decryptList = try client.Decrypt().list(nil, nil)
```

#### Example: Create

```swift
let decrypt = try client.Decrypt().create(VMap([
    ("decryption_parameter", .map(VMap())),  // VMap
    ("encrypted", .list([])),  // [Value]
    ("has_cc_data", .bool(true)),  // Bool
    ("message_id", .string("example_message_id")),  // String
    ("name", .string("example_name")),  // String
    ("reference", .string("example_reference")),  // String
    ("serial", .string("example_serial")),  // String
    ("success", .bool(true))  // Bool
]), nil)
```


### DecryptExt

Create an instance: `let decryptExt = client.DecryptExt()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `completed` | `String` |  |
| `decrypted` | `Double` |  |
| `encrypted` | `Double` |  |
| `ip` | `String` |  |
| `message_id` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Bool` |  |

#### Example: Create

```swift
let decryptExt = try client.DecryptExt().create(VMap([
    ("encrypted", .double(1.0)),  // Double
    ("partner_id", .string("example_partner_id")),  // String
    ("serial", .string("example_serial"))  // String
]), nil)
```


### Validation

Create an instance: `let validation = client.Validation()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, nil)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `firmware` | `String` |  |
| `message_id` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Bool` |  |

#### Example: Create

```swift
let validation = try client.Validation().create(VMap([
    ("message_id", .string("example_message_id")),  // String
    ("reference", .string("example_reference")),  // String
    ("serial", .string("example_serial")),  // String
    ("success", .bool(true))  // Bool
]), nil)
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

### Data as loose values

The Swift SDK uses a loose object model — the vendored `Value` enum
(with `VMap` / `VList` wrappers) throughout — rather than a bespoke typed
struct per endpoint. This mirrors the dynamic nature of the API and keeps the
SDK flexible: no regeneration is needed when the API schema changes.

Use the `.asMap` / `.asList` / `.asString` accessors to safely coerce a
`Value` to a concrete Swift type (each returns `nil` on a type mismatch).
A `BluefinDecryptxTypes.swift` file of reference `struct` types is also
generated for editor documentation.

### Project structure

```
swift/
├── Package.swift                     -- SwiftPM manifest (zero runtime deps)
├── Sources/ProjectNameSDK/
│   ├── core/                         -- Main client, config, entity base, error type
│   ├── entity/                       -- Generated entity clients
│   ├── feature/                      -- Built-in features (Base, Test, Log, ...)
│   ├── utility/                      -- Utility functions
│   └── Struct/                       -- Vendored Voxgig Struct port
└── Tests/ProjectNameSDKTests/        -- Test suites (XCTest)
```

The main client class (`BluefinDecryptxSDK`, under `Sources/ProjectNameSDK/core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed. The SDK is dependency-free: JSON parsing is the vendored
`Struct/JSON.swift`, HTTP transport is Foundation's `URLSession`, and the
struct library is inlined under `Struct/`.

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
