
`#work_assessment-processing_gtfs.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [0. Get situated](#0-get-situated)
    1. [Code](#code)
1. [0. Copy in files of interest](#0-copy-in-files-of-interest)
    1. [Code](#code-1)
1. [1. Run AGAT](#1-run-agat)
    1. [Get situated](#get-situated)
        1. [Code](#code-2)
    1. [Make associated storage directories](#make-associated-storage-directories)
        1. [Code](#code-3)
    1. [Create arrays of relevant gff3 and bam files](#create-arrays-of-relevant-gff3-and-bam-files)
        1. [Code](#code-4)
    1. [Loop through array elements with agat_convert_sp_gff2gtf.pl](#loop-through-array-elements-with-agat_convert_sp_gff2gtfpl)
        1. [Code](#code-5)
1. [2. Run GffCompare](#2-run-gffcompare)
    1. [Loop through array elements with `gffcompare`](#loop-through-array-elements-with-gffcompare)
        1. [Code](#code-6)
1. [3. Strip string "chr" from collapsed gtf files](#3-strip-string-chr-from-collapsed-gtf-files)
    1. [...](#)
        1. [Code](#code-7)
1. [4. Run `htseq-count`](#4-run-htseq-count)
    1. [Perform a trial run of `htseq-count` on bams in `bams_renamed/`](#perform-a-trial-run-of-htseq-count-on-bams-in-bams_renamed)
        1. [Code](#code-8)
    1. [Set up necessary variables](#set-up-necessary-variables)
        1. [Code](#code-9)
    1. [Generate lists of arguments](#generate-lists-of-arguments)
        1. [Code](#code-10)
    1. [Break the full, multi-line list into individual per-line lists](#break-the-full-multi-line-list-into-individual-per-line-lists)
        1. [Code](#code-11)
    1. [Use a `HEREDOC` to write a '`run`' script](#use-a-heredoc-to-write-a-run-script)
        1. [Code](#code-12)
    1. [Use a `HEREDOC` to write '`submit`' script](#use-a-heredoc-to-write-submit-script)
        1. [Code](#code-13)
    1. [Use `sbatch` to run the '`submission`' and '`run`' scripts](#use-sbatch-to-run-the-submission-and-run-scripts)
        1. [Code](#code-14)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="0-get-situated"></a>
## 0. Get situated
<a id="code"></a>
### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

tmux new -s gff3
tmux attach -t gff3
grabnode  # 8, defaults

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
```
</details>
<br />
<br />

<a id="0-copy-in-files-of-interest"></a>
## 0. Copy in files of interest
<a id="code-1"></a>
### Code
<details>
<summary><i>Code: Copy in files of interest</i></summary>

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

cp -r "${p_trinity}" "${p_gtf}"
```
</details>
<br />
<br />

<a id="1-run-agat"></a>
## 1. Run AGAT
<a id="get-situated"></a>
### Get situated
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

# tmux new -s install
# tmux attach -t install
grabnode  # 8, defaults

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate gff3_env
```
</details>
<br />

<a id="make-associated-storage-directories"></a>
### Make associated storage directories
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Make associated storage directories</i></summary>

```bash
#!/bin/bash

mkdir -p outfiles_gtf-gff3/{already,Trinity-GG}
mkdir -p outfiles_gtf-gff3/Trinity-GG/{G_N,Q_N}/err_out

mkdir -p outfiles_htseq-count/{already,Trinity-GG}
mkdir -p outfiles_htseq-count/Trinity-GG/{G_N,Q_N}/{sh,list,err_out}
```
</details>
<br />

<a id="create-arrays-of-relevant-gff3-and-bam-files"></a>
### Create arrays of relevant gff3 and bam files
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Create arrays of relevant gff3 and bam files</i></summary>

```bash
#!/bin/bash

unset stems
typeset -a stems
while IFS=" " read -r -d $'\0'; do
    stems+=( "${REPLY%.gff3}" )
done < <(\
    find . \
        -type f \
        -name "trinity*.gff3" \
        -print0 \
            | sort -z\
)
echo_test "${stems[@]}"
echo "${#stems[@]}"  # 12

unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_UMI" \
        -type l \
        -name "*ovn*bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams[@]}"
echo "${#bams[@]}"  # 8
```
</details>
<br />

<a id="loop-through-array-elements-with-agat_convert_sp_gff2gtfpl"></a>
### Loop through array elements with agat_convert_sp_gff2gtf.pl
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Loop through array elements with agat_convert_sp_gff2gtf.pl</i></summary>

```bash
#!/bin/bash

for i in "${stems[@]}"; do
    in="${i}.gff3"
    out="$(echo "${i}" | sed 's/infiles/outfiles/g' - )"
    err_out="$(dirname "${out}")/err_out/01-agat.$(basename "${out}")"
    echo "Running agat_convert_sp_gff2gtf.pl"
    echo "        in   ${in}"
    echo "       out  ${out}.gtf"
    echo "    stdout  ${err_out}.stdout.txt"
    echo "    stderr  ${err_out}.stderr.txt"
    echo ""

    agat_convert_sp_gff2gtf.pl \
        --gff "${in}" \
        -o "${out}.gtf" \
            > >(tee -a "${err_out}.stdout.txt") \
            2> >(tee -a "${err_out}.stderr.txt")
done
```
</details>
<br />

<a id="2-run-gffcompare"></a>
## 2. Run GffCompare
<a id="loop-through-array-elements-with-gffcompare"></a>
### Loop through array elements with `gffcompare`
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Loop through array elements with gffcompare</i></summary>

```bash
#!/bin/bash

for i in "${stems[@]}"; do
    in="$(echo "${i}" | sed 's/infiles/outfiles/g' - ).gtf"
    out="${in%.gtf}"
    err_out="$(dirname "${out}")/err_out/02-gffcompare.$(basename "${out}")"
    echo "Running gffcompare"
    echo "        in  ${in}"
    echo "       out  ${out}"
    echo "    stdout  ${err_out}.stdout.txt"
    echo "    stderr  ${err_out}.stderr.txt"
    echo ""
    
    echo "\
    gffcompare -C \"${in}\" \\
        -o \"${out}\" \\
            > >(tee -a \"${err_out%.gtf}.stdout.txt\") \\
            2> >(tee -a \"${err_out%.gtf}.stderr.txt\")
    "

    gffcompare -C "${in}" \
        -o "${out}.gffcompare" \
        > >(tee -a "${err_out%.gtf}.stdout.txt") \
        2> >(tee -a "${err_out%.gtf}.stderr.txt")
done
```
</details>
<br />

<a id="3-strip-string-chr-from-collapsed-gtf-files"></a>
## 3. Strip string "chr" from collapsed gtf files
<a id="..."></a>
### ...
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Strip string "chr" from collapsed gtf files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

for j in "${stems[@]}"; do
    in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffcompare.combined.gtf"
    out="${in%.gtf}.sans-chr.gtf"
    err_out="$(dirname "${out}")/err_out/03-chr-rename.$(basename "${out}" .gffcompare.combined.sans-chr.gtf)"
    echo "Running htseq-count"
    echo "        in                        ${in}"
    echo "       out                        ${out}"
    echo "    stdout  ${err_out}.stdout.txt"
    echo "    stderr  ${err_out}.stderr.txt"
    echo ""

    echo "awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, "", \$1); print }' ${in} > ${out}"

    awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, "", $1); print }' ${in} > ${out}
done
```
</details>
<br />

<a id="4-run-htseq-count"></a>
## 4. Run `htseq-count`
<a id="perform-a-trial-run-of-htseq-count-on-bams-in-bams_renamed"></a>
### Perform a trial run of `htseq-count` on bams in `bams_renamed/`
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Perform a trial run of htseq-count on bams in bams_renamed/</i></summary>

```bash
#!/bin/bash

k=0
for i in "yes" "reverse"; do
    for j in "${stems[@]}"; do
        # i="reverse"  # echo "${i}"
        # j="${stems[0]}"  # echo "${j}"
        in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffcompare.combined.sans-chr.gtf"  # ., "${in}"
        out="$(echo "${j}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).htseq-count-${i}.tsv"  # echo "${out}"
        err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"
        echo "Running htseq-count"
        echo "        in                                    ${in}"
        echo "       out                                 ${out}"
        echo "    stdout  ${err_out}.stdout.txt"
        echo "    stderr  ${err_out}.stderr.txt"
        echo ""

        let k++
        printf "    Iteration '%d'\n\n" "${k}"

        echo "\
        htseq-count \\
            --order \"pos\" \\
            --stranded \"${i}\" \\
            --nonunique \"all\" \\
            --type \"transcript\" \\
            --idattr \"gene_id\" \\
            --nprocesses \"${SLURM_CPUS_ON_NODE}\" \\
            --counts_output \"${out}\" \\
            --with-header \\
            \${bams[*]} \\
            \"${in}\" \\
                > >(tee -a \"${err_out}.stdout.txt\") \\
                2> >(tee -a \"${err_out}.stderr.txt\")
        "

        # start="$(date +%s.%N)"
        # htseq-count \
        #     --order "pos" \
        #     --stranded "${i}" \
        #     --nonunique "all" \
        #     --type "transcript" \
        #     --idattr "gene_id" \
        #     --nprocesses "${SLURM_CPUS_ON_NODE}" \
        #     --counts_output "${out}" \
        #     --with-header \
        #     ${bams[*]} \
        #     "${in}" \
        #         > >(tee -a "${err_out}.stdout.txt") \
        #         2> >(tee -a "${err_out}.stderr.txt")
        # end="$(date +%s.%N)"
        # run_time="$( echo "$end - $start" | bc -l )"
        # echo "${run_time}"  # ~18 minutes per iteration
    done
done
```
</details>
<br />

<a id="set-up-necessary-variables"></a>
### Set up necessary variables
<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_run="run_htseq-count.sh"  # echo "${script_run}"
script_submit="submit_run_htseq-count.sh"  # echo "${script_submit}"
threads=16  # echo "${threads}"

store_scripts_G="outfiles_htseq-count/Trinity-GG/G_N/sh"  # echo "${store_scripts_G}"  # ., "${store_scripts_G}"
store_scripts_Q="outfiles_htseq-count/Trinity-GG/Q_N/sh"  # echo "${store_scripts_Q}"  # ., "${store_scripts_Q}"

store_err_out_G="outfiles_htseq-count/Trinity-GG/G_N/err_out"  # echo "${store_err_out_G}"  # ., "${store_err_out_G}"
store_err_out_Q="outfiles_htseq-count/Trinity-GG/Q_N/err_out"  # echo "${store_err_out_Q}"  # ., "${store_err_out_Q}"

store_lists_G="outfiles_htseq-count/Trinity-GG/G_N/list"  # echo "${store_lists_G}"  # ., "${store_lists_G}"
store_lists_Q="outfiles_htseq-count/Trinity-GG/Q_N/list"  # echo "${store_lists_Q}"  # ., "${store_lists_Q}"

list="Trinity-GG.htseq-count.txt"  # echo "${list}"
max_id_job=12  # echo "${max_id_job}"
max_id_task=12  # echo "${max_id_task}"
```
</details>
<br />

<a id="generate-lists-of-arguments"></a>
### Generate lists of arguments
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Generate lists of arguments</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset stranded
typeset -a stranded=("yes" "reverse")
echo_test "${stranded[@]}"
echo "${#stranded[@]}"

if [[ -f "${store_lists_G}/${list}" ]]; then
    rm "${store_lists_G}/${list}"
fi

if [[ -f "${store_lists_Q}/${list}" ]]; then
    rm "${store_lists_Q}/${list}"
fi

#  Header -----------------------------
if [[ -f "${store_lists_G}/${list}" ]]; then
    rm "${store_lists_G}/${list}"
fi
echo "stranded \
infile \
outfile \
err_out" \
    > "${store_lists_G}/${list}"
#  ., "${store_lists_G}/${list}"
#  vi "${store_lists_G}/${list}"
# cat "${store_lists_G}/${list}"

if [[ -f "${store_lists_Q}/${list}" ]]; then
    rm "${store_lists_Q}/${list}"
fi
echo "stranded \
infile \
outfile \
err_out" \
    > "${store_lists_Q}/${list}"
#  ., "${store_lists_Q}/${list}"
#  vi "${store_lists_Q}/${list}"
# cat "${store_lists_Q}/${list}"

#  Body -------------------------------
for i in "${stranded[@]}"; do
    for j in "${stems[@]}"; do
        st="${i}"
        in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffcompare.combined.sans-chr.gtf"
        ou="$(echo "${j}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).htseq-count-${st}.tsv"
        er="$(dirname "${ou}")/err_out/03-htseq-count-${st}.$(basename "${ou}" .tsv)"

        echo "${st} ${in} ${ou} ${er}"
        echo ""

        if [[ "${j}" == *G_N* ]]; then
            echo "${st} ${in} ${ou} ${er}" >> "${store_lists_G}/${list}"
        elif [[ "${j}" == *Q_N* ]]; then
            echo "${st} ${in} ${ou} ${er}" >> "${store_lists_Q}/${list}"
        fi
        #        ., "${store_lists_G}"
        #        ., "${store_lists_G}/${list}"
        #     wc -l "${store_lists_G}/${list}"
        #  head -20 "${store_lists_G}/${list}"
        #
        #        ., "${store_lists_Q}"
        #        ., "${store_lists_Q}/${list}"
        #     wc -l "${store_lists_Q}/${list}"
        #  head -20 "${store_lists_Q}/${list}"
    done
done
```
</details>
<br />

<a id="break-the-full-multi-line-list-into-individual-per-line-lists"></a>
### Break the full, multi-line list into individual per-line lists
<a id="code-11"></a>
#### Code
<details>
<summary><i>Code: Break the full, multi-line list into individual per-line lists</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists_G}/${list%.txt}.4.txt" ]]; then
    rm \
        "${store_lists_G}/"${list%.txt}.?.txt \
        "${store_lists_G}/"${list%.txt}.??.txt
fi
#  ., "${store_lists_G}"
#  vi "${store_lists_G}/${list}"  # :q
# cat "${store_lists_G}/${list}"  # :q

typeset -i i=0
sed 1d "${store_lists_G}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists_G}/${individual}" ]] || rm "${store_lists_G}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists_G}/${list}" >> "${store_lists_G}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists_G}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists_G}/${individual}"
done
#  ., "${store_lists_G}"
#  vi "${store_lists_G}/${list%.txt}.4.txt"  # :q
# cat "${store_lists_G}/${list%.txt}.4.txt"

if [[ -f "${store_lists_Q}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm \
        "${store_lists_Q}/"${list%.txt}.?.txt \
        "${store_lists_Q}/"${list%.txt}.??.txt
fi
#  ., "${store_lists_Q}"
#  vi "${store_lists_Q}/${list}"  # :q
# cat "${store_lists_Q}/${list}"  # :q

typeset -i i=0
sed 1d "${store_lists_Q}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists_Q}/${individual}" ]] || rm "${store_lists_Q}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists_Q}/${list}" >> "${store_lists_Q}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists_Q}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists_Q}/${individual}"
done
#  ., "${store_lists_Q}"
#  vi "${store_lists_Q}/${list%.txt}.4.txt"  # :q
# cat "${store_lists_Q}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="use-a-heredoc-to-write-a-run-script"></a>
### Use a `HEREDOC` to write a '`run`' script
<a id="code-12"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write a 'run' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_scripts_G}/${script_run}" ]]; then
    rm "./${store_scripts_G}/${script_run}"
fi

if [[ -f "${store_scripts_Q}/${script_run}" ]]; then
    rm "./${store_scripts_Q}/${script_run}"
fi

cat << script > "${script_run}"
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
parallel --header : --colsep " " -k -j 1 echo \\
    'htseq-count \\
        --order pos \\
        --stranded {stranded} \\
        --nonunique all \\
        --type transcript \\
        --idattr gene_id \\
        --nprocesses ${threads} \\
        --counts_output {outfile} \\
        --with-header \\
        ${bams[*]} \\
        {infile} \\
            > {err_out}.stdout.txt \\
            2> {err_out}.stderr.txt' \\
:::: "\${arguments}"


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \\
    'htseq-count \\
        --order pos \\
        --stranded {stranded} \\
        --nonunique all \\
        --type transcript \\
        --idattr gene_id \\
        --nprocesses ${threads} \\
        --counts_output {outfile} \\
        --with-header \\
        ${bams[*]} \\
        {infile} \\
            > {err_out}.stdout.txt \\
            2> {err_out}.stderr.txt' \\
:::: "\${arguments}"
script
chmod +x "${script_run}"

cp "${script_run}" "${store_scripts_G}/${script_run}"
cp "${script_run}" "${store_scripts_Q}/${script_run}"

if [[ -f "${store_scripts_G}/${script_run}" ]] &&
   [[ -f "${store_scripts_Q}/${script_run}" ]]
then
    rm "./${script_run}"
fi
#  cd "./${store_scripts_G}"
#  ., "./${store_scripts_G}/${script_run}"
#  vi "./${store_scripts_G}/${script_run}"  # :q
# cat "./${store_scripts_G}/${script_run}"
#
#  cd "./${store_scripts_Q}"
#  ., "./${store_scripts_Q}/${script_run}"
#  vi "./${store_scripts_Q}/${script_run}"  # :q
# cat "./${store_scripts_Q}/${script_run}"
```
</details>
<br />

<a id="use-a-heredoc-to-write-submit-script"></a>
### Use a `HEREDOC` to write '`submit`' script
<a id="code-13"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to write 'submit' script</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts_G}/${script_submit}" ]]; then
    rm "./${store_scripts_G}/${script_submit}"
fi
cat << script > "${store_scripts_G}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./${store_err_out_G}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=./${store_err_out_G}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists_G}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$3 }' \\
        | sed 's:\./outfiles_htseq-count/Trinity-GG/::g' \\
        | sed 's:\/:\.:g' \\
        | sed 's:\.tsv::g'
)"

ln -f \\
    ${store_err_out_G}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${store_err_out_G}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${store_err_out_G}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${store_err_out_G}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${store_scripts_G}/${script_run}" \\
        -a "./${store_lists_G}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${store_err_out_G}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${store_err_out_G}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  ., "${store_scripts_G}"
#  ., "${store_scripts_G}/${script_submit}"
#  vi "${store_scripts_G}/${script_submit}"  # :q
# cat -n "${store_scripts_G}/${script_submit}"

if [[ -f "./${store_scripts_Q}/${script_submit}" ]]; then
    rm "./${store_scripts_Q}/${script_submit}"
fi
cat << script > "${store_scripts_Q}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./${store_err_out_Q}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=./${store_err_out_Q}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists_Q}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \\
        | awk -v OFS='\t' 'FNR == 2 { print \$3 }' \\
        | sed 's:\./outfiles_htseq-count/Trinity-GG/::g' \\
        | sed 's:\/:\.:g' \\
        | sed 's:\.tsv::g'
)"

ln -f \\
    ${store_err_out_Q}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \\
    ${store_err_out_Q}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \\
    ${store_err_out_Q}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \\
    ${store_err_out_Q}/${script_run%.sh}.\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \\
    "${store_scripts_Q}/${script_run}" \\
        -a "./${store_lists_Q}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \\
    ${store_err_out_Q}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \\
    ${store_err_out_Q}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  ., "${store_scripts_Q}"
#  ., "${store_scripts_Q}/${script_submit}"
#  vi "${store_scripts_Q}/${script_submit}"  # :q
# cat -n "${store_scripts_Q}/${script_submit}"
```
</details>
<br />

<a id="use-sbatch-to-run-the-submission-and-run-scripts"></a>
### Use `sbatch` to run the '`submission`' and '`run`' scripts
<a id="code-14"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate gff3_env

sbatch "${store_scripts_G}/${script_submit}"
sbatch "${store_scripts_Q}/${script_submit}"
# alias crj=".,f ./sh_err_out/err_out/ | tail -220"
# alias grj="cd ./sh_err_out/err_out/ && .,f | tail -220"
# alias t220=".,f | tail -220"
```
