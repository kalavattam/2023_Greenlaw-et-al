#!/usr/bin/env bash

#  make_rRNA.sh
#  Kamil Slowikowski
#  2014-1212
#
#  Modified:
#  Arindam Ghosh
#  2019-0724
#
#  Modified:
#  Kris Alavattam
#  2022-0902
#
#  Make an interval_list file suitable for picard CollectRnaSeqMetrics.jar.
#
#  Picard Tools CollectRnaSeqMetrics.jar:
#  broadinstitute.github.io/picard/command-line-overview.html#CollectRnaSeqMetrics
#
#  #NOTE #TODO This script has not yet been tested
#
#  Below, default is to work with GRCh38.p13 / Ensembl release 105 / UCSC version 39
#  Relevant files available at, for example, gencodegenes.org/human/release_39.html
#
#  Dependencies:
#      - samtools
#      - perl
#      - awk
#      - Linux utilities such as gzip, grep, cut, sort
#
#
#  1. Prep work: Obtain a fasta file for the primary assembly of a given
#     organism, and prepare a "chromosome sizes" file from the fasta sequence
#
#     #  For example...
#     #  Here, "${dir}" is a directory containing fasta file, gtf file, etc.
#     cd "${dir}" ||
#         {
#             echo "cd into ${dir} failed. Check on this."
#         }
#
#     curl https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_39/GRCh38.primary_assembly.genome.fa.gz \
#         > ./GRCh38.primary_assembly.genome.fa.gz
#
#     samtools faidx ./GRCh38.primary_assembly.genome.fa.gz
#
#     cut -f1,2 ./GRCh38.primary_assembly.genome.fa.fai \
#         > GRCh38.primary_assembly.genome.sizes
#
#     #  Make available an unzipped version of the fasta file
#     gzip -dk GRCh38.primary_assembly.genome.fa.gz
#
#
#  2. Prep work: Obtain a gtf file for the primary assembly of a given organism
#
#     #  For example,
#     cd "${dir}" ||
#         {
#             echo "cd into ${dir} failed. Check on this."
#         }
#
#     curl https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_39/gencode.v39.primary_assembly.annotation.gtf.gz \
#         > gencode.v39.primary_assembly.annotation.gtf.gz
#
#     gzip -dk gencode.v39.primary_assembly.annotation.gtf.gz
#

#TODO Interactive description of arguments, etc.

#  Input files needed to make rRNA interval_list file
chrom_sizes="${1:-"GRCh38.primary_assembly.genome.sizes"}"
genes="${2:-"gencode.v39.primary_assembly.annotation.gtf"}"

#  Output file suitable for Picard CollectRnaSeqMetrics.jar.
rRNA="${3:-"gencode.v39.rRNA.interval_list"}"

#  Sequence names and lengths (must be tab-delimited)
perl -lane 'print "\@SQ\tSN:$F[0]\tLN:$F[1]\tAS:GRCh38"' "${chrom_sizes}" \
    | grep -v _ \
    >> "${rRNA}"

#  Intervals for rRNA transcripts
grep 'gene_biotype "rRNA"' "${genes}" \
    | awk '$3 == "gene"' \
    | cut -f1,4,5,7,9 \
    | perl -lane '
        /gene_id "([^"]+)"/ or die "no gene_id on $.";
        print join "\t", (@F[0,1,2,3], $1)
    ' \
    | sort -k1V -k2n -k3n \
    >> "${rRNA}"
