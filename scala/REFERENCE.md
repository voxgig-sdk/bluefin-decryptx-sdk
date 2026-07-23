# BluefinDecryptx Scala SDK Reference

Complete API reference for the BluefinDecryptx Scala SDK.


## BluefinDecryptxSDK

### Constructor

```scala
val client = new BluefinDecryptxSDK(options)
```

Create a new SDK client instance. `options` is a `java.util.Map[String, Object]`.

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

```scala
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

#### `optionsMap() -> Map`

Return a deep copy of the current SDK options.

#### `getUtility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> Map`

Make a direct HTTP request to any API endpoint. Returns a result
`java.util.Map[String, Object]` with `ok`, `status`, `headers`, and
`data` (or `err` on failure). This escape hatch never raises — branch on
`result.get("ok")`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Map` | Path parameter values. |
| `fetchargs["query"]` | `Map` | Query string parameters. |
| `fetchargs["headers"]` | `Map` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `Object` | Request body (maps are JSON-serialized). |

**Returns:** `java.util.Map[String, Object]`

#### `prepare(fetchargs) -> Map`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## Decrypt

```scala
val decrypt = client.decrypt(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `code` | `java.lang.Long` | No |  |
| `decrypted` | `java.util.List[Object]` | No |  |
| `decryption_parameter` | `java.util.Map[String, Object]` | Yes |  |
| `encrypted` | `java.util.List[Object]` | Yes |  |
| `failed` | `java.lang.Boolean` | No |  |
| `firmware` | `String` | No |  |
| `has_cc_data` | `java.lang.Boolean` | Yes |  |
| `message` | `String` | No |  |
| `message_id` | `String` | Yes |  |
| `name` | `String` | Yes |  |
| `partner_id` | `String` | No |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | Yes |  |
| `serial` | `String` | Yes |  |
| `success` | `java.lang.Boolean` | Yes |  |
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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.decrypt(null).create(java.util.Map.of(
    "decryption_parameter", java.util.Map.of(),  // java.util.Map[String, Object]
    "encrypted", java.util.List.of(),  // java.util.List[Object]
    "has_cc_data", true,  // java.lang.Boolean
    "message_id", "example_message_id",  // String
    "name", "example_name",  // String
    "reference", "example_reference",  // String
    "serial", "example_serial",  // String
    "success", true  // java.lang.Boolean
), null)
```

#### `list(reqmatch, ctrl) -> Object`

List entities matching the given criteria. The match is optional — call `list(null, null)` to list all records. Returns an aggregate list and raises on error.

```scala
val results = client.decrypt(null).list(null, null)
println(results)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Decrypt` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## DecryptExt

```scala
val decryptExt = client.decryptExt(null)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `completed` | `String` | No |  |
| `decrypted` | `java.lang.Double` | No |  |
| `encrypted` | `java.lang.Double` | Yes |  |
| `ip` | `String` | No |  |
| `message_id` | `String` | No |  |
| `partner_id` | `String` | Yes |  |
| `partner_key` | `String` | No |  |
| `reference` | `String` | No |  |
| `serial` | `String` | Yes |  |
| `success` | `java.lang.Boolean` | No |  |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.decryptExt(null).create(java.util.Map.of(
    "encrypted", 1.0,  // java.lang.Double
    "partner_id", "example_partner_id",  // String
    "serial", "example_serial"  // String
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `DecryptExt` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Validation

```scala
val validation = client.validation(null)
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
| `success` | `java.lang.Boolean` | Yes |  |

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

#### `create(reqdata, ctrl) -> Object`

Create a new entity with the given data. Returns the created entity data and raises on error.

```scala
val result = client.validation(null).create(java.util.Map.of(
    "message_id", "example_message_id",  // String
    "reference", "example_reference",  // String
    "serial", "example_serial",  // String
    "success", true  // java.lang.Boolean
), null)
```

### Common Methods

#### `data(newdata*) -> Object`

Get or set the entity data.

#### `matchArgs(newmatch*) -> Object`

Get or set the entity match criteria.

#### `make() -> Entity`

Create a new `Validation` entity instance with the same options.

#### `getName() -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```scala
val feature = new java.util.LinkedHashMap[String, Object]()
feature.put("test", java.util.Map.of("active", true))
val options = new java.util.LinkedHashMap[String, Object]()
options.put("feature", feature)
val client = new BluefinDecryptxSDK(options)
```

