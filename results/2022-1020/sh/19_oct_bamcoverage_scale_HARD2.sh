#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

# Please review the variables below and update if needed.
THREADS=8

module load deepTools/3.3.1-foss-2018b-Python-3.6.6

mkdir bigwigs_scaled_CPM


for file in *CT2*.bam ; do

    bamCoverage -b ${file} --normalizeUsing CPM --scaleFactor 1 --minMappingQuality 3 --binSize 10  -o ${file%.bam}_scale.bw

  done;

  for file in *CT4*.bam ; do

      bamCoverage -b ${file} --normalizeUsing CPM --scaleFactor 1 --minMappingQuality 3 --binSize 10  -o ${file%.bam}_scale.bw

    done;

for file in *CT10*.bam ; do

      bamCoverage -b ${file} --normalizeUsing CPM --scaleFactor 1.188235295 --minMappingQuality 3 --binSize 10  -o ${file%.bam}_scale.bw

    done;

for file in *CT8*.bam ; do

      bamCoverage -b ${file} --normalizeUsing CPM --scaleFactor 2.097195449 --minMappingQuality 3 --binSize 10  -o ${file%.bam}_scale.bw

    done;

for file in *CT6*.bam ; do

    bamCoverage -b ${file} --normalizeUsing CPM --scaleFactor 1.662186677 --minMappingQuality 3 --binSize 10  -o ${file%.bam}_scale.bw

  done;






  mv *scale.bw bigwigs_scaled_2

  done
