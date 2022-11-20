#!/bin/bash

#  align_process_fastqs.sh
#  CC, AG?
#  Adapted by KA, 2022-1027-1028


#  Source functions -----------------------------------------------------------
check_dependency() {
    # Check if program is available in "${PATH}"; exit if not
    # 
    # :param 1: program/package <chr>
    command -v "${1}" &>/dev/null ||
        {
            echo "Exiting: ${1} not found. Install ${1}."
            # exit 1
        }
}


check_exit() {
    # Check the exit code of a child process
    # 
    # :param 1: exit code <int >= 0>
    # :param 2: program/package <chr>
    if [[ "${1}" == "0" ]]; then
        echo "${2} completed: $(date)"
    else
        err "#ERROR: ${2} returned exit code ${1}"
    fi
}


err() {
    # Print an error meassage, then exit with code 1
    # 
    # :param 1: program/package <chr>
    echo "${1} exited unexpectedly"
    # exit 1
}


print_usage() {
    # Print the help message and exit
    echo "${help}"
    # exit 1
}


#  Handle arguments, assign variables -----------------------------------------
help="""
${0}
Align a pair of .fastq files from paired-end sequencing, then sort and compress
the alignments. Then, ...

Dependencies:
  - bowtie2 >= 2.3.4.2
  - samtools >= 1.9

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  directory containing infiles, including path <chr>
  -p  prefix for paired-end fastq infiles used with Linux find <chr>
  -b  directory containing Bowtie 2 indices, including path <chr>
  -r  prefix for Bowtie 2 indices <chr>
  -s  path to 'split_bam_paired_end.sh', including name <chr; default: bin/>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -t  number of threads; options: 1, 2, 4, 8, or 16 <int; default: 16>
"""

while getopts "h:u:i:p:b:r:s:o:t" opt; do
    case "${opt}" in
        h) echo "${help}" && exit ;;
        u) safe_mode="${OPTARG}" ;;
        i) dir_infiles="${OPTARG}" ;;
        p) prefix_infiles="${OPTARG}" ;;
        b) dir_indices="${OPTARG}" ;;
        r) prefix_indices="${OPTARG}" ;;
        s) script="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${dir_infiles}" ]] && print_usage
[[ -z "${prefix_infiles}" ]] && print_usage
[[ -z "${dir_indices}" ]] && print_usage
[[ -z "${prefix_indices}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${script}" ]] && script="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/bin/split_bam_paired_end.sh"  #TODO Address this
[[ -z "${threads}" ]] && threads=16

#  Assignments for tests (to be commented out)
safe_mode=FALSE
dir_infiles="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1025/fastq"
prefix_infiles="5781_G1_IN_merged"
dir_indices="${HOME}/genomes/combined_SC_KL_20S/Bowtie2"
prefix_indices="combined_SC_KL_20S"
script="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/bin/split_bam_fwd_rev.sh"
outdir="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1025/align_process_fastqs"
threads=1

echo "${safe_mode}"
echo "${dir_infiles}"
echo "${prefix_infiles}"
echo "${dir_indices}"
echo "${prefix_indices}"
echo "${script}"
echo "${outdir}"
echo "${threads}"


#  Check variable and array assignments, and dependencies too -----------------
echo ""
echo "Running ${0}... "

#  Evaluate "${safe_mode}"  #TODO Test if/how this works
case "$(echo "${safe_mode}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-u: \"Safe mode\" is TRUE.\n" && set -Eeuxo pipefail ;;
    false | f) \
        echo -e "-u: \"Safe mode\" is FALSE.\n" ;;
    *) \
        echo -e "Exiting: -u \"safe mode\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

#  Check that "${dir_infiles}" exists
[[ -d "${dir_infiles}" ]] ||
    {
        echo -e "Exiting: -i ${dir_infiles} does not exist.\n"
        # exit 1
    }

#  Grab the infiles in the above directory, then check that exactly two files
#+ corresponding to "${dir_infiles}/${prefix_infiles}" are found; throw an
#+ error and exit if not
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    # shellcheck disable=SC2061
    find "${dir_infiles}" \
        -maxdepth 1 \
        -type f \
        -name "${prefix_infiles}"* \
        -print0 \
            | sort -z \
)

#  Only two fastq infiles should be found (read 1 and read 2); if less than or
#+ more than two are found, then exit with a warning message; at that point,
#+ the user will need to troubleshoot their dir_infiles and/or prefix_infiles
#+ assignments
if [[ "${#infiles[@]}" -eq 0 ]]; then
    echo -e "Exiting: -i and/or -p: zero fastq files were found.\n"
    # exit 1
elif [[ "${#infiles[@]}" -lt 2 ]]; then
    echo -e "Exiting: -i and/or -p: only one fastq file was found.\n"
    # exit 1
elif [[ "${#infiles[@]}" -gt 2 ]]; then
    echo -e "Exiting: -i and/or -p: more than two fastq files were found.\n"
    # exit 1
elif [[ "${#infiles[@]}" -eq 2 ]]; then
    :  # Do nothing and continue on in the script
fi

#  Report on what the two fastq files are
echo "The fastq infiles are..."
for i in "${infiles[@]}"; do printf %s"\n" "  - ${i}"; done
echo ""

#  Check that "${dir_indices}" exists
[[ -d "${dir_indices}" ]] ||
    {
        echo -e "Exiting: -i ${dir_indices} does not exist.\n"
        # exit 1
    }

#  Check that index files with "${prefix_indices}" exist
unset indices
typeset -a indices
while IFS=" " read -r -d $'\0'; do
    indices+=( "${REPLY}" )
done < <(\
    # shellcheck disable=SC2061
    find "${dir_indices}" \
        -maxdepth 1 \
        -type f \
        -name "${prefix_indices}"* \
        -print0 \
            | sort -z \
)

#  Six Bowtie 2 index files should be found; if less than or more than six are
#+ found, then exit with a warning message; at that point, the user will need
#+ to troubleshoot their dir_indices and/or prefix_indices assignments
if [[ "${#indices[@]}" -eq 0 ]]; then
    echo -e "Exiting: -b and/or -r: zero Bowtie 2 index files were found.\n"
    # exit 1
elif [[ "${#indices[@]}" -lt 6 ]]; then
    echo -e "Exiting: -b and/or -r: less than six Bowtie 2 index files were found.\n"
    # exit 1
elif [[ "${#indices[@]}" -gt 6 ]]; then
    echo -e "Exiting: -b and/or -r: more than six Bowtie 2 index files were found.\n"
    # exit 1
elif [[ "${#indices[@]}" -eq 6 ]]; then
    :  # Do nothing and continue on in the script
fi

#  Report on what the index files are
echo "The Bowtie 2 index infiles are..."
for i in "${indices[@]}"; do printf %s"\n" "  - ${i}"; done
echo ""

#  Assign variable for use when calling Bowtie 2
bowtie2_indices="${dir_indices}/${prefix_indices}"
# echo "${bowtie2_indices}"

#  Make "${outdir}" if it doesn't exist
[[ -d "${outdir}" ]] ||
    {
        echo -e "-o: Directory ${outdir} does not exist; making the directory.\n"
        mkdir -p "${outdir}"
    }

[[ -d "${outdir}/bam" ]] ||
    {
        echo -e "-o: Directory ${outdir}/bam does not exist; making the directory.\n"
        mkdir -p "${outdir}/bam"
    }

[[ -d "${outdir}/bw" ]] ||
    {
        echo -e "-o: Directory ${outdir}/bw does not exist; making the directory.\n"
        mkdir -p "${outdir}/bw"
    }

#  Check on the specified (or default) number of threads
case "${threads}" in
    1 | 2 | 4 | 8 | 16) : ;;  # Do nothing and move on
    *) \
        echo -e "Exiting: -p ${threads} must be either 1, 2, 4, 8, or 16.\n"
        # exit 1
        ;;
esac

#  Apportion threads for Bowtie 2 and samtools based on the value assigned to
#+ "${threads}"
if [[ "${threads}" -eq 1 ]]; then
    threads_bowtie2=1
    threads_sort=1
elif [[ "${threads}" -eq 2 ]]; then
    threads_bowtie2=2
    threads_sort=1
elif [[ "${threads}" -eq 4 ]]; then
    threads_bowtie2=3
    threads_sort=1
elif [[ "${threads}" -eq 8 ]]; then
    threads_bowtie2=7
    threads_sort=1
elif [[ "${threads}" -eq 16 ]]; then
    threads_bowtie2=14
    threads_sort=2
fi

echo ""

#  Load and then check for necessary dependencies; exit if not found
modules=(
    "Bowtie2/2.4.4-GCC-11.2.0"
    "SAMtools/1.16.1-GCC-11.2.0"
    "deepTools/3.5.1-foss-2021b"
    "BamTools/2.5.2-GCC-11.2.0"
)
for i in "${modules[@]}"; do ml "${i}"; done
check_dependency bowtie2
check_dependency samtools
check_dependency deeptools
check_dependency bamtools


#  Run Bowtie 2 and samtools --------------------------------------------------
bowtie2 \
    -p "${threads_bowtie2}" \
    -x "${bowtie2_indices}" \
    -1 "${infiles[0]}" \
    -2 "${infiles[1]}" \
    --trim5 1 \
    --local \
    --very-sensitive-local \
    --no-unal \
    --no-mixed \
    --no-discordant \
    --phred33 \
    -I 10 \
    -X 700 \
    --no-overlap \
    --no-dovetail \
        | samtools sort \
            -@ "${threads_sort}" \
            -l 0 \
            -O "bam" \
        | samtools view \
            -@ "${threads}" \
            -O "bam" \
            -o "${outdir}/bam/$(basename "${infiles[0]%_R1*fastq}.bam")"

samtools index \
    -@ "${threads}" \
    "${outdir}/bam/$(basename "${infiles[0]%_R1*fastq}.bam")"


#  Run ... #TBC
#  Run split_bam_paired_end.sh ------------------------------------------------
bash "${script}" -u FALSE -i -o  #TBC




#  Copy results to output before cleanup
for expected_result in ${expected_results}; do
    ${wrap} cp ${expected_result} ${output_directory}/
done

logNoExec "   /\ /\\"
logNoExec "  (=' '=)"
cd "${rundir}"
# done

cd $output_directory
mkdir strand_specific_bams
for expected_result in *.bam; do
    ${wrap} "${script}" ${expected_result} ${output_directory}
    ${wrap}  mv *_rev*.bam strand_specific_bams
    ${wrap}  mv *_fwd*.bam strand_specific_bams
done

cd strand_specific_bams
mkdir BigWigs

#  Generate outputs: bigwig file containing all fragment sizes and a plot of
#+ the fragment size distribution up to 1000 bp
${wrap} bamCoverage -b ${sample_name}*_rev*.bam -o ${sample_name}_cov_rev.bw
${wrap} bamCoverage -b ${sample_name}*_fwd*.bam -o ${sample_name}_cov_fwd.bw
${wrap} bamCoverage --normalizeUsing RPKM --minMappingQuality 3 -b ${sample_name}*_rev*.bam -o ${sample_name}_cov_rev_rpkmnorm.bw
${wrap} bamCoverage --normalizeUsing RPKM --minMappingQuality 3 -b ${sample_name}*_fwd*.bam -o ${sample_name}_cov_fwd_rpkmnorm.bw
# ${wrap} bamPEFragmentSize -hist ${sample_name}_fragmentSize.png --maxFragmentLength 1000 -b ${sample_name}_sorted.bam

    for expected_result_2 in ${expected_results_2}; do
        ${wrap} cp ${expected_result_2} ${output_directory_bw}/
    done

    logNoExec "   /\ /\\"
    logNoExec "  (=' '=)"
done
