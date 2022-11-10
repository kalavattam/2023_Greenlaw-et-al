
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

Make a new `.fasta` file with *chr*-styled names:
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
