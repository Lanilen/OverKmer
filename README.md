# OverKmer
Scripts for identifying telomere sequences with Illumina data.

The idea of this script is to allow for the identification of the telomere repeat
in any species, given a sifficient amount of Illumina reads (works with as little
as 2 million).

Canonically, the telomere is considered to be a repetition of the kmer CCCTAA or
any shift of it (i.e., CCTAAC, CTAACC, etc.). This is considered known for humans
and mammals, but not necessarily on every species.

What this script does is, for a given, specific kmer length, it takes the first
K kmers of that length that appear in a read, and calculate whether 90%+ of said
read is comprised of repetitions of that kmer.

This works better than just counting all possible kmers of size K, as the telomeres
are not particularly abundant in most species. As kmers of length 6 (the canonical
mammal repeat) are not unique, the numbers for many other kmers are often much higher
that the telomere one.

The only other kmers that ever cover as many >90% reads as the telomere repeats are
poly-A tails (and their reverse complement), and, in the case of untrimed 2-Channel
SBS Illumina data, poly-G errors. In test done on moneky, human, and bird data, all
other repeats, including microsatellites, never come close to the telomere.

Output should look something like this:

GGGTTA  12345
CCCTAA  9656
TTAGGG  9638
GTTAGG  9382
GGTTAG  9234
CCTAAC  8341
CTAACC  7797
TAGGGT  7648
AGGGTT  7043
TAACCC  3251
ACCCTA  3077
AACCCT  2641
AAAAAA  1395
GAAAAA  129
AAAAGA  117
AAAAAG  110
AAAGAA  95


As you can see, the canonical telomere repeat, its shifts, and their reverse complements
take all the top spots.

This work best with trimmed Illumina data, but given enough reads, it makes little
difference.

To run the script:

[user@serv~] perl find_overkmer_simplified.pl reads.fastq kmer_length

As mentioned, 6 is canonical in mammals. Trying with more or less than the true length of
the telomere repeat will put the poly-A and, if applicable, poly-G at the top followed by
random microsatellites with a wide gap. Example on 2.5M reads:

Length 5:
AAAAA	27
TTTTT	14
AAGGA	2
AGGAA	2
GGAAA	2
GGGAA	2
AAAGG	1
GAAGG	1
GAAAG	1
GGAAG	1
GGGGG	1

Length 6:
AAAAAA	19
ACCCTA	16
CCCTAA	16
TAACCC	16
TTTTTT	15
CTAACC	15
GTTAGG	14
AACCCT	14
CCTAAC	14
TTAGGG	13
GGTTAG	12
TAGGGT	8
GGGTTA	8
AGGGTT	7
TTCTTC	3
CACACA	3
AAGAAG	2
TCTTCT	2
AGAAGA	2
GAAGAA	2
ACACAC	1
GAGGAG	1
CTTCTT	1
GGAGGA	1
AGGAGG	1
GTGTGT	1
AGGGGA	1
TGTGTG	1
CTCTCT	1


Length 7:
AAAAAAA	19
TTTTTTT	14
CCGTCTC	1
CTCCCGT	1
CCCGTCT	1
TCCCGTC	1
