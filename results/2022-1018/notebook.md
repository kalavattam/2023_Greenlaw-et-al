
# 2022-1018-1019
<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [2022-1018](#2022-1018)
	1. [Installing local instance of `Trinity`](#installing-local-instance-of-trinity)
	1. [Use `Docker` to run local instance of `Trinity`](#use-docker-to-run-local-instance-of-trinity)
		1. [Alias to prevent excessive typing](#alias-to-prevent-excessive-typing)
	1. [Potentially interesting/useful links for studying `Trinity`](#potentially-interestinguseful-links-for-studying-trinity)
	1. [Set up directory structure for 2022_transcriptome-construction](#set-up-directory-structure-for-2022_transcriptome-construction)
	1. [Meeting with Alison, 2022-1018](#meeting-with-alison-2022-1018)
	1. [Questions](#questions)
	1. [E-mails between me and Alison \(2022-1017-1019\)](#e-mails-between-me-and-alison-2022-1017-1019)
		1. [E-mail 1: "Fred Hutch Server and a few of my scripts"](#e-mail-1-fred-hutch-server-and-a-few-of-my-scripts)
			1. [Scripts](#scripts)
			1. [Contents](#contents)
		1. [E-mail 2: "Fred Hutch Server and a few of my scripts"](#e-mail-2-fred-hutch-server-and-a-few-of-my-scripts)
			1. [Attached files](#attached-files)
			1. [Contents](#contents-1)
		1. [E-mail 3: "Fred Hutch Server and a few of my scripts"](#e-mail-3-fred-hutch-server-and-a-few-of-my-scripts)
			1. [Attached files](#attached-files-1)
			1. [Contents](#contents-2)
		1. [E-mail 4: "Fred Hutch Server and a few of my scripts"](#e-mail-4-fred-hutch-server-and-a-few-of-my-scripts)
			1. [Script](#script)
			1. [Contents](#contents-3)
1. [2022-1019](#2022-1019)
	1. [Meeting with Alison and Toshi, 2022-1019](#meeting-with-alison-and-toshi-2022-1019)
		1. [Design](#design)
		1. [Background](#background)
		1. [Goals for me](#goals-for-me)
		1. [Next steps](#next-steps)
	1. [E-mails between me and Alison \(2022-1019\)](#e-mails-between-me-and-alison-2022-1019)
		1. [E-mail 1: "Nascent normalization remains baffling"](#e-mail-1-nascent-normalization-remains-baffling)
			1. [File](#file)
			1. [Contents](#contents-4)
			1. [Notes from meeting](#notes-from-meeting)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="2022-1018"></a>
# 2022-1018
<a id="installing-local-instance-of-trinity"></a>
## Installing local instance of `Trinity`
[Instructions.](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-in-Docker#run-trinity-using-docker)
1. Install `Docker`; then, log in to `Docker`
2. `docker pull trinityrnaseq/trinityrnaseq`
<br />
<br />

<a id="use-docker-to-run-local-instance-of-trinity"></a>
## Use `Docker` to run local instance of `Trinity`
```bash
#!/bin/bash
#DONTRUN

docker run --rm -v`pwd`:`pwd` trinityrnaseq/trinityrnaseq Trinity \
	--seqType fq \
	--left `pwd`/reads_1.fq.gz \
	--right `pwd`/reads_2.fq.gz \
	--max_memory 1G \
	--CPU 4 \
	--output `pwd`/trinity_out_dir
```

<a id="alias-to-prevent-excessive-typing"></a>
### Alias to prevent excessive typing
```bash
#!/bin/bash
#DONTRUN

unalias Trinity
alias Trinity="docker run --rm -v`pwd`:`pwd` --platform linux/amd64 trinityrnaseq/trinityrnaseq Trinity"
```
<br />
<br />

<a id="potentially-interestinguseful-links-for-studying-trinity"></a>
## Potentially interesting/useful links for studying `Trinity`
- https://biohpc.cornell.edu/doc/RNA-Seq-2019-exercise1-2.html
- https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity
- https://www.broadinstitute.org/broade/trinity-screencast
- https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-in-Docker#run-trinity-using-docker
- https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html
<br />
<br />

<a id="set-up-directory-structure-for-2022_transcriptome-construction"></a>
## Set up directory structure for 2022_transcriptome-construction
1. Create repo on Github per, e.g., [these instructions](https://github.com/prog4biol/pfb2022/blob/master/unix.md#creating-a-new-repository)
    a. Private (for now)
    b. R-styled `.gitignore` (to be updated)
    c. No license (for now)

```bash
#!/bin/bash
#DONTRUN

dir_proj="projects-etc"

cd  # Go home
mkdir "${dir_proj}" && cd "${dir_proj}"

#  Run first time only
# gh auth login
# ? What account do you want to log into? GitHub.com
# ? What is your preferred protocol for Git operations? HTTPS
# ? Authenticate Git with your GitHub credentials? Yes
# ? How would you like to authenticate GitHub CLI? Login with a web browser
#
# ! First copy your one-time code: A6F8-2289
# Press Enter to open github.com in your browser...
# ✓ Authentication complete.
# - gh config set -h github.com git_protocol https
# ✓ Configured git protocol
# ✓ Logged in as kalavattam

#  Clone 2022_transcriptome-construction repo  # If necessary, run `brew install gh`
gh repo clone kalavattam/2022_transcriptome-construction

mkdir -p 2022_transcriptome-construction/{bin,data,results}  # Start with only these directories for the time being
#  Save this mardown document to notebook.md in 2022_transcriptome-construction/results

#  Push it to 2022_transcriptome-construction/results
git add results/notebook.md
git commit -m 'Initial commit: Uploading notebook.md'
git push origin main
```
<br />
<br />

<a id="meeting-with-alison-2022-1018"></a>
## Meeting with Alison, 2022-1018
- Label yeast (*S. cerevisiae*) with 4tU for 6 minutes: this allows us to identify nascent transcription
- Isolate RNA from frozen pellet
- *K. lactis* spiked in during the RNA-isolation step; thus, the RNA is comprised of two species
- Pull down 40 µg: biotin-streptavidin chemistry
- However, after biotin conjugation but before streptavidin-bead binding, take input: 10% taken out to examine steady-state transcription
- Perform column cleanups
- Use of "Universal Plus Total" kit with custom yeast rRNA probe set, allowing the isolation of stranded cDNA
- Align to *S. cerevisiae* and *K. lactis* separately
- Run `samtools` script that counts the number of alignments (successful) in bam files
- Calculate ratio of *K. lactis* counts to *S. cerevisiae* counts, e.g., `KL/SC`
- Calculate a "ratio of ratios," i.e., an additional normalization: `parent/mutant`
<br />
<br />

<a id="questions"></a>
## Questions
- Where does `Trinity` transcriptome assembly/annotation fit in the above the steps?
- How do we evaluate the annotations output by `Trinity`? What is the "ground truth"? Is there a systematic means of evaluation?
- normalization_station.pptx, 2/14: calculation of "ratio of ratios" is described as `R_sample/R_parental`, but looks like `R_parental/R_sample` in the Excel slide (e.g., `parent/mutant`); which is correct and/or what is my misunderstanding here?
- What is the purpose of the scaling factor here? What is it doing and/or what is it correcting for?
- Are these antisense RNA molecules mRNAs (forgive my ignorance)?
- RPKM/FPKM normalization is a form of RNA-seq normalization that is known to perform poorly when assumptions for library-size normalization (namely, as assumption that extracted  mRNA/cell is the same `*`) are violated; have we considered trying other forms of normalization? I wonder if that's something I could try on the side while Alison moves forward with...
- What does "single tag" and "double tag" mean again?
<br />
<br />

<a id="e-mails-between-me-and-alison-2022-1017-1019"></a>
## E-mails between me and Alison (2022-1017-1019)
<a id="e-mail-1-fred-hutch-server-and-a-few-of-my-scripts"></a>
### E-mail 1: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Monday, October 17, 2022 5:01 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Fred Hutch Server and a few of my scripts

<a id="scripts"></a>
#### Scripts
- `New_101122_sc_bowtie_4tu.sh`
- `bam_split_paired_end.sh`
- `trin4.1_adjusted_salmo.sh`
- `map2genome_gff.sh`

<a id="contents"></a>
#### Contents
Hi Kris!

I know Toshi got a really fancy computer, so it may be better/faster to do this locally for you. For me, I use the server. 

Here is how you log in: [link](https://sciwiki.fredhutch.org/compdemos/first_rhino/)

Here are the modules available: [link](https://sciwiki.fredhutch.org/scicomputing/bio-modules-18.04/)

I attached some of the scripts I use for alignment and annotation. They are in brief:
1. Bowtie 4tU: does alignment and splits strands for paired end RNAseq
2. split paired end: called by bowtie 4tU makes strand specific bam files. Both 1 and 2 were mainly written by Christine's partner who is a software person. I have Frankensteined them to adjust a few things. 
3. trin4.1: the way I ran trinity. There are probably ways these settings could be tweaked. They were stollen from [this pre-print](https://www.biorxiv.org/content/10.1101/575837v1) and only changed slightly. 
4. map2genome: this takes the .fasta output and makes it a .gff annotation format aligned to the yeast genome 
5. Not included: bedtools classing of transcripts. I have messy notes on this but lots of it was directly in terminal. 

Trinity creates a lot of junk transcripts. It will connect things that overlap, and generally is oversensitive. I have tried filtering by mapping quality the bams that go into trinity, this helps but hasn't been the silver bullet. *I think running trinity with a bunch of different setting may be the solution*, but for me at least trinity takes a long long time to run so we will need to be strategic in our testing. 

Hope you feel better. Take your time with this; I know it's a lot of information. 

Best, 
Alison 

<a id="e-mail-2-fred-hutch-server-and-a-few-of-my-scripts"></a>
### E-mail 2: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Tuesday, October 18, 2022 2:11 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Re: Fred Hutch Server and a few of my scripts

<a id="attached-files"></a>
#### Attached files
- `heatmaps_nab3_nrd1.pptx`
- `20220928_lab_meeting.pptx`
- `scaling_factor.xlsx`

<a id="contents-1"></a>
#### Contents
NA

<a id="e-mail-3-fred-hutch-server-and-a-few-of-my-scripts"></a>
### E-mail 3: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Tuesday, October 18, 2022 2:12 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Re: Fred Hutch Server and a few of my scripts

<a id="attached-files-1"></a>
#### Attached files
NA

<a id="contents-2"></a>
#### Contents
(Concerns Nature Reviews on noncoding RNAs.)
- [How noncoding RNAs began to leave the junkyard | Nature Methods](https://www.nature.com/articles/s41592-022-01627-8?utm_source=nmeth_etoc&utm_medium=email&utm_campaign=toc_41592_19_10&utm_content=20221011)
- [Regulatory non-coding RNAs: everything is possible, but what is important? | Nature Methods](https://www.nature.com/articles/s41592-022-01629-6?utm_source=nmeth_etoc&utm_medium=email&utm_campaign=toc_41592_19_10&utm_content=20221011)
- [Some roads ahead for noncoding RNAs | Nature Methods](https://www.nature.com/articles/s41592-022-01628-7?utm_source=nmeth_etoc&utm_medium=email&utm_campaign=toc_41592_19_10&utm_content=20221011)

<a id="e-mail-4-fred-hutch-server-and-a-few-of-my-scripts"></a>
### E-mail 4: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Tuesday, October 18, 2022 7:22 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Re: Fred Hutch Server and a few of my scripts

<a id="script"></a>
#### Script
- `AG_CC_read_counts_RNA_April2022.sh`

<a id="contents-3"></a>
#### Contents
I realized I never gave you the script that counts reads for normalization. Here is that! (No need to look at it tonight!!!) 

Alison
<br />
<br />

<a id="2022-1019"></a>
# 2022-1019
<a id="meeting-with-alison-and-toshi-2022-1019"></a>
## Meeting with Alison and Toshi, 2022-1019
<a id="design"></a>
### Design
- With Alison's project, comparing three types of Q cells
- For parental and mutant strains, there are two lines (except double mutant strains)
- Add 4tU, label for 6 minutes: transcribed RNAs within this window will include 4tU
- Sequence all RNA
	- The total is considered "steady state" RNA
	- Pull down the transcripts that contain 4tU (using "click chemistry")
- Rationale for normalization: On a per-cell level, how much is transcription changing? Unless we normalize, we can't say if, e.g., "antisense is only increasing or sense is going down"
	- This rationale is not super clear
- From 40 µg total RNA, end up with 16 µL of nascent RNA at a concentration of approximately 5 ng/µL

<a id="background"></a>
### Background
- In Q, many genes have highly elevated antisense transcription
- Want to establish what among these have functional significance
- Experimental system: Have depleted genetic factors with roles in the termination of antisense transcription
- We'll know this experimental system work if/when...
    - we see that antisense transcription is up for genes
    - antisense transcription termination is blocked, i.e., the ncRNA is longer

<a id="goals-for-me"></a>
### Goals for me
- Help Alison with normalization
    - The logic for *ratio of ratios*: "If *S. cerevisiae* goes up, we want the scaling factor to go up."
    - `#QUESTION` But surely there's another way to calculate a number with this property, right?
    - `#NOTE` Toshi requested that Alison try a different calculation/normalization scheme
    - `#TODO` Touch base with Alison on what she's doing now
    - I think this is it:
    	- First, normalize to depth
    	- Then, calculate size factor for the strain (take the ratio `KL/SC`)
    	- "One strain set as basis"  `#WHAT`
- Need to establish an automated way to annotate ncRNAs with Trinity
	- Non-trivially difficult: No ORF as with sense transcripts

<a id="next-steps"></a>
### Next steps
- Get Alison's code running on the cluster
- Systematize it
- `#GENERAL` Learn how people do things and search for more streamlined ways to do things
- Look into additional programs to do transcriptome annotation like Trinity, but touch base with Alison before trying any of them: She may have tried them already and may then have input
<br />
<br />

<a id="e-mails-between-me-and-alison-2022-1019"></a>
## E-mails between me and Alison (2022-1019)

<a id="e-mail-1-nascent-normalization-remains-baffling"></a>
### E-mail 1: "Nascent normalization remains baffling"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Wednesday, October 19, 2022 7:30 AM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Nascent normalization remains baffling

<a id="file"></a>
#### File
- `normalization_station.pptx`

<a id="contents-4"></a>
#### Contents
Hi Toshi - 

I messed around with the normalization, trying to get the big nascent discrepancy to make sense and I couldn't. I have attached the details. 

(Email scheduled for 7:30 am) 

Alison 

<a id="notes-from-meeting"></a>
#### Notes from meeting
(See above notes)
