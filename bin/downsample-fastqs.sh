#!/bin/bash

#  downsample-fastqs.sh
#  KA

#  The package 'BBMap' needs to be in your "${PATH}"
#+ Get it here: https://sourceforge.net/projects/bbmap/

f1="${1}"
f2="${2}"
samp="${3}"  # e.g., "50k"
dir_out="${4}"

#  Be sensitive to whether the extension is "fastq.gz" or "fastq"
if [[ "${f1}" == *"fastq.gz" ]]; then
	reformat.sh \
		in1="${f1}" \
		in2="${f2}" \
		out1="${dir_out}/$(basename "${f1%.fastq.gz}.${samp}.fastq.gz")" \
		out2="${dir_out}/$(basename "${f2%.fastq.gz}.${samp}.fastq.gz")" \
		samplereadstarget="${samp}"
elif [[ "${f1}" == *"fastq" ]]; then
	reformat.sh \
		in1="${f1}" \
		in2="${f2}" \
		out1="${dir_out}/$(basename "${f1%.fastq}.${samp}.fastq")" \
		out2="${dir_out}/$(basename "${f2%.fastq}.${samp}.fastq")" \
		samplereadstarget="${samp}"
fi
