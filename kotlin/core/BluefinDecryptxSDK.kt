package voxgig.bluefindecryptxsdk.core

/**
 * BluefinDecryptx SDK client. All transport and pipeline behaviour lives in the
 * SdkClient base (core/SdkClient.kt); this class binds the API-specific
 * entity accessors and the test-mode constructor.
 */
class BluefinDecryptxSDK(options: MutableMap<String, Any?>?) : SdkClient(options) {

  constructor() : this(null)


  /**
   * Returns a decrypt entity bound to this client.
   * Idiomatic usage: client.decrypt(null).list(null, null) or
   * client.decrypt(null).load(mutableMapOf("id" to ...), null).
   */
  fun decrypt(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefindecryptxsdk.entity.DecryptEntity(this, entopts)
  }

  /**
   * Returns a decrypt_ext entity bound to this client.
   * Idiomatic usage: client.decryptExt(null).list(null, null) or
   * client.decryptExt(null).load(mutableMapOf("id" to ...), null).
   */
  fun decryptExt(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefindecryptxsdk.entity.DecryptExtEntity(this, entopts)
  }

  /**
   * Returns a validation entity bound to this client.
   * Idiomatic usage: client.validation(null).list(null, null) or
   * client.validation(null).load(mutableMapOf("id" to ...), null).
   */
  fun validation(entopts: MutableMap<String, Any?>?): SdkEntity {
    return voxgig.bluefindecryptxsdk.entity.ValidationEntity(this, entopts)
  }


  companion object {
    // testSDK builds a client in test mode: the test feature is activated,
    // installing the in-memory mock transport (no network activity).
    fun testSDK(): BluefinDecryptxSDK = testSDK(null, null)

    fun testSDK(
      testopts: MutableMap<String, Any?>?,
      sdkopts: MutableMap<String, Any?>?,
    ): BluefinDecryptxSDK {
      val sdk = BluefinDecryptxSDK(testOptions(testopts, sdkopts))
      sdk.mode = "test"
      return sdk
    }
  }
}
