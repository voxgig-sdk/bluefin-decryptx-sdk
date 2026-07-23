# BluefinDecryptx Dart SDK Reference

Complete API reference for the BluefinDecryptx Dart SDK.

## BluefinDecryptxSDK

### Constructor

```dart
import 'package:bluefin_decryptx_sdk/BluefinDecryptxSDK.dart';

final client = BluefinDecryptxSDK(options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Map` | SDK configuration options. |
| `options['apikey']` | `String` | API key for authentication. |
| `options['base']` | `String` | Base URL for API requests. |
| `options['prefix']` | `String` | URL prefix appended after base. |
| `options['suffix']` | `String` | URL suffix appended after path. |
| `options['headers']` | `Map` | Custom headers for all requests. |
| `options['feature']` | `Map` | Feature configuration. |
| `options['system']` | `Map` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK.test([testopts, sdkopts])`

Create a test client with mock features active. Both arguments may be `null`.

```dart
final client = BluefinDecryptxSDK.test();
```


### Instance Methods

#### `Decrypt([entopts])`

Create a new `DecryptEntity` instance. Pass no argument for no initial data.

#### `DecryptExt([entopts])`

Create a new `DecryptExtEntity` instance. Pass no argument for no initial data.

#### `Validation([entopts])`

Create a new `ValidationEntity` instance. Pass no argument for no initial data.

#### `options() -> Map`

Return a deep copy of the current SDK options.

#### `utility() -> Utility`

Return the SDK utility object.

#### `direct([fetchargs]) -> Future<Map>`

Make a direct HTTP request to any API endpoint. Returns a result `Map` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never throws — branch on `result['ok']`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs['path']` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs['method']` | `String` | HTTP method (default: `'GET'`). |
| `fetchargs['params']` | `Map` | Path parameter values. |
| `fetchargs['query']` | `Map` | Query string parameters. |
| `fetchargs['headers']` | `Map` | Request headers (merged with defaults). |
| `fetchargs['body']` | `dynamic` | Request body (maps are JSON-serialized). |

**Returns:** `Future<Map>`

#### `prepare([fetchargs]) -> Future`

Prepare a fetch definition without sending. Returns the `fetchdef` (or an error value on failure).


---

## DecryptEntity

```dart
final decrypt = client.Decrypt();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `code` | `int` | No |  |
| `decrypted` | `List<dynamic>` | No |  |
| `decryption_parameter` | `Map<String, dynamic>` | Yes |  |
| `encrypted` | `List<dynamic>` | Yes |  |
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

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.Decrypt().create({
  'decryption_parameter': <String, dynamic>{},  // Map<String, dynamic>
  'encrypted': <dynamic>[],  // List<dynamic>
  'has_cc_data': true,  // bool
  'message_id': 'example_message_id',  // String
  'name': 'example_name',  // String
  'reference': 'example_reference',  // String
  'serial': 'example_serial',  // String
  'success': true,  // bool
});
```

#### `list([reqmatch, ctrl]) -> Future<List>`

List entities matching the given criteria. The match is optional — call `list()` with no argument to list all records. Returns a list of entity instances and throws on error.

```dart
final results = await client.Decrypt().list();
for (final decrypt in results) {
  print(decrypt.data());
}
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `DecryptEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## DecryptExtEntity

```dart
final decrypt_ext = client.DecryptExt();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `String` | No |  |
| `completed` | `String` | No |  |
| `decrypted` | `num` | No |  |
| `encrypted` | `num` | Yes |  |
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

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.DecryptExt().create({
  'encrypted': 1,  // num
  'partner_id': 'example_partner_id',  // String
  'serial': 'example_serial',  // String
});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `DecryptExtEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## ValidationEntity

```dart
final validation = client.Validation();
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

#### `create(reqdata, [ctrl]) -> Future<dynamic>`

Create a new entity with the given data. Returns the created entity data and throws on error.

```dart
final result = await client.Validation().create({
  'message_id': 'example_message_id',  // String
  'reference': 'example_reference',  // String
  'serial': 'example_serial',  // String
  'success': true,  // bool
});
```

### Common Methods

#### `data([d]) -> Map`

Get the entity data, or set it when passed an argument.

#### `match([m]) -> Map`

Get the entity match criteria, or set it when passed an argument.

#### `make() -> Entity`

Create a new `ValidationEntity` instance with the same options.

#### `entopts() -> Map`

Return the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```dart
final client = BluefinDecryptxSDK({
  'feature': {
    'test': {'active': true},
  },
});
```

