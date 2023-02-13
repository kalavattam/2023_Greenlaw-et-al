#!/bin/env perl

#  parse_bam-flag.pl
#  Dave Tang
#  2014-0306
#  davetang.org/muse/2014/03/06/understanding-bam-flags/
#
#  Modified: Kris Alavattam
#  2023-0210

use strict;
use warnings;

my $usage = "Usage: $0 <bam_flag>\n";
my $flag = shift or die $usage;

die "Please enter a numerical value\n" if $flag =~ /\D+/;

if ($flag & 0x1) {
   print "template having multiple segments in sequencing, i.e., read paired (0x1)\n";
}
if ($flag & 0x2) {
   print "each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)\n";
}
if ($flag & 0x4) {
   print "segment unmapped, i.e., read unmapped (0x4)\n";
}
if ($flag & 0x8) {
   print "next segment in the template unmapped, i.e., mate unmapped (0x8)\n";
}
if ($flag & 0x10) {
   print "SEQ being reverse complemented, i.e., read reverse strand (0x10)\n";
}
if ($flag & 0x20) {
   print "SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)\n";
}
if ($flag & 0x40) {
   print "the first segment in the template, i.e., first in pair (0x40)\n";
}
if ($flag & 0x80) {
   print "the last segment in the template, i.e., second in pair (0x80)\n";
}
if ($flag & 0x100) {
   print "secondary alignment, i.e., not primary alignment (0x100)\n";
}
if ($flag & 0x200) {
   print "not passing quality controls, i.e., read fails platform/vendor quality checks (0x200)\n";
}
if ($flag & 0x400) {
   print "PCR or optical duplicate (0x400)\n";
}
if ($flag & 0x800) {
   print "supplementary alignment (0x800)\n";
}

exit(0);

__END__
