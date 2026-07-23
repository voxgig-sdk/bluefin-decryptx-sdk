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
class ValidationEntityTest {

  @Test
  fun instance() {
    val testsdk = BluefinDecryptxSDK.testSDK()
    val ent = testsdk.validation(null)
    assertNotNull(ent, "expected non-null validation entity")
  }

  @Test
  fun basic() {
    val setup = validationBasicSetup(null)
    // Per-op sdk-test-control.json skip.
    val mode = if (setup.live) "live" else "unit"
    for (op in arrayOf("create")) {
      val reason = RunnerSupport.skipReason("entityOp", "validation.$op", mode)
      Assumptions.assumeTrue(
        reason == null,
        if (reason == null || "" == reason) "skipped via sdk-test-control.json" else reason,
      )
    }
    Assumptions.assumeFalse(
      setup.syntheticOnly,
      "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_VALIDATION_ENTID JSON to run live",
    )
    val client = setup.client

    // CREATE
    val validationRef01Ent = client.validation(null)
    var validationRef01Data: MutableMap<String, Any?> = (Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.validation"), "validation_ref01")) ?: linkedMapOf())

    val validationRef01DataResult = validationRef01Ent.create(validationRef01Data, null)
    validationRef01Data = Helpers.toMapAny(validationRef01DataResult) ?: linkedMapOf()
    assertNotNull(validationRef01Data, "expected create result to be a map")

  }

  companion object {
    fun validationBasicSetup(extra: MutableMap<String, Any?>?): RunnerSupport.EntityTestSetup {
      RunnerSupport.loadEnvLocal()

      val entityData: MutableMap<String, Any?>
      try {
        val entityDataSource = Files.readString(Paths.get(
            "..", ".sdk", "test", "entity", "validation", "ValidationTestData.json"))
        entityData = Helpers.toMapAny(Json.parse(entityDataSource)) ?: linkedMapOf()
      } catch (e: Exception) {
        throw AssertionError("failed to read validation test data: " + e.message, e)
      }

      val options = linkedMapOf<String, Any?>()
      options["entity"] = entityData["existing"]

      var client = BluefinDecryptxSDK.testSDK(options, extra)

      // Generate idmap via transform, matching TS pattern.
      val idnames = mutableListOf<Any?>()
      idnames.add("validation01")
      idnames.add("validation02")
      idnames.add("validation03")
      val idmap = Struct.transform(idnames, Json.parse(
          "{\"`\$PACK`\": [\"\", {" +
          "\"`\$KEY`\": \"`\$COPY`\"," +
          "\"`\$VAL`\": [\"`\$FORMAT`\", \"upper\", \"`\$COPY`\"]" +
          "}]}"))

      // Detect ENTID env override before envOverride consumes it.
      val entidEnvRaw = RunnerSupport.getenv("BLUEFINDECRYPTX_TEST_VALIDATION_ENTID")
      val idmapOverridden = entidEnvRaw != null && entidEnvRaw.trim().startsWith("{")

      val envm = linkedMapOf<String, Any?>()
      envm["BLUEFINDECRYPTX_TEST_VALIDATION_ENTID"] = idmap
      envm["BLUEFINDECRYPTX_TEST_LIVE"] = "FALSE"
      envm["BLUEFINDECRYPTX_TEST_EXPLAIN"] = "FALSE"
      envm["BLUEFINDECRYPTX_APIKEY"] = "NONE"
      val env = RunnerSupport.envOverride(envm)

      var idmapResolved = Helpers.toMapAny(env["BLUEFINDECRYPTX_TEST_VALIDATION_ENTID"])
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
