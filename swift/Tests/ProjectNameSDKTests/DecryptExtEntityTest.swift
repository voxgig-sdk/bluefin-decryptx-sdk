// decrypt_ext entity test (generated from the API model).

import XCTest

@testable import BluefinDecryptxSdk

final class DecryptExtEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinDecryptxSDK.testSDK(nil, nil)
    let ent = sdk.DecryptExt()
    XCTAssertEqual(ent.getName(), "decrypt_ext")
  }
}
