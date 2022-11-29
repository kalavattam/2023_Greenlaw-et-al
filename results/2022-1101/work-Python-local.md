
<br />
<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set up local `Trinity_env` `conda`/`mamba` environment](#set-up-local-trinity_env-condamamba-environment)
  1. [Create the environment and install some of the programs](#create-the-environment-and-install-some-of-the-programs)
  1. [Install additional programs, including `jupyterlab`](#install-additional-programs-including-jupyterlab)
1. [Set up `jupyterlab` for use as an IDE](#set-up-jupyterlab-for-use-as-an-ide)
  1. [Update keyboard shortcut bindings](#update-keyboard-shortcut-bindings)
  1. [Install a variable inspector for `jupyterlab`](#install-a-variable-inspector-for-jupyterlab)
  1. [Install a linter for `jupyterlab`](#install-a-linter-for-jupyterlab)
1. [Step through portions of `*-filter-uncorrectable-fastq.py*`](#step-through-portions-of--filter-uncorrectable-fastqpy)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="set-up-local-trinity_env-condamamba-environment"></a>
## Set up local `Trinity_env` `conda`/`mamba` environment
<a id="create-the-environment-and-install-some-of-the-programs"></a>
### Create the environment and install some of the programs
```bash
#!/bin/bash
#DONTRUN

#  Create the environment such that it'll use x86 (and thus Rosetta since I'm
#+ on an Apple M* architecture machine) for its programs
create_x86_conda_environment () {
    #  Create a conda environment using x86 architecture
    #+
    #+ The first argument is environment name; all subsequent arguments will be
    #+ passed to `conda create`
    #+
    #+ example usage: create_x86_conda_environment myenv_x86 python=3.9

    CONDA_SUBDIR=osx-64 conda create -n ${@}
    conda activate ${1}
    conda config --env --set subdir osx-64
}

create_x86_conda_environment Trinity_env \
	-c bioconda \
    trim-galore rcorrector star fastqc bedtools
```

<details>
<summary><i>create_x86_conda_environment Trinity_env messages printed to terminal:</i></summary>

```txt
Collecting package metadata (current_repodata.json): done
Solving environment: done

## Package Plan ##

  environment location: /Users/kalavatt/mambaforge/envs/Trinity_env

  added / updated specs:
    - bedtools
    - fastqc
    - rcorrector
    - star
    - trim-galore


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    bedtools-2.30.0            |       h0e31d98_3         810 KB  bioconda
    bz2file-0.98               |             py_0           9 KB  conda-forge
    cutadapt-1.18              |   py37h1de35cc_1         178 KB  bioconda
    fastqc-0.11.9              |       hdfd78af_1         9.7 MB  bioconda
    freetype-2.12.1            |       h3f81eb7_1         586 KB  conda-forge
    kmer-jellyfish-2.3.0       |       hcd10b59_3         332 KB  bioconda
    libpng-1.6.39              |       ha978bb4_0         265 KB  conda-forge
    libsqlite-3.40.0           |       ha978bb4_0         873 KB  conda-forge
    openjdk-17.0.3             |       hbc0c0cd_4       168.3 MB  conda-forge
    perl-5.32.1                | 2_h0d85af4_perl5        13.4 MB  conda-forge
    pigz-2.6                   |       h5dbffcc_0          88 KB  conda-forge
    pip-22.3.1                 |     pyhd8ed1ab_0         1.5 MB  conda-forge
    python-3.7.12              |hf3644f1_100_cpython        24.3 MB  conda-forge
    rcorrector-1.0.5           |       hb8176d5_0          35 KB  bioconda
    setuptools-65.5.1          |     pyhd8ed1ab_0         731 KB  conda-forge
    sqlite-3.40.0              |       h9ae0607_0         885 KB  conda-forge
    star-2.7.10b               |       h527b516_0         2.9 MB  bioconda
    trim-galore-0.6.7          |       hdfd78af_0          42 KB  bioconda
    wheel-0.38.4               |     pyhd8ed1ab_0          32 KB  conda-forge
    xopen-0.7.3                |             py_0          11 KB  bioconda
    ------------------------------------------------------------
                                           Total:       224.8 MB

The following NEW packages will be INSTALLED:

  bedtools           bioconda/osx-64::bedtools-2.30.0-h0e31d98_3 None
  bz2file            conda-forge/noarch::bz2file-0.98-py_0 None
  bzip2              conda-forge/osx-64::bzip2-1.0.8-h0d85af4_4 None
  ca-certificates    conda-forge/osx-64::ca-certificates-2022.9.24-h033912b_0 None
  cutadapt           bioconda/osx-64::cutadapt-1.18-py37h1de35cc_1 None
  expat              conda-forge/osx-64::expat-2.5.0-hf0c8a7f_0 None
  fastqc             bioconda/noarch::fastqc-0.11.9-hdfd78af_1 None
  font-ttf-dejavu-s~ conda-forge/noarch::font-ttf-dejavu-sans-mono-2.37-hab24e00_0 None
  fontconfig         conda-forge/osx-64::fontconfig-2.14.1-h5bb23bf_0 None
  freetype           conda-forge/osx-64::freetype-2.12.1-h3f81eb7_1 None
  kmer-jellyfish     bioconda/osx-64::kmer-jellyfish-2.3.0-hcd10b59_3 None
  libcxx             conda-forge/osx-64::libcxx-14.0.6-hccf4f1f_0 None
  libffi             conda-forge/osx-64::libffi-3.4.2-h0d85af4_5 None
  libpng             conda-forge/osx-64::libpng-1.6.39-ha978bb4_0 None
  libsqlite          conda-forge/osx-64::libsqlite-3.40.0-ha978bb4_0 None
  libzlib            conda-forge/osx-64::libzlib-1.2.13-hfd90126_4 None
  ncurses            conda-forge/osx-64::ncurses-6.3-h96cf925_1 None
  openjdk            conda-forge/osx-64::openjdk-17.0.3-hbc0c0cd_4 None
  openssl            conda-forge/osx-64::openssl-3.0.7-hfd90126_0 None
  perl               conda-forge/osx-64::perl-5.32.1-2_h0d85af4_perl5 None
  pigz               conda-forge/osx-64::pigz-2.6-h5dbffcc_0 None
  pip                conda-forge/noarch::pip-22.3.1-pyhd8ed1ab_0 None
  python             conda-forge/osx-64::python-3.7.12-hf3644f1_100_cpython None
  rcorrector         bioconda/osx-64::rcorrector-1.0.5-hb8176d5_0 None
  readline           conda-forge/osx-64::readline-8.1.2-h3899abd_0 None
  setuptools         conda-forge/noarch::setuptools-65.5.1-pyhd8ed1ab_0 None
  sqlite             conda-forge/osx-64::sqlite-3.40.0-h9ae0607_0 None
  star               bioconda/osx-64::star-2.7.10b-h527b516_0 None
  tk                 conda-forge/osx-64::tk-8.6.12-h5dbffcc_0 None
  trim-galore        bioconda/noarch::trim-galore-0.6.7-hdfd78af_0 None
  wheel              conda-forge/noarch::wheel-0.38.4-pyhd8ed1ab_0 None
  xopen              bioconda/noarch::xopen-0.7.3-py_0 None
  xz                 conda-forge/osx-64::xz-5.2.6-h775f41a_0 None
  zlib               conda-forge/osx-64::zlib-1.2.13-hfd90126_4 None


Proceed ([y]/n)? Y


Downloading and Extracting Packages
perl-5.32.1          | 13.4 MB   | ##################################################################################################################### | 100%
rcorrector-1.0.5     | 35 KB     | ##################################################################################################################### | 100%
xopen-0.7.3          | 11 KB     | ##################################################################################################################### | 100%
bedtools-2.30.0      | 810 KB    | ##################################################################################################################### | 100%
fastqc-0.11.9        | 9.7 MB    | ##################################################################################################################### | 100%
star-2.7.10b         | 2.9 MB    | ##################################################################################################################### | 100%
freetype-2.12.1      | 586 KB    | ##################################################################################################################### | 100%
pip-22.3.1           | 1.5 MB    | ##################################################################################################################### | 100%
python-3.7.12        | 24.3 MB   | ##################################################################################################################### | 100%
openjdk-17.0.3       | 168.3 MB  | ##################################################################################################################### | 100%
cutadapt-1.18        | 178 KB    | ##################################################################################################################### | 100%
trim-galore-0.6.7    | 42 KB     | ##################################################################################################################### | 100%
setuptools-65.5.1    | 731 KB    | ##################################################################################################################### | 100%
libsqlite-3.40.0     | 873 KB    | ##################################################################################################################### | 100%
libpng-1.6.39        | 265 KB    | ##################################################################################################################### | 100%
kmer-jellyfish-2.3.0 | 332 KB    | ##################################################################################################################### | 100%
wheel-0.38.4         | 32 KB     | ##################################################################################################################### | 100%
pigz-2.6             | 88 KB     | ##################################################################################################################### | 100%
bz2file-0.98         | 9 KB      | ##################################################################################################################### | 100%
sqlite-3.40.0        | 885 KB    | ##################################################################################################################### | 100%
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
#
# To activate this environment, use
#
#     $ conda activate Trinity_env
#
# To deactivate an active environment, use
#
#     $ conda deactivate

Retrieving notices: ...working... done
```
</details>

<a id="install-additional-programs-including-jupyterlab"></a>
### Install additional programs, including `jupyterlab`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Create an environment alias, save it, and then activate the environment 
echo 'alias Trinity_env="conda activate Trinity_env"' >> ~/.zaliases
alias Trinity_env="conda activate Trinity_env"
Trinity_env

#  Install more programs
mamba install -c bioconda rename samtools

#  After the above, install parallel and jupyterlab from conda-forge
mamba install -c conda-forge parallel jupyterlab
```

<details>
<summary><i>mamba install -c bioconda rename samtools messages printed to terminal:</i></summary>

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['rename', 'samtools']

bioconda/noarch                                             Using cache
conda-forge/noarch                                          Using cache
bioconda/osx-64                                      3.7MB @   3.2MB/s  1.3s
conda-forge/osx-64                                  25.5MB @   4.0MB/s  7.0s

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - rename
   - samtools
   - ca-certificates
   - openssl


  Package            Version  Build       Channel                  Size
─────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────

  + c-ares            1.18.1  h0d85af4_0  conda-forge/osx-64     Cached
  + htslib              1.16  h567f53e_0  bioconda/osx-64        Cached
  + krb5              1.19.3  hb98e516_0  conda-forge/osx-64     Cached
  + libcurl           7.86.0  h581aaea_1  conda-forge/osx-64      351kB
  + libdeflate          1.13  h775f41a_0  conda-forge/osx-64     Cached
  + libedit     3.1.20191231  h0678c8f_2  conda-forge/osx-64     Cached
  + libev               4.33  haf1e3a3_1  conda-forge/osx-64     Cached
  + libnghttp2        1.47.0  h5aae05b_1  conda-forge/osx-64     Cached
  + libssh2           1.10.0  h47af595_3  conda-forge/osx-64     Cached
  + rename             1.601  hdfd78af_1  bioconda/noarch          13kB
  + samtools          1.16.1  h7e39424_1  bioconda/osx-64        Cached

  Summary:

  Install: 11 packages

  Total download: 365kB

─────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
libcurl                                            351.2kB @   2.1MB/s  0.2s
rename                                              13.4kB @  52.9kB/s  0.3s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>

<details>
<summary><i>mamba install -c conda-forge parallel jupyterlab messages printed to terminal:</i></summary>

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['parallel', 'jupyterlab']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - parallel
   - jupyterlab
   - ca-certificates
   - openssl


  Package                              Version  Build              Channel                  Size
──────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────────────────

  + anyio                                3.6.2  pyhd8ed1ab_0       conda-forge/noarch       85kB
  + appnope                              0.1.3  pyhd8ed1ab_0       conda-forge/noarch        8kB
  + argon2-cffi                         21.3.0  pyhd8ed1ab_0       conda-forge/noarch       16kB
  + argon2-cffi-bindings                21.2.0  py37h69ee0a8_2     conda-forge/osx-64       35kB
  + attrs                               22.1.0  pyh71513ae_1       conda-forge/noarch       49kB
  + babel                               2.11.0  pyhd8ed1ab_0       conda-forge/noarch        7MB
  + backcall                             0.2.0  pyh9f0ad1d_0       conda-forge/noarch       14kB
  + backports                              1.0  pyhd8ed1ab_3       conda-forge/noarch        6kB
  + backports.functools_lru_cache        1.6.4  pyhd8ed1ab_0       conda-forge/noarch        9kB
  + beautifulsoup4                      4.11.1  pyha770c72_0       conda-forge/noarch       98kB
  + bleach                               5.0.1  pyhd8ed1ab_0       conda-forge/noarch      127kB
  + brotlipy                             0.7.0  py37h69ee0a8_1004  conda-forge/osx-64      375kB
  + certifi                          2022.9.24  pyhd8ed1ab_0       conda-forge/noarch     Cached
  + cffi                                1.15.1  py37h7346b73_1     conda-forge/osx-64      224kB
  + charset-normalizer                   2.1.1  pyhd8ed1ab_0       conda-forge/noarch     Cached
  + cryptography                        38.0.2  py37hbf3704f_1     conda-forge/osx-64        1MB
  + debugpy                              1.6.3  py37hf6dfe07_0     conda-forge/osx-64        2MB
  + decorator                            5.1.1  pyhd8ed1ab_0       conda-forge/noarch       12kB
  + defusedxml                           0.7.1  pyhd8ed1ab_0       conda-forge/noarch       24kB
  + entrypoints                            0.4  pyhd8ed1ab_0       conda-forge/noarch        9kB
  + flit-core                            3.8.0  pyhd8ed1ab_0       conda-forge/noarch       46kB
  + idna                                   3.4  pyhd8ed1ab_0       conda-forge/noarch     Cached
  + importlib-metadata                  4.11.4  py37hf985489_0     conda-forge/osx-64       34kB
  + importlib_resources                 5.10.0  pyhd8ed1ab_0       conda-forge/noarch       30kB
  + ipykernel                           6.16.2  pyh736e0ef_0       conda-forge/noarch      102kB
  + ipython                             7.33.0  py37hf985489_0     conda-forge/osx-64        1MB
  + ipython_genutils                     0.2.0  py_1               conda-forge/noarch       22kB
  + jedi                                0.18.2  pyhd8ed1ab_0       conda-forge/noarch      804kB
  + jinja2                               3.1.2  pyhd8ed1ab_1       conda-forge/noarch      101kB
  + json5                                0.9.5  pyh9f0ad1d_0       conda-forge/noarch       21kB
  + jsonschema                          4.17.1  pyhd8ed1ab_0       conda-forge/noarch       71kB
  + jupyter_client                       7.4.7  pyhd8ed1ab_0       conda-forge/noarch       94kB
  + jupyter_core                        4.11.1  py37hf985489_0     conda-forge/osx-64       83kB
  + jupyter_server                      1.23.3  pyhd8ed1ab_0       conda-forge/noarch      239kB
  + jupyterlab                           3.5.0  pyhd8ed1ab_0       conda-forge/noarch        6MB
  + jupyterlab_pygments                  0.2.2  pyhd8ed1ab_0       conda-forge/noarch       17kB
  + jupyterlab_server                   2.16.3  pyhd8ed1ab_0       conda-forge/noarch       51kB
  + libsodium                           1.0.18  hbcb3906_1         conda-forge/osx-64      529kB
  + markupsafe                           2.1.1  py37h69ee0a8_1     conda-forge/osx-64       21kB
  + matplotlib-inline                    0.1.6  pyhd8ed1ab_0       conda-forge/noarch       12kB
  + mistune                              2.0.4  pyhd8ed1ab_0       conda-forge/noarch       69kB
  + nbclassic                            0.4.8  pyhd8ed1ab_0       conda-forge/noarch        8MB
  + nbclient                             0.7.0  pyhd8ed1ab_0       conda-forge/noarch       67kB
  + nbconvert                            7.2.5  pyhd8ed1ab_0       conda-forge/noarch        6kB
  + nbconvert-core                       7.2.5  pyhd8ed1ab_0       conda-forge/noarch      197kB
  + nbconvert-pandoc                     7.2.5  pyhd8ed1ab_0       conda-forge/noarch        5kB
  + nbformat                             5.7.0  pyhd8ed1ab_0       conda-forge/noarch      109kB
  + nest-asyncio                         1.5.6  pyhd8ed1ab_0       conda-forge/noarch       10kB
  + notebook                             6.5.2  pyha770c72_1       conda-forge/noarch      273kB
  + notebook-shim                        0.2.2  pyhd8ed1ab_0       conda-forge/noarch       15kB
  + packaging                             21.3  pyhd8ed1ab_0       conda-forge/noarch       36kB
  + pandoc                              2.19.2  h694c41f_1         conda-forge/osx-64     Cached
  + pandocfilters                        1.5.0  pyhd8ed1ab_0       conda-forge/noarch       12kB
  + parallel                          20221122  h694c41f_0         conda-forge/osx-64        2MB
  + parso                                0.8.3  pyhd8ed1ab_0       conda-forge/noarch       71kB
  + pexpect                              4.8.0  pyh1a96a4e_2       conda-forge/noarch       49kB
  + pickleshare                          0.7.5  py_1003            conda-forge/noarch        9kB
  + pkgutil-resolve-name                1.3.10  pyhd8ed1ab_0       conda-forge/noarch        9kB
  + prometheus_client                   0.15.0  pyhd8ed1ab_0       conda-forge/noarch       51kB
  + prompt-toolkit                      3.0.33  pyha770c72_0       conda-forge/noarch      266kB
  + psutil                               5.9.3  py37h8052db5_0     conda-forge/osx-64      363kB
  + ptyprocess                           0.7.0  pyhd3deb0d_0       conda-forge/noarch       17kB
  + pycparser                             2.21  pyhd8ed1ab_0       conda-forge/noarch     Cached
  + pygments                            2.13.0  pyhd8ed1ab_0       conda-forge/noarch      840kB
  + pyopenssl                           22.1.0  pyhd8ed1ab_0       conda-forge/noarch     Cached
  + pyparsing                            3.0.9  pyhd8ed1ab_0       conda-forge/noarch       81kB
  + pyrsistent                          0.18.1  py37h69ee0a8_1     conda-forge/osx-64       90kB
  + pysocks                              1.7.1  py37hf985489_5     conda-forge/osx-64       28kB
  + python-dateutil                      2.8.2  pyhd8ed1ab_0       conda-forge/noarch      246kB
  + python-fastjsonschema               2.16.2  pyhd8ed1ab_0       conda-forge/noarch      247kB
  + python_abi                             3.7  3_cp37m            conda-forge/osx-64        6kB
  + pytz                                2022.6  pyhd8ed1ab_0       conda-forge/noarch      240kB
  + pyzmq                               24.0.1  py37haa7bc41_0     conda-forge/osx-64      458kB
  + requests                            2.28.1  pyhd8ed1ab_1       conda-forge/noarch     Cached
  + send2trash                           1.8.0  pyhd8ed1ab_0       conda-forge/noarch       18kB
  + six                                 1.16.0  pyh6c4a22f_0       conda-forge/noarch       14kB
  + sniffio                              1.3.0  pyhd8ed1ab_0       conda-forge/noarch       14kB
  + soupsieve                      2.3.2.post1  pyhd8ed1ab_0       conda-forge/noarch       35kB
  + terminado                           0.17.0  pyhd1c38e8_0       conda-forge/noarch       19kB
  + tinycss2                             1.2.1  pyhd8ed1ab_0       conda-forge/noarch       23kB
  + tomli                                2.0.1  pyhd8ed1ab_0       conda-forge/noarch       16kB
  + tornado                                6.2  py37h994c40b_0     conda-forge/osx-64      663kB
  + traitlets                            5.5.0  pyhd8ed1ab_0       conda-forge/noarch       87kB
  + typing_extensions                    4.4.0  pyha770c72_0       conda-forge/noarch       30kB
  + urllib3                            1.26.13  pyhd8ed1ab_0       conda-forge/noarch      111kB
  + wcwidth                              0.2.5  pyh9f0ad1d_2       conda-forge/noarch       34kB
  + webencodings                         0.5.1  py_1               conda-forge/noarch       12kB
  + websocket-client                     1.4.2  pyhd8ed1ab_0       conda-forge/noarch       44kB
  + zeromq                               4.3.4  he49afe7_1         conda-forge/osx-64      321kB
  + zipp                                3.11.0  pyhd8ed1ab_0       conda-forge/noarch       16kB

  Summary:

  Install: 90 packages

  Total download: 36MB

──────────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
python_abi                                           5.8kB @  73.3kB/s  0.1s
pysocks                                             28.4kB @ 338.1kB/s  0.1s
pyrsistent                                          90.4kB @ 983.4kB/s  0.1s
tomli                                               15.9kB @ 142.6kB/s  0.0s
decorator                                           12.1kB @  98.0kB/s  0.0s
libsodium                                          528.8kB @   4.2MB/s  0.1s
pyzmq                                              458.2kB @   3.4MB/s  0.1s
backcall                                            13.7kB @  97.0kB/s  0.0s
parso                                               71.0kB @ 457.5kB/s  0.0s
pyparsing                                           81.3kB @ 495.9kB/s  0.0s
python-fastjsonschema                              247.5kB @   1.4MB/s  0.0s
entrypoints                                          9.2kB @  51.8kB/s  0.0s
json5                                               20.9kB @ 111.3kB/s  0.0s
pytz                                               240.2kB @   1.2MB/s  0.0s
jinja2                                             101.4kB @ 487.0kB/s  0.0s
typing_extensions                                   30.0kB @ 136.3kB/s  0.0s
python-dateutil                                    246.0kB @   1.1MB/s  0.0s
jedi                                               804.4kB @   3.5MB/s  0.0s
beautifulsoup4                                      98.3kB @ 411.9kB/s  0.0s
wcwidth                                             34.1kB @ 134.3kB/s  0.0s
anyio                                               85.2kB @ 329.9kB/s  0.0s
importlib-metadata                                  33.6kB @ 126.9kB/s  0.0s
brotlipy                                           375.3kB @   1.4MB/s  0.0s
jupyter_client                                      94.1kB @ 338.1kB/s  0.0s
ipykernel                                          102.2kB @ 349.0kB/s  0.0s
nbclient                                            66.6kB @ 225.3kB/s  0.0s
jupyter_server                                     238.5kB @ 799.9kB/s  0.0s
jupyterlab_server                                   51.1kB @ 170.8kB/s  0.0s
ipython_genutils                                    21.6kB @  67.4kB/s  0.0s
appnope                                              8.1kB @  24.8kB/s  0.0s
markupsafe                                          21.3kB @  64.7kB/s  0.0s
prometheus_client                                   51.0kB @ 147.8kB/s  0.0s
six                                                 14.3kB @  40.1kB/s  0.0s
mistune                                             69.0kB @ 187.7kB/s  0.0s
webencodings                                        11.9kB @  32.2kB/s  0.0s
attrs                                               49.5kB @ 127.2kB/s  0.0s
flit-core                                           46.3kB @ 118.7kB/s  0.0s
pexpect                                             48.8kB @ 119.7kB/s  0.0s
tinycss2                                            23.2kB @  56.1kB/s  0.0s
jupyterlab                                           6.3MB @  14.3MB/s  0.1s
importlib_resources                                 29.5kB @  65.9kB/s  0.1s
jupyter_core                                        83.2kB @ 183.2kB/s  0.0s
cryptography                                         1.2MB @   2.6MB/s  0.1s
argon2-cffi                                         15.7kB @  32.8kB/s  0.0s
nbconvert-core                                     197.3kB @ 411.5kB/s  0.0s
notebook-shim                                       14.9kB @  30.8kB/s  0.0s
psutil                                             363.0kB @ 719.8kB/s  0.0s
pickleshare                                          9.3kB @  18.5kB/s  0.0s
ptyprocess                                          16.5kB @  32.1kB/s  0.0s
backports                                            6.0kB @  11.0kB/s  0.0s
defusedxml                                          24.1kB @  42.5kB/s  0.1s
matplotlib-inline                                   12.3kB @  21.5kB/s  0.1s
zeromq                                             320.8kB @ 546.0kB/s  0.1s
bleach                                             127.1kB @ 211.7kB/s  0.0s
nbformat                                           108.8kB @ 175.1kB/s  0.0s
packaging                                           36.4kB @  58.1kB/s  0.1s
nbconvert                                            6.4kB @  10.1kB/s  0.0s
nest-asyncio                                         9.7kB @  14.7kB/s  0.0s
traitlets                                           87.4kB @ 131.7kB/s  0.0s
ipython                                              1.2MB @   1.7MB/s  0.1s
debugpy                                              2.0MB @   2.9MB/s  0.1s
soupsieve                                           34.7kB @  50.2kB/s  0.0s
zipp                                                15.7kB @  22.6kB/s  0.0s
parallel                                             1.8MB @   2.5MB/s  0.7s
nbconvert-pandoc                                     5.4kB @   7.4kB/s  0.0s
tornado                                            663.2kB @ 904.1kB/s  0.0s
websocket-client                                    43.7kB @  58.4kB/s  0.0s
sniffio                                             14.4kB @  19.1kB/s  0.0s
backports.functools_lru_cache                        9.0kB @  11.9kB/s  0.0s
pkgutil-resolve-name                                 8.7kB @  11.1kB/s  0.0s
notebook                                           272.9kB @ 348.6kB/s  0.0s
jsonschema                                          70.5kB @  89.5kB/s  0.0s
argon2-cffi-bindings                                35.1kB @  44.5kB/s  0.1s
terminado                                           19.1kB @  23.6kB/s  0.0s
prompt-toolkit                                     265.7kB @ 323.8kB/s  0.0s
urllib3                                            110.7kB @ 133.7kB/s  0.0s
pygments                                           840.4kB @   1.0MB/s  0.0s
send2trash                                          17.5kB @  20.8kB/s  0.0s
babel                                                7.0MB @   8.2MB/s  0.2s
cffi                                               224.0kB @ 257.9kB/s  0.0s
jupyterlab_pygments                                 17.4kB @  20.0kB/s  0.0s
pandocfilters                                       11.6kB @  13.2kB/s  0.0s
nbclassic                                            8.0MB @   8.2MB/s  0.1s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />
<br />

<a id="set-up-jupyterlab-for-use-as-an-ide"></a>
## Set up `jupyterlab` for use as an IDE
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Run Jupyter Lab
jupyter lab
```
<a id="update-keyboard-shortcut-bindings"></a>
### Update keyboard shortcut bindings
1. Settings `>` Advanced Settings Editor `>` JSON Settings Editor
2. Change the following such that `command enter` runs highlighted code, not what's shown below
<img src="notebook/key-binding-initial.jupyterlab.png" alt="drawing" width="625">

3. Disable use of shortcut `command enter` with `"command": "notebook:run-cell"`
	- this command can still be executed with shortcut `control enter`
	- the material at this [link](https://stackoverflow.com/questions/70435519/jupyter-lab-delete-all-default-shortcuts) explains how to disable default shortcuts
4. Actually, go ahead and disable the use of `control enter` for `"command": "notebook:run-cell"` too
5. Following the advice at this [link](https://stackoverflow.com/questions/56460834/how-to-run-a-single-line-or-selected-code-in-a-jupyter-notebook-or-jupyterlab-ce), insert a new command into the `JSON` file (line `746`) for running highlighted code: `"notebook:run-in-console"`

<i> Custom keyboard settings </i>

```json
{
    // Keyboard Shortcuts
    // @jupyterlab/shortcuts-extension:shortcuts
    // Keyboard shortcut settings.
    // *****************************************

    "shortcuts": [
        {
            "args": {},
            "command": "notebook:run-cell",
            "keys": [
                "Ctrl Enter"
            ],
            "selector": ".jp-Notebook:focus",
            "disabled": true
        },
        {
            "args": {},
            "command": "notebook:run-cell",
            "keys": [
                "Ctrl Enter"
            ],
            "selector": ".jp-Notebook.jp-mod-editMode",
            "disabled": true
        },
        {
            "args": {},
            "command": "notebook:run-cell",
            "keys": [
                "Accel Enter"
            ],
            "selector": ".jp-Notebook:focus",
            "disabled": true
        },
                {
            "args": {},
            "command": "notebook:run-cell-and-insert-below",
            "keys": [
                "Alt Enter"
            ],
            "selector": ".jp-Notebook:focus",
            "disabled": true
        },
        {
            "args": {},
            "command": "notebook:run-cell-and-insert-below",
            "keys": [
                "Alt Enter"
            ],
            "selector": ".jp-Notebook.jp-mod-editMode",
            "disabled": true
        },
        {
            "args": {},
            "command": "notebook:run-in-console",
            "keys": [
                "Accel Enter"
            ],
            "selector": ".jp-Notebook.jp-mod-editMode",
            "disabled": false
        }
    ]
}
```
6. `#TODO` Later, determine appropriate keyboard shortcuts for `"notebook:run-cell-and-insert-below"` and `"notebook:run-cell"`
7. For the above (and more), saved the default key bindings and custom key bindings in separate `.json` files (to be included in the `results/2022-1101/` directory)
<details>
<summary><i>jupyter lab messages printed to terminal:</i></summary>

```txt
[I 2022-11-29 07:42:24.174 ServerApp] jupyterlab | extension was successfully linked.
[I 2022-11-29 07:42:24.182 ServerApp] nbclassic | extension was successfully linked.
[I 2022-11-29 07:42:24.184 ServerApp] Writing Jupyter server cookie secret to /Users/kalavatt/Library/Jupyter/runtime/jupyter_cookie_secret
[I 2022-11-29 07:42:24.493 ServerApp] notebook_shim | extension was successfully linked.
[I 2022-11-29 07:42:24.877 ServerApp] notebook_shim | extension was successfully loaded.
[I 2022-11-29 07:42:24.879 LabApp] JupyterLab extension loaded from /Users/kalavatt/mambaforge/envs/Trinity_env/lib/python3.7/site-packages/jupyterlab
[I 2022-11-29 07:42:24.879 LabApp] JupyterLab application directory is /Users/kalavatt/mambaforge/envs/Trinity_env/share/jupyter/lab
[I 2022-11-29 07:42:24.883 ServerApp] jupyterlab | extension was successfully loaded.
[I 2022-11-29 07:42:24.887 ServerApp] nbclassic | extension was successfully loaded.
[I 2022-11-29 07:42:24.890 ServerApp] Serving notebooks from local directory: /Users/kalavatt/projects-etc/2022_transcriptome-construction
[I 2022-11-29 07:42:24.890 ServerApp] Jupyter Server 1.23.3 is running at:
[I 2022-11-29 07:42:24.890 ServerApp] http://localhost:8888/lab?token=3e03d1ffc651655e8fb98316ad7ea4127550fd731bdc8ccc
[I 2022-11-29 07:42:24.890 ServerApp]  or http://127.0.0.1:8888/lab?token=3e03d1ffc651655e8fb98316ad7ea4127550fd731bdc8ccc
[I 2022-11-29 07:42:24.890 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2022-11-29 07:42:24.897 ServerApp]

    To access the server, open this file in a browser:
        file:///Users/kalavatt/Library/Jupyter/runtime/jpserver-26776-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/lab?token=3e03d1ffc651655e8fb98316ad7ea4127550fd731bdc8ccc
     or http://127.0.0.1:8888/lab?token=3e03d1ffc651655e8fb98316ad7ea4127550fd731bdc8ccc
[W 2022-11-29 07:42:28.071 LabApp] Could not determine jupyterlab build status without nodejs
[I 2022-11-29 07:49:31.589 ServerApp] Creating new notebook in /results/2022-1101
[I 2022-11-29 07:49:31.649 ServerApp] Writing notebook-signing key to /Users/kalavatt/Library/Jupyter/notebook_secret
[I 2022-11-29 07:49:31.871 ServerApp] Kernel started: 68897743-b29a-4ff6-8187-8c41d33d8f5f
[I 2022-11-29 07:51:31.770 ServerApp] Saving file at /results/2022-1101/Untitled.ipynb
[I 2022-11-29 08:33:39.291 ServerApp] Saving file at /results/2022-1101/Untitled.ipynb
[I 2022-11-29 09:00:48.047 ServerApp] Creating new notebook in /results/2022-1101
[I 2022-11-29 09:00:48.217 ServerApp] Kernel started: 2910ab38-eb5a-47ef-b8a8-d6bce0942f91
[I 2022-11-29 09:00:56.222 ServerApp] Kernel shutdown: 2910ab38-eb5a-47ef-b8a8-d6bce0942f91
[W 2022-11-29 09:00:56.470 ServerApp] delete /results/2022-1101/Untitled1.ipynb
[I 2022-11-29 09:02:58.700 ServerApp] Saving file at /results/2022-1101/Untitled.ipynb
[I 2022-11-29 09:21:29.112 ServerApp] Saving file at /results/2022-1101/Untitled.ipynb
[I 2022-11-29 09:24:02.430 ServerApp] Saving file at /results/2022-1101/Untitled.ipynb
[W 2022-11-29 09:24:22.450 ServerApp] 404 GET /api/contents/results/2022-1101/work-Python-local.ipynb?1669742662442 (::1): file or directory does not exist: 'results/2022-1101/work-Python-local.ipynb'
[W 2022-11-29 09:24:22.451 ServerApp] wrote error: "file or directory does not exist: 'results/2022-1101/work-Python-local.ipynb'"
[W 2022-11-29 09:24:22.460 ServerApp] 404 GET /api/contents/results/2022-1101/work-Python-local.ipynb?1669742662442 (::1) 12.24ms referer=http://localhost:8888/lab/tree/results/2022-1101/Untitled.ipynb
[W 2022-11-29 09:24:22.471 ServerApp] 404 GET /api/contents/results/2022-1101/work-Python-local.ipynb?content=0&1669742662469 (::1): file or directory does not exist: 'results/2022-1101/work-Python-local.ipynb'
[W 2022-11-29 09:24:22.472 ServerApp] wrote error: "file or directory does not exist: 'results/2022-1101/work-Python-local.ipynb'"
[W 2022-11-29 09:24:22.472 ServerApp] 404 GET /api/contents/results/2022-1101/work-Python-local.ipynb?content=0&1669742662469 (::1) 1.16ms referer=http://localhost:8888/lab/tree/results/2022-1101/Untitled.ipynb
[I 2022-11-29 09:24:22.476 ServerApp] Uploading file to /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:25:01.756 ServerApp] Kernel shutdown: 68897743-b29a-4ff6-8187-8c41d33d8f5f
^C[I 2022-11-29 09:25:06.372 ServerApp] interrupted
Serving notebooks from local directory: /Users/kalavatt/projects-etc/2022_transcriptome-construction
0 active kernels
Jupyter Server 1.23.3 is running at:
http://localhost:8888/lab?token=3e03d1ffc651655e8fb98316ad7ea4127550fd731bdc8ccc
 or http://127.0.0.1:8888/lab?token=3e03d1ffc651655e8fb98316ad7ea4127550fd731bdc8ccc
Shutdown this Jupyter server (y/[n])? y
[C 2022-11-29 09:25:08.220 ServerApp] Shutdown confirmed
[I 2022-11-29 09:25:08.223 ServerApp] Shutting down 3 extensions
[I 2022-11-29 09:25:08.224 ServerApp] Shutting down 0 terminals
```
</details>

<a id="install-a-variable-inspector-for-jupyterlab"></a>
### Install a variable inspector for `jupyterlab`
To do so, follow the advice for Jupyter Lab at this link (but use `conda`/`mamba`, not `pip`)
```bash
#!/bin/bash
#DONTRUN #CONTINUE
mamba install -c conda-forge jupyterlab-variableinspector
```

<details>
<summary><i>mamba install -c conda-forge jupyterlab-variableinspector messages printed to terminal:</i></summary>

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['jupyterlab-variableinspector']

conda-forge/noarch                                  10.4MB @   3.6MB/s  3.1s
conda-forge/osx-64                                  25.5MB @   2.4MB/s 11.2s

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - jupyterlab-variableinspector
   - ca-certificates
   - certifi
   - openssl


  Package                         Version  Build         Channel                Size
──────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────

  + jupyterlab-variableinspector    3.0.9  pyhd8ed1ab_0  conda-forge/noarch     54kB

  Summary:

  Install: 1 packages

  Total download: 54kB

──────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] T
Confirm changes: [Y/n] Y
jupyterlab-variableinspector                        54.4kB @ 405.9kB/s  0.1s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>

<a id="install-a-linter-for-jupyterlab"></a>
### Install a linter for `jupyterlab`
```bash
#!/bin/bash
#DONTRUN #CONTINUE
mamba install -c conda-forge pycodestyle
```

<details>
<summary><i>mamba install -c conda-forge pycodestyle messages printed to terminal:</i></summary>

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['pycodestyle']

conda-forge/noarch                                  10.4MB @   2.5MB/s  4.4s
conda-forge/osx-64                                  25.5MB @   3.3MB/s  8.4s

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - pycodestyle
   - ca-certificates
   - certifi
   - openssl


  Package        Version  Build         Channel                Size
─────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────

  + pycodestyle   2.10.0  pyhd8ed1ab_0  conda-forge/noarch     43kB

  Summary:

  Install: 1 packages

  Total download: 43kB

─────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
pycodestyle                                         42.5kB @ 204.2kB/s  0.2s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>

<a id="step-through-portions-of--filter-uncorrectable-fastqpy"></a>
## Step through portions of `*-filter-uncorrectable-fastq.py*`
`#DONE` Copy `08_rcorrector/` (~754.5 MB) in `exp_preprocessing/` from remote (FHCC `rhino`/`gizmo`) to local, Apple M1 Max
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Run Jupyter Lab
jupyter lab
```
<details>
<summary><i>jupyter lab messages printed to terminal:</i></summary>

<b>\#1</b>
```txt
[I 2022-11-29 09:30:49.130 ServerApp] jupyterlab | extension was successfully linked.
[I 2022-11-29 09:30:49.137 ServerApp] nbclassic | extension was successfully linked.
[I 2022-11-29 09:30:49.272 ServerApp] notebook_shim | extension was successfully linked.
[I 2022-11-29 09:30:49.298 ServerApp] notebook_shim | extension was successfully loaded.
[I 2022-11-29 09:30:49.299 LabApp] JupyterLab extension loaded from /Users/kalavatt/mambaforge/envs/Trinity_env/lib/python3.7/site-packages/jupyterlab
[I 2022-11-29 09:30:49.299 LabApp] JupyterLab application directory is /Users/kalavatt/mambaforge/envs/Trinity_env/share/jupyter/lab
[I 2022-11-29 09:30:49.302 ServerApp] jupyterlab | extension was successfully loaded.
[I 2022-11-29 09:30:49.305 ServerApp] nbclassic | extension was successfully loaded.
[I 2022-11-29 09:30:49.306 ServerApp] Serving notebooks from local directory: /Users/kalavatt/projects-etc/2022_transcriptome-construction
[I 2022-11-29 09:30:49.306 ServerApp] Jupyter Server 1.23.3 is running at:
[I 2022-11-29 09:30:49.306 ServerApp] http://localhost:8888/lab?token=4c4c55ecc208a98b02a11f66ad46b5c0c0925490582a41d8
[I 2022-11-29 09:30:49.306 ServerApp]  or http://127.0.0.1:8888/lab?token=4c4c55ecc208a98b02a11f66ad46b5c0c0925490582a41d8
[I 2022-11-29 09:30:49.306 ServerApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 2022-11-29 09:30:49.309 ServerApp]

    To access the server, open this file in a browser:
        file:///Users/kalavatt/Library/Jupyter/runtime/jpserver-34460-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/lab?token=4c4c55ecc208a98b02a11f66ad46b5c0c0925490582a41d8
     or http://127.0.0.1:8888/lab?token=4c4c55ecc208a98b02a11f66ad46b5c0c0925490582a41d8
[W 2022-11-29 09:31:29.828 LabApp] Could not determine jupyterlab build status without nodejs
[I 2022-11-29 09:31:44.683 ServerApp] Kernel started: f284b27f-1b50-409d-9bfe-a70ff97e5429
[W 2022-11-29 09:31:45.329 ServerApp] Got events for closed stream <zmq.eventloop.zmqstream.ZMQStream object at 0x7f9fc096bc50>
[I 2022-11-29 09:33:44.635 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:37:45.126 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:39:45.178 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:43:46.116 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:45:46.162 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:47:46.199 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:49:46.242 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:51:46.293 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:53:03.574 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:55:03.628 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:57:03.681 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:59:03.730 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 09:59:41.806 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 10:01:41.868 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 10:03:41.924 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 10:07:41.976 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 10:09:43.123 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 10:14:01.722 ServerApp] Saving file at /results/2022-1101/work-Python-local.ipynb
[I 2022-11-29 10:15:42.937 ServerApp] Starting buffering for f284b27f-1b50-409d-9bfe-a70ff97e5429:207e657c-dfee-43c2-9e6d-ab7eafe56a7d
^C[I 2022-11-29 10:15:46.786 ServerApp] interrupted
Serving notebooks from local directory: /Users/kalavatt/projects-etc/2022_transcriptome-construction
1 active kernel
Jupyter Server 1.23.3 is running at:
http://localhost:8888/lab?token=4c4c55ecc208a98b02a11f66ad46b5c0c0925490582a41d8
 or http://127.0.0.1:8888/lab?token=4c4c55ecc208a98b02a11f66ad46b5c0c0925490582a41d8
Shutdown this Jupyter server (y/[n])? y
[C 2022-11-29 10:15:49.168 ServerApp] Shutdown confirmed
[I 2022-11-29 10:15:49.171 ServerApp] Shutting down 3 extensions
[I 2022-11-29 10:15:49.171 ServerApp] Shutting down 1 kernel
[I 2022-11-29 10:15:49.172 ServerApp] Kernel shutdown: f284b27f-1b50-409d-9bfe-a70ff97e5429
[I 2022-11-29 10:15:49.286 ServerApp] Shutting down 0 terminals
```

<b>\#2</b>
```txt
#NOTE Did not copy it in
```
</details>

`#NOTE` Determined that it will be easier to use a full Python IDE (e.g., `Spyder`) to do this work, so deleted the `.ipynb` file in which I was attempting to do this step-through work  
`#NOTE` Still, setting up and customizing `jupyterlab` was still valuable and worth the time; I can see myself bouncing between notebooks and the full IDE when coding in Python in the future, based on the requirements and goals of the project
