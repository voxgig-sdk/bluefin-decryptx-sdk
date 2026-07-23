# BluefinDecryptx Golang SDK



The Golang SDK for the BluefinDecryptx API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Decrypt(nil)` — each with the same small set of operations (`List`, `Create`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/bluefin-decryptx-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/bluefin-decryptx-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/bluefin-decryptx-sdk/go=../bluefin-decryptx-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/bluefin-decryptx-sdk/go"
)

func main() {
    client := sdk.NewBluefinDecryptxSDK(map[string]any{
        "apikey": os.Getenv("BLUEFIN_DECRYPTX_APIKEY"),
    })

    // List decrypt records — the value is the array of records itself.
    decrypts, err := client.Decrypt(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }
    for _, item := range decrypts.([]any) {
        fmt.Println(item)
    }

    // Create a decrypt.
    created, err := client.Decrypt(nil).Create(map[string]any{"decryption_parameter": map[string]any{}, "encrypted": []any{}, "has_cc_data": true, "message_id": "example_message_id", "name": "example_name", "reference": "example_reference", "serial": "example_serial", "success": true}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(created)
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
decrypts, err := client.Decrypt(nil).List(nil, nil)
if err != nil {
    // handle err
    return
}
_ = decrypts
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

decrypt, err := client.Decrypt(nil).List(
    nil, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(decrypt) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewBluefinDecryptxSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
    },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
BLUEFIN_DECRYPTX_TEST_LIVE=TRUE
BLUEFIN_DECRYPTX_APIKEY=<your-key>
```

Then run:

```bash
cd go && go test ./test/...
```


## Reference

### NewBluefinDecryptxSDK

```go
func NewBluefinDecryptxSDK(options map[string]any) *BluefinDecryptxSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *BluefinDecryptxSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### BluefinDecryptxSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Decrypt` | `(data map[string]any) BluefinDecryptxEntity` | Create a Decrypt entity instance. |
| `DecryptExt` | `(data map[string]any) BluefinDecryptxEntity` | Create a DecryptExt entity instance. |
| `Validation` | `(data map[string]any) BluefinDecryptxEntity` | Create a Validation entity instance. |

### Entity interface (BluefinDecryptxEntity)

All entities implement the `BluefinDecryptxEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Create` | the entity record (`map[string]any`) |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    decrypt, err := client.Decrypt(nil).List(map[string]any{/* fields */}, nil)
    if err != nil { /* handle */ }
    // decrypt is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Decrypt

| Field | Description |
| --- | --- |
| `"client_id"` |  |
| `"code"` |  |
| `"decrypted"` |  |
| `"decryption_parameter"` |  |
| `"encrypted"` |  |
| `"failed"` |  |
| `"firmware"` |  |
| `"has_cc_data"` |  |
| `"message"` |  |
| `"message_id"` |  |
| `"name"` |  |
| `"partner_id"` |  |
| `"partner_key"` |  |
| `"reference"` |  |
| `"serial"` |  |
| `"success"` |  |
| `"value"` |  |

Operations: Create, List.

API path: `/decrypt`

#### DecryptExt

| Field | Description |
| --- | --- |
| `"client_id"` |  |
| `"completed"` |  |
| `"decrypted"` |  |
| `"encrypted"` |  |
| `"ip"` |  |
| `"message_id"` |  |
| `"partner_id"` |  |
| `"partner_key"` |  |
| `"reference"` |  |
| `"serial"` |  |
| `"success"` |  |

Operations: Create.

API path: `/decrypt-ext`

#### Validation

| Field | Description |
| --- | --- |
| `"client_id"` |  |
| `"firmware"` |  |
| `"message_id"` |  |
| `"partner_id"` |  |
| `"partner_key"` |  |
| `"reference"` |  |
| `"serial"` |  |
| `"success"` |  |

Operations: Create.

API path: `/device/validate`



## Entities


### Decrypt

Create an instance: `decrypt := client.Decrypt(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `string` |  |
| `code` | `int` |  |
| `decrypted` | `[]any` |  |
| `decryption_parameter` | `map[string]any` |  |
| `encrypted` | `[]any` |  |
| `failed` | `bool` |  |
| `firmware` | `string` |  |
| `has_cc_data` | `bool` |  |
| `message` | `string` |  |
| `message_id` | `string` |  |
| `name` | `string` |  |
| `partner_id` | `string` |  |
| `partner_key` | `string` |  |
| `reference` | `string` |  |
| `serial` | `string` |  |
| `success` | `bool` |  |
| `value` | `string` |  |

#### Example: List

```go
decrypts, err := client.Decrypt(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(decrypts) // the array of records
```

#### Example: Create

```go
result, err := client.Decrypt(nil).Create(map[string]any{
    "decryption_parameter": map[string]any{},
    "encrypted": []any{},
    "has_cc_data": true,
    "message_id": "example_message_id",
    "name": "example_name",
    "reference": "example_reference",
    "serial": "example_serial",
    "success": true,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### DecryptExt

Create an instance: `decryptExt := client.DecryptExt(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `client_id` | `string` |  |
| `completed` | `string` |  |
| `decrypted` | `float64` |  |
| `encrypted` | `float64` |  |
| `ip` | `string` |  |
| `message_id` | `string` |  |
| `partner_id` | `string` |  |
| `partner_key` | `string` |  |
| `reference` | `string` |  |
| `serial` | `string` |  |
| `success` | `bool` |  |

#### Example: Create

```go
result, err := client.DecryptExt(nil).Create(map[string]any{
    "encrypted": 1,
    "partner_id": "example_partner_id",
    "serial": "example_serial",
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Validation

Create an instance: `validation := client.Validation(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Create(data, ctrl)` | Create a new entity with the given data. |

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
| `success` | `bool` |  |

#### Example: Create

```go
result, err := client.Validation(nil).Create(map[string]any{
    "message_id": "example_message_id",
    "reference": "example_reference",
    "serial": "example_serial",
    "success": true,
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/bluefin-decryptx-sdk/go/
├── bluefin-decryptx.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/bluefin-decryptx-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `List`, the entity
stores the returned data and match criteria internally.

```go
decrypt := client.Decrypt(nil)
decrypt.List(nil, nil)

// decrypt.Data() now returns the decrypt data from the last list
// decrypt.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
