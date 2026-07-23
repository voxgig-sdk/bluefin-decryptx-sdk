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
public class ValidationEntityTest {

  @Test
  public void instance() {
    BluefinDecryptxSDK testsdk = BluefinDecryptxSDK.testSDK();
    SdkEntity ent = testsdk.validation(null);
    assertNotNull(ent, "expected non-null validation entity");
  }

  @Test
  public void basic() {
    RunnerSupport.EntityTestSetup setup = validationBasicSetup(null);
    // Per-op sdk-test-control.json skip — basic test exercises a flow
    // with multiple ops; skipping any op skips the whole flow.
    String mode = setup.live ? "live" : "unit";
    for (String op : new String[] { "create" }) {
      String reason = RunnerSupport.skipReason("entityOp", "validation." + op, mode);
      Assumptions.assumeTrue(reason == null,
          reason == null || "".equals(reason)
              ? "skipped via sdk-test-control.json" : reason);
    }
    // The basic flow consumes synthetic IDs from the fixture. In live mode
    // without an *_ENTID env override, those IDs hit the live API and 4xx.
    Assumptions.assumeFalse(setup.syntheticOnly,
        "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_VALIDATION_ENTID JSON to run live");
    BluefinDecryptxSDK client = setup.client;

    // CREATE
    SdkEntity validationRef01Ent = client.validation(null);
    Map<String, Object> validationRef01Data = Helpers.toMapAny(Struct.getprop(
        Struct.getpath(setup.data, "new.validation"), "validation_ref01"));

    Object validationRef01DataResult = validationRef01Ent.create(validationRef01Data, null);
    validationRef01Data = Helpers.toMapAny(validationRef01DataResult);
    assertNotNull(validationRef01Data, "expected create result to be a map");

  }

  static RunnerSupport.EntityTestSetup validationBasicSetup(Map<String, Object> extra) {
    RunnerSupport.loadEnvLocal();

    Map<String, Object> entityData;
    try {
      String entityDataSource = Files.readString(Path.of(
          "..", ".sdk", "test", "entity", "validation", "ValidationTestData.json"));
      entityData = Helpers.toMapAny(Json.parse(entityDataSource));
    }
    catch (Exception e) {
      throw new AssertionError("failed to read validation test data: " + e.getMessage(), e);
    }

    Map<String, Object> options = new LinkedHashMap<>();
    options.put("entity", entityData.get("existing"));

    BluefinDecryptxSDK client = BluefinDecryptxSDK.testSDK(options, extra);

    // Generate idmap via transform, matching TS pattern.
    List<Object> idnames = new ArrayList<>();
    idnames.add("validation01");
    idnames.add("validation02");
    idnames.add("validation03");
    Object idmap = Struct.transform(idnames, Json.parse(
        "{\"`$PACK`\": [\"\", {"
        + "\"`$KEY`\": \"`$COPY`\","
        + "\"`$VAL`\": [\"`$FORMAT`\", \"upper\", \"`$COPY`\"]"
        + "}]}"));

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against
    // synthetic IDs from the fixture and 4xx's. Surface this so the test
    // can skip.
    String entidEnvRaw = RunnerSupport.getenv("BLUEFINDECRYPTX_TEST_VALIDATION_ENTID");
    boolean idmapOverridden = entidEnvRaw != null
        && entidEnvRaw.trim().startsWith("{");

    Map<String, Object> envm = new LinkedHashMap<>();
    envm.put("BLUEFINDECRYPTX_TEST_VALIDATION_ENTID", idmap);
    envm.put("BLUEFINDECRYPTX_TEST_LIVE", "FALSE");
    envm.put("BLUEFINDECRYPTX_TEST_EXPLAIN", "FALSE");
    envm.put("BLUEFINDECRYPTX_APIKEY", "NONE");
    Map<String, Object> env = RunnerSupport.envOverride(envm);

    Map<String, Object> idmapResolved = Helpers.toMapAny(env.get("BLUEFINDECRYPTX_TEST_VALIDATION_ENTID"));
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
