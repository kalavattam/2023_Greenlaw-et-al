Links  
- [STAR `--twopassMode None` vs `--twopassMode Basic`](https://www.biostars.org/p/301944/)


Links  
- [Google search results for "W303 reference genome"](https://www.google.com/search?q=W303+reference+genome&rlz=1C5CHFA_enUS949US949&ei=AJSLY43DNMDg0PEPjIKBgAY&ved=0ahUKEwiNw-jYiN77AhVAMDQIHQxBAGAQ4dUDCBA&uact=5&oq=W303+reference+genome&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQogQyBQgAEKIEMgUIABCiBDIFCAAQogQyBQgAEKIEOgoIABBHENYEELADOgUIIRCgAToFCCEQqwJKBAhBGABKBAhGGABQ8ARYygtg4wxoAXABeACAAXOIAf8DkgEDNi4xmAEAoAEByAEIwAEB&sclient=gws-wiz-serp)
    + [ResearchGate: Whole-Genome Sequence and Variant Analysis of W303, a Widely-Used Strain of Saccharomyces cerevisiae](https://www.researchgate.net/publication/317367308_Whole-Genome_Sequence_and_Variant_Analysis_of_W303_a_Widely-Used_Strain_of_Saccharomyces_cerevisiae)
    + [PubMed for the above](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5499129/)
        * [NCBI Biosample for W303 (GCA_002163515.1)](https://www.ncbi.nlm.nih.gov/biosample/SAMN05199423)
        * [NCBI GenBank entry for W303 (GCA_002163515.1)](https://www.ncbi.nlm.nih.gov/assembly/GCA_002163515.1)
        * [NCBI BioProject for W303 (GCA_002163515.1)](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA324291)
        * [NCBI Taxonomy Browser for W303](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=580240)
        * [NCBI page for W303 assemblies (currently, there are three in the database)](https://www.ncbi.nlm.nih.gov/assembly/?term=txid580240[Organism:noexp])    
    + [On how we could identify and filter out *Ty* elements](https://www.nature.com/articles/s41598-017-00414-2#Sec13)
    ```txt
(fr/the M&M associated w/the above link)

Identification of Ty elements

Retrotransposons sequences downloaded from SGD database were subjected to BLASTn against the Sb genomes. The BLAST results obtained were further filtered with query coverage of 90% and best hits were retrieved. Further, the matched regions were screened manually.
```


        * [The *Sci Rep* paper for the above link, which itself could be useful for looking into W303](https://www.nature.com/articles/s41598-017-00414-2)

- [Google search results for "GCA_002163515.1"]
    + There don't seem to be annotations for the assembly; at least, none that I could find
    + Also, one paper (hosted by HAL or something and by a French group) suggested there's a chromosomal inversion on chrXVI for GCA_002163515.1


- [*F1000Research*: "Ten steps to get started in Genome Assembly and Annotation"](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5850084/)
    + Makes use of *S. cerevisiae* W303 (`#QUESTION` which assembly?) in its benchmarking...
    + That reference leads to a rabbit hole that results in [this zenodo entry](https://zenodo.org/record/345098)
- [NCBI GenBank: 2012 WGS for W303 genome assembly](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA167645)
    + Used by/in the above
- [Google search results for '"w303" reference genome "gff"'](https://www.google.com/search?q=%22w303%22+reference+genome+%22gff%22&rlz=1C5CHFA_enUS949US949&biw=1440&bih=796&ei=2paLY66NBvXg0PEP7oGEsAw&ved=0ahUKEwiu4sW0i977AhV1MDQIHe4AAcYQ4dUDCBA&uact=5&oq=%22w303%22+reference+genome+%22gff%22&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIICCEQwwQQoAEyCAghEMMEEKABMgUIIRCrAjIFCCEQqwI6CggAEEcQ1gQQsANKBAhBGABKBAhGGABQ1ANY1ANgggloAXABeACAAWaIAWaSAQMwLjGYAQCgAQHIAQjAAQE&sclient=gws-wiz-serp)
    + [*bioRxiv* 2022: 142 telomere-to-telomere assemblies reveal the genome structural landscape in Saccharomyces cerevisiae](https://www.biorxiv.org/content/10.1101/2022.10.04.510633v1.full.pdf)
    + [PLOS One: "Evolutionary Genomics of Transposable Elements in Saccharomyces cerevisiae"](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0050978)
        * File S3: "GFF file of Repeatmasker/REannotate Ty fragments in the June 2008 version of S. cerevisiae genome from the UCSC Genome Database (sacCer2). Individual fragments from the same element are given the same name in the ID column. The span of the union of fragments is the same as the range of coordinates given in File S2."

- `#IMPORTANT` [SGD sequence files for W303](http://sgd-archive.yeastgenome.org/?prefix=sequence/strains/W303/)
    + The 2017/2018 assembly is not included
    + But the 2012 and 2015 assemblies are and include annotations in the forms of `gff` files