# BluefinDecryptx Java SDK



The Java SDK for the BluefinDecryptx API — an entity-oriented client following idiomatic Java conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.decrypt(null)` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Maven Central. Install it from the GitHub
release tag (`java/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases)) or
from a source checkout — build the library with Maven:

```bash
cd java && mvn install
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```java
import voxgig.bluefindecryptxsdk.core.BluefinDecryptxSDK;

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("apikey", System.getenv("BLUEFIN_DECRYPTX_APIKEY"));
BluefinDecryptxSDK client = new BluefinDecryptxSDK(options);
```

### 2. List decrypt records

`list(null, null)` returns an aggregate list of records (as `Object`, an
aggregate list) and raises on error.

```java
try {
    Object decryptList = client.decrypt(null).list(null, null);
    System.out.println(decryptList);
}
catch (RuntimeException err) {
    System.out.println("list failed: " + err.getMessage());
}
```

### 4. Create, update, and remove

```java
// Create — returns the bare created record (as Object)
Object created = client.decrypt(null).create(Map.of("decryption_parameter", Map.of(), "encrypted", List.of(), "has_cc_data", true, "message_id", "example_message_id", "name", "example_name", "reference", "example_reference", "serial", "example_serial", "success", true), null);

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

```java
Map<String, Object> result = client.direct(Map.of(
    "path", "/api/resource/{id}",
    "method", "GET",
    "params", Map.of("id", "example")));

if (Boolean.TRUE.equals(result.get("ok"))) {
    System.out.println(result.get("status"));  // 200
    System.out.println(result.get("data"));    // response body
}
else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present, so
    // read both — an absent key simply reads as null.
    System.out.println(result.get("status") + " " + result.get("err"));
}
```

### Prepare a request without sending it

```java
// prepare() returns the fetch definition and raises on error.
Map<String, Object> fetchdef = client.prepare(Map.of(
    "path", "/api/resource/{id}",
    "method", "DELETE",
    "params", Map.of("id", "example")));

System.out.println(fetchdef.get("url"));
System.out.println(fetchdef.get("method"));
System.out.println(fetchdef.get("headers"));
```

### Use test mode

Create a mock client for unit testing — no server required:

```java
BluefinDecryptxSDK client = BluefinDecryptxSDK.testSDK(null, null);

// Entity ops return the bare record and raise on error.
Object decrypt = client.decrypt(null).list(null, null);
// decrypt holds the mock response record
System.out.println(decrypt);
```

### Use a custom fetch function

Replace the HTTP transport with your own `BiFunction`:

```java
java.util.function.BiFunction<String, Map<String, Object>, Object> mockFetch =
    (url, init) -> {
        Map<String, Object> res = new java.util.LinkedHashMap<>();
        res.put("status", 200);
        res.put("statusText", "OK");
        res.put("headers", new java.util.LinkedHashMap<String, Object>());
        res.put("json", (java.util.function.Supplier<Object>) () ->
            Map.of("id", "mock01"));
        return res;
    };

Map<String, Object> options = new java.util.LinkedHashMap<>();
options.put("base", "http://localhost:8080");
options.put("system", Map.of("fetch", mockFetch));
BluefinDecryptxSDK client = new BluefinDecryptxSDK(options);
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run:

```bash
cd java && mvn test
```


## Reference

### BluefinDecryptxSDK

```java
BluefinDecryptxSDK client = new BluefinDecryptxSDK(options);
```

Creates a new SDK client. `options` is a `Map<String, Object>`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Map` | Feature activation flags. |
| `extend` | `List` | Additional Feature instances to load. |
| `system` | `Map` | System overrides (e.g. custom `fetch` function). |

### testSDK

```java
BluefinDecryptxSDK client = BluefinDecryptxSDK.testSDK(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### BluefinDecryptxSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `optionsMap` | `() -> Map` | Deep copy of current SDK options. |
| `getUtility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Map` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Map` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `decrypt` | `(entopts) -> SdkEntity` | Create a Decrypt entity instance. |
| `decryptExt` | `(entopts) -> SdkEntity` | Create a DecryptExt entity instance. |
| `validation` | `(entopts) -> SdkEntity` | Create a Validation entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch, ctrl) -> Object` | List entities matching the criteria (an aggregate list). Raises on error. |
| `create` | `(reqdata, ctrl) -> Object` | Create a new entity. Raises on error. |
| `data` | `(newdata...) -> Object` | Get or set entity data. |
| `match` | `(newmatch...) -> Object` | Get or set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `getName` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `Map` for single-entity
ops, an aggregate `List` for `list`) as `Object` and raise on error. Wrap
calls in `try`/`catch` to handle failures.

The `direct()` escape hatch never raises — it returns a result
`Map<String, Object>` you branch on via `result.get("ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `Map` | Response headers. |
| `data` | `Object` | Parsed JSON response body. |

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

Operations: create, list.

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

Operations: create.

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

Operations: create.

API path: `/device/validate`



## Entities


### Decrypt

Create an instance: `SdkEntity decrypt = client.decrypt(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |
| `list(null, null)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `code` | `Long` |  |
| `decrypted` | `List<Object>` |  |
| `decryption_parameter` | `Map<String, Object>` |  |
| `encrypted` | `List<Object>` |  |
| `failed` | `Boolean` |  |
| `firmware` | `String` |  |
| `has_cc_data` | `Boolean` |  |
| `message` | `String` |  |
| `message_id` | `String` |  |
| `name` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Boolean` |  |
| `value` | `String` |  |

#### Example: List

```java
Object decryptList = client.decrypt(null).list(null, null);
```

#### Example: Create

```java
Object decrypt = client.decrypt(null).create(Map.of(
    "decryption_parameter", Map.of(),  // Map<String, Object>
    "encrypted", List.of(),  // List<Object>
    "has_cc_data", true,  // Boolean
    "message_id", "example_message_id",  // String
    "name", "example_name",  // String
    "reference", "example_reference",  // String
    "serial", "example_serial",  // String
    "success", true  // Boolean
), null);
```


### DecryptExt

Create an instance: `SdkEntity decryptExt = client.decryptExt(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |

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
| `success` | `Boolean` |  |

#### Example: Create

```java
Object decryptExt = client.decryptExt(null).create(Map.of(
    "encrypted", 1.0,  // Double
    "partner_id", "example_partner_id",  // String
    "serial", "example_serial"  // String
), null);
```


### Validation

Create an instance: `SdkEntity validation = client.validation(null);`

#### Operations

| Method | Description |
| --- | --- |
| `create(data, null)` | Create a new entity with the given data. |

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
| `success` | `Boolean` |  |

#### Example: Create

```java
Object validation = client.validation(null).create(Map.of(
    "message_id", "example_message_id",  // String
    "reference", "example_reference",  // String
    "serial", "example_serial",  // String
    "success", true  // Boolean
), null);
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

### Data as maps

The Java SDK uses a loose object model — `Map<String, Object>` throughout —
rather than a bespoke typed class per endpoint. This mirrors the dynamic
nature of the API and keeps the SDK flexible: no regeneration is needed when
the API schema changes.

Use `Helpers.toMapAny(value)` to safely coerce a value to a
`Map<String, Object>`. A `BluefinDecryptxTypes.java` module of reference
`record` types is also generated for editor documentation.

### Project structure

```
java/
├── pom.xml                     -- Maven project (compiles core/, utility/, feature/, entity/)
├── core/                       -- Main SDK client, config, entity base, error type
├── entity/                     -- Entity implementations
├── feature/                    -- Built-in features (Base, Test, Log, ...)
├── utility/                    -- Utility functions and the vendored struct library
└── test/                       -- JUnit test suites
```

The main client class (`BluefinDecryptxSDK`, package `voxgig.bluefindecryptxsdk.core`)
exposes the entity accessors. Reference entity or utility types directly only
when needed.

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
