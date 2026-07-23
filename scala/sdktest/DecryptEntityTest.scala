// Generated basic-flow test for the decrypt entity (model-driven;
// mirrors the java TestEntity generator). A dependency-free scala-cli test
// object driven by SdkEntityTestMain. Runs against the in-memory test
// transport seeded with the shipped DecryptTestData.json fixtures.

import java.util.{ArrayList, LinkedHashMap, List => JList, Map => JMap}

import voxgig.bluefindecryptxsdk.core.{Helpers, BluefinDecryptxSDK}
import voxgig.bluefindecryptxsdk.utility.struct.Struct

object DecryptEntityTest {

  def run(rep: SdkTestReport): Unit = {
    rep.scope("decrypt.instance") {
      val testsdk = BluefinDecryptxSDK.testSDK()
      val ent = testsdk.decrypt(null)
      rep.check("decrypt.instance", ent != null, "expected non-null decrypt entity")
    }

    rep.scope("decrypt.basic") {
      val entityData = Helpers.toMapAny(SdkTestSupport.readJson(
          "../.sdk/test/entity/decrypt/DecryptTestData.json"))
      val options = new LinkedHashMap[String, Object]()
      options.put("entity", entityData.get("existing"))
      val client = BluefinDecryptxSDK.testSDK(options, null)

      val idmap = new LinkedHashMap[String, Object]()
      idmap.put("decrypt01", "DECRYPT01")
      idmap.put("decrypt02", "DECRYPT02")
      idmap.put("decrypt03", "DECRYPT03")
      val now = System.currentTimeMillis()

      // CREATE
      val decryptRef01Ent = client.decrypt(null)
      var decryptRef01Data = Helpers.toMapAny(Struct.getprop(
          Struct.getpath(entityData, "new.decrypt"), "decrypt_ref01"))
      val decryptRef01DataResult = decryptRef01Ent.create(decryptRef01Data, null)
      decryptRef01Data = Helpers.toMapAny(decryptRef01DataResult)
      rep.check("decrypt.create.map", decryptRef01Data != null, "expected create result to be a map")

      // LIST
      val decryptRef01Match = new LinkedHashMap[String, Object]()
      val decryptRef01ListResult = decryptRef01Ent.list(decryptRef01Match, null)
      rep.check("decrypt.list.islist", decryptRef01ListResult.isInstanceOf[JList[?]], "expected list result to be an array, got " + decryptRef01ListResult)
    }
  }
}
