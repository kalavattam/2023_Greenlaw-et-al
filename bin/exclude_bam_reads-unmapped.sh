#!/bin/bash

#  exclude_bam_reads-unmapped.sh
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


check_argument_flagstat() {
    case "$(echo "$(convert_chr_lower "${flagstat}")")" in
        true | t) \
            flagstat=1
            echo -e "-f: \"Run samtools flagstat\" is TRUE."
            ;;
        false | f) \
            flagstat=0
            echo -e "-f: \"Run samtools flagstat\" is FALSE."
            ;;
        *) \
            echo -e "Exiting: -f \"flagstat\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_define_variables_etc() {
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

    #  Check on value assigned to "${flagstat}"
    check_argument_flagstat

    #  Check on value assigned to "${threads}"
    check_argument_threads
    
    echo ""

    #  Make additional variable assignments from the arguments
    base="$(basename "${infile}")"
    outfile="${base%.bam}.exclude-unmapped.bam"
}


main() {
    #  ------------------------------------
    #  Run samtools to exclude unmapped alignments from .bam infile
    #  ------------------------------------
    echo ""
    echo "Running ${0}... "

    check_define_variables_etc


    #  Exclude primary alignments from a bam infile; write a bam outfile
    echo "Filtering out unmapped..."

    samtools view \
        -@ "${threads}" \
        -b -f 0x4 -f 0x8 \
        "${infile}" \
        -o "${outdir}/${outfile}"
        check_exit $? "samtools"


    #  Run flagstat on primary alignment bam outfiles -----------------------------
    if [[ $((flagstat)) -eq 1 ]]; then
        #  Make subdirectories
        flag_m="${outdir}/flagstat"
        mkdir -p "${flag_m}"

        #  Mapped
        samtools flagstat \
            -@ "${threads}" \
            "${outdir}/${outfile}" \
                > "${flag_m}/${outfile%.bam}.flagstat.txt" &
            check_exit $? "samtools"

        wait
    fi
}


#  ------------------------------------
#  Handle arguments, assign variables
#  ------------------------------------
help="""
exclude_bam_alignments-unmapped.sh
----------------------------------
Exclude unmapped alignments from bam infile. Name of bam outfile will be
derived from the infile.

Dependencies:
  - samtools >= #TBD

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  bam infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -f  run samtools flagstat on bams: \"TRUE\" or \"FALSE\" <lgl>
  -t  number of threads <int >= 1; default: 1>
"""

while getopts "h:u:i:o:f:t:" opt; do
    case "${opt}" in
        h) echo "${help}" && exit ;;
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${flagstat}" ]] && print_usage
[[ -z "${threads}" ]] && threads=1

main
