
`#work_make-presentation-etc.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Scraps to be incorporated](#scraps-to-be-incorporated)
1. [Documentation `#INPROGRESS`](#documentation-inprogress)
    1. [The *"comprehensive transcriptome database"* strategy](#the-comprehensive-transcriptome-database-strategy)
        1. [Pros and cons of the `Trinity` GG and GF approaches](#pros-and-cons-of-the-trinity-gg-and-gf-approaches)
        1. [Input for the *"comprehensive transcriptome database"* strategy](#input-for-the-comprehensive-transcriptome-database-strategy)
    1. [How I called the different programs, including rationale and other details](#how-i-called-the-different-programs-including-rationale-and-other-details)
        1. [★ `PASA`](#%E2%98%85-pasa)
            1. [Details](#details)
                1. [First, here's a breakdown of the *"kinds"* of input](#first-heres-a-breakdown-of-the-kinds-of-input)
                1. [And here's a breakdown of the input with respect to both *"kinds"* and *"combinations"*](#and-heres-a-breakdown-of-the-input-with-respect-to-both-kinds-and-combinations)
            1. [The how](#the-how)
                1. [`--gene_overlap` method](#--gene_overlap-method)
                1. [`--stringent_alignment_overlap` method](#--stringent_alignment_overlap-method)
                1. [Default method \(neither `--gene_overlap` nor `--stringent_alignment_overlap`\)](#default-method-neither---gene_overlap-nor---stringent_alignment_overlap)
                1. [The meaning of the parameters](#the-meaning-of-the-parameters)
        1. [★ `Trinity`](#%E2%98%85-trinity)
            1. [Details](#details-1)
            1. [The how](#the-how-1)
                1. [GG](#gg)
                1. [GF](#gf)
        1. [★ `STAR`](#%E2%98%85-star)
        1. [★ `rcorrector`](#%E2%98%85-rcorrector)
        1. [★ `trim_galore`](#%E2%98%85-trim_galore)
1. [`#TODOs`](#todos)
    1. [Building an understanding/explanation for important parts of the `PASA` pipeline](#building-an-understandingexplanation-for-important-parts-of-the-pasa-pipeline)
1. [Presentation outline](#presentation-outline)
    1. [Slide 1](#slide-1)
        1. [Head](#head)
        1. [Body: Bullets](#body-bullets)
        1. [Tail](#tail)
    1. [Slide 2](#slide-2)
        1. [Head](#head-1)
        1. [Body: Bullets](#body-bullets-1)
        1. [Tail](#tail-1)
    1. [Slide 3](#slide-3)
        1. [Head](#head-2)
        1. [Body](#body)
            1. [Left side: Bullets](#left-side-bullets)
                1. [Abbreviated bullets](#abbreviated-bullets)
            1. [Right side: Raghavan et al., Figure 1](#right-side-raghavan-et-al-figure-1)
    1. [Slide 4](#slide-4)
        1. [Head](#head-3)
                1. [Left side: Bullets](#left-side-bullets-1)
        1. [Tail](#tail-2)
    1. [Slide 4](#slide-4-1)
        1. [Background \(not in the main slide\)](#background-not-in-the-main-slide)
    1. [Maybe](#maybe)
    1. [Citations](#citations)
    1. [Snippets](#snippets)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="scraps-to-be-incorporated"></a>
## Scraps to be incorporated
<details>
<summary><i>Click to view: Scraps to be incorporated</i></summary>

If a genome sequence is available, `Trinity` offers a method in which...
1. reads are aligned to the genome, partitioning mapped reads by locus
2. the alignments undergo local *de novo* transcriptome assembly at each locus

Thus, the genome serves as "a substrate" for grouping overlapping reads into clusters that will be separately fed into `Trinity` for *de novo* transcriptome assembly. This differs from other genome-guided approaches such as those implemented in `cufflinks` and `stringtie`, where aligned reads are stitched into transcript structures, and where <mark>transcript sequences are reconstructed based on the reference genome sequence</mark>. In the `Trinity` __GG__ approach, transcripts are reconstructed based on the actual read sequences.

Why do this? You may have a reference genome, but your sample likely comes from an organism with a genome that isn't an exact match to the reference genome. Genome-guided *de novo* assembly should capture the sequence variations contained in your RNA-Seq sample in the form of the transcripts that are *de novo* reconstructed. In comparison to genome-free *de novo* assembly, it can also help in cases where you have paralogs or other genes with shared sequences, since the genome is used to partition the reads according to locus prior to doing any *de novo* assembly. If you have a highly fragmented draft genome, then you are likely better off performing a genome-free *de novo* transcriptome assembly.
</details>
<br />
<br />

<a id="documentation-inprogress"></a>
## Documentation `#INPROGRESS`
I used [`PASA` (Program to Assemble Spliced Alignments)](https://github.com/PASApipeline/PASApipeline/wiki) to build our draft transcriptome assemblies following the *"comprehensive transcriptome database"* strategy documented [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db).

<a id="the-comprehensive-transcriptome-database-strategy"></a>
### The *"comprehensive transcriptome database"* strategy
<details>
<summary><i>Click to view: The "comprehensive transcriptome database" strategy</i></summary>

The *"comprehensive transcriptome database"* strategy attempts to overcome limitations from using either the `Trinity` genome-guided (__GG__) or `Trinity` genome-free (__GF__) assembly approaches alone, yielding what is likely a more comprehensive representation of the transcriptome.

<a id="pros-and-cons-of-the-trinity-gg-and-gf-approaches"></a>
#### Pros and cons of the `Trinity` GG and GF approaches
1. For example, some pros and cons of using the `Trinity` __GG__ approach alone:
	+ Cons
		* an inability to capture transcripts associated with non-annotated features in the reference genome
		* an inability to capture transcripts that align partially or otherwise poorly to the reference genome
		* an inability to capture any other transcripts that aren't properly represented by the reference genome
		* unmapped reads are not included in draft transcriptome assemblies
	+ Pros
		* reads are grouped based on
			- first, alignment to the reference genome
			- second, k-mer composition among reads in the grouping that results from alignment
<br />
<br />

2. And some pros and cons of using the `Trinity` __GF__ approach alone:
	+ Cons
		* reads are grouped based on k-mer composition alone
			- *(this is a "con" in certain contexts and a "pro" in others)*
			- for example, it is a "con" if there are many paralogs (or other features that share sequence similarity) in the organism's genome
			- "The k-mer composition suggests a given read could be associated with many different groups, so which group should it go into? "
	+ Pros
		* reads are grouped based on k-mer composition alone
			- *(this is a "con" in certain contexts and a "pro" in others)*
			- this a "pro" in cases where the quality of the reference genome is poor
		* an ability to capture transcripts associated with non-annotated features in a reference genome
		* an ability to capture transcripts that would align partially to a reference genome
		* an ability to capture any other transcripts that aren't properly represented by the reference genome
		* reads that would be unmapped following alignment are included in draft transcriptome assemblies

<a id="input-for-the-comprehensive-transcriptome-database-strategy"></a>
#### Input for the *"comprehensive transcriptome database"* strategy
In `PASA`'s *"comprehensive transcriptome database"* strategy, we use as input the results from calling `Trinity` twice:
1. We input a `.fasta` file from running `Trinity` in __GF__ mode
	+ `#TODO #INPROGRESS` Summarize what this is, how it works
	+ called with `--jaccard_clip`
	+ input is `.fastq` files processed as described below and filtered to contain only alignments to *S. cerevisiae*
2. We input a `.fasta` file that results from running `Trinity` in __GG__ mode
	+ `#TODO #INPROGRESS` Summarize what this is, how it works
	+ called with `--jaccard_clip`
	+ input is `.bam` files processed as described below and filtered to contain only alignments to *S. cerevisiae*
</details>
<br />

<a id="how-i-called-the-different-programs-including-rationale-and-other-details"></a>
### How I called the different programs, including rationale and other details
- Experiment begun `2022-1201`; rough draft work begun `2022-1101`
- Automated pipeline `#INPROGRESS`
<a id="%E2%98%85-pasa"></a>
#### <sup>★</sup> `PASA`
<details>
<summary><i>Click to view: PASA</i></summary>

`#DEKHO`
<a id="details"></a>
##### Details
- I called `PASA`<sup>___‡___</sup> using __three__ *"kinds"* of input in __three__ *"combinations"*
	+ That resulted in total of __nine__ different draft transcriptome assemblies to assess
- <sup>___‡___</sup>I called `PASA` in two different ways:
	+ Once without the parameter `--gene_overlap` and once with the parameter  `#TODO` Provide the rationale and invocations
	+ So, actually, there are __18__ (9 × 2) different draft transcriptome assemblies to assess

<a id="first-heres-a-breakdown-of-the-kinds-of-input"></a>
###### First, here's a breakdown of the *"kinds"* of input
- Three kinds using __"unprocessed"__ `.bam`s and .`fastq`s
	+ adapter- and quality-trimmed with `trim_galore`: `FALSE`
	+ k-mer-corrected with `rcorrector`: `FALSE`
	+ aligned with `STAR` in `Local` mode (which allows "soft clipping")
- Three kinds using __"processed"__ `.bam`s and .`fastq`s
	+ adapter- and quality-trimmed with `trim_galore`: `TRUE`  `#TODO` Provide the rationale and invocation
	+ k-mer-corrected with `rcorrector`: `FALSE`
	+ aligned with `STAR` in `EndToEnd` mode (which *doesn't* allow "soft clipping")
- Three kinds using __"processed (full)"__ `.bam`s and .`fastq`s
	+ adapter- and quality-trimmed with `trim_galore`: `TRUE`  `#TODO` Provide the rationale and invocation
	+ k-mer-corrected with `rcorrector`: `TRUE`  `#TODO` Provide the full invocation
	+ aligned with `STAR` in `EndToEnd` mode (which *doesn't* allow "soft clipping")

<a id="and-heres-a-breakdown-of-the-input-with-respect-to-both-kinds-and-combinations"></a>
###### And here's a breakdown of the input with respect to both *"kinds"* and *"combinations"*
- __"unprocessed"__
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 1 *(only __one__ alignment is allowed per read)*
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 10 *(up to __10__ alignments are allowed per read)*
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 100 *(up to __100__ alignments are allowed per read)*
- __"processed"__
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 1
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 10
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 100
- __"processed (full)"__
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 1
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 10
	+ `PASA` from `Trinity` __GF__ + `Trinity` __GG__ multi-hit-mode 100

<a id="the-how"></a>
##### The how
<a id="--gene_overlap-method"></a>
###### `--gene_overlap` method
<details>
<summary><i>Click to view code: The calls to Launch_PASA_pipeline.pl using the --gene_overlap method, followed by the call to build_comprehensive_transcriptome.dbi</i></summary>

```bash
#!/bin/bash
#DONTRUN

cat << script > "./sh_err_out/${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name%.sh}.%J.out.txt

#  ${s_name}
#  KA
#  $(date '+%Y-%m%d')

str_directory="\${1}"
str_experiment="\${2}"
str_accessions="\${3}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "\${str_directory}/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \\
    --no-home \\
    --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
    --bind "\$(pwd)" \\
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
    "\${HOME}/singularity-docker-etc/PASA.sif" \\
        "\${PASAHOME}/Launch_PASA_pipeline.pl" \\
            --CPU \${SLURM_CPUS_ON_NODE} \\
            -c "\${str_experiment}.align_assembly.config" \\
            -C \\
            -R \\
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \\
            -I 1002 \\
            -t "\${str_experiment}.transcripts.fasta.clean" \\
            -T \\
            -u "\${str_experiment}.transcripts.fasta" \\
            --TDN "\${str_accessions}" \\
            --transcribed_is_aligned_orient \\
            -L \\
            --annots "Saccharomyces_cerevisiae.R64-1-1.108.gff3" \\
            --gene_overlap ${value} \\
            --ALIGNERS "blat,gmap,minimap2" \\
                1> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stdout.log") \\
                2> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
    #  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
    if [[ -s "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
        singularity run \\
            --no-home \\
            --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
            --bind "\$(pwd)" \\
            --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
            "\${HOME}/singularity-docker-etc/PASA.sif" \\
                \${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \\
                    -c "\${str_experiment}.align_assembly.config" \\
                    -t "\${str_experiment}.transcripts.fasta" \\
                    --prefix "\${str_experiment}.compreh_init_build" \\
                    --min_per_ID 95 \\
                    --min_per_aligned 30 \\
                        1> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stdout.log") \\
                        2> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
    else
        echo "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
        echo "Check on things..."
    fi
fi

script
```
</details>
<br />

<a id="--stringent_alignment_overlap-method"></a>
###### `--stringent_alignment_overlap` method
<details>
<summary><i>Click to view code: The calls to Launch_PASA_pipeline.pl using the --stringent_alignment_overlap method, followed by the call to build_comprehensive_transcriptome.dbi</i></summary>

```bash
#!/bin/bash
#DONTRUN

cat << script > "./sh_err_out/${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name%.sh}.%J.out.txt

#  ${s_name}
#  KA
#  $(date '+%Y-%m%d')

str_directory="\${1}"
str_experiment="\${2}"
str_accessions="\${3}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "\${str_directory}/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \\
    --no-home \\
    --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
    --bind "\$(pwd)" \\
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
    "\${HOME}/singularity-docker-etc/PASA.sif" \\
        "\${PASAHOME}/Launch_PASA_pipeline.pl" \\
            --CPU \${SLURM_CPUS_ON_NODE} \\
            -c "\${str_experiment}.align_assembly.config" \\
            -C \\
            -R \\
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \\
            -I 1002 \\
            -t "\${str_experiment}.transcripts.fasta.clean" \\
            -T \\
            -u "\${str_experiment}.transcripts.fasta" \\
            --TDN "\${str_accessions}" \\
            --transcribed_is_aligned_orient \\
            --stringent_alignment_overlap ${value} \\
            --ALIGNERS "blat,gmap,minimap2" \\
                1> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stdout.log") \\
                2> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
    #  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
    if [[ -s "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
        singularity run \\
            --no-home \\
            --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
            --bind "\$(pwd)" \\
            --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
            "\${HOME}/singularity-docker-etc/PASA.sif" \\
                \${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \\
                    -c "\${str_experiment}.align_assembly.config" \\
                    -t "\${str_experiment}.transcripts.fasta" \\
                    --prefix "\${str_experiment}.compreh_init_build" \\
                    --min_per_ID 95 \\
                    --min_per_aligned 30 \\
                        1> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stdout.log") \\
                        2> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
    else
        echo "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
        echo "Check on things..."
    fi
fi

script
```
</details>
<br />

<a id="default-method-neither---gene_overlap-nor---stringent_alignment_overlap"></a>
###### Default method (neither `--gene_overlap` nor `--stringent_alignment_overlap`)

<details>
<summary><i>Click to view code: The calls to Launch_PASA_pipeline.pl using default "overlap" settings, followed by the call to build_comprehensive_transcriptome.dbi</i></summary>

```bash
#!/bin/bash
#DONTRUN

cat << script > "./sh_err_out/${s_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${s_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${s_name%.sh}.%J.out.txt

#  ${s_name}
#  KA
#  $(date '+%Y-%m%d')

str_directory="\${1}"
str_experiment="\${2}"
str_accessions="\${3}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is \${PASAHOME}"
echo ""

cd "\${str_directory}/\${str_experiment}"
echo "Working directory from which the script is called: \$(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \\
    --no-home \\
    --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
    --bind "\$(pwd)" \\
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
    "\${HOME}/singularity-docker-etc/PASA.sif" \\
        "\${PASAHOME}/Launch_PASA_pipeline.pl" \\
            --CPU \${SLURM_CPUS_ON_NODE} \\
            -c "\${str_experiment}.align_assembly.config" \\
            -C \\
            -R \\
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \\
            -I 1002 \\
            -t "\${str_experiment}.transcripts.fasta.clean" \\
            -T \\
            -u "\${str_experiment}.transcripts.fasta" \\
            --TDN "\${str_accessions}" \\
            --transcribed_is_aligned_orient \\
            --ALIGNERS "blat,gmap,minimap2" \\
                1> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stdout.log") \\
                2> >(tee -a "\${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
    #  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
    if [[ -s "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
        singularity run \\
            --no-home \\
            --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
            --bind "\$(pwd)" \\
            --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
            "\${HOME}/singularity-docker-etc/PASA.sif" \\
                \${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \\
                    -c "\${str_experiment}.align_assembly.config" \\
                    -t "\${str_experiment}.transcripts.fasta" \\
                    --prefix "\${str_experiment}.compreh_init_build" \\
                    --min_per_ID 95 \\
                    --min_per_aligned 30 \\
                        1> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stdout.log") \\
                        2> >(tee -a "\${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
    else
        echo "\${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
        echo "Check on things..."
    fi
fi

script
```
</details>
<br />

<a id="the-meaning-of-the-parameters"></a>
###### The meaning of the parameters
`#TODO`
</details>
<br />
<br />

<a id="%E2%98%85-trinity"></a>
#### <sup>★</sup> `Trinity`
<details>
<summary><i>Click to view: Trinity</i></summary>

<a id="details-1"></a>
##### Details

<a id="the-how-1"></a>
##### The how

<a id="gg"></a>
###### GG

<a id="gf"></a>
###### GF
</details>
<br />
<br />

<a id="%E2%98%85-star"></a>
#### <sup>★</sup> `STAR`
<details>
<summary><i>Click to view: STAR</i></summary>

...
</details>
<br />
<br />

<a id="%E2%98%85-rcorrector"></a>
#### <sup>★</sup> `rcorrector`
<details>
<summary><i>Click to view: rcorrector</i></summary>

...
</details>
<br />
<br />

<a id="%E2%98%85-trim_galore"></a>
#### <sup>★</sup> `trim_galore`
<details>
<summary><i>Click to view: trim_galore</i></summary>

...
</details>
<br />
<br />

<a id="todos"></a>
## `#TODOs`
<details>
<summary><i>Click to view: #TODO items</i></summary>

<a id="building-an-understandingexplanation-for-important-parts-of-the-pasa-pipeline"></a>
### Building an understanding/explanation for important parts of the `PASA` pipeline
- Review what's going on with/in `Launch_PASA_pipeline.pl`
- Understand what's going on with `validate_alignments_in_db.dbi`, which is regulated by the `PASA` `*.align_assembly.config` file
```txt
#script validate_alignments_in_db.dbi
validate_alignments_in_db.dbi:--MIN_PERCENT_ALIGNED=75
validate_alignments_in_db.dbi:--MIN_AVG_PER_ID=95
validate_alignments_in_db.dbi:--NUM_BP_PERFECT_SPLICE_BOUNDARY=0
```
- Understand what's going on with `subcluster_builder.dbi`, which is also regulated by the `PASA` `*.align_assembly.config` file
```txt
#script subcluster_builder.dbi
subcluster_builder.dbi:-m=50
```
- Understand what's going on with the parameters in `build_comprehensive_transcriptome.dbi`, e.g.,
```txt
--min_per_ID 95
--min_per_aligned 30
```
</details>
<br />
<br />

<a id="presentation-outline"></a>
## Presentation outline
*...for the presentation to be given on 2023-0111*
<a id="slide-1"></a>
### Slide 1
<a id="head"></a>
#### Head
Using quiescent yeast cells, we seek to perform a *comprehensive characterization of cryptic transcripts*

<a id="body-bullets"></a>
#### Body: Bullets
- An important, conserved feature of eukaryotic genomes is ___pervasive transcription___
- In *S. cerevisiae*, at least 85% of the genome is transcribed in cycling cells, resulting in substantial amounts of ___noncoding transcription___
    + In close proximity to or overlapping annotated genes
    + On the antisense strand
- Much of this noncoding transcription degrades on a shorter time scale than transcription detected by, e.g., RNA-seq&mdash;as such, it is termed ___cryptic transcription___
- Subsets of cryptic transcripts have been characterized and annotated through the knockout of RNA surveillance factors and chromatin modifiers `#CITATIONS`
    + When such factors are knocked out, the otherwise cryptic transcripts are stabilized  `#QUESTION Do we need to mention this in the slide?`
    + They're made capable of detection with standard transcription readouts&mdash;and thus capable of characterization  `#QUESTION Do we need to mention this in the slide?`
- However, it is an ongoing mystery as to the functions of cryptic transcripts 
- Alison and the Tsukiyama Lab have shown that quiescent cells are ___enriched for noncoding transcription in general and antisense transcripts in particular___
- Thus, using quiescent *S. cerevisiae* as a model, Alison sought to perform a ___comprehensive characterization of cryptic transcripts___...
    + Alison performed ___4tU-seq___&mdash;also known as ___"nascent RNA-seq"___
        * 4tU-seq is a variant of RNA-seq that enriches for nascent transcription
        * 4tU-seq detects low abundance and labile transcripts that are not detected with standard transcription readouts (unless analyzing cells defective for RNA degradation)  `#QUESTION Do we need to mention this in the slide?`
    + ...with the goal of identifying and characterizing noncoding and antisense transcripts detected at the entry to quiescence
    + <mark style="background-color:lightgrey;">This will be followed by experiments that infer and define the function of cryptic transcripts</mark> `#QUESTION Do we need to mention this?`

<a id="tail"></a>
#### Tail
This work necessitates the creation of a new transcriptome assembly built from the 4tU-seq data&mdash;but ___why?___ And ___what will we do with it?___
<br />
<br />

<a id="slide-2"></a>
### Slide 2
<a id="head-1"></a>
#### Head
Why do we need a new transcriptome assembly, and what will we do with it?

<a id="body-bullets-1"></a>
#### Body: Bullets
- Even though a standard *S. cerevisiae* transcriptome assembly exists, it contains little-to-no information for our transcripts of interest, namely...
    + Noncoding transcription  `#NOTE May not need these bullets`
        * Antisense transcripts
        * Intergenic transcripts
    + Alternative stop and start sites for transcripts
    + `#QUESTION Anything else?`
- Using the 4tU-seq-derived transcriptome assembly, we seek to...
    + Determine the numbers of antisense (AS) transcripts in quiescence-entry (Q) versus G1-arrest (G1) cells, and examine the differences in AS transcription between the two states; e.g.,
        * Are there changes in levels of transcription?
        * Are there positional changes such as changes in start or stop sites?
        * `#QUESTION Anything else?`
    + Determine the numbers of intergenic transcripts in Q versus G1 cells&mdash; and examine the between-state differences as above
    + Determine the extent of altered transcription start or stop sites in Q cells `#QUESTION Is this redundant with the above?`
    + Find, tally, and characterize transcripts that have never been annotated
- Having recorded exact coordinates for altered and/or novel transcripts, we will use the new assembly to...
    + measure differential expression in Q versus G1 cells
    + evaluate chromatin structure at particular kinds of loci
    + `#QUESTION Anything else?`

<a id="tail-1"></a>
#### Tail
The 4tU-seq-derived assembly makes it possible to characterize cryptic transcription&mdash;___but what does custom transcriptome assembly entail?___
<br />
<br />

<a id="slide-3"></a>
### Slide 3
<a id="head-2"></a>
#### Head
What is it to make a custom transcriptome assembly? What is the workflow?

<a id="body"></a>
#### Body
<a id="left-side-bullets"></a>
##### Left side: Bullets
- In transcriptome assembly, millions of "short" reads&mdash;sequences of nucleotides (e.g., CCGCGTGGAGGCAG) from transcription-specific next generation sequencing experiments&mdash;are pieced together to match or closely resemble their genomic sequences of origin: These are the ___assembled transcripts___
- In general, reads can be assembled through either <b>(a)</b> reference genome-guided or <b>(b)</b> *de novo*&mdash;a.k.a., genome-free&mdash;approaches
    + In the genome-guided approach, transcriptome assembly occurs when reads are mapped to the reference genome
        * Doing so is a means to determine the gene sequences from which the reads originate
        * From there, transcripts are reconstructed
    + In the genome-free approach, assembly is accomplished using the information contained in the reads alone
- We perform a hybrid approach, building transcripts from both genome-guided and genome-free approaches&mdash;but before diving into that, it's important to discuss the general workflow for transcriptome assembly

<a id="abbreviated-bullets"></a>
###### Abbreviated bullets
- In transcriptome assembly, millions of "short" reads are pieced together to match or closely resemble their genomic sequences of origin: These are the assembled transcripts
- In general, reads can be assembled through either <b>(a)</b> reference genome-guided or <b>(b)</b> *de novo*&mdash;a.k.a., genome-free&mdash;approaches
    + In the genome-guided approach, transcriptome assembly occurs when reads are mapped to the reference genome
    + In the genome-free approach, assembly is accomplished using the information contained in the reads alone
We perform a hybrid approach&mdash;but before diving into that, it's important to discuss the general workflow for transcriptome assembly

<a id="right-side-raghavan-et-al-figure-1"></a>
##### Right side: Raghavan et al., Figure 1

<a id="slide-4"></a>
### Slide 4
<a id="head-3"></a>
#### Head
What is it to make a custom transcriptome assembly? What is the workflow?

<a id="left-side-bullets-1"></a>
###### Left side: Bullets
- (A) The sequencing data must be quality controlled
- (B) The data is then assembled to obtain the reference transcriptome; then, it’s further quality controlled to produce an artifact-free assembly
- (C, D) Read alignment and transcript abundance estimation (C) are performed both as quality control measures, and differential transcript expression levels can be estimated (D)
- (E) If the RNA-seq data are suspected to contain non-mRNA species, RNA classification can be carried out to classify and filter the data
- (E) Transcriptomic sequences can be translated into their amino acid counterparts
- (F) The nucleotide (and/or translated protein) sequences can be annotated to assign identifiers and elucidate biological roles


- First, the sequencing data must be quality controlled (A); this can include
    + excluding reads originating from rRNAs
    + removing adapter sequences
    + `#TODO Add more, including rcorrector`
    + \[(A) Section ‘Pre-assembly quality control and filtering’\]
- Next, the data can be assembled (here, we see an illustration for *de novo* assembly) to obtain the transcriptome
    + they must then be quality controlled again to produce a final artifact-free assembly (B)
    + \[(B), Sections ‘De novo transcriptome assembly’, ‘Post-assembly quality control’, ‘Alignment and abundance estimation’, and ‘Assembly thinning and redundancy reduction’\]
- Read alignment and transcript abundance estimation (C) are performed both as quality control measures and to estimate transcript expression levels for differential expression analysis (D)
    + \[(C), Section ‘Alignment and abundance estimation’\]
    + \[(D), Section ‘Differential expression analysis’\]
- If the RNA-seq data are suspected to contain non-mRNA species, RNA classification can be carried out to classify and filter the data (E)
    + \[(E), Section ‘RNA classification’\]
- Protein sequences are useful in many contexts (including annotation), and therefore, the transcriptomic sequences can be translated into their amino acid counterparts (E)
    + \[(E), Section ‘Sequence translation’\]
- Finally, the nucleotide (and/or translated protein) sequences can be annotated to assign human-readable identifiers to them, and elucidate their biological roles (F)
    + \[(F), Section ‘Transcriptome functional annotation’)\]

<a id="tail-2"></a>
#### Tail
To be determined

<a id="slide-4-1"></a>
### Slide 4


<a id="background-not-in-the-main-slide"></a>
#### Background (not in the main slide)
- The "short" reads are typically 50 to 250 bp in length

<a id="maybe"></a>
### Maybe
- In __Slide 1__, below the bullet for *"Using 4tU-seq data, we seek to perform a..."*
    + We also seek to analyze noncoding transcription when the Nrd1-Nab3-Sen1 (NNS) complex is disrupted  `#QUESTION Do we need to mention this?`
- Depending on the above answer, some pieces I may need to fit into __Slide 1__
    + `#TODO` Want to ask and answer, *"Why do we need a new transcriptome assembly?"*
    + `#TODO` Brief rationale for disruption of NNS complex and analysis of transcription afterwards
        * NNS promotes transcription termination (or, more specifically, promotes); thus, it is expected that antisense transcription is increased in this model
        * `#QUESTIONS` Are we examining transcription in the NNS-KO model at Q entry, i.e., is this Q entry NNS-WT vs NNS-KO? And/or are G1-arrest or cycling cells analyzed in this experiment?

<a id="citations"></a>
### Citations
- Slide 1
    + Tudek A, Candelli T, Libri D, "Non-coding transcription by RNA polymerase II in yeast: Hasard or nécessité?", *Biochimie.* 2015
    + van Dijk EL, Chen CL, d'Aubenton-Carafa Y, Gourvennec S, Kwapisz M, Roche V, et al., "XUTs are a class of Xrn1-sensitive antisense regulatory non-coding RNA in yeast", *Nature* 2011
    + `#QUESTION` Others?
    + <mark>Greenlaw et al., *in preparation*</mark>

<a id="snippets"></a>
### Snippets
- From Alison: "Eg. My first annotation attempt allowed me to show that the 3’ NDR at convergent genes that fail to terminate is shallower than convergent genes that terminate appropriately."
