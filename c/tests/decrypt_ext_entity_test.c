// Generated instance test for the decrypt_ext entity.

#include "ctest.h"

int main(void) {
  BluefinDecryptxSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = bluefindecryptx_decrypt_ext(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "decrypt_ext", "entity get_name");

  TEST_SUMMARY("decrypt_ext_entity");
}
