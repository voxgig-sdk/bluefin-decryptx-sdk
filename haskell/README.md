# BluefinDecryptx Haskell SDK



The Haskell SDK for the BluefinDecryptx API — an entity-oriented client following idiomatic Haskell conventions (pure functions, explicit `IO`, and the dependency-free vendored `Value` struct model).

The SDK exposes the API as capitalised, semantic **Entities** — for example `decrypt sdk VNoval` — each
carrying a small, uniform set of operations (`eList`, `eCreate`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Hackage. Install it from the GitHub
release tag (`haskell/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases)) or
from a source checkout. The runtime has no third-party dependencies (only the
GHC boot libraries: `base`, `containers`, `array`, `time`), so the
bundled Makefile drives stock GHC with no cabal solve:

```bash
cd haskell && make test
```

A `.cabal` file is also generated for use with `cabal`/`stack`:

```bash
cd haskell && cabal build
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```haskell
import System.Environment (lookupEnv)
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..), emptyMap)
import SdkHelpers (jo)

main :: IO ()
main = do
  mkey <- lookupEnv "BLUEFIN_DECRYPTX_APIKEY"
  opts <- jo [("apikey", maybe VNoval VStr mkey)]
  sdk <- Sdk.newSdk opts
```

Entity operations raise on error (via `Control.Exception.throwIO`) and
return the bare result `Value`. Wrap a call in `Control.Exception.try`
to recover from failures.

### 2. List decrypt records

`eList ent match ctrl` returns a list `Value` and raises on error.

```haskell
  ent <- Sdk.decrypt sdk VNoval
  match <- emptyMap
  ctrl <- emptyMap
  decrypts <- Sdk.eList ent match ctrl
  print decrypts
```

### 4. Create, update, and remove

```haskell
  createEnt <- Sdk.decrypt sdk VNoval
  d <- jo [("decryption_parameter", VNoval), ("encrypted", VNoval), ("has_cc_data", VBool True), ("message_id", VStr "example_message_id"), ("name", VStr "example_name"), ("reference", VStr "example_reference"), ("serial", VStr "example_serial"), ("success", VBool True)]
  cctrl <- emptyMap
  created <- Sdk.eCreate createEnt d cctrl
  print created
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

For endpoints not covered by entity accessors, use `direct` — it never
raises and returns a result `Value` you branch on via its `ok` field:

```haskell
import qualified SdkClient as Sdk
import qualified SdkFeatures as F
import VoxgigStruct (Value (..))
import SdkHelpers (jo, getp)

main :: IO ()
main = do
  sdk <- Sdk.newSdk0
  params <- jo [("id", VStr "example")]
  args <- jo [("path", VStr "/api/resource/{id}"), ("method", VStr "GET"), ("params", params)]
  result <- F.direct sdk args
  ok <- getp result "ok"
  case ok of
    VBool True -> do
      status <- getp result "status"   -- e.g. VNum 200
      body <- getp result "data"       -- the response body
      print (status, body)
    _ -> do
      -- A non-2xx response carries status + data (the error body); a
      -- transport-level failure carries err instead.
      status <- getp result "status"
      err <- getp result "err"
      print (status, err)
```

### Prepare a request without sending it

```haskell
import qualified SdkClient as Sdk
import qualified SdkFeatures as F
import VoxgigStruct (Value (..))
import SdkHelpers (jo, getp)

main :: IO ()
main = do
  sdk <- Sdk.newSdk0
  params <- jo [("id", VStr "example")]
  args <- jo [("path", VStr "/api/resource/{id}"), ("method", VStr "DELETE"), ("params", params)]
  -- prepare returns the fetch definition and raises on error.
  fetchdef <- F.prepare sdk args
  url <- getp fetchdef "url"
  method <- getp fetchdef "method"
  print (url, method)
```

### Use test mode

Create a mock client for unit testing — no server required:

```haskell
import qualified SdkClient as Sdk
import qualified SdkFeatures as F
import VoxgigStruct (Value (..), emptyMap)
import SdkHelpers (jo)

main :: IO ()
main = do
  sdk <- Sdk.testSdk0
  ent <- Sdk.decrypt sdk VNoval
  arg <- emptyMap
  ctrl <- emptyMap
  -- Entity ops return the bare record and raise on error.
  decrypt <- Sdk.eList ent arg ctrl
  print decrypt
```

### Use a custom fetch function

Replace the HTTP transport with your own `VFunc` under `system.fetch`:

```haskell
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..))
import SdkHelpers (jo, jsonThunk)

customClient :: IO Sdk.Client
customClient = do
  let mockFetch = VFunc (\_ _ _ _ -> do
        body <- jo [("id", VStr "mock01")]
        jo [("status", VNum 200), ("statusText", VStr "OK"), ("json", jsonThunk body)])
  sys <- jo [("fetch", mockFetch)]
  opts <- jo [("base", VStr "http://localhost:8080"), ("system", sys)]
  Sdk.newSdk opts
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run the suite (stock GHC, no third-party dependencies):

```bash
cd haskell && make test
```


## Reference

### Client constructors

```haskell
import qualified SdkClient as Sdk
import VoxgigStruct (Value (..))
import SdkHelpers (jo)

makeClient :: IO Sdk.Client
makeClient = do
  opts <- jo [("base", VStr "https://api.example.com")]
  Sdk.newSdk opts
```

`newSdk :: Value -> IO Client` constructs a client from an options map;
`newSdk0 :: IO Client` is the no-argument convenience form.

| Option (map key) | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `headers` | `Value` | Custom headers for all requests. |
| `feature` | `Value` | Feature activation flags. |
| `system` | `Value` | System overrides (e.g. custom `fetch` function). |

### Test client

```haskell
client <- Sdk.testSdk testopts sdkopts
```

`testSdk :: Value -> Value -> IO Client` constructs a test-mode client with
mock transport (`testSdk0 :: IO Client` for the no-argument form). Pass
`VNoval` for defaults.

### Client functions

| Function | Signature | Description |
| --- | --- | --- |
| `newSdk` | `Value -> IO Client` | Construct a live client from options. |
| `newSdk0` | `IO Client` | Construct a live client with defaults. |
| `testSdk` | `Value -> Value -> IO Client` | Construct a test-mode client. |
| `prepare` | `Client -> Value -> IO Value` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `Client -> Value -> IO Value` | Build and send an HTTP request. Returns a result `Value` (branch on `ok`). |
| `decrypt` | `Client -> Value -> IO Entity` | Create a Decrypt entity instance. |
| `decrypt_ext` | `Client -> Value -> IO Entity` | Create a DecryptExt entity instance. |
| `validation` | `Client -> Value -> IO Entity` | Create a Validation entity instance. |

### Entity interface

All entities share the same record interface (fields of the `Entity` type).

| Field | Signature | Description |
| --- | --- | --- |
| `eList` | `Value -> Value -> IO Value` | List entities matching the criteria. Raises on error. |
| `eCreate` | `Value -> Value -> IO Value` | Create a new entity. Raises on error. |
| `eDataGet` | `IO Value` | Get entity data. |
| `eDataSet` | `Value -> IO ()` | Set entity data. |
| `eStream` | `String -> Value -> Value -> IO [Value]` | Run an op as a lazy stream of items. |
| `eMake` | `IO Entity` | Create a new instance with the same options. |
| `eName` | `String` | The entity name. |

### Result shape

Entity operations return the bare result `Value` (a map for single-entity
ops, a list for `eList`) and raise on error. Wrap calls in
`Control.Exception.try` to handle failures.

The `direct` escape hatch never raises — it returns a result `Value`
you branch on via its `ok` field (read with `getp result "ok"`):

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Bool` | `True` if the HTTP status is 2xx. |
| `status` | `Int` | HTTP status code. |
| `headers` | `Value` | Response headers. |
| `data` | `Value` | Parsed JSON response body. |

On error, `ok` is `False` and `err` carries the error value.

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

Create an instance: `decrypt <- Sdk.decrypt sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eCreate ent data ctrl` | Create a new entity with the given data. |
| `eList ent match ctrl` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `code` | `Int` |  |
| `decrypted` | `[Value]` |  |
| `decryption_parameter` | `Value` |  |
| `encrypted` | `[Value]` |  |
| `failed` | `Bool` |  |
| `firmware` | `String` |  |
| `has_cc_data` | `Bool` |  |
| `message` | `String` |  |
| `message_id` | `String` |  |
| `name` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Bool` |  |
| `value` | `String` |  |

#### Example: List

```haskell
  ent <- Sdk.decrypt sdk VNoval
  match <- emptyMap
  ctrl <- emptyMap
  decrypts <- Sdk.eList ent match ctrl
```

#### Example: Create

```haskell
  ent <- Sdk.decrypt sdk VNoval
  d <- jo
    [ ("decryption_parameter", VNoval)   -- Value
    , ("encrypted", VNoval)   -- [Value]
    , ("has_cc_data", VBool True)   -- Bool
    , ("message_id", VStr "example_message_id")   -- String
    , ("name", VStr "example_name")   -- String
    , ("reference", VStr "example_reference")   -- String
    , ("serial", VStr "example_serial")   -- String
    , ("success", VBool True)   -- Bool
    ]
  ctrl <- emptyMap
  decrypt <- Sdk.eCreate ent d ctrl
```


### DecryptExt

Create an instance: `decrypt_ext <- Sdk.decrypt_ext sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eCreate ent data ctrl` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `completed` | `String` |  |
| `decrypted` | `Double` |  |
| `encrypted` | `Double` |  |
| `ip` | `String` |  |
| `message_id` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Bool` |  |

#### Example: Create

```haskell
  ent <- Sdk.decrypt_ext sdk VNoval
  d <- jo
    [ ("encrypted", VNum 1)   -- Double
    , ("partner_id", VStr "example_partner_id")   -- String
    , ("serial", VStr "example_serial")   -- String
    ]
  ctrl <- emptyMap
  decrypt_ext <- Sdk.eCreate ent d ctrl
```


### Validation

Create an instance: `validation <- Sdk.validation sdk VNoval`

#### Operations

| Method | Description |
| --- | --- |
| `eCreate ent data ctrl` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `String` |  |
| `firmware` | `String` |  |
| `message_id` | `String` |  |
| `partner_id` | `String` |  |
| `partner_key` | `String` |  |
| `reference` | `String` |  |
| `serial` | `String` |  |
| `success` | `Bool` |  |

#### Example: Create

```haskell
  ent <- Sdk.validation sdk VNoval
  d <- jo
    [ ("message_id", VStr "example_message_id")   -- String
    , ("reference", VStr "example_reference")   -- String
    , ("serial", VStr "example_serial")   -- String
    , ("success", VBool True)   -- Bool
    ]
  ctrl <- emptyMap
  validation <- Sdk.eCreate ent d ctrl
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

### Data as struct Values

The Haskell SDK models every API record as the dynamic `Value` type (from
the vendored `VoxgigStruct` module) rather than bespoke Haskell records.
This mirrors the dynamic nature of the API and keeps the SDK flexible — no
new datatypes or code generation are needed when the API schema changes.

Build request maps with `jo [(key, value)]` and read fields back with
`getp value "field"`; scalars are the `VStr` / `VNum` / `VBool`
constructors, and `VNoval` stands for an absent property.

### Module structure

```
haskell/
├── src/
│   ├── VoxgigStruct.hs   -- vendored dependency-free struct library (Value)
│   ├── Vregex.hs         -- vendored regex support
│   ├── SdkTypes.hs       -- core types (Client, Entity, Feature)
│   ├── SdkHelpers.hs     -- helper functions (jo, getp, ...)
│   ├── SdkRuntime.hs     -- the generic operation pipeline
│   ├── SdkFeatures.hs    -- built-in features + makeEntity
│   ├── SdkConfig.hs      -- generated API configuration + feature factory
│   └── SdkClient.hs      -- generated public client (newSdk, entity accessors)
├── test/                 -- test suites
├── Makefile              -- stock-GHC build/test (no third-party deps)
└── bluefindecryptx-sdk.cabal      -- package manifest (for Hackage)
```

The public module (`SdkClient`) exports the SDK constructors (`newSdk`,
`testSdk`) and one accessor per entity. Import `VoxgigStruct` for the
`Value` constructors and `SdkHelpers` for `jo` / `getp`.

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
