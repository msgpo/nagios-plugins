#!/usr/bin/perl

use strict;
use File::Basename;

# build new command string
my $cmd = dirname(__FILE__) . "/check_procs";
for (my $i = 0; $i <=  $#ARGV; $i++) {
        $cmd .= " " . $ARGV[$i];
}

# get the return data
my $stdout = `$cmd`;
my $exitCode = $?;

# add perfdata
my $state = "*", my $procs = 0;
chop $stdout;
if($stdout =~ m/PROCS\s.*:\s(\d+)\sprocess/) {
        $procs = $1;
}

if($stdout =~ m/PROCS\s.*:\s(\d+)\s.*STATE\s=\s(.*)$/) {
        $procs = $1;
        $state = $2;
}
# return new data
print "$stdout|state=$state;procs=$procs;\n";
exit ($exitCode);

