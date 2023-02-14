
`#work_draft_process-data_4tU-seq_no-UMI-dedup.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Notes, emails, etc.](#notes-emails-etc)
	1. [Email from Alison to me, 2023-0113, 17:51](#email-from-alison-to-me-2023-0113-1751)
1. [Get `fastq` file stems into an array](#get-fastq-file-stems-into-an-array)
	1. [Code](#code)
	1. [Printed](#printed)
1. [Perform adapter and quality trimming of the `fastq`s](#perform-adapter-and-quality-trimming-of-the-fastqs)
	1. [Run `atria` to learn about adapter contamination](#run-atria-to-learn-about-adapter-contamination)
		1. [Code](#code-1)
		1. [Printed](#printed-1)
	1. [Run `FastQC` on `fastq` files](#run-fastqc-on-fastq-files)
		1. [Get situated](#get-situated)
			1. [Code](#code-2)
		1. [Use a `HEREDOC` to write the script, `submit_run-FastQC_no-dedup.sh`](#use-a-heredoc-to-write-the-script-submit_run-fastqc_no-dedupsh)
			1. [Code](#code-3)
		1. [Run `submit_run-FastQC_no-dedup.sh` on `fastq` files](#run-submit_run-fastqc_no-dedupsh-on-fastq-files)
			1. [Code](#code-4)
			1. [Printed](#printed-2)
	1. [Run `trim_galore` on `fastq` files](#run-trim_galore-on-fastq-files)
		1. [Get situated](#get-situated-1)
			1. [Code](#code-5)
		1. [Use a `HEREDOC` to write the script, `submit_run-trim-galore.sh`](#use-a-heredoc-to-write-the-script-submit_run-trim-galoresh)
			1. [Code](#code-6)
		1. [Run `submit_run-trim-galore.sh` on `fastq` files](#run-submit_run-trim-galoresh-on-fastq-files)
			1. [Code](#code-7)
			1. [Printed](#printed-3)
	1. [Run `FastQC_no-dedup` on `trim_galore`-processed `fastq` files](#run-fastqc_no-dedup-on-trim_galore-processed-fastq-files)
		1. [Get situated](#get-situated-2)
			1. [Code](#code-8)
		1. [Run `submit_run-FastQC_no-dedup.sh` on `trim_galore`-processed `fastq` files](#run-submit_run-fastqc_no-dedupsh-on-trim_galore-processed-fastq-files)
			1. [Code](#code-9)
			1. [Printed](#printed-4)
1. [Align the trimmed, compressed `fastq` files to a combined reference](#align-the-trimmed-compressed-fastq-files-to-a-combined-reference)
	1. [Get situated](#get-situated-3)
		1. [Code](#code-10)
	1. [Write and run the script `submit_star_unmapped-rm.sh`](#write-and-run-the-script-submit_star_unmapped-rmsh)
		1. [Assign variables and arrays](#assign-variables-and-arrays)
			1. [Code](#code-11)
		1. [Use a `HEREDOC` to write the script, `submit_star_unmapped-rm.sh`](#use-a-heredoc-to-write-the-script-submit_star_unmapped-rmsh)
			1. [Code](#code-12)
		1. [Run `submit_star_unmapped-rm.sh` on `fq.gz` files](#run-submit_star_unmapped-rmsh-on-fqgz-files)
			1. [Code](#code-13)
			1. [Printed](#printed-5)
	1. [Write and run the script `submit_star_unmapped-w.sh`](#write-and-run-the-script-submit_star_unmapped-wsh)
		1. [Assign variables and arrays](#assign-variables-and-arrays-1)
			1. [Code](#code-14)
		1. [Use a `HEREDOC` to write the script, `submit_star_unmapped-w.sh`](#use-a-heredoc-to-write-the-script-submit_star_unmapped-wsh)
			1. [Code](#code-15)
		1. [Run `submit_star_unmapped-w.sh` on `fq.gz` files](#run-submit_star_unmapped-wsh-on-fqgz-files)
			1. [Code](#code-16)
			1. [Printed](#printed-6)
	1. [Clean up results from `STAR` alignment, then index `bam`s](#clean-up-results-from-star-alignment-then-index-bams)
		1. [Clean up/rename results of `STAR` alignment](#clean-uprename-results-of-star-alignment)
			1. [Notes](#notes)
			1. [In `bams/unmapped-rm/SC_KL_20S`...](#in-bamsunmapped-rmsc_kl_20s)
				1. [Code](#code-17)
				1. [Printed](#printed-7)
			1. [In `bams/unmapped-w/SC_KL_20S`...](#in-bamsunmapped-wsc_kl_20s)
				1. [Code](#code-18)
				1. [Printed](#printed-8)
		1. [Check on `*.Log.out` warning messages: "`WARNING: not enough space allocated for transcript.`"](#check-on-logout-warning-messages-warning-not-enough-space-allocated-for-transcript)
			1. [Notes](#notes-1)
			1. [Code](#code-19)
				1. [Code for `bams/unmapped-rm/SC_KL_20S`...](#code-for-bamsunmapped-rmsc_kl_20s)
				1. [Code for `bams/unmapped-w/SC_KL_20S`...](#code-for-bamsunmapped-wsc_kl_20s)
			1. [Printed](#printed-9)
				1. [Printed for `bams/unmapped-rm/SC_KL_20S`...](#printed-for-bamsunmapped-rmsc_kl_20s)
				1. [Printed for `bams/unmapped-w/SC_KL_20S`...](#printed-for-bamsunmapped-wsc_kl_20s)
	1. [Isolate, examine problematic reads](#isolate-examine-problematic-reads)
		1. [Rough draft work](#rough-draft-work)
			1. [Notes, code](#notes-code)
			1. [Printed](#printed-10)
	1. [Index the `bam`s](#index-the-bams)
		1. [Get situated](#get-situated-4)
			1. [Code](#code-20)
		1. [Set up necessary variables, get `bam`s of interest into an array](#set-up-necessary-variables-get-bams-of-interest-into-an-array)
			1. [Code](#code-21)
		1. [Use a `HEREDOC` to write the script, `submit_samtools-index.sh`](#use-a-heredoc-to-write-the-script-submit_samtools-indexsh)
			1. [Code](#code-22)
		1. [Run `samtools index` on each element of `bam` array](#run-samtools-index-on-each-element-of-bam-array)
			1. [Code](#code-23)
			1. [Printed](#printed-11)
	1. [Create `bam`s composed of alignments to specific species](#create-bams-composed-of-alignments-to-specific-species)
		1. [Get situated](#get-situated-5)
			1. [Code, notes](#code-notes)
			1. [Printed](#printed-12)
		1. [Try/troubleshoot a test run with `split_bam_by_species.sh`](#trytroubleshoot-a-test-run-with-split_bam_by_speciessh)
			1. [Code, printed, notes](#code-printed-notes)
		1. [Submit jobs to make `bam`s for species-specific alignments](#submit-jobs-to-make-bams-for-species-specific-alignments)
			1. [Set up necessary variables, get `bam`s of interest into an array](#set-up-necessary-variables-get-bams-of-interest-into-an-array-1)
				1. [Code](#code-24)
			1. [Run `split_bam_by_species.sh` on `bam`s: Trial w/"`SC`"](#run-split_bam_by_speciessh-on-bams-trial-wsc)
				1. [Notes, code](#notes-code-1)
		1. [Create `bam`s w/o *K.lactis* and *20S* alignments: composed of *S. cerevisiae*](#create-bams-wo-klactis-and-20s-alignments-composed-of-s-cerevisiae)
			1. [Code](#code-25)
		1. [Create `bam`s w/o *S. cerevisiae* and *20S* alignments: composed of *K. lactis*](#create-bams-wo-s-cerevisiae-and-20s-alignments-composed-of-k-lactis)
			1. [Code](#code-26)
		1. [Create `bam`s w/o *S. cerevisiae* and *K. lactis* alignments: composed of *20S*](#create-bams-wo-s-cerevisiae-and-k-lactis-alignments-composed-of-20s)
			1. [Code](#code-27)
1. [*Scraps*](#scraps)
	1. [Printed](#printed-13)
	1. [Printed](#printed-14)
	1. [Notes](#notes-2)

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
- I have compared `FastQC_no-dedup` for `7078` `R1` and `7079` `R1`
    + They look similar with the main issue being lots of 20S virus
    + `7078` `R3` does have over representation of "Illumina Single End PCR Primer 1 (97% over 34 bp)", but so does `7079` `R3`&mdash;perhaps trimmomatic would help? I have not looked at `WT`
- <u>Steady state</u> RNA sequencing from `7078` done a year prior had a normal reverse to forward ratio of `1` to `2` (found in `TRF4_SSRNA_April2022`)

My current working hypothesis is that, somewhere in the genome, there are a bunch of low quality reads on the reverse strand, but I have yet to find the region. I am currently running scripts to count reads mapping to each chromosome, and perhaps that will tell me more about what is going on. 

Any ideas or help you could provide would be wonderful. 

A
</details>
<br />
<br />

<a id="get-fastq-file-stems-into-an-array"></a>
## Get `fastq` file stems into an array
<a id="code"></a>
### Code
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
        cd "results/2023-0115" \
        	|| echo "cd'ing failed; check on this..."
    }

unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
done < <(\
    find "./fastqs_no-dedup/symlinks" \
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

<a id="printed"></a>
### Printed
<details>
<summary><i>Printed: Get fastq file stems into an array</i></summary>

```txt
❯ unset fq_bases
❯ typeset -a fq_bases
❯ while IFS=" " read -r -d $'\0'; do
>     fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
> done < <(\
>     find "./fastqs_no-dedup/symlinks" \
>         -type l \
>         -name "*.fastq.gz" \
>         -print0 \
>             | sort -z \
> )
❯ echo_test "${fq_bases[@]}"
./fastqs_no-dedup/symlinks/5781_G1_IN_S5
./fastqs_no-dedup/symlinks/5781_G1_IN_S5
./fastqs_no-dedup/symlinks/5781_G1_IP_S1
./fastqs_no-dedup/symlinks/5781_G1_IP_S1
./fastqs_no-dedup/symlinks/5781_Q_IN_S6
./fastqs_no-dedup/symlinks/5781_Q_IN_S6
./fastqs_no-dedup/symlinks/5781_Q_IP_S2
./fastqs_no-dedup/symlinks/5781_Q_IP_S2
./fastqs_no-dedup/symlinks/5782_G1_IN_S7
./fastqs_no-dedup/symlinks/5782_G1_IN_S7
./fastqs_no-dedup/symlinks/5782_G1_IP_S3
./fastqs_no-dedup/symlinks/5782_G1_IP_S3
./fastqs_no-dedup/symlinks/5782_Q_IN_S8
./fastqs_no-dedup/symlinks/5782_Q_IN_S8
./fastqs_no-dedup/symlinks/5782_Q_IP_S4
./fastqs_no-dedup/symlinks/5782_Q_IP_S4
./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5
./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5
./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11
./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11
./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6
./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6
./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12
./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12
./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1
./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1
./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7
./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7
./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2
./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2
./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8
./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8
./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3
./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3
./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9
./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9
./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4
./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4
./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10
./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10
./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22
./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22
./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23
./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23
./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13
./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13
./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14
./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14
./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15
./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15
./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16
./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16
./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17
./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17
./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18
./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18
./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19
./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19
./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20
./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20
./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21
./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21
./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10
./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10
./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11
./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11
./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12
./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12
./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1
./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1
./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2
./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2
./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3
./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3
./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4
./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4
./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5
./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5
./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6
./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6
./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7
./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7
./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8
./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8
./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9
./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9
./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11
./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11
./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12
./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12

❯ echo "${#fq_bases[@]}"
110

❯ IFS=" " read -r -a fq_bases \
>     <<< "$(\
>         tr ' ' '\n' \
>             <<< "${fq_bases[@]}" \
>                 | sort -u \
>                 | tr '\n' ' '\
>     )"
❯ echo_test "${fq_bases[@]}"
./fastqs_no-dedup/symlinks/5781_G1_IN_S5
./fastqs_no-dedup/symlinks/5781_G1_IP_S1
./fastqs_no-dedup/symlinks/5781_Q_IN_S6
./fastqs_no-dedup/symlinks/5781_Q_IP_S2
./fastqs_no-dedup/symlinks/5782_G1_IN_S7
./fastqs_no-dedup/symlinks/5782_G1_IP_S3
./fastqs_no-dedup/symlinks/5782_Q_IN_S8
./fastqs_no-dedup/symlinks/5782_Q_IP_S4
./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5
./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11
./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6
./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12
./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1
./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7
./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2
./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8
./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3
./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9
./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4
./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10
./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22
./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23
./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13
./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14
./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15
./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16
./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17
./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18
./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19
./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20
./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21
./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10
./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11
./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12
./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1
./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2
./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3
./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4
./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5
./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6
./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7
./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8
./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9
./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11
./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12

❯ echo "${#fq_bases[@]}"
55
```
</details>
<br />
<br />

<a id="perform-adapter-and-quality-trimming-of-the-fastqs"></a>
## Perform adapter and quality trimming of the `fastq`s
<a id="run-atria-to-learn-about-adapter-contamination"></a>
### Run `atria` to learn about adapter contamination
<a id="code-1"></a>
#### Code
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
#     -r "${fq_bases[0]}_R1_001.fastq.gz" \
#     -R "${fq_bases[0]}_R3_001.fastq.gz"

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

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Run atria to learn about adapter contamination</i></summary>

```txt
Iteration:  0
   Sample:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz:
└  No adapter detected in the first 418224 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R3_001.fastq.gz:
└  No adapter detected in the first 418224 reads.

Iteration:  1
   Sample:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R1_001.fastq.gz:
└  No adapter detected in the first 418204 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R3_001.fastq.gz:
└  No adapter detected in the first 418204 reads.

Iteration:  2
   Sample:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R1_001.fastq.gz:
└  No adapter detected in the first 418246 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R3_001.fastq.gz:
└  No adapter detected in the first 418246 reads.

Iteration:  4
   Sample:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R1_001.fastq.gz:
└  No adapter detected in the first 418213 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R3_001.fastq.gz:
└  No adapter detected in the first 418213 reads.

Iteration:  5
   Sample:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R1_001.fastq.gz:
└  No adapter detected in the first 418199 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R3_001.fastq.gz:
└  No adapter detected in the first 418199 reads.

Iteration:  6
   Sample:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R1_001.fastq.gz:
└  No adapter detected in the first 418169 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R3_001.fastq.gz:
└  No adapter detected in the first 418169 reads.

Iteration:  7
   Sample:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R1_001.fastq.gz:
└  No adapter detected in the first 418216 reads.
┌ Info: ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R3_001.fastq.gz:
└  No adapter detected in the first 418216 reads.

Iteration:  8
   Sample:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz:
│  Top 5 adapters detected in the first 395309 reads:
│ ┌──────────────────┬───────────┬──────────┐
│ │          Adapter │ Occurance │ Identity │
│ ├──────────────────┼───────────┼──────────┤
│ │ AGATCGGAAGAGCGTC │      3091 │ 0.996684 │
│ │ GATCGGAAGAGCGTCG │      3065 │ 0.925685 │
│ │ AGATCGGAAGAGCGGT │      2951 │ 0.875021 │
│ │ TCGTCGGCAGCGTCAG │        11 │    0.875 │
│ │ AGATCGGAAGAGCTCG │         8 │ 0.882812 │
└ └──────────────────┴───────────┴──────────┘

Iteration:  10
   Sample:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz:
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
   Sample:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12
pigz 2.6
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz:
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
┌ Info: ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz:
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
<a id="get-situated"></a>
#### Get situated
<a id="code-2"></a>
##### Code
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
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

#  Make a directory for storing the FastQC_no-dedup results
if [[ ! -d "./FastQC_no-dedup" ]]; then
    mkdir -p "./FastQC_no-dedup/symlinks"
    mkdir -p "./FastQC_no-dedup/trim_galore"
fi

#  Variables
script_name="submit_run-FastQC_no-dedup.sh"  # echo "${script_name}"
threads=4  # echo "${threads}"

#  Arrays
unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001.fastq.gz}" )
done < <(\
    find "./fastqs_no-dedup/symlinks" \
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

<a id="use-a-heredoc-to-write-the-script-submit_run-fastqc_no-dedupsh"></a>
#### Use a `HEREDOC` to write the script, `submit_run-FastQC_no-dedup.sh`
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_run-FastQC_no-dedup.sh</i></summary>

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

FastQC_no-dedup \\
    --threads "\${SLURM_CPUS_ON_NODE}" \\
    --outdir "\${outdir}" \\
    "\${infile}"
script
# vi "./sh_err_out/${script_name}"
```
</details>
<br />

<a id="run-submit_run-fastqc_no-dedupsh-on-fastq-files"></a>
#### Run `submit_run-FastQC_no-dedup.sh` on `fastq` files
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Run submit_run-FastQC_no-dedup.sh on fastq files</i></summary>

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
    echo "   outdir:  ./FastQC_no-dedup/symlinks"
    echo ""
    
    #  For r1
    sbatch "./sh_err_out/${script_name}" \
        "${fq_r1[${i}]}" \
        "./FastQC_no-dedup/symlinks"
    echo "FastQC_no-dedup job submitted for ${fq_r1[${i}]}"
    echo ""

    #  For r2
    sbatch "./sh_err_out/${script_name}" \
        "${fq_r2[${i}]}" \
        "./FastQC_no-dedup/symlinks"
    echo "FastQC_no-dedup job submitted for ${fq_r2[${i}]}"
    
    echo ""
    echo ""
done
```
</details>
<br />

<a id="printed-2"></a>
##### Printed
<details>
<summary><i>Printed: Run submit_run-FastQC_no-dedup.sh on fastq files</i></summary>

```txt
# --------------------------------------
Iteration:  0
File base:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5
       r1:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993199
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz

Submitted batch job 7993200
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  1
File base:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1
       r1:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993201
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R1_001.fastq.gz

Submitted batch job 7993202
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  2
File base:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6
       r1:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993203
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R1_001.fastq.gz

Submitted batch job 7993204
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  3
File base:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2
       r1:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993205
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R1_001.fastq.gz

Submitted batch job 7993206
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  4
File base:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7
       r1:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993207
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R1_001.fastq.gz

Submitted batch job 7993208
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  5
File base:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3
       r1:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993209
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R1_001.fastq.gz

Submitted batch job 7993210
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  6
File base:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8
       r1:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993211
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R1_001.fastq.gz

Submitted batch job 7993212
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  7
File base:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4
       r1:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993213
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R1_001.fastq.gz

Submitted batch job 7993214
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  8
File base:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5
       r1:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993215
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz

Submitted batch job 7993216
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  9
File base:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11
       r1:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993217
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz

Submitted batch job 7993218
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz

# --------------------------------------
Iteration:  10
File base:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6
       r1:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993219
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz

Submitted batch job 7993220
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  11
File base:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12
       r1:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993221
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz

Submitted batch job 7993222
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz

# --------------------------------------
Iteration:  12
File base:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1
       r1:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993223
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz

Submitted batch job 7993224
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  13
File base:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7
       r1:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993225
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz

Submitted batch job 7993226
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  14
File base:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2
       r1:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993227
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz

Submitted batch job 7993228
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  15
File base:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8
       r1:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993229
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz

Submitted batch job 7993230
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  16
File base:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3
       r1:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993231
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz

Submitted batch job 7993232
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  17
File base:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9
       r1:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993233
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz

Submitted batch job 7993234
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz

# --------------------------------------
Iteration:  18
File base:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4
       r1:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993237
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz

Submitted batch job 7993238
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  19
File base:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10
       r1:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993239
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz

Submitted batch job 7993240
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz

# --------------------------------------
Iteration:  20
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993241
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz

Submitted batch job 7993242
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz

# --------------------------------------
Iteration:  21
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993243
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz

Submitted batch job 7993244
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz

# --------------------------------------
Iteration:  22
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993245
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz

Submitted batch job 7993246
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz

# --------------------------------------
Iteration:  23
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993247
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz

Submitted batch job 7993248
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz

# --------------------------------------
Iteration:  24
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993249
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz

Submitted batch job 7993250
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz

# --------------------------------------
Iteration:  25
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993251
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz

Submitted batch job 7993252
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz

# --------------------------------------
Iteration:  26
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993253
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz

Submitted batch job 7993254
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz

# --------------------------------------
Iteration:  27
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993255
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz

Submitted batch job 7993256
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz

# --------------------------------------
Iteration:  28
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993257
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz

Submitted batch job 7993258
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz

# --------------------------------------
Iteration:  29
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993259
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz

Submitted batch job 7993260
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz

# --------------------------------------
Iteration:  30
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993261
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz

Submitted batch job 7993262
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz

# --------------------------------------
Iteration:  31
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993263
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz

Submitted batch job 7993264
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz

# --------------------------------------
Iteration:  32
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993265
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz

Submitted batch job 7993266
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz

# --------------------------------------
Iteration:  33
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993267
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz

Submitted batch job 7993268
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz

# --------------------------------------
Iteration:  34
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993269
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz

Submitted batch job 7993270
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  35
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993271
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz

Submitted batch job 7993272
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  36
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993273
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz

Submitted batch job 7993274
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  37
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993275
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz

Submitted batch job 7993276
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  38
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993277
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz

Submitted batch job 7993278
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  39
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993279
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz

Submitted batch job 7993280
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  40
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993281
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz

Submitted batch job 7993282
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  41
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993283
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz

Submitted batch job 7993284
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  42
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993285
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz

Submitted batch job 7993286
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz

# --------------------------------------
Iteration:  43
File base:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993287
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz

Submitted batch job 7993288
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  44
File base:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993289
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz

Submitted batch job 7993290
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz

# --------------------------------------
Iteration:  45
File base:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993291
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz

Submitted batch job 7993292
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  46
File base:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993293
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz

Submitted batch job 7993294
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  47
File base:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993295
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz

Submitted batch job 7993296
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  48
File base:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993297
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz

Submitted batch job 7993298
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  49
File base:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993299
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz

Submitted batch job 7993300
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  50
File base:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993301
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz

Submitted batch job 7993302
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  51
File base:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993303
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz

Submitted batch job 7993304
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  52
File base:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993305
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz

Submitted batch job 7993306
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz

# --------------------------------------
Iteration:  53
File base:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11
       r1:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993307
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz

Submitted batch job 7993308
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz

# --------------------------------------
Iteration:  54
File base:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12
       r1:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
   outdir:  ./FastQC_no-dedup/symlinks

Submitted batch job 7993309
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz

Submitted batch job 7993310
FastQC_no-dedup job submitted for ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
```
</details>
<br />

<a id="run-trim_galore-on-fastq-files"></a>
### Run `trim_galore` on `fastq` files
<a id="get-situated-1"></a>
#### Get situated
<a id="code-5"></a>
##### Code
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
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

#  Make directory if necessary
if [[ ! -d "./fastqs_no-dedup/trim_galore" ]]; then
    mkdir -p "./fastqs_no-dedup/trim_galore"
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
<a id="code-6"></a>
##### Code
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
<a id="code-7"></a>
##### Code
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
    echo "   outdir:  ./fastqs_no-dedup/trim_galore"
    echo ""
    
    sbatch "./sh_err_out/${script_name}" \
        "${fq_r1[${i}]}" \
        "${fq_r2[${i}]}" \
        "./fastqs_no-dedup/trim_galore"
    echo "trim_galore job submitted for ${fq_r1[${i}]} and ${fq_r2[${i}]}"
    
    echo ""
    echo ""
done
```
</details>
<br />

<a id="printed-3"></a>
##### Printed
<details>
<summary><i>Printed: Run submit_run-trim-galore.sh on fastq files</i></summary>

```txt
# --------------------------------------
Iteration:  0
File base:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5
       r1:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7992566
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5781_G1_IN_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  1
File base:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1
       r1:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7992567
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5781_G1_IP_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  2
File base:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6
       r1:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7992568
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5781_Q_IN_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  3
File base:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2
       r1:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7992569
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5781_Q_IP_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  4
File base:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7
       r1:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993570
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5782_G1_IN_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  5
File base:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3
       r1:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993571
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5782_G1_IP_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  6
File base:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8
       r1:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993572
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5782_Q_IN_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  7
File base:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4
       r1:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993573
trim_galore job submitted for ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/5782_Q_IP_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  8
File base:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5
       r1:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993574
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  9
File base:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11
       r1:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993575
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz

# --------------------------------------
Iteration:  10
File base:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6
       r1:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993576
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  11
File base:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12
       r1:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993577
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz

# --------------------------------------
Iteration:  12
File base:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1
       r1:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993578
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  13
File base:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7
       r1:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993579
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  14
File base:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2
       r1:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993580
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  15
File base:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8
       r1:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993581
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  16
File base:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3
       r1:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993582
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  17
File base:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9
       r1:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993583
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz

# --------------------------------------
Iteration:  18
File base:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4
       r1:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993584
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  19
File base:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10
       r1:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993585
trim_galore job submitted for ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz

# --------------------------------------
Iteration:  20
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993586
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz

# --------------------------------------
Iteration:  21
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993587
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz

# --------------------------------------
Iteration:  22
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993588
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz

# --------------------------------------
Iteration:  23
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993589
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz

# --------------------------------------
Iteration:  24
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993590
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz

# --------------------------------------
Iteration:  25
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993591
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz

# --------------------------------------
Iteration:  26
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993592
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz

# --------------------------------------
Iteration:  27
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993593
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz

# --------------------------------------
Iteration:  28
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993594
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz

# --------------------------------------
Iteration:  29
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993595
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz

# --------------------------------------
Iteration:  30
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993596
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz

# --------------------------------------
Iteration:  31
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993597
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz

# --------------------------------------
Iteration:  32
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993598
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz

# --------------------------------------
Iteration:  33
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993599
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz

# --------------------------------------
Iteration:  34
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993600
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  35
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993601
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  36
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993602
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  37
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993603
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  38
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993604
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  39
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993605
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  40
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993606
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  41
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993607
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  42
File base:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9
       r1:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993608
trim_galore job submitted for ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz

# --------------------------------------
Iteration:  43
File base:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993609
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz

# --------------------------------------
Iteration:  44
File base:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993610
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz

# --------------------------------------
Iteration:  45
File base:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993611
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz

# --------------------------------------
Iteration:  46
File base:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993612
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz

# --------------------------------------
Iteration:  47
File base:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993613
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz

# --------------------------------------
Iteration:  48
File base:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993614
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz

# --------------------------------------
Iteration:  49
File base:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993615
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz

# --------------------------------------
Iteration:  50
File base:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993616
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz

# --------------------------------------
Iteration:  51
File base:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993617
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz

# --------------------------------------
Iteration:  52
File base:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9
       r1:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993618
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz

# --------------------------------------
Iteration:  53
File base:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11
       r1:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993619
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz

# --------------------------------------
Iteration:  54
File base:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12
       r1:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
       r2:  ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
   outdir:  ./fastqs_no-dedup/trim_galore

Submitted batch job 7993620
trim_galore job submitted for ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz and ./fastqs_no-dedup/symlinks/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
```
</details>
<br />

<a id="run-fastqc_no-dedup-on-trim_galore-processed-fastq-files"></a>
### Run `FastQC_no-dedup` on `trim_galore`-processed `fastq` files
<a id="get-situated-2"></a>
#### Get situated
<a id="code-8"></a>
##### Code
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
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

#  Make directory if necessary
if [[ ! -d "./FastQC_no-dedup/trim_galore" ]]; then
    mkdir -p "./FastQC_no-dedup/trim_galore"
fi

#  Variables
script_name="submit_run-FastQC_no-dedup.sh"  # echo "${script_name}"
threads=4  # echo "${threads}"

#  Arrays
unset t_bases
typeset -a t_bases
while IFS=" " read -r -d $'\0'; do
    t_bases+=( "${REPLY%_R?_001_val_?.fq.gz}" )
done < <(\
    find "./fastqs_no-dedup/trim_galore" \
        -type f \
        -name "*_R?_001_val_?.fq.gz" \
        -print0 \
            | sort -z \
)
# echo_test "${t_bases[@]}"
# echo "${#t_bases[@]}"  # 100

IFS=" " read -r -a t_bases \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${t_bases[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# echo_test "${t_bases[@]}"
# echo "${#t_bases[@]}"  # 55

unset t_r1
unset t_r2
typeset -a t_r1
typeset -a t_r2
for i in "${t_bases[@]}"; do
    t_r1+=("${i}_R1_001_val_1.fq.gz")
    t_r2+=("${i}_R3_001_val_2.fq.gz")
done
# echo_test "${t_r1[@]}"
# echo_test "${t_r2[@]}"
# echo "${#t_r1[@]}"  # 55
# echo "${#t_r2[@]}"  # 55
# ., "${t_r1[18]}"
# ., "${t_r2[18]}"
```
</details>
<br />

<a id="run-submit_run-fastqc_no-dedupsh-on-trim_galore-processed-fastq-files"></a>
#### Run `submit_run-FastQC_no-dedup.sh` on `trim_galore`-processed `fastq` files
<a id="code-9"></a>
##### Code
<details>
<summary><i>Code: Run submit_run-FastQC_no-dedup.sh on trim_galore-processed fastq files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#t_bases[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "# --------------------------------------"
    echo "Iteration:  ${i}"
    echo "File base:  ${t_bases[${i}]}"
    echo "       r1:  ${t_r1[${i}]}"
    echo "       r2:  ${t_r2[${i}]}"
    echo "   outdir:  ./FastQC_no-dedup/trim_galore"
    echo ""

    #  For r1
    sbatch "./sh_err_out/${script_name}" \
        "${t_r1[${i}]}" \
        "./FastQC_no-dedup/trim_galore"
    echo "FastQC_no-dedup job submitted for ${t_r1[${i}]}"
    echo ""

    #  For r2
    sbatch "./sh_err_out/${script_name}" \
        "${t_r2[${i}]}" \
        "./FastQC_no-dedup/trim_galore"
    echo "FastQC_no-dedup job submitted for ${t_r2[${i}]}"

    echo ""
    echo ""
done
```
</details>
<br />

<a id="printed-4"></a>
##### Printed
<details>
<summary><i>Printed: Run submit_run-FastQC_no-dedup.sh on trim_galore-processed fastq files</i></summary>

```txt
# --------------------------------------
Iteration:  0
File base:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5
       r1:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998782
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R1_001_val_1.fq.gz

Submitted batch job 7998783
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  1
File base:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1
       r1:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998784
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R1_001_val_1.fq.gz

Submitted batch job 7998785
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  2
File base:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6
       r1:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998786
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R1_001_val_1.fq.gz

Submitted batch job 7998787
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  3
File base:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2
       r1:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998788
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R1_001_val_1.fq.gz

Submitted batch job 7998789
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  4
File base:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7
       r1:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998790
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R1_001_val_1.fq.gz

Submitted batch job 7998791
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  5
File base:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3
       r1:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998792
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R1_001_val_1.fq.gz

Submitted batch job 7998793
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  6
File base:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8
       r1:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998794
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R1_001_val_1.fq.gz

Submitted batch job 7998795
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  7
File base:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4
       r1:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998796
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R1_001_val_1.fq.gz

Submitted batch job 7998797
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  8
File base:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5
       r1:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998798
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R1_001_val_1.fq.gz

Submitted batch job 7998799
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  9
File base:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11
       r1:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998800
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R1_001_val_1.fq.gz

Submitted batch job 7998801
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  10
File base:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6
       r1:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998802
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R1_001_val_1.fq.gz

Submitted batch job 7998803
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  11
File base:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12
       r1:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998804
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R1_001_val_1.fq.gz

Submitted batch job 7998805
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  12
File base:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1
       r1:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998806
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R1_001_val_1.fq.gz

Submitted batch job 7998807
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  13
File base:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7
       r1:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998808
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R1_001_val_1.fq.gz

Submitted batch job 7998809
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  14
File base:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2
       r1:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998810
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R1_001_val_1.fq.gz

Submitted batch job 7998811
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  15
File base:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8
       r1:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998812
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R1_001_val_1.fq.gz

Submitted batch job 7998813
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  16
File base:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3
       r1:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998814
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R1_001_val_1.fq.gz

Submitted batch job 7998815
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  17
File base:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9
       r1:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998816
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R1_001_val_1.fq.gz

Submitted batch job 7998817
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  18
File base:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4
       r1:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998818
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R1_001_val_1.fq.gz

Submitted batch job 7998819
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  19
File base:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10
       r1:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998820
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R1_001_val_1.fq.gz

Submitted batch job 7998821
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  20
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998822
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R1_001_val_1.fq.gz

Submitted batch job 7998823
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  21
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998824
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R1_001_val_1.fq.gz

Submitted batch job 7998825
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  22
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998826
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R1_001_val_1.fq.gz

Submitted batch job 7998827
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  23
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998828
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R1_001_val_1.fq.gz

Submitted batch job 7998829
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  24
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998830
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R1_001_val_1.fq.gz

Submitted batch job 7998831
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  25
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998832
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R1_001_val_1.fq.gz

Submitted batch job 7998833
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  26
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998834
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R1_001_val_1.fq.gz

Submitted batch job 7998835
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  27
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998836
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R1_001_val_1.fq.gz

Submitted batch job 7998837
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  28
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998838
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R1_001_val_1.fq.gz

Submitted batch job 7998839
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  29
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998840
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R1_001_val_1.fq.gz

Submitted batch job 7998841
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  30
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998842
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R1_001_val_1.fq.gz

Submitted batch job 7998843
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  31
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998844
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R1_001_val_1.fq.gz

Submitted batch job 7998845
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  32
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998846
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R1_001_val_1.fq.gz

Submitted batch job 7998847
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  33
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998848
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R1_001_val_1.fq.gz

Submitted batch job 7998849
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  34
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998850
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R1_001_val_1.fq.gz

Submitted batch job 7998851
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  35
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998852
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R1_001_val_1.fq.gz

Submitted batch job 7998853
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  36
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998854
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R1_001_val_1.fq.gz

Submitted batch job 7998855
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  37
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998856
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R1_001_val_1.fq.gz

Submitted batch job 7998857
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  38
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998858
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R1_001_val_1.fq.gz

Submitted batch job 7998859
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  39
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998860
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R1_001_val_1.fq.gz

Submitted batch job 7998861
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  40
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998862
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R1_001_val_1.fq.gz

Submitted batch job 7998863
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  41
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998864
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R1_001_val_1.fq.gz

Submitted batch job 7998865
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  42
File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9
       r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998866
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R1_001_val_1.fq.gz

Submitted batch job 7998867
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  43
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998868
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz

Submitted batch job 7998869
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  44
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998870
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001_val_1.fq.gz

Submitted batch job 7998871
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  45
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998872
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001_val_1.fq.gz

Submitted batch job 7998873
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  46
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998874
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001_val_1.fq.gz

Submitted batch job 7998875
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  47
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998876
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001_val_1.fq.gz

Submitted batch job 7998877
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  48
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998878
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001_val_1.fq.gz

Submitted batch job 7998879
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  49
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998880
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001_val_1.fq.gz

Submitted batch job 7998881
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  50
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998882
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001_val_1.fq.gz

Submitted batch job 7998883
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  51
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998884
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001_val_1.fq.gz

Submitted batch job 7998885
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  52
File base:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998886
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001_val_1.fq.gz

Submitted batch job 7998887
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  53
File base:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998888
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R1_001_val_1.fq.gz

Submitted batch job 7998889
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R3_001_val_2.fq.gz

# --------------------------------------
Iteration:  54
File base:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12
       r1:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R1_001_val_1.fq.gz
       r2:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R3_001_val_2.fq.gz
   outdir:  ./FastQC_no-dedup/trim_galore

Submitted batch job 7998890
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R1_001_val_1.fq.gz

Submitted batch job 7998891
FastQC_no-dedup job submitted for ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R3_001_val_2.fq.gz
```
</details>
<br />
<br />

<a id="align-the-trimmed-compressed-fastq-files-to-a-combined-reference"></a>
## Align the trimmed, compressed `fastq` files to a combined reference
The reference genome is composed of *S. cerevisiae*, *K. lactis*, and *20S* sequences

<a id="get-situated-3"></a>
### Get situated
<a id="code-10"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

#  Get on a node, etc. if necessary
grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
    {
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

#  Directory
if [[ ! -d "./bams_no-dedup" ]]; then
    mkdir -p bams_no-dedup/{unmapped-rm,unmapped-w}/{SC_KL_20S,SC,SC_KL,KL,20S}
fi
```
</details>
<br />

<a id="write-and-run-the-script-submit_star_unmapped-rmsh"></a>
### Write and run the script `submit_star_unmapped-rm.sh`
<a id="assign-variables-and-arrays"></a>
#### Assign variables and arrays
<a id="code-11"></a>
##### Code
<details>
<summary><i>Code: Assign variables and arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN

#  Variables
script_name="submit_star_unmapped-rm.sh"  # echo "${script_name}"
threads=16  # echo "${threads}"
dir_genome="${HOME}/genomes/combined_SC_KL_20S/STAR"  # ., "${dir_genome}"

#  Arrays
unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001_val_?.fq.gz}" )
done < <(\
    find "./fastqs_no-dedup/trim_galore" \
        -type f \
        -name "*_val_?.fq.gz" \
        -print0 \
            | sort -z \
)
# echo_test "${fq_bases[@]}"
# echo "${#fq_bases[@]}"  # 110

IFS=" " read -r -a fq_bases \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fq_bases[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# echo_test "${fq_bases[@]}"
# echo "${#fq_bases[@]}"  # 55

unset fq_r1
unset fq_r2
unset fq_pre
typeset -a fq_r1
typeset -a fq_r2
typeset -a fq_pre
for i in "${fq_bases[@]}"; do
    fq_r1+=( "${i}_R1_001_val_1.fq.gz" )
    fq_r2+=( "${i}_R3_001_val_2.fq.gz" )
    fq_pre+=( "$(basename "${i}")" )
done
# echo_test "${fq_r1[@]}"
# echo_test "${fq_r2[@]}"
# echo_test "${fq_pre[@]}"
# echo "${#fq_r1[@]}"  # 55
# echo "${#fq_r2[@]}"  # 55
# echo "${#fq_pre[@]}"  # 55
#   ., "${fq_r1[37]}"
#   ., "${fq_r2[37]}"
# echo "${fq_pre[37]}"
```
</details>
<br />

<a id="use-a-heredoc-to-write-the-script-submit_star_unmapped-rmsh"></a>
#### Use a `HEREDOC` to write the script, `submit_star_unmapped-rm.sh`
<a id="code-12"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_star_unmapped-rm.sh</i></summary>

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

read_1="\${1}"
read_2="\${2}"
prefix="\${3}"
dir_genome="\${4}"
multimappers="\${5}"

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
    --outFilterMultimapNmax "\${multimappers}" \\ \n\
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
    --outFilterMultimapNmax "\${multimappers}" \\
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

<a id="run-submit_star_unmapped-rmsh-on-fqgz-files"></a>
#### Run `submit_star_unmapped-rm.sh` on `fq.gz` files
*For a given read pair, allow up to 10 multimappers*

<a id="code-13"></a>
##### Code
<details>
<summary><i>Code: Run submit_star_unmapped-rm.sh on fq.gz files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#fq_bases[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "# --------------------------------------"
    echo "   Iteration:  ${i}"
    echo "   File base:  ${fq_bases[${i}]}"
    echo "          r1:  ${fq_r1[${i}]}"
    echo "          r2:  ${fq_r2[${i}]}"
    echo "      prefix:  ${fq_pre[${i}]}"
    echo "      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S"
    echo "      genome:  ${dir_genome}"
    echo "multimappers:  10"
    echo ""

    sbatch "./sh_err_out/${script_name}" \
        "${fq_r1[${i}]}" \
        "${fq_r2[${i}]}" \
        "./bams_no-dedup/unmapped-rm/SC_KL_20S/${fq_pre[${i}]}." \
        "${dir_genome}" \
        10
    
    sleep 1  # Slow down rate of job submission

    echo ""
    echo ""
done
```
</details>
<br />

<a id="printed-5"></a>
##### Printed
<details>
<summary><i>Printed: Run submit_star_unmapped-rm.sh on fq.gz files</i></summary>

```txt
# --------------------------------------
   Iteration:  0
   File base:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5
          r1:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R3_001_val_2.fq.gz
      prefix:  5781_G1_IN_S5
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998902

# --------------------------------------
   Iteration:  1
   File base:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1
          r1:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R3_001_val_2.fq.gz
      prefix:  5781_G1_IP_S1
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998903

# --------------------------------------
   Iteration:  2
   File base:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6
          r1:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R3_001_val_2.fq.gz
      prefix:  5781_Q_IN_S6
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998904

# --------------------------------------
   Iteration:  3
   File base:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2
          r1:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R3_001_val_2.fq.gz
      prefix:  5781_Q_IP_S2
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998905

# --------------------------------------
   Iteration:  4
   File base:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7
          r1:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R3_001_val_2.fq.gz
      prefix:  5782_G1_IN_S7
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998906

# --------------------------------------
   Iteration:  5
   File base:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3
          r1:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R3_001_val_2.fq.gz
      prefix:  5782_G1_IP_S3
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998907

# --------------------------------------
   Iteration:  6
   File base:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8
          r1:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R3_001_val_2.fq.gz
      prefix:  5782_Q_IN_S8
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998908

# --------------------------------------
   Iteration:  7
   File base:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4
          r1:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R3_001_val_2.fq.gz
      prefix:  5782_Q_IP_S4
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998909

# --------------------------------------
   Iteration:  8
   File base:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5
          r1:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R3_001_val_2.fq.gz
      prefix:  CW10_7747_8day_Q_IN_S5
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998910

# --------------------------------------
   Iteration:  9
   File base:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11
          r1:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R3_001_val_2.fq.gz
      prefix:  CW10_7747_8day_Q_PD_S11
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998911

# --------------------------------------
   Iteration:  10
   File base:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6
          r1:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R3_001_val_2.fq.gz
      prefix:  CW12_7748_8day_Q_IN_S6
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998912

# --------------------------------------
   Iteration:  11
   File base:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12
          r1:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R3_001_val_2.fq.gz
      prefix:  CW12_7748_8day_Q_PD_S12
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998913

# --------------------------------------
   Iteration:  12
   File base:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1
          r1:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R3_001_val_2.fq.gz
      prefix:  CW2_5781_8day_Q_IN_S1
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998914

# --------------------------------------
   Iteration:  13
   File base:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7
          r1:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R3_001_val_2.fq.gz
      prefix:  CW2_5781_8day_Q_PD_S7
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998915

# --------------------------------------
   Iteration:  14
   File base:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2
          r1:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R3_001_val_2.fq.gz
      prefix:  CW4_5782_8day_Q_IN_S2
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998916

# --------------------------------------
   Iteration:  15
   File base:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8
          r1:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R3_001_val_2.fq.gz
      prefix:  CW4_5782_8day_Q_PD_S8
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998917

# --------------------------------------
   Iteration:  16
   File base:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3
          r1:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R3_001_val_2.fq.gz
      prefix:  CW6_7078_8day_Q_IN_S3
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998918

# --------------------------------------
   Iteration:  17
   File base:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9
          r1:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R3_001_val_2.fq.gz
      prefix:  CW6_7078_8day_Q_PD_S9
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998919

# --------------------------------------
   Iteration:  18
   File base:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4
          r1:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R3_001_val_2.fq.gz
      prefix:  CW8_7079_8day_Q_IN_S4
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998920

# --------------------------------------
   Iteration:  19
   File base:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10
          r1:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R3_001_val_2.fq.gz
      prefix:  CW8_7079_8day_Q_PD_S10
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998921

# --------------------------------------
   Iteration:  20
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM10_DSp48_5781_S22
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998922

# --------------------------------------
   Iteration:  21
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM11_DSp48_7080_S23
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998923

# --------------------------------------
   Iteration:  22
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM1_DSm2_5781_S13
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998924

# --------------------------------------
   Iteration:  23
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM2_DSm2_7080_S14
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998925

# --------------------------------------
   Iteration:  24
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM3_DSm2_7079_S15
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998926

# --------------------------------------
   Iteration:  25
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM4_DSp2_5781_S16
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998927

# --------------------------------------
   Iteration:  26
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM5_DSp2_7080_S17
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998928

# --------------------------------------
   Iteration:  27
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM6_DSp2_7079_S18
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998929

# --------------------------------------
   Iteration:  28
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM7_DSp24_5781_S19
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998930

# --------------------------------------
   Iteration:  29
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM8_DSp24_7080_S20
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998931

# --------------------------------------
   Iteration:  30
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM9_DSp24_7079_S21
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998932

# --------------------------------------
   Iteration:  31
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp10_DSp48_5782_S10
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998933

# --------------------------------------
   Iteration:  32
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp11_DSp48_7081_S11
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998934

# --------------------------------------
   Iteration:  33
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp12_DSp48_7078_S12
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998935

# --------------------------------------
   Iteration:  34
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp1_DSm2_5782_S1
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998936

# --------------------------------------
   Iteration:  35
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp2_DSm2_7081_S2
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998937

# --------------------------------------
   Iteration:  36
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp3_DSm2_7078_S3
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998938

# --------------------------------------
   Iteration:  37
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp4_DSp2_5782_S4
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998939

# --------------------------------------
   Iteration:  38
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp5_DSp2_7081_S5
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998940

# --------------------------------------
   Iteration:  39
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp6_DSp2_7078_S6
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998941

# --------------------------------------
   Iteration:  40
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp7_DSp24_5782_S7
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998942

# --------------------------------------
   Iteration:  41
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp8_DSp24_7081_S8
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998943

# --------------------------------------
   Iteration:  42
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp9_DSp24_7078_S9
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998944

# --------------------------------------
   Iteration:  43
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz
      prefix:  Sample_CT10_7718_pIAA_Q_Nascent_S5
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998945

# --------------------------------------
   Iteration:  44
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001_val_2.fq.gz
      prefix:  Sample_CT10_7718_pIAA_Q_SteadyState_S10
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998946

# --------------------------------------
   Iteration:  45
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001_val_2.fq.gz
      prefix:  Sample_CT2_6125_pIAA_Q_Nascent_S1
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998947

# --------------------------------------
   Iteration:  46
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001_val_2.fq.gz
      prefix:  Sample_CT2_6125_pIAA_Q_SteadyState_S6
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998948

# --------------------------------------
   Iteration:  47
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001_val_2.fq.gz
      prefix:  Sample_CT4_6126_pIAA_Q_Nascent_S2
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998949

# --------------------------------------
   Iteration:  48
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001_val_2.fq.gz
      prefix:  Sample_CT4_6126_pIAA_Q_SteadyState_S7
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998950

# --------------------------------------
   Iteration:  49
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001_val_2.fq.gz
      prefix:  Sample_CT6_7714_pIAA_Q_Nascent_S3
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998951

# --------------------------------------
   Iteration:  50
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001_val_2.fq.gz
      prefix:  Sample_CT6_7714_pIAA_Q_SteadyState_S8
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998952

# --------------------------------------
   Iteration:  51
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001_val_2.fq.gz
      prefix:  Sample_CT8_7716_pIAA_Q_Nascent_S4
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998953

# --------------------------------------
   Iteration:  52
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001_val_2.fq.gz
      prefix:  Sample_CT8_7716_pIAA_Q_SteadyState_S9
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998954

# --------------------------------------
   Iteration:  53
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R3_001_val_2.fq.gz
      prefix:  Sample_CU11_5782_Q_Nascent_S11
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998955

# --------------------------------------
   Iteration:  54
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R3_001_val_2.fq.gz
      prefix:  Sample_CU12_5782_Q_SteadyState_S12
      outdir:  ./bams_no-dedup/unmapped-rm/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 7998956
```
</details>
<br />

<a id="write-and-run-the-script-submit_star_unmapped-wsh"></a>
### Write and run the script `submit_star_unmapped-w.sh`
<a id="assign-variables-and-arrays-1"></a>
#### Assign variables and arrays
<a id="code-14"></a>
##### Code
<details>
<summary><i>Code: Assign variables and arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN

#  Variables
script_name="submit_star_unmapped-w.sh"  # echo "${script_name}"
threads=16  # echo "${threads}"
dir_genome="${HOME}/genomes/combined_SC_KL_20S/STAR"  # ., "${dir_genome}"

#  Arrays
unset fq_bases
typeset -a fq_bases
while IFS=" " read -r -d $'\0'; do
    fq_bases+=( "${REPLY%_R?_001_val_?.fq.gz}" )
done < <(\
    find "./fastqs_no-dedup/trim_galore" \
        -type f \
        -name "*_val_?.fq.gz" \
        -print0 \
            | sort -z \
)
# echo_test "${fq_bases[@]}"
# echo "${#fq_bases[@]}"  # 110

IFS=" " read -r -a fq_bases \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${fq_bases[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# echo_test "${fq_bases[@]}"
# echo "${#fq_bases[@]}"  # 55

unset fq_r1
unset fq_r2
unset fq_pre
typeset -a fq_r1
typeset -a fq_r2
typeset -a fq_pre
for i in "${fq_bases[@]}"; do
    fq_r1+=( "${i}_R1_001_val_1.fq.gz" )
    fq_r2+=( "${i}_R3_001_val_2.fq.gz" )
    fq_pre+=( "$(basename "${i}")" )
done
# echo_test "${fq_r1[@]}"
# echo_test "${fq_r2[@]}"
# echo_test "${fq_pre[@]}"
# echo "${#fq_r1[@]}"  # 55
# echo "${#fq_r2[@]}"  # 55
# echo "${#fq_pre[@]}"  # 55
#   ., "${fq_r1[37]}"
#   ., "${fq_r2[37]}"
# echo "${fq_pre[37]}"
```
</details>
<br />

<a id="use-a-heredoc-to-write-the-script-submit_star_unmapped-wsh"></a>
#### Use a `HEREDOC` to write the script, `submit_star_unmapped-w.sh`
<a id="code-15"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_star_unmapped-w.sh</i></summary>

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

read_1="\${1}"
read_2="\${2}"
prefix="\${3}"
dir_genome="\${4}"
multimappers="\${5}"

echo -e "STAR \\ \n\
    --runMode alignReads \\ \n\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --outSAMtype BAM SortedByCoordinate \\ \n\
    --outSAMunmapped Within \\ \n\
    --outSAMattributes All \\ \n\
    --genomeDir "\${dir_genome}" \\ \n\
    --readFilesIn "\${read_1}" "\${read_2}" \\ \n\
    --readFilesCommand zcat \\ \n\
    --outFileNamePrefix "\${prefix}" \\ \n\
    --limitBAMsortRAM 4000000000 \\ \n\
    --outFilterMultimapNmax "\${multimappers}" \\ \n\
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
    --outSAMunmapped Within \\
    --outSAMattributes All \\
    --genomeDir "\${dir_genome}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --readFilesCommand zcat \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax "\${multimappers}" \\
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

<a id="run-submit_star_unmapped-wsh-on-fqgz-files"></a>
#### Run `submit_star_unmapped-w.sh` on `fq.gz` files
*For a given read pair, allow up to 10 multimappers*

<a id="code-16"></a>
##### Code
<details>
<summary><i>Code: Run submit_star_unmapped-w.sh on fq.gz files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#fq_bases[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "# --------------------------------------"
    echo "   Iteration:  ${i}"
    echo "   File base:  ${fq_bases[${i}]}"
    echo "          r1:  ${fq_r1[${i}]}"
    echo "          r2:  ${fq_r2[${i}]}"
    echo "      prefix:  ${fq_pre[${i}]}"
    echo "      outdir:  ./bams/unmapped-w/SC_KL_20S"
    echo "      genome:  ${dir_genome}"
    echo "multimappers:  10"
    echo ""

    sbatch "./sh_err_out/${script_name}" \
        "${fq_r1[${i}]}" \
        "${fq_r2[${i}]}" \
        "./bams/unmapped-w/SC_KL_20S/${fq_pre[${i}]}." \
        "${dir_genome}" \
        10
    
    sleep 1  # Slow down rate of job submission

    echo ""
    echo ""
done
```
</details>
<br />

<a id="printed-6"></a>
##### Printed
<details>
<summary><i>Printed: Run submit_star_unmapped-w.sh on fq.gz files</i></summary>

```txt
# --------------------------------------
   Iteration:  0
   File base:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5
          r1:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_G1_IN_S5_R3_001_val_2.fq.gz
      prefix:  5781_G1_IN_S5
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054458


# --------------------------------------
   Iteration:  1
   File base:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1
          r1:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_G1_IP_S1_R3_001_val_2.fq.gz
      prefix:  5781_G1_IP_S1
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054459


# --------------------------------------
   Iteration:  2
   File base:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6
          r1:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_Q_IN_S6_R3_001_val_2.fq.gz
      prefix:  5781_Q_IN_S6
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054460


# --------------------------------------
   Iteration:  3
   File base:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2
          r1:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5781_Q_IP_S2_R3_001_val_2.fq.gz
      prefix:  5781_Q_IP_S2
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054461


# --------------------------------------
   Iteration:  4
   File base:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7
          r1:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_G1_IN_S7_R3_001_val_2.fq.gz
      prefix:  5782_G1_IN_S7
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054462


# --------------------------------------
   Iteration:  5
   File base:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3
          r1:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_G1_IP_S3_R3_001_val_2.fq.gz
      prefix:  5782_G1_IP_S3
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054463


# --------------------------------------
   Iteration:  6
   File base:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8
          r1:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_Q_IN_S8_R3_001_val_2.fq.gz
      prefix:  5782_Q_IN_S8
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054464


# --------------------------------------
   Iteration:  7
   File base:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4
          r1:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/5782_Q_IP_S4_R3_001_val_2.fq.gz
      prefix:  5782_Q_IP_S4
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054465


# --------------------------------------
   Iteration:  8
   File base:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5
          r1:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_IN_S5_R3_001_val_2.fq.gz
      prefix:  CW10_7747_8day_Q_IN_S5
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054466


# --------------------------------------
   Iteration:  9
   File base:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11
          r1:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW10_7747_8day_Q_PD_S11_R3_001_val_2.fq.gz
      prefix:  CW10_7747_8day_Q_PD_S11
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054467


# --------------------------------------
   Iteration:  10
   File base:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6
          r1:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_IN_S6_R3_001_val_2.fq.gz
      prefix:  CW12_7748_8day_Q_IN_S6
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054468


# --------------------------------------
   Iteration:  11
   File base:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12
          r1:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW12_7748_8day_Q_PD_S12_R3_001_val_2.fq.gz
      prefix:  CW12_7748_8day_Q_PD_S12
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054469


# --------------------------------------
   Iteration:  12
   File base:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1
          r1:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_IN_S1_R3_001_val_2.fq.gz
      prefix:  CW2_5781_8day_Q_IN_S1
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054470


# --------------------------------------
   Iteration:  13
   File base:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7
          r1:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW2_5781_8day_Q_PD_S7_R3_001_val_2.fq.gz
      prefix:  CW2_5781_8day_Q_PD_S7
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054471


# --------------------------------------
   Iteration:  14
   File base:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2
          r1:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_IN_S2_R3_001_val_2.fq.gz
      prefix:  CW4_5782_8day_Q_IN_S2
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054472


# --------------------------------------
   Iteration:  15
   File base:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8
          r1:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW4_5782_8day_Q_PD_S8_R3_001_val_2.fq.gz
      prefix:  CW4_5782_8day_Q_PD_S8
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054473


# --------------------------------------
   Iteration:  16
   File base:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3
          r1:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_IN_S3_R3_001_val_2.fq.gz
      prefix:  CW6_7078_8day_Q_IN_S3
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054474


# --------------------------------------
   Iteration:  17
   File base:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9
          r1:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW6_7078_8day_Q_PD_S9_R3_001_val_2.fq.gz
      prefix:  CW6_7078_8day_Q_PD_S9
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054475


# --------------------------------------
   Iteration:  18
   File base:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4
          r1:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_IN_S4_R3_001_val_2.fq.gz
      prefix:  CW8_7079_8day_Q_IN_S4
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054476


# --------------------------------------
   Iteration:  19
   File base:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10
          r1:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/CW8_7079_8day_Q_PD_S10_R3_001_val_2.fq.gz
      prefix:  CW8_7079_8day_Q_PD_S10
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054477


# --------------------------------------
   Iteration:  20
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM10_DSp48_5781_S22_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM10_DSp48_5781_S22
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054478


# --------------------------------------
   Iteration:  21
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM11_DSp48_7080_S23_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM11_DSp48_7080_S23
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054479


# --------------------------------------
   Iteration:  22
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM1_DSm2_5781_S13_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM1_DSm2_5781_S13
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054480


# --------------------------------------
   Iteration:  23
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM2_DSm2_7080_S14_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM2_DSm2_7080_S14
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054481


# --------------------------------------
   Iteration:  24
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM3_DSm2_7079_S15_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM3_DSm2_7079_S15
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054482


# --------------------------------------
   Iteration:  25
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM4_DSp2_5781_S16_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM4_DSp2_5781_S16
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054483


# --------------------------------------
   Iteration:  26
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM5_DSp2_7080_S17_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM5_DSp2_7080_S17
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054484


# --------------------------------------
   Iteration:  27
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM6_DSp2_7079_S18_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM6_DSp2_7079_S18
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054485


# --------------------------------------
   Iteration:  28
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM7_DSp24_5781_S19_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM7_DSp24_5781_S19
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054486


# --------------------------------------
   Iteration:  29
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM8_DSp24_7080_S20_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM8_DSp24_7080_S20
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054487


# --------------------------------------
   Iteration:  30
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_BM9_DSp24_7079_S21_R3_001_val_2.fq.gz
      prefix:  SAMPLE_BM9_DSp24_7079_S21
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054488


# --------------------------------------
   Iteration:  31
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp10_DSp48_5782_S10_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp10_DSp48_5782_S10
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054489


# --------------------------------------
   Iteration:  32
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp11_DSp48_7081_S11_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp11_DSp48_7081_S11
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054490


# --------------------------------------
   Iteration:  33
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp12_DSp48_7078_S12_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp12_DSp48_7078_S12
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054491


# --------------------------------------
   Iteration:  34
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp1_DSm2_5782_S1_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp1_DSm2_5782_S1
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054492


# --------------------------------------
   Iteration:  35
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp2_DSm2_7081_S2_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp2_DSm2_7081_S2
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054493


# --------------------------------------
   Iteration:  36
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp3_DSm2_7078_S3_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp3_DSm2_7078_S3
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054494


# --------------------------------------
   Iteration:  37
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp4_DSp2_5782_S4_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp4_DSp2_5782_S4
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054495


# --------------------------------------
   Iteration:  38
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp5_DSp2_7081_S5_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp5_DSp2_7081_S5
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054496


# --------------------------------------
   Iteration:  39
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp6_DSp2_7078_S6_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp6_DSp2_7078_S6
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054497


# --------------------------------------
   Iteration:  40
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp7_DSp24_5782_S7_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp7_DSp24_5782_S7
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054498


# --------------------------------------
   Iteration:  41
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp8_DSp24_7081_S8_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp8_DSp24_7081_S8
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054499


# --------------------------------------
   Iteration:  42
   File base:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9
          r1:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/SAMPLE_Bp9_DSp24_7078_S9_R3_001_val_2.fq.gz
      prefix:  SAMPLE_Bp9_DSp24_7078_S9
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054500


# --------------------------------------
   Iteration:  43
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz
      prefix:  Sample_CT10_7718_pIAA_Q_Nascent_S5
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054501


# --------------------------------------
   Iteration:  44
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001_val_2.fq.gz
      prefix:  Sample_CT10_7718_pIAA_Q_SteadyState_S10
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054502


# --------------------------------------
   Iteration:  45
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001_val_2.fq.gz
      prefix:  Sample_CT2_6125_pIAA_Q_Nascent_S1
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054503


# --------------------------------------
   Iteration:  46
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001_val_2.fq.gz
      prefix:  Sample_CT2_6125_pIAA_Q_SteadyState_S6
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054504


# --------------------------------------
   Iteration:  47
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001_val_2.fq.gz
      prefix:  Sample_CT4_6126_pIAA_Q_Nascent_S2
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054505


# --------------------------------------
   Iteration:  48
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001_val_2.fq.gz
      prefix:  Sample_CT4_6126_pIAA_Q_SteadyState_S7
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054506


# --------------------------------------
   Iteration:  49
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001_val_2.fq.gz
      prefix:  Sample_CT6_7714_pIAA_Q_Nascent_S3
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054507


# --------------------------------------
   Iteration:  50
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001_val_2.fq.gz
      prefix:  Sample_CT6_7714_pIAA_Q_SteadyState_S8
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054508


# --------------------------------------
   Iteration:  51
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001_val_2.fq.gz
      prefix:  Sample_CT8_7716_pIAA_Q_Nascent_S4
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054510


# --------------------------------------
   Iteration:  52
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001_val_2.fq.gz
      prefix:  Sample_CT8_7716_pIAA_Q_SteadyState_S9
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054511


# --------------------------------------
   Iteration:  53
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CU11_5782_Q_Nascent_S11_R3_001_val_2.fq.gz
      prefix:  Sample_CU11_5782_Q_Nascent_S11
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054512


# --------------------------------------
   Iteration:  54
   File base:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12
          r1:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R1_001_val_1.fq.gz
          r2:  ./fastqs_no-dedup/trim_galore/Sample_CU12_5782_Q_SteadyState_S12_R3_001_val_2.fq.gz
      prefix:  Sample_CU12_5782_Q_SteadyState_S12
      outdir:  ./bams/unmapped-w/SC_KL_20S
      genome:  /home/kalavatt/genomes/combined_SC_KL_20S/STAR
multimappers:  10

Submitted batch job 8054513
```
</details>
<br />

<a id="clean-up-results-from-star-alignment-then-index-bams"></a>
### Clean up results from `STAR` alignment, then index `bam`s
<a id="clean-uprename-results-of-star-alignment"></a>
#### Clean up/rename results of `STAR` alignment
<a id="notes"></a>
##### Notes
<details>
<summary><i>Notes: Clean up/rename results of `STAR` alignment</i></summary>

Moving forward, perform the following steps:
1. `rm -r *._STARtmp`
2. `rename 's/.Log./.multi-10.Log./g' *`
3. `rename 's/.SJ.out.tab/.multi-10.SJ.tab/g' *`
4. `rename 's/.Aligned.sortedByCoord././g' *`
5. `rename 's/.out.bam/.multi-10.bam/g' *`
</details>
<br />

<a id="in-bamsunmapped-rmsc_kl_20s"></a>
##### In `bams/unmapped-rm/SC_KL_20S`...
<a id="code-17"></a>
###### Code
<details>
<summary><i>Code: In bams/unmapped-rm/SC_KL_20S...</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd bams/unmapped-rm/SC_KL_20S \
    || echo "cd'ing failed; check on this..."

#  Working things out...
rm -r *._STARtmp

rename -n 's/.Log./.multi-10.Log./g' *
rename 's/.Log./.multi-10.Log./g' *

rename -n 's/.SJ.out.tab/.multi-10.SJ.tab/g' *
rename 's/.SJ.out.tab/.multi-10.SJ.tab/g' *

rename -n 's/.Aligned.sortedByCoord././g' *
rename 's/.Aligned.sortedByCoord././g' *

rename -n 's/.out.bam/.multi-10.bam/g' *
rename 's/.out.bam/.multi-10.bam/g' *
```
</details>
<br />

<a id="printed-7"></a>
###### Printed
<details>
<summary><i>Printed: In bams/unmapped-rm/SC_KL_20S...</i></summary>

```txt
❯ rename -n 's/.Log./.multi-10.Log./g' *
'5781_G1_IN_S5.Log.final.out' would be renamed to '5781_G1_IN_S5.multi-10.Log.final.out'
'5781_G1_IN_S5.Log.out' would be renamed to '5781_G1_IN_S5.multi-10.Log.out'
'5781_G1_IN_S5.Log.progress.out' would be renamed to '5781_G1_IN_S5.multi-10.Log.progress.out'
'5781_G1_IP_S1.Log.final.out' would be renamed to '5781_G1_IP_S1.multi-10.Log.final.out'
'5781_G1_IP_S1.Log.out' would be renamed to '5781_G1_IP_S1.multi-10.Log.out'
'5781_G1_IP_S1.Log.progress.out' would be renamed to '5781_G1_IP_S1.multi-10.Log.progress.out'
'5781_Q_IN_S6.Log.final.out' would be renamed to '5781_Q_IN_S6.multi-10.Log.final.out'
'5781_Q_IN_S6.Log.out' would be renamed to '5781_Q_IN_S6.multi-10.Log.out'
'5781_Q_IN_S6.Log.progress.out' would be renamed to '5781_Q_IN_S6.multi-10.Log.progress.out'
'5781_Q_IP_S2.Log.final.out' would be renamed to '5781_Q_IP_S2.multi-10.Log.final.out'
'5781_Q_IP_S2.Log.out' would be renamed to '5781_Q_IP_S2.multi-10.Log.out'
'5781_Q_IP_S2.Log.progress.out' would be renamed to '5781_Q_IP_S2.multi-10.Log.progress.out'
'5782_G1_IN_S7.Log.final.out' would be renamed to '5782_G1_IN_S7.multi-10.Log.final.out'
'5782_G1_IN_S7.Log.out' would be renamed to '5782_G1_IN_S7.multi-10.Log.out'
'5782_G1_IN_S7.Log.progress.out' would be renamed to '5782_G1_IN_S7.multi-10.Log.progress.out'
'5782_G1_IP_S3.Log.final.out' would be renamed to '5782_G1_IP_S3.multi-10.Log.final.out'
'5782_G1_IP_S3.Log.out' would be renamed to '5782_G1_IP_S3.multi-10.Log.out'
'5782_G1_IP_S3.Log.progress.out' would be renamed to '5782_G1_IP_S3.multi-10.Log.progress.out'
'5782_Q_IN_S8.Log.final.out' would be renamed to '5782_Q_IN_S8.multi-10.Log.final.out'
'5782_Q_IN_S8.Log.out' would be renamed to '5782_Q_IN_S8.multi-10.Log.out'
'5782_Q_IN_S8.Log.progress.out' would be renamed to '5782_Q_IN_S8.multi-10.Log.progress.out'
'5782_Q_IP_S4.Log.final.out' would be renamed to '5782_Q_IP_S4.multi-10.Log.final.out'
'5782_Q_IP_S4.Log.out' would be renamed to '5782_Q_IP_S4.multi-10.Log.out'
'5782_Q_IP_S4.Log.progress.out' would be renamed to '5782_Q_IP_S4.multi-10.Log.progress.out'
'CW10_7747_8day_Q_IN_S5.Log.final.out' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.Log.final.out'
'CW10_7747_8day_Q_IN_S5.Log.out' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.Log.out'
'CW10_7747_8day_Q_IN_S5.Log.progress.out' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.Log.progress.out'
'CW10_7747_8day_Q_PD_S11.Log.final.out' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.Log.final.out'
'CW10_7747_8day_Q_PD_S11.Log.out' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.Log.out'
'CW10_7747_8day_Q_PD_S11.Log.progress.out' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.Log.progress.out'
'CW12_7748_8day_Q_IN_S6.Log.final.out' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.Log.final.out'
'CW12_7748_8day_Q_IN_S6.Log.out' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.Log.out'
'CW12_7748_8day_Q_IN_S6.Log.progress.out' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.Log.progress.out'
'CW12_7748_8day_Q_PD_S12.Log.final.out' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.Log.final.out'
'CW12_7748_8day_Q_PD_S12.Log.out' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.Log.out'
'CW12_7748_8day_Q_PD_S12.Log.progress.out' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.Log.progress.out'
'CW2_5781_8day_Q_IN_S1.Log.final.out' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.Log.final.out'
'CW2_5781_8day_Q_IN_S1.Log.out' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.Log.out'
'CW2_5781_8day_Q_IN_S1.Log.progress.out' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.Log.progress.out'
'CW2_5781_8day_Q_PD_S7.Log.final.out' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.Log.final.out'
'CW2_5781_8day_Q_PD_S7.Log.out' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.Log.out'
'CW2_5781_8day_Q_PD_S7.Log.progress.out' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.Log.progress.out'
'CW4_5782_8day_Q_IN_S2.Log.final.out' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.Log.final.out'
'CW4_5782_8day_Q_IN_S2.Log.out' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.Log.out'
'CW4_5782_8day_Q_IN_S2.Log.progress.out' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.Log.progress.out'
'CW4_5782_8day_Q_PD_S8.Log.final.out' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.Log.final.out'
'CW4_5782_8day_Q_PD_S8.Log.out' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.Log.out'
'CW4_5782_8day_Q_PD_S8.Log.progress.out' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.Log.progress.out'
'CW6_7078_8day_Q_IN_S3.Log.final.out' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.Log.final.out'
'CW6_7078_8day_Q_IN_S3.Log.out' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.Log.out'
'CW6_7078_8day_Q_IN_S3.Log.progress.out' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.Log.progress.out'
'CW6_7078_8day_Q_PD_S9.Log.final.out' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.Log.final.out'
'CW6_7078_8day_Q_PD_S9.Log.out' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.Log.out'
'CW6_7078_8day_Q_PD_S9.Log.progress.out' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.Log.progress.out'
'CW8_7079_8day_Q_IN_S4.Log.final.out' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.Log.final.out'
'CW8_7079_8day_Q_IN_S4.Log.out' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.Log.out'
'CW8_7079_8day_Q_IN_S4.Log.progress.out' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.Log.progress.out'
'CW8_7079_8day_Q_PD_S10.Log.final.out' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.Log.final.out'
'CW8_7079_8day_Q_PD_S10.Log.out' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.Log.out'
'CW8_7079_8day_Q_PD_S10.Log.progress.out' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.Log.progress.out'
'SAMPLE_BM10_DSp48_5781_S22.Log.final.out' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.final.out'
'SAMPLE_BM10_DSp48_5781_S22.Log.out' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.out'
'SAMPLE_BM10_DSp48_5781_S22.Log.progress.out' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.progress.out'
'SAMPLE_BM11_DSp48_7080_S23.Log.final.out' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.final.out'
'SAMPLE_BM11_DSp48_7080_S23.Log.out' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.out'
'SAMPLE_BM11_DSp48_7080_S23.Log.progress.out' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.progress.out'
'SAMPLE_BM1_DSm2_5781_S13.Log.final.out' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.final.out'
'SAMPLE_BM1_DSm2_5781_S13.Log.out' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.out'
'SAMPLE_BM1_DSm2_5781_S13.Log.progress.out' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.progress.out'
'SAMPLE_BM2_DSm2_7080_S14.Log.final.out' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.final.out'
'SAMPLE_BM2_DSm2_7080_S14.Log.out' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.out'
'SAMPLE_BM2_DSm2_7080_S14.Log.progress.out' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.progress.out'
'SAMPLE_BM3_DSm2_7079_S15.Log.final.out' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.final.out'
'SAMPLE_BM3_DSm2_7079_S15.Log.out' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.out'
'SAMPLE_BM3_DSm2_7079_S15.Log.progress.out' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.progress.out'
'SAMPLE_BM4_DSp2_5781_S16.Log.final.out' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.final.out'
'SAMPLE_BM4_DSp2_5781_S16.Log.out' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.out'
'SAMPLE_BM4_DSp2_5781_S16.Log.progress.out' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.progress.out'
'SAMPLE_BM5_DSp2_7080_S17.Log.final.out' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.final.out'
'SAMPLE_BM5_DSp2_7080_S17.Log.out' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.out'
'SAMPLE_BM5_DSp2_7080_S17.Log.progress.out' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.progress.out'
'SAMPLE_BM6_DSp2_7079_S18.Log.final.out' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.final.out'
'SAMPLE_BM6_DSp2_7079_S18.Log.out' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.out'
'SAMPLE_BM6_DSp2_7079_S18.Log.progress.out' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.progress.out'
'SAMPLE_BM7_DSp24_5781_S19.Log.final.out' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.final.out'
'SAMPLE_BM7_DSp24_5781_S19.Log.out' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.out'
'SAMPLE_BM7_DSp24_5781_S19.Log.progress.out' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.progress.out'
'SAMPLE_BM8_DSp24_7080_S20.Log.final.out' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.final.out'
'SAMPLE_BM8_DSp24_7080_S20.Log.out' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.out'
'SAMPLE_BM8_DSp24_7080_S20.Log.progress.out' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.progress.out'
'SAMPLE_BM9_DSp24_7079_S21.Log.final.out' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.final.out'
'SAMPLE_BM9_DSp24_7079_S21.Log.out' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.out'
'SAMPLE_BM9_DSp24_7079_S21.Log.progress.out' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.progress.out'
'SAMPLE_Bp10_DSp48_5782_S10.Log.final.out' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.final.out'
'SAMPLE_Bp10_DSp48_5782_S10.Log.out' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.out'
'SAMPLE_Bp10_DSp48_5782_S10.Log.progress.out' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.progress.out'
'SAMPLE_Bp11_DSp48_7081_S11.Log.final.out' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.final.out'
'SAMPLE_Bp11_DSp48_7081_S11.Log.out' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.out'
'SAMPLE_Bp11_DSp48_7081_S11.Log.progress.out' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.progress.out'
'SAMPLE_Bp12_DSp48_7078_S12.Log.final.out' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.final.out'
'SAMPLE_Bp12_DSp48_7078_S12.Log.out' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.out'
'SAMPLE_Bp12_DSp48_7078_S12.Log.progress.out' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.progress.out'
'SAMPLE_Bp1_DSm2_5782_S1.Log.final.out' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.final.out'
'SAMPLE_Bp1_DSm2_5782_S1.Log.out' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.out'
'SAMPLE_Bp1_DSm2_5782_S1.Log.progress.out' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.progress.out'
'SAMPLE_Bp2_DSm2_7081_S2.Log.final.out' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.final.out'
'SAMPLE_Bp2_DSm2_7081_S2.Log.out' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.out'
'SAMPLE_Bp2_DSm2_7081_S2.Log.progress.out' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.progress.out'
'SAMPLE_Bp3_DSm2_7078_S3.Log.final.out' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.final.out'
'SAMPLE_Bp3_DSm2_7078_S3.Log.out' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.out'
'SAMPLE_Bp3_DSm2_7078_S3.Log.progress.out' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.progress.out'
'SAMPLE_Bp4_DSp2_5782_S4.Log.final.out' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.final.out'
'SAMPLE_Bp4_DSp2_5782_S4.Log.out' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.out'
'SAMPLE_Bp4_DSp2_5782_S4.Log.progress.out' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.progress.out'
'SAMPLE_Bp5_DSp2_7081_S5.Log.final.out' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.final.out'
'SAMPLE_Bp5_DSp2_7081_S5.Log.out' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.out'
'SAMPLE_Bp5_DSp2_7081_S5.Log.progress.out' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.progress.out'
'SAMPLE_Bp6_DSp2_7078_S6.Log.final.out' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.final.out'
'SAMPLE_Bp6_DSp2_7078_S6.Log.out' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.out'
'SAMPLE_Bp6_DSp2_7078_S6.Log.progress.out' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.progress.out'
'SAMPLE_Bp7_DSp24_5782_S7.Log.final.out' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.final.out'
'SAMPLE_Bp7_DSp24_5782_S7.Log.out' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.out'
'SAMPLE_Bp7_DSp24_5782_S7.Log.progress.out' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.progress.out'
'SAMPLE_Bp8_DSp24_7081_S8.Log.final.out' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.final.out'
'SAMPLE_Bp8_DSp24_7081_S8.Log.out' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.out'
'SAMPLE_Bp8_DSp24_7081_S8.Log.progress.out' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.progress.out'
'SAMPLE_Bp9_DSp24_7078_S9.Log.final.out' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.final.out'
'SAMPLE_Bp9_DSp24_7078_S9.Log.out' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.out'
'SAMPLE_Bp9_DSp24_7078_S9.Log.progress.out' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.progress.out'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Log.final.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.final.out'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Log.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.out'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Log.progress.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.progress.out'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Log.final.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.final.out'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Log.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.out'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Log.progress.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.progress.out'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Log.final.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.final.out'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Log.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.out'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Log.progress.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.progress.out'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Log.final.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.final.out'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Log.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.out'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Log.progress.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.progress.out'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Log.final.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.final.out'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Log.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.out'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Log.progress.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.progress.out'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Log.final.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.final.out'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Log.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.out'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Log.progress.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.progress.out'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Log.final.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.final.out'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Log.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.out'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Log.progress.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.progress.out'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Log.final.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.final.out'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Log.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.out'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Log.progress.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.progress.out'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Log.final.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.final.out'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Log.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.out'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Log.progress.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.progress.out'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Log.final.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.final.out'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Log.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.out'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Log.progress.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.progress.out'
'Sample_CU11_5782_Q_Nascent_S11.Log.final.out' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.final.out'
'Sample_CU11_5782_Q_Nascent_S11.Log.out' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.out'
'Sample_CU11_5782_Q_Nascent_S11.Log.progress.out' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.progress.out'
'Sample_CU12_5782_Q_SteadyState_S12.Log.final.out' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.final.out'
'Sample_CU12_5782_Q_SteadyState_S12.Log.out' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.out'
'Sample_CU12_5782_Q_SteadyState_S12.Log.progress.out' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.progress.out'


❯ rename -n 's/.SJ.out.tab/.multi-10.SJ.tab/g' *
'5781_G1_IN_S5.SJ.out.tab' would be renamed to '5781_G1_IN_S5.multi-10.SJ.tab'
'5781_G1_IP_S1.SJ.out.tab' would be renamed to '5781_G1_IP_S1.multi-10.SJ.tab'
'5781_Q_IN_S6.SJ.out.tab' would be renamed to '5781_Q_IN_S6.multi-10.SJ.tab'
'5781_Q_IP_S2.SJ.out.tab' would be renamed to '5781_Q_IP_S2.multi-10.SJ.tab'
'5782_G1_IN_S7.SJ.out.tab' would be renamed to '5782_G1_IN_S7.multi-10.SJ.tab'
'5782_G1_IP_S3.SJ.out.tab' would be renamed to '5782_G1_IP_S3.multi-10.SJ.tab'
'5782_Q_IN_S8.SJ.out.tab' would be renamed to '5782_Q_IN_S8.multi-10.SJ.tab'
'5782_Q_IP_S4.SJ.out.tab' would be renamed to '5782_Q_IP_S4.multi-10.SJ.tab'
'CW10_7747_8day_Q_IN_S5.SJ.out.tab' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.SJ.tab'
'CW10_7747_8day_Q_PD_S11.SJ.out.tab' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.SJ.tab'
'CW12_7748_8day_Q_IN_S6.SJ.out.tab' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.SJ.tab'
'CW12_7748_8day_Q_PD_S12.SJ.out.tab' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.SJ.tab'
'CW2_5781_8day_Q_IN_S1.SJ.out.tab' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.SJ.tab'
'CW2_5781_8day_Q_PD_S7.SJ.out.tab' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.SJ.tab'
'CW4_5782_8day_Q_IN_S2.SJ.out.tab' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.SJ.tab'
'CW4_5782_8day_Q_PD_S8.SJ.out.tab' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.SJ.tab'
'CW6_7078_8day_Q_IN_S3.SJ.out.tab' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.SJ.tab'
'CW6_7078_8day_Q_PD_S9.SJ.out.tab' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.SJ.tab'
'CW8_7079_8day_Q_IN_S4.SJ.out.tab' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.SJ.tab'
'CW8_7079_8day_Q_PD_S10.SJ.out.tab' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.SJ.tab'
'SAMPLE_BM10_DSp48_5781_S22.SJ.out.tab' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.SJ.tab'
'SAMPLE_BM11_DSp48_7080_S23.SJ.out.tab' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.SJ.tab'
'SAMPLE_BM1_DSm2_5781_S13.SJ.out.tab' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.SJ.tab'
'SAMPLE_BM2_DSm2_7080_S14.SJ.out.tab' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.SJ.tab'
'SAMPLE_BM3_DSm2_7079_S15.SJ.out.tab' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.SJ.tab'
'SAMPLE_BM4_DSp2_5781_S16.SJ.out.tab' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.SJ.tab'
'SAMPLE_BM5_DSp2_7080_S17.SJ.out.tab' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.SJ.tab'
'SAMPLE_BM6_DSp2_7079_S18.SJ.out.tab' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.SJ.tab'
'SAMPLE_BM7_DSp24_5781_S19.SJ.out.tab' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.SJ.tab'
'SAMPLE_BM8_DSp24_7080_S20.SJ.out.tab' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.SJ.tab'
'SAMPLE_BM9_DSp24_7079_S21.SJ.out.tab' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.SJ.tab'
'SAMPLE_Bp10_DSp48_5782_S10.SJ.out.tab' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.SJ.tab'
'SAMPLE_Bp11_DSp48_7081_S11.SJ.out.tab' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.SJ.tab'
'SAMPLE_Bp12_DSp48_7078_S12.SJ.out.tab' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.SJ.tab'
'SAMPLE_Bp1_DSm2_5782_S1.SJ.out.tab' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.SJ.tab'
'SAMPLE_Bp2_DSm2_7081_S2.SJ.out.tab' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.SJ.tab'
'SAMPLE_Bp3_DSm2_7078_S3.SJ.out.tab' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.SJ.tab'
'SAMPLE_Bp4_DSp2_5782_S4.SJ.out.tab' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.SJ.tab'
'SAMPLE_Bp5_DSp2_7081_S5.SJ.out.tab' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.SJ.tab'
'SAMPLE_Bp6_DSp2_7078_S6.SJ.out.tab' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.SJ.tab'
'SAMPLE_Bp7_DSp24_5782_S7.SJ.out.tab' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.SJ.tab'
'SAMPLE_Bp8_DSp24_7081_S8.SJ.out.tab' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.SJ.tab'
'SAMPLE_Bp9_DSp24_7078_S9.SJ.out.tab' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.SJ.tab'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.SJ.out.tab' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.SJ.tab'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.SJ.out.tab' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.SJ.tab'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.SJ.out.tab' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.SJ.tab'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.SJ.out.tab' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.SJ.tab'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.SJ.out.tab' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.SJ.tab'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.SJ.out.tab' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.SJ.tab'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.SJ.out.tab' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.SJ.tab'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.SJ.out.tab' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.SJ.tab'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.SJ.out.tab' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.SJ.tab'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.SJ.out.tab' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.SJ.tab'
'Sample_CU11_5782_Q_Nascent_S11.SJ.out.tab' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.SJ.tab'
'Sample_CU12_5782_Q_SteadyState_S12.SJ.out.tab' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.SJ.tab'


❯ rename -n 's/.Aligned.sortedByCoord././g' *
'5781_G1_IN_S5.Aligned.sortedByCoord.out.bam' would be renamed to '5781_G1_IN_S5.out.bam'
'5781_G1_IP_S1.Aligned.sortedByCoord.out.bam' would be renamed to '5781_G1_IP_S1.out.bam'
'5781_Q_IN_S6.Aligned.sortedByCoord.out.bam' would be renamed to '5781_Q_IN_S6.out.bam'
'5781_Q_IP_S2.Aligned.sortedByCoord.out.bam' would be renamed to '5781_Q_IP_S2.out.bam'
'5782_G1_IN_S7.Aligned.sortedByCoord.out.bam' would be renamed to '5782_G1_IN_S7.out.bam'
'5782_G1_IP_S3.Aligned.sortedByCoord.out.bam' would be renamed to '5782_G1_IP_S3.out.bam'
'5782_Q_IN_S8.Aligned.sortedByCoord.out.bam' would be renamed to '5782_Q_IN_S8.out.bam'
'5782_Q_IP_S4.Aligned.sortedByCoord.out.bam' would be renamed to '5782_Q_IP_S4.out.bam'
'CW10_7747_8day_Q_IN_S5.Aligned.sortedByCoord.out.bam' would be renamed to 'CW10_7747_8day_Q_IN_S5.out.bam'
'CW10_7747_8day_Q_PD_S11.Aligned.sortedByCoord.out.bam' would be renamed to 'CW10_7747_8day_Q_PD_S11.out.bam'
'CW12_7748_8day_Q_IN_S6.Aligned.sortedByCoord.out.bam' would be renamed to 'CW12_7748_8day_Q_IN_S6.out.bam'
'CW12_7748_8day_Q_PD_S12.Aligned.sortedByCoord.out.bam' would be renamed to 'CW12_7748_8day_Q_PD_S12.out.bam'
'CW2_5781_8day_Q_IN_S1.Aligned.sortedByCoord.out.bam' would be renamed to 'CW2_5781_8day_Q_IN_S1.out.bam'
'CW2_5781_8day_Q_PD_S7.Aligned.sortedByCoord.out.bam' would be renamed to 'CW2_5781_8day_Q_PD_S7.out.bam'
'CW4_5782_8day_Q_IN_S2.Aligned.sortedByCoord.out.bam' would be renamed to 'CW4_5782_8day_Q_IN_S2.out.bam'
'CW4_5782_8day_Q_PD_S8.Aligned.sortedByCoord.out.bam' would be renamed to 'CW4_5782_8day_Q_PD_S8.out.bam'
'CW6_7078_8day_Q_IN_S3.Aligned.sortedByCoord.out.bam' would be renamed to 'CW6_7078_8day_Q_IN_S3.out.bam'
'CW6_7078_8day_Q_PD_S9.Aligned.sortedByCoord.out.bam' would be renamed to 'CW6_7078_8day_Q_PD_S9.out.bam'
'CW8_7079_8day_Q_IN_S4.Aligned.sortedByCoord.out.bam' would be renamed to 'CW8_7079_8day_Q_IN_S4.out.bam'
'CW8_7079_8day_Q_PD_S10.Aligned.sortedByCoord.out.bam' would be renamed to 'CW8_7079_8day_Q_PD_S10.out.bam'
'SAMPLE_BM10_DSp48_5781_S22.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.out.bam'
'SAMPLE_BM11_DSp48_7080_S23.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.out.bam'
'SAMPLE_BM1_DSm2_5781_S13.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.out.bam'
'SAMPLE_BM2_DSm2_7080_S14.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.out.bam'
'SAMPLE_BM3_DSm2_7079_S15.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.out.bam'
'SAMPLE_BM4_DSp2_5781_S16.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.out.bam'
'SAMPLE_BM5_DSp2_7080_S17.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.out.bam'
'SAMPLE_BM6_DSp2_7079_S18.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.out.bam'
'SAMPLE_BM7_DSp24_5781_S19.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.out.bam'
'SAMPLE_BM8_DSp24_7080_S20.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.out.bam'
'SAMPLE_BM9_DSp24_7079_S21.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.out.bam'
'SAMPLE_Bp10_DSp48_5782_S10.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.out.bam'
'SAMPLE_Bp11_DSp48_7081_S11.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.out.bam'
'SAMPLE_Bp12_DSp48_7078_S12.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.out.bam'
'SAMPLE_Bp1_DSm2_5782_S1.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.out.bam'
'SAMPLE_Bp2_DSm2_7081_S2.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.out.bam'
'SAMPLE_Bp3_DSm2_7078_S3.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.out.bam'
'SAMPLE_Bp4_DSp2_5782_S4.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.out.bam'
'SAMPLE_Bp5_DSp2_7081_S5.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.out.bam'
'SAMPLE_Bp6_DSp2_7078_S6.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.out.bam'
'SAMPLE_Bp7_DSp24_5782_S7.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.out.bam'
'SAMPLE_Bp8_DSp24_7081_S8.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.out.bam'
'SAMPLE_Bp9_DSp24_7078_S9.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.out.bam'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.out.bam'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.out.bam'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.out.bam'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.out.bam'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.out.bam'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.out.bam'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.out.bam'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.out.bam'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.out.bam'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.out.bam'
'Sample_CU11_5782_Q_Nascent_S11.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.out.bam'
'Sample_CU12_5782_Q_SteadyState_S12.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.out.bam'


❯ rename -n 's/.out.bam/.multi-10.bam/g' *
'5781_G1_IN_S5.out.bam' would be renamed to '5781_G1_IN_S5.multi-10.bam'
'5781_G1_IP_S1.out.bam' would be renamed to '5781_G1_IP_S1.multi-10.bam'
'5781_Q_IN_S6.out.bam' would be renamed to '5781_Q_IN_S6.multi-10.bam'
'5781_Q_IP_S2.out.bam' would be renamed to '5781_Q_IP_S2.multi-10.bam'
'5782_G1_IN_S7.out.bam' would be renamed to '5782_G1_IN_S7.multi-10.bam'
'5782_G1_IP_S3.out.bam' would be renamed to '5782_G1_IP_S3.multi-10.bam'
'5782_Q_IN_S8.out.bam' would be renamed to '5782_Q_IN_S8.multi-10.bam'
'5782_Q_IP_S4.out.bam' would be renamed to '5782_Q_IP_S4.multi-10.bam'
'CW10_7747_8day_Q_IN_S5.out.bam' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.bam'
'CW10_7747_8day_Q_PD_S11.out.bam' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.bam'
'CW12_7748_8day_Q_IN_S6.out.bam' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.bam'
'CW12_7748_8day_Q_PD_S12.out.bam' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.bam'
'CW2_5781_8day_Q_IN_S1.out.bam' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.bam'
'CW2_5781_8day_Q_PD_S7.out.bam' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.bam'
'CW4_5782_8day_Q_IN_S2.out.bam' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.bam'
'CW4_5782_8day_Q_PD_S8.out.bam' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.bam'
'CW6_7078_8day_Q_IN_S3.out.bam' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.bam'
'CW6_7078_8day_Q_PD_S9.out.bam' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.bam'
'CW8_7079_8day_Q_IN_S4.out.bam' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.bam'
'CW8_7079_8day_Q_PD_S10.out.bam' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.bam'
'SAMPLE_BM10_DSp48_5781_S22.out.bam' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.bam'
'SAMPLE_BM11_DSp48_7080_S23.out.bam' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.bam'
'SAMPLE_BM1_DSm2_5781_S13.out.bam' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.bam'
'SAMPLE_BM2_DSm2_7080_S14.out.bam' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.bam'
'SAMPLE_BM3_DSm2_7079_S15.out.bam' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.bam'
'SAMPLE_BM4_DSp2_5781_S16.out.bam' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.bam'
'SAMPLE_BM5_DSp2_7080_S17.out.bam' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.bam'
'SAMPLE_BM6_DSp2_7079_S18.out.bam' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.bam'
'SAMPLE_BM7_DSp24_5781_S19.out.bam' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.bam'
'SAMPLE_BM8_DSp24_7080_S20.out.bam' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.bam'
'SAMPLE_BM9_DSp24_7079_S21.out.bam' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.bam'
'SAMPLE_Bp10_DSp48_5782_S10.out.bam' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.bam'
'SAMPLE_Bp11_DSp48_7081_S11.out.bam' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.bam'
'SAMPLE_Bp12_DSp48_7078_S12.out.bam' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.bam'
'SAMPLE_Bp1_DSm2_5782_S1.out.bam' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.bam'
'SAMPLE_Bp2_DSm2_7081_S2.out.bam' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.bam'
'SAMPLE_Bp3_DSm2_7078_S3.out.bam' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.bam'
'SAMPLE_Bp4_DSp2_5782_S4.out.bam' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.bam'
'SAMPLE_Bp5_DSp2_7081_S5.out.bam' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.bam'
'SAMPLE_Bp6_DSp2_7078_S6.out.bam' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.bam'
'SAMPLE_Bp7_DSp24_5782_S7.out.bam' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.bam'
'SAMPLE_Bp8_DSp24_7081_S8.out.bam' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.bam'
'SAMPLE_Bp9_DSp24_7078_S9.out.bam' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.bam'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.out.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.bam'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.out.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.bam'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.out.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.bam'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.out.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.bam'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.out.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.bam'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.out.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.bam'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.out.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.bam'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.out.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.bam'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.out.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.bam'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.out.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.bam'
'Sample_CU11_5782_Q_Nascent_S11.out.bam' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.bam'
'Sample_CU12_5782_Q_SteadyState_S12.out.bam' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.bam'
```
</details>
<br />

<a id="in-bamsunmapped-wsc_kl_20s"></a>
##### In `bams/unmapped-w/SC_KL_20S`...
<a id="code-18"></a>
###### Code
<details>
<summary><i>Code: In bams/unmapped-w/SC_KL_20S...</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd bams/unmapped-w/SC_KL_20S \
    || echo "cd'ing failed; check on this..."

#  Working things out...
rm -r *._STARtmp

rename -n 's/.out./.multi-10./g' *
rename 's/.out./.multi-10./g' *

rename -n 's/.Log./.multi-10.Log./g' *
rename 's/.Log./.multi-10.Log./g' *

rename -n 's/.SJ.multi-10.tab/.multi-10.SJ.tab/g' *
rename 's/.SJ.multi-10.tab/.multi-10.SJ.tab/g' *

rename -n 's/.Aligned.sortedByCoord././g' *
rename 's/.Aligned.sortedByCoord././g' *
```
</details>
<br />

<a id="printed-8"></a>
###### Printed
<details>
<summary><i>Printed: In bams/unmapped-w/SC_KL_20S...</i></summary>

```txt
❯ rename -n 's/.out./.multi-10./g' *
'5781_G1_IN_S5.Aligned.sortedByCoord.out.bam' would be renamed to '5781_G1_IN_S5.Aligned.sortedByCoord.multi-10.bam'
'5781_G1_IN_S5.SJ.out.tab' would be renamed to '5781_G1_IN_S5.SJ.multi-10.tab'
'5781_G1_IP_S1.Aligned.sortedByCoord.out.bam' would be renamed to '5781_G1_IP_S1.Aligned.sortedByCoord.multi-10.bam'
'5781_G1_IP_S1.SJ.out.tab' would be renamed to '5781_G1_IP_S1.SJ.multi-10.tab'
'5781_Q_IN_S6.Aligned.sortedByCoord.out.bam' would be renamed to '5781_Q_IN_S6.Aligned.sortedByCoord.multi-10.bam'
'5781_Q_IN_S6.SJ.out.tab' would be renamed to '5781_Q_IN_S6.SJ.multi-10.tab'
'5781_Q_IP_S2.Aligned.sortedByCoord.out.bam' would be renamed to '5781_Q_IP_S2.Aligned.sortedByCoord.multi-10.bam'
'5781_Q_IP_S2.SJ.out.tab' would be renamed to '5781_Q_IP_S2.SJ.multi-10.tab'
'5782_G1_IN_S7.Aligned.sortedByCoord.out.bam' would be renamed to '5782_G1_IN_S7.Aligned.sortedByCoord.multi-10.bam'
'5782_G1_IN_S7.SJ.out.tab' would be renamed to '5782_G1_IN_S7.SJ.multi-10.tab'
'5782_G1_IP_S3.Aligned.sortedByCoord.out.bam' would be renamed to '5782_G1_IP_S3.Aligned.sortedByCoord.multi-10.bam'
'5782_G1_IP_S3.SJ.out.tab' would be renamed to '5782_G1_IP_S3.SJ.multi-10.tab'
'5782_Q_IN_S8.Aligned.sortedByCoord.out.bam' would be renamed to '5782_Q_IN_S8.Aligned.sortedByCoord.multi-10.bam'
'5782_Q_IN_S8.SJ.out.tab' would be renamed to '5782_Q_IN_S8.SJ.multi-10.tab'
'5782_Q_IP_S4.Aligned.sortedByCoord.out.bam' would be renamed to '5782_Q_IP_S4.Aligned.sortedByCoord.multi-10.bam'
'5782_Q_IP_S4.SJ.out.tab' would be renamed to '5782_Q_IP_S4.SJ.multi-10.tab'
'CW10_7747_8day_Q_IN_S5.Aligned.sortedByCoord.out.bam' would be renamed to 'CW10_7747_8day_Q_IN_S5.Aligned.sortedByCoord.multi-10.bam'
'CW10_7747_8day_Q_IN_S5.SJ.out.tab' would be renamed to 'CW10_7747_8day_Q_IN_S5.SJ.multi-10.tab'
'CW10_7747_8day_Q_PD_S11.Aligned.sortedByCoord.out.bam' would be renamed to 'CW10_7747_8day_Q_PD_S11.Aligned.sortedByCoord.multi-10.bam'
'CW10_7747_8day_Q_PD_S11.SJ.out.tab' would be renamed to 'CW10_7747_8day_Q_PD_S11.SJ.multi-10.tab'
'CW12_7748_8day_Q_IN_S6.Aligned.sortedByCoord.out.bam' would be renamed to 'CW12_7748_8day_Q_IN_S6.Aligned.sortedByCoord.multi-10.bam'
'CW12_7748_8day_Q_IN_S6.SJ.out.tab' would be renamed to 'CW12_7748_8day_Q_IN_S6.SJ.multi-10.tab'
'CW12_7748_8day_Q_PD_S12.Aligned.sortedByCoord.out.bam' would be renamed to 'CW12_7748_8day_Q_PD_S12.Aligned.sortedByCoord.multi-10.bam'
'CW12_7748_8day_Q_PD_S12.SJ.out.tab' would be renamed to 'CW12_7748_8day_Q_PD_S12.SJ.multi-10.tab'
'CW2_5781_8day_Q_IN_S1.Aligned.sortedByCoord.out.bam' would be renamed to 'CW2_5781_8day_Q_IN_S1.Aligned.sortedByCoord.multi-10.bam'
'CW2_5781_8day_Q_IN_S1.SJ.out.tab' would be renamed to 'CW2_5781_8day_Q_IN_S1.SJ.multi-10.tab'
'CW2_5781_8day_Q_PD_S7.Aligned.sortedByCoord.out.bam' would be renamed to 'CW2_5781_8day_Q_PD_S7.Aligned.sortedByCoord.multi-10.bam'
'CW2_5781_8day_Q_PD_S7.SJ.out.tab' would be renamed to 'CW2_5781_8day_Q_PD_S7.SJ.multi-10.tab'
'CW4_5782_8day_Q_IN_S2.Aligned.sortedByCoord.out.bam' would be renamed to 'CW4_5782_8day_Q_IN_S2.Aligned.sortedByCoord.multi-10.bam'
'CW4_5782_8day_Q_IN_S2.SJ.out.tab' would be renamed to 'CW4_5782_8day_Q_IN_S2.SJ.multi-10.tab'
'CW4_5782_8day_Q_PD_S8.Aligned.sortedByCoord.out.bam' would be renamed to 'CW4_5782_8day_Q_PD_S8.Aligned.sortedByCoord.multi-10.bam'
'CW4_5782_8day_Q_PD_S8.SJ.out.tab' would be renamed to 'CW4_5782_8day_Q_PD_S8.SJ.multi-10.tab'
'CW6_7078_8day_Q_IN_S3.Aligned.sortedByCoord.out.bam' would be renamed to 'CW6_7078_8day_Q_IN_S3.Aligned.sortedByCoord.multi-10.bam'
'CW6_7078_8day_Q_IN_S3.SJ.out.tab' would be renamed to 'CW6_7078_8day_Q_IN_S3.SJ.multi-10.tab'
'CW6_7078_8day_Q_PD_S9.Aligned.sortedByCoord.out.bam' would be renamed to 'CW6_7078_8day_Q_PD_S9.Aligned.sortedByCoord.multi-10.bam'
'CW6_7078_8day_Q_PD_S9.SJ.out.tab' would be renamed to 'CW6_7078_8day_Q_PD_S9.SJ.multi-10.tab'
'CW8_7079_8day_Q_IN_S4.Aligned.sortedByCoord.out.bam' would be renamed to 'CW8_7079_8day_Q_IN_S4.Aligned.sortedByCoord.multi-10.bam'
'CW8_7079_8day_Q_IN_S4.SJ.out.tab' would be renamed to 'CW8_7079_8day_Q_IN_S4.SJ.multi-10.tab'
'CW8_7079_8day_Q_PD_S10.Aligned.sortedByCoord.out.bam' would be renamed to 'CW8_7079_8day_Q_PD_S10.Aligned.sortedByCoord.multi-10.bam'
'CW8_7079_8day_Q_PD_S10.SJ.out.tab' would be renamed to 'CW8_7079_8day_Q_PD_S10.SJ.multi-10.tab'
'SAMPLE_BM10_DSp48_5781_S22.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM10_DSp48_5781_S22.SJ.out.tab' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.SJ.multi-10.tab'
'SAMPLE_BM11_DSp48_7080_S23.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM11_DSp48_7080_S23.SJ.out.tab' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.SJ.multi-10.tab'
'SAMPLE_BM1_DSm2_5781_S13.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM1_DSm2_5781_S13.SJ.out.tab' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.SJ.multi-10.tab'
'SAMPLE_BM2_DSm2_7080_S14.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM2_DSm2_7080_S14.SJ.out.tab' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.SJ.multi-10.tab'
'SAMPLE_BM3_DSm2_7079_S15.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM3_DSm2_7079_S15.SJ.out.tab' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.SJ.multi-10.tab'
'SAMPLE_BM4_DSp2_5781_S16.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM4_DSp2_5781_S16.SJ.out.tab' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.SJ.multi-10.tab'
'SAMPLE_BM5_DSp2_7080_S17.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM5_DSp2_7080_S17.SJ.out.tab' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.SJ.multi-10.tab'
'SAMPLE_BM6_DSp2_7079_S18.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM6_DSp2_7079_S18.SJ.out.tab' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.SJ.multi-10.tab'
'SAMPLE_BM7_DSp24_5781_S19.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM7_DSp24_5781_S19.SJ.out.tab' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.SJ.multi-10.tab'
'SAMPLE_BM8_DSp24_7080_S20.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM8_DSp24_7080_S20.SJ.out.tab' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.SJ.multi-10.tab'
'SAMPLE_BM9_DSp24_7079_S21.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_BM9_DSp24_7079_S21.SJ.out.tab' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.SJ.multi-10.tab'
'SAMPLE_Bp10_DSp48_5782_S10.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp10_DSp48_5782_S10.SJ.out.tab' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.SJ.multi-10.tab'
'SAMPLE_Bp11_DSp48_7081_S11.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp11_DSp48_7081_S11.SJ.out.tab' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.SJ.multi-10.tab'
'SAMPLE_Bp12_DSp48_7078_S12.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp12_DSp48_7078_S12.SJ.out.tab' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.SJ.multi-10.tab'
'SAMPLE_Bp1_DSm2_5782_S1.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp1_DSm2_5782_S1.SJ.out.tab' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.SJ.multi-10.tab'
'SAMPLE_Bp2_DSm2_7081_S2.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp2_DSm2_7081_S2.SJ.out.tab' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.SJ.multi-10.tab'
'SAMPLE_Bp3_DSm2_7078_S3.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp3_DSm2_7078_S3.SJ.out.tab' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.SJ.multi-10.tab'
'SAMPLE_Bp4_DSp2_5782_S4.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp4_DSp2_5782_S4.SJ.out.tab' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.SJ.multi-10.tab'
'SAMPLE_Bp5_DSp2_7081_S5.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp5_DSp2_7081_S5.SJ.out.tab' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.SJ.multi-10.tab'
'SAMPLE_Bp6_DSp2_7078_S6.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp6_DSp2_7078_S6.SJ.out.tab' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.SJ.multi-10.tab'
'SAMPLE_Bp7_DSp24_5782_S7.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp7_DSp24_5782_S7.SJ.out.tab' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.SJ.multi-10.tab'
'SAMPLE_Bp8_DSp24_7081_S8.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp8_DSp24_7081_S8.SJ.out.tab' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.SJ.multi-10.tab'
'SAMPLE_Bp9_DSp24_7078_S9.Aligned.sortedByCoord.out.bam' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.Aligned.sortedByCoord.multi-10.bam'
'SAMPLE_Bp9_DSp24_7078_S9.SJ.out.tab' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.SJ.multi-10.tab'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.SJ.out.tab' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.SJ.multi-10.tab'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.SJ.out.tab' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.SJ.multi-10.tab'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.SJ.out.tab' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.SJ.multi-10.tab'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.SJ.out.tab' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.SJ.multi-10.tab'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.SJ.out.tab' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.SJ.multi-10.tab'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.SJ.out.tab' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.SJ.multi-10.tab'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.SJ.out.tab' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.SJ.multi-10.tab'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.SJ.out.tab' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.SJ.multi-10.tab'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.SJ.out.tab' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.SJ.multi-10.tab'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Aligned.sortedByCoord.multi-10.bam'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.SJ.out.tab' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.SJ.multi-10.tab'
'Sample_CU11_5782_Q_Nascent_S11.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.Aligned.sortedByCoord.multi-10.bam'
'Sample_CU11_5782_Q_Nascent_S11.SJ.out.tab' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.SJ.multi-10.tab'
'Sample_CU12_5782_Q_SteadyState_S12.Aligned.sortedByCoord.out.bam' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.Aligned.sortedByCoord.multi-10.bam'
'Sample_CU12_5782_Q_SteadyState_S12.SJ.out.tab' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.SJ.multi-10.tab'


❯ rename -n 's/.Log./.multi-10.Log./g' *
'5781_G1_IN_S5.Log.final.out' would be renamed to '5781_G1_IN_S5.multi-10.Log.final.out'
'5781_G1_IN_S5.Log.out' would be renamed to '5781_G1_IN_S5.multi-10.Log.out'
'5781_G1_IN_S5.Log.progress.out' would be renamed to '5781_G1_IN_S5.multi-10.Log.progress.out'
'5781_G1_IP_S1.Log.final.out' would be renamed to '5781_G1_IP_S1.multi-10.Log.final.out'
'5781_G1_IP_S1.Log.out' would be renamed to '5781_G1_IP_S1.multi-10.Log.out'
'5781_G1_IP_S1.Log.progress.out' would be renamed to '5781_G1_IP_S1.multi-10.Log.progress.out'
'5781_Q_IN_S6.Log.final.out' would be renamed to '5781_Q_IN_S6.multi-10.Log.final.out'
'5781_Q_IN_S6.Log.out' would be renamed to '5781_Q_IN_S6.multi-10.Log.out'
'5781_Q_IN_S6.Log.progress.out' would be renamed to '5781_Q_IN_S6.multi-10.Log.progress.out'
'5781_Q_IP_S2.Log.final.out' would be renamed to '5781_Q_IP_S2.multi-10.Log.final.out'
'5781_Q_IP_S2.Log.out' would be renamed to '5781_Q_IP_S2.multi-10.Log.out'
'5781_Q_IP_S2.Log.progress.out' would be renamed to '5781_Q_IP_S2.multi-10.Log.progress.out'
'5782_G1_IN_S7.Log.final.out' would be renamed to '5782_G1_IN_S7.multi-10.Log.final.out'
'5782_G1_IN_S7.Log.out' would be renamed to '5782_G1_IN_S7.multi-10.Log.out'
'5782_G1_IN_S7.Log.progress.out' would be renamed to '5782_G1_IN_S7.multi-10.Log.progress.out'
'5782_G1_IP_S3.Log.final.out' would be renamed to '5782_G1_IP_S3.multi-10.Log.final.out'
'5782_G1_IP_S3.Log.out' would be renamed to '5782_G1_IP_S3.multi-10.Log.out'
'5782_G1_IP_S3.Log.progress.out' would be renamed to '5782_G1_IP_S3.multi-10.Log.progress.out'
'5782_Q_IN_S8.Log.final.out' would be renamed to '5782_Q_IN_S8.multi-10.Log.final.out'
'5782_Q_IN_S8.Log.out' would be renamed to '5782_Q_IN_S8.multi-10.Log.out'
'5782_Q_IN_S8.Log.progress.out' would be renamed to '5782_Q_IN_S8.multi-10.Log.progress.out'
'5782_Q_IP_S4.Log.final.out' would be renamed to '5782_Q_IP_S4.multi-10.Log.final.out'
'5782_Q_IP_S4.Log.out' would be renamed to '5782_Q_IP_S4.multi-10.Log.out'
'5782_Q_IP_S4.Log.progress.out' would be renamed to '5782_Q_IP_S4.multi-10.Log.progress.out'
'CW10_7747_8day_Q_IN_S5.Log.final.out' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.Log.final.out'
'CW10_7747_8day_Q_IN_S5.Log.out' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.Log.out'
'CW10_7747_8day_Q_IN_S5.Log.progress.out' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.Log.progress.out'
'CW10_7747_8day_Q_PD_S11.Log.final.out' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.Log.final.out'
'CW10_7747_8day_Q_PD_S11.Log.out' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.Log.out'
'CW10_7747_8day_Q_PD_S11.Log.progress.out' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.Log.progress.out'
'CW12_7748_8day_Q_IN_S6.Log.final.out' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.Log.final.out'
'CW12_7748_8day_Q_IN_S6.Log.out' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.Log.out'
'CW12_7748_8day_Q_IN_S6.Log.progress.out' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.Log.progress.out'
'CW12_7748_8day_Q_PD_S12.Log.final.out' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.Log.final.out'
'CW12_7748_8day_Q_PD_S12.Log.out' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.Log.out'
'CW12_7748_8day_Q_PD_S12.Log.progress.out' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.Log.progress.out'
'CW2_5781_8day_Q_IN_S1.Log.final.out' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.Log.final.out'
'CW2_5781_8day_Q_IN_S1.Log.out' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.Log.out'
'CW2_5781_8day_Q_IN_S1.Log.progress.out' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.Log.progress.out'
'CW2_5781_8day_Q_PD_S7.Log.final.out' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.Log.final.out'
'CW2_5781_8day_Q_PD_S7.Log.out' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.Log.out'
'CW2_5781_8day_Q_PD_S7.Log.progress.out' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.Log.progress.out'
'CW4_5782_8day_Q_IN_S2.Log.final.out' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.Log.final.out'
'CW4_5782_8day_Q_IN_S2.Log.out' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.Log.out'
'CW4_5782_8day_Q_IN_S2.Log.progress.out' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.Log.progress.out'
'CW4_5782_8day_Q_PD_S8.Log.final.out' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.Log.final.out'
'CW4_5782_8day_Q_PD_S8.Log.out' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.Log.out'
'CW4_5782_8day_Q_PD_S8.Log.progress.out' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.Log.progress.out'
'CW6_7078_8day_Q_IN_S3.Log.final.out' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.Log.final.out'
'CW6_7078_8day_Q_IN_S3.Log.out' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.Log.out'
'CW6_7078_8day_Q_IN_S3.Log.progress.out' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.Log.progress.out'
'CW6_7078_8day_Q_PD_S9.Log.final.out' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.Log.final.out'
'CW6_7078_8day_Q_PD_S9.Log.out' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.Log.out'
'CW6_7078_8day_Q_PD_S9.Log.progress.out' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.Log.progress.out'
'CW8_7079_8day_Q_IN_S4.Log.final.out' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.Log.final.out'
'CW8_7079_8day_Q_IN_S4.Log.out' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.Log.out'
'CW8_7079_8day_Q_IN_S4.Log.progress.out' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.Log.progress.out'
'CW8_7079_8day_Q_PD_S10.Log.final.out' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.Log.final.out'
'CW8_7079_8day_Q_PD_S10.Log.out' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.Log.out'
'CW8_7079_8day_Q_PD_S10.Log.progress.out' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.Log.progress.out'
'SAMPLE_BM10_DSp48_5781_S22.Log.final.out' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.final.out'
'SAMPLE_BM10_DSp48_5781_S22.Log.out' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.out'
'SAMPLE_BM10_DSp48_5781_S22.Log.progress.out' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.progress.out'
'SAMPLE_BM11_DSp48_7080_S23.Log.final.out' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.final.out'
'SAMPLE_BM11_DSp48_7080_S23.Log.out' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.out'
'SAMPLE_BM11_DSp48_7080_S23.Log.progress.out' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.progress.out'
'SAMPLE_BM1_DSm2_5781_S13.Log.final.out' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.final.out'
'SAMPLE_BM1_DSm2_5781_S13.Log.out' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.out'
'SAMPLE_BM1_DSm2_5781_S13.Log.progress.out' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.progress.out'
'SAMPLE_BM2_DSm2_7080_S14.Log.final.out' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.final.out'
'SAMPLE_BM2_DSm2_7080_S14.Log.out' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.out'
'SAMPLE_BM2_DSm2_7080_S14.Log.progress.out' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.progress.out'
'SAMPLE_BM3_DSm2_7079_S15.Log.final.out' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.final.out'
'SAMPLE_BM3_DSm2_7079_S15.Log.out' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.out'
'SAMPLE_BM3_DSm2_7079_S15.Log.progress.out' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.progress.out'
'SAMPLE_BM4_DSp2_5781_S16.Log.final.out' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.final.out'
'SAMPLE_BM4_DSp2_5781_S16.Log.out' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.out'
'SAMPLE_BM4_DSp2_5781_S16.Log.progress.out' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.progress.out'
'SAMPLE_BM5_DSp2_7080_S17.Log.final.out' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.final.out'
'SAMPLE_BM5_DSp2_7080_S17.Log.out' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.out'
'SAMPLE_BM5_DSp2_7080_S17.Log.progress.out' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.progress.out'
'SAMPLE_BM6_DSp2_7079_S18.Log.final.out' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.final.out'
'SAMPLE_BM6_DSp2_7079_S18.Log.out' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.out'
'SAMPLE_BM6_DSp2_7079_S18.Log.progress.out' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.progress.out'
'SAMPLE_BM7_DSp24_5781_S19.Log.final.out' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.final.out'
'SAMPLE_BM7_DSp24_5781_S19.Log.out' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.out'
'SAMPLE_BM7_DSp24_5781_S19.Log.progress.out' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.progress.out'
'SAMPLE_BM8_DSp24_7080_S20.Log.final.out' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.final.out'
'SAMPLE_BM8_DSp24_7080_S20.Log.out' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.out'
'SAMPLE_BM8_DSp24_7080_S20.Log.progress.out' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.progress.out'
'SAMPLE_BM9_DSp24_7079_S21.Log.final.out' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.final.out'
'SAMPLE_BM9_DSp24_7079_S21.Log.out' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.out'
'SAMPLE_BM9_DSp24_7079_S21.Log.progress.out' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.progress.out'
'SAMPLE_Bp10_DSp48_5782_S10.Log.final.out' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.final.out'
'SAMPLE_Bp10_DSp48_5782_S10.Log.out' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.out'
'SAMPLE_Bp10_DSp48_5782_S10.Log.progress.out' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.progress.out'
'SAMPLE_Bp11_DSp48_7081_S11.Log.final.out' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.final.out'
'SAMPLE_Bp11_DSp48_7081_S11.Log.out' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.out'
'SAMPLE_Bp11_DSp48_7081_S11.Log.progress.out' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.progress.out'
'SAMPLE_Bp12_DSp48_7078_S12.Log.final.out' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.final.out'
'SAMPLE_Bp12_DSp48_7078_S12.Log.out' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.out'
'SAMPLE_Bp12_DSp48_7078_S12.Log.progress.out' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.progress.out'
'SAMPLE_Bp1_DSm2_5782_S1.Log.final.out' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.final.out'
'SAMPLE_Bp1_DSm2_5782_S1.Log.out' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.out'
'SAMPLE_Bp1_DSm2_5782_S1.Log.progress.out' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.progress.out'
'SAMPLE_Bp2_DSm2_7081_S2.Log.final.out' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.final.out'
'SAMPLE_Bp2_DSm2_7081_S2.Log.out' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.out'
'SAMPLE_Bp2_DSm2_7081_S2.Log.progress.out' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.progress.out'
'SAMPLE_Bp3_DSm2_7078_S3.Log.final.out' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.final.out'
'SAMPLE_Bp3_DSm2_7078_S3.Log.out' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.out'
'SAMPLE_Bp3_DSm2_7078_S3.Log.progress.out' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.progress.out'
'SAMPLE_Bp4_DSp2_5782_S4.Log.final.out' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.final.out'
'SAMPLE_Bp4_DSp2_5782_S4.Log.out' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.out'
'SAMPLE_Bp4_DSp2_5782_S4.Log.progress.out' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.progress.out'
'SAMPLE_Bp5_DSp2_7081_S5.Log.final.out' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.final.out'
'SAMPLE_Bp5_DSp2_7081_S5.Log.out' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.out'
'SAMPLE_Bp5_DSp2_7081_S5.Log.progress.out' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.progress.out'
'SAMPLE_Bp6_DSp2_7078_S6.Log.final.out' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.final.out'
'SAMPLE_Bp6_DSp2_7078_S6.Log.out' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.out'
'SAMPLE_Bp6_DSp2_7078_S6.Log.progress.out' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.progress.out'
'SAMPLE_Bp7_DSp24_5782_S7.Log.final.out' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.final.out'
'SAMPLE_Bp7_DSp24_5782_S7.Log.out' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.out'
'SAMPLE_Bp7_DSp24_5782_S7.Log.progress.out' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.progress.out'
'SAMPLE_Bp8_DSp24_7081_S8.Log.final.out' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.final.out'
'SAMPLE_Bp8_DSp24_7081_S8.Log.out' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.out'
'SAMPLE_Bp8_DSp24_7081_S8.Log.progress.out' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.progress.out'
'SAMPLE_Bp9_DSp24_7078_S9.Log.final.out' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.final.out'
'SAMPLE_Bp9_DSp24_7078_S9.Log.out' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.out'
'SAMPLE_Bp9_DSp24_7078_S9.Log.progress.out' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.progress.out'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Log.final.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.final.out'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Log.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.out'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Log.progress.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.progress.out'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Log.final.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.final.out'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Log.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.out'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Log.progress.out' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.progress.out'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Log.final.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.final.out'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Log.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.out'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Log.progress.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.progress.out'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Log.final.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.final.out'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Log.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.out'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Log.progress.out' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.progress.out'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Log.final.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.final.out'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Log.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.out'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Log.progress.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.progress.out'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Log.final.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.final.out'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Log.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.out'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Log.progress.out' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.progress.out'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Log.final.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.final.out'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Log.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.out'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Log.progress.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.progress.out'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Log.final.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.final.out'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Log.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.out'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Log.progress.out' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.progress.out'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Log.final.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.final.out'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Log.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.out'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Log.progress.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.progress.out'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Log.final.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.final.out'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Log.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.out'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Log.progress.out' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.progress.out'
'Sample_CU11_5782_Q_Nascent_S11.Log.final.out' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.final.out'
'Sample_CU11_5782_Q_Nascent_S11.Log.out' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.out'
'Sample_CU11_5782_Q_Nascent_S11.Log.progress.out' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.progress.out'
'Sample_CU12_5782_Q_SteadyState_S12.Log.final.out' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.final.out'
'Sample_CU12_5782_Q_SteadyState_S12.Log.out' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.out'
'Sample_CU12_5782_Q_SteadyState_S12.Log.progress.out' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.progress.out'


❯ rename -n 's/.SJ.multi-10.tab/.multi-10.SJ.tab/g' *
'5781_G1_IN_S5.SJ.multi-10.tab' would be renamed to '5781_G1_IN_S5.multi-10.SJ.tab'
'5781_G1_IP_S1.SJ.multi-10.tab' would be renamed to '5781_G1_IP_S1.multi-10.SJ.tab'
'5781_Q_IN_S6.SJ.multi-10.tab' would be renamed to '5781_Q_IN_S6.multi-10.SJ.tab'
'5781_Q_IP_S2.SJ.multi-10.tab' would be renamed to '5781_Q_IP_S2.multi-10.SJ.tab'
'5782_G1_IN_S7.SJ.multi-10.tab' would be renamed to '5782_G1_IN_S7.multi-10.SJ.tab'
'5782_G1_IP_S3.SJ.multi-10.tab' would be renamed to '5782_G1_IP_S3.multi-10.SJ.tab'
'5782_Q_IN_S8.SJ.multi-10.tab' would be renamed to '5782_Q_IN_S8.multi-10.SJ.tab'
'5782_Q_IP_S4.SJ.multi-10.tab' would be renamed to '5782_Q_IP_S4.multi-10.SJ.tab'
'CW10_7747_8day_Q_IN_S5.SJ.multi-10.tab' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.SJ.tab'
'CW10_7747_8day_Q_PD_S11.SJ.multi-10.tab' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.SJ.tab'
'CW12_7748_8day_Q_IN_S6.SJ.multi-10.tab' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.SJ.tab'
'CW12_7748_8day_Q_PD_S12.SJ.multi-10.tab' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.SJ.tab'
'CW2_5781_8day_Q_IN_S1.SJ.multi-10.tab' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.SJ.tab'
'CW2_5781_8day_Q_PD_S7.SJ.multi-10.tab' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.SJ.tab'
'CW4_5782_8day_Q_IN_S2.SJ.multi-10.tab' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.SJ.tab'
'CW4_5782_8day_Q_PD_S8.SJ.multi-10.tab' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.SJ.tab'
'CW6_7078_8day_Q_IN_S3.SJ.multi-10.tab' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.SJ.tab'
'CW6_7078_8day_Q_PD_S9.SJ.multi-10.tab' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.SJ.tab'
'CW8_7079_8day_Q_IN_S4.SJ.multi-10.tab' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.SJ.tab'
'CW8_7079_8day_Q_PD_S10.SJ.multi-10.tab' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.SJ.tab'
'SAMPLE_BM10_DSp48_5781_S22.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.SJ.tab'
'SAMPLE_BM11_DSp48_7080_S23.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.SJ.tab'
'SAMPLE_BM1_DSm2_5781_S13.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.SJ.tab'
'SAMPLE_BM2_DSm2_7080_S14.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.SJ.tab'
'SAMPLE_BM3_DSm2_7079_S15.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.SJ.tab'
'SAMPLE_BM4_DSp2_5781_S16.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.SJ.tab'
'SAMPLE_BM5_DSp2_7080_S17.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.SJ.tab'
'SAMPLE_BM6_DSp2_7079_S18.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.SJ.tab'
'SAMPLE_BM7_DSp24_5781_S19.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.SJ.tab'
'SAMPLE_BM8_DSp24_7080_S20.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.SJ.tab'
'SAMPLE_BM9_DSp24_7079_S21.SJ.multi-10.tab' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.SJ.tab'
'SAMPLE_Bp10_DSp48_5782_S10.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.SJ.tab'
'SAMPLE_Bp11_DSp48_7081_S11.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.SJ.tab'
'SAMPLE_Bp12_DSp48_7078_S12.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.SJ.tab'
'SAMPLE_Bp1_DSm2_5782_S1.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.SJ.tab'
'SAMPLE_Bp2_DSm2_7081_S2.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.SJ.tab'
'SAMPLE_Bp3_DSm2_7078_S3.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.SJ.tab'
'SAMPLE_Bp4_DSp2_5782_S4.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.SJ.tab'
'SAMPLE_Bp5_DSp2_7081_S5.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.SJ.tab'
'SAMPLE_Bp6_DSp2_7078_S6.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.SJ.tab'
'SAMPLE_Bp7_DSp24_5782_S7.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.SJ.tab'
'SAMPLE_Bp8_DSp24_7081_S8.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.SJ.tab'
'SAMPLE_Bp9_DSp24_7078_S9.SJ.multi-10.tab' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.SJ.tab'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.SJ.multi-10.tab' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.SJ.tab'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.SJ.multi-10.tab' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.SJ.tab'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.SJ.multi-10.tab' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.SJ.tab'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.SJ.multi-10.tab' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.SJ.tab'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.SJ.multi-10.tab' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.SJ.tab'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.SJ.multi-10.tab' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.SJ.tab'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.SJ.multi-10.tab' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.SJ.tab'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.SJ.multi-10.tab' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.SJ.tab'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.SJ.multi-10.tab' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.SJ.tab'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.SJ.multi-10.tab' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.SJ.tab'
'Sample_CU11_5782_Q_Nascent_S11.SJ.multi-10.tab' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.SJ.tab'
'Sample_CU12_5782_Q_SteadyState_S12.SJ.multi-10.tab' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.SJ.tab'


❯ rename -n 's/.Aligned.sortedByCoord././g' *
'5781_G1_IN_S5.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5781_G1_IN_S5.multi-10.bam'
'5781_G1_IP_S1.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5781_G1_IP_S1.multi-10.bam'
'5781_Q_IN_S6.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5781_Q_IN_S6.multi-10.bam'
'5781_Q_IP_S2.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5781_Q_IP_S2.multi-10.bam'
'5782_G1_IN_S7.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5782_G1_IN_S7.multi-10.bam'
'5782_G1_IP_S3.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5782_G1_IP_S3.multi-10.bam'
'5782_Q_IN_S8.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5782_Q_IN_S8.multi-10.bam'
'5782_Q_IP_S4.Aligned.sortedByCoord.multi-10.bam' would be renamed to '5782_Q_IP_S4.multi-10.bam'
'CW10_7747_8day_Q_IN_S5.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW10_7747_8day_Q_IN_S5.multi-10.bam'
'CW10_7747_8day_Q_PD_S11.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW10_7747_8day_Q_PD_S11.multi-10.bam'
'CW12_7748_8day_Q_IN_S6.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW12_7748_8day_Q_IN_S6.multi-10.bam'
'CW12_7748_8day_Q_PD_S12.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW12_7748_8day_Q_PD_S12.multi-10.bam'
'CW2_5781_8day_Q_IN_S1.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW2_5781_8day_Q_IN_S1.multi-10.bam'
'CW2_5781_8day_Q_PD_S7.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW2_5781_8day_Q_PD_S7.multi-10.bam'
'CW4_5782_8day_Q_IN_S2.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW4_5782_8day_Q_IN_S2.multi-10.bam'
'CW4_5782_8day_Q_PD_S8.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW4_5782_8day_Q_PD_S8.multi-10.bam'
'CW6_7078_8day_Q_IN_S3.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW6_7078_8day_Q_IN_S3.multi-10.bam'
'CW6_7078_8day_Q_PD_S9.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW6_7078_8day_Q_PD_S9.multi-10.bam'
'CW8_7079_8day_Q_IN_S4.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW8_7079_8day_Q_IN_S4.multi-10.bam'
'CW8_7079_8day_Q_PD_S10.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'CW8_7079_8day_Q_PD_S10.multi-10.bam'
'SAMPLE_BM10_DSp48_5781_S22.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM10_DSp48_5781_S22.multi-10.bam'
'SAMPLE_BM11_DSp48_7080_S23.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM11_DSp48_7080_S23.multi-10.bam'
'SAMPLE_BM1_DSm2_5781_S13.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM1_DSm2_5781_S13.multi-10.bam'
'SAMPLE_BM2_DSm2_7080_S14.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM2_DSm2_7080_S14.multi-10.bam'
'SAMPLE_BM3_DSm2_7079_S15.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM3_DSm2_7079_S15.multi-10.bam'
'SAMPLE_BM4_DSp2_5781_S16.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM4_DSp2_5781_S16.multi-10.bam'
'SAMPLE_BM5_DSp2_7080_S17.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM5_DSp2_7080_S17.multi-10.bam'
'SAMPLE_BM6_DSp2_7079_S18.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM6_DSp2_7079_S18.multi-10.bam'
'SAMPLE_BM7_DSp24_5781_S19.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM7_DSp24_5781_S19.multi-10.bam'
'SAMPLE_BM8_DSp24_7080_S20.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM8_DSp24_7080_S20.multi-10.bam'
'SAMPLE_BM9_DSp24_7079_S21.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_BM9_DSp24_7079_S21.multi-10.bam'
'SAMPLE_Bp10_DSp48_5782_S10.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp10_DSp48_5782_S10.multi-10.bam'
'SAMPLE_Bp11_DSp48_7081_S11.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp11_DSp48_7081_S11.multi-10.bam'
'SAMPLE_Bp12_DSp48_7078_S12.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp12_DSp48_7078_S12.multi-10.bam'
'SAMPLE_Bp1_DSm2_5782_S1.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp1_DSm2_5782_S1.multi-10.bam'
'SAMPLE_Bp2_DSm2_7081_S2.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp2_DSm2_7081_S2.multi-10.bam'
'SAMPLE_Bp3_DSm2_7078_S3.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp3_DSm2_7078_S3.multi-10.bam'
'SAMPLE_Bp4_DSp2_5782_S4.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp4_DSp2_5782_S4.multi-10.bam'
'SAMPLE_Bp5_DSp2_7081_S5.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp5_DSp2_7081_S5.multi-10.bam'
'SAMPLE_Bp6_DSp2_7078_S6.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp6_DSp2_7078_S6.multi-10.bam'
'SAMPLE_Bp7_DSp24_5782_S7.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp7_DSp24_5782_S7.multi-10.bam'
'SAMPLE_Bp8_DSp24_7081_S8.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp8_DSp24_7081_S8.multi-10.bam'
'SAMPLE_Bp9_DSp24_7078_S9.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'SAMPLE_Bp9_DSp24_7078_S9.multi-10.bam'
'Sample_CT10_7718_pIAA_Q_Nascent_S5.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.bam'
'Sample_CT10_7718_pIAA_Q_SteadyState_S10.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.bam'
'Sample_CT2_6125_pIAA_Q_Nascent_S1.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.bam'
'Sample_CT2_6125_pIAA_Q_SteadyState_S6.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.bam'
'Sample_CT4_6126_pIAA_Q_Nascent_S2.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.bam'
'Sample_CT4_6126_pIAA_Q_SteadyState_S7.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.bam'
'Sample_CT6_7714_pIAA_Q_Nascent_S3.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.bam'
'Sample_CT6_7714_pIAA_Q_SteadyState_S8.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.bam'
'Sample_CT8_7716_pIAA_Q_Nascent_S4.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.bam'
'Sample_CT8_7716_pIAA_Q_SteadyState_S9.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.bam'
'Sample_CU11_5782_Q_Nascent_S11.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CU11_5782_Q_Nascent_S11.multi-10.bam'
'Sample_CU12_5782_Q_SteadyState_S12.Aligned.sortedByCoord.multi-10.bam' would be renamed to 'Sample_CU12_5782_Q_SteadyState_S12.multi-10.bam'
```
</details>
<br />

<a id="check-on-logout-warning-messages-warning-not-enough-space-allocated-for-transcript"></a>
#### Check on `*.Log.out` warning messages: "`WARNING: not enough space allocated for transcript.`"
<a id="notes-1"></a>
##### Notes
<details>
<summary><i>Notes: Check on *.Log.out warning messages: "WARNING: not enough space allocated for transcript."</i></summary>

In the `*.Log.out` files, we see a small number of warning messages, e.g., in "`SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.out`",
```txt
WARNING: not enough space allocated for transcript. Did not process all windows for read VH00699:36:AAAWYTFM5:1:1207:18572:48177
   SOLUTION: increase alignTranscriptsPerReadNmax and re-run
```

What does this mean? The answer from Alex Dobin, author of `STAR`, is [here](https://groups.google.com/g/rna-star/c/Bp2LoGbg09s/m/n5m5_gZNAgAJ):
> STAR preallocates memory for `alignTranscriptsPerReadNmax=10000` (by default) different alignments (transcripts) for each read.
> 
> If the actual number of possible alignments exceeds this value, the warning is issued.
> 
> Most likely, the reads with such a large number of possible alignments will have too many top alignments, and so will end up mapping to too many loci and will be discarded as multimappers.
</details>
<br />

<a id="code-19"></a>
##### Code
<details>
<summary><i>Code: Check on *.Log.out warning messages: "WARNING: not enough space allocated for transcript."</i></summary>

<a id="code-for-bamsunmapped-rmsc_kl_20s"></a>
###### Code for `bams/unmapped-rm/SC_KL_20S`...
```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && cd results/2023-0115
cd bams/unmapped-rm/SC_KL_20S
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams/unmapped-rm/SC_KL_20S

if [[ -f warnings-alignTranscriptsPerReadNmax.txt ]]; then
    rm warnings_alignTranscriptsPerReadNmax.txt
fi
touch warnings_alignTranscriptsPerReadNmax.txt

for i in *.Log.out; do
    tally="$(\
        grep "WARNING: not enough space allocated for transcript" "${i}" \
            | wc -l\
    )"
    echo -e "${i}\t${tally}" >> warnings_alignTranscriptsPerReadNmax.txt
    # echo ""
done
# cat warnings_alignTranscriptsPerReadNmax.txt
```

<a id="code-for-bamsunmapped-wsc_kl_20s"></a>
###### Code for `bams/unmapped-w/SC_KL_20S`...
```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && cd results/2023-0115
cd bams/unmapped-w/SC_KL_20S
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams/unmapped-w/SC_KL_20S

if [[ -f warnings-alignTranscriptsPerReadNmax.txt ]]; then
    rm warnings_alignTranscriptsPerReadNmax.txt
fi
touch warnings_alignTranscriptsPerReadNmax.txt

for i in *.Log.out; do
    tally="$(\
        grep "WARNING: not enough space allocated for transcript" "${i}" \
            | wc -l\
    )"
    echo -e "${i}\t${tally}" >> warnings_alignTranscriptsPerReadNmax.txt
    # echo ""
done
# cat warnings_alignTranscriptsPerReadNmax.txt
```
</details>
<br />

<a id="printed-9"></a>
##### Printed
<details>
<summary><i>Printed: Check on *.Log.out warning messages: "WARNING: not enough space allocated for transcript."</i></summary>

<a id="printed-for-bamsunmapped-rmsc_kl_20s"></a>
###### Printed for `bams/unmapped-rm/SC_KL_20S`...
```txt
❯ cat warnings_alignTranscriptsPerReadNmax.txt
5781_G1_IN_S5.multi-10.Log.out    0
5781_G1_IP_S1.multi-10.Log.out    0
5781_Q_IN_S6.multi-10.Log.out    0
5781_Q_IP_S2.multi-10.Log.out    0
5782_G1_IN_S7.multi-10.Log.out    0
5782_G1_IP_S3.multi-10.Log.out    0
5782_Q_IN_S8.multi-10.Log.out    1
5782_Q_IP_S4.multi-10.Log.out    0
CW10_7747_8day_Q_IN_S5.multi-10.Log.out    3
CW10_7747_8day_Q_PD_S11.multi-10.Log.out    0
CW12_7748_8day_Q_IN_S6.multi-10.Log.out    1
CW12_7748_8day_Q_PD_S12.multi-10.Log.out    3
CW2_5781_8day_Q_IN_S1.multi-10.Log.out    0
CW2_5781_8day_Q_PD_S7.multi-10.Log.out    1
CW4_5782_8day_Q_IN_S2.multi-10.Log.out    5
CW4_5782_8day_Q_PD_S8.multi-10.Log.out    6
CW6_7078_8day_Q_IN_S3.multi-10.Log.out    4
CW6_7078_8day_Q_PD_S9.multi-10.Log.out    4
CW8_7079_8day_Q_IN_S4.multi-10.Log.out    0
CW8_7079_8day_Q_PD_S10.multi-10.Log.out    1
SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.out    1
SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.out    1
SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.out    2
SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.out    0
SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.out    0
SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.out    0
SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.out    1
SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.out    0
SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.out    0
SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.out    2
SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.out    4
SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.out    1
SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.out    2
SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.out    0
SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.out    2
SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.out    3
SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.out    1
SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.out    0
SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.out    1
SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.out    1
SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.out    4
SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.out    1
SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.out    0
Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.out    3
Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.out    6
Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.out    9
Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.out    3
Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.out    6
Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.out    5
Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.out    2
Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.out    6
Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.out    6
Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.out    9
Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.out    4
Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.out    4
```

<a id="printed-for-bamsunmapped-wsc_kl_20s"></a>
###### Printed for `bams/unmapped-w/SC_KL_20S`...
```txt
❯ cat warnings_alignTranscriptsPerReadNmax.txt
5781_G1_IN_S5.multi-10.Log.out    0
5781_G1_IP_S1.multi-10.Log.out    0
5781_Q_IN_S6.multi-10.Log.out    0
5781_Q_IP_S2.multi-10.Log.out    0
5782_G1_IN_S7.multi-10.Log.out    0
5782_G1_IP_S3.multi-10.Log.out    0
5782_Q_IN_S8.multi-10.Log.out    1
5782_Q_IP_S4.multi-10.Log.out    0
CW10_7747_8day_Q_IN_S5.multi-10.Log.out    3
CW10_7747_8day_Q_PD_S11.multi-10.Log.out    0
CW12_7748_8day_Q_IN_S6.multi-10.Log.out    1
CW12_7748_8day_Q_PD_S12.multi-10.Log.out    3
CW2_5781_8day_Q_IN_S1.multi-10.Log.out    0
CW2_5781_8day_Q_PD_S7.multi-10.Log.out    1
CW4_5782_8day_Q_IN_S2.multi-10.Log.out    5
CW4_5782_8day_Q_PD_S8.multi-10.Log.out    6
CW6_7078_8day_Q_IN_S3.multi-10.Log.out    4
CW6_7078_8day_Q_PD_S9.multi-10.Log.out    4
CW8_7079_8day_Q_IN_S4.multi-10.Log.out    0
CW8_7079_8day_Q_PD_S10.multi-10.Log.out    1
SAMPLE_BM10_DSp48_5781_S22.multi-10.Log.out    1
SAMPLE_BM11_DSp48_7080_S23.multi-10.Log.out    1
SAMPLE_BM1_DSm2_5781_S13.multi-10.Log.out    2
SAMPLE_BM2_DSm2_7080_S14.multi-10.Log.out    0
SAMPLE_BM3_DSm2_7079_S15.multi-10.Log.out    0
SAMPLE_BM4_DSp2_5781_S16.multi-10.Log.out    0
SAMPLE_BM5_DSp2_7080_S17.multi-10.Log.out    1
SAMPLE_BM6_DSp2_7079_S18.multi-10.Log.out    0
SAMPLE_BM7_DSp24_5781_S19.multi-10.Log.out    0
SAMPLE_BM8_DSp24_7080_S20.multi-10.Log.out    2
SAMPLE_BM9_DSp24_7079_S21.multi-10.Log.out    4
SAMPLE_Bp10_DSp48_5782_S10.multi-10.Log.out    1
SAMPLE_Bp11_DSp48_7081_S11.multi-10.Log.out    2
SAMPLE_Bp12_DSp48_7078_S12.multi-10.Log.out    0
SAMPLE_Bp1_DSm2_5782_S1.multi-10.Log.out    2
SAMPLE_Bp2_DSm2_7081_S2.multi-10.Log.out    3
SAMPLE_Bp3_DSm2_7078_S3.multi-10.Log.out    1
SAMPLE_Bp4_DSp2_5782_S4.multi-10.Log.out    0
SAMPLE_Bp5_DSp2_7081_S5.multi-10.Log.out    1
SAMPLE_Bp6_DSp2_7078_S6.multi-10.Log.out    1
SAMPLE_Bp7_DSp24_5782_S7.multi-10.Log.out    4
SAMPLE_Bp8_DSp24_7081_S8.multi-10.Log.out    1
SAMPLE_Bp9_DSp24_7078_S9.multi-10.Log.out    0
Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.Log.out    3
Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.Log.out    6
Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.Log.out    9
Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.Log.out    3
Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.Log.out    6
Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.Log.out    5
Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.Log.out    2
Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.Log.out    6
Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.Log.out    6
Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.Log.out    9
Sample_CU11_5782_Q_Nascent_S11.multi-10.Log.out    4
Sample_CU12_5782_Q_SteadyState_S12.multi-10.Log.out    4
```
</details>
<br />

<a id="isolate-examine-problematic-reads"></a>
### Isolate, examine problematic reads
`#HERE` `#DEKHO`
<a id="rough-draft-work"></a>
#### Rough draft work
<a id="notes-code"></a>
##### Notes, code
<details>
<summary><i>Notes, code: Rough draft work</i></summary>

- `-f INT`   only include reads with all bits set in `INT` set in `FLAG` `[0]`
- `-F INT`   only include reads with none of the bits set in `INT` set in `FLAG` `[0]`
- i.e., `-f INT`: required flag
- i.e., `-F INT`: filtering flag
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get situated
grabnode  # 4, default settings
Trinity_env

transcriptome && cd results/2023-0115
cd bams/unmapped-w/SC_KL_20S

save="rough-draft-work"  # echo "${save}"
mkdir "${save}"  # ., "${save}"


#  Get bams of interest into an array ---------------------
unset bams
typeset -a bams
bams=(
    "CW6_7078_8day_Q_IN_S3.multi-10.bam"
    "CW6_7078_8day_Q_PD_S9.multi-10.bam"
    "CW8_7079_8day_Q_IN_S4.multi-10.bam"
    "CW8_7079_8day_Q_PD_S10.multi-10.bam"
)
echo_test "${bams[@]}"


#  Check flagstats
for i in "${bams[@]}"; do
    echo "${i}"
    samtools flagstat "${i}"
    echo ""
done


#  Isolate unmapped reads ---------------------------------
for i in "${bams[@]}"; do
    echo "Started: ${i}: Isolate unmapped reads..."
    samtools view -@ "${SLURM_CPUS_ON_NODE}" \
        -h \
        -f 12 \
        "${i}" \
        -b \
            -o "${save}/${i/.bam/.f-12.bam}"
    echo "Completed: ${i}: Isolate unmapped reads..."
    echo ""
done


#  Isolate secondary alignments ---------------------------
for i in "${bams[@]}"; do
    echo "Started: ${i}: Isolate secondary alignments..."
    samtools view -@ "${SLURM_CPUS_ON_NODE}" \
        -h \
        -f 256 \
        "${i}" \
        -b \
            -o "${save}/${i/.bam/.f-256.bam}"
    echo "Completed: ${i}: Isolate secondary alignments..."
    echo ""
done


#  Extract reads that didn’t map properly as pairs --------
#+ - novocraft.com/documentation/novoalign-2/novoalign-ngs-quick-start-tutorial/1040-2/
#+ - gist.github.com/darencard/72ddd9e6c08aaff5ff64ca512a04a6dd
for i in "${bams[@]}"; do
    echo "Started: ${i}: Extract reads that didn’t map properly as pairs..."
    # R1 unmapped, R2 mapped
    samtools view -@ "${SLURM_CPUS_ON_NODE}" \
        -h \
        -f 4 \
        -F 264 \
        "${i}" \
        -b \
            -o "${save}/${i/.bam/.f-4.F-264.bam}"

    # R1 mapped, R2 unmapped
    samtools view -@ "${SLURM_CPUS_ON_NODE}" \
        -h \
        -f 8 \
        -F 260 \
        "${i}" \
        -b \
            -o "${save}/${i/.bam/.f-8.F-260.bam}"

    # R1 & R2 unmapped
    samtools view -@ "${SLURM_CPUS_ON_NODE}" \
        -h \
        -f 12 \
        -F 256 \
        "${i}" \
        -b \
            -o "${save}/${i/.bam/.f-12.F-256.bam}"
    echo "Completed: ${i}: Extract reads that didn’t map properly as pairs..."
    echo ""
done

#  Merge bams fr/extracting reads that didn't map properly as pairs
for i in "${bams[@]}"; do
    echo "Started: ${i}: Merge bams fr/extracting reads that didn't map properly as pairs..."
    samtools merge -@ "${SLURM_CPUS_ON_NODE}" \
        "${save}/${i/.bam/.f-4-8-12.F-264-260-256.bam}" \
        "${save}/${i/.bam/.f-4.F-264.bam}" \
        "${save}/${i/.bam/.f-8.F-260.bam}" \
        "${save}/${i/.bam/.f-12.F-256.bam}"
    echo "Completed: ${i}: Merge bams fr/extracting reads that didn't map properly as pairs..."
    echo ""
done

#  Clean up outfiles fr/the preceding two loops
mkdir -p "${save}/f-4-8-12.F-264-260-256"
mv \
    "${save}/"*{f-4.F-264,f-8.F-260,f-12.F-256,f-4-8-12.F-264-260-256}".bam" \
    "${save}/f-4-8-12.F-264-260-256"

#  Extract valid alignments while excluding invalid alignments ----------------
#  i.e., select for alignments that are 'paired' and 'mapped in a proper pair'
#+ (=3) while filtering out alignments that are 'unmapped', the 'mate is
#+ unmapped', and 'not primary alignment' (=268)
for i in "${bams[@]}"; do
    echo "Started: ${i}:"
    echo "    Extract valid alignments while excluding invalid alignments..."
    samtools view -@ "${SLURM_CPUS_ON_NODE}" \
        -h \
        -f 3 \
        -F 268 \
        "${i}" \
        -b \
            -o "${save}/${i/.bam/.f-3.F-268.bam}"
    echo "Completed: ${i}:"
    echo "    Extract valid alignments while excluding invalid alignments..."
    echo ""
done
```
`#PICKUPHERE`
</details>
<br />

<a id="printed-10"></a>
##### Printed
<details>
<summary><i>Printed: Rough draft work</i></summary>

```txt
❯ mkdir rough-draft-work/
mkdir: created directory 'rough-draft-work/'


❯ for i in "${bams[@]}"; do
>     echo "${i}"
>     samtools flagstat "${i}"
>     echo ""
> done
CW6_7078_8day_Q_IN_S3.multi-10.bam
200921342 + 0 in total (QC-passed reads + QC-failed reads)
93869180 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
198276812 + 0 mapped (98.68% : N/A)
107052162 + 0 paired in sequencing
53526081 + 0 read1
53526081 + 0 read2
104407632 + 0 properly paired (97.53% : N/A)
104407632 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

CW6_7078_8day_Q_PD_S9.multi-10.bam
111427434 + 0 in total (QC-passed reads + QC-failed reads)
29292956 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
107328954 + 0 mapped (96.32% : N/A)
82134478 + 0 paired in sequencing
41067239 + 0 read1
41067239 + 0 read2
78035998 + 0 properly paired (95.01% : N/A)
78035998 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

CW8_7079_8day_Q_IN_S4.multi-10.bam
127670524 + 0 in total (QC-passed reads + QC-failed reads)
41870716 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
124242164 + 0 mapped (97.31% : N/A)
85799808 + 0 paired in sequencing
42899904 + 0 read1
42899904 + 0 read2
82371448 + 0 properly paired (96.00% : N/A)
82371448 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

CW8_7079_8day_Q_PD_S10.multi-10.bam
108690214 + 0 in total (QC-passed reads + QC-failed reads)
28651384 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
103710152 + 0 mapped (95.42% : N/A)
80038830 + 0 paired in sequencing
40019415 + 0 read1
40019415 + 0 read2
75058768 + 0 properly paired (93.78% : N/A)
75058768 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)


❯ for i in "${bams[@]}"; do
>     echo "Started: ${i}: Isolate unmapped reads..."
>     samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>         -h \
>         -f 12 \
>         "${i}" \
>         -b \
>             -o "${save}/${i/.bam/.f-12.bam}"
>     echo "Completed: ${i}: Isolate unmapped reads..."
>     echo ""
> done
Started: CW6_7078_8day_Q_IN_S3.multi-10.bam: Isolate unmapped reads...
Completed: CW6_7078_8day_Q_IN_S3.multi-10.bam: Isolate unmapped reads...

Started: CW6_7078_8day_Q_PD_S9.multi-10.bam: Isolate unmapped reads...
Completed: CW6_7078_8day_Q_PD_S9.multi-10.bam: Isolate unmapped reads...

Started: CW8_7079_8day_Q_IN_S4.multi-10.bam: Isolate unmapped reads...
Completed: CW8_7079_8day_Q_IN_S4.multi-10.bam: Isolate unmapped reads...

Started: CW8_7079_8day_Q_PD_S10.multi-10.bam: Isolate unmapped reads...
Completed: CW8_7079_8day_Q_PD_S10.multi-10.bam: Isolate unmapped reads...



❯ for i in "${bams[@]}"; do
>     echo "Started: ${i}: Isolate secondary alignments..."
>     samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>         -h \
>         -f 256 \
>         "${i}" \
>         -b \
>             -o "${save}/${i/.bam/.f-256.bam}"
>     echo "Completed: ${i}: Isolate secondary alignments..."
>     echo ""
> done
Started: CW6_7078_8day_Q_IN_S3.multi-10.bam: Isolate secondary reads...
Completed: CW6_7078_8day_Q_IN_S3.multi-10.bam: Isolate secondary reads...

Started: CW6_7078_8day_Q_PD_S9.multi-10.bam: Isolate secondary reads...
Completed: CW6_7078_8day_Q_PD_S9.multi-10.bam: Isolate secondary reads...

Started: CW8_7079_8day_Q_IN_S4.multi-10.bam: Isolate secondary reads...
Completed: CW8_7079_8day_Q_IN_S4.multi-10.bam: Isolate secondary reads...

Started: CW8_7079_8day_Q_PD_S10.multi-10.bam: Isolate secondary reads...
Completed: CW8_7079_8day_Q_PD_S10.multi-10.bam: Isolate secondary reads...


❯ for i in "${bams[@]}"; do
>     echo "Started: ${i}: Extract reads that didn’t map properly as pairs..."
>     # R1 unmapped, R2 mapped
>     samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>         -h \
>         -f 4 \
>         -F 264 \
>         "${i}" \
>         -b \
>             -o "${save}/${i/.bam/.f-4.F-264.bam}"
> 
>     # R1 mapped, R2 unmapped
>     samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>         -h \
>         -f 8 \
>         -F 260 \
>         "${i}" \
>         -b \
>             -o "${save}/${i/.bam/.f-8.F-260.bam}"
> 
>     # R1 & R2 unmapped
>     samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>         -h \
>         -f 12 \
>         -F 256 \
>         "${i}" \
>         -b \
>             -o "${save}/${i/.bam/.f-12.F-256.bam}"
>     echo "Completed: ${i}: Extract reads that didn’t map properly as pairs..."
>     echo ""
> done
Started: CW6_7078_8day_Q_IN_S3.multi-10.bam: Extract reads that didn’t map properly as pairs...
Completed: CW6_7078_8day_Q_IN_S3.multi-10.bam: Extract reads that didn’t map properly as pairs...

Started: CW6_7078_8day_Q_PD_S9.multi-10.bam: Extract reads that didn’t map properly as pairs...
Completed: CW6_7078_8day_Q_PD_S9.multi-10.bam: Extract reads that didn’t map properly as pairs...

Started: CW8_7079_8day_Q_IN_S4.multi-10.bam: Extract reads that didn’t map properly as pairs...
Completed: CW8_7079_8day_Q_IN_S4.multi-10.bam: Extract reads that didn’t map properly as pairs...

Started: CW8_7079_8day_Q_PD_S10.multi-10.bam: Extract reads that didn’t map properly as pairs...
Completed: CW8_7079_8day_Q_PD_S10.multi-10.bam: Extract reads that didn’t map properly as pairs...


❯ for i in "${bams[@]}"; do
>     echo "Started: ${i}: Merge bams fr/extracting reads that didn't map properly as pairs..."
>     samtools merge -@ "${SLURM_CPUS_ON_NODE}" \
>         "${save}/${i/.bam/.f-4-8-12.F-264-260-256.bam}" \
>         "${save}/${i/.bam/.f-4.F-264.bam}" \
>         "${save}/${i/.bam/.f-8.F-260.bam}" \
>         "${save}/${i/.bam/.f-12.F-256.bam}"
>     echo "Completed: ${i}: Merge bams fr/extracting reads that didn't map properly as pairs..."
>     echo ""
> done
Started: CW6_7078_8day_Q_IN_S3.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...
Completed: CW6_7078_8day_Q_IN_S3.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...

Started: CW6_7078_8day_Q_PD_S9.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...
Completed: CW6_7078_8day_Q_PD_S9.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...

Started: CW8_7079_8day_Q_IN_S4.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...
Completed: CW8_7079_8day_Q_IN_S4.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...

Started: CW8_7079_8day_Q_PD_S10.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...
Completed: CW8_7079_8day_Q_PD_S10.multi-10.bam: Merge bams fr/extracting reads that didn't map properly as pairs...


❯ mkdir -p "${save}/f-4-8-12.F-264-260-256"
mkdir: created directory 'rough-draft-work/f-4-8-12.F-264-260-256'


❯ mv \
>     "${save}/"*{f-4.F-264,f-8.F-260,f-12.F-256,f-4-8-12.F-264-260-256}".bam" \
>     "${save}/f-4-8-12.F-264-260-256"
renamed 'rough-draft-work/CW6_7078_8day_Q_IN_S3.multi-10.f-4.F-264.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_IN_S3.multi-10.f-4.F-264.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_PD_S9.multi-10.f-4.F-264.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_PD_S9.multi-10.f-4.F-264.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_IN_S4.multi-10.f-4.F-264.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_IN_S4.multi-10.f-4.F-264.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_PD_S10.multi-10.f-4.F-264.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_PD_S10.multi-10.f-4.F-264.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_IN_S3.multi-10.f-8.F-260.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_IN_S3.multi-10.f-8.F-260.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_PD_S9.multi-10.f-8.F-260.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_PD_S9.multi-10.f-8.F-260.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_IN_S4.multi-10.f-8.F-260.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_IN_S4.multi-10.f-8.F-260.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_PD_S10.multi-10.f-8.F-260.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_PD_S10.multi-10.f-8.F-260.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_IN_S3.multi-10.f-12.F-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_IN_S3.multi-10.f-12.F-256.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_PD_S9.multi-10.f-12.F-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_PD_S9.multi-10.f-12.F-256.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_IN_S4.multi-10.f-12.F-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_IN_S4.multi-10.f-12.F-256.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_PD_S10.multi-10.f-12.F-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_PD_S10.multi-10.f-12.F-256.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_IN_S3.multi-10.f-4-8-12.F-264-260-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_IN_S3.multi-10.f-4-8-12.F-264-260-256.bam'
renamed 'rough-draft-work/CW6_7078_8day_Q_PD_S9.multi-10.f-4-8-12.F-264-260-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW6_7078_8day_Q_PD_S9.multi-10.f-4-8-12.F-264-260-256.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_IN_S4.multi-10.f-4-8-12.F-264-260-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_IN_S4.multi-10.f-4-8-12.F-264-260-256.bam'
renamed 'rough-draft-work/CW8_7079_8day_Q_PD_S10.multi-10.f-4-8-12.F-264-260-256.bam' -> 'rough-draft-work/f-4-8-12.F-264-260-256/CW8_7079_8day_Q_PD_S10.multi-10.f-4-8-12.F-264-260-256.bam'


❯ for i in "${bams[@]}"; do
>     echo "Started: ${i}:"
>     echo "    Extract valid alignments while excluding invalid alignments..."
>     samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>         -h \
>         -f 3 \
>         -F 268 \
>         "${i}" \
>         -b \
>             -o "${save}/${i/.bam/.f-3.F-268.bam}"
>     echo "Completed: ${i}:"
>     echo "    Extract valid alignments while excluding invalid alignments..."
>     echo ""
> done
Started: CW6_7078_8day_Q_IN_S3.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...
Completed: CW6_7078_8day_Q_IN_S3.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...

Started: CW6_7078_8day_Q_PD_S9.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...
Completed: CW6_7078_8day_Q_PD_S9.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...

Started: CW8_7079_8day_Q_IN_S4.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...
Completed: CW8_7079_8day_Q_IN_S4.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...

Started: CW8_7079_8day_Q_PD_S10.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...
Completed: CW8_7079_8day_Q_PD_S10.multi-10.bam:
    Extract valid alignments while excluding invalid alignments...
```
</details>
<br />

<a id="index-the-bams"></a>
### Index the `bam`s
<a id="get-situated-4"></a>
#### Get situated
<a id="code-20"></a>
##### Code
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
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }
```
</details>
<br />

<a id="set-up-necessary-variables-get-bams-of-interest-into-an-array"></a>
#### Set up necessary variables, get `bam`s of interest into an array
<a id="code-21"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, get bams of interest into an array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Variables
script_name="submit_samtools-index.sh"  # echo "${script_name}"
threads=8  # echo "${threads}"

#  Arrays
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY%_R?_001_val_?.fq.gz}" )
done < <(\
    find "./bams/unmapped-rm/SC_KL_20S" \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
# echo_test "${bams[@]}"
# echo "${#bams[@]}"  # 55
```
</details>
<br />

<a id="use-a-heredoc-to-write-the-script-submit_samtools-indexsh"></a>
#### Use a `HEREDOC` to write the script, `submit_samtools-index.sh`
<a id="code-22"></a>
##### Code
<details>
<summary><i>Code: Use a HEREDOC to write the script, submit_samtools-index.sh</i></summary>

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

bam="\${1}"

samtools index -@ "\${SLURM_CPUS_ON_NODE}" "\${bam}"
script
# vi "./sh_err_out/${script_name}"  # :q
```
</details>
<br />

<a id="run-samtools-index-on-each-element-of-bam-array"></a>
#### Run `samtools index` on each element of `bam` array
<a id="code-23"></a>
##### Code
<details>
<summary><i>Code: Run samtools index on each element of bam array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#bams[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "# --------------------------------------"
    echo "   Iteration:  ${i}"
    echo "        File:  ${bams[${i}]}"
    echo "      outdir:  $(dirname "${bams[${i}]}")"
    echo ""

    sbatch "./sh_err_out/${script_name}" "${bams[${i}]}"
    sleep 1  # Slow down rate of job submission

    echo ""
    echo ""
done
```
</details>
<br />

<a id="printed-11"></a>
##### Printed
<details>
<summary><i>Printed: Run samtools index on each element of bam array</i></summary>

```txt
# --------------------------------------
   Iteration:  0
        File:  ./bams/unmapped-rm/SC_KL_20S/5781_G1_IN_S5.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010831

# --------------------------------------
   Iteration:  1
        File:  ./bams/unmapped-rm/SC_KL_20S/5781_G1_IP_S1.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010832

# --------------------------------------
   Iteration:  2
        File:  ./bams/unmapped-rm/SC_KL_20S/5781_Q_IN_S6.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010833

# --------------------------------------
   Iteration:  3
        File:  ./bams/unmapped-rm/SC_KL_20S/5781_Q_IP_S2.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010834

# --------------------------------------
   Iteration:  4
        File:  ./bams/unmapped-rm/SC_KL_20S/5782_G1_IN_S7.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010835

# --------------------------------------
   Iteration:  5
        File:  ./bams/unmapped-rm/SC_KL_20S/5782_G1_IP_S3.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010836

# --------------------------------------
   Iteration:  6
        File:  ./bams/unmapped-rm/SC_KL_20S/5782_Q_IN_S8.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010837

# --------------------------------------
   Iteration:  7
        File:  ./bams/unmapped-rm/SC_KL_20S/5782_Q_IP_S4.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010838

# --------------------------------------
   Iteration:  8
        File:  ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010839

# --------------------------------------
   Iteration:  9
        File:  ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_PD_S11.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010840

# --------------------------------------
   Iteration:  10
        File:  ./bams/unmapped-rm/SC_KL_20S/CW12_7748_8day_Q_IN_S6.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010841

# --------------------------------------
   Iteration:  11
        File:  ./bams/unmapped-rm/SC_KL_20S/CW12_7748_8day_Q_PD_S12.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010842

# --------------------------------------
   Iteration:  12
        File:  ./bams/unmapped-rm/SC_KL_20S/CW2_5781_8day_Q_IN_S1.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010843

# --------------------------------------
   Iteration:  13
        File:  ./bams/unmapped-rm/SC_KL_20S/CW2_5781_8day_Q_PD_S7.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010844

# --------------------------------------
   Iteration:  14
        File:  ./bams/unmapped-rm/SC_KL_20S/CW4_5782_8day_Q_IN_S2.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010845

# --------------------------------------
   Iteration:  15
        File:  ./bams/unmapped-rm/SC_KL_20S/CW4_5782_8day_Q_PD_S8.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010846

# --------------------------------------
   Iteration:  16
        File:  ./bams/unmapped-rm/SC_KL_20S/CW6_7078_8day_Q_IN_S3.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010847

# --------------------------------------
   Iteration:  17
        File:  ./bams/unmapped-rm/SC_KL_20S/CW6_7078_8day_Q_PD_S9.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010848

# --------------------------------------
   Iteration:  18
        File:  ./bams/unmapped-rm/SC_KL_20S/CW8_7079_8day_Q_IN_S4.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010849

# --------------------------------------
   Iteration:  19
        File:  ./bams/unmapped-rm/SC_KL_20S/CW8_7079_8day_Q_PD_S10.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010850

# --------------------------------------
   Iteration:  20
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM10_DSp48_5781_S22.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010851

# --------------------------------------
   Iteration:  21
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM11_DSp48_7080_S23.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010852

# --------------------------------------
   Iteration:  22
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM1_DSm2_5781_S13.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010853

# --------------------------------------
   Iteration:  23
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM2_DSm2_7080_S14.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010854

# --------------------------------------
   Iteration:  24
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM3_DSm2_7079_S15.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010855

# --------------------------------------
   Iteration:  25
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM4_DSp2_5781_S16.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010856

# --------------------------------------
   Iteration:  26
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM5_DSp2_7080_S17.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010857

# --------------------------------------
   Iteration:  27
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM6_DSp2_7079_S18.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010858

# --------------------------------------
   Iteration:  28
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM7_DSp24_5781_S19.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010859

# --------------------------------------
   Iteration:  29
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM8_DSp24_7080_S20.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010860

# --------------------------------------
   Iteration:  30
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_BM9_DSp24_7079_S21.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010861

# --------------------------------------
   Iteration:  31
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp10_DSp48_5782_S10.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010862

# --------------------------------------
   Iteration:  32
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp11_DSp48_7081_S11.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010863

# --------------------------------------
   Iteration:  33
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp12_DSp48_7078_S12.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010864

# --------------------------------------
   Iteration:  34
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp1_DSm2_5782_S1.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010865

# --------------------------------------
   Iteration:  35
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp2_DSm2_7081_S2.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010866

# --------------------------------------
   Iteration:  36
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp3_DSm2_7078_S3.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010867

# --------------------------------------
   Iteration:  37
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp4_DSp2_5782_S4.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010868

# --------------------------------------
   Iteration:  38
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp5_DSp2_7081_S5.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010869

# --------------------------------------
   Iteration:  39
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp6_DSp2_7078_S6.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010870

# --------------------------------------
   Iteration:  40
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp7_DSp24_5782_S7.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010871

# --------------------------------------
   Iteration:  41
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp8_DSp24_7081_S8.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010872

# --------------------------------------
   Iteration:  42
        File:  ./bams/unmapped-rm/SC_KL_20S/SAMPLE_Bp9_DSp24_7078_S9.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010873

# --------------------------------------
   Iteration:  43
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT10_7718_pIAA_Q_Nascent_S5.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010874

# --------------------------------------
   Iteration:  44
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT10_7718_pIAA_Q_SteadyState_S10.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010875

# --------------------------------------
   Iteration:  45
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT2_6125_pIAA_Q_Nascent_S1.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010876

# --------------------------------------
   Iteration:  46
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT2_6125_pIAA_Q_SteadyState_S6.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010877

# --------------------------------------
   Iteration:  47
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT4_6126_pIAA_Q_Nascent_S2.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010878

# --------------------------------------
   Iteration:  48
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT4_6126_pIAA_Q_SteadyState_S7.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010879

# --------------------------------------
   Iteration:  49
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT6_7714_pIAA_Q_Nascent_S3.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010880

# --------------------------------------
   Iteration:  50
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT6_7714_pIAA_Q_SteadyState_S8.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010881

# --------------------------------------
   Iteration:  51
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT8_7716_pIAA_Q_Nascent_S4.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010882

# --------------------------------------
   Iteration:  52
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CT8_7716_pIAA_Q_SteadyState_S9.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010883

# --------------------------------------
   Iteration:  53
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CU11_5782_Q_Nascent_S11.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010884

# --------------------------------------
   Iteration:  54
        File:  ./bams/unmapped-rm/SC_KL_20S/Sample_CU12_5782_Q_SteadyState_S12.multi-10.bam
      outdir:  ./bams/unmapped-rm/SC_KL_20S

Submitted batch job 8010885
```
</details>
<br />

<a id="create-bams-composed-of-alignments-to-specific-species"></a>
### Create `bam`s composed of alignments to specific species
`#DEKHO`
<a id="get-situated-5"></a>
#### Get situated
<a id="code-notes"></a>
##### Code, notes
<details>
<summary><i>Code, notes: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

#  Get on a node, etc. if necessary
grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
    {
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

if [[ ! -d "./bams" ]]; then
    mkdir -p bams/{unmapped-rm,unmapped-w}/{SC_KL_20S,SC,SC_KL,KL,20S}
fi
```

In November of 2022, I wrote two dedicated scripts for splitting bam by species, `split_bam_by_species.sh` and `functions.sh`

Access and these scripts from `$(pwd)` (`~/path/to/2022_transcriptome-construction/results/2023-0115`)
```bash
#!/bin/bash
#DONTRUN

., ../../bin
# ...

bash ../../bin/split_bam_by_species.sh
# vi ../../bin/split_bam_by_species.sh  # :q
```
</details>
<br />

<a id="printed-12"></a>
##### Printed
<details>
<summary><i>Printed: Get situated</i></summary>

```txt
❯ bash ../../bin/split_bam_by_species.sh
split_bam_by_species.sh
-----------------------
Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
and 20 S narnavirus, and split them into distinct .bam files for each species,
with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
including chromosome M, all S. cerevisiae including chromosome M, and S.
cerevisiae chromosome M only.

Names of chromosomes in .bam infiles must be in the following format:
  - S. cerevisiae (SC)
    - I
    - II
    - III
    - IV
    - V
    - VI
    - VII
    - VIII
    - IX
    - X
    - XI
    - XII
    - XIII
    - XIV
    - XV
    - XVI
    - Mito

  - K. lactis (KL)
    - A
    - B
    - C
    - D
    - E

  - 20 S narnavirus
    - 20S

The split .bam files are saved to a user-defined out directory.

Dependencies:
  - samtools >= #TBD

Arguments:
  -h  print this help message and exit
  -u  use safe mode: "TRUE" or "FALSE" <lgl; default: FALSE>
  -i  bam infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -s  what to split out; options: SC_all, SC_no_Mito, SC_VII, SC_XII,
      SC_VII_XII, SC_Mito, KL_all, virus_20S <chr; default: SC_all>

            SC_all  return all SC chromosomes, including Mito (default)
        SC_no_Mito  return all SC chromosomes, excluding Mito
            SC_VII  return only SC chromosome VII
            SC_XII  return only SC chromosome XII
        SC_VII_XII  return only SC chromosomes VII and XII
           SC_Mito  return only SC chromosome Mito
            KL_all  return all KL chromosomes
         virus_20S  return only 20 S narnavirus

  -t  number of threads <int >= 1; default: 1>
```
</details>
<br />

<a id="trytroubleshoot-a-test-run-with-split_bam_by_speciessh"></a>
#### Try/troubleshoot a test run with `split_bam_by_species.sh`
<a id="code-printed-notes"></a>
##### Code, printed, notes
<details>
<summary><i>Code, printed, notes: Try/troubleshoot a test run with split_bam_by_species.sh</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Initial try
bash ../../bin/split_bam_by_species.sh \
    -i "./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam" \
    -o "./bams" \
    -s "virus_20S" \
    -t 1
# "Safe mode" is FALSE.
# ./bams doesn't exist; mkdir'ing it.
#
#
# Running ../../bin/split_bam_by_species.sh...

#  The script worked in the sense that
#+ CW10_7747_8day_Q_IN_S5.multi-10.virus_20S.bam was generated; however, it was
#+ generated in the "indir", ./bams/unmapped-rm/SC_KL_20S, not ./bams; moreover, a ./bams
#+ directory was neither generated in $(pwd) nor in ./bams/unmapped-rm/SC_KL_20S

#  Try again after editing main() in split_bam_by_species.sh and
#+ check_exists_directory() in functions.sh
bash ../../bin/split_bam_by_species.sh \
    -i "./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam" \
    -o "./bams" \
    -s "KL_all" \
    -t 1
# "Safe mode" is FALSE.
# ./bams doesn't exist; mkdir'ing it.
#
#
# Running ../../bin/split_bam_by_species.sh...

#  Adjust check_exists_directory(), change it to FALSE in the main script
bash ../../bin/split_bam_by_species.sh \
    -i "./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam" \
    -o "./bams" \
    -s "SC_Mito" \
    -t 1
# "Safe mode" is FALSE.
# ./bams doesn't exist; mkdir'ing it.
#
#
# Running ../../bin/split_bam_by_species.sh...

#  After pushing the changes to split_bam_by_species.sh and function.sh (I had
#+ not done that for the previous two tests)
bash ../../bin/split_bam_by_species.sh \
    -i "./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam" \
    -o "./bams" \
    -s "SC_XII" \
    -t 1
# "Safe mode" is FALSE.
#
#
# Running ../../bin/split_bam_by_species.sh...
# [E::hts_open_format] Failed to open file "./bams/./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.SC_XII.bam" : No such file or directory
# samtools view: failed to open "./bams/./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.SC_XII.bam" for writing: No such file or directory

#  When writing the outfile, strip away the path associated with infile
bash ../../bin/split_bam_by_species.sh \
    -i "./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam" \
    -o "./bams" \
    -s "SC_XII" \
    -t 1
# "Safe mode" is FALSE.
#
#
# Running ../../bin/split_bam_by_species.sh...

bash ../../bin/split_bam_by_species.sh \
    -i "./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.bam" \
    -o "./bams" \
    -s "SC_VII" \
    -t 1
# "Safe mode" is FALSE.
#
#
# Running ../../bin/split_bam_by_species.sh...

#  It works!
., bams
# total 24M
# drwxrws--- 7 kalavatt 171 Jan 17 14:20 ./
# drwxrws--- 7 kalavatt 197 Jan 17 14:12 ../
# drwxrws--- 2 kalavatt   0 Jan 16 17:37 20S/
# -rw-rw---- 1 kalavatt 20M Jan 17 14:27 CW10_7747_8day_Q_IN_S5.multi-10.SC_VII.bam
# -rw-rw---- 1 kalavatt 858M Jan 17 14:20 CW10_7747_8day_Q_IN_S5.multi-10.SC_XII.bam
# drwxrws--- 2 kalavatt   0 Jan 16 17:37 KL/
# drwxrws--- 2 kalavatt   0 Jan 16 17:37 SC/
# drwxrws--- 2 kalavatt   0 Jan 16 17:37 SC_KL/
# drwxrws--- 2 kalavatt 20K Jan 17 14:08 SC_KL_20S/

#  Now clean up all of the test bams...
rm ./bams/CW10_7747_8day_Q_IN_S5.multi-10.SC_{VII,XII}.bam
., ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.{SC,KL,virus}*
# -rw-rw---- 1 kalavatt  540M Jan 17 13:59 ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.KL_all.bam
# -rw-rw---- 1 kalavatt   25M Jan 17 14:08 ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.SC_Mito.bam
# -rw-rw---- 1 kalavatt 1022M Jan 17 13:39 ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.virus_20S.bam
rm ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.{SC,KL,virus}*
., ./bams/unmapped-rm/SC_KL_20S/CW10_7747_8day_Q_IN_S5.multi-10.*  # Looks good
```
~~`#TODO` Take some time to fix `split_bam_by_species.sh`~~ *Done.*
</details>
<br />

<a id="submit-jobs-to-make-bams-for-species-specific-alignments"></a>
#### Submit jobs to make `bam`s for species-specific alignments
<a id="set-up-necessary-variables-get-bams-of-interest-into-an-array-1"></a>
##### Set up necessary variables, get `bam`s of interest into an array
<a id="code-24"></a>
###### Code
<details>
<summary><i>Code: Set up necessary variables, get bams of interest into an array </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get on a node, etc. if necessary
grabnode  # 1, default settings
Trinity_env

#  cd into '2022_transcriptome-construction/results', e.g.,
transcriptome && 
    {
        cd "results/2023-0115" || echo "cd'ing failed; check on this..."
    }

#  Variables
script_name="../../bin/split_bam_by_species.sh"  # echo "${script_name}"
threads=4  # echo "${threads}"

#  Arrays
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY%_R?_001_val_?.fq.gz}" )
done < <(\
    find "./bams/unmapped-rm/SC_KL_20S" \
        -type f \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
# echo_test "${bams[@]}"
# echo "${#bams[@]}"  # 55
```
</details>
<br />

<a id="run-split_bam_by_speciessh-on-bams-trial-wsc"></a>
##### Run `split_bam_by_species.sh` on `bam`s: Trial w/"`SC`"
`#PICKUPHERE` `#STILLNEEDTODOTHIS`
<a id="notes-code-1"></a>
###### Notes, code
<details>
<summary><i>Notes, code: Run split_bam_by_species.sh on bams</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

x="${#bams[@]}"  # echo "${x}"
y=$(( x - 1 ))  # echo "${y}"
for (( i=0; i<=y; i++ )); do
    echo "# --------------------------------------"
    echo "   iteration:  ${i}"
    echo "        file:  ${bams[${i}]}"
    echo "      outdir:  ./bams/unmapped-rm/SC"
    echo "       split:  SC_all"
    echo "     threads:  ${threads}"
    echo ""

    sbatch \
        --nodes=1 \
        --cpus-per-task="${threads}" \
        --error="./sh_err_out/err_out/$(basename ${script_name} .sh).%J.err.txt" \
        --output="./sh_err_out/err_out/$(basename ${script_name} .sh).%J.out.txt" \
        "${script_name}" \
            -i "${bams[${i}]}" \
            -o "./bams/unmapped-rm/SC" \
            -s "SC_all" \
            -t "${threads}"

    echo ""
    echo ""
done
```
</details>
<br />

<a id="create-bams-wo-klactis-and-20s-alignments-composed-of-s-cerevisiae"></a>
#### Create `bam`s w/o *K.lactis* and *20S* alignments: composed of *S. cerevisiae*
<a id="code-25"></a>
##### Code
<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
</details>
<br />

<a id="create-bams-wo-s-cerevisiae-and-20s-alignments-composed-of-k-lactis"></a>
#### Create `bam`s w/o *S. cerevisiae* and *20S* alignments: composed of *K. lactis*
<a id="code-26"></a>
##### Code
<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
</details>
<br />

<a id="create-bams-wo-s-cerevisiae-and-k-lactis-alignments-composed-of-20s"></a>
#### Create `bam`s w/o *S. cerevisiae* and *K. lactis* alignments: composed of *20S*
<a id="code-27"></a>
##### Code
<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

```
</details>
<br />

<a id="scraps"></a>
## *Scraps*
<a id="printed-13"></a>
### Printed
<details>
<summary><i>Printed: Mamba installations on my local FHCC machine (2023-0123)</i></summary>

`#TODO` Record this information in the proper location
```txt
#!/bin/bash
#DONTRUN #CONTINUE


❯ Trinity_env


❯ mamba install -c bioconda bioconductor-ramwas
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


Looking for: ['bioconductor-ramwas']

bioconda/osx-64                                      3.8MB @   4.0MB/s  1.0s
bioconda/noarch                                      4.1MB @   3.8MB/s  1.2s
conda-forge/noarch                                  11.0MB @   4.6MB/s  2.6s
conda-forge/osx-64                                  26.4MB @   4.5MB/s  6.6s

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - bioconductor-ramwas
   - ca-certificates
   - certifi
   - openssl


  Package                              Version  Build                 Channel                  Size
─────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  + bioconductor-annotationdbi          1.60.0  r42hdfd78af_0         bioconda/noarch           5MB
  + bioconductor-biobase                2.58.0  r42h3be46a4_0         bioconda/osx-64           3MB
  + bioconductor-biocfilecache           2.6.0  r42hdfd78af_0         bioconda/noarch         596kB
  + bioconductor-biomart                2.54.0  r42hdfd78af_0         bioconda/noarch         926kB
  + bioconductor-delayedarray           0.24.0  r42h3be46a4_0         bioconda/osx-64           3MB
  + bioconductor-genomicalignments      1.34.0  r42h3be46a4_0         bioconda/osx-64           2MB
  + bioconductor-keggrest               1.38.0  r42hdfd78af_0         bioconda/noarch         199kB
  + bioconductor-matrixgenerics         1.10.0  r42hdfd78af_0         bioconda/noarch         353kB
  + bioconductor-ramwas                 1.22.0  r42h3be46a4_0         bioconda/osx-64           4MB
  + bioconductor-summarizedexperiment   1.28.0  r42hdfd78af_0         bioconda/noarch           3MB
  + libllvm13                           13.0.1  h64f94b2_2            conda-forge/osx-64       27MB
  + r-askpass                              1.1  r42h815d134_3         conda-forge/osx-64       29kB
  + r-assertthat                         0.2.1  r42hc72bb7e_3         conda-forge/noarch       73kB
  + r-bit                                4.0.5  r42h815d134_0         conda-forge/osx-64        1MB
  + r-bit64                              4.0.5  r42h815d134_1         conda-forge/osx-64      545kB
  + r-blob                               1.2.3  r42hc72bb7e_1         conda-forge/noarch       66kB
  + r-cachem                             1.0.6  r42h815d134_1         conda-forge/osx-64       74kB
  + r-curl                               4.3.3  r42h815d134_1         conda-forge/osx-64      709kB
  + r-dbi                                1.1.3  r42hc72bb7e_1         conda-forge/noarch      789kB
  + r-dbplyr                             2.3.0  r42hc72bb7e_0         conda-forge/noarch        1MB
  + r-digest                            0.6.31  r42h49197e3_0         conda-forge/osx-64      184kB
  + r-dplyr                             1.0.10  r42h49197e3_1         conda-forge/osx-64        1MB
  + r-ellipsis                           0.3.2  r42h815d134_1         conda-forge/osx-64       42kB
  + r-fansi                              1.0.4  r42h815d134_0         conda-forge/osx-64      309kB
  + r-fastmap                            1.1.0  r42h49197e3_1         conda-forge/osx-64       71kB
  + r-filelock                           1.0.2  r42h815d134_1003      conda-forge/osx-64       30kB
  + r-filematrix                           1.3  r42hc72bb7e_1003      conda-forge/noarch        1MB
  + r-foreach                            1.5.2  r42hc72bb7e_1         conda-forge/noarch      138kB
  + r-generics                           0.1.3  r42hc72bb7e_1         conda-forge/noarch       95kB
  + r-glmnet                             4.1_2  r42h1e4e481_1         conda-forge/osx-64        2MB
  + r-hms                                1.1.2  r42hc72bb7e_1         conda-forge/noarch      110kB
  + r-httr                               1.4.4  r42hc72bb7e_1         conda-forge/noarch      509kB
  + r-iterators                         1.0.14  r42hc72bb7e_1         conda-forge/noarch      359kB
  + r-jsonlite                           1.8.4  r42h815d134_0         conda-forge/osx-64      629kB
  + r-kernsmooth                       2.23_20  r42hc309deb_1         conda-forge/osx-64      101kB
  + r-lattice                          0.20_45  r42h815d134_1         conda-forge/osx-64        1MB
  + r-matrix                             1.5_3  r42hce01bf1_0         conda-forge/osx-64        5MB
  + r-matrixstats                       0.63.0  r42h815d134_0         conda-forge/osx-64      452kB
  + r-memoise                            2.0.1  r42hc72bb7e_1         conda-forge/noarch       59kB
  + r-mime                                0.12  r42h815d134_1         conda-forge/osx-64       52kB
  + r-openssl                            2.0.5  r42hfeb9312_0         conda-forge/osx-64      628kB
  + r-pillar                             1.8.1  r42hc72bb7e_1         conda-forge/noarch      694kB
  + r-pkgconfig                          2.0.3  r42hc72bb7e_2         conda-forge/noarch       27kB
  + r-plogr                              0.2.0  r42hc72bb7e_1004      conda-forge/noarch       21kB
  + r-png                                0.1_8  r42hbf2103b_0         conda-forge/osx-64       57kB
  + r-prettyunits                        1.1.1  r42hc72bb7e_2         conda-forge/noarch       43kB
  + r-progress                           1.2.2  r42hc72bb7e_3         conda-forge/noarch       94kB
  + r-purrr                              1.0.1  r42h815d134_0         conda-forge/osx-64      482kB
  + r-r6                                 2.5.1  r42hc72bb7e_1         conda-forge/noarch       93kB
  + r-rappdirs                           0.3.3  r42h815d134_1         conda-forge/osx-64       52kB
  + r-rsqlite                           2.2.20  r42h49197e3_0         conda-forge/osx-64        1MB
  + r-shape                              1.4.6  r42ha770c72_1         conda-forge/noarch      813kB
  + r-survival                           3.5_0  r42h815d134_0         conda-forge/osx-64        6MB
  + r-sys                                3.4.1  r42h815d134_0         conda-forge/osx-64       48kB
  + r-tibble                             3.1.8  r42h815d134_1         conda-forge/osx-64      716kB
  + r-tidyselect                         1.2.0  r42hbe3e9c8_0         conda-forge/osx-64      222kB
  + r-utf8                               1.2.2  r42h815d134_1         conda-forge/osx-64      162kB
  + r-withr                              2.5.0  r42hc72bb7e_1         conda-forge/noarch      246kB
  + r-xml2                               1.3.3  r42h3576887_2         conda-forge/osx-64      330kB

  Change:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  - cryptography                        38.0.2  py37h1818b49_1        conda-forge
  + cryptography                        38.0.2  py37hbf3704f_1        conda-forge/osx-64     Cached
  - libssh2                             1.10.0  h7535e13_3            conda-forge
  + libssh2                             1.10.0  h47af595_3            conda-forge/osx-64     Cached
  - mysql-common                        8.0.31  h7ebae80_0            conda-forge
  + mysql-common                        8.0.31  hc4b2c72_0            conda-forge/osx-64        2MB
  - mysql-libs                          8.0.31  hc37e033_0            conda-forge
  + mysql-libs                          8.0.31  h8658499_0            conda-forge/osx-64        2MB
  - python                              3.7.12  haf480d7_100_cpython  conda-forge
  + python                              3.7.12  hf3644f1_100_cpython  conda-forge/osx-64     Cached
  - qt-webengine                        5.15.4  h72ca1e5_3            conda-forge
  + qt-webengine                        5.15.4  h1d4dd28_3            conda-forge/osx-64       54MB
  - sigtool                              0.1.3  h57ddcff_0            conda-forge
  + sigtool                              0.1.3  h88f4db0_0            conda-forge/osx-64     Cached

  Upgrade:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  - curl                                7.86.0  h57eb407_1            conda-forge
  + curl                                7.87.0  h6df9250_0            conda-forge/osx-64      141kB
  - gettext                             0.21.0  h7535e17_0            anaconda
  + gettext                             0.21.1  h8a4c099_0            conda-forge/osx-64     Cached
  - glib                                2.74.0  hbc0c0cd_0            conda-forge
  + glib                                2.74.1  hbc0c0cd_1            conda-forge/osx-64      483kB
  - glib-tools                          2.74.0  hbc0c0cd_0            conda-forge
  + glib-tools                          2.74.1  hbc0c0cd_1            conda-forge/osx-64       99kB
  - gst-plugins-base                    1.20.3  h37e1711_2            conda-forge
  + gst-plugins-base                    1.21.3  h37e1711_1            conda-forge/osx-64        2MB
  - gstreamer                           1.20.3  h1d18e73_2            conda-forge
  + gstreamer                           1.21.3  h1d18e73_1            conda-forge/osx-64        2MB
  - harfbuzz                             5.3.0  h08f8713_0            conda-forge
  + harfbuzz                             6.0.0  h08f8713_0            conda-forge/osx-64        1MB
  - krb5                                1.19.3  hb49756b_0            conda-forge
  + krb5                                1.20.1  h049b76e_0            conda-forge/osx-64        1MB
  - libcurl                             7.86.0  h57eb407_1            conda-forge
  + libcurl                             7.87.0  h6df9250_0            conda-forge/osx-64      333kB
  - libglib                             2.74.0  h3ba3332_0            conda-forge
  + libglib                             2.74.1  h4c723e1_1            conda-forge/osx-64        3MB
  - libnghttp2                          1.47.0  h7cbc4dc_1            conda-forge
  + libnghttp2                          1.51.0  he2ab024_0            conda-forge/osx-64      608kB
  - libpq                                 14.5  h4aa9af9_3            conda-forge
  + libpq                                 15.1  h3640bf0_3            conda-forge/osx-64        2MB
  - libxml2                             2.9.14  hea49891_4            conda-forge
  + libxml2                             2.10.3  hb9e07b5_0            conda-forge/osx-64     Cached
  - openssl                             1.1.1s  hfd90126_1            conda-forge
  + openssl                              3.0.7  hfd90126_1            conda-forge/osx-64     Cached
  - pango                              1.50.11  h7fca291_0            conda-forge
  + pango                              1.50.12  hbd9bf65_1            conda-forge/osx-64      412kB
  - pcre2                                10.37  h3f55489_1            conda-forge
  + pcre2                                10.40  h1c4e4bc_0            conda-forge/osx-64        3MB
  - qt                                  5.15.4  hb3ad848_0            conda-forge
  + qt                                  5.15.6  h93fa01e_0            conda-forge/osx-64       17kB
  - qt-main                             5.15.4  h938c29d_2            conda-forge
  + qt-main                             5.15.6  haeff654_6            conda-forge/osx-64       47MB
  - r-base                               4.2.1  he54549f_2            conda-forge
  + r-base                               4.2.2  h6e3643f_2            conda-forge/osx-64       24MB

  Downgrade:
─────────────────────────────────────────────────────────────────────────────────────────────────────

  - libclang                            14.0.6  default_h55ffa42_0    conda-forge
  + libclang                            13.0.1  default_he082bbe_0    conda-forge/osx-64        8MB

  Summary:

  Install: 59 packages
  Change: 7 packages
  Upgrade: 19 packages
  Downgrade: 1 packages

  Total download: 232MB

─────────────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
libnghttp2                                         608.0kB @   8.3MB/s  0.1s
krb5                                                 1.1MB @  12.4MB/s  0.1s
mysql-common                                         2.0MB @  17.5MB/s  0.1s
harfbuzz                                             1.2MB @  10.1MB/s  0.0s
pango                                              411.8kB @   3.0MB/s  0.0s
r-fastmap                                           71.4kB @ 510.9kB/s  0.0s
pcre2                                                2.6MB @  17.5MB/s  0.1s
gstreamer                                            1.8MB @  11.1MB/s  0.0s
r-matrixstats                                      451.9kB @   2.7MB/s  0.0s
r-jsonlite                                         628.6kB @   3.6MB/s  0.0s
r-ellipsis                                          42.1kB @ 239.2kB/s  0.0s
r-curl                                             709.0kB @   3.6MB/s  0.0s
r-cachem                                            73.6kB @ 348.3kB/s  0.0s
r-blob                                              66.4kB @ 268.9kB/s  0.0s
r-assertthat                                        73.2kB @ 259.6kB/s  0.0s
r-r6                                                92.6kB @ 288.3kB/s  0.0s
r-filematrix                                         1.2MB @   2.4MB/s  0.2s
r-filelock                                          29.9kB @  59.3kB/s  0.3s
r-hms                                              110.1kB @ 213.6kB/s  0.0s
r-httr                                             509.2kB @ 937.5kB/s  0.0s
r-tibble                                           715.8kB @   1.2MB/s  0.1s
r-dplyr                                              1.2MB @   1.8MB/s  0.1s
bioconductor-matrixgenerics                        352.7kB @ 499.4kB/s  0.2s
bioconductor-summarizedexperiment                    2.8MB @   3.6MB/s  0.1s
bioconductor-biocfilecache                         596.2kB @ 699.2kB/s  0.1s
libllvm13                                           26.5MB @  30.8MB/s  0.9s
curl                                               141.3kB @ 157.4kB/s  0.0s
libglib                                              3.1MB @   3.4MB/s  0.1s
r-png                                               57.4kB @  61.0kB/s  0.0s
libpq                                                2.3MB @   2.4MB/s  0.1s
r-bit                                                1.2MB @   1.2MB/s  0.1s
r-rappdirs                                          52.0kB @  52.2kB/s  0.0s
r-fansi                                            309.1kB @ 287.7kB/s  0.1s
qt                                                  16.7kB @  15.1kB/s  0.0s
r-pkgconfig                                         26.6kB @  23.5kB/s  0.0s
gst-plugins-base                                     2.4MB @   2.0MB/s  0.2s
r-shape                                            812.9kB @ 678.7kB/s  0.1s
r-memoise                                           59.0kB @  48.8kB/s  0.0s
r-progress                                          94.4kB @  76.7kB/s  0.0s
r-matrix                                             4.6MB @   3.6MB/s  0.3s
r-tidyselect                                       222.0kB @ 177.0kB/s  0.0s
bioconductor-delayedarray                            2.5MB @   1.8MB/s  0.2s
qt-main                                             47.3MB @  33.6MB/s  1.2s
bioconductor-genomicalignments                       2.4MB @   1.7MB/s  0.2s
glib-tools                                          98.6kB @  69.8kB/s  0.0s
r-purrr                                            482.1kB @ 331.8kB/s  0.0s
r-lattice                                            1.2MB @ 799.6kB/s  0.1s
r-askpass                                           28.5kB @  19.1kB/s  0.0s
r-kernsmooth                                       101.0kB @  66.5kB/s  0.1s
r-plogr                                             21.2kB @  13.9kB/s  0.0s
r-generics                                          94.5kB @  61.7kB/s  0.0s
r-prettyunits                                       43.3kB @  28.0kB/s  0.0s
bioconductor-keggrest                              199.5kB @ 127.8kB/s  0.0s
libclang                                             8.4MB @   5.2MB/s  0.3s
glib                                               482.7kB @ 299.7kB/s  0.0s
r-sys                                               48.4kB @  29.7kB/s  0.0s
qt-webengine                                        54.1MB @  33.2MB/s  1.4s
r-xml2                                             329.7kB @ 199.8kB/s  0.0s
bioconductor-annotationdbi                           5.2MB @   3.1MB/s  0.1s
r-dbi                                              789.4kB @ 470.8kB/s  0.0s
libcurl                                            332.7kB @ 194.0kB/s  0.0s
r-dbplyr                                             1.1MB @ 608.1kB/s  0.1s
bioconductor-biobase                                 2.5MB @   1.4MB/s  0.1s
r-utf8                                             162.0kB @  92.5kB/s  0.0s
r-survival                                           6.0MB @   3.4MB/s  0.1s
r-openssl                                          627.8kB @ 355.1kB/s  0.0s
r-pillar                                           693.5kB @ 389.7kB/s  0.0s
r-foreach                                          138.4kB @  76.6kB/s  0.0s
r-glmnet                                             1.9MB @   1.0MB/s  0.1s
r-bit64                                            544.6kB @ 299.1kB/s  0.1s
mysql-libs                                           2.0MB @   1.1MB/s  0.0s
r-withr                                            245.9kB @ 132.8kB/s  0.0s
bioconductor-biomart                               926.1kB @ 497.7kB/s  0.0s
r-iterators                                        359.2kB @ 191.3kB/s  0.0s
r-digest                                           183.7kB @  97.4kB/s  0.0s
r-mime                                              51.9kB @  27.5kB/s  0.0s
bioconductor-ramwas                                  3.6MB @   1.9MB/s  0.4s
r-rsqlite                                            1.2MB @ 637.5kB/s  0.1s
r-base                                              24.4MB @  11.0MB/s  0.4s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ R-Trinity


❯ mamba install -c conda-forge r-knitr r-markdown r-rmarkdown
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


Looking for: ['r-knitr', 'r-markdown', 'r-rmarkdown']

conda-forge/osx-64                                          Using cache
conda-forge/noarch                                          Using cache

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - r-knitr
   - r-markdown
   - r-rmarkdown
   - ca-certificates
   - certifi
   - openssl


  Package         Version  Build             Channel                 Size
───────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────

  + r-base64enc     0.1_3  r42h815d134_1005  conda-forge/osx-64      45kB
  + r-bslib         0.4.2  r42hc72bb7e_0     conda-forge/noarch       4MB
  + r-commonmark    1.8.1  r42h815d134_0     conda-forge/osx-64     135kB
  + r-evaluate       0.20  r42hc72bb7e_0     conda-forge/noarch      87kB
  + r-fs            1.5.2  r42h49197e3_2     conda-forge/osx-64     311kB
  + r-highr          0.10  r42hc72bb7e_0     conda-forge/noarch      57kB
  + r-htmltools     0.5.4  r42h49197e3_0     conda-forge/osx-64     351kB
  + r-jquerylib     0.1.4  r42hc72bb7e_1     conda-forge/noarch     379kB
  + r-knitr          1.41  r42hc72bb7e_0     conda-forge/noarch       1MB
  + r-markdown        1.4  r42hc72bb7e_0     conda-forge/noarch     125kB
  + r-rmarkdown      2.20  r42hc72bb7e_0     conda-forge/noarch       3MB
  + r-sass          0.4.4  r42h49197e3_0     conda-forge/osx-64       2MB
  + r-tinytex        0.43  r42hc72bb7e_0     conda-forge/noarch     142kB
  + r-xfun           0.36  r42h49197e3_0     conda-forge/osx-64     395kB
  + r-yaml          2.3.6  r42h815d134_0     conda-forge/osx-64     116kB

  Summary:

  Install: 15 packages

  Total download: 12MB

───────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
r-xfun                                             394.7kB @   5.8MB/s  0.1s
r-base64enc                                         44.6kB @ 604.3kB/s  0.1s
r-commonmark                                       135.4kB @   1.8MB/s  0.1s
r-fs                                               310.9kB @   4.1MB/s  0.1s
r-yaml                                             116.4kB @   1.5MB/s  0.1s
r-markdown                                         124.7kB @   1.3MB/s  0.0s
r-tinytex                                          142.2kB @   1.3MB/s  0.0s
r-sass                                               2.1MB @  17.0MB/s  0.1s
r-highr                                             57.1kB @ 454.5kB/s  0.0s
r-htmltools                                        351.0kB @   2.2MB/s  0.0s
r-evaluate                                          86.7kB @ 527.6kB/s  0.0s
r-knitr                                              1.3MB @   7.4MB/s  0.0s
r-rmarkdown                                          2.8MB @  15.3MB/s  0.1s
r-bslib                                              4.1MB @  21.5MB/s  0.1s
r-jquerylib                                        378.6kB @   2.0MB/s  0.0s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="printed-14"></a>
### Printed
<details>
<summary><i>Printed: </i></summary>

```txt

```
</details>
<br />

<a id="notes-2"></a>
### Notes
<details>
<summary><i>Notes: </i></summary>

</details>
<br />
<br />
