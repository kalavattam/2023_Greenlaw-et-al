#!/bin/bash

#  exclude_bam_reads-unmapped.sh
#  KA


check_dependency() {
    what="""
    check_dependency()
    ------------------
    Check if program is available in \"\${PATH}\"; exit if not
    
    :param 1: program to be checked <chr>
    :return: NA
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        command -v "${1}" &>/dev/null ||
            {
                printf "%s\n" "Exiting: \"${1}\" not found in \"\${PATH}\"."
                printf "%s\n\n" "         Check your env or install \"${1}\"?"
                # exit 1
            }
    fi
}


check_argument_safe_mode() {
    what="""
    check_argument_safe_mode()
    --------------------------
    Run script in \"safe mode\" (\`set -Eeuxo pipefail\`) if specified
    
    :param 1: run script in safe mode: TRUE or FALSE <lgl> [default: FALSE]
    :return: NA

    #TODO Check that param is not empty or inappropriate format/string
    """
    case "$(convert_chr_lower "${1}")" in
        true | t) \
            printf "%s\n" "-u: \"Safe mode\" is TRUE."
            set -Eeuxo pipefail
            ;;
        false | f) \
            printf "%s\n" "\"Safe mode\" is FALSE." ;;
        *) \
            printf "%s\n" "Exiting: \"Safe mode\" must be TRUE or FALSE."
            # exit 1
            ;;
    esac
}


check_exists_file() {
    what="""
    check_exists_file()
    -------------------
    Check that a file exists; exit if it doesn't
    
    :param 1: file, including path <chr>
    :return: NA

    #TODO Check that param is not an inappropriate format/string
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    elif [[ ! -f "${1}" ]]; then
        printf "%s\n\n" "Exiting: File \"${1}\" does not exist."
        # exit 1
    else
        :
    fi
}


check_exists_directory() {
    what="""
    check_exists_directory()
    ------------------------
    Check that a directory exists; if it doesn't, then either make it or exit
    
    :param 1: create directory if not found: TRUE or FALSE <lgl>
    :param 2: directory, including path <chr>
    :return: NA

    #TODO Check that params are not empty or inappropriate formats/strings
    """
    case "$(convert_chr_lower "${1}")" in
        true | t) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "${2} doesn't exist; mkdir'ing it."
                    mkdir -p "${2}"
                }
            ;;
        false | f) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "Exiting: ${2} does not exist."
                    exit 1
                }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not \"TRUE\" or \"FALSE\"."
            printf "%s\n" "${what}"
            exit 1
            ;;
    esac
}


check_argument_flagstat() {
    case "$(convert_chr_lower "${flagstat}")" in
        true | t) \
            flagstat=1
            printf "%s\n" "\"Run samtools flagstat\" is TRUE."
            ;;
        false | f) \
            flagstat=0
            printf "%s\n" "\"Run samtools flagstat\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"flagstat\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_threads() {
    what="""
    check_argument_threads()
    ---------------
    Check the value assigned to variable for threads/cores in script

    :param 1: value assigned to variable for threads/cores <int >= 1>
    :return: NA

    #TODO Checks...
    """
    case "${1}" in
        '' | *[!0-9]*) \
            printf "%s\n" "Exiting: argument must be an integer >= 1."
            # exit 1
            ;;
        *) : ;;
    esac
}


convert_chr_lower() {
    what="""
    convert_chr_lower()
    -------------------
    Convert alphabetical characters in a string to lowercase letters
    
    :param 1: string <chr>
    :return: converted string (stdout) <chr>
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        string_in="${1}"
        string_out="$(printf %s "${string_in}" | tr '[:upper:]' '[:lower:]')"

        echo "${string_out}"
    fi
}


print_usage() {
    what="""
    print_usage()
    -------------
    Print the script's help message and exit

    :param 1: help message assigned to a variable within script <chr>
    :return: help message (stdout) <chr>

    #TODO Checks...
    """
    echo "${1}"
    exit 1
}


check_etc() {
    #  ------------------------------------
    #  Check depencies, and check and make variable assignments 
    #  ------------------------------------
    #  Check for necessary dependencies; exit if not found
    check_dependency samtools

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode "${safe_mode}"

    #  Check that "${infile}" exists
    check_exists_file "${infile}"

    #  If TRUE, then make "${outdir}" if it does not exist; if FALSE (i.e.,
    #+ "${outdir}" does not exist), then exit
    check_exists_directory TRUE "${outdir}"

    #  Check on value assigned to "${threads}"
    check_argument_threads "${threads}"

    #  Check on value assigned to "${flagstat}"
    check_argument_flagstat
    
    echo ""

    #TODO Not sure if I want these assignments in this function...
    #  Make additional variable assignments from the arguments
    base="$(basename "${infile}")"
    outfile="${base%.bam}.exclude-unmapped.bam"

    echo ""
}


main() {
    #  ------------------------------------
    #  Run samtools to exclude unmapped reads from bam infile
    #  ------------------------------------
    echo ""
    echo "Running ${0}... "

    echo "Filtering out unmapped reads..."

    samtools view \
        -@ "${threads}" \
        -b -F 0x4 -F 0x8 \
        "${infile}" \
        -o "${outdir}/${outfile}"
    check_exit $? "samtools"


    #  ------------------------------------
    #  Run flagstat on filtered bam outfile (optional)
    #  ------------------------------------
    if [[ $((flagstat)) -eq 1 ]]; then
        samtools flagstat \
            -@ "${threads}" \
            "${outdir}/${outfile}" \
                > "${outdir}/${outfile%.bam}.flagstat.txt" &
        check_exit $? "samtools"

        wait
    fi
}


#  ------------------------------------
#  Handle arguments
#  ------------------------------------
help="""
#  ------------------------------------
#  exclude_bam_alignments-unmapped.sh
#  ------------------------------------
Filter out unmapped alignments from a bam infile. Optionally, run samtools
flagstat on the filtered bam outfile.

Name(s) of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode  use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile     bam infile, including path <chr>
    -o  outdir     outfile directory, including path; if not found, will be
                   mkdir'd <chr>
    -f  flagstat   run samtools flagstat on bams <lgl> [default: FALSE]
    -t  threads    number of threads <int >= 1> [default: 1]
"""

while getopts "u:i:o:f:t:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage "${help}" ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${flagstat}" ]] && flagstat=FALSE
[[ -z "${threads}" ]] && threads=1


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run samtools to exclude unmapped alignments from bam infile, etc.
#  ------------------------------------
main
