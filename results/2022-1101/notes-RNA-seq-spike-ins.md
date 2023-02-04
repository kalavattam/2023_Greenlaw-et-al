
`#2022-11`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [RNA-seq: Information on `bamCoverage`, spike-ins with `DESeq2`](#rna-seq-information-on-bamcoverage-spike-ins-with-deseq2)
    1. [Looking into the use of `bamCoverage` with RNA-seq data](#looking-into-the-use-of-bamcoverage-with-rna-seq-data)
    1. [Looking into the use of spike-ins prior to running `DESeq2`](#looking-into-the-use-of-spike-ins-prior-to-running-deseq2)
        1. [Related email from me to Alison](#related-email-from-me-to-alison)
        1. [Moving forward](#moving-forward)
            1. [Related email from me to Alison](#related-email-from-me-to-alison-1)
1. [On how to use `DESeq2` with KL-normalized data](#on-how-to-use-deseq2-with-kl-normalized-data)
    1. [First message to Mike Love, author of DESeq2](#first-message-to-mike-love-author-of-deseq2)
    1. [Second message to Mike Love, author of DESeq2](#second-message-to-mike-love-author-of-deseq2)
        1. [Final](#final)
        1. [Second](#second)
        1. [Original](#original)
    1. [Message fr/AG](#message-frag)
    1. [More message w/AG regarding normalization](#more-message-wag-regarding-normalization)
    1. [Messages with Matt and AG regarding UMI deduplication](#messages-with-matt-and-ag-regarding-umi-deduplication)
    1. [Another one for UMIs](#another-one-for-umis)
    1. [Another UMI one](#another-umi-one)
    1. [Notes from discussing things with AG as I put together the first message to `Bioconductor`/Mike Love](#notes-from-discussing-things-with-ag-as-i-put-together-the-first-message-to-bioconductormike-love)
1. [Open tabs related to QC `#TBO`](#open-tabs-related-to-qc-tbo)
1. [Links `#TBO`](#links-tbo)
    1. [Materials examined when formulating `Bioconductor` posts](#materials-examined-when-formulating-bioconductor-posts)
        1. [`Bioconductor` posts](#bioconductor-posts)
        1. [`DESeq2` vignette](#deseq2-vignette)
        1. [`rdrr.io`](#rdrrio)
    1. [`Biostars`](#biostars)
    1. [Material to further look into](#material-to-further-look-into)
1. [Email chains `#TBO`](#email-chains-tbo)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="rna-seq-information-on-bamcoverage-spike-ins-with-deseq2"></a>
## RNA-seq: Information on `bamCoverage`, spike-ins with `DESeq2`
<a id="looking-into-the-use-of-bamcoverage-with-rna-seq-data"></a>
### Looking into the use of `bamCoverage` with RNA-seq data
<a id="todo-return-to-this-line-of-thinking-later-for-now-focus-on-pcr-deduplication-using-umi-tools-and-the-umi-containing-fastq-files-from-fhcc-bioinformatics"></a>
`#TODO` Return to this line of thinking later; for now, focus on PCR deduplication using `umi_tools` and the UMI-containing `.fastq` files from FHCC Bioinformatics
- [Purpose of bamCoverage RPKM normalization methods](https://www.biostars.org/p/9474318/)
- [bamCoverage and RNA-seq data](https://github.com/deeptools/deepTools/issues/401)
- [Normalization with deepTools](https://www.biostars.org/p/473442/)
    + This is super useful!
    + Referenced in the above post as, essentially, what to do: [ATAC-seq sample normalization](https://www.biostars.org/p/413626/#414440)
        * No worries: The principles hold for the bin-based normalization of RNA-seq data too
        * A reference within this post that I should check over: [Normalizing for technical biases](http://bioconductor.org/books/3.13/csawBook/chap-norm.html)
            - "There is a great chapter in Aaron Lun's `csaw` book on normalization in the ChIP-seq (which applies to ATAC-seq as well) context that discusses the various aspects to consider..."
    + Also referenced in the above as "more details of the different normalization methods of bamCoverage": [Deeptools sample scaling](https://www.biostars.org/p/167950/)
    + Also referenced in the above is [bamCoverage and RNA-seq data](https://github.com/deeptools/deepTools/issues/401)

<a id="looking-into-the-use-of-spike-ins-prior-to-running-deseq2"></a>
### Looking into the use of spike-ins prior to running `DESeq2`
`#TODO` Write up notes later
- [estimateSizeFactors](https://rdrr.io/bioc/DESeq2/man/estimateSizeFactors.html)
- [Incorporating spike-ins to RNA-seq analysis](https://support.bioconductor.org/p/9143354/)
- [DESeq2 estimateSizeFactors with control genes](https://support.bioconductor.org/p/115682/)
- [...from the DESeq2 vignette](https://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#control-features-for-estimating-size-factors)
- [Bioconductor post on how to refer to the spike-in genes when calling `estimateSizeFactors()`](https://support.bioconductor.org/p/103826/)
- [Another Bioconductor post on how to call `controlGenes`](https://support.bioconductor.org/p/130660/)
- [Nice, simple explanation of `controlGenes` and its purpose in this Biostars post](https://www.biostars.org/p/400532/#400543)

<a id="related-email-from-me-to-alison"></a>
#### Related email from me to Alison
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Date: Thursday, November 3, 2022 at 1:39 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: FW: A question and a thought

Did a bit more reading: seems like calling `DESeq2::estimateSizeFactors()` with the `controlGenes` option set to our KL genes can be the way to go.
 
So, in that case...
1. when we call the script to split the bam by species, we should output, for each condition, bam files that contains both SC and KL (we should continue to filter out 20S, right?)
2. when we call `DESeq2::estimateSizeFactors()`, we should set the `controlGenes` option to refer to only the KL genes in our dds object; then, when size factors are determined, DESeq2 is going to run calculations that assume KL gene expression is unchanging between conditions
3. the size factors will continue to pertain only to the SC genes (for each condition) and be affected by the unchanging-KL-gene-expression assumption
4. this seems legit to me
 
Let’s try it out! I’ll start working on it after my lunch.
 
-Kris

<a id="moving-forward"></a>
#### Moving forward
I sent these links to Alison, who will move forward with implementing this.

<a id="related-email-from-me-to-alison-1"></a>
##### Related email from me to Alison
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Date: Thursday, November 3, 2022 at 2:32 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: More thinking about estimateSizeFactors with controlGenes

While walking around, it occurred to me that you could filter the counts matrix to keep only *K. lactis* genes with row sums above some cutoff or with a row mean higher above some cutoff, which could help to ensure the filtering out of low-expression/high-variance genes. You could even calculate row standard deviation too and keep it below some cutoff to ensure that you’re working with genes that don't vary much from sample to sample.
<br />
<br />

<a id="on-how-to-use-deseq2-with-kl-normalized-data"></a>
## On how to use `DESeq2` with KL-normalized data

<a id="first-message-to-mike-love-author-of-deseq2"></a>
### First message to Mike Love, author of DESeq2
[Link](https://support.bioconductor.org/p/9149000/)

Hi,

I am working with colleagues to perform differential expression analyses using data that have been spiked with RNA from another species, the purpose of which is to get a sense of the absolute numbers of transcripts that are up and down between conditions. We add the spike-in at the cell stage, prior to the steps of library generation, so the working assumption is that any features or quirks of library generation are equally reflected in the sample and spike-in information.

My question is, "What is the appropriate way to use this spike-in information with DESeq2?" Is it appropriate to use the spike-in information with the DESeq2::estimateSizeFactors() controlGenes argument (e.g., including the thousands of genes for this other species in the counts matrix that is supplied to DESeq2, then supplying the other-species gene names as a vector to the controlGenes)? When following this approach and subsequently running DESeq2::DESeq(), I believe the genes for the other species remain in the counts matrix and are included in the tests for significance, multiple hypothesis testing, etc. So, we should somehow exclude these genes from the counts matrix in the DESeqDataSet object prior to running DESeq2::DESeq()—is that correct?

Another thing we've considered is calculating and applying a simple sample-wise scaling factor prior to running DESeq2 as follows:
1. We calculate a scaling factor for the experiment (EXP) condition: x = (no. EXP sample reads)/(no. EXP spike-in reads)
2. We calculate a scaling factor for the control (CTRL) condition: y = (no. CTRL sample reads)/(no. CTRL spike-in reads)
3. We take a counts matrix such and we divide the sample counts by the corresponding scaling factor, e.g.,
```txt
gene    EXP CTRL
A   5   10
B   15  100
C   0   2
etc.

#  The above becomes...
gene    EXP CTRL
A   5/x     10/y
B   15/x    100/y
C   0/x     2/y
etc.
```
4. We then use the adjusted counts matrix as input for DESeq2.

Does this seem appropriate to you? (However, I don't think DESeq2 accepts non-integer counts in the counts matrix.)

We'll greatly appreciate any input or advice you can give us. Thank you!

-Kris

<a id="second-message-to-mike-love-author-of-deseq2"></a>
### Second message to Mike Love, author of DESeq2
<a id="final"></a>
#### Final
[Link](https://support.bioconductor.org/p/9149231/)

Hi,

I want to clarify what is going on under the hood when a user runs `DESeq2::estimateSizeFactors()` with the `controlGenes` argument. So, if my understanding is correct, all the steps of size-factor estimation take place, except they are applied only to the genes assigned to `controlGenes` (except for the final step, which is to apply the calculated size factor to all sample-wise genes) rather than the default of all genes supplied to `DESeq2::estimateSizeFactors()`—is that right?

*A related follow up question:* Are there any circumstances in which a user that has spike-in `controlGenes` for their samples would ***not*** want to use them?

Thanks,  
Kris

<a id="second"></a>
#### Second
Hi,

I want to clarify what is going on under the hood when a user runs `DESeq2::estimateSizeFactors()` with the `controlGenes` argument. So, if my understanding is correct, all the steps of size-factor estimation take place, except they are applied only to the genes assigned to `controlGenes` (except for the final step, which is to apply the calculated size factor to all sample-wise genes) rather than the default of all genes supplied to `DESeq2::estimateSizeFactors()`—is that right?

A related follow up question: Are there any circumstances in which a user that has spike-in controlGenes for their samples would not want to use them?

For example, we have both *nascent* and *steady-state* RNA-seq data for cycling cells (**C**) and non-cycling cells (**N**). The four samples are spiked with cells from a different species, and these spike-in cells are cycling. We want to perform differential gene expression analyses for **N** versus **C**. We know ahead of time that **N** has markedly lower and different transcription than **C**. They think that it is not appropriate to use the spike-in cells (which are cycling) for `controlGene`-styled size-factor estimation because of this comparison between non-cycling and cycling cells. My thinking is that, because they're expected to be stable across conditions, they ***should*** be used for *steady-state* **N** versus *steady-state* **C**, and *nascent* **N** versus *nascent* **C**. Is this reasonable?

What I am less sure about is steady *steady-state* **N** versus *nascent* **C**, and *nascent* **N** versus *steady-state* **C**—because I am not sure that *nascent* and *steady-state* transcription in the spike-ins is stable across conditions. Is this a situation where a user would not want to use the `controlGene`s? 

Thanks,  
Kris

<a id="original"></a>
#### Original
Hi,

I want to clarify what is going on under the hood when a user runs `DESeq2::estimateSizeFactors()` with the `controlGenes` argument. So, if my understanding is correct, all the steps of size-factor estimation take place, except they are applied only to the genes assigned to `controlGenes` (except for step 7 below, which is applied to all sample-wise genes) rather than the default of all genes supplied to `DESeq2::estimateSizeFactors()`—is that right?

So, put another way, use the `controlGenes`, rather than all genes, to do the following steps:
1. log-transform values
2. average e/row (geometric mean)
3. filter out genes with undefined values
4. subtract row-wise geometric mean fr/log-transformed values
5. take sample-wise median
6. transform median from log to "normal"; resulting value is the scaling factor
7. for each sample, divide original read count by the related scaling factor

*A related follow up question:* Are there any circumstances in which a user that has spike-in `controlGenes` for their samples would ***not*** want to use them?

For example, my colleagues have generated RNA-seq data for cycling cells (**C**) and non-cycling cells (**N**). Both samples are spiked with cells from a different species, and these spike-in cells are cycling. We want to perform differential gene expression analyses for **N** versus **C**. We know ahead of time that **N** has markedly lower and different transcription than **C**. They think that it is not appropriate to use the spike-in cells (which are cycling) for `controlGene`-styled size-factor estimation because of this comparison between non-cycling and cycling cells. Is this indeed a situation where a user would not want to use `controlGene`-styled size-factor estimation?

Thanks,  
Kris


<a id="message-frag"></a>
### Message fr/AG
https://support.bioconductor.org/p/88763/

This suggests `EdgeR` is better for non-integer counts. I am going mess around with getting `EdgeR` to run in case this is the approach we want. 

Alison 


<a id="more-message-wag-regarding-normalization"></a>
### More message w/AG regarding normalization
Message submitted to the `Bioconductor` forum, which is frequented by Mike Love, the author of DESeq2: https://support.bioconductor.org/p/9149000/
 
From: Greenlaw, Alison C <agreenla@fredhutch.org>  
Date: Monday, January 23, 2023 at 11:12 AM  
To: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: Re: Deseq2 math (is confusing)

That’s great news, as I have been thinking about this a lot. Looking forward to another perspective! 
 
Alison

From: Alavattam, Kris <kalavatt@fredhutch.org>  
Sent: Monday, January 23, 2023 11:09:17 AM  
To: Greenlaw, Alison C <agreenla@fredhutch.org>  
Subject: Re: Deseq2 math (is confusing)
 
Hi Alison,
 
Talked with Toshi about it a bit this morning. Probably easier to just chat about this stuff together when you come in.
 
Thanks,  
Kris
 
 
From: Greenlaw, Alison C <agreenla@fredhutch.org>  
Date: Friday, January 20, 2023 at 6:44 PM  
To: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: Deseq2 math (is confusing)

Hi Kris - 
 
This is definitely not urgent, but it's something I am puzzling through and wanted to get my thoughts out on paper about. 
 
There is a big discrepancy based on if I provided size factors or if I let DeSeq2 calculate size factors based on "control genes". I have figured out the reason behind this discrepancy, but I am not sure which way is more correct. 
 
The imagined role of size factors is to account for library size, and is usually calculated by taking sum of reads. This way, smaller libraries get smaller size factors - it's essentially a denominator for analysis so counts from small libraries have a small denominator and large have a large one - this way differential gene expression can be done across library sizes. 
 
So when using "control genes", if we set this multiplier based on the control gene(s) of choice. If for example, sample 1 has 500 counts for control gene 1 and sample 2 has 1000 than, the size factor for sample 1 would be .5 and the size factor for 2 would be 1. So when I feed in KL total counts as control genes (or a handful of KL genes, the results are similar), it is taking that KL amount, and setting it as an indicator of library size and adjusting all counts up or down based on this control gene amount. 
 
When I provide size factors, I calculate the ratio of SC to KL, and then the ratio between samples, so both change in SC and change in KL are accounted for in that number. I think this matters because I don't have the same about of read depth in SC for each sample. 
 
I think method 2 might be better, but I am unsure. It certainly provides more conservative results that Toshi trusts more. 
 
No rush on this but I wanted to articulate the problem while I had a good understanding of it. 
 
Alison


<a id="messages-with-matt-and-ag-regarding-umi-deduplication"></a>
### Messages with Matt and AG regarding UMI deduplication
Ah, I understand. Thanks for explaining!
 
-Kris
 
From: Fitzgibbon, Matthew P <mfitzgib@fredhutch.org>  
Date: Friday, January 20, 2023 at 3:39 PM  
To: Alavattam, Kris <kalavatt@fredhutch.org>, Greenlaw, Alison C <agreenla@fredhutch.org>  
Subject: Re: UMI question + small update

Hi Kris, No, the "/shared/ngs/illumina" volume is really just a hallucination, induced by a piece of software called the automounter. The data really live in Tsukiyama Lab "fast" storage, on a big NAS produced by Dell / Isilon. For example, these two paths:

```txt
/shared/ngs/illumina/agreenla/210216_D00300_1177_BHKCHKBCX3/Unaligned_UMIs/Project_agreenla/
/fh/fast/tsukiyama_t/SR/ngs/illumina/agreenla/210216_D00300_1177_BHKCHKBCX3/Unaligned_UMIs/Project_agreenla/
```
point to the same underlying data. You can think of that second form as the "real" location of the data, and that one will be easier to get to via Samba mounts, "net use" on Windows, etc.
 
Best,  
-Matt
 
From: Alavattam, Kris <kalavatt@fredhutch.org>  
Sent: Friday, January 20, 2023 3:29 PM  
To: Fitzgibbon, Matthew P <mfitzgib@fredhutch.org>; Greenlaw, Alison C <agreenla@fredhutch.org>  
Subject: Re: UMI question + small update
 
Thanks, Matt! That’s good to know. I will keep your message in my records for plannedanalyses with some of these older data. Just for my own knowledge: the directories where you keep the data—the /shared/ngs/illumina/* directories—are they temporary and do we need to move the files out of there?
 
Thanks,  
Kris
 
From: Fitzgibbon, Matthew P <mfitzgib@fredhutch.org>  
Date: Friday, January 20, 2023 at 3:20 PM  
To: Greenlaw, Alison C <agreenla@fredhutch.org>  
Cc: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: Re: UMI question + small update

Hi Alison & Kris, This discussion prompted me to go back through previous Tsukiyama Lab runs to check for UMIs that may have been masked. I found one old HiSeq run for Christine (/shared/ngs/illumina/ccucinot/200128_D00300_0897_BHCHGFBCX3) that is annotated as Ovation SoLo but did not seem to have UMI reads generated in that same directory at all. I've redone the demultiplexing for that run and placed in an Unaligned_UMI folder.
 
All of the other runs that I found with 16bp index reads appear to have R2 files that contain unmasked UMIs as hoped. I checked the following runs:

```txt
/fh/fast/tsukiyama_t/SR/ngs/illumina/agreenla/210216_D00300_1177_BHKCHKBCX3/Unaligned_UMIs/Project_agreenla/
/fh/fast/tsukiyama_t/SR/ngs/illumina/agreenla/220414_VH00699_101_AAAWYTFM5/Unaligned_UMI/Project_agreenla/
/fh/fast/tsukiyama_t/SR/ngs/illumina/agreenla/221010_VH01189_10_AAC57JMM5/Unaligned/Project_agreenla/
/fh/fast/tsukiyama_t/SR/ngs/illumina/agreenla/221220_VH00699_238_AACH7FFM5/Unaligned/Project_agreenla/
/fh/fast/tsukiyama_t/SR/ngs/illumina/ccucinot/180814_D00300_0588_AHKTYJBCX2/Unaligned/Project_ccucinot/
/fh/fast/tsukiyama_t/SR/ngs/illumina/ccucinot/180816_D00300_0592_AHKHHNBCX2/Unaligned/Project_ccucinot/
/fh/fast/tsukiyama_t/SR/ngs/illumina/ccucinot/200128_D00300_0897_BHCHGFBCX3/Unaligned_UMI/Project_ccucinot/
/fh/fast/tsukiyama_t/SR/ngs/illumina/ccucinot/200722_D00300_1007_BHGV5NBCX3/Unaligned_UMI/Project_ccucinot/
/fh/fast/tsukiyama_t/SR/ngs/illumina/jgessama/180316_SN367_1132_BHF3YTBCX2/Unaligned/Project_jgessama/
/fh/fast/tsukiyama_t/SR/ngs/illumina/mspain/171117_SN367_1068_BH2VNMBCX2/Unaligned/Project_mspain/
/fh/fast/tsukiyama_t/SR/ngs/illumina/mspain/180123_SN367_1095_AH7M5FBCX2/Unaligned/Project_mspain/
/fh/fast/tsukiyama_t/SR/ngs/illumina/sswygert/180814_D00300_0588_AHKTYJBCX2/Unaligned/Project_sswygert/
/fh/fast/tsukiyama_t/SR/ngs/illumina/sswygert/180816_D00300_0592_AHKHHNBCX2/Unaligned/Project_sswygert/
```
Let me know if there are any I missed or if data from older runs (e.g. `200128_D00300_0897_BHCHGFBCX3`) are still under active use in the lab. Would like to update anyone who might be interested.
 
Cheers,  
-Matt
 
 
From: Greenlaw, Alison C <agreenla@fredhutch.org>  
Sent: Thursday, January 19, 2023 12:50 PM  
To: Fitzgibbon, Matthew P <mfitzgib@fredhutch.org>  
Subject: Re: UMI question + small update
 
Awesome! Thanks so much for all your help, Matt. I am glad we were able to recover the UMI information!
 
Best, 
Alison 
From: Fitzgibbon, Matthew P <mfitzgib@fredhutch.org>  
Sent: Thursday, January 19, 2023 10:27 AM  
To: Greenlaw, Alison C <agreenla@fredhutch.org>  
Cc: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: Re: UMI question + small update
 
Hi Alison,
 
A few different threads here, so will address a couple first:
 
Found an additional demux setting that I think has successfully recovered the UMIs in those two runs. Basically, you have to explicitly tell the demultiplexer to not "mask" reads shorter than 35bp; we routinely set this to 8bp to prevent the UMIs from being converted to N's but in this case we also needed to change an adapter setting even though we're not doing adapter trimming. The _R2 files in these locations have been updated:
 
```txt
/shared/ngs/illumina/agreenla/221010_VH01189_10_AAC57JMM5/Unaligned/Project_agreenla  
/shared/ngs/illumina/agreenla/221220_VH00699_238_AACH7FFM5/Unaligned/Project_agreenla  
```
None of the other file content (e.g. the _R1 & _R3 reads) should have changed, but I copied everything over as a block anyway just to make sure none of the files get out of phase.
 
Kris, was great to get to meet briefly this morning. The approach of using UMItools to append UMI to read name (then maybe breaking it out to a tag in the BAM file post-alignment) sounds like a good approach. Similar to what some of the single-cell pipelines, like cellranger, do internally.
 
Not sure how this will work for de novo assembly, since need to assemble first, align back to your new transcriptome, then flag duplicates. I think there are "alignment-free" deduplication methods that consider UMIs but don't have recent experience with them. Here's one that a former member of our group used a few years back: https://github.com/vpc-ccg/calib
 
Just for completeness, here is the old Ovation SoLo tool I mentioned when Alison & I talked: https://github.com/tecangenomics/nudup
 
It hasn't seen any substantive update in about six years (and is python2) so the UMItools approach is almost certainly preferred.
 
Let me know how the updated fastq files are looking!
 
Best,  
-Matt
 
Matt Fitzgibbon  
Director, Bioinformatics Shared Resource  
Fred Hutchinson Cancer Center  
Seattle, WA 98109  
mfitzgib@fredhutch.org
 
From: Greenlaw, Alison C <agreenla@fredhutch.org>  
Sent: Wednesday, January 18, 2023 3:00 PM  
To: Fitzgibbon, Matthew P <mfitzgib@fredhutch.org>  
Cc: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: UMI question + small update
 
Hi Matt - 
 
You mentioned when we talked last week that you might have a UMItools script somewhere from nugen. If you are able to find that, it could be great since Kris (CC'ed) is hoping to add that to our de novo annotation pipeline. 
 
You took a peek at my weird RNA seq last week, where one strand of one sample was generating a very large file. It looks like the weird sample (7078_IN) has a higher fraction of low quality alignments, and fewer alignments by total percentage of reads overall compared to other samples in the pool. We are thinking this is likely a technical issue since the 7078_PD sample (pull down aka nascent) does not seem to have this same issue--and these two barcodes were initially from one single frozen yeast cell pellet.
 
I noticed the 7078_IN had 10% of the library pool, where all other samples were between 7.3 and 8.1%. Is there any way that reads that should have been undetermined got assigned to this sample? 
 
Kris and I are currently working to pull out the unaligned and low quality alignments and figure out the source. I was just curious is this issue might have occurred upstream or if you had any additional suggestions of this we could try.
 
Thanks so much for all your help!! 
 
Best,   
Alison

<a id="another-one-for-umis"></a>
### Another one for UMIs
FWIW, some notes I began to take on handling spike-in normalization:  
https://github.com/kalavattam/2022_transcriptome-construction/blob/main/results/2022-1101/notes-RNA-seq-spike-ins.md
 
 
From: Alavattam, Kris <kalavatt@fredhutch.org>  
Date: Thursday, January 19, 2023 at 12:11 PM  
To: Greenlaw, Alison C <agreenla@fredhutch.org>  
Subject: Re: UMI

Let’s see, how about you move on to working with control genes—I’ll take a bit of time to test our options for UMI processing.
 
Thanks,
Kris
 
From: Greenlaw, Alison C <agreenla@fredhutch.org>  
Date: Thursday, January 19, 2023 at 11:57 AM  
To: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: Re: UMI

I’m happy to try the next parts if you want to focus on others things. If you would rather finish it off , I will go back to figuring out control genes! 
 
Alison

From: Alavattam, Kris <kalavatt@fredhutch.org>  
Sent: Thursday, January 19, 2023 11:33:38 AM  
To: Greenlaw, Alison C <agreenla@fredhutch.org>  
Subject: Re: UMI
 
Looks like the info in the Biostars forum you found yesterday works:

```
❯ cd ~/tsukiyamalab/alisong/umi_test
 
❯ zcat 5781_G1_IN_S5_R1.processed.fastq.gz | head
@D00300:1007:HGV5NBCX3:1:1103:1220:2169_GTCGCNNN 1:N:0:NTCGAGAA
TAAAGNGAAGGTACATGAAATGCAAAANTTGATTGGTCTAGCTTCATATG
+
GGGGG#<<GGGIGIGGIGGGGGGGGIG#<<GGGGGGGGGGGGIGGGGAGG
@D00300:1007:HGV5NBCX3:1:1103:1231:2221_ACCAANNN 1:N:0:GTCGAGAA
CTGAANGCATCCATCGTTGAAACTTTCNTCGACGCCGCCTCATCTACTGA
+
GGGAA#<<AGGGGGIIIGGA.AGGGGG#<GGAGGIGIIIAGIGGGIGGIG
@D00300:1007:HGV5NBCX3:1:1103:1395:2129_ACCCCATA 1:N:0:GTCGAGAA
CNATGTGAAGAAAGCGGGCGCAGATGTTGTTATATGCCAATGGGGGTTTG
 
❯ zcat 5781_G1_IN_S5_R1_001.fastq.gz | head
@D00300:1007:HGV5NBCX3:1:1103:1220:2169 1:N:0:NTCGAGAA
TAAAGNGAAGGTACATGAAATGCAAAANTTGATTGGTCTAGCTTCATATG
+
GGGGG#<<GGGIGIGGIGGGGGGGGIG#<<GGGGGGGGGGGGIGGGGAGG
@D00300:1007:HGV5NBCX3:1:1103:1231:2221 1:N:0:GTCGAGAA
CTGAANGCATCCATCGTTGAAACTTTCNTCGACGCCGCCTCATCTACTGA
+
GGGAA#<<AGGGGGIIIGGA.AGGGGG#<GGAGGIGIIIAGIGGGIGGIG
@D00300:1007:HGV5NBCX3:1:1103:1395:2129 1:N:0:GTCGAGAA
CNATGTGAAGAAAGCGGGCGCAGATGTTGTTATATGCCAATGGGGGTTTG
```

I’ll move forward with the UMI processing.
 
-Kris
 
From: Greenlaw, Alison C <agreenla@fredhutch.org>  
Date: Wednesday, January 18, 2023 at 4:38 PM  
To: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: Re: UMI

`~/tsukiyamalab/alisong/umi_test`
 
From: Greenlaw, Alison C  
Sent: Wednesday, January 18, 2023 4:23 PM  
To: Alavattam, Kris <kalavatt@fredhutch.org>  
Subject: UMI
 
https://www.biostars.org/p/357359/  
add UMI sequences to fastq read name - Biostar: S  


<a id="another-umi-one"></a>
### Another UMI one
That’s great news! Thanks so much for your help! 

Alison


From: Alavattam, Kris <kalavatt@fredhutch.org>  
Sent: Thursday, January 19, 2023 9:50:52 AM  
To: Greenlaw, Alison C <agreenla@fredhutch.org>  
Cc: Tsukiyama, Toshio <ttsukiya@fredhutch.org>  
Subject: Response from Matt regarding the UMI issue
 
 
Hi Alison,  
cc Toshi
 
Good news! Matt stopped by the lab this morning. He still has the raw sequencing data output by the Illumina sequencer, and he is working on resolving our issues now. It turns out that, for some reason he’s not entirely sure of, a certain parameter needed to have been set when he was doing the demultiplexing/UMI-generation work—even though this particular parameter did not need to be set with previous demultiplexing/UMI-generation work (e.g., the work associated with the WT-Q-vs-G1 and TRF4 datasets).
 
He told me that the umitools strategy that you found on the Biostars forum yesterday is essentially the proper way to use that tool with these kinds of data (i.e., sequencing data organized in R1, R2, R3 files). Also, he’s also going to send us a link to the repo containing the tecan approach to UMI processing. He noted that, because the tecan approach is written in an outdated language (Python 2) and is no longer maintained by the authors, he recommends using the umitools approach.
 
To make the work a little easier for him, I told him it’s OK to copy all the sequencing files to your directory wholesale (i.e., R1, R2, R3, I1, and I2) rather than just selectively copying R2 alone to specific directories within your project directories. From there, we can do clean up and reorganization for the project directories as necessary.
 
We talked about the transcriptome assembly work a bit too, and I explained to Matt why I wanted to use these PCR duplicate-corrected files in our Trinity parameterization experiments. He understood and agreed with the reasoning.
 
Anyway, we should expect to get the updated files and the link to the tecan repo sometime later today.
 
Thanks,  
Kris


<a id="notes-from-discussing-things-with-ag-as-i-put-together-the-first-message-to-bioconductormike-love"></a>
### Notes from discussing things with AG as I put together the first message to `Bioconductor`/Mike Love
We want to assess the significant differences in normalized EXP versus normalize CTRL, e.g., assigning

Given that we've depleted a tx termination factor, many genes have increased tx; however, where to set is not functionally obvious.


Purpose of a spike-in: To account for the total amount of tx or RNA per cell is the same

We do the spike-in at the cell level; any changes thereafter, we can theoretically hope that it'll be reflected in sequences for both, and we 


Given our conditions, we suspect that genes are more upregulated than are downregulated, but how can we reasonably find the "unchanging points." Inputting these spike-in sequences with the controlGenes gives drastic results: More than half of all the genes in the genome are statistically significantly unregulated. This seems extreme to us, although it could be true.

Suggestion that's mathematically appropriate and precise, rather than--just b/c it seems like this is not the norm for how people use DESeq2, and it's not easy to Google this and come up with an answer
<br />
<br />

<a id="open-tabs-related-to-qc-tbo"></a>
## Open tabs related to QC `#TBO`
- [On converting `bam`s to `fastq`s](https://www.metagenomics.wiki/tools/samtools/converting-bam-to-fastq)
- [Alignment QC of RNA-seq data (Griffith Lab)](https://rnabio.org/module-02-alignment/0002/06/01/Alignment_QC/#)
<br />
<br />

<a id="links-tbo"></a>
## Links `#TBO`
<a id="materials-examined-when-formulating-bioconductor-posts"></a>
### Materials examined when formulating `Bioconductor` posts
<a id="bioconductor-posts"></a>
#### `Bioconductor` posts
- [`ControlGenes`/housekeeping genes `DESeq2`](https://support.bioconductor.org/p/130660/)
    + Another Bioconductor post on how to call `controlGenes`
- [Normalize to a housekeeping gene in `DESEq2`](https://support.bioconductor.org/p/p133150/)
- [Housekeeping genes vary across contrast groups, using `DESeq2` on NanoString data](https://support.bioconductor.org/p/9141678/)
- [Incorporating spike-ins to RNA-seq analysis](https://support.bioconductor.org/p/9143354/)
- [`DESeq2` `estimateSizeFactors` with control genes](https://support.bioconductor.org/p/115682/)
- [`DESeq2` `estimateSizeFactors` `controlGenes` return an error](https://support.bioconductor.org/p/103826/)
    + `Bioconductor` post on how to refer to the spike-in genes when calling `estimateSizeFactors()`

<a id="deseq2-vignette"></a>
#### `DESeq2` vignette
- [Control features for estimating size factors](http://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#control-features-for-estimating-size-factors)

<a id="rdrrio"></a>
#### `rdrr.io`
- [`estimateSizeFactors`](https://rdrr.io/bioc/DESeq2/man/estimateSizeFactors.html)

<a id="biostars"></a>
### `Biostars`
- [How to contrast gene expression level using like control some HouseKeeping Genes after a DEG using DESEQ2](https://www.biostars.org/p/400532/#400543)
    + Nice, simple explanation of `controlGenes` and its purpose in this `Biostars` post

<a id="material-to-further-look-into"></a>
### Material to further look into
- [`RUVg` (`RUVSeq`) seems to be something useful and worth considering for our work](https://www.google.com/search?q=ruvg+normalization&oq=ruvg+normalization&aqs=chrome..69i57.2410j0j7&sourceid=chrome&ie=UTF-8)
- [Confused about using `RUVg` in getting negative control genes using `RUVg` (`Bioconductor`)](https://support.bioconductor.org/p/9144949/)
<br />
<br />

<a id="email-chains-tbo"></a>
## Email chains `#TBO`
- [Using `DESeq2` scaling factors in the generation of `bigwig`s](https://outlook.office.com/mail/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQALWZ%2F1g2TixHsmcItlSvLMw%3D)
    + Me to Alison
    + 2023-0124
- [`DESeq2` math (is confusing)](https://outlook.office.com/mail/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQABU533NW37pKvXRIDCuLO70%3D)
    + Between me and Alison
    + 2023-0120-0124
- [Variance](https://outlook.office.com/mail/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQAAXbHUPN%2FzZFj8Q5y42kbhE%3D)
    + Between me and Alison
    + 2022-1115-1117
- [Code snippet for making a dds from counts matrix, then `rlog`-transforming it, then...](https://outlook.office.com/mail/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQAMOGut2ppC9NggrVTSmvfb8%3D)
    + Between me and Alison
    + 2022-1115
- [A question and a thought](https://outlook.office.com/mail/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQAElsJPNmy%2FBIqpkqHwG4Dg8%3D)
    + Between me and Alison
    + 2022-1103
- [More thinking about `estimateSizeFactors` with `controlGenes`](https://outlook.office.com/mail/id/AAQkAGQ2MWM4OTBhLWZjNTItNGFlZS05OTg3LTA2MTA2NjJkNzU3ZAAQABQLBQokcp1Huq5me3WutFU%3D)
    + Between me and Alison
    + 2022-1103
