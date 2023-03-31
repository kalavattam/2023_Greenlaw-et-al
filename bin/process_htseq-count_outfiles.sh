#!/bin/bash

#  process_htseq-count_outfiles.sh
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
                    # exit 1
                }
            ;;
        *) \
            printf "%s\n" "Exiting: param 1 is not \"TRUE\" or \"FALSE\"."
            printf "%s\n" "${what}"
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

    :param 1: help message assigned to a variable within script <chr>
    :return: help message (stdout) <chr>

    #TODO Checks...
    """
    echo "${1}"
    # exit 1
}


check_etc() {
    #  ------------------------------------
    #  Check and make variable assignments 
    #  ------------------------------------
    #  Check for necessary dependencies; exit if not found
    check_dependency paste
    check_dependency sed

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode "${safe_mode}"

    #  Check that "${querydir}" exists
    check_exists_directory FALSE "${querydir}"

    #  If TRUE, then make "$(dirname ${outpath})" if it does not exist; if
    #+ FALSE (i.e., "$(dirname ${outpath})" does not exist), then exit
    check_exists_directory FALSE "$(dirname ${outpath})"

    #  Check on the specified value for "${string}"
    case "$(convert_chr_lower "${string}")" in
        antisense_transcript | cut | cut_2016 | cut_4x | hc-strd-eq | \
        hc-strd-op | mrna | ncrna | nuts | rrna | snorna | snrna | srat | \
        sut | trna | xut) \
            :
            ;;
        *) \
            message="""
            Exiting: -s \"\${string}\" must be one of the following:
                - antisense_transcript
                - CUT
                - CUT_2016
                - CUT_4X
                - hc-strd-eq
                - hc-strd-op
                - mRNA
                - ncRNA
                - NUTs
                - rRNA
                - snoRNA
                - snRNA
                - SRAT
                - SUT
                - tRNA
                - XUT
            """
            printf "%s\n\n" "${message}"
            # exit 1
            ;;
    esac

    #  ------------------------------------
    #  Assign path and name for the tempfile and outfile
    #  ------------------------------------
    file_t="$(dirname "${outpath}")/tmp.$(basename "${outpath}")"
    file_o="${outpath}"
    # echo "${file_t}"
    # echo "${file_o}"

    echo ""
}


main() {
    #  ------------------------------------
    #  If already present, then remove the temp- and outfile
    #  ------------------------------------
    if [[ -f "${file_t}" ]]; then rm "${file_t}"; fi
    if [[ -f "${file_o}" ]]; then rm "${file_o}"; fi


    #  ------------------------------------
    #  Collect all files (with paths) containing the selected string into an array
    #  ------------------------------------
    unset files
    typeset -a files
    while IFS=" " read -r -d $'\0'; do
        files+=( "${REPLY}" )
    done < <(
        find "${querydir}" \
            -maxdepth 1 \
            -type f \
            -name "*${string}*" \
            -print0 \
                | sort -zV
    )
    # echo_test "${files[@]}"
    # echo "${#files[@]}"


    #  ------------------------------------
    #  Collect even indices into a comma-separated string; assign the string to
    #+ variable 'joined'
    #  ------------------------------------
    unset evens
    typeset -a evens
    for (( i = 1; i <= $(( ${#files[@]} * 2 )); i++ )); do
       if [[ $(( i % 2 )) -eq 0 ]]; then
            evens+=( "${i}" )
       fi
    done
    # echo_test "${evens[@]}"

    printf -v joined '%s,' "${evens[@]}"
    # echo "${joined%,}"


    #  ------------------------------------
    #  Concatenate pertinent columns for individual htseq-count outfiles
    #  ------------------------------------
    paste ${files[*]} | cut -f "1,${joined%,}" > "${file_t}"
    # head "${file_t}"
    # tail "${file_t}"


    #  ------------------------------------
    #  Strip paths from individual files, then save the filenames into a new array,
    #+ col_names, which will be used to name the columns in the outfile
    #  ------------------------------------
    unset col_names
    typeset -a col_names
    col_names+=( "features" )
    for i in "${files[@]}"; do
        col_names+=( "$(basename "${i}")" )
    done
    # echo_test "${col_names[@]}"


    #  ------------------------------------
    #  To the tempfile, add the filenames/col_names as column names
    #  ------------------------------------
    sed -i "1i\
    $(echo ${col_names[*]})
    " "${file_t}"
    # head "${file_t}"


    #  ------------------------------------
    #  Currently, the tempfile is a mix of both single and multiple whitespaces,
    #+ and tabs; replace all whitespaces and tabs with a single tab; save the
    #+ results to the outfile
    #  ------------------------------------
    cat "${file_t}" | sed 's/\t/ /g; s/[ ][ ]*/ /g; s/ /\t/g' \
        > "${file_o}"
    # head "${file_o}"
    # tail "${file_o}"
    # echo "${file_o}"


    #  ------------------------------------
    #  If the outfile is present, then remove the tempfile
    #  ------------------------------------
    if [[ -f "${file_o}" ]]; then rm "${file_t}"; fi
}


#  ------------------------------------
#  Handle arguments, assign variables
#  ------------------------------------
help="""
#  ------------------------------------
#  process_htseq-count_outfiles.sh
#  ------------------------------------
Search user-specified directory for sample-specific htseq-count outfiles
containing strings for specific features in their filenames (e.g.,the feature
'mRNA', the feature 'antisense_transcript', etc.). If found, then combine all
sample-specific files for the feature into a single tabular dataframe (with
features as rows, samples as columns, and counts as cells). Order of columns
(samples) is determined by an alphanumeric sort of filenames; the script
assumes that rows in feature-specific htseq-count outfiles are ordered in the
same way (i.e., it neither checks nor changes the order of the rows).

The following strings for features are supported:
    - antisense_transcript
    - CUT
    - CUT_2016
    - CUT_4X
    - hc-strd-eq
    - hc-strd-op
    - mRNA
    - ncRNA
    - NUTs
    - rRNA
    - snoRNA
    - snRNA
    - SRAT
    - SUT
    - tRNA
    - XUT

(Uppercase, lowercase, or mixed case is accepted.)

Outfiles have the format specified with argument \${outpath}.

Dependencies:
    - Linux paste (GNU or BSD) >= version #TBD
    - Linux sed (GNU or BSD) >= version #TBD

Arguments:
    -u  safe_mode   use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -q  querydir    directory to examine (query), including path <chr>
    -o  outpath     outpath/directory and file; if path/directory is not
                    found, will exit <chr>
    -s  string      string to query; options: antisense_transcript, CUT,
                    CUT_2016, CUT_4X, hc-strd-eq, hc-strd-op, mRNA, ncRNA,
                    NUTs, rRNA, snoRNA, snRNA, SRAT, SUT, tRNA, XUT <chr>
                    [default: mRNA]


#  ------------------------------------
#  Example call and results
#  ------------------------------------
❯ bash process_htseq-count_outfiles.sh \\
    -u FALSE \\
    -q \".\" \\
    -o \"./out/htseq-count.combined.timecourse.antisense_transcript.txt\" \\
    -s \"antisense_transcript\"
#  Outfile will be \"./out/htseq-count.combined.timecourse.antisense_transcript.txt\"
"""

while getopts "u:q:o:s:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        q) querydir="${OPTARG}" ;;
        o) outpath="${OPTARG}" ;;
        s) string="${OPTARG}" ;;
        *) print_usage "${help}" ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${querydir}" ]] && \
    {
        echo "Argument -q [querydir (infile/query directory)] is empty"
        echo "Printing help message and exiting..."
        echo ""
        print_usage "${help}"
    }
[[ -z "${outpath}" ]] && \
    {
        echo "Argument -o [outpath (outpath/directory and file)] is empty"
        echo "Printing help message and exiting..."
        echo ""
        print_usage "${help}"
    }
[[ -z "${string}" ]] && \
    {
        string="mRNA"
        echo "Argument -s [string] is empty, so it is set to its default \
        value of 'mRNA'"
    }

# #TEST (2023-0331)
# safe_mode=FALSE
# querydir="."  # cd "${querydir}"
# outpath="./test.KA.2023-0331"  # ., "${outdir}"
# string="hc-strd-eq"
#
# echo "${safe_mode}"
# echo "${querydir}"
# echo "${outpath}"
# echo "${string}"
#
# ls -lhaFG "${querydir}"
# ls -lhaFG "$(dirname "${outpath}")"


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Combine feature-specific htseq-count files into tabular dataframe
#  ------------------------------------
main
