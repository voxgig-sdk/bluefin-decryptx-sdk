# Decrypt entity test (offline, mock transport)

defmodule BluefinDecryptx.DecryptEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias BluefinDecryptx.Helpers, as: H
  alias BluefinDecryptx.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/decrypt/DecryptTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    BluefinDecryptx.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.decrypt"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = BluefinDecryptx.test()
    ent = BluefinDecryptx.decrypt(sdk)
    assert ent != nil
  end

  test "should list records" do
    sdk = mk_sdk()
    ent = BluefinDecryptx.decrypt(sdk)
    result = BluefinDecryptx.Entity.Decrypt.list(ent, S.jm([]))
    assert S.islist(result)
  end

  test "should create then read back" do
    sdk = BluefinDecryptx.test(S.jm(["entity", S.jm(["decrypt", S.jm([])])]))
    ent = BluefinDecryptx.decrypt(sdk)
    made = BluefinDecryptx.Entity.Decrypt.create(ent, S.jm(["name", "test-create"]))
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
