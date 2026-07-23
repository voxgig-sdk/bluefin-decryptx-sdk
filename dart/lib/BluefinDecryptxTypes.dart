// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON).
// Do not edit by hand.
//
// The operation pipeline passes plain maps; these classes are the typed,
// convertible view: `BluefinDecryptx.fromMap(ent.data())` / `model.toMap()`.

class Decrypt {
  /// STRING
  String? client_id;
  /// INTEGER
  int? code;
  /// ARRAY
  List<dynamic>? decrypted;
  /// OBJECT (required at the API)
  Map<String, dynamic>? decryption_parameter;
  /// ARRAY (required at the API)
  List<dynamic>? encrypted;
  /// BOOLEAN
  bool? failed;
  /// STRING
  String? firmware;
  /// BOOLEAN (required at the API)
  bool? has_cc_data;
  /// STRING
  String? message;
  /// STRING (required at the API)
  String? message_id;
  /// STRING (required at the API)
  String? name;
  /// STRING
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING (required at the API)
  String? reference;
  /// STRING (required at the API)
  String? serial;
  /// BOOLEAN (required at the API)
  bool? success;
  /// STRING
  String? value;

  Decrypt({
    this.client_id,
    this.code,
    this.decrypted,
    this.decryption_parameter,
    this.encrypted,
    this.failed,
    this.firmware,
    this.has_cc_data,
    this.message,
    this.message_id,
    this.name,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
    this.value,
  });

  factory Decrypt.fromMap(Map<String, dynamic> m) => Decrypt(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        code: m['code'] is int ? m['code'] : null,
        decrypted: m['decrypted'] is List<dynamic> ? m['decrypted'] : null,
        decryption_parameter: m['decryption_parameter'] is Map<String, dynamic> ? m['decryption_parameter'] : null,
        encrypted: m['encrypted'] is List<dynamic> ? m['encrypted'] : null,
        failed: m['failed'] is bool ? m['failed'] : null,
        firmware: m['firmware'] is String ? m['firmware'] : null,
        has_cc_data: m['has_cc_data'] is bool ? m['has_cc_data'] : null,
        message: m['message'] is String ? m['message'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
        value: m['value'] is String ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != code) {
      m['code'] = code;
    }
    if (null != decrypted) {
      m['decrypted'] = decrypted;
    }
    if (null != decryption_parameter) {
      m['decryption_parameter'] = decryption_parameter;
    }
    if (null != encrypted) {
      m['encrypted'] = encrypted;
    }
    if (null != failed) {
      m['failed'] = failed;
    }
    if (null != firmware) {
      m['firmware'] = firmware;
    }
    if (null != has_cc_data) {
      m['has_cc_data'] = has_cc_data;
    }
    if (null != message) {
      m['message'] = message;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class DecryptListMatch {
  /// STRING
  String? client_id;
  /// INTEGER
  int? code;
  /// ARRAY
  List<dynamic>? decrypted;
  /// OBJECT
  Map<String, dynamic>? decryption_parameter;
  /// ARRAY
  List<dynamic>? encrypted;
  /// BOOLEAN
  bool? failed;
  /// STRING
  String? firmware;
  /// BOOLEAN
  bool? has_cc_data;
  /// STRING
  String? message;
  /// STRING
  String? message_id;
  /// STRING
  String? name;
  /// STRING
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING
  String? reference;
  /// STRING
  String? serial;
  /// BOOLEAN
  bool? success;
  /// STRING
  String? value;

  DecryptListMatch({
    this.client_id,
    this.code,
    this.decrypted,
    this.decryption_parameter,
    this.encrypted,
    this.failed,
    this.firmware,
    this.has_cc_data,
    this.message,
    this.message_id,
    this.name,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
    this.value,
  });

  factory DecryptListMatch.fromMap(Map<String, dynamic> m) => DecryptListMatch(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        code: m['code'] is int ? m['code'] : null,
        decrypted: m['decrypted'] is List<dynamic> ? m['decrypted'] : null,
        decryption_parameter: m['decryption_parameter'] is Map<String, dynamic> ? m['decryption_parameter'] : null,
        encrypted: m['encrypted'] is List<dynamic> ? m['encrypted'] : null,
        failed: m['failed'] is bool ? m['failed'] : null,
        firmware: m['firmware'] is String ? m['firmware'] : null,
        has_cc_data: m['has_cc_data'] is bool ? m['has_cc_data'] : null,
        message: m['message'] is String ? m['message'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
        value: m['value'] is String ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != code) {
      m['code'] = code;
    }
    if (null != decrypted) {
      m['decrypted'] = decrypted;
    }
    if (null != decryption_parameter) {
      m['decryption_parameter'] = decryption_parameter;
    }
    if (null != encrypted) {
      m['encrypted'] = encrypted;
    }
    if (null != failed) {
      m['failed'] = failed;
    }
    if (null != firmware) {
      m['firmware'] = firmware;
    }
    if (null != has_cc_data) {
      m['has_cc_data'] = has_cc_data;
    }
    if (null != message) {
      m['message'] = message;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class DecryptCreateData {
  /// STRING
  String? client_id;
  /// INTEGER
  int? code;
  /// ARRAY
  List<dynamic>? decrypted;
  /// OBJECT (required at the API)
  Map<String, dynamic>? decryption_parameter;
  /// ARRAY (required at the API)
  List<dynamic>? encrypted;
  /// BOOLEAN
  bool? failed;
  /// STRING
  String? firmware;
  /// BOOLEAN (required at the API)
  bool? has_cc_data;
  /// STRING
  String? message;
  /// STRING (required at the API)
  String? message_id;
  /// STRING (required at the API)
  String? name;
  /// STRING
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING (required at the API)
  String? reference;
  /// STRING (required at the API)
  String? serial;
  /// BOOLEAN (required at the API)
  bool? success;
  /// STRING
  String? value;

  DecryptCreateData({
    this.client_id,
    this.code,
    this.decrypted,
    this.decryption_parameter,
    this.encrypted,
    this.failed,
    this.firmware,
    this.has_cc_data,
    this.message,
    this.message_id,
    this.name,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
    this.value,
  });

  factory DecryptCreateData.fromMap(Map<String, dynamic> m) => DecryptCreateData(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        code: m['code'] is int ? m['code'] : null,
        decrypted: m['decrypted'] is List<dynamic> ? m['decrypted'] : null,
        decryption_parameter: m['decryption_parameter'] is Map<String, dynamic> ? m['decryption_parameter'] : null,
        encrypted: m['encrypted'] is List<dynamic> ? m['encrypted'] : null,
        failed: m['failed'] is bool ? m['failed'] : null,
        firmware: m['firmware'] is String ? m['firmware'] : null,
        has_cc_data: m['has_cc_data'] is bool ? m['has_cc_data'] : null,
        message: m['message'] is String ? m['message'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        name: m['name'] is String ? m['name'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
        value: m['value'] is String ? m['value'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != code) {
      m['code'] = code;
    }
    if (null != decrypted) {
      m['decrypted'] = decrypted;
    }
    if (null != decryption_parameter) {
      m['decryption_parameter'] = decryption_parameter;
    }
    if (null != encrypted) {
      m['encrypted'] = encrypted;
    }
    if (null != failed) {
      m['failed'] = failed;
    }
    if (null != firmware) {
      m['firmware'] = firmware;
    }
    if (null != has_cc_data) {
      m['has_cc_data'] = has_cc_data;
    }
    if (null != message) {
      m['message'] = message;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != name) {
      m['name'] = name;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    if (null != value) {
      m['value'] = value;
    }
    return m;
  }
}

class DecryptExt {
  /// STRING
  String? client_id;
  /// STRING
  String? completed;
  /// NUMBER
  num? decrypted;
  /// NUMBER (required at the API)
  num? encrypted;
  /// STRING
  String? ip;
  /// STRING
  String? message_id;
  /// STRING (required at the API)
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? serial;
  /// BOOLEAN
  bool? success;

  DecryptExt({
    this.client_id,
    this.completed,
    this.decrypted,
    this.encrypted,
    this.ip,
    this.message_id,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
  });

  factory DecryptExt.fromMap(Map<String, dynamic> m) => DecryptExt(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        completed: m['completed'] is String ? m['completed'] : null,
        decrypted: m['decrypted'] is num ? m['decrypted'] : null,
        encrypted: m['encrypted'] is num ? m['encrypted'] : null,
        ip: m['ip'] is String ? m['ip'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != completed) {
      m['completed'] = completed;
    }
    if (null != decrypted) {
      m['decrypted'] = decrypted;
    }
    if (null != encrypted) {
      m['encrypted'] = encrypted;
    }
    if (null != ip) {
      m['ip'] = ip;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    return m;
  }
}

class DecryptExtCreateData {
  /// STRING
  String? client_id;
  /// STRING
  String? completed;
  /// NUMBER
  num? decrypted;
  /// NUMBER (required at the API)
  num? encrypted;
  /// STRING
  String? ip;
  /// STRING
  String? message_id;
  /// STRING (required at the API)
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING
  String? reference;
  /// STRING (required at the API)
  String? serial;
  /// BOOLEAN
  bool? success;

  DecryptExtCreateData({
    this.client_id,
    this.completed,
    this.decrypted,
    this.encrypted,
    this.ip,
    this.message_id,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
  });

  factory DecryptExtCreateData.fromMap(Map<String, dynamic> m) => DecryptExtCreateData(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        completed: m['completed'] is String ? m['completed'] : null,
        decrypted: m['decrypted'] is num ? m['decrypted'] : null,
        encrypted: m['encrypted'] is num ? m['encrypted'] : null,
        ip: m['ip'] is String ? m['ip'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != completed) {
      m['completed'] = completed;
    }
    if (null != decrypted) {
      m['decrypted'] = decrypted;
    }
    if (null != encrypted) {
      m['encrypted'] = encrypted;
    }
    if (null != ip) {
      m['ip'] = ip;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    return m;
  }
}

class Validation {
  /// STRING
  String? client_id;
  /// STRING
  String? firmware;
  /// STRING (required at the API)
  String? message_id;
  /// STRING
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING (required at the API)
  String? reference;
  /// STRING (required at the API)
  String? serial;
  /// BOOLEAN (required at the API)
  bool? success;

  Validation({
    this.client_id,
    this.firmware,
    this.message_id,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
  });

  factory Validation.fromMap(Map<String, dynamic> m) => Validation(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        firmware: m['firmware'] is String ? m['firmware'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != firmware) {
      m['firmware'] = firmware;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    return m;
  }
}

class ValidationCreateData {
  /// STRING
  String? client_id;
  /// STRING
  String? firmware;
  /// STRING (required at the API)
  String? message_id;
  /// STRING
  String? partner_id;
  /// STRING
  String? partner_key;
  /// STRING (required at the API)
  String? reference;
  /// STRING (required at the API)
  String? serial;
  /// BOOLEAN (required at the API)
  bool? success;

  ValidationCreateData({
    this.client_id,
    this.firmware,
    this.message_id,
    this.partner_id,
    this.partner_key,
    this.reference,
    this.serial,
    this.success,
  });

  factory ValidationCreateData.fromMap(Map<String, dynamic> m) => ValidationCreateData(
        client_id: m['client_id'] is String ? m['client_id'] : null,
        firmware: m['firmware'] is String ? m['firmware'] : null,
        message_id: m['message_id'] is String ? m['message_id'] : null,
        partner_id: m['partner_id'] is String ? m['partner_id'] : null,
        partner_key: m['partner_key'] is String ? m['partner_key'] : null,
        reference: m['reference'] is String ? m['reference'] : null,
        serial: m['serial'] is String ? m['serial'] : null,
        success: m['success'] is bool ? m['success'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != client_id) {
      m['client_id'] = client_id;
    }
    if (null != firmware) {
      m['firmware'] = firmware;
    }
    if (null != message_id) {
      m['message_id'] = message_id;
    }
    if (null != partner_id) {
      m['partner_id'] = partner_id;
    }
    if (null != partner_key) {
      m['partner_key'] = partner_key;
    }
    if (null != reference) {
      m['reference'] = reference;
    }
    if (null != serial) {
      m['serial'] = serial;
    }
    if (null != success) {
      m['success'] = success;
    }
    return m;
  }
}

