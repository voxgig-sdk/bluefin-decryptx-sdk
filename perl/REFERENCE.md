# BluefinDecryptx Perl SDK Reference

Complete API reference for the BluefinDecryptx Perl SDK.


## BluefinDecryptxSDK

### Constructor

```perl
use lib 'lib';
use BluefinDecryptxSDK;

my $client = BluefinDecryptxSDK->new($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `hashref` | SDK configuration options. |
| `$options->{apikey}` | `string` | API key for authentication. |
| `$options->{base}` | `string` | Base URL for API requests. |
| `$options->{prefix}` | `string` | URL prefix appended after base. |
| `$options->{suffix}` | `string` | URL suffix appended after path. |
| `$options->{headers}` | `hashref` | Custom headers for all requests. |
| `$options->{feature}` | `hashref` | Feature configuration. |
| `$options->{system}` | `hashref` | System overrides (e.g. custom fetch). |


### Static Methods

#### `BluefinDecryptxSDK->test($testopts, $sdkopts)`

Create a test client with mock features active. Both arguments may be `undef`.

```perl
my $client = BluefinDecryptxSDK->test();
```


### Instance Methods

#### `Decrypt($data)`

Create a new `Decrypt` entity instance. Pass `undef` for no initial data.

#### `DecryptExt($data)`

Create a new `DecryptExt` entity instance. Pass `undef` for no initial data.

#### `Validation($data)`

Create a new `Validation` entity instance. Pass `undef` for no initial data.

#### `options_map() -> hashref`

Return a deep copy of the current SDK options.

#### `get_utility() -> utility`

Return a copy of the SDK utility object.

#### `direct($fetchargs) -> hashref`

Make a direct HTTP request to any API endpoint. Returns a result `hashref` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never dies — branch on `$result->{ok}`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs->{path}` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs->{method}` | `string` | HTTP method (default: `'GET'`). |
| `$fetchargs->{params}` | `hashref` | Path parameter values. |
| `$fetchargs->{query}` | `hashref` | Query string parameters. |
| `$fetchargs->{headers}` | `hashref` | Request headers (merged with defaults). |
| `$fetchargs->{body}` | `any` | Request body (hashrefs are JSON-serialized). |

**Returns:** `hashref`

#### `prepare($fetchargs) -> hashref`

Prepare a fetch definition without sending. Returns the `fetchdef` and dies on error.


---

## Decrypt entity

```perl
my $decrypt = $client->Decrypt;
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `client_id` | `string` | No |  |
| `code` | `integer` | No |  |
| `decrypted` | `arrayref` | No |  |
| `decryption_parameter` | `hashref` | Yes |  |
| `encrypted` | `arrayref` | Yes |  |
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Decrypt->create({
    'decryption_parameter' => {},  # hashref
    'encrypted' => [],  # arrayref
    'has_cc_data' => 1,  # boolean
    'message_id' => 'example_message_id',  # string
    'name' => 'example_name',  # string
    'reference' => 'example_reference',  # string
    'serial' => 'example_serial',  # string
    'success' => 1,  # boolean
});
```

#### `list($reqmatch, $ctrl) -> arrayref`

List entities matching the given criteria. The match is optional — call `list` with no argument to list all records. Returns an arrayref and dies on error.

```perl
my $results = $client->Decrypt->list;
for my $decrypt (@$results) {
    print "$decrypt->{id}\n";
}
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Decrypt` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## DecryptExt entity

```perl
my $decrypt_ext = $client->DecryptExt;
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->DecryptExt->create({
    'encrypted' => 1,  # number
    'partner_id' => 'example_partner_id',  # string
    'serial' => 'example_serial',  # string
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `DecryptExt` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Validation entity

```perl
my $validation = $client->Validation;
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

#### `create($reqdata, $ctrl) -> hashref`

Create a new entity with the given data. Returns the created entity data and dies on error.

```perl
my $result = $client->Validation->create({
    'message_id' => 'example_message_id',  # string
    'reference' => 'example_reference',  # string
    'serial' => 'example_serial',  # string
    'success' => 1,  # boolean
});
```

### Common Methods

#### `data_get() -> hashref`

Get the entity data.

#### `data_set($data)`

Set the entity data.

#### `match_get() -> hashref`

Get the entity match criteria.

#### `match_set($match)`

Set the entity match criteria.

#### `make() -> entity`

Create a new `Validation` entity instance with the same options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```perl
my $client = BluefinDecryptxSDK->new({
    'feature' => {
        'test' => { 'active' => 1 },
    },
});
```

