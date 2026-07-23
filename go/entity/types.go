// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Decrypt is the typed data model for the decrypt entity.
type Decrypt struct {
	ClientId *string `json:"client_id,omitempty"`
	Code *int `json:"code,omitempty"`
	Decrypted *[]any `json:"decrypted,omitempty"`
	DecryptionParameter map[string]any `json:"decryption_parameter"`
	Encrypted []any `json:"encrypted"`
	Failed *bool `json:"failed,omitempty"`
	Firmware *string `json:"firmware,omitempty"`
	HasCcData bool `json:"has_cc_data"`
	Message *string `json:"message,omitempty"`
	MessageId string `json:"message_id"`
	Name string `json:"name"`
	PartnerId *string `json:"partner_id,omitempty"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference string `json:"reference"`
	Serial string `json:"serial"`
	Success bool `json:"success"`
	Value *string `json:"value,omitempty"`
}

// DecryptListMatch is the typed request payload for Decrypt.ListTyped.
type DecryptListMatch struct {
	ClientId *string `json:"client_id,omitempty"`
	Code *int `json:"code,omitempty"`
	Decrypted *[]any `json:"decrypted,omitempty"`
	DecryptionParameter *map[string]any `json:"decryption_parameter,omitempty"`
	Encrypted *[]any `json:"encrypted,omitempty"`
	Failed *bool `json:"failed,omitempty"`
	Firmware *string `json:"firmware,omitempty"`
	HasCcData *bool `json:"has_cc_data,omitempty"`
	Message *string `json:"message,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	Name *string `json:"name,omitempty"`
	PartnerId *string `json:"partner_id,omitempty"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Serial *string `json:"serial,omitempty"`
	Success *bool `json:"success,omitempty"`
	Value *string `json:"value,omitempty"`
}

// DecryptCreateData is the typed request payload for Decrypt.CreateTyped.
type DecryptCreateData struct {
	ClientId *string `json:"client_id,omitempty"`
	Code *int `json:"code,omitempty"`
	Decrypted *[]any `json:"decrypted,omitempty"`
	DecryptionParameter map[string]any `json:"decryption_parameter"`
	Encrypted []any `json:"encrypted"`
	Failed *bool `json:"failed,omitempty"`
	Firmware *string `json:"firmware,omitempty"`
	HasCcData bool `json:"has_cc_data"`
	Message *string `json:"message,omitempty"`
	MessageId string `json:"message_id"`
	Name string `json:"name"`
	PartnerId *string `json:"partner_id,omitempty"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference string `json:"reference"`
	Serial string `json:"serial"`
	Success bool `json:"success"`
	Value *string `json:"value,omitempty"`
}

// DecryptExt is the typed data model for the decrypt_ext entity.
type DecryptExt struct {
	ClientId *string `json:"client_id,omitempty"`
	Completed *string `json:"completed,omitempty"`
	Decrypted *float64 `json:"decrypted,omitempty"`
	Encrypted float64 `json:"encrypted"`
	Ip *string `json:"ip,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	PartnerId string `json:"partner_id"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Serial string `json:"serial"`
	Success *bool `json:"success,omitempty"`
}

// DecryptExtCreateData is the typed request payload for DecryptExt.CreateTyped.
type DecryptExtCreateData struct {
	ClientId *string `json:"client_id,omitempty"`
	Completed *string `json:"completed,omitempty"`
	Decrypted *float64 `json:"decrypted,omitempty"`
	Encrypted float64 `json:"encrypted"`
	Ip *string `json:"ip,omitempty"`
	MessageId *string `json:"message_id,omitempty"`
	PartnerId string `json:"partner_id"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference *string `json:"reference,omitempty"`
	Serial string `json:"serial"`
	Success *bool `json:"success,omitempty"`
}

// Validation is the typed data model for the validation entity.
type Validation struct {
	ClientId *string `json:"client_id,omitempty"`
	Firmware *string `json:"firmware,omitempty"`
	MessageId string `json:"message_id"`
	PartnerId *string `json:"partner_id,omitempty"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference string `json:"reference"`
	Serial string `json:"serial"`
	Success bool `json:"success"`
}

// ValidationCreateData is the typed request payload for Validation.CreateTyped.
type ValidationCreateData struct {
	ClientId *string `json:"client_id,omitempty"`
	Firmware *string `json:"firmware,omitempty"`
	MessageId string `json:"message_id"`
	PartnerId *string `json:"partner_id,omitempty"`
	PartnerKey *string `json:"partner_key,omitempty"`
	Reference string `json:"reference"`
	Serial string `json:"serial"`
	Success bool `json:"success"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
