# BluefinDecryptx Zig SDK Reference

Complete API reference for the BluefinDecryptx Zig SDK.


## BluefinDecryptxSDK

### Constructor

```zig
const sdk = @import("sdk");
const h = sdk.h;

const client = sdk.BluefinDecryptxSDK.new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`h.vnull()` for none).

**Parameters:**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Static Functions

#### `test_sdk(testopts: Value, sdkopts: Value) *BluefinDecryptxSDK`

Create a test client with mock features active. Both arguments may be
`h.vnull()`.

```zig
const client = sdk.test_sdk(h.vnull(), h.vnull());
```


### Instance Methods

#### `decrypt(entopts: Value) *DecryptEntity`

Create a new `DecryptEntity` instance. Pass `h.vnull()` for no
initial options.

#### `decrypt_ext(entopts: Value) *DecryptExtEntity`

Create a new `DecryptExtEntity` instance. Pass `h.vnull()` for no
initial options.

#### `validation(entopts: Value) *ValidationEntity`

Create a new `ValidationEntity` instance. Pass `h.vnull()` for no
initial options.

#### `options_map() Value`

Return a deep copy of the current SDK options.

#### `get_utility() *Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value`
map with `ok`, `status`, `headers`, and `data` (or `err` on failure).
This escape hatch returns a map even on a non-2xx response — branch on
`h.get_bool(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) E!Value`

Prepare a fetch definition without sending. Returns the fetchdef (use
`catch`/`try` to handle the error union).


---

## DecryptEntity

```zig
const decrypt = client.decrypt(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `[]const u8` | No |  |
| `code` | `i64` | No |  |
| `decrypted` | `Value (array)` | No |  |
| `decryption_parameter` | `Value (object)` | Yes |  |
| `encrypted` | `Value (array)` | Yes |  |
| `failed` | `bool` | No |  |
| `firmware` | `[]const u8` | No |  |
| `has_cc_data` | `bool` | Yes |  |
| `message` | `[]const u8` | No |  |
| `message_id` | `[]const u8` | Yes |  |
| `name` | `[]const u8` | Yes |  |
| `partner_id` | `[]const u8` | No |  |
| `partner_key` | `[]const u8` | No |  |
| `reference` | `[]const u8` | Yes |  |
| `serial` | `[]const u8` | Yes |  |
| `success` | `bool` | Yes |  |
| `value` | `[]const u8` | No |  |

### Field Usage by Operation

| Field | list | create |
| --- | --- | --- |
| `client_id` | - | - |
| `code` | - | - |
| `decrypted` | - | - |
| `decryption_parameter` | - | - |
| `encrypted` | - | - |
| `failed` | - | - |
| `firmware` | - | - |
| `has_cc_data` | - | - |
| `message` | - | - |
| `message_id` | - | - |
| `name` | - | - |
| `partner_id` | - | - |
| `partner_key` | - | - |
| `reference` | - | Yes |
| `serial` | - | - |
| `success` | - | - |
| `value` | - | - |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

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
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

#### `list(reqmatch: Value, ctrl: Value) OpResult`

List entities matching the given criteria. The match is optional — pass `h.vnull()` to list all records. `.ok` is a `Value` array.

```zig
switch (client.decrypt(h.vnull()).list(h.vnull(), h.vnull())) {
    .ok => |results| std.debug.print("{s}\n", .{h.stringify(results)}),
    .err => |e| std.debug.print("list failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## DecryptExtEntity

```zig
const decrypt_ext = client.decrypt_ext(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `[]const u8` | No |  |
| `completed` | `[]const u8` | No |  |
| `decrypted` | `f64` | No |  |
| `encrypted` | `f64` | Yes |  |
| `ip` | `[]const u8` | No |  |
| `message_id` | `[]const u8` | No |  |
| `partner_id` | `[]const u8` | Yes |  |
| `partner_key` | `[]const u8` | No |  |
| `reference` | `[]const u8` | No |  |
| `serial` | `[]const u8` | Yes |  |
| `success` | `bool` | No |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `client_id` | - |
| `completed` | - |
| `decrypted` | Yes |
| `encrypted` | - |
| `ip` | - |
| `message_id` | - |
| `partner_id` | - |
| `partner_key` | - |
| `reference` | Yes |
| `serial` | - |
| `success` | Yes |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.decrypt_ext(h.vnull()).create(h.jo(&.{
    .{ "encrypted", h.vnum(1) }, // f64
    .{ "partner_id", h.vstr("example_partner_id") }, // []const u8
    .{ "serial", h.vstr("example_serial") }, // []const u8
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## ValidationEntity

```zig
const validation = client.validation(h.vnull());
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `[]const u8` | No |  |
| `firmware` | `[]const u8` | No |  |
| `message_id` | `[]const u8` | Yes |  |
| `partner_id` | `[]const u8` | No |  |
| `partner_key` | `[]const u8` | No |  |
| `reference` | `[]const u8` | Yes |  |
| `serial` | `[]const u8` | Yes |  |
| `success` | `bool` | Yes |  |

### Field Usage by Operation

| Field | create |
| --- | --- |
| `client_id` | - |
| `firmware` | - |
| `message_id` | - |
| `partner_id` | - |
| `partner_key` | - |
| `reference` | Yes |
| `serial` | - |
| `success` | - |

### Operations

#### `create(reqdata: Value, ctrl: Value) OpResult`

Create a new entity with the given data. `.ok` carries the created entity data.

```zig
switch (client.validation(h.vnull()).create(h.jo(&.{
    .{ "message_id", h.vstr("example_message_id") }, // []const u8
    .{ "reference", h.vstr("example_reference") }, // []const u8
    .{ "serial", h.vstr("example_serial") }, // []const u8
    .{ "success", h.vbool(true) }, // bool
}), h.vnull())) {
    .ok => |result| std.debug.print("{s}\n", .{h.stringify(result)}),
    .err => |e| std.debug.print("create failed: {s}\n", .{e.msg}),
}
```

### Common Methods

#### `data(args: ?Value) Value`

Get the entity data. Pass a map to set it.

#### `matchv(args: ?Value) Value`

Get the entity match criteria. Pass a map to set it.

#### `stream(action: []const u8, args: Value, callopts: Value) []Value`

Run an operation through the pipeline and materialise its result items.

#### `get_name() []const u8`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```zig
const client = sdk.BluefinDecryptxSDK.new(h.jo(&.{
    .{ "feature", h.jo(&.{
        .{ "test", h.jo(&.{.{ "active", h.vbool(true) }}) },
    }) },
}));
```

