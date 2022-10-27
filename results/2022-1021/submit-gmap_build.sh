#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-gmap_build.sh
#  KA

ml GMAP-GSNAP/2018-07-04-foss-2018b

location_for_output="${HOME}/genomes/sacCer3/GMAP"
fasta="${HOME}/genomes/sacCer3/sacCer3.fa"

# gmap_build -d <genome> [-k <kmer size>] <fasta_files...>
#  e.g., see section 4 of https://github.com/juliangehring/GMAP-GSNAP/blob/master/README
gmap_build \
	--dir "${location_for_output}" \
	--sort "none" \
	--db "sacCer3" \
	"${fasta}"

