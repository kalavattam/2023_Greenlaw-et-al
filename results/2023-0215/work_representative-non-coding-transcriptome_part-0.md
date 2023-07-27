
`work_representative-non-coding-transcriptome_part-0.md`
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
            1. [Question/problem](#questionproblem)
            1. [Answer](#answer)
                1. [Code/printed](#codeprinted)
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
            1. [Question](#question)
            1. [Answer](#answer-1)
        1. [Question and answer #2](#question-and-answer-2)
            1. [Question](#question-1)
                1. [Code](#code)
            1. [Answer](#answer-2)
        1. [Conclusion](#conclusion-2)
    1. [van Dijk et al. \(Thermes, Morillon\) `** XUT **`](#van-dijk-et-al-thermes-morillon--xut-)
        1. [Links](#links-3)
        1. [Question and answer](#question-and-answer-1)
            1. [Question](#question-2)
            1. [Answer](#answer-3)
        1. [Conclusion](#conclusion-3)
        1. [Miscellaneous](#miscellaneous)
    1. [Venkatesh, Li, Gogol, Workman `** SRAT **`](#venkatesh-li-gogol-workman--srat-)
        1. [Links](#links-4)
        1. [Details](#details-2)
            1. [Related methods entry](#related-methods-entry-1)
        1. [Question and answer](#question-and-answer-2)
            1. [Question](#question-3)
            1. [Answer](#answer-4)
        1. [Conclusion](#conclusion-4)
    1. [Schulz et al. \(Cramer\) `** NUT **`](#schulz-et-al-cramer--nut-)
        1. [Project links](#project-links)
        1. [Problem/note](#problemnote)
        1. [Evidence for the above](#evidence-for-the-above)
            1. [From Extended Experimental procedures, "PAR-CLIP Data Analysis"](#from-extended-experimental-procedures-par-clip-data-analysis)
            1. [From Extended Experimental procedures, "Multiplex ChIP-seq"](#from-extended-experimental-procedures-multiplex-chip-seq)
            1. [Related: Entry from *Genome Res* paper](#related-entry-from-genome-res-paper)
        1. [Solution: Email Patrick Cramer for the file](#solution-email-patrick-cramer-for-the-file)
            1. [Message #1](#message-1)
            1. [Message #2](#message-2)
            1. [Message #3](#message-3)
            1. [Message #4](#message-4)
    1. [Gudipati et al. \(Libri\) `** dis3Δ transcripts **`](#gudipati-et-al-libri--dis3%CE%94-transcripts-)
        1. [Links](#links-5)
        1. [Problem](#problem-1)
        1. [Maybe](#maybe)
        1. [Email to Robin Dowell](#email-to-robin-dowell)
            1. [Update](#update)
    1. [Lidschreiber, Easter et al. \(Passmore, Cramer\) `** ... **`](#lidschreiber-easter-et-al-passmore-cramer---)
        1. [How I found this article](#how-i-found-this-article)
        1. [Question](#question-4)
    1. [Yu et al. \(Cramer\) `** ... **`](#yu-et-al-cramer---)
        1. [Links](#links-6)
        1. [How I found this article](#how-i-found-this-article-1)
    1. [Wilkening et al. \(Steinmetz\) `** ... **`](#wilkening-et-al-steinmetz---)
1. [Plan](#plan)
1. [Next step](#next-step)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="sgd-reference-genome-resources"></a>
## SGD reference genome resources
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

- [*G3* publication describing the history of the *S. cerevisiae* `S288c` reference genome](https://wiki.yeastgenome.org/images/1/1d/Engel_2013_PMID_24374639.pdf)
- [Downloads site](http://sgd-archive.yeastgenome.org/)
- [DNA and protein sequences](http://sgd-archive.yeastgenome.org/sequence)
- [List of dates of Genome Releases](http://downloads.yeastgenome.org/sequence/S288C_reference/dates_of_genome_releases.tab)
- [List of all chromosome sequence changes]()
- [`S288c` genome releases](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/)
- [`S288c` genome `liftOver` chain files](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/)
- [Other yeast strain genomes](http://sgd-archive.yeastgenome.org/sequence/strains)
</details>
<br />
<br />

<a id="breaking-down-the-entriescategories-within-combinedgtf"></a>
## Breaking down the entries/categories within `combined.gtf`
<font size="+2">...and touching on related publications/publications of interest</font>

<a id="yassour-et-al-regev--antisense_transcript-"></a>
### Yassour et al. (Regev) `** antisense_transcript **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

Strand-specific RNA sequencing reveals extensive regulated long antisense transcripts that are conserved across yeast species, *Genome Biol* 2010

<a id="links"></a>
#### Links
- [Publication at genomebiology.com](https://genomebiology.biomedcentral.com/articles/10.1186/gb-2010-11-8-r87)
- [SGD entry for the publication](http://yeastgenome.org/reference/S000136009)
- [GEO Series GSE21739](http://ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21739)

<a id="problem"></a>
#### Problem
- Given when this paper was published, it is not possible for the genomic coordinates to be in the `R64-1-1` system, the coordinate system used in our work.
- Furthermore, it is not clear in the paper what genome they aligned to.
- Given the date of publication, they may have used `R61-1-1 2008_06_05` ( UCSC Genome Browser version `sacCer2`) or perhaps (`R62-1-1 2009_02_18`)&mdash;or perhaps something even earlier than `R61`.

<a id="conclusion"></a>
#### Conclusion
These data are not usable in their current state.
</details>
<br />

<a id="xu-et-al-huber-steinmetz--cut-sut-"></a>
### Xu et al. (Huber, Steinmetz) `** CUT SUT **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

Bidirectional promoters generate pervasive transcription in yeast, *Nature* 2009

<a id="links-1"></a>
#### Links
- [Publication at nature.com](https://www.nature.com/articles/nature07728)
- [ArrayExpress entry for the publication, E-TABM-590](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-TABM-590?query=E-TABM-590)

<a id="details"></a>
#### Details
- CUT features (*not CUT_4X and CUT_2016*) come from `41586_2009_BFnature07728_MOESM276_ESM.xls` (Supplementary Table 3) tab "C".
- SUT features come from `41586_2009_BFnature07728_MOESM276_ESM.xls` (Supplementary Table 3) tab "B".
- (*"ORF-T's" are in tab "A"*.)
- Fasta used for alignment is available here: [steinmetzlab.embl.de/NFRsharing/scAll.fsa](steinmetzlab.embl.de/NFRsharing/scAll.fsa)

<a id="related-methods-entries"></a>
#### Related Methods entries
<a id="array-data-analysis"></a>
##### Array data analysis
Arrays profiled in conditions YPD, YPE and YPGal were normalized with genomic DNA as in \[16\]. Only the probes matching exactly and uniquely to the `S288c` genome were considered further. The normalized data were jointly segmented using a segmentation algorithm \[16\] and the automatically identified segments were curated using a custom web-interface ([Supplementary Information](https://www.nature.com/articles/nature07728#MOESM275)). This defined the set of manually curated transcripts.

To identify CUTs, arrays for the *rrp6Δ* strain were segmented jointly with the arrays of the wild-type strain in the same condition (SDC). `YJM789` arrays were normalized with `YJM789` genomic DNA as a reference. Only the probes matching exactly and uniquely to the `S288c`-aligned part of the `YJM789` sequence were considered further. The normalized data were segmented based on the alignment between `S288c` and `YJM789` \[28\].

<a id="transcript-categorization"></a>
##### Transcript categorization
The manually curated transcripts were overlapped with the genome annotation features and classified as: (1) SUTs, if they did not overlap with existing annotation; (2) ORF-Ts, if they overlapped with a verified or uncharacterized ORF; or (3) other. Transcripts detected solely in rrp6Δ were defined as (4) CUTs (see next section). We refer to the union of SUTs and CUTs also as unannotated transcripts. (5) Antisense transcripts were defined as unannotated transcripts that overlapped with other transcripts on the opposite strand.

<a id="definition-of-cuts"></a>
##### Definition of CUTs
The automatically detected segments for the *rrp6Δ* strain were overlapped with the manually curated transcripts. We defined three criteria: to not overlap any annotated feature; to show higher than twofold expression in *rrp6Δ* compared to wild type; and to be at least 100 bases long. Two types of CUTs were defined. CUTs of the first type were *rrp6Δ* segments that did not overlap any manually curated segments and fulfilled all three criteria. CUTs of the second type were derived from the *rrp6Δ* segments overlapping manually curated transcripts in either a one-to-one or a many-to-one relationship. The *rrp6Δ*-specific (non-overlapping) parts of these segments were classified as CUTs if they fulfilled all criteria.

<a id="question-and-answer"></a>
#### Question and answer
<a id="questionproblem"></a>
##### Question/problem
But what is `scAll.fsa`&mdash;i.e., what version of *S. cerevisiae* `S288c` is this?

<a id="answer"></a>
##### Answer
It appears to be '`S288C_reference_genome_R56-1-1_20070406/S288C_reference_sequence_R56-1-1_20070406.fsa`'

<a id="codeprinted"></a>
###### Code/printed
<details>
<summary><i>Code/printed: Answer</i></summary>

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
    S288C_reference_genome_R56-1-1_20070406/S288C_reference_sequence_R56-1-1_20070406.fsa \
        && echo "no difference"
# no difference
```
</details>
<br />

<a id="conclusion-1"></a>
#### Conclusion
OK, so it looks like they used `R56-1-1`; thus, the coordinates need to be lifted over from `R56-1-1` to `R64-1-1`. Will need [this particular `liftOver` chain file](sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain)
</details>
<br />

<a id="vera-dowell--cut_4x-cut_2016-"></a>
### Vera, Dowell `** CUT_4X, CUT_2016 **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>Survey of cryptic unstable transcripts in yeast, *BMC Genomics* 2016</u>

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
We developed an explicit duration hidden Markov model (HMM) to analyze per nucleotide *rrp6Δ*/WT RNA-seq fold change signal (Fig. 1a) using the `Matlab` HMM toolkit (MATLAB 2012b, The MathWorks Inc., Natick, MA, 2012). The HMM consists of two main states, one parameterized to non-elevated regions of the transcriptome (i.e. not CUTs) and one for elevated (approximately ≥2 fold) regions of the transcriptome (i.e. CUTs). Specifically we expanded the CUT state into nine identical sub-states with unidirectional movement through the model (Additional file 14: Figure S11) thereby setting the minimum length of a CUT to nine nucleotides and producing a 10-State model that approximates a hidden semi-Markov model \[51\]. This allowed us to deviate from the exponential duration modelling of traditional HMMs and produce CUT annotations with a length distribution that better approximated previous studies \[5, 11\]. We note that when the model is used to generate representative sequences, the CUT state of the model produced sequences that are generally long (>34,000 bp) reflecting our bias to identify long regions of relatively consistent elevated coverage. Per nucleotide fold change values were converted to discrete values for analysis by our HMM as necessitated by the Matlab toolkit (Additional file 10: Table S5). Transition and emission probabilities are available in (Additional file 10: Tables S4, S5).

<a id="cut-identification"></a>
###### *CUT identification*
From the HMM we derived an initial set of raw CUT annotations. These raw annotations were filtered to remove snRNAs, snoRNAs, and rRNAs as well as expected hits resulting from genotypic differences in *rrp6Δ* strains relative to WT. Any remaining regions within 450 bp were merged together into a single annotation. Regions with average *rrp6Δ* read coverage less than the upper two-thirds of all nonzero coverage values for that strain and any regions less than 100 nt in length also were removed. Final CUT annotations are available from the GEO repository under accession number GSE74028 at http://www.ncbi.nlm.nih.gov/geo.

<a id="annotation-overlap-and-significance-test"></a>
###### *Annotation overlap and significance test*
We used `IntersectBed` \[50\] to quantify the extent of overlap between our HMM `S288c` CUT annotations and other data sets (Fig. 1b) requiring overlap of ≥25 % the length of either annotation. Because we removed raw HMM CUT annotations that overlapped snRNAs, snoRNAs, and rRNAs, we likewise removed any annotations from Xu et al. \[11\] and Gudipati et al. \[31\] that overlapped the removed raw HMM CUTs in `S288c` to properly reflect the extent of overlap between these data sets and our `S288c` CUTs. Hence only 885 of a total 925 Xu et al. \[11\] CUTs and 1972 of a total 2032 Gudipati et al. \[31\] dis3Δ transcripts were used in subsequent overlap analyses. To determine statistical significant we randomly sampled genomic regions with the same length distribution as `S288c` identified CUTs. After 200 iterations, overlap of these randomly sampled regions and previously annotated CUTs or *dis3Δ* transcripts approximate a normal distribution (Additional file 2: Figure S2B,E). We use two standard deviations from the mean to assess significance within our CUT annotations.

<a id="conserved-cut-expression"></a>
###### *Conserved CUT expression*
First we converted all CUT annotations from strain-specific coordinates to the 4-way alignment coordinate system. Then we calculated a histogram of CUT annotations along the 4-way alignment and all continuous regions ≥1 in the histogram were selected. The total histogram signal over these selected regions was averaged and used to determine the total number of CUTs overlapping that region. Regions with an average histogram signal >4 denoted 4x conserved CUT expression. We identified 208 regions where the CUT annotations were incongruent across the four strains and applied hand edits to resolve these incongruences where possible. Additionally, we examined those CUTs in 3 of the 4 strains and if the CUT is missed in the fourth strain by our filtering procedure (i.e. the fourth strain has a CUT in the raw HMM output) we brought back the filtered CUT annotation and considered these to be 4X conserved CUTs. The resulting changes in CUT annotations are reflected in summaries reported in Fig. 3a. After removing those CUTs with indels (relative to the four-way alignment) for more than 25% the length of the CUT, we derived the conserved expression results reported in Fig. 3c, d. In the case of unique CUTs (Fig. 3d) we only reported those CUTs that did not overlap a raw (but removed) annotation in either of other strains. To determine the significance of our CUT conservation analysis we randomized CUT annotations in all four strains to assess the chance of CUT conservation simply by chance. With 200 iterations, little to no random 4x conserved CUTs were found (Additional file 15: Figure S12).

<a id="question-and-answer-1"></a>
#### Question and answer #1
<a id="question"></a>
##### Question
What's the coordinate system? Does `liftOver` need to be performed?

<a id="answer-1"></a>
##### Answer
From <b>Methods</b> *"Genome sequences and annotations"*: "`S288c` genome and annotations are from the Saccharomyces Genome Database (SGD) `S288c` genome version 64 \[29\]." Thus, `liftOver` does not need to be performed.

<a id="question-and-answer-2"></a>
#### Question and answer #2
<a id="question-1"></a>
##### Question
What are the differences between CUT_2016 and CUT_4X in `combined.gtf`?

<a id="code"></a>
###### Code
<details>
<summary><i>Code: Question</i></summary>

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
</details>
<br />

<a id="answer-2"></a>
##### Answer
Except for the above two entries, they seem to be overwhelmingly the same. It's not clear to me what the two extra "CUT_2016" entried are amid all Vera, Dowell features.

<a id="conclusion-2"></a>
#### Conclusion
Move forward with CUT_4X (more specifically, the entries in [`12864_2016_2622_MOESM5_ESM.xlsx`](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx), i.e., Table S1 from the publication).
</details>
<br />

<a id="van-dijk-et-al-thermes-morillon--xut-"></a>
### van Dijk et al. (Thermes, Morillon) `** XUT **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>XUTs are a class of Xrn1-sensitive antisense regulatory non-coding RNA in yeast, *Nature* 2011</u>

<a id="links-3"></a>
#### Links
- [Pubmed entry for the publication](pubmed.ncbi.nlm.nih.gov/21697827/)
- [Nature page for the publication](https://www.nature.com/articles/nature10118)

<a id="question-and-answer-1"></a>
#### Question and answer
<a id="question-2"></a>
##### Question
What's the coordinate system? Does `liftOver` need to be performed?

<a id="answer-3"></a>
##### Answer
From <b>Online Methods</b>, *"Transcriptome analysis and normalization"*: Genome was annotated according to SGD (http://www.yeastgenome.org/, 5 January 2010); SUT (stable unannotated transcript) and CUT (cryptic unstable transcript) annotations were retrieved \[22\].

According to \[`dates_of_genome_releases.tab` from the SGD\](`#TODO` *link to the file*), the "5 January 2010" release is "`R63-1-1 2010_01_05`".

`#TODO` `liftOver` from `R63` to `R64`

<a id="conclusion-3"></a>
#### Conclusion
1. Download the XUT annotation file (`gff3`)
- [Source page](http://vm-gb.curie.fr/XUT/index.htm)
- [The file proper](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff)
2. "Lift" the file from `R63` coordinates to `R64` coordinates

<a id="miscellaneous"></a>
#### Miscellaneous
There are 1658 entries in [the above `gff3`](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff) (which need to be "lifted" from `R63` to `R64`); for some reason, there are 1657 related records in `combined.gtf`. Just go with the `gff3` from van Dijk et al.
</details>
<br />

<a id="venkatesh-li-gogol-workman--srat-"></a>
### Venkatesh, Li, Gogol, Workman `** SRAT **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>Selective suppression of antisense transcription by Set2-mediated H3K36 methylation, *Nat Comm* 2016</u>

<a id="links-4"></a>
#### Links
- [Nature page for the publication](https://www.nature.com/articles/ncomms13610)

<a id="details-2"></a>
#### Details
<a id="related-methods-entry-1"></a>
##### Related methods entry
From <b>Methods</b> *"Identification of novel transcripts"*: "We aligned the unique reads obtained from the *SET2* deletion strain to the yeast genome (based on sequence dated April 2011 in the Saccharomyces Genome Database (http://www.yeastgenome.org/) and was obtained from the site ftp://ftp.ncbi.nlm.nih.gov/genbank/genomes/Eukaryotes/fungi/Saccharomyces_cerevisiae/SacCer_Apr2011) and identified all transcripts arising from each strand using the `Cufflinks` program. A five-nucleotide read gap was used to separate different transcripts. We used the `BEDtools` bioinformatics suite to refine this list of novel transcripts to remove known coding transcripts and their untranslated regions \[29\], and previously identified pervasive transcripts like the cryptic unstable transcripts (CUTs) \[4,5\], stable unannotated transcripts (SUTs) \[4\], and the Xrn1-sensitive unstable transcripts (XUTs) \[6\]. A discrepancy in these annotations arises from the fact that each transcript class was identified independent of one another, resulting in duplications that have not been resolved. We avoided this pitfall by removing all previously identified transcripts in our novel RNA identification pipeline. The resultant list of 1,179 novel transcripts (Supplementary Data 6) consisted entirely of transcripts from the antisense strand of protein-coding genes. This list was further pared down by estimating the differential expression of these transcripts (using limma in R) and requiring that the following parameters were met. First, to make sure that valid and complete transcripts were being designated, we selected identified transcripts with detectable expression (FPKM>1) either in the wild-type or the *SET2* deletion strain. This requirement also ensured that transcripts with breaks in the reads were removed from the analysis. Second, transcripts with a FDR of <5% (adjusted P value <0.05) were selected. Finally, we instituted a cutoff at twofold increase in the abundance of the transcripts in the *SET2* deletion mutant over the wild-type, to select ones that are upregulated upon loss of Set2. These parameters helped us obtain a list of 853 transcripts that we named SRATs."

<a id="question-and-answer-2"></a>
#### Question and answer
<a id="question-3"></a>
##### Question
What's the coordinate system? Does `liftOver` need to be performed?

<a id="answer-4"></a>
##### Answer
The coordinate system is "`SacCer_Apr2011`"; per [the SGD's official dates of genome releases](http://downloads.yeastgenome.org/sequence/S288C_reference/dates_of_genome_releases.tab), this looks to be the same as `R64-1-1`, which is given a release date of February, 2011. Thus, it seems that the authors used `R64-1-1`.

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
</details>
<br />

<a id="schulz-et-al-cramer--nut-"></a>
### Schulz et al. (Cramer) `** NUT **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>Transcriptome surveillance by selective termination of noncoding RNA synthesis, *Cell* 2013-1121</u>

<a id="project-links"></a>
#### Project links
- [EBI](https://www.ebi.ac.uk/ena/browser/view/PRJEB4393)
- [ArrayExpress](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-1766)

<a id="problemnote"></a>
#### Problem/note
Can't find a list of the ~1526 annotated NUTs: Thus, it's not clear to me how these annotations made it into `combined.gtf`.

However, they appear to be `R64-1-1` coordinates, which we can use...

<a id="evidence-for-the-above"></a>
#### Evidence for the above
<a id="from-extended-experimental-procedures-par-clip-data-analysis"></a>
##### From Extended Experimental procedures, "PAR-CLIP Data Analysis"
Quality-trimmed reads were aligned to the S. cerevisiae genome (`sacCer3`, April 2012) using the short read aligner `Bowtie` with maximum one mismatch and unique matches only (Langmead et al., 2009) (Bowtie
options: `-q -p 4 -S–sam-nohead -v 1 -n 1 -e 70 -l 28 -y -a -m 1–best–strata–phred33-quals`). Subsequently, BAM and PileUp files were generated using the `SAMTools` toolkit (Li et al., 2009).

<a id="from-extended-experimental-procedures-multiplex-chip-seq"></a>
##### From Extended Experimental procedures, "Multiplex ChIP-seq"
Reads were demultiplexed, quality-trimmed (Fastq Quality Filter), and mapped with `Bowtie 1.1.0` (Langmead et al., 2009) to the `SacCer3` genome assembly (Bowtie options: `-q -p 4 -S–sam-nohead -n 1 -e 70 -l 28 -y -m 1–best–strata–phred33-quals`). SAM files were converted into BAM files and read counts for every genomic position calculated using pileup from `SAMtools` (Li et al., 2009).

<a id="related-entry-from-genome-res-paper"></a>
##### Related: Entry from [*Genome Res* paper](https://genome.cshlp.org/content/28/12/1882.full)
It seems the list of NUTs was not made publicly available with the publication of Schulz et al. (Cramer); see [this link](https://genome.cshlp.org/content/28/12/1882.full), particularly the text associated with <b>Methods, List of noncoding RNAs and replication origins</b> in this [paper](https://genome.cshlp.org/content/28/12/1882.full):

"The list of CUTs was obtained from Xu et al. (2009), while the list of NUTs was kindly provided by the Cramer lab (Schulz et al. 2013). Among the NUTs, only those showing at least a twofold increase in +Rap/−Rap were taken into account to unify the threshold of ncRNA definition between CUTs and NUTs. The list of ARS (Supplemental Table S1) consists of the 234 ACS taken from Soriano et al. (2014) that overlap with the replication origins described in Hawkins et al. (2013), for which replication timing and efficiency have been defined. Replication origins with an efficiency <15% were not taken into account."

<a id="solution-email-patrick-cramer-for-the-file"></a>
#### Solution: Email Patrick Cramer for the file
<a id="message-1"></a>
##### Message #1
Tue 4/11/2023 12:41 PM  
From: Alavattam, Kris  
To: patrick.cramer@mpinat.mpg.de  
Cc: office.cramer@mpinat.mpg.de  

Dear Dr. Cramer,

Hi, my name is Kris Alavattam. I am a researcher in the laboratory of Dr. Toshio Tsukiyama, Fred Hutch Cancer Center, Seattle, WA USA. I am writing to inquire about obtaining the annotation file for Nrd1-unterminated transcripts (NUTs) described in your publication Schulz et al., Transcriptome Surveillance by Selective Termination of Noncoding RNA Synthesis, Cell 2013. My apologies if this file is publicly available and I have somehow missed it; I cannot seem to find it. I'll deeply appreciate any help you can provide.

Thank you for your time. Sincerely,  
Kris

Kris Alavattam, PhD  
he/him/his  
Staff Bioinformatician, Tsukiyama Lab  
Basic Sciences Division  
Fred Hutch Cancer Center  
Seattle, WA 98109

<a id="message-2"></a>
##### Message #2
Wed 4/12/2023 12:42 PM  
From: Cramer, Patrick <patrick.cramer@mpinat.mpg.de>  
To: Lidschreiber, Michael <michael.lidschreiber@mpinat.mpg.de>  
Cc: Office, Cramer <office.cramer@mpinat.mpg.de>;Alavattam, Kris  

Dear Michael

Can you point Kris to the right link?

Best Patrick

<a id="message-3"></a>
##### Message #3
Wed 4/12/2023 3:09 PM  
From: Lidschreiber, Michael <michael.lidschreiber@mpinat.mpg.de>  
To: Alavattam, Kris  
Cc: Office, Cramer <office.cramer@mpinat.mpg.de>;Cramer, Patrick <patrick.cramer@mpinat.mpg.de>  

Dear Kris,

Please find the annotation file attached.

Let me know if you need anything else.

Kind regards,  
Michael

<a id="message-4"></a>
##### Message #4
Wed 4/12/2023 5:09 AM  
From: Alavattam, Kris  
To: Lidschreiber, Michael <michael.lidschreiber@mpinat.mpg.de>  
Cc: Office, Cramer <office.cramer@mpinat.mpg.de>;Cramer, Patrick <patrick.cramer@mpinat.mpg.de>  

Thank you very much!

Best,  
Kris

Kris Alavattam, PhD  
he/him/his  
Staff Bioinformatician, Tsukiyama Lab  
Basic Sciences Division  
Fred Hutch Cancer Center  
Seattle, WA 98109
</details>
<br />

<a id="gudipati-et-al-libri--dis3%CE%94-transcripts-"></a>
### Gudipati et al. (Libri) `** dis3Δ transcripts **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>Extensive Degradation of RNA Precursors by the Exosome in Wild-Type Cells, *Mol Cell* 2012</u>

<a id="links-5"></a>
#### Links
- [ArrayExpress E-MTAB-1246](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-1246)
- [Online Mol Cell publication at sciencedirect.com](https://www.sciencedirect.com/science/article/pii/S1097276512007368?)
- [Publication via Europe PMC](https://europepmc.org/article/MED/23000176)
- [Publication entry on the SGD](https://www.yeastgenome.org/reference/S000152662)
- [Review on facultyopinions.com](https://facultyopinions.com/article/717980293#eval793471523)

<a id="problem-1"></a>
#### Problem
Although publications have made use of *dis3∆*-unique transcript annotations in their analyses, the annotations do not appear to be available in an explicit form amid the supplementary files, nor do they appear to be available from ArrayExpress.

<a id="maybe"></a>
#### Maybe
- Assess the paper's <b>Methods</b> section to understand how the transcript annotations were generated.
- Find and include the annotations in our "representative non-coding transcriptome" analyses.
- Would I need to process [this large "processed file" available from ArrayExpress](https://www.ebi.ac.uk/biostudies/files/E-MTAB-1246/normProbeIntensity.txt) in order to obtain transcript annotations?
- It would nice to include these annotations in the "representative non-coding transcriptome"

<a id="email-to-robin-dowell"></a>
#### Email to Robin Dowell
Thu 4/13/2023 9:49 AM  
From: Alavattam, Kris  
To: robin.dowell@colorado.edu  

Dear Dr. Dowell,

Hi, my name is Kris Alavattam. I am a researcher in the laboratory of Toshio Tsukiyama, Fred Hutch Cancer Center, Seattle, WA USA. I am writing to inquire about data associated with experiments performed in your publication Vera and Dowell, Survey of cryptic unstable transcripts in yeast, BMC Genomics 2016.

In Figure 1b, you examine the intersection of your HMM-defined CUTs with dis3∆ transcripts from Gudipati et al. (Extensive degradation of RNA precursors by the exosome in wild type cells, Mol Cell 2012). We are analyzing the expression of cryptic transcripts in our yeast model system and, like you, performing experiments to assess set overlaps with previously described/published yeast cryptic transcripts (indeed, we are including the CUTs called with your HMM model in our study). We would like to assess the dis3∆ transcripts as well and wonder if you have these reprocessed data from Gudipati et al. that you'd be willing to share with us. Many publications, such as yours in the case of the HMM and 4x-conserved CUTs, provide these data in the form of annotations in gtf or gff3 files—do you have similar such data for the dis3∆ transcripts reprocessed from the initial microarray data? Or perhaps in another non-gtf/gff3 form derived from the microarray data published by Gudipati et al.? I'll deeply appreciate any help you can provide.

Thank you for your time. Best,  
Kris

Kris Alavattam, PhD  
he/him/his  
Staff Bioinformatician, Tsukiyama Lab  
Basic Sciences Division  
Fred Hutch Cancer Center  
Seattle, WA 98109
</details>
<br />

<a id="update"></a>
##### Update
Never received a response from Dr. Dowell.

<a id="lidschreiber-easter-et-al-passmore-cramer---"></a>
### Lidschreiber, Easter et al. (Passmore, Cramer) `** ... **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>The APT complex is involved in non-coding RNA transcription and is distinct from CPF, *Nucleic Acids Res* 2018</u>

<a id="how-i-found-this-article"></a>
#### How I found this article
Googled "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" to find out what study the file is associated with. The top result was [the GEO page, GSE114301, for Lidschreiber, Easter et al.](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE114301). Although Steinmetz is not an author on this study, the following annotation files are made available on this page:
- [`GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013.gtf.gz`](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE114301&format=file&file=GSE114301%5FS%2Ecerevisiae%2EmRNA%2EsnRNA%2EsnoRNA%2Eanno%5FSteinmetz%5F2013%2Egtf%2Egz)
- [`GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013_DESeq2_results_table.txt.gz`](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE114301&format=file&file=GSE114301%5FS%2Ecerevisiae%2EmRNA%2EsnRNA%2EsnoRNA%2Eanno%5FSteinmetz%5F2013%5FDESeq2%5Fresults%5Ftable%2Etxt%2Egz)
- [`GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013_rawHTSeq-counts.txt.gz`](https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE114301&format=file&file=GSE114301%5FS%2Ecerevisiae%2EmRNA%2EsnRNA%2EsnoRNA%2Eanno%5FSteinmetz%5F2013%5FrawHTSeq%2Dcounts%2Etxt%2Egz)

<a id="question-4"></a>
#### Question
Is this something I want to follow up on/something we want to include in the "representative non-coding transcriptome"?
</details>
<br />

<a id="yu-et-al-cramer---"></a>
### Yu et al. (Cramer) `** ... **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>Architecture of the RNA polymerase II-Paf1C-TFIIS transcription elongation complex, *Nat Commun* 2017</u>

<a id="links-6"></a>
#### Links
- [PubMed entry](https://pubmed.ncbi.nlm.nih.gov/28585565/)
- [Publication on PubMed](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5467213/)

<a id="how-i-found-this-article-1"></a>
#### How I found this article
To learn about the study associated with "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" and, more importantly, to find out what the annotations are within this file, [I Googled "GSE95556"](https://www.google.com/search?q=GSE95556&oq=GSE95556&aqs=chrome..69i57j0i546l5.257j0j9&sourceid=chrome&ie=UTF-8).
</details>
<br />

<a id="wilkening-et-al-steinmetz---"></a>
### Wilkening et al. (Steinmetz) `** ... **`
<details>
<summary><font size="2"><i>Click to view</i></font></summary>

<u>An efficient method for genome-wide polyadenylation site mapping and RNA quantification, *Nucleic Acids Res* 2013</u>

This seems to be the file that "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" is associated with&mdash;awaiting feedback from Alison regarding this.

`#NOTE` She's not sure&mdash;it is a file first introduced to the lab by Christine.

`#TODO` Follow up on this.
</details>
<br />
<br />

<a id="plan"></a>
## Plan
1. Received the `NUTs` annotation, `Sc.cerevisiae.feature.anno_Schulz_2013.gtf`, from Michael Lidschreiber/Patrick Cramer via email: It already has `R64` coordinates, so no `liftOver` is not necessary.
2. The `CUTs` and `SUTs` annotations are available [here](https://static-content.springer.com/esm/art%3A10.1038%2Fnature07728/MediaObjects/41586_2009_BFnature07728_MOESM276_ESM.xls); coordinates need to be "lifted" from `R56` to `R64` using the file [here](sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain).
3. The `CUT_4X` annotation is available [here](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx), and the `CUT_HMM` annotation from the same paper is available [here (`GSE74028_S288c.CUTs.txt.gz`)](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE74nnn/GSE74028/suppl/GSE74028_S288c.CUTs.txt.gz): It already has `R64` coordinates, so `liftOver` is not necessary.
4. The `XUTs` annotation is available [here](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff) and needs to be lifted from the `R63` to `R64` coordinate system using the file here.
5. The `SRATs` annotation is available [here](static-content.springer.com/esm/art%3A10.1038%2Fncomms13610/MediaObjects/41467_2016_BFncomms13610_MOESM1735_ESM.csv) and is already in the R64 coordinate system
6. Emailed Robin Dowell about potentially obtaining data for the *dis3∆* transcripts from Gudapati et al. (2023-0413)&mdash;~~awaiting a response~~ ***never received a response...***
<br />
<br />

<a id="next-step"></a>
## Next step
Go to [`work_representative-non-coding-transcriptome_part-1.md`](./work_representative-non-coding-transcriptome_part-1.md)
<br />
