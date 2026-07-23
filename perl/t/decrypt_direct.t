#!perl
# Decrypt direct test

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Cwd ();

use BluefinDecryptxSDK;
require(Cwd::abs_path("$FindBin::Bin/runner.pm"));

DIRECT_LIST: {
  my $setup = decrypt_direct_setup([
    { 'id' => 'direct01' },
    { 'id' => 'direct02' },
  ]);
  my ($_should_skip, $_reason) = BluefinDecryptxTestRunner::is_control_skipped(
    'direct', 'direct-list-decrypt', $setup->{live} ? 'live' : 'unit');
  if ($_should_skip) {
    note($_reason || 'skipped via sdk-test-control.json');
    pass('direct-list-decrypt: skipped via sdk-test-control.json');
    last DIRECT_LIST;
  }
  my $client = $setup->{client};

  my $result = $client->direct({
    'path' => 'healthcheck',
    'method' => 'GET',
    'params' => {},
  });
  if ($setup->{live}) {
    # Live mode is lenient: synthetic IDs frequently 4xx and the list-
    # response shape varies wildly across public APIs. Skip rather than
    # fail when the call doesn't return a usable list.
    if (defined $result->{err}) {
      note("list call failed (likely synthetic IDs against live API): $result->{err}");
      pass('direct-list-decrypt: skipped (live)');
      last DIRECT_LIST;
    }
    unless ($result->{ok}) {
      note('list call not ok (likely synthetic IDs against live API)');
      pass('direct-list-decrypt: skipped (live)');
      last DIRECT_LIST;
    }
    my $status = BluefinDecryptxHelpers::to_int($result->{status});
    if ($status < 200 || $status >= 300) {
      note("expected 2xx status, got $status");
      pass('direct-list-decrypt: skipped (live)');
      last DIRECT_LIST;
    }
    pass('direct-list-decrypt: live ok');
  }
  else {
    ok(!defined $result->{err}, 'direct-list-decrypt: no error');
    ok($result->{ok}, 'direct-list-decrypt: ok');
    is(BluefinDecryptxHelpers::to_int($result->{status}), 200, 'direct-list-decrypt: status');
    ok(Voxgig::Struct::islist($result->{data}), 'direct-list-decrypt: data is array');
    is(scalar @{ $result->{data} }, 2, 'direct-list-decrypt: data length');
    is(scalar @{ $setup->{calls} }, 1, 'direct-list-decrypt: 1 call');
  }
}


sub decrypt_direct_setup {
  my ($mockres) = @_;
  BluefinDecryptxTestRunner::load_env_local();

  my $calls = [];

  my $env = BluefinDecryptxTestRunner::env_override({
    'BLUEFINDECRYPTX_TEST_DECRYPT_ENTID' => {},
    'BLUEFINDECRYPTX_TEST_LIVE' => 'FALSE',
    'BLUEFINDECRYPTX_APIKEY' => 'NONE',
  });

  my $live = ((($env->{'BLUEFINDECRYPTX_TEST_LIVE'}) || '') eq 'TRUE') ? 1 : 0;

  if ($live) {
    my $client = BluefinDecryptxSDK->new({
      'apikey' => $env->{'BLUEFINDECRYPTX_APIKEY'},
    });
    return {
      'client' => $client,
      'calls' => $calls,
      'live' => 1,
      'idmap' => {},
    };
  }

  my $mock_fetch = sub {
    my ($url, $init) = @_;
    push @$calls, { 'url' => $url, 'init' => $init };
    return ({
      'status' => 200,
      'statusText' => 'OK',
      'headers' => {},
      'json' => sub {
        return defined $mockres ? $mockres : { 'id' => 'direct01' };
      },
      'body' => 'mock',
    }, undef);
  };

  my $client = BluefinDecryptxSDK->new({
    'base' => 'http://localhost:8080',
    'system' => {
      'fetch' => $mock_fetch,
    },
  });

  return {
    'client' => $client,
    'calls' => $calls,
    'live' => 0,
    'idmap' => {},
  };
}

done_testing();
