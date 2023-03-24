
`#work_count_features_htseq-count.md`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Install `conda`/`mamba` environment: `expression_env`](#install-condamamba-environment-expression_env)
	1. [Code](#code)
1. [Get situated](#get-situated)
	1. [Code](#code-1)
1. [Run htseq-count on bams in bams_renamed/](#run-htseq-count-on-bams-in-bams_renamed)
	1. [Run htseq-count on bams in bams_renamed/ with combined_SC_KL.gff3](#run-htseq-count-on-bams-in-bams_renamed-with-combined_sc_klgff3)
		1. [Get situated](#get-situated-1)
			1. [Code](#code-2)
		1. [Set up arrays](#set-up-arrays)
			1. [Code](#code-3)
		1. [Index all bams in arrays](#index-all-bams-in-arrays)
			1. [Code](#code-4)
		1. [Run featureCounts with combined_SC_KL.gff3](#run-featurecounts-with-combined_sc_klgff3)
			1. [Code](#code-5)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="install-condamamba-environment-expression_env"></a>
## Install `conda`/`mamba` environment: `expression_env`
<a id="code"></a>
### Code
<details>
<summary><i>Code: Install conda/mamba environment: expression_env</i></summary>

```bash
#!/bin/bash

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

mamba create -n htseq_env -c bioconda python=3.9 htseq=2.0.2=py39h919a90d_0
```
</details>
<br />

<details>
<summary><i>Printed: Install conda/mamba environment: expression_env</i></summary>

```txt
❯ mamba create -n htseq_env -c bioconda python=3.9 htseq=2.0.2=py39h919a90d_0

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['python=3.9', 'htseq==2.0.2=py39h919a90d_0']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/main/linux-64                                            No change
pkgs/r/linux-64                                               No change
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/htseq_env

  Updating specs:

   - python=3.9
   - htseq==2.0.2=py39h919a90d_0


  Package                     Version  Build                Channel                    Size
─────────────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex                 0.1  conda_forge          conda-forge/linux-64     Cached
  + _openmp_mutex                 4.5  2_gnu                conda-forge/linux-64     Cached
  + brotli                      1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + brotli-bin                  1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + bzip2                       1.0.8  h7f98852_4           conda-forge/linux-64     Cached
  + c-ares                     1.18.1  h7f98852_0           conda-forge/linux-64     Cached
  + ca-certificates         2022.12.7  ha878542_0           conda-forge/linux-64     Cached
  + certifi                 2022.12.7  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + contourpy                   1.0.7  py39h4b4f3f3_0       conda-forge/linux-64      216kB
  + cycler                     0.11.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + fonttools                  4.39.2  py39h72bdee0_0       conda-forge/linux-64        2MB
  + freetype                   2.12.1  hca18f0e_1           conda-forge/linux-64     Cached
  + htseq                       2.0.2  py39h919a90d_0       bioconda/linux-64         393kB
  + importlib-resources        5.12.0  pyhd8ed1ab_0         conda-forge/noarch          9kB
  + importlib_resources        5.12.0  pyhd8ed1ab_0         conda-forge/noarch         31kB
  + jpeg                           9e  h0b41bf4_3           conda-forge/linux-64     Cached
  + keyutils                    1.6.1  h166bdaf_0           conda-forge/linux-64     Cached
  + kiwisolver                  1.4.4  py39hf939315_1       conda-forge/linux-64       78kB
  + krb5                       1.20.1  hf9c8cef_0           conda-forge/linux-64     Cached
  + lcms2                        2.14  h6ed2654_0           conda-forge/linux-64     Cached
  + ld_impl_linux-64             2.40  h41732ed_0           conda-forge/linux-64     Cached
  + lerc                        4.0.0  h27087fc_0           conda-forge/linux-64     Cached
  + libblas                     3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libbrotlicommon             1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + libbrotlidec                1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + libbrotlienc                1.0.9  h166bdaf_8           conda-forge/linux-64     Cached
  + libcblas                    3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libcurl                    7.87.0  h6312ad2_0           conda-forge/linux-64     Cached
  + libdeflate                   1.13  h166bdaf_0           conda-forge/linux-64     Cached
  + libedit              3.1.20191231  he28a2e2_2           conda-forge/linux-64     Cached
  + libev                        4.33  h516909a_1           conda-forge/linux-64     Cached
  + libffi                      3.4.2  h7f98852_5           conda-forge/linux-64     Cached
  + libgcc-ng                  12.2.0  h65d4601_19          conda-forge/linux-64     Cached
  + libgfortran-ng             12.2.0  h69a702a_19          conda-forge/linux-64     Cached
  + libgfortran5               12.2.0  h337968e_19          conda-forge/linux-64     Cached
  + libgomp                    12.2.0  h65d4601_19          conda-forge/linux-64     Cached
  + liblapack                   3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libnghttp2                 1.51.0  hdcd2b5c_0           conda-forge/linux-64     Cached
  + libnsl                      2.0.0  h7f98852_0           conda-forge/linux-64     Cached
  + libopenblas                0.3.21  pthreads_h78a6416_3  conda-forge/linux-64     Cached
  + libpng                     1.6.39  h753d276_0           conda-forge/linux-64     Cached
  + libsqlite                  3.40.0  h753d276_0           conda-forge/linux-64     Cached
  + libssh2                    1.10.0  haa6b8db_3           conda-forge/linux-64     Cached
  + libstdcxx-ng               12.2.0  h46fd767_19          conda-forge/linux-64     Cached
  + libtiff                     4.4.0  h0e0dad5_3           conda-forge/linux-64     Cached
  + libuuid                    2.32.1  h7f98852_1000        conda-forge/linux-64     Cached
  + libwebp-base                1.3.0  h0b41bf4_0           conda-forge/linux-64      357kB
  + libxcb                       1.13  h7f98852_1004        conda-forge/linux-64     Cached
  + libzlib                    1.2.13  h166bdaf_4           conda-forge/linux-64     Cached
  + matplotlib-base             3.7.1  py39he190548_0       conda-forge/linux-64        7MB
  + munkres                     1.0.7  py_1                 bioconda/noarch          Cached
  + ncurses                       6.3  h27087fc_1           conda-forge/linux-64     Cached
  + numpy                      1.24.2  py39h7360e5f_0       conda-forge/linux-64        7MB
  + openjpeg                    2.5.0  h7d73246_1           conda-forge/linux-64     Cached
  + openssl                    1.1.1t  h0b41bf4_0           conda-forge/linux-64     Cached
  + packaging                    23.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pillow                      9.2.0  py39hf3a2cdf_3       conda-forge/linux-64       47MB
  + pip                        23.0.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pthread-stubs                 0.4  h36c2ea0_1001        conda-forge/linux-64     Cached
  + pyparsing                   3.0.9  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pysam                      0.20.0  py39h9abd093_0       bioconda/linux-64           3MB
  + python                     3.9.15  h47a2c10_0_cpython   conda-forge/linux-64       22MB
  + python-dateutil             2.8.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + python_abi                    3.9  3_cp39               conda-forge/linux-64     Cached
  + readline                    8.1.2  h0f457ee_0           conda-forge/linux-64     Cached
  + setuptools                 67.6.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + six                        1.16.0  pyh6c4a22f_0         conda-forge/noarch       Cached
  + tk                         8.6.12  h27826a3_0           conda-forge/linux-64     Cached
  + tzdata                      2022g  h191b570_0           conda-forge/noarch       Cached
  + unicodedata2               15.0.0  py39hb9d737c_0       conda-forge/linux-64      512kB
  + wheel                      0.40.0  pyhd8ed1ab_0         conda-forge/noarch         56kB
  + xorg-libxau                 1.0.9  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libxdmcp               1.1.3  h7f98852_0           conda-forge/linux-64     Cached
  + xz                          5.2.6  h166bdaf_0           conda-forge/linux-64     Cached
  + zipp                       3.15.0  pyhd8ed1ab_0         conda-forge/noarch         17kB
  + zlib                       1.2.13  h166bdaf_4           conda-forge/linux-64     Cached
  + zstd                        1.5.2  h3eb15da_6           conda-forge/linux-64     Cached

  Summary:

  Install: 77 packages

  Total download: 89MB

─────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
importlib_resources                                 31.0kB @ 391.1kB/s  0.1s
zipp                                                17.2kB @ 182.8kB/s  0.1s
libwebp-base                                       356.8kB @   3.4MB/s  0.1s
wheel                                               55.7kB @ 526.8kB/s  0.1s
contourpy                                          215.5kB @   1.7MB/s  0.1s
unicodedata2                                       512.1kB @   3.6MB/s  0.0s
kiwisolver                                          77.5kB @ 443.2kB/s  0.0s
matplotlib-base                                      6.8MB @  30.7MB/s  0.1s
importlib-resources                                  9.3kB @  40.6kB/s  0.0s
htseq                                              393.3kB @   1.7MB/s  0.1s
pysam                                                2.8MB @   8.9MB/s  0.1s
fonttools                                            2.1MB @   6.4MB/s  0.1s
numpy                                                6.7MB @  17.6MB/s  0.2s
python                                              21.9MB @  53.5MB/s  0.4s
pillow                                              47.5MB @  87.9MB/s  0.5s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done

```
</details>
<br />
<br />

<a id="get-situated"></a>
## Get situated
<a id="code-1"></a>
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
<a id="code-2"></a>
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
<a id="code-3"></a>
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
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Index all bams in arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

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

<a id="run-featurecounts-with-combined_sc_klgff3"></a>
#### Run featureCounts with combined_SC_KL.gff3
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Run featureCounts with combined_SC_KL.gff3</i></summary>

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
