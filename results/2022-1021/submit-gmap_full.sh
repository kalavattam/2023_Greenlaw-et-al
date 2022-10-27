#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

ml GMAP-GSNAP/2018-07-04-foss-2018b
ml SAMtools/1.16.1-GCC-11.2.0

d_Kris="${HOME}/tsukiyamalab/Kris"
d_proj="2022_transcriptome-construction/results"
d_exp="2022-1021/trinity_trin4s_5781_Q_IP_sorted"
fasta="Trinity-GG.fasta"

gmap \
	-d "sacCer3" \
	-D "${HOME}/genomes/sacCer3/GMAP" \
    -A "${d_Kris}/${d_proj}/${d_exp}/${fasta}" \
    --format="gff3_gene" "samse" \
    	> "${d_Kris}/${d_proj}/${d_exp}/${fasta%.fasta}.GMAP.gff"

