
`#work_draft_process-data_4tU-seq_fastqs-UMI-dedup.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [PRE Symlink to `*R{1,2,3}*.fastq.gz`](#pre-symlink-to-r123fastqgz)
    1. [Notes](#notes)
    1. [Code](#code)
1. [PRE Get `fastq` file stems into arrays](#pre-get-fastq-file-stems-into-arrays)
    1. [Get situated](#get-situated)
        1. [Code](#code-1)
    1. [Create an array of file stems](#create-an-array-of-file-stems)
        1. [Code](#code-2)
    1. [Create arrays of specific files \(derived from the stems\)](#create-arrays-of-specific-files-derived-from-the-stems)
        1. [Code](#code-3)
1. [I Append UMIs to `fastq`s `R1` and `R3` *\(Trinity, general\)*](#i-append-umis-to-fastqs-r1-and-r3-trinity-general)
    1. [01 Get situated, make a directory for the processed `R1` and `R3` `fastq`s](#01-get-situated-make-a-directory-for-the-processed-r1-and-r3-fastqs)
        1. [Code](#code-4)
    1. [02 Set up necessary variables](#02-set-up-necessary-variables)
        1. [Code](#code-5)
    1. [03 Generate lists of arguments](#03-generate-lists-of-arguments)
        1. [03a Generate the full list](#03a-generate-the-full-list)
            1. [Code](#code-6)
        1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists)
            1. [Code](#code-7)
    1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script)
        1. [Code](#code-8)
    1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script)
        1. [Code](#code-9)
    1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts)
        1. [Code](#code-10)
1. [II Perform adapter and quality trimming of the `fastq`s *\(Trinity, general\)*](#ii-perform-adapter-and-quality-trimming-of-the-fastqs-trinity-general)
    1. [01 Get situated, make a directory for the adapter/quality-trimmed `R1` and `R3` `fastq`s](#01-get-situated-make-a-directory-for-the-adapterquality-trimmed-r1-and-r3-fastqs)
        1. [Code](#code-11)
    1. [02 Set up necessary variables](#02-set-up-necessary-variables-1)
        1. [Code](#code-12)
    1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-1)
        1. [03a Generate the full list](#03a-generate-the-full-list-1)
            1. [Code](#code-13)
        1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-1)
            1. [Code](#code-14)
    1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script-1)
        1. [Code](#code-15)
    1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-1)
        1. [Code](#code-16)
    1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-1)
        1. [Code](#code-17)
1. [III Perform kmer correction with `rcorrector` *\(Trinity\)*](#iii-perform-kmer-correction-with-rcorrector-trinity)
    1. [01 Get situated, make a directory for kmer-corrected `fastq`s](#01-get-situated-make-a-directory-for-kmer-corrected-fastqs)
        1. [Code](#code-18)
    1. [02 Set up necessary variables](#02-set-up-necessary-variables-2)
        1. [Code](#code-19)
    1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-2)
        1. [03a Generate the full list](#03a-generate-the-full-list-2)
            1. [Code](#code-20)
        1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-2)
            1. [Code](#code-21)
    1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script-2)
        1. [Code](#code-22)
    1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-2)
        1. [Code](#code-23)
    1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-2)
        1. [Code](#code-24)
1. [IV "Correct" the `rcorrect`ed `fastq`s *\(Trinity\)*](#iv-correct-the-rcorrected-fastqs-trinity)
    1. [01 Get situated, make a directory for kmer-corrected `fastq`s](#01-get-situated-make-a-directory-for-kmer-corrected-fastqs-1)
        1. [Code](#code-25)
    1. [02 Set up necessary variables](#02-set-up-necessary-variables-3)
        1. [Code](#code-26)
    1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-3)
        1. [03a Generate the full list](#03a-generate-the-full-list-3)
            1. [Code](#code-27)
        1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-3)
            1. [Code](#code-28)
    1. [04 Check on the '`run`' script](#04-check-on-the-run-script)
        1. [Code](#code-29)
    1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-3)
        1. [Code](#code-30)
    1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-3)
        1. [Code](#code-31)
1. [V Align kmer- and non-kmer-corrected `fastq`s *\(Trinity\)*](#v-align-kmer--and-non-kmer-corrected-fastqs-trinity)
    1. [01 Get situated, make directories for in-/outfiles, symlink the `fastq`s](#01-get-situated-make-directories-for-in-outfiles-symlink-the-fastqs)
        1. [01a Get situated, make directories for in-/outfiles](#01a-get-situated-make-directories-for-in-outfiles)
            1. [Code](#code-32)
        1. [01b Establish relative paths for symlinking](#01b-establish-relative-paths-for-symlinking)
            1. [Initialize function for finding relative paths between directories](#initialize-function-for-finding-relative-paths-between-directories)
                1. [Code](#code-33)
            1. [Establish relative path for UMI-extracted \(`U`\), trimmed \(`T`\), kmer-corrected \(`K`\) `fastq`s](#establish-relative-path-for-umi-extracted-u-trimmed-t-kmer-corrected-k-fastqs)
                1. [Code](#code-34)
            1. [Establish relative path for UMI-extracted \(`U`\), trimmed \(`T`\) `fastq`s](#establish-relative-path-for-umi-extracted-u-trimmed-t-fastqs)
                1. [Code](#code-35)
            1. [Initialize arrays of to-symlink source and target `UTK` `fastq`s](#initialize-arrays-of-to-symlink-source-and-target-utk-fastqs)
                1. [Code](#code-36)
            1. [Initialize arrays of to-symlink source and target `UT` `fastq`s](#initialize-arrays-of-to-symlink-source-and-target-ut-fastqs)
                1. [Code](#code-37)
        1. [01c Create the symlinks](#01c-create-the-symlinks)
            1. [Symlink the `UTK` `fastq`s](#symlink-the-utk-fastqs)
                1. [Code](#code-38)
            1. [Symlink the `UT` `fastq`s](#symlink-the-ut-fastqs)
                1. [Code](#code-39)
        1. [01d Get back to the head working directory](#01d-get-back-to-the-head-working-directory)
            1. [Code](#code-40)
    1. [02 Set up necessary variables](#02-set-up-necessary-variables-4)
        1. [Code](#code-41)
    1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-4)
        1. [03a Generate the full lists](#03a-generate-the-full-lists)
            1. [UTK files](#utk-files)
                1. [Code](#code-42)
            1. [UT files](#ut-files)
                1. [Code](#code-43)
        1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-4)
            1. [UTK files](#utk-files-1)
                1. [Code](#code-44)
            1. [UT files](#ut-files-1)
                1. [Code](#code-45)
    1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script-3)
        1. [Code](#code-46)
    1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-4)
        1. [UTK files](#utk-files-2)
            1. [Code](#code-47)
        1. [UT files](#ut-files-2)
            1. [Code](#code-48)
    1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-4)
        1. [Code](#code-49)
    1. [07 Rename, organize, and check on the `STAR` outfiles](#07-rename-organize-and-check-on-the-star-outfiles)
        1. [07a Rename, organize, and check on files in `aligned_umi-extracted_trimmed/`](#07a-rename-organize-and-check-on-files-in-aligned_umi-extracted_trimmed)
            1. [Code](#code-50)
            1. [Troubleshooting the problem with `CT2_6125_pIAA_Q_SteadyState_UT`](#troubleshooting-the-problem-with-ct2_6125_piaa_q_steadystate_ut)
                1. [Code](#code-51)
                1. [Notes, etc.](#notes-etc)
        1. [07b Rename, organize, and check on files in `aligned_umi-extracted_trimmed_kmer-corrected/`](#07b-rename-organize-and-check-on-files-in-aligned_umi-extracted_trimmed_kmer-corrected)
            1. [Code](#code-52)
1. [VI Subset bams by alignment flags *\(Trinity, general\)*](#vi-subset-bams-by-alignment-flags-trinity-general)
    1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles)
        1. [Code](#code-53)
    1. [02 Set up necessary variables, arrays](#02-set-up-necessary-variables-arrays)
        1. [02a Set up information for `aligned_UT_primary_*`](#02a-set-up-information-for-aligned_ut_primary_)
            1. [Code](#code-54)
        1. [02b Set up information for `aligned_UTK_primary-secondary_*`](#02b-set-up-information-for-aligned_utk_primary-secondary_)
            1. [Code](#code-55)
        1. [02c Set up information for `aligned_UTK_primary-unmapped_*`](#02c-set-up-information-for-aligned_utk_primary-unmapped_)
            1. [Code](#code-56)
        1. [02d Set up information for `aligned_UTK_primary`](#02d-set-up-information-for-aligned_utk_primary)
            1. [Code](#code-57)
    1. [03 Use a `for` loop to run `separate_bam.sh`, etc.](#03-use-a-for-loop-to-run-separate_bamsh-etc)
        1. [Run `separate_bam.sh` for `aligned_UT_primary_*`](#run-separate_bamsh-for-aligned_ut_primary_)
            1. [Run `separate_bam.sh`](#run-separate_bamsh)
                1. [Code](#code-58)
            1. [Run `list_tally_flags()`](#run-list_tally_flags)
                1. [Code](#code-59)
                1. [Printed](#printed)
        1. [Run `separate_bam.sh`, etc. for `aligned_UTK_primary-secondary_*`](#run-separate_bamsh-etc-for-aligned_utk_primary-secondary_)
            1. [Run `separate_bam.sh`](#run-separate_bamsh-1)
                1. [Code](#code-60)
            1. [Run `list_tally_flags()`](#run-list_tally_flags-1)
                1. [Code](#code-61)
                1. [Printed](#printed-1)
        1. [Run `separate_bam.sh` for `aligned_UTK_primary-unmapped_*`](#run-separate_bamsh-for-aligned_utk_primary-unmapped_)
            1. [Run `separate_bam.sh`](#run-separate_bamsh-2)
                1. [Code](#code-62)
            1. [Run `list_tally_flags()`](#run-list_tally_flags-2)
                1. [Code](#code-63)
                1. [Printed](#printed-2)
        1. [Run `separate_bam.sh` for `aligned_UTK_primary`](#run-separate_bamsh-for-aligned_utk_primary)
            1. [Run `separate_bam.sh`](#run-separate_bamsh-3)
                1. [Code](#code-64)
            1. [Run `list_tally_flags()`](#run-list_tally_flags-3)
                1. [Code](#code-65)
                1. [Printed](#printed-3)
    1. [04 Use `GNU parallel` to run `samtools index`](#04-use-gnu-parallel-to-run-samtools-index)
        1. [Get all bams \(in- and outfiles\) into a single array](#get-all-bams-in--and-outfiles-into-a-single-array)
            1. [Code](#code-66)
        1. [Run `samtools index`](#run-samtools-index)
            1. [Code](#code-67)
1. [VII Deduplicate "primary" files by UMI, position *\(general\)*](#vii-deduplicate-primary-files-by-umi-position-general)
    1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles-1)
    1. [02 Process `aligned_UT_primary` data](#02-process-aligned_ut_primary-data)
        1. [02a Set up necessary variables, arrays](#02a-set-up-necessary-variables-arrays)
            1. [Code](#code-68)
        1. [02b Use `GNU parallel` to run `umi_tools dedup` for UMI and positional deduplication](#02b-use-gnu-parallel-to-run-umi_tools-dedup-for-umi-and-positional-deduplication)
            1. [Use `GNU parallel` to run `umi_tools dedup` for UMI deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-umi-deduplication)
                1. [Code](#code-69)
            1. [Use `GNU parallel` to run `umi_tools dedup` for positional deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-positional-deduplication)
                1. [Code](#code-70)
    1. [03 Process `aligned_UTK_primary` data](#03-process-aligned_utk_primary-data)
        1. [03a Set up necessary variables, arrays](#03a-set-up-necessary-variables-arrays)
            1. [Code](#code-71)
        1. [03b Use `GNU parallel` to run `umi_tools dedup` for UMI and positional deduplication](#03b-use-gnu-parallel-to-run-umi_tools-dedup-for-umi-and-positional-deduplication)
            1. [Use `GNU parallel` to run `umi_tools dedup` for UMI deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-umi-deduplication-1)
                1. [Code](#code-72)
            1. [Use `GNU parallel` to run `umi_tools dedup` for positional deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-positional-deduplication-1)
                1. [Code](#code-73)
    1. [04 Use `GNU parallel` to run `samtools index`](#04-use-gnu-parallel-to-run-samtools-index-1)
        1. [Get all bams \(in- and outfiles\) into a single array](#get-all-bams-in--and-outfiles-into-a-single-array-1)
            1. [Code](#code-74)
        1. [Run `samtools index`](#run-samtools-index-1)
            1. [Code](#code-75)
1. [VIII Separate out alignments to different species *\(Trinity\)*](#viii-separate-out-alignments-to-different-species-trinity)
    1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles-2)
        1. [Code](#code-76)
    1. [02 Set up necessary variables, arrays](#02-set-up-necessary-variables-arrays-1)
        1. [Code](#code-77)
    1. [03 Use `GNU parallel` to split bams by species](#03-use-gnu-parallel-to-split-bams-by-species)
        1. [Code](#code-78)
        1. [Printed](#printed-4)
1. [IX Merge bams *\(Trinity\)*](#ix-merge-bams-trinity)
    1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles-3)
        1. [Code](#code-79)
    1. [02 Set up necessary variables, arrays](#02-set-up-necessary-variables-arrays-2)
        1. [Code](#code-80)
        1. [Printed](#printed-5)
    1. [03 Use `GNU parallel` to run `samtools merge`](#03-use-gnu-parallel-to-run-samtools-merge)
        1. [Code](#code-81)
        1. [Printed](#printed-6)
1. [X Perform bam-to-fastq conversions *\(Trinity\)*](#x-perform-bam-to-fastq-conversions-trinity)
    1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles-4)
        1. [Code](#code-82)
    1. [02 Set up necessary variables, arrays](#02-set-up-necessary-variables-arrays-3)
        1. [Code](#code-83)
        1. [Printed](#printed-7)
    1. [03 Use `GNU parallel` to run samtools fastq](#03-use-gnu-parallel-to-run-samtools-fastq)
        1. [Code](#code-84)
        1. [Printed, notes](#printed-notes)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="pre-symlink-to-r123fastqgz"></a>
## <u>PRE</u> Symlink to `*R{1,2,3}*.fastq.gz`
<a id="notes"></a>
### Notes
<details>
<summary><i>Notes: Symlink to *R{1,2,3}*.fastq.gz</i></summary>

- `"${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"`
- `"${HOME}/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla"`
- `"${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119"`
- `"${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119"`
</details>
<br />

<a id="code"></a>
### Code
<details>
<summary><i>Code: Symlink to *R{1,2,3}*.fastq.gz</i></summary>

*Get situated, do a quick check of the \*R{1,2,3}\*.fastq.gz files*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

., "${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
., "${HOME}/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla"
., "${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119"
., "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119"
```

*Making the symlinks*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir -p {FastQC,fastqs}_UMI-dedup/
mkdir -p fastqs_UMI-dedup/{symlinks,umi-tools_extract}
mkdir -p fastqs_UMI-dedup/

cd fastqs_UMI-dedup/symlinks \
    || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


p_W="${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
p_T="${HOME}/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla"
p_N="${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119"
p_R="${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119"

r_W="$(find_relative_path "$(pwd)/" "${p_W}")"
r_T="$(find_relative_path "$(pwd)/" "${p_T}")"
r_N="$(find_relative_path "$(pwd)/" "${p_N}")"
r_R="$(find_relative_path "$(pwd)/" "${p_R}")"
# ., "${r_W}"
# ., "${r_T}"
# ., "${r_N}"
# ., "${r_R}"

unset files_orig
typeset -a files_orig
while IFS=" " read -r -d $'\0'; do
    files_orig+=( "${REPLY}" )
done < <(\
    for i in "${r_W}" "${r_T}" "${r_N}" "${r_R}"; do
        find "${i}" \
            -type f \
            -name "*_R?_001.fastq.gz" \
            -print0 \
                | sort -z
    done \
)
echo_test "${files_orig[@]}"
echo "${#files_orig[@]}"  # 165
echo $(( ${#files_orig[@]} / 3 ))  # 55

iter=1
for i in "${files_orig[@]}"; do
    a="${i}"
    b="$(basename "${i}")"

    echo "   iter  ${iter}"
    echo " target  ${a}"
    echo "symlink  ${b}"
    echo ""

    # unlink "${b}"
    ln -s "${a}" "${b}"

    (( iter++ ))
done
# ., "fastqs_UMI-dedup/symlinks"
```
</details>
<br />
<br />

<a id="pre-get-fastq-file-stems-into-arrays"></a>
## <u>PRE</u> Get `fastq` file stems into arrays
<a id="get-situated"></a>
### Get situated
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge
```
</details>
<br />

<a id="create-an-array-of-file-stems"></a>
### Create an array of file stems
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Create an array of file stems</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Create the array
unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
done < <(\
    find "./fastqs_UMI-dedup/symlinks" \
        -type l \
        -name "*.fastq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"  # 165
echo $(( ${#fq_bases[@]} / 3 ))  # 55

#  Remove duplicate stems from the array
IFS=" " read -r -a fq_bases \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fq_bases[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"  # 55
echo $(( ${#fq_bases[@]} * 3 ))  # 165
```
</details>
<br />

<a id="create-arrays-of-specific-files-derived-from-the-stems"></a>
### Create arrays of specific files (derived from the stems)
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Create arrays of specific files (derived from the stems)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset UMIs

unset r1
unset r1_pro
unset r1_trim
unset r1_cor
unset r1_cor_cln
unset r1_UTK
unset r1_UT

unset r3
unset r3_pro
unset r3_trim
unset r3_cor
unset r3_cor_cln
unset r3_UTK
unset r3_UT

typeset -a UMIs

typeset -a r1
typeset -a r1_pro
typeset -a r1_trim
typeset -a r1_cor
typeset -a r1_cor_cln
typeset -a r1_UTK
typeset -a r1_UT

typeset -a r3
typeset -a r3_pro
typeset -a r3_trim
typeset -a r3_cor
typeset -a r3_cor_cln
typeset -a r3_UTK
typeset -a r3_UT

for i in "${fq_bases[@]}"; do
          UMIs+=( "${i}_R2_001.fastq.gz" )

            r1+=( "${i}_R1_001.fastq.gz" )
        r1_pro+=( "./fastqs_UMI-dedup/umi-tools_extract/$(basename "${i}_R1.UMI.fq.gz")" )
       r1_trim+=( "./fastqs_UMI-dedup/atria_trim/$(basename "${i}_R1.UMI.atria.fq.gz")" )
        r1_cor+=( "./fastqs_UMI-dedup/rcorrector/$(basename "${i}_R1.UMI.atria.cor.fq.gz")" )
    r1_cor_cln+=( "./fastqs_UMI-dedup/rcorrector_clean-up/$(basename "${i}_R1.UMI.atria.cor.rm-unfx.fq.gz")" )
        r1_UTK+=( "./bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected/$(echo $(basename "${i}") | sed 's:_S[0-9]\+::g; s:sample_::I')_UTK_R1.fq.gz" )
         r1_UT+=( "./bams_UMI-dedup/to-align_umi-extracted_trimmed/$(echo $(basename "${i}") | sed 's:_S[0-9]\+::g; s:sample_::I')_UT_R1.fq.gz" )

            r3+=( "${i}_R3_001.fastq.gz" )
        r3_pro+=( "./fastqs_UMI-dedup/umi-tools_extract/$(basename "${i}_R3.UMI.fq.gz")" )
       r3_trim+=( "./fastqs_UMI-dedup/atria_trim/$(basename "${i}_R3.UMI.atria.fq.gz")" )
        r3_cor+=( "./fastqs_UMI-dedup/rcorrector/$(basename "${i}_R3.UMI.atria.cor.fq.gz")" )
    r3_cor_cln+=( "./fastqs_UMI-dedup/rcorrector_clean-up/$(basename "${i}_R3.UMI.atria.cor.rm-unfx.fq.gz")" )
        r3_UTK+=( "./bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected/$(echo $(basename "${i}") | sed 's:_S[0-9]\+::g; s:sample_::I')_UTK_R3.fq.gz" )
         r3_UT+=( "./bams_UMI-dedup/to-align_umi-extracted_trimmed/$(echo $(basename "${i}") | sed 's:_S[0-9]\+::g; s:sample_::I')_UT_R3.fq.gz" )

    prefix_UTK+=( "./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/$(echo $(basename "${i}") | sed 's:_S[0-9]\+::g; s:sample_::I')_UTK" )
     prefix_UT+=( "./bams_UMI-dedup/aligned_umi-extracted_trimmed/$(echo $(basename "${i}") | sed 's:_S[0-9]\+::g; s:sample_::I')_UT" )
done

echo_test "${UMIs[@]}"        # ., "${UMIs[24]}"

echo_test "${r1[@]}"          # ., "${r1[25]}"
echo_test "${r1_pro[@]}"      # ., "${r1_pro[26]}"
echo_test "${r1_trim[@]}"     # ., "${r1_trim[29]}"
echo_test "${r1_cor[@]}"      # ., "${r1_cor[30]}"
echo_test "${r1_cor_cln[@]}"  # ., "${r1_cor_cln[31]}"
echo_test "${r1_UTK[@]}"      # ., "${r1_UTK[32]}"
echo_test "${r1_UT[@]}"       # ., "${r1_UT[32]}"

echo_test "${r3[@]}"          # ., "${r3[27]}"
echo_test "${r3_pro[@]}"      # ., "${r3_pro[28]}"
echo_test "${r3_trim[@]}"     # ., "${r3_trim[29]}"
echo_test "${r3_cor[@]}"      # ., "${r3_cor[30]}"
echo_test "${r3_cor_cln[@]}"  # ., "${r3_cor_cln[31]}"
echo_test "${r3_UTK[@]}"      # ., "${r3_UTK[32]}"
echo_test "${r3_UT[@]}"       # ., "${r3_UT[32]}"

echo_test "${prefix_UTK[@]}"  # ., "${prefix_UTK[33]}"
echo_test "${prefix_UT[@]}"   # ., "${prefix_UT[33]}"

echo "${#UMIs[@]}"

echo "${#r1[@]}"
echo "${#r1_pro[@]}"
echo "${#r1_trim[@]}"
echo "${#r1_cor[@]}"
echo "${#r1_cor_cln[@]}"
echo "${#r1_UTK[@]}"
echo "${#r1_UT[@]}"

echo "${#r3[@]}"
echo "${#r3_pro[@]}"
echo "${#r3_trim[@]}"
echo "${#r3_cor[@]}"
echo "${#r3_cor_cln[@]}"
echo "${#r3_UTK[@]}"
echo "${#r3_UT[@]}"

echo "${#prefix_UTK[@]}"
echo "${#prefix_UT[@]}"
```
</details>
<br />
<br />

<a id="i-append-umis-to-fastqs-r1-and-r3-trinity-general"></a>
## <u>I</u> Append UMIs to `fastq`s `R1` and `R3` *(Trinity, general)*
<a id="01-get-situated-make-a-directory-for-the-processed-r1-and-r3-fastqs"></a>
### 01 Get situated, make a directory for the processed `R1` and `R3` `fastq`s
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Get situated, make a directory for the processed R1 and R3 fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4

if [[ ! -d "./fastqs_UMI-dedup/umi-tools_extract/lists" ]]; then
    mkdir -p "./fastqs_UMI-dedup/umi-tools_extract/lists"
fi
```
</details>
<br />

<a id="02-set-up-necessary-variables"></a>
### 02 Set up necessary variables
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_umi-tools_extract.sh"  # echo "${script_run}"
script_submit="submit_run_umi-tools_extract.sh"  # echo "${script_submit}"
threads=1  # echo "${threads}"

store_scripts="./sh_err_out"  # echo "${store_scripts}"
store_err_out="./sh_err_out/err_out"  # echo "${store_err_out}"
store_lists="./fastqs_UMI-dedup/umi-tools_extract/lists"  # echo "${store_lists}"

list="umi-tools_extract.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list"></a>
#### 03a Generate the full list
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: Generate the full list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_lists}/${list}" ]]; then
    rm "${store_lists}/${list}"
fi
echo "UMIs \
r1 \
r1_pro \
r3 \
r3_pro" \
    > "${store_lists}/${list}"
#  ., "${store_lists}/${list}"
#  vi "${store_lists}/${list}"
# cat "${store_lists}/${list}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{UMIs} \
{r1} \
{r1_pro} \
{r3} \
{r3_pro}" \
::: UMIs "${UMIs[@]}" \
:::+ r1 "${r1[@]}" \
:::+ r1_pro "${r1_pro[@]}" \
:::+ r3 "${r3[@]}"  \
:::+ r3_pro "${r3_pro[@]}" \
    >> "${store_lists}/${list}"
#        ., "${store_lists}/${list}"
#     wc -l "${store_lists}/${list}"
#  head -20 "${store_lists}/${list}"
```
</details>
<br />

<a id="03b-break-the-full-multi-line-list-into-individual-per-line-lists"></a>
#### 03b Break the full, multi-line list into individual per-line lists
<a id="code-7"></a>
##### Code
<details>
<summary><i>Code: Break the full, multi-line list into individual per-line lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm \
        "${store_lists}/"${list%.txt}.?.txt \
        "${store_lists}/"${list%.txt}.??.txt
fi
#  ., "${store_lists}"
#  vi "${store_lists}/${list}"  # :q
# cat "${store_lists}/${list}"  # :q

typeset -i i=0
sed 1d "${store_lists}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists}/${individual}" ]] || rm "${store_lists}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists}/${list}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists}/${individual}"
done
#  ., "${store_lists}"
#  vi "${store_lists}/${list%.txt}.4.txt"  # :q
# cat "${store_lists}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-a-run-script"></a>
### 04 Use a `HEREDOC` to write a '`run`' script
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write a 'run' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_run}" ]]; then
    rm "./${store_scripts}/${script_run}"
fi
cat << script > "./${store_scripts}/${script_run}"
#!/bin/bash

#  ${script_run}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


#  ------------------------------------
#TODO Help message
#  ...

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"
check_file_exists "\${arguments}"


#  Echo -------------------------------
parallel --header : --colsep " " -k -j 1 echo \
    'umi_tools extract \
        --bc-pattern=NNNNNNNN \
        --stdin={UMIs} \
        --read2-in={r1} \
        --stdout={r1_pro} \
        --read2-stdout' \
:::: "\${arguments}"
echo ""

parallel --header : --colsep " " -k -j 1 echo \
    'umi_tools extract \
        --bc-pattern=NNNNNNNN \
        --stdin={UMIs} \
        --read2-in={r3} \
        --stdout={r3_pro} \
        --read2-stdout' \
:::: "\${arguments}"


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \
    'umi_tools extract \
        --bc-pattern=NNNNNNNN \
        --stdin={UMIs} \
        --read2-in={r1} \
        --stdout={r1_pro} \
        --read2-stdout' \
:::: "\${arguments}"

parallel --header : --colsep " " -k -j 1 \
    'umi_tools extract \
        --bc-pattern=NNNNNNNN \
        --stdin={UMIs} \
        --read2-in={r3} \
        --stdout={r3_pro} \
        --read2-stdout' \
:::: "\${arguments}"

script
chmod +x "./${store_scripts}/${script_run}"
#  ., "./${store_scripts}"
#  ., "./${store_scripts}/${script_run}"
#  vi "./${store_scripts}/${script_run}"  # :q
# cat "./${store_scripts}/${script_run}"
```
</details>
<br />

<a id="05-use-a-heredoc-to-write-submit-script"></a>
### 05 Use a `HEREDOC` to write '`submit`' script
<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write 'submit' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_submit}" ]]; then
    rm "./${store_scripts}/${script_submit}"
fi
cat << script > "${store_scripts}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=./${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$1 }' \
        | sed 's/_R2_001.fastq.gz//g' \
        | sed 's:\.\/fastqs_UMI-dedup\/symlinks\/::g'
)"

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \
    "${store_scripts}/${script_run}" \
        -a "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  ., "${store_scripts}"
#  ., "${store_scripts}/${script_submit}"
#  vi "${store_scripts}/${script_submit}"  # :q
# cat -n "${store_scripts}/${script_submit}"

#  Scraps
# cat "./${store_lists}/${list%.txt}.24.txt" \
#     | awk -v OFS='\t' 'FNR == 2 { print $1 }' \
#     | sed 's/_R2_001.fastq.gz//g' \
#     | sed 's:\.\/fastqs_UMI-dedup\/symlinks\/::g'
```
</details>
<br />

<a id="06-use-sbatch-to-run-the-submission-and-run-scripts"></a>
### 06 Use `sbatch` to run the '`submission`' and '`run`' scripts
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4

sbatch "${store_scripts}/${script_submit}"
# alias crj=".,f ./sh_err_out/err_out/ | tail -220"
# alias grj="cd ./sh_err_out/err_out/ && .,f | tail -220"
# alias t220=".,f | tail -220"
```
</details>
<br />
<br />

<a id="ii-perform-adapter-and-quality-trimming-of-the-fastqs-trinity-general"></a>
## <u>II</u> Perform adapter and quality trimming of the `fastq`s *(Trinity, general)*
<a id="01-get-situated-make-a-directory-for-the-adapterquality-trimmed-r1-and-r3-fastqs"></a>
### 01 Get situated, make a directory for the adapter/quality-trimmed `R1` and `R3` `fastq`s
<a id="code-11"></a>
#### Code
<details>
<summary><i>Code: Get situated, make make a directory for the adapter/quality-trimmed R1 and R3 fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge
atria_env

if [[ ! -d "./fastqs_UMI-dedup/atria_trim/lists" ]]; then
    mkdir -p "./fastqs_UMI-dedup/atria_trim/lists"
fi
```
</details>
<br />

<a id="02-set-up-necessary-variables-1"></a>
### 02 Set up necessary variables
<a id="code-12"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_atria_trim.sh"  # echo "${script_run}"
script_submit="submit_run_atria_trim.sh"  # echo "${script_submit}"
threads=8  # echo "${threads}"

store_scripts="sh_err_out"  # echo "${store_scripts}"
store_err_out="sh_err_out/err_out"  # echo "${store_err_out}"
store_lists="fastqs_UMI-dedup/atria_trim/lists"  # echo "${store_lists}"

list="atria_trim.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-1"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list-1"></a>
#### 03a Generate the full list
<a id="code-13"></a>
##### Code
<details>
<summary><i>Code: Generate the full list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_lists}/${list}" ]]; then
    rm "${store_lists}/${list}"
fi
echo "r1_pro \
r3_pro \
outdir" \
    > "${store_lists}/${list}"
#  ., "${store_lists}/${list}"
#  vi "${store_lists}/${list}"
# cat "${store_lists}/${list}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{r1_pro} \
{r3_pro} \
{outdir}" \
:::  r1_pro "${r1_pro[@]}" \
:::+ r3_pro "${r3_pro[@]}" \
:::  outdir "$(dirname ${r1_trim[24]})" \
    >> "${store_lists}/${list}"
#        ., "${store_lists}"
#        ., "${store_lists}/${list}"
#     wc -l "${store_lists}/${list}"
#  head -20 "${store_lists}/${list}"
```
</details>
<br />

<a id="03b-break-the-full-multi-line-list-into-individual-per-line-lists-1"></a>
#### 03b Break the full, multi-line list into individual per-line lists
<a id="code-14"></a>
##### Code
<details>
<summary><i>Code: Break the full, multi-line list into individual per-line lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm \
        "${store_lists}/"${list%.txt}.?.txt \
        "${store_lists}/"${list%.txt}.??.txt
fi
#  ., "${store_lists}"
#  vi "${store_lists}/${list}"  # :q
# cat "${store_lists}/${list}"

typeset -i i=0
sed 1d "${store_lists}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists}/${individual}" ]] || rm "${store_lists}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists}/${list}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists}/${individual}"
done
#  ., "${store_lists}"
#  vi "${store_lists}/${list%.txt}.4.txt"  # :q
# cat "${store_lists}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-a-run-script-1"></a>
### 04 Use a `HEREDOC` to write a '`run`' script
<a id="code-15"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write a 'run' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_run}" ]]; then
    rm "./${store_scripts}/${script_run}"
fi
cat << script > "./${store_scripts}/${script_run}"
#!/bin/bash

#  ${script_run}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


#  ------------------------------------
#TODO Help message
#  ...

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"
check_file_exists "\${arguments}"


#  ------------------------------------
eval "\$(conda shell.bash hook)"
conda activate atria_env


#  Echo -------------------------------
parallel --header : --colsep " " -k -j 1 echo \
    '\${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria \
        -t ${threads} \
        -r {r1_pro} \
        -R {r3_pro} \
        -o {outdir} \
        --no-length-filtration \
        --stats' \
:::: "\${arguments}"
echo ""


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \
    '\${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria \
        -t ${threads} \
        -r {r1_pro} \
        -R {r3_pro} \
        -o {outdir} \
        --no-length-filtration \
        --stats' \
:::: "\${arguments}"

script
chmod +x "./${store_scripts}/${script_run}"
#  ., "./${store_scripts}"
#  ., "./${store_scripts}/${script_run}"
#  vi "./${store_scripts}/${script_run}"  # :q
# cat "./${store_scripts}/${script_run}"
```
</details>
<br />

<a id="05-use-a-heredoc-to-write-submit-script-1"></a>
### 05 Use a `HEREDOC` to write '`submit`' script
<a id="code-16"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write 'submit' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_submit}" ]]; then
    rm "./${store_scripts}/${script_submit}"
fi
cat << script > "${store_scripts}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$1 }' \
    	| sed 's:\.\/fastqs_UMI-dedup\/umi\-tools_extract\/::g' \
    	| sed 's/_R1.UMI.fq.gz//g'
)"

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \
    "${store_scripts}/${script_run}" \
        -a "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  ., "${store_scripts}"
#  ., "${store_scripts}/${script_submit}"
#  vi "${store_scripts}/${script_submit}"  # :q
# cat "${store_scripts}/${script_submit}"

#  Scraps
# cat "./${store_lists}/${list%.txt}.24.txt" \
#     | awk -v OFS='\t' 'FNR == 2 { print $1 }' \
#     | sed 's:\.\/fastqs_UMI-dedup\/umi\-tools_extract\/::g' \
#     | sed 's/_R1.UMI.fq.gz//g'
```
</details>
<br />

<a id="06-use-sbatch-to-run-the-submission-and-run-scripts-1"></a>
### 06 Use `sbatch` to run the '`submission`' and '`run`' scripts
<a id="code-17"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge
atria_env

sbatch "${store_scripts}/${script_submit}"
# alias crj=".,f ./sh_err_out/err_out/ | tail -220"
# alias grj="cd ./sh_err_out/err_out/ && .,f | tail -220"
# alias t220=".,f | tail -220"
```
</details>
<br />
<br />

<a id="iii-perform-kmer-correction-with-rcorrector-trinity"></a>
## <u>III</u> Perform kmer correction with `rcorrector` *(Trinity)*
*(for transcriptome-assembly experiments)*

<a id="01-get-situated-make-a-directory-for-kmer-corrected-fastqs"></a>
### 01 Get situated, make a directory for kmer-corrected `fastq`s
<a id="code-18"></a>
#### Code
<details>
<summary><i>Code: Get situated, make a directory for kmer-corrected fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge
Trinity_env

if [[ ! -d "./fastqs_UMI-dedup/rcorrector/lists" ]]; then
    mkdir -p "./fastqs_UMI-dedup/rcorrector/lists"
fi
```
</details>
<br />

<a id="02-set-up-necessary-variables-2"></a>
### 02 Set up necessary variables
<a id="code-19"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_rcorrector.sh"  # echo "${script_run}"
script_submit="submit_run_rcorrector.sh"  # echo "${script_submit}"
threads=8  # echo "${threads}"

store_scripts="sh_err_out"  # echo "${store_scripts}"
store_err_out="sh_err_out/err_out"  # echo "${store_err_out}"
store_lists="fastqs_UMI-dedup/rcorrector/lists"  # echo "${store_lists}"

list="rcorrector.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-2"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list-2"></a>
#### 03a Generate the full list
<a id="code-20"></a>
##### Code
<details>
<summary><i>Code: Generate the full list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_lists}/${list}" ]]; then
    rm "${store_lists}/${list}"
fi
echo "r1_trim \
r3_trim \
outdir" \
    > "${store_lists}/${list}"
#  ., "${store_lists}/${list}"
#  vi "${store_lists}/${list}"
# cat "${store_lists}/${list}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{r1_trim} \
{r3_trim} \
{outdir}" \
:::  r1_trim "${r1_trim[@]}" \
:::+ r3_trim "${r3_trim[@]}" \
:::  outdir "./fastqs_UMI-dedup/rcorrector" \
    >> "${store_lists}/${list}"
#        ., "${store_lists}"
#        ., "${store_lists}/${list}"
#     wc -l "${store_lists}/${list}"
#  head -20 "${store_lists}/${list}"
```
</details>
<br />

<a id="03b-break-the-full-multi-line-list-into-individual-per-line-lists-2"></a>
#### 03b Break the full, multi-line list into individual per-line lists
<a id="code-21"></a>
##### Code
<details>
<summary><i>Code: Break the full, multi-line list into individual per-line lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm \
        "${store_lists}/"${list%.txt}.?.txt \
        "${store_lists}/"${list%.txt}.??.txt
fi
#  ., "${store_lists}"
#  vi "${store_lists}/${list}"  # :q
# cat "${store_lists}/${list}"

typeset -i i=0
sed 1d "${store_lists}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists}/${individual}" ]] || rm "${store_lists}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists}/${list}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists}/${individual}"
done
#  ., "${store_lists}"
#  vi "${store_lists}/${list%.txt}.4.txt"  # :q
# cat "${store_lists}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-a-run-script-2"></a>
### 04 Use a `HEREDOC` to write a '`run`' script
<a id="code-22"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write a 'run' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_run}" ]]; then
    rm "./${store_scripts}/${script_run}"
fi
cat << script > "./${store_scripts}/${script_run}"
#!/bin/bash

#  ${script_run}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


#  ------------------------------------
#TODO Help message
#  ...

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"
check_file_exists "\${arguments}"


#  ------------------------------------
eval "\$(conda shell.bash hook)"
conda activate Trinity_env


#  Echo -------------------------------
parallel --header : --colsep " " -k -j 1 echo \\
    'run_rcorrector.pl \\
        -t ${threads} \\
        -1 {r1_trim} \\
        -2 {r3_trim} \\
        -od {outdir}' \\
:::: "\${arguments}"
echo ""


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \\
    'run_rcorrector.pl \\
        -t ${threads} \\
        -1 {r1_trim} \\
        -2 {r3_trim} \\
        -od {outdir}' \\
:::: "\${arguments}"

script
chmod +x "./${store_scripts}/${script_run}"
# .,f "./${store_scripts}"
#  ., "./${store_scripts}/${script_run}"
#  vi "./${store_scripts}/${script_run}"  # :q
# cat "./${store_scripts}/${script_run}"
```
</details>
<br />

<a id="05-use-a-heredoc-to-write-submit-script-2"></a>
### 05 Use a `HEREDOC` to write '`submit`' script
<a id="code-23"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write 'submit' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#TODO Fix line 1307: Wrong directory!
if [[ -f "./${store_scripts}/${script_submit}" ]]; then
    rm "./${store_scripts}/${script_submit}"
fi
cat << script > "${store_scripts}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_JOB_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$1 }' \\
        | sed 's:\.\/fastqs_UMI-dedup\/atria_trim\/::g' \\
        | sed 's/_R1.UMI.atria.fq.gz//g'
)"

ln -f \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${store_scripts}/${script_run}" \\
        -a "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

script
# .,f "${store_scripts}"
#  ., "${store_scripts}/${script_submit}"
#  vi "${store_scripts}/${script_submit}"  # :q
# cat "${store_scripts}/${script_submit}"

#  Scraps
# cat "./${store_lists}/${list%.txt}.24.txt" \
#     | awk -v OFS='\t' 'FNR == 2 { print $1 }' \
#     | sed 's:\.\/fastqs_UMI-dedup\/atria_trim\/::g' \
#     | sed 's/_R1.UMI.atria.fq.gz//g'
```
</details>
<br />

<a id="06-use-sbatch-to-run-the-submission-and-run-scripts-2"></a>
### 06 Use `sbatch` to run the '`submission`' and '`run`' scripts
<a id="code-24"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge

sbatch "${store_scripts}/${script_submit}"
# alias crj=".,f ./sh_err_out/err_out/ | tail -220"
# alias grj="cd ./sh_err_out/err_out/ && .,f | tail -220"
# alias t220=".,f | tail -220"

#TODO 1/2 So that tmp_* files are written/read from scratch, get this code 
#TODO 2/2 running from scratch 
```
</details>
<br />
<br />

<a id="iv-correct-the-rcorrected-fastqs-trinity"></a>
## <u>IV</u> "Correct" the `rcorrect`ed `fastq`s *(Trinity)*
<a id="01-get-situated-make-a-directory-for-kmer-corrected-fastqs-1"></a>
### 01 Get situated, make a directory for kmer-corrected `fastq`s
<a id="code-25"></a>
#### Code
<details>
<summary><i>Code: Get situated, make a directory for kmer-corrected fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge
source activate Trinity_env

if [[ ! -d "./fastqs_UMI-dedup/rcorrector_clean-up/lists" ]]; then
    mkdir -p "./fastqs_UMI-dedup/rcorrector_clean-up/lists"
fi
```
</details>
<br />

<a id="02-set-up-necessary-variables-3"></a>
### 02 Set up necessary variables
<a id="code-26"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/bin/filter_rCorrector-treated-fastqs.py"  # echo "${script_run}"
script_submit="submit_run_rcorrector_clean-up.sh"  # echo "${script_submit}"
threads=1  # echo "${threads}"

store_scripts="sh_err_out"  # echo "${store_scripts}"
store_err_out="sh_err_out/err_out"  # echo "${store_err_out}"
store_lists="fastqs_UMI-dedup/rcorrector_clean-up/lists"  # echo "${store_lists}"

list="rcorrector_clean-up.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-3"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list-3"></a>
#### 03a Generate the full list
<a id="code-27"></a>
##### Code
<details>
<summary><i>Code: Generate the full list</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_lists}/${list}" ]]; then
    rm "${store_lists}/${list}"
fi
echo "r1_cor \
r3_cor \
sample \
outdir" \
    > "${store_lists}/${list}"
#  ., "${store_lists}/${list}"
#  vi "${store_lists}/${list}"
# cat "${store_lists}/${list}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{r1_cor} \
{r3_cor} \
{sample} \
{outdir}" \
:::  r1_cor "${r1_cor[@]#\.\/}" \
:::+ r3_cor "${r3_cor[@]#\.\/}" \
:::+ sample "${fq_bases[@]##*\/}" \
:::  outdir "fastqs_UMI-dedup/rcorrector_clean-up" \
    >> "${store_lists}/${list}"
#        ., "${store_lists}"
#        ., "${store_lists}/${list}"
#     wc -l "${store_lists}/${list}"
#  head -20 "${store_lists}/${list}"
```
</details>
<br />

<a id="03b-break-the-full-multi-line-list-into-individual-per-line-lists-3"></a>
#### 03b Break the full, multi-line list into individual per-line lists
<a id="code-28"></a>
##### Code
<details>
<summary><i>Code: Break the full, multi-line list into individual per-line lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm \
        "${store_lists}/"${list%.txt}.?.txt \
        "${store_lists}/"${list%.txt}.??.txt
fi
#  ., "${store_lists}"
#  vi "${store_lists}/${list}"  # :q
# cat "${store_lists}/${list}"

typeset -i i=0
sed 1d "${store_lists}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists}/${individual}" ]] || rm "${store_lists}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists}/${list}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists}/${individual}"
done
#  ., "${store_lists}"
#  vi "${store_lists}/${list%.txt}.4.txt"  # :q
# cat "${store_lists}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="04-check-on-the-run-script"></a>
### 04 Check on the '`run`' script
<a id="code-29"></a>
#### Code
<details>
<summary><i>Code: Check on the 'run' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

., "${script_run}"
cat -n "${script_run}"
```
</details>
<br />

<a id="05-use-a-heredoc-to-write-submit-script-3"></a>
### 05 Use a `HEREDOC` to write '`submit`' script
<a id="code-30"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write 'submit' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#NOTE 1/3 Here, note how we're calling the Python script from it's absolute
#NOTE 2/3 path starting from home and also sourcing the in- and outfiles
#NOTE 3/3 from home-derived absolute paths too
if [[ -f "./${store_scripts}/${script_submit}" ]]; then
    rm "./${store_scripts}/${script_submit}"
fi
cat << script > "${store_scripts}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=$(basename ${script_run})
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${store_err_out}/$(basename ${script_run%.py}).%A-%a.err.txt
#SBATCH --output=${store_err_out}/$(basename ${script_run%.py}).%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$3 }'
)"

ln -f \\
    ${store_err_out}/$(basename ${script_run%.py}).\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${store_err_out}/$(basename ${script_run%.py}).\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${store_err_out}/$(basename ${script_run%.py}).\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${store_err_out}/$(basename ${script_run%.py}).\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun python \\
    "${script_run}" \\
        -1 "$(pwd)/\$(cat "${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print \$1 }')" \\
        -2 "$(pwd)/\$(cat "${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print \$2 }')" \\
        -s "$(pwd)/\$(cat "${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print \$3 }')" \\
        -o "$(pwd)/\$(cat "${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print \$4 }')" \\
        -g True

rm \\
    ${store_err_out}/$(basename ${script_run%.py}).\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${store_err_out}/$(basename ${script_run%.py}).\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

script
#    .,f "${store_scripts}"
#     ., "${store_scripts}/${script_submit}"
#     vi "${store_scripts}/${script_submit}"  # :q
# cat -n "${store_scripts}/${script_submit}"


#  ------------------------------------
#  Scrap #1
# cat "./${store_lists}/${list%.txt}.24.txt" \
#     | awk -v OFS='\t' 'FNR == 2 { print $3 }'

#  Scrap #2
# SLURM_ARRAY_TASK_ID=24
# srun python \\
#     "${script_run}" \\
#         -1 ., "$(pwd)/$(cat "${store_lists}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print $1 }')" \\
#         -2 ., "$(pwd)/$(cat "${store_lists}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print $2 }')" \\
#         -s ., "$(pwd)/$(cat "${store_lists}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print $3 }')" \\
#         -o ., "$(pwd)/$(cat "${store_lists}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" | awk 'FNR == 2 { print $4 }')" \\
#         -g True
```
</details>
<br />

<a id="06-use-sbatch-to-run-the-submission-and-run-scripts-3"></a>
### 06 Use `sbatch` to run the '`submission`' and '`run`' scripts
<a id="code-31"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge

sbatch "${store_scripts}/${script_submit}"
# alias crj=".,f ./sh_err_out/err_out/ | tail -220"
# alias grj="cd ./sh_err_out/err_out/ && .,f | tail -220"
# alias t220=".,f | tail -220"
```
</details>
<br />
<br />

<a id="v-align-kmer--and-non-kmer-corrected-fastqs-trinity"></a>
## <u>V</u> Align kmer- and non-kmer-corrected `fastq`s *(Trinity)*
<a id="01-get-situated-make-directories-for-in-outfiles-symlink-the-fastqs"></a>
### 01 Get situated, make directories for in-/outfiles, symlink the `fastq`s
<a id="01a-get-situated-make-directories-for-in-outfiles"></a>
#### 01a Get situated, make directories for in-/outfiles
<a id="code-32"></a>
##### Code
<details>
<summary><i>Code: Get situated, make directories for in-/outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge
source activate Trinity_env

if [[ ! -d "./bams_UMI-dedup" ]]; then
    mkdir -p "./bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected"
    mkdir -p "./bams_UMI-dedup/to-align_umi-extracted_trimmed"
    mkdir -p "./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/lists"
    mkdir -p "./bams_UMI-dedup/aligned_umi-extracted_trimmed/lists"
fi
```
</details>
<br />

<a id="01b-establish-relative-paths-for-symlinking"></a>
#### 01b Establish relative paths for symlinking
<a id="initialize-function-for-finding-relative-paths-between-directories"></a>
##### Initialize function for finding relative paths between directories
<a id="code-33"></a>
###### Code
<details>
<summary><i>Code: Initialize function for finding relative paths between directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}
```
</details>
<br />

<a id="establish-relative-path-for-umi-extracted-u-trimmed-t-kmer-corrected-k-fastqs"></a>
##### Establish relative path for UMI-extracted (`U`), trimmed (`T`), kmer-corrected (`K`) `fastq`s
<a id="code-34"></a>
###### Code
<details>
<summary><i>Code: Establish relative path for UMI-extracted (U), trimmed (T), kmer-corrected (K) fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

p_kmer_cor_path="$(
    find_relative_path \
        "bams_UMI-dedup/to-align_trimmed_kmer-cor/" \
        "fastqs_UMI-dedup/rcorrector_clean-up/"
)"
# echo "${p_kmer_cor_path}"
```
</details>
<br />

<a id="establish-relative-path-for-umi-extracted-u-trimmed-t-fastqs"></a>
##### Establish relative path for UMI-extracted (`U`), trimmed (`T`) `fastq`s
<a id="code-35"></a>
###### Code
<details>
<summary><i>Code: Establish relative path for UMI-extracted (U), trimmed (T) fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

p_kmer_uncor_path="$(
    find_relative_path \
        "bams_UMI-dedup/to-align_trimmed_no-kmer-cor/" \
        "fastqs_UMI-dedup/atria_trim/"
)"
# echo "${p_kmer_no_cor}"
```
</details>
<br />

<a id="initialize-arrays-of-to-symlink-source-and-target-utk-fastqs"></a>
##### Initialize arrays of to-symlink source and target `UTK` `fastq`s
<a id="code-36"></a>
###### Code
<details>
<summary><i>Code: Initialize arrays of to-symlink source and target UTK fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  UMI-extracted (U), trimmed (T), kmer-corrected (K) files
unset fq_kmer_cor_init
unset fq_kmer_cor_sym
typeset -a fq_kmer_cor_init
typeset -a fq_kmer_cor_sym
while IFS=" " read -r -d $'\0'; do
    fq_kmer_cor_init+=(
        "$(echo "${p_kmer_cor_path}/$(basename "${REPLY}")")"
    )
    fq_kmer_cor_sym+=("$(
        echo "$(basename "${REPLY%.UMI.atria.cor.rm-unfx.fq.gz}").fq.gz" \
            | sed 's:_S[0-9]\+_:_:g; s:sample_::I' \
            | sed 's:_R1:_UTK_R1:g; s:_R3:_UTK_R3:g'
    )")
done < <(\
    find "./fastqs_UMI-dedup/rcorrector_clean-up" \
        -type f \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
# echo_test "${fq_kmer_cor_init[@]}"
# echo_test "${fq_kmer_cor_sym[@]}"
# echo "${#fq_kmer_cor_init[@]}"
# echo "${#fq_kmer_cor_sym[@]}"
```
</details>
<br />

<a id="initialize-arrays-of-to-symlink-source-and-target-ut-fastqs"></a>
##### Initialize arrays of to-symlink source and target `UT` `fastq`s
<a id="code-37"></a>
###### Code
<details>
<summary><i>Code: Initialize arrays of to-symlink source and target UT fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  UMI-extracted (U), trimmed (T) files
unset fq_kmer_uncor_init
unset fq_kmer_uncor_sym
typeset -a fq_kmer_uncor_init
typeset -a fq_kmer_uncor_sym
while IFS=" " read -r -d $'\0'; do
    fq_kmer_uncor_init+=(
        "$(echo "${p_kmer_uncor_path}/$(basename "${REPLY}")")"
    )
    fq_kmer_uncor_sym+=("$(
        echo "$(basename "${REPLY%.UMI.atria.fq.gz}").fq.gz" \
            | sed 's:_S[0-9]\+_:_:g; s:sample_::I' \
            | sed 's:_R1:_UT_R1:g; s:_R3:_UT_R3:g'
    )")
done < <(\
    find "./fastqs_UMI-dedup/atria_trim" \
        -maxdepth 1 \
        -type f \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
# echo_test "${fq_kmer_uncor_init[@]}"
# echo_test "${fq_kmer_uncor_sym[@]}"
# echo "${#fq_kmer_uncor_init[@]}"
# echo "${#fq_kmer_uncor_sym[@]}"
```
</details>
<br />

<a id="01c-create-the-symlinks"></a>
#### 01c Create the symlinks
<a id="symlink-the-utk-fastqs"></a>
##### Symlink the `UTK` `fastq`s
<a id="code-38"></a>
###### Code
<details>
<summary><i>Code: Symlink the UTK fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "./bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected" ||
    echo "cd'ing failed; check on this..."
for (( i = 0; i <= $(( ${#fq_kmer_cor_init[@]} - 1 )); i++ )); do
    echo "${fq_kmer_cor_init["${i}"]}"
    echo "${fq_kmer_cor_sym["${i}"]}"
    ln -s "${fq_kmer_cor_init["${i}"]}" "${fq_kmer_cor_sym["${i}"]}"
    echo ""
done
# .,
```
</details>
<br />

<a id="symlink-the-ut-fastqs"></a>
##### Symlink the `UT` `fastq`s
<a id="code-39"></a>
###### Code
<details>
<summary><i>Code: Symlink the UT fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "../to-align_umi-extracted_trimmed" ||
    echo "cd'ing failed; check on this..."
for (( i = 0; i <= $(( ${#fq_kmer_uncor_init[@]} - 1 )); i++ )); do
    echo "${fq_kmer_uncor_init["${i}"]}"
    echo "${fq_kmer_uncor_sym["${i}"]}"
    ln -s "${fq_kmer_uncor_init["${i}"]}" "${fq_kmer_uncor_sym["${i}"]}"
    echo ""
done
# .,
```
</details>
<br />

<a id="01d-get-back-to-the-head-working-directory"></a>
#### 01d Get back to the head working directory
<a id="code-40"></a>
##### Code
<details>
<summary><i>Code: Get back to the head working directory</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }
```
</details>
<br />

<a id="02-set-up-necessary-variables-4"></a>
### 02 Set up necessary variables
<a id="code-41"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_STAR.sh"  # echo "${script_run}"
# threads=1  # echo "${threads}"  # For echo tests
threads=8  # echo "${threads}"  # For true runs
dir_genome="${HOME}/genomes/combined_SC_KL_20S/STAR"  # ., "${dir_genome}"
multimappers=10  # echo "${multimappers}"

script_submit_UTK="submit_run_STAR_UTK.sh"  # echo "${script_submit_UTK}"
script_submit_UT="submit_run_STAR_UT.sh"  # echo "${script_submit_UT}"

max_id_job=$(( ${#fq_bases[@]} ))  # echo "${max_id_job}"
max_id_task=4  # echo "${max_id_task}"

store_scripts="sh_err_out"  # echo "${store_scripts}"
store_err_out="sh_err_out/err_out"  # echo "${store_err_out}"

store_list_UTK="bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/lists"  # echo "${store_list_UTK}"
list_UTK="STAR_UTK.txt"  # echo "${list_UTK}"

store_list_UT="bams_UMI-dedup/aligned_umi-extracted_trimmed/lists"  # echo "${store_list_UT}"
list_UT="STAR_UT.txt"  # echo "${list_UT}"

# echo_test "${r1_UTK[@]}"
# echo_test "${r3_UTK[@]}"
# echo_test "${prefix_UTK[@]}"

# echo_test "${r1_UT[@]}"
# echo_test "${r3_UT[@]}"
# echo_test "${prefix_UT[@]}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-4"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-lists"></a>
#### 03a Generate the full lists
<a id="utk-files"></a>
##### UTK files
<a id="code-42"></a>
###### Code
<details>
<summary><i>Code: UTK files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_list_UTK}/${list_UTK}" ]]; then
    rm "${store_list_UTK}/${list_UTK}"
fi
echo "read_1 \
read_2 \
prefix" \
    > "${store_list_UTK}/${list_UTK}"
#  ., "${store_list_UTK}/${list_UTK}"
#  vi "${store_list_UTK}/${list_UTK}"
# cat "${store_list_UTK}/${list_UTK}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{read_1} \
{read_2} \
{prefix}" \
:::  read_1 "${r1_UTK[@]}" \
:::+ read_2 "${r3_UTK[@]}" \
:::+ prefix "${prefix_UTK[@]}" \
    >> "${store_list_UTK}/${list_UTK}"
#        ., "${store_list_UTK}"
#        ., "${store_list_UTK}/${list_UTK}"
#     wc -l "${store_list_UTK}/${list_UTK}"
#  head -20 "${store_list_UTK}/${list_UTK}"
```
</details>
<br />

<a id="ut-files"></a>
##### UT files
<a id="code-43"></a>
###### Code
<details>
<summary><i>Code: UT files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_list_UT}/${list_UT}" ]]; then
    rm "${store_list_UT}/${list_UT}"
fi
echo "read_1 \
read_2 \
prefix" \
    > "${store_list_UT}/${list_UT}"
#  ., "${store_list_UT}/${list_UT}"
#  vi "${store_list_UT}/${list_UT}"
# cat "${store_list_UT}/${list_UT}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{read_1} \
{read_2} \
{prefix}" \
:::  read_1 "${r1_UT[@]}" \
:::+ read_2 "${r3_UT[@]}" \
:::+ prefix "${prefix_UT[@]}" \
    >> "${store_list_UT}/${list_UT}"
#        ., "${store_list_UT}"
#        ., "${store_list_UT}/${list_UT}"
#     wc -l "${store_list_UT}/${list_UT}"
#  head -20 "${store_list_UT}/${list_UT}"
```
</details>
<br />

<a id="03b-break-the-full-multi-line-list-into-individual-per-line-lists-4"></a>
#### 03b Break the full, multi-line list into individual per-line lists
<a id="utk-files-1"></a>
##### UTK files
<a id="code-44"></a>
###### Code
<details>
<summary><i>Code: UTK files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_list_UTK}/${list_UTK%.txt}.4.txt" ]]; then
    # rm "${store_list_UTK}/"${list_UTK%.txt}.{?,??,???}.txt
    rm \
        "${store_list_UTK}/${list_UTK%.txt}."?".txt" \
        "${store_list_UTK}/${list_UTK%.txt}."??".txt"
fi
#  ., "${store_list_UTK}"
#  vi "${store_list_UTK}/${list}"  # :q
# cat "${store_list_UTK}/${list}"

typeset -i i=0
sed 1d "${store_list_UTK}/${list_UTK}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list_UTK%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_list_UTK}/${individual}" ]] || rm "${store_list_UTK}/${individual}"
    # echo "${store_list_UTK}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list_UTK})" >> "${individual}"
    head -n 1 "${store_list_UTK}/${list_UTK}" >> "${store_list_UTK}/${individual}"  # cat "${store_list_UTK}/${individual}"
    echo "${line}" >> "${store_list_UTK}/${individual}"  # cat "${store_list_UTK}/${individual}"

    # echo "Created file: ${store_list_UTK}/${individual}"
done
#  ., "${store_list_UTK}"
#  vi "${store_list_UTK}/${list_UTK%.txt}.4.txt"  # :q
# cat "${store_list_UTK}/${list_UTK%.txt}.4.txt"
```
</details>
<br />

<a id="ut-files-1"></a>
##### UT files
<a id="code-45"></a>
###### Code
<details>
<summary><i>Code: UT files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_list_UT}/${list_UT%.txt}.4.txt" ]]; then
    # rm "${store_list_UT}/"${list_UT%.txt}.{?,??,???}.txt
    rm \
        "${store_list_UT}/${list_UT%.txt}."?".txt" \
        "${store_list_UT}/${list_UT%.txt}."??".txt"
fi
#  ., "${store_list_UT}"
#  vi "${store_list_UT}/${list}"  # :q
# cat "${store_list_UT}/${list}"

typeset -i i=0
sed 1d "${store_list_UT}/${list_UT}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list_UT%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_list_UT}/${individual}" ]] || rm "${store_list_UT}/${individual}"
    # echo "${store_list_UT}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list_UT})" >> "${individual}"
    head -n 1 "${store_list_UT}/${list_UT}" >> "${store_list_UT}/${individual}"  # cat "${store_list_UT}/${individual}"
    echo "${line}" >> "${store_list_UT}/${individual}"  # cat "${store_list_UT}/${individual}"

    # echo "Created file: ${store_list_UT}/${individual}"
done
#  ., "${store_list_UT}"
#  vi "${store_list_UT}/${list_UT%.txt}.4.txt"  # :q
# cat "${store_list_UT}/${list_UT%.txt}.4.txt"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-a-run-script-3"></a>
### 04 Use a `HEREDOC` to write a '`run`' script
<a id="code-46"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write a 'run' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_run}" ]]; then
    rm "./${store_scripts}/${script_run}"
fi
cat << script > "./${store_scripts}/${script_run}"
#!/bin/bash

#  ${script_run}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


#  ------------------------------------
#TODO Help message
#  ...

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"
check_file_exists "\${arguments}"


#  ------------------------------------
eval "\$(conda shell.bash hook)"
conda activate Trinity_env


#  Echo -------------------------------
parallel --header : --colsep " " -k -j 1 echo \\
    'STAR \\
        --runMode alignReads \\
        --runThreadN ${threads} \\
        --outSAMtype BAM SortedByCoordinate \\
        --outSAMunmapped Within \\
        --outSAMattributes All \\
        --genomeDir ${dir_genome} \\
        --readFilesIn {read_1} {read_2} \\
        --readFilesCommand zcat \\
        --outFileNamePrefix {prefix} \\
        --limitBAMsortRAM 4000000000 \\
        --outFilterMultimapNmax ${multimappers} \\
        --winAnchorMultimapNmax 1000 \\
        --alignSJoverhangMin 8 \\
        --alignSJDBoverhangMin 1 \\
        --outFilterMismatchNmax 999 \\
        --outMultimapperOrder Random \\
        --alignEndsType EndToEnd \\
        --alignIntronMin 4 \\
        --alignIntronMax 5000 \\
        --alignMatesGapMax 5000' \\
:::: "\${arguments}"
echo ""


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \\
    'STAR \\
        --runMode alignReads \\
        --runThreadN ${threads} \\
        --outSAMtype BAM SortedByCoordinate \\
        --outSAMunmapped Within \\
        --outSAMattributes All \\
        --genomeDir ${dir_genome} \\
        --readFilesIn {read_1} {read_2} \\
        --readFilesCommand zcat \\
        --outFileNamePrefix {prefix} \\
        --limitBAMsortRAM 4000000000 \\
        --outFilterMultimapNmax ${multimappers} \\
        --winAnchorMultimapNmax 1000 \\
        --alignSJoverhangMin 8 \\
        --alignSJDBoverhangMin 1 \\
        --outFilterMismatchNmax 999 \\
        --outMultimapperOrder Random \\
        --alignEndsType EndToEnd \\
        --alignIntronMin 4 \\
        --alignIntronMax 5000 \\
        --alignMatesGapMax 5000' \\
:::: "\${arguments}"

script
chmod +x "./${store_scripts}/${script_run}"
#    .,f "./${store_scripts}"
#     ., "./${store_scripts}/${script_run}"
#     vi "./${store_scripts}/${script_run}"  # :q
# cat -n "./${store_scripts}/${script_run}"
```
</details>
<br />

<a id="05-use-a-heredoc-to-write-submit-script-4"></a>
### 05 Use a `HEREDOC` to write '`submit`' script
<a id="utk-files-2"></a>
#### UTK files
<a id="code-47"></a>
##### Code
<details>
<summary><i>Code: UTK files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_submit_UTK}" ]]; then
    rm "./${store_scripts}/${script_submit_UTK}"
fi
cat << script > "${store_scripts}/${script_submit_UTK}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit_UTK}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_list_UTK}/${list_UTK%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$3 }' \\
        | sed 's:\.\/bams_UMI-dedup\/aligned_umi-extracted_trimmed_kmer-corrected\/::'
)"

ln -f \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${store_scripts}/${script_run}" \\
        -a "./${store_list_UTK}/${list_UTK%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

script
#    .,f "${store_scripts}"
#     ., "${store_scripts}/${script_submit_UTK}"
#     vi "${store_scripts}/${script_submit_UTK}"  # :q
# cat -n "${store_scripts}/${script_submit_UTK}"

#  Scraps
# SLURM_ARRAY_TASK_ID=24
# name="$(
#     cat "./${store_list_UTK}/${list_UTK%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $3 }'
# )"
# echo "${name}"
```
</details>
<br />

<a id="ut-files-2"></a>
#### UT files
<a id="code-48"></a>
##### Code
<details>
<summary><i>Code: UT files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_submit_UT}" ]]; then
    rm "./${store_scripts}/${script_submit_UT}"
fi
cat << script > "${store_scripts}/${script_submit_UT}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit_UT}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_list_UT}/${list_UT%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$3 }' \\
        | sed 's:\.\/bams_UMI-dedup\/aligned_umi-extracted_trimmed\/::'
)"

ln -f \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${store_err_out}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${store_scripts}/${script_run}" \\
        -a "./${store_list_UT}/${list_UT%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

script
#    .,f "${store_scripts}"
#     ., "${store_scripts}/${script_submit_UT}"
#     vi "${store_scripts}/${script_submit_UT}"  # :q
# cat -n "${store_scripts}/${script_submit_UT}"

#  Scraps
# SLURM_ARRAY_TASK_ID=24
# name="$(
#     cat "./bams_UMI-dedup/aligned_umi-extracted_trimmed/lists/STAR_UT.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $3 }' \
#         | sed 's:\.\/bams_UMI-dedup\/aligned_umi-extracted_trimmed\/::'
# )"
# echo "${name}"
```
</details>
<br />

<a id="06-use-sbatch-to-run-the-submission-and-run-scripts-4"></a>
### 06 Use `sbatch` to run the '`submission`' and '`run`' scripts
<a id="code-49"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
module purge

sbatch "${store_scripts}/${script_submit_UTK}"
sbatch "${store_scripts}/${script_submit_UT}"
# hitparade
# skal
# alias crj=".,f ./sh_err_out/err_out/ | tail -220"
# alias grj="cd ./sh_err_out/err_out/ && .,f | tail -220"
# alias t220=".,f | tail -220"
```
</details>
<br />

<a id="07-rename-organize-and-check-on-the-star-outfiles"></a>
### 07 Rename, organize, and check on the `STAR` outfiles
<a id="07a-rename-organize-and-check-on-files-in-aligned_umi-extracted_trimmed"></a>
#### 07a Rename, organize, and check on files in `aligned_umi-extracted_trimmed/`
<a id="code-50"></a>
##### Code
<details>
<summary><i>Code: Rename, organize, and check on files in aligned_umi-extracted_trimmed/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

cd "bams_UMI-dedup/aligned_umi-extracted_trimmed/" \
    || echo "cd'ing failed; check on this..."

rename -n 's/Aligned.sortedByCoord.out//g' *
rename -n 's/Log/.Log/g; s/SJ/.SJ/g' *

rename 's/Aligned.sortedByCoord.out//g' *
rename 's/Log/.Log/g; s/SJ/.SJ/g' *

rm -r *_STARtmp/

.,
#NOTE Saw that one bam had a file size of 0
```
</details>
<br />

<a id="troubleshooting-the-problem-with-ct2_6125_piaa_q_steadystate_ut"></a>
##### Troubleshooting the problem with `CT2_6125_pIAA_Q_SteadyState_UT`
<a id="code-51"></a>
###### Code
<details>
<summary><i>Code: Troubleshooting the problem with CT2_6125_pIAA_Q_SteadyState_UT</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Check on the problem bam (see 'Notes, etc.' below) -------------------------
cd ../../sh_err_out/err_out
.,f | tail -220
# -rw-rw---- 1 kalavatt 1.8K Feb  8 16:15 run_STAR.CT2_6125_pIAA_Q_SteadyState_UT.9897387-47.out.txt
# -rw-rw---- 1 kalavatt  501 Feb  8 16:15 run_STAR.CT2_6125_pIAA_Q_SteadyState_UT.9897387-47.err.txt

cat run_STAR.CT2_6125_pIAA_Q_SteadyState_UT.9897387-47.err.txt
cat run_STAR.CT2_6125_pIAA_Q_SteadyState_UT.9897387-47.out.txt

.,f | tail -880
., run_atria_trim.*
# -rw-rw---- 1 kalavatt    0 Feb  5 17:06 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9281731-47.err.txt
# -rw-rw---- 1 kalavatt  279 Feb  5 17:06 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9281731-47.out.txt
# -rw-rw---- 1 kalavatt  12K Feb  5 17:53 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9282279-47.err.txt
# -rw-rw---- 1 kalavatt  357 Feb  5 17:53 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9282279-47.out.txt
# -rw-rw---- 1 kalavatt  12K Feb  6 07:37 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.err.txt
# -rw-rw---- 1 kalavatt  365 Feb  6 07:37 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.out.txt

cat run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9281731-47.err.txt
cat run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9281731-47.out.txt
cat run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9282279-47.err.txt
cat run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9282279-47.out.txt
cat run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.err.txt
cat run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.out.txt
#NOTE Nothing unusual in the *.{err,out}.txt files

#  Check on the apparently problematic fastq.gz file
transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

zcat \
    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
        | head
zgrep -B 1 -A 4 \
    "^@VH01189:9:AAC57JMM5:1:2611:18894:53950_ATAGTACT" \
    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz

zcat \
    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
        | tail
zcat \
    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz \
        | tail


#  I don't see the problem spotted by STAR ------------------------------------
#  ...so try running STAR again for just this dataset
mkdir -p ./bams_UMI-dedup/aligned_umi-extracted_trimmed/bak
mv \
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT* \
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/bak

echo "${SLURM_CPUS_ON_NODE}"

STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes All \
    --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR \
    --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 10 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000 \
        > >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stdout.txt) \
        2> >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stderr.txt >&2)
#NOTE Weird, got the same error again (see 'Notes, etc.' below)


#  Try running atria again, then running STAR again ---------------------------
cat sh_err_out/err_out/run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.err.txt
cat sh_err_out/err_out/run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.out.txt

cd sh_err_out/err_out
., *Sample_CT2_6125_pIAA_Q_SteadyState*

cat run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280838-47.err.txt
cat run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280838-47.out.txt
#NOTE Nothing obviously unusual about the *.{err,out}.txt files

#  Run atria ------
cd ../../fastqs_UMI-dedup/atria_trim
mkdir bak
., Sample_CT2_6125_pIAA_Q_SteadyState_S6*
cat Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log
mv Sample_CT2_6125_pIAA_Q_SteadyState_S6* bak/

../..
con-deact
source activate atria_env
module purge

/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria \
    -t "${SLURM_CPUS_ON_NODE}" \
    -r ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz \
    -R ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz \
    -o ./fastqs_UMI-dedup/atria_trim \
    --no-length-filtration \
    --stats

# Save the atria stdout to a file in sh_err_out/err_out (do it by hand)
vi sh_err_out/err_out/rerun_atria.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stdout.txt

#  Run STAR -------
con-deact
source activate Trinity_env
module purge

STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes All \
    --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR \
    --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 10 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000 \
        >> >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stdout.txt) \
        2>> >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stderr.txt >&2)
#NOTE It worked! Let's move on...


#  Clean things up ------------------------------------------------------------
transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

mv \
    ./fastqs_UMI-dedup/atria_trim/bak \
    ./fastqs_UMI-dedup/atria_trim/problem
mv \
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/bak \
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/problem

cd ./bams_UMI-dedup/aligned_umi-extracted_trimmed
rename -n 's/Aligned.sortedByCoord.out//g' CT2_6125_pIAA_Q_SteadyState_UT*
rename -n 's/Log/.Log/g; s/SJ/.SJ/g' CT2_6125_pIAA_Q_SteadyState_UT*
rename 's/Aligned.sortedByCoord.out//g' CT2_6125_pIAA_Q_SteadyState_UT*
rename 's/Log/.Log/g; s/SJ/.SJ/g' CT2_6125_pIAA_Q_SteadyState_UT*
rm -r CT2_6125_pIAA_Q_SteadyState_UT*_STARtmp/
.,

cd ../../fastqs_UMI-dedup/atria_trim
.,f
#NOTE Everything looks OK


#  Move on --------------------------------------------------------------------
transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }
```
</details>
<br />

<a id="notes-etc"></a>
###### Notes, etc.
<details>
<summary><i>Notes, etc.: Troubleshooting the problem with CT2_6125_pIAA_Q_SteadyState_UT</i></summary>

Digging into things because the alignment job for `CT2_6125_pIAA_Q_SteadyState_UT`  appears to have failed
```txt
., *.bam
-rw-rw---- 1 kalavatt 2.1G Feb  8 15:07 5781_G1_IN_UT.bam
-rw-rw---- 1 kalavatt 2.2G Feb  8 15:11 5781_G1_IP_UT.bam
-rw-rw---- 1 kalavatt 1.8G Feb  8 15:11 5781_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 2.4G Feb  8 15:14 5781_Q_IP_UT.bam
-rw-rw---- 1 kalavatt 1.8G Feb  8 15:13 5782_G1_IN_UT.bam
-rw-rw---- 1 kalavatt 2.2G Feb  8 15:14 5782_G1_IP_UT.bam
-rw-rw---- 1 kalavatt 1.5G Feb  8 15:14 5782_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 2.2G Feb  8 15:17 5782_Q_IP_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 15:40 BM10_DSp48_5781_UT.bam
-rw-rw---- 1 kalavatt 2.5G Feb  8 15:41 BM11_DSp48_7080_UT.bam
-rw-rw---- 1 kalavatt 2.5G Feb  8 15:43 BM1_DSm2_5781_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 15:43 BM2_DSm2_7080_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 15:44 BM3_DSm2_7079_UT.bam
-rw-rw---- 1 kalavatt 2.4G Feb  8 15:44 BM4_DSp2_5781_UT.bam
-rw-rw---- 1 kalavatt 3.1G Feb  8 15:47 BM5_DSp2_7080_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 15:48 BM6_DSp2_7079_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 15:47 BM7_DSp24_5781_UT.bam
-rw-rw---- 1 kalavatt 2.8G Feb  8 15:48 BM8_DSp24_7080_UT.bam
-rw-rw---- 1 kalavatt 2.6G Feb  8 15:50 BM9_DSp24_7079_UT.bam
-rw-rw---- 1 kalavatt 2.4G Feb  8 15:51 Bp10_DSp48_5782_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 15:52 Bp11_DSp48_7081_UT.bam
-rw-rw---- 1 kalavatt 2.9G Feb  8 15:53 Bp12_DSp48_7078_UT.bam
-rw-rw---- 1 kalavatt 2.1G Feb  8 15:52 Bp1_DSm2_5782_UT.bam
-rw-rw---- 1 kalavatt 2.5G Feb  8 15:54 Bp2_DSm2_7081_UT.bam
-rw-rw---- 1 kalavatt 2.1G Feb  8 15:55 Bp3_DSm2_7078_UT.bam
-rw-rw---- 1 kalavatt 2.8G Feb  8 15:57 Bp4_DSp2_5782_UT.bam
-rw-rw---- 1 kalavatt 3.0G Feb  8 15:58 Bp5_DSp2_7081_UT.bam
-rw-rw---- 1 kalavatt 2.6G Feb  8 15:58 Bp6_DSp2_7078_UT.bam
-rw-rw---- 1 kalavatt 2.7G Feb  8 16:00 Bp7_DSp24_5782_UT.bam
-rw-rw---- 1 kalavatt 2.8G Feb  8 16:04 Bp8_DSp24_7081_UT.bam
-rw-rw---- 1 kalavatt 2.2G Feb  8 16:01 Bp9_DSp24_7078_UT.bam
-rw-rw---- 1 kalavatt 4.1G Feb  8 16:08 CT10_7718_pIAA_Q_Nascent_UT.bam
-rw-rw---- 1 kalavatt 4.0G Feb  8 16:08 CT10_7718_pIAA_Q_SteadyState_UT.bam
-rw-rw---- 1 kalavatt 3.9G Feb  8 16:09 CT2_6125_pIAA_Q_Nascent_UT.bam
-rw-rw---- 1 kalavatt    0 Feb  8 16:06 CT2_6125_pIAA_Q_SteadyState_UT.bam
-rw-rw---- 1 kalavatt 3.9G Feb  8 16:15 CT4_6126_pIAA_Q_Nascent_UT.bam
-rw-rw---- 1 kalavatt 4.3G Feb  8 16:15 CT4_6126_pIAA_Q_SteadyState_UT.bam
-rw-rw---- 1 kalavatt 4.6G Feb  8 16:18 CT6_7714_pIAA_Q_Nascent_UT.bam
-rw-rw---- 1 kalavatt 3.4G Feb  8 16:21 CT6_7714_pIAA_Q_SteadyState_UT.bam
-rw-rw---- 1 kalavatt 4.0G Feb  8 16:27 CT8_7716_pIAA_Q_Nascent_UT.bam
-rw-rw---- 1 kalavatt 3.9G Feb  8 16:23 CT8_7716_pIAA_Q_SteadyState_UT.bam
-rw-rw---- 1 kalavatt 4.0G Feb  8 16:25 CU11_5782_Q_Nascent_UT.bam
-rw-rw---- 1 kalavatt 3.8G Feb  8 16:28 CU12_5782_Q_SteadyState_UT.bam
-rw-rw---- 1 kalavatt 4.1G Feb  8 15:25 CW10_7747_8day_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 3.7G Feb  8 15:20 CW10_7747_8day_Q_PD_UT.bam
-rw-rw---- 1 kalavatt 3.6G Feb  8 15:24 CW12_7748_8day_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 4.0G Feb  8 15:25 CW12_7748_8day_Q_PD_UT.bam
-rw-rw---- 1 kalavatt 4.0G Feb  8 15:26 CW2_5781_8day_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 3.8G Feb  8 15:31 CW2_5781_8day_Q_PD_UT.bam
-rw-rw---- 1 kalavatt 3.8G Feb  8 15:35 CW4_5782_8day_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 3.9G Feb  8 15:33 CW4_5782_8day_Q_PD_UT.bam
-rw-rw---- 1 kalavatt 6.4G Feb  8 15:34 CW6_7078_8day_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 3.9G Feb  8 15:37 CW6_7078_8day_Q_PD_UT.bam
-rw-rw---- 1 kalavatt 4.1G Feb  8 15:40 CW8_7079_8day_Q_IN_UT.bam
-rw-rw---- 1 kalavatt 3.8G Feb  8 15:40 CW8_7079_8day_Q_PD_UT.


❯ cat run_STAR.CT2_6125_pIAA_Q_SteadyState_UT.9897387-47.err.txt
gzip: ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz: unexpected end of file

EXITING because of FATAL ERROR in reads input: quality string length is not equal to sequence length
@VH01189:9:AAC57JMM5:1:2611:18894:53950_ATAGTACT
CGCTCTCATCCATCAGTAACAAGGAATCATCAAAGTAGCCCGAAGCGTCG
;CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;CCCCCCCCCCC;C
SOLUTION: fix your fastq file

Feb 08 16:15:44 ...... FATAL ERROR, exiting
srun: error: gizmok10: task 0: Exited with exit code 1


❯ cat run_STAR.CT2_6125_pIAA_Q_SteadyState_UT.9897387-47.out.txt
STAR --runMode alignReads --runThreadN 8 --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes All --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz --readFilesCommand zcat --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT --limitBAMsortRAM 4000000000 --outFilterMultimapNmax 10 --winAnchorMultimapNmax 1000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outMultimapperOrder Random --alignEndsType EndToEnd --alignIntronMin 4 --alignIntronMax 5000 --alignMatesGapMax 5000

    STAR --runMode alignReads --runThreadN 8 --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes All --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz --readFilesCommand zcat --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT --limitBAMsortRAM 4000000000 --outFilterMultimapNmax 10 --winAnchorMultimapNmax 1000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outMultimapperOrder Random --alignEndsType EndToEnd --alignIntronMin 4 --alignIntronMax 5000 --alignMatesGapMax 5000
    STAR version: 2.7.10b   compiled: 2022-11-01T09:53:26-04:00 :/home/dobin/data/STAR/STARcode/STAR.master/source
Feb 08 16:06:48 ..... started STAR run
Feb 08 16:06:49 ..... loading genome
Feb 08 16:06:49 ..... started mapping


❯ zgrep -B 1 -A 4 \
>    "^@VH01189:9:AAC57JMM5:1:2611:18894:53950_ATAGTACT" \
>    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz

gzip: ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz: unexpected end of file
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
@VH01189:9:AAC57JMM5:1:2611:18894:53950_ATAGTACT 3:N:0:CGACCTAA+CAGGTTAG
CGCTCTCATCCATCAGTAACAAGGAATCATCAAAGTAGCCCGAAGCGTCG
+
;CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;CCCCCCCCCCC;CC


❯ zcat \
>    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
>        | tail

gzip: ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz: unexpected end of file
+
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
@VH01189:9:AAC57JMM5:1:2611:18250:53950_CTCCAGAT 3:N:0:CGACCTAA+CAGGTTAG
CTTAGGACATCTGCGTTATCGTTTTACAAATGTGCCGCCCCAGCCAAACT
+
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
@VH01189:9:AAC57JMM5:1:2611:18894:53950_ATAGTACT 3:N:0:CGACCTAA+CAGGTTAG
CGCTCTCATCCATCAGTAACAAGGAATCATCAAAGTAGCCCGAAGCGTCG
+
;CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;CCCCCCCCCCC;CC


❯ zcat \
>    ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz \
>        | tail

gzip: ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz: unexpected end of file
@VH01189:9:AAC57JMM5:1:2611:39742:56203_TACTTCGT 1:N:0:CGACCTAA+CAGGTTAG
GTTTGAGGCAATAACAGGTCTGTGATGCCCTTAGACGTTCTGGGCCGCAC
+
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
@VH01189:9:AAC57JMM5:1:2611:40613:56203_CCAGTGAA 1:N:0:CGACCTAA+CAGGTTAG
TTCCTTGCGAATCGTCGCCAGTAGACTGGCGAAGGTCCGGAAGGACTTGG
+
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
@VH01189:9:AAC57JMM5:1:2611:40878:56203_GTCGTAGT 1:N:0:CGACCTAA+CAGGTTAG
CTGGTCTTCGGGCCTGTACTGGCCCTCAGCACTTAGTCTACCCTGACGGT


❯ mkdir -p ./bams_UMI-dedup/aligned_umi-extracted_trimmed/bak
mkdir: created directory './bams_UMI-dedup/aligned_umi-extracted_trimmed/bak'


❯ mv \
>    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT* \
>    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/bak
renamed './bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT.bam' -> './bams_UMI-dedup/aligned_umi-extracted_trimmed/bak/CT2_6125_pIAA_Q_SteadyState_UT.bam'
renamed './bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT.Log.out' -> './bams_UMI-dedup/aligned_umi-extracted_trimmed/bak/CT2_6125_pIAA_Q_SteadyState_UT.Log.out'
renamed './bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT.Log.progress.out' -> './bams_UMI-dedup/aligned_umi-extracted_trimmed/bak/CT2_6125_pIAA_Q_SteadyState_UT.Log.progress.out'


❯ echo "${SLURM_CPUS_ON_NODE}"
16


❯ STAR \
>    --runMode alignReads \
>    --runThreadN "${SLURM_CPUS_ON_NODE}" \
>    --outSAMtype BAM SortedByCoordinate \
>    --outSAMunmapped Within \
>    --outSAMattributes All \
>    --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR \
>    --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
>    --readFilesCommand zcat \
>    --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT \
>    --limitBAMsortRAM 4000000000 \
>    --outFilterMultimapNmax 10 \
>    --winAnchorMultimapNmax 1000 \
>    --alignSJoverhangMin 8 \
>    --alignSJDBoverhangMin 1 \
>    --outFilterMismatchNmax 999 \
>    --outMultimapperOrder Random \
>    --alignEndsType EndToEnd \
>    --alignIntronMin 4 \
>    --alignIntronMax 5000 \
>    --alignMatesGapMax 5000 \
>        > >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stdout.txt) \
>        2> >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stderr.txt >&2)
    STAR --runMode alignReads --runThreadN 16 --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes All --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz --readFilesCommand zcat --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT --limitBAMsortRAM 4000000000 --outFilterMultimapNmax 10 --winAnchorMultimapNmax 1000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outMultimapperOrder Random --alignEndsType EndToEnd --alignIntronMin 4 --alignIntronMax 5000 --alignMatesGapMax 5000
    STAR version: 2.7.10b   compiled: 2022-11-01T09:53:26-04:00 :/home/dobin/data/STAR/STARcode/STAR.master/source
Feb 13 08:07:01 ..... started STAR run
Feb 13 08:07:01 ..... loading genome
Feb 13 08:07:05 ..... started mapping

gzip: ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz: unexpected end of file

EXITING because of FATAL ERROR in reads input: quality string length is not equal to sequence length
@VH01189:9:AAC57JMM5:1:2611:18894:53950_ATAGTACT
CGCTCTCATCCATCAGTAACAAGGAATCATCAAAGTAGCCCGAAGCGTCG
;CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;CCCCCCCCCCC;C
SOLUTION: fix your fastq file

Feb 13 08:09:34 ...... FATAL ERROR, exiting


❯ cat sh_err_out/err_out/run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.err.txt
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-t 8 -r ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz -R ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz -o ./fastqs_UMI-dedup/atria_trim --no-length-filtration --stats`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz"
└   read2 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = false
[ Info: Cycle 1: read 379697/379697 pairs; wrote 379697/379697 pairs; (copied 0/0 reads)
[ Info: Cycle 2: read 379460/759157 pairs; wrote 379460/759157 pairs; (copied 0/0 reads)
[ Info: Cycle 3: read 379467/1138624 pairs; wrote 379467/1138624 pairs; (copied 0/0 reads)
[ Info: Cycle 4: read 379467/1518091 pairs; wrote 379467/1518091 pairs; (copied 0/0 reads)
[ Info: Cycle 5: read 379455/1897546 pairs; wrote 379455/1897546 pairs; (copied 0/0 reads)
[ Info: Cycle 6: read 379564/2277110 pairs; wrote 379564/2277110 pairs; (copied 0/0 reads)
[ Info: Cycle 7: read 379597/2656707 pairs; wrote 379597/2656707 pairs; (copied 0/0 reads)
[ Info: Cycle 8: read 379466/3036173 pairs; wrote 379466/3036173 pairs; (copied 0/0 reads)
[ Info: Cycle 9: read 379467/3415640 pairs; wrote 379467/3415640 pairs; (copied 0/0 reads)
[ Info: Cycle 10: read 379465/3795105 pairs; wrote 379465/3795105 pairs; (copied 0/0 reads)
[ Info: Cycle 11: read 379450/4174555 pairs; wrote 379450/4174555 pairs; (copied 0/0 reads)
[ Info: Cycle 12: read 379661/4554216 pairs; wrote 379661/4554216 pairs; (copied 0/0 reads)
[ Info: Cycle 13: read 379501/4933717 pairs; wrote 379501/4933717 pairs; (copied 0/0 reads)
[ Info: Cycle 14: read 379468/5313185 pairs; wrote 379468/5313185 pairs; (copied 0/0 reads)
[ Info: Cycle 15: read 379471/5692656 pairs; wrote 379471/5692656 pairs; (copied 0/0 reads)
[ Info: Cycle 16: read 379450/6072106 pairs; wrote 379450/6072106 pairs; (copied 0/0 reads)
[ Info: Cycle 17: read 379509/6451615 pairs; wrote 379509/6451615 pairs; (copied 0/0 reads)
[ Info: Cycle 18: read 379655/6831270 pairs; wrote 379655/6831270 pairs; (copied 0/0 reads)
[ Info: Cycle 19: read 379464/7210734 pairs; wrote 379464/7210734 pairs; (copied 0/0 reads)
[ Info: Cycle 20: read 379470/7590204 pairs; wrote 379470/7590204 pairs; (copied 0/0 reads)
[ Info: Cycle 21: read 379468/7969672 pairs; wrote 379468/7969672 pairs; (copied 0/0 reads)
[ Info: Cycle 22: read 379458/8349130 pairs; wrote 379458/8349130 pairs; (copied 0/0 reads)
[ Info: Cycle 23: read 379612/8728742 pairs; wrote 379612/8728742 pairs; (copied 0/0 reads)
[ Info: Cycle 24: read 379548/9108290 pairs; wrote 379548/9108290 pairs; (copied 0/0 reads)
[ Info: Cycle 25: read 379465/9487755 pairs; wrote 379465/9487755 pairs; (copied 0/0 reads)
[ Info: Cycle 26: read 379468/9867223 pairs; wrote 379468/9867223 pairs; (copied 0/0 reads)
[ Info: Cycle 27: read 379466/10246689 pairs; wrote 379466/10246689 pairs; (copied 0/0 reads)
[ Info: Cycle 28: read 379456/10626145 pairs; wrote 379456/10626145 pairs; (copied 0/0 reads)
[ Info: Cycle 29: read 379655/11005800 pairs; wrote 379655/11005800 pairs; (copied 0/0 reads)
[ Info: Cycle 30: read 379517/11385317 pairs; wrote 379517/11385317 pairs; (copied 0/0 reads)
[ Info: Cycle 31: read 379470/11764787 pairs; wrote 379470/11764787 pairs; (copied 0/0 reads)
[ Info: Cycle 32: read 379475/12144262 pairs; wrote 379475/12144262 pairs; (copied 0/0 reads)
[ Info: Cycle 33: read 379467/12523729 pairs; wrote 379467/12523729 pairs; (copied 0/0 reads)
[ Info: Cycle 34: read 379458/12903187 pairs; wrote 379458/12903187 pairs; (copied 0/0 reads)
[ Info: Cycle 35: read 379665/13282852 pairs; wrote 379665/13282852 pairs; (copied 0/0 reads)
[ Info: Cycle 36: read 379506/13662358 pairs; wrote 379506/13662358 pairs; (copied 0/0 reads)
[ Info: Cycle 37: read 379474/14041832 pairs; wrote 379474/14041832 pairs; (copied 0/0 reads)
[ Info: Cycle 38: read 379476/14421308 pairs; wrote 379476/14421308 pairs; (copied 0/0 reads)
[ Info: Cycle 39: read 379467/14800775 pairs; wrote 379467/14800775 pairs; (copied 0/0 reads)
[ Info: Cycle 40: read 379460/15180235 pairs; wrote 379460/15180235 pairs; (copied 0/0 reads)
[ Info: Cycle 41: read 379589/15559824 pairs; wrote 379589/15559824 pairs; (copied 0/0 reads)
[ Info: Cycle 42: read 379572/15939396 pairs; wrote 379572/15939396 pairs; (copied 0/0 reads)
[ Info: Cycle 43: read 379467/16318863 pairs; wrote 379467/16318863 pairs; (copied 0/0 reads)
[ Info: Cycle 44: read 379473/16698336 pairs; wrote 379473/16698336 pairs; (copied 0/0 reads)
[ Info: Cycle 45: read 379469/17077805 pairs; wrote 379469/17077805 pairs; (copied 0/0 reads)
[ Info: Cycle 46: read 379453/17457258 pairs; wrote 379453/17457258 pairs; (copied 0/0 reads)
[ Info: Cycle 47: read 379644/17836902 pairs; wrote 379644/17836902 pairs; (copied 0/0 reads)
[ Info: Cycle 48: read 379527/18216429 pairs; wrote 379527/18216429 pairs; (copied 0/0 reads)
[ Info: Cycle 49: read 379473/18595902 pairs; wrote 379473/18595902 pairs; (copied 0/0 reads)
[ Info: Cycle 50: read 379475/18975377 pairs; wrote 379475/18975377 pairs; (copied 0/0 reads)
[ Info: Cycle 51: read 379468/19354845 pairs; wrote 379468/19354845 pairs; (copied 0/0 reads)
[ Info: Cycle 52: read 379456/19734301 pairs; wrote 379456/19734301 pairs; (copied 0/0 reads)
[ Info: Cycle 53: read 379629/20113930 pairs; wrote 379629/20113930 pairs; (copied 0/0 reads)
[ Info: Cycle 54: read 379536/20493466 pairs; wrote 379536/20493466 pairs; (copied 0/0 reads)
[ Info: Cycle 55: read 379467/20872933 pairs; wrote 379467/20872933 pairs; (copied 0/0 reads)
[ Info: Cycle 56: read 379473/21252406 pairs; wrote 379473/21252406 pairs; (copied 0/0 reads)
[ Info: Cycle 57: read 379461/21631867 pairs; wrote 379461/21631867 pairs; (copied 0/0 reads)
[ Info: Cycle 58: read 379447/22011314 pairs; wrote 379447/22011314 pairs; (copied 0/0 reads)
[ Info: Cycle 59: read 379697/22391011 pairs; wrote 379697/22391011 pairs; (copied 0/0 reads)
[ Info: Cycle 60: read 379460/22770471 pairs; wrote 379460/22770471 pairs; (copied 0/0 reads)
[ Info: Cycle 61: read 379466/23149937 pairs; wrote 379466/23149937 pairs; (copied 0/0 reads)
[ Info: Cycle 62: read 379466/23529403 pairs; wrote 379466/23529403 pairs; (copied 0/0 reads)
[ Info: Cycle 63: read 379452/23908855 pairs; wrote 379452/23908855 pairs; (copied 0/0 reads)
[ Info: Cycle 64: read 379639/24288494 pairs; wrote 379639/24288494 pairs; (copied 0/0 reads)
[ Info: Cycle 65: read 379511/24668005 pairs; wrote 379511/24668005 pairs; (copied 0/0 reads)
[ Info: Cycle 66: read 379466/25047471 pairs; wrote 379466/25047471 pairs; (copied 0/0 reads)
[ Info: Cycle 67: read 379467/25426938 pairs; wrote 379467/25426938 pairs; (copied 0/0 reads)
[ Info: Cycle 68: read 379456/25806394 pairs; wrote 379456/25806394 pairs; (copied 0/0 reads)
[ Info: Cycle 69: read 379573/26185967 pairs; wrote 379573/26185967 pairs; (copied 0/0 reads)
[ Info: Cycle 70: read 379574/26565541 pairs; wrote 379574/26565541 pairs; (copied 0/0 reads)
[ Info: Cycle 71: read 379465/26945006 pairs; wrote 379465/26945006 pairs; (copied 0/0 reads)
[ Info: Cycle 72: read 379460/27324466 pairs; wrote 379460/27324466 pairs; (copied 0/0 reads)
[ Info: Cycle 73: read 379457/27703923 pairs; wrote 379457/27703923 pairs; (copied 0/0 reads)
[ Info: Cycle 74: read 379576/28083499 pairs; wrote 379576/28083499 pairs; (copied 0/0 reads)
[ Info: Cycle 75: read 379581/28463080 pairs; wrote 379581/28463080 pairs; (copied 0/0 reads)
[ Info: Cycle 76: read 379466/28842546 pairs; wrote 379466/28842546 pairs; (copied 0/0 reads)
[ Info: Cycle 77: read 379470/29222016 pairs; wrote 379470/29222016 pairs; (copied 0/0 reads)
[ Info: Cycle 78: read 379424/29601440 pairs; wrote 379424/29601440 pairs; (copied 0/0 reads)
[ Info: Cycle 79: read 379554/29980994 pairs; wrote 379554/29980994 pairs; (copied 0/0 reads)
[ Info: Cycle 80: read 379602/30360596 pairs; wrote 379602/30360596 pairs; (copied 0/0 reads)
[ Info: Cycle 81: read 379467/30740063 pairs; wrote 379467/30740063 pairs; (copied 0/0 reads)
[ Info: Cycle 82: read 379471/31119534 pairs; wrote 379471/31119534 pairs; (copied 0/0 reads)
[ Info: Cycle 83: read 379465/31498999 pairs; wrote 379465/31498999 pairs; (copied 0/0 reads)
[ Info: Cycle 84: read 379456/31878455 pairs; wrote 379456/31878455 pairs; (copied 0/0 reads)
[ Info: Cycle 85: read 379705/32258160 pairs; wrote 379705/32258160 pairs; (copied 0/0 reads)
[ Info: Cycle 86: read 379465/32637625 pairs; wrote 379465/32637625 pairs; (copied 0/0 reads)
[ Info: Cycle 87: read 379477/33017102 pairs; wrote 379477/33017102 pairs; (copied 0/0 reads)
[ Info: Cycle 88: read 379447/33396549 pairs; wrote 379447/33396549 pairs; (copied 0/0 reads)
[ Info: Cycle 89: read 379453/33776002 pairs; wrote 379453/33776002 pairs; (copied 0/0 reads)
[ Info: Cycle 90: read 379714/34155716 pairs; wrote 379714/34155716 pairs; (copied 0/0 reads)
[ Info: Cycle 91: read 379463/34535179 pairs; wrote 379463/34535179 pairs; (copied 0/0 reads)
[ Info: Cycle 92: read 379473/34914652 pairs; wrote 379473/34914652 pairs; (copied 0/0 reads)
[ Info: Cycle 93: read 379475/35294127 pairs; wrote 379475/35294127 pairs; (copied 0/0 reads)
[ Info: Cycle 94: read 379462/35673589 pairs; wrote 379462/35673589 pairs; (copied 0/0 reads)
[ Info: Cycle 95: read 379474/36053063 pairs; wrote 379474/36053063 pairs; (copied 0/0 reads)
[ Info: Cycle 96: read 379690/36432753 pairs; wrote 379690/36432753 pairs; (copied 0/0 reads)
[ Info: Cycle 97: read 379465/36812218 pairs; wrote 379465/36812218 pairs; (copied 0/0 reads)
[ Info: Cycle 98: read 379472/37191690 pairs; wrote 379472/37191690 pairs; (copied 0/0 reads)
[ Info: Cycle 99: read 379469/37571159 pairs; wrote 379469/37571159 pairs; (copied 0/0 reads)
[ Info: Cycle 100: read 379454/37950613 pairs; wrote 379454/37950613 pairs; (copied 0/0 reads)
[ Info: Cycle 101: read 379578/38330191 pairs; wrote 379578/38330191 pairs; (copied 0/0 reads)
[ Info: Cycle 102: read 379577/38709768 pairs; wrote 379577/38709768 pairs; (copied 0/0 reads)
[ Info: Cycle 103: read 379471/39089239 pairs; wrote 379471/39089239 pairs; (copied 0/0 reads)
[ Info: Cycle 104: read 379473/39468712 pairs; wrote 379473/39468712 pairs; (copied 0/0 reads)
[ Info: Cycle 105: read 379469/39848181 pairs; wrote 379469/39848181 pairs; (copied 0/0 reads)
[ Info: Cycle 106: read 379451/40227632 pairs; wrote 379451/40227632 pairs; (copied 0/0 reads)
[ Info: Cycle 107: read 379675/40607307 pairs; wrote 379675/40607307 pairs; (copied 0/0 reads)
[ Info: Cycle 108: read 379489/40986796 pairs; wrote 379489/40986796 pairs; (copied 0/0 reads)
[ Info: Cycle 109: read 379471/41366267 pairs; wrote 379471/41366267 pairs; (copied 0/0 reads)
[ Info: Cycle 110: read 379470/41745737 pairs; wrote 379470/41745737 pairs; (copied 0/0 reads)
[ Info: Cycle 111: read 379460/42125197 pairs; wrote 379460/42125197 pairs; (copied 0/0 reads)
[ Info: Cycle 112: read 374644/42499841 pairs; wrote 374644/42499841 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz"
└   read2 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz"


❯ cat sh_err_out/err_out/run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.out.txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria -t 8 -r ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz -R ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz -o ./fastqs_UMI-dedup/atria_trim --no-length-filtration --stats

pigz 2.6


❯ ., *Sample_CT2_6125_pIAA_Q_SteadyState*
-rw-rw---- 1 kalavatt 738 Feb  6 18:26 filter_rCorrector-treated-fastqs.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9431945-47.err.txt
-rw-rw---- 1 kalavatt 11K Feb  6 18:26 filter_rCorrector-treated-fastqs.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9431945-47.out.txt
-rw-rw---- 1 kalavatt   0 Feb  5 17:06 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9281731-47.err.txt
-rw-rw---- 1 kalavatt 279 Feb  5 17:06 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9281731-47.out.txt
-rw-rw---- 1 kalavatt 12K Feb  5 17:53 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9282279-47.err.txt
-rw-rw---- 1 kalavatt 357 Feb  5 17:53 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9282279-47.out.txt
-rw-rw---- 1 kalavatt 12K Feb  6 07:37 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.err.txt
-rw-rw---- 1 kalavatt 365 Feb  6 07:37 run_atria_trim.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9294591-47.out.txt
-rw-rw---- 1 kalavatt   0 Feb  5 14:08 run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280714-47.err.txt
-rw-rw---- 1 kalavatt 671 Feb  5 14:08 run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280714-47.out.txt
-rw-rw---- 1 kalavatt   0 Feb  5 16:08 run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280838-47.err.txt
-rw-rw---- 1 kalavatt 49K Feb  5 16:38 run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280838-47.out.txt


❯ cat run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280838-47.err.txt


❯ cat run_umi-tools_extract.Sample_CT2_6125_pIAA_Q_SteadyState_S6.9280838-47.out.txt
umi_tools extract --bc-pattern=NNNNNNNN --stdin=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz --read2-in=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz --stdout=./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz --read2-stdout

umi_tools extract --bc-pattern=NNNNNNNN --stdin=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz --read2-in=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz --stdout=./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz --read2-stdout
# UMI-tools version: 1.0.1
# output generated by extract --bc-pattern=NNNNNNNN --stdin=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz --read2-in=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz --stdout=./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz --read2-stdout
# job started at Sun Feb  5 16:08:03 2023 on gizmok134 -- 34292c86-cfea-44e8-8075-2c79b3abebe8
# pid: 30915, system: Linux 4.15.0-192-generic #203-Ubuntu SMP Wed Aug 10 17:40:03 UTC 2022 x86_64
# blacklist                               : None
# compresslevel                           : 6
# either_read                             : False
# either_read_resolve                     : discard
# error_correct_cell                      : False
# extract_method                          : string
# filter_cell_barcode                     : None
# filter_cell_barcodes                    : False
# log2stderr                              : False
# loglevel                                : 1
# pattern                                 : NNNNNNNN
# pattern2                                : None
# prime3                                  : None
# quality_encoding                        : None
# quality_filter_mask                     : None
# quality_filter_threshold                : None
# random_seed                             : None
# read2_in                                : ./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
# read2_out                               : False
# read2_stdout                            : True
# reads_subset                            : None
# reconcile                               : False
# retain_umi                              : None
# short_help                              : None
# stderr                                  : <_io.TextIOWrapper name='<stderr>' mode='w' encoding='UTF-8'>
# stdin                                   : <_io.TextIOWrapper name='./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz' encoding='ascii'>
# stdlog                                  : <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
# stdout                                  : <_io.TextIOWrapper name='./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz' encoding='ascii'>
# timeit_file                             : None
# timeit_header                           : None
# timeit_name                             : all
# tmpdir                                  : None
# whitelist                               : None
2023-02-05 16:08:03,386 INFO Starting barcode extraction
2023-02-05 16:08:06,132 INFO Parsed 100000 reads
2023-02-05 16:08:08,295 INFO Parsed 200000 reads
2023-02-05 16:08:10,460 INFO Parsed 300000 reads
2023-02-05 16:08:12,631 INFO Parsed 400000 reads
2023-02-05 16:08:14,798 INFO Parsed 500000 reads
2023-02-05 16:08:16,965 INFO Parsed 600000 reads
2023-02-05 16:08:19,140 INFO Parsed 700000 reads
2023-02-05 16:08:21,309 INFO Parsed 800000 reads
2023-02-05 16:08:23,480 INFO Parsed 900000 reads
2023-02-05 16:08:25,656 INFO Parsed 1000000 reads
2023-02-05 16:08:27,821 INFO Parsed 1100000 reads
2023-02-05 16:08:29,986 INFO Parsed 1200000 reads
2023-02-05 16:08:32,156 INFO Parsed 1300000 reads
2023-02-05 16:08:34,321 INFO Parsed 1400000 reads
2023-02-05 16:08:36,481 INFO Parsed 1500000 reads
2023-02-05 16:08:38,647 INFO Parsed 1600000 reads
2023-02-05 16:08:40,871 INFO Parsed 1700000 reads
2023-02-05 16:08:43,031 INFO Parsed 1800000 reads
2023-02-05 16:08:45,194 INFO Parsed 1900000 reads
2023-02-05 16:08:47,367 INFO Parsed 2000000 reads
2023-02-05 16:08:49,532 INFO Parsed 2100000 reads
2023-02-05 16:08:51,696 INFO Parsed 2200000 reads
2023-02-05 16:08:53,866 INFO Parsed 2300000 reads
2023-02-05 16:08:56,030 INFO Parsed 2400000 reads
2023-02-05 16:08:58,195 INFO Parsed 2500000 reads
2023-02-05 16:09:00,368 INFO Parsed 2600000 reads
2023-02-05 16:09:02,529 INFO Parsed 2700000 reads
2023-02-05 16:09:04,691 INFO Parsed 2800000 reads
2023-02-05 16:09:06,858 INFO Parsed 2900000 reads
2023-02-05 16:09:09,030 INFO Parsed 3000000 reads
2023-02-05 16:09:11,440 INFO Parsed 3100000 reads
2023-02-05 16:09:13,607 INFO Parsed 3200000 reads
2023-02-05 16:09:15,787 INFO Parsed 3300000 reads
2023-02-05 16:09:17,961 INFO Parsed 3400000 reads
2023-02-05 16:09:20,135 INFO Parsed 3500000 reads
2023-02-05 16:09:22,312 INFO Parsed 3600000 reads
2023-02-05 16:09:24,488 INFO Parsed 3700000 reads
2023-02-05 16:09:26,772 INFO Parsed 3800000 reads
2023-02-05 16:09:28,964 INFO Parsed 3900000 reads
2023-02-05 16:09:31,147 INFO Parsed 4000000 reads
2023-02-05 16:09:33,322 INFO Parsed 4100000 reads
2023-02-05 16:09:35,510 INFO Parsed 4200000 reads
2023-02-05 16:09:37,682 INFO Parsed 4300000 reads
2023-02-05 16:09:39,851 INFO Parsed 4400000 reads
2023-02-05 16:09:42,209 INFO Parsed 4500000 reads
2023-02-05 16:09:44,392 INFO Parsed 4600000 reads
2023-02-05 16:09:46,563 INFO Parsed 4700000 reads
2023-02-05 16:09:48,741 INFO Parsed 4800000 reads
2023-02-05 16:09:50,936 INFO Parsed 4900000 reads
2023-02-05 16:09:53,102 INFO Parsed 5000000 reads
2023-02-05 16:09:55,276 INFO Parsed 5100000 reads
2023-02-05 16:09:57,716 INFO Parsed 5200000 reads
2023-02-05 16:09:59,892 INFO Parsed 5300000 reads
2023-02-05 16:10:02,071 INFO Parsed 5400000 reads
2023-02-05 16:10:04,255 INFO Parsed 5500000 reads
2023-02-05 16:10:06,423 INFO Parsed 5600000 reads
2023-02-05 16:10:08,586 INFO Parsed 5700000 reads
2023-02-05 16:10:10,761 INFO Parsed 5800000 reads
2023-02-05 16:10:13,201 INFO Parsed 5900000 reads
2023-02-05 16:10:15,421 INFO Parsed 6000000 reads
2023-02-05 16:10:17,648 INFO Parsed 6100000 reads
2023-02-05 16:10:19,844 INFO Parsed 6200000 reads
2023-02-05 16:10:22,009 INFO Parsed 6300000 reads
2023-02-05 16:10:24,176 INFO Parsed 6400000 reads
2023-02-05 16:10:26,349 INFO Parsed 6500000 reads
2023-02-05 16:10:28,615 INFO Parsed 6600000 reads
2023-02-05 16:10:30,787 INFO Parsed 6700000 reads
2023-02-05 16:10:32,972 INFO Parsed 6800000 reads
2023-02-05 16:10:35,149 INFO Parsed 6900000 reads
2023-02-05 16:10:37,319 INFO Parsed 7000000 reads
2023-02-05 16:10:39,505 INFO Parsed 7100000 reads
2023-02-05 16:10:41,670 INFO Parsed 7200000 reads
2023-02-05 16:10:44,068 INFO Parsed 7300000 reads
2023-02-05 16:10:46,243 INFO Parsed 7400000 reads
2023-02-05 16:10:48,422 INFO Parsed 7500000 reads
2023-02-05 16:10:50,588 INFO Parsed 7600000 reads
2023-02-05 16:10:52,761 INFO Parsed 7700000 reads
2023-02-05 16:10:54,937 INFO Parsed 7800000 reads
2023-02-05 16:10:57,104 INFO Parsed 7900000 reads
2023-02-05 16:10:59,272 INFO Parsed 8000000 reads
2023-02-05 16:11:01,448 INFO Parsed 8100000 reads
2023-02-05 16:11:03,614 INFO Parsed 8200000 reads
2023-02-05 16:11:05,786 INFO Parsed 8300000 reads
2023-02-05 16:11:07,964 INFO Parsed 8400000 reads
2023-02-05 16:11:10,132 INFO Parsed 8500000 reads
2023-02-05 16:11:12,297 INFO Parsed 8600000 reads
2023-02-05 16:11:14,477 INFO Parsed 8700000 reads
2023-02-05 16:11:16,658 INFO Parsed 8800000 reads
2023-02-05 16:11:18,826 INFO Parsed 8900000 reads
2023-02-05 16:11:21,003 INFO Parsed 9000000 reads
2023-02-05 16:11:23,177 INFO Parsed 9100000 reads
2023-02-05 16:11:25,341 INFO Parsed 9200000 reads
2023-02-05 16:11:27,513 INFO Parsed 9300000 reads
2023-02-05 16:11:29,836 INFO Parsed 9400000 reads
2023-02-05 16:11:32,007 INFO Parsed 9500000 reads
2023-02-05 16:11:34,180 INFO Parsed 9600000 reads
2023-02-05 16:11:36,365 INFO Parsed 9700000 reads
2023-02-05 16:11:38,535 INFO Parsed 9800000 reads
2023-02-05 16:11:40,705 INFO Parsed 9900000 reads
2023-02-05 16:11:42,889 INFO Parsed 10000000 reads
2023-02-05 16:11:45,075 INFO Parsed 10100000 reads
2023-02-05 16:11:47,253 INFO Parsed 10200000 reads
2023-02-05 16:11:49,435 INFO Parsed 10300000 reads
2023-02-05 16:11:51,617 INFO Parsed 10400000 reads
2023-02-05 16:11:53,787 INFO Parsed 10500000 reads
2023-02-05 16:11:55,962 INFO Parsed 10600000 reads
2023-02-05 16:11:58,134 INFO Parsed 10700000 reads
2023-02-05 16:12:00,298 INFO Parsed 10800000 reads
2023-02-05 16:12:02,465 INFO Parsed 10900000 reads
2023-02-05 16:12:04,641 INFO Parsed 11000000 reads
2023-02-05 16:12:06,806 INFO Parsed 11100000 reads
2023-02-05 16:12:08,979 INFO Parsed 11200000 reads
2023-02-05 16:12:11,166 INFO Parsed 11300000 reads
2023-02-05 16:12:13,327 INFO Parsed 11400000 reads
2023-02-05 16:12:15,491 INFO Parsed 11500000 reads
2023-02-05 16:12:17,669 INFO Parsed 11600000 reads
2023-02-05 16:12:19,843 INFO Parsed 11700000 reads
2023-02-05 16:12:22,020 INFO Parsed 11800000 reads
2023-02-05 16:12:24,203 INFO Parsed 11900000 reads
2023-02-05 16:12:26,412 INFO Parsed 12000000 reads
2023-02-05 16:12:28,574 INFO Parsed 12100000 reads
2023-02-05 16:12:30,747 INFO Parsed 12200000 reads
2023-02-05 16:12:32,922 INFO Parsed 12300000 reads
2023-02-05 16:12:35,083 INFO Parsed 12400000 reads
2023-02-05 16:12:37,250 INFO Parsed 12500000 reads
2023-02-05 16:12:39,430 INFO Parsed 12600000 reads
2023-02-05 16:12:41,588 INFO Parsed 12700000 reads
2023-02-05 16:12:43,755 INFO Parsed 12800000 reads
2023-02-05 16:12:45,929 INFO Parsed 12900000 reads
2023-02-05 16:12:48,098 INFO Parsed 13000000 reads
2023-02-05 16:12:50,262 INFO Parsed 13100000 reads
2023-02-05 16:12:52,438 INFO Parsed 13200000 reads
2023-02-05 16:12:54,606 INFO Parsed 13300000 reads
2023-02-05 16:12:56,766 INFO Parsed 13400000 reads
2023-02-05 16:12:58,931 INFO Parsed 13500000 reads
2023-02-05 16:13:01,108 INFO Parsed 13600000 reads
2023-02-05 16:13:03,278 INFO Parsed 13700000 reads
2023-02-05 16:13:05,449 INFO Parsed 13800000 reads
2023-02-05 16:13:07,626 INFO Parsed 13900000 reads
2023-02-05 16:13:09,796 INFO Parsed 14000000 reads
2023-02-05 16:13:11,961 INFO Parsed 14100000 reads
2023-02-05 16:13:14,139 INFO Parsed 14200000 reads
2023-02-05 16:13:16,283 INFO Parsed 14300000 reads
2023-02-05 16:13:18,403 INFO Parsed 14400000 reads
2023-02-05 16:13:20,527 INFO Parsed 14500000 reads
2023-02-05 16:13:22,681 INFO Parsed 14600000 reads
2023-02-05 16:13:24,842 INFO Parsed 14700000 reads
2023-02-05 16:13:27,001 INFO Parsed 14800000 reads
2023-02-05 16:13:29,171 INFO Parsed 14900000 reads
2023-02-05 16:13:31,326 INFO Parsed 15000000 reads
2023-02-05 16:13:33,480 INFO Parsed 15100000 reads
2023-02-05 16:13:35,644 INFO Parsed 15200000 reads
2023-02-05 16:13:37,813 INFO Parsed 15300000 reads
2023-02-05 16:13:39,966 INFO Parsed 15400000 reads
2023-02-05 16:13:42,122 INFO Parsed 15500000 reads
2023-02-05 16:13:44,281 INFO Parsed 15600000 reads
2023-02-05 16:13:46,433 INFO Parsed 15700000 reads
2023-02-05 16:13:48,592 INFO Parsed 15800000 reads
2023-02-05 16:13:50,753 INFO Parsed 15900000 reads
2023-02-05 16:13:52,899 INFO Parsed 16000000 reads
2023-02-05 16:13:55,055 INFO Parsed 16100000 reads
2023-02-05 16:13:57,217 INFO Parsed 16200000 reads
2023-02-05 16:13:59,366 INFO Parsed 16300000 reads
2023-02-05 16:14:01,517 INFO Parsed 16400000 reads
2023-02-05 16:14:03,684 INFO Parsed 16500000 reads
2023-02-05 16:14:05,842 INFO Parsed 16600000 reads
2023-02-05 16:14:07,997 INFO Parsed 16700000 reads
2023-02-05 16:14:10,159 INFO Parsed 16800000 reads
2023-02-05 16:14:12,317 INFO Parsed 16900000 reads
2023-02-05 16:14:14,465 INFO Parsed 17000000 reads
2023-02-05 16:14:16,616 INFO Parsed 17100000 reads
2023-02-05 16:14:18,786 INFO Parsed 17200000 reads
2023-02-05 16:14:20,960 INFO Parsed 17300000 reads
2023-02-05 16:14:23,141 INFO Parsed 17400000 reads
2023-02-05 16:14:25,332 INFO Parsed 17500000 reads
2023-02-05 16:14:27,488 INFO Parsed 17600000 reads
2023-02-05 16:14:29,639 INFO Parsed 17700000 reads
2023-02-05 16:14:31,797 INFO Parsed 17800000 reads
2023-02-05 16:14:33,953 INFO Parsed 17900000 reads
2023-02-05 16:14:36,108 INFO Parsed 18000000 reads
2023-02-05 16:14:38,272 INFO Parsed 18100000 reads
2023-02-05 16:14:40,437 INFO Parsed 18200000 reads
2023-02-05 16:14:42,595 INFO Parsed 18300000 reads
2023-02-05 16:14:44,753 INFO Parsed 18400000 reads
2023-02-05 16:14:46,920 INFO Parsed 18500000 reads
2023-02-05 16:14:49,071 INFO Parsed 18600000 reads
2023-02-05 16:14:51,224 INFO Parsed 18700000 reads
2023-02-05 16:14:53,389 INFO Parsed 18800000 reads
2023-02-05 16:14:55,544 INFO Parsed 18900000 reads
2023-02-05 16:14:57,698 INFO Parsed 19000000 reads
2023-02-05 16:14:59,862 INFO Parsed 19100000 reads
2023-02-05 16:15:02,020 INFO Parsed 19200000 reads
2023-02-05 16:15:04,423 INFO Parsed 19300000 reads
2023-02-05 16:15:06,577 INFO Parsed 19400000 reads
2023-02-05 16:15:08,735 INFO Parsed 19500000 reads
2023-02-05 16:15:10,893 INFO Parsed 19600000 reads
2023-02-05 16:15:13,049 INFO Parsed 19700000 reads
2023-02-05 16:15:15,211 INFO Parsed 19800000 reads
2023-02-05 16:15:17,368 INFO Parsed 19900000 reads
2023-02-05 16:15:19,523 INFO Parsed 20000000 reads
2023-02-05 16:15:21,684 INFO Parsed 20100000 reads
2023-02-05 16:15:23,841 INFO Parsed 20200000 reads
2023-02-05 16:15:25,988 INFO Parsed 20300000 reads
2023-02-05 16:15:28,149 INFO Parsed 20400000 reads
2023-02-05 16:15:30,313 INFO Parsed 20500000 reads
2023-02-05 16:15:32,463 INFO Parsed 20600000 reads
2023-02-05 16:15:34,759 INFO Parsed 20700000 reads
2023-02-05 16:15:36,926 INFO Parsed 20800000 reads
2023-02-05 16:15:39,079 INFO Parsed 20900000 reads
2023-02-05 16:15:41,236 INFO Parsed 21000000 reads
2023-02-05 16:15:43,394 INFO Parsed 21100000 reads
2023-02-05 16:15:45,546 INFO Parsed 21200000 reads
2023-02-05 16:15:47,698 INFO Parsed 21300000 reads
2023-02-05 16:15:49,885 INFO Parsed 21400000 reads
2023-02-05 16:15:52,050 INFO Parsed 21500000 reads
2023-02-05 16:15:54,213 INFO Parsed 21600000 reads
2023-02-05 16:15:56,383 INFO Parsed 21700000 reads
2023-02-05 16:15:58,550 INFO Parsed 21800000 reads
2023-02-05 16:16:00,713 INFO Parsed 21900000 reads
2023-02-05 16:16:02,882 INFO Parsed 22000000 reads
2023-02-05 16:16:05,538 INFO Parsed 22100000 reads
2023-02-05 16:16:07,704 INFO Parsed 22200000 reads
2023-02-05 16:16:09,870 INFO Parsed 22300000 reads
2023-02-05 16:16:12,044 INFO Parsed 22400000 reads
2023-02-05 16:16:14,210 INFO Parsed 22500000 reads
2023-02-05 16:16:16,372 INFO Parsed 22600000 reads
2023-02-05 16:16:18,538 INFO Parsed 22700000 reads
2023-02-05 16:16:20,701 INFO Parsed 22800000 reads
2023-02-05 16:16:22,866 INFO Parsed 22900000 reads
2023-02-05 16:16:25,038 INFO Parsed 23000000 reads
2023-02-05 16:16:27,208 INFO Parsed 23100000 reads
2023-02-05 16:16:29,378 INFO Parsed 23200000 reads
2023-02-05 16:16:31,549 INFO Parsed 23300000 reads
2023-02-05 16:16:33,712 INFO Parsed 23400000 reads
2023-02-05 16:16:35,869 INFO Parsed 23500000 reads
2023-02-05 16:16:38,030 INFO Parsed 23600000 reads
2023-02-05 16:16:40,197 INFO Parsed 23700000 reads
2023-02-05 16:16:42,356 INFO Parsed 23800000 reads
2023-02-05 16:16:44,517 INFO Parsed 23900000 reads
2023-02-05 16:16:46,694 INFO Parsed 24000000 reads
2023-02-05 16:16:48,862 INFO Parsed 24100000 reads
2023-02-05 16:16:51,025 INFO Parsed 24200000 reads
2023-02-05 16:16:53,198 INFO Parsed 24300000 reads
2023-02-05 16:16:55,369 INFO Parsed 24400000 reads
2023-02-05 16:16:57,534 INFO Parsed 24500000 reads
2023-02-05 16:16:59,707 INFO Parsed 24600000 reads
2023-02-05 16:17:01,880 INFO Parsed 24700000 reads
2023-02-05 16:17:04,050 INFO Parsed 24800000 reads
2023-02-05 16:17:06,224 INFO Parsed 24900000 reads
2023-02-05 16:17:08,401 INFO Parsed 25000000 reads
2023-02-05 16:17:10,564 INFO Parsed 25100000 reads
2023-02-05 16:17:12,730 INFO Parsed 25200000 reads
2023-02-05 16:17:14,903 INFO Parsed 25300000 reads
2023-02-05 16:17:17,067 INFO Parsed 25400000 reads
2023-02-05 16:17:19,227 INFO Parsed 25500000 reads
2023-02-05 16:17:21,401 INFO Parsed 25600000 reads
2023-02-05 16:17:23,565 INFO Parsed 25700000 reads
2023-02-05 16:17:25,723 INFO Parsed 25800000 reads
2023-02-05 16:17:27,887 INFO Parsed 25900000 reads
2023-02-05 16:17:30,053 INFO Parsed 26000000 reads
2023-02-05 16:17:32,219 INFO Parsed 26100000 reads
2023-02-05 16:17:34,393 INFO Parsed 26200000 reads
2023-02-05 16:17:36,566 INFO Parsed 26300000 reads
2023-02-05 16:17:38,735 INFO Parsed 26400000 reads
2023-02-05 16:17:40,924 INFO Parsed 26500000 reads
2023-02-05 16:17:43,132 INFO Parsed 26600000 reads
2023-02-05 16:17:45,306 INFO Parsed 26700000 reads
2023-02-05 16:17:47,484 INFO Parsed 26800000 reads
2023-02-05 16:17:49,665 INFO Parsed 26900000 reads
2023-02-05 16:17:51,839 INFO Parsed 27000000 reads
2023-02-05 16:17:54,010 INFO Parsed 27100000 reads
2023-02-05 16:17:56,227 INFO Parsed 27200000 reads
2023-02-05 16:17:58,553 INFO Parsed 27300000 reads
2023-02-05 16:18:00,769 INFO Parsed 27400000 reads
2023-02-05 16:18:02,963 INFO Parsed 27500000 reads
2023-02-05 16:18:05,133 INFO Parsed 27600000 reads
2023-02-05 16:18:07,301 INFO Parsed 27700000 reads
2023-02-05 16:18:09,480 INFO Parsed 27800000 reads
2023-02-05 16:18:11,654 INFO Parsed 27900000 reads
2023-02-05 16:18:13,824 INFO Parsed 28000000 reads
2023-02-05 16:18:16,002 INFO Parsed 28100000 reads
2023-02-05 16:18:18,178 INFO Parsed 28200000 reads
2023-02-05 16:18:20,350 INFO Parsed 28300000 reads
2023-02-05 16:18:22,527 INFO Parsed 28400000 reads
2023-02-05 16:18:24,701 INFO Parsed 28500000 reads
2023-02-05 16:18:26,874 INFO Parsed 28600000 reads
2023-02-05 16:18:29,052 INFO Parsed 28700000 reads
2023-02-05 16:18:31,226 INFO Parsed 28800000 reads
2023-02-05 16:18:33,396 INFO Parsed 28900000 reads
2023-02-05 16:18:35,569 INFO Parsed 29000000 reads
2023-02-05 16:18:37,747 INFO Parsed 29100000 reads
2023-02-05 16:18:39,918 INFO Parsed 29200000 reads
2023-02-05 16:18:42,089 INFO Parsed 29300000 reads
2023-02-05 16:18:44,423 INFO Parsed 29400000 reads
2023-02-05 16:18:46,594 INFO Parsed 29500000 reads
2023-02-05 16:18:48,765 INFO Parsed 29600000 reads
2023-02-05 16:18:50,936 INFO Parsed 29700000 reads
2023-02-05 16:18:53,104 INFO Parsed 29800000 reads
2023-02-05 16:18:55,275 INFO Parsed 29900000 reads
2023-02-05 16:18:57,450 INFO Parsed 30000000 reads
2023-02-05 16:18:59,631 INFO Parsed 30100000 reads
2023-02-05 16:19:01,802 INFO Parsed 30200000 reads
2023-02-05 16:19:04,023 INFO Parsed 30300000 reads
2023-02-05 16:19:06,191 INFO Parsed 30400000 reads
2023-02-05 16:19:08,356 INFO Parsed 30500000 reads
2023-02-05 16:19:10,518 INFO Parsed 30600000 reads
2023-02-05 16:19:12,688 INFO Parsed 30700000 reads
2023-02-05 16:19:14,854 INFO Parsed 30800000 reads
2023-02-05 16:19:17,020 INFO Parsed 30900000 reads
2023-02-05 16:19:19,200 INFO Parsed 31000000 reads
2023-02-05 16:19:21,369 INFO Parsed 31100000 reads
2023-02-05 16:19:23,541 INFO Parsed 31200000 reads
2023-02-05 16:19:25,888 INFO Parsed 31300000 reads
2023-02-05 16:19:28,061 INFO Parsed 31400000 reads
2023-02-05 16:19:30,232 INFO Parsed 31500000 reads
2023-02-05 16:19:32,409 INFO Parsed 31600000 reads
2023-02-05 16:19:34,583 INFO Parsed 31700000 reads
2023-02-05 16:19:36,751 INFO Parsed 31800000 reads
2023-02-05 16:19:38,926 INFO Parsed 31900000 reads
2023-02-05 16:19:41,088 INFO Parsed 32000000 reads
2023-02-05 16:19:43,252 INFO Parsed 32100000 reads
2023-02-05 16:19:45,418 INFO Parsed 32200000 reads
2023-02-05 16:19:47,586 INFO Parsed 32300000 reads
2023-02-05 16:19:49,748 INFO Parsed 32400000 reads
2023-02-05 16:19:51,915 INFO Parsed 32500000 reads
2023-02-05 16:19:54,075 INFO Parsed 32600000 reads
2023-02-05 16:19:56,233 INFO Parsed 32700000 reads
2023-02-05 16:19:58,395 INFO Parsed 32800000 reads
2023-02-05 16:20:00,570 INFO Parsed 32900000 reads
2023-02-05 16:20:02,748 INFO Parsed 33000000 reads
2023-02-05 16:20:04,932 INFO Parsed 33100000 reads
2023-02-05 16:20:07,105 INFO Parsed 33200000 reads
2023-02-05 16:20:09,272 INFO Parsed 33300000 reads
2023-02-05 16:20:11,520 INFO Parsed 33400000 reads
2023-02-05 16:20:13,687 INFO Parsed 33500000 reads
2023-02-05 16:20:15,846 INFO Parsed 33600000 reads
2023-02-05 16:20:18,006 INFO Parsed 33700000 reads
2023-02-05 16:20:20,166 INFO Parsed 33800000 reads
2023-02-05 16:20:22,435 INFO Parsed 33900000 reads
2023-02-05 16:20:24,595 INFO Parsed 34000000 reads
2023-02-05 16:20:26,755 INFO Parsed 34100000 reads
2023-02-05 16:20:28,916 INFO Parsed 34200000 reads
2023-02-05 16:20:31,083 INFO Parsed 34300000 reads
2023-02-05 16:20:33,249 INFO Parsed 34400000 reads
2023-02-05 16:20:35,429 INFO Parsed 34500000 reads
2023-02-05 16:20:37,598 INFO Parsed 34600000 reads
2023-02-05 16:20:39,767 INFO Parsed 34700000 reads
2023-02-05 16:20:41,940 INFO Parsed 34800000 reads
2023-02-05 16:20:44,110 INFO Parsed 34900000 reads
2023-02-05 16:20:46,279 INFO Parsed 35000000 reads
2023-02-05 16:20:48,453 INFO Parsed 35100000 reads
2023-02-05 16:20:50,619 INFO Parsed 35200000 reads
2023-02-05 16:20:52,828 INFO Parsed 35300000 reads
2023-02-05 16:20:54,999 INFO Parsed 35400000 reads
2023-02-05 16:20:57,164 INFO Parsed 35500000 reads
2023-02-05 16:20:59,324 INFO Parsed 35600000 reads
2023-02-05 16:21:01,491 INFO Parsed 35700000 reads
2023-02-05 16:21:03,658 INFO Parsed 35800000 reads
2023-02-05 16:21:05,819 INFO Parsed 35900000 reads
2023-02-05 16:21:07,979 INFO Parsed 36000000 reads
2023-02-05 16:21:10,146 INFO Parsed 36100000 reads
2023-02-05 16:21:12,306 INFO Parsed 36200000 reads
2023-02-05 16:21:14,465 INFO Parsed 36300000 reads
2023-02-05 16:21:16,636 INFO Parsed 36400000 reads
2023-02-05 16:21:18,802 INFO Parsed 36500000 reads
2023-02-05 16:21:20,953 INFO Parsed 36600000 reads
2023-02-05 16:21:23,153 INFO Parsed 36700000 reads
2023-02-05 16:21:25,319 INFO Parsed 36800000 reads
2023-02-05 16:21:27,482 INFO Parsed 36900000 reads
2023-02-05 16:21:29,650 INFO Parsed 37000000 reads
2023-02-05 16:21:31,814 INFO Parsed 37100000 reads
2023-02-05 16:21:33,975 INFO Parsed 37200000 reads
2023-02-05 16:21:36,139 INFO Parsed 37300000 reads
2023-02-05 16:21:38,303 INFO Parsed 37400000 reads
2023-02-05 16:21:40,465 INFO Parsed 37500000 reads
2023-02-05 16:21:42,630 INFO Parsed 37600000 reads
2023-02-05 16:21:44,802 INFO Parsed 37700000 reads
2023-02-05 16:21:46,964 INFO Parsed 37800000 reads
2023-02-05 16:21:49,125 INFO Parsed 37900000 reads
2023-02-05 16:21:51,291 INFO Parsed 38000000 reads
2023-02-05 16:21:53,449 INFO Parsed 38100000 reads
2023-02-05 16:21:55,647 INFO Parsed 38200000 reads
2023-02-05 16:21:57,842 INFO Parsed 38300000 reads
2023-02-05 16:22:00,023 INFO Parsed 38400000 reads
2023-02-05 16:22:02,210 INFO Parsed 38500000 reads
2023-02-05 16:22:04,391 INFO Parsed 38600000 reads
2023-02-05 16:22:06,556 INFO Parsed 38700000 reads
2023-02-05 16:22:08,714 INFO Parsed 38800000 reads
2023-02-05 16:22:10,872 INFO Parsed 38900000 reads
2023-02-05 16:22:13,032 INFO Parsed 39000000 reads
2023-02-05 16:22:15,183 INFO Parsed 39100000 reads
2023-02-05 16:22:17,340 INFO Parsed 39200000 reads
2023-02-05 16:22:19,505 INFO Parsed 39300000 reads
2023-02-05 16:22:21,671 INFO Parsed 39400000 reads
2023-02-05 16:22:23,831 INFO Parsed 39500000 reads
2023-02-05 16:22:25,993 INFO Parsed 39600000 reads
2023-02-05 16:22:28,149 INFO Parsed 39700000 reads
2023-02-05 16:22:30,303 INFO Parsed 39800000 reads
2023-02-05 16:22:32,460 INFO Parsed 39900000 reads
2023-02-05 16:22:34,685 INFO Parsed 40000000 reads
2023-02-05 16:22:36,845 INFO Parsed 40100000 reads
2023-02-05 16:22:39,007 INFO Parsed 40200000 reads
2023-02-05 16:22:41,169 INFO Parsed 40300000 reads
2023-02-05 16:22:43,327 INFO Parsed 40400000 reads
2023-02-05 16:22:45,471 INFO Parsed 40500000 reads
2023-02-05 16:22:47,620 INFO Parsed 40600000 reads
2023-02-05 16:22:49,775 INFO Parsed 40700000 reads
2023-02-05 16:22:51,928 INFO Parsed 40800000 reads
2023-02-05 16:22:54,084 INFO Parsed 40900000 reads
2023-02-05 16:22:56,244 INFO Parsed 41000000 reads
2023-02-05 16:22:58,396 INFO Parsed 41100000 reads
2023-02-05 16:23:00,548 INFO Parsed 41200000 reads
2023-02-05 16:23:02,703 INFO Parsed 41300000 reads
2023-02-05 16:23:04,853 INFO Parsed 41400000 reads
2023-02-05 16:23:06,998 INFO Parsed 41500000 reads
2023-02-05 16:23:09,154 INFO Parsed 41600000 reads
2023-02-05 16:23:11,306 INFO Parsed 41700000 reads
2023-02-05 16:23:13,454 INFO Parsed 41800000 reads
2023-02-05 16:23:15,607 INFO Parsed 41900000 reads
2023-02-05 16:23:17,755 INFO Parsed 42000000 reads
2023-02-05 16:23:19,898 INFO Parsed 42100000 reads
2023-02-05 16:23:22,055 INFO Parsed 42200000 reads
2023-02-05 16:23:24,213 INFO Parsed 42300000 reads
2023-02-05 16:23:26,361 INFO Parsed 42400000 reads
2023-02-05 16:23:28,508 INFO Input Reads: 42499841
2023-02-05 16:23:28,508 INFO Reads output: 42499841
# job finished in 925 seconds at Sun Feb  5 16:23:28 2023 -- 920.14  1.27  0.00  0.00 -- 34292c86-cfea-44e8-8075-2c79b3abebe8
# UMI-tools version: 1.0.1
# output generated by extract --bc-pattern=NNNNNNNN --stdin=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz --read2-in=./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz --stdout=./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz --read2-stdout
# job started at Sun Feb  5 16:23:29 2023 on gizmok134 -- 534fa752-3178-497c-8cee-ed061bac978e
# pid: 31617, system: Linux 4.15.0-192-generic #203-Ubuntu SMP Wed Aug 10 17:40:03 UTC 2022 x86_64
# blacklist                               : None
# compresslevel                           : 6
# either_read                             : False
# either_read_resolve                     : discard
# error_correct_cell                      : False
# extract_method                          : string
# filter_cell_barcode                     : None
# filter_cell_barcodes                    : False
# log2stderr                              : False
# loglevel                                : 1
# pattern                                 : NNNNNNNN
# pattern2                                : None
# prime3                                  : None
# quality_encoding                        : None
# quality_filter_mask                     : None
# quality_filter_threshold                : None
# random_seed                             : None
# read2_in                                : ./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
# read2_out                               : False
# read2_stdout                            : True
# reads_subset                            : None
# reconcile                               : False
# retain_umi                              : None
# short_help                              : None
# stderr                                  : <_io.TextIOWrapper name='<stderr>' mode='w' encoding='UTF-8'>
# stdin                                   : <_io.TextIOWrapper name='./fastqs_UMI-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz' encoding='ascii'>
# stdlog                                  : <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
# stdout                                  : <_io.TextIOWrapper name='./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz' encoding='ascii'>
# timeit_file                             : None
# timeit_header                           : None
# timeit_name                             : all
# tmpdir                                  : None
# whitelist                               : None
2023-02-05 16:23:29,955 INFO Starting barcode extraction
2023-02-05 16:23:32,445 INFO Parsed 100000 reads
2023-02-05 16:23:34,565 INFO Parsed 200000 reads
2023-02-05 16:23:36,685 INFO Parsed 300000 reads
2023-02-05 16:23:38,819 INFO Parsed 400000 reads
2023-02-05 16:23:40,949 INFO Parsed 500000 reads
2023-02-05 16:23:43,080 INFO Parsed 600000 reads
2023-02-05 16:23:45,217 INFO Parsed 700000 reads
2023-02-05 16:23:47,345 INFO Parsed 800000 reads
2023-02-05 16:23:49,474 INFO Parsed 900000 reads
2023-02-05 16:23:51,613 INFO Parsed 1000000 reads
2023-02-05 16:23:53,741 INFO Parsed 1100000 reads
2023-02-05 16:23:55,873 INFO Parsed 1200000 reads
2023-02-05 16:23:58,011 INFO Parsed 1300000 reads
2023-02-05 16:24:00,148 INFO Parsed 1400000 reads
2023-02-05 16:24:02,381 INFO Parsed 1500000 reads
2023-02-05 16:24:04,520 INFO Parsed 1600000 reads
2023-02-05 16:24:06,656 INFO Parsed 1700000 reads
2023-02-05 16:24:08,781 INFO Parsed 1800000 reads
2023-02-05 16:24:10,909 INFO Parsed 1900000 reads
2023-02-05 16:24:13,057 INFO Parsed 2000000 reads
2023-02-05 16:24:15,188 INFO Parsed 2100000 reads
2023-02-05 16:24:17,317 INFO Parsed 2200000 reads
2023-02-05 16:24:19,458 INFO Parsed 2300000 reads
2023-02-05 16:24:21,588 INFO Parsed 2400000 reads
2023-02-05 16:24:23,719 INFO Parsed 2500000 reads
2023-02-05 16:24:25,861 INFO Parsed 2600000 reads
2023-02-05 16:24:27,991 INFO Parsed 2700000 reads
2023-02-05 16:24:30,115 INFO Parsed 2800000 reads
2023-02-05 16:24:32,251 INFO Parsed 2900000 reads
2023-02-05 16:24:34,395 INFO Parsed 3000000 reads
2023-02-05 16:24:36,531 INFO Parsed 3100000 reads
2023-02-05 16:24:38,671 INFO Parsed 3200000 reads
2023-02-05 16:24:40,824 INFO Parsed 3300000 reads
2023-02-05 16:24:43,007 INFO Parsed 3400000 reads
2023-02-05 16:24:45,142 INFO Parsed 3500000 reads
2023-02-05 16:24:47,286 INFO Parsed 3600000 reads
2023-02-05 16:24:49,428 INFO Parsed 3700000 reads
2023-02-05 16:24:51,572 INFO Parsed 3800000 reads
2023-02-05 16:24:53,735 INFO Parsed 3900000 reads
2023-02-05 16:24:55,889 INFO Parsed 4000000 reads
2023-02-05 16:24:58,208 INFO Parsed 4100000 reads
2023-02-05 16:25:00,370 INFO Parsed 4200000 reads
2023-02-05 16:25:02,507 INFO Parsed 4300000 reads
2023-02-05 16:25:04,646 INFO Parsed 4400000 reads
2023-02-05 16:25:06,802 INFO Parsed 4500000 reads
2023-02-05 16:25:08,959 INFO Parsed 4600000 reads
2023-02-05 16:25:11,100 INFO Parsed 4700000 reads
2023-02-05 16:25:13,256 INFO Parsed 4800000 reads
2023-02-05 16:25:15,425 INFO Parsed 4900000 reads
2023-02-05 16:25:17,560 INFO Parsed 5000000 reads
2023-02-05 16:25:19,702 INFO Parsed 5100000 reads
2023-02-05 16:25:21,870 INFO Parsed 5200000 reads
2023-02-05 16:25:24,010 INFO Parsed 5300000 reads
2023-02-05 16:25:26,147 INFO Parsed 5400000 reads
2023-02-05 16:25:28,300 INFO Parsed 5500000 reads
2023-02-05 16:25:30,436 INFO Parsed 5600000 reads
2023-02-05 16:25:32,567 INFO Parsed 5700000 reads
2023-02-05 16:25:34,709 INFO Parsed 5800000 reads
2023-02-05 16:25:36,843 INFO Parsed 5900000 reads
2023-02-05 16:25:38,966 INFO Parsed 6000000 reads
2023-02-05 16:25:41,100 INFO Parsed 6100000 reads
2023-02-05 16:25:43,254 INFO Parsed 6200000 reads
2023-02-05 16:25:45,387 INFO Parsed 6300000 reads
2023-02-05 16:25:47,527 INFO Parsed 6400000 reads
2023-02-05 16:25:49,676 INFO Parsed 6500000 reads
2023-02-05 16:25:51,810 INFO Parsed 6600000 reads
2023-02-05 16:25:53,945 INFO Parsed 6700000 reads
2023-02-05 16:25:56,098 INFO Parsed 6800000 reads
2023-02-05 16:25:58,236 INFO Parsed 6900000 reads
2023-02-05 16:26:00,368 INFO Parsed 7000000 reads
2023-02-05 16:26:02,524 INFO Parsed 7100000 reads
2023-02-05 16:26:04,657 INFO Parsed 7200000 reads
2023-02-05 16:26:06,790 INFO Parsed 7300000 reads
2023-02-05 16:26:08,937 INFO Parsed 7400000 reads
2023-02-05 16:26:11,148 INFO Parsed 7500000 reads
2023-02-05 16:26:13,280 INFO Parsed 7600000 reads
2023-02-05 16:26:15,421 INFO Parsed 7700000 reads
2023-02-05 16:26:17,573 INFO Parsed 7800000 reads
2023-02-05 16:26:19,704 INFO Parsed 7900000 reads
2023-02-05 16:26:21,840 INFO Parsed 8000000 reads
2023-02-05 16:26:23,986 INFO Parsed 8100000 reads
2023-02-05 16:26:26,209 INFO Parsed 8200000 reads
2023-02-05 16:26:28,347 INFO Parsed 8300000 reads
2023-02-05 16:26:30,496 INFO Parsed 8400000 reads
2023-02-05 16:26:32,627 INFO Parsed 8500000 reads
2023-02-05 16:26:34,754 INFO Parsed 8600000 reads
2023-02-05 16:26:36,903 INFO Parsed 8700000 reads
2023-02-05 16:26:39,048 INFO Parsed 8800000 reads
2023-02-05 16:26:41,415 INFO Parsed 8900000 reads
2023-02-05 16:26:43,555 INFO Parsed 9000000 reads
2023-02-05 16:26:45,691 INFO Parsed 9100000 reads
2023-02-05 16:26:47,809 INFO Parsed 9200000 reads
2023-02-05 16:26:49,939 INFO Parsed 9300000 reads
2023-02-05 16:26:52,088 INFO Parsed 9400000 reads
2023-02-05 16:26:54,219 INFO Parsed 9500000 reads
2023-02-05 16:26:56,353 INFO Parsed 9600000 reads
2023-02-05 16:26:58,502 INFO Parsed 9700000 reads
2023-02-05 16:27:00,636 INFO Parsed 9800000 reads
2023-02-05 16:27:02,766 INFO Parsed 9900000 reads
2023-02-05 16:27:04,913 INFO Parsed 10000000 reads
2023-02-05 16:27:07,050 INFO Parsed 10100000 reads
2023-02-05 16:27:09,180 INFO Parsed 10200000 reads
2023-02-05 16:27:11,328 INFO Parsed 10300000 reads
2023-02-05 16:27:13,470 INFO Parsed 10400000 reads
2023-02-05 16:27:15,590 INFO Parsed 10500000 reads
2023-02-05 16:27:17,720 INFO Parsed 10600000 reads
2023-02-05 16:27:19,841 INFO Parsed 10700000 reads
2023-02-05 16:27:22,138 INFO Parsed 10800000 reads
2023-02-05 16:27:24,264 INFO Parsed 10900000 reads
2023-02-05 16:27:26,403 INFO Parsed 11000000 reads
2023-02-05 16:27:28,522 INFO Parsed 11100000 reads
2023-02-05 16:27:30,656 INFO Parsed 11200000 reads
2023-02-05 16:27:32,811 INFO Parsed 11300000 reads
2023-02-05 16:27:34,921 INFO Parsed 11400000 reads
2023-02-05 16:27:37,037 INFO Parsed 11500000 reads
2023-02-05 16:27:39,171 INFO Parsed 11600000 reads
2023-02-05 16:27:41,353 INFO Parsed 11700000 reads
2023-02-05 16:27:43,484 INFO Parsed 11800000 reads
2023-02-05 16:27:45,629 INFO Parsed 11900000 reads
2023-02-05 16:27:47,758 INFO Parsed 12000000 reads
2023-02-05 16:27:49,863 INFO Parsed 12100000 reads
2023-02-05 16:27:51,985 INFO Parsed 12200000 reads
2023-02-05 16:27:54,116 INFO Parsed 12300000 reads
2023-02-05 16:27:56,227 INFO Parsed 12400000 reads
2023-02-05 16:27:58,352 INFO Parsed 12500000 reads
2023-02-05 16:28:00,494 INFO Parsed 12600000 reads
2023-02-05 16:28:02,612 INFO Parsed 12700000 reads
2023-02-05 16:28:04,732 INFO Parsed 12800000 reads
2023-02-05 16:28:06,864 INFO Parsed 12900000 reads
2023-02-05 16:28:09,003 INFO Parsed 13000000 reads
2023-02-05 16:28:11,121 INFO Parsed 13100000 reads
2023-02-05 16:28:13,254 INFO Parsed 13200000 reads
2023-02-05 16:28:15,392 INFO Parsed 13300000 reads
2023-02-05 16:28:17,554 INFO Parsed 13400000 reads
2023-02-05 16:28:19,680 INFO Parsed 13500000 reads
2023-02-05 16:28:21,815 INFO Parsed 13600000 reads
2023-02-05 16:28:23,933 INFO Parsed 13700000 reads
2023-02-05 16:28:26,057 INFO Parsed 13800000 reads
2023-02-05 16:28:28,195 INFO Parsed 13900000 reads
2023-02-05 16:28:30,320 INFO Parsed 14000000 reads
2023-02-05 16:28:32,572 INFO Parsed 14100000 reads
2023-02-05 16:28:34,705 INFO Parsed 14200000 reads
2023-02-05 16:28:36,807 INFO Parsed 14300000 reads
2023-02-05 16:28:38,884 INFO Parsed 14400000 reads
2023-02-05 16:28:40,968 INFO Parsed 14500000 reads
2023-02-05 16:28:43,085 INFO Parsed 14600000 reads
2023-02-05 16:28:45,194 INFO Parsed 14700000 reads
2023-02-05 16:28:47,299 INFO Parsed 14800000 reads
2023-02-05 16:28:49,621 INFO Parsed 14900000 reads
2023-02-05 16:28:51,723 INFO Parsed 15000000 reads
2023-02-05 16:28:53,822 INFO Parsed 15100000 reads
2023-02-05 16:28:55,936 INFO Parsed 15200000 reads
2023-02-05 16:28:58,059 INFO Parsed 15300000 reads
2023-02-05 16:29:00,166 INFO Parsed 15400000 reads
2023-02-05 16:29:02,285 INFO Parsed 15500000 reads
2023-02-05 16:29:04,663 INFO Parsed 15600000 reads
2023-02-05 16:29:06,776 INFO Parsed 15700000 reads
2023-02-05 16:29:08,899 INFO Parsed 15800000 reads
2023-02-05 16:29:11,028 INFO Parsed 15900000 reads
2023-02-05 16:29:13,127 INFO Parsed 16000000 reads
2023-02-05 16:29:15,234 INFO Parsed 16100000 reads
2023-02-05 16:29:17,358 INFO Parsed 16200000 reads
2023-02-05 16:29:19,463 INFO Parsed 16300000 reads
2023-02-05 16:29:21,569 INFO Parsed 16400000 reads
2023-02-05 16:29:23,689 INFO Parsed 16500000 reads
2023-02-05 16:29:25,795 INFO Parsed 16600000 reads
2023-02-05 16:29:27,898 INFO Parsed 16700000 reads
2023-02-05 16:29:30,012 INFO Parsed 16800000 reads
2023-02-05 16:29:32,128 INFO Parsed 16900000 reads
2023-02-05 16:29:34,299 INFO Parsed 17000000 reads
2023-02-05 16:29:36,404 INFO Parsed 17100000 reads
2023-02-05 16:29:38,516 INFO Parsed 17200000 reads
2023-02-05 16:29:40,608 INFO Parsed 17300000 reads
2023-02-05 16:29:42,707 INFO Parsed 17400000 reads
2023-02-05 16:29:44,821 INFO Parsed 17500000 reads
2023-02-05 16:29:46,923 INFO Parsed 17600000 reads
2023-02-05 16:29:49,021 INFO Parsed 17700000 reads
2023-02-05 16:29:51,137 INFO Parsed 17800000 reads
2023-02-05 16:29:53,244 INFO Parsed 17900000 reads
2023-02-05 16:29:55,345 INFO Parsed 18000000 reads
2023-02-05 16:29:57,460 INFO Parsed 18100000 reads
2023-02-05 16:29:59,582 INFO Parsed 18200000 reads
2023-02-05 16:30:01,689 INFO Parsed 18300000 reads
2023-02-05 16:30:03,808 INFO Parsed 18400000 reads
2023-02-05 16:30:05,937 INFO Parsed 18500000 reads
2023-02-05 16:30:08,037 INFO Parsed 18600000 reads
2023-02-05 16:30:10,140 INFO Parsed 18700000 reads
2023-02-05 16:30:12,260 INFO Parsed 18800000 reads
2023-02-05 16:30:14,369 INFO Parsed 18900000 reads
2023-02-05 16:30:16,480 INFO Parsed 19000000 reads
2023-02-05 16:30:18,614 INFO Parsed 19100000 reads
2023-02-05 16:30:20,721 INFO Parsed 19200000 reads
2023-02-05 16:30:22,822 INFO Parsed 19300000 reads
2023-02-05 16:30:24,930 INFO Parsed 19400000 reads
2023-02-05 16:30:27,040 INFO Parsed 19500000 reads
2023-02-05 16:30:29,152 INFO Parsed 19600000 reads
2023-02-05 16:30:31,472 INFO Parsed 19700000 reads
2023-02-05 16:30:33,589 INFO Parsed 19800000 reads
2023-02-05 16:30:35,690 INFO Parsed 19900000 reads
2023-02-05 16:30:37,791 INFO Parsed 20000000 reads
2023-02-05 16:30:39,904 INFO Parsed 20100000 reads
2023-02-05 16:30:42,010 INFO Parsed 20200000 reads
2023-02-05 16:30:44,113 INFO Parsed 20300000 reads
2023-02-05 16:30:46,408 INFO Parsed 20400000 reads
2023-02-05 16:30:48,521 INFO Parsed 20500000 reads
2023-02-05 16:30:50,619 INFO Parsed 20600000 reads
2023-02-05 16:30:52,725 INFO Parsed 20700000 reads
2023-02-05 16:30:54,847 INFO Parsed 20800000 reads
2023-02-05 16:30:56,952 INFO Parsed 20900000 reads
2023-02-05 16:30:59,061 INFO Parsed 21000000 reads
2023-02-05 16:31:01,176 INFO Parsed 21100000 reads
2023-02-05 16:31:03,270 INFO Parsed 21200000 reads
2023-02-05 16:31:05,364 INFO Parsed 21300000 reads
2023-02-05 16:31:07,472 INFO Parsed 21400000 reads
2023-02-05 16:31:09,582 INFO Parsed 21500000 reads
2023-02-05 16:31:11,690 INFO Parsed 21600000 reads
2023-02-05 16:31:13,799 INFO Parsed 21700000 reads
2023-02-05 16:31:15,925 INFO Parsed 21800000 reads
2023-02-05 16:31:18,039 INFO Parsed 21900000 reads
2023-02-05 16:31:20,152 INFO Parsed 22000000 reads
2023-02-05 16:31:22,273 INFO Parsed 22100000 reads
2023-02-05 16:31:24,384 INFO Parsed 22200000 reads
2023-02-05 16:31:26,494 INFO Parsed 22300000 reads
2023-02-05 16:31:28,615 INFO Parsed 22400000 reads
2023-02-05 16:31:30,729 INFO Parsed 22500000 reads
2023-02-05 16:31:32,843 INFO Parsed 22600000 reads
2023-02-05 16:31:34,962 INFO Parsed 22700000 reads
2023-02-05 16:31:37,070 INFO Parsed 22800000 reads
2023-02-05 16:31:39,175 INFO Parsed 22900000 reads
2023-02-05 16:31:41,287 INFO Parsed 23000000 reads
2023-02-05 16:31:43,750 INFO Parsed 23100000 reads
2023-02-05 16:31:45,861 INFO Parsed 23200000 reads
2023-02-05 16:31:47,969 INFO Parsed 23300000 reads
2023-02-05 16:31:50,083 INFO Parsed 23400000 reads
2023-02-05 16:31:52,189 INFO Parsed 23500000 reads
2023-02-05 16:31:54,294 INFO Parsed 23600000 reads
2023-02-05 16:31:56,415 INFO Parsed 23700000 reads
2023-02-05 16:31:58,697 INFO Parsed 23800000 reads
2023-02-05 16:32:00,806 INFO Parsed 23900000 reads
2023-02-05 16:32:02,927 INFO Parsed 24000000 reads
2023-02-05 16:32:05,032 INFO Parsed 24100000 reads
2023-02-05 16:32:07,136 INFO Parsed 24200000 reads
2023-02-05 16:32:09,254 INFO Parsed 24300000 reads
2023-02-05 16:32:11,364 INFO Parsed 24400000 reads
2023-02-05 16:32:13,470 INFO Parsed 24500000 reads
2023-02-05 16:32:15,584 INFO Parsed 24600000 reads
2023-02-05 16:32:17,696 INFO Parsed 24700000 reads
2023-02-05 16:32:19,804 INFO Parsed 24800000 reads
2023-02-05 16:32:21,918 INFO Parsed 24900000 reads
2023-02-05 16:32:24,035 INFO Parsed 25000000 reads
2023-02-05 16:32:26,145 INFO Parsed 25100000 reads
2023-02-05 16:32:28,482 INFO Parsed 25200000 reads
2023-02-05 16:32:30,594 INFO Parsed 25300000 reads
2023-02-05 16:32:32,697 INFO Parsed 25400000 reads
2023-02-05 16:32:34,800 INFO Parsed 25500000 reads
2023-02-05 16:32:36,923 INFO Parsed 25600000 reads
2023-02-05 16:32:39,093 INFO Parsed 25700000 reads
2023-02-05 16:32:41,203 INFO Parsed 25800000 reads
2023-02-05 16:32:43,319 INFO Parsed 25900000 reads
2023-02-05 16:32:45,421 INFO Parsed 26000000 reads
2023-02-05 16:32:47,526 INFO Parsed 26100000 reads
2023-02-05 16:32:49,646 INFO Parsed 26200000 reads
2023-02-05 16:32:51,760 INFO Parsed 26300000 reads
2023-02-05 16:32:53,867 INFO Parsed 26400000 reads
2023-02-05 16:32:55,980 INFO Parsed 26500000 reads
2023-02-05 16:32:58,092 INFO Parsed 26600000 reads
2023-02-05 16:33:00,195 INFO Parsed 26700000 reads
2023-02-05 16:33:02,307 INFO Parsed 26800000 reads
2023-02-05 16:33:04,428 INFO Parsed 26900000 reads
2023-02-05 16:33:06,537 INFO Parsed 27000000 reads
2023-02-05 16:33:08,650 INFO Parsed 27100000 reads
2023-02-05 16:33:10,878 INFO Parsed 27200000 reads
2023-02-05 16:33:12,971 INFO Parsed 27300000 reads
2023-02-05 16:33:15,069 INFO Parsed 27400000 reads
2023-02-05 16:33:17,192 INFO Parsed 27500000 reads
2023-02-05 16:33:19,303 INFO Parsed 27600000 reads
2023-02-05 16:33:21,416 INFO Parsed 27700000 reads
2023-02-05 16:33:23,553 INFO Parsed 27800000 reads
2023-02-05 16:33:25,673 INFO Parsed 27900000 reads
2023-02-05 16:33:27,781 INFO Parsed 28000000 reads
2023-02-05 16:33:29,906 INFO Parsed 28100000 reads
2023-02-05 16:33:32,024 INFO Parsed 28200000 reads
2023-02-05 16:33:34,136 INFO Parsed 28300000 reads
2023-02-05 16:33:36,253 INFO Parsed 28400000 reads
2023-02-05 16:33:38,361 INFO Parsed 28500000 reads
2023-02-05 16:33:40,468 INFO Parsed 28600000 reads
2023-02-05 16:33:42,583 INFO Parsed 28700000 reads
2023-02-05 16:33:44,692 INFO Parsed 28800000 reads
2023-02-05 16:33:46,797 INFO Parsed 28900000 reads
2023-02-05 16:33:48,904 INFO Parsed 29000000 reads
2023-02-05 16:33:51,016 INFO Parsed 29100000 reads
2023-02-05 16:33:53,121 INFO Parsed 29200000 reads
2023-02-05 16:33:55,232 INFO Parsed 29300000 reads
2023-02-05 16:33:57,351 INFO Parsed 29400000 reads
2023-02-05 16:33:59,458 INFO Parsed 29500000 reads
2023-02-05 16:34:01,568 INFO Parsed 29600000 reads
2023-02-05 16:34:03,676 INFO Parsed 29700000 reads
2023-02-05 16:34:05,772 INFO Parsed 29800000 reads
2023-02-05 16:34:07,871 INFO Parsed 29900000 reads
2023-02-05 16:34:09,978 INFO Parsed 30000000 reads
2023-02-05 16:34:12,078 INFO Parsed 30100000 reads
2023-02-05 16:34:14,181 INFO Parsed 30200000 reads
2023-02-05 16:34:16,291 INFO Parsed 30300000 reads
2023-02-05 16:34:18,391 INFO Parsed 30400000 reads
2023-02-05 16:34:20,488 INFO Parsed 30500000 reads
2023-02-05 16:34:22,747 INFO Parsed 30600000 reads
2023-02-05 16:34:24,858 INFO Parsed 30700000 reads
2023-02-05 16:34:26,960 INFO Parsed 30800000 reads
2023-02-05 16:34:29,064 INFO Parsed 30900000 reads
2023-02-05 16:34:31,183 INFO Parsed 31000000 reads
2023-02-05 16:34:33,287 INFO Parsed 31100000 reads
2023-02-05 16:34:35,397 INFO Parsed 31200000 reads
2023-02-05 16:34:38,037 INFO Parsed 31300000 reads
2023-02-05 16:34:40,144 INFO Parsed 31400000 reads
2023-02-05 16:34:42,270 INFO Parsed 31500000 reads
2023-02-05 16:34:44,402 INFO Parsed 31600000 reads
2023-02-05 16:34:46,507 INFO Parsed 31700000 reads
2023-02-05 16:34:48,611 INFO Parsed 31800000 reads
2023-02-05 16:34:50,728 INFO Parsed 31900000 reads
2023-02-05 16:34:52,935 INFO Parsed 32000000 reads
2023-02-05 16:34:55,033 INFO Parsed 32100000 reads
2023-02-05 16:34:57,137 INFO Parsed 32200000 reads
2023-02-05 16:34:59,237 INFO Parsed 32300000 reads
2023-02-05 16:35:01,334 INFO Parsed 32400000 reads
2023-02-05 16:35:03,439 INFO Parsed 32500000 reads
2023-02-05 16:35:05,540 INFO Parsed 32600000 reads
2023-02-05 16:35:08,103 INFO Parsed 32700000 reads
2023-02-05 16:35:10,206 INFO Parsed 32800000 reads
2023-02-05 16:35:12,321 INFO Parsed 32900000 reads
2023-02-05 16:35:14,428 INFO Parsed 33000000 reads
2023-02-05 16:35:16,552 INFO Parsed 33100000 reads
2023-02-05 16:35:18,667 INFO Parsed 33200000 reads
2023-02-05 16:35:20,772 INFO Parsed 33300000 reads
2023-02-05 16:35:22,929 INFO Parsed 33400000 reads
2023-02-05 16:35:25,041 INFO Parsed 33500000 reads
2023-02-05 16:35:27,139 INFO Parsed 33600000 reads
2023-02-05 16:35:29,235 INFO Parsed 33700000 reads
2023-02-05 16:35:31,332 INFO Parsed 33800000 reads
2023-02-05 16:35:33,423 INFO Parsed 33900000 reads
2023-02-05 16:35:35,520 INFO Parsed 34000000 reads
2023-02-05 16:35:37,627 INFO Parsed 34100000 reads
2023-02-05 16:35:39,728 INFO Parsed 34200000 reads
2023-02-05 16:35:41,833 INFO Parsed 34300000 reads
2023-02-05 16:35:43,936 INFO Parsed 34400000 reads
2023-02-05 16:35:46,060 INFO Parsed 34500000 reads
2023-02-05 16:35:48,198 INFO Parsed 34600000 reads
2023-02-05 16:35:50,307 INFO Parsed 34700000 reads
2023-02-05 16:35:52,420 INFO Parsed 34800000 reads
2023-02-05 16:35:54,526 INFO Parsed 34900000 reads
2023-02-05 16:35:56,632 INFO Parsed 35000000 reads
2023-02-05 16:35:58,742 INFO Parsed 35100000 reads
2023-02-05 16:36:00,844 INFO Parsed 35200000 reads
2023-02-05 16:36:03,150 INFO Parsed 35300000 reads
2023-02-05 16:36:05,261 INFO Parsed 35400000 reads
2023-02-05 16:36:07,360 INFO Parsed 35500000 reads
2023-02-05 16:36:09,454 INFO Parsed 35600000 reads
2023-02-05 16:36:11,555 INFO Parsed 35700000 reads
2023-02-05 16:36:13,656 INFO Parsed 35800000 reads
2023-02-05 16:36:15,753 INFO Parsed 35900000 reads
2023-02-05 16:36:17,853 INFO Parsed 36000000 reads
2023-02-05 16:36:20,120 INFO Parsed 36100000 reads
2023-02-05 16:36:22,238 INFO Parsed 36200000 reads
2023-02-05 16:36:24,347 INFO Parsed 36300000 reads
2023-02-05 16:36:26,469 INFO Parsed 36400000 reads
2023-02-05 16:36:28,612 INFO Parsed 36500000 reads
2023-02-05 16:36:30,742 INFO Parsed 36600000 reads
2023-02-05 16:36:32,865 INFO Parsed 36700000 reads
2023-02-05 16:36:34,968 INFO Parsed 36800000 reads
2023-02-05 16:36:37,067 INFO Parsed 36900000 reads
2023-02-05 16:36:39,167 INFO Parsed 37000000 reads
2023-02-05 16:36:41,264 INFO Parsed 37100000 reads
2023-02-05 16:36:43,358 INFO Parsed 37200000 reads
2023-02-05 16:36:45,462 INFO Parsed 37300000 reads
2023-02-05 16:36:47,564 INFO Parsed 37400000 reads
2023-02-05 16:36:49,697 INFO Parsed 37500000 reads
2023-02-05 16:36:51,796 INFO Parsed 37600000 reads
2023-02-05 16:36:53,898 INFO Parsed 37700000 reads
2023-02-05 16:36:55,985 INFO Parsed 37800000 reads
2023-02-05 16:36:58,081 INFO Parsed 37900000 reads
2023-02-05 16:37:00,254 INFO Parsed 38000000 reads
2023-02-05 16:37:02,343 INFO Parsed 38100000 reads
2023-02-05 16:37:04,430 INFO Parsed 38200000 reads
2023-02-05 16:37:06,525 INFO Parsed 38300000 reads
2023-02-05 16:37:08,623 INFO Parsed 38400000 reads
2023-02-05 16:37:10,710 INFO Parsed 38500000 reads
2023-02-05 16:37:12,802 INFO Parsed 38600000 reads
2023-02-05 16:37:15,028 INFO Parsed 38700000 reads
2023-02-05 16:37:17,109 INFO Parsed 38800000 reads
2023-02-05 16:37:19,197 INFO Parsed 38900000 reads
2023-02-05 16:37:21,287 INFO Parsed 39000000 reads
2023-02-05 16:37:23,373 INFO Parsed 39100000 reads
2023-02-05 16:37:25,469 INFO Parsed 39200000 reads
2023-02-05 16:37:27,570 INFO Parsed 39300000 reads
2023-02-05 16:37:29,667 INFO Parsed 39400000 reads
2023-02-05 16:37:32,128 INFO Parsed 39500000 reads
2023-02-05 16:37:34,220 INFO Parsed 39600000 reads
2023-02-05 16:37:36,273 INFO Parsed 39700000 reads
2023-02-05 16:37:38,329 INFO Parsed 39800000 reads
2023-02-05 16:37:40,386 INFO Parsed 39900000 reads
2023-02-05 16:37:42,462 INFO Parsed 40000000 reads
2023-02-05 16:37:44,517 INFO Parsed 40100000 reads
2023-02-05 16:37:46,684 INFO Parsed 40200000 reads
2023-02-05 16:37:48,764 INFO Parsed 40300000 reads
2023-02-05 16:37:50,859 INFO Parsed 40400000 reads
2023-02-05 16:37:52,946 INFO Parsed 40500000 reads
2023-02-05 16:37:55,039 INFO Parsed 40600000 reads
2023-02-05 16:37:57,131 INFO Parsed 40700000 reads
2023-02-05 16:37:59,218 INFO Parsed 40800000 reads
2023-02-05 16:38:01,308 INFO Parsed 40900000 reads
2023-02-05 16:38:03,402 INFO Parsed 41000000 reads
2023-02-05 16:38:05,488 INFO Parsed 41100000 reads
2023-02-05 16:38:07,575 INFO Parsed 41200000 reads
2023-02-05 16:38:09,666 INFO Parsed 41300000 reads
2023-02-05 16:38:11,754 INFO Parsed 41400000 reads
2023-02-05 16:38:13,838 INFO Parsed 41500000 reads
2023-02-05 16:38:15,939 INFO Parsed 41600000 reads
2023-02-05 16:38:18,029 INFO Parsed 41700000 reads
2023-02-05 16:38:20,119 INFO Parsed 41800000 reads
2023-02-05 16:38:22,215 INFO Parsed 41900000 reads
2023-02-05 16:38:24,298 INFO Parsed 42000000 reads
2023-02-05 16:38:26,374 INFO Parsed 42100000 reads
2023-02-05 16:38:28,463 INFO Parsed 42200000 reads
2023-02-05 16:38:30,556 INFO Parsed 42300000 reads
2023-02-05 16:38:32,636 INFO Parsed 42400000 reads
2023-02-05 16:38:34,715 INFO Input Reads: 42499841
2023-02-05 16:38:34,715 INFO Reads output: 42499841
# job finished in 904 seconds at Sun Feb  5 16:38:34 2023 -- 897.88  1.29  0.00  0.00 -- 534fa752-3178-497c-8cee-ed061bac978e


❯ cd ../../fastqs_UMI-dedup/atria_trim


❯ mkdir bak
mkdir: created directory 'bak'


❯ ., Sample_CT2_6125_pIAA_Q_SteadyState_S6*
-rw-rw---- 1 kalavatt 965M Feb  5 17:53 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz
-rw-rw---- 1 kalavatt 1.8K Feb  5 17:53 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log
-rw-rw---- 1 kalavatt 2.9K Feb  5 17:53 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log.json
-rw-rw---- 1 kalavatt 947M Feb  5 17:53 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz


❯ cat Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log
┌ Info: ATRIA VERSIONS
│   atria = v3.2.1
│   julia = v1.8.5
└ @ Atria.Trimmer /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/src/Trimmer/wrapper.jl:606
┌ Info: ATRIA ARGUMENTS
│   command = `-t 8 -r ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz -R ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz -o ./fastqs_UMI-dedup/atria_trim --no-length-filtration`
└ @ Atria.Trimmer /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/src/Trimmer/wrapper.jl:607
┌ Info: ATRIA OUTPUT FILES
│   read1 = ./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz
│   read2 = ./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz
└ @ Atria.Trimmer /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/src/Trimmer/wrapper.jl:608
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = false
└ @ Atria.Trimmer /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/src/Trimmer/wrapper.jl:609
┌ Info: ATRIA COMPLETE
│   read1 = ./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz
│   read2 = ./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz
└ @ Atria.Trimmer /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/src/Trimmer/wrapper.jl:718


❯ mv Sample_CT2_6125_pIAA_Q_SteadyState_S6* bak/
renamed 'Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz' -> 'bak/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz'
renamed 'Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log' -> 'bak/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log'
renamed 'Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log.json' -> 'bak/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.log.json'
renamed 'Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz' -> 'bak/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz'


❯ ../..
cd -- ../..


❯ /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria \
>     -t "${SLURM_CPUS_ON_NODE}" \
>     -r ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz \
>     -R ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz \
>     -o ./fastqs_UMI-dedup/atria_trim \
>     --no-length-filtration \
>     --stats
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-t 16 -r ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.fq.gz -R ./fastqs_UMI-dedup/umi-tools_extract/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.fq.gz -o ./fastqs_UMI-dedup/atria_trim --no-length-filtration --stats`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz"
└   read2 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = false
[ Info: Cycle 1: read 379697/379697 pairs; wrote 379697/379697 pairs; (copied 0/0 reads)
[ Info: Cycle 2: read 379460/759157 pairs; wrote 379460/759157 pairs; (copied 0/0 reads)
[ Info: Cycle 3: read 379467/1138624 pairs; wrote 379467/1138624 pairs; (copied 0/0 reads)
[ Info: Cycle 4: read 379467/1518091 pairs; wrote 379467/1518091 pairs; (copied 0/0 reads)
[ Info: Cycle 5: read 379455/1897546 pairs; wrote 379455/1897546 pairs; (copied 0/0 reads)
[ Info: Cycle 6: read 379564/2277110 pairs; wrote 379564/2277110 pairs; (copied 0/0 reads)
[ Info: Cycle 7: read 379597/2656707 pairs; wrote 379597/2656707 pairs; (copied 0/0 reads)
[ Info: Cycle 8: read 379466/3036173 pairs; wrote 379466/3036173 pairs; (copied 0/0 reads)
[ Info: Cycle 9: read 379467/3415640 pairs; wrote 379467/3415640 pairs; (copied 0/0 reads)
[ Info: Cycle 10: read 379465/3795105 pairs; wrote 379465/3795105 pairs; (copied 0/0 reads)
[ Info: Cycle 11: read 379450/4174555 pairs; wrote 379450/4174555 pairs; (copied 0/0 reads)
[ Info: Cycle 12: read 379661/4554216 pairs; wrote 379661/4554216 pairs; (copied 0/0 reads)
[ Info: Cycle 13: read 379501/4933717 pairs; wrote 379501/4933717 pairs; (copied 0/0 reads)
[ Info: Cycle 14: read 379468/5313185 pairs; wrote 379468/5313185 pairs; (copied 0/0 reads)
[ Info: Cycle 15: read 379471/5692656 pairs; wrote 379471/5692656 pairs; (copied 0/0 reads)
[ Info: Cycle 16: read 379450/6072106 pairs; wrote 379450/6072106 pairs; (copied 0/0 reads)
[ Info: Cycle 17: read 379509/6451615 pairs; wrote 379509/6451615 pairs; (copied 0/0 reads)
[ Info: Cycle 18: read 379655/6831270 pairs; wrote 379655/6831270 pairs; (copied 0/0 reads)
[ Info: Cycle 19: read 379464/7210734 pairs; wrote 379464/7210734 pairs; (copied 0/0 reads)
[ Info: Cycle 20: read 379470/7590204 pairs; wrote 379470/7590204 pairs; (copied 0/0 reads)
[ Info: Cycle 21: read 379468/7969672 pairs; wrote 379468/7969672 pairs; (copied 0/0 reads)
[ Info: Cycle 22: read 379458/8349130 pairs; wrote 379458/8349130 pairs; (copied 0/0 reads)
[ Info: Cycle 23: read 379612/8728742 pairs; wrote 379612/8728742 pairs; (copied 0/0 reads)
[ Info: Cycle 24: read 379548/9108290 pairs; wrote 379548/9108290 pairs; (copied 0/0 reads)
[ Info: Cycle 25: read 379465/9487755 pairs; wrote 379465/9487755 pairs; (copied 0/0 reads)
[ Info: Cycle 26: read 379468/9867223 pairs; wrote 379468/9867223 pairs; (copied 0/0 reads)
[ Info: Cycle 27: read 379466/10246689 pairs; wrote 379466/10246689 pairs; (copied 0/0 reads)
[ Info: Cycle 28: read 379456/10626145 pairs; wrote 379456/10626145 pairs; (copied 0/0 reads)
[ Info: Cycle 29: read 379655/11005800 pairs; wrote 379655/11005800 pairs; (copied 0/0 reads)
[ Info: Cycle 30: read 379517/11385317 pairs; wrote 379517/11385317 pairs; (copied 0/0 reads)
[ Info: Cycle 31: read 379470/11764787 pairs; wrote 379470/11764787 pairs; (copied 0/0 reads)
[ Info: Cycle 32: read 379475/12144262 pairs; wrote 379475/12144262 pairs; (copied 0/0 reads)
[ Info: Cycle 33: read 379467/12523729 pairs; wrote 379467/12523729 pairs; (copied 0/0 reads)
[ Info: Cycle 34: read 379458/12903187 pairs; wrote 379458/12903187 pairs; (copied 0/0 reads)
[ Info: Cycle 35: read 379665/13282852 pairs; wrote 379665/13282852 pairs; (copied 0/0 reads)
[ Info: Cycle 36: read 379506/13662358 pairs; wrote 379506/13662358 pairs; (copied 0/0 reads)
[ Info: Cycle 37: read 379474/14041832 pairs; wrote 379474/14041832 pairs; (copied 0/0 reads)
[ Info: Cycle 38: read 379476/14421308 pairs; wrote 379476/14421308 pairs; (copied 0/0 reads)
[ Info: Cycle 39: read 379467/14800775 pairs; wrote 379467/14800775 pairs; (copied 0/0 reads)
[ Info: Cycle 40: read 379460/15180235 pairs; wrote 379460/15180235 pairs; (copied 0/0 reads)
[ Info: Cycle 41: read 379589/15559824 pairs; wrote 379589/15559824 pairs; (copied 0/0 reads)
[ Info: Cycle 42: read 379572/15939396 pairs; wrote 379572/15939396 pairs; (copied 0/0 reads)
[ Info: Cycle 43: read 379467/16318863 pairs; wrote 379467/16318863 pairs; (copied 0/0 reads)
[ Info: Cycle 44: read 379473/16698336 pairs; wrote 379473/16698336 pairs; (copied 0/0 reads)
[ Info: Cycle 45: read 379469/17077805 pairs; wrote 379469/17077805 pairs; (copied 0/0 reads)
[ Info: Cycle 46: read 379453/17457258 pairs; wrote 379453/17457258 pairs; (copied 0/0 reads)
[ Info: Cycle 47: read 379644/17836902 pairs; wrote 379644/17836902 pairs; (copied 0/0 reads)
[ Info: Cycle 48: read 379527/18216429 pairs; wrote 379527/18216429 pairs; (copied 0/0 reads)
[ Info: Cycle 49: read 379473/18595902 pairs; wrote 379473/18595902 pairs; (copied 0/0 reads)
[ Info: Cycle 50: read 379475/18975377 pairs; wrote 379475/18975377 pairs; (copied 0/0 reads)
[ Info: Cycle 51: read 379468/19354845 pairs; wrote 379468/19354845 pairs; (copied 0/0 reads)
[ Info: Cycle 52: read 379456/19734301 pairs; wrote 379456/19734301 pairs; (copied 0/0 reads)
[ Info: Cycle 53: read 379629/20113930 pairs; wrote 379629/20113930 pairs; (copied 0/0 reads)
[ Info: Cycle 54: read 379536/20493466 pairs; wrote 379536/20493466 pairs; (copied 0/0 reads)
[ Info: Cycle 55: read 379467/20872933 pairs; wrote 379467/20872933 pairs; (copied 0/0 reads)
[ Info: Cycle 56: read 379473/21252406 pairs; wrote 379473/21252406 pairs; (copied 0/0 reads)
[ Info: Cycle 57: read 379461/21631867 pairs; wrote 379461/21631867 pairs; (copied 0/0 reads)
[ Info: Cycle 58: read 379447/22011314 pairs; wrote 379447/22011314 pairs; (copied 0/0 reads)
[ Info: Cycle 59: read 379697/22391011 pairs; wrote 379697/22391011 pairs; (copied 0/0 reads)
[ Info: Cycle 60: read 379460/22770471 pairs; wrote 379460/22770471 pairs; (copied 0/0 reads)
[ Info: Cycle 61: read 379466/23149937 pairs; wrote 379466/23149937 pairs; (copied 0/0 reads)
[ Info: Cycle 62: read 379466/23529403 pairs; wrote 379466/23529403 pairs; (copied 0/0 reads)
[ Info: Cycle 63: read 379452/23908855 pairs; wrote 379452/23908855 pairs; (copied 0/0 reads)
[ Info: Cycle 64: read 379639/24288494 pairs; wrote 379639/24288494 pairs; (copied 0/0 reads)
[ Info: Cycle 65: read 379511/24668005 pairs; wrote 379511/24668005 pairs; (copied 0/0 reads)
[ Info: Cycle 66: read 379466/25047471 pairs; wrote 379466/25047471 pairs; (copied 0/0 reads)
[ Info: Cycle 67: read 379467/25426938 pairs; wrote 379467/25426938 pairs; (copied 0/0 reads)
[ Info: Cycle 68: read 379456/25806394 pairs; wrote 379456/25806394 pairs; (copied 0/0 reads)
[ Info: Cycle 69: read 379573/26185967 pairs; wrote 379573/26185967 pairs; (copied 0/0 reads)
[ Info: Cycle 70: read 379574/26565541 pairs; wrote 379574/26565541 pairs; (copied 0/0 reads)
[ Info: Cycle 71: read 379465/26945006 pairs; wrote 379465/26945006 pairs; (copied 0/0 reads)
[ Info: Cycle 72: read 379460/27324466 pairs; wrote 379460/27324466 pairs; (copied 0/0 reads)
[ Info: Cycle 73: read 379457/27703923 pairs; wrote 379457/27703923 pairs; (copied 0/0 reads)
[ Info: Cycle 74: read 379576/28083499 pairs; wrote 379576/28083499 pairs; (copied 0/0 reads)
[ Info: Cycle 75: read 379581/28463080 pairs; wrote 379581/28463080 pairs; (copied 0/0 reads)
[ Info: Cycle 76: read 379466/28842546 pairs; wrote 379466/28842546 pairs; (copied 0/0 reads)
[ Info: Cycle 77: read 379470/29222016 pairs; wrote 379470/29222016 pairs; (copied 0/0 reads)
[ Info: Cycle 78: read 379424/29601440 pairs; wrote 379424/29601440 pairs; (copied 0/0 reads)
[ Info: Cycle 79: read 379554/29980994 pairs; wrote 379554/29980994 pairs; (copied 0/0 reads)
[ Info: Cycle 80: read 379602/30360596 pairs; wrote 379602/30360596 pairs; (copied 0/0 reads)
[ Info: Cycle 81: read 379467/30740063 pairs; wrote 379467/30740063 pairs; (copied 0/0 reads)
[ Info: Cycle 82: read 379471/31119534 pairs; wrote 379471/31119534 pairs; (copied 0/0 reads)
[ Info: Cycle 83: read 379465/31498999 pairs; wrote 379465/31498999 pairs; (copied 0/0 reads)
[ Info: Cycle 84: read 379456/31878455 pairs; wrote 379456/31878455 pairs; (copied 0/0 reads)
[ Info: Cycle 85: read 379705/32258160 pairs; wrote 379705/32258160 pairs; (copied 0/0 reads)
[ Info: Cycle 86: read 379465/32637625 pairs; wrote 379465/32637625 pairs; (copied 0/0 reads)
[ Info: Cycle 87: read 379477/33017102 pairs; wrote 379477/33017102 pairs; (copied 0/0 reads)
[ Info: Cycle 88: read 379447/33396549 pairs; wrote 379447/33396549 pairs; (copied 0/0 reads)
[ Info: Cycle 89: read 379453/33776002 pairs; wrote 379453/33776002 pairs; (copied 0/0 reads)
[ Info: Cycle 90: read 379714/34155716 pairs; wrote 379714/34155716 pairs; (copied 0/0 reads)
[ Info: Cycle 91: read 379463/34535179 pairs; wrote 379463/34535179 pairs; (copied 0/0 reads)
[ Info: Cycle 92: read 379473/34914652 pairs; wrote 379473/34914652 pairs; (copied 0/0 reads)
[ Info: Cycle 93: read 379475/35294127 pairs; wrote 379475/35294127 pairs; (copied 0/0 reads)
[ Info: Cycle 94: read 379462/35673589 pairs; wrote 379462/35673589 pairs; (copied 0/0 reads)
[ Info: Cycle 95: read 379474/36053063 pairs; wrote 379474/36053063 pairs; (copied 0/0 reads)
[ Info: Cycle 96: read 379690/36432753 pairs; wrote 379690/36432753 pairs; (copied 0/0 reads)
[ Info: Cycle 97: read 379465/36812218 pairs; wrote 379465/36812218 pairs; (copied 0/0 reads)
[ Info: Cycle 98: read 379472/37191690 pairs; wrote 379472/37191690 pairs; (copied 0/0 reads)
[ Info: Cycle 99: read 379469/37571159 pairs; wrote 379469/37571159 pairs; (copied 0/0 reads)
[ Info: Cycle 100: read 379454/37950613 pairs; wrote 379454/37950613 pairs; (copied 0/0 reads)
[ Info: Cycle 101: read 379578/38330191 pairs; wrote 379578/38330191 pairs; (copied 0/0 reads)
[ Info: Cycle 102: read 379577/38709768 pairs; wrote 379577/38709768 pairs; (copied 0/0 reads)
[ Info: Cycle 103: read 379471/39089239 pairs; wrote 379471/39089239 pairs; (copied 0/0 reads)
[ Info: Cycle 104: read 379473/39468712 pairs; wrote 379473/39468712 pairs; (copied 0/0 reads)
[ Info: Cycle 105: read 379469/39848181 pairs; wrote 379469/39848181 pairs; (copied 0/0 reads)
[ Info: Cycle 106: read 379451/40227632 pairs; wrote 379451/40227632 pairs; (copied 0/0 reads)
[ Info: Cycle 107: read 379675/40607307 pairs; wrote 379675/40607307 pairs; (copied 0/0 reads)
[ Info: Cycle 108: read 379489/40986796 pairs; wrote 379489/40986796 pairs; (copied 0/0 reads)
[ Info: Cycle 109: read 379471/41366267 pairs; wrote 379471/41366267 pairs; (copied 0/0 reads)
[ Info: Cycle 110: read 379470/41745737 pairs; wrote 379470/41745737 pairs; (copied 0/0 reads)
[ Info: Cycle 111: read 379460/42125197 pairs; wrote 379460/42125197 pairs; (copied 0/0 reads)
[ Info: Cycle 112: read 374644/42499841 pairs; wrote 374644/42499841 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1.UMI.atria.fq.gz"
└   read2 = "./fastqs_UMI-dedup/atria_trim/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3.UMI.atria.fq.gz"


❯ STAR \
>     --runMode alignReads \
>     --runThreadN "${SLURM_CPUS_ON_NODE}" \
>     --outSAMtype BAM SortedByCoordinate \
>     --outSAMunmapped Within \
>     --outSAMattributes All \
>     --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR \
>     --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz \
>     --readFilesCommand zcat \
>     --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT \
>     --limitBAMsortRAM 4000000000 \
>     --outFilterMultimapNmax 10 \
>     --winAnchorMultimapNmax 1000 \
>     --alignSJoverhangMin 8 \
>     --alignSJDBoverhangMin 1 \
>     --outFilterMismatchNmax 999 \
>     --outMultimapperOrder Random \
>     --alignEndsType EndToEnd \
>     --alignIntronMin 4 \
>     --alignIntronMax 5000 \
>     --alignMatesGapMax 5000 \
>         >> >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stdout.txt) \
>         2>> >(tee -a sh_err_out/err_out/rerun_STAR.CT2_6125_pIAA_Q_SteadyState_UT.2023-0213.stderr.txt >&2)
    STAR --runMode alignReads --runThreadN 16 --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes All --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR --readFilesIn ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R1.fq.gz ./bams_UMI-dedup/to-align_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT_R3.fq.gz --readFilesCommand zcat --outFileNamePrefix ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CT2_6125_pIAA_Q_SteadyState_UT --limitBAMsortRAM 4000000000 --outFilterMultimapNmax 10 --winAnchorMultimapNmax 1000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outMultimapperOrder Random --alignEndsType EndToEnd --alignIntronMin 4 --alignIntronMax 5000 --alignMatesGapMax 5000
    STAR version: 2.7.10b   compiled: 2022-11-01T09:53:26-04:00 :/home/dobin/data/STAR/STARcode/STAR.master/source
Feb 13 08:39:36 ..... started STAR run
Feb 13 08:39:46 ..... loading genome
Feb 13 08:39:46 ..... started mapping
Feb 13 08:42:22 ..... finished mapping
Feb 13 08:42:22 ..... started sorting BAM
Feb 13 08:43:47 ..... finished successfully


❯ mv \
>     ./fastqs_UMI-dedup/atria_trim/bak \
>     ./fastqs_UMI-dedup/atria_trim/problem
renamed './fastqs_UMI-dedup/atria_trim/bak' -> './fastqs_UMI-dedup/atria_trim/problem'


❯ mv \
>     ./bams_UMI-dedup/aligned_umi-extracted_trimmed/bak \
>     ./bams_UMI-dedup/aligned_umi-extracted_trimmed/problem
renamed './bams_UMI-dedup/aligned_umi-extracted_trimmed/bak' -> './bams_UMI-dedup/aligned_umi-extracted_trimmed/problem'
```
</details>
<br />

<a id="07b-rename-organize-and-check-on-files-in-aligned_umi-extracted_trimmed_kmer-corrected"></a>
#### 07b Rename, organize, and check on files in `aligned_umi-extracted_trimmed_kmer-corrected/`
<a id="code-52"></a>
##### Code
<details>
<summary><i>Code: Rename, organize, and check on files in aligned_umi-extracted_trimmed_kmer-corrected/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

cd "bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/" \
    || echo "cd'ing failed; check on this..."

rename -n 's/Aligned.sortedByCoord.out//g' *
rename -n 's/Log/.Log/g; s/SJ/.SJ/g' *

rename 's/Aligned.sortedByCoord.out//g' *
rename 's/Log/.Log/g; s/SJ/.SJ/g' *

rm -r *_STARtmp/

.,
#NOTE Everything seems to check out
```
</details>
<br />
<br />

<a id="vi-subset-bams-by-alignment-flags-trinity-general"></a>
## <u>VI</u> Subset bams by alignment flags *(Trinity, general)*
<a id="01-get-situated-make-directories-for-outfiles"></a>
### 01 Get situated, make directories for outfiles
<a id="code-53"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directories for outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 16, etc.

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate Trinity_env
module purge
module load SAMtools/1.16.1-GCC-11.2.0

#  Make directories for outfiles
mkdir -p "./bams_UMI-dedup/aligned_UT_primary"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-secondary"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-unmapped"
```

</details>
<br />

<a id="02-set-up-necessary-variables-arrays"></a>
### 02 Set up necessary variables, arrays
<a id="02a-set-up-information-for-aligned_ut_primary_"></a>
#### 02a Set up information for `aligned_UT_primary_*`
<a id="code-54"></a>
##### Code
<details>
<summary><i>Code: Set up information for aligned_UT_primary_*</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams_UT_prim
typeset -a bams_UT_prim
while IFS=" " read -r -d $'\0'; do
    bams_UT_prim+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_umi-extracted_trimmed" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT_prim[@]}"
echo "${#bams_UT_prim[@]}"
```
</details>
<br />

<a id="02b-set-up-information-for-aligned_utk_primary-secondary_"></a>
#### 02b Set up information for `aligned_UTK_primary-secondary_*`
<a id="code-55"></a>
##### Code
<details>
<summary><i>Code: Set up information for aligned_UTK_primary-secondary_*</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams_UT_p_s
typeset -a bams_UT_p_s
while IFS=" " read -r -d $'\0'; do
    bams_UT_p_s+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/" \
        -maxdepth 1 \
        -type f \
        -name 578*.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT_p_s[@]}"
echo "${#bams_UT_p_s[@]}"
```
</details>
<br />

<a id="02c-set-up-information-for-aligned_utk_primary-unmapped_"></a>
#### 02c Set up information for `aligned_UTK_primary-unmapped_*`
<a id="code-56"></a>
##### Code
<details>
<summary><i>Code: Set up information for aligned_UTK_primary-unmapped_*</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams_UT_p_u
typeset -a bams_UT_p_u
while IFS=" " read -r -d $'\0'; do
    bams_UT_p_u+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/" \
        -maxdepth 1 \
        -type f \
        -name 578*.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT_p_u[@]}"
echo "${#bams_UT_p_u[@]}"
```
</details>
<br />

<a id="02d-set-up-information-for-aligned_utk_primary"></a>
#### 02d Set up information for `aligned_UTK_primary`
<a id="code-57"></a>
##### Code
<details>
<summary><i>Code: Set up information for aligned_UTK_primary</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams_UTK_prim
typeset -a bams_UTK_prim
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim[@]}"
echo "${#bams_UTK_prim[@]}"
```
</details>
<br />

<a id="03-use-a-for-loop-to-run-separate_bamsh-etc"></a>
### 03 Use a `for` loop to run `separate_bam.sh`, etc.
<a id="run-separate_bamsh-for-aligned_ut_primary_"></a>
#### Run `separate_bam.sh` for `aligned_UT_primary_*`
<a id="run-separate_bamsh"></a>
##### Run `separate_bam.sh`
<a id="code-58"></a>
###### Code
<details>
<summary><i>Code: Run separate_bam.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# bash ../../bin/separate_bam.sh

outdir="bams_UMI-dedup/aligned_UT_primary"
err_out="sh_err_out/err_out"
for i in "${bams_UT_prim[@]}"; do
    # i="${bams_UT_prim[0]}"  # echo "${i}"
    log="run_separate-bam.$(basename "${i}" .bam)"  # echo "${log}"

    bash ../../bin/separate_bam.sh \
        -u TRUE \
        -i "${i}" \
        -o "${outdir}" \
        -1 TRUE \
        -2 FALSE \
        -3 FALSE \
        -4 FALSE \
        -5 FALSE \
        -6 FALSE \
        -f TRUE \
        -l FALSE \
        -t "${SLURM_CPUS_ON_NODE}" \
            > >(tee -a "${err_out}/${log}.stdout.txt") \
            2> >(tee -a "${err_out}/${log}.stderr.txt" >&2)
done
```
</details>
<br />

<a id="run-list_tally_flags"></a>
##### Run `list_tally_flags()`
<a id="code-59"></a>
###### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset outbams
typeset -a outbams
while IFS=" " read -r -d $'\0'; do
    outbams+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UT_primary" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${outbams[@]}"
echo "${#outbams[@]}"

list_tally_flags() {
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr
}


export SHELL=$(type -p bash)
export -f list_tally_flags

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

for i in "bams_UMI-dedup/aligned_UT_primary/"*".list-tally-flags.txt"; do
    echo "${i}"
    echo "----------------------------------------"
    cat "${i}"
    echo ""
done
```
</details>
<br />

<a id="printed"></a>
###### Printed
<details>
<summary><i>Printed: Run list_tally_flags()</i></summary>

```txt
bams_UMI-dedup/aligned_UT_primary/5781_G1_IN_UT.primary.list-tally-flags.txt
----------------------------------------
6482529 83
6482529 163
5303159 99
5303159 147

bams_UMI-dedup/aligned_UT_primary/5781_G1_IP_UT.primary.list-tally-flags.txt
----------------------------------------
8316942 99
8316942 147
7871449 83
7871449 163

bams_UMI-dedup/aligned_UT_primary/5781_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
6495456 99
6495456 147
6155891 83
6155891 163

bams_UMI-dedup/aligned_UT_primary/5781_Q_IP_UT.primary.list-tally-flags.txt
----------------------------------------
10336305 83
10336305 163
10113673 99
10113673 147

bams_UMI-dedup/aligned_UT_primary/5782_G1_IN_UT.primary.list-tally-flags.txt
----------------------------------------
5685839 99
5685839 147
5560207 83
5560207 163

bams_UMI-dedup/aligned_UT_primary/5782_G1_IP_UT.primary.list-tally-flags.txt
----------------------------------------
8199512 99
8199512 147
8066610 83
8066610 163

bams_UMI-dedup/aligned_UT_primary/5782_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
5145323 83
5145323 163
4765071 99
4765071 147

bams_UMI-dedup/aligned_UT_primary/5782_Q_IP_UT.primary.list-tally-flags.txt
----------------------------------------
9456540 83
9456540 163
9179212 99
9179212 147

bams_UMI-dedup/aligned_UT_primary/BM10_DSp48_5781_UT.primary.list-tally-flags.txt
----------------------------------------
11889751 83
11889751 163
10046107 99
10046107 147

bams_UMI-dedup/aligned_UT_primary/BM11_DSp48_7080_UT.primary.list-tally-flags.txt
----------------------------------------
10650479 83
10650479 163
10639716 99
10639716 147

bams_UMI-dedup/aligned_UT_primary/BM1_DSm2_5781_UT.primary.list-tally-flags.txt
----------------------------------------
13068001 83
13068001 163
7065381 99
7065381 147

bams_UMI-dedup/aligned_UT_primary/BM2_DSm2_7080_UT.primary.list-tally-flags.txt
----------------------------------------
14350807 83
14350807 163
7205225 99
7205225 147

bams_UMI-dedup/aligned_UT_primary/BM3_DSm2_7079_UT.primary.list-tally-flags.txt
----------------------------------------
13648446 83
13648446 163
7962096 99
7962096 147

bams_UMI-dedup/aligned_UT_primary/BM4_DSp2_5781_UT.primary.list-tally-flags.txt
----------------------------------------
12672494 83
12672494 163
6245014 99
6245014 147

bams_UMI-dedup/aligned_UT_primary/BM5_DSp2_7080_UT.primary.list-tally-flags.txt
----------------------------------------
16064075 83
16064075 163
7603880 99
7603880 147

bams_UMI-dedup/aligned_UT_primary/BM6_DSp2_7079_UT.primary.list-tally-flags.txt
----------------------------------------
13772484 83
13772484 163
7954107 99
7954107 147

bams_UMI-dedup/aligned_UT_primary/BM7_DSp24_5781_UT.primary.list-tally-flags.txt
----------------------------------------
12874454 83
12874454 163
7929948 99
7929948 147

bams_UMI-dedup/aligned_UT_primary/BM8_DSp24_7080_UT.primary.list-tally-flags.txt
----------------------------------------
13099675 83
13099675 163
9557603 99
9557603 147

bams_UMI-dedup/aligned_UT_primary/BM9_DSp24_7079_UT.primary.list-tally-flags.txt
----------------------------------------
11951046 83
11951046 163
8591652 99
8591652 147

bams_UMI-dedup/aligned_UT_primary/Bp10_DSp48_5782_UT.primary.list-tally-flags.txt
----------------------------------------
10599843 83
10599843 163
9733895 99
9733895 147

bams_UMI-dedup/aligned_UT_primary/Bp11_DSp48_7081_UT.primary.list-tally-flags.txt
----------------------------------------
11760511 99
11760511 147
11111738 83
11111738 163

bams_UMI-dedup/aligned_UT_primary/Bp12_DSp48_7078_UT.primary.list-tally-flags.txt
----------------------------------------
12535615 83
12535615 163
12112967 99
12112967 147

bams_UMI-dedup/aligned_UT_primary/Bp1_DSm2_5782_UT.primary.list-tally-flags.txt
----------------------------------------
11005964 83
11005964 163
5504954 99
5504954 147

bams_UMI-dedup/aligned_UT_primary/Bp2_DSm2_7081_UT.primary.list-tally-flags.txt
----------------------------------------
13185293 83
13185293 163
6590979 99
6590979 147

bams_UMI-dedup/aligned_UT_primary/Bp3_DSm2_7078_UT.primary.list-tally-flags.txt
----------------------------------------
10756792 83
10756792 163
6363953 99
6363953 147

bams_UMI-dedup/aligned_UT_primary/Bp4_DSp2_5782_UT.primary.list-tally-flags.txt
----------------------------------------
14275244 83
14275244 163
6646268 99
6646268 147

bams_UMI-dedup/aligned_UT_primary/Bp5_DSp2_7081_UT.primary.list-tally-flags.txt
----------------------------------------
16052201 83
16052201 163
8256244 99
8256244 147

bams_UMI-dedup/aligned_UT_primary/Bp6_DSp2_7078_UT.primary.list-tally-flags.txt
----------------------------------------
12942998 83
12942998 163
7608083 99
7608083 147

bams_UMI-dedup/aligned_UT_primary/Bp7_DSp24_5782_UT.primary.list-tally-flags.txt
----------------------------------------
12928126 83
12928126 163
8233336 99
8233336 147

bams_UMI-dedup/aligned_UT_primary/Bp8_DSp24_7081_UT.primary.list-tally-flags.txt
----------------------------------------
12715638 83
12715638 163
10150380 99
10150380 147

bams_UMI-dedup/aligned_UT_primary/Bp9_DSp24_7078_UT.primary.list-tally-flags.txt
----------------------------------------
10166286 83
10166286 163
6929330 99
6929330 147

bams_UMI-dedup/aligned_UT_primary/CT10_7718_pIAA_Q_Nascent_UT.primary.list-tally-flags.txt
----------------------------------------
21136901 83
21136901 163
20958977 99
20958977 147

bams_UMI-dedup/aligned_UT_primary/CT10_7718_pIAA_Q_SteadyState_UT.primary.list-tally-flags.txt
----------------------------------------
33867077 99
33867077 147
11692160 83
11692160 163

bams_UMI-dedup/aligned_UT_primary/CT2_6125_pIAA_Q_Nascent_UT.primary.list-tally-flags.txt
----------------------------------------
21012169 83
21012169 163
20170410 99
20170410 147

bams_UMI-dedup/aligned_UT_primary/CT2_6125_pIAA_Q_SteadyState_UT.primary.list-tally-flags.txt
----------------------------------------
20998073 99
20998073 147
18525186 83
18525186 163

bams_UMI-dedup/aligned_UT_primary/CT4_6126_pIAA_Q_Nascent_UT.primary.list-tally-flags.txt
----------------------------------------
20746900 83
20746900 163
18609464 99
18609464 147

bams_UMI-dedup/aligned_UT_primary/CT4_6126_pIAA_Q_SteadyState_UT.primary.list-tally-flags.txt
----------------------------------------
24534037 99
24534037 147
16063022 83
16063022 163

bams_UMI-dedup/aligned_UT_primary/CT6_7714_pIAA_Q_Nascent_UT.primary.list-tally-flags.txt
----------------------------------------
24099430 83
24099430 163
22800248 99
22800248 147

bams_UMI-dedup/aligned_UT_primary/CT6_7714_pIAA_Q_SteadyState_UT.primary.list-tally-flags.txt
----------------------------------------
25924189 99
25924189 147
10532553 83
10532553 163

bams_UMI-dedup/aligned_UT_primary/CT8_7716_pIAA_Q_Nascent_UT.primary.list-tally-flags.txt
----------------------------------------
21475366 99
21475366 147
20775254 83
20775254 163

bams_UMI-dedup/aligned_UT_primary/CT8_7716_pIAA_Q_SteadyState_UT.primary.list-tally-flags.txt
----------------------------------------
30893568 99
30893568 147
12088337 83
12088337 163

bams_UMI-dedup/aligned_UT_primary/CU11_5782_Q_Nascent_UT.primary.list-tally-flags.txt
----------------------------------------
22547124 99
22547124 147
21326251 83
21326251 163

bams_UMI-dedup/aligned_UT_primary/CU12_5782_Q_SteadyState_UT.primary.list-tally-flags.txt
----------------------------------------
30712936 99
30712936 147
11944168 83
11944168 163

bams_UMI-dedup/aligned_UT_primary/CW10_7747_8day_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
28188490 99
28188490 147
12688795 83
12688795 163

bams_UMI-dedup/aligned_UT_primary/CW10_7747_8day_Q_PD_UT.primary.list-tally-flags.txt
----------------------------------------
18670024 83
18670024 163
17803064 99
17803064 147

bams_UMI-dedup/aligned_UT_primary/CW12_7748_8day_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
27327754 99
27327754 147
10399625 83
10399625 163

bams_UMI-dedup/aligned_UT_primary/CW12_7748_8day_Q_PD_UT.primary.list-tally-flags.txt
----------------------------------------
19621016 83
19621016 163
18928977 99
18928977 147

bams_UMI-dedup/aligned_UT_primary/CW2_5781_8day_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
25891036 99
25891036 147
12267219 83
12267219 163

bams_UMI-dedup/aligned_UT_primary/CW2_5781_8day_Q_PD_UT.primary.list-tally-flags.txt
----------------------------------------
18835231 83
18835231 163
17685889 99
17685889 147

bams_UMI-dedup/aligned_UT_primary/CW4_5782_8day_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
26212753 99
26212753 147
11828343 83
11828343 163

bams_UMI-dedup/aligned_UT_primary/CW4_5782_8day_Q_PD_UT.primary.list-tally-flags.txt
----------------------------------------
19188484 83
19188484 163
18119512 99
18119512 147

bams_UMI-dedup/aligned_UT_primary/CW6_7078_8day_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
25947639 99
25947639 147
25464464 83
25464464 163

bams_UMI-dedup/aligned_UT_primary/CW6_7078_8day_Q_PD_UT.primary.list-tally-flags.txt
----------------------------------------
19432622 83
19432622 163
18975599 99
18975599 147

bams_UMI-dedup/aligned_UT_primary/CW8_7079_8day_Q_IN_UT.primary.list-tally-flags.txt
----------------------------------------
27623599 99
27623599 147
12906718 83
12906718 163

bams_UMI-dedup/aligned_UT_primary/CW8_7079_8day_Q_PD_UT.primary.list-tally-flags.txt
----------------------------------------
18693001 83
18693001 163
18229299 99
18229299 147
```
</details>
<br />

<a id="run-separate_bamsh-etc-for-aligned_utk_primary-secondary_"></a>
#### Run `separate_bam.sh`, etc. for `aligned_UTK_primary-secondary_*`
<a id="run-separate_bamsh-1"></a>
##### Run `separate_bam.sh`
<a id="code-60"></a>
###### Code
<details>
<summary><i>Code: Run separate_bam.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# bash ../../bin/separate_bam.sh

outdir="bams_UMI-dedup/aligned_UTK_primary-secondary/"
err_out="sh_err_out/err_out"
for i in "${bams_UT_p_s[@]}"; do
    # i="${bams_UT_p_s[0]}"  # echo "${i}"
    log="run_separate-bam.primary-secondary.$(basename "${i}" .bam)"  # echo "${log}"

    bash ../../bin/separate_bam.sh \
        -u TRUE \
        -i "${i}" \
        -o "${outdir}" \
        -1 FALSE \
        -2 FALSE \
        -3 TRUE \
        -4 FALSE \
        -5 FALSE \
        -6 FALSE \
        -f TRUE \
        -l FALSE \
        -t "${SLURM_CPUS_ON_NODE}" \
            > >(tee -a "${err_out}/${log}.stdout.txt") \
            2> >(tee -a "${err_out}/${log}.stderr.txt" >&2)
done
```
</details>
<br />

<a id="run-list_tally_flags-1"></a>
##### Run `list_tally_flags()`
<a id="code-61"></a>
###### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset outbams
typeset -a outbams
while IFS=" " read -r -d $'\0'; do
    outbams+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-secondary" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${outbams[@]}"
echo "${#outbams[@]}"

list_tally_flags() {
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr
}


export SHELL=$(type -p bash)
export -f list_tally_flags

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

for i in "bams_UMI-dedup/aligned_UTK_primary-secondary/"*".list-tally-flags.txt"; do
    echo "${i}"
    echo "----------------------------------------"
    cat "${i}"
    echo ""
done
```
</details>
<br />

<a id="printed-1"></a>
###### Printed
<details>
<summary><i>Printed: Run list_tally_flags()</i></summary>

```txt
bams_UMI-dedup/aligned_UTK_primary-secondary//5781_G1_IN_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
6155381 83
6155381 163
6083730 419
6083730 339
4989735 99
4989735 147
1835994 403
1835994 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5781_G1_IP_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
7840091 99
7840091 147
7400370 83
7400370 163
2510742 419
2510742 339
1607903 403
1607903 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5781_Q_IN_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
6159928 99
6159928 147
5828590 83
5828590 163
5467097 419
5467097 339
 671376 403
 671376 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5781_Q_IP_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
9846889 83
9846889 163
9606231 99
9606231 147
2811679 419
2811679 339
 512070 403
 512070 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5782_G1_IN_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
5361718 99
5361718 147
5248329 83
5248329 163
3542438 419
3542438 339
1803137 403
1803137 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5782_G1_IP_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
7739780 99
7739780 147
7599481 83
7599481 163
2598917 419
2598917 339
1496022 403
1496022 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5782_Q_IN_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
5327576 419
5327576 339
4873200 83
4873200 163
4406470 99
4406470 147
 284910 403
 284910 355

bams_UMI-dedup/aligned_UTK_primary-secondary//5782_Q_IP_UTK.primary-secondary.list-tally-flags.txt
----------------------------------------
8965465 83
8965465 163
8671045 99
8671045 147
2310403 419
2310403 339
 446347 403
 446347 355
```
</details>
<br />

<a id="run-separate_bamsh-for-aligned_utk_primary-unmapped_"></a>
#### Run `separate_bam.sh` for `aligned_UTK_primary-unmapped_*`
<a id="run-separate_bamsh-2"></a>
##### Run `separate_bam.sh`
<a id="code-62"></a>
###### Code
<details>
<summary><i>Code: Run separate_bam.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# bash ../../bin/separate_bam.sh

outdir="bams_UMI-dedup/aligned_UTK_primary-unmapped/"
err_out="sh_err_out/err_out"
for i in "${bams_UT_p_u[@]}"; do
    # i="${bams_UT_p_u[0]}"  # echo "${i}"
    log="run_separate-bam.primary-unmapped.$(basename "${i}" .bam)"  # echo "${log}"

    bash ../../bin/separate_bam.sh \
        -u TRUE \
        -i "${i}" \
        -o "${outdir}" \
        -1 FALSE \
        -2 FALSE \
        -3 FALSE \
        -4 FALSE \
        -5 TRUE \
        -6 FALSE \
        -f TRUE \
        -l FALSE \
        -t "${SLURM_CPUS_ON_NODE}" \
            > >(tee -a "${err_out}/${log}.stdout.txt") \
            2> >(tee -a "${err_out}/${log}.stderr.txt" >&2)
done
```
</details>
<br />

<a id="run-list_tally_flags-2"></a>
##### Run `list_tally_flags()`
<a id="code-63"></a>
###### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE
#!/bin/bash
#DONTRUN #CONTINUE

unset outbams
typeset -a outbams
while IFS=" " read -r -d $'\0'; do
    outbams+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-unmapped" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${outbams[@]}"
echo "${#outbams[@]}"

list_tally_flags() {
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr
}


export SHELL=$(type -p bash)
export -f list_tally_flags

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

for i in "bams_UMI-dedup/aligned_UTK_primary-unmapped/"*".list-tally-flags.txt"; do
    echo "${i}"
    echo "----------------------------------------"
    cat "${i}"
    echo ""
done
```
</details>
<br />

<a id="printed-2"></a>
###### Printed
<details>
<summary><i>Printed: Run list_tally_flags()</i></summary>

`#NOTE` Very surprised at how few `73`, `133`, `153`, `101`, `89`, `69`, `165`, and `137` flags there are...

```txt
bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_G1_IN_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
6155381 83
6155381 163
4989735 99
4989735 147
1584849 77
1584849 141
      2 73
      2 133
      1 153
      1 101

bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_G1_IP_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
7840091 99
7840091 147
7400370 83
7400370 163
1325424 77
1325424 141

bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_Q_IN_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
6159928 99
6159928 147
5828590 83
5828590 163
 897085 77
 897085 141
      2 89
      2 69
      2 165
      2 137
      1 73
      1 133

bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_Q_IP_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
9846889 83
9846889 163
9606231 99
9606231 147
 639014 77
 639014 141
      2 89
      2 165

bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_G1_IN_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
5361718 99
5361718 147
5248329 83
5248329 163
1593849 77
1593849 141
      1 73
      1 133

bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_G1_IP_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
7739780 99
7739780 147
7599481 83
7599481 163
1200614 77
1200614 141
      2 89
      2 165

bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_Q_IN_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
4873200 83
4873200 163
4406470 99
4406470 147
 382966 77
 382966 141
      1 89
      1 165

bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_Q_IP_UTK.proper-etc.list-tally-flags.txt
----------------------------------------
8965465 83
8965465 163
8671045 99
8671045 147
 404329 77
 404329 141
      2 73
      2 133
      1 89
      1 165
```
</details>
<br />

<a id="run-separate_bamsh-for-aligned_utk_primary"></a>
#### Run `separate_bam.sh` for `aligned_UTK_primary`
<a id="run-separate_bamsh-3"></a>
##### Run `separate_bam.sh`
<a id="code-64"></a>
###### Code
<details>
<summary><i>Code: Run separate_bam.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# bash ../../bin/separate_bam.sh

outdir="bams_UMI-dedup/aligned_UTK_primary"
err_out="sh_err_out/err_out"
for i in "${bams_UTK_prim[@]}"; do
    # i="${bams_UTK_prim[0]}"  # echo "${i}"
    log="run_separate-bam.$(basename "${i}" .bam)"  # echo "${log}"

    bash ../../bin/separate_bam.sh \
        -u TRUE \
        -i "${i}" \
        -o "${outdir}" \
        -1 TRUE \
        -2 FALSE \
        -3 FALSE \
        -4 FALSE \
        -5 FALSE \
        -6 FALSE \
        -f TRUE \
        -l FALSE \
        -t "${SLURM_CPUS_ON_NODE}" \
            > >(tee -a "${err_out}/${log}.stdout.txt") \
            2> >(tee -a "${err_out}/${log}.stderr.txt" >&2)
done
```
</details>
<br />

<a id="run-list_tally_flags-3"></a>
##### Run `list_tally_flags()`
<a id="code-65"></a>
###### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset outbams
typeset -a outbams
while IFS=" " read -r -d $'\0'; do
    outbams+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${outbams[@]}"
echo "${#outbams[@]}"

list_tally_flags() {
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr
}


export SHELL=$(type -p bash)
export -f list_tally_flags

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${outbams[@]}"

for i in "bams_UMI-dedup/aligned_UTK_primary/"*".list-tally-flags.txt"; do
    echo "${i}"
    echo "----------------------------------------"
    cat "${i}"
    echo ""
done
```
</details>
<br />

<a id="printed-3"></a>
###### Printed
<details>
<summary><i>Printed: Run list_tally_flags()</i></summary>

```txt
bams_UMI-dedup/aligned_UTK_primary/5781_G1_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
6155381 83
6155381 163
4989735 99
4989735 147

bams_UMI-dedup/aligned_UTK_primary/5781_G1_IP_UTK.primary.list-tally-flags.txt
----------------------------------------
7840091 99
7840091 147
7400370 83
7400370 163

bams_UMI-dedup/aligned_UTK_primary/5781_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
6159928 99
6159928 147
5828590 83
5828590 163

bams_UMI-dedup/aligned_UTK_primary/5781_Q_IP_UTK.primary.list-tally-flags.txt
----------------------------------------
9846889 83
9846889 163
9606231 99
9606231 147

bams_UMI-dedup/aligned_UTK_primary/5782_G1_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
5361718 99
5361718 147
5248329 83
5248329 163

bams_UMI-dedup/aligned_UTK_primary/5782_G1_IP_UTK.primary.list-tally-flags.txt
----------------------------------------
7739780 99
7739780 147
7599481 83
7599481 163

bams_UMI-dedup/aligned_UTK_primary/5782_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
4873200 83
4873200 163
4406470 99
4406470 147

bams_UMI-dedup/aligned_UTK_primary/5782_Q_IP_UTK.primary.list-tally-flags.txt
----------------------------------------
8965465 83
8965465 163
8671045 99
8671045 147

bams_UMI-dedup/aligned_UTK_primary/BM10_DSp48_5781_UTK.primary.list-tally-flags.txt
----------------------------------------
11507943 83
11507943 163
9754417 99
9754417 147

bams_UMI-dedup/aligned_UTK_primary/BM11_DSp48_7080_UTK.primary.list-tally-flags.txt
----------------------------------------
10316243 99
10316243 147
10279077 83
10279077 163

bams_UMI-dedup/aligned_UTK_primary/BM1_DSm2_5781_UTK.primary.list-tally-flags.txt
----------------------------------------
12528353 83
12528353 163
6610104 99
6610104 147

bams_UMI-dedup/aligned_UTK_primary/BM2_DSm2_7080_UTK.primary.list-tally-flags.txt
----------------------------------------
13812692 83
13812692 163
6766506 99
6766506 147

bams_UMI-dedup/aligned_UTK_primary/BM3_DSm2_7079_UTK.primary.list-tally-flags.txt
----------------------------------------
13046181 83
13046181 163
7453786 99
7453786 147

bams_UMI-dedup/aligned_UTK_primary/BM4_DSp2_5781_UTK.primary.list-tally-flags.txt
----------------------------------------
12207583 83
12207583 163
5844429 99
5844429 147

bams_UMI-dedup/aligned_UTK_primary/BM5_DSp2_7080_UTK.primary.list-tally-flags.txt
----------------------------------------
15494352 83
15494352 163
7128296 99
7128296 147

bams_UMI-dedup/aligned_UTK_primary/BM6_DSp2_7079_UTK.primary.list-tally-flags.txt
----------------------------------------
13203719 83
13203719 163
7467622 99
7467622 147

bams_UMI-dedup/aligned_UTK_primary/BM7_DSp24_5781_UTK.primary.list-tally-flags.txt
----------------------------------------
12444589 83
12444589 163
7608842 99
7608842 147

bams_UMI-dedup/aligned_UTK_primary/BM8_DSp24_7080_UTK.primary.list-tally-flags.txt
----------------------------------------
12627948 83
12627948 163
9151888 99
9151888 147

bams_UMI-dedup/aligned_UTK_primary/BM9_DSp24_7079_UTK.primary.list-tally-flags.txt
----------------------------------------
11475576 83
11475576 163
8173191 99
8173191 147

bams_UMI-dedup/aligned_UTK_primary/Bp10_DSp48_5782_UTK.primary.list-tally-flags.txt
----------------------------------------
10255593 83
10255593 163
9460987 99
9460987 147

bams_UMI-dedup/aligned_UTK_primary/Bp11_DSp48_7081_UTK.primary.list-tally-flags.txt
----------------------------------------
11447800 99
11447800 147
10743574 83
10743574 163

bams_UMI-dedup/aligned_UTK_primary/Bp12_DSp48_7078_UTK.primary.list-tally-flags.txt
----------------------------------------
12084656 83
12084656 163
11752284 99
11752284 147

bams_UMI-dedup/aligned_UTK_primary/Bp1_DSm2_5782_UTK.primary.list-tally-flags.txt
----------------------------------------
10555966 83
10555966 163
5139680 99
5139680 147

bams_UMI-dedup/aligned_UTK_primary/Bp2_DSm2_7081_UTK.primary.list-tally-flags.txt
----------------------------------------
12683705 83
12683705 163
6185733 99
6185733 147

bams_UMI-dedup/aligned_UTK_primary/Bp3_DSm2_7078_UTK.primary.list-tally-flags.txt
----------------------------------------
10293732 83
10293732 163
5975466 99
5975466 147

bams_UMI-dedup/aligned_UTK_primary/Bp4_DSp2_5782_UTK.primary.list-tally-flags.txt
----------------------------------------
13778838 83
13778838 163
6221136 99
6221136 147

bams_UMI-dedup/aligned_UTK_primary/Bp5_DSp2_7081_UTK.primary.list-tally-flags.txt
----------------------------------------
15473797 83
15473797 163
7760313 99
7760313 147

bams_UMI-dedup/aligned_UTK_primary/Bp6_DSp2_7078_UTK.primary.list-tally-flags.txt
----------------------------------------
12407079 83
12407079 163
7146344 99
7146344 147

bams_UMI-dedup/aligned_UTK_primary/Bp7_DSp24_5782_UTK.primary.list-tally-flags.txt
----------------------------------------
12492238 83
12492238 163
7894263 99
7894263 147

bams_UMI-dedup/aligned_UTK_primary/Bp8_DSp24_7081_UTK.primary.list-tally-flags.txt
----------------------------------------
12264942 83
12264942 163
9752610 99
9752610 147

bams_UMI-dedup/aligned_UTK_primary/Bp9_DSp24_7078_UTK.primary.list-tally-flags.txt
----------------------------------------
9790152 83
9790152 163
6606567 99
6606567 147

bams_UMI-dedup/aligned_UTK_primary/CT10_7718_pIAA_Q_Nascent_UTK.primary.list-tally-flags.txt
----------------------------------------
20102777 83
20102777 163
19916541 99
19916541 147

bams_UMI-dedup/aligned_UTK_primary/CT10_7718_pIAA_Q_SteadyState_UTK.primary.list-tally-flags.txt
----------------------------------------
33249881 99
33249881 147
11291083 83
11291083 163

bams_UMI-dedup/aligned_UTK_primary/CT2_6125_pIAA_Q_Nascent_UTK.primary.list-tally-flags.txt
----------------------------------------
19981272 83
19981272 163
19102654 99
19102654 147

bams_UMI-dedup/aligned_UTK_primary/CT2_6125_pIAA_Q_SteadyState_UTK.primary.list-tally-flags.txt
----------------------------------------
20475438 99
20475438 147
17925924 83
17925924 163

bams_UMI-dedup/aligned_UTK_primary/CT4_6126_pIAA_Q_Nascent_UTK.primary.list-tally-flags.txt
----------------------------------------
19709935 83
19709935 163
17543729 99
17543729 147

bams_UMI-dedup/aligned_UTK_primary/CT4_6126_pIAA_Q_SteadyState_UTK.primary.list-tally-flags.txt
----------------------------------------
24054088 99
24054088 147
15590848 83
15590848 163

bams_UMI-dedup/aligned_UTK_primary/CT6_7714_pIAA_Q_Nascent_UTK.primary.list-tally-flags.txt
----------------------------------------
22949321 83
22949321 163
21658382 99
21658382 147

bams_UMI-dedup/aligned_UTK_primary/CT6_7714_pIAA_Q_SteadyState_UTK.primary.list-tally-flags.txt
----------------------------------------
25397718 99
25397718 147
10161043 83
10161043 163

bams_UMI-dedup/aligned_UTK_primary/CT8_7716_pIAA_Q_Nascent_UTK.primary.list-tally-flags.txt
----------------------------------------
20359236 99
20359236 147
19710242 83
19710242 163

bams_UMI-dedup/aligned_UTK_primary/CT8_7716_pIAA_Q_SteadyState_UTK.primary.list-tally-flags.txt
----------------------------------------
30266543 99
30266543 147
11652015 83
11652015 163

bams_UMI-dedup/aligned_UTK_primary/CU11_5782_Q_Nascent_UTK.primary.list-tally-flags.txt
----------------------------------------
21396043 99
21396043 147
20224117 83
20224117 163

bams_UMI-dedup/aligned_UTK_primary/CU12_5782_Q_SteadyState_UTK.primary.list-tally-flags.txt
----------------------------------------
30125466 99
30125466 147
11530024 83
11530024 163

bams_UMI-dedup/aligned_UTK_primary/CW10_7747_8day_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
27655519 99
27655519 147
12279657 83
12279657 163

bams_UMI-dedup/aligned_UTK_primary/CW10_7747_8day_Q_PD_UTK.primary.list-tally-flags.txt
----------------------------------------
17667079 83
17667079 163
16804225 99
16804225 147

bams_UMI-dedup/aligned_UTK_primary/CW12_7748_8day_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
26818582 99
26818582 147
10043502 83
10043502 163

bams_UMI-dedup/aligned_UTK_primary/CW12_7748_8day_Q_PD_UTK.primary.list-tally-flags.txt
----------------------------------------
18594300 83
18594300 163
17897197 99
17897197 147

bams_UMI-dedup/aligned_UTK_primary/CW2_5781_8day_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
25397463 99
25397463 147
11863396 83
11863396 163

bams_UMI-dedup/aligned_UTK_primary/CW2_5781_8day_Q_PD_UTK.primary.list-tally-flags.txt
----------------------------------------
17806842 83
17806842 163
16673661 99
16673661 147

bams_UMI-dedup/aligned_UTK_primary/CW4_5782_8day_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
25711706 99
25711706 147
11435174 83
11435174 163

bams_UMI-dedup/aligned_UTK_primary/CW4_5782_8day_Q_PD_UTK.primary.list-tally-flags.txt
----------------------------------------
18187278 83
18187278 163
17126533 99
17126533 147

bams_UMI-dedup/aligned_UTK_primary/CW6_7078_8day_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
25430388 99
25430388 147
24807749 83
24807749 163

bams_UMI-dedup/aligned_UTK_primary/CW6_7078_8day_Q_PD_UTK.primary.list-tally-flags.txt
----------------------------------------
18347772 83
18347772 163
17894680 99
17894680 147

bams_UMI-dedup/aligned_UTK_primary/CW8_7079_8day_Q_IN_UTK.primary.list-tally-flags.txt
----------------------------------------
27048757 99
27048757 147
12422129 83
12422129 163

bams_UMI-dedup/aligned_UTK_primary/CW8_7079_8day_Q_PD_UTK.primary.list-tally-flags.txt
----------------------------------------
17634392 83
17634392 163
17172036 99
17172036 147
```
</details>
<br />

<a id="04-use-gnu-parallel-to-run-samtools-index"></a>
### 04 Use `GNU parallel` to run `samtools index`
`#HERE`
<a id="get-all-bams-in--and-outfiles-into-a-single-array"></a>
#### Get all bams (in- and outfiles) into a single array
<a id="code-66"></a>
##### Code
<details>
<summary><i>Code: Get all bams (in- and outfiles) into a single array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ./bams_UMI-dedup \
    || echo "cd'ing failed; check on this..."

unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find . \
        -maxdepth 2 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams[@]}"
echo "${#bams[@]}"
```
</details>
<br />

<a id="run-samtools-index"></a>
#### Run `samtools index`
<a id="code-67"></a>
##### Code
<details>
<summary><i>Code: Run samtools index</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -k \
    -j 4 \
    --dry-run \
    "samtools index -@ 4 {}" \
::: "${bams[@]}"

parallel \
    -k \
    -j 4 \
    "samtools index -@ 4 {}" \
::: "${bams[@]}"
```
</details>
<br />
<br />

<a id="vii-deduplicate-primary-files-by-umi-position-general"></a>
## <u>VII</u> Deduplicate "primary" files by UMI, position *(general)*
<a id="01-get-situated-make-directories-for-outfiles-1"></a>
### 01 Get situated, make directories for outfiles
<details>
<summary><i>Code: Get situated, make directories for outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 16, etc.

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate Trinity_env
module purge
module load UMI-tools/1.0.1-foss-2019b-Python-3.7.4

#  Make directories for outfiles
mkdir -p "./bams_UMI-dedup/aligned_UT_primary_dedup-UMI"
mkdir -p "./bams_UMI-dedup/aligned_UT_primary_dedup-pos"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary_dedup-pos"
```
</details>
<br />

<a id="02-process-aligned_ut_primary-data"></a>
### 02 Process `aligned_UT_primary` data
<a id="02a-set-up-necessary-variables-arrays"></a>
#### 02a Set up necessary variables, arrays
<a id="code-68"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset inbams
typeset -a inbams
while IFS=" " read -r -d $'\0'; do
    inbams+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UT_primary/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams[@]}"
echo "${#inbams[@]}"

unset outbams_UMI
unset outbams_pos
typeset -a outbams_UMI
typeset -a outbams_pos
for i in "${inbams[@]}"; do
    # i="${inbams[0]}"  # echo "${i}"
    stem="$(basename "${i}" .bam)"  # echo "${stem}"
    outbams_UMI+=( "./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/${stem}.dedup-UMI.bam" )
    outbams_pos+=( "./bams_UMI-dedup/aligned_UT_primary_dedup-pos/${stem}.dedup-pos.bam" )
done
echo_test "${outbams_UMI[@]}"
echo_test "${outbams_pos[@]}"
echo "${#outbams_UMI[@]}"
echo "${#outbams_pos[@]}"
```
</details>
<br />

<a id="02b-use-gnu-parallel-to-run-umi_tools-dedup-for-umi-and-positional-deduplication"></a>
#### 02b Use `GNU parallel` to run `umi_tools dedup` for UMI and positional deduplication
<a id="use-gnu-parallel-to-run-umi_tools-dedup-for-umi-deduplication"></a>
##### Use `GNU parallel` to run `umi_tools dedup` for UMI deduplication
<a id="code-69"></a>
###### Code
<details>
<summary><i>Code: Use GNU parallel to run umi_tools dedup for UMI deduplication</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'umi_tools dedup \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --output-stats={2.}.stats \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_UMI[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    'umi_tools dedup \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --output-stats={2.}.stats \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_UMI[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"
```
</details>
<br />

<a id="use-gnu-parallel-to-run-umi_tools-dedup-for-positional-deduplication"></a>
##### Use `GNU parallel` to run `umi_tools dedup` for positional deduplication
<a id="code-70"></a>
###### Code
<details>
<summary><i>Code: Use GNU parallel to run umi_tools dedup for positional deduplication</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'umi_tools dedup \
        --ignore-umi \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_pos[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    'umi_tools dedup \
        --ignore-umi \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_pos[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"
```
</details>
<br />

<a id="03-process-aligned_utk_primary-data"></a>
### 03 Process `aligned_UTK_primary` data
<a id="03a-set-up-necessary-variables-arrays"></a>
#### 03a Set up necessary variables, arrays
<a id="code-71"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset inbams
typeset -a inbams
while IFS=" " read -r -d $'\0'; do
    inbams+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams[@]}"
echo "${#inbams[@]}"

unset outbams_UMI
unset outbams_pos
typeset -a outbams_UMI
typeset -a outbams_pos
for i in "${inbams[@]}"; do
    # i="${inbams[0]}"  # echo "${i}"
    stem="$(basename "${i}" .bam)"  # echo "${stem}"
    outbams_UMI+=( "./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/${stem}.dedup-UMI.bam" )
    outbams_pos+=( "./bams_UMI-dedup/aligned_UTK_primary_dedup-pos/${stem}.dedup-pos.bam" )
done
echo_test "${outbams_UMI[@]}"
echo_test "${outbams_pos[@]}"
echo "${#outbams_UMI[@]}"
echo "${#outbams_pos[@]}"
```
</details>
<br />

<a id="03b-use-gnu-parallel-to-run-umi_tools-dedup-for-umi-and-positional-deduplication"></a>
#### 03b Use `GNU parallel` to run `umi_tools dedup` for UMI and positional deduplication
<a id="use-gnu-parallel-to-run-umi_tools-dedup-for-umi-deduplication-1"></a>
##### Use `GNU parallel` to run `umi_tools dedup` for UMI deduplication
<a id="code-72"></a>
###### Code
<details>
<summary><i>Code: Use GNU parallel to run umi_tools dedup for UMI deduplication</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'umi_tools dedup \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --output-stats={2.}.stats \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_UMI[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    'umi_tools dedup \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --output-stats={2.}.stats \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_UMI[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"
```
</details>
<br />

<a id="use-gnu-parallel-to-run-umi_tools-dedup-for-positional-deduplication-1"></a>
##### Use `GNU parallel` to run `umi_tools dedup` for positional deduplication
<a id="code-73"></a>
###### Code
<details>
<summary><i>Code: Use GNU parallel to run umi_tools dedup for positional deduplication</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'umi_tools dedup \
        --ignore-umi \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_pos[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    'umi_tools dedup \
        --ignore-umi \
        --paired \
        --spliced-is-unique \
        --unmapped-reads=discard \
        --stdin={1} \
        --stdout={2} \
        --temp-dir={3} \
        --log={2.}.stdout.txt \
        --error={2.}.stderr.txt \
        --timeit={2.}.time.txt \
        --timeit-header' \
::: "${inbams[@]}" \
:::+ "${outbams_pos[@]}" \
::: "/fh/scratch/delete30/tsukiyama_t"
```
</details>
<br />

<a id="04-use-gnu-parallel-to-run-samtools-index-1"></a>
### 04 Use `GNU parallel` to run `samtools index`
`#HERE` `#DEKHO`
<a id="get-all-bams-in--and-outfiles-into-a-single-array-1"></a>
#### Get all bams (in- and outfiles) into a single array
<a id="code-74"></a>
##### Code
<details>
<summary><i>Code: Get all bams (in- and outfiles) into a single array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

module purge
module load SAMtools/1.16.1-GCC-11.2.0

cd ./bams_UMI-dedup \
    || echo "cd'ing failed; check on this..."

unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find . \
        -maxdepth 2 \
        -type f \
        -name *dedup*.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams[@]}"
echo "${#bams[@]}"
```
</details>
<br />

<a id="run-samtools-index-1"></a>
#### Run `samtools index`
<a id="code-75"></a>
##### Code
<details>
<summary><i>Code: Run samtools index</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -k \
    -j 4 \
    --dry-run \
    "samtools index -@ 8 {}" \
::: "${bams[@]}"

parallel \
    -k \
    -j 4 \
    "samtools index -@ 8 {}" \
::: "${bams[@]}"
```
</details>
<br />
<br />

<a id="viii-separate-out-alignments-to-different-species-trinity"></a>
## <u>VIII</u> Separate out alignments to different species *(Trinity)*
<a id="01-get-situated-make-directories-for-outfiles-2"></a>
### 01 Get situated, make directories for outfiles
<a id="code-76"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directories for outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 16, etc.

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate Trinity_env
module purge
module load SAMtools/1.16.1-GCC-11.2.0

#  Make directories for outfiles
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S"
```
</details>
<br />

<a id="02-set-up-necessary-variables-arrays-1"></a>
### 02 Set up necessary variables, arrays
<a id="code-77"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  primary + secondary (Trinity GG): exclude K. lactis and 20S alignments -----
unset inbams_ps
typeset -a inbams_ps
while IFS=" " read -r -d $'\0'; do
    inbams_ps+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary-secondary" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams_ps[@]}"
echo "${#inbams_ps[@]}"

outdir_ps="./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S"


#  primary + unmapped (Trinity GF): exclude K. lactis and 20S alignments ------
unset inbams_pu
typeset -a inbams_pu
while IFS=" " read -r -d $'\0'; do
    inbams_pu+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary-unmapped" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams_pu[@]}"
echo "${#inbams_pu[@]}"

outdir_pu="./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S"
```
</details>
<br />

<a id="03-use-gnu-parallel-to-split-bams-by-species"></a>
### 03 Use `GNU parallel` to split bams by species
<a id="code-78"></a>
#### Code
<details>
<summary><i>Code: Use GNU parallel to split bams by species</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  primary + secondary (Trinity GG): exclude K. lactis and 20S alignments -----
parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_ps[@]}" \
::: "${outdir_ps}"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_ps[@]}" \
::: "${outdir_ps}"

#  primary + unmapped (Trinity GF): exclude K. lactis and 20S alignments ------
parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_pu[@]}" \
::: "${outdir_pu}"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_pu[@]}" \
::: "${outdir_pu}"
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: </i></summary>

```txt
❯ parallel \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
> ::: "${inbams_ps[@]}" \
> ::: "${outdir_ps}"
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5781_G1_IN_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IN_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5781_G1_IP_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IP_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5781_Q_IN_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IN_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5781_Q_IP_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IP_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5782_G1_IN_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IN_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5782_G1_IP_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IP_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5782_Q_IN_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IN_UTK.primary-secondary.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-secondary/5782_Q_IP_UTK.primary-secondary.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IP_UTK.primary-secondary.SC.bam


❯ parallel \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
> ::: "${inbams_pu[@]}" \
> ::: "${outdir_pu}"
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_G1_IN_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IN_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_G1_IP_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IP_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_Q_IN_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IN_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5781_Q_IP_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IP_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_G1_IN_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IN_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_G1_IP_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IP_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_Q_IN_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IN_UTK.proper-etc.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary-unmapped/5782_Q_IP_UTK.proper-etc.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IP_UTK.proper-etc.SC.bam
```
</details>
<br />
<br />

<a id="ix-merge-bams-trinity"></a>
## <u>IX</u> Merge bams *(Trinity)*
<a id="01-get-situated-make-directories-for-outfiles-3"></a>
### 01 Get situated, make directories for outfiles
<a id="code-79"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directories for outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 16, etc.

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate Trinity_env
module purge
module load SAMtools/1.16.1-GCC-11.2.0

#  Make directories for outfiles
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged"
```
</details>
<br />

<a id="02-set-up-necessary-variables-arrays-2"></a>
### 02 Set up necessary variables, arrays
<a id="code-80"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  primary + secondary (Trinity GG): exclude K. lactis and 20S alignments -----
indir_ps="./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S"
outdir_ps="./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged"

unset inbams_ps
typeset -A inbams_ps
inbams_ps["${indir_ps}/5781_G1_IN_UTK.primary-secondary.SC.bam"]="${indir_ps}/5782_G1_IN_UTK.primary-secondary.SC.bam___${outdir_ps}/merged_G1_IN_UTK.primary-secondary.SC.bam"
inbams_ps["${indir_ps}/5781_G1_IP_UTK.primary-secondary.SC.bam"]="${indir_ps}/5782_G1_IP_UTK.primary-secondary.SC.bam___${outdir_ps}/merged_G1_IP_UTK.primary-secondary.SC.bam"
inbams_ps["${indir_ps}/5781_Q_IN_UTK.primary-secondary.SC.bam"]="${indir_ps}/5782_Q_IN_UTK.primary-secondary.SC.bam___${outdir_ps}/merged_Q_IN_UTK.primary-secondary.SC.bam"
inbams_ps["${indir_ps}/5781_Q_IP_UTK.primary-secondary.SC.bam"]="${indir_ps}/5782_Q_IP_UTK.primary-secondary.SC.bam___${outdir_ps}/merged_Q_IP_UTK.primary-secondary.SC.bam"

unset i_1_ps
unset i_2_ps
unset out_ps
typeset -a i_1_ps
typeset -a i_2_ps
typeset -a out_ps
for i in "${!inbams_ps[@]}"; do
    value_1="$(echo "${inbams_ps[$i]}" | awk -F '___' '{ print $1 }')"
    value_2="$(echo "${inbams_ps[$i]}" | awk -F '___' '{ print $2 }')"
    echo "    Key (i 1): ${i}"
    echo "Value 1 (i 2): ${value_1}"
    echo "Value 2 (out): ${value_2}"
    echo ""
    i_1_ps+=( "${i}" )
    i_2_ps+=( "${value_1}" )
    out_ps+=( "${value_2}" )
done
echo_test "${i_1_ps[@]}"
echo_test "${i_2_ps[@]}"
echo_test "${out_ps[@]}"


#  primary + unmapped (Trinity GF): exclude K. lactis and 20S alignments ------
indir_pu="./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S"
outdir_pu="./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged"

unset inbams_pu
typeset -A inbams_pu
inbams_pu["${indir_pu}/5781_G1_IN_UTK.proper-etc.SC.bam"]="${indir_pu}/5782_G1_IN_UTK.proper-etc.SC.bam___${outdir_pu}/merged_G1_IN_UTK.proper-etc.SC.bam"
inbams_pu["${indir_pu}/5781_G1_IP_UTK.proper-etc.SC.bam"]="${indir_pu}/5782_G1_IP_UTK.proper-etc.SC.bam___${outdir_pu}/merged_G1_IP_UTK.proper-etc.SC.bam"
inbams_pu["${indir_pu}/5781_Q_IN_UTK.proper-etc.SC.bam"]="${indir_pu}/5782_Q_IN_UTK.proper-etc.SC.bam___${outdir_pu}/merged_Q_IN_UTK.proper-etc.SC.bam"
inbams_pu["${indir_pu}/5781_Q_IP_UTK.proper-etc.SC.bam"]="${indir_pu}/5782_Q_IP_UTK.proper-etc.SC.bam___${outdir_pu}/merged_Q_IP_UTK.proper-etc.SC.bam"

unset i_1_pu
unset i_2_pu
unset out_pu
typeset -a i_1_pu
typeset -a i_2_pu
typeset -a out_pu
for i in "${!inbams_pu[@]}"; do
    value_1="$(echo "${inbams_pu[$i]}" | awk -F '___' '{ print $1 }')"
    value_2="$(echo "${inbams_pu[$i]}" | awk -F '___' '{ print $2 }')"
    echo "    Key (i 1): ${i}"
    echo "Value 1 (i 2): ${value_1}"
    echo "Value 2 (out): ${value_2}"
    echo ""
    i_1_pu+=( "${i}" )
    i_2_pu+=( "${value_1}" )
    out_pu+=( "${value_2}" )
done
echo_test "${i_1_pu[@]}"
echo_test "${i_2_pu[@]}"
echo_test "${out_pu[@]}"
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: Set up necessary variables, arrays</i></summary>

```txt
❯ for i in "${!inbams_ps[@]}"; do
>     value_1="$(echo "${inbams_ps[$i]}" | awk -F '___' '{ print $1 }')"
>     value_2="$(echo "${inbams_ps[$i]}" | awk -F '___' '{ print $2 }')"
>     echo "    Key (i 1): ${i}"
>     echo "Value 1 (i 2): ${value_1}"
>     echo "Value 2 (out): ${value_2}"
>     echo ""
>     i_1_ps+=( "${i}" )
>     i_2_ps+=( "${value_1}" )
>     out_ps+=( "${value_2}" )
> done
    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IP_UTK.primary-secondary.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IP_UTK.primary-secondary.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam

    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IN_UTK.primary-secondary.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IN_UTK.primary-secondary.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam

    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IN_UTK.primary-secondary.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IN_UTK.primary-secondary.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam

    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IP_UTK.primary-secondary.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IP_UTK.primary-secondary.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam


❯ echo_test "${i_1_ps[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IP_UTK.primary-secondary.SC.bam


❯ echo_test "${i_2_ps[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IP_UTK.primary-secondary.SC.bam


❯ echo_test "${out_ps[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam


❯ for i in "${!inbams_pu[@]}"; do
>     value_1="$(echo "${inbams_pu[$i]}" | awk -F '___' '{ print $1 }')"
>     value_2="$(echo "${inbams_pu[$i]}" | awk -F '___' '{ print $2 }')"
>     echo "    Key (i 1): ${i}"
>     echo "Value 1 (i 2): ${value_1}"
>     echo "Value 2 (out): ${value_2}"
>     echo ""
>     i_1_pu+=( "${i}" )
>     i_2_pu+=( "${value_1}" )
>     out_pu+=( "${value_2}" )
> done
    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IP_UTK.proper-etc.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IP_UTK.proper-etc.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IP_UTK.proper-etc.SC.bam

    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IN_UTK.proper-etc.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IN_UTK.proper-etc.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IN_UTK.proper-etc.SC.bam

    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IN_UTK.proper-etc.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IN_UTK.proper-etc.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IN_UTK.proper-etc.SC.bam

    Key (i 1): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IP_UTK.proper-etc.SC.bam
Value 1 (i 2): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IP_UTK.proper-etc.SC.bam
Value 2 (out): ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IP_UTK.proper-etc.SC.bam


❯ echo_test "${i_1_pu[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IP_UTK.proper-etc.SC.bam


❯ echo_test "${i_2_pu[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IP_UTK.proper-etc.SC.bam


❯ echo_test "${out_pu[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IP_UTK.proper-etc.SC.bam
```
</details>
<br />

<a id="03-use-gnu-parallel-to-run-samtools-merge"></a>
### 03 Use `GNU parallel` to run `samtools merge`
<a id="code-81"></a>
#### Code
<details>
<summary><i>Code: Use GNU parallel to run samtools merge</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  primary + secondary (Trinity GG): exclude K. lactis and 20S alignments -----
parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "samtools merge -@ 4 {1} {2} -o {3}" \
::: "${i_1_ps[@]}" \
:::+ "${i_2_ps[@]}" \
:::+ "${out_ps[@]}"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    "samtools merge -@ 4 {1} {2} -o {3}" \
::: "${i_1_ps[@]}" \
:::+ "${i_2_ps[@]}" \
:::+ "${out_ps[@]}"


#  primary + unmapped (Trinity GF): exclude K. lactis and 20S alignments ------
parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "samtools merge -@ 4 {1} {2} -o {3}" \
::: "${i_1_pu[@]}" \
:::+ "${i_2_pu[@]}" \
:::+ "${out_pu[@]}"

parallel \
    -j "${SLURM_CPUS_ON_NODE}" \
    "samtools merge -@ 4 {1} {2} -o {3}" \
::: "${i_1_pu[@]}" \
:::+ "${i_2_pu[@]}" \
:::+ "${out_pu[@]}"
```
</details>
<br />

<a id="printed-6"></a>
#### Printed
<details>
<summary><i>Printed: Run samtools merge</i></summary>

```txt
❯ parallel \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     "samtools merge -@ 4 {1} {2} -o {3}" \
> ::: "${i_1_ps[@]}" \
> :::+ "${i_2_ps[@]}" \
> :::+ "${out_ps[@]}"
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IP_UTK.primary-secondary.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IP_UTK.primary-secondary.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IN_UTK.primary-secondary.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IN_UTK.primary-secondary.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IN_UTK.primary-secondary.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IN_UTK.primary-secondary.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IP_UTK.primary-secondary.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IP_UTK.primary-secondary.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam


❯ parallel \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     "samtools merge -@ 4 {1} {2} -o {3}" \
> ::: "${i_1_pu[@]}" \
> :::+ "${i_2_pu[@]}" \
> :::+ "${out_pu[@]}"
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IP_UTK.proper-etc.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IP_UTK.proper-etc.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IP_UTK.proper-etc.SC.bam
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IN_UTK.proper-etc.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IN_UTK.proper-etc.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IN_UTK.proper-etc.SC.bam
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IN_UTK.proper-etc.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IN_UTK.proper-etc.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IN_UTK.proper-etc.SC.bam
samtools merge -@ 4 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IP_UTK.proper-etc.SC.bam ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IP_UTK.proper-etc.SC.bam -o ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IP_UTK.proper-etc.SC.bam
```
</details>
<br />
<br />

<a id="x-perform-bam-to-fastq-conversions-trinity"></a>
## <u>X</u> Perform bam-to-fastq conversions *(Trinity)*
<a id="01-get-situated-make-directories-for-outfiles-4"></a>
### 01 Get situated, make directories for outfiles
<a id="code-82"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directories for outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 16, etc.

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate Trinity_env
module purge
module load SAMtools/1.16.1-GCC-11.2.0

#  Make directories for outfiles
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq"
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq"
```
</details>
<br />

<a id="02-set-up-necessary-variables-arrays-3"></a>
### 02 Set up necessary variables, arrays
<a id="code-83"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  What is what -----------------------
# pS aligned_UTK_primary-secondary_sans-KL-20S/
# pSm aligned_UTK_primary-secondary_sans-KL-20S_merged/
# pU aligned_UTK_primary-unmapped_sans-KL-20S/
# pUm aligned_UTK_primary-unmapped_sans-KL-20S_merged/
#
# pS_o aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/
# pSm_o aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/
# pU_o aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/
# pUm_o aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/


#  pS ---------------------------------
unset pS
typeset -a pS
while IFS=" " read -r -d $'\0'; do
    pS+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${pS[@]}"
echo "${#pS[@]}"

unset pS_o
typeset -a pS_o
for i in "${pS[@]}"; do
    stem="$(basename "${i}" .bam)"
    pS_o+=( "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/${stem}" )
done
echo_test "${pS_o[@]}"
echo "${#pS_o[@]}"


#  pSm --------------------------------
unset pSm
typeset -a pSm
while IFS=" " read -r -d $'\0'; do
    pSm+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${pSm[@]}"
echo "${#pSm[@]}"

unset pSm_o
typeset -a pSm_o
for i in "${pSm[@]}"; do
    stem="$(basename "${i}" .bam)"
    pSm_o+=( "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/${stem}" )
done
echo_test "${pSm_o[@]}"
echo "${#pSm_o[@]}"


#  pU ---------------------------------
unset pU
typeset -a pU
while IFS=" " read -r -d $'\0'; do
    pU+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${pU[@]}"
echo "${#pU[@]}"

unset pU_o
typeset -a pU_o
for i in "${pU[@]}"; do
    stem="$(basename "${i}" .bam)"
    pU_o+=( "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/${stem}" )
done
echo_test "${pU_o[@]}"
echo "${#pU_o[@]}"


#  pUm --------------------------------
unset pUm
typeset -a pUm
while IFS=" " read -r -d $'\0'; do
    pUm+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${pUm[@]}"
echo "${#pUm[@]}"

unset pUm_o
typeset -a pUm_o
for i in "${pUm[@]}"; do
    stem="$(basename "${i}" .bam)"
    pUm_o+=( "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/${stem}" )
done
echo_test "${pUm_o[@]}"
echo "${#pUm_o[@]}"
```
</details>
<br />

<a id="printed-7"></a>
#### Printed
<details>
<summary><i>Printed: </i></summary>

```txt
❯ #  pS ---------------------------------
❯ while IFS=" " read -r -d $'\0'; do
>     pS+=( "${REPLY}" )
> done < <(\
>     find "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/" \
>         -maxdepth 1 \
>         -type f \
>         -name *.bam \
>         -print0 \
>             | sort -z \
> )

❯ echo_test "${pS[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IP_UTK.primary-secondary.SC.bam

❯ echo "${#pS[@]}"
8

❯ for i in "${pS[@]}"; do
>     stem="$(basename "${i}" .bam)"
>     pS_o+=( "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/${stem}" )
> done

❯ echo_test "${pS_o[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.primary-secondary.SC

❯ echo "${#pS_o[@]}"
8


❯ #  pSm --------------------------------
❯ while IFS=" " read -r -d $'\0'; do
>     pSm+=( "${REPLY}" )
> done < <(\
>     find "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/" \
>         -maxdepth 1 \
>         -type f \
>         -name *.bam \
>         -print0 \
>             | sort -z \
> )

❯ echo_test "${pSm[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam

❯ echo "${#pSm[@]}"
4

❯ for i in "${pSm[@]}"; do
>     stem="$(basename "${i}" .bam)"
>     pSm_o+=( "./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/${stem}" )
> done

❯ echo_test "${pSm_o[@]}"
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IP_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IN_UTK.primary-secondary.SC
./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.primary-secondary.SC

❯ echo "${#pSm_o[@]}"
4


❯ #  pU ---------------------------------
❯ while IFS=" " read -r -d $'\0'; do
>     pU+=( "${REPLY}" )
> done < <(\
>     find "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/" \
>         -maxdepth 1 \
>         -type f \
>         -name *.bam \
>         -print0 \
>             | sort -z \
> )

❯ echo_test "${pU[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IP_UTK.proper-etc.SC.bam

❯ echo "${#pU[@]}"
8

❯ for i in "${pU[@]}"; do
>     stem="$(basename "${i}" .bam)"
>     pU_o+=( "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/${stem}" )
> done

❯ echo_test "${pU_o[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC

❯ echo "${#pU_o[@]}"
8


❯ #  pUm --------------------------------
❯ while IFS=" " read -r -d $'\0'; do
>     pUm+=( "${REPLY}" )
> done < <(\
>     find "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/" \
>         -maxdepth 1 \
>         -type f \
>         -name *.bam \
>         -print0 \
>             | sort -z \
> )

❯ echo_test "${pUm[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IP_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IN_UTK.proper-etc.SC.bam
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IP_UTK.proper-etc.SC.bam

❯ echo "${#pUm[@]}"
4

❯ for i in "${pUm[@]}"; do
>     stem="$(basename "${i}" .bam)"
>     pUm_o+=( "./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/${stem}" )> done

❯ echo_test "${pUm_o[@]}"
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IP_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_Q_IN_UTK.proper-etc.SC
./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.proper-etc.SC

❯ echo "${#pUm_o[@]}"
4
```
</details>
<br />

<a id="03-use-gnu-parallel-to-run-samtools-fastq"></a>
### 03 Use `GNU parallel` to run samtools fastq
<a id="code-84"></a>
#### Code
<details>
<summary><i>Code: Use GNU parallel to run samtools fastq</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  pS ---------------------------------
parallel \
    -j 4 \
    --dry-run \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pS[@]}" \
:::+ "${pS_o[@]}"


#  pSm --------------------------------
parallel \
    -j 4 \
    --dry-run \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pSm[@]}" \
:::+ "${pSm_o[@]}"


#  pU ---------------------------------
parallel \
    -j 4 \
    --dry-run \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pU[@]}" \
:::+ "${pU_o[@]}"


#  pUm --------------------------------
parallel \
    -j 4 \
    --dry-run \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pUm[@]}" \
:::+ "${pUm_o[@]}"


#  Runs -------------------------------
parallel \
    -j 4 \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pS[@]}" \
:::+ "${pS_o[@]}"

parallel \
    -j 4 \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pSm[@]}" \
:::+ "${pSm_o[@]}"

parallel \
    -j 4 \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pU[@]}" \
:::+ "${pU_o[@]}"

parallel \
    -j 4 \
    "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
::: "${pUm[@]}" \
:::+ "${pUm_o[@]}"
```

</details>
<br />

<a id="printed-notes"></a>
#### Printed, notes
<details>
<summary><i>Printed, notes: Use GNU parallel to run samtools fastq</i></summary>

```txt
❯ #  pS ---------------------------------
❯ parallel \
>     -j 4 \
>     --dry-run \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pS[@]}" \
> :::+ "${pS_o[@]}"
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IN_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_G1_IP_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IN_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5781_Q_IP_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IN_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_G1_IP_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IN_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/5782_Q_IP_UTK.primary-secondary.SC.bam

#  (spot check)
samtools fastq \
    -@ 4 \
    -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.primary-secondary.SC.1.fq.gz \
    -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.primary-secondary.SC.2.fq.gz \
       ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S/             5781_Q_IN_UTK.primary-secondary.SC.bam


❯ #  pSm --------------------------------
❯ parallel \
>     -j 4 \
>     --dry-run \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pSm[@]}" \
> :::+ "${pSm_o[@]}"
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IP_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IP_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IN_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IN_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.primary-secondary.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.primary-secondary.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam

#  (spot check)
samtools fastq \
    -@ 4 \
    -1 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.primary-secondary.SC.1.fq.gz \
    -2 ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.primary-secondary.SC.2.fq.gz \
       ./bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/             merged_Q_IP_UTK.primary-secondary.SC.bam


❯ #  pU ---------------------------------
❯ parallel \
>     -j 4 \
>     --dry-run \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pU[@]}" \
> :::+ "${pU_o[@]}"
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IN_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_G1_IP_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IN_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5781_Q_IP_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IN_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_G1_IP_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IN_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/5782_Q_IP_UTK.proper-etc.SC.bam

#  (spot check)
samtools fastq \
    -@ 4 \
    -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz \
    -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz \
       ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S/             5782_Q_IP_UTK.proper-etc.SC.bam


❯ #  pUm --------------------------------
❯ parallel \
>     -j 4 \
>     --dry-run \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pUm[@]}" \
> :::+ "${pUm_o[@]}"
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IN_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IP_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IP_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_G1_IP_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_Q_IN_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_Q_IN_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IN_UTK.proper-etc.SC.bam
samtools fastq -@ 4 -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.proper-etc.SC.1.fq.gz -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_Q_IP_UTK.proper-etc.SC.2.fq.gz ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/merged_Q_IP_UTK.proper-etc.SC.bam

#  (spot check)
samtools fastq \
    -@ 4 \
    -1 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.proper-etc.SC.1.fq.gz \
    -2 ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.proper-etc.SC.2.fq.gz \
       ./bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged/             merged_G1_IN_UTK.proper-etc.SC.bam


#  Runs -------------------------------
❯ parallel \
>      -j 4 \
>      "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
>  ::: "${pS[@]}" \
>  :::+ "${pS_o[@]}"
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 18094562 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 20389872 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 20298202 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 29905450 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 15099464 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 19078550 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 29569194 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 22252398 reads


❯ parallel \
>     -j 4 \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pSm[@]}" \
> :::+ "${pSm_o[@]}"
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 33194026 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 39376752 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 42642270 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 59474644 reads


❯ parallel \
>     -j 4 \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pU[@]}" \
> :::+ "${pU_o[@]}"
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 18094566 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 20389873 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 20298205 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 29905450 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 15099465 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 19078551 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 29569196 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 22252399 reads


❯ parallel \
>     -j 4 \
>     "samtools fastq -@ 4 -1 {2}.1.fq.gz -2 {2}.2.fq.gz {1}" \
> ::: "${pUm[@]}" \
> :::+ "${pUm_o[@]}"
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 33194031 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 42642272 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 39376756 reads
[M::bam2fq_mainloop] discarded 0 singletons
[M::bam2fq_mainloop] processed 59474646 reads
```
</details>
<br />
