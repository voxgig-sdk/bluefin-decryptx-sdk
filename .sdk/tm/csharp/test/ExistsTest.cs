// BluefinDecryptx SDK exists test.

using Xunit;

using BluefinDecryptxSdk;

namespace BluefinDecryptxSdk.Test;

public class ExistsTest
{
    [Fact]
    public void TestMode()
    {
        var testsdk = BluefinDecryptxSDK.TestSDK(null, null);
        Assert.NotNull(testsdk);
    }
}
