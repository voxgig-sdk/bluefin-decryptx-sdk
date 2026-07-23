import 'feature/base/BaseFeature.dart';
import 'feature/test/TestFeature.dart';


// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'test': () => TestFeature(),

};

class Config {
  BaseFeature makeFeature(String fn) {
    final fc = FEATURE_CLASS[fn];
    if (null == fc) {
      // TODO: errors etc
      throw StateError('Unknown feature: ' + fn);
    }
    return fc();
  }

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'ProjectName',
  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
    },

  };

  final Map<String, dynamic> options = <String, dynamic>{
    'base': 'https://secure-prod.decryptx.com/api',

    'auth': <String, dynamic>{
      'prefix': '',
    },

    'headers': <String, dynamic>{
      'content-type': 'application/json',
    },

    'entity': <String, dynamic>{
            'decrypt': <String, dynamic>{},
      'decrypt_ext': <String, dynamic>{},
      'validation': <String, dynamic>{},

    }
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'decrypt': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'client_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'code',
          'req': false,
          'type': '`\$INTEGER`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'decrypted',
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'decryption_parameter',
          'req': true,
          'type': '`\$OBJECT`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'encrypted',
          'req': true,
          'type': '`\$ARRAY`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'failed',
          'req': false,
          'type': '`\$BOOLEAN`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'firmware',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 6,
        },
        <String, dynamic>{
          'active': true,
          'name': 'has_cc_data',
          'req': true,
          'type': '`\$BOOLEAN`',
          'index\$': 7,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 8,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 9,
        },
        <String, dynamic>{
          'active': true,
          'name': 'name',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 10,
        },
        <String, dynamic>{
          'active': true,
          'name': 'partner_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 11,
        },
        <String, dynamic>{
          'active': true,
          'name': 'partner_key',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 12,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': false,
              'type': '`\$STRING`',
            },
          },
          'req': true,
          'type': '`\$STRING`',
          'index\$': 13,
        },
        <String, dynamic>{
          'active': true,
          'name': 'serial',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 14,
        },
        <String, dynamic>{
          'active': true,
          'name': 'success',
          'req': true,
          'type': '`\$BOOLEAN`',
          'index\$': 15,
        },
        <String, dynamic>{
          'active': true,
          'name': 'value',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 16,
        },
      ],
      'name': 'decrypt',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
              'method': 'POST',
              'orig': '/decrypt',
              'parts': <dynamic>[
                'decrypt',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'index\$': 0,
            },
          ],
          'key\$': 'create',
        },
        'list': <String, dynamic>{
          'input': 'data',
          'name': 'list',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'client_id',
                    'orig': 'client_id',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'example': 'param 1',
                    'kind': 'query',
                    'name': 'encrypted_name',
                    'orig': 'encrypted_name',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'example': 'nlj/tULUuiMlM3io0JZ+9jFBTKH7KCPwVg7PFjvWUMzMa7XE/QbegA==',
                    'kind': 'query',
                    'name': 'encrypted_value',
                    'orig': 'encrypted_value',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'partner_id',
                    'orig': 'partner_id',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'partner_key',
                    'orig': 'partner_key',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'reference',
                    'orig': 'reference',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'serial',
                    'orig': 'serial',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
              'method': 'GET',
              'orig': '/healthcheck',
              'parts': <dynamic>[
                'healthcheck',
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'client_id',
                  'encrypted_name',
                  'encrypted_value',
                  'partner_id',
                  'partner_key',
                  'reference',
                  'serial',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'index\$': 0,
            },
          ],
          'key\$': 'list',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'decrypt_ext': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'client_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'completed',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'decrypted',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$NUMBER`',
            },
          },
          'req': false,
          'type': '`\$NUMBER`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'encrypted',
          'req': true,
          'type': '`\$NUMBER`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'ip',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'partner_id',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 6,
        },
        <String, dynamic>{
          'active': true,
          'name': 'partner_key',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 7,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'req': false,
          'type': '`\$STRING`',
          'index\$': 8,
        },
        <String, dynamic>{
          'active': true,
          'name': 'serial',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 9,
        },
        <String, dynamic>{
          'active': true,
          'name': 'success',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$BOOLEAN`',
            },
          },
          'req': false,
          'type': '`\$BOOLEAN`',
          'index\$': 10,
        },
      ],
      'name': 'decrypt_ext',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
              'method': 'POST',
              'orig': '/decrypt-ext',
              'parts': <dynamic>[
                'decrypt-ext',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'index\$': 0,
            },
          ],
          'key\$': 'create',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'validation': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'client_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'firmware',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'partner_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'partner_key',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': false,
              'type': '`\$STRING`',
            },
          },
          'req': true,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'serial',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 6,
        },
        <String, dynamic>{
          'active': true,
          'name': 'success',
          'req': true,
          'type': '`\$BOOLEAN`',
          'index\$': 7,
        },
      ],
      'name': 'validation',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
              'method': 'POST',
              'orig': '/device/validate',
              'parts': <dynamic>[
                'device',
                'validate',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
              'method': 'POST',
              'orig': '/partner/validate',
              'parts': <dynamic>[
                'partner',
                'validate',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
              'index\$': 1,
            },
          ],
          'key\$': 'create',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
  };

  // The pipeline context carries the config as a plain map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'main': main,
        'feature': feature,
        'options': options,
        'entity': entity,
      };
}

final config = Config();
