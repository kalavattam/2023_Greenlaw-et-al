
`#troubleshoot_RTR1-RRP6-WT.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Notes, emails, etc.](#notes-emails-etc)
	1. [Email from Alison to me, 2023-0113, 17:51](#email-from-alison-to-me-2023-0113-1751)
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
1. [Perform adapter and quality trimming of the `fastq`s](#perform-adapter-and-quality-trimming-of-the-fastqs)
	1. [Install `atria` for looking into adapters](#install-atria-for-looking-into-adapters)
	1. [Get `fastq` file stems into an array](#get-fastq-file-stems-into-an-array)
	1. [Run `atria` to learn about adapter contamination](#run-atria-to-learn-about-adapter-contamination)
	1. [Run `FastQC` on `fastq` files](#run-fastqc-on-fastq-files)
		1. [Get situated](#get-situated-2)
		1. [Use a `HEREDOC` to write the script, `submit_run-fastqc.sh`](#use-a-heredoc-to-write-the-script-submit_run-fastqcsh)
		1. [Run `submit_run-fastqc.sh` on `fastq` files](#run-submit_run-fastqcsh-on-fastq-files)
	1. [Run `trim_galore` on `fastq` files](#run-trim_galore-on-fastq-files)
		1. [Get situated](#get-situated-3)
		1. [Use a `HEREDOC` to write the script, `submit_run-trim-galore.sh`](#use-a-heredoc-to-write-the-script-submit_run-trim-galoresh)
		1. [Run `submit_run-trim-galore.sh` on `fastq` files](#run-submit_run-trim-galoresh-on-fastq-files)
	1. [Run `FastQC` on `trim_galore`-processed `fastq` files](#run-fastqc-on-trim_galore-processed-fastq-files)
		1. [Get situated](#get-situated-4)
		1. [Run `submit_run-fastqc.sh` on `trim_galore`-processed `fastq` files](#run-submit_run-fastqcsh-on-trim_galore-processed-fastq-files)
1. [Align the trimmed, compressed `fastq` files to a combined reference](#align-the-trimmed-compressed-fastq-files-to-a-combined-reference)
	1. [Get situated](#get-situated-5)
	1. [Use a `HEREDOC` to write the script, `submit_STAR.sh`](#use-a-heredoc-to-write-the-script-submit_starsh)
	1. [Run `submit_STAR.sh` on `fq.gz` files](#run-submit_starsh-on-fqgz-files)
		1. [Clean up results from `STAR` alignment, then index `bam`s](#clean-up-results-from-star-alignment-then-index-bams)
			1. [Get situated](#get-situated-6)
			1. [Clean up/rename results of `STAR` alignment](#clean-uprename-results-of-star-alignment)
		1. [Index the `bam`s](#index-the-bams)
			1. [Get `bam`s of interest into an array](#get-bams-of-interest-into-an-array)
			1. [Run `samtools index` on each element of `bam` array](#run-samtools-index-on-each-element-of-bam-array)
	1. [Create `bam`s composed of alignments to specific species](#create-bams-composed-of-alignments-to-specific-species)
		1. [Create `bam`s w/o *20S* alignments: composed of *S. cerevisiae* and *K. lactis*](#create-bams-wo-20s-alignments-composed-of-s-cerevisiae-and-k-lactis)
		1. [Create `bam`s w/o *K.lactis* and *20S* alignments: composed of *S. cerevisiae*](#create-bams-wo-klactis-and-20s-alignments-composed-of-s-cerevisiae)
		1. [Create `bam`s w/o *S. cerevisiae* and *20S* alignments: composed of *K. lactis*](#create-bams-wo-s-cerevisiae-and-20s-alignments-composed-of-k-lactis)
		1. [Create `bam`s w/o *S. cerevisiae* and *K. lactis* alignments: composed of *20S*](#create-bams-wo-s-cerevisiae-and-k-lactis-alignments-composed-of-20s)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<details>
<summary><font size="+2"><i>Notes</i></font></summary>

<a id="notes-emails-etc"></a>
## Notes, emails, etc.
<a id="email-from-alison-to-me-2023-0113-1751"></a>
### Email from Alison to me, 2023-0113, 17:51
*Edited by me, 2023-0115, 11:55*

Hi Kris - 

The files can all be found at `~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq` (just in case you forgot). I ended up duplicating my analysis, so the essential identical things can be found in similar folders&mdash;I will upload old analysis to `AWS` drive and then delete, I just haven't yet. 

I first noticed there was a problem when looking at the spike-in values&mdash;the two replicates had very different spike in values&mdash;`7078` had less <u>steady state</u> than WT and more transcription. Meanwhile, its biological duplicate, `7079`, had more <u>steady state</u> and less transcription. In this case, `7079` is more what I would expect since I knocked out an RNA decay factor. Initially, I assumed these strains were simply not good replicates for one another&mdash;but when I did my rough replicate comparison (use `HTSeq count` on mRNA&mdash;and then using mRNA length and total mRNA counts to roughly obtain `TPM`), the replicates looked very similar. 

I then dug some more and found the reverse/forward `bam` issue. The weird file in question is the `7078_IN` sample. The reverse bam is `500 MB` while the forward is `150 MB`. Generally, the `IN` (<u>steady state</u>) files have a `2` (rev) to `1` (fwd) ratio and the `PD` (<u>nascent</u>) have a `1` to `1` ratio. Therefore, the `3` to `1` ratio seems odd to me. 

Some things I have checked so far:
- `R1` and `R3` files are the same size
- Matt from Bioinformatics looked at my splitting script, and he thought it was reasonable
- I opened up both split and unsplit bams&mdash;splitting script seems to be assigning strand correctly (this is `bam_split_paired_end.sh`) 
- Additionally, from looking at `bam`s in `IGV`, it doesn't seem like the `7078` `bam` is much bigger than the `7079` `bam`, even though file size indicates they should be different magnitudes 
- How `bigwig`s are made seems to matter substantially
	+ When `7078` reverse is made using `CPM` and no filter for read quality, it has very low levels everywhere
	+ However, when the same `bigwig` is made with `MAPQ` filter of `3` or greater, it has much higher `CPM` across the board 
- I have compared `FastQC` for `7078` `R1` and `7079` `R1`
	+ They look similar with the main issue being lots of 20S virus
	+ `7078` `R3` does have over representation of "Illumina Single End PCR Primer 1 (97% over 34 bp)", but so does `7079` `R3`&mdash;perhaps trimmomatic would help? I have not looked at `WT`
- <u>Steady state</u> RNA sequencing from `7078` done a year prior had a normal reverse to forward ratio of `1` to `2` (found in `TRF4_SSRNA_April2022`)

My current working hypothesis is that, somewhere in the genome, there are a bunch of low quality reads on the reverse strand, but I have yet to find the region. I am currently running scripts to count reads mapping to each chromosome, and perhaps that will tell me more about what is going on. 

Any ideas or help you could provide would be wonderful. 

A
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
		cd "results/2023-0115" || echo "cd'ing failed; check on this"
	}

if [[ ! -d "2023-0115" ]]; then
	mkdir -p 2023-0115/notebook
	# mkdir: created directory '2023-0115'
	# mkdir: created directory '2023-0115/notebook'

	mkdir -p 2023-0115/sh_err_out/err_out
	# mkdir: created directory '2023-0115/sh_err_out'
	# mkdir: created directory '2023-0115/sh_err_out/err_out'
fi

cd 2023-0115 || echo "cd'ing failed; check on this"

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
	|| echo "cd'ing failed; check on this"

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
	|| echo "cd'ing failed; check on this"

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
	|| echo "cd'ing failed; check on this"


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
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		rm {} \;
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
	|| echo "cd'ing failed; check on this"


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
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		rm {} \;
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
	|| echo "cd'ing failed; check on this"


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
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		rm {} \;
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
	|| echo "cd'ing failed; check on this"


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
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		rm {} \;
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
	|| echo "cd'ing failed; check on this"


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
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		rm {} \;
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
	|| echo "cd'ing failed; check on this"

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
	|| echo "cd'ing failed; check on this"
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
	|| echo "cd'ing failed; check on this"
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

Use the files in "`~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/*_R{1,3}_001.fastq.gz`" ~~`#TBD`~~ `#DEKHO`

<details>
<summary><i>Scratch work to determine the above</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla \
	|| echo "cd'ing failed; check on this"

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
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		ls -lhaFG {} \;
#
# find ${dir} \
# 	-type f \
# 	-name "*_merged_R?.fastq" \
# 	-exec \
# 		rm {} \;
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
Use the files in "`~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/{CW10_7747_8day_Q_IN,CW10_7747_8day_Q_PD,CW12_7748_8day_Q_IN,CW12_7748_8day_Q_PD,CW2_5781_8day_Q_IN,CW2_5781_8day_Q_PD,CW4_5782_8day_Q_IN,CW4_5782_8day_Q_PD,CW6_7078_8day_Q_IN,CW6_7078_8day_Q_PD,CW8_7079_8day_Q_IN,CW8_7079_8day_Q_PD}` `#DEKHO`

<details>
<summary><i>Scratch work to determine the above</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ~/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq \
	|| echo "cd'ing failed; check on this"

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
	|| echo "cd'ing failed; check on this"

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
        cd "results/2023-0115" || echo "cd'ing failed; check on this"
    }

#  Make a directory for storing the symlinked fastqs
if [[ ! -d "./fastqs" ]]; then
    mkdir -p "./fastqs/symlinks"
    mkdir -p "./fastqs/trim_galore"
fi

#  Make a directory for storing the FastQC results
if [[ ! -d "./FastQC" ]]; then
    mkdir -p "./FastQC/symlinks"
    mkdir -p "./FastQC/trim_galore"
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
	echo "     Soft:  ./fastqs/symlinks/${file_fq[${i}]}"
	
	ln -s "${full_fq[${i}]}" "./fastqs/symlinks/${file_fq[${i}]}"
	echo ""
done

cd "./fastqs/symlinks" && .,
zcat "${file_fq[50]}" | head -8
zcat "${file_fq[50]}" | awk 'NR%4==2{print length($0)}' | head -1

tab="	"
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
>     echo "     Soft:  ./fastqs/symlinks/${file_fq[${i}]}"
> 
>     ln -s "${full_fq[${i}]}" "./fastqs/symlinks/${file_fq[${i}]}"
>     echo ""
> done
Iteration:  0
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_G1_IN_S5_R1_001.fastq.gz

Iteration:  1
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_G1_IN_S5_R3_001.fastq.gz

Iteration:  2
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_G1_IP_S1_R1_001.fastq.gz

Iteration:  3
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_G1_IP_S1_R3_001.fastq.gz

Iteration:  4
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_Q_IN_S6_R1_001.fastq.gz

Iteration:  5
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_Q_IN_S6_R3_001.fastq.gz

Iteration:  6
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_Q_IP_S2_R1_001.fastq.gz

Iteration:  7
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5781_Q_IP_S2_R3_001.fastq.gz

Iteration:  8
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_G1_IN_S7_R1_001.fastq.gz

Iteration:  9
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_G1_IN_S7_R3_001.fastq.gz

Iteration:  10
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_G1_IP_S3_R1_001.fastq.gz

Iteration:  11
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_G1_IP_S3_R3_001.fastq.gz

Iteration:  12
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz

Iteration:  13
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz

Iteration:  14
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_Q_IP_S4_R1_001.fastq.gz

Iteration:  15
     Hard:  /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/5782_Q_IP_S4_R3_001.fastq.gz

Iteration:  16
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz

Iteration:  17
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz

Iteration:  18
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz

Iteration:  19
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz

Iteration:  20
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz

Iteration:  21
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz

Iteration:  22
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz

Iteration:  23
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz

Iteration:  24
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz

Iteration:  25
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz

Iteration:  26
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz

Iteration:  27
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz

Iteration:  28
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz

Iteration:  29
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz

Iteration:  30
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz

Iteration:  31
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz

Iteration:  32
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz

Iteration:  33
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz

Iteration:  34
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz

Iteration:  35
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz

Iteration:  36
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz

Iteration:  37
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz

Iteration:  38
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz

Iteration:  39
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz

Iteration:  40
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz

Iteration:  41
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz

Iteration:  42
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz

Iteration:  43
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz

Iteration:  44
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz

Iteration:  45
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz

Iteration:  46
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz

Iteration:  47
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz

Iteration:  48
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz

Iteration:  49
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz

Iteration:  50
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz

Iteration:  51
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz

Iteration:  52
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz

Iteration:  53
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz

Iteration:  54
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz

Iteration:  55
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz

Iteration:  56
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz

Iteration:  57
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz

Iteration:  58
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz

Iteration:  59
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz

Iteration:  60
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz

Iteration:  61
     Hard:  /home/kalavatt/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz

Iteration:  62
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz

Iteration:  63
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz

Iteration:  64
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz

Iteration:  65
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz

Iteration:  66
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz

Iteration:  67
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz

Iteration:  68
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz

Iteration:  69
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz

Iteration:  70
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz

Iteration:  71
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz

Iteration:  72
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz

Iteration:  73
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz

Iteration:  74
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz

Iteration:  75
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz

Iteration:  76
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz

Iteration:  77
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz

Iteration:  78
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz

Iteration:  79
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz

Iteration:  80
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz

Iteration:  81
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz

Iteration:  82
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz

Iteration:  83
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz

Iteration:  84
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz

Iteration:  85
     Hard:  /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz

Iteration:  86
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz

Iteration:  87
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_IN/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz

Iteration:  88
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz

Iteration:  89
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW10_7747_8day_Q_PD/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz

Iteration:  90
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz

Iteration:  91
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_IN/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz

Iteration:  92
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz

Iteration:  93
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW12_7748_8day_Q_PD/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz

Iteration:  94
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz

Iteration:  95
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_IN/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz

Iteration:  96
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz

Iteration:  97
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW2_5781_8day_Q_PD/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz

Iteration:  98
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz

Iteration:  99
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_IN/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz

Iteration:  100
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz

Iteration:  101
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW4_5782_8day_Q_PD/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz

Iteration:  102
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz

Iteration:  103
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_IN/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz

Iteration:  104
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz

Iteration:  105
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW6_7078_8day_Q_PD/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz

Iteration:  106
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz

Iteration:  107
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_IN/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz

Iteration:  108
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz

Iteration:  109
     Hard:  /home/kalavatt/tsukiyamalab/alisong/rtr1_rrp6_wt/Sequencinfg/Project_agreenla/Fastq/CW8_7079_8day_Q_PD/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
     Soft:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz

❯ cd "./fastqs/symlinks" && .,
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

<a id="perform-adapter-and-quality-trimming-of-the-fastqs"></a>
## Perform adapter and quality trimming of the `fastq`s
<a id="install-atria-for-looking-into-adapters"></a>
### Install `atria` for looking into adapters
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

<details>
<summary><i>Notes: Install atria for looking into adapters, 5/5: Create an alias for atria</i></summary>

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

<a id="get-fastq-file-stems-into-an-array"></a>
### Get `fastq` file stems into an array
<details>
<summary><i>Code: Get fastq file stems into an array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 32, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
	{
		cd "results/2023-0115" || echo "cd'ing failed; check on this"
	}

unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
done < <(\
    find "./fastqs/symlinks" \
        -type l \
        -name "*.fastq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"

IFS=" " read -r -a fq_bases \
	<<< "$(\
		tr ' ' '\n' \
			<<< "${fq_bases[@]}" \
				| sort -u \
				| tr '\n' ' '\
	)"
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"
```
</details>
<br />

<details>
<summary><i>Printed: Get fastq file stems into an array</i></summary>

```txt
❯ unset fq_bases
❯ typeset -a fq_bases
❯ while IFS=" " read -r -d $'\0'; do
>     fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
> done < <(\
>     find "./fastqs/symlinks" \
>         -type l \
>         -name "*.fastq.gz" \
>         -print0 \
>             | sort -z \
> )
❯ echo_test "${fq_bases[@]}"
./fastqs/symlinks/5781_G1_IN_S5
./fastqs/symlinks/5781_G1_IN_S5
./fastqs/symlinks/5781_G1_IP_S1
./fastqs/symlinks/5781_G1_IP_S1
./fastqs/symlinks/5781_Q_IN_S6
./fastqs/symlinks/5781_Q_IN_S6
./fastqs/symlinks/5781_Q_IP_S2
./fastqs/symlinks/5781_Q_IP_S2
./fastqs/symlinks/5782_G1_IN_S7
./fastqs/symlinks/5782_G1_IN_S7
./fastqs/symlinks/5782_G1_IP_S3
./fastqs/symlinks/5782_G1_IP_S3
./fastqs/symlinks/5782_Q_IN_S8
./fastqs/symlinks/5782_Q_IN_S8
./fastqs/symlinks/5782_Q_IP_S4
./fastqs/symlinks/5782_Q_IP_S4
./fastqs/symlinks/CW10_7747_8day_Q_IN_S5
./fastqs/symlinks/CW10_7747_8day_Q_IN_S5
./fastqs/symlinks/CW10_7747_8day_Q_PD_S11
./fastqs/symlinks/CW10_7747_8day_Q_PD_S11
./fastqs/symlinks/CW12_7748_8day_Q_IN_S6
./fastqs/symlinks/CW12_7748_8day_Q_IN_S6
./fastqs/symlinks/CW12_7748_8day_Q_PD_S12
./fastqs/symlinks/CW12_7748_8day_Q_PD_S12
./fastqs/symlinks/CW2_5781_8day_Q_IN_S1
./fastqs/symlinks/CW2_5781_8day_Q_IN_S1
./fastqs/symlinks/CW2_5781_8day_Q_PD_S7
./fastqs/symlinks/CW2_5781_8day_Q_PD_S7
./fastqs/symlinks/CW4_5782_8day_Q_IN_S2
./fastqs/symlinks/CW4_5782_8day_Q_IN_S2
./fastqs/symlinks/CW4_5782_8day_Q_PD_S8
./fastqs/symlinks/CW4_5782_8day_Q_PD_S8
./fastqs/symlinks/CW6_7078_8day_Q_IN_S3
./fastqs/symlinks/CW6_7078_8day_Q_IN_S3
./fastqs/symlinks/CW6_7078_8day_Q_PD_S9
./fastqs/symlinks/CW6_7078_8day_Q_PD_S9
./fastqs/symlinks/CW8_7079_8day_Q_IN_S4
./fastqs/symlinks/CW8_7079_8day_Q_IN_S4
./fastqs/symlinks/CW8_7079_8day_Q_PD_S10
./fastqs/symlinks/CW8_7079_8day_Q_PD_S10
./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22
./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22
./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23
./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23
./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13
./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13
./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14
./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14
./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15
./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15
./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16
./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16
./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17
./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17
./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18
./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18
./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19
./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19
./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20
./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20
./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21
./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21
./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10
./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10
./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11
./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11
./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12
./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12
./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1
./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1
./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2
./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2
./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3
./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3
./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4
./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4
./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5
./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5
./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6
./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6
./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7
./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7
./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8
./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8
./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9
./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9
./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11
./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11
./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12
./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12

❯ echo "${#fq_bases[@]}"
110

❯ IFS=" " read -r -a fq_bases \
> 	<<< "$(\
> 		tr ' ' '\n' \
> 			<<< "${fq_bases[@]}" \
> 				| sort -u \
> 				| tr '\n' ' '\
> 	)"
❯ echo_test "${fq_bases[@]}"
./fastqs/symlinks/5781_G1_IN_S5
./fastqs/symlinks/5781_G1_IP_S1
./fastqs/symlinks/5781_Q_IN_S6
./fastqs/symlinks/5781_Q_IP_S2
./fastqs/symlinks/5782_G1_IN_S7
./fastqs/symlinks/5782_G1_IP_S3
./fastqs/symlinks/5782_Q_IN_S8
./fastqs/symlinks/5782_Q_IP_S4
./fastqs/symlinks/CW10_7747_8day_Q_IN_S5
./fastqs/symlinks/CW10_7747_8day_Q_PD_S11
./fastqs/symlinks/CW12_7748_8day_Q_IN_S6
./fastqs/symlinks/CW12_7748_8day_Q_PD_S12
./fastqs/symlinks/CW2_5781_8day_Q_IN_S1
./fastqs/symlinks/CW2_5781_8day_Q_PD_S7
./fastqs/symlinks/CW4_5782_8day_Q_IN_S2
./fastqs/symlinks/CW4_5782_8day_Q_PD_S8
./fastqs/symlinks/CW6_7078_8day_Q_IN_S3
./fastqs/symlinks/CW6_7078_8day_Q_PD_S9
./fastqs/symlinks/CW8_7079_8day_Q_IN_S4
./fastqs/symlinks/CW8_7079_8day_Q_PD_S10
./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22
./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23
./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13
./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14
./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15
./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16
./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17
./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18
./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19
./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20
./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21
./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10
./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11
./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12
./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1
./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2
./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3
./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4
./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5
./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6
./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7
./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8
./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9
./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11
./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12

❯ echo "${#fq_bases[@]}"
55
```
</details>
<br />

<a id="run-atria-to-learn-about-adapter-contamination"></a>
### Run `atria` to learn about adapter contamination
`#DEKHO`
<details>
<summary><i>Code: Run atria to learn about adapter contamination</i></summary>

```bash
#!/bin/bash
#DONTRUN

#  Still on a compute node with 32 cores
alias atria="\${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/software/Atria/app-3.2.1/bin/atria"
# atria --help

# ., "${fq_bases[0]}_R1_001.fastq.gz"
# ., "${fq_bases[0]}_R3_001.fastq.gz"
#
# atria --detect-adapter \
# 	-r "${fq_bases[0]}_R1_001.fastq.gz" \
# 	-R "${fq_bases[0]}_R3_001.fastq.gz"

x="${#fq_bases[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
	echo "Iteration:  ${i}"
	echo "   Sample:  ${fq_bases[${i}]}"
	atria --detect-adapter \
		--threads 32 \
		-r "${fq_bases[${i}]}_R1_001.fastq.gz" \
		-R "${fq_bases[${i}]}_R3_001.fastq.gz"
	echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Run atria to learn about adapter contamination</i></summary>

```txt
Iteration:  0
   Sample:  ./fastqs/symlinks/5781_G1_IN_S5
pigz 2.6
┌ Info: ./fastqs/symlinks/5781_G1_IN_S5_R1_001.fastq.gz:
└  No adapter detected in the first 418224 reads.
┌ Info: ./fastqs/symlinks/5781_G1_IN_S5_R3_001.fastq.gz:
└  No adapter detected in the first 418224 reads.

Iteration:  1
   Sample:  ./fastqs/symlinks/5781_G1_IP_S1
pigz 2.6
┌ Info: ./fastqs/symlinks/5781_G1_IP_S1_R1_001.fastq.gz:
└  No adapter detected in the first 418204 reads.
┌ Info: ./fastqs/symlinks/5781_G1_IP_S1_R3_001.fastq.gz:
└  No adapter detected in the first 418204 reads.

Iteration:  2
   Sample:  ./fastqs/symlinks/5781_Q_IN_S6
pigz 2.6
┌ Info: ./fastqs/symlinks/5781_Q_IN_S6_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 418225 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       193 │  0.96956 │
│ │ GATCGGAAGAGCACAC │       170 │ 0.964706 │
│ │ AGATCGGAAGAGCTCG │       105 │    0.875 │
│ │ GACGCTGCCGACGAAG │        34 │ 0.895221 │
│ │ CTGTCTCTTATACACA │        20 │ 0.959375 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/5781_Q_IN_S6_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 418225 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ ACACTCTTTCCCTACA │       169 │ 0.980399 │
│ │ AGATCGGAAGAGCGTC │       167 │ 0.975299 │
│ │ TACACTCTTTCCCTAC │       165 │ 0.958333 │
│ │ GATCGGAAGAGCGTCG │       146 │  0.97774 │
│ │ AGATCGGAAGAGCGGT │       125 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  3
   Sample:  ./fastqs/symlinks/5781_Q_IP_S2
pigz 2.6
┌ Info: ./fastqs/symlinks/5781_Q_IP_S2_R1_001.fastq.gz:
└  No adapter detected in the first 418246 reads.
┌ Info: ./fastqs/symlinks/5781_Q_IP_S2_R3_001.fastq.gz:
└  No adapter detected in the first 418246 reads.

Iteration:  4
   Sample:  ./fastqs/symlinks/5782_G1_IN_S7
pigz 2.6
┌ Info: ./fastqs/symlinks/5782_G1_IN_S7_R1_001.fastq.gz:
└  No adapter detected in the first 418213 reads.
┌ Info: ./fastqs/symlinks/5782_G1_IN_S7_R3_001.fastq.gz:
└  No adapter detected in the first 418213 reads.

Iteration:  5
   Sample:  ./fastqs/symlinks/5782_G1_IP_S3
pigz 2.6
┌ Info: ./fastqs/symlinks/5782_G1_IP_S3_R1_001.fastq.gz:
└  No adapter detected in the first 418199 reads.
┌ Info: ./fastqs/symlinks/5782_G1_IP_S3_R3_001.fastq.gz:
└  No adapter detected in the first 418199 reads.

Iteration:  6
   Sample:  ./fastqs/symlinks/5782_Q_IN_S8
pigz 2.6
┌ Info: ./fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz:
└  No adapter detected in the first 418169 reads.
┌ Info: ./fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz:
└  No adapter detected in the first 418169 reads.

Iteration:  7
   Sample:  ./fastqs/symlinks/5782_Q_IP_S4
pigz 2.6
┌ Info: ./fastqs/symlinks/5782_Q_IP_S4_R1_001.fastq.gz:
└  No adapter detected in the first 418216 reads.
┌ Info: ./fastqs/symlinks/5782_Q_IP_S4_R3_001.fastq.gz:
└  No adapter detected in the first 418216 reads.

Iteration:  8
   Sample:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5
pigz 2.6
┌ Info: ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395354 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      3905 │ 0.995823 │
│ │ GATCGGAAGAGCACAC │      3879 │ 0.937146 │
│ │ AGATCGGAAGAGCTCG │      3680 │ 0.875187 │
│ │ AGATCGGAAGAGCGTC │        16 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        11 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395354 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      3814 │  0.99628 │
│ │ GATCGGAAGAGCGTCG │      3767 │ 0.936488 │
│ │ AGATCGGAAGAGCGGT │      3631 │ 0.875086 │
│ │ AGATCGGAAGAGCTCG │        17 │ 0.882353 │
│ │ AGATCGGAAGAGCACA │        15 │ 0.883333 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  9
   Sample:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11
pigz 2.6
┌ Info: ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395309 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      3145 │ 0.997277 │
│ │ GATCGGAAGAGCACAC │      3139 │ 0.937201 │
│ │ AGATCGGAAGAGCTCG │      3031 │ 0.875124 │
│ │ AGATCGGAAGAGCGTC │        10 │    0.875 │
│ │ CTGTCTCTTATACACA │         7 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395309 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      3091 │ 0.996684 │
│ │ GATCGGAAGAGCGTCG │      3065 │ 0.935685 │
│ │ AGATCGGAAGAGCGGT │      2951 │ 0.875021 │
│ │ TCGTCGGCAGCGTCAG │        11 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         8 │ 0.882812 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  10
   Sample:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6
pigz 2.6
┌ Info: ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395321 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      6597 │ 0.996779 │
│ │ GATCGGAAGAGCACAC │      6563 │ 0.937224 │
│ │ AGATCGGAAGAGCTCG │      6311 │ 0.875218 │
│ │ AGATCGGAAGAGCGTC │        33 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        11 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395321 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      6460 │ 0.996914 │
│ │ GATCGGAAGAGCGTCG │      6393 │ 0.936601 │
│ │ AGATCGGAAGAGCGGT │      6199 │  0.87502 │
│ │ AGATCGGAAGAGCTCG │        27 │ 0.888889 │
│ │ AGATCGGAAGAGCACA │        17 │ 0.878676 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  11
   Sample:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12
pigz 2.6
┌ Info: ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395340 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      4447 │  0.99643 │
│ │ GATCGGAAGAGCACAC │      4433 │ 0.936753 │
│ │ AGATCGGAAGAGCTCG │      4242 │ 0.875206 │
│ │ AGATCGGAAGAGCGTC │        26 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        13 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395340 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      4343 │ 0.996863 │
│ │ GATCGGAAGAGCGTCG │      4321 │  0.93588 │
│ │ AGATCGGAAGAGCGGT │      4164 │ 0.875075 │
│ │ AGATCGGAAGAGCTCG │        23 │ 0.891304 │
│ │ TCGTCGGCAGCGTCAG │        22 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  12
   Sample:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1
pigz 2.6
┌ Info: ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395330 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      9224 │  0.99651 │
│ │ GATCGGAAGAGCACAC │      9193 │ 0.937072 │
│ │ AGATCGGAAGAGCTCG │      8780 │ 0.875164 │
│ │ AGATCGGAAGAGCGTC │        38 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        22 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395330 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      9015 │ 0.996603 │
│ │ GATCGGAAGAGCGTCG │      8937 │ 0.935808 │
│ │ AGATCGGAAGAGCGGT │      8628 │ 0.875145 │
│ │ AGATCGGAAGAGCTCG │        29 │ 0.881466 │
│ │ AGATCGGAAGAGCACA │        25 │   0.8875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  13
   Sample:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7
pigz 2.6
┌ Info: ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395321 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      9293 │ 0.996953 │
│ │ GATCGGAAGAGCACAC │      9274 │ 0.936658 │
│ │ AGATCGGAAGAGCTCG │      8921 │ 0.875182 │
│ │ AGATCGGAAGAGCGTC │        37 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        23 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395321 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      9097 │ 0.997163 │
│ │ GATCGGAAGAGCGTCG │      9049 │ 0.935842 │
│ │ AGATCGGAAGAGCGGT │      8765 │ 0.875043 │
│ │ TCGTCGGCAGCGTCAG │        27 │    0.875 │
│ │ AGATCGGAAGAGCACA │        24 │ 0.890625 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  14
   Sample:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2
pigz 2.6
┌ Info: ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395321 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      6015 │ 0.996633 │
│ │ GATCGGAAGAGCACAC │      5964 │  0.93685 │
│ │ AGATCGGAAGAGCTCG │      5729 │ 0.875109 │
│ │ AGATCGGAAGAGCGTC │        27 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        11 │ 0.880682 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395321 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      5875 │ 0.996819 │
│ │ GATCGGAAGAGCGTCG │      5807 │ 0.936295 │
│ │ AGATCGGAAGAGCGGT │      5634 │ 0.875011 │
│ │ AGATCGGAAGAGCTCG │        20 │ 0.884375 │
│ │ AGATCGGAAGAGCACA │        18 │ 0.888889 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  15
   Sample:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8
pigz 2.6
┌ Info: ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395315 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      5200 │ 0.996935 │
│ │ GATCGGAAGAGCACAC │      5180 │ 0.936704 │
│ │ AGATCGGAAGAGCTCG │      4983 │ 0.875213 │
│ │ AGATCGGAAGAGCGTC │        40 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        13 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395315 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      5097 │ 0.996775 │
│ │ GATCGGAAGAGCGTCG │      5052 │ 0.936065 │
│ │ AGATCGGAAGAGCGGT │      4886 │ 0.875077 │
│ │ AGATCGGAAGAGCACA │        19 │ 0.898026 │
│ │ AGATCGGAAGAGCTCG │        15 │ 0.879167 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  16
   Sample:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3
pigz 2.6
┌ Info: ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395167 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      6259 │ 0.995746 │
│ │ GATCGGAAGAGCACAC │      6214 │ 0.937409 │
│ │ AGATCGGAAGAGCTCG │      5893 │  0.87518 │
│ │ AGATCGGAAGAGCGTC │        37 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        11 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395167 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      6066 │ 0.996765 │
│ │ GATCGGAAGAGCGTCG │      5992 │ 0.936373 │
│ │ AGATCGGAAGAGCGGT │      5814 │ 0.875086 │
│ │ AGATCGGAAGAGCTCG │        24 │ 0.885417 │
│ │ AGATCGGAAGAGCACA │        23 │  0.88587 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  17
   Sample:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9
pigz 2.6
┌ Info: ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395337 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      6708 │  0.99632 │
│ │ GATCGGAAGAGCACAC │      6693 │ 0.936762 │
│ │ AGATCGGAAGAGCTCG │      6384 │ 0.875215 │
│ │ AGATCGGAAGAGCGTC │        35 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        25 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395337 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      6540 │ 0.996837 │
│ │ GATCGGAAGAGCGTCG │      6492 │ 0.936066 │
│ │ AGATCGGAAGAGCGGT │      6269 │  0.87505 │
│ │ AGATCGGAAGAGCTCG │        17 │ 0.889706 │
│ │ AGATCGGAAGAGCACA │        13 │ 0.889423 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  18
   Sample:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4
pigz 2.6
┌ Info: ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395355 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      4900 │ 0.996467 │
│ │ GATCGGAAGAGCACAC │      4860 │ 0.936883 │
│ │ AGATCGGAAGAGCTCG │      4656 │ 0.875148 │
│ │ AGATCGGAAGAGCGTC │        22 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        10 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395355 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      4820 │ 0.997134 │
│ │ GATCGGAAGAGCGTCG │      4760 │ 0.936476 │
│ │ AGATCGGAAGAGCGGT │      4641 │  0.87504 │
│ │ TCGTCGGCAGCGTCAG │        31 │    0.875 │
│ │ AGATCGGAAGAGCTCG │        20 │  0.88125 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  19
   Sample:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10
pigz 2.6
┌ Info: ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 395330 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      7792 │ 0.996896 │
│ │ GATCGGAAGAGCACAC │      7787 │  0.93624 │
│ │ AGATCGGAAGAGCTCG │      7467 │ 0.875159 │
│ │ AGATCGGAAGAGCGTC │        55 │    0.875 │
│ │ GACGCTGCCGACGAAG │        27 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395330 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      7658 │ 0.997144 │
│ │ GATCGGAAGAGCGTCG │      7624 │ 0.935729 │
│ │ AGATCGGAAGAGCGGT │      7362 │ 0.875051 │
│ │ TCGTCGGCAGCGTCAG │        36 │    0.875 │
│ │ AGATCGGAAGAGCTCG │        19 │ 0.878289 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  20
   Sample:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397585 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       851 │ 0.994198 │
│ │ GATCGGAAGAGCACAC │       830 │ 0.939533 │
│ │ AGATCGGAAGAGCTCG │       777 │  0.87508 │
│ │ GACGCTGCCGACGAAG │         7 │    0.875 │
│ │ ACACTCTTTCCCTACA │         4 │ 0.921875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397585 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       819 │ 0.993666 │
│ │ GATCGGAAGAGCGTCG │       796 │ 0.937736 │
│ │ AGATCGGAAGAGCGGT │       749 │ 0.875083 │
│ │ AGATCGGAAGAGCACA │         4 │ 0.890625 │
│ │ TCGTCGGCAGCGTCAG │         4 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  21
   Sample:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397580 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       866 │  0.99069 │
│ │ GATCGGAAGAGCACAC │       838 │ 0.942273 │
│ │ AGATCGGAAGAGCTCG │       753 │    0.875 │
│ │ AGATCGGAAGAGCGTC │         6 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         5 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397580 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       797 │ 0.993413 │
│ │ GATCGGAAGAGCGTCG │       764 │ 0.939054 │
│ │ AGATCGGAAGAGCGGT │       718 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │         6 │    0.875 │
│ │ CAAGCAGAAGACGGCA │         4 │ 0.921875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  22
   Sample:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397569 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1396 │ 0.992523 │
│ │ GATCGGAAGAGCACAC │      1373 │  0.94055 │
│ │ AGATCGGAAGAGCTCG │      1245 │ 0.875201 │
│ │ GACGCTGCCGACGAAG │        26 │ 0.879808 │
│ │ CTGTCTCTTATACACA │         8 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397569 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1334 │ 0.993488 │
│ │ GATCGGAAGAGCGTCG │      1288 │ 0.938859 │
│ │ AGATCGGAAGAGCGGT │      1210 │ 0.875052 │
│ │ TCGTCGGCAGCGTCAG │        35 │    0.875 │
│ │ AGATCGGAAGAGCACA │         7 │ 0.892857 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  23
   Sample:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397584 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       860 │ 0.990916 │
│ │ GATCGGAAGAGCACAC │       840 │ 0.942411 │
│ │ AGATCGGAAGAGCTCG │       744 │    0.875 │
│ │ GACGCTGCCGACGAAG │        12 │ 0.885417 │
│ │ CTGTCTCTTATACACA │        10 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397584 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       824 │  0.99196 │
│ │ GATCGGAAGAGCGTCG │       798 │ 0.941416 │
│ │ AGATCGGAAGAGCGGT │       722 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │        35 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         7 │ 0.883929 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  24
   Sample:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397595 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1013 │ 0.991115 │
│ │ GATCGGAAGAGCACAC │       995 │ 0.941771 │
│ │ AGATCGGAAGAGCTCG │       884 │    0.875 │
│ │ GACGCTGCCGACGAAG │        21 │ 0.877976 │
│ │ AGATCGGAAGAGCGTC │         8 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397595 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       966 │ 0.993271 │
│ │ GATCGGAAGAGCGTCG │       942 │ 0.939756 │
│ │ AGATCGGAAGAGCGGT │       868 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │        48 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         4 │ 0.890625 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  25
   Sample:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397538 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1021 │ 0.992593 │
│ │ GATCGGAAGAGCACAC │       990 │  0.94053 │
│ │ AGATCGGAAGAGCTCG │       914 │ 0.875137 │
│ │ GACGCTGCCGACGAAG │        10 │   0.8875 │
│ │ GACGCTGCCGACGACG │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397538 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       971 │ 0.994078 │
│ │ GATCGGAAGAGCGTCG │       932 │ 0.939109 │
│ │ AGATCGGAAGAGCGGT │       882 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │        11 │    0.875 │
│ │ CAAGCAGAAGACGGCA │         4 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  26
   Sample:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397545 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       605 │ 0.990289 │
│ │ GATCGGAAGAGCACAC │       587 │ 0.940481 │
│ │ AGATCGGAAGAGCTCG │       525 │ 0.875238 │
│ │ GACGCTGCCGACGAAG │        11 │ 0.892045 │
│ │ CTAATACGACTCACTA │         7 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397545 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       577 │ 0.990901 │
│ │ GATCGGAAGAGCGTCG │       549 │ 0.941712 │
│ │ AGATCGGAAGAGCGGT │       499 │ 0.875251 │
│ │ TCGTCGGCAGCGTCAG │        21 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         4 │ 0.890625 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  27
   Sample:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397594 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1144 │ 0.992297 │
│ │ GATCGGAAGAGCACAC │      1106 │ 0.940156 │
│ │ AGATCGGAAGAGCTCG │      1017 │ 0.875061 │
│ │ GACGCTGCCGACGAAG │        19 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         7 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397594 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1075 │ 0.993488 │
│ │ GATCGGAAGAGCGTCG │      1029 │ 0.938229 │
│ │ AGATCGGAAGAGCGGT │       975 │ 0.875128 │
│ │ TCGTCGGCAGCGTCAG │        31 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         7 │ 0.892857 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  28
   Sample:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397568 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       927 │ 0.991775 │
│ │ GATCGGAAGAGCACAC │       895 │ 0.942388 │
│ │ AGATCGGAAGAGCTCG │       815 │ 0.875077 │
│ │ CTAATACGACTCACTA │         7 │   0.9375 │
│ │ TCGTCGGCAGCGTCAG │         4 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397568 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       891 │ 0.992424 │
│ │ GATCGGAAGAGCGTCG │       858 │ 0.940705 │
│ │ AGATCGGAAGAGCGGT │       788 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │         9 │    0.875 │
│ │ CAAGCAGAAGACGGCA │         2 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  29
   Sample:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397566 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       793 │ 0.989912 │
│ │ GATCGGAAGAGCACAC │       768 │ 0.941895 │
│ │ AGATCGGAAGAGCTCG │       679 │ 0.875276 │
│ │ GACGCTGCCGACGAAG │         9 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397566 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       751 │ 0.992011 │
│ │ GATCGGAAGAGCGTCG │       718 │ 0.940634 │
│ │ AGATCGGAAGAGCGGT │       666 │ 0.875188 │
│ │ TCGTCGGCAGCGTCAG │        14 │ 0.879464 │
│ │ AGATCGGAAGAGCTCG │         4 │  0.90625 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  30
   Sample:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397581 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1158 │ 0.993955 │
│ │ GATCGGAAGAGCACAC │      1157 │ 0.939985 │
│ │ AGATCGGAAGAGCTCG │      1054 │ 0.875059 │
│ │ GACGCTGCCGACGAAG │        17 │ 0.878676 │
│ │ AGATCGGAAGAGCGTC │         9 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397581 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1121 │ 0.993867 │
│ │ GATCGGAAGAGCGTCG │      1109 │ 0.938289 │
│ │ AGATCGGAAGAGCGGT │      1016 │ 0.875062 │
│ │ TCGTCGGCAGCGTCAG │        27 │    0.875 │
│ │ CAAGCAGAAGACGGCA │        15 │    0.975 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  31
   Sample:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397559 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1673 │  0.99477 │
│ │ GATCGGAAGAGCACAC │      1645 │ 0.939856 │
│ │ AGATCGGAAGAGCTCG │      1542 │ 0.875162 │
│ │ AGATCGGAAGAGCGTC │         7 │    0.875 │
│ │ GACGCTGCCGACGAAT │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397559 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1624 │ 0.993342 │
│ │ GATCGGAAGAGCGTCG │      1587 │ 0.937224 │
│ │ AGATCGGAAGAGCGGT │      1469 │    0.875 │
│ │ AGATCGGAAGAGCTCG │        11 │ 0.880682 │
│ │ AGATCGGAAGAGCACA │         7 │ 0.883929 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  32
   Sample:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397589 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       793 │ 0.992434 │
│ │ GATCGGAAGAGCACAC │       762 │ 0.940863 │
│ │ AGATCGGAAGAGCTCG │       705 │ 0.875266 │
│ │ AGATCGGAAGAGCGTC │         7 │    0.875 │
│ │ CAAGCAGAAGACGGCA │         4 │  0.90625 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397589 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       754 │ 0.993203 │
│ │ GATCGGAAGAGCGTCG │       722 │ 0.938019 │
│ │ AGATCGGAAGAGCGGT │       681 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         5 │   0.9125 │
│ │ AGATCGGAAGAGCACA │         3 │ 0.895833 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  33
   Sample:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397488 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1090 │  0.99289 │
│ │ GATCGGAAGAGCACAC │      1070 │ 0.940421 │
│ │ AGATCGGAAGAGCTCG │       972 │ 0.875129 │
│ │ CTGAGCGGGCTGGCAA │         6 │    0.875 │
│ │ CTAATACGACTCACTA │         3 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397488 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1047 │ 0.993732 │
│ │ GATCGGAAGAGCGTCG │      1022 │  0.93909 │
│ │ AGATCGGAAGAGCGGT │       954 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         6 │ 0.895833 │
│ │ AGATCGGAAGAGCACA │         5 │      0.9 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  34
   Sample:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397495 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      2058 │ 0.993106 │
│ │ GATCGGAAGAGCACAC │      2020 │ 0.941089 │
│ │ AGATCGGAAGAGCTCG │      1850 │ 0.875034 │
│ │ GACGCTGCCGACGAAG │        17 │ 0.882353 │
│ │ CTGTCTCTTATACACA │        14 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397495 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1942 │ 0.994883 │
│ │ GATCGGAAGAGCGTCG │      1888 │ 0.938559 │
│ │ AGATCGGAAGAGCGGT │      1803 │ 0.875069 │
│ │ TCGTCGGCAGCGTCAG │         9 │    0.875 │
│ │ AGATCGGAAGAGCACA │         7 │ 0.883929 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  35
   Sample:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397549 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1059 │ 0.992741 │
│ │ GATCGGAAGAGCACAC │      1016 │ 0.940699 │
│ │ AGATCGGAAGAGCTCG │       953 │ 0.875131 │
│ │ CTGTCTCTTATACACA │        16 │    0.875 │
│ │ GACGCTGCCGACGAAG │         8 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397549 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1015 │ 0.993165 │
│ │ GATCGGAAGAGCGTCG │       968 │ 0.938404 │
│ │ AGATCGGAAGAGCGGT │       915 │ 0.875137 │
│ │ TCGTCGGCAGCGTCAG │        18 │    0.875 │
│ │ AAGTCGGAGGCCAAGC │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  36
   Sample:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397510 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       791 │ 0.990755 │
│ │ GATCGGAAGAGCACAC │       775 │ 0.942177 │
│ │ AGATCGGAAGAGCTCG │       684 │ 0.875091 │
│ │ GACGCTGCCGACGAAG │        16 │ 0.890625 │
│ │ CCACTACGCCTCCGCT │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397510 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       738 │ 0.993987 │
│ │ GATCGGAAGAGCGTCG │       707 │ 0.939003 │
│ │ AGATCGGAAGAGCGGT │       675 │ 0.875093 │
│ │ TCGTCGGCAGCGTCAG │        11 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  37
   Sample:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397566 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1470 │ 0.992092 │
│ │ GATCGGAAGAGCACAC │      1434 │  0.94042 │
│ │ AGATCGGAAGAGCTCG │      1301 │  0.87524 │
│ │ AGATCGGAAGAGCGTC │        12 │    0.875 │
│ │ CTAATACGACTCACTA │         7 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397566 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1386 │ 0.994408 │
│ │ GATCGGAAGAGCGTCG │      1335 │ 0.938624 │
│ │ AGATCGGAAGAGCGGT │      1274 │ 0.875147 │
│ │ AGATCGGAAGAGCTCG │         6 │  0.90625 │
│ │ TCGTCGGCAGCGTCAG │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  38
   Sample:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397493 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1013 │ 0.990375 │
│ │ GATCGGAAGAGCACAC │       996 │ 0.941893 │
│ │ AGATCGGAAGAGCTCG │       868 │ 0.875288 │
│ │ GACGCTGCCGACGAAG │         9 │    0.875 │
│ │ CTGTCTCTTATACACA │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397493 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       982 │  0.99058 │
│ │ GATCGGAAGAGCGTCG │       946 │ 0.940803 │
│ │ AGATCGGAAGAGCGGT │       847 │ 0.875074 │
│ │ TCGTCGGCAGCGTCAG │         7 │    0.875 │
│ │ AGATCGGAAGAGCACA │         3 │ 0.895833 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  39
   Sample:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397567 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1129 │ 0.992471 │
│ │ GATCGGAAGAGCACAC │      1104 │  0.94135 │
│ │ AGATCGGAAGAGCTCG │       998 │    0.875 │
│ │ GACGCTGCCGACGACG │         8 │    0.875 │
│ │ AGATCGGAAGAGCGTC │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397567 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1069 │ 0.993335 │
│ │ GATCGGAAGAGCGTCG │      1035 │ 0.938829 │
│ │ AGATCGGAAGAGCGGT │       965 │    0.875 │
│ │ CAAGCAGAAGACGGCA │         5 │     0.95 │
│ │ AGATCGGAAGAGCACA │         4 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  40
   Sample:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397577 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1885 │ 0.992672 │
│ │ GATCGGAAGAGCACAC │      1845 │  0.93977 │
│ │ AGATCGGAAGAGCTCG │      1687 │ 0.875296 │
│ │ AGATCGGAAGAGCGTC │        11 │    0.875 │
│ │ TCGTCGGCAGCGTCAG │         9 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397577 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1799 │ 0.993851 │
│ │ GATCGGAAGAGCGTCG │      1735 │  0.93804 │
│ │ AGATCGGAAGAGCGGT │      1647 │    0.875 │
│ │ AGATCGGAAGAGCTCG │        22 │ 0.883523 │
│ │ AGATCGGAAGAGCACA │        17 │ 0.882353 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  41
   Sample:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397531 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       753 │ 0.992447 │
│ │ GATCGGAAGAGCACAC │       740 │ 0.942061 │
│ │ AGATCGGAAGAGCTCG │       669 │    0.875 │
│ │ GACGCTGCCGACGAAG │         7 │    0.875 │
│ │ CTAATACGACTCACTA │         4 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397531 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       713 │ 0.992812 │
│ │ GATCGGAAGAGCGTCG │       694 │  0.93804 │
│ │ AGATCGGAAGAGCGGT │       637 │ 0.875098 │
│ │ CAAGCAGAAGACGGCA │         3 │      1.0 │
│ │ GACGCTGCCGACGATA │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  42
   Sample:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9
pigz 2.6
┌ Info: ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 397510 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1109 │ 0.990983 │
│ │ GATCGGAAGAGCACAC │      1075 │ 0.942035 │
│ │ AGATCGGAAGAGCTCG │       961 │ 0.875195 │
│ │ AGATCGGAAGAGCGTC │         9 │    0.875 │
│ │ CTAATACGACTCACTA │         7 │ 0.919643 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 397510 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1053 │ 0.993056 │
│ │ GATCGGAAGAGCGTCG │      1008 │  0.93998 │
│ │ AGATCGGAAGAGCGGT │       947 │ 0.875066 │
│ │ CAAGCAGAAGACGGCA │         8 │    0.875 │
│ │ AGATCGGAAGAGCACA │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  43
   Sample:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400087 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1842 │ 0.994401 │
│ │ GATCGGAAGAGCACAC │      1826 │ 0.938766 │
│ │ AGATCGGAAGAGCTCG │      1700 │ 0.875184 │
│ │ GACGCTGCCGACGAAG │        11 │    0.875 │
│ │ CAAGCAGAAGACGGCA │         8 │ 0.890625 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400087 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1750 │ 0.995643 │
│ │ GATCGGAAGAGCGTCG │      1721 │ 0.936628 │
│ │ AGATCGGAAGAGCGGT │      1640 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         5 │   0.8875 │
│ │ CTGTCTCTTATACACA │         5 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  44
   Sample:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 399987 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1442 │ 0.992805 │
│ │ GATCGGAAGAGCACAC │      1419 │ 0.940099 │
│ │ AGATCGGAAGAGCTCG │      1292 │ 0.875193 │
│ │ AGATCGGAAGAGCGTC │         9 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 399987 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1378 │ 0.994966 │
│ │ GATCGGAAGAGCGTCG │      1346 │ 0.939125 │
│ │ AGATCGGAAGAGCGGT │      1270 │    0.875 │
│ │ CGACAGGTTCAGAGTT │         2 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         1 │   0.9375 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  45
   Sample:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400084 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1617 │ 0.993429 │
│ │ GATCGGAAGAGCACAC │      1617 │ 0.941404 │
│ │ AGATCGGAAGAGCTCG │      1462 │ 0.875128 │
│ │ GACGCTGCCGACGACG │         8 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         7 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400084 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1481 │ 0.997215 │
│ │ GATCGGAAGAGCGTCG │      1466 │ 0.936178 │
│ │ AGATCGGAAGAGCGGT │      1423 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         3 │    0.875 │
│ │ AGATCGGAAGAGCACA │         2 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  46
   Sample:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400040 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      4873 │ 0.992843 │
│ │ GATCGGAAGAGCACAC │      4760 │ 0.940625 │
│ │ AGATCGGAAGAGCTCG │      4380 │ 0.875214 │
│ │ AGATCGGAAGAGCGTC │        24 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        12 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400040 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      4643 │ 0.994171 │
│ │ GATCGGAAGAGCGTCG │      4497 │ 0.938473 │
│ │ AGATCGGAAGAGCGGT │      4259 │ 0.875059 │
│ │ AGATCGGAAGAGCACA │        14 │ 0.883929 │
│ │ AGATCGGAAGAGCTCG │        14 │ 0.892857 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  47
   Sample:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400056 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1420 │ 0.994586 │
│ │ GATCGGAAGAGCACAC │      1408 │ 0.938077 │
│ │ AGATCGGAAGAGCTCG │      1315 │ 0.875238 │
│ │ GACGCTGCCGACGAAT │         7 │    0.875 │
│ │ GACGCTGCCGACGAAG │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400056 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1351 │   0.9969 │
│ │ GATCGGAAGAGCGTCG │      1337 │ 0.936799 │
│ │ AGATCGGAAGAGCGGT │      1296 │ 0.875048 │
│ │ AAGTCGGATCGTAGCC │         4 │    0.875 │
│ │ AGATCGGAAGAGCACA │         4 │ 0.890625 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  48
   Sample:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400054 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1764 │ 0.991886 │
│ │ GATCGGAAGAGCACAC │      1687 │ 0.940612 │
│ │ AGATCGGAAGAGCTCG │      1558 │  0.87516 │
│ │ AGATCGGAAGAGCGTC │        13 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         6 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400054 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1704 │ 0.993214 │
│ │ GATCGGAAGAGCGTCG │      1618 │ 0.939316 │
│ │ AGATCGGAAGAGCGGT │      1532 │ 0.875041 │
│ │ AGATCGGAAGAGCTCG │         5 │    0.925 │
│ │ GATCGGAAGAGCTCGT │         4 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  49
   Sample:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 399886 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      2410 │ 0.995202 │
│ │ GATCGGAAGAGCACAC │      2400 │ 0.937943 │
│ │ AGATCGGAAGAGCTCG │      2247 │ 0.875195 │
│ │ CAAGCAGAAGACGGCA │        14 │ 0.915179 │
│ │ AGATCGGAAGAGCGTC │        12 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 399886 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      2304 │ 0.994575 │
│ │ GATCGGAAGAGCGTCG │      2276 │ 0.935468 │
│ │ AGATCGGAAGAGCGGT │      2132 │ 0.875088 │
│ │ CAAGCAGAAGACGGCA │       107 │ 0.997079 │
│ │ AGATCGGAAGAGCTCG │        14 │ 0.883929 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  50
   Sample:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400007 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      2171 │ 0.993695 │
│ │ GATCGGAAGAGCACAC │      2148 │ 0.939508 │
│ │ AGATCGGAAGAGCTCG │      1983 │ 0.875221 │
│ │ AGATCGGAAGAGCGTC │        14 │    0.875 │
│ │ AGATCGGAAGAGCGGT │        12 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400007 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      2070 │  0.99532 │
│ │ GATCGGAAGAGCGTCG │      2025 │ 0.937994 │
│ │ AGATCGGAAGAGCGGT │      1930 │ 0.875097 │
│ │ AGATCGGAAGAGCTCG │        10 │   0.8875 │
│ │ AGATCGGAAGAGCACA │         5 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  51
   Sample:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400079 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │       873 │ 0.993414 │
│ │ GATCGGAAGAGCACAC │       866 │  0.94082 │
│ │ AGATCGGAAGAGCTCG │       790 │ 0.875079 │
│ │ CAAGCAGAAGACGGCA │         7 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         4 │ 0.890625 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400079 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │       817 │ 0.995869 │
│ │ GATCGGAAGAGCGTCG │       804 │ 0.937345 │
│ │ AGATCGGAAGAGCGGT │       770 │    0.875 │
│ │ CAAGCAGAAGACGGCA │        10 │     0.95 │
│ │ AGATCGGAAGAGCACA │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  52
   Sample:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400094 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1651 │ 0.994511 │
│ │ GATCGGAAGAGCACAC │      1632 │ 0.939262 │
│ │ AGATCGGAAGAGCTCG │      1526 │ 0.875123 │
│ │ AGATCGGAAGAGCGTC │        10 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         9 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400094 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1586 │ 0.996296 │
│ │ GATCGGAAGAGCGTCG │      1560 │  0.93762 │
│ │ AGATCGGAAGAGCGGT │      1501 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         5 │    0.875 │
│ │ AGATCGGAAGAGCACA │         4 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  53
   Sample:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400052 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      1687 │ 0.993813 │
│ │ GATCGGAAGAGCACAC │      1681 │ 0.938838 │
│ │ AGATCGGAAGAGCTCG │      1543 │ 0.875122 │
│ │ GACGCTGCCGACGAAG │        10 │    0.875 │
│ │ AGATCGGAAGAGCGTC │         8 │ 0.882812 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400052 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      1591 │ 0.996661 │
│ │ GATCGGAAGAGCGTCG │      1582 │ 0.936591 │
│ │ AGATCGGAAGAGCGGT │      1517 │ 0.875082 │
│ │ TCGTCGGCAGCGTCAG │         5 │    0.875 │
│ │ AGATCGGAAGAGCACA │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  54
   Sample:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12
pigz 2.6
┌ Info: ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz:
│  Top 5 adapters detected in the first 400083 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCACA │      2577 │ 0.994325 │
│ │ GATCGGAAGAGCACAC │      2556 │ 0.938576 │
│ │ AGATCGGAAGAGCTCG │      2369 │ 0.875211 │
│ │ AGATCGGAAGAGCGTC │        17 │    0.875 │
│ │ AGATCGGAAGAGCGGT │         7 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
┌ Info: ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 400083 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      2494 │ 0.996341 │
│ │ GATCGGAAGAGCGTCG │      2466 │ 0.937297 │
│ │ AGATCGGAAGAGCGGT │      2358 │ 0.875053 │
│ │ CAAGCAGAAGACGGCA │         5 │     0.95 │
│ │ CTGTCTCTTATACACA │         3 │    0.875 │
└ └──────────────────┴───────────┴──────────┘
```
</details>
<br />

<a id="run-fastqc-on-fastq-files"></a>
### Run `FastQC` on `fastq` files
<a id="get-situated-2"></a>
#### Get situated
`#DEKHO`
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Exit the compute node that has 32 cores (no need for so much power)
exit

grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
	{
		cd "results/2023-0115" || echo "cd'ing failed; check on this"
	}

#  Make a directory for storing the FastQC results
if [[ ! -d "./FastQC" ]]; then
    mkdir -p "./FastQC/symlinks"
    mkdir -p "./FastQC/trim_galore"
fi

#  Variables
script_name="submit_run-fastqc.sh"  # echo "${script_name}"
threads=4  # echo "${threads}"

#  Arrays
unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
done < <(\
    find "./fastqs/symlinks" \
        -type l \
        -name "*.fastq.gz" \
        -print0 \
            | sort -z \
)
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"

IFS=" " read -r -a fq_bases \
	<<< "$(\
		tr ' ' '\n' \
			<<< "${fq_bases[@]}" \
				| sort -u \
				| tr '\n' ' '\
	)"
echo_test "${fq_bases[@]}"
echo "${#fq_bases[@]}"

unset fq_r1
unset fq_r2
typeset -a fq_r1
typeset -a fq_r2
for i in "${fq_bases[@]}"; do
	fq_r1+=("${i}_R1_001.fastq.gz")
	fq_r2+=("${i}_R3_001.fastq.gz")
done
# echo_test "${fq_r1[@]}"
# echo_test "${fq_r2[@]}"
# echo "${#fq_r1[@]}"  # 55
# echo "${#fq_r2[@]}"  # 55
# ., "${fq_r1[40]}"
# ., "${fq_r2[40]}"
```
</details>
<br />

<a id="use-a-heredoc-to-write-the-script-submit_run-fastqcsh"></a>
#### Use a `HEREDOC` to write the script, `submit_run-fastqc.sh`
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_run-fastqc.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./sh_err_out/${script_name}" ]]; then
        rm "./sh_err_out/${script_name}"
fi
cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

infile="\${1}"
outdir="\${2}"

fastqc \\
    --threads "\${SLURM_CPUS_ON_NODE}" \\
    --outdir "\${outdir}" \\
    "\${infile}"
script
# vi "./sh_err_out/${script_name}"
```
</details>
<br />

<a id="run-submit_run-fastqcsh-on-fastq-files"></a>
#### Run `submit_run-fastqc.sh` on `fastq` files
<details>
<summary><i>Code: Run submit_run-fastqc.sh on fastq files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#fq_bases[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
	echo "# --------------------------------------"
	echo "Iteration:  ${i}"
	echo "File base:  ${fq_bases[${i}]}"
	echo "       r1:  ${fq_r1[${i}]}"
	echo "       r2:  ${fq_r2[${i}]}"
	echo "   outdir:  ./FastQC/symlinks"
	echo ""
	
	#  For r1
	sbatch "./sh_err_out/${script_name}" \
		"${fq_r1[${i}]}" \
		"./FastQC/symlinks"
	echo "FastQC job submitted for ${fq_r1[${i}]}"
	echo ""

	#  For r2
	sbatch "./sh_err_out/${script_name}" \
		"${fq_r2[${i}]}" \
		"./FastQC/symlinks"
	echo "FastQC job submitted for ${fq_r2[${i}]}"
	
	echo ""
	echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Run submit_run-fastqc.sh on fastq files</i></summary>

```txt
# --------------------------------------
Iteration:  0
File base:  ./fastqs/symlinks/5781_G1_IN_S5
       r1:  ./fastqs/symlinks/5781_G1_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_G1_IN_S5_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993199
FastQC job submitted for ./fastqs/symlinks/5781_G1_IN_S5_R1_001.fastq.gz

Submitted batch job 7993200
FastQC job submitted for ./fastqs/symlinks/5781_G1_IN_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  1
File base:  ./fastqs/symlinks/5781_G1_IP_S1
       r1:  ./fastqs/symlinks/5781_G1_IP_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_G1_IP_S1_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993201
FastQC job submitted for ./fastqs/symlinks/5781_G1_IP_S1_R1_001.fastq.gz

Submitted batch job 7993202
FastQC job submitted for ./fastqs/symlinks/5781_G1_IP_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  2
File base:  ./fastqs/symlinks/5781_Q_IN_S6
       r1:  ./fastqs/symlinks/5781_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993203
FastQC job submitted for ./fastqs/symlinks/5781_Q_IN_S6_R1_001.fastq.gz

Submitted batch job 7993204
FastQC job submitted for ./fastqs/symlinks/5781_Q_IN_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  3
File base:  ./fastqs/symlinks/5781_Q_IP_S2
       r1:  ./fastqs/symlinks/5781_Q_IP_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_Q_IP_S2_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993205
FastQC job submitted for ./fastqs/symlinks/5781_Q_IP_S2_R1_001.fastq.gz

Submitted batch job 7993206
FastQC job submitted for ./fastqs/symlinks/5781_Q_IP_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  4
File base:  ./fastqs/symlinks/5782_G1_IN_S7
       r1:  ./fastqs/symlinks/5782_G1_IN_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_G1_IN_S7_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993207
FastQC job submitted for ./fastqs/symlinks/5782_G1_IN_S7_R1_001.fastq.gz

Submitted batch job 7993208
FastQC job submitted for ./fastqs/symlinks/5782_G1_IN_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  5
File base:  ./fastqs/symlinks/5782_G1_IP_S3
       r1:  ./fastqs/symlinks/5782_G1_IP_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_G1_IP_S3_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993209
FastQC job submitted for ./fastqs/symlinks/5782_G1_IP_S3_R1_001.fastq.gz

Submitted batch job 7993210
FastQC job submitted for ./fastqs/symlinks/5782_G1_IP_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  6
File base:  ./fastqs/symlinks/5782_Q_IN_S8
       r1:  ./fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993211
FastQC job submitted for ./fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz

Submitted batch job 7993212
FastQC job submitted for ./fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  7
File base:  ./fastqs/symlinks/5782_Q_IP_S4
       r1:  ./fastqs/symlinks/5782_Q_IP_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_Q_IP_S4_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993213
FastQC job submitted for ./fastqs/symlinks/5782_Q_IP_S4_R1_001.fastq.gz

Submitted batch job 7993214
FastQC job submitted for ./fastqs/symlinks/5782_Q_IP_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  8
File base:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5
       r1:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993215
FastQC job submitted for ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz

Submitted batch job 7993216
FastQC job submitted for ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  9
File base:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11
       r1:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993217
FastQC job submitted for ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz

Submitted batch job 7993218
FastQC job submitted for ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz


# --------------------------------------
Iteration:  10
File base:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6
       r1:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993219
FastQC job submitted for ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz

Submitted batch job 7993220
FastQC job submitted for ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  11
File base:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12
       r1:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993221
FastQC job submitted for ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz

Submitted batch job 7993222
FastQC job submitted for ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz


# --------------------------------------
Iteration:  12
File base:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1
       r1:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993223
FastQC job submitted for ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz

Submitted batch job 7993224
FastQC job submitted for ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  13
File base:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7
       r1:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993225
FastQC job submitted for ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz

Submitted batch job 7993226
FastQC job submitted for ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  14
File base:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2
       r1:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993227
FastQC job submitted for ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz

Submitted batch job 7993228
FastQC job submitted for ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  15
File base:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8
       r1:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993229
FastQC job submitted for ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz

Submitted batch job 7993230
FastQC job submitted for ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  16
File base:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3
       r1:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993231
FastQC job submitted for ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz

Submitted batch job 7993232
FastQC job submitted for ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  17
File base:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9
       r1:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993233
FastQC job submitted for ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz

Submitted batch job 7993234
FastQC job submitted for ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz


# --------------------------------------
Iteration:  18
File base:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4
       r1:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993237
FastQC job submitted for ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz

Submitted batch job 7993238
FastQC job submitted for ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  19
File base:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10
       r1:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993239
FastQC job submitted for ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz

Submitted batch job 7993240
FastQC job submitted for ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz


# --------------------------------------
Iteration:  20
File base:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22
       r1:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993241
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz

Submitted batch job 7993242
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz


# --------------------------------------
Iteration:  21
File base:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23
       r1:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993243
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz

Submitted batch job 7993244
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz


# --------------------------------------
Iteration:  22
File base:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13
       r1:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993245
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz

Submitted batch job 7993246
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz


# --------------------------------------
Iteration:  23
File base:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14
       r1:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993247
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz

Submitted batch job 7993248
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz


# --------------------------------------
Iteration:  24
File base:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15
       r1:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993249
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz

Submitted batch job 7993250
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz


# --------------------------------------
Iteration:  25
File base:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16
       r1:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993251
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz

Submitted batch job 7993252
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz


# --------------------------------------
Iteration:  26
File base:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17
       r1:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993253
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz

Submitted batch job 7993254
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz


# --------------------------------------
Iteration:  27
File base:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18
       r1:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993255
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz

Submitted batch job 7993256
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz


# --------------------------------------
Iteration:  28
File base:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19
       r1:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993257
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz

Submitted batch job 7993258
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz


# --------------------------------------
Iteration:  29
File base:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20
       r1:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993259
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz

Submitted batch job 7993260
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz


# --------------------------------------
Iteration:  30
File base:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21
       r1:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993261
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz

Submitted batch job 7993262
FastQC job submitted for ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz


# --------------------------------------
Iteration:  31
File base:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10
       r1:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993263
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz

Submitted batch job 7993264
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz


# --------------------------------------
Iteration:  32
File base:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11
       r1:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993265
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz

Submitted batch job 7993266
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz


# --------------------------------------
Iteration:  33
File base:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12
       r1:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993267
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz

Submitted batch job 7993268
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz


# --------------------------------------
Iteration:  34
File base:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1
       r1:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993269
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz

Submitted batch job 7993270
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  35
File base:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2
       r1:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993271
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz

Submitted batch job 7993272
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  36
File base:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3
       r1:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993273
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz

Submitted batch job 7993274
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  37
File base:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4
       r1:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993275
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz

Submitted batch job 7993276
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  38
File base:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5
       r1:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993277
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz

Submitted batch job 7993278
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  39
File base:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6
       r1:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993279
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz

Submitted batch job 7993280
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  40
File base:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7
       r1:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993281
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz

Submitted batch job 7993282
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  41
File base:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8
       r1:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993283
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz

Submitted batch job 7993284
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  42
File base:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9
       r1:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993285
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz

Submitted batch job 7993286
FastQC job submitted for ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz


# --------------------------------------
Iteration:  43
File base:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
       r1:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993287
FastQC job submitted for ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz

Submitted batch job 7993288
FastQC job submitted for ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  44
File base:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
       r1:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993289
FastQC job submitted for ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz

Submitted batch job 7993290
FastQC job submitted for ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz


# --------------------------------------
Iteration:  45
File base:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
       r1:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993291
FastQC job submitted for ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz

Submitted batch job 7993292
FastQC job submitted for ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  46
File base:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
       r1:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993293
FastQC job submitted for ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz

Submitted batch job 7993294
FastQC job submitted for ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  47
File base:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
       r1:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993295
FastQC job submitted for ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz

Submitted batch job 7993296
FastQC job submitted for ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  48
File base:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
       r1:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993297
FastQC job submitted for ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz

Submitted batch job 7993298
FastQC job submitted for ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  49
File base:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
       r1:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993299
FastQC job submitted for ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz

Submitted batch job 7993300
FastQC job submitted for ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  50
File base:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
       r1:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993301
FastQC job submitted for ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz

Submitted batch job 7993302
FastQC job submitted for ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  51
File base:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
       r1:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993303
FastQC job submitted for ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz

Submitted batch job 7993304
FastQC job submitted for ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  52
File base:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
       r1:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993305
FastQC job submitted for ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz

Submitted batch job 7993306
FastQC job submitted for ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz


# --------------------------------------
Iteration:  53
File base:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11
       r1:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993307
FastQC job submitted for ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz

Submitted batch job 7993308
FastQC job submitted for ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz


# --------------------------------------
Iteration:  54
File base:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12
       r1:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
   outdir:  ./FastQC/symlinks

Submitted batch job 7993309
FastQC job submitted for ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz

Submitted batch job 7993310
FastQC job submitted for ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
```
</details>
<br />

<a id="run-trim_galore-on-fastq-files"></a>
### Run `trim_galore` on `fastq` files
<a id="get-situated-3"></a>
#### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get on a node, etc. if necessary
grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
	{
		cd "results/2023-0115" || echo "cd'ing failed; check on this"
	}

#  Make directory if necessary
if [[ ! -d "./fastqs/trim_galore" ]]; then
    mkdir -p "./fastqs/trim_galore"
fi

#  Variables
script_name="submit_run-trim-galore.sh"  # echo "${script_name}"
threads=1  # echo "${threads}"

#  Arrays
unset fq_r1
unset fq_r2
typeset -a fq_r1
typeset -a fq_r2
for i in "${fq_bases[@]}"; do
	fq_r1+=("${i}_R1_001.fastq.gz")
	fq_r2+=("${i}_R3_001.fastq.gz")
done
# echo_test "${fq_r1[@]}"
# echo_test "${fq_r2[@]}"
# echo "${#fq_r1[@]}"  # 55
# echo "${#fq_r2[@]}"  # 55
# ., "${fq_r1[11]}"
# ., "${fq_r2[11]}"
```
</details>
<br />

<a id="use-a-heredoc-to-write-the-script-submit_run-trim-galoresh"></a>
#### Use a `HEREDOC` to write the script, `submit_run-trim-galore.sh`
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_run-trim-galore.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./sh_err_out/${script_name}" ]]; then
        rm "./sh_err_out/${script_name}"
fi
cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

infile_1="\${1}"
infile_2="\${2}"
outdir="\${3}"

#  Echo test
parallel --header : --colsep " " -k -j 1 echo -e \\
"trim_galore \\
    --paired \\
    --retain_unpaired \\
    --phred33 \\
    --output_dir {outdir} \\
    --length 36 \\
    --quality 5 \\
    --stringency 1 \\
    -e 0.1 \\
    {infile_1} \\
    {infile_2}" \\
::: infile_1 "\${infile_1}" \\
::: infile_2 "\${infile_2}" \\
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
    {infile_1} \\
    {infile_2}" \\
::: infile_1 "\${infile_1}" \\
::: infile_2 "\${infile_2}" \\
::: outdir "\${outdir}"

echo ""
script
# vi "./sh_err_out/${script_name}"
```
</details>
<br />

<a id="run-submit_run-trim-galoresh-on-fastq-files"></a>
#### Run `submit_run-trim-galore.sh` on `fastq` files
<details>
<summary><i>Code: Run submit_run-trim-galore.sh on fastq files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#fq_bases[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
	echo "# --------------------------------------"
	echo "Iteration:  ${i}"
	echo "File base:  ${fq_bases[${i}]}"
	echo "       r1:  ${fq_r1[${i}]}"
	echo "       r2:  ${fq_r2[${i}]}"
	echo "   outdir:  ./fastqs/trim_galore"
	echo ""
	
	sbatch "./sh_err_out/${script_name}" \
		"${fq_r1[${i}]}" \
		"${fq_r2[${i}]}" \
		"./fastqs/trim_galore"
	echo "trim_galore job submitted for ${fq_r1[${i}]} and ${fq_r2[${i}]}"
	
	echo ""
	echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Run submit_run-trim-galore.sh on fastq files</i></summary>

```txt
# --------------------------------------
Iteration:  0
File base:  ./fastqs/symlinks/5781_G1_IN_S5
       r1:  ./fastqs/symlinks/5781_G1_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_G1_IN_S5_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993566
trim_galore job submitted for ./fastqs/symlinks/5781_G1_IN_S5_R1_001.fastq.gz and ./fastqs/symlinks/5781_G1_IN_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  1
File base:  ./fastqs/symlinks/5781_G1_IP_S1
       r1:  ./fastqs/symlinks/5781_G1_IP_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_G1_IP_S1_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993567
trim_galore job submitted for ./fastqs/symlinks/5781_G1_IP_S1_R1_001.fastq.gz and ./fastqs/symlinks/5781_G1_IP_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  2
File base:  ./fastqs/symlinks/5781_Q_IN_S6
       r1:  ./fastqs/symlinks/5781_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993568
trim_galore job submitted for ./fastqs/symlinks/5781_Q_IN_S6_R1_001.fastq.gz and ./fastqs/symlinks/5781_Q_IN_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  3
File base:  ./fastqs/symlinks/5781_Q_IP_S2
       r1:  ./fastqs/symlinks/5781_Q_IP_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5781_Q_IP_S2_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993569
trim_galore job submitted for ./fastqs/symlinks/5781_Q_IP_S2_R1_001.fastq.gz and ./fastqs/symlinks/5781_Q_IP_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  4
File base:  ./fastqs/symlinks/5782_G1_IN_S7
       r1:  ./fastqs/symlinks/5782_G1_IN_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_G1_IN_S7_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993570
trim_galore job submitted for ./fastqs/symlinks/5782_G1_IN_S7_R1_001.fastq.gz and ./fastqs/symlinks/5782_G1_IN_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  5
File base:  ./fastqs/symlinks/5782_G1_IP_S3
       r1:  ./fastqs/symlinks/5782_G1_IP_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_G1_IP_S3_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993571
trim_galore job submitted for ./fastqs/symlinks/5782_G1_IP_S3_R1_001.fastq.gz and ./fastqs/symlinks/5782_G1_IP_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  6
File base:  ./fastqs/symlinks/5782_Q_IN_S8
       r1:  ./fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993572
trim_galore job submitted for ./fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz and ./fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  7
File base:  ./fastqs/symlinks/5782_Q_IP_S4
       r1:  ./fastqs/symlinks/5782_Q_IP_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/5782_Q_IP_S4_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993573
trim_galore job submitted for ./fastqs/symlinks/5782_Q_IP_S4_R1_001.fastq.gz and ./fastqs/symlinks/5782_Q_IP_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  8
File base:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5
       r1:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993574
trim_galore job submitted for ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz and ./fastqs/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  9
File base:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11
       r1:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993575
trim_galore job submitted for ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz and ./fastqs/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz


# --------------------------------------
Iteration:  10
File base:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6
       r1:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993576
trim_galore job submitted for ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz and ./fastqs/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  11
File base:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12
       r1:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993577
trim_galore job submitted for ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz and ./fastqs/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz


# --------------------------------------
Iteration:  12
File base:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1
       r1:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993578
trim_galore job submitted for ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz and ./fastqs/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  13
File base:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7
       r1:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993579
trim_galore job submitted for ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz and ./fastqs/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  14
File base:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2
       r1:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993580
trim_galore job submitted for ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz and ./fastqs/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  15
File base:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8
       r1:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993581
trim_galore job submitted for ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz and ./fastqs/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  16
File base:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3
       r1:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993582
trim_galore job submitted for ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz and ./fastqs/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  17
File base:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9
       r1:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993583
trim_galore job submitted for ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz and ./fastqs/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz


# --------------------------------------
Iteration:  18
File base:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4
       r1:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993584
trim_galore job submitted for ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz and ./fastqs/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  19
File base:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10
       r1:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993585
trim_galore job submitted for ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz and ./fastqs/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz


# --------------------------------------
Iteration:  20
File base:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22
       r1:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993586
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz


# --------------------------------------
Iteration:  21
File base:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23
       r1:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993587
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz


# --------------------------------------
Iteration:  22
File base:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13
       r1:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993588
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz


# --------------------------------------
Iteration:  23
File base:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14
       r1:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993589
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz


# --------------------------------------
Iteration:  24
File base:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15
       r1:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993590
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz


# --------------------------------------
Iteration:  25
File base:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16
       r1:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993591
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz


# --------------------------------------
Iteration:  26
File base:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17
       r1:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993592
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz


# --------------------------------------
Iteration:  27
File base:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18
       r1:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993593
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz


# --------------------------------------
Iteration:  28
File base:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19
       r1:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993594
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz


# --------------------------------------
Iteration:  29
File base:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20
       r1:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993595
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz


# --------------------------------------
Iteration:  30
File base:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21
       r1:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993596
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz


# --------------------------------------
Iteration:  31
File base:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10
       r1:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993597
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz


# --------------------------------------
Iteration:  32
File base:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11
       r1:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993598
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz


# --------------------------------------
Iteration:  33
File base:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12
       r1:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993599
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz


# --------------------------------------
Iteration:  34
File base:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1
       r1:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993600
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  35
File base:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2
       r1:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993601
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  36
File base:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3
       r1:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993602
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  37
File base:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4
       r1:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993603
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  38
File base:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5
       r1:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993604
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  39
File base:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6
       r1:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993605
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  40
File base:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7
       r1:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993606
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  41
File base:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8
       r1:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993607
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  42
File base:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9
       r1:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993608
trim_galore job submitted for ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz and ./fastqs/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz


# --------------------------------------
Iteration:  43
File base:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
       r1:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993609
trim_galore job submitted for ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz


# --------------------------------------
Iteration:  44
File base:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
       r1:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993610
trim_galore job submitted for ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz


# --------------------------------------
Iteration:  45
File base:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
       r1:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993611
trim_galore job submitted for ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz


# --------------------------------------
Iteration:  46
File base:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
       r1:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993612
trim_galore job submitted for ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz


# --------------------------------------
Iteration:  47
File base:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
       r1:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993613
trim_galore job submitted for ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz


# --------------------------------------
Iteration:  48
File base:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
       r1:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993614
trim_galore job submitted for ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz


# --------------------------------------
Iteration:  49
File base:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
       r1:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993615
trim_galore job submitted for ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz


# --------------------------------------
Iteration:  50
File base:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
       r1:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993616
trim_galore job submitted for ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz


# --------------------------------------
Iteration:  51
File base:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
       r1:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993617
trim_galore job submitted for ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz


# --------------------------------------
Iteration:  52
File base:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
       r1:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993618
trim_galore job submitted for ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz


# --------------------------------------
Iteration:  53
File base:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11
       r1:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993619
trim_galore job submitted for ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz


# --------------------------------------
Iteration:  54
File base:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12
       r1:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
       r2:  ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
   outdir:  ./fastqs/trim_galore

Submitted batch job 7993620
trim_galore job submitted for ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz and ./fastqs/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
```
</details>
<br />

<a id="run-fastqc-on-trim_galore-processed-fastq-files"></a>
### Run `FastQC` on `trim_galore`-processed `fastq` files
`#PICKUPHERE`
<a id="get-situated-4"></a>
#### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get on a node, etc. if necessary
grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
	{
		cd "results/2023-0115" || echo "cd'ing failed; check on this"
	}

#  Make directory if necessary
if [[ ! -d "./FastQC/trim_galore" ]]; then
    mkdir -p "./FastQC/trim_galore"
fi

#  Variables
script_name="submit_run-fastqc.sh"  # echo "${script_name}"
threads=4  # echo "${threads}"

#  Arrays
unset fq_bases_t
typeset -a fq_bases_t
while IFS=" " read -r -d $'\0'; do
    fq_bases_t+=( "${REPLY%_R?_001_val_?.fq}" )
done < <(\
    find "./fastqs_trim-galore" \
        -type f \
        -name "*_val_?.fq" \
        -print0 \
            | sort -z \
)
# echo_test "${fq_bases_t[@]}"

IFS=" " read -r -a fq_bases_t \
	<<< "$(\
		tr ' ' '\n' \
			<<< "${fq_bases_t[@]}" \
				| sort -u \
				| tr '\n' ' '\
	)"
# echo_test "${fq_bases_t[@]}"

unset fq_t_r1
unset fq_t_r2
typeset -a fq_t_r1
typeset -a fq_t_r2
for i in "${fq_bases_t[@]}"; do
	fq_t_r1+=("${i}_R1_001_val_1.fq")
	fq_t_r2+=("${i}_R3_001_val_2.fq")
done
# echo_test "${fq_t_r1[@]}"
# echo_test "${fq_t_r2[@]}"
# echo "${#fq_t_r1[@]}"  # 12
# echo "${#fq_t_r2[@]}"  # 12
# ., "${fq_t_r1[8]}"
# ., "${fq_t_r2[8]}"
```
</details>
<br />

<a id="run-submit_run-fastqcsh-on-trim_galore-processed-fastq-files"></a>
#### Run `submit_run-fastqc.sh` on `trim_galore`-processed `fastq` files
<details>
<summary><i>Code: Run submit_run-fastqc.sh on trim_galore-processed fastq files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#fq_bases_t[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
	echo "# --------------------------------------"
	echo "Iteration:  ${i}"
	echo "File base:  ${fq_bases_t[${i}]}"
	echo "       r1:  ${fq_t_r1[${i}]}"
	echo "       r2:  ${fq_t_r2[${i}]}"
	echo "   outdir:  ./FastQC/trim_galore"
	echo ""

	#  For r1
	sbatch "./sh_err_out/${script_name}" \
		"${fq_t_r1[${i}]}" \
		"./FastQC/trim_galore"
	echo "FastQC job submitted for ${fq_t_r1[${i}]}"
	echo ""

	#  For r2
	sbatch "./sh_err_out/${script_name}" \
		"${fq_t_r2[${i}]}" \
		"./FastQC/trim_galore"
	echo "FastQC job submitted for ${fq_t_r2[${i}]}"

	echo ""
	echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Run submit_run-fastqc.sh on trim_galore-processed fastq files</i></summary>

```txt

```
</details>
<br />
<br />

<a id="align-the-trimmed-compressed-fastq-files-to-a-combined-reference"></a>
## Align the trimmed, compressed `fastq` files to a combined reference
The reference genome is composed of *S. cerevisiae*, *K. lactis*, and *20S* sequences

<a id="get-situated-5"></a>
### Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get on a node, etc. if necessary
grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
	{
		cd "results/2023-0115" || echo "cd'ing failed; check on this"
	}

#  Directory
if [[ ! -d "./bams" ]]; then
	mkdir -p bams/SC_KL_20S
	mkdir -p bams/SC
	mkdir -p bams/SC_KL
	mkdir -p bams/KL
	mkdir -p bams/20S
	mkdir -p FastQC/bams/SC_KL_20S
	mkdir -p FastQC/bams/SC
	mkdir -p FastQC/bams/SC_KL
	mkdir -p FastQC/bams/KL
	mkdir -p FastQC/bams/20S
fi

#  Variables
script_name="submit_STAR.sh"  # echo "${script_name}"
threads=16  # echo "${threads}"
dir_genome="${HOME}/genomes/combined_SC_KL_20S/STAR"  # ., "${dir_genome}"

#  Arrays
unset fq_bases_gz
typeset -a fq_bases_gz
while IFS=" " read -r -d $'\0'; do
    fq_bases_gz+=( "${REPLY%_R?_001_val_?.fq.gz}" )
done < <(\
    find "./fastqs_trim-galore" \
        -type f \
        -name "*_val_?.fq.gz" \
        -print0 \
            | sort -z \
)
# echo_test "${fq_bases_gz[@]}"

IFS=" " read -r -a fq_bases_gz \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fq_bases_gz[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# echo_test "${fq_bases_gz[@]}"

unset fq_gz_r1
unset fq_gz_r2
unset fq_pre
typeset -a fq_gz_r1
typeset -a fq_gz_r2
typeset -a fq_pre
for i in "${fq_bases_gz[@]}"; do
    fq_gz_r1+=( "${i}_R1_001_val_1.fq.gz" )
    fq_gz_r2+=( "${i}_R3_001_val_2.fq.gz" )
    fq_pre+=( "$(basename "${i}")" )
done
# echo_test "${fq_gz_r1[@]}"
# echo_test "${fq_gz_r2[@]}"
# echo_test "${fq_pre[@]}"
# echo "${#fq_gz_r1[@]}"  # 12
# echo "${#fq_gz_r2[@]}"  # 12
# echo "${#fq_pre[@]}"  # 12
#   ., "${fq_gz_r1[7]}"
#   ., "${fq_gz_r2[7]}"
# echo "${fq_gz_r2[7]}"
```
</details>
<br />

<a id="use-a-heredoc-to-write-the-script-submit_starsh"></a>
### Use a `HEREDOC` to write the script, `submit_STAR.sh`
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_STAR.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

read_1="\${1}"
read_2="\${2}"
prefix="\${3}"
dir_genome="\${4}"

echo -e "STAR \\ \n\
    --runMode alignReads \\ \n\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --outSAMtype BAM SortedByCoordinate \\ \n\
    --outSAMunmapped None \\ \n\
    --outSAMattributes All \\ \n\
    --genomeDir "\${dir_genome}" \\ \n\
    --readFilesIn "\${read_1}" "\${read_2}" \\ \n\
    --readFilesCommand zcat \\ \n\
    --outFileNamePrefix "\${prefix}" \\ \n\
    --limitBAMsortRAM 4000000000 \\ \n\
    --outFilterMultimapNmax 1 \\ \n\
    --winAnchorMultimapNmax 1000 \\ \n\
    --alignSJoverhangMin 8 \\ \n\
    --alignSJDBoverhangMin 1 \\ \n\
    --outFilterMismatchNmax 999 \\ \n\
    --outMultimapperOrder Random \\ \n\
    --alignEndsType EndToEnd \\ \n\
    --alignIntronMin 4 \\ \n\
    --alignIntronMax 5000 \\ \n\
    --alignMatesGapMax 5000"

STAR \\
    --runMode alignReads \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMtype BAM SortedByCoordinate \\
    --outSAMunmapped None \\
    --outSAMattributes All \\
    --genomeDir "\${dir_genome}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --readFilesCommand zcat \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax 1 \\
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
# vi "./sh_err_out/${script_name}"  # :q
```
</details>
<br />

<a id="run-submit_starsh-on-fqgz-files"></a>
### Run `submit_STAR.sh` on `fq.gz` files
<details>
<summary><i>Code: Run submit_STAR.sh on fq.gz files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#fq_bases_gz[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "# --------------------------------------"
    echo "Iteration:  ${i}"
    echo "File base:  ${fq_bases_gz[${i}]}"
    echo "       r1:  ${fq_gz_r1[${i}]}"
    echo "       r2:  ${fq_gz_r2[${i}]}"
    echo "   prefix:  ${fq_pre[${i}]}"
    echo ""

    sbatch "./sh_err_out/${script_name}" \
    	"${fq_gz_r1[${i}]}" \
    	"${fq_gz_r2[${i}]}" \
    	"./bams/SC_KL_20S/${fq_pre[${i}]}" \
    	"${dir_genome}"

    echo ""
    echo ""
done
```
</details>
<br />

<details>
<summary><i>Printed: Run submit_STAR.sh on fq.gz files</i></summary>

```txt
# --------------------------------------
Iteration:  0
File base:  ./fastqs_trim-galore/CW10_7747_8day_Q_IN_S5
       r1:  ./fastqs_trim-galore/CW10_7747_8day_Q_IN_S5_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW10_7747_8day_Q_IN_S5_R3_001_val_2.fq.gz
   prefix:  CW10_7747_8day_Q_IN_S5

Submitted batch job 7958373


# --------------------------------------
Iteration:  1
File base:  ./fastqs_trim-galore/CW10_7747_8day_Q_PD_S11
       r1:  ./fastqs_trim-galore/CW10_7747_8day_Q_PD_S11_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW10_7747_8day_Q_PD_S11_R3_001_val_2.fq.gz
   prefix:  CW10_7747_8day_Q_PD_S11

Submitted batch job 7958374


# --------------------------------------
Iteration:  2
File base:  ./fastqs_trim-galore/CW12_7748_8day_Q_IN_S6
       r1:  ./fastqs_trim-galore/CW12_7748_8day_Q_IN_S6_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW12_7748_8day_Q_IN_S6_R3_001_val_2.fq.gz
   prefix:  CW12_7748_8day_Q_IN_S6

Submitted batch job 7958375


# --------------------------------------
Iteration:  3
File base:  ./fastqs_trim-galore/CW12_7748_8day_Q_PD_S12
       r1:  ./fastqs_trim-galore/CW12_7748_8day_Q_PD_S12_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW12_7748_8day_Q_PD_S12_R3_001_val_2.fq.gz
   prefix:  CW12_7748_8day_Q_PD_S12

Submitted batch job 7958376


# --------------------------------------
Iteration:  4
File base:  ./fastqs_trim-galore/CW2_5781_8day_Q_IN_S1
       r1:  ./fastqs_trim-galore/CW2_5781_8day_Q_IN_S1_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW2_5781_8day_Q_IN_S1_R3_001_val_2.fq.gz
   prefix:  CW2_5781_8day_Q_IN_S1

Submitted batch job 7958377


# --------------------------------------
Iteration:  5
File base:  ./fastqs_trim-galore/CW2_5781_8day_Q_PD_S7
       r1:  ./fastqs_trim-galore/CW2_5781_8day_Q_PD_S7_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW2_5781_8day_Q_PD_S7_R3_001_val_2.fq.gz
   prefix:  CW2_5781_8day_Q_PD_S7

Submitted batch job 7958378


# --------------------------------------
Iteration:  6
File base:  ./fastqs_trim-galore/CW4_5782_8day_Q_IN_S2
       r1:  ./fastqs_trim-galore/CW4_5782_8day_Q_IN_S2_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW4_5782_8day_Q_IN_S2_R3_001_val_2.fq.gz
   prefix:  CW4_5782_8day_Q_IN_S2

Submitted batch job 7958379


# --------------------------------------
Iteration:  7
File base:  ./fastqs_trim-galore/CW4_5782_8day_Q_PD_S8
       r1:  ./fastqs_trim-galore/CW4_5782_8day_Q_PD_S8_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW4_5782_8day_Q_PD_S8_R3_001_val_2.fq.gz
   prefix:  CW4_5782_8day_Q_PD_S8

Submitted batch job 7958380


# --------------------------------------
Iteration:  8
File base:  ./fastqs_trim-galore/CW6_7078_8day_Q_IN_S3
       r1:  ./fastqs_trim-galore/CW6_7078_8day_Q_IN_S3_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW6_7078_8day_Q_IN_S3_R3_001_val_2.fq.gz
   prefix:  CW6_7078_8day_Q_IN_S3

Submitted batch job 7958381


# --------------------------------------
Iteration:  9
File base:  ./fastqs_trim-galore/CW6_7078_8day_Q_PD_S9
       r1:  ./fastqs_trim-galore/CW6_7078_8day_Q_PD_S9_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW6_7078_8day_Q_PD_S9_R3_001_val_2.fq.gz
   prefix:  CW6_7078_8day_Q_PD_S9

Submitted batch job 7958382


# --------------------------------------
Iteration:  10
File base:  ./fastqs_trim-galore/CW8_7079_8day_Q_IN_S4
       r1:  ./fastqs_trim-galore/CW8_7079_8day_Q_IN_S4_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW8_7079_8day_Q_IN_S4_R3_001_val_2.fq.gz
   prefix:  CW8_7079_8day_Q_IN_S4

Submitted batch job 7958383


# --------------------------------------
Iteration:  11
File base:  ./fastqs_trim-galore/CW8_7079_8day_Q_PD_S10
       r1:  ./fastqs_trim-galore/CW8_7079_8day_Q_PD_S10_R1_001_val_1.fq.gz
       r2:  ./fastqs_trim-galore/CW8_7079_8day_Q_PD_S10_R3_001_val_2.fq.gz
   prefix:  CW8_7079_8day_Q_PD_S10

Submitted batch job 7958384
```
</details>
<br />

<a id="clean-up-results-from-star-alignment-then-index-bams"></a>
#### Clean up results from `STAR` alignment, then index `bam`s
<a id="get-situated-6"></a>
##### Get situated
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="clean-uprename-results-of-star-alignment"></a>
##### Clean up/rename results of `STAR` alignment
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="index-the-bams"></a>
#### Index the `bam`s
<a id="get-bams-of-interest-into-an-array"></a>
##### Get `bam`s of interest into an array
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="run-samtools-index-on-each-element-of-bam-array"></a>
##### Run `samtools index` on each element of `bam` array
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="create-bams-composed-of-alignments-to-specific-species"></a>
### Create `bam`s composed of alignments to specific species
<a id="create-bams-wo-20s-alignments-composed-of-s-cerevisiae-and-k-lactis"></a>
#### Create `bam`s w/o *20S* alignments: composed of *S. cerevisiae* and *K. lactis*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="create-bams-wo-klactis-and-20s-alignments-composed-of-s-cerevisiae"></a>
#### Create `bam`s w/o *K.lactis* and *20S* alignments: composed of *S. cerevisiae*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="create-bams-wo-s-cerevisiae-and-20s-alignments-composed-of-k-lactis"></a>
#### Create `bam`s w/o *S. cerevisiae* and *20S* alignments: composed of *K. lactis*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```

<a id="create-bams-wo-s-cerevisiae-and-k-lactis-alignments-composed-of-20s"></a>
#### Create `bam`s w/o *S. cerevisiae* and *K. lactis* alignments: composed of *20S*
```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
