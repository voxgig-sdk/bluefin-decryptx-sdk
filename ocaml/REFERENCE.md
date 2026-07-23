# BluefinDecryptx OCaml SDK Reference

Complete API reference for the BluefinDecryptx OCaml SDK.


## Sdk_client

### Constructor

```ocaml
open Voxgig_struct
open Sdk_helpers

let client = Sdk_client.make options
```

Create a new SDK client instance from a `value` options map. Use
`Sdk_client.make0 ()` for defaults.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `value` | SDK configuration options (a Map). |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Static constructors

#### `Sdk_client.test testopts sdkopts`

Create a test client with mock features active. Both arguments may be `Noval`
(`Sdk_client.test ()` uses defaults, `Sdk_client.test_with` takes explicit
options).

```ocaml
let client = Sdk_client.test ()
```


### Instance functions

#### `Sdk_client.decrypt client entopts : entity_obj`

Create a `Decrypt` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.decrypt_ext client entopts : entity_obj`

Create a `DecryptExt` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.validation client entopts : entity_obj`

Create a `Validation` entity accessor. Pass `Noval` for no initial options.

#### `Sdk_client.direct client fetchargs : value`

Make a direct HTTP request to any API endpoint. Returns a result `value` map
with `ok`, `status`, `headers`, and `data` (or `err` on failure). This
escape hatch never raises — branch on `getp result "ok"`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `value` | Request body (Maps are JSON-serialized). |

**Returns:** a result `value` map.

#### `Sdk_client.prepare client fetchargs : value`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises
on error.


---

## Decrypt

```ocaml
let decrypt = Sdk_client.decrypt client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `code` | `int` | No |  |
| `decrypted` | `value list` | No |  |
| `decryption_parameter` | `value map` | Yes |  |
| `encrypted` | `value list` | Yes |  |
| `failed` | `bool` | No |  |
| `firmware` | `string` | No |  |
| `has_cc_data` | `bool` | Yes |  |
| `message` | `string` | No |  |
| `message_id` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `partner_id` | `string` | No |  |
| `partner_key` | `string` | No |  |
| `reference` | `string` | Yes |  |
| `serial` | `string` | Yes |  |
| `success` | `bool` | Yes |  |
| `value` | `string` | No |  |

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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.decrypt client Noval).e_create (jo [
    ("decryption_parameter", (empty_map ()));  (* value map *)
    ("encrypted", (empty_list ()));  (* value list *)
    ("has_cc_data", (Bool true));  (* bool *)
    ("message_id", (Str "example_message_id"));  (* string *)
    ("name", (Str "example_name"));  (* string *)
    ("reference", (Str "example_reference"));  (* string *)
    ("serial", (Str "example_serial"));  (* string *)
    ("success", (Bool true));  (* bool *)
]) Noval
```

#### `e_list reqmatch ctrl : value`

List entities matching the given criteria. The match is optional — pass `(empty_map ())` to list all records. Returns a List and raises on error.

```ocaml
let results = (Sdk_client.decrypt client Noval).e_list (empty_map ()) Noval in
(match results with
 | List items -> List.iter (fun r -> print_endline (stringify r)) !items
 | _ -> ())
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Decrypt` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## DecryptExt

```ocaml
let decrypt_ext = Sdk_client.decrypt_ext client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `completed` | `string` | No |  |
| `decrypted` | `float` | No |  |
| `encrypted` | `float` | Yes |  |
| `ip` | `string` | No |  |
| `message_id` | `string` | No |  |
| `partner_id` | `string` | Yes |  |
| `partner_key` | `string` | No |  |
| `reference` | `string` | No |  |
| `serial` | `string` | Yes |  |
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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.decrypt_ext client Noval).e_create (jo [
    ("encrypted", (Num 1.));  (* float *)
    ("partner_id", (Str "example_partner_id"));  (* string *)
    ("serial", (Str "example_serial"));  (* string *)
]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `DecryptExt` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Validation

```ocaml
let validation = Sdk_client.validation client Noval
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `firmware` | `string` | No |  |
| `message_id` | `string` | Yes |  |
| `partner_id` | `string` | No |  |
| `partner_key` | `string` | No |  |
| `reference` | `string` | Yes |  |
| `serial` | `string` | Yes |  |
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

#### `e_create reqdata ctrl : value`

Create a new entity with the given data. Returns the created entity data and raises on error.

```ocaml
let result = (Sdk_client.validation client Noval).e_create (jo [
    ("message_id", (Str "example_message_id"));  (* string *)
    ("reference", (Str "example_reference"));  (* string *)
    ("serial", (Str "example_serial"));  (* string *)
    ("success", (Bool true));  (* bool *)
]) Noval
```

### Common Fields

#### `e_data_get : unit -> value`

Get the entity data.

#### `e_data_set : value -> unit`

Set the entity data.

#### `e_match_get : unit -> value`

Get the entity match criteria.

#### `e_match_set : value -> unit`

Set the entity match criteria.

#### `e_make : unit -> entity_obj`

Create a new `Validation` entity accessor with the same options.

#### `e_name : string`

The entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ocaml
let client = Sdk_client.make (jo [
    ("feature", jo [
        ("test", jo [("active", Bool true)]);
    ]);
])
```

