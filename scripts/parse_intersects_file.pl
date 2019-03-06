use strict;

open (my $fh, "<intersects.tsv");

while (<$fh>) {
  chomp;
  my @raw = split /\t/;
  $raw[0] =~ /ID=(.*?)(;|\z)/i;
  my $ref = $1;

  $raw[1] =~ /ID=(.*?)(;|\z)/i;
  my $new = $1;

  print join("\t", $ref, $new) . "\n";
}
