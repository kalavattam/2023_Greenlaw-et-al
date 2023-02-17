
`work_run-QC.md`
<br />
<br />

`#TODO`
<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Run additional QC commands on all `separate_bam.sh` outfile](#run-additional-qc-commands-on-all-separate_bamsh-outfile)
    1. [Get all bams \(in- and outfiles\) into a single array](#get-all-bams-in--and-outfiles-into-a-single-array)
        1. [Code](#code)
    1. [Use `GNU parallel` to run `samtools idxstats`](#use-gnu-parallel-to-run-samtools-idxstats)
        1. [Code](#code-1)
    1. [Use `GNU parallel` to run `samtools stats`](#use-gnu-parallel-to-run-samtools-stats)
        1. [Code](#code-2)
    1. [Use `GNU parallel` to run `picard AlignmentSummaryMetrics`](#use-gnu-parallel-to-run-picard-alignmentsummarymetrics)
        1. [Code](#code-3)
    1. [`#NOTE` `#TODO` Come back to run even more QC commands on the bams](#note-todo-come-back-to-run-even-more-qc-commands-on-the-bams)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="run-additional-qc-commands-on-all-separate_bamsh-outfile"></a>
#### Run additional QC commands on all `separate_bam.sh` outfile
<a id="get-all-bams-in--and-outfiles-into-a-single-array"></a>
##### Get all bams (in- and outfiles) into a single array
<a id="code"></a>
###### Code
<details>
<summary><i>Code: Get all bams (in- and outfiles) into a single array</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ./bams_UMI-dedup \
    || echo "cd'ing failed; check on this..."

unset bams
typeset -a bams
while IFS=" " read -r -d $'\0'; do
    bams+=( "${REPLY}" )
done < <(\
    find . \
        -maxdepth 2 \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${bams[@]}"
echo "${#bams[@]}"
```
</details>
<br />

<a id="use-gnu-parallel-to-run-samtools-idxstats"></a>
##### Use `GNU parallel` to run `samtools idxstats`
<a id="code-1"></a>
###### Code
<details>
<summary><i>Code: Run samtools idxstats</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "samtools idxstats {} > {.}.idxstats.txt" \
::: "${bams[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "samtools idxstats  {} > {.}.idxstats.txt" \
::: "${bams[@]}"
```
</details>
<br />

<a id="use-gnu-parallel-to-run-samtools-stats"></a>
##### Use `GNU parallel` to run `samtools stats`
<a id="code-2"></a>
###### Code
<details>
<summary><i>Code: Run samtools stats</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel \
    -k \
    -j 4 \
    --dry-run \
    "samtools stats -@ 4 {1} -r {2} > {1.}.stats.txt" \
::: "${bams[@]}" \
::: "${HOME}/genomes/combined_SC_KL_20S/fasta/combined_SC_KL_20S.fasta"

parallel \
    -k \
    -j 4 \
    "samtools stats -@ 4 {1} -r {2} > {1.}.stats.txt" \
::: "${bams[@]}" \
::: "${HOME}/genomes/combined_SC_KL_20S/fasta/combined_SC_KL_20S.fasta"
```
</details>
<br />

<a id="use-gnu-parallel-to-run-picard-alignmentsummarymetrics"></a>
##### Use `GNU parallel` to run `picard AlignmentSummaryMetrics`
<a id="code-3"></a>
###### Code
<details>
<summary><i>Code: picard AlignmentSummaryMetrics</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

ml picard/2.25.1-Java-11
# To execute picard run: java -jar "${EBROOTPICARD}/picard.jar"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    --dry-run \
    "java -jar {1}/picard.jar CollectAlignmentSummaryMetrics R={2} I={3} O={3.}.CollectAlignmentSummaryMetrics.txt" \
::: "${EBROOTPICARD}" \
::: "${HOME}/genomes/combined_SC_KL_20S/fasta/combined_SC_KL_20S.fasta" \
::: "${bams[@]}"

parallel \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    "java -jar {1}/picard.jar CollectAlignmentSummaryMetrics R={2} I={3} O={3.}.CollectAlignmentSummaryMetrics.txt" \
::: "${EBROOTPICARD}" \
::: "${HOME}/genomes/combined_SC_KL_20S/fasta/combined_SC_KL_20S.fasta" \
::: "${bams[@]}"
```
</details>
<br />

<a id="note-todo-come-back-to-run-even-more-qc-commands-on-the-bams"></a>
##### `#NOTE` `#TODO` Come back to run even more QC commands on the bams
<br />
<br />
