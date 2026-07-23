package voxgig.bluefindecryptxsdk.core;

import java.util.Map;

/**
 * BluefinDecryptx SDK client. All transport and pipeline behaviour lives in
 * the SdkClient base (core/SdkClient.java); this class binds the
 * API-specific entity accessors and the test-mode constructor.
 */
public class BluefinDecryptxSDK extends SdkClient {

  public BluefinDecryptxSDK() {
    this(null);
  }

  public BluefinDecryptxSDK(Map<String, Object> options) {
    super(options);
  }


  /**
   * Returns a decrypt entity bound to this client.
   * Idiomatic usage: client.decrypt(null).list(null, null) or
   * client.decrypt(null).load(Map.of("id", ...), null).
   */
  public SdkEntity decrypt(Map<String, Object> entopts) {
    return new voxgig.bluefindecryptxsdk.entity.DecryptEntity(this, entopts);
  }

  /**
   * Returns a decrypt_ext entity bound to this client.
   * Idiomatic usage: client.decryptExt(null).list(null, null) or
   * client.decryptExt(null).load(Map.of("id", ...), null).
   */
  public SdkEntity decryptExt(Map<String, Object> entopts) {
    return new voxgig.bluefindecryptxsdk.entity.DecryptExtEntity(this, entopts);
  }

  /**
   * Returns a validation entity bound to this client.
   * Idiomatic usage: client.validation(null).list(null, null) or
   * client.validation(null).load(Map.of("id", ...), null).
   */
  public SdkEntity validation(Map<String, Object> entopts) {
    return new voxgig.bluefindecryptxsdk.entity.ValidationEntity(this, entopts);
  }


  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  public static BluefinDecryptxSDK testSDK() {
    return testSDK(null, null);
  }

  public static BluefinDecryptxSDK testSDK(
      Map<String, Object> testopts, Map<String, Object> sdkopts) {
    BluefinDecryptxSDK sdk = new BluefinDecryptxSDK(SdkClient.testOptions(testopts, sdkopts));
    sdk.mode = "test";
    return sdk;
  }
}
