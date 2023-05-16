
`work_representative-non-coding-transcriptome_part-3.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [Install liftOver, "lift" XUTs and CUTs/SUTs](#install-liftover-lift-xuts-and-cutssuts)
    1. [Install liftOver, etc.](#install-liftover-etc)
        1. [Code](#code-1)
    1. ["Lift" XUTs, CUTs/SUTs to appropriate coordinate system](#lift-xuts-cutssuts-to-appropriate-coordinate-system)
        1. [Review how to use liftOver](#review-how-to-use-liftover)
            1. [Code](#code-2)
            1. [Printed](#printed)
        1. [Check on the contents of the chain files](#check-on-the-contents-of-the-chain-files)
            1. [Code](#code-3)
            1. [Printed](#printed-1)
        1. [Remove "chr" prefix from chain files](#remove-chr-prefix-from-chain-files)
            1. [Code](#code-4)
        1. [Convert XUTs, CUTs/SUTs to bed](#convert-xuts-cutssuts-to-bed)
            1. [Next steps](#next-steps)
        1. [Perform the "lift overs"](#perform-the-lift-overs)
            1. [Get situated](#get-situated-1)
                1. [Code](#code-5)
            1. [Run liftOver](#run-liftover)
                1. [Code](#code-6)
1. [Next step](#next-step)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="get-situated"></a>
## Get situated
<a id="code"></a>
### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215"
source activate gff3_env
```
</details>
<br />
<br />

<a id="install-liftover-lift-xuts-and-cutssuts"></a>
## Install liftOver, "lift" XUTs and CUTs/SUTs
<a id="install-liftover-etc"></a>
### Install liftOver, etc.
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Install liftOver, etc.</i></summary>

```bash
#!/bin/bash

#  Within gff3_env
install=FALSE
if [[ "${install}" == TRUE ]]; then
    mamba install -c bioconda ucsc-liftover

    mamba install \
        -c conda-forge \
            r-complexupset \
            bioconductor-rtracklayer==1.58.0
fi
```
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
<a id="code-2"></a>
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
<a id="code-3"></a>
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
<a id="code-4"></a>
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
<a id="code-5"></a>
###### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

perform=FALSE
if [[ "${perform}" == TRUE ]]; then
    cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215"
    source activate gff3_env
fi
```
</details>
<br />

<a id="run-liftover"></a>
##### Run liftOver
<a id="code-6"></a>
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
<br />

<a id="next-step"></a>
## Next step
Go to [`work_representative-non-coding-transcriptome_part-4.Rmd`](./work_representative-non-coding-transcriptome_part-4.Rmd)
<br />
