
`#work_build-blacklist.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Commands used for initial processing on 2022-1206](#commands-used-for-initial-processing-on-2022-1206)
	1. [Look them up...](#look-them-up)
	1. [Pertinent results from the call to history](#pertinent-results-from-the-call-to-history)
1. [Emails with Alison about blacklists, files for assessment, etc.](#emails-with-alison-about-blacklists-files-for-assessment-etc)
	1. [Email: *"Blacklist file"*](#email-blacklist-file)
		1. [1: Alison → me `Monday, December 5, 2022 3:45 PM`](#1-alison-%E2%86%92-me-monday-december-5-2022-345-pm)
		1. [2: Me → Alison `Monday, December 5, 2022 at 4:05 PM`](#2-me-%E2%86%92-alison-monday-december-5-2022-at-405-pm)
		1. [3: Me → Alison `Tuesday, December 6, 2022 at 11:10 AM`](#3-me-%E2%86%92-alison-tuesday-december-6-2022-at-1110-am)
		1. [4: Me → Alison `Tuesday, December 6, 2022 11:16 AM`](#4-me-%E2%86%92-alison-tuesday-december-6-2022-1116-am)
		1. [5: Alison → me `Tuesday, December 6, 2022 11:44 AM`](#5-alison-%E2%86%92-me-tuesday-december-6-2022-1144-am)
			1. [*Note fr/Alison on what to blacklist and what to not*](#note-fralison-on-what-to-blacklist-and-what-to-not)
		1. [6: Me → Alison `Tuesday, December 6, 2022 at 11:47 AM`](#6-me-%E2%86%92-alison-tuesday-december-6-2022-at-1147-am)
		1. [7: Me → Alison `Tuesday, December 6, 2022 3:34 PM`](#7-me-%E2%86%92-alison-tuesday-december-6-2022-334-pm)
		1. [8: Alison → me `Wednesday, December 7, 2022 at 12:20 PM`](#8-alison-%E2%86%92-me-wednesday-december-7-2022-at-1220-pm)
		1. [9: Me → Alison `Wednesday, December 7, 2022 at 12:31 PM`](#9-me-%E2%86%92-alison-wednesday-december-7-2022-at-1231-pm)
		1. [10: Me → Alison `Wednesday, December 7, 2022 at 12:39 PM`](#10-me-%E2%86%92-alison-wednesday-december-7-2022-at-1239-pm)
	1. [Email: *"Bam files in directory `~/tsukiyamalab/alisong/Kris_bams/`"*](#email-bam-files-in-directory-~tsukiyamalabalisongkris_bams)
		1. [1: Me → Alison `Monday, December 12, 2022 3:27 PM`](#1-me-%E2%86%92-alison-monday-december-12-2022-327-pm)
		1. [2: Alison → Me `Monday, December 12, 2022 3:42 PM`](#2-alison-%E2%86%92-me-monday-december-12-2022-342-pm)
	1. [Email: *"IGV Sharing"*](#email-igv-sharing)
		1. [1: Alison → me `Wednesday, November 23, 2022 at 4:41 PM`](#1-alison-%E2%86%92-me-wednesday-november-23-2022-at-441-pm)
	1. [Email: *"Gff3 files in `~/tsukiyamalab/alisong/Kris/gtfs_2022-1214/param_gene-overlap_{FALSE,TRUE}`"*](#email-gff3-files-in-~tsukiyamalabalisongkrisgtfs_2022-1214param_gene-overlap_falsetrue)
		1. [1: Me → Alison `Wednesday, December 13, 2022 at 3:17 PM`](#1-me-%E2%86%92-alison-wednesday-december-13-2022-at-317-pm)
1. [Symlinking `.bam`s for Alison to work with with, 2022-1212](#symlinking-bams-for-alison-to-work-with-with-2022-1212)
	1. [The particular `.bam`s and their details](#the-particular-bams-and-their-details)
		1. ["Unprocessed" `.bam`s](#unprocessed-bams)
		1. ["Processed" `.bam`s](#processed-bams)
		1. ["Processed \(full\)" `.bam`s](#processed-full-bams)
	1. [Creating the symbolic links](#creating-the-symbolic-links)
1. [Symlinking `.gtf`s for Alison to work with with, 2022-1214](#symlinking-gtfs-for-alison-to-work-with-with-2022-1214)
	1. [The particular `.gtf`s and their details](#the-particular-gtfs-and-their-details)
		1. [Running `PASA` *without* parameter `--gene overlap 50.0`](#running-pasa-without-parameter---gene-overlap-500)
		1. [Running `PASA` *with* parameter `--gene overlap 50.0`](#running-pasa-with-parameter---gene-overlap-500)
	1. [The actual symlinking](#the-actual-symlinking)
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
	1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc)
	1. [Get the SGD `_genome_Current_Release.tgz`](#get-the-sgd-_genome_current_releasetgz)
	1. [Get the SGD `other_features` files](#get-the-sgd-other_features-files)
1. [Parse the SGD `.fasta` headers to make dataframes, etc.](#parse-the-sgd-fasta-headers-to-make-dataframes-etc)
1. [Convert the experiment `.bam`s into `.bw`s \(2022-1215\)](#convert-the-experiment-bams-into-bws-2022-1215)
	1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc-1)
	1. [Assess things](#assess-things)
	1. [Fix the symlinks to...](#fix-the-symlinks-to)
		1. ["preprocessed" `.bam`s](#preprocessed-bams)
		1. ["unprocessed" `.bam`s](#unprocessed-bams-1)
		1. ["processed \(full\)" .`bam`s](#processed-full-bams-1)
	1. [Now, edit the `.bam`-to-`.bw` script and make `.bw`s](#now-edit-the-bam-to-bw-script-and-make-bws)
		1. [Update the script](#update-the-script)
			1. [Scratch: `bamcoverage_strandselect.sh`](#scratch-bamcoverage_strandselectsh)
				1. [Before](#before)
				1. [After](#after)
			1. [Make `submit_bamCoverage.sh`](#make-submit_bamcoveragesh)
			1. [Get the `.bam`s of interest into an array or glob to be looped over for job submissions](#get-the-bams-of-interest-into-an-array-or-glob-to-be-looped-over-for-job-submissions)
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

<a id="emails-with-alison-about-blacklists-files-for-assessment-etc"></a>
## Emails with Alison about blacklists, files for assessment, etc.
<a id="email-blacklist-file"></a>
### Email: *"Blacklist file"*
<details>
<summary><i>Click to view</i></summary>

<a id="1-alison-%E2%86%92-me-monday-december-5-2022-345-pm"></a>
#### 1: Alison → me `Monday, December 5, 2022 3:45 PM`
Hi Kris - 

You can find the .gff file for other genomics regions in `~/tsukiyamalab/alisong/annotation_files/other_regions` I downloaded the .fasta file from sgd, and then mapped it to the reference using gmap. The gff needs to be filtered to pick out the black list regions. We don't want to blacklist origins of replication or centromeres for example. Everything is labeled pretty clearly so I would just run a few quick awk scripts to filter, but I'm sure their are other ways too. Let know if you have any questions or issues. 

Here is the source for the fasta:  
[http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/)

Alison

<a id="2-me-%E2%86%92-alison-monday-december-5-2022-at-405-pm"></a>
#### 2: Me → Alison `Monday, December 5, 2022 at 4:05 PM`
Thanks, this is great!

<a id="3-me-%E2%86%92-alison-tuesday-december-6-2022-at-1110-am"></a>
#### 3: Me → Alison `Tuesday, December 6, 2022 at 11:10 AM`
Hi Alison,
 
It looks like there are 850 unique `Name=Something` features in the .gff file. Is there a quick way for me to know which to include in the blacklist and which to not? No rush at all. You can see the unique elements in `~/tsukiyamalab/alisong/annotation_files/other_regions/KA.other_features_genomic.sort-uniq-tally.txt`.
 
Also, do you think that blacklisting the telomeric repeats in this file will be enough to prevent the weird Trinity annotations we see in telomeric regions, or should we go with a complete 10-kb blacklisting of the starts and ends of chromosomes? Or perhaps both?
 
Thanks,  
Kris

<a id="4-me-%E2%86%92-alison-tuesday-december-6-2022-1116-am"></a>
#### 4: Me → Alison `Tuesday, December 6, 2022 11:16 AM`
Ah—-I temporarily forgot about Christine’s telomere annotations. I think they’re from the UCSC table browser. If they look reasonable, perhaps we can just use those in place of blanket 10-kb blacklistings...

<a id="5-alison-%E2%86%92-me-tuesday-december-6-2022-1144-am"></a>
#### 5: Alison → me `Tuesday, December 6, 2022 11:44 AM`
Hi Kris - 

Here are some notes on those region names. Let me know if you have any questions. 

Alison

<a id="note-fralison-on-what-to-blacklist-and-what-to-not"></a>
##### *Note fr/Alison on what to blacklist and what to not*
```txt
Region names. How I think we should deal with each category of region as based on how the name starts: 

ARS - Autonomously Replicating Sequence, aka origin of replication, don’t blacklist

CEN - centromere, don’t blacklist

HML/HMR - silent mating type cassette array, don’t blacklist

MATALPHA - mating type locus. We use mata instead of mat@ so this can be blacklisted. Maybe ask Toshi if it is worth adjusting the reference to the correct mating type. He will probably say no.

NTS - Non-transcribed region of the rDNA repeat, probably depleted by depletion probes but can blacklist

ORI - mitochondrial origin of replication, don’t need to blacklist

RE301 - recombination enhancer, don’t blacklist

TEL - telomere, use Christine’s

VDE - intein encoding region, don’t blacklist

Y - every yeast chromosome named as Y (yeast) A-P (chromosome 1-16, with 1 being A, and 16 being P) and L or R (left or right of centromere). Fairly sure these are all long terminal repeats of some kind and should be blacklisted.
```

<a id="6-me-%E2%86%92-alison-tuesday-december-6-2022-at-1147-am"></a>
#### 6: Me → Alison `Tuesday, December 6, 2022 at 11:47 AM`

Very clear, thanks!

<a id="7-me-%E2%86%92-alison-tuesday-december-6-2022-334-pm"></a>
#### 7: Me → Alison `Tuesday, December 6, 2022 3:34 PM`

Hi Alison,
 
This is just a rough-draft thought we can talk about when you’re back in the lab: I feel a little frightened or wary to blacklist all the LTRs since they and other REs (repetitive elements) make up parts of some genes, especially lncRNA-coding ones, and some other features like TFBS. (At least, that’s the case for mammals; I’m not up on the bio of REs in yeast, so correct me if this is incorrect.) Although I don’t know, I’m thinking that it could affect the transcripts that we build at those particular genes and features with Trinity.
 
Also, forgive my ignorance, but is Ty1 a specific RE or is it a class of REs containing a bunch of individually named REs?
 
Thanks,  
Kris

<a id="8-alison-%E2%86%92-me-wednesday-december-7-2022-at-1220-pm"></a>
#### 8: Alison → me `Wednesday, December 7, 2022 at 12:20 PM`

Thinking about this more, I think it's reasonable to make the least conservative blacklist, use that and then only go more aggressive if there are still issues a more extensive blacklist could fix. 

Alison

<a id="9-me-%E2%86%92-alison-wednesday-december-7-2022-at-1231-pm"></a>
#### 9: Me → Alison `Wednesday, December 7, 2022 at 12:31 PM`

By most conservative, do you mean all telomere regions in the file from Christine plus the stuff associated with “Y” as mentioned in the .rtf file you sent? (And possibly mat@ too?)

```txt
Y - every yeast chromosome named as Y (yeast) A-P (chromosome 1-16, with 1 being A, and 16 being P) and L or R (left or right of centromere). Fairly sure these are all long terminal repeats of some kind and should be blacklisted.
```

<a id="10-me-%E2%86%92-alison-wednesday-december-7-2022-at-1239-pm"></a>
#### 10: Me → Alison `Wednesday, December 7, 2022 at 12:39 PM`

For a least conservative version, I think we’d be good to start with just the telomere regions in Christine’s file (also, we need to confirm the source of this file and how it was generated--my initial work suggests it’s from the UCSC table browser, but I’m not yet certain about that).
 
For a more conservative version, I think we’d be good to try the regions in Christine’s file, Ty1-* sequences, and telomeric-repeat sequences.
 
For a very conservative version, I think we’d be good to try the above plus all other LTRs (or whatever each “Y” feature is).
 
In IGV, do you see any out-of-place spikes in 4tU-seq signal that look like they could be the result of non-specific alignment?
</details>
<br />

<a id="email-bam-files-in-directory-~tsukiyamalabalisongkris_bams"></a>
### Email: *"Bam files in directory `~/tsukiyamalab/alisong/Kris_bams/`"*
<details>
<summary><i>Click to view</i></summary>

<a id="1-me-%E2%86%92-alison-monday-december-12-2022-327-pm"></a>
#### 1: Me → Alison `Monday, December 12, 2022 3:27 PM`
Hi Alison,

I created a subdirectory in your directory called 'Kris_bams/' ('~/tsukiyamalab/alisong/Kris_bams/'). Inside 'Kris_bams/', you can find symlinks to all of the relevant (and less or not relevant) bams.

In 'Kris_bams/', the bams are subdivided into three subdirectories:
- unprocessed/
- preprocessed/
- preprocessed-full/

On "unprocessed" bams...
- reads adapter- and quality-trimmed by trim_galore: FALSE
- reads k-mer-corrected by rcorrector: FALSE
- STAR alignment type: "Local" (allows "soft clipping")

On "preprocessed" bams...
- reads adapter- and quality-trimmed by trim_galore: TRUE
- reads k-mer-corrected by rcorrector: FALSE
- STAR alignment type: "EndToEnd" (doesn't allow "soft clipping")

On "preprocessed (full)" bams...
- reads adapter- and quality-trimmed by trim_galore: TRUE
- reads k-mer-corrected by rcorrector: TRUE
- STAR alignment type: "EndToEnd" (doesn't allow "soft clipping")

Within each of these subdirectories, you'll find bams for...
- 5781_G1_IN
- 5781_G1_IP
- 5781_Q_IN
- 5781_Q_IP
- 5782_G1_IN
- 5782_G1_IP
- 5782_Q_IN
- 5782_Q_IP

There are four of each kind
- multi-hit-mode_1000: Up to 1000 alignments are allowed/retained for a given read
- multi-hit-mode_100: Up to 100 alignments are allowed/retained for a given read
- multi-hit-mode_10: Up to 10 alignments are allowed/retained for a given read
- multi-hit-mode_1: Only 1 alignment are allowed/retained for a given read (standard; basically, "multi-hit mode" was off)

I'd start with making bigwig, etc. files for "unprocessed", "preprocessed", and "preprocessed (full)" 5781_Q_IP multi-hit-mode_1 bams (three samples). From there, you could branch out to 5782_Q_IP multi-hit-mode_1 bams (another three samples). Then maybe the same for Q_IN (another six samples)?

From there, maybe try 5781_Q_{IP,IN} multi-hit-mode_1000 and 5782_Q_{IP,IN} multi-hit-mode_1000 bams (twelve samples) to see where all the multimappers go (e.g., are they going to Ty elements?)

Thanks,  
Kris

P.S. Symbolic links stuff:
 
General pattern: `ln -s source_file target_file`
 
For example, here’s how I quickly symlinked the files to, e.g., 'Kris_bams/preprocessed-full/'
```bash
#!/bin/bash
#DONTRUN
 
pwd
# /home/kalavatt/tsukiyamalab/alisong/Kris_bams/preprocessed-full
 
p_pf="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/bam_trim-rcor-cor_split/EndToEnd"
for i in "${p_pf}/"*".sc_all.bam"; do
       echo "Working with ${i}"
       # echo "${i}" "$(basename "${i}")"  # Test things before actually running the command
       ln -s "${i}" "$(basename "${i}")"  # Run the command when things look reasonable
       echo ""
done
```

<a id="2-alison-%E2%86%92-me-monday-december-12-2022-342-pm"></a>
#### 2: Alison → Me `Monday, December 12, 2022 3:42 PM`
Awesome! Thank you so much!

Alison
</details>
<br />

<a id="email-igv-sharing"></a>
### Email: *"IGV Sharing"*
<details>
<summary><i>Click to view</i></summary>

<a id="1-alison-%E2%86%92-me-wednesday-november-23-2022-at-441-pm"></a>
#### 1: Alison → me `Wednesday, November 23, 2022 at 4:41 PM`
Hi Kris - 

I have made a folder where we can easily create IGV sessions to share and compare annotation. 

It can be found at:  
`~/tsukiyamalab/alisong/Kris_IGV_Sharing`

If you go to IGV and then go file, open session, you can open the .xml file with the bigwigs and annotation files I have loaded. You could also save a new xml file with additional files, focused on a certain region or with a particular scaling. Please note all bigwigs/bams/annotation files that you want to save within a session need to be within the same folder for the .xml file to work. I made a simple one with just Q, but I imagine this folder filling up with stuff as we continue to work. Feel free to copy stuff into that folder for ease. I assume none of these files will be particularly large so duplicates should have a negligible effect on storage costs. 

Enjoy your Thanksgiving!

Alison
</details>
<br />

<a id="email-gff3-files-in-~tsukiyamalabalisongkrisgtfs_2022-1214param_gene-overlap_falsetrue"></a>
### Email: *"Gff3 files in `~/tsukiyamalab/alisong/Kris/gtfs_2022-1214/param_gene-overlap_{FALSE,TRUE}`"*
<details>
<summary><i>Click to view</i></summary>

<a id="1-me-%E2%86%92-alison-wednesday-december-13-2022-at-317-pm"></a>
#### 1: Me → Alison `Wednesday, December 13, 2022 at 3:17 PM`
Hi Alison,
 
I created symlinks to all of the relevant (and less or not relevant) gff3s in ~/tsukiyamalab/alisong/Kris/gtfs_2022-1214/.
 
Within this directory, there are two subdirectories:
param_gene-overlap_FALSE/
param_gene-overlap_TRUE/
 
Documentation is forthcoming (for the time being, we can start with files in param_gene-overlap_FALSE/, although comparing to files in *_TRUE/ will be important).
 
There are nine kinds of files inside each subdirectory. Here’s the breakdown (GF = genome-free mode, GG = genome-guided mode):
__"unprocessed"__
+ PASA from Trinity GF + Trinity GG multi-hit-mode 1
+ PASA from Trinity GF + Trinity GG multi-hit-mode 10
+ PASA from Trinity GF + Trinity GG multi-hit-mode 100
__"processed"__
+ PASA from Trinity GF + Trinity GG multi-hit-mode 1
+ PASA from Trinity GF + Trinity GG multi-hit-mode 10
+ PASA from Trinity GF + Trinity GG multi-hit-mode 100
__"processed (full)"__
+ PASA from Trinity GF + Trinity GG multi-hit-mode 1
+ PASA from Trinity GF + Trinity GG multi-hit-mode 10
+ PASA from Trinity GF + Trinity GG multi-hit-mode 100
 
Trinity GF is always done with multi-hit-mode 1 (because GF doesn’t know how to handle multi-mappers, although Trinity GG does). I’ll be sure to send you rationale, experiment details, etc. before you come into the office tomorrow.
 
Thanks,
Kris
</details>
<br />
<br />

<a id="symlinking-bams-for-alison-to-work-with-with-2022-1212"></a>
## Symlinking `.bam`s for Alison to work with with, 2022-1212
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

<a id="symlinking-gtfs-for-alison-to-work-with-with-2022-1214"></a>
## Symlinking `.gtf`s for Alison to work with with, 2022-1214
<a id="the-particular-gtfs-and-their-details"></a>
### The particular `.gtf`s and their details
<a id="running-pasa-without-parameter---gene-overlap-500"></a>
#### Running `PASA` *without* parameter `--gene overlap 50.0`
In `2022_transcriptome-construction/results/2022-1201/files_PASA/`
```txt
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/
```

<a id="running-pasa-with-parameter---gene-overlap-500"></a>
#### Running `PASA` *with* parameter `--gene overlap 50.0`
In `2022_transcriptome-construction/results/2022-1201/files_PASA_param_gene-overlap/`
```txt
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd/
trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd/
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local/
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local/
trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local/
```

<a id="the-actual-symlinking"></a>
### The actual symlinking
<details>
<summary><i>Click to view the bash code</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/alisong" || \
	echo "cd'ing failed; check on this"


#  Reorganizationfor IGV experiments --
mkdir -p Kris/gtfs_2022-1214/
# mkdir: created directory 'Kris'
# mkdir: created directory 'Kris/gtfs_2022-1214'

mv Kris_bams/ bams_2022-1212/ && mv bams_2022-1212 Kris/
# renamed 'Kris_bams/' -> 'bams_2022-1212/'
# renamed 'bams_2022-1212' -> 'Kris/bams_2022-1212'

mv Kris_IGV_Sharing/ IGV_sharing/ && mv IGV_sharing/ Kris/
# renamed 'Kris_IGV_Sharing/' -> 'IGV_sharing/'
# renamed 'IGV_sharing/' -> 'Kris/IGV_sharing'

cd Kris/gtfs_2022-1214/ || \
	echo "cd'ing failed; check on this"

mkdir -p param_gene-overlap_{TRUE,FALSE}
# mkdir: created directory 'param_gene-overlap_TRUE'
# mkdir: created directory 'param_gene-overlap_FALSE'


#  Make filename stems, symlinking ----
unset stems
typeset -a stems
stems=(
	trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd
	trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_10_EndToEnd
	trinity_5781-5782_Q_IP_merged.trim-rcor.multi-hit-mode_100_EndToEnd
	trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_1_EndToEnd
	trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_10_EndToEnd
	trinity_5781-5782_Q_IP_merged.trim.un_multi-hit-mode_100_EndToEnd
	trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_1_Local
	trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_10_Local
	trinity_5781-5782_Q_IP_merged.un_multi-hit-mode_100_Local
)


#  Files: param_gene-overlap_FALSE ----
cd param_gene-overlap_FALSE || \
	echo "cd'ing failed; check on this"

unset key_value
typeset -A key_value
for i in "${stems[@]}"; do
	k="${HOME}/2022_transcriptome-construction_2022-1201/files_PASA/${i}/${i}.compreh_init_build/${i}.compreh_init_build.gff3"
	v="${i}.compreh_init_build.gff3"
	# echo "${k}"
	# echo "${v}"
	# echo ""

	key_value["${k}"]+="${v}"
done

for i in "${!key_value[@]}"; do
	echo "  Key: ${i}"
	echo "Value: ${key_value[$i]}"

	ln -s "${i}" "${key_value[$i]}"
	echo ""
done


#  Files: param_gene-overlap_TRUE -----
cd ../param_gene-overlap_TRUE || \
	echo "cd'ing failed; check on this"

unset key_value
typeset -A key_value
for i in "${stems[@]}"; do
	k="${HOME}/2022_transcriptome-construction_2022-1201/files_PASA_param_gene-overlap/${i}/${i}.compreh_init_build/${i}.compreh_init_build.gff3"
	v="${i}.compreh_init_build.gff3"
	# echo "${k}"
	# echo "${v}"
	# echo ""

	key_value["${k}"]+="${v}"
done

for i in "${!key_value[@]}"; do
	echo "  Key: ${i}"
	echo "Value: ${key_value[$i]}"

	ln -s "${i}" "${key_value[$i]}"
	echo ""
done
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
<a id="grab-a-node-get-to-the-right-directory-etc"></a>
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

<a id="convert-the-experiment-bams-into-bws-2022-1215"></a>
## Convert the experiment `.bam`s into `.bw`s (2022-1215)
*Building off of work started by Alison*

<a id="grab-a-node-get-to-the-right-directory-etc-1"></a>
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

<a id="fix-the-symlinks-to"></a>
### Fix the symlinks to...
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

<a id="before"></a>
###### Before
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

<a id="after"></a>
###### After
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

Some quick notes about the previous script:
- Important
	+ `bamCoverage` has a parameter to run in parallel, but it won't recognize it unless you call it with the `-p` option
		* So, `THREADS` becomes an unused variable
		* Also, when submit the job to `SLURM`, you need to tell it to assign 8 cores/CPUs to the job,
			- either through the call to `sbatch` (`-c` or `--cpus-per-task`)
			- or through a `#SBATCH` line in the job submission script: `#SBATCH --cpus-per-task=#`
	+ I recommend to get used to explicitly telling SLURM things with lines that start with `#SBATCH`
	+ Rather than have the for loop in the job submission script, use the for loop outside of the script; I'll explain what I mean below...
	+ To organize your results, explicitly specify to `SLURM` that you want `stderr` and `stdout` files
		* Save the files to specific locations (optional)
		* ...with specific names (I think this is mandatory)
	+ ~~Don't do directory remodeling, etc. inside the script~~ It's fine if it's a repeatable kind of thing you want to do
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

echo $HOME
kalavatt
agreenla
```

Submission messages printed to terminal
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
