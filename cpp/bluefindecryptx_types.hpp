// Typed reference models for the BluefinDecryptx SDK (C++).
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params. The C++ SDK runtime is Value-based, so these structs are
// DOCUMENTATION / convenience types only — the SDK neither includes nor
// requires this header. Array fields surface as std::vector<Value>, object
// fields as std::map<std::string, Value>, and any/null fields as sdk::Value.
// Optional (req:false) members are flagged with a trailing "// optional"
// comment. Do not edit by hand.

#ifndef SDK_BLUEFINDECRYPTX_TYPES_HPP
#define SDK_BLUEFINDECRYPTX_TYPES_HPP

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "core/types.hpp"

namespace sdk {
namespace types {

struct Decrypt {
  std::string client_id;  // optional
  int64_t code;  // optional
  std::vector<Value> decrypted;  // optional
  std::map<std::string, Value> decryption_parameter;
  std::vector<Value> encrypted;
  bool failed;  // optional
  std::string firmware;  // optional
  bool has_cc_data;
  std::string message;  // optional
  std::string message_id;
  std::string name;
  std::string partner_id;  // optional
  std::string partner_key;  // optional
  std::string reference;
  std::string serial;
  bool success;
  std::string value;  // optional
};

struct DecryptListMatch {
  std::string client_id;  // optional
  int64_t code;  // optional
  std::vector<Value> decrypted;  // optional
  std::map<std::string, Value> decryption_parameter;  // optional
  std::vector<Value> encrypted;  // optional
  bool failed;  // optional
  std::string firmware;  // optional
  bool has_cc_data;  // optional
  std::string message;  // optional
  std::string message_id;  // optional
  std::string name;  // optional
  std::string partner_id;  // optional
  std::string partner_key;  // optional
  std::string reference;  // optional
  std::string serial;  // optional
  bool success;  // optional
  std::string value;  // optional
};

struct DecryptCreateData {
  std::string client_id;  // optional
  int64_t code;  // optional
  std::vector<Value> decrypted;  // optional
  std::map<std::string, Value> decryption_parameter;
  std::vector<Value> encrypted;
  bool failed;  // optional
  std::string firmware;  // optional
  bool has_cc_data;
  std::string message;  // optional
  std::string message_id;
  std::string name;
  std::string partner_id;  // optional
  std::string partner_key;  // optional
  std::string reference;
  std::string serial;
  bool success;
  std::string value;  // optional
};

struct DecryptExt {
  std::string client_id;  // optional
  std::string completed;  // optional
  double decrypted;  // optional
  double encrypted;
  std::string ip;  // optional
  std::string message_id;  // optional
  std::string partner_id;
  std::string partner_key;  // optional
  std::string reference;  // optional
  std::string serial;
  bool success;  // optional
};

struct DecryptExtCreateData {
  std::string client_id;  // optional
  std::string completed;  // optional
  double decrypted;  // optional
  double encrypted;
  std::string ip;  // optional
  std::string message_id;  // optional
  std::string partner_id;
  std::string partner_key;  // optional
  std::string reference;  // optional
  std::string serial;
  bool success;  // optional
};

struct Validation {
  std::string client_id;  // optional
  std::string firmware;  // optional
  std::string message_id;
  std::string partner_id;  // optional
  std::string partner_key;  // optional
  std::string reference;
  std::string serial;
  bool success;
};

struct ValidationCreateData {
  std::string client_id;  // optional
  std::string firmware;  // optional
  std::string message_id;
  std::string partner_id;  // optional
  std::string partner_key;  // optional
  std::string reference;
  std::string serial;
  bool success;
};

} // namespace types
} // namespace sdk

#endif // SDK_BLUEFINDECRYPTX_TYPES_HPP
