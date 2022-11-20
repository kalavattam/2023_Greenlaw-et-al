#!/bin/bash

#  split_bam_by_species.sh
#  KA


#  ------------------------------------
#  Source external functions into environment
#  ------------------------------------
functions="$(dirname "${BASH_SOURCE}")/functions.sh"
if [[ -f "${functions}" ]]; then
    source "${functions}"
else
    printf "%s\n" "Exiting: functions.sh not found."
    exit 1
fi


check_etc() {
    #  ------------------------------------
    #  Check and make variable assignments 
    #  ------------------------------------
    #  Check for necessary dependencies; exit if not found
    check_dependency samtools

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode

    #  Check that "${infile}" exists
    check_exists_file "${infile}"

    #  If TRUE exist, then make "${outdir}" if it does not exist; if FALSE,
    #+ then exit if "${outdir}" does not exist
    check_exists_directory TRUE "${outdir}"  #TODO Fix this function

    #  Check on the specified value for "${split}"
    case "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" in
        sc_all | sc_no_mito | sc_vii | sc_xii | sc_vii_xii | sc_mito | \
        kl_all | virus_20s) \
            :
            ;;  # Do nothing and move on
        *) \
            message="""
            Exiting: -s \"\${split}\" must be one of the following:
              - SC_all
              - SC_no_Mito
              - SC_VII
              - SC_XII
              - SC_VII_XII
              - SC_Mito
              - KL_all
              - virus_20S
            """
            printf "%s\n\n" "${message}"
            exit 1
            ;;
    esac

    #  Check on value assigned to "${threads}"
    check_argument_threads

    echo ""

    #  Make additional variable assignments from the arguments
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

    # #TEST
    # echo "${SC_all}"
    # echo "${SC_no_Mito}"
    # echo "${SC_VII}"
    # echo "${SC_XII}"
    # echo "${SC_VII_XII}"
    # echo "${SC_Mito}"
    # echo "${KL_all}"
    # echo "${virus_20S}"
}


split_with_samtools() {
    what="""
    split_with_samtools()
    ---------------------
    Use samtools to filter a bam file such that it contains only chromosome(s)
    specified with ${0} argument -s

    :param 1: threads <int >= 1>
    :param 2: bam infile, including path <chr>
    :param 3: chromosomes to retain <chr>
    :param 4: bam outfile, including path <chr>
    :return: param 2 filtered to include only param 3 in param 4

    #TODO Checks...
    """
    samtools view -@ "${1}" -h "${2}" ${3} -o "${4}"
}


main() {
    #  ------------------------------------
    #  Run samtools to split the bam by species/chromosome
    #  ------------------------------------

    echo ""
    echo "Running ${0}... "

    # #TEST
    # threads=1
    # infile="exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam"
    # chr="VII XII"
    # SC_all="exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_VII_XII.bam"

    if [[ "$(echo "$(convert_chr_lower "${split}")")" == "sc_all" ]]; then
        chr="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "sc_no_mito" ]]; then
        chr="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "sc_vii" ]]; then
        chr="VII"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "sc_xii" ]]; then
        chr="XII"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "sc_vii_xii" ]]; then
        chr="VII XII"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "sc_mito" ]]; then
        chr="Mito"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "kl_all" ]]; then
        chr="A B C D E F"
    elif [[ "$(echo "$(convert_chr_lower "${split}")")" == "virus_20s" ]]; then
        chr="20S"
    else
        chr=""
        printf "%s\n\n" "Exiting: -s is not one of the species options."
        # exit 1
    fi

    split_with_samtools "${threads}" "${infile}" "${chr}" "${SC_all}"
}


#  ------------------------------------
#  Handle arguments, assign variables
#  ------------------------------------
help="""
split_bam_by_species.sh
-----------------------
Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
and 20 S narnavirus, and split them into distinct .bam files for each species,
with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
including chromosome M, all S. cerevisiae including chromosome M, and S.
cerevisiae chromosome M only.

Names of chromosomes in .bam infiles must be in the following format:
  - S. cerevisiae (SC)
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
    - Mito

  - K. lactis (KL)
    - A
    - B
    - C
    - D
    - E

  - 20 S narnavirus
    - 20S

The split .bam files are saved to a user-defined out directory.

Dependencies:
  - samtools >= #TBD

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  bam infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -s  what to split out; options: SC_all, SC_no_Mito, SC_VII, SC_XII,
      SC_VII_XII, SC_Mito, KL_all, virus_20S <chr; default: SC_all>

            SC_all  return all SC chromosomes, including Mito (default)
        SC_no_Mito  return all SC chromosomes, excluding Mito
            SC_VII  return only SC chromosome VII
            SC_XII  return only SC chromosome XII
        SC_VII_XII  return only SC chromosomes VII and XII
           SC_Mito  return only SC chromosome Mito
            KL_all  return all KL chromosomes
         virus_20S  return only 20 S narnavirus

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
# infile="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam/5781_G1_IN_merged.bam"
# outdir="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam"
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


check_etc


main
