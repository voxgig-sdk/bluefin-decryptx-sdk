<?php
declare(strict_types=1);

// DecryptExt entity test

require_once __DIR__ . '/../bluefindecryptx_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class DecryptExtEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = BluefinDecryptxSDK::test(null, null);
        $ent = $testsdk->DecryptExt(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = decrypt_ext_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "decrypt_ext." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $decrypt_ext_ref01_ent = $client->DecryptExt(null);
        $decrypt_ext_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.decrypt_ext"), "decrypt_ext_ref01"));

        $decrypt_ext_ref01_data_result = $decrypt_ext_ref01_ent->create($decrypt_ext_ref01_data, null);
        $decrypt_ext_ref01_data = Helpers::to_map($decrypt_ext_ref01_data_result);
        $this->assertNotNull($decrypt_ext_ref01_data);

    }
}

function decrypt_ext_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/decrypt_ext/DecryptExtTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = BluefinDecryptxSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["decrypt_ext01", "decrypt_ext02", "decrypt_ext03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID" => $idmap,
        "BLUEFINDECRYPTX_TEST_LIVE" => "FALSE",
        "BLUEFINDECRYPTX_TEST_EXPLAIN" => "FALSE",
        "BLUEFINDECRYPTX_APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["BLUEFINDECRYPTX_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["BLUEFINDECRYPTX_APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new BluefinDecryptxSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["BLUEFINDECRYPTX_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["BLUEFINDECRYPTX_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
