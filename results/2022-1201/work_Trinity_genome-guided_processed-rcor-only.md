
`#work_Trinity_genome-guided_processed-rcor-only.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up and run a trial `echo` test to test the setup](#set-things-up-and-run-a-trial-echo-test-to-test-the-setup)
1. [Build the script for submitting genome-guided `Trinity` jobs](#build-the-script-for-submitting-genome-guided-trinity-jobs)
    1. [Run `echo` tests](#run-echo-tests)
1. [Submit and run genome-guided `Trinity` jobs](#submit-and-run-genome-guided-trinity-jobs)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-things-up-and-run-a-trial-echo-test-to-test-the-setup"></a>
## Set things up and run a trial `echo` test to test the setup
```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 core, defaults

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
    files_processed-rcor-only/bam_*_merge/Local
    files_processed-rcor-only/bam_*_merge/EndToEnd
)
# echoTest "${d_in[@]}"
# echo "${#d_in[@]}"

unset infiles
typeset -a infiles
for i in "${d_in[@]}"; do
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"

    # while IFS=" " read -r -d $'\0'; do
    #     infiles+=( "${REPLY}" )
    # done < <(\
    #     find "${i}" \
    #         -type f \
    #         \( -name "*_Q_IP_*_1_*.bam" -o \
    #            -name "*_Q_IP_*_10_*.bam" -o \
    #            -name "*_Q_IP_*_100_*.bam" \) \
    #         -print0 |
    #             sort -z
    # )

    #  Forgot to do these in addition to the above files
    while IFS=" " read -r -d $'\0'; do
        infiles+=( "${REPLY}" )
    done < <(\
        find "${i}" \
            -type f \
            \( -name "*_Q_IP_*_5_*.bam" -o \
               -name "*_Q_IP_*_15_*.bam" -o \
               -name "*_Q_IP_*_50_*.bam" \) \
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
pre="trinity_$(basename "${f_in}" ".Aligned.sortedByCoord.out.sc_all.bam")"  # echo "${pre}"
t_out="${d_base}/${pre}"  # echo "${t_out}"

echo "${SLURM_CPUS_ON_NODE}"
echo "${f_in}"
echo "${intron}"
echo "${d_base}"
echo "${pre}"
echo "${t_out}"

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
<summary><i>Results of echo test printed to terminal (newlines added by me)</i></summary>

```txt
singularity run \
    --no-home \
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 \
    --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif \
        Trinity \
        --verbose \
        --max_memory 50G \
        --CPU 6 \
        --SS_lib_type FR \
        --genome_guided_bam files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam \
        --genome_guided_max_intron 1002 \
        --jaccard_clip \
        --output files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd \
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
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 \
    --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif \
        Trinity \
        --verbose \
        --max_memory 50G \
        --CPU 6 \
        --SS_lib_type FR \
        --genome_guided_bam files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam \
        --genome_guided_max_intron 1002 \
        --jaccard_clip \
        --output files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd \
        --full_cleanup \
        --min_kmer_cov 1 \
        --min_iso_ratio 0.05 \
        --min_glue 2 \
        --glue_factor 0.05 \
        --max_reads_per_graph 2000 \
        --normalize_max_read_cov 200 \
        --group_pairs_distance 700 \
        --min_contig_length 200
```
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
    t_out="${d_base}/${pre}"  # echo "${t_out}"
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

    [[ -d "${t_out}" ]] || mkdir -p "${t_out}"
    echo ""

    bash "./sh_err_out/${script_name}" \
        "${f_in}" \
        "${t_out}"

    echo ""
    echo ""
done
```

<details>
<summary><i>Spot checking one of the echo tests</i></summary>

```txt
#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd
#  =========================================================

mkdir: created directory 'files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd'

singularity run --no-home --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif Trinity --verbose --max_memory 50G --CPU 6 --SS_lib_type FR --genome_guided_bam files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam --genome_guided_max_intron 1002 --jaccard_clip --output files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd --full_cleanup --min_kmer_cov 1 --min_iso_ratio 0.05 --min_glue 2 --glue_factor 0.05 --max_reads_per_graph 2000 --normalize_max_read_cov 200 --group_pairs_distance 700 --min_contig_length 200
```

<summary><i>With newlines added...</i></summary>

```txt
singularity run \
    --no-home \
    --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201 \
    --bind /loc/scratch /home/kalavatt/singularity-docker-etc/Trinity.sif \
        Trinity \
        --verbose \
        --max_memory 50G \
        --CPU 6 \
        --SS_lib_type FR \
        --genome_guided_bam files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam \
        --genome_guided_max_intron 1002 \
        --jaccard_clip \
        --output files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd \
        --full_cleanup \
        --min_kmer_cov 1 \
        --min_iso_ratio 0.05 \
        --min_glue 2 \
        --glue_factor 0.05 \
        --max_reads_per_graph 2000 \
        --normalize_max_read_cov 200 \
        --group_pairs_distance 700 \
        --min_contig_length 200
```
</details>
<br />
<br />

<a id="submit-and-run-genome-guided-trinity-jobs"></a>
## Submit and run genome-guided `Trinity` jobs
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
    t_out="${d_base}/${pre}"  # echo "${t_out}"
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

    [[ -d "${t_out}" ]] || mkdir -p "${t_out}"
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

<summary><i>1, 10, 100</i></summary>

```txt
#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/Local/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local
#  =========================================================


Submitted batch job 6719414



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/Local/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local
#  =========================================================


Submitted batch job 6719415



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/Local/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local
#  =========================================================


Submitted batch job 6719431



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
#  =========================================================


Submitted batch job 6719432



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
#  =========================================================


Submitted batch job 6719433



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
#  =========================================================


Submitted batch job 6719434



```

<summary><i>5, 15, 50</i></summary>

```txt
#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/Local/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_Local
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_Local
#  =========================================================


Submitted batch job 6776773



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/Local/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_Local
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_Local
#  =========================================================


Submitted batch job 6776774



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/Local/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_Local.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_Local
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_Local

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_Local.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_Local
#  =========================================================


Submitted batch job 6776775



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_EndToEnd
#  =========================================================


Submitted batch job 6776776



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd
#  =========================================================


Submitted batch job 6776777



#  =========================================================
#  Establishing infile... ----------------------------------
- files_processed-rcor-only/bam_rcor-cor_split_merge/EndToEnd/5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

#  Establishing outfile... ---------------------------------
- files_Trinity_genome-guided/files_processed-rcor-only
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd
- files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd

#  Setting intron parameter --------------------------------
- 1002

#  Comparing in and out... ---------------------------------
- 5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd
#  =========================================================


Submitted batch job 6776778



```
</details>
<br />
