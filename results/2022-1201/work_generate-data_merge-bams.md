
# `work_generate-data_merge-bams.md`

<!-- MarkdownTOC -->

1. [Run `grabnode` and get to the working directory](#run-grabnode-and-get-to-the-working-directory)
1. [Make and populate directories for merged `.bam`s](#make-and-populate-directories-for-merged-bams)
    1. [Work with `files_unprocessed/`, `files_processed`, `files_processed-full`](#work-with-files_unprocessed-files_processed-files_processed-full)
        1. [Get files of interest into an array](#get-files-of-interest-into-an-array)
        1. [Design the outfile name](#design-the-outfile-name)
        1. [Draft a script for repeated running of `samtools merge`](#draft-a-script-for-repeated-running-of-samtools-merge)

<!-- /MarkdownTOC -->


<a id="run-grabnode-and-get-to-the-working-directory"></a>
## Run `grabnode` and get to the working directory
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


mwd
```

<a id="make-and-populate-directories-for-merged-bams"></a>
## Make and populate directories for merged `.bam`s
```bash
#!/bin/bash
#DONTRUN

mkdir -p files_unprocessed/bam_split_merge/{Local,EndToEnd}
mkdir -p files_processed/bam_trim_split_merge/{Local,EndToEnd}
mkdir -p files_processed-full/bam_trim-rcor-cor_split_merge/{Local,EndToEnd}
```
<a id="work-with-files_unprocessed-files_processed-files_processed-full"></a>
### Work with `files_unprocessed/`, `files_processed`, `files_processed-full`
<a id="get-files-of-interest-into-an-array"></a>
#### Get files of interest into an array
Test with files in `files_unprocessed/`
```bash
#!/bin/bash
#DONTRUN

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

Test with files in `files_unprocessed/`, `files_processed`, and `files_processed-full`
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

#  Check that the keys and values match
for i in "${!replicates_paired[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${replicates_paired[$i]}"
    echo ""
done
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

<a id="design-the-outfile-name"></a>
#### Design the outfile name
```bash
#!/bin/bash
#DONTRUN #CONTINUE

echo "${bams_5781[1]}"
echo "${bams_5782[1]}"

m_dir="$(dirname "${bams_5781[1]}")"  # echo "${m_dir}"
m_suf="$(\
    basename "${bams_5781[1]}" \
        | awk -F "_" '{ print $2"_"$3"_"$4"_"$5"_"$6"_"$7"_"$8 }' \
)"  # echo "${m_suf}"
m_pre="5781-5782"  # echo "${m_pre}"
m_file="${m_pre}_${m_suf}"  # echo "${m_file}"
echo "${m_file}"
```
<a id="draft-a-script-for-repeated-running-of-samtools-merge"></a>
#### Draft a script for repeated running of `samtools merge`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Generate job submission script ---------------------------------------------
script_name="submit_merge-bams.sh"
threads=8

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

rep_1="\${1}"
rep_2="\${2}"
outfile="\${3}"
threads="\${4}"

parallel --header : --colsep " " -k -j 1 echo \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
::: rep_2 "\${rep_2}" \\
::: outfile "\${outfile}"

parallel --header : --colsep " " -k -j 1 \\
"samtools merge \\
    -@ {threads} \\
    {rep_1} \\
    {rep_2} \\
    -o {outfile}" \\
::: threads "\${threads}" \\
::: rep_1 "\${rep_1}" \\
::: rep_2 "\${rep_2}" \\
::: outfile "\${outfile}"
script
```

<i>Scraps</i>
```bash
#  Samtools merge call
samtools merge \
    -@ "${threads}" \
    "${rep_1}" \
    "${rep_2}" \
    -o "${outfile}"

#  Samtools call in GNU parallel
samtools merge \
    -@ {threads} \
    {rep_1} \
    {rep_2} \
    -o {outfile}

#  Check that the keys and values match
for i in "${!replicates_paired[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${replicates_paired[$i]}"
    echo ""
done
```