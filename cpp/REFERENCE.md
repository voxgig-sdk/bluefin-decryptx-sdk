# BluefinDecryptx C++ SDK Reference

Complete API reference for the BluefinDecryptx C++ SDK.


## BluefinDecryptxSDK

### Constructor

```cpp
#include "core/sdk.hpp"

using namespace sdk;

auto client = std::make_shared<BluefinDecryptxSDK>(options);
```

Create a new SDK client instance. `options` is an `sdk::Value` map.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Value` | SDK configuration options (a map). |
| `options["apikey"]` | `std::string` | API key for authentication. |
| `options["base"]` | `std::string` | Base URL for API requests. |
| `options["prefix"]` | `std::string` | URL prefix appended after base. |
| `options["suffix"]` | `std::string` | URL suffix appended after path. |
| `options["headers"]` | `Value` | Custom headers for all requests. |
| `options["feature"]` | `Value` | Feature configuration. |
| `options["system"]` | `Value` | System overrides. |


### Static Methods

#### `BluefinDecryptxSDK::testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be
`Value::undef()`; a no-arg overload is also provided.

```cpp
auto client = BluefinDecryptxSDK::testSDK();
```


### Instance Methods

#### `decrypt(entopts = Value::undef()) -> std::shared_ptr<DecryptEntity>`

Create a new `DecryptEntity` instance bound to this client.

#### `decrypt_ext(entopts = Value::undef()) -> std::shared_ptr<DecryptExtEntity>`

Create a new `DecryptExtEntity` instance bound to this client.

#### `validation(entopts = Value::undef()) -> std::shared_ptr<ValidationEntity>`

Create a new `ValidationEntity` instance bound to this client.

#### `optionsMap() -> Value`

Return a deep copy of the current SDK options.

#### `getUtility() -> UtilityPtr`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Value`

Make a direct HTTP request to any API endpoint. Returns a result `Value` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `getp(result, "ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `std::string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `std::string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Value` | Path parameter values. |
| `fetchargs["query"]` | `Value` | Query string parameters. |
| `fetchargs["headers"]` | `Value` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Value` | Request body (maps are JSON-serialized). |

**Returns:** `Value` (result map)

#### `prepare(fetchargs) -> Value`

Prepare a fetch definition without sending. Returns the `fetchdef` and throws on error.


---

## DecryptEntity

```cpp
auto decrypt = client->decrypt();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `std::string` | No |  |
| `code` | `int64_t` | No |  |
| `decrypted` | `std::vector<Value>` | No |  |
| `decryption_parameter` | `std::map<std::string, Value>` | Yes |  |
| `encrypted` | `std::vector<Value>` | Yes |  |
| `failed` | `bool` | No |  |
| `firmware` | `std::string` | No |  |
| `has_cc_data` | `bool` | Yes |  |
| `message` | `std::string` | No |  |
| `message_id` | `std::string` | Yes |  |
| `name` | `std::string` | Yes |  |
| `partner_id` | `std::string` | No |  |
| `partner_key` | `std::string` | No |  |
| `reference` | `std::string` | Yes |  |
| `serial` | `std::string` | Yes |  |
| `success` | `bool` | Yes |  |
| `value` | `std::string` | No |  |

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

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->decrypt()->create(vmap({
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

#### `list(reqmatch, ctrl) -> Value`

List entities matching the given criteria. The match is optional — pass `Value::undef()` to list all records. Returns a Value list and throws on error.

```cpp
Value results = client->decrypt()->list(Value::undef(), Value::undef());
for (const auto& decrypt : *results.as_list()) {
  std::cout << Struct::jsonify(decrypt) << std::endl;
}
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `DecryptEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## DecryptExtEntity

```cpp
auto decrypt_ext = client->decrypt_ext();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `std::string` | No |  |
| `completed` | `std::string` | No |  |
| `decrypted` | `double` | No |  |
| `encrypted` | `double` | Yes |  |
| `ip` | `std::string` | No |  |
| `message_id` | `std::string` | No |  |
| `partner_id` | `std::string` | Yes |  |
| `partner_key` | `std::string` | No |  |
| `reference` | `std::string` | No |  |
| `serial` | `std::string` | Yes |  |
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

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->decrypt_ext()->create(vmap({
    {"encrypted", Value(1)},  // double
    {"partner_id", Value("example_partner_id")},  // std::string
    {"serial", Value("example_serial")},  // std::string
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `DecryptExtEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## ValidationEntity

```cpp
auto validation = client->validation();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `std::string` | No |  |
| `firmware` | `std::string` | No |  |
| `message_id` | `std::string` | Yes |  |
| `partner_id` | `std::string` | No |  |
| `partner_key` | `std::string` | No |  |
| `reference` | `std::string` | Yes |  |
| `serial` | `std::string` | Yes |  |
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

#### `create(reqdata, ctrl) -> Value`

Create a new entity with the given data. Returns the created entity data and throws on error.

```cpp
Value result = client->validation()->create(vmap({
    {"message_id", Value("example_message_id")},  // std::string
    {"reference", Value("example_reference")},  // std::string
    {"serial", Value("example_serial")},  // std::string
    {"success", Value(true)},  // bool
}), Value::undef());
```

### Common Methods

#### `data(arg = Value::undef()) -> Value`

Get the entity data (no argument) or set it (with a map argument).

#### `match(arg = Value::undef()) -> Value`

Get the entity match criteria (no argument) or set it (with a map argument).

#### `make() -> EntityPtr`

Create a new `ValidationEntity` instance with the same options.

#### `getName() -> std::string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```cpp
auto client = std::make_shared<BluefinDecryptxSDK>(vmap({
    {"feature", vmap({
        {"test", vmap({{"active", Value(true)}})},
    })},
}));
```

