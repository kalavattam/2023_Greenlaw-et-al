
`#work_process-data_4tU-seq_fastqs-UMI-dedup_new-experiments-March.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [PRE Symlink to `*R{1,2,3}*.fastq.gz`](#pre-symlink-to-r123fastqgz)
	1. [Notes](#notes)
	1. [Get situated, do a quick check of the \*R{1,2,3}\*.fastq.gz files](#get-situated-do-a-quick-check-of-the-r123fastqgz-files)
		1. [Code](#code)
	1. [Making the symlinks](#making-the-symlinks)
		1. [Code](#code-1)
1. [PRE Get `fastq` file stems into arrays](#pre-get-fastq-file-stems-into-arrays)
	1. [Get situated](#get-situated)
		1. [Code](#code-2)
	1. [Create an array of file stems](#create-an-array-of-file-stems)
		1. [Code](#code-3)
	1. [Create arrays of specific files \(derived from the stems\)](#create-arrays-of-specific-files-derived-from-the-stems)
		1. [Code](#code-4)
1. [I Append UMIs to `fastq`s `R1` and `R3` *\(Trinity, general\)*](#i-append-umis-to-fastqs-r1-and-r3-trinity-general)
	1. [01 Get situated, make a directory for the processed `R1` and `R3` `fastq`s](#01-get-situated-make-a-directory-for-the-processed-r1-and-r3-fastqs)
		1. [Code](#code-5)
	1. [02 Set up necessary variables](#02-set-up-necessary-variables)
		1. [Code](#code-6)
	1. [03 Generate lists of arguments](#03-generate-lists-of-arguments)
		1. [03a Generate the full list](#03a-generate-the-full-list)
			1. [Code](#code-7)
		1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists)
			1. [Code](#code-8)
	1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script)
		1. [Code](#code-9)
	1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script)
		1. [Code](#code-10)
	1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts)
		1. [Code](#code-11)
1. [II Perform adapter and quality trimming of the `fastq`s *\(Trinity, general\)*](#ii-perform-adapter-and-quality-trimming-of-the-fastqs-trinity-general)
	1. [01 Get situated, make a directory for the adapter/quality-trimmed `R1` and `R3` `fastq`s](#01-get-situated-make-a-directory-for-the-adapterquality-trimmed-r1-and-r3-fastqs)
		1. [Code](#code-12)
	1. [02 Set up necessary variables](#02-set-up-necessary-variables-1)
		1. [Code](#code-13)
	1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-1)
		1. [03a Generate the full list](#03a-generate-the-full-list-1)
			1. [Code](#code-14)
		1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-1)
			1. [Code](#code-15)
	1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script-1)
		1. [Code](#code-16)
	1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-1)
		1. [Code](#code-17)
	1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-1)
		1. [Code](#code-18)
1. [III Perform kmer correction with `rcorrector` *\(Trinity\)*](#iii-perform-kmer-correction-with-rcorrector-trinity)
	1. [01 Get situated, make a directory for kmer-corrected `fastq`s](#01-get-situated-make-a-directory-for-kmer-corrected-fastqs)
		1. [Code](#code-19)
	1. [02 Set up necessary variables](#02-set-up-necessary-variables-2)
		1. [Code](#code-20)
	1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-2)
		1. [03a Generate the full list](#03a-generate-the-full-list-2)
			1. [Code](#code-21)
		1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-2)
			1. [Code](#code-22)
	1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script-2)
		1. [Code](#code-23)
	1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-2)
		1. [Code](#code-24)
	1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-2)
		1. [Code](#code-25)
1. [IV "Correct" the `rcorrect`ed `fastq`s *\(Trinity\)*](#iv-correct-the-rcorrected-fastqs-trinity)
	1. [01 Get situated, make a directory for kmer-corrected `fastq`s](#01-get-situated-make-a-directory-for-kmer-corrected-fastqs-1)
		1. [Code](#code-26)
	1. [02 Set up necessary variables](#02-set-up-necessary-variables-3)
		1. [Code](#code-27)
	1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-3)
		1. [03a Generate the full list](#03a-generate-the-full-list-3)
			1. [Code](#code-28)
		1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-3)
			1. [Code](#code-29)
	1. [04 Check on the '`run`' script](#04-check-on-the-run-script)
		1. [Code](#code-30)
	1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-3)
		1. [Code](#code-31)
	1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-3)
		1. [Code](#code-32)
1. [V Align kmer- and non-kmer-corrected `fastq`s *\(Trinity\)*](#v-align-kmer--and-non-kmer-corrected-fastqs-trinity)
	1. [01 Get situated, make directories for in-/outfiles, symlink the `fastq`s](#01-get-situated-make-directories-for-in-outfiles-symlink-the-fastqs)
		1. [01a Get situated, make directories for in-/outfiles](#01a-get-situated-make-directories-for-in-outfiles)
			1. [Code](#code-33)
		1. [01b Establish relative paths for symlinking](#01b-establish-relative-paths-for-symlinking)
			1. [Initialize function for finding relative paths between directories](#initialize-function-for-finding-relative-paths-between-directories)
				1. [Code](#code-34)
			1. [Establish relative path for UMI-extracted \(`U`\), trimmed \(`T`\), kmer-corrected \(`K`\) `fastq`s](#establish-relative-path-for-umi-extracted-u-trimmed-t-kmer-corrected-k-fastqs)
				1. [Code](#code-35)
			1. [Establish relative path for UMI-extracted \(`U`\), trimmed \(`T`\) `fastq`s](#establish-relative-path-for-umi-extracted-u-trimmed-t-fastqs)
				1. [Code](#code-36)
			1. [Initialize arrays of to-symlink source and target `UTK` `fastq`s](#initialize-arrays-of-to-symlink-source-and-target-utk-fastqs)
				1. [Code](#code-37)
			1. [Initialize arrays of to-symlink source and target `UT` `fastq`s](#initialize-arrays-of-to-symlink-source-and-target-ut-fastqs)
				1. [Code](#code-38)
		1. [01c Create the symlinks](#01c-create-the-symlinks)
			1. [Symlink the `UTK` `fastq`s](#symlink-the-utk-fastqs)
				1. [Code](#code-39)
			1. [Symlink the `UT` `fastq`s](#symlink-the-ut-fastqs)
				1. [Code](#code-40)
		1. [01d Get back to the head working directory](#01d-get-back-to-the-head-working-directory)
			1. [Code](#code-41)
	1. [02 Set up necessary variables](#02-set-up-necessary-variables-4)
		1. [Code](#code-42)
	1. [03 Generate lists of arguments](#03-generate-lists-of-arguments-4)
		1. [03a Generate the full lists](#03a-generate-the-full-lists)
			1. [UTK files](#utk-files)
				1. [Code](#code-43)
			1. [UT files](#ut-files)
				1. [Code](#code-44)
		1. [03b Break the full, multi-line list into individual per-line lists](#03b-break-the-full-multi-line-list-into-individual-per-line-lists-4)
			1. [UTK files](#utk-files-1)
				1. [Code](#code-45)
			1. [UT files](#ut-files-1)
				1. [Code](#code-46)
	1. [04 Use a `HEREDOC` to write a '`run`' script](#04-use-a-heredoc-to-write-a-run-script-3)
		1. [Code](#code-47)
	1. [05 Use a `HEREDOC` to write '`submit`' script](#05-use-a-heredoc-to-write-submit-script-4)
		1. [UTK files](#utk-files-2)
			1. [Code](#code-48)
		1. [UT files](#ut-files-2)
			1. [Code](#code-49)
	1. [06 Use `sbatch` to run the '`submission`' and '`run`' scripts](#06-use-sbatch-to-run-the-submission-and-run-scripts-4)
		1. [Code](#code-50)
	1. [07 Rename, organize, and check on the `STAR` outfiles](#07-rename-organize-and-check-on-the-star-outfiles)
		1. [07a Rename, organize, and check on files in `aligned_umi-extracted_trimmed/`](#07a-rename-organize-and-check-on-files-in-aligned_umi-extracted_trimmed)
			1. [Code](#code-51)
		1. [07b Rename, organize, and check on files in `aligned_umi-extracted_trimmed_kmer-corrected/`](#07b-rename-organize-and-check-on-files-in-aligned_umi-extracted_trimmed_kmer-corrected)
			1. [Code](#code-52)
1. [VI Subset bams by alignment flags *\(Trinity, general\)*](#vi-subset-bams-by-alignment-flags-trinity-general)
	1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles)
		1. [Code](#code-53)
		1. [Code](#code-54)
	1. [02 Set up necessary variables, arrays](#02-set-up-necessary-variables-arrays)
		1. [02a Set up information for `aligned_UT_primary`](#02a-set-up-information-for-aligned_ut_primary)
			1. [Code](#code-55)
		1. [02b Set up information for `aligned_UTK_primary`](#02b-set-up-information-for-aligned_utk_primary)
			1. [Code](#code-56)
	1. [03 Run `samtools view` to exclude unmapped reads from `bam` infiles](#03-run-samtools-view-to-exclude-unmapped-reads-from-bam-infiles)
		1. [03a Use a `for` loop to run `separate_bam.sh`, etc. for `aligned_UT_primary`](#03a-use-a-for-loop-to-run-separate_bamsh-etc-for-aligned_ut_primary)
			1. [Run `separate_bam.sh`](#run-separate_bamsh)
				1. [Code](#code-57)
			1. [Run `list_tally_flags()`](#run-list_tally_flags)
				1. [Code](#code-58)
				1. [Printed](#printed)
		1. [03b Use a `for` loop to run `separate_bam.sh`, etc. for `aligned_UTK_primary`](#03b-use-a-for-loop-to-run-separate_bamsh-etc-for-aligned_utk_primary)
			1. [Run `separate_bam.sh`](#run-separate_bamsh-1)
				1. [Code](#code-59)
			1. [Run `list_tally_flags()`](#run-list_tally_flags-1)
				1. [Code](#code-60)
				1. [Printed](#printed-1)
	1. [04 Use `GNU parallel` to run `samtools index`](#04-use-gnu-parallel-to-run-samtools-index)
		1. [Get all bams \(in- and outfiles\) into a single array](#get-all-bams-in--and-outfiles-into-a-single-array)
			1. [Code](#code-61)
		1. [Run `samtools index`](#run-samtools-index)
			1. [Code](#code-62)
1. [VII Deduplicate "primary" files by UMI, position *\(general\)*](#vii-deduplicate-primary-files-by-umi-position-general)
	1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles-1)
	1. [02 Process `aligned_UT_primary` data](#02-process-aligned_ut_primary-data)
		1. [02a Set up necessary variables, arrays](#02a-set-up-necessary-variables-arrays)
			1. [Code](#code-63)
		1. [02b Use `GNU parallel` to run `umi_tools dedup` for UMI and positional deduplication](#02b-use-gnu-parallel-to-run-umi_tools-dedup-for-umi-and-positional-deduplication)
			1. [Use `GNU parallel` to run `umi_tools dedup` for UMI deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-umi-deduplication)
				1. [Code](#code-64)
			1. [Use `GNU parallel` to run `umi_tools dedup` for positional deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-positional-deduplication)
				1. [Code](#code-65)
	1. [03 Process `aligned_UTK_primary` data](#03-process-aligned_utk_primary-data)
		1. [03a Set up necessary variables, arrays](#03a-set-up-necessary-variables-arrays)
			1. [Code](#code-66)
		1. [03b Use `GNU parallel` to run `umi_tools dedup` for UMI and positional deduplication](#03b-use-gnu-parallel-to-run-umi_tools-dedup-for-umi-and-positional-deduplication)
			1. [Use `GNU parallel` to run `umi_tools dedup` for UMI deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-umi-deduplication-1)
				1. [Code](#code-67)
			1. [Use `GNU parallel` to run `umi_tools dedup` for positional deduplication](#use-gnu-parallel-to-run-umi_tools-dedup-for-positional-deduplication-1)
				1. [Code](#code-68)
	1. [04 Use `GNU parallel` to run `samtools index`](#04-use-gnu-parallel-to-run-samtools-index-1)
		1. [Get all bams \(in- and outfiles\) into a single array](#get-all-bams-in--and-outfiles-into-a-single-array-1)
			1. [Code](#code-69)
		1. [Run `samtools index`](#run-samtools-index-1)
			1. [Code](#code-70)
1. [VIII Separate out alignments to different species *\(Trinity\)*](#viii-separate-out-alignments-to-different-species-trinity)
	1. [01 Get situated, make directories for outfiles](#01-get-situated-make-directories-for-outfiles-2)
		1. [Code](#code-71)
	1. [02 Set up necessary variables, arrays](#02-set-up-necessary-variables-arrays-1)
		1. [Code](#code-72)
	1. [03 Use `GNU parallel` to split bams by species](#03-use-gnu-parallel-to-split-bams-by-species)
		1. [Code](#code-73)
		1. [Printed](#printed-2)
	1. [04 Use `GNU parallel` to run `samtools index`](#04-use-gnu-parallel-to-run-samtools-index-2)
		1. [Get all bams \(in- and outfiles\) into a single array](#get-all-bams-in--and-outfiles-into-a-single-array-2)
			1. [Code](#code-74)
		1. [Run `samtools index`](#run-samtools-index-2)
			1. [Code](#code-75)
		1. [Run `list_tally_flags()`](#run-list_tally_flags-2)
			1. [Code](#code-76)
			1. [Printed](#printed-3)
1. [IX Copy `aligned_UT_primary_dedup-UMI_sans-KL-20S` files to AG](#ix-copy-aligned_ut_primary_dedup-umi_sans-kl-20s-files-to-ag)
	1. [Code](#code-77)
	1. [Printed](#printed-4)

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

- `/home/kalavatt/tsukiyamalab/alisong/RNAseq_rrp6_additional_March23`
</details>
<br />

<a id="get-situated-do-a-quick-check-of-the-r123fastqgz-files"></a>
### Get situated, do a quick check of the \*R{1,2,3}\*.fastq.gz files
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get situated, do a quick check of the *R{1,2,3}*.fastq.gz files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0115" \
            || echo "cd'ing failed; check on this..."
    }

., "${HOME}/tsukiyamalab/alisong/RNAseq_rrp6_additional_March23"
```
</details>
<br />

<a id="making-the-symlinks"></a>
### Making the symlinks
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Making the symlinks</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd fastqs_UMI-dedup/symlinks \
    || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}

#  p_M: "path March"
p_M="${HOME}/tsukiyamalab/alisong/RNAseq_rrp6_additional_March23"

r_M="$(find_relative_path "$(pwd)/" "${p_M}")"
# ., "${r_M}"

unset files_orig
typeset -a files_orig
while IFS=" " read -r -d $'\0'; do
    files_orig+=( "${REPLY}" )
done < <(\
    for i in "${r_M}"; do
        find "${i}" \
            -type f \
            -name "*_R?_001.fastq.gz" \
            -print0 \
                | sort -z
    done \
)
echo_test "${files_orig[@]}"
echo "${#files_orig[@]}"  # 21
echo $(( ${#files_orig[@]} / 3 ))  # 7

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
# cd ../.. && ., "fastqs_UMI-dedup/symlinks"
# ls -1 "fastqs_UMI-dedup/symlinks" | wc -l
```
</details>
<br />
<br />

<a id="pre-get-fastq-file-stems-into-arrays"></a>
## <u>PRE</u> Get `fastq` file stems into arrays
<a id="get-situated"></a>
### Get situated
<a id="code-2"></a>
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
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Create an array of file stems</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Create the array
unset fq_bases
typeset -a fq_bases=(
    "fastqs_UMI-dedup/symlinks/BM10_5781_DSp48_S26"
    "fastqs_UMI-dedup/symlinks/BM10_5781_DSp48_S26"
    "fastqs_UMI-dedup/symlinks/BM10_5781_DSp48_S26"
    "fastqs_UMI-dedup/symlinks/BM12_7079_DSp48_S27"
    "fastqs_UMI-dedup/symlinks/BM12_7079_DSp48_S27"
    "fastqs_UMI-dedup/symlinks/BM12_7079_DSp48_S27"
    "fastqs_UMI-dedup/symlinks/CW6_7078_day8_Q_SS_S28"
    "fastqs_UMI-dedup/symlinks/CW6_7078_day8_Q_SS_S28"
    "fastqs_UMI-dedup/symlinks/CW6_7078_day8_Q_SS_S28"
    "fastqs_UMI-dedup/symlinks/DA1_5781_SS_G1_S22"
    "fastqs_UMI-dedup/symlinks/DA1_5781_SS_G1_S22"
    "fastqs_UMI-dedup/symlinks/DA1_5781_SS_G1_S22"
    "fastqs_UMI-dedup/symlinks/DA2_5782_SS_G1_S23"
    "fastqs_UMI-dedup/symlinks/DA2_5782_SS_G1_S23"
    "fastqs_UMI-dedup/symlinks/DA2_5782_SS_G1_S23"
    "fastqs_UMI-dedup/symlinks/DA3_7078_SS_G1_S24"
    "fastqs_UMI-dedup/symlinks/DA3_7078_SS_G1_S24"
    "fastqs_UMI-dedup/symlinks/DA3_7078_SS_G1_S24"
    "fastqs_UMI-dedup/symlinks/DA4_7079_SS_G1_S25"
    "fastqs_UMI-dedup/symlinks/DA4_7079_SS_G1_S25"
    "fastqs_UMI-dedup/symlinks/DA4_7079_SS_G1_S25"
)
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"  # 21
echo $(( ${#fq_bases[@]} / 3 ))  # 7

#  Remove duplicate stems from the array
IFS=" " read -r -a fq_bases \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fq_bases[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"  # 7
echo $(( ${#fq_bases[@]} * 3 ))  # 21
```
</details>
<br />

<a id="create-arrays-of-specific-files-derived-from-the-stems"></a>
### Create arrays of specific files (derived from the stems)
<a id="code-4"></a>
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

echo_test "${UMIs[@]}"        # ., "${UMIs[0]}"

echo_test "${r1[@]}"          # ., "${r1[1]}"
echo_test "${r1_pro[@]}"      # ., "${r1_pro[2]}"
echo_test "${r1_trim[@]}"     # ., "${r1_trim[3]}"
echo_test "${r1_cor[@]}"      # ., "${r1_cor[4]}"
echo_test "${r1_cor_cln[@]}"  # ., "${r1_cor_cln[5]}"
echo_test "${r1_UTK[@]}"      # ., "${r1_UTK[6]}"
echo_test "${r1_UT[@]}"       # ., "${r1_UT[0]}"

echo_test "${r3[@]}"          # ., "${r3[1]}"
echo_test "${r3_pro[@]}"      # ., "${r3_pro[2]}"
echo_test "${r3_trim[@]}"     # ., "${r3_trim[3]}"
echo_test "${r3_cor[@]}"      # ., "${r3_cor[4]}"
echo_test "${r3_cor_cln[@]}"  # ., "${r3_cor_cln[5]}"
echo_test "${r3_UTK[@]}"      # ., "${r3_UTK[6]}"
echo_test "${r3_UT[@]}"       # ., "${r3_UT[0]}"

echo_test "${prefix_UTK[@]}"  # ., "${prefix_UTK[1]}"
echo_test "${prefix_UT[@]}"   # ., "${prefix_UT[2]}"

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
<a id="code-5"></a>
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
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_umi-tools_extract.sh"  # echo "${script_run}"
script_submit="submit_run_umi-tools_extract.sh"  # echo "${script_submit}"
threads=1  # echo "${threads}"

store_scripts="./sh_err_out"  # echo "${store_scripts}" # ., "${store_scripts}"
store_err_out="./sh_err_out/err_out"  # echo "${store_err_out}" # ., "${store_err_out}"
store_lists="./fastqs_UMI-dedup/umi-tools_extract/lists"  # echo "${store_lists}" # ., "${store_lists}"

list="umi-tools_extract.new.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list"></a>
#### 03a Generate the full list
<a id="code-7"></a>
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
<a id="code-8"></a>
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
<a id="code-9"></a>
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
#  cd "./${store_scripts}"
#  ., "./${store_scripts}/${script_run}"
#  vi "./${store_scripts}/${script_run}"  # :q
# cat "./${store_scripts}/${script_run}"
```
</details>
<br />

<a id="05-use-a-heredoc-to-write-submit-script"></a>
### 05 Use a `HEREDOC` to write '`submit`' script
<a id="code-10"></a>
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
<a id="code-11"></a>
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
<a id="code-12"></a>
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
<a id="code-13"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_atria_trim.sh"  # echo "${script_run}"
script_submit="submit_run_atria_trim.sh"  # echo "${script_submit}"
threads=8  # echo "${threads}"

store_scripts="sh_err_out"  # echo "${store_scripts}"  # ., "${store_scripts}"
store_err_out="sh_err_out/err_out"  # echo "${store_err_out}"  # ., "${store_err_out}"
store_lists="fastqs_UMI-dedup/atria_trim/lists"  # echo "${store_lists}"  # ., "${store_lists}"

list="atria_trim.new.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-1"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list-1"></a>
#### 03a Generate the full list
<a id="code-14"></a>
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
:::  outdir "$(dirname ${r1_trim[0]})" \
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
<a id="code-15"></a>
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
<a id="code-16"></a>
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
<a id="code-17"></a>
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
<a id="code-18"></a>
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
<a id="code-19"></a>
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
<a id="code-20"></a>
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

list="rcorrector.new.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-2"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list-2"></a>
#### 03a Generate the full list
<a id="code-21"></a>
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
<a id="code-22"></a>
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
<a id="code-23"></a>
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
<a id="code-24"></a>
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
<a id="code-25"></a>
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
<a id="code-26"></a>
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
<a id="code-27"></a>
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

list="rcorrector_clean-up.new.txt"  # echo "${list}"
max_id_job="${#fq_bases[@]}"  # echo "${max_id_job}"
max_id_task=8  # echo "${max_id_task}"
```
</details>
<br />

<a id="03-generate-lists-of-arguments-3"></a>
### 03 Generate lists of arguments
<a id="03a-generate-the-full-list-3"></a>
#### 03a Generate the full list
<a id="code-28"></a>
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
<a id="code-29"></a>
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
<a id="code-30"></a>
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
<a id="code-31"></a>
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
<a id="code-32"></a>
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
<a id="code-33"></a>
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
<a id="code-34"></a>
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
<a id="code-35"></a>
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
<a id="code-36"></a>
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
# echo "${p_kmer_uncor_path}"
```
</details>
<br />

<a id="initialize-arrays-of-to-symlink-source-and-target-utk-fastqs"></a>
##### Initialize arrays of to-symlink source and target `UTK` `fastq`s
<a id="code-37"></a>
###### Code
<details>
<summary><i>Code: Initialize arrays of to-symlink source and target UTK fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

typeset -a new_kmer_cor=(
    "./fastqs_UMI-dedup/rcorrector_clean-up/BM10_5781_DSp48_S26_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/BM10_5781_DSp48_S26_R3.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/BM12_7079_DSp48_S27_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/BM12_7079_DSp48_S27_R3.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/CW6_7078_day8_Q_SS_S28_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/CW6_7078_day8_Q_SS_S28_R3.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA1_5781_SS_G1_S22_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA1_5781_SS_G1_S22_R3.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA2_5782_SS_G1_S23_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA2_5782_SS_G1_S23_R3.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA3_7078_SS_G1_S24_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA3_7078_SS_G1_S24_R3.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA4_7079_SS_G1_S25_R1.UMI.atria.cor.rm-unfx.fq.gz"
    "./fastqs_UMI-dedup/rcorrector_clean-up/DA4_7079_SS_G1_S25_R3.UMI.atria.cor.rm-unfx.fq.gz"
)
echo_test "${new_kmer_cor[@]}"
echo "${#new_kmer_cor[@]}"

#  UMI-extracted (U), trimmed (T), kmer-corrected (K) files
unset fq_kmer_cor_init
unset fq_kmer_cor_sym
typeset -a fq_kmer_cor_init
typeset -a fq_kmer_cor_sym
while IFS=" " read -r -d $' '; do
    fq_kmer_cor_init+=(
        "$(echo "${p_kmer_cor_path}/$(basename "${REPLY}")")"
    )
    fq_kmer_cor_sym+=("$(
        echo "$(basename "${REPLY%.UMI.atria.cor.rm-unfx.fq.gz}").fq.gz" \
            | sed 's:_S[0-9]\+_:_:g; s:sample_::I' \
            | sed 's:_R1:_UTK_R1:g; s:_R3:_UTK_R3:g'
    )")
done < <( echo "${new_kmer_cor[@]}"$" " )
# echo_test "${fq_kmer_cor_init[@]}"
# echo_test "${fq_kmer_cor_sym[@]}"
# echo "${#fq_kmer_cor_init[@]}"
# echo "${#fq_kmer_cor_sym[@]}"
```
</details>
<br />

<a id="initialize-arrays-of-to-symlink-source-and-target-ut-fastqs"></a>
##### Initialize arrays of to-symlink source and target `UT` `fastq`s
<a id="code-38"></a>
###### Code
<details>
<summary><i>Code: Initialize arrays of to-symlink source and target UT fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

new_kmer_uncor=(
    "fastqs_UMI-dedup/atria_trim/BM10_5781_DSp48_S26_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/BM10_5781_DSp48_S26_R3.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/BM12_7079_DSp48_S27_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/BM12_7079_DSp48_S27_R3.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/CW6_7078_day8_Q_SS_S28_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/CW6_7078_day8_Q_SS_S28_R3.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA1_5781_SS_G1_S22_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA1_5781_SS_G1_S22_R3.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA2_5782_SS_G1_S23_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA2_5782_SS_G1_S23_R3.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA3_7078_SS_G1_S24_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA3_7078_SS_G1_S24_R3.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA4_7079_SS_G1_S25_R1.UMI.atria.fq.gz"
    "fastqs_UMI-dedup/atria_trim/DA4_7079_SS_G1_S25_R3.UMI.atria.fq.gz"
)
echo_test "${new_kmer_uncor[@]}"
echo "${#new_kmer_uncor[@]}"

#  UMI-extracted (U), trimmed (T) files
unset fq_kmer_uncor_init
unset fq_kmer_uncor_sym
typeset -a fq_kmer_uncor_init
typeset -a fq_kmer_uncor_sym
while IFS=" " read -r -d $' '; do
    fq_kmer_uncor_init+=(
        "$(echo "${p_kmer_uncor_path}/$(basename "${REPLY}")")"
    )
    fq_kmer_uncor_sym+=("$(
        echo "$(basename "${REPLY%.UMI.atria.fq.gz}").fq.gz" \
            | sed 's:_S[0-9]\+_:_:g; s:sample_::I' \
            | sed 's:_R1:_UT_R1:g; s:_R3:_UT_R3:g'
    )")
done < <( echo "${new_kmer_uncor[@]}"$" " )
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
<a id="code-39"></a>
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
<a id="code-40"></a>
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
<a id="code-41"></a>
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
<a id="code-42"></a>
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
max_id_task=7  # echo "${max_id_task}"

store_scripts="sh_err_out"  # echo "${store_scripts}"
store_err_out="sh_err_out/err_out"  # echo "${store_err_out}"

store_list_UTK="bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/lists"  # echo "${store_list_UTK}"
list_UTK="STAR_UTK.new.txt"  # echo "${list_UTK}"

store_list_UT="bams_UMI-dedup/aligned_umi-extracted_trimmed/lists"  # echo "${store_list_UT}"
list_UT="STAR_UT.new.txt"  # echo "${list_UT}"

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
<a id="code-43"></a>
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
<a id="code-44"></a>
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
<a id="code-45"></a>
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
<a id="code-46"></a>
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
<a id="code-47"></a>
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
<a id="code-48"></a>
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
<a id="code-49"></a>
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
<a id="code-50"></a>
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
<a id="code-51"></a>
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

new=(
    "BM10_5781_DSp48"
    "BM10_5781_DSp48"
    "BM12_7079_DSp48"
    "BM12_7079_DSp48"
    "CW6_7078_day8_Q_SS"
    "CW6_7078_day8_Q_SS"
    "DA1_5781_SS_G1"
    "DA1_5781_SS_G1"
    "DA2_5782_SS_G1"
    "DA2_5782_SS_G1"
    "DA3_7078_SS_G1"
    "DA3_7078_SS_G1"
    "DA4_7079_SS_G1"
    "DA4_7079_SS_G1"
)
echo_test "${new[@]}"
echo "${#new[@]}"

for i in "${new[@]}"; do
    rename -n 's/Aligned.sortedByCoord.out//g' "${i}"*
    rename -n 's/Log/.Log/g; s/SJ/.SJ/g' "${i}"*

    rename 's/Aligned.sortedByCoord.out//g' "${i}"*
    rename 's/Log/.Log/g; s/SJ/.SJ/g' "${i}"*

    ls -1 "${i}"*_STARtmp/
    rm -r "${i}"*_STARtmp/
done

rename -n 's:\.\.:\.:g' *.{tab,out}
rename 's:\.\.:\.:g' *.{tab,out}

rename -n 's/BM10_5781_DSp48/BM10_DSp48_5781_new/g' *
rename 's/BM10_5781_DSp48/BM10_DSp48_5781_new/g' *

rename -n 's/BM12_7079_DSp48/BM12_DSp48_7079/g' *
rename 's/BM12_7079_DSp48/BM12_DSp48_7079/g' *

.,
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

new=(
    "BM10_5781_DSp48"
    "BM10_5781_DSp48"
    "BM12_7079_DSp48"
    "BM12_7079_DSp48"
    "CW6_7078_day8_Q_SS"
    "CW6_7078_day8_Q_SS"
    "DA1_5781_SS_G1"
    "DA1_5781_SS_G1"
    "DA2_5782_SS_G1"
    "DA2_5782_SS_G1"
    "DA3_7078_SS_G1"
    "DA3_7078_SS_G1"
    "DA4_7079_SS_G1"
    "DA4_7079_SS_G1"
)
echo_test "${new[@]}"
echo "${#new[@]}"

for i in "${new[@]}"; do
    rename -n 's/Aligned.sortedByCoord.out//g' "${i}"*
    rename -n 's/Log/.Log/g; s/SJ/.SJ/g' "${i}"*

    rename 's/Aligned.sortedByCoord.out//g' "${i}"*
    rename 's/Log/.Log/g; s/SJ/.SJ/g' "${i}"*

    ls -1 "${i}"*_STARtmp/
    rm -r "${i}"*_STARtmp/
done

rename -n 's:\.\.:\.:g' *.{tab,out}
rename 's:\.\.:\.:g' *.{tab,out}

rename -n 's/BM10_5781_DSp48/BM10_DSp48_5781_new/g' *
rename 's/BM10_5781_DSp48/BM10_DSp48_5781_new/g' *

rename -n 's/BM12_7079_DSp48/BM12_DSp48_7079/g' *
rename 's/BM12_7079_DSp48/BM12_DSp48_7079/g' *

.,
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
<a id="code-54"></a>
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
<a id="02a-set-up-information-for-aligned_ut_primary"></a>
#### 02a Set up information for `aligned_UT_primary`
<a id="code-55"></a>
##### Code
<details>
<summary><i>Code: Set up information for aligned_UT_primary</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams_UT_prim
typeset -a bams_UT_prim=(
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/BM10_DSp48_5781_new_UT.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/BM12_DSp48_7079_UT.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/CW6_7078_day8_Q_SS_UT.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/DA1_5781_SS_G1_UT.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/DA3_7078_SS_G1_UT.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/DA4_7079_SS_G1_UT.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed/DA2_5782_SS_G1_UT.bam
)
echo_test "${bams_UT_prim[@]}"
echo "${#bams_UT_prim[@]}"
```
</details>
<br />

<a id="02b-set-up-information-for-aligned_utk_primary"></a>
#### 02b Set up information for `aligned_UTK_primary`
<a id="code-56"></a>
##### Code
<details>
<summary><i>Code: Set up information for aligned_UTK_primary</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams_UTK_prim
typeset -a bams_UTK_prim=(
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/BM10_DSp48_5781_new_UTK.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/BM12_DSp48_7079_UTK.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/CW6_7078_day8_Q_SS_UTK.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/DA1_5781_SS_G1_UTK.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/DA3_7078_SS_G1_UTK.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/DA4_7079_SS_G1_UTK.bam
    ./bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected/DA2_5782_SS_G1_UTK.bam
)
echo_test "${bams_UTK_prim[@]}"
echo "${#bams_UTK_prim[@]}"
```
</details>
<br />

<a id="03-run-samtools-view-to-exclude-unmapped-reads-from-bam-infiles"></a>
### 03 Run `samtools view` to exclude unmapped reads from `bam` infiles
<a id="03a-use-a-for-loop-to-run-separate_bamsh-etc-for-aligned_ut_primary"></a>
#### 03a Use a `for` loop to run `separate_bam.sh`, etc. for `aligned_UT_primary`
<a id="run-separate_bamsh"></a>
##### Run `separate_bam.sh`
<a id="code-57"></a>
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
<a id="code-58"></a>
###### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset outbams
typeset -a outbams=(
    ./bams_UMI-dedup/aligned_UT_primary/BM10_DSp48_5781_new_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/BM12_DSp48_7079_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/CW6_7078_day8_Q_SS_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA1_5781_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA3_7078_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA4_7079_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA2_5782_SS_G1_UT.primary.bam
)

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
❯ for i in "bams_UMI-dedup/aligned_UT_primary/"*".list-tally-flags.txt"; do
>     echo "${i}"
>     echo "----------------------------------------"
>     cat "${i}"
>     echo ""
> done
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

bams_UMI-dedup/aligned_UT_primary/BM10_DSp48_5781_new_UT.primary.list-tally-flags.txt
----------------------------------------
24831265 83
24831265 163
10673706 99
10673706 147

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

bams_UMI-dedup/aligned_UT_primary/BM12_DSp48_7079_UT.primary.list-tally-flags.txt
----------------------------------------
22800622 83
22800622 163
10440760 99
10440760 147

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

bams_UMI-dedup/aligned_UT_primary/CW6_7078_day8_Q_SS_UT.primary.list-tally-flags.txt
----------------------------------------
21111121 99
21111121 147
20986433 83
20986433 163

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

bams_UMI-dedup/aligned_UT_primary/DA1_5781_SS_G1_UT.primary.list-tally-flags.txt
----------------------------------------
23848935 83
23848935 163
7385798 99
7385798 147

bams_UMI-dedup/aligned_UT_primary/DA2_5782_SS_G1_UT.primary.list-tally-flags.txt
----------------------------------------
22012822 83
22012822 163
6820725 99
6820725 147

bams_UMI-dedup/aligned_UT_primary/DA3_7078_SS_G1_UT.primary.list-tally-flags.txt
----------------------------------------
21616130 83
21616130 163
9891543 99
9891543 147

bams_UMI-dedup/aligned_UT_primary/DA4_7079_SS_G1_UT.primary.list-tally-flags.txt
----------------------------------------
21317999 83
21317999 163
10386700 99
10386700 147
```
</details>
<br />

<a id="03b-use-a-for-loop-to-run-separate_bamsh-etc-for-aligned_utk_primary"></a>
#### 03b Use a `for` loop to run `separate_bam.sh`, etc. for `aligned_UTK_primary`
<a id="run-separate_bamsh-1"></a>
##### Run `separate_bam.sh`
<a id="code-59"></a>
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

<a id="run-list_tally_flags-1"></a>
##### Run `list_tally_flags()`
<a id="code-60"></a>
###### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset outbams
typeset -a outbams=(
    ./bams_UMI-dedup/aligned_UTK_primary/BM10_DSp48_5781_new_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/BM12_DSp48_7079_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/CW6_7078_day8_Q_SS_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA1_5781_SS_G1_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA3_7078_SS_G1_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA4_7079_SS_G1_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA2_5782_SS_G1_UTK.primary.bam
)

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

<a id="printed-1"></a>
###### Printed
<details>
<summary><i>Printed: Run list_tally_flags()</i></summary>

```txt
❯ for i in "bams_UMI-dedup/aligned_UTK_primary/"*".list-tally-flags.txt"; do
>    echo "${i}"
>    echo "----------------------------------------"
>    cat "${i}"
>    echo ""
>done
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

bams_UMI-dedup/aligned_UTK_primary/BM10_DSp48_5781_new_UTK.primary.list-tally-flags.txt
----------------------------------------
24202359 83
24202359 163
10371345 99
10371345 147

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

bams_UMI-dedup/aligned_UTK_primary/BM12_DSp48_7079_UTK.primary.list-tally-flags.txt
----------------------------------------
22182989 83
22182989 163
10117933 99
10117933 147

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

bams_UMI-dedup/aligned_UTK_primary/CW6_7078_day8_Q_SS_UTK.primary.list-tally-flags.txt
----------------------------------------
20693648 99
20693648 147
20449736 83
20449736 163

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

bams_UMI-dedup/aligned_UTK_primary/DA1_5781_SS_G1_UTK.primary.list-tally-flags.txt
----------------------------------------
23167464 83
23167464 163
6976635 99
6976635 147

bams_UMI-dedup/aligned_UTK_primary/DA2_5782_SS_G1_UTK.primary.list-tally-flags.txt
----------------------------------------
21362985 83
21362985 163
6438129 99
6438129 147

bams_UMI-dedup/aligned_UTK_primary/DA3_7078_SS_G1_UTK.primary.list-tally-flags.txt
----------------------------------------
20842671 83
20842671 163
9321810 99
9321810 147

bams_UMI-dedup/aligned_UTK_primary/DA4_7079_SS_G1_UTK.primary.list-tally-flags.txt
----------------------------------------
20507120 83
20507120 163
9772656 99
9772656 147
```
</details>
<br />

<a id="04-use-gnu-parallel-to-run-samtools-index"></a>
### 04 Use `GNU parallel` to run `samtools index`
<a id="get-all-bams-in--and-outfiles-into-a-single-array"></a>
#### Get all bams (in- and outfiles) into a single array
<a id="code-61"></a>
##### Code
<details>
<summary><i>Code: Get all bams (in- and outfiles) into a single array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset bams
typeset -a bams=(
	./bams_UMI-dedup/aligned_UT_primary/BM10_DSp48_5781_new_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/BM12_DSp48_7079_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/CW6_7078_day8_Q_SS_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA1_5781_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA3_7078_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA4_7079_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UT_primary/DA2_5782_SS_G1_UT.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/BM10_DSp48_5781_new_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/BM12_DSp48_7079_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/CW6_7078_day8_Q_SS_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA1_5781_SS_G1_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA3_7078_SS_G1_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA4_7079_SS_G1_UTK.primary.bam
    ./bams_UMI-dedup/aligned_UTK_primary/DA2_5782_SS_G1_UTK.primary.bam
)
echo_test "${bams[@]}"
echo "${#bams[@]}"
```
</details>
<br />

<a id="run-samtools-index"></a>
#### Run `samtools index`
<a id="code-62"></a>
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
grabnode  # 8, etc.

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
<a id="code-63"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset inbams
typeset -a inbams=(
	./bams_UMI-dedup/aligned_UT_primary/BM10_DSp48_5781_new_UT.primary.bam
	./bams_UMI-dedup/aligned_UT_primary/BM12_DSp48_7079_UT.primary.bam
	./bams_UMI-dedup/aligned_UT_primary/CW6_7078_day8_Q_SS_UT.primary.bam
	./bams_UMI-dedup/aligned_UT_primary/DA1_5781_SS_G1_UT.primary.bam
	./bams_UMI-dedup/aligned_UT_primary/DA3_7078_SS_G1_UT.primary.bam
	./bams_UMI-dedup/aligned_UT_primary/DA4_7079_SS_G1_UT.primary.bam
	./bams_UMI-dedup/aligned_UT_primary/DA2_5782_SS_G1_UT.primary.bam
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
<a id="code-64"></a>
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
<a id="code-65"></a>
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
<a id="code-66"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset inbams
typeset -a inbams=(
	./bams_UMI-dedup/aligned_UTK_primary/BM10_DSp48_5781_new_UTK.primary.bam
	./bams_UMI-dedup/aligned_UTK_primary/BM12_DSp48_7079_UTK.primary.bam
	./bams_UMI-dedup/aligned_UTK_primary/CW6_7078_day8_Q_SS_UTK.primary.bam
	./bams_UMI-dedup/aligned_UTK_primary/DA1_5781_SS_G1_UTK.primary.bam
	./bams_UMI-dedup/aligned_UTK_primary/DA3_7078_SS_G1_UTK.primary.bam
	./bams_UMI-dedup/aligned_UTK_primary/DA4_7079_SS_G1_UTK.primary.bam
	./bams_UMI-dedup/aligned_UTK_primary/DA2_5782_SS_G1_UTK.primary.bam
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
<a id="code-67"></a>
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
<a id="code-68"></a>
###### Code
<details>
<summary><i>Code: Use GNU parallel to run umi_tools dedup for positional deduplication</i></summary>

`#INPROGRESS`
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
<a id="get-all-bams-in--and-outfiles-into-a-single-array-1"></a>
#### Get all bams (in- and outfiles) into a single array
<a id="code-69"></a>
##### Code
<details>
<summary><i>Code: Get all bams (in- and outfiles) into a single array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 32, etc.

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

unset bams
typeset -a bams=(
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/BM10_DSp48_5781_new_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/BM12_DSp48_7079_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/CW6_7078_day8_Q_SS_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/DA1_5781_SS_G1_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/DA2_5782_SS_G1_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/DA3_7078_SS_G1_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-pos/DA4_7079_SS_G1_UT.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM12_DSp48_7079_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA1_5781_SS_G1_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA2_5782_SS_G1_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA3_7078_SS_G1_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA4_7079_SS_G1_UT.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/BM10_DSp48_5781_new_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/BM12_DSp48_7079_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/CW6_7078_day8_Q_SS_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/DA1_5781_SS_G1_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/DA2_5782_SS_G1_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/DA3_7078_SS_G1_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-pos/DA4_7079_SS_G1_UTK.primary.dedup-pos.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM12_DSp48_7079_UTK.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA1_5781_SS_G1_UTK.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA2_5782_SS_G1_UTK.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA3_7078_SS_G1_UTK.primary.dedup-UMI.bam
	bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA4_7079_SS_G1_UTK.primary.dedup-UMI.bam
)
echo_test "${bams[@]}"
echo "${#bams[@]}"
```
</details>
<br />

<a id="run-samtools-index-1"></a>
#### Run `samtools index`
<a id="code-70"></a>
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
`#NOTE This work to generate aligned_{UTK,UT}_primary_dedup-UMI_sans-KL-20S is new to this notebook; it was not performed in work_process-data_4tU-seq_fastqs-UMI.md`

<a id="code-71"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directories for outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 28, etc.

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
mkdir -p "./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S"
mkdir -p "./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S"
```
</details>
<br />

<a id="02-set-up-necessary-variables-arrays-1"></a>
### 02 Set up necessary variables, arrays
<a id="code-72"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  *_UTK.primary.dedup-UMI.bam: exclude K. lactis and 20S alignments ----------
unset inbams_utk
typeset -a inbams_utk
while IFS=" " read -r -d $'\0'; do
    inbams_utk+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams_utk[@]}"
echo "${#inbams_utk[@]}"

outdir_utk="./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S"


#  *_UT.primary.dedup-UMI.bam: exclude K. lactis and 20S alignments -----------
unset inbams_ut
typeset -a inbams_ut
while IFS=" " read -r -d $'\0'; do
    inbams_ut+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UT_primary_dedup-UMI" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams_ut[@]}"
echo "${#inbams_ut[@]}"

outdir_ut="./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S"
```
</details>
<br />

<a id="03-use-gnu-parallel-to-split-bams-by-species"></a>
### 03 Use `GNU parallel` to split bams by species
<a id="code-73"></a>
#### Code
<details>
<summary><i>Code: Use GNU parallel to split bams by species</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  *_UTK.primary.dedup-UMI.bam --------
parallel \
    -j 14 \
    --dry-run \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_utk[@]}" \
::: "${outdir_utk}"

parallel \
    -j 14 \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_utk[@]}" \
::: "${outdir_utk}"

#  *_UT.primary.dedup-UMI.bam -----
parallel \
    -j 14 \
    --dry-run \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_ut[@]}" \
::: "${outdir_ut}"

parallel \
    -j 14 \
    "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
::: "${inbams_ut[@]}" \
::: "${outdir_ut}"
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Use GNU parallel to split bams by species</i></summary>

```txt
❯ parallel \
>    -j 14 \
>     --dry-run \
>     "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
> ::: "${inbams_utk[@]}" \
> ::: "${outdir_utk}"
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5781_G1_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5781_G1_IP_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5781_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5781_Q_IP_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5782_G1_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5782_G1_IP_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5782_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/5782_Q_IP_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM10_DSp48_5781_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM11_DSp48_7080_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM12_DSp48_7079_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM1_DSm2_5781_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM2_DSm2_7080_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM3_DSm2_7079_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM4_DSp2_5781_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM5_DSp2_7080_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM6_DSp2_7079_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM7_DSp24_5781_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM8_DSp24_7080_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/BM9_DSp24_7079_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp10_DSp48_5782_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp11_DSp48_7081_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp12_DSp48_7078_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp1_DSm2_5782_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp2_DSm2_7081_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp3_DSm2_7078_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp4_DSp2_5782_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp5_DSp2_7081_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp6_DSp2_7078_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp7_DSp24_5782_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp8_DSp24_7081_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/Bp9_DSp24_7078_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA1_5781_SS_G1_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA2_5782_SS_G1_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA3_7078_SS_G1_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UTK.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI/DA4_7079_SS_G1_UTK.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UTK.primary.dedup-UMI.SC.bam


❯ parallel \
>     -j 14 \
>     "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
> ::: "${inbams_utk[@]}" \
> ::: "${outdir_utk}"


❯ parallel \
>     -j 14 \
>     --dry-run \
>     "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
> ::: "${inbams_ut[@]}" \
> ::: "${outdir_ut}"
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5781_G1_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5781_G1_IP_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5781_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5781_Q_IP_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5782_G1_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5782_G1_IP_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5782_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/5782_Q_IP_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM11_DSp48_7080_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM12_DSp48_7079_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM1_DSm2_5781_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM2_DSm2_7080_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM3_DSm2_7079_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM4_DSp2_5781_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM5_DSp2_7080_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM6_DSp2_7079_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM7_DSp24_5781_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM8_DSp24_7080_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM9_DSp24_7079_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp10_DSp48_5782_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp11_DSp48_7081_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp12_DSp48_7078_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp1_DSm2_5782_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp2_DSm2_7081_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp3_DSm2_7078_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp4_DSp2_5782_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp5_DSp2_7081_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp6_DSp2_7078_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp7_DSp24_5782_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp8_DSp24_7081_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp9_DSp24_7078_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA1_5781_SS_G1_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA2_5782_SS_G1_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA3_7078_SS_G1_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.bam
samtools view -@ 2 -h ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI/DA4_7079_SS_G1_UT.primary.dedup-UMI.bam I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.bam


❯ parallel \
>     -j 14 \
>     "samtools view -@ 2 -h {1} I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito -o {2}/{1/.}.SC.bam" \
> ::: "${inbams_ut[@]}" \
> ::: "${outdir_ut}"
```
</details>
<br />

<a id="04-use-gnu-parallel-to-run-samtools-index-2"></a>
### 04 Use `GNU parallel` to run `samtools index`
<a id="get-all-bams-in--and-outfiles-into-a-single-array-2"></a>
#### Get all bams (in- and outfiles) into a single array
<a id="code-74"></a>
##### Code
<details>
<summary><i>Code: Get all bams (in- and outfiles) into a single array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 28, etc.

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


#  *_UTK.primary.dedup-UMI.SC.bam: excluded K. lactis and 20S alignments ------
unset inbams_utk_sc
typeset -a inbams_utk_sc
while IFS=" " read -r -d $'\0'; do
    inbams_utk_sc+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams_utk_sc[@]}"
echo "${#inbams_utk_sc[@]}"


#  *_UT.primary.dedup-UMI.SC.bam: excluded K. lactis and 20S alignments -------
unset inbams_ut_sc
typeset -a inbams_ut_sc
while IFS=" " read -r -d $'\0'; do
    inbams_ut_sc+=( "${REPLY}" )
done < <(\
    find "./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S" \
        -maxdepth 1 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${inbams_ut_sc[@]}"
echo "${#inbams_ut_sc[@]}"
```
</details>
<br />

<a id="run-samtools-index-2"></a>
#### Run `samtools index`
<a id="code-75"></a>
##### Code
<details>
<summary><i>Code: Run samtools index</i></summary>

```bash
#  *_UTK.primary.dedup-UMI.SC.bam: excluded K. lactis and 20S alignments ------
parallel \
    -k \
    -j 4 \
    --dry-run \
    "samtools index -@ 7 {}" \
::: "${inbams_utk_sc[@]}"

parallel \
    -k \
    -j 4 \
    "samtools index -@ 7 {}" \
::: "${inbams_utk_sc[@]}"


#  *_UT.primary.dedup-UMI.SC.bam: excluded K. lactis and 20S alignments -------
parallel \
    -k \
    -j 4 \
    --dry-run \
    "samtools index -@ 7 {}" \
::: "${inbams_ut_sc[@]}"

parallel \
    -k \
    -j 4 \
    "samtools index -@ 7 {}" \
::: "${inbams_ut_sc[@]}"
```
</details>
<br />

<a id="run-list_tally_flags-2"></a>
#### Run `list_tally_flags()`
<a id="code-76"></a>
##### Code
<details>
<summary><i>Code: Run list_tally_flags()</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

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
::: "${inbams_utk_sc[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${inbams_utk_sc[@]}"


parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${inbams_ut_sc[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "list_tally_flags {} > {.}.list-tally-flags.txt" \
::: "${inbams_ut_sc[@]}"


for i in "bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/"*".list-tally-flags.txt"; do
    echo "${i}"
    echo "----------------------------------------"
    cat "${i}"
    echo ""
done

for i in "bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/"*".list-tally-flags.txt"; do
    echo "${i}"
    echo "----------------------------------------"
    cat "${i}"
    echo ""
done
```
</details>
<br />

<a id="printed-3"></a>
##### Printed
<details>
<summary><i>Printed: Run list_tally_flags()</i></summary>

```txt
❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     "list_tally_flags {} > {.}.list-tally-flags.txt" \
> ::: "${inbams_utk_sc[@]}"
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UTK.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     "list_tally_flags {} > {.}.list-tally-flags.txt" \
> ::: "${inbams_utk_sc[@]}"


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     "list_tally_flags {} > {.}.list-tally-flags.txt" \
> ::: "${inbams_ut_sc[@]}"
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
list_tally_flags ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.bam > ./bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     "list_tally_flags {} > {.}.list-tally-flags.txt" \
> ::: "${inbams_ut_sc[@]}"


❯ for i in "bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/"*".list-tally-flags.txt"; do
>     echo "${i}"
>     echo "----------------------------------------"
>     cat "${i}"
>     echo ""
> done
bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4951616 83
4951616 163
4269402 99
4269402 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7472883 99
7472883 147
6986211 83
6986211 163

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
3868468 83
3868468 163
2950742 99
2950742 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4835144 83
4835144 163
4592200 99
4592200 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4390868 99
4390868 147
4092263 83
4092263 163

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7269826 99
7269826 147
7069011 83
7069011 163

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
3452975 83
3452975 163
2934611 99
2934611 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5384521 83
5384521 163
5047623 99
5047623 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
10393125 83
10393125 163
2355021 99
2355021 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------

5098131 83
5098131 163
2063658 99
2063658 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4865195 83
4865195 163
2455137 99
2455137 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9891734 83
9891734 163
2632666 99
2632666 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8681619 83
8681619 163
5155248 99
5155248 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9074845 83
9074845 163
5064275 99
5064275 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8588944 83
8588944 163
5325686 99
5325686 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7547155 83
7547155 163
4132925 99
4132925 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9693472 83
9693472 163
5101684 99
5101684 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7939306 83
7939306 163
4908410 99
4908410 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6390124 83
6390124 163
3076177 99
3076177 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6716521 83
6716521 163
4018800 99
4018800 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6351630 83
6351630 163
3938531 99
3938531 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4829123 83
4829123 163
1898906 99
1898906 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5018584 83
5018584 163
2302520 99
2302520 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5679162 83
5679162 163
2568606 99
2568606 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7224723 83
7224723 163
3961135 99
3961135 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8590821 83
8590821 163
4754253 99
4754253 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6673981 83
6673981 163
4110762 99
4110762 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8582261 83
8582261 163
4434625 99
4434625 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9483803 83
9483803 163
5458056 99
5458056 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7403648 83
7403648 163
4593945 99
4593945 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6590566 83
6590566 163
3292097 99
3292097 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6454568 83
6454568 163
4027468 99
4027468 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5379564 83
5379564 163
3051827 99
3051827 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6593695 83
6593695 163
4389384 99
4389384 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6776716 83
6776716 163
2935250 99
2935250 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5728757 83
5728757 163
3707384 99
3707384 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9791293 83
9791293 163
2946498 99
2946498 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5077639 83
5077639 163
3080362 99
3080362 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8793395 83
8793395 163
3064692 99
3064692 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8702394 83
8702394 163
5942106 99
5942106 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6139210 83
6139210 163
2861613 99
2861613 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7155779 83
7155779 163
5396324 99
5396324 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7270732 83
7270732 163
3534144 99
3534144 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7722664 83
7722664 163
5471729 99
5471729 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6601934 83
6601934 163
2803873 99
2803873 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7396536 83
7396536 163
2370159 99
2370159 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8067908 83
8067908 163
5479018 99
5479018 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6054122 83
6054122 163
1982886 99
1982886 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8638658 83
8638658 163
5687879 99
5687879 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6804024 83
6804024 163
2133249 99
2133249 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8868518 83
8868518 163
6206689 99
6206689 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6891761 83
6891761 163
2242225 99
2242225 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8961166 83
8961166 163
6187465 99
6187465 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
14867047 83
14867047 163
2599235 99
2599235 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9446571 83
9446571 163
7039836 99
7039836 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
12479440 83
12479440 163
2132502 99
2132502 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7546756 83
7546756 163
2825882 99
2825882 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8239761 83
8239761 163
5803564 99
5803564 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
14067594 83
14067594 163
5264607 99
5264607 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
13178893 83
13178893 163
4866527 99
4866527 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
12795185 83
12795185 163
6578951 99
6578951 147

bams_UMI-dedup/aligned_UTK_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UTK.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
12984855 83
12984855 163
7098771 99
7098771 147


❯ for i in "bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/"*".list-tally-flags.txt"; do
>     echo "${i}"
>     echo "----------------------------------------"
>     cat "${i}"
>     echo ""
> done
bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5194846 83
5194846 163
4520419 99
4520419 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_G1_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7898716 99
7898716 147
7390025 83
7390025 163

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4053478 83
4053478 163
3159298 99
3159298 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5781_Q_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5091979 83
5091979 163
4863791 99
4863791 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
4639252 99
4639252 147
4321164 83
4321164 163

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_G1_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7675287 99
7675287 147
7460402 83
7460402 163

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
3622296 83
3622296 163
3200391 99
3200391 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/5782_Q_IP_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5690690 83
5690690 163
5372097 99
5372097 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
10682902 83
10682902 163
2472240 99
2472240 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM10_DSp48_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5296658 83
5296658 163
2185033 99
2185033 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM11_DSp48_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5073600 83
5073600 163
2605045 99
2605045 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM12_DSp48_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
10196666 83
10196666 163
2774295 99
2774295 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM1_DSm2_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9072256 83
9072256 163
5504134 99
5504134 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM2_DSm2_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9448102 83
9448102 163
5392032 99
5392032 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM3_DSm2_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9020072 83
9020072 163
5703990 99
5703990 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM4_DSp2_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7854763 83
7854763 163
4423966 99
4423966 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM5_DSp2_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
10078039 83
10078039 163
5453565 99
5453565 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM6_DSp2_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8326469 83
8326469 163
5259336 99
5259336 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM7_DSp24_5781_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6643234 83
6643234 163
3263759 99
3263759 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM8_DSp24_7080_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7006015 83
7006015 163
4269970 99
4269970 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/BM9_DSp24_7079_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6656577 83
6656577 163
4213052 99
4213052 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5015548 83
5015548 163
2012937 99
2012937 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5224864 83
5224864 163
2437544 99
2437544 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5930306 83
5930306 163
2727265 99
2727265 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7544682 83
7544682 163
4237109 99
4237109 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8947410 83
8947410 163
5063644 99
5063644 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6999093 83
6999093 163
4395015 99
4395015 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8909921 83
8909921 163
4748231 99
4748231 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9869861 83
9869861 163
5824290 99
5824290 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7766107 83
7766107 163
4925690 99
4925690 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6850843 83
6850843 163
3496346 99
3496346 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6727665 83
6727665 163
4265742 99
4265742 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5615267 83
5615267 163
3258370 99
3258370 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6946647 83
6946647 163
4715027 99
4715027 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7022354 83
7022354 163
3086248 99
3086248 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6033989 83
6033989 163
4000473 99
4000473 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
10107147 83
10107147 163
3131564 99
3131564 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
5336545 83
5336545 163
3333717 99
3333717 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9055987 83
9055987 163
3202277 99
3202277 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9156118 83
9156118 163
6360252 99
6360252 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6364978 83
6364978 163
3013819 99
3013819 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7559418 83
7559418 163
5791153 99
5791153 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7544077 83
7544077 163
3722490 99
3722490 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8174248 83
8174248 163
5896131 99
5896131 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6838767 83
6838767 163
2950568 99
2950568 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7636804 83
7636804 163
2486121 99
2486121 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8531550 83
8531550 163
5901093 99
5901093 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
6266425 83
6266425 163
2084899 99
2084899 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9114220 83
9114220 163
6114433 99
6114433 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7030425 83
7030425 163
2237617 99
2237617 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9379998 83
9379998 163
6663439 99
6663439 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7125724 83
7125724 163
2347873 99
2347873 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
9458969 83
9458969 163
6632593 99
6632593 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
15235794 83
15235794 163
2732819 99
2732819 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
10023349 83
10023349 163
7570394 99
7570394 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
12784491 83
12784491 163
2242446 99
2242446 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
7848786 83
7848786 163
2982822 99
2982822 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
8753021 83
8753021 163
6261244 99
6261244 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
14489069 83
14489069 163
5568182 99
5568182 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
13583711 83
13583711 163
5152672 99
5152672 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
13313800 83
13313800 163
7000281 99
7000281 147

bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S/DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.list-tally-flags.txt
----------------------------------------
13543016 83
13543016 163
7562717 99
7562717 147
```
</details>
<br />
<br />

<a id="ix-copy-aligned_ut_primary_dedup-umi_sans-kl-20s-files-to-ag"></a>
## <u>IX</u> Copy `aligned_UT_primary_dedup-UMI_sans-KL-20S` files to AG
<a id="code-77"></a>
### Code
<details>
<summary><i>Code: Copy aligned_UT_primary_dedup-UMI_sans-KL-20S files to AG</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S"

mkdir -p "${HOME}/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314"

cp \
	*.{bam,bai} \
	"${HOME}/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314"
```
</details>
<br />

<a id="printed-4"></a>
### Printed
<details>
<summary><i>Printed: Copy aligned_UT_primary_dedup-UMI_sans-KL-20S files to AG</i></summary>

```txt
❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI_sans-KL-20S"


❯ mkdir -p "${HOME}/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314"
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314'


❯ cp \
>     *.{bam,bai} \
>     "${HOME}/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314"
'5781_G1_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_G1_IN_UT.primary.dedup-UMI.SC.bam'
'5781_G1_IP_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_G1_IP_UT.primary.dedup-UMI.SC.bam'
'5781_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_Q_IN_UT.primary.dedup-UMI.SC.bam'
'5781_Q_IP_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_Q_IP_UT.primary.dedup-UMI.SC.bam'
'5782_G1_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_G1_IN_UT.primary.dedup-UMI.SC.bam'
'5782_G1_IP_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_G1_IP_UT.primary.dedup-UMI.SC.bam'
'5782_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_Q_IN_UT.primary.dedup-UMI.SC.bam'
'5782_Q_IP_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_Q_IP_UT.primary.dedup-UMI.SC.bam'
'BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.bam'
'BM10_DSp48_5781_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM10_DSp48_5781_UT.primary.dedup-UMI.SC.bam'
'BM11_DSp48_7080_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM11_DSp48_7080_UT.primary.dedup-UMI.SC.bam'
'BM12_DSp48_7079_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM12_DSp48_7079_UT.primary.dedup-UMI.SC.bam'
'BM1_DSm2_5781_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM1_DSm2_5781_UT.primary.dedup-UMI.SC.bam'
'BM2_DSm2_7080_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM2_DSm2_7080_UT.primary.dedup-UMI.SC.bam'
'BM3_DSm2_7079_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM3_DSm2_7079_UT.primary.dedup-UMI.SC.bam'
'BM4_DSp2_5781_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM4_DSp2_5781_UT.primary.dedup-UMI.SC.bam'
'BM5_DSp2_7080_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM5_DSp2_7080_UT.primary.dedup-UMI.SC.bam'
'BM6_DSp2_7079_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM6_DSp2_7079_UT.primary.dedup-UMI.SC.bam'
'BM7_DSp24_5781_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM7_DSp24_5781_UT.primary.dedup-UMI.SC.bam'
'BM8_DSp24_7080_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM8_DSp24_7080_UT.primary.dedup-UMI.SC.bam'
'BM9_DSp24_7079_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM9_DSp24_7079_UT.primary.dedup-UMI.SC.bam'
'Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.bam'
'Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.bam'
'Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.bam'
'Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.bam'
'Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.bam'
'Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.bam'
'Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.bam'
'Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.bam'
'Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.bam'
'Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.bam'
'Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.bam'
'Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.bam'
'CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam'
'CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam'
'CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam'
'CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam'
'CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam'
'CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam'
'CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam'
'CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam'
'CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam'
'CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam'
'CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.bam'
'CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.bam'
'CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.bam'
'CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.bam'
'CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.bam'
'CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.bam'
'CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.bam'
'CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.bam'
'CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.bam'
'CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.bam'
'CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.bam'
'CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.bam'
'CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.bam'
'CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.bam'
'CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.bam'
'DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.bam'
'DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.bam'
'DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.bam'
'DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.bam' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.bam'
'5781_G1_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_G1_IN_UT.primary.dedup-UMI.SC.bam.bai'
'5781_G1_IP_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_G1_IP_UT.primary.dedup-UMI.SC.bam.bai'
'5781_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'5781_Q_IP_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5781_Q_IP_UT.primary.dedup-UMI.SC.bam.bai'
'5782_G1_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_G1_IN_UT.primary.dedup-UMI.SC.bam.bai'
'5782_G1_IP_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_G1_IP_UT.primary.dedup-UMI.SC.bam.bai'
'5782_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'5782_Q_IP_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/5782_Q_IP_UT.primary.dedup-UMI.SC.bam.bai'
'BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM10_DSp48_5781_new_UT.primary.dedup-UMI.SC.bam.bai'
'BM10_DSp48_5781_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM10_DSp48_5781_UT.primary.dedup-UMI.SC.bam.bai'
'BM11_DSp48_7080_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM11_DSp48_7080_UT.primary.dedup-UMI.SC.bam.bai'
'BM12_DSp48_7079_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM12_DSp48_7079_UT.primary.dedup-UMI.SC.bam.bai'
'BM1_DSm2_5781_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM1_DSm2_5781_UT.primary.dedup-UMI.SC.bam.bai'
'BM2_DSm2_7080_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM2_DSm2_7080_UT.primary.dedup-UMI.SC.bam.bai'
'BM3_DSm2_7079_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM3_DSm2_7079_UT.primary.dedup-UMI.SC.bam.bai'
'BM4_DSp2_5781_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM4_DSp2_5781_UT.primary.dedup-UMI.SC.bam.bai'
'BM5_DSp2_7080_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM5_DSp2_7080_UT.primary.dedup-UMI.SC.bam.bai'
'BM6_DSp2_7079_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM6_DSp2_7079_UT.primary.dedup-UMI.SC.bam.bai'
'BM7_DSp24_5781_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM7_DSp24_5781_UT.primary.dedup-UMI.SC.bam.bai'
'BM8_DSp24_7080_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM8_DSp24_7080_UT.primary.dedup-UMI.SC.bam.bai'
'BM9_DSp24_7079_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/BM9_DSp24_7079_UT.primary.dedup-UMI.SC.bam.bai'
'Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp10_DSp48_5782_UT.primary.dedup-UMI.SC.bam.bai'
'Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp11_DSp48_7081_UT.primary.dedup-UMI.SC.bam.bai'
'Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp12_DSp48_7078_UT.primary.dedup-UMI.SC.bam.bai'
'Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp1_DSm2_5782_UT.primary.dedup-UMI.SC.bam.bai'
'Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp2_DSm2_7081_UT.primary.dedup-UMI.SC.bam.bai'
'Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp3_DSm2_7078_UT.primary.dedup-UMI.SC.bam.bai'
'Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp4_DSp2_5782_UT.primary.dedup-UMI.SC.bam.bai'
'Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp5_DSp2_7081_UT.primary.dedup-UMI.SC.bam.bai'
'Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp6_DSp2_7078_UT.primary.dedup-UMI.SC.bam.bai'
'Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp7_DSp24_5782_UT.primary.dedup-UMI.SC.bam.bai'
'Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp8_DSp24_7081_UT.primary.dedup-UMI.SC.bam.bai'
'Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/Bp9_DSp24_7078_UT.primary.dedup-UMI.SC.bam.bai'
'CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai'
'CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai'
'CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai'
'CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai'
'CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai'
'CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai'
'CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai'
'CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai'
'CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai'
'CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai'
'CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.SC.bam.bai'
'CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.SC.bam.bai'
'CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai'
'CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai'
'CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai'
'CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai'
'CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai'
'CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.SC.bam.bai'
'CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.SC.bam.bai'
'CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.SC.bam.bai'
'DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA1_5781_SS_G1_UT.primary.dedup-UMI.SC.bam.bai'
'DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA2_5782_SS_G1_UT.primary.dedup-UMI.SC.bam.bai'
'DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA3_7078_SS_G1_UT.primary.dedup-UMI.SC.bam.bai'
'DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.bam.bai' -> '/home/kalavatt/tsukiyamalab/alisong/bams_UT_prim_SC_2023-0314/DA4_7079_SS_G1_UT.primary.dedup-UMI.SC.bam.bai'
```
</details>
<br />
<br />
