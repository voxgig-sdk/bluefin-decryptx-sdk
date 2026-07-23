# BluefinDecryptx Elixir SDK Reference

Complete API reference for the BluefinDecryptx Elixir SDK.


## BluefinDecryptx

### Constructor

```elixir
sdk = BluefinDecryptx.new(options)
```

Create a new SDK client. `options` is a struct value node — build one from a
native map with `BluefinDecryptx.Helpers.deep/1`.

**Options:**

| Name | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL for API requests. |
| `prefix` | `String.t()` | URL prefix appended after base. |
| `suffix` | `String.t()` | URL suffix appended after path. |
| `headers` | `map()` | Custom headers for all requests. |
| `feature` | `map()` | Feature configuration. |
| `system` | `map()` | System overrides (e.g. custom fetch). |


### Constructors

#### `BluefinDecryptx.test(testopts \\ nil, sdkopts \\ nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```elixir
sdk = BluefinDecryptx.test()
```


### Functions

#### `BluefinDecryptx.decrypt(client, entopts \\ nil)`

Create a `BluefinDecryptx.Entity.Decrypt` handle.

#### `BluefinDecryptx.decrypt_ext(client, entopts \\ nil)`

Create a `BluefinDecryptx.Entity.DecryptExt` handle.

#### `BluefinDecryptx.validation(client, entopts \\ nil)`

Create a `BluefinDecryptx.Entity.Validation` handle.

#### `options_map(client) :: map()`

Return a deep copy of the current SDK options.

#### `get_utility(client) :: map()`

Return the SDK utility node.

#### `direct(client, fetchargs) :: map()`

Make a direct HTTP request to any API endpoint. Returns a result node with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never raises — branch on `Voxgig.Struct.getprop(result, "ok")`.

**fetchargs keys:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `String.t()` | URL path with optional `{param}` placeholders. |
| `method` | `String.t()` | HTTP method (default: `"GET"`). |
| `params` | `map()` | Path parameter values. |
| `query` | `map()` | Query string parameters. |
| `headers` | `map()` | Request headers (merged with defaults). |
| `body` | `any()` | Request body (maps are JSON-serialized). |

#### `prepare(client, fetchargs) :: map()`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## BluefinDecryptx.Entity.Decrypt

```elixir
decrypt = BluefinDecryptx.decrypt(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String.t()` | No |  |
| `code` | `integer()` | No |  |
| `decrypted` | `list()` | No |  |
| `decryption_parameter` | `map()` | Yes |  |
| `encrypted` | `list()` | Yes |  |
| `failed` | `boolean()` | No |  |
| `firmware` | `String.t()` | No |  |
| `has_cc_data` | `boolean()` | Yes |  |
| `message` | `String.t()` | No |  |
| `message_id` | `String.t()` | Yes |  |
| `name` | `String.t()` | Yes |  |
| `partner_id` | `String.t()` | No |  |
| `partner_key` | `String.t()` | No |  |
| `reference` | `String.t()` | Yes |  |
| `serial` | `String.t()` | Yes |  |
| `success` | `boolean()` | Yes |  |
| `value` | `String.t()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinDecryptx.Entity.Decrypt.create(decrypt, BluefinDecryptx.Helpers.deep(%{
  "decryption_parameter" => %{},  # map()
  "encrypted" => [],  # list()
  "has_cc_data" => true,  # boolean()
  "message_id" => "example_message_id",  # String.t()
  "name" => "example_name",  # String.t()
  "reference" => "example_reference",  # String.t()
  "serial" => "example_serial",  # String.t()
  "success" => true,  # boolean()
}))
```

#### `list(entity, reqmatch \\ nil, ctrl \\ nil) :: list()`

List entities matching the given criteria. The match is optional — call `list(entity)` to list all records. Returns a list and raises on error.

```elixir
records = BluefinDecryptx.Entity.Decrypt.list(decrypt)
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinDecryptx.Entity.Decrypt` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## BluefinDecryptx.Entity.DecryptExt

```elixir
decrypt_ext = BluefinDecryptx.decrypt_ext(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String.t()` | No |  |
| `completed` | `String.t()` | No |  |
| `decrypted` | `float()` | No |  |
| `encrypted` | `float()` | Yes |  |
| `ip` | `String.t()` | No |  |
| `message_id` | `String.t()` | No |  |
| `partner_id` | `String.t()` | Yes |  |
| `partner_key` | `String.t()` | No |  |
| `reference` | `String.t()` | No |  |
| `serial` | `String.t()` | Yes |  |
| `success` | `boolean()` | No |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinDecryptx.Entity.DecryptExt.create(decrypt_ext, BluefinDecryptx.Helpers.deep(%{
  "encrypted" => 1,  # float()
  "partner_id" => "example_partner_id",  # String.t()
  "serial" => "example_serial",  # String.t()
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinDecryptx.Entity.DecryptExt` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## BluefinDecryptx.Entity.Validation

```elixir
validation = BluefinDecryptx.validation(sdk)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String.t()` | No |  |
| `firmware` | `String.t()` | No |  |
| `message_id` | `String.t()` | Yes |  |
| `partner_id` | `String.t()` | No |  |
| `partner_key` | `String.t()` | No |  |
| `reference` | `String.t()` | Yes |  |
| `serial` | `String.t()` | Yes |  |
| `success` | `boolean()` | Yes |  |

### Operations

#### `create(entity, reqdata, ctrl \\ nil) :: map()`

Create a new entity with the given data. Returns the created entity data and raises on error.

```elixir
record = BluefinDecryptx.Entity.Validation.create(validation, BluefinDecryptx.Helpers.deep(%{
  "message_id" => "example_message_id",  # String.t()
  "reference" => "example_reference",  # String.t()
  "serial" => "example_serial",  # String.t()
  "success" => true,  # boolean()
}))
```

### Common Functions

#### `data_get(entity) :: map()`

Get the entity data.

#### `data_set(entity, data)`

Set the entity data.

#### `match_get(entity) :: map()`

Get the entity match criteria.

#### `match_set(entity, match)`

Set the entity match criteria.

#### `make(entity) :: entity`

Create a new `BluefinDecryptx.Entity.Validation` handle with the same options.

#### `get_name(entity) :: String.t()`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```elixir
sdk = BluefinDecryptx.new(BluefinDecryptx.Helpers.deep(%{
  "feature" => %{
    "test" => %{"active" => true},
  }
}))
```

