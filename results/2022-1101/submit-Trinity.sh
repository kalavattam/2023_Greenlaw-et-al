#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Trinity.sh
#  KA

module load Trinity/2.10.0-foss-2019b-Python-3.7.4

file="5781_Q_IP_sorted.chrVII.bam"  # Separately, try 5781_Q_IP_sorted.bam

Trinity \
    --genome_guided_bam "${file}" \
    --CPU "${SLURM_CPUS_ON_NODE}" \
    --max_memory 50G \
    --SS_lib_type FR \
    --normalize_max_read_cov 200 \
    --jaccard_clip \
    --genome_guided_max_intron 1002 \
    --min_kmer_cov 2 \
    --max_reads_per_graph 500000 \
    --min_glue 2 \
    --group_pairs_distance 700 \
    --min_contig_length 200 \
    --full_cleanup \
    --output "./trinity_${file%.bam}"
