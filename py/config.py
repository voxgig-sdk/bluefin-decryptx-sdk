# BluefinDecryptx SDK configuration


def make_config():
    return {
        "main": {
            "name": "BluefinDecryptx",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
      },
        },
        "options": {
            "base": "https://secure-prod.decryptx.com/api",
            "auth": {
                "prefix": "",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "decrypt": {},
                "decrypt_ext": {},
                "validation": {},
            },
        },
        "entity": {
      "decrypt": {
        "fields": [
          {
            "active": True,
            "name": "client_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "code",
            "req": False,
            "type": "`$INTEGER`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "decrypted",
            "req": False,
            "type": "`$ARRAY`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "decryption_parameter",
            "req": True,
            "type": "`$OBJECT`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "encrypted",
            "req": True,
            "type": "`$ARRAY`",
            "index$": 4,
          },
          {
            "active": True,
            "name": "failed",
            "req": False,
            "type": "`$BOOLEAN`",
            "index$": 5,
          },
          {
            "active": True,
            "name": "firmware",
            "req": False,
            "type": "`$STRING`",
            "index$": 6,
          },
          {
            "active": True,
            "name": "has_cc_data",
            "req": True,
            "type": "`$BOOLEAN`",
            "index$": 7,
          },
          {
            "active": True,
            "name": "message",
            "req": False,
            "type": "`$STRING`",
            "index$": 8,
          },
          {
            "active": True,
            "name": "message_id",
            "req": True,
            "type": "`$STRING`",
            "index$": 9,
          },
          {
            "active": True,
            "name": "name",
            "req": True,
            "type": "`$STRING`",
            "index$": 10,
          },
          {
            "active": True,
            "name": "partner_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 11,
          },
          {
            "active": True,
            "name": "partner_key",
            "req": False,
            "type": "`$STRING`",
            "index$": 12,
          },
          {
            "active": True,
            "name": "reference",
            "op": {
              "create": {
                "req": False,
                "type": "`$STRING`",
              },
            },
            "req": True,
            "type": "`$STRING`",
            "index$": 13,
          },
          {
            "active": True,
            "name": "serial",
            "req": True,
            "type": "`$STRING`",
            "index$": 14,
          },
          {
            "active": True,
            "name": "success",
            "req": True,
            "type": "`$BOOLEAN`",
            "index$": 15,
          },
          {
            "active": True,
            "name": "value",
            "req": False,
            "type": "`$STRING`",
            "index$": 16,
          },
        ],
        "name": "decrypt",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/decrypt",
                "parts": [
                  "decrypt",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "create",
          },
          "list": {
            "input": "data",
            "name": "list",
            "points": [
              {
                "active": True,
                "args": {
                  "query": [
                    {
                      "active": True,
                      "kind": "query",
                      "name": "client_id",
                      "orig": "client_id",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "example": "param 1",
                      "kind": "query",
                      "name": "encrypted_name",
                      "orig": "encrypted_name",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "example": "nlj/tULUuiMlM3io0JZ+9jFBTKH7KCPwVg7PFjvWUMzMa7XE/QbegA==",
                      "kind": "query",
                      "name": "encrypted_value",
                      "orig": "encrypted_value",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "partner_id",
                      "orig": "partner_id",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "partner_key",
                      "orig": "partner_key",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "reference",
                      "orig": "reference",
                      "reqd": False,
                      "type": "`$STRING`",
                    },
                    {
                      "active": True,
                      "kind": "query",
                      "name": "serial",
                      "orig": "serial",
                      "reqd": True,
                      "type": "`$STRING`",
                    },
                  ],
                },
                "method": "GET",
                "orig": "/healthcheck",
                "parts": [
                  "healthcheck",
                ],
                "select": {
                  "exist": [
                    "client_id",
                    "encrypted_name",
                    "encrypted_value",
                    "partner_id",
                    "partner_key",
                    "reference",
                    "serial",
                  ],
                },
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "list",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "decrypt_ext": {
        "fields": [
          {
            "active": True,
            "name": "client_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "completed",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "decrypted",
            "op": {
              "create": {
                "req": True,
                "type": "`$NUMBER`",
              },
            },
            "req": False,
            "type": "`$NUMBER`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "encrypted",
            "req": True,
            "type": "`$NUMBER`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "ip",
            "req": False,
            "type": "`$STRING`",
            "index$": 4,
          },
          {
            "active": True,
            "name": "message_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 5,
          },
          {
            "active": True,
            "name": "partner_id",
            "req": True,
            "type": "`$STRING`",
            "index$": 6,
          },
          {
            "active": True,
            "name": "partner_key",
            "req": False,
            "type": "`$STRING`",
            "index$": 7,
          },
          {
            "active": True,
            "name": "reference",
            "op": {
              "create": {
                "req": True,
                "type": "`$STRING`",
              },
            },
            "req": False,
            "type": "`$STRING`",
            "index$": 8,
          },
          {
            "active": True,
            "name": "serial",
            "req": True,
            "type": "`$STRING`",
            "index$": 9,
          },
          {
            "active": True,
            "name": "success",
            "op": {
              "create": {
                "req": True,
                "type": "`$BOOLEAN`",
              },
            },
            "req": False,
            "type": "`$BOOLEAN`",
            "index$": 10,
          },
        ],
        "name": "decrypt_ext",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/decrypt-ext",
                "parts": [
                  "decrypt-ext",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "validation": {
        "fields": [
          {
            "active": True,
            "name": "client_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "firmware",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "message_id",
            "req": True,
            "type": "`$STRING`",
            "index$": 2,
          },
          {
            "active": True,
            "name": "partner_id",
            "req": False,
            "type": "`$STRING`",
            "index$": 3,
          },
          {
            "active": True,
            "name": "partner_key",
            "req": False,
            "type": "`$STRING`",
            "index$": 4,
          },
          {
            "active": True,
            "name": "reference",
            "op": {
              "create": {
                "req": False,
                "type": "`$STRING`",
              },
            },
            "req": True,
            "type": "`$STRING`",
            "index$": 5,
          },
          {
            "active": True,
            "name": "serial",
            "req": True,
            "type": "`$STRING`",
            "index$": 6,
          },
          {
            "active": True,
            "name": "success",
            "req": True,
            "type": "`$BOOLEAN`",
            "index$": 7,
          },
        ],
        "name": "validation",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/device/validate",
                "parts": [
                  "device",
                  "validate",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/partner/validate",
                "parts": [
                  "partner",
                  "validate",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 1,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
