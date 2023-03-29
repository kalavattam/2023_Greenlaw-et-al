
`#work_count_features_htseq-count.md`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [Run htseq-count on bams in bams_renamed/](#run-htseq-count-on-bams-in-bams_renamed)
    1. [Run htseq-count on bams in bams_renamed/ with combined_SC_KL.gff3](#run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_klgff3)
        1. [Get situated](#get-situated-1)
            1. [Code](#code-1)
        1. [Set up arrays](#set-up-arrays)
            1. [Code](#code-2)
        1. [Index all bams in arrays](#index-all-bams-in-arrays)
            1. [Code](#code-3)
        1. [Run htseq-count with combined_SC_KL.gff3](#run-htseq-count-with-combined_sc_klgff3)
            1. [Code](#code-4)

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

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

source activate htseq_env

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


❯ source activate htseq_env


❯ .,
total 33M
drwxrws---  9 kalavatt 1.2K Mar 20 13:57 ./
drwxrws--- 12 kalavatt  326 Mar 13 09:46 ../
drwxrws---  2 kalavatt  259 Feb 25 16:13 bak.bams/
drwxrws---  8 kalavatt  175 Feb 26 13:48 bak.bams_renamed/
drwxrws---  5 kalavatt  103 Mar 15 14:48 bak.outfiles_htseq-count/
drwxrws---  2 kalavatt  259 Mar 14 15:52 bams/
drwxrws---  8 kalavatt  175 Mar 14 15:54 bams_renamed/
-rw-rw----  1 kalavatt 8.5M Mar  3 09:16 combined_SC_KL.antisense.gff3
-rwxrwx---  1 kalavatt 8.5M Mar  3 09:16 combined_SC_KL.gff3*
drwxrws---  2 kalavatt   32 Mar 13 16:33 notebook/
drwxrws---  4 kalavatt   74 Mar 20 13:57 outfiles_htseq-count/
-rw-rw----  1 kalavatt  31K Mar  3 09:16 test_count_features.md
-rw-rw----  1 kalavatt  69K Mar  3 09:16 work_count_features.md
-rw-rw----  1 kalavatt 134K Mar 13 16:33 work_env-building.md
-rw-rw----  1 kalavatt 656K Mar  3 09:16 work_gff3_convert-strand-designations.nb.html
-rw-rw----  1 kalavatt 2.0K Mar  3 09:16 work_gff3_convert-strand-designations.Rmd
-rw-rw----  1 kalavatt 6.8K Feb 22 16:21 work_gff3_include-20S.md
-rw-rw----  1 kalavatt 5.6K Feb 22 16:21 work_model-variables.md
-rw-rw----  1 kalavatt 2.5M Mar 13 16:33 work_normalization-etc_rough-draft_NNS_vary-on-transcription.nb.html
-rw-rw----  1 kalavatt  33K Mar 13 16:33 work_normalization-etc_rough-draft_NNS_vary-on-transcription.Rmd
-rw-rw----  1 kalavatt 2.5M Mar 13 16:33 work_normalization-etc_rough-draft_OsTIR-NNS_vary-on-strain.nb.html
-rw-rw----  1 kalavatt  36K Mar 13 16:33 work_normalization-etc_rough-draft_OsTIR-NNS_vary-on-strain.Rmd
-rw-rw----  1 kalavatt 4.0M Mar 13 16:33 work_normalization-etc_rough-draft_wild-type_vary-on-state.nb.html
-rw-rw----  1 kalavatt  53K Mar 13 16:33 work_normalization-etc_rough-draft_wild-type_vary-on-state.Rmd
```
</details>
<br />
<br />

<a id="run-htseq-count-on-bams-in-bams_renamed"></a>
## Run htseq-count on bams in bams_renamed/
<a id="run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_klgff3"></a>
### Run htseq-count on bams in bams_renamed/ with combined_SC_KL.gff3
<a id="get-situated-1"></a>
#### Get situated
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

alias tml="tmux ls"
alias tma="tmux a -t"

tmux new -s h_sen
# tma h_sen

hitparade
grabnode  # 32, defaults
source activate htseq_env

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

mkdir -p outfiles_htseq-count/{combined_SC_KL,combined_SC_KL_antisense}/{stranded-yes,stranded-reverse}/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}
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
#DONTRUN #CONTINUE

#TODO Check that this is necessary with an if/else statement
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
done

module purge SAMtools/1.16.1-GCC-11.2.0
```
</details>
<br />

<a id="run-htseq-count-with-combined_sc_klgff3"></a>
#### Run htseq-count with combined_SC_KL.gff3
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Run htseq-count with combined_SC_KL.gff3</i></summary>

`#TODO` `#IMPORTANT` Change `--type "exon"` to `--type "mRNA"`
`#TODO` `#QUESTION` Need to change `--idattr "ID"`?
```bash
#  Set up unchanging variables
threads="${SLURM_CPUS_ON_NODE}"  # echo "${threads}"

#  Check that outdirs exist
for i in "yes" "reverse"; do
    ., "outfiles_htseq-count/combined_SC_KL/stranded-${i}/UT_prim_UMI/"
    ., "outfiles_htseq-count/combined_SC_KL/stranded-${i}/UTK_prim_UMI/"
    ., "outfiles_htseq-count/combined_SC_KL/stranded-${i}/UT_prim_pos/"
    ., "outfiles_htseq-count/combined_SC_KL/stranded-${i}/UTK_prim_pos/"
    ., "outfiles_htseq-count/combined_SC_KL/stranded-${i}/UT_prim_no/"
    ., "outfiles_htseq-count/combined_SC_KL/stranded-${i}/UTK_prim_no/"
done

for j in "combined_SC_KL.gff3" "combined_SC_KL.antisense.gff3"; do
    ., "${j}"
    if [[ "${j}" == *"antisense"* ]]; then
        ext="antisense.htseq-count.tsv"
    else
        ext="sense.htseq-count.tsv"
    fi
    echo "Extension will be '${ext}'"
    echo ""
done

for i in "yes" "reverse"; do
    for j in "combined_SC_KL.gff3" "combined_SC_KL.antisense.gff3"; do

        if [[ "${j}" == *"antisense"* ]]; then
            ext="antisense.htseq-count.tsv"
        else
            ext="sense.htseq-count.tsv"
        fi

        #  UT_prim_UMI
        outfile="outfiles_htseq-count/combined_SC_KL/stranded-${i}/UT_prim_UMI/UT_prim_UMI.${ext}"
        htseq-count \
            --order "pos" \
            --stranded "${i}" \
            --nonunique "all" \
            --type "exon" \
            --idattr "ID" \
            --nprocesses "${threads}" \
            --counts_output "${outfile}" \
            --with-header \
            ${UT_prim_UMI[*]} \
            "${j}" \
                > >(tee -a "${outfile%.tsv}.stdout.txt") \
                2> >(tee -a "${outfile%.tsv}.stderr.txt" >&2)

        #  UTK_prim_UMI
        outfile="outfiles_htseq-count/combined_SC_KL/stranded-${i}/UTK_prim_UMI/UTK_prim_UMI.${ext}"
        htseq-count \
            --order "pos" \
            --stranded "${i}" \
            --nonunique "all" \
            --type "exon" \
            --idattr "ID" \
            --nprocesses "${threads}" \
            --counts_output "${outfile}" \
            --with-header \
            ${UTK_prim_UMI[*]} \
                > >(tee -a "${outfile%.tsv}.stdout.txt") \
                2> >(tee -a "${outfile%.tsv}.stderr.txt" >&2)

        #  UT_prim_pos
        outfile="outfiles_htseq-count/combined_SC_KL/stranded-${i}/UT_prim_pos/UT_prim_pos.${ext}"
        htseq-count \
            --order "pos" \
            --stranded "${i}" \
            --nonunique "all" \
            --type "exon" \
            --idattr "ID" \
            --nprocesses "${threads}" \
            --counts_output "${outfile}" \
            --with-header \
            ${UT_prim_pos[*]} \
            "${j}" \
                > >(tee -a "${outfile%.tsv}.stdout.txt") \
                2> >(tee -a "${outfile%.tsv}.stderr.txt" >&2)

        #  UTK_prim_pos
        outfile="outfiles_htseq-count/combined_SC_KL/stranded-${i}/UTK_prim_pos/UTK_prim_pos.${ext}"
        htseq-count \
            --order "pos" \
            --stranded "${i}" \
            --nonunique "all" \
            --type "exon" \
            --idattr "ID" \
            --nprocesses "${threads}" \
            --counts_output "${outfile}" \
            --with-header \
            ${UTK_prim_pos[*]} \
            "${j}" \
                > >(tee -a "${outfile%.tsv}.stdout.txt") \
                2> >(tee -a "${outfile%.tsv}.stderr.txt" >&2)

        #  UT_prim_no
        outfile="outfiles_htseq-count/combined_SC_KL/stranded-${i}/UT_prim_no/UT_prim_no.${ext}"
        htseq-count \
            --order "pos" \
            --stranded "${i}" \
            --nonunique "all" \
            --type "exon" \
            --idattr "ID" \
            --nprocesses "${threads}" \
            --counts_output "${outfile}" \
            --with-header \
            ${UT_prim_no[*]} \
            "${j}" \
                > >(tee -a "${outfile%.tsv}.stdout.txt") \
                2> >(tee -a "${outfile%.tsv}.stderr.txt" >&2)

        #  UTK_prim_no
        outfile="outfiles_htseq-count/combined_SC_KL/stranded-${i}/UTK_prim_no/UTK_prim_no.${ext}"
        htseq-count \
            --order "pos" \
            --stranded "${i}" \
            --nonunique "all" \
            --type "exon" \
            --idattr "ID" \
            --nprocesses "${threads}" \
            --counts_output "${outfile}" \
            --with-header \
            ${UTK_prim_no[*]} \
            "${j}" \
                > >(tee -a "${outfile%.tsv}.stdout.txt") \
                2> >(tee -a "${outfile%.tsv}.stderr.txt" >&2)
    done
done

echo "Done."
```
</details>
<br />
