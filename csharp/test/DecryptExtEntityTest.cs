// decrypt_ext entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace BluefinDecryptxSdk.Test;

public class DecryptExtEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = BluefinDecryptxSDK.TestSDK(null, null);
        var ent = testsdk.DecryptExt();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = DecryptExtBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "decrypt_ext." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var decryptExtRef01Ent = client.DecryptExt();
        var decryptExtRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "decrypt_ext")),
            "decrypt_ext_ref01"));

        var decryptExtRef01DataResult = decryptExtRef01Ent.Create(decryptExtRef01Data, null);
        decryptExtRef01Data = Helpers.ToMapAny(decryptExtRef01DataResult);
        Assert.True(decryptExtRef01Data != null, "expected create result to be a map");

    }

    private static EntityTestSetup DecryptExtBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "decrypt_ext",
            "DecryptExtTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse decrypt_ext test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = BluefinDecryptxSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "decrypt_ext01", "decrypt_ext02", "decrypt_ext03" },
            new Dictionary<string, object?>
            {
                ["`$PACK`"] = new List<object?>
                {
                    "",
                    new Dictionary<string, object?>
                    {
                        ["`$KEY`"] = "`$COPY`",
                        ["`$VAL`"] = new List<object?> { "`$FORMAT`", "upper", "`$COPY`" },
                    },
                },
            });

        // Detect ENTID env override before EnvOverride consumes it. When
        // live mode is on without a real override, the basic test runs
        // against synthetic IDs from the fixture and 4xx's.
        var entidEnvRaw = Environment.GetEnvironmentVariable(
            "BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"] = idmap,
            ["BLUEFINDECRYPTX_TEST_LIVE"] = "FALSE",
            ["BLUEFINDECRYPTX_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFINDECRYPTX_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"])
            ?? Helpers.ToMapAny(idmap)
            ?? new Dictionary<string, object?>();

        if (Equals(env["BLUEFINDECRYPTX_TEST_LIVE"], "TRUE"))
        {
            var mergedOpts = StructUtils.Merge(new List<object?>
            {
                new Dictionary<string, object?>
                {
                    ["apikey"] = env["BLUEFINDECRYPTX_APIKEY"],
                },
                extra,
            });
            client = new BluefinDecryptxSDK(Helpers.ToMapAny(mergedOpts));
        }

        var live = Equals(env["BLUEFINDECRYPTX_TEST_LIVE"], "TRUE");
        return new EntityTestSetup
        {
            Client = client,
            Data = entityData,
            Idmap = idmapResolved,
            Env = env,
            Explain = Equals(env["BLUEFINDECRYPTX_TEST_EXPLAIN"], "TRUE"),
            Live = live,
            SyntheticOnly = live && !idmapOverridden,
            Now = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds(),
        };
    }
}
