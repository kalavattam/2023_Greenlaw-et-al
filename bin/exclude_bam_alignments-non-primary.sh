#!/bin/bash

#  exclude_bam_alignments-non-primary.sh
#  KA


#  Source functions into environment ------------------------------------------
functions="$(dirname "${BASH_SOURCE}")/functions.sh"
if [[ -f "${functions}" ]]; then
    source "${functions}"
else
    printf "%s\n" "Exiting: functions.sh not found."
    exit 1
fi


#  Handle arguments, assign variables -----------------------------------------
help="""
${0}:
Exclude non-primary alignments from bam infile. Name of bam outfile will be
derived from the infile.

Dependencies:
  - samtools >= #TBD

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  bam infile, including path <chr>
  -o  path for outfiles <chr>
  -f  run samtools flagstat on bams: \"TRUE\" or \"FALSE\" <lgl>
  -p  number of cores for parallelization <int >= 1; default: 1>
"""

while getopts "h:u:i:o:f:p:" opt; do
    case "${opt}" in
        h) echo "${help}" ;;
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outpath="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        p) parallelize="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outpath}" ]] && print_usage
[[ -z "${flagstat}" ]] && print_usage
[[ -z "${parallelize}" ]] && parallelize=1


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
[[ -f "${infile}" ]] ||
    {
        echo -e "Exiting: -i ${infile} does not exist.\n"
        exit 1
    }

#  Make "${outpath}" if it doesn't exist
[[ -d "${outpath}" ]] ||
    {
        echo -e "-o: Directory ${outpath} does not exist; making the directory.\n"
        mkdir -p "${outpath}"
    }

#  Evaluate "${flagstat}"
case "$(echo "${flagstat}" | tr '[:upper:]' '[:lower:]')" in
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
        exit 1
        ;;
esac

#  Check "${parallelize}"
[[ ! "${parallelize}" =~ ^[0-9]+$ ]] &&
    {
        echo -e "Exiting: -p \"parallelize\" argument must be an integer.\n"
        exit 1
    }

[[ ! $((parallelize)) -ge 1 ]] &&
    {
        echo -e "Exiting: -p \"parallelize\" argument must be an integer >= 1.\n"
        exit 1
    }

echo ""


#  Assign variables needed for the pipeline -----------------------------------
base="$(basename "${infile}")"
outfile="${base%.bam}.primary.bam"


#  Make subdirectories for primary-alignment outfiles -------------------------
mkdir -p "${outpath}"


#  Exclude primary alignments from a bam infile; write a bam outfile ----------
echo "[info] Separating bam files..."

samtools view \
-@ "${parallelize}" \
-b -F 256 "${infile}" \
-o "${outpath}/${outfile}"
check_exit $? "samtools"


#  Run flagstat on primary alignment bam outfiles -----------------------------
if [[ $((flagstat)) -eq 1 ]]; then
    #  Make subdirectories
    flag_m="${outpath}/flagstat"
    mkdir -p "${flag_m}"

    #  Mapped
    samtools flagstat \
    -@ "${parallelize}" \
    "${outpath}/${outfile}" \
        > "${flag_m}/${outfile%.bam}.flagstat.txt" &
    check_exit $? "samtools"

    wait
fi
