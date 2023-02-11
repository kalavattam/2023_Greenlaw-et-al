#!/bin/bash

#  exclude_bam_alignments-non-primary.sh
#  KA


check_exit() {
    what="""
    check_exit()
    ------------
    Check the exit code of a child process
    
    #TODO Check that params are not empty or inappropriate formats or strings

    :param 1: exit code <int >= 0>
    :param 2: program/package <chr>
    :return: message <chr>
    """
    if [[ "${1}" == "0" ]]; then
        echo "${2} completed: $(date)"
    else
        err "Error: ${2} returned exit code ${1}"
    fi
}


err() {
    what="""
    err()
    -----
    Print an error meassage, then exit with code 1
    
    #TODO Check that param is not empty or inappropriate format or string
    
    :param 1: program/package <chr>
    :return: error message (stdout) <chr>
    """
    echo "${1} exited unexpectedly"
    # exit 1
}


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
    
    #TODO Check that param is not an inappropriate format/string

    :param 1: file, including path <chr>
    :return: NA
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

    #TODO Check that params are not empty or inappropriate formats/strings

    :param 1: create directory if not found: TRUE or FALSE <lgl>
    :param 2: directory, including path <chr>
    :return: NA    
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


check_argument_flagstat() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
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


calculate_run_time() {
    what="""
    calculate_run_time()
    --------------------
    Calculate run time for chunk of code
    
    #TODO Check that params are not empty or inappropriate formats or strings

    :param 1: start time in \$(date +%s) format
    :param 2: end time in \$(date +%s) format
    :param 3: message to be displayed when printing the run time <chr>
    :return: message <chr>
    """
    local run_time
    
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
        $(( run_time/3600 )) \
        $(( run_time%3600/60 )) \
        $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    what="""
    display_spinning_icon()
    -----------------------
    Display \"spinning icon\" while a background process runs
    
    #TODO Checks...
    
    :param 1: PID of the last program the shell ran in the background <int>
    :param 2: message to be displayed next to the spinning icon <chr>
    :return: spinning icon <chr>
    """
    local spin
    local i
    
    spin="/|\\–"
    i=0
    
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    what="""
    list_tally_flags()
    ------------------
    List and tally flags in a bam infile; function acts on a bam infile to
    perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    list and tally flags; function writes the results to a txt outfile, the
    name of which is derived from the txt infile

    #TODO Checks...

    :param 1: name of bam infile, including path <chr>
    :param 2: name of txt outfile, including path <chr>
    :return: file \"\${2}\"
    """
    local start
    local end

    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
            > "${2}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


check_argument_list_etc() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t) \
            list_etc=1
            printf "%s\n" "\"Run list_tally_flags()\" is TRUE."
            ;;
        false | f) \
            list_etc=0
            printf "%s\n" "\"Run list_tally_flags()\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"list_etc\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
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

    #TODO Checks...

    :param 1: help message assigned to a variable within script <chr>
    :return: help message (stdout) <chr>
    """
    echo "${1}"
    exit 1
}


check_etc() {
    what="""
    check_etc()
    -----------
    Check depencies, and check and make variable assignments 

    #TODO Checks, etc., and a means to print the contents of variable what

    :global safe_mode:
    :global infile:
    :global outdir:
    :global threads:
    :global flagstat:
    :return: :global base:
    :return: :global outfile:
    """
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
    check_argument_flagstat "${flagstat}"

    #  Check on value assigned to "${threads}"
    check_argument_threads "${threads}"

    #TODO Not sure if I want these assignments in this function...
    #  Make additional variable assignments from the arguments
    base="$(basename "${infile}")"
    outfile="${base%.bam}.exclude-non-primary.bam"

    echo ""
}


main() {
    what="""
    main()
    ------
    Run samtools view to exclude non-primary alignments from bam infile;
    optionally, run samtools flagstat on primary alignment-filtered bam outfile

    #TODO Checks, etc., and a means to print the contents of variable what

    :global threads: number of threads <int >= 1>
    :global infile: bam infile, including path <chr>
    :global outdir: outfile directory, including path <chr>
    :global outfile: bam outfile, including path <chr>
    :global flagstat: run samtools flagstat on bams <0 or 1>
    :global list_etc: run samtools flagstat on bams <0 or 1>
    :return: file outdir/outfile (samtools view)
    :return: file outdir/outfile (samtools flagstat)
    :return: file outdir/outfile (list_tally_flags)
    """
    echo ""
    echo "Running ${0}... "
    echo "Filtering out non-primary alignments..."

    samtools view \
        -@ "${threads}" \
        -b -F 0x0100 \
        "${infile}" \
        -o "${outdir}/${outfile}"
    check_exit $? "samtools"

    if [[ $((flagstat)) -eq 1 ]]; then
        samtools flagstat \
            -@ "${threads}" \
            "${outdir}/${outfile}" \
                > "${outdir}/${outfile%.bam}.flagstat.txt" &
        check_exit $? "samtools"

        wait
    fi

    if [[ $((list_etc)) -eq 1 ]]; then
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
#  separate_bam_alignments-non-primary.sh
#  ------------------------------------
Exclude non-primary alignments from bam infile. Optionally, run samtools
flagstat on the filtered bam outfile.


Name of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= #TBD

Arguments:
    -u  safe_mode  use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile     bam infile, including path <chr>
    -o  outdir     outfile directory, including path; if not found, will be
                   mkdir'd <chr>
    -f  flagstat   run samtools flagstat on bams <lgl> [default: TRUE]
    -l  list_etc   run list_tally_flags() on bams <lgl> [default: TRUE]
    -t  threads    number of threads <int >= 1> [default: 1]
"""

while getopts "u:i:o:f:l:t:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        l) list_etc="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${flagstat}" ]] && flagstat=TRUE
[[ -z "${list_etc}" ]] && list_etc=TRUE
[[ -z "${threads}" ]] && threads=1


#  ------------------------------------
#  Check depencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run samtools to exclude unmapped alignments from bam infile, etc.
#  ------------------------------------
main
