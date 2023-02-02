
`#test_UMI-processing.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [Experiment description](#experiment-description)
    1. [Documentation for `AnnotateBamWithUmis`](#documentation-for-annotatebamwithumis)
        1. [Printed](#printed)
1. [Try a trial run with `AnnotateBamWithUmis`](#try-a-trial-run-with-annotatebamwithumis)
    1. [Make a directory for the trial with `AnnotateBamWithUmis`](#make-a-directory-for-the-trial-with-annotatebamwithumis)
        1. [Code](#code-1)
    1. [Locations of datasets](#locations-of-datasets)
    1. [Set up necessary variables](#set-up-necessary-variables)
        1. [Code](#code-2)
    1. [Run the command](#run-the-command)
        1. [Code](#code-3)
        1. [Printed](#printed-1)
1. [Try another experiment](#try-another-experiment)
    1. [Get situated](#get-situated-1)
        1. [Code](#code-4)
        1. [Check `umi_tools extract --help`](#check-umi_tools-extract---help)
            1. [`--help`](#--help)
            1. [`--help-extended`](#--help-extended)
        1. [Check `umi_tools dedup --help`](#check-umi_tools-dedup---help)
            1. [`--help`](#--help-1)
            1. [`--help-extended`](#--help-extended-1)
        1. [Check `umi_tools group --help`](#check-umi_tools-group---help)
            1. [`--help`](#--help-2)
            1. [`--help-extended`](#--help-extended-2)
    1. [Make a directory for the trial with `umi_tools extract`, etc.](#make-a-directory-for-the-trial-with-umi_tools-extract-etc)
        1. [Code](#code-5)
    1. [Set up necessary variables](#set-up-necessary-variables-1)
        1. [Code](#code-6)
    1. [Run `umi_tools extract`](#run-umi_tools-extract)
        1. [Code](#code-7)
        1. [Printed](#printed-2)
    1. [Run `trim_galore` on UMI-containing `fastq.gz` files](#run-trim_galore-on-umi-containing-fastqgz-files)
        1. [Code](#code-8)
        1. [Printed](#printed-3)
    1. [Run `STAR` on untrimmed and trimmed UMI-containing `fastq.gz` files](#run-star-on-untrimmed-and-trimmed-umi-containing-fastqgz-files)
        1. [Get situated](#get-situated-2)
            1. [Code](#code-9)
        1. [Set up necessary variables, array, outdir, etc.](#set-up-necessary-variables-array-outdir-etc)
            1. [Code](#code-10)
        1. [Write code for generating lists with permutations of parameters](#write-code-for-generating-lists-with-permutations-of-parameters)
            1. [Code](#code-11)
            1. [Examine the text printed to the multi-line list](#examine-the-text-printed-to-the-multi-line-list)
                1. [Printed](#printed-4)
        1. [Break the multi-line list into individual per-line `.txt` files](#break-the-multi-line-list-into-individual-per-line-txt-files)
            1. [Code](#code-12)
        1. [Use `HEREDOC`s to write the run and submit scripts, `run_star_test.sh` and `submit_star_test.sh`](#use-heredocs-to-write-the-run-and-submit-scripts-run_star_testsh-and-submit_star_testsh)
            1. [Code](#code-13)
                1. [`run_star_test.sh`](#run_star_testsh)
                1. [`submit_star_test.sh`](#submit_star_testsh)
    1. [Use `sbatch` to run the 'submission' and 'run' scripts](#use-sbatch-to-run-the-submission-and-run-scripts)
        1. [Code](#code-14)
        1. [Printed](#printed-5)
    1. [Rename STAR outfiles](#rename-star-outfiles)
        1. [Code](#code-15)
1. [Try another experiment&mdash;but with `Bowtie 2` alignment](#try-another-experimentmdashbut-with-bowtie-2-alignment)
    1. [Make a directory for the trial with `umi_tools extract`, etc.](#make-a-directory-for-the-trial-with-umi_tools-extract-etc-1)
    1. [Set up necessary variables](#set-up-necessary-variables-2)
    1. [Run `umi_tools extract`](#run-umi_tools-extract-1)
    1. [Run `trim_galore` on UMI-containing `fastq.gz` files](#run-trim_galore-on-umi-containing-fastqgz-files-1)
    1. [Run `Bowtie 2` on untrimmed and trimmed UMI-containing `fastq.gz` files](#run-bowtie-2-on-untrimmed-and-trimmed-umi-containing-fastqgz-files)
        1. [Get situated](#get-situated-3)
            1. [Code](#code-16)
        1. [Set up necessary variables, array, outdir, etc.](#set-up-necessary-variables-array-outdir-etc-1)
            1. [Code](#code-17)
        1. [Write code for generating lists with permutations of parameters](#write-code-for-generating-lists-with-permutations-of-parameters-1)
            1. [Code](#code-18)
        1. [Break the multi-line list into individual per-line `.txt` files](#break-the-multi-line-list-into-individual-per-line-txt-files-1)
            1. [Code](#code-19)
        1. [Use `HEREDOC`s to write the run and submit scripts, `run_bowtie2_test.sh` and `submit_bowtie2_test.sh`](#use-heredocs-to-write-the-run-and-submit-scripts-run_bowtie2_testsh-and-submit_bowtie2_testsh)
            1. [Code](#code-20)
                1. [`run_bowtie2_test.sh`](#run_bowtie2_testsh)
                1. [`submit_bowtie2_test.sh`](#submit_bowtie2_testsh)
    1. [Use `sbatch` to run the 'submission' and 'run' scripts](#use-sbatch-to-run-the-submission-and-run-scripts-1)
        1. [Code](#code-21)
1. [Doing the UMI deduplication manually, then assessing results](#doing-the-umi-deduplication-manually-then-assessing-results)
    1. [Get situated](#get-situated-4)
        1. [Code](#code-22)
    1. [Index `.bam`s \(serially\)](#index-bams-serially)
        1. [Code *\(Window 2, 16 cores\)*](#code-window-2-16-cores)
    1. [Perform a trial run of `umi_tools dedup`](#perform-a-trial-run-of-umi_tools-dedup)
        1. [Code *\(Window 1&mdash;1 core, 100 GB RAM&mdash;hereafter\)*](#code-window-1mdash1-core-100-gb-rammdashhereafter)
1. [Links of interest/learning about `umi_tools`](#links-of-interestlearning-about-umi_tools)
1. [Miscellaneous](#miscellaneous)

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
#DONTRUN

grabnode  # 1 core, 100, 200, or 750 GB memory, then default settings

transcriptome && \
    {
        cd results/2023-0115 \
            || echo "cd'ing failed; check on this..."
    }

source activate Trinity_env
```
</details>
<br />
<br />

<a id="experiment-description"></a>
## Experiment description
Follow approach to add UMI sequences to `fastq` read names described [here](https://www.biostars.org/p/357359/#358546): Working directly with already-aligned data  
[`AnnotateBamWithUmis` documentation](https://fulcrumgenomics.github.io/fgbio/tools/latest/AnnotateBamWithUmis.html)

<a id="documentation-for-annotatebamwithumis"></a>
### Documentation for `AnnotateBamWithUmis`
<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Documentation for AnnotateBamWithUmis</i></summary>

AnnotateBamWithUmis  
Overview  
Group: SAM/BAM

Annotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecular IDs, Molecular barcodes) from separate FASTQ files. Takes an existing BAM file and either one FASTQ file with UMI reads or multiple FASTQs if there are multiple UMIs per template, matches the reads between the files based on read names, and produces an output BAM file where each record is annotated with an optional tag (specified by `attribute`) that contains the read sequence of the UMI. Trailing read numbers (`/1` or `/2`) are removed from FASTQ read names, as is any text after whitespace, before matching. If multiple UMI segments are specified (see `--read-structure`) across one or more FASTQs, they are delimited in the same order as FASTQs are specified on the command line. The delimiter is controlled by the `--delimiter` option.

The `--read-structure` option may be used to specify which bases in the FASTQ contain UMI bases. Otherwise it is assumed the FASTQ contains only UMI bases.

The `--sorted` option may be used to indicate that the FASTQ has the same reads and is sorted in the same order as the BAM file.

At the end of execution, reports how many records were processed and how many were missing UMIs. If any read from the BAM file did not have a matching UMI read in the FASTQ file, the program will exit with a non-zero exit status. The `--fail-fast` option may be specified to cause the program to terminate the first time it finds a records without a matching UMI.

In order to avoid sorting the input files, the entire UMI fastq file(s) is read into memory. As a result the program needs to be run with memory proportional the size of the (uncompressed) fastq(s). Use the `--sorted` option to traverse the UMI fastq and BAM files assuming they are in the same order. More precisely, the UMI fastq file will be traversed first, reading in the next set of BAM reads with same read name as the UMI’s read name. Those BAM reads will be annotated. If no BAM reads exist for the UMI, no logging or error will be reported.
</details>
<br />
<br />

<a id="try-a-trial-run-with-annotatebamwithumis"></a>
## Try a trial run with `AnnotateBamWithUmis`
<a id="make-a-directory-for-the-trial-with-annotatebamwithumis"></a>
### Make a directory for the trial with `AnnotateBamWithUmis`
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Make a directory for the trial with AnnotateBamWithUmis</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir test_UMI-processing_AnnotateBamWithUmis
```
</details>
<br />

<a id="locations-of-datasets"></a>
### Locations of datasets
- `WTQvsG1`: `~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot`
- `TRF4_SSRNA_April2022`: `~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla`
- `Nab3_Nrd1_Depletion`: `~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119`
- `rtr1_rrp6_wt`: `~/tsukiyamalab/alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119`

<a id="set-up-necessary-variables"></a>
### Set up necessary variables
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

p_bam="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams/unmapped-w/SC_KL_20S"
f_bam="5782_Q_IN_S8.multi-10.bam"

p_fq="${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
f_fq="5782_Q_IN_S8_R2_001.fastq.gz"

p_out="./test_UMI-processing_AnnotateBamWithUmis"
f_out="5782_Q_IN_S8.Aligned.sortedByCoord.out.w-UMIs.bam"

echo "${p_bam}"
echo "${f_bam}"
echo "${p_fq}"
echo "${f_fq}"
echo "${p_out}"
echo "${f_out}"

., "${p_bam}/${f_bam}"
., "${p_fq}/${f_fq}"
```
</details>
<br />

<a id="run-the-command"></a>
### Run the command
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Run the command</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

fgbio AnnotateBamWithUmis --help
fgbio AnnotateBamWithUmis \
    --input="${p_bam}/${f_bam}" \
    --fastq="${p_fq}/${f_fq}" \
    --output="${p_out}/${f_out}"
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Run the command</i></summary>

For `grabnode` with 1 core, 100 GB memory, and default settings
```txt
❯ fgbio AnnotateBamWithUmis \
>     --input="${p_bam}/${f_bam}" \
>     --fastq="${p_fq}/${f_fq}" \
>     --output="${p_out}/${f_out}"
[2023/01/27 16:13:12 | FgBioMain | Info] Executing AnnotateBamWithUmis from fgbio version 1.3.0 as kalavatt@gizmok33 on JRE 11.0.13+7-b1751.21 with snappy, IntelInflater, and IntelDeflater
[2023/01/27 16:13:12 | AnnotateBamWithUmis | Info] Reading in UMIs from FASTQ.
[2023/01/27 16:16:49 | FgBioMain | Info] AnnotateBamWithUmis failed. Elapsed time: 3.66 minutes.
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
    at java.base/java.lang.StringUTF16.compress(StringUTF16.java:160)
    at java.base/java.lang.String.<init>(String.java:3214)
    at java.base/java.lang.String.<init>(String.java:276)
    at java.base/java.io.BufferedReader.readLine(BufferedReader.java:358)
    at java.base/java.io.BufferedReader.readLine(BufferedReader.java:392)
    at scala.io.BufferedSource$BufferedLineIterator.hasNext(BufferedSource.scala:73)
    at scala.collection.Iterator$SliceIterator.hasNext(Iterator.scala:1219)
    at scala.collection.immutable.List.prependedAll(List.scala:155)
    at scala.collection.IterableOnceOps.toList(IterableOnce.scala:1258)
    at scala.collection.IterableOnceOps.toList$(IterableOnce.scala:1258)
    at scala.collection.AbstractIterator.toList(Iterator.scala:1279)
    at com.fulcrumgenomics.fastq.FastqSource.fetchNextRecord(FastqSource.scala:101)
    at com.fulcrumgenomics.fastq.FastqSource.$anonfun$next$8(FastqSource.scala:94)
    at com.fulcrumgenomics.fastq.FastqSource$$Lambda$397/0x00000001005a8c40.apply$mcV$sp(Unknown Source)
    at com.fulcrumgenomics.commons.CommonsDef.yieldAndThen(CommonsDef.scala:74)
    at com.fulcrumgenomics.commons.CommonsDef.yieldAndThen$(CommonsDef.scala:72)
    at com.fulcrumgenomics.commons.CommonsDef$.yieldAndThen(CommonsDef.scala:422)
    at com.fulcrumgenomics.fastq.FastqSource.next(FastqSource.scala:94)
    at com.fulcrumgenomics.fastq.FastqSource.next(FastqSource.scala:84)
    at scala.collection.Iterator$$anon$9.next(Iterator.scala:575)
    at scala.collection.mutable.Growable.addAll(Growable.scala:62)
    at scala.collection.mutable.Growable.addAll$(Growable.scala:59)
    at scala.collection.immutable.MapBuilderImpl.addAll(Map.scala:683)
    at scala.collection.immutable.Map$.from(Map.scala:634)
    at scala.collection.IterableOnceOps.toMap(IterableOnce.scala:1263)
    at scala.collection.IterableOnceOps.toMap$(IterableOnce.scala:1262)
    at scala.collection.AbstractIterator.toMap(Iterator.scala:1279)
    at com.fulcrumgenomics.umi.AnnotateBamWithUmis.execute(AnnotateBamWithUmis.scala:81)
    at com.fulcrumgenomics.cmdline.FgBioMain.makeItSo(FgBioMain.scala:110)
    at com.fulcrumgenomics.cmdline.FgBioMain.makeItSoAndExit(FgBioMain.scala:86)
    at com.fulcrumgenomics.cmdline.FgBioMain$.main(FgBioMain.scala:50)
    at com.fulcrumgenomics.cmdline.FgBioMain.main(FgBioMain.scala)
```

For `grabnode` with 1 core, 200 GB memory, and default settings
```txt
❯ fgbio AnnotateBamWithUmis \
>     --input="${p_bam}/${f_bam}" \
>     --fastq="${p_fq}/${f_fq}" \
>     --output="${p_out}/${f_out}"
[2023/01/27 16:22:14 | FgBioMain | Info] Executing AnnotateBamWithUmis from fgbio version 1.3.0 as kalavatt@gizmok163 on JRE 11.0.13+7-b1751.21 with snappy, IntelInflater, and IntelDeflater
[2023/01/27 16:22:14 | AnnotateBamWithUmis | Info] Reading in UMIs from FASTQ.
[2023/01/27 16:25:45 | FgBioMain | Info] AnnotateBamWithUmis failed. Elapsed time: 3.55 minutes.
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
    at scala.collection.immutable.List.prependedAll(List.scala:156)
    at scala.collection.IterableOnceOps.toList(IterableOnce.scala:1258)
    at scala.collection.IterableOnceOps.toList$(IterableOnce.scala:1258)
    at scala.collection.AbstractIterator.toList(Iterator.scala:1279)
    at com.fulcrumgenomics.fastq.FastqSource.fetchNextRecord(FastqSource.scala:101)
    at com.fulcrumgenomics.fastq.FastqSource.$anonfun$next$8(FastqSource.scala:94)
    at com.fulcrumgenomics.fastq.FastqSource$$Lambda$397/0x00000001005a8c40.apply$mcV$sp(Unknown Source)
    at com.fulcrumgenomics.commons.CommonsDef.yieldAndThen(CommonsDef.scala:74)
    at com.fulcrumgenomics.commons.CommonsDef.yieldAndThen$(CommonsDef.scala:72)
    at com.fulcrumgenomics.commons.CommonsDef$.yieldAndThen(CommonsDef.scala:422)
    at com.fulcrumgenomics.fastq.FastqSource.next(FastqSource.scala:94)
    at com.fulcrumgenomics.fastq.FastqSource.next(FastqSource.scala:84)
    at scala.collection.Iterator$$anon$9.next(Iterator.scala:575)
    at scala.collection.mutable.Growable.addAll(Growable.scala:62)
    at scala.collection.mutable.Growable.addAll$(Growable.scala:59)
    at scala.collection.immutable.MapBuilderImpl.addAll(Map.scala:683)
    at scala.collection.immutable.Map$.from(Map.scala:634)
    at scala.collection.IterableOnceOps.toMap(IterableOnce.scala:1263)
    at scala.collection.IterableOnceOps.toMap$(IterableOnce.scala:1262)
    at scala.collection.AbstractIterator.toMap(Iterator.scala:1279)
    at com.fulcrumgenomics.umi.AnnotateBamWithUmis.execute(AnnotateBamWithUmis.scala:81)
    at com.fulcrumgenomics.cmdline.FgBioMain.makeItSo(FgBioMain.scala:110)
    at com.fulcrumgenomics.cmdline.FgBioMain.makeItSoAndExit(FgBioMain.scala:86)
    at com.fulcrumgenomics.cmdline.FgBioMain$.main(FgBioMain.scala:50)
    at com.fulcrumgenomics.cmdline.FgBioMain.main(FgBioMain.scala)
```

For `grabnode` with 1 core, 750 GB memory, and default settings
```txt
❯ fgbio AnnotateBamWithUmis \
>     --input="${p_bam}/${f_bam}" \
>     --fastq="${p_fq}/${f_fq}" \
>     --output="${p_out}/${f_out}"
[2023/01/27 16:30:22 | FgBioMain | Info] Executing AnnotateBamWithUmis from fgbio version 1.3.0 as kalavatt@gizmok15 on JRE 11.0.13+7-b1751.21 with snappy, IntelInflater, and IntelDeflater
[2023/01/27 16:30:22 | AnnotateBamWithUmis | Info] Reading in UMIs from FASTQ.
[2023/01/27 16:33:45 | FgBioMain | Info] AnnotateBamWithUmis failed. Elapsed time: 3.42 minutes.
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
    at scala.collection.immutable.List.prependedAll(List.scala:156)
    at scala.collection.IterableOnceOps.toList(IterableOnce.scala:1258)
    at scala.collection.IterableOnceOps.toList$(IterableOnce.scala:1258)
    at scala.collection.AbstractIterator.toList(Iterator.scala:1279)
    at com.fulcrumgenomics.fastq.FastqSource.fetchNextRecord(FastqSource.scala:101)
    at com.fulcrumgenomics.fastq.FastqSource.$anonfun$next$8(FastqSource.scala:94)
    at com.fulcrumgenomics.fastq.FastqSource$$Lambda$397/0x00000001005a8c40.apply$mcV$sp(Unknown Source)
    at com.fulcrumgenomics.commons.CommonsDef.yieldAndThen(CommonsDef.scala:74)
    at com.fulcrumgenomics.commons.CommonsDef.yieldAndThen$(CommonsDef.scala:72)
    at com.fulcrumgenomics.commons.CommonsDef$.yieldAndThen(CommonsDef.scala:422)
    at com.fulcrumgenomics.fastq.FastqSource.next(FastqSource.scala:94)
    at com.fulcrumgenomics.fastq.FastqSource.next(FastqSource.scala:84)
    at scala.collection.Iterator$$anon$9.next(Iterator.scala:575)
    at scala.collection.mutable.Growable.addAll(Growable.scala:62)
    at scala.collection.mutable.Growable.addAll$(Growable.scala:59)
    at scala.collection.immutable.MapBuilderImpl.addAll(Map.scala:683)
    at scala.collection.immutable.Map$.from(Map.scala:634)
    at scala.collection.IterableOnceOps.toMap(IterableOnce.scala:1263)
    at scala.collection.IterableOnceOps.toMap$(IterableOnce.scala:1262)
    at scala.collection.AbstractIterator.toMap(Iterator.scala:1279)
    at com.fulcrumgenomics.umi.AnnotateBamWithUmis.execute(AnnotateBamWithUmis.scala:81)
    at com.fulcrumgenomics.cmdline.FgBioMain.makeItSo(FgBioMain.scala:110)
    at com.fulcrumgenomics.cmdline.FgBioMain.makeItSoAndExit(FgBioMain.scala:86)
    at com.fulcrumgenomics.cmdline.FgBioMain$.main(FgBioMain.scala:50)
    at com.fulcrumgenomics.cmdline.FgBioMain.main(FgBioMain.scala)
```
</details>
<br />
<br />

<a id="try-another-experiment"></a>
## Try another experiment
Follow approach to add UMI sequences to `fastq` read names described [here](https://www.biostars.org/p/357359/#358546): Working directly with already-aligned data  
Code for `umi_tools` `extract.py` [here](https://github.com/CGATOxford/UMI-tools/blob/master/umi_tools/extract.py)

<a id="get-situated-1"></a>
### Get situated
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core, then default settings

transcriptome && \
    {
        cd results/2023-0115 \
            || echo "cd'ing failed; check on this..."
    }

source activate Trinity_env
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4
```
</details>
<br />

<a id="check-umi_tools-extract---help"></a>
#### Check `umi_tools extract --help`
<a id="--help"></a>
##### `--help`
<details>
<summary><i>--help</i></summary>

```txt
❯ umi_tools extract --help
UMI-Tools: Version 1.0.1
Matplotlib is building the font cache using fc-list. This may take a moment.

extract - Extract UMI from fastq

Usage:

   Single-end:
      umi_tools extract [OPTIONS] -p PATTERN [-I IN_FASTQ[.gz]] [-S OUT_FASTQ[.gz]]

   Paired end:
      umi_tools extract [OPTIONS] -p PATTERN [-I IN_FASTQ[.gz]] [-S OUT_FASTQ[.gz]] --read2-in=IN2_FASTQ[.gz] --read2-out=OUT2_FASTQ[.gz]

   note: If -I/-S are ommited standard in and standard out are used
         for input and output.  To generate a valid BAM file on
         standard out, please redirect log with --log=LOGFILE or
         --log2stderr. Input/Output will be (de)compressed if a
         filename provided to -S/-I/--read2-in/read2-out ends in .gz


For full UMI-tools documentation, see https://umi-tools.readthedocs.io/en/latest/

Options:
  --version             show program's version number and exit

  extract-specific options:
    --read2-out=READ2_OUT
                        file to output processed paired read to
    --read2-stdout      Paired reads, send read2 to stdout, discarding read1
    --quality-filter-threshold=QUALITY_FILTER_THRESHOLD
                        Remove reads where any UMI base quality score falls
                        below this threshold
    --quality-filter-mask=QUALITY_FILTER_MASK
                        If a UMI base has a quality below this threshold,
                        replace the base with 'N'
    --quality-encoding=QUALITY_ENCODING
                        Quality score encoding. Choose from 'phred33'[33-77]
                        'phred64' [64-106] or 'solexa' [59-106]
    --filter-cell-barcode
                        Filter the cell barcodes
    --error-correct-cell
                        Correct errors in the cell barcode
    --whitelist=WHITELIST
                        A whitelist of accepted cell barcodes
    --blacklist=BLACKLIST
                        A blacklist of rejected cell barcodes
    --subset-reads=READS_SUBSET, --reads-subset=READS_SUBSET
                        Only extract from the first N reads. If N is greater
                        than the number of reads, all reads will be used
    --reconcile-pairs   Allow the presences of reads in read2 input that are
                        not present in read1 input. This allows cell barcode
                        filtering of read1s without considering read2s

  [EXPERIMENTAl] barcode extraction options:
    --either-read       UMI may be on either read (see --either-read-resolve)
                        for options to resolve cases whereUMI is on both reads
    --either-read-resolve=EITHER_READ_RESOLVE
                        How to resolve instances where both reads contain a
                        UMI but using --either-read.Choose from 'discard' or
                        'quality'(use highest quality). default=dicard

  fastq barcode extraction options:
    --extract-method=EXTRACT_METHOD
                        How to extract the umi +/- cell barcodes, Choose from
                        'string' or 'regex'
    -p PATTERN, --bc-pattern=PATTERN
                        Barcode pattern
    --bc-pattern2=PATTERN2
                        Barcode pattern for paired reads
    --3prime            barcode is on 3' end of read.
    --read2-in=READ2_IN
                        file name for read pairs

  input/output options:
    -I FILE, --stdin=FILE
                        file to read stdin from [default = stdin].
    -L FILE, --log=FILE
                        file with logging information [default = stdout].
    -E FILE, --error=FILE
                        file with error information [default = stderr].
    -S FILE, --stdout=FILE
                        file where output is to go [default = stdout].
    --temp-dir=FILE     Directory for temporary files. If not set, the bash
                        environmental variable TMPDIR is used[default = None].
    --log2stderr        send logging information to stderr [default = False].
    --compresslevel=COMPRESSLEVEL
                        Level of Gzip compression to use. Default (6)
                        matchesGNU gzip rather than python gzip default (which
                        is 9)

  profiling options:
    --timeit=TIMEIT_FILE
                        store timeing information in file [none].
    --timeit-name=TIMEIT_NAME
                        name in timing file for this class of jobs [all].
    --timeit-header     add header for timing information [none].

  common options:
    -v LOGLEVEL, --verbose=LOGLEVEL
                        loglevel [1]. The higher, the more output.
    -h, --help          output short help (command line options only).
    --help-extended     Output full documentation
    --random-seed=RANDOM_SEED
                        random seed to initialize number generator with
                        [none].
```
</details>
<br />

<a id="--help-extended"></a>
##### `--help-extended`
<details>
<summary><i>--help-extended</i></summary>

```txt
❯ umi_tools extract --help-extended
UMI-Tools: Version 1.0.1

extract - Extract UMI from fastq

Usage:

   Single-end:
      umi_tools extract [OPTIONS] -p PATTERN [-I IN_FASTQ[.gz]] [-S OUT_FASTQ[.gz]]

   Paired end:
      umi_tools extract [OPTIONS] -p PATTERN [-I IN_FASTQ[.gz]] [-S OUT_FASTQ[.gz]] --read2-in=IN2_FASTQ[.gz] --read2-out=OUT2_FASTQ[.gz]

   note: If -I/-S are ommited standard in and standard out are used
         for input and output.  To generate a valid BAM file on
         standard out, please redirect log with --log=LOGFILE or
         --log2stderr. Input/Output will be (de)compressed if a
         filename provided to -S/-I/--read2-in/read2-out ends in .gz


For full UMI-tools documentation, see https://umi-tools.readthedocs.io/en/latest/


================================
extract - Extract UMI from fastq
================================

*Extract UMI barcode from a read and add it to the read name, leaving
any sample barcode in place*

Can deal with paired end reads and UMIs
split across the paired ends. Can also optionally extract cell
barcodes and append these to the read name also. See the section below
for an explanation for how to encode the barcode pattern(s) to
specficy the position of the UMI +/- cell barcode.

Usage:
------

For single ended reads, the following reads from stdin and outputs to
stdout::

        umi_tools extract --extract-method=string
        --bc-pattern=[PATTERN] -L extract.log [OPTIONS]

For paired end reads, the following reads end one from stdin and end
two from FASTQIN and outputs end one to stdin and end two to
FASTQOUT::

        umi_tools extract --extract-method=string
        --bc-pattern=[PATTERN] --bc-pattern2=[PATTERN]
        --read2-in=[FASTQIN] --read2-out=[FASTQOUT] -L extract.log [OPTIONS]

Using regex and filtering against a whitelist of cell barcodes::

        umi_tools extract --extract-method=regex --filter-cell-barcode
        --bc-pattern=[REGEX] --whitlist=[WHITELIST_TSV]
        -L extract.log [OPTIONS]


Filtering and correcting cell barcodes
--------------------------------------

umi_tools extract can optionally filter cell barcodes
(``--filter-cell-barcode``) against a user-supplied whitelist
(``--whitelist``). If a whitelist is not available for your data, e.g
if you have performed droplet-based scRNA-Seq, you can use the
whitelist tool.

Cell barcodes which do not match the whitelist (user-generated or
automatically generated) can also be optionally corrected using the
``--error-correct-cell`` option.

"""""""""""""""""""""""""
``--filter-cell-barcode``
"""""""""""""""""""""""""
     Filter cell barcodes against a user-supplied whitelist (see
     ``--whitelist``)

""""""""""""""""""""""""
``--error-correct-cell``
""""""""""""""""""""""""
     Error correct cell barcodes to the whitelist (see ``--whitelist``)

"""""""""""""""
``--whitelist``
"""""""""""""""
     Whitelist of accepted cell barcodes. The whitelist should be in
     the following format (tab-separated)::

        AAAAAA    AGAAAA
        AAAATC
        AAACAT
        AAACTA    AAACTN,GAACTA
        AAATAC
        AAATCA    GAATCA
        AAATGT    AAAGGT,CAATGT

    Where column 1 is the whitelisted cell barcodes and column 2 is
    the list (comma-separated) of other cell barcodes which should be
    corrected to the barcode in column 1. If the ``--error-correct-cell``
    option is not used, this column will be ignored. Any additional columns
    in the whitelist input, such as the counts columns from the output of
    umi_tools whitelist, will be ignored.

"""""""""""""""
``--blacklist``
"""""""""""""""
    BlackWhitelist of cell barcodes to discard

""""""""""""""""""""""
``--subset-reads=[N]``
""""""""""""""""""""""
    Only parse the first N reads

""""""""""""""""""""""""""""""
``--quality-filter-threshold``
""""""""""""""""""""""""""""""
    Remove reads where any UMI base quality score falls below this threshold

"""""""""""""""""""""""""
``--quality-filter-mask``
"""""""""""""""""""""""""
    If a UMI base has a quality below this threshold, replace the base with
'N'

""""""""""""""""""""""
``--quality-encoding``
""""""""""""""""""""""
    Quality score encoding. Choose from:
     - 'phred33' [33-77]
     - 'phred64' [64-106]
     - 'solexa' [59-106]

"""""""""""""""""""""
``--reconcile-pairs``
"""""""""""""""""""""
    Allow read 2 infile to contain reads not in read 1 infile. This
    enables support for upstream protocols where read one contains
    cell barcodes, and the read pairs have been filtered and corrected
    without regard to the read2s



Experimental options
--------------------

.. note:: These options have not been extensively testing to ensure behaviour
is as expected. If you have some suitable input files which we can use for
testing, please `contact us <https://github.com/CGATOxford/UMI-
tools/issues>`_.

If you have a library preparation method where the UMI may be in
either read, you can use the following options to search for the UMI
in either read::

       --either-read --extract-method --bc-pattern=[PATTERN1] --bc-
pattern2=[PATTERN2]

Where both patterns match, the default behaviour is to discard both
reads. If you want to select the read with the UMI with highest
sequence quality, provide ``--either-read-resolve=quality.``





Barcode extraction
------------------

""""""""""""""""
``--bc-pattern``
""""""""""""""""
      Pattern for barcode(s) on read 1. See ``--extract-method``

"""""""""""""""""
``--bc-pattern2``
"""""""""""""""""
      Pattern for barcode(s) on read 2. See ``--extract-method``

""""""""""""""""""""
``--extract-method``
""""""""""""""""""""
      There are two methods enabled to extract the umi barcode (+/-
      cell barcode). For both methods, the patterns should be provided
      using the ``--bc-pattern`` and ``--bc-pattern2`` options.x

 - ``string``
       This should be used where the barcodes are always in the same
       place in the read.

       - N = UMI position (required)
       - C = cell barcode position (optional)
       - X = sample position (optional)

       Bases with Ns and Cs will be extracted and added to the read
       name. The corresponding sequence qualities will be removed from
       the read. Bases with an X will be reattached to the read.

       E.g. If the pattern is `NNNNCC`,
       Then the read::

           @HISEQ:87:00000000 read1
           AAGGTTGCTGATTGGATGGGCTAG
           +
           DA1AEBFGGCG01DFH00B1FF0B

       will become::

           @HISEQ:87:00000000_TT_AAGG read1
           GCTGATTGGATGGGCTAG
           +
           1AFGGCG01DFH00B1FF0B

       where 'TT' is the cell barcode and 'AAGG' is the UMI.

 - ``regex``
       This method allows for more flexible barcode extraction and
       should be used where the cell barcodes are variable in
       length. Alternatively, the regex option can also be used to
       filter out reads which do not contain an expected adapter
       sequence. UMI-tools uses the regex module rather than the more
       standard re module since the former also enables fuzzy matching

       The regex must contain groups to define how the barcodes are
       encoded in the read. The expected groups in the regex are:

       umi_n = UMI positions, where n can be any value (required)
       cell_n = cell barcode positions, where n can be any value (optional)
       discard_n = positions to discard, where n can be any value (optional)

       UMI positions and cell barcode positions will be extracted and
       added to the read name. The corresponding sequence qualities
       will be removed from the read.

       Discard bases and the corresponding quality scores will be
       removed from the read. All bases matched by other groups or
       components of the regex will be reattached to the read sequence

       For example, the following regex can be used to extract reads
       from the Klein et al inDrop data::

           (?P<cell_1>.{8,12})(?P<discard_1>GAGTGATTGCTTGTGACGCCTT)(?P<cell_2>
.{8})(?P<umi_1>.{6})T{3}.*

       Where only reads with a 3' T-tail and `GAGTGATTGCTTGTGACGCCTT` in
       the correct position to yield two cell barcodes of 8-12 and 8bp
       respectively, and a 6bp UMI will be retained.

       You can also specify fuzzy matching to allow errors. For example if
       the discard group above was specified as below this would enable
       matches with up to 2 errors in the discard_1 group.

       ::

           (?P<discard_1>GAGTGATTGCTTGTGACGCCTT){s<=2}

       Note that all UMIs must be the same length for downstream
       processing with dedup, group or count commands


""""""""""""
``--3prime``
""""""""""""
       By default the barcode is assumed to be on the 5' end of the
       read, but use this option to sepecify that it is on the 3' end
       instead. This option only works with ``--extract-method=string``
       since 3' encoding can be specified explicitly with a regex, e.g
       ``.*(?P<umi_1>.{5})$``

""""""""""""""
``--read2-in``
""""""""""""""
        Filename for read pairs


Options:
  --version             show program's version number and exit

  extract-specific options:
    --read2-out=READ2_OUT
                        file to output processed paired read to
    --read2-stdout      Paired reads, send read2 to stdout, discarding read1
    --quality-filter-threshold=QUALITY_FILTER_THRESHOLD
                        Remove reads where any UMI base quality score falls
                        below this threshold
    --quality-filter-mask=QUALITY_FILTER_MASK
                        If a UMI base has a quality below this threshold,
                        replace the base with 'N'
    --quality-encoding=QUALITY_ENCODING
                        Quality score encoding. Choose from 'phred33'[33-77]
                        'phred64' [64-106] or 'solexa' [59-106]
    --filter-cell-barcode
                        Filter the cell barcodes
    --error-correct-cell
                        Correct errors in the cell barcode
    --whitelist=WHITELIST
                        A whitelist of accepted cell barcodes
    --blacklist=BLACKLIST
                        A blacklist of rejected cell barcodes
    --subset-reads=READS_SUBSET, --reads-subset=READS_SUBSET
                        Only extract from the first N reads. If N is greater
                        than the number of reads, all reads will be used
    --reconcile-pairs   Allow the presences of reads in read2 input that are
                        not present in read1 input. This allows cell barcode
                        filtering of read1s without considering read2s

  [EXPERIMENTAl] barcode extraction options:
    --either-read       UMI may be on either read (see --either-read-resolve)
                        for options to resolve cases whereUMI is on both reads
    --either-read-resolve=EITHER_READ_RESOLVE
                        How to resolve instances where both reads contain a
                        UMI but using --either-read.Choose from 'discard' or
                        'quality'(use highest quality). default=dicard

  fastq barcode extraction options:
    --extract-method=EXTRACT_METHOD
                        How to extract the umi +/- cell barcodes, Choose from
                        'string' or 'regex'
    -p PATTERN, --bc-pattern=PATTERN
                        Barcode pattern
    --bc-pattern2=PATTERN2
                        Barcode pattern for paired reads
    --3prime            barcode is on 3' end of read.
    --read2-in=READ2_IN
                        file name for read pairs

  input/output options:
    -I FILE, --stdin=FILE
                        file to read stdin from [default = stdin].
    -L FILE, --log=FILE
                        file with logging information [default = stdout].
    -E FILE, --error=FILE
                        file with error information [default = stderr].
    -S FILE, --stdout=FILE
                        file where output is to go [default = stdout].
    --temp-dir=FILE     Directory for temporary files. If not set, the bash
                        environmental variable TMPDIR is used[default = None].
    --log2stderr        send logging information to stderr [default = False].
    --compresslevel=COMPRESSLEVEL
                        Level of Gzip compression to use. Default (6)
                        matchesGNU gzip rather than python gzip default (which
                        is 9)

  profiling options:
    --timeit=TIMEIT_FILE
                        store timeing information in file [none].
    --timeit-name=TIMEIT_NAME
                        name in timing file for this class of jobs [all].
    --timeit-header     add header for timing information [none].

  common options:
    -v LOGLEVEL, --verbose=LOGLEVEL
                        loglevel [1]. The higher, the more output.
    -h, --help          output short help (command line options only).
    --help-extended     Output full documentation
    --random-seed=RANDOM_SEED
                        random seed to initialize number generator with
                        [none].
```
</details>
<br />

<a id="check-umi_tools-dedup---help"></a>
#### Check `umi_tools dedup --help`
<a id="--help-1"></a>
##### `--help`
<details>
<summary><i>--help</i></summary>

```txt
❯ umi_tools dedup --help
UMI-Tools: Version 1.0.1

dedup - Deduplicate reads using UMI and mapping coordinates

Usage: umi_tools dedup [OPTIONS] [--stdin=IN_BAM] [--stdout=OUT_BAM]

       note: If --stdout is ommited, standard out is output. To
             generate a valid BAM file on standard out, please
             redirect log with --log=LOGFILE or --log2stderr

For full UMI-tools documentation, see https://umi-tools.readthedocs.io/en/latest/

Options:
  --version             show program's version number and exit

  dedup-specific options:
    --output-stats=STATS
                        Specify location to output stats

  Barcode extraction options:
    --extract-umi-method=GET_UMI_METHOD
                        how is the read UMI +/ cell barcode encoded?
                        [default=read_id]
    --umi-separator=UMI_SEP
                        separator between read id and UMI
    --umi-tag=UMI_TAG   tag containing umi
    --umi-tag-split=UMI_TAG_SPLIT
                        split UMI in tag and take the first element
    --umi-tag-delimiter=UMI_TAG_DELIM
                        concatenate UMI in tag separated by delimiter
    --cell-tag=CELL_TAG
                        tag containing cell barcode
    --cell-tag-split=CELL_TAG_SPLIT
                        split cell barcode in tag and take the first
                        elementfor e.g 10X GEM tags
    --cell-tag-delimiter=CELL_TAG_DELIM
                        concatenate cell barcode in tag separated by delimiter

  UMI grouping options:
    --method=METHOD     method to use for umi grouping [default=directional]
    --edit-distance-threshold=THRESHOLD
                        Edit distance theshold at which to join two UMIs when
                        grouping UMIs. [default=1]
    --spliced-is-unique
                        Treat a spliced read as different to an unspliced one
                        [default=False]
    --soft-clip-threshold=SOFT_CLIP_THRESHOLD
                        number of bases clipped from 5' end before read is
                        counted as spliced [default=4]
    --read-length       use read length in addition to position and UMI to
                        identify possible duplicates [default=False]

  single-cell RNA-Seq options:
    --per-gene          Group/Dedup/Count per gene. Must combine with either
                        --gene-tag or --per-contig
    --gene-tag=GENE_TAG
                        Gene is defined by this bam tag [default=none]
    --assigned-status-tag=ASSIGNED_TAG
                        Bam tag describing whether read is assigned to a gene
                        By defualt, this is set as the same tag as --gene-tag
    --skip-tags-regex=SKIP_REGEX
                        Used with --gene-tag. Ignore reads where the gene-tag
                        matches this regex
    --per-contig        group/dedup/count UMIs per contig (field 3 in BAM;
                        RNAME), e.g for transcriptome where contig = gene
    --gene-transcript-map=GENE_TRANSCRIPT_MAP
                        File mapping transcripts to genes (tab separated)
    --per-cell          group/dedup/count per cell

  group/dedup options:
    --buffer-whole-contig
                        Read whole contig before outputting bundles:
                        guarantees that no reads are missed, but increases
                        memory usage
    --multimapping-detection-method=DETECTION_METHOD
                        Some aligners identify multimapping using bam tags.
                        Setting this option to NH, X0 or XT will use these
                        tags when selecting the best read amongst reads with
                        the same position and umi [default=none]

  SAM/BAM options:
    --mapping-quality=MAPPING_QUALITY
                        Minimum mapping quality for a read to be retained
                        [default=0]
    --unmapped-reads=UNMAPPED_READS
                        How to handle unmapped reads. Options are 'discard',
                        'use' or 'correct' [default=discard]
    --chimeric-pairs=CHIMERIC_PAIRS
                        How to handle chimeric read pairs. Options are
                        'discard', 'use' or 'correct' [default=use]
    --unpaired-reads=UNPAIRED_READS
                        How to handle unpaired reads. Options are 'discard',
                        'use' or 'correct' [default=use]
    --ignore-umi        Ignore UMI and dedup only on position
    --chrom=CHROM       Restrict to one chromosome
    --subset=SUBSET     Use only a fraction of reads, specified by subset
    -i, --in-sam        Input file is in sam format [default=False]
    --paired            paired input BAM. [default=False]
    -o, --out-sam       Output alignments in sam format [default=False]
    --no-sort-output    Don't Sort the output

  input/output options:
    -I FILE, --stdin=FILE
                        file to read stdin from [default = stdin].
    -L FILE, --log=FILE
                        file with logging information [default = stdout].
    -E FILE, --error=FILE
                        file with error information [default = stderr].
    -S FILE, --stdout=FILE
                        file where output is to go [default = stdout].
    --temp-dir=FILE     Directory for temporary files. If not set, the bash
                        environmental variable TMPDIR is used[default = None].
    --log2stderr        send logging information to stderr [default = False].
    --compresslevel=COMPRESSLEVEL
                        Level of Gzip compression to use. Default (6)
                        matchesGNU gzip rather than python gzip default (which
                        is 9)

  profiling options:
    --timeit=TIMEIT_FILE
                        store timeing information in file [none].
    --timeit-name=TIMEIT_NAME
                        name in timing file for this class of jobs [all].
    --timeit-header     add header for timing information [none].

  common options:
    -v LOGLEVEL, --verbose=LOGLEVEL
                        loglevel [1]. The higher, the more output.
    -h, --help          output short help (command line options only).
    --help-extended     Output full documentation
    --random-seed=RANDOM_SEED
                        random seed to initialize number generator with
                        [none].
```
</details>
<br />

<a id="--help-extended-1"></a>
##### `--help-extended`
<details>
<summary><i>--help-extended</i></summary>

```txt
❯ umi_tools dedup --help-extended
UMI-Tools: Version 1.0.1

dedup - Deduplicate reads using UMI and mapping coordinates

Usage: umi_tools dedup [OPTIONS] [--stdin=IN_BAM] [--stdout=OUT_BAM]

       note: If --stdout is ommited, standard out is output. To
             generate a valid BAM file on standard out, please
             redirect log with --log=LOGFILE or --log2stderr

For full UMI-tools documentation, see https://umi-tools.readthedocs.io/en/latest/


===========================================================
dedup - Deduplicate reads using UMI and mapping coordinates
===========================================================

*Deduplicate reads based on the mapping co-ordinate and the UMI attached to
the read*

The identification of duplicate reads is performed in an error-aware
manner by building networks of related UMIs (see
``--method``). ``dedup`` can also handle cell barcoded input (see
``--per-cell``).

Usage::

    umi_tools dedup --stdin=INFILE --log=LOGFILE [OPTIONS] > OUTFILE

Selecting the representative read
---------------------------------
For every group of duplicate reads, a single representative read is
retained.The following criteria are applied to select the read that
will be retained from a group of duplicated reads:

1. The read with the lowest number of mapping coordinates (see
``--multimapping-detection-method`` option)

2. The read with the highest mapping quality. Note that this is not
the read sequencing quality and that if two reads have the same
mapping quality then one will be picked at random regardless of the
read quality.

Otherwise a read is chosen at random.


Dedup-specific options
----------------------
"""""""""""""""""""""""""""
``--output-stats=[PREFIX]``
"""""""""""""""""""""""""""
       Output edit distance statistics and UMI usage statistics
       using this prefix.

       Output files are:

       [PREFIX]_stats_per_umi_per_position.tsv
           Histogram of counts per position per UMI pre- and post-
deduplication

       [PREFIX_stats_per_umi_per.tsv
           Table of stats per umi. Number of times UMI was observed,
           total counts and median counts, pre- and post-deduplication

       [PREFIX]_stats_edit_distance.tsv
           Edit distance between UMIs at each position. Positions with a
           single UMI are reported seperately. Pre- and post-deduplication and
           inluding null expectations from random sampling of UMIs from the
           UMIs observed across all positions.



Extracting barcodes
-------------------

It is assumed that the FASTQ files were processed with `umi_tools
extract` before mapping and thus the UMI is the last word of the read
name. e.g::

    @HISEQ:87:00000000_AATT

where `AATT` is the UMI sequeuence.

If you have used an alternative method which does not separate the
read id and UMI with a "_", such as bcl2fastq which uses ":", you can
specify the separator with the option ``--umi-separator=<sep>``,
replacing <sep> with e.g ":".

Alternatively, if your UMIs are encoded in a tag, you can specify this
by setting the option --extract-umi-method=tag and set the tag name
with the --umi-tag option. For example, if your UMIs are encoded in
the 'UM' tag, provide the following options:
``--extract-umi-method=tag`` ``--umi-tag=UM``

Finally, if you have used umis to extract the UMI +/- cell barcode,
you can specify ``--extract-umi-method=umis``

The start position of a read is considered to be the start of its alignment
minus any soft clipped bases. A read aligned at position 500 with
cigar 2S98M will be assumed to start at position 498.

""""""""""""""""""""""""
``--extract-umi-method``
""""""""""""""""""""""""
      How are the barcodes encoded in the read?

      Options are:

      - read_id (default)
            Barcodes are contained at the end of the read separated as
            specified with ``--umi-separator`` option

      - tag
            Barcodes contained in a tag(s), see ``--umi-tag``/``--cell-tag``
            options

      - umis
            Barcodes were extracted using umis (https://github.com/vals/umis)

"""""""""""""""""""""""""""""""
``--umi-separator=[SEPARATOR]``
"""""""""""""""""""""""""""""""
      Separator between read id and UMI. See ``--extract-umi-method``
      above. Default=``_``

"""""""""""""""""""
``--umi-tag=[TAG]``
"""""""""""""""""""
      Tag which contains UMI. See ``--extract-umi-method`` above

"""""""""""""""""""""""""""
``--umi-tag-split=[SPLIT]``
"""""""""""""""""""""""""""
      Separate the UMI in tag by SPLIT and take the first element

"""""""""""""""""""""""""""""""""""
``--umi-tag-delimiter=[DELIMITER]``
"""""""""""""""""""""""""""""""""""
      Separate the UMI in by DELIMITER and concatenate the elements

""""""""""""""""""""
``--cell-tag=[TAG]``
""""""""""""""""""""
      Tag which contains cell barcode. See `--extract-umi-method` above

""""""""""""""""""""""""""""
``--cell-tag-split=[SPLIT]``
""""""""""""""""""""""""""""
      Separate the cell barcode in tag by SPLIT and take the first element

""""""""""""""""""""""""""""""""""""
``--cell-tag-delimiter=[DELIMITER]``
""""""""""""""""""""""""""""""""""""
      Separate the cell barcode in by DELIMITER and concatenate the elements


UMI grouping options
---------------------------

""""""""""""
``--method``
""""""""""""
    What method to use to identify group of reads with the same (or
    similar) UMI(s)?

    All methods start by identifying the reads with the same mapping position.

    The simplest methods, unique and percentile, group reads with
    the exact same UMI. The network-based methods, cluster, adjacency and
    directional, build networks where nodes are UMIs and edges connect UMIs
    with an edit distance <= threshold (usually 1). The groups of reads
    are then defined from the network in a method-specific manner. For all
    the network-based methods, each read group is equivalent to one read
    count for the gene.

      - unique
          Reads group share the exact same UMI

      - percentile
          Reads group share the exact same UMI. UMIs with counts < 1% of the
          median counts for UMIs at the same position are ignored.

      - cluster
          Identify clusters of connected UMIs (based on hamming distance
          threshold). Each network is a read group

      - adjacency
          Cluster UMIs as above. For each cluster, select the node (UMI)
          with the highest counts. Visit all nodes one edge away. If all
          nodes have been visited, stop. Otherwise, repeat with remaining
          nodes until all nodes have been visted. Each step
          defines a read group.

      - directional (default)
          Identify clusters of connected UMIs (based on hamming distance
          threshold) and umi A counts >= (2* umi B counts) - 1. Each
          network is a read group.

"""""""""""""""""""""""""""""
``--edit-distance-threshold``
"""""""""""""""""""""""""""""
       For the adjacency and cluster methods the threshold for the
       edit distance to connect two UMIs in the network can be
       increased. The default value of 1 works best unless the UMI is
       very long (>14bp).

"""""""""""""""""""""""
``--spliced-is-unique``
"""""""""""""""""""""""
       Causes two reads that start in the same position on the same
       strand and having the same UMI to be considered unique if one is
spliced
       and the other is not. (Uses the 'N' cigar operation to test for
       splicing).

"""""""""""""""""""""""""
``--soft-clip-threshold``
"""""""""""""""""""""""""
       Mappers that soft clip will sometimes do so rather than mapping a
       spliced read if there is only a small overhang over the exon
       junction. By setting this option, you can treat reads with at least
       this many bases soft-clipped at the 3' end as spliced. Default=4.

""""""""""""""""""""""""""""""""""""""""""""""
``--multimapping-detection-method=[NH/X0/XT]``
""""""""""""""""""""""""""""""""""""""""""""""
      If the sam/bam contains tags to identify multimapping reads, you can
      specify for use when selecting the best read at a given loci.
      Supported tags are "NH", "X0" and "XT". If not specified, the read
      with the highest mapping quality will be selected.

"""""""""""""""""
``--read-length``
"""""""""""""""""
      Use the read length as a criteria when deduping, for e.g sRNA-Seq.


Single-cell RNA-Seq options
---------------------------

""""""""""""""
``--per-gene``
""""""""""""""
      Reads will be grouped together if they have the same gene.  This
      is useful if your library prep generates PCR duplicates with non
      identical alignment positions such as CEL-Seq. Note this option
      is hardcoded to be on with the count command. I.e counting is
      always performed per-gene. Must be combined with either
      ``--gene-tag`` or ``--per-contig`` option.

""""""""""""""
``--gene-tag``
""""""""""""""
      Deduplicate per gene. The gene information is encoded in the bam
      read tag specified

"""""""""""""""""""""""""
``--assigned-status-tag``
"""""""""""""""""""""""""
      BAM tag which describes whether a read is assigned to a
      gene. Defaults to the same value as given for ``--gene-tag``

"""""""""""""""""""""
``--skip-tags-regex``
"""""""""""""""""""""
      Use in conjunction with the ``--assigned-status-tag`` option to
      skip any reads where the tag matches this regex.  Default
      (``"^[__|Unassigned]"``) matches anything which starts with "__"
      or "Unassigned":

""""""""""""""""
``--per-contig``
""""""""""""""""
      Deduplicate per contig (field 3 in BAM; RNAME).
      All reads with the same contig will be considered to have the
      same alignment position. This is useful if you have aligned to a
      reference transcriptome with one transcript per gene. If you
      have aligned to a transcriptome with more than one transcript
      per gene, you can supply a map between transcripts and gene
      using the ``--gene-transcript-map`` option

"""""""""""""""""""""""""
``--gene-transcript-map``
"""""""""""""""""""""""""
      File mapping genes to transcripts (tab separated), e.g::

          gene1   transcript1
          gene1   transcript2
          gene2   transcript3

""""""""""""""
``--per-cell``
""""""""""""""
      Reads will only be grouped together if they have the same cell
      barcode. Can be combined with ``--per-gene``.

SAM/BAM Options
---------------

"""""""""""""""""""""
``--mapping-quality``
"""""""""""""""""""""
      Minimium mapping quality (MAPQ) for a read to be retained. Default is 0.

""""""""""""""""""""
``--unmapped-reads``
""""""""""""""""""""
     How should unmapped reads be handled. Options are:
      - discard (default)
          Discard all unmapped reads
      - use
          If read2 is unmapped, deduplicate using read1 only. Requires
          ``--paired``
      - output
          Output unmapped reads/read pairs without UMI
          grouping/deduplication. Only available in umi_tools group

""""""""""""""""""""
``--chimeric-pairs``
""""""""""""""""""""
     How should chimeric read pairs be handled. Options are:
      - discard
          Discard all chimeric read pairs
      - use (default)
          Deduplicate using read1 only
      - output
          Output chimeric read pairs without UMI
          grouping/deduplication.  Only available in umi_tools group

""""""""""""""""""""
``--unpaired-reads``
""""""""""""""""""""
     How should unpaired reads be handled. Options are:
      - discard
          Discard all unpaired reads
      - use (default)
          Deduplicate using read1 only
      - output
          Output unpaired reads without UMI
          grouping/deduplication. Only available in umi_tools group

""""""""""""""""
``--ignore-umi``
""""""""""""""""
      Ignore the UMI and group reads using mapping coordinates only

""""""""""""
``--subset``
""""""""""""
      Only consider a fraction of the reads, chosen at random. This is useful
      for doing saturation analyses.

"""""""""""
``--chrom``
"""""""""""
      Only consider a single chromosome. This is useful for
      debugging/testing purposes


Input/Output Options
---------------------

"""""""""""""""""""""""
``--in-sam, --out-sam``
"""""""""""""""""""""""
      By default, inputs are assumed to be in BAM format and outputs are
written
      in BAM format. Use these options to specify the use of SAM format for
      input or output.

""""""""""""
``--paired``
""""""""""""
       BAM is paired end - output both read pairs. This will also
       force the use of the template length to determine reads with
       the same mapping coordinates.


Group/Dedup options
-------------------

""""""""""""""""""""
``--no-sort-output``
""""""""""""""""""""
       By default, output is sorted. This involves the
       use of a temporary unsorted file since reads are considered in
       the order of their start position which may not be the same
       as their alignment coordinate due to soft-clipping and reverse
       alignments. The temp file will be saved (in ``--temp-dir``) and deleted
       when it has been sorted to the outfile. Use this option to turn
       off sorting.


"""""""""""""""""""""""""
``--buffer-whole-contig``
"""""""""""""""""""""""""
      forces dedup to parse an entire contig before yielding any reads
      for deduplication. This is the only way to absolutely guarantee
      that all reads with the same start position are grouped together
      for deduplication since dedup uses the start position of the
      read, not the alignment coordinate on which the reads are
      sorted. However, by default, dedup reads for another 1000bp
      before outputting read groups which will avoid any reads being
      missed with short read sequencing (<1000bp).



Options:
  --version             show program's version number and exit

  dedup-specific options:
    --output-stats=STATS
                        Specify location to output stats

  Barcode extraction options:
    --extract-umi-method=GET_UMI_METHOD
                        how is the read UMI +/ cell barcode encoded?
                        [default=read_id]
    --umi-separator=UMI_SEP
                        separator between read id and UMI
    --umi-tag=UMI_TAG   tag containing umi
    --umi-tag-split=UMI_TAG_SPLIT
                        split UMI in tag and take the first element
    --umi-tag-delimiter=UMI_TAG_DELIM
                        concatenate UMI in tag separated by delimiter
    --cell-tag=CELL_TAG
                        tag containing cell barcode
    --cell-tag-split=CELL_TAG_SPLIT
                        split cell barcode in tag and take the first
                        elementfor e.g 10X GEM tags
    --cell-tag-delimiter=CELL_TAG_DELIM
                        concatenate cell barcode in tag separated by delimiter

  UMI grouping options:
    --method=METHOD     method to use for umi grouping [default=directional]
    --edit-distance-threshold=THRESHOLD
                        Edit distance theshold at which to join two UMIs when
                        grouping UMIs. [default=1]
    --spliced-is-unique
                        Treat a spliced read as different to an unspliced one
                        [default=False]
    --soft-clip-threshold=SOFT_CLIP_THRESHOLD
                        number of bases clipped from 5' end before read is
                        counted as spliced [default=4]
    --read-length       use read length in addition to position and UMI to
                        identify possible duplicates [default=False]

  single-cell RNA-Seq options:
    --per-gene          Group/Dedup/Count per gene. Must combine with either
                        --gene-tag or --per-contig
    --gene-tag=GENE_TAG
                        Gene is defined by this bam tag [default=none]
    --assigned-status-tag=ASSIGNED_TAG
                        Bam tag describing whether read is assigned to a gene
                        By defualt, this is set as the same tag as --gene-tag
    --skip-tags-regex=SKIP_REGEX
                        Used with --gene-tag. Ignore reads where the gene-tag
                        matches this regex
    --per-contig        group/dedup/count UMIs per contig (field 3 in BAM;
                        RNAME), e.g for transcriptome where contig = gene
    --gene-transcript-map=GENE_TRANSCRIPT_MAP
                        File mapping transcripts to genes (tab separated)
    --per-cell          group/dedup/count per cell

  group/dedup options:
    --buffer-whole-contig
                        Read whole contig before outputting bundles:
                        guarantees that no reads are missed, but increases
                        memory usage
    --multimapping-detection-method=DETECTION_METHOD
                        Some aligners identify multimapping using bam tags.
                        Setting this option to NH, X0 or XT will use these
                        tags when selecting the best read amongst reads with
                        the same position and umi [default=none]

  SAM/BAM options:
    --mapping-quality=MAPPING_QUALITY
                        Minimum mapping quality for a read to be retained
                        [default=0]
    --unmapped-reads=UNMAPPED_READS
                        How to handle unmapped reads. Options are 'discard',
                        'use' or 'correct' [default=discard]
    --chimeric-pairs=CHIMERIC_PAIRS
                        How to handle chimeric read pairs. Options are
                        'discard', 'use' or 'correct' [default=use]
    --unpaired-reads=UNPAIRED_READS
                        How to handle unpaired reads. Options are 'discard',
                        'use' or 'correct' [default=use]
    --ignore-umi        Ignore UMI and dedup only on position
    --chrom=CHROM       Restrict to one chromosome
    --subset=SUBSET     Use only a fraction of reads, specified by subset
    -i, --in-sam        Input file is in sam format [default=False]
    --paired            paired input BAM. [default=False]
    -o, --out-sam       Output alignments in sam format [default=False]
    --no-sort-output    Don't Sort the output

  input/output options:
    -I FILE, --stdin=FILE
                        file to read stdin from [default = stdin].
    -L FILE, --log=FILE
                        file with logging information [default = stdout].
    -E FILE, --error=FILE
                        file with error information [default = stderr].
    -S FILE, --stdout=FILE
                        file where output is to go [default = stdout].
    --temp-dir=FILE     Directory for temporary files. If not set, the bash
                        environmental variable TMPDIR is used[default = None].
    --log2stderr        send logging information to stderr [default = False].
    --compresslevel=COMPRESSLEVEL
                        Level of Gzip compression to use. Default (6)
                        matchesGNU gzip rather than python gzip default (which
                        is 9)

  profiling options:
    --timeit=TIMEIT_FILE
                        store timeing information in file [none].
    --timeit-name=TIMEIT_NAME
                        name in timing file for this class of jobs [all].
    --timeit-header     add header for timing information [none].

  common options:
    -v LOGLEVEL, --verbose=LOGLEVEL
                        loglevel [1]. The higher, the more output.
    -h, --help          output short help (command line options only).
    --help-extended     Output full documentation
    --random-seed=RANDOM_SEED
                        random seed to initialize number generator with
                        [none].
```
</details>
<br />

<a id="check-umi_tools-group---help"></a>
#### Check `umi_tools group --help`
<a id="--help-2"></a>
##### `--help`
<details>
<summary><i>--help</i></summary>

```txt
❯ umi_tools group --help
UMI-Tools: Version 1.0.1

group - Group reads based on their UMI

Usage: umi_tools group --output-bam [OPTIONS] [--stdin=INFILE.bam] [--stdout=OUTFILE.bam]

       note: If --stdout is ommited, standard out is output. To
             generate a valid BAM file on standard out, please
             redirect log with --log=LOGFILE or --log2stderr

For full UMI-tools documentation, see https://umi-tools.readthedocs.io/en/latest/

Options:
  --version             show program's version number and exit
  --umi-group-tag=UMI_GROUP_TAG
                        tag for the outputted umi group

  group-specific options:
    --group-out=TSV     Outfile name for file mapping read id to read group
    --output-bam        output a bam file with read groups tagged using the UG
                        tag[default=False]

  Barcode extraction options:
    --extract-umi-method=GET_UMI_METHOD
                        how is the read UMI +/ cell barcode encoded?
                        [default=read_id]
    --umi-separator=UMI_SEP
                        separator between read id and UMI
    --umi-tag=UMI_TAG   tag containing umi
    --umi-tag-split=UMI_TAG_SPLIT
                        split UMI in tag and take the first element
    --umi-tag-delimiter=UMI_TAG_DELIM
                        concatenate UMI in tag separated by delimiter
    --cell-tag=CELL_TAG
                        tag containing cell barcode
    --cell-tag-split=CELL_TAG_SPLIT
                        split cell barcode in tag and take the first
                        elementfor e.g 10X GEM tags
    --cell-tag-delimiter=CELL_TAG_DELIM
                        concatenate cell barcode in tag separated by delimiter

  UMI grouping options:
    --method=METHOD     method to use for umi grouping [default=directional]
    --edit-distance-threshold=THRESHOLD
                        Edit distance theshold at which to join two UMIs when
                        grouping UMIs. [default=1]
    --spliced-is-unique
                        Treat a spliced read as different to an unspliced one
                        [default=False]
    --soft-clip-threshold=SOFT_CLIP_THRESHOLD
                        number of bases clipped from 5' end before read is
                        counted as spliced [default=4]
    --read-length       use read length in addition to position and UMI to
                        identify possible duplicates [default=False]

  single-cell RNA-Seq options:
    --per-gene          Group/Dedup/Count per gene. Must combine with either
                        --gene-tag or --per-contig
    --gene-tag=GENE_TAG
                        Gene is defined by this bam tag [default=none]
    --assigned-status-tag=ASSIGNED_TAG
                        Bam tag describing whether read is assigned to a gene
                        By defualt, this is set as the same tag as --gene-tag
    --skip-tags-regex=SKIP_REGEX
                        Used with --gene-tag. Ignore reads where the gene-tag
                        matches this regex
    --per-contig        group/dedup/count UMIs per contig (field 3 in BAM;
                        RNAME), e.g for transcriptome where contig = gene
    --gene-transcript-map=GENE_TRANSCRIPT_MAP
                        File mapping transcripts to genes (tab separated)
    --per-cell          group/dedup/count per cell

  group/dedup options:
    --buffer-whole-contig
                        Read whole contig before outputting bundles:
                        guarantees that no reads are missed, but increases
                        memory usage
    --multimapping-detection-method=DETECTION_METHOD
                        Some aligners identify multimapping using bam tags.
                        Setting this option to NH, X0 or XT will use these
                        tags when selecting the best read amongst reads with
                        the same position and umi [default=none]

  SAM/BAM options:
    --mapping-quality=MAPPING_QUALITY
                        Minimum mapping quality for a read to be retained
                        [default=0]
    --unmapped-reads=UNMAPPED_READS
                        How to handle unmapped reads. Options are 'discard',
                        'use' or 'correct' [default=discard]
    --chimeric-pairs=CHIMERIC_PAIRS
                        How to handle chimeric read pairs. Options are
                        'discard', 'use' or 'correct' [default=use]
    --unpaired-reads=UNPAIRED_READS
                        How to handle unpaired reads. Options are 'discard',
                        'use' or 'correct' [default=use]
    --ignore-umi        Ignore UMI and dedup only on position
    --chrom=CHROM       Restrict to one chromosome
    --subset=SUBSET     Use only a fraction of reads, specified by subset
    -i, --in-sam        Input file is in sam format [default=False]
    --paired            paired input BAM. [default=False]
    -o, --out-sam       Output alignments in sam format [default=False]
    --no-sort-output    Don't Sort the output

  input/output options:
    -I FILE, --stdin=FILE
                        file to read stdin from [default = stdin].
    -L FILE, --log=FILE
                        file with logging information [default = stdout].
    -E FILE, --error=FILE
                        file with error information [default = stderr].
    -S FILE, --stdout=FILE
                        file where output is to go [default = stdout].
    --temp-dir=FILE     Directory for temporary files. If not set, the bash
                        environmental variable TMPDIR is used[default = None].
    --log2stderr        send logging information to stderr [default = False].
    --compresslevel=COMPRESSLEVEL
                        Level of Gzip compression to use. Default (6)
                        matchesGNU gzip rather than python gzip default (which
                        is 9)

  profiling options:
    --timeit=TIMEIT_FILE
                        store timeing information in file [none].
    --timeit-name=TIMEIT_NAME
                        name in timing file for this class of jobs [all].
    --timeit-header     add header for timing information [none].

  common options:
    -v LOGLEVEL, --verbose=LOGLEVEL
                        loglevel [1]. The higher, the more output.
    -h, --help          output short help (command line options only).
    --help-extended     Output full documentation
    --random-seed=RANDOM_SEED
                        random seed to initialize number generator with
                        [none].
```
</details>
<br />

<a id="--help-extended-2"></a>
##### `--help-extended`
<details>
<summary><i>--help-extended</i></summary>

```txt
❯ umi_tools group --help-extended
UMI-Tools: Version 1.0.1

group - Group reads based on their UMI

Usage: umi_tools group --output-bam [OPTIONS] [--stdin=INFILE.bam] [--stdout=OUTFILE.bam]

       note: If --stdout is ommited, standard out is output. To
             generate a valid BAM file on standard out, please
             redirect log with --log=LOGFILE or --log2stderr

For full UMI-tools documentation, see https://umi-tools.readthedocs.io/en/latest/


==============================================================
Group - Group reads based on their UMI and mapping coordinates
==============================================================

*Identify groups of reads based on their genomic coordinate and UMI*

The group command can be used to create two types of outfile: a tagged
BAM or a flatfile describing the read groups

To generate the tagged-BAM file, use the option ``--output-bam`` and
provide a filename with the ``--stdout``/``-S`` option. Alternatively,
if you do not provide a filename, the bam file will be outputted to
the stdout. If you have provided the ``--log``/``-L`` option to send
the logging output elsewhere, you can pipe the output from the group
command directly to e.g samtools view like so::

    umi_tools group -I inf.bam --group-out=grouped.tsv --output-bam
    --log=group.log --paired | samtools view - |less

The tagged-BAM file will have two tagged per read:

 - UG
   Unique_id. 0-indexed unique id number for each group of reads
   with the same genomic position and UMI or UMIs inferred to be
   from the same true UMI + errors
 - BX
   Final UMI. The inferred true UMI for the group

To generate the flatfile describing the read groups, include the
``--group-out=<filename>`` option. The columns of the read groups file are
below. The first five columns relate to the read. The final 3 columns
relate to the group.

  - read_id
      read identifier

  - contig
      alignment contig

  - position
      Alignment position. Note that this position is not the start
      position of the read in the BAM file but the start of the read
      taking into account the read strand and cigar

  - gene
      The gene assignment for the read. Note, this will be NA unless the
      --per-gene option is specified

  - umi
      The read UMI

  - umi_count
      The number of times this UMI is observed for reads at the same
      position

  - final_umi
      The inferred true UMI for the group

  - final_umi_count
      The total number of reads within the group

  - unique_id
      The unique id for the group


group-specific options
----------------------

"""""""""""
--group-out
"""""""""""
   Outfile name for file mapping read id to read group




Extracting barcodes
-------------------

It is assumed that the FASTQ files were processed with `umi_tools
extract` before mapping and thus the UMI is the last word of the read
name. e.g::

    @HISEQ:87:00000000_AATT

where `AATT` is the UMI sequeuence.

If you have used an alternative method which does not separate the
read id and UMI with a "_", such as bcl2fastq which uses ":", you can
specify the separator with the option ``--umi-separator=<sep>``,
replacing <sep> with e.g ":".

Alternatively, if your UMIs are encoded in a tag, you can specify this
by setting the option --extract-umi-method=tag and set the tag name
with the --umi-tag option. For example, if your UMIs are encoded in
the 'UM' tag, provide the following options:
``--extract-umi-method=tag`` ``--umi-tag=UM``

Finally, if you have used umis to extract the UMI +/- cell barcode,
you can specify ``--extract-umi-method=umis``

The start position of a read is considered to be the start of its alignment
minus any soft clipped bases. A read aligned at position 500 with
cigar 2S98M will be assumed to start at position 498.

""""""""""""""""""""""""
``--extract-umi-method``
""""""""""""""""""""""""
      How are the barcodes encoded in the read?

      Options are:

      - read_id (default)
            Barcodes are contained at the end of the read separated as
            specified with ``--umi-separator`` option

      - tag
            Barcodes contained in a tag(s), see ``--umi-tag``/``--cell-tag``
            options

      - umis
            Barcodes were extracted using umis (https://github.com/vals/umis)

"""""""""""""""""""""""""""""""
``--umi-separator=[SEPARATOR]``
"""""""""""""""""""""""""""""""
      Separator between read id and UMI. See ``--extract-umi-method``
      above. Default=``_``

"""""""""""""""""""
``--umi-tag=[TAG]``
"""""""""""""""""""
      Tag which contains UMI. See ``--extract-umi-method`` above

"""""""""""""""""""""""""""
``--umi-tag-split=[SPLIT]``
"""""""""""""""""""""""""""
      Separate the UMI in tag by SPLIT and take the first element

"""""""""""""""""""""""""""""""""""
``--umi-tag-delimiter=[DELIMITER]``
"""""""""""""""""""""""""""""""""""
      Separate the UMI in by DELIMITER and concatenate the elements

""""""""""""""""""""
``--cell-tag=[TAG]``
""""""""""""""""""""
      Tag which contains cell barcode. See `--extract-umi-method` above

""""""""""""""""""""""""""""
``--cell-tag-split=[SPLIT]``
""""""""""""""""""""""""""""
      Separate the cell barcode in tag by SPLIT and take the first element

""""""""""""""""""""""""""""""""""""
``--cell-tag-delimiter=[DELIMITER]``
""""""""""""""""""""""""""""""""""""
      Separate the cell barcode in by DELIMITER and concatenate the elements


UMI grouping options
---------------------------

""""""""""""
``--method``
""""""""""""
    What method to use to identify group of reads with the same (or
    similar) UMI(s)?

    All methods start by identifying the reads with the same mapping position.

    The simplest methods, unique and percentile, group reads with
    the exact same UMI. The network-based methods, cluster, adjacency and
    directional, build networks where nodes are UMIs and edges connect UMIs
    with an edit distance <= threshold (usually 1). The groups of reads
    are then defined from the network in a method-specific manner. For all
    the network-based methods, each read group is equivalent to one read
    count for the gene.

      - unique
          Reads group share the exact same UMI

      - percentile
          Reads group share the exact same UMI. UMIs with counts < 1% of the
          median counts for UMIs at the same position are ignored.

      - cluster
          Identify clusters of connected UMIs (based on hamming distance
          threshold). Each network is a read group

      - adjacency
          Cluster UMIs as above. For each cluster, select the node (UMI)
          with the highest counts. Visit all nodes one edge away. If all
          nodes have been visited, stop. Otherwise, repeat with remaining
          nodes until all nodes have been visted. Each step
          defines a read group.

      - directional (default)
          Identify clusters of connected UMIs (based on hamming distance
          threshold) and umi A counts >= (2* umi B counts) - 1. Each
          network is a read group.

"""""""""""""""""""""""""""""
``--edit-distance-threshold``
"""""""""""""""""""""""""""""
       For the adjacency and cluster methods the threshold for the
       edit distance to connect two UMIs in the network can be
       increased. The default value of 1 works best unless the UMI is
       very long (>14bp).

"""""""""""""""""""""""
``--spliced-is-unique``
"""""""""""""""""""""""
       Causes two reads that start in the same position on the same
       strand and having the same UMI to be considered unique if one is
spliced
       and the other is not. (Uses the 'N' cigar operation to test for
       splicing).

"""""""""""""""""""""""""
``--soft-clip-threshold``
"""""""""""""""""""""""""
       Mappers that soft clip will sometimes do so rather than mapping a
       spliced read if there is only a small overhang over the exon
       junction. By setting this option, you can treat reads with at least
       this many bases soft-clipped at the 3' end as spliced. Default=4.

""""""""""""""""""""""""""""""""""""""""""""""
``--multimapping-detection-method=[NH/X0/XT]``
""""""""""""""""""""""""""""""""""""""""""""""
      If the sam/bam contains tags to identify multimapping reads, you can
      specify for use when selecting the best read at a given loci.
      Supported tags are "NH", "X0" and "XT". If not specified, the read
      with the highest mapping quality will be selected.

"""""""""""""""""
``--read-length``
"""""""""""""""""
      Use the read length as a criteria when deduping, for e.g sRNA-Seq.


Single-cell RNA-Seq options
---------------------------

""""""""""""""
``--per-gene``
""""""""""""""
      Reads will be grouped together if they have the same gene.  This
      is useful if your library prep generates PCR duplicates with non
      identical alignment positions such as CEL-Seq. Note this option
      is hardcoded to be on with the count command. I.e counting is
      always performed per-gene. Must be combined with either
      ``--gene-tag`` or ``--per-contig`` option.

""""""""""""""
``--gene-tag``
""""""""""""""
      Deduplicate per gene. The gene information is encoded in the bam
      read tag specified

"""""""""""""""""""""""""
``--assigned-status-tag``
"""""""""""""""""""""""""
      BAM tag which describes whether a read is assigned to a
      gene. Defaults to the same value as given for ``--gene-tag``

"""""""""""""""""""""
``--skip-tags-regex``
"""""""""""""""""""""
      Use in conjunction with the ``--assigned-status-tag`` option to
      skip any reads where the tag matches this regex.  Default
      (``"^[__|Unassigned]"``) matches anything which starts with "__"
      or "Unassigned":

""""""""""""""""
``--per-contig``
""""""""""""""""
      Deduplicate per contig (field 3 in BAM; RNAME).
      All reads with the same contig will be considered to have the
      same alignment position. This is useful if you have aligned to a
      reference transcriptome with one transcript per gene. If you
      have aligned to a transcriptome with more than one transcript
      per gene, you can supply a map between transcripts and gene
      using the ``--gene-transcript-map`` option

"""""""""""""""""""""""""
``--gene-transcript-map``
"""""""""""""""""""""""""
      File mapping genes to transcripts (tab separated), e.g::

          gene1   transcript1
          gene1   transcript2
          gene2   transcript3

""""""""""""""
``--per-cell``
""""""""""""""
      Reads will only be grouped together if they have the same cell
      barcode. Can be combined with ``--per-gene``.

SAM/BAM Options
---------------

"""""""""""""""""""""
``--mapping-quality``
"""""""""""""""""""""
      Minimium mapping quality (MAPQ) for a read to be retained. Default is 0.

""""""""""""""""""""
``--unmapped-reads``
""""""""""""""""""""
     How should unmapped reads be handled. Options are:
      - discard (default)
          Discard all unmapped reads
      - use
          If read2 is unmapped, deduplicate using read1 only. Requires
          ``--paired``
      - output
          Output unmapped reads/read pairs without UMI
          grouping/deduplication. Only available in umi_tools group

""""""""""""""""""""
``--chimeric-pairs``
""""""""""""""""""""
     How should chimeric read pairs be handled. Options are:
      - discard
          Discard all chimeric read pairs
      - use (default)
          Deduplicate using read1 only
      - output
          Output chimeric read pairs without UMI
          grouping/deduplication.  Only available in umi_tools group

""""""""""""""""""""
``--unpaired-reads``
""""""""""""""""""""
     How should unpaired reads be handled. Options are:
      - discard
          Discard all unpaired reads
      - use (default)
          Deduplicate using read1 only
      - output
          Output unpaired reads without UMI
          grouping/deduplication. Only available in umi_tools group

""""""""""""""""
``--ignore-umi``
""""""""""""""""
      Ignore the UMI and group reads using mapping coordinates only

""""""""""""
``--subset``
""""""""""""
      Only consider a fraction of the reads, chosen at random. This is useful
      for doing saturation analyses.

"""""""""""
``--chrom``
"""""""""""
      Only consider a single chromosome. This is useful for
      debugging/testing purposes


Input/Output Options
---------------------

"""""""""""""""""""""""
``--in-sam, --out-sam``
"""""""""""""""""""""""
      By default, inputs are assumed to be in BAM format and outputs are
written
      in BAM format. Use these options to specify the use of SAM format for
      input or output.

""""""""""""
``--paired``
""""""""""""
       BAM is paired end - output both read pairs. This will also
       force the use of the template length to determine reads with
       the same mapping coordinates.


Group/Dedup options
-------------------

""""""""""""""""""""
``--no-sort-output``
""""""""""""""""""""
       By default, output is sorted. This involves the
       use of a temporary unsorted file since reads are considered in
       the order of their start position which may not be the same
       as their alignment coordinate due to soft-clipping and reverse
       alignments. The temp file will be saved (in ``--temp-dir``) and deleted
       when it has been sorted to the outfile. Use this option to turn
       off sorting.


"""""""""""""""""""""""""
``--buffer-whole-contig``
"""""""""""""""""""""""""
      forces dedup to parse an entire contig before yielding any reads
      for deduplication. This is the only way to absolutely guarantee
      that all reads with the same start position are grouped together
      for deduplication since dedup uses the start position of the
      read, not the alignment coordinate on which the reads are
      sorted. However, by default, dedup reads for another 1000bp
      before outputting read groups which will avoid any reads being
      missed with short read sequencing (<1000bp).



Options:
  --version             show program's version number and exit
  --umi-group-tag=UMI_GROUP_TAG
                        tag for the outputted umi group

  group-specific options:
    --group-out=TSV     Outfile name for file mapping read id to read group
    --output-bam        output a bam file with read groups tagged using the UG
                        tag[default=False]

  Barcode extraction options:
    --extract-umi-method=GET_UMI_METHOD
                        how is the read UMI +/ cell barcode encoded?
                        [default=read_id]
    --umi-separator=UMI_SEP
                        separator between read id and UMI
    --umi-tag=UMI_TAG   tag containing umi
    --umi-tag-split=UMI_TAG_SPLIT
                        split UMI in tag and take the first element
    --umi-tag-delimiter=UMI_TAG_DELIM
                        concatenate UMI in tag separated by delimiter
    --cell-tag=CELL_TAG
                        tag containing cell barcode
    --cell-tag-split=CELL_TAG_SPLIT
                        split cell barcode in tag and take the first
                        elementfor e.g 10X GEM tags
    --cell-tag-delimiter=CELL_TAG_DELIM
                        concatenate cell barcode in tag separated by delimiter

  UMI grouping options:
    --method=METHOD     method to use for umi grouping [default=directional]
    --edit-distance-threshold=THRESHOLD
                        Edit distance theshold at which to join two UMIs when
                        grouping UMIs. [default=1]
    --spliced-is-unique
                        Treat a spliced read as different to an unspliced one
                        [default=False]
    --soft-clip-threshold=SOFT_CLIP_THRESHOLD
                        number of bases clipped from 5' end before read is
                        counted as spliced [default=4]
    --read-length       use read length in addition to position and UMI to
                        identify possible duplicates [default=False]

  single-cell RNA-Seq options:
    --per-gene          Group/Dedup/Count per gene. Must combine with either
                        --gene-tag or --per-contig
    --gene-tag=GENE_TAG
                        Gene is defined by this bam tag [default=none]
    --assigned-status-tag=ASSIGNED_TAG
                        Bam tag describing whether read is assigned to a gene
                        By defualt, this is set as the same tag as --gene-tag
    --skip-tags-regex=SKIP_REGEX
                        Used with --gene-tag. Ignore reads where the gene-tag
                        matches this regex
    --per-contig        group/dedup/count UMIs per contig (field 3 in BAM;
                        RNAME), e.g for transcriptome where contig = gene
    --gene-transcript-map=GENE_TRANSCRIPT_MAP
                        File mapping transcripts to genes (tab separated)
    --per-cell          group/dedup/count per cell

  group/dedup options:
    --buffer-whole-contig
                        Read whole contig before outputting bundles:
                        guarantees that no reads are missed, but increases
                        memory usage
    --multimapping-detection-method=DETECTION_METHOD
                        Some aligners identify multimapping using bam tags.
                        Setting this option to NH, X0 or XT will use these
                        tags when selecting the best read amongst reads with
                        the same position and umi [default=none]

  SAM/BAM options:
    --mapping-quality=MAPPING_QUALITY
                        Minimum mapping quality for a read to be retained
                        [default=0]
    --unmapped-reads=UNMAPPED_READS
                        How to handle unmapped reads. Options are 'discard',
                        'use' or 'correct' [default=discard]
    --chimeric-pairs=CHIMERIC_PAIRS
                        How to handle chimeric read pairs. Options are
                        'discard', 'use' or 'correct' [default=use]
    --unpaired-reads=UNPAIRED_READS
                        How to handle unpaired reads. Options are 'discard',
                        'use' or 'correct' [default=use]
    --ignore-umi        Ignore UMI and dedup only on position
    --chrom=CHROM       Restrict to one chromosome
    --subset=SUBSET     Use only a fraction of reads, specified by subset
    -i, --in-sam        Input file is in sam format [default=False]
    --paired            paired input BAM. [default=False]
    -o, --out-sam       Output alignments in sam format [default=False]
    --no-sort-output    Don't Sort the output

  input/output options:
    -I FILE, --stdin=FILE
                        file to read stdin from [default = stdin].
    -L FILE, --log=FILE
                        file with logging information [default = stdout].
    -E FILE, --error=FILE
                        file with error information [default = stderr].
    -S FILE, --stdout=FILE
                        file where output is to go [default = stdout].
    --temp-dir=FILE     Directory for temporary files. If not set, the bash
                        environmental variable TMPDIR is used[default = None].
    --log2stderr        send logging information to stderr [default = False].
    --compresslevel=COMPRESSLEVEL
                        Level of Gzip compression to use. Default (6)
                        matchesGNU gzip rather than python gzip default (which
                        is 9)

  profiling options:
    --timeit=TIMEIT_FILE
                        store timeing information in file [none].
    --timeit-name=TIMEIT_NAME
                        name in timing file for this class of jobs [all].
    --timeit-header     add header for timing information [none].

  common options:
    -v LOGLEVEL, --verbose=LOGLEVEL
                        loglevel [1]. The higher, the more output.
    -h, --help          output short help (command line options only).
    --help-extended     Output full documentation
    --random-seed=RANDOM_SEED
                        random seed to initialize number generator with
                        [none].
```
</details>
<br />

<a id="make-a-directory-for-the-trial-with-umi_tools-extract-etc"></a>
### Make a directory for the trial with `umi_tools extract`, etc.
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Make a directory for the trial with umi_tools extract, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir test_UMI-processing_umi-tools/
```
</details>
<br />

<a id="set-up-necessary-variables-1"></a>
### Set up necessary variables
<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Files ------------------------------
., "${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
., "${HOME}/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla"
., "${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119"
., "${HOME}/tsukiyamalab/alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119"


#  Example 1 --------------------------
p_fq_1="${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
p_fq_1_o="test_UMI-processing_umi-tools"

f_fq_1_bar="${p_fq_1}/5782_Q_IN_S8_R2_001.fastq.gz"
f_fq_1_l="${p_fq_1}/5782_Q_IN_S8_R1_001.fastq.gz"
f_fq_1_r="${p_fq_1}/5782_Q_IN_S8_R3_001.fastq.gz"

f_fq_1_l_pro="${p_fq_1_o}/5782_Q_IN_S8_R1_001.UMIs.fastq.gz"
f_fq_1_r_pro="${p_fq_1_o}/5782_Q_IN_S8_R3_001.UMIs.fastq.gz"

echo "${f_fq_1_bar}"
echo "${f_fq_1_l}"
echo "${f_fq_1_r}"
echo "${f_fq_1_l_pro}"
echo "${f_fq_1_r_pro}"

., "${f_fq_1_bar}"
., "${f_fq_1_l}"
., "${f_fq_1_r}"


#  Example 2 --------------------------
p_fq_2="${HOME}/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119"
p_fq_2_o="test_UMI-processing_umi-tools"

f_fq_2_bar="${p_fq_2}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz"
f_fq_2_l="${p_fq_2}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz"
f_fq_2_r="${p_fq_2}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz"

f_fq_2_l_pro="${p_fq_2_o}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz"
f_fq_2_r_pro="${p_fq_2_o}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz"

echo "${f_fq_2_bar}"
echo "${f_fq_2_l}"
echo "${f_fq_2_r}"
echo "${f_fq_2_l_pro}"
echo "${f_fq_2_r_pro}"

., "${f_fq_2_bar}"
., "${f_fq_2_l}"
., "${f_fq_2_r}"
```
</details>
<br />

<a id="run-umi_tools-extract"></a>
### Run `umi_tools extract`
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Run umi_tools extract</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Example 1 --------------------------
umi_tools extract \
    --bc-pattern=NNNNNNNN \
    --stdin="${f_fq_1_bar}" \
    --read2-in="${f_fq_1_l}" \
    --stdout="${f_fq_1_l_pro}" \
    --read2-stdout

umi_tools extract \
    --bc-pattern=NNNNNNNN \
    --stdin="${f_fq_1_bar}" \
    --read2-in="${f_fq_1_r}" \
    --stdout="${f_fq_1_r_pro}" \
    --read2-stdout


#  Example 2 --------------------------
umi_tools extract \
    --bc-pattern=NNNNNNNN \
    --stdin="${f_fq_2_bar}" \
    --read2-in="${f_fq_2_l}" \
    --stdout="${f_fq_2_l_pro}" \
    --read2-stdout

umi_tools extract \
    --bc-pattern=NNNNNNNN \
    --stdin="${f_fq_2_bar}" \
    --read2-in="${f_fq_2_r}" \
    --stdout="${f_fq_2_r_pro}" \
    --read2-stdout
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Run umi_tools extract</i></summary>

```txt
❯ umi_tools extract \
>     --bc-pattern=NNNNNNNN \
>     --stdin="${f_fq_1_bar}" \
>     --read2-in="${f_fq_1_l}" \
>     --stdout="${f_fq_1_l_pro}" \
>     --read2-stdout
# UMI-tools version: 1.0.1
# output generated by extract --bc-pattern=NNNNNNNN --stdin=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz --read2-in=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz --stdout=test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz --read2-stdout
# job started at Mon Jan 30 08:28:03 2023 on gizmoj10 -- 63d26a30-8cde-483f-9517-bcb196c81406
# pid: 12002, system: Linux 4.15.0-192-generic #203-Ubuntu SMP Wed Aug 10 17:40:03 UTC 2022 x86_64
# blacklist                               : None
# compresslevel                           : 6
# either_read                             : False
# either_read_resolve                     : discard
# error_correct_cell                      : False
# extract_method                          : string
# filter_cell_barcode                     : None
# filter_cell_barcodes                    : False
# log2stderr                              : False
# loglevel                                : 1
# pattern                                 : NNNNNNNN
# pattern2                                : None
# prime3                                  : None
# quality_encoding                        : None
# quality_filter_mask                     : None
# quality_filter_threshold                : None
# random_seed                             : None
# read2_in                                : /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
# read2_out                               : False
# read2_stdout                            : True
# reads_subset                            : None
# reconcile                               : False
# retain_umi                              : None
# short_help                              : None
# stderr                                  : <_io.TextIOWrapper name='<stderr>' mode='w' encoding='UTF-8'>
# stdin                                   : <_io.TextIOWrapper name='/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz' encoding='ascii'>
# stdlog                                  : <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
# stdout                                  : <_io.TextIOWrapper name='test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz' encoding='ascii'>
# timeit_file                             : None
# timeit_header                           : None
# timeit_name                             : all
# tmpdir                                  : None
# whitelist                               : None
2023-01-30 08:28:03,208 INFO Starting barcode extraction
2023-01-30 08:28:06,158 INFO Parsed 100000 reads
2023-01-30 08:28:08,816 INFO Parsed 200000 reads
2023-01-30 08:28:11,479 INFO Parsed 300000 reads
2023-01-30 08:28:14,107 INFO Parsed 400000 reads
2023-01-30 08:28:16,757 INFO Parsed 500000 reads
2023-01-30 08:28:19,408 INFO Parsed 600000 reads
2023-01-30 08:28:22,036 INFO Parsed 700000 reads
2023-01-30 08:28:24,677 INFO Parsed 800000 reads
2023-01-30 08:28:27,342 INFO Parsed 900000 reads
2023-01-30 08:28:30,024 INFO Parsed 1000000 reads
2023-01-30 08:28:32,713 INFO Parsed 1100000 reads
2023-01-30 08:28:35,392 INFO Parsed 1200000 reads
2023-01-30 08:28:38,071 INFO Parsed 1300000 reads
2023-01-30 08:28:40,781 INFO Parsed 1400000 reads
2023-01-30 08:28:43,456 INFO Parsed 1500000 reads
2023-01-30 08:28:46,152 INFO Parsed 1600000 reads
2023-01-30 08:28:48,826 INFO Parsed 1700000 reads
2023-01-30 08:28:51,551 INFO Parsed 1800000 reads
2023-01-30 08:28:54,260 INFO Parsed 1900000 reads
2023-01-30 08:28:57,015 INFO Parsed 2000000 reads
2023-01-30 08:28:59,779 INFO Parsed 2100000 reads
2023-01-30 08:29:02,539 INFO Parsed 2200000 reads
2023-01-30 08:29:05,301 INFO Parsed 2300000 reads
2023-01-30 08:29:08,035 INFO Parsed 2400000 reads
2023-01-30 08:29:10,743 INFO Parsed 2500000 reads
2023-01-30 08:29:13,451 INFO Parsed 2600000 reads
2023-01-30 08:29:16,133 INFO Parsed 2700000 reads
2023-01-30 08:29:18,815 INFO Parsed 2800000 reads
2023-01-30 08:29:21,476 INFO Parsed 2900000 reads
2023-01-30 08:29:24,123 INFO Parsed 3000000 reads
2023-01-30 08:29:26,789 INFO Parsed 3100000 reads
2023-01-30 08:29:29,487 INFO Parsed 3200000 reads
2023-01-30 08:29:32,173 INFO Parsed 3300000 reads
2023-01-30 08:29:34,832 INFO Parsed 3400000 reads
2023-01-30 08:29:37,518 INFO Parsed 3500000 reads
2023-01-30 08:29:40,194 INFO Parsed 3600000 reads
2023-01-30 08:29:42,885 INFO Parsed 3700000 reads
2023-01-30 08:29:45,604 INFO Parsed 3800000 reads
2023-01-30 08:29:48,322 INFO Parsed 3900000 reads
2023-01-30 08:29:51,030 INFO Parsed 4000000 reads
2023-01-30 08:29:53,751 INFO Parsed 4100000 reads
2023-01-30 08:29:56,445 INFO Parsed 4200000 reads
2023-01-30 08:29:59,126 INFO Parsed 4300000 reads
2023-01-30 08:30:01,847 INFO Parsed 4400000 reads
2023-01-30 08:30:04,580 INFO Parsed 4500000 reads
2023-01-30 08:30:07,308 INFO Parsed 4600000 reads
2023-01-30 08:30:10,028 INFO Parsed 4700000 reads
2023-01-30 08:30:12,760 INFO Parsed 4800000 reads
2023-01-30 08:30:15,517 INFO Parsed 4900000 reads
2023-01-30 08:30:18,264 INFO Parsed 5000000 reads
2023-01-30 08:30:20,985 INFO Parsed 5100000 reads
2023-01-30 08:30:23,739 INFO Parsed 5200000 reads
2023-01-30 08:30:26,507 INFO Parsed 5300000 reads
2023-01-30 08:30:29,191 INFO Parsed 5400000 reads
2023-01-30 08:30:31,785 INFO Parsed 5500000 reads
2023-01-30 08:30:34,405 INFO Parsed 5600000 reads
2023-01-30 08:30:37,037 INFO Parsed 5700000 reads
2023-01-30 08:30:39,685 INFO Parsed 5800000 reads
2023-01-30 08:30:42,333 INFO Parsed 5900000 reads
2023-01-30 08:30:44,970 INFO Parsed 6000000 reads
2023-01-30 08:30:47,636 INFO Parsed 6100000 reads
2023-01-30 08:30:50,286 INFO Parsed 6200000 reads
2023-01-30 08:30:52,958 INFO Parsed 6300000 reads
2023-01-30 08:30:55,590 INFO Parsed 6400000 reads
2023-01-30 08:30:58,262 INFO Parsed 6500000 reads
2023-01-30 08:31:00,930 INFO Parsed 6600000 reads
2023-01-30 08:31:03,574 INFO Parsed 6700000 reads
2023-01-30 08:31:06,252 INFO Parsed 6800000 reads
2023-01-30 08:31:08,933 INFO Parsed 6900000 reads
2023-01-30 08:31:11,565 INFO Parsed 7000000 reads
2023-01-30 08:31:14,292 INFO Parsed 7100000 reads
2023-01-30 08:31:16,936 INFO Parsed 7200000 reads
2023-01-30 08:31:19,597 INFO Parsed 7300000 reads
2023-01-30 08:31:22,260 INFO Parsed 7400000 reads
2023-01-30 08:31:24,945 INFO Parsed 7500000 reads
2023-01-30 08:31:27,640 INFO Parsed 7600000 reads
2023-01-30 08:31:30,351 INFO Parsed 7700000 reads
2023-01-30 08:31:33,074 INFO Parsed 7800000 reads
2023-01-30 08:31:35,766 INFO Parsed 7900000 reads
2023-01-30 08:31:38,405 INFO Parsed 8000000 reads
2023-01-30 08:31:41,058 INFO Parsed 8100000 reads
2023-01-30 08:31:43,685 INFO Parsed 8200000 reads
2023-01-30 08:31:46,324 INFO Parsed 8300000 reads
2023-01-30 08:31:48,978 INFO Parsed 8400000 reads
2023-01-30 08:31:51,658 INFO Parsed 8500000 reads
2023-01-30 08:31:54,315 INFO Parsed 8600000 reads
2023-01-30 08:31:56,979 INFO Parsed 8700000 reads
2023-01-30 08:31:59,650 INFO Parsed 8800000 reads
2023-01-30 08:32:02,331 INFO Parsed 8900000 reads
2023-01-30 08:32:05,000 INFO Parsed 9000000 reads
2023-01-30 08:32:07,667 INFO Parsed 9100000 reads
2023-01-30 08:32:10,336 INFO Parsed 9200000 reads
2023-01-30 08:32:13,006 INFO Parsed 9300000 reads
2023-01-30 08:32:15,674 INFO Parsed 9400000 reads
2023-01-30 08:32:18,332 INFO Parsed 9500000 reads
2023-01-30 08:32:20,971 INFO Parsed 9600000 reads
2023-01-30 08:32:23,633 INFO Parsed 9700000 reads
2023-01-30 08:32:26,331 INFO Parsed 9800000 reads
2023-01-30 08:32:29,021 INFO Parsed 9900000 reads
2023-01-30 08:32:31,690 INFO Parsed 10000000 reads
2023-01-30 08:32:34,393 INFO Parsed 10100000 reads
2023-01-30 08:32:37,107 INFO Parsed 10200000 reads
2023-01-30 08:32:39,830 INFO Parsed 10300000 reads
2023-01-30 08:32:42,546 INFO Parsed 10400000 reads
2023-01-30 08:32:45,277 INFO Parsed 10500000 reads
2023-01-30 08:32:47,981 INFO Parsed 10600000 reads
2023-01-30 08:32:48,120 INFO Input Reads: 10605037
2023-01-30 08:32:48,120 INFO Reads output: 10605037
# job finished in 284 seconds at Mon Jan 30 08:32:48 2023 -- 284.36  0.73  0.00  0.00 -- 63d26a30-8cde-483f-9517-bcb196c81406

❯ umi_tools extract \
>     --bc-pattern=NNNNNNNN \
>     --stdin="${f_fq_1_bar}" \
>     --read2-in="${f_fq_1_r}" \
>     --stdout="${f_fq_1_r_pro}" \
>     --read2-stdout
# UMI-tools version: 1.0.1
# output generated by extract --bc-pattern=NNNNNNNN --stdin=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz --read2-in=/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz --stdout=test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz --read2-stdout
# job started at Mon Jan 30 08:32:50 2023 on gizmoj10 -- e547eb72-422c-4493-bb6e-5371c1ec3277
# pid: 12465, system: Linux 4.15.0-192-generic #203-Ubuntu SMP Wed Aug 10 17:40:03 UTC 2022 x86_64
# blacklist                               : None
# compresslevel                           : 6
# either_read                             : False
# either_read_resolve                     : discard
# error_correct_cell                      : False
# extract_method                          : string
# filter_cell_barcode                     : None
# filter_cell_barcodes                    : False
# log2stderr                              : False
# loglevel                                : 1
# pattern                                 : NNNNNNNN
# pattern2                                : None
# prime3                                  : None
# quality_encoding                        : None
# quality_filter_mask                     : None
# quality_filter_threshold                : None
# random_seed                             : None
# read2_in                                : /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
# read2_out                               : False
# read2_stdout                            : True
# reads_subset                            : None
# reconcile                               : False
# retain_umi                              : None
# short_help                              : None
# stderr                                  : <_io.TextIOWrapper name='<stderr>' mode='w' encoding='UTF-8'>
# stdin                                   : <_io.TextIOWrapper name='/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz' encoding='ascii'>
# stdlog                                  : <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
# stdout                                  : <_io.TextIOWrapper name='test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz' encoding='ascii'>
# timeit_file                             : None
# timeit_header                           : None
# timeit_name                             : all
# tmpdir                                  : None
# whitelist                               : None
2023-01-30 08:32:50,181 INFO Starting barcode extraction
2023-01-30 08:32:53,214 INFO Parsed 100000 reads
2023-01-30 08:32:55,943 INFO Parsed 200000 reads
2023-01-30 08:32:58,690 INFO Parsed 300000 reads
2023-01-30 08:33:01,440 INFO Parsed 400000 reads
2023-01-30 08:33:04,200 INFO Parsed 500000 reads
2023-01-30 08:33:06,980 INFO Parsed 600000 reads
2023-01-30 08:33:09,714 INFO Parsed 700000 reads
2023-01-30 08:33:12,477 INFO Parsed 800000 reads
2023-01-30 08:33:15,252 INFO Parsed 900000 reads
2023-01-30 08:33:18,028 INFO Parsed 1000000 reads
2023-01-30 08:33:20,792 INFO Parsed 1100000 reads
2023-01-30 08:33:23,549 INFO Parsed 1200000 reads
2023-01-30 08:33:26,322 INFO Parsed 1300000 reads
2023-01-30 08:33:29,146 INFO Parsed 1400000 reads
2023-01-30 08:33:31,933 INFO Parsed 1500000 reads
2023-01-30 08:33:34,708 INFO Parsed 1600000 reads
2023-01-30 08:33:37,502 INFO Parsed 1700000 reads
2023-01-30 08:33:40,291 INFO Parsed 1800000 reads
2023-01-30 08:33:43,106 INFO Parsed 1900000 reads
2023-01-30 08:33:45,943 INFO Parsed 2000000 reads
2023-01-30 08:33:48,768 INFO Parsed 2100000 reads
2023-01-30 08:33:51,659 INFO Parsed 2200000 reads
2023-01-30 08:33:54,479 INFO Parsed 2300000 reads
2023-01-30 08:33:57,506 INFO Parsed 2400000 reads
2023-01-30 08:34:00,288 INFO Parsed 2500000 reads
2023-01-30 08:34:03,063 INFO Parsed 2600000 reads
2023-01-30 08:34:05,821 INFO Parsed 2700000 reads
2023-01-30 08:34:08,572 INFO Parsed 2800000 reads
2023-01-30 08:34:11,342 INFO Parsed 2900000 reads
2023-01-30 08:34:14,095 INFO Parsed 3000000 reads
2023-01-30 08:34:16,849 INFO Parsed 3100000 reads
2023-01-30 08:34:19,607 INFO Parsed 3200000 reads
2023-01-30 08:34:22,368 INFO Parsed 3300000 reads
2023-01-30 08:34:25,160 INFO Parsed 3400000 reads
2023-01-30 08:34:27,957 INFO Parsed 3500000 reads
2023-01-30 08:34:30,754 INFO Parsed 3600000 reads
2023-01-30 08:34:33,535 INFO Parsed 3700000 reads
2023-01-30 08:34:36,333 INFO Parsed 3800000 reads
2023-01-30 08:34:39,111 INFO Parsed 3900000 reads
2023-01-30 08:34:41,902 INFO Parsed 4000000 reads
2023-01-30 08:34:44,701 INFO Parsed 4100000 reads
2023-01-30 08:34:47,501 INFO Parsed 4200000 reads
2023-01-30 08:34:50,292 INFO Parsed 4300000 reads
2023-01-30 08:34:53,072 INFO Parsed 4400000 reads
2023-01-30 08:34:55,876 INFO Parsed 4500000 reads
2023-01-30 08:34:58,666 INFO Parsed 4600000 reads
2023-01-30 08:35:01,487 INFO Parsed 4700000 reads
2023-01-30 08:35:04,292 INFO Parsed 4800000 reads
2023-01-30 08:35:07,147 INFO Parsed 4900000 reads
2023-01-30 08:35:09,966 INFO Parsed 5000000 reads
2023-01-30 08:35:12,778 INFO Parsed 5100000 reads
2023-01-30 08:35:15,627 INFO Parsed 5200000 reads
2023-01-30 08:35:18,498 INFO Parsed 5300000 reads
2023-01-30 08:35:21,297 INFO Parsed 5400000 reads
2023-01-30 08:35:24,019 INFO Parsed 5500000 reads
2023-01-30 08:35:26,748 INFO Parsed 5600000 reads
2023-01-30 08:35:29,438 INFO Parsed 5700000 reads
2023-01-30 08:35:32,272 INFO Parsed 5800000 reads
2023-01-30 08:35:35,053 INFO Parsed 5900000 reads
2023-01-30 08:35:37,771 INFO Parsed 6000000 reads
2023-01-30 08:35:40,544 INFO Parsed 6100000 reads
2023-01-30 08:35:43,280 INFO Parsed 6200000 reads
2023-01-30 08:35:46,014 INFO Parsed 6300000 reads
2023-01-30 08:35:48,751 INFO Parsed 6400000 reads
2023-01-30 08:35:51,469 INFO Parsed 6500000 reads
2023-01-30 08:35:54,206 INFO Parsed 6600000 reads
2023-01-30 08:35:56,958 INFO Parsed 6700000 reads
2023-01-30 08:35:59,734 INFO Parsed 6800000 reads
2023-01-30 08:36:02,505 INFO Parsed 6900000 reads
2023-01-30 08:36:05,237 INFO Parsed 7000000 reads
2023-01-30 08:36:07,984 INFO Parsed 7100000 reads
2023-01-30 08:36:10,746 INFO Parsed 7200000 reads
2023-01-30 08:36:13,535 INFO Parsed 7300000 reads
2023-01-30 08:36:16,318 INFO Parsed 7400000 reads
2023-01-30 08:36:19,074 INFO Parsed 7500000 reads
2023-01-30 08:36:21,862 INFO Parsed 7600000 reads
2023-01-30 08:36:24,610 INFO Parsed 7700000 reads
2023-01-30 08:36:27,380 INFO Parsed 7800000 reads
2023-01-30 08:36:30,168 INFO Parsed 7900000 reads
2023-01-30 08:36:32,890 INFO Parsed 8000000 reads
2023-01-30 08:36:35,598 INFO Parsed 8100000 reads
2023-01-30 08:36:38,303 INFO Parsed 8200000 reads
2023-01-30 08:36:41,018 INFO Parsed 8300000 reads
2023-01-30 08:36:43,739 INFO Parsed 8400000 reads
2023-01-30 08:36:46,492 INFO Parsed 8500000 reads
2023-01-30 08:36:49,230 INFO Parsed 8600000 reads
2023-01-30 08:36:51,969 INFO Parsed 8700000 reads
2023-01-30 08:36:54,739 INFO Parsed 8800000 reads
2023-01-30 08:36:57,500 INFO Parsed 8900000 reads
2023-01-30 08:37:00,241 INFO Parsed 9000000 reads
2023-01-30 08:37:03,006 INFO Parsed 9100000 reads
2023-01-30 08:37:05,762 INFO Parsed 9200000 reads
2023-01-30 08:37:08,495 INFO Parsed 9300000 reads
2023-01-30 08:37:11,259 INFO Parsed 9400000 reads
2023-01-30 08:37:14,032 INFO Parsed 9500000 reads
2023-01-30 08:37:16,811 INFO Parsed 9600000 reads
2023-01-30 08:37:19,557 INFO Parsed 9700000 reads
2023-01-30 08:37:22,325 INFO Parsed 9800000 reads
2023-01-30 08:37:25,084 INFO Parsed 9900000 reads
2023-01-30 08:37:27,857 INFO Parsed 10000000 reads
2023-01-30 08:37:30,651 INFO Parsed 10100000 reads
2023-01-30 08:37:33,448 INFO Parsed 10200000 reads
2023-01-30 08:37:36,259 INFO Parsed 10300000 reads
2023-01-30 08:37:39,064 INFO Parsed 10400000 reads
2023-01-30 08:37:41,864 INFO Parsed 10500000 reads
2023-01-30 08:37:44,720 INFO Parsed 10600000 reads
2023-01-30 08:37:44,863 INFO Input Reads: 10605037
2023-01-30 08:37:44,863 INFO Reads output: 10605037
# job finished in 294 seconds at Mon Jan 30 08:37:44 2023 -- 293.98  0.65  0.00  0.00 -- e547eb72-422c-4493-bb6e-5371c1ec3277

❯ umi_tools extract \
>     --bc-pattern=NNNNNNNN \
>     --stdin="${f_fq_2_bar}" \
>     --read2-in="${f_fq_2_l}" \
>     --stdout="${f_fq_2_l_pro}" \
>     --read2-stdout
# UMI-tools version: 1.0.1
# output generated by extract --bc-pattern=NNNNNNNN --stdin=/home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz --read2-in=/home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz --stdout=test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz --read2-stdout
# job started at Mon Jan 30 09:50:35 2023 on gizmoj10 -- 7c26f0b9-d930-45b1-a4aa-9c8213f18d03
# pid: 24919, system: Linux 4.15.0-192-generic #203-Ubuntu SMP Wed Aug 10 17:40:03 UTC 2022 x86_64
# blacklist                               : None
# compresslevel                           : 6
# either_read                             : False
# either_read_resolve                     : discard
# error_correct_cell                      : False
# extract_method                          : string
# filter_cell_barcode                     : None
# filter_cell_barcodes                    : False
# log2stderr                              : False
# loglevel                                : 1
# pattern                                 : NNNNNNNN
# pattern2                                : None
# prime3                                  : None
# quality_encoding                        : None
# quality_filter_mask                     : None
# quality_filter_threshold                : None
# random_seed                             : None
# read2_in                                : /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
# read2_out                               : False
# read2_stdout                            : True
# reads_subset                            : None
# reconcile                               : False
# retain_umi                              : None
# short_help                              : None
# stderr                                  : <_io.TextIOWrapper name='<stderr>' mode='w' encoding='UTF-8'>
# stdin                                   : <_io.TextIOWrapper name='/home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz' encoding='ascii'>
# stdlog                                  : <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
# stdout                                  : <_io.TextIOWrapper name='test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz' encoding='ascii'>
# timeit_file                             : None
# timeit_header                           : None
# timeit_name                             : all
# tmpdir                                  : None
# whitelist                               : None
2023-01-30 09:50:35,503 INFO Starting barcode extraction
2023-01-30 09:50:38,309 INFO Parsed 100000 reads
2023-01-30 09:50:40,725 INFO Parsed 200000 reads
2023-01-30 09:50:43,150 INFO Parsed 300000 reads
2023-01-30 09:50:45,581 INFO Parsed 400000 reads
2023-01-30 09:50:48,025 INFO Parsed 500000 reads
2023-01-30 09:50:50,436 INFO Parsed 600000 reads
2023-01-30 09:50:52,847 INFO Parsed 700000 reads
2023-01-30 09:50:55,263 INFO Parsed 800000 reads
2023-01-30 09:50:57,674 INFO Parsed 900000 reads
2023-01-30 09:51:00,091 INFO Parsed 1000000 reads
2023-01-30 09:51:02,544 INFO Parsed 1100000 reads
2023-01-30 09:51:04,962 INFO Parsed 1200000 reads
2023-01-30 09:51:07,372 INFO Parsed 1300000 reads
2023-01-30 09:51:09,791 INFO Parsed 1400000 reads
2023-01-30 09:51:12,208 INFO Parsed 1500000 reads
2023-01-30 09:51:14,618 INFO Parsed 1600000 reads
2023-01-30 09:51:17,026 INFO Parsed 1700000 reads
2023-01-30 09:51:19,441 INFO Parsed 1800000 reads
2023-01-30 09:51:21,878 INFO Parsed 1900000 reads
2023-01-30 09:51:24,298 INFO Parsed 2000000 reads
2023-01-30 09:51:26,730 INFO Parsed 2100000 reads
2023-01-30 09:51:29,178 INFO Parsed 2200000 reads
2023-01-30 09:51:31,589 INFO Parsed 2300000 reads
2023-01-30 09:51:34,001 INFO Parsed 2400000 reads
2023-01-30 09:51:36,435 INFO Parsed 2500000 reads
2023-01-30 09:51:38,897 INFO Parsed 2600000 reads
2023-01-30 09:51:41,333 INFO Parsed 2700000 reads
2023-01-30 09:51:43,773 INFO Parsed 2800000 reads
2023-01-30 09:51:46,217 INFO Parsed 2900000 reads
2023-01-30 09:51:48,645 INFO Parsed 3000000 reads
2023-01-30 09:51:51,083 INFO Parsed 3100000 reads
2023-01-30 09:51:53,540 INFO Parsed 3200000 reads
2023-01-30 09:51:56,008 INFO Parsed 3300000 reads
2023-01-30 09:51:58,448 INFO Parsed 3400000 reads
2023-01-30 09:52:00,923 INFO Parsed 3500000 reads
2023-01-30 09:52:03,370 INFO Parsed 3600000 reads
2023-01-30 09:52:05,815 INFO Parsed 3700000 reads
2023-01-30 09:52:08,236 INFO Parsed 3800000 reads
2023-01-30 09:52:10,691 INFO Parsed 3900000 reads
2023-01-30 09:52:13,169 INFO Parsed 4000000 reads
2023-01-30 09:52:15,619 INFO Parsed 4100000 reads
2023-01-30 09:52:18,068 INFO Parsed 4200000 reads
2023-01-30 09:52:20,551 INFO Parsed 4300000 reads
2023-01-30 09:52:22,965 INFO Parsed 4400000 reads
2023-01-30 09:52:25,399 INFO Parsed 4500000 reads
2023-01-30 09:52:27,863 INFO Parsed 4600000 reads
2023-01-30 09:52:30,333 INFO Parsed 4700000 reads
2023-01-30 09:52:32,800 INFO Parsed 4800000 reads
2023-01-30 09:52:35,275 INFO Parsed 4900000 reads
2023-01-30 09:52:37,731 INFO Parsed 5000000 reads
2023-01-30 09:52:40,169 INFO Parsed 5100000 reads
2023-01-30 09:52:42,598 INFO Parsed 5200000 reads
2023-01-30 09:52:45,077 INFO Parsed 5300000 reads
2023-01-30 09:52:47,512 INFO Parsed 5400000 reads
2023-01-30 09:52:49,953 INFO Parsed 5500000 reads
2023-01-30 09:52:52,434 INFO Parsed 5600000 reads
2023-01-30 09:52:55,005 INFO Parsed 5700000 reads
2023-01-30 09:52:57,436 INFO Parsed 5800000 reads
2023-01-30 09:52:59,898 INFO Parsed 5900000 reads
2023-01-30 09:53:02,345 INFO Parsed 6000000 reads
2023-01-30 09:53:04,812 INFO Parsed 6100000 reads
2023-01-30 09:53:07,237 INFO Parsed 6200000 reads
2023-01-30 09:53:09,686 INFO Parsed 6300000 reads
2023-01-30 09:53:12,127 INFO Parsed 6400000 reads
2023-01-30 09:53:14,567 INFO Parsed 6500000 reads
2023-01-30 09:53:17,017 INFO Parsed 6600000 reads
2023-01-30 09:53:19,476 INFO Parsed 6700000 reads
2023-01-30 09:53:21,934 INFO Parsed 6800000 reads
2023-01-30 09:53:24,375 INFO Parsed 6900000 reads
2023-01-30 09:53:26,830 INFO Parsed 7000000 reads
2023-01-30 09:53:29,299 INFO Parsed 7100000 reads
2023-01-30 09:53:31,749 INFO Parsed 7200000 reads
2023-01-30 09:53:34,191 INFO Parsed 7300000 reads
2023-01-30 09:53:36,663 INFO Parsed 7400000 reads
2023-01-30 09:53:39,085 INFO Parsed 7500000 reads
2023-01-30 09:53:41,513 INFO Parsed 7600000 reads
2023-01-30 09:53:43,979 INFO Parsed 7700000 reads
2023-01-30 09:53:46,445 INFO Parsed 7800000 reads
2023-01-30 09:53:48,890 INFO Parsed 7900000 reads
2023-01-30 09:53:51,360 INFO Parsed 8000000 reads
2023-01-30 09:53:53,846 INFO Parsed 8100000 reads
2023-01-30 09:53:56,257 INFO Parsed 8200000 reads
2023-01-30 09:53:58,688 INFO Parsed 8300000 reads
2023-01-30 09:54:01,158 INFO Parsed 8400000 reads
2023-01-30 09:54:03,733 INFO Parsed 8500000 reads
2023-01-30 09:54:06,177 INFO Parsed 8600000 reads
2023-01-30 09:54:08,621 INFO Parsed 8700000 reads
2023-01-30 09:54:11,057 INFO Parsed 8800000 reads
2023-01-30 09:54:13,504 INFO Parsed 8900000 reads
2023-01-30 09:54:15,956 INFO Parsed 9000000 reads
2023-01-30 09:54:18,389 INFO Parsed 9100000 reads
2023-01-30 09:54:20,818 INFO Parsed 9200000 reads
2023-01-30 09:54:23,523 INFO Parsed 9300000 reads
2023-01-30 09:54:25,973 INFO Parsed 9400000 reads
2023-01-30 09:54:28,446 INFO Parsed 9500000 reads
2023-01-30 09:54:30,892 INFO Parsed 9600000 reads
2023-01-30 09:54:33,344 INFO Parsed 9700000 reads
2023-01-30 09:54:35,798 INFO Parsed 9800000 reads
2023-01-30 09:54:38,287 INFO Parsed 9900000 reads
2023-01-30 09:54:40,747 INFO Parsed 10000000 reads
2023-01-30 09:54:43,177 INFO Parsed 10100000 reads
2023-01-30 09:54:45,659 INFO Parsed 10200000 reads
2023-01-30 09:54:48,126 INFO Parsed 10300000 reads
2023-01-30 09:54:50,577 INFO Parsed 10400000 reads
2023-01-30 09:54:53,063 INFO Parsed 10500000 reads
2023-01-30 09:54:55,522 INFO Parsed 10600000 reads
2023-01-30 09:54:57,973 INFO Parsed 10700000 reads
2023-01-30 09:55:00,439 INFO Parsed 10800000 reads
2023-01-30 09:55:02,886 INFO Parsed 10900000 reads
2023-01-30 09:55:05,345 INFO Parsed 11000000 reads
2023-01-30 09:55:07,784 INFO Parsed 11100000 reads
2023-01-30 09:55:10,253 INFO Parsed 11200000 reads
2023-01-30 09:55:12,695 INFO Parsed 11300000 reads
2023-01-30 09:55:15,128 INFO Parsed 11400000 reads
2023-01-30 09:55:17,605 INFO Parsed 11500000 reads
2023-01-30 09:55:20,041 INFO Parsed 11600000 reads
2023-01-30 09:55:22,501 INFO Parsed 11700000 reads
2023-01-30 09:55:24,969 INFO Parsed 11800000 reads
2023-01-30 09:55:27,412 INFO Parsed 11900000 reads
2023-01-30 09:55:29,839 INFO Parsed 12000000 reads
2023-01-30 09:55:32,268 INFO Parsed 12100000 reads
2023-01-30 09:55:34,733 INFO Parsed 12200000 reads
2023-01-30 09:55:37,172 INFO Parsed 12300000 reads
2023-01-30 09:55:39,633 INFO Parsed 12400000 reads
2023-01-30 09:55:42,086 INFO Parsed 12500000 reads
2023-01-30 09:55:44,544 INFO Parsed 12600000 reads
2023-01-30 09:55:46,974 INFO Parsed 12700000 reads
2023-01-30 09:55:49,402 INFO Parsed 12800000 reads
2023-01-30 09:55:51,853 INFO Parsed 12900000 reads
2023-01-30 09:55:54,322 INFO Parsed 13000000 reads
2023-01-30 09:55:56,727 INFO Parsed 13100000 reads
2023-01-30 09:55:59,184 INFO Parsed 13200000 reads
2023-01-30 09:56:01,650 INFO Parsed 13300000 reads
2023-01-30 09:56:04,076 INFO Parsed 13400000 reads
2023-01-30 09:56:06,481 INFO Parsed 13500000 reads
2023-01-30 09:56:08,915 INFO Parsed 13600000 reads
2023-01-30 09:56:11,364 INFO Parsed 13700000 reads
2023-01-30 09:56:13,788 INFO Parsed 13800000 reads
2023-01-30 09:56:16,206 INFO Parsed 13900000 reads
2023-01-30 09:56:18,655 INFO Parsed 14000000 reads
2023-01-30 09:56:21,067 INFO Parsed 14100000 reads
2023-01-30 09:56:23,504 INFO Parsed 14200000 reads
2023-01-30 09:56:25,926 INFO Parsed 14300000 reads
2023-01-30 09:56:28,391 INFO Parsed 14400000 reads
2023-01-30 09:56:30,816 INFO Parsed 14500000 reads
2023-01-30 09:56:33,240 INFO Parsed 14600000 reads
2023-01-30 09:56:35,710 INFO Parsed 14700000 reads
2023-01-30 09:56:38,150 INFO Parsed 14800000 reads
2023-01-30 09:56:40,603 INFO Parsed 14900000 reads
2023-01-30 09:56:43,056 INFO Parsed 15000000 reads
2023-01-30 09:56:45,480 INFO Parsed 15100000 reads
2023-01-30 09:56:47,914 INFO Parsed 15200000 reads
2023-01-30 09:56:50,347 INFO Parsed 15300000 reads
2023-01-30 09:56:52,811 INFO Parsed 15400000 reads
2023-01-30 09:56:55,207 INFO Parsed 15500000 reads
2023-01-30 09:56:57,807 INFO Parsed 15600000 reads
2023-01-30 09:57:00,187 INFO Parsed 15700000 reads
2023-01-30 09:57:02,602 INFO Parsed 15800000 reads
2023-01-30 09:57:05,049 INFO Parsed 15900000 reads
2023-01-30 09:57:07,464 INFO Parsed 16000000 reads
2023-01-30 09:57:09,884 INFO Parsed 16100000 reads
2023-01-30 09:57:12,322 INFO Parsed 16200000 reads
2023-01-30 09:57:14,768 INFO Parsed 16300000 reads
2023-01-30 09:57:17,179 INFO Parsed 16400000 reads
2023-01-30 09:57:19,605 INFO Parsed 16500000 reads
2023-01-30 09:57:22,009 INFO Parsed 16600000 reads
2023-01-30 09:57:24,424 INFO Parsed 16700000 reads
2023-01-30 09:57:26,862 INFO Parsed 16800000 reads
2023-01-30 09:57:29,316 INFO Parsed 16900000 reads
2023-01-30 09:57:31,731 INFO Parsed 17000000 reads
2023-01-30 09:57:34,192 INFO Parsed 17100000 reads
2023-01-30 09:57:36,638 INFO Parsed 17200000 reads
2023-01-30 09:57:39,085 INFO Parsed 17300000 reads
2023-01-30 09:57:41,512 INFO Parsed 17400000 reads
2023-01-30 09:57:43,974 INFO Parsed 17500000 reads
2023-01-30 09:57:46,423 INFO Parsed 17600000 reads
2023-01-30 09:57:48,848 INFO Parsed 17700000 reads
2023-01-30 09:57:51,246 INFO Parsed 17800000 reads
2023-01-30 09:57:53,656 INFO Parsed 17900000 reads
2023-01-30 09:57:56,055 INFO Parsed 18000000 reads
2023-01-30 09:57:58,464 INFO Parsed 18100000 reads
2023-01-30 09:58:00,876 INFO Parsed 18200000 reads
2023-01-30 09:58:03,332 INFO Parsed 18300000 reads
2023-01-30 09:58:05,773 INFO Parsed 18400000 reads
2023-01-30 09:58:08,190 INFO Parsed 18500000 reads
2023-01-30 09:58:10,636 INFO Parsed 18600000 reads
2023-01-30 09:58:13,077 INFO Parsed 18700000 reads
2023-01-30 09:58:15,503 INFO Parsed 18800000 reads
2023-01-30 09:58:17,927 INFO Parsed 18900000 reads
2023-01-30 09:58:20,365 INFO Parsed 19000000 reads
2023-01-30 09:58:22,757 INFO Parsed 19100000 reads
2023-01-30 09:58:25,162 INFO Parsed 19200000 reads
2023-01-30 09:58:27,581 INFO Parsed 19300000 reads
2023-01-30 09:58:30,029 INFO Parsed 19400000 reads
2023-01-30 09:58:32,465 INFO Parsed 19500000 reads
2023-01-30 09:58:34,920 INFO Parsed 19600000 reads
2023-01-30 09:58:37,348 INFO Parsed 19700000 reads
2023-01-30 09:58:39,823 INFO Parsed 19800000 reads
2023-01-30 09:58:42,229 INFO Parsed 19900000 reads
2023-01-30 09:58:44,656 INFO Parsed 20000000 reads
2023-01-30 09:58:47,073 INFO Parsed 20100000 reads
2023-01-30 09:58:49,485 INFO Parsed 20200000 reads
2023-01-30 09:58:51,931 INFO Parsed 20300000 reads
2023-01-30 09:58:54,390 INFO Parsed 20400000 reads
2023-01-30 09:58:56,805 INFO Parsed 20500000 reads
2023-01-30 09:58:59,239 INFO Parsed 20600000 reads
2023-01-30 09:59:01,695 INFO Parsed 20700000 reads
2023-01-30 09:59:04,111 INFO Parsed 20800000 reads
2023-01-30 09:59:06,527 INFO Parsed 20900000 reads
2023-01-30 09:59:08,939 INFO Parsed 21000000 reads
2023-01-30 09:59:11,370 INFO Parsed 21100000 reads
2023-01-30 09:59:13,807 INFO Parsed 21200000 reads
2023-01-30 09:59:16,238 INFO Parsed 21300000 reads
2023-01-30 09:59:18,692 INFO Parsed 21400000 reads
2023-01-30 09:59:21,127 INFO Parsed 21500000 reads
2023-01-30 09:59:23,567 INFO Parsed 21600000 reads
2023-01-30 09:59:25,968 INFO Parsed 21700000 reads
2023-01-30 09:59:28,395 INFO Parsed 21800000 reads
2023-01-30 09:59:30,837 INFO Parsed 21900000 reads
2023-01-30 09:59:33,230 INFO Parsed 22000000 reads
2023-01-30 09:59:35,672 INFO Parsed 22100000 reads
2023-01-30 09:59:38,120 INFO Parsed 22200000 reads
2023-01-30 09:59:40,534 INFO Parsed 22300000 reads
2023-01-30 09:59:42,936 INFO Parsed 22400000 reads
2023-01-30 09:59:45,329 INFO Parsed 22500000 reads
2023-01-30 09:59:47,741 INFO Parsed 22600000 reads
2023-01-30 09:59:50,133 INFO Parsed 22700000 reads
2023-01-30 09:59:52,574 INFO Parsed 22800000 reads
2023-01-30 09:59:55,030 INFO Parsed 22900000 reads
2023-01-30 09:59:57,468 INFO Parsed 23000000 reads
2023-01-30 09:59:59,901 INFO Parsed 23100000 reads
2023-01-30 10:00:02,326 INFO Parsed 23200000 reads
2023-01-30 10:00:04,752 INFO Parsed 23300000 reads
2023-01-30 10:00:07,172 INFO Parsed 23400000 reads
2023-01-30 10:00:09,621 INFO Parsed 23500000 reads
2023-01-30 10:00:12,076 INFO Parsed 23600000 reads
2023-01-30 10:00:14,535 INFO Parsed 23700000 reads
2023-01-30 10:00:16,953 INFO Parsed 23800000 reads
2023-01-30 10:00:19,373 INFO Parsed 23900000 reads
2023-01-30 10:00:21,810 INFO Parsed 24000000 reads
2023-01-30 10:00:24,272 INFO Parsed 24100000 reads
2023-01-30 10:00:26,714 INFO Parsed 24200000 reads
2023-01-30 10:00:29,159 INFO Parsed 24300000 reads
2023-01-30 10:00:31,615 INFO Parsed 24400000 reads
2023-01-30 10:00:34,060 INFO Parsed 24500000 reads
2023-01-30 10:00:36,518 INFO Parsed 24600000 reads
2023-01-30 10:00:38,984 INFO Parsed 24700000 reads
2023-01-30 10:00:41,445 INFO Parsed 24800000 reads
2023-01-30 10:00:43,880 INFO Parsed 24900000 reads
2023-01-30 10:00:46,436 INFO Parsed 25000000 reads
2023-01-30 10:00:48,877 INFO Parsed 25100000 reads
2023-01-30 10:00:51,310 INFO Parsed 25200000 reads
2023-01-30 10:00:53,758 INFO Parsed 25300000 reads
2023-01-30 10:00:56,187 INFO Parsed 25400000 reads
2023-01-30 10:00:58,631 INFO Parsed 25500000 reads
2023-01-30 10:01:01,083 INFO Parsed 25600000 reads
2023-01-30 10:01:03,541 INFO Parsed 25700000 reads
2023-01-30 10:01:05,972 INFO Parsed 25800000 reads
2023-01-30 10:01:08,428 INFO Parsed 25900000 reads
2023-01-30 10:01:10,856 INFO Parsed 26000000 reads
2023-01-30 10:01:13,322 INFO Parsed 26100000 reads
2023-01-30 10:01:15,783 INFO Parsed 26200000 reads
2023-01-30 10:01:18,218 INFO Parsed 26300000 reads
2023-01-30 10:01:20,646 INFO Parsed 26400000 reads
2023-01-30 10:01:23,059 INFO Parsed 26500000 reads
2023-01-30 10:01:25,504 INFO Parsed 26600000 reads
2023-01-30 10:01:27,900 INFO Parsed 26700000 reads
2023-01-30 10:01:30,357 INFO Parsed 26800000 reads
2023-01-30 10:01:32,913 INFO Parsed 26900000 reads
2023-01-30 10:01:35,374 INFO Parsed 27000000 reads
2023-01-30 10:01:37,839 INFO Parsed 27100000 reads
2023-01-30 10:01:40,291 INFO Parsed 27200000 reads
2023-01-30 10:01:42,738 INFO Parsed 27300000 reads
2023-01-30 10:01:45,155 INFO Parsed 27400000 reads
2023-01-30 10:01:47,658 INFO Parsed 27500000 reads
2023-01-30 10:01:50,082 INFO Parsed 27600000 reads
2023-01-30 10:01:52,517 INFO Parsed 27700000 reads
2023-01-30 10:01:54,960 INFO Parsed 27800000 reads
2023-01-30 10:01:57,402 INFO Parsed 27900000 reads
2023-01-30 10:01:59,839 INFO Parsed 28000000 reads
2023-01-30 10:02:02,256 INFO Parsed 28100000 reads
2023-01-30 10:02:04,841 INFO Parsed 28200000 reads
2023-01-30 10:02:07,284 INFO Parsed 28300000 reads
2023-01-30 10:02:09,690 INFO Parsed 28400000 reads
2023-01-30 10:02:12,119 INFO Parsed 28500000 reads
2023-01-30 10:02:14,540 INFO Parsed 28600000 reads
2023-01-30 10:02:16,997 INFO Parsed 28700000 reads
2023-01-30 10:02:19,507 INFO Parsed 28800000 reads
2023-01-30 10:02:21,971 INFO Parsed 28900000 reads
2023-01-30 10:02:24,416 INFO Parsed 29000000 reads
2023-01-30 10:02:26,872 INFO Parsed 29100000 reads
2023-01-30 10:02:29,331 INFO Parsed 29200000 reads
2023-01-30 10:02:31,763 INFO Parsed 29300000 reads
2023-01-30 10:02:34,194 INFO Parsed 29400000 reads
2023-01-30 10:02:36,646 INFO Parsed 29500000 reads
2023-01-30 10:02:39,067 INFO Parsed 29600000 reads
2023-01-30 10:02:41,472 INFO Parsed 29700000 reads
2023-01-30 10:02:43,871 INFO Parsed 29800000 reads
2023-01-30 10:02:46,320 INFO Parsed 29900000 reads
2023-01-30 10:02:49,044 INFO Parsed 30000000 reads
2023-01-30 10:02:51,459 INFO Parsed 30100000 reads
2023-01-30 10:02:53,919 INFO Parsed 30200000 reads
2023-01-30 10:02:56,388 INFO Parsed 30300000 reads
2023-01-30 10:02:58,835 INFO Parsed 30400000 reads
2023-01-30 10:03:01,294 INFO Parsed 30500000 reads
2023-01-30 10:03:03,732 INFO Parsed 30600000 reads
2023-01-30 10:03:06,185 INFO Parsed 30700000 reads
2023-01-30 10:03:08,604 INFO Parsed 30800000 reads
2023-01-30 10:03:11,023 INFO Parsed 30900000 reads
2023-01-30 10:03:13,457 INFO Parsed 31000000 reads
2023-01-30 10:03:15,913 INFO Parsed 31100000 reads
2023-01-30 10:03:18,377 INFO Parsed 31200000 reads
2023-01-30 10:03:21,022 INFO Parsed 31300000 reads
2023-01-30 10:03:23,449 INFO Parsed 31400000 reads
2023-01-30 10:03:25,896 INFO Parsed 31500000 reads
2023-01-30 10:03:28,312 INFO Parsed 31600000 reads
2023-01-30 10:03:30,734 INFO Parsed 31700000 reads
2023-01-30 10:03:33,183 INFO Parsed 31800000 reads
2023-01-30 10:03:35,624 INFO Parsed 31900000 reads
2023-01-30 10:03:38,074 INFO Parsed 32000000 reads
2023-01-30 10:03:40,507 INFO Parsed 32100000 reads
2023-01-30 10:03:42,951 INFO Parsed 32200000 reads
2023-01-30 10:03:45,366 INFO Parsed 32300000 reads
2023-01-30 10:03:47,805 INFO Parsed 32400000 reads
2023-01-30 10:03:50,525 INFO Parsed 32500000 reads
2023-01-30 10:03:52,980 INFO Parsed 32600000 reads
2023-01-30 10:03:55,410 INFO Parsed 32700000 reads
2023-01-30 10:03:57,828 INFO Parsed 32800000 reads
2023-01-30 10:04:00,269 INFO Parsed 32900000 reads
2023-01-30 10:04:02,711 INFO Parsed 33000000 reads
2023-01-30 10:04:05,113 INFO Parsed 33100000 reads
2023-01-30 10:04:07,604 INFO Parsed 33200000 reads
2023-01-30 10:04:10,050 INFO Parsed 33300000 reads
2023-01-30 10:04:12,511 INFO Parsed 33400000 reads
2023-01-30 10:04:14,940 INFO Parsed 33500000 reads
2023-01-30 10:04:17,376 INFO Parsed 33600000 reads
2023-01-30 10:04:19,817 INFO Parsed 33700000 reads
2023-01-30 10:04:22,717 INFO Parsed 33800000 reads
2023-01-30 10:04:25,149 INFO Parsed 33900000 reads
2023-01-30 10:04:27,624 INFO Parsed 34000000 reads
2023-01-30 10:04:30,083 INFO Parsed 34100000 reads
2023-01-30 10:04:32,519 INFO Parsed 34200000 reads
2023-01-30 10:04:34,964 INFO Parsed 34300000 reads
2023-01-30 10:04:37,742 INFO Parsed 34400000 reads
2023-01-30 10:04:40,174 INFO Parsed 34500000 reads
2023-01-30 10:04:42,605 INFO Parsed 34600000 reads
2023-01-30 10:04:45,047 INFO Parsed 34700000 reads
2023-01-30 10:04:47,493 INFO Parsed 34800000 reads
2023-01-30 10:04:49,912 INFO Parsed 34900000 reads
2023-01-30 10:04:52,343 INFO Parsed 35000000 reads
2023-01-30 10:04:54,751 INFO Parsed 35100000 reads
2023-01-30 10:04:57,188 INFO Parsed 35200000 reads
2023-01-30 10:04:59,625 INFO Parsed 35300000 reads
2023-01-30 10:05:02,041 INFO Parsed 35400000 reads
2023-01-30 10:05:04,473 INFO Parsed 35500000 reads
2023-01-30 10:05:06,893 INFO Parsed 35600000 reads
2023-01-30 10:05:09,593 INFO Parsed 35700000 reads
2023-01-30 10:05:12,053 INFO Parsed 35800000 reads
2023-01-30 10:05:14,497 INFO Parsed 35900000 reads
2023-01-30 10:05:16,972 INFO Parsed 36000000 reads
2023-01-30 10:05:19,421 INFO Parsed 36100000 reads
2023-01-30 10:05:21,869 INFO Parsed 36200000 reads
2023-01-30 10:05:24,291 INFO Parsed 36300000 reads
2023-01-30 10:05:26,723 INFO Parsed 36400000 reads
2023-01-30 10:05:29,147 INFO Parsed 36500000 reads
2023-01-30 10:05:31,604 INFO Parsed 36600000 reads
2023-01-30 10:05:34,225 INFO Parsed 36700000 reads
2023-01-30 10:05:36,679 INFO Parsed 36800000 reads
2023-01-30 10:05:39,112 INFO Parsed 36900000 reads
2023-01-30 10:05:41,557 INFO Parsed 37000000 reads
2023-01-30 10:05:44,008 INFO Parsed 37100000 reads
2023-01-30 10:05:46,440 INFO Parsed 37200000 reads
2023-01-30 10:05:48,865 INFO Parsed 37300000 reads
2023-01-30 10:05:51,305 INFO Parsed 37400000 reads
2023-01-30 10:05:53,765 INFO Parsed 37500000 reads
2023-01-30 10:05:56,222 INFO Parsed 37600000 reads
2023-01-30 10:05:58,676 INFO Parsed 37700000 reads
2023-01-30 10:06:01,136 INFO Parsed 37800000 reads
2023-01-30 10:06:03,546 INFO Parsed 37900000 reads
2023-01-30 10:06:05,998 INFO Parsed 38000000 reads
2023-01-30 10:06:08,472 INFO Parsed 38100000 reads
2023-01-30 10:06:11,012 INFO Parsed 38200000 reads
2023-01-30 10:06:13,468 INFO Parsed 38300000 reads
2023-01-30 10:06:15,944 INFO Parsed 38400000 reads
2023-01-30 10:06:18,393 INFO Parsed 38500000 reads
2023-01-30 10:06:20,842 INFO Parsed 38600000 reads
2023-01-30 10:06:23,283 INFO Parsed 38700000 reads
2023-01-30 10:06:25,722 INFO Parsed 38800000 reads
2023-01-30 10:06:28,170 INFO Parsed 38900000 reads
2023-01-30 10:06:30,593 INFO Parsed 39000000 reads
2023-01-30 10:06:32,991 INFO Parsed 39100000 reads
2023-01-30 10:06:35,417 INFO Parsed 39200000 reads
2023-01-30 10:06:37,834 INFO Parsed 39300000 reads
2023-01-30 10:06:40,276 INFO Parsed 39400000 reads
2023-01-30 10:06:42,736 INFO Parsed 39500000 reads
2023-01-30 10:06:45,178 INFO Parsed 39600000 reads
2023-01-30 10:06:47,621 INFO Parsed 39700000 reads
2023-01-30 10:06:50,076 INFO Parsed 39800000 reads
2023-01-30 10:06:52,529 INFO Parsed 39900000 reads
2023-01-30 10:06:54,954 INFO Parsed 40000000 reads
2023-01-30 10:06:57,368 INFO Parsed 40100000 reads
2023-01-30 10:06:59,798 INFO Parsed 40200000 reads
2023-01-30 10:07:02,251 INFO Parsed 40300000 reads
2023-01-30 10:07:04,700 INFO Parsed 40400000 reads
2023-01-30 10:07:07,131 INFO Parsed 40500000 reads
2023-01-30 10:07:09,554 INFO Parsed 40600000 reads
2023-01-30 10:07:11,994 INFO Parsed 40700000 reads
2023-01-30 10:07:14,434 INFO Parsed 40800000 reads
2023-01-30 10:07:16,913 INFO Parsed 40900000 reads
2023-01-30 10:07:19,319 INFO Parsed 41000000 reads
2023-01-30 10:07:21,765 INFO Parsed 41100000 reads
2023-01-30 10:07:24,203 INFO Parsed 41200000 reads
2023-01-30 10:07:26,634 INFO Parsed 41300000 reads
2023-01-30 10:07:29,047 INFO Parsed 41400000 reads
2023-01-30 10:07:31,496 INFO Parsed 41500000 reads
2023-01-30 10:07:33,930 INFO Parsed 41600000 reads
2023-01-30 10:07:36,367 INFO Parsed 41700000 reads
2023-01-30 10:07:38,790 INFO Parsed 41800000 reads
2023-01-30 10:07:41,209 INFO Parsed 41900000 reads
2023-01-30 10:07:43,624 INFO Parsed 42000000 reads
2023-01-30 10:07:46,043 INFO Parsed 42100000 reads
2023-01-30 10:07:48,484 INFO Parsed 42200000 reads
2023-01-30 10:07:50,903 INFO Parsed 42300000 reads
2023-01-30 10:07:53,337 INFO Parsed 42400000 reads
2023-01-30 10:07:55,746 INFO Parsed 42500000 reads
2023-01-30 10:07:58,183 INFO Parsed 42600000 reads
2023-01-30 10:08:00,594 INFO Parsed 42700000 reads
2023-01-30 10:08:03,040 INFO Parsed 42800000 reads
2023-01-30 10:08:05,473 INFO Parsed 42900000 reads
2023-01-30 10:08:07,911 INFO Parsed 43000000 reads
2023-01-30 10:08:10,356 INFO Parsed 43100000 reads
2023-01-30 10:08:12,799 INFO Parsed 43200000 reads
2023-01-30 10:08:15,208 INFO Parsed 43300000 reads
2023-01-30 10:08:17,666 INFO Parsed 43400000 reads
2023-01-30 10:08:20,119 INFO Parsed 43500000 reads
2023-01-30 10:08:22,547 INFO Parsed 43600000 reads
2023-01-30 10:08:24,973 INFO Parsed 43700000 reads
2023-01-30 10:08:27,409 INFO Parsed 43800000 reads
2023-01-30 10:08:29,836 INFO Parsed 43900000 reads
2023-01-30 10:08:32,236 INFO Parsed 44000000 reads
2023-01-30 10:08:34,680 INFO Parsed 44100000 reads
2023-01-30 10:08:37,100 INFO Parsed 44200000 reads
2023-01-30 10:08:39,526 INFO Parsed 44300000 reads
2023-01-30 10:08:41,971 INFO Parsed 44400000 reads
2023-01-30 10:08:44,413 INFO Parsed 44500000 reads
2023-01-30 10:08:46,831 INFO Parsed 44600000 reads
2023-01-30 10:08:49,239 INFO Parsed 44700000 reads
2023-01-30 10:08:51,664 INFO Parsed 44800000 reads
2023-01-30 10:08:54,083 INFO Parsed 44900000 reads
2023-01-30 10:08:56,474 INFO Parsed 45000000 reads
2023-01-30 10:08:58,868 INFO Parsed 45100000 reads
2023-01-30 10:09:01,316 INFO Parsed 45200000 reads
2023-01-30 10:09:03,730 INFO Parsed 45300000 reads
2023-01-30 10:09:06,159 INFO Parsed 45400000 reads
2023-01-30 10:09:08,587 INFO Parsed 45500000 reads
2023-01-30 10:09:11,029 INFO Parsed 45600000 reads
2023-01-30 10:09:13,460 INFO Parsed 45700000 reads
2023-01-30 10:09:15,897 INFO Parsed 45800000 reads
2023-01-30 10:09:18,338 INFO Parsed 45900000 reads
2023-01-30 10:09:20,747 INFO Parsed 46000000 reads
2023-01-30 10:09:23,180 INFO Parsed 46100000 reads
2023-01-30 10:09:25,581 INFO Parsed 46200000 reads
2023-01-30 10:09:25,820 INFO Input Reads: 46209946
2023-01-30 10:09:25,820 INFO Reads output: 46209946
# job finished in 1130 seconds at Mon Jan 30 10:09:25 2023 -- 1124.66  1.87  0.00  0.00 -- 7c26f0b9-d930-45b1-a4aa-9c8213f18d03

❯ umi_tools extract \
>     --bc-pattern=NNNNNNNN \
>     --stdin="${f_fq_2_bar}" \
>     --read2-in="${f_fq_2_r}" \
>     --stdout="${f_fq_2_r_pro}" \
>     --read2-stdout
# UMI-tools version: 1.0.1
# output generated by extract --bc-pattern=NNNNNNNN --stdin=/home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz --read2-in=/home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz --stdout=test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz --read2-stdout
# job started at Mon Jan 30 10:27:21 2023 on gizmoj10 -- 994c561e-fd77-4e11-9b03-223aae8cb389
# pid: 32126, system: Linux 4.15.0-192-generic #203-Ubuntu SMP Wed Aug 10 17:40:03 UTC 2022 x86_64
# blacklist                               : None
# compresslevel                           : 6
# either_read                             : False
# either_read_resolve                     : discard
# error_correct_cell                      : False
# extract_method                          : string
# filter_cell_barcode                     : None
# filter_cell_barcodes                    : False
# log2stderr                              : False
# loglevel                                : 1
# pattern                                 : NNNNNNNN
# pattern2                                : None
# prime3                                  : None
# quality_encoding                        : None
# quality_filter_mask                     : None
# quality_filter_threshold                : None
# random_seed                             : None
# read2_in                                : /home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
# read2_out                               : False
# read2_stdout                            : True
# reads_subset                            : None
# reconcile                               : False
# retain_umi                              : None
# short_help                              : None
# stderr                                  : <_io.TextIOWrapper name='<stderr>' mode='w' encoding='UTF-8'>
# stdin                                   : <_io.TextIOWrapper name='/home/kalavatt/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz' encoding='ascii'>
# stdlog                                  : <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
# stdout                                  : <_io.TextIOWrapper name='test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz' encoding='ascii'>
# timeit_file                             : None
# timeit_header                           : None
# timeit_name                             : all
# tmpdir                                  : None
# whitelist                               : None
2023-01-30 10:27:21,350 INFO Starting barcode extraction
2023-01-30 10:27:23,916 INFO Parsed 100000 reads
2023-01-30 10:27:26,312 INFO Parsed 200000 reads
2023-01-30 10:27:28,717 INFO Parsed 300000 reads
2023-01-30 10:27:31,125 INFO Parsed 400000 reads
2023-01-30 10:27:33,527 INFO Parsed 500000 reads
2023-01-30 10:27:35,926 INFO Parsed 600000 reads
2023-01-30 10:27:38,346 INFO Parsed 700000 reads
2023-01-30 10:27:40,746 INFO Parsed 800000 reads
2023-01-30 10:27:43,154 INFO Parsed 900000 reads
2023-01-30 10:27:45,564 INFO Parsed 1000000 reads
2023-01-30 10:27:47,978 INFO Parsed 1100000 reads
2023-01-30 10:27:50,377 INFO Parsed 1200000 reads
2023-01-30 10:27:52,780 INFO Parsed 1300000 reads
2023-01-30 10:27:55,186 INFO Parsed 1400000 reads
2023-01-30 10:27:57,612 INFO Parsed 1500000 reads
2023-01-30 10:28:00,193 INFO Parsed 1600000 reads
2023-01-30 10:28:02,599 INFO Parsed 1700000 reads
2023-01-30 10:28:05,012 INFO Parsed 1800000 reads
2023-01-30 10:28:07,416 INFO Parsed 1900000 reads
2023-01-30 10:28:09,814 INFO Parsed 2000000 reads
2023-01-30 10:28:12,216 INFO Parsed 2100000 reads
2023-01-30 10:28:14,788 INFO Parsed 2200000 reads
2023-01-30 10:28:17,199 INFO Parsed 2300000 reads
2023-01-30 10:28:19,605 INFO Parsed 2400000 reads
2023-01-30 10:28:22,021 INFO Parsed 2500000 reads
2023-01-30 10:28:24,423 INFO Parsed 2600000 reads
2023-01-30 10:28:26,828 INFO Parsed 2700000 reads
2023-01-30 10:28:29,257 INFO Parsed 2800000 reads
2023-01-30 10:28:31,664 INFO Parsed 2900000 reads
2023-01-30 10:28:34,064 INFO Parsed 3000000 reads
2023-01-30 10:28:36,470 INFO Parsed 3100000 reads
2023-01-30 10:28:38,887 INFO Parsed 3200000 reads
2023-01-30 10:28:41,295 INFO Parsed 3300000 reads
2023-01-30 10:28:43,704 INFO Parsed 3400000 reads
2023-01-30 10:28:46,217 INFO Parsed 3500000 reads
2023-01-30 10:28:48,632 INFO Parsed 3600000 reads
2023-01-30 10:28:51,040 INFO Parsed 3700000 reads
2023-01-30 10:28:53,452 INFO Parsed 3800000 reads
2023-01-30 10:28:55,868 INFO Parsed 3900000 reads
2023-01-30 10:28:58,290 INFO Parsed 4000000 reads
2023-01-30 10:29:00,730 INFO Parsed 4100000 reads
2023-01-30 10:29:03,157 INFO Parsed 4200000 reads
2023-01-30 10:29:05,606 INFO Parsed 4300000 reads
2023-01-30 10:29:08,023 INFO Parsed 4400000 reads
2023-01-30 10:29:10,452 INFO Parsed 4500000 reads
2023-01-30 10:29:12,879 INFO Parsed 4600000 reads
2023-01-30 10:29:15,286 INFO Parsed 4700000 reads
2023-01-30 10:29:17,698 INFO Parsed 4800000 reads
2023-01-30 10:29:20,187 INFO Parsed 4900000 reads
2023-01-30 10:29:22,613 INFO Parsed 5000000 reads
2023-01-30 10:29:25,031 INFO Parsed 5100000 reads
2023-01-30 10:29:27,463 INFO Parsed 5200000 reads
2023-01-30 10:29:29,908 INFO Parsed 5300000 reads
2023-01-30 10:29:32,318 INFO Parsed 5400000 reads
2023-01-30 10:29:34,730 INFO Parsed 5500000 reads
2023-01-30 10:29:37,237 INFO Parsed 5600000 reads
2023-01-30 10:29:39,666 INFO Parsed 5700000 reads
2023-01-30 10:29:42,081 INFO Parsed 5800000 reads
2023-01-30 10:29:44,500 INFO Parsed 5900000 reads
2023-01-30 10:29:46,933 INFO Parsed 6000000 reads
2023-01-30 10:29:49,342 INFO Parsed 6100000 reads
2023-01-30 10:29:51,778 INFO Parsed 6200000 reads
2023-01-30 10:29:54,209 INFO Parsed 6300000 reads
2023-01-30 10:29:56,627 INFO Parsed 6400000 reads
2023-01-30 10:29:59,024 INFO Parsed 6500000 reads
2023-01-30 10:30:01,436 INFO Parsed 6600000 reads
2023-01-30 10:30:03,874 INFO Parsed 6700000 reads
2023-01-30 10:30:06,283 INFO Parsed 6800000 reads
2023-01-30 10:30:08,696 INFO Parsed 6900000 reads
2023-01-30 10:30:11,135 INFO Parsed 7000000 reads
2023-01-30 10:30:13,599 INFO Parsed 7100000 reads
2023-01-30 10:30:16,004 INFO Parsed 7200000 reads
2023-01-30 10:30:18,419 INFO Parsed 7300000 reads
2023-01-30 10:30:20,860 INFO Parsed 7400000 reads
2023-01-30 10:30:23,332 INFO Parsed 7500000 reads
2023-01-30 10:30:25,757 INFO Parsed 7600000 reads
2023-01-30 10:30:28,209 INFO Parsed 7700000 reads
2023-01-30 10:30:30,613 INFO Parsed 7800000 reads
2023-01-30 10:30:33,019 INFO Parsed 7900000 reads
2023-01-30 10:30:35,442 INFO Parsed 8000000 reads
2023-01-30 10:30:37,866 INFO Parsed 8100000 reads
2023-01-30 10:30:40,269 INFO Parsed 8200000 reads
2023-01-30 10:30:42,685 INFO Parsed 8300000 reads
2023-01-30 10:30:45,103 INFO Parsed 8400000 reads
2023-01-30 10:30:47,513 INFO Parsed 8500000 reads
2023-01-30 10:30:49,917 INFO Parsed 8600000 reads
2023-01-30 10:30:52,338 INFO Parsed 8700000 reads
2023-01-30 10:30:54,745 INFO Parsed 8800000 reads
2023-01-30 10:30:57,146 INFO Parsed 8900000 reads
2023-01-30 10:30:59,556 INFO Parsed 9000000 reads
2023-01-30 10:31:01,979 INFO Parsed 9100000 reads
2023-01-30 10:31:04,431 INFO Parsed 9200000 reads
2023-01-30 10:31:06,841 INFO Parsed 9300000 reads
2023-01-30 10:31:09,260 INFO Parsed 9400000 reads
2023-01-30 10:31:11,687 INFO Parsed 9500000 reads
2023-01-30 10:31:14,089 INFO Parsed 9600000 reads
2023-01-30 10:31:16,499 INFO Parsed 9700000 reads
2023-01-30 10:31:18,918 INFO Parsed 9800000 reads
2023-01-30 10:31:21,313 INFO Parsed 9900000 reads
2023-01-30 10:31:23,815 INFO Parsed 10000000 reads
2023-01-30 10:31:26,219 INFO Parsed 10100000 reads
2023-01-30 10:31:28,638 INFO Parsed 10200000 reads
2023-01-30 10:31:31,045 INFO Parsed 10300000 reads
2023-01-30 10:31:33,457 INFO Parsed 10400000 reads
2023-01-30 10:31:35,884 INFO Parsed 10500000 reads
2023-01-30 10:31:38,452 INFO Parsed 10600000 reads
2023-01-30 10:31:40,855 INFO Parsed 10700000 reads
2023-01-30 10:31:43,270 INFO Parsed 10800000 reads
2023-01-30 10:31:45,687 INFO Parsed 10900000 reads
2023-01-30 10:31:48,090 INFO Parsed 11000000 reads
2023-01-30 10:31:50,511 INFO Parsed 11100000 reads
2023-01-30 10:31:52,945 INFO Parsed 11200000 reads
2023-01-30 10:31:55,525 INFO Parsed 11300000 reads
2023-01-30 10:31:57,929 INFO Parsed 11400000 reads
2023-01-30 10:32:00,348 INFO Parsed 11500000 reads
2023-01-30 10:32:02,727 INFO Parsed 11600000 reads
2023-01-30 10:32:05,132 INFO Parsed 11700000 reads
2023-01-30 10:32:07,538 INFO Parsed 11800000 reads
2023-01-30 10:32:09,958 INFO Parsed 11900000 reads
2023-01-30 10:32:12,347 INFO Parsed 12000000 reads
2023-01-30 10:32:14,753 INFO Parsed 12100000 reads
2023-01-30 10:32:17,176 INFO Parsed 12200000 reads
2023-01-30 10:32:19,566 INFO Parsed 12300000 reads
2023-01-30 10:32:21,958 INFO Parsed 12400000 reads
2023-01-30 10:32:24,388 INFO Parsed 12500000 reads
2023-01-30 10:32:26,802 INFO Parsed 12600000 reads
2023-01-30 10:32:29,201 INFO Parsed 12700000 reads
2023-01-30 10:32:31,619 INFO Parsed 12800000 reads
2023-01-30 10:32:34,045 INFO Parsed 12900000 reads
2023-01-30 10:32:36,440 INFO Parsed 13000000 reads
2023-01-30 10:32:38,827 INFO Parsed 13100000 reads
2023-01-30 10:32:41,564 INFO Parsed 13200000 reads
2023-01-30 10:32:43,987 INFO Parsed 13300000 reads
2023-01-30 10:32:46,373 INFO Parsed 13400000 reads
2023-01-30 10:32:48,767 INFO Parsed 13500000 reads
2023-01-30 10:32:51,178 INFO Parsed 13600000 reads
2023-01-30 10:32:53,577 INFO Parsed 13700000 reads
2023-01-30 10:32:55,994 INFO Parsed 13800000 reads
2023-01-30 10:32:58,449 INFO Parsed 13900000 reads
2023-01-30 10:33:00,912 INFO Parsed 14000000 reads
2023-01-30 10:33:03,305 INFO Parsed 14100000 reads
2023-01-30 10:33:05,702 INFO Parsed 14200000 reads
2023-01-30 10:33:08,110 INFO Parsed 14300000 reads
2023-01-30 10:33:10,516 INFO Parsed 14400000 reads
2023-01-30 10:33:12,906 INFO Parsed 14500000 reads
2023-01-30 10:33:15,310 INFO Parsed 14600000 reads
2023-01-30 10:33:17,722 INFO Parsed 14700000 reads
2023-01-30 10:33:20,109 INFO Parsed 14800000 reads
2023-01-30 10:33:22,501 INFO Parsed 14900000 reads
2023-01-30 10:33:24,909 INFO Parsed 15000000 reads
2023-01-30 10:33:27,313 INFO Parsed 15100000 reads
2023-01-30 10:33:29,703 INFO Parsed 15200000 reads
2023-01-30 10:33:32,170 INFO Parsed 15300000 reads
2023-01-30 10:33:34,572 INFO Parsed 15400000 reads
2023-01-30 10:33:36,927 INFO Parsed 15500000 reads
2023-01-30 10:33:39,283 INFO Parsed 15600000 reads
2023-01-30 10:33:41,654 INFO Parsed 15700000 reads
2023-01-30 10:33:44,044 INFO Parsed 15800000 reads
2023-01-30 10:33:46,441 INFO Parsed 15900000 reads
2023-01-30 10:33:48,842 INFO Parsed 16000000 reads
2023-01-30 10:33:51,238 INFO Parsed 16100000 reads
2023-01-30 10:33:53,615 INFO Parsed 16200000 reads
2023-01-30 10:33:55,995 INFO Parsed 16300000 reads
2023-01-30 10:33:58,384 INFO Parsed 16400000 reads
2023-01-30 10:34:00,780 INFO Parsed 16500000 reads
2023-01-30 10:34:03,166 INFO Parsed 16600000 reads
2023-01-30 10:34:05,555 INFO Parsed 16700000 reads
2023-01-30 10:34:07,953 INFO Parsed 16800000 reads
2023-01-30 10:34:10,333 INFO Parsed 16900000 reads
2023-01-30 10:34:12,712 INFO Parsed 17000000 reads
2023-01-30 10:34:15,115 INFO Parsed 17100000 reads
2023-01-30 10:34:17,652 INFO Parsed 17200000 reads
2023-01-30 10:34:20,025 INFO Parsed 17300000 reads
2023-01-30 10:34:22,405 INFO Parsed 17400000 reads
2023-01-30 10:34:24,808 INFO Parsed 17500000 reads
2023-01-30 10:34:27,188 INFO Parsed 17600000 reads
2023-01-30 10:34:29,565 INFO Parsed 17700000 reads
2023-01-30 10:34:32,037 INFO Parsed 17800000 reads
2023-01-30 10:34:34,465 INFO Parsed 17900000 reads
2023-01-30 10:34:36,843 INFO Parsed 18000000 reads
2023-01-30 10:34:39,220 INFO Parsed 18100000 reads
2023-01-30 10:34:41,614 INFO Parsed 18200000 reads
2023-01-30 10:34:44,005 INFO Parsed 18300000 reads
2023-01-30 10:34:46,378 INFO Parsed 18400000 reads
2023-01-30 10:34:48,793 INFO Parsed 18500000 reads
2023-01-30 10:34:51,199 INFO Parsed 18600000 reads
2023-01-30 10:34:53,570 INFO Parsed 18700000 reads
2023-01-30 10:34:55,944 INFO Parsed 18800000 reads
2023-01-30 10:34:58,321 INFO Parsed 18900000 reads
2023-01-30 10:35:00,707 INFO Parsed 19000000 reads
2023-01-30 10:35:03,155 INFO Parsed 19100000 reads
2023-01-30 10:35:05,585 INFO Parsed 19200000 reads
2023-01-30 10:35:07,978 INFO Parsed 19300000 reads
2023-01-30 10:35:10,358 INFO Parsed 19400000 reads
2023-01-30 10:35:12,731 INFO Parsed 19500000 reads
2023-01-30 10:35:15,117 INFO Parsed 19600000 reads
2023-01-30 10:35:17,516 INFO Parsed 19700000 reads
2023-01-30 10:35:20,165 INFO Parsed 19800000 reads
2023-01-30 10:35:22,550 INFO Parsed 19900000 reads
2023-01-30 10:35:24,954 INFO Parsed 20000000 reads
2023-01-30 10:35:27,340 INFO Parsed 20100000 reads
2023-01-30 10:35:29,710 INFO Parsed 20200000 reads
2023-01-30 10:35:32,094 INFO Parsed 20300000 reads
2023-01-30 10:35:34,502 INFO Parsed 20400000 reads
2023-01-30 10:35:36,884 INFO Parsed 20500000 reads
2023-01-30 10:35:39,272 INFO Parsed 20600000 reads
2023-01-30 10:35:41,687 INFO Parsed 20700000 reads
2023-01-30 10:35:44,074 INFO Parsed 20800000 reads
2023-01-30 10:35:46,450 INFO Parsed 20900000 reads
2023-01-30 10:35:48,847 INFO Parsed 21000000 reads
2023-01-30 10:35:51,275 INFO Parsed 21100000 reads
2023-01-30 10:35:53,654 INFO Parsed 21200000 reads
2023-01-30 10:35:56,041 INFO Parsed 21300000 reads
2023-01-30 10:35:58,431 INFO Parsed 21400000 reads
2023-01-30 10:36:00,820 INFO Parsed 21500000 reads
2023-01-30 10:36:03,196 INFO Parsed 21600000 reads
2023-01-30 10:36:05,602 INFO Parsed 21700000 reads
2023-01-30 10:36:08,014 INFO Parsed 21800000 reads
2023-01-30 10:36:10,411 INFO Parsed 21900000 reads
2023-01-30 10:36:12,826 INFO Parsed 22000000 reads
2023-01-30 10:36:15,253 INFO Parsed 22100000 reads
2023-01-30 10:36:17,652 INFO Parsed 22200000 reads
2023-01-30 10:36:20,238 INFO Parsed 22300000 reads
2023-01-30 10:36:22,638 INFO Parsed 22400000 reads
2023-01-30 10:36:25,074 INFO Parsed 22500000 reads
2023-01-30 10:36:27,507 INFO Parsed 22600000 reads
2023-01-30 10:36:29,917 INFO Parsed 22700000 reads
2023-01-30 10:36:32,341 INFO Parsed 22800000 reads
2023-01-30 10:36:34,795 INFO Parsed 22900000 reads
2023-01-30 10:36:37,219 INFO Parsed 23000000 reads
2023-01-30 10:36:39,600 INFO Parsed 23100000 reads
2023-01-30 10:36:41,985 INFO Parsed 23200000 reads
2023-01-30 10:36:44,378 INFO Parsed 23300000 reads
2023-01-30 10:36:46,757 INFO Parsed 23400000 reads
2023-01-30 10:36:49,133 INFO Parsed 23500000 reads
2023-01-30 10:36:51,513 INFO Parsed 23600000 reads
2023-01-30 10:36:53,904 INFO Parsed 23700000 reads
2023-01-30 10:36:56,288 INFO Parsed 23800000 reads
2023-01-30 10:36:58,669 INFO Parsed 23900000 reads
2023-01-30 10:37:01,054 INFO Parsed 24000000 reads
2023-01-30 10:37:03,435 INFO Parsed 24100000 reads
2023-01-30 10:37:05,812 INFO Parsed 24200000 reads
2023-01-30 10:37:08,195 INFO Parsed 24300000 reads
2023-01-30 10:37:10,583 INFO Parsed 24400000 reads
2023-01-30 10:37:12,960 INFO Parsed 24500000 reads
2023-01-30 10:37:15,340 INFO Parsed 24600000 reads
2023-01-30 10:37:17,728 INFO Parsed 24700000 reads
2023-01-30 10:37:20,108 INFO Parsed 24800000 reads
2023-01-30 10:37:22,485 INFO Parsed 24900000 reads
2023-01-30 10:37:24,883 INFO Parsed 25000000 reads
2023-01-30 10:37:27,269 INFO Parsed 25100000 reads
2023-01-30 10:37:29,704 INFO Parsed 25200000 reads
2023-01-30 10:37:32,088 INFO Parsed 25300000 reads
2023-01-30 10:37:34,467 INFO Parsed 25400000 reads
2023-01-30 10:37:36,844 INFO Parsed 25500000 reads
2023-01-30 10:37:39,214 INFO Parsed 25600000 reads
2023-01-30 10:37:41,599 INFO Parsed 25700000 reads
2023-01-30 10:37:43,981 INFO Parsed 25800000 reads
2023-01-30 10:37:46,358 INFO Parsed 25900000 reads
2023-01-30 10:37:48,737 INFO Parsed 26000000 reads
2023-01-30 10:37:51,124 INFO Parsed 26100000 reads
2023-01-30 10:37:53,501 INFO Parsed 26200000 reads
2023-01-30 10:37:55,884 INFO Parsed 26300000 reads
2023-01-30 10:37:58,263 INFO Parsed 26400000 reads
2023-01-30 10:38:00,650 INFO Parsed 26500000 reads
2023-01-30 10:38:03,041 INFO Parsed 26600000 reads
2023-01-30 10:38:05,416 INFO Parsed 26700000 reads
2023-01-30 10:38:07,813 INFO Parsed 26800000 reads
2023-01-30 10:38:10,190 INFO Parsed 26900000 reads
2023-01-30 10:38:12,608 INFO Parsed 27000000 reads
2023-01-30 10:38:14,991 INFO Parsed 27100000 reads
2023-01-30 10:38:17,374 INFO Parsed 27200000 reads
2023-01-30 10:38:19,753 INFO Parsed 27300000 reads
2023-01-30 10:38:22,138 INFO Parsed 27400000 reads
2023-01-30 10:38:24,515 INFO Parsed 27500000 reads
2023-01-30 10:38:26,911 INFO Parsed 27600000 reads
2023-01-30 10:38:29,286 INFO Parsed 27700000 reads
2023-01-30 10:38:31,666 INFO Parsed 27800000 reads
2023-01-30 10:38:34,049 INFO Parsed 27900000 reads
2023-01-30 10:38:36,429 INFO Parsed 28000000 reads
2023-01-30 10:38:38,813 INFO Parsed 28100000 reads
2023-01-30 10:38:41,188 INFO Parsed 28200000 reads
2023-01-30 10:38:43,566 INFO Parsed 28300000 reads
2023-01-30 10:38:45,939 INFO Parsed 28400000 reads
2023-01-30 10:38:48,323 INFO Parsed 28500000 reads
2023-01-30 10:38:50,700 INFO Parsed 28600000 reads
2023-01-30 10:38:53,083 INFO Parsed 28700000 reads
2023-01-30 10:38:55,459 INFO Parsed 28800000 reads
2023-01-30 10:38:57,852 INFO Parsed 28900000 reads
2023-01-30 10:39:00,224 INFO Parsed 29000000 reads
2023-01-30 10:39:02,599 INFO Parsed 29100000 reads
2023-01-30 10:39:04,988 INFO Parsed 29200000 reads
2023-01-30 10:39:07,369 INFO Parsed 29300000 reads
2023-01-30 10:39:09,746 INFO Parsed 29400000 reads
2023-01-30 10:39:12,132 INFO Parsed 29500000 reads
2023-01-30 10:39:14,578 INFO Parsed 29600000 reads
2023-01-30 10:39:16,942 INFO Parsed 29700000 reads
2023-01-30 10:39:19,307 INFO Parsed 29800000 reads
2023-01-30 10:39:21,698 INFO Parsed 29900000 reads
2023-01-30 10:39:24,078 INFO Parsed 30000000 reads
2023-01-30 10:39:26,461 INFO Parsed 30100000 reads
2023-01-30 10:39:28,893 INFO Parsed 30200000 reads
2023-01-30 10:39:31,320 INFO Parsed 30300000 reads
2023-01-30 10:39:33,697 INFO Parsed 30400000 reads
2023-01-30 10:39:36,077 INFO Parsed 30500000 reads
2023-01-30 10:39:38,464 INFO Parsed 30600000 reads
2023-01-30 10:39:40,844 INFO Parsed 30700000 reads
2023-01-30 10:39:43,231 INFO Parsed 30800000 reads
2023-01-30 10:39:45,663 INFO Parsed 30900000 reads
2023-01-30 10:39:48,043 INFO Parsed 31000000 reads
2023-01-30 10:39:50,428 INFO Parsed 31100000 reads
2023-01-30 10:39:52,817 INFO Parsed 31200000 reads
2023-01-30 10:39:55,204 INFO Parsed 31300000 reads
2023-01-30 10:39:57,587 INFO Parsed 31400000 reads
2023-01-30 10:40:00,014 INFO Parsed 31500000 reads
2023-01-30 10:40:02,422 INFO Parsed 31600000 reads
2023-01-30 10:40:04,805 INFO Parsed 31700000 reads
2023-01-30 10:40:07,190 INFO Parsed 31800000 reads
2023-01-30 10:40:09,612 INFO Parsed 31900000 reads
2023-01-30 10:40:12,000 INFO Parsed 32000000 reads
2023-01-30 10:40:14,392 INFO Parsed 32100000 reads
2023-01-30 10:40:16,783 INFO Parsed 32200000 reads
2023-01-30 10:40:19,170 INFO Parsed 32300000 reads
2023-01-30 10:40:21,573 INFO Parsed 32400000 reads
2023-01-30 10:40:23,952 INFO Parsed 32500000 reads
2023-01-30 10:40:26,332 INFO Parsed 32600000 reads
2023-01-30 10:40:28,715 INFO Parsed 32700000 reads
2023-01-30 10:40:31,102 INFO Parsed 32800000 reads
2023-01-30 10:40:33,489 INFO Parsed 32900000 reads
2023-01-30 10:40:35,868 INFO Parsed 33000000 reads
2023-01-30 10:40:38,239 INFO Parsed 33100000 reads
2023-01-30 10:40:40,619 INFO Parsed 33200000 reads
2023-01-30 10:40:43,004 INFO Parsed 33300000 reads
2023-01-30 10:40:45,383 INFO Parsed 33400000 reads
2023-01-30 10:40:47,762 INFO Parsed 33500000 reads
2023-01-30 10:40:50,159 INFO Parsed 33600000 reads
2023-01-30 10:40:52,563 INFO Parsed 33700000 reads
2023-01-30 10:40:54,956 INFO Parsed 33800000 reads
2023-01-30 10:40:57,348 INFO Parsed 33900000 reads
2023-01-30 10:40:59,744 INFO Parsed 34000000 reads
2023-01-30 10:41:02,128 INFO Parsed 34100000 reads
2023-01-30 10:41:04,520 INFO Parsed 34200000 reads
2023-01-30 10:41:06,930 INFO Parsed 34300000 reads
2023-01-30 10:41:09,312 INFO Parsed 34400000 reads
2023-01-30 10:41:11,696 INFO Parsed 34500000 reads
2023-01-30 10:41:14,076 INFO Parsed 34600000 reads
2023-01-30 10:41:16,449 INFO Parsed 34700000 reads
2023-01-30 10:41:18,811 INFO Parsed 34800000 reads
2023-01-30 10:41:21,180 INFO Parsed 34900000 reads
2023-01-30 10:41:23,554 INFO Parsed 35000000 reads
2023-01-30 10:41:25,925 INFO Parsed 35100000 reads
2023-01-30 10:41:28,290 INFO Parsed 35200000 reads
2023-01-30 10:41:30,668 INFO Parsed 35300000 reads
2023-01-30 10:41:33,032 INFO Parsed 35400000 reads
2023-01-30 10:41:35,394 INFO Parsed 35500000 reads
2023-01-30 10:41:37,763 INFO Parsed 35600000 reads
2023-01-30 10:41:40,150 INFO Parsed 35700000 reads
2023-01-30 10:41:42,546 INFO Parsed 35800000 reads
2023-01-30 10:41:44,926 INFO Parsed 35900000 reads
2023-01-30 10:41:47,315 INFO Parsed 36000000 reads
2023-01-30 10:41:49,688 INFO Parsed 36100000 reads
2023-01-30 10:41:52,057 INFO Parsed 36200000 reads
2023-01-30 10:41:54,437 INFO Parsed 36300000 reads
2023-01-30 10:41:56,814 INFO Parsed 36400000 reads
2023-01-30 10:41:59,184 INFO Parsed 36500000 reads
2023-01-30 10:42:01,560 INFO Parsed 36600000 reads
2023-01-30 10:42:03,937 INFO Parsed 36700000 reads
2023-01-30 10:42:06,301 INFO Parsed 36800000 reads
2023-01-30 10:42:08,679 INFO Parsed 36900000 reads
2023-01-30 10:42:11,051 INFO Parsed 37000000 reads
2023-01-30 10:42:13,420 INFO Parsed 37100000 reads
2023-01-30 10:42:15,787 INFO Parsed 37200000 reads
2023-01-30 10:42:18,160 INFO Parsed 37300000 reads
2023-01-30 10:42:20,538 INFO Parsed 37400000 reads
2023-01-30 10:42:22,930 INFO Parsed 37500000 reads
2023-01-30 10:42:25,305 INFO Parsed 37600000 reads
2023-01-30 10:42:27,703 INFO Parsed 37700000 reads
2023-01-30 10:42:30,072 INFO Parsed 37800000 reads
2023-01-30 10:42:32,442 INFO Parsed 37900000 reads
2023-01-30 10:42:34,813 INFO Parsed 38000000 reads
2023-01-30 10:42:37,190 INFO Parsed 38100000 reads
2023-01-30 10:42:39,557 INFO Parsed 38200000 reads
2023-01-30 10:42:41,930 INFO Parsed 38300000 reads
2023-01-30 10:42:44,413 INFO Parsed 38400000 reads
2023-01-30 10:42:46,775 INFO Parsed 38500000 reads
2023-01-30 10:42:49,135 INFO Parsed 38600000 reads
2023-01-30 10:42:51,503 INFO Parsed 38700000 reads
2023-01-30 10:42:53,870 INFO Parsed 38800000 reads
2023-01-30 10:42:56,234 INFO Parsed 38900000 reads
2023-01-30 10:42:58,606 INFO Parsed 39000000 reads
2023-01-30 10:43:00,983 INFO Parsed 39100000 reads
2023-01-30 10:43:03,361 INFO Parsed 39200000 reads
2023-01-30 10:43:05,740 INFO Parsed 39300000 reads
2023-01-30 10:43:08,114 INFO Parsed 39400000 reads
2023-01-30 10:43:10,513 INFO Parsed 39500000 reads
2023-01-30 10:43:12,914 INFO Parsed 39600000 reads
2023-01-30 10:43:15,360 INFO Parsed 39700000 reads
2023-01-30 10:43:17,773 INFO Parsed 39800000 reads
2023-01-30 10:43:20,176 INFO Parsed 39900000 reads
2023-01-30 10:43:22,598 INFO Parsed 40000000 reads
2023-01-30 10:43:24,983 INFO Parsed 40100000 reads
2023-01-30 10:43:27,410 INFO Parsed 40200000 reads
2023-01-30 10:43:29,783 INFO Parsed 40300000 reads
2023-01-30 10:43:32,186 INFO Parsed 40400000 reads
2023-01-30 10:43:34,605 INFO Parsed 40500000 reads
2023-01-30 10:43:37,005 INFO Parsed 40600000 reads
2023-01-30 10:43:39,380 INFO Parsed 40700000 reads
2023-01-30 10:43:41,759 INFO Parsed 40800000 reads
2023-01-30 10:43:44,305 INFO Parsed 40900000 reads
2023-01-30 10:43:46,708 INFO Parsed 41000000 reads
2023-01-30 10:43:49,110 INFO Parsed 41100000 reads
2023-01-30 10:43:51,497 INFO Parsed 41200000 reads
2023-01-30 10:43:53,906 INFO Parsed 41300000 reads
2023-01-30 10:43:56,267 INFO Parsed 41400000 reads
2023-01-30 10:43:58,626 INFO Parsed 41500000 reads
2023-01-30 10:44:01,042 INFO Parsed 41600000 reads
2023-01-30 10:44:03,417 INFO Parsed 41700000 reads
2023-01-30 10:44:05,776 INFO Parsed 41800000 reads
2023-01-30 10:44:08,141 INFO Parsed 41900000 reads
2023-01-30 10:44:10,517 INFO Parsed 42000000 reads
2023-01-30 10:44:12,897 INFO Parsed 42100000 reads
2023-01-30 10:44:15,275 INFO Parsed 42200000 reads
2023-01-30 10:44:17,672 INFO Parsed 42300000 reads
2023-01-30 10:44:20,053 INFO Parsed 42400000 reads
2023-01-30 10:44:22,413 INFO Parsed 42500000 reads
2023-01-30 10:44:24,831 INFO Parsed 42600000 reads
2023-01-30 10:44:27,236 INFO Parsed 42700000 reads
2023-01-30 10:44:29,625 INFO Parsed 42800000 reads
2023-01-30 10:44:31,987 INFO Parsed 42900000 reads
2023-01-30 10:44:34,375 INFO Parsed 43000000 reads
2023-01-30 10:44:36,761 INFO Parsed 43100000 reads
2023-01-30 10:44:39,107 INFO Parsed 43200000 reads
2023-01-30 10:44:41,417 INFO Parsed 43300000 reads
2023-01-30 10:44:43,772 INFO Parsed 43400000 reads
2023-01-30 10:44:46,126 INFO Parsed 43500000 reads
2023-01-30 10:44:48,461 INFO Parsed 43600000 reads
2023-01-30 10:44:50,806 INFO Parsed 43700000 reads
2023-01-30 10:44:53,184 INFO Parsed 43800000 reads
2023-01-30 10:44:55,552 INFO Parsed 43900000 reads
2023-01-30 10:44:57,957 INFO Parsed 44000000 reads
2023-01-30 10:45:00,373 INFO Parsed 44100000 reads
2023-01-30 10:45:02,777 INFO Parsed 44200000 reads
2023-01-30 10:45:05,145 INFO Parsed 44300000 reads
2023-01-30 10:45:07,521 INFO Parsed 44400000 reads
2023-01-30 10:45:09,880 INFO Parsed 44500000 reads
2023-01-30 10:45:12,271 INFO Parsed 44600000 reads
2023-01-30 10:45:14,658 INFO Parsed 44700000 reads
2023-01-30 10:45:17,168 INFO Parsed 44800000 reads
2023-01-30 10:45:19,550 INFO Parsed 44900000 reads
2023-01-30 10:45:21,917 INFO Parsed 45000000 reads
2023-01-30 10:45:24,288 INFO Parsed 45100000 reads
2023-01-30 10:45:26,659 INFO Parsed 45200000 reads
2023-01-30 10:45:29,017 INFO Parsed 45300000 reads
2023-01-30 10:45:31,455 INFO Parsed 45400000 reads
2023-01-30 10:45:33,829 INFO Parsed 45500000 reads
2023-01-30 10:45:36,203 INFO Parsed 45600000 reads
2023-01-30 10:45:38,556 INFO Parsed 45700000 reads
2023-01-30 10:45:40,958 INFO Parsed 45800000 reads
2023-01-30 10:45:43,357 INFO Parsed 45900000 reads
2023-01-30 10:45:45,724 INFO Parsed 46000000 reads
2023-01-30 10:45:48,126 INFO Parsed 46100000 reads
2023-01-30 10:45:50,506 INFO Parsed 46200000 reads
2023-01-30 10:45:50,743 INFO Input Reads: 46209946
2023-01-30 10:45:50,743 INFO Reads output: 46209946
# job finished in 1109 seconds at Mon Jan 30 10:45:50 2023 -- 1105.56  1.45  0.00  0.00 -- 994c561e-fd77-4e11-9b03-223aae8cb389
```
</details>
<br />

<a id="run-trim_galore-on-umi-containing-fastqgz-files"></a>
### Run `trim_galore` on UMI-containing `fastq.gz` files
<a id="code-8"></a>
#### Code
<details>
<summary><i>Code: Run trim_galore on UMI-containing fastq.gz files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Example #1 -------------------------
trim_galore \
    --paired \
    --retain_unpaired \
    --phred33 \
    --output_dir "${p_fq_1_o}" \
    --length 36 \
    --quality 5 \
    --stringency 1 \
    -e 0.1 \
    "${f_fq_1_l_pro}" \
    "${f_fq_1_r_pro}"


#  Example #2 -------------------------
trim_galore \
    --paired \
    --retain_unpaired \
    --phred33 \
    --output_dir "${p_fq_2_o}" \
    --length 36 \
    --quality 5 \
    --stringency 1 \
    -e 0.1 \
    "${f_fq_2_l_pro}" \
    "${f_fq_2_r_pro}"
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: Run trim_galore on UMI-containing fastq.gz files</i></summary>

```txt
❯ trim_galore \
>     --paired \
>     --retain_unpaired \
>     --phred33 \
>     --output_dir "${p_fq_1_o}" \
>     --length 36 \
>     --quality 5 \
>     --stringency 1 \
>     -e 0.1 \
>     "${f_fq_1_l_pro}" \
>     "${f_fq_1_r_pro}"
Multicore support not enabled. Proceeding with single-core trimming.
Path to Cutadapt set as: 'cutadapt' (default)
Cutadapt seems to be working fine (tested command 'cutadapt --version')
Cutadapt version: 4.2
single-core operation.
Output will be written into the directory: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_UMI-processing_umi-tools/


AUTO-DETECTING ADAPTER TYPE
===========================
Attempting to auto-detect adapter type from the first 1 million sequences of the first file (>> test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz <<)

Found perfect matches for the following adapter sequences:
Adapter type    Count   Sequence    Sequences analysed  Percentage
Illumina    290 AGATCGGAAGAGC   1000000 0.03
Nextera 3   CTGTCTCTTATA    1000000 0.00
smallRNA    0   TGGAATTCTCGG    1000000 0.00
Using Illumina adapter for trimming (count: 290). Second best hit was Nextera (count: 3)

Writing report to '/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz_trimming_report.txt'

SUMMARISING RUN PARAMETERS
==========================
Input filename: test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz
Trimming mode: paired-end
Trim Galore version: 0.6.7
Cutadapt version: 4.2
Number of cores used for trimming: 1
Quality Phred score cutoff: 5
Quality encoding type selected: ASCII+33
Adapter sequence: 'AGATCGGAAGAGC' (Illumina TruSeq, Sanger iPCR; auto-detected)
Maximum trimming error rate: 0.1 (default)
Minimum required adapter overlap (stringency): 1 bp
Minimum required sequence length for both reads before a sequence pair gets removed: 36 bp
Length cut-off for read 1: 35 bp (default)
Length cut-off for read 2: 35 bb (default)
Output file(s) will be GZIP compressed

Cutadapt seems to be fairly up-to-date (version 4.2). Setting -j 1
Writing final adapter and quality trimmed output to 5782_Q_IN_S8_R1_001.UMIs_trimmed.fq.gz


>>> Now performing quality (cutoff '-q 5') and adapter trimming in a single pass for the adapter sequence: 'AGATCGGAAGAGC' from file test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz <<<
10000000 sequences processed
This is cutadapt 4.2 with Python 3.10.8
Command line parameters: -j 1 -e 0.1 -q 5 -O 1 -a AGATCGGAAGAGC test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz
Processing single-end reads on 1 core ...
Finished in 160.497 s (15.134 µs/read; 3.96 M reads/minute).

=== Summary ===

Total reads processed:              10,605,037
Reads with adapters:                 4,125,021 (38.9%)
Reads written (passing filters):    10,605,037 (100.0%)

Total basepairs processed:   530,251,850 bp
Quality-trimmed:                       4 bp (0.0%)
Total written (filtered):    524,591,536 bp (98.9%)

=== Adapter 1 ===

Sequence: AGATCGGAAGAGC; Type: regular 3'; Length: 13; Trimmed: 4125021 times

Minimum overlap: 1
No. of allowed errors:
1-9 bp: 0; 10-13 bp: 1

Bases preceding removed adapters:
  A: 40.9%
  C: 17.1%
  G: 15.7%
  T: 26.2%
  none/other: 0.0%

Overview of removed sequences
length  count   expect  max.err error counts
1   3107626 2651259.2   0   3107626
2   713569  662814.8    0   713569
3   208575  165703.7    0   208575
4   64486   41425.9 0   64486
5   10873   10356.5 0   10873
6   8372    2589.1  0   8372
7   2168    647.3   0   2168
8   1934    161.8   0   1934
9   1291    40.5    0   1169 122
10  1177    10.1    1   898 279
11  796 2.5 1   650 146
12  584 0.6 1   536 48
13  552 0.2 1   509 43
14  494 0.2 1   458 36
15  410 0.2 1   371 39
16  296 0.2 1   285 11
17  237 0.2 1   213 24
18  239 0.2 1   205 34
19  211 0.2 1   180 31
20  143 0.2 1   128 15
21  133 0.2 1   117 16
22  131 0.2 1   109 22
23  105 0.2 1   91 14
24  82  0.2 1   77 5
25  73  0.2 1   57 16
26  58  0.2 1   41 17
27  53  0.2 1   40 13
28  43  0.2 1   29 14
29  32  0.2 1   25 7
30  42  0.2 1   31 11
31  18  0.2 1   14 4
32  25  0.2 1   17 8
33  24  0.2 1   13 11
34  11  0.2 1   9 2
35  15  0.2 1   4 11
36  7   0.2 1   3 4
37  11  0.2 1   3 8
38  11  0.2 1   5 6
39  12  0.2 1   4 8
40  13  0.2 1   1 12
41  8   0.2 1   1 7
42  10  0.2 1   1 9
43  17  0.2 1   1 16
44  10  0.2 1   1 9
45  12  0.2 1   6 6
46  12  0.2 1   3 9
47  7   0.2 1   0 7
48  4   0.2 1   0 4
49  9   0.2 1   0 9

RUN STATISTICS FOR INPUT FILE: test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz
=============================================
10605037 sequences processed in total
The length threshold of paired-end sequences gets evaluated later on (in the validation step)

Writing report to '/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz_trimming_report.txt'

SUMMARISING RUN PARAMETERS
==========================
Input filename: test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz
Trimming mode: paired-end
Trim Galore version: 0.6.7
Cutadapt version: 4.2
Number of cores used for trimming: 1
Quality Phred score cutoff: 5
Quality encoding type selected: ASCII+33
Adapter sequence: 'AGATCGGAAGAGC' (Illumina TruSeq, Sanger iPCR; auto-detected)
Maximum trimming error rate: 0.1 (default)
Minimum required adapter overlap (stringency): 1 bp
Minimum required sequence length for both reads before a sequence pair gets removed: 36 bp
Length cut-off for read 1: 35 bp (default)
Length cut-off for read 2: 35 bb (default)
Output file(s) will be GZIP compressed

Cutadapt seems to be fairly up-to-date (version 4.2). Setting -j -j 1
Writing final adapter and quality trimmed output to 5782_Q_IN_S8_R3_001.UMIs_trimmed.fq.gz


>>> Now performing quality (cutoff '-q 5') and adapter trimming in a single pass for the adapter sequence: 'AGATCGGAAGAGC' from file test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz <<<
10000000 sequences processed
This is cutadapt 4.2 with Python 3.10.8
Command line parameters: -j 1 -e 0.1 -q 5 -O 1 -a AGATCGGAAGAGC test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz
Processing single-end reads on 1 core ...
Finished in 167.238 s (15.770 µs/read; 3.80 M reads/minute).

=== Summary ===

Total reads processed:              10,605,037
Reads with adapters:                 3,896,861 (36.7%)
Reads written (passing filters):    10,605,037 (100.0%)

Total basepairs processed:   530,251,850 bp
Quality-trimmed:                  30,800 bp (0.0%)
Total written (filtered):    525,001,318 bp (99.0%)

=== Adapter 1 ===

Sequence: AGATCGGAAGAGC; Type: regular 3'; Length: 13; Trimmed: 3896861 times

Minimum overlap: 1
No. of allowed errors:
1-9 bp: 0; 10-13 bp: 1

Bases preceding removed adapters:
  A: 34.6%
  C: 23.0%
  G: 15.8%
  T: 26.6%
  none/other: 0.0%

Overview of removed sequences
length  count   expect  max.err error counts
1   2957138 2651259.2   0   2957138
2   682155  662814.8    0   682155
3   182080  165703.7    0   182080
4   61033   41425.9 0   61033
5   6103    10356.5 0   6103
6   3678    2589.1  0   3678
7   757 647.3   0   757
8   571 161.8   0   571
9   580 40.5    0   530 50
10  556 10.1    1   469 87
11  427 2.5 1   392 35
12  289 0.6 1   280 9
13  226 0.2 1   221 5
14  217 0.2 1   213 4
15  194 0.2 1   190 4
16  132 0.2 1   129 3
17  122 0.2 1   118 4
18  112 0.2 1   107 5
19  95  0.2 1   92 3
20  78  0.2 1   76 2
21  64  0.2 1   61 3
22  41  0.2 1   39 2
23  42  0.2 1   41 1
24  29  0.2 1   28 1
25  25  0.2 1   25
26  29  0.2 1   29
27  12  0.2 1   9 3
28  20  0.2 1   19 1
29  11  0.2 1   10 1
30  9   0.2 1   9
31  6   0.2 1   5 1
32  3   0.2 1   2 1
33  3   0.2 1   3
34  5   0.2 1   4 1
35  4   0.2 1   4
36  1   0.2 1   1
37  1   0.2 1   1
38  1   0.2 1   1
39  1   0.2 1   0 1
40  1   0.2 1   1
41  6   0.2 1   6
42  1   0.2 1   1
44  1   0.2 1   1
45  1   0.2 1   0 1
46  1   0.2 1   1

RUN STATISTICS FOR INPUT FILE: test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz
=============================================
10605037 sequences processed in total
The length threshold of paired-end sequences gets evaluated later on (in the validation step)

Validate paired-end files 5782_Q_IN_S8_R1_001.UMIs_trimmed.fq.gz and 5782_Q_IN_S8_R3_001.UMIs_trimmed.fq.gz
file_1: 5782_Q_IN_S8_R1_001.UMIs_trimmed.fq.gz, file_2: 5782_Q_IN_S8_R3_001.UMIs_trimmed.fq.gz


>>>>> Now validing the length of the 2 paired-end infiles: 5782_Q_IN_S8_R1_001.UMIs_trimmed.fq.gz and 5782_Q_IN_S8_R3_001.UMIs_trimmed.fq.gz <<<<<
Writing validated paired-end Read 1 reads to 5782_Q_IN_S8_R1_001.UMIs_val_1.fq.gz
Writing validated paired-end Read 2 reads to 5782_Q_IN_S8_R3_001.UMIs_val_2.fq.gz

Writing unpaired read 1 reads to 5782_Q_IN_S8_R1_001.UMIs_unpaired_1.fq.gz
Writing unpaired read 2 reads to 5782_Q_IN_S8_R3_001.UMIs_unpaired_2.fq.gz

Total number of sequences analysed: 10605037

Number of sequence pairs removed because at least one read was shorter than the length cutoff (36 bp): 3378 (0.03%)

Deleting both intermediate output files 5782_Q_IN_S8_R1_001.UMIs_trimmed.fq.gz and 5782_Q_IN_S8_R3_001.UMIs_trimmed.fq.gz

====================================================================================================


❯ trim_galore \
>     --paired \
>     --retain_unpaired \
>     --phred33 \
>     --output_dir "${p_fq_2_o}" \
>     --length 36 \
>     --quality 5 \
>     --stringency 1 \
>     -e 0.1 \
>     "${f_fq_2_l_pro}" \
>     "${f_fq_2_r_pro}"
Multicore support not enabled. Proceeding with single-core trimming.
Path to Cutadapt set as: 'cutadapt' (default)
Cutadapt seems to be working fine (tested command 'cutadapt --version')
Cutadapt version: 4.2
single-core operation.
Output will be written into the directory: /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_UMI-processing_umi-tools/


AUTO-DETECTING ADAPTER TYPE
===========================
Attempting to auto-detect adapter type from the first 1 million sequences of the first file (>> test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz <<)

Found perfect matches for the following adapter sequences:
Adapter type    Count   Sequence    Sequences analysed  Percentage
Illumina    4575    AGATCGGAAGAGC   1000000 0.46
Nextera 3   CTGTCTCTTATA    1000000 0.00
smallRNA    0   TGGAATTCTCGG    1000000 0.00
Using Illumina adapter for trimming (count: 4575). Second best hit was Nextera (count: 3)

Writing report to '/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz_trimming_report.txt'

SUMMARISING RUN PARAMETERS
==========================
Input filename: test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz
Trimming mode: paired-end
Trim Galore version: 0.6.7
Cutadapt version: 4.2
Number of cores used for trimming: 1
Quality Phred score cutoff: 5
Quality encoding type selected: ASCII+33
Adapter sequence: 'AGATCGGAAGAGC' (Illumina TruSeq, Sanger iPCR; auto-detected)
Maximum trimming error rate: 0.1 (default)
Minimum required adapter overlap (stringency): 1 bp
Minimum required sequence length for both reads before a sequence pair gets removed: 36 bp
Length cut-off for read 1: 35 bp (default)
Length cut-off for read 2: 35 bb (default)
Output file(s) will be GZIP compressed

Cutadapt seems to be fairly up-to-date (version 4.2). Setting -j 1
Writing final adapter and quality trimmed output to Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_trimmed.fq.gz


  >>> Now performing quality (cutoff '-q 5') and adapter trimming in a single pass for the adapter sequence: 'AGATCGGAAGAGC' from file test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz <<<
10000000 sequences processed
20000000 sequences processed
30000000 sequences processed
40000000 sequences processed
This is cutadapt 4.2 with Python 3.10.8
Command line parameters: -j 1 -e 0.1 -q 5 -O 1 -a AGATCGGAAGAGC test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz
Processing single-end reads on 1 core ...
Finished in 605.639 s (13.106 µs/read; 4.58 M reads/minute).

=== Summary ===

Total reads processed:              46,209,946
Reads with adapters:                17,335,962 (37.5%)
Reads written (passing filters):    46,209,946 (100.0%)

Total basepairs processed: 2,310,497,300 bp
Quality-trimmed:                     316 bp (0.0%)
Total written (filtered):  2,275,795,456 bp (98.5%)

=== Adapter 1 ===

Sequence: AGATCGGAAGAGC; Type: regular 3'; Length: 13; Trimmed: 17335962 times

Minimum overlap: 1
No. of allowed errors:
1-9 bp: 0; 10-13 bp: 1

Bases preceding removed adapters:
  A: 37.1%
  C: 22.6%
  G: 18.4%
  T: 20.7%
  none/other: 1.2%

Overview of removed sequences
length  count   expect  max.err error counts
1   12507013    11552486.5  0   12507013
2   3123049 2888121.6   0   3123049
3   1084795 722030.4    0   1084795
4   245489  180507.6    0   245489
5   58840   45126.9 0   58840
6   19157   11281.7 0   19157
7   13863   2820.4  0   13863
8   20661   705.1   0   20661
9   11267   176.3   0   10412 855
10  10073   44.1    1   8562 1511
11  7042    11.0    1   6158 884
12  5253    2.8 1   4894 359
13  3938    0.7 1   3714 224
14  3598    0.7 1   3449 149
15  2820    0.7 1   2691 129
16  2656    0.7 1   2481 175
17  2309    0.7 1   2133 176
18  2027    0.7 1   1921 106
19  1611    0.7 1   1517 94
20  1040    0.7 1   952 88
21  800 0.7 1   678 122
22  544 0.7 1   416 128
23  256 0.7 1   193 63
24  223 0.7 1   148 75
25  169 0.7 1   92 77
26  141 0.7 1   80 61
27  137 0.7 1   50 87
28  65  0.7 1   32 33
29  83  0.7 1   31 52
30  314 0.7 1   238 76
31  41  0.7 1   22 19
32  76  0.7 1   25 51
33  62  0.7 1   34 28
34  81  0.7 1   26 55
35  194 0.7 1   146 48
36  128 0.7 1   64 64
37  133 0.7 1   93 40
38  209 0.7 1   165 44
39  41  0.7 1   16 25
40  95  0.7 1   41 54
41  88  0.7 1   14 74
42  38  0.7 1   8 30
43  26  0.7 1   1 25
44  9   0.7 1   1 8
45  32  0.7 1   2 30
46  26  0.7 1   3 23
47  116 0.7 1   3 113
48  65  0.7 1   28 37
49  320 0.7 1   297 23
50  204949  0.7 1   193790 11159

RUN STATISTICS FOR INPUT FILE: test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz
=============================================
46209946 sequences processed in total
The length threshold of paired-end sequences gets evaluated later on (in the validation step)

Writing report to '/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz_trimming_report.txt'

SUMMARISING RUN PARAMETERS
==========================
Input filename: test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz
Trimming mode: paired-end
Trim Galore version: 0.6.7
Cutadapt version: 4.2
Number of cores used for trimming: 1
Quality Phred score cutoff: 5
Quality encoding type selected: ASCII+33
Adapter sequence: 'AGATCGGAAGAGC' (Illumina TruSeq, Sanger iPCR; auto-detected)
Maximum trimming error rate: 0.1 (default)
Minimum required adapter overlap (stringency): 1 bp
Minimum required sequence length for both reads before a sequence pair gets removed: 36 bp
Length cut-off for read 1: 35 bp (default)
Length cut-off for read 2: 35 bb (default)
Output file(s) will be GZIP compressed

Cutadapt seems to be fairly up-to-date (version 4.2). Setting -j -j 1
Writing final adapter and quality trimmed output to Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_trimmed.fq.gz


  >>> Now performing quality (cutoff '-q 5') and adapter trimming in a single pass for the adapter sequence: 'AGATCGGAAGAGC' from file test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz <<<
10000000 sequences processed
20000000 sequences processed
30000000 sequences processed
40000000 sequences processed
This is cutadapt 4.2 with Python 3.10.8
Command line parameters: -j 1 -e 0.1 -q 5 -O 1 -a AGATCGGAAGAGC test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz
Processing single-end reads on 1 core ...
Finished in 594.193 s (12.859 µs/read; 4.67 M reads/minute).

=== Summary ===

Total reads processed:              46,209,946
Reads with adapters:                16,857,100 (36.5%)
Reads written (passing filters):    46,209,946 (100.0%)

Total basepairs processed: 2,310,497,300 bp
Quality-trimmed:                   1,682 bp (0.0%)
Total written (filtered):  2,277,675,044 bp (98.6%)

=== Adapter 1 ===

Sequence: AGATCGGAAGAGC; Type: regular 3'; Length: 13; Trimmed: 16857100 times

Minimum overlap: 1
No. of allowed errors:
1-9 bp: 0; 10-13 bp: 1

Bases preceding removed adapters:
  A: 32.2%
  C: 25.0%
  G: 16.7%
  T: 24.7%
  none/other: 1.4%

Overview of removed sequences
length  count   expect  max.err error counts
1   12561414    11552486.5  0   12561414
2   2934389 2888121.6   0   2934389
3   819918  722030.4    0   819918
4   198284  180507.6    0   198284
5   49127   45126.9 0   49127
6   17028   11281.7 0   17028
7   13329   2820.4  0   13329
8   10778   705.1   0   10778
9   10992   176.3   0   10282 710
10  9639    44.1    1   8415 1224
11  6654    11.0    1   6054 600
12  5097    2.8 1   4867 230
13  3840    0.7 1   3651 189
14  3531    0.7 1   3388 143
15  2744    0.7 1   2596 148
16  2583    0.7 1   2493 90
17  2223    0.7 1   2118 105
18  2003    0.7 1   1927 76
19  1606    0.7 1   1534 72
20  1011    0.7 1   955 56
21  725 0.7 1   677 48
22  450 0.7 1   426 24
23  211 0.7 1   193 18
24  176 0.7 1   145 31
25  143 0.7 1   80 63
26  94  0.7 1   72 22
27  65  0.7 1   53 12
28  55  0.7 1   37 18
29  48  0.7 1   37 11
30  290 0.7 1   167 123
31  35  0.7 1   22 13
32  31  0.7 1   26 5
33  40  0.7 1   28 12
34  40  0.7 1   19 21
35  132 0.7 1   97 35
36  245 0.7 1   225 20
37  103 0.7 1   95 8
38  103 0.7 1   86 17
39  27  0.7 1   18 9
40  24  0.7 1   21 3
41  18  0.7 1   9 9
42  14  0.7 1   7 7
43  17  0.7 1   1 16
44  18  0.7 1   1 17
45  13  0.7 1   1 12
46  25  0.7 1   3 22
47  21  0.7 1   6 15
48  41  0.7 1   25 16
49  317 0.7 1   309 8
50  197389  0.7 1   187899 9490

RUN STATISTICS FOR INPUT FILE: test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz
=============================================
46209946 sequences processed in total
The length threshold of paired-end sequences gets evaluated later on (in the validation step)

Validate paired-end files Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_trimmed.fq.gz and Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_trimmed.fq.gz
file_1: Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_trimmed.fq.gz, file_2: Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_trimmed.fq.gz


>>>>> Now validing the length of the 2 paired-end infiles: Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_trimmed.fq.gz and Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_trimmed.fq.gz <<<<<
Writing validated paired-end Read 1 reads to Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_val_1.fq.gz
Writing validated paired-end Read 2 reads to Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_val_2.fq.gz

Writing unpaired read 1 reads to Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_unpaired_1.fq.gz
Writing unpaired read 2 reads to Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_unpaired_2.fq.gz

Total number of sequences analysed: 46209946

Number of sequence pairs removed because at least one read was shorter than the length cutoff (36 bp): 222885 (0.48%)

Deleting both intermediate output files Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_trimmed.fq.gz and Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_trimmed.fq.gz

====================================================================================================
```
</details>
<br />

<a id="run-star-on-untrimmed-and-trimmed-umi-containing-fastqgz-files"></a>
### Run `STAR` on untrimmed and trimmed UMI-containing `fastq.gz` files
<a id="get-situated-2"></a>
#### Get situated
<a id="code-9"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

#REMEMBER 1/2 Being on a compute node and then launching further jobs will
#REMEMBER 2/2 throw errors, especially w/regarding to binding CPUs!
# grabnode  # 1 core, then default settings

transcriptome && \
    {
        cd results/2023-0115 \
            || echo "cd'ing failed; check on this..."
    }

source activate Trinity_env
```
</details>
<br />

<a id="set-up-necessary-variables-array-outdir-etc"></a>
#### Set up necessary variables, array, outdir, etc.
<a id="code-10"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, array, outdir, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  ----------------
p_nada_in_sym="fastqs/symlinks"  # ., "${p_nada_in_sym}"
p_nada_in_trm="fastqs/trim_galore"  # ., "${p_nada_in_trm}"

nada_1_l="${p_nada_in_sym}/5782_Q_IN_S8_R1_001.fastq.gz"  # ., "${nada_1_l}"
nada_1_r="${p_nada_in_sym}/5782_Q_IN_S8_R3_001.fastq.gz"  # ., "${nada_1_r}"
nada_1_trim_l="${p_nada_in_trm}/5782_Q_IN_S8_R1_001_val_1.fq.gz"  # ., "${nada_1_trim_l}"
nada_1_trim_r="${p_nada_in_trm}/5782_Q_IN_S8_R3_001_val_2.fq.gz"  # ., "${nada_1_trim_r}"

nada_2_l="${p_nada_in_sym}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz"  # ., "${nada_2_l}"
nada_2_r="${p_nada_in_sym}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz"  # ., "${nada_2_r}"
nada_2_trim_l="${p_nada_in_trm}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz"  # ., "${nada_2_trim_l}"
nada_2_trim_r="${p_nada_in_trm}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz"  # ., "${nada_2_trim_r}"

#  ----------------
p_umi_in="test_UMI-processing_umi-tools"

umi_1_l="${p_umi_in}/5782_Q_IN_S8_R1_001.UMIs.fastq.gz"  # ., "${umi_1_l}"
umi_1_r="${p_umi_in}/5782_Q_IN_S8_R3_001.UMIs.fastq.gz"  # ., "${umi_1_r}"
umi_1_trim_l="${p_umi_in}/5782_Q_IN_S8_R1_001.UMIs_val_1.fq.gz"  # ., "${umi_1_trim_l}"
umi_1_trim_r="${p_umi_in}/5782_Q_IN_S8_R3_001.UMIs_val_2.fq.gz"  # ., "${umi_1_trim_r}"

umi_2_l="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz"  # ., "${umi_2_l}"
umi_2_r="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz"  # ., "${umi_2_r}"
umi_2_trim_l="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_val_1.fq.gz"  # ., "${umi_2_trim_l}"
umi_2_trim_r="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_val_2.fq.gz"  # ., "${umi_2_trim_r}"

#  ----------------
p_out="${p_umi_in}/STAR"  # echo "${p_out}"
if [[ ! -d "${p_out}" ]]; then mkdir -p "${p_out}"; fi

#  ----------------
unset array
typeset -A array=(
    ["${nada_1_l}"]="${nada_1_r}"
    ["${nada_1_trim_l}"]="${nada_1_trim_r}"
    ["${nada_2_l}"]="${nada_2_r}"
    ["${nada_2_trim_l}"]="${nada_2_trim_r}"
    ["${umi_1_l}"]="${umi_1_r}"
    ["${umi_1_trim_l}"]="${umi_1_trim_r}"
    ["${umi_2_l}"]="${umi_2_r}"
    ["${umi_2_trim_l}"]="${umi_2_trim_r}"
)

unset read_l && typeset -a read_l
unset read_r && typeset -a read_r
for i in "${!array[@]}"; do
    echo "   key     (left)  ${i}"
    echo " value    (right)  ${array["${i}"]}"
    echo ""

    read_l+=( "${i}" )
    read_r+=( "${array["${i}"]}" )
done
echoTest "${read_l[@]}"
echoTest "${read_r[@]}"

unset prefix && typeset -a prefix
prefix=(
    "test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim"
    "test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.nada_trim"
    "test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.nada"
    "test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.UMIs_trim"
    "test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.UMIs"
    "test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.nada"
    "test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.nada_trim"
    "test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs"
)
echoTest "${prefix[@]}"

#  Check that everything lines up...
for i in {0..7}; do
    echo "   key     (left)  ${read_l["${i}"]}"
    echo " value    (right)  ${read_r["${i}"]}"
    echo "prefix  (for bam)  ${prefix["${i}"]}"
    echo ""
done

#  ----------------
script_run="run_star_test.sh"  # echo "${script_run}"
script_submit="submit_star_test.sh"  # echo "${script_submit}"
threads=16  # echo "${threads}"
dir_genome="${HOME}/genomes/combined_SC_KL_20S/STAR"  # ., "${dir_genome}"
multimappers=1

store_lists="test_UMI-processing_umi-tools/lists"  # ., "${store_lists}"
store_scripts="sh_err_out"  # ., "${store_scripts}"
store_err_out="${store_scripts}/err_out"  # ., "${store_err_out}" | head -20
if [[ ! -d "${store_lists}" ]]; then mkdir -p "${store_lists}"; fi

list="test_list_multi.txt"
max_id_job=8
max_id_task=4
```
</details>
<br />

<a id="write-code-for-generating-lists-with-permutations-of-parameters"></a>
#### Write code for generating lists with permutations of parameters
<a id="code-11"></a>
##### Code
<details>
<summary><i>Code: Write code for generating lists with permutations of parameters</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_lists}/${list}" ]]; then
    rm "${store_lists}/${list}"
fi
echo "threads \
dir_genome \
read_1 \
read_2 \
prefix \
multimappers" \
    > "${store_lists}/${list}"
#  ., "${store_lists}/${list}"
#  vi "${store_lists}/${list}"
# cat "${store_lists}/${list}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{threads} \
{dir_genome} \
{read_1} \
{read_2} \
{prefix} \
{multimappers}" \
::: threads "${threads}" \
::: dir_genome "${dir_genome}" \
::: read_1 "${read_l[@]}" \
:::+ read_2 "${read_r[@]}"  \
:::+ prefix "${prefix[@]}" \
::: multimappers "${multimappers}" \
    >> "${store_lists}/${list}"
#        ., "${store_lists}/${list}"
#     wc -l "${store_lists}/${list}"
#  head -20 "${store_lists}/${list}"
```
</details>
<br />

<a id="examine-the-text-printed-to-the-multi-line-list"></a>
##### Examine the text printed to the multi-line list
<a id="printed-4"></a>
###### Printed
<details>
<summary><i>Printed: Examine the text printed to the multi-line list</i></summary>

```txt
❯ wc -l "${store_lists}/${list}"
9 test_UMI-processing_umi-tools/lists/${list}

❯ head -20 "${store_lists}/${list}"
dir_genome read_1 read_2 prefix multimappers
/home/kalavatt/genomes/combined_SC_KL_20S/STAR test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_val_1.fq.gz test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_val_2.fq.gz test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR fastqs/trim_galore/5782_Q_IN_S8_R1_001_val_1.fq.gz fastqs/trim_galore/5782_Q_IN_S8_R3_001_val_2.fq.gz test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.nada_trim 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz fastqs/symlinks/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.nada 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs_val_1.fq.gz test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs_val_2.fq.gz test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.UMIs_trim 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR test_UMI-processing_umi-tools/5782_Q_IN_S8_R1_001.UMIs.fastq.gz test_UMI-processing_umi-tools/5782_Q_IN_S8_R3_001.UMIs.fastq.gz test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.UMIs 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR fastqs/symlinks/5782_Q_IN_S8_R1_001.fastq.gz fastqs/symlinks/5782_Q_IN_S8_R3_001.fastq.gz test_UMI-processing_umi-tools/STAR/5782_Q_IN_S8.nada 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR fastqs/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz fastqs/trim_galore/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.nada_trim 1
/home/kalavatt/genomes/combined_SC_KL_20S/STAR test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz test_UMI-processing_umi-tools/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz test_UMI-processing_umi-tools/STAR/Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs 1
```
</details>
<br />

<a id="break-the-multi-line-list-into-individual-per-line-txt-files"></a>
#### Break the multi-line list into individual per-line `.txt` files
<a id="code-12"></a>
##### Code
<details>
<summary><i>Code: Break the multi-line list into individual per-line .txt files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm "${store_lists}/"${list%.txt}.?.txt
fi
#  ., "${store_lists}"
#  vi "${store_lists}/${list}"  # :q
# cat "${store_lists}/${list}"  # :q

typeset -i i=0
sed 1d "${store_lists}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists}/${individual}" ]] || rm "${store_lists}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists}/${list}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists}/${individual}"
done
#  ., "${store_lists}"
#  vi "${store_lists}/${list%.txt}.4.txt"  # :q
# cat "${store_lists}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="use-heredocs-to-write-the-run-and-submit-scripts-run_star_testsh-and-submit_star_testsh"></a>
#### Use `HEREDOC`s to write the run and submit scripts, `run_star_test.sh` and `submit_star_test.sh`
<a id="code-13"></a>
##### Code
<details>
<summary><i>Code: Use HEREDOCs to write the script, run_star_test.sh and submit_star_test.sh</i></summary>

<a id="run_star_testsh"></a>
###### `run_star_test.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_run}" ]]; then
    rm "./${store_scripts}/${script_run}"
fi
cat << script > "./${store_scripts}/${script_run}"
#!/bin/bash

#  ${script_run}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


#  ------------------------------------
#TODO Help message
#  ...

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"
check_file_exists "\${arguments}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \
    '' \
:::: "\${arguments}"

#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \
    'STAR \
        --runMode alignReads \
        --runThreadN {threads} \
        --outSAMtype BAM SortedByCoordinate \
        --outSAMunmapped Within \
        --outSAMattributes All \
        --genomeDir {dir_genome} \
        --readFilesIn {read_1} {read_2} \
        --readFilesCommand zcat \
        --outFileNamePrefix {prefix} \
        --limitBAMsortRAM 4000000000 \
        --outFilterMultimapNmax {multimappers} \
        --winAnchorMultimapNmax 1000 \
        --alignSJoverhangMin 8 \
        --alignSJDBoverhangMin 1 \
        --outFilterMismatchNmax 999 \
        --outMultimapperOrder Random \
        --alignEndsType EndToEnd \
        --alignIntronMin 4 \
        --alignIntronMax 5000 \
        --alignMatesGapMax 5000' \
:::: "\${arguments}"

time_end="\$(date +%s)"
script
chmod +x "./${store_scripts}/${script_run}"
#  ., "./${store_scripts}/${script_run}"
#  vi "./${store_scripts}/${script_run}"
# cat "./${store_scripts}/${script_run}"
```

<a id="submit_star_testsh"></a>
###### `submit_star_test.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${script_submit}" ]]; then
    rm "${store_lists}/${script_submit}"
fi
cat << script > "${store_lists}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=./${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$4 }' \
        | sed 's:.*/::'
)"

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \
    ${store_err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \
    ${store_err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \
    "${store_scripts}/${script_run}" \
        -a "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  ., "${store_lists}/${script_submit}"
#  vi "${store_lists}/${script_submit}"  # :q
# cat "${store_lists}/${script_submit}"
```
</details>
<br />

<a id="use-sbatch-to-run-the-submission-and-run-scripts"></a>
### Use `sbatch` to run the 'submission' and 'run' scripts
<a id="code-14"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${store_lists}/${script_submit}"
```
</details>
<br />

<a id="printed-5"></a>
#### Printed
<details>
<summary><i>Printed: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```txt
❯ skal
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
   8684723_[5-8%4] campus-ne run_star kalavatt PD       0:00      1 (JobArrayTaskLimit) 16
         8684723_1 campus-ne run_star kalavatt  R       0:02      1 gizmok20 16
         8684723_2 campus-ne run_star kalavatt  R       0:02      1 gizmok70 16
         8684723_3 campus-ne run_star kalavatt  R       0:02      1 gizmok80 16
         8684723_4 campus-ne run_star kalavatt  R       0:02      1 gizmok100 16
```
</details>
<br />

<a id="rename-star-outfiles"></a>
### Rename STAR outfiles
<a id="code-15"></a>
#### Code
<details>
<summary><i>Code: Rename STAR outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd test_UMI-processing_umi-tools/STAR \
    || echo "cd'ing failed; check on this..."

rename 's/Aligned/.Aligned/g' *
rename 's/Log/.Log/g' *
rename 's/SJ/.SJ/g' *
rename 's/.Aligned.sortedByCoord.out//g' *

rmr *_STARtmp
```
</details>
<br />
<br />

<a id="try-another-experimentmdashbut-with-bowtie-2-alignment"></a>
## Try another experiment&mdash;but with `Bowtie 2` alignment
<a id="make-a-directory-for-the-trial-with-umi_tools-extract-etc-1"></a>
### Make a directory for the trial with `umi_tools extract`, etc.
*Done [above](#make-a-directory-for-the-trial-with-umi_tools-extract-etc)*

<a id="set-up-necessary-variables-2"></a>
### Set up necessary variables
*Done [above](#set-up-necessary-variables-1)*

<a id="run-umi_tools-extract-1"></a>
### Run `umi_tools extract`
*Done [above](#run-umi_tools-extract)*

<a id="run-trim_galore-on-umi-containing-fastqgz-files-1"></a>
### Run `trim_galore` on UMI-containing `fastq.gz` files
*Done [above](#run-trim_galore-on-umi-containing-fastqgz-files)*

<a id="run-bowtie-2-on-untrimmed-and-trimmed-umi-containing-fastqgz-files"></a>
### Run `Bowtie 2` on untrimmed and trimmed UMI-containing `fastq.gz` files
<a id="get-situated-3"></a>
#### Get situated
<a id="code-16"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Stay on rhino; don't get on gizmo

transcriptome && \
    {
        cd results/2023-0115 \
            || echo "cd'ing failed; check on this..."
    }

source activate Trinity_env
ml SAMtools/1.16.1-GCC-11.2.0
ml Bowtie2/2.4.4-GCC-11.2.0
```
</details>
<br />

<a id="set-up-necessary-variables-array-outdir-etc-1"></a>
#### Set up necessary variables, array, outdir, etc.
<a id="code-17"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables, array, outdir, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  ----------------
p_nada_in_sym="fastqs/symlinks"  # ., "${p_nada_in_sym}"
p_nada_in_trm="fastqs/trim_galore"  # ., "${p_nada_in_trm}"

nada_1_l="${p_nada_in_sym}/5782_Q_IN_S8_R1_001.fastq.gz"  # ., "${nada_1_l}"
nada_1_r="${p_nada_in_sym}/5782_Q_IN_S8_R3_001.fastq.gz"  # ., "${nada_1_r}"
nada_1_trim_l="${p_nada_in_trm}/5782_Q_IN_S8_R1_001_val_1.fq.gz"  # ., "${nada_1_trim_l}"
nada_1_trim_r="${p_nada_in_trm}/5782_Q_IN_S8_R3_001_val_2.fq.gz"  # ., "${nada_1_trim_r}"

nada_2_l="${p_nada_in_sym}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz"  # ., "${nada_2_l}"
nada_2_r="${p_nada_in_sym}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz"  # ., "${nada_2_r}"
nada_2_trim_l="${p_nada_in_trm}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001_val_1.fq.gz"  # ., "${nada_2_trim_l}"
nada_2_trim_r="${p_nada_in_trm}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001_val_2.fq.gz"  # ., "${nada_2_trim_r}"

#  ----------------
p_umi_in="test_UMI-processing_umi-tools"

umi_1_l="${p_umi_in}/5782_Q_IN_S8_R1_001.UMIs.fastq.gz"  # ., "${umi_1_l}"
umi_1_r="${p_umi_in}/5782_Q_IN_S8_R3_001.UMIs.fastq.gz"  # ., "${umi_1_r}"
umi_1_trim_l="${p_umi_in}/5782_Q_IN_S8_R1_001.UMIs_val_1.fq.gz"  # ., "${umi_1_trim_l}"
umi_1_trim_r="${p_umi_in}/5782_Q_IN_S8_R3_001.UMIs_val_2.fq.gz"  # ., "${umi_1_trim_r}"

umi_2_l="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs.fastq.gz"  # ., "${umi_2_l}"
umi_2_r="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs.fastq.gz"  # ., "${umi_2_r}"
umi_2_trim_l="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.UMIs_val_1.fq.gz"  # ., "${umi_2_trim_l}"
umi_2_trim_r="${p_umi_in}/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.UMIs_val_2.fq.gz"  # ., "${umi_2_trim_r}"

#  ----------------
p_out="${p_umi_in}/Bowtie2"  # echo "${p_out}"
if [[ ! -d "${p_out}" ]]; then mkdir -p "${p_out}"; fi

#  ----------------
unset array
typeset -A array=(
    ["${nada_1_l}"]="${nada_1_r}"
    ["${nada_1_trim_l}"]="${nada_1_trim_r}"
    ["${nada_2_l}"]="${nada_2_r}"
    ["${nada_2_trim_l}"]="${nada_2_trim_r}"
    ["${umi_1_l}"]="${umi_1_r}"
    ["${umi_1_trim_l}"]="${umi_1_trim_r}"
    ["${umi_2_l}"]="${umi_2_r}"
    ["${umi_2_trim_l}"]="${umi_2_trim_r}"
)

unset read_l && typeset -a read_l
unset read_r && typeset -a read_r
for i in "${!array[@]}"; do
    echo "   key     (left)  ${i}"
    echo " value    (right)  ${array["${i}"]}"
    echo ""

    read_l+=( "${i}" )
    read_r+=( "${array["${i}"]}" )
done
echoTest "${read_l[@]}"
echoTest "${read_r[@]}"

unset prefix && typeset -a prefix
prefix=(
    "test_UMI-processing_umi-tools/Bowtie2/Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim"
    "test_UMI-processing_umi-tools/Bowtie2/5782_Q_IN_S8.nada_trim"
    "test_UMI-processing_umi-tools/Bowtie2/Sample_CT10_7718_pIAA_Q_Nascent_S5.nada"
    "test_UMI-processing_umi-tools/Bowtie2/5782_Q_IN_S8.UMIs_trim"
    "test_UMI-processing_umi-tools/Bowtie2/5782_Q_IN_S8.UMIs"
    "test_UMI-processing_umi-tools/Bowtie2/5782_Q_IN_S8.nada"
    "test_UMI-processing_umi-tools/Bowtie2/Sample_CT10_7718_pIAA_Q_Nascent_S5.nada_trim"
    "test_UMI-processing_umi-tools/Bowtie2/Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs"
)
echoTest "${prefix[@]}"

#  Check that everything lines up...
for i in {0..7}; do
    echo "   key     (left)  ${read_l["${i}"]}"
    echo " value    (right)  ${read_r["${i}"]}"
    echo "prefix  (for bam)  ${prefix["${i}"]}"
    echo ""
done

#  ----------------
script_run="run_bowtie2_test.sh"  # echo "${script_run}"
script_submit="submit_bowtie2_test.sh"  # echo "${script_submit}"
threads=8  # echo "${threads}"
dir_genome="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"  # ., "${dir_genome}"*

store_lists="test_UMI-processing_umi-tools/lists"  # ., "${store_lists}"
store_scripts="sh_err_out"  # ., "${store_scripts}"
store_err_out="${store_scripts}/err_out"  # ., "${store_err_out}" | head -20
if [[ ! -d "${store_lists}" ]]; then mkdir -p "${store_lists}"; fi

list="test_list_Bowtie2_multi.txt"  # echo "${list}"
max_id_job=8  # echo "${max_id_job}"
max_id_task=4  # echo "${max_id_task}"


#  ----------------
#  Spot checks
., "${p_nada_in_sym}"
., "${p_nada_in_trm}"

., "${nada_1_l}"
., "${nada_1_r}"
., "${nada_1_trim_l}"
., "${nada_1_trim_r}"
., "${nada_2_l}"
., "${nada_2_r}"
., "${nada_2_trim_l}"
., "${nada_2_trim_r}"

., "${umi_1_l}"
., "${umi_1_r}"
., "${umi_1_trim_l}"
., "${umi_1_trim_r}"
., "${umi_2_l}"
., "${umi_2_r}"
., "${umi_2_trim_l}"
., "${umi_2_trim_r}"

echo "${p_out}"

echoTest "${read_l[@]}"
echoTest "${read_r[@]}"
echoTest "${prefix[@]}"

echo "${script_run}"
echo "${script_submit}"
echo "${threads}"
., "${dir_genome}"*
echo "${multimappers}"

., "${store_lists}"
., "${store_scripts}"
., "${store_err_out}" | head -50

echo "${list}"
echo "${max_id_job}"
echo "${max_id_task}"
```
</details>
<br />

<a id="write-code-for-generating-lists-with-permutations-of-parameters-1"></a>
#### Write code for generating lists with permutations of parameters
<a id="code-18"></a>
##### Code
<details>
<summary><i>Code: Write code for generating lists with permutations of parameters</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Header
if [[ -f "${store_lists}/${list}" ]]; then
    rm "${store_lists}/${list}"
fi
echo "threads \
dir_genome \
read_1 \
read_2 \
prefix" \
    > "${store_lists}/${list}"
#  ., "${store_lists}/${list}"
#  vi "${store_lists}/${list}"
# cat "${store_lists}/${list}"

#  Body
parallel --header : --colsep " " -k -j 1 echo \
"{threads} \
{dir_genome} \
{read_1} \
{read_2} \
{prefix}" \
::: threads "${threads}" \
::: dir_genome "${dir_genome}" \
::: read_1 "${read_l[@]}" \
:::+ read_2 "${read_r[@]}"  \
:::+ prefix "${prefix[@]}" \
    >> "${store_lists}/${list}"
#        ., "${store_lists}/${list}"
#     wc -l "${store_lists}/${list}"
#  head -20 "${store_lists}/${list}"
```
</details>
<br />

<a id="break-the-multi-line-list-into-individual-per-line-txt-files-1"></a>
#### Break the multi-line list into individual per-line `.txt` files
<a id="code-19"></a>
##### Code
<details>
<summary><i>Code: Break the multi-line list into individual per-line .txt files</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${list%.txt}.4.txt" ]]; then
    # rm "${store_lists}/"${list%.txt}.{?,??,???}.txt
    rm "${store_lists}/"${list%.txt}.?.txt
fi
#  ., "${store_lists}"
#  vi "${store_lists}/${list}"  # :q
# cat "${store_lists}/${list}"  # :q

typeset -i i=0
sed 1d "${store_lists}/${list}" | while read -r line; do
    #  Increment with each line
    i=$(( i + 1 ))

    #  File for job submission
    individual="${list%.txt}.${i}.txt"  # echo "${individual}"

    #  If present, remove infile with header and single-line body
    [[ ! -e "${store_lists}/${individual}" ]] || rm "${store_lists}/${individual}"
    # echo "${store_lists}/${individual}"

    #  Generate infile with header and single-line body
    # echo "$(head -n 1 ${list})" >> "${individual}"
    head -n 1 "${store_lists}/${list}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"
    echo "${line}" >> "${store_lists}/${individual}"  # cat "${store_lists}/${individual}"

    # echo "Created file: ${store_lists}/${individual}"
done
#  ., "${store_lists}"
#  vi "${store_lists}/${list%.txt}.4.txt"  # :q
# cat "${store_lists}/${list%.txt}.4.txt"
```
</details>
<br />

<a id="use-heredocs-to-write-the-run-and-submit-scripts-run_bowtie2_testsh-and-submit_bowtie2_testsh"></a>
#### Use `HEREDOC`s to write the run and submit scripts, `run_bowtie2_test.sh` and `submit_bowtie2_test.sh`
<a id="code-20"></a>
##### Code
<details>
<summary><i>Code: Use HEREDOCs to write the script, run_bowtie2_test.sh and submit_bowtie2_test.sh</i></summary>

<a id="run_bowtie2_testsh"></a>
###### `run_bowtie2_test.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "./${store_scripts}/${script_run}" ]]; then
    rm "./${store_scripts}/${script_run}"
fi
cat << script > "./${store_scripts}/${script_run}"
#!/bin/bash

#  ${script_run}
#  KA
#  $(date '+%Y-%m%d')


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


#  ------------------------------------
#TODO Help message
#  ...

while getopts "a:" opt; do
    case "\${opt}" in
        a) arguments="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${arguments}" ]] && print_message_exit "\${help}"
check_file_exists "\${arguments}"


#  Echo -------------------------------
parallel --header : --colsep " " -k -j 1 echo -e \
    'bowtie2 \
        -p {threads} \
        -x {dir_genome} \
        -1 {read_1} \
        -2 {read_2} \
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
            | samtools sort \
                -@ {threads} \
                -o {prefix}.bam \
                - \
    \n \
    samtools index \
        -@ {threads} \
        {prefix}.bam' \
:::: "\${arguments}"

#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \
    'bowtie2 \
        -p {threads} \
        -x {dir_genome} \
        -1 {read_1} \
        -2 {read_2} \
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
            | samtools sort \
                -@ {threads} \
                -o {prefix}.bam \
                - \

    samtools index \
        -@ {threads} \
        {prefix}.bam' \
:::: "\${arguments}"

script
chmod +x "./${store_scripts}/${script_run}"
#  ., "./${store_scripts}/${script_run}"
#  vi "./${store_scripts}/${script_run}"
# cat "./${store_scripts}/${script_run}"
```

<a id="submit_bowtie2_testsh"></a>
###### `submit_bowtie2_test.sh`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

if [[ -f "${store_lists}/${script_submit}" ]]; then
    rm "${store_lists}/${script_submit}"
fi
cat << script > "${store_lists}/${script_submit}"
#!/bin/bash

#SBATCH --job-name=${script_run}
#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./${store_err_out}/${script_run%.sh}.%A-%a.err.txt
#SBATCH --output=./${store_err_out}/${script_run%.sh}.%A-%a.out.txt
#SBATCH --array=1-${max_id_job}%${max_id_task}

#  ${script_submit}
#  KA
#  $(date '+%Y-%m%d')

name="\$(
    cat "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt" \
        | awk -v OFS='\t' 'FNR == 2 { print \$5 }' \
        | sed 's:.*/::'
)"

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt \
    ${store_err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

ln -f \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt \
    ${store_err_out}/\${name}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt

srun \
    "${store_scripts}/${script_run}" \
        -a "./${store_lists}/${list%.txt}.\${SLURM_ARRAY_TASK_ID}.txt"

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.out.txt

rm \
    ${store_err_out}/${script_run%.sh}.\${SLURM_ARRAY_JOB_ID}-\${SLURM_ARRAY_TASK_ID}.err.txt
script
#  ., "${store_lists}/${script_submit}"
#  vi "${store_lists}/${script_submit}"  # :q
# cat "${store_lists}/${script_submit}"
```
</details>
<br />

<a id="use-sbatch-to-run-the-submission-and-run-scripts-1"></a>
### Use `sbatch` to run the 'submission' and 'run' scripts
<a id="code-21"></a>
#### Code
<details>
<summary><i>Code: Use sbatch to run the 'submission' and 'run' scripts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

sbatch "${store_lists}/${script_submit}"

cd ${store_err_out} && .,f | tail -20
```
</details>
<br />
<br />

<a id="doing-the-umi-deduplication-manually-then-assessing-results"></a>
## Doing the UMI deduplication manually, then assessing results
<a id="get-situated-4"></a>
### Get situated
<a id="code-22"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN

grabnode  # Window 1: 1 core, 100 GB RAM, default settings
grabnode  # Window 2: 16 cores, default settings

#  Do the following in both windows
transcriptome && \
    {
        cd results/2023-0115 \
            || echo "cd'ing failed; check on this..."
    }

cd test_UMI-processing_umi-tools/STAR \
    || echo "cd'ing failed; check on this..."

source activate Trinity_env
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4
ml SAMtools/1.16.1-GCC-11.2.0
```
</details>
<br />

<a id="index-bams-serially"></a>
### Index `.bam`s (serially)
<a id="code-window-2-16-cores"></a>
#### Code *(Window 2, 16 cores)*
<details>
<summary><i>Code: Index .bams (serially)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in *.bam; do
    echo "${i}"
    samtools index \
        -@ "${SLURM_CPUS_ON_NODE}" \
        "${i}"
done
# exit  # exit from Window 2 (16 cores) when completed
```
</details>
<br />

<a id="perform-a-trial-run-of-umi_tools-dedup"></a>
### Perform a trial run of `umi_tools dedup`
<a id="code-window-1mdash1-core-100-gb-rammdashhereafter"></a>
#### Code *(Window 1&mdash;1 core, 100 GB RAM&mdash;hereafter)*
<details>
<summary><i>Code: Perform a trial run of umi_tools dedup</i></summary>

`#DEKHO`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Basic parameters with filtering out of unmapped reads ----------------------
#+ 
#+ Here, the UMI grouping method is 'directional', which is the program default
#+ 
#+ 5782-U
bam="5782_Q_IN_S8.UMIs.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

#+ 5782-U-T
bam="5782_Q_IN_S8.UMIs_trim.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

mkdir umi-tools_dedup_basic_rm-unmapped_5782/
mv *.time.txt \
    *.dedu.bam \
    *.std{out,err}.txt \
    5782_Q_IN_S8.UMIs*stats*tsv \
        umi-tools_basic_rm-unmapped_5782/

#+ 7718-U
bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

#+ 7718-U-T
bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

#  Adjusting parameters, retaining but not processing unmapped reads ----------
#+ 
#+ 5782-U
# bam="5782_Q_IN_S8.UMIs.bam"
# scratch="/fh/scratch/delete30/tsukiyama_t"
# umi_tools dedup \
#     --paired \
#     --spliced-is-unique \
#     --unmapped-reads="output" \
#     --stdin="${bam}" \
#     --stdout="${bam%.bam}.dedu.bam" \
#     --temp-dir="${scratch}" \
#     --output-stats="${bam%.bam}.stats" \
#     --log="${bam%.bam}.stdout.txt" \
#     --error="${bam%.bam}.stderr.txt" \
#     --timeit="${bam%.bam}.time.txt" \
#     --timeit-header
#
# #+ 5782-U-T
# bam="5782_Q_IN_S8.UMIs_trim.bam"
# scratch="/fh/scratch/delete30/tsukiyama_t"
# umi_tools dedup \
#     --paired \
#     --spliced-is-unique \
#     --unmapped-reads="output" \
#     --stdin="${bam}" \
#     --stdout="${bam%.bam}.dedu.bam" \
#     --temp-dir="${scratch}" \
#     --output-stats="${bam%.bam}.stats" \
#     --log="${bam%.bam}.stdout.txt" \
#     --error="${bam%.bam}.stderr.txt" \
#     --timeit="${bam%.bam}.time.txt" \
#     --timeit-header

#NOTE Can't call umi_tools dedup in the above manner:
# Traceback (most recent call last):
#   File "/app/software/UMI-tools/1.0.1-foss-2019b-Python-3.7.4/bin/umi_tools", line 8, in <module>
#     sys.exit(main())
#   File "/app/software/UMI-tools/1.0.1-foss-2019b-Python-3.7.4/lib/python3.7/site-packages/umi_tools/umi_tools.py", line 61, in main
#     module.main(sys.argv)
#   File "/app/software/UMI-tools/1.0.1-foss-2019b-Python-3.7.4/lib/python3.7/site-packages/umi_tools/dedup.py", line 154, in main
#     U.validateSamOptions(options, group=False)
#   File "/app/software/UMI-tools/1.0.1-foss-2019b-Python-3.7.4/lib/python3.7/site-packages/umi_tools/Utilities.py", line 1182, in validateSamOptions
#     raise ValueError("Cannot use --unmapped-reads=output. If you want "
# ValueError: Cannot use --unmapped-reads=output. If you want to retain unmapped without deduplicating them, use the group command


#  Adjusting parameters, retaining but not processing unmapped reads ----------
#+ The difference fr/the above: Using --unmapped-reads="use" as opposed to
#+ --unmapped-reads="output", which results in the above-noted error
#+ 
#+ 5782-U
bam="5782_Q_IN_S8.UMIs.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

#+ 5782-U-T
bam="5782_Q_IN_S8.UMIs_trim.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

mkdir umi-tools_dedup_adjusted_rm-unmapped_5782/
mv *.time.txt \
    *.dedu.bam \
    *.std{out,err}.txt \
    5782_Q_IN_S8.UMIs*stats*tsv \
        umi-tools_adjusted_rm-unmapped_5782/


#  Running umi_tools group ----------------------------------------------------
#+ 5782-U
bam="5782_Q_IN_S8.UMIs.bam"
stem="${bam%.bam}.group"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools group \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --temp-dir="${scratch}" \
    --group-out="${stem}.tsv" \
    --log="${stem}.stdout.txt" \
    --error="${stem}.stderr.txt" \
    --timeit="${stem}.time.txt" \
    --timeit-header

#+ 5782-U-T
bam="5782_Q_IN_S8.UMIs_trim.bam"
stem="${bam%.bam}.group"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools group \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --temp-dir="${scratch}" \
    --group-out="${stem}.tsv" \
    --log="${stem}.stdout.txt" \
    --error="${stem}.stderr.txt" \
    --timeit="${stem}.time.txt" \
    --timeit-header

for i in *.tsv; do gzip "${i}"; done
mkdir umi-tools_group_adjusted_rm-unmapped_5782/
mv *.group.* umi-tools_group_adjusted_rm-unmapped_5782/
```
</details>
<br />
<br />

*Scraps&mdash;to be organized*
```bash
bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

# -------
bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim.bam"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --stdout="${bam%.bam}.dedu.bam" \
    --temp-dir="${scratch}" \
    --output-stats="${bam%.bam}.stats" \
    --log="${bam%.bam}.stdout.txt" \
    --error="${bam%.bam}.stderr.txt" \
    --timeit="${bam%.bam}.time.txt" \
    --timeit-header

# -------
bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs.bam"
stem="${bam%.bam}.group"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools group \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --temp-dir="${scratch}" \
    --group-out="${stem}.tsv" \
    --log="${stem}.stdout.txt" \
    --error="${stem}.stderr.txt" \
    --timeit="${stem}.time.txt" \
    --timeit-header

bam="Sample_CT10_7718_pIAA_Q_Nascent_S5.UMIs_trim.bam"
stem="${bam%.bam}.group"
scratch="/fh/scratch/delete30/tsukiyama_t"
umi_tools group \
    --paired \
    --spliced-is-unique \
    --unmapped-reads="use" \
    --stdin="${bam}" \
    --temp-dir="${scratch}" \
    --group-out="${stem}.tsv" \
    --log="${stem}.stdout.txt" \
    --error="${stem}.stderr.txt" \
    --timeit="${stem}.time.txt" \
    --timeit-header

echo "Done."
```

<a id="links-of-interestlearning-about-umi_tools"></a>
## Links of interest/learning about `umi_tools`
- [Biostars: Tool to analyze bulk RNAseq data with UMI]([https://www.biostars.org/p/405375/)
- [Biostars: Bulk RNA-Seq pipeline suggestion incorporating UMIs](https://www.biostars.org/p/413672/)
- `#NOTE In particular, this post is helpful and suggests that how I initially called umi_tools is valid`
- You studied up on [this post](https://dnatech.genomecenter.ucdavis.edu/faqs/should-i-remove-pcr-duplicates-from-my-rna-seq-data/), 'Should I remove PCR duplicates from my RNA-seq data?', in another post
- [An important post](https://dnatech.genomecenter.ucdavis.edu/faqs/what-are-umis-and-why-are-they-used-in-high-throughput-sequencing/) related to, and part of the same series as, the above
<br />
<br />

<a id="miscellaneous"></a>
## Miscellaneous
- MultiQC is not working with the output of `umi_tools`: Filed a GitHub issue [here](https://github.com/ewels/MultiQC/issues/1852)
<br />
