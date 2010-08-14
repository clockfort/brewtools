#!/usr/bin/perl
# Copyright (c) 2010 Chris Lockfort <clockfort@csh.removethisforspam.rit.edu>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
use strict;
use warnings;
use Math::Trig ':pi';

print "Enter height of liquid (in): ";
my $height = <>;
print "Enter diameter of cylindrical fermenter (in): ";
my $diameter = <>;

my $volume = pi * ($diameter/2) ** 2 * $height;
my $productive_volume = pi * ($diameter/2) ** 2 * ($height - 0.5);

#convert in^3 to fl oz, divide into 12 fl oz bottles, round to 1 decimal place
my $bottles = sprintf("%.1f", $volume * 0.554112554 / 12); 

my $productive_bottles = sprintf("%.1f", $productive_volume * 0.554112554 / 12);

print "Approximate number of 12 oz bottles: $bottles\n";
if($productive_bottles > 0){
	print "Approximate numbber of 12 oz bottles, accounting for typical losses: $productive_bottles\n";
}
