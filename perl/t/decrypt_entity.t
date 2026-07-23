#!perl
# Decrypt entity test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use BluefinDecryptxSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

{
  my $testsdk = BluefinDecryptxSDK->test(undef, undef);
  my $ent = $testsdk->Decrypt(undef);
  ok(defined $ent, 'decrypt: create instance');
}

BASIC_FLOW: {
  my $setup = decrypt_basic_setup(undef);
  my $_live = $setup->{live} ? 1 : 0;
  # Per-op sdk-test-control.json skip.
  for my $_op ('create', 'list') {
    my ($_should_skip, $_reason) = BluefinDecryptxTestRunner::is_control_skipped(
      'entityOp', "decrypt." . $_op, $_live ? 'live' : 'unit');
    if ($_should_skip) {
      note($_reason || 'skipped via sdk-test-control.json');
      pass('decrypt: basic flow skipped via sdk-test-control.json');
      last BASIC_FLOW;
    }
  }
  # The basic flow consumes synthetic IDs from the fixture. In live mode
  # without an *_ENTID env override, those IDs hit the live API and 4xx.
  if ($setup->{synthetic_only}) {
    note('live entity test uses synthetic IDs from fixture - set BLUEFINDECRYPTX_TEST_DECRYPT_ENTID JSON to run live');
    pass('decrypt: basic flow skipped (synthetic IDs only)');
    last BASIC_FLOW;
  }
  my $client = $setup->{client};
  my %V;

  # CREATE
  $V{decrypt_ref01_ent} = $client->Decrypt(undef);
  $V{decrypt_ref01_data} = BluefinDecryptxHelpers::to_map(BluefinDecryptxHelpers::gp(
    BluefinDecryptxHelpers::gpath($setup->{data}, 'new.decrypt'), 'decrypt_ref01'));

  $V{decrypt_ref01_data_result} = $V{decrypt_ref01_ent}->create($V{decrypt_ref01_data}, undef);
  $V{decrypt_ref01_data} = BluefinDecryptxHelpers::to_map($V{decrypt_ref01_data_result});
  ok(defined $V{decrypt_ref01_data}, 'decrypt create: data');

  # LIST
  $V{decrypt_ref01_match} = {};

  $V{decrypt_ref01_list_result} = $V{decrypt_ref01_ent}->list($V{decrypt_ref01_match}, undef);
  ok(Voxgig::Struct::islist($V{decrypt_ref01_list_result}), 'decrypt list: is array');

  $V{found_item} = Voxgig::Struct::select(
    BluefinDecryptxTestRunner::entity_list_to_data($V{decrypt_ref01_list_result}),
    { 'id' => $V{decrypt_ref01_data}{id} });
  ok(!Voxgig::Struct::isempty($V{found_item}), 'decrypt list: item exists');

}

sub decrypt_basic_setup {
  my ($extra) = @_;
  BluefinDecryptxTestRunner::load_env_local();

  my $entity_data_file = Cwd::abs_path(
    "$FindBin::Bin/../../.sdk/test/entity/decrypt/DecryptTestData.json");
  my $entity_data = do {
    open my $fh, '<:raw', $entity_data_file or die "Cannot open $entity_data_file: $!";
    local $/;
    Voxgig::Struct::parse_json(<$fh>);
  };

  my $options = {};
  $options->{entity} = $entity_data->{existing};

  my $client = BluefinDecryptxSDK->test($options, $extra);

  # Generate idmap via transform.
  my $idmap = Voxgig::Struct::transform(
    ['decrypt01', 'decrypt02', 'decrypt03'],
    {
      '`$PACK`' => ['', {
        '`$KEY`' => '`$COPY`',
        '`$VAL`' => ['`$FORMAT`', 'upper', '`$COPY`'],
      }],
    }
  );

  # Detect ENTID env override before env_override consumes it. When live
  # mode is on without a real override, the basic test runs against
  # synthetic IDs from the fixture and 4xx's. Surface this so the test can
  # skip.
  my $entid_env_raw = $ENV{'BLUEFINDECRYPTX_TEST_DECRYPT_ENTID'};
  my $idmap_overridden = (defined $entid_env_raw && $entid_env_raw =~ /^\s*\{/) ? 1 : 0;

  my $env = BluefinDecryptxTestRunner::env_override({
    'BLUEFINDECRYPTX_TEST_DECRYPT_ENTID' => $idmap,
    'BLUEFINDECRYPTX_TEST_LIVE' => 'FALSE',
    'BLUEFINDECRYPTX_TEST_EXPLAIN' => 'FALSE',
    'BLUEFINDECRYPTX_APIKEY' => 'NONE',
  });

  my $idmap_resolved = BluefinDecryptxHelpers::to_map($env->{'BLUEFINDECRYPTX_TEST_DECRYPT_ENTID'});
  if (!defined $idmap_resolved) {
    $idmap_resolved = BluefinDecryptxHelpers::to_map($idmap);
  }

  if ((($env->{'BLUEFINDECRYPTX_TEST_LIVE'}) || '') eq 'TRUE') {
    my $merged_opts = Voxgig::Struct::merge([
      {
        'apikey' => $env->{'BLUEFINDECRYPTX_APIKEY'},
      },
      (Voxgig::Struct::ismap($extra) ? $extra : {}),
    ]);
    $client = BluefinDecryptxSDK->new(BluefinDecryptxHelpers::to_map($merged_opts));
  }

  my $live = ((($env->{'BLUEFINDECRYPTX_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;
  return {
    'client' => $client,
    'data' => $entity_data,
    'idmap' => $idmap_resolved,
    'env' => $env,
    'explain' => ((($env->{'BLUEFINDECRYPTX_TEST_EXPLAIN'}) || '') eq 'TRUE') ? 1 : 0,
    'live' => $live,
    'synthetic_only' => ($live && !$idmap_overridden) ? 1 : 0,
    'now' => BluefinDecryptxHelpers::now_ms(),
  };
}

done_testing();
