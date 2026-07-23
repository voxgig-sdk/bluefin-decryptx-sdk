// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.

import Foundation

/// Decrypt is the typed data model for the decrypt entity.
public struct Decrypt {
  public var clientId: String?
  public var code: Int?
  public var decrypted: [Value]?
  public var decryptionParameter: VMap
  public var encrypted: [Value]
  public var failed: Bool?
  public var firmware: String?
  public var hasCcData: Bool
  public var message: String?
  public var messageId: String
  public var name: String
  public var partnerId: String?
  public var partnerKey: String?
  public var reference: String
  public var serial: String
  public var success: Bool
  public var value: String?
}

/// DecryptListMatch is the typed request payload for Decrypt.list.
public struct DecryptListMatch {
  public var clientId: String?
  public var code: Int?
  public var decrypted: [Value]?
  public var decryptionParameter: VMap?
  public var encrypted: [Value]?
  public var failed: Bool?
  public var firmware: String?
  public var hasCcData: Bool?
  public var message: String?
  public var messageId: String?
  public var name: String?
  public var partnerId: String?
  public var partnerKey: String?
  public var reference: String?
  public var serial: String?
  public var success: Bool?
  public var value: String?
}

/// DecryptCreateData is the typed request payload for Decrypt.create.
public struct DecryptCreateData {
  public var clientId: String?
  public var code: Int?
  public var decrypted: [Value]?
  public var decryptionParameter: VMap
  public var encrypted: [Value]
  public var failed: Bool?
  public var firmware: String?
  public var hasCcData: Bool
  public var message: String?
  public var messageId: String
  public var name: String
  public var partnerId: String?
  public var partnerKey: String?
  public var reference: String
  public var serial: String
  public var success: Bool
  public var value: String?
}

/// DecryptExt is the typed data model for the decrypt_ext entity.
public struct DecryptExt {
  public var clientId: String?
  public var completed: String?
  public var decrypted: Double?
  public var encrypted: Double
  public var ip: String?
  public var messageId: String?
  public var partnerId: String
  public var partnerKey: String?
  public var reference: String?
  public var serial: String
  public var success: Bool?
}

/// DecryptExtCreateData is the typed request payload for DecryptExt.create.
public struct DecryptExtCreateData {
  public var clientId: String?
  public var completed: String?
  public var decrypted: Double?
  public var encrypted: Double
  public var ip: String?
  public var messageId: String?
  public var partnerId: String
  public var partnerKey: String?
  public var reference: String?
  public var serial: String
  public var success: Bool?
}

/// Validation is the typed data model for the validation entity.
public struct Validation {
  public var clientId: String?
  public var firmware: String?
  public var messageId: String
  public var partnerId: String?
  public var partnerKey: String?
  public var reference: String
  public var serial: String
  public var success: Bool
}

/// ValidationCreateData is the typed request payload for Validation.create.
public struct ValidationCreateData {
  public var clientId: String?
  public var firmware: String?
  public var messageId: String
  public var partnerId: String?
  public var partnerKey: String?
  public var reference: String
  public var serial: String
  public var success: Bool
}

