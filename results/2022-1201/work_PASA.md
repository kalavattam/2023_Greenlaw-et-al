
# `work_PASA.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set up arrays for genome-free and -guided `.fasta`s](#set-up-arrays-for-genome-free-and--guided-fastas)
    1. [Run an `echo` test for the arrays](#run-an-echo-test-for-the-arrays)
1. [Important "precursor" and main steps for calling `PASA`](#important-precursor-and-main-steps-for-calling-pasa)
    1. [Breakdown of previous steps I performed leading up to the running of `PASA`](#breakdown-of-previous-steps-i-performed-leading-up-to-the-running-of-pasa)
1. [Run a test call to `Singularity` `PASA`](#run-a-test-call-to-singularity-pasa)
    1. [Perform the "precursor" work](#perform-the-precursor-work)
        1. [Set up directory for the test call and associated precursor work](#set-up-directory-for-the-test-call-and-associated-precursor-work)
        1. [Set up the concatenation of `.fasta`s from genome-free and -guided `Trinity` runs](#set-up-the-concatenation-of-fastas-from-genome-free-and--guided-trinity-runs)
        1. [Create a `.txt` file for `Trinity` genome-free transcript accessions](#create-a-txt-file-for-trinity-genome-free-transcript-accessions)
            1. [Run an `echo` test](#run-an-echo-test)
            1. [Check the results of the `echo` test](#check-the-results-of-the-echo-test)
            1. [Run the command](#run-the-command)
        1. [Clean the transcript sequences for the test call](#clean-the-transcript-sequences-for-the-test-call)
            1. [Run an `echo` test](#run-an-echo-test-1)
            1. [Check the results of the `echo` test](#check-the-results-of-the-echo-test-1)
            1. [Run the command](#run-the-command-1)
        1. [Set up an example `.config` file for the sample call to `PASA`](#set-up-an-example-config-file-for-the-sample-call-to-pasa)
    1. [Run `Launch_PASA_pipeline.pl`](#run-launch_pasa_pipelinepl)
        1. [Perform an `echo` test](#perform-an-echo-test)
            1. [Results of `echo` test](#results-of-echo-test)
        1. [Run the command](#run-the-command-2)
1. [Previous shell script for submitting genome-free `Trinity` jobs](#previous-shell-script-for-submitting-genome-free-trinity-jobs)
1. [Build the script for submitting genome-free `Trinity` jobs](#build-the-script-for-submitting-genome-free-trinity-jobs)
    1. [Run `echo` tests](#run-echo-tests)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-up-arrays-for-genome-free-and--guided-fastas"></a>
## Set up arrays for genome-free and -guided `.fasta`s
```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 6 and corresponding defaults

mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd

Trinity_env
ml Singularity


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

<details>
<summary><i>What are the key-value contents of the different associative arrays?</i></summary>

```bash
echo "# T_proc keys" && \
echoTest "${!T_proc[@]}" && \
echo "" && \
echo "# T_proc values" && \
echoTest "${T_proc[@]}" && \
echo "" && \
echo "" && \
echo "# T_full keys" && \
echoTest "${!T_full[@]}" && \
echo "" && \
echo "# T_full values" && \
echoTest "${T_full[@]}" && \
echo "" && \
echo "" && \
echo "# T_full keys" && \
echoTest "${!T_un[@]}" && \
echo "" && \
echo "# T_full values" && \
echoTest "${T_un[@]}" && \
echo "" && \
echo ""
```

<summary><i>Results of echo tests printed to terminal</i></summary>

```txt
# T_proc keys
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Trinity-GG.fasta

# T_proc values
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Trinity.fasta


# T_full keys
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Trinity-GG.fasta
files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta

# T_full values
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta
files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta


# T_full keys
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Trinity-GG.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity-GG.fasta
files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Trinity-GG.fasta

# T_full values
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Trinity.fasta
```
</details>
<br />

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

<details>
<summary><i>Results of message test</i></summary>

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

<a id="important-precursor-and-main-steps-for-calling-pasa"></a>
## Important "precursor" and main steps for calling `PASA`
*...culled from the below breakdown*
1. Concatenate the `Trinity.fasta` and `Trinity.GG.fasta` files into a single `transcripts.fasta` file
2. Create a file containing the list of transcript accessions that correspond to the `Trinity` *de novo* assembly (full *de novo*, not genome-guided)
3. Clean the transcript sequences (`PASA_alignment_assembly`)
4. Write a configuration file
5. Run `Launch_PASA_pipeline.pl`
6. Run `build_comprehensive_transcriptome.dbi`  `#NOTE` *Haven't done this yet*

<a id="breakdown-of-previous-steps-i-performed-leading-up-to-the-running-of-pasa"></a>
### Breakdown of previous steps I performed leading up to the running of `PASA`
- [Working through the first few steps of `PASA` Wiki (2022-1124)](../2022-1101/work-Trinity-2.md#working-through-the-first-few-steps-of-pasa-wiki-2022-1124)
    + `A`
        * Concatenate `Trinity.fasta` and `Trinity.GG.fasta` files into a single `transcripts.fasta`
        * `cat Trinity.fasta Trinity.GG.fasta > transcripts.fasta`
    + `B`
        * Create a file containing the list of transcript accessions that correspond to the `Trinity` genome-free assembly
        * `singularity run ~/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl`
    + `C`
        * Clean the transcript sequences
        * `singularity run ~/singularity-docker-etc/PASA.sif ${PASAHOME}/bin/seqclean`
- [Documentation, details for `PASA`'s `Launch_PASA_pipeline.pl`, including `*.config`](../2022-1101/work-Trinity-2.md#documentation-details-for-pasas-launch_pasa_pipelinepl-including-config)
    + `D`
        * Attempt to write an `alignAssembly` configuration file
        * `#IMPORTANT` `#NOTE` I also need to write an `annotationCompare` configuration file too
            - I neglected to do this in my previous work
            - ...just as I neglected to run the final step of PASA, which is described in bullet #4 [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db)
                + `${PASA_HOME}/scripts/build_comprehensive_transcriptome.dbi`
                + `#TODO` Check on what `${PASA_HOME}` is in the example here
- [Attempt to call `Launch_PASA_pipeline.pl` (2022-1124)](../2022-1101/work-Trinity-2.md#attempt-to-call-launch_pasa_pipelinepl-2022-1124)
- [Attempt to call `Launch_PASA_pipeline.pl` following Brian Haas' advice (2022-1125)](../2022-1101/work-Trinity-2.md#attempt-to-call-launch_pasa_pipelinepl-following-brian-haas-advice-2022-1125)
- [Attempt to continue `Launch_PASA_pipeline.pl` following Brian Haas' advice (2022-1126)](../2022-1101/work-Trinity-2.md#attempt-to-continue-launch_pasa_pipelinepl-following-brian-haas-advice-2022-1126)
<br />
<br />

<a id="run-a-test-call-to-singularity-pasa"></a>
## Run a test call to `Singularity` `PASA`
<a id="perform-the-precursor-work"></a>
### Perform the "precursor" work
<a id="set-up-directory-for-the-test-call-and-associated-precursor-work"></a>
#### Set up directory for the test call and associated precursor work
```bash
#!/bin/bash
#DONTRUN #CONTINUE


#  Derive names for the subdirectories, "${sub}" ------------------------------
#+ ...i.e., the experiment directories within test_files_PASA
#+ 
#+ Can derive the directory names from the keys rather than the values

#  Extract the value using "$(echo "${!T_full[@]}" | cut -d ' ' -f 3)" as the
#+ key
echo "${T_full["$(echo "${!T_full[@]}" | cut -d ' ' -f 3)"]}"
# files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta

# #DONE Get these piped commands into a function
# #  unix.stackexchange.com/questions/550235/print-last-n-characters-from-all-lines-in-a-file-using-cut
# typeset sub=$(\
#     echo "${!T_full[@]}" \
#         | cut -d ' ' -f 3 \
#         | cut -d '/' -f 3- \
#         | rev \
#         | cut -b 18- \
#         | rev \
# )
# echo "${sub}"

name_tx_db() {
    # #TODO Description of function
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
# name_tx_db "${!T_full[*]}" 1
# name_tx_db "${!T_full[*]}" 2
# name_tx_db "${!T_full[*]}" 3
#
# name_tx_db "${!T_proc[*]}" 1
# name_tx_db "${!T_proc[*]}" 2
# name_tx_db "${!T_proc[*]}" 3
#
# name_tx_db "${!T_un[*]}" 1
# name_tx_db "${!T_un[*]}" 2
# name_tx_db "${!T_un[*]}" 3
# #NOTE It works!


#  Make the subdirectory for the test
sub="$(name_tx_db "${!T_full[*]}" 3)"
# # echo "${sub}"
# trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

mkdir -p "test_files_PASA/${sub}"
# mkdir: created directory 'test_files_PASA'
# mkdir: created directory 'test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd'
```

<a id="set-up-the-concatenation-of-fastas-from-genome-free-and--guided-trinity-runs"></a>
#### Set up the concatenation of `.fasta`s from genome-free and -guided `Trinity` runs
```bash
#!/bin/bash
#DONTRUN #CONTINUE

., "$(pwd)/test_files_PASA/${sub}"
# total 80K
# drwxrws--- 2 kalavatt  0 Dec 10 13:29 ./
# drwxrws--- 3 kalavatt 85 Dec 10 13:29 ../

get_element() {
    # #TODO Description of function
    #
    # :param 1: associate array "keys" <e.g., "${!T_full[*]}">
    # :param 2: number of key to work with <int 1-3; e.g., "3">
    echo "${1}" \
        | cut -d ' ' -f "${2}"
}
get_element "${!T_full[*]}" 3  # Key (genome-guided Trinity)
# files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
get_element "${T_full[*]}" 3  # Value (genome-free Trinity)
# files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta

., "$(get_element "${!T_full[*]}" 3)"
# -rw-r--r-- 1 kalavatt 17M Dec  8 18:43 files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Trinity-GG.fasta
., "$(get_element "${T_full[*]}" 3)"
# -rw-r--r-- 1 kalavatt 12M Dec  9 15:44 files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta

#  cat Trinity.fasta Trinity.GG.fasta > transcripts.fasta
cat "$(get_element "${T_full[*]}" 3)" "$(get_element "${!T_full[*]}" 3)" \
    > "test_files_PASA/${sub}/${sub}.transcripts.fasta"
., "test_files_PASA/${sub}/${sub}.transcripts.fasta"
# -rw-rw---- 1 kalavatt 28M Dec 10 13:46 test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta

#NOTE 1/2 I could perhaps automate this with a nested for loop where i is
#NOTE 2/2 T_XXXX and j is 1 2 3
```

<a id="create-a-txt-file-for-trinity-genome-free-transcript-accessions"></a>
#### Create a `.txt` file for `Trinity` genome-free transcript accessions
<a id="run-an-echo-test"></a>
##### Run an `echo` test
```bash
#!/bin/bash
#DONTRUN #CONTINUE

genome_free_fasta="$(get_element "${T_full[*]}" 3)"
genome_free_accessions="test_files_PASA/${sub}/$(basename "${genome_free_fasta}" .fasta).accessions"
# echo "${genome_free_fasta}"
# echo "${genome_free_accessions}"

export PASAHOME="/usr/local/src/PASApipeline"
parallel --header : --colsep " " -k -j 1 echo \
"singularity run \
    --no-home \
    --bind {d_exp} \
    --bind {d_scr} \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/misc_utilities/accession_extractor.pl \
            \< {genome_free_fasta} \
            \> {genome_free_accessions}" \
::: d_exp "$(pwd)" \
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
::: genome_free_fasta "$(get_element "${T_full[*]}" 3)" \
:::+ genome_free_accessions "test_files_PASA/${sub}/$(basename "${genome_free_fasta}" .fasta).accessions"
```

<a id="check-the-results-of-the-echo-test"></a>
##### Check the results of the `echo` test
How does it look?
```txt
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl < files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta > test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
```

Cleaned up for readability
```txt
singularity run 
    --no-home 
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
    --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch 
    /home/kalavatt/singularity-docker-etc/PASA.sif 
        /usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl 
            < files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.fasta 
            > test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
```

<a id="run-the-command"></a>
##### Run the command
```bash
#!/bin/bash
#DONTRUN #CONTINUE

export PASAHOME="/usr/local/src/PASApipeline"
parallel --header : --colsep " " -k -j 1 \
'singularity run \
    --no-home \
    --bind {d_exp} \
    --bind {d_scr} \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/misc_utilities/accession_extractor.pl \
            < {genome_free_fasta} \
            > {genome_free_accessions}' \
::: d_exp "$(pwd)" \
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
::: genome_free_fasta "$(get_element "${T_full[*]}" 3)" \
:::+ genome_free_accessions "test_files_PASA/${sub}/$(basename "${genome_free_fasta}" .fasta).accessions"

., "${genome_free_accessions}"
# -rw-rw---- 1 kalavatt 400K Dec 10 14:17 test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
```

<a id="clean-the-transcript-sequences-for-the-test-call"></a>
#### Clean the transcript sequences for the test call
<a id="run-an-echo-test-1"></a>
##### Run an `echo` test
```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel --header : --colsep " " -k -j 1 echo \
"singularity run \
    --no-home \
    --bind {d_exp} \
    --bind {d_scr} \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/bin/seqclean \
            {genome_combined}" \
::: d_exp "$(pwd)" \
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
::: genome_combined "test_files_PASA/${sub}/${sub}.transcripts.fasta"
```

<a id="check-the-results-of-the-echo-test-1"></a>
##### Check the results of the `echo` test
How does it look?
```txt
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/bin/seqclean test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
```

Cleaned up
```txt
singularity run 
    --no-home 
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
    --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch 
        /home/kalavatt/singularity-docker-etc/PASA.sif 
            /usr/local/src/PASApipeline/bin/seqclean test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
```

<a id="run-the-command-1"></a>
##### Run the command
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "test_files_PASA/${sub}"

parallel --header : --colsep " " -k -j 1 \
'singularity run \
    --no-home \
    --bind {d_exp} \
    --bind {d_scr} \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/bin/seqclean \
            {genome_combined}' \
::: d_exp "$(pwd)" \
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
::: genome_combined "${sub}.transcripts.fasta"

cd -
# pwd
# # /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201
```

<details>
<summary><i>Results of seqclean printed to terminal</i></summary>

```txt
seqclean running options:
seqclean trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
 Standard log file: seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
 Error log file:    err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
 Using 1 CPUs for cleaning
-= Rebuilding trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta cdb index =-
 Launching actual cleaning process:
 psx -p 1  -n 1000  -i trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
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
 in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd, without a detectable error.
```
</details>
<br />

<a id="set-up-an-example-config-file-for-the-sample-call-to-pasa"></a>
#### Set up an example `.config` file for the sample call to `PASA`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./test_files_PASA/${sub}/${sub}.align_assembly.config" ]]; then
    rm "./test_files_PASA/${sub}/${sub}.align_assembly.config"
fi

cat << align_assembly > "./test_files_PASA/${sub}/${sub}.align_assembly.config"
## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
# DATABASE=/exact/path/to/your/working/directory/sample_mydb.pasa.sqlite
DATABASE=/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/${sub}/${sub}.pasa.sqlite


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
# vi "./test_files_PASA/${sub}/${sub}.align_assembly.config"  # :q
```

<a id="run-launch_pasa_pipelinepl"></a>
### Run `Launch_PASA_pipeline.pl`
<a id="perform-an-echo-test"></a>
#### Perform an `echo` test
```bash
#!/bin/bash
#DONTRUN #CONTINUE

export PASAHOME="/usr/local/src/PASApipeline"
parallel --header : --colsep " " -k -j 1 echo \
    'singularity run \
        --no-home \
        --bind {d_exp} \
        --bind {d_scr} \
        ~/singularity-docker-etc/PASA.sif \
            ${PASAHOME}/Launch_PASA_pipeline.pl \
                --CPU {j_cor} \
                --config {align_assembly_config} \
                --create \
                --replace \
                --genome {genome} \
                --MAX_INTRON_LENGTH 1002 \
                --transcripts {transcripts_clean} \
                -T \
                -u {transcripts} \
                --TDN {accessions} \
                --transcribed_is_aligned_orient \
                --stringent_alignment_overlap 30.0 \
                --ALIGNERS blat,gmap,minimap2 \
                    1\> >(tee -a stdout.log.txt) \
                    2\> >(tee -a stderr.log.txt >&2)' \
::: d_exp "$(pwd)" \
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: align_assembly_config "./test_files_PASA/${sub}/${sub}.align_assembly.config" \
::: genome "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
::: transcripts_clean "test_files_PASA/${sub}/${sub}.transcripts.fasta.clean" \
::: transcripts "test_files_PASA/${sub}/${sub}.transcripts.fasta" \
::: accessions "test_files_PASA/${sub}/$(basename "${genome_free_fasta}" .fasta).accessions"
```

<a id="results-of-echo-test"></a>
##### Results of `echo` test
How does it look?
```txt
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/PASA.sif /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl --CPU 6 --config ./test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config --create --replace --genome /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --MAX_INTRON_LENGTH 1002 --transcripts test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean -T -u test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta --TDN test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions tdn.accs --transcribed_is_aligned_orient --stringent_alignment_overlap 30.0 --ALIGNERS blat,gmap,minimap2 1> /dev/fd/63 2> /dev/fd/62
```

Cleaned up
```txt
singularity run 
    --no-home 
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
    --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch 
    /home/kalavatt/singularity-docker-etc/PASA.sif 
        /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl 
            --CPU 6 
            --config ./test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config 
            --create 
            --replace 
            --genome /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta 
            --MAX_INTRON_LENGTH 1002 
            --transcripts test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean 
            -T 
            -u test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta 
            --TDN test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions 
            --transcribed_is_aligned_orient 
            --stringent_alignment_overlap 30.0 
            --ALIGNERS blat,gmap,minimap2 
                1> /dev/fd/63 
                2> /dev/fd/62
```

<a id="run-the-command-2"></a>
#### Run the command
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "test_files_PASA/${sub}" || echo "cd'ing failed; check on this"

export PASAHOME="/usr/local/src/PASApipeline"
singularity run \
    --bind "${HOME}" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/Launch_PASA_pipeline.pl \
            --CPU "${SLURM_CPUS_ON_NODE}" \
            -c "${sub}.align_assembly.config" \
            -C \
            -R \
            -g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "${sub}.transcripts.fasta.clean" \
            -T \
            -u "${sub}.transcripts.fasta" \
            --TDN "$(basename "${genome_free_fasta}" .fasta).accessions" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS blat,gmap,minimap2 \
                > >(tee -a stdout.log.txt) \
                2> >(tee -a stderr.log.txt >&2)
```
<br />
<br />

<a id="previous-shell-script-for-submitting-genome-free-trinity-jobs"></a>
## Previous shell script for submitting genome-free `Trinity` jobs
<details>
<summary><i>Click to view previous script, etc.</i></summary>

```bash
singularity run \
    --bind /loc/scratch \
    --bind $(pwd) \
    ~/singularity-docker-etc/PASA.sif \
    ${PASAHOME}/Launch_PASA_pipeline.pl \
        -c tmp.align_assembly.config \
        -I 1002 \
        -C \
        -R \
        -g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
        -t transcripts.fasta.clean \
        -T \
        -u transcripts.fasta \
        --transcribed_is_aligned_orient \
        --stringent_alignment_overlap 30.0 \
        --TDN tdn.accs \
        --ALIGNERS blat,gmap \
        --CPU "${SLURM_CPUS_ON_NODE}" \
            > >(tee -a stdout.log.txt) \
            2> >(tee -a stderr.log.txt >&2)

export PASAHOME=/usr/local/src/PASApipeline

singularity run \
    ~/singularity-docker-etc/PASA.sif \
    "${PASAHOME}/Launch_PASA_pipeline.pl"
```
</details>
<br />

<details>
<summary><i>PASA options (edited and reformatted for increased readability)</i></summary>

```txt
############################# Options ###############################
#
# * indicates required
#
# --config | -c *                  <filename>  alignment assembly configuration file
#
# // spliced alignment settings
# --ALIGNERS                       <string>    aligners (available options include: gmap, blat, minimap2...
#                                              can run using several, e.g., 'gmap,blat,minimap2')
#  -N                              <int>       max number of top scoring alignments (default: 1)
# --MAX_INTRON_LENGTH | -I         <int>       (max intron length parameter passed to GMAP or BLAT)
#                                              (default: 100000)
# --IMPORT_CUSTOM_ALIGNMENTS_GFF3  <filename>  only using the alignments supplied in the corresponding GFF3
#                                              file
# --trans_gtf                      <filename>  incorporate cufflinks- or stringtie-generated transcripts
#
#
# // actions
# --create | -C                                flag, create database
# --replace | -r                               flag, drop database if -C is also given; rhis will DELETE
#                                              all your data and it is irreversible
# --run | -R                                   flag, run alignment/assembly pipeline
# --annot_compare | -A                         (see section below; can use with opts -L and --annots) 
#                                              compare to annotated genes
# --ALT_SPLICE                                 flag, run alternative splicing analysis
#
#
# // input files
# --genome | -g *                  <filename>  genome sequence FASTA file (should contain annot db asmbl_id
#                                              as header accession)
# --transcripts | -t *             <filename>  transcript db
#  -f                              <filename>  file containing a list of fl-cdna accessions
# --TDN                            <filename>  file containing a list of accessions corresponding to
#                                              Trinity (full) de novo assemblies (not genome-guided)
#
#
# // polyAdenylation site identification  ** highly recommended **
#  -T                                          flag,transcript db were trimmed using the TGI seqclean tool
#  -u                              <filename>  value, transcript db containing untrimmed sequences (input
#                                              to seqclean)
#                                              <a filename with a .cln extension should also exist,
#                                              generated by seqclean>
#
# // Misc
# --TRANSDECODER                               flag, run transdecoder to identify candidate full-length
#                                              coding transcripts
# --CPU                            <int>       multithreading (default: 2)
# --PASACONF                       <string>    path to a user-defined pasa.conf file containing mysql
#                                              connection info
#                                              (used in place of the $PASAHOME/pasa_conf/conf.txt file)
#                                              (and allows for users to have their own unique mysql
#                                              connection info)
#                                              (instead of the pasa role account)
#
#  -d                                          flag, debug
#  -h                                          flag, print this option menu and quit
#
#####################################################################
#
# // Transcript alignment clustering options (clusters are fed into the PASA assembler):
#
# By default, clusters together transcripts based on any overlap (even 1 base!)
#
# Alternatives:
#
# --stringent_alignment_overlap    <float>     (suggested: 30.0) overlapping transcripts must have this min
#                                              % overlap to be clustered
#
# --gene_overlap                   <float>     (suggested: 50.0) transcripts overlapping existing gene
#                                              annotations are clustered; intergenic alignments are
#                                              clustered by default mechanism
#                                              * if --gene_overlap, must also specify --annots with
#                                                annotations in recognizable format (gtf, gff3, or data
#                                                adapted) (just examines 'gene' rows, though)
#
#
# --INVALIDATE_SINGLE_EXON_ESTS                invalidates single exon ests so that none can be built into
#                                              pasa assemblies
#
# --transcribed_is_aligned_orient              flag for strand-specific RNA-Seq assemblies, the aligned
#                                              orientation should correspond to the transcribed orientation
#
#####################################################################
#
# // Annotation comparison options (used in conjunction with -A at top).
#
#  -L                                          load annotations (use in conjunction with --annots)
# --annots                         <filename>  existing gene annotations in recognized format (gtf, gff3,
#                                              or custom adapted)
# --GENETIC_CODE                               (default: universal, options: Euplotes, Tetrahymena,
#                                              Candida, Acetabularia)
#
###################### Process Args and Options #####################
```
</details>
<br />
<br />

<a id="build-the-script-for-submitting-genome-free-trinity-jobs"></a>
## Build the script for submitting genome-free `Trinity` jobs
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
