
`#work_build-blacklist.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Commands used for initial processing on 2022-1206](#commands-used-for-initial-processing-on-2022-1206)
	1. [Look them up...](#look-them-up)
	1. [Pertinent results from the call to history](#pertinent-results-from-the-call-to-history)
1. [Symlinking `.bam`s for IGV assessments, etc., 2022-1212](#symlinking-bams-for-igv-assessments-etc-2022-1212)
	1. [The particular `.bam`s and their details](#the-particular-bams-and-their-details)
		1. ["Unprocessed" `.bam`s](#unprocessed-bams)
		1. ["Processed" `.bam`s](#processed-bams)
		1. ["Processed \(full\)" `.bam`s](#processed-full-bams)
	1. [Creating the symbolic links](#creating-the-symbolic-links)
1. [Convert the experiment `.bam`s into `.bw`s, 2022-1215](#convert-the-experiment-bams-into-bws-2022-1215)
	1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc)
	1. [Assess things](#assess-things)
	1. [Fix the symlinks to the `.bam`s linked on 2022-1212](#fix-the-symlinks-to-the-bams-linked-on-2022-1212)
		1. ["preprocessed" `.bam`s](#preprocessed-bams)
		1. ["unprocessed" `.bam`s](#unprocessed-bams-1)
		1. ["processed \(full\)" .`bam`s](#processed-full-bams-1)
	1. [Now, edit the `.bam`-to-`.bw` script and make `.bw`s](#now-edit-the-bam-to-bw-script-and-make-bws)
		1. [Update the script](#update-the-script)
			1. [Scratch: `bamcoverage_strandselect.sh`](#scratch-bamcoverage_strandselectsh)
				1. [Before \(AG\)](#before-ag)
				1. [After \(KA\)](#after-ka)
			1. [Make `submit_bamCoverage.sh`](#make-submit_bamcoveragesh)
			1. [Get the `.bam`s of interest into an array or glob to be looped over for job submissions](#get-the-bams-of-interest-into-an-array-or-glob-to-be-looped-over-for-job-submissions)
1. [Symlinking more `.bam`s and creating more `.bw`s, 2022-1216](#symlinking-more-bams-and-creating-more-bws-2022-1216)
	1. [Checking on what `.bam`s have been symlinked](#checking-on-what-bams-have-been-symlinked)
	1. [Reorganize the `.bw`s](#reorganize-the-bws)
	1. [Create `--ignoreDuplicates` `.bw`s for `multi-hit-mode 100`, `1000`](#create---ignoreduplicates-bws-for-multi-hit-mode-100-1000)
	1. [Create non-`--ignoreDuplicates` `.bw`s for `multi-hit-mode` `1`, `10`, `100`, `1000`](#create-non---ignoreduplicates-bws-for-multi-hit-mode-1-10-100-1000)
		1. [Make the submission script](#make-the-submission-script)
1. [Symlink to merged `.bam`s and create `.bw`s for them, 2022-1216](#symlink-to-merged-bams-and-create-bws-for-them-2022-1216)
1. [Symlinking `.gff3`s for assessment, 2022-1214-1216](#symlinking-gff3s-for-assessment-2022-1214-1216)
	1. [The particular `.gff3`s and their details](#the-particular-gff3s-and-their-details)
		1. [Get the absolute paths to the relevant `files_PAS*` `.gff3`s](#get-the-absolute-paths-to-the-relevant-files_pas-gff3s)
	1. [The actual symlinking](#the-actual-symlinking)
		1. [Clean up the previous symlinks, which don't work for Alison](#clean-up-the-previous-symlinks-which-dont-work-for-alison)
		1. [Create symlinks that will work for Alison/other users](#create-symlinks-that-will-work-for-alisonother-users)
1. [Scraps to be incorporated](#scraps-to-be-incorporated)
1. [Documentation for Alison/me](#documentation-for-alisonme)
	1. [The *"comprehensive transcriptome database"* strategy](#the-comprehensive-transcriptome-database-strategy)
		1. [Pros and cons of the `Trinity` GG and GF approaches](#pros-and-cons-of-the-trinity-gg-and-gf-approaches)
		1. [Input for the *"comprehensive transcriptome database"* strategy](#input-for-the-comprehensive-transcriptome-database-strategy)
	1. [How I called the different programs, including rationale and other details](#how-i-called-the-different-programs-including-rationale-and-other-details)
		1. [★ `PASA`](#%E2%98%85-pasa)
			1. [Details](#details)
				1. [First, here's a breakdown of the *"kinds"* of input](#first-heres-a-breakdown-of-the-kinds-of-input)
				1. [And here's a breakdown of the input with respect to both *"kinds"* and *"combinations"*](#and-heres-a-breakdown-of-the-input-with-respect-to-both-kinds-and-combinations)
			1. [The how](#the-how)
				1. [`--gene_overlap` `TRUE`](#--gene_overlap-true)
				1. [`--gene_overlap` `FALSE`](#--gene_overlap-false)
				1. [The meaning of the parameters](#the-meaning-of-the-parameters)
		1. [★ `Trinity`](#%E2%98%85-trinity)
			1. [Details](#details-1)
			1. [The how](#the-how-1)
				1. [GG](#gg)
				1. [GF](#gf)
		1. [★ `STAR`](#%E2%98%85-star)
		1. [★ `rcorrector`](#%E2%98%85-rcorrector)
		1. [★ `trim_galore`](#%E2%98%85-trim_galore)
1. [Downloading things... \(2022-1213\)](#downloading-things-2022-1213)
	1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc-1)
	1. [Get the SGD `_genome_Current_Release.tgz`](#get-the-sgd-_genome_current_releasetgz)
	1. [Get the SGD `other_features` files](#get-the-sgd-other_features-files)
1. [Parse the SGD `.fasta` headers to make dataframes, etc.](#parse-the-sgd-fasta-headers-to-make-dataframes-etc)
1. [Questions about `bamCoverage`](#questions-about-bamcoverage)
	1. [On `--filterRNAstrand`](#on---filterrnastrand)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="commands-used-for-initial-processing-on-2022-1206"></a>
## Commands used for initial processing on 2022-1206
<a id="look-them-up"></a>
### Look them up...
```bash
#!/bin/bash

history | grep -i awk | less
```

<a id="pertinent-results-from-the-call-to-history"></a>
### Pertinent results from the call to history
<details>
<summary><i>Click to view</i></summary>

```txt
32894  2022-12-06 10:49:49 cat gene_names.txt | awk -F '\t' '{ print $9 }'
32895  2022-12-06 10:50:31 cat gene_names.txt | awk -F '\t' '{ print $9 }' > gene_names.ID-field.txt
32898  2022-12-06 10:51:58 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }'
32899  2022-12-06 10:52:11 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }' | grep -v "Name="
32900  2022-12-06 10:53:17 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }' | grep -v "Name=" -
32922  2022-12-06 11:01:39 cat KA.other_features_genomic.names.ID-field.txt | awk -F ';' '{ print $2 }' | sed 's/Name=//' | head
32923  2022-12-06 11:03:18 cat KA.other_features_genomic.names.ID-field.txt | awk -F ';' '{ print $2 }' | sed 's/Name=//' | sort | uniq -c > KA.other_feature
```
</details>
<br />
<br />

<a id="symlinking-bams-for-igv-assessments-etc-2022-1212"></a>
## Symlinking `.bam`s for IGV assessments, etc., 2022-1212
<a id="the-particular-bams-and-their-details"></a>
### The particular `.bam`s and their details
<a id="unprocessed-bams"></a>
#### "Unprocessed" `.bam`s
- reads adapter and quality trimmed by `trim_galore`: `FALSE`
- reads k-mer-corrected by `rcorrector`: `FALSE`
- `STAR` alignment type: "`Local`"

<details>
<summary><i>Click to see the files</i></summary>

```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
```
</details>

<a id="processed-bams"></a>
#### "Processed" `.bam`s
- reads adapter and quality trimmed by `trim_galore`: TRUE
- reads k-mer-corrected by `rcorrector`: FALSE
- `STAR` alignment type: "`EndToEnd`"

<details>
<summary><i>Click to see the files</i></summary>

```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
```
</details>

<a id="processed-full-bams"></a>
#### "Processed (full)" `.bam`s
- reads adapter and quality trimmed by trim_galore: TRUE
- reads k-mer-corrected by rcorrector: TRUE
- STAR alignment type: "EndToEnd"

<details>
<summary><i>Click to see the files</i></summary>

```txt
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
```
</details>

<a id="creating-the-symbolic-links"></a>
### Creating the symbolic links
<details>
<summary><i>Click to view the bash code</i></summary>

```bash
#!/bin/bash

cd "/home/kalavatt/tsukiyamalab/alisong" || echo "cd'ing failed"
mkdir -p Kris_bams/{unprocessed,preprocessed,preprocessed-full}

cd "Kris_bams" || echo "cd'ing failed; check on this"

p_u="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local"
p_p="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd"
p_pf="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd"

cd unprocessed
for i in "${p_u}/"*".sc_all.bam"; do
	# echo "${i}" "$(basename "${i}")"
	ln -s "${i}" "$(basename "${i}")"  #YAAD ln -s source_file target_file
done

cd ../preprocessed
for i in "${p_p}/"*".sc_all.bam"; do
	# echo "${i}" "$(basename "${i}")"
	ln -s "${i}" "$(basename "${i}")"
done
rename 's/un_multi-hit-mode/multi-hit-mode/g' *.bam

cd ../preprocessed-full
for i in "${p_pf}/"*".sc_all.bam"; do
	# echo "${i}" "$(basename "${i}")"
	ln -s "${i}" "$(basename "${i}")"
done

cd ..
.,s
```
</details>
<br />

<details>
<summary><i>Results of .,s in ~/tsukiyamalab/alisong/Kris_bams </i></summary>

```txt
./preprocessed:
total 972K
drwxrws--- 2 kalavatt 3.3K Dec 12 14:58 ./
drwxrws--- 5 kalavatt   94 Dec 12 14:51 ../
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

./preprocessed-full:
total 1002K
drwxrws--- 2 kalavatt 3.5K Dec 12 14:59 ./
drwxrws--- 5 kalavatt   94 Dec 12 14:51 ../
lrwxrwxrwx 1 kalavatt  234 Dec 12 14:59 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  234 Dec 12 14:59 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  230 Dec 12 14:59 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  230 Dec 12 14:59 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  234 Dec 12 14:59 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  234 Dec 12 14:59 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  230 Dec 12 14:59 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  233 Dec 12 14:59 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  232 Dec 12 14:59 5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  231 Dec 12 14:59 5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  230 Dec 12 14:59 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

./unprocessed:
total 948K
drwxrws--- 2 kalavatt 3.1K Dec 12 14:56 ./
drwxrws--- 5 kalavatt   94 Dec 12 14:51 ../
lrwxrwxrwx 1 kalavatt  204 Dec 12 14:56 5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 12 14:56 5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  200 Dec 12 14:56 5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  200 Dec 12 14:56 5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 12 14:56 5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 12 14:56 5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  200 Dec 12 14:56 5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 12 14:56 5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 12 14:56 5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  201 Dec 12 14:56 5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  200 Dec 12 14:56 5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
```
</details>
<br />
<br />

<a id="convert-the-experiment-bams-into-bws-2022-1215"></a>
## Convert the experiment `.bam`s into `.bw`s, 2022-1215
*Building off of work started by Alison*

<a id="grab-a-node-get-to-the-right-directory-etc"></a>
### Grab a node, get to the right directory, etc.
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN

pwd
# /home/kalavatt


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults

#  Rename the directory for analyses in which we assess assemblies with IGV
cd "${HOME}/tsukiyamalab/alisong" || \
    echo "cd'ing failed; check on this"

mv Kris/ assess_transcriptome_assemblies/
# renamed 'Kris/' -> 'assess_transcriptome_assemblies/'

#  Create a symlink to the directory for assessing assemblies with IGV
cd ../..

ln -s \
	"${HOME}/tsukiyamalab/alisong/assess_transcriptome_assemblies" \
	"assess_transcriptome_assemblies"

., "assess_transcriptome_assemblies"
# lrwxrwxrwx 1 kalavatt 67 Dec 15 09:27 assess_transcriptome_assemblies -> /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/

cd "assess_transcriptome_assemblies" && .,
# /home/kalavatt/assess_transcriptome_assemblies
# total 259K
# drwxrws---  5 kalavatt  149 Dec 14 14:38 ./
# drwxrws--- 49 agreenla 3.2K Dec 15 09:21 ../
# drwxrws---  6 kalavatt  180 Dec 14 15:05 bams_2022-1212/
# drwxrws---  4 kalavatt   83 Dec 14 15:05 gtfs_2022-1214/
# drwxrws---  2 agreenla 1.7K Dec 12 14:26 IGV_sharing/

#  Load Trinity environment
Trinity_env
```
</details>
<br />

<a id="assess-things"></a>
### Assess things
`#DEKHO`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

., bams_2022-1212/
# total 235K
# drwxrws--- 6 kalavatt  124 Dec 15 09:41 ./
# drwxrws--- 5 kalavatt   93 Dec 15 09:40 ../
# drwxrws--- 3 agreenla  523 Dec 15 09:41 bigwig_test1/
# drwxrws--- 2 kalavatt 3.3K Dec 12 14:58 preprocessed/
# drwxrws--- 2 kalavatt 3.5K Dec 12 14:59 preprocessed-full/
# drwxrws--- 2 kalavatt 3.1K Dec 12 14:56 unprocessed/

cd bams_2022-1212/bigwig_test1/ && .,
# drwxrws--- 3 agreenla  523 Dec 15 09:41 ./
# drwxrws--- 6 kalavatt  124 Dec 15 09:41 ../
# lrwxrwxrwx 1 agreenla  154 Dec 14 15:14 5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  153 Dec 14 15:14 5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  164 Dec 14 15:18 5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  163 Dec 14 15:17 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  148 Dec 14 15:31 5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  147 Dec 14 15:31 5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
# -rw-rw---- 1 agreenla  639 Dec 14 15:38 bamcoverage_strandselect.sh
# drwxrws--- 2 agreenla    0 Dec 14 15:39 bigwigs1/
# -rw-rw---- 1 agreenla 4.8K Dec 14 15:39 slurm-5685397.out

head -1000 slurm-5685397.out
```

<details>
<summary><i>Click to view results of head -1000 slurm-5685397.out</i></summary>

```txt
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam" : Permission denied
The file '5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam' does not exist
[E::hts_open_format] Failed to open file "5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam" : Permission denied
The file '5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam' does not exist
mv: cannot stat '*.bw': No such file or directory
/var/tmp/slurmd/job5685397/slurm_script: line 26: syntax error near unexpected token `done'
/var/tmp/slurmd/job5685397/slurm_script: line 26: `done'
```
</details>
<br />

```bash
#!/bin/bash
#DONTRUN #CONTINUE

., ../preprocessed
```

<details>
<summary><i>Click to view results of ., ../preprocessed</i></summary>

```txt
total 972K
drwxrws--- 2 kalavatt 3.3K Dec 12 14:58 ./
drwxrws--- 6 kalavatt  124 Dec 15 09:41 ../
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_G1_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_G1_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5781_Q_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_G1_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_G1_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5782_Q_IN_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  217 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  216 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  215 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  214 Dec 12 14:57 5782_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
```
</details>
<br />

- The problem is that the symlink is pointing to my home directory, which does not exist on Alison's (or anyone else's) system...
- Let's see how we can address this...

<a id="fix-the-symlinks-to-the-bams-linked-on-2022-1212"></a>
### Fix the symlinks to the `.bam`s linked on 2022-1212
<a id="preprocessed-bams"></a>
#### "preprocessed" `.bam`s
`#DEKHO` `#TODO` Fix things when `samtools split`, `samtools index`, and `samtools sort -n` are completed
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ../preprocessed

for i in *.bam *.bai; do unlink "${i}"; done
.,
# total 72K
# drwxrws--- 2 kalavatt   0 Dec 15 09:51 ./
# drwxrws--- 6 kalavatt 124 Dec 15 09:41 ../

pwd
# /home/kalavatt/assess_transcriptome_assemblies/bams_2022-1212/preprocessed

cd ../../..
# /home/kalavatt

cd tsukiyamalab/alisong/assess_transcriptome_assemblies
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies

cd bams_2022-1212/preprocessed
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/bams_2022-1212/preprocessed

# ., ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd
path_prepro="../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd"
# echo "${path_prepro}"
# ., "${path_prepro}"

for i in "${path_prepro}/"*".sc_all.ba"*; do
    # ., "${i}"
    # echo "${i}"
    # echo "ln -s ${i}" "$(basename "${i}")"
    # echo ""
    
    # unlink "${i}"
    ln -s "${i}" "$(basename "${i}")"
done
.,
```

<details>
<summary><i>Click to view results of .,</i></summary>

```txt
total 2.0M
drwxrws--- 2 kalavatt 6.9K Dec 15 13:38 ./
drwxrws--- 6 kalavatt  124 Dec 15 13:15 ../
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  206 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  206 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  198 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  198 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  206 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  206 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  198 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  201 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  205 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  200 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  204 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  199 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  203 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  198 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  202 Dec 15 13:38 5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
```
</details>
<br />

<a id="unprocessed-bams-1"></a>
#### "unprocessed" `.bam`s
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ../unprocessed

for i in *.bam *.bai; do unlink "${i}"; done
.,
# total 72K
# drwxrws--- 2 kalavatt   0 Dec 15 09:51 ./
# drwxrws--- 6 kalavatt 124 Dec 15 09:41 ../

pwd
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/bams_2022-1212/unprocessed

# ., ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local
path_unpro="../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local"
# echo "${path_unpro}"
# ., "${path_unpro}"
# ls "${path_unpro}" | wc -l

for i in "${path_unpro}/"*".sc_all.ba"*; do
	# ., "${i}"
    # echo "${i}"
    # echo "ln -s ${i}" "$(basename "${i}")"
    # echo ""
    
    ln -s "${i}" "$(basename "${i}")"
done
.,
```

<details>
<summary><i>Click to view results of .,</i></summary>

```txt
total 2.0M
drwxrws--- 2 kalavatt 6.4K Dec 15 13:36 ./
drwxrws--- 6 kalavatt  124 Dec 15 13:15 ../
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  192 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  192 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  184 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  184 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  192 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  192 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  184 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  187 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  191 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  186 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  190 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  185 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  189 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  184 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  188 Dec 15 13:36 5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam.bai
```
</details>
<br />

<a id="processed-full-bams-1"></a>
#### "processed (full)" .`bam`s
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ../preprocessed-full

for i in *.bam *.bai; do unlink "${i}"; done
.,
# total 80K
# drwxrws--- 2 kalavatt   0 Dec 15 10:24 ./
# drwxrws--- 6 kalavatt 124 Dec 15 09:41 ../

pwd
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/bams_2022-1212/preprocessed-full

# ., ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd
path_prepro_full="../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd"
# echo "${path_prepro_full}"
# ., "${path_prepro_full}"

for i in "${path_prepro_full}/"*".sc_all.ba"*; do
	# ., "${i}"
    # echo "${i}"
    # echo "ln -s ${i}" "$(basename "${i}")"
    # echo ""
    
    ln -s "${i}" "$(basename "${i}")"
done
.,
```

<details>
<summary><i>Click to view results of .,</i></summary>

```txt
total 2.0M
drwxrws--- 2 kalavatt 7.0K Dec 15 13:37 ./
drwxrws--- 6 kalavatt  124 Dec 15 13:15 ../
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  222 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  222 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  214 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  214 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  222 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  222 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  214 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  217 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  221 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  216 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  220 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  215 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  219 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
lrwxrwxrwx 1 kalavatt  214 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
lrwxrwxrwx 1 kalavatt  218 Dec 15 13:37 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam.bai
```
</details>
<br />

<a id="now-edit-the-bam-to-bw-script-and-make-bws"></a>
### Now, edit the `.bam`-to-`.bw` script and make `.bw`s
<a id="update-the-script"></a>
#### Update the script
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ../bigwig_test1
.,
# total 355K
# drwxrws--- 3 agreenla  523 Dec 15 09:41 ./
# drwxrws--- 6 kalavatt  124 Dec 15 09:41 ../
# lrwxrwxrwx 1 agreenla  154 Dec 14 15:14 5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  153 Dec 14 15:14 5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  164 Dec 14 15:18 5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  163 Dec 14 15:17 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  148 Dec 14 15:31 5781_Q_IP_merged.un_multi-hit-mode_10_Local.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
# lrwxrwxrwx 1 agreenla  147 Dec 14 15:31 5781_Q_IP_merged.un_multi-hit-mode_1_Local.bam -> /home/agreenla/tsukiyamalab/alisong/Kris/bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
# -rw-rw---- 1 agreenla  639 Dec 14 15:38 bamcoverage_strandselect.sh
# drwxrws--- 2 agreenla    0 Dec 14 15:39 bigwigs1/
# -rw-rw---- 1 agreenla 4.8K Dec 14 15:39 slurm-5685397.out

#  Remove the bigwigs1/ directory
rmdir bigwigs1/

#  Remove the symlinks
for i in *.bam; do
	# echo "${i}"
	unlink "${i}"
done

#  Archive the stuff from Alison
mkdir archive
mv bamcoverage_strandselect.sh slurm-5685397.out archive
# renamed 'bamcoverage_strandselect.sh' -> 'archive/bamcoverage_strandselect.sh'
# renamed 'slurm-5685397.out' -> 'archive/slurm-5685397.out'
```

<a id="scratch-bamcoverage_strandselectsh"></a>
##### Scratch: `bamcoverage_strandselect.sh`
Now, update `bamcoverage_strandselect.sh` to...
`#QUESTION` Does `deepTools` `bamCoverage` have a `parallel` mode? `#ANSWER` No...

<a id="before-ag"></a>
###### Before (AG)
```bash
#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

# Please review the variables below and update if needed.
THREADS=8

module load deepTools

mkdir bigwigs1

for file in *.bam; do

  bamCoverage -b ${file} --normalizeUsing CPM --filterRNAstrand forward -o ${file%.bam}_fwd.bw
  bamCoverage -b ${file} --normalizeUsing CPM --filterRNAstrand reverse -o ${file%.bam}_rev.bw

  bamCoverage -b ${file} --normalizeUsing CPM --minMappingQuality 3 --filterRNAstrand forward -o ${file%.bam}_fwd_mapQ3.bw
  bamCoverage -b ${file} --normalizeUsing CPM --minMappingQuality 3 --filterRNAstrand reverse -o ${file%.bam}_rev_mapQ3.bw



  done

  mv *.bw bigwigs1

done
```

<a id="after-ka"></a>
###### After (KA)
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./bamcoverage_strandselect.sh.%J.err.txt
#SBATCH --output=./bamcoverage_strandselect.sh.%J.out.txt

#  submit_bamCoverage.sh
#  AG, KA
#  2022-1215

module load deepTools

infile="${1}"

#  Make directories for outfiles
mkdir -p {MAPQ0,MAPQ3,MAPQ30}

#  Run bamCoverage
#  ...with no MAPQ filtering
bamCoverage \
	-p ${SLURM_CPUS_ON_NODE} \
	--ignoreDuplicates \
	-b ${file} \
	--normalizeUsing CPM \
	--filterRNAstrand forward \
	-o ${file%.bam}_MAPQ0_fwd.bw

bamCoverage \
	-p ${SLURM_CPUS_ON_NODE} \
	--ignoreDuplicates \
	-b ${file} \
	--normalizeUsing CPM \
	--filterRNAstrand reverse \
	-o ${file%.bam}_MAPQ0_rev.bw

#  ...by excluding alignments less than MAPQ 3
bamCoverage \
	-p ${SLURM_CPUS_ON_NODE} \
	--ignoreDuplicates \
	-b ${file} \
	--normalizeUsing CPM \
	--minMappingQuality 3 \
	--filterRNAstrand forward \
	-o ${file%.bam}_fwd_MAPQ3.bw

bamCoverage \
	-p ${SLURM_CPUS_ON_NODE} \
	--ignoreDuplicates \
	-b ${file} \
	--normalizeUsing CPM \
	--minMappingQuality 3 \
	--filterRNAstrand reverse \
	-o ${file%.bam}_rev_MAPQ3.bw

#  ...by excluding alignments less than MAPQ 30
bamCoverage \
	-p ${SLURM_CPUS_ON_NODE} \
	--ignoreDuplicates \
	-b ${file} \
	--normalizeUsing CPM \
	--minMappingQuality 30 \
	--filterRNAstrand forward \
	-o ${file%.bam}_fwd_MAPQ30.bw

bamCoverage \
	-p ${SLURM_CPUS_ON_NODE} \
	--ignoreDuplicates \
	-b ${file} \
	--normalizeUsing CPM \
	--minMappingQuality 30 \
	--filterRNAstrand reverse \
	-o ${file%.bam}_rev_MAPQ30.bw
```

Some quick notes about the previous script for teaching purposes:
- Important
	+ `bamCoverage` has a parameter to run in parallel, but it won't recognize it unless you call it with the `-p` option
		* So, `THREADS` becomes an unused variable
		* Also, when submitting the job to `SLURM`, you need to tell it to assign 8 (or however many) cores/CPUs to the job,
			- either through the call to `sbatch` (`-c` or `--cpus-per-task`)
			- or through a `#SBATCH` line in the job submission script: `#SBATCH --cpus-per-task=#`
	+ I recommend to get used to explicitly telling `SLURM` things with lines in the script that start with `#SBATCH` (see below)
	+ Rather than have the for loop in the job submission script, use the for loop outside of the script;
		* Write the script to take a single infile
		* Then,loop over the files to apply the script to each file
		* I'll show an example below...
	+ To organize your results, explicitly specify to `SLURM` that you want `stderr` and `stdout` files
		* Save the files to specific locations (optional, but important for organizing your results/staying on top of things)
		* ...with specific names (I think this is mandatory)
	+ ~~Don't do directory remodeling, etc. inside the script~~ It's fine if it's a thing you want to do repeatedly with consistent, specific directory changes
- Less important
	+ I told you yesterday that a MAPQ score of 30 represents of 99.99% that the mapped position is correct, but that's incorrect&mdash;it's actually 99.9%
		* Some details on MAPQ [here](http://www.acgt.me/blog/2014/12/16/understanding-mapq-scores-in-sam-files-does-37-42)
	+ Delete all of the unused variables

<a id="make-submit_bamcoveragesh"></a>
##### Make `submit_bamCoverage.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

s_name="submit_bamCoverage.sh"

if [[ -f "${s_name}" ]]; then rm "${s_name}"; fi
cat << script > "${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./stderr.${s_name}.%J.txt
#SBATCH --output=./stdout.${s_name}.%J.txt

#  ${s_name}
#  AG, KA
#  $(date '+%Y-%m%d')

module load deepTools

infile="\${1}"
outfile="\${2}"

#  Make directories for outfiles
mkdir -p {MAPQ0,MAPQ3,MAPQ30}

#  Run bamCoverage
#  ...with no MAPQ filtering
bamCoverage \\
	-p \${SLURM_CPUS_ON_NODE} \\
	--ignoreDuplicates \\
	-b "\${infile}" \\
	--normalizeUsing CPM \\
	--filterRNAstrand forward \\
	-o "MAPQ0/\${outfile}_MAPQ0_fwd.bw"

bamCoverage \\
	-p \${SLURM_CPUS_ON_NODE} \\
	--ignoreDuplicates \\
	-b "\${infile}" \\
	--normalizeUsing CPM \\
	--filterRNAstrand reverse \\
	-o "MAPQ0/\${outfile}_MAPQ0_rev.bw"

#  ...by excluding alignments less than MAPQ 3
bamCoverage \\
	-p \${SLURM_CPUS_ON_NODE} \\
	--ignoreDuplicates \\
	-b "\${infile}" \\
	--normalizeUsing CPM \\
	--minMappingQuality 3 \\
	--filterRNAstrand forward \\
	-o "MAPQ3/\${outfile}_MAPQ3_fwd.bw"

bamCoverage \\
	-p \${SLURM_CPUS_ON_NODE} \\
	--ignoreDuplicates \\
	-b "\${infile}" \\
	--normalizeUsing CPM \\
	--minMappingQuality 3 \\
	--filterRNAstrand reverse \\
	-o "MAPQ3/\${outfile}_MAPQ3_rev.bw"

#  ...by excluding alignments less than MAPQ 30
bamCoverage \\
	-p \${SLURM_CPUS_ON_NODE} \\
	--ignoreDuplicates \\
	-b "\${infile}" \\
	--normalizeUsing CPM \\
	--minMappingQuality 30 \\
	--filterRNAstrand forward \\
	-o "MAPQ30/\${outfile}_MAPQ30_fwd.bw"

bamCoverage \\
	-p \${SLURM_CPUS_ON_NODE} \\
	--ignoreDuplicates \\
	-b "\${infile}" \\
	--normalizeUsing CPM \\
	--minMappingQuality 30 \\
	--filterRNAstrand reverse \\
	-o "MAPQ30/\${outfile}_MAPQ30_rev.bw"
script
# vi "${s_name}"  # :q
```

<a id="get-the-bams-of-interest-into-an-array-or-glob-to-be-looped-over-for-job-submissions"></a>
##### Get the `.bam`s of interest into an array or glob to be looped over for job submissions
- In my attempts to come up with something teachable, I think I've gone about doing this in a way that is overall not good
- What's not good about it?
	+ For one, we're Parsing the results of `ls`, which is a bit of a no-no (probably fine for rough-draft work and assuming your filenames are "normal")
		* [unix.stackexchange.com/questions/128985/why-not-parse-ls-and-what-to-do-instead](https://unix.stackexchange.com/questions/128985/why-not-parse-ls-and-what-to-do-instead)
		* [mywiki.wooledge.org/ParsingLs](http://mywiki.wooledge.org/ParsingLs)
	+ Very poor control of what's being globbed onto
	+ Using relative paths to find things: This code snippet is even more context-sensitive, and thus breakable, than normal
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/bams_2022-1212/bigwig_test1

#  Glob approach with ls  #NOTE This is bad practice, but it's fine for now
for i in $(ls -1R ../{unprocessed,preprocessed,preprocessed-full}/5781_Q_IP*multi-hit-mode_{10,1}_*.sc_all.bam); do
	echo "${i}"
done
# ../preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# ../preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# ../preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# ../preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
# ../unprocessed/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam
# ../unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

# for i in $(ls -1R ../{unprocessed,preprocessed,preprocessed-full}/5781_Q_IP*multi-hit-mode_{10,1}_*.sc_all.bam); do
# 	echo "${i}"
# done

#  Strip away the leading '../', strip away '.bam' extension
for i in $(ls -1R ../{unprocessed,preprocessed,preprocessed-full}/5781_Q_IP*multi-hit-mode_{10,1}_*.sc_all.bam); do
	echo "${i##\.\.\/}"  # One way to do it
	echo "$(basename "${i}")"  # Easier way to do it
	echo "$(basename "${i}" ".bam")"  # Do both at the same time
	echo ""
done

for i in $(ls -1R ../{unprocessed,preprocessed,preprocessed-full}/5781_Q_IP*multi-hit-mode_{10,1}_*.sc_all.bam); do
	., "${i}"
	echo ""
	echo "Submitting SLURM job for ${i}..."
	# echo "${s_name}" "${i}" "$(basename "${i}" .bam)"
	sbatch "${s_name}" "${i}" "$(basename "${i}" .bam)"
	echo ""
	echo ""
done


#TODO With the jobs now completed, mv and rename the bigwig directory
#WAIT Wait to get feedback from Alison on the files
```

<details>
<summary><i>Submission messages printed to terminal</i></summary>

```txt
lrwxrwxrwx 1 kalavatt 199 Dec 15 13:38 ../preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

Submitting SLURM job for ../preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam...
Submitted batch job 5707988


lrwxrwxrwx 1 kalavatt 198 Dec 15 13:38 ../preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/bam_trim_split/EndToEnd/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

Submitting SLURM job for ../preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam...
Submitted batch job 5707989


lrwxrwxrwx 1 kalavatt 215 Dec 15 13:37 ../preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

Submitting SLURM job for ../preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam...
Submitted batch job 5707990


lrwxrwxrwx 1 kalavatt 214 Dec 15 13:37 ../preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

Submitting SLURM job for ../preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam...
Submitted batch job 5707991


lrwxrwxrwx 1 kalavatt 185 Dec 15 13:36 ../unprocessed/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam

Submitting SLURM job for ../unprocessed/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam...
Submitted batch job 5707992


lrwxrwxrwx 1 kalavatt 184 Dec 15 13:36 ../unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam -> ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/bam_split/Local/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam

Submitting SLURM job for ../unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam...
Submitted batch job 5707993
```
</details>
<br />
<br />

<a id="symlinking-more-bams-and-creating-more-bws-2022-1216"></a>
## Symlinking more `.bam`s and creating more `.bw`s, 2022-1216
`#DEKHO`
<a id="checking-on-what-bams-have-been-symlinked"></a>
### Checking on what `.bam`s have been symlinked
```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults
Trinity_env

mwd() {
    transcriptome \
       && cd "./results/2022-1201" \
       || echo "cd'ing failed; check on this"
}


awd() {
	~/assess_transcriptome_assemblies \
		&& cd "./bams_2022-1212" \
       || echo "cd'ing failed; check on this"
}


# mwd
awd

ls -1 ./*
#NOTE We've already symlinked to *.multi-hit-mode_{100,1000}_*.{bam,bam.bai}
```

<a id="reorganize-the-bws"></a>
### Reorganize the `.bw`s
```bash
#!/bin/bash
#DONTRUN

mv bigwig_test1 ../bws_2022-1215
cd .. && .,
# drwxrws---  6 kalavatt  125 Dec 16 09:10 ./
# drwxrws--- 49 agreenla 3.2K Dec 15 09:21 ../
# drwxrws---  5 kalavatt   94 Dec 16 09:10 bams_2022-1212/
# drwxrws---  6 agreenla 1.1K Dec 15 14:48 bws_2022-1215/
# drwxrws---  4 kalavatt   83 Dec 16 08:09 gff3s_2022-1214/
# drwxrws---  2 agreenla 1.5K Dec 15 09:41 IGV_sharing/

cd bws_2022-1215 && .,
# drwxrws--- 6 agreenla  830 Dec 16 09:11 ./
# drwxrws--- 6 kalavatt  125 Dec 16 09:10 ../
# drwxrws--- 2 kalavatt   80 Dec 16 09:11 archive/
# drwxrws--- 2 kalavatt 1.4K Dec 15 14:00 MAPQ0/
# drwxrws--- 2 kalavatt 1.4K Dec 15 14:04 MAPQ3/
# drwxrws--- 2 kalavatt 1.4K Dec 15 14:07 MAPQ30/
# -rw-rw---- 1 kalavatt 4.1K Dec 15 14:04 stderr.submit_bamCoverage.sh.5707988.txt
# -rw-rw---- 1 kalavatt 4.1K Dec 15 14:05 stderr.submit_bamCoverage.sh.5707989.txt
# -rw-rw---- 1 kalavatt 4.2K Dec 15 14:04 stderr.submit_bamCoverage.sh.5707990.txt
# -rw-rw---- 1 kalavatt 4.2K Dec 15 14:03 stderr.submit_bamCoverage.sh.5707991.txt
# -rw-rw---- 1 kalavatt 4.1K Dec 15 14:06 stderr.submit_bamCoverage.sh.5707992.txt
# -rw-rw---- 1 kalavatt 4.1K Dec 15 14:03 stderr.submit_bamCoverage.sh.5707993.txt
# -rw-rw---- 1 kalavatt  608 Dec 15 14:04 stdout.submit_bamCoverage.sh.5707988.txt
# -rw-rw---- 1 kalavatt  606 Dec 15 14:05 stdout.submit_bamCoverage.sh.5707989.txt
# -rw-rw---- 1 kalavatt  606 Dec 15 14:04 stdout.submit_bamCoverage.sh.5707990.txt
# -rw-rw---- 1 kalavatt  603 Dec 15 14:03 stdout.submit_bamCoverage.sh.5707991.txt
# -rw-rw---- 1 kalavatt  606 Dec 15 14:06 stdout.submit_bamCoverage.sh.5707992.txt
# -rw-rw---- 1 kalavatt  609 Dec 15 14:03 stdout.submit_bamCoverage.sh.5707993.txt
# -rw-rw---- 1 kalavatt 1.7K Dec 15 13:54 submit_bamCoverage.sh


#  Organize things, clean things up -------------------------------------------
mv submit_bamCoverage.sh submit_bamCoverage_param-ignoreDuplicates-TRUE.sh

mkdir -p {param_ignoreDuplicates-TRUE,param_ignoreDuplicates-FALSE}/err_out
mv MAPQ{0,3,30} param_ignoreDuplicates-TRUE/
mv *.txt param_ignoreDuplicates-TRUE/err_out
mv *.sh param_ignoreDuplicates-TRUE/ && cd param_ignoreDuplicates-TRUE/
```

<a id="create---ignoreduplicates-bws-for-multi-hit-mode-100-1000"></a>
### Create `--ignoreDuplicates` `.bw`s for `multi-hit-mode 100`, `1000`
```bash
#!/bin/bash
#DONTRUN

cd param_ignoreDuplicates-TRUE && .,s

#  Get the multi-hit-mode 100, 1000 files into an array (with absolute paths)
# cd ../..
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find ../.. \
        -type l \
        \( \
    		-name "*multi-hit-mode_100_*.bam" \
    		-o -name "*multi-hit-mode_1000_*.bam" \
		\) \
        -print0 | \
            sort -z
)
echoTest "${bams[@]}"  # It works!

s_name="submit_bamCoverage_param-ignoreDuplicates-TRUE.sh"
for i in "${bams[@]}"; do
	echo "sbatch ${s_name} ${i} $(basename "${i}" .bam)"
	echo ""

	sbatch ${s_name} ${i} $(basename "${i}" .bam)
	echo ""
	echo ""
done
```

<details>
<summary><i>Job submission messages printed to terminal</i></summary>

```txt
sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745678


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745679


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745680


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745681


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745682


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745683


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745684


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745685


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745686


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745687


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745688


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745689


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745690


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745691


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745692


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745693


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745694


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745695


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745696


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745697


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745698


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745699


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745700


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745701


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745702


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745703


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745704


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745705


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745706


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745707


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745708


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745709


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745710


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745711


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745712


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745713


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745714


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745715


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745716


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745717


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745718


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745719


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745720


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745721


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745722


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745723


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745724


sbatch submit_bamCoverage_param-ignoreDuplicates-TRUE.sh ../../bams_2022-1212/unprocessed/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745725
```
</details>
<br />

<a id="create-non---ignoreduplicates-bws-for-multi-hit-mode-1-10-100-1000"></a>
### Create non-`--ignoreDuplicates` `.bw`s for `multi-hit-mode` `1`, `10`, `100`, `1000`
<a id="make-the-submission-script"></a>
#### Make the submission script
```bash
#!/bin/bash
#DONTRUN

#  First, get to the correct working directory
pwd
# /home/kalavatt/assess_transcriptome_assemblies/bws_2022-1215/param_ignoreDuplicates-TRUE
cd ../param_ignoreDuplicates-FALSE
# /home/kalavatt/assess_transcriptome_assemblies/bws_2022-1215/param_ignoreDuplicates-FALSE

s_name="submit_bamCoverage_param-ignoreDuplicates-FALSE.sh"

if [[ -f "${s_name}" ]]; then rm "${s_name}"; fi
cat << script > "${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./err_out/stderr.${s_name}.%J.txt
#SBATCH --output=./err_out/stdout.${s_name}.%J.txt

#  ${s_name}
#  AG, KA
#  $(date '+%Y-%m%d')

module load deepTools

infile="\${1}"
outfile="\${2}"

#  Make directories for outfiles
mkdir -p {MAPQ0,MAPQ3,MAPQ30}


#   ---------------------------------------------------------------------------
#  Run bamCoverage ------------------------------------------------------------
#   ---------------------------------------------------------------------------

#  ...with no MAPQ filtering  -------------------------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --filterRNAstrand forward \\
    -o "MAPQ0/\${outfile}_MAPQ0_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --filterRNAstrand reverse \\
    -o "MAPQ0/\${outfile}_MAPQ0_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)


#  ...by excluding alignments less than MAPQ 3 --------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 3 \\
    --filterRNAstrand forward \\
    -o "MAPQ3/\${outfile}_MAPQ3_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 3 \\
    --filterRNAstrand reverse \\
    -o "MAPQ3/\${outfile}_MAPQ3_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)


#  ...by excluding alignments less than MAPQ 30 -------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 30 \\
    --filterRNAstrand forward \\
    -o "MAPQ30/\${outfile}_MAPQ30_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 30 \\
    --filterRNAstrand reverse \\
    -o "MAPQ30/\${outfile}_MAPQ30_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

script
# vi "${s_name}"  # :q


#  Get files of interest into an array ----------------------------------------
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find ../.. \
        -type l \
        \( \
    		-name "*multi-hit-mode_1_*.bam" \
    		-o -name "*multi-hit-mode_10_*.bam" \
    		-o -name "*multi-hit-mode_100_*.bam" \
    		-o -name "*multi-hit-mode_1000_*.bam" \
		\) \
        -print0 | \
            sort -z
)
echoTest "${bams[@]}"  # It works!

echo "${s_name}"  # submit_bamCoverage_param-ignoreDuplicates-FALSE.sh
for i in "${bams[@]}"; do
	echo "sbatch ${s_name} ${i} $(basename "${i}" .bam)"
	echo ""

	sbatch ${s_name} ${i} $(basename "${i}" .bam)
	echo ""
	echo ""
	sleep 0.33
done
```

<details>
<summary><i>Job submission messages printed to terminal</i></summary>

```txt
sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745765


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745766


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745767


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745768


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745769


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745770


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745771


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745772


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745773


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745774


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745775


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745776


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745777


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745778


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745779


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745780


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745781


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745782


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745783


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745784


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745785


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745786


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745787


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745788


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745789


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745790


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745791


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745792


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745793


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745794


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745795


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed/5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745796


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745797


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745798


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745799


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745800


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745801


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745802


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745803


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745804


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745805


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745806


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745807


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745808


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745809


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745810


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745811


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745812


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745813


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745814


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745815


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745816


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745817


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745818


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745819


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745820


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745821


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745822


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745823


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745824


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745825


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745826


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745827


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/preprocessed-full/5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745828


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745829


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745830


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745831


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745832


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745833


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745834


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745835


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745836


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745837


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745838


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745839


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745840


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745841


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745842


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745843


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5781_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745844


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745845


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745846


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745847


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745848


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745849


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745850


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745851


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_G1_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745852


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745853


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745854


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745855


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IN_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745856


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.un_multi-hit-mode_1000_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745857


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.un_multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745858


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.un_multi-hit-mode_10_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745859


sbatch submit_bamCoverage_param-ignoreDuplicates-FALSE.sh ../../bams_2022-1212/unprocessed/5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam 5782_Q_IP_merged.un_multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all

Submitted batch job 5745860
```
</details>
<br />
<br />

<a id="symlink-to-merged-bams-and-create-bws-for-them-2022-1216"></a>
## Symlink to merged `.bam`s and create `.bw`s for them, 2022-1216
```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults
Trinity_env

mwd() {
    transcriptome \
       && cd "./results/2022-1201" \
       || echo "cd'ing failed; check on this"
}


awd() {
    ~/assess_transcriptome_assemblies \
       || echo "cd'ing failed; check on this"
}


#  Identify the files of interest to symlink to -------------------------------
mwd
ls -1 ./files_{processed,processed-full}/*_split_merge/EndToEnd
ls -1 ./files_unprocessed/*_split_merge/Local

p_exp="$(pwd)"
echo "${p_exp}"


#  Get relative paths, set things up, etc. ------------------------------------
awd
# .,

#  Create directories for outfiles ------------------------
mkdir -p {bams_merged_2022-1216,bws_merged_2022-1216}/{unprocessed,preprocessed,preprocessed-full}
# mkdir: created directory 'bams_merged_2022-1216'
# mkdir: created directory 'bams_merged_2022-1216/unprocessed'
# mkdir: created directory 'bams_merged_2022-1216/preprocessed'
# mkdir: created directory 'bams_merged_2022-1216/preprocessed-full'
# mkdir: created directory 'bws_merged_2022-1216'
# mkdir: created directory 'bws_merged_2022-1216/unprocessed'
# mkdir: created directory 'bws_merged_2022-1216/preprocessed'
# mkdir: created directory 'bws_merged_2022-1216/preprocessed-full'

mkdir -p bws_merged_2022-1216/{unprocessed,preprocessed,preprocessed-full}/{param_ignoreDuplicates-FALSE,param_ignoreDuplicates-TRUE}
# mkdir: created directory 'bws_merged_2022-1216/unprocessed/param_ignoreDuplicates-FALSE'
# mkdir: created directory 'bws_merged_2022-1216/unprocessed/param_ignoreDuplicates-TRUE'
# mkdir: created directory 'bws_merged_2022-1216/preprocessed/param_ignoreDuplicates-FALSE'
# mkdir: created directory 'bws_merged_2022-1216/preprocessed/param_ignoreDuplicates-TRUE'
# mkdir: created directory 'bws_merged_2022-1216/preprocessed-full/param_ignoreDuplicates-FALSE'
# mkdir: created directory 'bws_merged_2022-1216/preprocessed-full/param_ignoreDuplicates-TRUE'

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}



#  Set up paths, arrays, etc. for symlinking *.{bam,bai} ----------------------
cd bams_merged_2022-1216/preprocessed-full/
# /home/kalavatt/assess_transcriptome_assemblies/bams_merged_2022-1216/preprocessed-full

rel_exp="$(find_relative_path "$(pwd)/" "${p_exp}")"
echo "${rel_exp}"
# ../../../../kalavatt/2022_transcriptome-construction/results/2022-1201

for i in ${rel_exp}/files_processed-full/*_split_merge/EndToEnd/*; do
	# ., "${i}"
	echo "  Key: ${i}"
	echo "Value: $(basename "${i}")"
	echo ""

	echo "ln -s ${i} $(basename "${i}")"
	ln -s ${i} $(basename "${i}")
	echo ""
	echo ""
done
.,

cd ../preprocessed/
for i in ${rel_exp}/files_processed/*_split_merge/EndToEnd/*; do
	# ., "${i}"
	echo "  Key: ${i}"
	echo "Value: $(basename "${i}")"
	echo ""

	echo "ln -s ${i} $(basename "${i}")"
	ln -s ${i} $(basename "${i}")
	echo ""
	echo ""
done
.,

cd ../unprocessed
for i in ${rel_exp}/files_unprocessed/*_split_merge/Local/*; do
	# ., "${i}"
	echo "  Key: ${i}"
	echo "Value: $(basename "${i}")"
	echo ""

	echo "ln -s ${i} $(basename "${i}")"
	ln -s ${i} $(basename "${i}")
	echo ""
	echo ""
done
.,

cd .. && .,s  # Looks good

awd && cd bws_merged_2022-1216
.,s
# ./preprocessed:
# total 144K
# drwxrws--- 4 kalavatt 91 Dec 16 10:22 ./
# drwxrws--- 5 kalavatt 94 Dec 16 10:20 ../
# drwxrws--- 2 kalavatt  0 Dec 16 10:22 param_ignoreDuplicates-FALSE/
# drwxrws--- 2 kalavatt  0 Dec 16 10:22 param_ignoreDuplicates-TRUE/
#
# ./preprocessed-full:
# total 152K
# drwxrws--- 4 kalavatt 91 Dec 16 10:22 ./
# drwxrws--- 5 kalavatt 94 Dec 16 10:20 ../
# drwxrws--- 2 kalavatt  0 Dec 16 10:22 param_ignoreDuplicates-FALSE/
# drwxrws--- 2 kalavatt  0 Dec 16 10:22 param_ignoreDuplicates-TRUE/
#
# ./unprocessed:
# total 152K
# drwxrws--- 4 kalavatt 91 Dec 16 10:22 ./
# drwxrws--- 5 kalavatt 94 Dec 16 10:20 ../
# drwxrws--- 2 kalavatt  0 Dec 16 10:22 param_ignoreDuplicates-FALSE/
# drwxrws--- 2 kalavatt  0 Dec 16 10:22 param_ignoreDuplicates-TRUE/

#  Clear the existing directory structure; make new one ---
#+ ...that is similar to the structure in bws_2022-1215/
rmr preprocessed/
rmr preprocessed-full/
rmr unprocessed/

mkdir -p {param_ignoreDuplicates-FALSE,param_ignoreDuplicates-TRUE}/{MAPQ0,MAPQ3,MAPQ30,err_out}
.,s
# ./param_ignoreDuplicates-FALSE:
# total 224K
# drwxrws--- 6 kalavatt 95 Dec 16 10:49 ./
# drwxrws--- 4 kalavatt 91 Dec 16 10:49 ../
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 err_out/
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 MAPQ0/
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 MAPQ3/
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 MAPQ30/
#
# ./param_ignoreDuplicates-TRUE:
# total 232K
# drwxrws--- 6 kalavatt 95 Dec 16 10:49 ./
# drwxrws--- 4 kalavatt 91 Dec 16 10:49 ../
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 err_out/
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 MAPQ0/
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 MAPQ3/
# drwxrws--- 2 kalavatt  0 Dec 16 10:49 MAPQ30/
```
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  ----------------------------------------------------------------------------
#  Generate .bws from the merged .bams that have been symlinked ---------------
#  ----------------------------------------------------------------------------

#  param-ignoreDuplicates-FALSE -----------------------------------------------

#  Make a job submission script ---------------------------
cd param_ignoreDuplicates-FALSE
s_name="submit_bamCoverage_param-ignoreDuplicates-FALSE.sh"

if [[ -f "${s_name}" ]]; then rm "${s_name}"; fi
cat << script > "${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./err_out/stderr.${s_name}.%J.txt
#SBATCH --output=./err_out/stdout.${s_name}.%J.txt

#  ${s_name}
#  AG, KA
#  $(date '+%Y-%m%d')

module load deepTools

infile="\${1}"
outfile="\${2}"

#  Make directories for outfiles
mkdir -p {MAPQ0,MAPQ3,MAPQ30}


#   ---------------------------------------------------------------------------
#  Run bamCoverage ------------------------------------------------------------
#   ---------------------------------------------------------------------------

#  ...with no MAPQ filtering  -------------------------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --filterRNAstrand forward \\
    -o "MAPQ0/\${outfile}_MAPQ0_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --filterRNAstrand reverse \\
    -o "MAPQ0/\${outfile}_MAPQ0_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)


#  ...by excluding alignments less than MAPQ 3 --------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 3 \\
    --filterRNAstrand forward \\
    -o "MAPQ3/\${outfile}_MAPQ3_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 3 \\
    --filterRNAstrand reverse \\
    -o "MAPQ3/\${outfile}_MAPQ3_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)


#  ...by excluding alignments less than MAPQ 30 -------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 30 \\
    --filterRNAstrand forward \\
    -o "MAPQ30/\${outfile}_MAPQ30_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --normalizeUsing CPM \\
    --minMappingQuality 30 \\
    --filterRNAstrand reverse \\
    -o "MAPQ30/\${outfile}_MAPQ30_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

script
# vi "${s_name}"  # :q


#  Create an .bam array for generation of .bws ------------
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find "${HOME}/assess_transcriptome_assemblies/bams_merged_2022-1216" \
        -type l \
        \( \
            -name "*multi-hit-mode_1_*.bam" \
            -o -name "*multi-hit-mode_10_*.bam" \
            -o -name "*multi-hit-mode_100_*.bam" \
            -o -name "*multi-hit-mode_1000_*.bam" \
        \) \
        -print0 | \
            sort -z
)
echoTest "${bams[@]}"  # It works!


#  Submit the jobs ----------------------------------------
echo "${s_name}"  # submit_bamCoverage_param-ignoreDuplicates-FALSE.sh
for i in "${bams[@]}"; do
    echo "sbatch ${s_name} ${i} $(basename "${i}" .bam)"
    echo ""

    sbatch ${s_name} ${i} $(basename "${i}" .bam)
    echo ""
    echo ""
    sleep 0.2
done
```

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  ----------------------------------------------------------------------------
#  Generate .bws from the merged .bams that have been symlinked ---------------
#  ----------------------------------------------------------------------------

#  param-ignoreDuplicates-TRUE ------------------------------------------------

#  Make a job submission script ---------------------------
pwd
# /home/kalavatt/assess_transcriptome_assemblies/bws_merged_2022-1216/param_ignoreDuplicates-FALSE

cd ../param_ignoreDuplicates-TRUE
s_name="submit_bamCoverage_param-ignoreDuplicates-TRUE.sh"

if [[ -f "${s_name}" ]]; then rm "${s_name}"; fi
cat << script > "${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./err_out/stderr.${s_name}.%J.txt
#SBATCH --output=./err_out/stdout.${s_name}.%J.txt

#  ${s_name}
#  AG, KA
#  $(date '+%Y-%m%d')

module load deepTools

infile="\${1}"
outfile="\${2}"

#  Make directories for outfiles
mkdir -p {MAPQ0,MAPQ3,MAPQ30}


#   ---------------------------------------------------------------------------
#  Run bamCoverage ------------------------------------------------------------
#   ---------------------------------------------------------------------------

#  ...with no MAPQ filtering  -------------------------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --ignoreDuplicates \\
    --normalizeUsing CPM \\
    --filterRNAstrand forward \\
    -o "MAPQ0/\${outfile}_MAPQ0_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --ignoreDuplicates \\
    --normalizeUsing CPM \\
    --filterRNAstrand reverse \\
    -o "MAPQ0/\${outfile}_MAPQ0_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)


#  ...by excluding alignments less than MAPQ 3 --------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --ignoreDuplicates \\
    --normalizeUsing CPM \\
    --minMappingQuality 3 \\
    --filterRNAstrand forward \\
    -o "MAPQ3/\${outfile}_MAPQ3_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --ignoreDuplicates \\
    --normalizeUsing CPM \\
    --minMappingQuality 3 \\
    --filterRNAstrand reverse \\
    -o "MAPQ3/\${outfile}_MAPQ3_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)


#  ...by excluding alignments less than MAPQ 30 -------------------------------
bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --ignoreDuplicates \\
    --normalizeUsing CPM \\
    --minMappingQuality 30 \\
    --filterRNAstrand forward \\
    -o "MAPQ30/\${outfile}_MAPQ30_fwd.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

bamCoverage \\
    -p \${SLURM_CPUS_ON_NODE} \\
    -b "\${infile}" \\
    --ignoreDuplicates \\
    --normalizeUsing CPM \\
    --minMappingQuality 30 \\
    --filterRNAstrand reverse \\
    -o "MAPQ30/\${outfile}_MAPQ30_rev.bw"
echo "" | tee >(cat >&2)
echo "" | tee >(cat >&2)

script
# vi "${s_name}"  # :q


#  Create an .bam array for generation of .bws ------------
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find "${HOME}/assess_transcriptome_assemblies/bams_merged_2022-1216" \
        -type l \
        \( \
            -name "*multi-hit-mode_1_*.bam" \
            -o -name "*multi-hit-mode_10_*.bam" \
            -o -name "*multi-hit-mode_100_*.bam" \
            -o -name "*multi-hit-mode_1000_*.bam" \
        \) \
        -print0 | \
            sort -z
)
echoTest "${bams[@]}"  # It works!


#  Submit the jobs ----------------------------------------
echo "${s_name}"  # submit_bamCoverage_param-ignoreDuplicates-TRUE.sh
for i in "${bams[@]}"; do
    echo "sbatch ${s_name} ${i} $(basename "${i}" .bam)"
    echo ""

    sbatch ${s_name} ${i} $(basename "${i}" .bam)
    echo ""
    echo ""
    sleep 0.2
done
```
<br />
<br />

<a id="symlinking-gff3s-for-assessment-2022-1214-1216"></a>
## Symlinking `.gff3`s for assessment, 2022-1214-1216

<a id="the-particular-gff3s-and-their-details"></a>
### The particular `.gff3`s and their details
```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults

mwd() {
    transcriptome \
       && cd "./results/2022-1201" \
       || echo "cd'ing failed; check on this"
}


mwd

Trinity_env


ls -1 files_PASA
ls -1 files_PASA_param_gene-overlap
```

<details>
<summary><i>Results of ls -1 </i></summary>

Results of `ls -1 files_PASA`
```txt
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
```

Results of `ls -1 files_PASA_param_gene-overlap`
```txt
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
```
</details>
<br />

<a id="get-the-absolute-paths-to-the-relevant-files_pas-gff3s"></a>
#### Get the absolute paths to the relevant `files_PAS*` `.gff3`s
```bash
#!/bin/bash
#CONTINUE

cd files_PASA/
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA

.,s
#  NOTE 1/2 Inside each directory is a subdirectory with extension
#+ NOTE 2/2 .compreh_init_build: We need to target the .gff3 files in those

cd ..
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

cd files_PASA_param_gene-overlap/
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap

.,s
#  NOTE Same as above

cd ..
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

files_PASA_param_F="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA"
files_PASA_param_T="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap"

ls -1 files_PASA/*/*.compreh_init_build/*.gff3
ls -1 files_PASA_param_gene-overlap/*/*.compreh_init_build/*.gff3
```

<details>
<summary><i>Results of ls -1 </i></summary>

Results of `ls -1 files_PASA`
```txt
files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.compreh_init_build/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.compreh_init_build/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.compreh_init_build.gff3
files_PASA/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.compreh_init_build/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.compreh_init_build.gff3
```

Results of `ls -1 files_PASA_param_gene-overlap`
```txt
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.compreh_init_build/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.compreh_init_build/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.compreh_init_build/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.compreh_init_build.gff3
files_PASA_param_gene-overlap/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.compreh_init_build/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.compreh_init_build.gff3
```
</details>
<br />

<a id="the-actual-symlinking"></a>
### The actual symlinking
<details>
<summary><i>Click to view the bash code</i></summary>

<a id="clean-up-the-previous-symlinks-which-dont-work-for-alison"></a>
#### Clean up the previous symlinks, which don't work for Alison
```bash
#!/bin/bash
#CONTINUE

cd "${HOME}/tsukiyamalab/alisong" || \
	echo "cd'ing failed; check on this"

# # 2022-1214  #OUTDATED ------------------------------------
# #  Reorganizationfor IGV experiments --
# mkdir -p Kris/gtfs_2022-1214/
# # mkdir: created directory 'Kris'
# # mkdir: created directory 'Kris/gtfs_2022-1214'
#
# mv Kris_bams/ bams_2022-1212/ && mv bams_2022-1212 Kris/
# # renamed 'Kris_bams/' -> 'bams_2022-1212/'
# # renamed 'bams_2022-1212' -> 'Kris/bams_2022-1212'
#
# mv Kris_IGV_Sharing/ IGV_sharing/ && mv IGV_sharing/ Kris/
# # renamed 'Kris_IGV_Sharing/' -> 'IGV_sharing/'
# # renamed 'IGV_sharing/' -> 'Kris/IGV_sharing'
#
# cd Kris/gtfs_2022-1214/ || \
# 	echo "cd'ing failed; check on this"
#
# mkdir -p param_gene-overlap_{TRUE,FALSE}
# # mkdir: created directory 'param_gene-overlap_TRUE'
# # mkdir: created directory 'param_gene-overlap_FALSE'

#  2022-1216 ----------------------------------------------
cd assess_transcriptome_assemblies && .,
# total 203K
# drwxrws---  5 kalavatt   93 Dec 16 08:08 ./
# drwxrws--- 49 agreenla 3.2K Dec 15 09:21 ../
# drwxrws---  6 kalavatt  180 Dec 15 14:41 bams_2022-1212/
# drwxrws---  4 kalavatt  139 Dec 15 15:14 gtfs_2022-1214/
# drwxrws---  2 agreenla 1.5K Dec 15 09:41 IGV_sharing/

#  Clean out and rename gtfs_*/ directory
cd gtfs_2022-1214 && .,s
#NOTE Too much to copy in

ls -1 */*.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.compreh_init_build.gff3
# param_gene-overlap_FALSE/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local.compreh_init_build.gff3
# param_gene-overlap_TRUE/trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local.compreh_init_build.gff3

#  Unlink the .gff3 files
for i in */*.gff3; do
	echo "Unlinking ${i}"
	unlink "${i}"
	echo ""
done
```

<a id="create-symlinks-that-will-work-for-alisonother-users"></a>
#### Create symlinks that will work for Alison/other users
```bash
#!/bin/bash
#CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/gtfs_2022-1214

cd ..
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/

mv gtfs_2022-1214 gff3s_2022-1214

cd gff3s_2022-1214
# /home/kalavatt/tsukiyamalab/alisong/assess_transcriptome_assemblies/gff3s_2022-1214

#  Make subdirectories for the two ways PASA was called
mkdir -p {param_gene-overlap_TRUE,param_gene-overlap_FALSE}


#  Determine the relative paths from the present location ---------------------
#+ ...to the PASA outfile directories
find_relative_path() {
	realpath --relative-to="${1}" "${2}"
}


rel_PASA_param_F="$(find_relative_path "$(pwd)/param_gene-overlap_FALSE" "${files_PASA_param_F}")"
rel_PASA_param_T="$(find_relative_path "$(pwd)/param_gene-overlap_TRUE" "${files_PASA_param_T}")"

cd param_gene-overlap_FALSE && \
	ls -1 ${rel_PASA_param_F}/*/*.compreh_init_build/*.gff3 && \
	cd ..  # It works!

cd param_gene-overlap_TRUE && \
	ls -1 ${rel_PASA_param_T}/*/*.compreh_init_build/*.gff3 && \
	cd ..  # It works!

# #  Check
# cd param_gene-overlap_FALSE
# for i in ${rel_PASA_param_F}/*/*.compreh_init_build/*.gff3 ${rel_PASA_param_T}/*/*.compreh_init_build/*.gff3; do
# 	echo "${i}"
# 	echo "$(basename "${i}")"
# 	echo ""
# done  # It works!
# cd ..


#  Files: param_gene-overlap_FALSE ----
cd param_gene-overlap_FALSE || \
	echo "cd'ing failed; check on this"

unset key_value_F
typeset -A key_value_F
for i in ${rel_PASA_param_F}/*/*.compreh_init_build/*.gff3; do
	k="${i}"
	v="$(basename "${i}")"
	echo "${k}"
	echo "${v}"
	echo ""

	key_value_F["${k}"]+="${v}"
done

for i in "${!key_value_F[@]}"; do
	echo "  Key: ${i}"
	echo "Value: ${key_value_F[$i]}"

	ln -s "${i}" "${key_value_F[$i]}"
	echo ""
done
.,  # It works!


#  Files: param_gene-overlap_TRUE -----
cd ../param_gene-overlap_TRUE || \
	echo "cd'ing failed; check on this"

unset key_value_T
typeset -A key_value_T
for i in ${rel_PASA_param_T}/*/*.compreh_init_build/*.gff3; do
	k="${i}"
	v="$(basename "${i}")"
	echo "${k}"
	echo "${v}"
	echo ""

	key_value_T["${k}"]+="${v}"
done

for i in "${!key_value_T[@]}"; do
	echo "  Key: ${i}"
	echo "Value: ${key_value_T[$i]}"

	ln -s "${i}" "${key_value_T[$i]}"
	echo ""
done
.,  # It works!
```
</details>
<br />
<br />

<a id="scraps-to-be-incorporated"></a>
## Scraps to be incorporated
If a genome sequence is available, `Trinity` offers a method in which...
1. reads are aligned to the genome, partitioning mapped reads by locus
2. the alignments undergo local *de novo* transcriptome assembly at each locus

Thus, the genome serves as "a substrate" for grouping overlapping reads into clusters that will be separately fed into `Trinity` for *de novo* transcriptome assembly. This differs from other genome-guided approaches such as those implemented in `cufflinks` and `stringtie`, where aligned reads are stitched into transcript structures, and where <mark>transcript sequences are reconstructed based on the reference genome sequence</mark>. In the `Trinity` __GG__ approach, transcripts are reconstructed based on the actual read sequences.

Why do this? You may have a reference genome, but your sample likely comes from an organism with a genome that isn't an exact match to the reference genome. Genome-guided *de novo* assembly should capture the sequence variations contained in your RNA-Seq sample in the form of the transcripts that are *de novo* reconstructed. In comparison to genome-free *de novo* assembly, it can also help in cases where you have paralogs or other genes with shared sequences, since the genome is used to partition the reads according to locus prior to doing any *de novo* assembly. If you have a highly fragmented draft genome, then you are likely better off performing a genome-free *de novo* transcriptome assembly.
<br />
<br />

<a id="documentation-for-alisonme"></a>
## Documentation for Alison/me
I used [`PASA` (Program to Assemble Spliced Alignments)](https://github.com/PASApipeline/PASApipeline/wiki) to build our draft transcriptome assemblies following the *"comprehensive transcriptome database"* strategy documented [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db).

<a id="the-comprehensive-transcriptome-database-strategy"></a>
### The *"comprehensive transcriptome database"* strategy
The *"comprehensive transcriptome database"* strategy attempts to overcome limitations from using either the `Trinity` genome-guided (__GG__) or `Trinity` genome-free (__GF__) assembly approaches alone, yielding what is likely a more comprehensive representation of the transcriptome.

<a id="pros-and-cons-of-the-trinity-gg-and-gf-approaches"></a>
#### Pros and cons of the `Trinity` GG and GF approaches
1. For example, some pros and cons of using the `Trinity` __GG__ approach alone:
	+ Cons
		* an inability to capture transcripts associated with non-annotated features in the reference genome
		* an inability to capture transcripts that align partially or otherwise poorly to the reference genome
		* an inability to capture any other transcripts that aren't properly represented by the reference genome
		* unmapped reads are not included in draft transcriptome assemblies
	+ Pros
		* reads are grouped based on
			- first, alignment to the reference genome
			- second, k-mer composition among reads in the grouping that results from alignment
<br />
<br />

2. And some pros and cons of using the `Trinity` __GF__ approach alone:
	+ Cons
		* reads are grouped based on k-mer composition alone
			- *(this is a "con" in certain contexts and a "pro" in others)*
			- for example, it is a "con" if there are many paralogs (or other features that share sequence similarity) in the organism's genome
			- "The k-mer composition suggests a given read could be associated with many different groups, so which group should it go into? "
	+ Pros
		* reads are grouped based on k-mer composition alone
			- *(this is a "con" in certain contexts and a "pro" in others)*
			- this a "pro" in cases where the quality of the reference genome is poor
		* an ability to capture transcripts associated with non-annotated features in a reference genome
		* an ability to capture transcripts that would align partially to a reference genome
		* an ability to capture any other transcripts that aren't properly represented by the reference genome
		* reads that would be unmapped following alignment are included in draft transcriptome assemblies

<a id="input-for-the-comprehensive-transcriptome-database-strategy"></a>
#### Input for the *"comprehensive transcriptome database"* strategy
In `PASA`'s *"comprehensive transcriptome database"* strategy, we use as input the results from calling `Trinity` twice:
1. We input a `.fasta` file from running `Trinity` in __GF__ mode
	+ `#TODO #INPROGRESS` Summarize what this is, how it works
	+ called with `--jaccard_clip`
	+ input is `.fastq` files processed as described below and filtered to contain only alignments to *S. cerevisiae*
2. We input a `.fasta` file that results from running `Trinity` in __GG__ mode
	+ `#TODO #INPROGRESS` Summarize what this is, how it works
	+ called with `--jaccard_clip`
	+ input is `.bam` files processed as described below and filtered to contain only alignments to *S. cerevisiae*

<a id="how-i-called-the-different-programs-including-rationale-and-other-details"></a>
### How I called the different programs, including rationale and other details
- Experiment begun `2022-1201`; rough draft work begun `2022-1101`
- Automated pipeline `#INPROGRESS`
<a id="%E2%98%85-pasa"></a>
#### <sup>★</sup> `PASA`
`#DEKHO`
<a id="details"></a>
##### Details
- I called `PASA`<sup>___‡___</sup> using __three__ *"kinds"* of input in __three__ *"combinations"*
	+ That resulted in total of __nine__ different draft transcriptome assemblies to assess
- <sup>___‡___</sup>I called `PASA` in two different ways:
	+ Once without the parameter `--gene_overlap` and once with the parameter  `#TODO` Provide the rationale and invocations
	+ So, actually, there are __18__ (9 × 2) different draft transcriptome assemblies to assess

<a id="first-heres-a-breakdown-of-the-kinds-of-input"></a>
###### First, here's a breakdown of the *"kinds"* of input
- Three kinds using __"unprocessed"__ `.bam`s and .`fastq`s
	+ adapter- and quality-trimmed with `trim_galore`: `FALSE`
	+ k-mer-corrected with `rcorrector`: `FALSE`
	+ aligned with `STAR` in `Local` mode (which allows "soft clipping")
- Three kinds using __"processed"__ `.bam`s and .`fastq`s
	+ adapter- and quality-trimmed with `trim_galore`: `TRUE`  `#TODO` Provide the rationale and invocation
	+ k-mer-corrected with `rcorrector`: `FALSE`
	+ aligned with `STAR` in `EndToEnd` mode (which *doesn't* allow "soft clipping")
- Three kinds using __"processed (full)"__ `.bam`s and .`fastq`s
	+ adapter- and quality-trimmed with `trim_galore`: `TRUE`  `#TODO` Provide the rationale and invocation
	+ k-mer-corrected with `rcorrector`: `TRUE`  `#TODO` Provide the full invocation
	+ aligned with `STAR` in `EndToEnd` mode (which *doesn't* allow "soft clipping")

<a id="and-heres-a-breakdown-of-the-input-with-respect-to-both-kinds-and-combinations"></a>
###### And here's a breakdown of the input with respect to both *"kinds"* and *"combinations"*
- __"unprocessed"__
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 1 *(only __one__ alignment is allowed per read)*
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 10 *(up to __10__ alignments are allowed per read)*
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 100 *(up to __100__ alignments are allowed per read)*
- __"processed"__
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 1
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 10
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 100
- __"processed (full)"__
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 1
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 10
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 100

<a id="the-how"></a>
##### The how
<a id="--gene_overlap-true"></a>
###### `--gene_overlap` `TRUE`
<details>
<summary><i>Click to view the bash script</i></summary>

The calls to both `Launch_PASA_pipeline.pl` and `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./sh_err_out/err_out/submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.%J.out.txt

#  submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.sh
#  KA
#  2022-1213

str_experiment="${1}"
str_accessions="${2}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is ${PASAHOME}"
echo ""

cd "files_PASA_param_gene-overlap/${str_experiment}"
echo "Working directory from which the script is called: $(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \
    --no-home \
    --bind "${HOME}/genomes/sacCer3/Ensembl/108" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    "${HOME}/singularity-docker-etc/PASA.sif" \
        "${PASAHOME}/Launch_PASA_pipeline.pl" \
            --CPU ${SLURM_CPUS_ON_NODE} \
            -c "${str_experiment}.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "${str_experiment}.transcripts.fasta.clean" \
            -T \
            -u "${str_experiment}.transcripts.fasta" \
            --TDN "${str_accessions}" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            -L \
            --annots "Saccharomyces_cerevisiae.R64-1-1.108.gff3" \
            --gene_overlap 50.0  \
            --ALIGNERS "blat,gmap,minimap2" \
                1> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stdout.log") \
                2> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
    #  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
    if [[ -s "${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
        singularity run \
            --no-home \
            --bind "${HOME}/genomes/sacCer3/Ensembl/108" \
            --bind "$(pwd)" \
            --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
            "${HOME}/singularity-docker-etc/PASA.sif" \
                ${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \
                    -c "${str_experiment}.align_assembly.config" \
                    -t "${str_experiment}.transcripts.fasta" \
                    --prefix "${str_experiment}.compreh_init_build" \
                    --min_per_ID 95 \
                    --min_per_aligned 30 \
                        1> >(tee -a "${str_experiment}.build_comprehensive_transcriptome.stdout.log") \
                        2> >(tee -a "${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
    else
        echo "${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
        echo "Check on things..."
    fi
fi
```
</details>
<br />

<a id="--gene_overlap-false"></a>
###### `--gene_overlap` `FALSE`

<details>
<summary><i>Click to view the bash scripts</i></summary>

The calls to `Launch_PASA_pipeline.pl`
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.out.txt

#  submit_launch-PASA-pipeline.sh
#  KA
#  2022-1212

str_experiment="${1}"
str_accessions="${2}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is ${PASAHOME}"
echo ""

cd "files_PASA_param_gene-overlap/${str_experiment}"
echo "Working directory from which the script is called: $(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \
    --no-home \
    --bind "${HOME}/genomes/sacCer3/Ensembl/108" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    "${HOME}/singularity-docker-etc/PASA.sif" \
        "${PASAHOME}/Launch_PASA_pipeline.pl" \
            --CPU ${SLURM_CPUS_ON_NODE} \
            -c "${str_experiment}.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "${str_experiment}.transcripts.fasta.clean" \
            -T \
            -u "${str_experiment}.transcripts.fasta" \
            --TDN "${str_accessions}" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS "blat,gmap,minimap2" \
                1> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stdout.log") \
                2> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)
```

The calls to `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.out.txt

#  submit_launch-PASA-pipeline.sh
#  KA
#  2022-1212

str_experiment="${1}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is ${PASAHOME}"
echo ""

cd "files_PASA/${str_experiment}"
echo "Working directory from which the script is called: $(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \
    --no-home \
    --bind "${HOME}/genomes/sacCer3/Ensembl/108/DNA" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    "${HOME}/singularity-docker-etc/PASA.sif" \
        ${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \
            -c "${str_experiment}.align_assembly.config" \
            -t "${str_experiment}.transcripts.fasta" \
            --prefix "${str_experiment}.compreh_init_build" \
            --min_per_ID 95 \
            --min_per_aligned 30 \
                1> >(tee -a "${str_experiment}.stdout.log") \
                2> >(tee -a "${str_experiment}.stderr.log" >&2)
```
</details>
<br />

<a id="the-meaning-of-the-parameters"></a>
###### The meaning of the parameters
`#TODO`
<br />
<br />

<a id="%E2%98%85-trinity"></a>
#### <sup>★</sup> `Trinity`
<a id="details-1"></a>

<a id="details-1"></a>
##### Details
<a id="the-how-1"></a>

<a id="the-how-1"></a>
##### The how
<a id="gg"></a>

<a id="gg"></a>
###### GG
<a id="gf"></a>

<a id="gf"></a>
###### GF
<br />
<br />

<a id="%E2%98%85-star"></a>
#### <sup>★</sup> `STAR`
<br />
<br />

<a id="%E2%98%85-rcorrector"></a>
#### <sup>★</sup> `rcorrector`
<br />
<br />

<a id="%E2%98%85-trim_galore"></a>
#### <sup>★</sup> `trim_galore`
<br />
<br />

<a id="downloading-things-2022-1213"></a>
## Downloading things... (2022-1213)
- `#IMPORTANT` SGD files are derived from UCSC genome resources; see... `#TODO` Reference the source of this information
- `#TODO` Give this section a better name
<a id="grab-a-node-get-to-the-right-directory-etc-1"></a>
### Grab a node, get to the right directory, etc.
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults

mwd() {
    transcriptome \
       && cd "./results/2022-1201" \
       || echo "cd'ing failed; check on this"
}


mwd

Trinity_env
ml Singularity
```
</details>
<br />
<br />

<a id="get-the-sgd-_genome_current_releasetgz"></a>
### [Get the SGD `_genome_Current_Release.tgz`](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/)
- The most recent genome release is from 2021-0427
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir -p files_features/SGD_genome-current-release
cd files_features/SGD_genome-current-release || \
	echo "cd'ing failed; check on this"

    # http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_Current_Release.tgz
link="http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases"
files=(
    genome_releases.README
    S288C_reference_genome_Current_Release.tgz
    README.html
)
for i in "${files[@]}"; do curl -L "${link}/${i}" -o "${i}"; done
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2157k      0 --:--:-- --:--:-- --:--:-- 2157k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2485k      0 --:--:-- --:--:-- --:--:-- 2507k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2191k      0 --:--:-- --:--:-- --:--:-- 2191k
```

<a id="get-the-sgd-other_features-files"></a>
### [Get the SGD `other_features` files](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

../..

mkdir -p files_features/SGD_other-features
cd files_features/SGD_other-features || \
	echo "cd'ing failed; check on this"

link="http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features"
files=(
	other_features_genomic_1000.fasta.gz
	other_features_genomic.fasta.gz
	other_features.README
	README.html
)
for i in "${files[@]}"; do curl -L "${link}/${i}" -o "${i}"; done
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  637k  100  637k    0     0  3125k      0 --:--:-- --:--:-- --:--:-- 3125k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  186k  100  186k    0     0  1023k      0 --:--:-- --:--:-- --:--:-- 1023k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100   775  100   775    0     0   5827      0 --:--:-- --:--:-- --:--:--  5827
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100   311  100   311    0     0   4573      0 --:--:-- --:--:-- --:--:--  4573
```
<br />
<br />

<a id="parse-the-sgd-fasta-headers-to-make-dataframes-etc"></a>
## Parse the SGD `.fasta` headers to make dataframes, etc.
- `#INPROGRESS` Make a `python` script for using the headers in the SGD `other_features` `.fasta` to make a `pandas` dataframe, which can be used in turn to make `.bed`, `.gtf`, etc. files
- [Details about the `.bed` format](https://genome.ucsc.edu/FAQ/FAQformat.html#format1)

<details>
<summary><i>Scratch work for working with only the 'other_features' .fasta (2022-1214-1214)</i></summary>

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 13 10:14:09 2022

@author: kalavatt
"""

# bioinformatics.stackexchange.com/questions/5435/how-to-create-a-bed-file-from-fasta
import numpy as np
import pandas as pd
# import sys


# stackoverflow.com/questions/43067373/split-by-comma-and-how-to-exclude-comma-from-quotes-in-split
def tokenize(string, separator = ',', quote = '"'):
    """
    Split a comma separated string into a List of strings.

    Separator characters inside the quotes are ignored.

    :param string: A string to be split into chunks
    :param separator: A separator character
    :param quote: A character to define beginning and end of the quoted string
    :return: A list of strings, one element for every chunk
    """
    comma_separated_list = []

    chunk = ''
    in_quotes = False

    for character in string:
        if character == separator and not in_quotes:
            comma_separated_list.append(chunk)
            chunk = ''
        else:
            chunk += character
            if character == quote:
                in_quotes = False if in_quotes else True

    comma_separated_list.append(chunk)

    return comma_separated_list

# -----------------------------------------------------------------------------
# Drafting it all... ----------------------------------------------------------
# -----------------------------------------------------------------------------
# Read in .fasta
fasta = "other_features_genomic.fasta"

# Extract the headers
headers = []
with open(fasta) as f:
    header = None
    for line in f:
        if line.startswith('>'):  # Identifies fasta header line
            headers.append(line[1:-1])  # Append all of the line that isn't >
            header = line[1:]  # Reset header
del(fasta)
del(f)
del(line)

# Add a 'forward complement' designation to match the presence of a 'reverse
# complement' designation on certain lines
headers_fix_complement = []
for i in headers:
    if i.find('Genome Release 64-3-1, reverse complement,') != -1:
        headers_fix_complement.append(i)
    else:
        headers_fix_complement.append(
            i.replace(
                'Genome Release 64-3-1,',
                'Genome Release 64-3-1, forward complement,'
            )
        )
del(i)

header_list = []
for i in headers_fix_complement:
    # print(type(i))
    print(tokenize(i))
    header_list.append(tokenize(i))
del(i)

# -----------------------------------------------------------------------------
# Add columns names
# stackoverflow.com/questions/18915941/create-a-pandas-dataframe-from-generator
# sparkbyexamples.com/pandas/pandas-add-column-names-to-dataframe/
header_df = pd.DataFrame(
    header_list,
    columns = [
        'feature', 'coord_written', 'release', 'strand_written',
        'category', 'notes'
    ]
)

# Clean up variables
del(header)
del(headers)
del(header_list)
del(headers_fix_complement)

# There are leading spaces in string columns; strip these away
# stackoverflow.com/questions/49551336/pandas-trim-leading-trailing-white-space-in-a-dataframe
header_df = header_df.applymap(
    lambda x: x.strip() if isinstance(x, str) else x
)

# -----------------------------------------------------------------------------
# Split column 'feature' on space
# stackoverflow.com/questions/37333299/splitting-a-pandas-dataframe-column-by-delimiter
header_df[['name_systematic', 'name_standard', 'SGDID']] = header_df[
    'feature'
].str.split(' ', expand = True)

# Check that 'name_standard' is exactly the same as 'feature'
# geeksforgeeks.org/how-to-compare-two-columns-in-pandas/
header_df['name_standard'].equals(header_df['name_systematic'])  # False

# Return where two columns are different
header_df.query('name_standard != name_systematic')
#     feature                    coord  ... name_standard             SGDID
# 11   ARS109      Chr I from 159907-160127  ...    ARS101  SGDID:S000077372
# 86    RE301      Chr III from 29108-29809  ...        RE  SGDID:S000303804
# 142  ARS416     Chr IV from 462567-462622  ...      ARS1  SGDID:S000029652
# 405  ARS808   Chr VIII from 140349-141274  ...      ARS2  SGDID:S000029042
# 444  ARS913     Chr IX from 214624-214754  ...    ARS901  SGDID:S000007644

# Details on where there are differences:
# yeastgenome.org/locus/ARS101
# yeastgenome.org/locus/S000303804
# yeastgenome.org/locus/S000029652
# yeastgenome.org/locus/S000029042
# yeastgenome.org/locus/S000007644

# -----------------------------------------------------------------------------
# Strip string 'SGDID:' from column 'SGDID'
# stackoverflow.com/questions/13682044/remove-unwanted-parts-from-strings-in-a-column
header_df['SGDID'] = header_df['SGDID'].str.replace('SGDID:', '')

# Create 'coord_...' columns derived from 'coord_written'
header_df['coord_pre_y'] = header_df['coord_written']\
        .str.replace(' from ', ':').str.replace('Chr ', 'Chr')
header_df['coord_pre_n'] = header_df['coord_written']\
        .str.replace(' from ', ':').str.replace('Chr ', '')

# -----------------------------------------------------------------------------
# Populate new column based on value in other column
# towardsdatascience.com/create-new-column-based-on-other-columns-pandas-5586d87de73d
# stackoverflow.com/questions/10715519/conditionally-fill-column-values-based-on-another-columns-value-in-pandas
# numpy.org/doc/stable/reference/generated/numpy.where.html
header_df['strand'] = np.where(
    header_df['strand_written'] == 'reverse complement', '-', '+'
)

# -----------------------------------------------------------------------------
# Extracting substrings to populate columns 'chr', 'start', 'end'
# # Extract substring before colon for 'chr'
# header_df['coord_pre_n'].str.split(':').str[0]

header_df['chr'] = header_df['coord_pre_n']\
    .str.split(':').str[0]

# stackoverflow.com/questions/20025882/add-a-string-prefix-to-each-value-in-a-string-column-using-pandas
header_df['chr_pre_y'] = 'Chr' + header_df['chr']

# -------------------------------------
# # Extract substring after colon for 'start', 'end'
# header_df['coord_pre_n'].str.split(':').str[1]

# start -----------
# #   if 'strand' is '+', take [0] for 'start'
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[0]  # '+' 'start'
#
# # elif 'strand' is '-', take [1] for 'start'
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[1]  # '-' 'start'

header_df['start'] = np.where(
    header_df['strand'] == '+',
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[0],
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[1]
)

# end -------------
# #   if 'strand' is '+', take [1] for 'end';
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[1]  # '+' 'end'
#
# # elif 'strand' is '-', take [0] for 'end'
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[0]  # '-' 'end'

header_df['end'] = np.where(
    header_df['strand'] == '+',
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[1],
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[0]
)
```
</details>
<br />
<br />

<br />
<br />

<a id="questions-about-bamcoverage"></a>
## Questions about `bamCoverage`
<a id="on---filterrnastrand"></a>
### On `--filterRNAstrand`
```txt
Possible choices: forward, reverse

Selects RNA-seq reads (single-end or paired-end) originating from genes on the given strand. This option assumes a standard dUTP-based library preparation (that is, –filterRNAstrand=forward keeps minus-strand reads, which originally came from genes on the forward strand using a dUTP-based method). Consider using –samExcludeFlag instead for filtering by strand in other contexts.
```
Were our files made with a dUTP-based library preparation method?

In the `stdout.*.txt` files for the job submissions, we see that only some 30-50% of alignments are being used; the rest are being filtered out, even when we set `--minMappingQuality 0`. Is this normal? Can check these against the slurm.out files from your previous runs of `bamCoverage`?
