
`#work_make-symlinks-etc.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

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
				1. [Notes about the previous script for teaching purposes](#notes-about-the-previous-script-for-teaching-purposes)
			1. [Make `submit_bamCoverage.sh`](#make-submit_bamcoveragesh)
			1. [Get the `.bam`s of interest into an array \(or glob\) to be looped over for job submissions](#get-the-bams-of-interest-into-an-array-or-glob-to-be-looped-over-for-job-submissions)
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
1. [Questions about `bamCoverage`](#questions-about-bamcoverage)
	1. [On `--filterRNAstrand`](#on---filterrnastrand)
1. [Linking and/or symlinking to data galore, 2022-0103-0105](#linking-andor-symlinking-to-data-galore-2022-0103-0105)
	1. [The plan of attack](#the-plan-of-attack)
	1. [Replace string "`trim-rcor`" with "`rcor`" in appropriate directories](#replace-string-trim-rcor-with-rcor-in-appropriate-directories)
		1. [Grab a node, get to the work directory, and load the proper environment](#grab-a-node-get-to-the-work-directory-and-load-the-proper-environment)
		1. [Rename incorrectly labeled `*trim-rcor*` files to `*rcor*`](#rename-incorrectly-labeled-trim-rcor-files-to-rcor)
			1. [Create arrays of specific, approrpiate files for renaming](#create-arrays-of-specific-approrpiate-files-for-renaming)
			1. [Use the arrays to rename appropriate files](#use-the-arrays-to-rename-appropriate-files)
	1. [Copy/rename \(and rename some more\) for use by Alison](#copyrename-and-rename-some-more-for-use-by-alison)
		1. [Get files of interest into arrays](#get-files-of-interest-into-arrays)
		1. [Copy/rename files of interest into the "assessment" directory](#copyrename-files-of-interest-into-the-assessment-directory)
		1. [In the "assignment" directory, do additional renaming work](#in-the-assignment-directory-do-additional-renaming-work)
	1. [Rename "`trim-rcor`" strings to "`rcor`" in "`./files_Trinity*`", "`./files_processed-rcor-only`"](#rename-trim-rcor-strings-to-rcor-in-files_trinity-files_processed-rcor-only)
		1. [Get directories of interest into arrays, then rename them as appropriate](#get-directories-of-interest-into-arrays-then-rename-them-as-appropriate)
		1. [Work with "`./files_Trinity*`"](#work-with-files_trinity)
		1. [Work with "`./files_processed-rcor-only`"](#work-with-files_processed-rcor-only)
			1. [Notes](#notes)
			1. [Code to accomplish the above](#code-to-accomplish-the-above)
	1. [Symlink to the individual and merged `.bam`s, renaming them for easy use by Alison](#symlink-to-the-individual-and-merged-bams-renaming-them-for-easy-use-by-alison)
		1. [Create an array of appropriate `.bam`s](#create-an-array-of-appropriate-bams)
		1. [Clean up/set up '`awd`', then symlink the `.bam`s](#clean-upset-up-awd-then-symlink-the-bams)
		1. [Create an array of appropriate `.bai`s and symlink them](#create-an-array-of-appropriate-bais-and-symlink-them)
	1. [Generate `.bw`s for the `.bam`s](#generate-bws-for-the-bams)

<!-- /MarkdownTOC -->
</details>
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
<summary><i>Click to view code: Go to work directory, create symbolic links for files of interest</i></summary>

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
<summary><i>Printed to terminal: `.,s` in `~/tsukiyamalab/alisong/Kris_bams` </i></summary>

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
<summary><i>Click to view code: Grab a node, get to the right directory, symlink 'assess_transcriptome_assemblies/', load conda/mamba environment</i></summary>

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
<details>
<summary><i>Click to view code: Go to 'bams_2022-1212/', run `.,`, etc., run `head -1000 slurm-5685397.out`</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: `head -1000 slurm-5685397.out`</i></summary>

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

<details>
<summary><i>Click to view code and results printed to terminal: `., ../preprocessed`</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

., ../preprocessed
```

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

- <mark>`#ERROR` The problem is that the symlink is pointing to my home directory, which does not exist on Alison's (or anyone else's) system...</mark>
- Let's see how we can address this...

<a id="fix-the-symlinks-to-the-bams-linked-on-2022-1212"></a>
### Fix the symlinks to the `.bam`s linked on 2022-1212
<a id="preprocessed-bams"></a>
#### "preprocessed" `.bam`s
~~`#TODO` Fix things when `samtools split`, `samtools index`, and `samtools sort -n` are completed~~ *Done.*
<details>
<summary><i>Go to bams_2022-1212/preprocessed, unlink the unusable symlinks (fr/absolute paths), create usable symlinks (fr/relative paths), run `.,`</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: `.,`</i></summary>

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
<details>
<summary><i>Go to bams_2022-1212/unprocessed, unlink the unusable symlinks (fr/absolute paths), create usable symlinks (fr/relative paths), run `.,`</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: `.,`</i></summary>

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
<details>
<summary><i>Go to bams_2022-1212/processed-full, unlink the unusable symlinks (fr/absolute paths), create usable symlinks (fr/relative paths), run `.,`</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: `.,`</i></summary>

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
<details>
<summary><i>Go to bams_2022-1212/bigwig_test1, unlink unusable symlinks to bams (fr/absolute paths), then archive AG's work with the broken links</i></summary>

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
</details>
<br />

<a id="scratch-bamcoverage_strandselectsh"></a>
##### Scratch: `bamcoverage_strandselect.sh`
Now, update AG's script, `bamcoverage_strandselect.sh`, to...  
`#QUESTION` Does `deepTools` `bamCoverage` have a `parallel` mode? `#ANSWER` ~~No...~~*Yes.*

<a id="before-ag"></a>
###### Before (AG)
<details>
<summary><i>The contents of the shell script `bamcoverage_strandselect.sh`</i></summary>

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
</details>
<br />

<a id="after-ka"></a>
###### After (KA)
<details>
<summary><i>Contents of new script, `submit_bamCoverage.sh`</i></summary>

`#NOTE` `2023-0104` I neglected to rename `#SBATCH --error=` and `#SBATCH --output=`
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
</details>
<br />

<a id="notes-about-the-previous-script-for-teaching-purposes"></a>
###### Notes about the previous script for teaching purposes
<details>
<summary><i>Notes about the previous script for teaching purposes</i></summary>

Some quick notes about the previous script for teaching purposes:
- Important
	+ `bamCoverage` has a parameter to run in parallel, but it won't recognize it unless you call it with the `-p` option
		* So, without specifying `-p`, `THREADS` becomes an unused variable
		* Also, when submitting the job to `SLURM`, you need to tell it to assign 8 (or however many) cores/CPUs to the job,
			- either through the call to `sbatch` (`-c` or `--cpus-per-task`)
			- or through a `#SBATCH` line in the job submission script: `#SBATCH --cpus-per-task=#`
	+ I recommend to get used to explicitly telling `SLURM` things with lines in the script that start with `#SBATCH` (see below)
	+ Rather than have the `for loop` in the job submission script, use the for loop outside of the script;
		* Write the script to take a single infile
		* Then,loop over the files, applying the script to each file
		* I'll show an example below...
	+ To organize your results, explicitly specify to `SLURM` that you want `stderr` and `stdout` files
		* Save the files to specific locations *(optional, but important for organizing your results/staying on top of things)*
		* ...with specific names
	+ ~~Don't do directory remodeling, etc. inside the script~~ If it's limited in scope, then it's fine, especially if it's a thing you want to do repeatedly with consistent, specific directory changes
- Less important
	+ I told you yesterday that a MAPQ score of 30 represents of 99.99% that the mapped position is correct, but that's incorrect&mdash;it's actually 99.9%
		* Some details on MAPQ [here](http://www.acgt.me/blog/2014/12/16/understanding-mapq-scores-in-sam-files-does-37-42)
	+ Delete all of the unused variables&mdash;they're confusing for other people using your script
</details>
<br />

<a id="make-submit_bamcoveragesh"></a>
##### Make `submit_bamCoverage.sh`
<details>
<summary><i>Click to view code: HEREDOC to make `submit_bamCoverage.sh`</i></summary>

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
</details>
<br />

<a id="get-the-bams-of-interest-into-an-array-or-glob-to-be-looped-over-for-job-submissions"></a>
##### Get the `.bam`s of interest into an array (or glob) to be looped over for job submissions
<details>
<summary><i>More notes for teaching purposes</i></summary>

- In my attempts to come up with something teachable, I think I've gone about doing this in a way that is, in some ways, not good
- What's not good about it?
	+ For one, we're parsing the results of `ls`, which is frowned upon (but somewhat fine for rough-draft work and assuming your filenames are "normal")
		* [unix.stackexchange.com/questions/128985/why-not-parse-ls-and-what-to-do-instead](https://unix.stackexchange.com/questions/128985/why-not-parse-ls-and-what-to-do-instead)
		* [mywiki.wooledge.org/ParsingLs](http://mywiki.wooledge.org/ParsingLs)
	+ Very poor control of what's being globbed onto
	+ Using relative paths to find things: This code snippet is even more context-sensitive, and thus breakable, than normal
</details>
<br />

<details>
<summary><i>Click to view code: Get the .bams of interest into an array (or glob) to be looped over; submit jobs for submit_bamCoverage.sh</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: Submit jobs for submit_bamCoverage.sh</i></summary>

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
<a id="checking-on-what-bams-have-been-symlinked"></a>
### Checking on what `.bam`s have been symlinked
<details>
<summary><i>Click to view: Get on a node, load conda environment, go to work directory, check on things</i></summary>

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
</details>
<br />

<a id="reorganize-the-bws"></a>
### Reorganize the `.bw`s
<details>
<summary><i>Click to view: Rename and reorganize work directory, check on things</i></summary>

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
</details>
<br />

<a id="create---ignoreduplicates-bws-for-multi-hit-mode-100-1000"></a>
### Create `--ignoreDuplicates` `.bw`s for `multi-hit-mode 100`, `1000`
<details>
<summary><i>Click to view code: Create --ignoreDuplicates .bws for multi-hit-mode 100, 1000</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: Create --ignoreDuplicates .bws for multi-hit-mode 100, 1000</i></summary>

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
<details>
<summary><i>Click to view code: Make the submission script for non --ignoreDuplicates .bws for multi-hit-mode 1, 10, 100, 1000, then submit jobs</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: Submission of jobs</i></summary>

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
<details>
<summary><i>Click to view code: Go to work directory, load environment, symlink to merged .bams, and create .bws</i></summary>

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
</details>
<br />
<br />

<a id="symlinking-gff3s-for-assessment-2022-1214-1216"></a>
## Symlinking `.gff3`s for assessment, 2022-1214-1216
<a id="the-particular-gff3s-and-their-details"></a>
### The particular `.gff3`s and their details
<details>
<summary><i>Click to view code: Go to work directory, load environment, run `ls -1` on `files_PASA/` and `files_PASA_param_gene-overlap/`</i></summary>

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
</details>
<br />

<details>
<summary><i>Printed to terminal: Run `ls -1` </i></summary>

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
<details>
<summary><i>Click to view code: Target `*.compreh_init_build/*.gff3`, then run `ls -1`</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

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
</details>
<br />

<details>
<summary><i>Printed to terminal: Run `ls -1`</i></summary>

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
<a id="clean-up-the-previous-symlinks-which-dont-work-for-alison"></a>
#### Clean up the previous symlinks, which don't work for Alison
<details>
<summary><i>Click to view code: Go to work directory, check on things, then create symlinks</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

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
</details>
<br />

<a id="create-symlinks-that-will-work-for-alisonother-users"></a>
#### Create symlinks that will work for Alison/other users
<details>
<summary><i>Click to view code: Rename/reorganize things, check on things, create symlinks</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

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

<a id="questions-about-bamcoverage"></a>
## Questions about `bamCoverage`
<a id="on---filterrnastrand"></a>
### On `--filterRNAstrand`
```txt
Possible choices: forward, reverse

Selects RNA-seq reads (single-end or paired-end) originating from genes on the given strand. This option assumes a standard dUTP-based library preparation (that is, –filterRNAstrand=forward keeps minus-strand reads, which originally came from genes on the forward strand using a dUTP-based method). Consider using –samExcludeFlag instead for filtering by strand in other contexts.
```
Were our files made with a dUTP-based library preparation method?

<mark>`#TODO` AG answered this in an email from sometime in mid-to-late December: Copy the answer in here</mark>

In the `stdout.*.txt` files for the job submissions, we see that only some 30-50% of alignments are being used; the rest are being filtered out, even when we set `--minMappingQuality 0`. Is this normal? Can check these against the `*slurm.out` files from your previous runs of `bamCoverage`?
<br />
<br />

<a id="linking-andor-symlinking-to-data-galore-2022-0103-0105"></a>
## Linking and/or symlinking to data galore, 2022-0103-0105
<a id="the-plan-of-attack"></a>
### The plan of attack
- To be specific, `#TODO` Symlink to `.bam`s, merged `.bam`s~~, and `.gff3`s~~
	+ However, first, `#TODO` For all subdirectories and files in `files_PASA_rcor-only_*`, replace string "`trim-rcor`" with either "`rcor`" or "`rcor-only`"
	+ Put another way, `#TODO` After the completion of remaining jobs, rename appropriate '`trim-rcor`'/actually only '`rcor`' string-containing files; carefully determine the appropriate files before running anything
	+ Likewise, `#TODO` Determine the `MarkDown` notebooks and shell scripts in which the '`trim-rcor`' string should be replaced with the string '`rcor`', then make the appropriate changes
- When the above is completed, `#TODO` Create `.bw`s for the `.bam`s, i.e., both the individual and merged ones
- `#DONE` `2023-0104`: Have renamed, copied, and further renamed the `.gff3`s for use by Alison; it remains to...
	+ `#TODO` Symlink the individual and merged `.bam`s
	+ `#TODO` Create `.bw`s for `.bam`s

<a id="replace-string-trim-rcor-with-rcor-in-appropriate-directories"></a>
### Replace string "`trim-rcor`" with "`rcor`" in appropriate directories
<a id="grab-a-node-get-to-the-work-directory-and-load-the-proper-environment"></a>
#### Grab a node, get to the work directory, and load the proper environment
<details>
<summary><i>Click to view code: Grab a node, get to the work directory, and load the proper environment</i></summary>

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
```
</details>
<br />

<a id="rename-incorrectly-labeled-trim-rcor-files-to-rcor"></a>
#### Rename incorrectly labeled `*trim-rcor*` files to `*rcor*`
<a id="create-arrays-of-specific-approrpiate-files-for-renaming"></a>
##### Create arrays of specific, approrpiate files for renaming
<details>
<summary><i>Click to view code: Create arrays of specific, approrpiate files for renaming</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset directories
typeset -a directories
while IFS=" " read -r -d $'\0'; do
    directories+=( "${REPLY}" )
done < <(\
    find . \
	    -maxdepth 2 \
		-type d \
		-name "*rcor-only*" \
		-not -path "./files_Trinity*" \
		-not -path "./files_processed-rcor-only" \
		-print0 \
			| sort -z
)
echoTest "${directories[@]}"
# ./files_PASA_rcor-only_gene-overlap-10.0
# ./files_PASA_rcor-only_gene-overlap-20.0
# ./files_PASA_rcor-only_gene-overlap-30.0
# ./files_PASA_rcor-only_gene-overlap-40.0
# ./files_PASA_rcor-only_gene-overlap-50.0
# ./files_PASA_rcor-only_gene-overlap-60.0
# ./files_PASA_rcor-only_gene-overlap-70.0
# ./files_PASA_rcor-only_gene-overlap-80.0
# ./files_PASA_rcor-only_gene-overlap-90.0
# ./files_PASA_rcor-only_minimal-overlap
# ./files_PASA_rcor-only_stringent-alignment-overlap-10.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-20.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-30.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-40.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-50.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-60.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-70.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-80.0
# ./files_PASA_rcor-only_stringent-alignment-overlap-90.0
```
</details>
<br />

- `#TODO` Need to do something like the above for "`./files_Trinity*`" "`./files_processed-rcor-only`"
- `#IMPORTANT` `2023-0104`: Don't forget the above `#TODO`

<a id="use-the-arrays-to-rename-appropriate-files"></a>
##### Use the arrays to rename appropriate files
`#NOTE` Here, I ended up pursuing a tact in which we rename directories in order of top-to-bottom hierarchy; once that's done, move on to renaming the individual files; if renaming is not done in this order, then directory names will change prior to file names, thereby breaking the paths to access the files; errors will be thrown

<details>
<summary><i>Click to view code: Use the arrays to rename appropriate files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Rename the directories: -maxdepth 1
for i in "${directories[@]}"; do
	unset tmp
	typeset -a tmp
	while IFS=" " read -r -d $'\0'; do
	    tmp+=( "${REPLY}" )
	done < <(\
		find "${i}" \
			-maxdepth 1 \
			-type d \
			-name "*trim-rcor*" \
			-print0 \
				| sort -z \
	)
	# echoTest "${tmp[@]}"
	for i in "${tmp[@]}"; do
		rename 's/trim-rcor/rcor/g' "${i}"
	done
done

#  Rename the directories: -maxdepth 2
for i in "${directories[@]}"; do
	unset tmp
	typeset -a tmp
	while IFS=" " read -r -d $'\0'; do
	    tmp+=( "${REPLY}" )
	done < <(\
		find "${i}" \
			-maxdepth 2 \
			-type d \
			-name "*trim-rcor*" \
			-print0 \
				| sort -z \
	)
	# echoTest "${tmp[@]}"
	for i in "${tmp[@]}"; do
		rename 's/trim-rcor/rcor/g' "${i}"
	done
done

#  Rename the files
for i in "${directories[@]}"; do
	unset tmp
	typeset -a tmp
	while IFS=" " read -r -d $'\0'; do
	    tmp+=( "${REPLY}" )
	done < <(\
		find "${i}" \
			-type f \
			-name "*trim-rcor*" \
			-print0 \
				| sort -z \
	)
	# echoTest "${tmp[@]}"
	for i in "${tmp[@]}"; do
		rename 's/trim-rcor/rcor/g' "${i}"
	done
done
```
</details>
<br />

<a id="copyrename-and-rename-some-more-for-use-by-alison"></a>
### Copy/rename (and rename some more) for use by Alison
<a id="get-files-of-interest-into-arrays"></a>
#### Get files of interest into arrays
<details>
<summary><i>Click to view code: Get files of interest into arrays</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  First, work with the .gff3s from rcor-only-processed datasets
unset gff3s_rcor
typeset -a gff3s_rcor
while IFS=" " read -r -d $'\0'; do
    gff3s_rcor+=( "${REPLY}" )
done < <(\
    find "./files_PASA_rcor-only_"*"/trinity_5781-5782_Q_IP_merged."*"/"*".compreh_init_build/" \
		-type f \
		-name "*.gff3" \
		-print0 \
			| sort -z
)
echoTest "${gff3s_rcor[@]}"
echo "${#gff3s_rcor[@]}"

#  Next, work with the other .gff3s, i.e., those with no processing,
#+ trim-galore processing, and rcor-trim-galore-combined processing
unset gff3s_other
typeset -a gff3s_other
while IFS=" " read -r -d $'\0'; do
    gff3s_other+=( "${REPLY}" )
done < <(\
    find "./files_PASA_un_trim_trim-rcor_"*"/trinity_5781-5782_Q_IP_merged."*"/"*".compreh_init_build/" \
		-type f \
		-name "*.gff3" \
		-print0 \
			| sort -z
)
echoTest "${gff3s_other[@]}"
echo "${#gff3s_other[@]}"
```
</details>
<br />

<a id="copyrename-files-of-interest-into-the-assessment-directory"></a>
#### Copy/rename files of interest into the "assessment" directory
<details>
<summary><i>Click to view code: Copy/rename files of interest into the "assessment" directory</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

count=1
for i in "${gff3s_rcor[@]}"; do
	# i="${gff3s_rcor[0]}"  # echo "${i}"

	#  Extract a string from a parent of parent of parent (greatgrandparent)
	#+ directory to be appended to the child filename when copying
	greatgrandparent="$(\
		basename "$(dirname "$(dirname "$(dirname "${i}")")")" \
			| awk -F '_' '{$1=""; print $0}' \
			| sed 's/^ *//g' \
			| tr -s ' ' '_'\
	)"
	# echo "${greatgrandparent}"
	child="$(basename "${i}")"  # echo "${child}"
	new_child="${greatgrandparent}_${child}"  # echo "${new_child}"

	#  Copy to 'gff3s_2023-0103/' in
	#+ 'tsukiyamalab/alisong/assess_transcriptome_assemblies/'; it's already
	#+ been mkdir'd
	path_new_child="tsukiyamalab/alisong/assess_transcriptome_assemblies/gff3s_2023-0103"

	echo "${count}"
	# echo "cp -- ${i} ${HOME}/${path_new_child}/${new_child}"  #TEST
	cp -- "${i}" "${HOME}/${path_new_child}/${new_child}"
	count=$(( count + 1 ))
	echo ""
done
#  228

count=1
for i in "${gff3s_other[@]}"; do
	# i="${gff3s_other[0]}"  # echo "${i}"

	#  Extract a string from a parent of parent of parent (greatgrandparent)
	#+ directory to be appended to the child filename when copying
	greatgrandparent="$(\
		basename "$(dirname "$(dirname "$(dirname "${i}")")")" \
			| awk -F '_' '{$1=""; print $0}' \
			| sed 's/^ *//g' \
			| tr -s ' ' '_'\
	)"
	# echo "${greatgrandparent}"
	child="$(basename "${i}")"  # echo "${child}"
	new_child="${greatgrandparent}_${child}"  # echo "${new_child}"

	#  Copy to 'gff3s_2023-0103/' in
	#+ 'tsukiyamalab/alisong/assess_transcriptome_assemblies/'; it's already
	#+ been mkdir'd
	path_new_child="tsukiyamalab/alisong/assess_transcriptome_assemblies/gff3s_2023-0103"

	echo "${count}"
	# echo "cp -- ${i} ${HOME}/${path_new_child}/${new_child}"  #TEST
	cp -- "${i}" "${HOME}/${path_new_child}/${new_child}"
	count=$(( count + 1 ))
	echo ""
done
#  171

#  There are two loops above, one for each array, because I was not sure if I
#+ would need to do different text processing for the filenames in the two
#+ arrays; it turns out I don't need to do that, so I can use a single loop,
#+ instead of the two identical loops, in the future

#  Tally the total number of files copied
echo $(( 228 + 171 ))
# 399
```
</details>
<br />

<a id="in-the-assignment-directory-do-additional-renaming-work"></a>
#### In the "assignment" directory, do additional renaming work
...to make file identities clearer

<details>
<summary><i>Click to view code: In the "assignment" directory, do additional renaming work</i></summary>

```bash
cd --  ~/tsukiyamalab/alisong/assess_transcriptome_assemblies/gff3s_2023-0103

for i in *.trim-rcor.*; do
	# echo "${i}"
	# rename -n 's/PASA_un_trim_trim-rcor_/PASA_trim-rcor_/g' "${i}"  #TEST
	rename 's/PASA_un_trim_trim-rcor_/PASA_trim-rcor_/g' "${i}"
done

for i in *.trim.un_*; do
	# echo "${i}"
	# rename -n 's/PASA_un_trim_trim-rcor_/PASA_trim-only_/g' "${i}"  #TEST
	rename 's/PASA_un_trim_trim-rcor_/PASA_trim-only_/g' "${i}"
done

for i in *_merged.un_*; do
	# echo "${i}"
	# rename -n 's/PASA_un_trim_trim-rcor_/PASA_unprocessed_/g' "${i}"  #TEST
	rename 's/PASA_un_trim_trim-rcor_/PASA_unprocessed_/g' "${i}"
done

for i in *.trim-rcor.*; do
	# echo "${i}"
	# rename -n 's/\.trim-rcor\./\./g' "${i}"  #TEST
	rename 's/\.trim-rcor\./\./g' "${i}"
done

for i in *.trim.un_*; do
	# echo "${i}"
	# rename -n 's/\.trim\.un_/\./g' "${i}"  #TEST
	rename 's/\.trim\.un_/\./g' "${i}"
done

for i in *_merged.un_*; do
	# echo "${i}"
	# rename -n 's/\.un_/\./g' "${i}"  #TEST
	rename 's/\.un_/\./g' "${i}"
done

for i in *.rcor.*; do
	# echo "${i}"
	# rename -n 's/\.rcor\./\./g' "${i}"  #TEST
	rename 's/\.rcor\./\./g' "${i}"
done
```
</details>
<br />

<a id="rename-trim-rcor-strings-to-rcor-in-files_trinity-files_processed-rcor-only"></a>
### Rename "`trim-rcor`" strings to "`rcor`" in "`./files_Trinity*`", "`./files_processed-rcor-only`"
<details>
<summary><i>Click to view code: Get into work directory, load environment, etc.</i></summary>

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


mwd
# awd
```
</details>
<br />

<a id="get-directories-of-interest-into-arrays-then-rename-them-as-appropriate"></a>
#### Get directories of interest into arrays, then rename them as appropriate
<a id="work-with-files_trinity"></a>
#### Work with "`./files_Trinity*`"
<details>
<summary><i>Click to view code: Get directories of interest into arrays, then rename directories as appropriate; afterwards, rename files in directories/subdirectories as appropriate</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

unset directories
typeset -a directories
while IFS=" " read -r -d $'\0'; do
    directories+=( "${REPLY}" )
done < <(\
	find "./files_Trinity"*"/files_processed-rcor-only" \
	    -maxdepth 1 \
		-type d \
		-name "*trim-rcor*" \
		-print0 \
			| sort -z
)
echoTest "${directories[@]}"
# ./files_Trinity_genome-free/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
# ./files_Trinity_genome-free/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_Local
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_Local
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_EndToEnd
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_15_Local
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_EndToEnd
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_50_Local
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_EndToEnd
# ./files_Trinity_genome-guided/files_processed-rcor-only/trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_5_Local

#  Rename the directories
for i in "${directories[@]}"; do
	# rename -n 's/trim-rcor/rcor/g' "${i}"
    rename 's/trim-rcor/rcor/g' "${i}"
done

#  Now that the directories are renamed, update the array
unset directories
typeset -a directories
while IFS=" " read -r -d $'\0'; do
    directories+=( "${REPLY}" )
done < <(\
	find "./files_Trinity"*"/files_processed-rcor-only" \
	    -maxdepth 1 \
		-type d \
		-name "*rcor*" \
		-print0 \
			| sort -z
)
echoTest "${directories[@]}"

#  Identify subdirectories to rename, then do so
for i in "${directories[@]}"; do
    unset tmp
    typeset -a tmp
    while IFS=" " read -r -d $'\0'; do
        tmp+=( "${REPLY}" )
    done < <(\
        find "${i}" \
            -maxdepth 1 \
            -type d \
            -name "*trim-rcor*" \
            -print0 \
                | sort -z \
    )
    # echoTest "${tmp[@]}"
    for i in "${tmp[@]}"; do
        # rename -n 's/trim-rcor/rcor/g' "${i}"
        rename 's/trim-rcor/rcor/g' "${i}"
    done
done

#  Check to ensure that the subdirectories were renamed
for i in "${directories[@]}"; do
    unset tmp
    typeset -a tmp
    while IFS=" " read -r -d $'\0'; do
        tmp+=( "${REPLY}" )
    done < <(\
        find "${i}" \
            -maxdepth 1 \
            -type d \
            -name "*rcor*" \
            -print0 \
                | sort -z \
    )
    echoTest "${tmp[@]}"
done

#  Are there sub-subdirectories that need to be renamed? If so, then do so
for i in "${directories[@]}"; do
    unset tmp
    typeset -a tmp
    while IFS=" " read -r -d $'\0'; do
        tmp+=( "${REPLY}" )
    done < <(\
        find "${i}" \
            # -maxdepth 2 \
            -maxdepth 3 \
            -type d \
            -name "*trim-rcor*" \
            -print0 \
                | sort -z \
    )
    echoTest "${tmp[@]}"
    # for i in "${tmp[@]}"; do
    #     rename -n 's/trim-rcor/rcor/g' "${i}"
    #     # rename 's/trim-rcor/rcor/g' "${i}"
    # done
done
#NOTE 1/2 There appear to be none (testing -maxdepth 2 and 3), so move on to
#NOTE 2/2 renaming files

#  Rename files in subdirectories
for i in "${directories[@]}"; do
    unset tmp
    typeset -a tmp
    while IFS=" " read -r -d $'\0'; do
        tmp+=( "${REPLY}" )
    done < <(\
        find "${i}" \
            -maxdepth 1 \
            -type d \
            -name "*rcor*" \
            -print0 \
                | sort -z \
    )
    # echoTest "${tmp[@]}"
    
    for j in "${tmp[@]}"; do
    	# j="${tmp[0]}"  # echo "${j}"
    	unset tmp_2
	    typeset -a tmp_2
	    while IFS=" " read -r -d $'\0'; do
	        tmp_2+=( "${REPLY}" )
	    done < <(\
	        find "${j}" \
	            -maxdepth 1 \
	            -type f \
	            -name "*rcor*" \
	            -print0 \
	                | sort -z \
    	)
    	# echoTest "${tmp_2[@]}"
	    for i in "${tmp_2[@]}"; do
	        # rename -n 's/trim-rcor/rcor/g' "${i}"
	        rename 's/trim-rcor/rcor/g' "${i}"
	    done
	done
done
#NOTE 1/2 This should handle everything; to check on this, do some spot checks
#NOTE 2/2 in the subdirectories

#NOTE Sure enough, everything is addressed
```
</details>
<br />

<a id="work-with-files_processed-rcor-only"></a>
#### Work with "`./files_processed-rcor-only`"
<a id="notes"></a>
##### Notes
<details>
<summary><i>Click to view notes</i></summary>

In `./files_processed-rcor-only`, we have the following subdirectories:
- `bam_rcor-cor/`
- `bam_rcor-cor_split/`
- `bam_rcor-cor_split_merge/`
- `fastq_rcor/`
- `fastq_rcor-cor/`
- `fastq_rcor-cor_split/`

Of these subdirectories, the following contain *sub-subdirectories* that need to be renamed:
- `./bam_rcor-cor/EndToEnd/`
- `./bam_rcor-cor/Local/`

Of these subdirectories, the following contain *files* that need to be renamed:
- `./bam_rcor-cor_split/EndToEnd/`
- `./bam_rcor-cor_split/Local/`
- `./bam_rcor-cor_split_merge/EndToEnd/`
- `./bam_rcor-cor_split_merge/Local/`
- `./fastq_rcor-cor_split/EndToEnd`
- `./fastq_rcor-cor_split/Local`

Once the *sub-subdirectories* are renamed, there are files in each that need to be renamed too
</details>
<br />

<a id="code-to-accomplish-the-above"></a>
##### Code to accomplish the above
<details>
<summary><i>Click to view code: Get directories of interest into arrays, then rename directories as appropriate; afterwards, rename files in directories/subdirectories as appropriate</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Rename appropriate subdirectories
unset subdirectories
typeset -a subdirectories
while IFS=" " read -r -d $'\0'; do
    subdirectories+=( "${REPLY}" )
done < <(\
	find "./files_processed-rcor-only/bam_rcor-cor/"*"/" \
	    -maxdepth 1 \
		-type d \
		-name "*trim-rcor*" \
		-print0 \
			| sort -z
)
echoTest "${subdirectories[@]}"

for i in "${subdirectories[@]}"; do
	# rename -n 's/trim-rcor/rcor/g' "${i}"
	rename 's/trim-rcor/rcor/g' "${i}"
done

#  With all subdirectories appropriately named, rename files
unset files
typeset -a files
while IFS=" " read -r -d $'\0'; do
    files+=( "${REPLY}" )
done < <(\
	find "./files_processed-rcor-only/"* \
	    -maxdepth 4 \
		-type f \
		-name "*trim-rcor*" \
		-print0 \
			| sort -z
)
echoTest "${files[@]}"

for i in "${files[@]}"; do
	# rename -n 's/trim-rcor/rcor/g' "${i}"
	rename 's/trim-rcor/rcor/g' "${i}"
done
#NOTE 1/2 This should handle everything; to check on this, do some spot checks
#NOTE 2/2 in the subdirectories

#NOTE Sure enough, everything is addressed
```
</details>
<br />

OK, now we're ready to symlink `.bam`s and perform subsequent steps

<a id="symlink-to-the-individual-and-merged-bams-renaming-them-for-easy-use-by-alison"></a>
### Symlink to the individual and merged `.bam`s, renaming them for easy use by Alison
<a id="create-an-array-of-appropriate-bams"></a>
#### Create an array of appropriate `.bam`s
<details>
<summary><i>Click to view code: Get appropriate .bams of interest into an array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
	find "./files_processed-rcor-only" \
		-type f \
		-name "*rcor*.bam" \
		-print0 \
			| sort -z
)
echoTest "${bams[@]}"
echo "${#bams[@]}"
```
</details>
<br />

<a id="clean-upset-up-awd-then-symlink-the-bams"></a>
#### Clean up/set up '`awd`', then symlink the `.bam`s
<details>
<summary><i>Click to view code: Clean up/set up 'awd', then symlink the .bams</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get to the proper wd -------------------------------------------------------
awd
# cd -- /home/kalavatt/assess_transcriptome_assemblies

.,
# total 747K
# drwxrws--- 10 kalavatt  276 Jan  5 09:58 ./
# drwxrws--- 49 agreenla 2.4K Jan  3 12:14 ../
# drwxrws---  5 kalavatt  149 Dec 28 10:18 bams_2022-1212/
# drwxrws---  5 kalavatt   94 Dec 28 10:18 bams_merged_2022-1216/
# drwxrws---  5 agreenla  116 Dec 28 10:18 bws_2022-1215/
# drwxrws---  4 kalavatt   91 Dec 16 10:49 bws_merged_2022-1216/
# drwxrws---  5 kalavatt  114 Jan  5 10:15 gff3s_2022-1214/
# drwxrws--- 11 agreenla  622 Dec 28 10:18 gff3s_2022-1222_email-from-Kris/
# drwxrws---  5 kalavatt  54K Jan  5 09:59 gff3s_2023-0103/
# drwxrws---  3 agreenla   32 Jan  5 10:15 IGV/

mv bams_2022-1212/ bams_individual_2022-1212/
# renamed 'bams_2022-1212/' -> 'bams_individual_2022-1212/'

mkdir -p bams_individual_merged_2023-0105/

#  Determine the relative paths from the present location ---------------------
#+ ...to the bam directories
pwd
# /home/kalavatt/assess_transcriptome_assemblies/bams_individual_merged_2023-0105

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


#  Symlink to the files -------------------------------------------------------
p_part="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201"
for i in "${bams[@]}"; do
	# i="${bams[0]}"  # echo "${i}"
	# dirname "${i}"

	# #  Working things out...
	# find_relative_path "${p_part}/${i}" "$(pwd)"  #REVERSED
	# find_relative_path "$(dirname "${p_part}/${i}")" "$(pwd)"  #REVERSED
	# ., "$(find_relative_path "$(pwd)" "${p_part}/${i}")"  #FAILS
	# ., "$(find_relative_path "$(pwd)" "$(dirname "${p_part}/${i}")")" #WORKS
	
	p_rel="$(find_relative_path "$(pwd)" "$(dirname "${p_part}/${i}")")"  # echo "${p_rel}"
	f_base="$(basename "${i}")"  # echo "${f_base}"
	ln -sf "${p_rel}/${f_base}" "${f_base}"
done
```
</details>
<br />

<a id="create-an-array-of-appropriate-bais-and-symlink-them"></a>
#### Create an array of appropriate `.bai`s and symlink them
<details>
<summary><i>Click to view code: Symlink the .bais</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE


#  Get into the proper wd -----------------------------------------------------
mwd && pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201


#  Make an array fro .bais ----------------------------------------------------
unset bais
typeset -a bais
while IFS=" " read -r -d $'\0'; do
    bais+=( "${REPLY}" )
done < <(\
	find "./files_processed-rcor-only" \
		-type f \
		-name "*rcor*.bai" \
		-print0 \
			| sort -z
)
echoTest "${bais[@]}"
echo "${#bais[@]}"


#  Get to the proper wd -------------------------------------------------------
awd
# cd -- /home/kalavatt/assess_transcriptome_assemblies

cd -- bams_individual_merged_2023-0105/
# /home/kalavatt/assess_transcriptome_assemblies/bams_individual_merged_2023-0105


#  Determine the relative paths from the present location ---------------------
#+ ...to the bam directories
pwd
# /home/kalavatt/assess_transcriptome_assemblies/bams_individual_merged_2023-0105

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


#  Symlink to the files -------------------------------------------------------
p_part="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201"
for i in "${bais[@]}"; do
	p_rel="$(find_relative_path "$(pwd)" "$(dirname "${p_part}/${i}")")"  # echo "${p_rel}"
	f_base="$(basename "${i}")"  # echo "${f_base}"
	ln -sf "${p_rel}/${f_base}" "${f_base}"
done
```
</details>
<br />

<a id="generate-bws-for-the-bams"></a>
### Generate `.bw`s for the `.bam`s
<details>
<summary><i>Click to view code: Generate .bws for the .bams</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE


pwd
# /home/kalavatt/assess_transcriptome_assemblies/bams_individual_merged_2023-0105

cd .. && .,
# total 987K
# drwxrws--- 11 kalavatt  337 Jan  5 11:32 ./
# drwxrws--- 49 agreenla 2.4K Jan  3 12:14 ../
# drwxrws---  5 kalavatt  149 Dec 28 10:18 bams_individual_2022-1212/
# drwxrws---  2 kalavatt  30K Jan  5 13:47 bams_individual_merged_2023-0105/
# drwxrws---  5 kalavatt   94 Dec 28 10:18 bams_merged_2022-1216/
# drwxrws---  5 agreenla  116 Dec 28 10:18 bws_2022-1215/
# drwxrws---  4 kalavatt   91 Dec 16 10:49 bws_merged_2022-1216/
# drwxrws---  5 kalavatt  114 Jan  5 10:15 gff3s_2022-1214/
# drwxrws--- 11 agreenla  622 Dec 28 10:18 gff3s_2022-1222_email-from-Kris/
# drwxrws---  5 kalavatt  54K Jan  5 09:59 gff3s_2023-0103/
# drwxrws---  3 agreenla   32 Jan  5 10:15 IGV/

mv bws_2022-1215/ bws_individual_2022-1215/
# renamed 'bws_2022-1215/' -> 'bws_individual_2022-1215/'

mkdir -p bws_individual_merged_2023-0105/err_out
cd bws_individual_merged_2023-0105/
# /home/kalavatt/assess_transcriptome_assemblies/bws_individual_merged_2023-0105


#  Generate .bws from the merged .bams that have been symlinked ---------------
#NOTE Not using parameter --ignoreDuplicates

#  Make a job submission script ---------------------------
s_name="submit_bamCoverage.sh"

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

# module load deepTools

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


# #  ...by excluding alignments less than MAPQ 3 --------------------------------
# bamCoverage \\
#     -p \${SLURM_CPUS_ON_NODE} \\
#     -b "\${infile}" \\
#     --normalizeUsing CPM \\
#     --minMappingQuality 3 \\
#     --filterRNAstrand forward \\
#     -o "MAPQ3/\${outfile}_MAPQ3_fwd.bw"
# echo "" | tee >(cat >&2)
# echo "" | tee >(cat >&2)
#
# bamCoverage \\
#     -p \${SLURM_CPUS_ON_NODE} \\
#     -b "\${infile}" \\
#     --normalizeUsing CPM \\
#     --minMappingQuality 3 \\
#     --filterRNAstrand reverse \\
#     -o "MAPQ3/\${outfile}_MAPQ3_rev.bw"
# echo "" | tee >(cat >&2)
# echo "" | tee >(cat >&2)
#
#
# #  ...by excluding alignments less than MAPQ 30 -------------------------------
# bamCoverage \\
#     -p \${SLURM_CPUS_ON_NODE} \\
#     -b "\${infile}" \\
#     --normalizeUsing CPM \\
#     --minMappingQuality 30 \\
#     --filterRNAstrand forward \\
#     -o "MAPQ30/\${outfile}_MAPQ30_fwd.bw"
# echo "" | tee >(cat >&2)
# echo "" | tee >(cat >&2)
#
# bamCoverage \\
#     -p \${SLURM_CPUS_ON_NODE} \\
#     -b "\${infile}" \\
#     --normalizeUsing CPM \\
#     --minMappingQuality 30 \\
#     --filterRNAstrand reverse \\
#     -o "MAPQ30/\${outfile}_MAPQ30_rev.bw"
# echo "" | tee >(cat >&2)
# echo "" | tee >(cat >&2)

script
# vi "${s_name}"  # :q

#  Create an .bam array for generation of .bws ------------
unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find "${HOME}/assess_transcriptome_assemblies/bams_individual_merged_2023-0105" \
        -type l \
        -name "*.sc_all.bam" \
        -print0 | \
            sort -z
)
echoTest "${bams[@]}"  # It works!
echo "${#bams[@]}"
# 168

#  Submit the jobs ----------------------------------------
# echo "${s_name}"  # submit_bamCoverage.sh
for i in "${bams[@]}"; do
    echo "sbatch ${s_name} ${i} $(basename "${i}" .bam)"
    echo ""

    sbatch ${s_name} ${i} $(basename "${i}" .bam)
    echo ""
    echo ""
    sleep 0.1
done

rmdir MAPQ3/ MAPQ30/
```
</details>
<br />
