
`work_representative-non-coding-transcriptome.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [SGD reference genome resources](#sgd-reference-genome-resources)
1. [Breaking down the entries/categories within `combined.gtf`](#breaking-down-the-entriescategories-within-combinedgtf)
    1. [Yassour et al. \(Regev\) `** antisense_transcript **`](#yassour-et-al-regev--antisense_transcript-)
        1. [Links](#links)
        1. [Problem](#problem)
        1. [Conclusion](#conclusion)
    1. [Xu et al. \(Huber, Steinmetz\) `** CUT SUT **`](#xu-et-al-huber-steinmetz--cut-sut-)
        1. [Links](#links-1)
        1. [Details](#details)
        1. [Related Methods entries](#related-methods-entries)
            1. [Array data analysis](#array-data-analysis)
            1. [Transcript categorization](#transcript-categorization)
            1. [Definition of CUTs](#definition-of-cuts)
        1. [Question and answer](#question-and-answer)
            1. [Question](#question)
            1. [Answer](#answer)
        1. [Conclusion](#conclusion-1)
    1. [Vera, Dowell `** CUT_4X, CUT_2016 **`](#vera-dowell--cut_4x-cut_2016-)
        1. [Links](#links-2)
        1. [Details](#details-1)
            1. [Related Methods entry](#related-methods-entry)
                1. [*Explicit duration hidden Markov model*](#explicit-duration-hidden-markov-model)
                1. [*CUT identification*](#cut-identification)
                1. [*Annotation overlap and significance test*](#annotation-overlap-and-significance-test)
                1. [*Conserved CUT expression*](#conserved-cut-expression)
        1. [Question and answer #1](#question-and-answer-1)
            1. [Question](#question-1)
            1. [Answer](#answer-1)
        1. [Question and answer #2](#question-and-answer-2)
            1. [Question](#question-2)
            1. [Answer](#answer-2)
        1. [Conclusion](#conclusion-2)
    1. [van Dijk et al. \(Thermes, Morillon\) `** XUT **`](#van-dijk-et-al-thermes-morillon--xut-)
        1. [Links](#links-3)
        1. [Question and answer](#question-and-answer-1)
            1. [Question](#question-3)
            1. [Answer](#answer-3)
        1. [Conclusion](#conclusion-3)
        1. [Miscellaneous](#miscellaneous)
    1. [Venkatesh, Li, Gogol, Workman `** SRAT **`](#venkatesh-li-gogol-workman--srat-)
        1. [Links](#links-4)
        1. [Details](#details-2)
            1. [Related methods entry](#related-methods-entry-1)
        1. [Question and answer](#question-and-answer-2)
            1. [Question](#question-4)
            1. [Answer](#answer-4)
        1. [Conclusion](#conclusion-4)
    1. [Schulz et al. \(Cramer\) `** NUT **`](#schulz-et-al-cramer--nut-)
    1. [Gudipati et al. \(Libri\) `** dis3Δ transcripts **`](#gudipati-et-al-libri--dis3%CE%94-transcripts-)
        1. [Links](#links-5)
        1. [Problem](#problem-1)
        1. [Maybe](#maybe)
    1. [Lidschreiber, Easter et al. \(Passmore, Cramer\) `**  **`](#lidschreiber-easter-et-al-passmore-cramer--)
        1. [How I found this article](#how-i-found-this-article)
        1. [Question](#question-5)
    1. [Yu et al. \(Cramer\) `...`](#yu-et-al-cramer-)
        1. [Links](#links-6)
        1. [How I found this article](#how-i-found-this-article-1)
    1. [Wilkening et al. \(Steinmetz\) `...`](#wilkening-et-al-steinmetz-)
1. [Plan](#plan)
1. [Obtain the data](#obtain-the-data)
    1. [Get situated](#get-situated)
        1. [Code](#code)
    1. [Download NUTs](#download-nuts)
        1. [Notes, code](#notes-code)
    1. [Download CUTs, SUTs](#download-cuts-suts)
        1. [Code](#code-1)
    1. [Download CUTs-4X, CUTs-HMM](#download-cuts-4x-cuts-hmm)
        1. [Code](#code-2)
    1. [Download XUTs](#download-xuts)
        1. [Code](#code-3)
    1. [Download SRATs](#download-srats)
        1. [Code](#code-4)
1. [Install liftOver, "lift" XUTs and CUTs/SUTs](#install-liftover-lift-xuts-and-cutssuts)
    1. [Install liftOver, etc.](#install-liftover-etc)
        1. [Code](#code-5)
    1. ["Lift" XUTs, CUTs/SUTs to appropriate coordinate system](#lift-xuts-cutssuts-to-appropriate-coordinate-system)
        1. [Review how to use liftOver](#review-how-to-use-liftover)
            1. [Code](#code-6)
            1. [Printed](#printed)
        1. [Check on the contents of the chain files](#check-on-the-contents-of-the-chain-files)
            1. [Code](#code-7)
            1. [Printed](#printed-1)
        1. [Remove "chr" prefix from chain files](#remove-chr-prefix-from-chain-files)
            1. [Code](#code-8)
        1. [Convert XUTs, CUTs/SUTs to bed](#convert-xuts-cutssuts-to-bed)
            1. [Next steps](#next-steps)
        1. [Perform the "lift overs"](#perform-the-lift-overs)
            1. [Get situated](#get-situated-1)
                1. [Code](#code-9)
            1. [Run liftOver](#run-liftover)
                1. [Code](#code-10)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="sgd-reference-genome-resources"></a>
## SGD reference genome resources
- [*G3* publication describing the history of the *S. cerevisiae* S288c reference genome](https://wiki.yeastgenome.org/images/1/1d/Engel_2013_PMID_24374639.pdf)
- [Downloads site](http://sgd-archive.yeastgenome.org/)
- [DNA and protein sequences](http://sgd-archive.yeastgenome.org/sequence)
- [List of dates of Genome Releases](http://downloads.yeastgenome.org/sequence/S288C_reference/dates_of_genome_releases.tab)
- [List of all chromosome sequence changes]()
- [S288c genome releases](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/)
- [S288c genome liftOver chain files](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/)
- [Other yeast strain genomes](http://sgd-archive.yeastgenome.org/sequence/strains)
<br />
<br />

<a id="breaking-down-the-entriescategories-within-combinedgtf"></a>
## Breaking down the entries/categories within `combined.gtf`
<a id="yassour-et-al-regev--antisense_transcript-"></a>
### Yassour et al. (Regev) `** antisense_transcript **`
Strand-specific RNA sequencing reveals extensive regulated long antisense transcripts that are conserved across yeast species, *Genome Biol* 2010

<a id="links"></a>
#### Links
- [Publication at genomebiology.com](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2010-11-8-r87)
- [SGD entry for the publication](http://yeastgenome.org/reference/S000136009)
- [GEO Series GSE21739](http://ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21739)

<a id="problem"></a>
#### Problem
- Given when this paper was published, it is not possible for the genomic coordinates to be in the R64-1-1 system, the coordinate system used in our work.
- Furthermore, it is not clear in the paper what genome they aligned to.
- Given the date of publication, they may have used R61-1-1 (2008_06_05 UCSC Genome Browser version sacCer2) or perhaps (R62-1-1 2009_02_18)&mdash;or perhaps something even earlier than R61.

<a id="conclusion"></a>
#### Conclusion
These data are not usable in their current state.
<br />

<a id="xu-et-al-huber-steinmetz--cut-sut-"></a>
### Xu et al. (Huber, Steinmetz) `** CUT SUT **`
Bidirectional promoters generate pervasive transcription in yeast, *Nature* 2009

<a id="links-1"></a>
#### Links
- [Publication at nature.com](https://www.nature.com/articles/nature07728)
- [ArrayExpress entry for the publication, E-TABM-590](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-TABM-590?query=E-TABM-590)

<a id="details"></a>
#### Details
- CUT features (*not CUT_4X and CUT_2016*) come from `41586_2009_BFnature07728_MOESM276_ESM.xls` (Supplementary Table 3) tab "C"
- SUT features come from `41586_2009_BFnature07728_MOESM276_ESM.xls` (Supplementary Table 3) tab "B"
- (*"ORF-T's" are in tab "A"*)
- Fasta used for alignment is available here: [steinmetzlab.embl.de/NFRsharing/scAll.fsa](steinmetzlab.embl.de/NFRsharing/scAll.fsa)

<a id="related-methods-entries"></a>
#### Related Methods entries
<a id="array-data-analysis"></a>
##### Array data analysis
Arrays profiled in conditions YPD, YPE and YPGal were normalized with genomic DNA as in \[16\]. Only the probes matching exactly and uniquely to the S288c genome were considered further. The normalized data were jointly segmented using a segmentation algorithm \[16\] and the automatically identified segments were curated using a custom web-interface ([Supplementary Information](https://www.nature.com/articles/nature07728#MOESM275)). This defined the set of manually curated transcripts.

To identify CUTs, arrays for the *rrp6Δ* strain were segmented jointly with the arrays of the wild-type strain in the same condition (SDC). YJM789 arrays were normalized with YJM789 genomic DNA as a reference. Only the probes matching exactly and uniquely to the S288c-aligned part of the YJM789 sequence were considered further. The normalized data were segmented based on the alignment between S288c and YJM789 \[28\].

<a id="transcript-categorization"></a>
##### Transcript categorization
The manually curated transcripts were overlapped with the genome annotation features and classified as: (1) SUTs, if they did not overlap with existing annotation; (2) ORF-Ts, if they overlapped with a verified or uncharacterized ORF; or (3) other. Transcripts detected solely in rrp6Δ were defined as (4) CUTs (see next section). We refer to the union of SUTs and CUTs also as unannotated transcripts. (5) Antisense transcripts were defined as unannotated transcripts that overlapped with other transcripts on the opposite strand.

<a id="definition-of-cuts"></a>
##### Definition of CUTs
The automatically detected segments for the *rrp6Δ* strain were overlapped with the manually curated transcripts. We defined three criteria: to not overlap any annotated feature; to show higher than twofold expression in *rrp6Δ* compared to wild type; and to be at least 100 bases long. Two types of CUTs were defined. CUTs of the first type were *rrp6Δ* segments that did not overlap any manually curated segments and fulfilled all three criteria. CUTs of the second type were derived from the *rrp6Δ* segments overlapping manually curated transcripts in either a one-to-one or a many-to-one relationship. The *rrp6Δ*-specific (non-overlapping) parts of these segments were classified as CUTs if they fulfilled all criteria.

<a id="question-and-answer"></a>
#### Question and answer
<a id="question"></a>
##### Question
Problem But what is `scAll.fsa`&mdash;i.e., what version of *S. cerevisiae* S288c is this?

<a id="answer"></a>
##### Answer
It appears to be '`S288C_reference_genome_R56-1-1_20070406/S288C_reference_sequence_R56-1-1_20070406.fsa`'

```bash
#!/bin/bash

cmp \
    scAll.fsa \
    S288C_reference_genome_R64-3-1_20210421/S288C_reference_sequence_R64-3-1_20210421.fsa
# scAll.fsa S288C_reference_genome_R64-3-1_20210421/S288C_reference_sequence_R64-3-1_20210421.fsa differ: char 3994, line 65

cmp \
    scAll.fsa \
    S288C_reference_genome_R58-1-1_20080305/S288C_reference_sequence_R58-1-1_20080305.fsa
# scAll.fsa S288C_reference_genome_R58-1-1_20080305/S288C_reference_sequence_R58-1-1_20080305.fsa differ: char 59260, line 971

cmp \
    scAll.fsa \
    S288C_reference_genome_R59-1-1_20080603/S288C_reference_sequence_R59-1-1_20080603.fsa
# scAll.fsa S288C_reference_genome_R59-1-1_20080603/S288C_reference_sequence_R59-1-1_20080603.fsa differ: char 59260, line 971

cmp \
    scAll.fsa \
    S288C_reference_genome_R54-1-1_20061006/S288C_reference_sequence_R54-1-1_20061006.fsa
# scAll.fsa S288C_reference_genome_R54-1-1_20061006/S288C_reference_sequence_R54-1-1_20061006.fsa differ: char 142600, line 2338

cmp \
    scAll.fsa \
    S288C_reference_genome_R55-1-1_20061110/S288C_reference_sequence_R55-1-1_20061110.fsa
# scAll.fsa S288C_reference_genome_R55-1-1_20061110/S288C_reference_sequence_R55-1-1_20061110.fsa differ: char 142600, line 2338

cmp \
    scAll.fsa \
    S288C_reference_genome_R56-1-1_20070406/S288C_reference_sequence_R56-1-1_20070406.fsa

cmp \
    scAll.fsa \
    S288C_reference_genome_R56-1-1_20070406/S288C_reference_sequence_R56-1-1_20070406.fsa && echo "no difference"
# no difference
```

<a id="conclusion-1"></a>
#### Conclusion
OK, so it looks like they used R56-1-1; thus, the coordinates need to be lifted over from R56-1-1 to R64-1-1. Will need [this particular liftOver chain file](sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain)
<br />

<a id="vera-dowell--cut_4x-cut_2016-"></a>
### Vera, Dowell `** CUT_4X, CUT_2016 **`
Survey of cryptic unstable transcripts in yeast, *BMC Genomics* 2016

<a id="links-2"></a>
#### Links
- [Publication at BMC Genomics](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-2622-5)
- CUT annotation from the paper: [`12864_2016_2622_MOESM5_ESM.xlsx`](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx) (Table S1)

<a id="details-1"></a>
#### Details
<a id="related-methods-entry"></a>
##### Related Methods entry
<a id="explicit-duration-hidden-markov-model"></a>
###### *Explicit duration hidden Markov model*
We developed an explicit duration hidden Markov model (HMM) to analyze per nucleotide rrp6Δ/WT RNA-seq fold change signal (Fig. 1a) using the Matlab HMM toolkit (MATLAB 2012b, The MathWorks Inc., Natick, MA, 2012). The HMM consists of two main states, one parameterized to non-elevated regions of the transcriptome (i.e. not CUTs) and one for elevated (approximately ≥2 fold) regions of the transcriptome (i.e. CUTs). Specifically we expanded the CUT state into nine identical sub-states with unidirectional movement through the model (Additional file 14: Figure S11) thereby setting the minimum length of a CUT to nine nucleotides and producing a 10-State model that approximates a hidden semi-Markov model \[51\]. This allowed us to deviate from the exponential duration modelling of traditional HMMs and produce CUT annotations with a length distribution that better approximated previous studies \[5, 11\]. We note that when the model is used to generate representative sequences, the CUT state of the model produced sequences that are generally long (>34,000 bp) reflecting our bias to identify long regions of relatively consistent elevated coverage. Per nucleotide fold change values were converted to discrete values for analysis by our HMM as necessitated by the Matlab toolkit (Additional file 10: Table S5). Transition and emission probabilities are available in (Additional file 10: Tables S4, S5).

<a id="cut-identification"></a>
###### *CUT identification*
From the HMM we derived an initial set of raw CUT annotations. These raw annotations were filtered to remove snRNAs, snoRNAs, and rRNAs as well as expected hits resulting from genotypic differences in *rrp6Δ* strains relative to WT. Any remaining regions within 450 bp were merged together into a single annotation. Regions with average *rrp6Δ* read coverage less than the upper two-thirds of all nonzero coverage values for that strain and any regions less than 100 nt in length also were removed. Final CUT annotations are available from the GEO repository under accession number GSE74028 at http://www.ncbi.nlm.nih.gov/geo.

<a id="annotation-overlap-and-significance-test"></a>
###### *Annotation overlap and significance test*
We used IntersectBed \[50\] to quantify the extent of overlap between our HMM S288c CUT annotations and other data sets (Fig. 1b) requiring overlap of ≥25 % the length of either annotation. Because we removed raw HMM CUT annotations that overlapped snRNAs, snoRNAs, and rRNAs, we likewise removed any annotations from Xu et al. \[11\] and Gudipati et al. \[31\] that overlapped the removed raw HMM CUTs in S288c to properly reflect the extent of overlap between these data sets and our S288c CUTs. Hence only 885 of a total 925 Xu et al. \[11\] CUTs and 1972 of a total 2032 Gudipati et al. \[31\] dis3Δ transcripts were used in subsequent overlap analyses. To determine statistical significant we randomly sampled genomic regions with the same length distribution as S288c identified CUTs. After 200 iterations, overlap of these randomly sampled regions and previously annotated CUTs or dis3Δ transcripts approximate a normal distribution (Additional file 2: Figure S2B,E). We use two standard deviations from the mean to assess significance within our CUT annotations.

<a id="conserved-cut-expression"></a>
###### *Conserved CUT expression*
First we converted all CUT annotations from strain-specific coordinates to the 4-way alignment coordinate system. Then we calculated a histogram of CUT annotations along the 4-way alignment and all continuous regions ≥1 in the histogram were selected. The total histogram signal over these selected regions was averaged and used to determine the total number of CUTs overlapping that region. Regions with an average histogram signal >4 denoted 4x conserved CUT expression. We identified 208 regions where the CUT annotations were incongruent across the four strains and applied hand edits to resolve these incongruences where possible. Additionally, we examined those CUTs in 3 of the 4 strains and if the CUT is missed in the fourth strain by our filtering procedure (i.e. the fourth strain has a CUT in the raw HMM output) we brought back the filtered CUT annotation and considered these to be 4X conserved CUTs. The resulting changes in CUT annotations are reflected in summaries reported in Fig. 3a. After removing those CUTs with indels (relative to the four-way alignment) for more than 25% the length of the CUT, we derived the conserved expression results reported in Fig. 3c, d. In the case of unique CUTs (Fig. 3d) we only reported those CUTs that did not overlap a raw (but removed) annotation in either of other strains. To determine the significance of our CUT conservation analysis we randomized CUT annotations in all four strains to assess the chance of CUT conservation simply by chance. With 200 iterations, little to no random 4x conserved CUTs were found (Additional file 15: Figure S12).

<a id="question-and-answer-1"></a>
#### Question and answer #1
<a id="question-1"></a>
##### Question
What's the coordinate system? Does liftOver need to be performed?

<a id="answer-1"></a>
##### Answer
from <b>Methods</b> *"Genome sequences and annotations"*: "S288c genome and annotations are from the Saccharomyces Genome Database (SGD) S288c genome version 64 \[29\]."

Thus, liftOver does not need to be performed.

<a id="question-and-answer-2"></a>
#### Question and answer #2
<a id="question-2"></a>
##### Question
What are the differences between CUT_2016 and CUT_4X in combined.gtf?

```r
#!/usr/bin/env Rscript

Vera_Dowell <- t_ncRNA[stringr::str_detect(t_ncRNA$source, "^Vera*"), ]
Vera_Dowell$gene_id[!(
    duplicated(Vera_Dowell$gene_id) |
    duplicated(Vera_Dowell$gene_id, fromLast = TRUE)
)]
# [1] "CUT4251" "CUT4379"

Vera_Dowell[Vera_Dowell$gene_id %in% c("CUT4251", "CUT4379"), ]
# # A tibble: 2 × 9
#   seqnames start   end width strand source           type     score gene_id
#   <chr>    <int> <int> <int> <fct>  <fct>            <fct>    <dbl> <chr>  
# 1 XV       78074 78494   421 -      Vera_Dowell_2016 CUT_2016    NA CUT4251
# 2 XV       92778 92896   119 -      Vera_Dowell_2016 CUT_2016    NA CUT4379
```
`#NOTE` Both are found associated with type CUT_2016 but not type CUT_4X

<a id="answer-2"></a>
##### Answer
Except for the above two entries, they seem to be overwhelmingly the same. It's not clear to me what is the two extra "CUT_2016" amid all Vera, Dowel features; 

<a id="conclusion-2"></a>
#### Conclusion
Move forward with CUT_4X (more specifically, the entries in [`12864_2016_2622_MOESM5_ESM.xlsx`](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx), i.e., Table S1 from the publication)
<br />

<a id="van-dijk-et-al-thermes-morillon--xut-"></a>
### van Dijk et al. (Thermes, Morillon) `** XUT **`
XUTs are a class of Xrn1-sensitive antisense regulatory non-coding RNA in yeast, *Nature* 2011

<a id="links-3"></a>
#### Links
- [Pubmed entry for the publication](pubmed.ncbi.nlm.nih.gov/21697827/)
- [Nature page for the publication](https://www.nature.com/articles/nature10118)

<a id="question-and-answer-1"></a>
#### Question and answer
<a id="question-3"></a>
##### Question
What's the coordinate system? Does liftOver need to be performed?

<a id="answer-3"></a>
##### Answer
From <b>Online Methods</b>, *"Transcriptome analysis and normalization"*: Genome was annotated according to SGD (http://www.yeastgenome.org/, 5 January 2010); SUT (stable unannotated transcript) and CUT (cryptic unstable transcript) annotations were retrieved \[22\].

According to [`dates_of_genome_releases.tab` from the SGD], the "5 January 2010" release is "R63-1-1 2010_01_05".

`#TODO` liftOver from R63 to R64

<a id="conclusion-3"></a>
#### Conclusion
1. Download the XUT annotation file (gff3)
- [Source page](http://vm-gb.curie.fr/XUT/index.htm)
- [The file proper](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff)
2. "Lift" the file from R63 coordinates to R64 coordinates

<a id="miscellaneous"></a>
#### Miscellaneous
There are 1658 entries in [the above gff3](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff) (which need to be "lifted" from R63 to R64); for some reason, there are 1657 related records in `combined.gtf`. Just go with the gff3 from van Dijk et al.
<br />

<a id="venkatesh-li-gogol-workman--srat-"></a>
### Venkatesh, Li, Gogol, Workman `** SRAT **`
Selective suppression of antisense transcription by Set2-mediated H3K36 methylation, *Nat Comm* 2016

<a id="links-4"></a>
#### Links
- [Nature page for the publication](https://www.nature.com/articles/ncomms13610)

<a id="details-2"></a>
#### Details
<a id="related-methods-entry-1"></a>
##### Related methods entry
From <b>Methods</b> *"Identification of novel transcripts"*: "We aligned the unique reads obtained from the *SET2* deletion strain to the yeast genome (based on sequence dated April 2011 in the Saccharomyces Genome Database (http://www.yeastgenome.org/) and was obtained from the site ftp://ftp.ncbi.nlm.nih.gov/genbank/genomes/Eukaryotes/fungi/Saccharomyces_cerevisiae/SacCer_Apr2011) and identified all transcripts arising from each strand using the Cufflinks program. A five-nucleotide read gap was used to separate different transcripts. We used the BEDtools bioinformatics suite to refine this list of novel transcripts to remove known coding transcripts and their untranslated regions \[29\], and previously identified pervasive transcripts like the cryptic unstable transcripts (CUTs) \[4,5\], stable unannotated transcripts (SUTs) \[4\], and the Xrn1-sensitive unstable transcripts (XUTs) \[6\]. A discrepancy in these annotations arises from the fact that each transcript class was identified independent of one another, resulting in duplications that have not been resolved. We avoided this pitfall by removing all previously identified transcripts in our novel RNA identification pipeline. The resultant list of 1,179 novel transcripts (Supplementary Data 6) consisted entirely of transcripts from the antisense strand of protein-coding genes. This list was further pared down by estimating the differential expression of these transcripts (using limma in R) and requiring that the following parameters were met. First, to make sure that valid and complete transcripts were being designated, we selected identified transcripts with detectable expression (FPKM>1) either in the wild-type or the *SET2* deletion strain. This requirement also ensured that transcripts with breaks in the reads were removed from the analysis. Second, transcripts with a FDR of <5% (adjusted P value <0.05) were selected. Finally, we instituted a cutoff at twofold increase in the abundance of the transcripts in the *SET2* deletion mutant over the wild-type, to select ones that are upregulated upon loss of Set2. These parameters helped us obtain a list of 853 transcripts that we named SRATs."

<a id="question-and-answer-2"></a>
#### Question and answer
<a id="question-4"></a>
##### Question
What's the coordinate system? Does liftOver need to be performed?

<a id="answer-4"></a>
##### Answer
The coordinate system is "`SacCer_Apr2011`"; per [the SGD's official dates of genome releases](http://downloads.yeastgenome.org/sequence/S288C_reference/dates_of_genome_releases.tab), this looks to be the same as R64-1-1, which is given a release date of February, 2011. Thus, it seems that the authors used R64-1-1.

```txt
R54-1-1 2006_10_06
R55-1-1 2006_11_10
R56-1-1 2007_04_06
R57-1-1 2007_12_12
R58-1-1 2008_03_05
R59-1-1 2008_06_03
R60-1-1 2008_06_04
R61-1-1 2008_06_05      UCSC Genome Browser version sacCer2
R62-1-1 2009_02_18
R63-1-1 2010_01_05
R64-1-1 2011_02_03      UCSC Genome Browser version sacCer3
R64-2-1 2014_11_18      RefSeq GCF_000146045.1|GenBank GCA_000146045.1
R64-3-1 2021-04-21      RefSeq GCF_000146045.2|GenBank GCA_000146045.2 https://wiki.yeastgenome.org/index.php/
```

<a id="conclusion-4"></a>
#### Conclusion
Download the SRAT annotations: [`41467_2016_BFncomms13610_MOESM1735_ESM.csv`](static-content.springer.com/esm/art%3A10.1038%2Fncomms13610/MediaObjects/41467_2016_BFncomms13610_MOESM1735_ESM.csv) (Supplementary Data 1)
<br />

<a id="schulz-et-al-cramer--nut-"></a>
### Schulz et al. (Cramer) `** NUT **`
Transcriptome surveillance by selective termination of noncoding RNA synthesis, *Cell* 2013-1121

https://www.ebi.ac.uk/ena/browser/view/PRJEB4393
https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-1766

Problem #NOTE Can't find a list of the ~1526 annotated NUTs: Thus, it's not clear to me how these annotations made it into combined.gtf; however, they appear to be R64-1-1 coordinates, which we can use...

`#EVIDENCE`
From EXTENDED EXPERIMENTAL PROCEDURES, "PAR-CLIP Data Analysis"
Quality-trimmed reads were aligned to the S. cerevisiae genome (sacCer3, April 2012)
using the short read aligner Bowtie with maximum one mismatch and unique matches only (Langmead et al., 2009) (Bowtie
options: -q -p 4 -S–sam-nohead -v 1 -n 1 -e 70 -l 28 -y -a -m 1–best–strata–phred33-quals). Subsequently, BAM and PileUp files
were generated using the SAMTools toolkit (Li et al., 2009).

From EXTENDED EXPERIMENTAL PROCEDURES, "Multiplex ChIP-seq"
Reads were demultiplexed, quality-trimmed (Fastq Quality Filter), and mapped with Bowtie 1.1.0 (Langmead et al., 2009) to the
SacCer3 genome assembly (Bowtie options: -q -p 4 -S–sam-nohead -n 1 -e 70 -l 28 -y -m 1–best–strata–phred33-quals).
SAM files were converted into BAM files and read counts for every genomic position calculated using pileup from SAMtools
(Li et al., 2009).

`#INTERESTING` (https://genome.cshlp.org/content/28/12/1882.full)
It seems the list of NUTs was not made publicly available with the publication of Schulz et al. (Cramer); see https://genome.cshlp.org/content/28/12/1882.full, particularly Methods, List of noncoding RNAs and replication origins: "The list of CUTs was obtained from Xu et al. (2009), while the list of NUTs was kindly provided by the Cramer lab (Schulz et al. 2013). Among the NUTs, only those showing at least a twofold increase in +Rap/−Rap were taken into account to unify the threshold of ncRNA definition between CUTs and NUTs. The list of ARS (Supplemental Table S1) consists of the 234 ACS taken from Soriano et al. (2014) that overlap with the replication origins described in Hawkins et al. (2013), for which replication timing and efficiency have been defined. Replication origins with an efficiency <15% were not taken into account."
<br />

<a id="gudipati-et-al-libri--dis3%CE%94-transcripts-"></a>
### Gudipati et al. (Libri) `** dis3Δ transcripts **`
Extensive Degradation of RNA Precursors by the Exosome in Wild-Type Cells, *Mol Cell* 2012

<a id="links-5"></a>
#### Links
- [ArrayExpress E-MTAB-1246](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-1246)
- [Online Mol Cell publication at sciencedirect.com](https://www.sciencedirect.com/science/article/pii/S1097276512007368?)
- [Publication via Europe PMC](https://europepmc.org/article/MED/23000176)
- [Publication entry on the SGD](https://www.yeastgenome.org/reference/S000152662)
- [Review on facultyopinions.com](https://facultyopinions.com/article/717980293#eval793471523)

<a id="problem-1"></a>
#### Problem
Although publications have made use of dis3∆-unique transcript annotations in their analyses, these do not appear to be available in an explicit form amid the supplementary files, nor does it appear to be available from ArrayExpress.

<a id="maybe"></a>
#### Maybe
- Assess the paper's <b>Methods</b> section to understand how the transcript annotations were generated.
- Find and include the annotations in our "representative non-coding transcriptome" analyses.
- Would I need to process [this large "processed file" available from ArrayExpress](https://www.ebi.ac.uk/biostudies/files/E-MTAB-1246/normProbeIntensity.txt) in order to obtain transcript annotations?
- It would nice to include these annotations in the "representative non-coding transcriptome"
<br />

<a id="lidschreiber-easter-et-al-passmore-cramer--"></a>
### Lidschreiber, Easter et al. (Passmore, Cramer) `**  **`
The APT complex is involved in non-coding RNA transcription and is distinct from CPF, *Nucleic Acids Res* 2018

<a id="how-i-found-this-article"></a>
#### How I found this article
Googled "GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf" to find out what study the file is associated with. The top result was [the GEO page, GSE114301, for Lidschreiber, Easter et al.](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE114301). Although Steinmetz is not an author on this study, the following annotation files are made available on this page:
- `GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013.gtf.gz`
- `GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013_DESeq2_results_table.txt.gz`
- `GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013_rawHTSeq-counts.txt.gz`

<a id="question-5"></a>
#### Question
Is this something I want to follow up on/something we want to include in the "representative non-coding transcriptome?"
<br />

<a id="yu-et-al-cramer-"></a>
### Yu et al. (Cramer) `...`
Architecture of the RNA polymerase II-Paf1C-TFIIS transcription elongation complex, *Nat Commun* 2017

<a id="links-6"></a>
#### Links
- [PubMed entry](https://pubmed.ncbi.nlm.nih.gov/28585565/)
- [Publication on PubMed](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5467213/)

<a id="how-i-found-this-article-1"></a>
#### How I found this article
To learn about the study associated "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" and, more importantly, what are the annotations within this file, [I Googled "GSE95556"](https://www.google.com/search?q=GSE95556&oq=GSE95556&aqs=chrome..69i57j0i546l5.257j0j9&sourceid=chrome&ie=UTF-8).
<br />

<a id="wilkening-et-al-steinmetz-"></a>
### Wilkening et al. (Steinmetz) `...`
An efficient method for genome-wide polyadenylation site mapping and RNA quantification, *Nucleic Acids Res* 2013

This seems to be the file that "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" is associated with&mdash;awaiting feedback from Alison regarding this. `#NOTE` She's not sure&mdash;it is a file first introduced to the lab by Christine.
<br />
<br />

<a id="plan"></a>
## Plan
1. Received the `NUTs` annotation, `Sc.cerevisiae.feature.anno_Schulz_2013.gtf`, from Michael Lidschreiber/Patrick Cramer via email: It already has R64 coordinates, so no liftOver is not necessary.
2. The `CUTs` and `SUTs` annotations are available [here](https://static-content.springer.com/esm/art%3A10.1038%2Fnature07728/MediaObjects/41586_2009_BFnature07728_MOESM276_ESM.xls); coordinates need to be "lifted" from R56 to R64 using the file [here](sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain).
3. The `CUT_4X` annotation is available [here](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx), and the `CUT_HMM` annotation from the same paper is available [here (`GSE74028_S288c.CUTs.txt.gz`)](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE74nnn/GSE74028/suppl/GSE74028_S288c.CUTs.txt.gz): It already has R64 coordinates, so liftOver is not necessary.
4. The `XUTs` annotation is available [here](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff) and needs to be lifted from the R63 to R64 coordinate system using the file here.
5. The `SRATs` annotation is available [here](static-content.springer.com/esm/art%3A10.1038%2Fncomms13610/MediaObjects/41467_2016_BFncomms13610_MOESM1735_ESM.csv) and is already in the R64 coordinate system
6. Emailed Robin Dowell about potentially obtaining data for the *dis3*∆ transcripts from Gudapati et al. (2023-0413)&mdash;awaiting a response
<br />
<br />

<a id="obtain-the-data"></a>
## Obtain the data
<a id="get-situated"></a>
### Get situated
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215"
source activate gff3_env

if [[ ! -d infiles_gtf-gff3/representation ]]; then
    mkdir -p infiles_gtf-gff3/representation/{NUTs,CUTs_SUTs,CUTs-HMM_CUTs-4X,XUTs,SRATs}
fi
```
</details>
<br />

<a id="download-nuts"></a>
### Download NUTs
<a id="notes-code"></a>
#### Notes, code
<details>
<summary><i>Notes, code: Download NUTs</i></summary>

Download manually to `infiles_gtf-gff3/representation/NUTs` from [email](https://outlook.office.com/mail/inbox/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQADnQJ40sYUZHmZabCmVS4qQ%3D) from Michael Lidschreiber
<details>
<summary><i>Code: Download NUTs</i></summary>

```bash
#!/bin/bash

#  Give file a scrutable name
cp \
    infiles_gtf-gff3/representation/NUTs/Sc.cerevisiae.feature.anno_Schulz_2013.gtf \
    infiles_gtf-gff3/representation/NUTs/NUTs.gtf

#NOTE Already in R64 coordinates
```
</details>
<br />

</details>
<br />

<a id="download-cuts-suts"></a>
### Download CUTs, SUTs
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Download CUTs, SUTs</i></summary>

```bash
#!/bin/bash

#  Get the list of CUTs, SUTs
curl \
    https://static-content.springer.com/esm/art%3A10.1038%2Fnature07728/MediaObjects/41586_2009_BFnature07728_MOESM276_ESM.xls \
        > infiles_gtf-gff3/representation/CUTs_SUTs/41586_2009_BFnature07728_MOESM276_ESM.xls

#  Give file a scrutable name
cp \
    infiles_gtf-gff3/representation/CUTs_SUTs/41586_2009_BFnature07728_MOESM276_ESM.xls \
    infiles_gtf-gff3/representation/CUTs_SUTs/CUTs_SUTs.xls

#  Get necessary liftOver file, and give it a helpful name
curl \
    sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain \
        > infiles_gtf-gff3/representation/CUTs_SUTs/V56_2007_04_06_V64_2011_02_03.over.chain

cp \
    infiles_gtf-gff3/representation/CUTs_SUTs/V56_2007_04_06_V64_2011_02_03.over.chain \
    infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.chain
```
</details>
<br />

<a id="download-cuts-4x-cuts-hmm"></a>
### Download CUTs-4X, CUTs-HMM
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Download CUTs-4X, CUTs-HMM</i></summary>

```bash
#!/bin/bash

#  Get CUTs-4x
curl \
    https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx \
        > infiles_gtf-gff3/representation/CUTs-HMM_CUTs-4X/12864_2016_2622_MOESM5_ESM.xlsx

#  Get CUTs-HMM
curl \
    https://ftp.ncbi.nlm.nih.gov/geo/series/GSE74nnn/GSE74028/suppl/GSE74028_S288c.CUTs.txt.gz \
        > infiles_gtf-gff3/representation/CUTs-HMM_CUTs-4X/GSE74028_S288c.CUTs.txt.gz

#  Give files scrutable names
cp \
    infiles_gtf-gff3/representation/CUTs-HMM_CUTs-4X/12864_2016_2622_MOESM5_ESM.xlsx \
    infiles_gtf-gff3/representation/CUTs-HMM_CUTs-4X/CUTs-4x.xlsx

cp \
    infiles_gtf-gff3/representation/CUTs-HMM_CUTs-4X/GSE74028_S288c.CUTs.txt.gz \
    infiles_gtf-gff3/representation/CUTs-HMM_CUTs-4X/CUTs-HMM.txt.gz

#NOTE Already in R64 coordinates
```
</details>
<br />

<a id="download-xuts"></a>
### Download XUTs
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Download XUTs</i></summary>

```bash
#!/bin/bash

#  Get XUTs
curl \
    http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff \
        > infiles_gtf-gff3/representation/XUTs/XUTs_Van_Dijk_et_al_2011.gff

#  Give file a scrutable name
cp \
    infiles_gtf-gff3/representation/XUTs/XUTs_Van_Dijk_et_al_2011.gff \
    infiles_gtf-gff3/representation/XUTs/XUTs.gff

#  Get necessary liftOver file, and give it a helpful name
curl \
    http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V63_2010_01_05_V64_2011_02_03.over.chain \
        > infiles_gtf-gff3/representation/XUTs/V63_2010_01_05_V64_2011_02_03.over.chain

cp \
    infiles_gtf-gff3/representation/XUTs/V63_2010_01_05_V64_2011_02_03.over.chain \
    infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.chain
```
</details>
<br />

<a id="download-srats"></a>
### Download SRATs
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Download SRATs</i></summary>

```bash
#!/bin/bash

#  Get SRATs
curl \
    static-content.springer.com/esm/art%3A10.1038%2Fncomms13610/MediaObjects/41467_2016_BFncomms13610_MOESM1735_ESM.csv \
        > infiles_gtf-gff3/representation/SRATs/41467_2016_BFncomms13610_MOESM1735_ESM.csv

#  Give file a scrutable name
cp \
    infiles_gtf-gff3/representation/SRATs/41467_2016_BFncomms13610_MOESM1735_ESM.csv \
    infiles_gtf-gff3/representation/SRATs/SRATs.csv

#NOTE Already in R64 coordinates
```
</details>
<br />
<br />

<a id="install-liftover-lift-xuts-and-cutssuts"></a>
## Install liftOver, "lift" XUTs and CUTs/SUTs
<a id="install-liftover-etc"></a>
### Install liftOver, etc.
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Install liftOver, etc.</i></summary>

```bash
#!/bin/bash

#  Within gff3_env
mamba install -c bioconda ucsc-liftover

mamba install \
    -c conda-forge \
        r-complexupset \
        bioconductor-rtracklayer==1.58.0
```
`#INPRORESS` Include in environment-building `MarkDown` notebook
</details>
<br />

<details>
<summary><i>Printed: Install liftOver, etc.</i></summary>

```txt
❯ mamba install -c bioconda ucsc-liftover

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

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['ucsc-liftover']

bioconda/noarch                                      4.2MB @   3.3MB/s  1.6s
bioconda/linux-64                                    4.6MB @   2.9MB/s  1.7s
pkgs/main/linux-64                                   5.5MB @   3.4MB/s  2.0s
pkgs/main/noarch                                   821.4kB @ 400.8kB/s  0.4s
pkgs/r/noarch                                                 No change
pkgs/r/linux-64                                               No change
conda-forge/noarch                                  11.9MB @   3.9MB/s  3.6s
conda-forge/linux-64                                30.8MB @   4.1MB/s  8.6s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/gff3_env

  Updating specs:

   - ucsc-liftover
   - ca-certificates
   - certifi
   - openssl


  Package              Version  Build          Channel                    Size
────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────

  + mysql-connector-c   6.1.11  h6eb9d5d_1007  conda-forge/linux-64     Cached
  + ucsc-liftover          377  ha8a8165_4     bioconda/linux-64         217kB

  Summary:

  Install: 2 packages

  Total download: 217kB

────────────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
ucsc-liftover                                      216.9kB @   1.5MB/s  0.1s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done


❯ mamba install \
>     -c conda-forge \
>         r-complexupset \
>         bioconductor-rtracklayer==1.58.0

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

        mamba (1.3.1) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['r-complexupset', 'bioconductor-rtracklayer==1.58.0']

bioconda/noarch                                      4.2MB @   4.2MB/s  1.1s
bioconda/linux-64                                    4.6MB @   3.9MB/s  1.3s
pkgs/main/linux-64                                   5.5MB @   4.1MB/s  1.5s
pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                              No change
conda-forge/noarch                                  11.9MB @   4.6MB/s  2.9s
conda-forge/linux-64                                30.8MB @   4.6MB/s  7.4s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/gff3_env

  Updating specs:

   - r-complexupset
   - bioconductor-rtracklayer==1.58.0
   - ca-certificates
   - certifi
   - openssl


  Package           Version  Build          Channel                Size
─────────────────────────────────────────────────────────────────────────
  Install:
─────────────────────────────────────────────────────────────────────────

  + r-complexupset    1.3.3  r42hc72bb7e_1  conda-forge/noarch      3MB
  + r-patchwork       1.1.2  r42hc72bb7e_1  conda-forge/noarch      3MB

  Summary:

  Install: 2 packages

  Total download: 6MB

─────────────────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
r-patchwork                                          3.3MB @  36.1MB/s  0.1s
r-complexupset                                       2.8MB @   9.4MB/s  0.3s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="lift-xuts-cutssuts-to-appropriate-coordinate-system"></a>
### "Lift" XUTs, CUTs/SUTs to appropriate coordinate system
<a id="review-how-to-use-liftover"></a>
#### Review how to use liftOver
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: Review how to use liftOver</i></summary>

```bash
#!/bin/bash

liftOver
```
</details>
<br />

<a id="printed"></a>
##### Printed
<details>
<summary><i>Printed: Review how to use liftOver</i></summary>

```txt
❯ liftOver
liftOver - Move annotations from one assembly to another
usage:
   liftOver oldFile map.chain newFile unMapped
oldFile and newFile are in bed format by default, but can be in GFF and
maybe eventually others with the appropriate flags below.
The map.chain file has the old genome as the target and the new genome
as the query.

***********************************************************************
WARNING: liftOver was only designed to work between different
         assemblies of the same organism. It may not do what you want
         if you are lifting between different organisms. If there has
         been a rearrangement in one of the species, the size of the
         region being mapped may change dramatically after mapping.
***********************************************************************

options:
   -minMatch=0.N Minimum ratio of bases that must remap. Default 0.95
   -gff  File is in gff/gtf format.  Note that the gff lines are converted
         separately.  It would be good to have a separate check after this
         that the lines that make up a gene model still make a plausible gene
         after liftOver
   -genePred - File is in genePred format
   -sample - File is in sample format
   -bedPlus=N - File is bed N+ format (i.e. first N fields conform to bed format)
   -positions - File is in browser "position" format
   -hasBin - File has bin value (used only with -bedPlus)
   -tab - Separate by tabs rather than space (used only with -bedPlus)
   -pslT - File is in psl format, map target side only
   -ends=N - Lift the first and last N bases of each record and combine the
             result. This is useful for lifting large regions like BAC end pairs.
   -minBlocks=0.N Minimum ratio of alignment blocks or exons that must map
                  (default 1.00)
   -fudgeThick    (bed 12 or 12+ only) If thickStart/thickEnd is not mapped,
                  use the closest mapped base.  Recommended if using
                  -minBlocks.
   -multiple               Allow multiple output regions
   -noSerial               In -multiple mode, do not put a serial number in the 5th BED column
   -minChainT, -minChainQ  Minimum chain size in target/query, when mapping
                           to multiple output regions (default 0, 0)
   -minSizeT               deprecated synonym for -minChainT (ENCODE compat.)
   -minSizeQ               Min matching region size in query with -multiple.
   -chainTable             Used with -multiple, format is db.tablename,
                               to extend chains from net (preserves dups)
   -errorHelp              Explain error messages
```
</details>
<br />

<a id="check-on-the-contents-of-the-chain-files"></a>
#### Check on the contents of the chain files
<a id="code-7"></a>
##### Code
<details>
<summary><i>Code: Check on the contents of the chain files</i></summary>

```bash
#!/bin/bash

head infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.chain
head infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.chain
```
</details>
<br />

<a id="printed-1"></a>
##### Printed
<details>
<summary><i>Printed: Check on the contents of the chain files</i></summary>

```txt
❯ head infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.chain
##gapPenalties=axtChain O=400 E=30
##matrix=axtChain 16 91,-114,-31,-123,-114,100,-125,-31,-31,-125,100,-114,-123,-31,-114,91
chain 21723539 chrI 230208 + 0 230208 chrI 230218 + 0 230218 1
3834    1   0
2091    0   1
527 1   0
10002   1   1
10  1   0
29  1   0
5032    0   1


❯ head infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.chain
##gapPenalties=axtChain O=400 E=30
##matrix=axtChain 16 91,-114,-31,-123,-114,100,-125,-31,-31,-125,100,-114,-123,-31,-114,91
chain 21724089 chrI 230208 + 0 230208 chrI 230218 + 0 230218 1
3834    1   0
2091    0   1
527 1   0
10002   1   1
10  1   0
29  1   0
5032    0   1
```
</details>
<br />

<a id="remove-chr-prefix-from-chain-files"></a>
#### Remove "chr" prefix from chain files
<a id="code-8"></a>
##### Code
<details>
<summary><i>Code: Remove "chr" prefix from chain files</i></summary>

```bash
#!/bin/bash

cat infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.chain \
    | sed 's/chr//g' \
        > infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.no-chr.chain

cat \
    infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.chain \
    | sed 's/chr//g' \
        > infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.no-chr.chain

head infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.no-chr.chain
head infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.no-chr.chain
```
</details>
<br />

<details>
<summary><i>Printed: Remove "chr" prefix from chain files</i></summary>

```txt
❯ cat infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.chain \
>     | sed 's/chr//g' \
>         > infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.no-chr.chain


❯ cat \
>     infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.chain \
>     | sed 's/chr//g' \
>         > infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.no-chr.chain


❯ head infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.no-chr.chain
##gapPenalties=axtChain O=400 E=30
##matrix=axtChain 16 91,-114,-31,-123,-114,100,-125,-31,-31,-125,100,-114,-123,-31,-114,91
chain 21723539 I 230208 + 0 230208 I 230218 + 0 230218 1
3834    1   0
2091    0   1
527 1   0
10002   1   1
10  1   0
29  1   0
5032    0   1


❯ head infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.no-chr.chain
##gapPenalties=axtChain O=400 E=30
##matrix=axtChain 16 91,-114,-31,-123,-114,100,-125,-31,-31,-125,100,-114,-123,-31,-114,91
chain 21724089 I 230208 + 0 230208 I 230218 + 0 230218 1
3834    1   0
2091    0   1
527 1   0
10002   1   1
10  1   0
29  1   0
5032    0   1
```
</details>
<br />

<a id="convert-xuts-cutssuts-to-bed"></a>
#### Convert XUTs, CUTs/SUTs to bed
<a id="next-steps"></a>
##### Next steps
<details>
<summary><i>Next steps</i></summary>

...for use with UCSC liftOver: see [`work_representative-non-coding-transcriptome.Rmd`](./work_representative-non-coding-transcriptome.Rmd)
</details>
<br />

<a id="perform-the-lift-overs"></a>
#### Perform the "lift overs"
Back from running code in [`work_representative-non-coding-transcriptome.Rmd`](./work_representative-non-coding-transcriptome.Rmd)

<a id="get-situated-1"></a>
##### Get situated
<a id="code-9"></a>
###### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215"
source activate gff3_env
```
</details>
<br />

<a id="run-liftover"></a>
##### Run liftOver
<a id="code-10"></a>
###### Code
<details>
<summary><i>Code: Run liftOver</i></summary>

```bash
#!/bin/bash

#  Initialize the files
p_base="infiles_gtf-gff3/representation"
p_CS="${p_base}/CUTs_SUTs"
p_X="${p_base}/XUTs"

f_C="${p_CS}/CUTs.coord-R56.bed"
f_S="${p_CS}/SUTs.coord-R56.bed"
f_X="${p_X}/XUTs.coord-R63.bed"

chain_R56="${p_CS}/liftOver_R56-to-R64.no-chr.chain"
chain_R63="${p_X}/liftOver_R63-to-R64.no-chr.chain"

o_C="${p_CS}/CUTs.coord-R64.bed"
o_S="${p_CS}/SUTs.coord-R64.bed"
o_X="${p_X}/XUTs.coord-R64.bed"

u_C="${p_CS}/CUTs.coord-R64.unmapped.bed"
u_S="${p_CS}/SUTs.coord-R64.unmapped.bed"
u_X="${p_X}/XUTs.coord-R64.unmapped.bed"

#  Check
., "${f_C}"
., "${f_S}"
., "${f_X}"
., "${chain_R56}"
., "${chain_R63}"

#  Run liftOver
liftOver "${f_C}" "${chain_R56}" "${o_C}" "${u_C}"
liftOver "${f_S}" "${chain_R56}" "${o_S}" "${u_S}"
liftOver "${f_X}" "${chain_R63}" "${o_X}" "${u_X}"

#  Check
., "${o_C}"
., "${u_C}"
., "${o_S}"

., "${u_S}"
., "${o_X}"
., "${u_X}"

head "${f_C}"
head "${o_C}"

head "${f_S}"
head "${o_S}"

head "${f_X}"
head "${o_X}"
```

</details>
<br />

<details>
<summary><i>Printed: Run liftOver</i></summary>

```txt
❯ ., "${f_C}"
-rw-rw---- 1 kalavatt 57K Apr 14 09:38 infiles_gtf-gff3/representation/CUTs_SUTs/CUTs.coord-R56.bed


❯ ., "${f_S}"
-rw-rw---- 1 kalavatt 51K Apr 14 09:38 infiles_gtf-gff3/representation/CUTs_SUTs/SUTs.coord-R56.bed


❯ ., "${f_X}"
-rw-rw---- 1 kalavatt 68K Apr 14 09:38 infiles_gtf-gff3/representation/XUTs/XUTs.coord-R63.bed


❯ ., "${chain_R56}"
-rw-rw---- 1 kalavatt 6.6K Apr 13 11:19 infiles_gtf-gff3/representation/CUTs_SUTs/liftOver_R56-to-R64.no-chr.chain


❯ ., "${chain_R63}"
-rw-rw---- 1 kalavatt 6.5K Apr 13 11:19 infiles_gtf-gff3/representation/XUTs/liftOver_R63-to-R64.no-chr.chain


❯ liftOver "${f_C}" "${chain_R56}" "${o_C}" "${u_C}"
Reading liftover chains
Mapping coordinates


❯ liftOver "${f_S}" "${chain_R56}" "${o_S}" "${u_S}"
Reading liftover chains
Mapping coordinates


❯ liftOver "${f_X}" "${chain_R63}" "${o_X}" "${u_X}"
Reading liftover chains
Mapping coordinates


❯ ., "${o_C}"
-rw-rw---- 1 kalavatt 57K Apr 14 10:44 infiles_gtf-gff3/representation/CUTs_SUTs/CUTs.coord-R64.bed


❯ ., "${u_C}"
-rw-rw---- 1 kalavatt 0 Apr 14 10:44 infiles_gtf-gff3/representation/CUTs_SUTs/CUTs.coord-R64.unmapped.bed


❯ ., "${o_S}"
-rw-rw---- 1 kalavatt 51K Apr 14 10:44 infiles_gtf-gff3/representation/CUTs_SUTs/SUTs.coord-R64.bed


❯ ., "${u_S}"
-rw-rw---- 1 kalavatt 0 Apr 14 10:44 infiles_gtf-gff3/representation/CUTs_SUTs/SUTs.coord-R64.unmapped.bed


❯ ., "${o_X}"
-rw-rw---- 1 kalavatt 68K Apr 14 10:44 infiles_gtf-gff3/representation/XUTs/XUTs.coord-R64.bed


❯ ., "${u_X}"
-rw-rw---- 1 kalavatt 0 Apr 14 10:44 infiles_gtf-gff3/representation/XUTs/XUTs.coord-R64.unmapped.bed


❯ head "${f_C}"
I   10732   11141   CUTs_CUT436_ST3636_bothEndsMapped_Automatic 0   -
I   30072   30905   CUTs_CUT001_ST0002_bothEndsMapped_Automatic 0   +
I   30532   30893   CUTs_CUT437_ST3638_bothEndsMapped_Automatic 0   -
I   34380   34749   CUTs_CUT438_ST3641_mapped5_Automatic    0   -
I   35796   36349   CUTs_CUT439_ST3642_bothEndsMapped_Automatic 0   -
I   67850   67963   CUTs_CUT440_ST3652_mapped5_Automatic    0   -
I   138606  138831  CUTs_CUT002_ST0033_bothEndsMapped_Automatic 0   +
I   143438  143599  CUTs_CUT003_ST0035_mappedNone_Automatic 0   +
I   151618  152035  CUTs_CUT441_ST3672_bothEndsMapped_Automatic 0   -
I   170494  172447  CUTs_CUT004_ST0041_bothEndsMapped_Automatic 0   +


❯ head "${o_C}"
I   10731   11140   CUTs_CUT436_ST3636_bothEndsMapped_Automatic 0   -
I   30071   30904   CUTs_CUT001_ST0002_bothEndsMapped_Automatic 0   +
I   30531   30892   CUTs_CUT437_ST3638_bothEndsMapped_Automatic 0   -
I   34379   34748   CUTs_CUT438_ST3641_mapped5_Automatic    0   -
I   35795   36348   CUTs_CUT439_ST3642_bothEndsMapped_Automatic 0   -
I   67849   67962   CUTs_CUT440_ST3652_mapped5_Automatic    0   -
I   138604  138829  CUTs_CUT002_ST0033_bothEndsMapped_Automatic 0   +
I   143436  143597  CUTs_CUT003_ST0035_mappedNone_Automatic 0   +
I   151616  152033  CUTs_CUT441_ST3672_bothEndsMapped_Automatic 0   -
I   170499  172449  CUTs_CUT004_ST0041_bothEndsMapped_Automatic 0   +


❯ head "${f_S}"
I   5075    6237    SUTs_SUT432_ST3634_bothEndsMapped_Manual    0   -
I   9368    9601    SUTs_SUT001_ST0001_bothEndsMapped_Manual    0   +
I   28084   29773   SUTs_SUT433_ST3637_bothEndsMapped_Manual    0   -
I   31484   32749   SUTs_SUT434_ST3639_bothEndsMapped_Manual    0   -
I   33076   34381   SUTs_SUT435_ST3640_bothEndsMapped_Manual    0   -
I   43440   45329   SUTs_SUT002_ST0010_bothEndsMapped_Manual    0   +
I   68718   69487   SUTs_SUT003_ST0016_bothEndsMapped_Manual    0   +
I   191610  192195  SUTs_SUT436_ST3678_bothEndsMapped_Manual    0   -
I   198774  199895  SUTs_SUT004_ST0047_bothEndsMapped_Manual    0   +
II  45284   45461   SUTs_SUT437_ST3688_bothEndsMapped_Manual    0   -


❯ head "${o_S}"
I   5074    6237    SUTs_SUT432_ST3634_bothEndsMapped_Manual    0   -
I   9367    9600    SUTs_SUT001_ST0001_bothEndsMapped_Manual    0   +
I   28082   29772   SUTs_SUT433_ST3637_bothEndsMapped_Manual    0   -
I   31483   32748   SUTs_SUT434_ST3639_bothEndsMapped_Manual    0   -
I   33075   34380   SUTs_SUT435_ST3640_bothEndsMapped_Manual    0   -
I   43439   45328   SUTs_SUT002_ST0010_bothEndsMapped_Manual    0   +
I   68717   69486   SUTs_SUT003_ST0016_bothEndsMapped_Manual    0   +
I   191616  192201  SUTs_SUT436_ST3678_bothEndsMapped_Manual    0   -
I   198780  199902  SUTs_SUT004_ST0047_bothEndsMapped_Manual    0   +
II  45287   45464   SUTs_SUT437_ST3688_bothEndsMapped_Manual    0   -


❯ head "${f_X}"
I   5236    5888    XUT_Morillon_1R-2   0   -
I   11270   11786   XUT_Morillon_1F-1   0   +
I   13123   13702   XUT_Morillon_1F-3   0   +
I   13727   16713   XUT_Morillon_1F-4   0   +
I   17193   17983   XUT_Morillon_1R-5   0   -
I   24352   24706   XUT_Morillon_1F-11  0   +
I   24814   25522   XUT_Morillon_1F-12  0   +
I   27075   28176   XUT_Morillon_1F-14  0   +
I   28986   29747   XUT_Morillon_1R-16  0   -
I   30017   30861   XUT_Morillon_1F-15  0   +


❯ head "${o_X}"
I   5235    5887    XUT_Morillon_1R-2   0   -
I   11269   11785   XUT_Morillon_1F-1   0   +
I   13122   13701   XUT_Morillon_1F-3   0   +
I   13726   16710   XUT_Morillon_1F-4   0   +
I   17190   17980   XUT_Morillon_1R-5   0   -
I   24351   24705   XUT_Morillon_1F-11  0   +
I   24813   25521   XUT_Morillon_1F-12  0   +
I   27074   28174   XUT_Morillon_1F-14  0   +
I   28985   29746   XUT_Morillon_1R-16  0   -
I   30016   30860   XUT_Morillon_1F-15  0   +
```
</details>
<br />
