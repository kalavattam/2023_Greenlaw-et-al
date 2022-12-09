
# `work_Trinity_genome-free.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up and run a trial `echo` test to test the setup](#set-things-up-and-run-a-trial-echo-test-to-test-the-setup)
    1. [Getting file, directory info into a deduplicated associative array](#getting-file-directory-info-into-a-deduplicated-associative-array)
    1. [Running an `echo` test, part #1](#running-an-echo-test-part-1)
    1. [Running an `echo` test, part #2](#running-an-echo-test-part-2)
1. [Build the script for submitting genome-free `Trinity` jobs](#build-the-script-for-submitting-genome-free-trinity-jobs)
    1. [Run `echo` tests](#run-echo-tests)
    1. [Results of `echo` tests](#results-of-echo-tests)
1. [Submit and run genome-free `Trinity` jobs](#submit-and-run-genome-free-trinity-jobs)
    1. [Generate the submission script](#generate-the-submission-script)
    1. [Run the submission script](#run-the-submission-script)
1. [Previous shell script for submitting genome-free `Trinity` jobs](#previous-shell-script-for-submitting-genome-free-trinity-jobs)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-things-up-and-run-a-trial-echo-test-to-test-the-setup"></a>
## Set things up and run a trial `echo` test to test the setup
<a id="getting-file-directory-info-into-a-deduplicated-associative-array"></a>
### Getting file, directory info into a deduplicated associative array
```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 core and defaults

mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd

Trinity_env


#  Create an array of files of interest, including relative paths -------------
unset d_in_base
typeset -a d_in_base=(
    files_unprocessed/fastq*split/Local
    files_processed/fastq*split/EndToEnd
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
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"

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

<a id="running-an-echo-test-part-1"></a>
### Running an `echo` test, part #1
```bash
#!/bin/bash
#DONTRUN #CONTINUE

i=1
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
d_base="files_Trinity_genome-free/$(echo "${d_f_5781_r1}" | cut -d "/" -f 1)"  # echo "${d_base}"
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

<details>
<summary><i>Results of echo test #1 printed to terminal</i></summary>

```txt
         cores  6
        left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
        left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
       right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
       right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
        intron  1002
     directory  files_Trinity_genome-free/files_processed-full
        prefix  trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
    experiment  files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
```
</details>
<br />

<a id="running-an-echo-test-part-2"></a>
### Running an `echo` test, part #2
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
                --min_glue 2 \
                --glue_factor 0.05 \
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
:::+ t_out "${t_out}"
```

<details>
<summary><i>Results of echo test #2 printed to terminal</i></summary>

```txt
singularity run --no-home --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```

<summary><i>Spot check echo test #2</i></summary>

```txt
singularity run 
    --no-home 
    --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 
    --bind /loc/scratch 
    /home/kalavatt/singularity-docker-etc/Trinity.sif
        Trinity 
            --verbose 
            --max_memory 50G 
            --CPU 6 
            --SS_lib_type FR 
            --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz 
            --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz 
            --jaccard_clip 
            --output files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd 
            --full_cleanup 
            --min_kmer_cov 1 
            --min_iso_ratio 0.05 
            --min_glue 2 
            --glue_factor 0.05 
            --max_reads_per_graph 2000 
            --normalize_max_read_cov 200 
            --group_pairs_distance 700 
            --min_contig_length 200
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

script_name="echo_submit_Trinity_genome-free.sh"
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

<a id="results-of-echo-tests"></a>
### Results of `echo` tests
<details>
<summary><i>Results of echo tests printed to terminal</i></summary>

```txt
#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity_genome-free/files_processed
       pre  trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
     t_out  files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
    intron  1002

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity_genome-free/files_processed-full
       pre  trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
    intron  1002

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity_genome-free/files_unprocessed
       pre  trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
     t_out  files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

#  Setting intron parameter --------------------------------
    intron  1002

#  Comparing in and out... ---------------------------------
    Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all
    files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
#  =========================================================


singularity run --no-home --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --left files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz --right files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz --jaccard_clip --output files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```

<summary><i>Spot-checking the calls to singularity...</i></summary>

```txt
singularity run 
    --no-home 
    --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 
    --bind /loc/scratch 
    /home/kalavatt/singularity-docker-etc/Trinity.sif 
        Trinity 
            --verbose 
            --max_memory 50G 
            --CPU 6 
            --SS_lib_type FR 
            --left files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz 
            --right files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz 
            --jaccard_clip 
            --output files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd 
            --full_cleanup 
            --min_kmer_cov 1 
            --min_iso_ratio 0.05 
            --min_glue 2 
            --glue_factor 0.05 
            --max_reads_per_graph 2000 
            --normalize_max_read_cov 200 
            --group_pairs_distance 700 
            --min_contig_length 200

singularity run 
    --no-home 
    --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 
    --bind /loc/scratch 
    /home/kalavatt/singularity-docker-etc/Trinity.sif 
        Trinity 
            --verbose 
            --max_memory 50G 
            --CPU 6 
            --SS_lib_type FR 
            --left files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz 
            --right files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz 
            --jaccard_clip 
            --output files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd 
            --full_cleanup 
            --min_kmer_cov 1 
            --min_iso_ratio 0.05 
            --min_glue 2 
            --glue_factor 0.05 
            --max_reads_per_graph 2000 
            --normalize_max_read_cov 200 
            --group_pairs_distance 700 
            --min_contig_length 200

singularity run 
    --no-home 
    --bind /home/kalavatt/2022_transcriptome-construction_2022-1201 
    --bind /loc/scratch 
    /home/kalavatt/singularity-docker-etc/Trinity.sif 
        Trinity 
            --verbose 
            --max_memory 50G 
            --CPU 6 
            --SS_lib_type FR 
            --left files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz,files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz 
            --right files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz,files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz 
            --jaccard_clip 
            --output files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local 
            --full_cleanup 
            --min_kmer_cov 1 
            --min_iso_ratio 0.05 
            --min_glue 2 
            --glue_factor 0.05 
            --max_reads_per_graph 2000 
            --normalize_max_read_cov 200 
            --group_pairs_distance 700 
            --min_contig_length 200
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

script_name="submit_Trinity_genome-free.sh"
threads=6  #ABOVE

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

module load Singularity/3.5.3


#  Echo command invocation to STDOUT ------------------------------------------
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


#  Run the command ------------------------------------------------------------
parallel --header : --colsep " " -k -j 1 \\
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
```

<a id="run-the-submission-script"></a>
### Run the submission script
```bash
#!/bin/bash
#DONTRUN #CONTINUE

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
    sbatch "./sh_err_out/${script_name}" \
        "${d_f_5781_r1}" \
        "${d_f_5782_r1}" \
        "${d_f_5781_r2}" \
        "${d_f_5782_r2}" \
        "${t_out}"
    sleep 0.33

    echo ""
    echo ""
done
```

<details>
<summary><i>Messages printed to terminal</i></summary>

```
#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed/fastq_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed/fastq_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity_genome-free/files_processed
       pre  trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
     t_out  files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
    intron  1002

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity_genome-free/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
#  =========================================================


Submitted batch job 5481438


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_processed-full/fastq_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity_genome-free/files_processed-full
       pre  trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
     t_out  files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
    intron  1002

#  Comparing in and out... ---------------------------------
    Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all
    files_Trinity_genome-free/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================


Submitted batch job 5481439


#  =========================================================
#  Establishing infiles... ----------------------------------
    left_1  files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz
    left_2  files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.1.fq.gz
   right_1  files_unprocessed/fastq_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz
   right_2  files_unprocessed/fastq_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  Establishing outfile... ---------------------------------
    d_base  files_Trinity_genome-free/files_unprocessed
       pre  trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
     t_out  files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

#  Setting intron parameter --------------------------------
    intron  1002

#  Comparing in and out... ---------------------------------
    Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all
    files_Trinity_genome-free/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
#  =========================================================


Submitted batch job 5481440
```
</details>
<br />
<br />

<a id="previous-shell-script-for-submitting-genome-free-trinity-jobs"></a>
## Previous shell script for submitting genome-free `Trinity` jobs
<details>
<summary><i>Click to view previous script, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode # Lowest and default settings

#  Define variables
d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
d_free="${d_work}/exp_alignment_STAR_tags/rna-star/files_bams"
f_free_1="${d_free}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.1.fq.gz"
f_free_2="${d_free}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.2.fq.gz"
prefix_0="Trinity_trial"
prefix_1="genome-free"
prefix_2="$(echo $(basename "${f_free}") | cut -d . -f 5)"
prefix="${prefix_0}_${prefix_1}_${prefix_2}"
intron=1002
script="submit-Trinity-trial-genome-free.sh"
d_master="${d_work}/exp_${prefix_0}"
d_exp="${d_master}/exp_${prefix}"

echo "${d_work}"
echo "${d_free}"
echo "${f_free_1}"
echo "${f_free_2}"
echo "${prefix_0}"
echo "${prefix_1}"
echo "${prefix_2}"
echo "${prefix}"
echo "${intron}"
echo "${script}"
echo "${d_master}"
echo "${d_exp}"

ls -lhaFG "${d_work}"
ls -lhaFG "${d_free}"
ls -lhaFG "${f_free_1}"
ls -lhaFG "${f_free_2}"
ls -lhaFG "${d_master}"

#  Change and set up directories
cd "${d_work}" || echo "Error: cd'ing failed; check on this"
[[ -d "${d_exp}" ]] || mkdir -p "${d_exp}"

#  For now, use the latest version of Trinity available via FHCC Bioinformatics
ml Trinity/2.12.0-foss-2020b

#  Generate the job-submission script
if [[ -f "${script}" ]]; then rm "${script}"; fi
cat << script > "${script}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

infile_1="\${1}"
infile_2="\${2}"
outdir="\${3}"
prefix="\${4}"

echo "echo test:"
echo -e "Trinity \\ \n\
    --max_memory 50G \\ \n\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --SS_lib_type FR \\ \n\
    --seqType fq \\ \n\
    --left "\${infile_1}" \\ \n\
    --right "\${infile_2}" \\ \n\
    --jaccard_clip \\ \n\
    --output "\${outdir}/\${prefix}" \\ \n\
    --full_cleanup \\ \n\
    --min_kmer_cov 1 \\ \n\
    --min_iso_ratio 0.05 \\ \n\
    --min_glue 2 \\ \n\
    --glue_factor 0.05 \\ \n\
    --max_reads_per_graph 2000 \\ \n\
    --normalize_max_read_cov 200 \\ \n\
    --group_pairs_distance 700 \\ \n\
    --min_contig_length 200"

Trinity \\
    --max_memory 50G \\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\
    --SS_lib_type FR \\
    --seqType fq \\
    --left "\${infile_1}" \\
    --right "\${infile_2}" \\
    --jaccard_clip \\
    --output "\${outdir}/\${prefix}" \\
    --full_cleanup \\
    --min_kmer_cov 1 \\
    --min_iso_ratio 0.05 \\
    --min_glue 2 \\
    --glue_factor 0.05 \\
    --max_reads_per_graph 2000 \\
    --normalize_max_read_cov 200 \\
    --group_pairs_distance 700 \\
    --min_contig_length 200
script
```
</details>
<br />
<br />

<details>
<summary><i>Scrap #1</i></summary>

```bash
#  Get the file/directory info into an associative array --
unset f_in_comp
typeset -A f_in_comp
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    echo "  Key  ${f_in[$i]}"
    echo "Value  ${d_in[$i]}"

    f_in_comp[${f_in[$i]}]=${d_in[$i]}
    echo ""
done
# echoTest "${!f_in_comp[@]}"  # Keys
# echoTest "${f_in_comp[@]}"  # Values

#  Check that the keys and values match
for i in "${!f_in_comp[@]}"; do
    echo "  Key  ${i}"
    echo "Value  ${f_in_comp[$i]}"
    echo ""
done
echo "${#f_in_comp[@]}"
```
</details>
<br />

<details>
<summary><i>Scrap #2</i></summary>

```bash
# x_in="${f_in_comp["Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all"]}"  # echo "${x_in}"
# echo "${x_in}"

x_d_in="${f_in_comp["${f_in[1]}"]}"  # echo "${x_d_in}"
echo "${x_d_in}"
# files_processed-full/fastq_trim-rcor-cor_split/EndToEnd

x_f_in="${f_in[1]}"
echo "${x_f_in}"
# Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

# x_d_in="${d_in[1]}"  # echo "${x_d_in}"
# x_f_in="${f_in[1]}"  # echo "${x_f_in}"

echoTest "${d_in[@]}"
echoTest "${f_in[@]}"
```
</details>
<br />
