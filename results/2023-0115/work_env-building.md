
`#work_env-building.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Install `miniconda`](#install-miniconda)
    1. [Include safeguards to prevent package installation in base environment](#include-safeguards-to-prevent-package-installation-in-base-environment)
1. [Rebuilding `Trinity_env`](#rebuilding-trinity_env)
1. [Building `atria_env`](#building-atria_env)
1. [Install `atria` for looking into adapters](#install-atria-for-looking-into-adapters)
    1. [1/5](#15)
        1. [Code](#code)
        1. [Printed](#printed)
    1. [2/5](#25)
        1. [Code](#code-1)
        1. [Printed](#printed-1)
    1. [3/5](#35)
        1. [Code](#code-2)
        1. [Printed](#printed-2)
    1. [4/5](#45)
        1. [Code](#code-3)
        1. [Printed](#printed-3)
    1. [5/5](#55)
        1. [Code](#code-4)
        1. [Printed](#printed-4)
1. [Building a `umi_tools_env`](#building-a-umi_tools_env)
1. [Building an environment for PolyAtailor](#building-an-environment-for-polyatailor)
    1. [Notes](#notes)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="install-miniconda"></a>
## Install `miniconda`
<details>
<summary><i>Code: Install miniconda</i></summary>

```bash
#!/bin/bash

pwd

curl https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh \
    > Miniconda3-py39_22.11.1-1-Linux-x86_64.sh

bash Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
```
</details>
<br />

<a id="include-safeguards-to-prevent-package-installation-in-base-environment"></a>
### Include safeguards to prevent package installation in base environment
Code snippets (adapted) to deny `conda install` commands if in the base environment (from [here](https://github.com/conda/conda/issues/7791)):
<br />

<details>
<summary><i>Code: Include safeguards to prevent package installation in base environment</i></summary>

```bash
extended_conda() {
    if \
        [[ "${CONDA_PROMPT_MODIFIER-}" = "(base) " ]] && \
        [[ "${1}" = "install" ]]; \
    then
        echo "Installations in base are not allowed"
    else
        conda "$@"
    fi
}


pip() {
    if \
        [[ "${CONDA_PROMPT_MODIFIER-}" = "(base) " ]] && \
        [[ "${1}" = "install" ]]; \
    then
        echo "Installations in base are not allowed"
    else
        command pip "$@"
    fi
}


alias conda=extended_conda
```
Put `extended_conda()` and `pip()` in `.bash_functions`; put `alias conda=extended_conda` in `.bash_aliases`
</details>
<br />
<br />

<a id="rebuilding-trinity_env"></a>
## Rebuilding `Trinity_env`
<details>
<summary><i>Code: Rebuilding Trinity_env</i></summary>

```bash
#!/bin/env
#DONTRUN #CREATE

grabnode  # 1, default settings

conda create \
	-n Trinity_env \
	-c conda-forge \
		python=3.10 \
		mamba \
		parallel \
		zlib=1.2.13

source activate Trinity_env

# mamba search -c conda-forge xopen
mamba install -c xopen xopen=1.7.0

# mamba search -c bioconda cutadapt
mamba install -c bioconda cutadapt=4.2

#  Needed for rcorrector (zlib >=1.2.12,<1.3.0a0)
# mamba search -c bioconda rcorrector
mamba install -c bioconda rcorrector=1.0.5

mamba install \
	-c bioconda \
		star \
		fastqc \
		bedtools \
		rename \
		samtools

# mamba search -c bioconda trim-galore
mamba install -c bioconda trim-galore=0.6.7
# Wow, now mamba installation of trim-galore works

mamba install -c conda-forge ripgrep

mamba install -c bioconda fgbio

# mamba install -c conda-forge pybktree
#  Installed in an effort to get the below working; however, after installing
#+ it, it requested a 2.7-version of package python_abi, but this is a python
#+ 3.10 environment, so something like mamba install -c conda-forge
#+ python_abi=2.7 is not possible here; thus, decided to create a separate
#+ environment for umi_tools
#+
#+ Anyway, pbktree is now an "orphan package" in the environment and does not
#+ need to be included in the final build .yml for Trinity_env

mamba install -c bioconda multiqc

#  Needed for atria statplot
mamba install \
    -c conda-forge \
        r-tidyverse \
        r-argparse \
        r-plotly \
        r-ggsci

# ❯ atria statplot
# Rscript (R) version 4.2.0 (2022-04-22)
# Warning message:
# package ‘argparse’ was built under R version 4.2.2
# Warning messages:
# 1: package ‘plotly’ was built under R version 4.2.2
# 2: package ‘ggplot2’ was built under R version 4.2.2
# Warning message:
# package ‘ggsci’ was built under R version 4.2.1
# Error: package or namespace load failed for ‘tidyverse’ in dyn.load(file, DLLpath = DLLpath, ...):
#  unable to load shared object '/home/kalavatt/miniconda3/envs/Trinity_env/lib/R/library/haven/libs/haven.so':
#   /home/kalavatt/miniconda3/envs/Trinity_env/lib/R/library/haven/libs/haven.so: undefined symbol: libiconv
# In addition: Warning message:
# package ‘tidyverse’ was built under R version 4.2.1
# Execution halted

mamba install -c bioconda bbmap=39.01  # Dependency for downsample-fastqs.sh
```
</details>

- `#NOTE` The version of samtools installed is 1.3&mdash;it's quite old
- `#TODO` Check on the versions of the other installed `bioconda` packages
- `#NOTE` So there are obvious improvements that need to happen before finalizing a `.yml`
<br />
<br />

<a id="building-atria_env"></a>
## Building `atria_env`
<details>
<summary><i>Code: Building atria_env</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

conda create -n atria_env \
    -c conda-forge \
        r-tidyverse \
        r-argparse \
        r-plotly \
        r-ggsci \
        pbzip2 \
        pigz

conda install -c conda-forge parallel

# ❯ alias atria="\${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria"
# ❯ atria statplot --help
# Rscript (R) version 4.2.2 (2022-10-31)
# Failed to query server: Connection timed out
# ── Attaching packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.2 ──
# ✔ tibble  3.1.8     ✔ dplyr   1.1.0
# ✔ tidyr   1.3.0     ✔ stringr 1.5.0
# ✔ readr   2.1.3     ✔ forcats 1.0.0
# ✔ purrr   1.0.1
# ── Conflicts ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
# ✖ dplyr::filter() masks plotly::filter(), stats::filter()
# ✖ dplyr::lag()    masks stats::lag()
# Warning message:
# In system("timedatectl", intern = TRUE) :
#   running command 'timedatectl' had status 1
# usage: atria statplot [-h] [-i STAT.TSV [STAT.TSV ...]] [-o PREF]
#                       [-l DIR|DIR2|BASE|.] [-a INT] [-F]
#
# Trimming performance plots with stat.tsv files
#
# options:
#   -h, --help            show this help message and exit
#   -i STAT.TSV [STAT.TSV ...], --input STAT.TSV [STAT.TSV ...]
#                         input stat.tsv files; if auto, search files ended with
#                         r12.stat.tsv
#   -o PREF, --outpref PREF
#                         Prefix of output files (default: trimmer_accuracy)
#   -l DIR|DIR2|BASE|., --legend DIR|DIR2|BASE|.
#                         legend name: DIR = dir name, BASE = base name, DIR2 =
#                         second dir name (default: DIR)
#   -a INT, --adapter-length INT
#                         Main adapter length for stats
#   -F, --no-format       Stop formatting legend names (keep ^[A-Za-z]*, first
#                         uppercase)
```
`#TODO` Add an `alias` to `.bash_aliases` for quick loading of the env and the `alias`ed path to `atria` itself
</details>
<br />
<br />

<a id="install-atria-for-looking-into-adapters"></a>
## Install `atria` for looking into adapters
<a id="15"></a>
### 1/5
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Install atria for looking into adapters, 1/5: pbzip2</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  First, install dependency pbzip2 via mamba (dependency pigz is already
#+ installed)
mamba install -c conda-forge pbzip2
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Install atria for looking into adapters, 1/5: pbzip2</i></summary>

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

        mamba (0.15.3) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['pbzip2']

pkgs/main/noarch         [====================] (00m:00s) No change
pkgs/r/linux-64          [====================] (00m:00s) No change
pkgs/r/noarch            [====================] (00m:00s) No change
pkgs/main/linux-64       [====================] (00m:01s) Done
conda-forge/noarch       [====================] (00m:03s) Done
conda-forge/linux-64     [====================] (00m:08s) Done

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/Trinity_env

  Updating specs:

   - pbzip2
   - ca-certificates
   - certifi
   - openssl


  Package               Version  Build       Channel                    Size
──────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────

  + pbzip2               1.1.13  0           conda-forge/linux-64     114 KB

  Change:
──────────────────────────────────────────────────────────────────────────────

  - openssl              1.1.1s  h7f8727e_0  installed
  + openssl              1.1.1s  h0b41bf4_1  conda-forge/linux-64       2 MB

  Upgrade:
──────────────────────────────────────────────────────────────────────────────

  - ca-certificates  2022.10.11  h06a4308_0  installed
  + ca-certificates   2022.12.7  ha878542_0  conda-forge/linux-64     143 KB

  Summary:

  Install: 1 packages
  Change: 1 packages
  Upgrade: 1 packages

  Total download: 2 MB

──────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/N] Y
Finished pbzip2                               (00m:00s)             114 KB      2 MB/s
Finished ca-certificates                      (00m:00s)             143 KB      2 MB/s
Finished openssl                              (00m:00s)               2 MB     20 MB/s
Downloading  [====================================================================================================] (00m:01s)   15.53 MB/s
Extracting   [====================================================================================================] (00m:00s)        3 / 3
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
````
</details>
<br />

<a id="25"></a>
### 2/5
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Install atria for looking into adapters, 2/5: julia</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Next, install the language Julia
cd ~

wget "https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz"

tar zxvf julia-1.8.5-linux-x86_64.tar.gz

vi ~/.bashrc
#  export PATH=$PATH:$HOME/julia-1.8.1/bin

which julia
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Install atria for looking into adapters, 2/5: julia</i></summary>

```txt
❯ wget "https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz"
--2023-01-15 14:01:46--  https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz
Resolving julialang-s3.julialang.org (julialang-s3.julialang.org)... 151.101.42.49, 2a04:4e42:a::561
Connecting to julialang-s3.julialang.org (julialang-s3.julialang.org)|151.101.42.49|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 130873886 (125M) [application/x-tar]
Saving to: ‘julia-1.8.5-linux-x86_64.tar.gz’

julia-1.8.5-linux-x86_64.tar.gz                                        100%[===========================================================================================================================================================================>] 124.81M  6.11MB/s    in 14s

2023-01-15 14:02:00 (8.88 MB/s) - ‘julia-1.8.5-linux-x86_64.tar.gz’ saved [130873886/130873886]

❯ tar zxvf julia-1.8.5-linux-x86_64.tar.gz
...

❯ vi ~/.bashrc

❯ which julia
/home/kalavatt/julia-1.8.5/bin/julia
```
</details>
<br />

<a id="35"></a>
### 3/5
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Install atria for looking into adapters, 3/5: atria</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  cd into 2022_transcriptome-construction/
cd software/
git clone "https://github.com/cihga39871/Atria.git"

cd Atria/

julia build_atria.jl
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Install atria for looking into adapters, 3/5: atria</i></summary>

```txt
❯ git clone "https://github.com/cihga39871/Atria.git"
Cloning into 'Atria'...
remote: Enumerating objects: 713, done.
remote: Counting objects: 100% (232/232), done.
remote: Compressing objects: 100% (166/166), done.
remote: Total 713 (delta 138), reused 118 (delta 61), pack-reused 481
Receiving objects: 100% (713/713), 1.90 MiB | 18.57 MiB/s, done.
Resolving deltas: 100% (432/432), done.

❯ cd Atria/
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria

❯ julia build_atria.jl
pigz 2.6
  Activating project at `/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria`
  Installing known registries into `~/.julia`
Precompiling project...
  29 dependencies successfully precompiled in 7 seconds
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
  No Changes to `/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/Project.toml`
    Updating `/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/Manifest.toml`
  [a4e569a6] ↑ Tar v1.10.0 ⇒ v1.10.1
  [e66e0078] ↑ CompilerSupportLibraries_jll v0.5.2+0 ⇒ v1.0.1+0
✔ [02m:27s] PackageCompiler: compiling base system image (incremental=false)
Precompiling project...
  29 dependencies successfully precompiled in 66 seconds
[ Info: PackageCompiler: Executing /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/test/runtests.jl => /tmp/jl_packagecompiler_1fLA3M/jl_vbvKbV
@SRR7243169.1 1 length=301
ACCCAAGGCGTGCTCGTAGGATTTGTCGACATAGTCGATCAGACCTTCGTCCAGCGGCCAGGCGTTAACCTGACCTTCCCAATCGTCGATGATGGTGTTGCCGAAGCGGAACACTTCACTTTGCAGGTACGGCACGCGCGCGGCGACCCAGGCAGCCTTGGCGGCTTTCAGGGTCTCGGCGTTCGGCCTGTCTCTTATACACATCTCCGAGCCCACGAGCCGTAGAGGAATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAGACAAGCACTCTATACATCCGTCTCACCCGATACACTCC
+SRR7243169.1 1 length=301
CCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGDGGGGGGDGGGGGGGGCGGGGGGGGGGGGGGGGFGGGGGGFGGGGGGGGGGGGGGFGGGEDGG>GFFGGGGDGGGDGFGG7;)9C>DF3B4)76676:@DF?F?>D@F3=FFFF?=<6*600)07).)0.)818)))**0=***))0((.**)0))0.7*/62(
┌ Info: read simulation: output files
│   r1 = "peReadSimulated.R1.fastq"
└   r2 = "peReadSimulated.R2.fastq"
┌ Info: read simulation: all done
└   elapsed = 9.561089992523193
usage: trimmer_and_benchmark.jl [-o PREF] [-x REPEAT] [-a SEQ]
                        [-A SEQ] [-s SEQ-LENGTH]
                        [-i INSERT-SIZE-RANGE [INSERT-SIZE-RANGE...]]
                        [-S SUBSITUTION-RATE [SUBSITUTION-RATE...]]
                        [-I INSERTION-RATE [INSERTION-RATE...]]
                        [-D DELETION-RATE [DELETION-RATE...]] [-h]

optional arguments:
  -h, --help            show this help message and exit

output:
  -o, --prefix PREF     prefix of output fastq files (default:
                        "read_simulation")

simulation:
  -x, --repeat REPEAT   repeat times for each case (type: Int64,
                        default: 30000)
  -a, --adapter1 SEQ    read 1 adapter (default:
                        "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA")
  -A, --adapter2 SEQ    read 2 adapter (default:
                        "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT")
  -s, --seq-length SEQ-LENGTH
                        a given sequence length; simulated sequence
                        length might be 1 base more than the value
                        because of simulated phasing error (type:
                        Int64, default: 100)
  -i, --insert-size-range INSERT-SIZE-RANGE [INSERT-SIZE-RANGE...]
                        range of insert size (type: Int64, default:
                        [80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100,
                        102, 104, 106, 108, 110, 112, 114, 116, 118,
                        120])
  -S, --subsitution-rate SUBSITUTION-RATE [SUBSITUTION-RATE...]
                        subsitution rate per base. it is random for
                        each base. error type includs mismatch (type:
                        Float64, default: [0.001, 0.002, 0.003, 0.004,
                        0.005])
  -I, --insertion-rate INSERTION-RATE [INSERTION-RATE...]
                        insertion rate; number of arg should be the
                        same as --subsitution-rate (type: Float64,
                        default: [1.0e-5, 2.0e-5, 3.0e-5, 4.0e-5,
                        5.0e-5])
  -D, --deletion-rate DELETION-RATE [DELETION-RATE...]
                        deletion rate; number of arg should be the
                        same as --subsitution-rate (type: Float64,
                        default: [1.0e-5, 2.0e-5, 3.0e-5, 4.0e-5,
                        5.0e-5])

┌ Info: read random trim: start
│   file1 = "peReadSimulated.R1.fastq"
└   file2 = "peReadSimulated.R2.fastq"
┌ Info: read random trim: all done
└   elapsed = 1.5604071617126465
usage: atria randtrim [-h] R1_FASTQ R2_FASTQ

positional arguments:
  R?_FASTQ      input fastqs. caution: raw fastq has to be
                generated by `atria simulate`.

optional arguments:
  -h, --help  show this help message and exit

pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -R peReadSimulated.R2.randtrim.fastq.gz -c 8 --compress gz --check-identifier -f`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.gz"
└   read2 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R2.randtrim.atria.fastq.gz"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = true
[ Info: Cycle 1: read 210000/210000 pairs; wrote 88933/88933 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.gz"
└   read2 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R2.randtrim.atria.fastq.gz"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -c 8 --compress gz -f`
┌ Info: ATRIA OUTPUT FILES
└   read = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.gz"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   tail_polyG_trimming = false
│   tail_polyT_trimming = false
│   tail_polyA_trimming = false
│   tail_polyC_trimming = false
│   adapter_trimming = true
│   consensus_calling = false
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = true
└   complexity_filtering = false
[ Info: Cycle 1: read 210000/210000 pairs; wrote 149310/149310; (copied 0/0)
┌ Info: ATRIA COMPLETE
└   read = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.gz"
pigz 2.6
┌ Info: peReadSimulated.R1.randtrim.fastq.gz:
│  Top 5 adapters detected in the first 210000 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │     15501 │ 0.996069 │
│ │ AGATCGGAAGAGCTCG │     14791 │ 0.875123 │
│ │ GATCGGAAGAGCACAC │     10285 │ 0.935069 │
│ │ AGATCGGAAGAGCGGT │        52 │    0.875 │
│ │ AGATCGGAAGAGCGTC │        45 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -R peReadSimulated.R2.randtrim.fastq.gz -c 8 --compress bz2 --check-identifier -f`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.bz2"
└   read2 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R2.randtrim.atria.fastq.bz2"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = true
[ Info: Cycle 1: read 210000/210000 pairs; wrote 88933/88933 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.bz2"
└   read2 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R2.randtrim.atria.fastq.bz2"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.randtrim.fastq.gz -c 8 --compress bz2 -f`
┌ Info: ATRIA OUTPUT FILES
└   read = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.bz2"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   tail_polyG_trimming = false
│   tail_polyT_trimming = false
│   tail_polyA_trimming = false
│   tail_polyC_trimming = false
│   adapter_trimming = true
│   consensus_calling = false
│   hard_clip_3_end = false
│   hard_clip_5_end = true
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = true
└   complexity_filtering = false
[ Info: Cycle 1: read 210000/210000 pairs; wrote 149310/149310; (copied 0/0)
┌ Info: ATRIA COMPLETE
└   read = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.randtrim.atria.fastq.bz2"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.fastq -R peReadSimulated.R2.fastq --polyG --enable-complexity-filtration -f`
┌ Info: ATRIA OUTPUT FILES
│   read1 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.atria.fastq"
└   read2 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R2.atria.fastq"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   adapter_trimming = true
│   consensus_calling = true
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
└   length_filtering = true
[ Info: Cycle 1: read 188282/188282 pairs; wrote 188282/188282 pairs; (copied 0/0 reads)
[ Info: Cycle 2: read 21718/210000 pairs; wrote 21718/210000 pairs; (copied 0/0 reads)
┌ Info: ATRIA COMPLETE
│   read1 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.atria.fastq"
└   read2 = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R2.atria.fastq"
pigz 2.6
┌ Info: ATRIA VERSIONS
│   atria = "v3.2.1"
└   julia = "v1.8.5"
┌ Info: ATRIA ARGUMENTS
└   command = `-r peReadSimulated.R1.fastq --polyG --enable-complexity-filtration -f`
┌ Info: ATRIA OUTPUT FILES
└   read = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.atria.fastq"
┌ Info: ATRIA TRIMMERS AND FILTERS
│   tail_polyG_trimming = true
│   tail_polyT_trimming = false
│   tail_polyA_trimming = false
│   tail_polyC_trimming = false
│   adapter_trimming = true
│   consensus_calling = false
│   hard_clip_3_end = false
│   hard_clip_5_end = false
│   quality_trimming = true
│   tail_N_trimming = true
│   max_N_filtering = true
│   length_filtering = true
└   complexity_filtering = true
[ Info: Cycle 1: read 188282/188282 pairs; wrote 188279/188279; (copied 0/0)
[ Info: Cycle 2: read 21718/210000 pairs; wrote 21716/209995; (copied 0/0)
┌ Info: ATRIA COMPLETE
└   read = "/tmp/jl_Fy9Mxermx8/peReadSimulated.R1.atria.fastq"
pigz 2.6
[ Warning: Skip completed analysis: /tmp/jl_Fy9Mxermx8/peReadSimulated.R1.atria.log.json (use --force to disable the feature)
pigz 2.6
[ Warning: Skip completed analysis: /tmp/jl_Fy9Mxermx8/peReadSimulated.R1.atria.log.json (use --force to disable the feature)
pigz 2.6
┌ Info: peReadSimulated.R1.fastq:
│  Top 5 adapters detected in the first 188282 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │     29959 │ 0.996693 │
│ │ AGATCGGAAGAGCTCG │     28611 │ 0.875129 │
│ │ GATCGGAAGAGCACAC │     19989 │ 0.935171 │
│ │ AGATCGGAAGAGCGGT │        99 │    0.875 │
│ │ AGATCGGAAGAGCGTC │        92 │ 0.875679 │
└ └──────────────────┴───────────┴──────────┘
usage: atria [-t INT] [--log2-chunk-size INDEX] [-f]
             -r R1-FASTQ [R1-FASTQ...] [-R [R2-FASTQ...]] [-o PATH]
             [-g AUTO|NO|GZ|GZIP|BZ2|BZIP2] [--check-identifier]
             [--detect-adapter] [--polyG] [--polyT] [--polyA]
             [--polyC] [--poly-length POLY-LENGTH]
             [--poly-mismatch-per-16mer INT] [--no-adapter-trim]
             [-a SEQ] [-A SEQ] [-T INT] [-d INT] [-D INT] [-s INT]
             [--trim-score-pe FLOAT] [--trim-score-se FLOAT] [-l INT]
             [--stats] [--no-consensus]
             [--kmer-tolerance-consensus INT]
             [--min-ratio-mismatch FLOAT] [--overlap-score FLOAT]
             [--prob-diff FLOAT] [-C INT] [-c INT] [--no-quality-trim]
             [-q INT] [--quality-kmer INT] [--quality-format FORMAT]
             [--no-tail-n-trim] [-n INT] [--no-length-filtration]
             [--length-range INT:INT] [--enable-complexity-filtration]
             [--min-complexity FLOAT] [-p INT] [--version] [-h]

Atria v3.2.1

optional arguments:
  -t, --threads INT     use INT threads to process one sample
                        (multi-threading parallel). (type: Int64,
                        default: 1)
  --log2-chunk-size INDEX
                        read at most 2^INDEX bits each time. Suggest
                        to process 200,000 reads each time. Reduce
                        INDEX to lower the memory usage. (type: Int64,
                        default: 26)
  -f, --force           force to analyze all samples; not skip
                        completed ones
  --version             show version information and exit
  -h, --help            show this help message and exit

input/output: input read 1 and read 2 should be in the same order:
  -r, --read1 R1-FASTQ [R1-FASTQ...]
                        input read 1 fastq file(s), or single-end
                        fastq files
  -R, --read2 [R2-FASTQ...]
                        input read 2 fastq file(s) (paired with
                        R1-FASTQ)
  -o, --output-dir PATH
                        store output files and stats to PATH (default:
                        "/tmp/jl_Fy9Mxermx8")
  -g, --compress AUTO|NO|GZ|GZIP|BZ2|BZIP2
                        compression methods for output files (AUTO:
                        same as input, NO: no compression, GZ|GZIP:
                        gzip with `pigz`, BZ2|BZIP2: bzip2 with
                        `pbzip2`) (default: "AUTO")
  --check-identifier    check whether the identifiers of r1 and r2 are
                        the same
  --detect-adapter      detect possible adapters for each sample only

poly X tail trimming:
  --polyG               enable trimming poly G tails
  --polyT               enable trimming poly T tails
  --polyA               enable trimming poly A tails
  --polyC               enable trimming poly C tails
  --poly-length POLY-LENGTH
                        the minimum length of poly X (type: Int64,
                        default: 10)
  --poly-mismatch-per-16mer INT
                        the number of mismatch allowed in 16 mer poly
                        X (type: Int64, default: 2)

adapter trimming (after polyX trimming):
  --no-adapter-trim     disable adapter and pair-end trimming
  -a, --adapter1 SEQ    read 1 adapter (default:
                        "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA")
  -A, --adapter2 SEQ    read 2 adapter (default:
                        "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT")
  -T, --kmer-tolerance INT
                        # of mismatch allowed in 16-mers adapter and
                        pair-end matching (type: Int64, default: 2)
  -d, --pe-adapter-diff INT
                        (FOR PAIRED END) number of bases allowed when
                        disconcordance found between adapter and
                        pair-end search (type: Int64, default: 0)
  -D, --r1-r2-diff INT  (FOR PAIRED END) number of bases allowed when
                        the insert sizes of r1 and r2 are different
                        (type: Int64, default: 0)
  -s, --kmer-n-match INT
                        (FOR PAIRED END) if n base matched [0-16] is
                        less than INT, loosen matches will be made
                        based on the match with the highest n base
                        match (type: Int64, default: 9)
  --trim-score-pe FLOAT
                        (FOR PAIRED END) if final score [0-32] of read
                        pair is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  --trim-score-se FLOAT
                        (FOR SINGLE END) if final score [0-16] of read
                        is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  -l, --tail-length INT
                        (FOR PAIRED END) if the adapter is in the tail
                        region, and insert size of pe match is smaller
                        than this region, do not trim the read. (type:
                        Int64, default: 12)
  --stats               (DEV ONLY) write stats to description lines of
                        r2 reads.

consensus/merging in adapter trimming (FOR PAIRED END):
  --no-consensus        disable generating consensus paired reads. If
                        adapter trimming is disabled, consensus
                        calling is not performed even the flag is not
                        set.
  --kmer-tolerance-consensus INT
                        # of mismatch allowed in 16-mers matching in
                        consensus calling (type: Int64, default: 10)
  --min-ratio-mismatch FLOAT
                        if the ratio of mismatch of the overlapped
                        region is less than FLOAT, skip consensus
                        calling. (type: Float64, default: 0.28)
  --overlap-score FLOAT
                        if no adapter was found, scan the tails of the
                        paired reads. Then, if the maximum score of
                        the overlapped 16-mers are less than FLOAT,
                        skip consensus calling for the read pair. If
                        adapters were found, this step is ignored.
                        (type: Float64, default: 0.0)
  --prob-diff FLOAT     when doing consensus calling, if the bases
                        were not complementary, the base with the
                        higher quality probability is selected unless
                        the quality probability difference are less
                        than FLOAT (type: Float64, default: 0.0)

hard clipping: trim a fixed length (after adapter trimming):
  -C, --clip-after INT  hard clip the 3' tails to contain only INT
                        bases. 0 to disable. (type: Int64, default: 0)
  -c, --clip5 INT       remove the first INT bases from 5' end. (type:
                        Int64, default: 0)

quality trimming: trim the tail when the average quality of bases in
a sliding window is low (after hard clipping):
  --no-quality-trim     skip quality trimming
  -q, --quality-score INT
                        threshold of quality score; 0 means turn off
                        quality trimming (type: Int64, default: 20)
  --quality-kmer INT    trim the tail once found the average quality
                        of bases in a sliding window is low (type:
                        Int64, default: 5)
  --quality-format FORMAT
                        the format of the quality score (Illumina1.3,
                        Illumina1.8, Sanger, Illumina1.5, Solexa); or
                        the ASCII number when quality score == 0
                        (default: "33")

N trimming (after quality trimming):
  --no-tail-n-trim      disable removing NNNNN tail.
  -n, --max-n INT       # N allowed in each read; N tails not included
                        if --no-tail-n-trim; INT<0 to disable (type:
                        Int64, default: 15)

length filtration (after N trimming):
  --no-length-filtration
                        disable length filtration
  --length-range INT:INT
                        length range of good reads; format is min:max
                        (default: "50:500")

read complexity filtration (after length filtration):
  --enable-complexity-filtration
                        enable complexity filtration
  --min-complexity FLOAT
                        complexity threshold (type: Float64, default:
                        0.3)

legacy arguments:
  -p, --procs INT       ignored (multi-proc is disabled) (default:
                        "1")

Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li,
Atria: an ultra-fast and accurate trimmer for adapter and quality
trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

usage: atria [-t INT] [--log2-chunk-size INDEX] [-f]
             -r R1-FASTQ [R1-FASTQ...] [-R [R2-FASTQ...]] [-o PATH]
             [-g AUTO|NO|GZ|GZIP|BZ2|BZIP2] [--check-identifier]
             [--detect-adapter] [--polyG] [--polyT] [--polyA]
             [--polyC] [--poly-length POLY-LENGTH]
             [--poly-mismatch-per-16mer INT] [--no-adapter-trim]
             [-a SEQ] [-A SEQ] [-T INT] [-d INT] [-D INT] [-s INT]
             [--trim-score-pe FLOAT] [--trim-score-se FLOAT] [-l INT]
             [--stats] [--no-consensus]
             [--kmer-tolerance-consensus INT]
             [--min-ratio-mismatch FLOAT] [--overlap-score FLOAT]
             [--prob-diff FLOAT] [-C INT] [-c INT] [--no-quality-trim]
             [-q INT] [--quality-kmer INT] [--quality-format FORMAT]
             [--no-tail-n-trim] [-n INT] [--no-length-filtration]
             [--length-range INT:INT] [--enable-complexity-filtration]
             [--min-complexity FLOAT] [-p INT] [--version] [-h]

Atria v3.2.1

optional arguments:
  -t, --threads INT     use INT threads to process one sample
                        (multi-threading parallel). (type: Int64,
                        default: 1)
  --log2-chunk-size INDEX
                        read at most 2^INDEX bits each time. Suggest
                        to process 200,000 reads each time. Reduce
                        INDEX to lower the memory usage. (type: Int64,
                        default: 26)
  -f, --force           force to analyze all samples; not skip
                        completed ones
  --version             show version information and exit
  -h, --help            show this help message and exit

input/output: input read 1 and read 2 should be in the same order:
  -r, --read1 R1-FASTQ [R1-FASTQ...]
                        input read 1 fastq file(s), or single-end
                        fastq files
  -R, --read2 [R2-FASTQ...]
                        input read 2 fastq file(s) (paired with
                        R1-FASTQ)
  -o, --output-dir PATH
                        store output files and stats to PATH (default:
                        "/tmp/jl_Fy9Mxermx8")
  -g, --compress AUTO|NO|GZ|GZIP|BZ2|BZIP2
                        compression methods for output files (AUTO:
                        same as input, NO: no compression, GZ|GZIP:
                        gzip with `pigz`, BZ2|BZIP2: bzip2 with
                        `pbzip2`) (default: "AUTO")
  --check-identifier    check whether the identifiers of r1 and r2 are
                        the same
  --detect-adapter      detect possible adapters for each sample only

poly X tail trimming:
  --polyG               enable trimming poly G tails
  --polyT               enable trimming poly T tails
  --polyA               enable trimming poly A tails
  --polyC               enable trimming poly C tails
  --poly-length POLY-LENGTH
                        the minimum length of poly X (type: Int64,
                        default: 10)
  --poly-mismatch-per-16mer INT
                        the number of mismatch allowed in 16 mer poly
                        X (type: Int64, default: 2)

adapter trimming (after polyX trimming):
  --no-adapter-trim     disable adapter and pair-end trimming
  -a, --adapter1 SEQ    read 1 adapter (default:
                        "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA")
  -A, --adapter2 SEQ    read 2 adapter (default:
                        "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT")
  -T, --kmer-tolerance INT
                        # of mismatch allowed in 16-mers adapter and
                        pair-end matching (type: Int64, default: 2)
  -d, --pe-adapter-diff INT
                        (FOR PAIRED END) number of bases allowed when
                        disconcordance found between adapter and
                        pair-end search (type: Int64, default: 0)
  -D, --r1-r2-diff INT  (FOR PAIRED END) number of bases allowed when
                        the insert sizes of r1 and r2 are different
                        (type: Int64, default: 0)
  -s, --kmer-n-match INT
                        (FOR PAIRED END) if n base matched [0-16] is
                        less than INT, loosen matches will be made
                        based on the match with the highest n base
                        match (type: Int64, default: 9)
  --trim-score-pe FLOAT
                        (FOR PAIRED END) if final score [0-32] of read
                        pair is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  --trim-score-se FLOAT
                        (FOR SINGLE END) if final score [0-16] of read
                        is greater than FLOAT, the reads will be
                        trimmed. (type: Float64, default: 10.0)
  -l, --tail-length INT
                        (FOR PAIRED END) if the adapter is in the tail
                        region, and insert size of pe match is smaller
                        than this region, do not trim the read. (type:
                        Int64, default: 12)
  --stats               (DEV ONLY) write stats to description lines of
                        r2 reads.

consensus/merging in adapter trimming (FOR PAIRED END):
  --no-consensus        disable generating consensus paired reads. If
                        adapter trimming is disabled, consensus
                        calling is not performed even the flag is not
                        set.
  --kmer-tolerance-consensus INT
                        # of mismatch allowed in 16-mers matching in
                        consensus calling (type: Int64, default: 10)
  --min-ratio-mismatch FLOAT
                        if the ratio of mismatch of the overlapped
                        region is less than FLOAT, skip consensus
                        calling. (type: Float64, default: 0.28)
  --overlap-score FLOAT
                        if no adapter was found, scan the tails of the
                        paired reads. Then, if the maximum score of
                        the overlapped 16-mers are less than FLOAT,
                        skip consensus calling for the read pair. If
                        adapters were found, this step is ignored.
                        (type: Float64, default: 0.0)
  --prob-diff FLOAT     when doing consensus calling, if the bases
                        were not complementary, the base with the
                        higher quality probability is selected unless
                        the quality probability difference are less
                        than FLOAT (type: Float64, default: 0.0)

hard clipping: trim a fixed length (after adapter trimming):
  -C, --clip-after INT  hard clip the 3' tails to contain only INT
                        bases. 0 to disable. (type: Int64, default: 0)
  -c, --clip5 INT       remove the first INT bases from 5' end. (type:
                        Int64, default: 0)

quality trimming: trim the tail when the average quality of bases in
a sliding window is low (after hard clipping):
  --no-quality-trim     skip quality trimming
  -q, --quality-score INT
                        threshold of quality score; 0 means turn off
                        quality trimming (type: Int64, default: 20)
  --quality-kmer INT    trim the tail once found the average quality
                        of bases in a sliding window is low (type:
                        Int64, default: 5)
  --quality-format FORMAT
                        the format of the quality score (Illumina1.3,
                        Illumina1.8, Sanger, Illumina1.5, Solexa); or
                        the ASCII number when quality score == 0
                        (default: "33")

N trimming (after quality trimming):
  --no-tail-n-trim      disable removing NNNNN tail.
  -n, --max-n INT       # N allowed in each read; N tails not included
                        if --no-tail-n-trim; INT<0 to disable (type:
                        Int64, default: 15)

length filtration (after N trimming):
  --no-length-filtration
                        disable length filtration
  --length-range INT:INT
                        length range of good reads; format is min:max
                        (default: "50:500")

read complexity filtration (after length filtration):
  --enable-complexity-filtration
                        enable complexity filtration
  --min-complexity FLOAT
                        complexity threshold (type: Float64, default:
                        0.3)

legacy arguments:
  -p, --procs INT       ignored (multi-proc is disabled) (default:
                        "1")

Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li,
Atria: an ultra-fast and accurate trimmer for adapter and quality
trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

┌ Info: read simulation stats: start
└   input = "peReadSimulated.R1.atria.fastq.r12"
┌ Info: read simulation stats: output
│   detail = "peReadSimulated.R1.atria.fastq.r12.stat-detail.tsv"
└   summary = "peReadSimulated.R1.atria.fastq.r12.stat.tsv"
┌ Info: read simulation stats: all done
└   elapsed = 3.014359951019287
usage: atria readstat [-h] FASTQS...

positional arguments:
  FASTQS      input trimmed fastqs. caution: raw fastq has to be
              generated by `atria simulate`. If multiple, two by two are considered paired.

optional arguments:
  -h, --help  show this help message and exit

[ Error: Rscript not found in PATH. Please install R and export Rscript to PATH.

  Atria v3.2.1
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡

  An ultra-fast and accurate adapter and quality trimming software designed for paired-end sequencing data.

  If you use Atria, please cite

  │  Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li, Atria: an ultra-fast and accurate trimmer for adapter and quality trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

  Github: https://github.com/cihga39871/Atria

  Usage
  =======

  Try atria -h or atria --help for more information.

  Input and Output
  ––––––––––––––––––

  The input files should be paired-end FastQ(.gz|.bz2) files (in the same order), or single-end fastqs:

    1. Read 1 files: -r X_R1.FQ Y_R1.FQ.GZ ...

    2. Read 2 files (optional): -R X_R2.FQ Y_R2.FQ.GZ ...

  Output all files to a directory: -o PATH or --output-dir PATH. Default is the current directory.

  Atria skips completed analysis by default. Use -f or --force to disable the feature.

  Trimming methods
  ––––––––––––––––––

  Atria integrated several trimming and read filtration methods. It does the following sequentially.

    1. Poly X Tail Trimming: remove remove poly-X tails.
       suggest to enable --polyG for Illumina NextSeq/NovaSeq data.
       • enable: --polyG, --polyT, --polyA, and/or --polyC (default: disabled)
       • trim poly X tail if length > INT: --poly-length 10

    2. Adapter Trimming
       • specify read 1 adapter: -a SEQ or --adapter1 SEQ (default: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA)
       • specify read 2 adapter: -A SEQ or --adapter2 SEQ (default: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT) (if paired-end)
       • disable: --no-adapter-trim
       • if adapter is unknown, use --detect-adapter.

    3. Paired-end Consensus Calling: the overlapped regions of read pairs are checked and corrected. It is available only when input files are paired-end and Adapter Trimming is on.
       • disable: --no-consensus

    4. Hard Clip 3' end: resize reads to a fixed length by discarding extra bases in 3' end.
       • specify the number of bases to keep: -C INT or --clip-after INT (default: disabled)

    5. Hard Clip 5' end: remove the first INT bases from 5' end.
       • specify the number of bases to remove: -c INT or --clip5 INT (default: disabled)

    6. Quality Trimming: trim low-quality tails. (Trimming read tails when the average quality of bases in a sliding window is low.)
       • specify average quality threshold: -q 20 or --quality-score 20 (default: 20)
       • specify sliding window length: --quality-kmer 5 (default: 5)
       • specify FastQ quality format: --quality-format Illumina1.8, or --quality-format 33 (default: 33, ie. Illumina1.8)
       • disable: --no-quality-trim

    7. Tail N Trimming: trim N tails.
       • disable: --no-tail-n-trim

    8. N Filtration: discard a read pair if the number of N in one read is greater than a certain amount. N tails are ignored if Tail N Trimming is on.
       • specify # N allowed in each read: -n 15 or --max-n 15 (default: 15)
       • disable: -n -1 or --max-n -1

    9. Read Length Filtration: filter read pair length in a range.
       • specify read length range: --length-range 50:500 (default: 50:500)
       • disable: --no-length-filtration

    10. Read Complexity Filtration: filter reads with low complexity.
       Complexity is the percentage of base that is different from its next base.
       • enable: --enable-complexity-filtration (default: disabled)
       • specify complexity threshold: --min-complexity 0.3 (default: 0.3)

  Parallel (multi-threading) computing
  ––––––––––––––––––––––––––––––––––––––

    1. Specify number of threads to use: -t 8 or --threads 8. (Default: 8)

    2. If memory is not sufficient, use --log2-chunk-size INT where INT is from 23 to 25. Memory usage reduces exponentially as it decreases.
Available programs:
    atria       Pair-end trimming software (default)
    simulate    Generate artificial pair-end reads
    randtrim    Randomly trim R1 or R2 at a random position
    readstat    Collect trimming statistics
                    (reads should be generated by `atria simulate`)
    statplot    Plot trimming statistics
                    (`Rscript` in PATH required)
    test        Test Atria program
    p | prog    Show this program list

[ Info: Precompiling/test passed without errors.
Test Summary: | Pass  Total     Time
Atria         |   96     96  1m38.7s
[ Info: PackageCompiler: Done
✔ [05m:03s] PackageCompiler: compiling nonincremental system image
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libatomic.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libatomic.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so.6: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libstdc++.so.6: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010001
/usr/bin/ld: warning: /home/kalavatt/julia-1.8.5/lib/julia/libgcc_s.so.1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0010002
[ Info: Success. Atria is installed at ./app-3.2.1/bin/atria
pigz 2.6
```
</details>
<br />

<a id="45"></a>
### 4/5
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Install atria for looking into adapters, 4/5: R, Rscript, Tidyverse, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  When installing atria, encountered the following error:
#+ 'Error: Rscript not found in PATH. Please install R and export Rscript to PATH.'
#+ 
#+ Therefore, install R, Rscript, Tidyverse, etc.
mamba install -c conda-forge r-tidyverse
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: Install atria for looking into adapters, 4/5: R, Rscript, Tidyverse, etc.</i></summary>

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

        mamba (0.15.3) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-tidyverse']

conda-forge/linux-64     [====================] (00m:00s) No change
pkgs/main/linux-64       [====================] (00m:00s) No change
pkgs/main/noarch         [====================] (00m:00s) No change
pkgs/r/linux-64          [====================] (00m:00s) No change
pkgs/r/noarch            [====================] (00m:00s) No change
conda-forge/noarch       [====================] (00m:02s) Done

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/Trinity_env

  Updating specs:

   - r-tidyverse
   - ca-certificates
   - certifi
   - openssl


  Package                      Version  Build                Channel                     Size
───────────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                     1.0.1  anacondar_1          conda-forge/noarch          3 KB
  + binutils_impl_linux-64        2.38  h2a08ee3_1           pkgs/main/linux-64          5 MB
  + binutils_linux-64           2.38.0  hc2dff05_0           pkgs/main/linux-64         24 KB
  + bwidget                     1.9.14  ha770c72_1           conda-forge/linux-64      120 KB
  + cairo                       1.16.0  h19f5f5c_2           pkgs/main/linux-64        Cached
  + curl                        7.85.0  h5eee18b_0           pkgs/main/linux-64        Cached
  + font-ttf-inconsolata         3.000  h77eed37_0           conda-forge/noarch         94 KB
  + font-ttf-source-code-pro     2.038  h77eed37_0           conda-forge/noarch        684 KB
  + font-ttf-ubuntu               0.83  hab24e00_0           conda-forge/noarch          2 MB
  + fonts-conda-ecosystem            1  0                    conda-forge/noarch          4 KB
  + fonts-conda-forge                1  0                    conda-forge/noarch          4 KB
  + fribidi                     1.0.10  h36c2ea0_0           conda-forge/linux-64      112 KB
  + gcc_impl_linux-64           11.2.0  h1234567_1           pkgs/main/linux-64         22 MB
  + gcc_linux-64                11.2.0  h5c386dc_0           pkgs/main/linux-64         25 KB
  + gfortran_impl_linux-64      11.2.0  h7a446d4_16          conda-forge/linux-64       15 MB
  + gfortran_linux-64           11.2.0  hc2dff05_0           pkgs/main/linux-64         24 KB
  + graphite2                   1.3.14  h295c915_1           pkgs/main/linux-64        Cached
  + gxx_impl_linux-64           11.2.0  h1234567_1           pkgs/main/linux-64         11 MB
  + gxx_linux-64                11.2.0  hc2dff05_0           pkgs/main/linux-64         24 KB
  + harfbuzz                     3.1.2  h6b1f951_0           pkgs/main/linux-64          1 MB
  + kernel-headers_linux-64     2.6.32  he073ed8_15          conda-forge/noarch        707 KB
  + libblas                      3.9.0  16_linux64_openblas  conda-forge/linux-64       13 KB
  + libcblas                     3.9.0  16_linux64_openblas  conda-forge/linux-64       13 KB
  + libgcc-devel_linux-64       11.2.0  h1234567_1           pkgs/main/linux-64          3 MB
  + liblapack                    3.9.0  16_linux64_openblas  conda-forge/linux-64       13 KB
  + libopenblas                 0.3.21  pthreads_h78a6416_3  conda-forge/linux-64       10 MB
  + libstdcxx-devel_linux-64    11.2.0  h1234567_1           pkgs/main/linux-64         15 MB
  + make                           4.3  hd18ef5c_1           conda-forge/linux-64      507 KB
  + openblas                    0.3.21  pthreads_h320a7e8_3  conda-forge/linux-64       11 MB
  + pango                      1.48.10  h54213e6_2           conda-forge/linux-64      403 KB
  + pcre2                        10.37  hc3806b6_1           conda-forge/linux-64        1 MB
  + pixman                      0.40.0  h36c2ea0_0           conda-forge/linux-64      627 KB
  + r-askpass                      1.1  r42h06615bd_3        conda-forge/linux-64       29 KB
  + r-assertthat                 0.2.1  r42hc72bb7e_3        conda-forge/noarch         71 KB
  + r-backports                  1.4.1  r42h06615bd_1        conda-forge/linux-64      111 KB
  + r-base                       4.2.0  h1ae530e_0           pkgs/r/linux-64            26 MB
  + r-base64enc                  0.1_3  r42h06615bd_1005     conda-forge/linux-64       44 KB
  + r-bit                        4.0.5  r42h06615bd_0        conda-forge/linux-64        1 MB
  + r-bit64                      4.0.5  r42h06615bd_1        conda-forge/linux-64      508 KB
  + r-blob                       1.2.3  r42hc72bb7e_1        conda-forge/noarch         65 KB
  + r-broom                      1.0.2  r42hc72bb7e_0        conda-forge/noarch          2 MB
  + r-bslib                      0.4.1  r42hc72bb7e_0        conda-forge/noarch          4 MB
  + r-cachem                     1.0.6  r42h06615bd_1        conda-forge/linux-64       73 KB
  + r-callr                      3.7.3  r42hc72bb7e_0        conda-forge/noarch        429 KB
  + r-cellranger                 1.1.0  r42hc72bb7e_1005     conda-forge/noarch        110 KB
  + r-cli                        3.3.0  r42h884c59f_0        pkgs/r/linux-64             1 MB
  + r-clipr                      0.8.0  r42hc72bb7e_1        conda-forge/noarch         68 KB
  + r-colorspace                 2.0_3  r42h06615bd_1        conda-forge/linux-64        3 MB
  + r-cpp11                      0.4.3  r42hc72bb7e_0        conda-forge/noarch        236 KB
  + r-crayon                     1.5.2  r42hc72bb7e_1        conda-forge/noarch        168 KB
  + r-curl                       4.3.3  r42h06615bd_1        conda-forge/linux-64      692 KB
  + r-data.table                1.14.6  r42h06615bd_0        conda-forge/linux-64        2 MB
  + r-dbi                        1.1.3  r42hc72bb7e_1        conda-forge/noarch        771 KB
  + r-dbplyr                     2.2.1  r42hc72bb7e_1        conda-forge/noarch       1005 KB
  + r-digest                    0.6.29  r42h884c59f_0        pkgs/r/linux-64           185 KB
  + r-dplyr                      1.0.9  r42h884c59f_0        pkgs/r/linux-64             1 MB
  + r-dtplyr                     1.2.2  r42hc72bb7e_2        conda-forge/noarch        324 KB
  + r-ellipsis                   0.3.2  r42h06615bd_1        conda-forge/linux-64       42 KB
  + r-evaluate                    0.19  r42hc72bb7e_0        conda-forge/noarch         85 KB
  + r-fansi                      1.0.3  r42h06615bd_1        conda-forge/linux-64      323 KB
  + r-farver                     2.1.0  r42h884c59f_0        pkgs/r/linux-64             1 MB
  + r-fastmap                    1.1.0  r42h884c59f_0        pkgs/r/linux-64            64 KB
  + r-forcats                    0.5.2  r42hc72bb7e_1        conda-forge/noarch        390 KB
  + r-fs                         1.5.2  r42h884c59f_0        pkgs/r/linux-64           468 KB
  + r-gargle                     1.2.1  r42hc72bb7e_1        conda-forge/noarch        484 KB
  + r-generics                   0.1.3  r42hc72bb7e_1        conda-forge/noarch         92 KB
  + r-ggplot2                    3.4.0  r42hc72bb7e_0        conda-forge/noarch          4 MB
  + r-glue                       1.6.2  r42h06615bd_1        conda-forge/linux-64      154 KB
  + r-googledrive                2.0.0  r42hc72bb7e_1        conda-forge/noarch          2 MB
  + r-googlesheets4              1.0.1  r42h785f33e_1        conda-forge/noarch        498 KB
  + r-gtable                     0.3.1  r42hc72bb7e_1        conda-forge/noarch        174 KB
  + r-haven                      2.5.0  r42h884c59f_0        pkgs/r/linux-64           363 KB
  + r-highr                       0.10  r42hc72bb7e_0        conda-forge/noarch         56 KB
  + r-hms                        1.1.2  r42hc72bb7e_1        conda-forge/noarch        107 KB
  + r-htmltools                  0.5.2  r42h76d94ec_0        pkgs/r/linux-64           333 KB
  + r-httr                       1.4.4  r42hc72bb7e_1        conda-forge/noarch        497 KB
  + r-ids                        1.0.1  r42hc72bb7e_2        conda-forge/noarch        127 KB
  + r-isoband                    0.2.5  r42h884c59f_0        pkgs/r/linux-64             2 MB
  + r-jquerylib                  0.1.4  r42hc72bb7e_1        conda-forge/noarch        370 KB
  + r-jsonlite                   1.8.4  r42h133d619_0        conda-forge/linux-64      619 KB
  + r-knitr                       1.41  r42hc72bb7e_0        conda-forge/noarch          1 MB
  + r-labeling                   0.4.2  r42hc72bb7e_2        conda-forge/noarch         68 KB
  + r-lattice                  0.20_45  r42h06615bd_1        conda-forge/linux-64        1 MB
  + r-lifecycle                  1.0.1  r42h142f84f_0        pkgs/r/noarch             102 KB
  + r-lubridate                  1.8.0  r42h884c59f_0        pkgs/r/linux-64           994 KB
  + r-magrittr                   2.0.3  r42h06615bd_1        conda-forge/linux-64      216 KB
  + r-mass                    7.3_58.1  r42h06615bd_1        conda-forge/linux-64        1 MB
  + r-matrix                     1.5_3  r42h5f7b363_0        conda-forge/linux-64        4 MB
  + r-memoise                    2.0.1  r42hc72bb7e_1        conda-forge/noarch         58 KB
  + r-mgcv                      1.8_41  r42h5f7b363_0        conda-forge/linux-64        3 MB
  + r-mime                        0.12  r42h06615bd_1        conda-forge/linux-64       52 KB
  + r-modelr                    0.1.10  r42hc72bb7e_0        conda-forge/noarch        220 KB
  + r-munsell                    0.5.0  r42hc72bb7e_1005     conda-forge/noarch        248 KB
  + r-nlme                     3.1_160  r42h8da6f51_0        conda-forge/linux-64        2 MB
  + r-openssl                    2.0.5  r42hb1dc35e_0        conda-forge/linux-64      620 KB
  + r-pillar                     1.8.1  r42hc72bb7e_1        conda-forge/noarch        677 KB
  + r-pkgconfig                  2.0.3  r42hc72bb7e_2        conda-forge/noarch         26 KB
  + r-prettyunits                1.1.1  r42hc72bb7e_2        conda-forge/noarch         42 KB
  + r-processx                   3.8.0  r42h06615bd_0        conda-forge/linux-64      332 KB
  + r-progress                   1.2.2  r42hc72bb7e_3        conda-forge/noarch         92 KB
  + r-ps                         1.7.2  r42h06615bd_0        conda-forge/linux-64      323 KB
  + r-purrr                      0.3.5  r42h06615bd_1        conda-forge/linux-64      414 KB
  + r-r6                         2.5.1  r42hc72bb7e_1        conda-forge/noarch         90 KB
  + r-rappdirs                   0.3.3  r42h06615bd_1        conda-forge/linux-64       52 KB
  + r-rcolorbrewer               1.1_3  r42h785f33e_1        conda-forge/noarch         65 KB
  + r-readr                      2.1.2  r42h884c59f_0        pkgs/r/linux-64           808 KB
  + r-readxl                     1.4.0  r42h884c59f_0        pkgs/r/linux-64           742 KB
  + r-rematch                    1.0.1  r42hc72bb7e_1005     conda-forge/noarch         20 KB
  + r-rematch2                   2.1.2  r42hc72bb7e_2        conda-forge/noarch         54 KB
  + r-reprex                     2.0.2  r42hc72bb7e_1        conda-forge/noarch        499 KB
  + r-rlang                      1.0.2  r42h884c59f_0        pkgs/r/linux-64             1 MB
  + r-rmarkdown                   2.19  r42hc72bb7e_0        conda-forge/noarch          3 MB
  + r-rstudioapi                  0.14  r42hc72bb7e_1        conda-forge/noarch        301 KB
  + r-rvest                      1.0.3  r42hc72bb7e_1        conda-forge/noarch        216 KB
  + r-sass                       0.4.1  r42h884c59f_0        pkgs/r/linux-64             2 MB
  + r-scales                     1.2.1  r42hc72bb7e_1        conda-forge/noarch        612 KB
  + r-selectr                    0.4_2  r42hc72bb7e_2        conda-forge/noarch        463 KB
  + r-stringi                    1.7.6  r42h884c59f_0        pkgs/r/linux-64           826 KB
  + r-stringr                    1.4.1  r42hc72bb7e_1        conda-forge/noarch        212 KB
  + r-sys                        3.4.1  r42h06615bd_0        conda-forge/linux-64       49 KB
  + r-tibble                     3.1.8  r42h06615bd_1        conda-forge/linux-64      694 KB
  + r-tidyr                      1.2.0  r42h884c59f_0        pkgs/r/linux-64           805 KB
  + r-tidyselect                 1.1.2  r42hc72bb7e_1        conda-forge/linux-64      199 KB
  + r-tidyverse                  1.3.2  r42hc72bb7e_1        conda-forge/noarch        438 KB
  + r-tinytex                     0.43  r42hc72bb7e_0        conda-forge/noarch        139 KB
  + r-tzdb                       0.3.0  r42h884c59f_0        pkgs/r/linux-64           507 KB
  + r-utf8                       1.2.2  r42h06615bd_1        conda-forge/linux-64      164 KB
  + r-uuid                       1.1_0  r42h06615bd_1        conda-forge/linux-64       54 KB
  + r-vctrs                      0.4.1  r42h884c59f_0        pkgs/r/linux-64             1 MB
  + r-viridislite                0.4.1  r42hc72bb7e_1        conda-forge/noarch          1 MB
  + r-vroom                      1.5.7  r42h884c59f_0        pkgs/r/linux-64           865 KB
  + r-withr                      2.5.0  r42hc72bb7e_1        conda-forge/noarch        240 KB
  + r-xfun                        0.31  r42h76d94ec_0        pkgs/r/linux-64           380 KB
  + r-xml2                       1.3.3  r42h884c59f_0        pkgs/r/linux-64           227 KB
  + r-yaml                       2.3.6  r42h06615bd_0        conda-forge/linux-64      122 KB
  + sysroot_linux-64              2.12  he073ed8_15          conda-forge/noarch         31 MB
  + tktable                       2.10  hb7b940f_3           conda-forge/linux-64       89 KB

  Change:
───────────────────────────────────────────────────────────────────────────────────────────────

  - mkl_fft                      1.3.1  py37hd3c417c_0       installed
  + mkl_fft                      1.3.1  py37h3e078e5_1       conda-forge/linux-64      206 KB
  - mkl_random                   1.2.2  py37h51133e4_0       installed
  + mkl_random                   1.2.2  py37h219a48f_0       conda-forge/linux-64      361 KB
  - numpy                       1.21.5  py37h6c91a56_3       installed
  + numpy                       1.21.5  py37hf838250_3       pkgs/main/linux-64         10 KB
  - numpy-base                  1.21.5  py37ha15fc14_3       installed
  + numpy-base                  1.21.5  py37h1e6e340_3       pkgs/main/linux-64          5 MB
  - scipy                        1.7.3  py37h6c91a56_2       installed
  + scipy                        1.7.3  py37hf2a6cf1_0       conda-forge/linux-64       22 MB

  Upgrade:
───────────────────────────────────────────────────────────────────────────────────────────────

  - blas                           1.0  mkl                  installed
  + blas                           1.1  openblas             conda-forge/linux-64      Cached

  Summary:

  Install: 137 packages
  Change: 5 packages
  Upgrade: 1 packages

  Total download: 251 MB

───────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/N] Y
Finished bwidget                              (00m:00s)             120 KB      1 MB/s
Finished make                                 (00m:00s)             507 KB      4 MB/s
Finished liblapack                            (00m:00s)              13 KB     95 KB/s
Finished pixman                               (00m:00s)             627 KB      4 MB/s
Finished pcre2                                (00m:00s)               1 MB      7 MB/s
Finished _r-mutex                             (00m:00s)               3 KB     21 KB/s
Finished fonts-conda-ecosystem                (00m:00s)               4 KB     20 KB/s
Finished font-ttf-ubuntu                      (00m:00s)               2 MB      8 MB/s
Finished gxx_linux-64                         (00m:00s)              24 KB     88 KB/s
Finished mkl_random                           (00m:00s)             361 KB      1 MB/s
Finished numpy-base                           (00m:00s)               5 MB     14 MB/s
Finished r-farver                             (00m:00s)               1 MB      4 MB/s
Finished r-rlang                              (00m:00s)               1 MB      3 MB/s
Finished r-backports                          (00m:00s)             111 KB    252 KB/s
Finished r-mime                               (00m:00s)              52 KB    107 KB/s
Finished r-sys                                (00m:00s)              49 KB    100 KB/s
Finished libopenblas                          (00m:00s)              10 MB     22 MB/s
Finished r-rappdirs                           (00m:00s)              52 KB     95 KB/s
Finished r-stringi                            (00m:00s)             826 KB      1 MB/s
Finished r-askpass                            (00m:00s)              29 KB     49 KB/s
Finished r-fansi                              (00m:00s)             323 KB    536 KB/s
Finished r-glue                               (00m:00s)             154 KB    254 KB/s
Finished r-evaluate                           (00m:00s)              85 KB    133 KB/s
Finished r-gtable                             (00m:00s)             174 KB    268 KB/s
Finished r-viridislite                        (00m:00s)               1 MB      2 MB/s
Finished r-clipr                              (00m:00s)              68 KB    101 KB/s
Finished r-rstudioapi                         (00m:00s)             301 KB    446 KB/s
Finished r-crayon                             (00m:00s)             168 KB    242 KB/s
Finished r-munsell                            (00m:00s)             248 KB    353 KB/s
Finished r-ids                                (00m:00s)             127 KB    178 KB/s
Finished r-knitr                              (00m:00s)               1 MB      2 MB/s
Finished r-jquerylib                          (00m:00s)             370 KB    466 KB/s
Finished r-cli                                (00m:00s)               1 MB      1 MB/s
Finished r-scales                             (00m:00s)             612 KB    706 KB/s
Finished r-matrix                             (00m:00s)               4 MB      5 MB/s
Finished r-reprex                             (00m:00s)             499 KB    565 KB/s
Finished r-rvest                              (00m:00s)             216 KB    239 KB/s
Finished r-sass                               (00m:00s)               2 MB      2 MB/s
Finished r-forcats                            (00m:00s)             390 KB    418 KB/s
Finished r-callr                              (00m:00s)             429 KB    457 KB/s
Finished r-vroom                              (00m:00s)             865 KB    913 KB/s
Finished r-tidyverse                          (00m:00s)             438 KB    446 KB/s
Finished libblas                              (00m:00s)              13 KB     12 KB/s
Finished r-dbplyr                             (00m:00s)            1005 KB   1006 KB/s
Finished r-readr                              (00m:00s)             808 KB    784 KB/s
Finished fonts-conda-forge                    (00m:00s)               4 KB      4 KB/s
Finished kernel-headers_linux-64              (00m:00s)             707 KB    657 KB/s
Finished r-fastmap                            (00m:00s)              64 KB     54 KB/s
Finished r-fs                                 (00m:00s)             468 KB    394 KB/s
Finished gcc_impl_linux-64                    (00m:00s)              22 MB     21 MB/s
Finished libgcc-devel_linux-64                (00m:00s)               3 MB      2 MB/s
Finished r-data.table                         (00m:00s)               2 MB      1 MB/s
Finished r-curl                               (00m:00s)             692 KB    519 KB/s
Finished r-lattice                            (00m:00s)               1 MB    854 KB/s
Finished r-cachem                             (00m:00s)              73 KB     52 KB/s
Finished r-rematch                            (00m:00s)              20 KB     14 KB/s
Finished r-assertthat                         (00m:00s)              71 KB     49 KB/s
Finished r-cpp11                              (00m:00s)             236 KB    158 KB/s
Finished r-tinytex                            (00m:00s)             139 KB     91 KB/s
Finished r-prettyunits                        (00m:00s)              42 KB     27 KB/s
Finished r-mgcv                               (00m:00s)               3 MB      2 MB/s
Finished gxx_impl_linux-64                    (00m:00s)              11 MB      7 MB/s
Finished r-htmltools                          (00m:00s)             333 KB    200 KB/s
Finished r-nlme                               (00m:00s)               2 MB      1 MB/s
Finished r-progress                           (00m:00s)              92 KB     55 KB/s
Finished r-blob                               (00m:00s)              65 KB     38 KB/s
Finished r-cellranger                         (00m:00s)             110 KB     64 KB/s
Finished r-rematch2                           (00m:00s)              54 KB     31 KB/s
Finished r-modelr                             (00m:00s)             220 KB    125 KB/s
Finished r-tidyr                              (00m:00s)             805 KB    452 KB/s
Finished binutils_linux-64                    (00m:00s)              24 KB     12 KB/s
Finished harfbuzz                             (00m:00s)               1 MB    585 KB/s
Finished scipy                                (00m:00s)              22 MB     12 MB/s
Finished r-digest                             (00m:00s)             185 KB     90 KB/s
Finished r-yaml                               (00m:00s)             122 KB     58 KB/s
Finished r-vctrs                              (00m:00s)               1 MB    509 KB/s
Finished openblas                             (00m:00s)              11 MB      5 MB/s
Finished r-mass                               (00m:00s)               1 MB    519 KB/s
Finished r-jsonlite                           (00m:00s)             619 KB    271 KB/s
Finished r-labeling                           (00m:00s)              68 KB     30 KB/s
Finished r-highr                              (00m:00s)              56 KB     24 KB/s
Finished r-generics                           (00m:00s)              92 KB     40 KB/s
Finished r-httr                               (00m:00s)             497 KB    212 KB/s
Finished r-gargle                             (00m:00s)             484 KB    203 KB/s
Finished r-lubridate                          (00m:00s)             994 KB    413 KB/s
Finished r-bit64                              (00m:00s)             508 KB    208 KB/s
Finished r-googledrive                        (00m:00s)               2 MB    723 KB/s
Finished r-readxl                             (00m:00s)             742 KB    295 KB/s
Finished tktable                              (00m:00s)              89 KB     35 KB/s
Finished font-ttf-source-code-pro             (00m:00s)             684 KB    265 KB/s
Finished r-bslib                              (00m:00s)               4 MB      2 MB/s
Finished r-xfun                               (00m:00s)             380 KB    142 KB/s
Finished binutils_impl_linux-64               (00m:00s)               5 MB      2 MB/s
Finished r-base64enc                          (00m:00s)              44 KB     16 KB/s
Finished r-utf8                               (00m:00s)             164 KB     57 KB/s
Finished r-pkgconfig                          (00m:00s)              26 KB      9 KB/s
Finished sysroot_linux-64                     (00m:00s)              31 MB     11 MB/s
Finished r-tzdb                               (00m:00s)             507 KB    172 KB/s
Finished r-stringr                            (00m:00s)             212 KB     70 KB/s
Finished libstdcxx-devel_linux-64             (00m:00s)              15 MB      5 MB/s
Finished r-pillar                             (00m:00s)             677 KB    220 KB/s
Finished libcblas                             (00m:00s)              13 KB      4 KB/s
Finished r-dtplyr                             (00m:00s)             324 KB    103 KB/s
Finished r-purrr                              (00m:00s)             414 KB    132 KB/s
Finished r-rmarkdown                          (00m:00s)               3 MB    880 KB/s
Finished r-uuid                               (00m:00s)              54 KB     17 KB/s
Finished r-xml2                               (00m:00s)             227 KB     71 KB/s
Finished r-r6                                 (00m:00s)              90 KB     28 KB/s
Finished mkl_fft                              (00m:00s)             206 KB     62 KB/s
Finished r-lifecycle                          (00m:00s)             102 KB     31 KB/s
Finished r-openssl                            (00m:00s)             620 KB    185 KB/s
Finished r-tibble                             (00m:00s)             694 KB    207 KB/s
Finished fribidi                              (00m:00s)             112 KB     33 KB/s
Finished r-dplyr                              (00m:00s)               1 MB    331 KB/s
Finished pango                                (00m:00s)             403 KB    119 KB/s
Finished r-isoband                            (00m:00s)               2 MB    525 KB/s
Finished r-rcolorbrewer                       (00m:00s)              65 KB     19 KB/s
Finished r-memoise                            (00m:00s)              58 KB     17 KB/s
Finished r-haven                              (00m:00s)             363 KB    103 KB/s
Finished r-tidyselect                         (00m:00s)             199 KB     56 KB/s
Finished gcc_linux-64                         (00m:00s)              25 KB      7 KB/s
Finished r-ps                                 (00m:00s)             323 KB     90 KB/s
Finished r-hms                                (00m:00s)             107 KB     30 KB/s
Finished r-dbi                                (00m:00s)             771 KB    212 KB/s
Finished gfortran_impl_linux-64               (00m:00s)              15 MB      4 MB/s
Finished r-withr                              (00m:00s)             240 KB     65 KB/s
Finished r-broom                              (00m:00s)               2 MB    484 KB/s
Finished gfortran_linux-64                    (00m:00s)              24 KB      7 KB/s
Finished font-ttf-inconsolata                 (00m:00s)              94 KB     25 KB/s
Finished r-ellipsis                           (00m:00s)              42 KB     11 KB/s
Finished r-bit                                (00m:00s)               1 MB    302 KB/s
Finished numpy                                (00m:00s)              10 KB      3 KB/s
Finished r-magrittr                           (00m:00s)             216 KB     56 KB/s
Finished r-colorspace                         (00m:00s)               3 MB    679 KB/s
Finished r-googlesheets4                      (00m:00s)             498 KB    128 KB/s
Finished r-selectr                            (00m:00s)             463 KB    119 KB/s
Finished r-processx                           (00m:00s)             332 KB     84 KB/s
Finished r-ggplot2                            (00m:00s)               4 MB      1 MB/s
Finished r-base                               (00m:02s)              26 MB      5 MB/s
Downloading  [====================================================================================================] (00m:13s)   51.39 MB/s
Extracting   [====================================================================================================] (02m:19s)    139 / 139
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="55"></a>
### 5/5
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Install atria for looking into adapters, 5/5: Create an alias for atria</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

alias atria="\${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria"
atria
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: Install atria for looking into adapters, 5/5: Create an alias for atria</i></summary>

```txt
❯ atria

  Atria v3.2.1
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡

  An ultra-fast and accurate adapter and quality trimming software designed for paired-end sequencing data.

  If you use Atria, please cite

  │  Jiacheng Chuan, Aiguo Zhou, Lawrence Richard Hale, Miao He, Xiang Li, Atria: an ultra-fast and accurate trimmer for adapter and quality trimming, Gigabyte, 1, 2021 https://doi.org/10.46471/gigabyte.31

  Github: https://github.com/cihga39871/Atria

  Usage
  =======

  Try atria -h or atria --help for more information.

  Input and Output
  ––––––––––––––––––

  The input files should be paired-end FastQ(.gz|.bz2) files (in the same order), or single-end fastqs:

    1. Read 1 files: -r X_R1.FQ Y_R1.FQ.GZ ...

    2. Read 2 files (optional): -R X_R2.FQ Y_R2.FQ.GZ ...

  Output all files to a directory: -o PATH or --output-dir PATH. Default is the current directory.

  Atria skips completed analysis by default. Use -f or --force to disable the feature.

  Trimming methods
  ––––––––––––––––––

  Atria integrated several trimming and read filtration methods. It does the following sequentially.

    1. Poly X Tail Trimming: remove remove poly-X tails.
       suggest to enable --polyG for Illumina NextSeq/NovaSeq data.
       • enable: --polyG, --polyT, --polyA, and/or --polyC (default: disabled)
       • trim poly X tail if length > INT: --poly-length 10

    2. Adapter Trimming
       • specify read 1 adapter: -a SEQ or --adapter1 SEQ (default: AGATCGGAAGAGCACACGTCTGAACTCCAGTCA)
       • specify read 2 adapter: -A SEQ or --adapter2 SEQ (default: AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT) (if paired-end)
       • disable: --no-adapter-trim
       • if adapter is unknown, use --detect-adapter.

    3. Paired-end Consensus Calling: the overlapped regions of read pairs are checked and corrected. It is available only when input files are paired-end and Adapter Trimming is on.
       • disable: --no-consensus

    4. Hard Clip 3' end: resize reads to a fixed length by discarding extra bases in 3' end.
       • specify the number of bases to keep: -C INT or --clip-after INT (default: disabled)

    5. Hard Clip 5' end: remove the first INT bases from 5' end.
       • specify the number of bases to remove: -c INT or --clip5 INT (default: disabled)

    6. Quality Trimming: trim low-quality tails. (Trimming read tails when the average quality of bases in a sliding window is low.)
       • specify average quality threshold: -q 20 or --quality-score 20 (default: 20)
       • specify sliding window length: --quality-kmer 5 (default: 5)
       • specify FastQ quality format: --quality-format Illumina1.8, or --quality-format 33 (default: 33, ie. Illumina1.8)
       • disable: --no-quality-trim

    7. Tail N Trimming: trim N tails.
       • disable: --no-tail-n-trim

    8. N Filtration: discard a read pair if the number of N in one read is greater than a certain amount. N tails are ignored if Tail N Trimming is on.
       • specify # N allowed in each read: -n 15 or --max-n 15 (default: 15)
       • disable: -n -1 or --max-n -1

    9. Read Length Filtration: filter read pair length in a range.
       • specify read length range: --length-range 50:500 (default: 50:500)
       • disable: --no-length-filtration

    10. Read Complexity Filtration: filter reads with low complexity.
       Complexity is the percentage of base that is different from its next base.
       • enable: --enable-complexity-filtration (default: disabled)
       • specify complexity threshold: --min-complexity 0.3 (default: 0.3)

  Parallel (multi-threading) computing
  ––––––––––––––––––––––––––––––––––––––

    1. Specify number of threads to use: -t 8 or --threads 8. (Default: 8)

    2. If memory is not sufficient, use --log2-chunk-size INT where INT is from 23 to 25. Memory usage reduces exponentially as it decreases.
```
</details>
<br />
<br />

<a id="building-a-umi_tools_env"></a>
## Building a `umi_tools_env`
<details>
<summary><i>Code: Building a umi_tools_env</i></summary>

```bash
#!/bin/env
#DONTRUN #CREATE

# grabnode  # 1, default settings

# conda create \
#     -n umi_tools_env \
#     -c bioconda umi_tools=1.1.2=py38hbff2b2d_1

# source activate umi_tools_env
```
`#NOTE` For now, just use the FHCC cluster installation, `UMI-tools/1.0.1-foss-2019b-Python-3.7.4`
</details>
<br />
<br />

<a id="building-an-environment-for-polyatailor"></a>
## Building an environment for [PolyAtailor](https://github.com/BMILAB/PolyAtailor)
<a id="notes"></a>
### Notes
<details>
<summary><i>Notes: Building an environment for PolyAtailor</i></summary>

Thinking of a strategy to set up the base environment with conda/mamba and then installing GitHub packages with pip3, then installing R packages in R iteself with either CRAN or bioconductor; the below packages have information on how we may be able to do this
- [How to Install R Packages in Your Own Environment (Updated)](https://www.youtube.com/watch?v=_CT_jAV4ULw)
- [Installing additional R packages ](https://www.chpc.utah.edu/documentation/software/r-language.php#rpkg)
</details>
<br />
<br />
