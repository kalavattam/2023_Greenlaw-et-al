
`work_draft_QC-etc.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Things to check](#things-to-check)
	1. [`samtools`](#samtools)
	1. [`picard`](#picard)
	1. [`RSeQC`](#rseqc)
1. [Additional files needed](#additional-files-needed)
1. [Make `refFlat.txt` and rRNA interval list file needed by `picard`](#make-refflattxt-and-rrna-interval-list-file-needed-by-picard)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="things-to-check"></a>
## Things to check
<a id="samtools"></a>
### `samtools`
- [stats](http://www.htslib.org/doc/samtools-stats.html)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for samtools stats</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

samtools stats \
	--threads "${threads}" \
	--ref-seq "${fasta}" \
	"${bam}"
```
</details>
<br />

- [flagstat](http://www.htslib.org/doc/samtools-flagstat.html)
	+ Interesting and easy to run, but perhaps not important
- [idxstats](http://www.htslib.org/doc/samtools-idxstats.html)
	+ Interesting and easy to run, but perhaps not important

<a id="picard"></a>
### `picard`
- [CollectAlignmentSummaryMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360040507751-CollectAlignmentSummaryMetrics-Picard-)

<details>
<summary><i>Code: Example call for picard CollectAlignmentSummaryMetrics</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

java -jar "${EBROOTPICARD}/picard.jar" \
	CollectAlignmentSummaryMetrics \
		-R="${ref_fasta}" \
	    -I="${bam}" \
	    -O="${bam%.bam}.align-summary.met.txt"
```
</details>
<br />

- [CollectBaseDistributionByCycle](https://gatk.broadinstitute.org/hc/en-us/articles/360042477312-CollectBaseDistributionByCycle-Picard-)
- [CollectGcBiasMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360036801531-CollectGcBiasMetrics-Picard-)
- [CollectInsertSizeMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360037055772-CollectInsertSizeMetrics-Picard-)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for picard CollectInsertSizeMetrics</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

java -jar "${EBROOTPICARD}/picard.jar" \
	CollectInsertSizeMetrics \
	    -I="${bam}" \
	    -O="${bam%.bam}.insert-size.met.txt" \
	    -H="${bam%.bam}.insert-size.hist.pdf"
```
</details>
<br />

- [CollectQualityYieldMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360040507031-CollectQualityYieldMetrics-Picard-)
- [CollectRnaSeqMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360037057492-CollectRnaSeqMetrics-Picard-)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for picard CollectRnaSeqMetrics</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

java -jar "${EBROOTPICARD}/picard.jar" \
	CollectRnaSeqMetrics \
		-I="${bam}" \
		-O="${bam%.bam}.RNA.met.txt" \
		--REF_FLAT="${ref_flat}" \
		--STRAND_SPECIFICITY="FIRST_READ_TRANSCRIPTION_STRAND" \
		--RIBOSOMAL_INTERVALS="${rRNA_intervals}"
```
</details>
<br />

- [EstimateLibraryComplexity](https://gatk.broadinstitute.org/hc/en-us/articles/360037051452-EstimateLibraryComplexity-Picard-)
	+ `#IMPORTANT`
	+ No module for `MultiQC`

<details>
<summary><i>Code: Example call for picard EstimateLibraryComplexity</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

java -jar picard.jar EstimateLibraryComplexity \
    -I="${bam}" \
    -O="${bam%.bam}.complex.met.txt"
```
</details>
<br />

- [MarkDuplicates](https://gatk.broadinstitute.org/hc/en-us/articles/360037052812-MarkDuplicates-Picard-)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for picard MarkDuplicates</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

java -jar "${EBROOTPICARD}/picard.jar" \
	MarkDuplicates \
	    -I="${bam}" \
	    -O="${bam%.bam}.mark-dup.bam" \
	    -M="${bam%.bam}.mark-dup.met.txt"
```
</details>
<br />

- [QualityScoreDistribution](https://gatk.broadinstitute.org/hc/en-us/articles/360037057312-QualityScoreDistribution-Picard-)
- [ValidateSamFile](https://gatk.broadinstitute.org/hc/en-us/articles/360036854731-ValidateSamFile-Picard-)

<a id="rseqc"></a>
### [`RSeQC`](https://rseqc.sourceforge.net/)
- [bam_stat.py](https://rseqc.sourceforge.net/#bam-stat-py)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for bam_stat.py</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

bam_stat.py \
	-i "${bam}" \
	-q 0 \
		> "${bam%.bam}.bam-stat.txt"
```
</details>
<br />

- [geneBody_coverage.py](https://rseqc.sourceforge.net/#genebody-coverage-py)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for geneBody_coverage.py</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

geneBody_coverage.py \
	-i "${bam}" \
	-r "${ref_gene_model}" \
	-o "${bam%.bam}.gene-body"
```
</details>
<br />

- [inner_distance.py](https://rseqc.sourceforge.net/#inner-distance-py)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for inner_distance.py</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

inner_distance.py \
	-i "${bam}" \
	-r "${ref_gene_model}" \
	-q 0 \
	-o "${bam%.bam}.inner-dist"
```
</details>
<br />

- [junction_annotation.py](https://rseqc.sourceforge.net/#junction-annotation-py)
- [junction_saturation.py](https://rseqc.sourceforge.net/#junction-saturation-py)
- [read_distribution.py](https://rseqc.sourceforge.net/#read-distribution-py)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for read_distribution.py</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

read_distribution.py \
	-i "${bam}" \
	-r "${ref_gene_model}" \
		> "${bam%.bam}.read-dist.txt"
```
</details>
<br />

- [read_duplication.py](https://rseqc.sourceforge.net/#read-duplication-py)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for read_duplication.py</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

read_duplication.py \
	-i "${bam}" \
	-q 0 \
	-o "${bam%.bam}"
```
</details>
<br />

- [read_GC.py](https://rseqc.sourceforge.net/#read-gc-py)
- [tin.py](https://rseqc.sourceforge.net/#tin-py)
	+ `#IMPORTANT`

<details>
<summary><i>Code: Example call for tin.py</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tin.py \
	-i "${bam}" \
	-r "${ref_gene_model}" \
		> "${bam%.bam}.tin.txt"
```
</details>
<br />
<br />

<a id="additional-files-needed"></a>
## Additional files needed
- For using [`rseqc`](https://rseqc.sourceforge.net/), will need to 'make bed reference gene model'
	+ [General Google results](https://www.google.com/search?q=rseqc+make+bed+reference+gene+model&oq=rseqc+make+bed+reference+gene+model&aqs=chrome..69i57j0i546l5.11422j0j7&sourceid=chrome&ie=UTF-8#ip=1)
	+ Can follow the tact here, particularly the code under the line of text (towards the bottom) "[`Source`](https://www.biostars.org/p/299573/)"
		* This post also describes a strategy for creating a reference gene model composed of only housekeeping genes
	+ There's also the info at this post (seems very straightforward): [link](https://bioinformatics.stackexchange.com/questions/7094/making-a-bed-file-for-rseqc)
- For `picard`, will need to 'make refflat from gff3'
	+ [General search results](https://www.google.com/search?q=make+refflat+from+gff3&oq=make+refflat+from+gff3&aqs=chrome..69i57j33i160l3.7758j0j7&sourceid=chrome&ie=UTF-8#ip=1)
	+ Can follow the tact here, particularly the code under the fields `GFF to GTF` and `GTF to refFlat`: [link](https://github.com/igordot/genomics/blob/master/notes/converting-files.md)
	+ There is also this approach described by one of the authors of `picard`: [link](https://github.com/broadinstitute/picard/issues/805#issue-224851540)
	+ `slowkow` has a method for doing this as well (part of `picardmetrics`): [link](https://github.com/slowkow/picardmetrics/blob/e218f358bc7d018afbce398c8d102e5a33ac4721/picardmetrics#L224)
- For `picard` (`CollectRnaSeqMetrics`), will also need a table of genomic intervals with the coordinates of all ribosomal genes in the genome
	+ One approach (from `slowkow`): [link](https://slowkow.com/notes/ribosomal-rna/)
	+ The same approach, I think, from the `picardmetrics` source code: [link](https://github.com/slowkow/picardmetrics/blob/e218f358bc7d018afbce398c8d102e5a33ac4721/picardmetrics#L272)
- If I wanted to have a `gff3` for *20S*, I can follow these tactics:
	+ [link](https://www.biostars.org/p/9496608/)
	+ *My previous work in, e.g., [this notebook](../2022-1021/notebook.md#on-making-a-gff-from-the-trinity-assembled-transcriptome)*
- Additional approaches to generating the files needed by `picard` are desscribed [here (resource from the Griffith Lab)](https://rnabio.org/module-02-alignment/0002/06/01/Alignment_QC/#Using%20Picard)
<br />
<br />

<a id="make-refflattxt-and-rrna-interval-list-file-needed-by-picard"></a>
## Make `refFlat.txt` and rRNA interval list file needed by `picard`


























