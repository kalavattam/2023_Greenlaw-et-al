#!/bin/bash

wrap=""
rundir="$(pwd)"


############################################################
################# CONFIGURATION VARIABLES ##################
#  This is for bam files for deeptools, and bamresort...

#  Please review the variables below and update if needed.
threads="${1:-"16"}"

#  'load_modules': Python modules to load before processing samples; list
#+ separated by spaces in order of load sequence
load_module_cmd="module load"
load_modules="Bowtie2/2.4.4-GCC-11.2.0 SAMtools/1.16.1-GCC-11.2.0 deepTools/3.5.1-foss-2021b"
reference_genome="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"
split_reads="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/bin/split_bam_paired_end.sh"


#  'sample_prefix' and 'sample_suffix' are used to automatically identify
#+ sample subdirectory names if none are provided
sample_directory="${2:-"~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN"}"
sample_root="${3:-"5781_G1_IN_merged"}"
# sample_prefix=""
# sample_infix="_R"
# sample_suffix="001.fastq"

#  'expected_result': Filenames used to identify whether samples have already
#+ been processed and to copy to the combined output directory
expected_results="*sorted.bam *sorted.bam.bai"
expected_results_2=".bw"

#  'output_directory' identifies where the 'expected_results' will be copied to
output_directory="${rundir}/bam"
output_directory_2="${rundir}/bw"

#  Remove 'cleanup_files' from the sample directory after finished processing
#+ and after running 'cleanup_command'
cleanup_files=""

#  Run the 'cleanup_command' in the sample directory after finished processing
cleanup_command="echo Cleaning up files matching ${cleanup_files}"  # Or, e.g., "gzip --fast .fastq" to save space by recompressing files
#NOTE #KA Above two variables are not used (2022-1027)

#  'reprocess': Determines whether to reprocess a sample if its
#+ 'expected_result' already exists. If "manual", will reprocess only if the
#+ user specified the sample name on the command line. If "always", will always
#+ reprocess. If "never", will not reprocess even if manually listed.
reprocess="manual"  #TODO Check 'output_directory' for result; compare MD5
#NOTE #KA Above variable, 'reprocess', is not used (2022-1027)


###########################################################
#################### IDENTIFY SAMPLES #####################
samples=""
params="$@"


###########################################################
#################### PROCESS SAMPLES ######################
wrap="log eval "
log() { echo "\$ ${@/eval/}" 2>&1 | tee -a ${sample_log}; "$@" 2>&1 | tee -a ${sample_log}; }
logcd() { echo "\$ cd ${@/eval/}" 2>&1 | tee -a ${sample_log}; cd "$@" 2>&1 | tee -a ${sample_log}; }  #NOTE #KA Function does not appear to be used (2022-1027)
logNoExec() { echo "\$ ${@/eval/}" 2>&1 | tee -a ${sample_log}; }
logNoEcho() { "$@" 2>&1 | tee -a ${sample_log}; }

echo "Preparing environment to process samples: "
echo ${samples}
#TODO prompt to continue
#echo "Continue?"

# Load required python modules.
for pymodule in ${load_modules}; do
    echo "Loading module ${pymodule}..."
    ${load_module_cmd} ${pymodule}
    echo "...done."
done
echo ""

#  Create the output directory and any needed parent directories.
mkdir -p "${output_directory}"

#  Locate the infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "${sample_directory}" \
        -maxdepth 1 \
        -type f \
        -name "${sample_root}"* \
        -print0 \
            | sort -z \
)
# for i in "${infiles[@]}"; do echo "${i}"; done

#  Only two fastq files should be found; if less or more, then exit with a
#+ warning message
if [[ "${#infiles[@]}" -eq 0 ]]; then
    echo "Exiting: Zero fastq files were found..." && exit 1
elif [[ "${#infiles[@]}" -lt 2 ]]; then
    echo "Exiting: Only one fastq file was found..." && exit 1
elif [[ "${#infiles[@]}" -gt 2 ]]; then
    echo "Exiting: More than two fastq files were found..." && exit 1
elif [[ "${#infiles[@]}" -eq 2 ]]; then
    :
fi

# samples=""
# params="$@"
# if [[ -z "${params// }" ]];
#     then
#         # Find all files matching "_R1_" sample pattern
#         for i in $(ls ${sample_prefix}*${sample_infix}*${sample_suffix}); do
#             echo "File ${i} matches sample pattern."
#             #  Discard anything matching 'sample_prefix'
#             sample=${i#$sample_prefix};
#            
#             #  Discard 'sample_infix' (ex "_R1"), 'sample_suffix' (ex ".fastq") and anything potentially in between (ex "_001")
#             sample=${sample%$sample_infix*$sample_suffix};
#             echo "Sample name defined: ${sample}"
#
#             # Extract "trailer" from sample name after 'sample_infix' (ex "_R1" INFIX
#             trailer=${i#*$sample_infix}
#             trailer=${i%$sample_suffix}
#             #NOTE #KA Unused variable... (2022-1027)
#
#             #TODO Check for existence of corresponding "_R2" file; complain if not found or trailer mismatch
#             #TODO Check and warn if processed sample results already exists ('reprocess' check/functionality)
#
#             # Add sample name to samples list
#             samples="${samples} ${sample}"
#         done
#     else
#         echo "Parameter list of samples not supported; please ensure filenames match '*fix' variable definitions instead."
#         #TODO Add back in ability to specify a list of sample names and find/check filenames based on that
# fi



# for sample_name in ${samples}; do
#     sample_log="${sample_name}.log"
#
logNoExec "==========================="
logNoEcho date
logNoExec "Processing ${sample_name}"
#  Set up FIFOs to avoid creating additional unnecessary unzipped and
#+ merged copied of fastq data
# ${wrap} mkfifo merged_R1.fastq
# ${wrap} mkfifo merged_R2.fastq
# ${wrap} zcat -f *_R1*.fastq* > merged_R1.fastq &
# ${wrap} zcat -f *_R2*.fastq* > merged_R2.fastq &
# ${wrap} gunzip *fastq.gz
# ${wrap} "cat *_R1_*.fastq > ${sample_name}_merged_R1.fastq"
# ${wrap} "cat *_R2_*.fastq > ${sample_name}_merged_R2.fastq"
# ${wrap} "cat \*_R1_\*.fastq > \$\{sample_name\}_merged_R1.fastq"
# ${wrap} "cat \*_R2_\*.fastq > \$\{sample_name\}_merged_R2.fastq"

mkdir -p "${rundir}/bam"

#  Run Bowtie2
${wrap} bowtie2 \
    -p "${threads}" \
    -x "${reference_genome}" \
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
    -S "${rundir}/bam/$(basename "${infiles[0]%_R1*fastq}").sam"

    | samtools view -@ "${threads}" -h - \
    | samtools sort -@ "${threads}" - \
    > "test.bam"

#  Run samtools
logNoExec '~ beginning samtools sort...'
${wrap} samtools view \
    -@ ${threads} \
    -bS \
    -o ${sample_name}_mapped.bam \
    ${sample_name}_mapped.sam

${wrap} samtools sort \
    -@ ${threads} \
    ${sample_name}_mapped.bam \
    ${sample_name}_sorted  # Adding the .bam in the script makes the file be .bam

${wrap} samtools index \
    ${sample_name}_sorted.bam

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
    ${wrap} "${split_reads}" ${expected_result} ${output_directory}
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
        ${wrap} cp ${expected_result_2} ${output_directory_2}/
    done

    logNoExec "   /\ /\\"
    logNoExec "  (=' '=)"
done
