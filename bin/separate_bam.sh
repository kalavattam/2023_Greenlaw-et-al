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


check_argument_primary() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            primary=1
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments\" is TRUE."
            ;;
        false | f | 0) \
            primary=0
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"primary\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_secondary() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            secondary=1
            printf "%s\n" "\"Output bam composed of 'proper' secondary primary alignments\" is TRUE."
            ;;
        false | f | 0) \
            secondary=0
            printf "%s\n" "\"Output bam composed of 'proper' secondary primary alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"secondary\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_prim_sec() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            prim_sec=1
            printf "%s\n" "\"Output bam composed of 'proper' primary and secondary alignments\" is TRUE."
            ;;
        false | f | 0) \
            prim_sec=0
            printf "%s\n" "\"Output bam composed of 'proper' primary and secondary alignments\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"prim_sec\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_unmapped() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            unmapped=1
            printf "%s\n" "\"Output bam composed of 'proper' unmapped reads\" is TRUE."
            ;;
        false | f | 0) \
            unmapped=0
            printf "%s\n" "\"Output bam composed of 'proper' unmapped reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"unmapped\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_proper_etc() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            proper_etc=1
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads\" is TRUE."
            ;;
        false | f | 0) \
            proper_etc=0
            printf "%s\n" "\"Output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"proper_etc\" argument must be TRUE or FALSE.\n"
            # exit 1
            ;;
    esac
}


check_argument_improp_etc() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            improp_etc=1
            printf "%s\n" "\"Output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads\" is TRUE."
            ;;
        false | f | 0) \
            improp_etc=0
            printf "%s\n" "\"Output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"improp_etc\" argument must be TRUE or FALSE.\n"
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


check_argument_list_tally() {
    #TODO Description (what), checks, etc.
    case "$(convert_chr_lower "${1}")" in
        true | t | 1) \
            list_tally=1
            printf "%s\n" "\"Run list_tally_flags()\" is TRUE."
            ;;
        false | f | 0) \
            list_tally=0
            printf "%s\n" "\"Run list_tally_flags()\" is FALSE."
            ;;
        *) \
            printf "%s\n\n" "Exiting: \"list_tally\" argument must be TRUE or FALSE.\n"
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
    :global primary:
    :global secondary:
    :global prim_sec:
    :global unmapped:
    :global proper_etc:
    :global improp_etc:
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

    check_argument_primary "${primary}"

    check_argument_secondary "${secondary}"

    check_argument_prim_sec "${prim_sec}"

    check_argument_unmapped "${unmapped}"

    check_argument_proper_etc "${proper_etc}"

    check_argument_improp_etc "${improp_etc}"
    
    #  Check on value assigned to "${flagstat}"
    check_argument_flagstat "${flagstat}"

    #TODO
    check_argument_list_tally "${list_tally}"
    
    #  Check on value assigned to "${threads}"
    check_argument_threads "${threads}"

    #TODO Not sure if I want these assignments in this function...
    #  Make additional variable assignments from the arguments
    outfile="$(basename "${infile}")"

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
    :global outfile: bam outfile <chr>
    :global primary: output bam composed of 'proper' primary alignments <lgl>
    :global secondary: output bam composed of 'proper' secondary alignments <lgl>
    :global prim_sec: output bam composed of 'proper' primary and secondary alignments <lgl>
    :global unmapped: output bam composed of 'proper' unmapped reads <lgl>
    :global proper_etc: output bam composed of 'proper' primary alignments and singletons, and 'proper' unmapped reads <lgl>
    :global improp_etc: output bam composed of 'proper' and 'improper' primary and secondary alignments, and unmapped reads <lgl>
    :global flagstat: run samtools flagstat on bams <0 or 1>
    :global list_tally: run samtools flagstat on bams <0 or 1>
    :return: file(s) outdir/outfile (samtools view)
    :return: file(s) outdir/outfile (samtools flagstat)
    :return: file(s) outdir/outfile (list_tally_flags)
    """
    echo ""
    echo "Running ${0}... "
    echo "Filtering out unmapped reads..."

    #  Bam composed of "proper" primary alignments
    if [[ "${primary}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            -F 0x0100 \
            -F 0x0004 \
            -F 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.primary.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" secondary alignments
    if [[ "${secondary}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            --rf 0x0100 \
            -F 0x0004 \
            -F 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.secondary.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" primary and secondary alignments
    if [[ "${prim_sec}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            -F 0x0004 \
            -F 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.primary-secondary.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" unmapped reads
    if [[ "${unmapped}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            --rf 0x0004 \
            --rf 0x0008 \
            -F 0x0100 \
            -b -o "${outdir}/${outfile%.bam}.unmapped.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" primary alignments and singletons, and "proper"
    #+ unmapped reads
    if [[ "${proper_etc}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            -F 0x0100 \
            -b -o "${outdir}/${outfile%.bam}.proper-etc.bam" \
            "${infile}"
    fi

    #  Bam composed of "proper" and "improper" primary and secondary
    #+ alignments, and unmapped reads
    if [[ "${improp_etc}" -eq 1 ]]; then
        samtools view \
            -@ "${threads}" \
            --rf 0x0100 \
            --rf 0x0004 \
            --rf 0x0008 \
            -b -o "${outdir}/${outfile%.bam}.proper-improper-etc.bam" \
            "${infile}"
    fi

    if [[ $((flagstat)) -eq 1 ]]; then
        for i in "${outdir}/${outfile%.bam}."*".bam"; do
            samtools flagstat \
                -@ "${threads}" \
                "${i}" \
                    > "${i%.bam}.flagstat.txt"
        done
    fi

    if [[ $((list_tally)) -eq 1 ]]; then
        #TODO Switch to GNU parallel here
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
#  separate_bams.sh
#  ------------------------------------
Filter out unmapped reads from a bam infile. Optionally, run samtools flagstat
on the filtered bam outfile. Name(s) of outfile(s) are derived from the infile.

Dependencies:
    - samtools >= version #TBD

Arguments:
    -u  safe_mode   use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -i  infile      bam infile, including path <chr>
    -o  outdir      outfile directory, including path; if not found, will be
                    mkdir'd <chr>
    -1  primary     output bam composed of 'proper' primary alignments <lgl>
                    [default: TRUE]
    -2  secondary   output bam composed of 'proper' secondary alignments <lgl>
                    [default: TRUE]
    -3  prim_sec    output bam composed of 'proper' primary and secondary
                    alignments <lgl> [default: TRUE]
    -4  unmapped    output bam composed of 'proper' unmapped reads <lgl>
                    [default: TRUE]
    -5  proper_etc  output bam composed of 'proper' primary alignments and
                    singletons, and 'proper' unmapped reads <lgl>
                    [default: FALSE]
    -6  improp_etc  output bam composed of 'proper' and 'improper' primary
                    and secondary alignments, and unmapped reads <lgl>
                    [default: FALSE]
    -f  flagstat    run samtools flagstat on bam outfiles <lgl> [default: TRUE]
    -l  list_tally  run list and tally flags in bam outfiles <lgl>
                    [default: TRUE]
    -t  threads     number of threads <int >= 1> [default: 1]
"""

while getopts "u:i:o:1:2:3:4:5:6:f:l:t:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        1) primary="${OPTARG}" ;;
        2) secondary="${OPTARG}" ;;
        3) prim_sec="${OPTARG}" ;;
        4) unmapped="${OPTARG}" ;;
        5) proper_etc="${OPTARG}" ;;
        6) improp_etc="${OPTARG}" ;;
        f) flagstat="${OPTARG}" ;;
        l) list_tally="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${primary}" ]] && primary=TRUE
[[ -z "${secondary}" ]] && secondary=TRUE
[[ -z "${prim_sec}" ]] && prim_sec=TRUE
[[ -z "${unmapped}" ]] && unmapped=TRUE
[[ -z "${proper_etc}" ]] && proper_etc=FALSE
[[ -z "${improp_etc}" ]] && improp_etc=FALSE
[[ -z "${flagstat}" ]] && flagstat=TRUE
[[ -z "${list_tally}" ]] && list_tally=TRUE
[[ -z "${threads}" ]] && threads=1


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run samtools to...
#  ------------------------------------
main
