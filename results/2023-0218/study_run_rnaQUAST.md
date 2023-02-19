
`#study_run_rnaQUAST.md`
<br />
<br />

## Install rnaQUAST in its own environment
### Code
<details>
<summary><i>Code: Install rnaQUAST in its own environment</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

conda create -n rnaquast_env -c bioconda rnaquast
```
</details>
<br />

### Printed
<details>
<summary><i>Printed: Install rnaQUAST in its own environment</i></summary>

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

## Check on Trinity GG `Q_N` that have failed or not yet completed
### Notes, printed
<details>
<summary><i>Notes: Check on Trinity GG Q_N that have failed or not yet completed</i></summary>

In `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_Trinity-GG/Q_N`, we see that the following three fasta files have not been generated&mdash;what is going with these datasets?
- `trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01/`
- `trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05/`
- `trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05/`

`trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01` is still running&mdash;it has been running for 2 days and 22 hours at the time of writing

The other two jobs were nearly completed before they failed; I posted a [question]() to the [trinityrnaseq-users](https://groups.google.com/g/trinityrnaseq-users) forum about this
</details>
<br />

### Printed
<details>
<summary><i>Printed: Check on Trinity GG Q_N that have failed or not yet completed</i></summary>

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

## Make necessary directories
### Code
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
<br />

<a id="find-relative-paths-for-trinity-gf-and-gg-files"></a>
## Symlink the Trinity GG Q_N directory
<a id="code-1"></a>
### Code
<details>
<summary><i>Code: Symlink the Trinity GG Q_N directory</i></summary>

```bash
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
<br />

## Get situated
### Code
<details>
<summary><i>Code: Get situated</i></summary>

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
<br />

## Initialize arrays related to Trinity GG Q_N fasta files, and variables
### Code
<details>
<summary><i>Code: Initialize arrays related to Trinity GG Q_N fasta files, and variables</i></summary>

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
<br />

## Try a trial run of rnaQUAST
### Code
<details>
<summary><i>Code: Try a trial run of rnaQUAST</i></summary>

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

### Printed
<details>
<summary><i>Printed: Try a trial run of rnaQUAST</i></summary>

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
