#!/usr/bin/perl

use strict;

if ($#ARGV != 1) {
    die "$0 kmer_list reads_list\n";
}

my @kmers;

open (READ, $ARGV[0]);
while (<READ>) {
    my @x = split;
    push (@kmers, $x[0]);
}
close READ;

my %poppers;

my $total = 0;

open (READ, $ARGV[1]);
while (<READ>) {
    $total++;
    if ($total =~ /000000$/) {
        print STDERR ".";
    }
    my $seq = <READ>;
    for my $n (@kmers) {
        my $total = () = ($seq =~ m/$n/g);
        if (($total*6)/length($seq) > 0.9) {
            $poppers{$n}++;
        }
    }
    <READ>;
    <READ>;
}
close READ;

for my $n (sort {$poppers{$b} <=> $poppers{$a}} keys %poppers) {
    print $n, "\t", $poppers{$n}, "\n";
}
