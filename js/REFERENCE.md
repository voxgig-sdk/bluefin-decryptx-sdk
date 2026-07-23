# BluefinDecryptx JavaScript SDK Reference

Complete API reference for the BluefinDecryptx JavaScript SDK.


## BluefinDecryptxSDK

### Constructor

```ts
new BluefinDecryptxSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = BluefinDecryptxSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `BluefinDecryptxSDK` instance in test mode.


### Instance Methods

#### `Decrypt(data?: object)`

Create a new `Decrypt` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `DecryptEntity` instance.

#### `DecryptExt(data?: object)`

Create a new `DecryptExt` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `DecryptExtEntity` instance.

#### `Validation(data?: object)`

Create a new `Validation` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ValidationEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `BluefinDecryptxSDK.test()`.

**Returns:** `BluefinDecryptxSDK` instance in test mode.


---

## DecryptEntity

```ts
const decrypt = client.Decrypt()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `code` | `number` | No |  |
| `decrypted` | `Array` | No |  |
| `decryption_parameter` | `Object` | Yes |  |
| `encrypted` | `Array` | Yes |  |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Decrypt().create({
  decryption_parameter: {},
  encrypted: [],
  has_cc_data: true,
  message_id: 'example_message_id',
  name: 'example_name',
  reference: 'example_reference',
  serial: 'example_serial',
  success: true,
})
```

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Decrypt().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `DecryptEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinDecryptxSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## DecryptExtEntity

```ts
const decrypt_ext = client.DecryptExt()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `completed` | `string` | No |  |
| `decrypted` | `number` | No |  |
| `encrypted` | `number` | Yes |  |
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.DecryptExt().create({
  encrypted: 1,
  partner_id: 'example_partner_id',
  serial: 'example_serial',
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `DecryptExtEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinDecryptxSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ValidationEntity

```ts
const validation = client.Validation()
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

#### `create(data: object, ctrl?: object)`

Create a new entity with the given data.

```ts
const result = await client.Validation().create({
  message_id: 'example_message_id',
  reference: 'example_reference',
  serial: 'example_serial',
  success: true,
})
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ValidationEntity` instance with the same client and
options.

#### `client()`

Return the parent `BluefinDecryptxSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new BluefinDecryptxSDK({
  feature: {
    test: { active: true },
  }
})
```

