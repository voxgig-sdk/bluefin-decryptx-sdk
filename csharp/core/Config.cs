// BluefinDecryptx SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

namespace BluefinDecryptxSdk;

public static class SdkConfig
{
    public static Dictionary<string, object?> MakeConfig()
    {
        return new Dictionary<string, object?>
        {
            ["main"] = new Dictionary<string, object?>
            {
                ["name"] = "BluefinDecryptx",
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                },
            },
            ["options"] = new Dictionary<string, object?>
            {
                ["base"] = "https://secure-prod.decryptx.com/api",
                ["auth"] = new Dictionary<string, object?>
                {
                    ["prefix"] = "",
                },
                ["headers"] = new Dictionary<string, object?>
                {
                    ["content-type"] = "application/json",
                },
                ["entity"] = new Dictionary<string, object?>
                {
                    ["decrypt"] = new Dictionary<string, object?>(),
                    ["decrypt_ext"] = new Dictionary<string, object?>(),
                    ["validation"] = new Dictionary<string, object?>(),
                },
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["decrypt"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "client_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "code",
                            ["req"] = false,
                            ["type"] = "`$INTEGER`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "decrypted",
                            ["req"] = false,
                            ["type"] = "`$ARRAY`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "decryption_parameter",
                            ["req"] = true,
                            ["type"] = "`$OBJECT`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "encrypted",
                            ["req"] = true,
                            ["type"] = "`$ARRAY`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "failed",
                            ["req"] = false,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "firmware",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 6,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "has_cc_data",
                            ["req"] = true,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 7,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "message",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 8,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "message_id",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 9,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "name",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 10,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "partner_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 11,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "partner_key",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 12,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "reference",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = false,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 13,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "serial",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 14,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "success",
                            ["req"] = true,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 15,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "value",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 16,
                        },
                    },
                    ["name"] = "decrypt",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/decrypt",
                                    ["parts"] = new List<object?>
                                    {
                                        "decrypt",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "create",
                        },
                        ["list"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "list",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>
                                    {
                                        ["query"] = new List<object?>
                                        {
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "query",
                                                ["name"] = "client_id",
                                                ["orig"] = "client_id",
                                                ["reqd"] = false,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["example"] = "param 1",
                                                ["kind"] = "query",
                                                ["name"] = "encrypted_name",
                                                ["orig"] = "encrypted_name",
                                                ["reqd"] = false,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["example"] = "nlj/tULUuiMlM3io0JZ+9jFBTKH7KCPwVg7PFjvWUMzMa7XE/QbegA==",
                                                ["kind"] = "query",
                                                ["name"] = "encrypted_value",
                                                ["orig"] = "encrypted_value",
                                                ["reqd"] = false,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "query",
                                                ["name"] = "partner_id",
                                                ["orig"] = "partner_id",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "query",
                                                ["name"] = "partner_key",
                                                ["orig"] = "partner_key",
                                                ["reqd"] = true,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
                                            {
                                                ["active"] = true,
                                                ["kind"] = "query",
                                                ["name"] = "reference",
                                                ["orig"] = "reference",
                                                ["reqd"] = false,
                                                ["type"] = "`$STRING`",
                                            },
                                            new Dictionary<string, object?>
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
                                    ["parts"] = new List<object?>
                                    {
                                        "healthcheck",
                                    },
                                    ["select"] = new Dictionary<string, object?>
                                    {
                                        ["exist"] = new List<object?>
                                        {
                                            "client_id",
                                            "encrypted_name",
                                            "encrypted_value",
                                            "partner_id",
                                            "partner_key",
                                            "reference",
                                            "serial",
                                        },
                                    },
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "list",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["decrypt_ext"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "client_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "completed",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "decrypted",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$NUMBER`",
                                },
                            },
                            ["req"] = false,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "encrypted",
                            ["req"] = true,
                            ["type"] = "`$NUMBER`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "ip",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "message_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "partner_id",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 6,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "partner_key",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 7,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "reference",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = true,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 8,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "serial",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 9,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "success",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
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
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/decrypt-ext",
                                    ["parts"] = new List<object?>
                                    {
                                        "decrypt-ext",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "create",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
                ["validation"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "client_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "firmware",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "message_id",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "partner_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "partner_key",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "reference",
                            ["op"] = new Dictionary<string, object?>
                            {
                                ["create"] = new Dictionary<string, object?>
                                {
                                    ["req"] = false,
                                    ["type"] = "`$STRING`",
                                },
                            },
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "serial",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 6,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "success",
                            ["req"] = true,
                            ["type"] = "`$BOOLEAN`",
                            ["index$"] = 7,
                        },
                    },
                    ["name"] = "validation",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/device/validate",
                                    ["parts"] = new List<object?>
                                    {
                                        "device",
                                        "validate",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["method"] = "POST",
                                    ["orig"] = "/partner/validate",
                                    ["parts"] = new List<object?>
                                    {
                                        "partner",
                                        "validate",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 1,
                                },
                            },
                            ["key$"] = "create",
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
            },
        };
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "test":
                return new Feature.TestFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
