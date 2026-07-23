

class BluefinDecryptxError extends Error {

  isBluefinDecryptxError = true

  sdk = 'BluefinDecryptx'

  constructor(code, msg, ctx) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

module.exports = {
  BluefinDecryptxError
}

