// BluefinDecryptx SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/types.hpp); this class binds the API-specific entity
// accessors and the test-mode constructor.

#ifndef SDK_CORE_CLIENT_HPP
#define SDK_CORE_CLIENT_HPP

#include <memory>

#include "../core/types.hpp"
#include "../entity/entities.hpp"

namespace sdk {

class BluefinDecryptxSDK : public SdkClient {
public:
  explicit BluefinDecryptxSDK(Value options = Value::undef()) : SdkClient(options) {}


  // Decrypt entity bound to this client.
  std::shared_ptr<DecryptEntity> decrypt(Value entopts = Value::undef()) {
    return std::make_shared<DecryptEntity>(this, entopts);
  }

  // DecryptExt entity bound to this client.
  std::shared_ptr<DecryptExtEntity> decrypt_ext(Value entopts = Value::undef()) {
    return std::make_shared<DecryptExtEntity>(this, entopts);
  }

  // Validation entity bound to this client.
  std::shared_ptr<ValidationEntity> validation(Value entopts = Value::undef()) {
    return std::make_shared<ValidationEntity>(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  static std::shared_ptr<BluefinDecryptxSDK> testSDK() {
    return testSDK(Value::undef(), Value::undef());
  }

  static std::shared_ptr<BluefinDecryptxSDK> testSDK(Value testopts, Value sdkopts) {
    auto sdk = std::make_shared<BluefinDecryptxSDK>(SdkClient::testOptions(testopts, sdkopts));
    sdk->mode = "test";
    return sdk;
  }

  // Convenience no-arg constructor.
  static std::shared_ptr<BluefinDecryptxSDK> create() {
    return std::make_shared<BluefinDecryptxSDK>(Value::undef());
  }
};

using BluefinDecryptxSDKPtr = std::shared_ptr<BluefinDecryptxSDK>;

} // namespace sdk

#endif // SDK_CORE_CLIENT_HPP
