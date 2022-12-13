
`#work_build-blacklist.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Commands used for initial processing on 2022-1206](#commands-used-for-initial-processing-on-2022-1206)
	1. [Look them up...](#look-them-up)
	1. [Pertinent results from the call to history](#pertinent-results-from-the-call-to-history)
1. [Emails with Alison about blacklists](#emails-with-alison-about-blacklists)
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
	1. [Email: *"Bam files in directory ~/tsukiyamalab/alisong/Kris_bams/"*](#email-bam-files-in-directory-~tsukiyamalabalisongkris_bams)
		1. [1: Me → Alison `Monday, December 12, 2022 3:27 PM`](#1-me-%E2%86%92-alison-monday-december-12-2022-327-pm)
		1. [2: Alison → Me `Monday, December 12, 2022 3:42 PM`](#2-alison-%E2%86%92-me-monday-december-12-2022-342-pm)
	1. [Email: *"IGV Sharing"*](#email-igv-sharing)
		1. [1: Alison → me `Wednesday, November 23, 2022 at 4:41 PM`](#1-alison-%E2%86%92-me-wednesday-november-23-2022-at-441-pm)
1. [Symlinking `.bam`s for Alison to work with with, 2022-1212](#symlinking-bams-for-alison-to-work-with-with-2022-1212)
	1. [The particular `.bam`s and their details](#the-particular-bams-and-their-details)
		1. ["Unprocessed" `.bam`s](#unprocessed-bams)
		1. ["Processed" `.bam`s](#processed-bams)
		1. ["Processed \(full\)" `.bam`s](#processed-full-bams)
	1. [Creating the symbolic links](#creating-the-symbolic-links)
1. [Downloading things... \(2022-1213\)](#downloading-things-2022-1213)
	1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc)
	1. [Get the SGD `other_features` files](#get-the-sgd-other_features-files)

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

<a id="emails-with-alison-about-blacklists"></a>
## Emails with Alison about blacklists
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
#### *Note fr/Alison on what to blacklist and what to not*
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
### Email: *"Bam files in directory ~/tsukiyamalab/alisong/Kris_bams/"*
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
<a id="1-alison-%E2%86%92-me-wednesday-november-23-2022-at-441-pm"></a>
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
<br />

<a id="symlinking-bams-for-alison-to-work-with-with-2022-1212"></a>
## Symlinking `.bam`s for Alison to work with with, 2022-1212
<a id="the-particular-bams-and-their-details"></a>
### The particular `.bam`s and their details
<a id="unprocessed-bams"></a>
#### "Unprocessed" `.bam`s
- reads adapter and quality trimmed by trim_galore: FALSE
- reads k-mer-corrected by rcorrector: FALSE
- STAR alignment type: "Local"

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
- reads adapter and quality trimmed by trim_galore: TRUE
- reads k-mer-corrected by rcorrector: FALSE
- STAR alignment type: "EndToEnd"

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
```bash
#!/bin/bash

cd "/home/kalavatt/tsukiyamalab/alisong" || echo "cd'ing failed"
mkdir -p Kris_bams/{unprocessed,preprocessed,preprocessed-full}

cd "Kris_bams" || echo "cd'ing failed"

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

<a id="downloading-things-2022-1213"></a>
## Downloading things... (2022-1213)
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

<a id="get-the-sgd-other_features-files"></a>
### [Get the SGD `other_features` files](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir -p files_features/SGD-other-features
cd files_features/SGD-other-features || \
	echo "cd'ing failed; check on this"

link="http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/"
files=(
	other_features_genomic_1000.fasta.gz
	other_features_genomic.fasta.gz
	other_features.README
	README.html
)
for i in "${files[@]}"; do curl "${link}/${i}" > "./${i}"; done
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0   799k      0 --:--:-- --:--:-- --:--:--  797k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  1344k      0 --:--:-- --:--:-- --:--:-- 1351k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2319k      0 --:--:-- --:--:-- --:--:-- 2319k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2783k      0 --:--:-- --:--:-- --:--:-- 2783k

zcat other_features_genomic.fasta.gz | less


```

`#TODO` Make a python script for using .fasta headers to make .bed files
