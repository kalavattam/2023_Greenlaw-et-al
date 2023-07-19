
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
    1. [Copy over `bam`s, renaming them in the process; generate `MD5` checksums too](#copy-over-bams-renaming-them-in-the-process-generate-md5-checksums-too)
1. [Prepare and copy over `bam`s: transcriptome assembly work](#prepare-and-copy-over-bams-transcriptome-assembly-work)
    1. [Get to pertinent source directory, examine `bam`s](#get-to-pertinent-source-directory-examine-bams-1)
    1. [Copy over `bam`s, renaming them in the process; generate `MD5` checksums too](#copy-over-bams-renaming-them-in-the-process-generate-md5-checksums-too-1)
1. [Prepare and copy over `gff3`s and `gtf`s](#prepare-and-copy-over-gff3s-and-gtfs)
    1. [Determine/find/copy over the `gff3`s and `gtf`s to submit](#determinefindcopy-over-the-gff3s-and-gtfs-to-submit)
1. [Prepare and copy over counts matrices](#prepare-and-copy-over-counts-matrices)
    1. [Determine/find/copy over the counts matrices to submit](#determinefindcopy-over-the-counts-matrices-to-submit)

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

<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash


```
</details>
<br />
