// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return
// `voxgig_value*`), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support. This header is standalone
// and is not #included by any generated .c.

#ifndef BLUEFINDECRYPTX_ENTITY_TYPES_H
#define BLUEFINDECRYPTX_ENTITY_TYPES_H

#include "sdk.h"

// Decrypt is the typed data model for the decrypt entity.
typedef struct {
  char*client_id;  // optional
  int64_t code;  // optional
  voxgig_value*decrypted;  // optional
  voxgig_value*decryption_parameter;
  voxgig_value*encrypted;
  bool failed;  // optional
  char*firmware;  // optional
  bool has_cc_data;
  char*message;  // optional
  char*message_id;
  char*name;
  char*partner_id;  // optional
  char*partner_key;  // optional
  char*reference;
  char*serial;
  bool success;
  char*value;  // optional
} Decrypt;

// DecryptListMatch is the typed request payload for Decrypt.list.
typedef struct {
  char*client_id;  // optional
  int64_t code;  // optional
  voxgig_value*decrypted;  // optional
  voxgig_value*decryption_parameter;  // optional
  voxgig_value*encrypted;  // optional
  bool failed;  // optional
  char*firmware;  // optional
  bool has_cc_data;  // optional
  char*message;  // optional
  char*message_id;  // optional
  char*name;  // optional
  char*partner_id;  // optional
  char*partner_key;  // optional
  char*reference;  // optional
  char*serial;  // optional
  bool success;  // optional
  char*value;  // optional
} DecryptListMatch;

// DecryptCreateData is the typed request payload for Decrypt.create.
typedef struct {
  char*client_id;  // optional
  int64_t code;  // optional
  voxgig_value*decrypted;  // optional
  voxgig_value*decryption_parameter;
  voxgig_value*encrypted;
  bool failed;  // optional
  char*firmware;  // optional
  bool has_cc_data;
  char*message;  // optional
  char*message_id;
  char*name;
  char*partner_id;  // optional
  char*partner_key;  // optional
  char*reference;
  char*serial;
  bool success;
  char*value;  // optional
} DecryptCreateData;

// DecryptExt is the typed data model for the decrypt_ext entity.
typedef struct {
  char*client_id;  // optional
  char*completed;  // optional
  double decrypted;  // optional
  double encrypted;
  char*ip;  // optional
  char*message_id;  // optional
  char*partner_id;
  char*partner_key;  // optional
  char*reference;  // optional
  char*serial;
  bool success;  // optional
} DecryptExt;

// DecryptExtCreateData is the typed request payload for DecryptExt.create.
typedef struct {
  char*client_id;  // optional
  char*completed;  // optional
  double decrypted;  // optional
  double encrypted;
  char*ip;  // optional
  char*message_id;  // optional
  char*partner_id;
  char*partner_key;  // optional
  char*reference;  // optional
  char*serial;
  bool success;  // optional
} DecryptExtCreateData;

// Validation is the typed data model for the validation entity.
typedef struct {
  char*client_id;  // optional
  char*firmware;  // optional
  char*message_id;
  char*partner_id;  // optional
  char*partner_key;  // optional
  char*reference;
  char*serial;
  bool success;
} Validation;

// ValidationCreateData is the typed request payload for Validation.create.
typedef struct {
  char*client_id;  // optional
  char*firmware;  // optional
  char*message_id;
  char*partner_id;  // optional
  char*partner_key;  // optional
  char*reference;
  char*serial;
  bool success;
} ValidationCreateData;

#endif // BLUEFINDECRYPTX_ENTITY_TYPES_H
