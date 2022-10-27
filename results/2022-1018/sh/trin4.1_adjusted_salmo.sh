#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

############################################################
################# CONFIGURATION VARIABLES ##################

# Please review the variables below and update if needed.
THREADS=8

module purge
module load Trinity/2.10.0-foss-2019b-Python-3.7.4 # loads trinity


for file in *.bam; do
#must be coordinate sorted bam

   $WRAP Trinity --genome_guided_bam ${file} \
          --max_memory 50G --SS_lib_type FR\
          --normalize_max_read_cov 200 --jaccard_clip --genome_guided_max_intron 1002\
          --min_kmer_cov 2 --max_reads_per_graph 500000 --min_glue 2 --group_pairs_distance 700\
          --min_contig_length 200 --full_cleanup --output ./trinity_trin4s_${file%.bam_sorted_new.bam}


#NOTES
#ADDED max path per node and capped at 5
#changed group pairs distance from 300 to 700 (but may need to set differently for different libraries)
#decreased min glue from 5 to 2



 done;
