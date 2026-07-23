# BluefinDecryptx C SDK Reference

Complete API reference for the BluefinDecryptx C SDK.


## BluefinDecryptxSDK

### Constructor

```c
#include "core/api.h"

BluefinDecryptxSDK* client = bluefin_decryptx_sdk_new(options);
```

Create a new SDK client instance. `options` is a `voxgig_value*` map
(`NULL` for none).

**Parameters (`options` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides. |


### Test Constructor

#### `BluefinDecryptxSDK* test_sdk(voxgig_value* testopts, voxgig_value* sdkopts)`

Create a test client with mock features active. Both arguments may be
`NULL`.

```c
BluefinDecryptxSDK* client = test_sdk(NULL, NULL);
```


### Entity Accessors

#### `Entity* bluefin_decryptx_decrypt(BluefinDecryptxSDK* client, voxgig_value* entopts)`

Create a new `Decrypt` entity instance. Pass `NULL` for no initial
options.

#### `Entity* bluefin_decryptx_decrypt_ext(BluefinDecryptxSDK* client, voxgig_value* entopts)`

Create a new `DecryptExt` entity instance. Pass `NULL` for no initial
options.

#### `Entity* bluefin_decryptx_validation(BluefinDecryptxSDK* client, voxgig_value* entopts)`

Create a new `Validation` entity instance. Pass `NULL` for no initial
options.

#### `voxgig_value* sdk_direct(BluefinDecryptxSDK* client, voxgig_value* fetchargs, PNError** err)`

Make a direct HTTP request to any API endpoint. Returns a result map with
`ok`, `status`, `headers`, and `data` (or `err` on failure). This escape
hatch never sets `*err` for a non-2xx response — branch on
`getp(result, "ok")`.

**Parameters (`fetchargs` map keys):**

| Key | Value type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

#### `voxgig_value* sdk_prepare(BluefinDecryptxSDK* client, voxgig_value* fetchargs, PNError** err)`

Prepare a fetch definition without sending. Returns the fetchdef and sets
`*err` on failure.


---

## Decrypt

```c
Entity* decrypt = bluefin_decryptx_decrypt(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `char*` | No |  |
| `code` | `int64_t` | No |  |
| `decrypted` | `voxgig_value* (list)` | No |  |
| `decryption_parameter` | `voxgig_value* (map)` | Yes |  |
| `encrypted` | `voxgig_value* (list)` | Yes |  |
| `failed` | `bool` | No |  |
| `firmware` | `char*` | No |  |
| `has_cc_data` | `bool` | Yes |  |
| `message` | `char*` | No |  |
| `message_id` | `char*` | Yes |  |
| `name` | `char*` | Yes |  |
| `partner_id` | `char*` | No |  |
| `partner_key` | `char*` | No |  |
| `reference` | `char*` | Yes |  |
| `serial` | `char*` | Yes |  |
| `success` | `bool` | Yes |  |
| `value` | `char*` | No |  |

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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* decrypt = bluefin_decryptx_decrypt(client, NULL);
voxgig_value* result = decrypt->vt->create(decrypt, cmap(8,
    "decryption_parameter", v_map(),  // voxgig_value* (map)
    "encrypted", v_list(),  // voxgig_value* (list)
    "has_cc_data", v_bool(true),  // bool
    "message_id", v_str("example_message_id"),  // char*
    "name", v_str("example_name"),  // char*
    "reference", v_str("example_reference"),  // char*
    "serial", v_str("example_serial"),  // char*
    "success", v_bool(true))  // bool
, NULL, &err);
```

#### `vt->list(Entity* e, voxgig_value* reqmatch, voxgig_value* ctrl, PNError** err)`

List entities matching the given criteria. The match is optional — pass `NULL` to list all records. Returns a List.

```c
Entity* decrypt = bluefin_decryptx_decrypt(client, NULL);
voxgig_value* results = decrypt->vt->list(decrypt, NULL, NULL, &err);
for (size_t i = 0; i < (size_t)voxgig_size(results); i++) {
    printf("%s\n", voxgig_to_json(voxgig_getelem(results, v_int(i), NULL)));
}
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Decrypt` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## DecryptExt

```c
Entity* decrypt_ext = bluefin_decryptx_decrypt_ext(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `char*` | No |  |
| `completed` | `char*` | No |  |
| `decrypted` | `double` | No |  |
| `encrypted` | `double` | Yes |  |
| `ip` | `char*` | No |  |
| `message_id` | `char*` | No |  |
| `partner_id` | `char*` | Yes |  |
| `partner_key` | `char*` | No |  |
| `reference` | `char*` | No |  |
| `serial` | `char*` | Yes |  |
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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* decrypt_ext = bluefin_decryptx_decrypt_ext(client, NULL);
voxgig_value* result = decrypt_ext->vt->create(decrypt_ext, cmap(3,
    "encrypted", v_num(1),  // double
    "partner_id", v_str("example_partner_id"),  // char*
    "serial", v_str("example_serial"))  // char*
, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `DecryptExt` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Validation

```c
Entity* validation = bluefin_decryptx_validation(client, NULL);
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `char*` | No |  |
| `firmware` | `char*` | No |  |
| `message_id` | `char*` | Yes |  |
| `partner_id` | `char*` | No |  |
| `partner_key` | `char*` | No |  |
| `reference` | `char*` | Yes |  |
| `serial` | `char*` | Yes |  |
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

#### `vt->create(Entity* e, voxgig_value* reqdata, voxgig_value* ctrl, PNError** err)`

Create a new entity with the given data. Returns the created entity data and sets `*err` on failure.

```c
Entity* validation = bluefin_decryptx_validation(client, NULL);
voxgig_value* result = validation->vt->create(validation, cmap(4,
    "message_id", v_str("example_message_id"),  // char*
    "reference", v_str("example_reference"),  // char*
    "serial", v_str("example_serial"),  // char*
    "success", v_bool(true))  // bool
, NULL, &err);
```

### Common Methods

#### `voxgig_value* vt->data(Entity* e, voxgig_value* args)`

Get the entity data. Pass a map to set it.

#### `voxgig_value* vt->matchv(Entity* e, voxgig_value* args)`

Get the entity match criteria. Pass a map to set it.

#### `Entity* vt->make(Entity* e)`

Create a new `Validation` entity instance with the same options.

#### `const char* vt->get_name(Entity* e)`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```c
BluefinDecryptxSDK* client = bluefin_decryptx_sdk_new(cmap(1,
    "feature", cmap(1,
        "test", cmap(1, "active", v_bool(true)))
));
```

