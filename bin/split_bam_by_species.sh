#!/bin/bash

#  split_bam_by_species.sh
#  CC and AG?
#  Adapted by KA, 2022-1028


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
Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
and 20 S narnavirus, and split them into distinct .bam files for each species,
with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
including chrM, all S. cerevisiae including chrM, and S. cerevisiae chrM only.
The split .bam files are saved to a user-defined out directory.

Dependencies:
  - samtools >= 1.9

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <logical; default: FALSE>
  -i  infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -t  number of threads <int >= 1>
"""

while getopts "h:u:i:o:t:" opt; do
    case "${opt}" in
        h) echo "${help}" && exit ;;
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${threads}" ]] && threads=16

#  Assignments for tests
safe_mode=FALSE
infile="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam/5781_G1_IN_merged.bam"
outdir="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam"
threads=1

echo "${safe_mode}"
echo "${infile}"
echo "${outdir}"
echo "${threads}"

ls -lhaFG "${infile}"
ls -lhaFG "${outdir}"


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

echo ""

#  Check for necessary dependencies; exit if not found
module="SAMtools/1.16.1-GCC-11.2.0"
ml "${module}"
check_dependency samtools


#  Make additional variable assignments from the arguments --------------------
base="$(basename "${infile}")"
name="${base%.*}"
split_SC="${outdir}/${name}.split_SC.bam"
split_SC_Mito="${outdir}/${name}.split_SC_Mito.bam"
split_Mito="${outdir}/${name}.split_Mito.bam"
split_KL="${outdir}/${name}.split_KL.bam"
split_20S="${outdir}/${name}.split_20S.bam"

echo "${split_SC}"
echo "${split_SC_Mito}"
echo "${split_Mito}"
echo "${split_KL}"
echo "${split_20S}"


#  Run samtools to split the bam by species/chromosome ------------------------
samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
	-o "${split_SC}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito \
	-o "${split_SC_Mito}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	Mito \
	-o "${split_Mito}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	A B C D E F \
	-o "${split_KL}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	20S \
	-o "${split_20S}"
