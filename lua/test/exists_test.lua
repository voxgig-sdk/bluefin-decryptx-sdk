-- BluefinDecryptx SDK exists test

local sdk = require("bluefin-decryptx_sdk")

describe("BluefinDecryptxSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
