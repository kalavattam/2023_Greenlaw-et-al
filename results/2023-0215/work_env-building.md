
`work_env-building.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Make additions to `Trinity_env`](#make-additions-to-trinity_env)
    1. [Get situated, make directory for `featureCounts` work, etc.](#get-situated-make-directory-for-featurecounts-work-etc)
        1. [Code](#code)
    1. [Install featureCounts in `Trinity_env`](#install-featurecounts-in-trinity_env)
        1. [Code](#code-1)
        1. [Printed](#printed)
1. [Create a new environment, `expression_env`](#create-a-new-environment-expression_env)
    1. [Create the environment on KrisMac](#create-the-environment-on-krismac)
        1. [Code](#code-2)
        1. [Printed](#printed-1)
    1. [Create the environment on WorkMac](#create-the-environment-on-workmac)
        1. [Code](#code-3)
        1. [Printed](#printed-2)
    1. [Add appropriate shortcut to `.zaliases` and `.bash_aliases`](#add-appropriate-shortcut-to-zaliases-and-bash_aliases)
        1. [Code](#code-4)
1. [Create an environment for gff3 processing, `gff3_env`](#create-an-environment-for-gff3-processing-gff3_env)
    1. [Get situated](#get-situated)
        1. [Code](#code-5)
    1. [Set up `gff3_env`](#set-up-gff3_env)
        1. [Code](#code-6)
        1. [Printed](#printed-3)
    1. [Add appropriate shortcut to `.zaliases` and `.bash_aliases`](#add-appropriate-shortcut-to-zaliases-and-bash_aliases-1)
        1. [Code](#code-7)
1. [Create an environment for running `Python` with `spyder`](#create-an-environment-for-running-python-with-spyder)
    1. [Code](#code-8)
    1. [Printed](#printed-4)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

`#TODO` Make sure this doc is at parity with the doc in `2023_expression`  
~~`#DONE` Add in the creation of the `htseq_env` and/or `gff3_env`~~  
`#TODO` Move section on additions to `Trinity_env` to the main notebook for building `Trinity_env` (elsewhere in repo)  
<br />
<br />

<a id="make-additions-to-trinity_env"></a>
## Make additions to `Trinity_env`
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
### Install featureCounts in `Trinity_env`
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
<br />

<a id="create-a-new-environment-expression_env"></a>
## Create a new environment, `expression_env`
*Contains programs for 4tU-seq analyses*

<a id="create-the-environment-on-krismac"></a>
### Create the environment on KrisMac
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Create a new environment, expression_env: Create the environment on KrisMac</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi

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
<summary><i>Printed: Create a new environment for normalization work, install programs, etc.: Create the environment on KrisMac</i></summary>

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

<a id="create-the-environment-on-workmac"></a>
### Create the environment on WorkMac
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Create a new environment, expression_env: Create the environment on WorkMac</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

create_x86_conda_environment \
    expression_env \
    -c conda-forge \
        r-base \
        r-tidyverse \
        mamba
#  create_x86_conda_environment:
#+ Create a conda environment using x86 architecture
#+
#+ The first argument is environment name; all subsequent arguments will be
#+ passed to `conda create`
#+
#+ example usage: create_x86_conda_environment myenv_x86 python=3.9

source activate expression_env

mamba install -c bioconda bioconductor-deseq2

mamba install -c bioconda subread

mamba install \
    -c bioconda \
        bioconductor-enhancedvolcano bioconductor-pcatools

mamba install -c conda-forge r-markdown  # Needed by RStudio on WorkMac...

mamba install -c conda-forge r-roxygen2  #TODO Copy in installation text...

mamba install -c bioconda bioconductor-sva

mamba install -c conda-forge r-ggalt

mamba install -c conda-forge r-rjson

mamba install -c bioconda bioconductor-rtracklayer
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Create a new environment for normalization work, install programs, etc.: Create the environment on WorkMac</i></summary>

```txt
❯ create_x86_conda_environment \
>     expression_env \
>     -c conda-forge \
>         r-base \
>         r-tidyverse \
>         mamba
Collecting package metadata (current_repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
  current version: 22.9.0
  latest version: 23.1.0

Please update conda by running

    $ conda update -n base -c conda-forge conda



## Package Plan ##

  environment location: /Users/kalavatt/mambaforge/envs/expression_env

  added / updated specs:
    - mamba
    - r-base
    - r-tidyverse


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    brotlipy-0.7.0             |py311h5547dcb_1005         370 KB  conda-forge
    cffi-1.15.1                |  py311ha86e640_3         274 KB  conda-forge
    compiler-rt_osx-64-14.0.6  |       h8d5cb93_0         3.4 MB
    conda-23.1.0               |  py311h6eed73b_0         1.2 MB  conda-forge
    conda-package-handling-2.0.2|     pyh38be061_0         247 KB  conda-forge
    conda-package-streaming-0.7.0|     pyhd8ed1ab_1          17 KB  conda-forge
    cryptography-39.0.1        |  py311h61927ef_0         1.1 MB  conda-forge
    curl-7.88.1                |       h6df9250_0         140 KB  conda-forge
    fmt-9.1.0                  |       hb8565cd_0         179 KB  conda-forge
    fontconfig-2.14.2          |       h5bb23bf_0         232 KB  conda-forge
    gfortran_impl_osx-64-11.3.0|      h1f927f5_28        17.5 MB  conda-forge
    jpeg-9e                    |       hb7f2c08_3         226 KB  conda-forge
    libarchive-3.6.2           |       h6d8d9f1_0         706 KB  conda-forge
    libcurl-7.88.1             |       h6df9250_0         335 KB  conda-forge
    libcxx-15.0.7              |       h71dddab_0         1.1 MB  conda-forge
    libdeflate-1.17            |       hac1461d_0          66 KB  conda-forge
    libgfortran-5.0.0          |10_4_0_h97931a8_28         144 KB  conda-forge
    libgfortran-devel_osx-64-11.3.0|      h824d247_28         418 KB  conda-forge
    libgfortran5-11.3.0        |      h082f757_28         1.4 MB  conda-forge
    libmamba-1.3.1             |       h9d281b0_1         1.2 MB  conda-forge
    libmambapy-1.3.1           |  py311hcc19a12_1         231 KB  conda-forge
    libsolv-0.7.23             |       hbc0c0cd_0         402 KB  conda-forge
    libtiff-4.5.0              |       hee9004a_2         383 KB  conda-forge
    llvm-openmp-15.0.7         |       h61d9ccf_0         287 KB  conda-forge
    lz4-c-1.9.4                |       hf0c8a7f_0         153 KB  conda-forge
    lzo-2.10                   |    haf1e3a3_1000         190 KB  conda-forge
    mamba-1.3.1                |  py311h8082e30_1          63 KB  conda-forge
    mpc-1.3.1                  |       h81bd1dd_0         107 KB  conda-forge
    openssl-3.0.8              |       hfd90126_0         2.2 MB  conda-forge
    pango-1.50.13              |       hbd9bf65_0         407 KB  conda-forge
    pip-23.0.1                 |     pyhd8ed1ab_0         1.3 MB  conda-forge
    pluggy-1.0.0               |     pyhd8ed1ab_5          16 KB  conda-forge
    pycosat-0.6.4              |  py311h5547dcb_1         113 KB  conda-forge
    pyopenssl-23.0.0           |     pyhd8ed1ab_0         124 KB  conda-forge
    python-3.11.0              |he7542f4_1_cpython        14.7 MB  conda-forge
    python_abi-3.11            |          3_cp311           6 KB  conda-forge
    r-backports-1.4.1          |    r42h815d134_1         109 KB  conda-forge
    r-base-4.2.2               |       h841e2fe_3        23.3 MB  conda-forge
    r-broom-1.0.3              |    r42hc72bb7e_0         1.7 MB  conda-forge
    r-cachem-1.0.7             |    r42h815d134_0          72 KB  conda-forge
    r-callr-3.7.3              |    r42hc72bb7e_0         429 KB  conda-forge
    r-cellranger-1.1.0         | r42hc72bb7e_1005         110 KB  conda-forge
    r-cli-3.6.0                |    r42h49197e3_0         1.2 MB  conda-forge
    r-clipr-0.8.0              |    r42hc72bb7e_1          68 KB  conda-forge
    r-colorspace-2.1_0         |    r42h815d134_0         2.4 MB  conda-forge
    r-conflicted-1.2.0         |    r42h785f33e_0          62 KB  conda-forge
    r-data.table-1.14.8        |    r42h557251b_0         1.8 MB  conda-forge
    r-dbplyr-2.3.1             |    r42hc72bb7e_0         1.0 MB  conda-forge
    r-dplyr-1.1.0              |    r42h49197e3_0         1.3 MB  conda-forge
    r-dtplyr-1.3.0             |    r42hc72bb7e_0         348 KB  conda-forge
    r-farver-2.1.1             |    r42h49197e3_1         1.4 MB  conda-forge
    r-fastmap-1.1.1            |    r42h49197e3_0          69 KB  conda-forge
    r-forcats-1.0.0            |    r42hc72bb7e_0         414 KB  conda-forge
    r-fs-1.6.1                 |    r42h49197e3_0         269 KB  conda-forge
    r-gargle-1.3.0             |    r42h785f33e_0         519 KB  conda-forge
    r-ggplot2-3.4.1            |    r42hc72bb7e_0         3.9 MB  conda-forge
    r-googledrive-2.0.0        |    r42hc72bb7e_1         1.8 MB  conda-forge
    r-googlesheets4-1.0.1      |    r42h785f33e_1         498 KB  conda-forge
    r-gtable-0.3.1             |    r42hc72bb7e_1         174 KB  conda-forge
    r-haven-2.5.1              |    r42h49197e3_0         383 KB  conda-forge
    r-httr-1.4.5               |    r42hc72bb7e_0         477 KB  conda-forge
    r-ids-1.0.1                |    r42hc72bb7e_2         127 KB  conda-forge
    r-isoband-0.2.7            |    r42h49197e3_1         1.6 MB  conda-forge
    r-knitr-1.42               |    r42hc72bb7e_1         1.2 MB  conda-forge
    r-labeling-0.4.2           |    r42hc72bb7e_2          68 KB  conda-forge
    r-lubridate-1.9.2          |    r42h815d134_1         942 KB  conda-forge
    r-mass-7.3_58.2            |    r42h815d134_0         1.1 MB  conda-forge
    r-mgcv-1.8_41              |    r42h40f944a_0         3.2 MB  conda-forge
    r-modelr-0.1.10            |    r42hc72bb7e_0         220 KB  conda-forge
    r-munsell-0.5.0            | r42hc72bb7e_1005         248 KB  conda-forge
    r-nlme-3.1_162             |    r42h1e4e481_0         2.2 MB  conda-forge
    r-processx-3.8.0           |    r42h815d134_0         318 KB  conda-forge
    r-ps-1.7.2                 |    r42h815d134_0         315 KB  conda-forge
    r-ragg-1.2.5               |    r42hd0b13e6_0         386 KB  conda-forge
    r-rcpp-1.0.10              |    r42h49197e3_0         1.9 MB  conda-forge
    r-readr-2.1.4              |    r42h49197e3_0         724 KB  conda-forge
    r-readxl-1.4.2             |    r42h3ae43e4_0         712 KB  conda-forge
    r-rematch-1.0.1            | r42hc72bb7e_1005          20 KB  conda-forge
    r-rematch2-2.1.2           |    r42hc72bb7e_2          54 KB  conda-forge
    r-reprex-2.0.2             |    r42hc72bb7e_1         499 KB  conda-forge
    r-rstudioapi-0.14          |    r42hc72bb7e_1         301 KB  conda-forge
    r-rvest-1.0.3              |    r42hc72bb7e_1         216 KB  conda-forge
    r-sass-0.4.5               |    r42h49197e3_0         2.0 MB  conda-forge
    r-scales-1.2.1             |    r42hc72bb7e_1         612 KB  conda-forge
    r-selectr-0.4_2            |    r42hc72bb7e_2         463 KB  conda-forge
    r-stringi-1.7.12           |    r42h7183e51_0         836 KB  conda-forge
    r-systemfonts-1.0.4        |    r42h1372bf0_1         253 KB  conda-forge
    r-textshaping-0.3.6        |    r42h12cd53d_4          99 KB  conda-forge
    r-tidyr-1.3.0              |    r42h49197e3_0         1.1 MB  conda-forge
    r-tidyverse-2.0.0          |    r42h785f33e_0         415 KB  conda-forge
    r-timechange-0.2.0         |    r42h49197e3_0         177 KB  conda-forge
    r-tinytex-0.44             |    r42hc72bb7e_0         139 KB  conda-forge
    r-tzdb-0.3.0               |    r42h49197e3_1         531 KB  conda-forge
    r-utf8-1.2.3               |    r42h815d134_0         135 KB  conda-forge
    r-uuid-1.1_0               |    r42h815d134_1          50 KB  conda-forge
    r-vctrs-0.5.2              |    r42h49197e3_0         1.2 MB  conda-forge
    r-viridislite-0.4.1        |    r42hc72bb7e_1         1.3 MB  conda-forge
    r-vroom-1.6.1              |    r42h49197e3_0         781 KB  conda-forge
    r-xfun-0.37                |    r42h49197e3_0         393 KB  conda-forge
    r-yaml-2.3.7               |    r42h815d134_0         104 KB  conda-forge
    reproc-14.2.4              |       hb7f2c08_0          27 KB  conda-forge
    reproc-cpp-14.2.4          |       hf0c8a7f_0          19 KB  conda-forge
    requests-2.28.2            |     pyhd8ed1ab_0          55 KB  conda-forge
    ruamel.yaml-0.17.21        |  py311h5547dcb_2         248 KB  conda-forge
    ruamel.yaml.clib-0.2.7     |  py311h5547dcb_1         115 KB  conda-forge
    setuptools-67.4.0          |     pyhd8ed1ab_0         567 KB  conda-forge
    tzdata-2022g               |       h191b570_0         106 KB  conda-forge
    urllib3-1.26.14            |     pyhd8ed1ab_0         110 KB  conda-forge
    yaml-cpp-0.7.0             |       hf0c8a7f_2         139 KB  conda-forge
    zstandard-0.19.0           |  py311hebd4beb_1         405 KB  conda-forge
    zstd-1.5.2                 |       hbc0c0cd_6         399 KB  conda-forge
    ------------------------------------------------------------
                                           Total:       123.2 MB

The following NEW packages will be INSTALLED:

  _r-mutex           conda-forge/noarch::_r-mutex-1.0.1-anacondar_1 None
  brotlipy           conda-forge/osx-64::brotlipy-0.7.0-py311h5547dcb_1005 None
  bwidget            conda-forge/osx-64::bwidget-1.9.14-h694c41f_1 None
  bzip2              conda-forge/osx-64::bzip2-1.0.8-h0d85af4_4 None
  c-ares             conda-forge/osx-64::c-ares-1.18.1-h0d85af4_0 None
  ca-certificates    conda-forge/osx-64::ca-certificates-2022.12.7-h033912b_0 None
  cairo              conda-forge/osx-64::cairo-1.16.0-h904041c_1014 None
  cctools_osx-64     conda-forge/osx-64::cctools_osx-64-973.0.1-hcc6d90d_11 None
  certifi            conda-forge/noarch::certifi-2022.12.7-pyhd8ed1ab_0 None
  cffi               conda-forge/osx-64::cffi-1.15.1-py311ha86e640_3 None
  charset-normalizer conda-forge/noarch::charset-normalizer-2.1.1-pyhd8ed1ab_0 None
  clang              conda-forge/osx-64::clang-14.0.6-h694c41f_0 None
  clang-14           conda-forge/osx-64::clang-14-14.0.6-default_h55ffa42_0 None
  clang_osx-64       conda-forge/osx-64::clang_osx-64-14.0.6-h3113cd8_4 None
  clangxx            conda-forge/osx-64::clangxx-14.0.6-default_h55ffa42_0 None
  clangxx_osx-64     conda-forge/osx-64::clangxx_osx-64-14.0.6-h6f97653_4 None
  colorama           conda-forge/noarch::colorama-0.4.6-pyhd8ed1ab_0 None
  compiler-rt        conda-forge/osx-64::compiler-rt-14.0.6-h613da45_0 None
  compiler-rt_osx-64 pkgs/main/osx-64::compiler-rt_osx-64-14.0.6-h8d5cb93_0 None
  conda              conda-forge/osx-64::conda-23.1.0-py311h6eed73b_0 None
  conda-package-han~ conda-forge/noarch::conda-package-handling-2.0.2-pyh38be061_0 None
  conda-package-str~ conda-forge/noarch::conda-package-streaming-0.7.0-pyhd8ed1ab_1 None
  cryptography       conda-forge/osx-64::cryptography-39.0.1-py311h61927ef_0 None
  curl               conda-forge/osx-64::curl-7.88.1-h6df9250_0 None
  expat              conda-forge/osx-64::expat-2.5.0-hf0c8a7f_0 None
  fmt                conda-forge/osx-64::fmt-9.1.0-hb8565cd_0 None
  font-ttf-dejavu-s~ conda-forge/noarch::font-ttf-dejavu-sans-mono-2.37-hab24e00_0 None
  font-ttf-inconsol~ conda-forge/noarch::font-ttf-inconsolata-3.000-h77eed37_0 None
  font-ttf-source-c~ conda-forge/noarch::font-ttf-source-code-pro-2.038-h77eed37_0 None
  font-ttf-ubuntu    conda-forge/noarch::font-ttf-ubuntu-0.83-hab24e00_0 None
  fontconfig         conda-forge/osx-64::fontconfig-2.14.2-h5bb23bf_0 None
  fonts-conda-ecosy~ conda-forge/noarch::fonts-conda-ecosystem-1-0 None
  fonts-conda-forge  conda-forge/noarch::fonts-conda-forge-1-0 None
  freetype           conda-forge/osx-64::freetype-2.12.1-h3f81eb7_1 None
  fribidi            conda-forge/osx-64::fribidi-1.0.10-hbcb3906_0 None
  gettext            conda-forge/osx-64::gettext-0.21.1-h8a4c099_0 None
  gfortran_impl_osx~ conda-forge/osx-64::gfortran_impl_osx-64-11.3.0-h1f927f5_28 None
  gfortran_osx-64    conda-forge/osx-64::gfortran_osx-64-11.3.0-h18f7dce_0 None
  gmp                conda-forge/osx-64::gmp-6.2.1-h2e338ed_0 None
  graphite2          conda-forge/osx-64::graphite2-1.3.13-h2e338ed_1001 None
  gsl                conda-forge/osx-64::gsl-2.7-h93259b0_0 None
  harfbuzz           conda-forge/osx-64::harfbuzz-6.0.0-h08f8713_0 None
  icu                conda-forge/osx-64::icu-70.1-h96cf925_0 None
  idna               conda-forge/noarch::idna-3.4-pyhd8ed1ab_0 None
  isl                conda-forge/osx-64::isl-0.25-hb486fe8_0 None
  jpeg               conda-forge/osx-64::jpeg-9e-hb7f2c08_3 None
  krb5               conda-forge/osx-64::krb5-1.20.1-h049b76e_0 None
  ld64_osx-64        conda-forge/osx-64::ld64_osx-64-609-hfd63004_11 None
  lerc               conda-forge/osx-64::lerc-4.0.0-hb486fe8_0 None
  libarchive         conda-forge/osx-64::libarchive-3.6.2-h6d8d9f1_0 None
  libblas            conda-forge/osx-64::libblas-3.9.0-16_osx64_openblas None
  libcblas           conda-forge/osx-64::libcblas-3.9.0-16_osx64_openblas None
  libclang-cpp14     conda-forge/osx-64::libclang-cpp14-14.0.6-default_h55ffa42_0 None
  libcurl            conda-forge/osx-64::libcurl-7.88.1-h6df9250_0 None
  libcxx             conda-forge/osx-64::libcxx-15.0.7-h71dddab_0 None
  libdeflate         conda-forge/osx-64::libdeflate-1.17-hac1461d_0 None
  libedit            conda-forge/osx-64::libedit-3.1.20191231-h0678c8f_2 None
  libev              conda-forge/osx-64::libev-4.33-haf1e3a3_1 None
  libffi             conda-forge/osx-64::libffi-3.4.2-h0d85af4_5 None
  libgfortran        conda-forge/osx-64::libgfortran-5.0.0-10_4_0_h97931a8_28 None
  libgfortran-devel~ conda-forge/noarch::libgfortran-devel_osx-64-11.3.0-h824d247_28 None
  libgfortran5       conda-forge/osx-64::libgfortran5-11.3.0-h082f757_28 None
  libglib            conda-forge/osx-64::libglib-2.74.1-h4c723e1_1 None
  libiconv           conda-forge/osx-64::libiconv-1.17-hac89ed1_0 None
  liblapack          conda-forge/osx-64::liblapack-3.9.0-16_osx64_openblas None
  libllvm14          conda-forge/osx-64::libllvm14-14.0.6-h5b596cc_1 None
  libmamba           conda-forge/osx-64::libmamba-1.3.1-h9d281b0_1 None
  libmambapy         conda-forge/osx-64::libmambapy-1.3.1-py311hcc19a12_1 None
  libnghttp2         conda-forge/osx-64::libnghttp2-1.51.0-he2ab024_0 None
  libopenblas        conda-forge/osx-64::libopenblas-0.3.21-openmp_h429af6e_3 None
  libpng             conda-forge/osx-64::libpng-1.6.39-ha978bb4_0 None
  libsolv            conda-forge/osx-64::libsolv-0.7.23-hbc0c0cd_0 None
  libsqlite          conda-forge/osx-64::libsqlite-3.40.0-ha978bb4_0 None
  libssh2            conda-forge/osx-64::libssh2-1.10.0-h47af595_3 None
  libtiff            conda-forge/osx-64::libtiff-4.5.0-hee9004a_2 None
  libwebp-base       conda-forge/osx-64::libwebp-base-1.2.4-h775f41a_0 None
  libxml2            conda-forge/osx-64::libxml2-2.10.3-hb9e07b5_0 None
  libzlib            conda-forge/osx-64::libzlib-1.2.13-hfd90126_4 None
  llvm-openmp        conda-forge/osx-64::llvm-openmp-15.0.7-h61d9ccf_0 None
  llvm-tools         conda-forge/osx-64::llvm-tools-14.0.6-h5b596cc_1 None
  lz4-c              conda-forge/osx-64::lz4-c-1.9.4-hf0c8a7f_0 None
  lzo                conda-forge/osx-64::lzo-2.10-haf1e3a3_1000 None
  make               conda-forge/osx-64::make-4.3-h22f3db7_1 None
  mamba              conda-forge/osx-64::mamba-1.3.1-py311h8082e30_1 None
  mpc                conda-forge/osx-64::mpc-1.3.1-h81bd1dd_0 None
  mpfr               conda-forge/osx-64::mpfr-4.1.0-h0f52abe_1 None
  ncurses            conda-forge/osx-64::ncurses-6.3-h96cf925_1 None
  openssl            conda-forge/osx-64::openssl-3.0.8-hfd90126_0 None
  pandoc             conda-forge/osx-64::pandoc-2.19.2-h694c41f_1 None
  pango              conda-forge/osx-64::pango-1.50.13-hbd9bf65_0 None
  pcre2              conda-forge/osx-64::pcre2-10.40-h1c4e4bc_0 None
  pip                conda-forge/noarch::pip-23.0.1-pyhd8ed1ab_0 None
  pixman             conda-forge/osx-64::pixman-0.40.0-hbcb3906_0 None
  pluggy             conda-forge/noarch::pluggy-1.0.0-pyhd8ed1ab_5 None
  pybind11-abi       conda-forge/noarch::pybind11-abi-4-hd8ed1ab_3 None
  pycosat            conda-forge/osx-64::pycosat-0.6.4-py311h5547dcb_1 None
  pycparser          conda-forge/noarch::pycparser-2.21-pyhd8ed1ab_0 None
  pyopenssl          conda-forge/noarch::pyopenssl-23.0.0-pyhd8ed1ab_0 None
  pysocks            conda-forge/noarch::pysocks-1.7.1-pyha2e5f31_6 None
  python             conda-forge/osx-64::python-3.11.0-he7542f4_1_cpython None
  python_abi         conda-forge/osx-64::python_abi-3.11-3_cp311 None
  r-askpass          conda-forge/osx-64::r-askpass-1.1-r42h815d134_3 None
  r-assertthat       conda-forge/noarch::r-assertthat-0.2.1-r42hc72bb7e_3 None
  r-backports        conda-forge/osx-64::r-backports-1.4.1-r42h815d134_1 None
  r-base             conda-forge/osx-64::r-base-4.2.2-h841e2fe_3 None
  r-base64enc        conda-forge/osx-64::r-base64enc-0.1_3-r42h815d134_1005 None
  r-bit              conda-forge/osx-64::r-bit-4.0.5-r42h815d134_0 None
  r-bit64            conda-forge/osx-64::r-bit64-4.0.5-r42h815d134_1 None
  r-blob             conda-forge/noarch::r-blob-1.2.3-r42hc72bb7e_1 None
  r-broom            conda-forge/noarch::r-broom-1.0.3-r42hc72bb7e_0 None
  r-bslib            conda-forge/noarch::r-bslib-0.4.2-r42hc72bb7e_0 None
  r-cachem           conda-forge/osx-64::r-cachem-1.0.7-r42h815d134_0 None
  r-callr            conda-forge/noarch::r-callr-3.7.3-r42hc72bb7e_0 None
  r-cellranger       conda-forge/noarch::r-cellranger-1.1.0-r42hc72bb7e_1005 None
  r-cli              conda-forge/osx-64::r-cli-3.6.0-r42h49197e3_0 None
  r-clipr            conda-forge/noarch::r-clipr-0.8.0-r42hc72bb7e_1 None
  r-colorspace       conda-forge/osx-64::r-colorspace-2.1_0-r42h815d134_0 None
  r-conflicted       conda-forge/noarch::r-conflicted-1.2.0-r42h785f33e_0 None
  r-cpp11            conda-forge/noarch::r-cpp11-0.4.3-r42hc72bb7e_0 None
  r-crayon           conda-forge/noarch::r-crayon-1.5.2-r42hc72bb7e_1 None
  r-curl             conda-forge/osx-64::r-curl-4.3.3-r42h815d134_1 None
  r-data.table       conda-forge/osx-64::r-data.table-1.14.8-r42h557251b_0 None
  r-dbi              conda-forge/noarch::r-dbi-1.1.3-r42hc72bb7e_1 None
  r-dbplyr           conda-forge/noarch::r-dbplyr-2.3.1-r42hc72bb7e_0 None
  r-digest           conda-forge/osx-64::r-digest-0.6.31-r42h49197e3_0 None
  r-dplyr            conda-forge/osx-64::r-dplyr-1.1.0-r42h49197e3_0 None
  r-dtplyr           conda-forge/noarch::r-dtplyr-1.3.0-r42hc72bb7e_0 None
  r-ellipsis         conda-forge/osx-64::r-ellipsis-0.3.2-r42h815d134_1 None
  r-evaluate         conda-forge/noarch::r-evaluate-0.20-r42hc72bb7e_0 None
  r-fansi            conda-forge/osx-64::r-fansi-1.0.4-r42h815d134_0 None
  r-farver           conda-forge/osx-64::r-farver-2.1.1-r42h49197e3_1 None
  r-fastmap          conda-forge/osx-64::r-fastmap-1.1.1-r42h49197e3_0 None
  r-forcats          conda-forge/noarch::r-forcats-1.0.0-r42hc72bb7e_0 None
  r-fs               conda-forge/osx-64::r-fs-1.6.1-r42h49197e3_0 None
  r-gargle           conda-forge/noarch::r-gargle-1.3.0-r42h785f33e_0 None
  r-generics         conda-forge/noarch::r-generics-0.1.3-r42hc72bb7e_1 None
  r-ggplot2          conda-forge/noarch::r-ggplot2-3.4.1-r42hc72bb7e_0 None
  r-glue             conda-forge/osx-64::r-glue-1.6.2-r42h815d134_1 None
  r-googledrive      conda-forge/noarch::r-googledrive-2.0.0-r42hc72bb7e_1 None
  r-googlesheets4    conda-forge/noarch::r-googlesheets4-1.0.1-r42h785f33e_1 None
  r-gtable           conda-forge/noarch::r-gtable-0.3.1-r42hc72bb7e_1 None
  r-haven            conda-forge/osx-64::r-haven-2.5.1-r42h49197e3_0 None
  r-highr            conda-forge/noarch::r-highr-0.10-r42hc72bb7e_0 None
  r-hms              conda-forge/noarch::r-hms-1.1.2-r42hc72bb7e_1 None
  r-htmltools        conda-forge/osx-64::r-htmltools-0.5.4-r42h49197e3_0 None
  r-httr             conda-forge/noarch::r-httr-1.4.5-r42hc72bb7e_0 None
  r-ids              conda-forge/noarch::r-ids-1.0.1-r42hc72bb7e_2 None
  r-isoband          conda-forge/osx-64::r-isoband-0.2.7-r42h49197e3_1 None
  r-jquerylib        conda-forge/noarch::r-jquerylib-0.1.4-r42hc72bb7e_1 None
  r-jsonlite         conda-forge/osx-64::r-jsonlite-1.8.4-r42h815d134_0 None
  r-knitr            conda-forge/noarch::r-knitr-1.42-r42hc72bb7e_1 None
  r-labeling         conda-forge/noarch::r-labeling-0.4.2-r42hc72bb7e_2 None
  r-lattice          conda-forge/osx-64::r-lattice-0.20_45-r42h815d134_1 None
  r-lifecycle        conda-forge/noarch::r-lifecycle-1.0.3-r42hc72bb7e_1 None
  r-lubridate        conda-forge/osx-64::r-lubridate-1.9.2-r42h815d134_1 None
  r-magrittr         conda-forge/osx-64::r-magrittr-2.0.3-r42h815d134_1 None
  r-mass             conda-forge/osx-64::r-mass-7.3_58.2-r42h815d134_0 None
  r-matrix           conda-forge/osx-64::r-matrix-1.5_3-r42hce01bf1_0 None
  r-memoise          conda-forge/noarch::r-memoise-2.0.1-r42hc72bb7e_1 None
  r-mgcv             conda-forge/osx-64::r-mgcv-1.8_41-r42h40f944a_0 None
  r-mime             conda-forge/osx-64::r-mime-0.12-r42h815d134_1 None
  r-modelr           conda-forge/noarch::r-modelr-0.1.10-r42hc72bb7e_0 None
  r-munsell          conda-forge/noarch::r-munsell-0.5.0-r42hc72bb7e_1005 None
  r-nlme             conda-forge/osx-64::r-nlme-3.1_162-r42h1e4e481_0 None
  r-openssl          conda-forge/osx-64::r-openssl-2.0.5-r42hfeb9312_0 None
  r-pillar           conda-forge/noarch::r-pillar-1.8.1-r42hc72bb7e_1 None
  r-pkgconfig        conda-forge/noarch::r-pkgconfig-2.0.3-r42hc72bb7e_2 None
  r-prettyunits      conda-forge/noarch::r-prettyunits-1.1.1-r42hc72bb7e_2 None
  r-processx         conda-forge/osx-64::r-processx-3.8.0-r42h815d134_0 None
  r-progress         conda-forge/noarch::r-progress-1.2.2-r42hc72bb7e_3 None
  r-ps               conda-forge/osx-64::r-ps-1.7.2-r42h815d134_0 None
  r-purrr            conda-forge/osx-64::r-purrr-1.0.1-r42h815d134_0 None
  r-r6               conda-forge/noarch::r-r6-2.5.1-r42hc72bb7e_1 None
  r-ragg             conda-forge/osx-64::r-ragg-1.2.5-r42hd0b13e6_0 None
  r-rappdirs         conda-forge/osx-64::r-rappdirs-0.3.3-r42h815d134_1 None
  r-rcolorbrewer     conda-forge/noarch::r-rcolorbrewer-1.1_3-r42h785f33e_1 None
  r-rcpp             conda-forge/osx-64::r-rcpp-1.0.10-r42h49197e3_0 None
  r-readr            conda-forge/osx-64::r-readr-2.1.4-r42h49197e3_0 None
  r-readxl           conda-forge/osx-64::r-readxl-1.4.2-r42h3ae43e4_0 None
  r-rematch          conda-forge/noarch::r-rematch-1.0.1-r42hc72bb7e_1005 None
  r-rematch2         conda-forge/noarch::r-rematch2-2.1.2-r42hc72bb7e_2 None
  r-reprex           conda-forge/noarch::r-reprex-2.0.2-r42hc72bb7e_1 None
  r-rlang            conda-forge/osx-64::r-rlang-1.0.6-r42h49197e3_1 None
  r-rmarkdown        conda-forge/noarch::r-rmarkdown-2.20-r42hc72bb7e_0 None
  r-rstudioapi       conda-forge/noarch::r-rstudioapi-0.14-r42hc72bb7e_1 None
  r-rvest            conda-forge/noarch::r-rvest-1.0.3-r42hc72bb7e_1 None
  r-sass             conda-forge/osx-64::r-sass-0.4.5-r42h49197e3_0 None
  r-scales           conda-forge/noarch::r-scales-1.2.1-r42hc72bb7e_1 None
  r-selectr          conda-forge/noarch::r-selectr-0.4_2-r42hc72bb7e_2 None
  r-stringi          conda-forge/osx-64::r-stringi-1.7.12-r42h7183e51_0 None
  r-stringr          conda-forge/noarch::r-stringr-1.5.0-r42h785f33e_0 None
  r-sys              conda-forge/osx-64::r-sys-3.4.1-r42h815d134_0 None
  r-systemfonts      conda-forge/osx-64::r-systemfonts-1.0.4-r42h1372bf0_1 None
  r-textshaping      conda-forge/osx-64::r-textshaping-0.3.6-r42h12cd53d_4 None
  r-tibble           conda-forge/osx-64::r-tibble-3.1.8-r42h815d134_1 None
  r-tidyr            conda-forge/osx-64::r-tidyr-1.3.0-r42h49197e3_0 None
  r-tidyselect       conda-forge/osx-64::r-tidyselect-1.2.0-r42hbe3e9c8_0 None
  r-tidyverse        conda-forge/noarch::r-tidyverse-2.0.0-r42h785f33e_0 None
  r-timechange       conda-forge/osx-64::r-timechange-0.2.0-r42h49197e3_0 None
  r-tinytex          conda-forge/noarch::r-tinytex-0.44-r42hc72bb7e_0 None
  r-tzdb             conda-forge/osx-64::r-tzdb-0.3.0-r42h49197e3_1 None
  r-utf8             conda-forge/osx-64::r-utf8-1.2.3-r42h815d134_0 None
  r-uuid             conda-forge/osx-64::r-uuid-1.1_0-r42h815d134_1 None
  r-vctrs            conda-forge/osx-64::r-vctrs-0.5.2-r42h49197e3_0 None
  r-viridislite      conda-forge/noarch::r-viridislite-0.4.1-r42hc72bb7e_1 None
  r-vroom            conda-forge/osx-64::r-vroom-1.6.1-r42h49197e3_0 None
  r-withr            conda-forge/noarch::r-withr-2.5.0-r42hc72bb7e_1 None
  r-xfun             conda-forge/osx-64::r-xfun-0.37-r42h49197e3_0 None
  r-xml2             conda-forge/osx-64::r-xml2-1.3.3-r42h3576887_2 None
  r-yaml             conda-forge/osx-64::r-yaml-2.3.7-r42h815d134_0 None
  readline           conda-forge/osx-64::readline-8.1.2-h3899abd_0 None
  reproc             conda-forge/osx-64::reproc-14.2.4-hb7f2c08_0 None
  reproc-cpp         conda-forge/osx-64::reproc-cpp-14.2.4-hf0c8a7f_0 None
  requests           conda-forge/noarch::requests-2.28.2-pyhd8ed1ab_0 None
  ruamel.yaml        conda-forge/osx-64::ruamel.yaml-0.17.21-py311h5547dcb_2 None
  ruamel.yaml.clib   conda-forge/osx-64::ruamel.yaml.clib-0.2.7-py311h5547dcb_1 None
  setuptools         conda-forge/noarch::setuptools-67.4.0-pyhd8ed1ab_0 None
  sigtool            conda-forge/osx-64::sigtool-0.1.3-h88f4db0_0 None
  tapi               conda-forge/osx-64::tapi-1100.0.11-h9ce4665_0 None
  tk                 conda-forge/osx-64::tk-8.6.12-h5dbffcc_0 None
  tktable            conda-forge/osx-64::tktable-2.10-h49f0cf7_3 None
  toolz              conda-forge/noarch::toolz-0.12.0-pyhd8ed1ab_0 None
  tqdm               conda-forge/noarch::tqdm-4.64.1-pyhd8ed1ab_0 None
  tzdata             conda-forge/noarch::tzdata-2022g-h191b570_0 None
  urllib3            conda-forge/noarch::urllib3-1.26.14-pyhd8ed1ab_0 None
  wheel              conda-forge/noarch::wheel-0.38.4-pyhd8ed1ab_0 None
  xz                 conda-forge/osx-64::xz-5.2.6-h775f41a_0 None
  yaml-cpp           conda-forge/osx-64::yaml-cpp-0.7.0-hf0c8a7f_2 None
  zlib               conda-forge/osx-64::zlib-1.2.13-hfd90126_4 None
  zstandard          conda-forge/osx-64::zstandard-0.19.0-py311hebd4beb_1 None
  zstd               conda-forge/osx-64::zstd-1.5.2-hbc0c0cd_6 None


Proceed ([y]/n)? y


Downloading and Extracting Packages
conda-package-stream | 17 KB     | ######################################################################### 100%
r-systemfonts-1.0.4  | 253 KB    | ######################################################################### 100%
r-fastmap-1.1.1      | 69 KB     | ######################################################################### 100%
r-rematch2-2.1.2     | 54 KB     | ######################################################################### 100%
r-fs-1.6.1           | 269 KB    | ######################################################################### 100%
r-ids-1.0.1          | 127 KB    | ######################################################################### 100%
r-googledrive-2.0.0  | 1.8 MB    | ######################################################################### 100%
urllib3-1.26.14      | 110 KB    | ######################################################################### 100%
openssl-3.0.8        | 2.2 MB    | ######################################################################### 100%
libmamba-1.3.1       | 1.2 MB    | ######################################################################### 100%
r-modelr-0.1.10      | 220 KB    | ######################################################################### 100%
libsolv-0.7.23       | 402 KB    | ######################################################################### 100%
r-gtable-0.3.1       | 174 KB    | ######################################################################### 100%
libcurl-7.88.1       | 335 KB    | ######################################################################### 100%
r-readr-2.1.4        | 724 KB    | ######################################################################### 100%
r-callr-3.7.3        | 429 KB    | ######################################################################### 100%
r-dbplyr-2.3.1       | 1.0 MB    | ######################################################################### 100%
compiler-rt_osx-64-1 | 3.4 MB    | ######################################################################### 100%
r-clipr-0.8.0        | 68 KB     | ######################################################################### 100%
libarchive-3.6.2     | 706 KB    | ######################################################################### 100%
r-forcats-1.0.0      | 414 KB    | ######################################################################### 100%
r-dtplyr-1.3.0       | 348 KB    | ######################################################################### 100%
r-vroom-1.6.1        | 781 KB    | ######################################################################### 100%
ruamel.yaml.clib-0.2 | 115 KB    | ######################################################################### 100%
r-mass-7.3_58.2      | 1.1 MB    | ######################################################################### 100%
zstd-1.5.2           | 399 KB    | ######################################################################### 100%
r-ragg-1.2.5         | 386 KB    | ######################################################################### 100%
r-readxl-1.4.2       | 712 KB    | ######################################################################### 100%
r-munsell-0.5.0      | 248 KB    | ######################################################################### 100%
reproc-14.2.4        | 27 KB     | ######################################################################### 100%
cryptography-39.0.1  | 1.1 MB    | ######################################################################### 100%
yaml-cpp-0.7.0       | 139 KB    | ######################################################################### 100%
r-tzdb-0.3.0         | 531 KB    | ######################################################################### 100%
r-cli-3.6.0          | 1.2 MB    | ######################################################################### 100%
r-viridislite-0.4.1  | 1.3 MB    | ######################################################################### 100%
r-scales-1.2.1       | 612 KB    | ######################################################################### 100%
llvm-openmp-15.0.7   | 287 KB    | ######################################################################### 100%
libcxx-15.0.7        | 1.1 MB    | ######################################################################### 100%
r-httr-1.4.5         | 477 KB    | ######################################################################### 100%
r-farver-2.1.1       | 1.4 MB    | ######################################################################### 100%
reproc-cpp-14.2.4    | 19 KB     | ######################################################################### 100%
pluggy-1.0.0         | 16 KB     | ######################################################################### 100%
libgfortran-devel_os | 418 KB    | ######################################################################### 100%
r-utf8-1.2.3         | 135 KB    | ######################################################################### 100%
lz4-c-1.9.4          | 153 KB    | ######################################################################### 100%
r-conflicted-1.2.0   | 62 KB     | ######################################################################### 100%
pango-1.50.13        | 407 KB    | ######################################################################### 100%
r-selectr-0.4_2      | 463 KB    | ######################################################################### 100%
tzdata-2022g         | 106 KB    | ######################################################################### 100%
r-uuid-1.1_0         | 50 KB     | ######################################################################### 100%
libgfortran-5.0.0    | 144 KB    | ######################################################################### 100%
pyopenssl-23.0.0     | 124 KB    | ######################################################################### 100%
r-ggplot2-3.4.1      | 3.9 MB    | ######################################################################### 100%
pycosat-0.6.4        | 113 KB    | ######################################################################### 100%
r-haven-2.5.1        | 383 KB    | ######################################################################### 100%
r-stringi-1.7.12     | 836 KB    | ######################################################################### 100%
r-isoband-0.2.7      | 1.6 MB    | ######################################################################### 100%
r-rematch-1.0.1      | 20 KB     | ######################################################################### 100%
r-rstudioapi-0.14    | 301 KB    | ######################################################################### 100%
python-3.11.0        | 14.7 MB   | ######################################################################### 100%
libdeflate-1.17      | 66 KB     | ######################################################################### 100%
r-xfun-0.37          | 393 KB    | ######################################################################### 100%
zstandard-0.19.0     | 405 KB    | ######################################################################### 100%
libtiff-4.5.0        | 383 KB    | ######################################################################### 100%
r-knitr-1.42         | 1.2 MB    | ######################################################################### 100%
r-dplyr-1.1.0        | 1.3 MB    | ######################################################################### 100%
r-rvest-1.0.3        | 216 KB    | ######################################################################### 100%
r-rcpp-1.0.10        | 1.9 MB    | ######################################################################### 100%
libmambapy-1.3.1     | 231 KB    | ######################################################################### 100%
r-tidyverse-2.0.0    | 415 KB    | ######################################################################### 100%
requests-2.28.2      | 55 KB     | ######################################################################### 100%
python_abi-3.11      | 6 KB      | ######################################################################### 100%
r-timechange-0.2.0   | 177 KB    | ######################################################################### 100%
lzo-2.10             | 190 KB    | ######################################################################### 100%
fontconfig-2.14.2    | 232 KB    | ######################################################################### 100%
r-textshaping-0.3.6  | 99 KB     | ######################################################################### 100%
r-sass-0.4.5         | 2.0 MB    | ######################################################################### 100%
r-lubridate-1.9.2    | 942 KB    | ######################################################################### 100%
mpc-1.3.1            | 107 KB    | ######################################################################### 100%
r-ps-1.7.2           | 315 KB    | ######################################################################### 100%
ruamel.yaml-0.17.21  | 248 KB    | ######################################################################### 100%
r-colorspace-2.1_0   | 2.4 MB    | ######################################################################### 100%
r-data.table-1.14.8  | 1.8 MB    | ######################################################################### 100%
r-labeling-0.4.2     | 68 KB     | ######################################################################### 100%
r-nlme-3.1_162       | 2.2 MB    | ######################################################################### 100%
r-processx-3.8.0     | 318 KB    | ######################################################################### 100%
r-vctrs-0.5.2        | 1.2 MB    | ######################################################################### 100%
gfortran_impl_osx-64 | 17.5 MB   | ######################################################################### 100%
r-mgcv-1.8_41        | 3.2 MB    | ######################################################################### 100%
r-googlesheets4-1.0. | 498 KB    | ######################################################################### 100%
fmt-9.1.0            | 179 KB    | ######################################################################### 100%
r-yaml-2.3.7         | 104 KB    | ######################################################################### 100%
r-reprex-2.0.2       | 499 KB    | ######################################################################### 100%
pip-23.0.1           | 1.3 MB    | ######################################################################### 100%
libgfortran5-11.3.0  | 1.4 MB    | ######################################################################### 100%
conda-package-handli | 247 KB    | ######################################################################### 100%
setuptools-67.4.0    | 567 KB    | ######################################################################### 100%
mamba-1.3.1          | 63 KB     | ######################################################################### 100%
curl-7.88.1          | 140 KB    | ######################################################################### 100%
r-tidyr-1.3.0        | 1.1 MB    | ######################################################################### 100%
conda-23.1.0         | 1.2 MB    | ######################################################################### 100%
r-tinytex-0.44       | 139 KB    | ######################################################################### 100%
cffi-1.15.1          | 274 KB    | ######################################################################### 100%
r-base-4.2.2         | 23.3 MB   | ######################################################################### 100%
jpeg-9e              | 226 KB    | ######################################################################### 100%
r-backports-1.4.1    | 109 KB    | ######################################################################### 100%
r-cachem-1.0.7       | 72 KB     | ######################################################################### 100%
r-gargle-1.3.0       | 519 KB    | ######################################################################### 100%
brotlipy-0.7.0       | 370 KB    | ######################################################################### 100%
r-cellranger-1.1.0   | 110 KB    | ######################################################################### 100%
r-broom-1.0.3        | 1.7 MB    | ######################################################################### 100%
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate expression_env
#
# To deactivate an active environment, use
#
#     $ conda deactivate

Retrieving notices: ...working... done


❯ source activate expression_env


❯ con-env
# conda environments:
#
                         /Users/kalavatt/mambaforge/envs/Trinity_env
base                  *  /Users/kalavatt/mambaforge/envs/expression_env
                         /Users/kalavatt/mambaforge/envs/r413_env
                         /Users/kalavatt/mambaforge/envs/spyder_env


❯ mamba install -c bioconda bioconductor-deseq2

mamba install -c bioconda subread

mamba install \
    -c bioconda \
        bioconductor-enhancedvolcano bioconductor-pcatools

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

bioconda/osx-64                                      3.8MB @   3.7MB/s  1.1s
bioconda/noarch                                      4.2MB @   3.6MB/s  1.2s
pkgs/main/osx-64                                     5.0MB @   3.8MB/s  1.4s
pkgs/r/noarch                                        1.3MB @ 906.8kB/s  0.4s
pkgs/main/noarch                                   819.1kB @ 552.4kB/s  0.2s
pkgs/r/osx-64                                      820.9kB @ 512.5kB/s  0.5s
conda-forge/noarch                                  11.4MB @   4.0MB/s  3.1s
conda-forge/osx-64                                  27.1MB @   4.2MB/s  7.1s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - bioconductor-deseq2
   - ca-certificates
   - certifi
   - openssl


  Package                                 Version  Build             Channel                 Size
───────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────────────

  + argcomplete                             2.0.0  pyhd8ed1ab_0      conda-forge/noarch      35kB
  + bioconductor-annotate                  1.76.0  r42hdfd78af_0     bioconda/noarch          2MB
  + bioconductor-annotationdbi             1.60.0  r42hdfd78af_0     bioconda/noarch          5MB
  + bioconductor-biobase                   2.58.0  r42h3be46a4_0     bioconda/osx-64          3MB
  + bioconductor-biocgenerics              0.44.0  r42hdfd78af_0     bioconda/noarch        665kB
  + bioconductor-biocparallel              1.32.5  r42hb890f52_0     bioconda/osx-64          2MB
  + bioconductor-biostrings                2.66.0  r42h3be46a4_0     bioconda/osx-64         14MB
  + bioconductor-data-packages           20230202  hdfd78af_0        bioconda/noarch        144kB
  + bioconductor-delayedarray              0.24.0  r42h3be46a4_0     bioconda/osx-64          3MB
  + bioconductor-deseq2                    1.38.0  r42hb890f52_0     bioconda/osx-64          3MB
  + bioconductor-genefilter                1.80.0  r42h238a2e4_0     bioconda/osx-64          1MB
  + bioconductor-geneplotter               1.76.0  r42hdfd78af_0     bioconda/noarch          2MB
  + bioconductor-genomeinfodb              1.34.8  r42hdfd78af_0     bioconda/noarch          4MB
  + bioconductor-genomeinfodbdata           1.2.9  r42hdfd78af_0     bioconda/noarch          8kB
  + bioconductor-genomicranges             1.50.0  r42h3be46a4_0     bioconda/osx-64          2MB
  + bioconductor-iranges                   2.32.0  r42h3be46a4_0     bioconda/osx-64          3MB
  + bioconductor-keggrest                  1.38.0  r42hdfd78af_0     bioconda/noarch        199kB
  + bioconductor-matrixgenerics            1.10.0  r42hdfd78af_0     bioconda/noarch        353kB
  + bioconductor-s4vectors                 0.36.0  r42h3be46a4_0     bioconda/osx-64          2MB
  + bioconductor-summarizedexperiment      1.28.0  r42hdfd78af_0     bioconda/noarch          3MB
  + bioconductor-xvector                   0.38.0  r42h3be46a4_0     bioconda/osx-64        737kB
  + bioconductor-zlibbioc                  1.44.0  r42h3be46a4_0     bioconda/osx-64         73kB
  + importlib-metadata                     4.13.0  pyha770c72_0      conda-forge/noarch      26kB
  + importlib_metadata                     4.13.0  hd8ed1ab_0        conda-forge/noarch       9kB
  + jq                                        1.5  0                 bioconda/osx-64        309kB
  + libgcc                                  4.8.5  1                 conda-forge/osx-64     804kB
  + pyyaml                                    6.0  py311h5547dcb_5   conda-forge/osx-64     198kB
  + r-bh                                 1.81.0_1  r42hc72bb7e_0     conda-forge/noarch      11MB
  + r-bitops                                1.0_7  r42h815d134_1     conda-forge/osx-64      44kB
  + r-codetools                            0.2_19  r42hc72bb7e_0     conda-forge/noarch     108kB
  + r-formatr                                1.14  r42hc72bb7e_0     conda-forge/noarch     165kB
  + r-futile.logger                         1.4.3  r42hc72bb7e_1004  conda-forge/noarch     111kB
  + r-futile.options                        1.0.1  r42hc72bb7e_1003  conda-forge/noarch      29kB
  + r-lambda.r                              1.2.4  r42hc72bb7e_2     conda-forge/noarch     124kB
  + r-locfit                              1.5_9.7  r42h815d134_0     conda-forge/osx-64     573kB
  + r-matrixstats                          0.63.0  r42h815d134_0     conda-forge/osx-64     452kB
  + r-plogr                                 0.2.0  r42hc72bb7e_1004  conda-forge/noarch      21kB
  + r-png                                   0.1_8  r42hbf2103b_0     conda-forge/osx-64      57kB
  + r-rcpparmadillo                    0.11.4.4.0  r42hf5e6a41_0     conda-forge/osx-64     883kB
  + r-rcurl                             1.98_1.10  r42h815d134_0     conda-forge/osx-64     815kB
  + r-rsqlite                              2.2.20  r42h49197e3_0     conda-forge/osx-64       1MB
  + r-snow                                  0.4_4  r42hc72bb7e_1     conda-forge/noarch     117kB
  + r-survival                              3.5_3  r42h815d134_0     conda-forge/osx-64       6MB
  + r-xml                               3.99_0.13  r42h67ce8dc_0     conda-forge/osx-64       2MB
  + r-xtable                                1.8_4  r42hc72bb7e_4     conda-forge/noarch     717kB
  + toml                                   0.10.2  pyhd8ed1ab_0      conda-forge/noarch      18kB
  + xmltodict                              0.13.0  pyhd8ed1ab_0      conda-forge/noarch      14kB
  + yaml                                    0.2.5  h0d85af4_2        conda-forge/osx-64      84kB
  + yq                                      3.1.1  pyhd8ed1ab_0      conda-forge/noarch      23kB
  + zipp                                   3.15.0  pyhd8ed1ab_0      conda-forge/noarch      17kB

  Summary:

  Install: 50 packages

  Total download: 76MB

───────────────────────────────────────────────────────────────────────────────────────────────────


bioconductor-biocgenerics                          664.5kB @  10.3MB/s  0.1s
bioconductor-zlibbioc                               73.2kB @ 862.9kB/s  0.1s
bioconductor-s4vectors                               2.3MB @  23.5MB/s  0.1s
bioconductor-iranges                                 2.5MB @  19.5MB/s  0.1s
pyyaml                                             197.9kB @   1.5MB/s  0.0s
bioconductor-biobase                                 2.5MB @  17.7MB/s  0.1s
libgcc                                             804.3kB @   5.7MB/s  0.1s
r-snow                                             117.0kB @ 755.2kB/s  0.0s
toml                                                18.4kB @ 113.6kB/s  0.0s
r-formatr                                          165.2kB @ 973.5kB/s  0.0s
zipp                                                17.2kB @  98.5kB/s  0.0s
argcomplete                                         35.2kB @ 194.1kB/s  0.0s
yq                                                  22.6kB @ 113.7kB/s  0.0s
bioconductor-biocparallel                            1.7MB @   8.4MB/s  0.0s
bioconductor-keggrest                              199.5kB @ 957.5kB/s  0.0s
r-png                                               57.4kB @ 229.4kB/s  0.0s
bioconductor-annotate                                1.8MB @   6.5MB/s  0.1s
bioconductor-genomeinfodb                            4.3MB @  14.6MB/s  0.1s
r-rcurl                                            815.2kB @   2.5MB/s  0.0s
r-codetools                                        108.1kB @ 329.0kB/s  0.0s
r-survival                                           6.0MB @  18.2MB/s  0.3s
r-plogr                                             21.2kB @  59.4kB/s  0.0s
importlib_metadata                                   9.1kB @  24.9kB/s  0.0s
bioconductor-data-packages                         144.5kB @ 372.4kB/s  0.0s
bioconductor-genomicranges                           2.2MB @   5.3MB/s  0.1s
r-matrixstats                                      451.9kB @ 963.3kB/s  0.0s
r-locfit                                           573.3kB @   1.2MB/s  0.2s
jq                                                 309.3kB @ 650.1kB/s  0.1s
importlib-metadata                                  25.5kB @  50.9kB/s  0.0s
yaml                                                84.2kB @ 166.5kB/s  0.0s
bioconductor-genomeinfodbdata                        7.9kB @  14.7kB/s  0.0s
bioconductor-matrixgenerics                        352.7kB @ 638.6kB/s  0.1s
bioconductor-deseq2                                  2.9MB @   5.0MB/s  0.4s
r-bitops                                            44.3kB @  74.5kB/s  0.0s
r-lambda.r                                         123.9kB @ 198.9kB/s  0.0s
r-rcpparmadillo                                    883.4kB @   1.3MB/s  0.2s
bioconductor-annotationdbi                           5.2MB @   7.1MB/s  0.2s
r-xtable                                           717.4kB @ 914.1kB/s  0.1s
r-bh                                                11.4MB @  14.0MB/s  0.2s
r-futile.logger                                    111.1kB @ 136.2kB/s  0.0s
xmltodict                                           13.6kB @  16.0kB/s  0.0s
bioconductor-geneplotter                             1.5MB @   1.7MB/s  0.5s
bioconductor-summarizedexperiment                    2.8MB @   3.1MB/s  0.1s
bioconductor-genefilter                              1.1MB @   1.3MB/s  0.2s
r-rsqlite                                            1.2MB @   1.3MB/s  0.3s
r-futile.options                                    28.8kB @  31.3kB/s  0.0s
bioconductor-xvector                               737.3kB @ 782.5kB/s  0.0s
bioconductor-biostrings                             14.2MB @  13.2MB/s  0.2s
r-xml                                                1.7MB @   1.5MB/s  0.2s
bioconductor-delayedarray                            2.5MB @   2.1MB/s  0.3s

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

bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
pkgs/main/osx-64                                              No change
pkgs/main/noarch                                   819.4kB @   2.4MB/s  0.4s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - subread
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build       Channel             Size
────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────

  + subread    2.0.3  h740a0af_1  bioconda/osx-64     12MB

  Summary:

  Install: 1 packages

  Total download: 12MB

────────────────────────────────────────────────────────────


Confirm changes: [Y/n]
mamba install \
    -c bioconda \
        bioconductor-enhancedvolcano bioconductor-pcatools
subread                                             12.3MB @  33.3MB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

\                  __    __    __    __
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

bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
pkgs/main/osx-64                                            Using cache
pkgs/main/noarch                                            Using cache
pkgs/r/osx-64                                               Using cache
pkgs/r/noarch                                               Using cache

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - bioconductor-enhancedvolcano
   - bioconductor-pcatools
   - ca-certificates
   - certifi
   - openssl


  Package                            Version  Build          Channel                 Size
───────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────

  + bioconductor-beachmat             2.14.0  r42hb890f52_0  bioconda/osx-64          1MB
  + bioconductor-biocsingular         1.14.0  r42hb890f52_0  bioconda/osx-64        995kB
  + bioconductor-delayedmatrixstats   1.20.0  r42hdfd78af_0  bioconda/noarch        740kB
  + bioconductor-enhancedvolcano      1.16.0  r42hdfd78af_0  bioconda/noarch          5MB
  + bioconductor-pcatools             2.10.0  r42hb890f52_0  bioconda/osx-64          5MB
  + bioconductor-scaledmatrix          1.6.0  r42hdfd78af_0  bioconda/noarch        653kB
  + bioconductor-sparsematrixstats    1.10.0  r42hb890f52_0  bioconda/osx-64          1MB
  + r-cowplot                          1.1.1  r42hc72bb7e_1  conda-forge/noarch       1MB
  + r-dqrng                            0.3.0  r42h49197e3_1  conda-forge/osx-64     164kB
  + r-ggrepel                          0.9.3  r42h49197e3_0  conda-forge/osx-64     261kB
  + r-irlba                          2.3.5.1  r42hce01bf1_0  conda-forge/osx-64     320kB
  + r-plyr                             1.8.8  r42h49197e3_0  conda-forge/osx-64     856kB
  + r-reshape2                         1.4.4  r42h49197e3_2  conda-forge/osx-64     132kB
  + r-rsvd                             1.0.5  r42hc72bb7e_1  conda-forge/noarch       4MB
  + r-sitmo                            2.0.2  r42h49197e3_1  conda-forge/osx-64     160kB

  Summary:

  Install: 15 packages

  Total download: 22MB

───────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
bioconductor-sparsematrixstats                       1.2MB @  11.5MB/s  0.1s
bioconductor-scaledmatrix                          652.9kB @   6.1MB/s  0.1s
r-sitmo                                            160.5kB @   1.5MB/s  0.1s
bioconductor-delayedmatrixstats                    739.6kB @   6.2MB/s  0.1s
bioconductor-beachmat                                1.3MB @  10.0MB/s  0.1s
r-irlba                                            319.6kB @   2.0MB/s  0.1s
r-reshape2                                         131.5kB @ 804.9kB/s  0.0s
r-ggrepel                                          260.8kB @   1.5MB/s  0.0s
r-rsvd                                               3.6MB @  20.3MB/s  0.1s
r-dqrng                                            163.7kB @ 838.1kB/s  0.0s
r-plyr                                             856.0kB @   4.0MB/s  0.0s
bioconductor-biocsingular                          994.8kB @   4.1MB/s  0.1s
r-cowplot                                            1.4MB @   4.8MB/s  0.2s
bioconductor-enhancedvolcano                         5.1MB @  12.9MB/s  0.2s
bioconductor-pcatools                                5.0MB @   7.5MB/s  0.5s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge r-markdown

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-markdown']

bioconda/noarch                                      4.2MB @   4.4MB/s  1.1s
pkgs/main/osx-64                                     5.0MB @   4.3MB/s  1.3s
bioconda/osx-64                                      3.8MB @   2.8MB/s  1.4s
pkgs/r/noarch                                        1.3MB @ 901.1kB/s  0.5s
pkgs/r/osx-64                                      820.9kB @ 556.7kB/s  0.3s
pkgs/main/noarch                                   819.4kB @ 501.6kB/s  0.3s
conda-forge/noarch                                  11.4MB @   4.9MB/s  2.6s
conda-forge/osx-64                                  27.1MB @   4.3MB/s  7.0s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - r-markdown
   - ca-certificates
   - certifi
   - openssl


  Package         Version  Build          Channel                  Size
─────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────

  + r-commonmark    1.8.1  r42h815d134_0  conda-forge/osx-64     Cached
  + r-markdown        1.5  r42hc72bb7e_0  conda-forge/noarch      122kB

  Summary:

  Install: 2 packages

  Total download: 122kB

─────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
r-markdown                                         122.1kB @ 597.3kB/s  0.2s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c bioconda bioconductor-sva

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['bioconductor-sva']

bioconda/osx-64                                      3.8MB @   4.8MB/s  0.9s
pkgs/r/noarch                                                 No change
bioconda/noarch                                      4.2MB @   4.2MB/s  1.1s
pkgs/main/osx-64                                     5.2MB @   4.7MB/s  1.2s
pkgs/r/osx-64                                                 No change
pkgs/main/noarch                                   820.1kB @ 673.2kB/s  0.3s
conda-forge/noarch                                  11.7MB @   4.5MB/s  2.8s
conda-forge/osx-64                                  27.6MB @   5.0MB/s  6.2s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - bioconductor-sva
   - ca-certificates
   - certifi
   - openssl


  Package             Version  Build          Channel              Size
─────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────

  + bioconductor-sva   3.46.0  r42h3be46a4_0  bioconda/osx-64     489kB

  Summary:

  Install: 1 packages

  Total download: 489kB

─────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
bioconductor-sva                                   488.8kB @   1.9MB/s  0.3s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge r-ggalt
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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-ggalt']

bioconda/osx-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/osx-64                                                 No change
bioconda/noarch                                      4.2MB @   4.6MB/s  1.0s
pkgs/main/osx-64                                     5.2MB @   4.9MB/s  1.2s
conda-forge/noarch                                  11.7MB @   5.2MB/s  2.5s
conda-forge/osx-64                                  27.6MB @   4.8MB/s  6.4s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - r-ggalt
   - ca-certificates
   - certifi
   - openssl


  Package          Version  Build             Channel                  Size
─────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────

  + proj             9.1.1  hf909084_2        conda-forge/osx-64        3MB
  + r-ash           1.0_15  r42h1e4e481_1007  conda-forge/osx-64       45kB
  + r-crosstalk      1.2.0  r42hc72bb7e_1     conda-forge/noarch      377kB
  + r-extrafont       0.18  r42ha770c72_1     conda-forge/noarch       69kB
  + r-extrafontdb      1.0  r42hc72bb7e_1004  conda-forge/noarch       20kB
  + r-ggalt          0.4.0  r42ha770c72_3     conda-forge/noarch        2MB
  + r-hexbin        1.28.3  r42h1e4e481_0     conda-forge/osx-64        2MB
  + r-htmlwidgets    1.6.2  r42hc72bb7e_0     conda-forge/noarch      424kB
  + r-later          1.3.0  r42hf00d5e6_1     conda-forge/osx-64      116kB
  + r-lazyeval       0.2.2  r42h815d134_3     conda-forge/osx-64      168kB
  + r-maps           3.4.1  r42h815d134_1     conda-forge/osx-64        2MB
  + r-plotly        4.10.1  r42hc72bb7e_0     conda-forge/noarch        3MB
  + r-proj4         1.0_12  r42h2df1cd0_1     conda-forge/osx-64       37kB
  + r-promises     1.2.0.1  r42h49197e3_1     conda-forge/osx-64        2MB
  + r-rttf2pt1      1.3.12  r42h815d134_0     conda-forge/osx-64      109kB
  + sqlite          3.40.0  h9ae0607_0        conda-forge/osx-64     Cached

  Summary:

  Install: 16 packages

  Total download: 15MB

─────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
r-lazyeval                                         167.8kB @   3.0MB/s  0.1s
r-maps                                               2.4MB @  26.6MB/s  0.1s
r-htmlwidgets                                      424.0kB @   4.8MB/s  0.0s
proj                                                 2.6MB @  19.5MB/s  0.0s
r-later                                            115.6kB @ 779.7kB/s  0.1s
r-rttf2pt1                                         108.9kB @ 673.2kB/s  0.2s
r-extrafontdb                                       20.3kB @  65.8kB/s  0.2s
r-ash                                               44.8kB @ 141.7kB/s  0.3s
r-ggalt                                              2.4MB @   7.1MB/s  0.2s
r-proj4                                             37.4kB @ 111.1kB/s  0.2s
r-plotly                                             3.0MB @   8.9MB/s  0.3s
r-extrafont                                         69.0kB @ 164.3kB/s  0.1s
r-crosstalk                                        376.9kB @ 861.5kB/s  0.1s
r-promises                                           1.6MB @   3.5MB/s  0.1s
r-hexbin                                             1.6MB @   3.4MB/s  0.2s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge r-rjson

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-rjson']

pkgs/main/osx-64                                              No change
bioconda/osx-64                                               No change
pkgs/r/noarch                                                 No change
bioconda/noarch                                               No change
pkgs/r/osx-64                                                 No change
pkgs/main/noarch                                              No change
conda-forge/noarch                                  11.7MB @   5.0MB/s  2.6s
conda-forge/osx-64                                  27.6MB @   5.1MB/s  6.1s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - r-rjson
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build          Channel                 Size
───────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────

  + r-rjson   0.2.21  r42h49197e3_2  conda-forge/osx-64     167kB

  Summary:

  Install: 1 packages

  Total download: 167kB

───────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - r-rjson
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build          Channel                 Size
───────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────

  + r-rjson   0.2.21  r42h49197e3_2  conda-forge/osx-64     167kB

  Summary:

  Install: 1 packages

  Total download: 167kB

r-rjson                                            167.4kB @ 341.8kB/s  0.5s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c bioconda bioconductor-rtracklayer

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['bioconductor-rtracklayer']

bioconda/osx-64                                      3.8MB @   4.4MB/s  0.9s
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
bioconda/noarch                                      4.2MB @   4.3MB/s  1.1s
pkgs/r/osx-64                                                 No change
pkgs/main/osx-64                                     5.2MB @   4.8MB/s  1.2s
conda-forge/noarch                                  11.7MB @   4.5MB/s  2.9s
conda-forge/osx-64                                  27.6MB @   5.0MB/s  6.2s

Pinned packages:
  - python 3.11.*


warning  libmamba Invalid package cache, file '/Users/kalavatt/mambaforge/pkgs/r-base-4.2.2-h841e2fe_3/lib/R/doc/html/packages.html' has incorrect size
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/expression_env

  Updating specs:

   - bioconductor-rtracklayer
   - ca-certificates
   - certifi
   - openssl


  Package                           Version  Build               Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────

  + bioconductor-biocio               1.8.0  r42hdfd78af_0       bioconda/noarch         429kB
  + bioconductor-genomicalignments   1.34.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-rhtslib              2.0.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-rsamtools           2.14.0  r42hb890f52_0       bioconda/osx-64        Cached
  + bioconductor-rtracklayer         1.58.0  r42h6e925bd_1       bioconda/osx-64           6MB
  + r-restfulr                       0.0.15  r42h9f1ad2d_1       bioconda/osx-64         440kB

  Change:
────────────────────────────────────────────────────────────────────────────────────────────────

  - krb5                             1.20.1  h049b76e_0          conda-forge
  + krb5                             1.20.1  h0165f36_0          conda-forge/osx-64        1MB
  - libarchive                        3.6.2  h6d8d9f1_0          conda-forge
  + libarchive                        3.6.2  h7181a6f_0          conda-forge/osx-64      728kB
  - libssh2                          1.10.0  h47af595_3          conda-forge
  + libssh2                          1.10.0  h7535e13_3          conda-forge/osx-64     Cached
  - python                           3.11.0  he7542f4_1_cpython  conda-forge
  + python                           3.11.0  h4150a38_1_cpython  conda-forge/osx-64       15MB
  - sigtool                           0.1.3  h88f4db0_0          conda-forge
  + sigtool                           0.1.3  h57ddcff_0          conda-forge/osx-64     Cached

  Downgrade:
────────────────────────────────────────────────────────────────────────────────────────────────

  - cryptography                     39.0.2  py311h61927ef_0     conda-forge
  + cryptography                     39.0.0  py311h8661239_0     conda-forge/osx-64        1MB
  - curl                             7.88.1  h6df9250_0          conda-forge
  + curl                             7.87.0  haf73cf8_0          conda-forge/osx-64      141kB
  - libcurl                          7.88.1  h6df9250_0          conda-forge
  + libcurl                          7.87.0  haf73cf8_0          conda-forge/osx-64      331kB
  - libmamba                          1.3.1  h9d281b0_2          conda-forge
  + libmamba                          1.2.0  h1ca9962_0          conda-forge/osx-64        1MB
  - libmambapy                        1.3.1  py311hcc19a12_2     conda-forge
  + libmambapy                        1.2.0  py311h8020b13_0     conda-forge/osx-64      237kB
  - libnghttp2                       1.52.0  he2ab024_0          conda-forge
  + libnghttp2                       1.51.0  h0dd9d14_0          conda-forge/osx-64      609kB
  - mamba                             1.3.1  py311h8082e30_2     conda-forge
  + mamba                             1.2.0  py311h280fce9_0     conda-forge/osx-64       65kB
  - openssl                           3.1.0  hfd90126_0          conda-forge
  + openssl                          1.1.1t  hfd90126_0          conda-forge/osx-64        2MB
  - r-base                            4.2.3  h841e2fe_0          conda-forge
  + r-base                            4.2.2  h841e2fe_3          conda-forge/osx-64     Cached
  - r-openssl                         2.0.6  r42hfeb9312_0       conda-forge
  + r-openssl                         2.0.5  r42h13d56fc_0       conda-forge/osx-64      626kB

  Summary:

  Install: 6 packages
  Change: 5 packages
  Downgrade: 10 packages

  Total download: 30MB

────────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
libarchive                                         727.7kB @   8.5MB/s  0.1s
openssl                                              1.7MB @  18.6MB/s  0.1s
libnghttp2                                         609.3kB @   6.1MB/s  0.1s
krb5                                                 1.1MB @  10.9MB/s  0.1s
libcurl                                            331.2kB @   2.5MB/s  0.0s
python                                              15.3MB @  50.6MB/s  0.3s
mamba                                               65.4kB @ 215.6kB/s  0.2s
curl                                               141.3kB @ 431.0kB/s  0.0s
libmambapy                                         237.1kB @ 716.2kB/s  0.2s
bioconductor-biocio                                429.4kB @   1.2MB/s  0.3s
r-restfulr                                         440.1kB @ 788.7kB/s  0.2s
r-openssl                                          626.4kB @   1.0MB/s  0.3s
bioconductor-rtracklayer                             5.6MB @   9.1MB/s  0.5s
cryptography                                         1.2MB @   1.7MB/s  0.4s
libmamba                                             1.2MB @   1.5MB/s  0.5s
Preparing transaction: done
Verifying transaction: /
SafetyError: The package for r-base located at /Users/kalavatt/mambaforge/pkgs/r-base-4.2.2-h841e2fe_3
appears to be corrupted. The path 'lib/R/doc/html/packages.html'
has an incorrect size.
  reported size: 3423 bytes
  actual size: 41091 bytes


done
Executing transaction: done
```
</details>
<br />

<a id="add-appropriate-shortcut-to-zaliases-and-bash_aliases"></a>
### Add appropriate shortcut to `.zaliases` and `.bash_aliases`
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Add appropriate shortcut to .zaliases and .bash_aliases</i></summary>

```bash
#!/bin/bash

#  .zaliases
alias expression_env="source activate expression_env"
alias R-expression="(
    source activate expression_env
    open -na /Applications/RStudio.app
)"

#  .bash_aliases
alias expression_env="source activate expression_env"
```
</details>
<br />
<br />

<a id="create-an-environment-for-gff3-processing-gff3_env"></a>
## Create an environment for gff3 processing, `gff3_env`
<a id="get-situated"></a>
### Get situated
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

tmux new -s install
tmux attach -t install
grabnode  # 1, defaults

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

<a id="set-up-gff3_env"></a>
### Set up `gff3_env`
<details>
<summary><i>Need the following packages</i></summary>

- https://anaconda.org/bioconda/agat
- https://anaconda.org/bioconda/gffcompare
- https://anaconda.org/bioconda/subread (`featureCounts`)
- https://anaconda.org/bioconda/htseq (`htseq-count`)
- https://anaconda.org/bioconda/bioconductor-rtracklayer
- https://anaconda.org/bioconda/bioconductor-genomicranges
- https://anaconda.org/conda-forge/markdown
- https://anaconda.org/conda-forge/r-markdown
- https://anaconda.org/conda-forge/r-tidyverse
</details>
<br />

<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Set up gff3_env</i></summary>

```bash
#!/bin/bash

#  Local installation, WorkMac
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
# conda config --set channel_priority strict

create_x86_conda_environment gff3_env

mamba install \
    -c bioconda \
        bioconductor-genomicalignments \
        bioconductor-genomicranges \
        bioconductor-rtracklayer

mamba install \
    -c conda-forge \
        python==3.10 \
        bioconductor-rtracklayer==1.58.0

mamba install \
    -c bioconda \
        gffcompare \
        gffread \
        htseq \
        bioconductor-rtracklayer==1.58.0

mamba install \
    -c conda-forge \
        markdown \
        parallel \
        r-markdown \
        r-tidyverse \
        rename \
        ucsc-liftover \
        bioconductor-rtracklayer==1.58.0

mamba install \
    -c conda-forge \
        r-complexupset \
        bioconductor-rtracklayer==1.58.0

mamba install \
    -c bioconda \
        igv \
        bioconductor-rtracklayer==1.58.0

# mamba create -n gff3_env \
#     --yes \
#     -c bioconda \
#         agat \
#         gffcompare \
#         subread \
#         htseq \
#         bioconductor-rtracklayer \
#         bioconductor-genomicranges
#
# source activate gff3_env
#
# mamba install \
#     --yes \
#     -c conda-forge \
#         markdown \
#         r-markdown \
#         r-tidyverse \
#         bioconductor-rtracklayer==1.58.0
#
# mamba install \
#     --yes \
#     -c conda-forge \
#         parallel \
#         rename \
#         gffread \
#         ucsc-liftover \
#         bioconductor-rtracklayer==1.58.0
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: Set up gff3_env</i></summary>

```txt
❯ create_x86_conda_environment gff3_env
Collecting package metadata (current_repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
  current version: 23.1.0
  latest version: 23.3.1

Please update conda by running

    $ conda update -n base -c conda-forge conda

Or to minimize the number of packages updated during conda update use

     conda install conda=23.3.1



## Package Plan ##

  environment location: /Users/kalavatt/mambaforge/envs/gff3_env



Proceed ([y]/n)? y

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate gff3_env
#
# To deactivate an active environment, use
#
#     $ conda deactivate


❯ mamba install \
>     -c bioconda \
>         bioconductor-genomicalignments \
>         bioconductor-genomicranges \
>         bioconductor-rtracklayer

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['bioconductor-genomicalignments', 'bioconductor-genomicranges', 'bioconductor-rtracklayer']

bioconda/noarch                                               No change
bioconda/osx-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/osx-64                                                 No change
pkgs/main/osx-64                                     5.2MB @   5.3MB/s  1.1s
conda-forge/noarch                                  11.9MB @   2.8MB/s  4.5s
conda-forge/osx-64                                  27.8MB @   5.0MB/s  6.3s
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - bioconductor-genomicalignments
   - bioconductor-genomicranges
   - bioconductor-rtracklayer


  Package                                   Version  Build               Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                                  1.0.1  anacondar_1         conda-forge/noarch     Cached
  + argcomplete                               3.0.5  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + bioconductor-biobase                     2.58.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-biocgenerics                0.44.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-biocio                       1.8.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-biocparallel                1.32.5  r42hb890f52_0       bioconda/osx-64        Cached
  + bioconductor-biostrings                  2.66.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-data-packages             20230202  hdfd78af_0          bioconda/noarch        Cached
  + bioconductor-delayedarray                0.24.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-genomeinfodb                1.34.8  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-genomeinfodbdata             1.2.9  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-genomicalignments           1.34.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-genomicranges               1.50.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-iranges                     2.32.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-matrixgenerics              1.10.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-rhtslib                      2.0.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-rsamtools                   2.14.0  r42hb890f52_0       bioconda/osx-64        Cached
  + bioconductor-rtracklayer                 1.58.0  r42h6e925bd_1       bioconda/osx-64        Cached
  + bioconductor-s4vectors                   0.36.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-summarizedexperiment        1.28.0  r42hdfd78af_0       bioconda/noarch        Cached
  + bioconductor-xvector                     0.38.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bioconductor-zlibbioc                    1.44.0  r42h3be46a4_0       bioconda/osx-64        Cached
  + bwidget                                  1.9.14  h694c41f_1          conda-forge/osx-64     Cached
  + bzip2                                     1.0.8  h0d85af4_4          conda-forge/osx-64     Cached
  + c-ares                                   1.18.1  h0d85af4_0          conda-forge/osx-64     Cached
  + ca-certificates                       2022.12.7  h033912b_0          conda-forge/osx-64     Cached
  + cairo                                    1.16.0  h904041c_1014       conda-forge/osx-64     Cached
  + cctools_osx-64                          973.0.1  h5676edf_13         conda-forge/osx-64     Cached
  + clang                                    16.0.1  h49458c0_0          conda-forge/osx-64     Cached
  + clang-16                                 16.0.1  default_hd25f202_0  conda-forge/osx-64     Cached
  + clang_osx-64                             16.0.1  hac0a0c4_1          conda-forge/osx-64     Cached
  + clangxx                                  16.0.1  default_hd25f202_0  conda-forge/osx-64     Cached
  + clangxx_osx-64                           16.0.1  h950475c_1          conda-forge/osx-64     Cached
  + compiler-rt                              16.0.1  h613da45_0          conda-forge/osx-64     Cached
  + compiler-rt_osx-64                       16.0.1  h613da45_0          conda-forge/noarch     Cached
  + curl                                     7.87.0  haf73cf8_0          conda-forge/osx-64     Cached
  + expat                                     2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + font-ttf-dejavu-sans-mono                  2.37  hab24e00_0          conda-forge/noarch     Cached
  + font-ttf-inconsolata                      3.000  h77eed37_0          conda-forge/noarch     Cached
  + font-ttf-source-code-pro                  2.038  h77eed37_0          conda-forge/noarch     Cached
  + font-ttf-ubuntu                            0.83  hab24e00_0          conda-forge/noarch     Cached
  + fontconfig                               2.14.2  h5bb23bf_0          conda-forge/osx-64     Cached
  + fonts-conda-ecosystem                         1  0                   conda-forge/noarch     Cached
  + fonts-conda-forge                             1  0                   conda-forge/noarch     Cached
  + freetype                                 2.12.1  h3f81eb7_1          conda-forge/osx-64     Cached
  + fribidi                                  1.0.10  hbcb3906_0          conda-forge/osx-64     Cached
  + gettext                                  0.21.1  h8a4c099_0          conda-forge/osx-64     Cached
  + gfortran_impl_osx-64                     11.3.0  h1f927f5_31         conda-forge/osx-64     Cached
  + gfortran_osx-64                          11.3.0  h18f7dce_1          conda-forge/osx-64     Cached
  + gmp                                       6.2.1  h2e338ed_0          conda-forge/osx-64     Cached
  + graphite2                                1.3.13  h2e338ed_1001       conda-forge/osx-64     Cached
  + gsl                                         2.7  h93259b0_0          conda-forge/osx-64     Cached
  + harfbuzz                                  6.0.0  h08f8713_0          conda-forge/osx-64     Cached
  + icu                                        70.1  h96cf925_0          conda-forge/osx-64     Cached
  + isl                                        0.25  hb486fe8_0          conda-forge/osx-64     Cached
  + jpeg                                         9e  hb7f2c08_3          conda-forge/osx-64     Cached
  + jq                                          1.5  0                   bioconda/osx-64        Cached
  + krb5                                     1.20.1  h0165f36_0          conda-forge/osx-64     Cached
  + ld64_osx-64                                 609  hbfe4790_13         conda-forge/osx-64     Cached
  + lerc                                      4.0.0  hb486fe8_0          conda-forge/osx-64     Cached
  + libblas                                   3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libcblas                                  3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libclang-cpp16                           16.0.1  default_hd25f202_0  conda-forge/osx-64     Cached
  + libcurl                                  7.87.0  haf73cf8_0          conda-forge/osx-64     Cached
  + libcxx                                   16.0.1  h71dddab_0          conda-forge/osx-64     Cached
  + libdeflate                                 1.17  hac1461d_0          conda-forge/osx-64     Cached
  + libedit                            3.1.20191231  h0678c8f_2          conda-forge/osx-64     Cached
  + libev                                      4.33  haf1e3a3_1          conda-forge/osx-64     Cached
  + libexpat                                  2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + libffi                                    3.4.2  h0d85af4_5          conda-forge/osx-64     Cached
  + libgcc                                    4.8.5  1                   conda-forge/osx-64     Cached
  + libgfortran                               5.0.0  11_3_0_h97931a8_31  conda-forge/osx-64     Cached
  + libgfortran-devel_osx-64                 11.3.0  h824d247_31         conda-forge/noarch     Cached
  + libgfortran5                             12.2.0  he409387_31         conda-forge/osx-64     Cached
  + libglib                                  2.74.1  h4c723e1_1          conda-forge/osx-64     Cached
  + libiconv                                   1.17  hac89ed1_0          conda-forge/osx-64     Cached
  + liblapack                                 3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libllvm16                                16.0.1  h7001e86_0          conda-forge/osx-64     Cached
  + libnghttp2                               1.51.0  h0dd9d14_0          conda-forge/osx-64     Cached
  + libopenblas                              0.3.21  openmp_h429af6e_3   conda-forge/osx-64     Cached
  + libpng                                   1.6.39  ha978bb4_0          conda-forge/osx-64     Cached
  + libsqlite                                3.40.0  ha978bb4_0          conda-forge/osx-64     Cached
  + libssh2                                  1.10.0  h7535e13_3          conda-forge/osx-64     Cached
  + libtiff                                   4.5.0  hee9004a_2          conda-forge/osx-64     Cached
  + libwebp-base                              1.3.0  hb7f2c08_0          conda-forge/osx-64     Cached
  + libxml2                                  2.10.3  h201ad9d_4          conda-forge/osx-64     Cached
  + libzlib                                  1.2.13  hfd90126_4          conda-forge/osx-64     Cached
  + llvm-openmp                              16.0.1  h61d9ccf_0          conda-forge/osx-64     Cached
  + llvm-tools                               16.0.1  h7001e86_0          conda-forge/osx-64     Cached
  + make                                        4.3  h22f3db7_1          conda-forge/osx-64     Cached
  + mpc                                       1.3.1  h81bd1dd_0          conda-forge/osx-64     Cached
  + mpfr                                      4.2.0  h4f9bd69_0          conda-forge/osx-64     Cached
  + ncurses                                     6.3  h96cf925_1          conda-forge/osx-64     Cached
  + openssl                                  1.1.1t  hfd90126_0          conda-forge/osx-64     Cached
  + pango                                   1.50.14  hbd9bf65_0          conda-forge/osx-64     Cached
  + pcre2                                     10.40  h1c4e4bc_0          conda-forge/osx-64     Cached
  + pip                                      23.0.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pixman                                   0.40.0  hbcb3906_0          conda-forge/osx-64     Cached
  + python                                   3.11.0  h4150a38_1_cpython  conda-forge/osx-64     Cached
  + python_abi                                 3.11  3_cp311             conda-forge/osx-64     Cached
  + pyyaml                                      6.0  py311h5547dcb_5     conda-forge/osx-64     Cached
  + r-base                                    4.2.2  h841e2fe_3          conda-forge/osx-64     Cached
  + r-bh                                   1.81.0_1  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-bitops                                  1.0_7  r42h815d134_1       conda-forge/osx-64     Cached
  + r-codetools                              0.2_19  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-cpp11                                   0.4.3  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-crayon                                  1.5.2  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-formatr                                  1.14  r42hc72bb7e_0       conda-forge/noarch     Cached
  + r-futile.logger                           1.4.3  r42hc72bb7e_1004    conda-forge/noarch     Cached
  + r-futile.options                          1.0.1  r42hc72bb7e_1003    conda-forge/noarch     Cached
  + r-lambda.r                                1.2.4  r42hc72bb7e_2       conda-forge/noarch     Cached
  + r-lattice                                0.21_8  r42h815d134_0       conda-forge/osx-64     Cached
  + r-matrix                                  1.5_4  r42hce01bf1_0       conda-forge/osx-64     Cached
  + r-matrixstats                            0.63.0  r42h815d134_0       conda-forge/osx-64     Cached
  + r-rcurl                               1.98_1.10  r42h815d134_0       conda-forge/osx-64     Cached
  + r-restfulr                               0.0.15  r42h9f1ad2d_1       bioconda/osx-64        Cached
  + r-rjson                                  0.2.21  r42h49197e3_2       conda-forge/osx-64     Cached
  + r-snow                                    0.4_4  r42hc72bb7e_1       conda-forge/noarch     Cached
  + r-xml                                 3.99_0.14  r42h67ce8dc_0       conda-forge/osx-64     Cached
  + r-yaml                                    2.3.7  r42h815d134_0       conda-forge/osx-64     Cached
  + readline                                    8.2  h9e318b2_1          conda-forge/osx-64     Cached
  + setuptools                               67.6.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sigtool                                   0.1.3  h57ddcff_0          conda-forge/osx-64     Cached
  + tapi                                  1100.0.11  h9ce4665_0          conda-forge/osx-64     Cached
  + tk                                       8.6.12  h5dbffcc_0          conda-forge/osx-64     Cached
  + tktable                                    2.10  h49f0cf7_3          conda-forge/osx-64     Cached
  + toml                                     0.10.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tomlkit                                  0.11.7  pyha770c72_0        conda-forge/noarch     Cached
  + typing                                 3.10.0.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tzdata                                    2023c  h71feb2d_0          conda-forge/noarch     Cached
  + wheel                                    0.40.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xmltodict                                0.13.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xz                                        5.2.6  h775f41a_0          conda-forge/osx-64     Cached
  + yaml                                      0.2.5  h0d85af4_2          conda-forge/osx-64     Cached
  + yq                                        3.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + zlib                                     1.2.13  hfd90126_4          conda-forge/osx-64     Cached
  + zstd                                      1.5.2  hbc0c0cd_6          conda-forge/osx-64     Cached

  Summary:

  Install: 137 packages

  Total download: 0 B

────────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install \
>     -c conda-forge \
>         python==3.10 \
>         bioconductor-rtracklayer==1.58.0

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['python==3.10', 'bioconductor-rtracklayer==1.58.0']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/r/osx-64                                                 No change
pkgs/main/osx-64                                              No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - python==3.10
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - openssl


  Package         Version  Build               Channel                  Size
──────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────

  + sqlite         3.40.0  h9ae0607_0          conda-forge/osx-64     Cached

  Change:
──────────────────────────────────────────────────────────────────────────────

  - pyyaml            6.0  py311h5547dcb_5     conda-forge
  + pyyaml            6.0  py310h90acd4f_5     conda-forge/osx-64     Cached

  Reinstall:
──────────────────────────────────────────────────────────────────────────────

  o argcomplete     3.0.5  pyhd8ed1ab_0        conda-forge
  o pip            23.0.1  pyhd8ed1ab_0        conda-forge
  o setuptools     67.6.1  pyhd8ed1ab_0        conda-forge
  o toml           0.10.2  pyhd8ed1ab_0        conda-forge
  o tomlkit        0.11.7  pyha770c72_0        conda-forge
  o typing       3.10.0.0  pyhd8ed1ab_0        conda-forge
  o wheel          0.40.0  pyhd8ed1ab_0        conda-forge
  o xmltodict      0.13.0  pyhd8ed1ab_0        conda-forge
  o yq              3.2.1  pyhd8ed1ab_0        conda-forge

  Downgrade:
──────────────────────────────────────────────────────────────────────────────

  - python         3.11.0  h4150a38_1_cpython  conda-forge
  + python         3.10.0  h1248fe1_3_cpython  conda-forge/osx-64     Cached
  - python_abi       3.11  3_cp311             conda-forge
  + python_abi       3.10  3_cp310             conda-forge/osx-64     Cached

  Summary:

  Install: 1 packages
  Change: 1 packages
  Reinstall: 9 packages
  Downgrade: 2 packages

  Total download: 0 B

──────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install \
>     -c bioconda \
>         gffcompare \
>         gffread \
>         htseq \
>         bioconductor-rtracklayer==1.58.0

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['gffcompare', 'gffread', 'htseq', 'bioconductor-rtracklayer==1.58.0']

bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
pkgs/main/osx-64                                              No change
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
pkgs/main/noarch                                              No change

Pinned packages:
  - python 3.10.*


warning  libmamba Invalid package cache, file '/Users/kalavatt/mambaforge/pkgs/r-base-4.2.2-h6e3643f_2/lib/R/doc/html/packages.html' has incorrect size
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - gffcompare
   - gffread
   - htseq
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - openssl


  Package              Version  Build            Channel                  Size
────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────

  + brotli               1.0.9  hb7f2c08_8       conda-forge/osx-64     Cached
  + brotli-bin           1.0.9  hb7f2c08_8       conda-forge/osx-64     Cached
  + certifi          2022.12.7  pyhd8ed1ab_0     conda-forge/noarch     Cached
  + contourpy            1.0.7  py310ha23aa8a_0  conda-forge/osx-64     Cached
  + cycler              0.11.0  pyhd8ed1ab_0     conda-forge/noarch     Cached
  + fonttools           4.39.3  py310h90acd4f_0  conda-forge/osx-64     Cached
  + gffcompare          0.12.6  hb3ea9af_0       bioconda/osx-64        Cached
  + gffread             0.12.7  h6151dfb_1       bioconda/osx-64        Cached
  + htseq                2.0.2  py310hec0d4ff_0  bioconda/osx-64        Cached
  + kiwisolver           1.4.4  py310ha23aa8a_1  conda-forge/osx-64     Cached
  + lcms2                 2.14  h90f4b2a_0       conda-forge/osx-64     Cached
  + libbrotlicommon      1.0.9  hb7f2c08_8       conda-forge/osx-64     Cached
  + libbrotlidec         1.0.9  hb7f2c08_8       conda-forge/osx-64     Cached
  + libbrotlienc         1.0.9  hb7f2c08_8       conda-forge/osx-64     Cached
  + libxcb                1.13  h0d85af4_1004    conda-forge/osx-64     Cached
  + matplotlib-base      3.7.1  py310he725631_0  conda-forge/osx-64     Cached
  + munkres              1.0.7  py_1             bioconda/noarch        Cached
  + numpy               1.24.2  py310h788a5b3_0  conda-forge/osx-64     Cached
  + openjpeg             2.5.0  h5d0d7b0_1       conda-forge/osx-64     Cached
  + packaging             23.1  pyhd8ed1ab_0     conda-forge/noarch     Cached
  + pillow               9.2.0  py310hffcf78b_3  conda-forge/osx-64     Cached
  + pthread-stubs          0.4  hc929b4f_1001    conda-forge/osx-64     Cached
  + pyparsing            3.0.9  pyhd8ed1ab_0     conda-forge/noarch     Cached
  + pysam               0.20.0  py310h958c131_0  bioconda/osx-64        Cached
  + python-dateutil      2.8.2  pyhd8ed1ab_0     conda-forge/noarch     Cached
  + six                 1.16.0  pyh6c4a22f_0     conda-forge/noarch     Cached
  + unicodedata2        15.0.0  py310h90acd4f_0  conda-forge/osx-64     Cached
  + xorg-libxau          1.0.9  h35c211d_0       conda-forge/osx-64     Cached
  + xorg-libxdmcp        1.1.3  h35c211d_0       conda-forge/osx-64     Cached

  Change:
────────────────────────────────────────────────────────────────────────────────

  - r-base               4.2.2  h841e2fe_3       conda-forge
  + r-base               4.2.2  h6e3643f_2       conda-forge/osx-64     Cached

  Downgrade:
────────────────────────────────────────────────────────────────────────────────

  - libdeflate            1.17  hac1461d_0       conda-forge
  + libdeflate            1.13  h775f41a_0       conda-forge/osx-64     Cached
  - libtiff              4.5.0  hee9004a_2       conda-forge
  + libtiff              4.4.0  h5e0c7b4_3       conda-forge/osx-64     Cached

  Summary:

  Install: 29 packages
  Change: 1 packages
  Downgrade: 2 packages

  Total download: 0 B

────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: \
SafetyError: The package for r-base located at /Users/kalavatt/mambaforge/pkgs/r-base-4.2.2-h6e3643f_2
appears to be corrupted. The path 'lib/R/doc/html/packages.html'
has an incorrect size.
  reported size: 3423 bytes
  actual size: 11533 bytes


done
Executing transaction: done


❯ mamba install \
>     -c conda-forge \
>         markdown \
>         parallel \
>         r-markdown \
>         r-tidyverse \
>         rename \
>         ucsc-liftover \
>         bioconductor-rtracklayer==1.58.0

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['markdown', 'parallel', 'r-markdown', 'r-tidyverse', 'rename', 'ucsc-liftover', 'bioconductor-rtracklayer==1.58.0']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/r/osx-64                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
pkgs/main/osx-64                                              No change

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - markdown
   - parallel
   - r-markdown
   - r-tidyverse
   - rename
   - ucsc-liftover
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - certifi
   - openssl


  Package                Version  Build             Channel                 Size
──────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────

  + importlib-metadata     6.3.0  pyha770c72_0      conda-forge/noarch      25kB
  + libuuid               2.38.1  hb7f2c08_0        conda-forge/osx-64      30kB
  + markdown               3.4.3  pyhd8ed1ab_0      conda-forge/noarch      71kB
  + mysql-connector-c     6.1.11  h0f02589_1007     conda-forge/osx-64       5MB
  + pandoc                 3.1.1  h9d075a6_0        conda-forge/osx-64      15MB
  + parallel            20230322  h694c41f_0        conda-forge/osx-64       2MB
  + perl                  5.32.1  2_h0d85af4_perl5  conda-forge/osx-64      14MB
  + r-askpass                1.1  r42h815d134_3     conda-forge/osx-64      29kB
  + r-assertthat           0.2.1  r42hc72bb7e_3     conda-forge/noarch      73kB
  + r-backports            1.4.1  r42h815d134_1     conda-forge/osx-64     112kB
  + r-base64enc            0.1_3  r42h815d134_1005  conda-forge/osx-64      45kB
  + r-bit                  4.0.5  r42h815d134_0     conda-forge/osx-64       1MB
  + r-bit64                4.0.5  r42h815d134_1     conda-forge/osx-64     545kB
  + r-blob                 1.2.4  r42hc72bb7e_0     conda-forge/noarch      66kB
  + r-broom                1.0.4  r42hc72bb7e_0     conda-forge/noarch       2MB
  + r-bslib                0.4.2  r42hc72bb7e_0     conda-forge/noarch       4MB
  + r-cachem               1.0.7  r42h815d134_0     conda-forge/osx-64      73kB
  + r-callr                3.7.3  r42hc72bb7e_0     conda-forge/noarch     439kB
  + r-cellranger           1.1.0  r42hc72bb7e_1005  conda-forge/noarch     112kB
  + r-cli                  3.6.1  r42h49197e3_0     conda-forge/osx-64       1MB
  + r-clipr                0.8.0  r42hc72bb7e_1     conda-forge/noarch      70kB
  + r-colorspace           2.1_0  r42h815d134_0     conda-forge/osx-64       3MB
  + r-commonmark           1.9.0  r42h815d134_0     conda-forge/osx-64     122kB
  + r-curl                 4.3.3  r42h815d134_1     conda-forge/osx-64     709kB
  + r-data.table          1.14.8  r42h557251b_0     conda-forge/osx-64       2MB
  + r-dbi                  1.1.3  r42hc72bb7e_1     conda-forge/noarch     789kB
  + r-dbplyr               2.3.2  r42hc72bb7e_0     conda-forge/noarch       1MB
  + r-digest              0.6.31  r42h49197e3_0     conda-forge/osx-64     184kB
  + r-dplyr                1.1.1  r42h49197e3_0     conda-forge/osx-64       1MB
  + r-dtplyr               1.3.1  r42hc72bb7e_0     conda-forge/noarch     357kB
  + r-ellipsis             0.3.2  r42h815d134_1     conda-forge/osx-64      42kB
  + r-evaluate              0.20  r42hc72bb7e_0     conda-forge/noarch      87kB
  + r-fansi                1.0.4  r42h815d134_0     conda-forge/osx-64     309kB
  + r-farver               2.1.1  r42h49197e3_1     conda-forge/osx-64       1MB
  + r-fastmap              1.1.1  r42h49197e3_0     conda-forge/osx-64      71kB
  + r-forcats              1.0.0  r42hc72bb7e_0     conda-forge/noarch     424kB
  + r-fs                   1.6.1  r42h49197e3_0     conda-forge/osx-64     276kB
  + r-gargle               1.3.0  r42h785f33e_0     conda-forge/noarch     531kB
  + r-generics             0.1.3  r42hc72bb7e_1     conda-forge/noarch      95kB
  + r-ggplot2              3.4.2  r42hc72bb7e_0     conda-forge/noarch       4MB
  + r-glue                 1.6.2  r42h815d134_1     conda-forge/osx-64     157kB
  + r-googledrive          2.1.0  r42hc72bb7e_0     conda-forge/noarch       1MB
  + r-googlesheets4        1.1.0  r42h785f33e_0     conda-forge/noarch     508kB
  + r-gtable               0.3.3  r42hc72bb7e_0     conda-forge/noarch     221kB
  + r-haven                2.5.2  r42h49197e3_0     conda-forge/osx-64     352kB
  + r-highr                 0.10  r42hc72bb7e_0     conda-forge/noarch      57kB
  + r-hms                  1.1.3  r42hc72bb7e_0     conda-forge/noarch     107kB
  + r-htmltools            0.5.5  r42h49197e3_0     conda-forge/osx-64     353kB
  + r-httr                 1.4.5  r42hc72bb7e_0     conda-forge/noarch     488kB
  + r-ids                  1.0.1  r42hc72bb7e_2     conda-forge/noarch     130kB
  + r-isoband              0.2.7  r42h49197e3_1     conda-forge/osx-64       2MB
  + r-jquerylib            0.1.4  r42hc72bb7e_1     conda-forge/noarch     379kB
  + r-jsonlite             1.8.4  r42h815d134_0     conda-forge/osx-64     629kB
  + r-knitr                 1.42  r42hc72bb7e_1     conda-forge/noarch       1MB
  + r-labeling             0.4.2  r42hc72bb7e_2     conda-forge/noarch      70kB
  + r-lifecycle            1.0.3  r42hc72bb7e_1     conda-forge/noarch     128kB
  + r-lubridate            1.9.2  r42h815d134_1     conda-forge/osx-64     964kB
  + r-magrittr             2.0.3  r42h815d134_1     conda-forge/osx-64     219kB
  + r-markdown               1.6  r42hc72bb7e_0     conda-forge/noarch     179kB
  + r-mass              7.3_58.3  r42h815d134_0     conda-forge/osx-64       1MB
  + r-memoise              2.0.1  r42hc72bb7e_1     conda-forge/noarch      59kB
  + r-mgcv                1.8_42  r42h40f944a_0     conda-forge/osx-64       3MB
  + r-mime                  0.12  r42h815d134_1     conda-forge/osx-64      52kB
  + r-modelr              0.1.11  r42hc72bb7e_0     conda-forge/noarch     221kB
  + r-munsell              0.5.0  r42hc72bb7e_1005  conda-forge/noarch     254kB
  + r-nlme               3.1_162  r42h1e4e481_0     conda-forge/osx-64       2MB
  + r-openssl              2.0.5  r42h13d56fc_0     conda-forge/osx-64     626kB
  + r-pillar               1.9.0  r42hc72bb7e_0     conda-forge/noarch     617kB
  + r-pkgconfig            2.0.3  r42hc72bb7e_2     conda-forge/noarch      27kB
  + r-prettyunits          1.1.1  r42hc72bb7e_2     conda-forge/noarch      43kB
  + r-processx             3.8.0  r42h815d134_0     conda-forge/osx-64     325kB
  + r-progress             1.2.2  r42hc72bb7e_3     conda-forge/noarch      94kB
  + r-ps                   1.7.4  r42h815d134_0     conda-forge/osx-64     304kB
  + r-purrr                1.0.1  r42h815d134_0     conda-forge/osx-64     482kB
  + r-r6                   2.5.1  r42hc72bb7e_1     conda-forge/noarch      93kB
  + r-rappdirs             0.3.3  r42h815d134_1     conda-forge/osx-64      52kB
  + r-rcolorbrewer         1.1_3  r42h785f33e_1     conda-forge/noarch      67kB
  + r-rcpp                1.0.10  r42h49197e3_0     conda-forge/osx-64       2MB
  + r-readr                2.1.4  r42h49197e3_0     conda-forge/osx-64     741kB
  + r-readxl               1.4.2  r42h3ae43e4_0     conda-forge/osx-64     729kB
  + r-rematch              1.0.1  r42hc72bb7e_1005  conda-forge/noarch      21kB
  + r-rematch2             2.1.2  r42hc72bb7e_2     conda-forge/noarch      55kB
  + r-reprex               2.0.2  r42hc72bb7e_1     conda-forge/noarch     511kB
  + r-rlang                1.1.0  r42h49197e3_0     conda-forge/osx-64       2MB
  + r-rmarkdown             2.14  r42h6115d3f_0     pkgs/r/noarch            3MB
  + r-rstudioapi            0.14  r42hc72bb7e_1     conda-forge/noarch     309kB
  + r-rvest                1.0.3  r42hc72bb7e_1     conda-forge/noarch     221kB
  + r-sass                 0.4.5  r42h49197e3_0     conda-forge/osx-64       2MB
  + r-scales               1.2.1  r42hc72bb7e_1     conda-forge/noarch     627kB
  + r-selectr              0.4_2  r42hc72bb7e_2     conda-forge/noarch     474kB
  + r-stringi             1.7.12  r42h7183e51_0     conda-forge/osx-64     856kB
  + r-stringr              1.5.0  r42h785f33e_0     conda-forge/noarch     294kB
  + r-sys                  3.4.1  r42h815d134_0     conda-forge/osx-64      48kB
  + r-tibble               3.2.1  r42h815d134_1     conda-forge/osx-64     609kB
  + r-tidyr                1.3.0  r42h49197e3_0     conda-forge/osx-64       1MB
  + r-tidyselect           1.2.0  r42hbe3e9c8_0     conda-forge/osx-64     222kB
  + r-tidyverse            1.3.2  r42hc72bb7e_1     conda-forge/noarch     448kB
  + r-timechange           0.2.0  r42h49197e3_0     conda-forge/osx-64     181kB
  + r-tinytex               0.44  r42hc72bb7e_0     conda-forge/noarch     142kB
  + r-tzdb                 0.3.0  r42h49197e3_1     conda-forge/osx-64     544kB
  + r-utf8                 1.2.3  r42h815d134_0     conda-forge/osx-64     138kB
  + r-uuid                 1.1_0  r42h815d134_1     conda-forge/osx-64      51kB
  + r-vctrs                0.6.1  r42h49197e3_0     conda-forge/osx-64       1MB
  + r-viridislite          0.4.1  r42hc72bb7e_1     conda-forge/noarch       1MB
  + r-vroom                1.6.1  r42h49197e3_0     conda-forge/osx-64     800kB
  + r-withr                2.5.0  r42hc72bb7e_1     conda-forge/noarch     246kB
  + r-xfun                  0.38  r42h49197e3_0     conda-forge/osx-64     418kB
  + r-xml2                 1.3.3  r42h3576887_2     conda-forge/osx-64     330kB
  + rename                 1.601  hdfd78af_1        bioconda/noarch         13kB
  + ucsc-liftover            377  h516baf0_2        bioconda/osx-64        861kB
  + zipp                  3.15.0  pyhd8ed1ab_0      conda-forge/noarch      17kB

  Summary:

  Install: 111 packages

  Total download: 103MB

──────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
libuuid                                             29.6kB @ 731.2kB/s  0.0s
r-mime                                              51.9kB @   1.2MB/s  0.0s
r-magrittr                                         219.1kB @   4.6MB/s  0.1s
r-backports                                        111.9kB @   1.3MB/s  0.0s
r-jsonlite                                         628.6kB @   7.0MB/s  0.1s
r-base64enc                                         44.6kB @ 373.7kB/s  0.0s
r-rappdirs                                          52.0kB @ 335.7kB/s  0.0s
r-rcpp                                               2.0MB @  10.7MB/s  0.1s
r-digest                                           183.7kB @ 823.6kB/s  0.0s
r-farver                                             1.5MB @   6.0MB/s  0.1s
r-sys                                               48.4kB @ 186.9kB/s  0.0s
mysql-connector-c                                    4.6MB @  17.0MB/s  0.3s
r-xml2                                             329.7kB @   1.2MB/s  0.0s
r-cachem                                            73.4kB @ 258.8kB/s  0.0s
r-pkgconfig                                         26.6kB @  86.2kB/s  0.0s
r-withr                                            245.9kB @ 790.5kB/s  0.0s
r-openssl                                          626.4kB @   2.0MB/s  0.1s
perl                                                14.0MB @  42.7MB/s  0.3s
r-highr                                             57.1kB @ 163.4kB/s  0.0s
r-dbi                                              789.4kB @   2.2MB/s  0.0s
r-lifecycle                                        128.1kB @ 353.9kB/s  0.0s
r-viridislite                                        1.3MB @   3.6MB/s  0.1s
r-httr                                             488.0kB @   1.3MB/s  0.0s
r-jquerylib                                        378.6kB @ 965.3kB/s  0.0s
r-gtable                                           221.3kB @ 557.6kB/s  0.0s
r-gargle                                           531.2kB @   1.3MB/s  0.0s
pandoc                                              14.7MB @  35.7MB/s  0.4s
r-progress                                          94.4kB @ 212.9kB/s  0.0s
r-pillar                                           617.4kB @   1.4MB/s  0.0s
r-sass                                               2.1MB @   4.5MB/s  0.1s
r-vctrs                                              1.3MB @   2.7MB/s  0.1s
r-vroom                                            799.7kB @   1.6MB/s  0.0s
r-cellranger                                       112.2kB @ 227.1kB/s  0.0s
r-bslib                                              4.1MB @   8.2MB/s  0.1s
r-tidyr                                              1.1MB @   2.2MB/s  0.1s
r-dbplyr                                             1.1MB @   2.1MB/s  0.0s
r-xfun                                             417.8kB @ 770.6kB/s  0.0s
r-broom                                              1.8MB @   3.3MB/s  0.1s
r-curl                                             709.0kB @   1.3MB/s  0.0s
r-uuid                                              51.2kB @  89.8kB/s  0.0s
r-ggplot2                                            4.1MB @   7.2MB/s  0.1s
r-timechange                                       181.5kB @ 312.0kB/s  0.0s
r-stringi                                          855.8kB @   1.4MB/s  0.0s
r-ellipsis                                          42.1kB @  68.5kB/s  0.0s
r-mass                                               1.1MB @   1.8MB/s  0.1s
r-nlme                                               2.3MB @   3.7MB/s  0.1s
r-askpass                                           28.5kB @  45.2kB/s  0.0s
r-generics                                          94.5kB @ 147.8kB/s  0.0s
r-rstudioapi                                       308.6kB @ 481.9kB/s  0.0s
r-rcolorbrewer                                      66.9kB @ 103.1kB/s  0.0s
r-tinytex                                          142.4kB @ 217.6kB/s  0.0s
r-memoise                                           59.0kB @  89.3kB/s  0.0s
r-prettyunits                                       43.3kB @  65.1kB/s  0.0s
markdown                                            70.9kB @ 105.4kB/s  0.0s
r-processx                                         325.3kB @ 477.4kB/s  0.0s
r-hms                                              106.7kB @ 156.0kB/s  0.0s
r-purrr                                            482.1kB @ 701.1kB/s  0.0s
r-haven                                            352.2kB @ 507.2kB/s  0.2s
r-tibble                                           609.5kB @ 853.6kB/s  0.0s
r-reprex                                           511.2kB @ 708.3kB/s  0.0s
r-tidyverse                                        448.2kB @ 615.7kB/s  0.0s
r-googledrive                                        1.2MB @   1.6MB/s  0.0s
r-glue                                             157.1kB @ 210.2kB/s  0.0s
r-fs                                               275.8kB @ 365.3kB/s  0.0s
r-rmarkdown                                          2.8MB @   3.7MB/s  0.1s
r-bit                                                1.2MB @   1.5MB/s  0.1s
r-data.table                                         1.9MB @   2.3MB/s  0.1s
parallel                                             1.9MB @   2.3MB/s  0.1s
r-assertthat                                        73.2kB @  90.7kB/s  0.0s
r-ids                                              130.2kB @ 160.4kB/s  0.0s
r-r6                                                92.6kB @ 113.4kB/s  0.1s
r-scales                                           627.1kB @ 758.7kB/s  0.0s
r-blob                                              66.0kB @  79.6kB/s  0.0s
r-googlesheets4                                    507.7kB @ 593.4kB/s  0.0s
r-rvest                                            221.2kB @ 257.2kB/s  0.0s
r-dplyr                                              1.4MB @   1.6MB/s  0.0s
r-htmltools                                        353.0kB @ 407.9kB/s  0.1s
r-commonmark                                       121.7kB @ 138.7kB/s  0.0s
r-utf8                                             138.0kB @ 156.2kB/s  0.0s
r-fastmap                                           70.6kB @  79.6kB/s  0.0s
zipp                                                17.2kB @  19.2kB/s  0.0s
r-rlang                                              1.5MB @   1.7MB/s  0.0s
r-labeling                                          70.0kB @  77.1kB/s  0.0s
r-munsell                                          254.3kB @ 279.8kB/s  0.0s
rename                                              13.4kB @  14.6kB/s  0.0s
r-rematch2                                          54.9kB @  59.3kB/s  0.0s
r-callr                                            439.1kB @ 468.4kB/s  0.0s
r-readr                                            741.0kB @ 786.6kB/s  0.0s
r-ps                                               304.0kB @ 318.6kB/s  0.0s
r-cli                                                1.3MB @   1.3MB/s  0.0s
r-evaluate                                          86.7kB @  90.2kB/s  0.0s
r-bit64                                            544.6kB @ 564.8kB/s  0.0s
r-tidyselect                                       222.0kB @ 226.7kB/s  0.0s
importlib-metadata                                  25.3kB @  25.7kB/s  0.0s
r-forcats                                          424.4kB @ 430.6kB/s  0.0s
r-clipr                                             69.8kB @  69.3kB/s  0.0s
r-isoband                                            1.6MB @   1.6MB/s  0.0s
r-readxl                                           728.8kB @ 708.1kB/s  0.1s
r-knitr                                              1.3MB @   1.3MB/s  0.0s
r-selectr                                          473.9kB @ 455.7kB/s  0.0s
r-tzdb                                             543.9kB @ 516.8kB/s  0.0s
r-modelr                                           220.6kB @ 206.3kB/s  0.0s
r-rematch                                           20.8kB @  19.4kB/s  0.0s
ucsc-liftover                                      860.8kB @ 791.2kB/s  0.1s
r-mgcv                                               3.3MB @   3.0MB/s  0.1s
r-fansi                                            309.1kB @ 281.1kB/s  0.0s
r-markdown                                         178.6kB @ 162.0kB/s  0.0s
r-dtplyr                                           357.4kB @ 322.6kB/s  0.0s
r-stringr                                          294.3kB @ 260.8kB/s  0.0s
r-colorspace                                         2.5MB @   2.2MB/s  0.1s
r-lubridate                                        964.5kB @ 799.1kB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install \
>     -c conda-forge \
>         r-complexupset \
>         bioconductor-rtracklayer==1.58.0

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-complexupset', 'bioconductor-rtracklayer==1.58.0']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/main/noarch                                              No change
pkgs/main/osx-64                                              No change
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - r-complexupset
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - certifi
   - openssl


  Package           Version  Build          Channel                Size
─────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────

  + r-complexupset    1.3.3  r42hc72bb7e_1  conda-forge/noarch      3MB
  + r-patchwork       1.1.2  r42hc72bb7e_1  conda-forge/noarch      3MB

  Summary:

  Install: 2 packages

  Total download: 6MB

─────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
r-patchwork                                          3.3MB @  17.4MB/s  0.2s
r-complexupset                                       2.8MB @   6.8MB/s  0.4s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c bioconda igv bioconductor-rtracklayer==1.58.0

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['igv', 'bioconductor-rtracklayer==1.58.0']

bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
pkgs/main/osx-64                                              No change

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - igv
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build       Channel                 Size
────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────

  + igv       2.13.2  hdfd78af_0  bioconda/noarch         34MB
  + openjdk   17.0.3  hbc0c0cd_6  conda-forge/osx-64     165MB

  Summary:

  Install: 2 packages

  Total download: 200MB

────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
igv                                                 34.1MB @  34.1MB/s  1.0s
openjdk                                            165.4MB @  83.9MB/s  2.0s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c \
>     conda-forge \
>         r-plyr \
>         bioconductor-rtracklayer==1.58.0

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-plyr', 'bioconductor-rtracklayer==1.58.0']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
pkgs/main/osx-64                                              No change

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/gff3_env

  Updating specs:

   - r-plyr
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - certifi
   - openssl


  Package   Version  Build          Channel                 Size
──────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────

  + r-plyr    1.8.8  r42h49197e3_0  conda-forge/osx-64     856kB

  Summary:

  Install: 1 packages

  Total download: 856kB

──────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
r-plyr                                             856.0kB @   3.2MB/s  0.3s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="add-appropriate-shortcut-to-zaliases-and-bash_aliases-1"></a>
### Add appropriate shortcut to `.zaliases` and `.bash_aliases`
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Add appropriate shortcut to .zaliases and .bash_aliases</i></summary>

```bash
#!/bin/bash

#  .zaliases
alias gff3_env="source activate gff3_env"
alias R-gff3="(
    source activate gff3_env
    open -na /Applications/RStudio.app
)"

#  .bash_aliases
alias gff3_env="source activate gff3_env"
```
</details>
<br />
<br />

<a id="create-an-environment-for-running-python-with-spyder"></a>
## Create an environment for running `Python` with `spyder`
<a id="code-8"></a>
### Code
<details>
<summary><i>Code: Create an environment for running Python with spyder</i></summary>

```bash
#!/bin/bash

create_x86_conda_environment spyder_env
# source activate spyder_env

mamba install -c conda-forge spyder numpy
mamba install -c conda-forge pandas
mamba install -c conda-forge nltk  #NOTE Don't need this
mamba install -c conda-forge pipe
```
</details>
<br />

<a id="printed-4"></a>
### Printed
<details>
<summary><i>Printed: </i></summary>

```txt
❯ create_x86_conda_environment spyder_env
Retrieving notices: ...working... done
Collecting package metadata (current_repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
  current version: 23.1.0
  latest version: 23.3.1

Please update conda by running

    $ conda update -n base -c conda-forge conda

Or to minimize the number of packages updated during conda update use

     conda install conda=23.3.1



## Package Plan ##

  environment location: /Users/kalavatt/mambaforge/envs/spyder_env



Proceed ([y]/n)? y

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate spyder_env
#
# To deactivate an active environment, use
#
#     $ conda deactivate


❯ mamba install -c conda-forge spyder numpy

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['spyder', 'numpy']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/r/osx-64                                                 No change
pkgs/r/noarch                                                 No change
pkgs/main/osx-64                                              No change
pkgs/main/noarch                                              No change
Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/spyder_env

  Updating specs:

   - spyder
   - numpy


  Package                               Version  Build               Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────

  + alabaster                            0.7.13  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + applaunchservices                     0.3.0  pyhd8ed1ab_2        conda-forge/noarch     Cached
  + appnope                               0.1.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + arrow                                 1.2.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + astroid                              2.15.3  py311h6eed73b_0     conda-forge/osx-64     Cached
  + asttokens                             2.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + atomicwrites                          1.4.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + attrs                                22.2.0  pyh71513ae_0        conda-forge/noarch     Cached
  + autopep8                              2.0.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + babel                                2.12.1  pyhd8ed1ab_1        conda-forge/noarch     Cached
  + backcall                              0.2.0  pyh9f0ad1d_0        conda-forge/noarch     Cached
  + backports                               1.0  pyhd8ed1ab_3        conda-forge/noarch     Cached
  + backports.functools_lru_cache         1.6.4  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + beautifulsoup4                       4.12.2  pyha770c72_0        conda-forge/noarch     Cached
  + binaryornot                           0.4.4  py_1                conda-forge/noarch     Cached
  + black                                23.3.0  py311h6eed73b_0     conda-forge/osx-64     Cached
  + bleach                                6.0.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + brotlipy                              0.7.0  py311h5547dcb_1005  conda-forge/osx-64     Cached
  + bzip2                                 1.0.8  h0d85af4_4          conda-forge/osx-64     Cached
  + ca-certificates                   2022.12.7  h033912b_0          conda-forge/osx-64     Cached
  + certifi                           2022.12.7  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + cffi                                 1.15.1  py311ha86e640_3     conda-forge/osx-64     Cached
  + chardet                               5.1.0  py311h6eed73b_0     conda-forge/osx-64     Cached
  + charset-normalizer                    3.1.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + click                                 8.1.3  unix_pyhd8ed1ab_2   conda-forge/noarch     Cached
  + cloudpickle                           2.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + colorama                              0.4.6  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + comm                                  0.1.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + cookiecutter                          2.1.1  pyh6c4a22f_0        conda-forge/noarch     Cached
  + cryptography                         40.0.2  py311h61927ef_0     conda-forge/osx-64     Cached
  + debugpy                               1.6.7  py311h814d153_0     conda-forge/osx-64     Cached
  + decorator                             5.1.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + defusedxml                            0.7.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + diff-match-patch                   20200713  pyh9f0ad1d_0        conda-forge/noarch     Cached
  + dill                                  0.3.6  pyhd8ed1ab_1        conda-forge/noarch     Cached
  + docstring-to-markdown                  0.12  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + docutils                               0.19  py311h6eed73b_1     conda-forge/osx-64     Cached
  + entrypoints                             0.4  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + executing                             1.2.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + flake8                                6.0.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + gettext                              0.21.1  h8a4c099_0          conda-forge/osx-64     Cached
  + giflib                                5.2.1  hb7f2c08_3          conda-forge/osx-64     Cached
  + glib                                 2.76.1  hbc0c0cd_0          conda-forge/osx-64     Cached
  + glib-tools                           2.76.1  hbc0c0cd_0          conda-forge/osx-64     Cached
  + gst-plugins-base                     1.22.0  h37e1711_2          conda-forge/osx-64     Cached
  + gstreamer                            1.22.0  h1d18e73_2          conda-forge/osx-64     Cached
  + icu                                    72.1  h7336db1_0          conda-forge/osx-64     Cached
  + idna                                    3.4  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + imagesize                             1.4.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + importlib-metadata                    6.5.0  pyha770c72_0        conda-forge/noarch     Cached
  + importlib_metadata                    6.5.0  hd8ed1ab_0          conda-forge/noarch     Cached
  + importlib_resources                  5.12.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + inflection                            0.5.1  pyh9f0ad1d_0        conda-forge/noarch     Cached
  + intervaltree                          3.0.2  py_0                conda-forge/noarch     Cached
  + ipykernel                            6.22.0  pyh736e0ef_0        conda-forge/noarch     Cached
  + ipython                              8.12.0  pyhd1c38e8_0        conda-forge/noarch     Cached
  + ipython_genutils                      0.2.0  py_1                conda-forge/noarch     Cached
  + isort                                5.12.0  pyhd8ed1ab_1        conda-forge/noarch     Cached
  + jaraco.classes                        3.2.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + jedi                                 0.18.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + jellyfish                             0.9.0  py311h5547dcb_2     conda-forge/osx-64     Cached
  + jinja2                                3.1.2  pyhd8ed1ab_1        conda-forge/noarch     Cached
  + jinja2-time                           0.2.0  pyhd8ed1ab_3        conda-forge/noarch     Cached
  + jsonschema                           4.17.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + jupyter_client                        8.2.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + jupyter_core                          5.3.0  py311h6eed73b_0     conda-forge/osx-64     Cached
  + jupyterlab_pygments                   0.2.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + keyring                             23.13.1  py311h6eed73b_0     conda-forge/osx-64     Cached
  + krb5                                 1.20.1  h049b76e_0          conda-forge/osx-64     Cached
  + lazy-object-proxy                     1.9.0  py311h5547dcb_0     conda-forge/osx-64     Cached
  + lerc                                  4.0.0  hb486fe8_0          conda-forge/osx-64     Cached
  + libblas                               3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libcblas                              3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libclang                             14.0.6  default_h55ffa42_0  conda-forge/osx-64     Cached
  + libclang13                           14.0.6  default_hb5731bd_0  conda-forge/osx-64     Cached
  + libcxx                               16.0.1  h71dddab_0          conda-forge/osx-64     Cached
  + libdeflate                             1.18  hac1461d_0          conda-forge/osx-64     Cached
  + libedit                        3.1.20191231  h0678c8f_2          conda-forge/osx-64     Cached
  + libexpat                              2.5.0  hf0c8a7f_1          conda-forge/osx-64     Cached
  + libffi                                3.4.2  h0d85af4_5          conda-forge/osx-64     Cached
  + libgfortran                           5.0.0  11_3_0_h97931a8_31  conda-forge/osx-64     Cached
  + libgfortran5                         12.2.0  he409387_31         conda-forge/osx-64     Cached
  + libglib                              2.76.1  h4c723e1_0          conda-forge/osx-64     Cached
  + libiconv                               1.17  hac89ed1_0          conda-forge/osx-64     Cached
  + libjpeg-turbo                       2.1.5.1  hb7f2c08_0          conda-forge/osx-64     Cached
  + liblapack                             3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libllvm14                            14.0.6  h5b596cc_1          conda-forge/osx-64     Cached
  + libogg                                1.3.4  h35c211d_1          conda-forge/osx-64     Cached
  + libopenblas                          0.3.21  openmp_h429af6e_3   conda-forge/osx-64     Cached
  + libopus                               1.3.1  hc929b4f_1          conda-forge/osx-64     Cached
  + libpng                               1.6.39  ha978bb4_0          conda-forge/osx-64     Cached
  + libpq                                  15.2  h3640bf0_0          conda-forge/osx-64     Cached
  + libsodium                            1.0.18  hbcb3906_1          conda-forge/osx-64     Cached
  + libspatialindex                       1.9.3  he49afe7_4          conda-forge/osx-64     Cached
  + libsqlite                            3.40.0  ha978bb4_0          conda-forge/osx-64     Cached
  + libtiff                               4.5.0  hedf67fa_6          conda-forge/osx-64     Cached
  + libvorbis                             1.3.7  h046ec9c_0          conda-forge/osx-64     Cached
  + libwebp                               1.3.0  ha9aa8fa_0          conda-forge/osx-64     Cached
  + libwebp-base                          1.3.0  hb7f2c08_0          conda-forge/osx-64     Cached
  + libzlib                              1.2.13  hfd90126_4          conda-forge/osx-64     Cached
  + llvm-openmp                          16.0.1  h61d9ccf_0          conda-forge/osx-64     Cached
  + markupsafe                            2.1.2  py311h5547dcb_0     conda-forge/osx-64     Cached
  + matplotlib-inline                     0.1.6  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + mccabe                                0.7.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + mistune                               2.0.5  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + more-itertools                        9.1.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + mypy_extensions                       1.0.0  pyha770c72_0        conda-forge/noarch     Cached
  + mysql-common                         8.0.32  hc4b2c72_1          conda-forge/osx-64     Cached
  + mysql-libs                           8.0.32  h8658499_1          conda-forge/osx-64     Cached
  + nbclient                              0.7.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + nbconvert                             7.3.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + nbconvert-core                        7.3.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + nbconvert-pandoc                      7.3.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + nbformat                              5.8.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + ncurses                                 6.3  h96cf925_1          conda-forge/osx-64     Cached
  + nest-asyncio                          1.5.6  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + nspr                                   4.35  hea0b92c_0          conda-forge/osx-64     Cached
  + nss                                    3.89  h78b00b3_0          conda-forge/osx-64     Cached
  + numpy                                1.24.2  py311ha9d2c9f_0     conda-forge/osx-64        8MB
  + numpydoc                              1.5.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + openssl                               3.1.0  hfd90126_0          conda-forge/osx-64     Cached
  + packaging                              23.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pandoc                               2.19.2  h694c41f_2          conda-forge/osx-64     Cached
  + pandocfilters                         1.5.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + parso                                 0.8.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pathspec                             0.11.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pcre2                                 10.40  h1c4e4bc_0          conda-forge/osx-64     Cached
  + pexpect                               4.8.0  pyh1a96a4e_2        conda-forge/noarch     Cached
  + pickleshare                           0.7.5  py_1003             conda-forge/noarch     Cached
  + pip                                    23.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pkgutil-resolve-name                 1.3.10  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + platformdirs                          3.2.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pluggy                                1.0.0  pyhd8ed1ab_5        conda-forge/noarch     Cached
  + ply                                    3.11  py_1                conda-forge/noarch     Cached
  + prompt-toolkit                       3.0.38  pyha770c72_0        conda-forge/noarch     Cached
  + prompt_toolkit                       3.0.38  hd8ed1ab_0          conda-forge/noarch     Cached
  + psutil                                5.9.5  py311h5547dcb_0     conda-forge/osx-64     Cached
  + ptyprocess                            0.7.0  pyhd3deb0d_0        conda-forge/noarch     Cached
  + pure_eval                             0.2.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pycodestyle                          2.10.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pycparser                              2.21  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pydocstyle                            6.3.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pyflakes                              3.0.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pygments                             2.15.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pylint                               2.17.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pylint-venv                           3.0.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pyls-spyder                           0.4.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pyobjc-core                           9.1.1  py311hfd07503_0     conda-forge/osx-64     Cached
  + pyobjc-framework-cocoa                  9.1  py311hfd07503_0     conda-forge/osx-64     Cached
  + pyobjc-framework-coreservices           9.0  py311h5547dcb_0     conda-forge/osx-64     Cached
  + pyobjc-framework-fsevents               9.1  py311h6eed73b_0     conda-forge/osx-64     Cached
  + pyopenssl                            23.1.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pyqt                                 5.15.7  py311h8771221_3     conda-forge/osx-64     Cached
  + pyqt5-sip                           12.11.0  py311h78fa98d_3     conda-forge/osx-64     Cached
  + pyqtwebengine                        5.15.7  py311heb9b8d8_3     conda-forge/osx-64     Cached
  + pyrsistent                           0.19.3  py311h5547dcb_0     conda-forge/osx-64     Cached
  + pysocks                               1.7.1  pyha2e5f31_6        conda-forge/noarch     Cached
  + python                               3.11.3  h99528f9_0_cpython  conda-forge/osx-64     Cached
  + python-dateutil                       2.8.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python-fastjsonschema                2.16.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python-lsp-black                      1.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python-lsp-jsonrpc                    1.0.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python-lsp-server                     1.7.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python-lsp-server-base                1.7.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + python-slugify                        8.0.1  pyhd8ed1ab_1        conda-forge/noarch     Cached
  + python.app                              1.4  py311h5547dcb_1     conda-forge/osx-64     Cached
  + python_abi                             3.11  3_cp311             conda-forge/osx-64     Cached
  + pytoolconfig                          1.2.5  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pytz                                 2023.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + pyyaml                                  6.0  py311h5547dcb_5     conda-forge/osx-64     Cached
  + pyzmq                                25.0.2  py311habfacb3_0     conda-forge/osx-64     Cached
  + qdarkstyle                              3.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + qstylizer                             0.2.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + qt-main                              5.15.8  h0afe88e_9          conda-forge/osx-64     Cached
  + qt-webengine                         5.15.8  h84e7aee_0          conda-forge/osx-64     Cached
  + qtawesome                             1.2.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + qtconsole                             5.4.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + qtconsole-base                        5.4.2  pyha770c72_0        conda-forge/noarch     Cached
  + qtpy                                  2.3.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + readline                                8.2  h9e318b2_1          conda-forge/osx-64     Cached
  + requests                             2.28.2  pyhd8ed1ab_1        conda-forge/noarch     Cached
  + rope                                  1.7.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + rtree                                 1.0.1  py311hbc1f44b_1     conda-forge/osx-64     Cached
  + setuptools                           67.6.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sip                                   6.7.8  py311h814d153_0     conda-forge/osx-64     Cached
  + six                                  1.16.0  pyh6c4a22f_0        conda-forge/noarch     Cached
  + snowballstemmer                       2.2.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sortedcontainers                      2.4.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + soupsieve                       2.3.2.post1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sphinx                                6.1.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sphinxcontrib-applehelp               1.0.4  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sphinxcontrib-devhelp                 1.0.2  py_0                conda-forge/noarch     Cached
  + sphinxcontrib-htmlhelp                2.0.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + sphinxcontrib-jsmath                  1.0.1  py_0                conda-forge/noarch     Cached
  + sphinxcontrib-qthelp                  1.0.3  py_0                conda-forge/noarch     Cached
  + sphinxcontrib-serializinghtml         1.1.5  pyhd8ed1ab_2        conda-forge/noarch     Cached
  + spyder                                5.4.3  py311h6eed73b_0     conda-forge/osx-64     Cached
  + spyder-kernels                        2.4.3  unix_pyhd8ed1ab_0   conda-forge/noarch     Cached
  + stack_data                            0.6.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + text-unidecode                          1.3  py_0                conda-forge/noarch     Cached
  + textdistance                          4.5.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + three-merge                           0.1.1  pyh9f0ad1d_0        conda-forge/noarch     Cached
  + tinycss2                              1.2.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tk                                   8.6.12  h5dbffcc_0          conda-forge/osx-64     Cached
  + toml                                 0.10.2  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tomli                                 2.0.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + tomlkit                              0.11.7  pyha770c72_0        conda-forge/noarch     Cached
  + tornado                                 6.3  py311h5547dcb_0     conda-forge/osx-64     Cached
  + traitlets                             5.9.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + typing                             3.10.0.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + typing-extensions                     4.5.0  hd8ed1ab_0          conda-forge/noarch     Cached
  + typing_extensions                     4.5.0  pyha770c72_0        conda-forge/noarch     Cached
  + tzdata                                2023c  h71feb2d_0          conda-forge/noarch     Cached
  + ujson                                 5.7.0  py311h814d153_0     conda-forge/osx-64     Cached
  + unidecode                             1.3.6  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + urllib3                             1.26.15  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + watchdog                              3.0.0  py311h6fddac2_0     conda-forge/osx-64     Cached
  + wcwidth                               0.2.6  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + webencodings                          0.5.1  py_1                conda-forge/noarch     Cached
  + whatthepatch                          1.0.4  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + wheel                                0.40.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + wrapt                                1.15.0  py311h5547dcb_0     conda-forge/osx-64     Cached
  + wurlitzer                             3.0.3  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xz                                    5.2.6  h775f41a_0          conda-forge/osx-64     Cached
  + yaml                                  0.2.5  h0d85af4_2          conda-forge/osx-64     Cached
  + yapf                                 0.32.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + zeromq                                4.3.4  he49afe7_1          conda-forge/osx-64     Cached
  + zipp                                 3.15.0  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + zstd                                  1.5.2  hbc0c0cd_6          conda-forge/osx-64     Cached

  Summary:

  Install: 229 packages

  Total download: 8MB

────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
numpy                                                7.5MB @  33.7MB/s  0.2s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge pandas

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['pandas']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                             Using cache
bioconda/noarch                                             Using cache
pkgs/main/osx-64                                              No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/osx-64                                                 No change

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/spyder_env

  Updating specs:

   - pandas
   - ca-certificates
   - certifi
   - openssl


  Package          Version  Build            Channel                 Size
───────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────

  + pandas           2.0.0  py311hd84f3f5_0  conda-forge/osx-64      14MB
  + python-tzdata   2023.3  pyhd8ed1ab_0     conda-forge/noarch     143kB

  Summary:

  Install: 2 packages

  Total download: 14MB

───────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
python-tzdata                                      143.1kB @   2.5MB/s  0.1s
pandas                                              14.1MB @  74.7MB/s  0.2s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge nltk

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['nltk']

bioconda/osx-64                                               No change
pkgs/main/osx-64                                              No change
bioconda/noarch                                               No change
pkgs/main/noarch                                              No change
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
conda-forge/noarch                                  11.9MB @   4.2MB/s  3.1s
conda-forge/osx-64                                  27.9MB @   4.9MB/s  6.3s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/spyder_env

  Updating specs:

   - nltk
   - ca-certificates
   - certifi
   - openssl


  Package     Version  Build            Channel                  Size
───────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────

  + joblib      1.2.0  pyhd8ed1ab_0     conda-forge/noarch      210kB
  + nltk        3.8.1  pyhd8ed1ab_0     conda-forge/noarch        1MB
  + regex   2023.3.23  py311h5547dcb_0  conda-forge/osx-64      372kB
  + tqdm       4.65.0  pyhd8ed1ab_1     conda-forge/noarch     Cached

  Summary:

  Install: 4 packages

  Total download: 2MB

───────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
joblib                                             210.0kB @   1.3MB/s  0.2s
nltk                                                 1.1MB @   6.0MB/s  0.2s
regex                                              372.0kB @   1.9MB/s  0.2s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge pipe

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

        mamba (1.4.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['pipe']

bioconda/osx-64                                      3.8MB @   4.1MB/s  1.0s
bioconda/noarch                                      4.2MB @   4.0MB/s  1.1s
pkgs/main/osx-64                                     5.3MB @   4.5MB/s  1.3s
pkgs/r/noarch                                                 No change
pkgs/r/osx-64                                                 No change
pkgs/main/noarch                                              No change
conda-forge/noarch                                  12.0MB @   4.5MB/s  2.9s
conda-forge/osx-64                                  27.9MB @   4.5MB/s  6.9s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/spyder_env

  Updating specs:

   - pipe
   - ca-certificates
   - certifi
   - openssl


  Package  Version  Build         Channel                Size
───────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────

  + pipe       2.0  pyhd8ed1ab_0  conda-forge/noarch     13kB

  Summary:

  Install: 1 packages

  Total download: 13kB

───────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
pipe                                                12.7kB @ 102.7kB/s  0.1s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />
