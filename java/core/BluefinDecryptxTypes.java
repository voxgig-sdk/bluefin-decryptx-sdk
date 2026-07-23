package voxgig.bluefindecryptxsdk.core;

// Typed reference models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Map<String, Object> / Object) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a boxed (nullable)
// type, so an optional (req:false) key needs no distinct rendering.

import java.util.List;
import java.util.Map;

public final class BluefinDecryptxTypes {

  private BluefinDecryptxTypes() {}

  public record Decrypt(String client_id, Long code, List<Object> decrypted, Map<String, Object> decryption_parameter, List<Object> encrypted, Boolean failed, String firmware, Boolean has_cc_data, String message, String message_id, String name, String partner_id, String partner_key, String reference, String serial, Boolean success, String value) {}

  public record DecryptListMatch(String client_id, Long code, List<Object> decrypted, Map<String, Object> decryption_parameter, List<Object> encrypted, Boolean failed, String firmware, Boolean has_cc_data, String message, String message_id, String name, String partner_id, String partner_key, String reference, String serial, Boolean success, String value) {}

  public record DecryptCreateData(String client_id, Long code, List<Object> decrypted, Map<String, Object> decryption_parameter, List<Object> encrypted, Boolean failed, String firmware, Boolean has_cc_data, String message, String message_id, String name, String partner_id, String partner_key, String reference, String serial, Boolean success, String value) {}

  public record DecryptExt(String client_id, String completed, Double decrypted, Double encrypted, String ip, String message_id, String partner_id, String partner_key, String reference, String serial, Boolean success) {}

  public record DecryptExtCreateData(String client_id, String completed, Double decrypted, Double encrypted, String ip, String message_id, String partner_id, String partner_key, String reference, String serial, Boolean success) {}

  public record Validation(String client_id, String firmware, String message_id, String partner_id, String partner_key, String reference, String serial, Boolean success) {}

  public record ValidationCreateData(String client_id, String firmware, String message_id, String partner_id, String partner_key, String reference, String serial, Boolean success) {}

}
