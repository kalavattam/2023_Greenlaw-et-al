
# 2022-1101
## Implementing the proper calculation of TPM
- The following steps were put together after having read, in particular, [the reponse from `slowkow` to this post](https://www.biostars.org/p/171766/); another post is also quite useful, [particularly the comment from Heng Li](https://www.biostars.org/p/216616/#216678)
- Adapt [this script](https://gist.github.com/slowkow/8101509) to calculate the number of coding bases per gene
- Parse information collected by [`picardmetrics`](https://github.com/slowkow/picardmetrics) to get the mean fragment length for each library
    - `.gtf` file for genome of interest, e.g., `~/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf`
    	- The `.gtf` file is used to generate, in turn, a `.refFlat` file, the file type actually needed by `picardmetrics`
		- The `.gtf` file is also used to generate a `.rRNA.list` file, a file that provides "location\[s\] of rRNA sequences in genome, in interval_list format" per [here](https://broadinstitute.github.io/picard/command-line-overview.html#CollectRnaSeqMetrics)
		- `picardmetrics` has a subcommand to generate these files
			- `.refFlat` files: `picardmetrics refFlat "${gtf}"`
			- `.rRNA.list` files: `picardmetrics rRNA "${gtf}"`
    - `.fasta` file for genome of interest, e.g., `~/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta`
- Adapt [this script](https://www.biostars.org/p/216616/#216678) to convert raw counts (from `subread featureCounts`, I think `#TODO Check on this`) to TPM

### Build out the script for calling `picardmetrics`
...a necessary *(?)* step prior to calculating TPM
- Calling `picardmetrics` is necessary for getting the mean fragment length per library
- It has the added benefit of providing many other quality-control metrics for the RNA-seq libraries, which will likely benefit me and Alison as we move forward with this work
- `#DONE` Before setting up the script, install `picardmetrics` on the FHCC cluster
    + See [notes on the installation (which was somewhat tricky) here](https://gist.github.com/kalavattam/74394ed83c542862e087658accbdbc38))
```bash
#DONTRUN

grabnode  # 1 core, default memory, 1 day, default GPU
#  Run through each line or chunk below...


#  name-of-script  #TODO
#  KA


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


print_usage() {
    # Print the help message and exit
    echo "${help}"
    # exit 1
}


#  Handle arguments, assign variables -----------------------------------------
help="""
Run picardmetrics on .bam files to check the quality of sequencing data. Among
other things, running picardmetrics provide information on library mean
fragment length, which is necessary for the calculation of TPM.

Dependencies:
  - picardmetrics == 0.2.4 (2016-07-06)
  - #TBD

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <lgl; default: FALSE>
  -i  directory containing infiles, including path <chr>
  -g  gtf, including path <chr>
  -f  fasta for reference genome, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -t  number of threads; options: 1, 2, 4, or 8 <int; default: 2>
  -r  bam(s) from RNA-seq exp.: \"TRUE\" or \"FALSE\" <lgl; default: TRUE>

Notes:
  - \"safe mode\" is untested
"""

# while getopts "h:u:i:g:f:o:t:r:" opt; do
#     case "${opt}" in
#         h) echo "${help}" && exit ;;
#         u) safe_mode="${OPTARG}" ;;
#         i) dir_infiles="${OPTARG}" ;;
#         g) gtf="${OPTARG}" ;;
#         f) fasta="${OPTARG}" ;;
#         o) outdir="${OPTARG}" ;;
#         t) threads="${OPTARG}" ;;
#         r) RNAseq="${OPTARG}" ;;
#         *) print_usage ;;
#     esac
# done
#
# [[ -z "${safe_mode}" ]] && safe_mode=FALSE
# [[ -z "${dir_infiles}" ]] && print_usage
# [[ -z "${gtf}" ]] && print_usage
# [[ -z "${fasta}" ]] && print_usage
# [[ -z "${outdir}" ]] && print_usage
# [[ -z "${threads}" ]] && threads=2
# [[ -z "${RNAseq}" ]] && RNAseq=TRUE

#  Assignments for tests (to be commented out)
safe_mode=FALSE
dir_infiles="${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq"
gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"  #UPDATED
fasta="${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.plus-chr-rename.fasta"  #UPDATED
outdir="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"
threads=1
RNAseq=TRUE

echo "${safe_mode}"
echo "${dir_infiles}"
echo "${gtf}"
echo "${fasta}"
echo "${outdir}"
echo "${threads}"
echo "${RNAseq}"


#  Check variable and array assignments, and dependencies too -----------------
echo ""
echo "Running ${0}... "

# -------------------------------------
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

# -------------------------------------
#  Check that "${dir_infiles}" exists; exit if it doesn't
[[ -d "${dir_infiles}" ]] ||
    {
        echo -e "Exiting: -i ${dir_infiles} does not exist.\n"
        # exit 1
    }

# -------------------------------------
#  Grab the bam infiles in the above directory; throw an error and exit if none
#+ are found
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    # shellcheck disable=SC2061
    find "${dir_infiles}" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
# for i in "${infiles[@]}"; do echo "${i}"; done

#  If no files are found, then exit with a warning message
if [[ "${#infiles[@]}" -eq 0 ]]; then
    echo -e "Exiting: -i: zero bam files were found.\n"
    # exit 1
elif [[ "${#infiles[@]}" -gt 0 ]]; then
    :  # Do nothing and continue on in the script
fi

#  Report on what the bam files are
echo "The bam infiles are..."
for i in "${infiles[@]}"; do printf %s"\n" "  - ${i}"; done
echo ""

# -------------------------------------
#  Check that "${gtf}" exists; exit if it doesn't
[[ -f "${gtf}" ]] ||
    {
        echo -e "Exiting: -g ${gtf} does not exist.\n"
        # exit 1
    }

# -------------------------------------
#  Based on "${gtf}", derive names of rRNA.list and refFlat files, and then
#+ check if they exist or not; if not, set flags to signify that they need to
#+ be generated (done by picardmetrics)
dir_gtf="$(dirname "${gtf}")"
dir_up="${dir_gtf%/*}"

[[ -d ${dir_up} ]] ||
	{
		echo -e "Exiting: -g ${dir_up} (upstream directory for gtf file) does not seem to exist?\n"
        # exit 1
	}

file_rRNA="$(basename "${gtf%.gtf}.rRNA.list")"
file_refFlat="$(basename "${gtf%.gtf}.refFlat")"

rRNA="${dir_up}/rRNA/${file_rRNA}"
refFlat="${dir_up}/refFlat/${file_refFlat}"

flag_rRNA=0
[[ -f "${rRNA}" ]] ||
    {
        [[ -d "$(dirname ${rRNA})" ]] ||
        	{
        		mkdir -p "$(dirname ${rRNA})"
        	}
        flag_rRNA=1
    }

flag_refFlat=0
[[ -f "${refFlat}" ]] ||
    {
        [[ -d "$(dirname ${refFlat})" ]] ||
        	{
        		mkdir -p "$(dirname ${refFlat})"
        	}
        flag_refFlat=1
    }

# -------------------------------------
#  Check that "${fasta}" exists; exit if it doesn't
[[ -f "${fasta}" ]] ||
    {
        echo -e "Exiting: -f ${fasta} does not exist.\n"
        # exit 1
    }

# -------------------------------------
#  Check that "${outdir}" exists; if not, create "${outdir}"
[[ -d "${outdir}" ]] ||
    {
        echo -e "-o: Directory ${outdir} does not exist; making the directory.\n"
        mkdir -p "${outdir}"
    }

# -------------------------------------
#  Check on the specified (or default) number of threads; exit if not specific
case "${threads}" in
    1 | 2 | 4 | 8) : ;;  # Do nothing and move on
    *) \
        echo -e "Exiting: -p ${threads} must be either 1, 2, 4, or 8.\n"
        # exit 1
        ;;
esac

#  Set flag_threads=1 if "${threads}" > 1
flag_threads=0
if (( "${threads}" > 1 )); then flag_threads=1; fi

# -------------------------------------
#  Evaluate "${RNAseq}"
case "$(echo "${RNAseq}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-r: \"RNA-seq\" is TRUE.\n" && \
        flag_RNAseq=1
        ;;
    false | f) \
        echo -e "-r: \"RNA-seq\" is FALSE.\n" && \
        flag_RNAseq=0
        ;;
    *) \
        echo -e "Exiting: -r \"RNA-seq\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

# -------------------------------------
#  Load and then check for necessary dependencies; exit if not found
modules=(
	#  Need to load java?
	"Java/1.8.0_181"
	"parallel/20210322-GCCcore-10.2.0"
	"R/4.2.0-foss-2021b"
)
for i in "${modules[@]}"; do ml "${i}"; done
check_dependency java
check_dependency parallel  #TODO Need to check on version too (>20200101)
check_dependency picardmetrics
check_dependency R
check_dependency Rscript


#  Check on and/or prepare rRNA and refFlat files needed by picardmetrics -----
if [[ "${flag_rRNA}" == 1 ]]; then
    echo "Generating a list of genomic intervals for rRNA genes: $(basename ${rRNA})"
    echo ""

    picardmetrics rRNA "${gtf}"
    
    mv "$(dirname "${gtf}")/$(basename "${rRNA}")" "$(dirname ${rRNA})"

    cd -
fi

if [[ "${flag_refFlat}" == 1 ]]; then
    echo "Generating a refFlat file: $(basename ${refFlat})"
    echo ""        
    
    picardmetrics refFlat "${gtf}"

    mv "$(dirname "${gtf}")/$(basename ${refFlat})" "$(dirname ${refFlat})"

    cd -
fi


#  If present, then remove and regenerate "${outdir}/picardmetrics.conf" ----------------
#  Otherwise, generate picardmetrics.conf
if [[ -f "${outdir}/picardmetrics.conf" ]]; then
	rm -- "${outdir}/picardmetrics.conf"
fi

cat << configuration > "${outdir}/picardmetrics.conf"
# ~/picardmetrics.conf
# Change the values of these variables to match your system configuration.

# Write temporary files here.
TEMP_DIR="\${TMPDIR}"

# Run all jobs with niceness to avoid interrupting interactive sessions.
NICENESS=20

# Picard Tools jar file.
PICARD_JAR="\${HOME}/src/picard-tools-1.126/picard.jar"

# Java invocation of Picard Tools.
PICARD="java -Xms5g -Xmx5g -jar \${PICARD_JAR}"

# Reference genome sequence.
REFERENCE_SEQUENCE="${fasta}"

# Only for RNA-seq: annotations for all gene features.
REF_FLAT="${refFlat}"

# Only for RNA-seq: all genomic intervals for ribosomal RNA genes.
RIBOSOMAL_INTERVALS="${rRNA}"
configuration

if [[ -f "${outdir}/picardmetrics.conf" ]]; then
	:
else
	echo "Exiting: picardmetrics.conf not found in ${outdir}; check on this."
	# exit 1
fi


#  Run picardmetrics; use GNU parallel if flag_threads=1 ----------------------
if [[ "${flag_RNAseq}" -eq 1 ]]; then
	if [[ "${flag_threads}" -eq 0 ]]; then
		echo "Running picardmetrics in serial"
		echo ""

		for i in "${infiles[@]}"; do
		    echo "Working with ${i}..."
		    picardmetrics run \
		    -f "${outdir}/picardmetrics.conf" \
		    -o "${outdir}" \
		    -r \
		    -k \
		    "${i}"

		    echo ""
		done
	elif [[ "${flag_threads}" -eq 1 ]]; then
		echo "Running picardmetrics in parallel with ${threads} threads"
		echo ""

		parallel --header : --colsep " " -k -j "${threads}" \
		"picardmetrics run \
		-f {configuration} \
		-o {outdir} \
		-r \
		-k \
		{infiles}" \
		::: configuration "${outdir}/picardmetrics.conf" \
		::: outdir "${outdir}" \
		::: infiles "${infiles[@]}"
	fi
elif [[ "${flag_RNAseq}" -eq 0 ]]; then
	if [[ "${flag_threads}" -eq 0 ]]; then
		echo "Running picardmetrics in serial"
		echo ""

		for i in "${infiles[@]}"; do
		    echo "Working with ${i}..."
		    picardmetrics run \
		    -f "${outdir}/picardmetrics.conf" \
		    -o "${outdir}" \
		    -k \
		    "${i}"

		    echo ""
		done
	elif [[ "${flag_threads}" -eq 1 ]]; then
		echo "Running picardmetrics in parallel with ${threads} threads"
		echo ""

		parallel --header : --colsep " " -k -j "${threads}" \
		"picardmetrics run \
		-f {configuration} \
		-o {outdir} \
		-k \
		{infiles}" \
		::: configuration "${outdir}/picardmetrics.conf" \
		::: outdir "${outdir}" \
		::: infiles "${infiles[@]}"
	fi
fi
```

After setting up and stepping through things, getting this chromosome name-related error:
```txt
Running picardmetrics in serial

Working with /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.bam...
picardmetrics version 0.2.4 2016-07-06
2022-11-01 13:55:12	picardmetrics config: '/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/picardmetrics.conf'
2022-11-01 13:55:12	START	/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.bam
2022-11-01 13:55:12	CreateSequenceDictionary
2022-11-01 13:55:13	ReorderSam
ERROR: ReorderSam failed. See: /home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/5781_G1_IN_sorted.ReorderSam.log
[Tue Nov 01 13:55:13 PDT 2022] picard.sam.ReorderSam INPUT=/loc/scratch/3151686/picardmetrics_kalavatt_18572/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.bam OUTPUT=/loc/scratch/3151686/picardmetrics_kalavatt_18572/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.ReorderSam.bam REFERENCE=/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta TMP_DIR=[/loc/scratch/3151686/picardmetrics_kalavatt_18572/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq] VALIDATION_STRINGENCY=LENIENT    ALLOW_INCOMPLETE_DICT_CONCORDANCE=false ALLOW_CONTIG_LENGTH_DISCORDANCE=false VERBOSITY=INFO QUIET=false COMPRESSION_LEVEL=5 MAX_RECORDS_IN_RAM=500000 CREATE_INDEX=false CREATE_MD5_FILE=false
[Tue Nov 01 13:55:13 PDT 2022] Executing as kalavatt@gizmoj37 on Linux 4.15.0-192-generic amd64; Java HotSpot(TM) 64-Bit Server VM 1.8.0_181-b13; Picard version: 1.126(4691ee611ac205d4afe2a1b7a2ea975a6f997426_1417447214) IntelDeflater
INFO	2022-11-01 13:55:13	ReorderSam	SAM/BAM file
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrI230218
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrII813184
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrIII316620
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrIV1531933
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrIX439888
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrM85779
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrV576874
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrVI270161
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrVII1090940
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrVIII562643
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrX745751
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrXI666816
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrXII1078177
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrXIII924431
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrXIV784333
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrXV1091291
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nchrXVI948066
INFO	2022-11-01 13:55:13	ReorderSam	Reference
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nI230218
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nII813184
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nIII316620
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nIV1531933
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nV576874
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nVI270161
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nVII1090940
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nVIII562643
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nIX439888
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nX745751
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nXI666816
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nXII1078177
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nXIII924431
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nXIV784333
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nXV1091291
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nXVI948066
INFO	2022-11-01 13:55:13	ReorderSam	  SN=%s LN=%d%nMito85779
INFO	2022-11-01 13:55:13	ReorderSam	Reordering SAM/BAM file:
[Tue Nov 01 13:55:14 PDT 2022] picard.sam.ReorderSam done. Elapsed time: 0.00 minutes.
Runtime.totalMemory()=5189795840
To get help, see http://broadinstitute.github.io/picard/index.html#GettingHelp
Exception in thread "main" picard.PicardException: New reference sequence does not contain a matching contig for chrI
	at picard.sam.ReorderSam.buildSequenceDictionaryMap(ReorderSam.java:229)
	at picard.sam.ReorderSam.doWork(ReorderSam.java:110)
	at picard.cmdline.CommandLineProgram.instanceMain(CommandLineProgram.java:187)
	at picard.cmdline.PicardCommandLine.instanceMain(PicardCommandLine.java:89)
	at picard.cmdline.PicardCommandLine.main(PicardCommandLine.java:99)
mv: cannot stat '/loc/scratch/3151686/picardmetrics_kalavatt_18572//home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.ReorderSam.bam': No such file or directory
ERROR: Failed to move '/loc/scratch/3151686/picardmetrics_kalavatt_18572//home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.ReorderSam.bam' to '/loc/scratch/3151686/picardmetrics_kalavatt_18572//home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/5781_G1_IN_sorted.bam'
```

Make a new fasta with *chr*-styled names:
```bash
#QUESTION What do the chromosomes look like in the bam file(s)? ---------------
cd "${dir_infiles}"  # dir_infiles=${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq
ml SAMtools/1.16.1-GCC-11.2.0

samtools idxstats "5781_G1_IN_sorted.bam" | cut -f 1
# chrI
# chrII
# chrIII
# chrIV
# chrIX
# chrM
# chrV
# chrVI
# chrVII
# chrVIII
# chrX
# chrXI
# chrXII
# chrXIII
# chrXIV
# chrXV
# chrXVI


#  Create a version of the gtf file with the above-styled chromosome names ----
cd "${HOME}/genomes/sacCer3/Ensembl/108/gtf"

cat "Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
	| cut -f 1 \
	| sort \
	| uniq
# I
# II
# III
# IV
# IX
# Mito
# V
# VI
# VII
# VIII
# X
# XI
# XII
# XIII
# XIV
# XV
# XVI

cp \
"Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
"Saccharomyces_cerevisiae.R64-1-1.108.gtf.bak"

#  gist.github.com/sahilseth/f91553f6f617f91363e7
cat "Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
	| awk '{ if($1 !~ /^#/){print "chr"$0} else{print $0} }' \
	> "Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"

cat "Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" \
	| cut -f 1 \
	| sort \
	| uniq
# chrI
# chrII
# chrIII
# chrIV
# chrIX
# chrMito
# chrV
# chrVI
# chrVII
# chrVIII
# chrX
# chrXI
# chrXII
# chrXIII
# chrXIV
# chrXV
# chrXVI
cp \
"Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" \
"Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf.bak"

sed -i \
's/chrMito/chrM/g' \
"Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"

cat "Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" \
	| cut -f 1 \
	| sort \
	| uniq
# chrI
# chrII
# chrIII
# chrIV
# chrIX
# chrM
# chrV
# chrVI
# chrVII
# chrVIII
# chrX
# chrXI
# chrXII
# chrXIII
# chrXIV
# chrXV
# chrXVI

cat "Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf.bak" \
	| cut -f 1 \
	| sort \
	| uniq
#NOTE chrMito has been changed to chrM; can delete *.plus-chr-rename.gtf.bak
rm -- *.plus-chr-rename.gtf.bak
rm -- *.gtf.bak


#  Create a version of the fasta file with the above-styled chromosome names --
cd "${HOME}/genomes/sacCer3/Ensembl/108/DNA"

zcat "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz" \
	| grep "^>"
# >I dna:chromosome chromosome:R64-1-1:I:1:230218:1 REF
# >II dna:chromosome chromosome:R64-1-1:II:1:813184:1 REF
# >III dna:chromosome chromosome:R64-1-1:III:1:316620:1 REF
# >IV dna:chromosome chromosome:R64-1-1:IV:1:1531933:1 REF
# >V dna:chromosome chromosome:R64-1-1:V:1:576874:1 REF
# >VI dna:chromosome chromosome:R64-1-1:VI:1:270161:1 REF
# >VII dna:chromosome chromosome:R64-1-1:VII:1:1090940:1 REF
# >VIII dna:chromosome chromosome:R64-1-1:VIII:1:562643:1 REF
# >IX dna:chromosome chromosome:R64-1-1:IX:1:439888:1 REF
# >X dna:chromosome chromosome:R64-1-1:X:1:745751:1 REF
# >XI dna:chromosome chromosome:R64-1-1:XI:1:666816:1 REF
# >XII dna:chromosome chromosome:R64-1-1:XII:1:1078177:1 REF
# >XIII dna:chromosome chromosome:R64-1-1:XIII:1:924431:1 REF
# >XIV dna:chromosome chromosome:R64-1-1:XIV:1:784333:1 REF
# >XV dna:chromosome chromosome:R64-1-1:XV:1:1091291:1 REF
# >XVI dna:chromosome chromosome:R64-1-1:XVI:1:948066:1 REF
# >Mito dna:chromosome chromosome:R64-1-1:Mito:1:85779:1 REF

cat "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
	| grep "^>"
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito

cp \
"Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
"Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.plus-chr-rename.fasta"

sed -i \
"s/>/>chr/g" \
"Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.plus-chr-rename.fasta"

cat "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.plus-chr-rename.fasta" \
	| grep "^>"
# >chrI
# >chrII
# >chrIII
# >chrIV
# >chrV
# >chrVI
# >chrVII
# >chrVIII
# >chrIX
# >chrX
# >chrXI
# >chrXII
# >chrXIII
# >chrXIV
# >chrXV
# >chrXVI
# >chrMito

sed -i \
"s/>chrMito/>chrM/g" \
"Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.plus-chr-rename.fasta"
# >chrI
# >chrII
# >chrIII
# >chrIV
# >chrV
# >chrVI
# >chrVII
# >chrVIII
# >chrIX
# >chrX
# >chrXI
# >chrXII
# >chrXIII
# >chrXIV
# >chrXV
# >chrXVI
# >chrM

#  Go back up to the writing/stepping-through code chunk and replace in
#+ *.plus-chr-rename.* .gtf and .fasta files
```
<br />
<br />

## To be continued after the completion of `Trinity` work
Remember, the overarching goal is to have appropriately processed bam files for experiments to determine the best way(s) to call `Trinity`
- `(...)` Continue the TPM work
    - `#DONE` Understand what needs to be run before/after what when working with the adapted code base from `slowkow` (the work started in early September, 2022)
    - `(   )` Adapt [this code](https://gist.github.com/slowkow/c6ab0348747f86e2748b#file-counts_to_tpm-r)
- `(...)` Review notes (e.g., from previous meetings), steps, written-by-me code, and emails (incorporating some into this or another notebook where necessary) prior to Alison's arrival to the lab tomorrow; we-ll likely touch base to talk about things when she comes
- `#DONE` Look into the detection of optical duplicates with `picardmetrics` or just `picard MarkDuplicates`
	- `#NOTE` Shouldn't do it with RNA-seq data: [reasoning here](https://gatk.broadinstitute.org/hc/en-us/articles/360036459932-MarkDuplicates-Picard-#--READ_NAME_REGEX)
- `(TBC)` Began to troubleshoot error in which `picardmetrics` could not access the header for `5781_G1_IN_*.bam` in the initial bam directory; continue with this tomorrow
	- Seems to have to do with this [line of code](https://github.com/slowkow/picardmetrics/blob/master/picardmetrics#L554)
- `(TBC)` Look into the detection and removal of PCR duplicates with UMI-tools as suggested by Alison: Need to figure out what that entails
	- Began to look into [this](https://umi-tools.readthedocs.io/en/latest/reference/dedup.html) at the end of the day; continue reading up on this tomorrow
- `(   )` Continue to build out the alignment and processing script you were working on at the end of last week
    + Functionize it
    + Get major modules into separate scripts, which are in-turn functionized
    + get the main work into some kind of driver script
    + Etc.
    + `(...)` Get an answer to the question, "When splitting a bam from an RNA-seq experiment by strand for visualization (two separate bw files, one for the forward strand, the other for the reverse strand), should the bam be normalized (for example, using one of the normalization options provided by deepTools' `bamCoverage --normalizeUsing`) before or after the split?"
        * Asked the question on the [Biostars forum](https://www.biostars.org/p/9543809/); thus far, no repsone
- `#DONE` Continue to put together a ["master list" of all of Alison's relevant file directories](#updated-list-of-alisons-paths-to-important-directories-and-files)
- `#DONE` Collect information on the [RNA-seq kits used by Alison](#information-on-the-rna-seq-kits-used-by-alison) to generate the libraries
<br />
<br />

# 2022-1102-1108
## [Links on how to do miscellaneous things](#links-on-how-to-do-miscellaneous-things)
### System
- [How to shut off auto-period with double space](https://stackoverflow.com/questions/42566449/avoid-auto-period-character-after-quick-type-space-in-sublime-text-3) (in particular, see comment #2, which gives a command-line input answer)

### Sublime
- [Shortcuts to change text case (upper or lower)](https://www.nobledesktop.com/blog/change-text-case-in-sublime-text)
    + Convert to upper case: `cmd k` the `cmd u`
    + Convert to lower case: `cmd k` the `cmd l`
- [Shortcuts for more complicated case conversions](https://github.com/jdavisclark/CaseConversion)
    + dash-case: `ctrl alt c`, `ctrl alt h`
    + separate words: `ctrl alt c`, `ctrl alt w`
    + [more options](https://github.com/jdavisclark/CaseConversion#keybindings)
    + [`stackoverflow.com` post](https://stackoverflow.com/questions/68735093/insert-hyphens-between-each-space-on-sublime-text)

#### On making Sublime plugins
- [Basic tutorial from Sublime](https://docs.sublimetext.io/guide/extensibility/plugins/)
- [Another tutorial](https://betterprogramming.pub/how-to-create-your-own-sublime-text-plugin-2731e75f52d5)
- [Google search results](https://www.google.com/search?q=how+to+write+a+sublime+plugin&oq=how+to+write+a+sublime+plugin&aqs=chrome..69i57j33i160j33i22i29i30l3.6346j0j7&sourceid=chrome&ie=UTF-8)
- [An example plugin](https://github.com/liangzr/WDMLMarkup/blob/master/encode_html_entities.py)
- [On creating keybindings to plugins](https://forum.sublimetext.com/t/how-to-create-key-binding-to-python-script/4589)

### Markdown
- [Sublime MarkdownEditing](MarkdownEditing)
- [Markdown Extended Syntax](https://www.markdownguide.org/extended-syntax)
- [How to add new line in markdown presentation](https://stackoverflow.com/questions/33191744/how-to-add-new-line-in-markdown-presentation)
- [How do I display local image in markdown?](https://stackoverflow.com/questions/41604263/how-do-i-display-local-image-in-markdown)
- [How to link to headers](https://stackoverflow.com/questions/51221730/markdown-link-to-header)
- [How to reference a section in another file](https://stackoverflow.com/questions/51187658/markdown-reference-to-section-from-another-file)
- [How to highlight text in a Markdown document](https://stackoverflow.com/questions/25104738/text-highlight-in-markdown)
- [Get underlined text with Markdown](https://stackoverflow.com/questions/3003476/get-underlined-text-with-markdown)

### Slack
- [fhbig.slack.com](https://fhbig.slack.com/)

### Shell scripting
- [Scripting Tips for Bioinformatics](https://informatics.fas.harvard.edu/scripting-tips-for-bioinformatics.html)
- [Use bash to multiply floats](https://stackoverflow.com/questions/26003503/utilizing-bash-to-multiply-an-interger-by-a-float-with-an-if-statement)

### On yeast genomics
- [SGD Wiki][https://wiki.yeastgenome.org/index.php/Main_Page]  `#NOTE This is fantastic`
<br />
<br />

## Looking into UMI-tools
...especially as it pertains to the removal of PCR duplicates

- Module available on the FHCC cluster: `UMI-tools/1.0.1-foss-2019b-Python-3.7.4`
- Can be installed with conda as well: `install -c bioconda umi_tools`
- [GitHub page for UMI-tools](https://github.com/CGATOxford/UMI-tools)
- [Read the Docs for UMI-tools](https://umi-tools.readthedocs.io/en/latest/index.html)

### Email chains between Alison and Matt Fitzgibbon, FHCC Bioinformatician
...regarding sequencing data and their demultiplexing, UMI information, etc.
#### Chain #1
##### Message #1
From: [SR-Bioinformatics](no-reply@fredhutch.happyfox.com)  
Sent: Wednesday, September 28, 2022 3:46 PM  
To: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Subject: \[agreenla tsukiyama_t\]: UMI question (#BI00009208)

**New ticket created #BI00009208**

Hello! 

I was wondering if UMIs were available for a run of sequencing done this April. The fastq files are in the following folder:
```txt
/shared/ngs/illumina/agreenla/220414_VH00699_101_AAAWYTFM5/Unaligned/Project_agreenla
```

I have gotten in the habit of asking genomics to sequence UMIs, but we haven't been using them computationally (though hopefully this will change soon!). I didn't see R3 .fastq files for this experiment, and I was wondering if that wasn't sequenced or if the R3 was somewhere/not normally computationally included. If R3 is no longer available, or never sequenced, that's just what it is, but if this is available and somewhere else you could direct me to, that would be great!

Thanks! 

Alison Greenlaw

##### Message #2
From: [Matt Fitzgibbon](bioinformatics@fredhutch.org)  
Sent: Wednesday, September 28, 2022 4:03 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Cc: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)  
Subject: Re: #BI00009208: \[agreenla tsukiyama_t\]: UMI question ()

**New reply for the ticket #BI00009208**
 
Hi Alison,

It looks like that run was configured with read 3 as an index read:

```txt
<Read Number="1" NumCycles="50" IsIndexedRead="N" IsReverseComplement="N"/>
<Read Number="2" NumCycles="16" IsIndexedRead="Y" IsReverseComplement="N"/>
<Read Number="3" NumCycles="8" IsIndexedRead="Y" IsReverseComplement="Y"/>
<Read Number="4" NumCycles="50" IsIndexedRead="N" IsReverseComplement="N"/>
```

Looks like these may be a "UDI-UMI" scheme with the i7 read consisting of 8bp index + an 8bp UMI? This would have to be demultiplexed manually. Happy to do that provided we know special handling is needed. In this case I don't have previous notes about this run (beyond seeing that the demultiplex looked successful, with ~6% undetermined barcodes).

If you can confirm the barcoding & UMI scheme, we'll set up new demux that should generate corresponding R3 files (similar to what we've done previously for Ovation Solo runs).

Note that in this case, I happen to still have the raw binary dump from the sequencer available, but in general we guarantee retaining the binary data for 30 days. If there are other previous runs where you'd like to leverage the UMIs please let me know flowcell IDs so we can retain them until demultiplexed.

Thanks,  
-Matt

##### Message #3
From: [SR-Bioinformatics](no-reply@fredhutch.happyfox.com)  
Sent: Wednesday, September 28, 2022 4:14 PM  
To: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Subject: New reply: : \[agreenla tsukiyama_t\]: UMI question () #BI00009208

**New reply for ticket #BI00009208**
 
Thank you so much! That scheme seems to be correct to me! The manual (screenshot attached) says to use 16 cycles to capture the 8 bp tag. I will be sure to be more proactive about requesting this in the future.

This is a long shot, but there's some sequencing from 2020 that, if the UMI data exists, I would like to have it. The data is in this folder:
`/shared/ngs/illumina/ccucinot/200722_D00300_1007_BHGV5NBCX3/`

(Christine and I shared a lane and she submitted it. I can see a "raw" folder exists but don't have permission to access it.) This one was done using the Ovation Solo kit that we have since stopped using. 

Thanks so much for all your help!  
Alison 

##### Message #4
From: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Sent: Wednesday, September 28, 2022 4:21 PM
To: [Greenlaw, Alison C](agreenla@fredhutch.org)
Cc: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)
Subject: Re: #BI00009208: New reply: : \[agreenla tsukiyama_t\]: UMI question ()
 
**New reply for the ticket #BI00009208**
 
Ok, that sounds fortunate. I coordinated with Christine on a few UMI runs. She didn't want the UMIs at the time, but we discussed that they would be unrecoverable without the raw binary data, so I saved copies of a few specific runs for her. The `200722_D00300_1007_BHGV5NBCX3` flowcell "raw" directory is likely one of these.

I'm out of office today, but will get the `220414_VH00699_101_AAAWYTFM5` demux set up tomorrow.

Cheers,  
-Matt

##### Message #5
From: [SR-Bioinformatics](no-reply@fredhutch.happyfox.com)  
Sent: Wednesday, September 28, 2022 4:27 PM  
To: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)  
Subject: New reply: : New reply: : \[agreenla tsukiyama_t\]: UMI question () #BI00009208
 
**New reply for ticket #BI00009208**
 
That's great to hear! Thank you so much!

Alison 

##### Message #6
From: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)  
Sent: Thursday, September 29, 2022 1:11 AM  
To: [Bioinformatics](bioinformatics@fredhutch.org)  
Cc: [Greenlaw, Alison C](agreenla@fredhutch.org)
Subject: Re: New reply: : New reply: : \[agreenla tsukiyama_t\]: UMI question () #BI00009208
 
Ok, this should be done for the April flowcell. Since the naming of the files is different, I put it alongside the existing results under:  
`/shared/ngs/illumina/agreenla/220414_VH00699_101_AAAWYTFM5/Unaligned_UMI/Project_agreenla`

Under the new folder, we generated the UMI reads in the \_R2 files so the second read in each pair is now named \_R3 here. That is, the older file:  
`Unaligned/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz`

has the same contents as the new file:  
`Unaligned_UMI/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz`

The file sizes may be different because of compression differences, but the uncompressed sequence should be identical. I also generated the index reads (\_I1 & \_I2) in case needed by downstream software.

Note that the data here are largely redundant with the original demultiplexing result, so the original could be removed to save storage space. I also noticed that there are a few "archived" copies of a June 2021 flowcell, likely generated by HutchBase while someone was correcting barcodes. We can remove these "archived" folders if no one is using them.

Let me know how looks,  
-Matt

##### Message #7
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Sent: Thursday, September 29, 2022 7:08 PM  
To: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)  
Subject: Re: New reply: : New reply: : \[agreenla tsukiyama_t\]: UMI question () #BI00009208
 
Looks great to me! Thank you so much! I have entered barcodes incorrectly when submitting before, so I do suspect that's what those archived copies are. 

When you have a chance, I would still appreciate the UMI info from the 2020 run. I'm currently very much in wet bench mode so it's no rush. 

Thanks!  
Alison 

##### Message #8
From: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)  
Sent: Friday, September 30, 2022 11:27 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: Re: New reply: : New reply: : [agreenla tsukiyama_t]: UMI question () #BI00009208
 
Hi Alison,

Demultiplexing for that run is done, again alongside the original since the filenames are changed (R1/R2/R3):  
`/shared/ngs/illumina/ccucinot/200722_D00300_1007_BHGV5NBCX3/Unaligned_UMI/Project_ccucinot`

This uses a newer version of the demultiplexing software than was current in 2020, so the organization is a bit different as well. The newer version also excludes the Illumina quality "failed" reads, which are generally not recommended for consideration.

Is this data related to the quiescent yeast work? I think there are two other older flowcells that may have similar UMI setup:
```txt
180816_D00300_0592_AHKHHNBCX2
200128_D00300_0897_HCHGFBCX3
```
Let me know if either of these flowcells are related to this project as well. Otherwise will close this request out for now.

Best,  
-Matt

##### Message #9
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Sent: Friday, September 30, 2022 11:32 PM  
To: [Fitzgibbon, Matthew P](mfitzgib@fredhutch.org)  
Subject: Re: New reply: : New reply: : \[agreenla tsukiyama_t\]: UMI question () #BI00009208
 
Thank you so much! Are those folders within Christine's directory? If I had to venture a guess, that would be the RNAseq that went into her 2020 elife paper on exit from Q. I'm not looking to do anything with that sequencing for my project for the time being, and I'm not sure what, if any, plans she has for that data. You're definitely good to close this request for now!

Have a nice weekend!

Alison 

#### Chain #2
##### Message #1
From: [SR-Bioinformatics](no-reply@fredhutch.happyfox.com)  
Sent: Tuesday, October 11, 2022 12:28 PM  
To: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Subject: #BI00009330: \[agreenla tsukiyama_t\]: Transfer Status Failed ()

**New ticket created #BI00009330**
 
Hi Bioinformatics - 
 
I just did some sequencing and the page on hutchbase says "Transfer process appears to have failed, please contact Bioinformatics." Could you help me with this? The run folder is `221010_VH01189_10_AAC57JMM5`. 
 
Thanks so much, 
Alison Greenlaw

##### Message #2
From: [Matt Fitzgibbon](bioinformatics@fredhutch.org)  
Sent: Tuesday, October 11, 2022 1:00 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: Re: #BI00009330: \[agreenla tsukiyama_t\]: Transfer Status Failed ()

**New reply for the ticket #BI00009330**
 
Hi Allison,

The systems group is having trouble with the storage systems. We are aware of this and I know I need to do multiplex manually to get the UM eyes to you. Will update when we know more.

-Matt

##### Message #3
From: [SR-Bioinformatics](no-reply@fredhutch.happyfox.com)  
Sent: Tuesday, October 11, 2022 1:17 PM
To: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Subject: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330
 
**New reply for ticket #BI00009330**

Thank you so much!
 
Alison 

##### Message #4
From: [Matt Fitzgibbon](bioinformatics@fredhutch.org)  
Sent: Tuesday, October 11, 2022 3:38 PM  
To: [Bioinformatics](bioinformatics@fredhutch.org)  
Subject: Re: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330
 
Hi Alison,
 
Demultiplexed output (including the UMIs as _R2) are under:
 
`/shared/ngs/illumina/agreenla/221010_VH01189_10_AAC57JMM5/Unaligned/Project_agreenla`
 
As with other UMI data, the forward & reverse read pairs are named \_R1 & \_R3 here. Overall, yield looks quite good as summarized in the table below. Let us know if you have additional questions or any trouble accessing the files.
 
Cheers,  
-Matt

| sample                              | clusters                            | pct                                 |
| :---------------------------------- | :---------------------------------- | :---------------------------------- |
| Sample_CT2_6125_pIAA_Q_Nascent      | 44,894,530                          | 7.90%                               |
| Sample_CT4_6126_pIAA_Q_Nascent      | 42,977,878                          | 7.60%                               |
| Sample_CT6_7714_pIAA_Q_Nascent      | 51,384,406                          | 9.00%                               |
| Sample_CT8_7716_pIAA_Q_Nascent      | 46,127,940                          | 8.10%                               |
| Sample_CT10_7718_pIAA_Q_Nascent     | 46,209,946                          | 8.10%                               |
| Sample_CT2_6125_pIAA_Q_SteadyState  | 42,499,841                          | 7.50%                               |
| Sample_CT4_6126_pIAA_Q_SteadyState  | 43,252,877                          | 7.60%                               |
| Sample_CT6_7714_pIAA_Q_SteadyState  | 39,023,367                          | 6.90%                               |
| Sample_CT8_7716_pIAA_Q_SteadyState  | 45,760,877                          | 8.00%                               |
| Sample_CT10_7718_pIAA_Q_SteadyState | 48,422,087                          | 8.50%                               |
| Sample_CU11_5782_Q_Nascent          | 46,984,639                          | 8.30%                               |
| Sample_CU12_5782_Q_SteadyState      | 44,791,725                          | 7.90%                               |
| Undetermined                        | 26,509,156                          | 4.70%                               |
| **Total**                           | **568,839,269**                     |                                     |
<br />
##### Message #5
From: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Sent: Wednesday, October 12, 2022 11:18 AM
To: [Bioinformatics](bioinformatics@fredhutch.org)  
Cc: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: Re: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330
 
Hi Alison,

Were you able to access these data? Let us know if everything is looking as expected.

Best,  
-Matt

##### Message #6
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Sent: Wednesday, October 12, 2022 12:46 PM
To: [Fitzgibbon, Matthew](mfitzgib@fredhutch.org)  
Subject: Re: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330
 
Hi Matt!

I was going to reply when everything started working but the server has been slow and my scripts have been buggy so it's taking a minute. I am pretty sure it's all good on the demultiplexing end but I will reach out if there are issues. 
 
Alison

##### Message #7
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Wednesday, October 26, 2022 at 3:38 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Fw: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330

Turns out the UMI information is in a place I don't have permission to access for `WTQ_G1`. I am fixing this, but it is dependent on bioinformatics core so unfortunately, I don't know when I will be able to get it to you. 

Other UMI info in these Locations:
```txt
~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla

~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/UMI
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/UMI
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
```

##### Message #8
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Sent: Wednesday, October 26, 2022 3:41 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: Re: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330
 
Thanks, sounds good.

##### Message #9
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Sent: Wednesday, October 26, 2022 6:55 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Re: New reply: : \[agreenla tsukiyama_t\]: Transfer Status Failed () #BI00009330
 
Got permission and copied to the following directory:

`~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot`

Let me know if you have any issues. 

Alison 

### Notes, etc. on removing PCR duplicates from *bulk* RNA-seq data
#### [Should I remove PCR duplicates from my RNA-seq data?](https://dnatech.genomecenter.ucdavis.edu/faqs/should-i-remove-pcr-duplicates-from-my-rna-seq-data/)
The short and generalized answer to the question “Should I remove PCR duplicates from my RNA-seq data?” is in most cases **NO**. For some scenarios, de-duplification can be helpful, but **only when using UMIs**. Please see the details below.

The vast majority of RNA-seq data are analyzed *without duplicate removal*. Duplicate removal is not possible for single-read data (without UMIs). De-duplification is more likely to cause harm to the analysis than to provide benefits even for paired-end data ([Parekh et al., 2016](https://www.nature.com/articles/srep25533)). This is because *the use of simple sequence comparisons, or the typical use of alignment coordinates, to identify “duplicated reads” will lead to the removal of valid biological duplicates*. RNA-seq library preparation involves several processing steps (e.g., fragmentation, random priming, A-tailing, ligation); none of these processes is truly random or unbiased. Thus, the occurrence of "duplicated reads" in between millions of reads can be expected even in paired-end read data. Short transcripts and very highly expressed transcripts will show the majority of such “natural” duplicates. Their removal would distort the data. For example, plant RNA-seq data often seem to contain large amounts of duplicated reads. This is in part due to the fact the gene expression in many plant tissues, like leaves, is dominated by a small number of transcripts: much more so than in most animal samples. Another concern is that the fraction of reads identified as "duplicated" is correlated to the number of aligned reads. Thus, one would have to normalize any data set for equal read numbers to avoid introducing additional bias.

Several studies (among them [Parekh et al., 2016](https://www.nature.com/articles/srep25533); see below) have shown that retaining PCR and Illumina-clustering duplicates does not cause significant artifacts *as long as the library complexity is sufficient*. The library complexity is, in most cases, directly related to the amount of starting material available for the library preparation. Chemical inhibitors present in the sample could also cause low conversion efficiency and thus reduced library complexities. *PCR duplicates are thus mostly a problem for very low input or for extremely deep RNA-sequencing projects. In these cases, UMIs (Unique Molecular Identifiers) should be used to prevent the removal of natural duplicates.* UMIs are, for example, standard in almost all single-cell RNA-seq protocols.

*The usage of UMIs is recommended primarily for two scenarios: very low input samples and very deep sequencing of RNA-seq libraries* (> 80 million reads per sample). UMIs are also employed for the detection of ultra-low frequency mutations in DNA sequencing (e.g. [Duplex-Seq](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4271547/)). For other types of projects, UMIs will have a minor effect in reducing PCR amplification-induced technical noise. Our 3′-Tag-RNA-Seq protocol [employs UMIs by default](https://dnatech.genomecenter.ucdavis.edu/tag-seq-gene-expression-profiling/. For other RNA-seq applications, please request UMIs on the submission form. When using UMIs for conventional RNA-seq, genomic DNA-sequencing, or ChIOP-seq, the first eleven bases of both forward and reverse reads will represent UMI and linker sequences. These are then followed by the biological insert sequences. The UMI sequences are usually trimmed off and the information transferred into the read ID header with software utilities like UMI-Tools.

Please see the [discussion here](https://www.biostars.org/p/55648/) for details and these excellent papers:
- [Parekh et al., 2016](https://www.nature.com/articles/srep25533): The impact of amplification on differential expression analyses by RNA-seq.
- [Fu et al., 2018](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-018-4933-1): Elimination of PCR duplicates in RNA-seq and small RNA-seq using unique molecular identifiers.
- [Kennedy et al., 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4271547/): Detecting ultralow-frequency mutations by Duplex Sequencing. 

*This [blog post](molecularecologist.com/2016/08/the-trouble-with-pcr-duplicates) offers a detailed analysis of the effect of increasing read numbers on the frequency of PCR duplicates as well as the occurrence of false-positive duplicate identifications on another type of Illumina sequencing data (RAD-seq). Please note that the library type studied is different from RNA-seq as are the potential effects of PCR duplicates for this type of analysis. In contrast to RNA-seq, PCR duplicates should be removed for most RAD-seq studies.*

#### [What are UMIs and why are they used in high-throughput sequencing?](https://dnatech.genomecenter.ucdavis.edu/faqs/what-are-umis-and-why-are-they-used-in-high-throughput-sequencing/)
**UMI** is an acronym for **U**nique **M**olecular **I**dentifier. UMIs are complex indices added to sequencing libraries **before** any PCR amplification steps, enabling the accurate bioinformatic identification of PCR duplicates. UMIs are also known as “Molecular Barcodes” or “Random Barcodes”. The idea seems to have been first implemented in an iCLIP protocol ([König et al., 2010](https://www.nature.com/articles/nsmb.1838)).

UMIs are valuable tools for both **quantitative** sequencing applications (e.g., RNA-Seq, ChIP-Seq) and also for **genomic variant detection**, especially the detection of rare mutations. UMI sequence information, in conjunction with alignment coordinates, enables grouping of sequencing data into **read families** representing individual sample DNA or RNA fragments. Please see the graphic below.

**The problems UMIs are addressing:**
- **Quantitative analysis:** Many sequencing library preparation protocols enable high-throughput sequencing (HTS) from low amounts of starting material. Their preparation requires PCR amplification of the libraries. While the PCR polymerases and reagents have been improved greatly in recent years, enabling a mostly unbiased amplification of sequencing libraries, *some biases still remain against sequences with extreme GC contents and against long fragments*. When starting from ultra-low input samples, stochastic effects in the first rounds of the PCR add to the problems. These issues can potentially cause erroneous quantitation data. *Removal of PCR duplicates using alignment coordinate information is especially inefficient for low-input situations and also for deep sequencing data.* In the latter case, *alignment coordinate-based de-duplification will remove large numbers of biological duplicate reads from the data, especially for the most abundant transcripts*. *UMIs alleviate the PCR duplicate problem* by adding unique molecular tags to the sequencing library molecules before amplification. Please also see our [FAQ: “Should I remove PCR duplicates from my RNA-seq data?”](https://dnatech.genomecenter.ucdavis.edu/faqs/should-i-remove-pcr-duplicates-from-my-rna-seq-data/) for more information.
- **Rare variant analysis:** Illumina sequencing provides data with low error rates (~0.1 to 0.5%) for most applications. These low error rates nevertheless interfere with the confident identification of low abundance variants. UMI-less data can’t distinguish between these and sequencing errors. UMIs, in combination with deep sequencing yielding multiple reads for each of the sample DNA fragments, solved this problem. The approach was first described as [Duplex Sequencing](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4271547/). Hereby, single-strand consensus sequences (SSCSs) and Duplex consensus sequences (DCSs) assembly of the read families increase the accuracy of the sequencing data significantly. Please note that the DNA sample starting amounts and the library yields have to be controlled for this approach to be efficient. Applications include sequencing of heterogeneous tumor samples, cfDNA sequencing including ctDNA sequencing, and deep exome sequencing.

The usage of **UMIs** is recommended primarily for three scenarios: very low input samples, very deep sequencing of RNA-seq libraries (> 80 million reads per sample), and the detection of ultra-low frequency mutations in DNA sequencing. For many other types of projects, UMIs will yield minor increases in the accuracy of the data. In addition, *UMI analysis is an excellent QC tool for library complexity.*

**Incorporating UMIs into sequencing libraries:**
- Our **3′-Tag-RNA-Seq** protocols employ [UMIs by default](https://dnatech.genomecenter.ucdavis.edu/tag-seq-gene-expression-profiling/). For **Tag-seq**, the first 6 bases of the forward read represent the UMI. These are followed by a common linker with the sequence "TATA", followed by the 12-bp random priming sequence. It is recommended to transfer the UMI sequence information to the read header and to trim the first 22 bases from each read with UMI-TOOLS or custom scripts.
- For **conventional RNA-seq and DNA sequencing applications**, you will specifically have to request UMIs on the submission form. The default library preparations will NOT use UMIs. The UMIs will be located in-line with the insert sequences for conventional RNA-seq, genomic DNA-sequencing, or ChIP-seq. *The first twelve bases of both forward and reverse reads will represent UMIs and associated linker sequences (7 nt UMI sequence followed by a 5 nt spacer "TGACT"; UMIs of forward and reverse read are independent, resulting in a combined UMI length of 14 nt)*. UMIs and spacers are then followed by the biological insert sequences (for paired-end data, a total of 22 bp will be dedicated to the UMIs instead of the inserts). The UMI and spacer sequences are usually trimmed off and the information transferred into the read ID header with software utilities like UMI-Tools or FASTP.

The figure below displays the (simplified) principles of the UMI data analysis for quantitative and variant detection studies.  
![UMI figure](./readme/UMIs.png)

##### Notes, questions related to the above text
- `#TODO (   )` Look into how to use UMIs to detetermine the complexity of RNA-seq libraries
    + Can I do this with UMI-tools?
- What are the UMIs in Alison's libraries?
    + Are they independent for each reads as described in the second bullet under **Incorporating UMIs into sequencing libraries**?
    + Does UMI-tools automatically detect the UMIs when using, say, the `dedup` subcommand?
- The above figure makes things very clear: great figure!

#### Notes from reading the Biostars post, ["Should We Remove Duplicated Reads In RNA-seq?"](https://www.biostars.org/p/55648/)
- [Top comment](https://www.biostars.org/p/55648/#55662): The general consensus seems to be to NOT remove duplicates from RNA-seq. Read the Biostar discussions:
    + [Duplicated reads in RNA-Seq Experiment](https://www.biostars.org/p/14283/)
    + [Read duplicates](https://www.biostars.org/p/47229/)
    + [Duplicate reads in RNAseq](https://www.biostars.org/p/52966/)
    + and [this seqanswers thread](http://seqanswers.com/forums/showthread.php?t=6854) and the other threads it links to.
- [Most interesting comment (sub-comment to the top comment)](https://www.biostars.org/p/55648/#55882): The general consensus I see from those discussions, [rather than "no"](https://www.biostars.org/p/55648/#55662), is "it depends". The first link: Malachi Griffith writes: *"Observing high rates of read duplicates in RNA-seq libraries is common. It may not be an indication of poor library complexity caused by low sample input or over-amplification. It might be caused by such problems but it is often because of very high abundance of a small number of genes."* Second link: Istvan Albert writes: *"My personal opinion is to investigate the duplication rates and remove them if there is indication that these are artificial ones."* Third link: Ketil writes: *"I think the number of duplicates depend on many factors, so it is hard to give any general and useful rules of thumb. Usually, duplicates are correlated with too little sample material, and/or difficulties in the lab."* And the seqanswers thread goes both ways.

#### The abstract of [Parekh et al., *Sci Rep* 2016](https://www.nature.com/articles/srep25533)
Currently, quantitative RNA-seq methods are pushed to work with increasingly small starting amounts of RNA that require amplification. However, it is unclear how much noise or bias amplification introduces and how this affects precision and accuracy of RNA quantification. To assess the effects of amplification, reads that originated from the same RNA molecule (PCR-duplicates) need to be identified. *Computationally, read duplicates are defined by their mapping position, which does not distinguish PCR from natural duplicates and hence it is unclear how to treat duplicated reads.* Here, we generate and analyse RNA-seq data sets prepared using three different protocols (Smart-Seq, TruSeq and UMI-seq). *We find that a large fraction of computationally identified read duplicates are not PCR duplicates and can be explained by sampling and fragmentation bias. Consequently, the computational removal of duplicates does *improve neither accuracy nor precision and can actually worsen the power and the False Discovery Rate (FDR) for differential gene expression.* Even when duplicates are experimentally identified by unique molecular identifiers (UMIs), power and FDR are only mildly improved. However, *the pooling of samples as made possible by the early barcoding of the UMI-protocol leads to an appreciable increase in the power to detect differentially expressed genes.*

##### Notes, questions related to the above text
- `#DONE` What kind of wet-lab RNA-seq protocol/kit/etc. did Alison use?
    + It will be helpful to read over and understand that
    + If there are different protocols/kits/etc. for different libraries, need to know that too
    + `#DONE` Add in the information sent by Alison in the email "RNA seq kit info," sent 2022-1102
    + See the section ["Information on the RNA-seq kits used by Alison"](#information-on-the-rna-seq-kits-used-by-alison) below

#### On ["Elimination of PCR duplicates..." (Fu et al., *BMC Genom* 2018)](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-018-4933-1)
##### Abstract
**Background**  
RNA-seq and small RNA-seq are powerful, quantitative tools to study gene regulation and function. Common high-throughput sequencing methods rely on polymerase chain reaction (PCR) to expand the starting material, but not every molecule amplifies equally, causing some to be overrepresented. Unique molecular identifiers (UMIs) can be used to distinguish undesirable PCR duplicates derived from a single molecule and identical but biologically meaningful reads from different molecules.

**Results**  
We have incorporated UMIs into RNA-seq and small RNA-seq protocols and developed tools to analyze the resulting data. Our UMIs contain stretches of random nucleotides whose lengths sufficiently capture diverse molecule species in both RNA-seq and small RNA-seq libraries generated from mouse testis. Our approach yields high-quality data while allowing unique tagging of all molecules in high-depth libraries.

**Conclusions**  
Using simulated and real datasets, we demonstrate that our methods increase the reproducibility of RNA-seq and small RNA-seq data. Notably, *we find that the amount of starting material and sequencing depth, but not the number of PCR cycles, determine PCR duplicate frequency*. Finally, we show that *computational removal of PCR duplicates based only on their mapping coordinates introduces substantial bias into data analysis*.

##### Final paragraph of Introduction
Here, we describe novel experimental protocols and computational methods to unambiguously identify PCR duplicates in RNA-seq and small RNA-seq data. We show that r*emoving PCR duplicates using UMI information is accurate, whereas removing PCR duplicates without UMIs is overly aggressive,* eliminating many biologically meaningful reads. Finally, we show that *the amount of starting materials and sequencing depth determine the level of PCR duplicates, without additional contribution from the extent of PCR amplification.*
<br />
<br />

## Information on the RNA-seq kits used by Alison
### Email from Alison
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Wednesday, November 2, 2022 at 4:27 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: RNA seq kit info

SoLo Kit - all RNAseq from ~2017-2020ish  
G1vsQ data produced with this kit  
https://lifesciences.tecan.com/ovation-solo-rna-seq-library-preparation-nuquant
 
Universal Plus Total - all other RNA sequencing by AG  
https://lifesciences.tecan.com/universal-plus-total-rna-seq-library-preparation-kit-nuquant

Alison 

### Additional notes
- For Ovation SoLo, [pdf files are here](https://lifesciences.tecan.com/ovation-solo-rna-seq-library-preparation-nuquant?p=tab--5)
- For Universal Plus Total, [pdf files are here](https://lifesciences.tecan.com/universal-plus-total-rna-seq-library-preparation-kit-nuquant?p=tab--5)
<br />
<br />

## Updated list of Alison's paths to important directories and files
### Locations of "processed `.bam` files"
...i.e., those that are ready for use with `htseq-count` or `featurecounts`

#### WTQvsG1
```txt
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/bam_resort
```

#### Nab3_Nrd1_Depletion
```txt
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/SC_bams_all
```
- `#DONE` Double check that this is the correct location for "processed .bam files"
    + Seems not to be per [this email](#email-from-alison-2022-1020); for example, output of HTSeq `count` here:
```txt
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/S_cerevisiae_BamFiles/bam_resort/feature_counts_7716_6126
```

#### Email chain between me and Alison
##### Message #1
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Date: Tuesday, November 1, 2022 at 10:55 AM
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Re: .bam files for calculating TPM

Yes! 
 
There are bam files at:  
```txt
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq
```
Also resorted for HTseq:  
```txt
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/bam_resort
```

I should be in in the next hour-ish so we can chat more then! 
 
Alison

##### Message #2
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Sent: Tuesday, November 1, 2022 10:19 AM
To: [Greenlaw, Alison C](agreenla@fredhutch.org)
Subject: .bam files for calculating TPM
 
Hi Alison,
 
In addition to Nab3_Nrd1_Depletion, was thinking to test my in-progress TPM code on some WTQvsG1 .bam files that you have processed (those that you’re using to run htseq-count/featurecounts). If there are any, can you let me know the location of some files?
 
Thanks,  
Kris

### Locations of "raw `.fastq` files" and "UMI information"
Notes and summary based on an email chain between me and Alison, [shown below](#email-chain-between-me-and-alison) and [above](#email-chains-between-alison-and-matt-fitzgibbon-fhcc-bioinformatician)
#### WTQvsG1
##### #1
```txt
~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot
```
- Demultiplexed but still contain PCR duplicates to be removed with UMI-tools
- The `.fastq` files in here look like this:
```txt
*_I1_001.fastq.gz
*_R1_001.fastq.gz
*_R2_001.fastq.gz
*_R3_001.fastq.gz
```

##### #2
```txt
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
```
- Demultiplexed but still contain PCR duplicates to be removed with UMI-tools
- These directories contain copies of the above `.fastq` files
```txt
*_R1_001.fastq
*_R1_002.fastq
*_R1_003.fastq
*_R1_004.fastq
*_R2_001.fastq
*_R2_002.fastq
*_R2_003.fastq
*_R2_004.fastq
```

#### TRF4_SSRNA_April2022
```txt
~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla
#QUESTION What is this project?
#QUESTION Is this a project we're working on now? 
```

#### Nab3_Nrd1_Depletion
###### #1
```txt
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}
```
- Demultiplexed but still contain PCR duplicates to be removed with UMI-tools
- Here, there are `.fastq` files with strings `*_R1_*` and `*_R3_*`, e.g.,
```txt
*_Nascent_S3_R1_001.fastq
*_Nascent_S3_R3_001.fastq
*_SteadyState_S8_R1_001.fastq
*_SteadyState_S8_R3_001.fastq
```

###### #2
```txt
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/UMI
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/UMI
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI

# i.e.,
# ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/UMI
```
- Here, there are .fastq files with strings: `*_R1_*`, `*_R2_*`, `*R3_`*, `*_I1_*`, and `*_I2_*`; how to handle them?
    + `#TODO (   )` Reference with [the email chains between Alison and Matt](#email-chains-between-alison-and-matt-fitzgibbon-fhcc-bioinformatician)
- How are these files different from the above?

#### Email chain between me and Alison
...on "raw" `.fastq` files and "UMI information"

##### Message #1
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Sent: Thursday, October 27, 2022 2:43 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: Some questions about the fastq files
 
Hi Alison,
 
I just want to check my understanding regarding the fastq files: i.e., what is what, what I should try out for alignment and Trinity work, etc.

For the WT Q vs. G1 analyses, raw fastq files are in this directory:
```txt
~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot
```
1. These have not yet been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?
 
For the WT Q vs. G1 analyses as well, there are also raw fastq files in these directories:
```txt
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
```
2. These files have been demultiplexed, but PCR duplicates remain in the fastq files—is that correct?
3. To save time, I am thinking I should use the `*_merged_R{1,2}.fastq` files for alignment to the combined reference (comprised of *S. cerevisiae*, *K. lactis*, and 20 S) and downstream steps: is that reasonable to you?
 
For WT vs. Nab3-depletion work, there are fastq files in these directories:
```txt
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}
```
4. These files have been demultiplexed, but PCR duplicates remain in the fastq files—is that correct?
 
Within each of the immediately above `{5782_7714,6125_7718,6126_7716}` directories, there are UMI subdirectories:
```txt
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/UMI
```
5. These contain fastq files that have not been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?
 
Until I hear back from you, I will move forward with what I typed in question #3 above. I’ll appreciate any instructions, insights, and/or advice.
 
Thanks! And apologies for the questions while you’re off,
Kris

##### Message #2
From: [Greenlaw, Alison C](agreenla@fredhutch.or )  
Date: Thursday, October 27, 2022 at 2:58 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.or)  
Subject: Re: Some questions about the fastq files

Hi Kris! You caught me right before my flight so excellent timing. 
 
> To address your questions:  
> For the WT Q vs. G1 analyses, raw fastq files are in this directory:  
> ```txt
> ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot
> ```
> 1. These have not yet been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?

Yes! They have been "demultiplexed" in that the core splits them by barcode but no UMI processing has been done. (Is this also known as demultiplexing?) PCR duplicates should be removed using UMI tools. Then, use those fastq files with UMI removed for alignment and Trinity work. 

> For the WT Q vs. G1 analyses as well, there are also raw fastq files in these directories:
> ```txt
> ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
> ```
> 2. These files have been demultiplexed, but PCR duplicates remain in the fastq files: is that correct?

Yep! 

> 3. To save time, I am thinking I should use the `*_merged_R{1,2}.fastq` files for alignment to the combined reference (comprised of *S. cerevisiae*, *K. lactis*, and 20 S) and downstream steps: is that reasonable to you?

This is definitely a good place to start! Perhaps we can re-do with UMI factored in later?

> For WT vs. Nab3-depletion work, there are fastq files in these directories:
> ```txt
> ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}
> ```
> 4. These files have been demultiplexed, but PCR duplicates remain in the fastq files: is that correct?

Yes!

> Within each of the immediately above `{5782_7714,6125_7718,6126_7716}` directories, there are UMI subdirectories:
> ```txt 
> ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/UMI
> ```
> 5. These contain fastq files that have not been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?

Yes - so R2 contains UMI info - it needs to be processed along with R1 and R3 to my knowledge if we are incorporating UMI info. 
 
Hopefully this is clarified for you! I think you are very much on the right track. I have not done any work to remove PCR duplicates, I have been saving UMI info for a future moment, that may or may not be soon depending on how much Trinity needs less coverage. 
 
Alison

### Locations of other important files

#### Email from Alison, 2022-1020
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Thursday, October 20, 2022 at 5:56 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: File Locations

Hi Kris - 

Nab3 depletion data  
`~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla`

Folders of interest:
- I split samples for speed reasons. Raw fastq R1 and R3 reads in these 3 folders: 
    - 5782_7714
    - 6126_7716
    - 6125_7718
        - Within each folder is UMI folder with R2, I1 and I2 reads. We don't currently have a pipeline with includes them, but I have thought it would be good for a while. 
    - I copied all aligned bams into SC_bams_all
    - Output of HTSeq count (one for each folder above):
        - `~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/S_cerevisiae_BamFiles/bam_resort/feature_counts_7716_6126`

WT G1 vs Q data  
`~/tsukiyamalab/alisong/WTQvsG1/`

Folders of interest: 
- Raw fastq info
    - `~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot`
    - each sample has a folder. The Bioinformatics core does it differently now. So fastq files used to need to be merged. 
    - "IP" = Nascent, "IN" = SteadyState
- Trinity Run Location
    - `~/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/all_at_once/correct_bams`
- Map trinity output to genome location
    - `~/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/map_trin_to_genome/try2`
- I started thinking about annotation automation. Not a ton here but some
    - `~/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation`
- I attempted to break AS transcripts into Classes. That all happened here. This is probably the biggest mess of any of the above:
    - `~/tsukiyamalab/alisong/WTQvsG1/MANUAL/AS_CLASSES`
    - and: `~/tsukiyamalab/alisong/WTQvsG1/MANUAL/AS_CLASSES/jan2022_good`

Steady State Q entry Data
- `~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla`
- This was all done for an old project but might be relevant to Toshi's interests and or the larger project

All the R stuff is local to my laptop/on my OneDrive. Happy to figure out a way to share than more easily. Also please let me know if there are file permission issues. 

Alison

## RNA-seq: Information on bamCoverage, spike-ins with DESeq2
### Looking into the use of bamCoverage with RNA-seq data
#TODO Return to this line of thinking later; for now, focus on PCR deduplication using UMI-tools and the UMI-containing `.fastq` files from FHCC Bioinformatics
- [Purpose of bamCoverage RPKM normalization methods](https://www.biostars.org/p/9474318/)
- [bamCoverage and RNA-seq data](https://github.com/deeptools/deepTools/issues/401)
- [Normalization with deepTools](https://www.biostars.org/p/473442/)
    + This is super useful!
    + Referenced in the above post as, essentially, what to do: [ATAC-seq sample normalization](https://www.biostars.org/p/413626/#414440)
        * No worries: The principles hold for the bin-based normalization of RNA-seq data too
        * A reference within this post that I should check over: [Normalizing for technical biases](http://bioconductor.org/books/3.13/csawBook/chap-norm.html)
            - "There is a great chapter in Aaron Lun's csaw book on normalization in the ChIP-seq (which applies to ATAC-seq as well) context that discusses the various aspects to consider..."
    + Also referenced in the above as "more details of the different normalization methods of bamCoverage": [Deeptools sample scaling](https://www.biostars.org/p/167950/)
    + Also referenced in the above is [bamCoverage and RNA-seq data](https://github.com/deeptools/deepTools/issues/401)

### Looking into the use of spike-ins prior to running `DESeq2`
`#TODO (   ) Write up notes later`
- [estimateSizeFactors](https://rdrr.io/bioc/DESeq2/man/estimateSizeFactors.html)
- [Incorporating spike-ins to RNA-seq analysis](https://support.bioconductor.org/p/9143354/)
- [DESeq2 estimateSizeFactors with control genes](https://support.bioconductor.org/p/115682/)
- [...from the DESeq2 vignette](https://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#control-features-for-estimating-size-factors)
- [Bioconductor post on how to refer to the spike-in genes when calling `estimateSizeFactors()`](https://support.bioconductor.org/p/103826/)
- [Another Bioconductor post on how to call `controlGenes`](https://support.bioconductor.org/p/130660/)
- [Nice, simple explanation of `controlGenes` and its purpose in this Biostars post](https://www.biostars.org/p/400532/#400543)

#### Related email from me to Alison
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Date: Thursday, November 3, 2022 at 1:39 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: FW: A question and a thought

Did a bit more reading: seems like calling `DESeq2::estimateSizeFactors()` with the `controlGenes` option set to our KL genes can be the way to go.
 
So, in that case...
1. when we call the script to split the bam by species, we should output, for each condition, bam files that contains both SC and KL (we should continue to filter out 20S, right?)
2. when we call `DESeq2::estimateSizeFactors()`, we should set the `controlGenes` option to refer to only the KL genes in our dds object; then, when size factors are determined, DESeq2 is going to run calculations that assume KL gene expression is unchanging between conditions
3. the size factors will continue to pertain only to the SC genes (for each condition) and be affected by the unchanging-KL-gene-expression assumption
4. this seems legit to me
 
Let’s try it out! I’ll start working on it after my lunch.
 
-Kris

#### Moving forward
I sent these links to Alison, who will move forward with implementing this.

##### Related email from me to Alison
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Date: Thursday, November 3, 2022 at 2:32 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: More thinking about estimateSizeFactors with controlGenes

While walking around, it occurred to me that you could filter the counts matrix to keep only *K. lactis* genes with row sums above some cutoff or with a row mean higher above some cutoff, which could help to ensure the filtering out of low-expression/high-variance genes. You could even calculate row standard deviation too and keep it below some cutoff to ensure that you’re working with genes that don't vary much from sample to sample.
<br />
<br />

##  Get another trial run of `Trinity` going
Just to reacquaint yourself with things...
```bash
#DONTRUN

grabnode  # 1 node, default memory, 1 node, no GPU (default)

#  cd into the work directory
results="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results"
cd "${results}/2022-1101"

#  Make a directory for the results from the previous picardmetrics test (see
#+ above)
mkdir -p exp_picardmetrics
mv 5781_G1_IN_sorted.* picardmetrics.conf exp_picardmetrics/

#  Make symlinks to the test bams
ln -s \
"${results}/2022-1021/5781_Q_IP_sorted.bam" \
"./5781_Q_IP_sorted.bam"

ln -s \
"${results}/2022-1021/5781_Q_IP_sorted.chrVII.bam" \
"./5781_Q_IP_sorted.chrVII.bam"

#  Check that the symlinks are valid
ml SAMtools/1.16.1-GCC-11.2.0  # Load in samtools

samtools view "./5781_Q_IP_sorted.bam" | head -5
# HISEQ:1007:HGV5NBCX3:1:1207:3282:88984  99  chrI    147 17  49M =   307 209 TTACCCTGTCTCATTCAACCATACCACTCCCAACTACCATCCATCCCTC   GGGGIGIIIIGGIIIIIIIGIGIIIIIIIGIIIIIIIGIIIIIGIIIGI   AS:i:75 XS:i:52 XN:i:0  XM:i:3  XO:i:0  XG:i:0  NM:i:3  MD:Z:10C19G3C14 YS:i:90 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1216:10817:56273 99  chrI    159 2   49M =   234 123 ATTCAACTATACCACTCCCAACTACCATCCATCTCTCTACTTACTACCA   GGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGGIIIIIIIGIIIG   AS:i:66 XS:i:78 XN:i:0  XM:i:4  XO:i:0  XG:i:0  NM:i:4  MD:Z:7C10G3C10C15   YS:i:80 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1112:7352:13135  99  chrI    226 2   19M1I29M    =   433 257 CCAATTACCCATATCCTACTCCACTGCCACTTACCCTACCATTCCCCTA   GGGGGGGIIIIIGIIIIIIIIIIIIIGIIIGIGGGGAGGIIIIGIIIII   AS:i:73 XS:i:75 XN:i:0  XM:i:2  XO:i:1  XG:i:1  NM:i:3  MD:Z:16A25A5    YS:i:73 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2210:9324:79218  99  chrI    229 11  16M1I32M    =   295 115 ATTACCCATATCCTACTCCACTGCCACTTACCCTACCATTACCCTACCA   GGGGGGIIIIIIIIIIIIIIIIIIIGGGIIIIIIIIIGIIIIIIIIIIG   AS:i:80 XS:i:82 XN:i:0  XM:i:1  XO:i:1  XG:i:1  NM:i:2  MD:Z:13A34  YS:i:90 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1216:10817:56273 147 chrI    234 2   11M1I37M    =   159 -123    CCATATCCTACTCCACTGCCACTTACCCTACCATTACCCTACCATCCAC   IIGGGIIIIGGGIGGGGIIIIIIGGGIIIGIIIGGGIIGGGIGGGGGGG   AS:i:80 XS:i:83 XN:i:0  XM:i:1  XO:i:1  XG:i:1  NM:i:2  MD:Z:8A39   YS:i:66 YT:Z:CP

samtools view "./5781_Q_IP_sorted.chrVII.bam" | head -5
# HISEQ:1007:HGV5NBCX3:1:1216:9044:65854  99  chrVII  79  11  1S48M   =   252 219 GTCTCTCAACTTACCCTCCATTACCCTACCTCACCACTCGTTACCCTGT   AGA.<AGGGAGGAA<AGGGGIIIIGGIIGGGGIGGIGIIIIIIIIGGAG   AS:i:81 XS:i:90 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:4A26C16    YS:i:72 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2105:9998:77180  99  chrVII  189 0   22S27M  =   403 286 CCATTCATCCCTCTACTTCCTACCATCATAACCGTTACCCTCCAATTAC   GGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII   AS:i:54 XS:i:54 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:27 YS:i:77 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2103:16874:90641 99  chrVII  215 34  49M =   390 224 CCATATCCAACTCCACTACCATTACCCTACTATTACCCTACCATCCACC   GGGGGIIIIIIIIIIIIIIIIIIIIIIGIIIIIIIIGIIIIIIIIIIII   AS:i:98 XS:i:98 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:49 YS:i:98 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1109:8925:17739  99  chrVII  220 17  1S48M   =   347 177 TTCCAACTCCACTACCATTACCCTACTATTACCCTACCATCCACCATGT   GGGGGIIIIIGGGGIGGIGGIIIIIIIIIGGGIIIGGGIIIGGGGGIGG   AS:i:96 XS:i:96 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:48 YS:i:76 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1216:9044:65854  147 chrVII  252 11  4S43M2S =   79  -219    TCATCTACCATCCACCATGTCCTACTCACCATACTGTTGTTCTACCCAC   GAGGGGG<<.GIGIGGGGGGIIIIIGGGGGGIGGGGGGGGIGGAGAAAA   AS:i:72 XS:i:72 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:25T0G16    YS:i:81 YT:Z:CP

#  Write out the script for calling Trinity
cat << script > "./submit-Trinity.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Trinity.sh
#  KA

module load Trinity/2.10.0-foss-2019b-Python-3.7.4

file="5781_Q_IP_sorted.chrVII.bam"  # Separately, try 5781_Q_IP_sorted.bam

Trinity \\
    --genome_guided_bam "\${file}" \\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\
    --max_memory 50G \\
    --SS_lib_type FR \\
    --normalize_max_read_cov 200 \\
    --jaccard_clip \\
    --genome_guided_max_intron 1002 \\
    --min_kmer_cov 2 \\
    --max_reads_per_graph 500000 \\
    --min_glue 2 \\
    --group_pairs_distance 700 \\
    --min_contig_length 200 \\
    --full_cleanup \\
    --output "./trinity_\${file%.bam}"
script

#  Run submit-Trinity.sh on SLURM
sbatch ./submit-Trinity.sh

#  Run time:
#+ - Job started: Thursday, November 3, 2022: 15:26:01
#+ - Job finished: Thursday, November 3, 2022: 15:37:00


#  Clean up Trinity outfiles
pwd
# "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

mkdir -p exp_Trinity
mv 5781_* 3299486* trinity_5781_* exp_Trinity/
```

## Continued reading, studying regarding `Trinity`
Builds on work [performed here](../2022-1025/readme.md#snippets-etc-from-searching-the-trinity-google-group)

### [Outstanding, ongoing questions, points, etc.](#outstanding-ongoing-questions-points-etc)
- When building a transcriptome with Trinity, should we use all `.fastq` (*de novo* assembly) or `.bam` (genome-guided assembly) files in one run? Would doing so build a transcriptome from that combined information?
- What is *minimizing the sum of ranks* [described below](#from-file-s1)?
    + Does it mean summing the three metrics of interest&mdash;**Transcript Length Distribution Related Factors (when maximized)**, **Unweighted K-mer KL_A_to_M (when minimized)**, and **Unweighted_Pair_F1 (when maximized)**&mdash;and then taking the assembly with lowest sum?
    + I think that could be it...
    + Some kind of transformation (hence, "rank") needs to take place, I think
- For `Bowtie 2` alignment, what does "concordant" and "discordant" mean?
    + "A discordant alignment is an alignment where both mates align uniquely, but that does not satisfy the paired-end constraints (`--fr`/`--rf`/`--ff`, `-I`, `-X`)" ([reference](https://www.biostars.org/p/78446/))
        * `--fr`/`--rf`/`--ff`: The upstream/downstream mate orientations for a valid paired-end alignment against the forward reference strand
        * `-I`: The minimum fragment length for valid paired-end alignments
        * `-X`: The maximum fragment length for valid paired-end alignments
- For `Bowtie 2` alignment, what does `--no-mixed`/"mixed mode" mean?
    + If `Bowtie 2` cannot find a paired-end alignment for a pair, by default it will go on to look for unpaired alignments for the constituent mates. This is called "mixed mode."
    + To disable mixed mode, set the `--no-mixed` option.
    + `Bowtie 2` runs a little faster in `--no-mixed` mode, but <mark>will only consider alignment status of pairs *per se*, not individual mates</mark>.
    + ([reference](https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#mixed-mode-paired-where-possible-unpaired-otherwise))
- Bowtie 2 is not a splice-aware aligner, so why are we using it for RNA-seq work?
    + Very little splicing takes place in yeast
    + I discussed this with Toshi on 2022-1107
        * Categories of genes that undergo splicing
            - Ribosome protein-coding genes
            - Housekeeping genes such as ACT1 (Actin)  `#TODO Look up how to format genes and proteins for yeast`
            - Toshi says that genes with alternative splicing tend to be constitutively active
                + These are not well-studied by researchers who tend to be interested in genes that are expressed under different conditions and circumstances
                + "...boring"
        * Per Toshi, there are no genes with more than one intron
        * Average gene size is less than one kb, probably ~800 bp, but Toshi is not certain about that
        * Out of some 6000 genes, 283 have introns (nearly 5%)
            - `#NOTE` This could make the switch from Bowtie 2 to a splice-aware aligner such as STAR meaningful
- What does "\[a\]lignment stringency was set to minimum of 95% identity across at least 90% of the transcript sequence" as [described below](#from-file-s1)?
    + I think it will become clear as I read through the `PASA` documentation
- Could [this use of `Cuffmerge`](#from-supplementary-figure-1) address the [downstream work](../notebook.md#discussion-with-alison-on-what-i-should-prioritize) required for the transcriptome-assembly process?
    + More info on [`Cuffmerge` here](http://cole-trapnell-lab.github.io/cufflinks/cuffmerge/)
- `#IMPORTANT` Prior to running `Trinity`&mdash;among other things&mdash;we need to map the `.fastq` files to the combined reference (*S. cerevisiae*, *K. lactis*, and 20 S) and then filter out those that are assigned to *K. lactis* and 20 S
    + Then, we need to convert the `.bam` files back to `.fastq` files
    + `#QUESTION` But what about reads that are unmapped?
        * Option #1: ***Do include them*** with reads that mapped to *S. cerevisiae* in the *de novo* transcriptome assembly
        * Option #2: ***Do not include them*** with reads that mapped to *S. cerevisiae* in the *de novo* transcriptome assembly
    + And what about the parameters for calling `Bowtie2`? Here is how we're currently calling it:

### [The pipeline (in progress)](#the-pipeline-in-progress)
#### [In-progress steps of the pipeline](#in-progress-steps-of-the-pipeline)
0. Generate downsampled paired-end `.fastq` files for use in tests of preprocessing and *de novo* transcriptome assembly
1. Run some kind of quality check on the `.fastq` files, e.g., `FastqQC` or `fastp`, paying attention to
    - adapter content
    - k-mer content
    - other metrics? `#TODO`
2. Filter out adapters using, e.g., `Trimmomatic` or `Trim Galore`, which has been shown to outperform `Trimmomatic`  
3. Map the `.fastq` files to the combined reference (*S. cerevisiae*, *K. lactis*, and 20 S) with `Bowtie 2`
    - `Bowtie 2`
        + Retain unmapped reads in the resulting `.bam` files
            * (or write the unmapped reads to a separate `.bam` or `.fastq` file)
            * `#DONE` Get rid of `--no-unal`
        + I don't think we should worry about concordance with the initial alignments
            * Thus, perhaps we should get rid of the flags that control for concordance
            * ~~Actually, we can keep *some* of the flags because they'll be retained in one form or another~~
                - ~~If they're properly paired but not concordant, they'll be written to `"${infiles[0]%_R1.fastq}.unaligned"` via `--un-conc-gz`~~
                - If they're not properly paired, we won't be able to evaluate concordance, but they'll be retained in the sense that they'll be written to the `.bam` outfile because we're no longer calling `--no-unal`
                - `#DONE` Actually, go ahead and get rid of `--no-discordant` because we don't want them written to a `.fastq` file: we want them written to the `.bam` outfile with mapped coordinates (that we can later use for filtering)
                - `#DONE` Go ahead and get rid of `--no-overlap` too for the same reasons
                - `#DONE` Same with `--no-dovetail`
        + I don't think we should worry about unpaired alignments for paired reads just yet either; just keep and use them all, if possible
            * `#DONE` Get rid of `--no-mixed`
        + `#TODO` Get rid of `--trim5`; not sure why we bother with it in the first place
        + `#MAYBE` Get rid of `--al-conc-gz` because it writes the alignments to a `.fastq.gz`; actually, I think they're going into the `.bam` too... hold off on this
    - `STAR`
        + Map the `.fastq` files to the combined reference with `STAR`
        + Can use [these parameters](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c)
4. Filter `.bam` files to remove reads that are assigned to *K. lactis* and 20 S&mdash;and `#QUESTION` *S. cerevisiae* chrM as well? `#TODO`
    - `#ANSWER` Let's go with 'yes' 
5. Convert the `.bam` files back to `.fastq` files
    - `#TODO` Determine the handling of unmapped reads: If we decide we want to include them in the transcriptome assembly, then they need to be in the resulting `.fastq` files
6. Perform a quality check of the new `.fastq` files using the same program, paying special attention to the same metrics
7. `#OPTIONAL` Based on the results of the quality check, trim adapters and low quality bases from `.fastq` files
7. Remove erroneous k-mers with `rCorrector` `#TODO` Look into this
8. Discard read pairs in which at least one of the reads is "unfixable"
9. `#MAYBE` Map trimmed reads to a blacklist to remove unwanted (rRNA reads; OPTIONAL)  `#TODO Check with Alison on whether or not we would want to do this`
    + ["Reads mapped to blacklisted regions were removed (i.e., mitochondrial genome, ribosomal genes in chromosome 12, and subtelomeres)."](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8407396/) (do `cmd f` for *blacklist*)
    + If your RNA-seq libraries are built with a stranded protocol (see the link)  `#QUESTION What was I typing up and referring to here?`  `#TODO Come back to the best practices document`
    + Spoke with Toshi briefly about the existence of and use of blacklists in yeast NGS work; [details below](#brief-discussion-with-toshi-about-yeast-blacklists)
10. ...

##### [In-progress list of packages for the pipeline](#in-progress-list-of-packages-for-the-pipeline)
- Ongoing list packages for a `conda env` for doing the transcriptome-assembly work:
    + `Trinity`
        * [`conda`](https://anaconda.org/bioconda/trinity)
        * [`Repository`](https://github.com/trinityrnaseq/trinityrnaseq/)
        * [`Documentation`](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
    + `TrimGalore`
        * [`conda`](https://anaconda.org/bioconda/trim-galore)
        * [`Home`](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/)
        * [`Repository`](https://github.com/FelixKrueger/TrimGalore) 
        * [`Documentation`](https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md)
    + `rCorrector` Use to remove spurious k-mers
        * `#TODO` Follow up on this
    + `DETONATE` Would be used for validation
        * [`Vignette`](https://deweylab.biostat.wisc.edu/detonate/vignette.html)
    + `BUSCO` Would be used for validation
    + `FastQC` `#DECISION fastp or FastQC?`
    + `fastp` `#DECISION fastp or FastQC?` 
        * [`Repo and documentation`](https://github.com/OpenGene/fastp)
        * [`conda`](https://anaconda.org/bioconda/fastp)
    + `pasa` Would be used for mapping Trinity sequences to the reference
        * `#TODO` Follow up on this
    + `Transrate` `#MAYBE` Would be used for validation
        * [`Documentation`](http://hibberdlab.com/transrate/)
        * [`Repository`](https://github.com/blahah/transrate/)
        * [`conda`](https://anaconda.org/bioconda/transrate)
    + etc.
- Related resource: [Lessons on using Trinity from Brian Haas](https://bioinformaticsdotca.github.io/rnaseq_2018)

#### [References for the experimental design/pipeline](#references-for-the-experimental-design)
- [Best Practices for De Novo Transcriptome Assembly with Trinity](https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html)
- [McIlwain et al. (Hittinger), *G3* 2016](https://academic.oup.com/g3journal/article/6/6/1757/6029942) ([notes below](#mcilwain-et-al-hittinger-g3-2016))
- ...  
`#TODO For the in-progress steps below, describe what material is from what reference above`

### [Notes from the references listed above](#notes-from-the-references-listed-above)
#### McIlwain et al. (Hittinger), *G3* 2016
[Link to paper](https://academic.oup.com/g3journal/article/6/6/1757/6029942)

##### From *Materials and Methods*
...

We validated the predicted protein coding genes of Y22-3 using: 1) single-end RNA-Seq data collected from four growth phases of Y22-3 grown on YP media containing 60 g/L dextrose and 30 g/L xylose (YPDX, equivalent sugar concentrations that mimic ACSH made with 6% glucan loading), 2) <mark>an optimized (Figure S1) *de novo* transcriptome assembled by Trinity (Grabherr et al. 2011) using paired-end RNA-Seq data</mark> from clones derived from Y22-3 that were grown aerobically or anaerobically from four to six growth phases on YPDX and ACSH, and 3) proteomic data collected similarly to previous nanoflow liquid....

##### From [*File S1*](https://oup.silverchair-cdn.com/oup/backfile/Content_public/Journal/g3journal/6/6/10.1534_g3.116.029389/5/029389_files1.pdf?Expires=1670618915&Signature=4DEEu1wmL~iHD~Hpq-nTS9dJzWOHBV~jvWPaFFY-df6LV7nLBK45mN5h7MfOqxC5yDY8f8jpz9jcgsnBH6Q0a3NCotRUwvPcyQzo9VIX8fy4VSj7nibf9enwo-tyw5u4vQNtZXU4kjRgJZddXmvRE~73LEJdaFYQxBiRTNvskf5lCvmw64xLDeJPW8OGMVixRphDasc5zo~DNSQyNsbPxaZQCd4nNlNx2OMIc~RadavZBm-ZMPB81bPr4~oFeHEVr6WeLRtj0aJEVotV~PxzZYvAqleqMhLJUsuorvqVuz1sD4K~mJDcvweCBacBkAu5fgiBGAsdrTOoQ4RYmuKFNw__&Key-Pair-Id=APKAIE5G5CRDK6RD3PGA)
**<mark>*De novo*</mark> transcriptome assembly (transcriptome method):**  
¶1  
To describe transcriptional activity of Y22-3 over a wide range of conditions, nearly <mark>1.5 billion (1,433,309,474) paired-end Illumina RNA-Seq reads</mark> from the JGI dataset were <mark>assembled *de novo*</mark> to yield a generalized transcriptome model (Parreiras et al. 2014).

<mark>To remove both low-quality and nucleotide composition-biased parts of the sequencing reads, the Trimmomatic software (Bolger et al. 2014) was applied to pre-process the reads with the following rules: 1) remove the first 12 bp from 5’ end, 2) remove any number of bp from 3’ end that have the average quality score < 30 in a 3-bp sliding window, and 3) keep the trimmed read if 36 or more bp are left.</mark>

¶2  
Transcriptome assembly was performed using the Trinity pipeline (Grabherr et al. 2011). The <mark>pool of reads was normalized to a target coverage of 50 using Trinity’s *in silico* normalization routine</mark>.

Transcriptome assembly with default parameters produced numerous artificial fusion transcripts. To optimize the assembly parameters for our particular case, extensive <mark>parameter scanning and optimization</mark> were performed by generating 270 *de novo* assemblies that combined <mark>10 levels of minimal k-mer coverage<mark> (Inchworm stage of the Trinity), <mark>three levels of minimal glue</mark>, <mark>three levels of minimal iso ratio</mark>, and <mark>three levels of glue factor</mark> (Chrysalis stage). Optimization of the Butterfly-stage parameters was not recommended by the Trinity developers.

¶3  
<mark>Selection of the best assembly was performed with the aid of the [DETONATE](https://deweylab.biostat.wisc.edu/detonate/) [package](https://github.com/deweylab/detonate) [(Li et al. 2014)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0553-5), using both the RSEM-EVAL and REF-EVAL pipelines</mark>.

Our preliminary applications of DETONATE to smaller-size assemblies, combined with visual assessment of the assembly quality after subsequent mapping to the genome sequence, revealed that <mark>3 out of 47 output statistics generated by the DETONATE&mdash;**Transcript Length Distribution Related Factors (when maximized)**, **Unweighted K-mer KL_A_to_M (when minimized)**, and **Unweighted_Pair_F1 (when maximized)**&mdash;are better representatives of the overall assembly quality</mark> for our transcriptome. We <mark>selected the three candidate assemblies with top scores according to each of the three statistics</mark>. <mark>The final assembly was selected by [*minimizing the sum of ranks*](#outstanding-ongoing-questions)</mark>; this assembly belonged to the top 5% of assemblies for all three ranked lists.

<mark>The following advanced Trinity parameters were used to generate the optimized transcriptome assembly: **min_kmer_cov 32 (Inchworm stage), min_glue 4, min_iso_ratio 0.01, and glue_factor 0.01 (Chrysalis stage)**.</mark>

<mark>The transcripts from the optimized transcriptome assembly were mapped onto the Y22-3 genome sequence via **the [first stage](https://github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly) of the [PASA pipeline](https://github.com/PASApipeline/PASApipeline) [(Haas et al. 2003)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC206470/)** with blat and gmap aligners and the following options: `--MAX_INTRON_LENGTH 2000` and `--transcribed_is_aligned_orient`.</mark> Alignment stringency was set to minimum of 95% identity across at least 90% of the transcript sequence.

Visual comparison of the mapping results derived from the optimized and default-parameter assemblies [(Figure S1)](https://oup.silverchair-cdn.com/oup/backfile/Content_public/Journal/g3journal/6/6/10.1534_g3.116.029389/5/029389_figures1.pdf?Expires=1670618835&Signature=EYS-mn5bLPlI~Wa3u7B8J8J-2Vm1yZ08An4f35VKyef4qyT~T1LaBSdQkKJtKbYfggQciXpi30thpgSUXdx~S3I9MHUyUBpZFr-JGC4YdMg1c-IdMqWBbczfmPdinQx9pFMrlqty9lHf1oxA5Jmc4vbAdJVoJU3AHt4kIRChviV8PyelyFsFQkIYNRIpLclSVODM180ebZ~jiIMquHHdA3fbS4z~p7lLqMCAmCdnMmp6-dJbpCt9JSz10BSztduUZSjfbOoF9sKMxhTuH2rUHEHH-ONMu3NeRg0YJcR~rcJV4Pnkaw3QY4Xx~-L3G--IzRoGTkLfkNqd7WYIUHZPJA__&Key-Pair-Id=APKAIE5G5CRDK6RD3PGA) revealed that cases of artificial both-strand coverage by predicted transcripts, which were abundant in the default assembly, were essentially eliminated in the optimized assembly, without sacrificing sensitivity (seen as coverage of the genomic features predicted at DNA level).

...

#### Blevins et al. (Mar Albà), bioRxiv 2019-0313
[Link to paper](https://www.biorxiv.org/content/10.1101/575837v1.full); this is the study Alison referenced for the parameters [used here](#get-another-trial-run-of-trinity-going)

##### From *Results*
**Assembling novel transcripts from 11 yeast species**

¶1  
We selected 10 species from the Saccharomycotina subphylum, including the model organism *S. cerevisiae*, as well as a more distant outgroup species (*Schizosaccharomyces pombe*), due to their evolutionary history as well as their inclusion in other relevant studies (Figure 1, Supplementary Table 1). All 11 species of yeast were grown in rich media, henceforth referred to as ‘normal’ conditions, as well as in oxidative stress conditions induced by adding hydrogen peroxide ... to the rich media, henceforth referred to as 'stress.'

¶2  
We performed high throughput RNA sequencing (RNA-Seq) in normal and stress conditions for the 11 species, and <mark>[assembled *de novo* transcriptomes using Trinity (Grabherr et al. 2013)](#from-methods)</mark>. We combined the set of *de novo* assembled transcripts with the reference annotations to generate an inclusive and non-redundant set of transcripts for each species (Supplementary Figure 1). Our de novo assemblies contained an average of 770 novel (unannotated) transcripts for each species studied (Supplementary Table 2).

##### From *Supplementary Figure 1*
**Flow chart of our RNAseq analysis pipeline.**

We began our analysis with raw RNA-Seq sequencing fastq files for each of the species both conditions.

Adapters and low-quality reads were removed with `Trimmomatic`, then `FastQC` was used to do a subsequent quality assessment.

The high-quality reads were then mapped to the reference genome with `Bowtie2`.

`Trinity` was run in reference-free mode, so the assembled transcripts it produces are lacking genomic coordinates.

For this reason, we used `GMAP` to map where the assembled transcripts belong on the reference genome.

<mark>We then [used `Cuffmerge` to compare and combine the reference annotations with our *de novo* assembly](#outstanding-ongoing-questions).</mark>

Nucleotide sequences were extracted for each transcript using the tool `gffread` from the `Cufflinks` suite, and BLAST databases were created for each species using the complete transcriptome (novel transcripts & annotated
transcripts).

Each transcript was used as a query in `BLAST` searches against all `BLAST` databases (the transcriptomes of all 11 species) as well as the proteomes of 35 distant non-Ascomycota species.

`Salmon` was used to quantify the expression of each transcript in both conditions.

##### From *Methods*
**Processing of RNA-Seq data**  
We trimmed the adapters and low quality bases with Trimmomatic (Bolger et al. 2014) with the following parameters:
```txt
ILLUMINACLIP:$illumina_adapters:2:33:20:2:true \
LEADING:36 \
TRAILING:32 \
SLIDINGWINDOW:4:30 \
MINLEN:35
```
We then used Bowtie2 version 2.2.3 with default parameters (Langmead and Salzberg 2012) to map the trimmed RNA-Seq reads to the reference genome. After mapping the reads, we discarded all reads with > 2 mismatches as well as unpaired reads.

**Assembly of transcriptomes**  
¶1  
We used Trinity in genome-guided BAM mode (Grabherr et al. 2013) to perform a *de novo* assembly using the following parameters:

¶2  
```txt
--normalize_max_read_cov 200 \
--jaccard_clip \
--genome_guided_max_intron 1002 \
--min_kmer_cov 2 \
--max_reads_per_graph 300000 \
--min_glue 5 \
--group_pairs_distance 300 \
--min_contig_length 200
```

¶3  
In this mode, `Trinity` works with mapped reads, but it does not use the reference genome directly to reconstruct the transcripts.

We used `Transrate` (Smith-Unna et al. 2016) to evaluate the quality of each assembly and refined the parameters of Trinity to achieve a high-quality de novo assembly.

As `Trinity` does not use the reference genome directly to assemble transfrags, we used GMAP (Wu and Watanabe 2005) to map the assembled transcripts back to the reference genome. We used Cuffmerge from the Cufflinks suite version 2.2.0 (Trapnell et al. 2012) to combine the de novo assemblies from normal and stress conditions with the reference transcriptome. When we combined novel and annotated transcripts into a comprehensive transcriptome, novel transcripts from our assembly which overlapped the reference annotations were considered redundant and were excluded from most of the analysis; however, these transcripts were still included in the BLAST database during homology searches.
<br />
<br />

## [Sussing out the alignment work for the pipeline](#sussing-out-the-alignment-work-for-the-pipeline)
### [On calling `Bowtie 2`](#on-calling-bowtie-2)
Section ties into the section immediately [above](#outstanding-ongoing-questions-points-etc) and [below](#in-progress-steps-of-the-pipeline)
```bash
bowtie2 \
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
        | samtools sort -@ "${threads}" -o "${infiles[0]%_R1.fastq}_sorted.bam" -
```

#### [Meaning of `Bowtie 2` parameters](#meaning-of-bowtie-2-parameters)
```txt
-p: threads
-x: Bowtie2 indices, including path and root
-1: Read #1 of paired-end reads
-2: Read #2 of paired-end reads
--trim5: trim <int> bases from 5'/left end of reads
--local: local alignment; ends might be soft clipped (off)
--very-sensitive-local: -D 20 -R 3 -N 0 -L 20 -i S,1,0.50
    -D: give up extending after <int> failed extends in a row (15)
    -R: for reads w/ repetitive seeds, try <int> sets of seeds (2)
    -N: max # mismatches in seed alignment; can be 0 or 1 (0)
    -L: length of seed substrings; must be >3, <32 (22)
    -i: interval between seed substrings w/r/t read len (S,1,1.15)
--no-unal: suppress SAM records for unaligned reads
--no-mixed: suppress unpaired alignments for paired reads
--no-discordant: suppress discordant alignments for paired reads
    From biostars.org/p/78446/, a discordant alignment is an alignment where
    both mates align uniquely, but that does not satisfy the paired-end
    constraints (--fr/--rf/--ff, -I, -X).
--phred33: qualities are Phred+33 (default)
-I: minimum fragment length (0)
-X: maximum fragment length (500)
--no-overlap: not concordant when mates overlap at all
--no-dovetail: NA

Based on the description for --dovetail, "concordant when mates extend past
each other", I presume --no-dovetail means "not concordant when mates extend
past each other"

#QUESTION Why do we do '--trim5 1'?
    #QUESTION What is the length of our reads? Is it something to do with that?
```

When calling `Bowtie2` for [**Step 3** below](#in-progress-steps-of-the-pipeline)), we'll want to ~~remove the pipe to `samtools` and~~ take advantage of these flags for directing the alignments, or lack thereof, to specific files
```txt
  --un <path>        write unpaired reads that didn't align to <path>
  --al <path>        write unpaired reads that aligned at least once to <path>
  --un-conc <path>   write pairs that didn't align concordantly to <path>
  --al-conc <path>   write pairs that aligned concordantly at least once to <path>
    (Note: for --un, --al, --un-conc, or --al-conc, add '-gz' to the option name, e.g.
    --un-gz <path>, to gzip compress output, or add '-bz2' to bzip2 compress output.)
```

#### [How we should call `Bowtie 2`](#how-we-should-call-bowtie-2)
Thus, we'll want to call `Bowtie 2` like this (also incorporates thoughts from sub-bullets for [**Step 3** below](#in-progress-steps-of-the-pipeline)):
```bash
bowtie2 \
    -p "${threads}" \
    -x "${reference_genome}" \
    -1 "${infiles[0]}" \
    -2 "${infiles[1]}" \
    --local \
    --very-sensitive-local \
    --phred33 \
    -I 10 \
    -X 700 \
    --un-conc-gz "${infiles[0]%_R1.fastq}.unaligned" \
    --al-conc-gz "${infiles[0]%_R1.fastq}.aligned"
        | samtools sort -@ "${threads}" -o "${infiles[0]%_R1.fastq}_sorted.bam" -

#  Bowtie2 will append .1.fastq.gz and .2.fastq.gz to
#+ "${infiles[0]%_R1.fastq}.unaligned"
````

### [On calling `STAR`](#on-calling-star)
- Section ties into the section immediately [above](#outstanding-ongoing-questions-points-etc) and [below](#in-progress-steps-of-the-pipeline)
- Performing `STAR` "genome generation" (i.e., creating an indexed genome file with annotations) is based on the parameters described [here (example call)](https://groups.google.com/g/rna-star/c/TPTdAL7NNZ4), [here (on `--genomeSAindexNbases`)](https://groups.google.com/g/rna-star/c/08UtIdEFFmY/m/gU1eif_1KdwJ), and [here (on `--sjdbGTFfeatureExon CDS`)](https://groups.google.com/g/rna-star/c/IOJuxxONrKs/m/a0jV0kkCAQAJ)
- Performing `STAR` alignment with *S. cerevisiae* data is based on the parameters described [here](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c)
- An [important consideration](https://groups.google.com/g/rna-star/c/08UtIdEFFmY/m/gU1eif_1KdwJ) for building the yeast genome index with `STAR`

#### [Building a `STAR` genome index](#building-a-star-genome-index)
```bash
#DONTRUN

STAR \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --runMode genomeGenerate \
    --genomeDir "${genomeDir}" \
    --genomeFastaFiles "${genomeFastaFiles}" \
    --sjdbGTFfile "${sjdbGTFfile}" \
    --sjdbOverhang ${sjdbOverhang} \
    --sjdbGTFtagExonParentTranscript Parent \
    --genomeSAindexNbases "${genomeSAindexNbases}"

#  'exon' not found in gff3 for yeast, but 'CDS' is, so use that for
#+ --sjdbGTFfeatureExon

#  Wait, this is not true--see plenty of examples of 'exon' in the .gff3.gz
#+ files; thus, remove --sjdbGTFfeatureExon CDS from the call
```

#### [Meaning of `STAR` parameters for `genomeGenerate`](#meaning-of-star-parameters-for-genomegenerate)
Meaning of the parameters for `STAR --runMode genomeGenerate`:
```txt
                    --runThreadN  number of threads to be used for genome generation
                     --genomeDir  path to the directory where the genome indices are stored;
                                  must be mkdir'd already
              --genomeFastaFiles  one or more FASTA files with the genome reference sequences
                   --sjdbGTFfile  path to the file with annotated transcripts in the standard
                                  .gtf format; STAR can be run without annotations, but using
                                  annotations is highly recommended whenever they are
                                  available; the annotations can also be included on the fly
                                  at the mapping step (that is, instead of including them
                                  now, they can be included in the mapping step); for .gff3
                                  formatted annotations, use
                                  '--sjdbGTFtagExonParentTranscript Parent'
                  --sjdbOverhang  length of genomic sequence around the annotated junction to
                                  be used in constructing the splice junctions database; this
                                  length should be equal to the ReadLength-1, where
                                  ReadLength is the length of the reads; in case of reads of
                                  varying length, the value should be max(ReadLength)-1
            --sjdbGTFfeatureExon  (see below)
--sjdbGTFtagExonParentTranscript  use when a .gff3 formatted annotation is supplied to 
                                  --sjdbGTFfile; in general, for --sjdbGTFfile files STAR
                                  only processes lines that have --sjdbGTFfeatureExon (=exon
                                  by default) in the 3rd field (column); exons are assigned
                                  to the transcripts using parent-child relationship defined
                                  by the --sjdbGTFtagExonParentTranscript (=transcript id by
                                  default) .gtf/.gff attribute
           --genomeSAindexNbases  for small genomes, the parameter --genomeSAindexNbases must
                                  be scaled down, with a typical value of
                                  min(14, log2(GenomeLength)/2 - 1); for example, for a 1 Mb
                                  genome, this is equal to 9; for a 100 kb genome, this is
                                  equal to 7; for yeast, this is ~12
```

#### [How we should call `STAR`](#how-we-should-call-star)
```bash
#DONTRUN

STAR \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMunmapped Within \
    --genomeDir "${genomeDir}" \
    --readFilesIn "${infiles[0]}" "${infiles[1]}" \
    --outFileNamePrefix "${infiles[0]%_R1.fastq}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000 \
    --outSAMtype BAM SortedByCoordinate

#  Don't need...
#+     - '--readFilesCommand zcat' b/c .fastq files are unzipped 
#+     - '--quantMode TranscriptomeSAM \' b/c only care about what does and
#+       does not align
#+     - '--outTmpDir' b/c we can just use the default settings
#+     - '--outSAMattributes' b/c the default is fine

#  Changes...
#+     - Change '--alignIntronMin' from '0' to '4' per this note from Dobin:
#+       "I would use at least 4 for --alignIntronMin , I do not think the very
#+       small introns in the annotations are real"
#+         - https://groups.google.com/g/rna-star/c/hQeHTBbkc0c?pli=1
#+         - https://groups.google.com/d/msg/rna-star/LqxVCE34464/GBordrd6AQAJ
#+     - More from Dobin: "I would increase --alignMatesGapMax to at least
#+       --alignIntronMin since the gap between mates may contain a splice
#+       junction."
#+         - Marco increased --alignMatesGapMax from '2000' to '5000'

#  Miscellaneous notes
#+     - If we used default settings for --alignIntronMax, the value would be
#+       589824 (see 'Meaning of parameters...' below); leave as is (set by
#+       Marco)
#+     - Can maybe leave '--outSAMattrIHstart 0' as is; default is '1'? '1' is
#+       needed for use with some downstream applications, including StringTie
#+       and Cufflinks; however, that doesn't matter for my situation, so just
#+       delete it and go with defaults for now
```

#### [Meaning of `STAR` parameters for `alignReads`](#meaning-of-star-parameters-for-alignreads)
```txt
           --runThreadN  number of threads to run STAR
                         < format: int>0 >
       --outSAMunmapped  output of unmapped reads in the SAM format
                             1st word:
                                 None   ... no output
                                 Within ... output unmapped reads within the main SAM file
                                            (i.e., Aligned.out.sam)
                             2nd word:
                                 KeepPairs ... record unmapped mate for each alignment, and,
                                               in case of unsorted output, keep it adjacent
                                               to its mapped mate; only affects multi-mapping
                                               reads
                         < string(s) >
            --genomeDir  path to the directory where genome files are stored (for --runMode
                         alignReads) or will be generated (for --runMode generateGenome)
                         < format: ./GenomeDir/ >
          --readFilesIn  paths to files that contain input read1 (and, if needed, read2)
                         < format: string(s); format: Read1 Read2 >
    --outFileNamePrefix  output files name prefix (including full or relative path)
                         < format: string; format: ./ >
     --readFilesCommand  command line to execute for each of the input file; this command
                         should generate FASTA or FASTQ text and send it to stdout; for
                         example, 'zcat' to uncompress .gz files, 'bzcat' to uncompress .bz2
                         files, etc.
                         < string(s) >
            --quantMode  types of quantification requested
                             -                ... none
                             TranscriptomeSAM ... output SAM/BAM alignments to transcriptome
                                                  into a separate file
                             GeneCounts       ... count reads per gene
                         < string(s) >
      --limitBAMsortRAM  maximum available RAM (bytes) for sorting BAM; if =0, it will be set
                         to the genome index size; 0 value can only be used with --genomeLoad
                         NoSharedMemory option < int>=0 >
        --outFilterType  type of filtering
                             Normal  ... standard filtering using only current alignment
                             BySJout ... keep only those reads that contain junctions that
                                         passed filtering into SJ.out.tab
                         < format: string; default: Normal >
--outFilterMultimapNmax  maximum number of loci the read is allowed to map to; alignments
                         (all of them) will be output only if the read maps to no more loci
                         than this value; otherwise no alignments will be output, and the
                         read will be counted as "mapped to too many loci" in the
                         Log.final.out
                         < format: int; default: 10 >
   --alignSJoverhangMin  minimum overhang (i.e. block size) for spliced alignments
                         < format: int>0; default: 5 >
 --alignSJDBoverhangMin  minimum overhang (i.e. block size) for annotated (sjdb) spliced
                         alignments
                         < format: int>0; default: 3 >
--outFilterMismatchNmax  alignment will be output only if it has no more mismatches than this
                         value
                         < format: int; default: 10 >
       --alignIntronMin  minimum intron size: genomic gap is considered intron if its
                         length>=alignIntronMin, otherwise it is considered Deletion
                         < default: 21 >
       --alignIntronMax  maximum intron size, if 0, max intron size will be determined by
                         (2^winBinNbits)*winAnchorDistNbins < default: 0 >
          --winBinNbits  =log2(winBin), where winBin is the size of the bin for the
                         windows/clustering, each window will occupy an integer number of
                         bins
                         < int>0; default: 16 >
   --winAnchorDistNbins  max number of bins between two anchors that allows aggregation of
                         anchors into one window
                         < int>0; default: 9 >
     --alignMatesGapMax  maximum gap between two mates, if 0, max intron gap will be
                         determined by (2^winBinNbits)*winAnchorDistNbins < default: 0 >
            --outTmpDir  path to a directory that will be used as temporary by STAR; all
                         contents of this directory will be removed; the temp directory will
                         default to outFileNamePrefix_STARtmp
                         < format: string >
    --outSAMattrIHstart  start value for the IH attribute; 0 may be required by some
                         downstream software, such as Cufflinks or StringTie
                         < int>=0; default: 1 >
     --outSAMattributes  a string of desired SAM attributes, in the order desired for the
                         output SAM; tags can be listed in any combination/order
                         < format: string; default: Standard >
           --outSAMtype  type of SAM/BAM output
                             1st word:
                                 BAM  ... output BAM without sorting
                                 SAM  ... output SAM without sorting
                                 None ... no SAM/BAM output
                             2nd, 3rd:
                                 Unsorted           ... standard unsorted
                                 SortedByCoordinate ... sorted by coordinate; this option
                                                        will allocate extra memory for
                                                        sorting which can be specified by
                                                        --limitBAMsortRAM
                         < format: strings; default: SAM >
```

### [Implementing the alignment steps with `STAR` and `Bowtie 2`](#implementing-the-alignment-steps-with-star-and-bowtie-2)
#### [Generating files needed for `STAR` alignment (2022-1107)](#generating-files-needed-for-star-alignment-2022-1107)
...to the combined reference genes (*S. cerevisiae*, *K. lactis*, and S20)

##### [Preparing the `.fasta` and `.gff3` files for `STAR`](#preparing-the-fasta-and-gff3-files-for-star)
```bash
#DONTRUN

#  grabnode can be "on" or "off"


#  Download .gff3 files for sacCer3 (Ensembl 108) -----------------------------
cd ~/genomes/sacCer3/Ensembl/108
mkdir -p gff3 && cd gff3/

URL="https://ftp.ensembl.org/pub/release-108/gff3/saccharomyces_cerevisiae"

curl \
    "${URL}/CHECKSUMS" \
    > "CHECKSUMS"

curl \
    "${URL}/README" \
    > "README"

curl \
    "${URL}/Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gff3.gz" \
    > "Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gff3.gz"

curl \
    "${URL}/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz" \
    > "Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz"

#NOTE No "abinitio" gene predictions for K. lactis 


#  Are chromosome names consistent between sacCer3 .gff3 and .fasta? ----------
#  Check the file contents: How are chromosomes named?
zcat Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz | head -23
# ##gff-version 3
# ##sequence-region   I 1 230218
# ##sequence-region   II 1 813184
# ##sequence-region   III 1 316620
# ##sequence-region   IV 1 1531933
# ##sequence-region   IX 1 439888
# ##sequence-region   Mito 1 85779
# ##sequence-region   V 1 576874
# ##sequence-region   VI 1 270161
# ##sequence-region   VII 1 1090940
# ##sequence-region   VIII 1 562643
# ##sequence-region   X 1 745751
# ##sequence-region   XI 1 666816
# ##sequence-region   XII 1 1078177
# ##sequence-region   XIII 1 924431
# ##sequence-region   XIV 1 784333
# ##sequence-region   XV 1 1091291
# ##sequence-region   XVI 1 948066
# #!genome-build  R64-1-1
# #!genome-version R64-1-1
# #!genome-date 2011-09
# #!genome-build-accession GCA_000146045.2
# #!genebuild-last-updated 2018-10

#QUESTION Need to rename "Mito"? #ANSWER No (see immediately below)

cd ~/genomes/sacCer3/Ensembl/108/DNA

grep "^>" Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito


#  Check on consistency of chromosome names in K. lactis ----------------------
#+ ...looking at .fasta and .gff3.gz
cd ~/genomes/kluyveromyces_lactis_gca_000002515/Ensembl/55

zcat ./gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz \
    | head -11
# ##gff-version 3
# ##sequence-region   A 1 1062590
# ##sequence-region   B 1 1320834
# ##sequence-region   C 1 1753957
# ##sequence-region   D 1 1715506
# ##sequence-region   E 1 2234072
# ##sequence-region   F 1 2602197
# #!genome-build Genolevures Consortium ASM251v1
# #!genome-version ASM251v1
# #!genome-build-accession GCA_000002515.1
# #!genebuild-last-updated 2015-02

grep \
    "^>" \
    ./DNA/Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.chr-rename.fasta
# >A
# >B
# >C
# >D
# >E
# >F

#NOTE #IMPORTANT For both genomes, chromosome names are consistent


#  Merge the two .gff3 files --------------------------------------------------
grabnode  # Lowest and/or default settings

cd ~/genomes/

#  Use AGAT (Another Gff Analysis Toolkit):
#+ biostars.org/p/413510/
ml AGAT/0.9.2-GCC-11.2.0  # Nice, a module is available

#  This seems like the script to use: agat_sp_merge_annotations.pl
agat_sp_merge_annotations.pl
#
#  ------------------------------------------------------------------------------
# |   Another GFF Analysis Toolkit (AGAT) - Version: v0.9.1                      |
# |   https://github.com/NBISweden/AGAT                                          |
# |   National Bioinformatics Infrastructure Sweden (NBIS) - www.nbis.se         |
#  ------------------------------------------------------------------------------
#
# At least 2 files are mandatory:
#  --gff file1 --gff file2
#
#
# Usage:
#         agat_sp_merge_annotations.pl --gff infile1 --gff infile2 --out outFile
#         agat_sp_merge_annotations.pl --help

agat_sp_merge_annotations.pl --help
#
#  ------------------------------------------------------------------------------
# |   Another GFF Analysis Toolkit (AGAT) - Version: v0.9.1                      |
# |   https://github.com/NBISweden/AGAT                                          |
# |   National Bioinformatics Infrastructure Sweden (NBIS) - www.nbis.se         |
#  ------------------------------------------------------------------------------
#
#
# Name:
#     agat_sp_merge_annotations.pl
#
# Description:
#     This script merge different gff annotation files in one. It uses the
#     Omniscient parser that takes care of duplicated names and fixes other
#     oddities met in those files.
#
# Usage:
#         agat_sp_merge_annotations.pl --gff infile1 --gff infile2 --out outFile
#         agat_sp_merge_annotations.pl --help
#
# Options:
#     --gff or -f
#             Input GTF/GFF file(s). You can specify as much file you want
#             like so: -f file1 -f file2 -f file3
#
#     --out, --output or -o
#             Output gff3 file where the gene incriminated will be write.
#
#     --help or -h
#             Display this helpful text.
#
# Feedback:
#   Did you find a bug?:
#     Do not hesitate to report bugs to help us keep track of the bugs and
#     their resolution. Please use the GitHub issue tracking system available
#     at this address:
#
#                 https://github.com/NBISweden/AGAT/issues
#
#      Ensure that the bug was not already reported by searching under Issues.
#      If you're unable to find an (open) issue addressing the problem, open a new one.
#      Try as much as possible to include in the issue when relevant:
#      - a clear description,
#      - as much relevant information as possible,
#      - the command used,
#      - a data sample,
#      - an explanation of the expected behaviour that is not occurring.
#
#   Do you want to contribute?:
#     You are very welcome, visit this address for the Contributing
#     guidelines:
#     https://github.com/NBISweden/AGAT/blob/master/CONTRIBUTING.md

infile_1="./sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz"
infile_2="./kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz"
outfile="./combined_SC_KL_20S/g/combined_SC_KL"

mkdir -p "$(dirname "${outfile}")"

agat_sp_merge_annotations.pl \
    -f "${infile_1}" \
    -f "${infile_2}" \
    -o "${outfile}"
#  See STDERR printed to screen below

#  Give a proper name to the outdirectory within "${outfile}"
mv "$(dirname "${outfile}")" "./combined_SC_KL_20S/gff3"
# For some reason, the sequence 'gff3' is stripped away from strings by AGAT

#  Rename and compress outfile
outfile="./combined_SC_KL_20S/gff3/combined_SC_KL"

mv "${outfile}.gff" "${outfile}.gff3"
gzip "${outfile}.gff3"

ls -1 ./combined_SC_KL_20S/gff3  # Check
# combined_SC_KL.gff3.gz


#  Are chromosome names consistent for combined_SC_KL_20S? --------------------
grep "^>" ./combined_SC_KL_20S/fasta/combined_SC_KL_20S.fasta
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito
# >A
# >B
# >C
# >D
# >E
# >F
# >20S

zcat ./combined_SC_KL_20S/gff3/combined_SC_KL.gff3.gz \
    | head -33
# ##gff-version 3
# ##sequence-region   I 1 230218
# ##sequence-region   II 1 813184
# ##sequence-region   III 1 316620
# ##sequence-region   IV 1 1531933
# ##sequence-region   IX 1 439888
# ##sequence-region   Mito 1 85779
# ##sequence-region   V 1 576874
# ##sequence-region   VI 1 270161
# ##sequence-region   VII 1 1090940
# ##sequence-region   VIII 1 562643
# ##sequence-region   X 1 745751
# ##sequence-region   XI 1 666816
# ##sequence-region   XII 1 1078177
# ##sequence-region   XIII 1 924431
# ##sequence-region   XIV 1 784333
# ##sequence-region   XV 1 1091291
# ##sequence-region   XVI 1 948066
# #!genome-build  R64-1-1
# #!genome-version R64-1-1
# #!genome-date 2011-09
# #!genome-build-accession GCA_000146045.2
# #!genebuild-last-updated 2018-10
# ##sequence-region   A 1 1062590
# ##sequence-region   B 1 1320834
# ##sequence-region   C 1 1753957
# ##sequence-region   D 1 1715506
# ##sequence-region   E 1 2234072
# ##sequence-region   F 1 2602197
# #!genome-build Genolevures Consortium ASM251v1
# #!genome-version ASM251v1
# #!genome-build-accession GCA_000002515.1
# #!genebuild-last-updated 2015-02

#NOTE #IMPORTANT Chromosome names are consistent
```

Call to [AGAT](https://www.biostars.org/p/413510/) `agat_sp_merge_annotations.pl` printed the following to screen (`STDERR`):
```txt
********************************************************************************
*                              - Start parsing -                               *
********************************************************************************
-------------------------- parse options and metadata --------------------------
=> Accessing the feature level json files
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level1.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level2.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level3.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_spread.json file
=> Attribute used to group features when no Parent/ID relationship exists (i.e common tag):
    * locus_tag
    * gene_id
=> merge_loci option deactivated
=> Machine information:
    This script is being run by perl v5.34.0
    Bioperl location being used: /app/software/BioPerl/1.7.8-GCCcore-11.2.0/lib/perl5/site_perl/5.34.0/Bio/
    Operating system being used: linux
=> Accessing Ontology
    No ontology accessible from the gff file header!
    We use the SOFA ontology distributed with AGAT:
        /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo
    Read ontology /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo:
        4 root terms, and 2596 total terms, and 1516 leaf terms
    Filtering ontology:
        We found 1861 terms that are sequence_feature or is_a child of it.
--------------------------------- parsing file ---------------------------------
=> Number of line in file: 35862
=> Number of comment lines: 7167
=> Fasta included: No
=> Number of features lines: 28695
=> Number of feature type (3rd column): 16
    * Level1: 6 => transposable_element_gene ncRNA_gene chromosome gene pseudogene transposable_element
    * level2: 7 => snRNA ncRNA pseudogenic_transcript tRNA mRNA rRNA snoRNA
    * level3: 3 => exon five_prime_UTR CDS
    * unknown: 0 =>
=> Version of the Bioperl GFF parser selected by AGAT: 3
Parsing: 100% [======================================================]D 0h00m03s
********************************************************************************
*                               - End parsing -                                *
*                              done in 5 seconds                               *
********************************************************************************

********************************************************************************
*                               - Start checks -                               *
********************************************************************************
---------------------------- Check1: feature types -----------------------------
----------------------------------- ontology -----------------------------------
All feature types in agreement with the Ontology.
------------------------------------- agat -------------------------------------
AGAT can deal with all the encountered feature types (3rd column)
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check2: duplicates ------------------------------
None found
------------------------------ done in 0 seconds -------------------------------

-------------------------- Check3: sequential bucket ---------------------------
None found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check4: l2 linked to l3 ----------------------------
91 cases fixed where L3 features have parent feature(s) missing
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check5: l1 linked to l2 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check6: remove orphan l1 ---------------------------
We remove only those not supposed to be orphan
91 cases removed where L1 features do not have children (while they are suposed to have children).
------------------------------ done in 0 seconds -------------------------------

------------------------- Check7: all level3 locations -------------------------
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check8: check cds -------------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check9: check exons ------------------------------
No exons created
No exons locations modified
No supernumerary exons removed
No level2 locations modified
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check10: check utrs ------------------------------
No UTRs created
No UTRs locations modified
No supernumerary UTRs removed
------------------------------ done in 1 seconds -------------------------------

------------------------ Check11: all level2 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

------------------------ Check12: all level1 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

---------------------- Check13: remove identical isoforms ----------------------
None found
------------------------------ done in 0 seconds -------------------------------
********************************************************************************
*                                - End checks -                                *
*                              done in 1 seconds                               *
********************************************************************************

=> OmniscientI total time: 6 seconds
./sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz GFF3 file parsed
There is 7507 exon
There is 91 rna
There is 0 transposable_element_gene
There is 424 ncrna_gene
There is 6913 cds
There is 4 five_prime_utr
There is 12 pseudogenic_transcript
There is 17 chromosome
There is 6600 gene
There is 77 snorna
There is 18 ncrna
There is 24 rrna
There is 6600 mrna
There is 91 transposable_element
There is 12 pseudogene
There is 6 snrna
There is 299 trna
********************************************************************************
*                              - Start parsing -                               *
********************************************************************************
-------------------------- parse options and metadata --------------------------
=> Accessing the feature level json files
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level1.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level2.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level3.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_spread.json file
=> Attribute used to group features when no Parent/ID relationship exists (i.e common tag):
    * locus_tag
    * gene_id
=> merge_loci option deactivated
=> Machine information:
    This script is being run by perl v5.34.0
    Bioperl location being used: /app/software/BioPerl/1.7.8-GCCcore-11.2.0/lib/perl5/site_perl/5.34.0/Bio/
    Operating system being used: linux
=> Accessing Ontology
    No ontology accessible from the gff file header!
    We use the SOFA ontology distributed with AGAT:
        /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo
    Read ontology /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo:
        4 root terms, and 2596 total terms, and 1516 leaf terms
    Filtering ontology:
        We found 1861 terms that are sequence_feature or is_a child of it.
--------------------------------- parsing file ---------------------------------
=> Number of line in file: 27298
=> Number of comment lines: 5461
=> Fasta included: No
=> Number of features lines: 21837
=> Number of feature type (3rd column): 12
    * Level1: 4 => chromosome biological_region gene ncRNA_gene
    * level2: 6 => snRNA ncRNA tRNA rRNA mRNA lnc_RNA
    * level3: 2 => exon CDS
    * unknown: 0 =>
=> Version of the Bioperl GFF parser selected by AGAT: 3
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   9115    9552    .   +   .   external_name "KLLA0_A00165t; CR382121.1:mobile_element:9115..9552"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   341014  344221  .   -   .   external_name "KLLA0_A03844t; DNA transposon of KLLA part of the newly discovered ROVER DNA transposon family of the Kluyveromyces: degenerate copy with probably 2 frameshifts"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   584843  585278  .   +   .   external_name "KLLA0_A06457t; CR382121.1:mobile_element:584843..585278"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_misc_feature    biological_region   760404  760598  .   +   .   external_name "KLLA0_A08668s; Centromere Klla0A"  ; logic_name ena_misc_feature
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   1046924 1047346 .   -   .   external_name "KLLA0_A12023t; CR382121.1:mobile_element:complement(1046924..1047346)"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   1047531 1048025 .   -   .   external_name "KLLA0_A12034t; CR382121.1:mobile_element:complement(1047531..1048025)"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   1054728 1060266 .   -   .   external_name "KLLA0_A12134t; CR382121.1:mobile_element:complement(1054728..1060266)"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: B    ena_mobile_element  biological_region   21083   21192   .   +   .   external_name "KLLA0_B00330t; CR382122.1:mobile_element:21083..21192"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: B    ena_misc_feature    biological_region   1168861 1169058 .   +   .   external_name "KLLA0_B13299s; Centromere Klla0B"  ; logic_name ena_misc_feature
gff3 reader error level1: No ID attribute found @ for the feature: C    ena_misc_feature    biological_region   1638151 1638347 .   +   .   external_name "KLLA0_C18529s; Centromere Klla0C"  ; logic_name ena_misc_feature
gff3 reader error level1: No ID attribute found  ************** Too much WARNING message we skip the next **************
Parsing: 100% [======================================================]D 0h00m02s
33 warning messages: gff3 reader error level1: No ID attribute found
********************************************************************************
*                               - End parsing -                                *
*                              done in 3 seconds                               *
********************************************************************************

********************************************************************************
*                               - Start checks -                               *
********************************************************************************
---------------------------- Check1: feature types -----------------------------
----------------------------------- ontology -----------------------------------
INFO - Feature types not expected by the GFF3 specification:
* lnc_rna
The feature type (3rd column in GFF3) is constrained to be either a term from th
e Sequence Ontology or an SO accession number. The latter alternative is disting
uished using the syntax SO:000000. In either case, it must be sequence_feature (
SO:0000110) or an is_a child of it.To follow rigorously the gff3 format, please
visit this website:
https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md
------------------------------------- agat -------------------------------------
AGAT can deal with all the encountered feature types (3rd column)
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check2: duplicates ------------------------------
None found
------------------------------ done in 0 seconds -------------------------------

-------------------------- Check3: sequential bucket ---------------------------
None found
------------------------------ done in 1 seconds -------------------------------

--------------------------- Check4: l2 linked to l3 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check5: l1 linked to l2 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check6: remove orphan l1 ---------------------------
We remove only those not supposed to be orphan
None found
------------------------------ done in 0 seconds -------------------------------

------------------------- Check7: all level3 locations -------------------------
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check8: check cds -------------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check9: check exons ------------------------------
No exons created
No exons locations modified
No supernumerary exons removed
No level2 locations modified
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check10: check utrs ------------------------------
No UTRs created
No UTRs locations modified
No supernumerary UTRs removed
------------------------------ done in 0 seconds -------------------------------

------------------------ Check11: all level2 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

------------------------ Check12: all level1 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

---------------------- Check13: remove identical isoforms ----------------------
None found
------------------------------ done in 0 seconds -------------------------------
********************************************************************************
*                                - End checks -                                *
*                              done in 1 seconds                               *
********************************************************************************

=> OmniscientI total time: 4 seconds
./kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz GFF3 file parsed
There is 6 chromosome
There is 5076 gene
There is 33 biological_region
There is 1 lnc_rna
There is 5076 mrna
There is 21 rrna
There is 1 ncrna
There is 310 trna
There is 35 snrna
There is 5659 exon
There is 5251 cds
There is 368 ncrna_gene

Total raw data of files together:
There is 77 snorna
There is 1 lnc_rna
There is 23 chromosome
There is 33 biological_region
There is 11676 gene
There is 41 snrna
There is 12 pseudogene
There is 609 trna
There is 19 ncrna
There is 45 rrna
There is 11676 mrna
There is 91 transposable_element
There is 13166 exon
There is 91 rna
There is 0 transposable_element_gene
There is 4 five_prime_utr
There is 12 pseudogenic_transcript
There is 792 ncrna_gene
There is 12164 cds

Now merging overlaping loci, and removing identical isoforms
********************************************************************************
*                              - Start parsing -                               *
********************************************************************************
-------------------------- parse options and metadata --------------------------
=> Accessing the feature level json files
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level1.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level2.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level3.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_spread.json file
=> Attribute used to group features when no Parent/ID relationship exists (i.e common tag):
    * locus_tag
    * gene_id
=> merge_loci option activated
=> Machine information:
    This script is being run by perl v5.34.0
    Bioperl location being used: /app/software/BioPerl/1.7.8-GCCcore-11.2.0/lib/perl5/site_perl/5.34.0/Bio/
    Operating system being used: linux
=> Accessing Ontology
    No ontology accessible from the gff file header!
    We use the SOFA ontology distributed with AGAT:
        /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo
    Read ontology /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo:
        4 root terms, and 2596 total terms, and 1516 leaf terms
    Filtering ontology:
        We found 1861 terms that are sequence_feature or is_a child of it.
--------------------------------- parsing file ---------------------------------
********************************************************************************
*                               - End parsing -                                *
*                              done in 2 seconds                               *
********************************************************************************

********************************************************************************
*                               - Start checks -                               *
********************************************************************************
---------------------------- Check1: feature types -----------------------------
----------------------------------- ontology -----------------------------------
INFO - Feature types not expected by the GFF3 specification:
* lnc_rna
* rna
The feature type (3rd column in GFF3) is constrained to be either a term from th
e Sequence Ontology or an SO accession number. The latter alternative is disting
uished using the syntax SO:000000. In either case, it must be sequence_feature (
SO:0000110) or an is_a child of it.To follow rigorously the gff3 format, please
visit this website:
https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md
------------------------------------- agat -------------------------------------
AGAT can deal with all the encountered feature types (3rd column)
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check2: duplicates ------------------------------
None found
------------------------------ done in 0 seconds -------------------------------

-------------------------- Check3: sequential bucket ---------------------------
None found
------------------------------ done in 1 seconds -------------------------------

--------------------------- Check4: l2 linked to l3 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check5: l1 linked to l2 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check6: remove orphan l1 ---------------------------
We remove only those not supposed to be orphan
None found
------------------------------ done in 0 seconds -------------------------------

------------------------- Check7: all level3 locations -------------------------
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check8: check cds -------------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check9: check exons ------------------------------
No exons created
No exons locations modified
No supernumerary exons removed
No level2 locations modified
------------------------------ done in 1 seconds -------------------------------

----------------------------- Check10: check utrs ------------------------------
No UTRs created
No UTRs locations modified
No supernumerary UTRs removed
------------------------------ done in 0 seconds -------------------------------

------------------------ Check11: all level2 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

------------------------ Check12: all level1 locations -------------------------
No problem found
------------------------------ done in 1 seconds -------------------------------

-------------- Check13: merge overlaping features into same locus --------------
165 overlapping cases found. For each case 2 loci have been merged within a same locus
------------------------------ done in 1 seconds -------------------------------

---------------------- Check14: remove identical isoforms ----------------------
None found
------------------------------ done in 0 seconds -------------------------------
********************************************************************************
*                                - End checks -                                *
*                              done in 4 seconds                               *
********************************************************************************

=> OmniscientI total time: 6 seconds

final result:
There is 19 ncrna
There is 45 rrna
There is 11676 mrna
There is 50 transposable_element
There is 10 pseudogene
There is 41 snrna
There is 609 trna
There is 23 chromosome
There is 11557 gene
There is 33 biological_region
There is 77 snorna
There is 1 lnc_rna
There is 789 ncrna_gene
There is 12164 cds
There is 12 pseudogenic_transcript
There is 4 five_prime_utr
There is 13166 exon
There is 91 rna
```
Seems to be OK...

##### [Getting the `.fastq` files of interest into one location](#getting-the-fastq-files-of-interest-into-one-location)
```bash
#DONTRUN

#  grabnode should be "on"

#  Base directory containing subdirectories with original merged .fastq files
cd ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot

ls -d1 Sample_57*
# Sample_5781_G1_IN
# Sample_5781_G1_IP
# Sample_5781_Q_IN
# Sample_5781_Q_IP
# Sample_5782_G1_IN
# Sample_5782_G1_IP
# Sample_5782_Q_IN
# Sample_5782_Q_IP

ls -d1 Sample_57*/*merged*fastq*
# Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq
# Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq
# Sample_5781_G1_IP/5781_G1_IP_merged_R1.fastq
# Sample_5781_G1_IP/5781_G1_IP_merged_R2.fastq
# Sample_5781_Q_IN/5781_Q_IN_merged_R1.fastq
# Sample_5781_Q_IN/5781_Q_IN_merged_R2.fastq
# Sample_5781_Q_IP/5781_Q_IP_merged_R1.fastq
# Sample_5781_Q_IP/5781_Q_IP_merged_R2.fastq
# Sample_5782_G1_IN/5782_G1_IN_merged_R1.fastq
# Sample_5782_G1_IN/5782_G1_IN_merged_R2.fastq
# Sample_5782_G1_IP/5782_G1_IP_merged_R1.fastq
# Sample_5782_G1_IP/5782_G1_IP_merged_R2.fastq
# Sample_5782_Q_IN/5782_Q_IN_merged_R1.fastq
# Sample_5782_Q_IN/5782_Q_IN_merged_R2.fastq
# Sample_5782_Q_IP/5782_Q_IP_merged_R1.fastq
# Sample_5782_Q_IP/5782_Q_IP_merged_R2.fastq

#  Get the .fastq files into an array to loop over
cd ~

unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find ${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot \
        -type f \
        -name *578*merged*fastq* \
        -print0 \
            | sort -z \
)
for i in "${infiles[@]}"; do echo "${i}"; done  # Check
for i in "${infiles[@]}"; do echo "$(basename "${i}")"; done  # Check

#  Make symlinks to the .fastq files in 2022_transcriptome-contructions results
mkdir -p ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/files_fastq_symlinks

for i in "${infiles[@]}"; do
    ln -s \
        ${i} \
        ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/files_fastq_symlinks/$(basename ${i})
done

ls -1 ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/files_fastq_symlinks
# 5781_G1_IN_merged_R1.fastq
# 5781_G1_IN_merged_R2.fastq
# 5781_G1_IP_merged_R1.fastq
# 5781_G1_IP_merged_R2.fastq
# 5781_Q_IN_merged_R1.fastq
# 5781_Q_IN_merged_R2.fastq
# 5781_Q_IP_merged_R1.fastq
# 5781_Q_IP_merged_R2.fastq
# 5782_G1_IN_merged_R1.fastq
# 5782_G1_IN_merged_R2.fastq
# 5782_G1_IP_merged_R1.fastq
# 5782_G1_IP_merged_R2.fastq
# 5782_Q_IN_merged_R1.fastq
# 5782_Q_IN_merged_R2.fastq
# 5782_Q_IP_merged_R1.fastq
# 5782_Q_IP_merged_R2.fastq

#NOTE Per Alison, "IP" = Nascent, "IN" = SteadyState
```

##### [Checking on the length of reads for each `.fastq` file](#checking-on-the-length-of-reads-for-each-fastq-file)
```bash
#DONTRUN

#  grabnode should be "on"

cd ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101

#  Prepare for and run FastQC
mkdir -p files_fastq_symlinks/FastQC

cat << script > "./submit-FastQC.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-FastQC.sh
#  KA

module load FastQC/0.11.9-Java-11

infile="\${1}"
outdir="\${2}"

fastqc \\
    --threads "\${SLURM_CPUS_ON_NODE}" \\
    --outdir "\${outdir}" \\
    "\${infile}"
script

#  Get the symlinked .fastq files into an array to loop over
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name 578*merged*fastq* \
        -print0 \
            | sort -z \
)
for i in "${infiles[@]}"; do echo "${i}"; done  # Check
for i in "${infiles[@]}"; do echo "$(basename "${i}" ".fastq")"; done  # Check

#  Do a test run of submit-FastQC.sh
i="${infiles[0]}"

mkdir -p "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"

sbatch ./submit-FastQC.sh \
    "${i}" \
    "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"
#NOTE It works

#  Submit the .fastq files to SLURM
for i in "${infiles[@]}"; do
    mkdir -p "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"

    sbatch ./submit-FastQC.sh \
        "${i}" \
        "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"

    sleep 0.5
done

#  Clean up the FastQC work
mkdir -p exp_FastQC
mv *.{err,out}.txt exp_FastQC/

ls -d ./files_fastq_symlinks/FastQC/*.bak
./files_fastq_symlinks/FastQC/5781_G1_IN_merged_R1.bak
rm -r ./files_fastq_symlinks/FastQC/5781_G1_IN_merged_R1.bak

#  Going into the ./files_fastq_symlinks/FastQC subdirectories and manually
#+ spot-checking the .html files

#NOTE #IMPORTANT The read length is bp (at least for these "WTQvsG1" files)
````

#### [Run `STAR` genome generation](#run-star-genome-generation)
```bash
#DONTRUN

#  grabnode has been called with default/lowest settings
cd ~/genomes/combined_SC_KL_20S
mkdir -p STAR/{err_out,sh}
cd STAR/

#  Reference
# STAR \
#     --runThreadN "${SLURM_CPUS_ON_NODE}" \
#     --runMode genomeGenerate \
#     --genomeDir "${genome_dir}" \
#     --genomeFastaFiles "${genome_fasta_file}" \
#     --sjdbGTFfile "${sjdb_gtf_file}" \
#     --sjdbOverhang "${sjdb_overhang}" \
#     --sjdbGTFtagExonParentTranscript Parent \
#     --genomeSAindexNbases "${genome_sa_index_n_bases}"

cat << script > "./submit-STAR-genomeGenerate.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-STAR-genomeGenerate.sh
#  KA

module load STAR/2.7.9a-GCC-11.2.0

genome_dir="\${1}"
genome_fasta_file="\${2}"
sjdb_gtf_file="\${3}"
sjdb_overhang="\${4}"
genome_sa_index_n_bases="\${5}"

STAR \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --runMode genomeGenerate \\
    --genomeDir "\${genome_dir}" \\
    --genomeFastaFiles "\${genome_fasta_file}" \\
    --sjdbGTFfile "\${sjdb_gtf_file}" \\
    --sjdbOverhang "\${sjdb_overhang}" \\
    --sjdbGTFtagExonParentTranscript Parent \\
    --genomeSAindexNbases "\${genome_sa_index_n_bases}"
script

#  First, make sure the .gff3 file is unzipped
[[ -f ../gff3/combined_SC_KL.gff3 ]] ||
    {
        cd ../gff3
        gzip -dk combined_SC_KL.gff3.gz
        cd -
    }

#  Try it out
genome_dir="."
genome_fasta_file="../fasta/combined_SC_KL_20S.fasta"
sjdb_gtf_file="../gff3/combined_SC_KL.gff3"
sjdb_overhang="49"  # 50 - 1
genome_sa_index_n_bases="10"
#  Per Alex Dobin, 12 is appropriate the S. cerevisiae genome; however, in a
#+ trial run, I got the following error (broken over multiple lines by me):
#+ 
#+ !!!!! WARNING: --genomeSAindexNbases 12 is too large for the genome
#+ size=22848775, which may cause seg-fault at the mapping step. Re-run genome
#+ generation with recommended --genomeSAindexNbases 11
#+ 
#+ Therefore, I changed genome_sa_index_n_bases from "12" to "11"

#IMPORTANT 
#  Actually, the above is incorrect; Dobin recommends "10", not "12", for
#+ --genomeSAindexNbases: Set --genomeSAindexNbases 10
#+ 
#+ groups.google.com/g/rna-star/c/hQeHTBbkc0c?pli=1

sbatch submit-STAR-genomeGenerate.sh \
    "${genome_dir}" \
    "${genome_fasta_file}" \
    "${sjdb_gtf_file}" \
    "${sjdb_overhang}" \
    "${genome_sa_index_n_bases}"
#NOTE #IMPORTED Completed remarkably quickly... like, less than 10 seconds

#  Clean up
mv *.{err,out}.txt err_out/
mv *.sh sh/

#  Document things a bit
mkdir readme && cd readme/
touch readme.md
echo \
    "Made 2022-1107. See readme.md in directory results/2022-1101 for details." \
    >> readme.md

echo \
    "Files made on 2022-1107 used '--genomeSAindexNbases 11'. Alex Dobin recommends '10', not '11', for the yeast genome. Therefore, deleted those files." \
    >> readme.md

echo "" >> readme.md

echo \
    "Files made on 2022-1108 used '--genomeSAindexNbases 10'." \
    >> readme.md
```

#### [Run `STAR` alignment](#run-star-alignment)
```bash
#DONTRUN

#  grabnode has been called with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"
mkdir -p {exp_alignment_STAR,files_bams}

#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)
#  Some checks...
for i in "${infiles[@]}"; do echo "${i}"; done && echo ""
for i in "${infiles[@]}"; do echo "$(basename "${i}")"; done && echo
for i in "${infiles[@]}"; do echo "$(basename "${i%_R?.fastq}")"; done && echo ""

echo "${infiles[0]}" && echo ""
echo "${infiles[1]}" && echo ""
echo "$(basename "${infiles[0]%_R?.fastq}")" && echo ""

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"

echo "${genome_dir}"
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"

#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Run the alignment
if [[ -f "./submit-STAR-alignReads.sh" ]]; then
    rm "./submit-STAR-alignReads.sh"
fi

cat << script > "./submit-STAR-alignReads.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-STAR-alignReads.sh
#  KA

module load STAR/2.7.9a-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

STAR \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMunmapped Within \\
    --genomeDir "\${genome_dir}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax 1 \\
    --alignSJoverhangMin 8 \\
    --alignSJDBoverhangMin 1 \\
    --outFilterMismatchNmax 999 \\
    --alignIntronMin 4 \\
    --alignIntronMax 5000 \\
    --alignMatesGapMax 5000 \\
    --outSAMtype BAM SortedByCoordinate
script

sbatch submit-STAR-alignReads.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

##### [Alignment metrics for the test run of `STAR`](#alignment-metrics-for-the-test-run-of-star)
```txt
                                 Started job on |       Nov 08 10:28:26
                             Started mapping on |       Nov 08 10:28:27
                                    Finished on |       Nov 08 10:29:41
       Mapping speed, Million of reads per hour |       680.54

                          Number of input reads |       13988842
                      Average input read length |       100
                                    UNIQUE READS:
                   Uniquely mapped reads number |       8559366
                        Uniquely mapped reads % |       61.19%
                          Average mapped length |       98.22
                       Number of splices: Total |       352426
            Number of splices: Annotated (sjdb) |       289654
                       Number of splices: GT/AG |       321441
                       Number of splices: GC/AG |       232
                       Number of splices: AT/AC |       2334
               Number of splices: Non-canonical |       28419
                      Mismatch rate per base, % |       0.39%
                         Deletion rate per base |       0.01%
                        Deletion average length |       1.19
                        Insertion rate per base |       0.01%
                       Insertion average length |       1.17
                             MULTI-MAPPING READS:
        Number of reads mapped to multiple loci |       0
             % of reads mapped to multiple loci |       0.00%
        Number of reads mapped to too many loci |       5035208
             % of reads mapped to too many loci |       35.99%
                                  UNMAPPED READS:
  Number of reads unmapped: too many mismatches |       0
       % of reads unmapped: too many mismatches |       0.00%
            Number of reads unmapped: too short |       393913
                 % of reads unmapped: too short |       2.82%
                Number of reads unmapped: other |       355
                     % of reads unmapped: other |       0.00%
                                  CHIMERIC READS:
                       Number of chimeric reads |       0
                            % of chimeric reads |       0.00%
```
###### [Thoughts on the alignment metrics for `STAR`](#thoughts-on-the-alignment-metrics-for-star):
- A lot of multi-mappers in the dataset...
- `#DONE` Later, check what value I assigned to `--outFilterMultimapNmax` in my 4DN RNA-seq work; consider to replace the current value, `1`, with that other value
    + `#ANSWER` `--outFilterMultimapNmax 1000`
- `#DONE` What does the [`Trinity` Google Group](https://groups.google.com/g/trinityrnaseq-users) have to say about multimappers?
    + `#ANSWER` Per Brian Haas at [this post](https://groups.google.com/g/trinityrnaseq-users/c/L4hypoWSk_o/m/bTO2L8ssAQAJ): "If reads are mapped to multiple genomic locations, then `Trinity` will use those reads as substrates for *de novo* assembly at each of the locations. This is important to do in the case of paralogs that share sequences in common."
        * However, here, he's talking about genome-guided assembly; is this also the case for non-genome-guided assembly?
            - `#ANSWER` ~~I would think so... What he says about potential paralogs seems like it holds true in this circumstance too~~
            - `#ANSWER` Actually, I don't think so: We would essentially be increasing the numbers of reads in our `.fastq` files: for example, our .bam files will contain multimappers after converting 
            - Actually, reach out to the `Trinity` Google group to ask about it
        * `#CONCLUSION` ***Don't*** keep the multimappers and ***don't*** use them in draft-free *de novo* assembly of the transcriptome; consider using them in genome-guided assembly `#TBD`

Message that I sent to the Trinity Google group:
```txt
Hi all,

I am preparing to do a non-genome-guided transcriptome assembly for S. cerevisiae with Trinity (our yeast model has high levels of gene expression in unannotated parts of the genome, so that's why we are doing transcriptome assembly with an otherwise well-annotated organism).

I am working with RNA-seq data that contain spike-in RNA from another yeast species. I filter this out by performing an initial alignment (with either Bowtie 2 or STAR) to a reference genome made up of S. cerevisiae and the other species. Using the resulting .bam file, I filter out alignments to the chromosomes of the other species. I also filter out unaligned reads (a relatively small percentage of reads: I wonder if I should just keep them in?). Then, I convert the filtered .bam (containing only S. cerevisiae alignments) to .fastq files (paired-end). I use these files as input to Trinity for non-genome-guided transcriptome assembly.

There are many multimappers (multiple alignments per read) in my data. Based on the information in this previous post to the Trinity Google group (Genome-guided Trinity - reads mapping to multiple loci?), I am curious to know if I should report and keep the multiple alignments per read, not filter them from my .bam file, and in turn have them present in the converted .fastq files. This is because, if I understand correctly, these reads can be "substrates for de novo assembly at each of the locations" where they map, at least in genome-guided assembly. In practice, this will add duplicates to the .fastq files, so will this have the same effect with non-genome-guided assembly?

What do you think? Any input will be greatly appreciated.

Thanks,
Kris

Link from above:
https://groups.google.com/g/trinityrnaseq-users/c/L4hypoWSk_o/m/bTO2L8ssAQAJ
```

###### [Examine the flags in the `.bam` outfile from the test run of `STAR`](#examine-the-flags-in-the-bam-outfile-from-the-test-run-of-star)
Use `samtools flagstat` and the bespoke function `list_tally_flags`:
```bash
#!/bin/bash
#DONTRUN

samtools flagstat \
    ./files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    > ./files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt

#  grabnode has been called with default/lowest settings; samtools is loaded
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

less ./files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# 27446606 + 531078 in total (QC-passed reads + QC-failed reads)
# 27446606 + 531078 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 16893176 + 225556 mapped (61.55% : 42.47%)
# 16893176 + 225556 primary mapped (61.55% : 42.47%)
# 27446606 + 531078 paired in sequencing
# 13723303 + 265539 read1
# 13723303 + 265539 read2
# 16893176 + 225556 properly paired (61.55% : 42.47%)
# 16893176 + 225556 with itself and mate mapped
# 0 + 0 singletons (0.00% : 0.00%)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)

cd ./files_bams

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags 5781_G1_IN_mergedAligned.sortedByCoord.out.bam

#  Numbers of records in the .bam file
samtools view -c \
    5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# 27977684

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

#  The numbers of records in the .bam and .fastq files are equivalent
```

Contents of outfile from running `list_tally_flags`...
```txt
5276715 77
5276715 141
4691235 99
4691235 147
3755353 83
3755353 163
 152761 653
 152761 589
  62364 659
  62364 611
  50414 675
  50414 595
```
What are the meanings of these flags? Use [this tool](https://broadinstitute.github.io/picard/explain-flags.html) to check:
| flag | meaning                                                                                                                     |
| :--- | :-------------------------------------------------------------------------------------------------------------------------- |
| 77   | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40)                                           |
| 141  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80)                                          |
| 99   | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40)                       |
| 147  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80)                      |
| 83   | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40)                       |
| 163  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80)                      |
| 653  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80), read fails* (0x200)                     |
| 589  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40), read fails* (0x200)                      |
| 659  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80), read fails* (0x200) |
| 611  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40), read fails* (0x200)  |
| 675  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80), read fails* (0x200) |
| 595  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40), read fails* (0x200)  |

###### [Additional thoughts on the alignment metrics and flags from `STAR`](#additional-thoughts-on-the-alignment-metrics-and-flags-from-star)
- Because we want to use the multimappers in `Trinity` transcriptome assembly (rationale in ["Thoughts on the..."](#thoughts-on-the-alignment-metrics-for-star) above), it'd probably be good to have information for where `STAR` (and `Bowtie 2`) is aligning them in the bam file, instead of them being unmapped as above
- Thus, we should adjust the parameters for how we call `STAR` to retain the multi-mappers
- `(   ) #TODO #TOMORROW` Adjust `STAR` parameters based on the repetitive-element work you did in 2020 (bring your laptop to work tomorrow); for now, move on to `Bowtie 2` work

###### [Do a little clean-up prior to running alignment with `Bowtie 2`](#do-a-little-clean-up-prior-to-running-alignment-with-bowtie-2)
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

mv files_bams/ exp_alignment_STAR/
```

#### [Generating files needed for `Bowtie 2` alignment (2022-1108)](#generating-files-needed-for-bowtie-2-alignment-2022-1108)
...to the combined reference genes (*S. cerevisiae*, *K. lactis*, and S20)

##### [Preparing the `.fasta` and `.gff3` files for `Bowtie 2`](#preparing-the-fasta-and-gff3-files-for-bowtie-2)
`Bowtie 2` indices were already generated: see [this link](../2022-1025/readme.md#create-bowtie-2-indices); but just checking on things before diving into things...
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/combined_SC_KL_20S"

#  Checking the .fasta
grep "^>" ./fasta/*.fasta
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito
# >A
# >B
# >C
# >D
# >E
# >F
# >20S

#  Checking the .gff3
head -33 ./gff3/combined_SC_KL.gff3
# ##gff-version 3
# ##sequence-region   I 1 230218
# ##sequence-region   II 1 813184
# ##sequence-region   III 1 316620
# ##sequence-region   IV 1 1531933
# ##sequence-region   IX 1 439888
# ##sequence-region   Mito 1 85779
# ##sequence-region   V 1 576874
# ##sequence-region   VI 1 270161
# ##sequence-region   VII 1 1090940
# ##sequence-region   VIII 1 562643
# ##sequence-region   X 1 745751
# ##sequence-region   XI 1 666816
# ##sequence-region   XII 1 1078177
# ##sequence-region   XIII 1 924431
# ##sequence-region   XIV 1 784333
# ##sequence-region   XV 1 1091291
# ##sequence-region   XVI 1 948066
# #!genome-build  R64-1-1
# #!genome-version R64-1-1
# #!genome-date 2011-09
# #!genome-build-accession GCA_000146045.2
# #!genebuild-last-updated 2018-10
# ##sequence-region   A 1 1062590
# ##sequence-region   B 1 1320834
# ##sequence-region   C 1 1753957
# ##sequence-region   D 1 1715506
# ##sequence-region   E 1 2234072
# ##sequence-region   F 1 2602197
# #!genome-build Genolevures Consortium ASM251v1
# #!genome-version ASM251v1
# #!genome-build-accession GCA_000002515.1
# #!genebuild-last-updated 2015-02

#  Checking the Bowtie 2 indices
#+ bowtie-bio.sourceforge.net/bowtie2/manual.shtml#the-bowtie2-build-indexer
module load Bowtie2/2.4.4-GCC-11.2.0
bowtie2-inspect --names ./Bowtie2/combined_SC_KL_20S
# I
# II
# III
# IV
# V
# VI
# VII
# VIII
# IX
# X
# XI
# XII
# XIII
# XIV
# XV
# XVI
# Mito
# A
# B
# C
# D
# E
# F
# 20S
```

##### [On the location of the `.fastq` files](#on-the-location-of-the-fastq-files)
See all the work done [here](#getting-the-fastq-files-of-interest-into-one-location)

##### [Run `Bowtie 2` alignment](#run-bowtie-2-alignment)
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

mkdir -p exp_alignment_Bowtie_2/files_bams

#  Get .fastq files into an array
#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./exp_alignment_Bowtie_2/files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"

#  Some checks...
echo "${genome_dir}"
ls -lhaFG ${genome_dir}* && echo ""
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"

#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Perform alignment with Bowtie 2
if [[ -f "./submit-Bowtie-2.sh" ]]; then
    rm "./submit-Bowtie-2.sh"
fi

cat << script > "./submit-Bowtie-2.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Bowtie-2.sh
#  KA

module load Bowtie2/2.4.4-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

bowtie2 \\
    -p "\${SLURM_CPUS_ON_NODE}" \\
    -x "\${genome_dir}" \\
    -1 "\${read_1}" \\
    -2 "\${read_2}" \\
    --trim5 1 \\
    --local \\
    --very-sensitive-local \\
    --no-unal \\
    --no-mixed \\
    --no-discordant \\
    --phred33 \\
    -I 10 \\
    -X 700 \\
    --no-overlap \\
    --no-dovetail \\
        | samtools sort -@ "\${SLURM_CPUS_ON_NODE}" -o "\${prefix}_sorted.bam" -
script

sbatch submit-Bowtie-2.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

##### [Alignment metrics for the test run of `Bowtie 2`](#alignment-metrics-for-the-test-run-of-bowtie-2)
```txt
13988842 reads; of these:
  13988842 (100.00%) were paired; of these:
    904915 (6.47%) aligned concordantly 0 times
    7154822 (51.15%) aligned concordantly exactly 1 time
    5929105 (42.38%) aligned concordantly >1 times
93.53% overall alignment rate
[bam_sort_core] merging from 7 files and 1 in-memory blocks..
```

###### [Thoughts on the alignment metrics for `Bowtie 2`](#thoughts-on-the-alignment-metrics-for-bowtie-2)
- Approximately half are well-aligned
- Approximately 7% of reads don't align at all
- The rest, 43%, are discordant

###### [Examine the flags in the `.bam` outfile from the test run of `Bowtie 2`](#examine-the-flags-in-the-bam-outfile-from-the-test-run-of-bowtie-2)
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

#  First, a bit of clean-up
mv *.txt exp_alignment_Bowtie_2/

ml SAMtools/1.16.1-GCC-11.2.0

samtools flagstat \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam \
    > ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.flagstat.txt
# 26167854 + 0 in total (QC-passed reads + QC-failed reads)
# 26167854 + 0 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 26167854 + 0 mapped (100.00% : N/A)
# 26167854 + 0 primary mapped (100.00% : N/A)
# 26167854 + 0 paired in sequencing
# 13083927 + 0 read1
# 13083927 + 0 read2
# 26167854 + 0 properly paired (100.00% : N/A)
# 26167854 + 0 with itself and mate mapped
# 0 + 0 singletons (0.00% : N/A)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam

samtools view -c \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam
# 26167854

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

# Multiply by the overall alignment rate: Is it equal to the number of records in the .bam file?
echo "27977684*0.9353" | bc
# 26167527.8452; rounds up to 26167528; rounds down to 26167527

#  The numbers of records in the .bam and .fastq files are not equivalent
```

Contents of outfile from running `list_tally_flags`...
```txt
7070153 83
7070153 163
6013774 99
6013774 147
```

##### Try re-running `Bowtie 2` alignment
...***without*** the flags for removing unaligned and discordant reads, which were mistakenly included in the first run
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

#  Remove the bams and other files from the "first test"
rm -r exp_alignment_Bowtie_2/

#  Remake the experiment directory
mkdir -p exp_alignment_Bowtie_2/files_bams  # Should already be done

#  Get .fastq files into an array
#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./exp_alignment_Bowtie_2/files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"

#  Some checks...
echo "${genome_dir}"
ls -lhaFG ${genome_dir}* && echo ""
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"

#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Rename the script for calling Bowtie 2 as in the preceding code chunk
if [[ -f "submit-Bowtie-2.sh" ]]; then
    mv "submit-Bowtie-2.sh" "submit-Bowtie-2.test-1.sh"
fi

#  Perform alignment with Bowtie 2
if [[ -f "./submit-Bowtie-2.test-2.sh" ]]; then
    rm "./submit-Bowtie-2.test-2.sh"
fi

#  Parameters updated in comparison to the first test
cat << script > "./submit-Bowtie-2.test-2.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Bowtie-2.sh
#  KA

module load Bowtie2/2.4.4-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

bowtie2 \\
    -p "\${SLURM_CPUS_ON_NODE}" \\
    -x "\${genome_dir}" \\
    -1 "\${read_1}" \\
    -2 "\${read_2}" \\
    --local \\
    --very-sensitive-local \\
    --phred33 \\
    -I 10 \\
    -X 700 \\
    --un-conc-gz "\${prefix}.unaligned" \\
    --al-conc-gz "${prefix}.aligned" \\
        | samtools sort -@ "\${SLURM_CPUS_ON_NODE}" -o "\${prefix}_sorted.bam" -
script

sbatch submit-Bowtie-2.test-2.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

##### [Alignment metrics for the *corrected* test run of Bowtie 2](#alignment-metrics-for-the-corrected-test-run-of-bowtie-2)
```txt
13988842 reads; of these:
  13988842 (100.00%) were paired; of these:
    552105 (3.95%) aligned concordantly 0 times
    7261264 (51.91%) aligned concordantly exactly 1 time
    6175473 (44.15%) aligned concordantly >1 times
    ----
    552105 pairs aligned concordantly 0 times; of these:
      119842 (21.71%) aligned discordantly 1 time
    ----
    432263 pairs aligned 0 times concordantly or discordantly; of these:
      864526 mates make up the pairs; of these:
        386601 (44.72%) aligned 0 times
        176417 (20.41%) aligned exactly 1 time
        301508 (34.88%) aligned >1 times
98.62% overall alignment 
[bam_sort_core] merging from 8 files and 8 in-memory blocks...
```

###### [Thoughts on the alignment metrics for Bowtie 2 (*corrected*)](#thoughts-on-the-alignment-metrics-for-bowtie-2-corrected)
- Very similar to the previous run...

###### [Examine the flags in the `.bam` outfile from the *corrected* test run of `Bowtie 2`](#examine-the-flags-in-the-bam-outfile-from-the-corrected-test-run-of-bowtie-2)
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

#  First, a bit of clean-up
mv *.txt exp_alignment_Bowtie_2/

ml SAMtools/1.16.1-GCC-11.2.0

samtools flagstat \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam \
    > ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.flagstat.txt
#  1. Readout from "correct" .bam (i.e., with correct parameters)
# 27977684 + 0 in total (QC-passed reads + QC-failed reads)
# 27977684 + 0 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 27591083 + 0 mapped (98.62% : N/A)
# 27591083 + 0 primary mapped (98.62% : N/A)
# 27977684 + 0 paired in sequencing
# 13988842 + 0 read1
# 13988842 + 0 read2
# 26873474 + 0 properly paired (96.05% : N/A)
# 27450096 + 0 with itself and mate mapped
# 140987 + 0 singletons (0.50% : N/A)
# 153696 + 0 with mate mapped to a different chr
# 65835 + 0 with mate mapped to a different chr (mapQ>=5)

#  1. Readout from "uncorrect" .bam (i.e., with incorrect parameters; see
#+    above)
# 26167854 + 0 in total (QC-passed reads + QC-failed reads)
# 26167854 + 0 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 26167854 + 0 mapped (100.00% : N/A)
# 26167854 + 0 primary mapped (100.00% : N/A)
# 26167854 + 0 paired in sequencing
# 13083927 + 0 read1
# 13083927 + 0 read2
# 26167854 + 0 properly paired (100.00% : N/A)
# 26167854 + 0 with itself and mate mapped
# 0 + 0 singletons (0.00% : N/A)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam

samtools view -c \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam
# 27977684

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

# Multiply by the overall alignment rate: Is it equal to the number of records in the .bam file?
echo "27977684*0.9862" | bc
# 27591591.9608; rounds up to 27591592; rounds down to 27591591

#  Numbers of records in the .bam and .fastq files *are* equivalent
#+ Great!
```

Contents of outfile from running `list_tally_flags` (with notes from me)...
```txt
7314425 83
7314425 163
6122312 99
6122312 147
 139372 97
 139372 145
 122807 77
 122807 141
  96792 81
  96792 161
  42776 89
  42776 165
  40407 73
  40407 133
  33323 65
  33323 129
  31296 153 unmapped
  31296 101 unmapped
  26508 69 unmapped
  26508 137 unmapped
  18824 177
  18824 113
```
What are the meanings of these flags? Use [this tool](https://broadinstitute.github.io/picard/explain-flags.html) to check:
| flag | meaning                                                                                                |
| :--- | :----------------------------------------------------------------------------------------------------- |
| 83   | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40)  |
| 163  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80) |
| 99   | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40)  |
| 147  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80) |
| 97   | read paired (0x1), mate reverse strand (0x20), first in pair (0x40)                                    |
| 145  | read paired (0x1), read reverse strand (0x10), second in pair (0x80)                                   |
| 77   | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40)                      |
| 141  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80)                     |
| 81   | read paired (0x1), read reverse strand (0x10), first in pair (0x40)                                    |
| 161  | read paired (0x1), mate reverse strand (0x20), second in pair (0x80)                                   |
| 89   | read paired (0x1), mate unmapped (0x8), read reverse strand (0x10), first in pair (0x40)               |
| 165  | read paired (0x1), read unmapped (0x4), mate reverse strand (0x20), second in pair (0x80)              |
| 73   | read paired (0x1), mate unmapped (0x8), first in pair (0x40)                                           |
| 133  | read paired (0x1), read unmapped (0x4), second in pair (0x80)                                          |
| 65   | read paired (0x1), first in pair (0x40)                                                                |
| 129  | read paired (0x1), second in pair (0x80)                                                               |
| 153  | read paired (0x1), mate unmapped (0x8), read reverse strand (0x10), second in pair (0x80)              |
| 101  | read paired (0x1), read unmapped (0x4), mate reverse strand (0x20), first in pair (0x40)               |
| 69   | read paired (0x1), read unmapped (0x4), first in pair (0x40)                                           |
| 137  | read paired (0x1), mate unmapped (0x8), second in pair (0x80)                                          |
| 177  | read paired (0x1), read reverse strand (0x10), mate reverse strand (0x20), second in pair (0x80)       |
| 113  | read paired (0x1), read reverse strand (0x10), mate reverse strand (0x20), first in pair (0x40)        |
<br />
<br />

Do the above counts sum to 27977684?
```bash
echo $(( \
    7314425 + \
    7314425 + \
    6122312 + \
    6122312 + \
    139372 + \
    139372 + \
    122807 + \
    122807 + \
    96792 + \
    96792 + \
    42776 + \
    42776 + \
    40407 + \
    40407 + \
    33323 + \
    33323 + \
    31296 + \
    31296 + \
    26508 + \
    26508 + \
    18824 + \
    18824 \
))
# 27977684: Yes
```

###### [Examine the `.fastq` outfiles from the *corrected* test run of `Bowtie 2`](#examine-the-fastq-outfiles-from-the-corrected-test-run-of-bowtie-2)
```bash
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/exp_alignment_Bowtie_2/files_bams"

ls -lhaFG
# total 2.5G
# drwxrws--- 2 kalavatt  337 Nov  9 15:31 ./
# drwxrws--- 3 kalavatt  160 Nov  9 15:23 ../
# -rw-rw---- 1 kalavatt 427M Nov  8 16:24 5781_G1_IN_merged.1.aligned
# -rw-rw---- 1 kalavatt  19M Nov  8 16:24 5781_G1_IN_merged.1.unaligned
# -rw-rw---- 1 kalavatt 447M Nov  8 16:24 5781_G1_IN_merged.2.aligned
# -rw-rw---- 1 kalavatt  19M Nov  8 16:24 5781_G1_IN_merged.2.unaligned
# -rw-rw---- 1 kalavatt 942M Nov  8 16:24 5781_G1_IN_merged_sorted.bam
# -rw-rw---- 1 kalavatt  531 Nov  9 15:25 5781_G1_IN_merged_sorted.flagstat.txt
# -rw-rw---- 1 kalavatt  255 Nov  9 15:29 5781_G1_IN_merged_sorted.flags.txt

#  (The files are gzipped even though the extension is not present...)
echo $(zcat 5781_G1_IN_merged.1.aligned | wc -l)/4 | bc  # 13436737
echo $(zcat 5781_G1_IN_merged.2.aligned | wc -l)/4 | bc  # 13436737
echo $(zcat 5781_G1_IN_merged.1.unaligned | wc -l)/4 | bc  # 552105
echo $(zcat 5781_G1_IN_merged.2.unaligned | wc -l)/4 | bc  # 552105

#  Do the above counts sum to 27977684?
echo $(( 13436737 + 13436737 + 552105 + 552105 ))  # 27977684: Yes
```

###### [`head` through the `.bam` outfile from the *corrected* test run of `Bowtie 2`](#head-through-the-bam-outfile-from-the-corrected-test-run-of-bowtie-2)
...to see if information for multimappers are present in the tags
```bash
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/exp_alignment_Bowtie_2/files_bams"

samtools view -h 5781_G1_IN_merged_sorted.bam | less
```

Example output:
```txt
@HD     VN:1.0  SO:coordinate
@SQ     SN:I    LN:230218
@SQ     SN:II   LN:813184
@SQ     SN:III  LN:316620
@SQ     SN:IV   LN:1531933
@SQ     SN:V    LN:576874
@SQ     SN:VI   LN:270161
@SQ     SN:VII  LN:1090940
@SQ     SN:VIII LN:562643
@SQ     SN:IX   LN:439888
@SQ     SN:X    LN:745751
@SQ     SN:XI   LN:666816
@SQ     SN:XII  LN:1078177
@SQ     SN:XIII LN:924431
@SQ     SN:XIV  LN:784333
@SQ     SN:XV   LN:1091291
@SQ     SN:XVI  LN:948066
@SQ     SN:Mito LN:85779
@SQ     SN:A    LN:1062590
@SQ     SN:B    LN:1320834
@SQ     SN:C    LN:1753957
@SQ     SN:D    LN:1715506
@SQ     SN:E    LN:2234072
@SQ     SN:F    LN:2602197
@SQ     SN:20S  LN:2514
@PG     ID:bowtie2      PN:bowtie2      VN:2.4.4        CL:"/app/software/Bowtie2/2.4.4-GCC-11.2.0/bin/bowtie2-align-s --wrapper basic-0 -p 8 -x /home/kalavatt/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S --local --very-sensitive-local --phred33 -I 10 -X 700 --
@PG     ID:samtools     PN:samtools     PP:bowtie2      VN:1.16.1       CL:samtools sort -@ 8 -o ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam -
@PG     ID:samtools.1   PN:samtools     PP:samtools     VN:1.16.1       CL:samtools view -h 5781_G1_IN_merged_sorted.bam
HISEQ:1007:HGV5NBCX3:1:1114:5228:88329  99      I       288     11      50M     =       522     280     CTACTCACCATACTGTTGTTCTACCCACCATATTGAAACGCTAACAAATG      GGGGGGGIIIIIIGIIIGGGIIIIIIIIIIIIGIGGIIIGIIIIIIIIIG      AS:i:93 XS:i:92 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:1114:5228:88329  147     I       522     11      4S46M   =       288     -280    CTAGATGCACTCACATCATTATGCACGGCACTTGCCTCAGCGGTCTATAC      GGGGGGGAIGGGGGGGIGGIIIGGGGGGGGGGIGGIIGIGGGGGIGGGGG      AS:i:92 XS:i:100        XN:i:0  XM:i:0  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:2106:14749:35491 163     I       1663    1       7S43M   =       1730    124     TTTTTTTTTGATCAAATAGGTCTATAATATTAATATACATTTATATAATC      GGGGGIIII<GGGGGAGGGGGIIGIIGGGGGGGIIAGGGGGGGGAGGGGG      AS:i:86 XS:i:86 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:2216:6220:25229  163     I       1663    14      7S43M   =       1701    95      TTTTTTTTTGGTCAAAAAGGTCTATAATATTAATAAAAATTTATATAATC      GGGGGIIIGAAG.<GG..<G<AAA.<A.<.G.<.<.<..<GGA#######      AS:i:64 XS:i:57 XN:i:0  XM:i:4  XO:i:0  XG:i:0  NM:i:4
HISEQ:1007:HGV5NBCX3:1:2114:12240:15164 163     I       1673    11      50M     =       1867    244     AGGTCTATAATATTAATATACATTTATATAATCTACGGTATTTATATCAT      GAAGGIIIIGIIIIIGIIGIIIIIIGIIIGGGIGIIGGGIIGIIIIIIGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2216:6220:25229  83      I       1701    14      49M1S   =       1663    -95     TAATCTACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTATTTTATG      GGGGIIIIIGGIGGIIIGIGGAIGIGIIIIIIIGGIIIGIIGGGGGGAGG      AS:i:98 XS:i:90 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:1113:16755:16657 81      I       1702    11      49M1S   XIV     415061  0       AATCTACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTTTTTTTTTG      IGG<GGGAAAAIGGAG<G.<<...<.<<...<..IIIIIGA.IGGG.GG<      AS:i:88 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:4
HISEQ:1007:HGV5NBCX3:1:2112:18005:41299 163     I       1707    11      50M     =       2074    417     ACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTATTTTATTTTGTTC      AAAAGAGGGIIIGGGGGGGIGIGGIIGGIIGGGGGGGGGGGGGGGIGIIG      AS:i:100        XS:i:92 XN:i:0  XM:i:0  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:2206:19349:73834 163     I       1707    33      50M     =       1842    185     ACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTATTTTATTTTGTTC      GGGGGIIIIIIGIIGGGGIIIIGIGIIIIIIIGGIIIIIIIIIGIIGIIG      AS:i:100        XS:i:70 XN:i:0  XM:i:0  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:2113:2817:14137  163     I       1730    14      50M     =       1859    179     AAGAAGTTTTTTTATTTTATTTTGTTCGTTAATTTTCAATGTCTATGGAA      GGAGGIIIIIIIIIIIIIIGIIIIIIIGIIIGGGGGIGGIIIIIIIIGII      AS:i:85 XS:i:93 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2
HISEQ:1007:HGV5NBCX3:1:2106:14749:35491 83      I       1730    1       49M1S   =       1663    -124    AAGTAGTTTTTTTATTTTATTTTGTTCTTTAATTTTTAATGTCTATGGAG      GIGGGIIGIIIIIIIIIIIIIIIIIGIIGGGGGIIIIIIIIIIIIGGGGG      AS:i:74 XS:i:82 XN:i:0  XM:i:3  XO:i:0  XG:i:0  NM:i:3
HISEQ:1007:HGV5NBCX3:1:2102:3746:13152  163     I       1744    1       1S49M   =       1940    247     TTTTTTTTTTGTTATTTAATTTTAAAGTTCTATGTAAGCCCGATCGTAAA      G#################################################      AS:i:66 XS:i:66 XN:i:0  XM:i:8  XO:i:0  XG:i:0  NM:i:8
HISEQ:1007:HGV5NBCX3:1:1204:4745:12269  163     I       1837    1       50M     =       1942    155     GGATAGAGCACTGGAGATGGCTGGCTTTAATCTGCTGGAGTACCATGGAA      AGGGAGGIGGGIGIGIGIIGIIGGGAGGIIIIGGGGIGIIIGIIIIIIII      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2206:19349:73834 83      I       1842    33      50M     =       1707    -185    GAGCACTGGAGATGGCTGGCTTTAATCTGCTGGAGTACCATGGAACACCG      IIIIGGIIIIIIGIGIGIIIIIIIIIIIGIIGIIIIIGGIIIIGGGGGGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2204:14658:11161 163     I       1849    1       50M     =       1945    146     GGAGATGGCTGGCTTTAATCTGCTGGAGTACCATGGAACACCGGTGATCA      GAGAGGGGIIA.GGGGIGIGGIGGGGGGGGGGGGGGGGGGGGGGAGGGIG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2113:2817:14137  83      I       1859    14      49M1S   =       1730    -179    GGCTTTAATCTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCAG      IIIGIIIIIIGIGAGIIIIIIIIIGIIIIIIIIIIIIIIIIIIGIGGGGG      AS:i:98 XS:i:98 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:2114:12240:15164 83      I       1867    11      50M     =       1673    -244    TCTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCACTTGGTCTG      GIIIIIGIGGIIIIIIGIIGIIIGIIIGIIIIIIGIGIIIIIIGGAGGGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:1115:5126:26256  163     I       1868    1       50M     =       2190    372     CTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCACTTGGTCTGG      GGGGGGIIIIIIIIIIIIGIIIIIGIGIIGIIIIIIGIIIGIIGGGIIGI      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2116:5000:45130  163     I       1868    11      50M     =       2190    372     CTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCACTTGGTCTGG      AAGGGIIIGGGIIIIIGIIIIIIIIIIIIIIIIIIIIIIGIIIIIIIIII      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2102:3746:13152  83      I       1940    1       48M2S   =       1744    -247    GTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGCG      GG<.G<A.GGGGAAGGAGGA<<.<<.IGGGA<...AG<<...GGGAAAGG      AS:i:96 XS:i:96 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:1204:4745:12269  83      I       1942    1       49M1S   =       1837    -155    GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG      GGIGG.GIIGGAGIGGGGG<<GGAIGGGGGGGAGGAGAGGGAGGGAGGGG      AS:i:98 XS:i:98 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:2204:14658:11161 83      I       1945    1       50M     =       1849    -146    GTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTTCAG      GGGGGGIIGGGGGGGGGGGGGGGGGIGGIIIGGGGIIIGGIIGGGGGGGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2112:18005:41299 83      I       2074    11      50M     =       1707    -417    GTTGACTCTTTCGTCAGATTGAGCTAGAGTGGTGGTTGCGGAAGCAGTAG      IGGIIIIIIIGIGGIGIGGIIGIIIIGGIIIIIIIIIIIIIIIIIGGGGG      AS:i:92 XS:i:100        XN:i:0  XM:i:1  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:1114:8312:7074   163     I       2102    11      1S48M1S =       2335    284     GGTGGTGGTTGCAGAAGCAGTAGCAGCGATCGCAGCGACCCCAGACGCGC      .GGAG<..<GG#######################################      AS:i:80 XS:i:72 XN:i:0  XM:i:4  XO:i:0  XG:i:0  NM:i:4
HISEQ:1007:HGV5NBCX3:1:1115:5126:26256  83      I       2190    1       49M1S   =       1868    -372    GTGCTGATATAAGCTTAACAGGAAAGAAAAGAATAAAGACATATTCTCAG      GIIIIIIIGGGGIIIGIIIGIIIIGIIIIIIIIIIGIIIIIIIIIGGGGG      AS:i:90 XS:i:98 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:2116:5000:45130  83      I       2190    11      49M1S   =       1868    -372    GTGCTGATATAAGCTTAACAGGAAAGAAAAGAATAAAGACATATTCTCAG      IGIIIIGIIGGGIIIIIIIIIIIIIIGIIIIIIIGIGIIIIIGIIGGGGG      AS:i:91 XS:i:98 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:2209:15800:37695 163     I       2276    41      47M3S   =       2425    199     CCCTCATGGGTTGTTGCTATTTAAACGATCGCTGACTGGCACCAGTTTCT      GGGGGIIIIIIIIIIIIIIIGIIIIIIIGIIIIIIIIGIIIIIIIIIIGG      AS:i:94 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:4
HISEQ:1007:HGV5NBCX3:1:1203:21227:75075 163     I       2291    41      49M1S   =       2527    279     GCTATTTAAACGATCGCTGACTGGCACCAGTTTCTCATCACATATTCTCC      GGGAGIGGGGIIIGGIGIIIIIIIGIGIGGGGIGGIIGGIIIGGGGAGGG      AS:i:82 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:3
HISEQ:1007:HGV5NBCX3:1:1114:8312:7074   83      I       2335    11      47M3S   =       2102    -284    TTCTCCATATCTCATCTTTCACACAATCTCATTATCTCTATGGAGATCAG      ####G.GA<...A.IGIIGGG<<...<.GG.GAGG<..GG.G.<...<..      AS:i:89 XS:i:94 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:2209:15800:37695 83      I       2425    41      50M     =       2276    -199    ATGTGGAGTATTGTTTTATGGCACTCATGTGTATTCGTATGCGCAGAATG      IIIIIIGIIIIIIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIGGGGGG      AS:i:76 XS:i:100        XN:i:0  XM:i:3  XO:i:0  XG:i:0
```

We won't find any multimappers in here because, by default, `Bowtie 2` "\[looks\] for multiple alignments, \[reports\] best, with MAPQ"
- To see see what reads are multimappers, we have to include wither the the flag `-k <all>` or `-a/--all`
```txt
      -k <int>  report up to <int> alns per read; MAPQ not meaningful
-a/--all        report all alignments; very slow, MAPQ not meaningful
```

# 2022-1109

# Miscellaneous
## [Figure out where to put this](#figure-out-where-to-put-this)
### [Brief discussion with Toshi about yeast blacklists](#brief-discussion-with-toshi-about-yeast-blacklists)
- He's not aware of any such blacklists for yeast
- He suggested to reach out to Christine and Alison
- He suggested that we could put together a blacklist from ChIP-seq input data
    + `#IDEA` Identify binding regions (which should be non-specific since these are input data) present in multiple or all samples
- `#TODO` Skim over the blacklist paper from Anshul Kundaje to understand precisely what the blacklist describes
    + e.g., `#QUESTION` Is it non-specific binding, and thus noise, because of something related to the reference, or is it because of something related to the wet-work behind the NGS data?
    + `#TODO` I think it is reference-related, but want to confirm
- `#TODO` Look into [the one example of the use of a yeast blacklist I found in the literature]((https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8407396/))
- Also, discussed the possibility of doing bench-work in the future
    + Mentioned how, after tackling the `Trinity` tasks, it'd be a fun and interesting bioinformatics experiment to compare yeast G2/M MicroC data (from the Koshland Lab) to the yeast Q MicroC data (from this lab)
    + From there, based on what we find, we could consider to design and perform wet experiments
<br />
<br />

## [Google searches and websites to follow up on](#google-searches-and-websites-to-follow-up-on)
- ["add flag to multimapper"](https://www.google.com/search?q=add+flag+to+multimappers&oq=add+flag+to+multimappers&aqs=chrome..69i57j33i160l2.3704j0j7&sourceid=chrome&ie=UTF-8)
    + ["SAM FLAG for primary alignments, secondary alignments, and what's their relationships to uniqueness of mapping"](https://www.biostars.org/p/206396/)
- ["use star with trinity"](https://www.google.com/search?q=use+star+with+trinity&oq=use+star+with+trinity&aqs=chrome..69i57j33i160l2.2936j0j7&sourceid=chrome&ie=UTF-8)
- ["ty elements cerevisiae"](https://www.google.com/search?q=ty+elements+cerevisiae&ei=hRJsY_jDKfDL0PEPy9CMqAE&ved=0ahUKEwi4moHt_KH7AhXwJTQIHUsoAxUQ4dUDCBA&uact=5&oq=ty+elements+cerevisiae&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQogQyBQgAEKIEMgUIABCiBDIFCAAQogQ6CggAEEcQ1gQQsANKBAhNGAFKBAhBGABKBAhGGABQ9RtYpR1g1yFoAXABeACAAUSIAYYBkgEBMpgBAKABAcgBAsABAQ&sclient=gws-wiz-serp)
    + [Ty Elements of the Yeast *Saccharomyces Cerevisiae*](https://www.tandfonline.com/doi/abs/10.1080/13102818.2005.10817272)
    + [Transposable elements in yeasts](https://pubmed.ncbi.nlm.nih.gov/21819950/)
- ["repeatmasker yeast"](https://www.google.com/search?q=repeatmasker+yeast&oq=repeatmasker+yeast&aqs=chrome..69i57j0i546l5.5324j0j7&sourceid=chrome&ie=UTF-8)
    + [RepeatMasker for Fungi](https://www.biostars.org/p/171368/)
- [Dfam](https://www.dfam.org/home)
<br />
<br />

## [Next steps](#next-steps)
`( Y ) #MONDAY` Pick up with fine-tuning the initial call to `Bowtie2`: *Shifting focus to STAR, a splice-aware aligner*  

`( Y ) #TUESDAY` Use the combined-reference .fasta, .gtf, and genome index files to try aligning one of the (symlinked) .fastq files using the parameters for *S. cerevisiae* you found on the `STAR` Google group  
- First, sus out and describe the parameters (for example, are all of them needed, are the values appropriate, etc.?)
- Once this is done, move on to "filtering" the bam file, including isolating unmapped reads, and stripping away chromosomes that are not needed  

`( Y ) #TUESDAY` Do the same with `Bowtie 2`  

`( Y ) #WEDNESDAT` Read over and take notes on the qualifying exam and research update documents sent by Alison  

`(...) #WEDNESDAY` Pick up with the assessment of the Bowtie 2 alignment test #2 experiment: Need to know, from the alignments, what reads are unimappers, multimappers, etc.  

`(...) #WEDNESDAY` Adjust `STAR` parameters based on the repetitive-element work you did in 2020 (bring your laptop to work tomorrow); for now, move on to `Bowtie 2` work  

`(   ) #WEDNESDAY` Read and take notes on [this paper sent by Alison](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-016-1406-x#Sec2), which makes use of `Trinity` for transcriptome assembly  

`(   ) #WEDNESDAY` Continue to read and take notes on [Best Practices for De Novo Transcriptome Assembly with Trinity](https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html)  

`(   ) #SOMETIME` Put together a "blacklist" for *S. cerevisiae*  
- [Google search for "download bed file for telomere coordinates"](https://www.google.com/search?q=download+bed+file+for+telomere+coordinates&ei=89lrY6zaH8aO0PEPrsGseA&oq=download+telomere+coordinates&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAxgAMgsIIRDDBBCgARCLAzoKCAAQRxDWBBCwAzoNCCEQwwQQChCgARCLA0oECE0YAUoECEEYAEoECEYYAFClF1i0I2DnM2gBcAF4AIABS4gBzAOSAQE4mAEAoAEByAEIuAEDwAEB&sclient=gws-wiz-serp)
- Christine has `.bed` files in her shared folder
    + It seems she got them from the UCSC table browser
    + `#TODO` Look into the possibility of getting them from Ensembl
- Already have locations of rDNA from having run `picardmetrics`

Sent message to Trinity Google group (see message above in a "Thoughts on..." post `#TODO` Organize all of this)
Until I hear back, or if I don't hear back, go ahead and move forward with altered STAR parameters (so that we don't have flags in high hundreds and, instead, get readouts more similar to what we see with Bowtie 2 today (2022-1109))
After that's done, compare the kinds of alignments we're getting between the two aligners and then pick one for subsequent use
After that, move on to writing up code for filtering by chromosomes (build on/expand what you were working on before): Ultimately, we'll start by working with VII of S. cerevisiae
From there, move on to reading and taking notes on the Harvard "best practices" document, which will inform you of the steps you need to take next
<br />
<br />
