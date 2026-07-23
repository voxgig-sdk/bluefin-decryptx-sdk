# BluefinDecryptx Kotlin SDK Reference

Complete API reference for the BluefinDecryptx Kotlin SDK.


## BluefinDecryptxSDK

### Constructor

```kotlin
val client = BluefinDecryptxSDK(options)
```

Create a new SDK client instance. `options` is a `MutableMap<String, Any?>`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Map` | Custom headers for all requests. |
| `options["feature"]` | `Map` | Feature configuration. |
| `options["system"]` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK.testSDK(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `null`.

```kotlin
val client = BluefinDecryptxSDK.testSDK(null, null)
```


### Instance Methods

#### `decrypt(entopts)`

Create a new `Decrypt` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `decryptExt(entopts)`

Create a new `DecryptExt` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `validation(entopts)`

Create a new `Validation` entity instance (returns `SdkEntity`). Pass
`null` for no initial options.

#### `optionsMap() -> MutableMap`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> MutableMap`

Make a direct HTTP request to any API endpoint. Returns a result
`MutableMap<String, Any?>` with `ok`, `status`, `headers`, and `data`
(or `err` on failure). This escape hatch never raises — branch on
`result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Any?` | Request body (maps are JSON-serialized). |

**Returns:** `MutableMap<String, Any?>`

#### `prepare(fetchargs) -> MutableMap`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Decrypt

```kotlin
val decrypt = client.decrypt(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String?` | No |  |
| `code` | `Long?` | No |  |
| `decrypted` | `List<Any?>?` | No |  |
| `decryption_parameter` | `Map<String, Any?>?` | Yes |  |
| `encrypted` | `List<Any?>?` | Yes |  |
| `failed` | `Boolean?` | No |  |
| `firmware` | `String?` | No |  |
| `has_cc_data` | `Boolean?` | Yes |  |
| `message` | `String?` | No |  |
| `message_id` | `String?` | Yes |  |
| `name` | `String?` | Yes |  |
| `partner_id` | `String?` | No |  |
| `partner_key` | `String?` | No |  |
| `reference` | `String?` | Yes |  |
| `serial` | `String?` | Yes |  |
| `success` | `Boolean?` | Yes |  |
| `value` | `String?` | No |  |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.decrypt(null).create(mutableMapOf<String, Any?>(
    "decryption_parameter" to mapOf<String, Any?>(),  // Map<String, Any?>?
    "encrypted" to listOf<Any?>(),  // List<Any?>?
    "has_cc_data" to true,  // Boolean?
    "message_id" to "example_message_id",  // String?
    "name" to "example_name",  // String?
    "reference" to "example_reference",  // String?
    "serial" to "example_serial",  // String?
    "success" to true  // Boolean?
), null)
```

#### `list(reqmatch, ctrl) -> Any?`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```kotlin
val results = client.decrypt(null).list(null, null)
println(results)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Decrypt` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## DecryptExt

```kotlin
val decryptExt = client.decryptExt(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String?` | No |  |
| `completed` | `String?` | No |  |
| `decrypted` | `Double?` | No |  |
| `encrypted` | `Double?` | Yes |  |
| `ip` | `String?` | No |  |
| `message_id` | `String?` | No |  |
| `partner_id` | `String?` | Yes |  |
| `partner_key` | `String?` | No |  |
| `reference` | `String?` | No |  |
| `serial` | `String?` | Yes |  |
| `success` | `Boolean?` | No |  |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.decryptExt(null).create(mutableMapOf<String, Any?>(
    "encrypted" to 1.0,  // Double?
    "partner_id" to "example_partner_id",  // String?
    "serial" to "example_serial"  // String?
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `DecryptExt` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Validation

```kotlin
val validation = client.validation(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String?` | No |  |
| `firmware` | `String?` | No |  |
| `message_id` | `String?` | Yes |  |
| `partner_id` | `String?` | No |  |
| `partner_key` | `String?` | No |  |
| `reference` | `String?` | Yes |  |
| `serial` | `String?` | Yes |  |
| `success` | `Boolean?` | Yes |  |

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

#### `create(reqdata, ctrl) -> Any?`

Create a new entity with the given data. Returns the created entity data and raises on error.

```kotlin
val result = client.validation(null).create(mutableMapOf<String, Any?>(
    "message_id" to "example_message_id",  // String?
    "reference" to "example_reference",  // String?
    "serial" to "example_serial",  // String?
    "success" to true  // Boolean?
), null)
```

### Common Methods

#### `data(vararg newdata) -> Any?`

Get or set the entity data.

#### `match(vararg newmatch) -> Any?`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Validation` entity instance with the same options.

#### `name -> String`

The entity name (read-only property).


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```kotlin
val feature = mutableMapOf<String, Any?>(
    "test" to mapOf("active" to true),
)
val client = BluefinDecryptxSDK(mutableMapOf<String, Any?>("feature" to feature))
```

