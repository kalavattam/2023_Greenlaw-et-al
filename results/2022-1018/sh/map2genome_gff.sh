#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

############################################################
################# CONFIGURATION VARIABLES ##################

# Please review the variables below and update if needed.
THREADS=8

module purge
module load GMAP-GSNAP/2018-07-04-foss-2018b
module load SAMtools/1.10-GCCcore-8.3.0

for file in *.fasta; do

   $WRAP gmap -d S288C -D /home/agreenla/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/map_trin_to_genome/try2/S288C \
         -A ${file} --format=gff3_gene samse > ${file%.fasta}.gff
 done;

  mkdir gffs
  mv *.gff gffs


done
