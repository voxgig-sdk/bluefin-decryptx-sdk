package voxgig.bluefindecryptxsdk.core

// Typed reference models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These case classes are documentation/DX reference shapes ONLY. The SDK ops
// take and return the loose object model (java.util.Map[String, Object] /
// Object) at runtime, so these types are not wired into the op signatures —
// use them to describe a payload before converting it to a map. Every
// component is a boxed (nullable) type, so an optional (req:false) key needs
// no distinct rendering.

object BluefinDecryptxTypes {

  final case class Decrypt(client_id: String, code: java.lang.Long, decrypted: java.util.List[Object], decryption_parameter: java.util.Map[String, Object], encrypted: java.util.List[Object], failed: java.lang.Boolean, firmware: String, has_cc_data: java.lang.Boolean, message: String, message_id: String, name: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean, value: String)

  final case class DecryptListMatch(client_id: String, code: java.lang.Long, decrypted: java.util.List[Object], decryption_parameter: java.util.Map[String, Object], encrypted: java.util.List[Object], failed: java.lang.Boolean, firmware: String, has_cc_data: java.lang.Boolean, message: String, message_id: String, name: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean, value: String)

  final case class DecryptCreateData(client_id: String, code: java.lang.Long, decrypted: java.util.List[Object], decryption_parameter: java.util.Map[String, Object], encrypted: java.util.List[Object], failed: java.lang.Boolean, firmware: String, has_cc_data: java.lang.Boolean, message: String, message_id: String, name: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean, value: String)

  final case class DecryptExt(client_id: String, completed: String, decrypted: java.lang.Double, encrypted: java.lang.Double, ip: String, message_id: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean)

  final case class DecryptExtCreateData(client_id: String, completed: String, decrypted: java.lang.Double, encrypted: java.lang.Double, ip: String, message_id: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean)

  final case class Validation(client_id: String, firmware: String, message_id: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean)

  final case class ValidationCreateData(client_id: String, firmware: String, message_id: String, partner_id: String, partner_key: String, reference: String, serial: String, success: java.lang.Boolean)

}
