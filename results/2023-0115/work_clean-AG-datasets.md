
`#work_clean-AG-datasets.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
	1. [Make a new experiment directory, `2023-0115/`](#make-a-new-experiment-directory-2023-0115)
	1. [Make an alias and function for checking arrays, files, directories](#make-an-alias-and-function-for-checking-arrays-files-directories)
1. [Symlink to the `fastq` files](#symlink-to-the-fastq-files)
	1. [Find out which files to use for AG's experiments](#find-out-which-files-to-use-for-ags-experiments)
		1. [`WTQvsG1` datasets](#wtqvsg1-datasets)
			1. [Clean things up: `WTQvsG1`](#clean-things-up-wtqvsg1)
				1. [Clean things up: `WTQvsG1/*`](#clean-things-up-wtqvsg1-1)
				1. [Clean things up: `WTQvsG1/20S`](#clean-things-up-wtqvsg120s)
				1. [Clean things up: `WTQvsG1/Project_ccucinot`](#clean-things-up-wtqvsg1project_ccucinot)
				1. [Clean things up: `WTQvsG1/de_novo_annotation`](#clean-things-up-wtqvsg1de_novo_annotation)
				1. [Clean things up: `WTQvsG1/Project_ccucinot_test`](#clean-things-up-wtqvsg1project_ccucinot_test)
				1. [Clean things up: `WTQvsG1/automation_of_annotation`](#clean-things-up-wtqvsg1automation_of_annotation)
		1. [`TRF4_SSRNA_April2022` datasets](#trf4_ssrna_april2022-datasets)
			1. [Clean things up: `TRF4_SSRNA_April2022`](#clean-things-up-trf4_ssrna_april2022)
		1. [`Nab3_Nrd1_Depletion` datasets](#nab3_nrd1_depletion-datasets)
			1. [Clean things up: `Nab3_Nrd1_Depletion`](#clean-things-up-nab3_nrd1_depletion)
		1. [`rtr1_rrp6_wt` datasets](#rtr1_rrp6_wt-datasets)
			1. [Clean things up: `rtr1_rrp6_wt`](#clean-things-up-rtr1_rrp6_wt)
	1. [Make symbolic links to the `fastq` files](#make-symbolic-links-to-the-fastq-files)
		1. [Examine all of the files that will be symlinked](#examine-all-of-the-files-that-will-be-symlinked)
		1. [Get situated](#get-situated-1)
		1. [Make the symbolic links](#make-the-symbolic-links)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="get-situated"></a>
## Get situated
<a id="make-a-new-experiment-directory-2023-0115"></a>
### Make a new experiment directory, `2023-0115/`
<details>
<summary><i>Code: Make a new experiment directory, 2023-0115/</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 1, default settings
conda activate Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
    {
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

if [[ ! -d "2023-0115" ]]; then
    mkdir -p 2023-0115/notebook
    # mkdir: created directory '2023-0115'
    # mkdir: created directory '2023-0115/notebook'

    mkdir -p 2023-0115/sh_err_out/err_out
    # mkdir: created directory '2023-0115/sh_err_out'
    # mkdir: created directory '2023-0115/sh_err_out/err_out'
fi

cd 2023-0115 || echo "cd'ing failed; check on this..."

if [[ ! -f README.md ]]; then
    touch README.md
    echo "Troubleshooting issues encountered by AG, and general 4tU-seq work too" \
        >> README.md
fi
```
</details>
<br />

<a id="make-an-alias-and-function-for-checking-arrays-files-directories"></a>
### Make an alias and function for checking arrays, files, directories
<details>
<summary><i>Code: Make an alias and function for checking arrays, files, directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Make an alias for quickly checking file/directory status
alias .,="ls -lhaFG"

#  Make a function for quickly checking the contents of arrays
echo_test () {
    for i in "${@:-*}"; do echo "${i}"; done
}
```
</details>
<br />

<a id="symlink-to-the-fastq-files"></a>
## Symlink to the `fastq` files
<a id="find-out-which-files-to-use-for-ags-experiments"></a>
### Find out which files to use for AG's experiments
<details>
<summary><i>Notes: Symlink to the fastq files</i></summary>

Following the write-ups/descriptions in the notebook [notes-Alison-files-locations.md](../2022-1101/notes-Alison-files-locations.md) and [the above email from AG](#email-from-alison-to-me-2023-0113-1751)

- `WTQvsG1` datasets
- `TRF4_SSRNA_April2022` datasets
- `Nab3_Nrd1_Depletion` datasets
- `rtr1_rrp6_wt` datasets
</details>
<br />

<a id="wtqvsg1-datasets"></a>
#### `WTQvsG1` datasets
<details>
<summary><i>Notes, etc.: WTQvsG1 datasets</i></summary>

~~Use the files in "`~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*`"~~  
Use the files in "`~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/*_R{1,3}_001.fastq.gz`" `#DEKHO`
```bash
#!/bin/bash
#DONTRUN

., ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/*_R{1,3}_001.fastq.gz
# -rw-rw---- 1 agreenla 490M Oct 26 18:47 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 512M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 642M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 673M Oct 26 18:47 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 497M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 518M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 774M Oct 26 18:44 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 810M Oct 26 18:44 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 474M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 497M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 637M Oct 26 18:46 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 665M Oct 26 18:44 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 375M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 394M Oct 26 18:47 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 696M Oct 26 18:46 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 726M Oct 26 18:46 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
```

<details>
<summary><i>Scratch work to determine the above</i></summary>

```txt
❯ cd ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot

❯ .,
total 12G
drwxrws--- 2 agreenla 1.5K Oct 26 18:52 ./
drwxr-s--- 5 agreenla  334 Oct 26 18:52 ../
-rw-rw---- 1 agreenla 124M Oct 26 18:46 5781_G1_IN_S5_I1_001.fastq.gz
-rw-rw---- 1 agreenla 490M Oct 26 18:47 5781_G1_IN_S5_R1_001.fastq.gz
-rw-rw---- 1 agreenla 181M Oct 26 18:47 5781_G1_IN_S5_R2_001.fastq.gz
-rw-rw---- 1 agreenla 512M Oct 26 18:45 5781_G1_IN_S5_R3_001.fastq.gz
-rw-rw---- 1 agreenla 156M Oct 26 18:45 5781_G1_IP_S1_I1_001.fastq.gz
-rw-rw---- 1 agreenla 642M Oct 26 18:45 5781_G1_IP_S1_R1_001.fastq.gz
-rw-rw---- 1 agreenla 233M Oct 26 18:43 5781_G1_IP_S1_R2_001.fastq.gz
-rw-rw---- 1 agreenla 673M Oct 26 18:47 5781_G1_IP_S1_R3_001.fastq.gz
-rw-rw---- 1 agreenla 117M Oct 26 18:45 5781_Q_IN_S6_I1_001.fastq.gz
-rw-rw---- 1 agreenla 497M Oct 26 18:45 5781_Q_IN_S6_R1_001.fastq.gz
-rw-rw---- 1 agreenla 182M Oct 26 18:45 5781_Q_IN_S6_R2_001.fastq.gz
-rw-rw---- 1 agreenla 518M Oct 26 18:45 5781_Q_IN_S6_R3_001.fastq.gz
-rw-rw---- 1 agreenla 178M Oct 26 18:47 5781_Q_IP_S2_I1_001.fastq.gz
-rw-rw---- 1 agreenla 774M Oct 26 18:44 5781_Q_IP_S2_R1_001.fastq.gz
-rw-rw---- 1 agreenla 276M Oct 26 18:47 5781_Q_IP_S2_R2_001.fastq.gz
-rw-rw---- 1 agreenla 810M Oct 26 18:44 5781_Q_IP_S2_R3_001.fastq.gz
-rw-rw---- 1 agreenla 119M Oct 26 18:46 5782_G1_IN_S7_I1_001.fastq.gz
-rw-rw---- 1 agreenla 474M Oct 26 18:45 5782_G1_IN_S7_R1_001.fastq.gz
-rw-rw---- 1 agreenla 177M Oct 26 18:46 5782_G1_IN_S7_R2_001.fastq.gz
-rw-rw---- 1 agreenla 497M Oct 26 18:45 5782_G1_IN_S7_R3_001.fastq.gz
-rw-rw---- 1 agreenla 151M Oct 26 18:43 5782_G1_IP_S3_I1_001.fastq.gz
-rw-rw---- 1 agreenla 637M Oct 26 18:46 5782_G1_IP_S3_R1_001.fastq.gz
-rw-rw---- 1 agreenla 230M Oct 26 18:44 5782_G1_IP_S3_R2_001.fastq.gz
-rw-rw---- 1 agreenla 665M Oct 26 18:44 5782_G1_IP_S3_R3_001.fastq.gz
-rw-rw---- 1 agreenla  95M Oct 26 18:44 5782_Q_IN_S8_I1_001.fastq.gz
-rw-rw---- 1 agreenla 375M Oct 26 18:45 5782_Q_IN_S8_R1_001.fastq.gz
-rw-rw---- 1 agreenla 140M Oct 26 18:45 5782_Q_IN_S8_R2_001.fastq.gz
-rw-rw---- 1 agreenla 394M Oct 26 18:47 5782_Q_IN_S8_R3_001.fastq.gz
-rw-rw---- 1 agreenla 165M Oct 26 18:43 5782_Q_IP_S4_I1_001.fastq.gz
-rw-rw---- 1 agreenla 696M Oct 26 18:46 5782_Q_IP_S4_R1_001.fastq.gz
-rw-rw---- 1 agreenla 251M Oct 26 18:43 5782_Q_IP_S4_R2_001.fastq.gz
-rw-rw---- 1 agreenla 726M Oct 26 18:46 5782_Q_IP_S4_R3_001.fastq.gz

❯ ., ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN:
total 18G
drwxr-s---  2 agreenla  829 Oct 22  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R1_003.fastq
-rw-r-----  1 agreenla 303M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R1_004.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R2_003.fastq
-rw-r-----  1 agreenla 303M Aug 31  2020 5781_G1_IN_GTCGAGAA_L001_R2_004.fastq
-rw-rw----  1 agreenla 3.3K Sep  3  2020 5781_G1_IN.log
-rw-rw----  1 agreenla 1.3G Sep  3  2020 5781_G1_IN_mapped.bam
-rw-rw----  1 agreenla 5.8G Sep  3  2020 5781_G1_IN_mapped.sam
-rw-rw----  1 agreenla 2.1G Sep  3  2020 5781_G1_IN_merged_R1.fastq
-rw-rw----  1 agreenla 2.1G Sep  3  2020 5781_G1_IN_merged_R2.fastq
-rw-rw----  1 agreenla 809M Sep  3  2020 5781_G1_IN_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5781_G1_IN_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-rw----  1 agreenla 4.0K Oct 22  2020 ._SampleSheet.csv
-rw-r-----  1 agreenla  172 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP:
total 24G
drwxr-s---  2 agreenla  904 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R1_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R1_004.fastq
-rw-r-----  1 agreenla 358M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R1_005.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R2_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R2_004.fastq
-rw-r-----  1 agreenla 358M Aug 31  2020 5781_G1_IP_CGCTACAT_L001_R2_005.fastq
-rw-rw----  1 agreenla 3.3K Sep  3  2020 5781_G1_IP.log
-rw-rw----  1 agreenla 1.7G Sep  3  2020 5781_G1_IP_mapped.bam
-rw-rw----  1 agreenla 7.9G Sep  3  2020 5781_G1_IP_mapped.sam
-rw-rw----  1 agreenla 2.8G Sep  3  2020 5781_G1_IP_merged_R1.fastq
-rw-rw----  1 agreenla 2.8G Sep  3  2020 5781_G1_IP_merged_R2.fastq
-rw-rw----  1 agreenla 1.2G Sep  3  2020 5781_G1_IP_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5781_G1_IP_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  172 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN:
total 16G
drwxr-s---  2 agreenla  779 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R1_003.fastq
-rw-r-----  1 agreenla 336M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R1_004.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R2_003.fastq
-rw-r-----  1 agreenla 336M Aug 31  2020 5781_Q_IN_ACAACAGC_L001_R2_004.fastq
-rw-rw----  1 agreenla 3.2K Sep  3  2020 5781_Q_IN.log
-rw-rw----  1 agreenla 939M Sep  3  2020 5781_Q_IN_mapped.bam
-rw-rw----  1 agreenla 4.4G Sep  3  2020 5781_Q_IN_mapped.sam
-rw-rw----  1 agreenla 2.2G Sep  3  2020 5781_Q_IN_merged_R1.fastq
-rw-rw----  1 agreenla 2.2G Sep  3  2020 5781_Q_IN_merged_R2.fastq
-rw-rw----  1 agreenla 590M Sep  3  2020 5781_Q_IN_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5781_Q_IN_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  171 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP:
total 21G
drwxr-s---  2 agreenla 1.1K Aug  9 16:35 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R1_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R1_004.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R1_005.fastq
-rw-r-----  1 agreenla 307M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R1_006.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R2_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R2_004.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R2_005.fastq
-rw-r-----  1 agreenla 307M Aug 31  2020 5781_Q_IP_AATCCAGC_L001_R2_006.fastq
-rw-rw----  1 agreenla 3.4K Sep  3  2020 5781_Q_IP.log
-rw-rw----  1 agreenla 1.2G Sep  3  2020 5781_Q_IP_mapped.bam
-rw-rw----  1 agreenla 4.0K Aug  9 16:37 ._5781_Q_IP_mapped.sam
-rw-rw----  1 agreenla 5.2G Sep  3  2020 5781_Q_IP_mapped.sam
-rw-rw----  1 agreenla 3.3G Sep  3  2020 5781_Q_IP_merged_R1.fastq
-rw-rw----  1 agreenla 3.3G Sep  3  2020 5781_Q_IP_merged_R2.fastq
-rw-rw----  1 agreenla 766M Sep  3  2020 5781_Q_IP_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5781_Q_IP_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  171 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN:
total 17G
drwxr-s---  2 agreenla  794 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R1_003.fastq
-rw-r-----  1 agreenla 222M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R1_004.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R2_003.fastq
-rw-r-----  1 agreenla 222M Aug 31  2020 5782_G1_IN_ATGACAGG_L001_R2_004.fastq
-rw-rw----  1 agreenla 3.3K Sep  3  2020 5782_G1_IN.log
-rw-rw----  1 agreenla 1.2G Sep  3  2020 5782_G1_IN_mapped.bam
-rw-rw----  1 agreenla 5.5G Sep  3  2020 5782_G1_IN_mapped.sam
-rw-rw----  1 agreenla 2.0G Sep  3  2020 5782_G1_IN_merged_R1.fastq
-rw-rw----  1 agreenla 2.0G Sep  3  2020 5782_G1_IN_merged_R2.fastq
-rw-rw----  1 agreenla 773M Sep  3  2020 5782_G1_IN_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5782_G1_IN_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  172 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP:
total 24G
drwxr-s---  2 agreenla  904 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R1_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R1_004.fastq
-rw-r-----  1 agreenla 343M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R1_005.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R2_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R2_004.fastq
-rw-r-----  1 agreenla 343M Aug 31  2020 5782_G1_IP_CGTCTAAC_L001_R2_005.fastq
-rw-rw----  1 agreenla 3.3K Sep  3  2020 5782_G1_IP.log
-rw-rw----  1 agreenla 1.7G Sep  3  2020 5782_G1_IP_mapped.bam
-rw-rw----  1 agreenla 7.7G Sep  3  2020 5782_G1_IP_mapped.sam
-rw-rw----  1 agreenla 2.8G Sep  3  2020 5782_G1_IP_merged_R1.fastq
-rw-rw----  1 agreenla 2.8G Sep  3  2020 5782_G1_IP_merged_R2.fastq
-rw-rw----  1 agreenla 1.1G Sep  3  2020 5782_G1_IP_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5782_G1_IP_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  172 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN:
total 13G
drwxr-s---  2 agreenla  671 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IN_GCACACAA_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IN_GCACACAA_L001_R1_002.fastq
-rw-r-----  1 agreenla 429M Aug 31  2020 5782_Q_IN_GCACACAA_L001_R1_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IN_GCACACAA_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IN_GCACACAA_L001_R2_002.fastq
-rw-r-----  1 agreenla 429M Aug 31  2020 5782_Q_IN_GCACACAA_L001_R2_003.fastq
-rw-rw----  1 agreenla 3.1K Sep  3  2020 5782_Q_IN.log
-rw-rw----  1 agreenla 828M Sep  3  2020 5782_Q_IN_mapped.bam
-rw-rw----  1 agreenla 3.9G Sep  3  2020 5782_Q_IN_mapped.sam
-rw-rw----  1 agreenla 1.7G Sep  3  2020 5782_Q_IN_merged_R1.fastq
-rw-rw----  1 agreenla 1.7G Sep  3  2020 5782_Q_IN_merged_R2.fastq
-rw-rw----  1 agreenla 526M Sep  3  2020 5782_Q_IN_sorted.bam
-rw-rw----  1 agreenla  36K Sep  3  2020 5782_Q_IN_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  171 Aug 31  2020 SampleSheet.csv

/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP:
total 25G
drwxr-s---  2 agreenla  887 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_004.fastq
-rw-r-----  1 agreenla 582M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_005.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_004.fastq
-rw-r-----  1 agreenla 582M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_005.fastq
-rw-rw----  1 agreenla 3.3K Sep  3  2020 5782_Q_IP.log
-rw-rw----  1 agreenla 1.2G Sep  3  2020 5782_Q_IP_mapped.bam
-rw-rw----  1 agreenla 5.6G Sep  3  2020 5782_Q_IP_mapped.sam
-rw-rw----  1 agreenla 3.0G Sep  3  2020 5782_Q_IP_merged_R1.fastq
-rw-rw----  1 agreenla 3.0G Sep  3  2020 5782_Q_IP_merged_R2.fastq
-rw-rw----  1 agreenla 817M Sep  3  2020 5782_Q_IP_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5782_Q_IP_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  171 Aug 31  2020 SampleSheet.csv

❯ cd /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP

❯ .,
total 25G
drwxr-s---  2 agreenla  887 Sep  3  2020 ./
drwxr-s--- 15 agreenla 1.3K Oct 17 17:17 ../
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_004.fastq
-rw-r-----  1 agreenla 582M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R1_005.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_001.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_002.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_003.fastq
-rw-r-----  1 agreenla 609M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_004.fastq
-rw-r-----  1 agreenla 582M Aug 31  2020 5782_Q_IP_AACTCGGA_L001_R2_005.fastq
-rw-rw----  1 agreenla 3.3K Sep  3  2020 5782_Q_IP.log
-rw-rw----  1 agreenla 1.2G Sep  3  2020 5782_Q_IP_mapped.bam
-rw-rw----  1 agreenla 5.6G Sep  3  2020 5782_Q_IP_mapped.sam
-rw-rw----  1 agreenla 3.0G Sep  3  2020 5782_Q_IP_merged_R1.fastq
-rw-rw----  1 agreenla 3.0G Sep  3  2020 5782_Q_IP_merged_R2.fastq
-rw-rw----  1 agreenla 817M Sep  3  2020 5782_Q_IP_sorted.bam
-rw-rw----  1 agreenla  37K Sep  3  2020 5782_Q_IP_sorted.bam.bai
-rwxr-x---  1 agreenla 1.7K Sep  3  2020 bam_split_paired_end.sh*
-rw-r-----  1 agreenla  171 Aug 31  2020 SampleSheet.csv

❯ head 5782_Q_IP_AACTCGGA_L001_R1_001.fastq
@HISEQ:1007:HGV5NBCX3:1:1101:1378:2231 1:N:0:AACTCGGA
CAGAAATGATCAGGAAATATTAATTTCCATTCACTACGTTTTAGTCGGTG
+
GGGGGIIIGIIIGIIIIIIIIGGIIIIIGIIIIIGIIIIIIIIIIIIIII
@HISEQ:1007:HGV5NBCX3:1:1101:1609:2140 1:Y:0:AACTCGGA
CATGAAACTGGATCTTTGAATGTTTCATAAATTTGATATTTTTTGATTGT
+
GGAA.<AGGGAGA<GA..<GA.<G<AGGGG<A.GGAG.<AAAGGAGGGG<
@HISEQ:1007:HGV5NBCX3:1:1101:1645:2147 1:N:0:AACTCGGA
CTGAATATAATGGCAGTACACCTGCAGATGCATTTGAAACAAAAGTCACA

❯ head 5782_Q_IP_merged_R1.fastq
@HISEQ:1007:HGV5NBCX3:1:1101:1378:2231 1:N:0:AACTCGGA
CAGAAATGATCAGGAAATATTAATTTCCATTCACTACGTTTTAGTCGGTG
+
GGGGGIIIGIIIGIIIIIIIIGGIIIIIGIIIIIGIIIIIIIIIIIIIII
@HISEQ:1007:HGV5NBCX3:1:1101:1609:2140 1:Y:0:AACTCGGA
CATGAAACTGGATCTTTGAATGTTTCATAAATTTGATATTTTTTGATTGT
+
GGAA.<AGGGAGA<GA..<GA.<G<AGGGG<A.GGAG.<AAAGGAGGGG<
@HISEQ:1007:HGV5NBCX3:1:1101:1645:2147 1:N:0:AACTCGGA
CTGAATATAATGGCAGTACACCTGCAGATGCATTTGAAACAAAAGTCACA

❯ tail 5782_Q_IP_AACTCGGA_L001_R1_005.fastq
+
GGGGGGGIGGIIIIIGIGIIIIIGIIGIIIIIGIGGGIGGIIGIIGGGGG
@HISEQ:1007:HGV5NBCX3:1:2216:21258:101098 1:N:0:AACTCGGA
CGCCCACACAGGATTTGGTAAAGAAAGTATTTGATATGAAACTCCGAGAG
+
GGAAAGAGAGIIGA.AGGGGIIIIIGIGGGGIIIGGIGIIIIGGIGGGGG
@HISEQ:1007:HGV5NBCX3:1:2216:21265:101132 1:Y:0:AACTCGGA
CTCAACTTGAACAACCATTCCAAGACTTCTTGGTTTACACGTCCGTGCAA
+
AGAAAG.<..GGAGIGGGIIGGGGGGGGGGGG.GGGGAGGGGIIGIGGGG

❯ tail 5782_Q_IP_merged_R1.fastq
+
GGGGGGGIGGIIIIIGIGIIIIIGIIGIIIIIGIGGGIGGIIGIIGGGGG
@HISEQ:1007:HGV5NBCX3:1:2216:21258:101098 1:N:0:AACTCGGA
CGCCCACACAGGATTTGGTAAAGAAAGTATTTGATATGAAACTCCGAGAG
+
GGAAAGAGAGIIGA.AGGGGIIIIIGIGGGGIIIGGIGIIIIGGIGGGGG
@HISEQ:1007:HGV5NBCX3:1:2216:21265:101132 1:Y:0:AACTCGGA
CTCAACTTGAACAACCATTCCAAGACTTCTTGGTTTACACGTCCGTGCAA
+
AGAAAG.<..GGAGIGGGIIGGGGGGGGGGGG.GGGGAGGGGIIGIGGGG

#  Is ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
#+ the same as ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq?
#+ 
#+ -rw-rw---- 1 agreenla 512M Oct 26 18:45 5781_G1_IN_S5_R3_001.fastq.gz
#+ -rw-rw---- 1 agreenla 2.1G Sep  3  2020 5781_G1_IN_merged_R2.fastq
#+ 
#+ To answer, cd into each directory, and then run wc -l, head, tail
```

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# -------------------------------------
cd ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot \
    || echo "cd'ing failed; check on this..."

zcat 5781_G1_IN_S5_R1_001.fastq.gz | wc -l
# 54893212

zcat 5781_G1_IN_S5_R1_001.fastq.gz | head -8
# @D00300:1007:HGV5NBCX3:1:1103:1220:2169 1:N:0:NTCGAGAA
# TAAAGNGAAGGTACATGAAATGCAAAANTTGATTGGTCTAGCTTCATATG
# +
# GGGGG#<<GGGIGIGGIGGGGGGGGIG#<<GGGGGGGGGGGGIGGGGAGG
# @D00300:1007:HGV5NBCX3:1:1103:1231:2221 1:N:0:GTCGAGAA
# CTGAANGCATCCATCGTTGAAACTTTCNTCGACGCCGCCTCATCTACTGA
# +
# GGGAA#<<AGGGGGIIIGGA.AGGGGG#<GGAGGIGIIIAGIGGGIGGIG

zcat 5781_G1_IN_S5_R1_001.fastq.gz | tail -8
# @D00300:1007:HGV5NBCX3:1:2216:21089:101169 1:N:0:GTCGAGAA
# CTATCTGGTTGATCCTGCCAGTAGTCATATGCTTGTCTCAAAGATTAAGC
# +
# GGGAGIGIIIIIIIIIIIIIIIIIIGIIIIIIIIIIGIIIIIIIIIIIIG
# @D00300:1007:HGV5NBCX3:1:2216:21033:101203 1:N:0:GTCGAGNA
# CTGTATGGCCCTTAATGATGCCATGGTGTCGGCTAATGGTAACCTGTATG
# +
# GGGGGGGGIIIIIIIIIIGGGGIGGIIGGGIIIIIIIIIIIIIIIGGIGG

# -----------------
zcat 5781_G1_IN_S5_R3_001.fastq.gz | wc -l
# 54893212

zcat 5781_G1_IN_S5_R3_001.fastq.gz | head -8
# @D00300:1007:HGV5NBCX3:1:1103:1220:2169 3:N:0:NTCGAGAA
# ATATGTTGAGCAAGTGTGTTGATGTAGTATAGTAAGTCAAATCTAAATTT
# +
# GGGGGIIIIIIGIIIIGIIIIGIIIIGIIIGIIIGGGGIGGIIIIGIGII
# @D00300:1007:HGV5NBCX3:1:1103:1231:2221 3:N:0:GTCGAGAA
# GTGTTCGTTGGTGGAGCCACTAAATCGTCAACAACAGAAGGGTGTTGTAC
# +
# GGAGAGGGGIIIIIIIIIIIIGGGIIIIGGGIIIIGIIIGGGGGIIIIIG

zcat 5781_G1_IN_S5_R3_001.fastq.gz | tail -8
# @D00300:1007:HGV5NBCX3:1:2216:21089:101169 3:N:0:GTCGAGAA
# AGGGCAGAAATTTGAATGAACCATCGCCAGCACAAGGCCATGCGATTCGA
# +
# GGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIGIGIGGGIGGGGIG
# @D00300:1007:HGV5NBCX3:1:2216:21033:101203 3:N:0:GTCGAGNA
# CATTATTGGCGTTATCAATACTTNNNNNNANNNNNNNNNNNNNNNNNNNN
# +
# GGGGGIIAGGIIIIGIIIGIIII######<####################

# -------------------------------------
cd ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN \
    || echo "cd'ing failed; check on this..."

cat 5781_G1_IN_merged_R1.fastq | wc -l
# 55955368

cat 5781_G1_IN_merged_R1.fastq | head -8
# @HISEQ:1007:HGV5NBCX3:1:1101:1232:2133 1:Y:0:GTCGAGAA
# CNATANTGCTGGTTTGACTAAGGGTGCNTCTGCTGGTGAAGGTTTGGGTA
# +
# G#<GG#<<GGGIIIIIIIIIIIIIIII#<GGGIIIIGIIIIIIIIIIIIG
# @HISEQ:1007:HGV5NBCX3:1:1101:1203:2134 1:Y:0:NTCGAGAA
# GNAAANTCCATCTAAAGCTAAATATTGNCGAGAGACCGATAGCGAACAAG
# +
# G#<<G#<<GGGGIIIIIIIGIIGGGII#<<GGGIGGGGGGGIIIGGGGII

cat 5781_G1_IN_merged_R1.fastq | tail -8
# @HISEQ:1007:HGV5NBCX3:1:2216:21033:101203 1:N:0:GTCGAGNA
# CTGTATGGCCCTTAATGATGCCATGGTGTCGGCTAATGGTAACCTGTATG
# +
# GGGGGGGGIIIIIIIIIIGGGGIGGIIGGGIIIIIIIIIIIIIIIGGIGG
# @HISEQ:1007:HGV5NBCX3:1:2216:21280:101183 1:Y:0:GTCGAGAA
# CGNTGCCNNTAAGATTACTGTAAAGACGCCTGAATATCCAAGAGGCCGTC
# +
# <<#<<<.##<<...<<<.<..<<G<GG..<<AGG.G.<..<.G.<GGG##

# -----------------
cat 5781_G1_IN_merged_R2.fastq | wc -l
# 55955368

cat 5781_G1_IN_merged_R2.fastq | head -8
# @HISEQ:1007:HGV5NBCX3:1:1101:1232:2133 2:Y:0:GTCGAGAA
# TTGTGCGAATTCAATATCTTTCAATCTTAGTTCTTGGTTAATAATTTCTA
# +
# GGGGGIIIGIIIIIIIIIIIIIIGGIIIIIIIIIIIIIIIIIIIIIIIII
# @HISEQ:1007:HGV5NBCX3:1:1101:1203:2134 2:Y:0:NTCGAGAA
# AGCCCTTCCCTTTCAACAATTTCACGTACTTTTTCACTCTCTTTTCAAAG
# +
# GGGGGIIIGIGGGGIIIIIIIIIIIIIGGGGIIIGGIIIIIIGIIIIIGI

cat 5781_G1_IN_merged_R2.fastq | tail -8
# @HISEQ:1007:HGV5NBCX3:1:2216:21033:101203 2:N:0:GTCGAGNA
# CATTATTGGCGTTATCAATACTTNNNNNNANNNNNNNNNNNNNNNNNNNN
# +
# GGGGGIIAGGIIIIGIIIGIIII###########################
# @HISEQ:1007:HGV5NBCX3:1:2216:21280:101183 2:Y:0:GTCGAGAA
# ATAAGTATTGGAAGCCCTTGTCCGGATTGGCAGCATCATTCCATGCAACT
# +
# AAAAAGGIG.GGGGGAAGG.<GGGGG<GGGGAGGGAGGIIGGGIGGIIIG
```
</details>
</details>
<br />

<a id="clean-things-up-wtqvsg1"></a>
##### Clean things up: `WTQvsG1`
<a id="clean-things-up-wtqvsg1-1"></a>
###### Clean things up: `WTQvsG1/*`
<details>
<summary><i>Code: Clean things up: WTQvsG1/*</i></summary>

```bash
#!/bin/bash
#DONTRUN

#NOTE Won't work until I have r/w permissions from AG...
```
~~`#DONE` Awaiting AG to give me r/w permissions~~  
~~`#DONE` Pick up with cleanup, compression later~~
</details>
<br />

<details>
<summary><i>Printed: Clean things up: WTQvsG1/*</i></summary>

```txt
```
</details>
<br />

<a id="clean-things-up-wtqvsg120s"></a>
###### Clean things up: `WTQvsG1/20S`
<details>
<summary><i>Code: Clean things up: WTQvsG1/20S</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/WTQvsG1"
cd "${dir}"


#  20S ------------------------------------------------------------------------
cd 20S \
    || echo "cd'ing failed; check on this..."


#  rm *.sam files ---------------------
find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  Compressed fastqs already? ---------
find . \
    -type f \
    -name "*.fastq.gz" \
    -exec \
        ls -lhaFG {} \;
#  No...


#  rm *_merged_R?.fastq files ---------
find . \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

# find . \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         rm {} \;
#NOTE 1/2 Keep the *merged*fastq files b/c the merge operation actually needed
#NOTE 2/2 to take place


#  'core' files from segfaults --------
find . \
    -type f \
    -name "core" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "core" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
dir="$(pwd)"  # echo "${dir}"

unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find "${dir}" \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 --force "$(basename "${i}")"
    
    echo ""
done
#NOTE 1/2 Many segmentation faults; need read/write permissions from AG, then
#NOTE 2/2 can clean everything up

#NOTE 1/2 Also, will need to take care of 'core' files, apparently from the
#NOTE 2/2 segmentation faults
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: WTQvsG1/20S</i></summary>

```txt
Compressing ./Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R1_002.fastq...
 dirname:  ./Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP/5781_G1_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IP
basename:  5781_G1_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP/5782_Q_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_Q_IP
basename:  5782_Q_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP/5782_G1_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IP
basename:  5782_G1_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_G1_IN
basename:  5781_G1_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_006.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_006.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_006.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_006.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP/5781_Q_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5781_Q_IP
basename:  5781_Q_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/20S/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_004.fastq
```
</details>
<br />

<a id="clean-things-up-wtqvsg1project_ccucinot"></a>
###### Clean things up: `WTQvsG1/Project_ccucinot`
<details>
<summary><i>Code: Clean things up: WTQvsG1/Project_ccucinot</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/WTQvsG1"
cd "${dir}"


#  Project_ccucinot -----------------------------------------------------------
cd Project_ccucinot \
    || echo "cd'ing failed; check on this..."


#  rm *.sam files ---------------------
find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find . \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

# find . \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         rm {} \;
#NOTE 1/2 Keep the *merged*fastq files b/c the merge operation actually needed
#NOTE 2/2 to take place


#  'core' files from segfaults --------
find . \
    -type f \
    -name "core" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "core" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
dir="$(pwd)"  # echo "${dir}"

unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find "${dir}" \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 --force "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: WTQvsG1/Project_ccucinot</i></summary>

```txt
Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_GCACACAA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN
basename:  5782_Q_IN_GCACACAA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_ACAACAGC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN
basename:  5781_Q_IN_ACAACAGC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP
basename:  5781_G1_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_AACTCGGA_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_AACTCGGA_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP
basename:  5782_Q_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_CGTCTAAC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_CGTCTAAC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP
basename:  5782_G1_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN
basename:  5781_G1_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_006.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_006.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_006.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_006.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP
basename:  5781_Q_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_ATGACAGG_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN
basename:  5782_G1_IN_ATGACAGG_L001_R2_004.fastq
```
</details>
<br />

<a id="clean-things-up-wtqvsg1de_novo_annotation"></a>
###### Clean things up: `WTQvsG1/de_novo_annotation`
<details>
<summary><i>Code: Clean things up: WTQvsG1/de_novo_annotation</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/WTQvsG1"
cd "${dir}"


#  de_novo_annotation ---------------------------------------------------------
cd de_novo_annotation \
    || echo "cd'ing failed; check on this..."


#  rm *.sam files ---------------------
find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find . \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

# find . \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         rm {} \;
#NOTE 1/2 Keep the *merged*fastq files b/c the merge operation actually needed
#NOTE 2/2 to take place


#  'core' files from segfaults --------
find . \
    -type f \
    -name "core" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "core" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
dir="$(pwd)"  # echo "${dir}"

unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find "${dir}" \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 --force "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: WTQvsG1/de_novo_annotation</i></summary>

```txt

```
`#NOTE` *Just deleted `.sam` files&mdash;nothing was printed out*
</details>
<br />

<a id="clean-things-up-wtqvsg1project_ccucinot_test"></a>
###### Clean things up: `WTQvsG1/Project_ccucinot_test`
<details>
<summary><i>Code: Clean things up: WTQvsG1/Project_ccucinot_test</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/WTQvsG1"
cd "${dir}"


#  Project_ccucinot -----------------------------------------------------------
cd Project_ccucinot_test \
    || echo "cd'ing failed; check on this..."


#  rm *.sam files ---------------------
find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find . \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

# find . \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         rm {} \;
#NOTE 1/2 Keep the *merged*fastq files b/c the merge operation actually needed
#NOTE 2/2 to take place


#  'core' files from segfaults --------
find . \
    -type f \
    -name "core" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "core" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
dir="$(pwd)"  # echo "${dir}"

unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find "${dir}" \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 --force "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: WTQvsG1/Project_ccucinot_test</i></summary>

```txt
Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_CGCTACAT_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_CGCTACAT_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP/5781_G1_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IP
basename:  5781_G1_IP_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_merged_R1.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_GTCGAGAA_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_GTCGAGAA_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot_test/Sample_5781_G1_IN
basename:  5781_G1_IN_merged_R2.fastq
```
</details>
<br />

<a id="clean-things-up-wtqvsg1automation_of_annotation"></a>
###### Clean things up: `WTQvsG1/automation_of_annotation`
<details>
<summary><i>Code: Clean things up: WTQvsG1/automation_of_annotation</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/WTQvsG1"
cd "${dir}"


#  Project_ccucinot -----------------------------------------------------------
cd automation_of_annotation \
    || echo "cd'ing failed; check on this..."


#  rm *.sam files ---------------------
find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find . \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find . \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

# find . \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         rm {} \;
#NOTE 1/2 Keep the *merged*fastq files b/c the merge operation actually needed
#NOTE 2/2 to take place


#  'core' files from segfaults --------
find . \
    -type f \
    -name "core" \
    -exec \
        ls -lhaFG {} \;

find . \
    -type f \
    -name "core" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
dir="$(pwd)"  # echo "${dir}"

unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find "${dir}" \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 --force "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: WTQvsG1/automation_of_annotation</i></summary>

```txt
Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_006.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_006.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_002.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_002.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_004.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_004.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_003.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_003.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_merged_R2.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_merged_R2.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R2_005.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R2_005.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_006.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_006.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_AATCCAGC_L001_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_AATCCAGC_L001_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP/5781_Q_IP_merged_R1.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1/Sample_5781_Q_IP
basename:  5781_Q_IP_merged_R1.fastq
```
</details>
<br />

<a id="trf4_ssrna_april2022-datasets"></a>
#### `TRF4_SSRNA_April2022` datasets
<details>
<summary><i>Notes, etc.: TRF4_SSRNA_April2022 datasets</i></summary>

Use the files in "`~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/*_R{1,3}_001.fastq.gz`" ~~`#TBD`~~ `#DEKHO`

<details>
<summary><i>Scratch work to determine the above</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla \
    || echo "cd'ing failed; check on this..."

.,
# total 42G
# drwxr-s--- 2 agreenla 6.6K Sep 29 18:49 ./
# drwxrws--- 3 agreenla   90 Oct 26 15:22 ../
# -rw-r----- 1 agreenla 155M Sep 29 18:48 SAMPLE_BM10_DSp48_5781_S22_I1_001.fastq.gz
# -rw-r----- 1 agreenla 144M Sep 29 18:47 SAMPLE_BM10_DSp48_5781_S22_I2_001.fastq.gz
# -rw-r----- 1 agreenla 653M Sep 29 18:47 SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
# -rw-r----- 1 agreenla 268M Sep 29 18:49 SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz
# -rw-r----- 1 agreenla 659M Sep 29 18:50 SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
# -rw-r----- 1 agreenla 163M Sep 29 18:46 SAMPLE_BM11_DSp48_7080_S23_I1_001.fastq.gz
# -rw-r----- 1 agreenla 133M Sep 29 18:49 SAMPLE_BM11_DSp48_7080_S23_I2_001.fastq.gz
# -rw-r----- 1 agreenla 643M Sep 29 18:47 SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
# -rw-r----- 1 agreenla 266M Sep 29 18:49 SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq.gz
# -rw-r----- 1 agreenla 650M Sep 29 18:46 SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
# -rw-r----- 1 agreenla 148M Sep 29 18:48 SAMPLE_BM1_DSm2_5781_S13_I1_001.fastq.gz
# -rw-r----- 1 agreenla 147M Sep 29 18:49 SAMPLE_BM1_DSm2_5781_S13_I2_001.fastq.gz
# -rw-r----- 1 agreenla 634M Sep 29 18:48 SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
# -rw-r----- 1 agreenla 251M Sep 29 18:47 SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz
# -rw-r----- 1 agreenla 639M Sep 29 18:47 SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
# -rw-r----- 1 agreenla 162M Sep 29 18:49 SAMPLE_BM2_DSm2_7080_S14_I1_001.fastq.gz
# -rw-r----- 1 agreenla 141M Sep 29 18:49 SAMPLE_BM2_DSm2_7080_S14_I2_001.fastq.gz
# -rw-r----- 1 agreenla 664M Sep 29 18:47 SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
# -rw-r----- 1 agreenla 274M Sep 29 18:49 SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq.gz
# -rw-r----- 1 agreenla 666M Sep 29 18:49 SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
# -rw-r----- 1 agreenla 150M Sep 29 18:47 SAMPLE_BM3_DSm2_7079_S15_I1_001.fastq.gz
# -rw-r----- 1 agreenla 159M Sep 29 18:48 SAMPLE_BM3_DSm2_7079_S15_I2_001.fastq.gz
# -rw-r----- 1 agreenla 685M Sep 29 18:49 SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
# -rw-r----- 1 agreenla 271M Sep 29 18:46 SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz
# -rw-r----- 1 agreenla 688M Sep 29 18:47 SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
# -rw-r----- 1 agreenla 139M Sep 29 18:48 SAMPLE_BM4_DSp2_5781_S16_I1_001.fastq.gz
# -rw-r----- 1 agreenla 113M Sep 29 18:47 SAMPLE_BM4_DSp2_5781_S16_I2_001.fastq.gz
# -rw-r----- 1 agreenla 584M Sep 29 18:49 SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
# -rw-r----- 1 agreenla 233M Sep 29 18:47 SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz
# -rw-r----- 1 agreenla 587M Sep 29 18:46 SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
# -rw-r----- 1 agreenla 177M Sep 29 18:49 SAMPLE_BM5_DSp2_7080_S17_I1_001.fastq.gz
# -rw-r----- 1 agreenla 171M Sep 29 18:46 SAMPLE_BM5_DSp2_7080_S17_I2_001.fastq.gz
# -rw-r----- 1 agreenla 720M Sep 29 18:49 SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
# -rw-r----- 1 agreenla 286M Sep 29 18:49 SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq.gz
# -rw-r----- 1 agreenla 720M Sep 29 18:48 SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
# -rw-r----- 1 agreenla 162M Sep 29 18:49 SAMPLE_BM6_DSp2_7079_S18_I1_001.fastq.gz
# -rw-r----- 1 agreenla 145M Sep 29 18:49 SAMPLE_BM6_DSp2_7079_S18_I2_001.fastq.gz
# -rw-r----- 1 agreenla 682M Sep 29 18:46 SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
# -rw-r----- 1 agreenla 274M Sep 29 18:49 SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz
# -rw-r----- 1 agreenla 685M Sep 29 18:48 SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
# -rw-r----- 1 agreenla 139M Sep 29 18:47 SAMPLE_BM7_DSp24_5781_S19_I1_001.fastq.gz
# -rw-r----- 1 agreenla 128M Sep 29 18:47 SAMPLE_BM7_DSp24_5781_S19_I2_001.fastq.gz
# -rw-r----- 1 agreenla 632M Sep 29 18:49 SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
# -rw-r----- 1 agreenla 256M Sep 29 18:49 SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz
# -rw-r----- 1 agreenla 636M Sep 29 18:49 SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
# -rw-r----- 1 agreenla 153M Sep 29 18:47 SAMPLE_BM8_DSp24_7080_S20_I1_001.fastq.gz
# -rw-r----- 1 agreenla 136M Sep 29 18:49 SAMPLE_BM8_DSp24_7080_S20_I2_001.fastq.gz
# -rw-r----- 1 agreenla 707M Sep 29 18:49 SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
# -rw-r----- 1 agreenla 280M Sep 29 18:47 SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq.gz
# -rw-r----- 1 agreenla 711M Sep 29 18:47 SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
# -rw-r----- 1 agreenla 169M Sep 29 18:47 SAMPLE_BM9_DSp24_7079_S21_I1_001.fastq.gz
# -rw-r----- 1 agreenla 128M Sep 29 18:46 SAMPLE_BM9_DSp24_7079_S21_I2_001.fastq.gz
# -rw-r----- 1 agreenla 651M Sep 29 18:49 SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
# -rw-r----- 1 agreenla 262M Sep 29 18:47 SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz
# -rw-r----- 1 agreenla 656M Sep 29 18:47 SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
# -rw-r----- 1 agreenla 132M Sep 29 18:48 SAMPLE_Bp10_DSp48_5782_S10_I1_001.fastq.gz
# -rw-r----- 1 agreenla 139M Sep 29 18:49 SAMPLE_Bp10_DSp48_5782_S10_I2_001.fastq.gz
# -rw-r----- 1 agreenla 602M Sep 29 18:48 SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
# -rw-r----- 1 agreenla 249M Sep 29 18:48 SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz
# -rw-r----- 1 agreenla 609M Sep 29 18:46 SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
# -rw-r----- 1 agreenla 158M Sep 29 18:48 SAMPLE_Bp11_DSp48_7081_S11_I1_001.fastq.gz
# -rw-r----- 1 agreenla 139M Sep 29 18:48 SAMPLE_Bp11_DSp48_7081_S11_I2_001.fastq.gz
# -rw-r----- 1 agreenla 679M Sep 29 18:47 SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
# -rw-r----- 1 agreenla 286M Sep 29 18:47 SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq.gz
# -rw-r----- 1 agreenla 688M Sep 29 18:49 SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
# -rw-r----- 1 agreenla 166M Sep 29 18:48 SAMPLE_Bp12_DSp48_7078_S12_I1_001.fastq.gz
# -rw-r----- 1 agreenla 149M Sep 29 18:49 SAMPLE_Bp12_DSp48_7078_S12_I2_001.fastq.gz
# -rw-r----- 1 agreenla 736M Sep 29 18:48 SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
# -rw-r----- 1 agreenla 301M Sep 29 18:49 SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz
# -rw-r----- 1 agreenla 745M Sep 29 18:46 SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
# -rw-r----- 1 agreenla 122M Sep 29 18:47 SAMPLE_Bp1_DSm2_5782_S1_I1_001.fastq.gz
# -rw-r----- 1 agreenla 109M Sep 29 18:47 SAMPLE_Bp1_DSm2_5782_S1_I2_001.fastq.gz
# -rw-r----- 1 agreenla 516M Sep 29 18:47 SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
# -rw-r----- 1 agreenla 205M Sep 29 18:47 SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz
# -rw-r----- 1 agreenla 519M Sep 29 18:48 SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
# -rw-r----- 1 agreenla 131M Sep 29 18:49 SAMPLE_Bp2_DSm2_7081_S2_I1_001.fastq.gz
# -rw-r----- 1 agreenla 126M Sep 29 18:48 SAMPLE_Bp2_DSm2_7081_S2_I2_001.fastq.gz
# -rw-r----- 1 agreenla 605M Sep 29 18:47 SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
# -rw-r----- 1 agreenla 239M Sep 29 18:47 SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq.gz
# -rw-r----- 1 agreenla 609M Sep 29 18:47 SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
# -rw-r----- 1 agreenla 130M Sep 29 18:48 SAMPLE_Bp3_DSm2_7078_S3_I1_001.fastq.gz
# -rw-r----- 1 agreenla 108M Sep 29 18:49 SAMPLE_Bp3_DSm2_7078_S3_I2_001.fastq.gz
# -rw-r----- 1 agreenla 540M Sep 29 18:47 SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
# -rw-r----- 1 agreenla 215M Sep 29 18:47 SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq.gz
# -rw-r----- 1 agreenla 543M Sep 29 18:48 SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
# -rw-r----- 1 agreenla 147M Sep 29 18:48 SAMPLE_Bp4_DSp2_5782_S4_I1_001.fastq.gz
# -rw-r----- 1 agreenla 128M Sep 29 18:48 SAMPLE_Bp4_DSp2_5782_S4_I2_001.fastq.gz
# -rw-r----- 1 agreenla 639M Sep 29 18:48 SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
# -rw-r----- 1 agreenla 256M Sep 29 18:48 SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq.gz
# -rw-r----- 1 agreenla 642M Sep 29 18:47 SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
# -rw-r----- 1 agreenla 181M Sep 29 18:47 SAMPLE_Bp5_DSp2_7081_S5_I1_001.fastq.gz
# -rw-r----- 1 agreenla 148M Sep 29 18:46 SAMPLE_Bp5_DSp2_7081_S5_I2_001.fastq.gz
# -rw-r----- 1 agreenla 738M Sep 29 18:48 SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
# -rw-r----- 1 agreenla 293M Sep 29 18:48 SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq.gz
# -rw-r----- 1 agreenla 741M Sep 29 18:48 SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
# -rw-r----- 1 agreenla 138M Sep 29 18:48 SAMPLE_Bp6_DSp2_7078_S6_I1_001.fastq.gz
# -rw-r----- 1 agreenla 126M Sep 29 18:48 SAMPLE_Bp6_DSp2_7078_S6_I2_001.fastq.gz
# -rw-r----- 1 agreenla 641M Sep 29 18:48 SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
# -rw-r----- 1 agreenla 255M Sep 29 18:48 SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq.gz
# -rw-r----- 1 agreenla 647M Sep 29 18:49 SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
# -rw-r----- 1 agreenla 139M Sep 29 18:47 SAMPLE_Bp7_DSp24_5782_S7_I1_001.fastq.gz
# -rw-r----- 1 agreenla 129M Sep 29 18:48 SAMPLE_Bp7_DSp24_5782_S7_I2_001.fastq.gz
# -rw-r----- 1 agreenla 644M Sep 29 18:46 SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
# -rw-r----- 1 agreenla 258M Sep 29 18:47 SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq.gz
# -rw-r----- 1 agreenla 651M Sep 29 18:48 SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
# -rw-r----- 1 agreenla 170M Sep 29 18:48 SAMPLE_Bp8_DSp24_7081_S8_I1_001.fastq.gz
# -rw-r----- 1 agreenla 154M Sep 29 18:48 SAMPLE_Bp8_DSp24_7081_S8_I2_001.fastq.gz
# -rw-r----- 1 agreenla 714M Sep 29 18:49 SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
# -rw-r----- 1 agreenla 291M Sep 29 18:48 SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq.gz
# -rw-r----- 1 agreenla 719M Sep 29 18:49 SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
# -rw-r----- 1 agreenla 119M Sep 29 18:46 SAMPLE_Bp9_DSp24_7078_S9_I1_001.fastq.gz
# -rw-r----- 1 agreenla 119M Sep 29 18:49 SAMPLE_Bp9_DSp24_7078_S9_I2_001.fastq.gz
# -rw-r----- 1 agreenla 533M Sep 29 18:46 SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
# -rw-r----- 1 agreenla 213M Sep 29 18:47 SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq.gz
# -rw-r----- 1 agreenla 538M Sep 29 18:48 SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz

cd ~/tsukiyamalab/alisong/TRF4_SSRNA_April2022 \
    || echo "cd'ing failed; check on this..."
.,
# total 952K
# drwxrws---  7 agreenla  401 Jan 16 11:12  ./
# drwxrws--- 49 agreenla 2.2K Jan 13 17:50  ../
# drwxrws--- 27 agreenla 1.1K Jan 16 11:12  20S/
# -rw-rw----  1 agreenla  13K May 26  2022  background_dependence.pzfx
# -rw-rw----  1 agreenla  16K May 26  2022  chromosomes.xlsx
# -rw-rw----  1 agreenla  17K May 26  2022 'IS trf4 null polyploid at CHRXVI in the literature.docx'
# drwxrws--- 26 agreenla 1.1K Jan 16 11:12  KL/
# -rw-rw----  1 agreenla  17K Jul 25 17:39  media_change_Q_entry.pzfx
# -rw-rw----  1 agreenla 1.2K May 26  2022  multi_bam_summary
# drwxr-s--- 27 agreenla 1.4K May  2  2022  Project_agreenla/
# drwxrws---  6 agreenla  219 Jan 16 11:12  TEST/
# drwxrws---  3 agreenla   34 Jan 16 11:11  UMI_information/
# -rw-rw----  1 agreenla  54K May 26  2022  various_trf4_RNAseq.pzfx

cd Project_agreenla/ && .,
# total 1.5M
# drwxr-s--- 27 agreenla 1.4K May  2  2022 ./
# drwxrws---  7 agreenla  401 Jan 16 11:12 ../
# -rw-rw----  1 agreenla 4.0K Apr 19  2022 ._.DS_Store
# -rw-rw----  1 agreenla  19K Jan 13 17:50 .DS_Store
# drwxrws---  2 agreenla  470 Apr 19  2022 SAMPLE_BM10_DSp48_5781/
# drwxrws---  2 agreenla  470 Apr 19  2022 SAMPLE_BM11_DSp48_7080/
# drwxrws---  2 agreenla  452 Apr 19  2022 SAMPLE_BM1_DSm2_5781/
# drwxrws---  2 agreenla  452 Apr 19  2022 SAMPLE_BM2_DSm2_7080/
# drwxrws---  2 agreenla  452 Apr 19  2022 SAMPLE_BM3_DSm2_7079/
# drwxrws---  2 agreenla  452 Apr 19  2022 SAMPLE_BM4_DSp2_5781/
# drwxrws---  2 agreenla  452 Apr 19  2022 SAMPLE_BM5_DSp2_7080/
# drwxrws---  2 agreenla  452 Apr 20  2022 SAMPLE_BM6_DSp2_7079/
# drwxrws---  2 agreenla  461 Apr 20  2022 SAMPLE_BM7_DSp24_5781/
# drwxrws---  2 agreenla  461 Apr 20  2022 SAMPLE_BM8_DSp24_7080/
# drwxrws---  2 agreenla  461 Apr 20  2022 SAMPLE_BM9_DSp24_7079/
# drwxrws---  2 agreenla  470 Apr 20  2022 SAMPLE_Bp10_DSp48_5782/
# drwxrws---  2 agreenla  470 Apr 20  2022 SAMPLE_Bp11_DSp48_7081/
# drwxrws---  2 agreenla  470 Apr 20  2022 SAMPLE_Bp12_DSp48_7078/
# drwxrws---  2 agreenla  450 Apr 20  2022 SAMPLE_Bp1_DSm2_5782/
# drwxrws---  2 agreenla  450 Apr 20  2022 SAMPLE_Bp2_DSm2_7081/
# drwxrws---  2 agreenla  450 Apr 20  2022 SAMPLE_Bp3_DSm2_7078/
# drwxrws---  2 agreenla  450 Apr 20  2022 SAMPLE_Bp4_DSp2_5782/
# drwxrws---  2 agreenla  450 Apr 20  2022 SAMPLE_Bp5_DSp2_7081/
# drwxrws---  2 agreenla  450 Apr 20  2022 SAMPLE_Bp6_DSp2_7078/
# drwxrws---  2 agreenla  459 Apr 20  2022 SAMPLE_Bp7_DSp24_5782/
# drwxrws---  2 agreenla  459 Apr 20  2022 SAMPLE_Bp8_DSp24_7081/
# drwxrws---  2 agreenla  459 Apr 20  2022 SAMPLE_Bp9_DSp24_7078/
# -rw-rw----  1 agreenla 4.0K May  2  2022 ._Scaling.xlsx
# -rw-rw----  1 agreenla  14K Apr 25  2022 Scaling.xlsx
# -rw-rw----  1 agreenla 4.0K Apr 20  2022 ._sc_bowtie_RNA_AG220419.sh
# -rw-rw----  1 agreenla 6.7K Apr 19  2022 sc_bowtie_RNA_AG220419.sh
# -rw-rw----  1 agreenla 4.0K Apr 20  2022 ._sc_bowtie_RNA_AG220419_split_only.sh
# -rw-rw----  1 agreenla 6.4K Apr 20  2022 sc_bowtie_RNA_AG220419_split_only.sh
# drwxrws---  4 agreenla 2.8K Jan 16 11:12 S_cerevisiae_BamFiles/
# drwxrws---  2 agreenla   41 Aug 31  2020 scripts/
# -rw-rw----  1 agreenla 4.0K Apr 20  2022 ._slurm-53880790.out
# -rw-rw----  1 agreenla  51K Apr 20  2022 slurm-53880790.out
# -rw-rw----  1 agreenla 4.0K Apr 21  2022 ._slurm-53930077.out
# -rw-rw----  1 agreenla  16K Apr 21  2022 slurm-53930077.out

find . -type f -name "*.fastq" | sort
# ./SAMPLE_BM10_DSp48_5781/BM10_DSp48_5781_merged_R1.fastq
# ./SAMPLE_BM10_DSp48_5781/BM10_DSp48_5781_merged_R2.fastq
# ./SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq
# ./SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq
# ./SAMPLE_BM11_DSp48_7080/BM11_DSp48_7080_merged_R1.fastq
# ./SAMPLE_BM11_DSp48_7080/BM11_DSp48_7080_merged_R2.fastq
# ./SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq
# ./SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq
# ./SAMPLE_BM1_DSm2_5781/BM1_DSm2_5781_merged_R1.fastq
# ./SAMPLE_BM1_DSm2_5781/BM1_DSm2_5781_merged_R2.fastq
# ./SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq
# ./SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq
# ./SAMPLE_BM2_DSm2_7080/BM2_DSm2_7080_merged_R1.fastq
# ./SAMPLE_BM2_DSm2_7080/BM2_DSm2_7080_merged_R2.fastq
# ./SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq
# ./SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq
# ./SAMPLE_BM3_DSm2_7079/BM3_DSm2_7079_merged_R1.fastq
# ./SAMPLE_BM3_DSm2_7079/BM3_DSm2_7079_merged_R2.fastq
# ./SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq
# ./SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq
# ./SAMPLE_BM4_DSp2_5781/BM4_DSp2_5781_merged_R1.fastq
# ./SAMPLE_BM4_DSp2_5781/BM4_DSp2_5781_merged_R2.fastq
# ./SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq
# ./SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq
# ./SAMPLE_BM5_DSp2_7080/BM5_DSp2_7080_merged_R1.fastq
# ./SAMPLE_BM5_DSp2_7080/BM5_DSp2_7080_merged_R2.fastq
# ./SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq
# ./SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq
# ./SAMPLE_BM6_DSp2_7079/BM6_DSp2_7079_merged_R1.fastq
# ./SAMPLE_BM6_DSp2_7079/BM6_DSp2_7079_merged_R2.fastq
# ./SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq
# ./SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq
# ./SAMPLE_BM7_DSp24_5781/BM7_DSp24_5781_merged_R1.fastq
# ./SAMPLE_BM7_DSp24_5781/BM7_DSp24_5781_merged_R2.fastq
# ./SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq
# ./SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq
# ./SAMPLE_BM8_DSp24_7080/BM8_DSp24_7080_merged_R1.fastq
# ./SAMPLE_BM8_DSp24_7080/BM8_DSp24_7080_merged_R2.fastq
# ./SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq
# ./SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq
# ./SAMPLE_BM9_DSp24_7079/BM9_DSp24_7079_merged_R1.fastq
# ./SAMPLE_BM9_DSp24_7079/BM9_DSp24_7079_merged_R2.fastq
# ./SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq
# ./SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq
# ./SAMPLE_Bp10_DSp48_5782/Bp10_DSp48_5782_merged_R1.fastq
# ./SAMPLE_Bp10_DSp48_5782/Bp10_DSp48_5782_merged_R2.fastq
# ./SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq
# ./SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq
# ./SAMPLE_Bp11_DSp48_7081/Bp11_DSp48_7081_merged_R1.fastq
# ./SAMPLE_Bp11_DSp48_7081/Bp11_DSp48_7081_merged_R2.fastq
# ./SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq
# ./SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq
# ./SAMPLE_Bp12_DSp48_7078/Bp12_DSp48_7078_merged_R1.fastq
# ./SAMPLE_Bp12_DSp48_7078/Bp12_DSp48_7078_merged_R2.fastq
# ./SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq
# ./SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq
# ./SAMPLE_Bp1_DSm2_5782/Bp1_DSm2_5782_merged_R1.fastq
# ./SAMPLE_Bp1_DSm2_5782/Bp1_DSm2_5782_merged_R2.fastq
# ./SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq
# ./SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq
# ./SAMPLE_Bp2_DSm2_7081/Bp2_DSm2_7081_merged_R1.fastq
# ./SAMPLE_Bp2_DSm2_7081/Bp2_DSm2_7081_merged_R2.fastq
# ./SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq
# ./SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq
# ./SAMPLE_Bp3_DSm2_7078/Bp3_DSm2_7078_merged_R1.fastq
# ./SAMPLE_Bp3_DSm2_7078/Bp3_DSm2_7078_merged_R2.fastq
# ./SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq
# ./SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq
# ./SAMPLE_Bp4_DSp2_5782/Bp4_DSp2_5782_merged_R1.fastq
# ./SAMPLE_Bp4_DSp2_5782/Bp4_DSp2_5782_merged_R2.fastq
# ./SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq
# ./SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq
# ./SAMPLE_Bp5_DSp2_7081/Bp5_DSp2_7081_merged_R1.fastq
# ./SAMPLE_Bp5_DSp2_7081/Bp5_DSp2_7081_merged_R2.fastq
# ./SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq
# ./SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq
# ./SAMPLE_Bp6_DSp2_7078/Bp6_DSp2_7078_merged_R1.fastq
# ./SAMPLE_Bp6_DSp2_7078/Bp6_DSp2_7078_merged_R2.fastq
# ./SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq
# ./SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq
# ./SAMPLE_Bp7_DSp24_5782/Bp7_DSp24_5782_merged_R1.fastq
# ./SAMPLE_Bp7_DSp24_5782/Bp7_DSp24_5782_merged_R2.fastq
# ./SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq
# ./SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq
# ./SAMPLE_Bp8_DSp24_7081/Bp8_DSp24_7081_merged_R1.fastq
# ./SAMPLE_Bp8_DSp24_7081/Bp8_DSp24_7081_merged_R2.fastq
# ./SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq
# ./SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq
# ./SAMPLE_Bp9_DSp24_7078/Bp9_DSp24_7078_merged_R1.fastq
# ./SAMPLE_Bp9_DSp24_7078/Bp9_DSp24_7078_merged_R2.fastq
# ./SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq
# ./SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq

., */*fastq | sort
# -rw-rw---- 1 agreenla 2.9G Apr 19  2022 SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq
# -rw-rw---- 1 agreenla 2.9G Apr 19  2022 SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq
# -rw-rw---- 1 agreenla 2.9G Apr 20  2022 SAMPLE_Bp1_DSm2_5782/Bp1_DSm2_5782_merged_R1.fastq
# -rw-rw---- 1 agreenla 2.9G Apr 20  2022 SAMPLE_Bp1_DSm2_5782/Bp1_DSm2_5782_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 19  2022 SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 19  2022 SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 19  2022 SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 19  2022 SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 20  2022 SAMPLE_Bp3_DSm2_7078/Bp3_DSm2_7078_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 20  2022 SAMPLE_Bp3_DSm2_7078/Bp3_DSm2_7078_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 20  2022 SAMPLE_Bp9_DSp24_7078/Bp9_DSp24_7078_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.0G Apr 20  2022 SAMPLE_Bp9_DSp24_7078/Bp9_DSp24_7078_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.3G Apr 19  2022 SAMPLE_BM4_DSp2_5781/BM4_DSp2_5781_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.3G Apr 19  2022 SAMPLE_BM4_DSp2_5781/BM4_DSp2_5781_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.3G Apr 19  2022 SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq
# -rw-rw---- 1 agreenla 3.3G Apr 19  2022 SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq
# -rw-rw---- 1 agreenla 3.4G Apr 19  2022 SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq
# -rw-rw---- 1 agreenla 3.4G Apr 19  2022 SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq
# -rw-rw---- 1 agreenla 3.4G Apr 20  2022 SAMPLE_Bp2_DSm2_7081/Bp2_DSm2_7081_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.4G Apr 20  2022 SAMPLE_Bp2_DSm2_7081/Bp2_DSm2_7081_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 19  2022 SAMPLE_BM1_DSm2_5781/BM1_DSm2_5781_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 19  2022 SAMPLE_BM1_DSm2_5781/BM1_DSm2_5781_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 19  2022 SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 19  2022 SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 19  2022 SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 19  2022 SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 20  2022 SAMPLE_Bp10_DSp48_5782/Bp10_DSp48_5782_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.5G Apr 20  2022 SAMPLE_Bp10_DSp48_5782/Bp10_DSp48_5782_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 19  2022 SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_BM7_DSp24_5781/BM7_DSp24_5781_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_BM7_DSp24_5781/BM7_DSp24_5781_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_BM9_DSp24_7079/BM9_DSp24_7079_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_BM9_DSp24_7079/BM9_DSp24_7079_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_Bp4_DSp2_5782/Bp4_DSp2_5782_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_Bp4_DSp2_5782/Bp4_DSp2_5782_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_Bp6_DSp2_7078/Bp6_DSp2_7078_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_Bp6_DSp2_7078/Bp6_DSp2_7078_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_Bp7_DSp24_5782/Bp7_DSp24_5782_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.6G Apr 20  2022 SAMPLE_Bp7_DSp24_5782/Bp7_DSp24_5782_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM10_DSp48_5781/BM10_DSp48_5781_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM10_DSp48_5781/BM10_DSp48_5781_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM11_DSp48_7080/BM11_DSp48_7080_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM11_DSp48_7080/BM11_DSp48_7080_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM2_DSm2_7080/BM2_DSm2_7080_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM2_DSm2_7080/BM2_DSm2_7080_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq
# -rw-rw---- 1 agreenla 3.7G Apr 19  2022 SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM3_DSm2_7079/BM3_DSm2_7079_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM3_DSm2_7079/BM3_DSm2_7079_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM6_DSp2_7079/BM6_DSp2_7079_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM6_DSp2_7079/BM6_DSp2_7079_merged_R2.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq
# -rw-rw---- 1 agreenla 3.8G Apr 19  2022 SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq
# -rw-rw---- 1 agreenla 3.9G Apr 19  2022 SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq
# -rw-rw---- 1 agreenla 3.9G Apr 19  2022 SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq
# -rw-rw---- 1 agreenla 3.9G Apr 20  2022 SAMPLE_Bp11_DSp48_7081/Bp11_DSp48_7081_merged_R1.fastq
# -rw-rw---- 1 agreenla 3.9G Apr 20  2022 SAMPLE_Bp11_DSp48_7081/Bp11_DSp48_7081_merged_R2.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_BM5_DSp2_7080/BM5_DSp2_7080_merged_R1.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_BM5_DSp2_7080/BM5_DSp2_7080_merged_R2.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 19  2022 SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 20  2022 SAMPLE_BM8_DSp24_7080/BM8_DSp24_7080_merged_R1.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 20  2022 SAMPLE_BM8_DSp24_7080/BM8_DSp24_7080_merged_R2.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 20  2022 SAMPLE_Bp8_DSp24_7081/Bp8_DSp24_7081_merged_R1.fastq
# -rw-rw---- 1 agreenla 4.0G Apr 20  2022 SAMPLE_Bp8_DSp24_7081/Bp8_DSp24_7081_merged_R2.fastq
# -rw-rw---- 1 agreenla 4.1G Apr 19  2022 SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq
# -rw-rw---- 1 agreenla 4.1G Apr 19  2022 SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq
# -rw-rw---- 1 agreenla 4.1G Apr 20  2022 SAMPLE_Bp5_DSp2_7081/Bp5_DSp2_7081_merged_R1.fastq
# -rw-rw---- 1 agreenla 4.1G Apr 20  2022 SAMPLE_Bp5_DSp2_7081/Bp5_DSp2_7081_merged_R2.fastq
# -rw-rw---- 1 agreenla 4.2G Apr 19  2022 SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq
# -rw-rw---- 1 agreenla 4.2G Apr 19  2022 SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq
# -rw-rw---- 1 agreenla 4.2G Apr 20  2022 SAMPLE_Bp12_DSp48_7078/Bp12_DSp48_7078_merged_R1.fastq
# -rw-rw---- 1 agreenla 4.2G Apr 20  2022 SAMPLE_Bp12_DSp48_7078/Bp12_DSp48_7078_merged_R2.fastq

cd SAMPLE_BM10_DSp48_5781/ \
    || echo "cd'ing failed; check on this..."
# /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM10_DSp48_5781

.,
# total 23G
# drwxrws---  2 agreenla  470 Apr 19  2022 ./
# drwxr-s--- 27 agreenla 1.4K May  2  2022 ../
# -rw-rw----  1 agreenla 1.7K Apr 19  2022 bam_split_paired_end.sh
# -rw-rw----  1 agreenla 1.6K Apr 19  2022 BM10_DSp48_5781.log
# -rw-rw----  1 agreenla 845M Apr 19  2022 BM10_DSp48_5781_mapped.bam
# -rw-rw----  1 agreenla 5.1G Apr 19  2022 BM10_DSp48_5781_mapped.sam
# -rw-rw----  1 agreenla 3.7G Apr 19  2022 BM10_DSp48_5781_merged_R1.fastq
# -rw-rw----  1 agreenla 3.7G Apr 19  2022 BM10_DSp48_5781_merged_R2.fastq
# -rw-rw----  1 agreenla 443M Apr 19  2022 BM10_DSp48_5781_sorted.bam
# -rw-rw----  1 agreenla  37K Apr 19  2022 BM10_DSp48_5781_sorted.bam.bai
# -rw-rw----  1 agreenla 3.7G Apr 19  2022 SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq
# -rw-rw----  1 agreenla 3.7G Apr 19  2022 SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq
```
</details>
</details>
<br />

<a id="clean-things-up-trf4_ssrna_april2022"></a>
##### Clean things up: `TRF4_SSRNA_April2022`
<details>
<summary><i>Code: Clean things up: TRF4_SSRNA_April2022</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/TRF4_SSRNA_April2022"
cd "${dir}"


#  rm *.sam files ---------------------
find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find ${dir} \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find ${dir} \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: TRF4_SSRNA_April2022</i></summary>

```txt
Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM4_DSp2_5781
basename:  SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM4_DSp2_5781
basename:  SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM10_DSp48_5781
basename:  SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM10_DSp48_5781
basename:  SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM7_DSp24_5781
basename:  SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM7_DSp24_5781
basename:  SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM11_DSp48_7080
basename:  SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM11_DSp48_7080
basename:  SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp7_DSp24_5782
basename:  SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp7_DSp24_5782
basename:  SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM9_DSp24_7079
basename:  SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM9_DSp24_7079
basename:  SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp4_DSp2_5782
basename:  SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp4_DSp2_5782
basename:  SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM6_DSp2_7079
basename:  SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM6_DSp2_7079
basename:  SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp12_DSp48_7078
basename:  SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp12_DSp48_7078
basename:  SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp5_DSp2_7081
basename:  SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp5_DSp2_7081
basename:  SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp6_DSp2_7078
basename:  SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp6_DSp2_7078
basename:  SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp9_DSp24_7078
basename:  SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp9_DSp24_7078
basename:  SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp2_DSm2_7081
basename:  SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp2_DSm2_7081
basename:  SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp10_DSp48_5782
basename:  SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp10_DSp48_5782
basename:  SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp1_DSm2_5782
basename:  SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp1_DSm2_5782
basename:  SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM5_DSp2_7080
basename:  SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM5_DSp2_7080
basename:  SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM3_DSm2_7079
basename:  SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM3_DSm2_7079
basename:  SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp3_DSm2_7078
basename:  SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp3_DSm2_7078
basename:  SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM2_DSm2_7080
basename:  SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM2_DSm2_7080
basename:  SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM8_DSp24_7080
basename:  SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_BM8_DSp24_7080
basename:  SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp8_DSp24_7081
basename:  SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/KL/SAMPLE_Bp8_DSp24_7081
basename:  SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/TEST/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/TEST/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/TEST/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/TEST/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM4_DSp2_5781
basename:  SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM4_DSp2_5781
basename:  SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM10_DSp48_5781
basename:  SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM10_DSp48_5781
basename:  SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM7_DSp24_5781
basename:  SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM7_DSp24_5781
basename:  SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM11_DSp48_7080
basename:  SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM11_DSp48_7080
basename:  SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp7_DSp24_5782
basename:  SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp7_DSp24_5782
basename:  SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM9_DSp24_7079
basename:  SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM9_DSp24_7079
basename:  SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp4_DSp2_5782
basename:  SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp4_DSp2_5782
basename:  SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM6_DSp2_7079
basename:  SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM6_DSp2_7079
basename:  SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp12_DSp48_7078
basename:  SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp12_DSp48_7078
basename:  SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp5_DSp2_7081
basename:  SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp5_DSp2_7081
basename:  SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/Bp11_Repeat/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/Bp11_Repeat/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/Bp11_Repeat/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/Bp11_Repeat/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp6_DSp2_7078
basename:  SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp6_DSp2_7078
basename:  SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp9_DSp24_7078
basename:  SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp9_DSp24_7078
basename:  SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp2_DSm2_7081
basename:  SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp2_DSm2_7081
basename:  SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp10_DSp48_5782
basename:  SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp10_DSp48_5782
basename:  SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp1_DSm2_5782
basename:  SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp1_DSm2_5782
basename:  SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM5_DSp2_7080
basename:  SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM5_DSp2_7080
basename:  SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM3_DSm2_7079
basename:  SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM3_DSm2_7079
basename:  SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp3_DSm2_7078
basename:  SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp3_DSm2_7078
basename:  SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM2_DSm2_7080
basename:  SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM2_DSm2_7080
basename:  SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq
Segmentation fault (core dumped)

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM8_DSp24_7080
basename:  SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_BM8_DSp24_7080
basename:  SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp8_DSp24_7081
basename:  SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/20S/SAMPLE_Bp8_DSp24_7081
basename:  SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM4_DSp2_5781
basename:  SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM4_DSp2_5781/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM4_DSp2_5781
basename:  SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM10_DSp48_5781
basename:  SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM10_DSp48_5781/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM10_DSp48_5781
basename:  SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM1_DSm2_5781/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM1_DSm2_5781
basename:  SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM7_DSp24_5781
basename:  SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM7_DSp24_5781/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM7_DSp24_5781
basename:  SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM11_DSp48_7080
basename:  SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM11_DSp48_7080/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM11_DSp48_7080
basename:  SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp7_DSp24_5782
basename:  SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp7_DSp24_5782/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp7_DSp24_5782
basename:  SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM9_DSp24_7079
basename:  SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM9_DSp24_7079/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM9_DSp24_7079
basename:  SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp4_DSp2_5782
basename:  SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp4_DSp2_5782/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp4_DSp2_5782
basename:  SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM6_DSp2_7079
basename:  SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM6_DSp2_7079/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM6_DSp2_7079
basename:  SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp12_DSp48_7078
basename:  SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp12_DSp48_7078/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp12_DSp48_7078
basename:  SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp5_DSp2_7081
basename:  SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp5_DSp2_7081/SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp5_DSp2_7081
basename:  SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp6_DSp2_7078
basename:  SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp6_DSp2_7078/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp6_DSp2_7078
basename:  SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp9_DSp24_7078
basename:  SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp9_DSp24_7078/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp9_DSp24_7078
basename:  SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp2_DSm2_7081
basename:  SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp2_DSm2_7081/SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp2_DSm2_7081
basename:  SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp10_DSp48_5782
basename:  SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp10_DSp48_5782/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp10_DSp48_5782
basename:  SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp1_DSm2_5782
basename:  SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp1_DSm2_5782/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp1_DSm2_5782
basename:  SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM5_DSp2_7080
basename:  SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM5_DSp2_7080/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM5_DSp2_7080
basename:  SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM3_DSm2_7079
basename:  SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM3_DSm2_7079/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM3_DSm2_7079
basename:  SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp3_DSm2_7078
basename:  SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp3_DSm2_7078/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp3_DSm2_7078
basename:  SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM2_DSm2_7080
basename:  SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM2_DSm2_7080/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM2_DSm2_7080
basename:  SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp11_DSp48_7081/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp11_DSp48_7081
basename:  SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM8_DSp24_7080
basename:  SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM8_DSp24_7080/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_BM8_DSp24_7080
basename:  SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp8_DSp24_7081
basename:  SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp8_DSp24_7081/SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla/SAMPLE_Bp8_DSp24_7081
basename:  SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq
```
</details>
<br />

<a id="nab3_nrd1_depletion-datasets"></a>
#### `Nab3_Nrd1_Depletion` datasets
<details>
<summary><i>Notes, etc.: Nab3_Nrd1_Depletion datasets</i></summary>

~~Use the files in "`~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/*_R{1,3}_001.fastq.gz`"~~ ~~`#TBD`~~ ~~`#DEKHO`~~  
`#TODO` There's a new path to properly multiplexed, UMI-associated files; paste that path here

<details>
<summary><i>Scratch work to determine the above</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla \
    || echo "cd'ing failed; check on this..."

.,
# total 584K
# drwxr-s--- 11 agreenla  465 Oct 18 17:33 ./
# drwxrws---  4 agreenla  745 Jan 11 11:39 ../
# -rw-rw----  1 agreenla 4.0K Oct 11 19:05 ._101122_sc_bowtie_4tu.sh
# -rw-rw----  1 agreenla 7.2K Oct 11 19:05 101122_sc_bowtie_4tu.sh
# drwxrws---  4 agreenla 5.3K Dec 12 14:47 20S/
# drwxrws---  7 agreenla 2.2K Jan 16 11:26 5782_7714/
# drwxrws---  7 agreenla 2.2K Jan 16 11:26 6125_7718/
# drwxrws---  8 agreenla 2.4K Jan 16 11:26 6126_7716/
# drwxrws---  3 agreenla 1.9K Jan 16 11:26 BIGWIGS/
# -rw-rw----  1 agreenla 4.0K Oct 11 18:20 ._.DS_Store
# -rw-rw----  1 agreenla  25K Jan 11 17:16 .DS_Store
# drwxrws---  3 agreenla 1.6K Dec 12 14:47 KL_bams_all/
# drwxrws---  5 agreenla 1.6K Dec 12 14:47 Nascent_Scaling_Test/
# -rw-rw----  1 agreenla 6.6K Oct 11 18:14 PEYeastChIPSeq_nodirV3.sh
# drwxrws---  5 agreenla 1.8K Nov  1 10:27 SC_bams_all/
# -rw-rw----  1 agreenla 6.3K Aug 31  2020 sc_bowtie_4tu.sh
# drwxrws---  2 agreenla   41 Dec 12 14:47 scripts/

., {5782_7714,6125_7718,6126_7716}/*
#  Too much to copy in here

., {5782_7714,6125_7718,6126_7716}/*_R?_001.fastq
# -rw-rw---- 1 agreenla 8.1G Oct 11 18:07 5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq
# -rw-rw---- 1 agreenla 8.1G Oct 11 18:05 5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq
# -rw-rw---- 1 agreenla 6.1G Oct 11 18:02 5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq
# -rw-rw---- 1 agreenla 6.1G Oct 11 18:07 5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq
# -rw-rw---- 1 agreenla 7.4G Oct 11 18:06 5782_7714/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq
# -rw-rw---- 1 agreenla 7.4G Oct 11 18:07 5782_7714/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq
# -rw-rw---- 1 agreenla 7.1G Oct 11 18:04 5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq
# -rw-rw---- 1 agreenla 7.1G Oct 11 18:05 5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq
# -rw-rw---- 1 agreenla 7.3G Oct 11 18:05 6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq
# -rw-rw---- 1 agreenla 7.3G Oct 11 18:05 6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq
# -rw-rw---- 1 agreenla 7.6G Oct 11 18:02 6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq
# -rw-rw---- 1 agreenla 7.6G Oct 11 18:03 6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq
# -rw-rw---- 1 agreenla 7.1G Oct 11 18:05 6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq
# -rw-rw---- 1 agreenla 7.1G Oct 11 18:06 6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq
# -rw-rw---- 1 agreenla 6.7G Oct 11 18:06 6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq
# -rw-rw---- 1 agreenla 6.7G Oct 11 18:03 6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq
# -rw-rw---- 1 agreenla 6.8G Oct 11 18:06 6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq
# -rw-rw---- 1 agreenla 6.8G Oct 11 18:04 6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq
# -rw-rw---- 1 agreenla 6.8G Oct 11 18:01 6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq
# -rw-rw---- 1 agreenla 6.8G Oct 11 18:02 6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq
# -rw-rw---- 1 agreenla 7.3G Oct 11 18:07 6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq
# -rw-rw---- 1 agreenla 7.3G Oct 11 18:03 6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq
# -rw-rw---- 1 agreenla 7.2G Oct 11 18:05 6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq
# -rw-rw---- 1 agreenla 7.2G Oct 11 18:04 6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq
```
</details>
</details>
<br />

<a id="clean-things-up-nab3_nrd1_depletion"></a>
##### Clean things up: `Nab3_Nrd1_Depletion`
<details>
<summary><i>Code: Clean things up: Nab3_Nrd1_Depletion</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion"
cd "${dir}"


#  rm *.sam files ---------------------
find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find ${dir} \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

# find ${dir} \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         ls -lhaFG {} \;
#
# find ${dir} \
#     -type f \
#     -name "*_merged_R?.fastq" \
#     -exec \
#         rm {} \;
#NOTE No "merged" .fastq files in these directories


#  run pigz, remaining *.fastq files --
unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find ${dir} \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: Nab3_Nrd1_Depletion</i></summary>

```txt
Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718
basename:  Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/CT8_redo/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/CT8_redo
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/CT8_redo/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/CT8_redo
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/20S
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT8_7716_pIAA_Q_SteadyState_S9_I2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_I2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT4_6126_pIAA_Q_Nascent_S2_I2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_I2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT4_6126_pIAA_Q_SteadyState_S7_I2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_I2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT4_6126_pIAA_Q_SteadyState_S7_I1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_I1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT8_7716_pIAA_Q_SteadyState_S9_I1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_I1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT8_7716_pIAA_Q_Nascent_S4_I1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_I1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT8_7716_pIAA_Q_Nascent_S4_I2_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_I2_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI/Sample_CT4_6126_pIAA_Q_Nascent_S2_I1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_I1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716
basename:  Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714
basename:  Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq
```
</details>
<br />

<a id="rtr1_rrp6_wt-datasets"></a>
#### `rtr1_rrp6_wt` datasets
<details>
<summary><i>Notes, etc.: rtr1_rrp6_wt datasets</i></summary>

~~Use the files in "`~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq`" `#TBD`~~  
~~Use the files in "`~/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/*_R{1,3}_001.fastq.gz`"~~  
~~Use the files in "`~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/{CW10_7747_8day_Q_IN,CW10_7747_8day_Q_PD,CW12_7748_8day_Q_IN,CW12_7748_8day_Q_PD,CW2_5781_8day_Q_IN,CW2_5781_8day_Q_PD,CW4_5782_8day_Q_IN,CW4_5782_8day_Q_PD,CW6_7078_8day_Q_IN,CW6_7078_8day_Q_PD,CW8_7079_8day_Q_IN,CW8_7079_8day_Q_PD}`~~ ~~`#DEKHO`~~  
`#TODO` There's a new path to properly multiplexed, UMI-associated files; paste that path here

<details>
<summary><i>Scratch work to determine the above</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq \
    || echo "cd'ing failed; check on this..."

# .,
# total 1.2M
# drwxrws--- 16 agreenla  753 Jan 15 12:59 ./
# drwxrws---  7 agreenla  237 Jan 13 17:08 ../
# drwxrws---  2 agreenla  476 Jan 12 14:10 CW10_7747_8day_Q_IN/
# drwxrws---  2 agreenla  478 Jan 12 14:31 CW10_7747_8day_Q_PD/
# drwxrws---  2 agreenla  476 Jan 12 14:42 CW12_7748_8day_Q_IN/
# drwxrws---  2 agreenla  478 Jan 12 15:08 CW12_7748_8day_Q_PD/
# drwxrws---  2 agreenla  467 Jan 12 15:24 CW2_5781_8day_Q_IN/
# drwxrws---  2 agreenla  467 Jan 12 15:58 CW2_5781_8day_Q_PD/
# drwxrws---  2 agreenla  467 Jan 12 16:15 CW4_5782_8day_Q_IN/
# drwxrws---  2 agreenla  467 Jan 12 16:54 CW4_5782_8day_Q_PD/
# drwxrws---  2 agreenla  467 Jan 12 17:14 CW6_7078_8day_Q_IN/
# drwxrws---  2 agreenla  467 Jan 12 17:42 CW6_7078_8day_Q_PD/
# drwxrws---  2 agreenla  578 Jan 13 15:46 CW8_7079_8day_Q_IN/
# drwxrws---  2 agreenla  469 Jan 12 18:25 CW8_7079_8day_Q_PD/
# -rw-rw----  1 agreenla 6.7K Jan 12 13:59 sc_bowtie_RNA_AG220419.sh
# drwxrws---  4 agreenla 4.9K Jan 15 12:26 S_cerevisiae_BamFiles/
# drwxrws---  2 agreenla   41 Jan 13 16:33 scripts/
# -rw-rw----  1 agreenla  14K Jan 11 16:37 slurm-7550534.out
# -rw-rw----  1 agreenla 5.5K Jan 11 16:39 slurm-7550640.out
# -rw-rw----  1 agreenla 3.1K Jan 11 16:42 slurm-7550710.out
# -rw-rw----  1 agreenla  27K Jan 11 16:52 slurm-7550749.out
# -rw-rw----  1 agreenla 7.8K Jan 12 13:33 slurm-7627292.out
# -rw-rw----  1 agreenla  26K Jan 12 19:13 slurm-7631090.out

cd CW10_7747_8day_Q_IN/
# /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN
.,
# total 28G
# drwxrws---  2 agreenla  476 Jan 12 14:10 ./
# drwxrws--- 16 agreenla  753 Jan 15 12:59 ../
# -rw-rw----  1 agreenla 1.6K Jan 12 14:10 10_7747_8day_Q_IN.log
# -rw-rw----  1 agreenla 699M Jan 12 14:09 10_7747_8day_Q_IN_mapped.bam
# -rw-rw----  1 agreenla 4.2G Jan 12 14:09 10_7747_8day_Q_IN_mapped.sam
# -rw-rw----  1 agreenla 6.9G Jan 12 14:00 10_7747_8day_Q_IN_merged_R1.fastq
# -rw-rw----  1 agreenla 6.9G Jan 12 14:01 10_7747_8day_Q_IN_merged_R3.fastq
# -rw-rw----  1 agreenla 383M Jan 12 14:10 10_7747_8day_Q_IN_sorted.bam
# -rw-rw----  1 agreenla  38K Jan 12 14:10 10_7747_8day_Q_IN_sorted.bam.bai
# -rw-rw----  1 agreenla 1.7K Jan 12 13:59 bam_split_paired_end.sh
# -rw-rw----  1 agreenla 6.9G Dec 21 12:23 CW10_7747_8day_Q_IN_S5_R1_001.fastq
# -rw-rw----  1 agreenla 6.9G Dec 21 12:23 CW10_7747_8day_Q_IN_S5_R3_001.fastq

cd ~/tsukiyamalab/alisong/rtr1_rrp6_wt \
    || echo "cd'ing failed; check on this..."

.,
# total 896K
# drwxrws---  4 agreenla  448 Jan 16 11:37  ./
# drwxrws--- 49 agreenla 2.2K Jan 13 17:50  ../
# -rw-rw----  1 agreenla  18K Dec 15 17:32  221215_lib_pooling.xlsx
# -rw-rw----  1 agreenla  165 Dec 13 00:27 '~$barcodes+samples.xlsx'
# -rw-rw----  1 agreenla 9.2K Dec 12 18:02  barcodes+samples.xlsx
# -rw-rw----  1 agreenla  11K Dec 15 17:45  INTO_LBRARY_PREP_DILUTIONS.xlsx
# -rw-rw----  1 agreenla  29K Dec 19 17:10 'Nascent RNA Labeling and Purification-Warfield_MSedit_AGedit2212.docx'
# drwxr-s---  2 agreenla 1.8K Dec 21 11:47  Project_agreenla/
# -rw-rw----  1 agreenla 7.5K Dec 19 17:12  Q_entry_rtr1_rrp6.pzfx
# -rw-rw----  1 agreenla  11K Dec 19 17:09  Q_entry_sat_labeling_20221116.xlsx
# -rw-rw----  1 agreenla  11K Nov 28 14:36  RNA_IP_Amount.xlsx
# drwxrws---  3 agreenla   34 Jan 16 11:37  Sequencinfg/

cd Project_agreenla/
# /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla

.,
# total 19G
# drwxr-s--- 2 agreenla 1.8K Dec 21 11:47 ./
# drwxrws--- 4 agreenla  448 Jan 16 11:37 ../
# -rw-rw---- 1 agreenla 250M Dec 21 11:44 CW10_7747_8day_Q_IN_S5_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 247M Dec 21 11:37 CW10_7747_8day_Q_PD_S11_I1_001.fastq.gz
# -rw-rw---- 1 agreenla 223M Dec 21 11:47 CW10_7747_8day_Q_PD_S11_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:41 CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:40 CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 272M Dec 21 11:38 CW12_7748_8day_Q_IN_S6_I1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.1G Dec 21 11:40 CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 231M Dec 21 11:41 CW12_7748_8day_Q_PD_S12_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 198M Dec 21 11:41 CW12_7748_8day_Q_PD_S12_R2_001.fastq.gz
# -rw-rw---- 1 agreenla 971M Dec 21 11:48 CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 274M Dec 21 11:38 CW2_5781_8day_Q_IN_S1_I1_001.fastq.gz
# -rw-rw---- 1 agreenla 262M Dec 21 11:41 CW2_5781_8day_Q_IN_S1_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.1G Dec 21 11:39 CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 197M Dec 21 11:41 CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz
# -rw-rw---- 1 agreenla 229M Dec 21 11:39 CW2_5781_8day_Q_PD_S7_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 245M Dec 21 11:44 CW4_5782_8day_Q_IN_S2_I1_001.fastq.gz
# -rw-rw---- 1 agreenla 231M Dec 21 11:36 CW4_5782_8day_Q_IN_S2_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 192M Dec 21 11:46 CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.1G Dec 21 11:43 CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 281M Dec 21 11:43 CW4_5782_8day_Q_PD_S8_I1_001.fastq.gz
# -rw-rw---- 1 agreenla 228M Dec 21 11:36 CW4_5782_8day_Q_PD_S8_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:37 CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:34 CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 352M Dec 21 11:46 CW6_7078_8day_Q_IN_S3_I1_001.fastq.gz
# -rw-rw---- 1 agreenla 300M Dec 21 11:47 CW6_7078_8day_Q_IN_S3_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 253M Dec 21 11:44 CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.5G Dec 21 11:42 CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 255M Dec 21 11:43 CW8_7079_8day_Q_IN_S4_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 206M Dec 21 11:34 CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:35 CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 249M Dec 21 11:45 CW8_7079_8day_Q_PD_S10_I2_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:36 CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.3G Dec 21 11:46 CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz

., ~/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/*_R{1,3}_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:41 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:40 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 1.1G Dec 21 11:40 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 971M Dec 21 11:48 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 1.1G Dec 21 11:39 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.1G Dec 21 11:43 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:37 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:34 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 1.5G Dec 21 11:42 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:35 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
# -rw-rw---- 1 agreenla 1.2G Dec 21 11:36 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
# -rw-rw---- 1 agreenla 1.3G Dec 21 11:46 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Project_agreenla/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
```
</details>
</details>
<br />

<a id="clean-things-up-rtr1_rrp6_wt"></a>
##### Clean things up: `rtr1_rrp6_wt`
<details>
<summary><i>Code: Clean things up: rtr1_rrp6_wt</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 32, default settings
Trinity_env

dir="${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt"
cd "${dir}"


#  rm *.sam files ---------------------
find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        rm {} \;

find ${dir} \
    -type f \
    -name "*.sam" \
    -exec \
        ls -lhaFG {} \;


#  rm *_merged_R?.fastq files ---------
find ${dir} \
    -type f \
    -name "*.fastq" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        ls -lhaFG {} \;

find ${dir} \
    -type f \
    -name "*_merged_R?.fastq" \
    -exec \
        rm {} \;


#  run pigz, remaining *.fastq files --
unset fq_gz
typeset -a fq_gz
while IFS=" " read -r -d $'\0'; do
    fq_gz+=( "${REPLY}" )
done < <(\
    find ${dir} \
        -type f \
        -name "*.fastq" \
        -print0
)
echo_test "${fq_gz[@]}"
echo "${#fq_gz[@]}"

for i in "${fq_gz[@]}"; do
    echo "Compressing ${i}..."
    echo " dirname:  $(dirname "${i}")"
    echo "basename:  $(basename "${i}")"
    
    cd -- "$(dirname "${i}")"
    pigz -p 32 "$(basename "${i}")"
    
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Clean things up: rtr1_rrp6_wt</i></summary>

```txt
Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW8_7079_8day_Q_PD_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW8_7079_8day_Q_PD_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW2_5781_8day_Q_IN_S1_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW2_5781_8day_Q_IN_S1_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW12_7748_8day_Q_PD_S12_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW12_7748_8day_Q_PD_S12_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW2_5781_8day_Q_PD_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW2_5781_8day_Q_PD_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW8_7079_8day_Q_IN_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW8_7079_8day_Q_IN_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW2_5781_8day_Q_PD_S7_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW2_5781_8day_Q_PD_S7_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW8_7079_8day_Q_IN_S4_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW8_7079_8day_Q_IN_S4_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW12_7748_8day_Q_PD_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW12_7748_8day_Q_PD_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW8_7079_8day_Q_PD_S10_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW8_7079_8day_Q_PD_S10_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW12_7748_8day_Q_IN_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW12_7748_8day_Q_IN_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW12_7748_8day_Q_IN_S6_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW12_7748_8day_Q_IN_S6_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748/CW2_5781_8day_Q_IN_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5781_7079_7748
basename:  CW2_5781_8day_Q_IN_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW6_7078_8day_Q_IN_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW6_7078_8day_Q_IN_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW4_5782_8day_Q_PD_S8_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW4_5782_8day_Q_PD_S8_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW4_5782_8day_Q_IN_S2_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW4_5782_8day_Q_IN_S2_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW6_7078_8day_Q_PD_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW6_7078_8day_Q_PD_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW4_5782_8day_Q_IN_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW4_5782_8day_Q_IN_S2_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW10_7747_8day_Q_IN_S5_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW10_7747_8day_Q_IN_S5_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW6_7078_8day_Q_PD_S9_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW6_7078_8day_Q_PD_S9_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW4_5782_8day_Q_PD_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW4_5782_8day_Q_PD_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW6_7078_8day_Q_IN_S3_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW6_7078_8day_Q_IN_S3_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW10_7747_8day_Q_PD_S11_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW10_7747_8day_Q_PD_S11_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW10_7747_8day_Q_IN_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW10_7747_8day_Q_IN_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747/CW10_7747_8day_Q_PD_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/5782_7078_7747
basename:  CW10_7747_8day_Q_PD_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD
basename:  CW12_7748_8day_Q_PD_S12_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD
basename:  CW12_7748_8day_Q_PD_S12_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD
basename:  CW6_7078_8day_Q_PD_S9_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD
basename:  CW6_7078_8day_Q_PD_S9_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN
basename:  CW2_5781_8day_Q_IN_S1_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN
basename:  CW2_5781_8day_Q_IN_S1_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN
basename:  CW10_7747_8day_Q_IN_S5_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN
basename:  CW10_7747_8day_Q_IN_S5_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD
basename:  CW4_5782_8day_Q_PD_S8_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD
basename:  CW4_5782_8day_Q_PD_S8_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN
basename:  CW8_7079_8day_Q_IN_S4_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN
basename:  CW8_7079_8day_Q_IN_S4_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD
basename:  CW2_5781_8day_Q_PD_S7_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD
basename:  CW2_5781_8day_Q_PD_S7_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD
basename:  CW8_7079_8day_Q_PD_S10_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD
basename:  CW8_7079_8day_Q_PD_S10_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN
basename:  CW6_7078_8day_Q_IN_S3_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN
basename:  CW6_7078_8day_Q_IN_S3_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN
basename:  CW12_7748_8day_Q_IN_S6_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN
basename:  CW12_7748_8day_Q_IN_S6_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD
basename:  CW10_7747_8day_Q_PD_S11_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD
basename:  CW10_7747_8day_Q_PD_S11_R1_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R3_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN
basename:  CW4_5782_8day_Q_IN_S2_R3_001.fastq

Compressing /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R1_001.fastq...
 dirname:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN
basename:  CW4_5782_8day_Q_IN_S2_R1_001.fastq
```
</details>
<br />

<a id="make-symbolic-links-to-the-fastq-files"></a>
### Make symbolic links to the `fastq` files
<a id="examine-all-of-the-files-that-will-be-symlinked"></a>
#### Examine all of the files that will be symlinked
<details>
<summary><i>Notes, etc.: Examine all of the files that will be symlinked</i></summary>

- `~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/*_R{1,3}_001.fastq.gz`
- `~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/*_R{1,3}_001.fastq.gz`
- `~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/*_R{1,3}_001.fastq.gz`
- `~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/{CW10_7747_8day_Q_IN,CW10_7747_8day_Q_PD,CW12_7748_8day_Q_IN,CW12_7748_8day_Q_PD,CW2_5781_8day_Q_IN,CW2_5781_8day_Q_PD,CW4_5782_8day_Q_IN,CW4_5782_8day_Q_PD,CW6_7078_8day_Q_IN,CW6_7078_8day_Q_PD,CW8_7079_8day_Q_IN,CW8_7079_8day_Q_PD}/*_R{1,3}_001.fastq.gz`

<details>
<summary><i>Scratch work for the above</i></summary>

```txt
❯ ., ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/*_R{1,3}_001.fastq.gz
-rw-rw---- 1 agreenla 490M Oct 26 18:47 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
-rw-rw---- 1 agreenla 512M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
-rw-rw---- 1 agreenla 642M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
-rw-rw---- 1 agreenla 673M Oct 26 18:47 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
-rw-rw---- 1 agreenla 497M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
-rw-rw---- 1 agreenla 518M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
-rw-rw---- 1 agreenla 774M Oct 26 18:44 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
-rw-rw---- 1 agreenla 810M Oct 26 18:44 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
-rw-rw---- 1 agreenla 474M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
-rw-rw---- 1 agreenla 497M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
-rw-rw---- 1 agreenla 637M Oct 26 18:46 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
-rw-rw---- 1 agreenla 665M Oct 26 18:44 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
-rw-rw---- 1 agreenla 375M Oct 26 18:45 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
-rw-rw---- 1 agreenla 394M Oct 26 18:47 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
-rw-rw---- 1 agreenla 696M Oct 26 18:46 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
-rw-rw---- 1 agreenla 726M Oct 26 18:46 /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz

❯ ., ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/*_R{1,3}_001.fastq.gz | wc -l
16

❯ ., ~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/*_R{1,3}_001.fastq.gz
-rw-r----- 1 agreenla 653M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
-rw-r----- 1 agreenla 659M Sep 29 18:50 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
-rw-r----- 1 agreenla 643M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
-rw-r----- 1 agreenla 650M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
-rw-r----- 1 agreenla 634M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
-rw-r----- 1 agreenla 639M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
-rw-r----- 1 agreenla 664M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
-rw-r----- 1 agreenla 666M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
-rw-r----- 1 agreenla 685M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
-rw-r----- 1 agreenla 688M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
-rw-r----- 1 agreenla 584M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
-rw-r----- 1 agreenla 587M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
-rw-r----- 1 agreenla 720M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
-rw-r----- 1 agreenla 720M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
-rw-r----- 1 agreenla 682M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
-rw-r----- 1 agreenla 685M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
-rw-r----- 1 agreenla 632M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
-rw-r----- 1 agreenla 636M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
-rw-r----- 1 agreenla 707M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
-rw-r----- 1 agreenla 711M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
-rw-r----- 1 agreenla 651M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
-rw-r----- 1 agreenla 656M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
-rw-r----- 1 agreenla 602M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
-rw-r----- 1 agreenla 609M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
-rw-r----- 1 agreenla 679M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
-rw-r----- 1 agreenla 688M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
-rw-r----- 1 agreenla 736M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
-rw-r----- 1 agreenla 745M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
-rw-r----- 1 agreenla 516M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
-rw-r----- 1 agreenla 519M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
-rw-r----- 1 agreenla 605M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
-rw-r----- 1 agreenla 609M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
-rw-r----- 1 agreenla 540M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
-rw-r----- 1 agreenla 543M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
-rw-r----- 1 agreenla 639M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
-rw-r----- 1 agreenla 642M Sep 29 18:47 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
-rw-r----- 1 agreenla 738M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
-rw-r----- 1 agreenla 741M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
-rw-r----- 1 agreenla 641M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
-rw-r----- 1 agreenla 647M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
-rw-r----- 1 agreenla 644M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
-rw-r----- 1 agreenla 651M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
-rw-r----- 1 agreenla 714M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
-rw-r----- 1 agreenla 719M Sep 29 18:49 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
-rw-r----- 1 agreenla 533M Sep 29 18:46 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
-rw-r----- 1 agreenla 538M Sep 29 18:48 /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz

❯ ., ~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/*_R{1,3}_001.fastq.gz | wc -l
46

❯ ., ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/*_R{1,3}_001.fastq.gz
-rw-rw---- 1 kalavatt 1.3G Oct 11 18:07 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1.3G Oct 11 18:05 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 740M Oct 11 18:02 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 744M Oct 11 18:07 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1.2G Oct 11 18:06 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1.2G Oct 11 18:07 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 830M Oct 11 18:04 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 828M Oct 11 18:05 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1.2G Oct 11 18:05 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1.2G Oct 11 18:05 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 891M Oct 11 18:02 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 892M Oct 11 18:03 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1.1G Oct 11 18:05 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1.1G Oct 11 18:06 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 804M Oct 11 18:06 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 803M Oct 11 18:03 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1.1G Oct 11 18:06 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1.1G Oct 11 18:04 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 816M Oct 11 18:01 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 811M Oct 11 18:02 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1.2G Oct 11 18:07 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1.2G Oct 11 18:03 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 866M Oct 11 18:05 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 868M Oct 11 18:04 /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz

❯ ., ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/*_R{1,3}_001.fastq.gz | wc -l
24

❯ ., ~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/{CW10_7747_8day_Q_IN,CW10_7747_8day_Q_PD,CW12_7748_8day_Q_IN,CW12_7748_8day_Q_PD,CW2_5781_8day_Q_IN,CW2_5781_8day_Q_PD,CW4_5782_8day_Q_IN,CW4_5782_8day_Q_PD,CW6_7078_8day_Q_IN,CW6_7078_8day_Q_PD,CW8_7079_8day_Q_IN,CW8_7079_8day_Q_PD}/*_R{1,3}_001.fastq.gz
-rw-rw---- 1 kalavatt  811M Dec 21 12:23 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  832M Dec 21 12:23 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  991M Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
-rw-rw---- 1 kalavatt 1003M Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  746M Dec 21 12:23 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  775M Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:23 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  779M Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  806M Dec 21 12:23 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1017M Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  758M Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  783M Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
-rw-rw---- 1 kalavatt 1018M Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:20 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  846M Dec 21 12:22 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  865M Dec 21 12:20 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:20 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
-rw-rw---- 1 kalavatt  1.1G Dec 21 12:21 /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz

❯ ., ~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/{CW10_7747_8day_Q_IN,CW10_7747_8day_Q_PD,CW12_7748_8day_Q_IN,CW12_7748_8day_Q_PD,CW2_5781_8day_Q_IN,CW2_5781_8day_Q_PD,CW4_5782_8day_Q_IN,CW4_5782_8day_Q_PD,CW6_7078_8day_Q_IN,CW6_7078_8day_Q_PD,CW8_7079_8day_Q_IN,CW8_7079_8day_Q_PD}/*_R{1,3}_001.fastq.gz | wc -l
24
```
</details>
</details>
<br />

<a id="get-situated-1"></a>
#### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
    {
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

#  Make a directory for storing the symlinked fastqs
if [[ ! -d "./fastqs_no-dedup" ]]; then
    mkdir -p "./fastqs_no-dedup/symlinks"
    mkdir -p "./fastqs_no-dedup/trim_galore"
fi

#  Make a directory for storing the FastQC results
if [[ ! -d "./FastQC_no-dedup" ]]; then
    mkdir -p "./FastQC_no-dedup/symlinks"
    mkdir -p "./FastQC_no-dedup/trim_galore"
fi
```
</details>
<br />

<a id="make-the-symbolic-links"></a>
#### Make the symbolic links
<details>
<summary><i>Code: Make the symbolic links</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE


#  Create an array of fastqs of interest --------------------------------------
unset dir_fqs
typeset -a dir_fqs
dir_fqs=(
    "${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
    "${HOME}/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla"
    "${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714"
    "${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718"
    "${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN"
    "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD"
)
echo_test "${dir_fqs[@]}"
echo "${#dir_fqs[@]}"  # 17

x="${#dir_fqs[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
unset full_fq
unset file_fq
typeset -a full_fq
typeset -a file_fq
while IFS=" " read -r -d $'\0'; do
    full_fq+=( "${REPLY}" )
    file_fq+=( "$(basename "${REPLY}")" )
done < <(\
    for i in $(seq 0 "${y}"); do
        find "${dir_fqs[${i}]}" \
            -type f \
            \( \
                -name "*_R1_001.fastq.gz" \
                -o -name "*_R3_001.fastq.gz" \
            \) \
            -print0 \
                | sort -z
    done
)
echo_test "${full_fq[@]}"
echo_test "${file_fq[@]}"
echo "${#full_fq[@]}"  # 110
echo "${#file_fq[@]}"  # 110


#  Iterate over the arrays to make the symlinks, then check on things ---------
x="${#full_fq[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "Iteration:  ${i}"
    echo "     Hard:  ${full_fq[${i}]}"
    echo "     Soft:  ./fastqs_no-dedup/symlinks/${file_fq[${i}]}"
    
    ln -s "${full_fq[${i}]}" "./fastqs_no-dedup/symlinks/${file_fq[${i}]}"
    echo ""
done

cd "./fastqs_no-dedup/symlinks" && .,
zcat "${file_fq[50]}" | head -8
zcat "${file_fq[50]}" | awk 'NR%4==2{print length($0)}' | head -1

tab="$(echo -e "\t")"
echo "file${tab}length"
for i in "${file_fq[@]}"; do
    length="$(zcat "${i}" | awk 'NR%4==2{print length($0)}' | head -1)"
    echo "${i}${tab}${length}"
done

cd -
```
</details>
<br />

<details>
<summary><i>Printed: Make the symbolic links: Iterate over the arrays to make the symlinks, then check on things</i></summary>

```txt
❯ for (( i=0; i<=y; i++ )); do
>     echo "Iteration:  ${i}"
>     echo "     Hard:  ${full_fq[${i}]}"
>     echo "     Soft:  ./fastqs_no-dedup/symlinks/${file_fq[${i}]}"
> 
>     ln -s "${full_fq[${i}]}" "./fastqs_no-dedup/symlinks/${file_fq[${i}]}"
>     echo ""
> done
Iteration:  0
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz

Iteration:  1
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R3_001.fastq.gz

Iteration:  2
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R1_001.fastq.gz

Iteration:  3
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R3_001.fastq.gz

Iteration:  4
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R1_001.fastq.gz

Iteration:  5
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R3_001.fastq.gz

Iteration:  6
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R1_001.fastq.gz

Iteration:  7
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R3_001.fastq.gz

Iteration:  8
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R1_001.fastq.gz

Iteration:  9
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R3_001.fastq.gz

Iteration:  10
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R1_001.fastq.gz

Iteration:  11
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R3_001.fastq.gz

Iteration:  12
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R1_001.fastq.gz

Iteration:  13
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R3_001.fastq.gz

Iteration:  14
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R1_001.fastq.gz

Iteration:  15
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R3_001.fastq.gz

Iteration:  16
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz

Iteration:  17
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz

Iteration:  18
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz

Iteration:  19
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz

Iteration:  20
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz

Iteration:  21
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz

Iteration:  22
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz

Iteration:  23
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz

Iteration:  24
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz

Iteration:  25
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz

Iteration:  26
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz

Iteration:  27
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz

Iteration:  28
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz

Iteration:  29
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz

Iteration:  30
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz

Iteration:  31
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz

Iteration:  32
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz

Iteration:  33
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz

Iteration:  34
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz

Iteration:  35
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz

Iteration:  36
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz

Iteration:  37
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz

Iteration:  38
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz

Iteration:  39
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz

Iteration:  40
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz

Iteration:  41
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz

Iteration:  42
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz

Iteration:  43
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz

Iteration:  44
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz

Iteration:  45
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz

Iteration:  46
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz

Iteration:  47
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz

Iteration:  48
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz

Iteration:  49
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz

Iteration:  50
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz

Iteration:  51
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz

Iteration:  52
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz

Iteration:  53
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz

Iteration:  54
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz

Iteration:  55
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz

Iteration:  56
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz

Iteration:  57
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz

Iteration:  58
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz

Iteration:  59
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz

Iteration:  60
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz

Iteration:  61
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz

Iteration:  62
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz

Iteration:  63
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz

Iteration:  64
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz

Iteration:  65
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz

Iteration:  66
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz

Iteration:  67
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz

Iteration:  68
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz

Iteration:  69
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz

Iteration:  70
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz

Iteration:  71
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz

Iteration:  72
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz

Iteration:  73
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz

Iteration:  74
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz

Iteration:  75
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz

Iteration:  76
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz

Iteration:  77
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz

Iteration:  78
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz

Iteration:  79
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz

Iteration:  80
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz

Iteration:  81
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz

Iteration:  82
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz

Iteration:  83
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz

Iteration:  84
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz

Iteration:  85
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz

Iteration:  86
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz

Iteration:  87
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz

Iteration:  88
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz

Iteration:  89
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz

Iteration:  90
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz

Iteration:  91
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz

Iteration:  92
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz

Iteration:  93
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz

Iteration:  94
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz

Iteration:  95
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz

Iteration:  96
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz

Iteration:  97
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz

Iteration:  98
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz

Iteration:  99
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz

Iteration:  100
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz

Iteration:  101
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz

Iteration:  102
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz

Iteration:  103
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz

Iteration:  104
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz

Iteration:  105
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz

Iteration:  106
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz

Iteration:  107
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz

Iteration:  108
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz

Iteration:  109
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
     Soft:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz

❯ cd "./fastqs_no-dedup/symlinks" && .,
total 3.3M
drwxrws--- 2 kalavatt 6.3K Jan 16 16:31 ./
drwxrws--- 4 kalavatt   55 Jan 16 15:30 ../
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5781_G1_IN_S5_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5781_G1_IN_S5_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5781_G1_IP_S1_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5781_G1_IP_S1_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5781_Q_IN_S6_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5781_Q_IN_S6_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5781_Q_IP_S2_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5781_Q_IP_S2_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5782_G1_IN_S7_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5782_G1_IN_S7_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5782_G1_IP_S3_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  104 Jan 16 16:31 5782_G1_IP_S3_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5782_Q_IN_S8_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5782_Q_IN_S8_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5782_Q_IP_S4_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  103 Jan 16 16:31 5782_Q_IP_S4_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  142 Jan 16 16:31 CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  142 Jan 16 16:31 CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  142 Jan 16 16:31 CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  142 Jan 16 16:31 CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  141 Jan 16 16:31 CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  141 Jan 16 16:31 CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  131 Jan 16 16:31 SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  131 Jan 16 16:31 SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  131 Jan 16 16:31 SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  131 Jan 16 16:31 SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  131 Jan 16 16:31 SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  131 Jan 16 16:31 SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  132 Jan 16 16:31 SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  129 Jan 16 16:31 SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  130 Jan 16 16:31 SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  144 Jan 16 16:31 Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  144 Jan 16 16:31 Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  149 Jan 16 16:31 Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  149 Jan 16 16:31 Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  143 Jan 16 16:31 Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  147 Jan 16 16:31 Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  140 Jan 16 16:31 Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
lrwxrwxrwx 1 kalavatt  144 Jan 16 16:31 Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
lrwxrwxrwx 1 kalavatt  144 Jan 16 16:31 Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz -> /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz

❯ zcat "${file_fq[50]}" | head -8
@VH00699:36:AAAWYTFM5:1:1101:58204:1360 1:N:0:AACTCGGA+GTCTTGCT
CTGGTCTAGTGCTATTGTNTATCAATGTCCTGATTGTTTAATCGGCAAAA
+
C;CCCCCCCCCCCCCCC;#CCCCCCCCCCCCCCCCCCCCCCCCCCCCC;C
@VH00699:36:AAAWYTFM5:1:1101:58886:1360 1:N:0:AACTCGGA+GTCTTGCT
GTTTATTTGATAGTTCCTNTAGTACATGGTATAACTGTGGTAATTCTAGA
+
CCCCCCCCCCCCCCCCCC#CCCCCCCCCCCCCCCCCC;CCCCCCCCCCCC

❯ zcat "${file_fq[50]}" | awk 'NR%4==2{print length($0)}' | head -1
50

❯ tab="   "
❯ echo "file${tab}length"
❯ for i in "${file_fq[@]}"; do
>     length="$(zcat "${i}" | awk 'NR%4==2{print length($0)}' | head -1)"
>     echo "${i}${tab}${length}"
> done
file   length
5781_G1_IN_S5_R1_001.fastq.gz   50
5781_G1_IN_S5_R3_001.fastq.gz   50
5781_G1_IP_S1_R1_001.fastq.gz   50
5781_G1_IP_S1_R3_001.fastq.gz   50
5781_Q_IN_S6_R1_001.fastq.gz   50
5781_Q_IN_S6_R3_001.fastq.gz   50
5781_Q_IP_S2_R1_001.fastq.gz   50
5781_Q_IP_S2_R3_001.fastq.gz   50
5782_G1_IN_S7_R1_001.fastq.gz   50
5782_G1_IN_S7_R3_001.fastq.gz   50
5782_G1_IP_S3_R1_001.fastq.gz   50
5782_G1_IP_S3_R3_001.fastq.gz   50
5782_Q_IN_S8_R1_001.fastq.gz   50
5782_Q_IN_S8_R3_001.fastq.gz   50
5782_Q_IP_S4_R1_001.fastq.gz   50
5782_Q_IP_S4_R3_001.fastq.gz   50
SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz   50
SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz   50
SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz   50
SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz   50
SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz   50
SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz   50
SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz   50
SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz   50
SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz   50
SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz   50
SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz   50
SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz   50
SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz   50
SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz   50
SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz   50
SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz   50
SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz   50
SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz   50
SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz   50
SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz   50
SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz   50
SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz   50
SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz   50
SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz   50
SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz   50
SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz   50
SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz   50
SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz   50
SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz   50
SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz   50
SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz   50
SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz   50
SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz   50
SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz   50
SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz   50
SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz   50
SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz   50
SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz   50
SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz   50
SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz   50
SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz   50
SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz   50
SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz   50
SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz   50
SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz   50
SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz   50
Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz   50
Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz   50
Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz   50
Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz   50
Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz   50
Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz   50
Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz   50
Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz   50
Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz   50
Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz   50
Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz   50
Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz   50
Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz   50
Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz   50
Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz   50
Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz   50
Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz   50
Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz   50
Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz   50
Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz   50
Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz   50
Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz   50
Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz   50
Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz   50
CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz   50
CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz   50
CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz   50
CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz   50
CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz   50
CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz   50
CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz   50
CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz   50
CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz   50
CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz   50
CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz   50
CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz   50
CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz   50
CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz   50
CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz   50
CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz   50
CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz   50
CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz   50
CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz   50
CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz   50
CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz   50
CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz   50
CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz   50
CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz   50
```
</details>
<br />
<br />
