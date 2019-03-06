use strict;

open (my $fh, "<$ARGV[0]");

while (<$fh>) {
  my @gff = split /\t/;
  if ($gff[2] =~ /gene/i) {
    print $_
  }
}
