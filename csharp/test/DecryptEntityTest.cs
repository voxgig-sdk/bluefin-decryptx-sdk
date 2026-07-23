// decrypt entity test - basic flow (generated from the API model).

using System.Text.Json;

using Voxgig.Struct;
using Xunit;

namespace BluefinDecryptxSdk.Test;

public class DecryptEntityTest
{
    [Fact]
    public void Instance()
    {
        var testsdk = BluefinDecryptxSDK.TestSDK(null, null);
        var ent = testsdk.Decrypt();
        Assert.NotNull(ent);
    }

    [Fact]
    public void Basic()
    {
        var setup = DecryptBasicSetup(null);
        // Per-op sdk-test-control.json skip - basic test exercises a flow
        // with multiple ops; skipping any op skips the whole flow.
        var _mode = setup.Live ? "live" : "unit";
        foreach (var _op in new[] { "create", "list" })
        {
            var (_shouldSkip, _) = TestRunner.IsControlSkipped(
                "entityOp", "decrypt." + _op, _mode);
            if (_shouldSkip)
            {
                return; // skipped via sdk-test-control.json
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live
        // mode without an *_ENTID env override, those IDs hit the live API
        // and 4xx; set BLUEFINDECRYPTX_TEST_DECRYPT_ENTID JSON to run live.
        if (setup.SyntheticOnly)
        {
            return;
        }
        var client = setup.Client;

        // CREATE
        var decryptRef01Ent = client.Decrypt();
        var decryptRef01Data = Helpers.ToMapAny(StructUtils.GetProp(
            StructUtils.GetPath(setup.Data, StructUtils.Jt("new", "decrypt")),
            "decrypt_ref01"));

        var decryptRef01DataResult = decryptRef01Ent.Create(decryptRef01Data, null);
        decryptRef01Data = Helpers.ToMapAny(decryptRef01DataResult);
        Assert.True(decryptRef01Data != null, "expected create result to be a map");

        // LIST
        var decryptRef01Match = new Dictionary<string, object?>();

        var decryptRef01ListResult = decryptRef01Ent.List(decryptRef01Match, null);
        var decryptRef01List = decryptRef01ListResult as List<object?>;
        Assert.True(decryptRef01List != null,
            $"expected list result to be a list, got {decryptRef01ListResult?.GetType()}");

        var decryptRef01ListFound = StructUtils.Select(
            TestRunner.EntityListToData(decryptRef01List!),
            new Dictionary<string, object?> { ["id"] = decryptRef01Data!["id"] });
        Assert.False(StructUtils.IsEmpty(decryptRef01ListFound),
            "expected to find created entity in list");

    }

    [Fact]
    public async Task Stream()
    {
        var setup = DecryptBasicSetup(new Dictionary<string, object?>
        {
            ["feature"] = new Dictionary<string, object?>
            {
                ["streaming"] = new Dictionary<string, object?> { ["active"] = true },
            },
        });
        if (setup.Live)
        {
            return; // unit mode only - streams the seeded fixture data
        }

        var ent = setup.Client.Decrypt();
        var match = new Dictionary<string, object?>();

        // Materialised list result for the same op.
        var listed = ent.List(match, null) as List<object?> ?? new List<object?>();

        // stream("list") yields items via the streaming feature's iterator.
        var streamed = new List<object?>();
        await foreach (var item in ent.Stream("list", match, null))
        {
            streamed.Add(item);
        }
        Assert.True(streamed.Count > 0, "expected stream to yield items");
        Assert.Equal(listed.Count, streamed.Count);

        // Fallback: with streaming inactive, stream still yields the
        // materialised items.
        var setup2 = DecryptBasicSetup(null);
        var ent2 = setup2.Client.Decrypt();
        var streamed2 = new List<object?>();
        await foreach (var item in ent2.Stream("list", match, null))
        {
            streamed2.Add(item);
        }
        Assert.Equal(listed.Count, streamed2.Count);
    }

    private static EntityTestSetup DecryptBasicSetup(
        Dictionary<string, object?>? extra)
    {
        TestRunner.LoadEnvLocal();

        var entityDataFile = Path.Combine(TestRunner.TestDir(),
            "..", "..", ".sdk", "test", "entity", "decrypt",
            "DecryptTestData.json");

        var entityDataEl = JsonSerializer.Deserialize<JsonElement>(
            File.ReadAllText(entityDataFile));
        var entityData = StructRunner.ConvertElement(entityDataEl)
            as Dictionary<string, object?>
            ?? throw new InvalidOperationException(
                "failed to parse decrypt test data");

        var options = new Dictionary<string, object?>
        {
            ["entity"] = entityData["existing"],
        };

        var client = BluefinDecryptxSDK.TestSDK(options, extra);

        // Generate idmap via transform, matching the TS pattern.
        var idmap = StructUtils.Transform(
            new List<object?> { "decrypt01", "decrypt02", "decrypt03" },
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
            "BLUEFINDECRYPTX_TEST_DECRYPT_ENTID") ?? "";
        var idmapOverridden = entidEnvRaw != "" &&
            entidEnvRaw.Trim().StartsWith("{");

        var env = TestRunner.EnvOverride(new Dictionary<string, object?>
        {
            ["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"] = idmap,
            ["BLUEFINDECRYPTX_TEST_LIVE"] = "FALSE",
            ["BLUEFINDECRYPTX_TEST_EXPLAIN"] = "FALSE",
            ["BLUEFINDECRYPTX_APIKEY"] = "NONE",
        });

        var idmapResolved = Helpers.ToMapAny(env["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"])
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
