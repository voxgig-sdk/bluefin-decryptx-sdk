package voxgig.bluefindecryptxsdk.sdktest

import java.nio.file.Files
import java.nio.file.Paths

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assumptions
import org.junit.jupiter.api.Test

import voxgig.bluefindecryptxsdk.core.Helpers
import voxgig.bluefindecryptxsdk.core.SdkEntity
import voxgig.bluefindecryptxsdk.core.BluefinDecryptxSDK
import voxgig.bluefindecryptxsdk.utility.Json
import voxgig.bluefindecryptxsdk.utility.struct.Struct

@Suppress("UNCHECKED_CAST", "UNUSED_VARIABLE", "UNUSED_VALUE")
class DecryptExtEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinDecryptxSDK.testSDK()
    val ent = testsdk.decryptExt(null)
    assertNotNull(ent, "expected non-null decrypt_ext entity")
  }

  @Test
  fun basic() {
    val setup = decryptExtBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create")) {
      val reason = RunnerSupport.skipReason("entityOp", "decrypt_ext.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val decryptExtRef01Ent = client.decryptExt(null)
    var decryptExtRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.decrypt_ext"), "decrypt_ext_ref01")) ?: linkedMapOf())

    val decryptExtRef01DataResult = decryptExtRef01Ent.create(decryptExtRef01Data, null)
    decryptExtRef01Data = Helpers.toMapAny(decryptExtRef01DataResult) ?: linkedMapOf()
    assertNotNull(decryptExtRef01Data, "expected create result to be a map")

  }

  companion object {
    fun decryptExtBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "decrypt_ext", "DecryptExtTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read decrypt_ext test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinDecryptxSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("decrypt_ext01")
      idnames.add("decrypt_ext02")
      idnames.add("decrypt_ext03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"] = idmap
      envm["BLUEFINDECRYPTX_TEST_LIVE"] = "FALSE"
      envm["BLUEFINDECRYPTX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFINDECRYPTX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"])
      if (idmapResolved == null) {
        idmapResolved = Helpers.toMapAny(idmap) ?: linkedMapOf()
      }

      val live = "TRUE" == env["BLUEFINDECRYPTX_TEST_LIVE"]
      if (live) {
        val liveOpts = linkedMapOf<String, Any?>()
        liveOpts["apikey"] = env["BLUEFINDECRYPTX_APIKEY"]
        val mergedOpts = Struct.merge(Struct.jt(liveOpts, extra))
        client = BluefinDecryptxSDK(Helpers.toMapAny(mergedOpts))
      }

      val setup = RunnerSupport.EntityTestSetup()
      setup.client = client
      setup.data = entityData
      setup.idmap = idmapResolved
      setup.env = env
      setup.explain = "TRUE" == env["BLUEFINDECRYPTX_TEST_EXPLAIN"]
      setup.live = live
      setup.syntheticOnly = live && !idmapOverridden
      setup.now = System.currentTimeMillis()
      return setup
    }
  }
}
