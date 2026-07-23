package voxgig.bluefindecryptxsdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;

import voxgig.bluefindecryptxsdk.core.Helpers;
import voxgig.bluefindecryptxsdk.core.SdkEntity;
import voxgig.bluefindecryptxsdk.core.BluefinDecryptxSDK;
import voxgig.bluefindecryptxsdk.utility.Json;
import voxgig.bluefindecryptxsdk.utility.struct.Struct;

@SuppressWarnings({"unchecked", "unused"})
public class DecryptEntityTest {

  @Test
  public void instance() {
    BluefinDecryptxSDK testsdk = BluefinDecryptxSDK.testSDK();
    SdkEntity ent = testsdk.decrypt(null);
    assertNotNull(ent, "expected non-null decrypt entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = decryptBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create", "list" }) {
      String reason = RunnerSupport.skipReason("entityOp", "decrypt." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_ENTID JSON to run live");
    BluefinDecryptxSDK client = setup.client;

    // CREATE
    SdkEntity decryptRef01Ent = client.decrypt(null);
    Map<String, Object> decryptRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.decrypt"), "decrypt_ref01"));

    Object decryptRef01DataResult = decryptRef01Ent.create(decryptRef01Data, null);
    decryptRef01Data = Helpers.toMapAny(decryptRef01DataResult);
    assertNotNull(decryptRef01Data, "expected create result to be a map");

    // LIST
    Map<String, Object> decryptRef01Match = new LinkedHashMap<>();

    Object decryptRef01ListResult = decryptRef01Ent.list(decryptRef01Match, null);
    assertTrue(decryptRef01ListResult instanceof List,
        "expected list result to be an array, got " + decryptRef01ListResult);
    List<Object> decryptRef01List = (List<Object>) decryptRef01ListResult;

    List<Object> foundItem = Struct.select(
        RunnerSupport.entityListToData(decryptRef01List),
        Struct.jm("id", decryptRef01Data.get("id")));
    assertFalse(Struct.isempty(foundItem), "expected to find created entity in list");

  }

  @Test
  public void stream() {
    Map<String, Object> streamingActive = new LinkedHashMap<>();
    Map<String, Object> streamingOpts = new LinkedHashMap<>();
    streamingOpts.put("active", true);
    Map<String, Object> featureOpts = new LinkedHashMap<>();
    featureOpts.put("streaming", streamingOpts);
    streamingActive.put("feature", featureOpts);

    RunnerSupport.EntityTestSetup setup = decryptBasicSetup(streamingActive);
    Assumptions.assumeFalse(setup.live,
        "stream test streams the seeded fixture data (unit mode only)");

    SdkEntity ent = setup.client.decrypt(null);
    Map<String, Object> match = new LinkedHashMap<>();

    // Materialised list result for the same op.
    Object listedResult = ent.list(match, null);
    List<Object> listed = listedResult instanceof List
        ? (List<Object>) listedResult : new ArrayList<>();

    // stream("list") yields items via the streaming feature's iterator.
    List<Object> streamed = ent.stream("list", match, null)
        .collect(Collectors.toList());
    assertTrue(streamed.size() > 0, "expected stream to yield items");
    assertEquals(listed.size(), streamed.size(),
        "expected stream to yield the same item count as list");

    // Fallback: with streaming inactive, stream still yields the
    // materialised items.
    RunnerSupport.EntityTestSetup setup2 = decryptBasicSetup(null);
    SdkEntity ent2 = setup2.client.decrypt(null);
    List<Object> streamed2 = ent2.stream("list", match, null)
        .collect(Collectors.toList());
    assertEquals(listed.size(), streamed2.size(),
        "expected fallback stream to yield the materialised items");
  }

  static RunnerSupport.EntityTestSetup decryptBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "decrypt", "DecryptTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read decrypt test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    BluefinDecryptxSDK client = BluefinDecryptxSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("decrypt01");
    idnames.add("decrypt02");
    idnames.add("decrypt03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("BLUEFINDECRYPTX_TEST_DECRYPT_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("BLUEFINDECRYPTX_TEST_DECRYPT_ENTID", idmap);
    envm.put("BLUEFINDECRYPTX_TEST_LIVE", "FALSE");
    envm.put("BLUEFINDECRYPTX_TEST_EXPLAIN", "FALSE");
    envm.put("BLUEFINDECRYPTX_APIKEY", "NONE");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"));
    if (idmapResolved == null) {
      idmapResolved = Helpers.toMapAny(idmap);
    }

    boolean live = "TRUE".equals(env.get("BLUEFINDECRYPTX_TEST_LIVE"));
    if (live) {
      Map<String, Object> liveOpts = new LinkedHashMap<>();
      liveOpts.put("apikey", env.get("BLUEFINDECRYPTX_APIKEY"));
      Object mergedOpts = Struct.merge(Struct.jt(liveOpts, extra));
      client = new BluefinDecryptxSDK(Helpers.toMapAny(mergedOpts));
    }

    RunnerSupport.EntityTestSetup setup = new RunnerSupport.EntityTestSetup();
    setup.client = client;
    setup.data = entityData;
    setup.idmap = idmapResolved;
    setup.env = env;
    setup.explain = "TRUE".equals(env.get("BLUEFINDECRYPTX_TEST_EXPLAIN"));
    setup.live = live;
    setup.syntheticOnly = live && !idmapOverridden;
    setup.now = System.currentTimeMillis();
    return setup;
  }
}
