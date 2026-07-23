// validation entity test (generated from the API model).

import XCTest

@testable import BluefinDecryptxSdk

final class ValidationEntityTest: XCTestCase {
  func testInstance() {
    let sdk = BluefinDecryptxSDK.testSDK(nil, nil)
    let ent = sdk.Validation()
    XCTAssertEqual(ent.getName(), "validation")
  }
}
