
`#study_run_rnaQUAST.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Install rnaQUAST in its own environment \(2023-0218\)](#install-rnaquast-in-its-own-environment-2023-0218)
    1. [Code](#code)
    1. [Printed](#printed)
1. [Check on Trinity GG Q_N that failed/didn't complete \(2023-0218\)](#check-on-trinity-gg-q_n-that-faileddidnt-complete-2023-0218)
    1. [Notes, printed](#notes-printed)
    1. [Printed](#printed-1)
1. [Do a trial run with current Trinity GG Q_N assemblies \(2023-0218\)](#do-a-trial-run-with-current-trinity-gg-q_n-assemblies-2023-0218)
    1. [Make necessary directories](#make-necessary-directories)
        1. [Code](#code-1)
    1. [Symlink the Trinity GG Q_N directory, create merged version of the fastqs](#symlink-the-trinity-gg-q_n-directory-create-merged-version-of-the-fastqs)
        1. [Code](#code-2)
    1. [Download and store the BUSCO database for the *Saccharomycetes* class](#download-and-store-the-busco-database-for-the-saccharomycetes-class)
    1. [Grab a node with 32 cores, get situated](#grab-a-node-with-32-cores-get-situated)
        1. [Code](#code-3)
    1. [Initialize variables, arrays related to Trinity GG Q_N fasta files](#initialize-variables-arrays-related-to-trinity-gg-q_n-fasta-files)
        1. [Code](#code-4)
    1. [Launch the trial run of rnaQUAST](#launch-the-trial-run-of-rnaquast)
        1. [Code](#code-5)
        1. [Printed](#printed-2)
    1. [Check in, assess the job situation \(2023-0220, 10:20 a.m.\)](#check-in-assess-the-job-situation-2023-0220-1020-am)
    1. [Next steps \(2023-0220, 11:10 a.m.\)](#next-steps-2023-0220-1110-am)
    1. [Kill the initial run \(2023-0220, 12:00 p.m.\)](#kill-the-initial-run-2023-0220-1200-pm)
1. [Install up-to-date rnaQUAST in its own environment \(2023-0220\)](#install-up-to-date-rnaquast-in-its-own-environment-2023-0220)
    1. [Code](#code-6)
    1. [Printed](#printed-3)
1. [Do ~~three~~n new trial runs \(2023-0220-0221\)](#do-~~three~~n-new-trial-runs-2023-0220-0221)
    1. [Prepare for and perform run 1](#prepare-for-and-perform-run-1)
        1. [Code](#code-7)
        1. [Printed](#printed-4)
    1. [Prepare for and perform run 2](#prepare-for-and-perform-run-2)
        1. [Code](#code-8)
        1. [Printed](#printed-5)
    1. [Prepare for and perform run 3](#prepare-for-and-perform-run-3)
        1. [Code](#code-9)
        1. [Printed](#printed-6)
    1. [Prepare for and perform run 4](#prepare-for-and-perform-run-4)
        1. [Code](#code-10)
        1. [Printed](#printed-7)
    1. [Prepare for and perform run 5](#prepare-for-and-perform-run-5)
        1. [Code](#code-11)
        1. [Printed](#printed-8)
    1. [Prepare for and perform run 6](#prepare-for-and-perform-run-6)
        1. [Code](#code-12)
        1. [Printed](#printed-9)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="install-rnaquast-in-its-own-environment-2023-0218"></a>
## Install rnaQUAST in its own environment (2023-0218)
<a id="code"></a>
### Code
<details>
<summary><i>Code: Install rnaQUAST in its own environment (2023-0218)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

conda create -n rnaquast_env -c bioconda rnaquast
```
</details>
<br />

<a id="printed"></a>
### Printed
<details>
<summary><i>Printed: Install rnaQUAST in its own environment (2023-0218)</i></summary>

```txt
❯ conda create -n rnaquast_env -c bioconda rnaquast
Retrieving notices: ...working... done
Collecting package metadata (current_repodata.json): done
Solving environment: failed with repodata from current_repodata.json, will retry with next repodata source.
Collecting package metadata (repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
  current version: 22.11.1
  latest version: 23.1.0

Please update conda by running

    $ conda update -n base -c defaults conda

Or to minimize the number of packages updated during conda update use

     conda install conda=23.1.0



## Package Plan ##

  environment location: /home/kalavatt/miniconda3/envs/rnaquast_env

  added / updated specs:
    - rnaquast


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    argcomplete-1.12.3         |     pyhd3eb1b0_0          35 KB
    argh-0.26.2                |           py36_0          36 KB
    augustus-3.1               |                0        34.7 MB  bioconda
    blas-1.0                   |              mkl           6 KB
    blast-2.5.0                |       hc0b0e79_3       137.8 MB  bioconda
    blat-35                    |                1         1.7 MB  bioconda
    boost-1.73.0               |  py36h06a4308_11          25 KB
    busco-2.0.1                |           py36_0          29 KB  bioconda
    c-ares-1.18.1              |       h7f8727e_0         114 KB
    certifi-2021.5.30          |   py36h06a4308_0         139 KB
    curl-7.87.0                |       h5eee18b_0          88 KB
    cycler-0.11.0              |     pyhd3eb1b0_0          12 KB
    emboss-6.6.0               |       h6debe1e_0        94.5 MB  bioconda
    gffutils-0.11.1            |     pyh7cba7a3_0         1.2 MB  bioconda
    gmap-2021.08.25            | pl5262h36cd882_0        27.1 MB  bioconda
    hmmer-3.3.2                |       h87f3376_2         9.6 MB  bioconda
    importlib-metadata-4.8.1   |   py36h06a4308_0          38 KB
    importlib_metadata-4.8.1   |       hd3eb1b0_0          11 KB
    intel-openmp-2022.1.0      |    h9e868ea_3769         4.5 MB
    joblib-1.0.1               |     pyhd3eb1b0_0         208 KB
    kiwisolver-1.3.1           |   py36h2531618_0          86 KB
    krb5-1.19.4                |       h568e23c_0         1.3 MB
    lcms2-2.12                 |       h3be6417_0         312 KB
    libboost-1.73.0            |      h3ff78a5_11        13.9 MB
    libcurl-7.87.0             |       h91b91d3_0         373 KB
    libev-4.33                 |       h7f8727e_1         111 KB
    libffi-3.3                 |       he6710b0_2          50 KB
    libgcc-7.2.0               |       h69d50b8_2         269 KB
    libgd-2.3.3                |       h695aa2c_1         222 KB
    libnghttp2-1.46.0          |       hce63b2e_0         680 KB
    libtiff-4.2.0              |       h85742a9_0         502 KB
    matplotlib-base-3.3.4      |   py36h62a2d02_0         5.1 MB
    mkl-2020.2                 |              256       138.3 MB
    mkl-service-2.3.0          |   py36he8ac12f_0          52 KB
    mkl_fft-1.3.0              |   py36h54f3939_0         170 KB
    mkl_random-1.1.1           |   py36h0573a6f_0         327 KB
    mysql-connector-c-6.1.6    |                2         9.6 MB  bioconda
    numpy-1.19.2               |   py36h54aff64_0          22 KB
    numpy-base-1.19.2          |   py36hfa32c7d_0         4.1 MB
    olefile-0.46               |           py36_0          48 KB
    openjpeg-2.4.0             |       h3ad879b_0         331 KB
    openssl-1.1.1t             |       h7f8727e_0         3.7 MB
    perl-5.26.2                |       h14c3975_0        10.5 MB
    pillow-8.3.1               |   py36h2c7a002_0         637 KB
    pip-21.2.2                 |   py36h06a4308_0         1.8 MB
    py-boost-1.73.0            |  py36ha9443f7_11         204 KB
    pyfaidx-0.7.0              |     pyh5e36f6f_0          31 KB  bioconda
    pyparsing-3.0.4            |     pyhd3eb1b0_0          81 KB
    python-3.6.13              |       h12debd9_1        32.5 MB
    python-dateutil-2.8.2      |     pyhd3eb1b0_0         233 KB
    rnaquast-2.0.1             |                0         4.9 MB  bioconda
    samtools-1.6               |       hb116620_7         514 KB  bioconda
    setuptools-58.0.4          |   py36h06a4308_0         788 KB
    simplejson-3.8.1           |           py36_0         130 KB  bioconda
    sqlite-3.40.1              |       h5082296_0         1.2 MB
    star-2.7.10b               |       h9ee0642_0         4.9 MB  bioconda
    tornado-6.1                |   py36h27cfd23_0         581 KB
    typing_extensions-4.1.1    |     pyh06a4308_0          28 KB
    ucsc-pslsort-357           |                0        1006 KB  bioconda
    zipp-3.6.0                 |     pyhd3eb1b0_0          17 KB
    zstd-1.4.9                 |       haebb681_0         480 KB
    ------------------------------------------------------------
                                           Total:       551.9 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      pkgs/main/linux-64::_libgcc_mutex-0.1-main
  _openmp_mutex      pkgs/main/linux-64::_openmp_mutex-5.1-1_gnu
  argcomplete        pkgs/main/noarch::argcomplete-1.12.3-pyhd3eb1b0_0
  argh               pkgs/main/linux-64::argh-0.26.2-py36_0
  augustus           bioconda/linux-64::augustus-3.1-0
  blas               pkgs/main/linux-64::blas-1.0-mkl
  blast              bioconda/linux-64::blast-2.5.0-hc0b0e79_3
  blat               bioconda/linux-64::blat-35-1
  boost              pkgs/main/linux-64::boost-1.73.0-py36h06a4308_11
  busco              bioconda/linux-64::busco-2.0.1-py36_0
  bzip2              pkgs/main/linux-64::bzip2-1.0.8-h7b6447c_0
  c-ares             pkgs/main/linux-64::c-ares-1.18.1-h7f8727e_0
  ca-certificates    pkgs/main/linux-64::ca-certificates-2023.01.10-h06a4308_0
  certifi            pkgs/main/linux-64::certifi-2021.5.30-py36h06a4308_0
  curl               pkgs/main/linux-64::curl-7.87.0-h5eee18b_0
  cycler             pkgs/main/noarch::cycler-0.11.0-pyhd3eb1b0_0
  emboss             bioconda/linux-64::emboss-6.6.0-h6debe1e_0
  expat              pkgs/main/linux-64::expat-2.4.9-h6a678d5_0
  fontconfig         pkgs/main/linux-64::fontconfig-2.14.1-h52c9d5c_1
  freetype           pkgs/main/linux-64::freetype-2.12.1-h4a9f257_0
  gffutils           bioconda/noarch::gffutils-0.11.1-pyh7cba7a3_0
  gmap               bioconda/linux-64::gmap-2021.08.25-pl5262h36cd882_0
  hmmer              bioconda/linux-64::hmmer-3.3.2-h87f3376_2
  icu                pkgs/main/linux-64::icu-58.2-he6710b0_3
  importlib-metadata pkgs/main/linux-64::importlib-metadata-4.8.1-py36h06a4308_0
  importlib_metadata pkgs/main/noarch::importlib_metadata-4.8.1-hd3eb1b0_0
  intel-openmp       pkgs/main/linux-64::intel-openmp-2022.1.0-h9e868ea_3769
  joblib             pkgs/main/noarch::joblib-1.0.1-pyhd3eb1b0_0
  jpeg               pkgs/main/linux-64::jpeg-9e-h7f8727e_0
  kiwisolver         pkgs/main/linux-64::kiwisolver-1.3.1-py36h2531618_0
  krb5               pkgs/main/linux-64::krb5-1.19.4-h568e23c_0
  lcms2              pkgs/main/linux-64::lcms2-2.12-h3be6417_0
  ld_impl_linux-64   pkgs/main/linux-64::ld_impl_linux-64-2.38-h1181459_1
  libboost           pkgs/main/linux-64::libboost-1.73.0-h3ff78a5_11
  libcurl            pkgs/main/linux-64::libcurl-7.87.0-h91b91d3_0
  libedit            pkgs/main/linux-64::libedit-3.1.20221030-h5eee18b_0
  libev              pkgs/main/linux-64::libev-4.33-h7f8727e_1
  libffi             pkgs/main/linux-64::libffi-3.3-he6710b0_2
  libgcc             pkgs/main/linux-64::libgcc-7.2.0-h69d50b8_2
  libgcc-ng          pkgs/main/linux-64::libgcc-ng-11.2.0-h1234567_1
  libgd              pkgs/main/linux-64::libgd-2.3.3-h695aa2c_1
  libgomp            pkgs/main/linux-64::libgomp-11.2.0-h1234567_1
  libnghttp2         pkgs/main/linux-64::libnghttp2-1.46.0-hce63b2e_0
  libpng             pkgs/main/linux-64::libpng-1.6.37-hbc83047_0
  libssh2            pkgs/main/linux-64::libssh2-1.10.0-h8f2d780_0
  libstdcxx-ng       pkgs/main/linux-64::libstdcxx-ng-11.2.0-h1234567_1
  libtiff            pkgs/main/linux-64::libtiff-4.2.0-h85742a9_0
  libuuid            pkgs/main/linux-64::libuuid-1.41.5-h5eee18b_0
  libwebp-base       pkgs/main/linux-64::libwebp-base-1.2.4-h5eee18b_0
  libxml2            pkgs/main/linux-64::libxml2-2.9.14-h74e7548_0
  lz4-c              pkgs/main/linux-64::lz4-c-1.9.4-h6a678d5_0
  matplotlib-base    pkgs/main/linux-64::matplotlib-base-3.3.4-py36h62a2d02_0
  mkl                pkgs/main/linux-64::mkl-2020.2-256
  mkl-service        pkgs/main/linux-64::mkl-service-2.3.0-py36he8ac12f_0
  mkl_fft            pkgs/main/linux-64::mkl_fft-1.3.0-py36h54f3939_0
  mkl_random         pkgs/main/linux-64::mkl_random-1.1.1-py36h0573a6f_0
  mysql-connector-c  bioconda/linux-64::mysql-connector-c-6.1.6-2
  ncurses            pkgs/main/linux-64::ncurses-6.4-h6a678d5_0
  numpy              pkgs/main/linux-64::numpy-1.19.2-py36h54aff64_0
  numpy-base         pkgs/main/linux-64::numpy-base-1.19.2-py36hfa32c7d_0
  olefile            pkgs/main/linux-64::olefile-0.46-py36_0
  openjpeg           pkgs/main/linux-64::openjpeg-2.4.0-h3ad879b_0
  openssl            pkgs/main/linux-64::openssl-1.1.1t-h7f8727e_0
  perl               pkgs/main/linux-64::perl-5.26.2-h14c3975_0
  pillow             pkgs/main/linux-64::pillow-8.3.1-py36h2c7a002_0
  pip                pkgs/main/linux-64::pip-21.2.2-py36h06a4308_0
  py-boost           pkgs/main/linux-64::py-boost-1.73.0-py36ha9443f7_11
  pyfaidx            bioconda/noarch::pyfaidx-0.7.0-pyh5e36f6f_0
  pyparsing          pkgs/main/noarch::pyparsing-3.0.4-pyhd3eb1b0_0
  python             pkgs/main/linux-64::python-3.6.13-h12debd9_1
  python-dateutil    pkgs/main/noarch::python-dateutil-2.8.2-pyhd3eb1b0_0
  readline           pkgs/main/linux-64::readline-8.2-h5eee18b_0
  rnaquast           bioconda/linux-64::rnaquast-2.0.1-0
  samtools           bioconda/linux-64::samtools-1.6-hb116620_7
  setuptools         pkgs/main/linux-64::setuptools-58.0.4-py36h06a4308_0
  simplejson         bioconda/linux-64::simplejson-3.8.1-py36_0
  six                pkgs/main/noarch::six-1.16.0-pyhd3eb1b0_1
  sqlite             pkgs/main/linux-64::sqlite-3.40.1-h5082296_0
  star               bioconda/linux-64::star-2.7.10b-h9ee0642_0
  tk                 pkgs/main/linux-64::tk-8.6.12-h1ccaba5_0
  tornado            pkgs/main/linux-64::tornado-6.1-py36h27cfd23_0
  typing_extensions  pkgs/main/noarch::typing_extensions-4.1.1-pyh06a4308_0
  ucsc-pslsort       bioconda/linux-64::ucsc-pslsort-357-0
  wheel              pkgs/main/noarch::wheel-0.37.1-pyhd3eb1b0_0
  xz                 pkgs/main/linux-64::xz-5.2.10-h5eee18b_1
  zipp               pkgs/main/noarch::zipp-3.6.0-pyhd3eb1b0_0
  zlib               pkgs/main/linux-64::zlib-1.2.13-h5eee18b_0
  zstd               pkgs/main/linux-64::zstd-1.4.9-haebb681_0


Proceed ([y]/n)? y


Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate rnaquast_env
#
# To deactivate an active environment, use
#
#     $ conda deactivate
```
</details>
<br />
<br />

<a id="check-on-trinity-gg-q_n-that-faileddidnt-complete-2023-0218"></a>
## Check on Trinity GG Q_N that failed/didn't complete (2023-0218)
<a id="notes-printed"></a>
### Notes, printed
<details>
<summary><i>Notes: Check on Trinity GG Q_N that failed/didn't complete (2023-0218)</i></summary>

In `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N`, we see that the following three fasta files have not been generated&mdash;what is going with these datasets?
- `trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01/`
- `trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05/`
- `trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05/`

`trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01` is still running&mdash;it has been running for 2 days and 22 hours at the time of writing

The other two jobs were nearly completed before they failed; I posted a [question](https://groups.google.com/g/trinityrnaseq-users/c/IwQLh8QZlNg/m/UZz8_NWCAQAJ) to the [trinityrnaseq-users](https://groups.google.com/g/trinityrnaseq-users) forum about this
</details>
<br />

<a id="printed-1"></a>
### Printed
<details>
<summary><i>Printed: Check on Trinity GG Q_N that failed/didn't complete (2023-0218)</i></summary>

```txt
❯ cat trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.10397285-106.out.txt
singularity run \
            --bind /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG:/data \
            --bind /fh/scratch/delete30/tsukiyama_t:/loc/scratch \
            ~/singularity-docker-etc/Trinity.sif \
                Trinity \
                    --verbose \
                    --max_memory 50G \
                    --CPU 6 \
                    --SS_lib_type FR \
                    --genome_guided_bam /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/infiles_Trinity-GG/Q_N.bam \
                    --genome_guided_max_intron 1002 \
                    --jaccard_clip \
                    --output /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01 \
                    --full_cleanup \
                    --min_kmer_cov 4 \
                    --min_iso_ratio 0.005 \
                    --min_glue 4 \
                    --glue_factor 0.01 \
                    --max_reads_per_graph 2000 \
                    --normalize_max_read_cov 200 \
                    --group_pairs_distance 700 \
                    --min_contig_length 200


❯ cat trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.10397285-106.err.txt


❯ tail -200 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05.10397285-207.out.txt
...
#############################################################################
Finished.  Final Trinity assemblies are written to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05/Dir_Q_N.bam.norm_200.bam.-.sam.minC1.gff/VII/4/1056589_1063415.trinity.reads.out.Trinity.fasta
#############################################################################


Fully cleaning up.
succeeded(4411), failed(368)   100% completed.

We are sorry, commands in file: [FailedCommands] failed.  :-(

Error, cmd: /usr/local/bin/trinity-plugins/BIN/ParaFly -c trinity_GG.cmds -CPU 6 -v -shuffle  died with ret 256 at /usr/local/bin/Trinity line 2919.
	main::process_cmd("/usr/local/bin/trinity-plugins/BIN/ParaFly -c trinity_GG.cmds"...) called at /usr/local/bin/Trinity line 3653
	main::run_partitioned_cmds("trinity_GG.cmds") called at /usr/local/bin/Trinity line 3611
	main::run_genome_guided_Trinity("/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-const"..., undef) called at /usr/local/bin/Trinity line 1467

Trinity run time
Run time: 3h:38m:33s


❯ tail -200 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05.10397285-191.out.txt
...
#############################################################################
Finished.  Final Trinity assemblies are written to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05/Dir_Q_N.bam.norm_200.bam.-.sam.minC1.gff/VII/4/1056589_1063415.trinity.reads.out.Trinity.fasta
#############################################################################


Fully cleaning up.
succeeded(4778), failed(1)   100% completed.

We are sorry, commands in file: [FailedCommands] failed.  :-(

Error, cmd: /usr/local/bin/trinity-plugins/BIN/ParaFly -c trinity_GG.cmds -CPU 6 -v -shuffle  died with ret 256 at /usr/local/bin/Trinity line 2919.
	main::process_cmd("/usr/local/bin/trinity-plugins/BIN/ParaFly -c trinity_GG.cmds"...) called at /usr/local/bin/Trinity line 3653
	main::run_partitioned_cmds("trinity_GG.cmds") called at /usr/local/bin/Trinity line 3611
	main::run_genome_guided_Trinity("/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-const"..., undef) called at /usr/local/bin/Trinity line 1467

Trinity run time
Run time: 1h:57m:56s
```
</details>
<br />
<br />

<a id="do-a-trial-run-with-current-trinity-gg-q_n-assemblies-2023-0218"></a>
## Do a trial run with current Trinity GG Q_N assemblies (2023-0218)
i.e., with 285 of the 288 Trinity GG Q_N assemblies

<a id="make-necessary-directories"></a>
### Make necessary directories
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Make necessary directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
source activate rnaquast_env

mkdir 2023-0218/

cd "results/2023-0218/" \
    || echo "cd'ing failed; check on this..."

mkdir outfiles_rnaQUAST-test_Trinity-GG_Q-N/
```
</details>
<br />

<a id="symlink-the-trinity-gg-q_n-directory-create-merged-version-of-the-fastqs"></a>
### Symlink the Trinity GG Q_N directory, create merged version of the fastqs
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Symlink the Trinity GG Q_N directory, create merged version of the fastqs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


#  Files: assemblies
ori_GG="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N"
rel_GG="$(find_relative_path "." "${ori_GG}")"  # echo "${rel_GG}"

ln -s "${rel_GG}" Trinity_GG.Q_N


#  Files: fastqs
mkdir fastqs/
cd fastqs/ \
    || echo "cd'ing failed; check on this..."
ori_fq="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected"
rel_fq="$(find_relative_path "." "${ori_fq}")"  # echo "${rel_fq}"

ln -s "${rel_fq}/5781_Q_IP_UTK_R1.fq.gz" "5781_Q_IP_UTK_R1.fq.gz"
ln -s "${rel_fq}/5781_Q_IP_UTK_R3.fq.gz" "5781_Q_IP_UTK_R3.fq.gz"
ln -s "${rel_fq}/5782_Q_IP_UTK_R1.fq.gz" "5782_Q_IP_UTK_R1.fq.gz"
ln -s "${rel_fq}/5782_Q_IP_UTK_R3.fq.gz" "5782_Q_IP_UTK_R3.fq.gz"

cat "5781_Q_IP_UTK_R1.fq.gz" "5782_Q_IP_UTK_R1.fq.gz" \
	> "merged_Q_IP_UTK_R1.fq.gz"

cat "5781_Q_IP_UTK_R3.fq.gz" "5782_Q_IP_UTK_R3.fq.gz" \
	> "merged_Q_IP_UTK_R3.fq.gz"
```

<a id="download-and-store-the-busco-database-for-the-saccharomycetes-class"></a>
### Download and store the BUSCO database for the *Saccharomycetes* class
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  File: BUSCO lineage
cd ..
mkdir BUSCO/
cd BUSCO/ \
    || echo "cd'ing failed; check on this..."
curl \
	https://busco-data.ezlab.org/v4/data/lineages/saccharomycetes_odb10.2020-08-05.tar.gz \
	-o saccharomycetes_odb10.2020-08-05.tar.gz
```
</details>
<br />

<a id="grab-a-node-with-32-cores-get-situated"></a>
### Grab a node with 32 cores, get situated
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Grab a node with 32 cores, get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 32, etc.

transcriptome && 
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }
```
</details>
<br />

<a id="initialize-variables-arrays-related-to-trinity-gg-q_n-fasta-files"></a>
### Initialize variables, arrays related to Trinity GG Q_N fasta files
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Initialize variables, arrays related to Trinity GG Q_N fasta files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Arrays -----------------------------
unset f_GG
typeset -a f_GG
while IFS=" " read -r -d $'\0'; do
    f_GG+=( "${REPLY}" )
done < <(\
        find "./Trinity_GG.Q_N/" \
            -maxdepth 3 \
            -type f \
            -name "*.fasta" \
            -print0 \
                | sort -z\
)
echo_test "${f_GG[@]}"
echo "${#f_GG[@]}"  # 285

unset n_GG
typeset -a n_GG
for i in "${f_GG[@]}"; do
	# i="${f_GG[0]}"  # echo "${i}"
	name="$(basename "${i}" .Trinity-GG.fasta)"  # echo "${name}"
	n_GG+=( "${name#trinity-}" )
done
echo_test "${n_GG[@]}"
echo "${#n_GG[@]}"  # 285

#  Check that files and names match
echo_test "${f_GG[@]}" | head
echo_test "${n_GG[@]}" | head
echo_test "${f_GG[@]}" | tail
echo_test "${n_GG[@]}" | tail


#  Variables --------------------------
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"

p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"

p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"
```
</details>
<br />

<a id="launch-the-trial-run-of-rnaquast"></a>
### Launch the trial run of rnaQUAST
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Launch the trial run of rnaQUAST</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

source activate rnaquast_env
rnaQUAST.py

rnaQUAST.py \
	-t "${SLURM_CPUS_ON_NODE}" \
	--labels ${n_GG[*]} \
	--transcripts ${f_GG[*]} \
	--reference "${p_ref}/${f_ref}" \
	--gtf "${p_gtf}/${f_gtf}" \
	--gmap_index "${p_gmap}/${d_gmap}" \
	--strand_specific \
	--left_reads "fastqs/merged_Q_IP_UTK_R1.fq.gz" \
	--right_reads "fastqs/merged_Q_IP_UTK_R3.fq.gz" \
	--output_dir "outfiles_rnaQUAST-test_Trinity-GG_Q-N/" \
	--busco_lineage "BUSCO/saccharomycetes_odb10.2020-08-05.tar.gz" \
	--gene_mark \
	--disable_infer_genes \
	--disable_infer_transcripts
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Launch the trial run of rnaQUAST</i></summary>

```txt
❯ rnaQUAST.py
usage: /home/kalavatt/miniconda3/envs/rnaquast_env/bin/rnaQUAST.py
       [-h] [-r REFERENCE [REFERENCE ...]] [--gtf GTF [GTF ...]]
       [--gene_db GENE_DB] [-c TRANSCRIPTS [TRANSCRIPTS ...]]
       [-psl ALIGNMENT [ALIGNMENT ...]] [-sam READS_ALIGNMENT] [-1 LEFT_READS]
       [-2 RIGHT_READS] [-s SINGLE_READS] [--gmap_index GMAP_INDEX]
       [-o OUTPUT_DIR] [--test] [-d] [-t THREADS] [-l LABELS [LABELS ...]]
       [-ss] [--min_alignment MIN_ALIGNMENT] [--no_plots] [--blat]
       [--gene_mark] [--meta] [--lower_threshold LOWER_THRESHOLD]
       [--upper_threshold UPPER_THRESHOLD] [--disable_infer_genes]
       [--disable_infer_transcripts] [--busco_lineage BUSCO_LINEAGE]
       [--prokaryote]

QUALITY ASSESSMENT FOR TRANSCRIPTOME ASSEMBLIES /home/kalavatt/miniconda3/envs/rnaquast_env/bin/rnaQUAST.py v.2.0.1

Usage:
python /home/kalavatt/miniconda3/envs/rnaquast_env/bin/rnaQUAST.py --transcripts TRANSCRIPTS --reference REFERENCE --gtf GENE_COORDINATES

optional arguments:
  -h, --help            show this help message and exit

Input data:
  -r REFERENCE [REFERENCE ...], --reference REFERENCE [REFERENCE ...]
                        Single file (or several files for meta RNA) with
                        reference genome in FASTA format or *.txt file with
                        one-per-line list of FASTA files with reference
                        sequences
  --gtf GTF [GTF ...]   File with gene coordinates (or several files or *.txt
                        file with one-per-line list of GTF / GFF files for
                        meta RNA). We recommend to use files downloaded from
                        GENCODE or Ensembl [GTF/GFF]
  --gene_db GENE_DB     Path to the gene database generated by gffutils to be
                        used
  -c TRANSCRIPTS [TRANSCRIPTS ...], --transcripts TRANSCRIPTS [TRANSCRIPTS ...]
                        File(s) with transcripts [FASTA]
  -psl ALIGNMENT [ALIGNMENT ...], --alignment ALIGNMENT [ALIGNMENT ...]
                        File(s) with transcript alignments to the reference
                        genome [PSL]
  -sam READS_ALIGNMENT, --reads_alignment READS_ALIGNMENT
                        File with read alignments to the reference genome
                        [SAM]
  -1 LEFT_READS, --left_reads LEFT_READS
                        File with forward paired-end reads [FASTQ or gzip-
                        compressed]
  -2 RIGHT_READS, --right_reads RIGHT_READS
                        File with reverse paired-end reads [FASTQ or gzip-
                        compressed]
  -s SINGLE_READS, --single_reads SINGLE_READS
                        File with unpaired reads [FASTQ or gzip-compressed]
  --gmap_index GMAP_INDEX
                        Folder containing GMAP index for the reference genome

Basic options:
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory to store all results [default:
                        rnaQUAST_results/results_<datetime>]
  --test                Run rnaQUAST on the test data from the test_data
                        folder, output directory is rnaOUAST_test_output
  -d, --debug           Report detailed information, typically used only for
                        detecting problems.

Advanced options:
  -t THREADS, --threads THREADS
                        Maximum number of threads, default: min(number of CPUs
                        / 2, 16)
  -l LABELS [LABELS ...], --labels LABELS [LABELS ...]
                        Name(s) of assemblies that will be used in the reports
  -ss, --strand_specific
                        Set if transcripts were assembled using strand-
                        specific RNA-Seq data
  --min_alignment MIN_ALIGNMENT
                        Minimal alignment length, default: 50
  --no_plots            Do not draw plots (to speed up computation)
  --blat                Run with BLAT alignment tool
                        (http://hgwdev.cse.ucsc.edu/~kent/exe/) instead of
                        GMAP
  --gene_mark           Run with GeneMarkS-T tool
                        (http://topaz.gatech.edu/GeneMark/)
  --meta                Run QUALITY ASSESSMENT FOR METATRANSCRIPTOME
                        ASSEMBLIES
  --lower_threshold LOWER_THRESHOLD
                        Lower threshold for x-assembled/covered/matched
                        metrics, default: 0.5
  --upper_threshold UPPER_THRESHOLD
                        Upper threshold for x-assembled/covered/matched
                        metrics, default: 0.95
  --prokaryote          Use this option if the genome is prokaryotic

Gffutils related options:
  --disable_infer_genes
                        Use this option if your GTF file already contains
                        genes records
  --disable_infer_transcripts
                        Use this option if your GTF already contains
                        transcripts records

BUSCO related options:
  --busco_lineage BUSCO_LINEAGE
                        Run with BUSCO tool (http://busco.ezlab.org/). Path to
                        the BUSCO lineage data to be used (Eukaryota, Metazoa,
                        Arthropoda, Vertebrata or Fungi)

Don't forget to add GMAP (or BLAT) to PATH.
```
</details>
<br />

<a id="check-in-assess-the-job-situation-2023-0220-1020-am"></a>
### Check in, assess the job situation (2023-0220, 10:20 a.m.)
<details>
<summary><i>Notes: Check in, assess the job situation (2023-0220, 10:20 a.m.)</i></summary>

<br />
In checking the rnaQUAST log, the job has been stuck with the following message since ~18:00 p.m., 2023-0218:

```txt
2023-02-18 17:55:33
Getting database coverage by reads...


❯ pwd
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N


❯ .,sf
-rw-r----- 1 kalavatt 33M Feb 18 17:49 ./Saccharomyces_cerevisiae.R64-1-1.108.db

./tmp:
total 13M
-rw-rw---- 1 kalavatt 10M Feb 18 17:49 Saccharomyces_cerevisiae.R64-1-1.108.cleared.gtf
drwxrws--- 4 kalavatt 100 Feb 18 17:49 ../
drwxrws--- 3 kalavatt  92 Feb 18 17:51 ./
drwxrws--- 5 kalavatt 230 Feb 18 17:55 star_out/

./logs:
total 328K
drwxrws--- 4 kalavatt  100 Feb 18 17:49 ../
-rw-rw---- 1 kalavatt    0 Feb 18 17:51 STAR.err.log
drwxrws--- 2 kalavatt   90 Feb 18 17:51 ./
-rw-rw---- 1 kalavatt 2.2K Feb 18 17:55 STAR.out.log
-rw-rw---- 1 kalavatt  35K Feb 18 17:56 rnaQUAST.log
```

Nothing has been written to `./Saccharomyces_cerevisiae.R64-1-1.108.db` since `Feb 18 17:49`, and nothing has been written to `rnaQUAST.log` since `Feb 18 17:56`

To review, here is how I called rnaQUAST (per `rnaQUAST.log`):

```txt
/home/kalavatt/miniconda3/envs/rnaquast_env/share/rnaquast-2.0.1-0/rnaQUAST.py -t 32 --labels gg_mkc-16_mir-0.005_mg-1_gf-0.005 gg_mkc-16_mir-0.005_mg-1_gf-0.01 gg_mkc-16_mir-0.005_mg-1_gf-0.05 gg_mkc-16_mir-0.005_mg-1_gf-0.1 gg_mkc-16_mir-0.005_mg-2_gf-0.005 gg_mkc-16_mir-0.005_mg-2_gf-0.01 gg_mkc-16_mir-0.005_mg-2_gf-0.05 gg_mkc-16_mir-0.005_mg-2_gf-0.1 gg_mkc-16_mir-0.005_mg-4_gf-0.005 gg_mkc-16_mir-0.005_mg-4_gf-0.01 gg_mkc-16_mir-0.005_mg-4_gf-0.05 gg_mkc-16_mir-0.005_mg-4_gf-0.1 gg_mkc-16_mir-0.01_mg-1_gf-0.005 gg_mkc-16_mir-0.01_mg-1_gf-0.01 gg_mkc-16_mir-0.01_mg-1_gf-0.1 gg_mkc-16_mir-0.01_mg-2_gf-0.005 gg_mkc-16_mir-0.01_mg-2_gf-0.01 gg_mkc-16_mir-0.01_mg-2_gf-0.05 gg_mkc-16_mir-0.01_mg-2_gf-0.1 gg_mkc-16_mir-0.01_mg-4_gf-0.005 gg_mkc-16_mir-0.01_mg-4_gf-0.01 gg_mkc-16_mir-0.01_mg-4_gf-0.05 gg_mkc-16_mir-0.01_mg-4_gf-0.1 gg_mkc-16_mir-0.05_mg-1_gf-0.005 gg_mkc-16_mir-0.05_mg-1_gf-0.01 gg_mkc-16_mir-0.05_mg-1_gf-0.05 gg_mkc-16_mir-0.05_mg-1_gf-0.1 gg_mkc-16_mir-0.05_mg-2_gf-0.005 gg_mkc-16_mir-0.05_mg-2_gf-0.01 gg_mkc-16_mir-0.05_mg-2_gf-0.05 gg_mkc-16_mir-0.05_mg-2_gf-0.1 gg_mkc-16_mir-0.05_mg-4_gf-0.005 gg_mkc-16_mir-0.05_mg-4_gf-0.01 gg_mkc-16_mir-0.05_mg-4_gf-0.05 gg_mkc-16_mir-0.05_mg-4_gf-0.1 gg_mkc-16_mir-0.1_mg-1_gf-0.005 gg_mkc-16_mir-0.1_mg-1_gf-0.01 gg_mkc-16_mir-0.1_mg-1_gf-0.05 gg_mkc-16_mir-0.1_mg-1_gf-0.1 gg_mkc-16_mir-0.1_mg-2_gf-0.005 gg_mkc-16_mir-0.1_mg-2_gf-0.01 gg_mkc-16_mir-0.1_mg-2_gf-0.05 gg_mkc-16_mir-0.1_mg-2_gf-0.1 gg_mkc-16_mir-0.1_mg-4_gf-0.005 gg_mkc-16_mir-0.1_mg-4_gf-0.01 gg_mkc-16_mir-0.1_mg-4_gf-0.05 gg_mkc-16_mir-0.1_mg-4_gf-0.1 gg_mkc-1_mir-0.005_mg-1_gf-0.005 gg_mkc-1_mir-0.005_mg-1_gf-0.01 gg_mkc-1_mir-0.005_mg-1_gf-0.05 gg_mkc-1_mir-0.005_mg-1_gf-0.1 gg_mkc-1_mir-0.005_mg-2_gf-0.005 gg_mkc-1_mir-0.005_mg-2_gf-0.01 gg_mkc-1_mir-0.005_mg-2_gf-0.05 gg_mkc-1_mir-0.005_mg-2_gf-0.1 gg_mkc-1_mir-0.005_mg-4_gf-0.005 gg_mkc-1_mir-0.005_mg-4_gf-0.01 gg_mkc-1_mir-0.005_mg-4_gf-0.05 gg_mkc-1_mir-0.005_mg-4_gf-0.1 gg_mkc-1_mir-0.01_mg-1_gf-0.005 gg_mkc-1_mir-0.01_mg-1_gf-0.01 gg_mkc-1_mir-0.01_mg-1_gf-0.05 gg_mkc-1_mir-0.01_mg-1_gf-0.1 gg_mkc-1_mir-0.01_mg-2_gf-0.005 gg_mkc-1_mir-0.01_mg-2_gf-0.01 gg_mkc-1_mir-0.01_mg-2_gf-0.05 gg_mkc-1_mir-0.01_mg-2_gf-0.1 gg_mkc-1_mir-0.01_mg-4_gf-0.005 gg_mkc-1_mir-0.01_mg-4_gf-0.01 gg_mkc-1_mir-0.01_mg-4_gf-0.05 gg_mkc-1_mir-0.01_mg-4_gf-0.1 gg_mkc-1_mir-0.05_mg-1_gf-0.005 gg_mkc-1_mir-0.05_mg-1_gf-0.01 gg_mkc-1_mir-0.05_mg-1_gf-0.05 gg_mkc-1_mir-0.05_mg-1_gf-0.1 gg_mkc-1_mir-0.05_mg-2_gf-0.005 gg_mkc-1_mir-0.05_mg-2_gf-0.01 gg_mkc-1_mir-0.05_mg-2_gf-0.05 gg_mkc-1_mir-0.05_mg-2_gf-0.1 gg_mkc-1_mir-0.05_mg-4_gf-0.005 gg_mkc-1_mir-0.05_mg-4_gf-0.01 gg_mkc-1_mir-0.05_mg-4_gf-0.05 gg_mkc-1_mir-0.05_mg-4_gf-0.1 gg_mkc-1_mir-0.1_mg-1_gf-0.005 gg_mkc-1_mir-0.1_mg-1_gf-0.01 gg_mkc-1_mir-0.1_mg-1_gf-0.05 gg_mkc-1_mir-0.1_mg-1_gf-0.1 gg_mkc-1_mir-0.1_mg-2_gf-0.005 gg_mkc-1_mir-0.1_mg-2_gf-0.01 gg_mkc-1_mir-0.1_mg-2_gf-0.05 gg_mkc-1_mir-0.1_mg-2_gf-0.1 gg_mkc-1_mir-0.1_mg-4_gf-0.005 gg_mkc-1_mir-0.1_mg-4_gf-0.01 gg_mkc-1_mir-0.1_mg-4_gf-0.05 gg_mkc-1_mir-0.1_mg-4_gf-0.1 gg_mkc-2_mir-0.005_mg-1_gf-0.005 gg_mkc-2_mir-0.005_mg-1_gf-0.01 gg_mkc-2_mir-0.005_mg-1_gf-0.05 gg_mkc-2_mir-0.005_mg-1_gf-0.1 gg_mkc-2_mir-0.005_mg-2_gf-0.005 gg_mkc-2_mir-0.005_mg-2_gf-0.01 gg_mkc-2_mir-0.005_mg-2_gf-0.05 gg_mkc-2_mir-0.005_mg-2_gf-0.1 gg_mkc-2_mir-0.005_mg-4_gf-0.005 gg_mkc-2_mir-0.005_mg-4_gf-0.01 gg_mkc-2_mir-0.005_mg-4_gf-0.05 gg_mkc-2_mir-0.005_mg-4_gf-0.1 gg_mkc-2_mir-0.01_mg-1_gf-0.005 gg_mkc-2_mir-0.01_mg-1_gf-0.01 gg_mkc-2_mir-0.01_mg-1_gf-0.05 gg_mkc-2_mir-0.01_mg-1_gf-0.1 gg_mkc-2_mir-0.01_mg-2_gf-0.005 gg_mkc-2_mir-0.01_mg-2_gf-0.01 gg_mkc-2_mir-0.01_mg-2_gf-0.05 gg_mkc-2_mir-0.01_mg-2_gf-0.1 gg_mkc-2_mir-0.01_mg-4_gf-0.005 gg_mkc-2_mir-0.01_mg-4_gf-0.01 gg_mkc-2_mir-0.01_mg-4_gf-0.05 gg_mkc-2_mir-0.01_mg-4_gf-0.1 gg_mkc-2_mir-0.05_mg-1_gf-0.005 gg_mkc-2_mir-0.05_mg-1_gf-0.01 gg_mkc-2_mir-0.05_mg-1_gf-0.05 gg_mkc-2_mir-0.05_mg-1_gf-0.1 gg_mkc-2_mir-0.05_mg-2_gf-0.005 gg_mkc-2_mir-0.05_mg-2_gf-0.01 gg_mkc-2_mir-0.05_mg-2_gf-0.05 gg_mkc-2_mir-0.05_mg-2_gf-0.1 gg_mkc-2_mir-0.05_mg-4_gf-0.005 gg_mkc-2_mir-0.05_mg-4_gf-0.01 gg_mkc-2_mir-0.05_mg-4_gf-0.05 gg_mkc-2_mir-0.05_mg-4_gf-0.1 gg_mkc-2_mir-0.1_mg-1_gf-0.005 gg_mkc-2_mir-0.1_mg-1_gf-0.01 gg_mkc-2_mir-0.1_mg-1_gf-0.05 gg_mkc-2_mir-0.1_mg-1_gf-0.1 gg_mkc-2_mir-0.1_mg-2_gf-0.005 gg_mkc-2_mir-0.1_mg-2_gf-0.01 gg_mkc-2_mir-0.1_mg-2_gf-0.05 gg_mkc-2_mir-0.1_mg-2_gf-0.1 gg_mkc-2_mir-0.1_mg-4_gf-0.005 gg_mkc-2_mir-0.1_mg-4_gf-0.01 gg_mkc-2_mir-0.1_mg-4_gf-0.05 gg_mkc-2_mir-0.1_mg-4_gf-0.1 gg_mkc-32_mir-0.005_mg-1_gf-0.005 gg_mkc-32_mir-0.005_mg-1_gf-0.01 gg_mkc-32_mir-0.005_mg-1_gf-0.05 gg_mkc-32_mir-0.005_mg-1_gf-0.1 gg_mkc-32_mir-0.005_mg-2_gf-0.005 gg_mkc-32_mir-0.005_mg-2_gf-0.01 gg_mkc-32_mir-0.005_mg-2_gf-0.05 gg_mkc-32_mir-0.005_mg-2_gf-0.1 gg_mkc-32_mir-0.005_mg-4_gf-0.005 gg_mkc-32_mir-0.005_mg-4_gf-0.01 gg_mkc-32_mir-0.005_mg-4_gf-0.05 gg_mkc-32_mir-0.005_mg-4_gf-0.1 gg_mkc-32_mir-0.01_mg-1_gf-0.005 gg_mkc-32_mir-0.01_mg-1_gf-0.01 gg_mkc-32_mir-0.01_mg-1_gf-0.05 gg_mkc-32_mir-0.01_mg-1_gf-0.1 gg_mkc-32_mir-0.01_mg-2_gf-0.005 gg_mkc-32_mir-0.01_mg-2_gf-0.01 gg_mkc-32_mir-0.01_mg-2_gf-0.05 gg_mkc-32_mir-0.01_mg-2_gf-0.1 gg_mkc-32_mir-0.01_mg-4_gf-0.005 gg_mkc-32_mir-0.01_mg-4_gf-0.01 gg_mkc-32_mir-0.01_mg-4_gf-0.05 gg_mkc-32_mir-0.01_mg-4_gf-0.1 gg_mkc-32_mir-0.05_mg-1_gf-0.005 gg_mkc-32_mir-0.05_mg-1_gf-0.01 gg_mkc-32_mir-0.05_mg-1_gf-0.05 gg_mkc-32_mir-0.05_mg-1_gf-0.1 gg_mkc-32_mir-0.05_mg-2_gf-0.005 gg_mkc-32_mir-0.05_mg-2_gf-0.01 gg_mkc-32_mir-0.05_mg-2_gf-0.05 gg_mkc-32_mir-0.05_mg-2_gf-0.1 gg_mkc-32_mir-0.05_mg-4_gf-0.005 gg_mkc-32_mir-0.05_mg-4_gf-0.01 gg_mkc-32_mir-0.05_mg-4_gf-0.05 gg_mkc-32_mir-0.05_mg-4_gf-0.1 gg_mkc-32_mir-0.1_mg-1_gf-0.005 gg_mkc-32_mir-0.1_mg-1_gf-0.01 gg_mkc-32_mir-0.1_mg-1_gf-0.05 gg_mkc-32_mir-0.1_mg-1_gf-0.1 gg_mkc-32_mir-0.1_mg-2_gf-0.005 gg_mkc-32_mir-0.1_mg-2_gf-0.01 gg_mkc-32_mir-0.1_mg-2_gf-0.05 gg_mkc-32_mir-0.1_mg-2_gf-0.1 gg_mkc-32_mir-0.1_mg-4_gf-0.005 gg_mkc-32_mir-0.1_mg-4_gf-0.01 gg_mkc-32_mir-0.1_mg-4_gf-0.05 gg_mkc-32_mir-0.1_mg-4_gf-0.1 gg_mkc-4_mir-0.005_mg-1_gf-0.005 gg_mkc-4_mir-0.005_mg-1_gf-0.01 gg_mkc-4_mir-0.005_mg-1_gf-0.05 gg_mkc-4_mir-0.005_mg-1_gf-0.1 gg_mkc-4_mir-0.005_mg-2_gf-0.005 gg_mkc-4_mir-0.005_mg-2_gf-0.01 gg_mkc-4_mir-0.005_mg-2_gf-0.05 gg_mkc-4_mir-0.005_mg-2_gf-0.1 gg_mkc-4_mir-0.005_mg-4_gf-0.005 gg_mkc-4_mir-0.005_mg-4_gf-0.05 gg_mkc-4_mir-0.005_mg-4_gf-0.1 gg_mkc-4_mir-0.01_mg-1_gf-0.005 gg_mkc-4_mir-0.01_mg-1_gf-0.01 gg_mkc-4_mir-0.01_mg-1_gf-0.05 gg_mkc-4_mir-0.01_mg-1_gf-0.1 gg_mkc-4_mir-0.01_mg-2_gf-0.005 gg_mkc-4_mir-0.01_mg-2_gf-0.01 gg_mkc-4_mir-0.01_mg-2_gf-0.05 gg_mkc-4_mir-0.01_mg-2_gf-0.1 gg_mkc-4_mir-0.01_mg-4_gf-0.005 gg_mkc-4_mir-0.01_mg-4_gf-0.01 gg_mkc-4_mir-0.01_mg-4_gf-0.05 gg_mkc-4_mir-0.01_mg-4_gf-0.1 gg_mkc-4_mir-0.05_mg-1_gf-0.005 gg_mkc-4_mir-0.05_mg-1_gf-0.01 gg_mkc-4_mir-0.05_mg-1_gf-0.05 gg_mkc-4_mir-0.05_mg-1_gf-0.1 gg_mkc-4_mir-0.05_mg-2_gf-0.005 gg_mkc-4_mir-0.05_mg-2_gf-0.01 gg_mkc-4_mir-0.05_mg-2_gf-0.05 gg_mkc-4_mir-0.05_mg-2_gf-0.1 gg_mkc-4_mir-0.05_mg-4_gf-0.005 gg_mkc-4_mir-0.05_mg-4_gf-0.01 gg_mkc-4_mir-0.05_mg-4_gf-0.05 gg_mkc-4_mir-0.05_mg-4_gf-0.1 gg_mkc-4_mir-0.1_mg-1_gf-0.005 gg_mkc-4_mir-0.1_mg-1_gf-0.01 gg_mkc-4_mir-0.1_mg-1_gf-0.05 gg_mkc-4_mir-0.1_mg-1_gf-0.1 gg_mkc-4_mir-0.1_mg-2_gf-0.005 gg_mkc-4_mir-0.1_mg-2_gf-0.01 gg_mkc-4_mir-0.1_mg-2_gf-0.05 gg_mkc-4_mir-0.1_mg-2_gf-0.1 gg_mkc-4_mir-0.1_mg-4_gf-0.005 gg_mkc-4_mir-0.1_mg-4_gf-0.01 gg_mkc-4_mir-0.1_mg-4_gf-0.05 gg_mkc-4_mir-0.1_mg-4_gf-0.1 gg_mkc-8_mir-0.005_mg-1_gf-0.005 gg_mkc-8_mir-0.005_mg-1_gf-0.01 gg_mkc-8_mir-0.005_mg-1_gf-0.05 gg_mkc-8_mir-0.005_mg-1_gf-0.1 gg_mkc-8_mir-0.005_mg-2_gf-0.005 gg_mkc-8_mir-0.005_mg-2_gf-0.01 gg_mkc-8_mir-0.005_mg-2_gf-0.05 gg_mkc-8_mir-0.005_mg-2_gf-0.1 gg_mkc-8_mir-0.005_mg-4_gf-0.005 gg_mkc-8_mir-0.005_mg-4_gf-0.01 gg_mkc-8_mir-0.005_mg-4_gf-0.05 gg_mkc-8_mir-0.005_mg-4_gf-0.1 gg_mkc-8_mir-0.01_mg-1_gf-0.005 gg_mkc-8_mir-0.01_mg-1_gf-0.01 gg_mkc-8_mir-0.01_mg-1_gf-0.05 gg_mkc-8_mir-0.01_mg-1_gf-0.1 gg_mkc-8_mir-0.01_mg-2_gf-0.005 gg_mkc-8_mir-0.01_mg-2_gf-0.01 gg_mkc-8_mir-0.01_mg-2_gf-0.05 gg_mkc-8_mir-0.01_mg-2_gf-0.1 gg_mkc-8_mir-0.01_mg-4_gf-0.005 gg_mkc-8_mir-0.01_mg-4_gf-0.01 gg_mkc-8_mir-0.01_mg-4_gf-0.05 gg_mkc-8_mir-0.01_mg-4_gf-0.1 gg_mkc-8_mir-0.05_mg-1_gf-0.005 gg_mkc-8_mir-0.05_mg-1_gf-0.01 gg_mkc-8_mir-0.05_mg-1_gf-0.05 gg_mkc-8_mir-0.05_mg-1_gf-0.1 gg_mkc-8_mir-0.05_mg-2_gf-0.005 gg_mkc-8_mir-0.05_mg-2_gf-0.01 gg_mkc-8_mir-0.05_mg-2_gf-0.05 gg_mkc-8_mir-0.05_mg-2_gf-0.1 gg_mkc-8_mir-0.05_mg-4_gf-0.005 gg_mkc-8_mir-0.05_mg-4_gf-0.01 gg_mkc-8_mir-0.05_mg-4_gf-0.05 gg_mkc-8_mir-0.05_mg-4_gf-0.1 gg_mkc-8_mir-0.1_mg-1_gf-0.005 gg_mkc-8_mir-0.1_mg-1_gf-0.01 gg_mkc-8_mir-0.1_mg-1_gf-0.05 gg_mkc-8_mir-0.1_mg-1_gf-0.1 gg_mkc-8_mir-0.1_mg-2_gf-0.005 gg_mkc-8_mir-0.1_mg-2_gf-0.01 gg_mkc-8_mir-0.1_mg-2_gf-0.05 gg_mkc-8_mir-0.1_mg-2_gf-0.1 gg_mkc-8_mir-0.1_mg-4_gf-0.005 gg_mkc-8_mir-0.1_mg-4_gf-0.01 gg_mkc-8_mir-0.1_mg-4_gf-0.1 --transcripts ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta --reference /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --gtf /home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf --gmap_index /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap --strand_specific --left_reads fastqs/merged_Q_IP_UTK_R1.fq.gz --right_reads fastqs/merged_Q_IP_UTK_R3.fq.gz --output_dir outfiles_rnaQUAST-test_Trinity-GG_Q-N/ --busco_lineage BUSCO/saccharomycetes_odb10.2020-08-05.tar.gz --gene_mark --disable_infer_genes --disable_infer_transcripts
```

And here is how I called rnaQUAST from the command line (using variables and arrays):

```txt
rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels ${n_GG[*]} \
    --transcripts ${f_GG[*]} \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --left_reads "fastqs/merged_Q_IP_UTK_R1.fq.gz" \
    --right_reads "fastqs/merged_Q_IP_UTK_R3.fq.gz" \
    --output_dir "outfiles_rnaQUAST-test_Trinity-GG_Q-N/" \
    --busco_lineage "BUSCO/saccharomycetes_odb10.2020-08-05.tar.gz" \
    --gene_mark \
    --disable_infer_genes \
    --disable_infer_transcripts
```

I am thinking that this hang-up is not something real&mdash;although I am not sure. What could be causing the potential hang-up? The symlinked nature of the symlinked fasta assemblies? The compressed BUSCO database?

I posted an issue on the [rnaQUAST GitHub repo](https://github.com/ablab/rnaquast) [here](https://github.com/ablab/rnaquast/issues/14).

In looking over other issues, I saw a comment from the author to run the most recent version of rnaQUAST, version 2.2.2 ([link](https://github.com/ablab/rnaquast/issues/13#issuecomment-1112130505)); in reviewing my `rnaQUAST.log`, I see that rnaQUAST is version 2.0.1, which at this point is some ~3 years old. Apparently, the conda installation selected an older version of rnaQUAST? Indeed, that is the case:

```txt
    rnaquast-2.0.1             |                0         4.9 MB  bioconda
```

What are the versions available via conda/mamba?
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mamba search -c bioconda rnaquast
```

```txt

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

Loading channels: done
# Name                       Version           Build  Channel
rnaquast                       1.5.1               0  bioconda
rnaquast                       2.0.0               0  bioconda
rnaquast                       2.0.1               0  bioconda
rnaquast                       2.1.0               0  bioconda
rnaquast                       2.1.0               1  bioconda
rnaquast                       2.2.0               0  bioconda
rnaquast                       2.2.0      h9ee0642_1  bioconda
rnaquast                       2.2.0      h9ee0642_2  bioconda
rnaquast                       2.2.1      h9ee0642_0  bioconda
```

For some reason, conda/mamba defaulted to installing an outdated version of the program...
</details>
<br />

<a id="next-steps-2023-0220-1110-am"></a>
### Next steps (2023-0220, 11:10 a.m.)
<details>
<summary><i>Notes: Next steps (2023-0220, 11:10 a.m.)</i></summary>

<br />

1. Create a new rnaQUAST environment centered on `rnaquast=2.2.1=h9ee0642_0`
2. Invoke rnaQUAST using only one assembly fasta&mdash;just go with, say, `./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta` together with label `gg_mkc-16_mir-0.005_mg-1_gf-0.005`
3. Run four pilot experiments with the above assembly:
    - One using a symlinked file *without* `--busco_lineage` and `--gene_mark`
    - One using a symlinked file *with* `--busco_lineage` and `--gene_mark`
    - Per [this message from the rnaQUAST developers](https://github.com/ablab/rnaquast/issues/14#issuecomment-1437537096), one without providing reads and *without* `--busco_lineage` and `--gene_mark`
    - Per [this message from the rnaQUAST developers](https://github.com/ablab/rnaquast/issues/14#issuecomment-1437537096), one without providing reads and *with* `--busco_lineage` and `--gene_mark`

In general, the invocations should be like the following:  
e.g., *without `--busco_lineage` and `--gene_mark`*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels ${n_GG[*]} \
    --transcripts ${f_GG[*]} \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --left_reads "fastqs/merged_Q_IP_UTK_R1.fq.gz" \
    --right_reads "fastqs/merged_Q_IP_UTK_R3.fq.gz" \
    --output_dir "outfiles_rnaQUAST-test_Trinity-GG_Q-N/" \
    --disable_infer_genes \
    --disable_infer_transcripts
```

e.g., *with `--busco_lineage` and `--gene_mark`*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels ${n_GG[*]} \
    --transcripts ${f_GG[*]} \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --left_reads "fastqs/merged_Q_IP_UTK_R1.fq.gz" \
    --right_reads "fastqs/merged_Q_IP_UTK_R3.fq.gz" \
    --output_dir "outfiles_rnaQUAST-test_Trinity-GG_Q-N/" \
    --busco_lineage "BUSCO/saccharomycetes_odb10" \
    --gene_mark \
    --disable_infer_genes \
    --disable_infer_transcripts
```
</details>
<br />

<a id="kill-the-initial-run-2023-0220-1200-pm"></a>
### Kill the initial run (2023-0220, 12:00 p.m.)
<details>
<summary><i>Notes: Kill the initial run (2023-0220, 12:00 p.m.)</i></summary>

<br />

Kill the job and `rm` outfiles at 12:00 p.m., 2023-0220; decided to do this because I accidentally used the same outdirectory in my initial call to run 1 below

STDOUT at the time of killing the job:
```txt
/home/kalavatt/miniconda3/envs/rnaquast_env/share/rnaquast-2.0.1-0/rnaQUAST.py -t 32 --labels gg_mkc-16_mir-0.005_mg-1_gf-0.005 gg_mkc-16_mir-0.005_mg-1_gf-0.01 gg_mkc-16_mir-0.005_mg-1_gf-0.05 gg_mkc-16_mir-0.005_mg-1_gf-0.1 gg_mkc-16_mir-0.005_mg-2_gf-0.005 gg_mkc-16_mir-0.005_mg-2_gf-0.01 gg_mkc-16_mir-0.005_mg-2_gf-0.05 gg_mkc-16_mir-0.005_mg-2_gf-0.1 gg_mkc-16_mir-0.005_mg-4_gf-0.005 gg_mkc-16_mir-0.005_mg-4_gf-0.01 gg_mkc-16_mir-0.005_mg-4_gf-0.05 gg_mkc-16_mir-0.005_mg-4_gf-0.1 gg_mkc-16_mir-0.01_mg-1_gf-0.005 gg_mkc-16_mir-0.01_mg-1_gf-0.01 gg_mkc-16_mir-0.01_mg-1_gf-0.1 gg_mkc-16_mir-0.01_mg-2_gf-0.005 gg_mkc-16_mir-0.01_mg-2_gf-0.01 gg_mkc-16_mir-0.01_mg-2_gf-0.05 gg_mkc-16_mir-0.01_mg-2_gf-0.1 gg_mkc-16_mir-0.01_mg-4_gf-0.005 gg_mkc-16_mir-0.01_mg-4_gf-0.01 gg_mkc-16_mir-0.01_mg-4_gf-0.05 gg_mkc-16_mir-0.01_mg-4_gf-0.1 gg_mkc-16_mir-0.05_mg-1_gf-0.005 gg_mkc-16_mir-0.05_mg-1_gf-0.01 gg_mkc-16_mir-0.05_mg-1_gf-0.05 gg_mkc-16_mir-0.05_mg-1_gf-0.1 gg_mkc-16_mir-0.05_mg-2_gf-0.005 gg_mkc-16_mir-0.05_mg-2_gf-0.01 gg_mkc-16_mir-0.05_mg-2_gf-0.05 gg_mkc-16_mir-0.05_mg-2_gf-0.1 gg_mkc-16_mir-0.05_mg-4_gf-0.005 gg_mkc-16_mir-0.05_mg-4_gf-0.01 gg_mkc-16_mir-0.05_mg-4_gf-0.05 gg_mkc-16_mir-0.05_mg-4_gf-0.1 gg_mkc-16_mir-0.1_mg-1_gf-0.005 gg_mkc-16_mir-0.1_mg-1_gf-0.01 gg_mkc-16_mir-0.1_mg-1_gf-0.05 gg_mkc-16_mir-0.1_mg-1_gf-0.1 gg_mkc-16_mir-0.1_mg-2_gf-0.005 gg_mkc-16_mir-0.1_mg-2_gf-0.01 gg_mkc-16_mir-0.1_mg-2_gf-0.05 gg_mkc-16_mir-0.1_mg-2_gf-0.1 gg_mkc-16_mir-0.1_mg-4_gf-0.005 gg_mkc-16_mir-0.1_mg-4_gf-0.01 gg_mkc-16_mir-0.1_mg-4_gf-0.05 gg_mkc-16_mir-0.1_mg-4_gf-0.1 gg_mkc-1_mir-0.005_mg-1_gf-0.005 gg_mkc-1_mir-0.005_mg-1_gf-0.01 gg_mkc-1_mir-0.005_mg-1_gf-0.05 gg_mkc-1_mir-0.005_mg-1_gf-0.1 gg_mkc-1_mir-0.005_mg-2_gf-0.005 gg_mkc-1_mir-0.005_mg-2_gf-0.01 gg_mkc-1_mir-0.005_mg-2_gf-0.05 gg_mkc-1_mir-0.005_mg-2_gf-0.1 gg_mkc-1_mir-0.005_mg-4_gf-0.005 gg_mkc-1_mir-0.005_mg-4_gf-0.01 gg_mkc-1_mir-0.005_mg-4_gf-0.05 gg_mkc-1_mir-0.005_mg-4_gf-0.1 gg_mkc-1_mir-0.01_mg-1_gf-0.005 gg_mkc-1_mir-0.01_mg-1_gf-0.01 gg_mkc-1_mir-0.01_mg-1_gf-0.05 gg_mkc-1_mir-0.01_mg-1_gf-0.1 gg_mkc-1_mir-0.01_mg-2_gf-0.005 gg_mkc-1_mir-0.01_mg-2_gf-0.01 gg_mkc-1_mir-0.01_mg-2_gf-0.05 gg_mkc-1_mir-0.01_mg-2_gf-0.1 gg_mkc-1_mir-0.01_mg-4_gf-0.005 gg_mkc-1_mir-0.01_mg-4_gf-0.01 gg_mkc-1_mir-0.01_mg-4_gf-0.05 gg_mkc-1_mir-0.01_mg-4_gf-0.1 gg_mkc-1_mir-0.05_mg-1_gf-0.005 gg_mkc-1_mir-0.05_mg-1_gf-0.01 gg_mkc-1_mir-0.05_mg-1_gf-0.05 gg_mkc-1_mir-0.05_mg-1_gf-0.1 gg_mkc-1_mir-0.05_mg-2_gf-0.005 gg_mkc-1_mir-0.05_mg-2_gf-0.01 gg_mkc-1_mir-0.05_mg-2_gf-0.05 gg_mkc-1_mir-0.05_mg-2_gf-0.1 gg_mkc-1_mir-0.05_mg-4_gf-0.005 gg_mkc-1_mir-0.05_mg-4_gf-0.01 gg_mkc-1_mir-0.05_mg-4_gf-0.05 gg_mkc-1_mir-0.05_mg-4_gf-0.1 gg_mkc-1_mir-0.1_mg-1_gf-0.005 gg_mkc-1_mir-0.1_mg-1_gf-0.01 gg_mkc-1_mir-0.1_mg-1_gf-0.05 gg_mkc-1_mir-0.1_mg-1_gf-0.1 gg_mkc-1_mir-0.1_mg-2_gf-0.005 gg_mkc-1_mir-0.1_mg-2_gf-0.01 gg_mkc-1_mir-0.1_mg-2_gf-0.05 gg_mkc-1_mir-0.1_mg-2_gf-0.1 gg_mkc-1_mir-0.1_mg-4_gf-0.005 gg_mkc-1_mir-0.1_mg-4_gf-0.01 gg_mkc-1_mir-0.1_mg-4_gf-0.05 gg_mkc-1_mir-0.1_mg-4_gf-0.1 gg_mkc-2_mir-0.005_mg-1_gf-0.005 gg_mkc-2_mir-0.005_mg-1_gf-0.01 gg_mkc-2_mir-0.005_mg-1_gf-0.05 gg_mkc-2_mir-0.005_mg-1_gf-0.1 gg_mkc-2_mir-0.005_mg-2_gf-0.005 gg_mkc-2_mir-0.005_mg-2_gf-0.01 gg_mkc-2_mir-0.005_mg-2_gf-0.05 gg_mkc-2_mir-0.005_mg-2_gf-0.1 gg_mkc-2_mir-0.005_mg-4_gf-0.005 gg_mkc-2_mir-0.005_mg-4_gf-0.01 gg_mkc-2_mir-0.005_mg-4_gf-0.05 gg_mkc-2_mir-0.005_mg-4_gf-0.1 gg_mkc-2_mir-0.01_mg-1_gf-0.005 gg_mkc-2_mir-0.01_mg-1_gf-0.01 gg_mkc-2_mir-0.01_mg-1_gf-0.05 gg_mkc-2_mir-0.01_mg-1_gf-0.1 gg_mkc-2_mir-0.01_mg-2_gf-0.005 gg_mkc-2_mir-0.01_mg-2_gf-0.01 gg_mkc-2_mir-0.01_mg-2_gf-0.05 gg_mkc-2_mir-0.01_mg-2_gf-0.1 gg_mkc-2_mir-0.01_mg-4_gf-0.005 gg_mkc-2_mir-0.01_mg-4_gf-0.01 gg_mkc-2_mir-0.01_mg-4_gf-0.05 gg_mkc-2_mir-0.01_mg-4_gf-0.1 gg_mkc-2_mir-0.05_mg-1_gf-0.005 gg_mkc-2_mir-0.05_mg-1_gf-0.01 gg_mkc-2_mir-0.05_mg-1_gf-0.05 gg_mkc-2_mir-0.05_mg-1_gf-0.1 gg_mkc-2_mir-0.05_mg-2_gf-0.005 gg_mkc-2_mir-0.05_mg-2_gf-0.01 gg_mkc-2_mir-0.05_mg-2_gf-0.05 gg_mkc-2_mir-0.05_mg-2_gf-0.1 gg_mkc-2_mir-0.05_mg-4_gf-0.005 gg_mkc-2_mir-0.05_mg-4_gf-0.01 gg_mkc-2_mir-0.05_mg-4_gf-0.05 gg_mkc-2_mir-0.05_mg-4_gf-0.1 gg_mkc-2_mir-0.1_mg-1_gf-0.005 gg_mkc-2_mir-0.1_mg-1_gf-0.01 gg_mkc-2_mir-0.1_mg-1_gf-0.05 gg_mkc-2_mir-0.1_mg-1_gf-0.1 gg_mkc-2_mir-0.1_mg-2_gf-0.005 gg_mkc-2_mir-0.1_mg-2_gf-0.01 gg_mkc-2_mir-0.1_mg-2_gf-0.05 gg_mkc-2_mir-0.1_mg-2_gf-0.1 gg_mkc-2_mir-0.1_mg-4_gf-0.005 gg_mkc-2_mir-0.1_mg-4_gf-0.01 gg_mkc-2_mir-0.1_mg-4_gf-0.05 gg_mkc-2_mir-0.1_mg-4_gf-0.1 gg_mkc-32_mir-0.005_mg-1_gf-0.005 gg_mkc-32_mir-0.005_mg-1_gf-0.01 gg_mkc-32_mir-0.005_mg-1_gf-0.05 gg_mkc-32_mir-0.005_mg-1_gf-0.1 gg_mkc-32_mir-0.005_mg-2_gf-0.005 gg_mkc-32_mir-0.005_mg-2_gf-0.01 gg_mkc-32_mir-0.005_mg-2_gf-0.05 gg_mkc-32_mir-0.005_mg-2_gf-0.1 gg_mkc-32_mir-0.005_mg-4_gf-0.005 gg_mkc-32_mir-0.005_mg-4_gf-0.01 gg_mkc-32_mir-0.005_mg-4_gf-0.05 gg_mkc-32_mir-0.005_mg-4_gf-0.1 gg_mkc-32_mir-0.01_mg-1_gf-0.005 gg_mkc-32_mir-0.01_mg-1_gf-0.01 gg_mkc-32_mir-0.01_mg-1_gf-0.05 gg_mkc-32_mir-0.01_mg-1_gf-0.1 gg_mkc-32_mir-0.01_mg-2_gf-0.005 gg_mkc-32_mir-0.01_mg-2_gf-0.01 gg_mkc-32_mir-0.01_mg-2_gf-0.05 gg_mkc-32_mir-0.01_mg-2_gf-0.1 gg_mkc-32_mir-0.01_mg-4_gf-0.005 gg_mkc-32_mir-0.01_mg-4_gf-0.01 gg_mkc-32_mir-0.01_mg-4_gf-0.05 gg_mkc-32_mir-0.01_mg-4_gf-0.1 gg_mkc-32_mir-0.05_mg-1_gf-0.005 gg_mkc-32_mir-0.05_mg-1_gf-0.01 gg_mkc-32_mir-0.05_mg-1_gf-0.05 gg_mkc-32_mir-0.05_mg-1_gf-0.1 gg_mkc-32_mir-0.05_mg-2_gf-0.005 gg_mkc-32_mir-0.05_mg-2_gf-0.01 gg_mkc-32_mir-0.05_mg-2_gf-0.05 gg_mkc-32_mir-0.05_mg-2_gf-0.1 gg_mkc-32_mir-0.05_mg-4_gf-0.005 gg_mkc-32_mir-0.05_mg-4_gf-0.01 gg_mkc-32_mir-0.05_mg-4_gf-0.05 gg_mkc-32_mir-0.05_mg-4_gf-0.1 gg_mkc-32_mir-0.1_mg-1_gf-0.005 gg_mkc-32_mir-0.1_mg-1_gf-0.01 gg_mkc-32_mir-0.1_mg-1_gf-0.05 gg_mkc-32_mir-0.1_mg-1_gf-0.1 gg_mkc-32_mir-0.1_mg-2_gf-0.005 gg_mkc-32_mir-0.1_mg-2_gf-0.01 gg_mkc-32_mir-0.1_mg-2_gf-0.05 gg_mkc-32_mir-0.1_mg-2_gf-0.1 gg_mkc-32_mir-0.1_mg-4_gf-0.005 gg_mkc-32_mir-0.1_mg-4_gf-0.01 gg_mkc-32_mir-0.1_mg-4_gf-0.05 gg_mkc-32_mir-0.1_mg-4_gf-0.1 gg_mkc-4_mir-0.005_mg-1_gf-0.005 gg_mkc-4_mir-0.005_mg-1_gf-0.01 gg_mkc-4_mir-0.005_mg-1_gf-0.05 gg_mkc-4_mir-0.005_mg-1_gf-0.1 gg_mkc-4_mir-0.005_mg-2_gf-0.005 gg_mkc-4_mir-0.005_mg-2_gf-0.01 gg_mkc-4_mir-0.005_mg-2_gf-0.05 gg_mkc-4_mir-0.005_mg-2_gf-0.1 gg_mkc-4_mir-0.005_mg-4_gf-0.005 gg_mkc-4_mir-0.005_mg-4_gf-0.05 gg_mkc-4_mir-0.005_mg-4_gf-0.1 gg_mkc-4_mir-0.01_mg-1_gf-0.005 gg_mkc-4_mir-0.01_mg-1_gf-0.01 gg_mkc-4_mir-0.01_mg-1_gf-0.05 gg_mkc-4_mir-0.01_mg-1_gf-0.1 gg_mkc-4_mir-0.01_mg-2_gf-0.005 gg_mkc-4_mir-0.01_mg-2_gf-0.01 gg_mkc-4_mir-0.01_mg-2_gf-0.05 gg_mkc-4_mir-0.01_mg-2_gf-0.1 gg_mkc-4_mir-0.01_mg-4_gf-0.005 gg_mkc-4_mir-0.01_mg-4_gf-0.01 gg_mkc-4_mir-0.01_mg-4_gf-0.05 gg_mkc-4_mir-0.01_mg-4_gf-0.1 gg_mkc-4_mir-0.05_mg-1_gf-0.005 gg_mkc-4_mir-0.05_mg-1_gf-0.01 gg_mkc-4_mir-0.05_mg-1_gf-0.05 gg_mkc-4_mir-0.05_mg-1_gf-0.1 gg_mkc-4_mir-0.05_mg-2_gf-0.005 gg_mkc-4_mir-0.05_mg-2_gf-0.01 gg_mkc-4_mir-0.05_mg-2_gf-0.05 gg_mkc-4_mir-0.05_mg-2_gf-0.1 gg_mkc-4_mir-0.05_mg-4_gf-0.005 gg_mkc-4_mir-0.05_mg-4_gf-0.01 gg_mkc-4_mir-0.05_mg-4_gf-0.05 gg_mkc-4_mir-0.05_mg-4_gf-0.1 gg_mkc-4_mir-0.1_mg-1_gf-0.005 gg_mkc-4_mir-0.1_mg-1_gf-0.01 gg_mkc-4_mir-0.1_mg-1_gf-0.05 gg_mkc-4_mir-0.1_mg-1_gf-0.1 gg_mkc-4_mir-0.1_mg-2_gf-0.005 gg_mkc-4_mir-0.1_mg-2_gf-0.01 gg_mkc-4_mir-0.1_mg-2_gf-0.05 gg_mkc-4_mir-0.1_mg-2_gf-0.1 gg_mkc-4_mir-0.1_mg-4_gf-0.005 gg_mkc-4_mir-0.1_mg-4_gf-0.01 gg_mkc-4_mir-0.1_mg-4_gf-0.05 gg_mkc-4_mir-0.1_mg-4_gf-0.1 gg_mkc-8_mir-0.005_mg-1_gf-0.005 gg_mkc-8_mir-0.005_mg-1_gf-0.01 gg_mkc-8_mir-0.005_mg-1_gf-0.05 gg_mkc-8_mir-0.005_mg-1_gf-0.1 gg_mkc-8_mir-0.005_mg-2_gf-0.005 gg_mkc-8_mir-0.005_mg-2_gf-0.01 gg_mkc-8_mir-0.005_mg-2_gf-0.05 gg_mkc-8_mir-0.005_mg-2_gf-0.1 gg_mkc-8_mir-0.005_mg-4_gf-0.005 gg_mkc-8_mir-0.005_mg-4_gf-0.01 gg_mkc-8_mir-0.005_mg-4_gf-0.05 gg_mkc-8_mir-0.005_mg-4_gf-0.1 gg_mkc-8_mir-0.01_mg-1_gf-0.005 gg_mkc-8_mir-0.01_mg-1_gf-0.01 gg_mkc-8_mir-0.01_mg-1_gf-0.05 gg_mkc-8_mir-0.01_mg-1_gf-0.1 gg_mkc-8_mir-0.01_mg-2_gf-0.005 gg_mkc-8_mir-0.01_mg-2_gf-0.01 gg_mkc-8_mir-0.01_mg-2_gf-0.05 gg_mkc-8_mir-0.01_mg-2_gf-0.1 gg_mkc-8_mir-0.01_mg-4_gf-0.005 gg_mkc-8_mir-0.01_mg-4_gf-0.01 gg_mkc-8_mir-0.01_mg-4_gf-0.05 gg_mkc-8_mir-0.01_mg-4_gf-0.1 gg_mkc-8_mir-0.05_mg-1_gf-0.005 gg_mkc-8_mir-0.05_mg-1_gf-0.01 gg_mkc-8_mir-0.05_mg-1_gf-0.05 gg_mkc-8_mir-0.05_mg-1_gf-0.1 gg_mkc-8_mir-0.05_mg-2_gf-0.005 gg_mkc-8_mir-0.05_mg-2_gf-0.01 gg_mkc-8_mir-0.05_mg-2_gf-0.05 gg_mkc-8_mir-0.05_mg-2_gf-0.1 gg_mkc-8_mir-0.05_mg-4_gf-0.005 gg_mkc-8_mir-0.05_mg-4_gf-0.01 gg_mkc-8_mir-0.05_mg-4_gf-0.05 gg_mkc-8_mir-0.05_mg-4_gf-0.1 gg_mkc-8_mir-0.1_mg-1_gf-0.005 gg_mkc-8_mir-0.1_mg-1_gf-0.01 gg_mkc-8_mir-0.1_mg-1_gf-0.05 gg_mkc-8_mir-0.1_mg-1_gf-0.1 gg_mkc-8_mir-0.1_mg-2_gf-0.005 gg_mkc-8_mir-0.1_mg-2_gf-0.01 gg_mkc-8_mir-0.1_mg-2_gf-0.05 gg_mkc-8_mir-0.1_mg-2_gf-0.1 gg_mkc-8_mir-0.1_mg-4_gf-0.005 gg_mkc-8_mir-0.1_mg-4_gf-0.01 gg_mkc-8_mir-0.1_mg-4_gf-0.1 --transcripts ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta ./Trinity_GG.Q_N/trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta --reference /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --gtf /home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf --gmap_index /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap --strand_specific --left_reads fastqs/merged_Q_IP_UTK_R1.fq.gz --right_reads fastqs/merged_Q_IP_UTK_R3.fq.gz --output_dir outfiles_rnaQUAST-test_Trinity-GG_Q-N/ --busco_lineage BUSCO/saccharomycetes_odb10.2020-08-05.tar.gz --gene_mark --disable_infer_genes --disable_infer_transcripts

rnaQUAST version: 2.0.1

System information:
  OS: Linux-4.15.0-192-generic-x86_64-with-debian-buster-sid (linux_64)
  Python version: 3.6.13
  CPUs number: 36

External tools:
  matplotlib version: 3.3.4
  joblib version: 1.0.1
  gffutils version: 0.11.1
  blastn version: 2.5.0+
  makeblastdb version: 2.5.0+
  gmap version: 2021-08-25

Started: 2023-02-18 17:49:38

Logging to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/rnaQUAST.log

2023-02-18 17:49:39
Getting reference...
Done.
Using strand specific transcripts...

2023-02-18 17:49:39
Creating sqlite3 db by gffutils...
2023-02-18 17:49:43,397 - INFO - Committing changes: 41000 features
2023-02-18 17:49:43,691 - INFO - Populating features table and first-order relations: 41878 features
2023-02-18 17:49:43,706 - INFO - Creating relations(parent) index
2023-02-18 17:49:43,735 - INFO - Creating relations(child) index
2023-02-18 17:49:43,761 - INFO - Creating features(featuretype) index
2023-02-18 17:49:43,773 - INFO - Creating features (seqid, start, end) index
2023-02-18 17:49:43,793 - INFO - Creating features (seqid, start, end, strand) index
2023-02-18 17:49:43,813 - INFO - Running ANALYZE features
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/Saccharomyces_cerevisiae.R64-1-1.108.db.

2023-02-18 17:49:44
Loading sqlite3 db by gffutils from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/Saccharomyces_cerevisiae.R64-1-$
.108.db to memory...
Done.

2023-02-18 17:49:44
Getting GENE DATABASE metrics...
Done.

Sets maximum intron size equal 2583. Default is 1500000 bp.


2023-02-18 17:51:09
Sorting exons attributes...
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
Done.

2023-02-18 17:51:12
Running STAR...

2023-02-18 17:51:12
  STAR --runMode genomeGenerate --runThreadN 32 --genomeDir /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/tmp/star_out/tmp_dir/genome_dir --genomeFastaFiles /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --genomeSAindexNbases 10.0 1>> /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.out.log 2>> /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.err.log
    logs can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.out.log and /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.err.log.

2023-02-18 17:51:16
  STAR --runThreadN 32 --genomeDir /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/tmp/star_out/genome_dir --readFilesIn /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/fastqs/merged_Q_IP_UTK_R1.fq.gz /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/fastqs/merged_Q_IP_UTK_R3.fq.gz --outFileNamePrefix /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/tmp/star_out/ --outSAMtype SAM --limitBAMsortRAM 1000706316 --readFilesCommand zcat 1>> /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.out.log 2>> /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.err.log
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/tmp/star_out.
  logs can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.out.log and /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N/logs/STAR.err.log.

2023-02-18 17:55:33
Getting database coverage by reads...

[Errno 116] Stale file handle
Traceback (most recent call last):
  File "/home/kalavatt/miniconda3/envs/rnaquast_env/bin/rnaQUAST.py", line 348, in <module>
    return_code = main_utils()
  File "/home/kalavatt/miniconda3/envs/rnaquast_env/bin/rnaQUAST.py", line 171, in main_utils
    genome_len, tmp_dir, args.threads, WELL_FULLY_COVERAGE_THRESHOLDS, logger, log_dir)
  File "/home/kalavatt/miniconda3/envs/rnaquast_env/share/rnaquast-2.0.1-0/metrics/ReadsCoverage.py", line 52, in __init__
    WELL_FULLY_COVERAGE_THRESHOLDS, logger, log_dir)
  File "/home/kalavatt/miniconda3/envs/rnaquast_env/share/rnaquast-2.0.1-0/metrics/ReadsCoverage.py", line 71, in get_database_coverage_by_reads
    for line in in_handle:
OSError: [Errno 116] Stale file handle

ERROR! Exception caught!

In case you have troubles running rnaQUAST, you can write to rnaquast_support@ablab.spbau.ru
Please provide us with rnaQUAST.log file from the output directory.
```
</details>
<br />
<br />

<a id="install-up-to-date-rnaquast-in-its-own-environment-2023-0220"></a>
## Install up-to-date rnaQUAST in its own environment (2023-0220)
<a id="code-6"></a>
### Code
<details>
<summary><i>Code: Install up-to-date rnaQUAST in its own environment (2023-0220)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 1, etc.

mamba create \
    -n rnaquast_curr_env \
    -c bioconda \
        rnaquast=2.2.1=h9ee0642_0

exit

rm -r outfiles_rnaQUAST-test_Trinity-GG_Q-N/
```
</details>
<br />

<a id="printed-3"></a>
### Printed
<details>
<summary><i>Printed: Install up-to-date rnaQUAST in its own environment (2023-0220)</i></summary>

```txt
❯ mamba create \
>     -n rnaquast_curr_env \
>     -c bioconda \
>         rnaquast=2.2.1=h9ee0642_0

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


Looking for: ['rnaquast==2.2.1=h9ee0642_0']

bioconda/linux-64                                             No change
bioconda/noarch                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
pkgs/r/linux-64                                               No change
pkgs/main/linux-64                                   5.2MB @   4.8MB/s  1.3s
conda-forge/noarch                                  11.3MB @   4.4MB/s  2.8s
conda-forge/linux-64                                29.8MB @   5.1MB/s  6.7s
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/rnaquast_curr_env

  Updating specs:

   - rnaquast==2.2.1=h9ee0642_0


  Package                                 Version  Build                 Channel                    Size
──────────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────────────────────────

  + _libgcc_mutex                             0.1  conda_forge           conda-forge/linux-64     Cached
  + _openmp_mutex                             4.5  2_gnu                 conda-forge/linux-64     Cached
  + _r-mutex                                1.0.1  anacondar_1           conda-forge/noarch       Cached
  + alsa-lib                                1.2.8  h166bdaf_0            conda-forge/linux-64      592kB
  + argcomplete                             2.0.0  pyhd8ed1ab_0          conda-forge/noarch         35kB
  + argh                                   0.26.2  pyh9f0ad1d_1002       conda-forge/noarch         26kB
  + augustus                                3.5.0  pl5321hf46c7bb_1      bioconda/linux-64          33MB
  + bamtools                                2.5.1  hd03093a_10           bioconda/linux-64           1MB
  + bbmap                                   39.01  h5c4e2a8_0            bioconda/linux-64           9MB
  + binutils_impl_linux-64                   2.40  hf600244_0            conda-forge/linux-64     Cached
  + biopython                                1.79  py37h540881e_2        conda-forge/linux-64        3MB
  + blast                                  2.13.0  hf3cf87c_0            bioconda/linux-64          24MB
  + blat                                       35  1                     bioconda/linux-64        Cached
  + boost-cpp                              1.74.0  h75c5d50_8            conda-forge/linux-64       17MB
  + bottleneck                              1.3.5  py37hda87dfa_0        conda-forge/linux-64      129kB
  + brotli                                  1.0.9  h166bdaf_8            conda-forge/linux-64       19kB
  + brotli-bin                              1.0.9  h166bdaf_8            conda-forge/linux-64       20kB
  + busco                                   5.4.5  pyhdfd78af_0          bioconda/noarch           343kB
  + bwidget                                1.9.14  ha770c72_1            conda-forge/linux-64     Cached
  + bzip2                                   1.0.8  h7f98852_4            conda-forge/linux-64     Cached
  + c-ares                                 1.18.1  h7f98852_0            conda-forge/linux-64     Cached
  + ca-certificates                     2022.12.7  ha878542_0            conda-forge/linux-64     Cached
  + cairo                                  1.16.0  ha61ee94_1014         conda-forge/linux-64     Cached
  + cdbtools                                 0.99  hd03093a_7            bioconda/linux-64          72kB
  + certifi                             2022.12.7  pyhd8ed1ab_0          conda-forge/noarch       Cached
  + curl                                   7.87.0  h6312ad2_0            conda-forge/linux-64       88kB
  + cycler                                 0.11.0  pyhd8ed1ab_0          conda-forge/noarch         10kB
  + dendropy                                4.5.2  pyh3252c3a_0          bioconda/noarch           315kB
  + diamond                                2.0.15  hb97b32f_1            bioconda/linux-64           3MB
  + emboss                                  6.6.0  haa49230_5            bioconda/linux-64          98MB
  + entrez-direct                            16.2  he881be0_1            bioconda/linux-64           8MB
  + expat                                   2.5.0  h27087fc_0            conda-forge/linux-64     Cached
  + font-ttf-dejavu-sans-mono                2.37  hab24e00_0            conda-forge/noarch       Cached
  + font-ttf-inconsolata                    3.000  h77eed37_0            conda-forge/noarch       Cached
  + font-ttf-source-code-pro                2.038  h77eed37_0            conda-forge/noarch       Cached
  + font-ttf-ubuntu                          0.83  hab24e00_0            conda-forge/noarch       Cached
  + fontconfig                             2.14.2  h14ed4e7_0            conda-forge/linux-64     Cached
  + fonts-conda-ecosystem                       1  0                     conda-forge/noarch       Cached
  + fonts-conda-forge                           1  0                     conda-forge/noarch       Cached
  + fonttools                              4.38.0  py37h540881e_0        conda-forge/linux-64        2MB
  + freetype                               2.12.1  hca18f0e_1            conda-forge/linux-64     Cached
  + fribidi                                1.0.10  h36c2ea0_0            conda-forge/linux-64     Cached
  + gawk                                    5.1.0  h7f98852_0            conda-forge/linux-64        1MB
  + gcc_impl_linux-64                      12.2.0  hcc96c02_19           conda-forge/linux-64     Cached
  + gettext                                0.21.1  h27087fc_0            conda-forge/linux-64     Cached
  + gffutils                               0.11.1  pyh7cba7a3_0          bioconda/noarch          Cached
  + gfortran_impl_linux-64                 12.2.0  h55be85b_19           conda-forge/linux-64     Cached
  + giflib                                  5.2.1  h36c2ea0_2            conda-forge/linux-64       79kB
  + gmap                               2017.11.15  h2f06484_4            bioconda/linux-64          41MB
  + gmp                                     6.2.1  h58526e2_0            conda-forge/linux-64      826kB
  + graphite2                              1.3.13  h58526e2_1001         conda-forge/linux-64     Cached
  + gsl                                       2.7  he838d99_0            conda-forge/linux-64     Cached
  + gxx_impl_linux-64                      12.2.0  hcc96c02_19           conda-forge/linux-64     Cached
  + harfbuzz                                6.0.0  h8e241bc_0            conda-forge/linux-64     Cached
  + hmmer                                   3.1b2  3                     bioconda/linux-64           6MB
  + htslib                                   1.16  h6bc39ce_0            bioconda/linux-64           2MB
  + icu                                      70.1  h27087fc_0            conda-forge/linux-64     Cached
  + importlib-metadata                     4.11.4  py37h89c1867_0        conda-forge/linux-64       34kB
  + importlib_metadata                     4.11.4  hd8ed1ab_0            conda-forge/noarch          4kB
  + joblib                                  1.2.0  pyhd8ed1ab_0          conda-forge/noarch        210kB
  + jpeg                                       9e  h0b41bf4_3            conda-forge/linux-64     Cached
  + kernel-headers_linux-64                2.6.32  he073ed8_15           conda-forge/noarch       Cached
  + keyutils                                1.6.1  h166bdaf_0            conda-forge/linux-64     Cached
  + kiwisolver                              1.4.4  py37h7cecad7_0        conda-forge/linux-64       75kB
  + krb5                                   1.20.1  hf9c8cef_0            conda-forge/linux-64        1MB
  + lcms2                                    2.14  h6ed2654_0            conda-forge/linux-64      262kB
  + ld_impl_linux-64                         2.40  h41732ed_0            conda-forge/linux-64     Cached
  + lerc                                    4.0.0  h27087fc_0            conda-forge/linux-64     Cached
  + libblas                                 3.9.0  16_linux64_openblas   conda-forge/linux-64     Cached
  + libbrotlicommon                         1.0.9  h166bdaf_8            conda-forge/linux-64       67kB
  + libbrotlidec                            1.0.9  h166bdaf_8            conda-forge/linux-64       34kB
  + libbrotlienc                            1.0.9  h166bdaf_8            conda-forge/linux-64      295kB
  + libcblas                                3.9.0  16_linux64_openblas   conda-forge/linux-64     Cached
  + libcups                                 2.3.3  h36d4200_3            conda-forge/linux-64        5MB
  + libcurl                                7.87.0  h6312ad2_0            conda-forge/linux-64      347kB
  + libdeflate                               1.13  h166bdaf_0            conda-forge/linux-64       80kB
  + libedit                          3.1.20191231  he28a2e2_2            conda-forge/linux-64     Cached
  + libev                                    4.33  h516909a_1            conda-forge/linux-64     Cached
  + libffi                                  3.4.2  h7f98852_5            conda-forge/linux-64     Cached
  + libgcc-devel_linux-64                  12.2.0  h3b97bd3_19           conda-forge/linux-64     Cached
  + libgcc-ng                              12.2.0  h65d4601_19           conda-forge/linux-64     Cached
  + libgd                                   2.3.3  h18fbbfe_3            conda-forge/linux-64      272kB
  + libgfortran-ng                         12.2.0  h69a702a_19           conda-forge/linux-64     Cached
  + libgfortran5                           12.2.0  h337968e_19           conda-forge/linux-64     Cached
  + libglib                                2.74.1  h606061b_1            conda-forge/linux-64     Cached
  + libgomp                                12.2.0  h65d4601_19           conda-forge/linux-64     Cached
  + libhwloc                                2.8.0  h32351e8_1            conda-forge/linux-64        3MB
  + libiconv                                 1.17  h166bdaf_0            conda-forge/linux-64     Cached
  + libidn2                                 2.3.4  h166bdaf_0            conda-forge/linux-64      160kB
  + liblapack                               3.9.0  16_linux64_openblas   conda-forge/linux-64     Cached
  + libnghttp2                             1.51.0  hdcd2b5c_0            conda-forge/linux-64     Cached
  + libnsl                                  2.0.0  h7f98852_0            conda-forge/linux-64     Cached
  + libopenblas                            0.3.21  pthreads_h78a6416_3   conda-forge/linux-64     Cached
  + libpng                                 1.6.39  h753d276_0            conda-forge/linux-64     Cached
  + libsanitizer                           12.2.0  h46fd767_19           conda-forge/linux-64     Cached
  + libsqlite                              3.40.0  h753d276_0            conda-forge/linux-64     Cached
  + libssh2                                1.10.0  haa6b8db_3            conda-forge/linux-64     Cached
  + libstdcxx-devel_linux-64               12.2.0  h3b97bd3_19           conda-forge/linux-64     Cached
  + libstdcxx-ng                           12.2.0  h46fd767_19           conda-forge/linux-64     Cached
  + libtiff                                 4.4.0  h0e0dad5_3            conda-forge/linux-64      658kB
  + libunistring                           0.9.10  h7f98852_0            conda-forge/linux-64        1MB
  + libuuid                                2.32.1  h7f98852_1000         conda-forge/linux-64     Cached
  + libwebp                                 1.2.4  h522a892_0            conda-forge/linux-64       90kB
  + libwebp-base                            1.2.4  h166bdaf_0            conda-forge/linux-64     Cached
  + libxcb                                   1.13  h7f98852_1004         conda-forge/linux-64     Cached
  + libxml2                                2.10.3  h7463322_0            conda-forge/linux-64     Cached
  + libzlib                                1.2.13  h166bdaf_4            conda-forge/linux-64     Cached
  + lp_solve                              5.5.2.5  h14c3975_1001         conda-forge/linux-64      429kB
  + make                                      4.3  hd18ef5c_1            conda-forge/linux-64     Cached
  + matplotlib-base                         3.5.3  py37hf395dca_2        conda-forge/linux-64        8MB
  + metaeuk                             6.a5d39d9  pl5321hf1761c0_1      bioconda/linux-64           4MB
  + metis                                   5.1.0  h58526e2_1006         conda-forge/linux-64        4MB
  + mpfr                                    4.1.0  h9202a9a_1            conda-forge/linux-64        3MB
  + munkres                                 1.0.7  py_1                  bioconda/noarch            10kB
  + mysql-connector-c                      6.1.11  h6eb9d5d_1007         conda-forge/linux-64        3MB
  + ncurses                                   6.3  h27087fc_1            conda-forge/linux-64     Cached
  + nomkl                                     1.0  h5ca1d4c_0            conda-forge/noarch          4kB
  + numexpr                                 2.8.3  py37h85a3170_100      conda-forge/linux-64      137kB
  + numpy                                  1.21.6  py37h976b520_0        conda-forge/linux-64        6MB
  + openjdk                                17.0.3  h58dac75_5            conda-forge/linux-64      169MB
  + openjpeg                                2.5.0  h7d73246_1            conda-forge/linux-64      546kB
  + openssl                                1.1.1t  h0b41bf4_0            conda-forge/linux-64     Cached
  + packaging                                23.0  pyhd8ed1ab_0          conda-forge/noarch         41kB
  + pandas                                  1.3.5  py37h8c16a72_0        pkgs/main/linux-64         10MB
  + pango                                 1.50.13  hd33c08f_0            conda-forge/linux-64      437kB
  + pbzip2                                 1.1.13  0                     conda-forge/linux-64     Cached
  + pcre                                     8.45  h9c3ff4c_0            conda-forge/linux-64      259kB
  + pcre2                                   10.40  hc3806b6_0            conda-forge/linux-64     Cached
  + perl                                   5.32.1  2_h7f98852_perl5      conda-forge/linux-64     Cached
  + perl-apache-test                         1.43  pl5321hdfd78af_0      bioconda/noarch           122kB
  + perl-app-cpanminus                     1.7046  pl5321hd8ed1ab_0      conda-forge/noarch        245kB
  + perl-archive-tar                         2.40  pl5321hdfd78af_0      bioconda/noarch            34kB
  + perl-base                                2.23  pl5321hdfd78af_2      bioconda/noarch            12kB
  + perl-carp                                1.38  pl5321hdfd78af_4      bioconda/noarch            17kB
  + perl-class-load                          0.25  pl5321hdfd78af_1      bioconda/noarch            14kB
  + perl-class-load-xs                       0.10  pl5321h9f5acd7_6      bioconda/linux-64          14kB
  + perl-class-method-modifiers              2.13  pl5321hdfd78af_0      bioconda/noarch            16kB
  + perl-common-sense                        3.75  pl5321hdfd78af_0      bioconda/noarch            14kB
  + perl-compress-raw-bzip2                 2.201  pl5321h87f3376_1      bioconda/linux-64          49kB
  + perl-compress-raw-zlib                  2.105  pl5321h87f3376_0      bioconda/linux-64          77kB
  + perl-constant                            1.33  pl5321hdfd78af_2      bioconda/noarch            12kB
  + perl-cpan-meta                       2.150010  pl5321hdfd78af_1      bioconda/noarch             6kB
  + perl-cpan-meta-check                    0.014  pl5321hdfd78af_1      bioconda/noarch            10kB
  + perl-cpan-meta-requirements             2.140  pl5321hdfd78af_1      bioconda/noarch            13kB
  + perl-cpan-meta-yaml                     0.018  pl5321hdfd78af_1      bioconda/noarch            14kB
  + perl-data-dumper                        2.183  pl5321hec16e2b_1      bioconda/linux-64          38kB
  + perl-data-optlist                       0.113  pl5321ha770c72_0      conda-forge/linux-64       19kB
  + perl-dbi                                1.643  pl5321hec16e2b_1      bioconda/linux-64         619kB
  + perl-devel-globaldestruction             0.14  pl5321hdfd78af_1      bioconda/noarch            10kB
  + perl-devel-overloadinfo                 0.007  pl5321hdfd78af_0      bioconda/noarch            11kB
  + perl-devel-stacktrace                    2.04  pl5321hdfd78af_1      bioconda/noarch            17kB
  + perl-dist-checkconflicts                 0.11  pl5321hdfd78af_3      bioconda/noarch            12kB
  + perl-encode                              3.19  pl5321hec16e2b_1      bioconda/linux-64           2MB
  + perl-eval-closure                        0.14  pl5321h9f5acd7_6      bioconda/linux-64          13kB
  + perl-exporter                            5.72  pl5321hdfd78af_2      bioconda/noarch            16kB
  + perl-exporter-tiny                   1.002002  pl5321hdfd78af_0      bioconda/noarch            25kB
  + perl-extutils-cbuilder               0.280230  pl5321hdfd78af_2      bioconda/noarch            23kB
  + perl-extutils-makemaker                  7.66  pl5321hd8ed1ab_0      conda-forge/noarch        157kB
  + perl-extutils-manifest                   1.73  pl5321hdfd78af_0      bioconda/noarch            15kB
  + perl-extutils-parsexs                    3.44  pl5321hdfd78af_0      bioconda/noarch            42kB
  + perl-file-path                           2.18  pl5321hd8ed1ab_0      conda-forge/noarch         22kB
  + perl-file-temp                         0.2304  pl5321hd8ed1ab_0      conda-forge/noarch         32kB
  + perl-file-which                          1.24  pl5321hd8ed1ab_0      conda-forge/noarch         17kB
  + perl-getopt-long                         2.54  pl5321hdfd78af_0      bioconda/noarch            32kB
  + perl-io-compress                        2.201  pl5321h87f3376_0      bioconda/linux-64          86kB
  + perl-io-zlib                             1.14  pl5321hdfd78af_0      bioconda/noarch            12kB
  + perl-ipc-cmd                             1.04  pl5321hdfd78af_0      bioconda/noarch            25kB
  + perl-json                                4.10  pl5321hdfd78af_0      bioconda/noarch            57kB
  + perl-json-pp                             4.11  pl5321hdfd78af_0      bioconda/noarch            34kB
  + perl-json-xs                             2.34  pl5321h9f5acd7_5      bioconda/linux-64          65kB
  + perl-list-moreutils                     0.430  pl5321hdfd78af_0      bioconda/noarch            32kB
  + perl-list-moreutils-xs                  0.430  pl5321hec16e2b_1      bioconda/linux-64          50kB
  + perl-locale-maketext-simple              0.21  pl5321hdfd78af_3      bioconda/noarch            11kB
  + perl-module-build                      0.4231  pl5321hdfd78af_0      bioconda/noarch           131kB
  + perl-module-corelist               5.20220620  pl5321hdfd78af_0      bioconda/noarch            67kB
  + perl-module-implementation               0.09  pl5321hdfd78af_3      bioconda/noarch            12kB
  + perl-module-load                         0.34  pl5321hdfd78af_0      bioconda/noarch             6kB
  + perl-module-load-conditional             0.68  pl5321hdfd78af_3      bioconda/noarch            12kB
  + perl-module-metadata                 1.000037  pl5321hdfd78af_0      bioconda/noarch            18kB
  + perl-module-runtime                     0.016  pl5321hdfd78af_2      bioconda/noarch            17kB
  + perl-module-runtime-conflicts           0.003  pl5321hdfd78af_1      bioconda/noarch             9kB
  + perl-moo                             2.005004  pl5321hdfd78af_0      bioconda/noarch            42kB
  + perl-moose                             2.2202  pl5321hec16e2b_0      bioconda/linux-64         457kB
  + perl-mro-compat                          0.15  pl5321hdfd78af_0      bioconda/noarch            13kB
  + perl-package-deprecationmanager          0.17  pl5321hdfd78af_1      bioconda/noarch            13kB
  + perl-package-stash                       0.40  pl5321h87f3376_1      bioconda/linux-64         124kB
  + perl-package-stash-xs                    0.30  pl5321h0b41bf4_0      conda-forge/linux-64       29kB
  + perl-parallel-forkmanager                2.02  pl5321hdfd78af_1      bioconda/noarch            23kB
  + perl-params-check                        0.38  pl5321hdfd78af_2      bioconda/noarch             6kB
  + perl-params-util                        1.102  pl5321h9f5acd7_1      bioconda/linux-64          24kB
  + perl-parent                             0.236  pl5321hdfd78af_2      bioconda/noarch             8kB
  + perl-pathtools                           3.75  pl5321hec16e2b_3      bioconda/linux-64          43kB
  + perl-perl-ostype                        1.010  pl5321hdfd78af_2      bioconda/noarch             9kB
  + perl-role-tiny                       2.002004  pl5321hdfd78af_0      bioconda/noarch            17kB
  + perl-scalar-list-utils                   1.62  pl5321hec16e2b_1      bioconda/linux-64          45kB
  + perl-storable                            3.15  pl5321hec16e2b_3      bioconda/linux-64          65kB
  + perl-sub-exporter                       0.988  pl5321hdfd78af_0      bioconda/noarch            38kB
  + perl-sub-exporter-progressive        0.001013  pl5321hdfd78af_1      bioconda/noarch            10kB
  + perl-sub-identify                        0.14  pl5321hec16e2b_2      bioconda/linux-64          14kB
  + perl-sub-install                        0.928  pl5321hdfd78af_3      bioconda/noarch            12kB
  + perl-sub-name                            0.21  pl5321hec16e2b_3      bioconda/linux-64          15kB
  + perl-sub-quote                       2.006006  pl5321hdfd78af_0      bioconda/noarch            20kB
  + perl-test-fatal                         0.016  pl5321hdfd78af_0      bioconda/noarch            13kB
  + perl-text-abbrev                         1.02  pl5321hdfd78af_1      bioconda/noarch             8kB
  + perl-text-parsewords                     3.31  pl5321hdfd78af_0      bioconda/noarch            10kB
  + perl-try-tiny                            0.31  pl5321hdfd78af_1      bioconda/noarch            20kB
  + perl-types-serialiser                    1.01  pl5321hdfd78af_0      bioconda/noarch            13kB
  + perl-version                           0.9924  pl5321hec16e2b_2      bioconda/linux-64          25kB
  + perl-xsloader                            0.24  pl5321hd8ed1ab_0      conda-forge/noarch         14kB
  + perl-yaml                                1.30  pl5321hdfd78af_0      bioconda/noarch            44kB
  + pillow                                  9.2.0  py37h850a105_2        conda-forge/linux-64       47MB
  + pip                                    23.0.1  pyhd8ed1ab_0          conda-forge/noarch       Cached
  + pixman                                 0.40.0  h36c2ea0_0            conda-forge/linux-64     Cached
  + prodigal                                2.6.3  hec16e2b_4            bioconda/linux-64         795kB
  + pthread-stubs                             0.4  h36c2ea0_1001         conda-forge/linux-64     Cached
  + pyfaidx                                 0.7.1  pyh5e36f6f_0          bioconda/noarch            33kB
  + pyparsing                               3.0.9  pyhd8ed1ab_0          conda-forge/noarch         81kB
  + pysam                                  0.20.0  py37hee149a5_0        bioconda/linux-64           3MB
  + python                                 3.7.12  hb7a2778_100_cpython  conda-forge/linux-64       60MB
  + python-dateutil                         2.8.2  pyhd8ed1ab_0          conda-forge/noarch        246kB
  + python_abi                                3.7  3_cp37m               conda-forge/linux-64        6kB
  + pytz                                 2022.7.1  pyhd8ed1ab_0          conda-forge/noarch        186kB
  + pyvcf3                                  1.0.3  pyhdfd78af_0          bioconda/noarch           980kB
  + r-base                                  4.2.2  h6b4767f_2            conda-forge/linux-64       25MB
  + r-cli                                   3.6.0  r42h38f115c_0         conda-forge/linux-64     Cached
  + r-colorspace                            2.1_0  r42h133d619_0         conda-forge/linux-64     Cached
  + r-crayon                                1.5.2  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-ellipsis                              0.3.2  r42h06615bd_1         conda-forge/linux-64     Cached
  + r-fansi                                 1.0.4  r42h133d619_0         conda-forge/linux-64     Cached
  + r-farver                                2.1.1  r42h7525677_1         conda-forge/linux-64     Cached
  + r-ggplot2                               3.4.1  r42hc72bb7e_0         conda-forge/noarch       Cached
  + r-glue                                  1.6.2  r42h06615bd_1         conda-forge/linux-64     Cached
  + r-gtable                                0.3.1  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-isoband                               0.2.7  r42h38f115c_1         conda-forge/linux-64     Cached
  + r-labeling                              0.4.2  r42hc72bb7e_2         conda-forge/noarch       Cached
  + r-lattice                             0.20_45  r42h06615bd_1         conda-forge/linux-64     Cached
  + r-lifecycle                             1.0.3  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-magrittr                              2.0.3  r42h06615bd_1         conda-forge/linux-64     Cached
  + r-mass                               7.3_58.2  r42h133d619_0         conda-forge/linux-64     Cached
  + r-matrix                                1.5_3  r42h5f7b363_0         conda-forge/linux-64     Cached
  + r-mgcv                                 1.8_41  r42h5f7b363_0         conda-forge/linux-64     Cached
  + r-munsell                               0.5.0  r42hc72bb7e_1005      conda-forge/noarch       Cached
  + r-nlme                                3.1_162  r42hac0b197_0         conda-forge/linux-64     Cached
  + r-pillar                                1.8.1  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-pkgconfig                             2.0.3  r42hc72bb7e_2         conda-forge/noarch       Cached
  + r-r6                                    2.5.1  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-rcolorbrewer                          1.1_3  r42h785f33e_1         conda-forge/noarch       Cached
  + r-rlang                                 1.0.6  r42h7525677_1         conda-forge/linux-64     Cached
  + r-scales                                1.2.1  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-tibble                                3.1.8  r42h06615bd_1         conda-forge/linux-64     Cached
  + r-utf8                                  1.2.3  r42h133d619_0         conda-forge/linux-64     Cached
  + r-vctrs                                 0.5.2  r42h38f115c_0         conda-forge/linux-64     Cached
  + r-viridislite                           0.4.1  r42hc72bb7e_1         conda-forge/noarch       Cached
  + r-withr                                 2.5.0  r42hc72bb7e_1         conda-forge/noarch       Cached
  + readline                                8.1.2  h0f457ee_0            conda-forge/linux-64     Cached
  + rnaquast                                2.2.1  h9ee0642_0            bioconda/linux-64           5MB
  + samtools                               1.16.1  h6899075_1            bioconda/linux-64         421kB
  + sed                                       4.8  he412f7d_0            conda-forge/linux-64     Cached
  + sepp                                    4.5.1  py37he4bd417_1        bioconda/linux-64           7MB
  + setuptools                             67.3.2  pyhd8ed1ab_0          conda-forge/noarch       Cached
  + simplejson                             3.17.6  py37h540881e_1        conda-forge/linux-64      106kB
  + six                                    1.16.0  pyh6c4a22f_0          conda-forge/noarch         14kB
  + sqlite                                 3.40.0  h4ff8645_0            conda-forge/linux-64      820kB
  + star                                  2.7.10b  h9ee0642_0            bioconda/linux-64        Cached
  + suitesparse                            5.10.1  h9e50725_1            conda-forge/linux-64        3MB
  + sysroot_linux-64                         2.12  he073ed8_15           conda-forge/noarch       Cached
  + tar                                      1.34  hb2e2bae_1            conda-forge/linux-64      915kB
  + tbb                                  2021.7.0  h924138e_1            conda-forge/linux-64        2MB
  + tk                                     8.6.12  h27826a3_0            conda-forge/linux-64     Cached
  + tktable                                  2.10  hb7b940f_3            conda-forge/linux-64     Cached
  + typing-extensions                       4.4.0  hd8ed1ab_0            conda-forge/noarch          9kB
  + typing_extensions                       4.4.0  pyha770c72_0          conda-forge/noarch         30kB
  + ucsc-fatotwobit                           377  ha8a8165_5            bioconda/linux-64         138kB
  + ucsc-pslsort                              377  ha8a8165_4            bioconda/linux-64         140kB
  + ucsc-twobitinfo                           377  ha8a8165_3            bioconda/linux-64         154kB
  + unicodedata2                           14.0.0  py37h540881e_1        conda-forge/linux-64      508kB
  + wget                                   1.20.3  ha56f1ee_1            conda-forge/linux-64      824kB
  + wheel                                  0.38.4  pyhd8ed1ab_0          conda-forge/noarch       Cached
  + xorg-fixesproto                           5.0  h7f98852_1002         conda-forge/linux-64        9kB
  + xorg-inputproto                         2.3.2  h7f98852_1002         conda-forge/linux-64       20kB
  + xorg-kbproto                            1.0.7  h7f98852_1002         conda-forge/linux-64     Cached
  + xorg-libice                            1.0.10  h7f98852_0            conda-forge/linux-64     Cached
  + xorg-libsm                              1.2.3  hd9c2040_1000         conda-forge/linux-64     Cached
  + xorg-libx11                             1.7.2  h7f98852_0            conda-forge/linux-64     Cached
  + xorg-libxau                             1.0.9  h7f98852_0            conda-forge/linux-64     Cached
  + xorg-libxdmcp                           1.1.3  h7f98852_0            conda-forge/linux-64     Cached
  + xorg-libxext                            1.3.4  h7f98852_1            conda-forge/linux-64     Cached
  + xorg-libxfixes                          5.0.3  h7f98852_1004         conda-forge/linux-64       18kB
  + xorg-libxi                             1.7.10  h7f98852_0            conda-forge/linux-64       47kB
  + xorg-libxrender                        0.9.10  h7f98852_1003         conda-forge/linux-64     Cached
  + xorg-libxt                              1.2.1  h7f98852_2            conda-forge/linux-64     Cached
  + xorg-libxtst                            1.2.3  h7f98852_1002         conda-forge/linux-64       32kB
  + xorg-recordproto                       1.14.2  h7f98852_1002         conda-forge/linux-64        8kB
  + xorg-renderproto                       0.11.1  h7f98852_1002         conda-forge/linux-64     Cached
  + xorg-xextproto                          7.3.0  h7f98852_1002         conda-forge/linux-64     Cached
  + xorg-xproto                            7.0.31  h7f98852_1007         conda-forge/linux-64     Cached
  + xz                                      5.2.6  h166bdaf_0            conda-forge/linux-64     Cached
  + zipp                                   3.14.0  pyhd8ed1ab_0          conda-forge/noarch         17kB
  + zlib                                   1.2.13  h166bdaf_4            conda-forge/linux-64     Cached
  + zstd                                    1.5.2  h3eb15da_6            conda-forge/linux-64     Cached

  Summary:

  Install: 300 packages

  Total download: 636MB

──────────────────────────────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
xorg-inputproto                                     19.6kB @ 260.7kB/s  0.1s
python_abi                                           5.7kB @  58.8kB/s  0.1s
libunistring                                         1.4MB @  14.1MB/s  0.1s
xorg-recordproto                                     8.0kB @  59.2kB/s  0.1s
xorg-fixesproto                                      9.1kB @  66.0kB/s  0.1s
libbrotlidec                                        34.2kB @ 204.0kB/s  0.1s
alsa-lib                                           592.3kB @   3.3MB/s  0.1s
metis                                                4.3MB @  21.6MB/s  0.2s
libidn2                                            160.4kB @ 807.7kB/s  0.1s
libtiff                                            657.5kB @   3.3MB/s  0.1s
xorg-libxfixes                                      18.1kB @  75.3kB/s  0.1s
openjpeg                                           546.2kB @   2.2MB/s  0.1s
libwebp                                             89.6kB @ 363.5kB/s  0.1s
tar                                                914.7kB @   3.0MB/s  0.2s
curl                                                88.2kB @ 285.2kB/s  0.1s
xorg-libxtst                                        32.1kB @ 102.1kB/s  0.1s
suitesparse                                          2.5MB @   6.6MB/s  0.1s
perl-sub-name                                       15.5kB @  33.8kB/s  0.2s
perl-compress-raw-zlib                              77.2kB @ 166.1kB/s  0.2s
cdbtools                                            71.7kB @ 153.4kB/s  0.1s
libcups                                              4.5MB @   9.5MB/s  0.3s
samtools                                           420.8kB @ 818.5kB/s  0.1s
htslib                                               2.4MB @   4.3MB/s  0.3s
perl-extutils-makemaker                            157.2kB @ 272.8kB/s  0.2s
zipp                                                17.3kB @  26.0kB/s  0.3s
perl-dbi                                           619.1kB @ 695.2kB/s  0.7s
packaging                                           40.7kB @  42.4kB/s  0.3s
cycler                                              10.3kB @  10.5kB/s  0.3s
joblib                                             210.0kB @ 213.0kB/s  0.3s
metaeuk                                              4.3MB @   4.0MB/s  0.6s
perl-base                                           11.9kB @  10.1kB/s  0.3s
perl-params-check                                    6.1kB @   4.9kB/s  0.3s
perl-locale-maketext-simple                         10.6kB @   8.5kB/s  0.3s
perl-getopt-long                                    31.5kB @  25.2kB/s  0.3s
perl-parent                                          7.9kB @   6.3kB/s  0.2s
dendropy                                           315.3kB @ 216.5kB/s  0.2s
perl-module-corelist                                67.5kB @  44.1kB/s  0.3s
perl-text-parsewords                                 9.8kB @   6.4kB/s  0.3s
pyvcf3                                             979.5kB @ 638.9kB/s  0.3s
munkres                                             10.2kB @   6.6kB/s  0.3s
perl-test-fatal                                     13.1kB @   8.4kB/s  0.1s
libgd                                              272.5kB @ 151.1kB/s  0.2s
perl-cpan-meta-requirements                         13.5kB @   7.4kB/s  0.3s
perl-module-runtime-conflicts                        9.4kB @   5.1kB/s  0.3s
perl-params-util                                    24.1kB @  13.1kB/s  0.3s
pysam                                                2.8MB @   1.5MB/s  0.4s
bottleneck                                         129.2kB @  68.2kB/s  0.1s
perl-file-temp                                      31.5kB @  16.6kB/s  0.0s
perl-package-stash-xs                               28.6kB @  15.0kB/s  0.1s
fonttools                                            2.0MB @   1.1MB/s  0.1s
numexpr                                            137.0kB @  61.1kB/s  0.4s
perl-module-metadata                                17.7kB @   7.9kB/s  0.4s
perl-cpan-meta                                       5.7kB @   2.5kB/s  0.4s
perl-sub-exporter                                   38.4kB @  17.1kB/s  0.4s
pyfaidx                                             32.6kB @  14.5kB/s  0.4s
perl-extutils-parsexs                               42.1kB @  16.0kB/s  0.4s
perl-module-build                                  131.1kB @  49.6kB/s  0.4s
giflib                                              79.3kB @  25.8kB/s  0.6s
libdeflate                                          80.4kB @  23.8kB/s  0.6s
libbrotlienc                                       295.2kB @  81.0kB/s  0.6s
sepp                                                 6.9MB @   1.8MB/s  1.7s
rnaquast                                             5.1MB @   1.3MB/s  1.3s
brotli-bin                                          20.1kB @   5.1kB/s  0.4s
sqlite                                             820.2kB @ 192.8kB/s  0.3s
wget                                               823.6kB @ 192.8kB/s  0.5s
bbmap                                                9.4MB @   2.2MB/s  2.2s
libhwloc                                             3.1MB @ 695.0kB/s  0.6s
prodigal                                           795.2kB @ 174.8kB/s  0.4s
perl-data-dumper                                    38.5kB @   8.1kB/s  0.5s
perl-compress-raw-bzip2                             48.8kB @   9.8kB/s  0.5s
ucsc-pslsort                                       140.1kB @  28.2kB/s  0.7s
hmmer                                                5.8MB @   1.1MB/s  1.0s
nomkl                                                3.8kB @ 730.0 B/s  0.3s
perl-file-which                                     17.3kB @   3.3kB/s  0.3s
argh                                                26.2kB @   4.8kB/s  0.3s
pyparsing                                           81.3kB @  14.9kB/s  0.3s
typing_extensions                                   30.0kB @   5.4kB/s  0.3s
entrez-direct                                        7.8MB @   1.4MB/s  0.9s
perl-mro-compat                                     12.6kB @   2.2kB/s  0.4s
perl-devel-stacktrace                               17.5kB @   3.0kB/s  0.4s
perl-exporter-tiny                                  25.4kB @   4.3kB/s  0.3s
perl-types-serialiser                               13.1kB @   2.2kB/s  0.3s
perl-list-moreutils                                 32.5kB @   5.2kB/s  0.4s
perl-constant                                       12.5kB @   2.0kB/s  0.4s
perl-devel-globaldestruction                         9.7kB @   1.6kB/s  0.4s
perl-json-xs                                        65.4kB @  10.5kB/s  0.0s
unicodedata2                                       508.2kB @  81.2kB/s  0.4s
perl-eval-closure                                   12.9kB @   2.0kB/s  0.5s
importlib_metadata                                   3.9kB @ 563.0 B/s  0.4s
argcomplete                                         35.2kB @   5.0kB/s  0.4s
perl-module-load-conditional                        12.1kB @   1.6kB/s  0.4s
perl-cpan-meta-check                                10.0kB @   1.4kB/s  0.4s
perl-devel-overloadinfo                             11.1kB @   1.4kB/s  0.4s
perl-class-load                                     14.2kB @   1.8kB/s  0.4s
busco                                              343.1kB @  42.6kB/s  0.3s
pcre                                               259.4kB @  31.1kB/s  0.5s
krb5                                                 1.3MB @ 154.4kB/s  0.5s
brotli                                              18.9kB @   2.1kB/s  0.6s
r-base                                              25.1MB @   2.4MB/s  4.2s
perl-sub-identify                                   14.2kB @   1.3kB/s  0.4s
perl-scalar-list-utils                              44.7kB @   4.1kB/s  0.4s
ucsc-twobitinfo                                    153.6kB @  13.8kB/s  0.4s
diamond                                              2.6MB @ 225.3kB/s  0.6s
six                                                 14.3kB @   1.2kB/s  0.4s
typing-extensions                                    8.6kB @ 710.0 B/s  0.4s
perl-sub-exporter-progressive                       10.2kB @ 837.0 B/s  0.4s
perl-common-sense                                   13.6kB @   1.1kB/s  0.4s
perl-io-zlib                                        12.2kB @ 966.0 B/s  0.4s
augustus                                            32.7MB @   2.5MB/s  5.1s
perl-exporter                                       15.9kB @   1.2kB/s  0.3s
perl-role-tiny                                      17.0kB @   1.3kB/s  0.4s
perl-carp                                           17.1kB @   1.3kB/s  0.4s
perl-pathtools                                      43.1kB @   3.2kB/s  0.4s
perl-encode                                          2.2MB @ 164.1kB/s  0.7s
kiwisolver                                          74.5kB @   5.5kB/s  0.4s
pango                                              437.2kB @  31.8kB/s  0.4s
perl-archive-tar                                    34.1kB @   2.4kB/s  0.3s
pillow                                              47.2MB @   3.3MB/s  8.4s
perl-moose                                         457.3kB @  30.6kB/s  0.5s
gawk                                                 1.5MB @  95.2kB/s  0.5s
lp_solve                                           428.6kB @  27.7kB/s  0.5s
emboss                                              98.4MB @   6.1MB/s 13.9s
mysql-connector-c                                    2.8MB @ 173.8kB/s  0.9s
tbb                                                  1.6MB @  93.6kB/s  0.5s
xorg-libxi                                          47.3kB @   2.8kB/s  0.5s
perl-storable                                       64.8kB @   3.8kB/s  0.3s
ucsc-fatotwobit                                    137.8kB @   8.1kB/s  0.3s
perl-module-load                                     5.9kB @ 342.0 B/s  0.4s
perl-json-pp                                        33.9kB @   2.0kB/s  0.4s
blast                                               23.5MB @   1.4MB/s  3.3s
perl-sub-quote                                      20.4kB @   1.2kB/s  0.4s
perl-class-method-modifiers                         15.8kB @ 899.0 B/s  0.4s
python                                              60.1MB @   3.4MB/s  8.8s
perl-module-implementation                          11.6kB @ 642.0 B/s  0.4s
perl-cpan-meta-yaml                                 13.6kB @ 753.0 B/s  0.4s
perl-sub-install                                    12.3kB @ 685.0 B/s  0.5s
perl-extutils-cbuilder                              22.9kB @   1.2kB/s  0.4s
perl-package-stash                                 124.2kB @   6.8kB/s  0.4s
perl-parallel-forkmanager                           22.9kB @   1.2kB/s  0.7s
matplotlib-base                                      7.7MB @ 398.2kB/s  1.7s
mpfr                                                 2.7MB @ 140.3kB/s  0.9s
perl-list-moreutils-xs                              50.3kB @   2.6kB/s  0.4s
pytz                                               186.2kB @   9.5kB/s  0.4s
python-dateutil                                    246.0kB @  12.5kB/s  0.4s
perl-text-abbrev                                     7.5kB @ 374.0 B/s  0.3s
perl-perl-ostype                                     8.6kB @ 430.0 B/s  0.4s
perl-dist-checkconflicts                            12.4kB @ 619.0 B/s  0.4s
perl-json                                           57.1kB @   2.8kB/s  0.3s
perl-apache-test                                   121.9kB @   6.0kB/s  0.3s
perl-ipc-cmd                                        25.2kB @   1.2kB/s  0.3s
pandas                                               9.7MB @ 477.8kB/s  2.4s
lcms2                                              262.1kB @  12.8kB/s  0.4s
bamtools                                             1.1MB @  51.7kB/s  0.4s
libcurl                                            347.4kB @  16.7kB/s  0.5s
importlib-metadata                                  33.6kB @   1.6kB/s  0.4s
perl-file-path                                      22.4kB @   1.1kB/s  0.7s
perl-package-deprecationmanager                     13.0kB @ 604.0 B/s  0.7s
perl-try-tiny                                       19.5kB @ 903.0 B/s  1.2s
numpy                                                6.4MB @ 296.4kB/s  1.0s
perl-app-cpanminus                                 245.4kB @  11.2kB/s  0.5s
perl-module-runtime                                 17.1kB @ 779.0 B/s  0.4s
perl-moo                                            41.8kB @   1.9kB/s  0.4s
perl-version                                        25.1kB @   1.1kB/s  0.8s
perl-xsloader                                       14.2kB @ 624.0 B/s  0.8s
libbrotlicommon                                     67.2kB @   2.9kB/s  0.4s
gmp                                                825.8kB @  35.1kB/s  1.0s
biopython                                            2.8MB @ 116.1kB/s  0.8s
perl-yaml                                           43.6kB @   1.8kB/s  0.7s
perl-extutils-manifest                              14.9kB @ 611.0 B/s  0.3s
perl-io-compress                                    85.8kB @   3.5kB/s  0.3s
perl-class-load-xs                                  14.0kB @ 566.0 B/s  0.3s
perl-data-optlist                                   19.4kB @ 783.0 B/s  0.4s
boost-cpp                                           17.0MB @ 671.7kB/s  3.4s
gmap                                                41.0MB @   1.5MB/s  5.8s
openjdk                                            168.8MB @   5.8MB/s 15.9s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate rnaquast_curr_env

To deactivate an active environment, use

     $ mamba deactivate
```
</details>
<br />
<br />

<a id="do-~~three~~n-new-trial-runs-2023-0220-0221"></a>
## Do ~~three~~<i>n</> new trial runs (2023-0220-0221)
1. *with symlinked file, without `--busco_lineage` and `--gene_mark`: `trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta`*
2. *with symlinked file, with `--busco_lineage` and `--gene_mark`: `trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta`*
3. *without reads, without `--busco_lineage` and `--gene_mark`: `trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta`*
4. *without reads, with `--busco_lineage` and `--gene_mark`: `trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta`*
5. *without reads, without `--busco_lineage` and `--gene_mark`: the 285 Trinity GG Q_N datasets*
6. *with reads <b>but in the form of a bam file</b>, and without `--busco_lineage` and `--gene_mark` (can troubleshoot why they're not working&mdash;or at least why BUSCO is not working&mdash;later): `trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta`*

<a id="prepare-for-and-perform-run-1"></a>
### Prepare for and perform run 1
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Prepare for and perform run 1</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tmux ls
tmux new -s run_1  # then detach
tmux a -t run_1

grabnode  # 16, defaults
source activate rnaquast_curr_env

transcriptome &&
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }

n_GG="gg_mkc-16_mir-0.005_mg-1_gf-0.005"
f_GG="./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta"
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"
p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"
p_f_r1="fastqs/merged_Q_IP_UTK_R1.fq.gz"
p_f_r3="fastqs/merged_Q_IP_UTK_R3.fq.gz"

d_out="outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-1"
if [[ ! -d "${d_out}" ]]; then
    mkdir "${d_out}"
fi

echo "${SLURM_CPUS_ON_NODE}"
echo "${n_GG}"
echo "${f_GG}"
echo "${p_ref}/${f_ref}"
echo "${p_gtf}/${f_gtf}"
echo "${p_gmap}/${d_gmap}"
echo "${p_f_r1}"
echo "${p_f_r3}"
echo "${d_out}"

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels "${n_GG}" \
    --transcripts "${f_GG}" \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --left_reads "${p_f_r1}" \
    --right_reads "${p_f_r3}" \
    --output_dir "${d_out}" \
    --disable_infer_genes \
    --disable_infer_transcripts
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: Prepare for and perform run 1</i></summary>

```txt
❯ tmux ls
rnaquast: 1 windows (created Sat Feb 18 16:34:31 2023) [203x73]


❯ transcriptome &&
>     {
>         cd "results/2023-0218/" \
>             || echo "cd'ing failed; check on this..."
>     }
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218


❯ if [[ ! -d "${d_out}" ]]; then
>     mkdir "${d_out}"
> fi
mkdir: created directory 'outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-1'


❯ echo "${SLURM_CPUS_ON_NODE}"
16


❯ echo "${n_GG}"
gg_mkc-16_mir-0.005_mg-1_gf-0.005


❯ echo "${f_GG}"
./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta


❯ echo "${p_ref}/${f_ref}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta


❯ echo "${p_gtf}/${f_gtf}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf


❯ echo "${p_gmap}/${d_gmap}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap


❯ echo "${p_f_r1}"
fastqs/merged_Q_IP_UTK_R1.fq.gz


❯ echo "${p_f_r3}"
fastqs/merged_Q_IP_UTK_R3.fq.gz


#  Job was hanging, so killed it on 2023-0221, ~7:15 a.m.
```
</details>
<br />

<a id="prepare-for-and-perform-run-2"></a>
### Prepare for and perform run 2
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Prepare for and perform run 2</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tmux ls
tmux new -s run_2  # then detach
tmux a -t run_2

grabnode  # 16, defaults
source activate rnaquast_curr_env

transcriptome &&
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }

n_GG="gg_mkc-16_mir-0.005_mg-1_gf-0.005"
f_GG="./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta"
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"
p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"
p_f_r1="fastqs/merged_Q_IP_UTK_R1.fq.gz"
p_f_r3="fastqs/merged_Q_IP_UTK_R3.fq.gz"
p_f_busco="BUSCO/saccharomycetes_odb10"

d_out="outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-2"
if [[ ! -d "${d_out}" ]]; then
    mkdir "${d_out}"
fi

echo "${SLURM_CPUS_ON_NODE}"
echo "${n_GG}"
echo "${f_GG}"
echo "${p_ref}/${f_ref}"
echo "${p_gtf}/${f_gtf}"
echo "${p_gmap}/${d_gmap}"
echo "${p_f_r1}"
echo "${p_f_r3}"
echo "${d_out}"
echo "${p_f_busco}"

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels "${n_GG}" \
    --transcripts "${f_GG}" \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --left_reads "${p_f_r1}" \
    --right_reads "${p_f_r3}" \
    --output_dir "${d_out}" \
    --busco "${p_f_busco}" \
    --gene_mark \
    --disable_infer_genes \
    --disable_infer_transcripts
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: Prepare for and perform run 2</i></summary>

```txt
❯ tmux ls
rnaquast: 1 windows (created Sat Feb 18 16:34:31 2023) [203x73]
run_1: 1 windows (created Mon Feb 20 11:42:40 2023) [203x73]


❯ transcriptome &&
>     {
>         cd "results/2023-0218/" \
>             || echo "cd'ing failed; check on this..."
>     }
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218


❯ echo "${SLURM_CPUS_ON_NODE}"
16


❯ echo "${n_GG}"
gg_mkc-16_mir-0.005_mg-1_gf-0.005


❯ echo "${f_GG}"
./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta


❯ echo "${p_ref}/${f_ref}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta


❯ echo "${p_gtf}/${f_gtf}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf


❯ echo "${p_gmap}/${d_gmap}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap


❯ echo "${p_f_r1}"
fastqs/merged_Q_IP_UTK_R1.fq.gz


❯ echo "${p_f_r3}"
fastqs/merged_Q_IP_UTK_R3.fq.gz


❯ echo "${d_out}"
outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-2


❯ echo "${p_f_busco}"
BUSCO/saccharomycetes_odb10


#  Job was hanging, so killed it on 2023-0221, ~7:15 a.m.
```
</details>
<br />

<a id="prepare-for-and-perform-run-3"></a>
### Prepare for and perform run 3
<a id="code-9"></a>
#### Code
<details>
<summary><i>Code: Prepare for and perform run 3</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tmux ls
tmux new -s run_3  # then detach
tmux a -t run_3

grabnode  # 16, defaults
source activate rnaquast_curr_env

transcriptome &&
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }

n_GG="gg_mkc-16_mir-0.005_mg-1_gf-0.005"
f_GG="./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta"
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"
p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"

d_out="outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3"
if [[ ! -d "${d_out}" ]]; then
    mkdir "${d_out}"
fi

echo "${SLURM_CPUS_ON_NODE}"
echo "${n_GG}"
echo "${f_GG}"
echo "${p_ref}/${f_ref}"
echo "${p_gtf}/${f_gtf}"
echo "${p_gmap}/${d_gmap}"
echo "${d_out}"

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels "${n_GG}" \
    --transcripts "${f_GG}" \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --output_dir "${d_out}" \
    --disable_infer_genes \
    --disable_infer_transcripts
```
</details>
<br />

<a id="printed-6"></a>
#### Printed
<details>
<summary><i>Printed: Prepare for and perform run 3</i></summary>

```txt
❯ transcriptome &&
>     {
>         cd "results/2023-0218/" \
>             || echo "cd'ing failed; check on this..."
>     }
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218


❯ if [[ ! -d "${d_out}" ]]; then
>     mkdir "${d_out}"
> fi
mkdir: created directory 'outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3'


❯ echo "${SLURM_CPUS_ON_NODE}"
16


❯ echo "${n_GG}"
gg_mkc-16_mir-0.005_mg-1_gf-0.005


❯ echo "${f_GG}"
./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta


❯ echo "${p_ref}/${f_ref}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta


❯ echo "${p_gtf}/${f_gtf}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf


❯ echo "${p_gmap}/${d_gmap}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap


❯ echo "${d_out}"
outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3


❯ rnaQUAST.py \
>     -t "${SLURM_CPUS_ON_NODE}" \
>     --labels "${n_GG}" \
>     --transcripts "${f_GG}" \
>     --reference "${p_ref}/${f_ref}" \
>     --gtf "${p_gtf}/${f_gtf}" \
>     --gmap_index "${p_gmap}/${d_gmap}" \
>     --strand_specific \
>     --output_dir "${d_out}" \
>     --disable_infer_genes \
>     --disable_infer_transcripts
/home/kalavatt/miniconda3/envs/rnaquast_curr_env/share/rnaquast-2.2.1-0/rnaQUAST.py -t 16 --labels gg_mkc-16_mir-0.005_mg-1_gf-0.005 --transcripts ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.0
05.Trinity-GG.fasta --reference /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --gtf /home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharo
myces_cerevisiae.R64-1-1.108.gtf --gmap_index /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap --strand_specific --output_dir outfiles_rn
aQUAST-test_Trinity-GG_Q-N_2022-0220_run-3 --disable_infer_genes --disable_infer_transcripts

rnaQUAST: 2.2.1

System information:
  OS: Linux-4.15.0-192-generic-x86_64-with-debian-buster-sid (linux_64)
  Python version: 3.7.12
  CPUs number: 36

External tools:
  matplotlib: 3.5.3
  joblib: 1.2.0
  gffutils: 0.11.1
  blastn: 2.13.0+
  makeblastdb: 2.13.0+
  gmap: 2017-11-15

Started: 2023-02-20 13:26:51

Logging to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/logs/rnaQUAST.log

2023-02-20 13:26:51
Getting reference...
Done.
Using strand specific transcripts...

2023-02-20 13:26:51
Creating sqlite3 db by gffutils...
2023-02-20 13:26:55,231 - INFO - Committing changes: 41000 features
2023-02-20 13:26:55,307 - INFO - Populating features table and first-order relations: 41878 features
2023-02-20 13:26:55,314 - INFO - Creating relations(parent) index
2023-02-20 13:26:55,344 - INFO - Creating relations(child) index
2023-02-20 13:26:55,371 - INFO - Creating features(featuretype) index
2023-02-20 13:26:55,384 - INFO - Creating features (seqid, start, end) index
2023-02-20 13:26:55,404 - INFO - Creating features (seqid, start, end, strand) index
2023-02-20 13:26:55,425 - INFO - Running ANALYZE features
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/Saccharomyces_cerevisiae.R64-1-1.108.db.

2023-02-20 13:26:55
Loading sqlite3 db by gffutils from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/Saccharomyces_ce
revisiae.R64-1-1.108.db to memory...
Done.

2023-02-20 13:26:56
Getting GENE DATABASE metrics...
Done.

Sets maximum intron size equal 2583. Default is 1500000 bp.


2023-02-20 13:27:32
Sorting exons attributes...
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
Done.

  2023-02-20 13:27:34
  Getting transcripts from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta...
  Done.

2023-02-20 13:27:34
Getting upper case fasta...
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/Saccharomyces_cerevisiae.R64-1-1.dna.
toplevel.chr-rename.upper.fasta

2023-02-20 13:27:34
Aligning gg_mkc-16_mir-0.005_mg-1_gf-0.005 to Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.upper...
  log can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/logs/gmap.gg_mkc-16_mir-0.005_
mg-1_gf-0.005.err.log.
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.psl

GMAP TIME: 0:00:18.891645



2023-02-20 13:27:53
Extracting isoforms sequences...
Done.

2023-02-20 13:28:34
Getting blast database for /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/Saccharomyces_cerevis
iae.R64-1-1.108.isoforms.fa
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/Saccharomyces_cerevisiae.R64-1-1.108.
isoforms

2023-02-20 13:28:34
Transcripts:
  /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta -> gg_mkc-16_mir-0.005_mg-1_gf
-0.005
Reference:
  /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
Gene coordinates:
  /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/Saccharomyces_cerevisiae.R64-1-1.108.cleared.g
tf


Processing transcripts from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta:

  2023-02-20 13:28:34
  Aligning /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta to /fh/fast/tsukiyama
_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/Saccharomyces_cerevisiae.R64-1-1.108.isoforms by blastn...
    saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.b
last6
    log can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/logs/gg_mkc-16_mir-0.005_mg-
1_gf-0.005.blastn.log.

  2023-02-20 13:28:38
  Getting BLAST alignments report files...
    saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.a
ssembled.best.blast6 (contains best alignments for assembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.p
aralogs.best.blast6 (contains best alignments for assembled transcripts having paralogs)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.best.blast6 (contains best alignments for misassembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.blast6 (contains all alignments for misassembled transcripts)

  2023-02-20 13:28:39
  Getting GMAP (or BLAT) alignments report files...
    saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.a
ssembled.best.psl (contains best alignments for assembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.u
niquely.psl (contains best alignments for uniquely aligned assembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.p
aralogs.best.psl (contains best alignments for assembled transcripts having paralogs)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.best.psl (contains best alignments for misassembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.psl (contains all alignments for misassembled transcripts)

  2023-02-20 13:28:47
  Processing assembled aligned transcripts...
  Done.

  2023-02-20 13:33:07
  Processing misassembled aligned transcripts...
  Done.

  2023-02-20 13:33:07
  Processing misassembled aligned transcripts...
  Done.

  2023-02-20 13:33:07
  Getting BASIC TRANSCRIPTS metrics...
  Done.
  Getting ALIGNMENT metrics...
  Done.
  Getting SPECIFICITY metrics...
  Done.
  Getting SENSITIVITY metrics...
  Done.

Getting SEPARATED report for gg_mkc-16_mir-0.005_mg-1_gf-0.005...

  2023-02-20 13:34:29
  Getting TXT report...
    Getting GENE DATABASE METRICS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/database_metrics.txt
    Getting BASIC TRANSCRIPTS METRICS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/basic_metrics.txt
    Getting ALIGNMENT METRICS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/alignment_metrics.txt
    Getting ALIGNMENT METRICS FOR MISASSEMBLED (CHIMERIC) TRANSCRIPTS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/misassemblies.txt
    Getting ASSEMBLY COMPLETENESS (SENSITIVITY) report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/sensitivity.txt
    Getting ASSEMBLY SPECIFICITY report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/specificity.txt
  Done.

  2023-02-20 13:34:29
  Getting DISTRIBUTION report...
    Drawing cumulative transcript / isoform length plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/transcript_length.png
    Drawing cumulative blocks / exons length plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/block_length.png
    Drawing cumulative transcript aligned fraction plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-aligned.png
    Drawing cumulative number of blocks / exons per alignment / isoform plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/blocks_per_alignment.png
    Drawing cumulative alignment multiplicity plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/alignment_multiplicity.png
    Drawing cumulative substitution errors per alignment plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/mismatch_rate.png
    Drawing Nx plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/Nx.png
    Drawing NAx plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/NAx.png
    Drawing cumulative transcript matched fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-matched.png
    Drawing cumulative block matched fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-matched_blocks.png
    Drawing cumulative isoform assembled fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-assembled.png
    Drawing cumulative exon assembled fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-assembled_exons.png
    Drawing cumulative isoform covered fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-covered.png
    Drawing cumulative exon covered fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-covered_exons.png
    Drawing cumulative number of alignments per isoform plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/alignments_per_isoform.png
  Done.

  2023-02-20 13:34:33
  Getting OTHER reports...
    Getting Unaligned transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.unaligned.fasta
    Getting Paralogous transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.paralogs.fasta
    Getting Misassembled transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.misassembled.fasta
    Getting Misassembled by BLAT transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.misassembled.blat.fasta
    Getting Misassembled by BLASTN transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.misassembled.blast.fasta
    Getting Unique aligned transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.correct.fasta
    Getting Unannotated transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.unannotated.fasta
    Getting fully assembled isoforms list...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.95%-assembled.list
    Getting well assembled isoforms list...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.50%-assembled.list
  Done.

2023-02-20 13:34:33
Getting SHORT SUMMARY report...
  saved to
    /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/short_report.txt
    /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/short_report.tex
    /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/short_report.pdf

THE QUALITY OF TRANSCRIPTOME ASSEMBLY DONE. RESULTS: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3

Separated assemblies reports are saved to
  /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/gg_mkc-16_mir-0.005_mg-1_gf-0.005_output
  PDF version (tables and plots) saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/short_repo
rt.pdf
  TXT version (tables and plots) saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/short_repo
rt.txt

Log saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-3/logs/rnaQUAST.log

Finished: 2023-02-20 13:34:35
Elapsed time: 0:07:44.547183
NOTICEs: 0; WARNINGs: 0; non-fatal ERRORs: 0

Thank you for using rnaQUAST!
```
</details>
<br />

<a id="prepare-for-and-perform-run-4"></a>
### Prepare for and perform run 4
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Prepare for and perform run 4</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tmux ls
tmux new -s run_4  # then detach
tmux a -t run_4

grabnode  # 16, defaults
source activate rnaquast_curr_env

transcriptome &&
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }

n_GG="gg_mkc-16_mir-0.005_mg-1_gf-0.005"
f_GG="./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta"
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"
p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"
p_f_busco="BUSCO/saccharomycetes_odb10"

d_out="outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4"
if [[ ! -d "${d_out}" ]]; then
    mkdir "${d_out}"
fi

echo "${SLURM_CPUS_ON_NODE}"
echo "${n_GG}"
echo "${f_GG}"
echo "${p_ref}/${f_ref}"
echo "${p_gtf}/${f_gtf}"
echo "${p_gmap}/${d_gmap}"
echo "${d_out}"
echo "${p_f_busco}"

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels "${n_GG}" \
    --transcripts "${f_GG}" \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --output_dir "${d_out}" \
    --busco "${p_f_busco}" \
    --gene_mark \
    --disable_infer_genes \
    --disable_infer_transcripts
```
</details>
<br />

<a id="printed-7"></a>
#### Printed
<details>
<summary><i>Printed: Prepare for and perform run 4</i></summary>

```txt
❯ transcriptome &&
>     {
>         cd "results/2023-0218/" \
>             || echo "cd'ing failed; check on this..."
>     }
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218


❯ if [[ ! -d "${d_out}" ]]; then
>     mkdir "${d_out}"
> fi
mkdir: created directory 'outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4'


❯ echo "${SLURM_CPUS_ON_NODE}"
16


❯ echo "${n_GG}"
gg_mkc-16_mir-0.005_mg-1_gf-0.005


❯ echo "${f_GG}"
./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta


❯ echo "${p_ref}/${f_ref}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta


❯ echo "${p_gtf}/${f_gtf}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf


❯ echo "${p_gmap}/${d_gmap}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap


❯ echo "${d_out}"
outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4


❯ echo "${p_f_busco}"
BUSCO/saccharomycetes_odb10


❯ rnaQUAST.py \
>     -t "${SLURM_CPUS_ON_NODE}" \
>     --labels "${n_GG}" \
>     --transcripts "${f_GG}" \
>     --reference "${p_ref}/${f_ref}" \
>     --gtf "${p_gtf}/${f_gtf}" \
>     --gmap_index "${p_gmap}/${d_gmap}" \
>     --strand_specific \
>     --output_dir "${d_out}" \
>     --busco "${p_f_busco}" \
>     --gene_mark \
>     --disable_infer_genes \
>     --disable_infer_transcripts
/home/kalavatt/miniconda3/envs/rnaquast_curr_env/share/rnaquast-2.2.1-0/rnaQUAST.py -t 16 --labels gg_mkc-16_mir-0.005_mg-1_gf-0.005 --transcripts ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.0
05.Trinity-GG.fasta --reference /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --gtf /home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharo
myces_cerevisiae.R64-1-1.108.gtf --gmap_index /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap --strand_specific --output_dir outfiles_rn
aQUAST-test_Trinity-GG_Q-N_2022-0220_run-4 --busco BUSCO/saccharomycetes_odb10 --gene_mark --disable_infer_genes --disable_infer_transcripts

rnaQUAST: 2.2.1

System information:
  OS: Linux-4.15.0-192-generic-x86_64-with-debian-buster-sid (linux_64)
  Python version: 3.7.12
  CPUs number: 36

External tools:
  matplotlib: 3.5.3
  joblib: 1.2.0
  gffutils: 0.11.1
  blastn: 2.13.0+
  makeblastdb: 2.13.0+
  gmap: 2017-11-15
  BUSCO: 5.4.5
  GeneMarkS_T: unknown

Started: 2023-02-20 13:29:02

Logging to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/rnaQUAST.log

2023-02-20 13:29:02
Getting reference...
Done.
Using strand specific transcripts...

2023-02-20 13:29:03
Creating sqlite3 db by gffutils...
2023-02-20 13:29:06,545 - INFO - Committing changes: 41000 features
2023-02-20 13:29:06,631 - INFO - Populating features table and first-order relations: 41878 features
2023-02-20 13:29:06,640 - INFO - Creating relations(parent) index
2023-02-20 13:29:06,674 - INFO - Creating relations(child) index
2023-02-20 13:29:06,709 - INFO - Creating features(featuretype) index
2023-02-20 13:29:06,725 - INFO - Creating features (seqid, start, end) index
2023-02-20 13:29:06,750 - INFO - Creating features (seqid, start, end, strand) index
2023-02-20 13:29:06,776 - INFO - Running ANALYZE features
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/Saccharomyces_cerevisiae.R64-1-1.108.db.

2023-02-20 13:29:06
Loading sqlite3 db by gffutils from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/Saccharomyces_ce
revisiae.R64-1-1.108.db to memory...
Done.

2023-02-20 13:29:07
Getting GENE DATABASE metrics...
Done.

Sets maximum intron size equal 2583. Default is 1500000 bp.


2023-02-20 13:29:44
Sorting exons attributes...
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
  Sorted in I.
  Sorted in II.
  Sorted in III.
  Sorted in IV.
  Sorted in V.
  Sorted in VI.
  Sorted in VII.
  Sorted in VIII.
  Sorted in IX.
  Sorted in X.
  Sorted in XI.
  Sorted in XII.
  Sorted in XIII.
  Sorted in XIV.
  Sorted in XV.
  Sorted in XVI.
  Sorted in Mito.
Done.

  2023-02-20 13:29:46
  Getting transcripts from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta...
  Done.

2023-02-20 13:29:46
Getting upper case fasta...
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/Saccharomyces_cerevisiae.R64-1-1.dna.
toplevel.chr-rename.upper.fasta

2023-02-20 13:29:46
Aligning gg_mkc-16_mir-0.005_mg-1_gf-0.005 to Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.upper...
  log can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/gmap.gg_mkc-16_mir-0.005_
mg-1_gf-0.005.err.log.
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.psl

GMAP TIME: 0:00:17.821596



2023-02-20 13:30:04
Extracting isoforms sequences...
Done.

2023-02-20 13:30:47
Getting blast database for /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/Saccharomyces_cerevis
iae.R64-1-1.108.isoforms.fa
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/Saccharomyces_cerevisiae.R64-1-1.108.
isoforms

2023-02-20 13:30:47
Transcripts:
  /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta -> gg_mkc-16_mir-0.005_mg-1_gf
-0.005
Reference:
  /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
Gene coordinates:
  /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/Saccharomyces_cerevisiae.R64-1-1.108.cleared.g
tf


Processing transcripts from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta:

  2023-02-20 13:30:47
  Aligning /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta to /fh/fast/tsukiyama
_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/Saccharomyces_cerevisiae.R64-1-1.108.isoforms by blastn...
    saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.b
last6
    log can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/gg_mkc-16_mir-0.005_mg-
1_gf-0.005.blastn.log.

  2023-02-20 13:30:51
  Getting BLAST alignments report files...
    saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.a
ssembled.best.blast6 (contains best alignments for assembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.p
aralogs.best.blast6 (contains best alignments for assembled transcripts having paralogs)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.best.blast6 (contains best alignments for misassembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.blast6 (contains all alignments for misassembled transcripts)

  2023-02-20 13:30:52
  Getting GMAP (or BLAT) alignments report files...
    saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.a
ssembled.best.psl (contains best alignments for assembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.u
niquely.psl (contains best alignments for uniquely aligned assembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.p
aralogs.best.psl (contains best alignments for assembled transcripts having paralogs)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.best.psl (contains best alignments for misassembled transcripts)
             /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/tmp/gg_mkc-16_mir-0.005_mg-1_gf-0.005.m
isassembled.psl (contains all alignments for misassembled transcripts)

  2023-02-20 13:31:01
  Processing assembled aligned transcripts...
  Done.

  2023-02-20 13:35:12
  Processing misassembled aligned transcripts...
  Done.

  2023-02-20 13:35:12
  Processing misassembled aligned transcripts...
  Done.

  2023-02-20 13:35:12
  Getting BASIC TRANSCRIPTS metrics...
  Done.
  Getting ALIGNMENT metrics...
  Done.
  Getting SPECIFICITY metrics...
  Done.
  Getting SENSITIVITY metrics...

2023-02-20 13:36:25
  Running BUSCO (Benchmarking Universal Single-Copy Orthologs)...

ERROR! busco failed for gg_mkc-16_mir-0.005_mg-1_gf-0.005!
    logs can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/gg_mkc-16_mir-0.005_mg
-1_gf-0.005.busco.out.log and /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/gg_mkc-16_mir-0.0
05_mg-1_gf-0.005.busco.err.log.

2023-02-20 13:36:29
  Running GeneMarkS-T (Gene Prediction in Transcripts)...

ERROR! GeneMarkS-T failed for gg_mkc-16_mir-0.005_mg-1_gf-0.005!
    logs can be found in /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/gg_mkc-16_mir-0.005_mg
-1_gf-0.005.GeneMarkS_T.out.log and /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/gg_mkc-16_m
ir-0.005_mg-1_gf-0.005.GeneMarkS_T.err.log.
  Done.

Getting SEPARATED report for gg_mkc-16_mir-0.005_mg-1_gf-0.005...                                                                                                                                  [61/393]

  2023-02-20 13:36:30
  Getting TXT report...
    Getting GENE DATABASE METRICS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/database_metrics.txt
    Getting BASIC TRANSCRIPTS METRICS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/basic_metrics.txt
    Getting ALIGNMENT METRICS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/alignment_metrics.txt
    Getting ALIGNMENT METRICS FOR MISASSEMBLED (CHIMERIC) TRANSCRIPTS report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/misassemblies.txt
    Getting ASSEMBLY COMPLETENESS (SENSITIVITY) report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/sensitivity.txt
    Getting ASSEMBLY SPECIFICITY report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/specificity.txt
  Done.

  2023-02-20 13:36:30
  Getting DISTRIBUTION report...
    Drawing cumulative transcript / isoform length plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/transcript_length.png
    Drawing cumulative blocks / exons length plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/block_length.png
    Drawing cumulative transcript aligned fraction plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-aligned.png
    Drawing cumulative number of blocks / exons per alignment / isoform plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/blocks_per_alignment.png
    Drawing cumulative alignment multiplicity plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/alignment_multiplicity.png
    Drawing cumulative substitution errors per alignment plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/mismatch_rate.png
    Drawing Nx plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/Nx.png
    Drawing NAx plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/NAx.png
    Drawing cumulative transcript matched fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-matched.png
    Drawing cumulative block matched fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-matched_blocks.png
    Drawing cumulative isoform assembled fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-assembled.png
    Drawing cumulative exon assembled fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-assembled_exons.png
    Drawing cumulative isoform covered fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-covered.png
    Drawing cumulative exon covered fraction histogram...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/x-covered_exons.png
    Drawing cumulative number of alignments per isoform plot...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/alignments_per_isoform.png
  Done.

  2023-02-20 13:36:34
  Getting OTHER reports...
    Getting Unaligned transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.unaligned.fasta
    Getting Paralogous transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.paralogs.fasta
    Getting Misassembled transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.misassembled.fasta
    Getting Misassembled by BLAT transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.misassembled.blat.fasta
    Getting Misassembled by BLASTN transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.misassembled.blast.fasta
    Getting Unique aligned transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.correct.fasta
    Getting Unannotated transcripts report...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.unannotated.fasta
    Getting fully assembled isoforms list...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.95%-assembled.list
    Getting well assembled isoforms list...
      saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_out
put/gg_mkc-16_mir-0.005_mg-1_gf-0.005.50%-assembled.list
  Done.

2023-02-20 13:36:34
Getting SHORT SUMMARY report...
  saved to
    /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/short_report.txt
    /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/short_report.tex
    /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/short_report.pdf

THE QUALITY OF TRANSCRIPTOME ASSEMBLY DONE. RESULTS: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4

Separated assemblies reports are saved to
  /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/gg_mkc-16_mir-0.005_mg-1_gf-0.005_output
  PDF version (tables and plots) saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/short_repo
rt.pdf
  TXT version (tables and plots) saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/short_repo
rt.txt

Log saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-4/logs/rnaQUAST.log

Finished: 2023-02-20 13:36:36
Elapsed time: 0:07:33.274793
NOTICEs: 0; WARNINGs: 0; non-fatal ERRORs: 2

non-fatal ERRORs:
  non-fatal ERROR: busco failed for gg_mkc-16_mir-0.005_mg-1_gf-0.005!
  non-fatal ERROR: GeneMarkS-T failed for gg_mkc-16_mir-0.005_mg-1_gf-0.005!

Thank you for using rnaQUAST!
```
</details>
<br />

<a id="prepare-for-and-perform-run-5"></a>
### Prepare for and perform run 5
<a id="code-11"></a>
#### Code
<details>
<summary><i>Code: Prepare for and perform run 5</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tmux new -s run_5  # then detach
tmux a -t run_5

grabnode  # 16, defaults
source activate rnaquast_curr_env

transcriptome &&
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }


#  Arrays -----------------------------
unset f_GG
typeset -a f_GG
while IFS=" " read -r -d $'\0'; do
    f_GG+=( "${REPLY}" )
done < <(\
        find "./Trinity_GG.Q_N/" \
            -maxdepth 3 \
            -type f \
            -name "*.fasta" \
            -print0 \
                | sort -z\
)
echo_test "${f_GG[@]}"
echo "${#f_GG[@]}"  # 285

unset n_GG
typeset -a n_GG
for i in "${f_GG[@]}"; do
    # i="${f_GG[0]}"  # echo "${i}"
    name="$(basename "${i}" .Trinity-GG.fasta)"  # echo "${name}"
    n_GG+=( "${name#trinity-}" )
done
echo_test "${n_GG[@]}"
echo "${#n_GG[@]}"  # 285

#  Check that files and names match
echo_test "${f_GG[@]}" | head
echo_test "${n_GG[@]}" | head
echo_test "${f_GG[@]}" | tail
echo_test "${n_GG[@]}" | tail


#  Variables --------------------------
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"

p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"

p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"

d_out="outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-5"
if [[ ! -d "${d_out}" ]]; then
    mkdir "${d_out}"
fi

echo "${SLURM_CPUS_ON_NODE}"
echo "${p_ref}/${f_ref}"
echo "${p_gtf}/${f_gtf}"
echo "${p_gmap}/${d_gmap}"
echo "${d_out}"

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels ${n_GG[*]} \
    --transcripts ${f_GG[*]} \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    --disable_infer_genes \
    --disable_infer_transcripts

#NOTE 1/3 Forgot to point to the output directory, so the results are
#NOTE 2/3 being written to...
#NOTE 3/3 ${HOME}/miniconda3/envs/rnaquast_curr_env/bin/rnaQUAST_results/results_2023_02_20_14_40_40

#TODO 1/2 When the job is completed, mv .../results_2023_02_20_14_40_40 to
#TODO 2/2 "${d_out}"
```
</details>
<br />

<a id="printed-8"></a>
#### Printed
<details>
<summary><i>Printed: Prepare for and perform run 5</i></summary>

```txt
(just check the logs)
```
</details>
<br />

<a id="prepare-for-and-perform-run-6"></a>
### Prepare for and perform run 6
<a id="code-12"></a>
#### Code
<details>
<summary><i>Code: Prepare for and perform run 6</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tmux new -s run_6  # then detach
tmux a -t run_6

grabnode  # 16, defaults
source activate rnaquast_curr_env

transcriptome &&
    {
        cd "results/2023-0218/" \
            || echo "cd'ing failed; check on this..."
    }


#  Symlink bams in new bams/ directory --------------------
#+ ...for use with rnaquast -sam option
if [[ ! -d bams/ ]]; then
    mkdir bams/
fi

cd "bams/" \
    || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


UTK_prim_no="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UTK_prim_no"
)"
echo "${UTK_prim_no}"

ln -s "${UTK_prim_no}/WT_Q_day7_N_rep1.UTK_prim.bam" "WT_Q_day7_N_rep1.UTK_prim.bam"
ln -s "${UTK_prim_no}/WT_Q_day7_N_rep2.UTK_prim.bam" "WT_Q_day7_N_rep2.UTK_prim.bam"


#  Index and merge the two replicates ---------------------
ml SAMtools/1.16.1-GCC-11.2.0

if [[ ! -f "WT_Q_day7_N_rep1.UTK_prim.bam.bai" ]]; then
    samtools index -@ "${SLURM_CPUS_ON_NODE}" "WT_Q_day7_N_rep1.UTK_prim.bam"
fi

if [[ ! -f "WT_Q_day7_N_rep2.UTK_prim.bam.bai" ]]; then
    samtools index -@ "${SLURM_CPUS_ON_NODE}" "WT_Q_day7_N_rep2.UTK_prim.bam"
fi

if [[ ! -f "WT_Q_day7_N_merged.UTK_prim.bam" ]]; then
    samtools merge \
        -@ "${SLURM_CPUS_ON_NODE}" \
        -o "WT_Q_day7_N_merged.UTK_prim.bam" \
        "WT_Q_day7_N_rep1.UTK_prim.bam" \
        "WT_Q_day7_N_rep2.UTK_prim.bam"
fi

#  Index merged bam, then convert it to a sam file --------
if [[ ! -f "WT_Q_day7_N_merged.UTK_prim.bam.bai" ]]; then
    samtools index -@ "${SLURM_CPUS_ON_NODE}" "WT_Q_day7_N_merged.UTK_prim.bam"
fi

if [[ ! -f "WT_Q_day7_N_merged.UTK_prim.sam" ]]; then
    samtools view \
        -@ "${SLURM_CPUS_ON_NODE}" -h \
        -o "WT_Q_day7_N_merged.UTK_prim.sam" \
        "WT_Q_day7_N_merged.UTK_prim.bam"
fi


#  Set up variables and outdirectory ----------------------
n_GG="gg_mkc-16_mir-0.005_mg-1_gf-0.005"
f_GG="./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta"
p_ref="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
f_ref="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
p_gtf="${HOME}/genomes/sacCer3/Ensembl/108/gtf"
f_gtf="Saccharomyces_cerevisiae.R64-1-1.108.gtf"
p_gmap="${HOME}/genomes/sacCer3/Ensembl/108/DNA"
d_gmap="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap"
p_f_sam="bams/WT_Q_day7_N_merged.UTK_prim.sam"

d_out="outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-6"
if [[ ! -d "${d_out}" ]]; then
    mkdir "${d_out}"
fi

echo "${SLURM_CPUS_ON_NODE}"
echo "${n_GG}"
echo "${f_GG}"
echo "${p_ref}/${f_ref}"
echo "${p_gtf}/${f_gtf}"
echo "${p_gmap}/${d_gmap}"
echo "${p_f_sam}"
., "${p_f_sam}"
echo "${d_out}"

rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels "${n_GG}" \
    --transcripts "${f_GG}" \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    -sam "${p_f_sam}" \
    --output_dir "${d_out}" \
    --disable_infer_genes \
    --disable_infer_transcripts
```
</details>
<br />

<a id="printed-9"></a>
#### Printed
<details>
<summary><i>Printed: Prepare for and perform run 6</i></summary>

```txt
❯ echo "${SLURM_CPUS_ON_NODE}"
16


❯ echo "${n_GG}"
gg_mkc-16_mir-0.005_mg-1_gf-0.005


❯ echo "${f_GG}"
./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta


❯ echo "${p_ref}/${f_ref}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta


❯ echo "${p_gtf}/${f_gtf}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf


❯ echo "${p_gmap}/${d_gmap}"
/home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap


❯ echo "${p_f_sam}"
bams/WT_Q_day7_N_merged.UTK_prim.sam


❯ ., "${p_f_sam}"
-rw-rw---- 1 kalavatt 18G Feb 21 09:07 bams/WT_Q_day7_N_merged.UTK_prim.sam


❯ echo "${d_out}"
outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-6


❯ rnaQUAST.py \
    -t "${SLURM_CPUS_ON_NODE}" \
    --labels "${n_GG}" \
    --transcripts "${f_GG}" \
    --reference "${p_ref}/${f_ref}" \
    --gtf "${p_gtf}/${f_gtf}" \
    --gmap_index "${p_gmap}/${d_gmap}" \
    --strand_specific \
    -sam "${p_f_sam}" \
    --output_dir "${d_out}" \
    --disable_infer_genes \
    --disable_infer_transcripts
/home/kalavatt/miniconda3/envs/rnaquast_curr_env/share/rnaquast-2.2.1-0/rnaQUAST.py -t 16 --labels gg_mkc-16_mir-0.005_mg-1_gf-0.005 --transcripts ./Trinity_GG.Q_N/trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta --reference /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta --gtf /home/kalavatt/genomes/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf --gmap_index /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta.gmap --strand_specific -sam bams/WT_Q_day7_N_merged.UTK_prim.sam --output_dir outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-6 --disable_infer_genes --disable_infer_transcripts

rnaQUAST: 2.2.1

System information:
  OS: Linux-4.15.0-192-generic-x86_64-with-debian-buster-sid (linux_64)
  Python version: 3.7.12
  CPUs number: 24

External tools:
  matplotlib: 3.5.3
  joblib: 1.2.0
  gffutils: 0.11.1
  blastn: 2.13.0+
  makeblastdb: 2.13.0+
  gmap: 2017-11-15

Started: 2023-02-21 09:13:10

Logging to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-6/logs/rnaQUAST.log

2023-02-21 09:13:10
Getting reference...
Done.
Using strand specific transcripts...

2023-02-21 09:13:11
Creating sqlite3 db by gffutils...
2023-02-21 09:13:14,608 - INFO - Committing changes: 41000 features
2023-02-21 09:13:14,692 - INFO - Populating features table and first-order relations: 41878 features
2023-02-21 09:13:14,700 - INFO - Creating relations(parent) index
2023-02-21 09:13:14,729 - INFO - Creating relations(child) index
2023-02-21 09:13:14,756 - INFO - Creating features(featuretype) index
2023-02-21 09:13:14,768 - INFO - Creating features (seqid, start, end) index
2023-02-21 09:13:14,786 - INFO - Creating features (seqid, start, end, strand) index
2023-02-21 09:13:14,806 - INFO - Running ANALYZE features
  saved to /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-6/Saccharomyces_cerevisiae.R64-1-1.108.db.

2023-02-21 09:13:14
Loading sqlite3 db by gffutils from /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0218/outfiles_rnaQUAST-test_Trinity-GG_Q-N_2022-0220_run-6/Saccharomyces_cerevisiae.R64-1-1.108.db to memory...
Done.
```
</details>
<br />
