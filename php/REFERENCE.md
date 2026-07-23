# BluefinDecryptx PHP SDK Reference

Complete API reference for the BluefinDecryptx PHP SDK.


## BluefinDecryptxSDK

### Constructor

```php
require_once __DIR__ . '/bluefindecryptx_sdk.php';

$client = new BluefinDecryptxSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = BluefinDecryptxSDK::test();
```


### Instance Methods

#### `Decrypt($data = null)`

Create a new `DecryptEntity` instance. Pass `null` for no initial data.

#### `DecryptExt($data = null)`

Create a new `DecryptExtEntity` instance. Pass `null` for no initial data.

#### `Validation($data = null)`

Create a new `ValidationEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): BluefinDecryptxUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## DecryptEntity

```php
$decrypt = $client->Decrypt();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `code` | `int` | No |  |
| `decrypted` | `array` | No |  |
| `decryption_parameter` | `array` | Yes |  |
| `encrypted` | `array` | Yes |  |
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->Decrypt()->create([
  "decryption_parameter" => null, // array
  "encrypted" => null, // array
  "has_cc_data" => null, // bool
  "message_id" => null, // string
  "name" => null, // string
  "reference" => null, // string
  "serial" => null, // string
  "success" => null, // bool
]);
```

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Decrypt()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): DecryptEntity`

Create a new `DecryptEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## DecryptExtEntity

```php
$decrypt_ext = $client->DecryptExt();
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->DecryptExt()->create([
  "encrypted" => null, // float
  "partner_id" => null, // string
  "serial" => null, // string
]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): DecryptExtEntity`

Create a new `DecryptExtEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ValidationEntity

```php
$validation = $client->Validation();
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

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->Validation()->create([
  "message_id" => null, // string
  "reference" => null, // string
  "serial" => null, // string
  "success" => null, // bool
]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ValidationEntity`

Create a new `ValidationEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new BluefinDecryptxSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

