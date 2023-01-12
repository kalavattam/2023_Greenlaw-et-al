
# `work_Trinity-GF_trim-rcor_min-glue_glue-factor.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up and run a trial `echo` test to test the setup](#set-things-up-and-run-a-trial-echo-test-to-test-the-setup)
    1. [Getting file, directory info into a deduplicated associative array](#getting-file-directory-info-into-a-deduplicated-associative-array)
    1. [Running an `echo` test, part #1](#running-an-echo-test-part-1)
    1. [Running an `echo` test, part #2](#running-an-echo-test-part-2)
1. [Build the script for submitting genome-free `Trinity` jobs](#build-the-script-for-submitting-genome-free-trinity-jobs)
    1. [Run `echo` tests](#run-echo-tests)
        1. [Generate script for `echo` tests](#generate-script-for-echo-tests)
        1. [Run the script for `echo` tests](#run-the-script-for-echo-tests)
1. [Submit and run genome-free `Trinity` jobs](#submit-and-run-genome-free-trinity-jobs)
    1. [Generate the submission script](#generate-the-submission-script)
    1. [Run the submission script](#run-the-submission-script)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-things-up-and-run-a-trial-echo-test-to-test-the-setup"></a>
## Set things up and run a trial `echo` test to test the setup
<a id="getting-file-directory-info-into-a-deduplicated-associative-array"></a>
### Getting file, directory info into a deduplicated associative array
<details>
<summary><i>Click to view: Getting file, directory info into a deduplicated associative array</i></summary>

```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 core and defaults

mwd() {
    transcriptome \
        && cd "./results/2023-0111" \
        || echo "cd'ing failed; check on this"
}


mwd

Trinity_env


#  Symlink to directory of interest, ../2022-1201/files_processed-full --------
ln -s ../2022-1201/files_processed-full files_processed-full
# .,


#  Create an array of files of interest, including relative paths -------------
unset d_in_base
typeset -a d_in_base=(
    files_processed-full/fastq*split/EndToEnd
)
# echoTest "${d_in_base[@]}"
# echo "${#d_in_base[@]}"


#  Get necessary file/path info into separate arrays ------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_in_base[@]}"; do
    # i="${d_in_base[0]}"
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"
    # ., "${i}"

    while IFS=" " read -r -d $'\0'; do
        f_in+=( "$(echo "$(basename "${REPLY%.?.fq.gz}")" | cut -d $'_' -f 2-)" )
        d_in+=( "$(dirname "${REPLY}")" )
    done < <(\
        find "${i}" \
            -type f \
            -name "*_Q_IP_*_1_*.?.fq.gz" \
            -print0
    )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"


#  Rejoin the path and file info before dedup'ing ---------
unset d_f_rejoin
typeset -a d_f_rejoin
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    d_f_rejoin+=( "${d_in[${i}]}/${f_in[${i}]}" )
done
echoTest "${d_f_rejoin[@]}"


#  Remove duplicate elements from the "rejoin" array ------
IFS=" " read -r -a d_f_rejoin \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${d_f_rejoin[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echoTest "${d_f_rejoin[@]}"


#  "Unjoin" the "rejoin" array ----------------------------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_f_rejoin[@]}"; do
    echo "#  Working with... ------------------------------------------"
    echo "#+ ${i}"

    f_in+=( "$(basename "${i%.?.fq.gz}")" )
    d_in+=( "$(dirname "${i}")" )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"

#NOTE 1/3 The above "unjoin", "rejoin", "unjoin" steps are necessary to maintain
#NOTE 2/3 the equivalent orders for directory paths and corresponding file-name
#NOTE 3/3 snippets
```
</details>
<br />

<a id="running-an-echo-test-part-1"></a>
### Running an `echo` test, part #1
Also, setting important variables in this code chunk
- `SLURM_CPUS_ON_NODE`
- `intron`
- `d_base`
- `pre`
- `t_out`

<details>
<summary><i>Click to view: Running an echo test, part #1</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

i=0
d_f_5781_r1="${d_in[$i]}/5781_${f_in[$i]}.1.fq.gz"
d_f_5781_r2="${d_in[$i]}/5781_${f_in[$i]}.2.fq.gz"
d_f_5782_r1="${d_in[$i]}/5782_${f_in[$i]}.1.fq.gz"
d_f_5782_r2="${d_in[$i]}/5782_${f_in[$i]}.2.fq.gz"

# echo "${d_in[$i]}"
# echo "${f_in[$i]}"
#
# echo "${d_f_5781_r1}"
# echo "${d_f_5781_r2}"
# echo "${d_f_5782_r1}"
# echo "${d_f_5782_r2}"
#
# ., "${d_f_5781_r1}"
# ., "${d_f_5781_r2}"
# ., "${d_f_5782_r1}"
# ., "${d_f_5782_r2}"

SLURM_CPUS_ON_NODE=6  # echo "${SLURM_CPUS_ON_NODE}"
intron="1002"  # echo "${intron}"
d_base="files_Trinity-GF/$(echo "${d_f_5781_r1}" | cut -d "/" -f 1)"  # echo "${d_base}"
pre="trinity_5781-5782_$(\
    echo $(basename "${d_f_5781_r1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
        | cut -d $'_' -f 2- \
)"  # echo "${pre}"
t_out="${d_base}/${pre}"  # echo "${t_out}"

message="""
         cores  ${SLURM_CPUS_ON_NODE}
        left_1  ${d_f_5781_r1}
        left_2  ${d_f_5782_r1}
       right_1  ${d_f_5781_r2}
       right_2  ${d_f_5782_r2}
        intron  ${intron}
     directory  ${d_base}
        prefix  ${pre}
    experiment  ${t_out}
"""
echo "${message}"
```
</details>
<br />

<details>
<summary><i>Printed to terminal: Running an echo test, part #1</i></summary>

```txt
         cores  6
        left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
        left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
       right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
       right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
        intron  1002
     directory  files_Trinity-GF/files_processed-full
        prefix  trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
    experiment  files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
```
</details>
<br />

<a id="running-an-echo-test-part-2"></a>
### Running an `echo` test, part #2
<details>
<summary><i>Click to view: Running an echo test, part #2</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel --header : --colsep " " -k -j 1 echo \
    'singularity run \
        --no-home \
        --bind {d_exp} \
        --bind {d_scr} \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {t_out} \
                --full_cleanup \
                --min_kmer_cov 1 \
                --min_iso_ratio 0.05 \
                --min_glue {min_glue} \
                --glue_factor {glue_factor} \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200' \
::: d_exp "$(pwd)" \
::: d_scr "/loc/scratch" \
::: j_mem "50G" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: left_1 "${d_f_5781_r1}" \
:::+ left_2 "${d_f_5782_r1}" \
:::+ right_1 "${d_f_5781_r2}" \
:::+ right_2 "${d_f_5782_r2}" \
:::+ t_out "${t_out}" \
::: min_glue 1 2 4 \
::: glue_factor 0.005 0.01 0.05 0.1
```
</details>
<br />

`#NOTE` There's an obvious problem with the stems for outfiles&mdash;they don't contain `min_glue` and `glue_factor` information
~~`#TODO` Fix this below~~ *Done.*
<details>
<summary><i>Printed to terminal: Running an echo test, part #2</i></summary>

*Two examples from the below with added newlines*
```txt
singularity run \
    --no-home \
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 \
    --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif \
        Trinity \
        --verbose \
        --max_memory 50G \
        --CPU 6 \
        --SS_lib_type FR \
        --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
        --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
        --jaccard_clip \
        --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
        --full_cleanup \
        --min_kmer_cov 1 \
        --min_iso_ratio 0.05 \
        --min_glue 2 \
        --glue_factor 0.05 \
        --max_reads_per_graph 2000 \
        --normalize_max_read_cov 200 \
        --group_pairs_distance 700 \
        --min_contig_length 200

singularity run \
    --no-home \
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 \
    --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif \
        Trinity \
        --verbose \
        --max_memory 50G \
        --CPU 6 \
        --SS_lib_type FR \
        --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz \
        --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz \
        --jaccard_clip \
        --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
        --full_cleanup \
        --min_kmer_cov 1 \
        --min_iso_ratio 0.05 \
        --min_glue 4 \
        --glue_factor 0.1 \
        --max_reads_per_graph 2000 \
        --normalize_max_read_cov 200 \
        --group_pairs_distance 700 \
        --min_contig_length 200
```

*Nothing added/altered*
```txt
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.01 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.1 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.01 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.1 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.01 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.1 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```
</details>
<br />
<br />

<a id="build-the-script-for-submitting-genome-free-trinity-jobs"></a>
## Build the script for submitting genome-free `Trinity` jobs
<a id="run-echo-tests"></a>
### Run `echo` tests
<a id="generate-script-for-echo-tests"></a>
#### Generate script for `echo` tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="echo_submit_Trinity-GF_min-glue_glue-factor.sh"
threads=8

if [[ ! -d sh_err_out ]]; then
    mkdir sh_err_out/err_out
fi

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
min_glue="\${6}"
glue_factor="\${7}"

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
                --min_glue {min_glue} \\
                --glue_factor {glue_factor} \\
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
:::+ t_out "\${out}" \\
::: min_glue "\${min_glue}" \\
::: glue_factor "\${glue_factor}"
script
# vi "./sh_err_out/${script_name}"  # :q
```

<a id="run-the-script-for-echo-tests"></a>
#### Run the script for `echo` tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

# echoTest "${f_in[@]}"
# echoTest "${d_in[@]}"
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    # i=0
    for min_glue in 1 2 4; do
        # min_glue=4
        for glue_factor in 0.005 0.01 0.05 0.1; do
            # glue_factor=0.1
            d_f_5781_r1="${d_in[$i]}/5781_${f_in[$i]}.1.fq.gz"  # ., "${d_f_5781_r1}"
            d_f_5782_r1="${d_in[$i]}/5782_${f_in[$i]}.1.fq.gz"  # ., "${d_f_5782_r1}"
            d_f_5781_r2="${d_in[$i]}/5781_${f_in[$i]}.2.fq.gz"  # ., "${d_f_5781_r2}"
            d_f_5782_r2="${d_in[$i]}/5782_${f_in[$i]}.2.fq.gz"  # ., "${d_f_5782_r2}"
            echo "#  ========================================================="
            echo "#  Establishing infiles... ----------------------------------"
            echo "    left_1  ${d_f_5781_r1}"
            echo "    left_2  ${d_f_5782_r1}"
            echo "   right_1  ${d_f_5781_r2}"
            echo "   right_2  ${d_f_5782_r2}"
            echo ""

            d_base="files_Trinity-GF/$(echo "${d_f_5781_r1}" | cut -d "/" -f 1)"  # echo "${d_base}"  # ., "${d_base}"
            pre="trinity_mg-${min_glue}_gf-${glue_factor}_5781-5782_$(\
                echo $(basename "${d_f_5781_r1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
                    | cut -d $'_' -f 2- \
            )"  # echo "${pre}"
            t_out="${d_base}/${pre}"  # echo "${t_out}"
            echo "#  Establishing outfile... ---------------------------------"
            echo "    d_base  ${d_base}"
            echo "       pre  ${pre}"
            echo "     t_out  ${t_out}"
            echo ""

            intron="1002"
            echo "#  Setting parameters --------------------------------------"
            echo "     intron  ${intron}"
            echo "   min_glue  ${min_glue}"
            echo "glue_factor  ${glue_factor}"
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
                "${t_out}" \
                "${min_glue}" \
                "${glue_factor}"

            echo ""
            echo ""
        done
    done
done
```

<details>
<summary><i>Printed to terminal: Run the script for echo tests</i></summary>

```txt
#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-1_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  1
glue_factor  0.005

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF'
mkdir: created directory 'files_Trinity-GF/files_processed-full'
mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-1_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  1
glue_factor  0.01

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.01 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-1_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  1
glue_factor  0.05

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-1_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  1
glue_factor  0.1

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-1_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 1 --glue_factor 0.1 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-2_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  2
glue_factor  0.005

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-2_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  2
glue_factor  0.01

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.01 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-2_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  2
glue_factor  0.05

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-2_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  2
glue_factor  0.1

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-2_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.1 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-4_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  4
glue_factor  0.005

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.005_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.005 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-4_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  4
glue_factor  0.01

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.01_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.01 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-4_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  4
glue_factor  0.05

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.05_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity-GF/files_processed-full
       pre  trinity_mg-4_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting parameters --------------------------------------
     intron  1002
   min_glue  4
glue_factor  0.1

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --seqType fq --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity-GF/files_processed-full/trinity_mg-4_gf-0.1_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 4 --glue_factor 0.1 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```
</details>
<br />
<br />

<a id="submit-and-run-genome-free-trinity-jobs"></a>
## Submit and run genome-free `Trinity` jobs
<a id="generate-the-submission-script"></a>
### Generate the submission script
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="submit_Trinity-GF_min-glue_glue-factor.sh"
threads=8  #ABOVE

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

d_data="\${1}"
left_1="\${2}"
left_2="\${3}"
right_1="\${4}"
right_2="\${5}"
out="\${6}"
min_glue="\${7}"
glue_factor="\${8}"

module load Singularity/3.5.3

echo "pwd is \$(pwd)"
echo ""


#  Echo command invocation to STDOUT ------------------------------------------
parallel --header : --colsep " " -k -j 1 echo \\
    'singularity run \\
        --no-home \\
        --bind {d_exp} \\
        --bind {d_data} \\
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
                --min_glue {min_glue} \\
                --glue_factor {glue_factor} \\
                --max_reads_per_graph 2000 \\
                --normalize_max_read_cov 200 \\
                --group_pairs_distance 700 \\
                --min_contig_length 200' \\
::: d_exp "\$(pwd)" \\
::: d_data "\${d_data}" \\
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: left_1 "\${left_1}" \\
:::+ left_2 "\${left_2}" \\
:::+ right_1 "\${right_1}" \\
:::+ right_2 "\${right_2}" \\
:::+ t_out "\${out}" \\
::: min_glue "\${min_glue}" \\
::: glue_factor "\${glue_factor}"


#  Run the command ------------------------------------------------------------
parallel --header : --colsep " " -k -j 1 \\
    'singularity run \\
        --no-home \\
        --bind {d_exp} \\
        --bind {d_data} \\
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
                --min_glue {min_glue} \\
                --glue_factor {glue_factor} \\
                --max_reads_per_graph 2000 \\
                --normalize_max_read_cov 200 \\
                --group_pairs_distance 700 \\
                --min_contig_length 200' \\
::: d_exp "\$(pwd)" \\
::: d_data "\${d_data}" \\
::: d_scr "/fh/scratch/delete30/tsukiyama_t:/loc/scratch" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: left_1 "\${left_1}" \\
:::+ left_2 "\${left_2}" \\
:::+ right_1 "\${right_1}" \\
:::+ right_2 "\${right_2}" \\
:::+ t_out "\${out}" \\
::: min_glue "\${min_glue}" \\
::: glue_factor "\${glue_factor}"
script
# vi "./sh_err_out/${script_name}"  # :q
```

<a id="run-the-submission-script"></a>
### Run the submission script
- Trinity is unable to find the symlinked .fastq.gz infiles as infiles
- Try giving a hard path to the files
- No, that doesn't solve the problem...
- There appears to be some kind of mounting issue with Singularity&mdash;troubleshoot this tomorrow
```bash
#!/bin/bash
#DONTRUN #CONTINUE

# echoTest "${f_in[@]}"
# echoTest "${d_in[@]}"
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    # i=0
    for min_glue in 1 2 4; do
        # min_glue=4
        for glue_factor in 0.005 0.01 0.05 0.1; do
            # glue_factor=0.1

            #  Symlinked files
            d_f_5781_r1="${d_in[$i]}/5781_${f_in[$i]}.1.fq.gz"  # ., "${d_f_5781_r1}"
            d_f_5782_r1="${d_in[$i]}/5782_${f_in[$i]}.1.fq.gz"  # ., "${d_f_5782_r1}"
            d_f_5781_r2="${d_in[$i]}/5781_${f_in[$i]}.2.fq.gz"  # ., "${d_f_5781_r2}"
            d_f_5782_r2="${d_in[$i]}/5782_${f_in[$i]}.2.fq.gz"  # ., "${d_f_5782_r2}"
            
            #  Hard path to files
            # d_f_5781_r1="../2022-1201/${d_in[$i]}/5781_${f_in[$i]}.1.fq.gz"  # ., "${d_f_5781_r1}"
            # d_f_5782_r1="../2022-1201/${d_in[$i]}/5782_${f_in[$i]}.1.fq.gz"  # ., "${d_f_5782_r1}"
            # d_f_5781_r2="../2022-1201/${d_in[$i]}/5781_${f_in[$i]}.2.fq.gz"  # ., "${d_f_5781_r2}"
            # d_f_5782_r2="../2022-1201/${d_in[$i]}/5782_${f_in[$i]}.2.fq.gz"  # ., "${d_f_5782_r2}"
            echo "#  ========================================================="
            echo "#  Establishing infiles... ----------------------------------"
            echo "    left_1  ${d_f_5781_r1}"
            echo "    left_2  ${d_f_5782_r1}"
            echo "   right_1  ${d_f_5781_r2}"
            echo "   right_2  ${d_f_5782_r2}"
            echo ""

            d_base="files_Trinity-GF/$(echo "${d_f_5781_r1}" | cut -d "/" -f 1)"  # echo "${d_base}"  # ., "${d_base}"
            pre="trinity_mg-${min_glue}_gf-${glue_factor}_5781-5782_$(\
                echo $(basename "${d_f_5781_r1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
                    | cut -d $'_' -f 2- \
            )"  # echo "${pre}"
            d_data="files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"  # echo "${d_data}"  # ., "${d_data}"
            t_out="${d_base}/${pre}"  # echo "${t_out}"
            echo "#  Establishing outfile... ---------------------------------"
            echo "    d_base  ${d_base}"
            echo "    d_data  ${d_data}"
            echo "       pre  ${pre}"
            echo "     t_out  ${t_out}"
            echo ""

            intron="1002"
            echo "#  Setting parameters --------------------------------------"
            echo "     intron  ${intron}"
            echo "   min_glue  ${min_glue}"
            echo "glue_factor  ${glue_factor}"
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
            sbatch "./sh_err_out/${script_name}" \
                "${d_f_5781_r1}" \
                "${d_f_5782_r1}" \
                "${d_f_5781_r2}" \
                "${d_f_5782_r2}" \
                "${t_out}" \
                "${min_glue}" \
                "${glue_factor}"
            sleep 0.33

            echo ""
            echo ""
        done
    done
done
```

<details>
<summary><i>Printed to terminal: Run the submission script</i></summary>

```txt

```
</details>
<br />
