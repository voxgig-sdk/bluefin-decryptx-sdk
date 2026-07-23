package voxgig.bluefindecryptxsdk.core

import java.util.{Map => JMap}

// BluefinDecryptx SDK client. All transport and pipeline behaviour lives in the
// SdkClient base (core/SdkClient.scala); this class binds the API-specific
// entity accessors and the test-mode constructor.
class BluefinDecryptxSDK(options: JMap[String, Object]) extends SdkClient(options) {

  def this() = this(null)


  /**
   * Returns a decrypt entity bound to this client.
   * Idiomatic usage: client.decrypt(null).list(null, null) or
   * client.decrypt(null).load(java.util.Map.of("id", ...), null).
   */
  def decrypt(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefindecryptxsdk.entity.DecryptEntity(this, entopts)

  /**
   * Returns a decrypt_ext entity bound to this client.
   * Idiomatic usage: client.decryptExt(null).list(null, null) or
   * client.decryptExt(null).load(java.util.Map.of("id", ...), null).
   */
  def decryptExt(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefindecryptxsdk.entity.DecryptExtEntity(this, entopts)

  /**
   * Returns a validation entity bound to this client.
   * Idiomatic usage: client.validation(null).list(null, null) or
   * client.validation(null).load(java.util.Map.of("id", ...), null).
   */
  def validation(entopts: java.util.Map[String, Object]): SdkEntity =
    new voxgig.bluefindecryptxsdk.entity.ValidationEntity(this, entopts)


}

object BluefinDecryptxSDK {

  // testSDK builds a client in test mode: the test feature is activated,
  // installing the in-memory mock transport (no network activity).
  def testSDK(): BluefinDecryptxSDK = testSDK(null, null)

  def testSDK(testopts: JMap[String, Object], sdkopts: JMap[String, Object]): BluefinDecryptxSDK = {
    val sdk = new BluefinDecryptxSDK(SdkClient.testOptions(testopts, sdkopts))
    sdk.mode = "test"
    sdk
  }
}
