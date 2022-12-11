
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
            1. [Assessing the completion of `Launch_PASA_pipeline.pl`](#assessing-the-completion-of-launch_pasa_pipelinepl)
        1. [Previous shell script for running `Singularity` `PASA` `Launch_PASA_pipeline.pl`](#previous-shell-script-for-running-singularity-pasa-launch_pasa_pipelinepl)
        1. [Options for `Launch_PASA_pipeline.pl`](#options-for-launch_pasa_pipelinepl)
    1. [Run `build_comprehensive_transcriptome.dbi`](#run-build_comprehensive_transcriptomedbi)
        1. [What are the options/arguments for `build_comprehensive_transcriptome.dbi`?](#what-are-the-optionsarguments-for-build_comprehensive_transcriptomedbi)
        1. [On the meaning of the parameters, using this script, etc.](#on-the-meaning-of-the-parameters-using-this-script-etc)
        1. [Questions for Brian Haas regarding `build_comprehensive_transcriptome.dbi` and `PASA` in general](#questions-for-brian-haas-regarding-build_comprehensive_transcriptomedbi-and-pasa-in-general)
            1. [Question #1](#question-1)
                1. [Text by me](#text-by-me)
                1. [Realization](#realization)
            1. [Question #2: Question about small and/or microbial genomes and `--trans_gtf` \(in `Launch_PASA_pipeline.pl`\)](#question-2-question-about-small-andor-microbial-genomes-and---trans_gtf-in-launch_pasa_pipelinepl)
                1. [Text by me](#text-by-me-1)
                1. [Response by Brian](#response-by-brian)
                1. [Follow-up from me](#follow-up-from-me)
        1. [On running `build_comprehensive_transcriptome.dbi`](#on-running-build_comprehensive_transcriptomedbi)
1. [Miscellaneous](#miscellaneous)

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
6. Run [`build_comprehensive_transcriptome.dbi`](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db#build-a-comprehensive-transcriptome-database-using-genome-guided-and-de-novo-rna-seq-assembly)  `#NOTE` *Haven't done this yet*

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
<details>
<summary><i>Click to view</i></summary>

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
</details>
<br />

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

#TODO 1/2 For some reasong, this does not work:
#TODO 2/2 --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \

#  Performed the commands below: /loc/scratch is present within the container;
#+ try again; first, rename stderr and stdout files so that they're not over-
#+ written
mv stderr.log.txt stderr.log.1.txt
mv stdout.log.txt stdout.log.1.txt

#  Call Launch_PASA_pipeline.pl again... and it failed again; what is the
#+ specific error? (See below)

#IMPORTANT 1/2 It seems that I need to bind "/loc/scratch/5495869" instead of
#IMPORTANT 2/2 "/loc/scratch"
echo "${SLURM_JOB_ID}"
# 5495869
#  Do --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}"

mv stderr.log.txt stderr.log.2.txt
mv stdout.log.txt stdout.log.2.txt

singularity run \
    --bind "${HOME}" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
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
#  It seems to be working...

#IMPORTANT Slurm Environmental Variables: hpcc.umd.edu/hpcc/help/slurmenv.html
```

<details>
<summary><i>Troubleshooting the /loc/scratch errors by performing shell command within and outside the container (edited for readability)</i></summary>

```txt
❯ singularity shell \
    --bind "${HOME}" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
    ~/singularity-docker-etc/PASA.sif
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd, may not be available

Singularity> cd /loc/scratch

Singularity> ls -lhaFG
total 0
drwxrws--- 2 root      0 Oct  2  2021 ./
drwxr-xr-x 3 kalavatt 60 Dec 11 06:17 ../

Singularity> cd /

Singularity> ls -lhaFG
total 172K
drwxr-xr-x   1 kalavatt  100 Dec 11 06:17 ./
drwxr-xr-x   1 kalavatt  100 Dec 11 06:17 ../
lrwxrwxrwx   1 root       27 Nov 23 12:12 .exec -> .singularity.d/actions/exec*
lrwxrwxrwx   1 root       26 Nov 23 12:12 .run -> .singularity.d/actions/run*
lrwxrwxrwx   1 root       28 Nov 23 12:12 .shell -> .singularity.d/actions/shell*
drwxr-xr-x   5 root      127 Nov 23 12:12 .singularity.d/
lrwxrwxrwx   1 root       27 Nov 23 12:12 .test -> .singularity.d/actions/test*
lrwxrwxrwx   1 root        7 Jul 23  2021 bin -> usr/bin/
drwxr-xr-x   2 root        3 Apr 15  2020 boot/
drwxr-xr-x  18 root     4.2K Nov 12 19:17 dev/
lrwxrwxrwx   1 root       36 Nov 23 12:12 environment -> .singularity.d/env/90-environment.sh*
drwxr-xr-x  53 root     1.8K Aug  6  2021 etc/
drwxr-xr-x   3 kalavatt   60 Dec 11 06:17 fh/
drwxr-xr-x   1 kalavatt   60 Dec 11 06:17 home/
lrwxrwxrwx   1 root        7 Jul 23  2021 lib -> usr/lib/
lrwxrwxrwx   1 root        9 Jul 23  2021 lib32 -> usr/lib32/
lrwxrwxrwx   1 root        9 Jul 23  2021 lib64 -> usr/lib64/
lrwxrwxrwx   1 root       10 Jul 23  2021 libx32 -> usr/libx32/
drwxr-xr-x   3 kalavatt   60 Dec 11 06:17 loc/
drwxr-xr-x   2 root        3 Jul 23  2021 media/
drwxr-xr-x   2 root        3 Jul 23  2021 mnt/
drwxr-xr-x   2 root        3 Jul 23  2021 opt/
dr-xr-xr-x 445 root        0 Nov  9 07:00 proc/
drwx------   3 root       90 Feb  3  2022 root/
drwxr-xr-x   8 root      124 Aug  6  2021 run/
lrwxrwxrwx   1 root        8 Jul 23  2021 sbin -> usr/sbin/
lrwxrwxrwx   1 root       24 Nov 23 12:12 singularity -> .singularity.d/runscript*
drwxr-xr-x   2 root        3 Jul 23  2021 srv/
dr-xr-xr-x  13 root        0 Nov  9 07:00 sys/
drwxrwxrwt  32 root     168K Dec 11 06:17 tmp/
drwxr-xr-x  14 root      241 Aug  6  2021 usr/
drwxr-xr-x  11 root      172 Jul 23  2021 var/

Singularity> exit

❯ cd /fh/scratch/delete30/tsukiyama_t
 
❯ .,
total 512
drwxrws---   2 root   0 Oct  2  2021 ./
drwxr-xr-x 240 root 238 Nov 18 11:36 ../

❯ -
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

❯ touch /fh/scratch/delete30/tsukiyama_t/test.txt

❯ cd /fh/scratch/delete30/tsukiyama_t

❯ .,
total 1.0K
drwxrws---   2 root       1 Dec 11 06:10 ./
drwxr-xr-x 240 root     238 Nov 18 11:36 ../
-rw-rw----   1 kalavatt   0 Dec 11 06:22 test.txt

❯ -
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

❯ singularity shell \
    --bind "${HOME}" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \
    ~/singularity-docker-etc/PASA.sif
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd, may not be available

Singularity> ls -lhaFG /loc/scratch
total 512
drwxrws--- 2 root      1 Dec 11 06:10 ./
drwxr-xr-x 3 kalavatt 60 Dec 11 06:23 ../
-rw-rw---- 1 kalavatt  0 Dec 11 06:22 test.txt

Singularity> exit
```
</details>
<br />

<details>
<summary><i>What is the specific error (edited for readability)?</i></summary>

```txt
It appears that some assemblies were generated from an earlier pass.  Only contigs w/o existing alignment assemblies will be pursued.  Otherwise, kill this process and remove the 'assemblies' directory, then restart.
Thread 3 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769022-0.462711754794331.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 5278.
Thread 2 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769022-0.128009359891625.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13555.
Thread 6 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769022-0.977187826604681.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 1430.
Thread 5 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769023-0.262293261083872.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 7333.
Thread 1 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769023-0.40543911031364.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 3838.
Thread 7 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769023-0.457377864354388.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9616.
Thread 4 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769023-0.568041899082349.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 25534.
ERROR, thread 1 exited with error Can't open file /loc/scratch/5495869/pasa.1670769023-0.40543911031364.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 3838.

ERROR, thread 2 exited with error Can't open file /loc/scratch/5495869/pasa.1670769022-0.128009359891625.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13555.

ERROR, thread 3 exited with error Can't open file /loc/scratch/5495869/pasa.1670769022-0.462711754794331.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 5278.

ERROR, thread 4 exited with error Can't open file /loc/scratch/5495869/pasa.1670769023-0.568041899082349.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 25534.

ERROR, thread 5 exited with error Can't open file /loc/scratch/5495869/pasa.1670769023-0.262293261083872.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 7333.

ERROR, thread 6 exited with error Can't open file /loc/scratch/5495869/pasa.1670769022-0.977187826604681.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 1430.

ERROR, thread 7 exited with error Can't open file /loc/scratch/5495869/pasa.1670769023-0.457377864354388.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9616.

Thread 11 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.631634204023616.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 12431.
Thread 14 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.569490806506114.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15409.
Thread 8 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.193429036372439.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 4504.
Thread 9 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.508540524010645.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18184.
Thread 13 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.761479575493471.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 17971.
Thread 10 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.404627130207704.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9379.
Thread 12 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769025-0.597653939928026.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 11115.
ERROR, thread 8 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.193429036372439.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 4504.

ERROR, thread 9 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.508540524010645.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18184.

ERROR, thread 10 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.404627130207704.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9379.

ERROR, thread 11 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.631634204023616.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 12431.

ERROR, thread 12 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.597653939928026.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 11115.

ERROR, thread 13 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.761479575493471.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 17971.

ERROR, thread 14 exited with error Can't open file /loc/scratch/5495869/pasa.1670769025-0.569490806506114.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15409.

Thread 17 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769026-0.778892846153216.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15803.
Thread 16 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769026-0.102179548078315.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18190.
Thread 15 terminated abnormally: Can't open file /loc/scratch/5495869/pasa.1670769026-0.341801809453504.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13074.
ERROR, thread 15 exited with error Can't open file /loc/scratch/5495869/pasa.1670769026-0.341801809453504.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13074.

ERROR, thread 16 exited with error Can't open file /loc/scratch/5495869/pasa.1670769026-0.102179548078315.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18190.

ERROR, thread 17 exited with error Can't open file /loc/scratch/5495869/pasa.1670769026-0.778892846153216.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15803.

Error, 17 threads failed.

Error, cmd:
/usr/local/src/PASApipeline/scripts/assemble_clusters.dbi \
    -G /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta  \
    -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite'  \
    -T 6  \
        > trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.pasa_alignment_assembly_building.ascii_illustrations.out
died with ret 7424 No such file or directory at /usr/local/src/PASApipeline/PerlLib/Pipeliner.pm line 187.
    Pipeliner::run(Pipeliner=HASH(0x5602202ca5f0)) called at /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl line 1047
```
</details>
<br />

<a id="assessing-the-completion-of-launch_pasa_pipelinepl"></a>
##### Assessing the completion of `Launch_PASA_pipeline.pl`
*It seems to have completed successfully*
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd

mv stderr.log.txt stderr.log.3.txt
mv stdout.log.txt stdout.log.3.txt

.,
```

Results of ., printed to terminal
```txt
total 394M
drwxrws--- 6 kalavatt 5.4K Dec 11 08:23 ./
drwxrws--- 3 kalavatt  141 Dec 11 08:19 ../
-rw-r--r-- 1 kalavatt    8 Dec 10 16:05 11.ooc
-rw-r--r-- 1 kalavatt  12M Dec 10 16:26 alignment.validations.output
lrwxrwxrwx 1 kalavatt  120 Dec 10 16:06 blat.spliced_alignments.gff3 -> pblat_outdir/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean.pslx.top_1.gff3
drwxr-s--- 2 kalavatt 3.7K Dec 10 15:53 cleaning_1/
-rw-rw-r-- 1 kalavatt  12K Dec 10 15:53 err_seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-r--r-- 1 kalavatt 7.2M Dec 10 16:05 gmap.spliced_alignments.gff3
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 gmap.spliced_alignments.gff3.completed
-rw-r--r-- 1 kalavatt    0 Dec 10 16:06 minimap2.splice_alignments.gff3.ok
-rw-r--r-- 1 kalavatt 4.8M Dec 10 16:06 minimap2.spliced_alignments.gff3
-rw-rw-r-- 1 kalavatt 3.5K Dec 10 15:53 outparts_cln.sort
drwxr-sr-x 2 kalavatt  325 Dec 11 07:06 pasa_run.log.dir/
drwxr-sr-x 2 kalavatt 3.0K Dec 11 07:40 __pasa_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite_SQLite_chkpts/
-rw-r--r-- 1 kalavatt  19K Dec 11 07:34 __pasa_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite_SQLite_chkpts.cmds_log
drwxr-sr-x 3 kalavatt  270 Dec 10 16:06 pblat_outdir/
-rw-rw-r-- 1 kalavatt 1.7K Dec 10 15:53 seqcl_trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.log
-rw-rw---- 1 kalavatt  61K Dec 10 17:33 stderr.log.1.txt
-rw-rw---- 1 kalavatt  36K Dec 11 06:30 stderr.log.2.txt
-rw-rw---- 1 kalavatt  61K Dec 11 07:34 stderr.log.3.txt
-rw-rw---- 1 kalavatt 1008 Dec 10 16:07 stdout.log.1.txt
-rw-rw---- 1 kalavatt    0 Dec 11 06:30 stdout.log.2.txt
-rw-rw---- 1 kalavatt  197 Dec 11 07:40 stdout.log.3.txt
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 tmp-31731-44938-out
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 tmp-31731-44938-out.tmp.1
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 tmp-31731-44938-out.tmp.2
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 tmp-31731-44938-out.tmp.3
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 tmp-31731-44938-out.tmp.4
-rw-r--r-- 1 kalavatt    0 Dec 10 16:05 tmp-31731-44938-out.tmp.5
-rw-rw---- 1 kalavatt  984 Dec 10 15:54 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.align_assembly.config
-rw-r--r-- 1 kalavatt 151M Dec 11 07:29 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite
-rw-r--r-- 1 kalavatt  16M Dec 11 07:18 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.assemblies.fasta
-rw-r--r-- 1 kalavatt 265K Dec 10 16:38 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.failed_blat_alignments.gff3
-rw-r--r-- 1 kalavatt 379K Dec 10 16:38 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.failed_blat_alignments.gtf
-rw-r--r-- 1 kalavatt 115K Dec 10 16:49 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.failed_gmap_alignments.gff3
-rw-r--r-- 1 kalavatt 188K Dec 10 16:49 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.failed_gmap_alignments.gtf
-rw-r--r-- 1 kalavatt 181K Dec 10 17:01 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.failed_minimap2_alignments.gff3
-rw-r--r-- 1 kalavatt 264K Dec 10 17:01 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.failed_minimap2_alignments.gtf
-rw-r--r-- 1 kalavatt  35M Dec 11 07:06 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.pasa_alignment_assembly_building.ascii_illustrations.out
-rw-r--r-- 1 kalavatt 789K Dec 11 07:31 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.pasa_assemblies.bed
-rw-r--r-- 1 kalavatt 3.0M Dec 11 07:40 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.pasa_assemblies_described.txt
-rw-r--r-- 1 kalavatt 2.2M Dec 11 07:30 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.pasa_assemblies.gff3
-rw-r--r-- 1 kalavatt 3.0M Dec 11 07:34 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.pasa_assemblies.gtf
-rw-r--r-- 1 kalavatt 338K Dec 10 17:06 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.polyAsites.fasta
-rw-r--r-- 1 kalavatt 2.9M Dec 10 16:32 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_blat_alignments.bed
-rw-r--r-- 1 kalavatt 5.2M Dec 10 16:29 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_blat_alignments.gff3
-rw-r--r-- 1 kalavatt  10M Dec 10 16:37 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_blat_alignments.gtf
-rw-r--r-- 1 kalavatt 3.1M Dec 10 16:43 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_gmap_alignments.bed
-rw-r--r-- 1 kalavatt 5.3M Dec 10 16:41 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_gmap_alignments.gff3
-rw-r--r-- 1 kalavatt  11M Dec 10 16:49 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_gmap_alignments.gtf
-rw-r--r-- 1 kalavatt 3.0M Dec 10 16:55 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_minimap2_alignments.bed
-rw-r--r-- 1 kalavatt 5.4M Dec 10 16:52 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_minimap2_alignments.gff3
-rw-r--r-- 1 kalavatt  11M Dec 10 17:01 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite.valid_minimap2_alignments.gtf
-rw-rw---- 1 kalavatt  28M Dec 10 15:52 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta
-rw-rw-r-- 1 kalavatt 1.7M Dec 10 15:53 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cidx
-rw-rw-r-- 1 kalavatt  28M Dec 10 15:53 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean
-rw-r--r-- 1 kalavatt 1.7M Dec 10 16:06 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean.cidx
-rw-r--r-- 1 kalavatt 1.3M Dec 10 16:04 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean.fai
-rw-r--r-- 1 kalavatt 7.0M Dec 10 16:06 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean.mm2.bam
-rw-r--r-- 1 kalavatt  11K Dec 10 16:06 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean.mm2.bam.bai
-rw-r--r-- 1 kalavatt    0 Dec 10 16:06 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.clean.mm2.bam.ok
-rw-rw-r-- 1 kalavatt 1.9M Dec 10 15:53 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.transcripts.fasta.cln
-rw-rw---- 1 kalavatt 400K Dec 10 15:53 trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Trinity.accessions
```

Using `Sublime`, manually create more easily readable versions of the `stderr` and `stdout` files; replace all instances of
```txt
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = "en_US:",
    LC_ALL = (unset),
    LC_CTYPE = "en_US.UTF-8",
    LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```
with blank lines

Also, for any line containing `CMD:`, add a new line before the identified lines

Give these "cleaned up" `stderr` and `stdout` `.clean.txt` extensions
</details>

<a id="previous-shell-script-for-running-singularity-pasa-launch_pasa_pipelinepl"></a>
#### Previous shell script for running `Singularity` `PASA` `Launch_PASA_pipeline.pl`
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

<a id="options-for-launch_pasa_pipelinepl"></a>
#### Options for `Launch_PASA_pipeline.pl`
<details>
<summary><i>Launch_PASA_pipeline.pl options (edited and reformatted for increased readability)</i></summary>

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
# --create | -C                    <flag>      flag, create database
# --replace | -r                   <flag>      flag, drop database if -C is also given; this will DELETE
#                                              all your data and it is irreversible
# --run | -R                       <flag>      flag, run alignment/assembly pipeline
# --annot_compare | -A                         (see section below; can use with opts -L and --annots) 
#                                              compare to annotated genes
# --ALT_SPLICE                     <flag>      flag, run alternative splicing analysis
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
#  -T                              <flag>      flag, transcript db were trimmed using the TGI seqclean tool
#  -u                              <filename>  value, transcript db containing untrimmed sequences (input
#                                              to seqclean)
#                                              <a filename with a .cln extension should also exist,
#                                              generated by seqclean>
#
# // Misc
# --TRANSDECODER                   <flag>      flag, run transdecoder to identify candidate full-length
#                                              coding transcripts
# --CPU                            <int>       multithreading (default: 2)
# --PASACONF                       <string>    path to a user-defined pasa.conf file containing mysql
#                                              connection info
#                                              (used in place of the $PASAHOME/pasa_conf/conf.txt file)
#                                              (and allows for users to have their own unique mysql
#                                              connection info)
#                                              (instead of the pasa role account)
#
#  -d                              <flag>      flag, debug
#  -h                              <flag>      flag, print this option menu and quit
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
# --INVALIDATE_SINGLE_EXON_ESTS    <flag>      invalidates single exon ests so that none can be built into
#                                              pasa assemblies
#
# --transcribed_is_aligned_orient  <flag>      flag for strand-specific RNA-Seq assemblies, the aligned
#                                              orientation should correspond to the transcribed orientation
#
#####################################################################
#
# // Annotation comparison options (used in conjunction with -A at top).
#
#  -L                              <flag>      load annotations (use in conjunction with --annots)
# --annots                         <filename>  existing gene annotations in recognized format (gtf, gff3,
#                                              or custom adapted)
# --GENETIC_CODE                               (default: universal, options: Euplotes, Tetrahymena,
#                                              Candida, Acetabularia)
#
###################### Process Args and Options #####################
```
</details>
<br />

<a id="run-build_comprehensive_transcriptomedbi"></a>
### Run [`build_comprehensive_transcriptome.dbi`](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db#build-a-comprehensive-transcriptome-database-using-genome-guided-and-de-novo-rna-seq-assembly)
<a id="what-are-the-optionsarguments-for-build_comprehensive_transcriptomedbi"></a>
#### What are the options/arguments for `build_comprehensive_transcriptome.dbi`?
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

export PASAHOME="/usr/local/src/PASApipeline"
singularity run \
    --bind "${HOME}" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi
```

Help message (cleaned for readability)
```txt
############################# Options ###############################
#
# -c                 <filename>  configuration file for align-assembly
#
# -t                 <filename>  transcripts fasta file input to PASA
#
#
# Mapping criteria: (if not met, considered not mapping at all)
#
# --prefix           <string>    prefix for output file names. (default: compreh_init_build)
#
# --min_per_ID       <int>       default: 95
#
# --min_per_aligned  <int>       default: 30
#
#
###################### Process Args and Options #####################
```
</details>
<br />

<a id="on-the-meaning-of-the-parameters-using-this-script-etc"></a>
#### On the meaning of the parameters, using this script, etc.
*...taken from the [`PASA` Google Group](https://groups.google.com/g/pasapipeline-users)*
- [Build comprehensive transcriptome questions](https://groups.google.com/g/pasapipeline-users/c/F1rqmPP1cCc/m/1_ueLz7YBgAJ)
- [Annotation update will include transcripts that do not match any gene-model?](https://groups.google.com/g/pasapipeline-users/c/VMw2uFAI7fk/m/g_k-LhAaHwAJ)
- [Comprehensive Transcriptome Database Using Genome-guided and De novo RNA-Seq Assembly](https://groups.google.com/g/pasapipeline-users/c/KdcAyqYUxgU/m/BT7os7LzAQAJ)
    + `#NOTE` This particular thread answers my questions about not using any files output by step #3 as input for step #4 when building comprehensive transcriptome databases
    + This message is particularly relevant: *"There is a MySQL database that PASA stores data in. Therefore information can be shared from one step to the next without explicitly passing all the data on the command line."*
    + `#QUESTION` Does this mean that step #4 needs to be called in the same directory as step #3?  `#TODO` Submit this question on the forum

<a id="questions-for-brian-haas-regarding-build_comprehensive_transcriptomedbi-and-pasa-in-general"></a>
#### Questions for Brian Haas regarding `build_comprehensive_transcriptome.dbi` and `PASA` in general
<a id="question-1"></a>
##### Question #1
<a id="text-by-me"></a>
###### Text by me
Hi Brian and community,

I see in this previous post that, when building comprehensive transcriptome databases, outfiles from step #3 (running `Launch_PASA_pipeline.pl`) don't need to be explicitly passed to step #4 (running `build_comprehensive_transcriptome.dbi`) because of implicit detection of the MySQL or SQLite database...

<a id="realization"></a>
###### Realization
`#ANSWER` It doesn't matter where I call the script from; so long as the database path and name in the configuration file is correct, the script will no where to grab things

<a id="question-2-question-about-small-andor-microbial-genomes-and---trans_gtf-in-launch_pasa_pipelinepl"></a>
##### Question #2: Question about small and/or microbial genomes and `--trans_gtf` (in `Launch_PASA_pipeline.pl`)
<a id="text-by-me-1"></a>
###### [Text by me](https://groups.google.com/g/pasapipeline-users/c/0e8jkG6aLtI/m/LLTI9gCNBAAJ)
Hi Brian and community,

Apologies for the off-topic nature of this question.

I'm interested to include a `.gtf` from `StringTie` for argument `--trans_gtf` when building a comprehensive transcriptome database, i.e., when running `Launch_PASA_pipeline.pl`.

For transcriptome assembly, I'm working with *S. cerevisiae* Illumina RNA-seq data. I'm interested to know if, in your or anyone else's experience, `StringTie` should be called with altered parameters when working with organisms with small and/or microbial genomes. For example, I know that this is recommended when using genome-free and genome-guided `Trinity` with small and/or microbial genomes. No response from the `StringTie` developers so far, and my scans of the literature show that some authors have used default parameters in this or similar contexts.

Or, perhaps, do you not recommend using `StringTie` with small and/or microbial genomes, similar to your not recommending the use of `Cufflinks` in that context?

Thanks; any input will be appreciated,  
Kris

~~*Sent; awaiting response (hopefully, I'll get one)*~~

<a id="response-by-brian"></a>
###### [Response by Brian](https://groups.google.com/g/pasapipeline-users/c/0e8jkG6aLtI/m/aLmE5neOBAAJ)
Hi Kris,

The main danger here is generating fusion transcripts from overlapping
transcripts (UTRs, mostly).  If the data are strand-specific and you
can run stringtie in strand-specific mode, it could be fine.  (If it's
not strand-specific, it'll be trouble w/ compact genomes).  I'd just
suggest looking at your stringtie results first in IGV and/or run some
analyses like cuffcompare (or whatever the new version is called) to
compare your stringtie gtf to the reference gene structure annotation
and assess the level of fusion transcripts generated.

If things look good, you could use PASA to merge everything, but use
the option to require sufficient overlap among alignments to assemble
to again mitigate the neighboring fusion transcript issue.

hope this helps,

~b

<a id="follow-up-from-me"></a>
###### Follow-up from me
Thanks, Brian; yes, that's very helpful. When you mention "the option to require sufficient overlap among alignments to assemble to again mitigate the neighboring fusion transcript issue," you mean adjusting the `--stringent_alignment_overlap` parameter when running `Launch_PASA_pipeline.pl`, is that correct?

In trial experiments I'm running with `PASA`, in which I'm using `.fasta` files from genome-guided and genome-free `Trinity` (but nothing from `StringTie`/`Cufflinks`/etc. yet), so it makes me wonder if it would be helpful to increase the value for `--stringent_alignment_overlap` from 30.0 to perhaps something higher? (Currently, I'm calling `Launch_PASA_pipeline.pl` with `--stringent_alignment_overlap 30.0`, following the advice here.) If I understand things correctly, a higher percentage overlap for `--stringent_alignment_overlap` could/would mitigate the false identification of fusion transcripts that result from working with data from small, gene-dense genomes such as S. cerevisiae—, is that right?

A little experimental context could be helpful here: We're working with a *S. cerevisiae* knock-out model that increases global antisense transcription, and we want to accurately identify these ncRNA transcripts and use the custom annotations in downstream analyses. In our work so far, we see a lot of both fusion and (apparently) fragmentary transcripts. Do you think that adjusting the value for `--stringent_alignment_overlap` could be useful in this context? Or perhaps leaving the `--stringent_alignment_overlap` at 30.0 is reasonable? Thinking of this, I'm reminded also of the `--gene_overlap` option available in `Launch_PASA_pipeline.pl` (which should be called together with the `-L` flag and `--annots_gff3` option). Could calling `Launch_PASA_pipeline.pl` with `--gene_overlap` set to some value be potentially useful in this context?

Thanks! And thanks for these great programs and documentation,
Kris

<a id="on-running-build_comprehensive_transcriptomedbi"></a>
#### On running `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

export PASAHOME="/usr/local/src/PASApipeline"
singularity run \
    --bind "${HOME}" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \
            -c "${sub}.align_assembly.config" \
            -t "${sub}.transcripts.fasta" \
            --min_per_ID 95 \
            --min_per_aligned 30 \
                > >(tee -a stdout.log.bct.txt) \
                2> >(tee -a stderr.log.bct.txt >&2)
```
It completed successfully (and was quick)

<details>
<summary><i>Messages printed to terminal</i></summary>

```txt
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
-connecting to SQLite db: /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite
[84 / 84] processing map/fail TRINITY_DN71_c0_g1_i4CMD: /usr/local/src/PASApipeline/scripts/PASA_transcripts_and_assemblies_to_GFF3.dbi -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite'
-F compreh_init_build/compreh_init_build.fasta > compreh_init_build/compreh_init_build.gff3

perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
CMD: /usr/local/src/PASApipeline/scripts/PASA_transcripts_and_assemblies_to_GFF3.dbi -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/test_files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.pasa.sqlite' -F compreh_init_build/compreh_init_build.fasta -B > compreh_init_build/compreh_init_build.bed
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").


Done.

See files: compreh_init_build/compreh_init_build.fasta and compreh_init_build/compreh_init_build.geneToTrans_mapping
```
</details>

<a id="miscellaneous"></a>
## Miscellaneous
- [On viewing .gff3 files in IGV](https://software.broadinstitute.org/software/igv/GFF)
