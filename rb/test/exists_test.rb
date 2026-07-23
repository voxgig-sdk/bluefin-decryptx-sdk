# BluefinDecryptx SDK exists test

require "minitest/autorun"
require_relative "../BluefinDecryptx_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = BluefinDecryptxSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
