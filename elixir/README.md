# BluefinDecryptx Elixir SDK



The Elixir SDK for the BluefinDecryptx API — an entity-oriented client
following idiomatic, functional Elixir conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `BluefinDecryptx.decrypt(sdk)` — each
carrying a small, uniform set of operations (`list`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to [Hex](https://hex.pm). Install it from
the GitHub release tag (`elixir/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases))
by adding a git dependency to your `mix.exs`:

```elixir
def deps do
  [
    {:bluefin_decryptx, git: "https://github.com/voxgig-sdk/bluefin-decryptx-sdk.git", tag: "elixir/vX.Y.Z"}
  ]
end
```

Or from a local source checkout:

```elixir
def deps do
  [
    {:bluefin_decryptx, path: "../bluefin-decryptx-sdk/elixir"}
  ]
end
```

Then run `mix deps.get`.


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```elixir
alias BluefinDecryptx.Helpers, as: H

sdk = BluefinDecryptx.new(H.deep(%{"apikey" => System.get_env("BLUEFIN_DECRYPTX_APIKEY")}))
```

### 2. List decrypt records

`list/2` returns a list value node and raises on error.

```elixir
try do
  decrypt = BluefinDecryptx.decrypt(sdk)
  records = BluefinDecryptx.Entity.Decrypt.list(decrypt)
  IO.inspect(records)
rescue
  err -> IO.puts("list failed: " <> inspect(err))
end
```

### 4. Create, update, and remove

```elixir
decrypt = BluefinDecryptx.decrypt(sdk)

# Create — returns the bare created record
created = BluefinDecryptx.Entity.Decrypt.create(decrypt, H.deep(%{"decryption_parameter" => %{}, "encrypted" => [], "has_cc_data" => true, "message_id" => "example_message_id", "name" => "example_name", "reference" => "example_reference", "serial" => "example_serial", "success" => true}))

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

For endpoints not covered by entity operations. `direct/2` never raises —
it returns a result node you branch on with `Voxgig.Struct.getprop/2`:

```elixir
alias Voxgig.Struct, as: S
alias BluefinDecryptx.Helpers, as: H

result = BluefinDecryptx.direct(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => %{"id" => "example"}
}))

if S.getprop(result, "ok") do
  IO.inspect(S.getprop(result, "status"))  # 200
  IO.inspect(S.getprop(result, "data"))    # response body
else
  # A non-2xx response carries status + data (the error body); a
  # transport-level failure carries err instead.
  IO.inspect(S.getprop(result, "err"))
end
```

### Prepare a request without sending it

```elixir
alias BluefinDecryptx.Helpers, as: H

# prepare/2 returns the fetch definition and raises on error.
fetchdef = BluefinDecryptx.prepare(sdk, H.deep(%{
  "path" => "/api/resource/{id}",
  "method" => "DELETE",
  "params" => %{"id" => "example"}
}))

IO.inspect(Voxgig.Struct.getprop(fetchdef, "url"))
IO.inspect(Voxgig.Struct.getprop(fetchdef, "method"))
```

### Use test mode

Create a mock client for unit testing — no server required:

```elixir
alias BluefinDecryptx.Helpers, as: H

sdk = BluefinDecryptx.test()

# Entity ops return the bare record (raise on error).
decrypt = BluefinDecryptx.decrypt(sdk)
records = BluefinDecryptx.Entity.Decrypt.list(decrypt, H.deep(%{}))
IO.inspect(records)
```

### Use a custom fetch function

Replace the HTTP transport with your own function. It receives `(url,
fetchdef)` and returns a `{response, error}` tuple:

```elixir
alias Voxgig.Struct, as: S
alias BluefinDecryptx.Helpers, as: H

mock_fetch = fn _url, _fetchdef ->
  response = H.deep(%{
    "status" => 200,
    "statusText" => "OK",
    "headers" => %{},
    "json" => fn -> %{"id" => "mock01"} end
  })
  {response, nil}
end

sdk = BluefinDecryptx.new(H.deep(%{
  "base" => "http://localhost:8080",
  "system" => %{"fetch" => mock_fetch}
}))
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run:

```bash
cd elixir && mix test
```


## Reference

### BluefinDecryptx

```elixir
sdk = BluefinDecryptx.new(options)
```

Creates a new SDK client. `options` is a struct value node — build one from a
native map with `BluefinDecryptx.Helpers.deep/1`.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String.t()` | API key for authentication. |
| `base` | `String.t()` | Base URL of the API server. |
| `prefix` | `String.t()` | URL path prefix prepended to all requests. |
| `suffix` | `String.t()` | URL path suffix appended to all requests. |
| `feature` | `map()` | Feature activation flags. |
| `extend` | `list()` | Additional feature instances to load. |
| `system` | `map()` | System overrides (e.g. custom `fetch` function). |

### test

```elixir
sdk = BluefinDecryptx.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### BluefinDecryptx functions

| Function | Signature | Description |
| --- | --- | --- |
| `options_map` | `(client) :: map()` | Deep copy of current SDK options. |
| `get_utility` | `(client) :: map()` | The SDK utility node. |
| `prepare` | `(client, fetchargs) :: map()` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(client, fetchargs) :: map()` | Build and send an HTTP request. Returns a result node (branch on `ok`). |
| `decrypt` | `(client, entopts \\ nil) :: entity` | Create a Decrypt entity handle. |
| `decrypt_ext` | `(client, entopts \\ nil) :: entity` | Create a DecryptExt entity handle. |
| `validation` | `(client, entopts \\ nil) :: entity` | Create a Validation entity handle. |

### Entity interface

Every entity's `BluefinDecryptx.Entity.<Name>` module shares the same interface.

| Function | Signature | Description |
| --- | --- | --- |
| `list` | `(entity, reqmatch \\ nil, ctrl \\ nil) :: list()` | List entities matching the criteria. Raises on error. |
| `create` | `(entity, reqdata, ctrl \\ nil) :: map()` | Create a new entity. Raises on error. |
| `data_get` | `(entity) :: map()` | Get entity data. |
| `data_set` | `(entity, data)` | Set entity data. |
| `match_get` | `(entity) :: map()` | Get entity match criteria. |
| `match_set` | `(entity, match)` | Set entity match criteria. |
| `make` | `(entity) :: entity` | Create a new handle with the same options. |
| `get_name` | `(entity) :: String.t()` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a value node — a map for
single-entity ops, a list for `list`) and raise a `BluefinDecryptx.Error` on
failure. Wrap calls in `try`/`rescue` to handle errors.

The `direct/2` escape hatch never raises — it returns a result node you
branch on via `Voxgig.Struct.getprop(result, "ok")`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean()` | `true` if the HTTP status is 2xx. |
| `status` | `integer()` | HTTP status code. |
| `headers` | `map()` | Response headers. |
| `data` | `any()` | Parsed JSON response body. |

On error, `ok` is `false` and `err` carries the error value.

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

Every operation lives on the entity's `BluefinDecryptx.Entity.<Name>` module and
takes an entity handle built from the client:


### Decrypt

Create a handle: `decrypt = BluefinDecryptx.decrypt(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |
| `list(entity)` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String.t()` |  |
| `code` | `integer()` |  |
| `decrypted` | `list()` |  |
| `decryption_parameter` | `map()` |  |
| `encrypted` | `list()` |  |
| `failed` | `boolean()` |  |
| `firmware` | `String.t()` |  |
| `has_cc_data` | `boolean()` |  |
| `message` | `String.t()` |  |
| `message_id` | `String.t()` |  |
| `name` | `String.t()` |  |
| `partner_id` | `String.t()` |  |
| `partner_key` | `String.t()` |  |
| `reference` | `String.t()` |  |
| `serial` | `String.t()` |  |
| `success` | `boolean()` |  |
| `value` | `String.t()` |  |

#### Example: List

```elixir
decrypt = BluefinDecryptx.decrypt(sdk)
records = BluefinDecryptx.Entity.Decrypt.list(decrypt)
```

#### Example: Create

```elixir
decrypt = BluefinDecryptx.decrypt(sdk)
record = BluefinDecryptx.Entity.Decrypt.create(decrypt, BluefinDecryptx.Helpers.deep(%{
  "decryption_parameter" => %{},  # map()
  "encrypted" => [],  # list()
  "has_cc_data" => true,  # boolean()
  "message_id" => "example_message_id",  # String.t()
  "name" => "example_name",  # String.t()
  "reference" => "example_reference",  # String.t()
  "serial" => "example_serial",  # String.t()
  "success" => true,  # boolean()
}))
```


### DecryptExt

Create a handle: `decrypt_ext = BluefinDecryptx.decrypt_ext(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String.t()` |  |
| `completed` | `String.t()` |  |
| `decrypted` | `float()` |  |
| `encrypted` | `float()` |  |
| `ip` | `String.t()` |  |
| `message_id` | `String.t()` |  |
| `partner_id` | `String.t()` |  |
| `partner_key` | `String.t()` |  |
| `reference` | `String.t()` |  |
| `serial` | `String.t()` |  |
| `success` | `boolean()` |  |

#### Example: Create

```elixir
decrypt_ext = BluefinDecryptx.decrypt_ext(sdk)
record = BluefinDecryptx.Entity.DecryptExt.create(decrypt_ext, BluefinDecryptx.Helpers.deep(%{
  "encrypted" => 1,  # float()
  "partner_id" => "example_partner_id",  # String.t()
  "serial" => "example_serial",  # String.t()
}))
```


### Validation

Create a handle: `validation = BluefinDecryptx.validation(sdk)`

#### Operations

| Method | Description |
| --- | --- |
| `create(entity, data)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String.t()` |  |
| `firmware` | `String.t()` |  |
| `message_id` | `String.t()` |  |
| `partner_id` | `String.t()` |  |
| `partner_key` | `String.t()` |  |
| `reference` | `String.t()` |  |
| `serial` | `String.t()` |  |
| `success` | `boolean()` |  |

#### Example: Create

```elixir
validation = BluefinDecryptx.validation(sdk)
record = BluefinDecryptx.Entity.Validation.create(validation, BluefinDecryptx.Helpers.deep(%{
  "message_id" => "example_message_id",  # String.t()
  "reference" => "example_reference",  # String.t()
  "serial" => "example_serial",  # String.t()
  "success" => true,  # boolean()
}))
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

### Data as struct value nodes

The Elixir SDK models every runtime object — clients, contexts, results and
record data — as reference-stable struct value nodes from the vendored
`Voxgig.Struct` library rather than as compile-time structs. This mirrors
the dynamic nature of the API and lets a feature hook mutate a shared node
that every later pipeline stage observes — the immutable-Elixir way to honour
the shared-mutable hook contract.

Build inputs from native Elixir maps with `BluefinDecryptx.Helpers.deep/1`,
and read fields off results with `Voxgig.Struct.getprop/2`.

### Module structure

```
elixir/
├── lib/
│   ├── bluefin-decryptx.ex                 -- Main SDK module (entity factories)
│   ├── config.ex                 -- Resolved configuration
│   ├── features.ex               -- Feature factory
│   ├── pipeline.ex               -- Operation pipeline
│   └── bluefin-decryptx/
│       ├── context.ex            -- Operation context
│       ├── entity_base.ex        -- Shared entity behaviour
│       ├── error.ex              -- SDK error type
│       ├── feature.ex            -- Built-in features
│       ├── helpers.ex            -- Value helpers (deep/1, ...)
│       ├── json.ex               -- JSON encode/decode
│       └── utility.ex            -- Utility functions
│   └── entity/                   -- Per-entity modules
├── mix.exs                       -- Package manifest
└── test/                         -- ExUnit suites
```

The main module `BluefinDecryptx` exposes the SDK constructors and one entity
factory function per entity. Call an operation on the matching
`BluefinDecryptx.Entity.<Name>` module.

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
