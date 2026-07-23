# BluefinDecryptx SDK utility: clean

use strict;
use warnings;

package BluefinDecryptxUtilities;

our %REGISTRY;

$REGISTRY{clean} = sub {
  my ($ctx, $val) = @_;
  return $val;
};

1;
