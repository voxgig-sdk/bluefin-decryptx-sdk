-- BluefinDecryptx SDK configuration

local function make_config()
  return {
    main = {
      name = "BluefinDecryptx",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
      },
    },
    options = {
      base = "https://secure-prod.decryptx.com/api",
      auth = {
        prefix = "",
      },
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["decrypt"] = {},
        ["decrypt_ext"] = {},
        ["validation"] = {},
      },
    },
    entity = {
      ["decrypt"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "client_id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "code",
            ["req"] = false,
            ["type"] = "`$INTEGER`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "decrypted",
            ["req"] = false,
            ["type"] = "`$ARRAY`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "decryption_parameter",
            ["req"] = true,
            ["type"] = "`$OBJECT`",
            ["index$"] = 3,
          },
          {
            ["active"] = true,
            ["name"] = "encrypted",
            ["req"] = true,
            ["type"] = "`$ARRAY`",
            ["index$"] = 4,
          },
          {
            ["active"] = true,
            ["name"] = "failed",
            ["req"] = false,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 5,
          },
          {
            ["active"] = true,
            ["name"] = "firmware",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 6,
          },
          {
            ["active"] = true,
            ["name"] = "has_cc_data",
            ["req"] = true,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 7,
          },
          {
            ["active"] = true,
            ["name"] = "message",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 8,
          },
          {
            ["active"] = true,
            ["name"] = "message_id",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 9,
          },
          {
            ["active"] = true,
            ["name"] = "name",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 10,
          },
          {
            ["active"] = true,
            ["name"] = "partner_id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 11,
          },
          {
            ["active"] = true,
            ["name"] = "partner_key",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 12,
          },
          {
            ["active"] = true,
            ["name"] = "reference",
            ["op"] = {
              ["create"] = {
                ["req"] = false,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 13,
          },
          {
            ["active"] = true,
            ["name"] = "serial",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 14,
          },
          {
            ["active"] = true,
            ["name"] = "success",
            ["req"] = true,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 15,
          },
          {
            ["active"] = true,
            ["name"] = "value",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 16,
          },
        },
        ["name"] = "decrypt",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["method"] = "POST",
                ["orig"] = "/decrypt",
                ["parts"] = {
                  "decrypt",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "create",
          },
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {
                  ["query"] = {
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "client_id",
                      ["orig"] = "client_id",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = "param 1",
                      ["kind"] = "query",
                      ["name"] = "encrypted_name",
                      ["orig"] = "encrypted_name",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["example"] = "nlj/tULUuiMlM3io0JZ+9jFBTKH7KCPwVg7PFjvWUMzMa7XE/QbegA==",
                      ["kind"] = "query",
                      ["name"] = "encrypted_value",
                      ["orig"] = "encrypted_value",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "partner_id",
                      ["orig"] = "partner_id",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "partner_key",
                      ["orig"] = "partner_key",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "reference",
                      ["orig"] = "reference",
                      ["reqd"] = false,
                      ["type"] = "`$STRING`",
                    },
                    {
                      ["active"] = true,
                      ["kind"] = "query",
                      ["name"] = "serial",
                      ["orig"] = "serial",
                      ["reqd"] = true,
                      ["type"] = "`$STRING`",
                    },
                  },
                },
                ["method"] = "GET",
                ["orig"] = "/healthcheck",
                ["parts"] = {
                  "healthcheck",
                },
                ["select"] = {
                  ["exist"] = {
                    "client_id",
                    "encrypted_name",
                    "encrypted_value",
                    "partner_id",
                    "partner_key",
                    "reference",
                    "serial",
                  },
                },
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "list",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["decrypt_ext"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "client_id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "completed",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "decrypted",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$NUMBER`",
              },
            },
            ["req"] = false,
            ["type"] = "`$NUMBER`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "encrypted",
            ["req"] = true,
            ["type"] = "`$NUMBER`",
            ["index$"] = 3,
          },
          {
            ["active"] = true,
            ["name"] = "ip",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 4,
          },
          {
            ["active"] = true,
            ["name"] = "message_id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 5,
          },
          {
            ["active"] = true,
            ["name"] = "partner_id",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 6,
          },
          {
            ["active"] = true,
            ["name"] = "partner_key",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 7,
          },
          {
            ["active"] = true,
            ["name"] = "reference",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 8,
          },
          {
            ["active"] = true,
            ["name"] = "serial",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 9,
          },
          {
            ["active"] = true,
            ["name"] = "success",
            ["op"] = {
              ["create"] = {
                ["req"] = true,
                ["type"] = "`$BOOLEAN`",
              },
            },
            ["req"] = false,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 10,
          },
        },
        ["name"] = "decrypt_ext",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["method"] = "POST",
                ["orig"] = "/decrypt-ext",
                ["parts"] = {
                  "decrypt-ext",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
            },
            ["key$"] = "create",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["validation"] = {
        ["fields"] = {
          {
            ["active"] = true,
            ["name"] = "client_id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 0,
          },
          {
            ["active"] = true,
            ["name"] = "firmware",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 1,
          },
          {
            ["active"] = true,
            ["name"] = "message_id",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 2,
          },
          {
            ["active"] = true,
            ["name"] = "partner_id",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 3,
          },
          {
            ["active"] = true,
            ["name"] = "partner_key",
            ["req"] = false,
            ["type"] = "`$STRING`",
            ["index$"] = 4,
          },
          {
            ["active"] = true,
            ["name"] = "reference",
            ["op"] = {
              ["create"] = {
                ["req"] = false,
                ["type"] = "`$STRING`",
              },
            },
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 5,
          },
          {
            ["active"] = true,
            ["name"] = "serial",
            ["req"] = true,
            ["type"] = "`$STRING`",
            ["index$"] = 6,
          },
          {
            ["active"] = true,
            ["name"] = "success",
            ["req"] = true,
            ["type"] = "`$BOOLEAN`",
            ["index$"] = 7,
          },
        },
        ["name"] = "validation",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["active"] = true,
                ["args"] = {},
                ["method"] = "POST",
                ["orig"] = "/device/validate",
                ["parts"] = {
                  "device",
                  "validate",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 0,
              },
              {
                ["active"] = true,
                ["args"] = {},
                ["method"] = "POST",
                ["orig"] = "/partner/validate",
                ["parts"] = {
                  "partner",
                  "validate",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["index$"] = 1,
              },
            },
            ["key$"] = "create",
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
