# BluefinDecryptx Zig SDK



The Zig SDK for the BluefinDecryptx API — an entity-oriented client following idiomatic Zig conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.decrypt(h.vnull())` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
Zig has no central package registry, so this package is distributed as a
git tag (`zig/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases)). Add it to
your `build.zig.zon` dependencies, or build from a source checkout:

```bash
cd zig && zig build
```

To depend on it from another project, add the tagged archive to
`build.zig.zon`:

```zig
.dependencies = .{
    .sdk = .{
        .url = "<repo-url>/archive/refs/tags/zig/vX.Y.Z.tar.gz",
        // .hash = "...", // filled in by `zig fetch`
    },
},
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```zig
const std = @import("std");
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.BluefinDecryptxSDK.new(h.jo(&.{
    .{ "apikey", h.vstr(std.posix.getenv("BLUEFIN_DECRYPTX_APIKEY") orelse "") },
}));
```

### 2. List decrypt records

`list()` returns an `OpResult` whose `.ok` is a `Value` array —
`switch` on it.

```zig
switch (client.decrypt(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |decrypts| std.debug.print("{s}\n", .{h.stringify(decrypts)}),
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### 4. Create, update, and remove

```zig
// Create — .ok carries the created record
switch (client.decrypt(h.vnull()).create(h.jo(&.{.{ "decryption_parameter", h.omap() }, .{ "encrypted", h.olist() }, .{ "has_cc_data", h.vbool(true) }, .{ "message_id", h.vstr("example_message_id") }, .{ "name", h.vstr("example_name") }, .{ "reference", h.vstr("example_reference") }, .{ "serial", h.vstr("example_serial") }, .{ "success", h.vbool(true) }}), h.vnull())) {
    .ok => |created| std.debug.print("{s}\n", .{h.stringify(created)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}

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

```zig
const result = client.direct(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("GET") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
}));

if (h.get_bool(result, "ok") orelse false) {
    std.debug.print("{d}\n", .{h.to_int(h.getp(result, "status"))}); // 200
    std.debug.print("{s}\n", .{h.stringify(h.getp(result, "data"))}); // response body
} else {
    // A non-2xx response carries status + data (the error body); a
    // transport-level failure carries err instead. Only one is present.
    std.debug.print("{s}\n", .{h.get_str(result, "err") orelse ""});
}
```

### Prepare a request without sending it

```zig
// prepare() returns the fetch definition (an error union — use `catch`/`try`).
const fetchdef = client.prepare(h.jo(&.{
    .{ "path", h.vstr("/api/resource/{id}") },
    .{ "method", h.vstr("DELETE") },
    .{ "params", h.jo(&.{.{ "id", h.vstr("example") }}) },
})) catch unreachable;

std.debug.print("{s}\n", .{h.get_str(fetchdef, "url") orelse ""});
std.debug.print("{s}\n", .{h.get_str(fetchdef, "method") orelse ""});
std.debug.print("{s}\n", .{h.stringify(h.getp(fetchdef, "headers"))});
```

### Use test mode

Create a mock client for unit testing — no server required:

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());

// Entity ops return an OpResult — .ok carries the record, .err the error.
switch (client.decrypt(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |decrypt| std.debug.print("{s}\n", .{h.stringify(decrypt)}), // the mock record
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Point at a different server

Override the base URL to reach a local or staging server:

```zig
const client = sdk.BluefinDecryptxSDK.new(h.jo(&.{
    .{ "base", h.vstr("http://localhost:8080") },
}));
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run:

```bash
cd zig && zig build test
```


## Reference

### BluefinDecryptxSDK

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.BluefinDecryptxSDK.new(options);
```

Creates a new SDK client. `options` is a `Value` map (`h.vnull()` for
none) carrying any of the following keys:

| Option | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `map` | Feature activation flags. |
| `system` | `map` | System overrides (e.g. a custom fetcher). |

### test_sdk

```zig
const client = sdk.test_sdk(testopts, sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be
`h.vnull()`.

### BluefinDecryptxSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() Value` | Deep copy of the current SDK options. |
| `get_utility` | `() *Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs: Value) E!Value` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs: Value) Value` | Build and send an HTTP request. Returns a result map (branch on `ok`). |
| `decrypt` | `(entopts: Value) *DecryptEntity` | Create a Decrypt entity instance. |
| `decrypt_ext` | `(entopts: Value) *DecryptExtEntity` | Create a DecryptExt entity instance. |
| `validation` | `(entopts: Value) *ValidationEntity` | Create a Validation entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `(reqmatch: Value, ctrl: Value) OpResult` | List entities matching the criteria (`.ok` is a `Value` array). |
| `create` | `(reqdata: Value, ctrl: Value) OpResult` | Create a new entity. |
| `stream` | `(action: []const u8, args: Value, callopts: Value) []Value` | Run an op through the pipeline and materialise its result items. |
| `data` | `(args: ?Value) Value` | Get entity data (pass a map to set). |
| `matchv` | `(args: ?Value) Value` | Get entity match criteria (pass a map to set). |
| `get_name` | `() []const u8` | Return the entity name. |

### Result shape

Entity operations return an `OpResult` union — `switch` on it: `.ok`
carries the bare result data (a `Value` object for single-entity ops, a
`Value` array for `list`), `.err` carries the branded error pointer.

The `direct()` escape hatch returns a result `Value` map directly (no
error union) — even on a non-2xx response — that you branch on via
`h.get_bool(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `map` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error message.

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

Create an instance: `const decrypt = client.decrypt(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |
| `list(reqmatch, ctrl)` | List entities, optionally matching the given criteria. |

Each operation returns an `OpResult` — `switch` on it: `.ok => |data|`
carries the result `Value`, `.err => |e|` carries the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `[]const u8` |  |
| `code` | `i64` |  |
| `decrypted` | `Value (array)` |  |
| `decryption_parameter` | `Value (object)` |  |
| `encrypted` | `Value (array)` |  |
| `failed` | `bool` |  |
| `firmware` | `[]const u8` |  |
| `has_cc_data` | `bool` |  |
| `message` | `[]const u8` |  |
| `message_id` | `[]const u8` |  |
| `name` | `[]const u8` |  |
| `partner_id` | `[]const u8` |  |
| `partner_key` | `[]const u8` |  |
| `reference` | `[]const u8` |  |
| `serial` | `[]const u8` |  |
| `success` | `bool` |  |
| `value` | `[]const u8` |  |

#### Example: List

```zig
switch (client.decrypt(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |decrypts| std.debug.print("{s}\n", .{h.stringify(decrypts)}),
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

#### Example: Create

```zig
switch (client.decrypt(h.vnull()).create(h.jo(&.{
    .{ "decryption_parameter", h.omap() }, // Value (object)
    .{ "encrypted", h.olist() }, // Value (array)
    .{ "has_cc_data", h.vbool(true) }, // bool
    .{ "message_id", h.vstr("example_message_id") }, // []const u8
    .{ "name", h.vstr("example_name") }, // []const u8
    .{ "reference", h.vstr("example_reference") }, // []const u8
    .{ "serial", h.vstr("example_serial") }, // []const u8
    .{ "success", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |decrypt| std.debug.print("{s}\n", .{h.stringify(decrypt)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### DecryptExt

Create an instance: `const decrypt_ext = client.decrypt_ext(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns an `OpResult` — `switch` on it: `.ok => |data|`
carries the result `Value`, `.err => |e|` carries the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `[]const u8` |  |
| `completed` | `[]const u8` |  |
| `decrypted` | `f64` |  |
| `encrypted` | `f64` |  |
| `ip` | `[]const u8` |  |
| `message_id` | `[]const u8` |  |
| `partner_id` | `[]const u8` |  |
| `partner_key` | `[]const u8` |  |
| `reference` | `[]const u8` |  |
| `serial` | `[]const u8` |  |
| `success` | `bool` |  |

#### Example: Create

```zig
switch (client.decrypt_ext(h.vnull()).create(h.jo(&.{
    .{ "encrypted", h.vnum(1) }, // f64
    .{ "partner_id", h.vstr("example_partner_id") }, // []const u8
    .{ "serial", h.vstr("example_serial") }, // []const u8
}), h.vnull())) {
    .ok => |decrypt_ext| std.debug.print("{s}\n", .{h.stringify(decrypt_ext)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```


### Validation

Create an instance: `const validation = client.validation(h.vnull());`

#### Operations

| Method | Description |
| --- | --- |
| `create(reqdata, ctrl)` | Create a new entity with the given data. |

Each operation returns an `OpResult` — `switch` on it: `.ok => |data|`
carries the result `Value`, `.err => |e|` carries the branded error.

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `[]const u8` |  |
| `firmware` | `[]const u8` |  |
| `message_id` | `[]const u8` |  |
| `partner_id` | `[]const u8` |  |
| `partner_key` | `[]const u8` |  |
| `reference` | `[]const u8` |  |
| `serial` | `[]const u8` |  |
| `success` | `bool` |  |

#### Example: Create

```zig
switch (client.validation(h.vnull()).create(h.jo(&.{
    .{ "message_id", h.vstr("example_message_id") }, // []const u8
    .{ "reference", h.vstr("example_reference") }, // []const u8
    .{ "serial", h.vstr("example_serial") }, // []const u8
    .{ "success", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |validation| std.debug.print("{s}\n", .{h.stringify(validation)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
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

The Zig SDK uses a single dynamic `Value` type throughout rather than a
typed struct per entity. `Value` is the vendored voxgig struct port's
`JsonValue` (a JSON-shaped tagged union: `.string`, `.integer`,
`.float`, `.bool`, `.array`, `.object`, `.null`). This mirrors the
dynamic nature of the API and keeps the SDK flexible — no code generation is
needed when the API schema changes.

Build request maps with the `h.jo` / `h.ja` helpers and read fields back
with `h.getp` (or the typed `h.get_str` / `h.get_bool` / `h.to_int`
accessors); use `h.to_map` to safely coerce a value to a map.

### Module structure

```
zig/
├── root.zig                     -- Module root (re-exports the public surface)
├── build.zig                    -- Build + test wiring
├── core/                        -- Pipeline types, config, client (sdk.zig)
├── entity/                      -- Per-entity clients (one file each)
├── feature/                     -- Built-in features (base, test, log)
├── utility/                     -- Utilities + the vendored voxgig struct port
└── test/                        -- Test suites
```

The public API is re-exported from `root.zig`, so `@import("sdk")` reaches
the SDK client, `Value`, and the `h` (helpers) namespace directly. Import
entity or utility modules only when needed.

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
