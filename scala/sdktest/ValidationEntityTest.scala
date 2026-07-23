// Generated basic-flow test for the validation entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped ValidationTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefindecryptxsdk.core.{Helpers, BluefinDecryptxSDK}
import voxgig.bluefindecryptxsdk.utility.struct.Struct

object ValidationEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("validation.instance") {
      val testsdk = BluefinDecryptxSDK.testSDK()
      val ent = testsdk.validation(null)
      rep.check("validation.instance", ent != null, "expected non-null validation entity")
    }

    rep.scope("validation.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/validation/ValidationTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinDecryptxSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("validation01", "VALIDATION01")
      idmap.put("validation02", "VALIDATION02")
      idmap.put("validation03", "VALIDATION03")
      val now = System.currentTimeMillis()

      // CREATE
      val validationRef01Ent = client.validation(null)
      var validationRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.validation"), "validation_ref01"))
      val validationRef01DataResult = validationRef01Ent.create(validationRef01Data, null)
      validationRef01Data = Helpers.toMapAny(validationRef01DataResult)
      rep.check("validation.create.map", validationRef01Data != null, "expected create result to be a map")
    }
  }
}
