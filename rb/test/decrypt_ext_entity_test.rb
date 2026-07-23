# DecryptExt entity test

require "minitest/autorun"
require "json"
require_relative "../BluefinDecryptx_sdk"
require_relative "runner"

class DecryptExtEntityTest < Minitest::Test
  def test_create_instance
    testsdk = BluefinDecryptxSDK.test(nil, nil)
    ent = testsdk.DecryptExt(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = decrypt_ext_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "decrypt_ext." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    decrypt_ext_ref01_ent = client.DecryptExt(nil)
    decrypt_ext_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.decrypt_ext"), "decrypt_ext_ref01"))

    decrypt_ext_ref01_data_result = decrypt_ext_ref01_ent.create(decrypt_ext_ref01_data, nil)
    decrypt_ext_ref01_data = Helpers.to_map(decrypt_ext_ref01_data_result)
    assert !decrypt_ext_ref01_data.nil?

  end
end

def decrypt_ext_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "decrypt_ext", "DecryptExtTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = BluefinDecryptxSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["decrypt_ext01", "decrypt_ext02", "decrypt_ext03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID" => idmap,
    "BLUEFINDECRYPTX_TEST_LIVE" => "FALSE",
    "BLUEFINDECRYPTX_TEST_EXPLAIN" => "FALSE",
    "BLUEFINDECRYPTX_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["BLUEFINDECRYPTX_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["BLUEFINDECRYPTX_APIKEY"],
      },
      extra || {},
    ])
    client = BluefinDecryptxSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["BLUEFINDECRYPTX_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["BLUEFINDECRYPTX_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
