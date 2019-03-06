# Not finished, not using yet....

use strict;
use Digest::MD5;

open (my $fh, "<$ARGV[0]");

my ($id, $seq);

my %hashes;

while (<$fh>) {
  chomp;
  if ($_ =~ />(.*)/) {
    # End of record, process previous seq before continuing to new seq...

    $id = $1;
    $seq = ''; # Blank out current seq...
  } else {
    $seq .= $_;
  }
}
