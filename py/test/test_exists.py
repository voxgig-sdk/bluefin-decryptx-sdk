# ProjectName SDK exists test

import pytest
from bluefindecryptx_sdk import BluefinDecryptxSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = BluefinDecryptxSDK.test(None, None)
        assert testsdk is not None
