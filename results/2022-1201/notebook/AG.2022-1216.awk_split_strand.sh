#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

# Please review the variables below and update if needed.
THREADS=8

module purge

mkdir plus
mkdir minus

for file in *.gff3; do

  awk '($7=="+")' ${file} > ${file%.gff3}_plus.gff3
  awk '($7=="-")' ${file} > ${file%.gff3}_minus.gff3


  done

  mv *plus.gff3 plus
  mv *minus.gff3 minus

done
