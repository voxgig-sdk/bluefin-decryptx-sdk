package voxgig.bluefindecryptxsdk.core

// Typed reference models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These types are documentation/DX reference shapes ONLY. The SDK ops take and
// return the loose object model (MutableMap<String, Any?> / Any?) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a nullable type, so
// an optional (req:false) key needs no distinct rendering.

@Suppress("unused")
object BluefinDecryptxTypes {

  data class Decrypt(val client_id: String?, val code: Long?, val decrypted: List<Any?>?, val decryption_parameter: Map<String, Any?>?, val encrypted: List<Any?>?, val failed: Boolean?, val firmware: String?, val has_cc_data: Boolean?, val message: String?, val message_id: String?, val name: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?, val value: String?)

  data class DecryptListMatch(val client_id: String?, val code: Long?, val decrypted: List<Any?>?, val decryption_parameter: Map<String, Any?>?, val encrypted: List<Any?>?, val failed: Boolean?, val firmware: String?, val has_cc_data: Boolean?, val message: String?, val message_id: String?, val name: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?, val value: String?)

  data class DecryptCreateData(val client_id: String?, val code: Long?, val decrypted: List<Any?>?, val decryption_parameter: Map<String, Any?>?, val encrypted: List<Any?>?, val failed: Boolean?, val firmware: String?, val has_cc_data: Boolean?, val message: String?, val message_id: String?, val name: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?, val value: String?)

  data class DecryptExt(val client_id: String?, val completed: String?, val decrypted: Double?, val encrypted: Double?, val ip: String?, val message_id: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?)

  data class DecryptExtCreateData(val client_id: String?, val completed: String?, val decrypted: Double?, val encrypted: Double?, val ip: String?, val message_id: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?)

  data class Validation(val client_id: String?, val firmware: String?, val message_id: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?)

  data class ValidationCreateData(val client_id: String?, val firmware: String?, val message_id: String?, val partner_id: String?, val partner_key: String?, val reference: String?, val serial: String?, val success: Boolean?)

}
