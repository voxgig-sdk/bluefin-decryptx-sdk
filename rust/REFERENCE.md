# BluefinDecryptx Rust SDK Reference

Complete API reference for the BluefinDecryptx Rust SDK.


## BluefinDecryptxSDK

### Constructor

```rust
use bluefin_decryptx_sdk::{BluefinDecryptxSDK, Value};

let client = BluefinDecryptxSDK::new(options);
```

Create a new SDK client instance. `options` is a `Value` map
(`Value::Noval` for none).

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

#### `test_sdk(testopts: Value, sdkopts: Value) -> Rc<BluefinDecryptxSDK>`

Create a test client with mock features active. Both arguments may be
`Value::Noval`.

```rust
use bluefin_decryptx_sdk::{test_sdk, Value};

let client = test_sdk(Value::Noval, Value::Noval);
```


### Instance Methods

#### `decrypt(entopts: Value) -> Rc<DecryptEntity>`

Create a new `DecryptEntity` instance. Pass `Value::Noval` for no
initial options.

#### `decrypt_ext(entopts: Value) -> Rc<DecryptExtEntity>`

Create a new `DecryptExtEntity` instance. Pass `Value::Noval` for no
initial options.

#### `validation(entopts: Value) -> Rc<ValidationEntity>`

Create a new `ValidationEntity` instance. Pass `Value::Noval` for no
initial options.

#### `options_map() -> Value`

Return a deep copy of the current SDK options.

#### `get_utility() -> Rc<Utility>`

Return a copy of the SDK utility object.

#### `direct(fetchargs: Value) -> Result<Value, BluefinDecryptxError>`

Make a direct HTTP request to any API endpoint. `Ok` is a result `Value::Map`
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch resolves to `Ok` even on a non-2xx response — branch on
`getp(&result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `prepare(fetchargs: Value) -> Result<Value, BluefinDecryptxError>`

Prepare a fetch definition without sending. Returns the fetchdef on `Ok`.


---

## DecryptEntity

```rust
let decrypt = client.decrypt(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `code` | `i64` | No |  |
| `decrypted` | `Vec<Value>` | No |  |
| `decryption_parameter` | `std::collections::HashMap<String, Value>` | Yes |  |
| `encrypted` | `Vec<Value>` | Yes |  |
| `failed` | `bool` | No |  |
| `firmware` | `String` | No |  |
| `has_cc_data` | `bool` | Yes |  |
| `message` | `String` | No |  |
| `message_id` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `partner_id` | `String` | No |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | Yes |  |
| `serial` | `String` | Yes |  |
| `success` | `bool` | Yes |  |
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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, BluefinDecryptxError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.decrypt(Value::Noval).create(jo(vec![
    ("decryption_parameter", Value::empty_map()),  // std::collections::HashMap<String, Value>
    ("encrypted", Value::empty_list()),  // Vec<Value>
    ("has_cc_data", Value::Bool(true)),  // bool
    ("message_id", Value::str("example_message_id")),  // String
    ("name", Value::str("example_name")),  // String
    ("reference", Value::str("example_reference")),  // String
    ("serial", Value::str("example_serial")),  // String
    ("success", Value::Bool(true)),  // bool
]), Value::Noval).unwrap();
```

#### `list(reqmatch: Value, ctrl: Value) -> Result<Value, BluefinDecryptxError>`

List entities matching the given criteria. The match is optional — pass `Value::Noval` to list all records. `Ok` is a `Value::List`.

```rust
let results = client.decrypt(Value::Noval).list(Value::Noval, Value::Noval).unwrap();
if let Value::List(items) = &results {
    for decrypt in items.borrow().iter() {
        println!("{:?}", decrypt);
    }
}
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `DecryptEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## DecryptExtEntity

```rust
let decrypt_ext = client.decrypt_ext(Value::Noval);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `completed` | `String` | No |  |
| `decrypted` | `f64` | No |  |
| `encrypted` | `f64` | Yes |  |
| `ip` | `String` | No |  |
| `message_id` | `String` | No |  |
| `partner_id` | `String` | Yes |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | No |  |
| `serial` | `String` | Yes |  |
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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, BluefinDecryptxError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.decrypt_ext(Value::Noval).create(jo(vec![
    ("encrypted", Value::Num(1.0)),  // f64
    ("partner_id", Value::str("example_partner_id")),  // String
    ("serial", Value::str("example_serial")),  // String
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `DecryptExtEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## ValidationEntity

```rust
let validation = client.validation(Value::Noval);
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

#### `create(reqdata: Value, ctrl: Value) -> Result<Value, BluefinDecryptxError>`

Create a new entity with the given data. Returns the created entity data on `Ok` and `Err` on failure.

```rust
let result = client.validation(Value::Noval).create(jo(vec![
    ("message_id", Value::str("example_message_id")),  // String
    ("reference", Value::str("example_reference")),  // String
    ("serial", Value::str("example_serial")),  // String
    ("success", Value::Bool(true)),  // bool
]), Value::Noval).unwrap();
```

### Common Methods

#### `data(args: Option<&Value>) -> Value`

Get the entity data. Pass `Some(&map)` to set it.

#### `matchv(args: Option<&Value>) -> Value`

Get the entity match criteria. Pass `Some(&map)` to set it.

#### `make() -> Rc<dyn Entity>`

Create a new `ValidationEntity` instance with the same options.

#### `get_name() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```rust
let client = BluefinDecryptxSDK::new(jo(vec![
    ("feature", jo(vec![
        ("test", jo(vec![("active", Value::Bool(true))])),
    ])),
]));
```

