
import { Context } from './Context'


class BluefinDecryptxError extends Error {

  isBluefinDecryptxError = true

  sdk = 'BluefinDecryptx'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  BluefinDecryptxError
}

