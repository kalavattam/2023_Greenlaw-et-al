
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
        1. [Set up variables, etc., then submit `htseq-count` jobs](#set-up-variables-etc-then-submit-htseq-count-jobs)
            1. [Code](#code-4)
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
<a id="set-up-variables-etc-then-submit-htseq-count-jobs"></a>
#### Set up variables, etc., then submit `htseq-count` jobs
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Set up variables, etc., then submit htseq-count jobs</i></summary>

```bash
#!/bin/bash

job_name="run_htseq-count"  # echo "${job_name}"
threads=12  # echo "${threads}"
# job_no_max=24  # echo "${job_no_max}"

echo "Combination of infiles is..."
echo "${UT_prim_UMI[*]}"  # in

stranded="strd-eq"  # echo "${stranded}"

unset gtfs
typeset -a gtfs=(
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf"
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf"
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_antisense.gtf"
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features_sense-antisense.gtf"
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features_sense.gtf"
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features_antisense.gtf"
)
# echo_test "${gtfs[@]}"
# echo "${#gtfs[@]}"

unset modes
typeset -a modes=(
    "union"
    "intersection-strict"
    "intersection-nonempty"
)
# echo_test "${modes[@]}"
# echo "${#modes[@]}"

unset nonunique_options
typeset -a nonunique_options=(
    "none"
    "all"
    "fraction"
    "random"
)
# echo_test "${nonunique_options[@]}"
# echo "${#nonunique_options[@]}"

h=0
for gtf in "${gtfs[@]}"; do
    for mode in "${modes[@]}"; do
        for nonunique in "${nonunique_options[@]}"; do 
            # gtf="${gtfs[4]}"  # echo "${gtf}"
            # mode="${modes[1]}"  # echo "${mode}"
            # nonunique="${nonunique_options[1]}"  # echo "${nonunique}"
            out="$(
                echo $(dirname "${gtf}") \
                    | sed 's:outfiles_gtf-gff3:outfiles_htseq-count:g'
            )/UT_prim_UMI/all-bams.hc-${stranded}.${mode}.nonunique-${nonunique}.$(
                basename ${gtf} .gtf
            ).tsv" # echo "${out}"  # ., "$(dirname "${out}")"
            err_out="$(dirname "${out}")/err_out/$(basename "${out}" .tsv)"  # echo "${err_out}"  # cd "$(dirname "${err_out}")"

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

            let h++
            iter="${h}"  # echo "${iter}"
            echo """
            #  -------------------------------------
            #+ Iteration ${iter}
            
            sbatch \\
                --job-name=${job_name}_mode-${mode}_nonunique-${nonunique} \\
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
                    --counts_output \"${out}\" \\
                    --with-header \\
                    ${UT_prim_UMI[*]} \\
                    \"${gtf}\" \\
                         > >(tee -a \"${err_out}.stdout.txt\") \\
                        2> >(tee -a \"${err_out}.stderr.txt\")
            
            """

            sbatch \
                --job-name="${job_name}_mode-${mode}_nonunique-${nonunique}" \
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
                    --counts_output "${out}" \
                    --with-header \
                    ${UT_prim_UMI[*]} \
                    "${gtf}"

            sleep 0.5
            echo ""
        done
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
❯ echo_test "${gtfs[@]}"
outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf
outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense.gtf
outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_antisense.gtf
outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features_sense-antisense.gtf
outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features_sense.gtf
outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features_antisense.gtf


❯ echo_test "${modes[@]}"
union
intersection-strict
intersection-nonempty


❯ echo_test "${nonunique_options[@]}"
none
all
fraction
random


❯ skal  #  Shortly after submitting the jobs
20098162 campus-ne run_htse kalavatt  R       1:16      1 gizmoj23 12
20098163 campus-ne run_htse kalavatt  R       1:13      1 gizmoj26 12
20098164 campus-ne run_htse kalavatt  R       1:10      1 gizmok160 12
20098165 campus-ne run_htse kalavatt  R       1:07      1 gizmoj36 12
20098166 campus-ne run_htse kalavatt  R       1:07      1 gizmoj22 12
20098167 campus-ne run_htse kalavatt  R       1:04      1 gizmok23 12
20098168 campus-ne run_htse kalavatt  R       1:04      1 gizmoj37 12
20098169 campus-ne run_htse kalavatt  R       1:04      1 gizmoj21 12
20098170 campus-ne run_htse kalavatt  R       1:01      1 gizmok157 12
20098171 campus-ne run_htse kalavatt  R       0:52      1 gizmoj33 12
20098172 campus-ne run_htse kalavatt  R       0:46      1 gizmoj35 12
20098173 campus-ne run_htse kalavatt  R       0:46      1 gizmoj30 12
20098174 campus-ne run_htse kalavatt  R       0:46      1 gizmoj29 12
20098175 campus-ne run_htse kalavatt  R       0:43      1 gizmoj28 12
20098176 campus-ne run_htse kalavatt  R       0:43      1 gizmok36 12
20098177 campus-ne run_htse kalavatt  R       0:43      1 gizmoj31 12
20098178 campus-ne run_htse kalavatt  R       0:43      1 gizmoj10 12
20098179 campus-ne run_htse kalavatt  R       0:43      1 gizmoj11 12
20098180 campus-ne run_htse kalavatt  R       0:43      1 gizmoj15 12
20098181 campus-ne run_htse kalavatt  R       0:43      1 gizmoj13 12
20098182 campus-ne run_htse kalavatt  R       0:43      1 gizmoj17 12
20098183 campus-ne run_htse kalavatt  R       0:43      1 gizmoj16 12
20098184 campus-ne run_htse kalavatt  R       0:40      1 gizmoj35 12
20098185 campus-ne run_htse kalavatt  R       0:40      1 gizmok83 12
20098186 campus-ne run_htse kalavatt  R       0:40      1 gizmoj9 12
20098187 campus-ne run_htse kalavatt  R       0:40      1 gizmoj30 12
20098188 campus-ne run_htse kalavatt  R       0:40      1 gizmoj31 12
20098189 campus-ne run_htse kalavatt  R       0:37      1 gizmoj28 12
20098190 campus-ne run_htse kalavatt  R       0:37      1 gizmok169 12
20098191 campus-ne run_htse kalavatt  R       0:37      1 gizmoj16 12
20098192 campus-ne run_htse kalavatt  R       0:37      1 gizmoj17 12
20098193 campus-ne run_htse kalavatt  R       0:37      1 gizmoj9 12
20098194 campus-ne run_htse kalavatt  R       0:37      1 gizmoj10 12
20098195 campus-ne run_htse kalavatt  R       0:37      1 gizmoj11 12
20098196 campus-ne run_htse kalavatt  R       0:34      1 gizmoj15 12
20098197 campus-ne run_htse kalavatt  R       0:31      1 gizmok156 12
20098198 campus-ne run_htse kalavatt  R       0:28      1 gizmok56 12
20098199 campus-ne run_htse kalavatt  R       0:28      1 gizmok81 12
20098200 campus-ne run_htse kalavatt  R       0:25      1 gizmok69 12
20098201 campus-ne run_htse kalavatt  R       0:25      1 gizmok98 12
20098202 campus-ne run_htse kalavatt  R       0:25      1 gizmok46 12
20098203 campus-ne run_htse kalavatt  R       0:25      1 gizmok123 12
20098204 campus-ne run_htse kalavatt  R       0:22      1 gizmok107 12
20098205 campus-ne run_htse kalavatt  R       0:22      1 gizmok12 12
20098206 campus-ne run_htse kalavatt  R       0:19      1 gizmok55 12
20098207 campus-ne run_htse kalavatt  R       0:19      1 gizmok60 12
20098208 campus-ne run_htse kalavatt  R       0:16      1 gizmok63 12
20098209 campus-ne run_htse kalavatt  R       0:16      1 gizmok148 12
20098210 campus-ne run_htse kalavatt  R       0:16      1 gizmok42 12
20098211 campus-ne run_htse kalavatt  R       0:16      1 gizmok129 12
20098212 campus-ne run_htse kalavatt  R       0:16      1 gizmok130 12
20098213 campus-ne run_htse kalavatt  R       0:13      1 gizmok108 12
20098214 campus-ne run_htse kalavatt  R       0:13      1 gizmok121 12
20098215 campus-ne run_htse kalavatt  R       0:13      1 gizmok97 12
20098216 campus-ne run_htse kalavatt  R       0:13      1 gizmok124 12
20098217 campus-ne run_htse kalavatt  R       0:13      1 gizmok89 12
20098218 campus-ne run_htse kalavatt  R       0:10      1 gizmok128 12
20098219 campus-ne run_htse kalavatt  R       0:10      1 gizmok1 12
20098220 campus-ne run_htse kalavatt  R       0:10      1 gizmok12 12
20098221 campus-ne run_htse kalavatt  R       0:10      1 gizmok35 12
20098222 campus-ne run_htse kalavatt  R       0:07      1 gizmok68 12
20098223 campus-ne run_htse kalavatt  R       0:07      1 gizmok135 12
20098224 campus-ne run_htse kalavatt  R       0:07      1 gizmok144 12
20098225 campus-ne run_htse kalavatt  R       0:07      1 gizmok48 12
20098226 campus-ne run_htse kalavatt  R       0:07      1 gizmok126 12
20098227 campus-ne run_htse kalavatt  R       0:07      1 gizmok150 12
20098228 campus-ne run_htse kalavatt  R       0:07      1 gizmok151 12
20098229 campus-ne run_htse kalavatt  R       0:04      1 gizmok62 12
20098230 campus-ne run_htse kalavatt  R       0:04      1 gizmok66 12
20098231 campus-ne run_htse kalavatt  R       0:04      1 gizmok44 12
20098232 campus-ne run_htse kalavatt  R       0:01      1 gizmok96 12
20098233 campus-ne run_htse kalavatt  R       0:01      1 gizmok70 12


❯ ls -1 *.2*.stderr.txt | wc -l  # From within the err_out/ directory
72


❯ ls -1 *.2*.stderr.txt  # From within the err_out/ directory
all-bams.hc-strd-eq.intersection-nonempty.nonunique-all.processed_features_antisense.20098231.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-all.processed_features-intergenic_antisense.20098195.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-all.processed_features-intergenic_sense.20098183.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-all.processed_features-intergenic_sense-antisense.20098171.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-all.processed_features_sense.20098219.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-all.processed_features_sense-antisense.20098207.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-fraction.processed_features_antisense.20098232.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-fraction.processed_features-intergenic_antisense.20098196.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-fraction.processed_features-intergenic_sense.20098184.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-fraction.processed_features-intergenic_sense-antisense.20098172.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-fraction.processed_features_sense.20098220.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-fraction.processed_features_sense-antisense.20098208.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-none.processed_features_antisense.20098230.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-none.processed_features-intergenic_antisense.20098194.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-none.processed_features-intergenic_sense.20098182.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-none.processed_features-intergenic_sense-antisense.20098170.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-none.processed_features_sense.20098218.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-none.processed_features_sense-antisense.20098206.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-random.processed_features_antisense.20098233.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-random.processed_features-intergenic_antisense.20098197.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-random.processed_features-intergenic_sense.20098185.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-random.processed_features-intergenic_sense-antisense.20098173.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-random.processed_features_sense.20098221.stderr.txt
all-bams.hc-strd-eq.intersection-nonempty.nonunique-random.processed_features_sense-antisense.20098209.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-all.processed_features_antisense.20098227.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-all.processed_features-intergenic_antisense.20098191.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-all.processed_features-intergenic_sense.20098179.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-all.processed_features-intergenic_sense-antisense.20098167.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-all.processed_features_sense.20098215.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-all.processed_features_sense-antisense.20098203.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-fraction.processed_features_antisense.20098228.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-fraction.processed_features-intergenic_antisense.20098192.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-fraction.processed_features-intergenic_sense.20098180.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-fraction.processed_features-intergenic_sense-antisense.20098168.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-fraction.processed_features_sense.20098216.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-fraction.processed_features_sense-antisense.20098204.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-none.processed_features_antisense.20098226.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-none.processed_features-intergenic_antisense.20098190.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-none.processed_features-intergenic_sense.20098178.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-none.processed_features-intergenic_sense-antisense.20098166.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-none.processed_features_sense.20098214.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-none.processed_features_sense-antisense.20098202.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-random.processed_features_antisense.20098229.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-random.processed_features-intergenic_antisense.20098193.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-random.processed_features-intergenic_sense.20098181.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-random.processed_features-intergenic_sense-antisense.20098169.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-random.processed_features_sense.20098217.stderr.txt
all-bams.hc-strd-eq.intersection-strict.nonunique-random.processed_features_sense-antisense.20098205.stderr.txt
all-bams.hc-strd-eq.union.nonunique-all.processed_features_antisense.20098223.stderr.txt
all-bams.hc-strd-eq.union.nonunique-all.processed_features-intergenic_antisense.20098187.stderr.txt
all-bams.hc-strd-eq.union.nonunique-all.processed_features-intergenic_sense.20098175.stderr.txt
all-bams.hc-strd-eq.union.nonunique-all.processed_features-intergenic_sense-antisense.20098163.stderr.txt
all-bams.hc-strd-eq.union.nonunique-all.processed_features_sense.20098211.stderr.txt
all-bams.hc-strd-eq.union.nonunique-all.processed_features_sense-antisense.20098199.stderr.txt
all-bams.hc-strd-eq.union.nonunique-fraction.processed_features_antisense.20098224.stderr.txt
all-bams.hc-strd-eq.union.nonunique-fraction.processed_features-intergenic_antisense.20098188.stderr.txt
all-bams.hc-strd-eq.union.nonunique-fraction.processed_features-intergenic_sense.20098176.stderr.txt
all-bams.hc-strd-eq.union.nonunique-fraction.processed_features-intergenic_sense-antisense.20098164.stderr.txt
all-bams.hc-strd-eq.union.nonunique-fraction.processed_features_sense.20098212.stderr.txt
all-bams.hc-strd-eq.union.nonunique-fraction.processed_features_sense-antisense.20098200.stderr.txt
all-bams.hc-strd-eq.union.nonunique-none.processed_features_antisense.20098222.stderr.txt
all-bams.hc-strd-eq.union.nonunique-none.processed_features-intergenic_antisense.20098186.stderr.txt
all-bams.hc-strd-eq.union.nonunique-none.processed_features-intergenic_sense.20098174.stderr.txt
all-bams.hc-strd-eq.union.nonunique-none.processed_features-intergenic_sense-antisense.20098162.stderr.txt
all-bams.hc-strd-eq.union.nonunique-none.processed_features_sense.20098210.stderr.txt
all-bams.hc-strd-eq.union.nonunique-none.processed_features_sense-antisense.20098198.stderr.txt
all-bams.hc-strd-eq.union.nonunique-random.processed_features_antisense.20098225.stderr.txt
all-bams.hc-strd-eq.union.nonunique-random.processed_features-intergenic_antisense.20098189.stderr.txt
all-bams.hc-strd-eq.union.nonunique-random.processed_features-intergenic_sense.20098177.stderr.txt
all-bams.hc-strd-eq.union.nonunique-random.processed_features-intergenic_sense-antisense.20098165.stderr.txt
all-bams.hc-strd-eq.union.nonunique-random.processed_features_sense.20098213.stderr.txt
all-bams.hc-strd-eq.union.nonunique-random.processed_features_sense-antisense.20098201.stderr.txt
```
</details>
<br />
