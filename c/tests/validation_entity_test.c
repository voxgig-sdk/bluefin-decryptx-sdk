// Generated instance test for the validation entity.

#include "ctest.h"

int main(void) {
  BluefinDecryptxSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = bluefindecryptx_validation(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "validation", "entity get_name");

  TEST_SUMMARY("validation_entity");
}
