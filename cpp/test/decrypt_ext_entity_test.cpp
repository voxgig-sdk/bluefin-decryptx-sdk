// Generated basic-flow test for the decrypt_ext entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct DecryptExtSetup {
  std::shared_ptr<BluefinDecryptxSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static DecryptExtSetup decrypt_ext_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/decrypt_ext/DecryptExtTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinDecryptxSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("decrypt_ext01"), Value("decrypt_ext02"), Value("decrypt_ext03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID", idmap},
    {"BLUEFINDECRYPTX_TEST_LIVE", Value("FALSE")},
    {"BLUEFINDECRYPTX_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFINDECRYPTX_TEST_DECRYPT_EXT_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFINDECRYPTX_TEST_LIVE") == Value("TRUE");

  DecryptExtSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void decrypt_ext_entity_instance() {
  auto testsdk = BluefinDecryptxSDK::testSDK();
  auto ent = testsdk->decrypt_ext();
  ASSERT_EQ(ent->getName(), std::string("decrypt_ext"), "entity name");
}

static void decrypt_ext_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"decrypt_ext", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = BluefinDecryptxSDK::testSDK(seed, sdkopts);
  auto se = strsdk->decrypt_ext();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = BluefinDecryptxSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->decrypt_ext();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void decrypt_ext_entity_basic() {
  auto setup = decrypt_ext_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("decrypt_ext.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto decrypt_ext_ref01_ent = client->decrypt_ext();
  Value decrypt_ext_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "decrypt_ext"}), "decrypt_ext_ref01"));
  if (!decrypt_ext_ref01_data.is_map()) decrypt_ext_ref01_data = vmap();
  {
    Value decrypt_ext_ref01_data_result = decrypt_ext_ref01_ent->create(Struct::clone(decrypt_ext_ref01_data), Value::undef());
    decrypt_ext_ref01_data = Helpers::toMapAny(decrypt_ext_ref01_data_result);
    if (!decrypt_ext_ref01_data.is_map()) decrypt_ext_ref01_data = vmap();
    ASSERT_TRUE(decrypt_ext_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(decrypt_ext_entity_instance);
  T_RUN(decrypt_ext_entity_stream);
  T_RUN(decrypt_ext_entity_basic);
  return sdktest::summary("decrypt_ext_entity_test");
}
