import 'harness.dart';

import '../lib/BluefinDecryptxSDK.dart';

void tests() {
  describe('exists', () {
    test('test-mode', (t) async {
      final testsdk = BluefinDecryptxSDK.test();
      equal(true, null != testsdk);
    });
  });
}
