
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { BluefinDecryptxSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('DecryptEntity', async () => {

  test('instance', async () => {
    const testsdk = BluefinDecryptxSDK.test()
    const ent = testsdk.Decrypt()
    assert(null != ent)
  })


  // Feature #4: the entity `stream(action, ...)` method runs the op pipeline
  // and returns an async iterator over result items. With the streaming
  // feature active it yields the feature's incremental output; otherwise it
  // falls back to the materialised list so `stream` always yields.
  test('stream', async () => {
    const seed = {
      entity: {
        decrypt: { s1: { id: 's1' }, s2: { id: 's2' }, s3: { id: 's3' } }
      }
    }

    // Fallback: streaming inactive -> yields the materialised list items.
    const base = BluefinDecryptxSDK.test(seed)
    const seen = []
    for await (const item of base.Decrypt().stream('list')) {
      seen.push(item)
    }
    assert.equal(seen.length, 3)

    // Inbound: streaming active -> yields each item from the feature iterator.
    if (config.feature && config.feature.streaming) {
      const sdk = BluefinDecryptxSDK.test(seed, { feature: { streaming: { active: true } } })
      const got = []
      for await (const item of sdk.Decrypt().stream('list')) {
        if (Array.isArray(item)) { got.push(...item) } else { got.push(item) }
      }
      assert.equal(got.length, 3)
    }
  })


  test('basic', async () => {

    const setup = basicSetup()
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const decrypt_ref01_ent = client.Decrypt()
    let decrypt_ref01_data = setup.data.new.decrypt['decrypt_ref01']

    decrypt_ref01_data = await decrypt_ref01_ent.create(decrypt_ref01_data)
    assert(null != decrypt_ref01_data)


    // LIST
    const decrypt_ref01_match = {}

    const decrypt_ref01_list = await decrypt_ref01_ent.list(decrypt_ref01_match)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/decrypt/DecryptTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = BluefinDecryptxSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['decrypt01','decrypt02','decrypt03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_DECRYPTX_TEST_DECRYPT_ENTID': idmap,
    'BLUEFIN_DECRYPTX_TEST_LIVE': 'FALSE',
    'BLUEFIN_DECRYPTX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_DECRYPTX_APIKEY': 'NONE',
  })

  idmap = env['BLUEFIN_DECRYPTX_TEST_DECRYPT_ENTID']

  if ('TRUE' === env.BLUEFIN_DECRYPTX_TEST_LIVE) {
    client = new BluefinDecryptxSDK(merge([
      {
        apikey: env.BLUEFIN_DECRYPTX_APIKEY,
      },
      extra
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.BLUEFIN_DECRYPTX_TEST_EXPLAIN,
    now: Date.now(),
  }

  return setup
}
  
