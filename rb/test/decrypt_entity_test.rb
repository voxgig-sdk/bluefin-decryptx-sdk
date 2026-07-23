# Decrypt entity test

require "minitest/autorun"
require "json"
require_relative "../BluefinDecryptx_sdk"
require_relative "runner"

class DecryptEntityTest < Minitest::Test
  def test_create_instance
    testsdk = BluefinDecryptxSDK.test(nil, nil)
    ent = testsdk.Decrypt(nil)
    assert !ent.nil?
  end

  # Feature #4: the entity stream(action, ...) method runs the op pipeline and
  # returns an Enumerator over result items. With the streaming feature active
  # it yields the feature's incremental output; otherwise it falls back to the
  # materialised list so stream always yields.
  def test_stream
    seed = {
      "entity" => {
        "decrypt" => {
          "s1" => { "id" => "s1" },
          "s2" => { "id" => "s2" },
          "s3" => { "id" => "s3" },
        },
      },
    }

    # Fallback: streaming inactive -> yields the materialised list items.
    base = BluefinDecryptxSDK.test(seed, nil)
    seen = base.Decrypt(nil).stream("list", nil, nil).to_a
    assert_equal 3, seen.length

    # Inbound: streaming active -> yields each item from the feature.
    cfg = BluefinDecryptxConfig.make_config
    if cfg["feature"].is_a?(Hash) && cfg["feature"].key?("streaming")
      sdk = BluefinDecryptxSDK.test(seed, { "feature" => { "streaming" => { "active" => true } } })
      got = []
      sdk.Decrypt(nil).stream("list", nil, nil).each do |item|
        if item.is_a?(Array)
          got.concat(item)
        else
          got << item
        end
      end
      assert_equal 3, got.length
    end
  end

  def test_basic_flow
    setup = decrypt_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["create", "list"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "decrypt." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set BLUEFINDECRYPTX_TEST_DECRYPT_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # CREATE
    decrypt_ref01_ent = client.Decrypt(nil)
    decrypt_ref01_data = Helpers.to_map(Vs.getprop(
      Vs.getpath(setup[:data], "new.decrypt"), "decrypt_ref01"))

    decrypt_ref01_data_result = decrypt_ref01_ent.create(decrypt_ref01_data, nil)
    decrypt_ref01_data = Helpers.to_map(decrypt_ref01_data_result)
    assert !decrypt_ref01_data.nil?

    # LIST
    decrypt_ref01_match = {}

    decrypt_ref01_list_result = decrypt_ref01_ent.list(decrypt_ref01_match, nil)
    assert decrypt_ref01_list_result.is_a?(Array)

  end
end

def decrypt_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "decrypt", "DecryptTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = BluefinDecryptxSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["decrypt01", "decrypt02", "decrypt03"],
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
  entid_env_raw = ENV["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "BLUEFINDECRYPTX_TEST_DECRYPT_ENTID" => idmap,
    "BLUEFINDECRYPTX_TEST_LIVE" => "FALSE",
    "BLUEFINDECRYPTX_TEST_EXPLAIN" => "FALSE",
    "BLUEFINDECRYPTX_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["BLUEFINDECRYPTX_TEST_DECRYPT_ENTID"])
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
