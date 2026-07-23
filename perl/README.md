# BluefinDecryptx Perl SDK



The Perl SDK for the BluefinDecryptx API — an entity-oriented client
following idiomatic Perl conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `$client->Decrypt` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to CPAN. Install it from the GitHub
release tag (`perl/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases)) or
from a source checkout.

The SDK is pure Perl with zero non-core runtime dependencies, so no build
step is required — just put its `lib` directory on `@INC`:

```perl
use lib 'lib';
use BluefinDecryptxSDK;
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```perl
use lib 'lib';
use BluefinDecryptxSDK;

my $client = BluefinDecryptxSDK->new({
    'apikey' => $ENV{'BLUEFIN_DECRYPTX_APIKEY'},
});
```

### 2. List decrypt records

`list()` returns an `arrayref` of records (each a `hashref`) and dies on
error — iterate it directly.

```perl
my $decrypts = eval { $client->Decrypt->list };
if (my $err = $@) {
    print "list failed: $err\n";
}
else {
    for my $decrypt (@$decrypts) {
        print "$decrypt->{id}\n";
    }
}
```

### 4. Create, update, and remove

```perl
# Create — returns the bare created record (a hashref)
my $created = $client->Decrypt->create({ 'decryption_parameter' => {}, 'encrypted' => [], 'has_cc_data' => 1, 'message_id' => 'example_message_id', 'name' => 'example_name', 'reference' => 'example_reference', 'serial' => 'example_serial', 'success' => 1 });

```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const decrypts = await client.Decrypt().list()
  console.log(decrypts)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```perl
my $result = $client->direct({
    'path' => '/api/resource/{id}',
    'method' => 'GET',
    'params' => { 'id' => 'example' },
});

if ($result->{ok}) {
    print $result->{status}, "\n";  # 200
    print $result->{data}, "\n";    # response body
}
else {
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read whichever is defined.
    print $result->{status}, ' ', ($result->{err} // ''), "\n";
}
```

### Prepare a request without sending it

```perl
# prepare() returns the fetch definition and dies on error.
my $fetchdef = $client->prepare({
    'path' => '/api/resource/{id}',
    'method' => 'DELETE',
    'params' => { 'id' => 'example' },
});

print $fetchdef->{url}, "\n";
print $fetchdef->{method}, "\n";
print $fetchdef->{headers}, "\n";
```

### Use test mode

Create a mock client for unit testing — no server required:

```perl
my $client = BluefinDecryptxSDK->test(undef, undef);

# Entity ops return the bare record and die on error.
my $decrypt = $client->Decrypt->list();
# $decrypt contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own coderef:

```perl
my $mock_fetch = sub {
    my ($url, $init) = @_;
    return ({
        'status' => 200,
        'statusText' => 'OK',
        'headers' => {},
        'json' => sub { { 'id' => 'mock01' } },
    }, undef);
};

my $client = BluefinDecryptxSDK->new({
    'base' => 'http://localhost:8080',
    'system' => { 'fetch' => $mock_fetch },
});
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run:

```bash
cd perl && prove -Ilib t/
```


## Reference

### BluefinDecryptxSDK

```perl
use lib 'lib';
use BluefinDecryptxSDK;

my $client = BluefinDecryptxSDK->new($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `hashref` | Feature activation flags. |
| `extend` | `arrayref` | Additional feature instances to load. |
| `system` | `hashref` | System overrides (e.g. custom `fetch` coderef). |

### test

```perl
my $client = BluefinDecryptxSDK->test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `undef`.

### BluefinDecryptxSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> hashref` | Deep copy of current SDK options. |
| `get_utility` | `() -> utility` | Copy of the SDK utility object. |
| `prepare` | `($fetchargs) -> hashref` | Build an HTTP request definition without sending. Dies on error. |
| `direct` | `($fetchargs) -> hashref` | Build and send an HTTP request. Returns a result hashref (branch on `ok`). |
| `Decrypt` | `($data) -> Decrypt entity` | Create a Decrypt entity instance. |
| `DecryptExt` | `($data) -> DecryptExt entity` | Create a DecryptExt entity instance. |
| `Validation` | `($data) -> Validation entity` | Create a Validation entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `list` | `($reqmatch, $ctrl) -> arrayref` | List entities matching the criteria. Dies on error. |
| `create` | `($reqdata, $ctrl) -> hashref` | Create a new entity. Dies on error. |
| `data_get` | `() -> hashref` | Get entity data. |
| `data_set` | `($data)` | Set entity data. |
| `match_get` | `() -> hashref` | Get entity match criteria. |
| `match_set` | `($match)` | Set entity match criteria. |
| `make` | `() -> entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `hashref` for single-entity
ops, an `arrayref` for `list`) and die on error. Wrap calls in
`eval { ... }` and inspect `$@` to handle failures.

The `direct()` escape hatch never dies — it returns a result `hashref`
you branch on via `$result->{ok}`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean` | True if the HTTP status is 2xx. |
| `status` | `integer` | HTTP status code. |
| `headers` | `hashref` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is false and `err` contains the error value.

### Entities

#### Decrypt

| Field | Description |
| --- | --- |
| `client_id` |  |
| `code` |  |
| `decrypted` |  |
| `decryption_parameter` |  |
| `encrypted` |  |
| `failed` |  |
| `firmware` |  |
| `has_cc_data` |  |
| `message` |  |
| `message_id` |  |
| `name` |  |
| `partner_id` |  |
| `partner_key` |  |
| `reference` |  |
| `serial` |  |
| `success` |  |
| `value` |  |

Operations: Create, List.

API path: `/decrypt`

#### DecryptExt

| Field | Description |
| --- | --- |
| `client_id` |  |
| `completed` |  |
| `decrypted` |  |
| `encrypted` |  |
| `ip` |  |
| `message_id` |  |
| `partner_id` |  |
| `partner_key` |  |
| `reference` |  |
| `serial` |  |
| `success` |  |

Operations: Create.

API path: `/decrypt-ext`

#### Validation

| Field | Description |
| --- | --- |
| `client_id` |  |
| `firmware` |  |
| `message_id` |  |
| `partner_id` |  |
| `partner_key` |  |
| `reference` |  |
| `serial` |  |
| `success` |  |

Operations: Create.

API path: `/device/validate`



## Entities


### Decrypt

Create an instance: `my $decrypt = $client->Decrypt;`

#### Operations

| Method | Description |
| --- | --- |
| `create($data)` | Create a new entity with the given data. |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `string` |  |
| `code` | `integer` |  |
| `decrypted` | `arrayref` |  |
| `decryption_parameter` | `hashref` |  |
| `encrypted` | `arrayref` |  |
| `failed` | `boolean` |  |
| `firmware` | `string` |  |
| `has_cc_data` | `boolean` |  |
| `message` | `string` |  |
| `message_id` | `string` |  |
| `name` | `string` |  |
| `partner_id` | `string` |  |
| `partner_key` | `string` |  |
| `reference` | `string` |  |
| `serial` | `string` |  |
| `success` | `boolean` |  |
| `value` | `string` |  |

#### Example: List

```perl
my $decrypts = $client->Decrypt->list;
```

#### Example: Create

```perl
my $decrypt = $client->Decrypt->create({
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


### DecryptExt

Create an instance: `my $decrypt_ext = $client->DecryptExt;`

#### Operations

| Method | Description |
| --- | --- |
| `create($data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `string` |  |
| `completed` | `string` |  |
| `decrypted` | `number` |  |
| `encrypted` | `number` |  |
| `ip` | `string` |  |
| `message_id` | `string` |  |
| `partner_id` | `string` |  |
| `partner_key` | `string` |  |
| `reference` | `string` |  |
| `serial` | `string` |  |
| `success` | `boolean` |  |

#### Example: Create

```perl
my $decrypt_ext = $client->DecryptExt->create({
    'encrypted' => 1,  # number
    'partner_id' => 'example_partner_id',  # string
    'serial' => 'example_serial',  # string
});
```


### Validation

Create an instance: `my $validation = $client->Validation;`

#### Operations

| Method | Description |
| --- | --- |
| `create($data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `string` |  |
| `firmware` | `string` |  |
| `message_id` | `string` |  |
| `partner_id` | `string` |  |
| `partner_key` | `string` |  |
| `reference` | `string` |  |
| `serial` | `string` |  |
| `success` | `boolean` |  |

#### Example: Create

```perl
my $validation = $client->Validation->create({
    'message_id' => 'example_message_id',  # string
    'reference' => 'example_reference',  # string
    'serial' => 'example_serial',  # string
    'success' => 1,  # boolean
});
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashrefs

The Perl SDK uses plain hashrefs and arrayrefs throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `BluefinDecryptxHelpers::to_map()` to safely validate that a value
is a hashref.

### Module structure

```
perl/
├── lib/BluefinDecryptxSDK.pm    -- Main SDK module (package BluefinDecryptxSDK)
├── config.pm                    -- Configuration
├── features.pm                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (base, test, log)
├── utility/                     -- Utility functions
├── lib/Voxgig/Struct.pm         -- Vendored struct library
└── t/                           -- Test suites
```

Load the main module with `use lib 'lib'; use BluefinDecryptxSDK;` — it
pulls in the config, features, and core modules for you. Require entity or
utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const decrypt = client.Decrypt()
await decrypt.list()

// decrypt.data() now returns the decrypt data from the last `list`
// decrypt.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
