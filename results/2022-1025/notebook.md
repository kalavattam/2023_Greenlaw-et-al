
# 2022-1025-1101
<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [2022-1025](#2022-1025)
    1. [E-mail: "Additional Nab3 Analysis"](#e-mail-additional-nab3-analysis)
        1. [File](#file)
        1. [Contents](#contents)
    1. [Working through the "Five things to try out/work on" in `notebook.md`](#working-through-the-five-things-to-try-outwork-on-in-notebookmd)
        1. [Working on the bullet "Test the genome-guided bam approach to `Trinity`..."](#working-on-the-bullet-test-the-genome-guided-bam-approach-to-trinity)
            1. [Snippets, etc. from searching the `Trinity Google Group`](#snippets-etc-from-searching-the-trinity-google-group)
                1. [Have searched for term "Jaccard"](#have-searched-for-term-jaccard)
                    1. ["Genome-guided assembly questions"](#genome-guided-assembly-questions)
                1. [Have searched for the term "antisense"](#have-searched-for-the-term-antisense)
                    1. ["genome guided strand specific assembly"](#genome-guided-strand-specific-assembly)
                    1. ["filtering 'fake' antisense and overly similar sequences" by Brian Haas](#filtering-fake-antisense-and-overly-similar-sequences-by-brian-haas)
                    1. ["evaulating strand-specificity"](#evaulating-strand-specificity)
            1. [Important links, etc.](#important-links-etc)
            1. [Check that libraries are indeed FR and not RF](#check-that-libraries-are-indeed-fr-and-not-rf)
    1. [Miscellaneous](#miscellaneous)
    1. [Notes from meeting with Alison and Toshi](#notes-from-meeting-with-alison-and-toshi)
    1. [Notes from meeting with Alison to discuss the `Trinity` work](#notes-from-meeting-with-alison-to-discuss-the-trinity-work)
        1. [Two things to try out](#two-things-to-try-out)
1. [2022-1026](#2022-1026)
    1. [E-mail: "Some R code"](#e-mail-some-r-code)
        1. [File](#file-1)
        1. [Contents](#contents-1)
    1. [Creation of a combined reference genome](#creation-of-a-combined-reference-genome)
        1. [1. The `fasta` for *Saccharomyces 20 S narnavirus* can be obtained from the Saccharomyces Genome Database \(SGD\)](#1-the-fasta-for-saccharomyces-20-s-narnavirus-can-be-obtained-from-the-saccharomyces-genome-database-sgd)
        1. [2. Go ahead and grab the other *S. cerevisiae* virus sequences available on SGD](#2-go-ahead-and-grab-the-other-s-cerevisiae-virus-sequences-available-on-sgd)
        1. [3. Now, get the genome `fasta` for *S. cerevisiae* from Ensembl release 108](#3-now-get-the-genome-fasta-for-s-cerevisiae-from-ensembl-release-108)
        1. [4. Now, get the genome `fasta` for *K. lactis*](#4-now-get-the-genome-fasta-for-k-lactis)
        1. [5. Clean up the headers for the 20S narnavirus, *S. cerevisisae*, and *K. lactis*](#5-clean-up-the-headers-for-the-20s-narnavirus-s-cerevisisae-and-k-lactis)
    1. [Concatenate the *S. cerevisiae*, *K. lactis*, and *S20* genomes](#concatenate-the-s-cerevisiae-k-lactis-and-s20-genomes)
        1. [Chromosome contents of `combined_SC_KL_20S.fasta`:](#chromosome-contents-of-combined_sc_kl_20sfasta)
        1. [Create `Bowtie 2` indices](#create-bowtie-2-indices)
1. [2022-1027-1028](#2022-1027-1028)
    1. [Continued work with `how_are_we_stranded_here`](#continued-work-with-how_are_we_stranded_here)
    1. [Items to work through `#TODO`](#items-to-work-through-todo)
        1. [Downsampling `fastq` files](#downsampling-fastq-files)
        1. [Stepping through each line](#stepping-through-each-line)
            1. [Will piping to threaded `samtools sort` work?](#will-piping-to-threaded-samtools-sort-work)
                1. [`samtools sort` number of threads in reading phase #891](#samtools-sort-number-of-threads-in-reading-phase-891)
                    1. [`bernt-matthias` commented on Jul 11, 2018](#bernt-matthias-commented-on-jul-11-2018)
                    1. [`jkbonfield` commented on Jul 11, 2018](#jkbonfield-commented-on-jul-11-2018)
                    1. [`bernt-matthias` commented on Jul 11, 2018](#bernt-matthias-commented-on-jul-11-2018-1)
                    1. [`jkbonfield` commented on Jul 11, 2018](#jkbonfield-commented-on-jul-11-2018-1)
                    1. [My thoughts, 2022-1028](#my-thoughts-2022-1028)
        1. [Stepping through each line](#stepping-through-each-line-1)
            1. [Stepping through `split_bam_by_species.sh`](#stepping-through-split_bam_by_speciessh)
            1. [Miscellaneous tab to remember](#miscellaneous-tab-to-remember)
1. [2022-1031](#2022-1031)
    1. [`#NOTE`](#note)
    1. [`#TODO`](#todo)
1. [2022-1101](#2022-1101)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="2022-1025"></a>
# 2022-1025
<a id="e-mail-additional-nab3-analysis"></a>
## E-mail: "Additional Nab3 Analysis"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Monday, October 24, 2022 at 11:34 PM  
To: [Tsukiyama, Toshio](ttsukiya@fredhutch.org)  
Cc: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Additional Nab3 Analysis

<a id="file"></a>
### File
- `more analysis.pptx`

<a id="contents"></a>
### Contents
Hi Toshi - 

You have seen a lot of the analysis in the attached but there's some new stuff too, as well as what I am thinking of doing next. I am happy with what I am seeing so far. 

Kris - I will send you the code related to this analysis in the next few days. I want to get it organized and commented first. 

Alison
<br />
<br />

<a id="working-through-the-five-things-to-try-outwork-on-in-notebookmd"></a>
## Working through the "Five things to try out/work on" in `notebook.md`
...("Going over Trinity assessments with Alison")
<a id="working-on-the-bullet-test-the-genome-guided-bam-approach-to-trinity"></a>
### Working on the bullet "Test the genome-guided bam approach to `Trinity`..."
...versus the fastq approach
<a id="snippets-etc-from-searching-the-trinity-google-group"></a>
#### Snippets, etc. from searching the [`Trinity Google Group`](https://groups.google.com/g/trinityrnaseq-users)
<a id="have-searched-for-term-jaccard"></a>
##### Have searched for term "Jaccard"
<a id="genome-guided-assembly-questions"></a>
###### ["Genome-guided assembly questions"](https://groups.google.com/g/trinityrnaseq-users/c/HV-JK9xiC8E/m/tVyPJzpYBgAJ)
Post #2
```txt
...

For drosophila, the `--jaccard_clip` can help. If you have strand-specific rna-seq, then I wouldn't bother, since the strand-specific rna-seq already solves a lot of the problems that jaccard-clip is meant to mitigate.

...
```

Post #3
```txt
Brian,

Is it your recommendation to never use jaccard-clip with strand-specific RNA-seq? Or would you still use it with *very dense genomes like yeast*?

thanks,  
-Will
```

Post #4
```txt
With very dense genomes, you'll always need it.  For moderately-dense genomes, you can probably get away w/out it if you have strand-specific data.

Jaccard clip is by no means a 'cure' for the issue....  it just mitigates it.  We still need a more effective approach for it ... someday.

\~b
```

<a id="have-searched-for-the-term-antisense"></a>
##### Have searched for the term "antisense"
<a id="genome-guided-strand-specific-assembly"></a>
###### ["genome guided strand specific assembly"](https://groups.google.com/g/trinityrnaseq-users/c/DVnpAnhdNeA/m/RM5oT_PXAAAJ)
Post #6
```txt
The process we support is to just give it a single coordinate sorted bam file, indicate the `--SS_lib_type` mode and let Trinity do the transcribed strand based separation of the alignments.
```


<a id="filtering-fake-antisense-and-overly-similar-sequences-by-brian-haas"></a>
###### ["filtering 'fake' antisense and overly similar sequences" by Brian Haas](https://groups.google.com/g/trinityrnaseq-users/c/2Fe5dZu7FnY/m/r69jVJfSBAAJ)
```txt
Hi all,

Attached is a little script you can drop into trinityrnaseq/util/misc and use (along with having cdhit installed) to filter out transcripts that might derive from 'fake' antisense in the context of > strand-specific rna-seq, or to weed out overly similar sequences that tend to be shorter and lowly expressed (possible artifacts).

It'll go into the next release as an option for additional filtering.

It's only been used lightly so far by myself, so let me know if you encounter any weirdness / bugs.

Run like so:
    filter_similar_seqs_expr_and_strand_aware.pl  \
        --transcripts_fasta Trinity.fasta \
        --expr_matrix  isoforms.expr.matrix \
            > Trinity.filtered.fasta
```

<a id="evaulating-strand-specificity"></a>
###### ["evaulating strand-specificity"](https://groups.google.com/g/trinityrnaseq-users/c/Gi8_f_kXxh4/m/yBGD9RG3BAAJ)
Post #2
- on removing the approximately 1% of fake antisense reads from strand-specific library preparation, sequencing, etc.
- I guess this pertains to `filter_similar_seqs_expr_and_strand_aware.pl` in `trinityrnaseq/util/misc` mentioned immediately above
```txt
Hi Sjannie,

If it's a deeply sequenced data set, then I expect you'll see more of a spread, and it's because the strand-specificity is generally about 99% effective.  If you sequence deep enough, that remaining 1% can accumulate sufficient reads to have Trinity assemble the same transcript in the 'antisense' orientation in addition to the more dominantly supported sense orientation.  So, you end up with some artificial lowly expressed antisense transcript assemblies in the output, and these are presumably the transcripts that are shifting the distribution here.  They'll be lowly expressed in when quantified using a strand-specific quantification method.

I don't have a canned solution for dealing with this, mainly because I haven't needed to.  I just tend to ignore the lowly expressed contigs, as they don't tend to show up as significant in any downstream assay of DE, and are just passengers in the study.  But, I can imagine a simple protocol for cleaning them up, and we could implement something for it for the next release.  It would involve two steps (after having a strand-specific assembly and an expression matrix): 
  1. running cdhit-est to cluster at high stringency (high identity and high percent length overlap of the shorter transcript), and
  2. excluding entries in a cdhit cluster that have an expression value below some threshold of the dominantly expressed transcript and having a transcriptional orientation that's opposite from the dominantly expressed transcript (antisense).

You could assume an \~1% 'fake' antisense rate given what we know about the experimental protocols.

\~brian
```

<a id="important-links-etc"></a>
#### Important links, etc.
- ["De novo RNA-Seq Assembly, Annotation, and Analysis Using Trinity and Trinotate," part of the "Informatics for RNA-Seq Analysis" Workshop](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6)
- ["Informatics for RNA-Seq Analysis" Workshop home page](https://bioinformaticsdotca.github.io/rnaseq_2017)
- ["Transcriptome Assembly Quality Assessment" by Brian Haas, co-author and maintainer of Trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Transcriptome-Assembly-Quality-Assessment)

<a id="check-that-libraries-are-indeed-fr-and-not-rf"></a>
#### Check that libraries are indeed FR and not RF
- ["Strandness in RNASeq" by Hong Zheng, 2017-0817](https://littlebitofdata.com/en/2017/08/strandness_in_rnaseq/)
- ["signalbash/how_are_we_stranded_here"](https://github.com/signalbash/how_are_we_stranded_here)
```bash
#!/bin/bash
#DONTRUN

#  Install how_are_we_stranded_here in its own environment on rhino/gizmo -----

#NOTE Installation is finnicky; here's how I ultimately ended up doing it...
#  Building on advice at this link:
#+ github.com/signalbash/how_are_we_stranded_here/issues/13
mamba create -n strandedness_env
conda activate strandedness_env

mamba install -c conda-forge python=3.6.15  
mamba install -c conda-forge numpy=1.10
mamba install -c bioconda kallisto=0.44.0
mamba install -c bioconda bx-python  # python-lzo, a necessary package, is installed alognside bx-python
mamba install -c bioconda rseqc
mamba install -c bioconda how_are_we_stranded_here  # pandas, a necessary package, is installed alongside how_are_we_stranded_here


#  Download files needed by how_are_we_stranded_here --------------------------
#  These are (a) a genome-annotation gtf file and (b) a fasta of transcript
#+ sequences (cDNA), for S. cerevisiae
cd "${HOME}/genomes/sacCer3"
mkdir -p Ensembl/108
cd mkdir -p Ensembl/108

#  Get the gtf file(s)
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/CHECKSUMS
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/README
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gtf.gz
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.108.gtf.gz

mkdir gtf
mv CHECKSUMS README *.gtf.gz gtf/

#  Get the transcripts (cdna) file
wget https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/cdna/CHECKSUMS
wget https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/cdna/README
wget https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/cdna/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz

mkdir cDNA
mv CHECKSUMS README *.fa.gz cDNA/


#  Now, set up vartiables and run how_are_we_stranded_here --------------------
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025"

pa_fastq="${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_157_G1_IN"
pa_gtf_cDNA="${HOME}/genomes/sacCer3/Ensembl/108"

check_strandedness \
    --gtf "${pa_gtf_cDNA}/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
    --transcripts "${pa_gtf_cDNA}/cDNA/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa" \
    --reads_1 "${pa_fastq}/5781_G1_IN_GTCGAGAA_L001_R1_001.fastq" \
    --reads_2 "${pa_fastq}/5781_G1_IN_GTCGAGAA_L001_R2_001.fastq"
```

Output of `how-are-we-stranded-here` printed to screen
```txt
Results stored in: stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001
converting gtf to bed
Checking if fasta headers and bed file transcript_ids match...
OK!
generating kallisto index

[build] loading fasta file /home/kalavatt/genomes/sacCer3/Ensembl/108/cDNA/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa
[build] k-mer length: 31
[build] counting k-mers ... done.
[build] building target de Bruijn graph ...  done
[build] creating equivalence classes ...  done
[build] target de Bruijn graph has 11489 contigs and contains 8243691 k-mers

creating fastq files with first 200000 reads
quantifying with kallisto

[quant] fragment length distribution will be estimated from the data
[index] k-mer length: 31
[index] number of targets: 6,612
[index] number of k-mers: 8,243,691
[index] number of equivalence classes: 8,064
Warning: 515 transcripts were defined in GTF file, but not in the index
[quant] running in paired-end mode
[quant] will process pair 1: stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/5781_G1_IN_GTCGAGAA_L001_R1_001_sample.fq
                             stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/5781_G1_IN_GTCGAGAA_L001_R2_001_sample.fq
[quant] finding pseudoalignments for the reads ... done
[quant] processed 200,000 reads, 108,480 reads pseudoaligned
[quant] estimated average fragment length: 229.667
[   em] quantifying the abundances ... done
[   em] the Expectation-Maximization algorithm ran for 270 rounds
[  bam] writing pseudoalignments to BAM format .. done
[  bam] sorting BAM files .. done
[  bam] indexing BAM file .. done

checking strandedness
Reading reference gene model stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/Saccharomyces_cerevisiae.R64-1-1.108.bed ... Done
Loading SAM/BAM file ...  Finished
Total 177529 usable reads were sampled
This is PairEnd Data
Fraction of reads failed to determine: 0.0824
Fraction of reads explained by "1++,1--,2+-,2-+": 0.8990 (98.0% of explainable reads)
Fraction of reads explained by "1+-,1-+,2++,2--": 0.0186 (2.0% of explainable reads)
Over 90% of reads explained by "1 ++,1--,2+-,2-+"
Data is likely FR/fr-secondstrand
```
Sure enough, the library is likely to be `FR`, consistent with what Alison is invoking in `Trinity`
<br />
<br />

<a id="miscellaneous"></a>
## Miscellaneous
`#TODO` Look into [these Google search results for "spike-in normalization eli5"](https://www.google.com/search?q=spike-in+normalization+eli5&oq=spike-in+normalization+eli5&aqs=chrome..69i57j0i546l2.5874j0j7&sourceid=chrome&ie=UTF-8)  
`#TODO` Look into [these Google search results for "s cerevisiae blacklist"](https://www.google.com/search?q=s+cerevisiae+blacklist&oq=s+cerevisiae+blacklist&aqs=chrome..69i57j69i64l3.4473j0j4&sourceid=chrome&ie=UTF-8)
<br />
<br />

<a id="notes-from-meeting-with-alison-and-toshi"></a>
## Notes from meeting with Alison and Toshi
(...with regards to `pptx` in e-mail "Additional Nab3 Analysis," sent 2022-1024)
- `#TODO` A more formal, polished implementation of the calculation of TPM (e.g., see *Slide 1*), building on what Alison did in `Analysis_sense_antisense.Rmd` (see directory `results/2022-1025/Rmd`)
- `#QUESTION` What does "gated at 14 TPM" mean?
    - `#ANSWER` Top 20% expressed antisense transcripts upon depletion of *Nab3*
    - If we do this analysis, per Toshi, we need to show...
        - Suggestion from Alison: Maybe stringent; try top 10%, top 30%
        - Suggestion from Toshi that Alison is going to move forward with: Try different quintiles; "it's possible at a certain level that fold change doesn't matter"
- Per Toshi, should not care about very lowly expressed transcripts (`#QUESTION` mRNA? AS? All?) because, `#REMEMBER`, our data are very, very deeply sequenced
    - The yeast genome is much, much smaller than mammalian genomes
- `#QUESTION` Is it the absolute level or relative increase of antisense transcription that matters?
    - Toshi suspects that absolute levels are the most important, per Alison, "for function"
    - If no increase from parent to depletion (child), then it may not be functional or, at least, we won't be to see it from this perspective
- Alison is calculation a "representation factor" statistic for set overlaps (e.g., Venn diagrams) using the web software and details here:
    - [Home](http://nemates.org/MA/): Click on "Statistical significance of the overlap between two groups of genes"
    - [The software](http://nemates.org/MA/progs/overlap_stats.html)
    - [The details](http://nemates.org/MA/progs/representation.stats.html) `#TODO`
    - These stats that are being generated: Are they legitimate/appropriate given the context of our analyses, the question(s) we ask? `#TODO`
- On *Slide 2*, both sense (S) and antisense (AS) transcripts (tx) are "from nascent"
- Per Toshi, ≤20 AS tx are biologically functional for their activity, not their RNA product, in budding yeast (*Saccharomyces cerevisiae*)
- Per Toshi and Alison, may be interesting to look into the following: AS nascent versus steady-state (SS) sense in "all combinations" `#TODO` Follow up on what they're talking about here
- *Slides 2 and 3*: Many of the AS tx that are up, corresponding S does not go down: `#QUESTION` From Toshi: Is this because there's no S to begin with?
- *Slide 4*: y-axis is S, and panel B is from a separate paper (the left panel is from Alison)
    - Panel B is not Q: it's "late log" (OD 0.6 to 3.0)
    - Alison depleted *Nab3*, the team behind the other paper (2013, I think?) depleted a factor that forms a dimer with Nab3, so it's expected to have a similar function
- *Slide 7* (the violin-plot slide): Shows changes in mRNA depletion
- *Slide 8* (the next violin-plot slide): Shows absolute levels of AS tx (in TPM)
    - Possibilities for "activating" AS tx or "neutral and everything is coming up" `#TODO` Get clarification on this second part?
    - Or it could be that Nab3 (which is currently depleted) would otherwise be degrading the currently upregulated mRNA (e.g., in "violins" 2 and 3)
    - "Are they tandem genes" because PolII keeps going (`#QUESTION` I presume they're talking about something like "slip-through tx" here?)
- Question from Toshi: "How much overlap to say that S/AS overlap?" Answer from Alison: "Whatever HTSeq says" `#NOTE` She'll look into precisely is going on here
- Point from Toshi: It's possible that, once we annotate in a formal way (i.e., optimize the `Trinity` work), things might change quite a bit
- *Slide 11* ("Sense up, AS up")
    - Is this because S was very low to begin with?
    - Per Toshi, it's hard to imagine both strands robustly transcribed
- `#QUESTION` from Toshi: Should we pause to get a "correct annotation" and then do "serious analyses?"
    - Alison wants to continue with the current work, which she and Toshi consider "rough draft analyses"
    - Alison: "It's interesting to play around with."
    - However, going to eventually need to redo everything with proper annotations
    - The main findings are unlikely change
- `#QUESTION` If AS is increased, then are you more likely to have S up, down, or unchanged?
- Some next steps for Alison
    - Re-do "bin analyses" (violin plot slides) with AS "bins" (categories, really)
    - Correlation analyses between nascent and steady
<br />
<br />

<a id="notes-from-meeting-with-alison-to-discuss-the-trinity-work"></a>
## Notes from meeting with Alison to discuss the `Trinity` work
- `#QUESTION` The `fastq` files in `${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot`, do I need to do anything with them (e.g., regarding the *K. lactis* spike-in and/or 20 S) prior to using them as input with `Trinity`?
    - Can try to give the fastq (contains *K. lactis* and 20 S information in addition to *S. cerevisiae* information)
    - The two species are largely conserved (if I copied down this note correctly), but there is some notable divergence between the two `#TODO` Follow up with Alison on this
    - Alison mentioned a genome duplication event: Did it occur prior to the airising of the two species? `#TODO` Follow up with Alison on this
    - Idea worked out with Alison: Create a combined genome comprised of *S. cerevisiae*, *K. lactis*, and 20 S
        - Align to it
        - Filter out reads aligned to *K. lactis* and 20 S
        - Use the remaining reads, aligned to *S. cerevisiae* as `bam` input to `Trinity`
            - Could convert from bam to fastq and split by chromosome too... `#TODO` Think about this...
- `#QUESTION` Are there *K. lactis* reads in these `fastq` files, in addition to *S. cerevisiae* reads? `#ANSWER` Yes, and 20 S reads too
- `#QUESTION` ...for the `fastq` and `bam` files prior to using them as input for `deepTools bamCoverage`?
- `#QUESTION` Alison is calling `Trinity` with `--SS_lib_type FR`; however, most strand-specific libraries are generated with the dUTP method, which means they need `--SS_lib_type RF`; therefore, are we sure that `--SS_lib_type FR` is correct here? `#ANSWER` Yes, see the results of your work with `how_are_we_stranded_here` in `results/2022-1025/readme.md`

<a id="two-things-to-try-out"></a>
### Two things to try out
1. `#TODO (   )` A "better way" to calculate TPM (see "Notes from meeting with Alison and Toshi" above)
2. `#TODO (   )` Create a combined genome comprised of *S. cerevisiae*, *K. lactis*, and 20 S (more details immediately above); then, select the *S. cerevisiae* alignments for downstream analyses
<br />
<br />

<a id="2022-1026"></a>
# 2022-1026
<a id="e-mail-some-r-code"></a>
## E-mail: "Some R code"
<a id="file-1"></a>
### File
- `Analysis_sense_antisense.Rmd`
- `AS_mRNA_Nascent_Nab3.txt`
- `AS_TPM.txt`
- `deletionmeta_AS.txt`
- `deletionmeta.txt`
- `mRNA_Nascent_Nab3.txt`
- `res_order_AS_Diff_expression.txt`
- `WT_Q_G1_TPM.txt`

<a id="contents-1"></a>
### Contents
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Date: Tuesday, October 25, 2022 at 6:56 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Some R code

I have attached the .Rmd that does most all the analysis we went over this afternoon with Toshi. I have also attached the 7 .txt files it needs to read in to work. Let me know if you have any questions or issues. 
 
Alison
<br />
<br />

<a id="creation-of-a-combined-reference-genome"></a>
## Creation of a combined reference genome
...comprised of *S. cerevisiae*, *K. lactis*, and 20 S narnavirus

<a id="1-the-fasta-for-saccharomyces-20-s-narnavirus-can-be-obtained-from-the-saccharomyces-genome-database-sgd"></a>
### 1. The `fasta` for *Saccharomyces 20 S narnavirus* can be obtained from the [Saccharomyces Genome Database (SGD)](https://www.yeastgenome.org/)
- In the search bar, input "20 S"
- The second result (October 26, 2022) is "20S_RNA_Narnavirus_1997_NC004051.fsa"
- Downloads for the `fasta` file and `README` are available; use the links to download the files

```bash
#!/bin/bash
#DONTRUN

grabnode

#  Saccharomyces cerevisiae narnavirus 20S RNA
#+ yeastgenome.org/search?q=20s&is_quick=true
cd "${HOME}/genomes"
mkdir -p 20S_RNA_Narnavirus_1997_NC004051 && cd 20S_RNA_Narnavirus_1997_NC004051

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209166/20S_RNA_Narnavirus_1997_NC004051.fsa \
    > 20S_RNA_Narnavirus_1997_NC004051.fasta

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README \
    > yeast_viruses.README

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209349/20S_RNA_Narnavirus_1997_NC004051.gb \
    > 20S_RNA_Narnavirus_1997_NC004051.gb

```

<a id="2-go-ahead-and-grab-the-other-s-cerevisiae-virus-sequences-available-on-sgd"></a>
### 2. Go ahead and grab the other *S. cerevisiae* virus sequences available on [SGD](https://www.yeastgenome.org/)

```bash
#!/bin/bash
#DONTRUN

#  Saccharomyces cerevisiae virus L-A (L1)
#+ yeastgenome.org/search?q=L-A_L1_2002_NC003745&is_quick=true
cd "${HOME}/genomes"
mkdir -p L-A_L1_2002_NC003745 && cd L-A_L1_2002_NC003745

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209169/L-A_L1_2002_NC003745.fsa \
    > L-A_L1_2002_NC003745.fasta

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README \
    > yeast_viruses.README

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209352/L-A_L1_2002_NC003745.gb \
    > L-A_L1_2002_NC003745.gb

cd ..

#  Killer virus of S. cerevisiae
#+ yeastgenome.org/search?q=killer&is_quick=true
mkdir -p KillerVirusM1_1996_NC001782 && cd KillerVirusM1_1996_NC001782

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209168/KillerVirusM1_1996_NC001782.fsa \
    > KillerVirusM1_1996_NC001782.fasta

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README \
    > yeast_viruses.README

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209351/KillerVirusM1_1996_NC001782.gb \
    > KillerVirusM1_1996_NC001782.gb

cd ..

#  Saccharomyces cerevisiae narnavirus 23S RNA
#+ yeastgenome.org/search?q=23S&is_quick=true
mkdir -p 23S_RNA_Narnavirus_1997_NC004050 && cd 23S_RNA_Narnavirus_1997_NC004050

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209167/23S_RNA_Narnavirus_1997_NC004050.fsa  \
    > 23S_RNA_Narnavirus_1997_NC004050.fasta \

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README  \
    > yeast_viruses.README \

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209350/23S_RNA_Narnavirus_1997_NC004050.gb  \
    > 23S_RNA_Narnavirus_1997_NC004050.gb \

cd ..

#  Saccharomyces cerevisiae virus L-BC
#+ yeastgenome.org/search?q=L-BC&is_quick=true
mkdir -p L-BC_La_1993_NC001641 && cd L-BC_La_1993_NC001641

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209170/L-BC_La_1993_NC001641.fsa \
    > L-BC_La_1993_NC001641.fasta

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README \
    > yeast_viruses.README

curl \
    https://sgd-prod-upload.s3.amazonaws.com/S000209353/L-BC_La_1993_NC001641.gb \
    > L-BC_La_1993_NC001641.gb

cd ..
```

<a id="3-now-get-the-genome-fasta-for-s-cerevisiae-from-ensembl-release-108"></a>
### 3. Now, get the genome `fasta` for *S. cerevisiae* from [Ensembl release 108](https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/)
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/sacCer3" || echo "cd failed. Check on this."

alias .,="ls -lhaFG"
.,
```

Results:
```txt
total 19M
drwxrwx--- 4 kalavatt  105 Oct 26 13:15 ./
drwxrwx--- 8 kalavatt  247 Oct 26 13:08 ../
drwxrwx--- 3 kalavatt   21 Oct 25 16:19 Ensembl/
drwxrwx--- 3 kalavatt  628 Oct 24 15:07 GMAP/
-rw-rw---- 1 kalavatt 2.9M Oct 24 14:48 sacCer3.2bit
-rw-rw---- 1 kalavatt  12M Oct 24 14:52 sacCer3.fa
```

Looks we have a `fasta` already, `sacCer3.fa`, from converting the `2bit` to `fasta` with `twoBitToFa`. Technically, these files should be with the `Ensembl/108/` subdirectory, so go ahead and move them into there. Also, go ahead and rename the file to `sacCer3.fasta`, and grab the corresponding `README` for the file.
```bash
#!/bin/bash
#DONTRUN

mv sacCer.* Ensembl/108/

cd Ensembl/108/

mv sacCer3.fa sacCer3.fasta

#  Organize things a bit...
mkdir -p 2bit_fasta
mv *.2bit *.fasta  2bit_fasta/
```

The `2bit` was obtained from [this UCSC goldenPath link](https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips); thus, get the `README` from this spot too. Also, per the `README`, the `2bit` is dated **2011-08-24**. This is quite old.
```bash
#!/bin/bash
#DONTRUN

cd 2bit_fasta || echo "cd failed. Check on this."

vi README  # Then, copy in the text from the above UCSC goldenPath link
curl \
    https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/md5sum.txt \
    > md5sum.txt
```

Is there an updated genome fasta available from [Ensembl release 108](https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/)? Let's check.
```bash
#!/bin/bash
#DONTRUN

#  Move 2bit_fasta to a new, non-Ensembl-release-108 directory for clear
#+ indication of its status as an older assembly
cd "${HOME}/genomes/sacCer3" || echo "cd failed. Check on this."

mkdir -p UCSC
mv Ensembl/108/2bit_fasta ./UCSC/
#  OK, this is better...

cd Ensembl/108
mkdir -p DNA && cd DNA

#  It looks like 'Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz' is the
#+ file we want
curl \
    https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz \
    > Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz

curl \
    https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/README \
    > README

curl \
    https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/CHECKSUMS \
    > CHECKSUMS

zcat Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz | head -5
```

Results:
```txt
>I dna:chromosome chromosome:R64-1-1:I:1:230218:1 REF
CCACACCACACCCACACACCCACACACCACACCACACACCACACCACACCCACACACACA
CATCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
CACCATCCATCCCTCTACTTACTACCACTCACCCACCGTTACCCTCCAATTACCCATATC
```
Note how the name of the chromosome is 'I' and not 'chrI' as it is in the UCSC `2bit`/`fasta`. `#NOTE` I may need to make a new version of the `*.toplevel.fa.gz` file with cleaned up, simplified chromosome names.

List all of the chromosome names in the Ensembl `fasta` file:
```bash
#!/bin/bash
#DONTRUN

fasta="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz"
zgrep "^>" "${fasta}"
```

Results:
```txt
>I dna:chromosome chromosome:R64-1-1:I:1:230218:1 REF
>II dna:chromosome chromosome:R64-1-1:II:1:813184:1 REF
>III dna:chromosome chromosome:R64-1-1:III:1:316620:1 REF
>IV dna:chromosome chromosome:R64-1-1:IV:1:1531933:1 REF
>V dna:chromosome chromosome:R64-1-1:V:1:576874:1 REF
>VI dna:chromosome chromosome:R64-1-1:VI:1:270161:1 REF
>VII dna:chromosome chromosome:R64-1-1:VII:1:1090940:1 REF
>VIII dna:chromosome chromosome:R64-1-1:VIII:1:562643:1 REF
>IX dna:chromosome chromosome:R64-1-1:IX:1:439888:1 REF
>X dna:chromosome chromosome:R64-1-1:X:1:745751:1 REF
>XI dna:chromosome chromosome:R64-1-1:XI:1:666816:1 REF
>XII dna:chromosome chromosome:R64-1-1:XII:1:1078177:1 REF
>XIII dna:chromosome chromosome:R64-1-1:XIII:1:924431:1 REF
>XIV dna:chromosome chromosome:R64-1-1:XIV:1:784333:1 REF
>XV dna:chromosome chromosome:R64-1-1:XV:1:1091291:1 REF
>XVI dna:chromosome chromosome:R64-1-1:XVI:1:948066:1 REF
>Mito dna:chromosome chromosome:R64-1-1:Mito:1:85779:1 REF
```

For thoroughness, let's go ahead and get `README` and `CHECKSUMS` files for everything else we've downloaded from Ensembl in the last couple of days:
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/sacCer3/Ensembl/108"
alias .,s="ls -lhaFG ./*"
.,s
```

Results:
```txt
./cDNA:
total 12M
drwxrwx--- 2 kalavatt  178 Oct 25 17:12 ./
drwxrwx--- 5 kalavatt   64 Oct 26 13:44 ../
-rw-rw---- 1 kalavatt   79 Sep  2 07:04 CHECKSUMS
-rw-rw---- 1 kalavatt 2.5K Jul 25 10:21 README
-rw-rw---- 1 kalavatt  12M Oct 25 17:12 Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa
-rw-rw---- 1 kalavatt 3.7M Jul 25 10:21 Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz

./DNA:
total 4.6M
drwxrwx--- 2 kalavatt  120 Oct 26 13:46 ./
drwxrwx--- 5 kalavatt   64 Oct 26 13:44 ../
-rw-rw---- 1 kalavatt 3.8K Oct 26 13:46 CHECKSUMS
-rw-rw---- 1 kalavatt 4.9K Oct 26 13:46 README
-rw-rw---- 1 kalavatt 3.7M Oct 26 13:46 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz

./gtf:
total 14M
drwxrwx--- 2 kalavatt  240 Oct 25 17:12 ./
drwxrwx--- 5 kalavatt   64 Oct 26 13:44 ../
-rw-rw---- 1 kalavatt  140 Aug 11 14:07 CHECKSUMS
-rw-rw---- 1 kalavatt 9.2K Jul 29 08:56 README
-rw-rw---- 1 kalavatt  116 Jul 29 08:56 Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gtf.gz
-rw-rw---- 1 kalavatt  10M Oct 25 17:12 Saccharomyces_cerevisiae.R64-1-1.108.gtf
-rw-rw---- 1 kalavatt 582K Jul 29 08:56 Saccharomyces_cerevisiae.R64-1-1.108.gtf.gz
```
Looks like I already did. Nice.

<a id="4-now-get-the-genome-fasta-for-k-lactis"></a>
### 4. Now, get the genome `fasta` for *K. lactis*
...from what appears to be a special version of Ensembl for fungi, e.g., [here](https://fungi.ensembl.org) and a specific page for [*K. lactis*](https://fungi.ensembl.org/Kluyveromyces_lactis_gca_000002515/Info/Index)

Click the link ["Download DNA sequence"](http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/). Site contents:
```txt
[ICO]    Name    Last modified    Size    Description
[PARENTDIR]    Parent Directory         -     
CHECKSUMS    2022-09-21 11:02    1.7K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.A.fa.gz    2022-08-16 05:28    324K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.B.fa.gz    2022-08-16 05:28    403K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.C.fa.gz    2022-08-16 05:28    535K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.D.fa.gz    2022-08-16 05:28    520K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.E.fa.gz    2022-08-16 05:28    681K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.F.fa.gz    2022-08-16 05:28    793K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz    2022-08-16 05:28    3.2M     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.A.fa.gz    2022-08-16 05:28    323K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.B.fa.gz    2022-08-16 05:28    402K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.C.fa.gz    2022-08-16 05:28    534K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.D.fa.gz    2022-08-16 05:28    520K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.E.fa.gz    2022-08-16 05:28    680K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.F.fa.gz    2022-08-16 05:28    793K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.toplevel.fa.gz    2022-08-16 05:28    3.2M     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.A.fa.gz    2022-08-16 05:28    324K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.B.fa.gz    2022-08-16 05:28    403K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.C.fa.gz    2022-08-16 05:29    535K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.D.fa.gz    2022-08-16 05:29    521K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.E.fa.gz    2022-08-16 05:29    682K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.F.fa.gz    2022-08-16 05:29    794K     
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.toplevel.fa.gz    2022-08-16 05:29    3.2M     
README
```
Cool. Looks like we need `Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz`, `README`, and `CHECKSUMS`:
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/" || echo "cd failed. Check on this."
mkdir -p kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA && cd kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA

curl \
    http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz \
    > Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz

curl \
    http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/README \
    > README

curl \
    http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/CHECKSUMS \
    > CHECKSUMS

#  Grab some other files too: transcripts and annotations
cd ..
mkdir -p {cDNA,gff3}
cd cDNA || echo "cd failed. Check on this."

#  Getting errors: "curl: (51) SSL: no alternative certificate subject name
#+ matches target host name 'ftp.ensemblgenomes.org'"; try running curl in
#+ "--insecure" option
curl \
    --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/cdna/Kluyveromyces_lactis_gca_000002515.ASM251v1.cdna.all.fa.gz \
    > Kluyveromyces_lactis_gca_000002515.ASM251v1.cdna.all.fa.gz

curl \
    --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/cdna/CHECKSUMS \
    > CHECKSUMS

curl \
    --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/cdna/README \
    > README

cd ../gff3 || echo "cd failed. Check on this."

curl \
    --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/gff3/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz \
    > Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz

curl \
    --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/gff3/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/README \
    > README

curl \
    --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/gff3/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/CHECKSUMS \
    > CHECKSUMS

#  Let's see what the chromosomes look like in the K. lactis fasta
cd ../DNA || echo "cd failed. Check on this."

fasta="Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz"
zgrep "^>" "${fasta}"
```

Results for chromosome names in `Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz`:
```txt
>A dna:chromosome chromosome:ASM251v1:A:1:1062590:1 REF
>B dna:chromosome chromosome:ASM251v1:B:1:1320834:1 REF
>C dna:chromosome chromosome:ASM251v1:C:1:1753957:1 REF
>D dna:chromosome chromosome:ASM251v1:D:1:1715506:1 REF
>E dna:chromosome chromosome:ASM251v1:E:1:2234072:1 REF
>F dna:chromosome chromosome:ASM251v1:F:1:2602197:1 REF
```

And what is the "chromosome name" for the 20 S narnavirus?
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/20S_RNA_Narnavirus_1997_NC004051/" || echo "cd failed. Check on this."

fasta="20S_RNA_Narnavirus_1997_NC004051.fasta"
zgrep "^>" "${fasta}"
```

`#NOTE They look fine; not pasted here`

<a id="5-clean-up-the-headers-for-the-20s-narnavirus-s-cerevisisae-and-k-lactis"></a>
### 5. Clean up the headers for the 20S narnavirus, *S. cerevisisae*, and *K. lactis*
Results for `20S_RNA_Narnavirus_1997_NC004051.fasta`
```txt
>gi|21557564|ref|NC_004051.1| Saccharomyces 20S RNA narnavirus, complete genome
```

Try renaming the "chromosome name" for the 20 S narnavirus
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/20S_RNA_Narnavirus_1997_NC004051/"

fasta="20S_RNA_Narnavirus_1997_NC004051.fasta"
awk '/^>/ {$0=$1} 1' "${fasta}" > "${fasta%.fasta}.chr-rename.fasta"
```

It works, but let's give the header a more informative string:
```bash
#!/bin/bash
#DONTRUN

fasta="20S_RNA_Narnavirus_1997_NC004051.chr-rename.fasta"
cp "${fasta}" "${fasta}.bak"

change_to=">20S"
sed -i "1s/.*/${change_to}/" "${fasta}"

head -5 "${fasta}"
```

Results for `20S_RNA_Narnavirus_1997_NC004051.chr-rename.fasta`
```txt
>20S
GGGGCTGATCCCATGAAGGAACCAGTAGACTGCCGTCTTTCGACGCCAGCCGGTTTCTCGGGGACAGTCC
CCCCTCCTGGTCGCACTAAGGCGGCCAGGCCGGGAACCATCCCTGTGAGGCGTTCGCGTGGAAGCGCGTC
TGCCTTACCGGGTAAAATCTACGGTTGGAGCCGTCGACAACGGGATAGGTTCGCGATGTTGCTGTCGTCT
TTCGACGCGGCTCTCGCGGCCTACTCCGGCGTCGTCGTCTCCAGAGGTACACGCTCTCTACCGCCATCGC
```

Change the chromosome names (headers) for *S. cerevisiae* and *K.lactis* by removing everything after (and including) the first space
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/sacCer3/Ensembl/108/DNA" || echo "cd failed. Check on this."

fasta="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz"
gunzip < "${fasta}" > "${fasta%.gz}"
awk '/^>/ {$0=$1} 1' "${fasta%.gz}" > "${fasta%.fa.gz}.chr-rename.fasta"
rm "${fasta%.gz}"
zgrep "^>" "${fasta%.fa.gz}.chr-rename.fasta"
```

Results for `Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta`:
```txt
>I
>II
>III
>IV
>V
>VI
>VII
>VIII
>IX
>X
>XI
>XII
>XIII
>XIV
>XV
>XVI
>Mito
```

```bash
#!/bin/bash
#DONTRUN

#  K. lactis
cd "${HOME}/genomes/kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA" || echo "cd failed. Check on this."

fasta="Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz"
gunzip < "${fasta}" > "${fasta%.gz}"
awk '/^>/ {$0=$1} 1' "${fasta%.gz}" > "${fasta%.fa.gz}.chr-rename.fasta"
rm "${fasta%.gz}"
zgrep "^>" "${fasta%.fa.gz}.chr-rename.fasta"
```

Results for `Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.chr-rename.fasta`:
```txt
>A
>B
>C
>D
>E
>F
```
<br />
<br />

<a id="concatenate-the-s-cerevisiae-k-lactis-and-s20-genomes"></a>
## [Concatenate the *S. cerevisiae*, *K. lactis*, and *S20* genomes](#concatenate-the-s-cerevisiae-k-lactis-and-s20-genomes)
...creating a combined genome for RNA-seq and related analyses
```bash
#!/bin/bash
#DONTRUN

#  Make a directory for the combined genome
cd "${HOME}/genomes" || echo "cd failed. Check on this."
mkdir -p combined_SC_KL_20S  # For S. cerevisiae, K. lactis, and the 20 S narnavirus

fasta_SC="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
fasta_KL="Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.chr-rename.fasta"
fasta_20S="20S_RNA_Narnavirus_1997_NC004051.chr-rename.fasta"
fasta_comb="combined_SC_KL_20S.fasta"

cp \
    "${HOME}/genomes/sacCer3/Ensembl/108/DNA/${fasta_SC}" \
    combined_SC_KL_20S/
\

cp \
    "${HOME}/genomes/kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA/${fasta_KL}" \
    combined_SC_KL_20S/

cp \
    "${HOME}/genomes/20S_RNA_Narnavirus_1997_NC004051/${fasta_20S}" \
    combined_SC_KL_20S/

cat "${fasta_SC}" "${fasta_KL}" "${fasta_20S}" > "${fasta_comb}"
zgrep ">" "${fasta_comb}"
```

<a id="chromosome-contents-of-combined_sc_kl_20sfasta"></a>
### Chromosome contents of `combined_SC_KL_20S.fasta`:
```txt
>I
>II
>III
>IV
>V
>VI
>VII
>VIII
>IX
>X
>XI
>XII
>XIII
>XIV
>XV
>XVI
>Mito
>A
>B
>C
>D
>E
>F
>20S
```
Great, this is what we want.

<a id="create-bowtie-2-indices"></a>
### [Create `Bowtie 2` indices](#create-bowtie-2-indices)
...for `combined_SC_KL_20S`
```bash
#!/bin/bash
#DONTRUN

#  Make a directory for the combined genome
cd "${HOME}/genomes/combined_SC_KL_20S" || echo "cd failed. Check on this."
mkdir -p fasta_individual  # For S. cerevisiae, K. lactis, and the 20 S narnavirus

mv "${fasta_SC}" "${fasta_KL}" "${fasta_20S}" fasta_individual/

#  Index the fasta file
ml SAMtools/1.16.1-GCC-11.2.0 Bowtie2/2.4.4-GCC-11.2.0
samtools faidx "${fasta_comb}"

#  Create a Bowtie2 index (e.g., metagenomics.wiki/tools/bowtie2/index)
mkdir -p Bowtie2 
bowtie2-build combined_SC_KL_20S.fasta Bowtie2/combined_SC_KL_20S \
    1> combined_SC_KL_20S.bowtie2-build.stdout.txt

cd Bowtie2 || echo "cd failed. Check on this."
bowtie2-inspect --names combined_SC_KL_20S  # It looks correct
cd ..

#  Clean up a bit
mkdir -p {txt,fasta}
mv *fasta* fasta/
mv *.txt txt/
```
<br />
<br />

<a id="2022-1027-1028"></a>
# 2022-1027-1028
<a id="continued-work-with-how_are_we_stranded_here"></a>
## Continued work with `how_are_we_stranded_here`
Move `how_are_we_stranded_here` output to a distinct directory, `how_are_we_stranded_here`, in `"${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025"`
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025"

mkdir -p how_are_we_stranded_here
mv \
    kallisto_index \
    stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/ \
    how_are_we_stranded_here/
```
<br />
<br />

<a id="items-to-work-through-todo"></a>
## Items to work through `#TODO`
`#TODO (...)` Edit the `Bowtie2` alignment script from Alison in order to align an RNA-seq `fasta` file to the combined reference genome
`#TODO ( Y )` Figure out what to do regarding PCR duplicates and UMIs/demultiplexing; copy in and reflect on the recent, related e-mail chains from Alison
`#TODO ( Y )` Downsample fastq files

<a id="downsampling-fastq-files"></a>
### Downsampling `fastq` files
Downsample `fastq` files in order to run quick tests that don't need many threads:
```bash
#!/bin/bash
#DONTRUN

#  First, download BBMap (latest version) from SourceForge; BBMap provides a
#+ quick and easy to do this sort of random downsampling
cd ~  # Do the following work in "${HOME}"
curl \
    -L https://sourceforge.net/projects/bbmap/files/BBMap_39.01.tar.gz/download \
    > BBMap_39.01.tar.gz

tar -xvf BBMap_39.01.tar.gz  # Unpack the tar.gz file
#  Unpacked directory in "${HOME}" now: It's in a directory simply called
#+ "bbmap" (with the decompression, a bunch of info on files in the tar were
#+ printed to screen)

#  Get BBMap into "${PATH}" by adding this to the end of .bashrc:
#+ export PATH="${PATH}:${HOME}/bbmap"

#  Go ahead and remove the *.tar.gz file
rm BBMap_39.01.tar.gz

#  Use your bespoke script, 'downsample-fastqs.sh', which makes use of BBMap
#+ 'reformat.sh', to downsample fastq files
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction"

#  Sample down to 50,000 reads per file
#+ Also, need to install Java and/or at least have it loaded as a module
ml Java/15.0.1

#  Make a directory to store the downsampled fastq files
mkdir -p "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq"

/bin/bash ./bin/downsample-fastqs.sh \
    "${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq" \
    "${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq" \
    "50k" \
    "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq"
#  Without loading Java, command exits with error code 127:
#+ /home/kalavatt/bbmap/reformat.sh: line 230: java: command not found
```

Printed to screen with the call to `downsample-fastqs.sh`:
```txt
java -ea -Xms300m -cp /home/kalavatt/bbmap/current/ jgi.ReformatReads in1=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq in2=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq out1=/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq/5781_G1_IN_merged_R1.50k.fastq out2=/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq/5781_G1_IN_merged_R2.50k.fastq samplereadstarget=50k
Executing jgi.ReformatReads [in1=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq, in2=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq, out1=/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq/5781_G1_IN_merged_R1.50k.fastq, out2=/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq/5781_G1_IN_merged_R2.50k.fastq, samplereadstarget=50k]

Set INTERLEAVED to false
Input is being processed as paired
Input:                      27977684 reads              1398884200 bases
Output:                     100000 reads (0.36%)     5000000 bases (0.36%)

Time:                             25.654 seconds.
Reads Processed:      27977k     1090.58k reads/sec
Bases Processed:       1398m     54.53m bases/sec
```

<a id="stepping-through-each-line"></a>
### Stepping through each line
...of the `Bowtie2` alignment and processing script from Alison G. (derived from `New_101122_sc_bowtie_4tu.sh`)

```bash
#!/bin/bash
#DONTRUN

grabnode  # Default settings

cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025"
alias .,="ls -lhaFG"


#  1: "Configuration variables"
wrap=""
rundir="$(pwd)"

echo "${wrap}"
echo "${rundir}"


#  1 (cont.)
threads="${1:-"1"}"  # Normally, 16
load_module_cmd="module load"
load_modules="Bowtie2/2.4.4-GCC-11.2.0 SAMtools/1.16.1-GCC-11.2.0 deepTools/3.5.1-foss-2021b"
reference_genome="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"
split_reads="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/bin/split_bam_fwd_rev.sh"

echo "${threads}"
echo "${load_module_cmd}"
echo "${load_modules}"
echo "${reference_genome}"
echo "${split_reads}"

., "${reference_genome}"*
., "${split_reads}"


#  1 (cont.)
sample_directory="${2:-"${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/fastq"}"
sample_root="${3:-"5781_G1_IN_merged"}"

echo "${sample_directory}"
echo "${sample_root}"

., "${sample_directory}"
., "${sample_directory}/${sample_root}"*


#  1 (cont.)
expected_results="*sorted.bam *sorted.bam.bai"
expected_results_2=".bw"
output_directory="${rundir}/bam"
output_directory_2="${rundir}/bw"
cleanup_files=""
cleanup_command="echo Cleaning up files matching ${cleanup_files}"
reprocess="manual"

echo "${expected_results}"
echo "${expected_results_2}"
echo "${output_directory}"
echo "${output_directory_2}"
echo "${cleanup_files}"
echo "${cleanup_command}"
echo "${reprocess}"


#  2: "Identify samples"
samples=""
params="$@"

echo "${samples}"
echo "${params}"


#  3: "Process samples"
wrap="log eval "
log() { echo "\$ ${@/eval/}" 2>&1 | tee -a ${sample_log}; "$@" 2>&1 | tee -a ${sample_log}; }
logcd() { echo "\$ cd ${@/eval/}" 2>&1 | tee -a ${sample_log}; cd "$@" 2>&1 | tee -a ${sample_log}; }  #NOTE #KA Function does not appear to be used (2022-1027)
logNoExec() { echo "\$ ${@/eval/}" 2>&1 | tee -a ${sample_log}; }
logNoEcho() { "$@" 2>&1 | tee -a ${sample_log}; }

echo "Preparing environment to process samples: "
echo ${samples}
#TODO prompt to continue
#echo "Continue?"

# Load required python modules.
for pymodule in ${load_modules}; do
    echo "Loading module ${pymodule}..."
    ${load_module_cmd} ${pymodule}
    echo "...done."
done
#KA It works
#KA Try the for loop with quoted variables: It breaks; leave as is


#  4
# Create the output directory and any needed parent directories.
[[ -d "${output_directory}" ]] ||
    {
        echo "${output_directory} does not exist; mkdir'ing it..."
        mkdir -p "${output_directory}"
    }
#  mkdir: created directory '/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/bam'

#  Locate the infiles
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "${sample_directory}" \
        -maxdepth 1 \
        -type f \
        -name "${sample_root}"* \
        -print0 \
            | sort -z \
)
for i in "${infiles[@]}"; do echo "${i}"; done  # Check; can comment out later
echo ""

#  Only two fastq files should be found; if less or more, then exit with a
#+ warning message
if [[ "${#infiles[@]}" -eq 0 ]]; then
    echo "Exiting: Zero fastq files were found..." && exit 1
elif [[ "${#infiles[@]}" -lt 2 ]]; then
    echo "Exiting: Only one fastq file was found..." && exit 1
elif [[ "${#infiles[@]}" -gt 2 ]]; then
    echo "Exiting: More than two fastq files were found..." && exit 1
elif [[ "${#infiles[@]}" -eq 2 ]]; then
    :
fi
#  So far, it works; let's keep stepping


#  5
logNoExec "==========================="
logNoEcho date
logNoExec "Processing ${sample_name}"

echo "$wrap"
echo "${threads}"
echo "${reference_genome}"
echo "${infiles[0]}"
echo "${infiles[1]}"


# ${wrap} bowtie2 \
#     -p "${threads}" \
#     -x "${reference_genome}" \
#     -1 "${infiles[0]}" \
#     -2 "${infiles[1]}" \
#     --trim5 1 \
#     --local \
#     --very-sensitive-local \
#     --no-unal \
#     --no-mixed \
#     --no-discordant \
#     --phred33 \
#     -I 10 \
#     -X 700 \
#     --no-overlap \
#     --no-dovetail \
#         | samtools sort -@ "${threads}" -o "${infiles[0]%_R1.fastq}_sorted.bam" -
#NOTE 1/2 In order for the pipe operation to work, the call to ${wrap} needs to
#NOTE 2/2 be removed

#  For example, it should be called like this:
bowtie2 \
    -p "${threads}" \
    -x "${reference_genome}" \
    -1 "${infiles[0]}" \
    -2 "${infiles[1]}" \
    --trim5 1 \
    --local \
    --very-sensitive-local \
    --no-unal \
    --no-mixed \
    --no-discordant \
    --phred33 \
    -I 10 \
    -X 700 \
    --no-overlap \
    --no-dovetail \
        | samtools sort -@ "${threads}" -o "${infiles[0]%_R1.fastq}_sorted.bam" -
#  Meaning of Bowtie2 parameters:
#+ -p: threads
#+ -x: Bowtie2 indices, including path and root
#+ -1: Read #1 of paired-end reads
#+ -2: Read #2 of paired-end reads
#+ --trim5: trim <int> bases from 5'/left end of reads
#+ --local: local alignment; ends might be soft clipped (off)
#+ --very-sensitive-local: -D 20 -R 3 -N 0 -L 20 -i S,1,0.50
#+     -D: give up extending after <int> failed extends in a row (15)
#+     -R: for reads w/ repetitive seeds, try <int> sets of seeds (2)
#+     -N: max # mismatches in seed alignment; can be 0 or 1 (0)
#+     -L: length of seed substrings; must be >3, <32 (22)
#+     -i: interval between seed substrings w/r/t read len (S,1,1.15)
#+ --no-unal: suppress SAM records for unaligned reads
#+ --no-mixed: suppress unpaired alignments for paired reads
#+ --no-discordant: suppress discordant alignments for paired reads
#+    From biostars.org/p/78446/, a discordant alignment is an alignment where
#+    both mates align uniquely, but that does not satisfy the paired-end
#+    constraints (--fr/--rf/--ff, -I, -X).
#+ --phred33: qualities are Phred+33 (default)
#+ -I: minimum fragment length (0)
#+ -X: maximum fragment length (500)
#+ --no-overlap: not concordant when mates overlap at all
#+ --no-dovetail: NA

#QUESTION Will piping to threaded samtools sort work?
#ANSWER 1/2 It seems so: github.com/samtools/samtools/issues/891
#ANSWER 2/2 (Relevant text pasted below)
```

<a id="will-piping-to-threaded-samtools-sort-work"></a>
#### [Will piping to threaded `samtools sort` work?](#will-piping-to-threaded-samtools-sort-work)
<a id="samtools-sort-number-of-threads-in-reading-phase-891"></a>
##### [`samtools sort` number of threads in reading phase #891](https://github.com/samtools/samtools/issues/891)
<a id="bernt-matthias-commented-on-jul-11-2018"></a>
###### `bernt-matthias` commented on Jul 11, 2018
**Is your feature request related to a problem? Please specify.**
1. When using `mapper | samtools sort -`, it is difficult to specify the number of threads for the mapper and for samtools.
2. Until all data is read entirely, `samtools` seldomly uses the available CPUs efficiently (CPU usage is seldomly larger than 100%).

**Describe the solution you would like.**
I suggest to allow to specify the number of CPUs used by samtools during reading the data (and producing pre-sorted chunks) separately. This would simplify the specification of the number of threads used by both programs. Until the mapper is finished, `samtools` could, for instance, use a single thread for reading and chunking and then use the full number of threads afterwards (when the mapper has finished). Thereby
- the CPU usage could be better limited (in shared environments you need to specify the number of cores and sometimes admins really check)
- the currently suboptimal performance of `samtools sort` during reading would be nicely hidden.
- I guess the single thread for the first phase could nicely fill the missing CPU utilization of the mapper.

<a id="jkbonfield-commented-on-jul-11-2018"></a>
###### `jkbonfield` commented on Jul 11, 2018
`sort` could certainly be more efficient. Ideally, it would be using asynchronous I/O too.

However, this particular problem is perhaps one of expectation. Over-specifying the number of threads is not a catastrophically bad thing to do, and you can use `cgroups` or `hwloc-bind` to govern how many cores the entire process can take up too.

Also, I don't think it's true to say that `samtools sort` only uses more than one CPU until the mapper has finished. It uses one thread until it's read enough data and then it uses multiple threads to sort and write that temporary data to disk, repeatedly. On finishing (no more `stdin`), it then has a separate merge stage. If your mapper is the slow part, then "yes", `samtools` will likely be stuck at under 100% CPU, but that's not really a `samtools` issue I think.

Note there is more or less a way to handle what you want already (untested, but I think it's equivalent), e.g.:

`mapper | samtools sort -l 0 -O bam -@2 | samtools view -O bam -@16 -o out.bam`

The second merge stage only starts when the mapper has finished, and this will be I/O bound and won't be threading on output as there are no lengthy `bgzf` compression steps. The `samtools view` command will only start consuming CPU after the mapper has finished, so both mapper and view can be given the same cores to work on.

Finally maybe you'll get more luck using `mapper | mbuffer | samtools` too with some systems and/or aligners. This can avoid issues with small pipe sizes.

<a id="bernt-matthias-commented-on-jul-11-2018-1"></a>
###### `bernt-matthias` commented on Jul 11, 2018
Thanks for the info and suggestions.

```txt
On finishing (no more `stdin`) it then has a separate merge stage. If your mapper is the slow part, then "yes", `samtools` will likely be stuck at under 100% CPU, but that's not really a `samtools` issue I think.
```

Actually (in my case the mapper is `hisat2`), CPU usage is most of the time approx 100% and then spikes for a short time to approximately `x`\*100%, where `x` ist the number of threads given to `samtools`. But this time is really short.

```txt
 Note there is more or less a way to handle what you want already (untested, but I think it's equivalent), e.g.:

`mapper | samtools sort -l 0 -O bam -@2 | samtools view -O bam -@16 -o out.bam`

The second merge stage only starts when the mapper has finished, and this will be I/O bound and won't be threading on output as there are no lengthy `bgzf` compression steps. The `samtools view` command will only start consuming CPU after the mapper has finished, so both mapper and view can be given the same cores to work on.
```

Sounds like a cool idea. The result should be equivalent.

Efficiency depends a bit on how sort merges the temporary files. If it is done in a tree-like fashion, then it would start to write output on the top level of the merge tree. But if all temporary files are merged at once, then it would start writing output immediately (which would start `view` earlier). For the suggested solution the latter would be better, I guess.

<a id="jkbonfield-commented-on-jul-11-2018-1"></a>
###### `jkbonfield` commented on Jul 11, 2018
Sadly, `sort` is pretty noddy. It simply reads until hitting the memory limit, sorts, writes to temporary file, repeats. At the end, it then opens *ALL* files and merges. This isn't particularly efficient and can cause major I/O bottlenecks and/or running out of file descriptors if you've set the memory limit too low.

It can perhaps be sped up by adjusting the block size to be larger than the file system hints at (`fstat`) via the `--input-fmt-option block_size=10000000` option, for example. This would use more memory (but probably still less than you used for sorting), but will perhaps thrash the system less.

<a id="my-thoughts-2022-1028"></a>
###### My thoughts, 2022-1028
I am not so sure about the `mapper | mbuffer | samtools` and `--input-fmt-option block_size=10000000` approaches mentioned above...

Let's move forward with the `mapper | samtools sort -l 0 -O bam -@2 | samtools view -O bam -@16 -o out.bam` approach discussed above. If I understand things correctly, this will get uncompressed sorting started and cap it at a maximum of two threads, which I have decided to subtract from the number supplied to `bowtie2` to prevent overthreading; e.g., of 16 threads total, 14 are assigned to `bowtie2` and two are assigned to `samtools sort`. Then, the final compressed merge via `samtools view` will not begin until mapping with `bowtie2` is completed.

The call to `bowtie2` and `samtools` will look like this:
```bash
#!/bin/bash
#DONTRUN

threads=16

#  superuser.com/questions/49765/how-to-make-a-statement-that-checks-if-something-is-divisible-by-something-else
#  stackoverflow.com/questions/8356698/how-to-remove-decimal-from-a-variable
if [[ "${threads}" -gt 1 ]] && (( "${threads}" % 4 == 0 )); then  #TODO More robust if/then logic here
    #  Call Bowtie2 in this manner if we've assigned a number of threads
    #+ divisible by 4
    threads_bowtie2_float="$(echo "${threads}"*0.875 | bc)"
    threads_sort_float="$(echo "${threads}"*0.125 | bc)"
    threads_bowtie2="$(printf %.0f "${threads_bowtie2}")"
    threads_sort="$(printf %.0f "${threads_sort}")"

    bowtie2 \
        -p "${threads_bowtie2}" \
        -x "${reference_genome}" \
        -1 "${infiles[0]}" \
        -2 "${infiles[1]}" \
        --trim5 1 \
        --local \
        --very-sensitive-local \
        --no-unal \
        --no-mixed \
        --no-discordant \
        --phred33 \
        -I 10 \
        -X 700 \
        --no-overlap \
        --no-dovetail \
            | samtools sort -@ "${threads_sort}" -l 0 -O "bam" \
            | samtools view -@ "${threads}" -0 bam "${infiles[0]%_R1.fastq}.bam"
else
    echo "Threads is not greater than 1 and/or not divisible by 4"
fi
```

<a id="stepping-through-each-line-1"></a>
### Stepping through each line
...of the `Bowtie2` alignment and processing script, which is now `align_process_fastqs.sh`

Have added explicit arguments to the script `align_process_fastqs.sh`; let's carefully step through and test the things that have been drafted thus far...
```bash
#!/bin/bash
#DONTRUN

grabnode  # If not already on gizmo

#  Source functions -----------------------------------------------------------
check_dependency() {
    # Check if program is available in "${PATH}"; exit if not
    # 
    # :param 1: program/package <chr>
    command -v "${1}" &>/dev/null ||
        {
            echo "Exiting: ${1} not found. Install ${1}."
            # exit 1
        }
}


check_exit() {
    # Check the exit code of a child process
    # 
    # :param 1: exit code <int >= 0>
    # :param 2: program/package <chr>
    if [[ "${1}" == "0" ]]; then
        echo "${2} completed: $(date)"
    else
        err "#ERROR: ${2} returned exit code ${1}"
    fi
}


err() {
    # Print an error meassage, then exit with code 1
    # 
    # :param 1: program/package <chr>
    echo "${1} exited unexpectedly"
    # exit 1
}


print_usage() {
    # Print the help message and exit
    echo "${help}"
    # exit 1
}


#  Handle arguments, assign variables -----------------------------------------
help="""
Take user-input .bam files and split them into distinct .bam files for the
forward and reverse strands, saving the split .bam files to a user-defined out
directory.

Dependencies:
  - samtools >= 1.9

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <logical; default: FALSE>
  -i  infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -t  number of threads <int >= 1>
  -c  remove bams for flags 147, 99, 83, and 163: \"TRUE\" or \"FALSE\" <logical; default: TRUE>
"""

while getopts "h:u:i:o:t:c:" opt; do
	case "${opt}" in
		h) echo "${help}" && exit ;;
		u) safe_mode="${OPTARG}" ;;
		i) infile="${OPTARG}" ;;
		o) outdir="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        c) clean_up="${OPTARG}" ;;
		*) print_usage ;;
	esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${threads}" ]] && threads=16
[[ -z "${clean_up}" ]] && clean_up=TRUE

#  Assignments for tests
safe_mode=FALSE
infile="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam/5781_G1_IN_merged.bam"
outdir="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam"
threads=1
clean_up=TRUE

echo "${safe_mode}"
echo "${infile}"
echo "${outdir}"
echo "${threads}"
echo "${clean_up}"

ls -lhaFG "${infile}"
ls -lhaFG "${outdir}"


#  Check variable assignments and dependencies --------------------------------
echo ""
echo "Running ${0}... "

#  Evaluate "${safe_mode}"
case "$(echo "${safe_mode}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-u: \"Safe mode\" is TRUE.\n" && set -Eeuxo pipefail ;;
    false | f) \
        echo -e "-u: \"Safe mode\" is FALSE.\n" ;;
    *) \
        echo -e "Exiting: -u \"safe mode\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

#  Check that "${infile}" exists
[[ -f "${infile}" ]] ||
    {
        echo -e "Exiting: -i ${infile} does not exist.\n"
        # exit 1
    }

#  Make "${outdir}" if it doesn't exist
[[ -d "${outdir}" ]] ||
    {
        echo -e "-o: Directory ${outdir} does not exist; making the directory.\n"
        mkdir -p "${outdir}"
    }

#  Evaluate "${clean_up}"
case "$(echo "${clean_up}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-c: \"Clean up\" is TRUE.\n" ;;
    false | f) \
        echo -e "-c: \"Clean up\" is FALSE.\n" ;;
    *) \
        echo -e "Exiting: -c \"clean up\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

echo ""

#  Check for necessary dependencies; exit if not found
module="SAMtools/1.16.1-GCC-11.2.0"
ml "${module}"
check_dependency samtools


#  Make additional variable assignments from the arguments --------------------
base="$(basename "${infile}")"
name="${base%.*}"
forward_1="${outdir}/${name}.fwd_99.bam"
forward_2="${outdir}/${name}.fwd_147.bam"
forward="${outdir}/${name}.fwd.bam"
reverse_1="${outdir}/${name}.rev_83.bam"
reverse_2="${outdir}/${name}.rev_163.bam"
reverse="${outdir}/${name}.rev.bam"

echo "${base}"
echo "${name}"
echo "${forward_1}"
echo "${forward_2}"
echo "${forward}"
echo "${reverse_1}"
echo "${reverse_2}"
echo "${reverse}"


#  Forward strand ---------------------
#+
#+ 1. Alignments of the second in pair if they map to the forward strand
#+ 2. Alignments of the first in pair if they map to the reverse strand

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x20 - partner on reverse strand
#+ 0x40 - read one
#+ FLAGs 0x1 + 0x2 + 0x20 + 0x40 = 0x63 = 99 in decimal
samtools view -@ "${threads}" -bh -f 99 "${infile}" -o "${forward_1}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${forward_1}"
check_exit $? "samtools"

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x10 - on reverse strand
#+ 0x80 - read two
#+ FLAGs 0x1 + 0x2 + 0x10 + 0x80 = 0x93 = 147 in decimal
samtools view -@ "${threads}" -bh -f 147 "${infile}" -o "${forward_2}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${forward_2}"
check_exit $? "samtools"

#  Combine alignments that originate on the forward strand
samtools merge -@ "${threads}" -f "${forward_1}" "${forward_2}" -o "${forward}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${forward}"
check_exit $? "samtools"


#  Reverse strand ---------------------
#+
#+ 1. Alignments of the second in pair if they map to the reverse strand
#+ 2. Alignments of the first in pair if they map to the forward strand

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x10 - reverse strand
#+ 0x40 - read one
#+ FLAGs 0x1 + 0x2 + 0x10 + 0x40 = 0x53 = 83 in decimal
samtools view -@ "${threads}" -bh -f 83 "${infile}" -o "${reverse_1}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${reverse_1}"
check_exit $? "samtools"

#  0x1 - paired
#+ 0x2 - properly paired
#+ 0x30 - partner on reverse strand
#+ 0x80 - read two
#+ FLAGs 0x1 + 0x2 + 0x20 + 0x80 = 0xA3 = 163 in decimal
samtools view -@ "${threads}" -bh -f 163 "${infile}" -o "${reverse_2}"
check_exit $? "samtools"

samtools index -@ "${threads}" "${reverse_2}"
check_exit $? "samtools"

#  Combine alignments that originate on the reverse strand
samtools merge -@ "${threads}" -f "${reverse_1}" "${reverse_2}" -o "${reverse}"
check_exit $? "samtools"

samtools index "${reverse}"
check_exit $? "samtools"


#  Clean up -------------------------------------------------------------------
if \
    [[ "$(echo "${clean_up}" | tr '[:upper:]' '[:lower:]')" == "true" ]] || \
    [[ "$(echo "${clean_up}" | tr '[:upper:]' '[:lower:]')" == "t" ]]; then
        rm \
        	"${forward_1}" \
        	"${forward_2}" \
        	"${reverse_1}" \
        	"${reverse_2}"
        rm \
        	"${forward_1}.bai" \
        	"${forward_2}.bai" \
        	"${reverse_1}.bai" \
        	"${reverse_2}.bai"
fi
```

<a id="stepping-through-split_bam_by_speciessh"></a>
#### Stepping through `split_bam_by_species.sh`
Great, it works. Now, write up code, to be kept in a separate script, for filtering the `bam` files by *S. cerevisiae*, *K. lactis*, and 20 S narnavirus.
```bash
#!/bin/bash
#DONTRUN

bam="5781_G1_IN_merged.bam"
samtools idxstats "${bam}" | cut -f 1
# I
# II
# III
# IV
# V
# VI
# VII
# VIII
# IX
# X
# XI
# XII
# XIII
# XIV
# XV
# XVI
# Mito
# A
# B
# C
# D
# E
# F
# 20S
# *

samtools view -h "${bam}" | tail -5
# HISEQ:1007:HGV5NBCX3:1:2111:1451:67691	147	20S	2037	44	49M	=	1861	-225	CGACTATAAGGTCACCCGGCCGGGTAAGATGTACCCGGACCGTTACGGC	GIIGIGIIGGIIIGIIG<IIGIGGGGIGGAIIIIIIGIGGIIGIIGGGG	AS:i:91	XN:i:0	XM:i:1	XO:i:0	XG:i:0	NM:i:1	MD:Z:36A12	YS:i:90	YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1212:20534:19899	99	20S	2061	44	49M	=	2364	352	TAAGATGTACCCGGACCGTTACGGCTTTCTTGATGGAGAGTCTCTTCGG	GGGGIGIIIIIGIIIGIIIIIGIIGGIIIIIIGIIGIIGGGGGIGGIII	AS:i:90	XN:i:0	XM:i:1	XO:i:0	XG:i:0	NM:i:1	MD:Z:12A36	YS:i:98	YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1113:3051:23043	147	20S	2123	44	49M	=	1874	-298	TGTTGAACTCGGCCGTCTATGAGACTTTTCTCGGACCTGACCCTGACGC	GIGIGGIIIGIGGGGGAGGGGIIIIIIIGGGIGGAGIGIIIIIIIGGGG	AS:i:98	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:49	YS:i:90	YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2109:1871:100283	147	20S	2124	44	49M	=	1761	-412	GTTGAACTCGGCCGTCTATGAGACTTTTCTCGGACCTGACCCTGACGCC	GIGIIIIIGIIIGAGGAIIIGIIIIIGGGGGIGGGGIIIGGGGGIGGGA	AS:i:98	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:49	YS:i:98	YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1212:20534:19899	147	20S	2364	44	49M	=	2061	-352	GTTACTGATGGATGAGAGCGTGTACCAACGTAGATTCCGGCAACTGGTC	GIGGGGGIIIIGGIGGAIIIGGGIIGGAGIGIGIIGGGGIIIIIGGGAG	AS:i:98	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:49	YS:i:90	YT:Z:CP


#  Should I keep or exclude 'Mito' from *S. cerevisiae*? Have reached out to
#+ Alison regarding this and awaiting her feedback
chromosomes_SC="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI"
chromosomes_SC_Mito="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito"
chromosomes_Mito="Mito"
chromosomes_KL="A B C D E F"
chromosome_20S="20S"

echo "${chromosomes_SC}"
echo "${chromosomes_SC_Mito}"
echo "${chromosomes_Mito}"
echo "${chromosomes_KL}"
echo "${chromosome_20S}"

#  For some reason, echoing the variable within the call samtools view does not
#+ work  #TODO Need to understand why
samtools view \
	-@ "${threads}" \
	-h "${bam}" \
	I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
	-o "${bam%.bam}.split_SC.bam"

samtools view \
	-@ "${threads}" \
	-h "${bam}" \
	I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito \
	-o "${bam%.bam}.split_SC_Mito.bam"

samtools view \
	-@ "${threads}" \
	-h "${bam}" \
	Mito \
	-o "${bam%.bam}.split_Mito.bam"

samtools view \
	-@ "${threads}" \
	-h "${bam}" \
	A B C D E F \
	-o "${bam%.bam}.split_KL.bam"

samtools view \
	-@ "${threads}" \
	-h "${bam}" \
	20S \
	-o "${bam%.bam}.split_20S.bam"
```

Stepping through the script for splitting by species/chromosome, `split_bam_by_species.sh`:
```bash
#!/bin/bash
#DONTRUN

#  Source functions -----------------------------------------------------------
check_dependency() {
    # Check if program is available in "${PATH}"; exit if not
    # 
    # :param 1: program/package <chr>
    command -v "${1}" &>/dev/null ||
        {
            echo "Exiting: ${1} not found. Install ${1}."
            # exit 1
        }
}


check_exit() {
    # Check the exit code of a child process
    # 
    # :param 1: exit code <int >= 0>
    # :param 2: program/package <chr>
    if [[ "${1}" == "0" ]]; then
        echo "${2} completed: $(date)"
    else
        err "#ERROR: ${2} returned exit code ${1}"
    fi
}


err() {
    # Print an error meassage, then exit with code 1
    # 
    # :param 1: program/package <chr>
    echo "${1} exited unexpectedly"
    # exit 1
}


print_usage() {
    # Print the help message and exit
    echo "${help}"
    # exit 1
}


#  Handle arguments, assign variables -----------------------------------------
help="""
Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
and 20 S narnavirus, and split them into distinct .bam files for each species,
with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
including chrM, all S. cerevisiae including chrM, and S. cerevisiae chrM only.
The split .bam files are saved to a user-defined out directory.

Dependencies:
  - samtools >= 1.9

Arguments:
  -h  print this help message and exit
  -u  use safe mode: \"TRUE\" or \"FALSE\" <logical; default: FALSE>
  -i  infile, including path <chr>
  -o  outfile directory, including path; if not found, will be mkdir'd <chr>
  -t  number of threads <int >= 1>
"""

while getopts "h:u:i:o:t:" opt; do
    case "${opt}" in
        h) echo "${help}" && exit ;;
        u) safe_mode="${OPTARG}" ;;
        i) infile="${OPTARG}" ;;
        o) outdir="${OPTARG}" ;;
        t) threads="${OPTARG}" ;;
        *) print_usage ;;
    esac
done

[[ -z "${safe_mode}" ]] && safe_mode=FALSE
[[ -z "${infile}" ]] && print_usage
[[ -z "${outdir}" ]] && print_usage
[[ -z "${threads}" ]] && threads=16

#  Assignments for tests
safe_mode=FALSE
infile="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam/5781_G1_IN_merged.bam"
outdir="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025/align_process_fastqs/bam"
threads=1

echo "${safe_mode}"
echo "${infile}"
echo "${outdir}"
echo "${threads}"

ls -lhaFG "${infile}"
ls -lhaFG "${outdir}"


#  Check variable assignments and dependencies --------------------------------
echo ""
echo "Running ${0}... "

#  Evaluate "${safe_mode}"
case "$(echo "${safe_mode}" | tr '[:upper:]' '[:lower:]')" in
    true | t) \
        echo -e "-u: \"Safe mode\" is TRUE.\n" && set -Eeuxo pipefail ;;
    false | f) \
        echo -e "-u: \"Safe mode\" is FALSE.\n" ;;
    *) \
        echo -e "Exiting: -u \"safe mode\" argument must be TRUE or FALSE.\n"
        # exit 1
        ;;
esac

#  Check that "${infile}" exists
[[ -f "${infile}" ]] ||
    {
        echo -e "Exiting: -i ${infile} does not exist.\n"
        # exit 1
    }

#  Make "${outdir}" if it doesn't exist
[[ -d "${outdir}" ]] ||
    {
        echo -e "-o: Directory ${outdir} does not exist; making the directory.\n"
        mkdir -p "${outdir}"
    }

echo ""

#  Check for necessary dependencies; exit if not found
module="SAMtools/1.16.1-GCC-11.2.0"
ml "${module}"
check_dependency samtools


#  Make additional variable assignments from the arguments --------------------
base="$(basename "${infile}")"
name="${base%.*}"
split_SC="${outdir}/${name}.split_SC.bam"
split_SC_Mito="${outdir}/${name}.split_SC_Mito.bam"
split_Mito="${outdir}/${name}.split_Mito.bam"
split_KL="${outdir}/${name}.split_KL.bam"
split_20S="${outdir}/${name}.split_20S.bam"


#  Run samtools to split the bam by species/chromosome ------------------------
samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
	-o "${split_SC}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito \
	-o "${split_SC_Mito}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	Mito \
	-o "${split_Mito}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	A B C D E F \
	-o "${split_KL}"

samtools view \
	-@ "${threads}" \
	-h "${infile}" \
	20S \
	-o "${split_20S}"
```

<a id="miscellaneous-tab-to-remember"></a>
#### Miscellaneous tab to remember
Have this open eventually: https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6
<br />
<br />

<a id="2022-1031"></a>
# 2022-1031
<a id="note"></a>
## `#NOTE`
- Spent much of the morning updating MacOS, and fine-tuning the `brew` installation and the ARM- and M1-installation of `conda` (`mambaforge`); also, organized files and began to reacquaint myself with the TPM-calculation work from early September (prior to starting this job)
- Spent much of the late morning and afternoon working with Alison's script, `Analysis_sense_antisense.Rmd`, running it line by line and adjusting it to have proper paths
    - Made a few small code changes, especially in response to questions and issues raised by Alison
    - Made many formatting changes such as adding namespaces, indenting and adding new lines, etc.
- Spent the late afternoon reacquainting myself with the TPM-calculation work, including the installation of [`slowkow/picardmetrics`](https://github.com/slowkow/picardmetrics), which is documented in detail [here as a `GitHub Gist`](https://gist.github.com/kalavattam/74394ed83c542862e087658accbdbc38)
<br />
<br />

<a id="todo"></a>
## `#TODO`
- Continue the TPM work
    - Understand what needs to be run before/after what when working with the adapted code base from `slowkow` (the work started in early September, 2022)
    - `#NOTE` TPM, like FPKM/RPKM, is not well-suited for between-sample comparisons: We may want to end up using something like `DESeq2` normalization (`#QUESTION` including something like `rlow`?) or `edgeR` TMM; still, get the TPM code up and running
- Review notes (e.g., from previous meetings), steps, written-by-me code, and e-mails (incorporating some into this or another notebook where necessary) prior to Alison's arrival to the lab tomorrow; we-ll likely touch base to talk about things when she comes
    - Look into the PCR deduplication with UMI tools that was suggested by Alison: Need to figure out what that entails
    - Remember, the goal is to have appropriately processed bam files for experimetns to determine the best way(s) to call `Trinity`
- Continue to build out the alignment and processing script you were working on at the end of last week (functionize it, get major modules into separate scripts, get the main work into a driver script, etc.)
<br />
<br />

<a id="2022-1101"></a>
# 2022-1101
Work on calculating TPM, alignment, processing, etc. continued in `2022_transcriptome-assembly/2022-1101/readme.md`, etc.
