
`#work_count_features-whole-genome_htseq-count.md`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [Run `htseq-count` on bams in `bams_renamed/` with `combined_SC_KL_20S.gff3`](#run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_kl_20sgff3)
    1. [Set up outfile directories](#set-up-outfile-directories)
        1. [Code](#code-1)
    1. [Set up arrays of bams](#set-up-arrays-of-bams)
        1. [Code](#code-2)
    1. [Index bams](#index-bams)
        1. [Code](#code-3)
    1. [Run `htseq-count` with `processed_features-intergenic_sense-antisense.gtf`](#run-htseq-count-with-processed_features-intergenic_sense-antisensegtf)
        1. [Set up necessary variables](#set-up-necessary-variables)
            1. [Code](#code-4)
        1. [Set up and submit `htseq-count` jobs](#set-up-and-submit-htseq-count-jobs)
            1. [Code](#code-5)
            1. [Printed](#printed)

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

<a id="run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_kl_20sgff3"></a>
## Run `htseq-count` on bams in `bams_renamed/` with `combined_SC_KL_20S.gff3`
<a id="set-up-outfile-directories"></a>
### Set up outfile directories
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

for h in ./outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/U*; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out
    else
        echo "Directories present; skipping mkdir'ing of outfile directories"
    fi

    break
done
```
</details>
<br />

<a id="set-up-arrays-of-bams"></a>
### Set up arrays of bams
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Set up arrays</i></summary>

```bash
#!/bin/bash

unset UT_prim_UMI
typeset -a UT_prim_UMI
while IFS=" " read -r -d $'\0'; do
    UT_prim_UMI+=( "${REPLY}" )
done < <(
    find "bams_renamed/UT_prim_UMI" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z
)

echo_test "${UT_prim_UMI[@]}"
echo "${#UT_prim_UMI[@]}"
```
</details>
<br />

<a id="index-bams"></a>
### Index bams
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Index all bams in arrays</i></summary>

```bash
#!/bin/bash

for h in ./bams_renamed/UT_prim_UMI/*.bai; do
    if [[ ! -e "${h}" ]]; then
        ml SAMtools/1.16.1-GCC-11.2.0

        for i in "${UT_prim_UMI[@]}"; do
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

<a id="run-htseq-count-with-processed_features-intergenic_sense-antisensegtf"></a>
### Run `htseq-count` with `processed_features-intergenic_sense-antisense.gtf`
<a id="set-up-necessary-variables"></a>
#### Set up necessary variables
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash




# echo_test "${UT_prim_UMI[@]}"
# echo "${#UT_prim_UMI[@]}"
```
</details>
<br />

<a id="set-up-and-submit-htseq-count-jobs"></a>
#### Set up and submit `htseq-count` jobs
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Set up and submit htseq-count jobs</i></summary>

```bash
#!/bin/bash

job_name="run_htseq-count"  # echo "${job_name}"
threads=12  # echo "${threads}"
job_no_max=24  # echo "${job_no_max}"

echo "Combination of infiles is..."
echo "${UT_prim_UMI[*]}"  # in

stranded="strd-eq"  # echo "${stranded}"

unset gtfs
typeset -a gtfs=(
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf"
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf"
)

h=0
for gtf in ${gtfs[@]}; do
    out="$(
        echo $(dirname "${gtf}") \
            | sed 's:outfiles_gtf-gff3:outfiles_htseq-count:g'
    )/UT_prim_UMI/$(
        basename ${gtf} .gtf
    ).all-bams.hc-${stranded}.tsv" # echo "${out}"  # ., "$(dirname "${out}")"
    err_out="$(dirname "${out}")/err_out/$(basename "${out}" .tsv)"  # echo "${err_out}"  # ., "$(dirname "${err_out}")"

    # echo """
    # Running htseq-count
    #             directory                                                                                       file
    #        out  $(dirname ${out})          $(basename ${out})
    #     stdout  $(dirname ${err_out})  $(basename ${err_out}).stdout.txt
    #     stderr  $(dirname ${err_out})  $(basename ${err_out}).stderr.txt
    # """

    if [[ "${stranded}" == "strd-eq" ]]; then
        hc_strd="yes"  # echo "${hc_strd}"
    elif [[ "${stranded}" == "strd-op" ]]; then
        hc_strd="reverse"  # echo "${hc_strd}"
    fi

    unset nonunique_options
    typeset -a nonunique_options=(
        "none"
        "all"
        "fraction"
        "random"
    )
    for nonunique in "${nonunique_options[@]}"; do 
        let h++
        iter="${h}"
        echo "        #  -------------------------------------"
        printf "        Iteration '%d'\n" "${iter}"
        echo """
        sbatch \\
            --job-name=${job_name}_${nonunique} \\
            --nodes=1 \\
            --cpus-per-task=${threads} \\
            --error=${err_out}.%A.stderr.txt \\
            --output=${err_out}.%A.stdout.txt \\
            htseq-count \\
                --order \"pos\" \\
                --stranded \"${hc_strd}\" \\
                --nonunique \"${nonunique}\" \\
                --type \"feature\" \\
                --idattr \"gene_id\" \\
                --nprocesses ${threads} \\
                --counts_output \"${out%.tsv}.${nonunique}.tsv\" \\
                --with-header \\
                ${UT_prim_UMI[*]} \\
                \"${gtf}\" \\
                     > >(tee -a \"${err_out}.${nonunique}.stdout.txt\") \\
                    2> >(tee -a \"${err_out}.${nonunique}.stderr.txt\")
        
        """

        sbatch \
            --job-name="${job_name}_${nonunique}" \
            --nodes=1 \
            --cpus-per-task="${threads}" \
            --error="${err_out}.%A.stderr.txt" \
            --output="${err_out}.%A.stdout.txt" \
            htseq-count \
                --order "pos" \
                --stranded "${hc_strd}" \
                --nonunique "${nonunique}" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses "${threads}" \
                --counts_output "${out%.tsv}.${nonunique}.tsv" \
                --with-header \
                ${UT_prim_UMI[*]} \
                "${gtf}" \
                     > >(tee -a "${err_out}.${nonunique}.stdout.txt") \
                    2> >(tee -a "${err_out}.${nonunique}.stderr.txt")

        sleep 0.5
        echo ""
    done
done
```
</details>
<br />

<a id="printed"></a>
##### Printed
<details>
<summary><i>Printed: Set up and submit htseq-count jobs</i></summary>

```txt
        #  -------------------------------------
        Iteration '1'

        sbatch \
            --job-name=run_htseq-count_none \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "none" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.none.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.none.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.none.stderr.txt")


Submitted batch job 19968436

        #  -------------------------------------
        Iteration '2'

        sbatch \
            --job-name=run_htseq-count_all \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "all" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.all.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.all.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.all.stderr.txt")


Submitted batch job 19968437

        #  -------------------------------------
        Iteration '3'

        sbatch \
            --job-name=run_htseq-count_fraction \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "fraction" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.fraction.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.fraction.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.fraction.stderr.txt")


Submitted batch job 19968438

        #  -------------------------------------
        Iteration '4'

        sbatch \
            --job-name=run_htseq-count_random \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "random" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.random.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.random.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense-antisense.all-bams.hc-strd-eq.random.stderr.txt")


Submitted batch job 19968439

        #  -------------------------------------
        Iteration '5'

        sbatch \
            --job-name=run_htseq-count_none \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "none" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense.all-bams.hc-strd-eq.none.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.none.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.none.stderr.txt")


Submitted batch job 19968441

        #  -------------------------------------
        Iteration '6'

        sbatch \
            --job-name=run_htseq-count_all \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "all" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense.all-bams.hc-strd-eq.all.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.all.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.all.stderr.txt")


Submitted batch job 19968442

        #  -------------------------------------
        Iteration '7'

        sbatch \
            --job-name=run_htseq-count_fraction \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "fraction" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense.all-bams.hc-strd-eq.fraction.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.fraction.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.fraction.stderr.txt")


Submitted batch job 19968443

        #  -------------------------------------
        Iteration '8'

        sbatch \
            --job-name=run_htseq-count_random \
            --nodes=1 \
            --cpus-per-task=12 \
            --error=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stderr.txt \
            --output=outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "yes" \
                --nonunique "random" \
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses 12 \
                --counts_output "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/processed_features-intergenic_sense.all-bams.hc-strd-eq.random.tsv" \
                --with-header \
                bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam bams_renamed/UT_prim_UMI/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam \
                "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf" \
                     > >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.random.stdout.txt") \
                    2> >(tee -a "outfiles_htseq-count/comprehensive/S288C_reference_genome_R64-1-1_20110203/UT_prim_UMI/err_out/processed_features-intergenic_sense.all-bams.hc-strd-eq.random.stderr.txt")


Submitted batch job 19968444
```
</details>
<br />