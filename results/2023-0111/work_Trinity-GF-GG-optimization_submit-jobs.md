
`work_Trinity-GF_optimization_submit-jobs.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [PRE Set up the experiment directory, `results/2023-0111`](#pre-set-up-the-experiment-directory-results2023-0111)
	1. [Get situated, make necessary directories](#get-situated-make-necessary-directories)
	1. [Symlink to datasets needed for Trinity GF and GG modes](#symlink-to-datasets-needed-for-trinity-gf-and-gg-modes)
		1. [Read in function for finding relative paths](#read-in-function-for-finding-relative-paths)
			1. [Code](#code)
		1. [Find relative paths for Trinity GF and GG files](#find-relative-paths-for-trinity-gf-and-gg-files)
			1. [Code](#code-1)
		1. [Create arrays for the original Trinity GF and GG files](#create-arrays-for-the-original-trinity-gf-and-gg-files)
			1. [Code](#code-2)
		1. [Create associative arrays for original and to-be-symlinked files](#create-associative-arrays-for-original-and-to-be-symlinked-files)
			1. [Code](#code-3)
			1. [Printed, notes](#printed-notes)
		1. [Loop through the associative arrays to create the symlinks](#loop-through-the-associative-arrays-to-create-the-symlinks)
			1. [Code](#code-4)
	1. [Singularity has issues with symlinked files; copy them directly](#singularity-has-issues-with-symlinked-files-copy-them-directly)
		1. [Address the problem for Trinity GF mode](#address-the-problem-for-trinity-gf-mode)
			1. [Remove the symlinks](#remove-the-symlinks)
				1. [Code](#code-5)
			1. [Copy over files of interest](#copy-over-files-of-interest)
				1. [Code](#code-6)
		1. [Address the problem for Trinity GG mode](#address-the-problem-for-trinity-gg-mode)
			1. [Remove the symlinks](#remove-the-symlinks-1)
				1. [Code](#code-7)
			1. [Copy over files of interest](#copy-over-files-of-interest-1)
				1. [Code](#code-8)
1. [I Run echo tests](#i-run-echo-tests)
	1. [pre Get situated, make necessary directories](#pre-get-situated-make-necessary-directories)
		1. [Code](#code-9)
	1. [i Run an echo test for Trinity GF mode with Q_N data](#i-run-an-echo-test-for-trinity-gf-mode-with-q_n-data)
		1. [01 Define variables, arrays](#01-define-variables-arrays)
			1. [Code](#code-10)
		1. [02 Generate lists of permuted parameters](#02-generate-lists-of-permuted-parameters)
			1. [02a Write the "master list"](#02a-write-the-master-list)
				1. [Code](#code-11)
				1. [Printed](#printed)
			1. [02b Write individual lists](#02b-write-individual-lists)
				1. [Code](#code-12)
				1. [Printed](#printed-1)
		1. [03 Use a `HEREDOC` to write the echo-test submission script](#03-use-a-heredoc-to-write-the-echo-test-submission-script)
			1. [Code](#code-13)
		1. [04 Use a `HEREDOC` to write the echo-test run script](#04-use-a-heredoc-to-write-the-echo-test-run-script)
			1. [Code](#code-14)
		1. [05 sbatch/srun the echo test](#05-sbatchsrun-the-echo-test)
			1. [Code](#code-15)
	1. [ii Run an echo test for Trinity GG mode with Q_N data](#ii-run-an-echo-test-for-trinity-gg-mode-with-q_n-data)
		1. [01 Define variables, arrays](#01-define-variables-arrays-1)
			1. [Code](#code-16)
		1. [02 Generate lists of permuted parameters](#02-generate-lists-of-permuted-parameters-1)
			1. [02a Write the "master list"](#02a-write-the-master-list-1)
				1. [Code](#code-17)
				1. [Printed](#printed-2)
			1. [02b Write individual lists](#02b-write-individual-lists-1)
				1. [Code](#code-18)
				1. [Printed](#printed-3)
		1. [03 Use a `HEREDOC` to write the echo-test submission script](#03-use-a-heredoc-to-write-the-echo-test-submission-script-1)
			1. [Code](#code-19)
		1. [04 Use a `HEREDOC` to write the echo-test run script](#04-use-a-heredoc-to-write-the-echo-test-run-script-1)
			1. [Code](#code-20)
		1. [05 sbatch/srun the echo test](#05-sbatchsrun-the-echo-test-1)
			1. [Code](#code-21)
1. [II Run Trinity](#ii-run-trinity)
	1. [pre Get situated, make necessary directories](#pre-get-situated-make-necessary-directories-1)
		1. [Code](#code-22)
	1. [i Run Trinity GF mode with Q_N data](#i-run-trinity-gf-mode-with-q_n-data)
		1. [01 Define variables, arrays](#01-define-variables-arrays-2)
			1. [Code](#code-23)
		1. [02 Generate lists of permuted parameters](#02-generate-lists-of-permuted-parameters-2)
			1. [02a Write the "master list"](#02a-write-the-master-list-2)
				1. [Code](#code-24)
			1. [02b Write individual lists](#02b-write-individual-lists-2)
				1. [Code](#code-25)
		1. [03 Use a `HEREDOC` to write the submission script](#03-use-a-heredoc-to-write-the-submission-script)
			1. [Code](#code-26)
		1. [04 Use a `HEREDOC` to write the run script](#04-use-a-heredoc-to-write-the-run-script)
			1. [Code](#code-27)
		1. [05 sbatch/srun Trinity](#05-sbatchsrun-trinity)
			1. [Code](#code-28)
	1. [ii Run Trinity GG mode with Q_N data](#ii-run-trinity-gg-mode-with-q_n-data)
		1. [01 Define variables, arrays](#01-define-variables-arrays-3)
			1. [Code](#code-29)
		1. [02 Generate lists of permuted parameters](#02-generate-lists-of-permuted-parameters-3)
			1. [02a Write the "master list"](#02a-write-the-master-list-3)
				1. [Code](#code-30)
			1. [02b Write individual lists](#02b-write-individual-lists-3)
				1. [Code](#code-31)
		1. [03 Use a `HEREDOC` to write the submission script](#03-use-a-heredoc-to-write-the-submission-script-1)
			1. [Code](#code-32)
		1. [04 Use a `HEREDOC` to write the run script](#04-use-a-heredoc-to-write-the-run-script-1)
			1. [Code](#code-33)
		1. [05 sbatch/srun Trinity](#05-sbatchsrun-trinity-1)
			1. [Code](#code-34)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="pre-set-up-the-experiment-directory-results2023-0111"></a>
## <u>PRE</u> Set up the experiment directory, `results/2023-0111`
<a id="get-situated-make-necessary-directories"></a>
### Get situated, make necessary directories
<details>
<summary><i>Code: Get situated, make necessary directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0111" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env

mkdir -p infiles_Trinity-{GG,GF}/
```
</details>
<br />

<a id="symlink-to-datasets-needed-for-trinity-gf-and-gg-modes"></a>
### Symlink to datasets needed for Trinity GF and GG modes
<a id="read-in-function-for-finding-relative-paths"></a>
#### Read in function for finding relative paths
<a id="code"></a>
##### Code
<details>
<summary><i>Code: Read in function for finding relative paths</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}
```
</details>
<br />

<a id="find-relative-paths-for-trinity-gf-and-gg-files"></a>
#### Find relative paths for Trinity GF and GG files
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: Find relative paths for Trinity GF and GG files</i></summary>

```bash
cd infiles_Trinity-GF/ \
    || echo "cd'ing failed; check on this..."
ori_GF="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq"
rel_GF="$(find_relative_path "." "${ori_GF}")"  # echo "${rel_GF}"

cd ../infiles_Trinity-GG/ \
    || echo "cd'ing failed; check on this..."
ori_GG="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/"
rel_GG="$(find_relative_path "." "${ori_GG}")"  # echo "${rel_GG}"

transcriptome && 
    {
        cd "results/2023-0111" \
            || echo "cd'ing failed; check on this..."
    }
```
</details>
<br />

<a id="create-arrays-for-the-original-trinity-gf-and-gg-files"></a>
#### Create arrays for the original Trinity GF and GG files
<a id="code-2"></a>
##### Code
<details>
<summary><i>Code: Create arrays for the original Trinity GF and GG files</i></summary>

```bash
unset f_ori_GF
typeset -a f_ori_GF
while IFS=" " read -r -d $'\0'; do
    f_ori_GF+=( "${REPLY}" )
done < <(\
        find "${ori_GF}" \
            -type f \
            -name "*.fq.gz" \
            -print0 \
                | sort -z\
)
echo_test "${f_ori_GF[@]}"
echo "${#f_ori_GF[@]}"  # 16

unset f_ori_GG
typeset -a f_ori_GG
while IFS=" " read -r -d $'\0'; do
    f_ori_GG+=( "${REPLY}" )
done < <(\
        find "${ori_GG}" \
            -type f \
            -name "*.bam" \
            -print0 \
                | sort -z\
)
echo_test "${f_ori_GG[@]}"
echo "${#f_ori_GG[@]}"  # 4
```
</details>
<br />

<a id="create-associative-arrays-for-original-and-to-be-symlinked-files"></a>
#### Create associative arrays for original and to-be-symlinked files
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Create associative arrays for original and to-be-symlinked files</i></summary>

```bash
unset f_sym_GF
typeset -A f_sym_GF
for i in "${f_ori_GF[@]}"; do
    # i="${f_ori_GF[0]}"  # echo "${i}"
    init="$(basename "${i}")"  # echo "${init}"
    
    if [[ "${init}" == *"_UTK.proper-etc.SC.1.fq.gz"* ]]; then
        tmp1="${init%_UTK.proper-etc.SC.1.fq.gz}.1.fq.gz"
    elif [[ "${init}" == *"_UTK.proper-etc.SC.2.fq.gz"* ]]; then
        tmp1="${init%_UTK.proper-etc.SC.2.fq.gz}.2.fq.gz"
    fi
    echo "${tmp1}"

    if [[ "${tmp1}" == *"IN"* ]]; then
        tmp2="$(echo "${tmp1}" | sed 's/IN/S/g')"
    elif [[ "${tmp1}" == *"IP"* ]]; then
        tmp2="$(echo "${tmp1}" | sed 's/IP/N/g')"
    fi
    # echo "${tmp2}"

    if [[ "${tmp2}" == *"G1"* ]]; then
        fq="$(echo "${tmp2}" | sed 's/G1/G/g')"
    else
        fq="${tmp2}"
    fi
    echo "${fq}"
    echo ""
    
    f_sym_GF["${fq}"]="${rel_GF}/${init}"
done
echo_test "${!f_sym_GF[@]}"  # Keys
echo_test "${f_sym_GF[@]}"  # Values

unset f_sym_GG
typeset -A f_sym_GG
for i in "${f_ori_GG[@]}"; do
    # i="${f_ori_GG[0]}"  # echo "${i}"
    init="$(basename "${i}")"
    echo "${init}"

    tmp1="${init%_UTK.primary-secondary.SC.bam}.bam"
    echo "${tmp1}"

    tmp2="${tmp1#merged_}"
    echo "${tmp2}"

    if [[ "${tmp2}" == *"IN"* ]]; then
        tmp3="$(echo "${tmp2}" | sed 's/IN/S/g')"
    elif [[ "${tmp2}" == *"IP"* ]]; then
        tmp3="$(echo "${tmp2}" | sed 's/IP/N/g')"
    fi
    echo "${tmp3}"

    if [[ "${tmp3}" == *"G1"* ]]; then
        bm="$(echo "${tmp3}" | sed 's/G1/G/g')"
    else
        bm="${tmp3}"
    fi
    echo "${bm}"
    echo ""
    
    f_sym_GG["${bm}"]="${rel_GG}/${init}"
done
echo_test "${!f_sym_GG[@]}"  # Keys
echo_test "${f_sym_GG[@]}"  # Values
```
</details>
<br />

<a id="printed-notes"></a>
##### Printed, notes
<details>
<summary><i>Printed, notes: Symlink to datasets needed for Trinity GF and GG modes</i></summary>

```txt
❯ while IFS=" " read -r -d $'\0'; do
>     f_ori_GF+=( "${REPLY}" )
> done < <(\
>         find "${ori_GF}" \
>             -type f \
>             -name "*.fq.gz" \
>             -print0 \
>                 | sort -z\
> )

❯ echo_test "${f_ori_GF[@]}"
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz

❯ echo "${#f_ori_GF[@]}"  # 165
16


❯ while IFS=" " read -r -d $'\0'; do
>     f_ori_GG+=( "${REPLY}" )
> done < <(\
>         find "${ori_GG}" \
>             -type f \
>             -name "*.bam" \
>             -print0 \
>                 | sort -z\
> )

❯ echo_test "${f_ori_GG[@]}"
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam

❯ echo "${#f_ori_GG[@]}"
4


❯ for i in "${f_ori_GF[@]}"; do
>     # i="${f_ori_GF[0]}"  # echo "${i}"
>     init="$(basename "${i}")"  # echo "${init}"
> 
>     if [[ "${init}" == *"_UTK.proper-etc.SC.1.fq.gz"* ]]; then
>         tmp1="${init%_UTK.proper-etc.SC.1.fq.gz}.1.fq.gz"
>     elif [[ "${init}" == *"_UTK.proper-etc.SC.2.fq.gz"* ]]; then
>         tmp1="${init%_UTK.proper-etc.SC.2.fq.gz}.2.fq.gz"
>     fi
>     echo "${tmp1}"
> 
>     if [[ "${tmp1}" == *"IN"* ]]; then
>         tmp2="$(echo "${tmp1}" | sed 's/IN/S/g')"
>     elif [[ "${tmp1}" == *"IP"* ]]; then
>         tmp2="$(echo "${tmp1}" | sed 's/IP/N/g')"
>     fi
>     # echo "${tmp2}"
> 
>     if [[ "${tmp2}" == *"G1"* ]]; then
>         fq="$(echo "${tmp2}" | sed 's/G1/G/g')"
>     else
>         fq="${tmp2}"
>     fi
>     echo "${fq}"
>     echo ""
> 
>     f_sym_GF["${fq}"]="${rel_GF}/${init}"
> done
5781_G1_IN.1.fq.gz
5781_G_S.1.fq.gz

5781_G1_IN.2.fq.gz
5781_G_S.2.fq.gz

5781_G1_IP.1.fq.gz
5781_G_N.1.fq.gz

5781_G1_IP.2.fq.gz
5781_G_N.2.fq.gz

5781_Q_IN.1.fq.gz
5781_Q_S.1.fq.gz

5781_Q_IN.2.fq.gz
5781_Q_S.2.fq.gz

5781_Q_IP.1.fq.gz
5781_Q_N.1.fq.gz

5781_Q_IP.2.fq.gz
5781_Q_N.2.fq.gz

5782_G1_IN.1.fq.gz
5782_G_S.1.fq.gz

5782_G1_IN.2.fq.gz
5782_G_S.2.fq.gz

5782_G1_IP.1.fq.gz
5782_G_N.1.fq.gz

5782_G1_IP.2.fq.gz
5782_G_N.2.fq.gz

5782_Q_IN.1.fq.gz
5782_Q_S.1.fq.gz

5782_Q_IN.2.fq.gz
5782_Q_S.2.fq.gz

5782_Q_IP.1.fq.gz
5782_Q_N.1.fq.gz

5782_Q_IP.2.fq.gz
5782_Q_N.2.fq.gz

❯ echo_test "${f_sym_GF[@]}"
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz

❯ echo_test "${!f_sym_GF[@]}"  # Keys
5781_G_S.1.fq.gz
5782_G_N.2.fq.gz
5782_Q_S.2.fq.gz
5782_G_S.2.fq.gz
5781_Q_S.2.fq.gz
5782_Q_N.1.fq.gz
5781_G_S.2.fq.gz
5782_G_N.1.fq.gz
5782_Q_N.2.fq.gz
5781_Q_N.1.fq.gz
5781_Q_S.1.fq.gz
5781_G_N.1.fq.gz
5782_Q_S.1.fq.gz
5782_G_S.1.fq.gz
5781_Q_N.2.fq.gz
5781_G_N.2.fq.gz

# (spot check)
5781_G_S.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz
5782_G_N.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz
5782_Q_S.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz
5782_G_S.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz
5781_Q_S.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz
5782_Q_N.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz
5781_G_S.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz
5782_G_N.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz
5782_Q_N.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz
5781_Q_N.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz
5781_Q_S.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz
5781_G_N.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz
5782_Q_S.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz
5782_G_S.1.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz
5781_Q_N.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz
5781_G_N.2.fq.gz ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz

5781_G_S.1.fq.gz 5781_G1_IN_UTK.proper-etc.SC.1.fq.gz
5782_G_N.2.fq.gz 5782_G1_IP_UTK.proper-etc.SC.2.fq.gz
5782_Q_S.2.fq.gz 5782_Q_IN_UTK.proper-etc.SC.2.fq.gz
5782_G_S.2.fq.gz 5782_G1_IN_UTK.proper-etc.SC.2.fq.gz
5781_Q_S.2.fq.gz 5781_Q_IN_UTK.proper-etc.SC.2.fq.gz
5782_Q_N.1.fq.gz 5782_Q_IP_UTK.proper-etc.SC.1.fq.gz
5781_G_S.2.fq.gz 5781_G1_IN_UTK.proper-etc.SC.2.fq.gz
5782_G_N.1.fq.gz 5782_G1_IP_UTK.proper-etc.SC.1.fq.gz
5782_Q_N.2.fq.gz 5782_Q_IP_UTK.proper-etc.SC.2.fq.gz
5781_Q_N.1.fq.gz 5781_Q_IP_UTK.proper-etc.SC.1.fq.gz
5781_Q_S.1.fq.gz 5781_Q_IN_UTK.proper-etc.SC.1.fq.gz
5781_G_N.1.fq.gz 5781_G1_IP_UTK.proper-etc.SC.1.fq.gz
5782_Q_S.1.fq.gz 5782_Q_IN_UTK.proper-etc.SC.1.fq.gz
5782_G_S.1.fq.gz 5782_G1_IN_UTK.proper-etc.SC.1.fq.gz
5781_Q_N.2.fq.gz 5781_Q_IP_UTK.proper-etc.SC.2.fq.gz
5781_G_N.2.fq.gz 5781_G1_IP_UTK.proper-etc.SC.2.fq.gz

5781_G_S.1.fq.gz 5781_G1_IN_UTK
5782_G_N.2.fq.gz 5782_G1_IP_UTK
5782_Q_S.2.fq.gz 5782_Q_IN_UTK
5782_G_S.2.fq.gz 5782_G1_IN_UTK
5781_Q_S.2.fq.gz 5781_Q_IN_UTK
5782_Q_N.1.fq.gz 5782_Q_IP_UTK
5781_G_S.2.fq.gz 5781_G1_IN_UTK
5782_G_N.1.fq.gz 5782_G1_IP_UTK
5782_Q_N.2.fq.gz 5782_Q_IP_UTK
5781_Q_N.1.fq.gz 5781_Q_IP_UTK
5781_Q_S.1.fq.gz 5781_Q_IN_UTK
5781_G_N.1.fq.gz 5781_G1_IP_UTK
5782_Q_S.1.fq.gz 5782_Q_IN_UTK
5782_G_S.1.fq.gz 5782_G1_IN_UTK
5781_Q_N.2.fq.gz 5781_Q_IP_UTK
5781_G_N.2.fq.gz 5781_G1_IP_UTK


❯ for i in "${f_ori_GG[@]}"; do
>     # i="${f_ori_GG[0]}"  # echo "${i}"
>     init="$(basename "${i}")"
>     echo "${init}"
> 
>     tmp1="${init%_UTK.primary-secondary.SC.bam}.bam"
>     echo "${tmp1}"
> 
>     tmp2="${tmp1#merged_}"
>     echo "${tmp2}"
> 
>     if [[ "${tmp2}" == *"IN"* ]]; then
>         tmp3="$(echo "${tmp2}" | sed 's/IN/S/g')"
>     elif [[ "${tmp2}" == *"IP"* ]]; then
>         tmp3="$(echo "${tmp2}" | sed 's/IP/N/g')"
>     fi
>     echo "${tmp3}"
> 
>     if [[ "${tmp3}" == *"G1"* ]]; then
>         bm="$(echo "${tmp3}" | sed 's/G1/G/g')"
>     else
>         bm="${tmp3}"
>     fi
>     echo "${bm}"
>     echo ""
> 
>     f_sym_GG["${bm}"]="${rel_GG}/${init}"
> done
merged_G1_IN_UTK.primary-secondary.SC.bam
merged_G1_IN.bam
G1_IN.bam
G1_S.bam
G_S.bam

merged_G1_IP_UTK.primary-secondary.SC.bam
merged_G1_IP.bam
G1_IP.bam

G1_N.bam
G_N.bam

merged_Q_IN_UTK.primary-secondary.SC.bam
merged_Q_IN.bam
Q_IN.bam
Q_S.bam
Q_S.bam

merged_Q_IP_UTK.primary-secondary.SC.bam
merged_Q_IP.bam
Q_IP.bam
Q_N.bam
Q_N.bam

❯ echo_test "${!f_sym_GG[@]}"  # Keys
Q_S.bam
G_N.bam
Q_N.bam
G_S.bam

❯ echo_test "${f_sym_GG[@]}"  # Values
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam
../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam

# (spot check)
Q_S.bam ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
G_N.bam ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
Q_N.bam ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam
G_S.bam ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam

Q_S.bam merged_Q_IN_UTK.primary-secondary.SC.bam
G_N.bam merged_G1_IP_UTK.primary-secondary.SC.bam
Q_N.bam merged_Q_IP_UTK.primary-secondary.SC.bam
G_S.bam merged_G1_IN_UTK.primary-secondary.SC.bam
```
</details>
<br />

<a id="loop-through-the-associative-arrays-to-create-the-symlinks"></a>
#### Loop through the associative arrays to create the symlinks
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Loop through the associative arrays to create the symlinks</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd infiles_Trinity-GF/
for i in "${!f_sym_GF[@]}"; do
    echo "#  ------------------------------------"
    echo "    Key: ${i}"
    echo "  Value: ${f_sym_GF[$i]}"
    echo ""
    echo "Command: "
    echo "    ln -s \\"
    echo "        ${f_sym_GF[$i]} \\"
    echo "        ${i}"
    echo ""
    echo ""
    
    ln -s "${f_sym_GF[$i]}" "${i}"
done
.,

cd ../infiles_Trinity-GG/
for i in "${!f_sym_GG[@]}"; do
    echo "#  ------------------------------------"
    echo "    Key: ${i}"
    echo "  Value: ${f_sym_GG[$i]}"
    echo ""
    echo "Command: "
    echo "    ln -s \\"
    echo "        ${f_sym_GG[$i]} \\"
    echo "        ${i}"
    echo ""
    echo ""
    
    ln -s "${f_sym_GG[$i]}" "${i}"
done
.,
```
</details>
<br />

<details>
<summary><i>Printed: Loop through the associative arrays to create the symlinks</i></summary>

```txt
❯ cd infiles_Trinity-GF/
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF

❯ for i in "${!f_sym_GF[@]}"; do
>     echo "#  ------------------------------------"
>     echo "    Key: ${i}"
>     echo "  Value: ${f_sym_GF[$i]}"
>     echo ""
>     echo "Command: "
>     echo "    ln -s \\"
>     echo "        ${f_sym_GF[$i]} \\"
>     echo "        ${i}"
>     echo ""
>     echo ""
> 
>     ln -s "${f_sym_GF[$i]}" "${i}"
> done
#  ------------------------------------
    Key: 5781_G_S.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz \
        5781_G_S.1.fq.gz


#  ------------------------------------
    Key: 5782_G_N.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz \
        5782_G_N.2.fq.gz


#  ------------------------------------
    Key: 5782_Q_S.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz \
        5782_Q_S.2.fq.gz


#  ------------------------------------
    Key: 5782_G_S.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz \
        5782_G_S.2.fq.gz


#  ------------------------------------
    Key: 5781_Q_S.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz \
        5781_Q_S.2.fq.gz


#  ------------------------------------
    Key: 5782_Q_N.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz \
        5782_Q_N.1.fq.gz


#  ------------------------------------
    Key: 5781_G_S.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz \
        5781_G_S.2.fq.gz


#  ------------------------------------
    Key: 5782_G_N.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz \
        5782_G_N.1.fq.gz


#  ------------------------------------
    Key: 5782_Q_N.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz \
        5782_Q_N.2.fq.gz


#  ------------------------------------
    Key: 5781_Q_N.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz \
        5781_Q_N.1.fq.gz


#  ------------------------------------
    Key: 5781_Q_S.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz \
        5781_Q_S.1.fq.gz


#  ------------------------------------
    Key: 5781_G_N.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz \
        5781_G_N.1.fq.gz


#  ------------------------------------
    Key: 5782_Q_S.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz \
        5782_Q_S.1.fq.gz


#  ------------------------------------
    Key: 5782_G_S.1.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz \
        5782_G_S.1.fq.gz


#  ------------------------------------
    Key: 5781_Q_N.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz \
        5781_Q_N.2.fq.gz


#  ------------------------------------
    Key: 5781_G_N.2.fq.gz
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz \
        5781_G_N.2.fq.gz

❯ .,
total 544K
drwxrws--- 2 kalavatt 544 Feb 14 09:16 ./
drwxrws--- 7 kalavatt 263 Feb 14 09:16 ../
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5781_G_N.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5781_G_N.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5781_G_S.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5781_G_S.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5781_Q_N.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5781_Q_N.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5781_Q_S.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5781_Q_S.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IN_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5782_G_N.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5782_G_N.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5782_G_S.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:16 5782_G_S.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IN_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5782_Q_N.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5782_Q_N.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5782_Q_S.1.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.1.fq.gz
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:16 5782_Q_S.2.fq.gz -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IN_UTK.proper-etc.SC.2.fq.gz

❯ cd ../infiles_Trinity-GG/

❯ for i in "${!f_sym_GG[@]}"; do
>     echo "#  ------------------------------------"
>     echo "    Key: ${i}"
>     echo "  Value: ${f_sym_GG[$i]}"
>     echo ""
>     echo "Command: "
>     echo "    ln -s \\"
>     echo "        ${f_sym_GG[$i]} \\"
>     echo "        ${i}"
>     echo ""
>     echo ""
> 
>     ln -s "${f_sym_GG[$i]}" "${i}"
> done
#  ------------------------------------
    Key: Q_S.bam
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam \
        Q_S.bam


#  ------------------------------------
    Key: G_N.bam
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam \
        G_N.bam


#  ------------------------------------
    Key: Q_N.bam
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam \
        Q_N.bam


#  ------------------------------------
    Key: G_S.bam
  Value: ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam

Command:
    ln -s \
        ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam \
        G_S.bam

❯ .,
total 192K
drwxrws--- 2 kalavatt 100 Feb 14 09:17 ./
drwxrws--- 7 kalavatt 263 Feb 14 09:16 ../
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:17 G_N.bam -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam
lrwxrwxrwx 1 kalavatt 121 Feb 14 09:17 G_S.bam -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IN_UTK.primary-secondary.SC.bam
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:17 Q_N.bam -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam
lrwxrwxrwx 1 kalavatt 120 Feb 14 09:17 Q_S.bam -> ../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IN_UTK.primary-secondary.SC.bam
```
</details>
<br />

<a id="singularity-has-issues-with-symlinked-files-copy-them-directly"></a>
### Singularity has issues with symlinked files; copy them directly
<a id="address-the-problem-for-trinity-gf-mode"></a>
#### Address the problem for Trinity GF mode
<a id="remove-the-symlinks"></a>
##### Remove the symlinks
<a id="code-5"></a>
###### Code
<details>
<summary><i>Code: Remove the symlinks</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd infiles_Trinity-GF \
	|| echo "cd'ing failed; check on this..."

for i in *.fq.gz; do unlink "${i}"; done
```
</details>
<br />

<a id="copy-over-files-of-interest"></a>
##### Copy over files of interest
<a id="code-6"></a>
###### Code
<details>
<summary><i>Code: Copy over files of interest</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  5781_G_N
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.1.fq.gz \
	5781_G_N.1.fq.gz
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IP_UTK.proper-etc.SC.2.fq.gz \
	5781_G_N.2.fq.gz

#  5781_Q_N
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.1.fq.gz \
	5781_Q_N.1.fq.gz
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_Q_IP_UTK.proper-etc.SC.2.fq.gz \
	5781_Q_N.2.fq.gz

#  5782_G_N
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.1.fq.gz \
	5782_G_N.1.fq.gz
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_G1_IP_UTK.proper-etc.SC.2.fq.gz \
	5782_G_N.2.fq.gz

#  5782_Q_N
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.1.fq.gz \
	5782_Q_N.1.fq.gz
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5782_Q_IP_UTK.proper-etc.SC.2.fq.gz \
	5782_Q_N.2.fq.gz
```
</details>
<br />

<a id="address-the-problem-for-trinity-gg-mode"></a>
#### Address the problem for Trinity GG mode
<a id="remove-the-symlinks-1"></a>
##### Remove the symlinks
<a id="code-7"></a>
###### Code
<details>
<summary><i>Code: Remove the symlinks</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ../infiles_Trinity-GG \
	|| echo "cd'ing failed; check on this..."

for i in *.bam; do unlink "${i}"; done
```
</details>
<br />

<a id="copy-over-files-of-interest-1"></a>
##### Copy over files of interest
<a id="code-8"></a>
###### Code
<details>
<summary><i>Code: Copy over files of interest</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  G_N
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_G1_IP_UTK.primary-secondary.SC.bam \
	G_N.bam

#  Q_N
cp \
	../../2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged/merged_Q_IP_UTK.primary-secondary.SC.bam \
	Q_N.bam
```
</details>
<br />
<br />

<a id="i-run-echo-tests"></a>
## <u>I</u> Run echo tests
<a id="pre-get-situated-make-necessary-directories"></a>
### <u>pre</u> Get situated, make necessary directories
<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: Get situated, make necessary directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0111" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env

mkdir -p sh_err_out/err_out/Trinity-{GG,GF}/{Q_N,G_N}
mkdir -p outfiles_Trinity-{GG,GF}/{Q_N,G_N}/lists
```
</details>
<br />

<a id="i-run-an-echo-test-for-trinity-gf-mode-with-q_n-data"></a>
### <u>i</u> Run an echo test for Trinity GF mode with Q_N data
<a id="01-define-variables-arrays"></a>
#### 01 Define variables, arrays
<a id="code-10"></a>
##### Code
<details>
<summary><i>Code: Define variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Experiment details -------------------------------------
cell_exp="Q_N"  # echo "${cell_exp}"
mode="Trinity-GF"  # echo "${mode}"


#  Indirectory (outdirectory and infiles are below) -------
d_files="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_${mode}"  # ls -1 "${d_files}"  #ABSPATH


#  SLURM parameters ---------------------------------------
threads=6  # echo "${threads}"
max_id_job=$(( 6 * 4 * 3 * 4 ))  # echo "${max_id_job}"
max_id_task=4 # echo "${max_id_task}"


#  Directories to bind ------------------------------------
catalog="${d_files}"  # echo "${catalog}"  #REDUNDANT #ABSPATH
scratch="/fh/scratch/delete30/tsukiyama_t"  # echo "${scratch}"  #ABSPATH


#  Trinity GF arguments, parameters, and infiles ----------
j_mem="50G"  # echo "${j_mem}"
j_cor="${threads}"  # echo "${j_cor}" #REDUNDANT

fq_1="1.fq.gz"  # echo "${fq_1}"
fq_2="2.fq.gz"  # echo "${fq_2}"
left_1="${d_files}/5781_${cell_exp}.${fq_1}"  # echo "${left_1}"  #INFILE  #ABSPATH
left_2="${d_files}/5782_${cell_exp}.${fq_1}"  # echo "${left_2}"  #INFILE  #ABSPATH
right_1="${d_files}/5781_${cell_exp}.${fq_2}"  # echo "${right_1}"  #INFILE  #ABSPATH
right_2="${d_files}/5782_${cell_exp}.${fq_2}"  # echo "${right_2}"  #INFILE  #ABSPATH

unset min_kmer_cov
unset min_iso_ratio
unset min_glue
unset glue_factor
typeset -a min_kmer_cov=(1 2 4 8 16 32)  # echo_test "${min_kmer_cov[@]}"
typeset -a min_iso_ratio=(0.005 0.01 0.05 0.1)  # echo_test "${min_iso_ratio[@]}"
typeset -a min_glue=(1 2 4)  # echo_test "${min_glue[@]}"
typeset -a glue_factor=(0.005 0.01 0.05 0.1)  # echo_test "${glue_factor[@]}"


#  Outdirectory -------------------------------------------
d_base="$(dirname "${d_files}")"  # echo "${d_base}"  #ABSPATH
d_mid="outfiles_${mode}/${cell_exp}"  # echo "${d_mid}"
pre="echo-test_trinity"  # echo "${pre}"
out="${d_base}/${d_mid}/${pre}"  # echo "${out}"  #ABSPATH


#  Parameter lists and their storage ----------------------
store="${d_base}/${d_mid}/lists"  # ., "${store}"  #ABSPATH
list="lists.txt"  # echo "${list}"


#  Scripts ------------------------------------------------
script_name_sub="echo_${mode}_${cell_exp}.sh"  # echo "${script_name_sub}"
script_name_run="run_${mode}_${cell_exp}.sh"  # echo "${script_name_run}"


#  Storage for scripts, STDERR, and STDOUT ----------------
sh_err_out="${d_base}/sh_err_out"  # echo "${sh_err_out}"  #ABSPATH
err_out="${sh_err_out}/err_out/${mode}/${cell_exp}"  # echo "${err_out}"  #ABSPATH
```
</details>
<br />

<a id="02-generate-lists-of-permuted-parameters"></a>
#### 02 Generate lists of permuted parameters
<a id="02a-write-the-master-list"></a>
##### 02a Write the "master list"
<a id="code-11"></a>
###### Code
<details>
<summary><i>Code: Write the "master list"</i></summary>

*Header*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list}" ]]; then
    rm "${store}/${list}"
fi

#  Header
echo "catalog \
scratch \
j_mem \
j_cor \
left_1 \
left_2 \
right_1 \
right_2 \
out \
min_kmer_cov \
min_iso_ratio \
min_glue \
glue_factor" \
    > "${store}/${list}"
# cat -n "${store}/${list}"
#     vi "${store}/${list}"  # :q
#  wc -l "${store}/${list}" | cut -d " " -f 1

#  Body
parallel --header : --colsep " " -k -j 1 echo \
    '{catalog} \
    {scratch} \
    {j_mem} \
    {j_cor} \
    {left_1} \
    {left_2} \
    {right_1} \
    {right_2} \
    {out}_mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
    {min_kmer_cov} \
    {min_iso_ratio} \
    {min_glue} \
    {glue_factor}' \
::: catalog "${catalog}" \
::: scratch "${scratch}" \
::: j_mem "${j_mem}"  \
::: j_cor "${j_cor}" \
::: left_1 "${left_1[@]}" \
:::+ left_2 "${left_2[@]}" \
:::+ right_1 "${right_1[@]}" \
:::+ right_2 "${right_2[@]}" \
::: out "${out}" \
::: min_kmer_cov "${min_kmer_cov[@]}" \
::: min_iso_ratio "${min_iso_ratio[@]}" \
::: min_glue "${min_glue[@]}" \
::: glue_factor "${glue_factor[@]}" \
    >> "${store}/${list}"
# cat -n "${store}/${list}"
#   less "${store}/${list}"
#  wc -l "${store}/${list}" | cut -d " " -f 1
```

<a id="printed"></a>
###### Printed
<details>
<summary><i>Printed: Write the "master list"</i></summary>

*Spot check: line 54*
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF
/fh/scratch/delete30/tsukiyama_t
50G
6
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GF/Q_N/echo-test_trinity_mkc-2_mir-0.005_mg-2_gf-0.005
2
0.005
2
0.005
```

*Spot check: line 177*
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF
/fh/scratch/delete30/tsukiyama_t
50G
6
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.1.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.2.fq.gz
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GF/Q_N/echo-test_trinity_mkc-8_mir-0.05_mg-2_gf-0.1
8
0.05
2
0.1
```
</details>
<br />

<a id="02b-write-individual-lists"></a>
##### 02b Write individual lists
<a id="code-12"></a>
###### Code
<details>
<summary><i>Code: Write individual lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list/.txt/.24.txt}" ]]; then
    rm "${store}/"*.{?,??,???}.txt
fi
#  ., "${store}"
#  vi "${store}/${list}"  # :q
# cat "${store}/${list}"  # :q

typeset -i i=0
sed 1d "${store}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store}/${individual}" ]] || rm "${store}/${individual}"
    # echo "${store}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store}/${list}" >> "${store}/${individual}"  # cat "${store}/${individual}"
    echo "${line}" >> "${store}/${individual}"  # cat "${store}/${individual}"

    # echo "Created file: ${store}/${individual}"
done
#     ., "${store}"
# cat -n "${store}/${list/.txt/.24.txt}"
#     vi "${store}/${list/.txt/.24.txt}"  # :q
```
</details>
<br />

<a id="printed-1"></a>
###### Printed
<details>
<summary><i>Printed: Write individual lists</i></summary>

*Reformatted*
```txt
❯ cat -n "${store}/${list/.txt/.24.txt}"
     1	catalog scratch j_mem j_cor left_1 left_2 right_1 right_2 out min_kmer_cov min_iso_ratio min_glue glue_factor
     2	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF
        /fh/scratch/delete30/tsukiyama_t
        50G
        6
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.1.fq.gz
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.1.fq.gz
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.2.fq.gz
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.2.fq.gz
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GF/Q_N/echo-test_trinity_mkc-1_mir-0.01_mg-4_gf-0.1
        1
        0.01
        4
        0.1
```
*Original*
```txt
❯ cat -n "${store}/${list/.txt/.24.txt}"
     1	catalog scratch j_mem j_cor left_1 left_2 right_1 right_2 out min_kmer_cov min_iso_ratio min_glue glue_factor
     2	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF /fh/scratch/delete30/tsukiyama_t 50G 6 /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.1.fq.gz /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.1.fq.gz /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5781_Q_N.2.fq.gz /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GF/5782_Q_N.2.fq.gz /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GF/Q_N/echo-test_trinity_mkc-1_mir-0.01_mg-4_gf-0.1 1 0.01 4 0.1
```
</details>
<br />

<a id="03-use-a-heredoc-to-write-the-echo-test-submission-script"></a>
#### 03 Use a `HEREDOC` to write the echo-test submission script
<a id="code-13"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the echo-test submission script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_sub}" ]]; then
    rm "${sh_err_out}/${script_name_sub}"
fi
cat << script > "${sh_err_out}/${script_name_sub}"
#!/bin/bash

#  ${script_name_sub}
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


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \\
        \$(( run_time/3600 )) \\
        \$(( run_time%3600/60 )) \\
        \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {left_1}         first of two .fastq.gz files for 'left' reads <chr>
    {left_2}         second of two .fastq.gz files for 'left' reads <chr>
    {right_1}        first of two .fastq.gz files for 'right' reads <chr>
    {right_2}        second of two .fastq.gz files for 'right' reads <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"


#  ------------------------------------
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel \\
    --header : \\
    --colsep " " \\
    -k \\
    -j 1 \\
    --dry-run \\
        'singularity run \\
            --bind {catalog}:/data \\
            --bind {scratch}:/loc/scratch \\
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
                    --output {out} \\
                    --full_cleanup \\
                    --min_kmer_cov {min_kmer_cov} \\
                    --min_iso_ratio {min_iso_ratio} \\
                    --min_glue {min_glue} \\
                    --glue_factor {glue_factor} \\
                    --max_reads_per_graph 2000 \\
                    --normalize_max_read_cov 200 \\
                    --group_pairs_distance 700 \\
                    --min_contig_length 200' \\
:::: "\${arguments}"

time_end="\$(date +%s)"
calculate_run_time "\${time_start}" "\${time_end}" "Trinity run time"
script
chmod +x "${sh_err_out}/${script_name_sub}"
# cat -n "${sh_err_out}/${script_name_sub}"
#     vi "${sh_err_out}/${script_name_sub}"  # :q
#     ., "${sh_err_out}/${script_name_sub}"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-the-echo-test-run-script"></a>
#### 04 Use a `HEREDOC` to write the echo-test run script
<a id="code-14"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the echo-test run script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_run}" ]]; then
    rm "${sh_err_out}/${script_name_run}"
fi
cat << script > "${sh_err_out}/${script_name_run}"
#!/bin/bash

#SBATCH --job-name=${script_name_sub}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_sub%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_sub%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}


#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')


mkc="mkc-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$10 }'
)"
mir="mir-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$11 }'
)"
mg="mg-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$12 }'
)"
gf="gf-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$13 }'
)"
name="${pre}_\${mkc}_\${mir}_\${mg}_\${gf}"

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${sh_err_out}/${script_name_sub}" \\
        -a "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  vi "${sh_err_out}/${script_name_run}"  # :q
# cat "${sh_err_out}/${script_name_run}"


#  Scraps ---------------------------------------------------------------------
# SLURM_ARRAY_TASK_ID=24
# mkc="mkc-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $10 }'
# )"
# mir="mir-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $11 }'
# )"
# mg="mg-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $12 }'
# )"
# gf="gf-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $13 }'
# )"
# name="${pre}_${mkc}_${mir}_${mg}_${gf}"
# echo "${name}"
```
</details>
<br />
<br />

<a id="05-sbatchsrun-the-echo-test"></a>
#### 05 sbatch/srun the echo test
<a id="code-15"></a>
##### Code
<details>
<summary><i>Code: sbatch/srun the echo test</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${sh_err_out}/${script_name_run}"
# skal
# cd "${err_out}" && .,f | tail -200
# .,f | tail -200
# cd -
```
</details>
<br />
<br />

<a id="ii-run-an-echo-test-for-trinity-gg-mode-with-q_n-data"></a>
### <u>ii</u> Run an echo test for Trinity GG mode with Q_N data
<a id="01-define-variables-arrays-1"></a>
#### 01 Define variables, arrays
<a id="code-16"></a>
##### Code
<details>
<summary><i>Code: Define variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Experiment details -------------------------------------
cell_exp="Q_N"  # echo "${cell_exp}"
mode="Trinity-GG"  # echo "${mode}"


#  Indirectory (outdirectory and infiles are below) -------
d_files="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_${mode}"  # ls -1 "${d_files}"  #ABSPATH


#  SLURM parameters ---------------------------------------
threads=6  # echo "${threads}"
max_id_job=$(( 6 * 4 * 3 * 4 ))  # echo "${max_id_job}"
max_id_task=4 # echo "${max_id_task}"


#  Directories to bind ------------------------------------
catalog="${d_files}"  # echo "${catalog}"  #REDUNDANT #ABSPATH
scratch="/fh/scratch/delete30/tsukiyama_t"  # echo "${scratch}"  #ABSPATH


#  Trinity GG arguments, parameters, and infiles ----------
j_mem="50G"  # echo "${j_mem}"
j_cor="${threads}"  # echo "${j_cor}" #REDUNDANT

bam="${d_files}/${cell_exp}.bam"  # echo "${bam}"  #INFILE  #ABSPATH

unset min_kmer_cov
unset min_iso_ratio
unset min_glue
unset glue_factor
typeset -a min_kmer_cov=(1 2 4 8 16 32)  # echo_test "${min_kmer_cov[@]}"
typeset -a min_iso_ratio=(0.005 0.01 0.05 0.1)  # echo_test "${min_iso_ratio[@]}"
typeset -a min_glue=(1 2 4)  # echo_test "${min_glue[@]}"
typeset -a glue_factor=(0.005 0.01 0.05 0.1)  # echo_test "${glue_factor[@]}"


#  Outdirectory -------------------------------------------
d_base="$(dirname "${d_files}")"  # echo "${d_base}"  #ABSPATH
d_mid="outfiles_${mode}/${cell_exp}"  # echo "${d_mid}"
pre="echo-test_trinity"  # echo "${pre}"
out="${d_base}/${d_mid}/${pre}"  # echo "${out}"  #ABSPATH


#  Parameter lists and their storage ----------------------
store="${d_base}/${d_mid}/lists"  # echo "${store}"  #ABSPATH
list="lists.txt"  # echo "${list}"


#  Scripts ------------------------------------------------
script_name_sub="echo_${mode}_${cell_exp}.sh"  # echo "${script_name_sub}"
script_name_run="run_${mode}_${cell_exp}.sh"  # echo "${script_name_run}"


#  Storage for scripts, STDERR, and STDOUT ----------------
sh_err_out="${d_base}/sh_err_out"  # echo "${sh_err_out}"  #ABSPATH
err_out="${sh_err_out}/err_out/${mode}/${cell_exp}"  # echo "${err_out}"  #ABSPATH
```
</details>
<br />

<a id="02-generate-lists-of-permuted-parameters-1"></a>
#### 02 Generate lists of permuted parameters
<a id="02a-write-the-master-list-1"></a>
##### 02a Write the "master list"
<a id="code-17"></a>
###### Code
<details>
<summary><i>Code: Write the "master list"</i></summary>

*Header*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list}" ]]; then
    rm "${store}/${list}"
fi

#  Header
echo "catalog \
scratch \
j_mem \
j_cor \
bam \
out \
min_kmer_cov \
min_iso_ratio \
min_glue \
glue_factor" \
    > "${store}/${list}"
# cat -n "${store}/${list}"
#     vi "${store}/${list}"  # :q
#  wc -l "${store}/${list}" | cut -d " " -f 1

#  Body
parallel --header : --colsep " " -k -j 1 echo \
    '{catalog} \
    {scratch} \
    {j_mem} \
    {j_cor} \
    {bam} \
    {out}_mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
    {min_kmer_cov} \
    {min_iso_ratio} \
    {min_glue} \
    {glue_factor}' \
::: catalog "${catalog}" \
::: scratch "${scratch}" \
::: j_mem "${j_mem}"  \
::: j_cor "${j_cor}" \
::: bam "${bam}" \
::: out "${out}" \
::: min_kmer_cov "${min_kmer_cov[@]}" \
::: min_iso_ratio "${min_iso_ratio[@]}" \
::: min_glue "${min_glue[@]}" \
::: glue_factor "${glue_factor[@]}" \
    >> "${store}/${list}"
# cat -n "${store}/${list}"
#   less "${store}/${list}"
#  wc -l "${store}/${list}" | cut -d " " -f 1
```

<a id="printed-2"></a>
###### Printed
<details>
<summary><i>Printed: Write the "master list"</i></summary>

*Spot check: line 56*
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG
/fh/scratch/delete30/tsukiyama_t
50G
6
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG/Q_N.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/echo-test_trinity_mkc-2_mir-0.005_mg-2_gf-0.05
2
0.005
2
0.05
```

*Spot check: line 231*
```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG
/fh/scratch/delete30/tsukiyama_t
50G
6
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG/Q_N.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/echo-test_trinity_mkc-16_mir-0.1_mg-1_gf-0.01
16
0.1
1
0.01
```
</details>
<br />

<a id="02b-write-individual-lists-1"></a>
##### 02b Write individual lists
<a id="code-18"></a>
###### Code
<details>
<summary><i>Code: Write individual lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list/.txt/.24.txt}" ]]; then
    rm "${store}/"*.{?,??,???}.txt
fi
#  ., "${store}"
#  vi "${store}/${list}"  # :q
# cat "${store}/${list}"  # :q

typeset -i i=0
sed 1d "${store}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store}/${individual}" ]] || rm "${store}/${individual}"
    # echo "${store}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store}/${list}" >> "${store}/${individual}"  # cat "${store}/${individual}"
    echo "${line}" >> "${store}/${individual}"  # cat "${store}/${individual}"

    # echo "Created file: ${store}/${individual}"
done
#     ., "${store}"
# cat -n "${store}/${list/.txt/.24.txt}"
#     vi "${store}/${list/.txt/.24.txt}"  # :q
```
</details>
<br />

<a id="printed-3"></a>
###### Printed
<details>
<summary><i>Printed: Write individual lists</i></summary>

*Reformatted*
```txt
❯ cat -n "${store}/${list/.txt/.24.txt}"
     1	catalog scratch j_mem j_cor bam out min_kmer_cov min_iso_ratio min_glue glue_factor
     2	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG
        /fh/scratch/delete30/tsukiyama_t
        50G
        6
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG/Q_N.bam
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/echo-test_trinity_mkc-1_mir-0.01_mg-4_gf-0.1
        1
        0.01
        4
        0.1
```
*Original*
```txt
cat -n "${store}/${list/.txt/.24.txt}"
     1	catalog scratch j_mem j_cor bam out min_kmer_cov min_iso_ratio min_glue glue_factor
     2	/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG /fh/scratch/delete30/tsukiyama_t 50G 6 /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG/Q_N.bam /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/echo-test_trinity_mkc-1_mir-0.01_mg-4_gf-0.1 1 0.01 4 0.1   
```
</details>
<br />

<a id="03-use-a-heredoc-to-write-the-echo-test-submission-script-1"></a>
#### 03 Use a `HEREDOC` to write the echo-test submission script
<a id="code-19"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the echo-test submission script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_sub}" ]]; then
    rm "${sh_err_out}/${script_name_sub}"
fi
cat << script > "${sh_err_out}/${script_name_sub}"
#!/bin/bash

#  ${script_name_sub}
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


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \\
        \$(( run_time/3600 )) \\
        \$(( run_time%3600/60 )) \\
        \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {bam}            coordinate-sorted bam file <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"


#  ------------------------------------
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel \\
    --header : \\
    --colsep " " \\
    -k \\
    -j 1 \\
    --dry-run \\
        'singularity run \\
            --bind {catalog}:/data \\
            --bind {scratch}:/loc/scratch \\
            ~/singularity-docker-etc/Trinity.sif \\
                Trinity \\
                    --verbose \\
                    --max_memory {j_mem} \\
                    --CPU {j_cor} \\
                    --SS_lib_type FR \\
                    --genome_guided_bam {bam} \\
                    --genome_guided_max_intron 1002 \\
                    --jaccard_clip \\
                    --output {out} \\
                    --full_cleanup \\
                    --min_kmer_cov {min_kmer_cov} \\
                    --min_iso_ratio {min_iso_ratio} \\
                    --min_glue {min_glue} \\
                    --glue_factor {glue_factor} \\
                    --max_reads_per_graph 2000 \\
                    --normalize_max_read_cov 200 \\
                    --group_pairs_distance 700 \\
                    --min_contig_length 200' \\
:::: "\${arguments}"

time_end="\$(date +%s)"
calculate_run_time "\${time_start}" "\${time_end}" "Trinity run time"
script
chmod +x "${sh_err_out}/${script_name_sub}"
# cat -n "${sh_err_out}/${script_name_sub}"
#     vi "${sh_err_out}/${script_name_sub}"  # :q
#     ., "${sh_err_out}/${script_name_sub}"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-the-echo-test-run-script-1"></a>
#### 04 Use a `HEREDOC` to write the echo-test run script
<a id="code-20"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the echo-test run script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_run}" ]]; then
    rm "${sh_err_out}/${script_name_run}"
fi
cat << script > "${sh_err_out}/${script_name_run}"
#!/bin/bash

#SBATCH --job-name=${script_name_sub}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_sub%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_sub%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}


#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')


mkc="mkc-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$7 }'
)"
mir="mir-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$8 }'
)"
mg="mg-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$9 }'
)"
gf="gf-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$10 }'
)"
name="${pre}_\${mkc}_\${mir}_\${mg}_\${gf}"

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${sh_err_out}/${script_name_sub}" \\
        -a "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  vi "${sh_err_out}/${script_name_run}"  # :q
# cat "${sh_err_out}/${script_name_run}"


#  Scraps ---------------------------------------------------------------------
# SLURM_ARRAY_TASK_ID=24
# mkc="mkc-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $7 }'
# )"
# mir="mir-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $8 }'
# )"
# mg="mg-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $9 }'
# )"
# gf="gf-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $10 }'
# )"
# name="${pre}_${mkc}_${mir}_${mg}_${gf}"
# echo "${name}"
```
</details>
<br />
<br />

<a id="05-sbatchsrun-the-echo-test-1"></a>
#### 05 sbatch/srun the echo test
<a id="code-21"></a>
##### Code
<details>
<summary><i>Code: sbatch/srun the echo test</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${sh_err_out}/${script_name_run}"
skal
cd "${err_out}" && .,f | tail -200
.,f | tail -200
cd -
```
</details>
<br />
<br />

<a id="ii-run-trinity"></a>
## <u>II</u> Run Trinity
<a id="pre-get-situated-make-necessary-directories-1"></a>
### <u>pre</u> Get situated, make necessary directories
<a id="code-22"></a>
#### Code
<details>
<summary><i>Code: Get situated, make necessary directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0111" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env
ml Singularity
```
</details>
<br />

<a id="i-run-trinity-gf-mode-with-q_n-data"></a>
### <u>i</u> Run Trinity GF mode with Q_N data
<a id="01-define-variables-arrays-2"></a>
#### 01 Define variables, arrays
<a id="code-23"></a>
##### Code
<details>
<summary><i>Code: Define variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Experiment details -------------------------------------
cell_exp="Q_N"  # echo "${cell_exp}"
mode="Trinity-GF"  # echo "${mode}"


#  Indirectory (outdirectory and infiles are below) -------
d_files="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_${mode}"  # ls -1 "${d_files}"  #ABSPATH


#  SLURM parameters ---------------------------------------
threads=6  # echo "${threads}"
max_id_job=$(( 6 * 4 * 3 * 4 ))  # echo "${max_id_job}"
max_id_task=12 # echo "${max_id_task}"


#  Directories to bind ------------------------------------
catalog="${d_files}"  # echo "${catalog}"  #REDUNDANT #ABSPATH
scratch="/fh/scratch/delete30/tsukiyama_t"  # echo "${scratch}"  #ABSPATH


#  Trinity GF arguments, parameters, and infiles ----------
j_mem="50G"  # echo "${j_mem}"
j_cor="${threads}"  # echo "${j_cor}" #REDUNDANT

fq_1="1.fq.gz"  # echo "${fq_1}"
fq_2="2.fq.gz"  # echo "${fq_2}"
left_1="${d_files}/5781_${cell_exp}.${fq_1}"  # echo "${left_1}"  #INFILE  #ABSPATH
left_2="${d_files}/5782_${cell_exp}.${fq_1}"  # echo "${left_2}"  #INFILE  #ABSPATH
right_1="${d_files}/5781_${cell_exp}.${fq_2}"  # echo "${right_1}"  #INFILE  #ABSPATH
right_2="${d_files}/5782_${cell_exp}.${fq_2}"  # echo "${right_2}"  #INFILE  #ABSPATH

unset min_kmer_cov
unset min_iso_ratio
unset min_glue
unset glue_factor
typeset -a min_kmer_cov=(1 2 4 8 16 32)  # echo_test "${min_kmer_cov[@]}"
typeset -a min_iso_ratio=(0.005 0.01 0.05 0.1)  # echo_test "${min_iso_ratio[@]}"
typeset -a min_glue=(1 2 4)  # echo_test "${min_glue[@]}"
typeset -a glue_factor=(0.005 0.01 0.05 0.1)  # echo_test "${glue_factor[@]}"


#  Outdirectory -------------------------------------------
d_base="$(dirname "${d_files}")"  # echo "${d_base}"  #ABSPATH
d_mid="outfiles_${mode}/${cell_exp}"  # echo "${d_mid}"
pre="trinity-gf"  # echo "${pre}"
out="${d_base}/${d_mid}/${pre}"  # echo "${out}"  #ABSPATH
#NOTE #REMEMBER Additional text will be appended to "${out}"


#  Parameter lists and their storage ----------------------
store="${d_base}/${d_mid}/lists"  # ., "${store}"  #ABSPATH
list="lists.txt"  # echo "${list}"


#  Scripts ------------------------------------------------
script_name_sub="submit_${mode}_${cell_exp}.sh"  # echo "${script_name_sub}"
script_name_run="run_${mode}_${cell_exp}.sh"  # echo "${script_name_run}"


#  Storage for scripts, STDERR, and STDOUT ----------------
sh_err_out="${d_base}/sh_err_out"  # echo "${sh_err_out}"  #ABSPATH
err_out="${sh_err_out}/err_out/${mode}/${cell_exp}"  # echo "${err_out}"  #ABSPATH
```
</details>
<br />

<a id="02-generate-lists-of-permuted-parameters-2"></a>
#### 02 Generate lists of permuted parameters
<a id="02a-write-the-master-list-2"></a>
##### 02a Write the "master list"
<a id="code-24"></a>
###### Code
<details>
<summary><i>Code: Write the "master list"</i></summary>

*Header*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list}" ]]; then
    rm "${store}/${list}"
fi

#  Header
echo "catalog \
scratch \
j_mem \
j_cor \
left_1 \
left_2 \
right_1 \
right_2 \
out \
min_kmer_cov \
min_iso_ratio \
min_glue \
glue_factor" \
    > "${store}/${list}"
# cat -n "${store}/${list}"
#     vi "${store}/${list}"  # :q
#  wc -l "${store}/${list}" | cut -d " " -f 1

#  Body
parallel --header : --colsep " " -k -j 1 echo \
    '{catalog} \
    {scratch} \
    {j_mem} \
    {j_cor} \
    {left_1} \
    {left_2} \
    {right_1} \
    {right_2} \
    {out}_mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
    {min_kmer_cov} \
    {min_iso_ratio} \
    {min_glue} \
    {glue_factor}' \
::: catalog "${catalog}" \
::: scratch "${scratch}" \
::: j_mem "${j_mem}"  \
::: j_cor "${j_cor}" \
::: left_1 "${left_1[@]}" \
:::+ left_2 "${left_2[@]}" \
:::+ right_1 "${right_1[@]}" \
:::+ right_2 "${right_2[@]}" \
::: out "${out}" \
::: min_kmer_cov "${min_kmer_cov[@]}" \
::: min_iso_ratio "${min_iso_ratio[@]}" \
::: min_glue "${min_glue[@]}" \
::: glue_factor "${glue_factor[@]}" \
    >> "${store}/${list}"
# cat -n "${store}/${list}"
#   less "${store}/${list}"
#  wc -l "${store}/${list}" | cut -d " " -f 1
```

<a id="02b-write-individual-lists-2"></a>
##### 02b Write individual lists
<a id="code-25"></a>
###### Code
<details>
<summary><i>Code: Write individual lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list/.txt/.24.txt}" ]]; then
    rm "${store}/"*.{?,??,???}.txt
fi
#  ., "${store}"
#  vi "${store}/${list}"  # :q
# cat "${store}/${list}"  # :q

typeset -i i=0
sed 1d "${store}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store}/${individual}" ]] || rm "${store}/${individual}"
    # echo "${store}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store}/${list}" >> "${store}/${individual}"  # cat "${store}/${individual}"
    echo "${line}" >> "${store}/${individual}"  # cat "${store}/${individual}"

    # echo "Created file: ${store}/${individual}"
done
#     .,  "${store}"
# cat -n "${store}/${list/.txt/.24.txt}"
#     vi "${store}/${list/.txt/.24.txt}"  # :q
```
</details>
<br />

<a id="03-use-a-heredoc-to-write-the-submission-script"></a>
#### 03 Use a `HEREDOC` to write the submission script
<a id="code-26"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the submission script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_sub}" ]]; then
    rm "${sh_err_out}/${script_name_sub}"
fi
cat << script > "${sh_err_out}/${script_name_sub}"
#!/bin/bash

#  ${script_name_sub}
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


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \\
        \$(( run_time/3600 )) \\
        \$(( run_time%3600/60 )) \\
        \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {left_1}         first of two .fastq.gz files for 'left' reads <chr>
    {left_2}         second of two .fastq.gz files for 'left' reads <chr>
    {right_1}        first of two .fastq.gz files for 'right' reads <chr>
    {right_2}        second of two .fastq.gz files for 'right' reads <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"


#  ------------------------------------
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel \\
    --header : \\
    --colsep " " \\
    -k \\
    -j 1 \\
    --dry-run \\
        'singularity run \\
            --bind {catalog}:/data \\
            --bind {scratch}:/loc/scratch \\
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
                    --output {out} \\
                    --full_cleanup \\
                    --min_kmer_cov {min_kmer_cov} \\
                    --min_iso_ratio {min_iso_ratio} \\
                    --min_glue {min_glue} \\
                    --glue_factor {glue_factor} \\
                    --max_reads_per_graph 2000 \\
                    --normalize_max_read_cov 200 \\
                    --group_pairs_distance 700 \\
                    --min_contig_length 200' \\
:::: "\${arguments}"

parallel \\
    --header : \\
    --colsep " " \\
    -k \\
    -j \${SLURM_CPUS_ON_NODE} \\
        'singularity run \\
            --bind {catalog}:/data \\
            --bind {scratch}:/loc/scratch \\
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
                    --output {out} \\
                    --full_cleanup \\
                    --min_kmer_cov {min_kmer_cov} \\
                    --min_iso_ratio {min_iso_ratio} \\
                    --min_glue {min_glue} \\
                    --glue_factor {glue_factor} \\
                    --max_reads_per_graph 2000 \\
                    --normalize_max_read_cov 200 \\
                    --group_pairs_distance 700 \\
                    --min_contig_length 200' \\
:::: "\${arguments}"

time_end="\$(date +%s)"
calculate_run_time "\${time_start}" "\${time_end}" "Trinity run time"
script
chmod +x "${sh_err_out}/${script_name_sub}"
# cat -n "${sh_err_out}/${script_name_sub}"
#     vi "${sh_err_out}/${script_name_sub}"  # :q
#     ., "${sh_err_out}/${script_name_sub}"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-the-run-script"></a>
#### 04 Use a `HEREDOC` to write the run script
<a id="code-27"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the run script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_run}" ]]; then
    rm "${sh_err_out}/${script_name_run}"
fi
cat << script > "${sh_err_out}/${script_name_run}"
#!/bin/bash

#SBATCH --job-name=${script_name_sub}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_sub%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_sub%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}


#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')


mkc="mkc-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$10 }'
)"
mir="mir-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$11 }'
)"
mg="mg-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$12 }'
)"
gf="gf-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$13 }'
)"
name="${pre}_\${mkc}_\${mir}_\${mg}_\${gf}"

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${sh_err_out}/${script_name_sub}" \\
        -a "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  vi "${sh_err_out}/${script_name_run}"  # :q
# cat "${sh_err_out}/${script_name_run}"
#  ., "${sh_err_out}/${script_name_run}"


#  Scraps ---------------------------------------------------------------------
# SLURM_ARRAY_TASK_ID=24
# mkc="mkc-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $10 }'
# )"
# mir="mir-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $11 }'
# )"
# mg="mg-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $12 }'
# )"
# gf="gf-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $13 }'
# )"
# name="${pre}_${mkc}_${mir}_${mg}_${gf}"
# echo "${name}"
```
</details>
<br />
<br />

<a id="05-sbatchsrun-trinity"></a>
#### 05 sbatch/srun Trinity
<a id="code-28"></a>
##### Code
<details>
<summary><i>Code: sbatch/srun Trinity</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${sh_err_out}/${script_name_run}"
skal
cd "${err_out}" && .,f | tail -200
.,f | tail -200
cd -
```
</details>
<br />
<br />

<a id="ii-run-trinity-gg-mode-with-q_n-data"></a>
### <u>ii</u> Run Trinity GG mode with Q_N data
<a id="01-define-variables-arrays-3"></a>
#### 01 Define variables, arrays
<a id="code-29"></a>
##### Code
<details>
<summary><i>Code: Define variables, arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Experiment details -------------------------------------
cell_exp="Q_N"  # echo "${cell_exp}"
mode="Trinity-GG"  # echo "${mode}"


#  Indirectory (outdirectory and infiles are below) -------
d_files="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_${mode}"  # ls -1 "${d_files}"  #ABSPATH


#  SLURM parameters ---------------------------------------
threads=6  # echo "${threads}"
max_id_job=$(( 6 * 4 * 3 * 4 ))  # echo "${max_id_job}"
max_id_task=12 # echo "${max_id_task}"


#  Directories to bind ------------------------------------
catalog="${d_files}"  # echo "${catalog}"  #REDUNDANT #ABSPATH
scratch="/fh/scratch/delete30/tsukiyama_t"  # echo "${scratch}"  #ABSPATH


#  Trinity GG arguments, parameters, and infiles ----------
j_mem="50G"  # echo "${j_mem}"
j_cor="${threads}"  # echo "${j_cor}" #REDUNDANT

bam="${d_files}/${cell_exp}.bam"  # echo "${bam}"  #INFILE  #ABSPATH

unset min_kmer_cov
unset min_iso_ratio
unset min_glue
unset glue_factor
typeset -a min_kmer_cov=(1 2 4 8 16 32)  # echo_test "${min_kmer_cov[@]}"
typeset -a min_iso_ratio=(0.005 0.01 0.05 0.1)  # echo_test "${min_iso_ratio[@]}"
typeset -a min_glue=(1 2 4)  # echo_test "${min_glue[@]}"
typeset -a glue_factor=(0.005 0.01 0.05 0.1)  # echo_test "${glue_factor[@]}"


#  Outdirectory -------------------------------------------
d_base="$(dirname "${d_files}")"  # echo "${d_base}"  #ABSPATH
d_mid="outfiles_${mode}/${cell_exp}"  # echo "${d_mid}"
pre="trinity-gg"  # echo "${pre}"
out="${d_base}/${d_mid}/${pre}"  # echo "${out}"  #ABSPATH
#NOTE #REMEMBER Additional text will be appended to "${out}"


#  Parameter lists and their storage ----------------------
store="${d_base}/${d_mid}/lists"  # ., "${store}"  #ABSPATH
list="lists.txt"  # echo "${list}"


#  Scripts ------------------------------------------------
script_name_sub="submit_${mode}_${cell_exp}.sh"  # echo "${script_name_sub}"
script_name_run="run_${mode}_${cell_exp}.sh"  # echo "${script_name_run}"


#  Storage for scripts, STDERR, and STDOUT ----------------
sh_err_out="${d_base}/sh_err_out"  # echo "${sh_err_out}"  #ABSPATH
err_out="${sh_err_out}/err_out/${mode}/${cell_exp}"  # echo "${err_out}"  #ABSPATH
```
</details>
<br />

<a id="02-generate-lists-of-permuted-parameters-3"></a>
#### 02 Generate lists of permuted parameters
<a id="02a-write-the-master-list-3"></a>
##### 02a Write the "master list"
<a id="code-30"></a>
###### Code
<details>
<summary><i>Code: Write the "master list"</i></summary>

*Header*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list}" ]]; then
    rm "${store}/${list}"
fi

#  Header
echo "catalog \
scratch \
j_mem \
j_cor \
bam \
out \
min_kmer_cov \
min_iso_ratio \
min_glue \
glue_factor" \
    > "${store}/${list}"
# cat -n "${store}/${list}"
#     vi "${store}/${list}"  # :q
#  wc -l "${store}/${list}" | cut -d " " -f 1

#  Body
parallel --header : --colsep " " -k -j 1 echo \
    '{catalog} \
    {scratch} \
    {j_mem} \
    {j_cor} \
    {bam} \
    {out}_mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
    {min_kmer_cov} \
    {min_iso_ratio} \
    {min_glue} \
    {glue_factor}' \
::: catalog "${catalog}" \
::: scratch "${scratch}" \
::: j_mem "${j_mem}"  \
::: j_cor "${j_cor}" \
::: bam "${bam}" \
::: out "${out}" \
::: min_kmer_cov "${min_kmer_cov[@]}" \
::: min_iso_ratio "${min_iso_ratio[@]}" \
::: min_glue "${min_glue[@]}" \
::: glue_factor "${glue_factor[@]}" \
    >> "${store}/${list}"
# cat -n "${store}/${list}"
#   less "${store}/${list}"
#  wc -l "${store}/${list}" | cut -d " " -f 1
```

<a id="02b-write-individual-lists-3"></a>
##### 02b Write individual lists
<a id="code-31"></a>
###### Code
<details>
<summary><i>Code: Write individual lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store}/${list/.txt/.24.txt}" ]]; then
    rm "${store}/"*.{?,??,???}.txt
fi
#  ., "${store}"
#  vi "${store}/${list}"  # :q
# cat "${store}/${list}"  # :q

typeset -i i=0
sed 1d "${store}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store}/${individual}" ]] || rm "${store}/${individual}"
    # echo "${store}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store}/${list}" >> "${store}/${individual}"  # cat "${store}/${individual}"
    echo "${line}" >> "${store}/${individual}"  # cat "${store}/${individual}"

    # echo "Created file: ${store}/${individual}"
done
#     .,  "${store}"
# cat -n "${store}/${list/.txt/.24.txt}"
#     vi "${store}/${list/.txt/.24.txt}"  # :q
```
</details>
<br />

<a id="03-use-a-heredoc-to-write-the-submission-script-1"></a>
#### 03 Use a `HEREDOC` to write the submission script
<a id="code-32"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the submission script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_sub}" ]]; then
    rm "${sh_err_out}/${script_name_sub}"
fi
cat << script > "${sh_err_out}/${script_name_sub}"
#!/bin/bash

#  ${script_name_sub}
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


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \\
        \$(( run_time/3600 )) \\
        \$(( run_time%3600/60 )) \\
        \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}:
This script takes in a single file that requires a list of arguments
-a  {arguments}  space-delimited list of arguments for the below settings and
                 parameters; list is header-ed with the names of variables for
                 the arguments (in brackets below)

    #  -------------------------------------
    {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
    {scratch}        scratch directory, including path, to be mounted to the
                     Trinity container <chr>
    {j_mem}          max memory to used by Trinity when limiting can be enabled
                     (e.g., with jellyfish, sorting, etc.); must be in the form
                     of a nonnegative integer followed by a single uppercase
                     letter signifying the unit of storage, e.g., '50G' <chr>
    {j_cor}          number of threads for Trinity to use <int >= 1>
    {bam}            coordinate-sorted bam file <chr>
    {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
    {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1>
    {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float>
    {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1>
    {glue_factor}    fraction of maximum (Inchworm pair coverage) for read
                     glue support <float>
    #  -------------------------------------
"""

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"


#  ------------------------------------
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel \\
    --header : \\
    --colsep " " \\
    -k \\
    -j 1 \\
    --dry-run \\
        'singularity run \\
            --bind {catalog}:/data \\
            --bind {scratch}:/loc/scratch \\
            ~/singularity-docker-etc/Trinity.sif \\
                Trinity \\
                    --verbose \\
                    --max_memory {j_mem} \\
                    --CPU {j_cor} \\
                    --SS_lib_type FR \\
                    --genome_guided_bam {bam} \\
                    --genome_guided_max_intron 1002 \\
                    --jaccard_clip \\
                    --output {out} \\
                    --full_cleanup \\
                    --min_kmer_cov {min_kmer_cov} \\
                    --min_iso_ratio {min_iso_ratio} \\
                    --min_glue {min_glue} \\
                    --glue_factor {glue_factor} \\
                    --max_reads_per_graph 2000 \\
                    --normalize_max_read_cov 200 \\
                    --group_pairs_distance 700 \\
                    --min_contig_length 200' \\
:::: "\${arguments}"

parallel \\
    --header : \\
    --colsep " " \\
    -k \\
    -j \${SLURM_CPUS_ON_NODE} \\
        'singularity run \\
            --bind {catalog}:/data \\
            --bind {scratch}:/loc/scratch \\
            ~/singularity-docker-etc/Trinity.sif \\
                Trinity \\
                    --verbose \\
                    --max_memory {j_mem} \\
                    --CPU {j_cor} \\
                    --SS_lib_type FR \\
                    --genome_guided_bam {bam} \\
                    --genome_guided_max_intron 1002 \\
                    --jaccard_clip \\
                    --output {out} \\
                    --full_cleanup \\
                    --min_kmer_cov {min_kmer_cov} \\
                    --min_iso_ratio {min_iso_ratio} \\
                    --min_glue {min_glue} \\
                    --glue_factor {glue_factor} \\
                    --max_reads_per_graph 2000 \\
                    --normalize_max_read_cov 200 \\
                    --group_pairs_distance 700 \\
                    --min_contig_length 200' \\
:::: "\${arguments}"

time_end="\$(date +%s)"
calculate_run_time "\${time_start}" "\${time_end}" "Trinity run time"
script
chmod +x "${sh_err_out}/${script_name_sub}"
# cat -n "${sh_err_out}/${script_name_sub}"
#     vi "${sh_err_out}/${script_name_sub}"  # :q
#     ., "${sh_err_out}/${script_name_sub}"
```
</details>
<br />

<a id="04-use-a-heredoc-to-write-the-run-script-1"></a>
#### 04 Use a `HEREDOC` to write the run script
<a id="code-33"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the run script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${sh_err_out}/${script_name_run}" ]]; then
    rm "${sh_err_out}/${script_name_run}"
fi
cat << script > "${sh_err_out}/${script_name_run}"
#!/bin/bash

#SBATCH --job-name=${script_name_sub}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_sub%.sh}.%A-%a.err.txt
#SBATCH --output=${err_out}/${script_name_sub%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}


#  ${script_name_run}
#  KA
#  $(date '+%Y-%m%d')


mkc="mkc-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$7 }'
)"
mir="mir-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$8 }'
)"
mg="mg-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$9 }'
)"
gf="gf-\$(
    cat "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$10 }'
)"
name="${pre}_\${mkc}_\${mir}_\${mg}_\${gf}"

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${sh_err_out}/${script_name_sub}" \\
        -a "${store}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${err_out}/${script_name_sub%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  vi "${sh_err_out}/${script_name_run}"  # :q
# cat "${sh_err_out}/${script_name_run}"
#  ., "${sh_err_out}/${script_name_run}"


#  Scraps ---------------------------------------------------------------------
# SLURM_ARRAY_TASK_ID=24
# mkc="mkc-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $7 }'
# )"
# mir="mir-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $8 }'
# )"
# mg="mg-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $9 }'
# )"
# gf="gf-$(
#     cat "${store}/${list%.txt}.${SLURM_ARRAY_TASK_ID}.txt" \
#         | awk -v OFS='\t' 'FNR == 2 { print $10 }'
# )"
# name="${pre}_${mkc}_${mir}_${mg}_${gf}"
# echo "${name}"
```
</details>
<br />
<br />

<a id="05-sbatchsrun-trinity-1"></a>
#### 05 sbatch/srun Trinity
<a id="code-34"></a>
##### Code
<details>
<summary><i>Code: sbatch/srun Trinity</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${sh_err_out}/${script_name_run}"
skal
cd "${err_out}" && .,f | tail -200
.,
.,f | tail -200
cd -
```
</details>
<br />
<br />
