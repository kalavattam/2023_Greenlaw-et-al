
# 2022-11
## RNA-seq: Information on bamCoverage, spike-ins with DESeq2
### Looking into the use of bamCoverage with RNA-seq data
#TODO Return to this line of thinking later; for now, focus on PCR deduplication using UMI-tools and the UMI-containing `.fastq` files from FHCC Bioinformatics
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

### Looking into the use of spike-ins prior to running `DESeq2`
`#TODO (   ) Write up notes later`
- [estimateSizeFactors](https://rdrr.io/bioc/DESeq2/man/estimateSizeFactors.html)
- [Incorporating spike-ins to RNA-seq analysis](https://support.bioconductor.org/p/9143354/)
- [DESeq2 estimateSizeFactors with control genes](https://support.bioconductor.org/p/115682/)
- [...from the DESeq2 vignette](https://bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html#control-features-for-estimating-size-factors)
- [Bioconductor post on how to refer to the spike-in genes when calling `estimateSizeFactors()`](https://support.bioconductor.org/p/103826/)
- [Another Bioconductor post on how to call `controlGenes`](https://support.bioconductor.org/p/130660/)
- [Nice, simple explanation of `controlGenes` and its purpose in this Biostars post](https://www.biostars.org/p/400532/#400543)

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

#### Moving forward
I sent these links to Alison, who will move forward with implementing this.

##### Related email from me to Alison
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Date: Thursday, November 3, 2022 at 2:32 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: More thinking about estimateSizeFactors with controlGenes

While walking around, it occurred to me that you could filter the counts matrix to keep only *K. lactis* genes with row sums above some cutoff or with a row mean higher above some cutoff, which could help to ensure the filtering out of low-expression/high-variance genes. You could even calculate row standard deviation too and keep it below some cutoff to ensure that you’re working with genes that don't vary much from sample to sample.
