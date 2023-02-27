
`work_env-building.md`
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
