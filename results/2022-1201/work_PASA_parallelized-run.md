
# `work_PASA_parallelized-run.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc)
1. [Set up arrays for genome-free and -guided `.fasta`s](#set-up-arrays-for-genome-free-and--guided-fastas)
	1. [Run an `echo` test for the arrays](#run-an-echo-test-for-the-arrays)
1. [Set up names of experiment directories, files, etc.](#set-up-names-of-experiment-directories-files-etc)
1. [Run `PASA` precursor commands](#run-pasa-precursor-commands)
	1. [`mkdir` the experiment directories](#mkdir-the-experiment-directories)
	1. [`cat` the `.fasta`s from `Trinity` genome-free and genome-guided approaches](#cat-the-fastas-from-trinity-genome-free-and-genome-guided-approaches)
	1. [Create `.txt`s for `Trinity` genome-free transcript accessions](#create-txts-for-trinity-genome-free-transcript-accessions)
	1. ["Clean" the transcript sequences](#clean-the-transcript-sequences)
	1. [Write `.config` files for the calls to `PASA`](#write-config-files-for-the-calls-to-pasa)
	1. [Symlink to the *S. cerevisiae* `.fasta` in each `PASA` experiment directory](#symlink-to-the-s-cerevisiae-fasta-in-each-pasa-experiment-directory)
1. [Run `PASA` `Launch_PASA_pipeline.pl`](#run-pasa-launch_pasa_pipelinepl)
	1. [First, perform `echo` tests for the general command](#first-perform-echo-tests-for-the-general-command)
	1. [Build and run the scripts for `PASA` job submissions to `SLURM`](#build-and-run-the-scripts-for-pasa-job-submissions-to-slurm)
		1. [Set up a script for `echo` testing](#set-up-a-script-for-echo-testing)
			1. [Run the `echo` test script \(`bash`\)](#run-the-echo-test-script-bash)
			1. [Run the `echo` test script \(`SLURM`\)](#run-the-echo-test-script-slurm)
		1. [Set up a job submission script](#set-up-a-job-submission-script)
		1. [Run the job submission script](#run-the-job-submission-script)
				1. [Checking on things](#checking-on-things)
1. [Run `PASA` `build_comprehensive_transcriptome.dbi`](#run-pasa-build_comprehensive_transcriptomedbi)
	1. [Set up a job submission script for `PASA` `build_comprehensive_transcriptome.dbi`](#set-up-a-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi)
	1. [Run the job submission script for `PASA` `build_comprehensive_transcriptome.dbi`](#run-the-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi)
1. [Miscellaneous](#miscellaneous)
1. [Miscellaneous](#miscellaneous-1)
1. [Miscellaneous](#miscellaneous-2)
1. [Miscellaneous](#miscellaneous-3)
1. [Build the script for submitting...](#build-the-script-for-submitting)
	1. [Run `echo` tests](#run-echo-tests)

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
    echo "Working with ${i}..."
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
    echo "Working with ${i}..."
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
    echo "Working with ${i}..."
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
echoTest "${!info_tx_db[@]}"
echoTest "${info_tx_db[@]}"

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
<summary><i>Results of echo tests, etc.</i></summary>

`for i in "T_proc" "T_full" "T_un"; do ...`
```txt
#  -------------------------------------
get_key_or_value "${!T_proc[*]}" 1
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta

get_key_or_value "${T_proc[*]}" 1
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta

name_tx_db "${!T_proc[*]}" 1
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd


#  -------------------------------------
get_key_or_value "${!T_proc[*]}" 2
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta

get_key_or_value "${T_proc[*]}" 2
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta

name_tx_db "${!T_proc[*]}" 2
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd


#  -------------------------------------
get_key_or_value "${!T_proc[*]}" 3
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta

get_key_or_value "${T_proc[*]}" 3
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta

name_tx_db "${!T_proc[*]}" 3
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd


#  -------------------------------------
get_key_or_value "${!T_full[*]}" 1
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta

get_key_or_value "${T_full[*]}" 1
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta

name_tx_db "${!T_full[*]}" 1
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd


#  -------------------------------------
get_key_or_value "${!T_full[*]}" 2
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta

get_key_or_value "${T_full[*]}" 2
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta

name_tx_db "${!T_full[*]}" 2
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd


#  -------------------------------------
get_key_or_value "${!T_full[*]}" 3
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta

get_key_or_value "${T_full[*]}" 3
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta

name_tx_db "${!T_full[*]}" 3
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd


#  -------------------------------------
get_key_or_value "${!T_un[*]}" 1
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta

get_key_or_value "${T_un[*]}" 1
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta

name_tx_db "${!T_un[*]}" 1
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local


#  -------------------------------------
get_key_or_value "${!T_un[*]}" 2
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta

get_key_or_value "${T_un[*]}" 2
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta

name_tx_db "${!T_un[*]}" 2
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local


#  -------------------------------------
get_key_or_value "${!T_un[*]}" 3
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta

get_key_or_value "${T_un[*]}" 3
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta

name_tx_db "${!T_un[*]}" 3
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
```

`echoTest "${!info_tx_db[@]}"`
```txt
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
```

`echoTest "${info_tx_db[@]}"`
```txt
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta,files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta,files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta,files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta,files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta,files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta,files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta,files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta,files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta,files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
```

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
<a id="mkdir-the-experiment-directories"></a>
### `mkdir` the experiment directories
```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
	[[ -d "files_PASA/${i}" ]] || mkdir -p "files_PASA/${i}"
	echo ""
done
```

<details>
<summary><i>Command results printed to terminal</i></summary>

```txt
#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

mkdir: created directory 'files_PASA'
mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd'

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

mkdir: created directory 'files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local'
```
</details>
<br />

<a id="cat-the-fastas-from-trinity-genome-free-and-genome-guided-approaches"></a>
### `cat` the `.fasta`s from `Trinity` genome-free and genome-guided approaches
```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
	
	cmd="cat \
	$(get_GG_or_GF "${info_tx_db["${i}"]}" 1) \
	$(get_GG_or_GF "${info_tx_db["${i}"]}" 2) \
	> files_PASA/${i}/${i}.transcripts.fasta"
	echo "${cmd}"
	echo ""

	eval "${cmd}"
	echo ""
done
```

<details>
<summary><i>Command results printed to terminal</i></summary>

```txt
#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

cat     files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

cat     files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

cat     files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

cat     files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta     files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

cat     files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

cat     files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

cat     files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta     files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

cat     files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta     files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

cat     files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta     files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta     > files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
```
</details>
<br />

<a id="create-txts-for-trinity-genome-free-transcript-accessions"></a>
### Create `.txt`s for `Trinity` genome-free transcript accessions
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Perform echo tests
for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
	
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
	:::+ genome_free_accessions "files_PASA/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
	echo ""
	echo ""
done
```

<details>
<summary><i>Results of echo tests (edited for increased readability)</i></summary>

```txt
#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
			< files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta 
			> files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
```
</details>
<br />

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Run the commands
export PASAHOME="/usr/local/src/PASApipeline"

for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
	
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
	:::+ genome_free_accessions "files_PASA/${i}/$(basename "$(get_GG_or_GF "${info_tx_db["${i}"]}" 2)" .fasta).accessions"
	echo ""
	echo ""
done

cd files_PASA && .,s && cd -
```

<details>
<summary><i>Results of .,s in files_PASA/ printed to terminal</i></summary>

```txt
./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd:
total 35M
drwxrws---  2 kalavatt  205 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd:
total 35M
drwxrws---  2 kalavatt  204 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd:
total 34M
drwxrws---  2 kalavatt  203 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd:
total 16M
drwxrws---  2 kalavatt  201 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd:
total 34M
drwxrws---  2 kalavatt  200 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd:
total 33M
drwxrws---  2 kalavatt  199 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  26M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local:
total 34M
drwxrws---  2 kalavatt  185 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local:
total 34M
drwxrws---  2 kalavatt  184 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local:
total 33M
drwxrws---  2 kalavatt  183 Dec 11 15:11 ./
drwxrws--- 11 kalavatt  776 Dec 11 14:55 ../
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
```
</details>
<br />

<a id="clean-the-transcript-sequences"></a>
### "Clean" the transcript sequences
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Perform echo tests
for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
	
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
	::: genome_combined "files_PASA/${i}/${i}.transcripts.fasta"
	echo ""
done
```

<details>
<summary><i>Results of echo tests printed to terminal (edited for increased readability)</i></summary>

```txt
#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta

#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

singularity run 
	--no-home 
	--bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
	--bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680 
	/home/kalavatt/singularity-docker-etc/PASA.sif 
		/usr/local/src/PASApipeline/bin/seqclean 
			files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
```
</details>
<br />

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Run the commands
export PASAHOME="/usr/local/src/PASApipeline"

for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""
	
	cd "files_PASA/${i}"
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
	echo ""

	cd -
	echo ""
	echo ""
done

cd files_PASA && .,s && cd -
#TODO 1/2 The above command is too slow for serialization, I think; get it into
#TODO 2/2 a generic script and then submit jobs to SLURM

#TODO Check to see if ${PASAHOME}/bin/seqclean can be parallelized or not
```

<details>
<summary><i>Results of .,s in files_PASA/ printed to terminal</i></summary>

```txt
./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd:
total 73M
drwxrws---  3 kalavatt  822 Dec 11 15:28 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.7K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  12K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.5K Dec 11 15:28 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd:
total 55M
drwxrws---  3 kalavatt  816 Dec 11 15:26 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:26 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd:
total 52M
drwxrws---  3 kalavatt  810 Dec 11 15:25 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:25 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:25 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:25 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:25 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd:
total 54M
drwxrws---  3 kalavatt  808 Dec 11 15:28 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:28 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd:
total 71M
drwxrws---  3 kalavatt  802 Dec 11 15:27 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:27 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd:
total 68M
drwxrws---  3 kalavatt  796 Dec 11 15:26 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.4K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:26 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  26M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.6M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local:
total 72M
drwxrws---  3 kalavatt  752 Dec 11 15:28 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.3K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.2K Dec 11 15:28 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local:
total 72M
drwxrws---  3 kalavatt  746 Dec 11 15:29 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:29 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:29 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:29 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:29 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local:
total 53M
drwxrws---  3 kalavatt  740 Dec 11 15:27 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:27 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
```
</details>
<br />

<a id="write-config-files-for-the-calls-to-pasa"></a>
### Write `.config` files for the calls to `PASA`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Just run the commands
for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""

	if [[ -f "./files_PASA/${i}/${i}.align_assembly.config" ]]; then
	    rm "./files_PASA/${i}/${i}.align_assembly.config"
	fi

cat << align_assembly > "./files_PASA/${i}/${i}.align_assembly.config"
## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/${i}/${i}.pasa.sqlite


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
# vi "./files_PASA/${i}/${i}.align_assembly.config"  # :q

	echo ""
done

cd files_PASA && .,s && cd -
```

<details>
<summary><i>Results of .,s in files_PASA/ printed to terminal</i></summary>

```txt
./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd:
total 73M
drwxrws---  3 kalavatt  929 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.7K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  12K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.5K Dec 11 15:28 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  906 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd:
total 55M
drwxrws---  3 kalavatt  922 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:26 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  904 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd:
total 52M
drwxrws---  3 kalavatt  915 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:25 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:25 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:25 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:25 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  902 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd:
total 54M
drwxrws---  3 kalavatt  913 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:28 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  902 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd:
total 71M
drwxrws---  3 kalavatt  906 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:27 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  900 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd:
total 68M
drwxrws---  3 kalavatt  899 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.4K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:26 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  898 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  26M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.6M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local:
total 72M
drwxrws---  3 kalavatt  849 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.3K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.2K Dec 11 15:28 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  886 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local:
total 72M
drwxrws---  3 kalavatt  842 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:29 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:29 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:29 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:29 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  884 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local:
total 53M
drwxrws---  3 kalavatt  835 Dec 12 05:37 ./
drwxrws--- 11 kalavatt  720 Dec 11 15:14 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:27 outparts_cln.sort
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  882 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
```
</details>
<br />

<a id="symlink-to-the-s-cerevisiae-fasta-in-each-pasa-experiment-directory"></a>
### Symlink to the *S. cerevisiae* `.fasta` in each `PASA` experiment directory
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Run the commands
fasta_SC_orig="${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
fasta_SC_sym="$(basename ${fasta_SC})"
cmd="ln -s ${fasta_SC} ${fasta_SC_sym}"
# echo "${cmd}"

for i in "${!info_tx_db[@]}"; do
	echo "#  -------------------------------------"
	echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
	echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
	echo "DB: ${i}"
	echo ""

	cd "files_PASA/${i}"
	# unlink "${fasta_SC_sym}"
	echo "${cmd}"
	eval "${cmd}"
	echo ""

	cd -
	echo ""
	echo ""
done

cd files_PASA && .,s && cd -
```

<details>
<summary><i>Loop messages printed to terminal</i></summary>

```txt
#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  -------------------------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
ln -s /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201
```
</details>
<br />

<details>
<summary><i>Results of .,s in files_PASA/ printed to terminal</i></summary>

```txt
./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd:
total 73M
drwxrws---  3 kalavatt 1009 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.7K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  12K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.5K Dec 11 15:28 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  906 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd:
total 55M
drwxrws---  3 kalavatt 1002 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:26 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  904 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd:
total 52M
drwxrws---  3 kalavatt  995 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:25 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:25 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:25 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:25 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  902 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd:
total 54M
drwxrws---  3 kalavatt  993 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:28 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  902 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd:
total 71M
drwxrws---  3 kalavatt  986 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:27 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  900 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd:
total 68M
drwxrws---  3 kalavatt  979 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.4K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:26 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  898 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  26M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.6M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local:
total 72M
drwxrws---  3 kalavatt  929 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.3K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.2K Dec 11 15:28 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  886 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local:
total 72M
drwxrws---  3 kalavatt  922 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:29 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:29 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:29 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:29 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  884 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

./trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local:
total 53M
drwxrws---  3 kalavatt  915 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:27 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  882 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions
```
</details>
<br />
<br />

<a id="run-pasa-launch_pasa_pipelinepl"></a>
## Run `PASA` `Launch_PASA_pipeline.pl`
<a id="first-perform-echo-tests-for-the-general-command"></a>
### First, perform `echo` tests for the general command
```bash
#!/bin/bash
#DONTRUN #CONTINUE

# # stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation
# usage=$(cat <<-END
# 	This is line one.
# 	This is line two.
# 	This is line three.
# END
# )
# echo ${usage}

for i in "${!info_tx_db[@]}"; do
	echo "#  ========================================================="
    echo "#  Work directory ----------------------"
    echo "$(pwd)"
    echo ""  

    echo "#  Essential files ---------------------"  
    echo "GG: $(get_GG_or_GF "${info_tx_db["${i}"]}" 1)"
    echo "GF: $(get_GG_or_GF "${info_tx_db["${i}"]}" 2)"
    echo "DB: ${i}"
    echo ""

    echo "#  Experiment directory ----------------"
    cd "files_PASA/${i}"
    echo ""

cmd=$(cat << command
singularity run \\ 
	--bind "${HOME}" \\ 
    --bind "$(pwd)" \\ 
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \\ 
    ~/singularity-docker-etc/PASA.sif \\ 
        ${PASAHOME}/Launch_PASA_pipeline.pl \\ 
            --CPU "${SLURM_CPUS_ON_NODE}" \\ 
            -c "${i}.align_assembly.config" \\ 
            -C \\ 
            -R \\ 
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \\ 
            -I 1002 \\ 
            -t "${i}.transcripts.fasta.clean" \\ 
            -T \\ 
            -u "${i}.transcripts.fasta" \\ 
            --TDN "$(basename "$(get_GG_or_GF "${info_tx_db[${i}]}" 2)" .fasta).accessions" \\ 
            --transcribed_is_aligned_orient \\ 
            --stringent_alignment_overlap 30.0 \\ 
            --ALIGNERS blat,gmap,minimap2 \\ 
                1> >(tee -a "${i}.stdout.log") \\ 
                2> >(tee -a "${i}.stderr.log" >&2)
command
)
	echo "#  Call to Launch_PASA_pipeline.pl -----"
	echo -e "${cmd}"
	echo ""

	echo "#  Contents of experiment directory ----"
	.,
	echo ""

	echo "#  Back to work directory --------------"
	cd -
	echo ""
	echo ""
done
```

<details>
<summary><i>Results of echo tests, etc. printed to terminal</i></summary>

```txt
#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.stderr.log" >&2)

#  Contents of experiment directory ----
total 52M
drwxrws---  3 kalavatt  995 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:25 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:25 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:25 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:25 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  902 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:25 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.stderr.log" >&2)

#  Contents of experiment directory ----
total 55M
drwxrws---  3 kalavatt 1002 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:26 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  904 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.stderr.log" >&2)

#  Contents of experiment directory ----
total 68M
drwxrws---  3 kalavatt  979 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.4K Dec 11 15:26 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:26 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:26 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:26 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  898 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  26M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.6M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.stderr.log" >&2)

#  Contents of experiment directory ----
total 53M
drwxrws---  3 kalavatt  915 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:27 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  882 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:26 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.stderr.log" >&2)

#  Contents of experiment directory ----
total 71M
drwxrws---  3 kalavatt  986 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:27 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:27 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.3K Dec 11 15:27 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:27 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  900 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  27M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.stderr.log" >&2)

#  Contents of experiment directory ----
total 54M
drwxrws---  3 kalavatt  993 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.5K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.4K Dec 11 15:28 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.6K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  902 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  27M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:27 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 401K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.stderr.log" >&2)

#  Contents of experiment directory ----
total 72M
drwxrws---  3 kalavatt  929 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.3K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.2K Dec 11 15:28 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  886 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.stderr.log" >&2)

#  Contents of experiment directory ----
total 73M
drwxrws---  3 kalavatt 1009 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.7K Dec 11 15:28 cleaning_1/
-rw-rw-r--  1 kalavatt  12K Dec 11 15:28 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.5K Dec 11 15:28 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.7K Dec 11 15:28 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw----  1 kalavatt  906 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 1.9M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw----  1 kalavatt 400K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  =========================================================
#  Work directory ----------------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Essential files ---------------------
GG: files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta
GF: files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
DB: trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

#  Experiment directory ----------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

#  Call to Launch_PASA_pipeline.pl -----
singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.stderr.log" >&2)

#  Contents of experiment directory ----
total 72M
drwxrws---  3 kalavatt  922 Dec 12 08:07 ./
drwxrws--- 11 kalavatt  720 Dec 12 07:56 ../
drwxr-s---  2 kalavatt 3.2K Dec 11 15:29 cleaning_1/
-rw-rw-r--  1 kalavatt  11K Dec 11 15:29 err_seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw-r--  1 kalavatt 3.1K Dec 11 15:29 outparts_cln.sort
lrwxrwxrwx  1 kalavatt  109 Dec 12 08:07 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta -> /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
-rw-rw-r--  1 kalavatt 1.5K Dec 11 15:29 seqcl_trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.log
-rw-rw----  1 kalavatt  884 Dec 12 05:37 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config
-rw-rw----  1 kalavatt  28M Dec 11 14:46 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta
-rw-rw-r--  1 kalavatt 1.7M Dec 11 15:28 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  28M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean
-rw-rw-r--  1 kalavatt 2.0M Dec 11 15:29 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.cln
-rw-rw----  1 kalavatt 406K Dec 11 15:11 trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

#  Back to work directory --------------
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201
```
</details>
<br />

<a id="build-and-run-the-scripts-for-pasa-job-submissions-to-slurm"></a>
### Build and run the scripts for `PASA` job submissions to `SLURM`
<a id="set-up-a-script-for-echo-testing"></a>
#### Set up a script for `echo` testing
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name_echo="echo_submit_launch-PASA-pipeline.sh"
threads=8

#  Set up command within echo script
#+ 
#+ In the command...
#+ - "${str_experiment}" is "${i}" from
#+   "$(for i in "${!info_tx_db[@]}"; do ...; done)"
#+ - "${str_accessions}" is
#+   "$(basename "$(get_GG_or_GF "${info_tx_db[${i}]}" 2)" .fasta).accessions"
cmd=$(cat << command
echo -e "\
ml Singularity 
export PASAHOME=\"/usr/local/src/PASApipeline\" 

singularity run \\ 
	--bind \"\${HOME}\" \\ 
    --bind \"\$(pwd)\" \\ 
    --bind \"/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}\" \\ 
    ~/singularity-docker-etc/PASA.sif \\ 
        \${PASAHOME}/Launch_PASA_pipeline.pl \\ 
            --CPU \"\${SLURM_CPUS_ON_NODE}\" \\ 
            -c \"\${str_experiment}.align_assembly.config\" \\ 
            -C \\ 
            -R \\ 
            -g \"Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta\" \\ 
            -I 1002 \\ 
            -t \"\${str_experiment}.transcripts.fasta.clean\" \\ 
            -T \\ 
            -u \"\${str_experiment}.transcripts.fasta\" \\ 
            --TDN \"\${str_accessions}\" \\ 
            --transcribed_is_aligned_orient \\ 
            --stringent_alignment_overlap 30.0 \\ 
            --ALIGNERS blat,gmap,minimap2 \\ 
                1> >(tee -a \"\${str_experiment}.stdout.log\") \\ 
                2> >(tee -a \"\${str_experiment}.stderr.log\" >&2)\
"
command
)
echo "${cmd}"

if [[ -f "./sh_err_out/${s_name_echo}" ]]; then
        rm "./sh_err_out/${s_name_echo}"
fi
cat << script > "./sh_err_out/${s_name_echo}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name_echo%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name_echo%.sh}.%J.out.txt

#  ${s_name_echo}
#  KA
#  $(date '+%Y-%m%d')

str_experiment="\${1}"
str_accessions="\${2}"

$(echo "${cmd}")

script
# vi "./sh_err_out/${s_name_echo}"  # :q
```

<details>
<summary><i>Results of echo printed to terminal</i></summary>

```txt
echo -e "ml Singularity
export PASAHOME=\"/usr/local/src/PASApipeline\"

singularity run \
    --bind \"${HOME}\" \
    --bind \"$(pwd)\" \
    --bind \"/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}\" \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/Launch_PASA_pipeline.pl \
            --CPU \"${SLURM_CPUS_ON_NODE}\" \
            -c \"${str_experiment}.align_assembly.config\" \
            -C \
            -R \
            -g \"Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta\" \
            -I 1002 \
            -t \"${str_experiment}.transcripts.fasta.clean\" \
            -T \
            -u \"${str_experiment}.transcripts.fasta\" \
            --TDN \"${str_accessions}\" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a \"${str_experiment}.stdout.log\") \
                2> >(tee -a \"${str_experiment}.stderr.log\" >&2)"
```
</details>
<br />

<a id="run-the-echo-test-script-bash"></a>
##### Run the `echo` test script (`bash`)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in "${!info_tx_db[@]}"; do
	str_experiment="${i}"
	str_accessions="$(basename "$(get_GG_or_GF "${info_tx_db[${i}]}" 2)" .fasta).accessions"

	echo "#  ========================================================="
	echo "\${str_experiment} is ${str_experiment}"
	echo "\${str_accessions} is ${str_accessions}"
	echo ""

	bash "./sh_err_out/${s_name_echo}" "${str_experiment}" "${str_accessions}"
	echo ""
	echo ""
done
```

<details>
<summary><i>Results of echo tests printed to terminal</i></summary>

```txt
#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.stderr.log" >&2)


#  =========================================================
${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5535680" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "1" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.stderr.log" >&2)
```
</details>
<br />

<a id="run-the-echo-test-script-slurm"></a>
##### Run the `echo` test script (`SLURM`)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in "${!info_tx_db[@]}"; do
	str_experiment="${i}"
	str_accessions="$(basename "$(get_GG_or_GF "${info_tx_db[${i}]}" 2)" .fasta).accessions"

	echo "#  ========================================================="
	echo "\${str_experiment} is ${str_experiment}"
	echo "\${str_accessions} is ${str_accessions}"
	echo ""

	sbatch "./sh_err_out/${s_name_echo}" "${str_experiment}" "${str_accessions}"
	echo ""
	echo ""
done

#  Check most recent stderr and stdout logs
cd sh_err_out/err_out && .,f

#  Spot checks
head -50 echo_submit_launch-PASA-pipeline.5582262.out.txt && echo ""
head -50 echo_submit_launch-PASA-pipeline.5582259.out.txt && echo ""
cd -
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201
```

<details>
<summary><i>Relevant results of .,f printed to terminal</i></summary>

```txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582261.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582262.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582253.err.txt
drwxrws--- 2 kalavatt  58K Dec 12 09:26 ./
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582260.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582256.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582258.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582257.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582259.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582254.err.txt
-rw-rw---- 1 kalavatt 1.3K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582262.out.txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582261.out.txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582253.out.txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582256.out.txt
-rw-rw---- 1 kalavatt 1.3K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582257.out.txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582254.out.txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582259.out.txt
-rw-rw---- 1 kalavatt 1.3K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582260.out.txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:26 echo_submit_launch-PASA-pipeline.5582258.out.txt
```
</details>
<br />

<details>
<summary><i>Results of first spot check</i></summary>

```txt
ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5582262" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "8" \
            -c "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.stderr.log" >&2)
```
</details>
<br />

<details>
<summary><i>Results of second spot check</i></summary>

```txt
ml Singularity
export PASAHOME="/usr/local/src/PASApipeline"

singularity run \
    --bind "/home/kalavatt" \
    --bind "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/5582259" \
    ~/singularity-docker-etc/PASA.sif \
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            --CPU "8" \
            -c "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta.clean" \
            -T \
            -u "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.transcripts.fasta" \
            --TDN "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                1> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.stdout.log") \
                2> >(tee -a "trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.stderr.log" >&2)
```
</details>
<br />

<a id="set-up-a-job-submission-script"></a>
#### Set up a job submission script
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name="submit_launch-PASA-pipeline.sh"
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

cd "files_PASA/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

# echo "All files in the working directory with extension .fasta:"
# ls -lhaFG *.fasta
# echo ""

singularity run \\
	--no-home \\
	--bind "\${HOME}/genomes/sacCer3/Ensembl/108/DNA" \\
	--bind "\$(pwd)" \\
	--bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
	${HOME}/singularity-docker-etc/PASA.sif \\
		\${PASAHOME}/Launch_PASA_pipeline.pl \\
			--CPU "\${SLURM_CPUS_ON_NODE}" \\
			-c "\${str_experiment}.align_assembly.config" \\
			-C \\
			-R \\
			-g Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta \\
			-I 1002 \\
			-t "\${str_experiment}.transcripts.fasta.clean" \\
			-T \\
			-u "\${str_experiment}.transcripts.fasta" \\
			--TDN "\${str_accessions}" \\
			--transcribed_is_aligned_orient \\
			--stringent_alignment_overlap 30.0 \\
			--ALIGNERS blat,gmap,minimap2 \\
				1> >(tee -a "\${str_experiment}.stdout.log") \\
				2> >(tee -a "\${str_experiment}.stderr.log" >&2)

script
# vi "sh_err_out/${s_name}"  # :q
```

<a id="run-the-job-submission-script"></a>
#### Run the job submission script
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
<summary><i>Relevant results of .,f in sh_err_out/err_out</i></summary>

```txt
-rw-rw---- 1 kalavatt 1.4K Dec 12 09:59 submit_launch-PASA-pipeline.5583197.out.txt
-rw-rw---- 1 kalavatt 2.0K Dec 12 09:59 submit_launch-PASA-pipeline.5583197.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 10:02 submit_launch-PASA-pipeline.5583200.out.txt
-rw-rw---- 1 kalavatt 2.0K Dec 12 10:02 submit_launch-PASA-pipeline.5583200.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 10:17 submit_launch-PASA-pipeline.5583306.out.txt
-rw-rw---- 1 kalavatt 1.1K Dec 12 10:17 submit_launch-PASA-pipeline.5583306.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 10:27 submit_launch-PASA-pipeline.5583309.out.txt
-rw-rw---- 1 kalavatt 1.5K Dec 12 10:27 submit_launch-PASA-pipeline.5583309.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 10:34 submit_launch-PASA-pipeline.5583313.out.txt
-rw-rw---- 1 kalavatt 1.6K Dec 12 10:34 submit_launch-PASA-pipeline.5583313.err.txt
-rw-rw---- 1 kalavatt    0 Dec 12 10:39 submit_launch-PASA-pipeline.5584659.out.txt
-rw-rw---- 1 kalavatt 1.5K Dec 12 10:39 submit_launch-PASA-pipeline.5584659.err.txt
-rw-rw---- 1 kalavatt  165 Dec 12 10:40 submit_launch-PASA-pipeline.5585068.out.txt
-rw-rw---- 1 kalavatt 1.6K Dec 12 10:40 submit_launch-PASA-pipeline.5585068.err.txt
-rw-rw---- 1 kalavatt 2.6K Dec 12 10:44 submit_launch-PASA-pipeline.5585328.out.txt
-rw-rw---- 1 kalavatt 1.5K Dec 12 10:44 submit_launch-PASA-pipeline.5585328.err.txt
```
</details>
<br />

I rewrote the submission script in [the above code chunk](#set-up-a-job-submission-script) in order to address the errors (and other forms of information) in these particular `stderr` and `stdout` `.txt` files

Thus, the preceding `echo` tests were not useful for preparing the actual submission scripts  `#IMPORTANT` Don't do those kinds of `echo` tests moving forward

<details>
<summary><i>Successful job submissions: Messages printed to terminal</i></summary>

```txt
#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5585583


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5585584


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5585585


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5585586


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5585587


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5585588


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5585589


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions

Submitted batch job 5585590


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
- ${str_accessions} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5585591
```
</details>
<br />

<a id="checking-on-things"></a>
###### Checking on things
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Check on the job submissions
skal

#  Check most recent stderr and stdout logs
cd sh_err_out/err_out && .,f
head -100 "$(ls -Arts | tail -1 | cut -d ' ' -f 6-)"  # :q
cd -

#  Check on how work is going in the directory of the last job submission
cd "files_PASA/${i}" && .,f
cd -
```
<br />
<br />

<a id="run-pasa-build_comprehensive_transcriptomedbi"></a>
## Run `PASA` `build_comprehensive_transcriptome.dbi`
<a id="set-up-a-job-submission-script-for-pasa-build_comprehensive_transcriptomedbi"></a>
### Set up a job submission script for `PASA` `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name_next="submit_build-comprehensive-transcriptome.sh"
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

cd "files_PASA/\${str_experiment}"
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

<details>
<summary><i>Job submission scripts printed to terminal</i></summary>

```txt
#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599216


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599217


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599218


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599219


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599220


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599221


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599222


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599223


#  =========================================================
- ${str_experiment} is trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

sh_err_out/submit_launch-PASA-pipeline.sh trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.accessions

Submitted batch job 5599224
```
</details>
<br />
<br />

<a id="miscellaneous"></a>
## Miscellaneous
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
<br />
<br />

<a id="miscellaneous-1"></a>
## Miscellaneous
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
<br />
<br />

<a id="miscellaneous-2"></a>
## Miscellaneous
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
<br />
<br />

<a id="miscellaneous-3"></a>
## Miscellaneous
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
<br />
<br />


<a id="build-the-script-for-submitting"></a>
## Build the script for submitting...
<a id="run-echo-tests"></a>
### Run `echo` tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="echo_submit_PASA.sh"
threads=6

if [[ -f "./sh_err_out/${script_name}" ]]; then
    rm "./sh_err_out/${script_name}"
fi
cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

left_1="\${1}"
left_2="\${2}"
right_1="\${3}"
right_2="\${4}"
out="\${5}"

# module load Singularity/3.5.3

parallel --header : --colsep " " -k -j 1 echo \\
    'singularity run \\
        --no-home \\
        --bind {d_exp} \\
        --bind {d_scr} \\
        ~/singularity-docker-etc/Trinity.sif \\
            Trinity \\
                --verbose \\
                --max_memory {j_mem} \\
                --CPU {j_cor} \\
                --SS_lib_type FR \\
                --seqType fq \\
                --left {left_1},{left_2} \\
                --right {right_1},{right_2} \\
                --jaccard_clip \\
                --output {t_out} \\
                --full_cleanup \\
                --min_kmer_cov 1 \\
                --min_iso_ratio 0.05 \\
                --min_glue 2 \\
                --glue_factor 0.05 \\
                --max_reads_per_graph 2000 \\
                --normalize_max_read_cov 200 \\
                --group_pairs_distance 700 \\
                --min_contig_length 200' \\
::: d_exp "\$(pwd)" \\
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: left_1 "\${left_1}" \\
:::+ left_2 "\${left_2}" \\
:::+ right_1 "\${right_1}" \\
:::+ right_2 "\${right_2}" \\
:::+ t_out "\${out}"
script
# vi "./sh_err_out/${script_name}"  # :q


#  Running the above... -------------------------------------------------------
# echoTest "${f_in[@]}"
# echoTest "${d_in[@]}"
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    # i=1
    d_f_5781_r1="${d_in[$i]}/5781_${f_in[$i]}.1.fq.gz"
    d_f_5782_r1="${d_in[$i]}/5782_${f_in[$i]}.1.fq.gz"
    d_f_5781_r2="${d_in[$i]}/5781_${f_in[$i]}.2.fq.gz"
    d_f_5782_r2="${d_in[$i]}/5782_${f_in[$i]}.2.fq.gz"
    echo "#  ========================================================="
    echo "#  Establishing infiles... ----------------------------------"
    echo "    left_1  ${d_f_5781_r1}"
    echo "    left_2  ${d_f_5782_r1}"
    echo "   right_1  ${d_f_5781_r2}"
    echo "   right_2  ${d_f_5782_r2}"
    echo ""

    d_base="files_Trinity_genome-free/$(echo "${d_f_5781_r1}" | cut -d "/" -f 1)"  # echo "${d_base}"
    pre="trinity_5781-5782_$(\
        echo $(basename "${d_f_5781_r1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
            | cut -d $'_' -f 2- \
    )"
    t_out="${d_base}/${pre}"
    echo "#  Establishing outfile... ---------------------------------"
    echo "    d_base  ${d_base}"
    echo "       pre  ${pre}"
    echo "     t_out  ${t_out}"
    echo ""

    intron="1002"
    echo "#  Setting intron parameter --------------------------------"
    echo "    intron  ${intron}"
    echo ""

    echo "#  Comparing in and out... ---------------------------------"
    echo "    ${f_in[$i]}"
    echo "    ${t_out}"

    echo "#  ========================================================="
    echo ""

    [[ -d "${t_out}" ]] || mkdir -p "${t_out}"
    echo ""

    #TODO 1/2 Could add some kind of check to make sure that left_* include
    #TODO 2/2 read 1, right_* include read 2
    bash "./sh_err_out/${script_name}" \
        "${d_f_5781_r1}" \
        "${d_f_5782_r1}" \
        "${d_f_5781_r2}" \
        "${d_f_5782_r2}" \
        "${t_out}"

    echo ""
    echo ""
done
```
