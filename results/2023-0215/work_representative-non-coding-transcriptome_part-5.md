
`work_representative-non-coding-transcriptome_part-5.md`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [Run `htseq-count` on bams in `bams_renamed/` with `.gtf`s in `outfiles_gtf-gff3/representation`](#run-htseq-count-on-bams-in-bams_renamed-with-gtfs-in-outfiles_gtf-gff3representation)
    1. [Set up outfile directories](#set-up-outfile-directories)
        1. [Code](#code-1)
    1. [Set up arrays of bams](#set-up-arrays-of-bams)
        1. [Code](#code-2)
    1. [Index bams](#index-bams)
        1. [Code](#code-3)
    1. [Run `htseq-count` with `.gtf`s in `outfiles_gtf-gff3/representation`](#run-htseq-count-with-gtfs-in-outfiles_gtf-gff3representation)
        1. [Set up necessary arrays, variables](#set-up-necessary-arrays-variables)
            1. [Code](#code-4)
        1. [Set up and submit `htseq-count` jobs](#set-up-and-submit-htseq-count-jobs)
            1. [Code](#code-5)
    1. [Concatenate files, copy pertinent files to AG](#concatenate-files-copy-pertinent-files-to-ag)
        1. [Code](#code-6)
1. [Run `htseq-count` on bams in `bams_renamed/` with `combined_AG.sans-chr.gtf`](#run-htseq-count-on-bams-in-bams_renamed-with-combined_agsans-chrgtf)
    1. [Set up outfile directories](#set-up-outfile-directories-1)
        1. [Code](#code-7)
    1. [Strip "chr" from chromosome names in `combined_AG.gtf`](#strip-chr-from-chromosome-names-in-combined_aggtf)
        1. [Code](#code-8)
    1. [Set up arrays of bams](#set-up-arrays-of-bams-1)
        1. [Code](#code-9)
    1. [Index bams](#index-bams-1)
        1. [Code](#code-10)
    1. [Run `htseq-count` with `combined_AG.sans-chr.gtf`](#run-htseq-count-with-combined_agsans-chrgtf)
        1. [Set up necessary variables](#set-up-necessary-variables)
            1. [Code](#code-11)
        1. [Set up and submit `htseq-count` jobs](#set-up-and-submit-htseq-count-jobs-1)
            1. [Code](#code-12)
    1. [Concatenate files, copy pertinent files to AG](#concatenate-files-copy-pertinent-files-to-ag-1)
        1. [Code](#code-13)

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

# tmux new -s htseq
# tmux a -t htseq

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

source activate gff3_env
```
</details>
<br />
<br />

<a id="run-htseq-count-on-bams-in-bams_renamed-with-gtfs-in-outfiles_gtf-gff3representation"></a>
## Run `htseq-count` on bams in `bams_renamed/` with `.gtf`s in `outfiles_gtf-gff3/representation`
<a id="set-up-outfile-directories"></a>
### Set up outfile directories
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Set up outfile directories</i></summary>

```bash
#!/bin/bash

for h in ./outfiles_htseq-count/representation/UT_prim_UMI/*; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p outfiles_htseq-count/representation/UT_prim_UMI/err_out
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
<summary><i>Code: Set up arrays of bams</i></summary>

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
echo_test "${UT_prim_UMI[@]}"
echo "${#UT_prim_UMI[@]}"
echo "${UT_prim_UMI[*]}"
```
</details>
<br />

<a id="index-bams"></a>
### Index bams
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Index bams</i></summary>

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

<a id="run-htseq-count-with-gtfs-in-outfiles_gtf-gff3representation"></a>
### Run `htseq-count` with `.gtf`s in `outfiles_gtf-gff3/representation`
<a id="set-up-necessary-arrays-variables"></a>
#### Set up necessary arrays, variables
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash

p_gtf=outfiles_gtf-gff3/representation  # ls -1 "${p_gtf}"
gtf=(
    "${p_gtf}/Greenlaw-et-al_CUTs-4x.gtf"
    # "${p_gtf}/Greenlaw-et-al_CUTs.gtf"
    "${p_gtf}/Greenlaw-et-al_CUTs-HMM.gtf"
    # "${p_gtf}/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf"
    # "${p_gtf}/Greenlaw-et-al_NUTs.gtf"
    # "${p_gtf}/Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
    # "${p_gtf}/Greenlaw-et-al_SRATs.gtf"
    # "${p_gtf}/Greenlaw-et-al_SUTs.gtf"
    # "${p_gtf}/Greenlaw-et-al_XUTs.gtf"
)
echo_test "${gtf[@]}"
echo "${#gtf[@]}"

job_name="run_htseq-count"  # echo "${job_name}"
threads=8  # echo "${threads}"

job_no_max=24  # echo "${job_no_max}"

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

h=0
for i in "strd-eq"; do
    for j in "${gtf[@]}"; do
        # i="strd-eq"  # echo "${i}"
        # j="${gtf[3]}"  # echo "${j}"

        #  -------------------------------------
        count_against="${j}"  # echo "${count_against}"
        out="outfiles_htseq-count/representation/UT_prim_UMI/$(
            echo $(basename "${count_against}") \
                | sed 's/Greenlaw-et-al_//g;s/.gtf//g'
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
                    directory                                                file
               out  $(dirname ${out})          $(basename ${out})
            stdout  $(dirname ${err_out})  $(basename ${err_out}).stdout.txt
            stderr  $(dirname ${err_out})  $(basename ${err_out}).stderr.txt
        """

        if [[ "${i}" == "strd-eq" ]]; then
            hc_strd="yes"  # echo "${hc_strd}"
        elif [[ "${i}" == "strd-op" ]]; then
            hc_strd="reverse"  # echo "${hc_strd}"
        fi


        #  -------------------------------------
        echo """
        sbatch \\
            --job-name=${job_name} \\
            --nodes=1 \\
            --cpus-per-task=${threads} \\
            --error=${err_out}.%A.stderr.txt \\
            --output=${err_out}.%A.stdout.txt \\
            htseq-count \\
                --order \"pos\" \\
                --stranded \"${hc_strd}\" \\
                --nonunique \"none\" \\
                --type \"feature\" \\
                --idattr \"gene_id\" \\
                --nprocesses ${threads} \\
                --counts_output \"${out}\" \\
                --with-header \\
                ${UT_prim_UMI[*]} \\
                \"${count_against}\" \\
                     > >(tee -a \"${err_out}.stdout.txt\") \\
                    2> >(tee -a \"${err_out}.stderr.txt\")
        """

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
                --type "feature" \
                --idattr "gene_id" \
                --nprocesses ${threads} \
                --counts_output "${out}" \
                --with-header \
                ${UT_prim_UMI[*]} \
                "${count_against}"

        sleep 0.5
        echo ""
    done
done
```
</details>
<br />

<a id="concatenate-files-copy-pertinent-files-to-ag"></a>
### Concatenate files, copy pertinent files to AG
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Concatenate files, copy pertinent files to AG</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"

bash ../../../../../../bin/process_htseq-count_outfiles.sh \
    -u FALSE \
    -q "." \
    -o "./all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv" \
    -s "hc-strd-eq"

bash ../../../../../../bin/process_htseq-count_outfiles.sh \
    -u FALSE \
    -q "." \
    -o "./all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv" \
    -s "hc-strd-op"

., all-samples*


#TODO Move this to its own location?
for i in ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/*; do
    if [[ ! -e "${i}" ]]; then
        mkdir ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI
        mkdir ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/{antisense_transcript,CUT,CUT_2016,CUT_4X,mRNA,ncRNA,NUTs,rRNA,snoRNA,snRNA,SRAT,SUT,tRNA,XUT}/UT_prim_UMI
    fi

    break
done

cp \
    all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv \
    all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv \
    /home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI
```
</details>
<br />

<details>
<summary><i>Printed: Concatenate files, copy pertinent files to AG</i></summary>

```txt
❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"


❯ bash ../../../../../../bin/process_htseq-count_outfiles.sh \
>     -u FALSE \
>     -q "." \
>     -o "./all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv" \
>     -s "hc-strd-eq"
"Safe mode" is FALSE.


❯ bash ../../../../../../bin/process_htseq-count_outfiles.sh \
>     -u FALSE \
>     -q "." \
>     -o "./all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv" \
>     -s "hc-strd-op"
"Safe mode" is FALSE.


❯ ., all-samples*
-rw-rw---- 1 kalavatt 2.8M Mar 31 14:19 all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv
-rw-rw---- 1 kalavatt 2.1M Mar 31 14:19 all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv


❯ for i in ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/*; do
>     if [[ ! -e "${i}" ]]; then
>         mkdir ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI
>         mkdir ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/{antisense_transcript,CUT,CUT_2016,CUT_4X,mRNA,ncRNA,NUTs,rRNA,snoRNA,snRNA,SRAT,SUT,tRNA,XUT}/UT_prim_UMI
>     fi
> 
>     break
> done
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/antisense_transcript'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/antisense_transcript/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_2016'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_2016/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_4X'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_4X/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/mRNA'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/mRNA/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/ncRNA'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/ncRNA/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/NUTs'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/NUTs/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/rRNA'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/rRNA/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snoRNA'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snoRNA/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snRNA'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snRNA/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SRAT'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SRAT/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SUT'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SUT/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/tRNA'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/tRNA/UT_prim_UMI'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/XUT'
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/XUT/UT_prim_UMI'


❯ cp \
>     all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv \
>     all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv \
>     /home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI
'all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv'
'all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv'
```
</details>
<br />
<br />

<a id="run-htseq-count-on-bams-in-bams_renamed-with-combined_agsans-chrgtf"></a>
## Run `htseq-count` on bams in `bams_renamed/` with `combined_AG.sans-chr.gtf`
<a id="set-up-outfile-directories-1"></a>
### Set up outfile directories
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Set up outfile directories</i></summary>

```bash
#!/bin/bash

# transcriptome && 
#     {
#         cd "results/2023-0215/" \
#             || echo "cd'ing failed; check on this..."
#     }
#
# source activate gff3_env
#
# .,

for h in ./outfiles_htseq-count/already/combined-AG/a*; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p outfiles_htseq-count/already/combined-AG/{antisense_transcript,CUT,CUT_4X,mRNA,ncRNA,rRNA,snoRNA,snRNA,SUT,tRNA,XUT,CUT_2016,SRAT,NUTs}/{UT_prim_UMI,UTK_prim_UMI}/err_out
    else
        echo "Directories present; skipping mkdir'ing of outfile directories"
    fi

    break
done
```
</details>
<br />

<a id="strip-chr-from-chromosome-names-in-combined_aggtf"></a>
### Strip "chr" from chromosome names in `combined_AG.gtf`
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Strip "chr" from chromosome names in combined_AG.gtf</i></summary>
<br />

`#TODO` *Get this work into another location*
```bash
#!/bin/bash

cd ~/genomes/combined_AG/gtf
sed 's/^chr//' combined_AG.gtf > combined_AG.sans-chr.gtf
head combined_AG.sans-chr.gtf
tail combined_AG.sans-chr.gtf

cd ~/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215

cp \
    ~/genomes/combined_AG/gtf/combined_AG.sans-chr.gtf \
    ~/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3/already/combined_AG.sans-chr.gtf
head ~/genomes/combined_AG/gtf/combined_AG.sans-chr.gtf
tail ~/genomes/combined_AG/gtf/combined_AG.sans-chr.gtf
```
</details>
<br />

<a id="set-up-arrays-of-bams-1"></a>
### Set up arrays of bams
<a id="code-9"></a>
#### Code
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

# unset UT_prim_pos
# typeset -a UT_prim_pos
# while IFS=" " read -r -d $'\0'; do
#     UT_prim_pos+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UT_prim_pos" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UTK_prim_pos
# typeset -a UTK_prim_pos
# while IFS=" " read -r -d $'\0'; do
#     UTK_prim_pos+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UTK_prim_pos" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UT_prim_no
# typeset -a UT_prim_no
# while IFS=" " read -r -d $'\0'; do
#     UT_prim_no+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UT_prim_no" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UTK_prim_no
# typeset -a UTK_prim_no
# while IFS=" " read -r -d $'\0'; do
#     UTK_prim_no+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UTK_prim_no" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )

echo_test "${UT_prim_UMI[@]}"
echo_test "${UTK_prim_UMI[@]}"
# echo_test "${UT_prim_pos[@]}"
# echo_test "${UTK_prim_pos[@]}"
# echo_test "${UT_prim_no[@]}"
# echo_test "${UTK_prim_no[@]}"

echo "${#UT_prim_UMI[@]}"
echo "${#UTK_prim_UMI[@]}"
# echo "${#UT_prim_pos[@]}"
# echo "${#UTK_prim_pos[@]}"
# echo "${#UT_prim_no[@]}"
# echo "${#UTK_prim_no[@]}"
```
</details>
<br />

<a id="index-bams-1"></a>
### Index bams
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Index all bams in arrays</i></summary>

```bash
#!/bin/bash

for h in ./bams_renamed/UT_prim_UMI/*.bai; do
    if [[ ! -e "${h}" ]]; then
        ml SAMtools/1.16.1-GCC-11.2.0

        # for i in \
        #     "${UT_prim_UMI[@]}" \
        #     "${UTK_prim_UMI[@]}" \
        #     "${UT_prim_pos[@]}" \
        #     "${UTK_prim_pos[@]}" \
        #     "${UT_prim_no[@]}" \
        #     "${UTK_prim_no[@]}"; do
        for i in \
            "${UT_prim_UMI[@]}" \
            "${UTK_prim_UMI[@]}"; do
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

<a id="run-htseq-count-with-combined_agsans-chrgtf"></a>
### Run `htseq-count` with `combined_AG.sans-chr.gtf`
<a id="set-up-necessary-variables"></a>
#### Set up necessary variables
<a id="code-11"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash

unset features
typeset -a features=(
    antisense_transcript
    CUT
    CUT_4X
    mRNA
    ncRNA
    rRNA
    snoRNA
    snRNA
    SUT
    tRNA
    XUT
    CUT_2016
    SRAT
    NUTs
)
# echo_test "${features[@]}"
# echo "${#features[@]}"

gtf="infiles_gtf-gff3/already/combined_AG.sans-chr.gtf"  # echo "${gtf}"  # ., "${gtf}"

job_name="run_htseq-count"  # echo "${job_name}"
threads=8  # echo "${threads}"

job_no_max=120  # echo "${job_no_max}"
```
</details>
<br />

<a id="set-up-and-submit-htseq-count-jobs-1"></a>
#### Set up and submit `htseq-count` jobs
<a id="code-12"></a>
##### Code
<details>
<summary><i>Code: Set up and submit htseq-count jobs</i></summary>

```bash
#!/bin/bash

g=0
for h in "${features[@]}"; do
    for i in "strd-eq"; do
        for j in "${UT_prim_UMI[@]}"; do
            # h="${features[0]}"  # echo "${h}"
            # i="strd-eq"  # echo "${i}"
            # j="${UT_prim_UMI[0]}"  # echo "${j}"


            #  -------------------------------------
            type="${h}"  # echo "${type}"
            strd="${i}"
            in="${j}"  # echo "${in}"
            
            out="$(
                echo "${in}" \
                    | sed "s:bams_renamed:outfiles_htseq-count\/already\/combined-AG\/${type}:g" \
                    | sed "s:.bam:.hc-${i}.tsv:g"
            )"   # echo "${out}"  # ., "$(dirname "${out}")"

            err_out="$(
                dirname "${out}"
            )/err_out/$(
                basename "${out}" .tsv
            )"  # echo "${err_out}"  # ., "$(dirname "${err_out}")"


            #  -------------------------------------
            let g++
            iter="${g}"
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
            elif [[ "${i}" == "strd-op" ]]; then
                hc_strd="reverse"  # echo "${hc_strd}"
            fi


            #  -------------------------------------
            echo "\
            sbatch \\
                --job-name=${job_name} \\
                --nodes=1 \\
                --cpus-per-task=${threads} \\
                --error=${err_out}.%A.stderr.txt \\
                --output=${err_out}.%A.stdout.txt \\
                htseq-count \\
                    --order \"pos\" \\
                    --stranded \"${hc_strd}\" \\
                    --nonunique \"none\" \\
                    --type \"${type}\" \\
                    --idattr \"gene_id\" \\
                    --nprocesses ${threads} \\
                    --counts_output \"${out}\" \\
                    --with-header \\
                    \"${in}\" \\
                    \"${gtf}\" \\
                         > >(tee -a \"${err_out}.stdout.txt\") \\
                        2> >(tee -a \"${err_out}.stderr.txt\")
            "


            #  -------------------------------------
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
                    --type "${type}" \
                    --idattr "gene_id" \
                    --nprocesses ${threads} \
                    --counts_output "${out}" \
                    --with-header \
                    "${in}" \
                    "${gtf}"
            
            sleep 0.15
            echo ""
        done
    done
done
```
</details>
<br />

<a id="concatenate-files-copy-pertinent-files-to-ag-1"></a>
### Concatenate files, copy pertinent files to AG
<a id="code-13"></a>
#### Code
<details>
<summary><i>Code: Concatenate files, copy pertinent files to AG</i></summary>

```bash
#!/bin/bash

unset features
typeset -a features=(
    # antisense_transcript
    # CUT
    # CUT_4X
    # mRNA
    # ncRNA
    # rRNA
    # snoRNA
    # snRNA
    # SUT
    # tRNA
    # XUT
    # CUT_2016
    SRAT
    NUTs
)
# echo_test "${features[@]}"
# echo "${#features[@]}"

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG"

for i in "${features[@]}"; do
    echo "#  -------------------------------------"
    echo "#+ combined-AG/${i}/UT_prim_UMI"
    
    cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/${i}/UT_prim_UMI"
    # .,
    # ls *.tsv | wc -l
    pwd
    
    echo """
    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \\
        -u FALSE \\
        -q \".\" \\
        -o \"./all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
        -s \"hc-strd-eq\""""

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
        -s "hc-strd-eq"
    
    echo """    cp \\
        \"all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
        \"${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI\"
    """

    if [[ -f "all-samples.combined-AG.hc-strd-eq.${i}.tsv" ]]; then
        cp \
            "all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
            "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
    else
        echo "Error: Some problem with generation of 'all-samples.*' file; breaking"
        # break
    fi
    echo ""

    ., "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
    echo ""
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Concatenate files, copy pertinent files to AG</i></summary>

```txt
❯ for i in "${features[@]}"; do
>     echo "#  -------------------------------------"
>     echo "#+ combined-AG/${i}/UT_prim_UMI"
> 
>     cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/${i}/UT_prim_UMI"
>     # .,
>     # ls *.tsv | wc -l
>     pwd
> 
>     echo """
>     bash ../../../../../../../bin/process_htseq-count_outfiles.sh \\
>         -u FALSE \\
>         -q \".\" \\
>         -o \"./all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
>         -s \"hc-strd-eq\""""
> 
>     bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
>         -u FALSE \
>         -q "." \
>         -o "./all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
>         -s "hc-strd-eq"
> 
>     echo """
>     cp \\
>         \"all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
>         \"${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI\"
>     """
> 
>     if [[ -f "all-samples.combined-AG.hc-strd-eq.${i}.tsv" ]]; then
>         cp \
>             "all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
>             "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
>     else
>         echo "Error: Some problem with generation of 'all-samples.*' file; breaking"
>         # break
>     fi
>     echo ""
> 
>     ., "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
>     echo ""
>     echo ""
> done
#  -------------------------------------
#+ combined-AG/antisense_transcript/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/antisense_transcript/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.antisense_transcript.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.antisense_transcript.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/antisense_transcript/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.antisense_transcript.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/antisense_transcript/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.antisense_transcript.tsv'

total 496K
drwxrws--- 2 kalavatt  77 Mar 31 15:20 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 94K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.antisense_transcript.tsv


#  -------------------------------------
#+ combined-AG/CUT/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/CUT/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.CUT.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.CUT.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.CUT.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.CUT.tsv'

total 296K
drwxrws--- 2 kalavatt   60 Mar 31 15:20 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 172K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.CUT.tsv


#  -------------------------------------
#+ combined-AG/CUT_4X/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/CUT_4X/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.CUT_4X.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.CUT_4X.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_4X/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.CUT_4X.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_4X/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.CUT_4X.tsv'

total 320K
drwxrws--- 2 kalavatt   63 Mar 31 15:20 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 172K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.CUT_4X.tsv


#  -------------------------------------
#+ combined-AG/mRNA/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/mRNA/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.mRNA.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.mRNA.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/mRNA/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.mRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/mRNA/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.mRNA.tsv'

total 2.0M
drwxrws--- 2 kalavatt   61 Mar 31 15:20 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 1.6M Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.mRNA.tsv


#  -------------------------------------
#+ combined-AG/ncRNA/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/ncRNA/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.ncRNA.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.ncRNA.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/ncRNA/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.ncRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/ncRNA/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.ncRNA.tsv'

total 176K
drwxrws--- 2 kalavatt  62 Mar 31 15:20 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 15K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.ncRNA.tsv


#  -------------------------------------
#+ combined-AG/rRNA/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/rRNA/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.rRNA.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.rRNA.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/rRNA/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.rRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/rRNA/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.rRNA.tsv'

total 176K
drwxrws--- 2 kalavatt  61 Mar 31 15:20 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 14K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.rRNA.tsv


#  -------------------------------------
#+ combined-AG/snoRNA/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/snoRNA/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.snoRNA.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.snoRNA.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snoRNA/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.snoRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snoRNA/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.snoRNA.tsv'

total 240K
drwxrws--- 2 kalavatt  63 Mar 31 15:20 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 31K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.snoRNA.tsv


#  -------------------------------------
#+ combined-AG/snRNA/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/snRNA/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.snRNA.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.snRNA.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snRNA/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.snRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/snRNA/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.snRNA.tsv'

total 176K
drwxrws--- 2 kalavatt  62 Mar 31 15:20 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 13K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.snRNA.tsv


#  -------------------------------------
#+ combined-AG/SUT/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/SUT/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.SUT.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.SUT.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SUT/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.SUT.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SUT/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.SUT.tsv'

total 320K
drwxrws--- 2 kalavatt   60 Mar 31 15:20 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 173K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.SUT.tsv


#  -------------------------------------
#+ combined-AG/tRNA/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/tRNA/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.tRNA.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.tRNA.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/tRNA/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.tRNA.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/tRNA/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.tRNA.tsv'

total 336K
drwxrws--- 2 kalavatt  61 Mar 31 15:20 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 53K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.tRNA.tsv


#  -------------------------------------
#+ combined-AG/XUT/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/XUT/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.XUT.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.XUT.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/XUT/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.XUT.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/XUT/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.XUT.tsv'

total 816K
drwxrws--- 2 kalavatt   60 Mar 31 15:20 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 313K Mar 31 15:20 all-samples.combined-AG.hc-strd-eq.XUT.tsv


❯ for i in "${features[@]}"; do
>     echo "#  -------------------------------------"
>     echo "#+ combined-AG/${i}/UT_prim_UMI"
> 
>     cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/${i}/UT_prim_UMI"
>     # .,
>     # ls *.tsv | wc -l
>     pwd
> 
>     echo """
>     bash ../../../../../../../bin/process_htseq-count_outfiles.sh \\
>         -u FALSE \\
>         -q \".\" \\
>         -o \"./all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
>         -s \"hc-strd-eq\""""
> 
>     bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
>         -u FALSE \
>         -q "." \
>         -o "./all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
>         -s "hc-strd-eq"
> 
>     echo """    cp \\
>         \"all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
>         \"${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI\"
>     """
> 
>     if [[ -f "all-samples.combined-AG.hc-strd-eq.${i}.tsv" ]]; then
>         cp \
>             "all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
>             "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
>     else
>         echo "Error: Some problem with generation of 'all-samples.*' file; breaking"
>         # break
>     fi
>     echo ""
> 
>     ., "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
>     echo ""
>     echo ""
> done
#  -------------------------------------
#+ combined-AG/CUT_2016/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/CUT_2016/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.CUT_2016.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.CUT_2016.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_2016/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.CUT_2016.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/CUT_2016/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.CUT_2016.tsv'

total 672K
drwxrws--- 2 kalavatt   65 Mar 31 15:51 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 172K Mar 31 15:51 all-samples.combined-AG.hc-strd-eq.CUT_2016.tsv


❯ for i in "${features[@]}"; do
>     echo "#  -------------------------------------"
>     echo "#+ combined-AG/${i}/UT_prim_UMI"
> 
>     cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/${i}/UT_prim_UMI"
>     # .,
>     # ls *.tsv | wc -l
>     pwd
> 
>     echo """
>     bash ../../../../../../../bin/process_htseq-count_outfiles.sh \\
>         -u FALSE \\
>         -q \".\" \\
>         -o \"./all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
>         -s \"hc-strd-eq\""""
> 
>     bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
>         -u FALSE \
>         -q "." \
>         -o "./all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
>         -s "hc-strd-eq"
> 
>     echo """    cp \\
>         \"all-samples.combined-AG.hc-strd-eq.${i}.tsv\" \\
>         \"${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI\"
>     """
> 
>     if [[ -f "all-samples.combined-AG.hc-strd-eq.${i}.tsv" ]]; then
>         cp \
>             "all-samples.combined-AG.hc-strd-eq.${i}.tsv" \
>             "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
>     else
>         echo "Error: Some problem with generation of 'all-samples.*' file; breaking"
>         # break
>     fi
>     echo ""
> 
>     ., "${HOME}/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/${i}/UT_prim_UMI"
>     echo ""
>     echo ""
> done
#  -------------------------------------
#+ combined-AG/SRAT/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/SRAT/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.SRAT.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.SRAT.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SRAT/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.SRAT.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/SRAT/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.SRAT.tsv'

total 520K
drwxrws--- 2 kalavatt  61 Apr  1 10:16 ./
drwxrws--- 3 kalavatt  29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 99K Apr  1 10:16 all-samples.combined-AG.hc-strd-eq.SRAT.tsv


#  -------------------------------------
#+ combined-AG/NUTs/UT_prim_UMI
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/already/combined-AG/NUTs/UT_prim_UMI

    bash ../../../../../../../bin/process_htseq-count_outfiles.sh \
        -u FALSE \
        -q "." \
        -o "./all-samples.combined-AG.hc-strd-eq.NUTs.tsv" \
        -s "hc-strd-eq"
"Safe mode" is FALSE.

    cp \
        "all-samples.combined-AG.hc-strd-eq.NUTs.tsv" \
        "/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/NUTs/UT_prim_UMI"

'all-samples.combined-AG.hc-strd-eq.NUTs.tsv' -> '/home/kalavatt/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331/already/combined-AG/NUTs/UT_prim_UMI/all-samples.combined-AG.hc-strd-eq.NUTs.tsv'

total 384K
drwxrws--- 2 kalavatt   61 Apr  1 10:16 ./
drwxrws--- 3 kalavatt   29 Mar 31 14:33 ../
-rw-rw---- 1 kalavatt 313K Apr  1 10:16 all-samples.combined-AG.hc-strd-eq.NUTs.tsv
```
</details>
<br />

<details>
<summary><i>Code: </i></summary>

`#TODO` *Better place or different notebook for this (and related) code chunks?*
```bash
#!/bin/bash

cd ~/tsukiyamalab/alisong/tsvs_htseq-count_2023-0331
mkdir -p gtf-gff3/combined

cp \
    ~/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3/already/{combined_AG.sans-chr.gtf,combined_SC_KL_20S.gff3} \
    gtf-gff3/combined

mv already/ combined/
mkdir matrices
mv combined/ matrices/
```
</details>
<br />
