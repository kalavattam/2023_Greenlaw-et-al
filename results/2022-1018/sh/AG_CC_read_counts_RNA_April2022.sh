#!/bin/bash
## this script will report total sc read counts
## then it will write them to a csv file.

module purge
ml SAMtools

echo File, Total  > KL_read_counts_try2.csv

for file in *.bam; do

  TOTAL=`samtools view ${file} | wc -l`

  echo ${file}, ${TOTAL} >> KL_read_counts_try2.csv

done
