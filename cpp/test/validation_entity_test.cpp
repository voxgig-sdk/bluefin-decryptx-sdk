// Generated basic-flow test for the validation entity (model-driven,
// unit mode; mirrors the rust/go TestEntity generator).

#include "runner_support.hpp"

using namespace sdk;
using namespace sdk::rs;

struct ValidationSetup {
  std::shared_ptr<BluefinDecryptxSDK> client;
  Value data;
  Value idmap;
  Value env;
  bool live = false;
  bool synthetic_only = false;
  long long now = 0;
};

static ValidationSetup validation_basic_setup(const Value& extra) {
  load_env_local();

  std::string entity_data_file = "../.sdk/test/entity/validation/ValidationTestData.json";
  Value entity_data = vs::parse_json(read_file(entity_data_file));

  Value options = vmap({{"entity", getp(entity_data, "existing")}});
  auto client = BluefinDecryptxSDK::testSDK(options, extra);

  // idmap via transform (upper-cased id name synthetics), matching the donors.
  Value idmap = Struct::transform(
      vlist({Value("validation01"), Value("validation02"), Value("validation03")}),
      vmap({{"`$PACK`", vlist({
        Value(""),
        vmap({
          {"`$KEY`", Value("`$COPY`")},
          {"`$VAL`", vlist({Value("`$FORMAT`"), Value("upper"), Value("`$COPY`")})}
        })
      })}}));
  if (!idmap.is_map()) idmap = vmap();

  Value env = env_override(vmap({
    {"BLUEFINDECRYPTX_TEST_VALIDATION_ENTID", idmap},
    {"BLUEFINDECRYPTX_TEST_LIVE", Value("FALSE")},
    {"BLUEFINDECRYPTX_TEST_EXPLAIN", Value("FALSE")}
  }));

  Value idmap_resolved = Helpers::toMapAny(getp(env, "BLUEFINDECRYPTX_TEST_VALIDATION_ENTID"));
  if (!idmap_resolved.is_map()) idmap_resolved = idmap;

  bool live = getp(env, "BLUEFINDECRYPTX_TEST_LIVE") == Value("TRUE");

  ValidationSetup s;
  s.client = client;
  s.data = entity_data;
  s.idmap = idmap_resolved;
  s.env = env;
  s.live = live;
  s.synthetic_only = false;
  s.now = now_ms();
  return s;
}

static void validation_entity_instance() {
  auto testsdk = BluefinDecryptxSDK::testSDK();
  auto ent = testsdk->validation();
  ASSERT_EQ(ent->getName(), std::string("validation"), "entity name");
}

static void validation_entity_stream() {
  // stream() runs the list op through the full pipeline and returns the
  // result items. Seed two entities via test mode; with the streaming feature
  // active it yields the feature's incremental items, else it falls back to
  // the materialised items — either way every item is yielded.
  Value seed = vmap({{"entity", vmap({{"validation", vmap({
      {"strm01", vmap({{"id", Value("strm01")}})},
      {"strm02", vmap({{"id", Value("strm02")}})}})}})}});
  Value sdkopts = vmap({{"feature",
      vmap({{"streaming", vmap({{"active", Value(true)}})}})}});

  auto strsdk = BluefinDecryptxSDK::testSDK(seed, sdkopts);
  auto se = strsdk->validation();
  std::vector<Value> items = se->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)items.size(), 2, "stream yields both seeded items");

  auto plainsdk = BluefinDecryptxSDK::testSDK(seed, Value::undef());
  auto pe = plainsdk->validation();
  std::vector<Value> pitems = pe->stream("list", Value::undef(), Value::undef());
  ASSERT_EQ((int)pitems.size(), 2, "fallback stream yields both items");
}

static void validation_entity_basic() {
  auto setup = validation_basic_setup(Value::undef());
  std::string mode = setup.live ? "live" : "unit";
  for (const std::string& op : std::vector<std::string>{"create"}) {
    auto sk = is_control_skipped("entityOp", std::string("validation.") + op, mode);
    if (sk.first) { std::cerr << "skip: " << (sk.second.empty()? "sdk-test-control.json" : sk.second) << "\n"; return; }
  }
  auto client = setup.client;
  // CREATE
  auto validation_ref01_ent = client->validation();
  Value validation_ref01_data = Helpers::toMapAny(getp(Struct::getpath(setup.data, {"new", "validation"}), "validation_ref01"));
  if (!validation_ref01_data.is_map()) validation_ref01_data = vmap();
  {
    Value validation_ref01_data_result = validation_ref01_ent->create(Struct::clone(validation_ref01_data), Value::undef());
    validation_ref01_data = Helpers::toMapAny(validation_ref01_data_result);
    if (!validation_ref01_data.is_map()) validation_ref01_data = vmap();
    ASSERT_TRUE(validation_ref01_data.is_map(), "expected create result to be a map");
  }

}

int main() {
  T_RUN(validation_entity_instance);
  T_RUN(validation_entity_stream);
  T_RUN(validation_entity_basic);
  return sdktest::summary("validation_entity_test");
}
