
`#work_prepare-data_GEO.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
1. [Prepare directory for GEO data](#prepare-directory-for-geo-data)
1. [Prepare and copy over `fastq`s](#prepare-and-copy-over-fastqs)
    1. [Get to and check `fastq` source directory](#get-to-and-check-fastq-source-directory)
    1. [Bespoke work: Give the samples accurate, correct names](#bespoke-work-give-the-samples-accurate-correct-names)
        1. [0. Naming scheme](#0-naming-scheme)
        1. [1. Uncorrected names with notes](#1-uncorrected-names-with-notes)
        1. [2. Corrected names \(rep, batch\), correctly ordered, and with notes](#2-corrected-names-rep-batch-correctly-ordered-and-with-notes)
        1. [3. Corrected names \(etc.\), now including strain information](#3-corrected-names-etc-now-including-strain-information)
        1. [4. Run print tests prior to copying `fastq`s](#4-run-print-tests-prior-to-copying-fastqs)
        1. [5. Copy the `fastq`s to `GEO/`, renaming them in the process](#5-copy-the-fastqs-to-geo-renaming-them-in-the-process)
        1. [6. Generate `MD5` checksums for the `fastq`s](#6-generate-md5-checksums-for-the-fastqs)
1. [Prepare and copy over `bam`s: standard analyses](#prepare-and-copy-over-bams-standard-analyses)
    1. [Get to pertinent source directory, examine `bam`s](#get-to-pertinent-source-directory-examine-bams)
        1. [Code](#code)
        1. [Printed](#printed)
    1. [Copy over `bam`s, renaming them in the process; generate `MD5` checksums too](#copy-over-bams-renaming-them-in-the-process-generate-md5-checksums-too)
        1. [Code](#code-1)
1. [Prepare and copy over `bam`s: transcriptome assembly work](#prepare-and-copy-over-bams-transcriptome-assembly-work)
    1. [Get to pertinent source directory, examine `bam`s](#get-to-pertinent-source-directory-examine-bams-1)
    1. [Copy over `bam`s, renaming them in the process; generate `MD5` checksums too](#copy-over-bams-renaming-them-in-the-process-generate-md5-checksums-too-1)
1. [Prepare and copy over `gff3`s and `gtf`s](#prepare-and-copy-over-gff3s-and-gtfs)
    1. [Determine/find/copy over the `gff3`s and `gtf`s to submit](#determinefindcopy-over-the-gff3s-and-gtfs-to-submit)
1. [Prepare and copy over counts matrices](#prepare-and-copy-over-counts-matrices)
    1. [Determine/find/copy over the counts matrices to submit](#determinefindcopy-over-the-counts-matrices-to-submit)
1. [Prepare and copy over `bw`s](#prepare-and-copy-over-bws)
    1. [Notes \(and code and printed\)](#notes-and-code-and-printed)
        1. [Code](#code-2)
        1. [Printed](#printed-1)
        1. [Printed](#printed-2)
        1. [Code](#code-3)
        1. [Printed](#printed-3)
        1. [Code](#code-4)
        1. [Printed](#printed-4)
        1. [Code](#code-5)
        1. [Printed](#printed-5)
        1. [Code](#code-6)
        1. [Printed](#printed-6)
        1. [Notes `#IMPORTANT`](#notes-important)
        1. [Notes `#IMPORTANT`](#notes-important-1)
        1. [Code](#code-7)
        1. [Printed](#printed-7)
        1. [Printed](#printed-8)
        1. [Code](#code-8)
        1. [Printed](#printed-9)
        1. [Code](#code-9)
        1. [Printed](#printed-10)
        1. [Notes `#IMPORTANT`](#notes-important-2)
        1. [Code](#code-10)
    1. [Correct misnamed files](#correct-misnamed-files)
        1. [Code](#code-11)
        1. [Printed](#printed-11)
1. [Visualize/assess the `GEO/` directory structure](#visualizeassess-the-geo-directory-structure)
    1. [Code](#code-12)
    1. [Printed](#printed-12)
1. [Copy files to a directory on the shared drive](#copy-files-to-a-directory-on-the-shared-drive)
    1. [Code](#code-13)
    1. [Printed](#printed-13)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="get-situated"></a>
## Get situated
<a id="code"></a>
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

tmux new -t "t"
grabnode  # 4, 80, 1, N

d_proj="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"
d_exp_1201="results/2022-1201"
d_exp_0115="results/2023-0115"
d_exp_0215="results/2023-0215"
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
...


❯ d_proj="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"


❯ d_exp_1201="results/2022-1201"


❯ d_exp_0115="results/2023-0115"


❯ d_exp_0215="results/2023-0215"
```
</details>
<br />
<br />

<a id="prepare-directory-for-geo-data"></a>
## Prepare directory for GEO data
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."
[[ ! -d GEO/ ]] &&
    {
        mkdir -p GEO/{bams,bws,matrices,fastqs,gtfs}
        mkdir -p GEO/bams/{transcriptome-assembly,standard-analyses}
        mkdir -p GEO/bws/{individual,mean}
    }


cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."
cd "fastqs_UMI-dedup/symlinks" || echo "cd'ing failed; check on this..."

ls -lhaFG
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."


❯ [[ ! -d GEO/ ]] &&
>     {
>         mkdir -p GEO/{bams,bws,matrices,fastqs,gtfs}
>         mkdir -p GEO/bams/{transcriptome-assembly,standard-analyses}
>     }
mkdir: created directory 'GEO'
mkdir: created directory 'GEO/bams'
mkdir: created directory 'GEO/bws'
mkdir: created directory 'GEO/matrices'
mkdir: created directory 'GEO/fastqs'
mkdir: created directory 'GEO/gtfs'
mkdir: created directory 'GEO/bams/transcriptome-assembly'
mkdir: created directory 'GEO/bams/standard-analyses'
mkdir: created directory 'GEO/bws'
mkdir: created directory 'GEO/bws/individual'
mkdir: created directory 'GEO/bws/mean'
```
</details>
<br />
<br />

<a id="prepare-and-copy-over-fastqs"></a>
## Prepare and copy over `fastq`s
<a id="get-to-and-check-fastq-source-directory"></a>
### Get to and check `fastq` source directory
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."
cd "fastqs_UMI-dedup/symlinks" || echo "cd'ing failed; check on this..."

ls -lhaFG
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."


❯ cd "fastqs_UMI-dedup/symlinks" || echo "cd'ing failed; check on this..."


❯ ls -lhaFG
total 5.6M
drwxrws--- 2 kalavatt 11K Mar 13 09:55 ./
drwxrws--- 7 kalavatt 154 Feb 10 10:23 ../
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5781_G1_IN_S5_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5781_G1_IN_S5_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5781_G1_IN_S5_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5781_G1_IP_S1_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5781_G1_IP_S1_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5781_G1_IP_S1_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5781_Q_IN_S6_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5781_Q_IN_S6_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5781_Q_IN_S6_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5781_Q_IP_S2_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5781_Q_IP_S2_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5781_Q_IP_S2_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5782_G1_IN_S7_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5782_G1_IN_S7_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5782_G1_IN_S7_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5782_G1_IP_S3_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5782_G1_IP_S3_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  94 Feb  5 10:40 5782_G1_IP_S3_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5782_Q_IN_S8_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5782_Q_IN_S8_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5782_Q_IN_S8_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5782_Q_IP_S4_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5782_Q_IP_S4_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  93 Feb  5 10:40 5782_Q_IP_S4_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  92 Mar 13 09:55 BM10_5781_DSp48_S26_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  92 Mar 13 09:55 BM10_5781_DSp48_S26_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  92 Mar 13 09:55 BM10_5781_DSp48_S26_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  92 Mar 13 09:55 BM12_7079_DSp48_S27_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  92 Mar 13 09:55 BM12_7079_DSp48_S27_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  92 Mar 13 09:55 BM12_7079_DSp48_S27_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:40 CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:40 CW10_7747_8day_Q_IN_S5_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_IN_S5_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:40 CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 112 Feb  5 10:40 CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 112 Feb  5 10:40 CW10_7747_8day_Q_PD_S11_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_PD_S11_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 112 Feb  5 10:40 CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:40 CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:40 CW12_7748_8day_Q_IN_S6_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_IN_S6_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:40 CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 112 Feb  5 10:40 CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 112 Feb  5 10:40 CW12_7748_8day_Q_PD_S12_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_PD_S12_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 112 Feb  5 10:40 CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  95 Mar 13 09:55 CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  95 Mar 13 09:55 CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  95 Mar 13 09:55 CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:41 CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:41 CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:41 CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA1_5781_SS_G1_S22_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA1_5781_SS_G1_S22_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA1_5781_SS_G1_S22_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA2_5782_SS_G1_S23_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA2_5782_SS_G1_S23_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA2_5782_SS_G1_S23_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA3_7078_SS_G1_S24_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA3_7078_SS_G1_S24_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA3_7078_SS_G1_S24_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA4_7079_SS_G1_S25_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA4_7079_SS_G1_S25_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt  91 Mar 13 09:55 DA4_7079_SS_G1_S25_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
```
</details>
<br />

<a id="bespoke-work-give-the-samples-accurate-correct-names"></a>
### Bespoke work: Give the samples accurate, correct names

<a id="0-naming-scheme"></a>
#### 0. Naming scheme
<details>
<summary><i>Notes</i></summary>

1. genotype: experiment or control sample `<chr>`
2. state: cell cycle or time in diauxic shift `<chr>`
3. day of sampling `<chr>`
4. library kit `<chr>`
5. transcription type `<chr>`
6. auxin status `<lgl>`
7. time course status `<lgl>`
8. strain number `<int>`
9. replicate info `<chr>`
10. batch info `<chr>`
</details>
<br />

<a id="1-uncorrected-names-with-notes"></a>
#### 1. Uncorrected names with notes
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        # unset A_fq; unset a_fq
        # typeset -A A_fq; typeset -a a_fq

        # #  Data to exclude because not used in project ------------------------
        #              A_fq["SAMPLE_BM2_DSm2_7080_S14"]="trf4_DSm2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_BM2_DSm2_7080_S14" )    #EXCLUDE
        #               A_fq["SAMPLE_Bp2_DSm2_7081_S2"]="trf4_DSm2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_Bp2_DSm2_7081_S2" )     #EXCLUDE
        #              A_fq["SAMPLE_BM5_DSp2_7080_S17"]="trf4_DSp2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_BM5_DSp2_7080_S17" )    #EXCLUDE
        #               A_fq["SAMPLE_Bp5_DSp2_7081_S5"]="trf4_DSp2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_Bp5_DSp2_7081_S5" )     #EXCLUDE
        #             A_fq["SAMPLE_BM8_DSp24_7080_S20"]="trf4_DSp24_day-3_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_BM8_DSp24_7080_S20" )   #EXCLUDE
        #              A_fq["SAMPLE_Bp8_DSp24_7081_S8"]="trf4_DSp24_day-3_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_Bp8_DSp24_7081_S8" )    #EXCLUDE
        #            A_fq["SAMPLE_BM11_DSp48_7080_S23"]="trf4_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_BM11_DSp48_7080_S23" )  #EXCLUDE
        #            A_fq["SAMPLE_Bp11_DSp48_7081_S11"]="trf4_DSp48_day-4_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_Bp11_DSp48_7081_S11" )  #EXCLUDE
        #
        #               A_fq["CW10_7747_8day_Q_PD_S11"]="rtr1_Q_day-8_tcn_N_aux-F_tc-F_rep1_batch1";           a_fq+=( "CW10_7747_8day_Q_PD_S11" )  #EXCLUDE  #FIXME* ∆ rep1 → rep2
        #               A_fq["CW12_7748_8day_Q_PD_S12"]="rtr1_Q_day-8_tcn_N_aux-F_tc-F_rep2_batch1";           a_fq+=( "CW12_7748_8day_Q_PD_S12" )  #EXCLUDE  #FIXME* ∆ rep2 → rep1
        #                A_fq["CW10_7747_8day_Q_IN_S5"]="rtr1_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch1";          a_fq+=( "CW10_7747_8day_Q_IN_S5" )   #EXCLUDE  #FIXME* ∆ rep1 → rep2
        #                A_fq["CW12_7748_8day_Q_IN_S6"]="rtr1_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch1";          a_fq+=( "CW12_7748_8day_Q_IN_S6" )   #EXCLUDE  #FIXME* ∆ rep2 → rep1
        #
        #        A_fq["Sample_CU11_5782_Q_Nascent_S11"]="WT_Q_day-7_tcn_N_aux-F_tc-F_rep2_batch1";             a_fq+=( "Sample_CU11_5782_Q_Nascent_S11" )      #EXCLUDE #FIXME† Duplicated #1
        #    A_fq["Sample_CU12_5782_Q_SteadyState_S12"]="WT_Q_day-7_tcn_SS_aux-F_tc-F_rep2_batch1";            a_fq+=( "Sample_CU12_5782_Q_SteadyState_S12" )  #EXCLUDE #FIXME† Duplicated #2
        #
        #     A_fq["Sample_CT6_7714_pIAA_Q_Nascent_S3"]="Nab3-Nrd1-AID_Q_day-7_tcn_N_aux-T_tc-F_rep3_batch1";  a_fq+=( "Sample_CT6_7714_pIAA_Q_Nascent_S3" )      #EXCLUDE
        # A_fq["Sample_CT6_7714_pIAA_Q_SteadyState_S8"]="Nab3-Nrd1-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep3_batch1"; a_fq+=( "Sample_CT6_7714_pIAA_Q_SteadyState_S8" )  #EXCLUDE

        #  Ovation data -------------------------------------------------------
                                  A_fq["5781_G1_IP_S1"]="WT_G1_day-1_ovn_N_aux-F_tc-F_rep1_batch1";            a_fq+=( "5781_G1_IP_S1" )
                                  A_fq["5782_G1_IP_S3"]="WT_G1_day-1_ovn_N_aux-F_tc-F_rep2_batch1";            a_fq+=( "5782_G1_IP_S3" )
                                  A_fq["5781_G1_IN_S5"]="WT_G1_day-1_ovn_SS_aux-F_tc-F_rep1_batch1";           a_fq+=( "5781_G1_IN_S5" )
                                  A_fq["5782_G1_IN_S7"]="WT_G1_day-1_ovn_SS_aux-F_tc-F_rep2_batch1";           a_fq+=( "5782_G1_IN_S7" )
                          
                                   A_fq["5781_Q_IP_S2"]="WT_Q_day-7_ovn_N_aux-F_tc-F_rep1_batch1";             a_fq+=( "5781_Q_IP_S2" )
                                   A_fq["5782_Q_IP_S4"]="WT_Q_day-7_ovn_N_aux-F_tc-F_rep2_batch1";             a_fq+=( "5782_Q_IP_S4" )
                                   A_fq["5781_Q_IN_S6"]="WT_Q_day-7_ovn_SS_aux-F_tc-F_rep1_batch1";            a_fq+=( "5781_Q_IN_S6" )
                                   A_fq["5782_Q_IN_S8"]="WT_Q_day-7_ovn_SS_aux-F_tc-F_rep2_batch1";            a_fq+=( "5782_Q_IN_S8" )

        #  rrp6∆ and control data ---------------------------------------------
                       A_fq["SAMPLE_BM1_DSm2_5781_S13"]="WT_DSm2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";         a_fq+=( "SAMPLE_BM1_DSm2_5781_S13" )
                        A_fq["SAMPLE_Bp1_DSm2_5782_S1"]="WT_DSm2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";         a_fq+=( "SAMPLE_Bp1_DSm2_5782_S1" )
                       A_fq["SAMPLE_BM4_DSp2_5781_S16"]="WT_DSp2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";         a_fq+=( "SAMPLE_BM4_DSp2_5781_S16" )
                        A_fq["SAMPLE_Bp4_DSp2_5782_S4"]="WT_DSp2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";         a_fq+=( "SAMPLE_Bp4_DSp2_5782_S4" )
                      A_fq["SAMPLE_BM7_DSp24_5781_S19"]="WT_DSp24_day-3_tcn_SS_aux-F_tc-T_rep1_batch1";        a_fq+=( "SAMPLE_BM7_DSp24_5781_S19" )
                       A_fq["SAMPLE_Bp7_DSp24_5782_S7"]="WT_DSp24_day-3_tcn_SS_aux-F_tc-T_rep2_batch1";        a_fq+=( "SAMPLE_Bp7_DSp24_5782_S7" )
                     A_fq["SAMPLE_BM10_DSp48_5781_S22"]="WT_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch1";        a_fq+=( "SAMPLE_BM10_DSp48_5781_S22" )  #OK‡ batch
                            A_fq["BM10_5781_DSp48_S26"]="WT_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch2";        a_fq+=( "BM10_5781_DSp48_S26" )         #OK‡ batch
                     A_fq["SAMPLE_Bp10_DSp48_5782_S10"]="WT_DSp48_day-4_tcn_SS_aux-F_tc-T_rep2_batch1";        a_fq+=( "SAMPLE_Bp10_DSp48_5782_S10" )
             
                        A_fq["SAMPLE_Bp3_DSm2_7078_S3"]="rrp6_DSm2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_Bp3_DSm2_7078_S3" )     #FIXME* ∆ rep1 → rep2
                       A_fq["SAMPLE_BM3_DSm2_7079_S15"]="rrp6_DSm2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_BM3_DSm2_7079_S15" )    #FIXME* ∆ rep2 → rep1
                        A_fq["SAMPLE_Bp6_DSp2_7078_S6"]="rrp6_DSp2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_Bp6_DSp2_7078_S6" )     #FIXME* ∆ rep1 → rep2
                       A_fq["SAMPLE_BM6_DSp2_7079_S18"]="rrp6_DSp2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_BM6_DSp2_7079_S18" )    #FIXME* ∆ rep2 → rep1
                       A_fq["SAMPLE_Bp9_DSp24_7078_S9"]="rrp6_DSp24_day-3_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_Bp9_DSp24_7078_S9" )    #FIXME* ∆ rep1 → rep2
                      A_fq["SAMPLE_BM9_DSp24_7079_S21"]="rrp6_DSp24_day-3_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_BM9_DSp24_7079_S21" )   #FIXME* ∆ rep2 → rep1
                     A_fq["SAMPLE_Bp12_DSp48_7078_S12"]="rrp6_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_Bp12_DSp48_7078_S12" )  #FIXME* ∆ rep1 → rep2
                            A_fq["BM12_7079_DSp48_S27"]="rrp6_DSp48_day-4_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "BM12_7079_DSp48_S27" )         #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ batch1 → batch2
             
                          A_fq["CW2_5781_8day_Q_PD_S7"]="WT_Q_day-8_tcn_N_aux-F_tc-F_rep1_batch1";             a_fq+=( "CW2_5781_8day_Q_PD_S7" )
                          A_fq["CW4_5782_8day_Q_PD_S8"]="WT_Q_day-8_tcn_N_aux-F_tc-F_rep2_batch1";             a_fq+=( "CW4_5782_8day_Q_PD_S8" )       #FIXME† Duplicated #1
                          A_fq["CW2_5781_8day_Q_IN_S1"]="WT_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch1";            a_fq+=( "CW2_5781_8day_Q_IN_S1" )
                          A_fq["CW4_5782_8day_Q_IN_S2"]="WT_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch1";            a_fq+=( "CW4_5782_8day_Q_IN_S2" )       #FIXME† Duplicated #2
             
                          A_fq["CW6_7078_8day_Q_PD_S9"]="rrp6_Q_day-8_tcn_N_aux-F_tc-F_rep1_batch1";           a_fq+=( "CW6_7078_8day_Q_PD_S9" )       #FIXME* ∆ rep1 → rep2
                         A_fq["CW8_7079_8day_Q_PD_S10"]="rrp6_Q_day-8_tcn_N_aux-F_tc-F_rep2_batch1";           a_fq+=( "CW8_7079_8day_Q_PD_S10" )      #FIXME* ∆ rep2 → rep1
                          A_fq["CW6_7078_8day_Q_IN_S3"]="rrp6_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch1";          a_fq+=( "CW6_7078_8day_Q_IN_S3" )       #FIXME* ∆ rep1 → rep2  #OK‡ batch
                         A_fq["CW6_7078_day8_Q_SS_S28"]="rrp6_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch2";          a_fq+=( "CW6_7078_day8_Q_SS_S28" )      #FIXME* ∆ rep1 → rep2  #OK‡ batch
                          A_fq["CW8_7079_8day_Q_IN_S4"]="rrp6_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch1";          a_fq+=( "CW8_7079_8day_Q_IN_S4" )       #FIXME* ∆ rep2 → rep1
             
                             A_fq["DA1_5781_SS_G1_S22"]="WT_G1_day-1_tcn_SS_aux-F_tc-F_rep1_batch1";           a_fq+=( "DA1_5781_SS_G1_S22" )          #FIXME‡ ∆ batch1 → batch2
                             A_fq["DA2_5782_SS_G1_S23"]="WT_G1_day-1_tcn_SS_aux-F_tc-F_rep2_batch1";           a_fq+=( "DA2_5782_SS_G1_S23" )          #FIXME‡ ∆ batch1 → batch2
             
                             A_fq["DA3_7078_SS_G1_S24"]="rrp6_G1_day-1_tcn_SS_aux-F_tc-F_rep1_batch1";         a_fq+=( "DA3_7078_SS_G1_S24" )          #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ batch1 → batch2
                             A_fq["DA4_7079_SS_G1_S25"]="rrp6_G1_day-1_tcn_SS_aux-F_tc-F_rep2_batch1";         a_fq+=( "DA4_7079_SS_G1_S25" )          #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ batch1 → batch2

        #  Nab3-AID and control OsTIR-AID data --------------------------------
              A_fq["Sample_CT8_7716_pIAA_Q_Nascent_S4"]="Nab3-AID_Q_day-7_tcn_N_aux-T_tc-F_rep1_batch1";       a_fq+=( "Sample_CT8_7716_pIAA_Q_Nascent_S4" )
             A_fq["Sample_CT10_7718_pIAA_Q_Nascent_S5"]="Nab3-AID_Q_day-7_tcn_N_aux-T_tc-F_rep2_batch1";       a_fq+=( "Sample_CT10_7718_pIAA_Q_Nascent_S5" )
          A_fq["Sample_CT8_7716_pIAA_Q_SteadyState_S9"]="Nab3-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep1_batch1";      a_fq+=( "Sample_CT8_7716_pIAA_Q_SteadyState_S9" )
        A_fq["Sample_CT10_7718_pIAA_Q_SteadyState_S10"]="Nab3-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep2_batch1";      a_fq+=( "Sample_CT10_7718_pIAA_Q_SteadyState_S10" )

              A_fq["Sample_CT2_6125_pIAA_Q_Nascent_S1"]="OsTIR-AID_Q_day-7_tcn_N_aux-T_tc-F_rep1_batch1";      a_fq+=( "Sample_CT2_6125_pIAA_Q_Nascent_S1" )
              A_fq["Sample_CT4_6126_pIAA_Q_Nascent_S2"]="OsTIR-AID_Q_day-7_tcn_N_aux-T_tc-F_rep2_batch1";      a_fq+=( "Sample_CT4_6126_pIAA_Q_Nascent_S2" )
          A_fq["Sample_CT2_6125_pIAA_Q_SteadyState_S6"]="OsTIR-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep1_batch1";     a_fq+=( "Sample_CT2_6125_pIAA_Q_SteadyState_S6" )
          A_fq["Sample_CT4_6126_pIAA_Q_SteadyState_S7"]="OsTIR-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep2_batch1";     a_fq+=( "Sample_CT4_6126_pIAA_Q_SteadyState_S7" )
    }
```
</details>
<br />

<a id="2-corrected-names-rep-batch-correctly-ordered-and-with-notes"></a>
#### 2. Corrected names (rep, batch), correctly ordered, and with notes
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        # unset A_fq; unset a_fq
        # typeset -A A_fq; typeset -a a_fq

        # #  Data to exclude because not used in project ------------------------
        #              A_fq["SAMPLE_BM2_DSm2_7080_S14"]="trf4_DSm2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_BM2_DSm2_7080_S14" )    #EXCLUDE
        #               A_fq["SAMPLE_Bp2_DSm2_7081_S2"]="trf4_DSm2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_Bp2_DSm2_7081_S2" )     #EXCLUDE
        #              A_fq["SAMPLE_BM5_DSp2_7080_S17"]="trf4_DSp2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_BM5_DSp2_7080_S17" )    #EXCLUDE
        #               A_fq["SAMPLE_Bp5_DSp2_7081_S5"]="trf4_DSp2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_Bp5_DSp2_7081_S5" )     #EXCLUDE
        #             A_fq["SAMPLE_BM8_DSp24_7080_S20"]="trf4_DSp24_day-3_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_BM8_DSp24_7080_S20" )   #EXCLUDE
        #              A_fq["SAMPLE_Bp8_DSp24_7081_S8"]="trf4_DSp24_day-3_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_Bp8_DSp24_7081_S8" )    #EXCLUDE
        #            A_fq["SAMPLE_BM11_DSp48_7080_S23"]="trf4_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_BM11_DSp48_7080_S23" )  #EXCLUDE
        #            A_fq["SAMPLE_Bp11_DSp48_7081_S11"]="trf4_DSp48_day-4_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_Bp11_DSp48_7081_S11" )  #EXCLUDE
        #
        #               A_fq["CW12_7748_8day_Q_PD_S12"]="rtr1_Q_day-8_tcn_N_aux-F_tc-F_rep1_batch1";           a_fq+=( "CW12_7748_8day_Q_PD_S12" )  #EXCLUDE  #DONE* ∆ rep2 → rep1
        #               A_fq["CW10_7747_8day_Q_PD_S11"]="rtr1_Q_day-8_tcn_N_aux-F_tc-F_rep2_batch1";           a_fq+=( "CW10_7747_8day_Q_PD_S11" )  #EXCLUDE  #DONE* ∆ rep1 → rep2
        #                A_fq["CW12_7748_8day_Q_IN_S6"]="rtr1_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch1";          a_fq+=( "CW12_7748_8day_Q_IN_S6" )   #EXCLUDE  #DONE* ∆ rep2 → rep1
        #                A_fq["CW10_7747_8day_Q_IN_S5"]="rtr1_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch1";          a_fq+=( "CW10_7747_8day_Q_IN_S5" )   #EXCLUDE  #DONE* ∆ rep1 → rep2
        #
        #        A_fq["Sample_CU11_5782_Q_Nascent_S11"]="WT_Q_day-7_tcn_N_aux-F_tc-F_rep2_batch1";             a_fq+=( "Sample_CU11_5782_Q_Nascent_S11" )      #EXCLUDE #NOCHANGE Duplicated #1
        #    A_fq["Sample_CU12_5782_Q_SteadyState_S12"]="WT_Q_day-7_tcn_SS_aux-F_tc-F_rep2_batch1";            a_fq+=( "Sample_CU12_5782_Q_SteadyState_S12" )  #EXCLUDE #NOCHANGE† Duplicated #2
        #
        #     A_fq["Sample_CT6_7714_pIAA_Q_Nascent_S3"]="Nab3-Nrd1-AID_Q_day-7_tcn_N_aux-T_tc-F_rep3_batch1";  a_fq+=( "Sample_CT6_7714_pIAA_Q_Nascent_S3" )      #EXCLUDE
        # A_fq["Sample_CT6_7714_pIAA_Q_SteadyState_S8"]="Nab3-Nrd1-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep3_batch1"; a_fq+=( "Sample_CT6_7714_pIAA_Q_SteadyState_S8" )  #EXCLUDE

        #  Ovation data -------------------------------------------------------
                                  A_fq["5781_G1_IP_S1"]="WT_G1_day-1_ovn_N_aux-F_tc-F_rep1_batch1";            a_fq+=( "5781_G1_IP_S1" )
                                  A_fq["5782_G1_IP_S3"]="WT_G1_day-1_ovn_N_aux-F_tc-F_rep2_batch1";            a_fq+=( "5782_G1_IP_S3" )
                                  A_fq["5781_G1_IN_S5"]="WT_G1_day-1_ovn_SS_aux-F_tc-F_rep1_batch1";           a_fq+=( "5781_G1_IN_S5" )
                                  A_fq["5782_G1_IN_S7"]="WT_G1_day-1_ovn_SS_aux-F_tc-F_rep2_batch1";           a_fq+=( "5782_G1_IN_S7" )
                                   A_fq["5781_Q_IP_S2"]="WT_Q_day-7_ovn_N_aux-F_tc-F_rep1_batch1";             a_fq+=( "5781_Q_IP_S2" )
                                   A_fq["5782_Q_IP_S4"]="WT_Q_day-7_ovn_N_aux-F_tc-F_rep2_batch1";             a_fq+=( "5782_Q_IP_S4" )
                                   A_fq["5781_Q_IN_S6"]="WT_Q_day-7_ovn_SS_aux-F_tc-F_rep1_batch1";            a_fq+=( "5781_Q_IN_S6" )
                                   A_fq["5782_Q_IN_S8"]="WT_Q_day-7_ovn_SS_aux-F_tc-F_rep2_batch1";            a_fq+=( "5782_Q_IN_S8" )

        #  rrp6∆ and control data ---------------------------------------------
                       A_fq["SAMPLE_BM1_DSm2_5781_S13"]="WT_DSm2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";         a_fq+=( "SAMPLE_BM1_DSm2_5781_S13" )
                        A_fq["SAMPLE_Bp1_DSm2_5782_S1"]="WT_DSm2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";         a_fq+=( "SAMPLE_Bp1_DSm2_5782_S1" )
                       A_fq["SAMPLE_BM4_DSp2_5781_S16"]="WT_DSp2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";         a_fq+=( "SAMPLE_BM4_DSp2_5781_S16" )
                        A_fq["SAMPLE_Bp4_DSp2_5782_S4"]="WT_DSp2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";         a_fq+=( "SAMPLE_Bp4_DSp2_5782_S4" )
                      A_fq["SAMPLE_BM7_DSp24_5781_S19"]="WT_DSp24_day-3_tcn_SS_aux-F_tc-T_rep1_batch1";        a_fq+=( "SAMPLE_BM7_DSp24_5781_S19" )
                       A_fq["SAMPLE_Bp7_DSp24_5782_S7"]="WT_DSp24_day-3_tcn_SS_aux-F_tc-T_rep2_batch1";        a_fq+=( "SAMPLE_Bp7_DSp24_5782_S7" )
                     A_fq["SAMPLE_BM10_DSp48_5781_S22"]="WT_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch1";        a_fq+=( "SAMPLE_BM10_DSp48_5781_S22" )  #OK‡ batch
                            A_fq["BM10_5781_DSp48_S26"]="WT_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch2";        a_fq+=( "BM10_5781_DSp48_S26" )         #OK‡ batch
                     A_fq["SAMPLE_Bp10_DSp48_5782_S10"]="WT_DSp48_day-4_tcn_SS_aux-F_tc-T_rep2_batch1";        a_fq+=( "SAMPLE_Bp10_DSp48_5782_S10" )
             
                       A_fq["SAMPLE_BM3_DSm2_7079_S15"]="rrp6_DSm2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_BM3_DSm2_7079_S15" )    #DONE* ∆ rep2 → rep1
                        A_fq["SAMPLE_Bp3_DSm2_7078_S3"]="rrp6_DSm2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_Bp3_DSm2_7078_S3" )     #DONE* ∆ rep1 → rep2
                       A_fq["SAMPLE_BM6_DSp2_7079_S18"]="rrp6_DSp2_day-2_tcn_SS_aux-F_tc-T_rep1_batch1";       a_fq+=( "SAMPLE_BM6_DSp2_7079_S18" )    #DONE* ∆ rep2 → rep1
                        A_fq["SAMPLE_Bp6_DSp2_7078_S6"]="rrp6_DSp2_day-2_tcn_SS_aux-F_tc-T_rep2_batch1";       a_fq+=( "SAMPLE_Bp6_DSp2_7078_S6" )     #DONE* ∆ rep1 → rep2
                      A_fq["SAMPLE_BM9_DSp24_7079_S21"]="rrp6_DSp24_day-3_tcn_SS_aux-F_tc-T_rep1_batch1";      a_fq+=( "SAMPLE_BM9_DSp24_7079_S21" )   #DONE* ∆ rep2 → rep1
                       A_fq["SAMPLE_Bp9_DSp24_7078_S9"]="rrp6_DSp24_day-3_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_Bp9_DSp24_7078_S9" )    #DONE* ∆ rep1 → rep2
                            A_fq["BM12_7079_DSp48_S27"]="rrp6_DSp48_day-4_tcn_SS_aux-F_tc-T_rep1_batch2";      a_fq+=( "BM12_7079_DSp48_S27" )         #DONE* ∆ rep2 → rep1  #DONE ∆ batch1 → batch2
                     A_fq["SAMPLE_Bp12_DSp48_7078_S12"]="rrp6_DSp48_day-4_tcn_SS_aux-F_tc-T_rep2_batch1";      a_fq+=( "SAMPLE_Bp12_DSp48_7078_S12" )  #DONE* ∆ rep1 → rep2
             
                          A_fq["CW2_5781_8day_Q_PD_S7"]="WT_Q_day-8_tcn_N_aux-F_tc-F_rep1_batch1";             a_fq+=( "CW2_5781_8day_Q_PD_S7" )
                          A_fq["CW4_5782_8day_Q_PD_S8"]="WT_Q_day-8_tcn_N_aux-F_tc-F_rep2_batch1";             a_fq+=( "CW4_5782_8day_Q_PD_S8" )       #NOCHANGE Duplicated #1
                          A_fq["CW2_5781_8day_Q_IN_S1"]="WT_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch1";            a_fq+=( "CW2_5781_8day_Q_IN_S1" )
                          A_fq["CW4_5782_8day_Q_IN_S2"]="WT_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch1";            a_fq+=( "CW4_5782_8day_Q_IN_S2" )       #NOCHANGE Duplicated #2
             
                         A_fq["CW8_7079_8day_Q_PD_S10"]="rrp6_Q_day-8_tcn_N_aux-F_tc-F_rep1_batch1";           a_fq+=( "CW8_7079_8day_Q_PD_S10" )      #DONE* ∆ rep2 → rep1
                          A_fq["CW6_7078_8day_Q_PD_S9"]="rrp6_Q_day-8_tcn_N_aux-F_tc-F_rep2_batch1";           a_fq+=( "CW6_7078_8day_Q_PD_S9" )       #DONE* ∆ rep1 → rep2
                          A_fq["CW8_7079_8day_Q_IN_S4"]="rrp6_Q_day-8_tcn_SS_aux-F_tc-F_rep1_batch1";          a_fq+=( "CW8_7079_8day_Q_IN_S4" )       #DONE* ∆ rep2 → rep1
                          A_fq["CW6_7078_8day_Q_IN_S3"]="rrp6_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch1";          a_fq+=( "CW6_7078_8day_Q_IN_S3" )       #DONE* ∆ rep1 → rep2  #OK‡ batch
                         A_fq["CW6_7078_day8_Q_SS_S28"]="rrp6_Q_day-8_tcn_SS_aux-F_tc-F_rep2_batch2";          a_fq+=( "CW6_7078_day8_Q_SS_S28" )      #DONE* ∆ rep1 → rep2  #OK‡ batch
             
                             A_fq["DA1_5781_SS_G1_S22"]="WT_G1_day-1_tcn_SS_aux-F_tc-F_rep1_batch2";           a_fq+=( "DA1_5781_SS_G1_S22" )          #DONE ∆ batch1 → batch2
                             A_fq["DA2_5782_SS_G1_S23"]="WT_G1_day-1_tcn_SS_aux-F_tc-F_rep2_batch2";           a_fq+=( "DA2_5782_SS_G1_S23" )          #DONE ∆ batch1 → batch2
             
                             A_fq["DA4_7079_SS_G1_S25"]="rrp6_G1_day-1_tcn_SS_aux-F_tc-F_rep1_batch2";         a_fq+=( "DA4_7079_SS_G1_S25" )          #DONE* ∆ rep2 → rep1  #DONE ∆ batch1 → batch2
                             A_fq["DA3_7078_SS_G1_S24"]="rrp6_G1_day-1_tcn_SS_aux-F_tc-F_rep2_batch2";         a_fq+=( "DA3_7078_SS_G1_S24" )          #DONE* ∆ rep1 → rep2  #DONE ∆ batch1 → batch2

        #  Nab3-AID and control OsTIR-AID data --------------------------------
              A_fq["Sample_CT8_7716_pIAA_Q_Nascent_S4"]="Nab3-AID_Q_day-7_tcn_N_aux-T_tc-F_rep1_batch1";       a_fq+=( "Sample_CT8_7716_pIAA_Q_Nascent_S4" )
             A_fq["Sample_CT10_7718_pIAA_Q_Nascent_S5"]="Nab3-AID_Q_day-7_tcn_N_aux-T_tc-F_rep2_batch1";       a_fq+=( "Sample_CT10_7718_pIAA_Q_Nascent_S5" )
          A_fq["Sample_CT8_7716_pIAA_Q_SteadyState_S9"]="Nab3-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep1_batch1";      a_fq+=( "Sample_CT8_7716_pIAA_Q_SteadyState_S9" )
        A_fq["Sample_CT10_7718_pIAA_Q_SteadyState_S10"]="Nab3-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep2_batch1";      a_fq+=( "Sample_CT10_7718_pIAA_Q_SteadyState_S10" )

              A_fq["Sample_CT2_6125_pIAA_Q_Nascent_S1"]="OsTIR-AID_Q_day-7_tcn_N_aux-T_tc-F_rep1_batch1";      a_fq+=( "Sample_CT2_6125_pIAA_Q_Nascent_S1" )
              A_fq["Sample_CT4_6126_pIAA_Q_Nascent_S2"]="OsTIR-AID_Q_day-7_tcn_N_aux-T_tc-F_rep2_batch1";      a_fq+=( "Sample_CT4_6126_pIAA_Q_Nascent_S2" )
          A_fq["Sample_CT2_6125_pIAA_Q_SteadyState_S6"]="OsTIR-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep1_batch1";     a_fq+=( "Sample_CT2_6125_pIAA_Q_SteadyState_S6" )
          A_fq["Sample_CT4_6126_pIAA_Q_SteadyState_S7"]="OsTIR-AID_Q_day-7_tcn_SS_aux-T_tc-F_rep2_batch1";     a_fq+=( "Sample_CT4_6126_pIAA_Q_SteadyState_S7" )
    }
```
</details>
<br />

<a id="3-corrected-names-etc-now-including-strain-information"></a>
#### 3. Corrected names (etc.), now including strain information
Also, *most* hyphenation was converted to camelCase
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

run=TRUE
[[ "${run}" == TRUE ]] &&
    {
        unset A_fq; unset a_fq
        typeset -A A_fq; typeset -a a_fq

        # #  Data to exclude because not used in project ------------------------
        #              A_fq["SAMPLE_BM2_DSm2_7080_S14"]="trf4_DSm2_daw2_tcn_SS_auxF_tcT_rep1_batch1";       a_fq+=( "SAMPLE_BM2_DSm2_7080_S14" )    #EXCLUDE
        #               A_fq["SAMPLE_Bp2_DSm2_7081_S2"]="trf4_DSm2_day2_tcn_SS_auxF_tcT_rep2_batch1";       a_fq+=( "SAMPLE_Bp2_DSm2_7081_S2" )     #EXCLUDE
        #              A_fq["SAMPLE_BM5_DSp2_7080_S17"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep1_batch1";       a_fq+=( "SAMPLE_BM5_DSp2_7080_S17" )    #EXCLUDE
        #               A_fq["SAMPLE_Bp5_DSp2_7081_S5"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep2_batch1";       a_fq+=( "SAMPLE_Bp5_DSp2_7081_S5" )     #EXCLUDE
        #             A_fq["SAMPLE_BM8_DSp24_7080_S20"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep1_batch1";      a_fq+=( "SAMPLE_BM8_DSp24_7080_S20" )   #EXCLUDE
        #              A_fq["SAMPLE_Bp8_DSp24_7081_S8"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep2_batch1";      a_fq+=( "SAMPLE_Bp8_DSp24_7081_S8" )    #EXCLUDE
        #            A_fq["SAMPLE_BM11_DSp48_7080_S23"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep1_batch1";      a_fq+=( "SAMPLE_BM11_DSp48_7080_S23" )  #EXCLUDE
        #            A_fq["SAMPLE_Bp11_DSp48_7081_S11"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep2_batch1";      a_fq+=( "SAMPLE_Bp11_DSp48_7081_S11" )  #EXCLUDE
        #
        #               A_fq["CW12_7748_8day_Q_PD_S12"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep1_batch1";           a_fq+=( "CW12_7748_8day_Q_PD_S12" )  #EXCLUDE  #DONE* ∆ rep2 → rep1
        #               A_fq["CW10_7747_8day_Q_PD_S11"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep2_batch1";           a_fq+=( "CW10_7747_8day_Q_PD_S11" )  #EXCLUDE  #DONE* ∆ rep1 → rep2
        #                A_fq["CW12_7748_8day_Q_IN_S6"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep1_batch1";          a_fq+=( "CW12_7748_8day_Q_IN_S6" )   #EXCLUDE  #DONE* ∆ rep2 → rep1
        #                A_fq["CW10_7747_8day_Q_IN_S5"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep2_batch1";          a_fq+=( "CW10_7747_8day_Q_IN_S5" )   #EXCLUDE  #DONE* ∆ rep1 → rep2
        #
        #        A_fq["Sample_CU11_5782_Q_Nascent_S11"]="WT_Q_day7_tcn_N_auxF_tcF_rep2_batch1";             a_fq+=( "Sample_CU11_5782_Q_Nascent_S11" )      #EXCLUDE #NOCHANGE Duplicated #1
        #    A_fq["Sample_CU12_5782_Q_SteadyState_S12"]="WT_Q_day7_tcn_SS_auxF_tcF_rep2_batch1";            a_fq+=( "Sample_CU12_5782_Q_SteadyState_S12" )  #EXCLUDE #NOCHANGE† Duplicated #2
        #
        #     A_fq["Sample_CT6_7714_pIAA_Q_Nascent_S3"]="Nab3-Nrd1-AID_Q_day7_tcn_N_auxT_tcF_rep3_batch1";  a_fq+=( "Sample_CT6_7714_pIAA_Q_Nascent_S3" )      #EXCLUDE
        # A_fq["Sample_CT6_7714_pIAA_Q_SteadyState_S8"]="Nab3-Nrd1-AID_Q_day7_tcn_SS_auxT_tcF_rep3_batch1"; a_fq+=( "Sample_CT6_7714_pIAA_Q_SteadyState_S8" )  #EXCLUDE

        #  Ovation data -------------------------------------------------------
                                  A_fq["5781_G1_IP_S1"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1";       a_fq+=( "5781_G1_IP_S1" )
                                  A_fq["5782_G1_IP_S3"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1";       a_fq+=( "5782_G1_IP_S3" )
                                  A_fq["5781_G1_IN_S5"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1";      a_fq+=( "5781_G1_IN_S5" )
                                  A_fq["5782_G1_IN_S7"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1";      a_fq+=( "5782_G1_IN_S7" )
                                   A_fq["5781_Q_IP_S2"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1";        a_fq+=( "5781_Q_IP_S2" )
                                   A_fq["5782_Q_IP_S4"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1";        a_fq+=( "5782_Q_IP_S4" )
                                   A_fq["5781_Q_IN_S6"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1";       a_fq+=( "5781_Q_IN_S6" )
                                   A_fq["5782_Q_IN_S8"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1";       a_fq+=( "5782_Q_IN_S8" )

        #  rrp6∆ and control data ---------------------------------------------
                       A_fq["SAMPLE_BM1_DSm2_5781_S13"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_fq+=( "SAMPLE_BM1_DSm2_5781_S13" )
                        A_fq["SAMPLE_Bp1_DSm2_5782_S1"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_fq+=( "SAMPLE_Bp1_DSm2_5782_S1" )
                       A_fq["SAMPLE_BM4_DSp2_5781_S16"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_fq+=( "SAMPLE_BM4_DSp2_5781_S16" )
                        A_fq["SAMPLE_Bp4_DSp2_5782_S4"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_fq+=( "SAMPLE_Bp4_DSp2_5782_S4" )
                      A_fq["SAMPLE_BM7_DSp24_5781_S19"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1";   a_fq+=( "SAMPLE_BM7_DSp24_5781_S19" )
                       A_fq["SAMPLE_Bp7_DSp24_5782_S7"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1";   a_fq+=( "SAMPLE_Bp7_DSp24_5782_S7" )
                     A_fq["SAMPLE_BM10_DSp48_5781_S22"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1";   a_fq+=( "SAMPLE_BM10_DSp48_5781_S22" )  #OK‡ batch
                            A_fq["BM10_5781_DSp48_S26"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2";   a_fq+=( "BM10_5781_DSp48_S26" )         #OK‡ batch
                     A_fq["SAMPLE_Bp10_DSp48_5782_S10"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1";   a_fq+=( "SAMPLE_Bp10_DSp48_5782_S10" )

                       A_fq["SAMPLE_BM3_DSm2_7079_S15"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";  a_fq+=( "SAMPLE_BM3_DSm2_7079_S15" )    #DONE* ∆ rep2 → rep1
                        A_fq["SAMPLE_Bp3_DSm2_7078_S3"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_fq+=( "SAMPLE_Bp3_DSm2_7078_S3" )     #DONE* ∆ rep1 → rep2
                       A_fq["SAMPLE_BM6_DSp2_7079_S18"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";  a_fq+=( "SAMPLE_BM6_DSp2_7079_S18" )    #DONE* ∆ rep2 → rep1
                        A_fq["SAMPLE_Bp6_DSp2_7078_S6"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_fq+=( "SAMPLE_Bp6_DSp2_7078_S6" )     #DONE* ∆ rep1 → rep2
                      A_fq["SAMPLE_BM9_DSp24_7079_S21"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1"; a_fq+=( "SAMPLE_BM9_DSp24_7079_S21" )   #DONE* ∆ rep2 → rep1
                       A_fq["SAMPLE_Bp9_DSp24_7078_S9"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1"; a_fq+=( "SAMPLE_Bp9_DSp24_7078_S9" )    #DONE* ∆ rep1 → rep2
                            A_fq["BM12_7079_DSp48_S27"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2"; a_fq+=( "BM12_7079_DSp48_S27" )         #DONE* ∆ rep2 → rep1  #DONE ∆ batch1 → batch2
                     A_fq["SAMPLE_Bp12_DSp48_7078_S12"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1"; a_fq+=( "SAMPLE_Bp12_DSp48_7078_S12" )  #DONE* ∆ rep1 → rep2

                          A_fq["CW2_5781_8day_Q_PD_S7"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1";        a_fq+=( "CW2_5781_8day_Q_PD_S7" )
                          A_fq["CW4_5782_8day_Q_PD_S8"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1";        a_fq+=( "CW4_5782_8day_Q_PD_S8" )       #NOCHANGE Duplicated #1
                          A_fq["CW2_5781_8day_Q_IN_S1"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1";       a_fq+=( "CW2_5781_8day_Q_IN_S1" )
                          A_fq["CW4_5782_8day_Q_IN_S2"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1";       a_fq+=( "CW4_5782_8day_Q_IN_S2" )       #NOCHANGE Duplicated #2

                         A_fq["CW8_7079_8day_Q_PD_S10"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1";      a_fq+=( "CW8_7079_8day_Q_PD_S10" )      #DONE* ∆ rep2 → rep1
                          A_fq["CW6_7078_8day_Q_PD_S9"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1";      a_fq+=( "CW6_7078_8day_Q_PD_S9" )       #DONE* ∆ rep1 → rep2
                          A_fq["CW8_7079_8day_Q_IN_S4"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1";     a_fq+=( "CW8_7079_8day_Q_IN_S4" )       #DONE* ∆ rep2 → rep1
                          A_fq["CW6_7078_8day_Q_IN_S3"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1";     a_fq+=( "CW6_7078_8day_Q_IN_S3" )       #DONE* ∆ rep1 → rep2  #OK‡ batch
                         A_fq["CW6_7078_day8_Q_SS_S28"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2";     a_fq+=( "CW6_7078_day8_Q_SS_S28" )      #DONE* ∆ rep1 → rep2  #OK‡ batch

                             A_fq["DA1_5781_SS_G1_S22"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2";      a_fq+=( "DA1_5781_SS_G1_S22" )          #DONE ∆ batch1 → batch2
                             A_fq["DA2_5782_SS_G1_S23"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2";      a_fq+=( "DA2_5782_SS_G1_S23" )          #DONE ∆ batch1 → batch2

                             A_fq["DA4_7079_SS_G1_S25"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2";    a_fq+=( "DA4_7079_SS_G1_S25" )          #DONE* ∆ rep2 → rep1  #DONE ∆ batch1 → batch2
                             A_fq["DA3_7078_SS_G1_S24"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2";    a_fq+=( "DA3_7078_SS_G1_S24" )          #DONE* ∆ rep1 → rep2  #DONE ∆ batch1 → batch2

        #  Nab3-AID and control OsTIR-AID data --------------------------------
              A_fq["Sample_CT8_7716_pIAA_Q_Nascent_S4"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1";    a_fq+=( "Sample_CT8_7716_pIAA_Q_Nascent_S4" )
             A_fq["Sample_CT10_7718_pIAA_Q_Nascent_S5"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1";    a_fq+=( "Sample_CT10_7718_pIAA_Q_Nascent_S5" )
          A_fq["Sample_CT8_7716_pIAA_Q_SteadyState_S9"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1";   a_fq+=( "Sample_CT8_7716_pIAA_Q_SteadyState_S9" )
        A_fq["Sample_CT10_7718_pIAA_Q_SteadyState_S10"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1";   a_fq+=( "Sample_CT10_7718_pIAA_Q_SteadyState_S10" )

              A_fq["Sample_CT2_6125_pIAA_Q_Nascent_S1"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1";   a_fq+=( "Sample_CT2_6125_pIAA_Q_Nascent_S1" )
              A_fq["Sample_CT4_6126_pIAA_Q_Nascent_S2"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1";   a_fq+=( "Sample_CT4_6126_pIAA_Q_Nascent_S2" )
          A_fq["Sample_CT2_6125_pIAA_Q_SteadyState_S6"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1";  a_fq+=( "Sample_CT2_6125_pIAA_Q_SteadyState_S6" )
          A_fq["Sample_CT4_6126_pIAA_Q_SteadyState_S7"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1";  a_fq+=( "Sample_CT4_6126_pIAA_Q_SteadyState_S7" )


        #  Examine the dictionary ---------------------------------------------
        print_test=TRUE
        [[ "${print_test}" == TRUE ]] &&
            {
                for i in "${a_fq[@]}"; do
                    echo "  key  ${i}"
                    echo "value  ${A_fq[${i}]}"
                    echo ""
                done
            }
    }
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ [[ "${run}" == TRUE ]] &&
>     {
>         unset A_fq; unset a_fq
>         typeset -A A_fq; typeset -a a_fq
> 
>         # #  Data to exclude because not used in project ------------------------
>         #              A_fq["SAMPLE_BM2_DSm2_7080_S14"]="trf4_DSm2_daw2_tcn_SS_auxF_tcT_rep1_batch1";       a_fq+=( "SAMPLE_BM2_DSm2_7080_S14" )    #EXCLUDE
>         #               A_fq["SAMPLE_Bp2_DSm2_7081_S2"]="trf4_DSm2_day2_tcn_SS_auxF_tcT_rep2_batch1";       a_fq+=( "SAMPLE_Bp2_DSm2_7081_S2" )     #EXCLUDE
>         #              A_fq["SAMPLE_BM5_DSp2_7080_S17"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep1_batch1";       a_fq+=( "SAMPLE_BM5_DSp2_7080_S17" )    #EXCLUDE
>         #               A_fq["SAMPLE_Bp5_DSp2_7081_S5"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep2_batch1";       a_fq+=( "SAMPLE_Bp5_DSp2_7081_S5" )     #EXCLUDE
>         #             A_fq["SAMPLE_BM8_DSp24_7080_S20"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep1_batch1";      a_fq+=( "SAMPLE_BM8_DSp24_7080_S20" )   #EXCLUDE
>         #              A_fq["SAMPLE_Bp8_DSp24_7081_S8"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep2_batch1";      a_fq+=( "SAMPLE_Bp8_DSp24_7081_S8" )    #EXCLUDE
>         #            A_fq["SAMPLE_BM11_DSp48_7080_S23"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep1_batch1";      a_fq+=( "SAMPLE_BM11_DSp48_7080_S23" )  #EXCLUDE
>         #            A_fq["SAMPLE_Bp11_DSp48_7081_S11"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep2_batch1";      a_fq+=( "SAMPLE_Bp11_DSp48_7081_S11" )  #EXCLUDE
>         #
>         #               A_fq["CW12_7748_8day_Q_PD_S12"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep1_batch1";           a_fq+=( "CW12_7748_8day_Q_PD_S12" )  #EXCLUDE  #DONE* ∆ rep2 → rep1
>         #               A_fq["CW10_7747_8day_Q_PD_S11"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep2_batch1";           a_fq+=( "CW10_7747_8day_Q_PD_S11" )  #EXCLUDE  #DONE* ∆ rep1 → rep2
>         #                A_fq["CW12_7748_8day_Q_IN_S6"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep1_batch1";          a_fq+=( "CW12_7748_8day_Q_IN_S6" )   #EXCLUDE  #DONE* ∆ rep2 → rep1
>         #                A_fq["CW10_7747_8day_Q_IN_S5"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep2_batch1";          a_fq+=( "CW10_7747_8day_Q_IN_S5" )   #EXCLUDE  #DONE* ∆ rep1 → rep2
>         #
>         #        A_fq["Sample_CU11_5782_Q_Nascent_S11"]="WT_Q_day7_tcn_N_auxF_tcF_rep2_batch1";             a_fq+=( "Sample_CU11_5782_Q_Nascent_S11" )      #EXCLUDE #NOCHANGE Duplicated #1
>         #    A_fq["Sample_CU12_5782_Q_SteadyState_S12"]="WT_Q_day7_tcn_SS_auxF_tcF_rep2_batch1";            a_fq+=( "Sample_CU12_5782_Q_SteadyState_S12" )  #EXCLUDE #NOCHANGE† Duplicated #2
>         #
>         #     A_fq["Sample_CT6_7714_pIAA_Q_Nascent_S3"]="Nab3-Nrd1-AID_Q_day7_tcn_N_auxT_tcF_rep3_batch1";  a_fq+=( "Sample_CT6_7714_pIAA_Q_Nascent_S3" )      #EXCLUDE
>         # A_fq["Sample_CT6_7714_pIAA_Q_SteadyState_S8"]="Nab3-Nrd1-AID_Q_day7_tcn_SS_auxT_tcF_rep3_batch1"; a_fq+=( "Sample_CT6_7714_pIAA_Q_SteadyState_S8" )  #EXCLUDE
> 
>         #  Ovation data -------------------------------------------------------
>                                   A_fq["5781_G1_IP_S1"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1";       a_fq+=( "5781_G1_IP_S1" )
>                                   A_fq["5782_G1_IP_S3"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1";       a_fq+=( "5782_G1_IP_S3" )
>                                   A_fq["5781_G1_IN_S5"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1";      a_fq+=( "5781_G1_IN_S5" )
>                                   A_fq["5782_G1_IN_S7"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1";      a_fq+=( "5782_G1_IN_S7" )
>                                    A_fq["5781_Q_IP_S2"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1";        a_fq+=( "5781_Q_IP_S2" )
>                                    A_fq["5782_Q_IP_S4"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1";        a_fq+=( "5782_Q_IP_S4" )
>                                    A_fq["5781_Q_IN_S6"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1";       a_fq+=( "5781_Q_IN_S6" )
>                                    A_fq["5782_Q_IN_S8"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1";       a_fq+=( "5782_Q_IN_S8" )
> 
>         #  rrp6∆ and control data ---------------------------------------------
>                        A_fq["SAMPLE_BM1_DSm2_5781_S13"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_fq+=( "SAMPLE_BM1_DSm2_5781_S13" )
>                         A_fq["SAMPLE_Bp1_DSm2_5782_S1"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_fq+=( "SAMPLE_Bp1_DSm2_5782_S1" )
>                        A_fq["SAMPLE_BM4_DSp2_5781_S16"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_fq+=( "SAMPLE_BM4_DSp2_5781_S16" )
>                         A_fq["SAMPLE_Bp4_DSp2_5782_S4"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_fq+=( "SAMPLE_Bp4_DSp2_5782_S4" )
>                       A_fq["SAMPLE_BM7_DSp24_5781_S19"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1";   a_fq+=( "SAMPLE_BM7_DSp24_5781_S19" )
>                        A_fq["SAMPLE_Bp7_DSp24_5782_S7"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1";   a_fq+=( "SAMPLE_Bp7_DSp24_5782_S7" )
>                      A_fq["SAMPLE_BM10_DSp48_5781_S22"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1";   a_fq+=( "SAMPLE_BM10_DSp48_5781_S22" )  #OK‡
 batch
>                             A_fq["BM10_5781_DSp48_S26"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2";   a_fq+=( "BM10_5781_DSp48_S26" )         #OK‡
 batch
>                      A_fq["SAMPLE_Bp10_DSp48_5782_S10"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1";   a_fq+=( "SAMPLE_Bp10_DSp48_5782_S10" )
> 
>                        A_fq["SAMPLE_BM3_DSm2_7079_S15"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";  a_fq+=( "SAMPLE_BM3_DSm2_7079_S15" )    #DONE* ∆ rep2 → rep1
>                         A_fq["SAMPLE_Bp3_DSm2_7078_S3"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_fq+=( "SAMPLE_Bp3_DSm2_7078_S3" )     #DONE* ∆ rep1 → rep2
>                        A_fq["SAMPLE_BM6_DSp2_7079_S18"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";  a_fq+=( "SAMPLE_BM6_DSp2_7079_S18" )    #DONE* ∆ rep2 → rep1
>                         A_fq["SAMPLE_Bp6_DSp2_7078_S6"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_fq+=( "SAMPLE_Bp6_DSp2_7078_S6" )     #DONE* ∆ rep1 → rep2
>                       A_fq["SAMPLE_BM9_DSp24_7079_S21"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1"; a_fq+=( "SAMPLE_BM9_DSp24_7079_S21" )   #DONE* ∆ rep2 → rep1
>                        A_fq["SAMPLE_Bp9_DSp24_7078_S9"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1"; a_fq+=( "SAMPLE_Bp9_DSp24_7078_S9" )    #DONE* ∆ rep1 → rep2
>                             A_fq["BM12_7079_DSp48_S27"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2"; a_fq+=( "BM12_7079_DSp48_S27" )         #DONE* ∆ rep2 → rep1  #DONE ∆ batch1 → batch2
>                      A_fq["SAMPLE_Bp12_DSp48_7078_S12"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1"; a_fq+=( "SAMPLE_Bp12_DSp48_7078_S12" )  #DONE* ∆ rep1 → rep2
> 
>                           A_fq["CW2_5781_8day_Q_PD_S7"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1";        a_fq+=( "CW2_5781_8day_Q_PD_S7" )
>                           A_fq["CW4_5782_8day_Q_PD_S8"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1";        a_fq+=( "CW4_5782_8day_Q_PD_S8" )       #NOCHANGE Duplicated #1
>                           A_fq["CW2_5781_8day_Q_IN_S1"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1";       a_fq+=( "CW2_5781_8day_Q_IN_S1" )
>                           A_fq["CW4_5782_8day_Q_IN_S2"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1";       a_fq+=( "CW4_5782_8day_Q_IN_S2" )       #NOCHANGE Duplicated #2
> 
>                          A_fq["CW8_7079_8day_Q_PD_S10"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1";      a_fq+=( "CW8_7079_8day_Q_PD_S10" )      #DONE* ∆ rep2 → rep1
>                           A_fq["CW6_7078_8day_Q_PD_S9"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1";      a_fq+=( "CW6_7078_8day_Q_PD_S9" )       #DONE* ∆ rep1 → rep2
>                           A_fq["CW8_7079_8day_Q_IN_S4"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1";     a_fq+=( "CW8_7079_8day_Q_IN_S4" )       #DONE* ∆ rep2 → rep1
>                           A_fq["CW6_7078_8day_Q_IN_S3"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1";     a_fq+=( "CW6_7078_8day_Q_IN_S3" )       #DONE* ∆ rep1 → rep2  #OK‡ batch
>                          A_fq["CW6_7078_day8_Q_SS_S28"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2";     a_fq+=( "CW6_7078_day8_Q_SS_S28" )      #DONE* ∆ rep1 → rep2  #OK‡ batch
> 
>                              A_fq["DA1_5781_SS_G1_S22"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2";      a_fq+=( "DA1_5781_SS_G1_S22" )          #DONE ∆ batch1 → batch2
>                              A_fq["DA2_5782_SS_G1_S23"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2";      a_fq+=( "DA2_5782_SS_G1_S23" )          #DONE ∆ batch1 → batch2
> 
>                              A_fq["DA4_7079_SS_G1_S25"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2";    a_fq+=( "DA4_7079_SS_G1_S25" )          #DONE* ∆ rep2 → rep1  #DONE ∆ batch1 → batch2
>                              A_fq["DA3_7078_SS_G1_S24"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2";    a_fq+=( "DA3_7078_SS_G1_S24" )          #DONE* ∆ rep1 → rep2  #DONE ∆ batch1 → batch2
> 
>         #  Nab3-AID and control OsTIR-AID data --------------------------------
>               A_fq["Sample_CT8_7716_pIAA_Q_Nascent_S4"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1";    a_fq+=( "Sample_CT8_7716_pIAA_Q_Nascent_S4" )
>              A_fq["Sample_CT10_7718_pIAA_Q_Nascent_S5"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1";    a_fq+=( "Sample_CT10_7718_pIAA_Q_Nascent_S5" )
>           A_fq["Sample_CT8_7716_pIAA_Q_SteadyState_S9"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1";   a_fq+=( "Sample_CT8_7716_pIAA_Q_SteadyState_S9" )
>         A_fq["Sample_CT10_7718_pIAA_Q_SteadyState_S10"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1";   a_fq+=( "Sample_CT10_7718_pIAA_Q_SteadyState_S10" )
> 
>               A_fq["Sample_CT2_6125_pIAA_Q_Nascent_S1"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1";   a_fq+=( "Sample_CT2_6125_pIAA_Q_Nascent_S1" )
>               A_fq["Sample_CT4_6126_pIAA_Q_Nascent_S2"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1";   a_fq+=( "Sample_CT4_6126_pIAA_Q_Nascent_S2" )
>           A_fq["Sample_CT2_6125_pIAA_Q_SteadyState_S6"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1";  a_fq+=( "Sample_CT2_6125_pIAA_Q_SteadyState_S6" )
>           A_fq["Sample_CT4_6126_pIAA_Q_SteadyState_S7"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1";  a_fq+=( "Sample_CT4_6126_pIAA_Q_SteadyState_S7" )
> 
> 
>         #  Examine the dictionary ---------------------------------------------
>         print_test=TRUE
>         [[ "${print_test}" == TRUE ]] &&
>             {
>                 for i in "${a_fq[@]}"; do
>                     echo "  key  ${i}"
>                     echo "value  ${A_fq[${i}]}"
>                     echo ""
>                 done
>             }
>     }
  key  5781_G1_IP_S1
value  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1

  key  5782_G1_IP_S3
value  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1

  key  5781_G1_IN_S5
value  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1

  key  5782_G1_IN_S7
value  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1

  key  5781_Q_IP_S2
value  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1

  key  5782_Q_IP_S4
value  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1

  key  5781_Q_IN_S6
value  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1

  key  5782_Q_IN_S8
value  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1

  key  SAMPLE_BM1_DSm2_5781_S13
value  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1

  key  SAMPLE_Bp1_DSm2_5782_S1
value  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1

  key  SAMPLE_BM4_DSp2_5781_S16
value  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1

  key  SAMPLE_Bp4_DSp2_5782_S4
value  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1

  key  SAMPLE_BM7_DSp24_5781_S19
value  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1

  key  SAMPLE_Bp7_DSp24_5782_S7
value  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1

  key  SAMPLE_BM10_DSp48_5781_S22
value  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1

  key  BM10_5781_DSp48_S26
value  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2

  key  SAMPLE_Bp10_DSp48_5782_S10
value  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1

  key  SAMPLE_BM3_DSm2_7079_S15
value  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1

  key  SAMPLE_Bp3_DSm2_7078_S3
value  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1

  key  SAMPLE_BM6_DSp2_7079_S18
value  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1

  key  SAMPLE_Bp6_DSp2_7078_S6
value  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1

  key  SAMPLE_BM9_DSp24_7079_S21
value  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1

  key  SAMPLE_Bp9_DSp24_7078_S9
value  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1

  key  BM12_7079_DSp48_S27
value  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2

  key  SAMPLE_Bp12_DSp48_7078_S12
value  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1

  key  CW2_5781_8day_Q_PD_S7
value  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1

  key  CW4_5782_8day_Q_PD_S8
value  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1

  key  CW2_5781_8day_Q_IN_S1
value  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1

  key  CW4_5782_8day_Q_IN_S2
value  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1

  key  CW8_7079_8day_Q_PD_S10
value  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1

  key  CW6_7078_8day_Q_PD_S9
value  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1

  key  CW8_7079_8day_Q_IN_S4
value  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1

  key  CW6_7078_8day_Q_IN_S3
value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1

  key  CW6_7078_day8_Q_SS_S28
value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2

  key  DA1_5781_SS_G1_S22
value  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2

  key  DA2_5782_SS_G1_S23
value  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2

  key  DA4_7079_SS_G1_S25
value  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2

  key  DA3_7078_SS_G1_S24
value  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2

  key  Sample_CT8_7716_pIAA_Q_Nascent_S4
value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1

  key  Sample_CT10_7718_pIAA_Q_Nascent_S5
value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1

  key  Sample_CT8_7716_pIAA_Q_SteadyState_S9
value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1

  key  Sample_CT10_7718_pIAA_Q_SteadyState_S10
value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1

  key  Sample_CT2_6125_pIAA_Q_Nascent_S1
value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1

  key  Sample_CT4_6126_pIAA_Q_Nascent_S2
value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1

  key  Sample_CT2_6125_pIAA_Q_SteadyState_S6
value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1

  key  Sample_CT4_6126_pIAA_Q_SteadyState_S7
value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1
```
</details>
<br />

<a id="4-run-print-tests-prior-to-copying-fastqs"></a>
#### 4. Run print tests prior to copying `fastq`s
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

for i in "${a_fq[@]}"; do echo "${i}_R1_001.fastq.gz"; done
for i in "${a_fq[@]}"; do ls -lhaFG "${i}_R1_001.fastq.gz"; done
for i in "${a_fq[@]}"; do ls -lhaFG "${i}_R2_001.fastq.gz"; done
for i in "${a_fq[@]}"; do ls -lhaFG "${i}_R3_001.fastq.gz"; done

for i in "${a_fq[@]}"; do
    echo """
    cp \\
        ${i}_R1_001.fastq.gz \\
        ${d_proj}/${d_exp_0215}/GEO/fastqs/${A_fq[${i}]}_R1.fq.gz
    """
done

for i in "${a_fq[@]}"; do
    for j in 1 2 3; do
        echo """
        cp \\
            ${i}_R${j}_001.fastq.gz \\
            ${d_proj}/${d_exp_0215}/GEO/fastqs/${A_fq[${i}]}_R${j}.fq.gz
        """
    done
done

#  Load GNU parallel
module purge
ml parallel/20210322-GCCcore-10.2.0

#  Do a print test with GNU parallel
unset read_numbers
typeset -a read_numbers=( 1 2 3 )
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'cp "{3}_R{1}_001.fastq.gz" "{2}/{4}_R{1}.fq.gz"' \
::: "${read_numbers[@]}" \
::: "${d_proj}/${d_exp_0215}/GEO/fastqs" \
::: "${!A_fq[@]}" \
:::+ "${A_fq[@]}"
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ for i in "${a_fq[@]}"; do echo "${i}_R1_001.fastq.gz"; done
5781_G1_IP_S1_R1_001.fastq.gz
5782_G1_IP_S3_R1_001.fastq.gz
5781_G1_IN_S5_R1_001.fastq.gz
5782_G1_IN_S7_R1_001.fastq.gz
5781_Q_IP_S2_R1_001.fastq.gz
5782_Q_IP_S4_R1_001.fastq.gz
5781_Q_IN_S6_R1_001.fastq.gz
5782_Q_IN_S8_R1_001.fastq.gz
SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
BM10_5781_DSp48_S26_R1_001.fastq.gz
SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
BM12_7079_DSp48_S27_R1_001.fastq.gz
SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz
DA1_5781_SS_G1_S22_R1_001.fastq.gz
DA2_5782_SS_G1_S23_R1_001.fastq.gz
DA4_7079_SS_G1_S25_R1_001.fastq.gz
DA3_7078_SS_G1_S24_R1_001.fastq.gz
Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz


❯ for i in "${a_fq[@]}"; do ls -lhaFG "${i}_R1_001.fastq.gz"; done
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5781_G1_IP_S1_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5782_G1_IP_S3_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5781_G1_IN_S5_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5782_G1_IN_S7_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5781_Q_IP_S2_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5782_Q_IP_S4_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5781_Q_IN_S6_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5782_Q_IN_S8_R1_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 92 Mar 13 09:55 BM10_5781_DSp48_S26_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 92 Mar 13 09:55 BM12_7079_DSp48_S27_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:41 CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 95 Mar 13 09:55 CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA1_5781_SS_G1_S22_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA2_5782_SS_G1_S23_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA4_7079_SS_G1_S25_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA3_7078_SS_G1_S24_R1_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 130 Feb  5 10:40 Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 135 Feb  5 10:40 Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz


❯ for i in "${a_fq[@]}"; do ls -lhaFG "${i}_R2_001.fastq.gz"; done
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5781_G1_IP_S1_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5782_G1_IP_S3_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5781_G1_IN_S5_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5782_G1_IN_S7_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5781_Q_IP_S2_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5782_Q_IP_S4_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5781_Q_IN_S6_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5782_Q_IN_S8_R2_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 92 Mar 13 09:55 BM10_5781_DSp48_S26_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 92 Mar 13 09:55 BM12_7079_DSp48_S27_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:41 CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 95 Mar 13 09:55 CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA1_5781_SS_G1_S22_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA2_5782_SS_G1_S23_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA4_7079_SS_G1_S25_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA3_7078_SS_G1_S24_R2_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 130 Feb  5 10:40 Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 135 Feb  5 10:40 Sample_CT10_7718_pIAA_Q_SteadyState_S10_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT2_6125_pIAA_Q_Nascent_S1_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_Nascent_S1_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq.gz


❯ for i in "${a_fq[@]}"; do ls -lhaFG "${i}_R3_001.fastq.gz"; done
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5781_G1_IP_S1_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5782_G1_IP_S3_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5781_G1_IN_S5_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 94 Feb  5 10:40 5782_G1_IN_S7_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5781_Q_IP_S2_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5782_Q_IP_S4_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5781_Q_IN_S6_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 93 Feb  5 10:40 5782_Q_IN_S8_R3_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 92 Mar 13 09:55 BM10_5781_DSp48_S26_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 119 Feb  5 10:40 SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 121 Feb  5 10:40 SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 120 Feb  5 10:40 SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 92 Mar 13 09:55 BM12_7079_DSp48_S27_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 122 Feb  5 10:40 SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:40 CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 111 Feb  5 10:41 CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 110 Feb  5 10:41 CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 95 Mar 13 09:55 CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA1_5781_SS_G1_S22_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA2_5782_SS_G1_S23_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA4_7079_SS_G1_S25_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 91 Mar 13 09:55 DA3_7078_SS_G1_S24_R3_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 130 Feb  5 10:40 Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 135 Feb  5 10:40 Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 129 Feb  5 10:40 Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt 133 Feb  5 10:40 Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz


❯ for i in "${a_fq[@]}"; do
>     echo """
>     cp \\
>         ${i}_R1_001.fastq.gz \\
>         ${d_proj}/${d_exp_0215}/GEO/fastqs/${A_fq[${i}]}_R1.fq.gz
>     """
> done
    cp \
        5781_G1_IP_S1_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz

    cp \
        5782_G1_IP_S3_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz

    cp \
        5781_G1_IN_S5_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz

    cp \
        5782_G1_IN_S7_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz

    cp \
        5781_Q_IP_S2_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz

    cp \
        5782_Q_IP_S4_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz

    cp \
        5781_Q_IN_S6_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz

    cp \
        5782_Q_IN_S8_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

    cp \
        SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

    cp \
        SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

    cp \
        SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

    cp \
        BM10_5781_DSp48_S26_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz

    cp \
        SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz

    cp \
        SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz

    cp \
        SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

    cp \
        SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz

    cp \
        SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

    cp \
        BM12_7079_DSp48_S27_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz

    cp \
        SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

    cp \
        CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz

    cp \
        CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz

    cp \
        CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz

    cp \
        CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz

    cp \
        CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz

    cp \
        CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz

    cp \
        CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz

    cp \
        CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz

    cp \
        CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz

    cp \
        DA1_5781_SS_G1_S22_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz

    cp \
        DA2_5782_SS_G1_S23_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz

    cp \
        DA4_7079_SS_G1_S25_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz

    cp \
        DA3_7078_SS_G1_S24_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz

    cp \
        Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz

    cp \
        Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz

    cp \
        Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz

    cp \
        Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz

    cp \
        Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz

    cp \
        Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz

    cp \
        Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz

    cp \
        Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz \
        /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz


❯ for i in "${a_fq[@]}"; do
>     for j in 1 2 3; do
>         echo """
>         cp \\
>             ${i}_R${j}_001.fastq.gz \\
>             ${d_proj}/${d_exp_0215}/GEO/fastqs/${A_fq[${i}]}_R${j}.fq.gz
>         """
>     done
> done
        cp \
            5781_G1_IP_S1_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz

        cp \
            5781_G1_IP_S1_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz

        cp \
            5781_G1_IP_S1_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz

        cp \
            5782_G1_IP_S3_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz

        cp \
            5782_G1_IP_S3_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz

        cp \
            5782_G1_IP_S3_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz

        cp \
            5781_G1_IN_S5_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz

        cp \
            5781_G1_IN_S5_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz

        cp \
            5781_G1_IN_S5_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz

        cp \
            5782_G1_IN_S7_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz

        cp \
            5782_G1_IN_S7_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz

        cp \
            5782_G1_IN_S7_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz

        cp \
            5781_Q_IP_S2_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz

        cp \
            5781_Q_IP_S2_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz

        cp \
            5781_Q_IP_S2_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz

        cp \
            5782_Q_IP_S4_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz

        cp \
            5782_Q_IP_S4_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz

        cp \
            5782_Q_IP_S4_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz

        cp \
            5781_Q_IN_S6_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz

        cp \
            5781_Q_IN_S6_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz

        cp \
            5781_Q_IN_S6_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz

        cp \
            5782_Q_IN_S8_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz

        cp \
            5782_Q_IN_S8_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz

        cp \
            5782_Q_IN_S8_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz

        cp \
            SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz

        cp \
            SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz

        cp \
            SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz

        cp \
            BM10_5781_DSp48_S26_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz

        cp \
            BM10_5781_DSp48_S26_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz

        cp \
            BM10_5781_DSp48_S26_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz

        cp \
            SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz

        cp \
            SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz

        cp \
            SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz

        cp \
            SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz

        cp \
            SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz

        cp \
            SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz

        cp \
            SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz

        cp \
            BM12_7079_DSp48_S27_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz

        cp \
            BM12_7079_DSp48_S27_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz

        cp \
            BM12_7079_DSp48_S27_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz

        cp \
            SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz

        cp \
            SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz

        cp \
            SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz

        cp \
            CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz

        cp \
            CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz

        cp \
            CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz

        cp \
            CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz

        cp \
            CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz

        cp \
            CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz

        cp \
            CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz

        cp \
            CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz

        cp \
            CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz

        cp \
            CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz

        cp \
            CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz

        cp \
            CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz

        cp \
            CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz

        cp \
            CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz

        cp \
            CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz

        cp \
            CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz

        cp \
            CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz

        cp \
            CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz

        cp \
            CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz

        cp \
            CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz

        cp \
            CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz

        cp \
            CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz

        cp \
            CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz

        cp \
            CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz

        cp \
            CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz

        cp \
            CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz

        cp \
            CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz

        cp \
            DA1_5781_SS_G1_S22_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz

        cp \
            DA1_5781_SS_G1_S22_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz

        cp \
            DA1_5781_SS_G1_S22_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz

        cp \
            DA2_5782_SS_G1_S23_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz

        cp \
            DA2_5782_SS_G1_S23_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz

        cp \
            DA2_5782_SS_G1_S23_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz

        cp \
            DA4_7079_SS_G1_S25_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz

        cp \
            DA4_7079_SS_G1_S25_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz

        cp \
            DA4_7079_SS_G1_S25_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz

        cp \
            DA3_7078_SS_G1_S24_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz

        cp \
            DA3_7078_SS_G1_S24_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz

        cp \
            DA3_7078_SS_G1_S24_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz

        cp \
            Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz

        cp \
            Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz

        cp \
            Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz

        cp \
            Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz

        cp \
            Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz

        cp \
            Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz

        cp \
            Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz

        cp \
            Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz

        cp \
            Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz

        cp \
            Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz

        cp \
            Sample_CT10_7718_pIAA_Q_SteadyState_S10_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz

        cp \
            Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz

        cp \
            Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz

        cp \
            Sample_CT2_6125_pIAA_Q_Nascent_S1_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz

        cp \
            Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz

        cp \
            Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz

        cp \
            Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz

        cp \
            Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz

        cp \
            Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz

        cp \
            Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz

        cp \
            Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz

        cp \
            Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz

        cp \
            Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz

        cp \
            Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz \
            /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz


❯ #  Load GNU parallel


❯ module purge


❯ ml parallel/20210322-GCCcore-10.2.0


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'cp "{3}_R{1}_001.fastq.gz" "{2}/{4}_R{1}.fq.gz"' \
> ::: "${read_numbers[@]}" \
> ::: "${d_proj}/${d_exp_0215}/GEO/fastqs" \
> ::: "${!A_fq[@]}" \
> :::+ "${A_fq[@]}"
cp "Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz"
cp "SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz"
cp "SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz"
cp "5781_Q_IP_S2_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz"
cp "SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz"
cp "Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz"
cp "5781_Q_IN_S6_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz"
cp "CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz"
cp "SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz"
cp "CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz"
cp "SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz"
cp "Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz"
cp "Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz"
cp "CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz"
cp "CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz"
cp "CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz"
cp "SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz"
cp "BM10_5781_DSp48_S26_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz"
cp "Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz"
cp "5781_G1_IN_S5_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz"
cp "SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz"
cp "Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz"
cp "CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz"
cp "5782_Q_IN_S8_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz"
cp "DA3_7078_SS_G1_S24_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz"
cp "BM12_7079_DSp48_S27_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz"
cp "DA1_5781_SS_G1_S22_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz"
cp "SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz"
cp "Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz"
cp "SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz"
cp "SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz"
cp "SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz"
cp "DA4_7079_SS_G1_S25_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz"
cp "5782_G1_IN_S7_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz"
cp "SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz"
cp "SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz"
cp "Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz"
cp "DA2_5782_SS_G1_S23_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz"
cp "CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz"
cp "CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz"
cp "5781_G1_IP_S1_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz"
cp "SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz"
cp "5782_Q_IP_S4_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz"
cp "5782_G1_IP_S3_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz"
cp "SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz"
cp "CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz"
cp "Sample_CT10_7718_pIAA_Q_SteadyState_S10_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz"
cp "SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz"
cp "SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz"
cp "5781_Q_IP_S2_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz"
cp "SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz"
cp "Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz"
cp "5781_Q_IN_S6_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz"
cp "CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz"
cp "SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz"
cp "CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz"
cp "SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz"
cp "Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz"
cp "Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz"
cp "CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz"
cp "CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz"
cp "CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz"
cp "SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz"
cp "BM10_5781_DSp48_S26_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz"
cp "Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz"
cp "5781_G1_IN_S5_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz"
cp "SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz"
cp "Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz"
cp "CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz"
cp "5782_Q_IN_S8_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz"
cp "DA3_7078_SS_G1_S24_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz"
cp "BM12_7079_DSp48_S27_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz"
cp "DA1_5781_SS_G1_S22_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz"
cp "SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz"
cp "Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz"
cp "SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz"
cp "SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz"
cp "SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz"
cp "DA4_7079_SS_G1_S25_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz"
cp "5782_G1_IN_S7_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz"
cp "SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz"
cp "SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz"
cp "Sample_CT2_6125_pIAA_Q_Nascent_S1_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz"
cp "DA2_5782_SS_G1_S23_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz"
cp "CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz"
cp "CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz"
cp "5781_G1_IP_S1_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz"
cp "SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz"
cp "5782_Q_IP_S4_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz"
cp "5782_G1_IP_S3_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz"
cp "SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz"
cp "CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz"
cp "Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz"
cp "SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz"
cp "SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz"
cp "5781_Q_IP_S2_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz"
cp "SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz"
cp "Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz"
cp "5781_Q_IN_S6_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz"
cp "CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz"
cp "SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz"
cp "CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz"
cp "SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz"
cp "Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz"
cp "Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz"
cp "CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz"
cp "CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz"
cp "CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz"
cp "SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz"
cp "BM10_5781_DSp48_S26_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz"
cp "Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz"
cp "5781_G1_IN_S5_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz"
cp "SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz"
cp "Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz"
cp "CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz"
cp "5782_Q_IN_S8_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz"
cp "DA3_7078_SS_G1_S24_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz"
cp "BM12_7079_DSp48_S27_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz"
cp "DA1_5781_SS_G1_S22_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz"
cp "SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz"
cp "Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz"
cp "SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz"
cp "SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz"
cp "SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz"
cp "DA4_7079_SS_G1_S25_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz"
cp "5782_G1_IN_S7_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz"
cp "SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz"
cp "SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz"
cp "Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz"
cp "DA2_5782_SS_G1_S23_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz"
cp "CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz"
cp "CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz"
cp "5781_G1_IP_S1_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz"
cp "SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz"
cp "5782_Q_IP_S4_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz"
cp "5782_G1_IP_S3_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz"
cp "SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz"
cp "CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz"
```
</details>
<br />

<a id="5-copy-the-fastqs-to-geo-renaming-them-in-the-process"></a>
#### 5. Copy the `fastq`s to `GEO/`, renaming them in the process
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

echo "${SLURM_CPUS_ON_NODE}"

unset read_numbers
typeset -a read_numbers=( 1 2 3 )

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'cp "{3}_R{1}_001.fastq.gz" "{2}/{4}_R{1}.fq.gz"' \
::: "${read_numbers[@]}" \
::: "${d_proj}/${d_exp_0215}/GEO/fastqs" \
::: "${!A_fq[@]}" \
:::+ "${A_fq[@]}"
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ echo "${SLURM_CPUS_ON_NODE}"
4


❯ unset read_numbers


❯ typeset -a read_numbers=( 1 2 3 )


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'cp "{3}_R{1}_001.fastq.gz" "{2}/{4}_R{1}.fq.gz"' \
> ::: "${read_numbers[@]}" \
> ::: "${d_proj}/${d_exp_0215}/GEO/fastqs" \
> ::: "${!A_fq[@]}" \
> :::+ "${A_fq[@]}"
```
</details>
<br />

<a id="6-generate-md5-checksums-for-the-fastqs"></a>
#### 6. Generate `MD5` checksums for the `fastq`s
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${d_proj}/${d_exp_0215}/GEO/fastqs" \
    || echo "cd'ing failed; check on this..."

[[ ! -d md5/ ]] && mkdir md5/

ls -lhaFG

#  Do a print test with GNU parallel
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'md5sum "{1}_R{2}.fq.gz" > "md5/{1}_R{2}.md5.txt"' \
::: "${A_fq[@]}" \
::: "${read_numbers[@]}"

#  Write out the md5 checksums
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'md5sum "{1}_R{2}.fq.gz" > "md5/{1}_R{2}.md5.txt"' \
::: "${A_fq[@]}" \
::: "${read_numbers[@]}"

cat md5/*.txt
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${d_proj}/${d_exp_0215}/GEO/fastqs" \
>     || echo "cd'ing failed; check on this..."


❯ [[ ! -d md5/ ]] && mkdir md5/
mkdir: created directory 'md5/'


❯ ls -lhaFG
total 113G
drwxrws--- 3 kalavatt  9.8K Jul 18 08:50 ./
drwxrws--- 7 kalavatt   115 Jul 18 07:59 ../
drwxrws--- 2 kalavatt     0 Jul 18 08:50 md5/
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:44 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  503M Jul 18 08:46 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.4G Jul 18 08:47 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:43 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  514M Jul 18 08:45 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.4G Jul 18 08:46 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:44 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  508M Jul 18 08:45 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:47 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:43 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  576M Jul 18 08:45 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:46 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:45 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  503M Jul 18 08:46 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:48 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:44 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  483M Jul 18 08:45 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:47 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:44 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  476M Jul 18 08:45 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:47 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:44 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  483M Jul 18 08:46 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:47 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  540M Jul 18 08:45 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  215M Jul 18 08:46 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  543M Jul 18 08:48 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  685M Jul 18 08:43 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  271M Jul 18 08:45 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  688M Jul 18 08:46 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  533M Jul 18 08:44 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  213M Jul 18 08:46 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  538M Jul 18 08:47 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  651M Jul 18 08:44 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  262M Jul 18 08:45 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  656M Jul 18 08:47 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  641M Jul 18 08:45 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  255M Jul 18 08:46 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  647M Jul 18 08:48 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  682M Jul 18 08:43 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  274M Jul 18 08:45 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  685M Jul 18 08:46 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  736M Jul 18 08:44 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  301M Jul 18 08:45 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  745M Jul 18 08:47 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt 1008M Jul 18 08:44 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  404M Jul 18 08:46 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt 1001M Jul 18 08:47 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz
-rw-rw---- 1 kalavatt 1015M Jul 18 08:44 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  414M Jul 18 08:46 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt 1014M Jul 18 08:47 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:45 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  402M Jul 18 08:46 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:48 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:44 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  470M Jul 18 08:45 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:47 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:43 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  466M Jul 18 08:45 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.3G Jul 18 08:46 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.5G Jul 18 08:44 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  615M Jul 18 08:45 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.5G Jul 18 08:47 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:44 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  508M Jul 18 08:46 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:47 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:44 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  494M Jul 18 08:45 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:47 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  634M Jul 18 08:45 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  251M Jul 18 08:46 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  639M Jul 18 08:48 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  516M Jul 18 08:43 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  205M Jul 18 08:45 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  519M Jul 18 08:46 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  632M Jul 18 08:44 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  256M Jul 18 08:46 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  636M Jul 18 08:47 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  644M Jul 18 08:44 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  258M Jul 18 08:46 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  651M Jul 18 08:47 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  584M Jul 18 08:43 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  233M Jul 18 08:45 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  587M Jul 18 08:46 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  639M Jul 18 08:45 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  256M Jul 18 08:46 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  642M Jul 18 08:48 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-r----- 1 kalavatt  653M Jul 18 08:44 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  268M Jul 18 08:46 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  659M Jul 18 08:47 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:44 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  425M Jul 18 08:45 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:47 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz
-rw-r----- 1 kalavatt  602M Jul 18 08:43 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r----- 1 kalavatt  249M Jul 18 08:45 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r----- 1 kalavatt  609M Jul 18 08:46 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  642M Jul 18 08:45 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  233M Jul 18 08:46 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  673M Jul 18 08:48 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  637M Jul 18 08:45 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  230M Jul 18 08:46 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  665M Jul 18 08:48 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  490M Jul 18 08:44 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  181M Jul 18 08:45 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  512M Jul 18 08:47 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  474M Jul 18 08:45 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  177M Jul 18 08:46 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  497M Jul 18 08:48 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  994M Jul 18 08:44 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  399M Jul 18 08:46 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt  988M Jul 18 08:47 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz
-rw-rw---- 1 kalavatt  908M Jul 18 08:45 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz
-rw-rw---- 1 kalavatt  361M Jul 18 08:46 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz
-rw-rw---- 1 kalavatt  911M Jul 18 08:48 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz
-rw-rw---- 1 kalavatt  774M Jul 18 08:43 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  276M Jul 18 08:45 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  810M Jul 18 08:46 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  696M Jul 18 08:45 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  251M Jul 18 08:46 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  726M Jul 18 08:48 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  497M Jul 18 08:43 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  182M Jul 18 08:45 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  518M Jul 18 08:46 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  375M Jul 18 08:44 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  140M Jul 18 08:46 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  394M Jul 18 08:47 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:45 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  456M Jul 18 08:46 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:48 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:45 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  466M Jul 18 08:46 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:48 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:43 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  475M Jul 18 08:45 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.2G Jul 18 08:46 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:45 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw---- 1 kalavatt  456M Jul 18 08:46 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw---- 1 kalavatt  1.1G Jul 18 08:48 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'md5sum "{1}_R{2}.fq.gz" > "md5/{1}_R{2}.md5.txt"' \
> ::: "${A_fq[@]}" \
> ::: "${read_numbers[@]}"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.md5.txt"


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'md5sum "{1}_R{2}.fq.gz" > "md5/{1}_R{2}.md5.txt"' \
> ::: "${A_fq[@]}" \
> ::: "${read_numbers[@]}"


#MD5
❯ cat md5/*.txt
7f0a38dfab28573dfde4a22bdec8ed23  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz
16b4e12514a46dd5ae52b12c319ebc71  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz
ac0514b003191ffa03e58757d7cce08f  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz
f68377fc5bd003f92e1d7df5a0e6f0c8  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz
489e8d761f71df48baaed553d478688a  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz
44cf3a4663aa1682a66403517d79109b  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz
b9e52b6d1bbeac9bba571b032189cbce  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz
6cab323c7204c36044bda8d1ce5deea5  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz
c005906ef62ff2ce76fd0b98164799b3  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz
1d18bdc8f84e760214aa7cb14c7c42b1  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz
e736988b28c78a73bbb1921a90461f7c  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz
c4fff15191d7441700a2d89ec11cd29f  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz
25e2344456219a2b3d3c9806747cb890  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz
a548a8fa1de84c0861093eaea20bfb2e  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz
1f459a12f9f2abe93b6083bcbcf10f9f  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz
10bee63679fbdf3a87bc2df8f2c92140  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz
acfc0b4d9969ca801315c088916dcb77  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz
928b0eb959b66baffcffba36961c5c74  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz
498e78a3cdde7deab06e779199371eab  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz
2a1c94b660d3b3455a141c47356c24e8  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz
5d5ab770fe7c71d70dc74d4eb52a0a47  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz
d61e3dd67c6842b3710905a2844549d9  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz
139e8b19b967980642f5a2913b315a5b  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz
83b6f48f7e4559fa35838e76a2320786  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz
607b96f9ecf8df6708f99686722a8538  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
da74d5e708da2276b5c65f324d80a22c  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
c12e396575e8161d03b38b4d59cf029d  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
44e705090abc84f0f9c02cecab49ce03  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
5fd70e5d9e07735cc5799228840ca90f  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
e9365ca8fdc45357d685d20a493c8c29  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
e4a24a4f1825498775fdc5346645a00e  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
d7e554f16d1ef167e98832ab5dd48c76  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
c9805e3f558f45467762b6c6d278a6c8  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
1a0f12d060d30146af6855ac46ef197d  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
cf3f66e7ff8fb8c5471828531a2700f4  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
4e61062f91688ae965a519b481e8936a  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
5d42c029fb6fbc757ccbc3baa30146d0  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
a55c6d53039b166819bf0f5e5c7ae83b  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
46b089b914be070facbdf93c58265216  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
a9635f39231fa4368e35c9a2b542f7ae  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
b52bcd049e4a6991d3e21113e6c7b507  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
7a38ac0ea24c7ffb29b7183d1342fceb  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
7fb58f2e24faa8b318a7cc9e8fc5cce7  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
57e8eb7b8d23f4e1dd3b064222e51383  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
f901c678fd26faac0378c6125147e219  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
836d793aac11e4634432c800f4828cb3  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz
3c8d7e7277b9bbf6626c21c163d0ceab  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz
c77a91f5bb87c1971aa9bcdbfe93b044  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz
3efd5512313294c11a4e10862f1d7869  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
7c171264db9bb95d3ebd6948d948ec2b  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
48e167b106d2e8f5e97bb5af233a45bc  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
89f337123e24665002b9cbf7d35ecd45  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz
fb96ddc67f87a244d5e7637709ecff8b  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz
f12b96220ed6dc5fa792c740b7a77356  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz
7e821d571063f0857c62c7169e6efb18  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz
76975f919f82ab29ead33088421e4fd2  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz
b5c8323f66cd4ac8b2f948b8dc0434c9  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz
5c1dd0f5a07fbcdc66bdd6ee67e916d7  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz
8da2981c17b55dd7a395345375e14fa3  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz
3020f0bbd199128f26cec0c9b0bb0b05  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz
b2b0d1bc192562cb749aeef0a04835bc  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz
e70c7797656ab1bcb2db1ddbd6c96caa  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz
0a051a3cbd644faf164627a4a6ee4ce4  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz
0269dc5569b9a439a2935a7a3ed9e642  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
70ef7b07d70799724f76e6f646e47470  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
f636d07a0e5126f1e728d55c756e5979  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
a5f665cca8f8b89cd8b21389c89cc973  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz
7a3ef83b7b59d845d4a9434400e088f1  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz
3440a1cb26f78f0332501b8c7c90b307  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz
9a67ac26694ce007b1928180a2b40bec  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
852b8f09ea89a9f260dddf0329b91a63  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
de0ae68bdb6dc6977f4129f394fc4724  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
4e6813bacf26579f448eeae229905853  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
f9b446e06c62182602529173557c0a3b  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
9ce9909ca7f56e6e829eb29c795c55e3  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
e1c7489c220ab372e1e92a7fd71272e1  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
725bff34e5e1818cdb2402cb93dfab9e  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
e2e8eb4ae98e2a6af886f33fa9b024bf  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
1081db39420d401ddb395770375326fb  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
f6690e5a137ee8adc9048d9b67e9f570  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
fd9daecaba939fe5a4d14a4e14d6a0b5  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
fcf94f249a1942eccb23da636f605d3f  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
9d4c47765d2c69ea027a8694c55e8027  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
b24c59c362eac1ecfd3e2ee4a22b23fa  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
55c15a2817e25bc21af39e9833e18e35  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
512cc8f12b5256e1afb8dace4c8bedc4  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
be632ca8ebe80528239c4e501b58b7cb  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
14c3c02cfd2158990a158313422fe66c  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
89886ac2c1c5230b7a9e808a33a8d167  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
9dc424f27a6bee706302bdb57403be92  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
c28825ced6eef91ea2eb48ea994bb46b  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz
779d9f3d3e990d4823733bbf5a4c38cc  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz
8c3b3fd286cdf7c6f41d0e328b8c8794  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz
8229f6769fd219028d8b2cb6aa9ac713  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
41f8a64e405e25d14fa205c92d9c1c5b  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
f4a4f887e4c569be5f88fcd8988129c2  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
f6caffeea039b8d1375ed32b17b0c5b6  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
69eaab7b47180e709a5ecb387f345750  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
586d356b54548b283e878bcf1046d8ba  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
96d1f22b178a26f6dbb0e9741088ab9a  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
7605e13d90cbd20176b11a81f6cb521b  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
403dfc189f9cbbec6b9575fd7a892e33  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
39f232b9859810c265bb6d96dc118ea4  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
3929bbabb5978f240eb7f3e9009f6ac8  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
72d063e3ba548d7c710005239b829f85  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
ca83b550187f2e320625483e15699db1  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
8b9ff2a9dd66cbd3d089f2793eb77fdc  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
6d790158ae5bbc1dce54b8d47716659b  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
2f14790365f5e4c83cdceeafe047bfae  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz
3ec18e2f788245aaf51ef8d76c073d67  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz
ed7505d0f285f30018aeae7c4629cad0  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz
75867ff06469088c63248d46455eb055  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz
76c6a4a7e6a78aeab1d70da1c2dcd839  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz
f141d83d9c74148e9082602c441ec827  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz
145172cf97549d233826ebcd67bd81ce  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
6ed7663634f3a91334317074f2001989  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
ff5ad61f9657a4bceb9ac18fdc89ff71  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
498d5b0b6f521fe529dc28cbad45d150  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
103c478dfb5535f96baacfa3338eda1c  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
2cbfacc7f1a753253b37094a5e1660ab  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
31c284e4f8803372e020cd71d95ed3a1  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
d0f5843cf133aa02b37715b80253a074  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
55d7200fad85347bf9309a8bee442a1e  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
a6da92cba9058e1671b35d7d90ecc1ae  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
3354254d16a629fe00cfbce6f910829f  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
9e41ca94797f5808fc490f089a92bed4  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
4c4d13653e622548a5782e45f2416b90  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
2cec446699e2ccedd04d0d9dbc03991d  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
8b022e45295e0325fe063dbf7b3f7fe7  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
1ff93c9e8779c5222809239035551d6f  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
959e177b9879228cb5c32059d0e4968d  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
d9de09110fee9f3ea0e52e32962f1f81  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
4b693caffbb87e284d87bc9b5cf01e4b  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
ec73e1d0363163dde7bf50fbf079aef4  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
4cef2e8e6909941ad3ceeed840d49f4a  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
3fbcaee97a45cc37658c85dee37af6a9  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
baee4da0eda5716c300f12fa9f0c0d8c  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
4ae8d445cdc63fdde39d6fbb60c668d2  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
```
</details>
<br />
<br />

<a id="prepare-and-copy-over-bams-standard-analyses"></a>
## Prepare and copy over `bam`s: standard analyses
<a id="get-to-pertinent-source-directory-examine-bams"></a>
### Get to pertinent source directory, examine `bam`s
<a id="code"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."
cd "bams/aligned_UT_primary_dedup-UMI" || echo "cd'ing failed; check on this..."

ls -lhaFG *.bam
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."


❯ cd "bams/aligned_UT_primary_dedup-UMI" || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary_dedup-UMI


❯ ls -lhaFG *.bam
-rw-rw---- 1 kalavatt  822M Feb 13 13:55 5781_G1_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 14:03 5781_G1_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  703M Feb 13 13:54 5781_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Feb 13 14:08 5781_Q_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  784M Feb 13 13:53 5782_G1_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 14:03 5782_G1_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  625M Feb 13 13:52 5782_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Feb 13 14:10 5782_Q_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Mar 14 10:41 BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  921M Feb 13 14:08 BM10_DSp48_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  902M Feb 13 14:09 BM11_DSp48_7080_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Mar 14 10:37 BM12_DSp48_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  960M Feb 13 14:02 BM1_DSm2_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1010M Feb 13 14:04 BM2_DSm2_7080_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.1G Feb 13 14:04 BM3_DSm2_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  876M Feb 13 14:00 BM4_DSp2_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.1G Feb 13 14:10 BM5_DSp2_7080_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1013M Feb 13 14:05 BM6_DSp2_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  919M Feb 13 14:21 BM7_DSp24_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1006M Feb 13 14:23 BM8_DSp24_7080_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  940M Feb 13 14:23 BM9_DSp24_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  849M Feb 13 14:24 Bp10_DSp48_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  951M Feb 13 14:37 Bp11_DSp48_7081_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1017M Feb 13 14:47 Bp12_DSp48_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  788M Feb 13 14:25 Bp1_DSm2_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  946M Feb 13 14:39 Bp2_DSm2_7081_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  819M Feb 13 14:27 Bp3_DSm2_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  970M Feb 13 14:41 Bp4_DSp2_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.1G Feb 13 14:49 Bp5_DSp2_7081_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  961M Feb 13 14:34 Bp6_DSp2_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  941M Feb 13 14:36 Bp7_DSp24_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  993M Feb 13 14:40 Bp8_DSp24_7081_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  777M Feb 13 14:33 Bp9_DSp24_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.7G Feb 13 15:04 CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Feb 13 16:22 CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Feb 13 15:24 CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 16:00 CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Feb 13 15:12 CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 15:55 CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.9G Feb 13 15:38 CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.2G Feb 13 15:55 CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.7G Feb 13 15:28 CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Feb 13 16:30 CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.7G Feb 13 15:29 CU11_5782_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 16:13 CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Feb 13 16:36 CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.6G Feb 13 15:31 CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 16:37 CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.7G Feb 13 15:45 CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Feb 13 16:34 CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.6G Feb 13 16:09 CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Feb 13 17:06 CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.6G Feb 13 16:28 CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.8G Feb 13 17:40 CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.7G Feb 13 16:27 CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Mar 14 11:02 CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Feb 13 17:18 CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.7G Feb 13 16:37 CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Mar 14 10:37 DA1_5781_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.3G Mar 14 10:26 DA2_5782_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.4G Mar 14 10:19 DA3_7078_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt  1.5G Mar 14 10:19 DA4_7079_SS_G1_UT.primary.dedup-UMI.bam
```
</details>
<br />

<a id="copy-over-bams-renaming-them-in-the-process-generate-md5-checksums-too"></a>
### Copy over `bam`s, renaming them in the process; generate `MD5` checksums too
~This code makes use of the arrays initialized in [this code chunk](#3-corrected-names-etc-now-including-strain-information)~

<a id="code-1"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

#  Load GNU parallel for print tests
module purge
ml parallel/20210322-GCCcore-10.2.0

#  Run print tests with GNU parallel
for i in "${!A_fq[@]}"; do echo "${i}"; done
., Sample_CT10_7718_pIAA_Q_SteadyState_S10*.bam
., CW2_5781_8day_Q_PD_S7*.bam
., BM9_DSp24_7079_UT*.bam

#NOTE
#  Actually, some of the files in this directory were given different, clearer
#+ names, so I can't use "${!A_fq[@]}", etc.

#  Create new arrays
unset A_bam; unset a_bam
typeset -A A_bam; typeset -a a_bam
# #  Data to exclude because not used in project
#               A_bam["BM2_DSm2_7080"]="trf4_DSm2_daw2_tcn_SS_auxF_tcT_rep1_batch1";        a_bam+=( "BM2_DSm2_7080" )
#               A_bam["Bp2_DSm2_7081"]="trf4_DSm2_day2_tcn_SS_auxF_tcT_rep2_batch1";        a_bam+=( "Bp2_DSm2_7081" )
#               A_bam["BM5_DSp2_7080"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep1_batch1";        a_bam+=( "BM5_DSp2_7080" )
#               A_bam["Bp5_DSp2_7081"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep2_batch1";        a_bam+=( "Bp5_DSp2_7081" )
#              A_bam["BM8_DSp24_7080"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep1_batch1";       a_bam+=( "BM8_DSp24_7080" )
#              A_bam["Bp8_DSp24_7081"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep2_batch1";       a_bam+=( "Bp8_DSp24_7081" )
#             A_bam["BM11_DSp48_7080"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep1_batch1";       a_bam+=( "BM11_DSp48_7080" )
#             A_bam["Bp11_DSp48_7081"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep2_batch1";       a_bam+=( "Bp11_DSp48_7081" )
#
#         A_bam["CW12_7748_8day_Q_PD"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep1_batch1";            a_bam+=( "CW12_7748_8day_Q_PD" )
#         A_bam["CW10_7747_8day_Q_PD"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep2_batch1";            a_bam+=( "CW10_7747_8day_Q_PD" )
#         A_bam["CW12_7748_8day_Q_IN"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep1_batch1";           a_bam+=( "CW12_7748_8day_Q_IN" )
#         A_bam["CW10_7747_8day_Q_IN"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep2_batch1";           a_bam+=( "CW10_7747_8day_Q_IN" )
#
#         A_bam["CU11_5782_Q_Nascent"]="WT_Q_day7_tcn_N_auxF_tcF_rep2_batch1";              a_bam+=( "CU11_5782_Q_Nascent" )
#     A_bam["CU12_5782_Q_SteadyState"]="WT_Q_day7_tcn_SS_auxF_tcF_rep2_batch1";             a_bam+=( "CU12_5782_Q_SteadyState" )
#
#     A_bam["CT6_7714_pIAA_Q_Nascent"]="Nab3-Nrd1-AID_Q_day7_tcn_N_auxT_tcF_rep3_batch1";   a_bam+=( "CT6_7714_pIAA_Q_Nascent" )
# A_bam["CT6_7714_pIAA_Q_SteadyState"]="Nab3-Nrd1-AID_Q_day7_tcn_SS_auxT_tcF_rep3_batch1";  a_bam+=( "CT6_7714_pIAA_Q_SteadyState" )

#  Ovation data (8)
                   A_bam["5781_G1_IP"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1";        a_bam+=( "5781_G1_IP" )
                   A_bam["5782_G1_IP"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1";        a_bam+=( "5782_G1_IP" )
                   A_bam["5781_G1_IN"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1";       a_bam+=( "5781_G1_IN" )
                   A_bam["5782_G1_IN"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1";       a_bam+=( "5782_G1_IN" )
                    A_bam["5781_Q_IP"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1";         a_bam+=( "5781_Q_IP" )
                    A_bam["5782_Q_IP"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1";         a_bam+=( "5782_Q_IP" )
                    A_bam["5781_Q_IN"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1";        a_bam+=( "5781_Q_IN" )
                    A_bam["5782_Q_IN"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1";        a_bam+=( "5782_Q_IN" )

#  rrp6∆ and control data (9 + 8 + 4 + 5 + 4 = 30)
                A_bam["BM1_DSm2_5781"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";     a_bam+=( "BM1_DSm2_5781" )
                A_bam["Bp1_DSm2_5782"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";     a_bam+=( "Bp1_DSm2_5782" )
                A_bam["BM4_DSp2_5781"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";     a_bam+=( "BM4_DSp2_5781" )
                A_bam["Bp4_DSp2_5782"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";     a_bam+=( "Bp4_DSp2_5782" )
               A_bam["BM7_DSp24_5781"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_bam+=( "BM7_DSp24_5781" )
               A_bam["Bp7_DSp24_5782"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_bam+=( "Bp7_DSp24_5782" )
              A_bam["BM10_DSp48_5781"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_bam+=( "BM10_DSp48_5781" )
          A_bam["BM10_DSp48_5781_new"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2";    a_bam+=( "BM10_DSp48_5781_new" )
              A_bam["Bp10_DSp48_5782"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_bam+=( "Bp10_DSp48_5782" )
             
                A_bam["BM3_DSm2_7079"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";   a_bam+=( "BM3_DSm2_7079" )
                A_bam["Bp3_DSm2_7078"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";   a_bam+=( "Bp3_DSm2_7078" )
                A_bam["BM6_DSp2_7079"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";   a_bam+=( "BM6_DSp2_7079" )
                A_bam["Bp6_DSp2_7078"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";   a_bam+=( "Bp6_DSp2_7078" )
               A_bam["BM9_DSp24_7079"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1";  a_bam+=( "BM9_DSp24_7079" )
               A_bam["Bp9_DSp24_7078"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_bam+=( "Bp9_DSp24_7078" )
              A_bam["BM12_DSp48_7079"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2";  a_bam+=( "BM12_DSp48_7079" )
              A_bam["Bp12_DSp48_7078"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_bam+=( "Bp12_DSp48_7078" )
             
           A_bam["CW2_5781_8day_Q_PD"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1";         a_bam+=( "CW2_5781_8day_Q_PD" )
           A_bam["CW4_5782_8day_Q_PD"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1";         a_bam+=( "CW4_5782_8day_Q_PD" )
           A_bam["CW2_5781_8day_Q_IN"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1";        a_bam+=( "CW2_5781_8day_Q_IN" )
           A_bam["CW4_5782_8day_Q_IN"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1";        a_bam+=( "CW4_5782_8day_Q_IN" )
               
           A_bam["CW8_7079_8day_Q_PD"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1";       a_bam+=( "CW8_7079_8day_Q_PD" )
           A_bam["CW6_7078_8day_Q_PD"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1";       a_bam+=( "CW6_7078_8day_Q_PD" )
           A_bam["CW8_7079_8day_Q_IN"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1";      a_bam+=( "CW8_7079_8day_Q_IN" )
           A_bam["CW6_7078_8day_Q_IN"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1";      a_bam+=( "CW6_7078_8day_Q_IN" )
           A_bam["CW6_7078_day8_Q_SS"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2";      a_bam+=( "CW6_7078_day8_Q_SS" )

               A_bam["DA1_5781_SS_G1"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2";       a_bam+=( "DA1_5781_SS_G1" )
               A_bam["DA2_5782_SS_G1"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2";       a_bam+=( "DA2_5782_SS_G1" )
               A_bam["DA3_7078_SS_G1"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2";     a_bam+=( "DA3_7078_SS_G1" )
               A_bam["DA4_7079_SS_G1"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2";     a_bam+=( "DA4_7079_SS_G1" )

#  Nab3-AID and control OsTIR-AID data (8)
      A_bam["CT8_7716_pIAA_Q_Nascent"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1";   a_bam+=( "CT8_7716_pIAA_Q_Nascent" )
     A_bam["CT10_7718_pIAA_Q_Nascent"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1";   a_bam+=( "CT10_7718_pIAA_Q_Nascent" )
  A_bam["CT8_7716_pIAA_Q_SteadyState"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1";  a_bam+=( "CT8_7716_pIAA_Q_SteadyState" )
 A_bam["CT10_7718_pIAA_Q_SteadyState"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1";  a_bam+=( "CT10_7718_pIAA_Q_SteadyState" )

      A_bam["CT2_6125_pIAA_Q_Nascent"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1";  a_bam+=( "CT2_6125_pIAA_Q_Nascent" )
      A_bam["CT4_6126_pIAA_Q_Nascent"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1";  a_bam+=( "CT4_6126_pIAA_Q_Nascent" )
  A_bam["CT2_6125_pIAA_Q_SteadyState"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1"; a_bam+=( "CT2_6125_pIAA_Q_SteadyState" )
  A_bam["CT4_6126_pIAA_Q_SteadyState"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1"; a_bam+=( "CT4_6126_pIAA_Q_SteadyState" )

#  Check the files exist
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'ls -lhaFG "{2}_UT.primary.dedup-UMI.bam"' \
::: "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
::: "${!A_bam[@]}" \
:::+ "${A_bam[@]}"

#  Run print tests for the copy commands
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'cp "{2}_UT.primary.dedup-UMI.bam" "{1}/{3}.UTPD.bam"' \
::: "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
::: "${!A_bam[@]}" \
:::+ "${A_bam[@]}"

#  Run the copy commands
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'cp "{2}_UT.primary.dedup-UMI.bam" "{1}/{3}.UTPD.bam"' \
::: "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
::: "${!A_bam[@]}" \
:::+ "${A_bam[@]}"

#  Generate MD5 checksums
cd "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
    || echo "cd'ing failed; check on this..."

[[ ! -d md5/ ]] && mkdir md5/

ls -lhaFG

#  Do a print test with GNU parallel
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'md5sum "{1}.UTPD.bam" > "md5/{1}.UTPD.md5.txt"' \
::: "${A_bam[@]}"

#  Write out the md5 checksums
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'md5sum "{1}.UTPD.bam" > "md5/{1}.UTPD.md5.txt"' \
::: "${A_bam[@]}"

cat md5/*.txt
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ module purge


❯ ml parallel/20210322-GCCcore-10.2.0


❯ for i in "${!A_fq[@]}"; do echo "${i}"; done
Sample_CT10_7718_pIAA_Q_SteadyState_S10
SAMPLE_BM4_DSp2_5781_S16
SAMPLE_Bp10_DSp48_5782_S10
5781_Q_IP_S2
SAMPLE_BM3_DSm2_7079_S15
Sample_CT10_7718_pIAA_Q_Nascent_S5
5781_Q_IN_S6
CW2_5781_8day_Q_IN_S1
SAMPLE_BM6_DSp2_7079_S18
CW8_7079_8day_Q_PD_S10
SAMPLE_Bp1_DSm2_5782_S1
Sample_CT2_6125_pIAA_Q_SteadyState_S6
Sample_CT4_6126_pIAA_Q_Nascent_S2
CW6_7078_8day_Q_PD_S9
CW6_7078_8day_Q_IN_S3
CW8_7079_8day_Q_IN_S4
SAMPLE_BM9_DSp24_7079_S21
BM10_5781_DSp48_S26
Sample_CT8_7716_pIAA_Q_SteadyState_S9
5781_G1_IN_S5
SAMPLE_Bp12_DSp48_7078_S12
Sample_CT4_6126_pIAA_Q_SteadyState_S7
CW6_7078_day8_Q_SS_S28
5782_Q_IN_S8
DA3_7078_SS_G1_S24
BM12_7079_DSp48_S27
DA1_5781_SS_G1_S22
SAMPLE_Bp7_DSp24_5782_S7
Sample_CT8_7716_pIAA_Q_Nascent_S4
SAMPLE_Bp9_DSp24_7078_S9
SAMPLE_BM10_DSp48_5781_S22
SAMPLE_BM7_DSp24_5781_S19
DA4_7079_SS_G1_S25
5782_G1_IN_S7
SAMPLE_Bp3_DSm2_7078_S3
SAMPLE_Bp4_DSp2_5782_S4
Sample_CT2_6125_pIAA_Q_Nascent_S1
DA2_5782_SS_G1_S23
CW4_5782_8day_Q_IN_S2
CW4_5782_8day_Q_PD_S8
5781_G1_IP_S1
SAMPLE_BM1_DSm2_5781_S13
5782_Q_IP_S4
5782_G1_IP_S3
SAMPLE_Bp6_DSp2_7078_S6
CW2_5781_8day_Q_PD_S7


❯ ., Sample_CT10_7718_pIAA_Q_SteadyState_S10*.bam
ls: cannot access 'Sample_CT10_7718_pIAA_Q_SteadyState_S10*.bam': No such file or directory


❯ ., CW2_5781_8day_Q_PD_S7*.bam
ls: cannot access 'CW2_5781_8day_Q_PD_S7*.bam': No such file or directory


❯ ., BM9_DSp24_7079_UT*.bam
-rw-rw---- 1 kalavatt 940M Feb 13 14:23 BM9_DSp24_7079_UT.primary.dedup-UMI.bam


❯ #  Create new arrays

❯ unset A_bam; unset a_bam


❯ typeset -A A_bam; typeset -a a_bam


❯ unset A_bam; unset a_bam
❯ typeset -A A_bam; typeset -a a_bam
❯ # #  Data to exclude because not used in project --------------------------------
❯ #               A_bam["BM2_DSm2_7080"]="trf4_DSm2_daw2_tcn_SS_auxF_tcT_rep1_batch1";        a_bam+=( "BM2_DSm2_7080" )
❯ #               A_bam["Bp2_DSm2_7081"]="trf4_DSm2_day2_tcn_SS_auxF_tcT_rep2_batch1";        a_bam+=( "Bp2_DSm2_7081" )
❯ #               A_bam["BM5_DSp2_7080"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep1_batch1";        a_bam+=( "BM5_DSp2_7080" )
❯ #               A_bam["Bp5_DSp2_7081"]="trf4_DSp2_day2_tcn_SS_auxF_tcT_rep2_batch1";        a_bam+=( "Bp5_DSp2_7081" )
❯ #              A_bam["BM8_DSp24_7080"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep1_batch1";       a_bam+=( "BM8_DSp24_7080" )
❯ #              A_bam["Bp8_DSp24_7081"]="trf4_DSp24_day3_tcn_SS_auxF_tcT_rep2_batch1";       a_bam+=( "Bp8_DSp24_7081" )
❯ #             A_bam["BM11_DSp48_7080"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep1_batch1";       a_bam+=( "BM11_DSp48_7080" )
❯ #             A_bam["Bp11_DSp48_7081"]="trf4_DSp48_day4_tcn_SS_auxF_tcT_rep2_batch1";       a_bam+=( "Bp11_DSp48_7081" )
❯ #
❯ #         A_bam["CW12_7748_8day_Q_PD"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep1_batch1";            a_bam+=( "CW12_7748_8day_Q_PD" )
❯ #         A_bam["CW10_7747_8day_Q_PD"]="rtr1_Q_day8_tcn_N_auxF_tcF_rep2_batch1";            a_bam+=( "CW10_7747_8day_Q_PD" )
❯ #         A_bam["CW12_7748_8day_Q_IN"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep1_batch1";           a_bam+=( "CW12_7748_8day_Q_IN" )
❯ #         A_bam["CW10_7747_8day_Q_IN"]="rtr1_Q_day8_tcn_SS_auxF_tcF_rep2_batch1";           a_bam+=( "CW10_7747_8day_Q_IN" )
❯ #
❯ #         A_bam["CU11_5782_Q_Nascent"]="WT_Q_day7_tcn_N_auxF_tcF_rep2_batch1";              a_bam+=( "CU11_5782_Q_Nascent" )
❯ #     A_bam["CU12_5782_Q_SteadyState"]="WT_Q_day7_tcn_SS_auxF_tcF_rep2_batch1";             a_bam+=( "CU12_5782_Q_SteadyState" )
❯ #
❯ #     A_bam["CT6_7714_pIAA_Q_Nascent"]="Nab3-Nrd1-AID_Q_day7_tcn_N_auxT_tcF_rep3_batch1";   a_bam+=( "CT6_7714_pIAA_Q_Nascent" )
❯ # A_bam["CT6_7714_pIAA_Q_SteadyState"]="Nab3-Nrd1-AID_Q_day7_tcn_SS_auxT_tcF_rep3_batch1";  a_bam+=( "CT6_7714_pIAA_Q_SteadyState" )
❯
❯ #  Ovation data (8) -----------------------------------------------------------
❯                    A_bam["5781_G1_IP"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1";        a_bam+=( "5781_G1_IP" )
❯                    A_bam["5782_G1_IP"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1";        a_bam+=( "5782_G1_IP" )
❯                    A_bam["5781_G1_IN"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1";       a_bam+=( "5781_G1_IN" )
❯                    A_bam["5782_G1_IN"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1";       a_bam+=( "5782_G1_IN" )
❯                     A_bam["5781_Q_IP"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1";         a_bam+=( "5781_Q_IP" )
❯                     A_bam["5782_Q_IP"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1";         a_bam+=( "5782_Q_IP" )
❯                     A_bam["5781_Q_IN"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1";        a_bam+=( "5781_Q_IN" )
❯                     A_bam["5782_Q_IN"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1";        a_bam+=( "5782_Q_IN" )
❯
❯ #  rrp6∆ and control data (9 + 8 + 4 + 5 + 4 = 30) ----------------------------
❯                 A_bam["BM1_DSm2_5781"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";     a_bam+=( "BM1_DSm2_5781" )
❯                 A_bam["Bp1_DSm2_5782"]="WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";     a_bam+=( "Bp1_DSm2_5782" )
❯                 A_bam["BM4_DSp2_5781"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1";     a_bam+=( "BM4_DSp2_5781" )
❯                 A_bam["Bp4_DSp2_5782"]="WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1";     a_bam+=( "Bp4_DSp2_5782" )
❯                A_bam["BM7_DSp24_5781"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_bam+=( "BM7_DSp24_5781" )
❯                A_bam["Bp7_DSp24_5782"]="WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_bam+=( "Bp7_DSp24_5782" )
❯               A_bam["BM10_DSp48_5781"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1";    a_bam+=( "BM10_DSp48_5781" )
❯           A_bam["BM10_DSp48_5781_new"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2";    a_bam+=( "BM10_DSp48_5781_new" )
❯               A_bam["Bp10_DSp48_5782"]="WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1";    a_bam+=( "Bp10_DSp48_5782" )
❯
❯                 A_bam["BM3_DSm2_7079"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";   a_bam+=( "BM3_DSm2_7079" )
❯                 A_bam["Bp3_DSm2_7078"]="rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";   a_bam+=( "Bp3_DSm2_7078" )
❯                 A_bam["BM6_DSp2_7079"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1";   a_bam+=( "BM6_DSp2_7079" )
❯                 A_bam["Bp6_DSp2_7078"]="rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1";   a_bam+=( "Bp6_DSp2_7078" )
❯                A_bam["BM9_DSp24_7079"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1";  a_bam+=( "BM9_DSp24_7079" )
❯                A_bam["Bp9_DSp24_7078"]="rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_bam+=( "Bp9_DSp24_7078" )
❯               A_bam["BM12_DSp48_7079"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2";  a_bam+=( "BM12_DSp48_7079" )
❯               A_bam["Bp12_DSp48_7078"]="rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1";  a_bam+=( "Bp12_DSp48_7078" )
❯
❯            A_bam["CW2_5781_8day_Q_PD"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1";         a_bam+=( "CW2_5781_8day_Q_PD" )
❯            A_bam["CW4_5782_8day_Q_PD"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1";         a_bam+=( "CW4_5782_8day_Q_PD" )
❯            A_bam["CW2_5781_8day_Q_IN"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1";        a_bam+=( "CW2_5781_8day_Q_IN" )
❯            A_bam["CW4_5782_8day_Q_IN"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1";        a_bam+=( "CW4_5782_8day_Q_IN" )
❯
❯            A_bam["CW8_7079_8day_Q_PD"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1";       a_bam+=( "CW8_7079_8day_Q_PD" )
❯            A_bam["CW6_7078_8day_Q_PD"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1";       a_bam+=( "CW6_7078_8day_Q_PD" )
❯            A_bam["CW8_7079_8day_Q_IN"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1";      a_bam+=( "CW8_7079_8day_Q_IN" )
❯            A_bam["CW6_7078_8day_Q_IN"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1";      a_bam+=( "CW6_7078_8day_Q_IN" )
❯            A_bam["CW6_7078_day8_Q_SS"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2";      a_bam+=( "CW6_7078_day8_Q_SS" )
❯
❯                A_bam["DA1_5781_SS_G1"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2";       a_bam+=( "DA1_5781_SS_G1" )
❯                A_bam["DA2_5782_SS_G1"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2";       a_bam+=( "DA2_5782_SS_G1" )
❯                A_bam["DA3_7078_SS_G1"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2";     a_bam+=( "DA3_7078_SS_G1" )
❯                A_bam["DA4_7079_SS_G1"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2";     a_bam+=( "DA4_7079_SS_G1" )
❯
❯ #  Nab3-AID and control OsTIR-AID data (8) ------------------------------------
❯       A_bam["CT8_7716_pIAA_Q_Nascent"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1";   a_bam+=( "CT8_7716_pIAA_Q_Nascent" )
❯      A_bam["CT10_7718_pIAA_Q_Nascent"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1";   a_bam+=( "CT10_7718_pIAA_Q_Nascent" )
❯   A_bam["CT8_7716_pIAA_Q_SteadyState"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1";  a_bam+=( "CT8_7716_pIAA_Q_SteadyState" )
❯  A_bam["CT10_7718_pIAA_Q_SteadyState"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1";  a_bam+=( "CT10_7718_pIAA_Q_SteadyState" )
❯
❯       A_bam["CT2_6125_pIAA_Q_Nascent"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1";  a_bam+=( "CT2_6125_pIAA_Q_Nascent" )
❯       A_bam["CT4_6126_pIAA_Q_Nascent"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1";  a_bam+=( "CT4_6126_pIAA_Q_Nascent" )
❯   A_bam["CT2_6125_pIAA_Q_SteadyState"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1"; a_bam+=( "CT2_6125_pIAA_Q_SteadyState" )
❯   A_bam["CT4_6126_pIAA_Q_SteadyState"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1"; a_bam+=( "CT4_6126_pIAA_Q_SteadyState" )


❯ #  Check the files exist


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'ls -lhaFG "{2}_UT.primary.dedup-UMI.bam"' \
> ::: "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
> ::: "${!A_bam[@]}" \
> :::+ "${A_bam[@]}"
-rw-rw---- 1 kalavatt 625M Feb 13 13:52 5782_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.6G Feb 13 16:28 CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Mar 14 11:02 CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.3G Mar 14 10:26 DA2_5782_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.6G Feb 13 16:09 CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 849M Feb 13 14:24 Bp10_DSp48_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Mar 14 10:41 BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 876M Feb 13 14:00 BM4_DSp2_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Feb 13 17:18 CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.7G Feb 13 15:28 CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 940M Feb 13 14:23 BM9_DSp24_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1017M Feb 13 14:47 Bp12_DSp48_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.4G Feb 13 14:10 5782_Q_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.4G Feb 13 17:06 CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 970M Feb 13 14:41 Bp4_DSp2_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 822M Feb 13 13:55 5781_G1_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Mar 14 10:19 DA4_7079_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 961M Feb 13 14:34 Bp6_DSp2_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.3G Feb 13 14:03 5781_G1_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 919M Feb 13 14:21 BM7_DSp24_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.4G Mar 14 10:19 DA3_7078_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.7G Feb 13 16:27 CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.7G Feb 13 16:37 CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 784M Feb 13 13:53 5782_G1_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 777M Feb 13 14:33 Bp9_DSp24_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Feb 13 15:24 CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 921M Feb 13 14:08 BM10_DSp48_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 941M Feb 13 14:36 Bp7_DSp24_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 788M Feb 13 14:25 Bp1_DSm2_5782_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.4G Feb 13 16:30 CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.3G Feb 13 14:03 5782_G1_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.3G Feb 13 16:00 CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.4G Mar 14 10:37 DA1_5781_SS_G1_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.8G Feb 13 17:40 CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.7G Feb 13 15:04 CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Feb 13 16:22 CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.1G Feb 13 14:04 BM3_DSm2_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Feb 13 14:08 5781_Q_IP_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.4G Mar 14 10:37 BM12_DSp48_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.3G Feb 13 15:55 CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.3G Feb 13 16:34 CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 819M Feb 13 14:27 Bp3_DSm2_7078_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 703M Feb 13 13:54 5781_Q_IN_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 960M Feb 13 14:02 BM1_DSm2_5781_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1013M Feb 13 14:05 BM6_DSp2_7079_UT.primary.dedup-UMI.bam
-rw-rw---- 1 kalavatt 1.5G Feb 13 15:12 CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam


❯ #  Run print tests for the copy commands


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'cp "{2}_UT.primary.dedup-UMI.bam" "{1}/{3}.UTPD.bam"' \
> ::: "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
> ::: "${!A_bam[@]}" \
> :::+ "${A_bam[@]}"
cp "5782_Q_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam"
cp "CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam"
cp "CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam"
cp "DA2_5782_SS_G1_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam"
cp "CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam"
cp "Bp10_DSp48_5782_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam"
cp "BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam"
cp "BM4_DSp2_5781_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam"
cp "CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam"
cp "CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam"
cp "BM9_DSp24_7079_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam"
cp "Bp12_DSp48_7078_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam"
cp "5782_Q_IP_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam"
cp "CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam"
cp "Bp4_DSp2_5782_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam"
cp "5781_G1_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam"
cp "DA4_7079_SS_G1_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam"
cp "Bp6_DSp2_7078_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam"
cp "5781_G1_IP_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam"
cp "BM7_DSp24_5781_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam"
cp "DA3_7078_SS_G1_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam"
cp "CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam"
cp "CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam"
cp "5782_G1_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam"
cp "Bp9_DSp24_7078_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam"
cp "CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam"
cp "BM10_DSp48_5781_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam"
cp "Bp7_DSp24_5782_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam"
cp "Bp1_DSm2_5782_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam"
cp "CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam"
cp "5782_G1_IP_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam"
cp "CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam"
cp "DA1_5781_SS_G1_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam"
cp "CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam"
cp "CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam"
cp "CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam"
cp "BM3_DSm2_7079_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam"
cp "5781_Q_IP_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam"
cp "BM12_DSp48_7079_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam"
cp "CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam"
cp "CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam"
cp "Bp3_DSm2_7078_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam"
cp "5781_Q_IN_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam"
cp "BM1_DSm2_5781_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam"
cp "BM6_DSp2_7079_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam"
cp "CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/standard-analyses/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam"


❯ cd "${d_proj}/${d_exp_0215}/GEO/bams/standard-analyses" \
>     || echo "cd'ing failed; check on this..."


❯ [[ ! -d md5/ ]] && mkdir md5/
mkdir: created directory 'md5/'


❯ ls -lhaFG
total 65G
drwxrws--- 3 kalavatt  3.3K Jul 18 10:51 ./
drwxrws--- 4 kalavatt    75 Jul 18 07:59 ../
drwxrws--- 2 kalavatt     0 Jul 18 10:51 md5/
-rw-rw---- 1 kalavatt  1.7G Jul 18 10:42 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.7G Jul 18 10:44 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.4G Jul 18 10:43 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:44 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:43 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:44 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.3G Jul 18 10:43 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.3G Jul 18 10:44 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  819M Jul 18 10:44 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.1G Jul 18 10:43 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  777M Jul 18 10:43 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  940M Jul 18 10:42 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  961M Jul 18 10:42 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt 1013M Jul 18 10:44 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt 1017M Jul 18 10:42 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.4G Jul 18 10:44 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:42 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  1.4G Jul 18 10:43 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  1.7G Jul 18 10:43 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.7G Jul 18 10:43 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.8G Jul 18 10:44 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:41 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:42 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  960M Jul 18 10:44 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  788M Jul 18 10:43 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  919M Jul 18 10:42 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  941M Jul 18 10:43 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  876M Jul 18 10:41 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  970M Jul 18 10:42 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  921M Jul 18 10:43 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:42 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  849M Jul 18 10:41 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.3G Jul 18 10:42 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.3G Jul 18 10:43 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  822M Jul 18 10:42 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  784M Jul 18 10:42 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.4G Jul 18 10:43 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  1.3G Jul 18 10:41 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam
-rw-rw---- 1 kalavatt  1.5G Jul 18 10:44 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.4G Jul 18 10:42 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  703M Jul 18 10:44 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  625M Jul 18 10:41 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.6G Jul 18 10:41 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.6G Jul 18 10:41 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.3G Jul 18 10:44 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw---- 1 kalavatt  1.4G Jul 18 10:42 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'md5sum "{1}.UTPD.bam" > "md5/{1}.UTPD.md5.txt"' \
> ::: "${A_bam[@]}"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.md5.txt"
md5sum "WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam" > "md5/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt"
md5sum "WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" > "md5/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam" > "md5/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.md5.txt"
md5sum "rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam" > "md5/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt"
md5sum "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" > "md5/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.md5.txt"
md5sum "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" > "md5/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt"
md5sum "WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" > "md5/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.md5.txt"
md5sum "WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam" > "md5/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.md5.txt"
md5sum "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam" > "md5/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam" > "md5/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.md5.txt"
md5sum "Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam" > "md5/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam" > "md5/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam" > "md5/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.md5.txt"
md5sum "WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam" > "md5/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" > "md5/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt"
md5sum "WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" > "md5/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt"
md5sum "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam" > "md5/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.md5.txt"
md5sum "OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam" > "md5/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.md5.txt"


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'md5sum "{1}.UTPD.bam" > "md5/{1}.UTPD.md5.txt"' \
> ::: "${A_bam[@]}"


#MD5
❯ cat md5/*.txt
5365fafc03962aab1762c5253e90a496  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam
4084ff4f983a81785ac6bf3ebf3b1af8  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam
12326b173614411fbeafcc6d37503c6c  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam
ce443c1060308124afeca53e3da7ce86  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam
3a7eafca7ff2e160ee11c541af1dfe7f  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam
c40bab5e54c49e50511a3f72d54c7992  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam
f61401443c696421b92d91bda2b2d6bd  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam
68072b0444213294639e6440ea0db988  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam
9fe7eb4a92e57123cfd87adcb288a0ff  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
b873b1857eac9efab10b78b659c274d3  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
bd582858fb9315d595c294fe77a234b6  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
08e0b53644d87b3653e4040c1dccef2b  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
9fb854deecb8e7b493aa888e0f2ab6e5  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
4122cfdaa67e423c7395b55ae69e2ffb  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
c2fcd417ff6e6916a7a1b77cd186df89  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
bbcbbbb5402dea0dff14af1e81ae32af  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam
aedfe1859d406021f61fab0e7e6563b2  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
43aa888abd62678397bbc539aa4c7993  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam
637338ef3d5a0b20f213c9b3bf0aa092  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam
f0c39de732247296b834814420b2ff91  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam
34969a7ffc0e97b56c49c963bb70bb9f  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam
590eb380b1f0d49f67fc0957f202a41c  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
ded2039dd24210c4fe64558d64309677  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam
332d1b5d39df521e25ca283a8bc23d1e  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
7a8d4854d64057bd99a24f2565df20e7  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
0b9cf6700d029413283e576bdf69e7fb  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
3cb2737c306b3436d06a46b471a33fdc  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
4bc64478dc8379e5c4b210ae26857054  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
1c32579051b4fc10649eb12133e57c47  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
8608da75909ec7f809e93967f951eeac  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
0e29d1826547b0ab58cb3ee05ad9c233  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam
ea9be5438b2e498a1b98ffed4c0a930e  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
467153add64db72d61fd114262848a2b  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
ca8cbbef238b3d2da204e9973f5ec257  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
642f087d5bb301dfbfb36749b89e57c3  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
2a6fb9f05d0c18ff569a7de6f88139ec  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
04582df0d6cc02715a7c6cded295b799  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam
98d286c0ccaf0798e6e8831461cad5ba  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam
a30a9ee7f7b8a716ce948ade2b00a644  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
1cd0fce81f33438b7ea7ff0a7615af73  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
cf9a0138735ae4cd9f017979238e3344  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
b2be314f5b3e8517c9112c7725570823  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
8b93957d4d716fda838aa1372cd1dd5a  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
39f19efb4e7c1a0be9d3ceb27e5a0a79  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
1dbc3762ee5e4e0555eabe96be70779e  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
498940f1aa80264e52419ec5e2e19853  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
```
</details>
<br />
<br />

<a id="prepare-and-copy-over-bams-transcriptome-assembly-work"></a>
## Prepare and copy over `bam`s: transcriptome assembly work
<a id="get-to-pertinent-source-directory-examine-bams-1"></a>
### Get to pertinent source directory, examine `bam`s
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."
cd "bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged" \
    || echo "cd'ing failed; check on this..."

ls -lhaFG *.bam
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."


❯ cd "bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged" \
>     || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged


❯ ls -lhaFG *.bam
-rw-rw---- 1 kalavatt 2.0G Feb 14 03:59 merged_G1_IN_UTK.primary-secondary.SC.bam
-rw-rw---- 1 kalavatt 2.6G Feb 14 03:59 merged_G1_IP_UTK.primary-secondary.SC.bam
-rw-rw---- 1 kalavatt 1.6G Feb 14 03:58 merged_Q_IN_UTK.primary-secondary.SC.bam
-rw-rw---- 1 kalavatt 1.8G Feb 14 03:58 merged_Q_IP_UTK.primary-secondary.SC.bam
```
</details>
<br />

<a id="copy-over-bams-renaming-them-in-the-process-generate-md5-checksums-too-1"></a>
### Copy over `bam`s, renaming them in the process; generate `MD5` checksums too
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

pwd

#  Create arrays for the bams used for Trinity GG 
unset A_GG; unset a_GG
typeset -A A_GG; typeset -a a_GG
A_GG["merged_G1_IN"]="WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1"; a_GG+=( "merged_G1_IN" )
A_GG["merged_G1_IP"]="WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1";  a_GG+=( "merged_G1_IP" )
 A_GG["merged_Q_IN"]="WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1";  a_GG+=( "merged_Q_IN" )
 A_GG["merged_Q_IP"]="WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1";   a_GG+=( "merged_Q_IP" )

#  Run a print test for the dictionary
for i in "${a_GG[@]}"; do
    echo """
      key  ${i}
    value  ${A_GG[${i}]}
    """
done

#  Check the files exist
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'ls -lhaFG "{2}_UTK.primary-secondary.SC.bam"' \
::: "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
::: "${!A_GG[@]}" \
:::+ "${A_GG[@]}"

#  Run print tests for the copy commands
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'cp "{2}_UTK.primary-secondary.SC.bam" "{1}/{3}.UTKPSSc.bam"' \
::: "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
::: "${!A_GG[@]}" \
:::+ "${A_GG[@]}"

#  Run the copy commands
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'cp "{2}_UTK.primary-secondary.SC.bam" "{1}/{3}.UTKPSSc.bam"' \
::: "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
::: "${!A_GG[@]}" \
:::+ "${A_GG[@]}"

#  Generate MD5 checksums
cd "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
    || echo "cd'ing failed; check on this..."

[[ ! -d md5/ ]] && mkdir md5/

ls -lhaFG

#  Do a print test with GNU parallel
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'md5sum "{1}.UTKPSSc.bam" > "md5/{1}.UTKPSSc.md5.txt"' \
::: "${A_GG[@]}"

#  Write out the md5 checksums
parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'md5sum "{1}.UTKPSSc.bam" > "md5/{1}.UTKPSSc.md5.txt"' \
::: "${A_GG[@]}"

cat md5/*.txt


# _UTK.primary-secondary.SC.bam
# .UTKPSSc.bam
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ pwd
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary-secondary_sans-KL-20S_merged


❯ unset A_GG; unset a_GG


❯ #  Create arrays for the bams used for Trinity GG


❯ unset A_GG; unset a_GG
❯ typeset -A A_GG; typeset -a a_GG
❯ A_GG["merged_G1_IN"]="WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1"; a_GG+=( "merged_G1_IN" )
❯ A_GG["merged_G1_IP"]="WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1";  a_GG+=( "merged_G1_IP" )
❯  A_GG["merged_Q_IN"]="WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1";  a_GG+=( "merged_Q_IN" )
❯  A_GG["merged_Q_IP"]="WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1";   a_GG+=( "merged_Q_IP" )


❯ #  Run a print test for the dictionary


❯ for i in "${a_GG[@]}"; do
>     echo """
>       key  ${i}
>     value  ${A_GG[${i}]}
>     """
> done
      key  merged_G1_IN
    value  WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1

      key  merged_G1_IP
    value  WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1

      key  merged_Q_IN
    value  WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1

      key  merged_Q_IP
    value  WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1


❯ #  Check the files exist


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'ls -lhaFG "{2}_UTK.primary-secondary.SC.bam"' \
> ::: "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
> ::: "${!A_GG[@]}" \
> :::+ "${A_GG[@]}"
-rw-rw---- 1 kalavatt 1.6G Feb 14 03:58 merged_Q_IN_UTK.primary-secondary.SC.bam
-rw-rw---- 1 kalavatt 1.8G Feb 14 03:58 merged_Q_IP_UTK.primary-secondary.SC.bam
-rw-rw---- 1 kalavatt 2.0G Feb 14 03:59 merged_G1_IN_UTK.primary-secondary.SC.bam
-rw-rw---- 1 kalavatt 2.6G Feb 14 03:59 merged_G1_IP_UTK.primary-secondary.SC.bam


❯ #  Run print tests for the copy commands


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'cp "{2}_UTK.primary-secondary.SC.bam" "{1}/{3}.UTKPSSc.bam"' \
> ::: "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
> ::: "${!A_GG[@]}" \
> :::+ "${A_GG[@]}"
cp "merged_Q_IN_UTK.primary-secondary.SC.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/transcriptome-assembly/WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam"
cp "merged_Q_IP_UTK.primary-secondary.SC.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/transcriptome-assembly/WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam"
cp "merged_G1_IN_UTK.primary-secondary.SC.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/transcriptome-assembly/WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam"
cp "merged_G1_IP_UTK.primary-secondary.SC.bam" "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bams/transcriptome-assembly/WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam"


❯ #  Run the copy commands


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'cp "{2}_UTK.primary-secondary.SC.bam" "{1}/{3}.UTKPSSc.bam"' \
> ::: "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
> ::: "${!A_GG[@]}" \
> :::+ "${A_GG[@]}"


❯ #  Generate MD5 checksums


❯ cd "${d_proj}/${d_exp_0215}/GEO/bams/transcriptome-assembly" \
>     || echo "cd'ing failed; check on this..."


❯ [[ ! -d md5/ ]] && mkdir md5/
mkdir: created directory 'md5/'


❯ ls -lhaFG
total 9.2G
drwxrws--- 3 kalavatt  337 Jul 18 11:34 ./
drwxrws--- 4 kalavatt   75 Jul 18 07:59 ../
drwxrws--- 2 kalavatt    0 Jul 18 11:34 md5/
-rw-rw---- 1 kalavatt 2.6G Jul 18 11:33 WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw---- 1 kalavatt 2.0G Jul 18 11:33 WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw---- 1 kalavatt 1.8G Jul 18 11:32 WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw---- 1 kalavatt 1.6G Jul 18 11:32 WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam


❯ #  Do a print test with GNU parallel


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'md5sum "{1}.UTKPSSc.bam" > "md5/{1}.UTKPSSc.md5.txt"' \
> ::: "${A_GG[@]}"
md5sum "WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" > "md5/WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt"
md5sum "WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" > "md5/WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt"
md5sum "WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" > "md5/WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt"
md5sum "WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" > "md5/WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt"


❯ ., WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw---- 1 kalavatt 1.6G Jul 18 11:32 WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam


❯ #  Write out the md5 checksums


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'md5sum "{1}.UTKPSSc.bam" > "md5/{1}.UTKPSSc.md5.txt"' \
> ::: "${A_GG[@]}"


#MD5
❯ cat md5/*.txt
b9fbe34f835db28c602adbb8acd2b587  WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
9bbbf3b3f16a9ec119f9bcb6652463d8  WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
85485b6a8ab90f2014070eb6712bc0e6  WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
0a3c54bde846af2404e1d419d220a67e  WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
```
</details>
<br />
<br />

<a id="prepare-and-copy-over-gff3s-and-gtfs"></a>
## Prepare and copy over `gff3`s and `gtf`s
<a id="determinefindcopy-over-the-gff3s-and-gtfs-to-submit"></a>
### Determine/find/copy over the `gff3`s and `gtf`s to submit
<details>
<summary><i>Notes</i></summary>

- `infiles_gtf-gff3/already/combined_SC_KL_20S.gff3`
- `outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf`
- `outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf`
- `outfiles_gtf-gff3/representation/Greenlaw-et-al_representative-non-coding-transcriptome.gtf`
- `outfiles_gtf-gff3/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf`
- `outfiles_gtf-gff3/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf`
- `outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.gtf`
- `outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.gtf`
</details>
<br />

<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

d_proj="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"
d_exp_0215="results/2023-0215"

cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."

d_gtfs="GEO/gtfs"
d_work="outfiles_gtf-gff3"
f_pre="Greenlaw-et-al"
f_suf="gtf"

#  Run a print test
echo """
#  Concatenated genome for standard and transcriptome-assembly work
cp \\
    \"infiles_gtf-gff3/already/combined_SC_KL_20S.gff3\" \\
    \"${d_gtfs}/${f_pre}.concatenated-genome_SC-KL-20S.gff3\"

#  R64-1-1 blacklist for generation of deepTools BPM coverage tracks
cp \\
    \"outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf\" \\
    \"${d_gtfs}/${f_pre}.R64-1-1_blacklist_rRNA-tRNA.${f_suf}\"

#  \"100% representation\" R64-1-1 genome
cp \\
    \"${d_work}/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.${f_suf}\" \\
    \"${d_gtfs}/${f_pre}.R64-1-1_features-intergenic_sense-antisense.${f_suf}\"

#  Noncoding collapsed features
cp \\
    \"${d_work}/representation/Greenlaw-et-al_representative-non-coding-transcriptome.${f_suf}\" \\
    \"${d_gtfs}/${f_pre}.txome_representative-pa-ncRNA.${f_suf}\"

#  Noncoding non-collapsed features
cp \\
    \"${d_work}/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.${f_suf}\" \\
    \"${d_gtfs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_suf}\"

#  Coding, no pa-ncRNA features
cp \\
    \"${d_work}/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.${f_suf}\" \\
    \"${d_gtfs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_suf}\"

#  G1 nascent transcriptome
cp \\
    \"${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.${f_suf}\" \\
    \"${d_gtfs}/${f_pre}.txome_nascent_G1.${f_suf}\"

#  Q nascent transcriptome
cp \\
    \"${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.${f_suf}\" \\
    \"${d_gtfs}/${f_pre}.txome_nascent_Q.${f_suf}\"
"""

#  Concatenated genome for standard and transcriptome-assembly work
cp \
    "infiles_gtf-gff3/already/combined_SC_KL_20S.gff3" \
    "${d_gtfs}/${f_pre}.concatenated-genome_SC-KL-20S.gff3"

#  R64-1-1 blacklist for generation of deepTools BPM coverage tracks
cp \
    "outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf" \
    "${d_gtfs}/${f_pre}.R64-1-1_blacklist_rRNA-tRNA.${f_suf}"

#  "100% representation" R64-1-1 genome
cp \
    "${d_work}/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.${f_suf}" \
    "${d_gtfs}/${f_pre}.R64-1-1_features-intergenic_sense-antisense.${f_suf}"

#  Noncoding collapsed features
cp \
    "${d_work}/representation/Greenlaw-et-al_representative-non-coding-transcriptome.${f_suf}" \
    "${d_gtfs}/${f_pre}.txome_representative-pa-ncRNA.${f_suf}"

#  Noncoding non-collapsed features
cp \
    "${d_work}/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.${f_suf}" \
    "${d_gtfs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_suf}"

#  Coding, no pa-ncRNA features
cp \
    "${d_work}/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.${f_suf}" \
    "${d_gtfs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_suf}"

#  G1 nascent transcriptome
cp \
    "${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.${f_suf}" \
    "${d_gtfs}/${f_pre}.txome_nascent_G1.${f_suf}"

#  Q nascent transcriptome
cp \
    "${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.${f_suf}" \
    "${d_gtfs}/${f_pre}.txome_nascent_Q.${f_suf}"

#  Check the copy commands were successful
cd "${d_gtfs}" || echo "cd'ing failed; check on this..."

ls -lhaFG

#  Generate MD5 checksums for the gff3 and gtfs
[[ ! -f md5/ ]] && mkdir md5/

for i in *.{gff3,gtf}; do
    echo "md5sum \"${i}\" > md5/${i%.g*}.md5.txt"
done

for i in *.{gff3,gtf}; do
    md5sum "${i}" > "md5/${i%.g*}.md5.txt"
done

cat md5/*.txt
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ d_proj="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"


❯ d_exp_0215="results/2023-0215"


❯ cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."


❯ d_gtfs="GEO/gtfs"


❯ d_work="outfiles_gtf-gff3"


❯ f_pre="Greenlaw-et-al"


❯ f_suf="gtf"


❯ #  Run a print test


❯ echo """
> #  Concatenated genome for standard and transcriptome-assembly work
> cp \\
>     \"infiles_gtf-gff3/already/combined_SC_KL_20S.gff3\" \\
>     \"${d_gtfs}/${f_pre}.concatenated-genome_SC-KL-20S.gff3\"
> 
> #  R64-1-1 blacklist for generation of deepTools BPM coverage tracks
> cp \\
>     \"outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf\" \\
>     \"${d_gtfs}/${f_pre}.R64-1-1_blacklist_rRNA-tRNA.${f_suf}\"
> 
> #  \"100% representation\" R64-1-1 genome
> cp \\
>     \"${d_work}/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.${f_suf}\" \\
>     \"${d_gtfs}/${f_pre}.R64-1-1_features-intergenic_sense-antisense.${f_suf}\"
> 
> #  Noncoding collapsed features
> cp \\
>     \"${d_work}/representation/Greenlaw-et-al_representative-non-coding-transcriptome.${f_suf}\" \\
>     \"${d_gtfs}/${f_pre}.txome_representative-pa-ncRNA.${f_suf}\"
> 
> #  Noncoding non-collapsed features
> cp \\
>     \"${d_work}/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.${f_suf}\" \\
>     \"${d_gtfs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_suf}\"
> 
> #  Coding, no pa-ncRNA features
> cp \\
>     \"${d_work}/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.${f_suf}\" \\
>     \"${d_gtfs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_suf}\"
> 
> #  G1 nascent transcriptome
> cp \\
>     \"${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.${f_suf}\" \\
>     \"${d_gtfs}/${f_pre}.txome_nascent_G1.${f_suf}\"
> 
> #  Q nascent transcriptome
> cp \\
>     \"${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.${f_suf}\" \\
>     \"${d_gtfs}/${f_pre}.txome_nascent_Q.${f_suf}\"
> """
#  Concatenated genome for standard and transcriptome-assembly work
cp \
    "infiles_gtf-gff3/already/combined_SC_KL_20S.gff3" \
    "GEO/gtfs/Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3"

#  R64-1-1 blacklist for generation of deepTools BPM coverage tracks
cp \
    "outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf" \
    "GEO/gtfs/Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf"

#  "100% representation" R64-1-1 genome
cp \
    "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf" \
    "GEO/gtfs/Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf"

#  Noncoding collapsed features
cp \
    "outfiles_gtf-gff3/representation/Greenlaw-et-al_representative-non-coding-transcriptome.gtf" \
    "GEO/gtfs/Greenlaw-et-al.txome_representative-pa-ncRNA.gtf"

#  Noncoding non-collapsed features
cp \
    "outfiles_gtf-gff3/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf" \
    "GEO/gtfs/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf"

#  Coding, no pa-ncRNA features
cp \
    "outfiles_gtf-gff3/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf" \
    "GEO/gtfs/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf"

#  G1 nascent transcriptome
cp \
    "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.gtf" \
    "GEO/gtfs/Greenlaw-et-al.txome_nascent_G1.gtf"

#  Q nascent transcriptome
cp \
    "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.gtf" \
    "GEO/gtfs/Greenlaw-et-al.txome_nascent_Q.gtf"


❯ #  Concatenated genome for standard and transcriptome-assembly work


❯ cp \
>     "infiles_gtf-gff3/already/combined_SC_KL_20S.gff3" \
>     "${d_gtfs}/${f_pre}.concatenated-genome_SC-KL-20S.gff3"
'infiles_gtf-gff3/already/combined_SC_KL_20S.gff3' -> 'GEO/gtfs/Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3'


❯ #  R64-1-1 blacklist for generation of deepTools BPM coverage tracks


❯ cp \
>     "outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf" \
>     "${d_gtfs}/${f_pre}.R64-1-1_blacklist_rRNA-tRNA.${f_suf}"
'outfiles_gtf-gff3/already/SC_features-rRNA-tRNA.gtf' -> 'GEO/gtfs/Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf'


❯ #  "100% representation" R64-1-1 genome


❯ cp \
>     "${d_work}/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.${f_suf}" \
>     "${d_gtfs}/${f_pre}.R64-1-1_features-intergenic_sense-antisense.${f_suf}"
'outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/processed_features-intergenic_sense-antisense.gtf' -> 'GEO/gtfs/Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf'


❯ #  Noncoding collapsed features


❯ cp \
>     "${d_work}/representation/Greenlaw-et-al_representative-non-coding-transcriptome.${f_suf}" \
>     "${d_gtfs}/${f_pre}.txome_representative-pa-ncRNA.${f_suf}"
'outfiles_gtf-gff3/representation/Greenlaw-et-al_representative-non-coding-transcriptome.gtf' -> 'GEO/gtfs/Greenlaw-et-al.txome_representative-pa-ncRNA.gtf'


❯ #  Noncoding non-collapsed features


❯ cp \
>     "${d_work}/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.${f_suf}" \
>     "${d_gtfs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_suf}"
'outfiles_gtf-gff3/representation/Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf' -> 'GEO/gtfs/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf'


❯ #  Coding, no pa-ncRNA features


❯ cp \
>     "${d_work}/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.${f_suf}" \
>     "${d_gtfs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_suf}"
'outfiles_gtf-gff3/representation/Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf' -> 'GEO/gtfs/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf'


❯ #  G1 nascent transcriptome


❯ cp \
>     "${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.${f_suf}" \
>     "${d_gtfs}/${f_pre}.txome_nascent_G1.${f_suf}"
'outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.gtf' -> 'GEO/gtfs/Greenlaw-et-al.txome_nascent_G1.gtf'


❯ #  Q nascent transcriptome


❯ cp \
>     "${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.${f_suf}" \
>     "${d_gtfs}/${f_pre}.txome_nascent_Q.${f_suf}"
'outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.gtf' -> 'GEO/gtfs/Greenlaw-et-al.txome_nascent_Q.gtf'


❯ #  Check the copy commands were successful


❯ cd "${d_gtfs}" || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/gtfs


❯ ls -lhaFG
total 15M
drwxrws--- 2 kalavatt   526 Jul 18 15:18 ./
drwxrws--- 7 kalavatt   115 Jul 18 07:59 ../
-rw-rw---- 1 kalavatt  8.5M Jul 18 15:18 Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3
-rw-rw---- 1 kalavatt  315K Jul 18 15:18 Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf
-rw-rw---- 1 kalavatt  4.5M Jul 18 15:18 Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf
-rw-rw---- 1 kalavatt  3.1M Jul 18 15:18 Greenlaw-et-al.txome_nascent_G1.gtf
-rw-rw---- 1 kalavatt  3.8M Jul 18 15:18 Greenlaw-et-al.txome_nascent_Q.gtf
-rw-rw---- 1 kalavatt  1.7M Jul 18 15:18 Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf
-rw-rw---- 1 kalavatt 1016K Jul 18 15:18 Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf
-rw-rw---- 1 kalavatt  1.6M Jul 18 15:18 Greenlaw-et-al.txome_representative-pa-ncRNA.gtf


❯ [[ ! -f md5/ ]] && mkdir md5/
mkdir: created directory 'md5/'


❯ for i in *.{gff3,gtf}; do
>     echo "md5sum \"${i}\" > md5/${i%.g*}.md5.txt"
> done
md5sum "Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3" > md5/Greenlaw-et-al.concatenated-genome_SC-KL-20S.md5.txt
md5sum "Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf" > md5/Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.md5.txt
md5sum "Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf" > md5/Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.md5.txt
md5sum "Greenlaw-et-al.txome_nascent_G1.gtf" > md5/Greenlaw-et-al.txome_nascent_G1.md5.txt
md5sum "Greenlaw-et-al.txome_nascent_Q.gtf" > md5/Greenlaw-et-al.txome_nascent_Q.md5.txt
md5sum "Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf" > md5/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.md5.txt
md5sum "Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf" > md5/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.md5.txt
md5sum "Greenlaw-et-al.txome_representative-pa-ncRNA.gtf" > md5/Greenlaw-et-al.txome_representative-pa-ncRNA.md5.txt


❯ for i in *.{gff3,gtf}; do
>     md5sum "${i}" > "md5/${i%.g*}.md5.txt"
> done


❯ ls -lhaFG ./*
-rw-rw---- 1 kalavatt  8.5M Jul 18 15:18 ./Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3
-rw-rw---- 1 kalavatt  315K Jul 18 15:18 ./Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf
-rw-rw---- 1 kalavatt  4.5M Jul 18 15:18 ./Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf
-rw-rw---- 1 kalavatt  3.1M Jul 18 15:18 ./Greenlaw-et-al.txome_nascent_G1.gtf
-rw-rw---- 1 kalavatt  3.8M Jul 18 15:18 ./Greenlaw-et-al.txome_nascent_Q.gtf
-rw-rw---- 1 kalavatt  1.7M Jul 18 15:18 ./Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf
-rw-rw---- 1 kalavatt 1016K Jul 18 15:18 ./Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf
-rw-rw---- 1 kalavatt  1.6M Jul 18 15:18 ./Greenlaw-et-al.txome_representative-pa-ncRNA.gtf

./md5:
total 296K
drwxrws--- 2 kalavatt 557 Jul 18 15:25 ./
drwxrws--- 3 kalavatt 547 Jul 18 15:22 ../
-rw-rw---- 1 kalavatt  84 Jul 18 15:25 Greenlaw-et-al.concatenated-genome_SC-KL-20S.md5.txt
-rw-rw---- 1 kalavatt  81 Jul 18 15:25 Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.md5.txt
-rw-rw---- 1 kalavatt  97 Jul 18 15:25 Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.md5.txt
-rw-rw---- 1 kalavatt  70 Jul 18 15:25 Greenlaw-et-al.txome_nascent_G1.md5.txt
-rw-rw---- 1 kalavatt  69 Jul 18 15:25 Greenlaw-et-al.txome_nascent_Q.md5.txt
-rw-rw---- 1 kalavatt  83 Jul 18 15:25 Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.md5.txt
-rw-rw---- 1 kalavatt  94 Jul 18 15:25 Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.md5.txt
-rw-rw---- 1 kalavatt  84 Jul 18 15:25 Greenlaw-et-al.txome_representative-pa-ncRNA.md5.txt


#MD5
❯ cat md5/*.txt
39e691a98c40a028506103684e43ed3e  Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3
a8433aa4c6a279ca256a2348682b03c8  Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf
b8a083a4a34830cf28d594ab12afd799  Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf
a9de7165b681fe6c5a9a62708d90f738  Greenlaw-et-al.txome_nascent_G1.gtf
a44ac63231bc68098d30d7c0e495886e  Greenlaw-et-al.txome_nascent_Q.gtf
bf1f6e99ee614c2ce347514fd83a3f52  Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf
546438d4eee056bc467294420ee1b276  Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf
214e9f2b24e9a401f799601b8ba05b4c  Greenlaw-et-al.txome_representative-pa-ncRNA.gtf
```
</details>
<br />
<br />

<a id="prepare-and-copy-over-counts-matrices"></a>
## Prepare and copy over counts matrices
<a id="determinefindcopy-over-the-counts-matrices-to-submit"></a>
### Determine/find/copy over the counts matrices to submit
<details>
<summary><i>Notes</i></summary>

- `outfiles_htseq-count/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv`
    + → `GEO/matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv`
- `outfiles_htseq-count/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv`
    + → `GEO/matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv`
- `outfiles_htseq-count/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.tsv`
    + → `GEO/matrices/Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv`
- `outfiles_htseq-count/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv`
    + → `GEO/matrices/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv`
- `outfiles_htseq-count/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv`
    + → `GEO/matrices/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv`
- `outfiles_htseq-count/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv`
    + → `GEO/matrices/Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv`
- `outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv`
    + → `GEO/matrices/Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv`
</details>
<br />

<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."

d_tsvs="GEO/matrices"
d_work="outfiles_htseq-count"
f_pre="Greenlaw-et-al"
f_info="hc_strd-eq_nonuniq-none"
f_suf="tsv"

#  Run a print test
echo """
#  Same-strand tallies for concatenated genome (e.g., use these counts to
#+ calculate K. lactis size factors)
cp \\
    \"${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.${f_info}.${f_suf}\"

#  Opposite-strand tallies for concatenated genome
cp \\
    \"${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.${f_suf}\"

#  Same-strand tallies for noncoding collapsed features 
cp \\
    \"${d_work}/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.txome_representative-pa-ncRNA.${f_info}.${f_suf}\"

#  Same-strand tallies for noncoding non-collapsed features
cp \\
    \"${d_work}/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_info}.${f_suf}\"

#  Same-strand tallies for coding (i.e., R64-1-1 functional annotations)
#+ non-pa-ncRNA features
cp \\
    \"${d_work}/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_info}.${f_suf}\"

#  Same-strand tallies for G1 nascent assembled features
cp \\
    \"${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.txome_nascent_G1.${f_info}.${f_suf}\"

#  Same-strand tallies for Q nascent assembled features
cp \\
    \"${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}\" \\
    \"${d_tsvs}/${f_pre}.txome_nascent_Q.${f_info}.${f_suf}\"
"""

#  Same-strand tallies for concatenated genome (e.g., use these counts to
#+ calculate K. lactis size factors)
cp \
    "${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.${f_suf}" \
    "${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.${f_info}.${f_suf}"

#  Opposite-strand tallies for concatenated genome
cp \
    "${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.${f_suf}" \
    "${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.${f_suf}"

#  Same-strand tallies for noncoding collapsed features 
cp \
    "${d_work}/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.${f_suf}" \
    "${d_tsvs}/${f_pre}.txome_representative-pa-ncRNA.${f_info}.${f_suf}"

#  Same-strand tallies for noncoding non-collapsed features
cp \
    "${d_work}/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.${f_suf}" \
    "${d_tsvs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_info}.${f_suf}"

#  Same-strand tallies for coding (i.e., R64-1-1 functional annotations)
#+ non-pa-ncRNA features
cp \
    "${d_work}/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.${f_suf}" \
    "${d_tsvs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_info}.${f_suf}"

#  Same-strand tallies for G1 nascent assembled features
cp \
    "${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}" \
    "${d_tsvs}/${f_pre}.txome_nascent_G1.${f_info}.${f_suf}"

#  Same-strand tallies for Q nascent assembled features
cp \
    "${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}" \
    "${d_tsvs}/${f_pre}.txome_nascent_Q.${f_info}.${f_suf}"

#  Check on the copied files and generate MD5 checksums
cd "${d_tsvs}" || echo "cd'ing failed; check on this..."

[[ ! -d md5/ ]] && mkdir md5/

ls -lhaFG

#NOTE Run counts matrices through script work_prepare-data_GEO_matrices.R

for i in *.tsv; do md5sum "${i}" > "md5/${i%.tsv}.md5.txt"; done

ls -lhaFG ./*

cat md5/*.txt
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${d_proj}/${d_exp_0215}" || echo "cd'ing failed; check on this..."


❯ d_tsvs="GEO/matrices"


❯ d_work="outfiles_htseq-count"


❯ f_pre="Greenlaw-et-al"


❯ f_info="hc_strd-eq_nonuniq-none"


❯ f_suf="tsv"


❯ echo """
> #  Same-strand tallies for concatenated genome (e.g., use these counts to
> #+ calculate K. lactis size factors)
> cp \\
>     \"${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.${f_suf}\" \\>     \"${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.${f_info}.${f_suf}\"
> 
> #  Opposite-strand tallies for concatenated genome
> cp \\
>     \"${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.${f_suf}\" \\>     \"${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.${f_suf}\"
> 
> #  Same-strand tallies for noncoding collapsed features
> cp \\
>     \"${d_work}/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.${f_suf}\" \\
>     \"${d_tsvs}/${f_pre}.txome_representative-pa-ncRNA.${f_info}.${f_suf}\"
> 
> #  Same-strand tallies for noncoding non-collapsed features
> cp \\
>     \"${d_work}/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.${f_suf}\" \\
>     \"${d_tsvs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_info}.${f_suf}\"
> 
> #  Same-strand tallies for coding (i.e., R64-1-1 functional annotations)
> #+ non-pa-ncRNA features
> cp \\
>     \"${d_work}/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.${f_suf}\" \\
>     \"${d_tsvs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_info}.${f_suf}\"
> 
> #  Same-strand tallies for G1 nascent assembled features
> cp \\
>     \"${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}\" \\
>     \"${d_tsvs}/${f_pre}.txome_nascent_G1.${f_info}.${f_suf}\"
> 
> #  Same-strand tallies for Q nascent assembled features
> cp \\
>     \"${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}\" \\
>     \"${d_tsvs}/${f_pre}.txome_nascent_Q.${f_info}.${f_suf}\"
> """
#  Same-strand tallies for concatenated genome (e.g., use these counts to
#+ calculate K. lactis size factors)
cp \
    "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv" \
    "GEO/matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv"

#  Opposite-strand tallies for concatenated genome
cp \
    "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv" \
    "GEO/matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv"

#  Same-strand tallies for noncoding collapsed features
cp \
    "outfiles_htseq-count/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.tsv" \
    "GEO/matrices/Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv"

#  Same-strand tallies for noncoding non-collapsed features
cp \
    "outfiles_htseq-count/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv" \
    "GEO/matrices/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv"

#  Same-strand tallies for coding (i.e., R64-1-1 functional annotations)
#+ non-pa-ncRNA features
cp \
    "outfiles_htseq-count/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv" \
    "GEO/matrices/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv"

#  Same-strand tallies for G1 nascent assembled features
cp \
    "outfiles_htseq-count/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv" \
    "GEO/matrices/Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv"

#  Same-strand tallies for Q nascent assembled features
cp \
    "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv" \
    "GEO/matrices/Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv"


❯ #  Same-strand tallies for concatenated genome (e.g., use these counts to
❯ #+ calculate K. lactis size factors)


❯ cp \
>     "${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.${f_suf}" \
>     "${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.${f_info}.${f_suf}"
'outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv' -> 'GEO/matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv'


❯ #  Opposite-strand tallies for concatenated genome


❯ cp \
>     "${d_work}/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.${f_suf}" \
>     "${d_tsvs}/${f_pre}.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.${f_suf}"
'outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI/all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv' -> 'GEO/matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv'


❯ #  Same-strand tallies for noncoding collapsed features


❯ cp \
>     "${d_work}/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.${f_suf}" \
>     "${d_tsvs}/${f_pre}.txome_representative-pa-ncRNA.${f_info}.${f_suf}"
'outfiles_htseq-count/representation/UT_prim_UMI/representative-non-coding-transcriptome.hc-strd-eq.tsv' -> 'GEO/matrices/Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv'


❯ #  Same-strand tallies for noncoding non-collapsed features


❯ cp \
>     "${d_work}/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.${f_suf}" \
>     "${d_tsvs}/${f_pre}.txome_non-collapsed-pa-ncRNA.${f_info}.${f_suf}"
'outfiles_htseq-count/representation/UT_prim_UMI/non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv' -> 'GEO/matrices/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv'


❯ #  Same-strand tallies for coding (i.e., R64-1-1 functional annotations)
❯ #+ non-pa-ncRNA features


❯ cp \
>     "${d_work}/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.${f_suf}" \
>     "${d_tsvs}/${f_pre}.txome_representative-coding-non-pa-ncRNA.${f_info}.${f_suf}"
'outfiles_htseq-count/representation/UT_prim_UMI/representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv' -> 'GEO/matrices/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv'


❯ #  Same-strand tallies for G1 nascent assembled features


❯ cp \
>     "${d_work}/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}" \
>     "${d_tsvs}/${f_pre}.txome_nascent_G1.${f_info}.${f_suf}"
'outfiles_htseq-count/Trinity-GG/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv' -> 'GEO/matrices/Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv'


❯ #  Same-strand tallies for Q nascent assembled features


❯ cp \
>     "${d_work}/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.${f_suf}" \
>     "${d_tsvs}/${f_pre}.txome_nascent_Q.${f_info}.${f_suf}"
'outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv' -> 'GEO/matrices/Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv'


❯ cd "${d_tsvs}" || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/matrices


❯ [[ ! -d md5/ ]] && mkdir md5/
mkdir: created directory 'md5/'


❯ ls -lhaFG
total 9.9M
drwxrws--- 3 kalavatt  646 Jul 18 16:42 ./
drwxrws--- 7 kalavatt  115 Jul 18 07:59 ../
-rw-rw---- 1 kalavatt 2.8M Jul 18 16:37 Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 2.1M Jul 18 16:37 Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 1.4M Jul 18 16:37 Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 1.6M Jul 18 16:37 Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 1.3M Jul 18 16:37 Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 1.6M Jul 18 16:37 Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 888K Jul 18 16:37 Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
drwxrws--- 2 kalavatt    0 Jul 18 16:42 md5/


❯ for i in *.tsv; do md5sum "${i}" > "md5/${i%.tsv}.md5.txt"; done


❯ #TODO 1/3 Need to delete and regenerate MD5 checksums after cleaning up and
❯ #TODO 2/3 correcting column names, and removing columns for the 16 unused
❯ #TODO 3/3 samples (from 62 to 46)


❯ ls -lhaFG ./*
-rw-rw---- 1 kalavatt 2.7M Jul 19 12:42 ./Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 2.2M Jul 19 12:42 ./Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 2.9M Jul 19 12:42 ./Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 3.6M Jul 19 12:42 ./Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 2.1M Jul 19 12:42 ./Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 1.7M Jul 19 12:42 ./Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw---- 1 kalavatt 1.6M Jul 19 12:42 ./Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv

./md5:
total 272K
drwxrws--- 2 kalavatt  651 Jul 19 12:47 ./
drwxrws--- 3 kalavatt 1.3K Jul 19 12:47 ../
-rw-rw---- 1 kalavatt  112 Jul 19 12:47 Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.md5.txt
-rw-rw---- 1 kalavatt  112 Jul 19 12:47 Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.md5.txt
-rw-rw---- 1 kalavatt   94 Jul 19 12:47 Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.md5.txt
-rw-rw---- 1 kalavatt   93 Jul 19 12:47 Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.md5.txt
-rw-rw---- 1 kalavatt  106 Jul 19 12:47 Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.md5.txt
-rw-rw---- 1 kalavatt  118 Jul 19 12:47 Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.md5.txt
-rw-rw---- 1 kalavatt  107 Jul 19 12:47 Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.md5.txt


#MD5
❯ cat md5/*.txt
1f701cd2de97a1f7dd787c70693fbda1  Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv
a79af572fffd34a63ab31f3a71c6161f  Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv
f5042f448885bda59011480b9d635ae7  Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv
79e74b8613e3b9515e85c4effcdac6b2  Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv
eccb07887774f15bf745783db3c99216  Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
39d3d5573ef5e9796b8ead8ba83dd566  Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
a88e399e136bec2f12f6f35fad16caa4  Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
```
</details>
<br />
<br />

<a id="prepare-and-copy-over-bws"></a>
## Prepare and copy over `bw`s
<a id="notes-and-code-and-printed"></a>
### Notes (and code and printed)
<details>
<summary><i>Notes (and code and printed)</i></summary>

Manually copied over files from `~/tsukiyamalab/alisong/KL_bigwigs_for_geo`:

<a id="code-2"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

ls -lhaFG "${HOME}/tsukiyamalab/alisong/KL_bigwigs_for_geo"
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ ls -lhaFG
total 1.6G
drwxrws---   2 agreenla 5.7K Jul 19 16:09 ./
drwxrws--- 101 agreenla 5.7K Jul 19 16:05 ../
-rw-rw----   1 agreenla  47M Apr 26 16:20 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  47M Apr 26 16:25 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  46M Apr 26 16:32 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  46M Apr 26 16:39 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  17M May 24 13:12 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May 24 13:30 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  14M May 24 13:44 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  15M May 24 14:04 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  35M Apr 26 16:44 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  35M Apr 26 16:48 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  34M Apr 26 16:54 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  34M Apr 26 16:59 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla 7.4M May 24 14:14 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla 7.7M May 24 14:27 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla 7.4M May 24 14:39 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla 7.7M May 24 14:52 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw         16

-rw-rw----   1 agreenla  20M May  2 13:44 r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  20M May  2 13:48 r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  22M May  2 13:54 r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  22M May  2 13:59 r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  17M May  2 14:02 r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  2 14:06 r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  20M May  2 14:11 r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  20M May  2 14:15 r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  21M May  2 13:50 r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  22M May  2 13:55 r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  22M May  2 14:02 r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  23M May  2 14:06 r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  17M May  2 14:04 r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  2 14:11 r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  16M May  2 15:38 r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech2.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  2 15:45 r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech2.UT_prim_UMI_p.bw

-rw-rw----   1 agreenla  22M May  5 13:15 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  22M May  5 13:24 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  22M May  5 13:35 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  22M May  5 13:44 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  40M May 24 14:42 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  40M May 24 14:46 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  39M May 24 14:53 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  39M May 24 14:58 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  11M May  5 12:44 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  12M May  5 13:00 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla 9.7M May  5 13:13 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla 9.9M May  5 13:26 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  13M May  5 13:37 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  13M May  5 13:53 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw        14

-rw-rw----   1 agreenla  19M May  2 14:05 WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  19M May  2 14:10 WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  17M May  2 14:16 WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  2 14:21 WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  17M May  2 14:21 WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  2 14:25 WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  17M May  2 14:31 WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  2 14:34 WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  18M May  2 14:13 WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  18M May  2 14:17 WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  18M May  2 14:25 WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  19M May  2 14:30 WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  14M May  2 14:15 WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  15M May  2 14:22 WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  14M May  2 14:33 WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  15M May  2 14:41 WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  13M May  2 14:46 WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  13M May  2 14:51 WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI_p.bw

-rw-rw----   1 agreenla  17M May  5 13:57 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  18M May  5 14:06 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  16M May  5 14:18 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  17M May  5 14:27 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  38M May 24 15:03 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  38M May 24 15:08 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla  38M May 24 15:14 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla  38M May 24 15:18 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla 8.0M May  5 14:04 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla 8.3M May  5 14:20 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw----   1 agreenla 8.4M May  5 14:31 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw----   1 agreenla 8.5M May  5 14:50 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw          12
```
</details>
<br />

<i>Above: 16 + 14 + 12 = 42 files to copy over. In particular, need to copy these files:</i>

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
```
</details>
<br />

<i>Above: 42 lines.</i>

Check/document the files that I manually copied over:

<a id="code-3"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

ls -lhaFG "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual"
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ ls -lhaFG "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual"
total 1.2G
drwxrws--- 2 kalavatt 3.1K Jul 20 06:03 ./
drwxrws--- 4 kalavatt   50 Jul 20 06:07 ../
-rw-rw---- 1 kalavatt  47M Apr 26 16:20 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  47M Apr 26 16:25 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:32 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:39 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  17M May 24 13:12 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  17M May 24 13:30 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  14M May 24 13:44 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  15M May 24 14:04 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:44 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:48 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:54 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:59 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:14 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:27 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:39 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:52 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:15 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:24 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:35 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:44 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  40M May 24 14:42 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  40M May 24 14:46 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  39M May 24 14:53 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  39M May 24 14:58 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  11M May  5 12:44 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  12M May  5 13:00 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 9.7M May  5 13:13 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 9.9M May  5 13:26 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  13M May  5 13:37 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  13M May  5 13:53 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  17M May  5 13:57 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  18M May  5 14:06 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  16M May  5 14:18 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  17M May  5 14:27 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:03 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:08 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:14 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:18 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 8.0M May  5 14:04 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 8.3M May  5 14:20 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 8.4M May  5 14:31 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 8.5M May  5 14:50 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
```
</details>
<br />

<i>Above: 42 lines.</i>

Also, manually copied over files from `~/tsukiyamalab/alisong/merged_bigwigs_for_geo`:

<a id="code-4"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

ls -lhaFG "${HOME}/tsukiyamalab/alisong/merged_bigwigs_for_geo"
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ ls -lhaFG "${HOME}/tsukiyamalab/alisong/merged_bigwigs_for_geo"
total 1.9G
drwxrws---   2 agreenla 2.4K Jul 19 13:13 ./
drwxrws--- 100 agreenla 5.6K Jul 19 14:45 ../
-rw-rw----   1 agreenla  76M May 24 13:02 mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
-rw-rw----   1 agreenla  75M May 24 13:05 mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
-rw-rw----   1 agreenla  30M May 24 16:02 mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
-rw-rw----   1 agreenla  31M May 24 16:05 mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
-rw-rw----   1 agreenla  60M May 24 13:04 mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
-rw-rw----   1 agreenla  60M May 24 13:07 mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
-rw-rw----   1 agreenla  15M May 24 16:03 mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
-rw-rw----   1 agreenla  16M May 24 16:06 mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
-rw-rw----   1 agreenla  39M May 24 16:06 mean_r6-n_DSm2_day2_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  40M May 24 16:23 mean_r6-n_DSm2_day2_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  35M May 24 16:07 mean_r6-n_DSp24_day3_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  35M May 24 16:25 mean_r6-n_DSp24_day3_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  41M May 24 16:09 mean_r6-n_DSp2_day2_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  42M May 24 16:26 mean_r6-n_DSp2_day2_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  40M May 24 16:10 mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw----   1 agreenla  41M May 24 16:28 mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw----   1 agreenla  69M May 24 16:12 mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
-rw-rw----   1 agreenla  69M May 24 16:29 mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
-rw-rw----   1 agreenla  24M May 24 16:13 mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw----   1 agreenla  24M May 24 16:30 mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw----   1 agreenla  32M May 24 16:14 mean_WT_DSm2_day2_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  32M May 24 16:32 mean_WT_DSm2_day2_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  32M May 24 16:15 mean_WT_DSp24_day3_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  32M May 24 16:33 mean_WT_DSp24_day3_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  33M May 24 16:17 mean_WT_DSp2_day2_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  34M May 24 16:34 mean_WT_DSp2_day2_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  26M May 24 16:18 mean_WT_DSp48_day4_tcn_SS_aux-F_tc-T__KL.m.bw
-rw-rw----   1 agreenla  26M May 24 16:35 mean_WT_DSp48_day4_tcn_SS_aux-F_tc-T__KL.p.bw
-rw-rw----   1 agreenla  30M May 24 16:19 mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw----   1 agreenla  31M May 24 16:37 mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw----   1 agreenla  40M May 24 13:04 mean_WT_G1_N_.bl-TPM.m.bw
-rw-rw----   1 agreenla  40M May 24 13:10 mean_WT_G1_N_.bl-TPM.p.bw
-rw-rw----   1 agreenla  28M May 24 13:05 mean_WT_G1_SS_.bl-TPM.m.bw
-rw-rw----   1 agreenla  29M May 24 13:11 mean_WT_G1_SS_.bl-TPM.p.bw
-rw-rw----   1 agreenla  67M May 24 16:21 mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
-rw-rw----   1 agreenla  68M May 24 16:38 mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
-rw-rw----   1 agreenla  17M May 24 16:22 mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw----   1 agreenla  18M May 24 16:39 mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw----   1 agreenla  64M May 24 13:07 mean_WT_Q_N_.bl-TPM.m.bw
-rw-rw----   1 agreenla  64M May 24 13:13 mean_WT_Q_N_.bl-TPM.p.bw
-rw-rw----   1 agreenla  24M May 24 13:08 mean_WT_Q_SS_.bl-TPM.m.bw
-rw-rw----   1 agreenla  25M May 24 13:14 mean_WT_Q_SS_.bl-TPM.p.bw
```
</details>
<br />

Nothing appears to be missing from this. Except for the time course datasets, copied over all of these files. Check/document the files that I manually copied over:

<a id="code-5"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

ls -lhaFG "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean"
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ ls -lhaFG "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean"
total 1.4G
drwxrws--- 2 kalavatt 1.6K Jul 19 17:18 ./
drwxrws--- 4 kalavatt   50 Jul 20 06:07 ../
-rw-rw---- 1 kalavatt  76M May 24 13:02 mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  75M May 24 13:05 mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:02 mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:05 mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  60M May 24 13:04 mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  60M May 24 13:07 mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  15M May 24 16:03 mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  16M May 24 16:06 mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  40M May 24 16:10 mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  41M May 24 16:28 mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  69M May 24 16:12 mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  69M May 24 16:29 mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  24M May 24 16:13 mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  24M May 24 16:30 mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:19 mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:37 mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  40M May 24 13:04 mean_WT_G1_N_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  40M May 24 13:10 mean_WT_G1_N_.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  28M May 24 13:05 mean_WT_G1_SS_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  29M May 24 13:11 mean_WT_G1_SS_.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  67M May 24 16:21 mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  68M May 24 16:38 mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  17M May 24 16:22 mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  18M May 24 16:39 mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  64M May 24 13:07 mean_WT_Q_N_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  64M May 24 13:13 mean_WT_Q_N_.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  24M May 24 13:08 mean_WT_Q_SS_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  25M May 24 13:14 mean_WT_Q_SS_.bl-TPM.p.bw
```
</details>
<br />

<i>Above: 28 lines&mdash;I copied over 28 files (again, didn't copy over the time course datasets).</i>

<a id="code-6"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" ||
    echo "cd'ing failed; check on this..."

ls -lhaFG ./*
```
</details>
<br />

<a id="printed-6"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" ||
>     echo "cd'ing failed; check on this..."


❯ ls -lhaFG ./*
./individual:
total 1.2G
drwxrws--- 2 kalavatt 3.1K Jul 20 06:03 ./
drwxrws--- 4 kalavatt   50 Jul 20 06:07 ../
-rw-rw---- 1 kalavatt  47M Apr 26 16:20 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  47M Apr 26 16:25 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:32 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:39 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  17M May 24 13:12 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  17M May 24 13:30 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  14M May 24 13:44 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  15M May 24 14:04 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:44 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:48 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:54 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:59 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:14 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:27 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:39 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:52 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:15 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:24 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:35 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:44 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  40M May 24 14:42 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  40M May 24 14:46 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  39M May 24 14:53 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  39M May 24 14:58 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  11M May  5 12:44 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  12M May  5 13:00 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 9.7M May  5 13:13 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 9.9M May  5 13:26 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  13M May  5 13:37 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  13M May  5 13:53 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  17M May  5 13:57 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  18M May  5 14:06 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  16M May  5 14:18 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  17M May  5 14:27 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:03 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:08 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:14 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:18 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 8.0M May  5 14:04 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 8.3M May  5 14:20 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 8.4M May  5 14:31 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 8.5M May  5 14:50 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw            42

./mean:
total 1.4G
drwxrws--- 2 kalavatt 1.6K Jul 19 17:18 ./
drwxrws--- 4 kalavatt   50 Jul 20 06:07 ../
-rw-rw---- 1 kalavatt  76M May 24 13:02 mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  75M May 24 13:05 mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:02 mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:05 mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  60M May 24 13:04 mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  60M May 24 13:07 mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  15M May 24 16:03 mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  16M May 24 16:06 mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  40M May 24 16:10 mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  41M May 24 16:28 mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  69M May 24 16:12 mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  69M May 24 16:29 mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  24M May 24 16:13 mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  24M May 24 16:30 mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:19 mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:37 mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  40M May 24 13:04 mean_WT_G1_N_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  40M May 24 13:10 mean_WT_G1_N_.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  28M May 24 13:05 mean_WT_G1_SS_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  29M May 24 13:11 mean_WT_G1_SS_.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  67M May 24 16:21 mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  68M May 24 16:38 mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  17M May 24 16:22 mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
-rw-rw---- 1 kalavatt  18M May 24 16:39 mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
-rw-rw---- 1 kalavatt  64M May 24 13:07 mean_WT_Q_N_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  64M May 24 13:13 mean_WT_Q_N_.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  24M May 24 13:08 mean_WT_Q_SS_.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  25M May 24 13:14 mean_WT_Q_SS_.bl-TPM.p.bw                                          28
```
</details>
<br />

Renaming strategy for <b><u>individual</u></b> datasets from Alison:

<a id="notes-important"></a>
#### Notes `#IMPORTANT`
<details>
<summary><i>Notes</i></summary>

<i>Original</i>
```txt
--------                                                    ------
original                                                    change
--------                                                    ------
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw

o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw

--------                                                    ------
original                                                    change
--------                                                    ------
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw

o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw

--------                                                    ------
original                                                    change
--------                                                    ------
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw      
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw      
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw      #FIXME† Duplicated #1
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw      #FIXME† Duplicated #1

r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw    #FIXME* ∆ rep1 → rep2
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw    #FIXME* ∆ rep1 → rep2
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw    #FIXME* ∆ rep2 → rep1
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw    #FIXME* ∆ rep2 → rep1

--------                                                    ------
original                                                    change
--------                                                    ------
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw     
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw     
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw     #FIXME† Duplicated #2
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw     #FIXME† Duplicated #2

r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw   #FIXME* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw   #FIXME* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw   #FIXME* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw   #FIXME* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw   #FIXME* ∆ rep2 → rep1
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw   #FIXME* ∆ rep2 → rep1

--------                                                    ------
original                                                    change
--------                                                    ------
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw    #FIXME‡ ∆ batch1 → batch2
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw    #FIXME‡ ∆ batch1 → batch2
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw    #FIXME‡ ∆ batch1 → batch2
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw    #FIXME‡ ∆ batch1 → batch2

r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw  #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ batch1 → batch2
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw  #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ batch1 → batch2
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw  #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ batch1 → batch2
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw  #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ batch1 → batch2
```

<i>Updated</i>
```txt
--------                                                    -------                                                      ------
original                                                    updated                                                      assess
--------                                                    -------                                                      ------
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw    #CHECKOK
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw    #CHECKOK
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw    #CHECKOK
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw    #CHECKOK

o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw     OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw   #NOTOK  #TODO 7716 → 6125  #DONEBELOW
o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw     OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw   #NOTOK  #TODO 7716 → 6125  #DONEBELOW
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw     OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw   #NOTOK  #TODO 7718 → 6126  #DONEBELOW
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw     OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw   #NOTOK  #TODO 7718 → 6126  #DONEBELOW

--------                                                    -------                                                      ------
original                                                    updated                                                      assess
--------                                                    -------                                                      ------
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw   Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw   #CHECKOK
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw   Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw   #CHECKOK
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw   Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw   #CHECKOK
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw   Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw   #CHECKOK

o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw    OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw  #NOTOK  #TODO 7716 → 6125  #DONEBELOW
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw    OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw  #NOTOK  #TODO 7716 → 6125  #DONEBELOW
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw    OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw  #NOTOK  #TODO 7718 → 6126  #DONEBELOW
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw    OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw  #NOTOK  #TODO 7718 → 6126  #DONEBELOW

--------                                                    -------                                                      ------
original                                                    updated                                                      assess
--------                                                    -------                                                      ------
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw      WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw          #CHECKOK
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw      WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw          #CHECKOK
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw      WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw          #CHECKOK  #NOCHANGE† Duplicated #1
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw      WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw          #CHECKOK  #NOCHANGE† Duplicated #1

r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw    rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw        #CHECKOK  #DONE* ∆ rep1 → rep2
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw    rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw        #CHECKOK  #DONE* ∆ rep1 → rep2
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw    rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw        #CHECKOK  #DONE* ∆ rep2 → rep1
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw    rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw        #CHECKOK  #DONE* ∆ rep2 → rep1

--------                                                    -------                                                      ------
original                                                    updated                                                      assess
--------                                                    -------                                                      ------
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw     WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw         #CHECKOK
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw     WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw         #CHECKOK
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw     WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw         #CHECKOK  #NOCHANGE† Duplicated #2
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw     WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw         #CHECKOK  #NOCHANGE† Duplicated #2

r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw       #CHECKOK  #DONE* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw       #CHECKOK  #DONE* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw       #CHECKOK  #DONE* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw       #CHECKOK  #DONE* ∆ rep1 → rep2  #OK‡ batch
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw       #CHECKOK  #DONE* ∆ rep2 → rep1
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw       #CHECKOK  #DONE* ∆ rep2 → rep1

--------                                                    -------                                                      ------
original                                                    updated                                                      assess
--------                                                    -------                                                      ------
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw    WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw        #CHECKOK  #DONE‡ ∆ batch1 → batch2
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw    WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw        #CHECKOK  #DONE‡ ∆ batch1 → batch2
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw    WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw        #CHECKOK  #DONE‡ ∆ batch1 → batch2
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw    WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw        #CHECKOK  #DONE‡ ∆ batch1 → batch2

r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw      #CHECKOK  #DONE* ∆ rep1 → rep2  #DONE‡ ∆ batch1 → batch2
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw      #CHECKOK  #DONE* ∆ rep1 → rep2  #DONE‡ ∆ batch1 → batch2
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw      #CHECKOK  #DONE* ∆ rep2 → rep1  #DONE‡ ∆ batch1 → batch2
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw      #CHECKOK  #DONE* ∆ rep2 → rep1  #DONE‡ ∆ batch1 → batch2
```
</details>
<br />

Renaming strategy for <b><u>merged</u></b> datasets from Alison:

<a id="notes-important-1"></a>
#### Notes `#IMPORTANT`
<details>
<summary><i>Notes</i></summary>

<i>Original</i>
```txt
--------                                      -------                                                               ------
original                                      updated                                                               assess
--------                                      -------                                                               ------
mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw    #NOTOK  #TODO 7716-7718 → 6125-6126  #THISISWRONGFIXTHIS
mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw    #NOTOK  #TODO 7716-7718 → 6125-6126  #THISISWRONGFIXTHIS

mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw     OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw   #NOTOK  #TODO 7716-7718 → 6125-6126  #WASALREADYFINE
mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw     OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw   #NOTOK  #TODO 7716-7718 → 6125-6126  #WASALREADYFINE

--------                                      -------                                                               ------
original                                      updated                                                               assess
--------                                      -------                                                               ------
mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw   Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw   #NOTOK  #TODO 7716-7718 → 6125-6126  #THISISWRONGFIXTHIS
mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw   Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw   #NOTOK  #TODO 7716-7718 → 6125-6126  #THISISWRONGFIXTHIS

mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw    OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw  #NOTOK  #TODO 7716-7718 → 6125-6126  #WASALREADYFINE
mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw    OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw  #NOTOK  #TODO 7716-7718 → 6125-6126  #WASALREADYFINE

--------                                      -------                                                               ------
original                                      updated                                                               assess
--------                                      -------                                                               ------
mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw      WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw          #CHECKOK
mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw      WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw          #CHECKOK

mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw    rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw        #CHECKOK
mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw    rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw        #CHECKOK

--------                                      -------                                                               ------
original                                      updated                                                               assess
--------                                      -------                                                               ------
mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw     WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw         #CHECKOK
mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw     WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw         #CHECKOK

mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw     #CHECKOK
mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw   rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw     #CHECKOK

--------                                      -------                                                               ------
original                                      updated                                                               assess
--------                                      -------                                                               ------
mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw    WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw        #CHECKOK
mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw    WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw        #CHECKOK

mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw      #CHECKOK
mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw      #CHECKOK

--------                                      -------                                                               ------
original                                      updated                                                               assess
--------                                      -------                                                               ------
mean_WT_G1_N_.bl-TPM.m.bw                     WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw          #CHECKOK
mean_WT_G1_N_.bl-TPM.p.bw                     WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw          #CHECKOK

mean_WT_G1_SS_.bl-TPM.m.bw                    WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw         #CHECKOK
mean_WT_G1_SS_.bl-TPM.p.bw                    WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw         #CHECKOK

mean_WT_Q_N_.bl-TPM.m.bw                      WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw           #CHECKOK
mean_WT_Q_N_.bl-TPM.p.bw                      WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw           #CHECKOK

mean_WT_Q_SS_.bl-TPM.m.bw                     WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw          #CHECKOK
mean_WT_Q_SS_.bl-TPM.p.bw                     WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw          #CHECKOK
```
</details>
<br />

Now, I need to copy over my Ovation and time course blacklisted BPM datasets:

<a id="code-7"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI" \
    || echo "cd'ing failed; check on this..."

ls -lhaFG ./*
```
</details>
<br />

<a id="printed-7"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI" \
>     || echo "cd'ing failed; check on this..."


❯ ls -lhaFG ./*
./err_out:
total 14M
drwxrws--- 2 kalavatt 33K Jul  4 14:40 ./
drwxrws--- 8 kalavatt 193 Jul 17 16:43 ../
...

./nab3_ostir:
total 1.1G
drwxrws--- 2 kalavatt 1.7K Apr  4 18:00 ./
drwxrws--- 8 kalavatt  193 Jul 17 16:43 ../
-rw-rw---- 1 kalavatt  47M Apr  4 17:40 n3-d_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  47M Apr  4 17:41 n3-d_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  47M Apr  4 17:50 n3-d_Q_N_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  47M Apr  4 17:49 n3-d_Q_N_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  46M Apr  4 17:41 n3-d_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  46M Apr  4 17:41 n3-d_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  46M Apr  4 17:50 n3-d_Q_N_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  46M Apr  4 17:50 n3-d_Q_N_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  49M Apr  4 17:45 n3-d_Q_N_rep3.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  48M Apr  4 17:45 n3-d_Q_N_rep3.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  49M Apr  4 17:54 n3-d_Q_N_rep3.TPM.m.bw
-rw-rw---- 1 kalavatt  48M Apr  4 17:55 n3-d_Q_N_rep3.TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:44 n3-d_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:50 n3-d_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:53 n3-d_Q_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:57 n3-d_Q_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:47 n3-d_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:51 n3-d_Q_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:53 n3-d_Q_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:59 n3-d_Q_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:45 n3-d_Q_SS_rep3.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:50 n3-d_Q_SS_rep3.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:53 n3-d_Q_SS_rep3.TPM.m.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:58 n3-d_Q_SS_rep3.TPM.p.bw
-rw-rw---- 1 kalavatt  35M Apr  4 17:41 o-d_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  34M Apr  4 17:42 o-d_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  35M Apr  4 17:50 o-d_Q_N_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  35M Apr  4 17:51 o-d_Q_N_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  34M Apr  4 17:39 o-d_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  34M Apr  4 17:39 o-d_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  34M Apr  4 17:47 o-d_Q_N_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  34M Apr  4 17:49 o-d_Q_N_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt 7.4M Apr  4 17:44 o-d_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 7.6M Apr  4 17:48 o-d_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 7.4M Apr  4 17:54 o-d_Q_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt 7.7M Apr  4 17:55 o-d_Q_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt 7.3M Apr  4 17:47 o-d_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 7.6M Apr  4 17:51 o-d_Q_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 7.4M Apr  4 17:56 o-d_Q_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt 7.6M Apr  4 18:00 o-d_Q_SS_rep2.TPM.p.bw

./rrp6_wt:
total 1.1G
drwxrws--- 2 kalavatt 2.0K Apr  4 18:05 ./
drwxrws--- 8 kalavatt  193 Jul 17 16:43 ../
-rw-rw---- 1 kalavatt  22M Apr  4 17:46 r6-n_G1_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:44 r6-n_G1_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:59 r6-n_G1_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:56 r6-n_G1_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:40 r6-n_G1_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:38 r6-n_G1_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:52 r6-n_G1_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:49 r6-n_G1_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  40M Apr  4 17:46 r6-n_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  40M Apr  4 17:45 r6-n_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  40M Apr  4 17:55 r6-n_Q_N_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  40M Apr  4 17:55 r6-n_Q_N_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  39M Apr  4 17:38 r6-n_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  39M Apr  4 17:38 r6-n_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  39M Apr  4 17:47 r6-n_Q_N_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  39M Apr  4 17:48 r6-n_Q_N_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  11M Apr  4 17:43 r6-n_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  12M Apr  4 17:49 r6-n_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  11M Apr  4 17:55 r6-n_Q_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  12M Apr  4 17:56 r6-n_Q_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:45 r6-n_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:50 r6-n_Q_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:54 r6-n_Q_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:58 r6-n_Q_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:40 WT_G1_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:39 WT_G1_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:54 WT_G1_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:51 WT_G1_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:40 WT_G1_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:39 WT_G1_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:54 WT_G1_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:51 WT_G1_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:43 WT_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:43 WT_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:53 WT_Q_N_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:51 WT_Q_N_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:45 WT_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:45 WT_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:54 WT_Q_N_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  38M Apr  4 17:54 WT_Q_N_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt 7.9M Apr  4 17:50 WT_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 8.2M Apr  4 17:55 WT_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 8.0M Apr  4 17:59 WT_Q_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt 8.3M Apr  4 18:05 WT_Q_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt 8.3M Apr  4 17:49 WT_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 8.5M Apr  4 17:55 WT_Q_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 8.4M Apr  4 17:59 WT_Q_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt 8.6M Apr  4 18:05 WT_Q_SS_rep2.TPM.p.bw

./timecourse_rrp6_wt:
total 1.2G
drwxrws--- 2 kalavatt 2.9K May  9 12:21 ./
drwxrws--- 8 kalavatt  193 Jul 17 16:43 ../
-rw-rw---- 1 kalavatt  20M Apr  4 17:43 r6-n_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:42 r6-n_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:53 r6-n_DSm2_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:52 r6-n_DSm2_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:43 r6-n_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:44 r6-n_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:55 r6-n_DSm2_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:54 r6-n_DSm2_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:41 r6-n_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:40 r6-n_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:50 r6-n_DSp24_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:49 r6-n_DSp24_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:43 r6-n_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:42 r6-n_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:52 r6-n_DSp24_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  21M Apr  4 17:51 r6-n_DSp24_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  21M Apr  4 17:38 r6-n_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:37 r6-n_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:48 r6-n_DSp2_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:46 r6-n_DSp2_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:45 r6-n_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:44 r6-n_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:55 r6-n_DSp2_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  23M Apr  4 17:54 r6-n_DSp2_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:43 r6-n_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:46 r6-n_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:51 r6-n_DSp48_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:53 r6-n_DSp48_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:43 r6-n_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:40 r6-n_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:52 r6-n_DSp48_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:53 r6-n_DSp48_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:43 WT_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:43 WT_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:55 WT_DSm2_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:54 WT_DSm2_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:44 WT_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:43 WT_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:55 WT_DSm2_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:53 WT_DSm2_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:39 WT_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:39 WT_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:49 WT_DSp24_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:49 WT_DSp24_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:38 WT_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:38 WT_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:46 WT_DSp24_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:45 WT_DSp24_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:38 WT_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:37 WT_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:46 WT_DSp2_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:45 WT_DSp2_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:39 WT_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:39 WT_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:51 WT_DSp2_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:49 WT_DSp2_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:44 WT_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Apr  4 17:43 WT_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:52 WT_DSp48_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  15M Apr  4 17:51 WT_DSp48_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  12M Apr  4 17:42 WT_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:44 WT_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:51 WT_DSp48_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:52 WT_DSp48_SS_rep2.TPM.p.bw

./timecourse_rrp6_wt_size-factor-scaled:
total 594M
drwxrws--- 2 kalavatt 1.9K May  9 12:21 ./
drwxrws--- 8 kalavatt  193 Jul 17 16:43 ../
-rw-rw---- 1 kalavatt  20M May  9 12:16 r6n_DSm2_rep1_tech1_gsf-1.5838222.m.bw
-rw-rw---- 1 kalavatt  20M May  9 12:15 r6n_DSm2_rep1_tech1_gsf-1.5838222.p.bw
-rw-rw---- 1 kalavatt  22M May  9 12:17 r6n_DSm2_rep2_tech1_gsf-1.2963194.m.bw
-rw-rw---- 1 kalavatt  22M May  9 12:16 r6n_DSm2_rep2_tech1_gsf-1.2963194.p.bw
-rw-rw---- 1 kalavatt  17M May  9 12:16 r6n_DSp24_rep1_tech1_gsf-1.1520234.m.bw
-rw-rw---- 1 kalavatt  17M May  9 12:15 r6n_DSp24_rep1_tech1_gsf-1.1520234.p.bw
-rw-rw---- 1 kalavatt  20M May  9 12:16 r6n_DSp24_rep2_tech1_gsf-0.8236362.m.bw
-rw-rw---- 1 kalavatt  21M May  9 12:15 r6n_DSp24_rep2_tech1_gsf-0.8236362.p.bw
-rw-rw---- 1 kalavatt  22M May  9 12:16 r6n_DSp2_rep1_tech1_gsf-1.0055450.m.bw
-rw-rw---- 1 kalavatt  22M May  9 12:15 r6n_DSp2_rep1_tech1_gsf-1.0055450.p.bw
-rw-rw---- 1 kalavatt  22M May  9 12:17 r6n_DSp2_rep2_tech1_gsf-0.9844227.m.bw
-rw-rw---- 1 kalavatt  23M May  9 12:16 r6n_DSp2_rep2_tech1_gsf-0.9844227.p.bw
-rw-rw---- 1 kalavatt  17M May  9 12:16 r6n_DSp48_rep1_tech1_gsf-0.7057575.m.bw
-rw-rw---- 1 kalavatt  17M May  9 12:17 r6n_DSp48_rep1_tech1_gsf-0.7057575.p.bw
-rw-rw---- 1 kalavatt  16M May  9 12:20 r6n_DSp48_rep2_tech1_gsf-0.6738932.m.bw
-rw-rw---- 1 kalavatt  17M May  9 12:17 r6n_DSp48_rep2_tech1_gsf-0.6738932.p.bw
-rw-rw---- 1 kalavatt  19M May  9 12:17 WT_DSm2_rep1_tech1_gsf-1.7599208.m.bw
-rw-rw---- 1 kalavatt  19M May  9 12:16 WT_DSm2_rep1_tech1_gsf-1.7599208.p.bw
-rw-rw---- 1 kalavatt  17M May  9 12:16 WT_DSm2_rep2_tech1_gsf-2.2889032.m.bw
-rw-rw---- 1 kalavatt  17M May  9 12:15 WT_DSm2_rep2_tech1_gsf-2.2889032.p.bw
-rw-rw---- 1 kalavatt  17M May  9 12:16 WT_DSp24_rep1_tech1_gsf-0.8081369.m.bw
-rw-rw---- 1 kalavatt  17M May  9 12:15 WT_DSp24_rep1_tech1_gsf-0.8081369.p.bw
-rw-rw---- 1 kalavatt  17M May  9 12:17 WT_DSp24_rep2_tech1_gsf-0.7898672.m.bw
-rw-rw---- 1 kalavatt  17M May  9 12:15 WT_DSp24_rep2_tech1_gsf-0.7898672.p.bw
-rw-rw---- 1 kalavatt  18M May  9 12:17 WT_DSp2_rep1_tech1_gsf-1.2338584.m.bw
-rw-rw---- 1 kalavatt  18M May  9 12:15 WT_DSp2_rep1_tech1_gsf-1.2338584.p.bw
-rw-rw---- 1 kalavatt  18M May  9 12:17 WT_DSp2_rep2_tech1_gsf-1.1810227.m.bw
-rw-rw---- 1 kalavatt  19M May  9 12:16 WT_DSp2_rep2_tech1_gsf-1.1810227.p.bw
-rw-rw---- 1 kalavatt  14M May  9 12:16 WT_DSp48_rep1_tech1_gsf-0.5904367.m.bw
-rw-rw---- 1 kalavatt  15M May  9 12:17 WT_DSp48_rep1_tech1_gsf-0.5904367.p.bw
-rw-rw---- 1 kalavatt  14M May  9 12:20 WT_DSp48_rep1_tech2_gsf-0.5742435.m.bw
-rw-rw---- 1 kalavatt  15M May  9 12:17 WT_DSp48_rep1_tech2_gsf-0.5742435.p.bw
-rw-rw---- 1 kalavatt  13M May  9 12:15 WT_DSp48_rep2_tech1_gsf-0.8004773.m.bw
-rw-rw---- 1 kalavatt  13M May  9 12:16 WT_DSp48_rep2_tech1_gsf-0.8004773.p.bw

./wt_ovn:
total 1021M
drwxrws--- 2 kalavatt 2.3K Jul  4 14:44 ./
drwxrws--- 8 kalavatt  193 Jul 17 16:43 ../
-rw-rw---- 1 kalavatt  22M Jul  4 14:42 WT_G1_N_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Jul  4 14:43 WT_G1_N_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 13:50 WT_G1_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 13:50 WT_G1_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 12:14 WT_G1_N_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 12:15 WT_G1_N_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  24M Jul  4 14:43 WT_G1_N_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  24M Jul  4 14:43 WT_G1_N_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  24M Apr  4 13:51 WT_G1_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  24M Apr  4 13:50 WT_G1_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  24M Apr  4 12:14 WT_G1_N_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  24M Apr  4 12:13 WT_G1_N_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  15M Jul  4 14:42 WT_G1_SS_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Jul  4 14:42 WT_G1_SS_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  15M Apr  4 13:50 WT_G1_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Apr  4 13:50 WT_G1_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  15M Apr  4 12:14 WT_G1_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  15M Apr  4 12:13 WT_G1_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  16M Jul  4 14:42 WT_G1_SS_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Jul  4 14:42 WT_G1_SS_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 13:49 WT_G1_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Apr  4 13:50 WT_G1_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 12:15 WT_G1_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 12:15 WT_G1_SS_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  37M Jul  4 14:43 WT_Q_N_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  37M Jul  4 14:44 WT_Q_N_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  37M Apr  4 13:50 WT_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  37M Apr  4 13:51 WT_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  37M Apr  4 12:14 WT_Q_N_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  37M Apr  4 12:14 WT_Q_N_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  35M Jul  4 14:43 WT_Q_N_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  35M Jul  4 14:43 WT_Q_N_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  35M Apr  4 13:51 WT_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  35M Apr  4 13:50 WT_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  35M Apr  4 12:13 WT_Q_N_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  35M Apr  4 12:13 WT_Q_N_rep2.TPM.p.bw
-rw-rw---- 1 kalavatt  13M Jul  4 14:42 WT_Q_SS_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Jul  4 14:42 WT_Q_SS_rep1.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  13M Apr  4 13:49 WT_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 13:50 WT_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  13M Apr  4 12:13 WT_Q_SS_rep1.TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 12:13 WT_Q_SS_rep1.TPM.p.bw
-rw-rw---- 1 kalavatt  11M Jul  4 14:41 WT_Q_SS_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.m.bw
-rw-rw---- 1 kalavatt  12M Jul  4 14:42 WT_Q_SS_rep2.bl-rRNA-tRNA-inter-M2-A1-TPM.p.bw
-rw-rw---- 1 kalavatt  11M Apr  4 13:49 WT_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  12M Apr  4 13:49 WT_Q_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  11M Apr  4 12:14 WT_Q_SS_rep2.TPM.m.bw
-rw-rw---- 1 kalavatt  12M Apr  4 12:13 WT_Q_SS_rep2.TPM.p.bw
```
</details>
<br />

I need to copy over the following files:

<a id="printed-8"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
./timecourse_rrp6_wt:
-rw-rw---- 1 kalavatt  20M Apr  4 17:43 r6-n_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:42 r6-n_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:43 r6-n_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:44 r6-n_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:41 r6-n_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:40 r6-n_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:43 r6-n_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  20M Apr  4 17:42 r6-n_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  21M Apr  4 17:38 r6-n_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:37 r6-n_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:45 r6-n_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 17:44 r6-n_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:43 r6-n_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:46 r6-n_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:43 r6-n_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:40 r6-n_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:43 WT_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:43 WT_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:44 WT_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:43 WT_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 17:39 WT_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:39 WT_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:38 WT_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Apr  4 17:38 WT_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:38 WT_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:37 WT_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  18M Apr  4 17:39 WT_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  19M Apr  4 17:39 WT_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  14M Apr  4 17:44 WT_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Apr  4 17:43 WT_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  12M Apr  4 17:42 WT_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 17:44 WT_DSp48_SS_rep2.bl-TPM.p.bw           32


./wt_ovn:
-rw-rw---- 1 kalavatt  22M Apr  4 13:50 WT_G1_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Apr  4 13:50 WT_G1_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  24M Apr  4 13:51 WT_G1_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  24M Apr  4 13:50 WT_G1_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  15M Apr  4 13:50 WT_G1_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Apr  4 13:50 WT_G1_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Apr  4 13:49 WT_G1_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Apr  4 13:50 WT_G1_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  37M Apr  4 13:50 WT_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  37M Apr  4 13:51 WT_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  35M Apr  4 13:51 WT_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  35M Apr  4 13:50 WT_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  13M Apr  4 13:49 WT_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Apr  4 13:50 WT_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  11M Apr  4 13:49 WT_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  12M Apr  4 13:49 WT_Q_SS_rep2.bl-TPM.p.bw               16
```
</details>
<br />

Code for copying over the above files:

<a id="code-8"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

pwd

cp \
    timecourse_rrp6_wt/r6-n_DSm2_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSm2_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSm2_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSm2_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSm2_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSm2_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSm2_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSm2_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp24_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSp24_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp24_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSp24_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp24_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSp24_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp24_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSp24_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp2_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSp2_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp2_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSp2_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp2_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSp2_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp2_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSp2_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp48_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSp48_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp48_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSp48_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp48_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/r6-n_DSp48_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/r6-n_DSp48_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/r6-n_DSp48_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSm2_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSm2_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSm2_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSm2_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSm2_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSm2_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSm2_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSm2_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSp24_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSp24_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSp24_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSp24_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSp24_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSp24_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSp24_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSp24_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSp2_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSp2_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSp2_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSp2_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSp2_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSp2_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSp2_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSp2_SS_rep2.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSp48_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSp48_SS_rep1.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSp48_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSp48_SS_rep1.bl-TPM.p.bw

cp \
    timecourse_rrp6_wt/WT_DSp48_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_DSp48_SS_rep2.bl-TPM.m.bw

cp \
    timecourse_rrp6_wt/WT_DSp48_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_DSp48_SS_rep2.bl-TPM.p.bw

cp \
    wt_ovn/WT_G1_N_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_G1_N_rep1.bl-TPM.m.bw

cp \
    wt_ovn/WT_G1_N_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_G1_N_rep1.bl-TPM.p.bw

cp \
    wt_ovn/WT_G1_N_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_G1_N_rep2.bl-TPM.m.bw

cp \
    wt_ovn/WT_G1_N_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_G1_N_rep2.bl-TPM.p.bw

cp \
    wt_ovn/WT_G1_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_G1_SS_rep1.bl-TPM.m.bw

cp \
    wt_ovn/WT_G1_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_G1_SS_rep1.bl-TPM.p.bw

cp \
    wt_ovn/WT_G1_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_G1_SS_rep2.bl-TPM.m.bw

cp \
    wt_ovn/WT_G1_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_G1_SS_rep2.bl-TPM.p.bw

cp \
    wt_ovn/WT_Q_N_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_Q_N_rep1.bl-TPM.m.bw

cp \
    wt_ovn/WT_Q_N_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_Q_N_rep1.bl-TPM.p.bw

cp \
    wt_ovn/WT_Q_N_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_Q_N_rep2.bl-TPM.m.bw

cp \
    wt_ovn/WT_Q_N_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_Q_N_rep2.bl-TPM.p.bw

cp \
    wt_ovn/WT_Q_SS_rep1.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_Q_SS_rep1.bl-TPM.m.bw

cp \
    wt_ovn/WT_Q_SS_rep1.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_Q_SS_rep1.bl-TPM.p.bw

cp \
    wt_ovn/WT_Q_SS_rep2.bl-TPM.m.bw \
    ../../GEO/bws/individual/WT_Q_SS_rep2.bl-TPM.m.bw

cp \
    wt_ovn/WT_Q_SS_rep2.bl-TPM.p.bw \
    ../../GEO/bws/individual/WT_Q_SS_rep2.bl-TPM.p.bw
```
</details>
<br />

<a id="printed-9"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ pwd
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSm2_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSm2_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSm2_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSm2_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSm2_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSm2_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSm2_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSm2_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSm2_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSm2_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSm2_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSm2_SS_rep2.bl-TPM.m.bw'

 
❯ cp \
>     timecourse_rrp6_wt/r6-n_DSm2_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSm2_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSm2_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSm2_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp24_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSp24_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSp24_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSp24_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp24_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSp24_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSp24_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSp24_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp24_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSp24_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSp24_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSp24_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp24_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSp24_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSp24_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSp24_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp2_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSp2_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSp2_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSp2_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp2_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSp2_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSp2_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSp2_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp2_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSp2_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSp2_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSp2_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp2_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSp2_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSp2_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSp2_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp48_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSp48_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSp48_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSp48_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp48_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSp48_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSp48_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSp48_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp48_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/r6-n_DSp48_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/r6-n_DSp48_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/r6-n_DSp48_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/r6-n_DSp48_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/r6-n_DSp48_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/r6-n_DSp48_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/r6-n_DSp48_SS_rep2.bl-TPM.p.bw'

 
❯ cp \
>     timecourse_rrp6_wt/WT_DSm2_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSm2_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSm2_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSm2_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSm2_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSm2_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSm2_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSm2_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSm2_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSm2_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSm2_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSm2_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSm2_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSm2_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSm2_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSm2_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp24_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSp24_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSp24_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSp24_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp24_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSp24_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSp24_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSp24_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp24_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSp24_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSp24_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSp24_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp24_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSp24_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSp24_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSp24_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp2_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSp2_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSp2_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSp2_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp2_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSp2_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSp2_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSp2_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp2_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSp2_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSp2_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSp2_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp2_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSp2_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSp2_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSp2_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp48_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSp48_SS_rep1.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSp48_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSp48_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp48_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSp48_SS_rep1.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSp48_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSp48_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp48_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_DSp48_SS_rep2.bl-TPM.m.bw
'timecourse_rrp6_wt/WT_DSp48_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_DSp48_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     timecourse_rrp6_wt/WT_DSp48_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_DSp48_SS_rep2.bl-TPM.p.bw
'timecourse_rrp6_wt/WT_DSp48_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_DSp48_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_G1_N_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_G1_N_rep1.bl-TPM.m.bw
'wt_ovn/WT_G1_N_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_G1_N_rep1.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_G1_N_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_G1_N_rep1.bl-TPM.p.bw
'wt_ovn/WT_G1_N_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_G1_N_rep1.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_G1_N_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_G1_N_rep2.bl-TPM.m.bw
'wt_ovn/WT_G1_N_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_G1_N_rep2.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_G1_N_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_G1_N_rep2.bl-TPM.p.bw
'wt_ovn/WT_G1_N_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_G1_N_rep2.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_G1_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_G1_SS_rep1.bl-TPM.m.bw
'wt_ovn/WT_G1_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_G1_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_G1_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_G1_SS_rep1.bl-TPM.p.bw
'wt_ovn/WT_G1_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_G1_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_G1_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_G1_SS_rep2.bl-TPM.m.bw
'wt_ovn/WT_G1_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_G1_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_G1_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_G1_SS_rep2.bl-TPM.p.bw
'wt_ovn/WT_G1_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_G1_SS_rep2.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_Q_N_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_Q_N_rep1.bl-TPM.m.bw
'wt_ovn/WT_Q_N_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_Q_N_rep1.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_Q_N_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_Q_N_rep1.bl-TPM.p.bw
'wt_ovn/WT_Q_N_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_Q_N_rep1.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_Q_N_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_Q_N_rep2.bl-TPM.m.bw
'wt_ovn/WT_Q_N_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_Q_N_rep2.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_Q_N_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_Q_N_rep2.bl-TPM.p.bw
'wt_ovn/WT_Q_N_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_Q_N_rep2.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_Q_SS_rep1.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_Q_SS_rep1.bl-TPM.m.bw
'wt_ovn/WT_Q_SS_rep1.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_Q_SS_rep1.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_Q_SS_rep1.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_Q_SS_rep1.bl-TPM.p.bw
'wt_ovn/WT_Q_SS_rep1.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_Q_SS_rep1.bl-TPM.p.bw'


❯ cp \
>     wt_ovn/WT_Q_SS_rep2.bl-TPM.m.bw \
>     ../../GEO/bws/individual/WT_Q_SS_rep2.bl-TPM.m.bw
'wt_ovn/WT_Q_SS_rep2.bl-TPM.m.bw' -> '../../GEO/bws/individual/WT_Q_SS_rep2.bl-TPM.m.bw'


❯ cp \
>     wt_ovn/WT_Q_SS_rep2.bl-TPM.p.bw \
>     ../../GEO/bws/individual/WT_Q_SS_rep2.bl-TPM.p.bw
'wt_ovn/WT_Q_SS_rep2.bl-TPM.p.bw' -> '../../GEO/bws/individual/WT_Q_SS_rep2.bl-TPM.p.bw'
```
</details>
<br />

Check the BPM time course and Ovation that were copied over:

<a id="code-9"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd ../../GEO/bws/individual || echo "cd'ing failed; check on this..."

ls -lhaFG *bl-TPM.{p,m}.bw

ls *bl-TPM.{p,m}.bw | wc -l

#  Examine everything in the directory
ls -lhaFG
```
</details>
<br />

<a id="printed-10"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ cd ../../GEO/bws/individual || echo "cd'ing failed; check on this..."


❯ ls -lhaFG *bl-TPM.{p,m}.bw
-rw-rw---- 1 kalavatt 20M Jul 20 07:57 r6-n_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 20M Jul 20 07:57 r6-n_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:57 r6-n_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:57 r6-n_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 17M Jul 20 07:57 r6-n_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 17M Jul 20 07:57 r6-n_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 20M Jul 20 07:58 r6-n_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 20M Jul 20 07:58 r6-n_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 21M Jul 20 07:58 r6-n_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:58 r6-n_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:58 r6-n_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:58 r6-n_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 16M Jul 20 07:58 r6-n_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 17M Jul 20 07:58 r6-n_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 16M Jul 20 07:58 r6-n_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 16M Jul 20 07:58 r6-n_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 19M Jul 20 08:03 WT_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 19M Jul 20 08:03 WT_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 16M Jul 20 08:03 WT_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 17M Jul 20 08:03 WT_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 16M Jul 20 08:03 WT_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 17M Jul 20 08:03 WT_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 17M Jul 20 08:03 WT_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 17M Jul 20 08:03 WT_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 18M Jul 20 08:03 WT_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 18M Jul 20 08:03 WT_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 18M Jul 20 08:03 WT_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 19M Jul 20 08:04 WT_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 14M Jul 20 08:04 WT_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 15M Jul 20 08:04 WT_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 12M Jul 20 08:04 WT_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 13M Jul 20 08:04 WT_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:58 WT_G1_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 22M Jul 20 07:58 WT_G1_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 24M Jul 20 07:58 WT_G1_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 24M Jul 20 07:58 WT_G1_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 15M Jul 20 07:58 WT_G1_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 15M Jul 20 07:58 WT_G1_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 16M Jul 20 07:58 WT_G1_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 16M Jul 20 07:58 WT_G1_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 37M Jul 20 07:59 WT_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 37M Jul 20 07:59 WT_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 35M Jul 20 07:59 WT_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 35M Jul 20 07:59 WT_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 13M Jul 20 07:59 WT_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 13M Jul 20 07:59 WT_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt 11M Jul 20 07:59 WT_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt 12M Jul 20 07:59 WT_Q_SS_rep2.bl-TPM.p.bw


❯ ls *bl-TPM.{p,m}.bw | wc -l
48


❯ #  Examine everything in the directory


❯ ls -lhaFG
total 2.2G
drwxrws--- 2 kalavatt 5.2K Jul 20 08:04 ./
drwxrws--- 4 kalavatt   50 Jul 20 07:21 ../
-rw-rw---- 1 kalavatt  47M Apr 26 16:20 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  47M Apr 26 16:25 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:32 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:39 n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  17M May 24 13:12 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  17M May 24 13:30 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  14M May 24 13:44 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  15M May 24 14:04 n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:44 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:48 o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:54 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:59 o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:14 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:27 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:39 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:52 o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:57 r6-n_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:57 r6-n_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:57 r6-n_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:57 r6-n_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:57 r6-n_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:57 r6-n_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:58 r6-n_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:58 r6-n_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  21M Jul 20 07:58 r6-n_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 r6-n_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 r6-n_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 r6-n_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 r6-n_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:58 r6-n_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 r6-n_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 r6-n_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:15 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:24 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:35 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:44 r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  40M May 24 14:42 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  40M May 24 14:46 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  39M May 24 14:53 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  39M May 24 14:58 r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  11M May  5 12:44 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  12M May  5 13:00 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 9.7M May  5 13:13 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 9.9M May  5 13:26 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  13M May  5 13:37 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  13M May  5 13:53 r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:03 WT_DSm2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:03 WT_DSm2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 08:03 WT_DSm2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSm2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 08:03 WT_DSp24_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:04 WT_DSp2_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  14M Jul 20 08:04 WT_DSp48_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Jul 20 08:04 WT_DSp48_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  12M Jul 20 08:04 WT_DSp48_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Jul 20 08:04 WT_DSp48_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  17M May  5 13:57 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  18M May  5 14:06 WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  16M May  5 14:18 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  17M May  5 14:27 WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 WT_G1_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 WT_G1_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  24M Jul 20 07:58 WT_G1_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  24M Jul 20 07:58 WT_G1_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  15M Jul 20 07:58 WT_G1_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  15M Jul 20 07:58 WT_G1_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 WT_G1_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 WT_G1_SS_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:03 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:08 WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:14 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:18 WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 8.0M May  5 14:04 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 8.3M May  5 14:20 WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt 8.4M May  5 14:31 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
-rw-rw---- 1 kalavatt 8.5M May  5 14:50 WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
-rw-rw---- 1 kalavatt  37M Jul 20 07:59 WT_Q_N_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  37M Jul 20 07:59 WT_Q_N_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  35M Jul 20 07:59 WT_Q_N_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  35M Jul 20 07:59 WT_Q_N_rep2.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  13M Jul 20 07:59 WT_Q_SS_rep1.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  13M Jul 20 07:59 WT_Q_SS_rep1.bl-TPM.p.bw
-rw-rw---- 1 kalavatt  11M Jul 20 07:59 WT_Q_SS_rep2.bl-TPM.m.bw
-rw-rw---- 1 kalavatt  12M Jul 20 07:59 WT_Q_SS_rep2.bl-TPM.p.bw
```
</details>
<br />

Scheme for renaming the `*bl-TPM.{p,m}.bw` files:

<a id="notes-important-2"></a>
#### Notes `#IMPORTANT`
<details>
<summary><i>Notes</i></summary>

```txt
--------                                                    -------                                                    -------
original                                                    updated                                                    further
--------                                                    -------                                                    -------
WT_DSm2_SS_rep1.bl-TPM.m.bw                                 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw     #NOTOK  #FIXTC  #DONEBELOW
WT_DSm2_SS_rep1.bl-TPM.p.bw                                 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw     #NOTOK  #FIXTC  #DONEBELOW
WT_DSm2_SS_rep2.bl-TPM.m.bw                                 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw     #NOTOK  #FIXTC  #DONEBELOW
WT_DSm2_SS_rep2.bl-TPM.p.bw                                 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw     #NOTOK  #FIXTC  #DONEBELOW

WT_DSp2_SS_rep1.bl-TPM.m.bw                                 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw     #NOTOK  #FIXTC  #DONEBELOW
WT_DSp2_SS_rep1.bl-TPM.p.bw                                 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw     #NOTOK  #FIXTC  #DONEBELOW
WT_DSp2_SS_rep2.bl-TPM.m.bw                                 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw     #NOTOK  #FIXTC  #DONEBELOW
WT_DSp2_SS_rep2.bl-TPM.p.bw                                 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw     #NOTOK  #FIXTC  #DONEBELOW

WT_DSp24_SS_rep1.bl-TPM.m.bw                                WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw    #NOTOK  #FIXTC  #DONEBELOW
WT_DSp24_SS_rep1.bl-TPM.p.bw                                WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw    #NOTOK  #FIXTC  #DONEBELOW
WT_DSp24_SS_rep2.bl-TPM.m.bw                                WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw    #NOTOK  #FIXTC  #DONEBELOW
WT_DSp24_SS_rep2.bl-TPM.p.bw                                WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw    #NOTOK  #FIXTC  #DONEBELOW

WT_DSp48_SS_rep1.bl-TPM.m.bw                                WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw    #NOTOK  #FIXTC  #DONEBELOW
WT_DSp48_SS_rep1.bl-TPM.p.bw                                WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw    #NOTOK  #FIXTC  #DONEBELOW
WT_DSp48_SS_rep2.bl-TPM.m.bw                                WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw    #NOTOK  #FIXTC  #DONEBELOW
WT_DSp48_SS_rep2.bl-TPM.p.bw                                WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw    #NOTOK  #FIXTC  #DONEBELOW

r6-n_DSm2_SS_rep1.bl-TPM.m.bw                               rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw   #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSm2_SS_rep1.bl-TPM.p.bw                               rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw   #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSm2_SS_rep2.bl-TPM.m.bw                               rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw   #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSm2_SS_rep2.bl-TPM.p.bw                               rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw   #NOTOK  #FIXTC  #DONEBELOW

r6-n_DSp2_SS_rep1.bl-TPM.m.bw                               rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw   #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp2_SS_rep1.bl-TPM.p.bw                               rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw   #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp2_SS_rep2.bl-TPM.m.bw                               rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw   #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp2_SS_rep2.bl-TPM.p.bw                               rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw   #NOTOK  #FIXTC  #DONEBELOW

r6-n_DSp24_SS_rep1.bl-TPM.m.bw                              rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw  #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp24_SS_rep1.bl-TPM.p.bw                              rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw  #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp24_SS_rep2.bl-TPM.m.bw                              rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw  #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp24_SS_rep2.bl-TPM.p.bw                              rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw  #NOTOK  #FIXTC  #DONEBELOW

r6-n_DSp48_SS_rep1.bl-TPM.m.bw                              rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw  #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp48_SS_rep1.bl-TPM.p.bw                              rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw  #NOTOK  #FIXTC  #DONEBELOW
r6-n_DSp48_SS_rep2.bl-TPM.m.bw                              rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw  #NOTOK  #FIXTC  #FIXBATCH  #DONEBELOW
r6-n_DSp48_SS_rep2.bl-TPM.p.bw                              rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw  #NOTOK  #FIXTC  #FIXBATCH  #DONEBELOW

--------                                                    -------                                                    -------
original                                                    updated                                                    further
--------                                                    -------                                                    -------
WT_G1_N_rep1.bl-TPM.m.bw                                    WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw        #NOCHANGE
WT_G1_N_rep1.bl-TPM.p.bw                                    WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw        #NOCHANGE
WT_G1_N_rep2.bl-TPM.m.bw                                    WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw        #NOCHANGE
WT_G1_N_rep2.bl-TPM.p.bw                                    WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw        #NOCHANGE

WT_G1_SS_rep1.bl-TPM.m.bw                                   WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw       #NOCHANGE
WT_G1_SS_rep1.bl-TPM.p.bw                                   WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw       #NOCHANGE
WT_G1_SS_rep2.bl-TPM.m.bw                                   WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw       #NOCHANGE
WT_G1_SS_rep2.bl-TPM.p.bw                                   WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw       #NOCHANGE

WT_Q_N_rep1.bl-TPM.m.bw                                     WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw         #NOCHANGE
WT_Q_N_rep1.bl-TPM.p.bw                                     WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw         #NOCHANGE
WT_Q_N_rep2.bl-TPM.m.bw                                     WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw         #NOCHANGE
WT_Q_N_rep2.bl-TPM.p.bw                                     WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw         #NOCHANGE

WT_Q_SS_rep1.bl-TPM.m.bw                                    WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw        #NOCHANGE
WT_Q_SS_rep1.bl-TPM.p.bw                                    WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw        #NOCHANGE
WT_Q_SS_rep2.bl-TPM.m.bw                                    WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw        #NOCHANGE
WT_Q_SS_rep2.bl-TPM.p.bw                                    WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw        #NOCHANGE
```
</details>
<br />
</details>
<br />

<a id="code-10"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

#  Create arrays for renaming bws: individual replicates ----------------------
unset A_ind; unset a_ind
typeset -A A_ind; typeset -a a_ind
#  From AG
A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw" )
A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw" )
A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )

#  From me
A_ind["WT_DSm2_SS_rep1.bl-TPM.m.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSm2_SS_rep1.bl-TPM.m.bw" )
A_ind["WT_DSm2_SS_rep1.bl-TPM.p.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSm2_SS_rep1.bl-TPM.p.bw" )
A_ind["WT_DSm2_SS_rep2.bl-TPM.m.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSm2_SS_rep2.bl-TPM.m.bw" )
A_ind["WT_DSm2_SS_rep2.bl-TPM.p.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSm2_SS_rep2.bl-TPM.p.bw" )
A_ind["WT_DSp2_SS_rep1.bl-TPM.m.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSp2_SS_rep1.bl-TPM.m.bw" )
A_ind["WT_DSp2_SS_rep1.bl-TPM.p.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSp2_SS_rep1.bl-TPM.p.bw" )
A_ind["WT_DSp2_SS_rep2.bl-TPM.m.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSp2_SS_rep2.bl-TPM.m.bw" )
A_ind["WT_DSp2_SS_rep2.bl-TPM.p.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSp2_SS_rep2.bl-TPM.p.bw" )
A_ind["WT_DSp24_SS_rep1.bl-TPM.m.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSp24_SS_rep1.bl-TPM.m.bw" )
A_ind["WT_DSp24_SS_rep1.bl-TPM.p.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSp24_SS_rep1.bl-TPM.p.bw" )
A_ind["WT_DSp24_SS_rep2.bl-TPM.m.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSp24_SS_rep2.bl-TPM.m.bw" )
A_ind["WT_DSp24_SS_rep2.bl-TPM.p.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSp24_SS_rep2.bl-TPM.p.bw" )
A_ind["WT_DSp48_SS_rep1.bl-TPM.m.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSp48_SS_rep1.bl-TPM.m.bw" )
A_ind["WT_DSp48_SS_rep1.bl-TPM.p.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSp48_SS_rep1.bl-TPM.p.bw" )
A_ind["WT_DSp48_SS_rep2.bl-TPM.m.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSp48_SS_rep2.bl-TPM.m.bw" )
A_ind["WT_DSp48_SS_rep2.bl-TPM.p.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSp48_SS_rep2.bl-TPM.p.bw" )

A_ind["r6-n_DSm2_SS_rep1.bl-TPM.m.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSm2_SS_rep1.bl-TPM.m.bw" )
A_ind["r6-n_DSm2_SS_rep1.bl-TPM.p.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSm2_SS_rep1.bl-TPM.p.bw" )
A_ind["r6-n_DSm2_SS_rep2.bl-TPM.m.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSm2_SS_rep2.bl-TPM.m.bw" )
A_ind["r6-n_DSm2_SS_rep2.bl-TPM.p.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSm2_SS_rep2.bl-TPM.p.bw" )
A_ind["r6-n_DSp2_SS_rep1.bl-TPM.m.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp2_SS_rep1.bl-TPM.m.bw" )
A_ind["r6-n_DSp2_SS_rep1.bl-TPM.p.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp2_SS_rep1.bl-TPM.p.bw" )
A_ind["r6-n_DSp2_SS_rep2.bl-TPM.m.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp2_SS_rep2.bl-TPM.m.bw" )
A_ind["r6-n_DSp2_SS_rep2.bl-TPM.p.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp2_SS_rep2.bl-TPM.p.bw" )
A_ind["r6-n_DSp24_SS_rep1.bl-TPM.m.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp24_SS_rep1.bl-TPM.m.bw" )
A_ind["r6-n_DSp24_SS_rep1.bl-TPM.p.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp24_SS_rep1.bl-TPM.p.bw" )
A_ind["r6-n_DSp24_SS_rep2.bl-TPM.m.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp24_SS_rep2.bl-TPM.m.bw" )
A_ind["r6-n_DSp24_SS_rep2.bl-TPM.p.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp24_SS_rep2.bl-TPM.p.bw" )
A_ind["r6-n_DSp48_SS_rep1.bl-TPM.m.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp48_SS_rep1.bl-TPM.m.bw" )
A_ind["r6-n_DSp48_SS_rep1.bl-TPM.p.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp48_SS_rep1.bl-TPM.p.bw" )
A_ind["r6-n_DSp48_SS_rep2.bl-TPM.m.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp48_SS_rep2.bl-TPM.m.bw" )
A_ind["r6-n_DSp48_SS_rep2.bl-TPM.p.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp48_SS_rep2.bl-TPM.p.bw" )

A_ind["WT_G1_N_rep1.bl-TPM.m.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_G1_N_rep1.bl-TPM.m.bw" )
A_ind["WT_G1_N_rep1.bl-TPM.p.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_G1_N_rep1.bl-TPM.p.bw" )
A_ind["WT_G1_N_rep2.bl-TPM.m.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_G1_N_rep2.bl-TPM.m.bw" )
A_ind["WT_G1_N_rep2.bl-TPM.p.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_G1_N_rep2.bl-TPM.p.bw" )

A_ind["WT_G1_SS_rep1.bl-TPM.m.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_G1_SS_rep1.bl-TPM.m.bw" )
A_ind["WT_G1_SS_rep1.bl-TPM.p.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_G1_SS_rep1.bl-TPM.p.bw" )
A_ind["WT_G1_SS_rep2.bl-TPM.m.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_G1_SS_rep2.bl-TPM.m.bw" )
A_ind["WT_G1_SS_rep2.bl-TPM.p.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_G1_SS_rep2.bl-TPM.p.bw" )

A_ind["WT_Q_N_rep1.bl-TPM.m.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_Q_N_rep1.bl-TPM.m.bw" )
A_ind["WT_Q_N_rep1.bl-TPM.p.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_Q_N_rep1.bl-TPM.p.bw" )
A_ind["WT_Q_N_rep2.bl-TPM.m.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_Q_N_rep2.bl-TPM.m.bw" )
A_ind["WT_Q_N_rep2.bl-TPM.p.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_Q_N_rep2.bl-TPM.p.bw" )

A_ind["WT_Q_SS_rep1.bl-TPM.m.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_Q_SS_rep1.bl-TPM.m.bw" )
A_ind["WT_Q_SS_rep1.bl-TPM.p.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_Q_SS_rep1.bl-TPM.p.bw" )
A_ind["WT_Q_SS_rep2.bl-TPM.m.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_Q_SS_rep2.bl-TPM.m.bw" )
A_ind["WT_Q_SS_rep2.bl-TPM.p.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_Q_SS_rep2.bl-TPM.p.bw" )


#  Create arrays for renaming bws: merged/averaged replicates -----------------
unset A_mean; unset a_mean
typeset -A A_mean; typeset -a a_mean
#  From AG
A_mean["mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw" )
A_mean["mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw" )

A_mean["mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw" )
A_mean["mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw" )

A_mean["mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw" )
A_mean["mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw" )

A_mean["mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw" )
A_mean["mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw" )

A_mean["mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw" )
A_mean["mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw" )

A_mean["mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw" )
A_mean["mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw" )

A_mean["mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw" )
A_mean["mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw" )

A_mean["mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw" )
A_mean["mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw" )

A_mean["mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw"; a_mean+=( "mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw" )
A_mean["mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw"; a_mean+=( "mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw" )

A_mean["mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw"; a_mean+=( "mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw" )
A_mean["mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw"; a_mean+=( "mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw" )

A_mean["mean_WT_G1_N_.bl-TPM.m.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_G1_N_.bl-TPM.m.bw" )
A_mean["mean_WT_G1_N_.bl-TPM.p.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_G1_N_.bl-TPM.p.bw" )

A_mean["mean_WT_G1_SS_.bl-TPM.m.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_G1_SS_.bl-TPM.m.bw" )
A_mean["mean_WT_G1_SS_.bl-TPM.p.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_G1_SS_.bl-TPM.p.bw" )

A_mean["mean_WT_Q_N_.bl-TPM.m.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_Q_N_.bl-TPM.m.bw" )
A_mean["mean_WT_Q_N_.bl-TPM.p.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_Q_N_.bl-TPM.p.bw" )

A_mean["mean_WT_Q_SS_.bl-TPM.m.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_Q_SS_.bl-TPM.m.bw" )
A_mean["mean_WT_Q_SS_.bl-TPM.p.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_Q_SS_.bl-TPM.p.bw" )


#  Run print tests ------------------------------------------------------------
for i in "${a_ind[@]}"; do
    echo """
      key  ${i}
    value  ${A_ind[${i}]}
    """
done

for i in "${a_mean[@]}"; do
    echo """
      key  ${i}
    value  ${A_mean[${i}]}
    """
done


#  Rename the bws -------------------------------------------------------------
cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual" \
    || echo "cd'ing failed; check on this..."

for i in "${a_ind[@]}"; do mv "${i}" "${A_ind[${i}]}"; done

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean" \
    || echo "cd'ing failed; check on this..."

for i in "${a_mean[@]}"; do mv "${i}" "${A_mean[${i}]}"; done

#  Check on the renamed files
cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" \
    || echo "cd'ing failed; check on this..."

ls -lhaFG ./*

ls individual | wc -l
ls mean | wc -l


#  Generate MD5 checksums for the bws -----------------------------------------
cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" \
    || echo "cd'ing failed; check on this..."

[[ ! -d "individual/md5" ]] && mkdir -p "individual/md5"
[[ ! -d "mean/md5" ]] && mkdir -p "mean/md5"

cd individual/ \
    && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt"; done

cd -- ../mean/ \
    && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt"; done

pwd

cat md5/*.txt

cd ../individual/ \
    && cat md5/*.txt
```
</details>
<br />

<details>
<summary><i>Printed</i></summary>

```txt
❯ #  Create arrays for renaming bws: individual replicates ----------------------


❯ unset A_ind; unset a_ind


❯ typeset -A A_ind; typeset -a a_ind


❯ #  From AG
❯ A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw"; a_ind+=( "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw"; a_ind+=( "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw"; a_ind+=( "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw"; a_ind+=( "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw" )
❯ A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw" )
❯ A_ind["r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw"; a_ind+=( "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw" )


❯ #  From me
❯ A_ind["WT_DSm2_SS_rep1.bl-TPM.m.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSm2_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_DSm2_SS_rep1.bl-TPM.p.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSm2_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_DSm2_SS_rep2.bl-TPM.m.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSm2_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_DSm2_SS_rep2.bl-TPM.p.bw"]="WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSm2_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_DSp2_SS_rep1.bl-TPM.m.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSp2_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_DSp2_SS_rep1.bl-TPM.p.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSp2_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_DSp2_SS_rep2.bl-TPM.m.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSp2_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_DSp2_SS_rep2.bl-TPM.p.bw"]="WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSp2_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_DSp24_SS_rep1.bl-TPM.m.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSp24_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_DSp24_SS_rep1.bl-TPM.p.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSp24_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_DSp24_SS_rep2.bl-TPM.m.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSp24_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_DSp24_SS_rep2.bl-TPM.p.bw"]="WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSp24_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_DSp48_SS_rep1.bl-TPM.m.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_DSp48_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_DSp48_SS_rep1.bl-TPM.p.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_DSp48_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_DSp48_SS_rep2.bl-TPM.m.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_DSp48_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_DSp48_SS_rep2.bl-TPM.p.bw"]="WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_DSp48_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSm2_SS_rep1.bl-TPM.m.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSm2_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSm2_SS_rep1.bl-TPM.p.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSm2_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSm2_SS_rep2.bl-TPM.m.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSm2_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSm2_SS_rep2.bl-TPM.p.bw"]="rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSm2_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSp2_SS_rep1.bl-TPM.m.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp2_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSp2_SS_rep1.bl-TPM.p.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp2_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSp2_SS_rep2.bl-TPM.m.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp2_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSp2_SS_rep2.bl-TPM.p.bw"]="rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp2_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSp24_SS_rep1.bl-TPM.m.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp24_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSp24_SS_rep1.bl-TPM.p.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp24_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSp24_SS_rep2.bl-TPM.m.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp24_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSp24_SS_rep2.bl-TPM.p.bw"]="rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp24_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSp48_SS_rep1.bl-TPM.m.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp48_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSp48_SS_rep1.bl-TPM.p.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp48_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["r6-n_DSp48_SS_rep2.bl-TPM.m.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw"; a_ind+=( "r6-n_DSp48_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["r6-n_DSp48_SS_rep2.bl-TPM.p.bw"]="rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw"; a_ind+=( "r6-n_DSp48_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_G1_N_rep1.bl-TPM.m.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_G1_N_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_G1_N_rep1.bl-TPM.p.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_G1_N_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_G1_N_rep2.bl-TPM.m.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_G1_N_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_G1_N_rep2.bl-TPM.p.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_G1_N_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_G1_SS_rep1.bl-TPM.m.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_G1_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_G1_SS_rep1.bl-TPM.p.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_G1_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_G1_SS_rep2.bl-TPM.m.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_G1_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_G1_SS_rep2.bl-TPM.p.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_G1_SS_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_Q_N_rep1.bl-TPM.m.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_Q_N_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_Q_N_rep1.bl-TPM.p.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_Q_N_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_Q_N_rep2.bl-TPM.m.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_Q_N_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_Q_N_rep2.bl-TPM.p.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_Q_N_rep2.bl-TPM.p.bw" )
❯ A_ind["WT_Q_SS_rep1.bl-TPM.m.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw"; a_ind+=( "WT_Q_SS_rep1.bl-TPM.m.bw" )
❯ A_ind["WT_Q_SS_rep1.bl-TPM.p.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw"; a_ind+=( "WT_Q_SS_rep1.bl-TPM.p.bw" )
❯ A_ind["WT_Q_SS_rep2.bl-TPM.m.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw"; a_ind+=( "WT_Q_SS_rep2.bl-TPM.m.bw" )
❯ A_ind["WT_Q_SS_rep2.bl-TPM.p.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw"; a_ind+=( "WT_Q_SS_rep2.bl-TPM.p.bw" )


❯ #  Create arrays for renaming bws: merged/averaged replicates -----------------


❯ unset A_mean; unset a_mean


❯ typeset -A A_mean; typeset -a a_mean


❯ #  From AG
❯ A_mean["mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw" )
❯ A_mean["mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw"]="Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw" )
❯ A_mean["mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw" )
❯ A_mean["mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw"]="OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw" )
❯ A_mean["mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw" )
❯ A_mean["mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw"]="Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw" )
❯ A_mean["mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw" )
❯ A_mean["mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw"]="OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw" )
❯ A_mean["mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw" )
❯ A_mean["mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw"]="WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw" )
❯ A_mean["mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw" )
❯ A_mean["mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw"]="rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw" )
❯ A_mean["mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw"; a_mean+=( "mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw" )
❯ A_mean["mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw"]="WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw"; a_mean+=( "mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw" )
❯ A_mean["mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw" )
❯ A_mean["mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw"]="rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw"; a_mean+=( "mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw" )
❯ A_mean["mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw"; a_mean+=( "mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw" )
❯ A_mean["mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw"]="WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw"; a_mean+=( "mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw" )
❯ A_mean["mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw"; a_mean+=( "mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw" )
❯ A_mean["mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw"]="rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw"; a_mean+=( "mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw" )
❯ A_mean["mean_WT_G1_N_.bl-TPM.m.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_G1_N_.bl-TPM.m.bw" )
❯ A_mean["mean_WT_G1_N_.bl-TPM.p.bw"]="WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_G1_N_.bl-TPM.p.bw" )
❯ A_mean["mean_WT_G1_SS_.bl-TPM.m.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_G1_SS_.bl-TPM.m.bw" )
❯ A_mean["mean_WT_G1_SS_.bl-TPM.p.bw"]="WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_G1_SS_.bl-TPM.p.bw" )
❯ A_mean["mean_WT_Q_N_.bl-TPM.m.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_Q_N_.bl-TPM.m.bw" )
❯ A_mean["mean_WT_Q_N_.bl-TPM.p.bw"]="WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_Q_N_.bl-TPM.p.bw" )
❯ A_mean["mean_WT_Q_SS_.bl-TPM.m.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw"; a_mean+=( "mean_WT_Q_SS_.bl-TPM.m.bw" )
❯ A_mean["mean_WT_Q_SS_.bl-TPM.p.bw"]="WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw"; a_mean+=( "mean_WT_Q_SS_.bl-TPM.p.bw" )


❯ #  Run print tests ------------------------------------------------------------


❯ for i in "${a_ind[@]}"; do
>     echo """
>       key  ${i}
>     value  ${A_ind[${i}]}
>     """
> done
      key  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw

      key  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw

      key  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw

      key  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw

      key  o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw

      key  o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw

      key  o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw

      key  o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw

      key  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw

      key  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw

      key  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw

      key  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw

      key  o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw

      key  o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw

      key  o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw

      key  o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw

      key  WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw

      key  WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw

      key  WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw

      key  WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw

      key  r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw

      key  r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw

      key  r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw

      key  r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw

      key  WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw

      key  WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw

      key  WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw

      key  WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw

      key  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw

      key  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw

      key  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw

      key  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw

      key  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw

      key  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw

      key  WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw

      key  WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw

      key  WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw

      key  WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw

      key  r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw
    value  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw

      key  r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw
    value  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw

      key  r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw
    value  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw

      key  r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw
    value  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw

      key  WT_DSm2_SS_rep1.bl-TPM.m.bw
    value  WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_DSm2_SS_rep1.bl-TPM.p.bw
    value  WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_DSm2_SS_rep2.bl-TPM.m.bw
    value  WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_DSm2_SS_rep2.bl-TPM.p.bw
    value  WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  WT_DSp2_SS_rep1.bl-TPM.m.bw
    value  WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_DSp2_SS_rep1.bl-TPM.p.bw
    value  WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_DSp2_SS_rep2.bl-TPM.m.bw
    value  WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_DSp2_SS_rep2.bl-TPM.p.bw
    value  WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  WT_DSp24_SS_rep1.bl-TPM.m.bw
    value  WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_DSp24_SS_rep1.bl-TPM.p.bw
    value  WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_DSp24_SS_rep2.bl-TPM.m.bw
    value  WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_DSp24_SS_rep2.bl-TPM.p.bw
    value  WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  WT_DSp48_SS_rep1.bl-TPM.m.bw
    value  WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_DSp48_SS_rep1.bl-TPM.p.bw
    value  WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_DSp48_SS_rep2.bl-TPM.m.bw
    value  WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_DSp48_SS_rep2.bl-TPM.p.bw
    value  WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  r6-n_DSm2_SS_rep1.bl-TPM.m.bw
    value  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw

      key  r6-n_DSm2_SS_rep1.bl-TPM.p.bw
    value  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw

      key  r6-n_DSm2_SS_rep2.bl-TPM.m.bw
    value  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw

      key  r6-n_DSm2_SS_rep2.bl-TPM.p.bw
    value  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw

      key  r6-n_DSp2_SS_rep1.bl-TPM.m.bw
    value  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw

      key  r6-n_DSp2_SS_rep1.bl-TPM.p.bw
    value  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw

      key  r6-n_DSp2_SS_rep2.bl-TPM.m.bw
    value  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw

      key  r6-n_DSp2_SS_rep2.bl-TPM.p.bw
    value  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw

      key  r6-n_DSp24_SS_rep1.bl-TPM.m.bw
    value  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw

      key  r6-n_DSp24_SS_rep1.bl-TPM.p.bw
    value  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw

      key  r6-n_DSp24_SS_rep2.bl-TPM.m.bw
    value  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw

      key  r6-n_DSp24_SS_rep2.bl-TPM.p.bw
    value  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw

      key  r6-n_DSp48_SS_rep1.bl-TPM.m.bw
    value  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw

      key  r6-n_DSp48_SS_rep1.bl-TPM.p.bw
    value  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw

      key  r6-n_DSp48_SS_rep2.bl-TPM.m.bw
    value  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw

      key  r6-n_DSp48_SS_rep2.bl-TPM.p.bw
    value  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw

      key  WT_G1_N_rep1.bl-TPM.m.bw
    value  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_G1_N_rep1.bl-TPM.p.bw
    value  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_G1_N_rep2.bl-TPM.m.bw
    value  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_G1_N_rep2.bl-TPM.p.bw
    value  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  WT_G1_SS_rep1.bl-TPM.m.bw
    value  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_G1_SS_rep1.bl-TPM.p.bw
    value  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_G1_SS_rep2.bl-TPM.m.bw
    value  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_G1_SS_rep2.bl-TPM.p.bw
    value  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  WT_Q_N_rep1.bl-TPM.m.bw
    value  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_Q_N_rep1.bl-TPM.p.bw
    value  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_Q_N_rep2.bl-TPM.m.bw
    value  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_Q_N_rep2.bl-TPM.p.bw
    value  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw

      key  WT_Q_SS_rep1.bl-TPM.m.bw
    value  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw

      key  WT_Q_SS_rep1.bl-TPM.p.bw
    value  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw

      key  WT_Q_SS_rep2.bl-TPM.m.bw
    value  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw

      key  WT_Q_SS_rep2.bl-TPM.p.bw
    value  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw


❯ for i in "${a_mean[@]}"; do
>     echo """
>       key  ${i}
>     value  ${A_mean[${i}]}
>     """
> done
      key  mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
    value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw

      key  mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
    value  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw

      key  mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw
    value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw

      key  mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw
    value  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw

      key  mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
    value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw

      key  mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
    value  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw

      key  mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw
    value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw

      key  mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw
    value  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw

      key  mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
    value  WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw

      key  mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
    value  WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw

      key  mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw
    value  rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw

      key  mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw
    value  rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw

      key  mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
    value  WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw

      key  mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
    value  WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw

      key  mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw

      key  mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw
    value  rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw

      key  mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
    value  WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw

      key  mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
    value  WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw

      key  mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw
    value  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw

      key  mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw
    value  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw

      key  mean_WT_G1_N_.bl-TPM.m.bw
    value  WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw

      key  mean_WT_G1_N_.bl-TPM.p.bw
    value  WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw

      key  mean_WT_G1_SS_.bl-TPM.m.bw
    value  WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw

      key  mean_WT_G1_SS_.bl-TPM.p.bw
    value  WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw

      key  mean_WT_Q_N_.bl-TPM.m.bw
    value  WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw

      key  mean_WT_Q_N_.bl-TPM.p.bw
    value  WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw

      key  mean_WT_Q_SS_.bl-TPM.m.bw
    value  WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw

      key  mean_WT_Q_SS_.bl-TPM.p.bw
    value  WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw


❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual" \
>     || echo "cd'ing failed; check on this..."


❯ for i in "${a_ind[@]}"; do mv "${i}" "${A_ind[${i}]}"; done
renamed 'n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw'
renamed 'n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw'
renamed 'n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw'
renamed 'n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw'
renamed 'o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw'
renamed 'o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw'
renamed 'o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw'
renamed 'o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw'
renamed 'n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw'
renamed 'n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw'
renamed 'n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw'
renamed 'n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw'
renamed 'o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw'
renamed 'o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw'
renamed 'o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw'
renamed 'o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw'
renamed 'WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw'
renamed 'WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw'
renamed 'WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw'
renamed 'WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw'
renamed 'r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw'
renamed 'r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw'
renamed 'r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw'
renamed 'r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw'
renamed 'WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw'
renamed 'WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw'
renamed 'WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw'
renamed 'WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw'
renamed 'r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw'
renamed 'r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw'
renamed 'r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_m.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw'
renamed 'r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI_p.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw'
renamed 'r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw'
renamed 'r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw'
renamed 'WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw'
renamed 'WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw'
renamed 'WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw'
renamed 'WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw'
renamed 'r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_m.bw' -> 'rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw'
renamed 'r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI_p.bw' -> 'rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw'
renamed 'r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_m.bw' -> 'rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw'
renamed 'r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI_p.bw' -> 'rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw'
renamed 'WT_DSm2_SS_rep1.bl-TPM.m.bw' -> 'WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_DSm2_SS_rep1.bl-TPM.p.bw' -> 'WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_DSm2_SS_rep2.bl-TPM.m.bw' -> 'WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_DSm2_SS_rep2.bl-TPM.p.bw' -> 'WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'WT_DSp2_SS_rep1.bl-TPM.m.bw' -> 'WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_DSp2_SS_rep1.bl-TPM.p.bw' -> 'WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_DSp2_SS_rep2.bl-TPM.m.bw' -> 'WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_DSp2_SS_rep2.bl-TPM.p.bw' -> 'WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'WT_DSp24_SS_rep1.bl-TPM.m.bw' -> 'WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_DSp24_SS_rep1.bl-TPM.p.bw' -> 'WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_DSp24_SS_rep2.bl-TPM.m.bw' -> 'WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_DSp24_SS_rep2.bl-TPM.p.bw' -> 'WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'WT_DSp48_SS_rep1.bl-TPM.m.bw' -> 'WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_DSp48_SS_rep1.bl-TPM.p.bw' -> 'WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_DSp48_SS_rep2.bl-TPM.m.bw' -> 'WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_DSp48_SS_rep2.bl-TPM.p.bw' -> 'WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'r6-n_DSm2_SS_rep1.bl-TPM.m.bw' -> 'rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw'
renamed 'r6-n_DSm2_SS_rep1.bl-TPM.p.bw' -> 'rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw'
renamed 'r6-n_DSm2_SS_rep2.bl-TPM.m.bw' -> 'rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw'
renamed 'r6-n_DSm2_SS_rep2.bl-TPM.p.bw' -> 'rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw'
renamed 'r6-n_DSp2_SS_rep1.bl-TPM.m.bw' -> 'rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw'
renamed 'r6-n_DSp2_SS_rep1.bl-TPM.p.bw' -> 'rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw'
renamed 'r6-n_DSp2_SS_rep2.bl-TPM.m.bw' -> 'rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw'
renamed 'r6-n_DSp2_SS_rep2.bl-TPM.p.bw' -> 'rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw'
renamed 'r6-n_DSp24_SS_rep1.bl-TPM.m.bw' -> 'rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw'
renamed 'r6-n_DSp24_SS_rep1.bl-TPM.p.bw' -> 'rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw'
renamed 'r6-n_DSp24_SS_rep2.bl-TPM.m.bw' -> 'rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw'
renamed 'r6-n_DSp24_SS_rep2.bl-TPM.p.bw' -> 'rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw'
renamed 'r6-n_DSp48_SS_rep1.bl-TPM.m.bw' -> 'rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw'
renamed 'r6-n_DSp48_SS_rep1.bl-TPM.p.bw' -> 'rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw'
renamed 'r6-n_DSp48_SS_rep2.bl-TPM.m.bw' -> 'rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw'
renamed 'r6-n_DSp48_SS_rep2.bl-TPM.p.bw' -> 'rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw'
renamed 'WT_G1_N_rep1.bl-TPM.m.bw' -> 'WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_G1_N_rep1.bl-TPM.p.bw' -> 'WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_G1_N_rep2.bl-TPM.m.bw' -> 'WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_G1_N_rep2.bl-TPM.p.bw' -> 'WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'WT_G1_SS_rep1.bl-TPM.m.bw' -> 'WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_G1_SS_rep1.bl-TPM.p.bw' -> 'WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_G1_SS_rep2.bl-TPM.m.bw' -> 'WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_G1_SS_rep2.bl-TPM.p.bw' -> 'WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'WT_Q_N_rep1.bl-TPM.m.bw' -> 'WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_Q_N_rep1.bl-TPM.p.bw' -> 'WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_Q_N_rep2.bl-TPM.m.bw' -> 'WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_Q_N_rep2.bl-TPM.p.bw' -> 'WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw'
renamed 'WT_Q_SS_rep1.bl-TPM.m.bw' -> 'WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw'
renamed 'WT_Q_SS_rep1.bl-TPM.p.bw' -> 'WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw'
renamed 'WT_Q_SS_rep2.bl-TPM.m.bw' -> 'WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw'
renamed 'WT_Q_SS_rep2.bl-TPM.p.bw' -> 'WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw'


❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean" \
>     || echo "cd'ing failed; check on this..."


❯ for i in "${a_mean[@]}"; do mv "${i}" "${A_mean[${i}]}"; done
renamed 'mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_n3-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.m.bw' -> 'OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_o-d_Q_day7_tcn_N_aux-T_tc-F__KL.p.bw' -> 'OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_n3-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.m.bw' -> 'OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_o-d_Q_day7_tcn_SS_aux-T_tc-F__KL.p.bw' -> 'OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw' -> 'WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_WT_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw' -> 'WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.m.bw' -> 'rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_r6-n_Q_day8_tcn_N_aux-F_tc-F__KL.p.bw' -> 'rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw' -> 'WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw'
renamed 'mean_WT_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw' -> 'WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw'
renamed 'mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.m.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw'
renamed 'mean_r6-n_Q_day8_tcn_SS_aux-F_tc-F__KL.p.bw' -> 'rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw'
renamed 'mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw' -> 'WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw'
renamed 'mean_WT_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw' -> 'WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw'
renamed 'mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.m.bw' -> 'rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw'
renamed 'mean_r6-n_G1_day1_tcn_SS_aux-F_tc-F__KL.p.bw' -> 'rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw'
renamed 'mean_WT_G1_N_.bl-TPM.m.bw' -> 'WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw'
renamed 'mean_WT_G1_N_.bl-TPM.p.bw' -> 'WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw'
renamed 'mean_WT_G1_SS_.bl-TPM.m.bw' -> 'WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw'
renamed 'mean_WT_G1_SS_.bl-TPM.p.bw' -> 'WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw'
renamed 'mean_WT_Q_N_.bl-TPM.m.bw' -> 'WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw'
renamed 'mean_WT_Q_N_.bl-TPM.p.bw' -> 'WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw'
renamed 'mean_WT_Q_SS_.bl-TPM.m.bw' -> 'WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw'
renamed 'mean_WT_Q_SS_.bl-TPM.p.bw' -> 'WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw'


❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" \
>     || echo "cd'ing failed; check on this..."


❯ ls -lhaFG ./*
./individual:
total 2.2G
drwxrws--- 2 kalavatt 6.4K Jul 20 09:45 ./
drwxrws--- 4 kalavatt   50 Jul 20 07:21 ../
-rw-rw---- 1 kalavatt  47M Apr 26 16:20 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  47M Apr 26 16:25 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:32 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:39 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  17M May 24 13:12 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  17M May 24 13:30 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  14M May 24 13:44 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  15M May 24 14:04 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:44 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:48 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:54 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:59 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:14 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:27 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:39 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:52 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:57 rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:57 rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:58 rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:58 rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  21M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:15 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:24 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:44 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  40M May 24 14:42 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  40M May 24 14:46 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  39M May 24 14:53 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  39M May 24 14:58 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  11M May  5 12:44 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  12M May  5 13:00 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 9.7M May  5 13:13 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt 9.9M May  5 13:26 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  13M May  5 13:37 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  13M May  5 13:53 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:04 WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  14M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  15M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  12M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  13M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  24M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  24M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  15M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  15M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  17M May  5 13:57 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  18M May  5 14:06 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  16M May  5 14:18 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  17M May  5 14:27 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  37M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  37M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  35M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  35M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  13M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  13M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  11M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  12M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:03 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:08 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:14 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:18 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 8.0M May  5 14:04 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 8.3M May  5 14:20 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 8.4M May  5 14:31 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 8.5M May  5 14:50 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw

./mean:
total 1.4G
drwxrws--- 2 kalavatt 2.3K Jul 20 09:47 ./
drwxrws--- 4 kalavatt   50 Jul 20 07:21 ../
-rw-rw---- 1 kalavatt  76M May 24 13:02 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  75M May 24 13:05 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:02 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:05 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  60M May 24 13:04 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  60M May 24 13:07 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  15M May 24 16:03 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  16M May 24 16:06 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  40M May 24 16:10 rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  41M May 24 16:28 rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  69M May 24 16:12 rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  69M May 24 16:29 rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  24M May 24 16:13 rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw
-rw-rw---- 1 kalavatt  24M May 24 16:30 rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw
-rw-rw---- 1 kalavatt  40M May 24 13:04 WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  40M May 24 13:10 WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  28M May 24 13:05 WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  29M May 24 13:11 WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:19 WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:37 WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  64M May 24 13:07 WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  64M May 24 13:13 WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  24M May 24 13:08 WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  25M May 24 13:14 WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  67M May 24 16:21 WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  68M May 24 16:38 WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  17M May 24 16:22 WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  18M May 24 16:39 WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw


❯ ls individual | wc -l
90


❯ ls mean | wc -l
28


❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" \
>     || echo "cd'ing failed; check on this..."


❯ [[ ! -d "individual/md5" ]] && mkdir -p "individual/md5"
mkdir: created directory 'individual/md5'


❯ [[ ! -d "mean/md5" ]] && mkdir -p "mean/md5"
mkdir: created directory 'mean/md5'


❯ cd individual/ \
>     && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt"; done
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual


❯ cd -- ../mean/ \
>     && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt" ; done


❯ pwd
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean


#MD5  #DONOTUSE  #UPDATEDBELOW
❯ cat md5/*.txt
f97c5652534a5ba770d4ee0669f5cc98  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
62942248e7cb347faca88a55b389be0e  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
75d3b4bd99ce785cfb63d1afd3bedf72  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
bc4682a980bdda5e2c2e43c76a43486b  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
a30ecded93d3d5b6c52829875a87bb17  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
bf53ff770c7a3df4f4c3ad3d34380ec3  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
0728258928b29efcef8b23e1ed518ba0  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
e1edffc2dfd6b24f05c99f463376b293  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
87543f664aadae9f0898290419016153  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw
22d930759ad6cf16048a72adc8fb5dd1  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw
e14e57b658fc4addad1a6105a6fb0750  rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw
fa6b515071369d128ae263a9dcd7f07a  rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw
4b0f5fbb12d93e04c204bc40a955fd06  rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw
d6933acc7e94f1acb223edd4cde72add  rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw
d2b01f664103b076163c888676ba9afa  WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
208ac27bd98a9f739370630f4a6ed588  WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
ecc60f4fc4317b223a156d7da0daf111  WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
242ca86a36be6bb6d763d93e8f94efc1  WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
8cd753b7ae40f7434ff381a4480de7a9  WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw
95445c8df96460044c9c0039d526f40e  WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw
f2cd4ea666de6c8847b02737c8d92e29  WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
f77e2144fc32818af5b557b82bae6d2e  WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
8f00bf9e3d9b5f8e2b3db520cb4a0cff  WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
51cd92a2352fe821385ffba6b89e5994  WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
2566cf2597c0470ac9ac9ac268083af8  WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
2e0720de0bbc21d5b81688fb860d9dd6  WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
1138b55f42cbadea25f663346900d6e7  WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
a7cf965f741772f30ba44e325f80b79d  WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw


#MD5  #DONOTUSE  #UPDATEDBELOW
❯ cd ../individual/ \
>     && cat md5/*.txt
a71050a29ad234e2b035e19ee64fe076  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
416fb9fb8bfa995b8f2f222a6cd3bfe5  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
8c0040ca02727ea8ef54aeae73db670a  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
d013697fcc6b58bc8535755c68787c49  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
24fbcf7d69b767561e65c3666e98594e  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
a1f289e80c10496901a7c5b5debf34df  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
39ae5b48e93fb3f60c81aa9e747b150f  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
7886545d2eeb2ae9fe077aed900c45d2  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
06e66d3e77b5ff3ccfe82230f7ebbfa3  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
3bfd3cec5c0b9c2bdd5e655dbac8c7f8  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
294756862f2ce5417e92fc5999267414  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
48ae58058ffd52bfa6599e8d054b5c99  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
c8e527236977b8546db06fb3734bed87  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
4e4039122b19abd8b040dd5394382a16  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
27d5abcbbabbb80ff074883e583b8873  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
80b8dc9b27f2eca2358f9ec2a20a6053  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
6cd88381bdb05c6932580922e1a88183  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
58ac9a536e7739e4f94e1d3ffecf50c3  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
0e56a32bc036c4f16bb0d3012d66d144  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
26e1f6b38a3bc6404eeb34feba032ab5  rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
a6d0d147c60e1741b9ed1ac3898a7b7c  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
fbe923f842eb230164081b12a42d48bf  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
72f1d5beb58920e37d41dbcd0f2f901e  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
e74818fb8252a97071062d47cb99eef9  rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
bd095b21af45ef229d4fdb40e97bcacb  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
ae672ca9ddb05147e34015f93425cd4a  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
62077015b81c38ee6f85c247ea67bacd  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
7676a7cd4ad2d8ed5a5915d8823d064e  rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
30fa748fdf40deaa50fadfd5133fc07c  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw
3c26935e77efcf2c6333f05e48323a66  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw
bd288bd0ccf44635728c257e4e7b0bc9  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw
08e2b1f8ac7a2b295dfaf13bf22d94d8  rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw
823013914d41636ae0fa37f8146f355f  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
dd5534db4aa1a6e2754370ed480e32fb  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
d9c40d14ec905154b5347e9f9d302ad8  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw
e85eb540c3707d77cecf11ee4c9eed8b  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw
c4be74a0cb9fedaf60fea079ceea3ad0  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
ecb1b6772ae9b69d8ae14a221440b108  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
f27be34a31cb3214b68356803098609b  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
d20fa998e1b61d72d87c1ae73f4d09ad  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
d8fdd0f8d7a1d427ea42601503be693c  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
cba3b4fc580b0175abfdc9c251d23609  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
7a2a727853b305f1b0431f50e7024385  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
f596a3c079593d5d4e73f0ec1187490c  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
b322dc0feca84023ad0cbdf20f2b7f27  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
4af8ee2e9fe60a35d2a7d27fe147d761  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
a23b854a9b1ae6eaa6fd9545f0b90253  WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
aeecb9d438fae889925230a62394278e  WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
9d095fc70811ec3e3eafdf0d68b3068d  WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
f5da85c301a99bd3c1f2f9bbf3cee894  WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
3cc40cbce04ae053eac79d24fca8cbca  WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
af8f570bf51a8615419bb8f204f15776  WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
d2e730dcdef497280b7ce05cfaad7a42  WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
9164efe3d4e1aaf30b1f406e4c6a94d0  WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
b73b1c248c5c7fd74213d558bb567ade  WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
8af941ee92db56aab8dc0630c6e19659  WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
a3d316cfb38625b84e733e4fde849867  WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
4b0d18923613c38bd808823954a977e4  WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
7b0696d331bd549ebcc2282ae7ecb2c1  WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
c02d42e7bceaa3ee48f72643deefcd01  WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
e258ae3ffb73e0d49388e707e5f5c9c8  WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
165b021a11259e925adac3102c64914f  WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
154d2f36714a338c7a30a265480bb7bd  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
dacff5b198846dc57b806a357cdd34d7  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
3b79b5eafa8132087b4c06f2fc3a07a9  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
5c57985d91120c55859c55be4763c9ab  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
fff9e994511a2d5db2430107ceba9ed2  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
34d9c5433c0327d33dde544d60091cc4  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
2c9a84eae42bfc25b88b9782dc643b82  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
37bc03196242e0fd88e16bc471d2e64a  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
b22f4be412adbec28a85625a9fd42c64  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw
815429b06c6807f73d45dd9a0dee30d5  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw
bdbeb14e160f5995e8c68b3a93adab46  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw
0b6482b3ba15690f6ae84f2fa9a70f1e  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw
06dc4fa9b4f998044db1393613acc4ce  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
921934797abc89bca60a72591c88968d  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
7a5f10460260b8094d7949687cf767ba  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
90ca7db51d3faa843daf4c5cbe138b7b  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
5954c14c5c793d902d9da293488c3d02  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
c01d1791ff8b8f41ead8c7247e6e03b4  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
eb70a157bf95f31a823956b79496ab85  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
295e9dc83d43b96898b450ee69e6c84a  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
f2139889149a37f9201631cd6b9403d2  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
48d373e3b519461e7d341725edf9edce  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
dfc0c90da7b8a7caa2ab5b7c69bf4b34  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
9ed704ff9a2e3d2ab8b8b6776d9d4533  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
5a634ff35cdd55768001ac1d2bcc3fac  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
c07f8acfe7d32079910b687af59e6501  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
ed56c83c3838357b376226539199286a  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
5f53ca9ebab67842668b5ff86808fa3d  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
```
</details>
<br />

<a id="correct-misnamed-files"></a>
### Correct misnamed files
<a id="code-11"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" \
    || echo "cd'ing failed; check on this..."


#  Correct file name errors in the above --------------------------------------
#  Individual replicates, KLSC ----------------------------
mv \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw \
    individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw

mv \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw \
    individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw


#  Averaged replicates, KLSC ------------------------------
mv \
    mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
    mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw

mv \
    mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
    mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw

mv \
    mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
    mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw

mv \
    mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
    mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw

mv \
    mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
    mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw

mv \
    mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
    mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw

mv \
    mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
    mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw

mv \
    mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
    mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw


#  Individual replicates, BPM -----------------------------
mv \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw

mv \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw

mv \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw

mv \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
    individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw

mv \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw

mv \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw

mv \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw

mv \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
    individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw

mv \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw

mv \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw

mv \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw

mv \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
    individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw

mv \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw

mv \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw

mv \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw

mv \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
    individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw

mv \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw

mv \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw

mv \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw

mv \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
    individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw

mv \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw

mv \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw

mv \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw

mv \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
    individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw

mv \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw

mv \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw

mv \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw

mv \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
    individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw

mv \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw

mv \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw

mv \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw

mv \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
    individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw


#  Fixing above mistakes for "averaged replicates, BPM" ---
cd mean || echo "cd'ing failed; check on this..."

mv \
    Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw \
    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw

mv \
    Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw \
    Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw

mv \
    Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw \
    Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw

mv \
    Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw \
    Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw


#  Check on the changes made --------------------------------------------------
cd .. && ls -lhaFG ./*


#  After the changes, regenerate MD5 checksums for the bws --------------------
cd individual/ && rmr md5/ && .. && cd mean/ && rmr md5/ && ..

mkdir -p {individual,mean}/md5

cd individual/ && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt"; done && ..
cd mean/ && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt"; done && ..

cat individual/md5/*.txt
cat mean/md5/*.txt
```
</details>
<br />

<a id="printed-11"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws" \
>     || echo "cd'ing failed; check on this..."


❯ #  Correct file name errors in the above --------------------------------------


❯ #  Individual replicates, KLSC ------------------


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw \
>     individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw'


❯ mv \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw \
>     individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
renamed 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw' -> 'individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw'


❯ #  Averaged replicates, KLSC --------------------


❯ mv \
>     mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
>     mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
renamed 'mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw' -> 'mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw'


❯ mv \
>     mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
>     mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
renamed 'mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw' -> 'mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw'


❯ mv \
>     mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
>     mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
renamed 'mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw' -> 'mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw'


❯ mv \
>     mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
>     mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
renamed 'mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw' -> 'mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw'


❯ mv \
>     mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
>     mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
renamed 'mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw' -> 'mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw'


❯ mv \
>     mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
>     mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
renamed 'mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw' -> 'mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw'


❯ mv \
>     mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw \
>     mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
renamed 'mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw' -> 'mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw'


❯ mv \
>     mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw \
>     mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
renamed 'mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw' -> 'mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw'


❯ #  Individual replicates, BPM -------------------


❯ mv \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
renamed 'individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw' -> 'individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
renamed 'individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw' -> 'individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
renamed 'individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw' -> 'individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
>     individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
renamed 'individual/WT_DSm2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw' -> 'individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
renamed 'individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw' -> 'individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
renamed 'individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw' -> 'individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
renamed 'individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw' -> 'individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
>     individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
renamed 'individual/WT_DSp2_day2_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw' -> 'individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
renamed 'individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw' -> 'individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
renamed 'individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw' -> 'individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
renamed 'individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw' -> 'individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
>     individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
renamed 'individual/WT_DSp24_day3_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw' -> 'individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
renamed 'individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw' -> 'individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
renamed 'individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw' -> 'individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
renamed 'individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw' -> 'individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw \
>     individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
renamed 'individual/WT_DSp48_day4_tcn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw' -> 'individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
renamed 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw' -> 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
renamed 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw' -> 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
renamed 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw' -> 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
>     individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
renamed 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw' -> 'individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
renamed 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw' -> 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
renamed 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw' -> 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
renamed 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw' -> 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
>     individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
renamed 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw' -> 'individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
renamed 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw' -> 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
renamed 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw' -> 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
renamed 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw' -> 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
>     individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
renamed 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw' -> 'individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
renamed 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_m.bw' -> 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
renamed 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7078_rep2_batch1.BPM_p.bw' -> 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw'


❯ mv \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw
renamed 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_m.bw' -> 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw'


❯ mv \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw \
>     individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw
renamed 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcF_7079_rep1_batch1.BPM_p.bw' -> 'individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw'


❯ #  Fix mistakes for "averaged replicates, KLSC", etc. ---


❯ cd mean || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean


❯ mv \
>     Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw \
>     Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
renamed 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw'


❯ mv \
>     Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw \
>     Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
renamed 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw' -> 'Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw'


❯ mv \
>     Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw \
>     Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
renamed 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw'


❯ mv \
>     Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw \
>     Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
renamed 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw' -> 'Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw'


❯ #  Check on the changes made --------------------------------------------------


❯ cd .. && ❯ ls -lhaFG ./*
./individual:
total 2.2G
drwxrws--- 3 kalavatt 6.4K Jul 21 09:17 ./
drwxrws--- 4 kalavatt   50 Jul 20 07:21 ../
drwxrws--- 2 kalavatt 6.9K Jul 20 10:44 md5/
-rw-rw---- 1 kalavatt  47M Apr 26 16:20 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  47M Apr 26 16:25 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:32 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  46M Apr 26 16:39 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  17M May 24 13:12 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  17M May 24 13:30 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  14M May 24 13:44 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  15M May 24 14:04 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:44 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  35M Apr 26 16:48 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:54 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  34M Apr 26 16:59 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:14 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:27 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 7.4M May 24 14:39 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 7.7M May 24 14:52 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:57 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:57 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:57 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:58 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  20M Jul 20 07:58 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  21M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:15 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:24 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  22M May  5 13:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  22M May  5 13:44 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  40M May 24 14:42 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  40M May 24 14:46 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  39M May 24 14:53 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  39M May 24 14:58 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  11M May  5 12:44 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  12M May  5 13:00 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 9.7M May  5 13:13 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt 9.9M May  5 13:26 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  13M May  5 13:37 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  13M May  5 13:53 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  17M Jul 20 08:03 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  18M Jul 20 08:03 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  19M Jul 20 08:04 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  14M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  15M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  12M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  13M Jul 20 08:04 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  22M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  24M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  24M Jul 20 07:58 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  15M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  15M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  16M Jul 20 07:58 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  17M May  5 13:57 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  18M May  5 14:06 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  16M May  5 14:18 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  17M May  5 14:27 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  37M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  37M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  35M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  35M Jul 20 07:59 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  13M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  13M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  11M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  12M Jul 20 07:59 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:03 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:08 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  38M May 24 15:14 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  38M May 24 15:18 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 8.0M May  5 14:04 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 8.3M May  5 14:20 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt 8.4M May  5 14:31 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt 8.5M May  5 14:50 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw

./mean:
total 1.4G
drwxrws--- 3 kalavatt 2.3K Jul 21 09:09 ./
drwxrws--- 4 kalavatt   50 Jul 20 07:21 ../
drwxrws--- 2 kalavatt 2.4K Jul 20 10:46 md5/
-rw-rw---- 1 kalavatt  76M May 24 13:02 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  75M May 24 13:05 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:02 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:05 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  60M May 24 13:04 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  60M May 24 13:07 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  15M May 24 16:03 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  16M May 24 16:06 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  40M May 24 16:10 rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  41M May 24 16:28 rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  69M May 24 16:12 rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  69M May 24 16:29 rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  24M May 24 16:13 rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw
-rw-rw---- 1 kalavatt  24M May 24 16:30 rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw
-rw-rw---- 1 kalavatt  40M May 24 13:04 WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  40M May 24 13:10 WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  28M May 24 13:05 WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  29M May 24 13:11 WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  30M May 24 16:19 WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw
-rw-rw---- 1 kalavatt  31M May 24 16:37 WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw
-rw-rw---- 1 kalavatt  64M May 24 13:07 WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  64M May 24 13:13 WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  24M May 24 13:08 WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw---- 1 kalavatt  25M May 24 13:14 WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw---- 1 kalavatt  67M May 24 16:21 WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  68M May 24 16:38 WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
-rw-rw---- 1 kalavatt  17M May 24 16:22 WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
-rw-rw---- 1 kalavatt  18M May 24 16:39 WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw


❯ #  After the changes, regenerate MD5 checksums for the bws --------------------


❯ cd individual/ && rmr md5/ && .. && cd mean/ && rmr md5/ && ..
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/mean


❯ cd individual/ && for i in *.bw; do md5sum "${i}" > "md5/${i%.bw}.md5.txt"; done && ..
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO/bws/individual


#MD5
❯ cat individual/md5/*.txt
a71050a29ad234e2b035e19ee64fe076  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
416fb9fb8bfa995b8f2f222a6cd3bfe5  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
8c0040ca02727ea8ef54aeae73db670a  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
d013697fcc6b58bc8535755c68787c49  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
24fbcf7d69b767561e65c3666e98594e  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
a1f289e80c10496901a7c5b5debf34df  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
39ae5b48e93fb3f60c81aa9e747b150f  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
7886545d2eeb2ae9fe077aed900c45d2  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
06e66d3e77b5ff3ccfe82230f7ebbfa3  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
3bfd3cec5c0b9c2bdd5e655dbac8c7f8  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
294756862f2ce5417e92fc5999267414  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
48ae58058ffd52bfa6599e8d054b5c99  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
c8e527236977b8546db06fb3734bed87  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
4e4039122b19abd8b040dd5394382a16  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
27d5abcbbabbb80ff074883e583b8873  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
80b8dc9b27f2eca2358f9ec2a20a6053  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
6cd88381bdb05c6932580922e1a88183  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
58ac9a536e7739e4f94e1d3ffecf50c3  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
0e56a32bc036c4f16bb0d3012d66d144  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
26e1f6b38a3bc6404eeb34feba032ab5  rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
a6d0d147c60e1741b9ed1ac3898a7b7c  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
fbe923f842eb230164081b12a42d48bf  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
72f1d5beb58920e37d41dbcd0f2f901e  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
e74818fb8252a97071062d47cb99eef9  rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
bd095b21af45ef229d4fdb40e97bcacb  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
ae672ca9ddb05147e34015f93425cd4a  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
62077015b81c38ee6f85c247ea67bacd  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
7676a7cd4ad2d8ed5a5915d8823d064e  rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
30fa748fdf40deaa50fadfd5133fc07c  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
3c26935e77efcf2c6333f05e48323a66  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
bd288bd0ccf44635728c257e4e7b0bc9  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw
08e2b1f8ac7a2b295dfaf13bf22d94d8  rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw
823013914d41636ae0fa37f8146f355f  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
dd5534db4aa1a6e2754370ed480e32fb  rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
d9c40d14ec905154b5347e9f9d302ad8  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw
e85eb540c3707d77cecf11ee4c9eed8b  rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw
c4be74a0cb9fedaf60fea079ceea3ad0  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
ecb1b6772ae9b69d8ae14a221440b108  rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
f27be34a31cb3214b68356803098609b  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
d20fa998e1b61d72d87c1ae73f4d09ad  rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
d8fdd0f8d7a1d427ea42601503be693c  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
cba3b4fc580b0175abfdc9c251d23609  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
7a2a727853b305f1b0431f50e7024385  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
f596a3c079593d5d4e73f0ec1187490c  rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
b322dc0feca84023ad0cbdf20f2b7f27  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
4af8ee2e9fe60a35d2a7d27fe147d761  rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
a23b854a9b1ae6eaa6fd9545f0b90253  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
aeecb9d438fae889925230a62394278e  WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
9d095fc70811ec3e3eafdf0d68b3068d  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
f5da85c301a99bd3c1f2f9bbf3cee894  WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
3cc40cbce04ae053eac79d24fca8cbca  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
af8f570bf51a8615419bb8f204f15776  WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
d2e730dcdef497280b7ce05cfaad7a42  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
9164efe3d4e1aaf30b1f406e4c6a94d0  WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
b73b1c248c5c7fd74213d558bb567ade  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
8af941ee92db56aab8dc0630c6e19659  WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
a3d316cfb38625b84e733e4fde849867  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
4b0d18923613c38bd808823954a977e4  WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
7b0696d331bd549ebcc2282ae7ecb2c1  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
c02d42e7bceaa3ee48f72643deefcd01  WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
e258ae3ffb73e0d49388e707e5f5c9c8  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
165b021a11259e925adac3102c64914f  WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
154d2f36714a338c7a30a265480bb7bd  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
dacff5b198846dc57b806a357cdd34d7  WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
3b79b5eafa8132087b4c06f2fc3a07a9  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
5c57985d91120c55859c55be4763c9ab  WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
fff9e994511a2d5db2430107ceba9ed2  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
34d9c5433c0327d33dde544d60091cc4  WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
2c9a84eae42bfc25b88b9782dc643b82  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
37bc03196242e0fd88e16bc471d2e64a  WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
b22f4be412adbec28a85625a9fd42c64  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw
815429b06c6807f73d45dd9a0dee30d5  WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw
bdbeb14e160f5995e8c68b3a93adab46  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw
0b6482b3ba15690f6ae84f2fa9a70f1e  WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw
06dc4fa9b4f998044db1393613acc4ce  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
921934797abc89bca60a72591c88968d  WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
7a5f10460260b8094d7949687cf767ba  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
90ca7db51d3faa843daf4c5cbe138b7b  WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
5954c14c5c793d902d9da293488c3d02  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
c01d1791ff8b8f41ead8c7247e6e03b4  WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
eb70a157bf95f31a823956b79496ab85  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
295e9dc83d43b96898b450ee69e6c84a  WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
f2139889149a37f9201631cd6b9403d2  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
48d373e3b519461e7d341725edf9edce  WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
dfc0c90da7b8a7caa2ab5b7c69bf4b34  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
9ed704ff9a2e3d2ab8b8b6776d9d4533  WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
5a634ff35cdd55768001ac1d2bcc3fac  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
c07f8acfe7d32079910b687af59e6501  WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
ed56c83c3838357b376226539199286a  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
5f53ca9ebab67842668b5ff86808fa3d  WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw


#MD5
❯ cat mean/md5/*.txt
f97c5652534a5ba770d4ee0669f5cc98  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
62942248e7cb347faca88a55b389be0e  Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
75d3b4bd99ce785cfb63d1afd3bedf72  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
bc4682a980bdda5e2c2e43c76a43486b  Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
a30ecded93d3d5b6c52829875a87bb17  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
bf53ff770c7a3df4f4c3ad3d34380ec3  OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
0728258928b29efcef8b23e1ed518ba0  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
e1edffc2dfd6b24f05c99f463376b293  OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
87543f664aadae9f0898290419016153  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw
22d930759ad6cf16048a72adc8fb5dd1  rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw
e14e57b658fc4addad1a6105a6fb0750  rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw
fa6b515071369d128ae263a9dcd7f07a  rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw
4b0f5fbb12d93e04c204bc40a955fd06  rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw
d6933acc7e94f1acb223edd4cde72add  rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw
d2b01f664103b076163c888676ba9afa  WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
208ac27bd98a9f739370630f4a6ed588  WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
ecc60f4fc4317b223a156d7da0daf111  WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
242ca86a36be6bb6d763d93e8f94efc1  WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
8cd753b7ae40f7434ff381a4480de7a9  WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw
95445c8df96460044c9c0039d526f40e  WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw
f2cd4ea666de6c8847b02737c8d92e29  WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
f77e2144fc32818af5b557b82bae6d2e  WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
8f00bf9e3d9b5f8e2b3db520cb4a0cff  WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
51cd92a2352fe821385ffba6b89e5994  WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
2566cf2597c0470ac9ac9ac268083af8  WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
2e0720de0bbc21d5b81688fb860d9dd6  WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
1138b55f42cbadea25f663346900d6e7  WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
a7cf965f741772f30ba44e325f80b79d  WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
```
</details>
<br />
<br />

<a id="visualizeassess-the-geo-directory-structure"></a>
## Visualize/assess the `GEO/` directory structure
<a id="code-12"></a>
### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO" \
    || echo "cd'ing failed; check on this..."

tree .

find bams/standard-analyses/ -type f -name "*.bam" | wc -l
find bams/transcriptome-assembly/ -type f -name "*.bam" | wc -l
find bws/individual/ -type f -name "*.bw" | wc -l
find bws/mean/ -type f -name "*.bw" | wc -l
find fastqs/ -type f -name "*.fq.gz" | wc -l
find gtfs/ -type f \( -name "*.gff3" -o -name "*.gtf" \) | wc -l
find matrices/ -type f -name "*.tsv" | wc -l

cd ..
du -cshl GEO/

echo $(( 46 + 4 + 90 + 28 + 138 + 8 + 7 ))
```
</details>
<br />

<a id="printed-12"></a>
### Printed
<details>
<summary><i>Printed</i></summary>

```txt
❯ cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO" \
>     || echo "cd'ing failed; check on this..."


❯ tree .
.
├── bams
│    ├── standard-analyses
│    │    ├── md5
│    │    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.md5.txt
│    │    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.md5.txt
│    │    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.md5.txt
│    │    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.md5.txt
│    │    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt
│    │    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt
│    │    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.md5.txt
│    │    │    └── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
│    │    └── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
│    └── transcriptome-assembly
│        ├── md5
│        │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt
│        │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt
│        │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt
│        │    └── WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.md5.txt
│        ├── WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
│        ├── WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
│        ├── WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
│        └── WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
├── bws
│    ├── individual
│    │    ├── md5
│    │    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.md5.txt
│    │    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.md5.txt
│    │    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.md5.txt
│    │    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.md5.txt
│    │    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.md5.txt
│    │    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.md5.txt
│    │    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.md5.txt
│    │    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.md5.txt
│    │    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.md5.txt
│    │    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.md5.txt
│    │    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.md5.txt
│    │    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.md5.txt
│    │    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.md5.txt
│    │    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.md5.txt
│    │    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.md5.txt
│    │    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.md5.txt
│    │    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.md5.txt
│    │    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.md5.txt
│    │    │    └── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
│    │    └── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
│    └── mean
│        ├── md5
│        │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.md5.txt
│        │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.md5.txt
│        │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.md5.txt
│        │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.md5.txt
│        │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.md5.txt
│        │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.md5.txt
│        │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.md5.txt
│        │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.md5.txt
│        │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.md5.txt
│        │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.md5.txt
│        │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.md5.txt
│        │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.md5.txt
│        │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.md5.txt
│        │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.md5.txt
│        │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.md5.txt
│        │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.md5.txt
│        │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.md5.txt
│        │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.md5.txt
│        │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.md5.txt
│        │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.md5.txt
│        │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.md5.txt
│        │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.md5.txt
│        │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.md5.txt
│        │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.md5.txt
│        │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.md5.txt
│        │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.md5.txt
│        │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.md5.txt
│        │    └── WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.md5.txt
│        ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
│        ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
│        ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
│        ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
│        ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
│        ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
│        ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
│        ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
│        ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw
│        ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw
│        ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw
│        ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw
│        ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw
│        ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw
│        ├── WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
│        ├── WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
│        ├── WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
│        ├── WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
│        ├── WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw
│        ├── WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw
│        ├── WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
│        ├── WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
│        ├── WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
│        ├── WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
│        ├── WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
│        ├── WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
│        ├── WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
│        └── WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
├── fastqs
│    ├── md5
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.md5.txt
│    │    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.md5.txt
│    │    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.md5.txt
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.md5.txt
│    │    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.md5.txt
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.md5.txt
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.md5.txt
│    │    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.md5.txt
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.md5.txt
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.md5.txt
│    │    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.md5.txt
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.md5.txt
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.md5.txt
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.md5.txt
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.md5.txt
│    │    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.md5.txt
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.md5.txt
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.md5.txt
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.md5.txt
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.md5.txt
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.md5.txt
│    │    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.md5.txt
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.md5.txt
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.md5.txt
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.md5.txt
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.md5.txt
│    │    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.md5.txt
│    │    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.md5.txt
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.md5.txt
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.md5.txt
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.md5.txt
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.md5.txt
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.md5.txt
│    │    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.md5.txt
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.md5.txt
│    │    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.md5.txt
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.md5.txt
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.md5.txt
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.md5.txt
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.md5.txt
│    │    ├── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.md5.txt
│    │    └── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.md5.txt
│    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz
│    ├── Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz
│    ├── OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz
│    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
│    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
│    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
│    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
│    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
│    ├── rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
│    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
│    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
│    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
│    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
│    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
│    ├── rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
│    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
│    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
│    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
│    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
│    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
│    ├── rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
│    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
│    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
│    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
│    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz
│    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz
│    ├── rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz
│    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
│    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
│    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
│    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz
│    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz
│    ├── rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz
│    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz
│    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz
│    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz
│    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz
│    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz
│    ├── rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz
│    ├── rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz
│    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
│    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
│    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
│    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
│    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
│    ├── WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
│    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
│    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
│    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
│    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
│    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
│    ├── WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
│    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
│    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
│    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
│    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
│    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
│    ├── WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
│    ├── WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
│    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
│    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
│    ├── WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
│    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
│    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
│    ├── WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
│    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
│    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
│    ├── WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
│    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
│    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
│    ├── WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
│    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz
│    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz
│    ├── WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz
│    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz
│    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz
│    ├── WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz
│    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
│    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
│    ├── WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
│    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
│    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
│    ├── WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
│    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
│    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
│    ├── WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
│    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
│    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
│    ├── WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
│    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
│    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
│    ├── WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
│    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
│    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
│    ├── WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
│    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
│    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
│    ├── WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
│    ├── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
│    ├── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
│    └── WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
├── gtfs
│    ├── Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3
│    ├── Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf
│    ├── Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf
│    ├── Greenlaw-et-al.txome_nascent_G1.gtf
│    ├── Greenlaw-et-al.txome_nascent_Q.gtf
│    ├── Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf
│    ├── Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf
│    ├── Greenlaw-et-al.txome_representative-pa-ncRNA.gtf
│    └── md5
│        ├── Greenlaw-et-al.concatenated-genome_SC-KL-20S.md5.txt
│        ├── Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.md5.txt
│        ├── Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.md5.txt
│        ├── Greenlaw-et-al.txome_nascent_G1.md5.txt
│        ├── Greenlaw-et-al.txome_nascent_Q.md5.txt
│        ├── Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.md5.txt
│        ├── Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.md5.txt
│        └── Greenlaw-et-al.txome_representative-pa-ncRNA.md5.txt
└── matrices
    ├── Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv
    ├── Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv
    ├── Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv
    ├── Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv
    ├── Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
    ├── Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
    ├── Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
    └── md5
        ├── Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.md5.txt
        ├── Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.md5.txt
        ├── Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.md5.txt
        ├── Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.md5.txt
        ├── Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.md5.txt
        ├── Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.md5.txt
        └── Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.md5.txt

16 directories, 642 files


❯ find bams/standard-analyses/ -type f -name "*.bam" | wc -l
46


❯ find bams/transcriptome-assembly/ -type f -name "*.bam" | wc -l
4


❯ find bws/individual/ -type f -name "*.bw" | wc -l
90


❯ find bws/mean/ -type f -name "*.bw" | wc -l
28


❯ find fastqs/ -type f -name "*.fq.gz" | wc -l
138


❯ find gtfs/ -type f \( -name "*.gff3" -o -name "*.gtf" \) | wc -l
8


❯ find matrices/ -type f -name "*.tsv" | wc -l
7


❯ cd ..


❯ du -cshl GEO/
164G    GEO/
164G    total


❯ echo $(( 46 + 4 + 90 + 28 + 138 + 8 + 7 ))
321
```
</details>
<br />
<br />

<a id="copy-files-to-a-directory-on-the-shared-drive"></a>
## Copy files to a directory on the shared drive
<a id="code-13"></a>
### Code
<details>
<summary><i>Code: Copy files to a directory on the shared drive</i></summary>

```bash
#!/bin/bash

grabnode  # 8, 160, 1, N

source activate gff3_env

transcriptome

cd results/2023-0215 || echo "cd'ing failed; check on this..."

[[ ! -d "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO" ]] \
    && mkdir -p "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"

cd GEO/ && ls -lhaFG

cp \
    bams/standard-analyses/*.bam \
    "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"

find \
    . \
    -type f \
    \( \
        -name *.bam \
        -o -name *.bw \
        -o -name *.fq.gz \
        -o -name *.gff3 \
        -o -name *.gtf \
        -o -name *.tsv \
    \) \
    | wc -l


unset to_copy
typeset -a to_copy
while IFS=" " read -r -d $'\0'; do
    to_copy+=( "${REPLY}" )
done < <(
    find . -type f \
        \( \
            -name *.bam \
            -o -name *.bw \
            -o -name *.fq.gz \
            -o -name *.gff3 \
            -o -name *.gtf \
            -o -name *.tsv \
        \) \
        -print0 \
            | sort -z
)
# echo_test "${to_copy[@]}"
# echo "${#to_copy[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    'cp "{1}" "{2}"' \
::: "${to_copy[@]}" \
::: "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    'cp "{1}" "{2}"' \
::: "${to_copy[@]}" \
::: "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"

ls -lhaFG ~/tsukiyamalab/alisong/KA.2023-0726.GEO

ls -1 ~/tsukiyamalab/alisong/KA.2023-0726.GEO | wc -l
```
</details>
<br />

<a id="printed-13"></a>
### Printed
<details>
<summary><i>Printed: Copy files to a directory on the shared drive</i></summary>

```txt
❯ grabnode
How many CPUs/cores would you like to grab on the node? [1-36] 8
How much memory (GB) would you like to grab? [160] 160
Please enter the max number of days you would like to grab this node: [1-7] 1
Do you need a GPU ? [y/N]N

You have requested 8 CPUs on this node/server for 1 days or until you type exit.

Warning: If you exit this shell before your jobs are finished, your jobs
on this node/server will be terminated. Please use sbatch for larger jobs.

Shared PI folders can be found in: /fh/fast, /fh/scratch and /fh/secure.

Requesting Queue: campus-new cores: 8 memory: 160 gpu: NONE
srun: job 25019242 queued and waiting for resources
srun: job 25019242 has been allocated resources


❯ source activate gff3_env


❯ transcriptome


❯ cd results/2023-0215 || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215


❯ [[ ! -d "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO" ]] \
>     && mkdir -p "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"
mkdir: created directory '/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO'


❯ cd GEO/ && ls -lhaFG
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/GEO
total 328K
drwxrws---  7 kalavatt  115 Jul 26 17:17 ./
drwxrws--- 10 kalavatt 5.1K Jul 26 17:14 ../
drwxrws---  4 kalavatt   75 Jul 26 17:17 bams/
drwxrws---  4 kalavatt   50 Jul 26 17:17 bws/
drwxrws---  3 kalavatt 9.8K Jul 26 17:17 fastqs/
drwxrws---  3 kalavatt  545 Jul 26 17:17 gtfs/
drwxrws---  3 kalavatt  644 Jul 20 06:07 matrices/


❯ find \
>     . \
>     -type f \
>     \( \
>         -name *.bam \
>         -o -name *.bw \
>         -o -name *.fq.gz \
>         -o -name *.gff3 \
>         -o -name *.gtf \
>         -o -name *.tsv \
>     \) \
>     | wc -l
321


❯ unset to_copy


❯ typeset -a to_copy


❯ while IFS=" " read -r -d $'\0'; do
>     to_copy+=( "${REPLY}" )
> done < <(
>     find . -type f \
>         \( \
>             -name *.bam \
>             -o -name *.bw \
>             -o -name *.fq.gz \
>             -o -name *.gff3 \
>             -o -name *.gtf \
>             -o -name *.tsv \
>         \) \
>         -print0 \
>             | sort -z
> )


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     --dry-run \
>     'cp "{1}" "{2}"' \
> ::: "${to_copy[@]}" \
> ::: "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/standard-analyses/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/transcriptome-assembly/WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/transcriptome-assembly/WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/transcriptome-assembly/WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bams/transcriptome-assembly/WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/individual/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./bws/mean/WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./fastqs/WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.txome_nascent_G1.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.txome_nascent_Q.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./gtfs/Greenlaw-et-al.txome_representative-pa-ncRNA.gtf" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"
cp "./matrices/Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv" "/home/kalavatt/tsukiyamalab/alisong/KA.2023-0726.GEO"


❯ parallel \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     'cp "{1}" "{2}"' \
> ::: "${to_copy[@]}" \
> ::: "${HOME}/tsukiyamalab/alisong/KA.2023-0726.GEO"


❯ ls -lhaFG ~/tsukiyamalab/alisong/KA.2023-0726.GEO
total 190G
drwxrws---   2 kalavatt   23K Jul 26 17:41 ./
drwxrws--- 102 agreenla  5.8K Jul 26 17:16 ../
-rw-rw----   1 kalavatt  8.5M Jul 26 17:41 Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3
-rw-rw----   1 kalavatt  2.7M Jul 26 17:41 Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw----   1 kalavatt  2.2M Jul 26 17:41 Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv
-rw-rw----   1 kalavatt  315K Jul 26 17:41 Greenlaw-et-al.R64-1-1_blacklist_rRNA-tRNA.gtf
-rw-rw----   1 kalavatt  4.5M Jul 26 17:41 Greenlaw-et-al.R64-1-1_features-intergenic_sense-antisense.gtf
-rw-rw----   1 kalavatt  3.1M Jul 26 17:41 Greenlaw-et-al.txome_nascent_G1.gtf
-rw-rw----   1 kalavatt  2.9M Jul 26 17:41 Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv
-rw-rw----   1 kalavatt  3.8M Jul 26 17:41 Greenlaw-et-al.txome_nascent_Q.gtf
-rw-rw----   1 kalavatt  3.6M Jul 26 17:41 Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv
-rw-rw----   1 kalavatt  1.7M Jul 26 17:41 Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf
-rw-rw----   1 kalavatt  2.1M Jul 26 17:41 Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw----   1 kalavatt 1016K Jul 26 17:41 Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf
-rw-rw----   1 kalavatt  1.7M Jul 26 17:41 Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw----   1 kalavatt  1.6M Jul 26 17:41 Greenlaw-et-al.txome_representative-pa-ncRNA.gtf
-rw-rw----   1 kalavatt  1.6M Jul 26 17:41 Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv
-rw-rw----   1 kalavatt   76M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   75M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt   47M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   47M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  503M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:36 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.7G Jul 26 17:32 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   46M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   46M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  514M Jul 26 17:35 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:36 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.7G Jul 26 17:32 Nab3-AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   30M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   31M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716-7718_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:36 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  508M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:36 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:32 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   14M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   15M Jul 26 17:35 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  576M Jul 26 17:36 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:32 Nab3-AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   60M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   60M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt   35M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   35M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  503M Jul 26 17:36 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:32 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   34M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   34M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.3G Jul 26 17:36 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  483M Jul 26 17:36 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:37 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:32 OsTIR-AID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   15M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   16M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125-6126_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  7.4M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt  7.7M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.1G Jul 26 17:37 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  476M Jul 26 17:36 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:37 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:32 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt  7.4M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt  7.7M Jul 26 17:35 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:37 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  483M Jul 26 17:37 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:37 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:32 OsTIR-AID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   20M Jul 26 17:35 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   20M Jul 26 17:35 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  540M Jul 26 17:37 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  215M Jul 26 17:37 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  543M Jul 26 17:37 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  819M Jul 26 17:32 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  685M Jul 26 17:37 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  271M Jul 26 17:37 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  688M Jul 26 17:37 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.1G Jul 26 17:32 rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   17M Jul 26 17:35 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  533M Jul 26 17:37 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  213M Jul 26 17:37 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  538M Jul 26 17:37 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  777M Jul 26 17:32 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   20M Jul 26 17:35 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   20M Jul 26 17:35 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  651M Jul 26 17:37 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  262M Jul 26 17:37 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  656M Jul 26 17:37 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  940M Jul 26 17:32 rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   21M Jul 26 17:35 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  641M Jul 26 17:37 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  255M Jul 26 17:37 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  647M Jul 26 17:37 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  961M Jul 26 17:32 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  682M Jul 26 17:37 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  274M Jul 26 17:37 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  685M Jul 26 17:37 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt 1013M Jul 26 17:32 rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   16M Jul 26 17:35 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  736M Jul 26 17:37 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  301M Jul 26 17:37 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  745M Jul 26 17:37 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt 1017M Jul 26 17:32 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   16M Jul 26 17:35 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_m.bw
-rw-rw----   1 kalavatt   16M Jul 26 17:35 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.BPM_p.bw
-rw-rw----   1 kalavatt 1008M Jul 26 17:38 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  404M Jul 26 17:37 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R2.fq.gz
-rw-rw----   1 kalavatt 1001M Jul 26 17:38 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:32 rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2.UTPD.bam
-rw-rw----   1 kalavatt   40M Jul 26 17:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt   41M Jul 26 17:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt 1015M Jul 26 17:38 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  414M Jul 26 17:37 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
-rw-rw----   1 kalavatt 1014M Jul 26 17:38 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:33 rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt  1.1G Jul 26 17:38 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  402M Jul 26 17:38 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R2.fq.gz
-rw-rw----   1 kalavatt  1.1G Jul 26 17:38 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:33 rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2.UTPD.bam
-rw-rw----   1 kalavatt   69M Jul 26 17:35 rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   69M Jul 26 17:35 rrp6_Q_day8_tcn_N_auxF_tcF_7078-7079_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt   40M Jul 26 17:35 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   40M Jul 26 17:35 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.3G Jul 26 17:38 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  470M Jul 26 17:38 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:38 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.7G Jul 26 17:33 rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   39M Jul 26 17:35 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   39M Jul 26 17:35 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:38 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  466M Jul 26 17:38 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:38 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.7G Jul 26 17:33 rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   24M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_m.bw
-rw-rw----   1 kalavatt   24M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7078-7079_rep-mean_batch1-2.KLSC_p.bw
-rw-rw----   1 kalavatt   11M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   12M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.5G Jul 26 17:39 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  615M Jul 26 17:38 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:39 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.8G Jul 26 17:33 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt  9.7M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt  9.9M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:39 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  508M Jul 26 17:38 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:39 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:33 rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2.UTPD.bam
-rw-rw----   1 kalavatt   13M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   13M Jul 26 17:35 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:39 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  494M Jul 26 17:38 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:39 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:33 rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   19M Jul 26 17:35 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   19M Jul 26 17:35 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  634M Jul 26 17:39 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  251M Jul 26 17:39 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  639M Jul 26 17:39 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  960M Jul 26 17:33 WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   16M Jul 26 17:35 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  516M Jul 26 17:39 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  205M Jul 26 17:39 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  519M Jul 26 17:39 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  788M Jul 26 17:33 WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   16M Jul 26 17:35 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  632M Jul 26 17:39 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  256M Jul 26 17:39 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  636M Jul 26 17:39 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  919M Jul 26 17:33 WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  644M Jul 26 17:39 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  258M Jul 26 17:39 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  651M Jul 26 17:39 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  941M Jul 26 17:33 WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   18M Jul 26 17:35 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   18M Jul 26 17:35 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  584M Jul 26 17:39 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  233M Jul 26 17:39 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  587M Jul 26 17:39 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  876M Jul 26 17:33 WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   18M Jul 26 17:35 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   19M Jul 26 17:35 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  639M Jul 26 17:39 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  256M Jul 26 17:39 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  642M Jul 26 17:39 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  970M Jul 26 17:33 WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   14M Jul 26 17:35 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   15M Jul 26 17:35 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  653M Jul 26 17:39 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  268M Jul 26 17:39 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  659M Jul 26 17:39 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  921M Jul 26 17:33 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt  1.1G Jul 26 17:40 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  425M Jul 26 17:39 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R2.fq.gz
-rw-rw----   1 kalavatt  1.1G Jul 26 17:40 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:34 WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2.UTPD.bam
-rw-rw----   1 kalavatt   12M Jul 26 17:35 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   13M Jul 26 17:35 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.BPM_p.bw
-rw-r-----   1 kalavatt  602M Jul 26 17:39 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R1.fq.gz
-rw-r-----   1 kalavatt  249M Jul 26 17:39 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R2.fq.gz
-rw-r-----   1 kalavatt  609M Jul 26 17:40 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  849M Jul 26 17:33 WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt  2.6G Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw----   1 kalavatt   40M Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   40M Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   22M Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  642M Jul 26 17:40 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  233M Jul 26 17:39 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  673M Jul 26 17:40 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:34 WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   24M Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   24M Jul 26 17:35 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  637M Jul 26 17:40 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  230M Jul 26 17:40 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  665M Jul 26 17:40 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:34 WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt  2.0G Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw----   1 kalavatt   28M Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   29M Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw----   1 kalavatt   15M Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   15M Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  490M Jul 26 17:40 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  181M Jul 26 17:40 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  512M Jul 26 17:40 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  822M Jul 26 17:34 WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   16M Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   16M Jul 26 17:35 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  474M Jul 26 17:40 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  177M Jul 26 17:40 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  497M Jul 26 17:40 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  784M Jul 26 17:34 WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   30M Jul 26 17:35 WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt   31M Jul 26 17:35 WT_G1_day1_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt   18M Jul 26 17:35 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt  994M Jul 26 17:40 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  399M Jul 26 17:40 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R2.fq.gz
-rw-rw----   1 kalavatt  988M Jul 26 17:40 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:34 WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2.UTPD.bam
-rw-rw----   1 kalavatt   16M Jul 26 17:35 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_m.bw
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.KLSC_p.bw
-rw-rw----   1 kalavatt  908M Jul 26 17:40 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R1.fq.gz
-rw-rw----   1 kalavatt  361M Jul 26 17:40 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R2.fq.gz
-rw-rw----   1 kalavatt  911M Jul 26 17:40 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2_R3.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:34 WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2.UTPD.bam
-rw-rw----   1 kalavatt  1.8G Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw----   1 kalavatt   64M Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   64M Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw----   1 kalavatt   37M Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   37M Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  774M Jul 26 17:40 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  276M Jul 26 17:40 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  810M Jul 26 17:40 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.5G Jul 26 17:34 WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   35M Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   35M Jul 26 17:35 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  696M Jul 26 17:40 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  251M Jul 26 17:40 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  726M Jul 26 17:41 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:34 WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt  1.6G Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5781-2_rep-merge_batch1.UTKPSSc.bam
-rw-rw----   1 kalavatt   24M Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   25M Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5781-5782_rep-mean_batch1.BPM_p.bw
-rw-rw----   1 kalavatt   13M Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   13M Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  497M Jul 26 17:40 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  182M Jul 26 17:40 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  518M Jul 26 17:41 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  703M Jul 26 17:34 WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   11M Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_m.bw
-rw-rw----   1 kalavatt   12M Jul 26 17:35 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.BPM_p.bw
-rw-rw----   1 kalavatt  375M Jul 26 17:40 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  140M Jul 26 17:40 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  394M Jul 26 17:40 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  625M Jul 26 17:34 WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   67M Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   68M Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt   38M Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   38M Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:41 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  456M Jul 26 17:41 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:41 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.6G Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt   38M Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   38M Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.2G Jul 26 17:41 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  466M Jul 26 17:41 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:41 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.6G Jul 26 17:35 WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1.UTPD.bam
-rw-rw----   1 kalavatt   17M Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt   18M Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5781-5782_rep-mean_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  8.0M Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt  8.3M Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.1G Jul 26 17:41 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  475M Jul 26 17:41 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.2G Jul 26 17:41 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.3G Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1.UTPD.bam
-rw-rw----   1 kalavatt  8.4M Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_m.bw
-rw-rw----   1 kalavatt  8.5M Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.KLSC_p.bw
-rw-rw----   1 kalavatt  1.1G Jul 26 17:41 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R1.fq.gz
-rw-rw----   1 kalavatt  456M Jul 26 17:41 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R2.fq.gz
-rw-rw----   1 kalavatt  1.1G Jul 26 17:41 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1_R3.fq.gz
-rw-rw----   1 kalavatt  1.4G Jul 26 17:35 WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1.UTPD.bam


❯ ls -1 ~/tsukiyamalab/alisong/KA.2023-0726.GEO | wc -l
321
```
</details>
<br />
<br />
