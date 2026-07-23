package voxgig.bluefindecryptxsdk.sdktest;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import voxgig.bluefindecryptxsdk.core.BluefinDecryptxSDK;

public class ExistsTest {

  @Test
  public void testMode() {
    BluefinDecryptxSDK testsdk = BluefinDecryptxSDK.testSDK();
    assertNotNull(testsdk, "expected non-nil SDK");
  }
}
