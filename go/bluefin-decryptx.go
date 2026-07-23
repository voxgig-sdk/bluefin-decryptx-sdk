package voxgigbluefindecryptxsdk

import (
	"github.com/voxgig-sdk/bluefin-decryptx-sdk/go/core"
	"github.com/voxgig-sdk/bluefin-decryptx-sdk/go/entity"
	"github.com/voxgig-sdk/bluefin-decryptx-sdk/go/feature"
	_ "github.com/voxgig-sdk/bluefin-decryptx-sdk/go/utility"
)

// Type aliases preserve external API.
type BluefinDecryptxSDK = core.BluefinDecryptxSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type BluefinDecryptxEntity = core.BluefinDecryptxEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type BluefinDecryptxError = core.BluefinDecryptxError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewDecryptEntityFunc = func(client *core.BluefinDecryptxSDK, entopts map[string]any) core.BluefinDecryptxEntity {
		return entity.NewDecryptEntity(client, entopts)
	}
	core.NewDecryptExtEntityFunc = func(client *core.BluefinDecryptxSDK, entopts map[string]any) core.BluefinDecryptxEntity {
		return entity.NewDecryptExtEntity(client, entopts)
	}
	core.NewValidationEntityFunc = func(client *core.BluefinDecryptxSDK, entopts map[string]any) core.BluefinDecryptxEntity {
		return entity.NewValidationEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewBluefinDecryptxSDK = core.NewBluefinDecryptxSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewBluefinDecryptxSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *BluefinDecryptxSDK  { return NewBluefinDecryptxSDK(nil) }
func Test() *BluefinDecryptxSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
