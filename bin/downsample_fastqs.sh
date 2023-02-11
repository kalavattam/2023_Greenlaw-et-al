#!/bin/bash

#  downsample_fastqs.sh
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


check_argument_downsample() {
    what="""
    check_argument_downsample()
    ---------------
    Check the downsampling value assigned to variable in script

    :param 1: value assigned to variable for downsampling <int >= 1>
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
    what="""
    check_etc()
    -----------
    Check depencies, and check and make variable assignments 

    #TODO Checks, etc., and a means to print the contents of variable what

    :global safe_mode:
    :global infile_1:
    :global infile_2:
    :global outdir:
    :global downsample:
    :return global stem_1:
    :return global stem_2:
    :return global extension:
    :return global outfile_1:
    :return global outfile_2:
    """
    #  Check for necessary dependencies; exit if not found
    check_dependency reformat.sh

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode "${safe_mode}"

    #  Check that "${infile_1}" and "${infile_2}" exists
    check_exists_file "${infile_1}"
    check_exists_file "${infile_2}"
    #TODO 1/2 Some kind of check that "${infile_1}" and "${infile_2}" are an
    #TODO 2/2 appropriate pair

    #  If TRUE exist, then make "${outdir}" if it does not exist; if FALSE,
    #+ then exit if "${outdir}" does not exist
    check_exists_directory TRUE "${outdir}"

    #  Check on value assigned to "${downsample}"
    check_argument_downsample "${downsample}"

    #TODO Not sure if I want these assignments in this function...
    local pen
    local ult

    ult="$(echo "${infile_1}" | awk -F "." '{ print $NF }')"
    pen="$(echo "${infile_1}" | awk -F "." '{ print $(NF - 1) }')"

    if [[ "${ult}" == "gz" ]]; then
        if [[ "${pen}" == "fq" || "${pen}" == "fastq" ]]; then
            stem_1="$(basename "${infile_1%."${pen}"."${ult}"}")"
            stem_2="$(basename "${infile_2%."${pen}"."${ult}"}")"
            extension="sample-${downsample}.${pen}.${ult}"
            outfile_1="${outdir}/${stem_1}.${extension}"
            outfile_2="${outdir}/${stem_2}.${extension}"
        else
            echo "Exiting: Penultimate extension must be \"fq\" or \"fastq\""
            # exit 1
        fi
    elif [[ "${ult}" == "fq" || "${ult}" == "fastq" ]]; then
        stem_1="$(basename "${infile_1%."${ult}"}")"
        stem_2="$(basename "${infile_2%."${ult}"}")"
        extension="sample-${downsample}.${ult}.gz"
        outfile_1="${outdir}/${stem_1}.${extension}"
        outfile_2="${outdir}/${stem_2}.${extension}"
    else
        echo "Exiting: Extension must be \"gz\", \"fq\", or \"fastq\""
        # exit 1
    fi

    echo ""
}


main() {
    what="""
    main()
    ------
    Run reformat.sh (BBMap)

    #TODO Checks, etc., and a means to print the contents of variable what
    
    :global infile_1:
    :global infile_2:
    :global outfile_1:
    :global outfile_2:
    :global downsample:
    :return: file \"\${outfile_1}\"
    :return: file \"\${outfile_2}\"
    """
    reformat.sh \
        in1="${infile_1}" \
        in2="${infile_2}" \
        out1="${outfile_1}" \
        out2="${outfile_2}" \
        samplereadstarget="${downsample}"    
}


#  ------------------------------------
#  Handle arguments
#  ------------------------------------
help="""
#  ------------------------------------
#  downsample_fastqs.sh
#  ------------------------------------
Randomly extract a subset of read pairs from paired-end fastq files. Number of
read pairs to be extracted is specified by the user. Script does not allow for
upsampling. Name(s) of outfile(s) will be derived from the infile. Outfiles
will gzip'd.

Dependencies:
    - reformat.sh (part of BBMap) >= version #TBD

Arguments:
    -u  safe_mode   use safe mode: TRUE or FALSE <lgl> [default: FALSE]
    -1  infile_1    \"first\" fastq infile, including path <chr>
    -2  infile_2    \"second\" fastq infile, including path <chr>
    -o  outdir      outfile directory, including path; if not found, will be
                    mkdir'd <chr>
    -d  downsample  number of read pairs to sample <int >= 0>
"""

while getopts "u:1:2:o:d:" opt; do
    case "${opt}" in
        u) safe_mode="${OPTARG}" ;;
        1) infile_1="${OPTARG}" ;;
        2) infile_2="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        d) downsample="${OPTARG}" ;;
        *) print_usage "${help}" ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile_1}" ]] && print_usage "${help}"
[[ -z "${infile_2}" ]] && print_usage "${help}"
[[ -z "${outdir}" ]] && print_usage "${help}"
[[ -z "${downsample}" ]] && print_usage "${help}"

#TEST (2023-0209)
# safe_mode=FALSE
# infile_1="./results/2023-0115/fastqs_UMI-dedup/rcorrector/5781_G1_IN_S5_R1.UMI.atria.cor.fq.gz"
# infile_2="./results/2023-0115/fastqs_UMI-dedup/rcorrector/5781_G1_IN_S5_R3.UMI.atria.cor.fq.gz"
# outdir="."
# downsample=50000


#  ------------------------------------
#  Check dependencies, and check and make variable assignments 
#  ------------------------------------
check_etc


#  ------------------------------------
#  Run reformat.sh (BBMap)
#  ------------------------------------
main
