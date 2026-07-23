class BluefinDecryptxError extends Error {
  final bool isBluefinDecryptxError = true;

  final String sdk = 'BluefinDecryptx';

  String code;
  String message;
  dynamic ctx;

  // Populated by makeError with the (cleaned) result and spec.
  dynamic result;
  dynamic spec;

  BluefinDecryptxError(this.code, this.message, [this.ctx]);

  @override
  String toString() => 'BluefinDecryptxError: ' + code + ': ' + message;
}
