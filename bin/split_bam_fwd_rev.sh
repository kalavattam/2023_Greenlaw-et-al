#!/bin/bash

#  split_bam_fwd_rev.sh
#  CC and AG?
#  Adapted by KA, 2022-1027


#  Source functions -----------------------------------------------------------
check_dependency() {
    # Check if program is available in "${PATH}"; exit if not
    # 
    # :param 1: program/package <chr>
    command -v "${1}" &>/dev/null ||
        {
            echo "Exiting: ${1} not found. Install ${1}."
            # exit 1
        }
}


check_exit() {
    # Check the exit code of a child process
    # 
    # :param 1: exit code <int >= 0>
    # :param 2: program/package <chr>
    if [[ "${1}" == "0" ]]; then
        echo "${2} completed: $(date)"
    else
        err "#ERROR: ${2} returned exit code ${1}"
    fi
}


err() {
    # Print an error meassage, then exit with code 1
    # 
    # :param 1: program/package <chr>
    echo "${1} exited unexpectedly"
    # exit 1
}


print_usage() {
    # Print the help message and exit
    echo "${help}"
    # exit 1
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
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -t  number of threads <int >= 1>
  -c  remove bams for flags 147, 99, 83, and 163: \"TRUE\" or \"FALSE\" <lgl; default: TRUE>
"""

while getopts "h:u:i:o:t:c:" opt; do
    case "${opt}" in
        h) echo "${help}" && exit ;;
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        c) clean_up="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${threads}" ]] && threads=16
[[ -z "${clean_up}" ]] && clean_up=TRUE

#  Assignments for tests
# safe_mode=FALSE
# infile="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam/5781_G1_IN_merged.bam"
# outdir="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam"
# threads=1
# clean_up=TRUE
#
# echo "${safe_mode}"
# echo "${infile}"
# echo "${outdir}"
# echo "${threads}"
# echo "${clean_up}"
#
# ls -lhaFG "${infile}"
# ls -lhaFG "${outdir}"


#  Check variable assignments and dependencies --------------------------------
echo ""
echo "Running ${0}... "

#  Evaluate "${safe_mode}"
case "$(echo "${safe_mode}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-u: \"Safe mode\" is TRUE.\n" && set -Eeuxo pipefail ;;
    false | f) \
        echo -e "-u: \"Safe mode\" is FALSE.\n" ;;
    *) \
        echo -e "Exiting: -u \"safe mode\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

#  Check that "${infile}" exists
[[ -f "${infile}" ]] ||
    {
        echo -e "Exiting: -i ${infile} does not exist.\n"
        # exit 1
    }

#  Make "${outdir}" if it doesn't exist
[[ -d "${outdir}" ]] ||
    {
        echo -e "-o: Directory ${outdir} does not exist; making the directory.\n"
        mkdir -p "${outdir}"
    }

#  Evaluate "${clean_up}"
case "$(echo "${clean_up}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-c: \"Clean up\" is TRUE.\n" ;;
    false | f) \
        echo -e "-c: \"Clean up\" is FALSE.\n" ;;
    *) \
        echo -e "Exiting: -c \"clean up\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

echo ""

#  Check for necessary dependencies; exit if not found
module="SAMtools/1.16.1-GCC-11.2.0"
ml "${module}"
check_dependency samtools


#  Make additional variable assignments from the arguments --------------------
base="$(basename "${infile}")"
name="${base%.*}"
forward_1="${outdir}/${name}.fwd_99.bam"
forward_2="${outdir}/${name}.fwd_147.bam"
forward="${outdir}/${name}.fwd.bam"
reverse_1="${outdir}/${name}.rev_83.bam"
reverse_2="${outdir}/${name}.rev_163.bam"
reverse="${outdir}/${name}.rev.bam"

#  Test
# echo "${base}"
# echo "${name}"
# echo "${forward_1}"
# echo "${forward_2}"
# echo "${forward}"
# echo "${reverse_1}"
# echo "${reverse_2}"
# echo "${reverse}"


#  Forward strand ---------------------
#+
#+ 1. Alignments of the second in pair if they map to the forward strand
#+ 2. Alignments of the first in pair if they map to the reverse strand

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x20 - partner on reverse strand
#+ 0x40 - read one
#+ FLAGs 0x1 + 0x2 + 0x20 + 0x40 = 0x63 = 99 in decimal
samtools view -@ "${threads}" -bh -f 99 "${infile}" -o "${forward_1}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${forward_1}"
check_exit $? "samtools"

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x10 - on reverse strand
#+ 0x80 - read two
#+ FLAGs 0x1 + 0x2 + 0x10 + 0x80 = 0x93 = 147 in decimal
samtools view -@ "${threads}" -bh -f 147 "${infile}" -o "${forward_2}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${forward_2}"
check_exit $? "samtools"

#  Combine alignments that originate on the forward strand
samtools merge -@ "${threads}" -f "${forward_1}" "${forward_2}" -o "${forward}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${forward}"
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
samtools view -@ "${threads}" -bh -f 83 "${infile}" -o "${reverse_1}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${reverse_1}"
check_exit $? "samtools"

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x30 - partner on reverse strand
#+ 0x80 - read two
#+ FLAGs 0x1 + 0x2 + 0x20 + 0x80 = 0xA3 = 163 in decimal
samtools view -@ "${threads}" -bh -f 163 "${infile}" -o "${reverse_2}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${reverse_2}"
check_exit $? "samtools"

#  Combine alignments that originate on the reverse strand
samtools merge -@ "${threads}" -f "${reverse_1}" "${reverse_2}" -o "${reverse}"
check_exit $? "samtools"

samtools index "${reverse}"
check_exit $? "samtools"


#  Clean up -------------------------------------------------------------------
if \
    [[ "$(echo "${clean_up}" | tr '[:upper:]' '[:lower:]')" == "true" ]] || \
    [[ "$(echo "${clean_up}" | tr '[:upper:]' '[:lower:]')" == "t" ]]; then
        rm \
            "${forward_1}" \
            "${forward_2}" \
            "${reverse_1}" \
            "${reverse_2}"
        rm \
            "${forward_1}.bai" \
            "${forward_2}.bai" \
            "${reverse_1}.bai" \
            "${reverse_2}.bai"
fi
