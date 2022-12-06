
# `work_generate-data_merge-bams.md`

<!-- MarkdownTOC -->

1. [Make and populate directories for merged `.bam`s](#make-and-populate-directories-for-merged-bams)
1. [Get files of interest into an array](#get-files-of-interest-into-an-array)
    1. [Test with files in `files_unprocessed/`](#test-with-files-in-files_unprocessed)
    1. [Test with files in `files_unprocessed/`, `files_processed`, and `files_processed-full`](#test-with-files-in-files_unprocessed-files_processed-and-files_processed-full)
1. [Design `outfile` name, assign `outdir` automatically](#design-outfile-name-assign-outdir-automatically)
1. [Draft a script for repeated running of `samtools merge`](#draft-a-script-for-repeated-running-of-samtools-merge)
    1. [Write a script for echo tests](#write-a-script-for-echo-tests)
    1. [Write a script for running the commands](#write-a-script-for-running-the-commands)
1. [Design a loop for on-the-fly assignments before submitting jobs](#design-a-loop-for-on-the-fly-assignments-before-submitting-jobs)

<!-- /MarkdownTOC -->

<a id="make-and-populate-directories-for-merged-bams"></a>
## Make and populate directories for merged `.bam`s
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mkdir -p files_unprocessed/bam_split_merge/{Local,EndToEnd}
mkdir -p files_processed/bam_trim_split_merge/{Local,EndToEnd}
mkdir -p files_processed-full/bam_trim-rcor-cor_split_merge/{Local,EndToEnd}
```
<br />
<br />

<a id="get-files-of-interest-into-an-array"></a>
## Get files of interest into an array
<a id="test-with-files-in-files_unprocessed"></a>
### Test with files in `files_unprocessed/`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ./files_unprocessed || echo "cd'ing failed; check on this"

unset bams_5781
typeset -a bams_5781
while IFS=" " read -r -d $'\0'; do
    bams_5781+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5781*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
echoTest "${bams_5781[@]}"

unset bams_5782
typeset -a bams_5782
while IFS=" " read -r -d $'\0'; do
    bams_5782+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5782*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
echoTest "${bams_5782[@]}"

unset bams_replicates
typeset -A bams_replicates
for i in $(seq 0 31); do
	# echo "${i}"
	bams_replicates[${bams_5781[i]}]=${bams_5782[i]}
done

#  Check that the keys and values match
for i in "${!bams_replicates[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${bams_replicates[$i]}"
    echo ""
done
```

<details>
<summary><i>Results of loop over associative array</i></summary>

```txt
  Key: ./bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
```
</details>
<br />

<a id="test-with-files-in-files_unprocessed-files_processed-and-files_processed-full"></a>
### Test with files in `files_unprocessed/`, `files_processed`, and `files_processed-full`
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get files of interest into an array ----------------------------------------
unset bams_5781
typeset -a bams_5781
while IFS=" " read -r -d $'\0'; do
    bams_5781+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5781*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
# echoTest "${bams_5781[@]}"
# echo "${#bams_5781[@]}"

unset bams_5782
typeset -a bams_5782
while IFS=" " read -r -d $'\0'; do
    bams_5782+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5782*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
# echoTest "${bams_5782[@]}"
# echo "${#bams_5782[@]}"

unset replicates_paired
typeset -A replicates_paired
stop="$(echo "${#bams_5782[@]}" - 1 | bc)"  # echo "${stop}"
for i in $(seq 0 "${stop}"); do
    # echo "${i}"
    replicates_paired[${bams_5781[i]}]=${bams_5782[i]}
done

# #  Check that the keys and values match
# for i in "${!replicates_paired[@]}"; do
#     echo "  Key: ${i}"
#     echo "Value: ${replicates_paired[$i]}"
#     echo ""
# done
# echo "${#replicates_paired[@]}"
```

<details>
<summary><i>Results of loop over associative array</i></summary>

```txt
  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IP_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IP_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IP_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IP_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IP_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IP_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IP_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IP_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IP_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IP_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IP_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IN_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IN_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IN_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IN_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IP_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IP_merged.trim.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_Q_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_Q_IN_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/Local/5781_G1_IN_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/Local/5782_G1_IN_merged.trim.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IP_merged.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/Local/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/Local/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/EndToEnd/5782_G1_IN_merged.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

  Key: ./files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
Value: ./files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
```
</details>
<br />
<br />

<a id="design-outfile-name-assign-outdir-automatically"></a>
## Design `outfile` name, assign `outdir` automatically
```bash
#!/bin/bash
#DONTRUN #CONTINUE

# echo "${bams_5781[1]}"
# echo "${bams_5782[1]}"

m_d_i="$(dirname "${bams_5781[1]}")"  # echo "${m_d_i}"
o1="$(echo "${m_d_i}" | cut -d "/" -f 2)"
o2="$(echo "$(echo "${m_d_i}" | cut -d "/" -f 3)_merge")"
o3="$(echo "${m_d_i}" | cut -d "/" -f 4)"
m_d_o="./${o1}/${o2}/${o3}"  # echo "${m_d_o}"

m_s="$(basename "${bams_5781[1]}" | cut -d "_" -f 2-)"  # echo "${m_s}"
m_p="5781-5782"  # echo "${m_p}"

m_f_base="${m_p}_${m_s}"  # echo "${m_f}"
m_f="${m_d_o}"  # echo "${m_d_o}"  # ., "${m_d_o}"
```
<br />
<br />

<a id="draft-a-script-for-repeated-running-of-samtools-merge"></a>
## Draft a script for repeated running of `samtools merge`
<a id="write-a-script-for-echo-tests"></a>
### Write a script for echo tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name_echo="echo_submit_merge-bams.sh"
threads=8

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

rep_1="\${1}"
rep_2="\${2}"
outfile="\${3}"
threads="\${4}"


#  Run echo tests ---------------------
echo "### Call to samtools merge ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
:::+ rep_2 "\${rep_2}" \\
:::+ outfile "\${outfile}"
echo ""
echo ""

echo "### Call to samtools index ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools index \\
    -@ {threads} \\
    {outfile}" \\
::: threads "\${threads}" \\
::: outfile "\${outfile}"
echo ""
echo ""

echo "### Potential call to samtools sort ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools sort \\
    -@ {threads} \\
    {outfile} \\
    -o {outfile_sorted}" \\
::: threads "\${threads}" \\
:::+ outfile "\${outfile}" \\
:::+ outfile_sorted "\${outfile%.bam}.sorted.bam"
echo ""
echo ""

echo "### Potential call to mv ###"
echo "mv -f \${outfile%.bam}.sorted.bam \${outfile}"
echo ""
echo ""

echo "### Potential call to index ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools index \\
    -@ {threads} \\
    {outfile}" \\
::: threads "\${threads}" \\
::: outfile "\${outfile}"
echo ""
echo ""


# #  Run commands -----------------------
# parallel --header : --colsep " " -k -j 1 \\
# "samtools merge \\
#     -@ {threads} \\
#     {rep_1} \\
#     {rep_2} \\
#     -o {outfile}" \\
# ::: threads "\${threads}" \\
# ::: rep_1 "\${rep_1}" \\
# :::+ rep_2 "\${rep_2}" \\
# :::+ outfile "\${outfile}"
#
# # utcc.utoronto.ca/~cks/space/blog/programming/BourneIfCanSetVars
# if [[ \$(\\
#     parallel --header : --colsep " " -k -j 1 \\
#     "samtools index \\
#         -@ {threads} \\
#         {outfile}" \\
#     ::: threads "\${threads}" \\
#     ::: outfile "\${outfile}" \\
# ) -ne 0 ]]; then
#     parallel --header : --colsep " " -k -j 1 \\
#     "samtools sort \\
#         -@ {threads} \\
#         {outfile} \\
#         -o {outfile_sorted}" \\
#     ::: threads "\${threads}" \\
#     :::+ outfile "\${outfile}" \\
#     :::+ outfile_sorted "\${outfile%.bam}.sorted.bam"
#
#     mv -f \\
#         "\${outfile%.bam}.sorted.bam" \\
#         "\${outfile}"
#
#     parallel --header : --colsep " " -k -j 1 \\
#     "samtools index \\
#         -@ {threads} \\
#         {outfile}" \\
#     ::: threads "\${threads}" \\
#     ::: outfile "\${outfile}"
# fi
script
# vi "./sh_err_out/${script_name}"  # :q
```

<a id="write-a-script-for-running-the-commands"></a>
### Write a script for running the commands
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name="submit_merge-bams.sh"
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

rep_1="\${1}"
rep_2="\${2}"
outfile="\${3}"
threads="\${4}"


#  Run echo tests ---------------------
echo "### Call to samtools merge ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
:::+ rep_2 "\${rep_2}" \\
:::+ outfile "\${outfile}"
echo ""
echo ""

echo "### Call to samtools index ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools index \\
    -@ {threads} \\
    {outfile}" \\
::: threads "\${threads}" \\
::: outfile "\${outfile}"
echo ""
echo ""

echo "### Potential call to samtools sort ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools sort \\
    -@ {threads} \\
    {outfile} \\
    -o {outfile_sorted}" \\
::: threads "\${threads}" \\
:::+ outfile "\${outfile}" \\
:::+ outfile_sorted "\${outfile%.bam}.sorted.bam"
echo ""
echo ""

echo "### Potential call to mv ###"
echo "mv -f \${outfile%.bam}.sorted.bam \${outfile}"
echo ""
echo ""

echo "### Potential call to index ###"
parallel --header : --colsep " " -k -j 1 echo \\
"samtools index \\
    -@ {threads} \\
    {outfile}" \\
::: threads "\${threads}" \\
::: outfile "\${outfile}"
echo ""
echo ""


#  Run commands -----------------------
parallel --header : --colsep " " -k -j 1 \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
:::+ rep_2 "\${rep_2}" \\
:::+ outfile "\${outfile}"

# utcc.utoronto.ca/~cks/space/blog/programming/BourneIfCanSetVars
if [[ \$(\\
    parallel --header : --colsep " " -k -j 1 \\
    "samtools index \\
        -@ {threads} \\
        {outfile}" \\
    ::: threads "\${threads}" \\
    ::: outfile "\${outfile}" \\
) -ne 0 ]]; then
    parallel --header : --colsep " " -k -j 1 \\
    "samtools sort \\
        -@ {threads} \\
        {outfile} \\
        -o {outfile_sorted}" \\
    ::: threads "\${threads}" \\
    :::+ outfile "\${outfile}" \\
    :::+ outfile_sorted "\${outfile%.bam}.sorted.bam"

    mv -f \\
        "\${outfile%.bam}.sorted.bam" \\
        "\${outfile}"

    parallel --header : --colsep " " -k -j 1 \\
    "samtools index \\
        -@ {threads} \\
        {outfile}" \\
    ::: threads "\${threads}" \\
    ::: outfile "\${outfile}"
fi
script
# vi "./sh_err_out/${script_name}"  # :q
```
<br />
<br />

<a id="design-a-loop-for-on-the-fly-assignments-before-submitting-jobs"></a>
## Design a loop for on-the-fly assignments before submitting jobs
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get files of interest into an array ----------------------------------------
unset bams_5781
typeset -a bams_5781
while IFS=" " read -r -d $'\0'; do
    bams_5781+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5781*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
# echoTest "${bams_5781[@]}"
# echo "${#bams_5781[@]}"

unset bams_5782
typeset -a bams_5782
while IFS=" " read -r -d $'\0'; do
    bams_5782+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5782*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
# echoTest "${bams_5782[@]}"
# echo "${#bams_5782[@]}"

unset replicates_paired
typeset -A replicates_paired
stop="$(echo "${#bams_5782[@]}" - 1 | bc)"  # echo "${stop}"
for i in $(seq 0 "${stop}"); do
    # echo "${i}"
    replicates_paired[${bams_5781[i]}]=${bams_5782[i]}
done


#  Design the reporting/submission loop, then submit jobs ---------------------
s_name_echo="echo_submit_merge-bams.sh"  #AGAIN
s_name="submit_merge-bams.sh"  #AGAIN
threads=8  #AGAIN

count=1
for i in "${!replicates_paired[@]}"; do
    # i="${bams_5781[76]}"  # echo "${bams_5781[76]}"

    #  Assign in- and outdirectories
    m_d_i="$(dirname "${i}")"  # echo "${m_d_i}"
    o1="$(echo "${m_d_i}" | cut -d "/" -f 2)"
    o2="$(echo "$(echo "${m_d_i}" | cut -d "/" -f 3)_merge")"
    o3="$(echo "${m_d_i}" | cut -d "/" -f 4)"
    m_d_o="./${o1}/${o2}/${o3}"  # echo "${m_d_o}"  # ., "${m_d_o}"

    #  Assign outfile
    m_s="$(basename "${i}" | cut -d "_" -f 2-)"  # echo "${m_s}"
    m_p="5781-5782"  # echo "${m_p}"
    m_f_base="${m_p}_${m_s}"  # echo "${m_f}"
    m_f="${m_d_o}/${m_f_base}"  # echo "${m_d_o}"  # ., "${m_d_o}"

    #  Report on what script's being submitted with what arguments
    message="""
    # --------------------------------------
    Submitting ${s_name} with the following files, parameters:
              replicate 1:       $(basename ${i})
              replicate 2:       $(basename ${replicates_paired[$i]})
           merged outfile:  ${m_f_base}
                  threads:  ${threads}

       replicate 1 (full):             ${i}
       replicate 2 (full):             ${replicates_paired[$i]}
    merged outfile (full):  ${m_f}


    Call to samtools merge:
        samtools merge \\
            -@ \"${threads}\" \\
            \"${i}\" \\
            \"${replicates_paired[$i]}\" \\
            \"${m_f}\"

    Call to samtools index:
        samtools index \\
            -@ \"${threads}\" \\
            \"${m_f}\"


    If merged .bam is not properly sorted, then...
        Call to samtools sort:
            samtools sort \\
                -@ \"${threads}\" \\
                \"${m_f}\" \\
                \"${m_f%.bam}.sorted.bam\"

        Call to mv:
            mv -f \\
                \"${m_f%.bam}.sorted.bam\" \\
                \"${m_f}\"

        Call to samtools index:
            samtools index \\
                -@ \"${threads}\" \\
                \"${m_f}\"

    """
    echo -e "${message}"

    # #  Echo test
    # bash "./sh_err_out/${s_name_echo}" \
    #     "${i}" \
    #     "${replicates_paired[$i]}" \
    #     "${m_f}" \
    #     "${threads}"

    sbatch "./sh_err_out/${s_name}" \
        "${i}" \
        "${replicates_paired[$i]}" \
        "${m_f}" \
        "${threads}"
    sleep 0.25

    (( count++ ))
done
```

<details>
<summary><i>Results of echo test with sample index #24</i></summary>

Printed to terminal
```txt
    # --------------------------------------
    Submitting echo_submit_merge-bams.sh with the following files, parameters:
              replicate 1:       5781_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
              replicate 2:       5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
           merged outfile:  5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
                  threads:  8

       replicate 1 (full):             ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
       replicate 2 (full):             ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
    merged outfile (full):  ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


    Call to samtools merge:
        samtools merge \
            -@ "8" \
            "./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam" \
            "./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam" \
            "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam"

    Call to samtools index:
        samtools index \
            -@ "8" \
            "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam"


    If merged .bam is not properly sorted, then...
        Call to samtools sort:
            samtools sort \
                -@ "8" \
                "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam" \
                "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.sorted.bam"

        Call to mv:
            mv -f \
                "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.sorted.bam" \
                "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam"

        Call to samtools index:
            samtools index \
                -@ "8" \
                "./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam"
```

Printed to `STDOUT`
```txt
### Call to samtools merge ###
samtools merge -@ 8 ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -o ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


### Call to samtools index ###
samtools index -@ 8 ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


### Potential call to samtools sort ###
samtools sort -@ 8 ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -o ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.sorted.bam


### Potential call to mv ###
mv -f ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.sorted.bam ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


### Potential call to index ###
samtools index -@ 8 ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
```

Printed to `STDOUT` (cleaned up manually)
```txt
### Call to samtools merge ###
samtools merge \
    -@ 8 \
    ./files_processed/bam_trim_split/Local/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam \
    ./files_processed/bam_trim_split/Local/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam \
    -o ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


### Call to samtools index ###
samtools index \
    -@ 8 \
    ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


### Potential call to samtools sort ###
samtools sort \
    -@ 8 \
    ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam \
    -o ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.sorted.bam


### Potential call to mv ###
mv -f \
    ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.sorted.bam  \
    ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam


### Potential call to index ###
samtools index \
    -@ 8 \
    ./files_processed/bam_trim_split_merge/Local/5781-5782_Q_IN_merged.trim.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
```
</details>
<br />
<br />

<details>
<summary><i>Scraps</i></summary>

```bash

```
</details>
