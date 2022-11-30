
<br />
<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Miscellaneous](#miscellaneous)
1. [Attempts to set up an environment for `Trinity`, etc.](#attempts-to-set-up-an-environment-for-trinity-etc)
	1. [Attempt #1 \(2022-1121\)](#attempt-1-2022-1121)
	1. [Attempt #2 \(2022-1122\)](#attempt-2-2022-1122)
1. [Filtering `.bam`s to retain only *S. cerevisiae* alignments \(2022-1122\)](#filtering-bams-to-retain-only-s-cerevisiae-alignments-2022-1122)
1. [Do a trial run of `Trinity` genome-guided mode \(2022-1122\)](#do-a-trial-run-of-trinity-genome-guided-mode-2022-1122)
1. [Convert "rna-star" filtered `.bam` files back to `.fastq` files \(2022-1122\)](#convert-rna-star-filtered-bam-files-back-to-fastq-files-2022-1122)
1. [Do a trial run of `Trinity` genome-guided mode \(2022-1122\)](#do-a-trial-run-of-trinity-genome-guided-mode-2022-1122-1)
1. [Organizing the `*.{err,out}.txt` from the trial runs](#organizing-the-errouttxt-from-the-trial-runs)
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
1. [On handling file access with `Singularity`](#on-handling-file-access-with-singularity)
	1. [Testing system-defined bind paths in `Singularity`](#testing-system-defined-bind-paths-in-singularity)
	1. [Try mounting some datasets needed for running `PASA` \(`Singularity`\)](#try-mounting-some-datasets-needed-for-running-pasa-singularity)
1. [Try a trial run of `Singularity` `PASA`](#try-a-trial-run-of-singularity-pasa)
	1. [Working through the first few steps of `PASA` Wiki \(2022-1124\)](#working-through-the-first-few-steps-of-pasa-wiki-2022-1124)
		1. [Documentation, details for `PASA`'s' `Launch_PASA_pipeline.pl`, including `*.config`](#documentation-details-for-pasas-launch_pasa_pipelinepl-including-config)
	1. [Attempt to call `Launch_PASA_pipeline.pl` \(2022-1124\)](#attempt-to-call-launch_pasa_pipelinepl-2022-1124)
		1. [Troubleshooting the errors from calling `Launch_PASA_pipeline.pl`](#troubleshooting-the-errors-from-calling-launch_pasa_pipelinepl)
			1. [Message from me \(2022-1124\)](#message-from-me-2022-1124)
			1. [Response from Brian Haas \(2022-1125\)](#response-from-brian-haas-2022-1125)
	1. [Attempt to call `Launch_PASA_pipeline.pl` following Brian Haas' advice \(2022-1125\)](#attempt-to-call-launch_pasa_pipelinepl-following-brian-haas-advice-2022-1125)
		1. [Again, troubleshooting the errors from calling `Launch_PASA_pipeline.pl`](#again-troubleshooting-the-errors-from-calling-launch_pasa_pipelinepl)
			1. [Subsequent message to Brian after encountering another error \(2022-1125\)](#subsequent-message-to-brian-after-encountering-another-error-2022-1125)
			1. [Response from Brian \(2022-1125\)](#response-from-brian-2022-1125)
			1. [Follow-up from me \(2022-1125\)](#follow-up-from-me-2022-1125)
			1. [Follow-up response from Brian \(2022-1125\)](#follow-up-response-from-brian-2022-1125)
	1. [Attempt to continue `Launch_PASA_pipeline.pl` following Brian Haas' advice \(2022-1126\)](#attempt-to-continue-launch_pasa_pipelinepl-following-brian-haas-advice-2022-1126)
		1. [Understanding `tmux` on FHCC `rhino`](#understanding-tmux-on-fhcc-rhino)
		1. [Set things up, get into the work directory](#set-things-up-get-into-the-work-directory)
		1. [Drawing on Brian's advice/testing out `singularity --bind` arguments](#drawing-on-brians-advicetesting-out-singularity---bind-arguments)
		1. [Continuing the `PASA` pipeline from where it left off yesterday](#continuing-the-pasa-pipeline-from-where-it-left-off-yesterday)
		1. [Checking on output from completion of the `PASA` pipeline](#checking-on-output-from-completion-of-the-pasa-pipeline)
1. [Setting up the preprocessing pipeline for `Trinity`](#setting-up-the-preprocessing-pipeline-for-trinity)
	1. [Getting started \(2022-1125, 2022-1126\)](#getting-started-2022-1125-2022-1126)
	1. [Set up the STAR alignment steps and sub-steps \(2022-1126\)](#set-up-the-star-alignment-steps-and-sub-steps-2022-1126)
		1. [Set up STAR alignment for genome-free assembly \(2022-1126\)](#set-up-star-alignment-for-genome-free-assembly-2022-1126)
		1. [Set up STAR alignment for genome-guided assembly \(2022-1126\)](#set-up-star-alignment-for-genome-guided-assembly-2022-1126)
	1. [Filter `.bam`s to retain only *S. cerevisiae* alignments \(2022-1128\)](#filter-bams-to-retain-only-s-cerevisiae-alignments-2022-1128)
	1. [Perform another quality check with `FastQC` \(2022-1128\)](#perform-another-quality-check-with-fastqc-2022-1128)
	1. [Convert the species-filtered `.bam`s from genome-free alignment to `.fastq`s](#convert-the-species-filtered-bams-from-genome-free-alignment-to-fastqs)
	1. [Perform a `FastQC` quality check for the new `.fastq` files \(2022-1128\)](#perform-a-fastqc-quality-check-for-the-new-fastq-files-2022-1128)
	1. [Remove erroneous k-mers from reads with `rCorrector` and "correct" the outfiles](#remove-erroneous-k-mers-from-reads-with-rcorrector-and-correct-the-outfiles)
		1. [Remove erroneous k-mers from paired-end reads with rCorrector](#remove-erroneous-k-mers-from-paired-end-reads-with-rcorrector)
		1. [Discard `rcorrector`-processed read pairs for which one read is deemed unfixable](#discard-rcorrector-processed-read-pairs-for-which-one-read-is-deemed-unfixable)
			1. [Troubleshoot errors associated with the `rcorrector`-correction scripts \(2022-1128-1129\)](#troubleshoot-errors-associated-with-the-rcorrector-correction-scripts-2022-1128-1129)
		1. [Continue work to discard `rcorrector`-processed read pairs that are "unfixable" \(2022-1129\)](#continue-work-to-discard-rcorrector-processed-read-pairs-that-are-unfixable-2022-1129)
			1. [Next steps following the successful completion of `rCorrector` treatment and correction \(2022-1129\)](#next-steps-following-the-successful-completion-of-rcorrector-treatment-and-correction-2022-1129)
		1. [Get `SLURM` submission scripts set up for `rCorrector` and "correction of `rCorrector`" \(2022-1130\)](#get-slurm-submission-scripts-set-up-for-rcorrector-and-correction-of-rcorrector-2022-1130)
			1. [...for `rCorrector`](#for-rcorrector)
			1. [...for "correction of `rCorrector`"](#for-correction-of-rcorrector)

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

<a id="filtering-bams-to-retain-only-s-cerevisiae-alignments-2022-1122"></a>
## Filtering `.bam`s to retain only *S. cerevisiae* alignments (2022-1122)
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

<a id="organizing-the-errouttxt-from-the-trial-runs"></a>
## Organizing the `*.{err,out}.txt` from the trial runs
```bash
#!/bin/bash
#DONTRUN

grabnode  # Default and lowest settings

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101"

mv *.{err,out}.txt exp_Trinity_trial/
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

<a id="on-handling-file-access-with-singularity"></a>
## On handling file access with `Singularity`
- [Binding file in singularity](https://stackoverflow.com/questions/45755512/binding-file-in-singularity)
- [Nice breakdowns of running Singularity on cluster from Harvard FAS](https://docs.rc.fas.harvard.edu/kb/singularity-on-the-cluster/)
- See the [FHCC Bioinformatics' Singularity Access to Storage section](#access-to-storage)
- [Sylabs documentation on "Bind Paths and Mounts"](https://docs.sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html)
	+ This seems to have the answer  ~~`#DONE` Study and test this~~
- [Google search results "singularity mount directory"](https://www.google.com/search?q=singularity+mount+directory&oq=mount+directory+singu&aqs=chrome.1.69i57j0i22i30.5454j0j7&sourceid=chrome&ie=UTF-8)

<a id="testing-system-defined-bind-paths-in-singularity"></a>
### Testing system-defined bind paths in `Singularity`
<details>
<summary><i>Checking the engine, kicking the tires...</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # Default and lowest settings

ml Singularity/3.5.3

cd ~/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101 \
	|| echo "cd'ing failed; check on this"

cd ~
ls -lhaFG singularity-docker-etc

#  Activate shell within/coming from the container
singularity shell ~/singularity-docker-etc/PASA.sif

ls -lhaFG
# Singularity> ls -lhaFG
# total 1.5M
# drwxr-x--- 18 kalavatt  805 Nov 24 12:48 ./
# drwxr-xr-x  1 kalavatt   60 Nov 24 12:50 ../
# -rw-------  1 kalavatt   50 Nov 17 15:27 .Xauthority
# -rw-rw----  1 kalavatt 4.0K Nov 21 12:33 .bash_aliases
# -rw-rw----  1 kalavatt 3.2K Nov 20 13:21 .bash_functions
# -rw-------  1 kalavatt 570K Nov 24 12:50 .bash_history
# -rw-rw----  1 kalavatt  308 Oct 20 11:18 .bash_profile
# -rw-rw----  1 kalavatt 6.0K Nov  7 15:05 .bashrc
# drwx------  4 kalavatt   87 Oct 20 11:42 .cache/
# drwxr-x---  2 kalavatt   34 Oct 20 10:28 .conda/
# drwxrwx---  5 kalavatt   75 Oct 28 15:14 .config/
# -rw-rw----  1 kalavatt   88 Oct 21 14:04 .gitconfig
# drwx------  3 kalavatt   35 Oct 17 10:57 .gnupg/
# drwxrwx---  3 kalavatt   23 Nov  7 15:06 .java/
# drwx------  7 kalavatt  113 Nov  1 09:09 .local/
# drwxr-x--- 15 kalavatt  524 Oct 20 09:57 .oh-my-bash/
# drwxrwx---  2 kalavatt   44 Nov  1 12:54 .oracle_jre_usage/
# -rw-r-----  1 kalavatt   17 Nov 17 08:49 .osh-update
# -rw-r-----  1 kalavatt    0 Nov 24 12:25 .sdirs
# drwx------  3 kalavatt   52 Nov 23 08:33 .singularity/
# drwx------  2 kalavatt   62 Oct 20 13:03 .ssh/
# -rw-------  1 kalavatt  28K Nov 23 11:51 .viminfo
# -rw-rw----  1 kalavatt  215 Oct 20 10:33 .wget-hsts
# drwxrwx---  3 kalavatt   23 Oct 20 11:42 Downloads/
# drwxrwx---  9 kalavatt 6.4K Oct  5 17:22 bbmap/
# drwxrwx--- 10 kalavatt  335 Nov  7 13:14 genomes/
# drwxr-x--- 20 kalavatt  570 Nov 23 11:34 miniconda3/
# -rw-rw----  1 kalavatt  726 Nov  1 09:20 picardmetrics.conf
# drwxrwx---  3 kalavatt  227 Nov 23 12:35 singularity-docker-etc/
# drwxrwx---  6 kalavatt  148 Nov  1 09:09 src/
# lrwxrwxrwx  1 root       37 Oct 17 10:44 tsukiyamalab -> /fh/fast/tsukiyama_t/grp/tsukiyamalab

ls -lhaFG /
# total 152K
# drwxr-xr-x   1 kalavatt   60 Nov 24 12:50 ./
# drwxr-xr-x   1 kalavatt   60 Nov 24 12:50 ../
# lrwxrwxrwx   1 root       27 Nov 23 12:12 .exec -> .singularity.d/actions/exec*
# lrwxrwxrwx   1 root       26 Nov 23 12:12 .run -> .singularity.d/actions/run*
# lrwxrwxrwx   1 root       28 Nov 23 12:12 .shell -> .singularity.d/actions/shell*
# drwxr-xr-x   5 root      127 Nov 23 12:12 .singularity.d/
# lrwxrwxrwx   1 root       27 Nov 23 12:12 .test -> .singularity.d/actions/test*
# lrwxrwxrwx   1 root        7 Jul 23  2021 bin -> usr/bin/
# drwxr-xr-x   2 root        3 Apr 15  2020 boot/
# drwxr-xr-x  18 root     4.1K Nov 23 16:19 dev/
# lrwxrwxrwx   1 root       36 Nov 23 12:12 environment -> .singularity.d/env/90-environment.sh*
# drwxr-xr-x  53 root     1.8K Aug  6  2021 etc/
# drwxr-xr-x   1 kalavatt   60 Nov 24 12:50 home/
# lrwxrwxrwx   1 root        7 Jul 23  2021 lib -> usr/lib/
# lrwxrwxrwx   1 root        9 Jul 23  2021 lib32 -> usr/lib32/
# lrwxrwxrwx   1 root        9 Jul 23  2021 lib64 -> usr/lib64/
# lrwxrwxrwx   1 root       10 Jul 23  2021 libx32 -> usr/libx32/
# drwxr-xr-x   2 root        3 Jul 23  2021 media/
# drwxr-xr-x   2 root        3 Jul 23  2021 mnt/
# drwxr-xr-x   2 root        3 Jul 23  2021 opt/
# dr-xr-xr-x 494 root        0 Nov  9 06:59 proc/
# drwx------   3 root       90 Feb  3  2022 root/
# drwxr-xr-x   8 root      124 Aug  6  2021 run/
# lrwxrwxrwx   1 root        8 Jul 23  2021 sbin -> usr/sbin/
# lrwxrwxrwx   1 root       24 Nov 23 12:12 singularity -> .singularity.d/runscript*
# drwxr-xr-x   2 root        3 Jul 23  2021 srv/
# dr-xr-xr-x  13 root        0 Nov  9 06:59 sys/
# drwxrwxrwt  18 root     148K Nov 24 12:52 tmp/
# drwxr-xr-x  14 root      241 Aug  6  2021 usr/
# drwxr-xr-x  11 root      172 Jul 23  2021 var/

alias .,="ls -lhaFG"

., /bin
# lrwxrwxrwx 1 root 7 Jul 23  2021 /bin -> usr/bin/

cd /bin && .,
# ... (a lot)

cd ..
., /dev
# ... (a lot)

., /etc
# ... (a lot)

., /lib
# lrwxrwxrwx 1 root 7 Jul 23  2021 /lib -> usr/lib/

., /mnt
# total 0
# drwxr-xr-x 2 root      3 Jul 23  2021 ./
# drwxr-xr-x 1 kalavatt 60 Nov 24 12:50 ../

., /opt
# total 0
# drwxr-xr-x 2 root      3 Jul 23  2021 ./
# drwxr-xr-x 1 kalavatt 60 Nov 24 12:50 ../

., /proc
# ... (a lot)

., /root
# ls: cannot open directory '/root': Permission denied

., /run
# total 512
# drwxr-xr-x  8 root     124 Aug  6  2021 ./
# drwxr-xr-x  1 kalavatt  60 Nov 24 12:50 ../
# drwxrwxrwt  3 root      29 Aug  6  2021 lock/
# drwxr-xr-x  2 root       3 Aug  6  2021 log/
# drwxr-xr-x  2 root       3 Jul 23  2021 mount/
# drwxr-xr-x  2 root       3 Aug  6  2021 sendsigs.omit.d/
# lrwxrwxrwx  1 root       8 Aug  6  2021 shm -> /dev/shm/
# drwxr-xr-x 10 root     154 Aug  6  2021 systemd/
# drwxr-xr-x  2 root       3 Aug  6  2021 user/
# -rw-rw-r--  1 root       0 Jul 23  2021 utmp

., /srv
# drwxr-xr-x 2 root      3 Jul 23  2021 ./
# drwxr-xr-x 1 kalavatt 60 Nov 24 12:50 ../

., /sys
total 0
# dr-xr-xr-x  13 root      0 Nov 24 12:53 ./
# drwxr-xr-x   1 kalavatt 60 Nov 24 12:50 ../
# drwxr-xr-x   2 root      0 Nov  9 06:59 block/
# drwxr-xr-x  45 root      0 Nov  9 06:59 bus/
# drwxr-xr-x  66 root      0 Nov  9 06:59 class/
# drwxr-xr-x   4 root      0 Nov  9 06:59 dev/
# drwxr-xr-x  71 root      0 Nov  9 06:59 devices/
# drwxr-xr-x   5 root      0 Nov  9 06:59 firmware/
# drwxr-xr-x   9 root      0 Nov  9 06:59 fs/
# drwxr-xr-x   2 root      0 Nov  9 06:59 hypervisor/
# drwxr-xr-x  14 root      0 Nov  9 06:59 kernel/
# drwxr-xr-x 180 root      0 Nov  9 06:59 module/
# drwxr-xr-x   2 root      0 Nov  9 06:59 power/

., /tmp
# total 216K
# drwxrwxrwt 18 root     148K Nov 24 13:00 ./
# drwxr-xr-x  1 kalavatt   60 Nov 24 12:50 ../
# drwxrwxrwt  2 root     4.0K Nov  9 07:00 .ICE-unix/
# drwxrwxrwt  2 root     4.0K Nov  9 07:00 .Test-unix/
# drwxrwxrwt  2 root     4.0K Nov  9 07:00 .X11-unix/
# drwxrwxrwt  2 root     4.0K Nov  9 07:00 .XIM-unix/
# drwxrwxrwt  2 root     4.0K Nov  9 07:00 .font-unix/
# drwx------  2    73778 4.0K Nov 23 17:33 Rtmp2N7h2a/
# drwxr-xr-x  3    74026 4.0K Nov  9 14:15 build/
# drwxr-x---  2    42037 4.0K Nov 23 00:06 hsperfdata_apaguiri/
# drwxr-x---  2    72966 4.0K Nov 21 00:08 hsperfdata_azimmer/
# drwxr-x---  2    71540 4.0K Nov 17 19:31 hsperfdata_madil/
# drwxr-x---  2    61501 4.0K Nov 18 16:55 hsperfdata_nahmed/
# drwxrwxrw-  2    71540 4.0K Nov 17 19:31 madil/
# drwx------  3 root     4.0K Nov 11 00:25 systemd-private-318ce31389ba4b1dbadc92a7cc2f39f6-ntp.service-VEcyVu/
# drwx------  3 root     4.0K Nov  9 07:00 systemd-private-318ce31389ba4b1dbadc92a7cc2f39f6-systemd-resolved.service-JgDtTj/
# drwxrwxrwt  2    60495 4.0K Nov 17 17:35 tmp/
# drwxrwxrwt  2    60495 4.0K Nov 16 16:59 var_tmp/

., /usr
# total 0
# drwxr-xr-x 14 root      241 Aug  6  2021 ./
# drwxr-xr-x  1 kalavatt   60 Nov 24 12:50 ../
# drwxr-xr-x  2 root      11K Aug  6  2021 bin/
# drwxr-xr-x  2 root        3 Apr 15  2020 games/
# drwxr-xr-x 42 root     2.9K Aug  6  2021 include/
# drwxr-xr-x 39 root      759 Aug  6  2021 lib/
# drwxr-xr-x  3 root     2.0K Aug  6  2021 lib32/
# drwxr-xr-x  2 root       43 Jul 23  2021 lib64/
# drwxr-xr-x  2 root       58 Aug  6  2021 libexec/
# drwxr-xr-x  3 root     2.1K Aug  6  2021 libx32/
# drwxr-xr-x 10 root      135 Jul 23  2021 local/
# drwxr-xr-x  2 root     2.3K Aug  6  2021 sbin/
# drwxr-xr-x 66 root     1.2K Aug  6  2021 share/
# drwxr-xr-x  2 root        3 Apr 15  2020 src/

., /var
# total 5.0K
# drwxr-xr-x 11 root      172 Jul 23  2021 ./
# drwxr-xr-x  1 kalavatt   60 Nov 24 12:50 ../
# drwxr-xr-x  2 root        3 Apr 15  2020 backups/
# drwxr-xr-x  7 root      102 Aug  6  2021 cache/
# drwxr-xr-x 18 root      271 Aug  6  2021 lib/
# drwxrwsr-x  2 root        3 Apr 15  2020 local/
# lrwxrwxrwx  1 root        9 Jul 23  2021 lock -> /run/lock/
# drwxr-xr-x  6 root      184 Aug  6  2021 log/
# drwxrwsr-x  2 root        3 Jul 23  2021 mail/
# drwxr-xr-x  2 root        3 Jul 23  2021 opt/
# lrwxrwxrwx  1 root        4 Jul 23  2021 run -> /run/
# drwxr-xr-x  2 root       27 Jul 23  2021 spool/
# drwxrwxrwt  6 root     4.0K Nov 24 12:48 tmp/

#  This isn't the same as my /, right? Exit Singularity shell and check
exit
ls -lhaFG /
# total 312K
# drwxr-xr-x  30 root 4.0K Sep 10 13:51 ./
# drwxr-xr-x  30 root 4.0K Sep 10 13:51 ../
# drwxrwsr-x  15 root  312 May 10  2022 app/
# -rw-r--r--   1 root    0 Jul  9  2020 .autorelabel
# drwxr-xr-x   2 root 4.0K Nov 11 00:25 bin/
# drwxr-xr-x   3 root 4.0K Nov 11 00:26 boot/
# drwxr-xr-x   3 root 4.0K Feb 11  2022 .bundle/
# drwxr-xr-x  18 root 4.1K Nov 23 16:19 dev/
# drwxr-xr-x 114 root  12K Nov 24 12:48 etc/
# dr-xr-xr-x   7 root 4.0K May 10  2021 fh/
# drwx------   2 root 4.0K Jul  9  2020 .gnupg/
# dr-xr-xr-x   2 root 4.0K Nov  2  2020 goodtimes_NFS/
# drwxr-xr-x   7 root    0 Nov 24 12:58 home/
# lrwxrwxrwx   1 root   34 Sep 10 13:51 initrd.img -> boot/initrd.img-4.15.0-192-generic
# lrwxrwxrwx   1 root   34 Sep 10 13:51 initrd.img.old -> boot/initrd.img-4.15.0-101-generic
# dr-xr-xr-x   2 root 4.0K May 10  2021 install/
# drwxr-xr-x  20 root 4.0K Sep 10 13:41 lib/
# drwxr-xr-x   2 root 4.0K Sep 10 13:41 lib64/
# drwxr-xr-x   4 root 4.0K Jul  9  2020 loc/
# drwx------   2 root  16K Jul  9  2020 lost+found/
# drwxr-xr-x   2 root 4.0K Jul  9  2020 media/
# drwxr-xr-x   9 root 4.0K Mar 20  2022 mnt/
# drwxr-xr-x   7 root 4.0K Mar  4  2021 opt/
# dr-xr-xr-x 508 root    0 Nov  9 06:59 proc/
# drwx------   7 root 4.0K Oct 24 14:56 root/
# drwxr-xr-x  30 root 1.4K Nov 24 13:02 run/
# drwxr-xr-x   2 root  12K Nov 11 00:25 sbin/
# dr-xr-xr-x  17 root 4.0K Sep 10 08:22 shared/
# drwxr-xr-x   2 root 4.0K Jul  9  2020 srv/
# dr-xr-xr-x  13 root    0 Nov 24 12:53 sys/
# drwxrwxrwt  18 root 148K Nov 24 13:02 tmp/
# drwxr-xr-x  10 root 4.0K Jul  9  2020 usr/
# drwxr-xr-x  15 root 4.0K Jul  9  2020 var/
# lrwxrwxrwx   1 root   31 Sep 10 13:51 vmlinuz -> boot/vmlinuz-4.15.0-192-generic
# lrwxrwxrwx   1 root   31 Sep 10 13:51 vmlinuz.old -> boot/vmlinuz-4.15.0-101-generic

cd /mnt && ls -lhaFG
# total 29K
# drwxr-xr-x  9 root 4.0K Mar 20  2022 ./
# drwxr-xr-x 30 root 4.0K Sep 10 13:51 ../
# drwxr-xr-x  2 root 4.0K Feb  7  2022 app/
# drwxr-xr-x  2 root    0 Nov  9 07:00 campbell-data/
# dr-xr-xr-x  3 root 4.0K Nov  2  2020 scdata/
# dr-xr-xr-x  2 root 4.0K Nov 20 06:41 silver/
# dr-xr-xr-x  2 root 4.0K May 10  2021 stortest/
# drwxr-xr-x  2 root 4.0K Mar 20  2022 test-1/
# drwxrwxrwx  3 root    1 Oct  2  2021 thorium/

#  It's different based on my /, I think; the image maps its directories some
#+ of the directories in /, I think
```
</details>
<br />

The `*.sif` containers maps many of its directories to directories in my local `/`, I think...

<a id="try-mounting-some-datasets-needed-for-running-pasa-singularity"></a>
### Try mounting some datasets needed for running `PASA` (`Singularity`)
```bash
#!/bin/bash
#DONTRUN

grabnode  # Default and lowest settings

ml Singularity/3.5.3

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" \
	|| echo "cd'ing failed; check on this"

mkdir -p exp_PASA_trial

cd exp_PASA_trial

ln -s \
	"${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-free_SC_all/Trinity_trial_genome-free_SC_all.Trinity.fasta" \
	genome-free_SC_all.Trinity.fasta

ln -s \
	"${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/Trinity_trial_genome-guided_SC_all/Trinity-GG.fasta" \
	genome-guided_SC_all.Trinity.fasta

ls -lhaFG
# total 99K
# drwxrws---  2 kalavatt  102 Nov 24 13:26 ./
# drwxrws--- 14 kalavatt 1.2K Nov 24 13:15 ../
# lrwxrwxrwx  1 kalavatt  188 Nov 24 13:23 genome-free_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-free_SC_all/Trinity_trial_genome-free_SC_all.Trinity.fasta
# lrwxrwxrwx  1 kalavatt  195 Nov 24 13:26 genome-guided_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/Trinity_trial_genome-guided_SC_all/Trinity-GG.fasta

#  Check the symbolic links
head genome-free_SC_all.Trinity.fasta  # It works
head genome-guided_SC_all.Trinity.fasta  # It works

#  Anything assigned to this environmental variable for Singularity?
echo "${SINGULARITY_BIND}"  # Empty

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial

export SINGULARITY_BIND=/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data
echo "${SINGULARITY_BIND}"
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial

#  Now try activating the singularity shell
singularity shell ~/singularity-docker-etc/PASA.sif
# WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, may not be available

ls -lhaFG /mnt/data
# total 67K
# drwxrws--- 2 kalavatt 102 Nov 24 13:26 ./
# drwxr-xr-x 1 kalavatt  60 Nov 24 13:31 ../
# lrwxrwxrwx 1 kalavatt 188 Nov 24 13:23 genome-free_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-free_SC_all/Trinity_trial_genome-free_SC_all.Trinity.fasta
# lrwxrwxrwx 1 kalavatt 195 Nov 24 13:26 genome-guided_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/Trinity_trial_genome-guided_SC_all/Trinity-GG.fasta

#  It seems to have worked
```
<br />
<br />

<a id="try-a-trial-run-of-singularity-pasa"></a>
## Try a trial run of `Singularity` `PASA`
<a id="working-through-the-first-few-steps-of-pasa-wiki-2022-1124"></a>
### Working through the first few steps of `PASA` Wiki (2022-1124)
We have successfully mounted data for use with `Singularity` `PASA`; let's try running `Singularity` `PASA` following the comprehensive-transcriptome-database approach described [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db).

```bash
#!/bin/bash
#DONTRUN

grabnode  # Default and lowest settings

ml Singularity/3.5.3

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial" \
	|| echo "cd'ing failed; check on this"

ls -1
# genome-free_SC_all.Trinity.fasta
# genome-guided_SC_all.Trinity.fasta

#  1. Concatenate the Trinity.fasta and Trinity.GG.fasta files into a single
#+    transcripts.fasta file
cat genome-free_SC_all.Trinity.fasta genome-guided_SC_all.Trinity.fasta > transcripts.fasta

#  2. Create a file containing the list of transcript accessions that
#+    correspond to the Trinity de novo assembly (full de novo, not genome-
#+    guided)
export SINGULARITY_BIND=/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data
echo "${SINGULARITY_BIND}"

#  See this link to learn more about singularity run:
#+ docs.sylabs.io/guides/3.1/user-guide/cli/singularity_run.html
if [[ -f tdn.accs ]]; then rm tdn.accs; fi
singularity run ~/singularity-docker-etc/PASA.sif \
	${PASA_HOME}/misc_utilities/accession_extractor.pl \
	< genome-free_SC_all.Trinity.fasta \
	> tdn.accs
# WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, may not be available
# /.singularity.d/runscript: 39: exec: /misc_utilities/accession_extractor.pl: not found

#  ${PASA_HOME} is /usr/local/src/PASApipeline, so try that out...
if [[ -f tdn.accs ]]; then rm tdn.accs; fi
singularity run ~/singularity-docker-etc/PASA.sif \
	/usr/local/src/PASApipeline/misc_utilities/accession_extractor.pl \
	< genome-free_SC_all.Trinity.fasta \
	> tdn.accs
# WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, may not be available
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
# 	LANGUAGE = "en_US:",
# 	LC_ALL = (unset),
# 	LC_CTYPE = "en_US.UTF-8",
# 	LANG = "en_US.UTF-8"
#     are supported and installed on your system.
# perl: warning: Falling back to the standard locale ("C").

#  It works!


#  3. Run PASA using RNA-seq-related options as described in the section above,
#+    but include the parameter setting --TDN tdn.accs
export PASAHOME=/usr/local/src/PASApipeline
echo "${PASAHOME}"

#  First, need to do things described in these two links:
#+ - github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly
#+ - github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq

#  3a. Clean the transcript sequences (PASA_alignment_assembly)
cp transcripts.fasta bak.transcripts.fasta

singularity run ~/singularity-docker-etc/PASA.sif \
	${PASAHOME}/bin/seqclean  transcripts.fasta
# WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, may not be available
# perl: warning: Setting locale failed.
# perl: warning: Please check that your locale settings:
# 	LANGUAGE = "en_US:",
# 	LC_ALL = (unset),
# 	LC_CTYPE = "en_US.UTF-8",
# 	LANG = "en_US.UTF-8"
#     are supported and installed on your system.
# perl: warning: Falling back to the standard locale ("C").
# seqclean running options:
# seqclean transcripts.fasta
#  Standard log file: seqcl_transcripts.fasta.log
#  Error log file:    err_seqcl_transcripts.fasta.log
#  Using 1 CPUs for cleaning
# -= Rebuilding transcripts.fasta cdb index =-
#  Launching actual cleaning process:
#  psx -p 1  -n 1000  -i transcripts.fasta -d cleaning -C '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial/transcripts.fasta:ANLMS100:::11:0' -c '/usr/local/src/PASApipeline/bin/seqclean.psx'
# Collecting cleaning reports
#
# **************************************************
# Sequences analyzed:     19435
# -----------------------------------
#                    valid:     19435  (5441 trimmed)
#                  trashed:         0
# **************************************************
# Output file containing only valid and trimmed sequences: transcripts.fasta.clean
# For trimming and trashing details see cleaning report  : transcripts.fasta.cln
# --------------------------------------------------
# seqclean (transcripts.fasta) finished on machine
#  in /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, without a detectable error.

alias .,="ls -lhaFG"
# total 69M
# drwxrws---  3 kalavatt  479 Nov 24 14:12 ./
# drwxrws--- 14 kalavatt 1.2K Nov 24 13:15 ../
# -rw-rw----  1 kalavatt  19M Nov 24 14:12 bak.transcripts.fasta
# drwxr-s---  2 kalavatt  970 Nov 24 14:12 cleaning_1/
# -rw-rw-r--  1 kalavatt 6.9K Nov 24 14:12 err_seqcl_transcripts.fasta.log
# lrwxrwxrwx  1 kalavatt  188 Nov 24 13:23 genome-free_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-free_SC_all/Trinity_trial_genome-free_SC_all.Trinity.fasta
# lrwxrwxrwx  1 kalavatt  195 Nov 24 13:26 genome-guided_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/Trinity_trial_genome-guided_SC_all/Trinity-GG.fasta
# -rw-rw-r--  1 kalavatt  880 Nov 24 14:12 outparts_cln.sort
# -rw-rw-r--  1 kalavatt 1002 Nov 24 14:12 seqcl_transcripts.fasta.log
# -rw-rw----  1 kalavatt 218K Nov 24 13:58 tdn.accs
# -rw-rw----  1 kalavatt  19M Nov 24 13:50 transcripts.fasta
# -rw-rw-r--  1 kalavatt 1.1M Nov 24 14:12 transcripts.fasta.cidx
# -rw-rw-r--  1 kalavatt  19M Nov 24 14:12 transcripts.fasta.clean
# -rw-rw-r--  1 kalavatt 1.3M Nov 24 14:12 transcripts.fasta.cln
```

From following the instructions at [PASA_alignment_assembl](github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly), we see,
> The `PASA` pipeline requires separate configuration files for the alignment assembly and later annotation comparison steps, and these are configured separately for each run of the `PASA` pipeline, setting parameters to be used by the various tools and processes executed within the `PASA` pipeline. Configuration file templates are provided as '`$PASAHOME/pasa_conf/pasa.alignAssembly.Template.txt`' and '`$PASAHOME/pasa_conf/pasa.annotationCompare.Template.txt`', and these will be further described when used below. 

`#DONE` Pick up with this tomorrow; basically, I'm trying to understand what I need to do to run something like what's shown on [this page](https://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq), all in keeping with (i.e., following) instruction #3 on [this page](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db):
```bash
#!/bin/bash
#EXAMPLE

#  github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq#strand-specific-rna-seq
#+
#+ If your gene density is high and you expect transcripts from neighboring
#+ genes to often overlap in their UTR regions, you can perform more stringent
#+ clustering of alignments like so:
${PASAHOME}/Launch_PASA_pipeline.pl \
	-c alignAssembly.config \
	-C \
	-R -g genome_sample.fasta \
	--ALIGNERS blat,gmap \
	-t Trinity.fasta \
	--transcribed_is_aligned_orient \
    --stringent_alignment_overlap 30.0
```
`#DONE` I need to understand what are appropriate contents/values for the `alignAssembly.config` file; once that's done, I need to get something like the above running with `Singularity` `PASA` (making use of the clean `trinity.fasta` file(s)) and then move on to subsequent steps [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db)

<a id="documentation-details-for-pasas-launch_pasa_pipelinepl-including-config"></a>
#### Documentation, details for `PASA`'s' `Launch_PASA_pipeline.pl`, including `*.config`
```bash
#!/bin/bash
#DONTRUN

grabnode  # Default and lowest settings

ml Singularity/3.5.3

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial" \
	|| echo "cd'ing failed; check on this"

alias .,="ls -lhaFG"
.,

#  Copied from
#+ github.com/PASApipeline/PASApipeline/blob/master/sample_data/mysql.confs/alignAssembly.config
cat << alignAssembly > "./alignAssembly.config"

## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=sample_mydb_pasa


#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter" 
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50

alignAssembly
# vi alignAssembly.config


#  What are the options for ${PASAHOME}/Launch_PASA_pipeline.pl?
export PASAHOME=/usr/local/src/PASApipeline
echo "${PASAHOME}"

singularity run ~/singularity-docker-etc/PASA.sif \
	${PASAHOME}/Launch_PASA_pipeline.pl

```

Documentation for `Launch_PASA_pipeline.pl`
<details>
<summary><i>Click here to expand</i></summary>

```txt
WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, may not be available
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = "en_US:",
	LC_ALL = (unset),
	LC_CTYPE = "en_US.UTF-8",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = "en_US:",
	LC_ALL = (unset),
	LC_CTYPE = "en_US.UTF-8",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").

############################# Options ###############################
#
#   * indicates required
#
#
# --config|-c * <filename>  alignment assembly configuration file
#
# // spliced alignment settings
# --ALIGNERS <string>   aligners (available options include: gmap, blat, minimap2... can run using several, ie. 'gmap,blat,minimap2')
# -N <int>              max number of top scoring alignments (default: 1)
# --MAX_INTRON_LENGTH|-I  <int>         (max intron length parameter passed to GMAP or BLAT)  (default: 100000)
# --IMPORT_CUSTOM_ALIGNMENTS_GFF3 <filename> :only using the alignments supplied in the corresponding GFF3 file.
# --trans_gtf <filename>      :incorporate cufflinks or stringtie--generated transcripts
#
#
# // actions
# --create|-C               flag, create database
# --replace|-r               flag, drop database if -C is also given. This will DELETE all your data and it is irreversible.
# --run|-R               flag, run alignment/assembly pipeline.
# --annot_compare|-A               (see section below; can use with opts -L and --annots)  compare to annotated genes.
# --ALT_SPLICE     flag, run alternative splicing analysis

# // input files
# --genome|-g * <filename>  genome sequence FASTA file (should contain annot db asmbl_id as header accession.)
# --transcripts|-t * <filename>  transcript db
# -f <filename>    file containing a list of fl-cdna accessions.
# --TDN <filename> file containing a list of accessions corresponding to Trinity (full) de novo assemblies (not genome-guided)
#
# // polyAdenylation site identification  ** highly recommended **
# -T               flag,transcript db were trimmed using the TGI seqclean tool.
#    -u <filename>   value, transcript db containing untrimmed sequences (input to seqclean)
#                  <a filename with a .cln extension should also exist, generated by seqclean.>
#
#
#
# Misc:
# --TRANSDECODER   flag, run transdecoder to identify candidate full-length coding transcripts
# --CPU <int>      multithreading (default: 2)
# --PASACONF <string> path to a user-defined pasa.conf file containing mysql connection info
#                      (used in place of the $PASAHOME/pasa_conf/conf.txt file)
#                      (and allows for users to have their own unique mysql connection info)
#                      (instead of the pasa role account)
#
# -d               flag, Debug
# -h               flag, print this option menu and quit
#
#########
#
# // Transcript alignment clustering options (clusters are fed into the PASA assembler):
#
#       By default, clusters together transcripts based on any overlap (even 1 base!).
#
#    Alternatives:
#
#        --stringent_alignment_overlap <float>  (suggested: 30.0)  overlapping transcripts must have this min % overlap to be clustered.
#
#        --gene_overlap <float>  (suggested: 50.0)  transcripts overlapping existing gene annotations are clustered.  Intergenic alignments are clustered by default mechanism.
#               * if --gene_overlap, must also specify --annots  with annotations in recognizable format (gtf, gff3, or data adapted) (just examines 'gene' rows, though).
#
#
#
# --INVALIDATE_SINGLE_EXON_ESTS    :invalidates single exon ests so that none can be built into pasa assemblies.
#
#
# --transcribed_is_aligned_orient   flag for strand-specific RNA-Seq assemblies, the aligned orientation should correspond to the transcribed orientation.
#
#
################
#
#  // Annotation comparison options (used in conjunction with -A at top).
#
#  -L   load annotations (use in conjunction with --annots)
#  --annots <filename>  existing gene annotations in recognized format (gtf, gff3, or custom adapted).
#  --GENETIC_CODE (default: universal, options: Euplotes, Tetrahymena, Candida, Acetabularia)
#
###################### Process Args and Options #####################
```
</details>
<br />

<a id="attempt-to-call-launch_pasa_pipelinepl-2022-1124"></a>
### Attempt to call `Launch_PASA_pipeline.pl` (2022-1124)
On calling `Launch_PASA_pipeline.pl`
```bash
#!/bin/bash
#DONTRUN

tmux  # Rename the session to 'PASA'
grabnode  # Default and lowest settings, except 2 threads
echo "${SLURM_CPUS_ON_NODE}"  # 2

ml Singularity/3.5.3

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial" \
	|| echo "cd'ing failed; check on this"

export SINGULARITY_BIND=${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data
echo "${SINGULARITY_BIND}"
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data

export PASAHOME=/usr/local/src/PASApipeline
echo "${PASAHOME}"
# /usr/local/src/PASApipeline

singularity run ~/singularity-docker-etc/PASA.sif \
	${PASAHOME}/Launch_PASA_pipeline.pl \
		-c alignAssembly.config \
		-I 1002 \
		-C \
		-R \
		-g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
		-t transcripts.fasta.clean \
		-T \
		-u transcripts.fasta \
		--transcribed_is_aligned_orient \
	    --stringent_alignment_overlap 30.0 \
	    --TDN tdn.accs \
	    --ALIGNERS blat,gmap \
	    --CPU "${SLURM_CPUS_ON_NODE}"

#  Building the above command from...
#+ - 1. github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly#transcript-alignments-followed-by-alignment-assembly
#+      (code chunk below the header)
#+
#+      ${PASAHOME}/Launch_PASA_pipeline.pl \
#+  	    -c alignAssembly.config \
#+  	    -C \
#+  	    -R \
#+  	    -g genome_sample.fasta \
#+  	    -t all_transcripts.fasta.clean \
#+  	    -T \
#+  	    -u all_transcripts.fasta \
#+  	    -f FL_accs.txt \
#+  	    --ALIGNERS blat,gmap,minimap2 \
#+  	    --CPU 2
#+
#+ - 2. github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq#strand-specific-rna-seq
#+      (second of three code chunks below the header)
#+
#+      ${PASAHOME}/Launch_PASA_pipeline.pl \
#+      	-c alignAssembly.config \
#+      	-C -R \
#+      	-g genome_sample.fasta \
#+      	--ALIGNERS blat,gmap\
#+      	-t Trinity.fasta \
#+      	--transcribed_is_aligned_orient \
#+      	--stringent_alignment_overlap 30.0

# -connecting to MySQL db: sample_mydb_pasa
# -*** Running PASA pipeine:
# * [Thu Nov 24 20:10:06 2022] Running CMD: /usr/local/src/PASApipeline/scripts/create_mysql_cdnaassembly_db.dbi -c alignAssembly.config -S '/usr/local/src/PASApipeline/schema/cdna_alignment_mysqlschema'
# perl: warning: Falling back to the standard locale ("C").
# DBI connect('database=;host=localhost','root',...) failed: Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2) at /usr/local/src/PASApipeline/PerlLib/DB_connect.pm line 72.
# Cannot connect to : Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2) at /usr/local/src/PASApipeline/scripts/create_mysql_cdnaassembly_db.dbi line 57.
# Error, cmd: /usr/local/src/PASApipeline/scripts/create_mysql_cdnaassembly_db.dbi -c alignAssembly.config -S '/usr/local/src/PASApipeline/schema/cdna_alignment_mysqlschema' died with ret 65280 No such file or directory at /usr/local/src/PASApipeline/PerlLib/Pipeliner.pm line 187.
#         Pipeliner::run(Pipeliner=HASH(0x55de4ede1b48)) called at /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl line 1047

#  Try changing the name of the database
mv alignAssembly.config bak.alignAssembly.config

cat << alignAssembly > "./alignAssembly.config"

## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=PASA


#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter" 
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50

alignAssembly
# vi alignAssembly.config

singularity run ~/singularity-docker-etc/PASA.sif \
	${PASAHOME}/Launch_PASA_pipeline.pl \
		-c alignAssembly.config \
		-I 1002 \
		-C \
		-R \
		-g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
		-t transcripts.fasta.clean \
		-T \
		-u transcripts.fasta \
		--transcribed_is_aligned_orient \
	    --stringent_alignment_overlap 30.0 \
	    --TDN tdn.accs \
	    --ALIGNERS blat,gmap \
	    --CPU "${SLURM_CPUS_ON_NODE}"
```

<a id="troubleshooting-the-errors-from-calling-launch_pasa_pipelinepl"></a>
#### Troubleshooting the errors from calling `Launch_PASA_pipeline.pl`
The call results in an error (see below), so I left a message on the [Trinity forum](https://groups.google.com/g/trinityrnaseq-users) and am now awaiting a response from Brian Haas:

<a id="message-from-me-2022-1124"></a>
##### Message from me (2022-1124)
Hi,

Following the advice [here](https://groups.google.com/g/trinityrnaseq-users/c/DWctG7wLNYY/m/RGn6ZH_fAQAJ, I am trying to run `PASA` `Launch_PASA_pipeline.pl` for a comprehensive transcriptome database. I'm not sure how to interpret an error message I get quickly after calling the script. Can you help me to understand the error and let me know any potential steps to resolve it?

Here's how I'm calling `Launch_PASA_pipeline.pl` (I worked out the call from info [here](http://github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly#transcript-alignments-followed-by-alignment-assembly) (code chunk below the header) and [here](http://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq#strand-specific-rna-seq) (second of three code chunks below the header)&mdash;please let me know if you see anything problematic):

```bash
export SINGULARITY_BIND=${HOME}/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data

export PASAHOME=/usr/local/src/PASApipeline

singularity run ~/singularity-docker-etc/PASA.sif \
    ${PASAHOME}/Launch_PASA_pipeline.pl \
        -c alignAssembly.config \
        -I 1002 \
        -C \
        -R \
        -g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
        -t transcripts.fasta.clean \
        -T \
        -u transcripts.fasta \
        --transcribed_is_aligned_orient \
        --stringent_alignment_overlap 30.0 \
        --TDN tdn.accs \
        --ALIGNERS blat,gmap \
        --CPU "${SLURM_CPUS_ON_NODE}"
```

And here's the error message:
```txt
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
-connecting to MySQL db: PASA
-*** Running PASA pipeine:
* [Thu Nov 24 20:23:06 2022] Running CMD: /usr/local/src/PASApipeline/scripts/create_mysql_cdnaassembly_db.dbi -c alignAssembly.config -S '/usr/local/src/PASApipeline/schema/cdna_alignment_mysqlschema'
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
        LANGUAGE = "en_US:",
        LC_ALL = (unset),
        LC_CTYPE = "en_US.UTF-8",
        LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
DBI connect('database=;host=localhost','root',...) failed: Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2) at /usr/local/src/PASApipeline/PerlLib/DB_connect.pm line 72.
Cannot connect to : Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2) at /usr/local/src/PASApipeline/scripts/create_mysql_cdnaassembly_db.dbi line 57.
Error, cmd: /usr/local/src/PASApipeline/scripts/create_mysql_cdnaassembly_db.dbi -c alignAssembly.config -S '/usr/local/src/PASApipeline/schema/cdna_alignment_mysqlschema' died with ret 65280 No such file or directory at /usr/local/src/PASApipeline/PerlLib/Pipeliner.pm line 187.
        Pipeliner::run(Pipeliner=HASH(0x55c7998992b8)) called at /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl line 1047
```

Here are the contents of `alignAssembly.conf`:
```bash
cat << alignAssembly > "./alignAssembly.config"

## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=PASA


#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter"
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50

alignAssembly
```

I also called the `Perl` script with an `alignAssembly.conf` that has` DATABASE=sample_mydb_pasa`, like the example in the `PASA` repo. That call resulted in the same error message.

Thanks,
Kris

<a id="response-from-brian-haas-2022-1125"></a>
##### Response from Brian Haas (2022-1125)
Hi Kris,

In your `alignAssembly.conf` file, set the
`DATABASE=/exact/path/to/your/working/directory/sample_mydb_pasa.sqlite`

which will use the `sqlite` backend instead of `mysql`

then just rerun your original command.

hope this helps,

~b

<a id="attempt-to-call-launch_pasa_pipelinepl-following-brian-haas-advice-2022-1125"></a>
### Attempt to call `Launch_PASA_pipeline.pl` following Brian Haas' advice (2022-1125)
Rerun the call to `Launch_PASA_pipeline.pl` based on advice from Brian Haas:
```bash
#!/bin/bash
#DONTRUN

tmux  # Rename the session to 'PASA'
grabnode  # Default and lowest settings, except 2 threads
echo "${SLURM_CPUS_ON_NODE}"  # 2

ml Singularity/3.5.3

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial" \
	|| echo "cd'ing failed; check on this"

export SINGULARITY_BIND=${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data
echo "${SINGULARITY_BIND}"
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial:/mnt/data

export PASAHOME=/usr/local/src/PASApipeline
echo "${PASAHOME}"
# /usr/local/src/PASApipeline

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial

if [[ -f alignAssembly.config ]]; then rm alignAssembly.config; fi
cat << alignAssembly > "./alignAssembly.config"

## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial/sample_mydb_pasa.sqlite


#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter" 
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50

alignAssembly
# vi alignAssembly.config

singularity run ~/singularity-docker-etc/PASA.sif \
	${PASAHOME}/Launch_PASA_pipeline.pl \
		-c alignAssembly.config \
		-I 1002 \
		-C \
		-R \
		-g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
		-t transcripts.fasta.clean \
		-T \
		-u transcripts.fasta \
		--transcribed_is_aligned_orient \
	    --stringent_alignment_overlap 30.0 \
	    --TDN tdn.accs \
	    --ALIGNERS blat,gmap \
	    --CPU "${SLURM_CPUS_ON_NODE}" \
	    	> >(tee -a stdout.log.txt) \
	    	2> >(tee -a stderr.log.txt >&2)

#  Great! It's running; stopped to adjust the above so that STDERR and STDOUT is saved to files (a lot of information is printed to the screen)
```

This resulted in an error involving the pipeline's call to script `assemble_clusters.dbi`; thus, submitted another message on the [Trinity forum](https://groups.google.com/g/trinityrnaseq-users) and am now awaiting a response from Brian Haas:

<a id="again-troubleshooting-the-errors-from-calling-launch_pasa_pipelinepl"></a>
#### Again, troubleshooting the errors from calling `Launch_PASA_pipeline.pl`

<a id="subsequent-message-to-brian-after-encountering-another-error-2022-1125"></a>
##### Subsequent message to Brian after encountering another error (2022-1125)
Thank you, Brian.

`Launch_PASA_pipeline.pl` ran for a good bit before failing with an error; this error is associated with the pipeline's call to `assemble_clusters.dbi`. Do you have any insights or advice for this?

Below, I've pasted what was printed to `STDERR`, and I've attached the `STDERR` log too (for better readability, I removed Perl warnings about my locale settings). I've also included how I called `Launch_PASA_pipeline.pl` (I'm calling it with two threads) and the contents of `alignAssembly.config`. Also, I've printed the contents of my work directory so you can see what files have been generated by the pipeline so far.

I appreciate your help. Thanks again,  
Kris

<details>
<summary><i>Click here to expand</i></summary>

The error messages associated with `alignAssembly.config`:
```txt
* [Fri Nov 25 10:47:03 2022] Running CMD: /usr/local/src/PASApipeline/scripts/assemble_clusters.dbi -G /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta  -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial/sample_mydb_pasa.sqlite'  -T 2  > sample_mydb_pasa.sqlite.pasa_alignment_assembly_building.ascii_illustrations.out

Thread 2 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402024-0.841504182973043.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13555.
Thread 3 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402024-0.821881816563295.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 5278.
Thread 1 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402024-0.401388888320984.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 3838.
ERROR, thread 1 exited with error Can't open file /loc/scratch/4593262/pasa.1669402024-0.401388888320984.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 3838.

ERROR, thread 2 exited with error Can't open file /loc/scratch/4593262/pasa.1669402024-0.841504182973043.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13555.

ERROR, thread 3 exited with error Can't open file /loc/scratch/4593262/pasa.1669402024-0.821881816563295.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 5278.

Thread 5 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402025-0.580776268922822.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 7333.
Thread 4 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402025-0.448308551059203.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 25534.
Thread 6 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402025-0.567081061731191.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 1430.
ERROR, thread 4 exited with error Can't open file /loc/scratch/4593262/pasa.1669402025-0.448308551059203.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 25534.

ERROR, thread 5 exited with error Can't open file /loc/scratch/4593262/pasa.1669402025-0.580776268922822.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 7333.

ERROR, thread 6 exited with error Can't open file /loc/scratch/4593262/pasa.1669402025-0.567081061731191.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 1430.

Thread 8 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402026-0.365538701488735.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 4504.
Thread 7 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402026-0.910045815006928.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9616.
Thread 9 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402026-0.752270791986124.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18184.
ERROR, thread 7 exited with error Can't open file /loc/scratch/4593262/pasa.1669402026-0.910045815006928.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9616.

ERROR, thread 8 exited with error Can't open file /loc/scratch/4593262/pasa.1669402026-0.365538701488735.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 4504.

ERROR, thread 9 exited with error Can't open file /loc/scratch/4593262/pasa.1669402026-0.752270791986124.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18184.

Thread 10 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402027-0.789667837861092.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9379.
Thread 11 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402027-0.572378615689562.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 12431.
Thread 12 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402027-0.987498708841489.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 11115.
ERROR, thread 10 exited with error Can't open file /loc/scratch/4593262/pasa.1669402027-0.789667837861092.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 9379.

ERROR, thread 11 exited with error Can't open file /loc/scratch/4593262/pasa.1669402027-0.572378615689562.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 12431.

ERROR, thread 12 exited with error Can't open file /loc/scratch/4593262/pasa.1669402027-0.987498708841489.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 11115.

Thread 14 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402028-0.0183860194674743.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15409.
Thread 13 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402028-0.816049709756957.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 17971.
Thread 15 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402028-0.198708701952459.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13074.
ERROR, thread 13 exited with error Can't open file /loc/scratch/4593262/pasa.1669402028-0.816049709756957.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 17971.

ERROR, thread 14 exited with error Can't open file /loc/scratch/4593262/pasa.1669402028-0.0183860194674743.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15409.

ERROR, thread 15 exited with error Can't open file /loc/scratch/4593262/pasa.1669402028-0.198708701952459.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 13074.

Thread 16 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402029-0.0687543715621395.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18190.
ERROR, thread 16 exited with error Can't open file /loc/scratch/4593262/pasa.1669402029-0.0687543715621395.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 18190.

Thread 17 terminated abnormally: Can't open file /loc/scratch/4593262/pasa.1669402029-0.304084447519021.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15803.
ERROR, thread 17 exited with error Can't open file /loc/scratch/4593262/pasa.1669402029-0.304084447519021.+.in at /usr/local/src/PASApipeline/PerlLib/CDNA/PASA_alignment_assembler.pm line 232, <$fh> line 15803.

Error, 17 threads failed.
Error, cmd: /usr/local/src/PASApipeline/scripts/assemble_clusters.dbi -G /home/kalavatt/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta  -M '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial/sample_mydb_pasa.sqlite'  -T 2  > sample_mydb_pasa.sqlite.pasa_alignment_assembly_building.ascii_illustrations.out died with ret 7424 No such file or directory at /usr/local/src/PASApipeline/PerlLib/Pipeliner.pm line 187.
    Pipeliner::run(Pipeliner=HASH(0x556e467dd2e8)) called at /usr/local/src/PASApipeline/Launch_PASA_pipeline.pl line 1047
```

Here's how I'm calling `Launch_PASA_pipeline.pl` (`--CPU 2`):
```bash

singularity run ~/singularity-docker-etc/PASA.sif \
    ${PASAHOME}/Launch_PASA_pipeline.pl \
        -c alignAssembly.config \
        -I 1002 \
        -C \
        -R \
        -g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
        -t transcripts.fasta.clean \
        -T \
        -u transcripts.fasta \
        --transcribed_is_aligned_orient \
        --stringent_alignment_overlap 30.0 \
        --TDN tdn.accs \
        --ALIGNERS blat,gmap \
        --CPU "${SLURM_CPUS_ON_NODE}" \
            > >(tee -a stdout.log.txt) \
            2> >(tee -a stderr.log.txt >&2)
```

And here are the contents of `alignAssembly.config`:
```bash
cat << alignAssembly > "./alignAssembly.config"

## templated variables to be replaced exist as <__var_name__>

# Pathname of an SQLite database
# If the environment variable DSN_DRIVER=mysql then it is the name of a MySQL database
DATABASE=/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial/sample_mydb_pasa.sqlite



#######################################################
# Parameters to specify to specific scripts in pipeline
# create a key = "script_name" + ":" + "parameter"
# assign a value as done above.

#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0

#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50

alignAssembly
```

Contents of work directory (`ls -lhaFG`):
```bash
total 131M
drwxrws---  7 kalavatt 2.1K Nov 25 11:39 ./
drwxrws--- 14 kalavatt 1.4K Nov 25 11:11 ../
-rw-r--r--  1 kalavatt    8 Nov 25 10:03 11.ooc
-rw-rw----  1 kalavatt  788 Nov 25 09:50 alignAssembly.config
-rw-r--r--  1 kalavatt 5.2M Nov 25 10:11 alignment.validations.output
drwxr-sr-x  2 kalavatt    0 Nov 25 10:47 assemblies/
-rw-rw----  1 kalavatt  679 Nov 24 19:07 bak.alignAssembly.config
-rw-rw----  1 kalavatt  19M Nov 24 14:12 bak.transcripts.fasta
lrwxrwxrwx  1 kalavatt   52 Nov 25 10:03 blat.spliced_alignments.gff3 -> pblat_outdir/transcripts.fasta.clean.pslx.top_1.gff3
drwxr-s---  2 kalavatt  970 Nov 24 19:24 cleaning_1/
-rw-rw-r--  1 kalavatt 6.9K Nov 24 14:12 err_seqcl_transcripts.fasta.log
lrwxrwxrwx  1 kalavatt  188 Nov 24 13:23 genome-free_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-free_SC_all/Trinity_trial_genome-free_SC_all.Trinity.fasta
lrwxrwxrwx  1 kalavatt  195 Nov 24 13:26 genome-guided_SC_all.Trinity.fasta -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_Trinity_trial/exp_Trinity_trial_genome-guided_SC_all/Trinity_trial_genome-guided_SC_all/Trinity-GG.fasta
-rw-r--r--  1 kalavatt 4.6M Nov 25 10:03 gmap.spliced_alignments.gff3
-rw-r--r--  1 kalavatt    0 Nov 25 10:03 gmap.spliced_alignments.gff3.completed
-rw-rw-r--  1 kalavatt  880 Nov 24 14:12 outparts_cln.sort
drwxr-sr-x  2 kalavatt  223 Nov 25 10:46 pasa_run.log.dir/
drwxr-sr-x  2 kalavatt 1.2K Nov 25 10:47 __pasa_sample_mydb_pasa.sqlite_SQLite_chkpts/
-rw-r--r--  1 kalavatt 6.9K Nov 25 10:47 __pasa_sample_mydb_pasa.sqlite_SQLite_chkpts.cmds_log
drwxr-sr-x  3 kalavatt  134 Nov 25 11:39 pblat_outdir/
-rw-r--r--  1 kalavatt  16M Nov 25 10:47 sample_mydb_pasa.sqlite
-rw-r--r--  1 kalavatt 155K Nov 25 10:19 sample_mydb_pasa.sqlite.failed_blat_alignments.gff3
-rw-r--r--  1 kalavatt 321K Nov 25 10:20 sample_mydb_pasa.sqlite.failed_blat_alignments.gtf
-rw-r--r--  1 kalavatt  82K Nov 25 10:27 sample_mydb_pasa.sqlite.failed_gmap_alignments.gff3
-rw-r--r--  1 kalavatt 187K Nov 25 10:27 sample_mydb_pasa.sqlite.failed_gmap_alignments.gtf
-rw-r--r--  1 kalavatt 8.1K Nov 25 10:47 sample_mydb_pasa.sqlite.pasa_alignment_assembly_building.ascii_illustrations.out
-rw-r--r--  1 kalavatt 546K Nov 25 10:36 sample_mydb_pasa.sqlite.polyAsites.fasta
-rw-r--r--  1 kalavatt 1.8M Nov 25 10:15 sample_mydb_pasa.sqlite.valid_blat_alignments.bed
-rw-r--r--  1 kalavatt 2.3M Nov 25 10:13 sample_mydb_pasa.sqlite.valid_blat_alignments.gff3
-rw-r--r--  1 kalavatt 6.2M Nov 25 10:19 sample_mydb_pasa.sqlite.valid_blat_alignments.gtf
-rw-r--r--  1 kalavatt 1.9M Nov 25 10:23 sample_mydb_pasa.sqlite.valid_gmap_alignments.bed
-rw-r--r--  1 kalavatt 2.3M Nov 25 10:21 sample_mydb_pasa.sqlite.valid_gmap_alignments.gff3
-rw-r--r--  1 kalavatt 6.5M Nov 25 10:27 sample_mydb_pasa.sqlite.valid_gmap_alignments.gtf
-rw-rw-r--  1 kalavatt 1002 Nov 24 14:12 seqcl_transcripts.fasta.log
-rw-rw----  1 kalavatt  40K Nov 25 11:19 stderr.log.clean.txt
-rw-rw----  1 kalavatt  55K Nov 25 10:47 stderr.log.txt
-rw-rw----  1 kalavatt  682 Nov 25 10:04 stdout.log.txt
-rw-rw----  1 kalavatt 218K Nov 24 13:58 tdn.accs
-rw-r--r--  1 kalavatt    0 Nov 25 10:03 tmp-5937-85746-out
-rw-r--r--  1 kalavatt    0 Nov 25 10:03 tmp-5937-85746-out.tmp.1
-rw-rw----  1 kalavatt  19M Nov 24 13:50 transcripts.fasta
-rw-rw-r--  1 kalavatt 1.1M Nov 24 14:12 transcripts.fasta.cidx
-rw-rw-r--  1 kalavatt  19M Nov 24 14:12 transcripts.fasta.clean
-rw-r--r--  1 kalavatt 1.1M Nov 25 10:04 transcripts.fasta.clean.cidx
-rw-r--r--  1 kalavatt 816K Nov 25 09:58 transcripts.fasta.clean.fai
-rw-rw-r--  1 kalavatt 1.3M Nov 24 14:12 transcripts.fasta.cln
```
</details>

<a id="response-from-brian-2022-1125"></a>
##### Response from Brian (2022-1125)
Hi Kris,

It looks like it can't access `/loc/scratch/`

Assuming `/loc/scratch` exists on your system, you might just need to bind that area in your singularity command. Something like this:

```bash
singularity -B /loc/scratch -B `pwd` run ......
```

the `-B` *bactick* `pwd` *backtick* just adds in your current working directory too, which I think happens automatically, but probably safer to just include it explicitly given that we're binding another area too.

best,

~b

<a id="follow-up-from-me-2022-1125"></a>
##### Follow-up from me (2022-1125)
Thanks, Brian! Will `Launch_PASA_pipeline.pl` pick up with the step it left off at?

-Kris

<a id="follow-up-response-from-brian-2022-1125"></a>
##### Follow-up response from Brian (2022-1125)
Yes, should pick up where it left off.

best of luck!

~~`#DONE` Copy in the responses from Brian Haas to my questions (copy those in as well)~~  
~~`#DONE` Move forward with the `PASA` pipeline taking into account Brian's suggestions~~

<a id="attempt-to-continue-launch_pasa_pipelinepl-following-brian-haas-advice-2022-1126"></a>
### Attempt to continue `Launch_PASA_pipeline.pl` following Brian Haas' advice (2022-1126)
<a id="understanding-tmux-on-fhcc-rhino"></a>
#### Understanding `tmux` on FHCC `rhino`
```bash
#!/bin/bash
#DONTRUN

#  Testing tmux, starting from local ------------------------------------------
#  Start a session --------------------
ssh rhino   # rhino01

tmux new -s PASA

exit

#  Is the session maintained? ---------
ssh rhino   # rhino03

tmux ls
# PASA: 1 windows (created Fri Nov 25 09:23:21 2022) [247x49]
#  The session is maintained; wait, actually, this 'PASA' is the one I set up
#+ yesterday: It's specific to rhino03 and I'm not actually on the one I just
#+ started on rhino01
#DONE Look into using tmux with rhino/gizmo more later
```

Important info on using [`tmux`](https://tmuxcheatsheet.com/) with FHCC rhino from [this link](https://sciwiki.fredhutch.org/scicomputing/access_methods/#screen-and-tmux):
> A note about screen: `ssh rhino` will assign you to one of the available, specific servers (i.e., `rhino01`, `rhino02`, `rhino03`) and screen instances are not shared across the servers. If you are interested in using screen to run a persistent session on the `rhino` cluster, consider:
>
>1. accessing a specific server directly, e.g., `ssh rhino01`
>2. making note of which server you have logged into by `ssh rhino` and then log directly into it on your next session

<a id="set-things-up-get-into-the-work-directory"></a>
#### Set things up, get into the work directory
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  On rhino3 right now...
tmux a -t PASA

#  Get on a compute node
grabnode  # Two cores and default settings

echo "${SLURM_CPUS_ON_NODE}"  # 2

#  Load in Singularity
ml Singularity/3.5.3

#  Get into the work directory
cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial" \
    || echo "cd'ing failed; check on this"

export PASAHOME=/usr/local/src/PASApipeline

#  Check that we have an "alignAssembly.config"
if [[ -f alignAssembly.config ]]; then
	echo "./alignAssembly.config is present"
else
	echo "./alignAssembly.config is not present; generate it"
fi
# ./alignAssembly.config is present
```

<a id="drawing-on-brians-advicetesting-out-singularity---bind-arguments"></a>
#### Drawing on Brian's advice/testing out `singularity --bind` arguments
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Does /loc/scratch exist?
ls -lhaFG /loc/scratch
# total 176K
# drwxr-xr-x  35 root         4.0K Nov 26 08:18 ./
# drwxr-xr-x   4 root         4.0K Jan 20  2021 ../
# drwxr-xr-x   2 fgao         4.0K Aug 25  2021 36150564/
# drwxr-xr-x   3 nespy        4.0K Nov 25 13:20 4600230/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:08 4609096/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:08 4609097/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:08 4609098/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:08 4609099/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:08 4609100/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:08 4609101/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609113/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609114/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609115/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609116/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609117/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609118/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609119/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609120/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609121/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609122/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609123/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:13 4609124/
# drwxr-xr-x   2 kalavatt     4.0K Nov 26 08:32 4609128/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609139/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609140/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609141/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609142/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609143/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609144/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609145/
# drwxr-xr-x   3 cwolock      4.0K Nov 26 08:18 4609146/
# drwxr-xr-x   3 pbradley     4.0K Apr 11  2022 53441931/
# drwx------   2 macaque-svc  4.0K Jan 20  2021 macaque-svc/
# drwx------ 723 marmoset-svc  36K Oct 15 23:42 marmoset-svc/
# drwx------   6 smrtanalysis 4.0K Aug  9 17:07 smrtlink/
#  OK, so we know /loc/scratch exists

#  Test out the binding suggested by Brian advice
singularity shell \
	--bind /loc/scratch \
	--bind $(pwd) \
	~/singularity-docker-etc/PASA.sif
# WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial, may not be available
# bash: _powerline_status_wrapper: command not found
# bash: _omb_util_prompt_command_hook: command not found
# Singularity>

#  In the container shell now...
ls -lhaFG /loc/scratch
# total 172K
# drwxr-xr-x  35 root     4.0K Nov 26 08:18 ./
# drwxr-xr-x   3 kalavatt   60 Nov 26 08:36 ../
# drwxr-xr-x   2    61515 4.0K Aug 25  2021 36150564/
# drwxr-xr-x   3    59763 4.0K Nov 25 13:20 4600230/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:08 4609096/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:08 4609097/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:08 4609098/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:08 4609099/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:08 4609100/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:08 4609101/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609113/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609114/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609115/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609116/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609117/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609118/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609119/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609120/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609121/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609122/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609123/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:13 4609124/
# drwxr-xr-x   2 kalavatt 4.0K Nov 26 08:32 4609128/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609139/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609140/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609141/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609142/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609143/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609144/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609145/
# drwxr-xr-x   3    75929 4.0K Nov 26 08:18 4609146/
# drwxr-xr-x   3    40534 4.0K Apr 11  2022 53441931/
# drwx------   2     9464 4.0K Jan 20  2021 macaque-svc/
# drwx------ 723     5133  36K Oct 15 23:42 marmoset-svc/
# drwx------   6     9277 4.0K Aug  9 17:07 smrtlink/

ls -lhaFG /mnt/data
# ls: cannot access '/mnt/data': No such file or directory

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_PASA_trial

cd /
ls -lhaFG
# total 288K
# drwxr-xr-x   1 kalavatt  100 Nov 26 08:36 ./
# drwxr-xr-x   1 kalavatt  100 Nov 26 08:36 ../
# lrwxrwxrwx   1 root       27 Nov 23 12:12 .exec -> .singularity.d/actions/exec*
# lrwxrwxrwx   1 root       26 Nov 23 12:12 .run -> .singularity.d/actions/run*
# lrwxrwxrwx   1 root       28 Nov 23 12:12 .shell -> .singularity.d/actions/shell*
# drwxr-xr-x   5 root      127 Nov 23 12:12 .singularity.d/
# lrwxrwxrwx   1 root       27 Nov 23 12:12 .test -> .singularity.d/actions/test*
# lrwxrwxrwx   1 root        7 Jul 23  2021 bin -> usr/bin/
# drwxr-xr-x   2 root        3 Apr 15  2020 boot/
# drwxr-xr-x  17 root     4.4K Nov 14 10:21 dev/
# lrwxrwxrwx   1 root       36 Nov 23 12:12 environment -> .singularity.d/env/90-environment.sh*
# drwxr-xr-x  53 root     1.8K Aug  6  2021 etc/
# drwxr-xr-x   3 kalavatt   60 Nov 26 08:36 fh/
# drwxr-xr-x   1 kalavatt   60 Nov 26 08:36 home/
# lrwxrwxrwx   1 root        7 Jul 23  2021 lib -> usr/lib/
# lrwxrwxrwx   1 root        9 Jul 23  2021 lib32 -> usr/lib32/
# lrwxrwxrwx   1 root        9 Jul 23  2021 lib64 -> usr/lib64/
# lrwxrwxrwx   1 root       10 Jul 23  2021 libx32 -> usr/libx32/
# drwxr-xr-x   3 kalavatt   60 Nov 26 08:36 loc/
# drwxr-xr-x   2 root        3 Jul 23  2021 media/
# drwxr-xr-x   2 root        3 Jul 23  2021 mnt/
# drwxr-xr-x   2 root        3 Jul 23  2021 opt/
# dr-xr-xr-x 624 root        0 Sep 10 16:01 proc/
# drwx------   3 root       90 Feb  3  2022 root/
# drwxr-xr-x   8 root      124 Aug  6  2021 run/
# lrwxrwxrwx   1 root        8 Jul 23  2021 sbin -> usr/sbin/
# lrwxrwxrwx   1 root       24 Nov 23 12:12 singularity -> .singularity.d/runscript*
# drwxr-xr-x   2 root        3 Jul 23  2021 srv/
# dr-xr-xr-x  13 root        0 Sep 10 16:01 sys/
# drwxrwxrwt  42 root     284K Nov 26 08:39 tmp/
# drwxr-xr-x  14 root      241 Aug  6  2021 usr/
# drwxr-xr-x  11 root      172 Jul 23  2021 var/

#  OK, it seems to work; exit the container shell
exit
```

<a id="continuing-the-pasa-pipeline-from-where-it-left-off-yesterday"></a>
#### Continuing the `PASA` pipeline from where it left off yesterday
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get into the appropriate conda/mamba environment
Trinity_env

#  Rename the std{err,out} files from yesterday so that they're not overwritten
mamba install -c bioconda rename

ls -lhaFG std{err,out}.*.txt
# -rw-rw---- 1 kalavatt 40K Nov 25 11:19 stderr.log.clean.txt
# -rw-rw---- 1 kalavatt 55K Nov 25 10:47 stderr.log.txt
# -rw-rw---- 1 kalavatt 682 Nov 25 10:04 stdout.log.txt

rename -n 's/std/attempt-2022-1125.std/g' std{err,out}.*.txt
# 'stderr.log.clean.txt' would be renamed to 'attempt-2022-1125.stderr.log.clean.txt'
# 'stderr.log.txt' would be renamed to 'attempt-2022-1125.stderr.log.txt'
# 'stdout.log.txt' would be renamed to 'attempt-2022-1125.stdout.log.txt'

rename -n 's/log.txt/log.attempt-2022-1125.txt/g' std{err,out}.*.txt
# 'stderr.log.txt' would be renamed to 'stderr.log.attempt-2022-1125.txt'
# 'stdout.log.txt' would be renamed to 'stdout.log.attempt-2022-1125.txt'

rename 's/log.txt/log.attempt-2022-1125.txt/g' std{err,out}.*.txt
rename 's/clean.txt/clean.attempt-2022-1125.txt/g' std{err,out}.*.txt

ls -lhaFG std{err,out}.*.txt
# -rw-rw---- 1 kalavatt 55K Nov 25 10:47 stderr.log.attempt-2022-1125.txt
# -rw-rw---- 1 kalavatt 40K Nov 25 11:19 stderr.log.clean.attempt-2022-1125.txt
# -rw-rw---- 1 kalavatt 682 Nov 25 10:04 stdout.log.attempt-2022-1125.txt

#  Launch Launch_PASA_pipeline.pl with the specified --bind arguments; the
#+ pipeline should pick up where it left off
singularity run \
	--bind /loc/scratch \
	--bind $(pwd) \
	~/singularity-docker-etc/PASA.sif \
	    ${PASAHOME}/Launch_PASA_pipeline.pl \
	        -c alignAssembly.config \
	        -I 1002 \
	        -C \
	        -R \
	        -g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
	        -t transcripts.fasta.clean \
	        -T \
	        -u transcripts.fasta \
	        --transcribed_is_aligned_orient \
	        --stringent_alignment_overlap 30.0 \
	        --TDN tdn.accs \
	        --ALIGNERS blat,gmap \
	        --CPU "${SLURM_CPUS_ON_NODE}" \
	            > >(tee -a stdout.log.txt) \
	            2> >(tee -a stderr.log.txt >&2)
#  It's running...
```

<a id="checking-on-output-from-completion-of-the-pasa-pipeline"></a>
#### Checking on output from completion of the `PASA` pipeline
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  The pipeline completed at ~0931; it seems to have completed successfully
rename -n 's/log.txt/log.attempt-2022-1126.txt/g' std{err,out}.log.txt
# 'stderr.log.txt' would be renamed to 'stderr.log.attempt-2022-1126.txt'
# 'stdout.log.txt' would be renamed to 'stdout.log.attempt-2022-1126.txt'

rename 's/log.txt/log.attempt-2022-1126.txt/g' std{err,out}.log.txt

#  Created a "clean" version of STDERR by hand (by "clean", I mean I removed
#+ all Perl locale warnings)

ls -lhaFG std*.txt
# -rw-rw---- 1 kalavatt 55K Nov 25 10:47 stderr.log.attempt-2022-1125.txt
# -rw-rw---- 1 kalavatt 40K Nov 26 09:27 stderr.log.attempt-2022-1126.txt
# -rw-rw---- 1 kalavatt 40K Nov 25 11:19 stderr.log.clean.attempt-2022-1125.txt
# -rw-rw---- 1 kalavatt 33K Nov 26 09:43 stderr.log.clean.attempt-2022-1126.txt
# -rw-rw---- 1 kalavatt 682 Nov 25 10:04 stdout.log.attempt-2022-1125.txt
# -rw-rw---- 1 kalavatt 197 Nov 26 09:31 stdout.log.attempt-2022-1126.txt

#  It seems we can generate reports based on the output from running the
#+ pipeline; apparently, we need to launch PasaWeb following the instructions
#+ here:
#+ 
#+ github.com/PASApipeline/PASApipeline/wiki/PasaWeb
```

`#TODO` Learn to use and launch [`PasaWeb`](https://github.com/PASApipeline/PASApipeline/wiki/PasaWeb) to get quality metrics, etc. for the `PASA`-pipeline output
<br />
<br />

<a id="setting-up-the-preprocessing-pipeline-for-trinity"></a>
## Setting up the preprocessing pipeline for `Trinity`
...for genome-free transcriptome assembly (will also influence *at least* one step of genome-guided transcriptome assembly); draws on material presented [here](https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html)

<a id="getting-started-2022-1125-2022-1126"></a>
### Getting started (2022-1125, 2022-1126)
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" \
    || echo "cd'ing failed; check on this"

Trinity_env

conda list
```

<details>
<summary><i>Printed to terminal:</i></summary>

```txt
# packages in environment at /home/kalavatt/miniconda3/envs/Trinity_env:
#
# Name                    Version                   Build  Channel
_libgcc_mutex             0.1                 conda_forge    conda-forge
_openmp_mutex             4.5                       2_gnu    conda-forge
bedtools                  2.30.0               h7d7f7ad_2    bioconda
bz2file                   0.98             py37h06a4308_1
bzip2                     1.0.8                h7b6447c_0
ca-certificates           2022.10.11           h06a4308_0
certifi                   2022.9.24        py37h06a4308_0
cutadapt                  2.6              py37h516909a_0    bioconda
dbus                      1.13.18              hb2f20db_0
dnaio                     0.3              py37h14c3975_1    bioconda
expat                     2.4.9                h6a678d5_0
fastqc                    0.11.9               hdfd78af_1    bioconda
font-ttf-dejavu-sans-mono 2.37                 hd3eb1b0_0
fontconfig                2.13.1               hef1e5e3_1
freetype                  2.12.1               h4a9f257_0
gdbm                      1.18                 hd4cb3f1_4
gettext                   0.21.1               h27087fc_0    conda-forge
glib                      2.70.2               h780b84a_4    conda-forge
glib-tools                2.70.2               h780b84a_4    conda-forge
icu                       58.2                 he6710b0_3
kmer-jellyfish            2.3.0                h9f5acd7_3    bioconda
ld_impl_linux-64          2.38                 h1181459_1
libffi                    3.4.2                h7f98852_5    conda-forge
libgcc-ng                 12.2.0              h65d4601_19    conda-forge
libglib                   2.70.2               h174f98d_4    conda-forge
libgomp                   12.2.0              h65d4601_19    conda-forge
libiconv                  1.17                 h166bdaf_0    conda-forge
libnsl                    2.0.0                h7f98852_0    conda-forge
libpng                    1.6.37               hbc83047_0
libstdcxx-ng              11.2.0               h1234567_1
libuuid                   1.41.5               h5eee18b_0
libxcb                    1.15                 h7f8727e_0
libxml2                   2.9.14               h74e7548_0
libzlib                   1.2.13               h166bdaf_4    conda-forge
ncurses                   6.3                  h5eee18b_3
openjdk                   11.0.13              h87a67e3_0
openssl                   3.0.7                h166bdaf_0    conda-forge
pcre                      8.45                 h295c915_0
perl                      5.34.0               h5eee18b_2
pigz                      2.6                  h27cfd23_0
pip                       22.2.2           py37h06a4308_0
python                    3.7.12          hf930737_100_cpython    conda-forge
rcorrector                1.0.4                h2e03b76_2    bioconda
readline                  8.2                  h5eee18b_0
semver                    2.13.0             pyh9f0ad1d_0    conda-forge
setuptools                65.5.0           py37h06a4308_0
spython                   0.2.14             pyhd8ed1ab_0    conda-forge
sqlite                    3.39.3               h5082296_0
star                      2.7.10b              h9ee0642_0    bioconda
tk                        8.6.12               h1ccaba5_0
trim-galore               0.6.7                hdfd78af_0    bioconda
wheel                     0.37.1             pyhd3eb1b0_0
xopen                     0.7.3                      py_0    bioconda
xz                        5.2.6                h5eee18b_0
zlib                      1.2.13               h166bdaf_4    conda-forge
``` 
</details>
<br />

`#DEKHO`  
`#REMEMBER` Per Alison, "IP" = Nascent, "IN" = SteadyState
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" \
    || echo "cd'ing failed; check on this"

Trinity_env
mamba install -c conda-forge parallel
mamba install -c bioconda samtools

mkdir -p exp_preprocessing/{01_fastqc,02_trim_galore,03_fastqc,04a_star-genome-free,04b_star-genome-guided,05a_fastqc,05b_fastqc,06_bam-to-fastq,07_fastqc,08_rcorrector}


#  1. FastQC ------------------------------------------------------------------
if [[ -f submit-preprocessing-fastqc.sh ]]; then
	rm submit-preprocessing-fastqc.sh
fi
cat << script > "./submit-preprocessing-fastqc.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --error=./exp_preprocessing/submit-preprocessing-fastqc.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-fastqc.%J.out.txt

#  submit-preprocessing-fastqc.sh
#  KA
#  $(date '+%Y-%m%d')


infile="\${1}"
outdir="\${2}"

fastqc \\
    --threads "\${SLURM_CPUS_ON_NODE}" \\
    --outdir "\${outdir}" \\
    "\${infile}"
script
# vi submit-preprocessing-fastqc.sh

unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "files_fastq_symlinks" \
        -type l \
        -name *_Q_IN_* \
        -print0 \
            | sort -z \
)
for i in "${infiles[@]}"; do echo "${i}"; done
# files_fastq_symlinks/5781_Q_IN_merged_R1.fastq
# files_fastq_symlinks/5781_Q_IN_merged_R2.fastq
# files_fastq_symlinks/5782_Q_IN_merged_R1.fastq
# files_fastq_symlinks/5782_Q_IN_merged_R2.fastq

#  Submit jobs
for i in "${infiles[@]}"; do
	echo "Working with ${i}..."
	sbatch submit-preprocessing-fastqc.sh \
		"${i}" \
		"exp_preprocessing/01_fastqc/"
	sleep 0.25
	echo ""
done

unset infiles


#  2. Trim Galore -------------------------------------------------------------
unset infiles
unset intermediate
unset duplicates
unset instrings

typeset -a infiles
typeset -a intermediate
typeset -A duplicates
typeset -a instrings

while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "files_fastq_symlinks" \
        -type l \
        -name *_Q_IN_* \
        -print0 \
            | sort -z \
)
# for i in "${infiles[@]}"; do echo "${i}"; done
# # files_fastq_symlinks/5781_Q_IN_merged_R1.fastq
# # files_fastq_symlinks/5781_Q_IN_merged_R2.fastq
# # files_fastq_symlinks/5782_Q_IN_merged_R1.fastq
# # files_fastq_symlinks/5782_Q_IN_merged_R2.fastq

for i in "${infiles[@]}"; do
	intermediate+=( "${i%_R?.fastq}" )
done
# for i in "${intermediate[@]}"; do echo "${i}"; done
# # files_fastq_symlinks/5781_Q_IN_merged
# # files_fastq_symlinks/5781_Q_IN_merged
# # files_fastq_symlinks/5782_Q_IN_merged
# # files_fastq_symlinks/5782_Q_IN_merged

for i in "${intermediate[@]}"; do
	if [[ -z "${duplicates[$i]}" ]]; then
        instrings+=( "${i}" )
    fi
    duplicates["${i}"]=1
done

# echo "Duplicates..."
# for i in "${!duplicates[@]}"; do echo "${i}"; done
# # files_fastq_symlinks/5782_Q_IN_merged
# # files_fastq_symlinks/5781_Q_IN_merged
# echo ""
#
# echo "Instrings..."
# for i in "${instrings[@]}"; do echo "${i}"; done
# # files_fastq_symlinks/5781_Q_IN_merged
# # files_fastq_symlinks/5782_Q_IN_merged
# echo ""

if [[ -f submit-preprocessing-trim_galore.sh ]]; then
	rm submit-preprocessing-trim_galore.sh
fi
cat << script > "./submit-preprocessing-trim_galore.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error=./exp_preprocessing/submit-preprocessing-trim_galore.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-trim_galore.%J.out.txt

#  submit-preprocessing-trim_galore.sh
#  KA
#  $(date '+%Y-%m%d')


instring="\${1}"
outdir="\${2}"

#  Echo test
parallel --header : --colsep " " -k -j 1 echo \\
"trim_galore \\
	--paired \\
	--retain_unpaired \\
	--phred33 \\
	--output_dir {outdir} \\
	--length 36 \\
	--quality 5 \\
	--stringency 1 \\
	-e 0.1 \\
	{sample}_R1.fastq \\
	{sample}_R2.fastq" \\
::: sample "\${instring}" \\
::: outdir "\${outdir}"

#  Run trim_galore
parallel --header : --colsep " " -k -j 1 \\
"trim_galore \\
	--paired \\
	--retain_unpaired \\
	--phred33 \\
	--output_dir {outdir} \\
	--length 36 \\
	--quality 5 \\
	--stringency 1 \\
	-e 0.1 \\
	{sample}_R1.fastq \\
	{sample}_R2.fastq" \\
::: sample "\${instring}" \\
::: outdir "\${outdir}"

echo ""
script
# vi submit-preprocessing-trim_galore.sh

#  Submit jobs
for i in "${instrings[@]}"; do
	echo "Working with ${i}..."
	sbatch submit-preprocessing-trim_galore.sh \
		"${i}" \
		"exp_preprocessing/02_trim_galore/"
	sleep 0.25
	echo ""
done

unset infiles
unset intermediate
unset duplicates
unset instrings
#TODO Compress .fastq output from trim_galore


#  3. FastQC ------------------------------------------------------------------
unset infiles_trimmed
unset infiles_trimmed_unpaired

typeset -a infiles_trimmed
typeset -a infiles_trimmed_unpaired

while IFS=" " read -r -d $'\0'; do
    infiles_trimmed+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/02_trim_galore" \
        -type f \
        -name *val*.fq \
        -print0 \
            | sort -z \
)
# for i in "${infiles_trimmed[@]}"; do echo "${i}"; done
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged_R1_val_1.fq
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged_R2_val_2.fq
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged_R1_val_1.fq
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged_R2_val_2.fq

while IFS=" " read -r -d $'\0'; do
    infiles_trimmed_unpaired+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/02_trim_galore" \
        -type f \
        -name *unpaired*.fq \
        -print0 \
            | sort -z \
)
for i in "${infiles_trimmed_unpaired[@]}"; do echo "${i}"; done

for i in "${infiles_trimmed[@]}"; do
	echo "Working with ${i}..."
	sbatch submit-preprocessing-fastqc.sh \
		"${i}" \
		"exp_preprocessing/03_fastqc/"
	sleep 0.25
	echo ""
done

for i in "${infiles_trimmed_unpaired[@]}"; do
	echo "Working with ${i}..."
	sbatch submit-preprocessing-fastqc.sh \
		"${i}" \
		"exp_preprocessing/03_fastqc/"
	sleep 0.25
	echo ""
done

unset infiles_trimmed
unset infiles_trimmed_unpaired
```

<a id="set-up-the-star-alignment-steps-and-sub-steps-2022-1126"></a>
### Set up the STAR alignment steps and sub-steps (2022-1126)
```bash
#  4. STAR --------------------------------------------------------------------
#  Check on STAR
# which STAR
# # /home/kalavatt/miniconda3/envs/Trinity_env/bin/STAR

# STAR --version
# # 2.7.10b

#  Check on samtools
# which samtools
# # /home/kalavatt/.local/bin/samtools

#  Why is not giving me the path to the conda/mamba installation?
#+ 
#+ Go into .bashrc and comment out line 189:
#+ export PATH="$HOME/.local/bin:$PATH"
#+ 
#+ Then, reinitialize the shell, reactivate Trinity_env, and see if this fixes
#+ things

# which samtools
# # /home/kalavatt/miniconda3/envs/Trinity_env/bin/samtools

# samtools --version
# # samtools 1.15
# # Using htslib 1.14
# # ...

#  So yes, that fixes things, but...
#REMEMBER 1/2 If/when returning to picardmetrics work, line 189 in .bashrc 
#REMEMBER 2/2 regarding /home/kalavatt/.local/bin/samtools is commented out
```

<a id="set-up-star-alignment-for-genome-free-assembly-2022-1126"></a>
#### Set up STAR alignment for genome-free assembly (2022-1126)
```bash
#!/bin/bash
#DONTRUN


#  Get the files into an array --------
unset infiles_trimmed
unset intermediate
unset duplicates
unset instrings

typeset -a infiles_trimmed
typeset -a intermediate
typeset -A duplicates
typeset -a instrings

while IFS=" " read -r -d $'\0'; do
    infiles_trimmed+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/02_trim_galore" \
        -type f \
        -name *val*.fq \
        -print0 \
            | sort -z \
)
# for i in "${infiles_trimmed[@]}"; do echo "${i}"; done
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged_R1_val_1.fq
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged_R2_val_2.fq
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged_R1_val_1.fq
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged_R2_val_2.fq

for i in "${infiles_trimmed[@]}"; do
	intermediate+=( "${i%_R?_val_?.fq}" )
done
# for i in "${intermediate[@]}"; do echo "${i}"; done
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged

for i in "${intermediate[@]}"; do
	if [[ -z "${duplicates[$i]}" ]]; then
        instrings+=( "${i}" )
    fi
    duplicates["${i}"]=1
done

# echo "Duplicates..."
# for i in "${!duplicates[@]}"; do echo "${i}"; done
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged
# echo ""
#
# echo "Instrings..."
# for i in "${instrings[@]}"; do echo "${i}"; done
# # exp_preprocessing/02_trim_galore/5781_Q_IN_merged
# # exp_preprocessing/02_trim_galore/5782_Q_IN_merged
# echo ""


#  4a. For genome-free assembly -------
unset genome_dir
unset threads

genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"
threads=8

if [[ -f submit-preprocessing-star-genome-free.sh ]]; then
	rm submit-preprocessing-star-genome-free.sh
fi
cat << script > "./submit-preprocessing-star-genome-free.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-star-genome-free.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-star-genome-free.%J.out.txt

#  submit-preprocessing-star-genome-free.sh
#  KA
#  $(date '+%Y-%m%d')


read_1="\${1}"
read_2="\${2}"
prefix="\${3}"

STAR \\
    --runMode alignReads \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMtype BAM SortedByCoordinate \\
    --outSAMunmapped Within \\
    --outSAMattributes All \\
    --genomeDir "${genome_dir}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax 1 \\
    --alignSJoverhangMin 8 \\
    --alignSJDBoverhangMin 1 \\
    --outFilterMismatchNmax 999 \\
    --alignIntronMin 4 \\
    --alignIntronMax 5000 \\
    --alignMatesGapMax 5000
script
# vi submit-preprocessing-star-genome-free.sh

for i in "${instrings[@]}"; do
	echo "Working with ${i}..."
	sbatch ./submit-preprocessing-star-genome-free.sh \
	    "${i}_R1_val_1.fq" \
	    "${i}_R2_val_2.fq" \
	    "exp_preprocessing/04a_star-genome-free/$(basename "${i}")"
	sleep 0.25
	echo ""
done


# -----------------
#  Filter out unmapped reads
unset infiles_aligned
typeset -a infiles_aligned

while IFS=" " read -r -d $'\0'; do
    infiles_aligned+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/04a_star-genome-free" \
        -type f \
        -name *out.bam \
        -print0 \
            | sort -z \
)
# for i in "${infiles_aligned[@]}"; do echo "${i}"; done
# # exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# # exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.bam

# -------
#  First index the bam files
unset threads
typeset threads=2

if [[ -f submit-preprocessing-index-bam.sh ]]; then
	rm submit-preprocessing-index-bam.sh
fi
cat << script > "./submit-preprocessing-index-bam.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-index-bam.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-index-bam.%J.out.txt

#  submit-preprocessing-index-bam.sh
#  KA
#  $(date '+%Y-%m%d')

bam="\${1}"

samtools index -@ ${threads} "\${bam}"
script
# vi submit-preprocessing-index-bam.sh

for i in "${infiles_aligned[@]}"; do
	echo "Working with ${i}..."
	sbatch ./submit-preprocessing-index-bam.sh "${i}"
	sleep 0.25
	echo ""
done

# -------
#  Now, filter the bam files to exclude unmapped reads
unset threads
typeset threads=4

if [[ -f submit-preprocessing-exclude-bam-reads-unmapped.sh ]]; then
	rm submit-preprocessing-exclude-bam-reads-unmapped.sh
fi
cat << script > "./submit-preprocessing-exclude-bam-reads-unmapped.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-exclude-bam-reads-unmapped.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-exclude-bam-reads-unmapped.%J.out.txt

#  submit-preprocessing-index-bam.sh
#  KA
#  $(date '+%Y-%m%d')


infile="\${1}"
outdir="\${2}"
outfile="\${3}"

samtools view \\
    -@ "${threads}" \\
    -b -F 0x4 -F 0x8 \\
    "\${infile}" \\
    -o "\${outdir}/\${outfile}"
script
# vi submit-preprocessing-exclude-bam-reads-unmapped.sh

for i in "${infiles_aligned[@]}"; do
	echo "Working with ${i}..."
	echo " - outdir is $(dirname "${i}")"
	echo " - outfile is $(basename "${i}" ".bam").unmapped.bam"

	sbatch ./submit-preprocessing-exclude-bam-reads-unmapped.sh \
		"${i}" \
		"$(dirname "${i}")" \
		"$(basename "${i}" ".bam").unmapped.bam"
	sleep 0.25
	echo ""
done


# -----------------
#  Now, index the filtered bam files
unset threads
typeset threads=2

for i in "${infiles_aligned[@]}"; do
	echo "Working with ${i%.bam}.unmapped.bam..."
	sbatch ./submit-preprocessing-index-bam.sh "${i%.bam}.unmapped.bam"
	sleep 0.25
	echo ""
done
```

<a id="set-up-star-alignment-for-genome-guided-assembly-2022-1126"></a>
#### Set up STAR alignment for genome-guided assembly (2022-1126)
```bash
#!/bin/bash
#DONTRUN


#  Get the files into an array --------
unset infiles_trimmed
unset intermediate
unset duplicates
unset instrings

typeset -a infiles_trimmed
typeset -a intermediate
typeset -A duplicates
typeset -a instrings

while IFS=" " read -r -d $'\0'; do
    infiles_trimmed+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/02_trim_galore" \
        -type f \
        -name *val*.fq \
        -print0 \
            | sort -z \
)
# for i in "${infiles_trimmed[@]}"; do echo "${i}"; done

for i in "${infiles_trimmed[@]}"; do
	intermediate+=( "${i%_R?_val_?.fq}" )
done
# for i in "${intermediate[@]}"; do echo "${i}"; done

for i in "${intermediate[@]}"; do
	if [[ -z "${duplicates[$i]}" ]]; then
        instrings+=( "${i}" )
    fi
    duplicates["${i}"]=1
done

# echo "Duplicates..."
# for i in "${!duplicates[@]}"; do echo "${i}"; done
# echo ""

# echo "Instrings..."
# for i in "${instrings[@]}"; do echo "${i}"; done
# echo ""


#  4b. For genome-guided assembly -------
unset genome_dir
unset threads

genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"
threads=8

if [[ -f submit-preprocessing-star-genome-guided.sh ]]; then
	rm submit-preprocessing-star-genome-guided.sh
fi
cat << script > "./submit-preprocessing-star-genome-guided.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-star-genome-guided.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-star-genome-guided.%J.out.txt

#  submit-preprocessing-star-genome-guided.sh
#  KA
#  $(date '+%Y-%m%d')


read_1="\${1}"
read_2="\${2}"
prefix="\${3}"

STAR \\
    --runMode alignReads \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMtype BAM SortedByCoordinate \\
    --outSAMunmapped Within \\
    --outSAMattributes All \\
    --genomeDir "${genome_dir}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax 1000 \\
    --winAnchorMultimapNmax 1000 \\
    --alignSJoverhangMin 8 \\
    --alignSJDBoverhangMin 1 \\
    --outFilterMismatchNmax 999 \\
    --outMultimapperOrder Random \\
    --alignEndsType EndToEnd \\
    --alignIntronMin 4 \\
    --alignIntronMax 5000 \\
    --alignMatesGapMax 5000
script
# vi submit-preprocessing-star-genome-guided.sh

for i in "${instrings[@]}"; do
	echo "Working with ${i}..."
	sbatch ./submit-preprocessing-star-genome-guided.sh \
	    "${i}_R1_val_1.fq" \
	    "${i}_R2_val_2.fq" \
	    "exp_preprocessing/04a_star-genome-free/$(basename "${i}")"
	sleep 0.25
	echo ""
done


# -----------------
#  Filter out unmapped reads
unset infiles_aligned
typeset -a infiles_aligned

while IFS=" " read -r -d $'\0'; do
    infiles_aligned+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/04b_star-genome-guided" \
        -type f \
        -name *out.bam \
        -print0 \
            | sort -z \
)
# for i in "${infiles_aligned[@]}"; do echo "${i}"; done

# -------
#  First index the bam files
unset threads
typeset threads=2

if [[ -f submit-preprocessing-index-bam.sh ]]; then
	rm submit-preprocessing-index-bam.sh
fi
cat << script > "./submit-preprocessing-index-bam.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-index-bam.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-index-bam.%J.out.txt

#  submit-preprocessing-index-bam.sh
#  KA
#  $(date '+%Y-%m%d')


bam="\${1}"

samtools index -@ ${threads} "\${bam}"
script
# vi submit-preprocessing-index-bam.sh

for i in "${infiles_aligned[@]}"; do
	echo "Working with ${i}..."
	sbatch ./submit-preprocessing-index-bam.sh "${i}"
	sleep 0.25
	echo ""
done

# -------
#  Now, filter the bam files to exclude unmapped reads
unset threads
typeset threads=4

if [[ -f submit-preprocessing-exclude-bam-reads-unmapped.sh ]]; then
	rm submit-preprocessing-exclude-bam-reads-unmapped.sh
fi
cat << script > "./submit-preprocessing-exclude-bam-reads-unmapped.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-exclude-bam-reads-unmapped.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-exclude-bam-reads-unmapped.%J.out.txt

#  submit-preprocessing-exclude-bam-reads-unmapped-bam.sh
#  KA
#  $(date '+%Y-%m%d')

infile="\${1}"
outdir="\${2}"
outfile="\${3}"


samtools view \\
    -@ "${threads}" \\
    -b -F 0x4 -F 0x8 \\
    "\${infile}" \\
    -o "\${outdir}/\${outfile}"
script
# vi submit-preprocessing-exclude-bam-reads-unmapped.sh

for i in "${infiles_aligned[@]}"; do
	echo "Working with ${i}..."
	echo " - outdir is $(dirname "${i}")"
	echo " - outfile is $(basename "${i}" ".bam").unmapped.bam"

	sbatch ./submit-preprocessing-exclude-bam-reads-unmapped.sh \
		"${i}" \
		"$(dirname "${i}")" \
		"$(basename "${i}" ".bam").unmapped.bam"
	sleep 0.25
	echo ""
done


# -----------------
#  Now, index the filtered bam files
unset threads
typeset threads=2

for i in "${infiles_aligned[@]}"; do
	echo "Working with ${i%.bam}.unmapped.bam..."
	sbatch ./submit-preprocessing-index-bam.sh "${i%.bam}.unmapped.bam"
	sleep 0.25
	echo ""
done
```

<a id="filter-bams-to-retain-only-s-cerevisiae-alignments-2022-1128"></a>
### Filter `.bam`s to retain only *S. cerevisiae* alignments (2022-1128)
`#TODO #INPROGRESS` Pick up with alignment for the two approaches, including bam-to-fastq conversion, then move on to implementing calls to `rCorrector`  
`#NOTETOSELF #THINKING #20221128` We completed the genome-free and genome-guided styles of `STAR` alignment; next step is to review my handwritten notes and then implement filtering-by-species scripts (genome-free, genome-guided) and bam-to-fastq scripts (genome-free)... and then what?  
`#NOTETOSELF #THINKING #20221128` Also, want to get some kind of rename/organization script in place for the `.bam`s output by `STAR`

```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

#  Alias: 'cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"'
#+ is "transcriptome"
transcriptome
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction

cd "./results/2022-1101" || echo "cd'ing failed; check on this"
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

#  Activate the conda environment for Trinity work
#+ Alias: 'conda activate Trinity_env' is 'Trinity_env'
Trinity_env

#  Alias: 'ls -lhaFG' is '.,'
.,
# total 2.6M
# drwxrws--- 15 kalavatt 1.6K Nov 28 07:49 ./
# drwxrws---  7 kalavatt  191 Nov 28 07:30 ../
# drwxrws---  3 kalavatt  160 Nov  9 15:23 exp_alignment_Bowtie_2/
# drwxrws---  3 kalavatt   94 Nov 20 11:06 exp_alignment_STAR/
# drwxrws---  3 kalavatt   94 Nov 18 13:04 exp_alignment_STAR_multi-hit/
# drwxrws---  4 kalavatt  190 Nov 21 12:22 exp_alignment_STAR_tags/
# drwxrws---  2 kalavatt 1.1K Nov  7 15:27 exp_FastQC/
# drwxrws---  2 kalavatt  206 Nov 20 13:40 exp_intron-length/
# drwxrws---  6 kalavatt 2.6K Nov 26 10:21 exp_PASA_trial/
# drwxrws---  2 kalavatt  854 Nov  7 14:31 exp_picardmetrics/
# drwxrws---  7 kalavatt 5.0K Nov 28 07:49 exp_preprocessing/
# drwxrws---  3 kalavatt  317 Nov  7 14:44 exp_Trinity/
# drwxrws---  4 kalavatt  242 Nov 24 12:27 exp_Trinity_trial/
# drwxrws---  3 kalavatt  720 Nov  8 10:03 files_fastq_symlinks/
# drwxrws---  2 kalavatt  726 Nov 23 15:37 notebook/
# -rw-rw----  1 kalavatt  14K Nov 16 12:23 notes-Alison-files-locations.md
# -rw-rw----  1 kalavatt  29K Nov 16 12:23 notes-Alison-papers.md
# -rw-rw----  1 kalavatt 1.3K Nov 16 12:23 notes-Alison-RNA-seq-kits.md
# -rw-rw----  1 kalavatt 8.0K Nov 25 10:11 notes-miscellaneous-links.md
# -rw-rw----  1 kalavatt 5.7K Nov 16 12:23 notes-RNA-seq-spike-ins.md
# -rw-rw----  1 kalavatt  35K Nov 18 11:33 notes-UMIs-etc.md
# -rw-rw----  1 kalavatt 209K Nov 28 07:43 scraps.md
# -rw-rw----  1 kalavatt  617 Nov  8 14:43 submit-Bowtie-2.test-1.sh
# -rw-rw----  1 kalavatt  642 Nov  8 16:16 submit-Bowtie-2.test-2.sh
# -rw-rw----  1 kalavatt  300 Nov  7 14:58 submit-FastQC.sh
# -rw-rw----  1 kalavatt  450 Nov 26 14:00 submit-preprocessing-exclude-bam-reads-unmapped.sh
# -rw-rw----  1 kalavatt  330 Nov 26 10:55 submit-preprocessing-fastqc.sh
# -rw-rw----  1 kalavatt  313 Nov 26 14:00 submit-preprocessing-index-bam.sh
# -rw-rw----  1 kalavatt  892 Nov 26 12:21 submit-preprocessing-star-genome-free.sh
# -rw-rw----  1 kalavatt 1002 Nov 26 13:52 submit-preprocessing-star-genome-guided.sh
# -rw-rw----  1 kalavatt  917 Nov 26 11:00 submit-preprocessing-trim_galore.sh
# -rw-rw----  1 kalavatt  871 Nov 18 14:52 submit-STAR-alignReads-multi-hit.sh
# -rw-rw----  1 kalavatt  874 Nov 18 14:53 submit-STAR-alignReads.tags.multi-hit-mode.sh
# -rw-rw----  1 kalavatt 1.4K Nov 18 14:38 submit-STAR-alignReads.tags.rna-star.sh
# -rw-rw----  1 kalavatt  694 Nov  3 17:41 submit-Trinity.sh
# -rw-rw----  1 kalavatt 1.2K Nov 22 14:54 submit-Trinity-trial-genome-free.sh
# -rw-rw----  1 kalavatt 1.2K Nov 22 10:47 submit-Trinity-trial-genome-guided.sh
# -rw-rw----  1 kalavatt  23K Nov 16 12:23 work-TPM-calculation.md
# -rw-rw----  1 kalavatt 310K Nov 26 10:41 work-Trinity.md


#  Set up a function for quickly checking the contents of arrays
echoTest() { for i in "${@:-*}"; do echo "${i}"; done; }


#  Create an array for .bam files of interest
unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find exp_preprocessing/04?_star-* \
        -type f \
        -name *out.bam \
        -print0 \
            | sort -z \
)
echoTest "${infiles_mapped[@]}"
# exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.bam
# exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.bam


# #  Set up function to split .bam files by species, etc.
# split_with_samtools() {
#     what="""
#     split_with_samtools()
#     ---------------------
#     Use samtools to filter a bam file such that it contains only chromosome(s)
#     specified with ${0} argument -s
# 
#     :param 1: threads <int >= 1>
#     :param 2: bam infile, including path <chr>
#     :param 3: chromosomes to retain <chr>
#     :param 4: bam outfile, including path <chr>
#     :return: param 2 filtered to include only param 3 in param 4
#     """
#     samtools view -@ "${1}" -h "${2}" ${3} -o "${4}"
# }
# 
# 
# #  Note that...
# #+ ...names of chromosomes in .bam infiles must be in the following format:
# #+   - S. cerevisiae (SC)
# #+     - I
# #+     - II
# #+     - III
# #+     - IV
# #+     - V
# #+     - VI
# #+     - VII
# #+     - VIII
# #+     - IX
# #+     - X
# #+     - XI
# #+     - XII
# #+     - XIII
# #+     - XIV
# #+     - XV
# #+     - XVI
# #+     - Mito
# #+
# #+   - K. lactis (KL)
# #+     - A
# #+     - B
# #+     - C
# #+     - D
# #+     - E
# #+
# #+   - 20 S narnavirus
# #+     - 20S
# #+
# #+ (They're in that format already.)
# 
# #  Finally, split .bam files by species, etc.
# threads=1
# chr="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito"
# split="sc_all"
# 
# for i in "${infiles_mapped[@]}"; do
# 	echo "Working with ${i}..."
# 	split_with_samtools \
# 	    "${threads}" \
# 	    "${i}" \
# 	    "${chr}" \
# 	    "${i%.bam}.${split}.bam"
# 	echo ""
# done
# 
# 
# #  Get split_with_samtools into jobs that are submitted to SLURM --------------
# #  First, remove the outfiles from the above for loop
# for i in "${infiles_mapped[@]}"; do
# 	., "${i%.bam}.${split}.bam"
# done
# # -rw-rw---- 1 kalavatt 525M Nov 28 08:51 exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# # -rw-rw---- 1 kalavatt 435M Nov 28 08:52 exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# # -rw-rw---- 1 kalavatt 1.2G Nov 28 08:53 exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# # -rw-rw---- 1 kalavatt 878M Nov 28 08:54 exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# 
# for i in "${infiles_mapped[@]}"; do
# 	rm "${i%.bam}.${split}.bam"
# done
# 
# for i in "${infiles_mapped[@]}"; do
# 	., "${i%.bam}.${split}.bam"
# done
# # ls: cannot access 'exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam': No such file or directory
# # ls: cannot access 'exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam': No such file or directory
# # ls: cannot access 'exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam': No such file or directory
# # ls: cannot access 'exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam': No such file or directory


#  Prepare the job-submission script for splitting .bam files by species ------
if [[ -f submit-preprocessing-split-bam-species.sh ]]; then
	rm submit-preprocessing-split-bam-species.sh
fi
cat << script > "./submit-preprocessing-split-bam-species.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-split-bam-species.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-split-bam-species.%J.out.txt

#  submit-preprocessing-split-bam-species.sh
#  KA
#  $(date '+%Y-%m%d')


split_with_samtools() {
    what="""
    split_with_samtools()
    ---------------------
    Use samtools to filter a bam file such that it contains only specified
    chromosome(s)

    :param 1: threads <int >= 1>
    :param 2: bam infile, including path <chr>
    :param 3: chromosomes to retain <chr>
    :param 4: bam outfile, including path <chr>
    :return: param 2 filtered to include only param 3 in param 4
    """
    samtools view -@ "\${1}" -h "\${2}" \${3} -o "\${4}"
}


infile="\${1}"
outfile="\${2}"
chromosomes="\${3}"
threads="\${4}"

split_with_samtools \\
    "\${threads}" \\
    "\${infile}" \\
    "\${chromosomes}" \\
    "\${outfile}"
script
vi submit-preprocessing-split-bam-species.sh


#  Submit jobs to split .bam files by species ---------------------------------
threads=4
chr="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito"
split="sc_all"
for i in "${infiles_mapped[@]}"; do
	echo "Submitting job for ${i}..."
	echo " - chromosomes to retain are ${chr}"
	echo " - outfile is ${i%.bam}.${split}.bam"
	echo " - running samtools with ${threads} threads"
	echo "Submission:"

	echo -e "sbatch ./submit-preprocessing-split-bam-species.sh \\ \n\
		\"${i}\" \\ \n\
		\"${i%.bam}.${split}.bam\" \\ \n\
		\"${chr}\" \\ \n\
		\"${threads}\""

	sbatch ./submit-preprocessing-split-bam-species.sh \
		"${i}" \
		"${i%.bam}.${split}.bam" \
		"${chr}" \
		"${threads}"
	sleep 0.25
	echo ""
done
```

<details>
<summary><i>sbatch ./submit-preprocessing-split-bam-species.sh, messages printed to terminal:</i></summary>

```txt
Submitting job for exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.bam...
 - chromosomes to retain are I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito
 - outfile is exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
 - running samtools with 4 threads
Submission:
sbatch ./submit-preprocessing-split-bam-species.sh \
        "exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.bam" \
        "exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
        "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito" \
        "4"
Submitted batch job 4714601

Submitting job for exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.bam...
 - chromosomes to retain are I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito
 - outfile is exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
 - running samtools with 4 threads
Submission:
sbatch ./submit-preprocessing-split-bam-species.sh \
        "exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.bam" \
        "exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
        "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito" \
        "4"
Submitted batch job 4714602

Submitting job for exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.bam...
 - chromosomes to retain are I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito
 - outfile is exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
 - running samtools with 4 threads
Submission:
sbatch ./submit-preprocessing-split-bam-species.sh \
        "exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.bam" \
        "exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
        "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito" \
        "4"
Submitted batch job 4714603

Submitting job for exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.bam...
 - chromosomes to retain are I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito
 - outfile is exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
 - running samtools with 4 threads
Submission:
sbatch ./submit-preprocessing-split-bam-species.sh \
        "exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.bam" \
        "exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
        "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito" \
        "4"
Submitted batch job 4714604
```
</details>
<br />

The jobs completed successfully

<a id="perform-another-quality-check-with-fastqc-2022-1128"></a>
### Perform another quality check with `FastQC` (2022-1128)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

.,
#  Looks fine and submit-preprocessing-fastqc.sh is present

for i in "${infiles_mapped[@]}"; do
	., "${i%.bam}.${split}.bam"
done
# -rw-rw---- 1 kalavatt 525M Nov 28 09:20 exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw---- 1 kalavatt 435M Nov 28 09:20 exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw---- 1 kalavatt 1.2G Nov 28 09:20 exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw---- 1 kalavatt 878M Nov 28 09:20 exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam

#  See answer #1 here:
#+ stackoverflow.com/questions/13648410/how-can-i-get-unique-values-from-an-array-in-bash
#+ (...which is way more efficient that what I did above)
unset infiles_mapped_bases
typeset -a infiles_mapped_bases
for i in "${infiles_mapped[@]}"; do
	infiles_mapped_bases+=( "$(basename "${i%.bam}.${split}.bam")" )
done
echo "w/duplicates..."
echoTest "${infiles_mapped_bases[@]}" 

IFS=" " read -r -a infiles_mapped_bases \
	<<< "$(\
		tr ' ' '\n' \
			<<< "${infiles_mapped_bases[@]}" \
				| sort -u \
				| tr '\n' ' '\
	)"
echo "w/o duplicates..."
echoTest "${infiles_mapped_bases[@]}" && echo ""

unset infiles_mapped_dirs
typeset -a infiles_mapped_dirs
for i in "${infiles_mapped[@]}"; do
	infiles_mapped_dirs+=( "$(dirname "${i%.bam}.${split}.bam")" )
done
echo "w/duplicates..."
echoTest "${infiles_mapped_dirs[@]}"

IFS=" " read -r -a infiles_mapped_dirs \
	<<< "$(\
		tr ' ' '\n' \
			<<< "${infiles_mapped_dirs[@]}" \
				| sort -u \
				| tr '\n' ' '\
	)"
echo "w/o duplicates..."
echoTest "${infiles_mapped_dirs[@]}" && echo ""


for i in "${infiles_mapped_dirs[@]}"; do
	# i="${infiles_mapped_dirs[0]}"
	step_no="$(\
		echo "${i}" \
			| awk -F _ '{ print $2 }' \
			| awk -F / '{ print $2 }'\
		)"
	if [[ "${step_no}" == "04a" ]]; then
		for j in "${infiles_mapped_bases[@]}"; do
			outdir="exp_preprocessing/05a_fastqc"
			echo "Working with ${i}..."
			echo "    - infile: ${i}/${j}"
			echo "    - outdir: ${outdir}"
			echo ""

			echo -e "sbatch submit-preprocessing-fastqc.sh \\ \n\
	            \"${i}/${j}\" \\ \n\
	            \"${outdir}\""

		    sbatch submit-preprocessing-fastqc.sh \
		        "${i}/${j}" \
		        "${outdir}"

	        sleep 0.25
	        echo "" && echo ""
		done
	elif [[ "${step_no}" == "04b" ]]; then
		for j in "${infiles_mapped_bases[@]}"; do
			outdir="exp_preprocessing/05b_fastqc"
			echo "Working with ${i}..."
			echo "    - infile: ${i}/${j}"
			echo "    - outdir: ${outdir}"
			echo ""

			echo -e "sbatch submit-preprocessing-fastqc.sh \\ \n\
	            \"${i}/${j}\" \\ \n\
	            \"${outdir}\""

		    sbatch submit-preprocessing-fastqc.sh \
		        "${i}/${j}" \
		        "${outdir}"

		    sleep 0.25
            echo "" && echo ""
		done
	else
		echo "Exiting: Problem encountered processing in- and outfiles"
		# exit 1
	fi
done
```

<details>
<summary><i>sbatch ./submit-preprocessing-fastqc.sh, messages printed to terminal:</i></summary>

```txt
Working with exp_preprocessing/04a_star-genome-free...
    - infile: exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
    - outdir: exp_preprocessing/05a_fastqc

sbatch submit-preprocessing-fastqc.sh \
                "exp_preprocessing/04a_star-genome-free/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
                "exp_preprocessing/05a_fastqc"
Submitted batch job 4715418


Working with exp_preprocessing/04a_star-genome-free...
    - infile: exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
    - outdir: exp_preprocessing/05a_fastqc

sbatch submit-preprocessing-fastqc.sh \
                "exp_preprocessing/04a_star-genome-free/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
                "exp_preprocessing/05a_fastqc"
Submitted batch job 4715419


Working with exp_preprocessing/04b_star-genome-guided...
    - infile: exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
    - outdir: exp_preprocessing/05b_fastqc

sbatch submit-preprocessing-fastqc.sh \
                "exp_preprocessing/04b_star-genome-guided/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
                "exp_preprocessing/05b_fastqc"
Submitted batch job 4715420


Working with exp_preprocessing/04b_star-genome-guided...
    - infile: exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
    - outdir: exp_preprocessing/05b_fastqc

sbatch submit-preprocessing-fastqc.sh \
                "exp_preprocessing/04b_star-genome-guided/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam" \
                "exp_preprocessing/05b_fastqc"
Submitted batch job 4715421
```
</details>
<br />

The jobs completed successfully

<a id="convert-the-species-filtered-bams-from-genome-free-alignment-to-fastqs"></a>
### Convert the species-filtered `.bam`s from genome-free alignment to `.fastq`s
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Check where we are
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

#  Check what's in the working directory
.,
#  Looks fine and submit-preprocessing-fastqc.sh is present

#  Check that we're using samtools from Trinity_env
which samtools
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/samtools


#  Make an array for files of interest ----------------------------------------
#  Remember, split="sc_all", assigned above
unset bams_filtered
typeset -a bams_filtered
while IFS=" " read -r -d $'\0'; do
    bams_filtered+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/04a_star-genome-free" \
        -type f \
        -name *${split}.bam \
        -print0 \
            | sort -z \
)
echoTest "${bams_filtered[@]}"


#  Prep the SLURM script for converting filtered .bams to .fastqs -------------
if [[ -f submit-preprocessing-convert-bam-fastq.sh ]]; then
	rm submit-preprocessing-convert-bam-fastq.sh
fi
cat << script > "./submit-preprocessing-convert-bam-fastq.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-convert-bam-fastq.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-convert-bam-fastq.%J.out.txt

#  submit-preprocessing-convert-bam-fastq.sh
#  KA
#  $(date '+%Y-%m%d')


infile="\${1}"
outprefix="\${2}"
threads="\${3}"

if [[ ! -f "\${infile}.bai" ]]; then
	echo "Indexing \${infile}"
	samtools index -@ "\${threads}" "\${infile}"
fi

if [[ ! -f "\${infile%.bam}.sort-n.bam" ]]; then
	echo "QNAME-sorting \${infile}"
	samtools sort -n -@ "\${threads}" "\${infile}" \\
		> "\${infile%.bam}.sort-n.bam"
fi

echo "Converting QNAME-sorted bam to fastq files"
if [[ -f "\${infile%.bam}.sort-n.bam" ]]; then
	samtools fastq \\
	    -@ "\${threads}" \\
	    -1 "\${outprefix}.1.fq.gz" \\
	    -2 "\${outprefix}.2.fq.gz" \\
	    "\${infile%.bam}.sort-n.bam"
else
	echo "\${infile%.bam}.sort-n.bam is NOT present; check on this..."
fi
script
# vi submit-preprocessing-convert-bam-fastq.sh


#  Submit jobs for converting filtered .bams to .fastqs -----------------------
threads=1
for i in "${bams_filtered[@]}"; do
	# i="${bams_filtered[0]}"
	step_no="$(\
		echo "${i}" \
			| awk -F _ '{ print $2 }' \
			| awk -F / '{ print $2 }'\
		)"
	if [[ "${step_no}" == "04a" ]]; then
		prefix="$(dirname $(dirname "${i}"))"
		suffix="06_bam-to-fastq"

		echo "Submitting job for ${i}..."
		echo " -    inpath: $(dirname "${i}")"
		echo " -    infile: ${i}"
		echo " -   outpath: ${prefix}/${suffix}"
		echo " - outprefix: ${prefix}/${suffix}/$(basename "${i%.bam}")"
		echo "Submission:"

		echo -e "sbatch ./submit-preprocessing-convert-bam-fastq.sh \\ \n\
			\"${i}\" \\ \n\
			\"${prefix}/${suffix}/$(basename "${i%.bam}")\" \\ \n\
			\"${threads}\""

		sbatch ./submit-preprocessing-convert-bam-fastq.sh \
			"${i}" \
			"${prefix}/${suffix}/$(basename "${i%.bam}")" \
			"${threads}"

		sleep 0.25
		echo ""
	else
		echo "Exiting: Problem encountered processing in- and outfiles"
		# exit 1
	fi
done
```

<a id="perform-a-fastqc-quality-check-for-the-new-fastq-files-2022-1128"></a>
### Perform a `FastQC` quality check for the new `.fastq` files (2022-1128)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

.,
#  Looks fine and submit-preprocessing-fastqc.sh is present


#  Make an array for files of interest ----------------------------------------
unset fastqs_from_bams
typeset -a fastqs_from_bams
while IFS=" " read -r -d $'\0'; do
    fastqs_from_bams+=( "${REPLY}" )
done < <(\
    find "exp_preprocessing/06_bam-to-fastq" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echoTest "${fastqs_from_bams[@]}"


#  Submit jobs for QC of .bams converted to .fastqs ---------------------------
for i in "${fastqs_from_bams[@]}"; do
    outdir="exp_preprocessing/07_fastqc"
    echo "Working with ${i}..."
    echo "    - infile: ${i}"
    echo "    - outdir: ${outdir}"
    echo ""

    echo -e "sbatch submit-preprocessing-fastqc.sh \\ \n\
        \"${i}\" \\ \n\
        \"${outdir}\""

    sbatch submit-preprocessing-fastqc.sh \
        "${i}" \
        "${outdir}"

    sleep 0.25
    echo "" && echo ""
done
```

<a id="remove-erroneous-k-mers-from-reads-with-rcorrector-and-correct-the-outfiles"></a>
### Remove erroneous k-mers from reads with `rCorrector` and "correct" the outfiles
<a id="remove-erroneous-k-mers-from-paired-end-reads-with-rcorrector"></a>
#### Remove erroneous k-mers from paired-end reads with rCorrector
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

.,
#  Looks fine and submit-preprocessing-fastqc.sh is present

#  Remember that we're still in Trinity_env; check that we have rcorrector installed
which rcorrector
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/rcorrector


#  Make an array for files of interest ----------------------------------------
unset fastqs_from_bams
typeset -a fastqs_from_bams
while IFS=" " read -r -d $'\0'; do
    fastqs_from_bams+=( "${REPLY%.?.fq.gz}" )
done < <(\
    find "exp_preprocessing/06_bam-to-fastq" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_from_bams[@]}"

IFS=" " read -r -a fastqs_from_bams \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_from_bams[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_from_bams[@]}" && echo ""


#  Perform a test run of rcorrector -------------------------------------------
threads=1
i="${fastqs_from_bams[0]}"

run_rcorrector.pl
# Usage: perl ./run_rcorrector.pl [OPTIONS]
# OPTIONS:
# Required parameters:
# 	-s seq_files: comma separated files for single-end data sets
# 	-1 seq_files_left: comma separated files for the first mate in the paried-end data sets
# 	-2 seq_files_right: comma separated files for the second mate in the paired-end data sets
# 	-i seq_files_interleaved: comma sperated files for interleaved paired-end data sets
# Other parameters:
# 	-k kmer_length (<=32, default: 23)
# 	-od output_file_directory (default: ./)
# 	-t number_of_threads (default: 1)
# 	-maxcorK INT: the maximum number of correction within k-bp window (default: 4)
# 	-wk FLOAT: the proportion of kmers that are used to estimate weak kmer count threshold, lower for more divergent genome (default: 0.95)
# 	-ek expected_number_of_kmers: does not affect the correctness of program but affect the memory usage (default: 100000000)
# 	-stdout: output the corrected reads to stdout (default: not used)
# 	-verbose: output some correction information to stdout (default: not used)
# 	-stage INT: start from which stage (default: 0)
# 		0-start from begining(storing kmers in bloom filter);
# 		1-start from count kmers showed up in bloom filter;
# 		2-start from dumping kmer counts into a jf_dump file;
# 		3-start from error correction.

run_rcorrector.pl \
	-t "${threads}" \
	-1 "${i}.1.fq.gz" \
	-2 "${i}.2.fq.gz" \
	-od "exp_preprocessing/08_rcorrector"
```

<details>
<summary><i>Call to run_rcorrector.pl, messages printed to terminal:</i></summary>

```txt
Put the kmers into bloom filter
jellyfish bc -m 23 -s 100000000 -C -t 1 -o tmp_39ba89fb652788a14b68b806e39757da.bc <(gzip -cd exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.1.fq.gz) <(gzip -cd exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.2.fq.gz)
Count the kmers in the bloom filter
jellyfish count -m 23 -s 100000 -C -t 1 --bc tmp_39ba89fb652788a14b68b806e39757da.bc -o tmp_39ba89fb652788a14b68b806e39757da.mer_counts <(gzip -cd exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.1.fq.gz) <(gzip -cd exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.2.fq.gz)
Dump the kmers
jellyfish dump -L 2 tmp_39ba89fb652788a14b68b806e39757da.mer_counts > tmp_39ba89fb652788a14b68b806e39757da.jf_dump
Error correction
/home/kalavatt/miniconda3/envs/Trinity_env/bin/rcorrector -t 1 -od exp_preprocessing/08_rcorrector  -p exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.1.fq.gz exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.2.fq.gz -c tmp_39ba89fb652788a14b68b806e39757da.jf_dump
Stored 13606816 kmers
Weak kmer threshold rate: 0.024658 (estimated from 0.950/1 of the chosen kmers)
Bad quality threshold is '@'
Processed 15069524 reads
	Corrected 5442342 bases.
```
</details>
<br />

The command completed successfully; however, it's quite slow using only one thread  
`#TODO` Formal `run_rcorrector.pl` job submissions to `SLURM`

<a id="discard-rcorrector-processed-read-pairs-for-which-one-read-is-deemed-unfixable"></a>
#### Discard `rcorrector`-processed read pairs for which one read is deemed unfixable
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

.,
#  Looks fine and submit-preprocessing-fastqc.sh is present

which python
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/python

python --version
# Python 3.7.15


#  Generate the requisite script for processing rcorrector-treated reads ------
#  The following script is taken from
#+ github.com/harvardinformatics/TranscriptomeAssemblyTools/blob/master/FilterUncorrectabledPEfastq.py
#+
#+ ...and is used following the guidelines (specifically steps 3 and 4) here:
#+ informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html
cat << script > "./submit-preprocessing-filter-uncorrectable-fastq.py"
"""
author: adam h freedman
afreedman405 at gmail.com
data: Fri Aug 26 10:55:18 EDT 2016

This script takes as an input Rcorrector error corrected Illumina paired-reads
in fastq format and:

1. Removes any reads that Rcorrector indentifes as containing an error,
but can't be corrected, typically low complexity sequences. For these,
the header contains 'unfixable'.

2. Strips the ' cor' from headers of reads that Rcorrector fixed, to avoid
issues created by certain header formats for downstream tools.

3. Write a log with counts of (a) read pairs that were removed because one end
was unfixable, (b) corrected left and right reads, (c) total number of
read pairs containing at least one corrected read.

Currently, this script only handles paired-end data, and handle either unzipped
or gzipped files on the fly, so long as the gzipped files end with 'gz'.
"""

import sys        
import gzip
from itertools import izip,izip_longest
import argparse
from os.path import basename

def get_input_streams(r1file,r2file):
    if r1file[-2:]=='gz':
        r1handle=gzip.open(r1file,'rb')
        r2handle=gzip.open(r2file,'rb')
    else:
        r1handle=open(r1file,'r')
        r2handle=open(r2file,'r')
    
    return r1handle,r2handle
        
        
def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx
    args = [iter(iterable)] * n
    return izip_longest(fillvalue=fillvalue, *args)  
    

if __name__=="__main__": 
    parser = argparse.ArgumentParser(
    	description="options for filtering and logging rCorrector fastq outputs"
    )
    parser.add_argument(
    	'-1','--left_reads',dest='leftreads',type=str,help='R1 fastq file'
    )
    parser.add_argument(
    	'-2','--right_reads',dest='rightreads',type=str,help='R2 fastq file'
    )
    parser.add_argument(
    	'-s','--sample_id',dest='id',type=str,help='sample name to write to log file'
    )
    opts = parser.parse_args()

    r1out=open('unfixrm_%s' % basename(opts.leftreads).replace('.gz',''),'w')
    r2out=open('unfixrm_%s' % basename(opts.rightreads).replace('.gz','') ,'w')

    r1_cor_count=0
    r2_cor_count=0
    pair_cor_count=0
    unfix_r1_count=0
    unfix_r2_count=0
    unfix_both_count=0   

    r1_stream,r2_stream=get_input_streams(opts.leftreads,opts.rightreads)

    with r1_stream as f1, r2_stream as f2:
        R1=grouper(f1,4)
        R2=grouper(f2,4)
        counter=0
        for entry in R1:
            counter+=1
            if counter%100000==0:
                print "%s reads processed" % counter
        
            head1,seq1,placeholder1,qual1=[i.strip() for i in entry]
            head2,seq2,placeholder2,qual2=[j.strip() for j in R2.next()]
            
            if 'unfixable' in head1 and 'unfixable' not in head2:
                unfix_r1_count+=1
            elif 'unfixable' in head2 and 'unfixable' not in head1:
                unfix_r2_count+=1
            elif 'unfixable' in head1 and 'unfixable' in head2:
                unfix_both_count+=1
            else:
                if 'cor' in head1:
                    r1_cor_count+=1
                if 'cor' in head2:
                    r2_cor_count+=1
                if 'cor' in head1 or 'cor' in head2:
                    pair_cor_count+=1
                
                head1=head1.split('l:')[0][:-1] 
                head2=head2.split('l:')[0][:-1]
                r1out.write('%s\n' % '\n'.join([head1,seq1,placeholder1,qual1]))
                r2out.write('%s\n' % '\n'.join([head2,seq2,placeholder2,qual2]))
    
    total_unfixable = unfix_r1_count+unfix_r2_count+unfix_both_count
    total_retained = counter - total_unfixable

    unfix_log=open('rmunfixable_%s.log' % opts.id,'w')
    unfix_log.write('total PE reads:%s\nremoved PE reads:%s\nretained PE reads:%s\nR1 corrected:%s\nR2 corrected:%s\npairs corrected:%s\nR1 unfixable:%s\nR2 unfixable:%s\nboth reads unfixable:%s\n' % (counter,total_unfixable,total_retained,r1_cor_count,r2_cor_count,pair_cor_count,unfix_r1_count,unfix_r2_count,unfix_both_count))
            
    r1out.close()
    r2out.close() 
    unfix_log.close()
script


#  Make an array for files of interest ----------------------------------------
unset fastqs_rcorrected
typeset -a fastqs_rcorrected
while IFS=" " read -r -d $'\0'; do
    fastqs_rcorrected+=( "${REPLY%.?.cor.fq.gz}" )
done < <(\
    find "exp_preprocessing/08_rcorrector" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_rcorrected[@]}"

IFS=" " read -r -a fastqs_rcorrected \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_rcorrected[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_rcorrected[@]}" && echo ""


#  Perform a test run of *filter-uncorrectable-fastq.py -----------------------
i="${fastqs_rcorrected[0]}"
python ./submit-preprocessing-filter-uncorrectable-fastq.py \
	-1 "${i}.1.cor.fq.gz" \
	-2 "${i}.2.cor.fq.gz" \
	-s "${i}"
#   File "./submit-preprocessing-filter-uncorrectable-fastq.py", line 82
#     print "%s reads processed" % counter
#                              ^
# SyntaxError: Missing parentheses in call to 'print'. Did you mean print("%s reads processed" % counter)?
```

<a id="troubleshoot-errors-associated-with-the-rcorrector-correction-scripts-2022-1128-1129"></a>
##### Troubleshoot errors associated with the `rcorrector`-correction scripts (2022-1128-1129)
```bash
#!/bin/bash
#DONTRUN #CONTINUE
#  Make sense of the error using 2to3 -----------------------------------------
#  It looks like the script is written in Python 2; install 2to3 and convert
#+ *filter-uncorrectable-fastq.py to Python 3 formatting
pip install 2to3
# Collecting 2to3
#   Downloading 2to3-1.0-py3-none-any.whl (1.7 kB)
# Installing collected packages: 2to3
# Successfully installed 2to3-1.0

which 2to3
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/2to3

2to3 ./submit-preprocessing-filter-uncorrectable-fastq.py
```
<details>
<summary><i>Results of 2to3 \*filter-uncorrectable-fastq.py printed to terminal:</i></summary>

```txt
RefactoringTool: Skipping optional fixer: buffer
RefactoringTool: Skipping optional fixer: idioms
RefactoringTool: Skipping optional fixer: set_literal
RefactoringTool: Skipping optional fixer: ws_comma
RefactoringTool: Refactored ./submit-preprocessing-filter-uncorrectable-fastq.py
--- ./submit-preprocessing-filter-uncorrectable-fastq.py	(original)
+++ ./submit-preprocessing-filter-uncorrectable-fastq.py	(refactored)
@@ -23,7 +23,7 @@

 import sys
 import gzip
-from itertools import izip,izip_longest
+from itertools importzip_longest
 import argparse
 from os.path import basename

@@ -42,7 +42,7 @@
     "Collect data into fixed-length chunks or blocks"
     # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx
     args = [iter(iterable)] * n
-    return izip_longest(fillvalue=fillvalue, *args)
+    return zip_longest(fillvalue=fillvalue, *args)


 if __name__=="__main__":
@@ -79,10 +79,10 @@
         for entry in R1:
             counter+=1
             if counter%100000==0:
-                print "%s reads processed" % counter
+                print("%s reads processed" % counter)

             head1,seq1,placeholder1,qual1=[i.strip() for i in entry]
-            head2,seq2,placeholder2,qual2=[j.strip() for j in R2.next()]
+            head2,seq2,placeholder2,qual2=[j.strip() for j in next(R2)]

             if 'unfixable' in head1 and 'unfixable' not in head2:
                 unfix_r1_count+=1
RefactoringTool: Files that need to be modified:
RefactoringTool: ./submit-preprocessing-filter-uncorrectable-fastq.py
```
</details>
<br />

`#DONE` Make the edits directly to the script  

Try rerunning things:
```bash
#!/bin/bash
#DONTRUN #CONTINUE


#  Make an array for files of interest ----------------------------------------
unset fastqs_rcorrected
typeset -a fastqs_rcorrected
while IFS=" " read -r -d $'\0'; do
    fastqs_rcorrected+=( "${REPLY%.?.cor.fq.gz}" )
done < <(\
    find "exp_preprocessing/08_rcorrector" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_rcorrected[@]}"

IFS=" " read -r -a fastqs_rcorrected \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_rcorrected[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_rcorrected[@]}" && echo ""


#  Perform a test run of *filter-uncorrectable-fastq.py -----------------------
i="${fastqs_rcorrected[0]}"
python ./submit-preprocessing-filter-uncorrectable-fastq.py \
	-1 "${i}.1.cor.fq.gz" \
	-2 "${i}.2.cor.fq.gz" \
	-s "${i}"
# Traceback (most recent call last):
#   File "./submit-preprocessing-filter-uncorrectable-fastq.py", line 87, in <module>
#     if 'unfixable' in head1 and 'unfixable' not in head2:
# TypeError: a bytes-like object is required, not 'str'
```

`#DONE` Going to need to load this script into an IDE and step through things to resolve this error  
`#DONE` Install `jupyterlab`  
~~`#SKIP` Troubleshoot difficulties connecting a local browser to jupyterlab initialized from the HPC~~  
`#DONE` Or do the troubleshooting locally by, e.g., temporarily copying pertinent files and scripts to local (would require a local installation of `jupyterlab`, which would be good to have anyway)

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Install jupyterlab to Trinity_env
mamba install -c conda-forge jupyterlab
```

<details>
<summary><i>Messages from installation of ` printed to terminal:</i></summary>

```txt
Transaction

  Prefix: /home/kalavatt/miniconda3/envs/Trinity_env

  Updating specs:

   - jupyterlab
   - ca-certificates
   - certifi
   - openssl


  Package                              Version  Build              Channel                    Size
────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────

  + anyio                                3.6.2  pyhd8ed1ab_0       conda-forge/noarch        83 KB
  + argon2-cffi                         21.3.0  pyhd8ed1ab_0       conda-forge/noarch        15 KB
  + argon2-cffi-bindings                21.2.0  py37h540881e_2     conda-forge/linux-64      34 KB
  + attrs                               22.1.0  pyh71513ae_1       conda-forge/noarch        48 KB
  + babel                               2.11.0  pyhd8ed1ab_0       conda-forge/noarch         7 MB
  + backcall                             0.2.0  pyh9f0ad1d_0       conda-forge/noarch        13 KB
  + backports                              1.0  pyhd8ed1ab_3       conda-forge/noarch         6 KB
  + backports.functools_lru_cache        1.6.4  pyhd8ed1ab_0       conda-forge/noarch         9 KB
  + beautifulsoup4                      4.11.1  pyha770c72_0       conda-forge/noarch        96 KB
  + bleach                               5.0.1  pyhd8ed1ab_0       conda-forge/noarch       124 KB
  + brotlipy                             0.7.0  py37h540881e_1004  conda-forge/linux-64     342 KB
  + cffi                                1.15.1  py37h43b0acd_1     conda-forge/linux-64     227 KB
  + charset-normalizer                   2.1.1  pyhd8ed1ab_0       conda-forge/noarch        36 KB
  + cryptography                        38.0.2  py37h38fbfac_1     conda-forge/linux-64       2 MB
  + debugpy                              1.6.0  py37hd23a5d3_0     conda-forge/linux-64       2 MB
  + decorator                            5.1.1  pyhd8ed1ab_0       conda-forge/noarch        12 KB
  + defusedxml                           0.7.1  pyhd8ed1ab_0       conda-forge/noarch        23 KB
  + entrypoints                            0.4  pyhd8ed1ab_0       conda-forge/noarch         9 KB
  + flit-core                            3.8.0  pyhd8ed1ab_0       conda-forge/noarch        45 KB
  + idna                                   3.4  pyhd8ed1ab_0       conda-forge/noarch        55 KB
  + importlib-metadata                  4.11.4  py37h89c1867_0     conda-forge/linux-64      33 KB
  + importlib_resources                 5.10.0  pyhd8ed1ab_0       conda-forge/noarch        29 KB
  + ipykernel                           6.16.2  pyh210e3f2_0       conda-forge/noarch       100 KB
  + ipython                             7.33.0  py37h89c1867_0     conda-forge/linux-64       1 MB
  + ipython_genutils                     0.2.0  py_1               conda-forge/noarch        21 KB
  + jedi                                0.18.2  pyhd8ed1ab_0       conda-forge/noarch       786 KB
  + jinja2                               3.1.2  pyhd8ed1ab_1       conda-forge/noarch        99 KB
  + json5                                0.9.5  pyh9f0ad1d_0       conda-forge/noarch        20 KB
  + jsonschema                          4.17.1  pyhd8ed1ab_0       conda-forge/noarch        69 KB
  + jupyter_client                       7.4.7  pyhd8ed1ab_0       conda-forge/noarch        92 KB
  + jupyter_core                        4.11.1  py37h89c1867_0     conda-forge/linux-64      81 KB
  + jupyter_server                      1.23.3  pyhd8ed1ab_0       conda-forge/noarch       233 KB
  + jupyterlab                           3.5.0  pyhd8ed1ab_0       conda-forge/noarch         6 MB
  + jupyterlab_pygments                  0.2.2  pyhd8ed1ab_0       conda-forge/noarch        17 KB
  + jupyterlab_server                   2.16.3  pyhd8ed1ab_0       conda-forge/noarch        50 KB
  + libsodium                           1.0.18  h36c2ea0_1         conda-forge/linux-64     366 KB
  + markupsafe                           2.1.1  py37h540881e_1     conda-forge/linux-64      22 KB
  + matplotlib-inline                    0.1.6  pyhd8ed1ab_0       conda-forge/noarch        12 KB
  + mistune                              2.0.4  pyhd8ed1ab_0       conda-forge/noarch        67 KB
  + nbclassic                            0.4.8  pyhd8ed1ab_0       conda-forge/noarch         8 MB
  + nbclient                             0.7.0  pyhd8ed1ab_0       conda-forge/noarch        65 KB
  + nbconvert                            7.2.5  pyhd8ed1ab_0       conda-forge/noarch         6 KB
  + nbconvert-core                       7.2.5  pyhd8ed1ab_0       conda-forge/noarch       193 KB
  + nbconvert-pandoc                     7.2.5  pyhd8ed1ab_0       conda-forge/noarch         5 KB
  + nbformat                             5.7.0  pyhd8ed1ab_0       conda-forge/noarch       106 KB
  + nest-asyncio                         1.5.6  pyhd8ed1ab_0       conda-forge/noarch        10 KB
  + notebook                             6.5.2  pyha770c72_1       conda-forge/noarch       267 KB
  + notebook-shim                        0.2.2  pyhd8ed1ab_0       conda-forge/noarch        15 KB
  + packaging                             21.3  pyhd8ed1ab_0       conda-forge/noarch        36 KB
  + pandoc                              2.19.2  h32600fe_1         conda-forge/linux-64      30 MB
  + pandocfilters                        1.5.0  pyhd8ed1ab_0       conda-forge/noarch        11 KB
  + parso                                0.8.3  pyhd8ed1ab_0       conda-forge/noarch        69 KB
  + pexpect                              4.8.0  py37hc8dfbb8_1     conda-forge/linux-64      79 KB
  + pickleshare                          0.7.5  py37hc8dfbb8_1002  conda-forge/linux-64      13 KB
  + pkgutil-resolve-name                1.3.10  pyhd8ed1ab_0       conda-forge/noarch         9 KB
  + prometheus_client                   0.15.0  pyhd8ed1ab_0       conda-forge/noarch        50 KB
  + prompt-toolkit                      3.0.33  pyha770c72_0       conda-forge/noarch       259 KB
  + psutil                               5.9.3  py37h540881e_0     conda-forge/linux-64     348 KB
  + ptyprocess                           0.7.0  pyhd3deb0d_0       conda-forge/noarch        16 KB
  + pycparser                             2.21  pyhd8ed1ab_0       conda-forge/noarch       100 KB
  + pygments                            2.13.0  pyhd8ed1ab_0       conda-forge/noarch       821 KB
  + pyopenssl                           22.1.0  pyhd8ed1ab_0       conda-forge/noarch       122 KB
  + pyparsing                            3.0.9  pyhd8ed1ab_0       conda-forge/noarch        79 KB
  + pyrsistent                          0.18.1  py37h540881e_1     conda-forge/linux-64      91 KB
  + pysocks                              1.7.1  py37h89c1867_5     conda-forge/linux-64      28 KB
  + python-dateutil                      2.8.2  pyhd8ed1ab_0       conda-forge/noarch       240 KB
  + python-fastjsonschema               2.16.2  pyhd8ed1ab_0       conda-forge/noarch       242 KB
  + python_abi                             3.7  2_cp37m            conda-forge/linux-64       4 KB
  + pytz                                2022.6  pyhd8ed1ab_0       conda-forge/noarch       235 KB
  + pyzmq                               23.0.0  py37h0c0c2a8_0     conda-forge/linux-64     474 KB
  + requests                            2.28.1  pyhd8ed1ab_1       conda-forge/noarch        53 KB
  + send2trash                           1.8.0  pyhd8ed1ab_0       conda-forge/noarch        17 KB
  + six                                 1.16.0  pyh6c4a22f_0       conda-forge/noarch        14 KB
  + sniffio                              1.3.0  pyhd8ed1ab_0       conda-forge/noarch        14 KB
  + soupsieve                      2.3.2.post1  pyhd8ed1ab_0       conda-forge/noarch        34 KB
  + terminado                           0.17.0  pyh41d4057_0       conda-forge/noarch        19 KB
  + tinycss2                             1.2.1  pyhd8ed1ab_0       conda-forge/noarch        23 KB
  + tomli                                2.0.1  pyhd8ed1ab_0       conda-forge/noarch        16 KB
  + tornado                                6.2  py37h540881e_0     conda-forge/linux-64     651 KB
  + traitlets                            5.5.0  pyhd8ed1ab_0       conda-forge/noarch        85 KB
  + typing_extensions                    4.4.0  pyha770c72_0       conda-forge/noarch        29 KB
  + urllib3                            1.26.13  pyhd8ed1ab_0       conda-forge/noarch       108 KB
  + wcwidth                              0.2.5  pyh9f0ad1d_2       conda-forge/noarch        33 KB
  + webencodings                         0.5.1  py_1               conda-forge/noarch        12 KB
  + websocket-client                     1.4.2  pyhd8ed1ab_0       conda-forge/noarch        43 KB
  + zeromq                               4.3.4  h9c3ff4c_1         conda-forge/linux-64     351 KB
  + zipp                                3.11.0  pyhd8ed1ab_0       conda-forge/noarch        15 KB

  Change:
────────────────────────────────────────────────────────────────────────────────────────────────────

  - openssl                             1.1.1s  h7f8727e_0         installed
  + openssl                             1.1.1s  h166bdaf_0         conda-forge/linux-64     Cached

  Summary:

  Install: 87 packages
  Change: 1 packages

  Total download: 64 MB

────────────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
Finished pysocks                              (00m:00s)              28 KB    310 KB/s
Finished pyrsistent                           (00m:00s)              91 KB    841 KB/s
Finished libsodium                            (00m:00s)             366 KB      3 MB/s
Finished zeromq                               (00m:00s)             351 KB      3 MB/s
Finished traitlets                            (00m:00s)              85 KB    607 KB/s
Finished backcall                             (00m:00s)              13 KB     90 KB/s
Finished python_abi                           (00m:00s)               4 KB     26 KB/s
Finished send2trash                           (00m:00s)              17 KB     96 KB/s
Finished python-fastjsonschema                (00m:00s)             242 KB      1 MB/s
Finished pyparsing                            (00m:00s)              79 KB    402 KB/s
Finished pandocfilters                        (00m:00s)              11 KB     56 KB/s
Finished backports                            (00m:00s)               6 KB     27 KB/s
Finished idna                                 (00m:00s)              55 KB    239 KB/s
Finished zipp                                 (00m:00s)              15 KB     64 KB/s
Finished charset-normalizer                   (00m:00s)              36 KB    141 KB/s
Finished matplotlib-inline                    (00m:00s)              12 KB     47 KB/s
Finished six                                  (00m:00s)              14 KB     51 KB/s
Finished terminado                            (00m:00s)              19 KB     68 KB/s
Finished tinycss2                             (00m:00s)              23 KB     74 KB/s
Finished bleach                               (00m:00s)             124 KB    390 KB/s
Finished jupyter_core                         (00m:00s)              81 KB    252 KB/s
Finished cffi                                 (00m:00s)             227 KB    647 KB/s
Finished brotlipy                             (00m:00s)             342 KB    941 KB/s
Finished jsonschema                           (00m:00s)              69 KB    180 KB/s
Finished nbclient                             (00m:00s)              65 KB    164 KB/s
Finished ipykernel                            (00m:00s)             100 KB    250 KB/s
Finished notebook-shim                        (00m:00s)              15 KB     34 KB/s
Finished notebook                             (00m:00s)             267 KB    610 KB/s
Finished nbconvert-pandoc                     (00m:00s)               5 KB     11 KB/s
Finished tornado                              (00m:00s)             651 KB      1 MB/s
Finished backports.functools_lru_cache        (00m:00s)               9 KB     18 KB/s
Finished decorator                            (00m:00s)              12 KB     23 KB/s
Finished websocket-client                     (00m:00s)              43 KB     81 KB/s
Finished ipython_genutils                     (00m:00s)              21 KB     39 KB/s
Finished webencodings                         (00m:00s)              12 KB     21 KB/s
Finished entrypoints                          (00m:00s)               9 KB     16 KB/s
Finished flit-core                            (00m:00s)              45 KB     78 KB/s
Finished attrs                                (00m:00s)              48 KB     81 KB/s
Finished jinja2                               (00m:00s)              99 KB    164 KB/s
Finished packaging                            (00m:00s)              36 KB     58 KB/s
Finished wcwidth                              (00m:00s)              33 KB     52 KB/s
Finished importlib-metadata                   (00m:00s)              33 KB     51 KB/s
Finished argon2-cffi                          (00m:00s)              15 KB     20 KB/s
Finished argon2-cffi-bindings                 (00m:00s)              34 KB     44 KB/s
Finished requests                             (00m:00s)              53 KB     69 KB/s
Finished nbconvert                            (00m:00s)               6 KB      8 KB/s
Finished markupsafe                           (00m:00s)              22 KB     27 KB/s
Finished ptyprocess                           (00m:00s)              16 KB     19 KB/s
Finished pygments                             (00m:00s)             821 KB    957 KB/s
Finished mistune                              (00m:00s)              67 KB     75 KB/s
Finished pkgutil-resolve-name                 (00m:00s)               9 KB      9 KB/s
Finished pytz                                 (00m:00s)             235 KB    258 KB/s
Finished debugpy                              (00m:00s)               2 MB      2 MB/s
Finished babel                                (00m:00s)               7 MB      8 MB/s
Finished pandoc                               (00m:00s)              30 MB     46 MB/s
Finished anyio                                (00m:00s)              83 KB     86 KB/s
Finished pexpect                              (00m:00s)              79 KB     82 KB/s
Finished jedi                                 (00m:00s)             786 KB    795 KB/s
Finished nbclassic                            (00m:00s)               8 MB      8 MB/s
Finished cryptography                         (00m:00s)               2 MB      2 MB/s
Finished jupyterlab_server                    (00m:00s)              50 KB     49 KB/s
Finished urllib3                              (00m:00s)             108 KB    107 KB/s
Finished prometheus_client                    (00m:00s)              50 KB     48 KB/s
Finished defusedxml                           (00m:00s)              23 KB     23 KB/s
Finished sniffio                              (00m:00s)              14 KB     13 KB/s
Finished jupyterlab_pygments                  (00m:00s)              17 KB     16 KB/s
Finished jupyter_client                       (00m:00s)              92 KB     85 KB/s
Finished nbconvert-core                       (00m:00s)             193 KB    178 KB/s
Finished importlib_resources                  (00m:00s)              29 KB     26 KB/s
Finished soupsieve                            (00m:00s)              34 KB     30 KB/s
Finished pickleshare                          (00m:00s)              13 KB     12 KB/s
Finished parso                                (00m:00s)              69 KB     61 KB/s
Finished python-dateutil                      (00m:00s)             240 KB    212 KB/s
Finished jupyterlab                           (00m:00s)               6 MB      5 MB/s
Finished tomli                                (00m:00s)              16 KB     13 KB/s
Finished prompt-toolkit                       (00m:00s)             259 KB    222 KB/s
Finished typing_extensions                    (00m:00s)              29 KB     25 KB/s
Finished pyopenssl                            (00m:00s)             122 KB    104 KB/s
Finished ipython                              (00m:00s)               1 MB    979 KB/s
Finished psutil                               (00m:00s)             348 KB    288 KB/s
Finished json5                                (00m:00s)              20 KB     17 KB/s
Finished nest-asyncio                         (00m:00s)              10 KB      8 KB/s
Finished nbformat                             (00m:00s)             106 KB     87 KB/s
Finished jupyter_server                       (00m:00s)             233 KB    190 KB/s
Finished beautifulsoup4                       (00m:00s)              96 KB     77 KB/s
Finished pycparser                            (00m:00s)             100 KB     79 KB/s
Finished pyzmq                                (00m:00s)             474 KB    288 KB/s
Downloading  [====================================================================================================] (00m:12s)   38.44 MB/s
Extracting   [====================================================================================================] (02m:12s)      87 / 87
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

For details on the resolution of these errors (2022-1129), see [`work-Python-local.md`](./work-Python-local.md) and [`filter_rCorrector-treated-fastqs.py`](../../bin/filter_rCorrector-treated-fastqs.py) (in particular, the GitHub commits for this `.py` file in `bin/`)

<a id="continue-work-to-discard-rcorrector-processed-read-pairs-that-are-unfixable-2022-1129"></a>
#### Continue work to discard `rcorrector`-processed read pairs that are "unfixable" (2022-1129)
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" ||
	echo "cd'ing failed; check on this"

pwd

which python
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/python

python --version
# Python 3.7.15

.,
# total 3.6M
# drwxrws--- 15 kalavatt 1.9K Nov 29 15:00 ./
# drwxrws---  7 kalavatt  191 Nov 29 14:49 ../
# drwxrws---  3 kalavatt  160 Nov  9 15:23 exp_alignment_Bowtie_2/
# drwxrws---  3 kalavatt   94 Nov 20 11:06 exp_alignment_STAR/
# drwxrws---  3 kalavatt   94 Nov 18 13:04 exp_alignment_STAR_multi-hit/
# drwxrws---  4 kalavatt  190 Nov 28 13:03 exp_alignment_STAR_tags/
# drwxrws---  2 kalavatt 1.1K Nov  7 15:27 exp_FastQC/
# drwxrws---  2 kalavatt  206 Nov 20 13:40 exp_intron-length/
# drwxrws---  6 kalavatt 2.6K Nov 26 10:21 exp_PASA_trial/
# drwxrws---  2 kalavatt  854 Nov  7 14:31 exp_picardmetrics/
# drwxrws--- 12 kalavatt 8.3K Nov 29 14:42 exp_preprocessing/
# drwxrws---  3 kalavatt  317 Nov  7 14:44 exp_Trinity/
# drwxrws---  4 kalavatt  242 Nov 24 12:27 exp_Trinity_trial/
# drwxrws---  3 kalavatt  720 Nov  8 10:03 files_fastq_symlinks/
# drwxrws---  2 kalavatt  778 Nov 29 14:09 notebook/
# -rw-rw----  1 kalavatt  14K Nov 16 12:23 notes-Alison-files-locations.md
# -rw-rw----  1 kalavatt  29K Nov 16 12:23 notes-Alison-papers.md
# -rw-rw----  1 kalavatt 1.3K Nov 16 12:23 notes-Alison-RNA-seq-kits.md
# -rw-rw----  1 kalavatt 8.3K Nov 28 10:05 notes-miscellaneous-links.md
# -rw-rw----  1 kalavatt 5.7K Nov 16 12:23 notes-RNA-seq-spike-ins.md
# -rw-rw----  1 kalavatt  35K Nov 18 11:33 notes-UMIs-etc.md
# -rw-rw----  1 kalavatt 264K Nov 29 14:57 scraps.md
# -rw-rw----  1 kalavatt  617 Nov  8 14:43 submit-Bowtie-2.test-1.sh
# -rw-rw----  1 kalavatt  642 Nov  8 16:16 submit-Bowtie-2.test-2.sh
# -rw-rw----  1 kalavatt  300 Nov  7 14:58 submit-FastQC.sh
# -rw-rw----  1 kalavatt 1.2K Nov 28 12:48 submit-preprocessing-convert-bam-fastq.sh
# -rw-rw----  1 kalavatt  450 Nov 26 14:00 submit-preprocessing-exclude-bam-reads-unmapped.sh
# -rw-rw----  1 kalavatt  330 Nov 26 10:55 submit-preprocessing-fastqc.sh
# -rw-rw----  1 kalavatt 4.3K Nov 29 06:52 submit-preprocessing-filter-uncorrectable-fastq.py
# -rw-rw----  1 kalavatt  313 Nov 26 14:00 submit-preprocessing-index-bam.sh
# -rw-rw----  1 kalavatt  942 Nov 28 09:18 submit-preprocessing-split-bam-species.sh
# -rw-rw----  1 kalavatt  892 Nov 26 12:21 submit-preprocessing-star-genome-free.sh
# -rw-rw----  1 kalavatt 1002 Nov 26 13:52 submit-preprocessing-star-genome-guided.sh
# -rw-rw----  1 kalavatt  917 Nov 26 11:00 submit-preprocessing-trim_galore.sh
# -rw-rw----  1 kalavatt  871 Nov 18 14:52 submit-STAR-alignReads-multi-hit.sh
# -rw-rw----  1 kalavatt  874 Nov 18 14:53 submit-STAR-alignReads.tags.multi-hit-mode.sh
# -rw-rw----  1 kalavatt 1.4K Nov 18 14:38 submit-STAR-alignReads.tags.rna-star.sh
# -rw-rw----  1 kalavatt  694 Nov 28 07:50 submit-Trinity.sh
# -rw-rw----  1 kalavatt 1.2K Nov 22 14:54 submit-Trinity-trial-genome-free.sh
# -rw-rw----  1 kalavatt 1.2K Nov 22 10:47 submit-Trinity-trial-genome-guided.sh
# -rw-rw----  1 kalavatt  45K Nov 29 14:09 work-Python-local.key-bindings-system.json
# -rw-rw----  1 kalavatt 1.7K Nov 29 14:09 work-Python-local.key-bindings-user.json
# -rw-rw----  1 kalavatt  53K Nov 29 14:52 work-Python-local.md
# -rw-rw----  1 kalavatt  23K Nov 16 12:23 work-TPM-calculation.md
# -rw-rw----  1 kalavatt 310K Nov 26 10:41 work-Trinity.md


#  Get together the script for correcting rCorrected .fastq files -------------
rm submit-preprocessing-filter-uncorrectable-fastq.py
cp \
	../../bin/filter_rCorrector-treated-fastqs.py \
	submit-preprocessing-filter-uncorrectable-fastq.py
# '../../bin/filter_rCorrector-treated-fastqs.py' -> 'submit-preprocessing-filter-uncorrectable-fastq.py'

# vi submit-preprocessing-filter-uncorrectable-fastq.py


#  Make an array for files of interest ----------------------------------------
unset fastqs_rcorrected
typeset -a fastqs_rcorrected
while IFS=" " read -r -d $'\0'; do
    fastqs_rcorrected+=( "${REPLY%.?.cor.fq.gz}" )
done < <(\
    find "exp_preprocessing/08_rcorrector" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_rcorrected[@]}"

IFS=" " read -r -a fastqs_rcorrected \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_rcorrected[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_rcorrected[@]}" && echo ""


#  Perform a test run of *filter-uncorrectable-fastq.py -----------------------
python submit-preprocessing-filter-uncorrectable-fastq.py --help
# usage: submit-preprocessing-filter-uncorrectable-fastq.py [-h] [-1 READS_LEFT]
#                                                           [-2 READS_RIGHT]
#                                                           [-s SAMPLE_ID]
#                                                           [-o DIR_OUT]
#                                                           [-g GZIP_OUT]
#
# Options for filtering, logging rCorrector fastq output
#
# optional arguments:
#   -h, --help            show this help message and exit
#   -1 READS_LEFT, --reads_left READS_LEFT
#                         R1 fastq infile (gzipped or not), including path
#   -2 READS_RIGHT, --reads_right READS_RIGHT
#                         R2 fastq infile (gzipped or not), including path
#   -s SAMPLE_ID, --sample_id SAMPLE_ID
#                         sample name to write to log file
#   -o DIR_OUT, --dir_out DIR_OUT
#                         outfile directory, including path
#   -g GZIP_OUT, --gzip_out GZIP_OUT
#                         write gzipped fastq outfiles (True or False)

i="${fastqs_rcorrected[0]}"
# echo "${i}"

python submit-preprocessing-filter-uncorrectable-fastq.py \
    -1 "${i}.1.cor.fq.gz" \
    -2 "${i}.2.cor.fq.gz" \
    -s "${i}" \
    -o "exp_preprocessing/08_rcorrector" \
    -g True
# Traceback (most recent call last):
#   File "submit-preprocessing-filter-uncorrectable-fastq.py", line 169, in <module>
#     unfix_log = open(opts.dir_out + '/rm_unfixable.%s.log' % opts.sample_id, 'w')
# FileNotFoundError: [Errno 2] No such file or directory: 'exp_preprocessing/08_rcorrector/rm_unfixable.exp_preprocessing/08_rcorrector/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.log'
```

Nice! It's working!  
...well, until just the end, it seems  

~~`#DONE` Fix this error `#TOMORROW`; it should be straightforward: remove `opts.dir_out + ` from lines `169` and `194`~~

<a id="next-steps-following-the-successful-completion-of-rcorrector-treatment-and-correction-2022-1129"></a>
##### Next steps following the successful completion of `rCorrector` treatment and correction (2022-1129)
- `#TODO` The next step is to get `SLURM` submission scripts set up for...  
	+ the initial use of `rCorrector`
	+ the "correction" of `rCorrector`-treated files  
- `#TODO` Also, need to get a couple of `FastQC` readouts in there,  
	+ one after the initial use of `rCorrector`
	+ one after the use of the correction script
- After that, I'll want to run `Trinity` (`v2.12` for consistency; however, after this experiment, we'll move on to using `Trinity v2.14`) using the output from `04b` (genome-guided) and `08` (genome-free; `unfixrm.*`)
- Once that's done, I'll use the `.fasta` files as input to the `PASA` (`Singularity`) pipeline, generating outfiles that can be compared to the first run (*in which no preprocessing was performed*)
- `#TODO` Learn how to read and make sense of the outfiles, and then determine the next steps, which include loading the data to `IGV` and or running `DETONATE`, etc.
- `#GOAL` Determine whether preprocessing makes an impact (positive or negative) on transcriptome assembly

```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" ||
	echo "cd'ing failed; check on this"


#  Get together the script for correcting rCorrected .fastq files -------------
#  Make the changes to filter_rCorrector-treated-fastqs.py described above...
rm submit-preprocessing-filter-uncorrectable-fastq.py
cp \
	../../bin/filter_rCorrector-treated-fastqs.py \
	submit-preprocessing-filter-uncorrectable-fastq.py
# '../../bin/filter_rCorrector-treated-fastqs.py' -> 'submit-preprocessing-filter-uncorrectable-fastq.py'

# vi submit-preprocessing-filter-uncorrectable-fastq.py


#  Make an array for files of interest ----------------------------------------
unset fastqs_rcorrected
typeset -a fastqs_rcorrected
while IFS=" " read -r -d $'\0'; do
    fastqs_rcorrected+=( "${REPLY%.?.cor.fq.gz}" )
done < <(\
    find "exp_preprocessing/08_rcorrector" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_rcorrected[@]}"

IFS=" " read -r -a fastqs_rcorrected \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_rcorrected[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_rcorrected[@]}" && echo ""


#  Perform a test run of *filter-uncorrectable-fastq.py -----------------------
# python submit-preprocessing-filter-uncorrectable-fastq.py --help

i="${fastqs_rcorrected[0]}"
# echo "${i}"

python submit-preprocessing-filter-uncorrectable-fastq.py \
    -1 "${i}.1.cor.fq.gz" \
    -2 "${i}.2.cor.fq.gz" \
    -s "${i}" \
    -o "exp_preprocessing/08_rcorrector" \
    -g True
# Traceback (most recent call last):
#   File "submit-preprocessing-filter-uncorrectable-fastq.py", line 169, in <module>
#     unfix_log = open(opts.dir_out + '/rm_unfixable.%s.log' % opts.sample_id, 'w')
# FileNotFoundError: [Errno 2] No such file or directory: 'exp_preprocessing/08_rcorrector/rm_unfixable.exp_preprocessing/08_rcorrector/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.log'
```

<a id="get-slurm-submission-scripts-set-up-for-rcorrector-and-correction-of-rcorrector-2022-1130"></a>
#### Get `SLURM` submission scripts set up for `rCorrector` and "correction of `rCorrector`" (2022-1130)
<a id="for-rcorrector"></a>
##### ...for `rCorrector`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" ||
	echo "cd'ing failed; check on this"

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

which rcorrector
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/rcorrector

which parallel
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/parallel


#  Make an array for files of interest ----------------------------------------
unset fastqs_from_bams
typeset -a fastqs_from_bams
while IFS=" " read -r -d $'\0'; do
    fastqs_from_bams+=( "${REPLY%.?.fq.gz}" )
done < <(\
    find "exp_preprocessing/06_bam-to-fastq" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_from_bams[@]}"
# exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/06_bam-to-fastq/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/06_bam-to-fastq/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all

IFS=" " read -r -a fastqs_from_bams \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_from_bams[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_from_bams[@]}" && echo ""
# exp_preprocessing/06_bam-to-fastq/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/06_bam-to-fastq/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all


#  Prep the SLURM script for running rcorrector -------------------------------
threads=8
outdir="exp_preprocessing/08_rcorrector"

if [[ -f submit-preprocessing-rcorrector.sh ]]; then
    rm submit-preprocessing-rcorrector.sh
fi
cat << script > "./submit-preprocessing-rcorrector.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./exp_preprocessing/submit-preprocessing-rcorrector.%J.err.txt
#SBATCH --output=./exp_preprocessing/submit-preprocessing-rcorrector.%J.out.txt

#  submit-preprocessing-rcorrector.sh
#  KA
#  $(date '+%Y-%m%d')


instring="\${1}"
outdir="\${2}"
threads="\${3}"

parallel --header : --colsep " " -k -j 1 echo \\
"run_rcorrector.pl \\
    -t {threads} \\
    -1 {instring}.1.fq.gz \\
    -2 {instring}.2.fq.gz \\
    -od {outdir}" \\
::: threads "\${threads}" \\
::: instring "\${instring}" \\
::: outdir "\${outdir}"

parallel --header : --colsep " " -k -j 1 \\
run_rcorrector.pl \\
    -t {threads} \\
    -1 {instring}.1.fq.gz \\
    -2 {instring}.2.fq.gz \\
    -od {outdir} \\
::: threads "\${threads}" \\
::: instring "\${instring}" \\
::: outdir "\${outdir}"
script
vi submit-preprocessing-rcorrector.sh


#  Submit jobs for running rcorrector -----------------------------------------
for i in "${fastqs_from_bams[@]}"; do
    # i="${fastqs_from_bams[0]}"
    echo "Working with ${i}..."
    sbatch ./submit-preprocessing-rcorrector.sh \
        "${i}" \
        "${outdir}" \
        "${threads}"

    sleep 0.25
    echo ""
done
```

<a id="for-correction-of-rcorrector"></a>
##### ...for "correction of `rCorrector`"
`#DEKO`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101" ||
	echo "cd'ing failed; check on this"

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

which rcorrector
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/rcorrector

which parallel
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/parallel


#  Make an array for files of interest ----------------------------------------
unset fastqs_rcorrected
typeset -a fastqs_rcorrected
while IFS=" " read -r -d $'\0'; do
    fastqs_rcorrected+=( "${REPLY%.?.cor.fq.gz}" )
done < <(\
    find "exp_preprocessing/08_rcorrector" \
        -type f \
        -name *.gz \
        -print0 \
            | sort -z \
)
echo "w/duplicates..."
echoTest "${fastqs_rcorrected[@]}"
# exp_preprocessing/08_rcorrector/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/08_rcorrector/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/08_rcorrector/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/08_rcorrector/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all

IFS=" " read -r -a fastqs_rcorrected \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fastqs_rcorrected[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo "w/o duplicates..."
echoTest "${fastqs_rcorrected[@]}" && echo ""
# exp_preprocessing/08_rcorrector/5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all
# exp_preprocessing/08_rcorrector/5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all

```

Opposite to what we saw before
IN = Input, steady-state; IP = Nascent, immunoprecipitation (should be using IP, not IN; but IN is fine)
