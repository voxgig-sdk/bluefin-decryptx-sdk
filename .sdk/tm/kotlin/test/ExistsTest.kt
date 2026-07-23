package KOTLINPACKAGE.sdktest

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test

import KOTLINPACKAGE.core.BluefinDecryptxSDK

class ExistsTest {

  @Test
  fun testMode() {
    val testsdk = BluefinDecryptxSDK.testSDK()
    assertNotNull(testsdk, "expected non-nil SDK")
  }
}
