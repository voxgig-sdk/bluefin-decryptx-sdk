// Generated basic-flow test for the decrypt_ext entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped DecryptExtTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefindecryptxsdk.core.{Helpers, BluefinDecryptxSDK}
import voxgig.bluefindecryptxsdk.utility.struct.Struct

object DecryptExtEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("decrypt_ext.instance") {
      val testsdk = BluefinDecryptxSDK.testSDK()
      val ent = testsdk.decryptExt(null)
      rep.check("decrypt_ext.instance", ent != null, "expected non-null decrypt_ext entity")
    }

    rep.scope("decrypt_ext.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/decrypt_ext/DecryptExtTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinDecryptxSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("decrypt_ext01", "DECRYPT_EXT01")
      idmap.put("decrypt_ext02", "DECRYPT_EXT02")
      idmap.put("decrypt_ext03", "DECRYPT_EXT03")
      val now = System.currentTimeMillis()

      // CREATE
      val decryptExtRef01Ent = client.decryptExt(null)
      var decryptExtRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.decrypt_ext"), "decrypt_ext_ref01"))
      val decryptExtRef01DataResult = decryptExtRef01Ent.create(decryptExtRef01Data, null)
      decryptExtRef01Data = Helpers.toMapAny(decryptExtRef01DataResult)
      rep.check("decrypt_ext.create.map", decryptExtRef01Data != null, "expected create result to be a map")
    }
  }
}
