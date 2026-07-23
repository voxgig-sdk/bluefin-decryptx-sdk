
const { test, describe } = require('node:test')
const { equal } = require('node:assert')


const { BluefinDecryptxSDK } = require('..')


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await BluefinDecryptxSDK.test()
    equal(null !== testsdk, true)
  })

})
