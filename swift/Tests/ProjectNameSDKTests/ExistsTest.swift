// BluefinDecryptx SDK exists test.

import XCTest

@testable import BluefinDecryptxSdk

final class ExistsTest: XCTestCase {
  func testMode() {
    let testsdk = BluefinDecryptxSDK.testSDK(nil, nil)
    XCTAssertEqual(testsdk.mode, "test")
  }
}
