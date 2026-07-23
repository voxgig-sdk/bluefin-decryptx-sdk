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
class DecryptEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinDecryptxSDK.testSDK()
    val ent = testsdk.decrypt(null)
    assertNotNull(ent, "expected non-null decrypt entity")
  }

  @Test
  fun basic() {
    val setup = decryptBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create", "list")) {
      val reason = RunnerSupport.skipReason("entityOp", "decrypt.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val decryptRef01Ent = client.decrypt(null)
    var decryptRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.decrypt"), "decrypt_ref01")) ?: linkedMapOf())

    val decryptRef01DataResult = decryptRef01Ent.create(decryptRef01Data, null)
    decryptRef01Data = Helpers.toMapAny(decryptRef01DataResult) ?: linkedMapOf()
    assertNotNull(decryptRef01Data, "expected create result to be a map")

    // LIST
    val decryptRef01Match = linkedMapOf<String, Any?>()

    val decryptRef01ListResult = decryptRef01Ent.list(decryptRef01Match, null)
    assertTrue(decryptRef01ListResult is List<*>,
        "expected list result to be an array, got " + decryptRef01ListResult)
    val decryptRef01List = decryptRef01ListResult as List<Any?>

    val foundItem = Struct.select(
        RunnerSupport.entityListToData(decryptRef01List),
        Struct.jm("id", decryptRef01Data["id"]))
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list")

  }

  @Test
  fun stream() {
    val streamingActive = linkedMapOf<String, Any?>(
      "feature" to linkedMapOf<String, Any?>(
        "streaming" to linkedMapOf<String, Any?>("active" to true),
      ),
    )
    val setup = decryptBasicSetup(streamingActive)
    Assumptions.assumeFalse(
      setup.live,
      "stream test streams the seeded fixture data (unit mode only)",
    )

    val ent = setup.client.decrypt(null)
    val match = linkedMapOf<String, Any?>()

    // Materialised list result for the same op.
    val listedResult = ent.list(match, null)
    val listed = (listedResult as? List<Any?>) ?: emptyList<Any?>()

    // stream("list") yields items via the streaming feature's iterator.
    val streamed = ent.stream("list", match, null).toList()
    assertTrue(streamed.size > 0, "expected stream to yield items")
    assertEquals(listed.size, streamed.size, "expected stream to match list count")

    // Fallback: with streaming inactive, stream still yields the materialised
    // items.
    val setup2 = decryptBasicSetup(null)
    val ent2 = setup2.client.decrypt(null)
    val streamed2 = ent2.stream("list", match, null).toList()
    assertEquals(listed.size, streamed2.size, "expected fallback stream to match list")
  }

  companion object {
    fun decryptBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "decrypt", "DecryptTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read decrypt test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinDecryptxSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("decrypt01")
      idnames.add("decrypt02")
      idnames.add("decrypt03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFINDECRYPTX_TEST_DECRYPT_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"] = idmap
      envm["BLUEFINDECRYPTX_TEST_LIVE"] = "FALSE"
      envm["BLUEFINDECRYPTX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFINDECRYPTX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"])
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
