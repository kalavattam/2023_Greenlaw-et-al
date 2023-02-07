#!/bin/bash

#  process_htseq-count_outfiles.sh
#  KA


check_dependency() {
    what="""
    check_dependency()
    ------------------
    Check if program is available in "\${PATH}"; exit if not
    
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
    Run script in \"safe mode\" (\`set -Eeuxo pipefail\`) if specified; assumes
    variable \"\${safe_mode}\" is defined
    
    :param \"\${safe_mode}\": value assigned to variable within script <lgl>
    :return: NA

    #TODO Check that params are not empty or inappropriate formats or strings
    """
    case "$(convert_chr_lower "${safe_mode}")" in
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
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    elif [[ ! -f "${1}" ]]; then
        printf "%s\n\n" "Exiting: File '${1}' does not exist."
        # exit 1
    else
        :
    fi
}


check_exists_directory() {  #TODO Fix this function
    what="""
    check_exists_directory()
    ------------------------
    Check that a directory exists; if it doesn't, then either make it or exit
    
    :param 1: create directory if not found: "TRUE" or "FALSE"
              <lgl; default: FALSE>
    :param 2: directory, including path <chr>
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
    :return: converted string <stdout>
    """
    if [[ -z "${1}" ]]; then
        printf "%s\n" "${what}"
    else
        string_in="${1}"
        string_out="$(printf %s "${1}" | tr '[:upper:]' '[:lower:]')"

        echo "${string_out}"
    fi
}


print_usage() {
    what="""
    print_usage()
    -------------
    Print the script's help message and exit; assumes variable \"\${help}\" is
    defined

    :param \"\${help}\": help message assigned to a variable within script
    :return: help message <stdout>

    #TODO Checks...
    #TODO Change to :param #: input
    """
    echo "${help}"
    exit 1
}


check_etc() {
    #  ------------------------------------
    #  Check and make variable assignments 
    #  ------------------------------------
    #  Check for necessary dependencies; exit if not found
    check_dependency paste
    check_dependency sed

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode

    #  Check that "${dir_q}" exists
    check_exists_directory FALSE "${dir_q}"

    #  If TRUE exist, then make "${dir_o}" if it does not exist; if FALSE,
    #+ then exit if "${dir_o}" does not exist
    check_exists_directory TRUE "${dir_o}"

    #  Check on the specified value for "${string}"
    case "$(echo "${string}" | tr '[:upper:]' '[:lower:]')" in
        antisense_transcript | cut | mrna | nuts | rrna | snorna | snrna | \
        srat | sut | trna | xut) \
            :
            ;;
        *) \
            message="""
            Exiting: -s \"\${string}\" must be one of the following:
                - antisense_transcript
                - CUT
                - mRNA
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
            exit 1
            ;;
    esac

    echo ""
}


#  ------------------------------------
#  Handle arguments, assign variables
#  ------------------------------------
help="""
#  ------------------------------------
#  process_htseq-count_outfiles.sh
#  ------------------------------------
Search user-specified directory for sample-specific htseq-count outfiles
containing strings for specific features (e.g.,the feature
'mRNA', the feature 'antisense_transcript', etc.) in their filenames; if found,
then combine all sample-specific files for the feature into a single tabular
dataframe (with features as rows, samples as columns, and counts as cells).
Order of columns (samples) is determined by an alphanumeric sort of sample-
specific file names; the script assumes that rows in sample-wise htseq-count
outfiles are ordered in the same way (i.e., it doesn't change or check for the
order of the rows).

The following feature strings are supported (uppercase, lowercase, or mixed
format is accepted):
    - antisense_transcript
    - CUT
    - mRNA
    - NUTs
    - rRNA
    - snoRNA
    - snRNA
    - SRAT
    - SUT
    - tRNA
    - XUT

Outfiles have this general format:
    \${dir_o}/htseq-count.combined.\${identifier}.\${string}.txt

Dependencies:
    - Linux paste (GNU or BSD)
    - Linux sed (GNU or BSD)

Arguments:
    -u  safe_mode   use safe mode: \"TRUE\" or \"FALSE\" <lgl> [default: FALSE]
    -d  dir_q       directory to examine (query), including path <chr>
    -o  dir_o       outfile directory, including path; if not found, program
                    will mkdir it <chr>
    -i  identifier  string to be included in the outfile name <chr>
    -s  string      string to query; options: antisense_transcript, CUT, mRNA,
                    NUTs, rRNA, snoRNA, snRNA, SRAT, SUT, tRNA, XUT <chr>
                    [default: mRNA]


#  ------------------------------------
#  Example call and results
#  ------------------------------------
❯ bash process_htseq-count_outfiles.sh \\
    -u FALSE \\
    -d \".\" \\
    -o \"./out\" \\
    -i \"timecourse\" \\
    -s \"antisense_transcript\"
#  Outfile will be \"./out/htseq-count.combined.timecourse.antisense_transcript.txt\"
"""

while getopts "u:d:o:i:s:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        d) dir_q="${OPTARG}" ;;
        o) dir_o="${OPTARG}" ;;
        i) identifier="${OPTARG}" ;;
        s) string="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${dir_q}" ]] && \
    {
        echo "Argument -d [dir_q (infile/query directory)] is empty"
        echo "Printing help message and exiting..."
        echo ""
        print_usage
    }
[[ -z "${dir_o}" ]] && \
    {
        echo "Argument -o [dir_o (outfile directory)] is empty"
        echo "Printing help message and exiting..."
        echo ""
        print_usage
    }
[[ -z "${identifier}" ]] && \
    {
        echo "Argument -i [identifier] is empty"
        echo "Printing help message and exiting..."
        echo ""
        print_usage
    }
[[ -z "${string}" ]] && \
    {
        string="mRNA"
        echo "Argument -s [string] is empty, so it is set to its default \
        value of 'mRNA'"
    }

#TEST  (2023-0207)
# safe_mode=FALSE
# dir_q="."  # cd "${dir_q}"
# dir_o="./test.KA.2023-0207"  # ., "${dir_o}"
# identifier="test.KA.2023-0207"
# string="CUT"
#
# echo "${safe_mode}"
# echo "${dir_q}"
# echo "${dir_o}"
# echo "${identifier}"
# echo "${string}"
#
# ls -lhaFG "${dir_q}"
# ls -lhaFG "${dir_o}"


#  ------------------------------------
#  Check on assignments, etc.
#  ------------------------------------
check_etc


#  ------------------------------------
#  Assign path and name for the tempfile and outfile
#  ------------------------------------
file_t="${dir_o}/htseq-count.combined.${identifier}.${string}.tmp.txt"
file_o="${file_t/.tmp.txt/.txt}"
echo "${file_t}"
echo "${file_o}"

#  ------------------------------------
#  If present, then remove the temp- and outfile
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
done < <(\
    find "${dir_q}" \
        -maxdepth 1 \
        -type f \
        -name "*${string}*" \
        -print0 \
            | sort -zV\
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
cat "${file_t}" \
    | sed 's/\t/ /g' \
    | sed 's/[ ][ ]*/ /g' \
    | sed 's/ /\t/g' \
        > "${file_o}"
# head "${file_o}"
# tail "${file_o}"
# echo "${file_o}"


#  ------------------------------------
#  If the outfile is present, then remove the tempfile
#  ------------------------------------
if [[ -f "${file_o}" ]]; then rm "${file_t}"; fi
