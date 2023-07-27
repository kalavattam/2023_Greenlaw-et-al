
`#work_GMAP_rough-draft.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Create gff3s for specific Trinity-GG Q_N fastas](#create-gff3s-for-specific-trinity-gg-q_n-fastas)
    1. [Get situated, create outdirectories and arrays for in-, outfiles](#get-situated-create-outdirectories-and-arrays-for-in--outfiles)
        1. [Code](#code)
    1. [Use a HEREDOC to make a GMAP submission script](#use-a-heredoc-to-make-a-gmap-submission-script)
        1. [Code](#code-1)
    1. [Launch GMAP for in-/outfile combinations](#launch-gmap-for-in-outfile-combinations)
        1. [Code](#code-2)
1. [Create gff3s for specific Trinity-GG G_N fastas](#create-gff3s-for-specific-trinity-gg-g_n-fastas)
    1. [Get situated, create outdirectories and arrays for in-, outfiles](#get-situated-create-outdirectories-and-arrays-for-in--outfiles-1)
        1. [Code](#code-3)
    1. [Use a HEREDOC to make a GMAP submission script](#use-a-heredoc-to-make-a-gmap-submission-script-1)
        1. [Code](#code-4)
    1. [Launch GMAP for in-/outfile combinations](#launch-gmap-for-in-outfile-combinations-1)
        1. [Code](#code-5)

<!-- /MarkdownTOC -->
</details>
<br />

Run `GMAP` on Trinity GG `mkc-{1,2,4,8,16,32}_mir-0.05_mg-2_gf-0.05` fasta files to generate corresponding gff3 files; files are found in these directories:
- `${HOME}/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N`
- `${HOME}/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/G_N`
<br />
<br />

<a id="create-gff3s-for-specific-trinity-gg-q_n-fastas"></a>
## Create gff3s for specific Trinity-GG Q_N fastas
<a id="get-situated-create-outdirectories-and-arrays-for-in--outfiles"></a>
### Get situated, create outdirectories and arrays for in-, outfiles
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get into the appropriate directory, create arrays for in-, outfiles</i></summary>

```bash
#!/bin/bash

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

if [[ ! -d outfiles_GMAP_rough-draft/ ]]; then
    mkdir -p "outfiles_GMAP_rough-draft/Trinity-GG/G_N/"
    mkdir -p "outfiles_GMAP_rough-draft/Trinity-GG/Q_N/"
fi

#  Infiles
unset fastas
typeset -a fastas
while IFS=" " read -r -d $'\0'; do
    fastas+=( "${REPLY}" )
done < <(
    find "outfiles_Trinity-GG/Q_N/" \
        -maxdepth 1 \
        -type f \
        -name "*mkc-*_mir-0.05_mg-2_gf-0.05*fasta" \
        -print0 \
            | sort -z
)
echo_test "${fastas[@]}"
echo "${!fastas[@]}"

#  Outfiles
unset gff3s
typeset -a gff3s
for i in "${fastas[@]}"; do
    gff3s+=( "outfiles_GMAP_rough-draft/Trinity-GG/Q_N/$(basename "${i}" .Trinity-GG.fasta).gff3" )
done
echo_test "${gff3s[@]}"
echo "${!gff3s[@]}"
```
</details>
<br />
<br />

<a id="use-a-heredoc-to-make-a-gmap-submission-script"></a>
### Use a HEREDOC to make a GMAP submission script
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to make a GMAP submission script</i></summary>

```bash
#!/bin/bash

script_name_sub="submit_GMAP_rough-draft.sh"
threads=1
sh_err_out="sh_err_out"
err_out="sh_err_out/err_out"

if [[ -f "${sh_err_out}/${script_name_sub}" ]]; then
    rm "${sh_err_out}/${script_name_sub}"
fi
cat << script > "${sh_err_out}/${script_name_sub}"
#!/bin/bash

#SBATCH --job-name=${script_name_sub}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_sub%.sh}.%J.err.txt
#SBATCH --output=${err_out}/${script_name_sub%.sh}.%J.out.txt

ml GMAP-GSNAP/2018-07-04-foss-2018b
ml SAMtools/1.16.1-GCC-11.2.0

fasta="\${1}"
outfile="\${2}"

gmap \
    -d "sacCer3" \
    -D "\${HOME}/genomes/sacCer3/GMAP" \
    -A "\${fasta}" \
    --format="gff3_gene" \
        > "\${outfile}"
script
```
</details>    
<br />
<br />

<a id="launch-gmap-for-in-outfile-combinations"></a>
### Launch GMAP for in-/outfile combinations
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Launch GMAP for in-/outfile combinations</i></summary>

```bash
#!/bin/bash

# for i in "${!fastas[@]}"; do
#     echo "sbatch ${sh_err_out}/${script_name_sub} \\"
#     echo "    ${fastas["${i}"]} \\"
#     echo "    ${gff3s["${i}"]}"
# done

for i in "${!fastas[@]}"; do
    echo "sbatch ${sh_err_out}/${script_name_sub} \\"
    echo "    ${fastas["${i}"]} \\"
    echo "    ${gff3s["${i}"]}"

    sbatch "${sh_err_out}/${script_name_sub}" \
        "${fastas["${i}"]}" \
        "${gff3s["${i}"]}"

    sleep 0.5
    echo ""
done
```
</details>
<br />
<br />

<a id="create-gff3s-for-specific-trinity-gg-g_n-fastas"></a>
## Create gff3s for specific Trinity-GG G_N fastas
<a id="get-situated-create-outdirectories-and-arrays-for-in--outfiles-1"></a>
### Get situated, create outdirectories and arrays for in-, outfiles
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Get into the appropriate directory, create arrays for in-, outfiles</i></summary>

```bash
#!/bin/bash

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

if [[ ! -d outfiles_GMAP_rough-draft/ ]]; then
    mkdir -p "outfiles_GMAP_rough-draft/Trinity-GG/G_N/"
    mkdir -p "outfiles_GMAP_rough-draft/Trinity-GG/Q_N/"
fi

#  Infiles
unset fastas
typeset -a fastas
while IFS=" " read -r -d $'\0'; do
    fastas+=( "${REPLY}" )
done < <(
    find "outfiles_Trinity-GG/G_N/" \
        -maxdepth 1 \
        -type f \
        -name "*mkc-*_mir-0.05_mg-2_gf-0.05*fasta" \
        -print0 \
            | sort -z
)
echo_test "${fastas[@]}"
echo "${!fastas[@]}"

#  Outfiles
unset gff3s
typeset -a gff3s
for i in "${fastas[@]}"; do
    gff3s+=( "outfiles_GMAP_rough-draft/Trinity-GG/G_N/$(basename "${i}" .Trinity-GG.fasta).gff3" )
done
echo_test "${gff3s[@]}"
echo "${!gff3s[@]}"
```
</details>
<br />
<br />

<a id="use-a-heredoc-to-make-a-gmap-submission-script-1"></a>
### Use a HEREDOC to make a GMAP submission script
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Use a HEREDOC to make a GMAP submission script</i></summary>

```bash
#!/bin/bash

script_name_sub="submit_GMAP_rough-draft.sh"
threads=1
sh_err_out="sh_err_out"
err_out="sh_err_out/err_out"

if [[ -f "${sh_err_out}/${script_name_sub}" ]]; then
    rm "${sh_err_out}/${script_name_sub}"
fi
cat << script > "${sh_err_out}/${script_name_sub}"
#!/bin/bash

#SBATCH --job-name=${script_name_sub}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=${err_out}/${script_name_sub%.sh}.%J.err.txt
#SBATCH --output=${err_out}/${script_name_sub%.sh}.%J.out.txt

ml GMAP-GSNAP/2018-07-04-foss-2018b
ml SAMtools/1.16.1-GCC-11.2.0

fasta="\${1}"
outfile="\${2}"

gmap \
    -d "sacCer3" \
    -D "\${HOME}/genomes/sacCer3/GMAP" \
    -A "\${fasta}" \
    --format="gff3_gene" \
        > "\${outfile}"
script
```
</details>    
<br />
<br />

<a id="launch-gmap-for-in-outfile-combinations-1"></a>
### Launch GMAP for in-/outfile combinations
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Launch GMAP for in-/outfile combinations</i></summary>

```bash
#!/bin/bash

# for i in "${!fastas[@]}"; do
#     echo "sbatch ${sh_err_out}/${script_name_sub} \\"
#     echo "    ${fastas["${i}"]} \\"
#     echo "    ${gff3s["${i}"]}"
# done

for i in "${!fastas[@]}"; do
    echo "sbatch ${sh_err_out}/${script_name_sub} \\"
    echo "    ${fastas["${i}"]} \\"
    echo "    ${gff3s["${i}"]}"

    sbatch "${sh_err_out}/${script_name_sub}" \
        "${fastas["${i}"]}" \
        "${gff3s["${i}"]}"

    sleep 0.5
    echo ""
done
```
</details>
<br />
