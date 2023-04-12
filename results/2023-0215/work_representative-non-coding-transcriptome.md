

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
<br />

## Breaking down the entries/categories within `combined.gtf`
### Yassour et al. (Regev) `** antisense_transcript **`
Strand-specific RNA sequencing reveals extensive regulated long antisense transcripts that are conserved across yeast species, *Genome Biol* 2010

#### `#LINKS`
- [SGD entry for the publication](yeastgenome.org/reference/S000136009)
- [GEO Series GSE21739](ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE21739)

#### `!!PROBLEM!!`
- Given when this paper was published, it is not possible for the genomic coordinates to be in the R64-1-1 system, the coordinate system used in our work.
- Furthermore, it is not clear in the paper what genome they aligned to.
- Given the date of publication, they may have used R61-1-1 (2008_06_05 UCSC Genome Browser version sacCer2) or perhaps (R62-1-1 2009_02_18)&mdash;or perhaps something even earlier than R61.

#### `#CONCLUSION`
These data are not usable in their current state.
<br />
<br />

### Xu et al. (Huber, Steinmetz) `** CUT SUT **`
Bidirectional promoters generate pervasive transcription in yeast, *Nature* 2009

#### `#LINKS`
- [Publication at nature.com](https://www.nature.com/articles/nature07728)
- [ArrayExpress entry for the publication, E-TABM-590](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-TABM-590?query=E-TABM-590)

#### `#DETAILS`
- CUT features (*not CUT_4X and CUT_2016*) come from `41586_2009_BFnature07728_MOESM276_ESM.xls` (Supplementary Table 3) tab "C"
- SUT features come from `41586_2009_BFnature07728_MOESM276_ESM.xls` (Supplementary Table 3) tab "B"
- (*"ORF-T's" are in tab "A"*)
- Fasta used for alignment is available here: [steinmetzlab.embl.de/NFRsharing/scAll.fsa](steinmetzlab.embl.de/NFRsharing/scAll.fsa)

#### Related Methods entries
##### Array data analysis
Arrays profiled in conditions YPD, YPE and YPGal were normalized with genomic DNA as in \[16\]. Only the probes matching exactly and uniquely to the S288c genome were considered further. The normalized data were jointly segmented using a segmentation algorithm \[16\] and the automatically identified segments were curated using a custom web-interface ([Supplementary Information](https://www.nature.com/articles/nature07728#MOESM275)). This defined the set of manually curated transcripts.

To identify CUTs, arrays for the *rrp6Δ* strain were segmented jointly with the arrays of the wild-type strain in the same condition (SDC). YJM789 arrays were normalized with YJM789 genomic DNA as a reference. Only the probes matching exactly and uniquely to the S288c-aligned part of the YJM789 sequence were considered further. The normalized data were segmented based on the alignment between S288c and YJM789 \[28\].

##### Transcript categorization
The manually curated transcripts were overlapped with the genome annotation features and classified as: (1) SUTs, if they did not overlap with existing annotation; (2) ORF-Ts, if they overlapped with a verified or uncharacterized ORF; or (3) other. Transcripts detected solely in rrp6Δ were defined as (4) CUTs (see next section). We refer to the union of SUTs and CUTs also as unannotated transcripts. (5) Antisense transcripts were defined as unannotated transcripts that overlapped with other transcripts on the opposite strand.

##### Definition of CUTs
The automatically detected segments for the *rrp6Δ* strain were overlapped with the manually curated transcripts. We defined three criteria: to not overlap any annotated feature; to show higher than twofold expression in *rrp6Δ* compared to wild type; and to be at least 100 bases long. Two types of CUTs were defined. CUTs of the first type were *rrp6Δ* segments that did not overlap any manually curated segments and fulfilled all three criteria. CUTs of the second type were derived from the *rrp6Δ* segments overlapping manually curated transcripts in either a one-to-one or a many-to-one relationship. The *rrp6Δ*-specific (non-overlapping) parts of these segments were classified as CUTs if they fulfilled all criteria.

#### `#QUESTION` and `#ANSWER`
##### `#QUESTION`
`!! PROBLEM !!` But what is `scAll.fsa`&mdash;i.e., what version of *S. cerevisiae* S288c is this?

##### `#ANSWER`
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

#### `#CONCLUSION`
OK, so it looks like they used R56-1-1; thus, the coordinates need to be lifted over from R56-1-1 to R64-1-1. Will need [this particular liftOver chain file](sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain)
<br />
<br />

### Vera, Dowell `** CUT_4X, CUT_2016 **`
Survey of cryptic unstable transcripts in yeast, *BMC Genomics* 2016

#### `#LINKS`
- [Publication at BMC Genomics](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-016-2622-5)
- CUT annotation from the paper: [`12864_2016_2622_MOESM5_ESM.xlsx`](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx) (Table S1)

#### `#DETAILS`
##### Related Methods entry
###### *Explicit duration hidden Markov model*
We developed an explicit duration hidden Markov model (HMM) to analyze per nucleotide rrp6Δ/WT RNA-seq fold change signal (Fig. 1a) using the Matlab HMM toolkit (MATLAB 2012b, The MathWorks Inc., Natick, MA, 2012). The HMM consists of two main states, one parameterized to non-elevated regions of the transcriptome (i.e. not CUTs) and one for elevated (approximately ≥2 fold) regions of the transcriptome (i.e. CUTs). Specifically we expanded the CUT state into nine identical sub-states with unidirectional movement through the model (Additional file 14: Figure S11) thereby setting the minimum length of a CUT to nine nucleotides and producing a 10-State model that approximates a hidden semi-Markov model \[51\]. This allowed us to deviate from the exponential duration modelling of traditional HMMs and produce CUT annotations with a length distribution that better approximated previous studies \[5, 11\]. We note that when the model is used to generate representative sequences, the CUT state of the model produced sequences that are generally long (>34,000 bp) reflecting our bias to identify long regions of relatively consistent elevated coverage. Per nucleotide fold change values were converted to discrete values for analysis by our HMM as necessitated by the Matlab toolkit (Additional file 10: Table S5). Transition and emission probabilities are available in (Additional file 10: Tables S4, S5).

###### *CUT identification*
From the HMM we derived an initial set of raw CUT annotations. These raw annotations were filtered to remove snRNAs, snoRNAs, and rRNAs as well as expected hits resulting from genotypic differences in *rrp6Δ* strains relative to WT. Any remaining regions within 450 bp were merged together into a single annotation. Regions with average *rrp6Δ* read coverage less than the upper two-thirds of all nonzero coverage values for that strain and any regions less than 100 nt in length also were removed. Final CUT annotations are available from the GEO repository under accession number GSE74028 at http://www.ncbi.nlm.nih.gov/geo.

###### *Annotation overlap and significance test*
We used IntersectBed \[50\] to quantify the extent of overlap between our HMM S288c CUT annotations and other data sets (Fig. 1b) requiring overlap of ≥25 % the length of either annotation. Because we removed raw HMM CUT annotations that overlapped snRNAs, snoRNAs, and rRNAs, we likewise removed any annotations from Xu et al. \[11\] and Gudipati et al. \[31\] that overlapped the removed raw HMM CUTs in S288c to properly reflect the extent of overlap between these data sets and our S288c CUTs. Hence only 885 of a total 925 Xu et al. \[11\] CUTs and 1972 of a total 2032 Gudipati et al. \[31\] dis3Δ transcripts were used in subsequent overlap analyses. To determine statistical significant we randomly sampled genomic regions with the same length distribution as S288c identified CUTs. After 200 iterations, overlap of these randomly sampled regions and previously annotated CUTs or dis3Δ transcripts approximate a normal distribution (Additional file 2: Figure S2B,E). We use two standard deviations from the mean to assess significance within our CUT annotations.

###### *Conserved CUT expression*
First we converted all CUT annotations from strain-specific coordinates to the 4-way alignment coordinate system. Then we calculated a histogram of CUT annotations along the 4-way alignment and all continuous regions ≥1 in the histogram were selected. The total histogram signal over these selected regions was averaged and used to determine the total number of CUTs overlapping that region. Regions with an average histogram signal >4 denoted 4x conserved CUT expression. We identified 208 regions where the CUT annotations were incongruent across the four strains and applied hand edits to resolve these incongruences where possible. Additionally, we examined those CUTs in 3 of the 4 strains and if the CUT is missed in the fourth strain by our filtering procedure (i.e. the fourth strain has a CUT in the raw HMM output) we brought back the filtered CUT annotation and considered these to be 4X conserved CUTs. The resulting changes in CUT annotations are reflected in summaries reported in Fig. 3a. After removing those CUTs with indels (relative to the four-way alignment) for more than 25% the length of the CUT, we derived the conserved expression results reported in Fig. 3c, d. In the case of unique CUTs (Fig. 3d) we only reported those CUTs that did not overlap a raw (but removed) annotation in either of other strains. To determine the significance of our CUT conservation analysis we randomized CUT annotations in all four strains to assess the chance of CUT conservation simply by chance. With 200 iterations, little to no random 4x conserved CUTs were found (Additional file 15: Figure S12).

#### `#QUESTION` and `#ANSWER` #1
##### `#QUESTION`
What's the coordinate system? Does liftOver need to be performed?

##### `#ANSWER`
from <b>Methods</b> *"Genome sequences and annotations"*: "S288c genome and annotations are from the Saccharomyces Genome Database (SGD) S288c genome version 64 \[29\]."

Thus, liftOver does not need to be performed.

#### `#QUESTION` and `#ANSWER` #2
##### `#QUESTION`
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

##### `#ANSWER`
Except for the above two entries, they seem to be overwhelmingly the same. It's not clear to me what is the two extra "CUT_2016" amid all Vera, Dowel features; 

#### `#CONCLUSION`
Move forward with CUT_4X (more specifically, the entries in [`12864_2016_2622_MOESM5_ESM.xlsx`](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx), i.e., Table S1 from the publication)
<br />
<br />

### van Dijk et al. (Thermes, Morillon) `** XUT **`
XUTs are a class of Xrn1-sensitive antisense regulatory non-coding RNA in yeast, *Nature* 2011

#### `#LINKS`
- [Pubmed entry for the publication](pubmed.ncbi.nlm.nih.gov/21697827/)
- [Nature page for the publication](https://www.nature.com/articles/nature10118)

#### `#QUESTION` and `#ANSWER`
##### `#QUESTION`
What's the coordinate system? Does liftOver need to be performed?

##### `#ANSWER`
From <b>Online Methods</b>, *"Transcriptome analysis and normalization"*: Genome was annotated according to SGD (http://www.yeastgenome.org/, 5 January 2010); SUT (stable unannotated transcript) and CUT (cryptic unstable transcript) annotations were retrieved \[22\].

According to [`dates_of_genome_releases.tab` from the SGD], the "5 January 2010" release is "R63-1-1 2010_01_05".
#TODO liftOver from R63 to R64

#### `#CONCLUSION`
1. Download the XUT annotation file (gff3)
- [Source page](http://vm-gb.curie.fr/XUT/index.htm)
- [The file proper](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff)
2. "Lift" the file from R63 coordinates to R64 coordinates

#### `#MISCELLANEOUS`
There are 1658 entries in [the above gff3](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff) (which need to be "lifted" from R63 to R64); for some reason, there are 1657 related records in `combined.gtf`. Just go with the gff3 from van Dijk et al.
<br />

### Venkatesh, Li, Gogol, Workman `** SRAT **`
Selective suppression of antisense transcription by Set2-mediated H3K36 methylation, *Nat Comm* 2016

#### `#LINKS`
- [Nature page for the publication](https://www.nature.com/articles/ncomms13610)

#### `#DETAILS`
##### Related methods entry
From <b>Methods</b> *"Identification of novel transcripts"*: "We aligned the unique reads obtained from the *SET2* deletion strain to the yeast genome (based on sequence dated April 2011 in the Saccharomyces Genome Database (http://www.yeastgenome.org/) and was obtained from the site ftp://ftp.ncbi.nlm.nih.gov/genbank/genomes/Eukaryotes/fungi/Saccharomyces_cerevisiae/SacCer_Apr2011) and identified all transcripts arising from each strand using the Cufflinks program. A five-nucleotide read gap was used to separate different transcripts. We used the BEDtools bioinformatics suite to refine this list of novel transcripts to remove known coding transcripts and their untranslated regions \[29\], and previously identified pervasive transcripts like the cryptic unstable transcripts (CUTs) \[4,5\], stable unannotated transcripts (SUTs) \[4\], and the Xrn1-sensitive unstable transcripts (XUTs) \[6\]. A discrepancy in these annotations arises from the fact that each transcript class was identified independent of one another, resulting in duplications that have not been resolved. We avoided this pitfall by removing all previously identified transcripts in our novel RNA identification pipeline. The resultant list of 1,179 novel transcripts (Supplementary Data 6) consisted entirely of transcripts from the antisense strand of protein-coding genes. This list was further pared down by estimating the differential expression of these transcripts (using limma in R) and requiring that the following parameters were met. First, to make sure that valid and complete transcripts were being designated, we selected identified transcripts with detectable expression (FPKM>1) either in the wild-type or the *SET2* deletion strain. This requirement also ensured that transcripts with breaks in the reads were removed from the analysis. Second, transcripts with a FDR of <5% (adjusted P value <0.05) were selected. Finally, we instituted a cutoff at twofold increase in the abundance of the transcripts in the *SET2* deletion mutant over the wild-type, to select ones that are upregulated upon loss of Set2. These parameters helped us obtain a list of 853 transcripts that we named SRATs."

#### `#QUESTION` and `#ANSWER`
##### `#QUESTION`
What's the coordinate system? Does liftOver need to be performed?

##### `#ANSWER`
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

#### `#CONCLUSION`
Download the SRAT annotations: [`41467_2016_BFncomms13610_MOESM1735_ESM.csv`](static-content.springer.com/esm/art%3A10.1038%2Fncomms13610/MediaObjects/41467_2016_BFncomms13610_MOESM1735_ESM.csv) (Supplementary Data 1)
<br />
<br />

### Schulz et al. (Cramer) `** NUT **`
Transcriptome surveillance by selective termination of noncoding RNA synthesis, *Cell* 2013-1121

https://www.ebi.ac.uk/ena/browser/view/PRJEB4393
https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-1766

!!PROBLEM!! #NOTE Can't find a list of the ~1526 annotated NUTs: Thus, it's not clear to me how these annotations made it into combined.gtf; however, they appear to be R64-1-1 coordinates, which we can use...

#EVIDENCE
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


#INTERESTING (https://genome.cshlp.org/content/28/12/1882.full)
It seems the list of NUTs was not made publicly available with the publication of Schulz et al. (Cramer); see https://genome.cshlp.org/content/28/12/1882.full, particularly Methods, List of noncoding RNAs and replication origins: "The list of CUTs was obtained from Xu et al. (2009), while the list of NUTs was kindly provided by the Cramer lab (Schulz et al. 2013). Among the NUTs, only those showing at least a twofold increase in +Rap/−Rap were taken into account to unify the threshold of ncRNA definition between CUTs and NUTs. The list of ARS (Supplemental Table S1) consists of the 234 ACS taken from Soriano et al. (2014) that overlap with the replication origins described in Hawkins et al. (2013), for which replication timing and efficiency have been defined. Replication origins with an efficiency <15% were not taken into account."
<br />
<br />

### Gudipati et al. (Libri) `** dis3Δ transcripts **`
Extensive Degradation of RNA Precursors by the Exosome in Wild-Type Cells, *Mol Cell* 2012

#### Links
- [ArrayExpress E-MTAB-1246](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-1246)
- [Online Mol Cell publication at sciencedirect.com](https://www.sciencedirect.com/science/article/pii/S1097276512007368?)
- [Publication via Europe PMC](https://europepmc.org/article/MED/23000176)
- [Publication entry on the SGD](https://www.yeastgenome.org/reference/S000152662)
- [Review on facultyopinions.com](https://facultyopinions.com/article/717980293#eval793471523)

#### `!! PROBLEM !!`
Although publications have made use of dis3∆-unique transcript annotations in their analyses, these do not appear to be available in an explicit form amid the supplementary files, nor does it appear to be available from ArrayExpress.

#### `#MAYBE`
- Assess the paper's <b>Methods</b> section to understand how the transcript annotations were generated.
- Find and include the annotations in our "representative non-coding transcriptome" analyses.
- Would I need to process [this large "processed file" available from ArrayExpress](https://www.ebi.ac.uk/biostudies/files/E-MTAB-1246/normProbeIntensity.txt) in order to obtain transcript annotations?
- It would nice to include these annotations in the "representative non-coding transcriptome"
<br />
<br />

### Lidschreiber, Easter et al. (Passmore, Cramer) `**  **`
The APT complex is involved in non-coding RNA transcription and is distinct from CPF, *Nucleic Acids Res* 2018

#### How I found this article
Googled "GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf" to find out what study the file is associated with. The top result was [the GEO page, GSE114301, for Lidschreiber, Easter et al.](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE114301). Although Steinmetz is not an author on this study, the following annotation files are made available on this page:
- `GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013.gtf.gz`
- `GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013_DESeq2_results_table.txt.gz`
- `GSE114301_S.cerevisiae.mRNA.snRNA.snoRNA.anno_Steinmetz_2013_rawHTSeq-counts.txt.gz`

#### `#QUESTION`
Is this something I want to follow up on/something we want to include in the "representative non-coding transcriptome?"
<br />
<br />

### Yu et al. (Cramer) `...`
Architecture of the RNA polymerase II-Paf1C-TFIIS transcription elongation complex, *Nat Commun* 2017

#### Links
- [PubMed entry](https://pubmed.ncbi.nlm.nih.gov/28585565/)
- [Publication on PubMed](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5467213/)

#### How I found this article
To learn about the study associated "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" and, more importantly, what are the annotations within this file, [I Googled "GSE95556"](https://www.google.com/search?q=GSE95556&oq=GSE95556&aqs=chrome..69i57j0i546l5.257j0j9&sourceid=chrome&ie=UTF-8).
<br />
<br />

### Wilkening et al. (Steinmetz) `...`
An efficient method for genome-wide polyadenylation site mapping and RNA quantification, Nucleic Acids Res 2013

This seems to be the file that "`GSE95556_Sc.cerevisiae.feature.anno_Steinmetz_2013.gtf`" is associated with&mdash;awaiting feedback from Alison regarding this. `#NOTE` She's not sure&mdash;it is a file first introduced to the lab by Christine.
<br />
<br />
<br />

## Summary
1. Received the `NUTs` annotation, `Sc.cerevisiae.feature.anno_Schulz_2013.gtf`, from Michael Lidschreiber/Patrick Cramer via email: It already has R64 coordinates, so no liftOver is not necessary.
2. The `CUTs` and `SUTs` annotations are available [here](https://static-content.springer.com/esm/art%3A10.1038%2Fnature07728/MediaObjects/41586_2009_BFnature07728_MOESM276_ESM.xls); coordinates need to be "lifted" from R56 to R64 using the file [here](sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/liftover/V56_2007_04_06_V64_2011_02_03.over.chain).
3. The `CUT_4X` annotation is available [here](https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-016-2622-5/MediaObjects/12864_2016_2622_MOESM5_ESM.xlsx), and the `CUT_HMM` annotation from the same paper is available [here (`GSE74028_S288c.CUTs.txt.gz`)](https://ftp.ncbi.nlm.nih.gov/geo/series/GSE74nnn/GSE74028/suppl/GSE74028_S288c.CUTs.txt.gz): It already has R64 coordinates, so liftOver is not necessary.
4. The `XUTs` annotation is available [here](http://vm-gb.curie.fr/XUT/XUTs_Van_Dijk_et_al_2011.gff) and needs to be lifted from the R63 to R64 coordinate system.
5. The `SRATs` annotation is available [here](static-content.springer.com/esm/art%3A10.1038%2Fncomms13610/MediaObjects/41467_2016_BFncomms13610_MOESM1735_ESM.csv) and is already in the R64 coordinate system
6. 