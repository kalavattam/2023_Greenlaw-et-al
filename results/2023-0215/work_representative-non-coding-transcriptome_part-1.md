
`work_representative-non-coding-transcriptome_part-1.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

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
    1. [Include SGD `R64-1-1` ncRNAs](#include-sgd-r64-1-1-ncrnas)
        1. [Notes, code](#notes-code-1)
1. [Next step](#next-step)

<!-- /MarkdownTOC -->
</details>
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
    mkdir -p infiles_gtf-gff3/representation/{NUTs,CUTs_SUTs,CUTs-HMM_CUTs-4X,XUTs,SRATs,ncRNAs}
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

Download manually to `infiles_gtf-gff3/representation/NUTs` from email from Michael Lidschreiber.
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

<a id="include-sgd-r64-1-1-ncrnas"></a>
### Include SGD `R64-1-1` ncRNAs
<a id="notes-code-1"></a>
#### Notes, code
<details>
<summary><i>Notes, code: Include SGD R64-1-1 ncRNAs</i></summary>

`gtf` of SGD `R64-1-1` ncRNAs were processed/isolated from [`saccharomyces_cerevisiae_R64-1-1_20110208.gff`](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz) in [`work_assess-process_R64-1-1_gff3.Rmd`](./work_assess-process_R64-1-1_gff3.Rmd).
```bash
#!/bin/bash

#  Copy ncRNAs to experiment directory
cp \
    outfiles_gtf-gff3/representation/Greenlaw-et-al_ncRNAs.gtf \
    infiles_gtf-gff3/representation/ncRNAs/processed_ncRNA_sense.gtf

#  Give file a shorter name
cp \
    infiles_gtf-gff3/representation/ncRNAs/processed_ncRNA_sense.gtf \
    infiles_gtf-gff3/representation/ncRNAs/ncRNAs.gtf

#NOTE Already in R64 coordinates
```
</details>
<br />
<br />

<a id="next-step"></a>
## Next step
Go to [`work_representative-non-coding-transcriptome_part-2.Rmd`](./work_representative-non-coding-transcriptome_part-2.Rmd)
<br />
