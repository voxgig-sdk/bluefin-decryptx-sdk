package JAVAPACKAGE.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import JAVAPACKAGE.core.BluefinDecryptxSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    BluefinDecryptxSDK testsdk = BluefinDecryptxSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
