
`#work_PASA_un_trim_trim-rcor_gene-overlap.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Grab a node, go to work directory, set up environment](#grab-a-node-go-to-work-directory-set-up-environment)
1. [Set up arrays for genome-free and -guided `.fasta`s](#set-up-arrays-for-genome-free-and--guided-fastas)
	1. [Run an `echo` test for the arrays](#run-an-echo-test-for-the-arrays)
1. [Set up associative array for experiment files, etc.](#set-up-associative-array-for-experiment-files-etc)
1. [Run `PASA` precursor commands](#run-pasa-precursor-commands)
	1. [Get a `.gff3` ready for precursor commands, calling `Launch_PASA_pipeline.pl`, etc.](#get-a-gff3-ready-for-precursor-commands-calling-launch_pasa_pipelinepl-etc)
	1. [Set up and run loop for precursor commands](#set-up-and-run-loop-for-precursor-commands)
1. [Run `PASA` `Launch_PASA_pipeline.pl`](#run-pasa-launch_pasa_pipelinepl)
	1. [Set up a job submission script for `PASA` `Launch_PASA_pipeline.pl`](#set-up-a-job-submission-script-for-pasa-launch_pasa_pipelinepl)
	1. [Run the job submission script for `PASA` `Launch_PASA_pipeline.pl`](#run-the-job-submission-script-for-pasa-launch_pasa_pipelinepl)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="grab-a-node-go-to-work-directory-set-up-environment"></a>
## Grab a node, go to work directory, set up environment
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 core, default settings

mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd

Trinity_env
ml Singularity


#  Define important variables -------------------------------------------------
value="75.0"  #CHANGEABLE #ARG  # (   ) 25.0, (   ) 33.0, (   ) 50.0 (*), (   ) 66.0, (   ) 75.0
d_exp="files_PASA_un_trim_trim-rcor_gene-overlap-${value}"  # echo "${d_exp}"
s_name="submit_PASA_un_trim_trim-rcor_gene-overlap-${value}.sh" # echo "${s_name}"
export PASAHOME="/usr/local/src/PASApipeline"
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
<br />
<br />

<a id="set-up-associative-array-for-experiment-files-etc"></a>
## Set up associative array for experiment files, etc.
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


	echo "#  ------------------------------------------------------------------------"
	echo "#  mkdir the experiment directory -----------------------------------------"
	echo "#  ------------------------------------------------------------------------"
	[[ -d "${d_exp}/${i}" ]] \
		|| mkdir -p "${d_exp}/${i}"
	echo "" && echo ""


	echo "#  ------------------------------------------------------------------------"
	echo "#  cat the .fastas from Trinity genome-free and genome-guided approaches --"
	echo "#  ------------------------------------------------------------------------"
	cmd="cat \
	$(get_GG_or_GF "${info_tx_db["${i}"]}" 1) \
	$(get_GG_or_GF "${info_tx_db["${i}"]}" 2) \
	> ${d_exp}/${i}/${i}.transcripts.fasta"
	echo "${cmd}"
	eval "${cmd}"
	echo "" && echo ""


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
	:::+ genome_free_accessions "${d_exp}/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
	
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
	:::+ genome_free_accessions "${d_exp}/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
	echo "" && echo ""


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
	::: genome_combined "${d_exp}/${i}/${i}.transcripts.fasta"
	
	cd "${d_exp}/${i}"
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


	echo "#  ------------------------------------------------------------------------"
	echo "#  Write .config files for the calls to PASA ------------------------------"
	echo "#  ------------------------------------------------------------------------"
cat << align_assembly > "./${d_exp}/${i}/${i}.align_assembly.config"
## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/${d_exp}/${i}/${i}.pasa.sqlite


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


	echo "#  ------------------------------------------------------------------------"
	echo "#  Symlink to the S. cerevisiae .fasta in each PASA experiment directory --"
	echo "#  ------------------------------------------------------------------------"
	fasta_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
	fasta_SC_sym="$(basename ${fasta_SC_orig})"
	cmd="ln -s ${fasta_SC_orig} ${fasta_SC_sym}"
	cd "${d_exp}/${i}"
	# unlink "${fasta_SC_sym}"
	echo "${cmd}"
	eval "${cmd}"
	cd -
	echo "" && echo ""


	echo "#  ------------------------------------------------------------------------"
	echo "#  Symlink to the S. cerevisiae .gff3 in each PASA experiment directory ---"
	echo "#  ------------------------------------------------------------------------"
	gff3_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3"
	gff3_SC_sym="$(basename ${gff3_SC_orig})"
	cmd="ln -s ${gff3_SC_orig} ${gff3_SC_sym}"
	cd "${d_exp}/${i}"
	# unlink "${gff3_SC_sym}"
	echo "${cmd}"
	eval "${cmd}"
	cd -
	echo "" && echo ""


	echo "#  ------------------------------------------------------------------------"
	echo "#  Print the contents of the given PASA experiment directory --------------"
	echo "#  ------------------------------------------------------------------------"	
	., "./${d_exp}/${i}"
	echo "" && echo ""
	echo "" && echo ""

	(( count++ ))
done
```
<br />
<br />

<a id="run-pasa-launch_pasa_pipelinepl"></a>
## Run `PASA` `Launch_PASA_pipeline.pl`
<a id="set-up-a-job-submission-script-for-pasa-launch_pasa_pipelinepl"></a>
### Set up a job submission script for `PASA` `Launch_PASA_pipeline.pl`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

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

str_directory="\${1}"
str_experiment="\${2}"
str_accessions="\${3}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "\${str_directory}/\${str_experiment}"
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
			-L \\
			--annots "Saccharomyces_cerevisiae.R64-1-1.108.gff3" \\
      		--gene_overlap ${value} \\
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
vi "sh_err_out/${s_name}"  # :q
```

<a id="run-the-job-submission-script-for-pasa-launch_pasa_pipelinepl"></a>
### Run the job submission script for `PASA` `Launch_PASA_pipeline.pl`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

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