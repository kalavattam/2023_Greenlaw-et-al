
`#work_MultiQC.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Perform FastQC analyses](#perform-fastqc-analyses)
	1. [Grab a node, get situated, make necessary outdirectories](#grab-a-node-get-situated-make-necessary-outdirectories)
		1. [Code](#code)
		1. [Printed](#printed)
	1. [Run FastQC on fastqs](#run-fastqc-on-fastqs)
		1. [Create arrays of fastq files of interest](#create-arrays-of-fastq-files-of-interest)
			1. [Code](#code-1)
		1. [Use GNU parallel to run FastQC on fastq array elements](#use-gnu-parallel-to-run-fastqc-on-fastq-array-elements)
			1. [Code](#code-2)
	1. [Run FastQC on bams](#run-fastqc-on-bams)
		1. [Create arrays of bam files of interest](#create-arrays-of-bam-files-of-interest)
			1. [Code](#code-3)
		1. [Use GNU parallel to run FastQC on bam array elements](#use-gnu-parallel-to-run-fastqc-on-bam-array-elements)
			1. [Code](#code-4)
1. [Run MultiQC](#run-multiqc)
	1. [Code](#code-5)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="perform-fastqc-analyses"></a>
## Perform FastQC analyses
<a id="grab-a-node-get-situated-make-necessary-outdirectories"></a>
### Grab a node, get situated, make necessary outdirectories
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Grab a node, get situated, make necessary outdirectories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115"
grabnode  # 16, etc.
Trinity_env

if [[ ! -d FastQC/fastqs_UMI-dedup ]]; then
    mkdir -p FastQC/fastqs_UMI-dedup/{atria_trim,rcorrector,rcorrector_clean-up,symlinks,umi-tools_extract}
fi

if [[ ! -d FastQC/bams_UMI-dedup ]]; then
    mkdir -p FastQC/bams_UMI-dedup/{aligned_umi-extracted_trimmed,aligned_umi-extracted_trimmed_kmer-corrected,aligned_UTK_primary,aligned_UTK_primary_dedup-pos}
    mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary_dedup-UMI,aligned_UTK_primary-secondary,aligned_UTK_primary-secondary_sans-KL-20S}
    mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq,aligned_UTK_primary-secondary_sans-KL-20S_merged}
    mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq,aligned_UTK_primary-unmapped}
    mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-unmapped_sans-KL-20S,aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq}
    mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-unmapped_sans-KL-20S_merged,aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq}
    mkdir -p FastQC/bams_UMI-dedup/{aligned_UT_primary,aligned_UT_primary_dedup-pos,aligned_UT_primary_dedup-UMI}
    mkdir -p FastQC/bams_UMI-dedup/{to-align_umi-extracted_trimmed,to-align_umi-extracted_trimmed_kmer-corrected}
fi
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Get situated, make outdirectories</i></summary>

```txt
❯ if [[ ! -d FastQC/fastqs_UMI-dedup ]]; then
>     mkdir -p FastQC/fastqs_UMI-dedup/{atria_trim,rcorrector,rcorrector_clean-up,symlinks,umi-tools_extract}
> fi
mkdir: created directory 'FastQC'
mkdir: created directory 'FastQC/fastqs_UMI-dedup'
mkdir: created directory 'FastQC/fastqs_UMI-dedup/atria_trim'
mkdir: created directory 'FastQC/fastqs_UMI-dedup/rcorrector'
mkdir: created directory 'FastQC/fastqs_UMI-dedup/rcorrector_clean-up'
mkdir: created directory 'FastQC/fastqs_UMI-dedup/symlinks'
mkdir: created directory 'FastQC/fastqs_UMI-dedup/umi-tools_extract'


❯ if [[ ! -d FastQC/bams_UMI-dedup ]]; then
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_umi-extracted_trimmed,aligned_umi-extracted_trimmed_kmer-corrected,aligned_UTK_primary,aligned_UTK_primary_dedup-pos}
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary_dedup-UMI,aligned_UTK_primary-secondary,aligned_UTK_primary-secondary_sans-KL-20S}
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq,aligned_UTK_primary-secondary_sans-KL-20S_merged}
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq,aligned_UTK_primary-unmapped}
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-unmapped_sans-KL-20S,aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq}
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_UTK_primary-unmapped_sans-KL-20S_merged,aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq}
>     mkdir -p FastQC/bams_UMI-dedup/{aligned_UT_primary,aligned_UT_primary_dedup-pos,aligned_UT_primary_dedup-UMI}
>     mkdir -p FastQC/bams_UMI-dedup/{to-align_umi-extracted_trimmed,to-align_umi-extracted_trimmed_kmer-corrected}
> fi
mkdir: created directory 'FastQC/bams_UMI-dedup'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_umi-extracted_trimmed'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary_dedup-pos'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary_dedup-UMI'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-secondary'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-unmapped'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UT_primary'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UT_primary_dedup-pos'
mkdir: created directory 'FastQC/bams_UMI-dedup/aligned_UT_primary_dedup-UMI'
mkdir: created directory 'FastQC/bams_UMI-dedup/to-align_umi-extracted_trimmed'
mkdir: created directory 'FastQC/bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected'
```
</details>
<br />

<a id="run-fastqc-on-fastqs"></a>
### Run FastQC on fastqs
<a id="create-arrays-of-fastq-files-of-interest"></a>
#### Create arrays of fastq files of interest
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: Create arrays of fastq files of interest bams</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Symlinked fastqs ---------------------------------------
unset fqs_sym
typeset -a fqs_sym
while IFS=" " read -r -d $'\0'; do
    fqs_sym+=( "${REPLY%_R?_001.fastq.gz}" )
done < <(\
    find "fastqs_UMI-dedup/symlinks" \
        -type l \
        -name "*.fastq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_sym[@]}"
echo "${#fqs_sym[@]}"

IFS=" " read -r -a fqs_sym \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_sym[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_sym[@]}"
echo "${#fqs_sym[@]}"

unset fqs_sym_r1
unset fqs_sym_r2
typeset -a fqs_sym_r1
typeset -a fqs_sym_r2
for i in "${fqs_sym[@]}"; do
    fqs_sym_r1+=("${i}_R1_001.fastq.gz")
    fqs_sym_r2+=("${i}_R3_001.fastq.gz")
done
echo_test "${fqs_sym_r1[@]}"
echo "${#fqs_sym_r1[@]}"
echo_test "${fqs_sym_r2[@]}"
echo "${#fqs_sym_r2[@]}"
# ., fastqs_UMI-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz


#  UMI-extracted fastqs -----------------------------------
unset fqs_UMI
typeset -a fqs_UMI
while IFS=" " read -r -d $'\0'; do
    fqs_UMI+=( "${REPLY%_R?.UMI.fq.gz}" )
done < <(\
    find "fastqs_UMI-dedup/umi-tools_extract" \
        -type f \
        -name "*.UMI.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UMI[@]}"
echo "${#fqs_UMI[@]}"

IFS=" " read -r -a fqs_UMI \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UMI[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UMI[@]}"
echo "${#fqs_UMI[@]}"

unset fqs_UMI_r1
unset fqs_UMI_r2
typeset -a fqs_UMI_r1
typeset -a fqs_UMI_r2
for i in "${fqs_UMI[@]}"; do
    fqs_UMI_r1+=("${i}_R1.UMI.fq.gz")
    fqs_UMI_r2+=("${i}_R3.UMI.fq.gz")
done
echo_test "${fqs_UMI_r1[@]}"
echo "${#fqs_UMI_r1[@]}"
echo_test "${fqs_UMI_r2[@]}"
echo "${#fqs_UMI_r2[@]}"
# ., fastqs_UMI-dedup/umi-tools_extract/5781_G1_IN_S5_R3.UMI.fq.gz


#  atria-trimmed fastqs -----------------------------------
unset fqs_atria
typeset -a fqs_atria
while IFS=" " read -r -d $'\0'; do
    fqs_atria+=( "${REPLY%_R?.UMI.atria.fq.gz}" )
done < <(\
    find "fastqs_UMI-dedup/atria_trim" \
        -maxdepth 1 \
        -type f \
        -name "*.UMI.atria.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_atria[@]}"
echo "${#fqs_atria[@]}"

IFS=" " read -r -a fqs_atria \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_atria[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_atria[@]}"
echo "${#fqs_atria[@]}"

unset fqs_atria_r1
unset fqs_atria_r2
typeset -a fqs_atria_r1
typeset -a fqs_atria_r2
for i in "${fqs_atria[@]}"; do
    fqs_atria_r1+=("${i}_R1.UMI.atria.fq.gz")
    fqs_atria_r2+=("${i}_R3.UMI.atria.fq.gz")
done
echo_test "${fqs_atria_r1[@]}"
echo "${#fqs_atria_r1[@]}"
echo_test "${fqs_atria_r2[@]}"
echo "${#fqs_atria_r2[@]}"
# ., fastqs_UMI-dedup/atria_trim/5781_G1_IN_S5_R3.UMI.atria.fq.gz


#  rcorrected fastqs -------------------------------------
unset fqs_rcor
typeset -a fqs_rcor
while IFS=" " read -r -d $'\0'; do
    fqs_rcor+=( "${REPLY%_R?.UMI.atria.cor.fq.gz}" )
done < <(\
    find "fastqs_UMI-dedup/rcorrector" \
        -maxdepth 1 \
        -type f \
        -name "*.UMI.atria.cor.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_rcor[@]}"
echo "${#fqs_rcor[@]}"

IFS=" " read -r -a fqs_rcor \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_rcor[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_rcor[@]}"
echo "${#fqs_rcor[@]}"

unset fqs_rcor_r1
unset fqs_rcor_r2
typeset -a fqs_rcor_r1
typeset -a fqs_rcor_r2
for i in "${fqs_rcor[@]}"; do
    fqs_rcor_r1+=("${i}_R1.UMI.atria.cor.fq.gz")
    fqs_rcor_r2+=("${i}_R3.UMI.atria.cor.fq.gz")
done
echo_test "${fqs_rcor_r1[@]}"
echo "${#fqs_rcor_r1[@]}"
echo_test "${fqs_rcor_r2[@]}"
echo "${#fqs_rcor_r2[@]}"
# ., fastqs_UMI-dedup/rcorrector/5781_G1_IN_S5_R3.UMI.atria.cor.fq.gz


#  rcorrector-corrected fastqs ----------------------------
unset fqs_rcor_cor
typeset -a fqs_rcor_cor
while IFS=" " read -r -d $'\0'; do
    fqs_rcor_cor+=( "${REPLY%_R?.UMI.atria.cor.rm-unfx.fq.gz}" )
done < <(\
    find "fastqs_UMI-dedup/rcorrector_clean-up" \
        -maxdepth 1 \
        -type f \
        -name "*.UMI.atria.cor.rm-unfx.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_rcor_cor[@]}"
echo "${#fqs_rcor_cor[@]}"

IFS=" " read -r -a fqs_rcor_cor \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_rcor_cor[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_rcor_cor[@]}"
echo "${#fqs_rcor_cor[@]}"

unset fqs_rcor_cor_r1
unset fqs_rcor_cor_r2
typeset -a fqs_rcor_cor_r1
typeset -a fqs_rcor_cor_r2
for i in "${fqs_rcor_cor[@]}"; do
    fqs_rcor_cor_r1+=("${i}_R1.UMI.atria.cor.rm-unfx.fq.gz")
    fqs_rcor_cor_r2+=("${i}_R3.UMI.atria.cor.rm-unfx.fq.gz")
done
echo_test "${fqs_rcor_cor_r1[@]}"
echo "${#fqs_rcor_cor_r1[@]}"
echo_test "${fqs_rcor_cor_r2[@]}"
echo "${#fqs_rcor_cor_r2[@]}"
# ., fastqs_UMI-dedup/rcorrector_clean-up/5781_G1_IN_S5_R3.UMI.atria.cor.rm-unfx.fq.gz
```
</details>
<br />

<a id="use-gnu-parallel-to-run-fastqc-on-fastq-array-elements"></a>
#### Use GNU parallel to run FastQC on fastq array elements
<a id="code-2"></a>
##### Code

<details>
<summary><i>Code: Use GNU parallel to run FastQC on fastq array elements</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# fastqs_UMI-dedup/{atria_trim,rcorrector,rcorrector_clean-up,symlinks,umi-tools_extract}

parallel \
    --header : \
    --colsep " " \
    -k \
    -j 1 \
'fastqc \
    --threads {threads} \
    --outdir FastQC/{infile//} \
    {infile}' \
::: threads "${SLURM_CPUS_ON_NODE}" \
::: infile \
    "${fqs_sym_r1[@]}" \
    "${fqs_sym_r2[@]}" \
    "${fqs_UMI_r1[@]}" \
    "${fqs_UMI_r2[@]}" \
    "${fqs_atria_r1[@]}" \
    "${fqs_atria_r2[@]}" \
    "${fqs_rcor_r1[@]}" \
    "${fqs_rcor_r2[@]}" \
    "${fqs_rcor_cor_r1[@]}" \
    "${fqs_rcor_cor_r2[@]}"
```
</details>
<br />

<a id="run-fastqc-on-bams"></a>
### Run FastQC on bams
<a id="create-arrays-of-bam-files-of-interest"></a>
#### Create arrays of bam files of interest
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Create arrays of bam files of interest bams</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  ----------------
unset bams_UT
typeset -a bams_UT
while IFS=" " read -r -d $'\0'; do
    bams_UT+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_umi-extracted_trimmed" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT[@]}"
echo "${#bams_UT[@]}"


#  ----------------
unset bams_UTK
typeset -a bams_UTK
while IFS=" " read -r -d $'\0'; do
    bams_UTK+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_umi-extracted_trimmed_kmer-corrected" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK[@]}"
echo "${#bams_UTK[@]}"


#  ----------------
unset bams_UTK_prim
typeset -a bams_UTK_prim
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim[@]}"
echo "${#bams_UTK_prim[@]}"


#  ----------------
unset bams_UTK_prim_dedup_pos
typeset -a bams_UTK_prim_dedup_pos
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim_dedup_pos+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary_dedup-pos" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim_dedup_pos[@]}"
echo "${#bams_UTK_prim_dedup_pos[@]}"


#  ----------------
unset bams_UTK_prim_dedup_UMI
typeset -a bams_UTK_prim_dedup_UMI
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim_dedup_UMI+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary_dedup-UMI" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim_dedup_UMI[@]}"
echo "${#bams_UTK_prim_dedup_UMI[@]}"


#  ----------------
unset bams_UTK_prim_sec
typeset -a bams_UTK_prim_sec
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim_sec+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-secondary" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim_sec[@]}"
echo "${#bams_UTK_prim_sec[@]}"


#  ----------------
unset bams_UTK_prim_sec_sans_KL_20S
typeset -a bams_UTK_prim_sec_sans_KL_20S
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim_sec_sans_KL_20S+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim_sec_sans_KL_20S[@]}"
echo "${#bams_UTK_prim_sec_sans_KL_20S[@]}"


#  ----------------
unset bams_UTK_prim_sec_sans_KL_20S_merged
typeset -a bams_UTK_prim_sec_sans_KL_20S_merged
while IFS=" " read -r -d $'\0'; do
    bams_UTK_prim_sec_sans_KL_20S_merged+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_prim_sec_sans_KL_20S_merged[@]}"
echo "${#bams_UTK_prim_sec_sans_KL_20S_merged[@]}"


#  ----------------
unset bams_UTK_proper_etc
typeset -a bams_UTK_proper_etc
while IFS=" " read -r -d $'\0'; do
    bams_UTK_proper_etc+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-unmapped" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_proper_etc[@]}"
echo "${#bams_UTK_proper_etc[@]}"


#  ----------------
unset bams_UTK_proper_etc_SC
typeset -a bams_UTK_proper_etc_SC
while IFS=" " read -r -d $'\0'; do
    bams_UTK_proper_etc_SC+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_proper_etc_SC[@]}"
echo "${#bams_UTK_proper_etc_SC[@]}"


#  ----------------
unset bams_UTK_proper_etc_SC_merged
typeset -a bams_UTK_proper_etc_SC_merged
while IFS=" " read -r -d $'\0'; do
    bams_UTK_proper_etc_SC_merged+=( "${REPLY}" )
done < <(\
    find ., "bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UTK_proper_etc_SC_merged[@]}"
echo "${#bams_UTK_proper_etc_SC_merged[@]}"


#  ----------------
unset bams_UT_prim
typeset -a bams_UT_prim
while IFS=" " read -r -d $'\0'; do
    bams_UT_prim+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UT_primary" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT_prim[@]}"
echo "${#bams_UT_prim[@]}"


#  ----------------
unset bams_UT_prim_dedup_pos
typeset -a bams_UT_prim_dedup_pos
while IFS=" " read -r -d $'\0'; do
    bams_UT_prim_dedup_pos+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UT_primary_dedup-pos" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT_prim_dedup_pos[@]}"
echo "${#bams_UT_prim_dedup_pos[@]}"


#  ----------------
unset bams_UT_prim_dedup_UMI
typeset -a bams_UT_prim_dedup_UMI
while IFS=" " read -r -d $'\0'; do
    bams_UT_prim_dedup_UMI+=( "${REPLY}" )
done < <(\
    find "bams_UMI-dedup/aligned_UT_primary_dedup-UMI" \
        -maxdepth 1 \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${bams_UT_prim_dedup_UMI[@]}"
echo "${#bams_UT_prim_dedup_UMI[@]}"


#  ----------------
unset fqs_UT
typeset -a fqs_UT
while IFS=" " read -r -d $'\0'; do
    fqs_UT+=( "${REPLY%_R?.fq.gz}" )
done < <(\
    find "bams_UMI-dedup/to-align_umi-extracted_trimmed" \
        -type l \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UT[@]}"
echo "${#fqs_UT[@]}"

IFS=" " read -r -a fqs_UT \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UT[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UT[@]}"
echo "${#fqs_UT[@]}"

unset fqs_UT_r1
unset fqs_UT_r2
typeset -a fqs_UT_r1
typeset -a fqs_UT_r2
for i in "${fqs_UT[@]}"; do
    fqs_UT_r1+=("${i}_R1.fq.gz")
    fqs_UT_r2+=("${i}_R3.fq.gz")
done
echo_test "${fqs_UT_r1[@]}"
echo "${#fqs_UT_r1[@]}"
echo_test "${fqs_UT_r2[@]}"
echo "${#fqs_UT_r2[@]}"
# ., bams_UMI-dedup/to-align_umi-extracted_trimmed/5781_G1_IN_UT_R3.fq.gz


#  ----------------
unset fqs_UTK
typeset -a fqs_UTK
while IFS=" " read -r -d $'\0'; do
    fqs_UTK+=( "${REPLY%_R?.fq.gz}" )
done < <(\
    find "bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected" \
        -type l \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UTK[@]}"
echo "${#fqs_UTK[@]}"

IFS=" " read -r -a fqs_UTK \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UTK[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UTK[@]}"
echo "${#fqs_UTK[@]}"

unset fqs_UTK_r1
unset fqs_UTK_r2
typeset -a fqs_UTK_r1
typeset -a fqs_UTK_r2
for i in "${fqs_UTK[@]}"; do
    fqs_UTK_r1+=("${i}_R1.fq.gz")
    fqs_UTK_r2+=("${i}_R3.fq.gz")
done
echo_test "${fqs_UTK_r1[@]}"
echo "${#fqs_UTK_r1[@]}"
echo_test "${fqs_UTK_r2[@]}"
echo "${#fqs_UTK_r2[@]}"
# ., bams_UMI-dedup/to-align_umi-extracted_trimmed_kmer-corrected/5781_G1_IN_UTK_R3.fq.gz


#  ----------------
unset fqs_UTK_prim_sec_SC
typeset -a fqs_UTK_prim_sec_SC
while IFS=" " read -r -d $'\0'; do
    fqs_UTK_prim_sec_SC+=( "${REPLY%.?.fq.gz}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq" \
        -type f \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UTK_prim_sec_SC[@]}"
echo "${#fqs_UTK_prim_sec_SC[@]}"

IFS=" " read -r -a fqs_UTK_prim_sec_SC \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UTK_prim_sec_SC[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UTK_prim_sec_SC[@]}"
echo "${#fqs_UTK_prim_sec_SC[@]}"

unset fqs_UTK_prim_sec_SC_r1
unset fqs_UTK_prim_sec_SC_r2
typeset -a fqs_UTK_prim_sec_SC_r1
typeset -a fqs_UTK_prim_sec_SC_r2
for i in "${fqs_UTK_prim_sec_SC[@]}"; do
    fqs_UTK_prim_sec_SC_r1+=("${i}.1.fq.gz")
    fqs_UTK_prim_sec_SC_r2+=("${i}.2.fq.gz")
done
echo_test "${fqs_UTK_prim_sec_SC_r1[@]}"
echo "${#fqs_UTK_prim_sec_SC_r1[@]}"
echo_test "${fqs_UTK_prim_sec_SC_r2[@]}"
echo "${#fqs_UTK_prim_sec_SC_r2[@]}"
# ., bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.primary-secondary.SC.2.fq.gz


#  ----------------
unset fqs_UTK_prim_sec_SC_merged
typeset -a fqs_UTK_prim_sec_SC_merged
while IFS=" " read -r -d $'\0'; do
    fqs_UTK_prim_sec_SC_merged+=( "${REPLY%.?.fq.gz}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq" \
        -type f \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UTK_prim_sec_SC_merged[@]}"
echo "${#fqs_UTK_prim_sec_SC_merged[@]}"

IFS=" " read -r -a fqs_UTK_prim_sec_SC_merged \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UTK_prim_sec_SC_merged[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UTK_prim_sec_SC_merged[@]}"
echo "${#fqs_UTK_prim_sec_SC_merged[@]}"

unset fqs_UTK_prim_sec_SC_merged_r1
unset fqs_UTK_prim_sec_SC_merged_r2
typeset -a fqs_UTK_prim_sec_SC_merged_r1
typeset -a fqs_UTK_prim_sec_SC_merged_r2
for i in "${fqs_UTK_prim_sec_SC_merged[@]}"; do
    fqs_UTK_prim_sec_SC_merged_r1+=("${i}.1.fq.gz")
    fqs_UTK_prim_sec_SC_merged_r2+=("${i}.2.fq.gz")
done
echo_test "${fqs_UTK_prim_sec_SC_merged_r1[@]}"
echo "${#fqs_UTK_prim_sec_SC_merged_r1[@]}"
echo_test "${fqs_UTK_prim_sec_SC_merged_r2[@]}"
echo "${#fqs_UTK_prim_sec_SC_merged_r2[@]}"
# ., bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.primary-secondary.SC.2.fq.gz


#  ----------------
unset fqs_UTK_prop_SC
typeset -a fqs_UTK_prop_SC
while IFS=" " read -r -d $'\0'; do
    fqs_UTK_prop_SC+=( "${REPLY%.?.fq.gz}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq" \
        -type f \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UTK_prop_SC[@]}"
echo "${#fqs_UTK_prop_SC[@]}"

IFS=" " read -r -a fqs_UTK_prop_SC \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UTK_prop_SC[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UTK_prop_SC[@]}"
echo "${#fqs_UTK_prop_SC[@]}"

unset fqs_UTK_prop_SC_r1
unset fqs_UTK_prop_SC_r2
typeset -a fqs_UTK_prop_SC_r1
typeset -a fqs_UTK_prop_SC_r2
for i in "${fqs_UTK_prop_SC[@]}"; do
    fqs_UTK_prop_SC_r1+=("${i}.1.fq.gz")
    fqs_UTK_prop_SC_r2+=("${i}.2.fq.gz")
done
echo_test "${fqs_UTK_prop_SC_r1[@]}"
echo "${#fqs_UTK_prop_SC_r1[@]}"
echo_test "${fqs_UTK_prop_SC_r2[@]}"
echo "${#fqs_UTK_prop_SC_r2[@]}"
# ., bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_bam-to-fastq/5781_G1_IN_UTK.proper-etc.SC.2.fq.gz


#  ----------------
unset fqs_UTK_prop_SC_merged
typeset -a fqs_UTK_prop_SC_merged
while IFS=" " read -r -d $'\0'; do
    fqs_UTK_prop_SC_merged+=( "${REPLY%.?.fq.gz}" )
done < <(\
    find "bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq" \
        -type f \
        -name "*.fq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fqs_UTK_prop_SC_merged[@]}"
echo "${#fqs_UTK_prop_SC_merged[@]}"

IFS=" " read -r -a fqs_UTK_prop_SC_merged \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fqs_UTK_prop_SC_merged[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echo_test "${fqs_UTK_prop_SC_merged[@]}"
echo "${#fqs_UTK_prop_SC_merged[@]}"

unset fqs_UTK_prop_SC_merged_r1
unset fqs_UTK_prop_SC_merged_r2
typeset -a fqs_UTK_prop_SC_merged_r1
typeset -a fqs_UTK_prop_SC_merged_r2
for i in "${fqs_UTK_prop_SC_merged[@]}"; do
    fqs_UTK_prop_SC_merged_r1+=("${i}.1.fq.gz")
    fqs_UTK_prop_SC_merged_r2+=("${i}.2.fq.gz")
done
echo_test "${fqs_UTK_prop_SC_merged_r1[@]}"
echo "${#fqs_UTK_prop_SC_merged_r1[@]}"
echo_test "${fqs_UTK_prop_SC_merged_r2[@]}"
echo "${#fqs_UTK_prop_SC_merged_r2[@]}"
# ., bams_UMI-dedup/aligned_UTK_primary-unmapped_sans-KL-20S_merged_bam-to-fastq/merged_G1_IN_UTK.proper-etc.SC.2.fq.gz
```
</details>
<br />

<a id="use-gnu-parallel-to-run-fastqc-on-bam-array-elements"></a>
#### Use GNU parallel to run FastQC on bam array elements
<a id="code-4"></a>
##### Code

<details>
<summary><i>Code: Use GNU parallel to run FastQC on bam array elements</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    --header : \
    --colsep " " \
    -k \
    -j 1 \
'fastqc \
    --threads {threads} \
    --outdir FastQC/{infile//} \
    {infile}' \
::: threads "${SLURM_CPUS_ON_NODE}" \
::: infile \
    "${bams_UT[@]}" \
    "${bams_UTK[@]}" \
    "${bams_UTK_prim[@]}" \
    "${bams_UTK_prim_dedup_pos[@]}" \
    "${bams_UTK_prim_dedup_UMI[@]}" \
    "${bams_UTK_prim_sec[@]}" \
    "${bams_UTK_prim_sec_sans_KL_20S[@]}" \
    "${bams_UTK_prim_sec_sans_KL_20S_merged[@]}" \
    "${bams_UTK_proper_etc[@]}" \
    "${bams_UTK_proper_etc_SC[@]}" \
    "${bams_UTK_proper_etc_SC_merged[@]}" \
    "${bams_UT_prim[@]}" \
    "${bams_UT_prim_dedup_pos[@]}" \
    "${bams_UT_prim_dedup_UMI[@]}" \
    "${fqs_UT_r1[@]}" \
    "${fqs_UT_r2[@]}" \
    "${fqs_UTK_r1[@]}" \
    "${fqs_UTK_r2[@]}" \
    "${fqs_UTK_prim_sec_SC_r1[@]}" \
    "${fqs_UTK_prim_sec_SC_r2[@]}" \
    "${fqs_UTK_prim_sec_SC_merged_r1[@]}" \
    "${fqs_UTK_prim_sec_SC_merged_r2[@]}" \
    "${fqs_UTK_prop_SC_r1[@]}" \
    "${fqs_UTK_prop_SC_r2[@]}" \
    "${fqs_UTK_prop_SC_merged_r1[@]}" \
    "${fqs_UTK_prop_SC_merged_r2[@]}"
```
</details>
<br />
<br />

<a id="run-multiqc"></a>
## Run MultiQC
<a id="code-5"></a>
### Code
<details>
<summary><i>Code: Run MultiQC</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir -p MultiQC/fastqs_UMI-dedup/symlinks

multiqc \
    --interactive \
    -o MultiQC/fastqs_UMI-dedup/symlinks \
	FastQC/fastqs_UMI-dedup/symlinks



```
</details>
<br />
