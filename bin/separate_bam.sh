#!/bin/bash

#  separate_split_bam.sh
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

    #TODO Check that param is not empty or inappropriate format/string

    :param 1: run script in safe mode: TRUE or FALSE <lgl> [default: FALSE]
    :return: NA    
    """
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            printf "%s\n" "-u: \"Safe mode\" is TRUE."
            set -Eeuxo pipefail
            ;;
        false | f | 0) \
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
        true | t | 1) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "${2} doesn't exist; mkdir'ing it."
                    mkdir -p "${2}"
                }
            ;;
        false | f | 0) \
            [[ -d "${2}" ]] ||
                {
                    printf "%s\n" "Exiting: ${2} does not exist."
                    exit 1
                }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not TRUE or FALSE."
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


check_argument_unmapped() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            unmapped=1
            printf "%s\n" "\"Target 'unmapped' reads\" is TRUE."
            ;;
        false | f | 0) \
            unmapped=0
            printf "%s\n" "\"Target 'unmapped' reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"unmapped\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_secondary() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            secondary=1
            printf "%s\n" "\"Target 'secondary' alignments\" is TRUE."
            ;;
        false | f | 0) \
            secondary=0
            printf "%s\n" "\"Target 'secondary' alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"secondary\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_mode() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        1) \
            mode=1
            printf "%s\n" "\"Run in '{in,ex}clusion' mode\" is set to '1'."
            ;;
        2) \
            mode=2
            printf "%s\n" "\"Run in '{in,ex}clusion' mode\" is set to '2'."
            ;;
        3) \
            mode=3
            printf "%s\n" "\"Run in '{in,ex}clusion' mode\" is set to '3'."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"{in,ex}clusion mode\" argument must be 1, 2, or 3.\n"
            # exit 1
            ;;
    esac
}


check_argument_flagstat() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            flagstat=1
            printf "%s\n" "\"Run samtools flagstat\" is TRUE."
            ;;
        false | f | 0) \
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
        true | t | 1) \
            list_etc=1
            printf "%s\n" "\"Run list_tally_flags()\" is TRUE."
            ;;
        false | f | 0) \
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
    Check dependencies, and check and make variable assignments 

    #TODO Checks, etc., and a means to print the contents of variable what

    :global safe_mode:
    :global infile:
    :global outdir:
    :global threads:
    :global flagstat:
    :return global base:
    :return global outfile:
    """
    #  Check for necessary dependencies; exit if not found
    check_dependency samtools

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode "${safe_mode}"

    #  Check that "${infile}" exists
    check_exists_file "${infile}"

    #  If TRUE, then make "${outdir}" if it does not exist; if FALSE (i.e.,
    #+ "${outdir}" does not exist), then exit
    check_exists_directory TRUE "${outdir}"

    #TODO
    check_argument_unmapped "${unmapped}"
    
    #TODO
    check_argument_secondary "${secondary}"
    
    #TODO
    check_argument_mode "${mode}"
    
    #  Check on value assigned to "${flagstat}"
    check_argument_flagstat "${flagstat}"

    #TODO
    check_argument_list_etc "${list_etc}"
    
    #  Check on value assigned to "${threads}"
    check_argument_threads "${threads}"

    #TODO Not sure if I want these assignments in this function...
    #  Make additional variable assignments from the arguments
    base="$(basename "${infile}")"
    outfile="${base%.bam}.exclude-unmapped.bam"

    echo ""
}


main() {
    what="""
    main()
    ------
    Run samtools view to exclude unmapped reads from bam infile; optionally,
    run samtools flagstat on primary alignment-filtered bam outfile

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
    echo "Filtering out unmapped reads..."

    if [[ "${mode}" -eq 1 ]]; then
        #  Inclusion ---------------------------
        #  Including only (--rf/-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0004 \
                --rf 0x0008 \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.in-u.bam" \
                "${infile}"
        fi

        #  Including only (--rf/-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s.bam" \
                "${infile}"
        fi

        #  Inclusion (--rf) of 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                --rf 0x0004 \
                --rf 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s-u.bam" \
                "${infile}"
        fi

        #  Exclusion ---------------------------
        #  Excluding (-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-u.bam" \
                "${infile}"
        fi

        #  Excluding (-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.ex-s.bam" \
                "${infile}"
        fi

        #  Excluding (-F) 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-s-u.bam" \
                "${infile}"
        fi

    elif [[ "${mode}" -eq 2 ]]; then
        #  Inclusion ---------------------------
        #  Including only (--rf/-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0004 \
                --rf 0x0008 \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.in-u.bam" \
                "${infile}"
        fi

        #  Including only (--rf/-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s.bam" \
                "${infile}"
        fi

        #  Including only (--rf/-F) 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                --rf 0x0100 \
                --rf 0x0004 \
                --rf 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.in-s-u.bam" \
                "${infile}"
        fi

    elif [[ "${mode}" -eq 3 ]]; then
        #  Exclusion ---------------------------
        #  Excluding (-F) unmapped reads (0x0004, 0x0008)
        if [[ "${unmapped}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-u.bam" \
                "${infile}"
        fi

        #  Excluding (-F) secondary alignments (0x0100)
        if [[ "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -b -o "${outdir}/${outfile%.bam}.ex-s.bam" \
                "${infile}"
        fi

        #  Excluding (-F) 0x0100, 0x0004, and 0x0008
        if [[ "${unmapped}" -eq 1 && "${secondary}" -eq 1 ]]; then
            samtools view \
                -@ "${threads}" \
                -F 0x0100 \
                -F 0x0004 \
                -F 0x0008 \
                -b -o "${outdir}/${outfile%.bam}.ex-s-u.bam" \
                "${infile}"
        fi
    fi

    if [[ $((flagstat)) -eq 1 ]]; then
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            samtools flagstat \
                -@ "${threads}" \
                "${i}" \
                    > "${i%.bam}.flagstat.txt"
        done
    fi

    if [[ $((list_etc)) -eq 1 ]]; then
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            list_tally_flags \
                "${i}" \
                "${i%.bam}.list-tally-flags.txt"
        done
    fi
}


#  ------------------------------------
#  Handle arguments
#  ------------------------------------
help="""
#  ------------------------------------
#  separate_split_bams.sh
#  ------------------------------------
Filter out unmapped reads from a bam infile. Optionally, run samtools flagstat
on the filtered bam outfile.

Name(s) of outfile(s) will be derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode  use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile     bam infile, including path <chr>
    -o  outdir     outfile directory, including path; if not found, will be
                   mkdir'd <chr>
    -v  unmapped   target 'unmapped' reads <lgl> [default: TRUE]
    -s  secondary  target 'secondary' alignments <lgl> [default: TRUE]
    -m  mode       run in '{in,ex}clusion' mode 1, 2, or 3 <int = 1, 2, or 3>
                   [default: 1]

                       mode 1: bam outfiles *including* and *excluding* the
                               'unmapped' reads and/or 'secondary' alignments
                               are produced
                       mode 2: only bam outfiles *including* the 'unmapped'
                               reads and/or 'secondary' alignments are produced
                               produced
                       mode 3: only bam outfiles *excluding* the 'unmapped'
                               reads and/or 'secondary' alignments are produced
                               produced

    -f  flagstat   run samtools flagstat on bam outfiles <lgl> [default: TRUE]
    -l  list_etc   run list_tally_flags() on bam outfiles <lgl> [default: TRUE]
    -t  threads    number of threads <int >= 1> [default: 1]
"""

while getopts "u:i:o:v:s:m:f:l:t:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        v) unmapped="${OPTARG}" ;;
        s) secondary="${OPTARG}" ;;
        m) mode="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        l) list_etc="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${unmapped}" ]] && unmapped=TRUE
[[ -z "${secondary}" ]] && secondary=TRUE
[[ -z "${mode}" ]] && mode=1
[[ -z "${flagstat}" ]] && flagstat=TRUE
[[ -z "${list_etc}" ]] && list_etc=TRUE
[[ -z "${threads}" ]] && threads=1


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run samtools to...
#  ------------------------------------
main
