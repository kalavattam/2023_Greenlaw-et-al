
# `work_PASA_parallelized-run_param_gene-overlap.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc)
1. [Set up arrays for genome-free and -guided `.fasta`s](#set-up-arrays-for-genome-free-and--guided-fastas)
	1. [Run an `echo` test for the arrays](#run-an-echo-test-for-the-arrays)
1. [Set up names of experiment directories, files, etc.](#set-up-names-of-experiment-directories-files-etc)
1. [Run `PASA` precursor commands](#run-pasa-precursor-commands)
	1. [Get a `.gff3` ready for precursor commands, calling `Launch_PASA_pipeline.pl`, etc.](#get-a-gff3-ready-for-precursor-commands-calling-launch_pasa_pipelinepl-etc)
	1. [Set up and run loop for precursor commands](#set-up-and-run-loop-for-precursor-commands)
	1. [Results of loop for precursor commands](#results-of-loop-for-precursor-commands)
1. [Run `PASA` `Launch_PASA_pipeline.pl`](#run-pasa-launch_pasa_pipelinepl)
	1. [Set up a job submission script for `PASA` `Launch_PASA_pipeline.pl`](#set-up-a-job-submission-script-for-pasa-launch_pasa_pipelinepl)
	1. [Run the job submission script for `PASA` `Launch_PASA_pipeline.pl`](#run-the-job-submission-script-for-pasa-launch_pasa_pipelinepl)
1. [Run `PASA` `build_comprehensive_transcriptome.dbi`](#run-pasa-build_comprehensive_transcriptomedbi)
	1. [Set up a job submission script for `PASA` `build_comprehensive_transcriptome.dbi`](#set-up-a-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi)
	1. [Run the job submission script for `PASA` `build_comprehensive_transcriptome.dbi`](#run-the-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="grab-a-node-get-to-the-right-directory-etc"></a>
## Grab a node, get to the right directory, etc.
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults

mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd

Trinity_env
ml Singularity
```
</details>
<br />
<br />

<a id="set-up-arrays-for-genome-free-and--guided-fastas"></a>
## Set up arrays for genome-free and -guided `.fasta`s
```bash 
#!/bin/bash
#DONTRUN

#  Create an array of files of interest, including relative paths -------------
#  "Partially processed" genome-guided .fastas ------------
unset GG_proc
typeset -a GG_proc
while IFS=" " read -r -d $'\0'; do
    GG_proc+=( "${REPLY}" )
done < <(\
    find "files_Trinity_genome-guided/files_processed" \
        -type f \
        -name "*.Trinity-GG.fasta" \
        -print0 |
            sort -z
)
# echoTest "${GG_proc[@]}"

GF_proc="files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta"
unset T_proc
typeset -A T_proc
for i in "${GG_proc[@]}"; do
    # echo "Working with ${i}..."
    T_proc["${i}"]+="${GF_proc}"
    echo ""
done
# echoTest "${!T_proc[@]}"
# echoTest "${T_proc[@]}"


#  "Fully processed" genome-guided .fastas ----------------
unset GG_full
typeset -a GG_full
while IFS=" " read -r -d $'\0'; do
    GG_full+=( "${REPLY}" )
done < <(\
    find "files_Trinity_genome-guided/files_processed-full" \
        -type f \
        -name "*.Trinity-GG.fasta" \
        -print0 |
            sort -z
)
# echoTest "${GG_full[@]}"

GF_full="files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta"
unset T_full
typeset -A T_full
for i in "${GG_full[@]}"; do
    # echo "Working with ${i}..."
    T_full["${i}"]+="${GF_full}"
    echo ""
done
# echoTest "${!T_full[@]}"
# echoTest "${T_full[@]}"


#  "Unprocessed" genome-guided .fastas --------------------
unset GG_un
typeset -a GG_un
while IFS=" " read -r -d $'\0'; do
    GG_un+=( "${REPLY}" )
done < <(\
    find "files_Trinity_genome-guided/files_unprocessed" \
        -type f \
        -name "*.Trinity-GG.fasta" \
        -print0 |
            sort -z
)
# echoTest "${GG_un[@]}"

GF_un="files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta"
unset T_un
typeset -A T_un
for i in "${GG_un[@]}"; do
    T_un["${i}"]+="${GF_un}"
    echo ""
done
# echoTest "${!T_un[@]}"
# echoTest "${T_un[@]}"

#IMPORTANT stackoverflow.com/questions/29161323/how-to-keep-associative-array-order
```

<a id="run-an-echo-test-for-the-arrays"></a>
### Run an `echo` test for the arrays
<details>
<summary><i>Set up and results of message test</i></summary>

```bash
#  How do the assignments look? -----------------------------------------------
message="""
#  'Partially processed' genome-guided .fastas ------------
#+ Keys (genome-guided Trinity files)
$(echoTest "${!T_proc[@]}")

#+ Values (genome-free Trinity files)
$(echoTest "${T_proc[@]}")


#  'Fully processed' genome-guided .fastas ----------------
#+ Keys (genome-guided Trinity files)
$(echoTest "${!T_full[@]}")

#+ Values (genome-free Trinity files)
$(echoTest "${T_full[@]}")


#  'Unprocessed' genome-guided .fastas --------------------
#+ Keys (genome-guided Trinity files)
$(echoTest "${!T_un[@]}")

#+ Values (genome-free Trinity files)
$(echoTest "${T_un[@]}")
"""
echo "${message}"
```

```txt
#  'Partially processed' genome-guided .fastas ------------
#+ Keys (genome-guided Trinity files)
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta

#+ Values (genome-free Trinity files)
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta


#  'Fully processed' genome-guided .fastas ----------------
#+ Keys (genome-guided Trinity files)
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta

#+ Values (genome-free Trinity files)
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta


#  'Unprocessed' genome-guided .fastas --------------------
#+ Keys (genome-guided Trinity files)
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta

#+ Values (genome-free Trinity files)
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
```
</details>
<br />
<br />

<a id="set-up-names-of-experiment-directories-files-etc"></a>
## Set up names of experiment directories, files, etc.
```bash
#!/bin/bash
#DONTRUN #CONTINUE


#  Establish functions for setting up names of directories, files, etc. -------
name_tx_db() {
    # This function parses pertinent path and filename info to determine the
    # name of a transcriptome database; it's highly dependent on the context of
    # these particular sets of experiments
    #
    # :param 1: associate array "keys" <e.g., "${!T_full[*]}">
    # :param 2: number of key to work with <int 1-3; e.g., "3">
    echo "${1}" \
        | cut -d ' ' -f "${2}" \
        | cut -d '/' -f 3- \
        | rev \
        | cut -b 18- \
        | rev
}


get_key_or_value() {
	#TODO Documentation
	echo "${1}" | cut -d ' ' -f "${2}"
}


get_GG_or_GF() {
	#TODO Documentation
	echo "${1}" | cut -d ',' -f "${2}"
}


#  Make an associative array that connects the information for... -------------
#+ Trinity-GF .fastas, Trinity-GG .fastas, and PASA databases
unset info_tx_db
typeset -A info_tx_db
for i in "T_proc" "T_full" "T_un"; do
	for j in 1 2 3; do
		# i="T_proc"
		# j=1
		echo "#  -------------------------------------"
		old_key="get_key_or_value \"\${!${i}[*]}\" ${j}"
		echo "${old_key}"
		eval "${old_key}"
		echo ""

		old_value="get_key_or_value \"\${${i}[*]}\" ${j}"
		echo "${old_value}"
		eval "${old_value}"
		echo ""

		name_of_db="name_tx_db \"\${!${i}[*]}\" ${j}"
		echo "${name_of_db}"
		eval "${name_of_db}"
		echo ""
		
		new_key="$(echo "$(eval "${name_of_db}")")"
		new_val="$(echo "$(eval "${old_key}"),$(eval "${old_value}")")"
		info_tx_db["${new_key}"]="${new_val}"
		echo ""
	done
done

#  Make sure everything is correctly associated
for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
done
```

<details>
<summary><i>Results of for-loop echo test</i></summary>

`for i in "${!info_tx_db[@]}"; do ...`
```txt
#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
```
</details>
<br />
<br />

<a id="run-pasa-precursor-commands"></a>
## Run `PASA` precursor commands
<a id="get-a-gff3-ready-for-precursor-commands-calling-launch_pasa_pipelinepl-etc"></a>
### Get a `.gff3` ready for precursor commands, calling `Launch_PASA_pipeline.pl`, etc.
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/genomes/sacCer3/Ensembl/108/gff3" || \
	echo "cd'ing failed; check on this"

#TODO Test that *.gff3.gz is present as well
if [[ ! -f "Saccharomyces_cerevisiae.R64-1-1.108.gff3" ]]; then
	zcat Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz \
		> Saccharomyces_cerevisiae.R64-1-1.108.gff3
fi
```

<a id="set-up-and-run-loop-for-precursor-commands"></a>
### Set up and run loop for precursor commands
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Be in the main work directory
if [[ \
	"$(pwd)" != "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
]]; then
	mwd
fi

#LOOP
count=1
for i in "${!info_tx_db[@]}"; do
	echo "#  ========================================================================"
	echo "#  Working with iteration ### ${count} ### ======================================="
	echo "#  ========================================================================"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  mkdir the experiment directory -----------------------------------------
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  mkdir the experiment directory -----------------------------------------"
	echo "#  ------------------------------------------------------------------------"
	[[ -d "files_PASA_param_gene-overlap/${i}" ]] \
		|| mkdir -p "files_PASA_param_gene-overlap/${i}"
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  cat the .fastas from Trinity genome-free and genome-guided approaches --
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  cat the .fastas from Trinity genome-free and genome-guided approaches --"
	echo "#  ------------------------------------------------------------------------"
	cmd="cat \
	$(get_GG_or_GF "${info_tx_db["${i}"]}" 1) \
	$(get_GG_or_GF "${info_tx_db["${i}"]}" 2) \
	> files_PASA_param_gene-overlap/${i}/${i}.transcripts.fasta"
	echo "${cmd}"
	eval "${cmd}"
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  Create .txts for Trinity genome-free transcript accessions -------------
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  Create .txts for Trinity genome-free transcript accessions -------------"
	echo "#  ------------------------------------------------------------------------"
	parallel --header : --colsep " " -k -j 1 echo \
	"singularity run \
	    --no-home \
	    --bind {d_exp} \
	    ~/singularity-docker-etc/PASA.sif \
	        ${PASAHOME}/misc_utilities/accession_extractor.pl \
	            \< {genome_free_fasta} \
	            \> {genome_free_accessions}" \
	::: d_exp "$(pwd)" \
	::: genome_free_fasta "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" \
	:::+ genome_free_accessions "files_PASA_param_gene-overlap/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
	
	parallel --header : --colsep " " -k -j 1 \
	"singularity run \
	    --no-home \
	    --bind {d_exp} \
	    ~/singularity-docker-etc/PASA.sif \
	        ${PASAHOME}/misc_utilities/accession_extractor.pl \
	            < {genome_free_fasta} \
	            > {genome_free_accessions}" \
	::: d_exp "$(pwd)" \
	::: genome_free_fasta "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" \
	:::+ genome_free_accessions "files_PASA_param_gene-overlap/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  Clean the transcript sequences -----------------------------------------
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  Clean the transcript sequences -----------------------------------------"
	echo "#  ------------------------------------------------------------------------"
	parallel --header : --colsep " " -k -j 1 echo \
	"singularity run \
	    --no-home \
	    --bind {d_exp} \
	    --bind {d_scr} \
	    ~/singularity-docker-etc/PASA.sif \
	        ${PASAHOME}/bin/seqclean \
	            {genome_combined}" \
	::: d_exp "$(pwd)" \
	::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
	::: genome_combined "files_PASA_param_gene-overlap/${i}/${i}.transcripts.fasta"
	
	cd "files_PASA_param_gene-overlap/${i}"
	parallel --header : --colsep " " -k -j 1 \
	"singularity run \
	    --no-home \
	    --bind {d_exp} \
	    --bind {d_scr} \
	    ~/singularity-docker-etc/PASA.sif \
	        ${PASAHOME}/bin/seqclean \
	            {genome_combined}" \
	::: d_exp "$(pwd)" \
	::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
	::: genome_combined "${i}.transcripts.fasta"
	cd -
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  Write .config files for the calls to PASA ------------------------------
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  Write .config files for the calls to PASA ------------------------------"
	echo "#  ------------------------------------------------------------------------"
cat << align_assembly > "./files_PASA_param_gene-overlap/${i}/${i}.align_assembly.config"
## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/${i}/${i}.pasa.sqlite


#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter" 
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50
align_assembly
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --"
	echo "#  ------------------------------------------------------------------------"
	fasta_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
	fasta_SC_sym="$(basename ${fasta_SC_orig})"
	cmd="ln -s ${fasta_SC_orig} ${fasta_SC_sym}"
	cd "files_PASA_param_gene-overlap/${i}"
	# unlink "${fasta_SC_sym}"
	echo "${cmd}"
	eval "${cmd}"
	cd -
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---"
	echo "#  ------------------------------------------------------------------------"
	gff3_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3"
	gff3_SC_sym="$(basename ${gff3_SC_orig})"
	cmd="ln -s ${gff3_SC_orig} ${gff3_SC_sym}"
	cd "files_PASA_param_gene-overlap/${i}"
	# unlink "${gff3_SC_sym}"
	echo "${cmd}"
	eval "${cmd}"
	cd -
	echo "" && echo ""


	#  ------------------------------------------------------------------------
	#  Print the contents of the given PASA experiment directory --------------
	#  ------------------------------------------------------------------------
	echo "#  ------------------------------------------------------------------------"
	echo "#  Print the contents of the given PASA experiment directory --------------"
	echo "#  ------------------------------------------------------------------------"	
	., "./files_PASA_param_gene-overlap/${i}"
	echo "" && echo ""
	echo "" && echo ""

	(( count++ ))
done
```

<a id="results-of-loop-for-precursor-commands"></a>
### Results of loop for precursor commands
<details>
<summary><i>Click to view</i></summary>

```txt
#  ========================================================================
#  Working with iteration ### 1 ### =======================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30388
-----------------------------------
                   valid:     30387  (2822 trimmed)
                 trashed:         1
**************************************************
----= Trashing summary =------
                by 'dust':        1
------------------------------
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 71M
drwxrws--- 3 kalavatt 1.1K Dec 13 07:48 ./
drwxrws--- 3 kalavatt   83 Dec 13 07:48 ../
drwxr-s--- 2 kalavatt 3.5K Dec 13 07:48 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:48 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.4K Dec 13 07:48 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:48 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:48 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.7K Dec 13 07:48 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw---- 1 kalavatt  921 Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw---- 1 kalavatt  27M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  27M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 1.9M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 400K Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 2 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30979
-----------------------------------
                   valid:     30978  (2863 trimmed)
                 trashed:         1
**************************************************
----= Trashing summary =------
                by 'dust':        1
------------------------------
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 82M
drwxrws--- 3 kalavatt 1.1K Dec 13 07:48 ./
drwxrws--- 4 kalavatt  223 Dec 13 07:48 ../
drwxr-s--- 2 kalavatt 3.5K Dec 13 07:48 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:48 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.4K Dec 13 07:48 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:48 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:48 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.7K Dec 13 07:48 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw---- 1 kalavatt  923 Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw---- 1 kalavatt  28M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  28M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 1.9M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 400K Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 3 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30158
-----------------------------------
                   valid:     30158  (3627 trimmed)
                 trashed:         0
**************************************************
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 51M
drwxrws--- 3 kalavatt 1.1K Dec 13 07:49 ./
drwxrws--- 5 kalavatt  304 Dec 13 07:48 ../
drwxr-s--- 2 kalavatt 3.4K Dec 13 07:49 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:49 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.3K Dec 13 07:49 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:49 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:49 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.6K Dec 13 07:49 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw---- 1 kalavatt  917 Dec 13 07:49 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw---- 1 kalavatt  26M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.6M Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  27M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 1.9M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 401K Dec 13 07:48 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 4 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta     files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30474
-----------------------------------
                   valid:     30474  (3657 trimmed)
                 trashed:         0
**************************************************
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 51M
drwxrws--- 3 kalavatt  974 Dec 13 07:49 ./
drwxrws--- 6 kalavatt  377 Dec 13 07:49 ../
drwxr-s--- 2 kalavatt 3.2K Dec 13 07:49 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:49 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.1K Dec 13 07:49 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:49 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:49 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.5K Dec 13 07:49 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw---- 1 kalavatt  901 Dec 13 07:49 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.align_assembly.config
-rw-rw---- 1 kalavatt  27M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  27M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 1.9M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 406K Dec 13 07:49 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 5 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30659
-----------------------------------
                   valid:     30659  (3702 trimmed)
                 trashed:         0
**************************************************
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 52M
drwxrws--- 3 kalavatt 1.1K Dec 13 07:50 ./
drwxrws--- 7 kalavatt  459 Dec 13 07:49 ../
drwxr-s--- 2 kalavatt 3.5K Dec 13 07:50 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:50 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.3K Dec 13 07:50 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:50 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:50 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.6K Dec 13 07:50 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw---- 1 kalavatt  919 Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw---- 1 kalavatt  27M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 13 07:49 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  27M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 1.9M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 401K Dec 13 07:49 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 6 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30624
-----------------------------------
                   valid:     30624  (3723 trimmed)
                 trashed:         0
**************************************************
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 72M
drwxrws--- 3 kalavatt 1.1K Dec 13 07:50 ./
drwxrws--- 8 kalavatt  542 Dec 13 07:50 ../
drwxr-s--- 2 kalavatt 3.5K Dec 13 07:50 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:50 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.4K Dec 13 07:50 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:50 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:50 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.6K Dec 13 07:50 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw---- 1 kalavatt  921 Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw---- 1 kalavatt  27M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  28M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 1.9M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 401K Dec 13 07:50 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 7 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta     files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     31008
-----------------------------------
                   valid:     31008  (3743 trimmed)
                 trashed:         0
**************************************************
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 54M
drwxrws--- 3 kalavatt  988 Dec 13 07:51 ./
drwxrws--- 9 kalavatt  617 Dec 13 07:50 ../
drwxr-s--- 2 kalavatt 3.3K Dec 13 07:51 cleaning_1/
-rw-rw-r-- 1 kalavatt  11K Dec 13 07:51 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw-r-- 1 kalavatt 3.2K Dec 13 07:51 outparts_cln.sort
lrwxrwxrwx 1 kalavatt   89 Dec 13 07:51 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx 1 kalavatt  109 Dec 13 07:51 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r-- 1 kalavatt 1.6K Dec 13 07:51 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw---- 1 kalavatt  905 Dec 13 07:51 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.align_assembly.config
-rw-rw---- 1 kalavatt  28M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 13 07:50 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  28M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean
-rw-rw-r-- 1 kalavatt 2.0M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 406K Dec 13 07:50 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 8 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     31067
-----------------------------------
                   valid:     31066  (2881 trimmed)
                 trashed:         1
**************************************************
----= Trashing summary =------
                by 'dust':        1
------------------------------
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 54M
drwxrws---  3 kalavatt 1.1K Dec 13 07:51 ./
drwxrws--- 10 kalavatt  702 Dec 13 07:51 ../
drwxr-s---  2 kalavatt 3.7K Dec 13 07:51 cleaning_1/
-rw-rw-r--  1 kalavatt  12K Dec 13 07:51 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.5K Dec 13 07:51 outparts_cln.sort
lrwxrwxrwx  1 kalavatt   89 Dec 13 07:51 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx  1 kalavatt  109 Dec 13 07:51 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 13 07:51 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  925 Dec 13 07:51 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 13 07:51 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions




#  ========================================================================
#  Working with iteration ### 9 ### ================================
#  ========================================================================
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local


#  ------------------------------------------------------------------------
#  mkdir the experiment directory -----------------------------------------
#  ------------------------------------------------------------------------
mkdir: created directory 'files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local'


#  ------------------------------------------------------------------------
#  cat the .fastas from Trinity genome-free and genome-guided approaches --
#  ------------------------------------------------------------------------
cat     files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta     files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta     > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta


#  ------------------------------------------------------------------------
#  Create .txts for Trinity genome-free transcript accessions -------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta > files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


#  ------------------------------------------------------------------------
#  Clean the transcript sequences -----------------------------------------
#  ------------------------------------------------------------------------
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
Collecting cleaning reports

**************************************************
Sequences analyzed:     30996
-----------------------------------
                   valid:     30996  (3720 trimmed)
                 trashed:         0
**************************************************
Output file containing only valid and trimmed sequences: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean
For trimming and trashing details see cleaning report  : trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cln
--------------------------------------------------
seqclean (trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta) finished on machine
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local, without a detectable error.
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Write .config files for the calls to PASA ------------------------------
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---
#  ------------------------------------------------------------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3 Saccharomyces_cerevisiae.R64-1-1.108.gff3
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  ------------------------------------------------------------------------
#  Print the contents of the given PASA experiment directory --------------
#  ------------------------------------------------------------------------
total 54M
drwxrws---  3 kalavatt  981 Dec 13 07:52 ./
drwxrws--- 11 kalavatt  776 Dec 13 07:51 ../
drwxr-s---  2 kalavatt 3.2K Dec 13 07:52 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 13 07:52 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 13 07:52 outparts_cln.sort
lrwxrwxrwx  1 kalavatt   89 Dec 13 07:52 Saccharomyces_cerevisiae.R64-1-1.108.gff3 -> /home/kalavatt/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3
lrwxrwxrwx  1 kalavatt  109 Dec 13 07:52 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 13 07:52 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  903 Dec 13 07:52 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 13 07:51 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 13 07:52 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 13 07:52 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 13 07:51 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions




```
</details>
<br />
<br />

<a id="run-pasa-launch_pasa_pipelinepl"></a>
## Run `PASA` `Launch_PASA_pipeline.pl`
<a id="set-up-a-job-submission-script-for-pasa-launch_pasa_pipelinepl"></a>
### Set up a job submission script for `PASA` `Launch_PASA_pipeline.pl`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name="submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.sh"
threads=8

if [[ -f "./sh_err_out/${s_name}" ]]; then
        rm "./sh_err_out/${s_name}"
fi
cat << script > "./sh_err_out/${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name%.sh}.%J.out.txt

#  ${s_name}
#  KA
#  $(date '+%Y-%m%d')

str_experiment="\${1}"
str_accessions="\${2}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "files_PASA_param_gene-overlap/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \\
	--no-home \\
	--bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
	--bind "\$(pwd)" \\
	--bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
	"\${HOME}/singularity-docker-etc/PASA.sif" \\
		"\${PASAHOME}/Launch_PASA_pipeline.pl" \\
			--CPU \${SLURM_CPUS_ON_NODE} \\
			-c "\${str_experiment}.align_assembly.config" \\
			-C \\
			-R \\
			-g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \\
			-I 1002 \\
			-t "\${str_experiment}.transcripts.fasta.clean" \\
			-T \\
			-u "\${str_experiment}.transcripts.fasta" \\
			--TDN "\${str_accessions}" \\
			--transcribed_is_aligned_orient \\
			--stringent_alignment_overlap 30.0 \\
			-L \\
			--annots "Saccharomyces_cerevisiae.R64-1-1.108.gff3" \\
      		--gene_overlap 50.0  \\
			--ALIGNERS "blat,gmap,minimap2" \\
				1> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stdout.log") \\
				2> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
	#  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
	if [[ -s "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
		singularity run \\
		    --no-home \\
		    --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
		    --bind "\$(pwd)" \\
		    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
		    "\${HOME}/singularity-docker-etc/PASA.sif" \\
		        \${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \\
		            -c "\${str_experiment}.align_assembly.config" \\
		            -t "\${str_experiment}.transcripts.fasta" \\
		            --prefix "\${str_experiment}.compreh_init_build" \\
		            --min_per_ID 95 \\
		            --min_per_aligned 30 \\
		                1> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stdout.log") \\
		                2> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
	else
		echo "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
		echo "Check on things..."
	fi
fi

script
# vi "sh_err_out/${s_name}"  # :q
```

<a id="run-the-job-submission-script-for-pasa-launch_pasa_pipelinepl"></a>
### Run the job submission script for `PASA` `Launch_PASA_pipeline.pl`
`#DEKHO`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Pick element 0, then try a trial job submission; cancel the job after you
#+ know it's working in order to submit jobs via looping over the full
#+ associative array

# for i in "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd"; do
for i in "${!info_tx_db[@]}"; do
	str_experiment="${i}"
	str_accessions="$(basename "$(get_GG_or_GF "${info_tx_db[${i}]}" 2)" .fasta).accessions"

	echo "#  ========================================================="
	echo "- \${str_experiment} is ${str_experiment}"
	echo "- \${str_accessions} is ${str_accessions}"
	echo ""

	sbatch "sh_err_out/${s_name}" "${str_experiment}" "${str_accessions}"
	sleep 0.25
	echo ""
	echo ""
done
```

<details>
<summary><i>Job submission messages printed to terminal</i></summary>

```txt
#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5648235


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5648236


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5648237


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5648238


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5648239


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5648240


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5648241


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5648242


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5648243


```
</details>
<br />
<br />

`#TODO` If this works, then go back and change the way we're doing things in `work_PASA_parallelized-run.md` and then rerun things there
<br />

<!-- 
<a id="run-pasa-build_comprehensive_transcriptomedbi"></a>
## Run `PASA` `build_comprehensive_transcriptome.dbi`
<a id="set-up-a-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi"></a>
### Set up a job submission script for `PASA` `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#DEKHO
s_name_next="submit_build-comprehensive-transcriptome_param_gene-overlap.sh"
threads=1

if [[ -f "./sh_err_out/${s_name_next}" ]]; then
        rm "./sh_err_out/${s_name_next}"
fi
cat << script > "./sh_err_out/${s_name_next}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name_next%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name_next%.sh}.%J.out.txt

#  ${s_name_next}
#  KA
#  $(date '+%Y-%m%d')

str_experiment="\${1}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "files_PASA_param_gene-overlap/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \\
    --no-home \\
    --bind "\${HOME}/genomes/sacCer3/Ensembl/108/DNA" \\
    --bind "\$(pwd)" \\
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
    "\${HOME}/singularity-docker-etc/PASA.sif" \\
        \${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \\
            -c "\${str_experiment}.align_assembly.config" \\
            -t "\${str_experiment}.transcripts.fasta" \\
            --prefix "\${str_experiment}.compreh_init_build" \\
            --min_per_ID 95 \\
            --min_per_aligned 30 \\
                1> >(tee -a "\${str_experiment}.stdout.log") \\
                2> >(tee -a "\${str_experiment}.stderr.log" >&2)

script
# vi "sh_err_out/${s_name_next}"  # :q
```

<a id="run-the-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi"></a>
### Run the job submission script for `PASA` `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in "${!info_tx_db[@]}"; do
	str_experiment="${i}"

	echo "#  ========================================================="
	echo "- \${str_experiment} is ${str_experiment}"
	echo ""

	echo ""sh_err_out/${s_name_next}" "${str_experiment}" "${str_accessions}""
	echo ""
	sbatch "sh_err_out/${s_name_next}" "${str_experiment}" "${str_accessions}"
	sleep 0.25
	echo ""
	echo ""
done
```
 -->
