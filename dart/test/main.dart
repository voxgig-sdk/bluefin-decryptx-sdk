// BluefinDecryptx SDK test suite entry. GENERATED — do not edit.

import 'dart:io';

import 'harness.dart' as harness;

import 'exists_test.dart' as exists_test;
import 'struct_test.dart' as struct_test;
import 'primary_test.dart' as primary_test;
import 'pipeline_test.dart' as pipeline_test;
import 'feature_test.dart' as feature_test;
import 'netsim_test.dart' as netsim_test;
import 'custom_test.dart' as custom_test;
import 'readme_examples_test.dart' as readme_examples_test;
import 'entity/decrypt/DecryptEntity_test.dart' as decrypt_entity_test;
import 'entity/decrypt/DecryptDirect_test.dart' as decrypt_direct_test;
import 'entity/decrypt_ext/DecryptExtEntity_test.dart' as decrypt_ext_entity_test;
import 'entity/validation/ValidationEntity_test.dart' as validation_entity_test;

Future<void> main() async {
  exists_test.tests();
  struct_test.tests();
  primary_test.tests();
  pipeline_test.tests();
  feature_test.tests();
  netsim_test.tests();
  custom_test.tests();
  readme_examples_test.tests();
  decrypt_entity_test.tests();
  decrypt_direct_test.tests();
  decrypt_ext_entity_test.tests();
  validation_entity_test.tests();

  final failed = await harness.runAll();
  if (0 < failed) {
    exitCode = 1;
  }
}
