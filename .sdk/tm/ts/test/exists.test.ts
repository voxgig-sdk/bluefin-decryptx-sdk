
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { BluefinDecryptxSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await BluefinDecryptxSDK.test()
    equal(null !== testsdk, true)
  })

})
