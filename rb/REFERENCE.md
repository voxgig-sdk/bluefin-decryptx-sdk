# BluefinDecryptx Ruby SDK Reference

Complete API reference for the BluefinDecryptx Ruby SDK.


## BluefinDecryptxSDK

### Constructor

```ruby
require_relative 'BluefinDecryptx_sdk'

client = BluefinDecryptxSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = BluefinDecryptxSDK.test
```


### Instance Methods

#### `Decrypt(data = nil)`

Create a new `Decrypt` entity instance. Pass `nil` for no initial data.

#### `DecryptExt(data = nil)`

Create a new `DecryptExt` entity instance. Pass `nil` for no initial data.

#### `Validation(data = nil)`

Create a new `Validation` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## DecryptEntity

```ruby
decrypt = client.Decrypt
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `code` | `Integer` | No |  |
| `decrypted` | `Array` | No |  |
| `decryption_parameter` | `Hash` | Yes |  |
| `encrypted` | `Array` | Yes |  |
| `failed` | `Boolean` | No |  |
| `firmware` | `String` | No |  |
| `has_cc_data` | `Boolean` | Yes |  |
| `message` | `String` | No |  |
| `message_id` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `partner_id` | `String` | No |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | Yes |  |
| `serial` | `String` | Yes |  |
| `success` | `Boolean` | Yes |  |
| `value` | `String` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Decrypt.create({
  "decryption_parameter" => {}, # Hash
  "encrypted" => [], # Array
  "has_cc_data" => true, # Boolean
  "message_id" => "example_message_id", # String
  "name" => "example_name", # String
  "reference" => "example_reference", # String
  "serial" => "example_serial", # String
  "success" => true, # Boolean
})
```

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Decrypt.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `DecryptEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## DecryptExtEntity

```ruby
decrypt_ext = client.DecryptExt
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `completed` | `String` | No |  |
| `decrypted` | `Float` | No |  |
| `encrypted` | `Float` | Yes |  |
| `ip` | `String` | No |  |
| `message_id` | `String` | No |  |
| `partner_id` | `String` | Yes |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | No |  |
| `serial` | `String` | Yes |  |
| `success` | `Boolean` | No |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.DecryptExt.create({
  "encrypted" => 1, # Float
  "partner_id" => "example_partner_id", # String
  "serial" => "example_serial", # String
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `DecryptExtEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ValidationEntity

```ruby
validation = client.Validation
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `firmware` | `String` | No |  |
| `message_id` | `String` | Yes |  |
| `partner_id` | `String` | No |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | Yes |  |
| `serial` | `String` | Yes |  |
| `success` | `Boolean` | Yes |  |

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

#### `create(reqdata, ctrl = nil) -> result`

Create a new entity with the given data. Raises on error.

```ruby
result = client.Validation.create({
  "message_id" => "example_message_id", # String
  "reference" => "example_reference", # String
  "serial" => "example_serial", # String
  "success" => true, # Boolean
})
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ValidationEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = BluefinDecryptxSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

