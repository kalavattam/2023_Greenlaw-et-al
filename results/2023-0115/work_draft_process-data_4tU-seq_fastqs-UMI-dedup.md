
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
1. [I Append UMIs to `fastq`s `R1` and `R3`](#i-append-umis-to-fastqs-r1-and-r3)
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
1. [II Perform adapter and quality trimming of the `fastq`s](#ii-perform-adapter-and-quality-trimming-of-the-fastqs)
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
1. [III Perform kmer correction with `rcorrector`](#iii-perform-kmer-correction-with-rcorrector)
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
1. [IV "Correct" the `rcorrect`ed `fastq`s](#iv-correct-the-rcorrected-fastqs)
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
1. [Scraps](#scraps)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="pre-symlink-to-r123fastqgz"></a>
## PRE Symlink to `*R{1,2,3}*.fastq.gz`
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
## PRE Get `fastq` file stems into arrays
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

unset r3
unset r3_pro
unset r3_trim
unset r3_cor
unset r3_cor_cln

typeset -a UMIs

typeset -a r1
typeset -a r1_pro
typeset -a r1_trim
typeset -a r1_cor
typeset -a r1_cor_cln

typeset -a r3
typeset -a r3_pro
typeset -a r3_trim
typeset -a r3_cor
typeset -a r3_cor_cln

for i in "${fq_bases[@]}"; do
          UMIs+=( "${i}_R2_001.fastq.gz" )

            r1+=( "${i}_R1_001.fastq.gz" )
        r1_pro+=( "./fastqs_UMI-dedup/umi-tools_extract/$(basename "${i}_R1.UMI.fq.gz")" )
       r1_trim+=( "./fastqs_UMI-dedup/atria_trim/$(basename "${i}_R1.UMI.atria.fq.gz")" )
        r1_cor+=( "./fastqs_UMI-dedup/rcorrector/$(basename "${i}_R1.UMI.atria.cor.fq.gz")" )
    r1_cor_cln+=( "./fastqs_UMI-dedup/rcorrector_clean-up/$(basename "${i}_R1.UMI.atria.cor.rm-unfx.fq.gz")" )

            r3+=( "${i}_R3_001.fastq.gz" )
        r3_pro+=( "./fastqs_UMI-dedup/umi-tools_extract/$(basename "${i}_R3.UMI.fq.gz")" )
       r3_trim+=( "./fastqs_UMI-dedup/atria_trim/$(basename "${i}_R3.UMI.atria.fq.gz")" )
        r3_cor+=( "./fastqs_UMI-dedup/rcorrector/$(basename "${i}_R3.UMI.atria.cor.fq.gz")" )
    r3_cor_cln+=( "./fastqs_UMI-dedup/rcorrector_clean-up/$(basename "${i}_R3.UMI.atria.cor.rm-unfx.fq.gz")" )
done

echo_test "${UMIs[@]}"        # ., "${UMIs[24]}"

echo_test "${r1[@]}"          # ., "${r1[25]}"
echo_test "${r1_pro[@]}"      # ., "${r1_pro[26]}"
echo_test "${r1_trim[@]}"     # ., "${r1_trim[29]}"
echo_test "${r1_cor[@]}"      # ., "${r1_cor[30]}"
echo_test "${r1_cor_cln[@]}"  # ., "${r1_cor_cln[31]}"

echo_test "${r3[@]}"          # ., "${r3[27]}"
echo_test "${r3_pro[@]}"      # ., "${r3_pro[28]}"
echo_test "${r3_trim[@]}"     # ., "${r3_trim[29]}"
echo_test "${r3_cor[@]}"      # ., "${r3_cor[30]}"
echo_test "${r3_cor_cln[@]}"  # ., "${r3_cor_cln[31]}"

echo "${#UMIs[@]}"

echo "${#r1[@]}"
echo "${#r1_pro[@]}"
echo "${#r1_trim[@]}"
echo "${#r1_cor[@]}"
echo "${#r1_cor_cln[@]}"

echo "${#r3[@]}"
echo "${#r3_pro[@]}"
echo "${#r3_trim[@]}"
echo "${#r3_cor[@]}"
echo "${#r3_cor_cln[@]}"
```
</details>
<br />
<br />

<a id="i-append-umis-to-fastqs-r1-and-r3"></a>
## I Append UMIs to `fastq`s `R1` and `R3`
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

`#COMEBACKTOTHIS`
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

module purge
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4

sbatch "${store_scripts}/${script_submit}"
```
</details>
<br />
<br />

<a id="ii-perform-adapter-and-quality-trimming-of-the-fastqs"></a>
## II Perform adapter and quality trimming of the `fastq`s
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

module purge

sbatch "${store_scripts}/${script_submit}"
```
</details>
<br />
<br />

<a id="iii-perform-kmer-correction-with-rcorrector"></a>
## III Perform kmer correction with `rcorrector`
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

<a id="iv-correct-the-rcorrected-fastqs"></a>
## IV "Correct" the `rcorrect`ed `fastq`s
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

<a id="scraps"></a>
## Scraps
<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
</details>
<br />
