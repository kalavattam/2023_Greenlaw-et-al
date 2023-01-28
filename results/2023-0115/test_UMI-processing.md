
`#test_UMI-processing.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
1. [Experiment description](#experiment-description)
    1. [Documentation for `AnnotateBamWithUmis`](#documentation-for-annotatebamwithumis)
1. [Try a trial run with `AnnotateBamWithUmis`](#try-a-trial-run-with-annotatebamwithumis)
    1. [Make a directory for the trial with `AnnotateBamWithUmis`](#make-a-directory-for-the-trial-with-annotatebamwithumis)
    1. [Locations of datasets](#locations-of-datasets)
    1. [Set up necessary variables](#set-up-necessary-variables)
    1. [Run the command](#run-the-command)
1. [Open tabs \(`#TODO`\)](#open-tabs-todo)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="get-situated"></a>
## Get situated
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
AnnotateBamWithUmis  
Overview  
Group: SAM/BAM

Annotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecular IDs, Molecular barcodes) from separate FASTQ files. Takes an existing BAM file and either one FASTQ file with UMI reads or multiple FASTQs if there are multiple UMIs per template, matches the reads between the files based on read names, and produces an output BAM file where each record is annotated with an optional tag (specified by `attribute`) that contains the read sequence of the UMI. Trailing read numbers (`/1` or `/2`) are removed from FASTQ read names, as is any text after whitespace, before matching. If multiple UMI segments are specified (see `--read-structure`) across one or more FASTQs, they are delimited in the same order as FASTQs are specified on the command line. The delimiter is controlled by the `--delimiter` option.

The `--read-structure` option may be used to specify which bases in the FASTQ contain UMI bases. Otherwise it is assumed the FASTQ contains only UMI bases.

The `--sorted` option may be used to indicate that the FASTQ has the same reads and is sorted in the same order as the BAM file.

At the end of execution, reports how many records were processed and how many were missing UMIs. If any read from the BAM file did not have a matching UMI read in the FASTQ file, the program will exit with a non-zero exit status. The `--fail-fast` option may be specified to cause the program to terminate the first time it finds a records without a matching UMI.

In order to avoid sorting the input files, the entire UMI fastq file(s) is read into memory. As a result the program needs to be run with memory proportional the size of the (uncompressed) fastq(s). Use the `--sorted` option to traverse the UMI fastq and BAM files assuming they are in the same order. More precisely, the UMI fastq file will be traversed first, reading in the next set of BAM reads with same read name as the UMI’s read name. Those BAM reads will be annotated. If no BAM reads exist for the UMI, no logging or error will be reported.
<br />
<br />

<a id="try-a-trial-run-with-annotatebamwithumis"></a>
## Try a trial run with `AnnotateBamWithUmis`
<a id="make-a-directory-for-the-trial-with-annotatebamwithumis"></a>
### Make a directory for the trial with `AnnotateBamWithUmis`
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

<a id="open-tabs-todo"></a>
## Open tabs (`#TODO`)
https://www.biostars.org/p/357359/#358546
