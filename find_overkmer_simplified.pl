#!/usr/bin/perl

use strict;

my @kmers;
my $klength = $ARGV[1];

unless ($#ARGV == 1) {
    die "$0 fastq_file kmer_length\n";
}

my %poppers;

my $total = 0;

open (READ, $ARGV[0]);
while (<READ>) {
    $total++;
    if ($total =~ /000000$/) {
	print STDERR ".";
    }
    my $seq = <READ>;
    my %currhash;
    for my $n (0..$klength-1) {
	$currhash{substr($seq,$n,$klength)} = 1;
    }
    for my $kmer (keys %currhash) {
	my $total = () = ($seq =~ m/$kmer/g);
	if (($total*$klength)/length($seq) > 0.9) {
	    $poppers{$kmer}++;
	}
    }
    <READ>;
    <READ>;
}
close READ;
print STDERR "\n";

for my $n (sort {$poppers{$b} <=> $poppers{$a}} keys %poppers) {
    print $n, "\t", $poppers{$n}, "\n";
}
