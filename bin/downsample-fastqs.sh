#!/bin/bash

#  downsample-fastqs.sh
#  KA

#  The package 'BBMap' needs to be in your "${PATH}"
#+ Get it here: https://sourceforge.net/projects/bbmap/

f1="${1}"
f2="${2}"
samp="${3:-50k}"
dir_out="${4}"

reformat.sh \
	in1="${f1}" \
	in2="${f2}" \
	out1="${dir_out}/$(basename "${f1%.fastq.gz}.${samp}.fastq.gz")" \
	out2="${dir_out}/$(basename "${f2%.fastq.gz}.${samp}.fastq.gz")" \
	samplereadstarget="${samp}"
