 
`work_count_features.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Set up environment for normalization, etc. analyses](#set-up-environment-for-normalization-etc-analyses)
    1. [Get situated, make directory for `featureCounts` work, etc.](#get-situated-make-directory-for-featurecounts-work-etc)
        1. [Code](#code)
    1. [Install featureCounts in Trinity_env](#install-featurecounts-in-trinity_env)
        1. [Code](#code-1)
        1. [Printed](#printed)
    1. [Create a new environment for normalization work, install programs, etc.](#create-a-new-environment-for-normalization-work-install-programs-etc)
        1. [Code](#code-2)
        1. [Printed](#printed-1)
1. [Symlink to datasets](#symlink-to-datasets)
    1. [Symlink to datasets without renaming them](#symlink-to-datasets-without-renaming-them)
        1. [Code](#code-3)
    1. [Use symlinks to give the datasets intuitive names](#use-symlinks-to-give-the-datasets-intuitive-names)
        1. [Get situated, make necessary directories](#get-situated-make-necessary-directories)
            1. [Code](#code-4)
        1. [Determine the relative paths](#determine-the-relative-paths)
            1. [Code](#code-5)
        1. [Set up associative arrays \(to be used in the symlinking\)](#set-up-associative-arrays-to-be-used-in-the-symlinking)
            1. [Code](#code-6)
        1. [Perform the symlinking](#perform-the-symlinking)
            1. [Code](#code-7)
1. [Run featureCounts](#run-featurecounts)
    1. [Test to determine option for featureCounts -s \(results in an error\)](#test-to-determine-option-for-featurecounts--s-results-in-an-error)
        1. [Code](#code-8)
        1. [Printed](#printed-2)
    1. [Convert the gff3 to "SAF" format](#convert-the-gff3-to-saf-format)
        1. [Code](#code-9)
        1. [Printed](#printed-3)
    1. [Test to determine option for featureCounts -s using the .saf file](#test-to-determine-option-for-featurecounts--s-using-the-saf-file)
        1. [Code](#code-10)
        1. [Printed](#printed-4)
    1. [Test to determine option for featureCounts -s with -g "ID" \(`#CORRECT`\)](#test-to-determine-option-for-featurecounts--s-with--g-id-correct)
        1. [Code](#code-11)
        1. [Printed](#printed-5)
    1. [Clean up](#clean-up)
        1. [Code](#code-12)
1. [Run featureCounts on bams in bams/ with combined_SC_KL.gff3](#run-featurecounts-on-bams-in-bams-with-combined_sc_klgff3)
    1. [Code](#code-13)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="set-up-environment-for-normalization-etc-analyses"></a>
## Set up environment for normalization, etc. analyses
<a id="get-situated-make-directory-for-featurecounts-work-etc"></a>
### Get situated, make directory for `featureCounts` work, etc.
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directory for featureCounts work, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 16, etc.

transcriptome && 
    {
        cd "results" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env

mkdir 2023-0215/

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }
```
</details>
<br />

<a id="install-featurecounts-in-trinity_env"></a>
### Install featureCounts in Trinity_env
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Install featureCounts in Trinity_env</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mamba install -c bioconda subread
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Install featureCounts in Trinity_env</i></summary>

```txt
❯ mamba install -c bioconda subread

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

        mamba (1.1.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['subread']

pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                   819.1kB @   2.6MB/s  0.3s
bioconda/noarch                                      4.2MB @   2.7MB/s  1.9s
pkgs/main/linux-64                                   5.2MB @   2.8MB/s  5.3s
bioconda/linux-64                                    4.5MB @ 806.0kB/s  6.6s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/Trinity_env

  Updating specs:

   - subread
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build       Channel               Size
──────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────

  + subread    2.0.3  h7132678_1  bioconda/linux-64     25MB

  Summary:

  Install: 1 packages

  Total download: 25MB

──────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
subread                                             24.7MB @  35.9MB/s  1.1s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="create-a-new-environment-for-normalization-work-install-programs-etc"></a>
### Create a new environment for normalization work, install programs, etc.
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Create a new environment for normalization work, install programs, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

mamba create \
    -n expression_env \
    -c conda-forge \
        r-base \
        r-tidyverse \
        mamba

source activate expression_env

mamba install -c bioconda bioconductor-deseq2

mamba install -c bioconda subread

mamba install \
    -c bioconda \
        bioconductor-enhancedvolcano bioconductor-pcatools

```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Create a new environment for normalization work, install programs, etc.</i></summary>

```txt
❯ mamba create \
>     -n expression_env \
>     -c conda-forge \
>         r-base \
>         r-tidyverse \
>         mamba

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


Looking for: ['r-base', 'r-tidyverse', 'mamba']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
conda-forge/noarch                                  11.3MB @   2.7MB/s  4.9s
conda-forge/linux-64                                29.8MB @   4.9MB/s  8.0s
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/expression_env

  Updating specs:

   - r-base
   - r-tidyverse
   - mamba


  Package                           Version  Build                Channel                    Size
───────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex                       0.1  conda_forge          conda-forge/linux-64     Cached
  + _openmp_mutex                       4.5  2_gnu                conda-forge/linux-64     Cached
  + _r-mutex                          1.0.1  anacondar_1          conda-forge/noarch       Cached
  + binutils_impl_linux-64             2.40  hf600244_0           conda-forge/linux-64     Cached
  + brotlipy                          0.7.0  py311hd4cff14_1005   conda-forge/linux-64     Cached
  + bwidget                          1.9.14  ha770c72_1           conda-forge/linux-64     Cached
  + bzip2                             1.0.8  h7f98852_4           conda-forge/linux-64     Cached
  + c-ares                           1.18.1  h7f98852_0           conda-forge/linux-64     Cached
  + ca-certificates               2022.12.7  ha878542_0           conda-forge/linux-64     Cached
  + cairo                            1.16.0  ha61ee94_1014        conda-forge/linux-64     Cached
  + certifi                       2022.12.7  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + cffi                             1.15.1  py311h409f033_3      conda-forge/linux-64     Cached
  + charset-normalizer                2.1.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + colorama                          0.4.6  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + conda                           22.11.1  py311h38be061_1      conda-forge/linux-64     Cached
  + conda-package-handling            2.0.2  pyh38be061_0         conda-forge/noarch       Cached
  + conda-package-streaming           0.7.0  pyhd8ed1ab_1         conda-forge/noarch       Cached
  + cryptography                     39.0.1  py311h9b4c7bb_0      conda-forge/linux-64     Cached
  + curl                             7.88.0  hdc1c0ab_0           conda-forge/linux-64     Cached
  + expat                             2.5.0  h27087fc_0           conda-forge/linux-64     Cached
  + fmt                               9.1.0  h924138e_0           conda-forge/linux-64     Cached
  + font-ttf-dejavu-sans-mono          2.37  hab24e00_0           conda-forge/noarch       Cached
  + font-ttf-inconsolata              3.000  h77eed37_0           conda-forge/noarch       Cached
  + font-ttf-source-code-pro          2.038  h77eed37_0           conda-forge/noarch       Cached
  + font-ttf-ubuntu                    0.83  hab24e00_0           conda-forge/noarch       Cached
  + fontconfig                       2.14.2  h14ed4e7_0           conda-forge/linux-64     Cached
  + fonts-conda-ecosystem                 1  0                    conda-forge/noarch       Cached
  + fonts-conda-forge                     1  0                    conda-forge/noarch       Cached
  + freetype                         2.12.1  hca18f0e_1           conda-forge/linux-64     Cached
  + fribidi                          1.0.10  h36c2ea0_0           conda-forge/linux-64     Cached
  + gcc_impl_linux-64                12.2.0  hcc96c02_19          conda-forge/linux-64     Cached
  + gettext                          0.21.1  h27087fc_0           conda-forge/linux-64     Cached
  + gfortran_impl_linux-64           12.2.0  h55be85b_19          conda-forge/linux-64     Cached
  + graphite2                        1.3.13  h58526e2_1001        conda-forge/linux-64     Cached
  + gsl                                 2.7  he838d99_0           conda-forge/linux-64     Cached
  + gxx_impl_linux-64                12.2.0  hcc96c02_19          conda-forge/linux-64     Cached
  + harfbuzz                          6.0.0  h8e241bc_0           conda-forge/linux-64     Cached
  + icu                                70.1  h27087fc_0           conda-forge/linux-64     Cached
  + idna                                3.4  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + jpeg                                 9e  h0b41bf4_3           conda-forge/linux-64     Cached
  + kernel-headers_linux-64          2.6.32  he073ed8_15          conda-forge/noarch       Cached
  + keyutils                          1.6.1  h166bdaf_0           conda-forge/linux-64     Cached
  + krb5                             1.20.1  h81ceb04_0           conda-forge/linux-64     Cached
  + ld_impl_linux-64                   2.40  h41732ed_0           conda-forge/linux-64     Cached
  + lerc                              4.0.0  h27087fc_0           conda-forge/linux-64     Cached
  + libarchive                        3.6.2  h3d51595_0           conda-forge/linux-64     Cached
  + libblas                           3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libcblas                          3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libcurl                          7.88.0  hdc1c0ab_0           conda-forge/linux-64     Cached
  + libdeflate                         1.17  h0b41bf4_0           conda-forge/linux-64     Cached
  + libedit                    3.1.20191231  he28a2e2_2           conda-forge/linux-64     Cached
  + libev                              4.33  h516909a_1           conda-forge/linux-64     Cached
  + libffi                            3.4.2  h7f98852_5           conda-forge/linux-64     Cached
  + libgcc-devel_linux-64            12.2.0  h3b97bd3_19          conda-forge/linux-64     Cached
  + libgcc-ng                        12.2.0  h65d4601_19          conda-forge/linux-64     Cached
  + libgfortran-ng                   12.2.0  h69a702a_19          conda-forge/linux-64     Cached
  + libgfortran5                     12.2.0  h337968e_19          conda-forge/linux-64     Cached
  + libglib                          2.74.1  h606061b_1           conda-forge/linux-64     Cached
  + libgomp                          12.2.0  h65d4601_19          conda-forge/linux-64     Cached
  + libiconv                           1.17  h166bdaf_0           conda-forge/linux-64     Cached
  + liblapack                         3.9.0  16_linux64_openblas  conda-forge/linux-64     Cached
  + libmamba                          1.3.1  hcea66bb_1           conda-forge/linux-64     Cached
  + libmambapy                        1.3.1  py311h1f88262_1      conda-forge/linux-64     Cached
  + libnghttp2                       1.51.0  hff17c54_0           conda-forge/linux-64     Cached
  + libnsl                            2.0.0  h7f98852_0           conda-forge/linux-64     Cached
  + libopenblas                      0.3.21  pthreads_h78a6416_3  conda-forge/linux-64     Cached
  + libpng                           1.6.39  h753d276_0           conda-forge/linux-64     Cached
  + libsanitizer                     12.2.0  h46fd767_19          conda-forge/linux-64     Cached
  + libsolv                          0.7.23  h3eb15da_0           conda-forge/linux-64     Cached
  + libsqlite                        3.40.0  h753d276_0           conda-forge/linux-64     Cached
  + libssh2                          1.10.0  hf14f497_3           conda-forge/linux-64     Cached
  + libstdcxx-devel_linux-64         12.2.0  h3b97bd3_19          conda-forge/linux-64     Cached
  + libstdcxx-ng                     12.2.0  h46fd767_19          conda-forge/linux-64     Cached
  + libtiff                           4.5.0  h6adf6a1_2           conda-forge/linux-64     Cached
  + libuuid                          2.32.1  h7f98852_1000        conda-forge/linux-64     Cached
  + libwebp-base                      1.2.4  h166bdaf_0           conda-forge/linux-64     Cached
  + libxcb                             1.13  h7f98852_1004        conda-forge/linux-64     Cached
  + libxml2                          2.10.3  h7463322_0           conda-forge/linux-64     Cached
  + libzlib                          1.2.13  h166bdaf_4           conda-forge/linux-64     Cached
  + lz4-c                             1.9.4  hcb278e6_0           conda-forge/linux-64     Cached
  + lzo                                2.10  h516909a_1000        conda-forge/linux-64     Cached
  + make                                4.3  hd18ef5c_1           conda-forge/linux-64     Cached
  + mamba                             1.3.1  py311h3072747_1      conda-forge/linux-64     Cached
  + ncurses                             6.3  h27087fc_1           conda-forge/linux-64     Cached
  + openssl                           3.0.8  h0b41bf4_0           conda-forge/linux-64     Cached
  + pandoc                           2.19.2  h32600fe_1           conda-forge/linux-64     Cached
  + pango                           1.50.12  hd33c08f_1           conda-forge/linux-64     Cached
  + pcre2                             10.40  hc3806b6_0           conda-forge/linux-64     Cached
  + pip                              23.0.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pixman                           0.40.0  h36c2ea0_0           conda-forge/linux-64     Cached
  + pluggy                            1.0.0  pyhd8ed1ab_5         conda-forge/noarch       Cached
  + pthread-stubs                       0.4  h36c2ea0_1001        conda-forge/linux-64     Cached
  + pybind11-abi                          4  hd8ed1ab_3           conda-forge/noarch       Cached
  + pycosat                           0.6.4  py311hd4cff14_1      conda-forge/linux-64     Cached
  + pycparser                          2.21  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pyopenssl                        23.0.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + pysocks                           1.7.1  pyha2e5f31_6         conda-forge/noarch       Cached
  + python                           3.11.0  he550d4f_1_cpython   conda-forge/linux-64     Cached
  + python_abi                         3.11  3_cp311              conda-forge/linux-64     Cached
  + r-askpass                           1.1  r42h06615bd_3        conda-forge/linux-64     Cached
  + r-assertthat                      0.2.1  r42hc72bb7e_3        conda-forge/noarch       Cached
  + r-backports                       1.4.1  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-base                            4.2.2  ha7d60f8_3           conda-forge/linux-64     Cached
  + r-base64enc                       0.1_3  r42h06615bd_1005     conda-forge/linux-64     Cached
  + r-bit                             4.0.5  r42h06615bd_0        conda-forge/linux-64     Cached
  + r-bit64                           4.0.5  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-blob                            1.2.3  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-broom                           1.0.3  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-bslib                           0.4.2  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-cachem                          1.0.6  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-callr                           3.7.3  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-cellranger                      1.1.0  r42hc72bb7e_1005     conda-forge/noarch       Cached
  + r-cli                             3.6.0  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-clipr                           0.8.0  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-colorspace                      2.1_0  r42h133d619_0        conda-forge/linux-64     Cached
  + r-cpp11                           0.4.3  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-crayon                          1.5.2  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-curl                            4.3.3  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-data.table                     1.14.8  r42h133d619_0        conda-forge/linux-64     Cached
  + r-dbi                             1.1.3  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-dbplyr                          2.3.0  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-digest                         0.6.31  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-dplyr                           1.1.0  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-dtplyr                          1.2.2  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-ellipsis                        0.3.2  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-evaluate                         0.20  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-fansi                           1.0.4  r42h133d619_0        conda-forge/linux-64     Cached
  + r-farver                          2.1.1  r42h7525677_1        conda-forge/linux-64     Cached
  + r-fastmap                         1.1.0  r42h7525677_1        conda-forge/linux-64     Cached
  + r-forcats                         1.0.0  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-fs                              1.6.1  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-gargle                          1.3.0  r42h785f33e_0        conda-forge/noarch       Cached
  + r-generics                        0.1.3  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-ggplot2                         3.4.1  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-glue                            1.6.2  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-googledrive                     2.0.0  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-googlesheets4                   1.0.1  r42h785f33e_1        conda-forge/noarch       Cached
  + r-gtable                          0.3.1  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-haven                           2.5.1  r42h7525677_0        conda-forge/linux-64     Cached
  + r-highr                            0.10  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-hms                             1.1.2  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-htmltools                       0.5.4  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-httr                            1.4.4  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-ids                             1.0.1  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-isoband                         0.2.7  r42h38f115c_1        conda-forge/linux-64     Cached
  + r-jquerylib                       0.1.4  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-jsonlite                        1.8.4  r42h133d619_0        conda-forge/linux-64     Cached
  + r-knitr                            1.42  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-labeling                        0.4.2  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-lattice                       0.20_45  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-lifecycle                       1.0.3  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-lubridate                       1.9.1  r42h133d619_0        conda-forge/linux-64     Cached
  + r-magrittr                        2.0.3  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-mass                         7.3_58.2  r42h133d619_0        conda-forge/linux-64     Cached
  + r-matrix                          1.5_3  r42h5f7b363_0        conda-forge/linux-64     Cached
  + r-memoise                         2.0.1  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-mgcv                           1.8_41  r42h5f7b363_0        conda-forge/linux-64     Cached
  + r-mime                             0.12  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-modelr                         0.1.10  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-munsell                         0.5.0  r42hc72bb7e_1005     conda-forge/noarch       Cached
  + r-nlme                          3.1_162  r42hac0b197_0        conda-forge/linux-64     Cached
  + r-openssl                         2.0.5  r42habfbb5e_0        conda-forge/linux-64     Cached
  + r-pillar                          1.8.1  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-pkgconfig                       2.0.3  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-prettyunits                     1.1.1  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-processx                        3.8.0  r42h06615bd_0        conda-forge/linux-64     Cached
  + r-progress                        1.2.2  r42hc72bb7e_3        conda-forge/noarch       Cached
  + r-ps                              1.7.2  r42h06615bd_0        conda-forge/linux-64     Cached
  + r-purrr                           1.0.1  r42h133d619_0        conda-forge/linux-64     Cached
  + r-r6                              2.5.1  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-rappdirs                        0.3.3  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-rcolorbrewer                    1.1_3  r42h785f33e_1        conda-forge/noarch       Cached
  + r-rcpp                           1.0.10  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-readr                           2.1.4  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-readxl                          1.4.2  r42h81ef4d7_0        conda-forge/linux-64     Cached
  + r-rematch                         1.0.1  r42hc72bb7e_1005     conda-forge/noarch       Cached
  + r-rematch2                        2.1.2  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-reprex                          2.0.2  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-rlang                           1.0.6  r42h7525677_1        conda-forge/linux-64     Cached
  + r-rmarkdown                        2.20  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-rstudioapi                       0.14  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-rvest                           1.0.3  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-sass                            0.4.5  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-scales                          1.2.1  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-selectr                         0.4_2  r42hc72bb7e_2        conda-forge/noarch       Cached
  + r-stringi                        1.7.12  r42h1ae9187_0        conda-forge/linux-64     Cached
  + r-stringr                         1.5.0  r42h785f33e_0        conda-forge/noarch       Cached
  + r-sys                             3.4.1  r42h06615bd_0        conda-forge/linux-64     Cached
  + r-tibble                          3.1.8  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-tidyr                           1.3.0  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-tidyselect                      1.2.0  r42hc72bb7e_0        conda-forge/linux-64     Cached
  + r-tidyverse                       1.3.2  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-timechange                      0.2.0  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-tinytex                          0.44  r42hc72bb7e_0        conda-forge/noarch       Cached
  + r-tzdb                            0.3.0  r42h7525677_1        conda-forge/linux-64     Cached
  + r-utf8                            1.2.3  r42h133d619_0        conda-forge/linux-64     Cached
  + r-uuid                            1.1_0  r42h06615bd_1        conda-forge/linux-64     Cached
  + r-vctrs                           0.5.2  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-viridislite                     0.4.1  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-vroom                           1.6.1  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-withr                           2.5.0  r42hc72bb7e_1        conda-forge/noarch       Cached
  + r-xfun                             0.37  r42h38f115c_0        conda-forge/linux-64     Cached
  + r-xml2                            1.3.3  r42h044e5c7_2        conda-forge/linux-64     Cached
  + r-yaml                            2.3.7  r42h133d619_0        conda-forge/linux-64     Cached
  + readline                          8.1.2  h0f457ee_0           conda-forge/linux-64     Cached
  + reproc                           14.2.4  h0b41bf4_0           conda-forge/linux-64     Cached
  + reproc-cpp                       14.2.4  hcb278e6_0           conda-forge/linux-64     Cached
  + requests                         2.28.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + ruamel.yaml                     0.17.21  py311hd4cff14_2      conda-forge/linux-64     Cached
  + ruamel.yaml.clib                  0.2.7  py311h2582759_1      conda-forge/linux-64     Cached
  + sed                                 4.8  he412f7d_0           conda-forge/linux-64     Cached
  + setuptools                       67.3.2  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + sysroot_linux-64                   2.12  he073ed8_15          conda-forge/noarch       Cached
  + tk                               8.6.12  h27826a3_0           conda-forge/linux-64     Cached
  + tktable                            2.10  hb7b940f_3           conda-forge/linux-64     Cached
  + toolz                            0.12.0  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + tqdm                             4.64.1  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + tzdata                            2022g  h191b570_0           conda-forge/noarch       Cached
  + urllib3                         1.26.14  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + wheel                            0.38.4  pyhd8ed1ab_0         conda-forge/noarch       Cached
  + xorg-kbproto                      1.0.7  h7f98852_1002        conda-forge/linux-64     Cached
  + xorg-libice                      1.0.10  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libsm                        1.2.3  hd9c2040_1000        conda-forge/linux-64     Cached
  + xorg-libx11                       1.7.2  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libxau                       1.0.9  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libxdmcp                     1.1.3  h7f98852_0           conda-forge/linux-64     Cached
  + xorg-libxext                      1.3.4  h7f98852_1           conda-forge/linux-64     Cached
  + xorg-libxrender                  0.9.10  h7f98852_1003        conda-forge/linux-64     Cached
  + xorg-libxt                        1.2.1  h7f98852_2           conda-forge/linux-64     Cached
  + xorg-renderproto                 0.11.1  h7f98852_1002        conda-forge/linux-64     Cached
  + xorg-xextproto                    7.3.0  h7f98852_1002        conda-forge/linux-64     Cached
  + xorg-xproto                      7.0.31  h7f98852_1007        conda-forge/linux-64     Cached
  + xz                                5.2.6  h166bdaf_0           conda-forge/linux-64     Cached
  + yaml-cpp                          0.7.0  h27087fc_2           conda-forge/linux-64     Cached
  + zlib                             1.2.13  h166bdaf_4           conda-forge/linux-64     Cached
  + zstandard                        0.19.0  py311hbe0fcd7_1      conda-forge/linux-64     Cached
  + zstd                              1.5.2  h3eb15da_6           conda-forge/linux-64     Cached

  Summary:

  Install: 237 packages

  Total download: 0 B

───────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate expression_env

To deactivate an active environment, use

     $ mamba 


❯ mamba install -c bioconda bioconductor-deseq2

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


Looking for: ['bioconductor-deseq2']

bioconda/noarch                                      4.2MB @   4.6MB/s  1.1s
bioconda/linux-64                                    4.5MB @   4.0MB/s  1.3s
pkgs/main/linux-64                                   5.2MB @   2.7MB/s  2.4s
pkgs/r/noarch                                        1.3MB @ 602.5kB/s  1.6s
pkgs/main/noarch                                   819.1kB @ 313.2kB/s  1.5s
pkgs/r/linux-64                                      1.4MB @ 524.7kB/s  0.9s
conda-forge/noarch                                  11.3MB @   3.6MB/s  3.5s
conda-forge/linux-64                                29.8MB @   4.2MB/s  8.1s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/expression_env

  Updating specs:

   - bioconductor-deseq2
   - ca-certificates
   - certifi
   - openssl


  Package                                 Version  Build             Channel                   Size
─────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  + argcomplete                             2.0.0  pyhd8ed1ab_0      conda-forge/noarch        35kB
  + bioconductor-annotate                  1.76.0  r42hdfd78af_0     bioconda/noarch            2MB
  + bioconductor-annotationdbi             1.60.0  r42hdfd78af_0     bioconda/noarch            5MB
  + bioconductor-biobase                   2.58.0  r42hc0cfd56_0     bioconda/linux-64          2MB
  + bioconductor-biocgenerics              0.44.0  r42hdfd78af_0     bioconda/noarch          665kB
  + bioconductor-biocparallel              1.32.5  r42hc247a5b_0     bioconda/linux-64          2MB
  + bioconductor-biostrings                2.66.0  r42hc0cfd56_0     bioconda/linux-64         14MB
  + bioconductor-data-packages           20230202  hdfd78af_0        bioconda/noarch          144kB
  + bioconductor-delayedarray              0.24.0  r42hc0cfd56_0     bioconda/linux-64          2MB
  + bioconductor-deseq2                    1.38.0  r42hc247a5b_0     bioconda/linux-64          3MB
  + bioconductor-genefilter                1.80.0  r42h38f54d8_0     bioconda/linux-64          1MB
  + bioconductor-geneplotter               1.76.0  r42hdfd78af_0     bioconda/noarch            2MB
  + bioconductor-genomeinfodb              1.34.8  r42hdfd78af_0     bioconda/noarch            4MB
  + bioconductor-genomeinfodbdata           1.2.9  r42hdfd78af_0     bioconda/noarch            8kB
  + bioconductor-genomicranges             1.50.0  r42hc0cfd56_0     bioconda/linux-64          2MB
  + bioconductor-iranges                   2.32.0  r42hc0cfd56_0     bioconda/linux-64          3MB
  + bioconductor-keggrest                  1.38.0  r42hdfd78af_0     bioconda/noarch          199kB
  + bioconductor-matrixgenerics            1.10.0  r42hdfd78af_0     bioconda/noarch          353kB
  + bioconductor-s4vectors                 0.36.0  r42hc0cfd56_0     bioconda/linux-64          2MB
  + bioconductor-summarizedexperiment      1.28.0  r42hdfd78af_0     bioconda/noarch            3MB
  + bioconductor-xvector                   0.38.0  r42hc0cfd56_0     bioconda/linux-64        738kB
  + bioconductor-zlibbioc                  1.44.0  r42hc0cfd56_0     bioconda/linux-64         74kB
  + importlib-metadata                     4.13.0  pyha770c72_0      conda-forge/noarch        26kB
  + importlib_metadata                     4.13.0  hd8ed1ab_0        conda-forge/noarch         9kB
  + jq                                        1.5  0                 bioconda/linux-64          1MB
  + libgcc                                  7.2.0  h69d50b8_2        conda-forge/linux-64     312kB
  + pyyaml                                    6.0  py311hd4cff14_5   conda-forge/linux-64     207kB
  + r-bh                                 1.81.0_1  r42hc72bb7e_0     conda-forge/noarch        11MB
  + r-bitops                                1.0_7  r42h06615bd_1     conda-forge/linux-64      46kB
  + r-codetools                            0.2_19  r42hc72bb7e_0     conda-forge/noarch       108kB
  + r-formatr                                1.14  r42hc72bb7e_0     conda-forge/noarch       165kB
  + r-futile.logger                         1.4.3  r42hc72bb7e_1004  conda-forge/noarch       111kB
  + r-futile.options                        1.0.1  r42hc72bb7e_1003  conda-forge/noarch        29kB
  + r-lambda.r                              1.2.4  r42hc72bb7e_2     conda-forge/noarch       124kB
  + r-locfit                              1.5_9.7  r42h133d619_0     conda-forge/linux-64     551kB
  + r-matrixstats                          0.63.0  r42h06615bd_0     conda-forge/linux-64     445kB
  + r-plogr                                 0.2.0  r42hc72bb7e_1004  conda-forge/noarch        21kB
  + r-png                                   0.1_8  r42h10cf519_0     conda-forge/linux-64      58kB
  + r-rcpparmadillo                    0.11.4.4.0  r42h358215d_0     conda-forge/linux-64     873kB
  + r-rcurl                             1.98_1.10  r42h133d619_0     conda-forge/linux-64     817kB
  + r-rsqlite                              2.2.20  r42h38f115c_0     conda-forge/linux-64       1MB
  + r-snow                                  0.4_4  r42hc72bb7e_1     conda-forge/noarch       117kB
  + r-survival                              3.5_3  r42h133d619_0     conda-forge/linux-64       6MB
  + r-xml                               3.99_0.13  r42hed7f998_0     conda-forge/linux-64       2MB
  + r-xtable                                1.8_4  r42hc72bb7e_4     conda-forge/noarch       717kB
  + toml                                   0.10.2  pyhd8ed1ab_0      conda-forge/noarch        18kB
  + xmltodict                              0.13.0  pyhd8ed1ab_0      conda-forge/noarch        14kB
  + yaml                                    0.2.5  h7f98852_2        conda-forge/linux-64      89kB
  + yq                                      3.1.0  pyhd8ed1ab_0      conda-forge/noarch        22kB
  + zipp                                   3.14.0  pyhd8ed1ab_0      conda-forge/noarch        17kB

  Summary:

  Install: 50 packages

  Total download: 76MB

─────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
bioconductor-s4vectors                               2.3MB @  30.2MB/s  0.1s
bioconductor-biocgenerics                          664.5kB @   6.3MB/s  0.1s
yaml                                                89.1kB @ 643.1kB/s  0.0s
bioconductor-zlibbioc                               74.5kB @ 499.8kB/s  0.2s
r-snow                                             117.0kB @ 576.0kB/s  0.1s
pyyaml                                             207.0kB @ 983.0kB/s  0.1s
xmltodict                                           13.6kB @  60.5kB/s  0.0s
r-locfit                                           551.0kB @   2.2MB/s  0.2s
r-plogr                                             21.2kB @  78.1kB/s  0.1s
r-lambda.r                                         123.9kB @ 452.7kB/s  0.1s
argcomplete                                         35.2kB @ 116.3kB/s  0.0s
bioconductor-iranges                                 2.5MB @   8.2MB/s  0.3s
r-futile.logger                                    111.1kB @ 360.6kB/s  0.1s
bioconductor-matrixgenerics                        352.7kB @ 960.6kB/s  0.1s
bioconductor-biobase                                 2.5MB @   6.2MB/s  0.6s
bioconductor-keggrest                              199.5kB @ 386.5kB/s  0.3s
bioconductor-xvector                               737.8kB @   1.3MB/s  0.2s
bioconductor-genomicranges                           2.3MB @   4.0MB/s  0.3s
bioconductor-genomeinfodb                            4.3MB @   7.1MB/s  0.3s
zipp                                                17.3kB @  20.3kB/s  0.2s
bioconductor-deseq2                                  2.9MB @   3.4MB/s  0.6s
r-rcpparmadillo                                    873.0kB @ 907.6kB/s  0.4s
importlib_metadata                                   9.1kB @   9.5kB/s  0.1s
bioconductor-biocparallel                            1.7MB @   1.3MB/s  0.4s
bioconductor-delayedarray                            2.5MB @   1.9MB/s  0.4s
r-rsqlite                                            1.2MB @ 880.6kB/s  0.5s
r-survival                                           5.9MB @   4.0MB/s  1.2s
r-bh                                                11.4MB @   7.0MB/s  1.2s
bioconductor-genefilter                              1.2MB @ 690.8kB/s  0.4s
r-matrixstats                                      444.8kB @ 241.5kB/s  0.4s
r-codetools                                        108.1kB @  58.6kB/s  0.4s
toml                                                18.4kB @  10.0kB/s  0.4s
bioconductor-geneplotter                             1.5MB @ 830.8kB/s  0.7s
importlib-metadata                                  25.5kB @  12.1kB/s  0.3s
jq                                                   1.2MB @ 555.9kB/s  0.4s
yq                                                  22.4kB @  10.6kB/s  0.4s
bioconductor-data-packages                         144.5kB @  68.2kB/s  0.5s
r-png                                               58.3kB @  24.5kB/s  0.3s
bioconductor-genomeinfodbdata                        7.9kB @   3.3kB/s  0.3s
bioconductor-summarizedexperiment                    2.8MB @   1.1MB/s  0.3s
r-futile.options                                    28.8kB @  10.8kB/s  0.4s
r-xml                                                1.7MB @ 613.4kB/s  0.6s
bioconductor-annotate                                1.8MB @ 608.3kB/s  0.6s
libgcc                                             311.7kB @ 102.6kB/s  0.4s
bioconductor-annotationdbi                           5.2MB @   1.6MB/s  1.1s
r-bitops                                            45.7kB @  13.9kB/s  0.3s
r-rcurl                                            817.2kB @ 248.4kB/s  0.5s
r-xtable                                           717.4kB @ 217.8kB/s  0.3s
bioconductor-biostrings                             14.2MB @   4.3MB/s  1.4s
r-formatr                                          165.2kB @  46.7kB/s  0.2s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c bioconda subread

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


Looking for: ['subread']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/r/linux-64                                               No change
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/expression_env

  Updating specs:

   - subread
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build       Channel               Size
──────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────

  + subread    2.0.3  h7132678_1  bioconda/linux-64     25MB

  Summary:

  Install: 1 packages

  Total download: 25MB

──────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
subread                                             24.7MB @  40.9MB/s  0.7s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install \
>     -c bioconda \
>         bioconductor-enhancedvolcano bioconductor-pcatools

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


Looking for: ['bioconductor-enhancedvolcano', 'bioconductor-pcatools']

bioconda/linux-64                                           Using cache
bioconda/noarch                                             Using cache
conda-forge/linux-64                                        Using cache
conda-forge/noarch                                          Using cache
pkgs/main/linux-64                                            No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/expression_env

  Updating specs:

   - bioconductor-enhancedvolcano
   - bioconductor-pcatools
   - ca-certificates
   - certifi
   - openssl


  Package                            Version  Build          Channel                   Size
─────────────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────────────

  + bioconductor-beachmat             2.14.0  r42hc247a5b_0  bioconda/linux-64          1MB
  + bioconductor-biocsingular         1.14.0  r42hc247a5b_0  bioconda/linux-64        993kB
  + bioconductor-delayedmatrixstats   1.20.0  r42hdfd78af_0  bioconda/noarch          740kB
  + bioconductor-enhancedvolcano      1.16.0  r42hdfd78af_0  bioconda/noarch            5MB
  + bioconductor-pcatools             2.10.0  r42hc247a5b_0  bioconda/linux-64          5MB
  + bioconductor-scaledmatrix          1.6.0  r42hdfd78af_0  bioconda/noarch          653kB
  + bioconductor-sparsematrixstats    1.10.0  r42hc247a5b_0  bioconda/linux-64          1MB
  + r-cowplot                          1.1.1  r42hc72bb7e_1  conda-forge/noarch         1MB
  + r-dqrng                            0.3.0  r42h7525677_1  conda-forge/linux-64     173kB
  + r-ggrepel                          0.9.3  r42h38f115c_0  conda-forge/linux-64     268kB
  + r-irlba                          2.3.5.1  r42h5f7b363_0  conda-forge/linux-64     317kB
  + r-plyr                             1.8.8  r42h7525677_0  conda-forge/linux-64     855kB
  + r-reshape2                         1.4.4  r42h7525677_2  conda-forge/linux-64     135kB
  + r-rsvd                             1.0.5  r42hc72bb7e_1  conda-forge/noarch         4MB
  + r-sitmo                            2.0.2  r42h7525677_1  conda-forge/linux-64     165kB

  Summary:

  Install: 15 packages

  Total download: 22MB

─────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
bioconductor-delayedmatrixstats                    739.6kB @  10.1MB/s  0.1s
bioconductor-scaledmatrix                          652.9kB @   6.2MB/s  0.1s
bioconductor-beachmat                                1.3MB @  11.5MB/s  0.1s
r-irlba                                            316.6kB @   2.2MB/s  0.0s
bioconductor-biocsingular                          992.9kB @   6.6MB/s  0.1s
bioconductor-sparsematrixstats                       1.2MB @   5.3MB/s  0.2s
r-plyr                                             855.3kB @   3.7MB/s  0.1s
r-cowplot                                            1.4MB @   6.0MB/s  0.2s
r-reshape2                                         135.2kB @ 543.4kB/s  0.1s
r-ggrepel                                          268.0kB @ 993.0kB/s  0.3s
r-rsvd                                               3.6MB @  11.2MB/s  0.1s
r-dqrng                                            173.1kB @ 495.0kB/s  0.1s
r-sitmo                                            165.0kB @ 427.7kB/s  0.1s
bioconductor-enhancedvolcano                         5.1MB @   7.8MB/s  0.4s
bioconductor-pcatools                                5.0MB @   5.4MB/s  0.7s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<br />
<br />

<a id="symlink-to-datasets"></a>
## Symlink to datasets
<a id="symlink-to-datasets-without-renaming-them"></a>
### Symlink to datasets without renaming them
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Symlink to datasets without renaming them</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd 2023-0215/ \
    || echo "cd'ing failed; check on this..."

mkdir bams/ \
    && cd bams/ \
        || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


path_UMI_UT="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI"
)"
echo "${path_UMI_UT}"

path_pos_UT="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-pos"
)"
echo "${path_pos_UT}"

path_no_UT="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary"
)"
echo "${path_no_UT}"

path_UMI_UTK="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-UMI"
)"
echo "${path_UMI_UTK}"

path_pos_UTK="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-pos"
)"
echo "${path_pos_UTK}"

path_no_UTK="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary"
)"
echo "${path_no_UTK}"

ln -s "${path_UMI_UT}" "aligned_UT_primary_dedup-UMI"
ln -s "${path_pos_UT}" "aligned_UT_primary_dedup-pos"
ln -s "${path_no_UT}" "aligned_UT_primary"
ln -s "${path_UMI_UTK}" "aligned_UTK_primary_dedup-UMI"
ln -s "${path_pos_UTK}" "aligned_UTK_primary_dedup-pos"
ln -s "${path_no_UTK}" "aligned_UTK_primary"
```
</details>
<br />

<a id="use-symlinks-to-give-the-datasets-intuitive-names"></a>
### Use symlinks to give the datasets intuitive names
<a id="get-situated-make-necessary-directories"></a>
#### Get situated, make necessary directories
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Get situated, make necessary directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get to and make appropriate directories ------------------------------------
transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

mkdir -p bams_renamed/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}
```
</details>
<br />

<a id="determine-the-relative-paths"></a>
#### Determine the relative paths
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Determine the relative paths</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


#  UTK
cd bams_renamed/UTK_prim_no/
UTK_prim_no="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UTK_primary"
)"
echo "${UTK_prim_no}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary

cd ../UTK_prim_pos/
UTK_prim_pos="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UTK_primary_dedup-pos"
)"
echo "${UTK_prim_pos}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-pos

cd ../UTK_prim_UMI/
UTK_prim_UMI="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UTK_primary_dedup-UMI"
)"
echo "${UTK_prim_UMI}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-UMI

#  UT
cd ../UT_prim_no/
UT_prim_no="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary"
)"
echo "${UT_prim_no}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary

cd ../UT_prim_pos/
UT_prim_pos="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary_dedup-pos"
)"
echo "${UT_prim_pos}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-pos

cd ../UT_prim_UMI/
UT_prim_UMI="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary_dedup-UMI"
)"
echo "${UT_prim_UMI}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI
```
</details>
<br />

<a id="set-up-associative-arrays-to-be-used-in-the-symlinking"></a>
#### Set up associative arrays (to be used in the symlinking)
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: Set up associative arrays (to be used in the symlinking)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  UTK
unset array_UTK_prim_no
typeset -A array_UTK_prim_no
array_UTK_prim_no["${UTK_prim_no}/5781_G1_IN_UTK.primary.bam"]="WT_G1_day1_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5781_G1_IP_UTK.primary.bam"]="WT_G1_day1_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5781_Q_IN_UTK.primary.bam"]="WT_Q_day7_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5781_Q_IP_UTK.primary.bam"]="WT_Q_day7_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_G1_IN_UTK.primary.bam"]="WT_G1_day1_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_G1_IP_UTK.primary.bam"]="WT_G1_day1_N_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_Q_IN_UTK.primary.bam"]="WT_Q_day7_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_Q_IP_UTK.primary.bam"]="WT_Q_day7_N_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM10_DSp48_5781_UTK.primary.bam"]="WT_DSp48_day4_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM11_DSp48_7080_UTK.primary.bam"]="t4-n_DSp48_day4_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM1_DSm2_5781_UTK.primary.bam"]="WT_DSm2_day2_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM2_DSm2_7080_UTK.primary.bam"]="t4-n_DSm2_day2_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM3_DSm2_7079_UTK.primary.bam"]="r6-n_DSm2_day2_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM4_DSp2_5781_UTK.primary.bam"]="WT_DSp2_day2_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM5_DSp2_7080_UTK.primary.bam"]="t4-n_DSp2_day2_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM6_DSp2_7079_UTK.primary.bam"]="r6-n_DSp2_day2_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM7_DSp24_5781_UTK.primary.bam"]="WT_DSp24_day3_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM8_DSp24_7080_UTK.primary.bam"]="t4-n_DSp24_day3_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM9_DSp24_7079_UTK.primary.bam"]="r6-n_DSp24_day3_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp10_DSp48_5782_UTK.primary.bam"]="WT_DSp48_day4_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp11_DSp48_7081_UTK.primary.bam"]="t4-n_DSp48_day4_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp12_DSp48_7078_UTK.primary.bam"]="r6-n_DSp48_day4_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp1_DSm2_5782_UTK.primary.bam"]="WT_DSm2_day2_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp2_DSm2_7081_UTK.primary.bam"]="t4-n_DSm2_day2_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp3_DSm2_7078_UTK.primary.bam"]="r6-n_DSm2_day2_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp4_DSp2_5782_UTK.primary.bam"]="WT_DSp2_day2_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp5_DSp2_7081_UTK.primary.bam"]="t4-n_DSp2_day2_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp6_DSp2_7078_UTK.primary.bam"]="r6-n_DSp2_day2_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp7_DSp24_5782_UTK.primary.bam"]="WT_DSp24_day3_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp8_DSp24_7081_UTK.primary.bam"]="t4-n_DSp24_day3_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp9_DSp24_7078_UTK.primary.bam"]="r6-n_DSp24_day3_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT10_7718_pIAA_Q_Nascent_UTK.primary.bam"]="n3-d_Q_day7_N_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT10_7718_pIAA_Q_SteadyState_UTK.primary.bam"]="n3-d_Q_day7_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT2_6125_pIAA_Q_Nascent_UTK.primary.bam"]="o-d_Q_day7_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT2_6125_pIAA_Q_SteadyState_UTK.primary.bam"]="o-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT4_6126_pIAA_Q_Nascent_UTK.primary.bam"]="o-d_Q_day7_N_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT4_6126_pIAA_Q_SteadyState_UTK.primary.bam"]="o-d_Q_day7_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT6_7714_pIAA_Q_Nascent_UTK.primary.bam"]="n3-d_Q_day7_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT6_7714_pIAA_Q_SteadyState_UTK.primary.bam"]="n3-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT8_7716_pIAA_Q_Nascent_UTK.primary.bam"]="n3-d_Q_day7_N_rep3.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT8_7716_pIAA_Q_SteadyState_UTK.primary.bam"]="n3-d_Q_day7_SS_rep3.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CU11_5782_Q_Nascent_UTK.primary.bam"]="WT_Q_day7_N_rep2_CU.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CU12_5782_Q_SteadyState_UTK.primary.bam"]="WT_Q_day7_SS_rep2_CU.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW10_7747_8day_Q_IN_UTK.primary.bam"]="r1-n_Q_day8_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW10_7747_8day_Q_PD_UTK.primary.bam"]="r1-n_Q_day8_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW12_7748_8day_Q_IN_UTK.primary.bam"]="r1-n_Q_day8_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW12_7748_8day_Q_PD_UTK.primary.bam"]="r1-n_Q_day8_N_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW2_5781_8day_Q_IN_UTK.primary.bam"]="WT_Q_day8_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW2_5781_8day_Q_PD_UTK.primary.bam"]="WT_Q_day8_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW4_5782_8day_Q_IN_UTK.primary.bam"]="WT_Q_day8_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW4_5782_8day_Q_PD_UTK.primary.bam"]="WT_Q_day8_N_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW6_7078_8day_Q_IN_UTK.primary.bam"]="r6-n_Q_day8_SS_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW6_7078_8day_Q_PD_UTK.primary.bam"]="r6-n_Q_day8_N_rep1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW8_7079_8day_Q_IN_UTK.primary.bam"]="r6-n_Q_day8_SS_rep2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW8_7079_8day_Q_PD_UTK.primary.bam"]="r6-n_Q_day8_N_rep2.UTK_prim.bam"

unset array_UTK_prim_pos
typeset -A array_UTK_prim_pos
array_UTK_prim_pos["${UTK_prim_pos}/5781_G1_IN_UTK.primary.dedup-pos.bam"]="WT_G1_day1_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5781_G1_IP_UTK.primary.dedup-pos.bam"]="WT_G1_day1_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5781_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day7_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5781_Q_IP_UTK.primary.dedup-pos.bam"]="WT_Q_day7_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_G1_IN_UTK.primary.dedup-pos.bam"]="WT_G1_day1_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_G1_IP_UTK.primary.dedup-pos.bam"]="WT_G1_day1_N_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day7_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_Q_IP_UTK.primary.dedup-pos.bam"]="WT_Q_day7_N_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM10_DSp48_5781_UTK.primary.dedup-pos.bam"]="WT_DSp48_day4_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM11_DSp48_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSp48_day4_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM1_DSm2_5781_UTK.primary.dedup-pos.bam"]="WT_DSm2_day2_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM2_DSm2_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSm2_day2_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM3_DSm2_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSm2_day2_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM4_DSp2_5781_UTK.primary.dedup-pos.bam"]="WT_DSp2_day2_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM5_DSp2_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSp2_day2_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM6_DSp2_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSp2_day2_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM7_DSp24_5781_UTK.primary.dedup-pos.bam"]="WT_DSp24_day3_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM8_DSp24_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSp24_day3_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM9_DSp24_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSp24_day3_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp10_DSp48_5782_UTK.primary.dedup-pos.bam"]="WT_DSp48_day4_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp11_DSp48_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSp48_day4_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp12_DSp48_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSp48_day4_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp1_DSm2_5782_UTK.primary.dedup-pos.bam"]="WT_DSm2_day2_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp2_DSm2_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSm2_day2_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp3_DSm2_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSm2_day2_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp4_DSp2_5782_UTK.primary.dedup-pos.bam"]="WT_DSp2_day2_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp5_DSp2_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSp2_day2_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp6_DSp2_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSp2_day2_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp7_DSp24_5782_UTK.primary.dedup-pos.bam"]="WT_DSp24_day3_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp8_DSp24_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSp24_day3_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp9_DSp24_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSp24_day3_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_N_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_N_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_N_rep3.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_SS_rep3.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CU11_5782_Q_Nascent_UTK.primary.dedup-pos.bam"]="WT_Q_day7_N_rep2_CU.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CU12_5782_Q_SteadyState_UTK.primary.dedup-pos.bam"]="WT_Q_day7_SS_rep2_CU.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW10_7747_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW10_7747_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW12_7748_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW12_7748_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_N_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW2_5781_8day_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day8_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW2_5781_8day_Q_PD_UTK.primary.dedup-pos.bam"]="WT_Q_day8_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW4_5782_8day_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day8_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW4_5782_8day_Q_PD_UTK.primary.dedup-pos.bam"]="WT_Q_day8_N_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW6_7078_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_SS_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW6_7078_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_N_rep1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW8_7079_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_SS_rep2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW8_7079_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_N_rep2.UTK_prim_pos.bam"

unset array_UTK_prim_UMI
typeset -A array_UTK_prim_UMI
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_G1_IN_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_G1_IP_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_Q_IP_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_G1_IN_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_G1_IP_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_N_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_Q_IP_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_N_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM10_DSp48_5781_UTK.primary.dedup-UMI.bam"]="WT_DSp48_day4_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM11_DSp48_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM1_DSm2_5781_UTK.primary.dedup-UMI.bam"]="WT_DSm2_day2_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM2_DSm2_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM3_DSm2_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM4_DSp2_5781_UTK.primary.dedup-UMI.bam"]="WT_DSp2_day2_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM5_DSp2_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM6_DSp2_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM7_DSp24_5781_UTK.primary.dedup-UMI.bam"]="WT_DSp24_day3_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM8_DSp24_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM9_DSp24_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp10_DSp48_5782_UTK.primary.dedup-UMI.bam"]="WT_DSp48_day4_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp11_DSp48_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp12_DSp48_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSp48_day4_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp1_DSm2_5782_UTK.primary.dedup-UMI.bam"]="WT_DSm2_day2_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp2_DSm2_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp3_DSm2_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp4_DSp2_5782_UTK.primary.dedup-UMI.bam"]="WT_DSp2_day2_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp5_DSp2_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp6_DSp2_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp7_DSp24_5782_UTK.primary.dedup-UMI.bam"]="WT_DSp24_day3_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp8_DSp24_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp9_DSp24_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_N_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_N_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_N_rep3.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_SS_rep3.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_N_rep2_CU.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_SS_rep2_CU.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_N_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_N_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_SS_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_N_rep1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_SS_rep2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_N_rep2.UTK_prim_UMI.bam"

#  UT
unset array_UT_prim_no
typeset -A array_UT_prim_no
array_UT_prim_no["${UT_prim_no}/5781_G1_IN_UT.primary.bam"]="WT_G1_day1_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5781_G1_IP_UT.primary.bam"]="WT_G1_day1_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5781_Q_IN_UT.primary.bam"]="WT_Q_day7_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5781_Q_IP_UT.primary.bam"]="WT_Q_day7_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_G1_IN_UT.primary.bam"]="WT_G1_day1_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_G1_IP_UT.primary.bam"]="WT_G1_day1_N_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_Q_IN_UT.primary.bam"]="WT_Q_day7_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_Q_IP_UT.primary.bam"]="WT_Q_day7_N_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM10_DSp48_5781_UT.primary.bam"]="WT_DSp48_day4_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM11_DSp48_7080_UT.primary.bam"]="t4-n_DSp48_day4_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM1_DSm2_5781_UT.primary.bam"]="WT_DSm2_day2_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM2_DSm2_7080_UT.primary.bam"]="t4-n_DSm2_day2_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM3_DSm2_7079_UT.primary.bam"]="r6-n_DSm2_day2_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM4_DSp2_5781_UT.primary.bam"]="WT_DSp2_day2_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM5_DSp2_7080_UT.primary.bam"]="t4-n_DSp2_day2_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM6_DSp2_7079_UT.primary.bam"]="r6-n_DSp2_day2_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM7_DSp24_5781_UT.primary.bam"]="WT_DSp24_day3_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM8_DSp24_7080_UT.primary.bam"]="t4-n_DSp24_day3_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM9_DSp24_7079_UT.primary.bam"]="r6-n_DSp24_day3_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp10_DSp48_5782_UT.primary.bam"]="WT_DSp48_day4_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp11_DSp48_7081_UT.primary.bam"]="t4-n_DSp48_day4_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp12_DSp48_7078_UT.primary.bam"]="r6-n_DSp48_day4_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp1_DSm2_5782_UT.primary.bam"]="WT_DSm2_day2_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp2_DSm2_7081_UT.primary.bam"]="t4-n_DSm2_day2_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp3_DSm2_7078_UT.primary.bam"]="r6-n_DSm2_day2_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp4_DSp2_5782_UT.primary.bam"]="WT_DSp2_day2_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp5_DSp2_7081_UT.primary.bam"]="t4-n_DSp2_day2_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp6_DSp2_7078_UT.primary.bam"]="r6-n_DSp2_day2_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp7_DSp24_5782_UT.primary.bam"]="WT_DSp24_day3_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp8_DSp24_7081_UT.primary.bam"]="t4-n_DSp24_day3_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp9_DSp24_7078_UT.primary.bam"]="r6-n_DSp24_day3_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT10_7718_pIAA_Q_Nascent_UT.primary.bam"]="n3-d_Q_day7_N_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT10_7718_pIAA_Q_SteadyState_UT.primary.bam"]="n3-d_Q_day7_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT2_6125_pIAA_Q_Nascent_UT.primary.bam"]="o-d_Q_day7_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT2_6125_pIAA_Q_SteadyState_UT.primary.bam"]="o-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT4_6126_pIAA_Q_Nascent_UT.primary.bam"]="o-d_Q_day7_N_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT4_6126_pIAA_Q_SteadyState_UT.primary.bam"]="o-d_Q_day7_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT6_7714_pIAA_Q_Nascent_UT.primary.bam"]="n3-d_Q_day7_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT6_7714_pIAA_Q_SteadyState_UT.primary.bam"]="n3-d_Q_day7_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT8_7716_pIAA_Q_Nascent_UT.primary.bam"]="n3-d_Q_day7_N_rep3.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT8_7716_pIAA_Q_SteadyState_UT.primary.bam"]="n3-d_Q_day7_SS_rep3.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CU11_5782_Q_Nascent_UT.primary.bam"]="WT_Q_day7_N_rep2_CU.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CU12_5782_Q_SteadyState_UT.primary.bam"]="WT_Q_day7_SS_rep2_CU.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW10_7747_8day_Q_IN_UT.primary.bam"]="r1-n_Q_day8_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW10_7747_8day_Q_PD_UT.primary.bam"]="r1-n_Q_day8_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW12_7748_8day_Q_IN_UT.primary.bam"]="r1-n_Q_day8_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW12_7748_8day_Q_PD_UT.primary.bam"]="r1-n_Q_day8_N_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW2_5781_8day_Q_IN_UT.primary.bam"]="WT_Q_day8_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW2_5781_8day_Q_PD_UT.primary.bam"]="WT_Q_day8_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW4_5782_8day_Q_IN_UT.primary.bam"]="WT_Q_day8_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW4_5782_8day_Q_PD_UT.primary.bam"]="WT_Q_day8_N_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW6_7078_8day_Q_IN_UT.primary.bam"]="r6-n_Q_day8_SS_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW6_7078_8day_Q_PD_UT.primary.bam"]="r6-n_Q_day8_N_rep1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW8_7079_8day_Q_IN_UT.primary.bam"]="r6-n_Q_day8_SS_rep2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW8_7079_8day_Q_PD_UT.primary.bam"]="r6-n_Q_day8_N_rep2.UT_prim.bam"

unset array_UT_prim_pos
typeset -A array_UT_prim_pos
array_UT_prim_pos["${UT_prim_pos}/5781_G1_IN_UT.primary.dedup-pos.bam"]="WT_G1_day1_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5781_G1_IP_UT.primary.dedup-pos.bam"]="WT_G1_day1_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5781_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day7_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5781_Q_IP_UT.primary.dedup-pos.bam"]="WT_Q_day7_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_G1_IN_UT.primary.dedup-pos.bam"]="WT_G1_day1_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_G1_IP_UT.primary.dedup-pos.bam"]="WT_G1_day1_N_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day7_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_Q_IP_UT.primary.dedup-pos.bam"]="WT_Q_day7_N_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM10_DSp48_5781_UT.primary.dedup-pos.bam"]="WT_DSp48_day4_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM11_DSp48_7080_UT.primary.dedup-pos.bam"]="t4-n_DSp48_day4_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM1_DSm2_5781_UT.primary.dedup-pos.bam"]="WT_DSm2_day2_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM2_DSm2_7080_UT.primary.dedup-pos.bam"]="t4-n_DSm2_day2_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM3_DSm2_7079_UT.primary.dedup-pos.bam"]="r6-n_DSm2_day2_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM4_DSp2_5781_UT.primary.dedup-pos.bam"]="WT_DSp2_day2_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM5_DSp2_7080_UT.primary.dedup-pos.bam"]="t4-n_DSp2_day2_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM6_DSp2_7079_UT.primary.dedup-pos.bam"]="r6-n_DSp2_day2_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM7_DSp24_5781_UT.primary.dedup-pos.bam"]="WT_DSp24_day3_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM8_DSp24_7080_UT.primary.dedup-pos.bam"]="t4-n_DSp24_day3_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM9_DSp24_7079_UT.primary.dedup-pos.bam"]="r6-n_DSp24_day3_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp10_DSp48_5782_UT.primary.dedup-pos.bam"]="WT_DSp48_day4_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp11_DSp48_7081_UT.primary.dedup-pos.bam"]="t4-n_DSp48_day4_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp12_DSp48_7078_UT.primary.dedup-pos.bam"]="r6-n_DSp48_day4_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp1_DSm2_5782_UT.primary.dedup-pos.bam"]="WT_DSm2_day2_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp2_DSm2_7081_UT.primary.dedup-pos.bam"]="t4-n_DSm2_day2_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp3_DSm2_7078_UT.primary.dedup-pos.bam"]="r6-n_DSm2_day2_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp4_DSp2_5782_UT.primary.dedup-pos.bam"]="WT_DSp2_day2_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp5_DSp2_7081_UT.primary.dedup-pos.bam"]="t4-n_DSp2_day2_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp6_DSp2_7078_UT.primary.dedup-pos.bam"]="r6-n_DSp2_day2_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp7_DSp24_5782_UT.primary.dedup-pos.bam"]="WT_DSp24_day3_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp8_DSp24_7081_UT.primary.dedup-pos.bam"]="t4-n_DSp24_day3_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp9_DSp24_7078_UT.primary.dedup-pos.bam"]="r6-n_DSp24_day3_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_N_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="o-d_Q_day7_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="o-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UT_prim_pos["${UT_prim_pos}/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="o-d_Q_day7_N_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="o-d_Q_day7_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_N_rep3.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_SS_rep3.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CU11_5782_Q_Nascent_UT.primary.dedup-pos.bam"]="WT_Q_day7_N_rep2_CU.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CU12_5782_Q_SteadyState_UT.primary.dedup-pos.bam"]="WT_Q_day7_SS_rep2_CU.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW10_7747_8day_Q_IN_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW10_7747_8day_Q_PD_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW12_7748_8day_Q_IN_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW12_7748_8day_Q_PD_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_N_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW2_5781_8day_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day8_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW2_5781_8day_Q_PD_UT.primary.dedup-pos.bam"]="WT_Q_day8_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW4_5782_8day_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day8_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW4_5782_8day_Q_PD_UT.primary.dedup-pos.bam"]="WT_Q_day8_N_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW6_7078_8day_Q_IN_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_SS_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW6_7078_8day_Q_PD_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_N_rep1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW8_7079_8day_Q_IN_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_SS_rep2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW8_7079_8day_Q_PD_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_N_rep2.UT_prim_pos.bam"

unset array_UT_prim_UMI
typeset -A array_UT_prim_UMI
array_UT_prim_UMI["${UT_prim_UMI}/5781_G1_IN_UT.primary.dedup-UMI.bam"]="WT_G1_day1_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5781_G1_IP_UT.primary.dedup-UMI.bam"]="WT_G1_day1_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5781_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day7_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5781_Q_IP_UT.primary.dedup-UMI.bam"]="WT_Q_day7_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_G1_IN_UT.primary.dedup-UMI.bam"]="WT_G1_day1_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_G1_IP_UT.primary.dedup-UMI.bam"]="WT_G1_day1_N_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day7_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_Q_IP_UT.primary.dedup-UMI.bam"]="WT_Q_day7_N_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM10_DSp48_5781_UT.primary.dedup-UMI.bam"]="WT_DSp48_day4_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM11_DSp48_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM1_DSm2_5781_UT.primary.dedup-UMI.bam"]="WT_DSm2_day2_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM2_DSm2_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM3_DSm2_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM4_DSp2_5781_UT.primary.dedup-UMI.bam"]="WT_DSp2_day2_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM5_DSp2_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM6_DSp2_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM7_DSp24_5781_UT.primary.dedup-UMI.bam"]="WT_DSp24_day3_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM8_DSp24_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM9_DSp24_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp10_DSp48_5782_UT.primary.dedup-UMI.bam"]="WT_DSp48_day4_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp11_DSp48_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp12_DSp48_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSp48_day4_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp1_DSm2_5782_UT.primary.dedup-UMI.bam"]="WT_DSm2_day2_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp2_DSm2_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp3_DSm2_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp4_DSp2_5782_UT.primary.dedup-UMI.bam"]="WT_DSp2_day2_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp5_DSp2_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp6_DSp2_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp7_DSp24_5782_UT.primary.dedup-UMI.bam"]="WT_DSp24_day3_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp8_DSp24_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp9_DSp24_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_N_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_SS_rep1.UTK_prim.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_N_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_N_rep3.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_SS_rep3.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.bam"]="WT_Q_day7_N_rep2_CU.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.bam"]="WT_Q_day7_SS_rep2_CU.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_N_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day8_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.bam"]="WT_Q_day8_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day8_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.bam"]="WT_Q_day8_N_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_SS_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_N_rep1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_SS_rep2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_N_rep2.UT_prim_UMI.bam"
```
</details>
<br />

<a id="perform-the-symlinking"></a>
#### Perform the symlinking
<a id="code-7"></a>
##### Code
<details>
<summary><i>Code: Perform the symlinking</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215/bams_renamed/" \
            || echo "cd'ing failed; check on this..."
    }

cd UTK_prim_no/
for i in "${!array_UTK_prim_no[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UTK_prim_no["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UTK_prim_no["${i}"]}"
done

cd ../UTK_prim_pos/
for i in "${!array_UTK_prim_pos[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UTK_prim_pos["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UTK_prim_pos["${i}"]}"
done

cd ../UTK_prim_UMI/
for i in "${!array_UTK_prim_UMI[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UTK_prim_UMI["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UTK_prim_UMI["${i}"]}"
done

cd ../UT_prim_no/
for i in "${!array_UT_prim_no[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UT_prim_no["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UT_prim_no["${i}"]}"
done

cd ../UT_prim_pos/
for i in "${!array_UT_prim_pos[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UT_prim_pos["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UT_prim_pos["${i}"]}"
done

cd ../UT_prim_UMI/
for i in "${!array_UT_prim_UMI[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UT_prim_UMI["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UT_prim_UMI["${i}"]}"
done
```
</details>
<br />
<br />

<a id="run-featurecounts"></a>
## Run featureCounts
<a id="test-to-determine-option-for-featurecounts--s-results-in-an-error"></a>
### Test to determine option for featureCounts -s (results in an error)
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s (results in an error)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

mkdir outfiles_featureCounts/test_fC-s

#  Check for forward-strandedness (1)
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

# featureCounts --help

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Test to determine option for featureCounts -s (results in an error)</i></summary>

```txt
❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
      v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-1                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-1.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3 (GTF)                        ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3 ...                               ||

ERROR: failed to find the gene identifier attribute in the 9th column of the provided GTF file.
The specified gene identifier attribute is 'gene_id'
An example of attributes included in your GTF annotation is 'ID=YML133C_mRNA-E2;Parent=transcript:YML133C_mRNA;Name=YML133C_mRNA-E2;constitutive=1;ensembl_end_phase=0;ensembl_phase=2;exon_id=YML133C_mRNA-E2;rank=2'.
```
</details>
<br />

<a id="convert-the-gff3-to-saf-format"></a>
### Convert the gff3 to "SAF" format
*Building on advice [here](https://www.biostars.org/p/432735/#9482784)*

<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: Convert the gff3 to "SAF" format</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/genomes/combined_SC_KL_20S/gff3" \
    || echo "cd'ing failed; check on this..."
gff3="combined_SC_KL.gff3"

if [[ -f "${gff3}.saf" ]]; then
    rm "${gff3}.saf"
fi
grep 'gene' "${gff3}" \
    | cut -d ';' -f1 \
    | tr -d ' ' \
    | sed 's/ID=//g'\
    | awk -v OFS='\t' '{ print $9,$1,$4,$5,$7 }' \
    | tail -n +3 \
        > "${gff3}.saf"

head "${gff3}.saf"
tail "${gff3}.saf"
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: Convert the gff3 to "SAF" format</i></summary>

```txt
❯ head "${gff3}.saf"
gene:YML133C    XIII    461    4684    -
transcript:YML133C_mRNA    XIII    461    4684    -
gene:YML133W-B    XIII    827    1309    +
transcript:YML133W-B_mRNA    XIII    827    1309    +
gene:YML133W-A    XIII    1610    2185    +
transcript:YML133W-A_mRNA    XIII    1610    2185    +
gene:YML132W    XIII    7244    8383    +
transcript:YML132W_mRNA    XIII    7244    8383    +
gene:YML131W    XIII    10198    11295    +
transcript:YML131W_mRNA    XIII    10198    11295    +

❯ tail "${gff3}.saf"
transcript:YFR052C-A_mRNA    VI    253429    253734    -
transcript:YFR053C_mRNA    VI    253592    255049    -
gene:YFR054C    VI    258855    259433    -
transcript:YFR054C_mRNA    VI    258855    259433    -
gene:YFR056C    VI    263957    264325    -
transcript:YFR056C_mRNA    VI    263957    264325    -
gene:YFR055W    VI    264204    265226    +
transcript:YFR055W_mRNA    VI    264204    265226    +
gene:YFR057W    VI    269061    269516    +
transcript:YFR057W_mRNA    VI    269061    269516    +
```
</details>
<br />

<a id="test-to-determine-option-for-featurecounts--s-using-the-saf-file"></a>
### Test to determine option for featureCounts -s using the .saf file
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s using the .saf file</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

#  Check for forward-strandedness (1)
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3.saf"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "SAF" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)


#  Check for reverse-strandedness (2)
threads="${SLURM_CPUS_ON_NODE}"
strand=2
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3.saf"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "SAF" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  Seems like -s 1 is the way to go; however, only 2% of alignments are
#+ assigned; there must be a problem with the gff3 or how I am parsing it
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: Test to determine option for featureCounts -s using the .saf file</i></summary>

```txt
❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "SAF" \
>     -o "${outfile}"
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
      v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-1                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-1.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3.saf (SAF)                    ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3.saf ...                           ||
||    Features : 24888                                                        ||
||    Meta-features : 24888                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : stranded                                              ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 493111 (2.1%)                        ||
||    Running time : 0.11 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-1.summary"                                        ||
||                                                                            ||
\\============================================================================//

❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "SAF" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
	  v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-2                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-2.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3.saf (SAF)                    ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3.saf ...                           ||
||    Features : 24888                                                        ||
||    Meta-features : 24888                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : reversely stranded                                    ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 357 (0.0%)                           ||
||    Running time : 0.03 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-2.summary"                                        ||
||                                                                            ||
\\============================================================================//
```
</details>
<br />

<a id="test-to-determine-option-for-featurecounts--s-with--g-id-correct"></a>
### Test to determine option for featureCounts -s with -g "ID" (`#CORRECT`)
- `featureCounts -s 1` with `-g "ID"` is the way to go
- Go back to using the gff3 rather than the saf

<a id="code-11"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s with -g "ID" (#CORRECT)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Check for forward-strandedness (1)
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)


#  Check for reverse-strandedness (2)
threads="${SLURM_CPUS_ON_NODE}"
strand=2
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: Test to determine option for featureCounts -s with -g "ID" (#CORRECT)</i></summary>

```txt
❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "GTF" \
>     -g "ID" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
	  v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-1                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-1.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3 (GTF)                        ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3 ...                               ||
||    Features : 13166                                                        ||
||    Meta-features : 13166                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : stranded                                              ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 14202700 (60.3%)                     ||
||    Running time : 0.03 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-1.summary"                                        ||
||                                                                            ||
\\============================================================================//

❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "GTF" \
>     -g "ID" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
	  v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-2                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-2.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3 (GTF)                        ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3 ...                               ||
||    Features : 13166                                                        ||
||    Meta-features : 13166                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : reversely stranded                                    ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 650463 (2.8%)                        ||
||    Running time : 0.03 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-2.summary"                                        ||
||                                                                            ||
\\============================================================================//
```
</details>
<br />

<a id="clean-up"></a>
### Clean up
<a id="code-12"></a>
#### Code
<details>
<summary><i>Code: Clean up</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/genomes/combined_SC_KL_20S/gff3" \
    || echo "cd'ing failed; check on this..."

rm *.saf

cd - \
    || echo "cd'ing failed; check on this..."
```
</details>
<br />
<br />

<a id="run-featurecounts-on-bams-in-bams-with-combined_sc_klgff3"></a>
## Run featureCounts on bams in bams/ with combined_SC_KL.gff3
- bams/aligned_UT_primary_dedup-UMI
- bams/aligned_UT_primary

<a id="code-13"></a>
### Code
<details>
<summary><i>Code: Run featureCounts on bams in bams/ with combined_SC_KL.gff3</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

#  Forward-stranded (FR) data: -s 1
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
indir="bams/aligned_UT_primary_dedup-UMI"
outfile="outfiles_featureCounts/aligned_UT_primary_dedup-UMI.featureCounts"

# ., "${indir}/"*".bam"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${indir}/"*".bam" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
indir="bams/aligned_UT_primary"
outfile="outfiles_featureCounts/aligned_UT_primary.featureCounts"

# ., "${indir}/"*".bam"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${indir}/"*".bam" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)
```
</details>
<br />
