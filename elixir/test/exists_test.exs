defmodule BluefinDecryptx.ExistsTest do
  use ExUnit.Case

  test "should create test sdk" do
    testsdk = BluefinDecryptx.test()
    assert testsdk != nil
  end
end
