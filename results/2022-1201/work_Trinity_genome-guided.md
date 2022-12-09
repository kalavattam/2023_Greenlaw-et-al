
`#work_Trinity_genome-guided.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up and run a trial `echo` test to test the setup](#set-things-up-and-run-a-trial-echo-test-to-test-the-setup)
1. [Build the script for submitting genome-guided `Trinity` jobs](#build-the-script-for-submitting-genome-guided-trinity-jobs)
    1. [Run `echo` tests](#run-echo-tests)
    1. [Submit and run genome-guided `Trinity` jobs](#submit-and-run-genome-guided-trinity-jobs)
1. [Previous shell script for submitting genome-guided `Trinity` jobs](#previous-shell-script-for-submitting-genome-guided-trinity-jobs)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-things-up-and-run-a-trial-echo-test-to-test-the-setup"></a>
## Set things up and run a trial `echo` test to test the setup
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
unset d_in
typeset -a d_in=(
    files_unprocessed/bam_*_merge/Local
    files_processed/bam_*_merge/EndToEnd
    files_processed-full/bam_*_merge/EndToEnd
)
# echoTest "${d_in[@]}"
# echo "${#d_in[@]}"

unset infiles
typeset -a infiles
for i in "${d_in[@]}"; do
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"

    while IFS=" " read -r -d $'\0'; do
        infiles+=( "${REPLY}" )
    done < <(\
        find "${i}" \
            -type f \
            \( -name "*_Q_IP_*_1_*.bam" -o \
               -name "*_Q_IP_*_10_*.bam" -o \
               -name "*_Q_IP_*_100_*.bam" \) \
            -print0 |
                sort -z
    )

    echo ""
done
# echoTest "${infiles[@]}"
# echo "${#infiles[@]}"


SLURM_CPUS_ON_NODE=6  # echo "${SLURM_CPUS_ON_NODE}"
f_in="${infiles[5]}"  # echo "${f_in}"
intron="1002"  # echo "${intron}"
d_base="files_Trinity_genome-guided/$(echo "${f_in}" | cut -d "/" -f 1)"  # echo "${d_base}"
pre="trinity_$(basename "${f_in}" ".Aligned.sortedByCoord.out.sc_all.bam")"  # echo "${prefix}"
t_out="${d_base}/${pre}"  # echo "${d_t}"

echo "${SLURM_CPUS_ON_NODE}"
echo "${f_in}"
echo "${intron}"
echo "${d_base}"
echo "${pre}"
echo "${d_t}"
echo "${t_out}"

parallel --header : --colsep " " -k -j 1 echo \
    'singularity shell \
        --no-home \
        --bind {d_exp} \
        --bind {d_scr} \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --genome_guided_bam {f_in} \
                --genome_guided_max_intron 1002 \
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
::: f_in "${f_in}" \
:::+ t_out "${t_out}"
```

<details>
<summary><i>Results of echo test printed to terminal</i></summary>

```txt
singularity shell --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```

<summary><i>Spot check</i></summary>

```txt
singularity shell 
    --no-home 
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
    --bind /loc/scratch 
    /home/kalavatt/singularity-docker-etc/Trinity.sif 
        Trinity 
            --verbose 
            --max_memory 50G 
            --CPU 6 
            --SS_lib_type FR 
            --genome_guided_bam files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 
            --genome_guided_max_intron 1002 
            --jaccard_clip 
            --output files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd 
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

<a id="build-the-script-for-submitting-genome-guided-trinity-jobs"></a>
## Build the script for submitting genome-guided `Trinity` jobs
<a id="run-echo-tests"></a>
### Run `echo` tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="echo_submit_Trinity_genome-guided.sh"
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

in="\${1}"
out="\${2}"

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
                --genome_guided_bam {f_in} \\
                --genome_guided_max_intron 1002 \\
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
::: d_scr "/loc/scratch" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: f_in "\${in}" \\
:::+ t_out "\${out}"
script
# vi "./sh_err_out/${script_name}"  # :q


#  Running the above... -------------------------------------------------------
# echoTest "${infiles[@]}"
for i in "${infiles[@]}"; do
    f_in="${i}"  # echo "${f_in}"
    echo "#  ========================================================="
    echo "#  Establishing infile... ----------------------------------"
    echo "- ${f_in}"
    echo ""

    d_base="files_Trinity_genome-guided/$(echo "${f_in}" | cut -d "/" -f 1)"  # echo "${d_base}"
    pre="trinity_$(basename "${f_in}" ".Aligned.sortedByCoord.out.sc_all.bam")"  # echo "${prefix}"
    t_out="${d_base}/${pre}"  # echo "${d_t}"
    echo "#  Establishing outfile... ---------------------------------"
    echo "- ${d_base}"
    echo "- ${pre}"
    echo "- ${t_out}"
    echo ""

    intron="1002"  # echo "${intron}"
    echo "#  Setting intron parameter --------------------------------"
    echo "- ${intron}"
    echo ""

    echo "#  Comparing in and out... ---------------------------------"
    echo "- $(basename "${f_in}")"
    echo "- $(basename "${t_out}")"

    echo "#  ========================================================="
    echo ""

    [[ -d "${d_t}" ]] || mkdir -p "${d_t}"
    echo ""

    bash "./sh_err_out/${script_name}" \
        "${f_in}" \
        "${t_out}"

    echo ""
    echo ""
done
```

<details>
<summary><i>Results of echo tests printed to terminal</i></summary>

```txt
#  =========================================================
#  Establishing infile... ----------------------------------
- files_unprocessed/bam_split_merge/Local/5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_unprocessed
- trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
- files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_unprocessed/bam_split_merge/Local/5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_unprocessed/bam_split_merge/Local/5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_unprocessed
- trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
- files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_unprocessed/bam_split_merge/Local/5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_unprocessed/bam_split_merge/Local/5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_unprocessed
- trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
- files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_unprocessed/bam_split_merge/Local/5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_unprocessed/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
- files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
- files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
- files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-full
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
- files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-full
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
- files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200


#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-full
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
- files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================


singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```

<summary><i>Spot-checking a call to singularity...</i></summary>

```txt
singularity run 
    --no-home 
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 
    --bind /loc/scratch
    /home/kalavatt/singularity-docker-etc/Trinity.sif
        Trinity 
            --verbose 
            --max_memory 50G 
            --CPU 6 
            --SS_lib_type FR 
            --genome_guided_bam files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 
            --genome_guided_max_intron 1002 
            --jaccard_clip 
            --output files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd 
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

<a id="submit-and-run-genome-guided-trinity-jobs"></a>
### Submit and run genome-guided `Trinity` jobs
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="submit_Trinity_genome-guided.sh"
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

in="\${1}"
out="\${2}"

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
                --genome_guided_bam {f_in} \\
                --genome_guided_max_intron 1002 \\
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
::: d_scr "/loc/scratch" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: f_in "\${in}" \\
:::+ t_out "\${out}"

echo ""


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
                --genome_guided_bam {f_in} \\
                --genome_guided_max_intron 1002 \\
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
::: d_scr "/loc/scratch" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: f_in "\${in}" \\
:::+ t_out "\${out}"
script
# vi "./sh_err_out/${script_name}"  # :q

# d_exp "" \\
# d_scr "" \\
# j_mem "" \\
# j_cor "" \\
# f_in "" \\
# t_out ""

#  Running the above... -------------------------------------------------------
# echoTest "${infiles[@]}"
remaining=(
    "${infiles[3]}"
    "${infiles[4]}"
    "${infiles[5]}"
    "${infiles[6]}"
    "${infiles[7]}"
    "${infiles[8]}"
)
echoTest "${remaining[@]}"

# for i in "${infiles[@]}"; do
# for i in "${infiles[0]}"; do
# for i in "${infiles[1]}"; do
# for i in "${infiles[2]}"; do
# for i in "${remaining[@]}"; do
for i in "${infiles[1]}"; do
    f_in="${i}"  # echo "${f_in}"
    echo "#  ========================================================="
    echo "#  Establishing infile... ----------------------------------"
    echo "- ${f_in}"
    echo ""

    d_base="files_Trinity_genome-guided/$(echo "${f_in}" | cut -d "/" -f 1)"  # echo "${d_base}"
    pre="trinity_$(basename "${f_in}" ".Aligned.sortedByCoord.out.sc_all.bam")"  # echo "${prefix}"
    t_out="${d_base}/${pre}"  # echo "${d_t}"
    echo "#  Establishing outfile... ---------------------------------"
    echo "- ${d_base}"
    echo "- ${pre}"
    echo "- ${t_out}"
    echo ""

    intron="1002"  # echo "${intron}"
    echo "#  Setting intron parameter --------------------------------"
    echo "- ${intron}"
    echo ""

    echo "#  Comparing in and out... ---------------------------------"
    echo "- $(basename "${f_in}")"
    echo "- $(basename "${t_out}")"

    echo "#  ========================================================="
    echo ""

    [[ -d "${d_t}" ]] || mkdir -p "${d_t}"
    echo ""

    sbatch "./sh_err_out/${script_name}" \
        "${f_in}" \
        "${t_out}"
    sleep 0.2
    echo ""

    echo ""
    echo ""
done
```

<details>
<summary><i>Messages printed to terminal with successful calls of the submission script</i></summary>

```txt
#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
- files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
#  =========================================================


Submitted batch job 5452110



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
- files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
#  =========================================================


Submitted batch job 5452111



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed/bam_trim_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
- files_Trinity_genome-guided/files_processed/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
#  =========================================================


Submitted batch job 5452112



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-full
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
- files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
#  =========================================================


Submitted batch job 5452113



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-full
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
- files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
#  =========================================================


Submitted batch job 5452114



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-full/bam_trim-rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-full
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
- files_Trinity_genome-guided/files_processed-full/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================


Submitted batch job 5452115



```
</details>
<br />
<br />

<a id="previous-shell-script-for-submitting-genome-guided-trinity-jobs"></a>
## Previous shell script for submitting genome-guided `Trinity` jobs
```bash
#!/bin/bash

#  Define variables
d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
d_guided="${d_work}/exp_alignment_STAR_tags/multi-hit-mode/files_bams"
f_guided="${d_guided}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"
prefix_0="Trinity_trial"
prefix_1="genome-guided"
prefix_2="$(echo $(basename "${f_guided}") | cut -d . -f 5)"
prefix="${prefix_0}_${prefix_1}_${prefix_2}"
intron=1002
script="submit-Trinity-trial-genome-guided.sh"
d_master="${d_work}/exp_${prefix_0}"
d_exp="${d_master}/exp_${prefix}"

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

infile="\${1}"
intron="\${2}"
outdir="\${3}"
prefix="\${4}"

echo "echo test:"
echo -e "Trinity \\ \n\
    --max_memory 50G \\ \n\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --SS_lib_type FR \\ \n\
    --genome_guided_bam "\${infile}" \\ \n\
    --genome_guided_max_intron "\${intron}" \\ \n\
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
    --genome_guided_bam "\${infile}" \\
    --genome_guided_max_intron "\${intron}" \\
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
<br />
<br />


<details>
<summary><i>Scrap #1</i></summary>

```bash
# #  Set up a function for doing the above kind of find -------------------------
# find_merged_bams() {
#     find ${1} \
#         -type f \
#         \( -name "*_Q_IP_*_1_*.bam" -o \
#            -name "*_Q_IP_*_10_*.bam" -o \
#            -name "*_Q_IP_*_100_*.bam" \) \
#         -print0 |
#             sort -z
# }
#
#
# find_merged_bams "${d_symlinked}/files_unprocessed/bam_"*"_merge/Local"
# find_merged_bams "${d_symlinked}/files_processed/bam_"*"_merge/EndToEnd"
# find_merged_bams "${d_symlinked}/files_processed-full/bam_"*"_merge/EndToEnd"
# #NOTE Can't use this: functions can only return one element
```
</details>
<br />

<details>
<summary><i>Scrap #2</i></summary>

```bash
parallel --header : --colsep " " -k -j 1 echo \
    'echo {chicken} \
        ">" ">(tee -a {chicken}.stdout.log)" \
        "2>" ">(tee -a {chicken}.stderr.log >&2)"' \
::: chicken "monkey"

parallel --header : --colsep " " -k -j 1 echo \
    'echo {chicken} \
        > >(tee -a {chicken}.stdout.log) \
        2> >(tee -a {chicken}.stderr.log >&2)' \
::: chicken "monkey"
```
</details>
<br />

<details>
<summary><i>Scrap #3</i></summary>

```bash
#  This is how to call with echo and include the writing to STDOUT and STDERR
#+ in the echo'd message
parallel --header : --colsep " " -k -j 1 echo \
    'singularity shell \
        --no-home \
        --bind {d_exp} \
        --bind {d_scr} \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --genome_guided_bam {f_in} \
                --genome_guided_max_intron 1002 \
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
                --min_contig_length 200 \
                    ">" ">(tee -a {t_out}/stdout.log)" \
                    "2>" ">(tee -a {t_out}/stderr.log >&2)"' \
::: d_exp "$(pwd)" \
::: d_scr "/loc/scratch" \
::: j_mem "50G" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: f_in "${f_in}" \
:::+ t_out "${t_out}"

#  This, I think, is how to call command and have the STDOUT and STDERR written
#+ to the corresponding redirects
parallel --header : --colsep " " -k -j 1 \
    'singularity shell \
        --no-home \
        --bind {d_exp} \
        --bind {d_scr} \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --genome_guided_bam {f_in} \
                --genome_guided_max_intron 1002 \
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
                --min_contig_length 200 \
                    > >(tee -a {t_out}/stdout.log) \
                    2> >(tee -a {t_out}/stderr.log >&2)' \
::: d_exp "$(pwd)" \
::: d_scr "/loc/scratch" \
::: j_mem "50G" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: f_in "${f_in}" \
:::+ t_out "${t_out}"
```
</details>
<br />

<details>
<summary><i>Scrap #4</i></summary>

```bash
#  Run the command ------------------------------------------------------------
singularity run \\
    --no-home \\
    --bind \$(pwd) \\
    --bind /loc/scratch \\
    ~/singularity-docker-etc/Trinity.sif \\
        Trinity \\
            --verbose \\
            --max_memory 50G \\
            --CPU \${SLURM_CPUS_ON_NODE} \\
            --SS_lib_type FR \\
            --genome_guided_bam \${in} \\
            --genome_guided_max_intron 1002 \\
            --jaccard_clip \\
            --output \${out} \\
            --full_cleanup \\
            --min_kmer_cov 1 \\
            --min_iso_ratio 0.05 \\
            --min_glue 2 \\
            --glue_factor 0.05 \\
            --max_reads_per_graph 2000 \\
            --normalize_max_read_cov 200 \\
            --group_pairs_distance 700 \\
            --min_contig_length 200 \\
                > >(tee -a \${out}/stdout.log) \\
                2> >(tee -a \${out}/stderr.log >&2)
```
</details>
<br />
