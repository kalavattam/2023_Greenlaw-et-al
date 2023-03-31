
`#work_count_features_htseq-count.md`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [Run `htseq-count` on bams in `bams_renamed/`](#run-htseq-count-on-bams-in-bams_renamed)
    1. [Run `htseq-count` on bams in `bams_renamed/` with `combined_SC_KL_20S.gff3`](#run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_kl_20sgff3)
        1. [Set up outfile directories](#set-up-outfile-directories)
            1. [Code](#code-1)
        1. [Set up arrays](#set-up-arrays)
            1. [Code](#code-2)
        1. [Index all bams in arrays](#index-all-bams-in-arrays)
            1. [Code](#code-3)
        1. [Run `htseq-count` with ...](#run-htseq-count-with-)
            1. [Set up necessary variables](#set-up-necessary-variables)
                1. [Code](#code-4)
            1. [Set up and submit `htseq-count` jobs](#set-up-and-submit-htseq-count-jobs)
                1. [Code](#code-5)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="get-situated"></a>
## Get situated
<a id="code"></a>
### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# tmux new -s htseq
# tmux a -t htseq

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

source activate gff3_env

.,
```
</details>
<br />

<details>
<summary><i>Printed: Get situated</i></summary>

```txt
❯ transcriptome &&
>     {
>         cd "results/2023-0215/" \
>             || echo "cd'ing failed; check on this..."
>     }
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215


❯ source activate gff3_env


❯ .,
total 22M
drwxrws---  8 kalavatt 2.0K Mar 30 12:24 ./
drwxrws--- 12 kalavatt  270 Mar 27 11:06 ../
drwxrws---  2 kalavatt  259 Mar 14 15:52 bams/
drwxrws---  8 kalavatt  175 Mar 14 15:54 bams_renamed/
drwxrws---  4 kalavatt   53 Mar 27 14:01 infiles_gtf-gff3/
drwxrws---  4 kalavatt  170 Mar 30 12:24 notebook/
drwxrws---  4 kalavatt   53 Mar 30 11:19 outfiles_gtf-gff3/
drwxrws---  4 kalavatt   53 Mar 28 12:32 outfiles_htseq-count/
-rw-rw----  1 kalavatt  31K Mar  3 09:16 test_count_features.md
-rw-rw----  1 kalavatt  25K Mar 29 10:48 work_assessment-processing_gtfs.md
-rw-rw----  1 kalavatt 736K Mar 30 12:24 work_assessment-processing_gtfs.nb.html
-rw-rw----  1 kalavatt  21K Mar 30 12:24 work_assessment-processing_gtfs.Rmd
-rw-rw----  1 kalavatt  78K Mar 29 10:48 work_count_features_featureCounts.md
-rw-rw----  1 kalavatt  12K Mar 29 10:48 work_count_features_htseq-count.md
-rw-rw----  1 kalavatt 217K Mar 30 12:24 work_env-building.md
-rw-rw----  1 kalavatt 3.2M Mar 29 10:48 work_evaluation-etc_rough-draft_Rrp6-WT_SS_timecourse_groupwise.nb.html
-rw-rw----  1 kalavatt  51K Mar 29 10:48 work_evaluation-etc_rough-draft_Rrp6-WT_SS_timecourse_groupwise.Rmd
-rw-rw----  1 kalavatt 1.9M Mar 29 10:48 work_evaluation-etc_variables_pairwise-groupwise.nb.html
-rw-rw----  1 kalavatt  50K Mar 29 10:48 work_evaluation-etc_variables_pairwise-groupwise.Rmd
-rw-rw----  1 kalavatt  39K Mar 29 10:48 work_evaluation-etc_variables_pairwise-groupwise.tmp-gw.R
-rw-rw----  1 kalavatt  33K Mar 29 10:48 work_evaluation-etc_variables_pairwise-groupwise.tmp-pw.R
-rw-rw----  1 kalavatt 6.7K Mar 29 10:48 work_evaluation-etc_variables_pairwise-groupwise.TODOs-scraps-etc.txt
-rw-rw----  1 kalavatt 656K Mar  3 09:16 work_gff3_convert-strand-designations.nb.html
-rw-rw----  1 kalavatt 2.0K Mar  3 09:16 work_gff3_convert-strand-designations.Rmd
-rw-rw----  1 kalavatt 6.8K Feb 22 16:21 work_gff3_include-20S.md
-rw-rw----  1 kalavatt 5.6K Feb 22 16:21 work_model-variables.md
-rw-rw----  1 kalavatt 2.5M Mar 13 16:33 work_normalization-etc_rough-draft_NNS_vary-on-transcription.nb.html
-rw-rw----  1 kalavatt  33K Mar 13 16:33 work_normalization-etc_rough-draft_NNS_vary-on-transcription.Rmd
-rw-rw----  1 kalavatt 1.1M Mar 29 10:48 work_normalization-etc_rough-draft_OsTIR-NNS_vary-on-strain.nb.html
-rw-rw----  1 kalavatt  59K Mar 29 10:48 work_normalization-etc_rough-draft_OsTIR-NNS_vary-on-strain.Rmd
-rw-rw----  1 kalavatt 4.5M Mar 29 10:48 work_normalization-etc_rough-draft_wild-type_vary-on-state_antisense.nb.html
-rw-rw----  1 kalavatt  64K Mar 29 10:48 work_normalization-etc_rough-draft_wild-type_vary-on-state_antisense.Rmd
-rw-rw----  1 kalavatt 803K Mar 29 10:48 work_normalization-etc_rough-draft_wild-type_vary-on-state.nb.html
-rw-rw----  1 kalavatt  53K Mar 29 10:48 work_normalization-etc_rough-draft_wild-type_vary-on-state.Rmd
```
</details>
<br />
<br />

<a id="run-htseq-count-on-bams-in-bams_renamed"></a>
## Run `htseq-count` on bams in `bams_renamed/`
<a id="run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_kl_20sgff3"></a>
### Run `htseq-count` on bams in `bams_renamed/` with `combined_SC_KL_20S.gff3`
<a id="set-up-outfile-directories"></a>
#### Set up outfile directories
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

for h in ./outfiles_htseq-count/already/combined-SC-KL-20S/U*; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p outfiles_htseq-count/already/combined-SC-KL-20S/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}/err_out
    else
        echo "Directories present; skipping mkdir'ing of outfile directories"
    fi

    break
done
```
</details>
<br />

<a id="set-up-arrays"></a>
#### Set up arrays
<a id="code-2"></a>
##### Code
<details>
<summary><i>Code: Set up arrays</i></summary>

```bash
#!/bin/bash

unset UT_prim_UMI
typeset -a UT_prim_UMI
while IFS=" " read -r -d $'\0'; do
    UT_prim_UMI+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_UMI" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_UMI
typeset -a UTK_prim_UMI
while IFS=" " read -r -d $'\0'; do
    UTK_prim_UMI+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_UMI" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UT_prim_pos
typeset -a UT_prim_pos
while IFS=" " read -r -d $'\0'; do
    UT_prim_pos+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_pos" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_pos
typeset -a UTK_prim_pos
while IFS=" " read -r -d $'\0'; do
    UTK_prim_pos+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_pos" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UT_prim_no
typeset -a UT_prim_no
while IFS=" " read -r -d $'\0'; do
    UT_prim_no+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_no" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_no
typeset -a UTK_prim_no
while IFS=" " read -r -d $'\0'; do
    UTK_prim_no+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_no" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

echo_test "${UT_prim_UMI[@]}"
echo_test "${UTK_prim_UMI[@]}"
echo_test "${UT_prim_pos[@]}"
echo_test "${UTK_prim_pos[@]}"
echo_test "${UT_prim_no[@]}"
echo_test "${UTK_prim_no[@]}"

echo "${#UT_prim_UMI[@]}"
echo "${#UTK_prim_UMI[@]}"
echo "${#UT_prim_pos[@]}"
echo "${#UTK_prim_pos[@]}"
echo "${#UT_prim_no[@]}"
echo "${#UTK_prim_no[@]}"
```
</details>
<br />

<a id="index-all-bams-in-arrays"></a>
#### Index all bams in arrays
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Index all bams in arrays</i></summary>

```bash
#!/bin/bash

for h in ./bams_renamed/UT_prim_UMI/*.bai; do
    if [[ ! -e "${h}" ]]; then
        ml SAMtools/1.16.1-GCC-11.2.0

        for i in \
            "${UT_prim_UMI[@]}" \
            "${UTK_prim_UMI[@]}" \
            "${UT_prim_pos[@]}" \
            "${UTK_prim_pos[@]}" \
            "${UT_prim_no[@]}" \
            "${UTK_prim_no[@]}"; do
                echo "${i}"
                samtools index -@ "${SLURM_CPUS_ON_NODE}" "${i}"

            module purge SAMtools/1.16.1-GCC-11.2.0
        done
    else
        echo "Bam indices exist; skipping the running of samtools index"
    fi

    break
done
```
</details>
<br />

<a id="run-htseq-count-with-"></a>
#### Run `htseq-count` with ...
<a id="set-up-necessary-variables"></a>
##### Set up necessary variables
<a id="code-4"></a>
###### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash

gtf="infiles_gtf-gff3/already/combined_SC_KL_20S.gff3"  # echo "${gtf}"  # ., "${gtf}"

job_name="run_htseq-count"  # echo "${job_name}"
threads=8  # echo "${threads}"

job_no_max=24  # echo "${job_no_max}"

# echo_test "${UT_prim_UMI[@]}"
# echo "${#UT_prim_UMI[@]}"
```
</details>
<br />

<a id="set-up-and-submit-htseq-count-jobs"></a>
##### Set up and submit `htseq-count` jobs
<a id="code-5"></a>
###### Code
<details>
<summary><i>Code: Run htseq-count with combined_SC_KL.gff3</i></summary>

`#TODO` `#IMPORTANT` Change `--type "exon"` to `--type "mRNA"`
`#TODO` `#QUESTION` Need to change `--idattr "ID"`?
```bash
#!/bin/bash

h=0
# for i in "strd-eq"; do
for i in "strd-eq" "strd-rv"; do
    # for j in "${UT_prim_UMI[0]}" \
    #          "${UT_prim_UMI[1]}" \
    #          "${UT_prim_UMI[2]}" \
    #          "${UT_prim_UMI[3]}" \
    #          "${UT_prim_UMI[4]}" \
    #          "${UT_prim_UMI[5]}";
    # do
    for j in "${UT_prim_UMI[@]}"; do
        # i="strd-eq"  # echo "${i}"
        # j="${UT_prim_UMI[0]}"  # echo "${j}"


        #  -------------------------------------
        in="${j}"  # echo "${in}"
        
        out="$(
            echo "${in}" \
                | sed 's:bams_renamed:outfiles_htseq-count\/already\/combined-SC-KL-20S:g' \
                | sed 's:.bam::g'
        ).hc-${i}.tsv"   # echo "${out}"  # ., "$(dirname "${out}")"

        err_out="$(
            dirname "${out}"
        )/err_out/$(
            basename "${out}" .tsv
        )"  # echo "${err_out}"  # ., "$(dirname "${err_out}")"


        #  -------------------------------------
        let h++
        iter="${h}"
        echo "        #  -------------------------------------"
        printf "        Iteration '%d'\n" "${iter}"

        echo """
        Running htseq-count
                    directory                                                            file
                in  $(dirname ${in})                                             $(basename ${in})
               out  $(dirname ${out})          $(basename ${out})
            stdout  $(dirname ${err_out})  $(basename ${err_out}).stdout.txt
            stderr  $(dirname ${err_out})  $(basename ${err_out}).stderr.txt
        """

        if [[ "${i}" == "strd-eq" ]]; then
            hc_strd="yes"  # echo "${hc_strd}"
        elif [[ "${i}" == "strd-rv" ]]; then
            hc_strd="reverse"  # echo "${hc_strd}"
        fi


        #  -------------------------------------
        echo "\
        srun \\
            --job-name=${job_name} \\
            --nodes=1 \\
            --cpus-per-task=${threads} \\
            --error=${err_out}.%A.stderr.txt \\
            --output=${err_out}.%A.stdout.txt \\
            htseq-count \\
                --order \"pos\" \\
                --stranded \"${hc_strd}\" \\
                --nonunique \"none\" \\
                --type \"mRNA\" \\
                --idattr \"ID\" \\
                --nprocesses ${threads} \\
                --counts_output \"${out}\" \\
                --with-header \\
                \"${in}\" \\
                \"${gtf}\" \\
                     > >(tee -a \"${err_out}.stdout.txt\") \\
                    2> >(tee -a \"${err_out}.stderr.txt\")
        "
        # (Scraps)
        # --array=${iter}-${max_id_job}%${max_id_task} \
        # --array=1-${max_id_job}%${max_id_task} \


        #  -------------------------------------
        # start="$(date +%s)"

        # if [[ $(( tally - 1 )) -ge ${job_no_max} ]]; then
        #     echo TRUE
        # else
        #     echo FALSE
        # fi
        
        # tally="$(squeue -u $(whoami) | grep -c "${job_name}")"  #TODO Debug this
        tally="$(squeue -u $(whoami) | wc -l)"  # echo "${tally}"
        while [[ $(( tally - 1 )) -ge ${job_no_max} ]]; do
            sleep 5
            printf "."
            tally="$(squeue -u $(whoami) | wc -l)"
        done

        sbatch \
            --job-name=${job_name} \
            --nodes=1 \
            --cpus-per-task=${threads} \
            --error=${err_out}.%A.stderr.txt \
            --output=${err_out}.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "${hc_strd}" \
                --nonunique "none" \
                --type "mRNA" \
                --idattr "ID" \
                --nprocesses ${threads} \
                --counts_output "${out}" \
                --with-header \
                "${in}" \
                "${gtf}"
        
        # end="$(date +%s)"
        #
        # run_time="$(echo "${end}" - "${start}" | bc -l)"
        # printf 'Run time: %dh:%dm:%ds\n' \
        #     $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))

        sleep 0.5
        echo ""
    done
done
```
</details>
<br />

```bash
#!/bin/bash

#  Already ----------------------------
p_gen="${HOME}/genomes"
p_gtf="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3/already"

if [[ ! -d "${p_gtf}" ]]; then mkdir -p "${p_gtf}"; fi

#  Check that files exist with the given paths
., "${p_gen}/combined_AG/gtf/combined_AG.gtf"
., "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL_20S.gff3"
., "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
., "${p_gen}/kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3"
., "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf"
., "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"

#  Copy in necessary files
if [[ ! -f "${p_gtf}/combined_AG.gtf" ]]; then
    cp \
        "${p_gen}/combined_AG/gtf/combined_AG.gtf" \
        "${p_gtf}/combined_AG.gtf"
fi

if [[ ! -f "${p_gtf}/combined_SC_KL_20S.gff3" ]]; then
    cp \
        "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL_20S.gff3" \
        "${p_gtf}/combined_SC_KL_20S.gff3"
fi

if [[ ! -f "${p_gtf}/combined_SC_KL.gff3" ]]; then
    cp \
        "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL.gff3" \
        "${p_gtf}/combined_SC_KL.gff3"
fi

if [[ ! -f "${p_gtf}/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3" ]]; then
    cp \
        "${p_gen}/kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3" \
        "${p_gtf}/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3"
fi

if [[ ! -f "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.gtf" ]]; then
    cp \
        "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
        "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.gtf"
fi

if [[ ! -f "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" ]]; then
    cp \
        "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" \
        "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"
fi


#  Trinity-GG -------------------------
p_trinity="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_GMAP_rough-draft/Trinity-GG"
p_gtf="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3"

if [[ ! -d "${p_gtf}/Trinity-GG" ]]; then
    echo " No \${p_gtf}/Trinity-GG... Copying it in now"
    cp -r "${p_trinity}" "${p_gtf}"
fi
```
