
<br />
<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Miscellaneous](#miscellaneous)
1. [Attempts to set up an environment for `Trinity`, etc.](#attempts-to-set-up-an-environment-for-trinity-etc)
	1. [Attempt #1 \(2022-1121\)](#attempt-1-2022-1121)
	1. [Attempt #2 \(2022-1122\)](#attempt-2-2022-1122)
1. [Filtering `.bam` files to retain only alignments to *S. cerevisiae* \(2022-1122\)](#filtering-bam-files-to-retain-only-alignments-to-s-cerevisiae-2022-1122)
1. [Do a trial run of `Trinity` genome-guided mode \(2022-1122\)](#do-a-trial-run-of-trinity-genome-guided-mode-2022-1122)
1. [Convert "rna-star" filtered `.bam` files back to `.fastq` files \(2022-1122\)](#convert-rna-star-filtered-bam-files-back-to-fastq-files-2022-1122)
1. [Do a trial run of `Trinity` genome-guided mode \(2022-1122\)](#do-a-trial-run-of-trinity-genome-guided-mode-2022-1122-1)
1. [Learning to use `Singularity` \(2022-1123\)](#learning-to-use-singularity-2022-1123)
	1. [Notes from FHCC Bioinformatics' *"Using `Singularity` Containers"*](#notes-from-fhcc-bioinformatics-using-singularity-containers)
	1. [Introduction](#introduction)
	1. [Using `Singularity`](#using-singularity)
	1. [Using Docker Containers with Singularity](#using-docker-containers-with-singularity)
		1. [Example: Convert and run latest `R` `Docker` container with `Singularity`](#example-convert-and-run-latest-r-docker-container-with-singularity)
	1. [Container Customization](#container-customization)
		1. [Example: Add `R` libraries to the base container](#example-add-r-libraries-to-the-base-container)
			1. [Build](#build)
			1. [Set up a Sylabs account](#set-up-a-sylabs-account)
			1. [*Try building again*](#try-building-again)
			1. [Verify](#verify)
	1. [Access to Storage](#access-to-storage)
		1. [Example: Bind Local File Systems](#example-bind-local-file-systems)
			1. [Create Mount Points](#create-mount-points)
			1. [Rebuild](#rebuild)
			1. [Run with Bind](#run-with-bind)
			1. [Verify](#verify-1)
	1. [The Build Environment](#the-build-environment)
		1. [The Image Cache](#the-image-cache)
		1. [Build Temporary Files](#build-temporary-files)
	1. [Related FHCC Bioinformatics links](#related-fhcc-bioinformatics-links)
1. [Follow-up question to Brian Haas](#follow-up-question-to-brian-haas)
	1. [Message from me \(2022-1122\)](#message-from-me-2022-1122)
	1. [Response from Brian Haas \(2022-1122\)](#response-from-brian-haas-2022-1122)
1. [Working out pipelines, `#TODO` lists, etc.](#working-out-pipelines-todo-lists-etc)
	1. [List of `#TODO`s written on 2022-1120](#list-of-todos-written-on-2022-1120)
	1. [Preprocessing pipeline rough draft, 2022-1121](#preprocessing-pipeline-rough-draft-2022-1121)
	1. [Subsequent pipeline draft, 2022-1121](#subsequent-pipeline-draft-2022-1121)
	1. [Building on the pipeline draft and reflecting on next steps, etc., 2022-1122](#building-on-the-pipeline-draft-and-reflecting-on-next-steps-etc-2022-1122)
	1. [Excel file used for parameterization](#excel-file-used-for-parameterization)
1. [Installing `PASA` and `Trinity` with `Singularity`](#installing-pasa-and-trinity-with-singularity)
	1. [More details and instructions for using PASA with Docker](#more-details-and-instructions-for-using-pasa-with-docker)
		1. [Example with test data](#example-with-test-data)
		1. [PASA/Docker Execution Modes \(SQLite or MySQL\)](#pasadocker-execution-modes-sqlite-or-mysql)
			1. [Docker using SQLite](#docker-using-sqlite)
			1. [MySQL internally within Docker](#mysql-internally-within-docker)
			1. [Local MySQL outside Docker Container](#local-mysql-outside-docker-container)
1. [On how to handle file input/output with `Singularity`](#on-how-to-handle-file-inputoutput-with-singularity)

<!-- /MarkdownTOC -->
</details>
<br />

`#TODO` Organize or delete this later
<br />
<br />

<a id="miscellaneous"></a>
## Miscellaneous
Couldn't really find much on "super-reads mode", which is something I found in the documentation for `Trinity v2.12.0`, nor did I find much on `--no_super_reads`: super-reads mode seems to be something happening by default according to the source code, at least in `Trinity v2.12.0`

Potentially interesting links/resources (from [Google search for "cerevisiae trinity assembly"](https://www.google.com/search?q=cerevisiae+trinity+assembly&oq=cerevisiae+trinity+assembly&aqs=chrome..69i57j33i160l4.353j0j7&sourceid=chrome&ie=UTF-8))
- [Compare *de novo* reconstructed transcripts to reference annotations](https://ycl6.gitbook.io/rna-seq-data-analysis/de_novo_assembly_using_trinity/compare_de_novo_reconstructed_transcripts_to_reference_annotations)
- [Assessing transcriptome assembly quality](https://southgreenplatform.github.io/trainings/trinityTrinotate/TP-trinity/#practice-3)
	+ Getting basic assembly metrics with the `Trinity` script `TrinityStats.pl`
	+ Reads mapping back rate and abundance estimation using the `Trinity` script `align_and_estimate_abundance.pl`
	+ Expression matrix construction
	+ Compute N50 based on the top-most highly expressed transcripts (Ex50)
	+ Quantifying completeness using BUSCO
	+ `BLASTX` comparison to known protein sequences database
	+ *Other sections before and after the above*
- [Assemblage de-novo de transcriptome Trinity](https://ressources.france-bioinformatique.fr/sites/default/files/A01_Galaxy_RNASeq_denovo_ITMO2016_0.pdf)
	+ Training from Ecole ITMO 2016
	+ Contains a lot of useful information; for example, info for preprocessing
	+ Interesting explanations of parameters, especially for butterfly stage  `#TODO` Study this later
- [Example of a yeast study using standard parameters for `Trinity`](https://www.sciencedirect.com/science/article/pii/S0888754321000288#ec0005)
- [An example of using StringTie with yeast](https://www.biostars.org/p/296555/)
- [On the meaning of N50](https://www.biostars.org/p/723/)

Before we even start tooling with the parameters, it is likely more important to clean the data
- See the FAS Informatics [*Best Practices* document]()
- See also the pertinent slides [here](https://ressources.france-bioinformatique.fr/sites/default/files/A01_Galaxy_RNASeq_denovo_ITMO2016_0.pdf)

~~Should I get cutadapt set up now...?~~ No, use `Trim Galore` (following the FAS Informatics [*Best Practices* document]())

`#QUESTION` Are forward reads left and reverse reads right? `#ANSWER` I don't know--probably
<br />
<br />

<a id="attempts-to-set-up-an-environment-for-trinity-etc"></a>
## Attempts to set up an environment for `Trinity`, etc.
<a id="attempt-1-2022-1121"></a>
### Attempt #1 (2022-1121)
- Creating an environment for `Trinity`, with related work
- So many failures...

<details>
<summary><i>Command line calls and notes</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode # Lowest and default settings

d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
cd "${d_work}" || echo "Error: cd'ing failed; check on this"

mamba create -n Trinity_env -c bioconda trinity
#  Success

echo 'alias Trinity_env="conda activate Trinity_env"' >> ~/.bash_aliases
alias Trinity_env="conda activate Trinity_env"
Trinity_env

mamba install -c bioconda pasa  # rcorrector cutadapt fastqc
# Encountered problems while solving:
#   - nothing provides perl 5.22.0* needed by pasa-2.3.3-pl5.22.0r3.4.1_0

mamba install -c bioconda pasa=2.5.2
# Encountered problems while solving:
#   - nothing provides libgcc-ng >=12 needed by pasa-2.5.2-h87f3376_0

mamba search -c anaconda libgcc-ng  #  No versions >=12
mamba install -c bioconda rcorrector  # cutadapt fastqc
#  Success

mamba install -c bioconda cutadapt  # fastqc
# Encountered problems while solving:
#   - nothing provides python 3.4* needed by cutadapt-1.10-py34_0

mamba search -c bioconda cutadapt
#  Success

mamba install -c bioconda cutadapt=4.1
# Encountered problems while solving:
#   - nothing provides libgcc-ng >=12 needed by cutadapt-4.1-py310h1425a21_1

mamba search -c conda-forge libgcc-ng  #  Several versions >12
mamba install -c conda-forge libgcc-ng=12.2.0  # Latest
#  Success: _openmp_mutex downgraded from 5.1 to 4.5

mamba install -c bioconda cutadapt=4.1
# Pinned packages:
#   - python 3.8.*
# 
# Encountered problems while solving:
#   - nothing provides python_abi 3.10.* *_cp310 needed by cutadapt-4.1-py310h1425a21_1

mamba install -c bioconda pasa=2.5.2
# Pinned packages:
#   - python 3.8.*
# 
# Encountered problems while solving:
#   - nothing provides libstdcxx-ng >=12 needed by pasa-2.5.2-h87f3376_0

mamba install -c bioconda fastqc
#  Success

#  Install libstdcxx-ng, python_abi 3.10.*
mamba search -c conda-forge libstdcxx-ng  #  Several versions >12
mamba install -c conda-forge libstdcxx-ng=12.2.0

mamba install -c bioconda pasa=2.5.2
# Encountered problems while solving:
#   - package pasa-2.5.2-h87f3376_0 requires lighttpd, but none of the providers can be installed

mamba install -c conda-forge lighttpd
#  Success (couple packages downgraded)

mamba install -c bioconda pasa=2.5.2
# Encountered problems while solving:
#   - package libnghttp2-1.46.0-hce63b2e_0 requires openssl >=1.1.1l,<1.1.2a, but none of the providers can be installed

mamba search -c conda-forge openssl
mamba install -c conda-forge openssl=1.1.1m

mamba install -c bioconda pasa=2.5.2  #  Weird because 1.1.1m
# Encountered problems while solving:
#   - package libnghttp2-1.47.0-h727a467_0 requires openssl >=1.1.1l,<1.1.2a, but none of the providers can be installed

mamba search -c conda-forge openssl
mamba install -c conda-forge openssl=1.1.1s

mamba install -c bioconda pasa=2.5.2  #  Weird because 1.1.1s
# Encountered problems while solving:
#   - package libnghttp2-1.47.0-h727a467_0 requires openssl >=1.1.1l,<1.1.2a, but none of the providers can be installed

mamba update -c conda-forge libnghttp2
# Encountered problems while solving:
#   - package libnghttp2-1.47.0-hdcd2b5c_1 requires openssl >=1.1.1q,<1.1.2a, but none of the providers can be installed

mamba install -c conda-forge openssl=1.1.1q

mamba install -c bioconda pasa=2.5.2  #  Weird because 1.1.1s
# Encountered problems while solving:
#   - package libnghttp2-1.47.0-hdcd2b5c_1 requires openssl >=1.1.1q,<1.1.2a, but none of the providers can be installed

mamba search -c conda-forge libnghttp2
#  ...
#+ Consider using Singularity to install PASA

mamba install -c bioconda cutadapt=4.1
# Encountered problems while solving:
#   - nothing provides python_abi 3.10.* *_cp310 needed by cutadapt-4.1-py310h1425a21_1

mamba search -c conda-forge python_abi
mamba install -c conda-forge python_abi=3.11
# Encountered problems while solving:
#   - package python_abi-3.11-2_cp311 requires python 3.11.*, but none of the providers can be installed

mamba search -c conda-forge python
mamba install -c conda-forge python=3.10.8
# Encountered problems while solving:
#   - package bowtie2-2.4.1-py38he513fc3_0 requires python >=3.8,<3.9.0a0, but none of the providers can be installed

#NOTE Cutadapt 4.1 is not possible without changing Bowtie2 and then potentially... Wait, what version of Trinity is this?

which Trinity
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/Trinity

Trinity --version
# Trinity version: Trinity-v2.9.1
# ** NOTE: Latest version of Trinity is Trinity-v2.14.0, and can be obtained at:
#     https://github.com/trinityrnaseq/trinityrnaseq/releases

#  Delete the environment and try installing Trinity and PASA using Singularity
```
`#NOTE` Deleted the environment
</details>

<a id="attempt-2-2022-1122"></a>
### Attempt #2 (2022-1122)
- Have determined to install `Trinity` and `PASA` via `Singularity` (with `.simg` files made from the `Docker` images)
- The following packages will be installed into an environment, `Trinity_env`, using `conda`
	+ `Trim Galore`
		* [`conda`](https://anaconda.org/bioconda/trim-galore)
	+ `rCorrector`
		* [`conda`](https://anaconda.org/bioconda/rcorrector)
	+ `STAR`  `#MAYBE`
		* [`conda`](https://anaconda.org/bioconda/star)
	+ `FastQC`
		* [`conda`](https://anaconda.org/bioconda/fastqc)
	+ `bedtools`
		* [`bedtools`](https://anaconda.org/bioconda/bedtools)

```bash
#!/bin/bash
#DONTRUN

grabnode # Lowest and default settings

d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
cd "${d_work}" || echo "Error: cd'ing failed; check on this"

mamba search -c bioconda trim-galore
mamba search -c bioconda star
mamba search -c bioconda rcorrector
mamba search -c bioconda fastqc
mamba search -c bioconda bedtools

mamba create \
	-n Trinity_env \
	-c bioconda \
	trim-galore rcorrector star fastqc bedtools
# + _libgcc_mutex                     0.1  main            pkgs/main/linux-64     Cached
# + _openmp_mutex                     5.1  1_gnu           pkgs/main/linux-64     Cached
# + bedtools                       2.30.0  h7d7f7ad_2      bioconda/linux-64       18 MB
# + bz2file                          0.98  py37h06a4308_1  pkgs/main/linux-64     245 KB
# + bzip2                           1.0.8  h7b6447c_0      pkgs/main/linux-64     Cached
# + ca-certificates            2022.10.11  h06a4308_0      pkgs/main/linux-64     Cached
# + certifi                     2022.9.24  py37h06a4308_0  pkgs/main/linux-64     Cached
# + cutadapt                          2.6  py37h516909a_0  bioconda/linux-64      173 KB
# + dbus                          1.13.18  hb2f20db_0      pkgs/main/linux-64     Cached
# + dnaio                             0.3  py37h14c3975_1  bioconda/linux-64      129 KB
# + expat                           2.4.9  h6a678d5_0      pkgs/main/linux-64     Cached
# + fastqc                         0.11.9  hdfd78af_1      bioconda/noarch        Cached
# + font-ttf-dejavu-sans-mono        2.37  hd3eb1b0_0      pkgs/main/noarch       Cached
# + fontconfig                     2.13.1  hef1e5e3_1      pkgs/main/linux-64     Cached
# + freetype                       2.12.1  h4a9f257_0      pkgs/main/linux-64     Cached
# + gdbm                             1.18  hd4cb3f1_4      pkgs/main/linux-64     Cached
# + glib                           2.69.1  h4ff587b_1      pkgs/main/linux-64     Cached
# + icu                              58.2  he6710b0_3      pkgs/main/linux-64     Cached
# + kmer-jellyfish                  2.3.0  h9f5acd7_3      bioconda/linux-64      Cached
# + ld_impl_linux-64                 2.38  h1181459_1      pkgs/main/linux-64     Cached
# + libffi                            3.3  he6710b0_2      pkgs/main/linux-64     Cached
# + libgcc-ng                      11.2.0  h1234567_1      pkgs/main/linux-64     Cached
# + libgomp                        11.2.0  h1234567_1      pkgs/main/linux-64     Cached
# + libpng                         1.6.37  hbc83047_0      pkgs/main/linux-64     Cached
# + libstdcxx-ng                   11.2.0  h1234567_1      pkgs/main/linux-64     Cached
# + libuuid                        1.41.5  h5eee18b_0      pkgs/main/linux-64     Cached
# + libxcb                           1.15  h7f8727e_0      pkgs/main/linux-64     Cached
# + libxml2                        2.9.14  h74e7548_0      pkgs/main/linux-64     Cached
# + ncurses                           6.3  h5eee18b_3      pkgs/main/linux-64     Cached
# + openjdk                       11.0.13  h87a67e3_0      pkgs/main/linux-64     Cached
# + openssl                        1.1.1s  h7f8727e_0      pkgs/main/linux-64     Cached
# + pcre                             8.45  h295c915_0      pkgs/main/linux-64     Cached
# + perl                           5.34.0  h5eee18b_2      pkgs/main/linux-64     Cached
# + pigz                              2.6  h27cfd23_0      pkgs/main/linux-64      70 KB
# + pip                            22.2.2  py37h06a4308_0  pkgs/main/linux-64     Cached
# + python                         3.7.15  haa1d7c7_0      pkgs/main/linux-64      41 MB
# + rcorrector                      1.0.4  h2e03b76_2      bioconda/linux-64      Cached
# + readline                          8.2  h5eee18b_0      pkgs/main/linux-64     Cached
# + setuptools                     65.5.0  py37h06a4308_0  pkgs/main/linux-64       1 MB
# + sqlite                         3.39.3  h5082296_0      pkgs/main/linux-64     Cached
# + star                          2.7.10b  h9ee0642_0      bioconda/linux-64        5 MB
# + tk                             8.6.12  h1ccaba5_0      pkgs/main/linux-64     Cached
# + trim-galore                     0.6.7  hdfd78af_0      bioconda/noarch         42 KB
# + wheel                          0.37.1  pyhd3eb1b0_0    pkgs/main/noarch       Cached
# + xopen                           0.7.3  py_0            bioconda/noarch         11 KB
# + xz                              5.2.6  h5eee18b_0      pkgs/main/linux-64     Cached
# + zlib                           1.2.13  h5eee18b_0      pkgs/main/linux-64     Cached

#  Check w/r/t/mamba search results (in separate tab)
#+ - STAR is up-to-date
#+ - Trim Galore is up-to-date
#+ - rcorrector is at version 1.0.4=h2e03b76_2; the most up-to-date version is 1.0.5=h5b5514e_0
#+     - difference between 1.0.4 and 1.0.5 described here: github.com/mourisl/Rcorrector/pull/36
#+     - #OPINION Should be OK to move forward with 1.0.4
#+         - Unlikely to encounter described error
#+ - FastqQC is up-to-date
#+ - bedtools is up-to-date

#  Successfully installed everything to set up the environment
Trinity_env  # It works because already present in .bash_aliases (yesterday)


# #  Go ahead and add samtools; goal is to have a compute environment in which
# #+ nothing is loaded from FHCC Bioinformatics
# mamba search -c bioconda samtools
# mamba install -c bioconda samtools  # Cancel because...
# #   Package            Version  Build       Channel                  Size
# # ─────────────────────────────────────────────────────────────────────────
# #   Install:
# # ─────────────────────────────────────────────────────────────────────────
# #
# #   + c-ares            1.18.1  h7f8727e_0  pkgs/main/linux-64     Cached
# #   + htslib              1.13  h9093b5e_0  bioconda/linux-64      Cached
# #   + krb5              1.19.2  hac12032_0  pkgs/main/linux-64     Cached
# #   + libcurl           7.85.0  h91b91d3_0  pkgs/main/linux-64     Cached
# #   + libdeflate           1.7  h27cfd23_5  pkgs/main/linux-64     Cached
# #   + libedit     3.1.20210714  h7f8727e_0  pkgs/main/linux-64     Cached
# #   + libev               4.33  h7f8727e_1  pkgs/main/linux-64     Cached
# #   + libnghttp2        1.46.0  hce63b2e_0  pkgs/main/linux-64     Cached
# #   + libssh2           1.10.0  h8f2d780_0  pkgs/main/linux-64     Cached
# #   + samtools            1.13  h8c37831_0  bioconda/linux-64      Cached
# #
# #   Downgrade:
# # ─────────────────────────────────────────────────────────────────────────
# #
# #   - ncurses              6.3  h5eee18b_3  installed
# #   + ncurses              6.2  he6710b0_1  pkgs/main/linux-64     Cached
# #   - python            3.7.15  haa1d7c7_0  installed
# #   + python            3.7.11  h12debd9_0  pkgs/main/linux-64      45 MB
# #   - readline             8.2  h5eee18b_0  installed
# #   + readline             8.1  h27cfd23_0  pkgs/main/linux-64     Cached
#
# #  Installing an outdated version of samtools, i.e., 1.13 instead of 1.16.1
#
# mamba install -c bioconda samtools=1.16.1
# # Pinned packages:
# #   - python 3.7.*
# #
# # Encountered problems while solving:
# #   - nothing provides libgcc-ng >=12 needed by samtools-1.16.1-h6899075_0
```
<br />
<br />

<a id="filtering-bam-files-to-retain-only-alignments-to-s-cerevisiae-2022-1122"></a>
## Filtering `.bam` files to retain only alignments to *S. cerevisiae* (2022-1122)
`#QUESTION` Haven't I done this yet? I wrote `split_bam_by_species.sh`, but have I run it with respect to the "rna-star" and "multi-hit-mode" `.bam` files yet?
`#ANSWER` I have run a few tests in which most of the outfiles were `rm`'d
    - One outfile for a `.bam` composed of only *S. cerevisiae* chromosomes is present in `"${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_alignment_STAR/files_bams"`
    - There are no such `.bam` files in the subdirectories of `"${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_alignment_STAR_tags"`
    - ∴ Do this work for the two `{multi-hit-mode,rna-star}/files_bams/*.exclude-unmapped.bam` files in `/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_alignment_STAR_tags`

```bash
#!/bin/bash
#DONTRUN

grabnode # Take two cores; otherwise, use default settings

d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
cd "${d_work}" || echo "Error: cd'ing failed; check on this"

module load SAMtools/1.16.1-GCC-11.2.0


#  .bam from "multi-hit-mode" (separate tab) ----------------------------------
threads=2
d_multi="exp_alignment_STAR_tags/multi-hit-mode/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam"

samtools index -@ 2 "${d_multi}"

#  Doing the following based on work fixing split_bam_by_species.sh below in
#+ the section for "rna-star"
if [[ -f "$(dirname "${d_multi}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam" ]]; then
	# ls -lhaFG "$(dirname "${d_multi}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam"
	rm "$(dirname "${d_multi}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam"
fi

ls -lhaFG "$(dirname "${d_multi}")"
# total 9.2G
# drwxrws--- 3 kalavatt  847 Nov 22 08:45 ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22 ../
# -rw-rw---- 1 kalavatt 4.3G Nov 18 14:58 5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  82K Nov 18 15:02 5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 3.4G Nov 18 15:19 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  79K Nov 22 08:09 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  595 Nov 18 15:20 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt  194 Nov 18 15:32 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt  589 Nov 18 15:49 5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  241 Nov 18 15:27 5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:58 5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 8.3K Nov 18 14:58 5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  836 Nov 18 14:58 5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt 129K Nov 18 14:57 5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:58 5781_G1_IN_merged_STARtmp/

unset filters
filters=(
	"SC_all"
	"KL_all"
	"virus_20S"
)
for i in "${filters[@]}"; do
	bash ../../bin/split_bam_by_species.sh \
	-u FALSE \
	-i "${d_multi}" \
	-o "$(dirname "${d_multi}")" \
	-s "${i}" \
	-t "${threads}"
done
#NOTES Took more than 10 minutes to run for 'SC_all'...

#  Index the filtered .bam files
for i in "${filters[@]}"; do
	samtools index -@ "${threads}" \
		"$(dirname "${d_multi}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.${i}.bam"
done

ls -lhaFG "$(dirname "${d_multi}")"
# total 14G
# drwxrws--- 3 kalavatt 1.4K Nov 22 09:05 ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22 ../
# -rw-rw---- 1 kalavatt 4.3G Nov 18 14:58 5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  82K Nov 18 15:02 5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 3.4G Nov 18 15:19 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  79K Nov 22 08:09 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  595 Nov 18 15:20 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt  194 Nov 18 15:32 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt 207M Nov 22 09:03 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam
# -rw-rw---- 1 kalavatt  16K Nov 22 09:05 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam.bai
# -rw-rw---- 1 kalavatt 3.1G Nov 22 09:02 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam
# -rw-rw---- 1 kalavatt  64K Nov 22 09:05 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai
# -rw-rw---- 1 kalavatt 778K Nov 22 09:03 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam
# -rw-rw---- 1 kalavatt  280 Nov 22 09:05 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam.bai
# -rw-rw---- 1 kalavatt  589 Nov 18 15:49 5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  241 Nov 18 15:27 5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:58 5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 8.3K Nov 18 14:58 5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  836 Nov 18 14:58 5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt 129K Nov 18 14:57 5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:58 5781_G1_IN_merged_STARtmp/


#  .bam from "rna-star" (separate tab) ----------------------------------------
threads=2
d_normal="exp_alignment_STAR_tags/rna-star/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam"

samtools index -@ 2 "${d_normal}"

if [[ -f "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam" ]]; then
	# ls -lhaFG "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam"
	rm "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam"
fi
bash ../../bin/split_bam_by_species.sh \
	-u FALSE \
	-i "${d_normal}" \
	-o "$(dirname "${d_normal}")" \
	-s SC_all \
	-t "${threads}"

bash ../../bin/split_bam_by_species.sh \
	-u FALSE \
	-i "${d_normal}" \
	-o "$(dirname "${d_normal}")" \
	-s KL_all \
	-t "${threads}"

bash ../../bin/split_bam_by_species.sh \
	-u FALSE \
	-i "${d_normal}" \
	-o "$(dirname "${d_normal}")" \
	-s virus_20S \
	-t "${threads}"

ls -lhaFG "$(dirname "${d_normal}")"
# total 2.5G
# drwxrws--- 3 kalavatt  941 Nov 22 08:13 ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22 ../
# -rw-rw---- 1 kalavatt 1.2G Nov 18 14:39 5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  59K Nov 18 15:01 5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 608M Nov 18 15:06 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  56K Nov 22 08:10 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  577 Nov 18 15:06 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt   94 Nov 18 15:27 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt 815K Nov 22 08:17 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam
# -rw-rw---- 1 kalavatt  573 Nov 18 15:49 5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  141 Nov 18 15:22 5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:39 5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 7.9K Nov 18 14:39 5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  364 Nov 18 14:39 5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt  46K Nov 18 14:39 5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:39 5781_G1_IN_merged_STARtmp/

#FIXME 1/4 The output of the above three commands seems to be all be saved as
#FIXME 2/4 *.split_SC_all.bam; for example, from the SC_all command, size of
#FIXME 3/4 the .bam file was 568M and, from the virus_20S command, the .bam
#FIXME 4/4 file size is 815K; ∴, need to fix split_bam_by_species.sh
#DONE Try again

filters=(
	"SC_all"
	"KL_all"
	"virus_20S"
)
for i in "${filters[@]}"; do
	bash ../../bin/split_bam_by_species.sh \
	-u FALSE \
	-i "${d_normal}" \
	-o "$(dirname "${d_normal}")" \
	-s "${i}" \
	-t "${threads}"
done
#NOTE Runs very quickly

ls -lhaFG "$(dirname "${d_normal}")"
# total 3.2G
# drwxrws--- 3 kalavatt 1.3K Nov 22 08:27  ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22  ../
# -rw-rw---- 1 kalavatt 1.2G Nov 18 14:39  5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  59K Nov 18 15:01  5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 815K Nov 22 08:27  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.20S.bam
# -rw-rw---- 1 kalavatt  40M Nov 22 08:27 '5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.A B C D E F.bam'
# -rw-rw---- 1 kalavatt 608M Nov 18 15:06  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  56K Nov 22 08:10  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  577 Nov 18 15:06  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt   94 Nov 18 15:27  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt 568M Nov 22 08:27 '5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito.bam'
# -rw-rw---- 1 kalavatt 815K Nov 22 08:17  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam
# -rw-rw---- 1 kalavatt  573 Nov 18 15:49  5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  141 Nov 18 15:22  5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:39  5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 7.9K Nov 18 14:39  5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  364 Nov 18 14:39  5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt  46K Nov 18 14:39  5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:39  5781_G1_IN_merged_STARtmp/

#FIXME The "fix" to split_bam_by_species.sh is not quite right...
#DONE Try again...

rm "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.split_SC_all.bam"

for i in "${filters[@]}"; do
	bash ../../bin/split_bam_by_species.sh \
	-u FALSE \
	-i "${d_normal}" \
	-o "$(dirname "${d_normal}")" \
	-s "${i}" \
	-t "${threads}"
done
#NOTE Runs very quickly

ls -lhaFG "$(dirname "${d_normal}")"
# total 3.9G
# drwxrws--- 3 kalavatt 1.4K Nov 22 08:31  ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22  ../
# -rw-rw---- 1 kalavatt 1.2G Nov 18 14:39  5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  59K Nov 18 15:01  5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 815K Nov 22 08:27  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.20S.bam
# -rw-rw---- 1 kalavatt  40M Nov 22 08:27 '5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.A B C D E F.bam'
# -rw-rw---- 1 kalavatt 608M Nov 18 15:06  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  56K Nov 22 08:10  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  577 Nov 18 15:06  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt   94 Nov 18 15:27  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt 568M Nov 22 08:27 '5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito.bam'
# -rw-rw---- 1 kalavatt  40M Nov 22 08:31  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam
# -rw-rw---- 1 kalavatt 568M Nov 22 08:31  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam
# -rw-rw---- 1 kalavatt 815K Nov 22 08:31  5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam
# -rw-rw---- 1 kalavatt  573 Nov 18 15:49  5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  141 Nov 18 15:22  5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:39  5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 7.9K Nov 18 14:39  5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  364 Nov 18 14:39  5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt  46K Nov 18 14:39  5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:39  5781_G1_IN_merged_STARtmp/

#NOTE split_bam_by_species.sh is fixed now; remove the files with weird names
rm "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito.bam"
rm "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.A B C D E F.bam"
rm "$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.20S.bam"

#  Index the filtered .bam files
for i in "${filters[@]}"; do
	samtools index -@ "${threads}" \
		"$(dirname "${d_normal}")/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.${i}.bam"
done

ls -lhaFG "$(dirname "${d_normal}")"
# total 3.2G
# drwxrws--- 3 kalavatt 1.4K Nov 22 08:53 ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22 ../
# -rw-rw---- 1 kalavatt 1.2G Nov 18 14:39 5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  59K Nov 18 15:01 5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 608M Nov 18 15:06 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  56K Nov 22 08:10 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  577 Nov 18 15:06 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt   94 Nov 18 15:27 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt  40M Nov 22 08:31 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam
# -rw-rw---- 1 kalavatt  16K Nov 22 08:53 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam.bai
# -rw-rw---- 1 kalavatt 568M Nov 22 08:31 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam
# -rw-rw---- 1 kalavatt  41K Nov 22 08:53 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai
# -rw-rw---- 1 kalavatt 815K Nov 22 08:31 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam
# -rw-rw---- 1 kalavatt  280 Nov 22 08:53 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam.bai
# -rw-rw---- 1 kalavatt  573 Nov 18 15:49 5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  141 Nov 18 15:22 5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:39 5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 7.9K Nov 18 14:39 5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  364 Nov 18 14:39 5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt  46K Nov 18 14:39 5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:39 5781_G1_IN_merged_STARtmp/

#TODO #LATER 1/2 Get *.flags.txt, *.flagstat.txt, and FastQC output for the
#TODO #LATER 2/2 filtered .bam files
```
<br />
<br />

<a id="do-a-trial-run-of-trinity-genome-guided-mode-2022-1122"></a>
## Do a trial run of `Trinity` genome-guided mode (2022-1122)
...use the "multi-hit-mode" *S. cerevisiae*-only `.bam`
```bash
#!/bin/bash
#DONTRUN

grabnode # Lowest and default settings

#  Define variables
d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
d_guided="${d_work}/exp_alignment_STAR_tags/multi-hit-mode/files_bams"
f_guided="${d_guided}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"
prefix_0="Trinity_trial"
prefix_1="genome-guided"
prefix_2="$(echo $(basename "${f_guided}") | cut -d . -f 5)"
prefix="${prefix_0}_${prefix_1}_${prefix_2}"
intron=1002
script="submit-Trinity-trial-genome-guided.sh"
d_master="${d_work}/exp_${prefix_0}"
d_exp="${d_master}/exp_${prefix}"

#  Change and set up directories
cd "${d_work}" || echo "Error: cd'ing failed; check on this"
[[ -d "${d_exp}" ]] || mkdir -p "${d_exp}"

#  For now, use the latest version of Trinity available via FHCC Bioinformatics
ml Trinity/2.12.0-foss-2020b

#  Generate the job-submission script
if [[ -f "${script}" ]]; then rm "${script}"; fi
cat << script > "${script}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

infile="\${1}"
intron="\${2}"
outdir="\${3}"
prefix="\${4}"

echo "echo test:"
echo -e "Trinity \\ \n\
    --max_memory 50G \\ \n\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --SS_lib_type FR \\ \n\
    --genome_guided_bam "\${infile}" \\ \n\
    --genome_guided_max_intron "\${intron}" \\ \n\
    --jaccard_clip \\ \n\
    --output "\${outdir}/\${prefix}" \\ \n\
    --full_cleanup \\ \n\
    --min_kmer_cov 1 \\ \n\
    --min_iso_ratio 0.05 \\ \n\
    --min_glue 2 \\ \n\
    --glue_factor 0.05 \\ \n\
    --max_reads_per_graph 2000 \\ \n\
    --normalize_max_read_cov 200 \\ \n\
    --group_pairs_distance 700 \\ \n\
    --min_contig_length 200"

Trinity \\
    --max_memory 50G \\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\
    --SS_lib_type FR \\
    --genome_guided_bam "\${infile}" \\
    --genome_guided_max_intron "\${intron}" \\
    --jaccard_clip \\
    --output "\${outdir}/\${prefix}" \\
    --full_cleanup \\
    --min_kmer_cov 1 \\
    --min_iso_ratio 0.05 \\
    --min_glue 2 \\
    --glue_factor 0.05 \\
    --max_reads_per_graph 2000 \\
    --normalize_max_read_cov 200 \\
    --group_pairs_distance 700 \\
    --min_contig_length 200
script
# vi "${script}"

# bash "${script}" "${f_guided}" "${intron}" "${d_exp}" "${prefix}"
#  After running, tweaking, and rerunning, here's how the "echo test" looks
# echo test:
# Trinity \
#     --max_memory 50G \
#     --CPU  \
#     --SS_lib_type FR \
#     --genome_guided_bam /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_alignment_STAR_tags/multi-hit-mode/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam \
#     --genome_guided_max_intron 1002 \
#     --jaccard_clip \
#     --output /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/Trinity_trial_genome-guided_SC_all \
#     --full_cleanup \
#     --min_kmer_cov 1 \
#     --min_iso_ratio 0.05 \
#     --min_glue 2 \
#     --glue_factor 0.05 \
#     --max_reads_per_graph 2000 \
#     --normalize_max_read_cov 200 \
#     --group_pairs_distance 700 \
#     --min_contig_length 200

#  Now, in the HEREDOC, uncomment the call to Trinity; does it start?
bash "${script}" "${f_guided}" "${intron}" "${d_exp}" "${prefix}"

#  It starts to run... ^C the job and take a look at things:
#+
#+ The directory "exp_trinity_trial_genome-guided_SC_all/" was made in "$(pwd)"
#+ and not in "exp_Trinity_trial/" as expected, and there's a .bam outfile in
#+ "exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/"
#+
#+ Now, run it on SLURM
sbatch "${script}" "${f_guided}" "${intron}" "${d_exp}" "${prefix}"
#  It seems to be running successfully
```
<br />
<br />

<a id="convert-rna-star-filtered-bam-files-back-to-fastq-files-2022-1122"></a>
## Convert "rna-star" filtered `.bam` files back to `.fastq` files (2022-1122)
<details>
<summary><i>Documentation for bamToFastq and samtools fastq</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode # Lowest and default settings

Trinity_env

which bedtools
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/bedtools

bamToFastq
# Tool:    bedtools bamtofastq (aka bamToFastq)
# Version: v2.30.0
# Summary: Convert BAM alignments to FASTQ files.
#
# Usage:   bamToFastq [OPTIONS] -i <BAM> -fq <FQ>
#
# Options:
# 	-fq2	FASTQ for second end.  Used if BAM contains paired-end data.
# 		BAM should be sorted by query name is creating paired FASTQ.
#
# 	-tags	Create FASTQ based on the mate info
# 		in the BAM R2 and Q2 tags.
#
# Tips:
# 	If you want to create a single, interleaved FASTQ file
# 	for paired-end data, you can just write both to /dev/stdout:
#
# 	bedtools bamtofastq -i x.bam -fq /dev/stdout -fq2 /dev/stdout > x.ilv.fq
#
# 	Also, the samtools fastq command has more fucntionality and is a useful alternative.

ml SAMtools/1.16.1-GCC-11.2.0
samtools fastq
# Usage: samtools fastq [options...] <in.bam>
#
# Description:
# Converts a SAM, BAM or CRAM to FASTQ format.
#
# Options:
#   -0 FILE      write reads designated READ_OTHER to FILE
#   -1 FILE      write reads designated READ1 to FILE
#   -2 FILE      write reads designated READ2 to FILE
#   -o FILE      write reads designated READ1 or READ2 to FILE
#                note: if a singleton file is specified with -s, only
#                paired reads will be written to the -1 and -2 files.
#   -f INT       only include reads with all  of the FLAGs in INT present [0]
#   -F INT       only include reads with none of the FLAGS in INT present [0x900]
#   -G INT       only EXCLUDE reads with all  of the FLAGs in INT present [0]
#   -n           don't append /1 and /2 to the read name
#   -N           always append /1 and /2 to the read name
#   -O           output quality in the OQ tag if present
#   -s FILE      write singleton reads designated READ1 or READ2 to FILE
#   -t           copy RG, BC and QT tags to the FASTQ header line
#   -T TAGLIST   copy arbitrary tags to the FASTQ header line, '*' for all
#   -v INT       default quality score if not given in file [1]
#   -i           add Illumina Casava 1.8 format entry to header (eg 1:N:0:ATCACG)
#   -c INT       compression level [0..9] to use when writing bgzf files [1]
#   --i1 FILE    write first index reads to FILE
#   --i2 FILE    write second index reads to FILE
#   --barcode-tag TAG
#                Barcode tag [BC]
#   --quality-tag TAG
#                Quality tag [QT]
#   --index-format STR
#                How to parse barcode and quality tags
#
#       --input-fmt-option OPT[=VAL]
#                Specify a single input file format option in the form
#                of OPTION or OPTION=VALUE
#       --reference FILE
#                Reference sequence FASTA FILE [null]
#   -@, --threads INT
#                Number of additional threads to use [0]
#       --verbosity INT
#                Set level of verbosity
#
# The files will be automatically compressed if the file names have a .gz
# or .bgzf extension.  The input to this program must be collated by name.
# Run 'samtools collate' or 'samtools sort -n' to achieve this.
#
# Reads are designated READ1 if FLAG READ1 is set and READ2 is not set.
# Reads are designated READ2 if FLAG READ1 is not set and READ2 is set.
# Otherwise reads are designated READ_OTHER (both flags set or both flags unset).
# Run 'samtools flags' for more information on flag codes and meanings.
#
# The index-format string describes how to parse the barcode and quality tags.
# It is made up of 'i' or 'n' followed by a length or '*'.  For example:
#    i14i8       The first 14 characters are index 1, the next 8 are index 2
#    n8i14       Ignore the first 8 characters, and use the next 14 for index 1
#
# If the tag contains a separator, then the numeric part can be replaced with
# '*' to mean 'read until the separator or end of tag', for example:
#    i*i*        Break the tag at the separator into index 1 and index 2
#    n*i*        Ignore the left part of the tag until the separator,
#                then use the second part of the tag as index 1
#
# Examples:
# To get just the paired reads in separate files, use:
#    samtools fastq -1 pair1.fq -2 pair2.fq -0 /dev/null -s /dev/null -n in.bam
#
# To get all non-supplementary/secondary reads in a single file, redirect
# the output:
#    samtools fastq in.bam > all_reads.fq
```
</details>
<br />

Rather than `bamToFastq`, move forward with `samtools fastq`, full documentation for which is found [here](http://www.htslib.org/doc/samtools-fasta.html)
	+ It appears that the `.bam` infile needs to be QNAME-sorted prior to running the program
	+ At least we can use `samtools sort -n` with parallelization to speed sorting up
	+ Additional related details and issues are discussed in [this GitHub Issues post from 2019](https://github.com/samtools/samtools/issues/1014)

```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
cd "${d_work}" || echo "cd'ing into \${d_work} failed; check on this"

d_exp="exp_alignment_STAR_tags/rna-star/files_bams"
f_exp="${d_exp}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"
f_bam="${d_exp}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.sort-n.bam"
f_pre="$(echo "$(basename "${f_bam}")" | cut -d "." -f 1-5)"
threads=1

ml SAMtools/1.16.1-GCC-11.2.0

source ../../bin/functions.sh

sort_bam_qname() {
    # Run samtools sort -n on bam infile
    #
    # :param 1: number of threads for parallelization <int >= 1>
    # :param 2: bam infile, including path <chr>
    # :param 3: bam outfile, including path <chr>
    start="$(date +%s)"

    samtools sort -n -@ "${1}" "${2}" > "${3}" &
    display_spinning_icon $! \
    "Running samtools sort -n on $(basename "${2}")... "

    end="$(date +%s)"
    calculate_run_time "${start}" "${end}" \
    "Ran samtools sort -n on $(basename "${2}")."
}


convert_bam_fastq() {
	# Run samtools fastq on QNAME-sorted paired-end bam infile
	#
	# :param 1: number of threads for parallelization <int >= 1>
	# :param 2: QNAME-sorted paired-end bam infile, including path <chr>
	# :param 3: outdirectory, including path <chr>
	# :param 4: prefix for outfiles <chr>
    start="$(date +%s)"

    samtools fastq \
    	-@ "${1}" \
    	-1 "${3}/${4}.1.fq.gz" \
    	-2 "${3}/${4}.2.fq.gz" \
    	"${2}" &
    display_spinning_icon $! \
    "Running samtools fastq on $(basename "${2}")... "

    end="$(date +%s)"
    calculate_run_time "${start}" "${end}" \
    "Ran samtools fastq on $(basename "${2}")."
}


sort_bam_qname "${threads}" "${f_exp}" "${f_bam}"
# ls -lhaFG "${f_bam}"

if [[ -f "${f_bam}" ]]; then
	convert_bam_fastq "${threads}" "${f_bam}" "${d_exp}" "${f_pre}"
fi
#  Run time: 0h:0m:46s  # Nice

ls -lhaFG "${d_exp}"
# total 5.0G
# drwxrws--- 3 kalavatt 1.7K Nov 22 13:13 ./
# drwxrws--- 3 kalavatt   28 Nov 21 12:22 ../
# -rw-rw---- 1 kalavatt 1.2G Nov 18 14:39 5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw---- 1 kalavatt  59K Nov 18 15:01 5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw---- 1 kalavatt 608M Nov 18 15:06 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw---- 1 kalavatt  56K Nov 22 08:10 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw---- 1 kalavatt  577 Nov 18 15:06 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flagstat.txt
# -rw-rw---- 1 kalavatt   94 Nov 18 15:27 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw---- 1 kalavatt  40M Nov 22 08:31 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam
# -rw-rw---- 1 kalavatt  16K Nov 22 08:53 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.KL_all.bam.bai
# -rw-rw---- 1 kalavatt 309M Nov 22 13:14 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.1.fq.gz
# -rw-rw---- 1 kalavatt 320M Nov 22 13:14 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.2.fq.gz
# -rw-rw---- 1 kalavatt 568M Nov 22 08:31 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam
# -rw-rw---- 1 kalavatt  41K Nov 22 08:53 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai
# -rw-rw---- 1 kalavatt 850M Nov 22 12:54 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.sort-n.bam
# -rw-rw---- 1 kalavatt 815K Nov 22 08:31 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam
# -rw-rw---- 1 kalavatt  280 Nov 22 08:53 5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.virus_20S.bam.bai
# -rw-rw---- 1 kalavatt  573 Nov 18 15:49 5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# -rw-rw---- 1 kalavatt  141 Nov 18 15:22 5781_G1_IN_mergedAligned.sortedByCoord.out.flags.txt
# -rw-rw---- 1 kalavatt 2.0K Nov 18 14:39 5781_G1_IN_mergedLog.final.out
# -rw-rw---- 1 kalavatt 7.9K Nov 18 14:39 5781_G1_IN_mergedLog.out
# -rw-rw---- 1 kalavatt  364 Nov 18 14:39 5781_G1_IN_mergedLog.progress.out
# -rw-rw---- 1 kalavatt  46K Nov 18 14:39 5781_G1_IN_mergedSJ.out.tab
# drwx--S--- 3 kalavatt   25 Nov 18 14:39 5781_G1_IN_merged_STARtmp/


#  Check on the numbers of reads and alignments -------------------------------
#  Now need to check that the number of reads in the fastq files equals the
#+ number of alignments in the bam file
no_fq1="$(echo $(zcat "${d_exp}/${f_pre}.1.fq.gz" | wc -l)/4 | bc)"
echo "${no_fq1}"  # 8048121

no_fq2="$(echo $(zcat "${d_exp}/${f_pre}.2.fq.gz" | wc -l)/4 | bc)"
echo "${no_fq2}"  # 8048121

no_bam="$(samtools view -c "${f_bam}")"
echo "${no_bam}"  # 16096242

echo $(( no_fq1 + no_fq2 ))  # 16096242


#  What do the reads look like? -----------------------------------------------
zcat "${d_exp}/${f_pre}.1.fq.gz" | head -12
@HISEQ:1007:HGV5NBCX3:1:1101:1183:28197
# CTAGANCTCCAGCTAACGCNNNNNNNNNNNCTTCTNCCNNNNNNNANCAN
# +
# GGGGG#<GGGIIGIGIGII###############################
# @HISEQ:1007:HGV5NBCX3:1:1101:1183:31770
# CGCATNTTAAGTAATCCTANNNNNNNNNNNTCGTTNAGNNNNNNNTNAGN
# +
# GGGGG#<<GGGIIIIIIII###############################
# @HISEQ:1007:HGV5NBCX3:1:1101:1184:36229
# CAATCNTACTTATTCGAAGNTNNNGNNNNNGAATCNATNNNNNNNGNCTN
# +
# GGGGG#<<GGIIIGIIIII###############################

zcat "${d_exp}/${f_pre}.2.fq.gz" | head -12
# @HISEQ:1007:HGV5NBCX3:1:1101:1183:28197
# GATACCGAAAGCGGAGGTACCGGTTTCAGCAATGACAACATCACCTTCTT
# +
# GAGGGIIIIIIIIIGIIIIIIGGGIIIIGIIGIIIIIIGIIIGGGIIIGG
# @HISEQ:1007:HGV5NBCX3:1:1101:1183:31770
# GTGTGATTATCATATAAATATGTTTTATCACTATGCTTGAAAGCATATTA
# +
# GGGGGGGIGIGIIIIIGIIIIIIIIIGIIIIGGGGGGIIIIIIIIGIIIG
# @HISEQ:1007:HGV5NBCX3:1:1101:1184:36229
# GGTACAGCGTCACCACCCATCCACAAAAACAATTCGTTACCATTATCTAT
# +
# GGGGGGIIGIGIIIIIIIIIIIIIIIGGGGIIIIGGIIGIIIIIIIIIIG


#  How do the reads compare to the initial fastq files? -----------------------
head -12 files_fastq_symlinks/5781_G1_IN_merged_R1.fastq
# @HISEQ:1007:HGV5NBCX3:1:1101:1232:2133 1:Y:0:GTCGAGAA
# CNATANTGCTGGTTTGACTAAGGGTGCNTCTGCTGGTGAAGGTTTGGGTA
# +
# G#<GG#<<GGGIIIIIIIIIIIIIIII#<GGGIIIIGIIIIIIIIIIIIG
# @HISEQ:1007:HGV5NBCX3:1:1101:1203:2134 1:Y:0:NTCGAGAA
# GNAAANTCCATCTAAAGCTAAATATTGNCGAGAGACCGATAGCGAACAAG
# +
# G#<<G#<<GGGGIIIIIIIGIIGGGII#<<GGGIGGGGGGGIIIGGGGII
# @HISEQ:1007:HGV5NBCX3:1:1101:1275:2154 1:N:0:GTCGAGAA
# CAAGTACAGTGATGGAAAGATGAAAAGNACTTTGAAAAGAGAGTGAAAAA
# +
# GGGGGIGGIGGIIIIIIIIGGGIIIII#<GGGIGGIIIIGIGGGGGGGII

head -12 files_fastq_symlinks/5781_G1_IN_merged_R2.fastq
# @HISEQ:1007:HGV5NBCX3:1:1101:1232:2133 2:Y:0:GTCGAGAA
# TTGTGCGAATTCAATATCTTTCAATCTTAGTTCTTGGTTAATAATTTCTA
# +
# GGGGGIIIGIIIIIIIIIIIIIIGGIIIIIIIIIIIIIIIIIIIIIIIII
# @HISEQ:1007:HGV5NBCX3:1:1101:1203:2134 2:Y:0:NTCGAGAA
# AGCCCTTCCCTTTCAACAATTTCACGTACTTTTTCACTCTCTTTTCAAAG
# +
# GGGGGIIIGIGGGGIIIIIIIIIIIIIGGGGIIIGGIIIIIIGIIIIIGI
# @HISEQ:1007:HGV5NBCX3:1:1101:1275:2154 2:N:0:GTCGAGAA
# CCCATGTCTGATCAAATGCCCTTCCCTTTCAACAATTTCACGTACTTTTT
# +
# GGGGGIIIGIGGGIIIIIGGGIGIIIIIIIIIIIIIIIIIIIGGGIIIII

#  Look normal enough to me; let's try a trial run on Trinity genome-free mode
```
<br />
<br />

<a id="do-a-trial-run-of-trinity-genome-guided-mode-2022-1122-1"></a>
## Do a trial run of `Trinity` genome-guided mode (2022-1122)
...using the "rna-star" *S. cerevisiae*-only `.bam`-to-`.fastq` files
```bash
#!/bin/bash
#DONTRUN

grabnode # Lowest and default settings

#  Define variables
d_work="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"
d_free="${d_work}/exp_alignment_STAR_tags/rna-star/files_bams"
f_free_1="${d_free}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.1.fq.gz"
f_free_2="${d_free}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.2.fq.gz"
prefix_0="Trinity_trial"
prefix_1="genome-free"
prefix_2="$(echo $(basename "${f_free}") | cut -d . -f 5)"
prefix="${prefix_0}_${prefix_1}_${prefix_2}"
intron=1002
script="submit-Trinity-trial-genome-free.sh"
d_master="${d_work}/exp_${prefix_0}"
d_exp="${d_master}/exp_${prefix}"

echo "${d_work}"
echo "${d_free}"
echo "${f_free_1}"
echo "${f_free_2}"
echo "${prefix_0}"
echo "${prefix_1}"
echo "${prefix_2}"
echo "${prefix}"
echo "${intron}"
echo "${script}"
echo "${d_master}"
echo "${d_exp}"

ls -lhaFG "${d_work}"
ls -lhaFG "${d_free}"
ls -lhaFG "${f_free_1}"
ls -lhaFG "${f_free_2}"
ls -lhaFG "${d_master}"

#  Change and set up directories
cd "${d_work}" || echo "Error: cd'ing failed; check on this"
[[ -d "${d_exp}" ]] || mkdir -p "${d_exp}"

#  For now, use the latest version of Trinity available via FHCC Bioinformatics
ml Trinity/2.12.0-foss-2020b

#  Generate the job-submission script
if [[ -f "${script}" ]]; then rm "${script}"; fi
cat << script > "${script}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=6
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

infile_1="\${1}"
infile_2="\${2}"
outdir="\${3}"
prefix="\${4}"

echo "echo test:"
echo -e "Trinity \\ \n\
    --max_memory 50G \\ \n\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --SS_lib_type FR \\ \n\
    --seqType fq \\ \n\
    --left "\${infile_1}" \\ \n\
    --right "\${infile_2}" \\ \n\
    --jaccard_clip \\ \n\
    --output "\${outdir}/\${prefix}" \\ \n\
    --full_cleanup \\ \n\
    --min_kmer_cov 1 \\ \n\
    --min_iso_ratio 0.05 \\ \n\
    --min_glue 2 \\ \n\
    --glue_factor 0.05 \\ \n\
    --max_reads_per_graph 2000 \\ \n\
    --normalize_max_read_cov 200 \\ \n\
    --group_pairs_distance 700 \\ \n\
    --min_contig_length 200"

Trinity \\
    --max_memory 50G \\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\
    --SS_lib_type FR \\
    --seqType fq \\
    --left "\${infile_1}" \\
	--right "\${infile_2}" \\
    --jaccard_clip \\
    --output "\${outdir}/\${prefix}" \\
    --full_cleanup \\
    --min_kmer_cov 1 \\
    --min_iso_ratio 0.05 \\
    --min_glue 2 \\
    --glue_factor 0.05 \\
    --max_reads_per_graph 2000 \\
    --normalize_max_read_cov 200 \\
    --group_pairs_distance 700 \\
    --min_contig_length 200
script
vi "${script}"

bash "${script}" "${f_free_1}" "${f_free_2}" "${d_exp}" "${prefix}"
#  After running, tweaking, and rerunning, here's how the "echo test" looks
# echo test:
# Trinity \
#     --max_memory 50G \
#     --CPU 1 \
#     --SS_lib_type FR \
#     --seqType fq \
#     --left /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_alignment_STAR_tags/rna-star/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.1.fq.gz \
#     --right /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_alignment_STAR_tags/rna-star/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.2.fq.gz \
#     --jaccard_clip \
#     --output /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-free_SC_all/Trinity_trial_genome-free_SC_all \
#     --full_cleanup \
#     --min_kmer_cov 1 \
#     --min_iso_ratio 0.05 \
#     --min_glue 2 \
#     --glue_factor 0.05 \
#     --max_reads_per_graph 2000 \
#     --normalize_max_read_cov 200 \
#     --group_pairs_distance 700 \
#     --min_contig_length 200

#  Now, in the HEREDOC, uncomment the call to Trinity; does it start?
bash "${script}" "${f_free_1}" "${f_free_2}" "${d_exp}" "${prefix}"

#  It starts to run... ^C the job and take a look at things:
#+
#+ The outdirectory contains stuff... Clean it out and then run on SLURM
sbatch "${script}" "${f_free_1}" "${f_free_2}" "${d_exp}" "${prefix}"
#  It seems to be running successfully
```
<br />
<br />

<a id="learning-to-use-singularity-2022-1123"></a>
## Learning to use `Singularity` (2022-1123)
...in order to use `Trinity` and `PASA`, etc.

<a id="notes-from-fhcc-bioinformatics-using-singularity-containers"></a>
### Notes from FHCC Bioinformatics' *"Using `Singularity` Containers"*
- [Link to FHCC Bioinformatics' *"Using `Singularity` Containers"*](https://sciwiki.fredhutch.org/compdemos/Singularity/)
- Below, notes from me are in *italicized text*

<a id="introduction"></a>
### Introduction
¶1  
...

¶2  
<mark>`Singularity` allows us to run containers&mdash;including `Docker` containers&mdash;on our shared systems.</mark> <mark>`Docker` requires a number of administrative privileges which makes it unusable in shared multi-user environments with networked storage. `Singularity` remedies these problems allowing individual, non-root, users to run containers.</mark>

¶3  
...


<a id="using-singularity"></a>
### Using `Singularity`
¶1  
`Singularity` is available on the `rhino` and `gizmo` compute hosts. Please use a `gizmo` node if your task will be computationally intensive. `Singularity` containers can be run interactively (via `grabnode`) and in batch processing.

¶2  
...  
```bash
#EXAMPLEFROMTUTORIAL
ml Singularity
```

¶3  
Use `ml spider` to see available versions *(e.g., `ml spider Singularity`)*. Sylabs provides a library of built images that can be used directly:
```bash
#EXAMPLEFROMTUTORIAL
singularity pull --arch amd64 library://sylabsed/examples/lolcow:latest
```

<details>
<summary><i>Test it out</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

pwd
# /home/kalavatt

ml Singularity

singularity pull --arch amd64 library://sylabsed/examples/lolcow:latest
#  79.91 MiB / 79.91 MiB [============================================================================================================] 100.00% 702.84 KiB/s 1m56s
# WARNING: unable to verify container: lolcow_latest.sif
# WARNING: Skipping container verification

singularity run ./lolcow_latest.sif
# / A Tale of Two Cities LITE(tm)         \
# |                                       |
# | -- by Charles Dickens                 |
# |                                       |
# | A man in love with a girl who loves   |
# | another man who looks just            |
# |                                       |
# | like him has his head chopped off in  |
# | France because of a mean              |
# |                                       |
# | lady who knits.                       |
# |                                       |
# | Crime and Punishment LITE(tm)         |
# |                                       |
# | -- by Fyodor Dostoevski               |
# |                                       |
# | A man sends a nasty letter to a       |
# | pawnbroker, but later                 |
# |                                       |
# | feels guilty and apologizes.          |
# |                                       |
# | The Odyssey LITE(tm)                  |
# |                                       |
# | -- by Homer                           |
# |                                       |
# | After working late, a valiant warrior |
# \ gets lost on his way home.            /
#  ---------------------------------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||

ls -lhaFG
# total 108M
# drwxr-x--- 17 kalavatt  800 Nov 23 07:45 ./
# drwxr-xr-x  5 root        0 Nov 23 07:43 ../
# -rw-rw----  1 kalavatt 4.0K Nov 21 12:33 .bash_aliases
# -rw-rw----  1 kalavatt 3.2K Nov 20 13:21 .bash_functions
# -rw-------  1 kalavatt 564K Nov 23 07:45 .bash_history
# -rw-rw----  1 kalavatt  308 Oct 20 11:18 .bash_profile
# -rw-rw----  1 kalavatt 6.0K Nov  7 15:05 .bashrc
# drwxrwx---  9 kalavatt 6.4K Oct  5 17:22 bbmap/
# drwx------  4 kalavatt   87 Oct 20 11:42 .cache/
# drwxr-x---  2 kalavatt   34 Oct 20 10:28 .conda/
# drwxrwx---  5 kalavatt   75 Oct 28 15:14 .config/
# drwxrwx---  3 kalavatt   23 Oct 20 11:42 Downloads/
# drwxrwx--- 10 kalavatt  335 Nov  7 13:14 genomes/
# -rw-rw----  1 kalavatt   88 Oct 21 14:04 .gitconfig
# drwx------  3 kalavatt   35 Oct 17 10:57 .gnupg/
# drwxrwx---  3 kalavatt   23 Nov  7 15:06 .java/
# drwx------  7 kalavatt  113 Nov  1 09:09 .local/
# -rwxr-x---  1 kalavatt  80M Nov 23 07:37 lolcow_latest.sif*
# drwxr-x--- 20 kalavatt  570 Nov 22 07:44 miniconda3/
# drwxr-x--- 15 kalavatt  524 Oct 20 09:57 .oh-my-bash/
# drwxrwx---  2 kalavatt   44 Nov  1 12:54 .oracle_jre_usage/
# -rw-r-----  1 kalavatt   17 Nov 17 08:49 .osh-update
# -rw-rw----  1 kalavatt  726 Nov  1 09:20 picardmetrics.conf
# -rw-r-----  1 kalavatt    0 Nov 23 07:35 .sdirs
# drwx------  3 kalavatt   23 Nov 23 07:35 .singularity/
# drwxrwx---  6 kalavatt  148 Nov  1 09:09 src/
# drwx------  2 kalavatt   62 Oct 20 13:03 .ssh/
# lrwxrwxrwx  1 root       37 Oct 17 10:44 tsukiyamalab -> /fh/fast/tsukiyama_t/grp/tsukiyamalab/
# -rw-------  1 kalavatt  46K Nov 22 14:54 .viminfo
# -rw-rw----  1 kalavatt  215 Oct 20 10:33 .wget-hsts
# -rw-------  1 kalavatt   50 Nov 17 15:27 .Xauthority

#NOTE lolcow_latest.sif is saved to "$(pwd)"
```
</details>

¶4  
The error about container verification is not necessarily critical&mdash;if you would like to do a bit-by-bit validation of the download, [additional steps](https://sylabs.io/guides/3.5/user-guide/signNverify.html) are required.

<a id="using-docker-containers-with-singularity"></a>
### Using Docker Containers with Singularity
¶1  
`#DEKHO`  
As indicated earlier, `Singularity` can run `Docker` container images. However, <mark>`Docker` container images must first be converted to be usable by `Singularity`</mark>.

¶2  
<mark>The conversion step is only necessary the first time you convert a `Docker` container to a `Singularity` container or when you want to update your Singularity container</mark> (e.g., to a newer version of a `Docker` container).

<a id="example-convert-and-run-latest-r-docker-container-with-singularity"></a>
#### Example: Convert and run latest `R` `Docker` container with `Singularity`
¶1  
...

*Try it out*
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

pwd
# /home/kalavatt

ml Singularity

singularity build r-base-latest.sif docker://r-base
# INFO:    Starting build...
# WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
# WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
# Getting image source signatures
# Copying blob ebbe46658ae1 done
# Copying blob ae8780930e7e done
# Copying blob 48f11b798771 done
# Copying blob ced6bc7d0fb6 done
# Copying blob b6e2154a522a done
# Copying blob 36a417257f63 done
# Copying config 935885ce10 done
# Writing manifest to image destination
# Storing signatures
# 2022/11/23 07:47:41  info unpack layer: sha256:ebbe46658ae1eddd748e3222cbc9dd7109f9fd7f279a4b2f9d6a32d0a58b4c16
# 2022/11/23 07:47:42  info unpack layer: sha256:ae8780930e7e7b18116589a863916682a85c45bec3c738dab17f8740830988b5
# 2022/11/23 07:47:42  info unpack layer: sha256:48f11b798771daf119baa7f2f3d5b9c4363b0aec5d12e488fbb2e07a0cf0be79
# 2022/11/23 07:47:43  info unpack layer: sha256:ced6bc7d0fb644dbcbeecc374d4904ae5df8f303707c30aa60514e3d929fd644
# 2022/11/23 07:47:43  info unpack layer: sha256:b6e2154a522a29fd10fe63922ee826f4d42e1e474ad08bc2f8c71e811e7f0127
# 2022/11/23 07:47:43  info unpack layer: sha256:36a417257f633cd58de6c3b59ec8c55c5bb04296fa387da3daa9cc1cba037116
# INFO:    Creating SIF file...
# INFO:    Build complete: r-base-latest.sif

#NOTE It ran for 2-3 minutes before completing

singularity exec r-base-latest.sif R
# R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
# Copyright (C) 2022 The R Foundation for Statistical Computing
# Platform: x86_64-pc-linux-gnu (64-bit)
#
# R is free software and comes with ABSOLUTELY NO WARRANTY.
# You are welcome to redistribute it under certain conditions.
# Type 'license()' or 'licence()' for distribution details.
#
#   Natural language support but running in an English locale
#
# R is a collaborative project with many contributors.
# Type 'contributors()' for more information and
# 'citation()' on how to cite R or R packages in publications.
#
# Type 'demo()' for some demos, 'help()' for on-line help, or
# 'help.start()' for an HTML browser interface to help.
# Type 'q()' to quit R.
#
# >

getwd()
# [1] "/home/kalavatt"

quit()
# Save workspace image? [y/n/c]: n

if [[ -f test-script.R ]]; then rm test-script.R; fi
touch test-script.R
echo -e '#!/usr/bin Rscript \n' >> test-script.R
echo 'getwd()' >> test-script.R
echo 'list.files()' >> test-script.R
# vi test-script.R

singularity exec r-base-latest.sif Rscript test-script.R
# [1] "/home/kalavatt"
#  [1] "bbmap"              "Downloads"          "genomes"
#  [4] "lolcow_latest.sif"  "miniconda3"         "picardmetrics.conf"
#  [7] "r-base-latest.sif"  "src"                "test-script.R"
# [10] "tsukiyamalab"
if [[ -f test-script.R ]]; then rm test-script.R; fi
```

<a id="container-customization"></a>
### Container Customization
¶1  
Containers can be customized by using a base container image then <mark>adding desired changes via a "definition file" that has necessary steps for modifying the base container</mark>.

¶2  
Root access is typically required to build `Singularity` containers. <mark>Sylabs' remote builder provides an option to build your container in Sylabs' sandbox cloud infrastructure. Once the container finishes building, it will be automatically downloaded to your working directory where it can be run</mark>.

¶3  
To use the remote builder option in `Singularity` you need a Sylabs account and key. The steps to set up remote builder can be found [here](https://sylabs.io/guides/3.5/user-guide/endpoint.html).

¶4  
You will need to generate a new key every 30 days when using Sylabs' remote builder option.



<a id="example-add-r-libraries-to-the-base-container"></a>
#### Example: Add `R` libraries to the base container
¶1  
In this example, we are going to build a more complex `Singularity` container using the latest `R` `Docker` image. To the base container, we will add additional `R` modules using a `Singularity` definition file and then build using Sylabs’ tools.

¶2  
...

*Try it out*
```bash
#!/bin/bash
#DONTRUN

# grabnode  # Lowest and default settings
#
# pwd
# # /home/kalavatt
#
# ml Singularity
#
# singularity build r-base-latest.sif docker://r-base

def="my.r.singularity.build.def"

if [[ -f "${def}" ]]; then rm "${def}"; fi
touch "${def}"

echo -e \
	'BootStrap: docker\nFrom: r-base\n' \
		>> "${def}"
echo -e \
	"%post\nR --no-echo -e 'install.packages(\"devtools\", repos=\"https://cloud.r-project.org/\")'" \
		>> "${def}"
# # vi "${def}"
# BootStrap: docker
# From: r-base
#
# %post
# R --no-echo -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
```

¶3  
This file indicates that `Docker` is used to build the container from a `Docker` image named `r-base`. The `%post` section defines the steps we want to take to modify that original container&mdash;in this case, using `R` to install the `devtools` packages.

¶4  
More information about `Singularity` definition files is available [here](https://sylabs.io/guides/3.6/user-guide/definition_files.html).

<a id="build"></a>
##### Build
¶5  
...
```bash
#CONTINUE
singularity build --remote my_r_container.sif my.r.singularity.build.def
# FATAL:   Unable to submit build job: no authentication token, log in with `singularity remote login`
```

<a id="set-up-a-sylabs-account"></a>
##### Set up a Sylabs account
The following is not part of the FHCC tutorial and is instead text and *my notes* on material at [this page](https://docs.sylabs.io/guides/3.5/user-guide/endpoint.html).
1. Go to: https://cloud.sylabs.io/
2. Click "Sign in to Sylabs" and follow the sign in steps.
	- Linked Sylabs to my [GitHub account](https://github.com/kalavattam)
	- Sylabs username is `kalavattam`
3. ~~Click on your login ID (same and updated button as the sign-in one).~~ Log in.
4. Select “Access Tokens” from the ~~drop down~~ menu.
5. Enter a name for your new access token, such as “test token”
    - Named it "`test-token`"
6. Click the "Create Access Token" button.
    - The following was printed to the [browser]()
7. Click "Copy Token to Clipboard" ~~from the "New API Token" page~~.
    - Also, downloaded the token to `~/Downloads/_Kris` as `sylabs-token_test-token.txt`
8. Run `singularity remote login` and [paste the access token at the prompt]().

```bash
#CONTINUE
singularity remote login  # Paste token at prompt 'API Key:'
# INFO:    Authenticating with default remote.
# Generate an API Key at https://cloud.sylabs.io/auth/tokens, and paste here:
# API Key:
# INFO:    API Key Verified!
```

<a id="try-building-again"></a>
##### *Try building again*
```bash
#CONTINUE
singularity build --remote my_r_container.sif my.r.singularity.build.def
#NOTE  Building took >10 minutes

# ...  # (A massive amount of text...)
# ERROR: dependencies ‘usethis’, ‘pkgdown’, ‘rcmdcheck’, ‘roxygen2’, ‘rversions’, ‘urlchecker’ are not available for package ‘devtools’
# * removing ‘/usr/local/lib/R/site-library/devtools’
#
# The downloaded source packages are in
# 	‘/tmp/Rtmp6SudoW/downloaded_packages’
# There were 17 warnings (use warnings() to see them)
# INFO:    Creating SIF file...
# INFO:    Build complete: /tmp/image-1862359741
# INFO:    Performing post-build operations
# INFO:    Generating SBOM for /tmp/image-1862359741
# INFO:    Adding SBOM to SIF
# INFO:    Calculating SIF image checksum
# INFO:    Uploading image to library...
# WARNING: Skipping container verification
# INFO:    Uploading 382403001 bytes
# INFO:    Image uploaded successfully.

#NOTE 1/3 Message was just hanging here, not providing a prompt and or exiting;
#NOTE 2/3 so, I input ^C after hitting ↵ once (besides making a newline,
#NOTE 3/3 nothing happened)

#  After inputting ^C, the following printed to terminal:
# Shutting down due to signal: interrupt
# INFO:    Build complete: my_r_container.sif
```

<a id="verify"></a>
##### Verify
¶1  
Launch the `R` editor on our new `Singularity` container with the following command: ... And then check all of the user installed `R` packages with the following command: ...

```bash
#CONTINUE
singularity exec my_r_container.sif R
# R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
# Copyright (C) 2022 The R Foundation for Statistical Computing
# Platform: x86_64-pc-linux-gnu (64-bit)
#
# R is free software and comes with ABSOLUTELY NO WARRANTY.
# You are welcome to redistribute it under certain conditions.
# Type 'license()' or 'licence()' for distribution details.
#
#   Natural language support but running in an English locale
#
# R is a collaborative project with many contributors.
# Type 'contributors()' for more information and
# 'citation()' on how to cite R or R packages in publications.
#
# Type 'demo()' for some demos, 'help()' for on-line help, or
# 'help.start()' for an HTML browser interface to help.
# Type 'q()' to quit R.
#
# >
```
```R
#CONTINUE
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)
```
<details>
<summary><i>The following was printed to terminal:</i></summary>

```txt
     Package Version
     askpass     1.1
   base64enc   0.1-3
        brew   1.0-8
        brio   1.1.3
       bslib   0.4.1
      cachem   1.0.6
       callr   3.7.3
         cli   3.4.1
       clipr   0.8.0
  commonmark   1.8.1
       cpp11   0.4.3
      crayon   1.5.2
        desc   1.4.2
     diffobj   0.3.5
      digest  0.6.30
     downlit   0.4.2
    ellipsis   0.3.2
    evaluate    0.18
       fansi   1.0.3
     fastmap   1.1.0
 fontawesome   0.4.0
          fs   1.5.2
    gitcreds   0.1.2
        glue   1.6.2
       highr     0.9
   htmltools   0.5.3
 htmlwidgets   1.5.4
      httpuv   1.6.6
         ini   0.3.1
   jquerylib   0.1.4
    jsonlite   1.8.3
       knitr    1.41
       later   1.3.0
   lifecycle   1.0.3
    magrittr   2.0.3
     memoise   2.0.1
        mime    0.12
      miniUI 0.1.1.1
      pillar   1.8.1
    pkgbuild   1.3.1
   pkgconfig   2.0.3
     pkgload   1.3.2
      praise   1.0.0
 prettyunits   1.1.1
    processx   3.8.0
     profvis   0.3.7
    promises 1.2.0.1
          ps   1.7.2
       purrr   0.3.5
          R6   2.5.1
    rappdirs   0.3.3
        Rcpp   1.0.9
    rematch2   2.1.2
     remotes   2.4.2
       rlang   1.0.6
   rmarkdown    2.18
   rprojroot   2.0.3
  rstudioapi    0.14
        sass   0.4.3
 sessioninfo   1.2.2
       shiny   1.7.3
 sourcetools   0.1.7
     stringi   1.7.8
     stringr   1.4.1
         sys   3.4.1
    testthat   3.1.5
      tibble   3.1.8
     tinytex    0.42
        utf8   1.2.2
       vctrs   0.5.1
       waldo   0.4.0
     whisker     0.4
       withr   2.5.0
        xfun    0.35
       xopen   1.0.0
      xtable   1.8-4
        yaml   2.3.6
         zip   2.2.2
      docopt   0.7.1
     littler  0.3.16
```
</details>

```R
#CONTINUE
quit()
# Save workspace image? [y/n/c]: n
```

¶2  
We can now see all of the newly installed `R` libraries. There are two `R` libraries in the base `R` `Docker` container&mdash;now you should see many more than that.

<a id="access-to-storage"></a>
### Access to Storage
¶1  
Storage on the host where you are running the container can be made available via a bind command into the container. Many local paths are bound into the container by default. For example, the current working directory and your home are available in the container by default.

¶2  
When I indicate "local path", I am including network paths mounted locally&mdash;so even though fast and scratch are not technically local to the host, they appear local.

¶3  
If you need access to other storage paths (e.g., `/fh/scratch`, `/fh/fast`) you will need to provide mount points (directories) in the container and explicitly bind paths to those mount points as part of running the container. Note that your HutchNet ID will need permissions to this storage, but root privileges are not necessary.

<a id="example-bind-local-file-systems"></a>
#### Example: Bind Local File Systems
¶4  
In this example, we'll make the biodata files maintained by `Shared Resources` available in our container on the path `/mnt/data`.

<a id="create-mount-points"></a>
##### Create Mount Points
¶5  
Modify the definition file we created earlier (`my.r.singularity.build.def`), adding a command to the `%post` section to create the directory where we will mount biodata:
```txt
BootStrap: docker
From: r-base

%post
R --no-echo -e 'install.packages("devtools", repos="https://cloud.r-project.org/")'
mkdir -p /mnt/data
```
```bash
#CONTINUE
ls -lhaFG my.r.singularity.build.def
# -rw-rw---- 1 kalavatt 122 Nov 23 08:14 my.r.singularity.build.def

echo "mkdir -p /mnt/data" >> my.r.singularity.build.def
vi my.r.singularity.build.def  # Looks the same as above
```
<a id="rebuild"></a>
##### Rebuild
¶6  
Rebuild the container as above:

```bash
#CONTINUE
singularity build --remote my_r_container.sif my.r.singularity.build.def
# Build target already exists. Do you want to overwrite? [N/y] y

# INFO:    Starting build...
# INFO:    Setting maximum build duration to 1h0m0s
# INFO:    Remote "cloud.sylabs.io" added.
# INFO:    Access Token Verified!
# INFO:    Token stored in /root/.singularity/remote.yaml
# INFO:    Remote "cloud.sylabs.io" now in use.
# INFO:    Starting build...
# Getting image source signatures
# Copying blob sha256:36a417257f633cd58de6c3b59ec8c55c5bb04296fa387da3daa9cc1cba037116
# Copying blob sha256:ebbe46658ae1eddd748e3222cbc9dd7109f9fd7f279a4b2f9d6a32d0a58b4c16
# Copying blob sha256:48f11b798771daf119baa7f2f3d5b9c4363b0aec5d12e488fbb2e07a0cf0be79
# Copying blob sha256:ced6bc7d0fb644dbcbeecc374d4904ae5df8f303707c30aa60514e3d929fd644
# Copying blob sha256:b6e2154a522a29fd10fe63922ee826f4d42e1e474ad08bc2f8c71e811e7f0127
# Copying blob sha256:ae8780930e7e7b18116589a863916682a85c45bec3c738dab17f8740830988b5
# Copying config sha256:935885ce101110cb4f94cbce7784d9536f3d26ff65e4017d141f6e0b80ede0f6
# Writing manifest to image destination
# Storing signatures
# 2022/11/23 17:20:21  info unpack layer: sha256:ebbe46658ae1eddd748e3222cbc9dd7109f9fd7f279a4b2f9d6a32d0a58b4c16
# 2022/11/23 17:20:24  info unpack layer: sha256:ae8780930e7e7b18116589a863916682a85c45bec3c738dab17f8740830988b5
# 2022/11/23 17:20:24  info unpack layer: sha256:48f11b798771daf119baa7f2f3d5b9c4363b0aec5d12e488fbb2e07a0cf0be79
# 2022/11/23 17:20:24  info unpack layer: sha256:ced6bc7d0fb644dbcbeecc374d4904ae5df8f303707c30aa60514e3d929fd644
# 2022/11/23 17:20:24  info unpack layer: sha256:b6e2154a522a29fd10fe63922ee826f4d42e1e474ad08bc2f8c71e811e7f0127
# 2022/11/23 17:20:24  info unpack layer: sha256:36a417257f633cd58de6c3b59ec8c55c5bb04296fa387da3daa9cc1cba037116
# INFO:    Running post scriptlet
# ...  # (Mountains of text printed to screen)
# ...  # (Text is mostly from compiling/gcc)
# ...
# ERROR: dependencies ‘usethis’, ‘pkgdown’, ‘rcmdcheck’, ‘roxygen2’, ‘rversions’, ‘urlchecker’ are not available for package ‘devtools’
# * removing ‘/usr/local/lib/R/site-library/devtools’
#
# The downloaded source packages are in
# 	‘/tmp/RtmpCkV9WN/downloaded_packages’
# There were 17 warnings (use warnings() to see them)
# + mkdir -p /mnt/data
# INFO:    Creating SIF file...
# INFO:    Build complete: /tmp/image-294748900
# INFO:    Performing post-build operations
# INFO:    Generating SBOM for /tmp/image-294748900
# INFO:    Adding SBOM to SIF
# INFO:    Calculating SIF image checksum
# INFO:    Uploading image to library...
# WARNING: Skipping container verification
# INFO:    Uploading 382403000 bytes
# INFO:    Image uploaded successfully.
# Shutting down due to signal: interrupt
#
#
#
# ^CINFO:    Build complete: my_r_container.sif
```

*After inputting `^C` and waiting several minutes, still no exit, so input `↵ ↵ ↵ ^C`; was still left waiting... It completed after some 10 minutes; seems you just have to wait*

<a id="run-with-bind"></a>
##### Run with Bind
Once the container has been rebuilt, we just need to run the container, adding additional instructions to bind the local path (on the host where you are running `Singularity`) to the directory we created.

There are two ways to bind these paths into the container&mdash;on the command line: `$ singularity exec --bind /shared/biodata:/mnt/data my_r_container.sif R`  
...or via environment variables:

```bash
#EXAMPLEFROMTUTORIAL
export SINGULARITY_BIND=/shared/biodata:/mnt/data
singularity exec my_r_container.sif R
```

<a id="verify-1"></a>
##### Verify
You can verify the bind of those paths with shell. Start a shell in the container and run:

```bash
#CONTINUE
export SINGULARITY_BIND=/shared/biodata:/mnt/data
singularity shell my_r_container.sif
#  Have a new kind of prompt now: Singularity> 

ls /mnt/data
# example_data  gmap-gsnap  humandb  microbiome  ncbi-blast  ngs	seq  tmp

t="/mnt/data"
ls -lhaFG $t
# total 0
# drwxr-xr-x 11 root  0 Sep 10 16:02 ./
# drwxr-xr-x  3 root 27 Nov 23 09:33 ../
# dr-xr-xr-x  2 root  0 Sep 10 16:02 example_data/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 gmap-gsnap/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 humandb/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 microbiome/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 ncbi-blast/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 ngs/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 reference/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 seq/
# dr-xr-xr-x  2 root  0 Sep 10 16:02 tmp

cd $t/example_data
pwd
/mnt/data/example_data

ls -lhaFG
# total 160K
# drwxrwsr-x  4 59162  80 Apr 19  2021 ./
# drwxr-xr-x 11 root    0 Sep 10 16:02 ../
# drwxrwsr--  4 59162  46 Mar 18  2021 data/
# -rw-rw-r--  1 59162 264 Mar 18  2021 README.md
# drwxrwsr--  2 59162   0 Apr 19  2021 rna_seq_class/

#  Interesting...
exit
#  Loss of new prompt (Singularity> )

ls /mnt/data
# ls: cannot access '/mnt/data': No such file or directory

singularity shell my_r_container.sif
ls /mnt/data
# example_data  gmap-gsnap  humandb  microbiome  ncbi-blast  ngs	reference  seq	tmp

ls
# bbmap	   genomes	      miniconda3	  my.r.singularity.build.def  r-base-latest.sif  tsukiyamalab
# Downloads  lolcow_latest.sif  my_r_container.sif  picardmetrics.conf	      src

exit

echo $t
# 
#  Makes sense: variable 't' is not in the main shell; it was in the
#+ Singularity shell

singularity shell my_r_container.sif
t="/mnt/data"
cd $t
ls -lhaFG
total 32K
# drwxr-xr-x 11 root   0 Sep 10 16:02 ./
# drwxr-xr-x  3 root  27 Nov 23 09:33 ../
# drwxrwsr-x  4 59162 80 Apr 19  2021 example_data/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 gmap-gsnap/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 humandb/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 microbiome/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 ncbi-blast/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 ngs/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 reference/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 seq/
# dr-xr-xr-x  2 root   0 Sep 10 16:02 tmp/

cd seq
# total 320K
# drwxrwsr-x  4 37019  48 Sep  8  2016 ./
# drwxr-xr-x 11 root    0 Sep 10 16:02 ../
# drwxrwsr-x  3 37019 23K Jul 12  2021 blastdb/
# drwxr-sr-x  3 37019  22 Feb  4  2016 Broad/

exit
```

<a id="the-build-environment"></a>
### The Build Environment
<a id="the-image-cache"></a>
#### The Image Cache
¶1  
Singularity caches data to speed future operations. By default, the cache is in your home directory in a directory named `.singularity`. This cache can be moved depending on your need&mdash;this can be controlled with the environment variable `SINGULARITY_CACHEDIR`.
```bash
#EXAMPLEFROMTUTORIAL
export SINGULARITY_CACHEDIR=${HOME}/.my_cachedir
singularity build my.r.singularity.build.def
```

¶2  
Note that you will need to set this environment variable every time you wish to use this cache path.

<a id="build-temporary-files"></a>
#### Build Temporary Files
¶1  
Two environment variables (and one command-line option) can be used to control where the build is done. This includes extraction of the various downloads and other build steps necessary to create the container.

¶2  
The command line option `--tmpdir` takes precedence over the environment variables:
```bash
#EXAMPLEFROMTUTORIAL
singularity build --tmpdir=${HOME}/tmp my.r.singularity.build.def
```

¶3  
<mark>The environment variables `SINGULARITY_TMPDIR` and `TMPDIR` are used if the command line option isn't set. `SINGULARITY_TMPDIR` takes precedence over `TMPDIR`</mark>.

IMPORTANT: If you set this build directory path to a location in the Scratch file system, you may encounter errors like "operation not permitted" when building the container. This file system does not support file operations used by some container builds (e.g., hard links and some attributes).

<a id="related-fhcc-bioinformatics-links"></a>
### Related FHCC Bioinformatics links
- [Using Docker at Fred Hutch](https://sciwiki.fredhutch.org/compdemos/Docker/)
	+ [On the SciComp Test Environment](https://sciwiki.fredhutch.org/compdemos/Docker/#on-the-scicomp-test-environment)
		* "You can deploy your own docker machine on the `Proxmox` virtual test environment in *ca* 60 sec using the `prox` command. This environment uses multiple large memory machines (16 cores, 384GB memory each) which are re-purposed previous generation `Rhino` class machines."
	+ [Using pre-made Docker images with application stacks](https://sciwiki.fredhutch.org/compdemos/Docker/#using-pre-made-docker-images-with-application-stacks)
	+ [Create your own Docker image and put your software inside](https://sciwiki.fredhutch.org/compdemos/Docker/#create-your-own-docker-image-and-put-your-software-inside)
- [General information about Docker and its use at FHCC](https://sciwiki.fredhutch.org/scicomputing/compute_environments/#docker-containers)
- [Building Software Containers (Hutch Data Core)](https://sciwiki.fredhutch.org/hdc/hdc_building_containers/)
<br />
<br />

<a id="follow-up-question-to-brian-haas"></a>
## Follow-up question to Brian Haas
- The message and response are at [this link](https://groups.google.com/g/trinityrnaseq-users/c/DWctG7wLNYY)  
- `#TODO` Get these messages into a suitable location in `work-Trinity.md`

<a id="message-from-me-2022-1122"></a>
### Message from me (2022-1122)
Thanks again for the advice and input. For genome-guided assembly that leverages multimapped reads, I'm using a bam file from having run STAR like this:
```bash
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMattributes All \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1000 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
```
With the parameter `--outFilterMultimapNmax 1000`, the vast majority of multimapping alignments remain in the bam outfile from STAR. I just want to make sure I'm not missing or misinterpreting anything you've communicated in this thread: is this bam suitable for genome-guided assembly that makes use of multimapped reads?

Thanks,  
Kris

<a id="response-from-brian-haas-2022-1122"></a>
### Response from Brian Haas (2022-1122)
Trinity should work with whatever coordinate-sorted bam you give it, but I question the need for including so many multimapping reads. The main use of having multimappmers included is to handle cases where you have a handful of paralogs that might benefit from having shared read content represented at each locus.
<br />
<br />

<a id="working-out-pipelines-todo-lists-etc"></a>
## Working out pipelines, `#TODO` lists, etc.
<a id="list-of-todos-written-on-2022-1120"></a>
### List of `#TODO`s written on 2022-1120
Has been put on hold until I get hands-on experience with preprocessing, `Trinity`-`PASA`, etc.
<img src="notebook/TODO.2022-1120.jpg" alt="drawing" width="750">

<a id="preprocessing-pipeline-rough-draft-2022-1121"></a>
### Preprocessing pipeline rough draft, 2022-1121
<img src="notebook/pipelines.2022-1121.preprocessing-rough.jpg" alt="drawing" width="750">

<a id="subsequent-pipeline-draft-2022-1121"></a>
### Subsequent pipeline draft, 2022-1121
Includes preprocessing and Trinity-PASA work
<img src="notebook/pipelines.2022-1121.preprocessing_Trinity.jpg" alt="drawing" width="750">

<a id="building-on-the-pipeline-draft-and-reflecting-on-next-steps-etc-2022-1122"></a>
### Building on the pipeline draft and reflecting on next steps, etc., 2022-1122
<img src="notebook/pipelines.2022-1122.preprocessing_Trinity.1.jpg" alt="drawing" width="750">
<img src="notebook/pipelines.2022-1122.preprocessing_Trinity.2.jpg" alt="drawing" width="750">

<a id="excel-file-used-for-parameterization"></a>
### Excel file used for parameterization
Excel file...  
[Excel file for Trinity parameters to use and potentially test](notebook/trinity-parameters.xlsx)
<br />
<br />

<a id="installing-pasa-and-trinity-with-singularity"></a>
## Installing `PASA` and `Trinity` with `Singularity`

<details>
<summary><i>Failed attempt to use spython to install PASA</i></summary>

```bash
#!/bin/bash
#DONTRUN #REMOTE

#  Get started ----------------------------------------------------------------
grabnode  # Lowest and default settings

pwd
# /home/kalavatt

ml Singularity
# # module list
# Currently Loaded Modules:
#   1) Go/1.14   2) Singularity/3.5.3


#  Create a directory for *.simg files, Dockerfiles, etc.; store them there ---
ls -lhaFG
# ...

mkdir -p singularity-docker-etc/PASA

mv *.sif *.def singularity-docker-etc/
# renamed 'lolcow_latest.sif' -> 'singularity-docker-etc/lolcow_latest.sif'
# renamed 'my_r_container.sif' -> 'singularity-docker-etc/my_r_container.sif'
# renamed 'r-base-latest.sif' -> 'singularity-docker-etc/r-base-latest.sif'
# renamed 'my.r.singularity.build.def' -> 'singularity-docker-etc/my.r.singularity.build.def'


#  Get the Dockerfile for PASA, then build a Singularity image from it --------
cd singularity-docker-etc/PASA

curl https://raw.githubusercontent.com/PASApipeline/PASApipeline/master/Docker/Dockerfile \
	> Dockerfile
curl https://raw.githubusercontent.com/PASApipeline/PASApipeline/master/Docker/conf.txt \
	> conf.txt

#  Follow the instructions here for building the image:
#+ stackoverflow.com/questions/60314664/how-to-build-singularity-container-from-dockerfile
#+
#+ In particular, see answer #2, which makes use of the package `spython`
#+ (Singularity Python), which can be obtained and installed via conda
Trinity_env
mamba install -c conda-forge spython

if [[ -f PASA.def ]]; then rm PASA.def; fi
spython recipe Dockerfile &> PASA.def
# vi PASA.def
#  Looks normal enough...

singularity build --remote PASA.sif PASA.def
# INFO:    Access Token Verified!
# INFO:    Token stored in /root/.singularity/remote.yaml
# INFO:    Remote "cloud.sylabs.io" now in use.
# INFO:    Starting build...
# Getting image source signatures
# Copying blob sha256:eaead16dc43bb8811d4ff450935d607f9ba4baffda4fc110cc402fa43f601d83
# Copying config sha256:498ea54ecd93159ae59a589d67d98eee003628516c0679a65ca60d03abfd744a
# Writing manifest to image destination
# Storing signatures
# 2022/11/23 19:43:37  info unpack layer: sha256:eaead16dc43bb8811d4ff450935d607f9ba4baffda4fc110cc402fa43f601d83
# INFO:    Copying conf.txt to /usr/local/src/PASApipeline/pasa_conf/
# FATAL:   While performing build: unable to copy files from host to container fs: no source files found matching: conf.txt
# FATAL:   While performing build: build image size <= 0

# # vi PASA.def
# Bootstrap: docker
# From: ubuntu:20.04
# Stage: spython-base
#
# %files
# conf.txt /usr/local/src/PASApipeline/pasa_conf/
# %labels
# maintainer="bhaas@broadinstitute.org"
# %post
#  ...


#  stackoverflow.com/questions/11145270/how-to-replace-an-entire-line-in-a-text-file-by-line-number
cp PASA.def bak.PASA.def
sed -i '6s/.*/conf.txt \./' PASA.def
# # vi PASA.def
# Bootstrap: docker
# From: ubuntu:20.04
# Stage: spython-base
#
# %files
# conf.txt .
# %labels
# maintainer="bhaas@broadinstitute.org"
# %post

singularity build --remote PASA.sif PASA.def
# INFO:    Starting build...
# INFO:    Setting maximum build duration to 1h0m0s
# INFO:    Remote "cloud.sylabs.io" added.
# INFO:    Access Token Verified!
# INFO:    Token stored in /root/.singularity/remote.yaml
# INFO:    Remote "cloud.sylabs.io" now in use.
# INFO:    Starting build...
# Getting image source signatures
# Copying blob sha256:eaead16dc43bb8811d4ff450935d607f9ba4baffda4fc110cc402fa43f601d83
# Copying config sha256:498ea54ecd93159ae59a589d67d98eee003628516c0679a65ca60d03abfd744a
# Writing manifest to image destination
# Storing signatures
# 2022/11/23 19:51:38  info unpack layer: sha256:eaead16dc43bb8811d4ff450935d607f9ba4baffda4fc110cc402fa43f601d83
# INFO:    Copying conf.txt to .
# FATAL:   While performing build: unable to copy files from host to container fs: no source files found matching: conf.txt
# FATAL:   While performing build: build image size <= 0

#  This is not working...

```
</details>
<br />

<details>
<summary><i>Local installation of PASA with Docker</i></summary>

Try installing `PASA` locally via `Docker` to see if this gives any insight into building it with `Singularity` on the HPC; following the instructions [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_Docker)
```bash
#!/bin/bash
#DONTRUN #LOCAL

docker pull pasapipeline/pasapipeline
# Using default tag: latest
# latest: Pulling from pasapipeline/pasapipeline
# 16ec32c2132b: Pull complete
# b7372f0e4c7e: Pull complete
# 4b6435ab903e: Pull complete
# bb3ed4ec7a4c: Pull complete
# a43d589f1366: Pull complete
# aa307d929b17: Pull complete
# d3c331b9da8c: Pull complete
# 39c12f722616: Pull complete
# a67b60493205: Pull complete
# ea4c9a29c838: Pull complete
# 95726cd7985a: Pull complete
# Digest: sha256:1b190dba4d1493c11677f90b683437e9c5531e2fe7105d8c46a21d8b3e521878
# Status: Downloaded newer image for pasapipeline/pasapipeline:latest
# docker.io/pasapipeline/pasapipeline:latest

#  Below, just pasting the text and commands from Brian Haas regarding Docker
#+ installation; haven't actually tested the following:

#  Here, $base_dir corresponds to the working directory that contains your
#+ input data; replace $base_dir with your actual directory name (don't use it
#+ as a variable)
docker run --rm -it -v /tmp:/tmp -v $base_dir:$base_dir \
    pasapipeline/pasapipeline:latest \
    bash -c \
    	'cd /$base_dir \
    	&& /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            -c alignAssembly.conf -C -R \
            --ALIGNER gmap -g genome.fa -t transcripts.cdna.fasta'

#  And just to give you a concrete example of how I do this in my own
#+ environment (with paths specified according to my project structure), my own
#+ Docker command for running PASA on the provided sample data is:
docker run --rm -it \
	-v /tmp:/tmp \
	-v /home/bhaas/GITHUB/pasapipeline/sample_data:/home/bhaas/GITHUB/pasapipeline/sample_data \
	pasapipeline/pasapipeline:latest \
    	bash -c 'cd /home/bhaas/GITHUB/pasapipeline/sample_data \
        	&& /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
        		-c sqlite.confs/alignAssembly.config -C -R \
        		--ALIGNER gmap -g genome_sample.fasta -t all_transcripts.fasta.clean'
```
</details>
<br />

<details>
<summary><i>Successful installation of PASA with Docker</i></summary>

Also, I found [this page for `PASA` on dockerhub](https://hub.docker.com/r/pasapipeline/pasapipeline); can I use `pasapipeline` like this?
```bash
#EXAMPLEFROMME
#  Referencing this line from the FHCC Bioinformatics Singularity tutorial:
#+ singularity build r-base-latest.sif docker://r-base

singularity build PASA.sif docker://pasapipeline
```

Let's test the above on remote:
```bash
#!/bin/bash
#DONTRUN #REMOTE

pwd
# /home/kalavatt/singularity-docker-etc/PASA

cd ..
singularity build PASA.sif docker://pasapipeline
# INFO:    Starting build...
# WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
# FATAL:   While performing build: conveyor failed to get: Error reading manifest latest in docker.io/library/pasapipeline: errors:
# denied: requested access to the resource is denied
# unauthorized: authentication required

singularity build PASA.sif docker://pasapipeline/pasapipeline
#  Wow, this seems to work...
```

<details>
<summary><i>The following was printed to screen:</i></summary>

```txt
INFO:    Starting build...
WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
Getting image source signatures
Copying blob 16ec32c2132b done
Copying blob b7372f0e4c7e done
Copying blob 4b6435ab903e done
Copying blob bb3ed4ec7a4c done
Copying blob a43d589f1366 done
Copying blob aa307d929b17 done
Copying blob d3c331b9da8c done
Copying blob 39c12f722616 done
Copying blob a67b60493205 done
Copying blob ea4c9a29c838 done
Copying blob 95726cd7985a done
Copying config ce2f32de0d done
Writing manifest to image destination
Storing signatures
2022/11/23 12:12:10  info unpack layer: sha256:16ec32c2132b43494832a05f2b02f7a822479f8250c173d0ab27b3de78b2f058
2022/11/23 12:12:11  info unpack layer: sha256:b7372f0e4c7ee23a71e6a0f593be74d2321d238c350a1df9c1d61aa58800fd22
2022/11/23 12:12:15  warn rootless{usr/lib/x86_64-linux-gnu/gstreamer1.0/gstreamer-1.0/gst-ptp-helper} ignoring (usually) harmless EPERM on setxattr "security.capability"
2022/11/23 12:12:20  info unpack layer: sha256:4b6435ab903e01b7398998984b10e581dbce325ad66396a0e326e12460844caf
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/Build.PL} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/Changes} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/MANIFEST} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/META.yml} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/lib/Test/Fork.pm} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/t/failed_fork.t} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/t/fork.t} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  warn rootless{root/.cpanm/work/1643904065.8/Test-Fork-0.02/t/fork_ok_return.t} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:12:21  info unpack layer: sha256:bb3ed4ec7a4cc746aa3c8bd891fc5870238b5599c9ff4ce4c2bbab601d1960a0
2022/11/23 12:12:25  info unpack layer: sha256:a43d589f13668fc35a3baf6832f589cb0fe4e7518db270a596f3f02e1bcd4ac8
2022/11/23 12:12:25  info unpack layer: sha256:aa307d929b174f503d4f2249f3fa80371c43d552839f38c5d0f7285eb6d1aed6
2022/11/23 12:12:25  info unpack layer: sha256:d3c331b9da8c9402647ac50512335f1619a41eb24da7d14654ce2414585174f5
2022/11/23 12:12:25  info unpack layer: sha256:39c12f722616abe4753e2cd68275053077282b85e487d8157960a8c38ced614c
2022/11/23 12:12:25  info unpack layer: sha256:a67b60493205a59c5f6e7227046c3238debb485a6b8d6ab617eba334d83d1f03
2022/11/23 12:12:26  info unpack layer: sha256:ea4c9a29c838c7b9ca6b99d0d834d6fde97c7439fa53087fb5ed20c28087eb05
2022/11/23 12:12:26  info unpack layer: sha256:95726cd7985a413ec09c52e32afc5c0e3eafe6a0f3580f0c8e60a4b585f816d3
INFO:    Creating SIF file...
INFO:    Build complete: PASA.sif
```
Nice!
</details>
</details>
<br />

<details>
<summary><i>Successful installation of Trinity with Docker</i></summary>

Let's do the same to install the latest version of `Trinity`
```bash
#!/bin/bash
#DONTRUN #REMOTE

pwd
# /home/kalavatt/singularity-docker-etc

singularity build Trinity.sif docker://trinityrnaseq/trinityrnaseq
```

<details>
<summary><i>The following was printed to screen:</i></summary>

```txt
INFO:    Starting build...
WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
WARN[0000] "/run/user/76178" directory set by $XDG_RUNTIME_DIR does not exist. Either create the directory or unset $XDG_RUNTIME_DIR.: stat /run/user/76178: no such file or directory: Trying to pull image in the event that it is a public image.
Getting image source signatures
Copying blob 7595c8c21622 done
Copying blob d13af8ca898f done
Copying blob 70799171ddba done
Copying blob b6c12202c5ef done
Copying blob f4c6ed5d0098 done
Copying blob 9cb0a3a9bc40 done
Copying blob 7baa9fcdfb01 done
Copying blob 7d6f46fec4a2 done
Copying blob 63db3c567bed done
Copying blob 3784ab1edb72 done
Copying blob 664a91eafeec done
Copying blob 9a378fda9b60 done
Copying blob 59711262c560 done
Copying blob 2fe84828826b done
Copying blob eb9b9daf9f62 done
Copying blob 8b8d9fb71d0a done
Copying blob 8f74c665b97f done
Copying blob 61be161bf30c done
Copying blob 5d04e4c0856c done
Copying blob 2b950511e31f done
Copying blob fb69d4b3806b done
Copying blob 1b412f3cc2a6 done
Copying blob 00d027a30155 done
Copying blob fbeb299350dc done
Copying blob 6b1dde3f4b10 done
Copying blob 14226d8bc60c done
Copying blob 3d3aa11b2963 done
Copying blob 3b2301cc97c3 done
Copying blob 0296120c2e81 done
Copying blob 2bc0b6caa553 done
Copying blob a7a7f0efc2ea done
Copying blob dd538631897b done
Copying blob 59396c340339 done
Copying blob 326a5fbf677c done
Copying blob 680af78e44da done
Copying blob db6f15ce2a38 done
Copying blob afd7b50e562c done
Copying blob e8528e82a8ac done
Copying blob 00b65cf9ea53 done
Copying blob e89b22784614 done
Copying blob eff801715fb5 done
Copying blob cadd82527c77 done
Copying blob e07d95e692e7 done
Copying blob 6732fbd5b491 done
Copying blob d4a3e63359f7 done
Copying blob 92a754a673d1 done
Copying blob 4d4d7f736c14 done
Copying blob 7a5099acf88f done
Copying blob 60cb67e04386 done
Copying blob ae240b68c5df done
Copying blob 4ccb2730c7ea done
Copying blob edd1035dba16 done
Copying blob ae1fe7a9f49f done
Copying config 27124e93cc done
Writing manifest to image destination
Storing signatures
2022/11/23 12:21:29  info unpack layer: sha256:7595c8c21622ea8a8b9778972e26dbbe063f7a1c4b0a28a80a34ebb3d343b586
2022/11/23 12:21:30  info unpack layer: sha256:d13af8ca898f36af68711cb67c345f65046a78ccd802453f4b129adf9205b1f8
2022/11/23 12:21:30  info unpack layer: sha256:70799171ddba93a611490ba3557d782714b3f4da8963d49ac8726786ba8274a5
2022/11/23 12:21:30  info unpack layer: sha256:b6c12202c5ef07dc9eb8f9d9e71407064684ed70f8c4040b62679b7d30200840
2022/11/23 12:21:30  info unpack layer: sha256:f4c6ed5d0098d3932a973210d66408f367a04a6bc2916a6c379e62112f818392
2022/11/23 12:21:49  info unpack layer: sha256:9cb0a3a9bc40f9933d1e613c78bec11ab98ca8c5fae29bce816d425e9ef3d5fe
2022/11/23 12:21:49  info unpack layer: sha256:7baa9fcdfb01d850e10993c4fb4c84d5f945e7ff3d53c07a461ff545b48e5f5d
2022/11/23 12:21:49  info unpack layer: sha256:7d6f46fec4a2223ac6733a95823af482265ddc825cfd018b53bd652a93b60c86
2022/11/23 12:21:49  info unpack layer: sha256:63db3c567bed6c69b58dbe27a13ff8bdc81a18f390b2eb1941a10b01adf5e292
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/KernSmooth.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/MASS.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/Matrix.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/boot.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/class.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/cluster.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/codetools.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/foreign.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/lattice.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/mgcv.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/nlme.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/nnet.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/rpart.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/spatial.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:52  warn rootless{usr/local/src/R-3.6.3/src/library/Recommended/survival.tgz} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:54  warn rootless{usr/local/src/R-3.6.3/tests/Pkgs/pkgA} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2022/11/23 12:21:54  info unpack layer: sha256:3784ab1edb726131da34954257089e864dd84a865b4967a5a57bfed323167a98
2022/11/23 12:21:54  info unpack layer: sha256:664a91eafeec75e33121852cabf162a27448a0d29e4a16b0c076442584ea226c
2022/11/23 12:21:58  info unpack layer: sha256:9a378fda9b60decad911d6959e0dd1ef6c774e5bd66234533bf17103a357e70d
2022/11/23 12:21:58  info unpack layer: sha256:59711262c560c2a49ebd07abb56ecaed92f3f722db39d307fae501579ba35175
2022/11/23 12:22:00  info unpack layer: sha256:2fe84828826bf9abcafd6f22e78004bb730000fd596b879cbe872ecf3884c2ec
2022/11/23 12:22:00  info unpack layer: sha256:eb9b9daf9f624401cf16fb891e0dca7c2f7a7d45d7816b7f475f84df1eb76261
2022/11/23 12:22:00  info unpack layer: sha256:8b8d9fb71d0a462deb7e6c433f50b60df01c382662ddbab262ca8ea03210bbf4
2022/11/23 12:22:00  info unpack layer: sha256:8f74c665b97f947ceddfc8d8da574fcc0a317895ab4bbe474fd03da879bc5047
2022/11/23 12:22:00  info unpack layer: sha256:61be161bf30c829eeea071daed9174a071d433185b65b9736174eeef8406afd3
2022/11/23 12:22:00  info unpack layer: sha256:5d04e4c0856cb2803ac512294e748cf31c46a016674c377e9a61deb275e00cef
2022/11/23 12:22:03  info unpack layer: sha256:2b950511e31f9ac307000c0d4f98d4a625c836a91dd80e050f98838acf355aea
2022/11/23 12:22:03  info unpack layer: sha256:fb69d4b3806bc01ab6a38d08027b6a41ef23709f44f37daaebcde25d5cb6e10e
2022/11/23 12:22:03  info unpack layer: sha256:1b412f3cc2a64f62e7c0cdaf2f37422c980c6e05eeffc0ab8e113cb57997c610
2022/11/23 12:22:03  info unpack layer: sha256:00d027a30155c6b9a89cfc5bd0caa7215fcb1a9a8aca393ba4b966c0cff7431c
2022/11/23 12:22:03  info unpack layer: sha256:fbeb299350dc0903aae4e48763e9704177687d21a9a903a18c116d4d1209da52
2022/11/23 12:22:03  info unpack layer: sha256:6b1dde3f4b108c906c939fc88b7b7a252cd360b9fff6b5dd6c44ace1e743699b
2022/11/23 12:22:03  info unpack layer: sha256:14226d8bc60ccbd8eccbe03de9b9e5897204b72d42fe9b4a7f7498e30f6a7ad2
2022/11/23 12:22:03  info unpack layer: sha256:3d3aa11b29638e279fcd301d2297f25ab72dac7c7b5a9f63c3e80220775aabc8
2022/11/23 12:22:07  info unpack layer: sha256:3b2301cc97c3edfbebbbccc01652902e586d19eee9000e72934cd762766e5f39
2022/11/23 12:22:07  info unpack layer: sha256:0296120c2e81e492da10dbbb0b7ce1fa940615f7d6c24ef37b4fda29e596dcf6
2022/11/23 12:22:07  info unpack layer: sha256:2bc0b6caa553e8733d199a3bc7ac43964d34f7b5df21c057da5fe1085b952cc2
2022/11/23 12:22:07  info unpack layer: sha256:a7a7f0efc2ea63694b3416783bdb864534b6435415e3d783755dee1b45be6b7a
2022/11/23 12:22:09  info unpack layer: sha256:dd538631897ba38d902137463f30780fdd4905e7a81ac411b8d8a9e805726270
2022/11/23 12:22:09  info unpack layer: sha256:59396c340339614cb39962074d3aef069f84f241f3be86db3b6d9c4649452655
2022/11/23 12:22:11  info unpack layer: sha256:326a5fbf677c9008863d5fc4be815631dfe37312b4ccd8d773b3a0e30e0beec4
2022/11/23 12:22:11  info unpack layer: sha256:680af78e44da976173aff4b7516e2d362e76d5b62271de9f0e0145758b164df3
2022/11/23 12:22:11  info unpack layer: sha256:db6f15ce2a3806452b698fc537092af83058c4a52bd21c7a989f1b73f22b69b7
2022/11/23 12:22:12  info unpack layer: sha256:afd7b50e562c22fd41d55a337e60f965493aa884e3e50e78bc756755412378d1
2022/11/23 12:22:12  info unpack layer: sha256:e8528e82a8ac10dee2bd3853846e979e5c9d387437aaa020b03497f82a5d6fc2
2022/11/23 12:22:21  info unpack layer: sha256:00b65cf9ea53ec464002334bcab47cd1ee819d613525959bf5a3a350b5a89181
2022/11/23 12:22:23  info unpack layer: sha256:e89b227846144f52c392ff4aef91c7dd21d8486b9de24a5079221444e38917a7
2022/11/23 12:22:24  info unpack layer: sha256:eff801715fb533409a906810eeb3305cb33a00b19ed05317353987b7d1812b81
2022/11/23 12:22:25  info unpack layer: sha256:cadd82527c772403be78dc39d019c21723b91cd4e3de063569f1fe98616b3535
2022/11/23 12:22:26  info unpack layer: sha256:e07d95e692e7097ea93a8709fbf7eaa26e7958cd3b64c5a4dd0321f224a35d27
2022/11/23 12:22:29  info unpack layer: sha256:6732fbd5b491b835c7960550cc6f5e8ff7f2fb666749f5581e095e679abe7909
2022/11/23 12:22:33  info unpack layer: sha256:d4a3e63359f7017c9d946bdb9c146b609d2dcb4b5c9ac842d8750ccecc81f599
2022/11/23 12:22:33  info unpack layer: sha256:92a754a673d171329ca5436d96b497ff33818f2562ffa4de8d08431a462dae58
2022/11/23 12:22:33  info unpack layer: sha256:4d4d7f736c14c4fcf99578ccc5fc826fdd985a028db2df445999b5579fd8212d
2022/11/23 12:22:41  info unpack layer: sha256:7a5099acf88f131a9867c3942024ef388aae98fed54720974a280be2869d001d
2022/11/23 12:22:41  info unpack layer: sha256:60cb67e043863d56fd05e681ded707b40873728e41ea3cbc416ae92c50996dfe
2022/11/23 12:22:43  info unpack layer: sha256:ae240b68c5dff1dd383cbe8943905592709b676e4e28fba9ef772269b80d3665
2022/11/23 12:22:46  info unpack layer: sha256:4ccb2730c7ea530893c4bd9076217b7bb3554e5b374cdd1e9ecf6ef659c8abe3
2022/11/23 12:22:46  info unpack layer: sha256:edd1035dba16da6ac7979c5753e934c7c7de508fa14b6ee73667d31066af3cd4
2022/11/23 12:22:46  info unpack layer: sha256:ae1fe7a9f49feb17c39ae199bd7d7bfe20138df9d49dce9dedaab80cfb3ee721
INFO:    Creating SIF file...
INFO:    Build complete: Trinity.sif
```
Nice!
</details>
</details>
<br />

<a id="more-details-and-instructions-for-using-pasa-with-docker"></a>
### More details and instructions for using PASA with Docker

<a id="example-with-test-data"></a>
#### Example with test data
...taken from [this GitHub Wiki page](https://github.com/PASApipeline/PASApipeline/wiki/PASA_Docker#example-with-test-data)

If you are going to try out the `docker run` command as `@brianjohnhaas` suggests, do so this way:

1. Let's say you are in a directory called `/home/github_pasa`
2. `git clone https://github.com/PASApipeline/PASApipeline.git`
3. You will now see `PASApipeline/` under `/home/github_pasa/`
4. Before the `docker run ...` do as follows
```bash
mkdir -p /home/work/temp
cd /home/work/
cp -r /home/github_pasa/PASApipeline/sample_data .
gunzip /home/work/sample_data/genome_sample.fasta.gz
```
5. Please <b><i>do note</i></b> that running the `docker run ...` command will add new files/folders to the `sample_data` directory at `/home/work/`
6. Run the `docker run ...` command from `/home/work`, where `<docker_image:tag>` could either be a `docker pull pasapipeline/pasapipeline:latest` or a custom `docker` built using the `Dockerfile` at the https://github.com/PASApipeline/PASApipeline/tree/master/Docker

<a id="pasadocker-execution-modes-sqlite-or-mysql"></a>
#### PASA/Docker Execution Modes (SQLite or MySQL)
...taken from [this GitHub Wiki page](https://github.com/PASApipeline/PASApipeline/wiki/PASA_Docker#pasadocker-execution-modes-sqlite-or-mysql)

<a id="docker-using-sqlite"></a>
##### Docker using SQLite
If you want to run `PASA` (align step) with `SQLITE` then do this:
```bash
docker run --rm -it \
  	-v $PWD/temp:/tmp \
	-v $PWD/sample_data:/home/bhaas/GITHUB/pasapipeline/sample_data  \
    pasapipeline/pasapipeline:latest \
        bash -c ' \
        cd /home/bhaas/GITHUB/pasapipeline/sample_data \
            && /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            	-c mysql.confs/alignAssembly.config -C -R \
            	--ALIGNER gmap -g genome_sample.fasta -t all_transcripts.fasta.clean'
```

<a id="mysql-internally-within-docker"></a>
##### MySQL internally within Docker
```bash
docker run --rm -it \
    -v $PWD/temp:/tmp \
    -v $PWD/sample_data:/home/bhaas/GITHUB/pasapipeline/sample_data  \
    pasapipeline/pasapipeline:latest \
        bash -c ' \
        cd /home/bhaas/GITHUB/pasapipeline/sample_data \
            && /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            	-c mysql.confs/alignAssembly.config -C -R \
            	--ALIGNER gmap -g genome_sample.fasta -t all_transcripts.fasta.clean'
```

<a id="local-mysql-outside-docker-container"></a>
##### Local MySQL outside Docker Container
```bash
docker run --rm -it \
    -v $PWD/temp:/tmp \
    -v $PWD/sample_data:/home/bhaas/GITHUB/pasapipeline/sample_data  \
    pasapipeline/pasapipeline:latest \
        bash -c ' \
        service mysql start \
        	&& cd /home/bhaas/GITHUB/pasapipeline/sample_data \
            && /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl \
            	-c mysql.confs/alignAssembly.config -C -R \
            	--ALIGNER gmap -g genome_sample.fasta -t all_transcripts.fasta.clean'
```

<a id="on-how-to-handle-file-inputoutput-with-singularity"></a>
## On how to handle file input/output with `Singularity`
- [Binding file in singularity](https://stackoverflow.com/questions/45755512/binding-file-in-singularity)
- [Nice breakdowns of running Singularity on cluster from Harvard FAS](https://docs.rc.fas.harvard.edu/kb/singularity-on-the-cluster/)
- See the [FHCC Bioinformatics' Singularity Access to Storage section](#access-to-storage)
- [Sylabs documentation on "Bind Paths and Mounts"](https://docs.sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html)
	+ This seems to have the answer  `#TODO` Study and test this
- [Google search results "singularity mount directory"](https://www.google.com/search?q=singularity+mount+directory&oq=mount+directory+singu&aqs=chrome.1.69i57j0i22i30.5454j0j7&sourceid=chrome&ie=UTF-8)
