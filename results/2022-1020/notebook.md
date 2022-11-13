
# 2022-1020
<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [E-mails between Alison, Toshi, and me](#e-mails-between-alison-toshi-and-me)
	1. [E-mail 1.1 \(from Alison\): "Quality control analysis"](#e-mail-11-from-alison-quality-control-analysis)
		1. [File](#file)
		1. [Contents](#contents)
	1. [E-mail 1.2 \(from Kris\): "Quality control analysis"](#e-mail-12-from-kris-quality-control-analysis)
		1. [Contents](#contents-1)
	1. [E-mail 1.3 \(from Toshi\): "Quality control analysis"](#e-mail-13-from-toshi-quality-control-analysis)
		1. [Contents](#contents-2)
	1. [E-mail 2 \(from Alison\): "More Code!"](#e-mail-2-from-alison-more-code)
		1. [Files](#files)
		1. [Contents](#contents-3)
	1. [E-mail 3 \(from Alison\): "File Locations"](#e-mail-3-from-alison-file-locations)
		1. [Contents](#contents-4)
	1. [E-mail 4 \(from Alison\): "Hand Curation and so many annotation files"](#e-mail-4-from-alison-hand-curation-and-so-many-annotation-files)
		1. [Files](#files-1)
		1. [Contents](#contents-5)
	1. [E-mail 5 \(from Alison\): "Small fraction of AS transcripts functional on first pass"](#e-mail-5-from-alison-small-fraction-of-as-transcripts-functional-on-first-pass)
		1. [File](#file-1)
		1. [Contents](#contents-6)
1. [Brief notes on Fred Hutch's cluster resources](#brief-notes-on-fred-hutchs-cluster-resources)
1. [New slides from Alison](#new-slides-from-alison)
1. [How Alison is calling Trinity](#how-alison-is-calling-trinity)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="e-mails-between-alison-toshi-and-me"></a>
## E-mails between Alison, Toshi, and me
<a id="e-mail-11-from-alison-quality-control-analysis"></a>
### E-mail 1.1 (from Alison): "Quality control analysis"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Sent: Thursday, October 20, 2022 2:26 PM  
To: [Tsukiyama, Toshio](ttsukiya@fredhutch.org)  
Cc: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Quality control analysis

<a id="file"></a>
#### File
- `replicate_comparison.pptx`

<a id="contents"></a>
#### Contents
Some more quality control analysis in lieu of yesterday's conversation. I feel data is good enough to keep going with analysis. Whether or not 6126/7716 is really much more drastically scaled or if this is artifact of technique is hard to know, but I feel data is otherwise looking very reproduceable between replicates so far. 

Kris - I will send you some more scripts related to this analysis in a separate email. 

Alison

<a id="e-mail-12-from-kris-quality-control-analysis"></a>
### E-mail 1.2 (from Kris): "Quality control analysis"
<a id="contents-1"></a>
#### Contents
Sounds good, Alison!
 
Yes, it seems reproducible to me too.
 
In slides 5 and 6, what is AS? (Sorry if I forgot already.)
 
Also, a quick thing on Spearman/Pearson: Spearman is less sensitive to outliers and more influenced by the centeredness of the data. And vice versa: Pearson is more sensitive to outliers and less influenced by the centeredness of the data.
 
Interesting how PC1 captures the vast majority of variance in the data but PC2 is the PC that actually separates nascent from steady state.
 
Kris

<a id="e-mail-13-from-toshi-quality-control-analysis"></a>
### E-mail 1.3 (from Toshi): "Quality control analysis"
<a id="contents-2"></a>
#### Contents
Your data sets looks good, if I understand correctly. I am glad to see single- and doule-depletion strains are similar. 

toshi

<a id="e-mail-2-from-alison-more-code"></a>
### E-mail 2 (from Alison): "More Code!"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Thursday, October 20, 2022 at 3:28 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: More Code!

<a id="files"></a>
#### Files
- `replicate_ratio_comparison_mRNA.Rmd`
- `mRNA_Nascent_Nab3.txt`
- `AS_mRNA_Nascent_Nab3.txt`
- `combined_mRNA.txt`
- `Correlation.sh`
- `19_oct_bamcoverage_scale_HARD2.sh`
- `13_OCT_Heatmaps.sh`
- `3heatmap.sh`

<a id="contents-3"></a>
#### Contents
Hi Kris - 

I have attached:

- R-notebook with replicate math from previous email as well as associated .txt files
	- R version 3.6.3 (2020-02-29) -- "Holding the Windsock"
- a few deepTools scripts 
	- correlation for bam correlation
	- bam coverage - making bigwigs from bam files
	- 2 heatmap scripts
No rush on any of this. I am not too worried that there are glaring issues here, but since much of this is code of my own making, it's always possible. 

Alison

<a id="e-mail-3-from-alison-file-locations"></a>
### E-mail 3 (from Alison): "File Locations"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Thursday, October 20, 2022 at 5:56 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: File Locations

<a id="contents-4"></a>
#### Contents
Hi Kris - 

Nab3 depletion data  
`~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla`

Folders of interest:
- I split samples for speed reasons. Raw fastq R1 and R3 reads in these 3 folders: 
	- 5782_7714
	- 6126_7716
	- 6125_7718
		- Within each folder is UMI folder with R2, I1 and I2 reads. We don't currently have a pipeline with includes them, but I have thought it would be good for a while. 
	- I copied all aligned bams into SC_bams_all
	- Output of HTSeq count (one for each folder above):
		- `~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/S_cerevisiae_BamFiles/bam_resort/feature_counts_7716_6126`

WT G1 vs Q data  
`~/tsukiyamalab/alisong/WTQvsG1/`

Folders of interest: 
- Raw fastq info
	- `~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot`
	- each sample has a folder. The Bioinformatics core does it differently now. So fastq files used to need to be merged. 
	- "IP" = Nascent, "IN" = SteadyState
- Trinity Run Location
	- `~/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/all_at_once/correct_bams`
- Map trinity output to genome location
	- `~/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/map_trin_to_genome/try2`
- I started thinking about annotation automation. Not a ton here but some
	- `~/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation`
- I attempted to break AS transcripts into Classes. That all happened here. This is probably the biggest mess of any of the above:
	- `~/tsukiyamalab/alisong/WTQvsG1/MANUAL/AS_CLASSES`
	- and: `~/tsukiyamalab/alisong/WTQvsG1/MANUAL/AS_CLASSES/jan2022_good`

Steady State Q entry Data
- `~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla`
- This was all done for an old project but might be relevant to Toshi's interests and or the larger project

All the R stuff is local to my laptop/on my OneDrive. Happy to figure out a way to share than more easily. Also please let me know if there are file permission issues. 

Alison

<a id="e-mail-4-from-alison-hand-curation-and-so-many-annotation-files"></a>
### E-mail 4 (from Alison): "Hand Curation and so many annotation files"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Thursday, October 20, 2022 at 6:24 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Hand Curation and so many annotation files 

<a id="files-1"></a>
#### Files
- `Trintity_minus.gtf`
- `Trinity_plus.gtf`
- `Trinity GTF_PROOFING TIME - keep+\_1st_Try.gtf`
- `final_downloadable.gtf`
- `downloadable_collapsed.gtf`
- `GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`
- `sacCer3.intergenic.convergent.bed`
- `sacCer3.intergenic.divergent.bed`
- `sacCer3.intergenic.tandem.bed`
- `Saccharomyces_cerevisiae.R64-1-1.104.gtf`
- `combined.gtf`

<a id="contents-5"></a>
#### Contents
Kris - 

I have attached the Trinity gtf output before and after annotation:
- Trinity plus and minus are each strand separately before any curation
- "PROOFING TIME" - was after first pass
- final downloadable - after second pass
- final downloadable collapsed - fully contained transcripts were merged with gffcompare
I did all the curation in google sheets because excel destroys .gtf files: [link](https://docs.google.com/spreadsheets/d/14NWzq4HJQfft_yWxbmT4bi6C8w1G0Q3PUBbVDO7XguM/edit#gid=1833438810)

I have also attached some general yeast annotation files:
- `GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf` - great annotation
- intergenic bed - bed files by orientation of intergenic region
- R64 - one of the official recent annotations, though definitely not the most recent. 
- `combined.gtf` - every CDS, and bunch of annotations from various noncoding annotation attempts - this is the file that is used for HTseq count btw

Alison 

<a id="e-mail-5-from-alison-small-fraction-of-as-transcripts-functional-on-first-pass"></a>
### E-mail 5 (from Alison): "Small fraction of AS transcripts functional on first pass"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Thursday, October 20, 2022 at 11:35 PM  
To: [Tsukiyama, Toshio](ttsukiya@fredhutch.org)  
Cc: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Small fraction of AS transcripts functional on first pass

<a id="file-1"></a>
#### File
- `Sense_Antisense.pptx`

<a id="contents-6"></a>
#### Contents
From my analysis it looks like because both transcription and steady state RNA level go up so much, that very few genes are down. I suspect if I removed sized factors from this data it would look like a lot more antisense transcripts are functional, and I think that is what happened with the 2013 paper as a spike in control is not mentioned. 

I think the functional fraction is still very interesting, and there's a lot of room to play around with gating to really understand what's going on a bit better - perhaps log2foldchange 2 is too harsh a cut off. Also quite interested in digging more into what mRNAs NNS regulates in Q, and I will plan to spend more time on that soon. 

Alison 
<br />
<br />

<a id="brief-notes-on-fred-hutchs-cluster-resources"></a>
## Brief notes on Fred Hutch's cluster resources
```
#  Log into FH cluster
ssh kalavatt@rhino.fhcrc.org
kalavatt@rhino.fhcrc.org's password: *******************
```
- `Rhino`: shared cluster node
- `Gizmo`: reserved cluster node

More details recorded in gists [here](https://gist.github.com/kalavattam).
<br />
<br />

<a id="new-slides-from-alison"></a>
## New slides from Alison
- The new normalization approach seems to be effective
- Results appear to be reproducible between replicates
- PC1 captures the vast majority of variance in the data but PC2 is the PC that actually separates nascent from steady state
	- The vast majority of variance may be the random-variable nature of the counts for low-expression genes, right?
<br />
<br />

<a id="how-alison-is-calling-trinity"></a>
## How Alison is calling Trinity
- See `trin4.1_adjusted_salmo.sh`
```bash
#!/bin/bash
#DONTRUN

Trinity \
	--genome_guided_bam ${file} \
	--max_memory 50G \
	--SS_lib_type FR \
	--normalize_max_read_cov 200 \
	--jaccard_clip \
	--genome_guided_max_intron 1002 \
    --min_kmer_cov 2 \
    --max_reads_per_graph 500000 \
    --min_glue 2 \
    --group_pairs_distance 700 \
    --min_contig_length 200 \
    --full_cleanup \
    --output ./trinity_trin4s_${file%.bam_sorted_new.bam}
```
- `--genome_guided_bam`: "If a genome sequence is available, Trinity offers a method whereby reads are first aligned to the genome, partitioned according to locus, followed by *de novo* transcriptome assembly at each locus" ([more info](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly))
	- "In this use-case, the genome is only being used as a substrate for grouping overlapping reads into clusters that will then be separately fed into Trinity for *de novo* transcriptome assembly."
	- "This is very much *unlike* typical genome-guided approaches (e.g., cufflinks) where aligned reads are stitched into transcript structures and where transcript sequences are reconstructed based on the reference genome sequence."
	- "Here, transcripts are reconstructed based on the actual read sequences."
- `--max_memory`: suggested max memory to use by Trinity, where limiting can be enabled
- `--SS_lib_type`: if paired, RF or FR (dUTP method = RF); if single, F or R; this means that left-end reads are on the forward strand and right-end reads are on the reverse strand
- `--normalize_max_read_cov`: defaults to 200, an *in silico* read normalization option
	- `#QUESTION` Does it mean that it sets the maximum coverage to 200x?
	- `#ANSWER` It means that "poorly covered regions \[are\] unchanged, but reads \[are\] down-sampled in high-coverage regions" (see slide 16 [here](https://biohpc.cornell.edu/lab/doc/Trinity_workshop.pdf))
	- "May end up using just 20% of all reads reducing computational burden with no impact on assembly quality"
	- `#NOTE` This normalization method has "mixed reviews" – \[it\] tends to skip whole genes
- `--jaccard_clip`: set if you have paired reads and you expect high gene density with UTR overlap (use FASTQ input file format for reads)
	- `#QUESTION`: Our input appears to be a bam; does this affect things?
- `--genome_guided_max_intron`: "...use a maximum intron length that makes most sense given your targeted organism" ([more info](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly))
- `--min_kmer_cov`: with a setting of 2, it means that singleton k-mers will not be included in initial Inchworm contigs (suggested by the Trinity team)
- `--max_reads_per_graph`: maximum number of reads to anchor within a single graph (default: 200000)
- `--min_glue`: min number of reads needed to glue two inchworm contigs together. (default: 2)
- `--group_pairs_distance`: maximum length expected between fragment pairs (default: 500) (reads outside this distance are treated as single-end)
- `--min_contig_length`: minimum assembled contig length to report (def=200, must be >= 100)
- `--full_cleanup`: only retain the Trinity fasta file, rename as `${output_dir}.Trinity.fasta`
- `--output`: name of directory for output (will be created if it doesn't already exist) default(your current working directory: `/usr/local/src/trinity_out_dir` note: must include 'trinity' in the name as a safety precaution!)
