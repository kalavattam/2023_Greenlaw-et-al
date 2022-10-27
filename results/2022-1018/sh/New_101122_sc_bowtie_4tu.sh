#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

############################################################
################# CONFIGURATION VARIABLES ##################
#this is for bam files for deeptools, and bamresort

# Please review the variables below and update if needed.
THREADS=16
# LOAD_MODULES: python modules to load before processing samples. List separated by spaces in order of load sequence.
#LOAD_MODULE_CMD="/app/Lmod/lmod/6.4.5/libexec/lmod load"
LOAD_MODULE_CMD="module load"
LOAD_MODULES="Bowtie2/2.3.4.2-foss-2018b SAMtools/0.1.20-foss-2018b deepTools/3.3.1-foss-2018b-Python-3.6.6"
REFERENCE_GENOME="~/saccer3/sacCer3 "
SPLIT_READS="~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/scripts"


#SAMPLE_PREFIX and SAMPLE_SUFFIX are used to automatically identify sample subdirectory names if none are provided.
SAMPLE_PREFIX=""
SAMPLE_INFIX="_R"
SAMPLE_SUFFIX="001.fastq"

# EXPECTED_RESULT: Filenames used to identify whether samples have already been processed, and to copy to the combined output directory.
EXPECTED_RESULTS="*sorted.bam *sorted.bam.bai"
EXPECTED_RESULTS_2=".bw"
#EXPECTED_RESULTS2="*.bw"

# OUTPUT_DIRECTORY identifies where the EXPECTED_RESULTS will be copied to.
OUTPUT_DIRECTORY="${RUNDIR}/S_cerevisiae_BamFiles"
OUTPUT_DIRECTORY_2="${RUNDIR}/BigWigs"
#OUTPUT_DIRECTORY2="${RUNDIR}/BigWigs"

# Directory to copy scripts and other resources from.
SCRIPTS_DIRECTORY="~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/scripts" #this is an old functionality and needs to be changed moving forward - 25/07/2020

# Remove CLEANUP_FILES from the sample directory after finished processing and after running CLEANUP_COMMAND.
CLEANUP_FILES=""

# Run the CLEANUP_COMMAND in the sample directory after finished processing.
CLEANUP_COMMAND="echo Cleaning up files matching ${CLEANUP_FILES}" # or ex, "gzip --fast .fastq" to save space by recompressing files

# REPROCESS: determines whether to reprocess a sample if its EXPECTED_RESULT already exists. If "MANUAL", will reprocess only if the user specified the sample name on the command line. If "ALWAYS", will always reprocess. If "NEVER", will not reprocess even if manually listed. TODO check OUTPUT_DIRECTORY for result. Compare MD5
REPROCESS=manual

###########################################################
#################### IDENTIFY SAMPLES #####################

SAMPLES=""
PARAMS="$@"


###########################################################
#################### PROCESS SAMPLES ######################

WRAP="log eval "
log() { echo "\$ ${@/eval/}" 2>&1 | tee -a ${SAMPLE_LOG}; "$@" 2>&1 | tee -a ${SAMPLE_LOG}; }
logcd() { echo "\$ cd ${@/eval/}" 2>&1 | tee -a ${SAMPLE_LOG}; cd "$@" 2>&1 | tee -a ${SAMPLE_LOG}; }
logNoExec() { echo "\$ ${@/eval/}" 2>&1 | tee -a ${SAMPLE_LOG}; }
logNoEcho() { "$@" 2>&1 | tee -a ${SAMPLE_LOG}; }

echo "Preparing environment to process samples: "
echo ${SAMPLES}
# TODO prompt to continue
#echo "Continue?"

# Load required python modules.
for pymodule in $LOAD_MODULES; do
  echo "Loading module ${pymodule}..."
  ${LOAD_MODULE_CMD} ${pymodule}
  echo "...done."
done;

# Create the output directory and any needed parent directories.
mkdir -p ${OUTPUT_DIRECTORY}
## mkdir -p ${OUTPUT_DIRECTORY2}

SAMPLES=""
PARAMS="$@"
if [[ -z "${PARAMS// }" ]];
  then
    # Find all files matching _R1_ sample pattern
    for i in `ls ${SAMPLE_PREFIX}*${SAMPLE_INFIX}*${SAMPLE_SUFFIX}`; do
        echo File ${i} matches sample pattern.
        # Discard anything matching SAMPLE_PREFIX
        SAMPLE=${i#$SAMPLE_PREFIX};
        # Discard SAMPLE_INFIX (ex "_R1"), SAMPLE_SUFFIX (ex ".fastq") and anything potentially in between (ex "_001")
        SAMPLE=${SAMPLE%$SAMPLE_INFIX*$SAMPLE_SUFFIX};
        echo Sample name defined: $SAMPLE

        # Extract "trailer" from sample name after SAMPLE_INFIX (ex _R1 INFIX
        TRAILER=${i#*$SAMPLE_INFIX}
        TRAILER=${i%$SAMPLE_SUFFIX}

        # TODO Check for existence of corresponding _R2 file complain if not found or trailer mismatch
        # TODO Check and warn if processed sample results already exists (REPROCESS check/functionality)

        # Add sample name to samples list
        SAMPLES="$SAMPLES ${SAMPLE}"
    done;
  else
    echo Parameter list of samples not supported, please ensure filenames match *FIX variable definitions instead.
    # TODO add back in ability to specify a list of sample names and find/check filenames based on that
fi;

for SAMPLE_NAME in ${SAMPLES}; do
  SAMPLE_LOG="${SAMPLE_NAME}.log"

	logNoExec "==========================="
  logNoEcho date
  logNoExec "Processing ${SAMPLE_NAME}"
# 	# set up fifos to avoid creating additional unnecessary unzipped and merged copied of fastq data
# 	# $WRAP mkfifo merged_R1.fastq
# 	# $WRAP mkfifo merged_R2.fastq
# 	# $WRAP zcat -f *_R1*.fastq* > merged_R1.fastq &
#   # $WRAP zcat -f *_R2*.fastq* > merged_R2.fastq &
   $WRAP gunzip *fastq.gz
   #$WRAP "cat *_R1_*.fastq > ${SAMPLE_NAME}_merged_R1.fastq"
  # $WRAP "cat *_R2_*.fastq > ${SAMPLE_NAME}_merged_R2.fastq"
   # $WRAP "cat \*_R1_\*.fastq > \$\{SAMPLE_NAME\}_merged_R1.fastq"
#   # $WRAP "cat \*_R2_\*.fastq > \$\{SAMPLE_NAME\}_merged_R2.fastq"
#
# 	# run bowtie2
 	$WRAP bowtie2 -p ${THREADS} -x ${REFERENCE_GENOME}  -1 ${SAMPLE_NAME}*_R1_001.fastq -2 ${SAMPLE_NAME}*_R3_001.fastq --trim5 1 --local --very-sensitive-local --no-unal --no-mixed --no-discordant --phred33 -I 10 -X 700 --no-overlap --no-dovetail -S ${SAMPLE_NAME}_mapped.sam
#
# 	# run samtools
 	logNoExec '~ beginning samtools sort...'
   $WRAP samtools view -@ ${THREADS} -bS -o ${SAMPLE_NAME}_mapped.bam ${SAMPLE_NAME}_mapped.sam
   $WRAP samtools sort -@ ${THREADS} ${SAMPLE_NAME}_mapped.bam ${SAMPLE_NAME}_sorted #adding the .bam in the script makes the file be .bam.bam
   $WRAP samtools index ${SAMPLE_NAME}_sorted.bam # the -b does not need to be there - causes it to not work bc it thinks that the -b is part of the file name
#
#   # Copy results to output before cleanup
   for EXPECTED_RESULT in ${EXPECTED_RESULTS}; do
     $WRAP cp ${EXPECTED_RESULT} ${OUTPUT_DIRECTORY}/
   done;
#
   logNoExec "   /\ /\\"
   logNoExec "  (=' '=)"
   cd ${RUNDIR}
 done;

cd $OUTPUT_DIRECTORY
mkdir STRAND_SPECIFIC_BAMS
for EXPECTED_RESULT in *.bam; do
  $WRAP $SPLIT_READS $EXPECTED_RESULT $OUTPUT_DIRECTORY
$WRAP  mv *_rev*.bam STRAND_SPECIFIC_BAMS
$WRAP  mv *_fwd*.bam STRAND_SPECIFIC_BAMS
done;
#
cd STRAND_SPECIFIC_BAMS
mkdir BigWigs
#
# generate outputs - bigwig file containing all fragment sizes and a plot of the fragment size distribution up to 1000bp
$WRAP bamCoverage -b ${SAMPLE_NAME}*_rev*.bam -o ${SAMPLE_NAME}_cov_rev.bw
$WRAP bamCoverage -b ${SAMPLE_NAME}*_fwd*.bam -o ${SAMPLE_NAME}_cov_fwd.bw
$WRAP bamCoverage --normalizeUsing RPKM --minMappingQuality 3 -b ${SAMPLE_NAME}*_rev*.bam -o ${SAMPLE_NAME}_cov_rev_rpkmnorm.bw
$WRAP bamCoverage --normalizeUsing RPKM --minMappingQuality 3 -b ${SAMPLE_NAME}*_fwd*.bam -o ${SAMPLE_NAME}_cov_fwd_rpkmnorm.bw

#$WRAP bamPEFragmentSize -hist ${SAMPLE_NAME}_fragmentSize.png --maxFragmentLength 1000 -b ${SAMPLE_NAME}_sorted.bam

  for EXPECTED_RESULT_2 in ${EXPECTED_RESULTS_2}; do
    $WRAP cp ${EXPECTED_RESULT_2} ${OUTPUT_DIRECTORY_2}/
  done;

  logNoExec "   /\ /\\"
  logNoExec "  (=' '=)"
done;
