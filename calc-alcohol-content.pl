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
use Switch;

my $tempMode = 0;
my ($start_grav,$start_temp,$end_grav,$end_temp);

print "Would you like to enter temperature data to obtain a more accurate figure? (Y/N): ";
my $valid = 0;
my $input;
while(!$valid){
	$input = <>;
	chomp $input;
	if($input eq "Y" || $input eq "y" || $input eq "yes"){
		$valid = 1;
		$tempMode = 1;
	}
	elsif($input eq "N" || $input eq "n" || $input eq "no"){
		$valid = 1;
	}
	else{
		print "Please respond with \"Y\" or \"N\".\n"
	}
}

print "Enter pre-fermentation specific gravity: ";
$start_grav=<>;
if($tempMode){
	print "Enter liquid temperature of this reading (Deg F): ";
	$start_temp=<>;
}
print "Enter post-fermentation specific gravity: ";
$end_grav=<>;
if($tempMode){
	print "Enter liquid temperature of this reading (Deg F): ";
	$end_temp=<>;
}
if($tempMode){
	$start_grav = correctHydrometerReadings($start_temp,$start_grav);
	$end_grav = correctHydrometerReadings($end_temp,$end_grav);
}

my $alcohol_content = sprintf( "%.2f%%", specific_gravity_to_potential_alcohol_content($start_grav) - specific_gravity_to_potential_alcohol_content($end_grav));

print "Total alcohol content of finished beverage is approximately: $alcohol_content\n";

sub correctHydrometerReadings{
my $temperature = shift;
my $reading = shift;

switch ($temperature) {
	case {$temperature<50} { die "ERROR: No correction values availabile for under 50 degrees.\n"; }
	case {$temperature<60} { $reading += (0.05*($temperature) - 3)/1000; } #Simple linear regression for this small temperature segment
	case {$temperature==60} {} #Hydrometer is calibrated for this value
	case {$temperature>60} { $reading += (6.105362041e-4*$temperature) + ((-8.184529406e-3)*$temperature**0.5) +  (2.676188365e-2); } #Regression calculated, RSS=3.91e-9.
}
return $reading;
}

sub specific_gravity_to_potential_alcohol_content{
	my $spec_grav = shift;
	if ($spec_grav<0) {die "Error: negative specific gravity is invalid.\n";}
	return (141.7418891 * log($spec_grav)); #Pretty good approximation
}

