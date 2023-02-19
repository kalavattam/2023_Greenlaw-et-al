
`work_count_features.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Set up environment for normalization, etc. analyses](#set-up-environment-for-normalization-etc-analyses)
    1. [Get situated, make directory for `featureCounts` work, etc.](#get-situated-make-directory-for-featurecounts-work-etc)
        1. [Code](#code)
    1. [Install `featureCounts` in `Trinity_env`](#install-featurecounts-in-trinity_env)
        1. [Code](#code-1)
        1. [Printed](#printed)
    1. [Create a new environment for normalization work, install programs, etc.](#create-a-new-environment-for-normalization-work-install-programs-etc)
        1. [Create a new environment, install featureCounts, tidyverse, DESeq2, EnhancedVolcano, etc.](#create-a-new-environment-install-featurecounts-tidyverse-deseq2-enhancedvolcano-etc)
            1. [Code](#code-2)
            1. [Printed](#printed-1)
1. [Name TBD](#name-tbd)
    1. [Symlink to datasets](#symlink-to-datasets)
        1. [Code](#code-3)
1. [Run featureCounts](#run-featurecounts)
    1. [Test to determine option for featureCounts -s; results in an error](#test-to-determine-option-for-featurecounts--s-results-in-an-error)
        1. [Code](#code-4)
        1. [Printed](#printed-2)
    1. [Convert the gff3 to "SAF" format](#convert-the-gff3-to-saf-format)
        1. [Code](#code-5)
        1. [Printed](#printed-3)
    1. [Test to determine option for featureCounts -s using the .saf file](#test-to-determine-option-for-featurecounts--s-using-the-saf-file)
        1. [Code](#code-6)
        1. [Printed](#printed-4)
    1. [Test to determine option for featureCounts -s with -g "ID" \(#CORRECT\)](#test-to-determine-option-for-featurecounts--s-with--g-id-correct)
        1. [Code](#code-7)
        1. [Printed](#printed-5)
    1. [Clean up](#clean-up)
        1. [Code](#code-8)
1. [Run featureCounts on all bams](#run-featurecounts-on-all-bams)
    1. [Code](#code-9)

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
### Install `featureCounts` in `Trinity_env`
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
<a id="create-a-new-environment-install-featurecounts-tidyverse-deseq2-enhancedvolcano-etc"></a>
#### Create a new environment, install featureCounts, tidyverse, DESeq2, EnhancedVolcano, etc.
<a id="code-2"></a>
##### Code
<details>
<summary><i>Code: Create a new environment, install featureCounts, tidyverse, DESeq2, EnhancedVolcano, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

conda create \
    -n expression_env \
    -c conda-forge \
        r-base=4.0.5 \
        r-tidyverse \
        mamba

mamba install -c bioconda subread

mamba install -c conda-forge r-futile.logger=1.4.3=r42hc72bb7e_1004

mamba search -c bioconda bioconductor-genomeinfodbdata

mamba install -c bioconda bioconductor-deseq2=1.38.0=r42hc247a5b_0

source activate expression_env
```
</details>
<br />

<a id="printed-1"></a>
##### Printed
<details>
<summary><i>Printed: Create a new environment, install featureCounts, tidyverse, DESeq2, EnhancedVolcano, etc.</i></summary>

```txt
❯ conda create \
>     -n expression_env \
>     -c conda-forge \
>         r-tidyverse \
>         mamba
Collecting package metadata (current_repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
  current version: 22.11.1
  latest version: 23.1.0

Please update conda by running

    $ conda update -n base -c defaults conda

Or to minimize the number of packages updated during conda update use

     conda install conda=23.1.0



## Package Plan ##

  environment location: /home/kalavatt/miniconda3/envs/expression_env

  added / updated specs:
    - mamba
    - r-tidyverse


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    cryptography-39.0.1        |  py311h9b4c7bb_0         1.4 MB  conda-forge
    curl-7.88.0                |       hdc1c0ab_0          86 KB  conda-forge
    jpeg-9e                    |       h0b41bf4_3         235 KB  conda-forge
    libcurl-7.88.0             |       hdc1c0ab_0         350 KB  conda-forge
    libmamba-1.3.1             |       hcea66bb_1         1.4 MB  conda-forge
    libmambapy-1.3.1           |  py311h1f88262_1         261 KB  conda-forge
    mamba-1.3.1                |  py311h3072747_1          63 KB  conda-forge
    openssl-3.0.8              |       h0b41bf4_0         2.5 MB  conda-forge
    pip-23.0.1                 |     pyhd8ed1ab_0         1.3 MB  conda-forge
    r-data.table-1.14.8        |    r42h133d619_0         1.8 MB  conda-forge
    r-fs-1.6.1                 |    r42h38f115c_0         482 KB  conda-forge
    r-ggplot2-3.4.1            |    r42hc72bb7e_0         3.9 MB  conda-forge
    r-readr-2.1.4              |    r42h38f115c_0         793 KB  conda-forge
    r-readxl-1.4.2             |    r42h81ef4d7_0         739 KB  conda-forge
    setuptools-67.3.2          |     pyhd8ed1ab_0         565 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        15.8 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu
  _r-mutex           conda-forge/noarch::_r-mutex-1.0.1-anacondar_1
  binutils_impl_lin~ conda-forge/linux-64::binutils_impl_linux-64-2.40-hf600244_0
  brotlipy           conda-forge/linux-64::brotlipy-0.7.0-py311hd4cff14_1005
  bwidget            conda-forge/linux-64::bwidget-1.9.14-ha770c72_1
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h7f98852_4
  c-ares             conda-forge/linux-64::c-ares-1.18.1-h7f98852_0
  ca-certificates    conda-forge/linux-64::ca-certificates-2022.12.7-ha878542_0
  cairo              conda-forge/linux-64::cairo-1.16.0-ha61ee94_1014
  certifi            conda-forge/noarch::certifi-2022.12.7-pyhd8ed1ab_0
  cffi               conda-forge/linux-64::cffi-1.15.1-py311h409f033_3
  charset-normalizer conda-forge/noarch::charset-normalizer-2.1.1-pyhd8ed1ab_0
  colorama           conda-forge/noarch::colorama-0.4.6-pyhd8ed1ab_0
  conda              conda-forge/linux-64::conda-22.11.1-py311h38be061_1
  conda-package-han~ conda-forge/noarch::conda-package-handling-2.0.2-pyh38be061_0
  conda-package-str~ conda-forge/noarch::conda-package-streaming-0.7.0-pyhd8ed1ab_1
  cryptography       conda-forge/linux-64::cryptography-39.0.1-py311h9b4c7bb_0
  curl               conda-forge/linux-64::curl-7.88.0-hdc1c0ab_0
  expat              conda-forge/linux-64::expat-2.5.0-h27087fc_0
  fmt                conda-forge/linux-64::fmt-9.1.0-h924138e_0
  font-ttf-dejavu-s~ conda-forge/noarch::font-ttf-dejavu-sans-mono-2.37-hab24e00_0
  font-ttf-inconsol~ conda-forge/noarch::font-ttf-inconsolata-3.000-h77eed37_0
  font-ttf-source-c~ conda-forge/noarch::font-ttf-source-code-pro-2.038-h77eed37_0
  font-ttf-ubuntu    conda-forge/noarch::font-ttf-ubuntu-0.83-hab24e00_0
  fontconfig         conda-forge/linux-64::fontconfig-2.14.2-h14ed4e7_0
  fonts-conda-ecosy~ conda-forge/noarch::fonts-conda-ecosystem-1-0
  fonts-conda-forge  conda-forge/noarch::fonts-conda-forge-1-0
  freetype           conda-forge/linux-64::freetype-2.12.1-hca18f0e_1
  fribidi            conda-forge/linux-64::fribidi-1.0.10-h36c2ea0_0
  gcc_impl_linux-64  conda-forge/linux-64::gcc_impl_linux-64-12.2.0-hcc96c02_19
  gettext            conda-forge/linux-64::gettext-0.21.1-h27087fc_0
  gfortran_impl_lin~ conda-forge/linux-64::gfortran_impl_linux-64-12.2.0-h55be85b_19
  graphite2          conda-forge/linux-64::graphite2-1.3.13-h58526e2_1001
  gsl                conda-forge/linux-64::gsl-2.7-he838d99_0
  gxx_impl_linux-64  conda-forge/linux-64::gxx_impl_linux-64-12.2.0-hcc96c02_19
  harfbuzz           conda-forge/linux-64::harfbuzz-6.0.0-h8e241bc_0
  icu                conda-forge/linux-64::icu-70.1-h27087fc_0
  idna               conda-forge/noarch::idna-3.4-pyhd8ed1ab_0
  jpeg               conda-forge/linux-64::jpeg-9e-h0b41bf4_3
  kernel-headers_li~ conda-forge/noarch::kernel-headers_linux-64-2.6.32-he073ed8_15
  keyutils           conda-forge/linux-64::keyutils-1.6.1-h166bdaf_0
  krb5               conda-forge/linux-64::krb5-1.20.1-h81ceb04_0
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-h41732ed_0
  lerc               conda-forge/linux-64::lerc-4.0.0-h27087fc_0
  libarchive         conda-forge/linux-64::libarchive-3.6.2-h3d51595_0
  libblas            conda-forge/linux-64::libblas-3.9.0-16_linux64_openblas
  libcblas           conda-forge/linux-64::libcblas-3.9.0-16_linux64_openblas
  libcurl            conda-forge/linux-64::libcurl-7.88.0-hdc1c0ab_0
  libdeflate         conda-forge/linux-64::libdeflate-1.17-h0b41bf4_0
  libedit            conda-forge/linux-64::libedit-3.1.20191231-he28a2e2_2
  libev              conda-forge/linux-64::libev-4.33-h516909a_1
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5
  libgcc-devel_linu~ conda-forge/linux-64::libgcc-devel_linux-64-12.2.0-h3b97bd3_19
  libgcc-ng          conda-forge/linux-64::libgcc-ng-12.2.0-h65d4601_19
  libgfortran-ng     conda-forge/linux-64::libgfortran-ng-12.2.0-h69a702a_19
  libgfortran5       conda-forge/linux-64::libgfortran5-12.2.0-h337968e_19
  libglib            conda-forge/linux-64::libglib-2.74.1-h606061b_1
  libgomp            conda-forge/linux-64::libgomp-12.2.0-h65d4601_19
  libiconv           conda-forge/linux-64::libiconv-1.17-h166bdaf_0
  liblapack          conda-forge/linux-64::liblapack-3.9.0-16_linux64_openblas
  libmamba           conda-forge/linux-64::libmamba-1.3.1-hcea66bb_1
  libmambapy         conda-forge/linux-64::libmambapy-1.3.1-py311h1f88262_1
  libnghttp2         conda-forge/linux-64::libnghttp2-1.51.0-hff17c54_0
  libnsl             conda-forge/linux-64::libnsl-2.0.0-h7f98852_0
  libopenblas        conda-forge/linux-64::libopenblas-0.3.21-pthreads_h78a6416_3
  libpng             conda-forge/linux-64::libpng-1.6.39-h753d276_0
  libsanitizer       conda-forge/linux-64::libsanitizer-12.2.0-h46fd767_19
  libsolv            conda-forge/linux-64::libsolv-0.7.23-h3eb15da_0
  libsqlite          conda-forge/linux-64::libsqlite-3.40.0-h753d276_0
  libssh2            conda-forge/linux-64::libssh2-1.10.0-hf14f497_3
  libstdcxx-devel_l~ conda-forge/linux-64::libstdcxx-devel_linux-64-12.2.0-h3b97bd3_19
  libstdcxx-ng       conda-forge/linux-64::libstdcxx-ng-12.2.0-h46fd767_19
  libtiff            conda-forge/linux-64::libtiff-4.5.0-h6adf6a1_2
  libuuid            conda-forge/linux-64::libuuid-2.32.1-h7f98852_1000
  libwebp-base       conda-forge/linux-64::libwebp-base-1.2.4-h166bdaf_0
  libxcb             conda-forge/linux-64::libxcb-1.13-h7f98852_1004
  libxml2            conda-forge/linux-64::libxml2-2.10.3-h7463322_0
  libzlib            conda-forge/linux-64::libzlib-1.2.13-h166bdaf_4
  lz4-c              conda-forge/linux-64::lz4-c-1.9.4-hcb278e6_0
  lzo                conda-forge/linux-64::lzo-2.10-h516909a_1000
  make               conda-forge/linux-64::make-4.3-hd18ef5c_1
  mamba              conda-forge/linux-64::mamba-1.3.1-py311h3072747_1
  ncurses            conda-forge/linux-64::ncurses-6.3-h27087fc_1
  openssl            conda-forge/linux-64::openssl-3.0.8-h0b41bf4_0
  pandoc             conda-forge/linux-64::pandoc-2.19.2-h32600fe_1
  pango              conda-forge/linux-64::pango-1.50.12-hd33c08f_1
  pcre2              conda-forge/linux-64::pcre2-10.40-hc3806b6_0
  pip                conda-forge/noarch::pip-23.0.1-pyhd8ed1ab_0
  pixman             conda-forge/linux-64::pixman-0.40.0-h36c2ea0_0
  pluggy             conda-forge/noarch::pluggy-1.0.0-pyhd8ed1ab_5
  pthread-stubs      conda-forge/linux-64::pthread-stubs-0.4-h36c2ea0_1001
  pybind11-abi       conda-forge/noarch::pybind11-abi-4-hd8ed1ab_3
  pycosat            conda-forge/linux-64::pycosat-0.6.4-py311hd4cff14_1
  pycparser          conda-forge/noarch::pycparser-2.21-pyhd8ed1ab_0
  pyopenssl          conda-forge/noarch::pyopenssl-23.0.0-pyhd8ed1ab_0
  pysocks            conda-forge/noarch::pysocks-1.7.1-pyha2e5f31_6
  python             conda-forge/linux-64::python-3.11.0-he550d4f_1_cpython
  python_abi         conda-forge/linux-64::python_abi-3.11-3_cp311
  r-askpass          conda-forge/linux-64::r-askpass-1.1-r42h06615bd_3
  r-assertthat       conda-forge/noarch::r-assertthat-0.2.1-r42hc72bb7e_3
  r-backports        conda-forge/linux-64::r-backports-1.4.1-r42h06615bd_1
  r-base             conda-forge/linux-64::r-base-4.2.2-ha7d60f8_3
  r-base64enc        conda-forge/linux-64::r-base64enc-0.1_3-r42h06615bd_1005
  r-bit              conda-forge/linux-64::r-bit-4.0.5-r42h06615bd_0
  r-bit64            conda-forge/linux-64::r-bit64-4.0.5-r42h06615bd_1
  r-blob             conda-forge/noarch::r-blob-1.2.3-r42hc72bb7e_1
  r-broom            conda-forge/noarch::r-broom-1.0.3-r42hc72bb7e_0
  r-bslib            conda-forge/noarch::r-bslib-0.4.2-r42hc72bb7e_0
  r-cachem           conda-forge/linux-64::r-cachem-1.0.6-r42h06615bd_1
  r-callr            conda-forge/noarch::r-callr-3.7.3-r42hc72bb7e_0
  r-cellranger       conda-forge/noarch::r-cellranger-1.1.0-r42hc72bb7e_1005
  r-cli              conda-forge/linux-64::r-cli-3.6.0-r42h38f115c_0
  r-clipr            conda-forge/noarch::r-clipr-0.8.0-r42hc72bb7e_1
  r-colorspace       conda-forge/linux-64::r-colorspace-2.1_0-r42h133d619_0
  r-cpp11            conda-forge/noarch::r-cpp11-0.4.3-r42hc72bb7e_0
  r-crayon           conda-forge/noarch::r-crayon-1.5.2-r42hc72bb7e_1
  r-curl             conda-forge/linux-64::r-curl-4.3.3-r42h06615bd_1
  r-data.table       conda-forge/linux-64::r-data.table-1.14.8-r42h133d619_0
  r-dbi              conda-forge/noarch::r-dbi-1.1.3-r42hc72bb7e_1
  r-dbplyr           conda-forge/noarch::r-dbplyr-2.3.0-r42hc72bb7e_0
  r-digest           conda-forge/linux-64::r-digest-0.6.31-r42h38f115c_0
  r-dplyr            conda-forge/linux-64::r-dplyr-1.1.0-r42h38f115c_0
  r-dtplyr           conda-forge/noarch::r-dtplyr-1.2.2-r42hc72bb7e_2
  r-ellipsis         conda-forge/linux-64::r-ellipsis-0.3.2-r42h06615bd_1
  r-evaluate         conda-forge/noarch::r-evaluate-0.20-r42hc72bb7e_0
  r-fansi            conda-forge/linux-64::r-fansi-1.0.4-r42h133d619_0
  r-farver           conda-forge/linux-64::r-farver-2.1.1-r42h7525677_1
  r-fastmap          conda-forge/linux-64::r-fastmap-1.1.0-r42h7525677_1
  r-forcats          conda-forge/noarch::r-forcats-1.0.0-r42hc72bb7e_0
  r-fs               conda-forge/linux-64::r-fs-1.6.1-r42h38f115c_0
  r-gargle           conda-forge/noarch::r-gargle-1.3.0-r42h785f33e_0
  r-generics         conda-forge/noarch::r-generics-0.1.3-r42hc72bb7e_1
  r-ggplot2          conda-forge/noarch::r-ggplot2-3.4.1-r42hc72bb7e_0
  r-glue             conda-forge/linux-64::r-glue-1.6.2-r42h06615bd_1
  r-googledrive      conda-forge/noarch::r-googledrive-2.0.0-r42hc72bb7e_1
  r-googlesheets4    conda-forge/noarch::r-googlesheets4-1.0.1-r42h785f33e_1
  r-gtable           conda-forge/noarch::r-gtable-0.3.1-r42hc72bb7e_1
  r-haven            conda-forge/linux-64::r-haven-2.5.1-r42h7525677_0
  r-highr            conda-forge/noarch::r-highr-0.10-r42hc72bb7e_0
  r-hms              conda-forge/noarch::r-hms-1.1.2-r42hc72bb7e_1
  r-htmltools        conda-forge/linux-64::r-htmltools-0.5.4-r42h38f115c_0
  r-httr             conda-forge/noarch::r-httr-1.4.4-r42hc72bb7e_1
  r-ids              conda-forge/noarch::r-ids-1.0.1-r42hc72bb7e_2
  r-isoband          conda-forge/linux-64::r-isoband-0.2.7-r42h38f115c_1
  r-jquerylib        conda-forge/noarch::r-jquerylib-0.1.4-r42hc72bb7e_1
  r-jsonlite         conda-forge/linux-64::r-jsonlite-1.8.4-r42h133d619_0
  r-knitr            conda-forge/noarch::r-knitr-1.42-r42hc72bb7e_1
  r-labeling         conda-forge/noarch::r-labeling-0.4.2-r42hc72bb7e_2
  r-lattice          conda-forge/linux-64::r-lattice-0.20_45-r42h06615bd_1
  r-lifecycle        conda-forge/noarch::r-lifecycle-1.0.3-r42hc72bb7e_1
  r-lubridate        conda-forge/linux-64::r-lubridate-1.9.1-r42h133d619_0
  r-magrittr         conda-forge/linux-64::r-magrittr-2.0.3-r42h06615bd_1
  r-mass             conda-forge/linux-64::r-mass-7.3_58.2-r42h133d619_0
  r-matrix           conda-forge/linux-64::r-matrix-1.5_3-r42h5f7b363_0
  r-memoise          conda-forge/noarch::r-memoise-2.0.1-r42hc72bb7e_1
  r-mgcv             conda-forge/linux-64::r-mgcv-1.8_41-r42h5f7b363_0
  r-mime             conda-forge/linux-64::r-mime-0.12-r42h06615bd_1
  r-modelr           conda-forge/noarch::r-modelr-0.1.10-r42hc72bb7e_0
  r-munsell          conda-forge/noarch::r-munsell-0.5.0-r42hc72bb7e_1005
  r-nlme             conda-forge/linux-64::r-nlme-3.1_162-r42hac0b197_0
  r-openssl          conda-forge/linux-64::r-openssl-2.0.5-r42habfbb5e_0
  r-pillar           conda-forge/noarch::r-pillar-1.8.1-r42hc72bb7e_1
  r-pkgconfig        conda-forge/noarch::r-pkgconfig-2.0.3-r42hc72bb7e_2
  r-prettyunits      conda-forge/noarch::r-prettyunits-1.1.1-r42hc72bb7e_2
  r-processx         conda-forge/linux-64::r-processx-3.8.0-r42h06615bd_0
  r-progress         conda-forge/noarch::r-progress-1.2.2-r42hc72bb7e_3
  r-ps               conda-forge/linux-64::r-ps-1.7.2-r42h06615bd_0
  r-purrr            conda-forge/linux-64::r-purrr-1.0.1-r42h133d619_0
  r-r6               conda-forge/noarch::r-r6-2.5.1-r42hc72bb7e_1
  r-rappdirs         conda-forge/linux-64::r-rappdirs-0.3.3-r42h06615bd_1
  r-rcolorbrewer     conda-forge/noarch::r-rcolorbrewer-1.1_3-r42h785f33e_1
  r-rcpp             conda-forge/linux-64::r-rcpp-1.0.10-r42h38f115c_0
  r-readr            conda-forge/linux-64::r-readr-2.1.4-r42h38f115c_0
  r-readxl           conda-forge/linux-64::r-readxl-1.4.2-r42h81ef4d7_0
  r-rematch          conda-forge/noarch::r-rematch-1.0.1-r42hc72bb7e_1005
  r-rematch2         conda-forge/noarch::r-rematch2-2.1.2-r42hc72bb7e_2
  r-reprex           conda-forge/noarch::r-reprex-2.0.2-r42hc72bb7e_1
  r-rlang            conda-forge/linux-64::r-rlang-1.0.6-r42h7525677_1
  r-rmarkdown        conda-forge/noarch::r-rmarkdown-2.20-r42hc72bb7e_0
  r-rstudioapi       conda-forge/noarch::r-rstudioapi-0.14-r42hc72bb7e_1
  r-rvest            conda-forge/noarch::r-rvest-1.0.3-r42hc72bb7e_1
  r-sass             conda-forge/linux-64::r-sass-0.4.5-r42h38f115c_0
  r-scales           conda-forge/noarch::r-scales-1.2.1-r42hc72bb7e_1
  r-selectr          conda-forge/noarch::r-selectr-0.4_2-r42hc72bb7e_2
  r-stringi          conda-forge/linux-64::r-stringi-1.7.12-r42h1ae9187_0
  r-stringr          conda-forge/noarch::r-stringr-1.5.0-r42h785f33e_0
  r-sys              conda-forge/linux-64::r-sys-3.4.1-r42h06615bd_0
  r-tibble           conda-forge/linux-64::r-tibble-3.1.8-r42h06615bd_1
  r-tidyr            conda-forge/linux-64::r-tidyr-1.3.0-r42h38f115c_0
  r-tidyselect       conda-forge/linux-64::r-tidyselect-1.2.0-r42hc72bb7e_0
  r-tidyverse        conda-forge/noarch::r-tidyverse-1.3.2-r42hc72bb7e_1
  r-timechange       conda-forge/linux-64::r-timechange-0.2.0-r42h38f115c_0
  r-tinytex          conda-forge/noarch::r-tinytex-0.44-r42hc72bb7e_0
  r-tzdb             conda-forge/linux-64::r-tzdb-0.3.0-r42h7525677_1
  r-utf8             conda-forge/linux-64::r-utf8-1.2.3-r42h133d619_0
  r-uuid             conda-forge/linux-64::r-uuid-1.1_0-r42h06615bd_1
  r-vctrs            conda-forge/linux-64::r-vctrs-0.5.2-r42h38f115c_0
  r-viridislite      conda-forge/noarch::r-viridislite-0.4.1-r42hc72bb7e_1
  r-vroom            conda-forge/linux-64::r-vroom-1.6.1-r42h38f115c_0
  r-withr            conda-forge/noarch::r-withr-2.5.0-r42hc72bb7e_1
  r-xfun             conda-forge/linux-64::r-xfun-0.37-r42h38f115c_0
  r-xml2             conda-forge/linux-64::r-xml2-1.3.3-r42h044e5c7_2
  r-yaml             conda-forge/linux-64::r-yaml-2.3.7-r42h133d619_0
  readline           conda-forge/linux-64::readline-8.1.2-h0f457ee_0
  reproc             conda-forge/linux-64::reproc-14.2.4-h0b41bf4_0
  reproc-cpp         conda-forge/linux-64::reproc-cpp-14.2.4-hcb278e6_0
  requests           conda-forge/noarch::requests-2.28.2-pyhd8ed1ab_0
  ruamel.yaml        conda-forge/linux-64::ruamel.yaml-0.17.21-py311hd4cff14_2
  ruamel.yaml.clib   conda-forge/linux-64::ruamel.yaml.clib-0.2.7-py311h2582759_1
  sed                conda-forge/linux-64::sed-4.8-he412f7d_0
  setuptools         conda-forge/noarch::setuptools-67.3.2-pyhd8ed1ab_0
  sysroot_linux-64   conda-forge/noarch::sysroot_linux-64-2.12-he073ed8_15
  tk                 conda-forge/linux-64::tk-8.6.12-h27826a3_0
  tktable            conda-forge/linux-64::tktable-2.10-hb7b940f_3
  toolz              conda-forge/noarch::toolz-0.12.0-pyhd8ed1ab_0
  tqdm               conda-forge/noarch::tqdm-4.64.1-pyhd8ed1ab_0
  tzdata             conda-forge/noarch::tzdata-2022g-h191b570_0
  urllib3            conda-forge/noarch::urllib3-1.26.14-pyhd8ed1ab_0
  wheel              conda-forge/noarch::wheel-0.38.4-pyhd8ed1ab_0
  xorg-kbproto       conda-forge/linux-64::xorg-kbproto-1.0.7-h7f98852_1002
  xorg-libice        conda-forge/linux-64::xorg-libice-1.0.10-h7f98852_0
  xorg-libsm         conda-forge/linux-64::xorg-libsm-1.2.3-hd9c2040_1000
  xorg-libx11        conda-forge/linux-64::xorg-libx11-1.7.2-h7f98852_0
  xorg-libxau        conda-forge/linux-64::xorg-libxau-1.0.9-h7f98852_0
  xorg-libxdmcp      conda-forge/linux-64::xorg-libxdmcp-1.1.3-h7f98852_0
  xorg-libxext       conda-forge/linux-64::xorg-libxext-1.3.4-h7f98852_1
  xorg-libxrender    conda-forge/linux-64::xorg-libxrender-0.9.10-h7f98852_1003
  xorg-libxt         conda-forge/linux-64::xorg-libxt-1.2.1-h7f98852_2
  xorg-renderproto   conda-forge/linux-64::xorg-renderproto-0.11.1-h7f98852_1002
  xorg-xextproto     conda-forge/linux-64::xorg-xextproto-7.3.0-h7f98852_1002
  xorg-xproto        conda-forge/linux-64::xorg-xproto-7.0.31-h7f98852_1007
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0
  yaml-cpp           conda-forge/linux-64::yaml-cpp-0.7.0-h27087fc_2
  zlib               conda-forge/linux-64::zlib-1.2.13-h166bdaf_4
  zstandard          conda-forge/linux-64::zstandard-0.19.0-py311hbe0fcd7_1
  zstd               conda-forge/linux-64::zstd-1.5.2-h3eb15da_6


Proceed ([y]/n)? y


Downloading and Extracting Packages

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

pkgs/main/noarch                                   819.1kB @   3.4MB/s  0.3s
pkgs/r/noarch                                        1.3MB @   2.6MB/s  0.3s
pkgs/r/linux-64                                      1.4MB @   2.5MB/s  0.6s
bioconda/noarch                                      4.2MB @   4.4MB/s  1.1s
bioconda/linux-64                                    4.5MB @   4.1MB/s  1.2s
pkgs/main/linux-64                                   5.2MB @   3.0MB/s  1.9s

Pinned packages:
  - python 3.11.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/expression_env

  Updating specs:

   - subread
   - ca-certificates
   - certifi
   - openssl


  Package               Version  Build       Channel                 Size
───────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────

  + subread               2.0.3  h7132678_1  bioconda/linux-64       25MB

  Upgrade:
───────────────────────────────────────────────────────────────────────────

  - ca-certificates   2022.12.7  ha878542_0  conda-forge
  + ca-certificates  2023.01.10  h06a4308_0  pkgs/main/linux-64     123kB

  Summary:

  Install: 1 packages
  Upgrade: 1 packages

  Total download: 25MB

───────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
ca-certificates                                    122.8kB @   1.7MB/s  0.1s
subread                                             24.7MB @  47.2MB/s  0.6s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install -c conda-forge r-futile.logger=1.4.3=r42hc72bb7e_1004

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


Looking for: ['r-futile.logger==1.4.3=r42hc72bb7e_1004']

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

   - r-futile.logger==1.4.3=r42hc72bb7e_1004
   - ca-certificates
   - certifi
   - openssl


  Package             Version  Build             Channel                 Size
───────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────

  + r-formatr            1.14  r42hc72bb7e_0     conda-forge/noarch     165kB
  + r-futile.logger     1.4.3  r42hc72bb7e_1004  conda-forge/noarch     111kB
  + r-futile.options    1.0.1  r42hc72bb7e_1003  conda-forge/noarch      29kB
  + r-lambda.r          1.2.4  r42hc72bb7e_2     conda-forge/noarch     124kB

  Summary:

  Install: 4 packages

  Total download: 429kB

───────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
r-formatr                                          165.2kB @ 966.7kB/s  0.2s
r-futile.options                                    28.8kB @ 151.7kB/s  0.2s
r-futile.logger                                    111.1kB @ 579.0kB/s  0.2s
r-lambda.r                                         123.9kB @ 573.5kB/s  0.2s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<br />
<br />

<a id="name-tbd"></a>
## Name TBD
<a id="symlink-to-datasets"></a>
### Symlink to datasets
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Symlink to datasets</i></summary>

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


path_1=$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI"
)
echo "${path_1}"

path_2=$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary"
)
echo "${path_2}"

ln -s "${path_1}" "aligned_UT_primary_dedup-UMI"
ln -s "${path_2}" "aligned_UT_primary"
```
</details>
<br />
<br />

<a id="run-featurecounts"></a>
## Run featureCounts
<a id="test-to-determine-option-for-featurecounts--s-results-in-an-error"></a>
### Test to determine option for featureCounts -s; results in an error
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s; results in an error</i></summary>

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
<summary><i>Printed: Test to determine option for featureCounts -s; results in an error</i></summary>

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

<a id="code-5"></a>
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
<a id="code-6"></a>
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
### Test to determine option for featureCounts -s with -g "ID" (#CORRECT)
`featureCounts -s 1` with `-g "ID"` is the way to go

<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s with -g "ID"</i></summary>

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
<summary><i>Printed: Test to determine option for featureCounts -s with -g "ID"</i></summary>

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
<a id="code-8"></a>
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

<a id="run-featurecounts-on-all-bams"></a>
## Run featureCounts on all bams
<a id="code-9"></a>
### Code
<details>
<summary><i>Code: </i></summary>

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
