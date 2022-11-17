#!/bin/bash

#  split_bam_by_species.sh
#  CC and AG?
#  Adapted by KA, 2022-1028, 2022-1116


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
    exit 1
}


#  Handle arguments, assign variables -----------------------------------------
help="""
Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
and 20 S narnavirus, and split them into distinct .bam files for each species,
with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
including chromosome M, all S. cerevisiae including chromosome M, and S.
cerevisiae chromosome M only.

Names of chromosomes in .bam infiles must be in the following format:
  - S. cerevisiae
    - I
    - II
    - III
    - IV
    - V
    - VI
    - VII
    - VIII
    - IX
    - X
    - XI
    - XII
    - XIII
    - XIV
    - XV
    - XVI

  - K. lactis
    - A
    - B
    - C
    - D
    - E

  - 20S
    - 20S

The split .bam files are saved to a user-defined out directory.

Dependencies:
  - samtools >= 1.9

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -s  what to split out; options: SC_all, SC_no_Mito, SC_VII, SC_XII,
      SC_VII_XII, SC_Mito, KL_all, virus_20S <chr; default: SC_all>
  -t  number of threads <int >= 1; default: 1>
"""

while getopts "h:u:i:o:s:t:" opt; do
    case "${opt}" in
        h) echo "${help}" && exit ;;
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        s) split="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${split}" ]] && split="SC_all"
[[ -z "${threads}" ]] && threads=1

# #TEST
# safe_mode=FALSE
# infile="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam/5781_G1_IN_merged.bam"
# outdir="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam"
# split="SC_all"
# threads=1
#
# echo "${safe_mode}"
# echo "${infile}"
# echo "${outdir}"
# echo "${split}"
# echo "${threads}"
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
        exit 1
        ;;
esac

#  Check that "${infile}" exists
[[ -f "${infile}" ]] ||
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

#  Check on the specified value for "${split}"
case "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" in
    sc_all | sc_no_mito | sc_vii | sc_xii | sc_vii_xii | sc_mito | \
    kl_all | virus_20s) \
        :
        ;;  # Do nothing and move on
    *) \
        echo -e "Exiting: -s ${split} must be one of the following:\n"
        echo -e "  - SC_all\n"
        echo -e "  - SC_no_Mito\n"
        echo -e "  - SC_VII\n"
        echo -e "  - SC_XII\n"
        echo -e "  - SC_VII_XII\n"
        echo -e "  - SC_Mito\n"
        echo -e "  - KL_all\n"
        echo -e "  - virus_20S\n"
        exit 1
        ;;
esac

#  Check on the specified (or default) number of threads
case "${threads}" in
    '' | *[!0-9]*) \
        echo -e "Exiting: -t ${threads} must be an integer >= 1.\n"
        exit 1
        ;;
    *) : ;;  # Do nothing and move on
esac

echo ""

#  Check for necessary dependencies; exit if not found
#TODO Should be loaded before calling this script, which inherits the env
# module="SAMtools/1.16.1-GCC-11.2.0"
# ml "${module}"
check_dependency samtools


#  Make additional variable assignments from the arguments --------------------
base="$(basename "${infile}")"
name="${base%.*}"
SC_all="${outdir}/${name}.split_SC_all.bam"
SC_no_Mito="${outdir}/${name}.split_SC_no_Mito.bam"
SC_VII="${outdir}/${name}.split_SC_VII.bam"
SC_XII="${outdir}/${name}.split_SC_XII.bam"
SC_VII_XII="${outdir}/${name}.split_SC_VII_XII.bam"
SC_Mito="${outdir}/${name}.split_SC_Mito.bam"
KL_all="${outdir}/${name}.split_KL_all.bam"
virus_20S="${outdir}/${name}.split_20S.bam"

#TEST
echo "${SC_all}"
echo "${SC_no_Mito}"
echo "${SC_VII}"
echo "${SC_XII}"
echo "${SC_VII_XII}"
echo "${SC_Mito}"
echo "${KL_all}"
echo "${virus_20S}"


#  Run samtools to split the bam by species/chromosome ------------------------
if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "sc_all" ]]; then
    samtools view \
        -@ "${threads}" \
        -h "${infile}" \
        I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito \
        -o "${SC_all}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "sc_no_mito" ]]; then
    samtools view \
        -@ "${threads}" \
        -h "${infile}" \
        I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
        -o "${SC_no_Mito}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "sc_vii" ]]; then
    samtools view \
        -@ "${threads}" \
        -h "${infile}" \
        VII \
        -o "${SC_VII}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "sc_xii" ]]; then
    samtools view \
        -@ "${threads}" \
        -h "${infile}" \
        XII \
        -o "${SC_XII}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "sc_vii_xii" ]]; then
    samtools view \
        -@ "${threads}" \
        -h "${infile}" \
        VII XII \
        -o "${SC_VII_XII}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "sc_mito" ]]; then
    samtools view \
    	-@ "${threads}" \
    	-h "${infile}" \
    	Mito \
    	-o "${SC_Mito}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "kl_all" ]]; then
    samtools view \
    	-@ "${threads}" \
    	-h "${infile}" \
    	A B C D E F \
    	-o "${KL_all}"
fi

if [[ "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" == "virus_20s" ]]; then
    samtools view \
    	-@ "${threads}" \
    	-h "${infile}" \
    	20S \
    	-o "${virus_20S}"
fi
