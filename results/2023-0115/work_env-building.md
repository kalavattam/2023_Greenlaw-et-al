
`#work_env-building.md`


## Install `miniconda`
```bash
#!/bin/bash

pwd

curl https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh \
    > Miniconda3-py39_22.11.1-1-Linux-x86_64.sh

bash Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
```

### Include safeguards to prevent package installation in base environment
Code snippets (adapted) to deny `conda install` commands if in the base environment (from [here](https://github.com/conda/conda/issues/7791)):
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
<br />
<br />

## Rebuilding `Trinity_env`
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

mamba install -c conda-forge pybktree
#  Installed in an effort to get the below working; however, after installing
#+ it, it requested a 2.7-version of package python_abi, but this is a python
#+ 3.10 environment, so something like mamba install -c conda-forge
#+ python_abi=2.7 is not possible here; thus, decided to create a separate
#+ environment for umi_tools
#+
#+ Anyway, pbktree is now an "orphan package" in the environment and does not
#+ need to be included in the final build .yml for Trinity_env

mamba install -c bioconda -c conda-forge multiqc
```

`#NOTE` The version of samtools installed is 1.3&mdash;it's quite old  
`#TODO` Check on the versions of the other installed `bioconda` packages
`#NOTE` So there are obvious improvements that need to happen befor finalizing a `.yml`
<br />
<br />

## Building a `umi_tools_env`
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
