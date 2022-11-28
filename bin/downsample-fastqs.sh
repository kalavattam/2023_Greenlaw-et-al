#!/bin/bash

#  downsample-fastqs.sh
#  KA

#  The package 'BBMap' needs to be in your "${PATH}"
#+ Get it here: https://sourceforge.net/projects/bbmap/

check_etc() {
    # :param 1: program to check existence of <chr> reformat.sh
    # :param 2: infile <chr> infile
    # :param 3: outdir <chr> outdir
    # :param 4: split <chr> split

    #  ------------------------------------
    #  Check and make variable assignments 
    #  ------------------------------------
    #  Check for necessary dependencies; exit if not found
    check_dependency "${1}"

    #  Evaluate "${safe_mode}"
    check_argument_safe_mode

    #  Check that "${infile}" exists
    check_exists_file "${2}"

    #  If TRUE exist, then make "${outdir}" if it does not exist; if FALSE,
    #+ then exit if "${outdir}" does not exist
    check_exists_directory TRUE "${3}"  #TODO Fix this function

    #  Check on the specified value for "${split}"
    case "$(echo "${4}" | tr '[:upper:]' '[:lower:]')" in
        sc_all | sc_no_mito | sc_vii | sc_xii | sc_vii_xii | sc_mito | \
        kl_all | virus_20s) \
            :
            ;;
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
}


main() {
    # :param 1: infile_1 <chr>
    # :param 2: infile_2 <chr>
    # :param 3: outfile_1 <chr>
    # :param 4: outfile_2 <chr>
    # :param 5: sample <chr>

    reformat.sh \
        in1="${infile_1}" \
        in2="${infile_2}" \
        out1="${outfile_1}" \
        out2="${outfile_2}" \
        samplereadstarget="${sample}"
}

#TODO  Named arguments and a parser

infile_1="${1}"
infile_2="${2}"
sample="${3}"  # e.g., "50k"
dir_out="${4}"

check_etc

outfile_1="${dir_out}/$(basename "${infile_1%.fastq.gz}.${sample}.${extension}")"
outfile_2="${dir_out}/$(basename "${infile_2%.fastq.gz}.${sample}.${extension}")"

main_etc
