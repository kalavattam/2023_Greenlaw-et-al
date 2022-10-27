#!/bin/bash

#  split_bam_paired_end.sh
#  CC and AG?
#  Adapted by KA, 2022-1027


#  Source functions -----------------------------------------------------------
check_dependency() {
    # Check if program is available in "${PATH}"; exit if not
    command -v "${1}" &>/dev/null ||
        {
            echo "Exiting: ${1} not found. Install ${1}."
            exit 1
        }
}


check_exit() {
    # Check the exit code of a child process
    # 
    # :param 1: exit code <int >= 0>
    # :param 2: program/package <chr>
    if [ "${1}" == "0" ]; then
        echo "[done] ${2} $(date)"
    else
        err "[error] ${2} returned exit code ${1}"
    fi
}


err() {
    # Print an error meassage, then exit with code 1
    # 
    # :param 1: program/package <chr>
    echo "${1} exited unexpectedly"
    exit 1
}


print_usage() {
	#  Print the help message and exit
	echo "${help}"
	exit 1
}


#  Handle arguments, assign variables -----------------------------------------
help="""
Take user-input .bam files and split them into distinct .bam files for the
forward and reverse strands, saving the split .bam files to a user-defined out
directory.

Dependencies:
  - samtools >= 1.9

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <logical; default: FALSE>
  -i  infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
"""

while getopts "h:u:i:o" opt; do
	case "${opt}" in
		h) echo "${help}" && exit ;;
		u) safe_mode="${OPTARG}" ;;
		i) infile="${OPTARG}" ;;
		o) outdir="${OPTARG}" ;;
		*) print_usage ;;
	esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage


#  Check variable assignments -------------------------------------------------
echo ""
echo "Running ${0}... "

#  Evaluate "${safe_mode}"
case "$(echo "${safe_mode}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-u: \"Safe mode\" is TRUE." && set -Eeuxo pipefail ;;
    false | f) \
        echo -e "-u: \"Safe mode\" is FALSE." ;;
    *) \
        echo -e "Exiting: -u \"safe mode\" argument must be TRUE or FALSE.\n"
        exit 1
        ;;
esac

#  Check for necessary dependencies; exit if not found
check_dependency samtools

#  Check that "${infile}" exists
[[ -d "${infile}" ]] ||
    {
        echo -e "Exiting: -i ${infile} does not exist.\n"
        exit 1
    }

#  Make "${outdir}" if it doesn't exist
[[ -d "${outdir}" ]] ||
    {
        echo -e "-o: Directory ${outdir} does not exist; making the directory.\n"
        mkdir -p "${outdir}"
    }

echo ""


#  Make additional variable assignments from the arguments --------------------
base="$(basename "${infile}")"
name="${base%.*}"
forward_1=${outdir}/${name}_fwd1.bam
forward_2=${outdir}/${name}_fwd2.bam
forward=${outdir}/${name}_fwd.bam
reverse_1=${outdir}/${name}_rev1.bam
reverse_2=${outdir}/${name}_rev2.bam
reverse=${outdir}/${name}_rev.bam


#  Forward strand ---------------------
#+
#+ 1. Alignments of the second in pair if they map to the forward strand
#+ 2. Alignments of the first in pair if they map to the reverse strand

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x20 - partner on reverse strand
#+ 0x40 - read one
#+ FLAGs 0x1 + 0x2 + 0x20 + 0x40 = 0x63 = 99 in decimal
samtools view -bh -f 99 "${infile}" > "${forward_1}"
check_exit $? "samtools"

samtools index "${forward_1}"
check_exit $? "samtools"

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x10 - on reverse strand
#+ 0x80 - read two
#+ FLAGs 0x1 + 0x2 + 0x10 + 0x80 = 0x93 = 147 in decimal
samtools view -bh -f 147 "${infile}" > "${forward_2}"
check_exit $? "samtools"

samtools index "${forward_2}"
check_exit $? "samtools"

#  Combine alignments that originate on the forward strand
samtools merge -f "${forward}" "${forward_1}" "${forward_2}"
check_exit $? "samtools"

samtools index "${forward}"
check_exit $? "samtools"


#  Reverse strand ---------------------
#+
#+ 1. Alignments of the second in pair if they map to the reverse strand
#+ 2. Alignments of the first in pair if they map to the forward strand

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x10 - reverse strand
#+ 0x40 - read one
#+ FLAGs 0x1 + 0x2 + 0x10 + 0x40 = 0x53 = 83 in decimal
samtools view -bh -f 83 "${infile}" > "${reverse_1}"
check_exit $? "samtools"

samtools index "${reverse_1}"
check_exit $? "samtools"

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x30 - partner on reverse strand
#+ 0x80 - read two
#+ FLAGs 0x1 + 0x2 + 0x20 + 0x80 = 0xA3 = 163 in decimal
samtools view -bh -f 163 "${infile}" > "${reverse_2}"
check_exit $? "samtools"

samtools index "${reverse_2}"
check_exit $? "samtools"

#  Combine alignments that originate on the reverse strand
samtools merge -f "${reverse}" "${reverse_1}" "${reverse_2}"
check_exit $? "samtools"

samtools index "${reverse}"
check_exit $? "samtools"
