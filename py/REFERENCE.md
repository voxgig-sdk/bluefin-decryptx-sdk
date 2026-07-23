# BluefinDecryptx Python SDK Reference

Complete API reference for the BluefinDecryptx Python SDK.


## BluefinDecryptxSDK

### Constructor

```python
from bluefindecryptx_sdk import BluefinDecryptxSDK

client = BluefinDecryptxSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = BluefinDecryptxSDK.test()
```


### Instance Methods

#### `Decrypt(data=None)`

Create a new `DecryptEntity` instance. Pass `None` for no initial data.

#### `DecryptExt(data=None)`

Create a new `DecryptExtEntity` instance. Pass `None` for no initial data.

#### `Validation(data=None)`

Create a new `ValidationEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## DecryptEntity

```python
decrypt = client.Decrypt()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `str` | No |  |
| `code` | `int` | No |  |
| `decrypted` | `list` | No |  |
| `decryption_parameter` | `dict` | Yes |  |
| `encrypted` | `list` | Yes |  |
| `failed` | `bool` | No |  |
| `firmware` | `str` | No |  |
| `has_cc_data` | `bool` | Yes |  |
| `message` | `str` | No |  |
| `message_id` | `str` | Yes |  |
| `name` | `str` | Yes |  |
| `partner_id` | `str` | No |  |
| `partner_key` | `str` | No |  |
| `reference` | `str` | Yes |  |
| `serial` | `str` | Yes |  |
| `success` | `bool` | Yes |  |
| `value` | `str` | No |  |

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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Decrypt().create({
    "decryption_parameter": {},  # dict
    "encrypted": [],  # list
    "has_cc_data": True,  # bool
    "message_id": "example_message_id",  # str
    "name": "example_name",  # str
    "reference": "example_reference",  # str
    "serial": "example_serial",  # str
    "success": True,  # bool
})
```

#### `list(reqmatch=None, ctrl=None) -> list`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list and raises on error.

```python
results = client.Decrypt().list()
for decrypt in results:
    print(decrypt)
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `DecryptEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## DecryptExtEntity

```python
decrypt_ext = client.DecryptExt()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `str` | No |  |
| `completed` | `str` | No |  |
| `decrypted` | `float` | No |  |
| `encrypted` | `float` | Yes |  |
| `ip` | `str` | No |  |
| `message_id` | `str` | No |  |
| `partner_id` | `str` | Yes |  |
| `partner_key` | `str` | No |  |
| `reference` | `str` | No |  |
| `serial` | `str` | Yes |  |
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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.DecryptExt().create({
    "encrypted": 1,  # float
    "partner_id": "example_partner_id",  # str
    "serial": "example_serial",  # str
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `DecryptExtEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ValidationEntity

```python
validation = client.Validation()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `str` | No |  |
| `firmware` | `str` | No |  |
| `message_id` | `str` | Yes |  |
| `partner_id` | `str` | No |  |
| `partner_key` | `str` | No |  |
| `reference` | `str` | Yes |  |
| `serial` | `str` | Yes |  |
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

#### `create(reqdata, ctrl=None) -> dict`

Create a new entity with the given data. Returns the created entity data and raises on error.

```python
result = client.Validation().create({
    "message_id": "example_message_id",  # str
    "reference": "example_reference",  # str
    "serial": "example_serial",  # str
    "success": True,  # bool
})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ValidationEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = BluefinDecryptxSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

