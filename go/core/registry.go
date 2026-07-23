package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewDecryptEntityFunc func(client *BluefinDecryptxSDK, entopts map[string]any) BluefinDecryptxEntity

var NewDecryptExtEntityFunc func(client *BluefinDecryptxSDK, entopts map[string]any) BluefinDecryptxEntity

var NewValidationEntityFunc func(client *BluefinDecryptxSDK, entopts map[string]any) BluefinDecryptxEntity

