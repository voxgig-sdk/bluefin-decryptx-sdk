// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.
#![allow(dead_code, non_snake_case, unused_imports)]

use crate::utility::voxgigstruct::Value;

/// Decrypt is the typed data model for the decrypt entity.
#[derive(Debug, Clone)]
pub struct Decrypt {
    pub client_id: Option<String>,
    pub code: Option<i64>,
    pub decrypted: Option<Vec<Value>>,
    pub decryption_parameter: std::collections::HashMap<String, Value>,
    pub encrypted: Vec<Value>,
    pub failed: Option<bool>,
    pub firmware: Option<String>,
    pub has_cc_data: bool,
    pub message: Option<String>,
    pub message_id: String,
    pub name: String,
    pub partner_id: Option<String>,
    pub partner_key: Option<String>,
    pub reference: String,
    pub serial: String,
    pub success: bool,
    pub value: Option<String>,
}

/// DecryptListMatch is the typed request payload for Decrypt.list.
#[derive(Debug, Clone)]
pub struct DecryptListMatch {
    pub client_id: Option<String>,
    pub code: Option<i64>,
    pub decrypted: Option<Vec<Value>>,
    pub decryption_parameter: Option<std::collections::HashMap<String, Value>>,
    pub encrypted: Option<Vec<Value>>,
    pub failed: Option<bool>,
    pub firmware: Option<String>,
    pub has_cc_data: Option<bool>,
    pub message: Option<String>,
    pub message_id: Option<String>,
    pub name: Option<String>,
    pub partner_id: Option<String>,
    pub partner_key: Option<String>,
    pub reference: Option<String>,
    pub serial: Option<String>,
    pub success: Option<bool>,
    pub value: Option<String>,
}

/// DecryptCreateData is the typed request payload for Decrypt.create.
#[derive(Debug, Clone)]
pub struct DecryptCreateData {
    pub client_id: Option<String>,
    pub code: Option<i64>,
    pub decrypted: Option<Vec<Value>>,
    pub decryption_parameter: std::collections::HashMap<String, Value>,
    pub encrypted: Vec<Value>,
    pub failed: Option<bool>,
    pub firmware: Option<String>,
    pub has_cc_data: bool,
    pub message: Option<String>,
    pub message_id: String,
    pub name: String,
    pub partner_id: Option<String>,
    pub partner_key: Option<String>,
    pub reference: String,
    pub serial: String,
    pub success: bool,
    pub value: Option<String>,
}

/// DecryptExt is the typed data model for the decrypt_ext entity.
#[derive(Debug, Clone)]
pub struct DecryptExt {
    pub client_id: Option<String>,
    pub completed: Option<String>,
    pub decrypted: Option<f64>,
    pub encrypted: f64,
    pub ip: Option<String>,
    pub message_id: Option<String>,
    pub partner_id: String,
    pub partner_key: Option<String>,
    pub reference: Option<String>,
    pub serial: String,
    pub success: Option<bool>,
}

/// DecryptExtCreateData is the typed request payload for DecryptExt.create.
#[derive(Debug, Clone)]
pub struct DecryptExtCreateData {
    pub client_id: Option<String>,
    pub completed: Option<String>,
    pub decrypted: Option<f64>,
    pub encrypted: f64,
    pub ip: Option<String>,
    pub message_id: Option<String>,
    pub partner_id: String,
    pub partner_key: Option<String>,
    pub reference: Option<String>,
    pub serial: String,
    pub success: Option<bool>,
}

/// Validation is the typed data model for the validation entity.
#[derive(Debug, Clone)]
pub struct Validation {
    pub client_id: Option<String>,
    pub firmware: Option<String>,
    pub message_id: String,
    pub partner_id: Option<String>,
    pub partner_key: Option<String>,
    pub reference: String,
    pub serial: String,
    pub success: bool,
}

/// ValidationCreateData is the typed request payload for Validation.create.
#[derive(Debug, Clone)]
pub struct ValidationCreateData {
    pub client_id: Option<String>,
    pub firmware: Option<String>,
    pub message_id: String,
    pub partner_id: Option<String>,
    pub partner_key: Option<String>,
    pub reference: String,
    pub serial: String,
    pub success: bool,
}

