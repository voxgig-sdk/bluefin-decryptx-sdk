# BluefinDecryptx Clojure SDK Reference

Complete API reference for the BluefinDecryptx Clojure SDK.


## Client

### make-sdk

```clojure
(require '[sdk.api :as api]
         '[voxgig.struct :as vs])

(def client (api/make-sdk options))
```

Create a new SDK client instance. `options` is a `voxgig.struct` map.

**Options:**

| Key | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL for API requests. |
| `prefix` | `string` | URL prefix appended after base. |
| `suffix` | `string` | URL suffix appended after path. |
| `headers` | `map` | Custom headers for all requests. |
| `feature` | `map` | Feature configuration. |
| `system` | `map` | System overrides (e.g. custom fetch). |


### Test client

#### `(api/test-sdk testopts sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```clojure
(def client (api/test-sdk nil nil))
```


### Client functions

#### `(api/decrypt client data)`

Create a new `Decrypt` entity instance. Pass `nil` for no initial data.

#### `(api/decrypt_ext client data)`

Create a new `DecryptExt` entity instance. Pass `nil` for no initial data.

#### `(api/validation client data)`

Create a new `Validation` entity instance. Pass `nil` for no initial data.

#### `(api/options-map client) -> map`

Return a deep copy of the current SDK options.

#### `(api/get-utility client) -> utility`

Return a copy of the SDK utility object.

#### `(api/direct client fetchargs) -> map`

Make a direct HTTP request to any API endpoint. Returns a result `map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `(vs/getprop result "ok")`.

**Fetch args:**

| Key | Type | Description |
| --- | --- | --- |
| `path` | `string` | URL path with optional `{param}` placeholders. |
| `method` | `string` | HTTP method (default: `"GET"`). |
| `params` | `map` | Path parameter values. |
| `query` | `map` | Query string parameters. |
| `headers` | `map` | Request headers (merged with defaults). |
| `body` | `any` | Request body (maps are JSON-serialized). |

**Returns:** a result `map`.

#### `(api/prepare client fetchargs) -> map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Decrypt

```clojure
(require '[sdk.entity.decrypt :as e-decrypt])

(def decrypt (api/decrypt client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `code` | `long` | No |  |
| `decrypted` | `vector` | No |  |
| `decryption_parameter` | `map` | Yes |  |
| `encrypted` | `vector` | Yes |  |
| `failed` | `boolean` | No |  |
| `firmware` | `string` | No |  |
| `has_cc_data` | `boolean` | Yes |  |
| `message` | `string` | No |  |
| `message_id` | `string` | Yes |  |
| `name` | `string` | Yes |  |
| `partner_id` | `string` | No |  |
| `partner_key` | `string` | No |  |
| `reference` | `string` | Yes |  |
| `serial` | `string` | Yes |  |
| `success` | `boolean` | Yes |  |
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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-decrypt/create (api/decrypt client nil)
    (vs/jm
      "decryption_parameter" (vs/jm)  ;; map
      "encrypted" (vs/jt)  ;; vector
      "has_cc_data" true  ;; boolean
      "message_id" "example_message_id"  ;; string
      "name" "example_name"  ;; string
      "reference" "example_reference"  ;; string
      "serial" "example_serial"  ;; string
      "success" true  ;; boolean
      )
    nil))
```

#### `(list ent reqmatch ctrl) -> vector`

List entities matching the given criteria. The match is optional — call with `nil` to list all records. Returns a vector and raises on error.

```clojure
(doseq [decrypt (e-decrypt/list (api/decrypt client nil) nil nil)]
  (println decrypt))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Decrypt` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## DecryptExt

```clojure
(require '[sdk.entity.decrypt_ext :as e-decrypt_ext])

(def decrypt_ext (api/decrypt_ext client nil))
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `completed` | `string` | No |  |
| `decrypted` | `double` | No |  |
| `encrypted` | `double` | Yes |  |
| `ip` | `string` | No |  |
| `message_id` | `string` | No |  |
| `partner_id` | `string` | Yes |  |
| `partner_key` | `string` | No |  |
| `reference` | `string` | No |  |
| `serial` | `string` | Yes |  |
| `success` | `boolean` | No |  |

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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-decrypt_ext/create (api/decrypt_ext client nil)
    (vs/jm
      "encrypted" 1  ;; double
      "partner_id" "example_partner_id"  ;; string
      "serial" "example_serial"  ;; string
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `DecryptExt` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Validation

```clojure
(require '[sdk.entity.validation :as e-validation])

(def validation (api/validation client nil))
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
| `success` | `boolean` | Yes |  |

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

#### `(create ent reqdata ctrl) -> map`

Create a new entity with the given data. Returns the created entity data and raises on error.

```clojure
(def result
  (e-validation/create (api/validation client nil)
    (vs/jm
      "message_id" "example_message_id"  ;; string
      "reference" "example_reference"  ;; string
      "serial" "example_serial"  ;; string
      "success" true  ;; boolean
      )
    nil))
```

### Common Members

State accessors are stored on the entity map and called via keyword lookup.

#### `((:data-get ent)) -> map`

Get the entity data.

#### `((:data-set ent) data)`

Set the entity data.

#### `((:match-get ent)) -> map`

Get the entity match criteria.

#### `((:match-set ent) match)`

Set the entity match criteria.

#### `((:make ent)) -> entity`

Create a new `Validation` entity instance with the same options.

#### `((:get-name ent)) -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```clojure
(def client
  (api/make-sdk
    (vs/jm "feature"
      (vs/jm
        "test" (vs/jm "active" true)
        ))))
```

