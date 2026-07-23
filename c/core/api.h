// BluefinDecryptx SDK public API (generated).

#ifndef BLUEFIN_DECRYPTX_API_H
#define BLUEFIN_DECRYPTX_API_H

#include "sdk.h"

// Decrypt entity.
Entity* decrypt_entity_new(BluefinDecryptxSDK* client, voxgig_value* entopts);
Entity* bluefin_decryptx_decrypt(BluefinDecryptxSDK* client, voxgig_value* entopts);
voxgig_value* decrypt_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// DecryptExt entity.
Entity* decrypt_ext_entity_new(BluefinDecryptxSDK* client, voxgig_value* entopts);
Entity* bluefin_decryptx_decrypt_ext(BluefinDecryptxSDK* client, voxgig_value* entopts);
voxgig_value* decrypt_ext_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Validation entity.
Entity* validation_entity_new(BluefinDecryptxSDK* client, voxgig_value* entopts);
Entity* bluefin_decryptx_validation(BluefinDecryptxSDK* client, voxgig_value* entopts);
voxgig_value* validation_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);

#endif // BLUEFIN_DECRYPTX_API_H
