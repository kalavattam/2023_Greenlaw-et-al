#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

# Please review the variables below and update if needed.
THREADS=8

module purge
module load deepTools

mkdir  mRNA_TTS_TES_pass1


for file in *.bw; do

  computeMatrix reference-point -b 500 -a 500 --referencePoint TSS  -S ${file} -R mRNAonly.bed  \
  -o ${file%.bw}_TTS.mat.gz --outFileNameMatrix ${file%.bw}_TTS.tab

  computeMatrix reference-point -b 500 -a 500 --referencePoint TES  -S ${file} -R mRNAonly.bed  \
  -o ${file%.bw}_TES.mat.gz --outFileNameMatrix ${file%.bw}_TES.tab

  done

for file in *.mat.gz; do

      computeMatrixOperations filterStrand -m ${file} -s + -o ${file%.mat.gz}_+_filtered.mat.gz
      computeMatrixOperations filterStrand -m ${file} -s - -o ${file%.mat.gz}_-_filtered.mat.gz

      done

for file in *filtered.mat.gz; do

    plotHeatmap -m ${file%.gz}.gz --colorMap Purples  --heatmapHeight 13 -o ${file%.gz}.png --outFileSortedRegions ${file%.gz}mapped.bed --dpi 600

    done


  mv *.gz mRNA_TTS_TES_pass1
  mv *.tab mRNA_TTS_TES_pass1
  mv *.png mRNA_TTS_TES_pass1
  mv *mapped.bed mRNA_TTS_TES_pass1




done
