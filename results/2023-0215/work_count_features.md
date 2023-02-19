
`work_count_features.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Something](#something)
	1. [Get situated, make directory for `featureCounts` work, etc.](#get-situated-make-directory-for-featurecounts-work-etc)
		1. [Code](#code)
	1. [Install `featureCounts`](#install-featurecounts)
		1. [Code](#code-1)
		1. [Printed](#printed)
	1. [Symlink to datasets](#symlink-to-datasets)
		1. [Code](#code-2)
1. [Run featureCounts](#run-featurecounts)
	1. [Test to determine option for featureCounts -s; results in an error](#test-to-determine-option-for-featurecounts--s-results-in-an-error)
		1. [Code](#code-3)
		1. [Printed](#printed-1)
	1. [Convert the gff3 to "SAF" format](#convert-the-gff3-to-saf-format)
		1. [Code](#code-4)
		1. [Printed](#printed-2)
	1. [Test to determine option for featureCounts -s using the .saf file](#test-to-determine-option-for-featurecounts--s-using-the-saf-file)
		1. [Code](#code-5)
		1. [Printed](#printed-3)
	1. [Test to determine option for featureCounts -s with -g "ID" \(#CORRECT\)](#test-to-determine-option-for-featurecounts--s-with--g-id-correct)
		1. [Code](#code-6)
		1. [Printed](#printed-4)
	1. [Clean up](#clean-up)
		1. [Code](#code-7)
1. [Run featureCounts on all bams](#run-featurecounts-on-all-bams)
	1. [Code](#code-8)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="something"></a>
## Something
<a id="get-situated-make-directory-for-featurecounts-work-etc"></a>
### Get situated, make directory for `featureCounts` work, etc.
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get situated, make directory for featureCounts work, etc.</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 16, etc.

transcriptome && 
    {
        cd "results" \
            || echo "cd'ing failed; check on this..."
    }

if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
    conda deactivate
fi
Trinity_env

mkdir 2023-0215/
```
</details>
<br />

<a id="install-featurecounts"></a>
### Install `featureCounts`
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Install featureCounts</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mamba install -c bioconda subread
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Install featureCounts</i></summary>

```txt
❯ mamba install -c bioconda subread

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

        mamba (1.1.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['subread']

pkgs/r/linux-64                                               No change
pkgs/r/noarch                                                 No change
pkgs/main/noarch                                   819.1kB @   2.6MB/s  0.3s
bioconda/noarch                                      4.2MB @   2.7MB/s  1.9s
pkgs/main/linux-64                                   5.2MB @   2.8MB/s  5.3s
bioconda/linux-64                                    4.5MB @ 806.0kB/s  6.6s

Pinned packages:
  - python 3.10.*


Transaction

  Prefix: /home/kalavatt/miniconda3/envs/Trinity_env

  Updating specs:

   - subread
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build       Channel               Size
──────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────

  + subread    2.0.3  h7132678_1  bioconda/linux-64     25MB

  Summary:

  Install: 1 packages

  Total download: 25MB

──────────────────────────────────────────────────────────────


Confirm changes: [Y/n] Y
subread                                             24.7MB @  35.9MB/s  1.1s

Downloading and Extracting Packages

Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />

<a id="symlink-to-datasets"></a>
### Symlink to datasets
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Symlink to datasets</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd 2023-0215/ \
    || echo "cd'ing failed; check on this..."

mkdir bams/ \
    && cd bams/ \
        || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


path_1=$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI"
)
echo "${path_1}"

path_2=$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary"
)
echo "${path_2}"

ln -s "${path_1}" "aligned_UT_primary_dedup-UMI"
ln -s "${path_2}" "aligned_UT_primary"
```
</details>
<br />
<br />

<a id="run-featurecounts"></a>
## Run featureCounts
<a id="test-to-determine-option-for-featurecounts--s-results-in-an-error"></a>
### Test to determine option for featureCounts -s; results in an error
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s; results in an error</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

mkdir outfiles_featureCounts/test_fC-s

#  Check for forward-strandedness (1)
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

# featureCounts --help

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Test to determine option for featureCounts -s; results in an error</i></summary>

```txt
❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
      v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-1                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-1.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3 (GTF)                        ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3 ...                               ||

ERROR: failed to find the gene identifier attribute in the 9th column of the provided GTF file.
The specified gene identifier attribute is 'gene_id'
An example of attributes included in your GTF annotation is 'ID=YML133C_mRNA-E2;Parent=transcript:YML133C_mRNA;Name=YML133C_mRNA-E2;constitutive=1;ensembl_end_phase=0;ensembl_phase=2;exon_id=YML133C_mRNA-E2;rank=2'.
```
</details>
<br />

<a id="convert-the-gff3-to-saf-format"></a>
### Convert the gff3 to "SAF" format
*Building on advice [here](https://www.biostars.org/p/432735/#9482784)*

<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Convert the gff3 to "SAF" format</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/genomes/combined_SC_KL_20S/gff3" \
    || echo "cd'ing failed; check on this..."
gff3="combined_SC_KL.gff3"

if [[ -f "${gff3}.saf" ]]; then
    rm "${gff3}.saf"
fi
grep 'gene' "${gff3}" \
    | cut -d ';' -f1 \
    | tr -d ' ' \
    | sed 's/ID=//g'\
    | awk -v OFS='\t' '{ print $9,$1,$4,$5,$7 }' \
    | tail -n +3 \
        > "${gff3}.saf"

head "${gff3}.saf"
tail "${gff3}.saf"
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Convert the gff3 to "SAF" format</i></summary>

```txt
❯ head "${gff3}.saf"
gene:YML133C    XIII    461    4684    -
transcript:YML133C_mRNA    XIII    461    4684    -
gene:YML133W-B    XIII    827    1309    +
transcript:YML133W-B_mRNA    XIII    827    1309    +
gene:YML133W-A    XIII    1610    2185    +
transcript:YML133W-A_mRNA    XIII    1610    2185    +
gene:YML132W    XIII    7244    8383    +
transcript:YML132W_mRNA    XIII    7244    8383    +
gene:YML131W    XIII    10198    11295    +
transcript:YML131W_mRNA    XIII    10198    11295    +

❯ tail "${gff3}.saf"
transcript:YFR052C-A_mRNA    VI    253429    253734    -
transcript:YFR053C_mRNA    VI    253592    255049    -
gene:YFR054C    VI    258855    259433    -
transcript:YFR054C_mRNA    VI    258855    259433    -
gene:YFR056C    VI    263957    264325    -
transcript:YFR056C_mRNA    VI    263957    264325    -
gene:YFR055W    VI    264204    265226    +
transcript:YFR055W_mRNA    VI    264204    265226    +
gene:YFR057W    VI    269061    269516    +
transcript:YFR057W_mRNA    VI    269061    269516    +
```
</details>
<br />

<a id="test-to-determine-option-for-featurecounts--s-using-the-saf-file"></a>
### Test to determine option for featureCounts -s using the .saf file
<a id="code-5"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s using the .saf file</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

#  Check for forward-strandedness (1)
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3.saf"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "SAF" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)


#  Check for reverse-strandedness (2)
threads="${SLURM_CPUS_ON_NODE}"
strand=2
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3.saf"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "SAF" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  Seems like -s 1 is the way to go; however, only 2% of alignments are
#+ assigned; there must be a problem with the gff3 or how I am parsing it
```
</details>
<br />

<a id="printed-3"></a>
#### Printed
<details>
<summary><i>Printed: Test to determine option for featureCounts -s using the .saf file</i></summary>

```txt
❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "SAF" \
>     -o "${outfile}"
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
      v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-1                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-1.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3.saf (SAF)                    ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3.saf ...                           ||
||    Features : 24888                                                        ||
||    Meta-features : 24888                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : stranded                                              ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 493111 (2.1%)                        ||
||    Running time : 0.11 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-1.summary"                                        ||
||                                                                            ||
\\============================================================================//

❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "SAF" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
	  v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-2                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-2.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3.saf (SAF)                    ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3.saf ...                           ||
||    Features : 24888                                                        ||
||    Meta-features : 24888                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : reversely stranded                                    ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 357 (0.0%)                           ||
||    Running time : 0.03 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-2.summary"                                        ||
||                                                                            ||
\\============================================================================//
```
</details>
<br />

<a id="test-to-determine-option-for-featurecounts--s-with--g-id-correct"></a>
### Test to determine option for featureCounts -s with -g "ID" (#CORRECT)
`featureCounts -s 1` with `-g "ID"` is the way to go

<a id="code-6"></a>
#### Code
<details>
<summary><i>Code: Test to determine option for featureCounts -s with -g "ID"</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Check for forward-strandedness (1)
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)


#  Check for reverse-strandedness (2)
threads="${SLURM_CPUS_ON_NODE}"
strand=2
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
infile="bams/aligned_UT_primary/5781_G1_IN_UT.primary.bam"
outfile="outfiles_featureCounts/test_fC-s/$(basename "${infile}" .bam).fC-${strand}"

featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${infile}" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)
```
</details>
<br />

<a id="printed-4"></a>
#### Printed
<details>
<summary><i>Printed: Test to determine option for featureCounts -s with -g "ID"</i></summary>

```txt
❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "GTF" \
>     -g "ID" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
	  v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-1                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-1.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3 (GTF)                        ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3 ...                               ||
||    Features : 13166                                                        ||
||    Meta-features : 13166                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : stranded                                              ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 14202700 (60.3%)                     ||
||    Running time : 0.03 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-1.summary"                                        ||
||                                                                            ||
\\============================================================================//

❯ featureCounts \
>     --verbose \
>     -T "${threads}" \
>     -p \
>     -s "${strand}" \
>     -a "${gff}" \
>     -F "GTF" \
>     -g "ID" \
>     -o "${outfile}" \
>     "${infile}" \
>         > >(tee -a "${outfile}.stdout.txt") \
>         2> >(tee -a "${outfile}.stderr.txt" >&2)

        ==========     _____ _    _ ____  _____  ______          _____
        =====         / ____| |  | |  _ \|  __ \|  ____|   /\   |  __ \
          =====      | (___ | |  | | |_) | |__) | |__     /  \  | |  | |
            ====      \___ \| |  | |  _ <|  _  /|  __|   / /\ \ | |  | |
              ====    ____) | |__| | |_) | | \ \| |____ / ____ \| |__| |
        ==========   |_____/ \____/|____/|_|  \_\______/_/    \_\_____/
	  v2.0.3

//========================== featureCounts setting ===========================\\
||                                                                            ||
||             Input files : 1 BAM file                                       ||
||                                                                            ||
||                           5781_G1_IN_UT.primary.bam                        ||
||                                                                            ||
||             Output file : 5781_G1_IN_UT.primary.fC-2                       ||
||                 Summary : 5781_G1_IN_UT.primary.fC-2.summary               ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : combined_SC_KL.gff3 (GTF)                        ||
||      Dir for temp files : outfiles_featureCounts                           ||
||                                                                            ||
||                 Threads : 16                                               ||
||                   Level : meta-feature level                               ||
||      Multimapping reads : not counted                                      ||
|| Multi-overlapping reads : not counted                                      ||
||   Min overlapping bases : 1                                                ||
||                                                                            ||
\\============================================================================//

//================================= Running ==================================\\
||                                                                            ||
|| Load annotation file combined_SC_KL.gff3 ...                               ||
||    Features : 13166                                                        ||
||    Meta-features : 13166                                                   ||
||    Chromosomes/contigs : 23                                                ||
||                                                                            ||
|| Process BAM file 5781_G1_IN_UT.primary.bam...                              ||
||    Strand specific : reversely stranded                                    ||
||                                                                            ||
|| Chromosomes/contigs in input file but not in annotation                    ||
||    20S                                                                     ||
||                                                                            ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 23571376                                             ||
||    Successfully assigned alignments : 650463 (2.8%)                        ||
||    Running time : 0.03 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "outfiles_featureCounts/  ||
|| 5781_G1_IN_UT.primary.fC-2.summary"                                        ||
||                                                                            ||
\\============================================================================//
```
</details>
<br />

<a id="clean-up"></a>
### Clean up
<a id="code-7"></a>
#### Code
<details>
<summary><i>Code: Clean up</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/genomes/combined_SC_KL_20S/gff3" \
    || echo "cd'ing failed; check on this..."

rm *.saf

cd - \
    || echo "cd'ing failed; check on this..."
```
</details>
<br />

<a id="run-featurecounts-on-all-bams"></a>
## Run featureCounts on all bams
<a id="code-8"></a>
### Code
<details>
<summary><i>Code: </i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

#  Forward-stranded (FR) data: -s 1
threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
indir="bams/aligned_UT_primary_dedup-UMI"
outfile="outfiles_featureCounts/aligned_UT_primary_dedup-UMI.featureCounts"

# ., "${indir}/"*".bam"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${indir}/"*".bam" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

threads="${SLURM_CPUS_ON_NODE}"
strand=1
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
indir="bams/aligned_UT_primary"
outfile="outfiles_featureCounts/aligned_UT_primary.featureCounts"

# ., "${indir}/"*".bam"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    "${indir}/"*".bam" \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)
```
</details>
<br />
