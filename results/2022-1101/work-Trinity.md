
# 2022-1102-1113
<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get another trial run of `Trinity` going](#get-another-trial-run-of-trinity-going)
    1. [Meaning of `Trinity` parameters used](#meaning-of-trinity-parameters-used)
1. [Continued reading, studying regarding `Trinity`](#continued-reading-studying-regarding-trinity)
    1. [Outstanding, ongoing questions, points, etc.](#outstanding-ongoing-questions-points-etc)
    1. [In-progress steps of the pipeline](#in-progress-steps-of-the-pipeline)
    1. [In-progress list of packages for the pipeline](#in-progress-list-of-packages-for-the-pipeline)
    1. [References for the experimental design/pipeline](#references-for-the-experimental-designpipeline)
    1. [Notes from the references listed above](#notes-from-the-references-listed-above)
        1. [McIlwain et al. \(Hittinger\), *G3* 2016](#mcilwain-et-al-hittinger-g3-2016)
            1. [From *Materials and Methods*](#from-materials-and-methods)
            1. [From *File S1*](#from-file-s1)
        1. [Blevins et al. \(Mar Alba\), bioRxiv 2019-0313](#blevins-et-al-mar-alba-biorxiv-2019-0313)
            1. [From *Results*](#from-results)
            1. [From *Supplementary Figure 1*](#from-supplementary-figure-1)
            1. [From *Methods*](#from-methods)
        1. [Build a Comprehensive Transcriptome Database](#build-a-comprehensive-transcriptome-database)
            1. [Build a Comprehensive Transcriptome Database Using Genome-Guided and *De Novo* RNA-seq Assembly](#build-a-comprehensive-transcriptome-database-using-genome-guided-and-de-novo-rna-seq-assembly)
        1. [Leveraging RNA-seq by the `PASA` Pipeline](#leveraging-rna-seq-by-the-pasa-pipeline)
            1. [Leveraging RNA-seq by the `PASA` Pipeline](#leveraging-rna-seq-by-the-pasa-pipeline-1)
                1. [Strand-specific RNA-seq](#strand-specific-rna-seq)
                1. [Non-Strand-specific RNA-seq](#non-strand-specific-rna-seq)
        1. [Running the `PASA` Alignment Assembly Pipeline](#running-the-pasa-alignment-assembly-pipeline)
            1. [Running the Alignment Assembly Pipeline](#running-the-alignment-assembly-pipeline)
                1. [Step A: Cleaning the transcript sequences \(optional\)](#step-a-cleaning-the-transcript-sequences-optional)
                1. [Step B: Walking Thru A Complete Example Using the Provided Sample Data](#step-b-walking-thru-a-complete-example-using-the-provided-sample-data)
        1. [Introduction to `PASA`](#introduction-to-pasa)
            1. [`PASA` in the Context of a Complete Eukaryotic Annotation Pipeline](#pasa-in-the-context-of-a-complete-eukaryotic-annotation-pipeline)
1. [Sussing out the alignment work for the pipeline](#sussing-out-the-alignment-work-for-the-pipeline)
    1. [On calling `Bowtie 2`](#on-calling-bowtie-2)
        1. [Meaning of `Bowtie 2` parameters](#meaning-of-bowtie-2-parameters)
        1. [How we should call `Bowtie 2`](#how-we-should-call-bowtie-2)
    1. [On calling `STAR`](#on-calling-star)
        1. [Building a `STAR` genome index](#building-a-star-genome-index)
        1. [Meaning of `STAR` parameters for `genomeGenerate`](#meaning-of-star-parameters-for-genomegenerate)
        1. [How we should call `STAR`](#how-we-should-call-star)
            1. [Meaning of `STAR` parameters for `alignReads`](#meaning-of-star-parameters-for-alignreads)
            1. [Rationale behind parameters based on pertinent 'rna-star' Google group conversation](#rationale-behind-parameters-based-on-pertinent-rna-star-google-group-conversation)
                1. [Post #1, Marco, 2016-0502](#post-1-marco-2016-0502)
                1. [Post #2, Alex, 2016-0503](#post-2-alex-2016-0503)
                1. [Post #3, Marco, 2016-0504](#post-3-marco-2016-0504)
                1. [Post #4, Marco, 2016-0504](#post-4-marco-2016-0504)
                1. [Post #5, Marco, 2016-0504](#post-5-marco-2016-0504)
    1. [Implementing the alignment steps with `STAR` and `Bowtie 2`](#implementing-the-alignment-steps-with-star-and-bowtie-2)
        1. [Generating files needed for `STAR` alignment \(2022-1107\)](#generating-files-needed-for-star-alignment-2022-1107)
            1. [Preparing the `.fasta` and `.gff3` files for `STAR`](#preparing-the-fasta-and-gff3-files-for-star)
            1. [Getting the `.fastq` files of interest into one location](#getting-the-fastq-files-of-interest-into-one-location)
            1. [Checking on the length of reads for each `.fastq` file](#checking-on-the-length-of-reads-for-each-fastq-file)
        1. [Run `STAR` genome generation](#run-star-genome-generation)
        1. [Run `STAR` alignment](#run-star-alignment)
            1. [Alignment metrics for the test run of `STAR`](#alignment-metrics-for-the-test-run-of-star)
                1. [Thoughts on the alignment metrics for `STAR`:](#thoughts-on-the-alignment-metrics-for-star)
                1. [Examine the flags in the `.bam` outfile from the test run of `STAR`](#examine-the-flags-in-the-bam-outfile-from-the-test-run-of-star)
                1. [Additional thoughts on the alignment metrics and flags from `STAR`](#additional-thoughts-on-the-alignment-metrics-and-flags-from-star)
                1. [Do a little clean-up prior to running alignment with `Bowtie 2`](#do-a-little-clean-up-prior-to-running-alignment-with-bowtie-2)
        1. [Generating files needed for `Bowtie 2` alignment \(2022-1108\)](#generating-files-needed-for-bowtie-2-alignment-2022-1108)
            1. [Preparing the `.fasta` and `.gff3` files for `Bowtie 2`](#preparing-the-fasta-and-gff3-files-for-bowtie-2)
            1. [On the location of the `.fastq` files](#on-the-location-of-the-fastq-files)
            1. [Run `Bowtie 2` alignment](#run-bowtie-2-alignment)
            1. [Alignment metrics for the test run of `Bowtie 2`](#alignment-metrics-for-the-test-run-of-bowtie-2)
                1. [Thoughts on the alignment metrics for `Bowtie 2`](#thoughts-on-the-alignment-metrics-for-bowtie-2)
                1. [Examine the flags in the `.bam` outfile from the test run of `Bowtie 2`](#examine-the-flags-in-the-bam-outfile-from-the-test-run-of-bowtie-2)
            1. [Try re-running `Bowtie 2` alignment](#try-re-running-bowtie-2-alignment)
            1. [Alignment metrics for the *corrected* test run of Bowtie 2](#alignment-metrics-for-the-corrected-test-run-of-bowtie-2)
                1. [Thoughts on the alignment metrics for `Bowtie 2` \(*corrected*\)](#thoughts-on-the-alignment-metrics-for-bowtie-2-corrected)
                1. [Examine the flags in the `.bam` outfile from the *corrected* test run of `Bowtie 2`](#examine-the-flags-in-the-bam-outfile-from-the-corrected-test-run-of-bowtie-2)
                1. [Examine the `.fastq` outfiles from the *corrected* test run of `Bowtie 2`](#examine-the-fastq-outfiles-from-the-corrected-test-run-of-bowtie-2)
                1. [`head` through the `.bam` outfile from the *corrected* test run of `Bowtie 2`](#head-through-the-bam-outfile-from-the-corrected-test-run-of-bowtie-2)
        1. [More thoughts on multimappers \(2022-1109-1110, 1115\)](#more-thoughts-on-multimappers-2022-1109-1110-1115)
            1. [Conversation with Brian Haas, author/maintainer of Trinity](#conversation-with-brian-haas-authormaintainer-of-trinity)
            1. [Material on multimappers from the `STAR` documentation](#material-on-multimappers-from-the-star-documentation)
                1. [4.1 Multimappers.](#41-multimappers)
                1. [5.2.1 Multimappers.](#521-multimappers)
            1. [Mapping parameters used in Teissandier et al., *Mobile DNA* 2019](#mapping-parameters-used-in-teissandier-et-al-mobile-dna-2019)
                1. [Unique mode](#unique-mode)
                1. [Random mode](#random-mode)
                1. [Multi-hit mode](#multi-hit-mode)
            1. [Meaning of the `STAR` parameters for Teissandier-styled alignment](#meaning-of-the-star-parameters-for-teissandier-styled-alignment)
            1. [How we called `STAR` previously \(based on 'rna-star' post, not retaining multimappers\) vs. multi-hit mode](#how-we-called-star-previously-based-on-rna-star-post-not-retaining-multimappers-vs-multi-hit-mode)
                1. [Previous \(based on 'rna-star' post\):](#previous-based-on-rna-star-post)
                1. [Multi-hit mode:](#multi-hit-mode-1)
                1. [Going through the parameters, making comparisons between the two approaches:](#going-through-the-parameters-making-comparisons-between-the-two-approaches)
                1. [Assessing the "ingredients"](#assessing-the-ingredients)
            1. [How we should call `STAR` taking into account 'rna-star' and multi-hit mode parameters](#how-we-should-call-star-taking-into-account-rna-star-and-multi-hit-mode-parameters)
            1. [How are other groups calling `STAR` with *S. cerevisiae*?](#how-are-other-groups-calling-star-with-s-cerevisiae)
                1. [Dorfel et al. \(Lyon\), Yeast 2017](#dorfel-et-al-lyon-yeast-2017)
                1. [Jensen et al. \(Jensen\), *Nat Comm* 2022](#jensen-et-al-jensen-nat-comm-2022)
                1. [Software and parameter settings used by OneStopRNAseq v1.0.0](#software-and-parameter-settings-used-by-onestoprnaseq-v100)
                1. [Mendoza et al., *Sci Adv* 2022](#mendoza-et-al-sci-adv-2022)
                1. [VELCRO-IP RNA-seq Data Analysis: Read Alignment and Quantification](#velcro-ip-rna-seq-data-analysis-read-alignment-and-quantification)
                1. [Osman et al. \(Cramer\), *JBC* 202100523-8/pdf)](#osman-et-al-cramer-jbc-202100523-8pdf)
        1. [Run `STAR` alignment, retaining multimappers \(2022-1115-1116\)](#run-star-alignment-retaining-multimappers-2022-1115-1116)
            1. [Alignment metrics for the test run of `STAR` \(multi-hit mode\)](#alignment-metrics-for-the-test-run-of-star-multi-hit-mode)
                1. [Thoughts on the alignment metrics for `STAR` \(multi-hit mode\)](#thoughts-on-the-alignment-metrics-for-star-multi-hit-mode)
                1. [Examine the flags in the `.bam` outfile from the test run of `STAR` \(multi-hit mode\)](#examine-the-flags-in-the-bam-outfile-from-the-test-run-of-star-multi-hit-mode)
        1. [Writing and testing `split_bam_by_species.sh`](#writing-and-testing-split_bam_by_speciessh)
            1. [Use `split_bam_by_species.sh` to get VII and *K. lactis* chromosomes from `.bam` files \(2022-1116\)](#use-split_bam_by_speciessh-to-get-vii-and-k-lactis-chromosomes-from-bam-files-2022-1116)
            1. [Having updated and "function-ized" `split_bam_by_species.sh`, test it \(2022-1117\)](#having-updated-and-function-ized-split_bam_by_speciessh-test-it-2022-1117)
        1. [Writing and testing `exclude_bam_reads-unmapped.sh` \(2022-1117\)](#writing-and-testing-exclude_bam_reads-unmappedsh-2022-1117)
1. [Miscellaneous](#miscellaneous)
    1. [Figure out where to put this](#figure-out-where-to-put-this)
        1. [Brief discussion with Toshi about yeast blacklists](#brief-discussion-with-toshi-about-yeast-blacklists)
    1. [Google searches and websites to follow up on](#google-searches-and-websites-to-follow-up-on)
    1. [To be continued after the completion of `Trinity` work](#to-be-continued-after-the-completion-of-trinity-work)
        1. [Discussion with Alison on what I should prioritize \(2022-1103\)](#discussion-with-alison-on-what-i-should-prioritize-2022-1103)
    1. [Next steps](#next-steps)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="get-another-trial-run-of-trinity-going"></a>
## Get another trial run of `Trinity` going
<details>
<summary><i>Click here to expand</i></summary>

Just to reacquaint yourself with things...
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 node, default memory, 1 node, no GPU (default)

#  cd into the work directory
results="${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results"
cd "${results}/2022-1101"

#  Make a directory for the results from the previous picardmetrics test (see
#+ above)
mkdir -p exp_picardmetrics
mv 5781_G1_IN_sorted.* picardmetrics.conf exp_picardmetrics/

#  Make symlinks to the test bams
ln -s \
"${results}/2022-1021/5781_Q_IP_sorted.bam" \
"./5781_Q_IP_sorted.bam"

ln -s \
"${results}/2022-1021/5781_Q_IP_sorted.chrVII.bam" \
"./5781_Q_IP_sorted.chrVII.bam"

#  Check that the symlinks are valid
ml SAMtools/1.16.1-GCC-11.2.0  # Load in samtools

samtools view "./5781_Q_IP_sorted.bam" | head -5
# HISEQ:1007:HGV5NBCX3:1:1207:3282:88984  99  chrI    147 17  49M =   307 209 TTACCCTGTCTCATTCAACCATACCACTCCCAACTACCATCCATCCCTC   GGGGIGIIIIGGIIIIIIIGIGIIIIIIIGIIIIIIIGIIIIIGIIIGI   AS:i:75 XS:i:52 XN:i:0  XM:i:3  XO:i:0  XG:i:0  NM:i:3  MD:Z:10C19G3C14 YS:i:90 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1216:10817:56273 99  chrI    159 2   49M =   234 123 ATTCAACTATACCACTCCCAACTACCATCCATCTCTCTACTTACTACCA   GGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGGIIIIIIIGIIIG   AS:i:66 XS:i:78 XN:i:0  XM:i:4  XO:i:0  XG:i:0  NM:i:4  MD:Z:7C10G3C10C15   YS:i:80 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1112:7352:13135  99  chrI    226 2   19M1I29M    =   433 257 CCAATTACCCATATCCTACTCCACTGCCACTTACCCTACCATTCCCCTA   GGGGGGGIIIIIGIIIIIIIIIIIIIGIIIGIGGGGAGGIIIIGIIIII   AS:i:73 XS:i:75 XN:i:0  XM:i:2  XO:i:1  XG:i:1  NM:i:3  MD:Z:16A25A5    YS:i:73 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2210:9324:79218  99  chrI    229 11  16M1I32M    =   295 115 ATTACCCATATCCTACTCCACTGCCACTTACCCTACCATTACCCTACCA   GGGGGGIIIIIIIIIIIIIIIIIIIGGGIIIIIIIIIGIIIIIIIIIIG   AS:i:80 XS:i:82 XN:i:0  XM:i:1  XO:i:1  XG:i:1  NM:i:2  MD:Z:13A34  YS:i:90 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1216:10817:56273 147 chrI    234 2   11M1I37M    =   159 -123    CCATATCCTACTCCACTGCCACTTACCCTACCATTACCCTACCATCCAC   IIGGGIIIIGGGIGGGGIIIIIIGGGIIIGIIIGGGIIGGGIGGGGGGG   AS:i:80 XS:i:83 XN:i:0  XM:i:1  XO:i:1  XG:i:1  NM:i:2  MD:Z:8A39   YS:i:66 YT:Z:CP

samtools view "./5781_Q_IP_sorted.chrVII.bam" | head -5
# HISEQ:1007:HGV5NBCX3:1:1216:9044:65854  99  chrVII  79  11  1S48M   =   252 219 GTCTCTCAACTTACCCTCCATTACCCTACCTCACCACTCGTTACCCTGT   AGA.<AGGGAGGAA<AGGGGIIIIGGIIGGGGIGGIGIIIIIIIIGGAG   AS:i:81 XS:i:90 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:4A26C16    YS:i:72 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2105:9998:77180  99  chrVII  189 0   22S27M  =   403 286 CCATTCATCCCTCTACTTCCTACCATCATAACCGTTACCCTCCAATTAC   GGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII   AS:i:54 XS:i:54 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:27 YS:i:77 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:2103:16874:90641 99  chrVII  215 34  49M =   390 224 CCATATCCAACTCCACTACCATTACCCTACTATTACCCTACCATCCACC   GGGGGIIIIIIIIIIIIIIIIIIIIIIGIIIIIIIIGIIIIIIIIIIII   AS:i:98 XS:i:98 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:49 YS:i:98 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1109:8925:17739  99  chrVII  220 17  1S48M   =   347 177 TTCCAACTCCACTACCATTACCCTACTATTACCCTACCATCCACCATGT   GGGGGIIIIIGGGGIGGIGGIIIIIIIIIGGGIIIGGGIIIGGGGGIGG   AS:i:96 XS:i:96 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:48 YS:i:76 YT:Z:CP
# HISEQ:1007:HGV5NBCX3:1:1216:9044:65854  147 chrVII  252 11  4S43M2S =   79  -219    TCATCTACCATCCACCATGTCCTACTCACCATACTGTTGTTCTACCCAC   GAGGGGG<<.GIGIGGGGGGIIIIIGGGGGGIGGGGGGGGIGGAGAAAA   AS:i:72 XS:i:72 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:25T0G16    YS:i:81 YT:Z:CP

#  Write out the script for calling Trinity
cat << script > "./submit-Trinity.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Trinity.sh
#  KA

module load Trinity/2.10.0-foss-2019b-Python-3.7.4

file="5781_Q_IP_sorted.chrVII.bam"  # Separately, try 5781_Q_IP_sorted.bam

Trinity \\
    --genome_guided_bam "\${file}" \\
    --CPU "\${SLURM_CPUS_ON_NODE}" \\
    --max_memory 50G \\
    --SS_lib_type FR \\
    --normalize_max_read_cov 200 \\
    --jaccard_clip \\
    --genome_guided_max_intron 1002 \\
    --min_kmer_cov 2 \\
    --max_reads_per_graph 500000 \\
    --min_glue 2 \\
    --group_pairs_distance 700 \\
    --min_contig_length 200 \\
    --full_cleanup \\
    --output "./trinity_\${file%.bam}"
script

#  Run submit-Trinity.sh on SLURM
sbatch ./submit-Trinity.sh

#  Run time:
#+ - Job started: Thursday, November 3, 2022: 15:26:01
#+ - Job finished: Thursday, November 3, 2022: 15:37:00


#  Clean up Trinity outfiles
pwd
# "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

mkdir -p exp_Trinity
mv 5781_* 3299486* trinity_5781_* exp_Trinity/
```

<a id="meaning-of-trinity-parameters-used"></a>
### Meaning of `Trinity` parameters used
- `--genome_guided_bam`: "If a genome sequence is available, Trinity offers a method whereby reads are first aligned to the genome, partitioned according to locus, followed by *de novo* transcriptome assembly at each locus" ([more info](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly))
    - "In this use-case, the genome is only being used as a substrate for grouping overlapping reads into clusters that will then be separately fed into Trinity for *de novo* transcriptome assembly."
    - "This is very much *unlike* typical genome-guided approaches (e.g., cufflinks) where aligned reads are stitched into transcript structures and where transcript sequences are reconstructed based on the reference genome sequence."
    - "Here, transcripts are reconstructed based on the actual read sequences."
- `--max_memory`: suggested max memory to use by Trinity, where limiting can be enabled
- `--SS_lib_type`: if paired, RF or FR (dUTP method = RF); if single, F or R; this means that left-end reads are on the forward strand and right-end reads are on the reverse strand
- `--normalize_max_read_cov`: defaults to 200, an *in silico* read normalization option
    - `#QUESTION` Does it mean that it sets the maximum coverage to 200x?
    - `#ANSWER` It means that "poorly covered regions \[are\] unchanged, but reads \[are\] down-sampled in high-coverage regions" (see slide 16 [here](https://biohpc.cornell.edu/lab/doc/Trinity_workshop.pdf))
    - "May end up using just 20% of all reads reducing computational burden with no impact on assembly quality"
    - `#NOTE` This normalization method has "mixed reviews" – \[it\] tends to skip whole genes
- `--jaccard_clip`: set if you have paired reads and you expect high gene density with UTR overlap (use FASTQ input file format for reads)
    - `#QUESTION`: Our input appears to be a bam; does this affect things?
- `--genome_guided_max_intron`: "...use a maximum intron length that makes most sense given your targeted organism" ([more info](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly))
- `--min_kmer_cov`: with a setting of 2, it means that singleton k-mers will not be included in initial Inchworm contigs (suggested by the Trinity team)
- `--max_reads_per_graph`: maximum number of reads to anchor within a single graph (default: 200000)
- `--min_glue`: min number of reads needed to glue two inchworm contigs together. (default: 2)
- `--group_pairs_distance`: maximum length expected between fragment pairs (default: 500) (reads outside this distance are treated as single-end)
- `--min_contig_length`: minimum assembled contig length to report (def=200, must be >= 100)
- `--full_cleanup`: only retain the Trinity fasta file, rename as `${output_dir}.Trinity.fasta`
- `--output`: name of directory for output (will be created if it doesn't already exist) default( your current working directory: `/usr/local/src/trinity_out_dir` note: must include 'trinity' in the name as a safety precaution! )
<br />
<br />
</details>

<a id="continued-reading-studying-regarding-trinity"></a>
## Continued reading, studying regarding `Trinity`
Builds on work [performed here](../2022-1025/readme.md#snippets-etc-from-searching-the-trinity-google-group)

<a id="outstanding-ongoing-questions-points-etc"></a>
### Outstanding, ongoing questions, points, etc.
- When building a transcriptome with Trinity, should we use all `.fastq` (*de novo* assembly) or `.bam` (genome-guided assembly) files in one run? Would doing so build a transcriptome from that combined information?
- What is *minimizing the sum of ranks* [described below](#from-file-s1)?
    + Does it mean summing the three metrics of interest&mdash;**Transcript Length Distribution Related Factors (when maximized)**, **Unweighted K-mer KL_A_to_M (when minimized)**, and **Unweighted_Pair_F1 (when maximized)**&mdash;and then taking the assembly with lowest sum?
    + I think that could be it...
    + Some kind of transformation (hence, "rank") needs to take place, I think
- For `Bowtie 2` alignment, what does "concordant" and "discordant" mean?
    + "A discordant alignment is an alignment where both mates align uniquely, but that does not satisfy the paired-end constraints (`--fr`/`--rf`/`--ff`, `-I`, `-X`)" ([reference](https://www.biostars.org/p/78446/))
        * `--fr`/`--rf`/`--ff`: The upstream/downstream mate orientations for a valid paired-end alignment against the forward reference strand
        * `-I`: The minimum fragment length for valid paired-end alignments
        * `-X`: The maximum fragment length for valid paired-end alignments
- For `Bowtie 2` alignment, what does `--no-mixed`/"mixed mode" mean?
    + If `Bowtie 2` cannot find a paired-end alignment for a pair, by default it will go on to look for unpaired alignments for the constituent mates. This is called "mixed mode."
    + To disable mixed mode, set the `--no-mixed` option.
    + `Bowtie 2` runs a little faster in `--no-mixed` mode, but <mark>will only consider alignment status of pairs *per se*, not individual mates</mark>.
    + ([reference](https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml#mixed-mode-paired-where-possible-unpaired-otherwise))
- `Bowtie 2` is not a splice-aware aligner, so why are we using it for RNA-seq work?
    + Very little splicing takes place in yeast
    + I discussed this with Toshi on 2022-1107
        * Categories of genes that undergo splicing
            - Ribosome protein-coding genes
            - Housekeeping genes such as ACT1 (Actin)  `#TODO Look up how to format genes and proteins for yeast`
            - Toshi says that genes with alternative splicing tend to be constitutively active
                + These are not well-studied by researchers who tend to be interested in genes that are expressed under different conditions and circumstances
                + "...boring"
        * Per Toshi, there are no genes with more than one intron
        * Average gene size is less than one kb, probably ~800 bp, but Toshi is not certain about that
        * Out of some 6000 genes, 283 have introns (nearly 5%)
            - `#NOTE` This could make the switch from Bowtie 2 to a splice-aware aligner such as STAR meaningful
- What does "\[a\]lignment stringency was set to minimum of 95% identity across at least 90% of the transcript sequence" as [described below](#from-file-s1)?
    + I think it will become clear as I read through the `PASA` documentation
- Could [this use of `Cuffmerge`](#from-supplementary-figure-1) address the [downstream work](../notebook.md#discussion-with-alison-on-what-i-should-prioritize) required for the transcriptome-assembly process?
    + More info on [`Cuffmerge` here](http://cole-trapnell-lab.github.io/cufflinks/cuffmerge/)
- `#IMPORTANT` Prior to running `Trinity`&mdash;among other things&mdash;we need to map the `.fastq` files to the combined reference (*S. cerevisiae*, *K. lactis*, and 20 S) and then filter out those that are assigned to *K. lactis* and 20 S
    + Then, we need to convert the `.bam` files back to `.fastq` files
    + `#QUESTION` But what about reads that are unmapped?
        * Option #1: ***Do include them*** with reads that mapped to *S. cerevisiae* in the *de novo* transcriptome assembly
        * Option #2: ***Do not include them*** with reads that mapped to *S. cerevisiae* in the *de novo* transcriptome assembly
    + And what about the parameters for calling `Bowtie2`? Here is how we're currently calling it:

<a id="in-progress-steps-of-the-pipeline"></a>
### In-progress steps of the pipeline
0. Generate downsampled paired-end `.fastq` files for use in tests of preprocessing and *de novo* transcriptome assembly
1. Run some kind of quality check on the `.fastq` files, e.g., `FastqQC` or `fastp`, paying attention to
    - adapter content
    - k-mer content
    - other metrics? `#TODO`
2. Filter out adapters using, e.g., `Trimmomatic` or `Trim Galore`, which has been shown to outperform `Trimmomatic`  
3. Map the `.fastq` files to the combined reference (*S. cerevisiae*, *K. lactis*, and 20 S) with `Bowtie 2`
    - `Bowtie 2`
        + Retain unmapped reads in the resulting `.bam` files
            * (or write the unmapped reads to a separate `.bam` or `.fastq` file)
            * `#DONE` Get rid of `--no-unal`
        + I don't think we should worry about concordance with the initial alignments
            * Thus, perhaps we should get rid of the flags that control for concordance
            * ~~Actually, we can keep *some* of the flags because they'll be retained in one form or another~~
                - ~~If they're properly paired but not concordant, they'll be written to `"${infiles[0]%_R1.fastq}.unaligned"` via `--un-conc-gz`~~
                - If they're not properly paired, we won't be able to evaluate concordance, but they'll be retained in the sense that they'll be written to the `.bam` outfile because we're no longer calling `--no-unal`
                - `#DONE` Actually, go ahead and get rid of `--no-discordant` because we don't want them written to a `.fastq` file: we want them written to the `.bam` outfile with mapped coordinates (that we can later use for filtering)
                - `#DONE` Go ahead and get rid of `--no-overlap` too for the same reasons
                - `#DONE` Same with `--no-dovetail`
        + I don't think we should worry about unpaired alignments for paired reads just yet either; just keep and use them all, if possible
            * `#DONE` Get rid of `--no-mixed`
        + `#TODO` Get rid of `--trim5`; not sure why we bother with it in the first place
        + `#MAYBE` Get rid of `--al-conc-gz` because it writes the alignments to a `.fastq.gz`; actually, I think they're going into the `.bam` too... hold off on this
    - `STAR`
        + Map the `.fastq` files to the combined reference with `STAR`
        + Can use [these parameters](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c)
4. Filter `.bam` files to remove reads that are assigned to *K. lactis* and 20 S&mdash;and `#QUESTION` *S. cerevisiae* chrM as well? `#TODO`
    - `#ANSWER` Let's go with 'yes' 
5. Convert the `.bam` files back to `.fastq` files
    - `#TODO` Determine the handling of unmapped reads: If we decide we want to include them in the transcriptome assembly, then they need to be in the resulting `.fastq` files
6. Perform a quality check of the new `.fastq` files using the same program, paying special attention to the same metrics
7. `#OPTIONAL` Based on the results of the quality check, trim adapters and low quality bases from `.fastq` files
7. Remove erroneous k-mers with `rCorrector` `#TODO` Look into this
8. Discard read pairs in which at least one of the reads is "unfixable"
9. `#MAYBE` Map trimmed reads to a blacklist to remove unwanted (rRNA reads; OPTIONAL)  `#TODO Check with Alison on whether or not we would want to do this`
    + ["Reads mapped to blacklisted regions were removed (i.e., mitochondrial genome, ribosomal genes in chromosome 12, and subtelomeres)."](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8407396/) (do `cmd f` for *blacklist*)
    + If your RNA-seq libraries are built with a stranded protocol (see the link)  `#QUESTION What was I typing up and referring to here?`  `#TODO Come back to the best practices document`
    + Spoke with Toshi briefly about the existence of and use of blacklists in yeast NGS work; [details below](#brief-discussion-with-toshi-about-yeast-blacklists)
10. ...

<a id="in-progress-list-of-packages-for-the-pipeline"></a>
### In-progress list of packages for the pipeline
- Ongoing list packages for a `conda env` for doing the transcriptome-assembly work:
    + `Trinity`
        * [`conda`](https://anaconda.org/bioconda/trinity)
        * [`Repository`](https://github.com/trinityrnaseq/trinityrnaseq/)
        * [`Documentation`](https://github.com/trinityrnaseq/trinityrnaseq/wiki)
    + `TrimGalore`
        * [`conda`](https://anaconda.org/bioconda/trim-galore)
        * [`Home`](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/)
        * [`Repository`](https://github.com/FelixKrueger/TrimGalore) 
        * [`Documentation`](https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md)
    + `rCorrector` Use to remove spurious k-mers
        * `#TODO` Follow up on this
    + `DETONATE` Would be used for validation
        * [`Vignette`](https://deweylab.biostat.wisc.edu/detonate/vignette.html)
    + `BUSCO` Would be used for validation
    + `FastQC` `#DECISION fastp or FastQC?`
    + `fastp` `#DECISION fastp or FastQC?` 
        * [`Repo and documentation`](https://github.com/OpenGene/fastp)
        * [`conda`](https://anaconda.org/bioconda/fastp)
    + `pasa` Would be used for mapping Trinity sequences to the reference
        * `#TODO` Follow up on this
    + `Transrate` `#MAYBE` Would be used for validation
        * [`Documentation`](http://hibberdlab.com/transrate/)
        * [`Repository`](https://github.com/blahah/transrate/)
        * [`conda`](https://anaconda.org/bioconda/transrate)
    + etc.
- Related resource: [Lessons on using Trinity from Brian Haas](https://bioinformaticsdotca.github.io/rnaseq_2018)

<a id="references-for-the-experimental-designpipeline"></a>
### References for the experimental design/pipeline
- [McIlwain et al. (Hittinger), *G3* 2016](https://academic.oup.com/g3journal/article/6/6/1757/6029942) ([notes below](#mcilwain-et-al-hittinger-g3-2016))
    + [Notes](#mcilwain-et-al-hittinger-g3-2016)
- [Blevins et al. (Mar Alba), bioRxiv 2019-0313](https://www.biorxiv.org/content/10.1101/575837v1.full)
    + [Notes](#blevins-et-al-mar-alba-biorxiv-2019-0313)
- `PASA` materials from Brian Haas
    + [Build a Comprehensive Transcriptome Database Using Genome-Guided and *De Novo* RNA-seq Assembly](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db)
        * Recommended by author/maintainer of `Trinity` to look into this (see [below](#more-thoughts-on-multimappers-2022-1109-1110))
        * [Notes](#build-a-comprehensive-transcriptome-database)
    + [Leveraging RNA-seq by the `PASA` Pipeline](https://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq)
        * Necessary to understand and leverage the [above reference](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db) recommended by Brian Haas
        * [Notes](#leveraging-rna-seq-by-the-pasa-pipeline)
    + [Running the `PASA` Alignment Assembly Pipeline](https://github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly)
        * Necessary to understand and leverage the above two references
            - [Build a Comprehensive Transcriptome Database Using Genome-Guided and *De Novo* RNA-seq Assembly](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db)
            - [Leveraging RNA-seq by the `PASA` Pipeline](https://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq)
        * [Notes](#running-the-pasa-alignment-assembly-pipeline)
    + [Introduction to `PASA`](https://github.com/PASApipeline/PASApipeline/wiki#introduction)
        * Necessary to understand and leverage the above three references
        * [Notes](#introduction-to-pasa)
- [Best Practices for *De Novo* Transcriptome Assembly with Trinity](https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html)

`#TODO For the in-progress steps below, describe what material is from what reference above`

<a id="notes-from-the-references-listed-above"></a>
### Notes from the references listed above
<a id="mcilwain-et-al-hittinger-g3-2016"></a>
#### McIlwain et al. (Hittinger), *G3* 2016
<details>
<summary><i>Click here to expand</i></summary>

[Link to paper](https://academic.oup.com/g3journal/article/6/6/1757/6029942)

<a id="from-materials-and-methods"></a>
##### From *Materials and Methods*
...

We validated the predicted protein coding genes of Y22-3 using: 1) single-end RNA-seq data collected from four growth phases of Y22-3 grown on YP media containing 60 g/L dextrose and 30 g/L xylose (YPDX, equivalent sugar concentrations that mimic ACSH made with 6% glucan loading), 2) <mark>an optimized (Figure S1) *de novo* transcriptome assembled by Trinity (Grabherr et al. 2011) using paired-end RNA-seq data</mark> from clones derived from Y22-3 that were grown aerobically or anaerobically from four to six growth phases on YPDX and ACSH, and 3) proteomic data collected similarly to previous nanoflow liquid....

<a id="from-file-s1"></a>
##### From [*File S1*](https://oup.silverchair-cdn.com/oup/backfile/Content_public/Journal/g3journal/6/6/10.1534_g3.116.029389/5/029389_files1.pdf?Expires=1670618915&Signature=4DEEu1wmL~iHD~Hpq-nTS9dJzWOHBV~jvWPaFFY-df6LV7nLBK45mN5h7MfOqxC5yDY8f8jpz9jcgsnBH6Q0a3NCotRUwvPcyQzo9VIX8fy4VSj7nibf9enwo-tyw5u4vQNtZXU4kjRgJZddXmvRE~73LEJdaFYQxBiRTNvskf5lCvmw64xLDeJPW8OGMVixRphDasc5zo~DNSQyNsbPxaZQCd4nNlNx2OMIc~RadavZBm-ZMPB81bPr4~oFeHEVr6WeLRtj0aJEVotV~PxzZYvAqleqMhLJUsuorvqVuz1sD4K~mJDcvweCBacBkAu5fgiBGAsdrTOoQ4RYmuKFNw__&Key-Pair-Id=APKAIE5G5CRDK6RD3PGA)
**<mark>*De novo*</mark> transcriptome assembly (transcriptome method):**  
¶1  
To describe transcriptional activity of Y22-3 over a wide range of conditions, nearly <mark>1.5 billion (1,433,309,474) paired-end Illumina RNA-seq reads</mark> from the JGI dataset were <mark>assembled *de novo*</mark> to yield a generalized transcriptome model (Parreiras et al. 2014).

<mark>To remove both low-quality and nucleotide composition-biased parts of the sequencing reads, the Trimmomatic software (Bolger et al. 2014) was applied to pre-process the reads with the following rules: 1) remove the first 12 bp from 5’ end, 2) remove any number of bp from 3’ end that have the average quality score < 30 in a 3-bp sliding window, and 3) keep the trimmed read if 36 or more bp are left.</mark>

¶2  
Transcriptome assembly was performed using the Trinity pipeline (Grabherr et al. 2011). The <mark>pool of reads was normalized to a target coverage of 50 using Trinity’s *in silico* normalization routine</mark>.

Transcriptome assembly with default parameters produced numerous artificial fusion transcripts. To optimize the assembly parameters for our particular case, extensive <mark>parameter scanning and optimization</mark> were performed by generating 270 *de novo* assemblies that combined <mark>10 levels of minimal k-mer coverage<mark> (Inchworm stage of the Trinity), <mark>three levels of minimal glue</mark>, <mark>three levels of minimal iso ratio</mark>, and <mark>three levels of glue factor</mark> (Chrysalis stage). Optimization of the Butterfly-stage parameters was not recommended by the Trinity developers.

¶3  
<mark>Selection of the best assembly was performed with the aid of the [DETONATE](https://deweylab.biostat.wisc.edu/detonate/) [package](https://github.com/deweylab/detonate) [(Li et al. 2014)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0553-5), using both the RSEM-EVAL and REF-EVAL pipelines</mark>.

Our preliminary applications of DETONATE to smaller-size assemblies, combined with visual assessment of the assembly quality after subsequent mapping to the genome sequence, revealed that <mark>3 out of 47 output statistics generated by the DETONATE&mdash;**Transcript Length Distribution Related Factors (when maximized)**, **Unweighted K-mer KL_A_to_M (when minimized)**, and **Unweighted_Pair_F1 (when maximized)**&mdash;are better representatives of the overall assembly quality</mark> for our transcriptome. We <mark>selected the three candidate assemblies with top scores according to each of the three statistics</mark>. <mark>The final assembly was selected by [*minimizing the sum of ranks*](#outstanding-ongoing-questions)</mark>; this assembly belonged to the top 5% of assemblies for all three ranked lists.

<mark>The following advanced Trinity parameters were used to generate the optimized transcriptome assembly: **min_kmer_cov 32 (Inchworm stage), min_glue 4, min_iso_ratio 0.01, and glue_factor 0.01 (Chrysalis stage)**.</mark>

<mark>The transcripts from the optimized transcriptome assembly were mapped onto the Y22-3 genome sequence via **the [first stage](https://github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly) of the [PASA pipeline](https://github.com/PASApipeline/PASApipeline) [(Haas et al. 2003)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC206470/)** with blat and gmap aligners and the following options: `--MAX_INTRON_LENGTH 2000` and `--transcribed_is_aligned_orient`.</mark> Alignment stringency was set to minimum of 95% identity across at least 90% of the transcript sequence.

Visual comparison of the mapping results derived from the optimized and default-parameter assemblies [(Figure S1)](https://oup.silverchair-cdn.com/oup/backfile/Content_public/Journal/g3journal/6/6/10.1534_g3.116.029389/5/029389_figures1.pdf?Expires=1670618835&Signature=EYS-mn5bLPlI~Wa3u7B8J8J-2Vm1yZ08An4f35VKyef4qyT~T1LaBSdQkKJtKbYfggQciXpi30thpgSUXdx~S3I9MHUyUBpZFr-JGC4YdMg1c-IdMqWBbczfmPdinQx9pFMrlqty9lHf1oxA5Jmc4vbAdJVoJU3AHt4kIRChviV8PyelyFsFQkIYNRIpLclSVODM180ebZ~jiIMquHHdA3fbS4z~p7lLqMCAmCdnMmp6-dJbpCt9JSz10BSztduUZSjfbOoF9sKMxhTuH2rUHEHH-ONMu3NeRg0YJcR~rcJV4Pnkaw3QY4Xx~-L3G--IzRoGTkLfkNqd7WYIUHZPJA__&Key-Pair-Id=APKAIE5G5CRDK6RD3PGA) revealed that cases of artificial both-strand coverage by predicted transcripts, which were abundant in the default assembly, were essentially eliminated in the optimized assembly, without sacrificing sensitivity (seen as coverage of the genomic features predicted at DNA level).

...
</details>

<a id="blevins-et-al-mar-alba-biorxiv-2019-0313"></a>
#### Blevins et al. (Mar Alba), bioRxiv 2019-0313
<details>
<summary><i>Click here to expand</i></summary>

[Link to paper](https://www.biorxiv.org/content/10.1101/575837v1.full); this is the study Alison referenced for the parameters [used here](#get-another-trial-run-of-trinity-going)

<a id="from-results"></a>
##### From *Results*
**Assembling novel transcripts from 11 yeast species**  
¶1  
We selected 10 species from the Saccharomycotina subphylum, including the model organism *S. cerevisiae*, as well as a more distant outgroup species (*Schizosaccharomyces pombe*), due to their evolutionary history as well as their inclusion in other relevant studies (Figure 1, Supplementary Table 1). All 11 species of yeast were grown in rich media, henceforth referred to as ‘normal’ conditions, as well as in oxidative stress conditions induced by adding hydrogen peroxide ... to the rich media, henceforth referred to as 'stress.'

¶2  
We performed high throughput RNA sequencing (RNA-seq) in normal and stress conditions for the 11 species, and <mark>[assembled *de novo* transcriptomes using Trinity (Grabherr et al. 2013)](#from-methods)</mark>. We combined the set of *de novo* assembled transcripts with the reference annotations to generate an inclusive and non-redundant set of transcripts for each species (Supplementary Figure 1). Our de novo assemblies contained an average of 770 novel (unannotated) transcripts for each species studied (Supplementary Table 2).

<a id="from-supplementary-figure-1"></a>
##### From *Supplementary Figure 1*
**Flow chart of our RNAseq analysis pipeline.**  
We began our analysis with raw RNA-seq sequencing fastq files for each of the species both conditions.

Adapters and low-quality reads were removed with `Trimmomatic`, then `FastQC` was used to do a subsequent quality assessment.

The high-quality reads were then mapped to the reference genome with `Bowtie2`.

`Trinity` was run in reference-free mode, so the assembled transcripts it produces are lacking genomic coordinates.

For this reason, we used `GMAP` to map where the assembled transcripts belong on the reference genome.

<mark>We then [used `Cuffmerge` to compare and combine the reference annotations with our *de novo* assembly](#outstanding-ongoing-questions).</mark>

Nucleotide sequences were extracted for each transcript using the tool `gffread` from the `Cufflinks` suite, and BLAST databases were created for each species using the complete transcriptome (novel transcripts & annotated
transcripts).

Each transcript was used as a query in `BLAST` searches against all `BLAST` databases (the transcriptomes of all 11 species) as well as the proteomes of 35 distant non-Ascomycota species.

`Salmon` was used to quantify the expression of each transcript in both conditions.

<a id="from-methods"></a>
##### From *Methods*
**Processing of RNA-seq data**  
We trimmed the adapters and low quality bases with Trimmomatic (Bolger et al. 2014) with the following parameters:
```txt
ILLUMINACLIP:$illumina_adapters:2:33:20:2:true \
LEADING:36 \
TRAILING:32 \
SLIDINGWINDOW:4:30 \
MINLEN:35
```
We then used Bowtie2 version 2.2.3 with default parameters (Langmead and Salzberg 2012) to map the trimmed RNA-seq reads to the reference genome. After mapping the reads, we discarded all reads with > 2 mismatches as well as unpaired reads.

**Assembly of transcriptomes**  
¶1  
We used Trinity in genome-guided BAM mode (Grabherr et al. 2013) to perform a *de novo* assembly using the following parameters:

¶2  
```txt
--normalize_max_read_cov 200 \
--jaccard_clip \
--genome_guided_max_intron 1002 \
--min_kmer_cov 2 \
--max_reads_per_graph 300000 \
--min_glue 5 \
--group_pairs_distance 300 \
--min_contig_length 200
```

¶3  
In this mode, `Trinity` works with mapped reads, but it does not use the reference genome directly to reconstruct the transcripts.

We used `Transrate` (Smith-Unna et al. 2016) to evaluate the quality of each assembly and refined the parameters of Trinity to achieve a high-quality de novo assembly.

As `Trinity` does not use the reference genome directly to assemble transfrags, we used GMAP (Wu and Watanabe 2005) to map the assembled transcripts back to the reference genome. We used Cuffmerge from the Cufflinks suite version 2.2.0 (Trapnell et al. 2012) to combine the de novo assemblies from normal and stress conditions with the reference transcriptome. When we combined novel and annotated transcripts into a comprehensive transcriptome, novel transcripts from our assembly which overlapped the reference annotations were considered redundant and were excluded from most of the analysis; however, these transcripts were still included in the BLAST database during homology searches.
</details>

<a id="build-a-comprehensive-transcriptome-database"></a>
#### Build a Comprehensive Transcriptome Database
- ...Using Genome-Guided and *De Novo* RNA-seq Assembly
- [Link to the resource](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db), which is recommended by the author/maintainer of `Trinity`, Brian Haas (see [below](#more-thoughts-on-multimappers-2022-1109-1110))

<a id="build-a-comprehensive-transcriptome-database-using-genome-guided-and-de-novo-rna-seq-assembly"></a>
##### Build a Comprehensive Transcriptome Database Using Genome-Guided and *De Novo* RNA-seq Assembly
*Copied from the link with my notes and questions interspersed (also edited for grammar, style):*

Depending on the genome and transcriptome samples under study, the genome may provide a limited view into the transcriptome. Our comprehensive transcriptome database-generating pipeline aims to:
- Capture transcripts for genes missing from the genome (difficult-to-sequence regions, novel transcripts existing in the sample, etc)
- Capture transcripts that align partially to the genome with exons falling into sequencing gaps
- Capture transcripts that cannot otherwise be represented properly according to the reference genome due to karyotype differences (e.g., genome translocations)

The transcripts are identified and included along with the `PASA` assemblies yielding a more comprehensive transcriptome database to be used for downstream investigations into expressed gene content and differential expression analyses.

Our system for building the comprehensive transcriptome database requires multiple sources of inputs:
1. [`Trinity` *de novo*](https://github.com/trinityrnaseq/trinityrnaseq/wiki) RNA-seq assemblies (e.g., `Trinity.fasta`),
2. [`Trinity` genome-guided](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly) RNA-seq assemblies (e.g., `Trinity.GG.fasta`),
3. and (optionally) [`Cufflinks`](https://github.com/cole-trapnell-lab/cufflinks) or [`StringTie`](https://ccb.jhu.edu/software/stringtie/) transcript structures (e.g., `cufflinks.gtf`).

```txt
Notes from me:

#QUESTION Cufflinks/Tophat is outdated right?

#ANSWER Yes. See, e.g., www.biostars.org/p/215220/, specifically this from Devon Ryan:
        "Regarding cufflinks, unless you need to find novel isoforms/genes then don't use it.
        If you do need novel isoforms/genes, then use stringTie rather than cufflinks."

Back to the text proper:
```

When applying `Trinity` to RNA-seq samples derived from microbial eukaryotes, using either genome-free or genome-guided *de novo* assembly, be sure to <mark>use the `--jaccard_clip` parameter to reduce the occurrence of falsely-fused genome-neighboring transcripts</mark>. Also, only include `Cufflinks` transcripts if applying the approach to expansive genomes of animals such as mouse or human, and <mark>exclude `Cufflinks` from application to compact microbial eukaryotic genomes</mark>.

After generating the inputs according to their separate procedures linked above, you can run `PASA` according to the following steps:
1. Concatenate the `Trinity.fasta` and `Trinity.GG.fasta` files into a single `transcripts.fasta` file:
```bash
#!/bin/bash
#DONTRUN

cat Trinity.fasta Trinity.GG.fasta > transcripts.fasta
```
2. Create a file containing the list of transcript accessions that correspond to the `Trinity` *de novo* assembly (full *de novo*, not genome-guided):
```bash
#!/bin/bash
#DONTRUN

${PASA_HOME}/misc_utilities/accession_extractor.pl < Trinity.fasta > tdn.accs
```
3. Run `PASA` using RNA-seq-related options as described in the section above ([`GitHub` link](https://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq), [my notes]()), but include the parameter setting `--TDN tdn.accs`. To (optionally) include `Cufflinks`-generated transcript structures, further include the parameter setting `--cufflinks_gtf cufflinks.gtf`. Note, `Cufflinks` may not be appropriate for gene-dense targets, such as in fungi; `Cufflinks` excels when applied to vertebrate genomes, so best to include when applying to mouse or human.
```txt
Note from me:

When Brias Haas writes "as described in the section above," he is referring the material at this link:
https://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq

Back to the main text:
```
4. After completing the `PASA` alignment assembly, generate the comprehensive transcriptome database via:
```bash
#!/bin/bash
#DONTRUN

${PASA_HOME}/scripts/build_comprehensive_transcriptome.dbi \
    -c alignAssembly.config \
    -t transcripts.fasta \
    --min_per_ID 95 \
    --min_per_aligned 30
```
This examines the `Trinity` *de novo* assemblies (specified by the `--TDN` parameter in the `PASA` run). The following groupings are performed:  
- Those TDN accessions mapping at above the `--min_per_ID` and `--min_per_aligned` values but otherwise failing the stringent alignment validation requirements (splice sites, contiguity, etc) are assigned to PASA assembly clusters (genes) based on exon overlap
- Those not mapping to `PASA` assemblies retain their gene identifier assigned as the Trinity component
- Likewise, those TDN entries that map poorly to the genome (below `--min_per_id` and `--min_per_aligned` criteria) or do not map to the genome at all are assigned gene identifiers based on the `Trinity` component identifier
- `PASA` assemblies and those TDN entries that were not included in `PASA` assemblies (not mapping or invalid alignments) are reported as a single data set

The resulting data files should include:
```txt
compreh_init_build/compreh_init_build.fasta                the transcript sequences
compreh_init_build/compreh_init_build.geneToTrans_mapping  the gene/transcript mapping file
                                                           (for use with RSEM, Trinotate,
                                                           other tools)
compreh_init_build/compreh_init_build.bed                  transcript structures in bed
                                                           format
compreh_init_build/compreh_init_build.gff3                 transcript structures in gff3
                                                           format
compreh_init_build/compreh_init_build.details              classifications of transcripts
                                                           according to genome mapping status
```
The classifications include:
```txt
pasa                                 PASA alignment assembly
InvalidQualityAlignment_YES_PASAmap  invalid alignment that maps at percent identity and
                                     alignment length requirement, and overlaps a PASA exon
InvalidQualityAlignment_NO_PASAmap   same as above, but doesn't map to a PASA exon
PoorAlignment_TreatUnmapped          invalid alignment that does not meet percent identity
                                     and length requirements (potentially missing from
                                     genome)
TDN_noMap                            no alignment to the genome reported (missing from the
                                     genome)
```

<a id="leveraging-rna-seq-by-the-pasa-pipeline"></a>
#### Leveraging RNA-seq by the `PASA` Pipeline
[Link to the resource](https://github.com/PASApipeline/PASApipeline/wiki/PASA_RNAseq), which is needed to understand and on the [above material](#build-a-comprehensive-transcriptome-database)

<a id="leveraging-rna-seq-by-the-pasa-pipeline-1"></a>
##### Leveraging RNA-seq by the `PASA` Pipeline
*Copied from the link with my notes and questions interspersed (also edited for grammar, style):*

Illumina RNA-seq is quickly revolutionizing gene discovery and gene structure annotation in eukaryotes. Recent enhancements to the `PASA` pipeline, including advancements in RNA-seq *de novo* assembly, now enable it to make use of these data for gene structure annotation. It is now relatively straightforward to generate strand-specific RNA-seq data via Illumina. Given the great utility of strand-specific data in differentiating between sense and antisense transcription, plus given the great depth of transcriptome sequencing coverage and the great prevalence of antisense transcription, strand-specific RNA-seq data is highly preferred by the `PASA` pipeline. `PASA` can still be used quite effectively in the case of non-strand-specific RNA-seq, but the execution is quite different (see below). The dUTP strand-specific RNA-seq method by [Parkhomchuk et al., *NAR* 2009](http://www.ncbi.nlm.nih.gov/pubmed/19620212) is recommended. You can buy an off-the-shelf kit for doing stranded RNA-seq from Illumina such as the TruSeq stranded mRNA kit. For a comparison of strand-specific methods, see [Levin et al., *Nat Methods* 2010](https://pubmed.ncbi.nlm.nih.gov/20711195/).

The procedure for leveraging RNA-seq in the `PASA` pipeline is very straightforward. First, assemble the RNA-seq data using our new `Trinity` *de novo* RNA-seq assembly software. The RNA-seq assembly process can be performed in either a genome-guided (recommended) or genome-free way. Documentation for `Trinity` RNA-seq assembly (genome-guided or genome-free) is provided at http://trinityrnaseq.github.io. Instructions for assembly of strand-specific and non-strand-specific RNA-seq are provided.

<a id="strand-specific-rna-seq"></a>
###### Strand-specific RNA-seq
In the case of strand-specific RNA-seq, run `PASA` with the `Trinity` transcript assemblies as input, including the `--transcribed_is_aligned_orient` parameter, to indicate that the `Trinity` transcripts were directionally assembled:
```bash
#!/bin/bash
#DONTRUN

${PASAHOME}/Launch_PASA_pipeline.pl \
    -c alignAssembly.config \
    -C \
    -R -g genome_sample.fasta \
    --ALIGNERS blat,gmap \
    -t Trinity.fasta \
    --transcribed_is_aligned_orient
```

The above will cluster and assemble alignments with minimal overlap. If your gene density is high and you expect transcripts from neighboring genes to often overlap in their UTR regions, you can perform more stringent clustering of alignments like so:
```bash
#!/bin/bash
#DONTRUN

${PASAHOME}/Launch_PASA_pipeline.pl \
    -c alignAssembly.config \
    -C -R \
    -g genome_sample.fasta \
    --ALIGNERS blat,gmap \
    -t Trinity.fasta \
    --transcribed_is_aligned_orient \
    --stringent_alignment_overlap 30.0 
```

Also, as an alternative, if you have existing gene structure annotations that are reasonably accurate, you can cluster Trinity assemblies by locus (annotation-informed clustering) and further augment full-length transcript reconstruction from overlapping inchworm assemblies like so, with the alternative run command:
```bash
#!/bin/bash
#DONTRUN

${PASAHOME}/Launch_PASA_pipeline.pl \
    -c alignAssembly.config \
    -C -R \
    -g genome_sample.fasta \
    --ALIGNERS blat,gmap \
    -t Trinity.fasta \
    --transcribed_is_aligned_orient \
    -L --annots_gff3 coding_gene_annotations.gff3 \
    --gene_overlap 50.0
```

<a id="non-strand-specific-rna-seq"></a>
###### Non-Strand-specific RNA-seq
In the case of non-strand-specific RNA-seq, simply exclude the `--transcribed_is_aligned_orient` parameter and run like so:
```bash
#!/bin/bash
#DONTRUN

$PASAHOME/Launch_PASA_pipeline.pl \
    -c alignAssembly.config \
    -C -R \
    -g genome_sample.fasta \
    -t Trinity.fasta \
    --ALIGNERS blat,gmap
```

<a id="running-the-pasa-alignment-assembly-pipeline"></a>
#### Running the `PASA` Alignment Assembly Pipeline
[Link to the resource](https://github.com/PASApipeline/PASApipeline/wiki/PASA_alignment_assembly)

<a id="running-the-alignment-assembly-pipeline"></a>
##### Running the Alignment Assembly Pipeline
*Copied from the link with my notes and questions interspersed (also edited for grammar, style):*

As input to the command-line driven `PASA` pipeline, we need only two (potentially three) input files:
- The genome sequence in a multiFasta file (i.e., `genome.fasta`)
- The transcript sequences in a multiFasta file (ie. transcripts.fasta)
- Optional: a file containing the list of accessions corresponding to full-length cDNAs (ie. FL_accs.txt)

<a id="step-a-cleaning-the-transcript-sequences-optional"></a>
###### Step A: Cleaning the transcript sequences (optional)
Have each of these files in the same 'working' directory. Then, run the `seqclean` utility on you transcripts like so:
```bash
#!/bin/bash
#DONTRUN

${PASAHOME}/bin/seqclean transcripts.fasta
```
If you have a database of vector sequences (i.e., `UniVec`), you can screen for vector as part of the cleaning process by running the following instead:
```bash
#!/bin/bash
#DONTRUN

${PASAHOME}/bin/seqclean transcripts.fasta -v /path/to/your/vectors.fasta
```
This will generate several output files including `transcripts.fasta.cln` and `transcripts.fasta.clean`. Both of these can be used as inputs to `PASA`.

<a id="step-b-walking-thru-a-complete-example-using-the-provided-sample-data"></a>
###### Step B: Walking Thru A Complete Example Using the Provided Sample Data
Sample inputs are provided in the `${PASAHOME}/sample_data` directory. We'll use these inputs to demonstrate the breadth of the software application, including using sample DATA ADAPTERs to import existing gene annotations into the database, and tentative structural updates out.

The `PASA` pipeline requires separate configuration files for the alignment assembly and later annotation comparison steps, and these are configured separately for each run of the `PASA` pipeline, setting parameters to be used by the various tools and processes executed within the `PASA` pipeline. Configuration file templates are provided as `${PASAHOME}/pasa_conf/pasa.alignAssembly.Template.txt` and `${PASAHOME}/pasa_conf/pasa.annotationCompare.Template.txt`, and these will be further described when used below.

The next steps explain the current contents of the sample_data directory. You do NOT need to redo these operations:
- I've copied the `${PASAHOME}/pasa_conf/pasa.alignAssembly.Template.txt` to `alignAssembly.config` and edited the `PASA` database name to `/tmp/sample_mydb_pasa`
    + Note, if you set the database name to a fully qualified path (i.e., `/path/to/my/database.sqlite`), it will use SQLite for the relational database type
    + If you simply specify a database name (i.e., `my_pasa_db`), it will default to using MySQL
- My required input files exist as: `genome_sample.fasta`, `all_transcripts.fasta`, and since I have some full-length cDNAs, I'm including `FL_accs.txt` to identify these as such
- I already ran `seqclean` to generate files: `all_transcripts.fasta.clean` and `all_transcripts.fasta.cln`

The following steps, you must execute in order to demonstrate the software. (The impatient can execute the entire pipeline below by running `./run_sample_pipeline.pl`. If this is your first time through, it helps to walk through the steps below instead.)

**Transcript alignments followed by alignment assembly**  
Run the PASA alignment assembly pipeline like so:
```bash
#!/bin/bash
#DONTRUN

${PASAHOME}/Launch_PASA_pipeline.pl \
    -c alignAssembly.config \
    -C \
    -R \
    -g genome_sample.fasta \
    -t all_transcripts.fasta.clean \
    -T \
    -u all_transcripts.fasta \
    -f FL_accs.txt \
    --ALIGNERS blat,gmap,minimap2 \
    --CPU 2
```

The `--ALIGNERS` can take values `gmap`, `blat`, `minimap2`, or some combination (i.e., `gmap,blat`), in which case both aligners will be executed in parallel. The CPU setting determines the number of threads to be split among each process. This is passed on to `GMAP` to indicate the thread count. In the case of `BLAT`, the new `pblat` utility is used for parallel processing.

This executes the following operations, generating the corresponding output files:
- aligns the `all_transcripts.fasta` file to `genome_sample.fasta` using the specified alignment tools; files generated include...
    + `sample_mydb_pasa.validated_transcripts.gff3`, `.gtf`, `.bed`: the valid alignments
    + `sample_mydb_pasa.failed_gmap_alignments.gff3`, `.gtf`, `.bed`: the alignments that fail validation test
    + `alignment.validations.output`: tab-delimited format describing the alignment validation results
- The valid alignments are clustered into piles based on genome alignment position, and piles are assembled using the `PASA` alignment assembler; files generated include...
    + `sample_mydb_pasa.assemblies.fasta`: the PASA assemblies in FASTA format
    + `sample_mydb_pasa.pasa_assemblies.gff3`, `.gtf`, `.bed`: the PASA assembly structures
    + `sample_mydb_pasa.pasa_alignment_assembly_building.ascii_illustrations.out`: descriptions of alignment assemblies and how they were constructed from the underlying transcript alignments
    + `sample_mydb_pasa.pasa_assemblies_described.txt`: tab-delimited format describing the contents of the PASA assemblies, including the identity of those transcripts that were assembled into the corresponding structure

<a id="introduction-to-pasa"></a>
#### Introduction to `PASA`
[Link to the resource](https://github.com/PASApipeline/PASApipeline/wiki#introduction)

*Copied from the link with my notes and questions interspersed (also edited for grammar, style):*  
¶1  
...

¶2  
Functions of `PASA` include:
...

¶3  
`PASA` is composed of a pipeline of utilities that perform the following ordered set of tasks:
- Clean the transcripts
    + The `seqclean` utility, developed by the TIGR Gene Index group, is used to identify evidence of polyadenylation and strip the poly-A, trim vector, and discard low quality sequences
- Map and align transcripts to the genome
    + `GMAP` and/or `BLAT` is used to map and align the transcripts to the genome
- Validate nearly perfect alignments
    + `PASA` utilizes only near perfect alignments. These alignments are required to align with a specified percent identity (typically 95%) along a specified percent of the transcript length (typically 90%)
    + Each alignment is required to have consensus splice sites at all inferred intron boundaries, including (GT/GC donor with an AG acceptor, or the AT-AC U12-type dinucleotide pairs)
- Maximal assembly of spliced alignments
    + The valid transcript alignments are clustered based on genome mapping location and assembled into gene structures that include the maximal number of compatible transcript alignments
    + Compatible alignments are those that have identical gene structures in their region of overlap
    + The products are termed `PASA` maximal alignment assemblies
    + Those assemblies that contain at least one full-length cDNA are termed FL-assemblies; the rest are non-FL-assembles
- Grouping alternatively spliced isoforms
    + Alignment assemblies that map to the same genomic locus, significantly overlap, and are transcribed on the same strand, are grouped into clusters of assemblies
- Automatic Genome Annotation
    + Given a set of existing gene structure annotations, which may include the latest annotation for a given genome or the results of a single ab-initio gene finder, a comparison to the `PASA` alignment assemblies is performed
        * Each alignment assembly is assigned a status identifier based on the results of the annotation comparison
        * The status identifier indicates whether or not the update is sanctioned as likely to improve the annotation, and the type of update that the assembly provides
        * There are over 40 different status identifiers (actually, about 20 since half correspond to FL-assemblies and the other half to non-FL-assemblies)
    + In the absence of any preexisting gene annotations, novel genes and alternative splicing isoforms of novel genes can be modeled
    + At any time, regardless of any existing annotations, users can obtain candidate gene structures based on the longest open reading frame (ORF) found within each `PASA` alignment assembly
        * The output includes a `.fasta` file for the proteins and a `.gff3` file describing the gene structures
        * This is useful when applied to a previously uncharacterized genome sequence, allowing one to rapidly obtaining a set of candidate gene structures for training various *ab-intio* gene prediction programs
        * In the case of RNA-seq, `PASA` can generate a full transcriptome-based genome annotation, identifying likely coding and non-coding transcripts

<a id="pasa-in-the-context-of-a-complete-eukaryotic-annotation-pipeline"></a>
##### `PASA` in the Context of a Complete Eukaryotic Annotation Pipeline
[Link to the resource](https://github.com/PASApipeline/PASApipeline/wiki#pasa-in-the-context-of-a-complete-eukaryotic-annotation-pipeline)

...
<br />
<br />

<a id="sussing-out-the-alignment-work-for-the-pipeline"></a>
## Sussing out the alignment work for the pipeline
<a id="on-calling-bowtie-2"></a>
### On calling `Bowtie 2`
Section ties into the section immediately [above](#outstanding-ongoing-questions-points-etc) and [below](#in-progress-steps-of-the-pipeline)
```bash
#!/bin/bash
#DONTRUN

bowtie2 \
    -p "${threads}" \
    -x "${reference_genome}" \
    -1 "${infiles[0]}" \
    -2 "${infiles[1]}" \
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
        | samtools sort -@ "${threads}" -o "${infiles[0]%_R1.fastq}_sorted.bam" -
```

<a id="meaning-of-bowtie-2-parameters"></a>
#### Meaning of `Bowtie 2` parameters
```txt
-p: threads
-x: Bowtie2 indices, including path and root
-1: Read #1 of paired-end reads
-2: Read #2 of paired-end reads
--trim5: trim <int> bases from 5'/left end of reads
--local: local alignment; ends might be soft clipped (off)
--very-sensitive-local: -D 20 -R 3 -N 0 -L 20 -i S,1,0.50
    -D: give up extending after <int> failed extends in a row (15)
    -R: for reads w/ repetitive seeds, try <int> sets of seeds (2)
    -N: max # mismatches in seed alignment; can be 0 or 1 (0)
    -L: length of seed substrings; must be >3, <32 (22)
    -i: interval between seed substrings w/r/t read len (S,1,1.15)
--no-unal: suppress SAM records for unaligned reads
--no-mixed: suppress unpaired alignments for paired reads
--no-discordant: suppress discordant alignments for paired reads
    From biostars.org/p/78446/, a discordant alignment is an alignment where
    both mates align uniquely, but that does not satisfy the paired-end
    constraints (--fr/--rf/--ff, -I, -X).
--phred33: qualities are Phred+33 (default)
-I: minimum fragment length (0)
-X: maximum fragment length (500)
--no-overlap: not concordant when mates overlap at all
--no-dovetail: NA

Based on the description for --dovetail, "concordant when mates extend past
each other", I presume --no-dovetail means "not concordant when mates extend
past each other"

#QUESTION Why do we do '--trim5 1'?
    #QUESTION What is the length of our reads? Is it something to do with that?
```

When calling `Bowtie2` for [in-progress pipeline **step 3**](#in-progress-steps-of-the-pipeline)), we'll want to ~~remove the pipe to `samtools` and~~ take advantage of these flags for directing the alignments, or lack thereof, to specific files
```txt
  --un <path>        write unpaired reads that didn't align to <path>
  --al <path>        write unpaired reads that aligned at least once to <path>
  --un-conc <path>   write pairs that didn't align concordantly to <path>
  --al-conc <path>   write pairs that aligned concordantly at least once to <path>
    (Note: for --un, --al, --un-conc, or --al-conc, add '-gz' to the option name, e.g.
    --un-gz <path>, to gzip compress output, or add '-bz2' to bzip2 compress output.)
```

<a id="how-we-should-call-bowtie-2"></a>
#### How we should call `Bowtie 2`
Thus, we'll want to call `Bowtie 2` like this (also incorporates thoughts from sub-bullets for [**Step 3** below](#in-progress-steps-of-the-pipeline)):
```bash
#!/bin/bash
#DONTRUN

bowtie2 \
    -p "${threads}" \
    -x "${reference_genome}" \
    -1 "${infiles[0]}" \
    -2 "${infiles[1]}" \
    --local \
    --very-sensitive-local \
    --phred33 \
    -I 10 \
    -X 700 \
    --un-conc-gz "${infiles[0]%_R1.fastq}.unaligned" \
    --al-conc-gz "${infiles[0]%_R1.fastq}.aligned"
        | samtools sort -@ "${threads}" -o "${infiles[0]%_R1.fastq}_sorted.bam" -

#  Bowtie2 will append .1.fastq.gz and .2.fastq.gz to
#+ "${infiles[0]%_R1.fastq}.unaligned"
````

<a id="on-calling-star"></a>
### On calling `STAR`
- Section ties into the section immediately [above](#outstanding-ongoing-questions-points-etc) and [below](#in-progress-steps-of-the-pipeline)
- Performing `STAR` "genome generation" (i.e., creating an indexed genome file with annotations) is based on the parameters described [here (example call)](https://groups.google.com/g/rna-star/c/TPTdAL7NNZ4), [here (on `--genomeSAindexNbases`)](https://groups.google.com/g/rna-star/c/08UtIdEFFmY/m/gU1eif_1KdwJ), and [here (on `--sjdbGTFfeatureExon CDS`)](https://groups.google.com/g/rna-star/c/IOJuxxONrKs/m/a0jV0kkCAQAJ)
- An [important consideration](https://groups.google.com/g/rna-star/c/08UtIdEFFmY/m/gU1eif_1KdwJ) for building the yeast genome index with `STAR`
- Performing `STAR` alignment with *S. cerevisiae* data is based on the parameters described [here in the rna-star Google group](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c)

<a id="building-a-star-genome-index"></a>
#### Building a `STAR` genome index
```bash
#!/bin/bash
#DONTRUN

STAR \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --runMode genomeGenerate \
    --genomeDir "${genomeDir}" \
    --genomeFastaFiles "${genomeFastaFiles}" \
    --sjdbGTFfile "${sjdbGTFfile}" \
    --sjdbOverhang ${sjdbOverhang} \
    --sjdbGTFtagExonParentTranscript Parent \
    --genomeSAindexNbases "${genomeSAindexNbases}"

#  'exon' not found in gff3 for yeast, but 'CDS' is, so use that for
#+ --sjdbGTFfeatureExon

#  Wait, this is not true--see plenty of examples of 'exon' in the .gff3.gz
#+ files; thus, remove --sjdbGTFfeatureExon CDS from the call
```

<a id="meaning-of-star-parameters-for-genomegenerate"></a>
#### Meaning of `STAR` parameters for `genomeGenerate`
Meaning of the parameters for `STAR --runMode genomeGenerate`:
```txt
                    --runThreadN  number of threads to be used for genome generation
                     --genomeDir  path to the directory where the genome indices are stored;
                                  must be mkdir'd already
              --genomeFastaFiles  one or more FASTA files with the genome reference sequences
                   --sjdbGTFfile  path to the file with annotated transcripts in the standard
                                  .gtf format; STAR can be run without annotations, but using
                                  annotations is highly recommended whenever they are
                                  available; the annotations can also be included on the fly
                                  at the mapping step (that is, instead of including them
                                  now, they can be included in the mapping step); for .gff3
                                  formatted annotations, use
                                  '--sjdbGTFtagExonParentTranscript Parent'
                  --sjdbOverhang  length of genomic sequence around the annotated junction to
                                  be used in constructing the splice junctions database; this
                                  length should be equal to the ReadLength-1, where
                                  ReadLength is the length of the reads; in case of reads of
                                  varying length, the value should be max(ReadLength)-1
            --sjdbGTFfeatureExon  (see below)
--sjdbGTFtagExonParentTranscript  use when a .gff3 formatted annotation is supplied to 
                                  --sjdbGTFfile; in general, for --sjdbGTFfile files STAR
                                  only processes lines that have --sjdbGTFfeatureExon (=exon
                                  by default) in the 3rd field (column); exons are assigned
                                  to the transcripts using parent-child relationship defined
                                  by the --sjdbGTFtagExonParentTranscript (=transcript id by
                                  default) .gtf/.gff attribute
           --genomeSAindexNbases  for small genomes, the parameter --genomeSAindexNbases must
                                  be scaled down, with a typical value of
                                  min(14, log2(GenomeLength)/2 - 1); for example, for a 1 Mb
                                  genome, this is equal to 9; for a 100 kb genome, this is
                                  equal to 7; for yeast, this is ~12
```

<a id="how-we-should-call-star"></a>
#### How we should call `STAR`
```bash
#!/bin/bash
#DONTRUN

STAR \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMunmapped Within \
    --genomeDir "${genomeDir}" \
    --readFilesIn "${infiles[0]}" "${infiles[1]}" \
    --outFileNamePrefix "${infiles[0]%_R1.fastq}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000 \
    --outSAMtype BAM SortedByCoordinate

#  Don't need...
#+     - '--readFilesCommand zcat' b/c .fastq files are unzipped 
#+     - '--quantMode TranscriptomeSAM \' b/c only care about what does and
#+       does not align
#+     - '--outTmpDir' b/c we can just use the default settings
#+     - '--outSAMattributes' b/c the default is fine

#  Changes...
#+     - Change '--alignIntronMin' from '0' to '4' per this note from Dobin:
#+       "I would use at least 4 for --alignIntronMin , I do not think the very
#+       small introns in the annotations are real"
#+         - https://groups.google.com/g/rna-star/c/hQeHTBbkc0c?pli=1
#+         - https://groups.google.com/d/msg/rna-star/LqxVCE34464/GBordrd6AQAJ
#+     - More from Dobin: "I would increase --alignMatesGapMax to at least
#+       --alignIntronMin since the gap between mates may contain a splice
#+       junction."
#+         - Marco increased --alignMatesGapMax from '2000' to '5000'

#  Miscellaneous notes
#+     - If we used default settings for --alignIntronMax, the value would be
#+       589824 (see 'Meaning of parameters...' below); leave as is (set by
#+       Marco)
#+     - Can maybe leave '--outSAMattrIHstart 0' as is; default is '1'? '1' is
#+       needed for use with some downstream applications, including StringTie
#+       and Cufflinks; however, that doesn't matter for my situation, so just
#+       delete it and go with defaults for now
```

<a id="meaning-of-star-parameters-for-alignreads"></a>
##### Meaning of `STAR` parameters for `alignReads`
```txt
           --runThreadN  number of threads to run STAR
                         < format: int>0 >

       --outSAMunmapped  output of unmapped reads in the SAM format
                             1st word:
                                 None   ... no output
                                 Within ... output unmapped reads within the main SAM file
                                            (i.e., Aligned.out.sam)
                             2nd word:
                                 KeepPairs ... record unmapped mate for each alignment, and,
                                               in case of unsorted output, keep it adjacent
                                               to its mapped mate; only affects multi-mapping
                                               reads
                         < string(s) >

            --genomeDir  path to the directory where genome files are stored (for --runMode
                         alignReads) or will be generated (for --runMode generateGenome)
                         < format: ./GenomeDir/ >

          --readFilesIn  paths to files that contain input read1 (and, if needed, read2)
                         < format: string(s); format: Read1 Read2 >

    --outFileNamePrefix  output files name prefix (including full or relative path)
                         < format: string; format: ./ >

     --readFilesCommand  command line to execute for each of the input file; this command
                         should generate FASTA or FASTQ text and send it to stdout; for
                         example, 'zcat' to uncompress .gz files, 'bzcat' to uncompress .bz2
                         files, etc.
                         < string(s) >

            --quantMode  types of quantification requested
                             -                ... none
                             TranscriptomeSAM ... output SAM/BAM alignments to transcriptome
                                                  into a separate file
                             GeneCounts       ... count reads per gene
                         < string(s) >

      --limitBAMsortRAM  maximum available RAM (bytes) for sorting BAM; if =0, it will be set
                         to the genome index size; 0 value can only be used with --genomeLoad
                         NoSharedMemory option < int>=0 >

        --outFilterType  type of filtering
                             Normal  ... standard filtering using only current alignment
                             BySJout ... keep only those reads that contain junctions that
                                         passed filtering into SJ.out.tab
                         < format: string; default: Normal >

--outFilterMultimapNmax  maximum number of loci the read is allowed to map to; alignments
                         (all of them) will be output only if the read maps to no more loci
                         than this value; otherwise no alignments will be output, and the
                         read will be counted as "mapped to too many loci" in the
                         Log.final.out
                         < format: int; default: 10 >

   --alignSJoverhangMin  minimum overhang (i.alignIntronMine. block size) for spliced alignments
                         < format: int>0; default: 5 >

 --alignSJDBoverhangMin  minimum overhang (i.e. block size) for annotated (sjdb) spliced
                         alignments
                         < format: int>0; default: 3 >

--outFilterMismatchNmax  alignment will be output only if it has no more mismatches than this
                         value
                         < format: int; default: 10 >

       --alignIntronMin  minimum intron size: genomic gap is considered intron if its
                         length>=alignIntronMin, otherwise it is considered Deletion
                         < default: 21 >

       --alignIntronMax  maximum intron size, if 0, max intron size will be determined by
                         (2^winBinNbits)*winAnchorDistNbins
                         < default: 0 >

          --winBinNbits  =log2(winBin), where winBin is the size of the bin for the
                         windows/clustering, each window will occupy an integer number of
                         bins
                         < int>0; default: 16 >

   --winAnchorDistNbins  max number of bins between two anchors that allows aggregation of
                         anchors into one window
                         < int>0; default: 9 >

     --alignMatesGapMax  maximum gap between two mates, if 0, max intron gap will be
                         determined by (2^winBinNbits)*winAnchorDistNbins
                         < default: 0 >

            --outTmpDir  path to a directory that will be used as temporary by STAR; all
                         contents of this directory will be removed; the temp directory will
                         default to outFileNamePrefix_STARtmp
                         < format: string >

    --outSAMattrIHstart  start value for the IH attribute; 0 may be required by some
                         downstream software, such as Cufflinks or StringTie
                         < int>=0; default: 1 >

     --outSAMattributes  a string of desired SAM attributes, in the order desired for the
                         output SAM; tags can be listed in any combination/order
                         < format: string; default: Standard >

           --outSAMtype  type of SAM/BAM output
                             1st word:
                                 BAM  ... output BAM without sorting
                                 SAM  ... output SAM without sorting
                                 None ... no SAM/BAM output
                             2nd, 3rd:
                                 Unsorted           ... standard unsorted
                                 SortedByCoordinate ... sorted by coordinate; this option
                                                        will allocate extra memory for
                                                        sorting which can be specified by
                                                        --limitBAMsortRAM
                         < format: strings; default: SAM >
```

<a id="rationale-behind-parameters-based-on-pertinent-rna-star-google-group-conversation"></a>
##### Rationale behind parameters based on [pertinent 'rna-star' Google group conversation](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c)
<details>
<summary><i>Click here to expand</i></summary>

<a id="post-1-marco-2016-0502"></a>
###### [Post #1, Marco, 2016-0502](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c/m/o7jPGuYfBQAJ)
```txt
Hi,

which is the set of parameters to use for mapping RNA-seq data of S cerevisiae?

Thanks,
Marco
```

<a id="post-2-alex-2016-0503"></a>
###### [Post #2, Alex, 2016-0503](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c/m/2tgQSP9vBQAJ)
```txt
Hi Marco,

this is what I would recommend for the first run:

at the genome generation stage:
--genomeSAindexNbases 10
at the mappings stage:
--alignIntronMin   <minimum expected intron size> --alignIntronMax <maximum expected intron size>

You can estimate expected intron size distribution from the annotated junctions. I would increase the range compared to the annotations to allow for detection of short and long novel introns.

Cheers
Alex
```

<a id="post-3-marco-2016-0504"></a>
###### [Post #3, Marco, 2016-0504](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c/m/2tgQSP9vBQAJ)
```txt
Hi Alex,

Thanks for your reply. This is the first time I do this kind of analysis, so I will be pedantic to be sure that I'm implementing it correctly.
I ask you to check the next lines and tell me if they look reasonable to you.

At the genome generation stage, I use the command:

STAR --runMode genomeGenerate --runThreadN 8 --genomeDir . --genomeFastaFiles Saccharomyces_cerevisiae.R64-1-1.dna.chromosome.fa --sjdbGTFfile Saccharomyces_cerevisiae.R64-1-1.81.gtf --outFileNamePrefix Saccharomyces_cerevisiae.R64-1-1.81.list_of_transcripts --genomeSAindexNbases 10



which should implement your suggestion.

To set the mapping stage, I estimate the expected intron size distribution looking at the file sjdbList.out.tab. 
I Run the commands:


cat sjdbList.out.tab | awk '{print sqrt(($2-$3)*($2-$3))}' | sort -k 1n | head -1

0

cat sjdbList.out.tab | awk '{print sqrt(($2-$3)*($2-$3))}' | sort -k 1n | tail -1

2482


So my first guess for the command --alignIntronMin   <minimum expected intron size> --alignIntronMax <maximum expected intron size>
is
--alignIntronMin 0 --alignIntronMax 5000

because the average gene size in S cerevisiae is about 1000 (estimated looking at the average region spanned by the loci annotated in the
.gtf file).

STAR --runThreadN 12 --outSAMunmapped Within --genomeDir . --readFilesIn XXXread1XXX XXXread2XXX --outFileNamePrefix XXXoutputXXX --readFilesCommand zcat --quantMode TranscriptomeSAM --limitBAMsortRAM 4000000000 --outFilterType BySJout --outFilterMultimapNmax 1 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --alignIntronMin 0 --alignIntronMax 5000 --alignMatesGapMax 2000 --outTmpDir $TMPDIR/STAR_ --outSAMattrIHstart 0 --outSAMattributes NH HI NM MD AS nM --outSAMtype BAM Unsorted SortedByCoordinate 


I left the rest of the parameters to be the default ones

I'm analysing 42 samples. The results are summarised in the attached file. I provide the average (Min = Max =) per field.



Thanks a lot,
Marco
```

<a id="post-4-marco-2016-0504"></a>
###### [Post #4, Marco, 2016-0504](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c/m/21okPLXQBQAJ)
```txt
Hi Marco,

your parameters look reasonable.
I would use at least 4 for --alignIntronMin , I do not think the very small introns in the annotations are real https://groups.google.com/d/msg/rna-star/LqxVCE34464/GBordrd6AQAJ.
I would increase --alignMatesGapMax to at least --alignIntronMin since the gap between mates may contain a splice junction.

The mapping stats look good on average. 68% of unique mappers for the worst sample is on the low inside, and same for the 92 bases mapped out of 98.
Since you used --outFilterMultimapNmax 1, all multi-mappers map "too many times", so you have high % of reads mapped to too many loci 

Cheers
Alex
```

<a id="post-5-marco-2016-0504"></a>
###### [Post #5, Marco, 2016-0504](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c/m/qc0r-9vWBQAJ)
```txt
Hi Alex,

I run the analysis, following your suggestions:

--alignIntronMin               10
--alignMatesGapMax  5000

obtaining very similar results wrt to the previous analysis (see attached file).
The case in which are found only 68% of uniquely mapped reads is still there, but it is the only case below 75%.

I'm already happy with these parameters. 
Just for curiosity, a part from increasing --outFilterMultimapNmax 1, are there other parameters that I could tune to try to increase this percentage?
(Log.final.out file in attachment)


Thanks,
Marco
```

Additional comments omitted.
</details>

<a id="implementing-the-alignment-steps-with-star-and-bowtie-2"></a>
### Implementing the alignment steps with `STAR` and `Bowtie 2`
<a id="generating-files-needed-for-star-alignment-2022-1107"></a>
#### Generating files needed for `STAR` alignment (2022-1107)
...to the combined reference genes (*S. cerevisiae*, *K. lactis*, and S20)

<a id="preparing-the-fasta-and-gff3-files-for-star"></a>
##### Preparing the `.fasta` and `.gff3` files for `STAR`
<details>
<summary><i>Click here to expand</i></summary>

```bash
#!/bin/bash
#DONTRUN

#  grabnode can be "on" or "off"


#  Download .gff3 files for sacCer3 (Ensembl 108) -----------------------------
cd ~/genomes/sacCer3/Ensembl/108
mkdir -p gff3 && cd gff3/

URL="https://ftp.ensembl.org/pub/release-108/gff3/saccharomyces_cerevisiae"

curl \
    "${URL}/CHECKSUMS" \
    > "CHECKSUMS"

curl \
    "${URL}/README" \
    > "README"

curl \
    "${URL}/Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gff3.gz" \
    > "Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gff3.gz"

curl \
    "${URL}/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz" \
    > "Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz"

#NOTE No "abinitio" gene predictions for K. lactis 


#  Are chromosome names consistent between sacCer3 .gff3 and .fasta? ----------
#  Check the file contents: How are chromosomes named?
zcat Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz | head -23
# ##gff-version 3
# ##sequence-region   I 1 230218
# ##sequence-region   II 1 813184
# ##sequence-region   III 1 316620
# ##sequence-region   IV 1 1531933
# ##sequence-region   IX 1 439888
# ##sequence-region   Mito 1 85779
# ##sequence-region   V 1 576874
# ##sequence-region   VI 1 270161
# ##sequence-region   VII 1 1090940
# ##sequence-region   VIII 1 562643
# ##sequence-region   X 1 745751
# ##sequence-region   XI 1 666816
# ##sequence-region   XII 1 1078177
# ##sequence-region   XIII 1 924431
# ##sequence-region   XIV 1 784333
# ##sequence-region   XV 1 1091291
# ##sequence-region   XVI 1 948066
# #!genome-build  R64-1-1
# #!genome-version R64-1-1
# #!genome-date 2011-09
# #!genome-build-accession GCA_000146045.2
# #!genebuild-last-updated 2018-10

#QUESTION Need to rename "Mito"? #ANSWER No (see immediately below)

cd ~/genomes/sacCer3/Ensembl/108/DNA

grep "^>" Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito


#  Check on consistency of chromosome names in K. lactis ----------------------
#+ ...looking at .fasta and .gff3.gz
cd ~/genomes/kluyveromyces_lactis_gca_000002515/Ensembl/55

zcat ./gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz \
    | head -11
# ##gff-version 3
# ##sequence-region   A 1 1062590
# ##sequence-region   B 1 1320834
# ##sequence-region   C 1 1753957
# ##sequence-region   D 1 1715506
# ##sequence-region   E 1 2234072
# ##sequence-region   F 1 2602197
# #!genome-build Genolevures Consortium ASM251v1
# #!genome-version ASM251v1
# #!genome-build-accession GCA_000002515.1
# #!genebuild-last-updated 2015-02

grep \
    "^>" \
    ./DNA/Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.chr-rename.fasta
# >A
# >B
# >C
# >D
# >E
# >F

#NOTE #IMPORTANT For both genomes, chromosome names are consistent


#  Merge the two .gff3 files --------------------------------------------------
grabnode  # Lowest and/or default settings

cd ~/genomes/

#  Use AGAT (Another Gff Analysis Toolkit):
#+ biostars.org/p/413510/
ml AGAT/0.9.2-GCC-11.2.0  # Nice, a module is available

#  This seems like the script to use: agat_sp_merge_annotations.pl
agat_sp_merge_annotations.pl
#
#  ------------------------------------------------------------------------------
# |   Another GFF Analysis Toolkit (AGAT) - Version: v0.9.1                      |
# |   https://github.com/NBISweden/AGAT                                          |
# |   National Bioinformatics Infrastructure Sweden (NBIS) - www.nbis.se         |
#  ------------------------------------------------------------------------------
#
# At least 2 files are mandatory:
#  --gff file1 --gff file2
#
#
# Usage:
#         agat_sp_merge_annotations.pl --gff infile1 --gff infile2 --out outFile
#         agat_sp_merge_annotations.pl --help

agat_sp_merge_annotations.pl --help
#
#  ------------------------------------------------------------------------------
# |   Another GFF Analysis Toolkit (AGAT) - Version: v0.9.1                      |
# |   https://github.com/NBISweden/AGAT                                          |
# |   National Bioinformatics Infrastructure Sweden (NBIS) - www.nbis.se         |
#  ------------------------------------------------------------------------------
#
#
# Name:
#     agat_sp_merge_annotations.pl
#
# Description:
#     This script merge different gff annotation files in one. It uses the
#     Omniscient parser that takes care of duplicated names and fixes other
#     oddities met in those files.
#
# Usage:
#         agat_sp_merge_annotations.pl --gff infile1 --gff infile2 --out outFile
#         agat_sp_merge_annotations.pl --help
#
# Options:
#     --gff or -f
#             Input GTF/GFF file(s). You can specify as much file you want
#             like so: -f file1 -f file2 -f file3
#
#     --out, --output or -o
#             Output gff3 file where the gene incriminated will be write.
#
#     --help or -h
#             Display this helpful text.
#
# Feedback:
#   Did you find a bug?:
#     Do not hesitate to report bugs to help us keep track of the bugs and
#     their resolution. Please use the GitHub issue tracking system available
#     at this address:
#
#                 https://github.com/NBISweden/AGAT/issues
#
#      Ensure that the bug was not already reported by searching under Issues.
#      If you're unable to find an (open) issue addressing the problem, open a new one.
#      Try as much as possible to include in the issue when relevant:
#      - a clear description,
#      - as much relevant information as possible,
#      - the command used,
#      - a data sample,
#      - an explanation of the expected behaviour that is not occurring.
#
#   Do you want to contribute?:
#     You are very welcome, visit this address for the Contributing
#     guidelines:
#     https://github.com/NBISweden/AGAT/blob/master/CONTRIBUTING.md

infile_1="./sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz"
infile_2="./kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz"
outfile="./combined_SC_KL_20S/g/combined_SC_KL"

mkdir -p "$(dirname "${outfile}")"

agat_sp_merge_annotations.pl \
    -f "${infile_1}" \
    -f "${infile_2}" \
    -o "${outfile}"
#  See STDERR printed to screen below

#  Give a proper name to the outdirectory within "${outfile}"
mv "$(dirname "${outfile}")" "./combined_SC_KL_20S/gff3"
# For some reason, the sequence 'gff3' is stripped away from strings by AGAT

#  Rename and compress outfile
outfile="./combined_SC_KL_20S/gff3/combined_SC_KL"

mv "${outfile}.gff" "${outfile}.gff3"
gzip "${outfile}.gff3"

ls -1 ./combined_SC_KL_20S/gff3  # Check
# combined_SC_KL.gff3.gz


#  Are chromosome names consistent for combined_SC_KL_20S? --------------------
grep "^>" ./combined_SC_KL_20S/fasta/combined_SC_KL_20S.fasta
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito
# >A
# >B
# >C
# >D
# >E
# >F
# >20S

zcat ./combined_SC_KL_20S/gff3/combined_SC_KL.gff3.gz \
    | head -33
# ##gff-version 3
# ##sequence-region   I 1 230218
# ##sequence-region   II 1 813184
# ##sequence-region   III 1 316620
# ##sequence-region   IV 1 1531933
# ##sequence-region   IX 1 439888
# ##sequence-region   Mito 1 85779
# ##sequence-region   V 1 576874
# ##sequence-region   VI 1 270161
# ##sequence-region   VII 1 1090940
# ##sequence-region   VIII 1 562643
# ##sequence-region   X 1 745751
# ##sequence-region   XI 1 666816
# ##sequence-region   XII 1 1078177
# ##sequence-region   XIII 1 924431
# ##sequence-region   XIV 1 784333
# ##sequence-region   XV 1 1091291
# ##sequence-region   XVI 1 948066
# #!genome-build  R64-1-1
# #!genome-version R64-1-1
# #!genome-date 2011-09
# #!genome-build-accession GCA_000146045.2
# #!genebuild-last-updated 2018-10
# ##sequence-region   A 1 1062590
# ##sequence-region   B 1 1320834
# ##sequence-region   C 1 1753957
# ##sequence-region   D 1 1715506
# ##sequence-region   E 1 2234072
# ##sequence-region   F 1 2602197
# #!genome-build Genolevures Consortium ASM251v1
# #!genome-version ASM251v1
# #!genome-build-accession GCA_000002515.1
# #!genebuild-last-updated 2015-02

#NOTE #IMPORTANT Chromosome names are consistent
```
Call to [AGAT](https://www.biostars.org/p/413510/) `agat_sp_merge_annotations.pl` printed the following to screen (`STDERR`):
<details>
<summary><i>Click here to expand</i></summary>

```txt
********************************************************************************
*                              - Start parsing -                               *
********************************************************************************
-------------------------- parse options and metadata --------------------------
=> Accessing the feature level json files
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level1.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level2.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level3.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_spread.json file
=> Attribute used to group features when no Parent/ID relationship exists (i.e common tag):
    * locus_tag
    * gene_id
=> merge_loci option deactivated
=> Machine information:
    This script is being run by perl v5.34.0
    Bioperl location being used: /app/software/BioPerl/1.7.8-GCCcore-11.2.0/lib/perl5/site_perl/5.34.0/Bio/
    Operating system being used: linux
=> Accessing Ontology
    No ontology accessible from the gff file header!
    We use the SOFA ontology distributed with AGAT:
        /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo
    Read ontology /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo:
        4 root terms, and 2596 total terms, and 1516 leaf terms
    Filtering ontology:
        We found 1861 terms that are sequence_feature or is_a child of it.
--------------------------------- parsing file ---------------------------------
=> Number of line in file: 35862
=> Number of comment lines: 7167
=> Fasta included: No
=> Number of features lines: 28695
=> Number of feature type (3rd column): 16
    * Level1: 6 => transposable_element_gene ncRNA_gene chromosome gene pseudogene transposable_element
    * level2: 7 => snRNA ncRNA pseudogenic_transcript tRNA mRNA rRNA snoRNA
    * level3: 3 => exon five_prime_UTR CDS
    * unknown: 0 =>
=> Version of the Bioperl GFF parser selected by AGAT: 3
Parsing: 100% [======================================================]D 0h00m03s
********************************************************************************
*                               - End parsing -                                *
*                              done in 5 seconds                               *
********************************************************************************

********************************************************************************
*                               - Start checks -                               *
********************************************************************************
---------------------------- Check1: feature types -----------------------------
----------------------------------- ontology -----------------------------------
All feature types in agreement with the Ontology.
------------------------------------- agat -------------------------------------
AGAT can deal with all the encountered feature types (3rd column)
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check2: duplicates ------------------------------
None found
------------------------------ done in 0 seconds -------------------------------

-------------------------- Check3: sequential bucket ---------------------------
None found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check4: l2 linked to l3 ----------------------------
91 cases fixed where L3 features have parent feature(s) missing
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check5: l1 linked to l2 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check6: remove orphan l1 ---------------------------
We remove only those not supposed to be orphan
91 cases removed where L1 features do not have children (while they are suposed to have children).
------------------------------ done in 0 seconds -------------------------------

------------------------- Check7: all level3 locations -------------------------
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check8: check cds -------------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check9: check exons ------------------------------
No exons created
No exons locations modified
No supernumerary exons removed
No level2 locations modified
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check10: check utrs ------------------------------
No UTRs created
No UTRs locations modified
No supernumerary UTRs removed
------------------------------ done in 1 seconds -------------------------------

------------------------ Check11: all level2 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

------------------------ Check12: all level1 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

---------------------- Check13: remove identical isoforms ----------------------
None found
------------------------------ done in 0 seconds -------------------------------
********************************************************************************
*                                - End checks -                                *
*                              done in 1 seconds                               *
********************************************************************************

=> OmniscientI total time: 6 seconds
./sacCer3/Ensembl/108/gff3/Saccharomyces_cerevisiae.R64-1-1.108.gff3.gz GFF3 file parsed
There is 7507 exon
There is 91 rna
There is 0 transposable_element_gene
There is 424 ncrna_gene
There is 6913 cds
There is 4 five_prime_utr
There is 12 pseudogenic_transcript
There is 17 chromosome
There is 6600 gene
There is 77 snorna
There is 18 ncrna
There is 24 rrna
There is 6600 mrna
There is 91 transposable_element
There is 12 pseudogene
There is 6 snrna
There is 299 trna
********************************************************************************
*                              - Start parsing -                               *
********************************************************************************
-------------------------- parse options and metadata --------------------------
=> Accessing the feature level json files
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level1.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level2.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level3.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_spread.json file
=> Attribute used to group features when no Parent/ID relationship exists (i.e common tag):
    * locus_tag
    * gene_id
=> merge_loci option deactivated
=> Machine information:
    This script is being run by perl v5.34.0
    Bioperl location being used: /app/software/BioPerl/1.7.8-GCCcore-11.2.0/lib/perl5/site_perl/5.34.0/Bio/
    Operating system being used: linux
=> Accessing Ontology
    No ontology accessible from the gff file header!
    We use the SOFA ontology distributed with AGAT:
        /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo
    Read ontology /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo:
        4 root terms, and 2596 total terms, and 1516 leaf terms
    Filtering ontology:
        We found 1861 terms that are sequence_feature or is_a child of it.
--------------------------------- parsing file ---------------------------------
=> Number of line in file: 27298
=> Number of comment lines: 5461
=> Fasta included: No
=> Number of features lines: 21837
=> Number of feature type (3rd column): 12
    * Level1: 4 => chromosome biological_region gene ncRNA_gene
    * level2: 6 => snRNA ncRNA tRNA rRNA mRNA lnc_RNA
    * level3: 2 => exon CDS
    * unknown: 0 =>
=> Version of the Bioperl GFF parser selected by AGAT: 3
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   9115    9552    .   +   .   external_name "KLLA0_A00165t; CR382121.1:mobile_element:9115..9552"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   341014  344221  .   -   .   external_name "KLLA0_A03844t; DNA transposon of KLLA part of the newly discovered ROVER DNA transposon family of the Kluyveromyces: degenerate copy with probably 2 frameshifts"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   584843  585278  .   +   .   external_name "KLLA0_A06457t; CR382121.1:mobile_element:584843..585278"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_misc_feature    biological_region   760404  760598  .   +   .   external_name "KLLA0_A08668s; Centromere Klla0A"  ; logic_name ena_misc_feature
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   1046924 1047346 .   -   .   external_name "KLLA0_A12023t; CR382121.1:mobile_element:complement(1046924..1047346)"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   1047531 1048025 .   -   .   external_name "KLLA0_A12034t; CR382121.1:mobile_element:complement(1047531..1048025)"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: A    ena_mobile_element  biological_region   1054728 1060266 .   -   .   external_name "KLLA0_A12134t; CR382121.1:mobile_element:complement(1054728..1060266)"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: B    ena_mobile_element  biological_region   21083   21192   .   +   .   external_name "KLLA0_B00330t; CR382122.1:mobile_element:21083..21192"  ; logic_name ena_mobile_element
gff3 reader error level1: No ID attribute found @ for the feature: B    ena_misc_feature    biological_region   1168861 1169058 .   +   .   external_name "KLLA0_B13299s; Centromere Klla0B"  ; logic_name ena_misc_feature
gff3 reader error level1: No ID attribute found @ for the feature: C    ena_misc_feature    biological_region   1638151 1638347 .   +   .   external_name "KLLA0_C18529s; Centromere Klla0C"  ; logic_name ena_misc_feature
gff3 reader error level1: No ID attribute found  ************** Too much WARNING message we skip the next **************
Parsing: 100% [======================================================]D 0h00m02s
33 warning messages: gff3 reader error level1: No ID attribute found
********************************************************************************
*                               - End parsing -                                *
*                              done in 3 seconds                               *
********************************************************************************

********************************************************************************
*                               - Start checks -                               *
********************************************************************************
---------------------------- Check1: feature types -----------------------------
----------------------------------- ontology -----------------------------------
INFO - Feature types not expected by the GFF3 specification:
* lnc_rna
The feature type (3rd column in GFF3) is constrained to be either a term from th
e Sequence Ontology or an SO accession number. The latter alternative is disting
uished using the syntax SO:000000. In either case, it must be sequence_feature (
SO:0000110) or an is_a child of it.To follow rigorously the gff3 format, please
visit this website:
https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md
------------------------------------- agat -------------------------------------
AGAT can deal with all the encountered feature types (3rd column)
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check2: duplicates ------------------------------
None found
------------------------------ done in 0 seconds -------------------------------

-------------------------- Check3: sequential bucket ---------------------------
None found
------------------------------ done in 1 seconds -------------------------------

--------------------------- Check4: l2 linked to l3 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check5: l1 linked to l2 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check6: remove orphan l1 ---------------------------
We remove only those not supposed to be orphan
None found
------------------------------ done in 0 seconds -------------------------------

------------------------- Check7: all level3 locations -------------------------
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check8: check cds -------------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check9: check exons ------------------------------
No exons created
No exons locations modified
No supernumerary exons removed
No level2 locations modified
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check10: check utrs ------------------------------
No UTRs created
No UTRs locations modified
No supernumerary UTRs removed
------------------------------ done in 0 seconds -------------------------------

------------------------ Check11: all level2 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

------------------------ Check12: all level1 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

---------------------- Check13: remove identical isoforms ----------------------
None found
------------------------------ done in 0 seconds -------------------------------
********************************************************************************
*                                - End checks -                                *
*                              done in 1 seconds                               *
********************************************************************************

=> OmniscientI total time: 4 seconds
./kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz GFF3 file parsed
There is 6 chromosome
There is 5076 gene
There is 33 biological_region
There is 1 lnc_rna
There is 5076 mrna
There is 21 rrna
There is 1 ncrna
There is 310 trna
There is 35 snrna
There is 5659 exon
There is 5251 cds
There is 368 ncrna_gene

Total raw data of files together:
There is 77 snorna
There is 1 lnc_rna
There is 23 chromosome
There is 33 biological_region
There is 11676 gene
There is 41 snrna
There is 12 pseudogene
There is 609 trna
There is 19 ncrna
There is 45 rrna
There is 11676 mrna
There is 91 transposable_element
There is 13166 exon
There is 91 rna
There is 0 transposable_element_gene
There is 4 five_prime_utr
There is 12 pseudogenic_transcript
There is 792 ncrna_gene
There is 12164 cds

Now merging overlaping loci, and removing identical isoforms
********************************************************************************
*                              - Start parsing -                               *
********************************************************************************
-------------------------- parse options and metadata --------------------------
=> Accessing the feature level json files
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level1.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level2.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_level3.json file
    Using standard /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/features_spread.json file
=> Attribute used to group features when no Parent/ID relationship exists (i.e common tag):
    * locus_tag
    * gene_id
=> merge_loci option activated
=> Machine information:
    This script is being run by perl v5.34.0
    Bioperl location being used: /app/software/BioPerl/1.7.8-GCCcore-11.2.0/lib/perl5/site_perl/5.34.0/Bio/
    Operating system being used: linux
=> Accessing Ontology
    No ontology accessible from the gff file header!
    We use the SOFA ontology distributed with AGAT:
        /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo
    Read ontology /app/software/AGAT/0.9.2-GCC-11.2.0/lib/perl5/site_perl/5.34.0/auto/share/dist/AGAT/so.obo:
        4 root terms, and 2596 total terms, and 1516 leaf terms
    Filtering ontology:
        We found 1861 terms that are sequence_feature or is_a child of it.
--------------------------------- parsing file ---------------------------------
********************************************************************************
*                               - End parsing -                                *
*                              done in 2 seconds                               *
********************************************************************************

********************************************************************************
*                               - Start checks -                               *
********************************************************************************
---------------------------- Check1: feature types -----------------------------
----------------------------------- ontology -----------------------------------
INFO - Feature types not expected by the GFF3 specification:
* lnc_rna
* rna
The feature type (3rd column in GFF3) is constrained to be either a term from th
e Sequence Ontology or an SO accession number. The latter alternative is disting
uished using the syntax SO:000000. In either case, it must be sequence_feature (
SO:0000110) or an is_a child of it.To follow rigorously the gff3 format, please
visit this website:
https://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md
------------------------------------- agat -------------------------------------
AGAT can deal with all the encountered feature types (3rd column)
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check2: duplicates ------------------------------
None found
------------------------------ done in 0 seconds -------------------------------

-------------------------- Check3: sequential bucket ---------------------------
None found
------------------------------ done in 1 seconds -------------------------------

--------------------------- Check4: l2 linked to l3 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check5: l1 linked to l2 ----------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

--------------------------- Check6: remove orphan l1 ---------------------------
We remove only those not supposed to be orphan
None found
------------------------------ done in 0 seconds -------------------------------

------------------------- Check7: all level3 locations -------------------------
------------------------------ done in 0 seconds -------------------------------

------------------------------ Check8: check cds -------------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

----------------------------- Check9: check exons ------------------------------
No exons created
No exons locations modified
No supernumerary exons removed
No level2 locations modified
------------------------------ done in 1 seconds -------------------------------

----------------------------- Check10: check utrs ------------------------------
No UTRs created
No UTRs locations modified
No supernumerary UTRs removed
------------------------------ done in 0 seconds -------------------------------

------------------------ Check11: all level2 locations -------------------------
No problem found
------------------------------ done in 0 seconds -------------------------------

------------------------ Check12: all level1 locations -------------------------
No problem found
------------------------------ done in 1 seconds -------------------------------

-------------- Check13: merge overlaping features into same locus --------------
165 overlapping cases found. For each case 2 loci have been merged within a same locus
------------------------------ done in 1 seconds -------------------------------

---------------------- Check14: remove identical isoforms ----------------------
None found
------------------------------ done in 0 seconds -------------------------------
********************************************************************************
*                                - End checks -                                *
*                              done in 4 seconds                               *
********************************************************************************

=> OmniscientI total time: 6 seconds

final result:
There is 19 ncrna
There is 45 rrna
There is 11676 mrna
There is 50 transposable_element
There is 10 pseudogene
There is 41 snrna
There is 609 trna
There is 23 chromosome
There is 11557 gene
There is 33 biological_region
There is 77 snorna
There is 1 lnc_rna
There is 789 ncrna_gene
There is 12164 cds
There is 12 pseudogenic_transcript
There is 4 five_prime_utr
There is 13166 exon
There is 91 rna
```
Seems to be OK...
</details>
</details>

<a id="getting-the-fastq-files-of-interest-into-one-location"></a>
##### Getting the `.fastq` files of interest into one location
```bash
#!/bin/bash
#DONTRUN

#  grabnode should be "on"

#  Base directory containing subdirectories with original merged .fastq files
cd ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot

ls -d1 Sample_57*
# Sample_5781_G1_IN
# Sample_5781_G1_IP
# Sample_5781_Q_IN
# Sample_5781_Q_IP
# Sample_5782_G1_IN
# Sample_5782_G1_IP
# Sample_5782_Q_IN
# Sample_5782_Q_IP

ls -d1 Sample_57*/*merged*fastq*
# Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq
# Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq
# Sample_5781_G1_IP/5781_G1_IP_merged_R1.fastq
# Sample_5781_G1_IP/5781_G1_IP_merged_R2.fastq
# Sample_5781_Q_IN/5781_Q_IN_merged_R1.fastq
# Sample_5781_Q_IN/5781_Q_IN_merged_R2.fastq
# Sample_5781_Q_IP/5781_Q_IP_merged_R1.fastq
# Sample_5781_Q_IP/5781_Q_IP_merged_R2.fastq
# Sample_5782_G1_IN/5782_G1_IN_merged_R1.fastq
# Sample_5782_G1_IN/5782_G1_IN_merged_R2.fastq
# Sample_5782_G1_IP/5782_G1_IP_merged_R1.fastq
# Sample_5782_G1_IP/5782_G1_IP_merged_R2.fastq
# Sample_5782_Q_IN/5782_Q_IN_merged_R1.fastq
# Sample_5782_Q_IN/5782_Q_IN_merged_R2.fastq
# Sample_5782_Q_IP/5782_Q_IP_merged_R1.fastq
# Sample_5782_Q_IP/5782_Q_IP_merged_R2.fastq

#  Get the .fastq files into an array to loop over
cd ~

unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find ${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot \
        -type f \
        -name *578*merged*fastq* \
        -print0 \
            | sort -z \
)
for i in "${infiles[@]}"; do echo "${i}"; done  # Check
for i in "${infiles[@]}"; do echo "$(basename "${i}")"; done  # Check

#  Make symlinks to the .fastq files in 2022_transcriptome-contructions results
mkdir -p ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/files_fastq_symlinks

for i in "${infiles[@]}"; do
    ln -s \
        ${i} \
        ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/files_fastq_symlinks/$(basename ${i})
done

ls -1 ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/files_fastq_symlinks
# 5781_G1_IN_merged_R1.fastq
# 5781_G1_IN_merged_R2.fastq
# 5781_G1_IP_merged_R1.fastq
# 5781_G1_IP_merged_R2.fastq
# 5781_Q_IN_merged_R1.fastq
# 5781_Q_IN_merged_R2.fastq
# 5781_Q_IP_merged_R1.fastq
# 5781_Q_IP_merged_R2.fastq
# 5782_G1_IN_merged_R1.fastq
# 5782_G1_IN_merged_R2.fastq
# 5782_G1_IP_merged_R1.fastq
# 5782_G1_IP_merged_R2.fastq
# 5782_Q_IN_merged_R1.fastq
# 5782_Q_IN_merged_R2.fastq
# 5782_Q_IP_merged_R1.fastq
# 5782_Q_IP_merged_R2.fastq

#NOTE Per Alison, "IP" = Nascent, "IN" = SteadyState
```

<a id="checking-on-the-length-of-reads-for-each-fastq-file"></a>
##### Checking on the length of reads for each `.fastq` file
```bash
#!/bin/bash
#DONTRUN

#  grabnode should be "on"

cd ~/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101

#  Prepare for and run FastQC
mkdir -p files_fastq_symlinks/FastQC

cat << script > "./submit-FastQC.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-FastQC.sh
#  KA

module load FastQC/0.11.9-Java-11

infile="\${1}"
outdir="\${2}"

fastqc \\
    --threads "\${SLURM_CPUS_ON_NODE}" \\
    --outdir "\${outdir}" \\
    "\${infile}"
script

#  Get the symlinked .fastq files into an array to loop over
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name 578*merged*fastq* \
        -print0 \
            | sort -z \
)
for i in "${infiles[@]}"; do echo "${i}"; done  # Check
for i in "${infiles[@]}"; do echo "$(basename "${i}" ".fastq")"; done  # Check

#  Do a test run of submit-FastQC.sh
i="${infiles[0]}"

mkdir -p "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"

sbatch ./submit-FastQC.sh \
    "${i}" \
    "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"
#NOTE It works

#  Submit the .fastq files to SLURM
for i in "${infiles[@]}"; do
    mkdir -p "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"

    sbatch ./submit-FastQC.sh \
        "${i}" \
        "./files_fastq_symlinks/FastQC/$(basename "${i}" ".fastq")"

    sleep 0.5
done

#  Clean up the FastQC work
mkdir -p exp_FastQC
mv *.{err,out}.txt exp_FastQC/

ls -d ./files_fastq_symlinks/FastQC/*.bak
./files_fastq_symlinks/FastQC/5781_G1_IN_merged_R1.bak
rm -r ./files_fastq_symlinks/FastQC/5781_G1_IN_merged_R1.bak

#  Going into the ./files_fastq_symlinks/FastQC subdirectories and manually
#+ spot-checking the .html files

#NOTE #IMPORTANT The read length is bp (at least for these "WTQvsG1" files)
````

<a id="run-star-genome-generation"></a>
#### Run `STAR` genome generation
```bash
#!/bin/bash
#DONTRUN

#  grabnode has been called with default/lowest settings
cd ~/genomes/combined_SC_KL_20S
mkdir -p STAR/{err_out,sh}
cd STAR/

#  Reference
# STAR \
#     --runThreadN "${SLURM_CPUS_ON_NODE}" \
#     --runMode genomeGenerate \
#     --genomeDir "${genome_dir}" \
#     --genomeFastaFiles "${genome_fasta_file}" \
#     --sjdbGTFfile "${sjdb_gtf_file}" \
#     --sjdbOverhang "${sjdb_overhang}" \
#     --sjdbGTFtagExonParentTranscript Parent \
#     --genomeSAindexNbases "${genome_sa_index_n_bases}"

cat << script > "./submit-STAR-genomeGenerate.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-STAR-genomeGenerate.sh
#  KA

module load STAR/2.7.9a-GCC-11.2.0

genome_dir="\${1}"
genome_fasta_file="\${2}"
sjdb_gtf_file="\${3}"
sjdb_overhang="\${4}"
genome_sa_index_n_bases="\${5}"

STAR \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --runMode genomeGenerate \\
    --genomeDir "\${genome_dir}" \\
    --genomeFastaFiles "\${genome_fasta_file}" \\
    --sjdbGTFfile "\${sjdb_gtf_file}" \\
    --sjdbOverhang "\${sjdb_overhang}" \\
    --sjdbGTFtagExonParentTranscript Parent \\
    --genomeSAindexNbases "\${genome_sa_index_n_bases}"
script

#  First, make sure the .gff3 file is unzipped
[[ -f ../gff3/combined_SC_KL.gff3 ]] ||
    {
        cd ../gff3
        gzip -dk combined_SC_KL.gff3.gz
        cd -
    }

#  Try it out
genome_dir="."
genome_fasta_file="../fasta/combined_SC_KL_20S.fasta"
sjdb_gtf_file="../gff3/combined_SC_KL.gff3"
sjdb_overhang="49"  # 50 - 1
genome_sa_index_n_bases="10"
#  Per Alex Dobin, 12 is appropriate the S. cerevisiae genome; however, in a
#+ trial run, I got the following error (broken over multiple lines by me):
#+ 
#+ !!!!! WARNING: --genomeSAindexNbases 12 is too large for the genome
#+ size=22848775, which may cause seg-fault at the mapping step. Re-run genome
#+ generation with recommended --genomeSAindexNbases 11
#+ 
#+ Therefore, I changed genome_sa_index_n_bases from "12" to "11"

#IMPORTANT 
#  Actually, the above is incorrect; Dobin recommends "10", not "12", for
#+ --genomeSAindexNbases: Set --genomeSAindexNbases 10
#+ 
#+ groups.google.com/g/rna-star/c/hQeHTBbkc0c?pli=1

sbatch submit-STAR-genomeGenerate.sh \
    "${genome_dir}" \
    "${genome_fasta_file}" \
    "${sjdb_gtf_file}" \
    "${sjdb_overhang}" \
    "${genome_sa_index_n_bases}"
#NOTE #IMPORTED Completed remarkably quickly... like, less than 10 seconds

#  Clean up
mv *.{err,out}.txt err_out/
mv *.sh sh/

#  Document things a bit
mkdir readme && cd readme/
touch readme.md
echo \
    "Made 2022-1107. See readme.md in directory results/2022-1101 for details." \
    >> readme.md

echo \
    "Files made on 2022-1107 used '--genomeSAindexNbases 11'. Alex Dobin recommends '10', not '11', for the yeast genome. Therefore, deleted those files." \
    >> readme.md

echo "" >> readme.md

echo \
    "Files made on 2022-1108 used '--genomeSAindexNbases 10'." \
    >> readme.md
```

<a id="run-star-alignment"></a>
#### Run `STAR` alignment
```bash
#!/bin/bash
#DONTRUN

#  grabnode has been called with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"
mkdir -p {exp_alignment_STAR,files_bams}

#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)
#  Some checks...
for i in "${infiles[@]}"; do echo "${i}"; done && echo ""
for i in "${infiles[@]}"; do echo "$(basename "${i}")"; done && echo
for i in "${infiles[@]}"; do echo "$(basename "${i%_R?.fastq}")"; done && echo ""

echo "${infiles[0]}" && echo ""
echo "${infiles[1]}" && echo ""
echo "$(basename "${infiles[0]%_R?.fastq}")" && echo ""

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"

echo "${genome_dir}"
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"
#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Run the alignment
if [[ -f "./submit-STAR-alignReads.sh" ]]; then
    rm "./submit-STAR-alignReads.sh"
fi

cat << script > "./submit-STAR-alignReads.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-STAR-alignReads.sh
#  KA

module load STAR/2.7.9a-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

STAR \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMunmapped Within \\
    --genomeDir "\${genome_dir}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax 1 \\
    --alignSJoverhangMin 8 \\
    --alignSJDBoverhangMin 1 \\
    --outFilterMismatchNmax 999 \\
    --alignIntronMin 4 \\
    --alignIntronMax 5000 \\
    --alignMatesGapMax 5000 \\
    --outSAMtype BAM SortedByCoordinate
script

sbatch submit-STAR-alignReads.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

<a id="alignment-metrics-for-the-test-run-of-star"></a>
##### Alignment metrics for the test run of `STAR`
```txt
                                 Started job on |       Nov 08 10:28:26
                             Started mapping on |       Nov 08 10:28:27
                                    Finished on |       Nov 08 10:29:41
       Mapping speed, Million of reads per hour |       680.54

                          Number of input reads |       13988842
                      Average input read length |       100
                                    UNIQUE READS:
                   Uniquely mapped reads number |       8559366
                        Uniquely mapped reads % |       61.19%
                          Average mapped length |       98.22
                       Number of splices: Total |       352426
            Number of splices: Annotated (sjdb) |       289654
                       Number of splices: GT/AG |       321441
                       Number of splices: GC/AG |       232
                       Number of splices: AT/AC |       2334
               Number of splices: Non-canonical |       28419
                      Mismatch rate per base, % |       0.39%
                         Deletion rate per base |       0.01%
                        Deletion average length |       1.19
                        Insertion rate per base |       0.01%
                       Insertion average length |       1.17
                             MULTI-MAPPING READS:
        Number of reads mapped to multiple loci |       0
             % of reads mapped to multiple loci |       0.00%
        Number of reads mapped to too many loci |       5035208
             % of reads mapped to too many loci |       35.99%
                                  UNMAPPED READS:
  Number of reads unmapped: too many mismatches |       0
       % of reads unmapped: too many mismatches |       0.00%
            Number of reads unmapped: too short |       393913
                 % of reads unmapped: too short |       2.82%
                Number of reads unmapped: other |       355
                     % of reads unmapped: other |       0.00%
                                  CHIMERIC READS:
                       Number of chimeric reads |       0
                            % of chimeric reads |       0.00%
```

<a id="thoughts-on-the-alignment-metrics-for-star"></a>
###### Thoughts on the alignment metrics for `STAR`:
- A lot of multimappers in the dataset...
- `#DONE` Later, check what value I assigned to `--outFilterMultimapNmax` in my 4DN RNA-seq work; consider to replace the current value, `1`, with that other value
    + `#ANSWER` `--outFilterMultimapNmax 1000`
- `#DONE` What does the [`Trinity` Google Group](https://groups.google.com/g/trinityrnaseq-users) have to say about multimappers?
    + `#ANSWER` Per Brian Haas at [this post](https://groups.google.com/g/trinityrnaseq-users/c/L4hypoWSk_o/m/bTO2L8ssAQAJ): "If reads are mapped to multiple genomic locations, then `Trinity` will use those reads as substrates for *de novo* assembly at each of the locations. This is important to do in the case of paralogs that share sequences in common."
        * However, here, he's talking about genome-guided assembly; is this also the case for non-genome-guided assembly?
            - `#ANSWER` I would think so... What he says about potential paralogs seems like it holds true in this circumstance too
    + 2022-1110: The thinking here is continued and expanded [below](#more-thoughts-on-multimappers-2022-1109-1110)

<a id="examine-the-flags-in-the-bam-outfile-from-the-test-run-of-star"></a>
###### Examine the flags in the `.bam` outfile from the test run of `STAR`
Use `samtools flagstat` and the bespoke function `list_tally_flags`:
```bash
#!/bin/bash
#DONTRUN

#  grabnode has been called with default/lowest settings; samtools is loaded
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

samtools flagstat \
    ./files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    > ./files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt

less ./files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# 27446606 + 531078 in total (QC-passed reads + QC-failed reads)
# 27446606 + 531078 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 16893176 + 225556 mapped (61.55% : 42.47%)
# 16893176 + 225556 primary mapped (61.55% : 42.47%)
# 27446606 + 531078 paired in sequencing
# 13723303 + 265539 read1
# 13723303 + 265539 read2
# 16893176 + 225556 properly paired (61.55% : 42.47%)
# 16893176 + 225556 with itself and mate mapped
# 0 + 0 singletons (0.00% : 0.00%)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)

cd ./files_bams

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags 5781_G1_IN_mergedAligned.sortedByCoord.out.bam

#  Numbers of records in the .bam file
samtools view -c \
    5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# 27977684

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

#  The numbers of records in the .bam and .fastq files are equivalent
```

Contents of outfile from running `list_tally_flags` (with some format edits and additions from me)...
```txt
5276715    77     unmapped (read, mate)
5276715    141    unmapped (read, mate)
4691235    99
4691235    147
3755353    83
3755353    163
 152761    653    unmapped (read, mate)    read fails
 152761    589    unmapped (read, mate)    read fails
  62364    659    read fails
  62364    611    read fails
  50414    675    read fails
  50414    595    read fails
```
What are the meanings of these flags? Use [this tool](https://broadinstitute.github.io/picard/explain-flags.html) to check:
| flag | meaning                                                                                                                     |
| :--- | :-------------------------------------------------------------------------------------------------------------------------- |
| 77   | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40)                                           |
| 141  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80)                                          |
| 99   | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40)                       |
| 147  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80)                      |
| 83   | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40)                       |
| 163  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80)                      |
| 653  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80), read fails* (0x200)                     |
| 589  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40), read fails* (0x200)                      |
| 659  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80), read fails* (0x200) |
| 611  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40), read fails* (0x200)  |
| 675  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80), read fails* (0x200) |
| 595  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40), read fails* (0x200)  |

<a id="additional-thoughts-on-the-alignment-metrics-and-flags-from-star"></a>
###### Additional thoughts on the alignment metrics and flags from `STAR`
- Because we want to use the multimappers in `Trinity` transcriptome assembly (rationale in ["Thoughts on the..."](#thoughts-on-the-alignment-metrics-for-star) above), it'd probably be good to have information for where `STAR` (and `Bowtie 2`) is aligning them in the bam file, instead of them being unmapped as above
- Thus, we should adjust the parameters for how we call `STAR` to retain the multimappers
- `#DONE` Adjust `STAR` parameters based on the repetitive-element work you did in 2020 (bring your laptop to work tomorrow); for now, move on to `Bowtie 2` work

<a id="do-a-little-clean-up-prior-to-running-alignment-with-bowtie-2"></a>
###### Do a little clean-up prior to running alignment with `Bowtie 2`
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

mv files_bams/ exp_alignment_STAR/
```

<a id="generating-files-needed-for-bowtie-2-alignment-2022-1108"></a>
#### Generating files needed for `Bowtie 2` alignment (2022-1108)
...to the combined reference genes (*S. cerevisiae*, *K. lactis*, and S20)

<a id="preparing-the-fasta-and-gff3-files-for-bowtie-2"></a>
##### Preparing the `.fasta` and `.gff3` files for `Bowtie 2`
`Bowtie 2` indices were already generated: see [this link](../2022-1025/readme.md#create-bowtie-2-indices); but just checking on things before diving into things...
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/genomes/combined_SC_KL_20S"

#  Checking the .fasta
grep "^>" ./fasta/*.fasta
# >I
# >II
# >III
# >IV
# >V
# >VI
# >VII
# >VIII
# >IX
# >X
# >XI
# >XII
# >XIII
# >XIV
# >XV
# >XVI
# >Mito
# >A
# >B
# >C
# >D
# >E
# >F
# >20S

#  Checking the .gff3
head -33 ./gff3/combined_SC_KL.gff3
# ##gff-version 3
# ##sequence-region   I 1 230218
# ##sequence-region   II 1 813184
# ##sequence-region   III 1 316620
# ##sequence-region   IV 1 1531933
# ##sequence-region   IX 1 439888
# ##sequence-region   Mito 1 85779
# ##sequence-region   V 1 576874
# ##sequence-region   VI 1 270161
# ##sequence-region   VII 1 1090940
# ##sequence-region   VIII 1 562643
# ##sequence-region   X 1 745751
# ##sequence-region   XI 1 666816
# ##sequence-region   XII 1 1078177
# ##sequence-region   XIII 1 924431
# ##sequence-region   XIV 1 784333
# ##sequence-region   XV 1 1091291
# ##sequence-region   XVI 1 948066
# #!genome-build  R64-1-1
# #!genome-version R64-1-1
# #!genome-date 2011-09
# #!genome-build-accession GCA_000146045.2
# #!genebuild-last-updated 2018-10
# ##sequence-region   A 1 1062590
# ##sequence-region   B 1 1320834
# ##sequence-region   C 1 1753957
# ##sequence-region   D 1 1715506
# ##sequence-region   E 1 2234072
# ##sequence-region   F 1 2602197
# #!genome-build Genolevures Consortium ASM251v1
# #!genome-version ASM251v1
# #!genome-build-accession GCA_000002515.1
# #!genebuild-last-updated 2015-02

#  Checking the Bowtie 2 indices
#+ bowtie-bio.sourceforge.net/bowtie2/manual.shtml#the-bowtie2-build-indexer
module load Bowtie2/2.4.4-GCC-11.2.0
bowtie2-inspect --names ./Bowtie2/combined_SC_KL_20S
# I
# II
# III
# IV
# V
# VI
# VII
# VIII
# IX
# X
# XI
# XII
# XIII
# XIV
# XV
# XVI
# Mito
# A
# B
# C
# D
# E
# F
# 20S
```

<a id="on-the-location-of-the-fastq-files"></a>
##### On the location of the `.fastq` files
See all the work done [here](#getting-the-fastq-files-of-interest-into-one-location)

<a id="run-bowtie-2-alignment"></a>
##### Run `Bowtie 2` alignment
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

mkdir -p exp_alignment_Bowtie_2/files_bams

#  Get .fastq files into an array
#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./exp_alignment_Bowtie_2/files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"

#  Some checks...
echo "${genome_dir}"
ls -lhaFG ${genome_dir}* && echo ""
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"

#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Perform alignment with Bowtie 2
if [[ -f "./submit-Bowtie-2.sh" ]]; then
    rm "./submit-Bowtie-2.sh"
fi

cat << script > "./submit-Bowtie-2.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Bowtie-2.sh
#  KA

module load Bowtie2/2.4.4-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

bowtie2 \\
    -p "\${SLURM_CPUS_ON_NODE}" \\
    -x "\${genome_dir}" \\
    -1 "\${read_1}" \\
    -2 "\${read_2}" \\
    --trim5 1 \\
    --local \\
    --very-sensitive-local \\
    --no-unal \\
    --no-mixed \\
    --no-discordant \\
    --phred33 \\
    -I 10 \\
    -X 700 \\
    --no-overlap \\
    --no-dovetail \\
        | samtools sort -@ "\${SLURM_CPUS_ON_NODE}" -o "\${prefix}_sorted.bam" -
script

sbatch submit-Bowtie-2.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

<a id="alignment-metrics-for-the-test-run-of-bowtie-2"></a>
##### Alignment metrics for the test run of `Bowtie 2`
```txt
13988842 reads; of these:
  13988842 (100.00%) were paired; of these:
    904915 (6.47%) aligned concordantly 0 times
    7154822 (51.15%) aligned concordantly exactly 1 time
    5929105 (42.38%) aligned concordantly >1 times
93.53% overall alignment rate
[bam_sort_core] merging from 7 files and 1 in-memory blocks..
```

<a id="thoughts-on-the-alignment-metrics-for-bowtie-2"></a>
###### Thoughts on the alignment metrics for `Bowtie 2`
- Approximately half are well-aligned
- Approximately 7% of reads don't align at all
- The rest, 43%, are discordant

<a id="examine-the-flags-in-the-bam-outfile-from-the-test-run-of-bowtie-2"></a>
###### Examine the flags in the `.bam` outfile from the test run of `Bowtie 2`
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

#  First, a bit of clean-up
mv *.txt exp_alignment_Bowtie_2/

ml SAMtools/1.16.1-GCC-11.2.0

samtools flagstat \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam \
    > ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.flagstat.txt
# 26167854 + 0 in total (QC-passed reads + QC-failed reads)
# 26167854 + 0 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 26167854 + 0 mapped (100.00% : N/A)
# 26167854 + 0 primary mapped (100.00% : N/A)
# 26167854 + 0 paired in sequencing
# 13083927 + 0 read1
# 13083927 + 0 read2
# 26167854 + 0 properly paired (100.00% : N/A)
# 26167854 + 0 with itself and mate mapped
# 0 + 0 singletons (0.00% : N/A)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam

samtools view -c \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam
# 26167854

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

# Multiply by the overall alignment rate: Is it equal to the number of records in the .bam file?
echo "27977684*0.9353" | bc
# 26167527.8452; rounds up to 26167528; rounds down to 26167527

#  The numbers of records in the .bam and .fastq files are not equivalent
```

Contents of outfile from running `list_tally_flags` (with some format edits)...
```txt
7070153    83
7070153    163
6013774    99
6013774    147
```

What are the meanings of these flags? Use [this tool](https://broadinstitute.github.io/picard/explain-flags.html) to check:
| flag | meaning                                                                                                |
| :--- | :----------------------------------------------------------------------------------------------------- |
| 83   | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40)  |
| 163  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80) |
| 99   | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40)  |
| 147  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80) |

<a id="try-re-running-bowtie-2-alignment"></a>
##### Try re-running `Bowtie 2` alignment
...***without*** the flags for removing unaligned and discordant reads, which were mistakenly included in the first run
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

#  Remove the bams and other files from the "first test"
rm -r exp_alignment_Bowtie_2/

#  Remake the experiment directory
mkdir -p exp_alignment_Bowtie_2/files_bams  # Should already be done

#  Get .fastq files into an array
#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./exp_alignment_Bowtie_2/files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S"

#  Some checks...
echo "${genome_dir}"
ls -lhaFG ${genome_dir}* && echo ""
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"

#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Rename the script for calling Bowtie 2 as in the preceding code chunk
if [[ -f "submit-Bowtie-2.sh" ]]; then
    mv "submit-Bowtie-2.sh" "submit-Bowtie-2.test-1.sh"
fi

#  Perform alignment with Bowtie 2
if [[ -f "./submit-Bowtie-2.test-2.sh" ]]; then
    rm "./submit-Bowtie-2.test-2.sh"
fi

#  Parameters updated in comparison to the first test
cat << script > "./submit-Bowtie-2.test-2.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Bowtie-2.sh
#  KA

module load Bowtie2/2.4.4-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

bowtie2 \\
    -p "\${SLURM_CPUS_ON_NODE}" \\
    -x "\${genome_dir}" \\
    -1 "\${read_1}" \\
    -2 "\${read_2}" \\
    --local \\
    --very-sensitive-local \\
    --phred33 \\
    -I 10 \\
    -X 700 \\
    --un-conc-gz "\${prefix}.unaligned" \\
    --al-conc-gz "${prefix}.aligned" \\
        | samtools sort -@ "\${SLURM_CPUS_ON_NODE}" -o "\${prefix}_sorted.bam" -
script

sbatch submit-Bowtie-2.test-2.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

<a id="alignment-metrics-for-the-corrected-test-run-of-bowtie-2"></a>
##### Alignment metrics for the *corrected* test run of Bowtie 2
Remember, *corrected* means `Bowtie 2` was called without flags for removing unaligned and discordant reads, both of which were present in the first run
```txt
13988842 reads; of these:
  13988842 (100.00%) were paired; of these:
    552105 (3.95%) aligned concordantly 0 times
    7261264 (51.91%) aligned concordantly exactly 1 time
    6175473 (44.15%) aligned concordantly >1 times
    ----
    552105 pairs aligned concordantly 0 times; of these:
      119842 (21.71%) aligned discordantly 1 time
    ----
    432263 pairs aligned 0 times concordantly or discordantly; of these:
      864526 mates make up the pairs; of these:
        386601 (44.72%) aligned 0 times
        176417 (20.41%) aligned exactly 1 time
        301508 (34.88%) aligned >1 times
98.62% overall alignment 
[bam_sort_core] merging from 8 files and 8 in-memory blocks...
```

<a id="thoughts-on-the-alignment-metrics-for-bowtie-2-corrected"></a>
###### Thoughts on the alignment metrics for `Bowtie 2` (*corrected*)
- Very similar to the [previous run](#alignment-metrics-for-the-test-run-of-bowtie-2)...

<a id="examine-the-flags-in-the-bam-outfile-from-the-corrected-test-run-of-bowtie-2"></a>
###### Examine the flags in the `.bam` outfile from the *corrected* test run of `Bowtie 2`
Again, remember that *corrected* means `Bowtie 2` was called without flags for removing unaligned and discordant reads, both of which were present in the first run
```bash
#!/bin/bash
#DONTRUN

#  Have called grabnode with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

#  First, a bit of clean-up
mv *.txt exp_alignment_Bowtie_2/

ml SAMtools/1.16.1-GCC-11.2.0

samtools flagstat \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam \
    > ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.flagstat.txt
#  1. Readout from "correct" .bam (i.e., with correct parameters)
# 27977684 + 0 in total (QC-passed reads + QC-failed reads)
# 27977684 + 0 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 27591083 + 0 mapped (98.62% : N/A)
# 27591083 + 0 primary mapped (98.62% : N/A)
# 27977684 + 0 paired in sequencing
# 13988842 + 0 read1
# 13988842 + 0 read2
# 26873474 + 0 properly paired (96.05% : N/A)
# 27450096 + 0 with itself and mate mapped
# 140987 + 0 singletons (0.50% : N/A)
# 153696 + 0 with mate mapped to a different chr
# 65835 + 0 with mate mapped to a different chr (mapQ>=5)

#  1. Readout from "uncorrect" .bam (i.e., with incorrect parameters; see
#+    above)
# 26167854 + 0 in total (QC-passed reads + QC-failed reads)
# 26167854 + 0 primary
# 0 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 26167854 + 0 mapped (100.00% : N/A)
# 26167854 + 0 primary mapped (100.00% : N/A)
# 26167854 + 0 paired in sequencing
# 13083927 + 0 read1
# 13083927 + 0 read2
# 26167854 + 0 properly paired (100.00% : N/A)
# 26167854 + 0 with itself and mate mapped
# 0 + 0 singletons (0.00% : N/A)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam

samtools view -c \
    ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam
# 27977684

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

# Multiply by the overall alignment rate: Is it equal to the number of records in the .bam file?
echo "27977684*0.9862" | bc
# 27591591.9608; rounds up to 27591592; rounds down to 27591591

#  Numbers of records in the .bam and .fastq files *are* equivalent
#+ Great!
```

Contents of outfile from running `list_tally_flags` (with format edits and notes from me)...
```txt
7314425    83
7314425    163
6122312    99
6122312    147
 139372    97
 139372    145
 122807    77     unmapped (read, mate)
 122807    141    unmapped (read, mate)
  96792    81
  96792    161
  42776    89     unmapped (mate)
  42776    165    unmapped (read)
  40407    73     unmapped (mate)
  40407    133    unmapped (read)
  33323    65
  33323    129
  31296    153    unmapped (mate)
  31296    101    unmapped (read)
  26508    69     unmapped (read)
  26508    137    unmapped (mate)
  18824    177    on different chromosomes
  18824    113    on different chromosomes
```
What are the meanings of these flags? Use [this tool](https://broadinstitute.github.io/picard/explain-flags.html) to check:
| flag | meaning                                                                                                |
| :--- | :----------------------------------------------------------------------------------------------------- |
| 83   | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40)  |
| 163  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80) |
| 99   | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40)  |
| 147  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80) |
| 97   | read paired (0x1), mate reverse strand (0x20), first in pair (0x40)                                    |
| 145  | read paired (0x1), read reverse strand (0x10), second in pair (0x80)                                   |
| 77   | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40)                      |
| 141  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80)                     |
| 81   | read paired (0x1), read reverse strand (0x10), first in pair (0x40)                                    |
| 161  | read paired (0x1), mate reverse strand (0x20), second in pair (0x80)                                   |
| 89   | read paired (0x1), mate unmapped (0x8), read reverse strand (0x10), first in pair (0x40)               |
| 165  | read paired (0x1), read unmapped (0x4), mate reverse strand (0x20), second in pair (0x80)              |
| 73   | read paired (0x1), mate unmapped (0x8), first in pair (0x40)                                           |
| 133  | read paired (0x1), read unmapped (0x4), second in pair (0x80)                                          |
| 65   | read paired (0x1), first in pair (0x40)                                                                |
| 129  | read paired (0x1), second in pair (0x80)                                                               |
| 153  | read paired (0x1), mate unmapped (0x8), read reverse strand (0x10), second in pair (0x80)              |
| 101  | read paired (0x1), read unmapped (0x4), mate reverse strand (0x20), first in pair (0x40)               |
| 69   | read paired (0x1), read unmapped (0x4), first in pair (0x40)                                           |
| 137  | read paired (0x1), mate unmapped (0x8), second in pair (0x80)                                          |
| 177  | read paired (0x1), read reverse strand (0x10), mate reverse strand (0x20), second in pair (0x80)       |
| 113  | read paired (0x1), read reverse strand (0x10), mate reverse strand (0x20), first in pair (0x40)        |

Do the above counts sum to 27977684?
```bash
#!/bin/bash
#DONTRUN

echo $(( \
    7314425 + \
    7314425 + \
    6122312 + \
    6122312 + \
    139372 + \
    139372 + \
    122807 + \
    122807 + \
    96792 + \
    96792 + \
    42776 + \
    42776 + \
    40407 + \
    40407 + \
    33323 + \
    33323 + \
    31296 + \
    31296 + \
    26508 + \
    26508 + \
    18824 + \
    18824 \
))
# 27977684: Yes
```
<br />
<br />

<a id="examine-the-fastq-outfiles-from-the-corrected-test-run-of-bowtie-2"></a>
###### Examine the `.fastq` outfiles from the *corrected* test run of `Bowtie 2`
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/exp_alignment_Bowtie_2/files_bams"

ls -lhaFG
# total 2.5G
# drwxrws--- 2 kalavatt  337 Nov  9 15:31 ./
# drwxrws--- 3 kalavatt  160 Nov  9 15:23 ../
# -rw-rw---- 1 kalavatt 427M Nov  8 16:24 5781_G1_IN_merged.1.aligned
# -rw-rw---- 1 kalavatt  19M Nov  8 16:24 5781_G1_IN_merged.1.unaligned
# -rw-rw---- 1 kalavatt 447M Nov  8 16:24 5781_G1_IN_merged.2.aligned
# -rw-rw---- 1 kalavatt  19M Nov  8 16:24 5781_G1_IN_merged.2.unaligned
# -rw-rw---- 1 kalavatt 942M Nov  8 16:24 5781_G1_IN_merged_sorted.bam
# -rw-rw---- 1 kalavatt  531 Nov  9 15:25 5781_G1_IN_merged_sorted.flagstat.txt
# -rw-rw---- 1 kalavatt  255 Nov  9 15:29 5781_G1_IN_merged_sorted.flags.txt

#  (The files are gzipped even though the extension is not present...)
echo $(zcat 5781_G1_IN_merged.1.aligned | wc -l)/4 | bc  # 13436737
echo $(zcat 5781_G1_IN_merged.2.aligned | wc -l)/4 | bc  # 13436737
echo $(zcat 5781_G1_IN_merged.1.unaligned | wc -l)/4 | bc  # 552105
echo $(zcat 5781_G1_IN_merged.2.unaligned | wc -l)/4 | bc  # 552105

#  Do the above counts sum to 27977684?
echo $(( 13436737 + 13436737 + 552105 + 552105 ))  # 27977684: Yes
```

<a id="head-through-the-bam-outfile-from-the-corrected-test-run-of-bowtie-2"></a>
###### `head` through the `.bam` outfile from the *corrected* test run of `Bowtie 2`
...to see if information for multimappers are present in the tags
```bash
#!/bin/bash
#DONTRUN

cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/exp_alignment_Bowtie_2/files_bams"

samtools view -h 5781_G1_IN_merged_sorted.bam | less
```

Example output:
```txt
@HD     VN:1.0  SO:coordinate
@SQ     SN:I    LN:230218
@SQ     SN:II   LN:813184
@SQ     SN:III  LN:316620
@SQ     SN:IV   LN:1531933
@SQ     SN:V    LN:576874
@SQ     SN:VI   LN:270161
@SQ     SN:VII  LN:1090940
@SQ     SN:VIII LN:562643
@SQ     SN:IX   LN:439888
@SQ     SN:X    LN:745751
@SQ     SN:XI   LN:666816
@SQ     SN:XII  LN:1078177
@SQ     SN:XIII LN:924431
@SQ     SN:XIV  LN:784333
@SQ     SN:XV   LN:1091291
@SQ     SN:XVI  LN:948066
@SQ     SN:Mito LN:85779
@SQ     SN:A    LN:1062590
@SQ     SN:B    LN:1320834
@SQ     SN:C    LN:1753957
@SQ     SN:D    LN:1715506
@SQ     SN:E    LN:2234072
@SQ     SN:F    LN:2602197
@SQ     SN:20S  LN:2514
@PG     ID:bowtie2      PN:bowtie2      VN:2.4.4        CL:"/app/software/Bowtie2/2.4.4-GCC-11.2.0/bin/bowtie2-align-s --wrapper basic-0 -p 8 -x /home/kalavatt/genomes/combined_SC_KL_20S/Bowtie2/combined_SC_KL_20S --local --very-sensitive-local --phred33 -I 10 -X 700 --
@PG     ID:samtools     PN:samtools     PP:bowtie2      VN:1.16.1       CL:samtools sort -@ 8 -o ./exp_alignment_Bowtie_2/files_bams/5781_G1_IN_merged_sorted.bam -
@PG     ID:samtools.1   PN:samtools     PP:samtools     VN:1.16.1       CL:samtools view -h 5781_G1_IN_merged_sorted.bam
HISEQ:1007:HGV5NBCX3:1:1114:5228:88329  99      I       288     11      50M     =       522     280     CTACTCACCATACTGTTGTTCTACCCACCATATTGAAACGCTAACAAATG      GGGGGGGIIIIIIGIIIGGGIIIIIIIIIIIIGIGGIIIGIIIIIIIIIG      AS:i:93 XS:i:92 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:1114:5228:88329  147     I       522     11      4S46M   =       288     -280    CTAGATGCACTCACATCATTATGCACGGCACTTGCCTCAGCGGTCTATAC      GGGGGGGAIGGGGGGGIGGIIIGGGGGGGGGGIGGIIGIGGGGGIGGGGG      AS:i:92 XS:i:100        XN:i:0  XM:i:0  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:2106:14749:35491 163     I       1663    1       7S43M   =       1730    124     TTTTTTTTTGATCAAATAGGTCTATAATATTAATATACATTTATATAATC      GGGGGIIII<GGGGGAGGGGGIIGIIGGGGGGGIIAGGGGGGGGAGGGGG      AS:i:86 XS:i:86 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:2216:6220:25229  163     I       1663    14      7S43M   =       1701    95      TTTTTTTTTGGTCAAAAAGGTCTATAATATTAATAAAAATTTATATAATC      GGGGGIIIGAAG.<GG..<G<AAA.<A.<.G.<.<.<..<GGA#######      AS:i:64 XS:i:57 XN:i:0  XM:i:4  XO:i:0  XG:i:0  NM:i:4
HISEQ:1007:HGV5NBCX3:1:2114:12240:15164 163     I       1673    11      50M     =       1867    244     AGGTCTATAATATTAATATACATTTATATAATCTACGGTATTTATATCAT      GAAGGIIIIGIIIIIGIIGIIIIIIGIIIGGGIGIIGGGIIGIIIIIIGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2216:6220:25229  83      I       1701    14      49M1S   =       1663    -95     TAATCTACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTATTTTATG      GGGGIIIIIGGIGGIIIGIGGAIGIGIIIIIIIGGIIIGIIGGGGGGAGG      AS:i:98 XS:i:90 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:1113:16755:16657 81      I       1702    11      49M1S   XIV     415061  0       AATCTACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTTTTTTTTTG      IGG<GGGAAAAIGGAG<G.<<...<.<<...<..IIIIIGA.IGGG.GG<      AS:i:88 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:4
HISEQ:1007:HGV5NBCX3:1:2112:18005:41299 163     I       1707    11      50M     =       2074    417     ACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTATTTTATTTTGTTC      AAAAGAGGGIIIGGGGGGGIGIGGIIGGIIGGGGGGGGGGGGGGGIGIIG      AS:i:100        XS:i:92 XN:i:0  XM:i:0  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:2206:19349:73834 163     I       1707    33      50M     =       1842    185     ACGGTATTTATATCATCAAAAAAAAGTAGTTTTTTTATTTTATTTTGTTC      GGGGGIIIIIIGIIGGGGIIIIGIGIIIIIIIGGIIIIIIIIIGIIGIIG      AS:i:100        XS:i:70 XN:i:0  XM:i:0  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:2113:2817:14137  163     I       1730    14      50M     =       1859    179     AAGAAGTTTTTTTATTTTATTTTGTTCGTTAATTTTCAATGTCTATGGAA      GGAGGIIIIIIIIIIIIIIGIIIIIIIGIIIGGGGGIGGIIIIIIIIGII      AS:i:85 XS:i:93 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2
HISEQ:1007:HGV5NBCX3:1:2106:14749:35491 83      I       1730    1       49M1S   =       1663    -124    AAGTAGTTTTTTTATTTTATTTTGTTCTTTAATTTTTAATGTCTATGGAG      GIGGGIIGIIIIIIIIIIIIIIIIIGIIGGGGGIIIIIIIIIIIIGGGGG      AS:i:74 XS:i:82 XN:i:0  XM:i:3  XO:i:0  XG:i:0  NM:i:3
HISEQ:1007:HGV5NBCX3:1:2102:3746:13152  163     I       1744    1       1S49M   =       1940    247     TTTTTTTTTTGTTATTTAATTTTAAAGTTCTATGTAAGCCCGATCGTAAA      G#################################################      AS:i:66 XS:i:66 XN:i:0  XM:i:8  XO:i:0  XG:i:0  NM:i:8
HISEQ:1007:HGV5NBCX3:1:1204:4745:12269  163     I       1837    1       50M     =       1942    155     GGATAGAGCACTGGAGATGGCTGGCTTTAATCTGCTGGAGTACCATGGAA      AGGGAGGIGGGIGIGIGIIGIIGGGAGGIIIIGGGGIGIIIGIIIIIIII      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2206:19349:73834 83      I       1842    33      50M     =       1707    -185    GAGCACTGGAGATGGCTGGCTTTAATCTGCTGGAGTACCATGGAACACCG      IIIIGGIIIIIIGIGIGIIIIIIIIIIIGIIGIIIIIGGIIIIGGGGGGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2204:14658:11161 163     I       1849    1       50M     =       1945    146     GGAGATGGCTGGCTTTAATCTGCTGGAGTACCATGGAACACCGGTGATCA      GAGAGGGGIIA.GGGGIGIGGIGGGGGGGGGGGGGGGGGGGGGGAGGGIG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2113:2817:14137  83      I       1859    14      49M1S   =       1730    -179    GGCTTTAATCTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCAG      IIIGIIIIIIGIGAGIIIIIIIIIGIIIIIIIIIIIIIIIIIIGIGGGGG      AS:i:98 XS:i:98 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:2114:12240:15164 83      I       1867    11      50M     =       1673    -244    TCTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCACTTGGTCTG      GIIIIIGIGGIIIIIIGIIGIIIGIIIGIIIIIIGIGIIIIIIGGAGGGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:1115:5126:26256  163     I       1868    1       50M     =       2190    372     CTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCACTTGGTCTGG      GGGGGGIIIIIIIIIIIIGIIIIIGIGIIGIIIIIIGIIIGIIGGGIIGI      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2116:5000:45130  163     I       1868    11      50M     =       2190    372     CTGCTGGAGTACCATGGAACACCGGTGATCATTCTGGTCACTTGGTCTGG      AAGGGIIIGGGIIIIIGIIIIIIIIIIIIIIIIIIIIIIGIIIIIIIIII      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2102:3746:13152  83      I       1940    1       48M2S   =       1744    -247    GTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGCG      GG<.G<A.GGGGAAGGAGGA<<.<<.IGGGA<...AG<<...GGGAAAGG      AS:i:96 XS:i:96 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:1204:4745:12269  83      I       1942    1       49M1S   =       1837    -155    GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG      GGIGG.GIIGGAGIGGGGG<<GGAIGGGGGGGAGGAGAGGGAGGGAGGGG      AS:i:98 XS:i:98 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0
HISEQ:1007:HGV5NBCX3:1:2204:14658:11161 83      I       1945    1       50M     =       1849    -146    GTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTTCAG      GGGGGGIIGGGGGGGGGGGGGGGGGIGGIIIGGGGIIIGGIIGGGGGGGG      AS:i:100        XS:i:100        XN:i:0  XM:i:0  XO:i:0
HISEQ:1007:HGV5NBCX3:1:2112:18005:41299 83      I       2074    11      50M     =       1707    -417    GTTGACTCTTTCGTCAGATTGAGCTAGAGTGGTGGTTGCGGAAGCAGTAG      IGGIIIIIIIGIGGIGIGGIIGIIIIGGIIIIIIIIIIIIIIIIIGGGGG      AS:i:92 XS:i:100        XN:i:0  XM:i:1  XO:i:0  XG:i:0
HISEQ:1007:HGV5NBCX3:1:1114:8312:7074   163     I       2102    11      1S48M1S =       2335    284     GGTGGTGGTTGCAGAAGCAGTAGCAGCGATCGCAGCGACCCCAGACGCGC      .GGAG<..<GG#######################################      AS:i:80 XS:i:72 XN:i:0  XM:i:4  XO:i:0  XG:i:0  NM:i:4
HISEQ:1007:HGV5NBCX3:1:1115:5126:26256  83      I       2190    1       49M1S   =       1868    -372    GTGCTGATATAAGCTTAACAGGAAAGAAAAGAATAAAGACATATTCTCAG      GIIIIIIIGGGGIIIGIIIGIIIIGIIIIIIIIIIGIIIIIIIIIGGGGG      AS:i:90 XS:i:98 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:2116:5000:45130  83      I       2190    11      49M1S   =       1868    -372    GTGCTGATATAAGCTTAACAGGAAAGAAAAGAATAAAGACATATTCTCAG      IGIIIIGIIGGGIIIIIIIIIIIIIIGIIIIIIIGIGIIIIIGIIGGGGG      AS:i:91 XS:i:98 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:2209:15800:37695 163     I       2276    41      47M3S   =       2425    199     CCCTCATGGGTTGTTGCTATTTAAACGATCGCTGACTGGCACCAGTTTCT      GGGGGIIIIIIIIIIIIIIIGIIIIIIIGIIIIIIIIGIIIIIIIIIIGG      AS:i:94 XN:i:0  XM:i:0  XO:i:0  XG:i:0  NM:i:0  MD:Z:4
HISEQ:1007:HGV5NBCX3:1:1203:21227:75075 163     I       2291    41      49M1S   =       2527    279     GCTATTTAAACGATCGCTGACTGGCACCAGTTTCTCATCACATATTCTCC      GGGAGIGGGGIIIGGIGIIIIIIIGIGIGGGGIGGIIGGIIIGGGGAGGG      AS:i:82 XN:i:0  XM:i:2  XO:i:0  XG:i:0  NM:i:2  MD:Z:3
HISEQ:1007:HGV5NBCX3:1:1114:8312:7074   83      I       2335    11      47M3S   =       2102    -284    TTCTCCATATCTCATCTTTCACACAATCTCATTATCTCTATGGAGATCAG      ####G.GA<...A.IGIIGGG<<...<.GG.GAGG<..GG.G.<...<..      AS:i:89 XS:i:94 XN:i:0  XM:i:1  XO:i:0  XG:i:0  NM:i:1
HISEQ:1007:HGV5NBCX3:1:2209:15800:37695 83      I       2425    41      50M     =       2276    -199    ATGTGGAGTATTGTTTTATGGCACTCATGTGTATTCGTATGCGCAGAATG      IIIIIIGIIIIIIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIGGGGGG      AS:i:76 XS:i:100        XN:i:0  XM:i:3  XO:i:0  XG:i:0
```

We won't find any multimappers in here because, by default, `Bowtie 2` "\[looks\] for multiple alignments, \[reports\] best, with MAPQ"
- To see see what reads are multimappers, we have to run `Bowtie 2` with either the flag `-k <all>` or the flag `-a/--all`
```txt
      -k <int>  report up to <int> alns per read; MAPQ not meaningful
-a/--all        report all alignments; very slow, MAPQ not meaningful
```

<a id="more-thoughts-on-multimappers-2022-1109-1110-1115"></a>
#### More thoughts on multimappers (2022-1109-1110, 1115)
The work and thinking here builds on the notes under the heading ["Thoughts on the alignment metrics for `STAR`"](#thoughts-on-the-alignment-metrics-for-star)
- `#DONE` What does the [`Trinity` Google Group](https://groups.google.com/g/trinityrnaseq-users) have to say about multimappers?
    + `#ANSWER` Per Brian Haas at [this post](https://groups.google.com/g/trinityrnaseq-users/c/L4hypoWSk_o/m/bTO2L8ssAQAJ): "If reads are mapped to multiple genomic locations, then `Trinity` will use those reads as substrates for *de novo* assembly at each of the locations. This is important to do in the case of paralogs that share sequences in common."
        * However, here, he's talking about genome-guided assembly; is this also the case for non-genome-guided assembly?
            - ~~`#ANSWER` I would think so... What he says about potential paralogs seems like it holds true in this circumstance too~~
            - `#ANSWER` Actually, I don't think so: We would essentially be increasing the numbers of reads in our `.fastq` files: for example, our .bam files will contain multimappers after converting 
            - Actually, reach out to the `Trinity` Google group to ask about it
        * `#CONCLUSION` ***Don't*** keep the multimappers and ***don't*** use them in draft-free *de novo* assembly of the transcriptome; consider using them in genome-guided assembly `#TBD`

<a id="conversation-with-brian-haas-authormaintainer-of-trinity"></a>
##### Conversation with Brian Haas, author/maintainer of Trinity
[Message that I sent to the Trinity Google group (2022-1109)](https://groups.google.com/g/trinityrnaseq-users/c/DWctG7wLNYY/m/F4LmzJKyAQAJ):
```txt
Hi all,

I am preparing to do a non-genome-guided transcriptome assembly for S. cerevisiae with Trinity (our yeast model has high levels of gene expression in unannotated parts of the genome, so that's why we are doing transcriptome assembly with an otherwise well-annotated organism).

I am working with RNA-seq data that contain spike-in RNA from another yeast species. I filter this out by performing an initial alignment (with either Bowtie 2 or STAR) to a reference genome made up of S. cerevisiae and the other species. Using the resulting .bam file, I filter out alignments to the chromosomes of the other species. I also filter out unaligned reads (a relatively small percentage of reads: I wonder if I should just keep them in?). Then, I convert the filtered .bam (containing only S. cerevisiae alignments) to .fastq files (paired-end). I use these files as input to Trinity for non-genome-guided transcriptome assembly.

There are many multimappers (multiple alignments per read) in my data. Based on the information in this previous post to the Trinity Google group (Genome-guided Trinity - reads mapping to multiple loci?), I am curious to know if I should report and keep the multiple alignments per read, not filter them from my .bam file, and in turn have them present in the converted .fastq files. This is because, if I understand correctly, these reads can be "substrates for de novo assembly at each of the locations" where they map, at least in genome-guided assembly. In practice, this will add duplicates to the .fastq files, so will this have the same effect with non-genome-guided assembly?

What do you think? Any input will be greatly appreciated.

Thanks,
Kris

Link from above:
https://groups.google.com/g/trinityrnaseq-users/c/L4hypoWSk_o/m/bTO2L8ssAQAJ
```

[Response from Brian Haas](https://groups.google.com/g/trinityrnaseq-users/c/DWctG7wLNYY/m/RGn6ZH_fAQAJ), author/maintainer of `Trinity` (2022-1110):
```txt
Hi,

The genome-guided assembly should use the multimapped reads in their different read clusters (based on genomic location), but the full de novo won't... they'll get put into the same initial big bag of reads.

Based on your description, I'm not sure why you're not after doing the genome-guided de novo assembly. It seems like everything you're assembling is coming from alignments to the genome. The only reason this would not be a good idea is if you have unmapped reads that would provide more complete transcripts by incorporating them with the genome-aligned ones. The problem with the unmapped reads is that you wouldn't know which read clusters they should go into.

You could try something like this:
https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db

It's kind of a pain to run but can be worth it. It'll take both the genome-free and the genome-based de novo assemblies as input and should deal with the unmapped reads too (given the full de novo).

Hope this helps. Just write again if I missed something here.

Best,

~b
```

It seems that genome-guided *de novo* assembly is an approach that I must try, either exclusively or in addition to non-genome-guided assembly.

An interpretation: It is unusual to use the non-genome-guided assembly approach as described since my starting material are coming from alignments to the genome. I guess my thinking was/is to use the alignments in `.fastq`, ignoring the knowledge that they come from (because they are filtered via) alignments to the genome. If I decide to try non-genome-guided assembly, I should not include multimappers and, instead, include only (**a**) <u>alignments to *S. cerevisiae*</u> and (**b**) <u>unmapped reads</u>.

Perhaps I will set up an experiment to test (**a**) <u>genome-guided assembly using `PASA`</u> versus (**b**) <u>non-genome-guided assembly roughly following the approach of [McIlwain et al.](#mcilwain-et-al-hittinger-g3-2016)</u> (and this approach will also influence how I validate genome-guided assembly).

`#IMPORTANT` Include the materials at the link mentioned by Brian in the ["References for the experimental design/pipeline"](#references-for-the-experimental-designpipeline). Put your notes on the link materials up there too.

[My response and question](https://groups.google.com/g/trinityrnaseq-users/c/DWctG7wLNYY/m/sq6sV0biAwAJ) to Brian after having studied his suggestion and materials (see [above](#references-for-the-experimental-designpipeline); 2022-1110):
```txt
Thank you, yes, that helps, and I am studying up on what you suggested.

Just to be clear, to take advantage of multimapper information when running genome-guided Trinity, I should use as a bam infile in which all multimappers are retained (for example, from calling Bowtie 2 with the -k <int> flag to keep <int> number of alignments per read)—is that correct?

Best,
Kris
```

[His response](#references-for-the-experimental-designpipeline) (2022-1110):
```txt
The genome-guided mode leverages multimapped reads and the main benefit is that it uses the genome to inform how to group the reads into loci-based clusters, instead of having to do it genome-free based on kmer composition, etc.

For genome alignments, you'll want to use STAR or HISAT when using RNA-seq data as input.

Best,

~brian
```
He doesn't directly address the question, Should I use "a bam infile in which all multimappers are retained?" Answer seems to be yes, though.

<a id="material-on-multimappers-from-the-star-documentation"></a>
##### Material on multimappers from the `STAR` documentation
<a id="41-multimappers"></a>
###### 4.1 Multimappers.
The output of multimappers (i.e., reads mapping to multiple loci) is controlled by `--outFilterMultimapNmax N`. By default, `N=10`. If a read maps to *less than or equal to `N` loci*, it will be output; otherwise, it will be considered unmapped and reported as "Multimapping: mapped to too many loci" in the `Log.final.out` summary statistics file.

The detection of multimappers is controlled by `--winAnchorMultimapNmax` option, `=50` by default. <mark>This parameter should be set to at least the number of multimapping loci, i.e. `--winAnchorMultimapNmax` should be greater than or equal to  `--outFilterMultimapNmax`</mark>. Note that <mark>this parameter also controls the overall sensitivity of mapping</mark>: increasing it will change (improve) the mapping of unique mappers as well, though at the cost of slower speed.

<a id="521-multimappers"></a>
###### 5.2.1 Multimappers.
The number of loci `Nmap` a read maps to is given by `NH:i:Nmap` field. Value of 1 corresponds to unique mappers, while values >1 corresponds to multimappers. `HI` attributes enumerates multiple alignments of a read starting with 1 (this can be changed with the `--outSAMattrIHstart`; setting it to 0 may be required for compatibility with downstream software such as `Cufflinks`).

The mapping quality `MAPQ` (column 5) is `255` for uniquely mapping reads, and int(-10\*log10(1 - 1/`Nmap`)) for multi-mapping reads. This scheme is same as the one used by `TopHat` and is compatible with `Cufflinks`. The default `MAPQ=255` for the unique mappers may be changed with `--outSAMmapqUnique` parameter (integer 0 to 255) to ensure compatibility with downstream tools such as `GATK`.

For multimappers, all alignments except one are marked with `0x100` (secondary alignment) in the `FLAG` (column 2 of the SAM). <mark>The unmarked alignment is selected from the best ones (i.e., highest scoring)</mark>. This default behavior can be changed with the `--outSAMprimaryFlag AllBestScore` option, which will output all alignments with the best score as primary alignments (i.e., `0x100` bit in the `FLAG` unset).

By default, the order of the multi-mapping alignments for each read is not truly random. The `--outMultimapperOrder Random` option outputs multiple alignments for each read in random order, and also also randomizes the choice of the primary alignment from the highest scoring alignments. Parameter `--runRNGseed` can be used to set the random generator seed. With this option, the ordering of multi-mapping alignments of each read, and the choice of the primary alignment will vary from run to run, unless only one thread is used and the seed is kept constant.

The `--outSAMmultNmax` parameter limits the number of output alignments (SAM lines) for multimappers. For instance, --outSAMmultNmax 1 will output exactly one SAM line for each mapped read. Note that `NH:i:` tag in STAR will still report the actual number of loci that the reads map to, while the the number of reported alignments for a read in the SAM file is `min(NH,--outSAMmultNMax)`. If `--outSAMmultNmax` is equal to `-1`, all the alignments are output according to the order specified in the `--outMultimapperOrder` option. If `--outSAMmultNmax` is not equal to `-1`, then top-scoring alignments will always be output first, even for the default `--outMultimapperOrder Old 2.4` option.

<a id="mapping-parameters-used-in-teissandier-et-al-mobile-dna-2019"></a>
##### Mapping parameters used in [Teissandier et al., *Mobile DNA* 2019](https://mobilednajournal.biomedcentral.com/articles/10.1186/s13100-019-0192-1)
<a id="unique-mode"></a>
###### Unique mode
```bash
--runThreadN 4 \
--outSAMtype BAM SortedByCoordinate \
--runMode alignReads \
--outFilterMultimapNmax 1 \
--outFilterMismatchNmax 3 \
--alignEndsType EndToEnd \
--alignIntronMax 1 \
--alignMatesGapMax 350
```

<a id="random-mode"></a>
###### Random mode
```bash
--runThreadN 4 \
--outSAMtype BAM SortedByCoordinate \
--runMode alignReads \
--outFilterMultimapNmax 1000 \
--outSAMmultNmax 1 \
--outFilterMismatchNmax 3 \
--outMultimapperOrder Random \
--winAnchorMultimapNmax 1000 \
--alignEndsType EndToEnd \
--alignIntronMax 1 \
--alignMatesGapMax 350
```

<a id="multi-hit-mode"></a>
###### Multi-hit mode
```bash
--runThreadN 4 \
--outSAMtype BAM SortedByCoordinate \
--runMode alignReads \
--outFilterMultimapNmax 1000 \
--outFilterMismatchNmax 3 \
--outMultimapperOrder Random \
--winAnchorMultimapNmax 1000 \
--alignEndsType EndToEnd \
--alignIntronMax 1 \
--alignMatesGapMax 350
```

<a id="meaning-of-the-star-parameters-for-teissandier-styled-alignment"></a>
##### Meaning of the `STAR` parameters for Teissandier-styled alignment
```txt
--runThreadN
            option defines the number of threads to be used for genome generation, it has to
            be set to the number of available cores on the server node

            int: number of threads to run STAR

--outSAMtype BAM Unsorted
            output unsorted Aligned.out.bam file. The paired ends of an alignment are always
            adjacent, and multiple alignments of a read are adjacent as well; this ”unsorted”
            file can be directly used with downstream software such as HTseq, without the
            need of name sorting; the order of the reads will match that of the input
            FASTQ(A) files only if one thread is used --runThread 1, and --outFilterType
            --BySJout is not used

--outSAMtype BAM SortedByCoordinate
            output sorted by coordinate Aligned.sortedByCoord.out.bam file, similar to
            samtools sort command; if this option causes problems, it is recommended to
            reduce --outBAMsortingThreadN from the default 6 to lower values (as low as 1)

--outSAMtype BAM Unsorted SortedByCoordinate
            output both unsorted and sorted files

            default: SAM

            strings: type of SAM/BAM output
            
                1st word:
                    BAM
                        output of BAM without sorting
                    SAM
                        output of SAM without sorting 
                    None
                        no SAM/BAM output

                2nd, 3rd:
                    Unsorted
                        standard unsorted
                    SortedByCoordinate
                        sorted by coordinate; this option will allocate extra memory for
                        sorting which can be specified by --limitBAMsortRAM

--runMode alignReads
            default: alignReads

            string: type of the run

                alignReads
                    map reads
                genomeGenerate
                    generate genome files
                inputAlignmentsFromBAM
                    input alignments from BAM; presently only works with --outWigType and
                    --bamRemoveDuplicates options
                liftOver
                    lift-over of GTF files (-–sjdbGTFfile) between genome assemblies using
                    chain file(s) from -–genomeChainFiles
                soloCellFiltering </path/to/raw/count/dir/> </path/to/output/prefix>
                    STARsolo cell filtering (”calling”) without remapping, followed by the path
                    to raw count directory and output (filtered) prefix

--outFilterMultimapNmax
            max number of multiple alignments allowed for a read: if exceeded, the read is
            considered unmapped

            default: 10

            int: maximum number of loci the read is allowed to map to; alignments (all of
            them) will be output only if the read maps to no more loci than this value

--outSAMmultNmax
            default: -1
            
            int: max number of multiple alignments for a read that will be output to the
            SAM/BAM files; note that if this value is not equal to -1, the top scoring
            alignment will be output first
            
            all alignments (up to -–outFilterMultimapNmax) will be output

--outFilterMismatchNmax
            maximum number of mismatches per pair, large number switches off this filter

            default: 10

            int: alignment will be output only if it has no more mismatches than this value.

--outMultimapperOrder
            default: Old 2.4

            string: order of multimapping alignments in the output files

                Old_2.4
                    quasi-random order used before 2.5.0
                Random
                    random order of alignments for each multimapper; read mates (pairs) are
                    always adjacent, and all alignment for each read stay together; this
                    option will become default in the future releases

--winAnchorMultimapNmax
            default: 50

            int>0: max number of loci anchors are allowed to map to

--alignEndsType
            default: Local

            string: type of read ends alignment

                Local
                    standard local alignment with soft-clipping allowed
                EndToEnd
                    force end-to-end read alignment, do not soft-clip
                Extend5pOfRead1
                    fully extend only the 5p of the read1, all other ends: local alignment
                Extend5pOfReads12
                    fully extend only the 5p of the both read1 and read2, all other ends:
                    local alignment

--alignIntronMax 
            maximum intron length

            default: 0

            maximum intron size, if 0, max intron size will be determined by
            (2^winBinNbits)*winAnchorDistNbins

--alignMatesGapMax
            maximum genomic distance between mates

            default: 0

            maximum gap between two mates, if 0, max intron gap will be determined by
            (2^winBinNbits)*winAnchorDistNbins


#  Parameters related to '--outFilterMultimapNmax', --alignIntronMax, --alignMatesGapMax ------
--limitOutSAMoneReadBytes
            default: 100000

            int>0: max size of the SAM record (bytes) for one read. Recommended value:
            >(2*(LengthMate1+LengthMate2+100)*outFilterMultimapNmax

--outSJfilterIntronMaxVsReadN
            default: 50000 100000 200000

            N integers>=0: maximum gap allowed for junctions supported by 1,2,3,,,N reads

            i.e. by default junctions supported by 1 read can have gaps <=50000b, by 2 reads:
            <=100000b, by 3 reads: <=200000. by >=4 reads any gap <=alignIntronMax

            does not apply to annotated junctions

--winBinNbits
            default: 16
            
            int>0: =log2(winBin), where winBin is the size of the bin for the
            windows/clustering, each window will occupy an integer number of bins

--winAnchorDistNbins
            default: 9

            int>0: max number of bins between two anchors that allows aggregation of anchors
            into one window
```

<a id="how-we-called-star-previously-based-on-rna-star-post-not-retaining-multimappers-vs-multi-hit-mode"></a>
##### How we called `STAR` previously (based on ['rna-star' post](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c), not retaining multimappers) vs. multi-hit mode
<a id="previous-based-on-rna-star-post"></a>
###### Previous (based on ['rna-star' post](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c)):
```bash
STAR \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
```

<a id="multi-hit-mode-1"></a>
###### Multi-hit mode:
```bash
--runThreadN 4 \
--outSAMtype BAM SortedByCoordinate \
--runMode alignReads \
--outFilterMultimapNmax 1000 \
--outFilterMismatchNmax 3 \
--outMultimapperOrder Random \
--winAnchorMultimapNmax 1000 \
--alignEndsType EndToEnd \
--alignIntronMax 1 \
--alignMatesGapMax 350
```

<a id="going-through-the-parameters-making-comparisons-between-the-two-approaches"></a>
###### Going through the parameters, making comparisons between the two approaches:
```txt
--outFilterMultimapNmax
    # ---------------------------------------------------
             'rna-star' parameters  1
                    multi-hit mode  1000
    # ---------------------------------------------------
    maximum number of loci the read is allowed to map to; alignments (all of them) will be
    output only if the read maps to no more loci than this value; otherwise no alignments will
    be output, and the read will be counted as "mapped to too many loci" in the Log.final.out
    
    < format: int; default: 10 >


--alignSJoverhangMin
    # ---------------------------------------------------
             'rna-star' parameters  8
                    multi-hit mode  5 (default)
    # ---------------------------------------------------
    minimum overhang (i.e. block size) for spliced alignments

    < format: int>0; default: 5 >


--alignSJDBoverhangMin
    # ---------------------------------------------------
             'rna-star' parameters  1
                    multi-hit mode  3 (default)
    # ---------------------------------------------------
    minimum overhang (i.e., block size) for annotated (sjdb) spliced alignments
    
    < format: int>0; default: 3 >


--outFilterMismatchNmax
    # ---------------------------------------------------
             'rna-star' parameters  999
                    multi-hit mode  3
    # ---------------------------------------------------
    alignment will be output only if it has no more mismatches than this value
    
    < format: int; default: 10 >


--outMultimapperOrder
    # ---------------------------------------------------
             'rna-star' parameters  Old_2.4 (default)
                    multi-hit mode  Random
    # ---------------------------------------------------
    order of multimapping alignments in the output files

    < default: Old_2.4 >


--winAnchorMultimapNmax
    # ---------------------------------------------------
             'rna-star' parameters  50 (default)
                    multi-hit mode  1000*

    *(set to the same value as --outFilterMultimapNmax)
    # ---------------------------------------------------


--alignEndsType
    # ---------------------------------------------------
             'rna-star' parameters  Local* (default)
                    multi-hit mode  EndToEnd*

    *(Local: standard local alignment with soft-clipping allowed)
    *(EndToEnd: force end-to-end read alignment, do not soft-clip)
    # ---------------------------------------------------
    string: type of read ends alignment
        Local
            standard local alignment with soft-clipping allowed
        EndToEnd
            force end-to-end read alignment, do not soft-clip
        Extend5pOfRead1
            fully extend only the 5p of the read1, all other ends: local alignment
        Extend5pOfReads12
            fully extend only the 5p of the both read1 and read2, all other ends: local
            alignment

    < default: Local >


--alignIntronMin
    # ---------------------------------------------------
             'rna-star' parameters  4
                    multi-hit mode  21 (default)
    # ---------------------------------------------------
    minimum intron size: genomic gap is considered intron if its length>=alignIntronMin,
    otherwise it is considered Deletion

    < default: 21 >


--alignIntronMax
    # ---------------------------------------------------
             'rna-star' parameters  5000
                    multi-hit mode  0 (default)
    # ---------------------------------------------------
    maximum intron size, if 0, max intron size will be determined by
    (2^winBinNbits)*winAnchorDistNbins
    
    < default: 0 >


--alignMatesGapMax
    # ---------------------------------------------------
             'rna-star' parameters  5000
                    multi-hit mode  350
    # ---------------------------------------------------
    maximum gap between two mates, if 0, max intron gap will be determined by
    (2^winBinNbits)*winAnchorDistNbins
    
    < default: 0 >
```

<a id="assessing-the-ingredients"></a>
###### Assessing the "ingredients"
```txt
--outFilterMultimapNmax
    # ---------------------------------------------------
             'rna-star' parameters  1
                    multi-hit mode  1000
    # ---------------------------------------------------

--alignSJoverhangMin
    # ---------------------------------------------------
             'rna-star' parameters  8
                    multi-hit mode  5 (default)
    # ---------------------------------------------------

--alignSJDBoverhangMin
    # ---------------------------------------------------
             'rna-star' parameters  1
                    multi-hit mode  3 (default)
    # ---------------------------------------------------

--outFilterMismatchNmax
    # ---------------------------------------------------
             'rna-star' parameters  999
                    multi-hit mode  3
    # ---------------------------------------------------

--outMultimapperOrder
    # ---------------------------------------------------
             'rna-star' parameters  Old_2.4 (default)
                    multi-hit mode  Random
    # ---------------------------------------------------

--winAnchorMultimapNmax
    # ---------------------------------------------------
             'rna-star' parameters  50 (default)
                    multi-hit mode  1000*

    *(set to the same value as --outFilterMultimapNmax)
    # ---------------------------------------------------

--alignEndsType
    # ---------------------------------------------------
             'rna-star' parameters  Local* (default)
                    multi-hit mode  EndToEnd*

    *(Local: standard local alignment with soft-clipping allowed)
    *(EndToEnd: force end-to-end read alignment, do not soft-clip)
    # ---------------------------------------------------

--alignIntronMin
    # ---------------------------------------------------
             'rna-star' parameters  4
                    multi-hit mode  21 (default)
    # ---------------------------------------------------

--alignIntronMax
    # ---------------------------------------------------
             'rna-star' parameters  5000
                    multi-hit mode  0 (default)
    # ---------------------------------------------------

--alignMatesGapMax
    # ---------------------------------------------------
             'rna-star' parameters  5000
                    multi-hit mode  350
    # ---------------------------------------------------
```

<a id="how-we-should-call-star-taking-into-account-rna-star-and-multi-hit-mode-parameters"></a>
##### How we should call `STAR` taking into account 'rna-star' and multi-hit mode parameters
```bash
#  Combination of Teissandier et al. multi-hit mode and 'rna-star' parameters
#+ for aligning yeast paired-end reads to S. cerevisiae and/or a combined-
#+ reference genome made up of S. cerevisiae, K. lactis, and S20 references
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1000 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
```

<a id="how-are-other-groups-calling-star-with-s-cerevisiae"></a>
##### How are other groups calling `STAR` with *S. cerevisiae*?
One thing that is weird about [the 'rna-star' approach](https://groups.google.com/g/rna-star/c/hQeHTBbkc0c) is the very liberal allowance of mismatches: `--outFilterMismatchNmax 999`; why?

From the `STAR` manual: `int: alignment will be output only if its ratio of mismatches to mapped length is less than this value`; also, in the ENCODE RNA-seq mapping pipeline, `--outFilterMismatchNmax 999`; essentially, they don't want to filter out alignments (at least, at this stage) based on mismatches

I did a [Google search for "outFilterMismatchNmax yeast"](https://www.google.com/search?q=outFilterMismatchNmax+yeast&oq=outFilterMismatchNmax+yeast&aqs=chrome..69i57j33i160l2.1850j0j7&sourceid=chrome&ie=UTF-8) and found `STAR` parameters for *S. cerevisiae* in several publications:

<a id="dorfel-et-al-lyon-yeast-2017"></a>
###### [Dorfel et al. (Lyon), Yeast 2017](https://onlinelibrary.wiley.com/doi/full/10.1002/yea.3211)
**RNA-Seq**  
Total RNA was purified according to the RiboZero Gold Kit (Epicentre) and the RNA Clean and Concentration Kit (Zymo Resaearch). Libraries were generated, PCR amplified, purified using the Agencourt AMPure XP system (Beckman Coulter) and characterized on a high-sensitivity DNA assay (Agilent). The libraries were sequenced on the Illumina NextSeq platform in high-output mode, resulting in 76 single-end reads. For quality control, we used `FastQC (v0.11.3)` to generate diagnostic statistics of the data and used `Fastx (version 0.1)` to remove low-quality reads. Then we used `cutadapt (v1.7.1)` to identify and remove 3' adapter sequence (AGATCGGAAGAGCACACGTCT) from the reads, and clip the first base from the 5' end (options: `-O 6` `-m 25` `-n 1` `-e 0.15` `--cut 1`). `Bowtie (v1.1-1)` was used to identify and remove rRNA reads (option: `--seedlen = 23`). We used `STAR (v2.4.0j)` to align the RNA-Seq reads to the *S. cerevisiae* reference genome S288C (release R64-2-1) (options for `STAR`: `--outSAMstrandField intronMotif` `--outSAMunmapped Within` `--outFilterType BySJout` `--outFilterMultimapNmax 20` `--alignSJoverhangMin 8` `--alignSJDBoverhangMin 1` `--outFilterMismatchNmax 999` `--outFilterMismatchNoverLmax 0.04` `--alignIntronMin 0` `--alignIntronMax 5000` `--alignMatesGapMax 5000` `--outSAMattributes NH HI AS NM MD` `--outSAMtype BAM SortedByCoordinate` `--outFilterIntronMotifs RemoveNoncanonical`). `Cufflinks (v2.2.1)` was used to quantify RNA abundance at the gene level. We used `DESeq2` to perform differential expression analysis, comparing the following combinations: knock-out vs. wild type (WT), hNAA10 vs. WT, and hNAA10S37P vs. WT. Only genes with Benjamini–Hochberg-adjusted p-values <0.05 and log2 fold changes >1 or −1 are considered significantly differentially expressed. Telomeric regions are defined by taking the distal 40 kb regions of either end of the chromosomes.
```txt
--outSAMstrandField intronMotif \
--outSAMunmapped Within \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--outFilterMismatchNoverLmax 0.04 \
--alignIntronMin 0 \
--alignIntronMax 5000 \
--alignMatesGapMax 5000 \
--outSAMattributes NH HI AS NM MD \
--outSAMtype BAM SortedByCoordinate \
--outFilterIntronMotifs RemoveNoncanonical
```
```txt
My notes on the above: Above parameters are similar to the 'rna-star' parameters

         --outSAMstrandField  intronMotif; see pp. 13, 20, 35

     --outFilterType BySJout  reduces the number of "spurious" junctions; one of the options
                              used in the ENCODE RNA-seq pipeline; see p. 9 of STAR manual

                              manual, p. 42:
                               Normal  standard filtering using only current alignment
                              BySJout  keep only those reads that contain junctions that passed
                                       filtering into SJ.out.tab

--outFilterMismatchNoverLmax  real: alignment will be output only if its ratio of mismatches to
                              *mapped* length is less than or equal to this value <default:
                              0.3>

     --outFilterIntronMotifs  RemoveNoncanonical is recommended Cufflinks usage; more info on
                              pp. 43-44 of the STAR manual

          --outSAMattributes  NH HI AS NM MD
                          NH  number of loci the reads maps to: = 1 for unique mappers, > 1 for
                              multimappers; standard SAM tag
                          HI  multiple alignment index, starts with -–outSAMattrIHstart (= 1 by
                              default); standard SAM tag
                          AS  local alignment score, +1/ − 1 for matches/mismateches, score
                              penalties for indels and gaps; for PE reads, total score for two
                              mates; standard SAM tag
                          NM  edit distance to the reference (number of mismatched + inserted +
                              deleted bases) for each mate; standard SAM tag
                          MD  string encoding mismatched and deleted reference bases (see
                              standard SAM specifications); standard SAM tag
```
<a id="jensen-et-al-jensen-nat-comm-2022"></a>
###### [Jensen et al. (Jensen), *Nat Comm* 2022](https://www.nature.com/articles/s41467-022-33961-y)
**Transcriptome analysis**  
All the raw sequencing reads were trimmed using `Trimmomatic` (46) to filter sequencing adapters and low-quality reads. The clean reads were aligned against yeast reference genome using `STAR` (47) with the parameters: "`--outFilterMultimapNmax 100` `--alignSJoverhangMin 8` `--alignSJDBoverhangMin 1` `--outFilterMismatchNmax 999` `--alignIntronMax 5000` `--alignMatesGapMax 5000` `--outSAMtype BAM Unsorted`". The genome reference and gene annotations of *Saccharomyces cerevisiae* (R64-1-1) were obtained from Ensembl. We used `HTSeq-count` (48) to calculate raw counts for each yeast gene, with the parameter "`-s reverse`" to specify the strand information of reads. We applied the TMM (trimmed mean of M values) method (49) implemented in `edgeR` package to normalize gene expressions. The TMM normalized RPKM (Reads Per Kilobase of transcript, per Million mapped reads) values were further log2 transformed to generate heatmaps and other plots using `pheatmap` and `ggplot2` (50).
```txt
--outFilterMultimapNmax 100 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--alignIntronMax 5000 \
--alignMatesGapMax 5000 \
--outSAMtype BAM Unsorted
```

```txt
My notes on the above: Above parameters are similar to the 'rna-star' parameters
```
<a id="software-and-parameter-settings-used-by-onestoprnaseq-v100"></a>
###### [Software and parameter settings used by OneStopRNAseq v1.0.0](https://mccb.umassmed.edu/OneStopRNAseq/about.php)
`#NOTE` An interesting site; e.g., provides parameters for `rMATS`, `GSEA`, `deepTools bamCoverage`, etc.; keep an eye on this...
```bash
STAR \
    --runThreadN {threads} \
    --genomeDir {INDEX} \
    --sjdbGTFfile {gtf} \
    --readFilesCommand zcat \
    --readFilesIn {reads} \
    --outFileNamePrefix {name} \
    --outFilterType BySJout \
    --outMultimapperOrder Random \
    --outFilterMultimapNmax 200 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 3 \
    --outFilterMismatchNmax 999 \
    --outFilterMismatchNoverReadLmax 0.05 \
    --alignIntronMin 20 \
    --alignIntronMax 1000000 \
    --outFilterIntronMotifs RemoveNoncanonicalUnannotated \
    --outSAMstrandField None \
    --outSAMtype BAM Unsorted \
    --quantMode GeneCounts \
    --outReadsUnmapped Fastx
```
```txt
--outReadsUnmapped Fastx  outputs unmapped reads into separate file(s) Unmapped.out.mate1[2],
                          formatted the same way as input read files (i.e. FASTQ or FASTA); for
                          paired-end reads, if a read maps as a whole, but one of the mates
                          does not map, both mates will also be output in Unmapped.out.mate1/2
                          files; to indicate the mapping status of the read mates, the
                          following tags are appended to the read name:
                              00  mates were not mapped;
                              10  1st mate mapped, 2nd unmapped
                              01  1st mate unmapped, 2nd mapped
```
<a id="mendoza-et-al-sci-adv-2022"></a>
###### [Mendoza et al., *Sci Adv* 2022](https://www.science.org/doi/10.1126/sciadv.abj5688?url_ver=Z39.88-2003&rfr_id=ori:rid:crossref.org&rfr_dat=cr_pub%20%200pubmed)
**RNA-seq analysis**  
All RNA-seq data were prepared for analysis as follows. `NextSeq` sequencing data were demultiplexed using native applications on `BaseSpace`. Demultiplexed FASTQs were aligned by `RNA-STAR v.2.5.2` to the assembly `sacCer3` (parameters `--outFilterType BySJout` `--outFilterMultimapNmax 20` `--alignSJoverhangMin 8` `--alignSJDBoverhangMin 1` `--outFilterMismatchNmax 999` `--alignIntronMin 20` `--alignIntronMax 1000000`). Aligned reads were mapped to genomic features using `HTSeq v.0.6.1` after merging lanes of `NextSeq` (parameters `-r pos` `-s no` `-t exon` `-i gene_id`). Quantification, library size adjustment, and analysis of differential gene expression were done using DESeq2 and Wald’s test. Overlaps between lists of genes were tested for significance using a hypergeometric test (`phyper()` in R).
```txt
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--alignIntronMin 20 \
--alignIntronMax 1000000
```
<a id="velcro-ip-rna-seq-data-analysis-read-alignment-and-quantification"></a>
###### [VELCRO-IP RNA-seq Data Analysis: Read Alignment and Quantification](https://bio-protocol.org/exchange/minidetail?type=30&id=10130019&utm_source=miniprotocol)
First, for removal of adaptor sequences, low quality bases, and short reads, we use `cutadapt` (Martin, 2011) to trim Illumina adaptor sequences and < Q20 bases. Reads < 40 nt were removed. Parameters: `cutadapt` `-m 40` `-a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC` `-A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT` `–nextseq-trim=20`. Next, for UMI extraction, we used `umi_tools` (Smith et al., 2017) to extract the UMI region (first 8 bases). Parameters: `umi_tools` `extract` `-–bc-pattern=NNNNNNNN` `-–bc-pattern2=NNNNNNNN`. We additionally remove 1 base from 5' end of the reads, which is the A/T nucleotide overhang from the ligation reaction during library preparation. For splice-aware alignment using `STAR` (Dobin et al., 2013), we used `STAR` to align the reads to a reference genome/transcriptome. `STAR` reference is built using a combination of yeast genome (sacCer3), mouse genome (mm10), mouse rDNA sequence (GenBank: GU372691), and mouse transcript annotations (GENCODE vM18). Only uniquely mapped reads were retained. Parameters: `STAR` `--sjdbOverhang 66` `--outFilterMultimapNmax 1` `--alignEndsType EndToEnd` `--alignIntronMax 1000000` `--alignMatesGapMax 1000000` `--alignIntronMin 20` `--outFilterMismatchNmax 999` `--alignSJDBoverhangMin 1` `--alignSJoverhangMin 8` `--outFilterType BySJout`. While the majority of the reads mapped to yeast mRNAs that we believe reflect background binding from the initial ribosome-IP (~20 million reads), 1–3% mapped to mouse mRNAs which corresponds to ~500,000 reads per sample. For deduplication using UMI, we used `umi_tools` to deduplicate the alignments. Deduplicated alignments are re-aligned using `STAR` and the same parameters as before. Parameters: `umi_tools` `dedup` `-–paired` `-–buffer-whole-contig`. For read quantification, we used `bedtools` (Quinlan and Hall, 2010) to count alignments over 200 nt sliding windows with step size of 100 nt across mouse genome.

<a id="osman-et-al-cramer-jbc-202100523-8pdf"></a>
###### [Osman et al. (Cramer), *JBC* 2021](https://www.jbc.org/article/S0021-9258(21)00523-8/pdf)
**4tU-seq and bioinformatics analysis**  
... Cultures were then divided into four smaller cultures of 40 ml each and treated with either 1-NA-PP1 (40 mM in DMSO) to a final concentration of 6μM (two replicates), or an equal volume of DMSO (two replicates), and incubated for 12 min, followed by 5 min of 4tU labeling. 4tU labeling and subsequent extraction of labeled RNA was performed as described (82). For the heat shock experiment, a 300 ml culture was grown in the same way. The culture was then divided into two 140 ml cultures, to which either 1-NA-PP1 or DMSO was added in the same way as described for the steady-state growth experiment and incubated for 12 min. About 100 ml from each culture was diluted with 100 ml of 37 C warm media to exert heat shock. About 80 ml were extracted after 12 min of heat shock and labeled with 4tU for 5 min. The entire experiment was carried out in the same way twice to obtain two replicates. 4tU-Seq data analysis was performed (82) but with minor modifications. Briefly, the raw `fastq` files of paired-end 75 base reads (for steady-state experiment) and 42 base reads (for heat shock experiment) with additional six base reads of barcodes were obtained for each of the samples. Reads were demultiplexed, and low-quality bases (\<Q20) removed using `Cutadapt (version 1.9.1)` with parameters `−q 20,20 −o 12 −m 25` (83). Reads were then mapped to the *S. cerevisiae* genome (sacCer3, version 64.2.1) using `STAR 2.5.2b` (84) with parameters `--outFilterMismatchNmax 2 --outFilterMultimapScoreRange 0`. `Samtools` (85) was used to quality filter SAM files. Alignments with `MAPQ` smaller than 7 (`−q 7`) were skipped, and only proper pairs (`−f 2`) were selected. We used a spike-in (RNAs) normalization strategy (86) to allow for observation of global changes in the 4tU-Seq signal. Sequencing depth from spike-in RNAs was calculated for each sample j according to 

*(see calculation in `.pdf` file)*

with read counts *k_ij* for the labeled spike-ins *i* in sample *j* and *l_i* for the length of labeled spike-ins *i* for the 4tU-seq samples.

<a id="run-star-alignment-retaining-multimappers-2022-1115-1116"></a>
#### Run `STAR` alignment, retaining multimappers (2022-1115-1116)
`#DEKHO`
```bash
#!/bin/bash
#DONTRUN

#  grabnode has been called with default/lowest settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"
mkdir -p exp_alignment_STAR_multi-hit/files_bams

#  Find and list .fastq files; designate the 'prefix' and other variables
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type l \
        -name *578*merged*.fastq \
        -print0 \
            | sort -z \
)
#  Some checks...
for i in "${infiles[@]}"; do echo "${i}"; done && echo ""
for i in "${infiles[@]}"; do echo "$(basename "${i}")"; done && echo
for i in "${infiles[@]}"; do echo "$(basename "${i%_R?.fastq}")"; done && echo ""

echo "${infiles[0]}" && echo ""
echo "${infiles[1]}" && echo ""
echo "$(basename "${infiles[0]%_R?.fastq}")" && echo ""

read_1="${infiles[0]}"
read_2="${infiles[1]}"
prefix="./exp_alignment_STAR_multi-hit/files_bams/$(basename "${read_1%_R?.fastq}")"
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"

echo "${genome_dir}"
echo "${read_1}"
echo "${read_2}"
echo "${prefix}"
#NOTE #REMEMBER "IP" = Nascent, "IN" = SteadyState

#  Run the alignment
if [[ -f "./submit-STAR-alignReads-multi-hit.sh" ]]; then
    rm "./submit-STAR-alignReads-multi-hit.sh"
fi

cat << script > "./submit-STAR-alignReads-multi-hit.sh"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-STAR-alignReads-multi-hit.sh
#  KA

module load STAR/2.7.9a-GCC-11.2.0

genome_dir="\${1}"
read_1="\${2}"
read_2="\${3}"
prefix="\${4}"

STAR \\
    --runMode alignReads \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMtype BAM SortedByCoordinate \\
    --outSAMunmapped Within \\
    --genomeDir "\${genome_dir}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax 1000 \\
    --winAnchorMultimapNmax 1000 \\
    --alignSJoverhangMin 8 \\
    --alignSJDBoverhangMin 1 \\
    --outFilterMismatchNmax 999 \\
    --outMultimapperOrder Random \\
    --alignEndsType EndToEnd \\
    --alignIntronMin 4 \\
    --alignIntronMax 5000 \\
    --alignMatesGapMax 5000
script

sbatch submit-STAR-alignReads-multi-hit.sh \
    "${genome_dir}" \
    "${read_1}" \
    "${read_2}" \
    "${prefix}"
```

<a id="alignment-metrics-for-the-test-run-of-star-multi-hit-mode"></a>
##### Alignment metrics for the test run of `STAR` (multi-hit mode)
```txt
                                 Started job on |       Nov 16 12:34:59
                             Started mapping on |       Nov 16 12:35:03
                                    Finished on |       Nov 16 12:37:27
       Mapping speed, Million of reads per hour |       349.72

                          Number of input reads |       13988842
                      Average input read length |       100
                                    UNIQUE READS:
                   Uniquely mapped reads number |       8547569
                        Uniquely mapped reads % |       61.10%
                          Average mapped length |       99.99
                       Number of splices: Total |       356914
            Number of splices: Annotated (sjdb) |       288451
                       Number of splices: GT/AG |       321878
                       Number of splices: GC/AG |       238
                       Number of splices: AT/AC |       2360
               Number of splices: Non-canonical |       32438
                      Mismatch rate per base, % |       1.87%
                         Deletion rate per base |       0.01%
                        Deletion average length |       1.21
                        Insertion rate per base |       0.01%
                       Insertion average length |       1.25
                             MULTI-MAPPING READS:
        Number of reads mapped to multiple loci |       5012911
             % of reads mapped to multiple loci |       35.84%
        Number of reads mapped to too many loci |       5
             % of reads mapped to too many loci |       0.00%
                                  UNMAPPED READS:
  Number of reads unmapped: too many mismatches |       0
       % of reads unmapped: too many mismatches |       0.00%
            Number of reads unmapped: too short |       419109
                 % of reads unmapped: too short |       3.00%
                Number of reads unmapped: other |       9248
                     % of reads unmapped: other |       0.07%
                                  CHIMERIC READS:
                       Number of chimeric reads |       0
                            % of chimeric reads |       0.00%
```
Click [here](#alignment-metrics-for-the-test-run-of-star) for alignment metrics for the previous test run of `STAR` (['rna-star' parameters](#alignment-metrics-for-the-test-run-of-star))

<a id="thoughts-on-the-alignment-metrics-for-star-multi-hit-mode"></a>
###### Thoughts on the alignment metrics for `STAR` (multi-hit mode)
- Interesting how, even with `--outFilterMultimapNmax 1000` and `--winAnchorMultimapNmax 1000`, there are still 5 reads for `Number of reads mapped to too many loci`
- On `Number of reads unmapped: too short`, a [comment from Alex Dobin](https://github.com/alexdobin/STAR/issues/164#issuecomment-226828834), author of `STAR`: '"too short" literally means "alignment too short".'
- On `...`, another [comment from Dobin](https://github.com/alexdobin/STAR/issues/506#issuecomment-432274359): 'The unmapped-other indeed means unmapped for reasons other than "too short" or "too many mismatches". Most commonly in this category, `STAR` cannot find good seeds, i.e., all seeds map too many times (50 by default), which can also be thought of as all seeds being too short. This may be caused by reads coming from highly repetitive regions of the genomes, but also can be caused by contamination with unrelated species.'

Click [here](#thoughts-on-the-alignment-metrics-for-star) for thoughts and comments from the previous test run of `STAR` (['rna-star' parameters](#alignment-metrics-for-the-test-run-of-star))

<a id="examine-the-flags-in-the-bam-outfile-from-the-test-run-of-star-multi-hit-mode"></a>
###### Examine the flags in the `.bam` outfile from the test run of `STAR` (multi-hit mode)
Use `samtools flagstat` and the bespoke function `list_tally_flags`:
```bash
#!/bin/bash
#DONTRUN

#  grabnode has been called with default/lowest settings; samtools is loaded
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

module load SAMtools/1.16.1-GCC-11.2.0

samtools flagstat \
    ./exp_alignment_STAR_multi-hit/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    > ./exp_alignment_STAR_multi-hit/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt

less ./exp_alignment_STAR_multi-hit/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.flagstat.txt
# 27446606 + 531078 primary
# 75080564 + 923976 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 101853252 + 1272248 mapped (99.34% : 87.44%)
# 26772688 + 348272 primary mapped (97.54% : 65.58%)
# 27446606 + 531078 paired in sequencing
# 13723303 + 265539 read1
# 13723303 + 265539 read2
# 26772688 + 348272 properly paired (97.54% : 65.58%)
# 26772688 + 348272 with itself and mate mapped
# 0 + 0 singletons (0.00% : 0.00%)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)
echo $(( 27446606 + 531078 ))  # 27977684

cd ./exp_alignment_STAR_multi-hit/files_bams

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags 5781_G1_IN_mergedAligned.sortedByCoord.out.bam

#  Numbers of records in the .bam file
samtools view -c \
    5781_G1_IN_mergedAligned.sortedByCoord.out.bam
# 103982224 (27977684 fr/initial test ('rna-star' parameters))

#  Numbers of records in the *_R{1,2}.fastq files
cd ..
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq | wc -l)/4 | bc
# 13988842
echo $(cat ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq | wc -l)/4 | bc
# 13988842

echo $(( 13988842 + 13988842 ))
# 27977684

#  The numbers of records in the .bam and .fastq files are equivalent
```

Contents of outfile from running `list_tally_flags` (including some format edits and notes from me)...
```txt
19948030    419    not primary alignment 
19948030    339    not primary alignment 
17592252    403    not primary alignment
17592252    355    not primary alignment
 7217590    83     primary alignment
 7217590    163    primary alignment
 6168754    99     primary alignment
 6168754    147    primary alignment
  336959    77     unmapped (read, mate)
  336959    141    unmapped (read, mate)
  248080    931    not primary alignment    read fails
  248080    851    not primary alignment    read fails
  213908    915    not primary alignment    read fails
  213908    867    not primary alignment    read fails
   94722    675    read fails
   94722    595    read fails
   91403    653    unmapped (read, mate)    read fails
   91403    589    unmapped (read, mate)    read fails
   79414    659    read fails
   79414    611    read fails
```
What are the meanings of these flags? Use [this tool](https://broadinstitute.github.io/picard/explain-flags.html) to check:
| flag | meaning                                                                                                                     |
| :--- | :-------------------------------------------------------------------------------------------------------------------------- |
| 419  | 0x1, read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80), not primary alignment (0x100)     |
| 339  | 0x1, read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40), not primary alignment (0x100)      |
| 403  | 0x1, read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80), not primary alignment (0x100)     |
| 355  | 0x1, read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40), not primary alignment (0x100)      |
| 83   | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40)                       |
| 163  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80)                      |
| 99   | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40)                       |
| 147  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80)                      |
| 77   | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40)                                           |
| 141  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80)                                          |
| 931  | 0x1, 0x2, mate reverse strand (0x20), second in pair (0x80), not primary alignment (0x100), read fails* (0x200)             |
| 851  | 0x1, 0x2, read reverse strand (0x10), first in pair (0x40), not primary alignment (0x100), read fails* (0x200)              |
| 915  | 0x1, 0x2, read reverse strand (0x10), second in pair (0x80), not primary alignment (0x100), read fails* (0x200)             |
| 867  | 0x1, 0x2, mate reverse strand (0x20), first in pair (0x40), not primary alignment (0x100), read fails* (0x200)              |
| 675  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), second in pair (0x80), read fails* (0x200) |
| 595  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), first in pair (0x40), read fails* (0x200)  |
| 653  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), second in pair (0x80), read fails* (0x200)                     |
| 589  | read paired (0x1), read unmapped (0x4), mate unmapped (0x8), first in pair (0x40), read fails* (0x200)                      |
| 659  | read paired (0x1), read mapped in proper pair (0x2), read reverse strand (0x10), second in pair (0x80), read fails* (0x200) |
| 611  | read paired (0x1), read mapped in proper pair (0x2), mate reverse strand (0x20), first in pair (0x40), read fails* (0x200)  |

<br />    

Click [here](#thoughts-on-the-alignment-metrics-for-star) for thoughts and comments from the previous test run of `STAR` (['rna-star' parameters](#examine-the-flags-in-the-bam-outfile-from-the-test-run-of-star-multi-hit-mode))

Also, a little bit of cleanup
```bash
#!/bin/bash
#DONTRUN

#  grabnode has been called with default/lowest settings; samtools is loaded
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101"

ls -lhaFG
total 1.9M
# drwxrws--- 10 kalavatt  967 Nov 17 12:41 ./
# drwxrws---  7 kalavatt  135 Nov 17 12:38 ../
# -rw-rw----  1 kalavatt    0 Nov 16 12:34 4016030.err.txt
# -rw-rw----  1 kalavatt  986 Nov 16 12:37 4016030.out.txt
# drwxrws---  3 kalavatt  160 Nov  9 15:23 exp_alignment_Bowtie_2/
# drwxrws---  3 kalavatt  150 Nov 16 16:13 exp_alignment_STAR/
# drwxrws---  3 kalavatt   84 Nov 16 16:12 exp_alignment_STAR_multi-hit/
# drwxrws---  2 kalavatt 1.1K Nov  7 15:27 exp_FastQC/
# drwxrws---  2 kalavatt  854 Nov  7 14:31 exp_picardmetrics/
# drwxrws---  3 kalavatt  317 Nov  7 14:44 exp_Trinity/
# drwxrws---  3 kalavatt  720 Nov  8 10:03 files_fastq_symlinks/
# -rw-rw----  1 kalavatt  14K Nov 16 12:23 notes-Alison-files-locations.md
# -rw-rw----  1 kalavatt  29K Nov 16 12:23 notes-Alison-papers.md
# -rw-rw----  1 kalavatt 1.3K Nov 16 12:23 notes-Alison-RNA-seq-kits.md
# -rw-rw----  1 kalavatt 6.6K Nov 17 09:27 notes-miscellaneous-links.md
# -rw-rw----  1 kalavatt 5.7K Nov 16 12:23 notes-RNA-seq-spike-ins.md
# -rw-rw----  1 kalavatt  35K Nov 16 12:23 notes-UMIs-etc.md
# drwxrws---  2 kalavatt   26 Nov 10 12:33 readme/
# -rw-rw----  1 kalavatt  617 Nov  8 14:43 submit-Bowtie-2.test-1.sh
# -rw-rw----  1 kalavatt  642 Nov  8 16:16 submit-Bowtie-2.test-2.sh
# -rw-rw----  1 kalavatt  300 Nov  7 14:58 submit-FastQC.sh
# -rw-rw----  1 kalavatt  871 Nov 16 12:34 submit-STAR-alignReads-multi-hit.sh
# -rw-rw----  1 kalavatt  694 Nov  3 17:41 submit-Trinity.sh
# -rw-rw----  1 kalavatt  23K Nov 16 12:23 work-TPM-calculation.md
# -rw-rw----  1 kalavatt 236K Nov 17 12:47 work-Trinity.md

#  Move SLURM stdout and stderr to the appropriate directory
mv 4016030.* ./exp_alignment_STAR_multi-hit/
```

<a id="writing-and-testing-split_bam_by_speciessh"></a>
#### Writing and testing `split_bam_by_species.sh`
`#DEKHO`
<a id="use-split_bam_by_speciessh-to-get-vii-and-k-lactis-chromosomes-from-bam-files-2022-1116"></a>
##### Use `split_bam_by_species.sh` to get VII and *K. lactis* chromosomes from `.bam` files (2022-1116)
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction"

module load SAMtools/1.16.1-GCC-11.2.0

samtools index \
    ./results/2022-1101/exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam

bash bin/split_bam_by_species.sh
# Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
# and 20 S narnavirus, and split them into distinct .bam files for each species,
# with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
# including chromosome M, all S. cerevisiae including chromosome M, and S.
# cerevisiae chromosome M only.
#
# Names of chromosomes in .bam infiles must be in the following format:
#   - S. cerevisiae
#     - I
#     - II
#     - III
#     - IV
#     - V
#     - VI
#     - VII
#     - VIII
#     - IX
#     - X
#     - XI
#     - XII
#     - XIII
#     - XIV
#     - XV
#     - XVI
#
#   - K. lactis
#     - A
#     - B
#     - C
#     - D
#     - E
#
#   - 20 S narnavirus
#     - 20S
#
# The split .bam files are saved to a user-defined out directory.
#
# Dependencies:
#   - samtools >= 1.9
#
# Arguments:
#   -h  print this help message and exit
#   -u  use safe mode: "TRUE" or "FALSE" <lgl; default: FALSE>
#   -i  infile, including path <chr>
#   -o  outfile directory, including path; if not found, will be mkdir'd <chr>
#   -s  what to split out; options: SC_all, SC_no_Mito, SC_VII, SC_XII,
#       SC_VII_XII, SC_Mito, KL_all, virus_20S <chr; default: SC_all>
#   -t  number of threads <int >= 1>

bash bin/split_bam_by_species.sh \
    -u TRUE \
    -i ./results/2022-1101/exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    -o ./results/2022-1101/exp_alignment_STAR/files_bams \
    -s SC_VII \
    -t 1

bash bin/split_bam_by_species.sh \
    -u FALSE \
    -i ./results/2022-1101/exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    -o ./results/2022-1101/exp_alignment_STAR/files_bams \
    -s KL_all \
    -t 1

cd ./results/2022-1101/exp_alignment_STAR/files_bams

samtools view -h \
    5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_VII.bam \
        | less

samtools view -h \
    5781_G1_IN_mergedAligned.sortedByCoord.out.split_KL_all.bam \
        | less

#  It works!

#TODO 1/2 Need to write the script so that it inherits the environment from
#TODO 2/2 which it was called
```

<a id="having-updated-and-function-ized-split_bam_by_speciessh-test-it-2022-1117"></a>
##### Having updated and "function-ized" `split_bam_by_species.sh`, test it (2022-1117)
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/"

module load SAMtools/1.16.1-GCC-11.2.0

dir_abbrev="./exp_alignment_STAR/files_bams"
if [[ ! -f "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai" ]]; then
    samtools index "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam"
fi

bash ../../bin/split_bam_by_species.sh
# split_bam_by_species.sh
# -----------------------
# Take user-input .bam files containing alignments to S. cerevisiae, K. lactis,
# and 20 S narnavirus, and split them into distinct .bam files for each species,
# with three splits for S. cerevisiae: all S. cerevisiae chromosomes not
# including chromosome M, all S. cerevisiae including chromosome M, and S.
# cerevisiae chromosome M only.
#
# Names of chromosomes in .bam infiles must be in the following format:
#   - S. cerevisiae (SC)
#     - I
#     - II
#     - III
#     - IV
#     - V
#     - VI
#     - VII
#     - VIII
#     - IX
#     - X
#     - XI
#     - XII
#     - XIII
#     - XIV
#     - XV
#     - XVI
#     - Mito
#
#   - K. lactis (KL)
#     - A
#     - B
#     - C
#     - D
#     - E
#
#   - 20 S narnavirus
#     - 20S
#
# The split .bam files are saved to a user-defined out directory.
#
# Dependencies:
#   - samtools >= #TBD
#
# Arguments:
#   -h  print this help message and exit
#   -u  use safe mode: "TRUE" or "FALSE" <lgl; default: FALSE>
#   -i  infile, including path <chr>
#   -o  outfile directory, including path; if not found, will be mkdir'd <chr>
#   -s  what to split out; options: SC_all, SC_no_Mito, SC_VII, SC_XII,
#       SC_VII_XII, SC_Mito, KL_all, virus_20S <chr; default: SC_all>
#
#             SC_all  return all SC chromosomes, including Mito (default)
#         SC_no_Mito  return all SC chromosomes, excluding Mito
#             SC_VII  return only SC chromosome VII
#             SC_XII  return only SC chromosome XII
#         SC_VII_XII  return only SC chromosomes VII and XII
#            SC_Mito  return only SC chromosome Mito
#             KL_all  return all KL chromosomes
#          virus_20S  return only 20 S narnavirus
#
#   -t  number of threads <int >= 1; default: 1>

if [[ -f "./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_VII_XII.bam" ]]; then
    rm "./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_VII_XII.bam"
fi

bash ../../bin/split_bam_by_species.sh \
    -u TRUE \
    -i ${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    -o ${dir_abbrev} \
    -s SC_VII_XII \
    -t 1

#  It works!
```

Safe mode: Information printed to screen
<details>
<summary><i>Click here to expand</i></summary>

```txt
Running ../../bin/split_bam_by_species.sh...
-u: "Safe mode" is TRUE.
+ check_exists_file ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam
+ what='
    check_exists_file()
    -------------------
    Check that a file exists; exit if it doesn'\''t

    :param 1: file, including path <chr>
    :return: NA
    '
+ [[ -z ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam ]]
+ [[ ! -f ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam ]]
+ :
+ check_exists_directory TRUE ./exp_alignment_STAR/files_bams
+ what='
    check_exists_directory()
    ------------------------
    Check that a directory exists; if it doesn'\''t, then either make it or exit

    :param 1: create directory if not found: TRUE or FALSE
              <lgl; default: FALSE>
    :param 2: directory, including path <chr>
    '
+ case "$(convert_chr_lower "${1}")" in
++ convert_chr_lower TRUE
++ what='
    convert_chr_lower()
    -----------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
++ [[ -z TRUE ]]
++ string_in=TRUE
+++ tr '[:upper:]' '[:lower:]'
+++ printf %s TRUE
++ string_out=true
++ echo true
+ [[ -f ./exp_alignment_STAR/files_bams ]]
+ printf '%s\n' './exp_alignment_STAR/files_bams doesn'\''t exist; mkdir'\''ing it.'
./exp_alignment_STAR/files_bams doesn't exist; mkdir'ing it.
+ mkdir -p ./exp_alignment_STAR/files_bams
+ case "$(echo "${split}" | tr '[:upper:]' '[:lower:]')" in
++ tr '[:upper:]' '[:lower:]'
++ echo SC_VII_XII
+ :
+ echo ''

++ basename ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam
+ base=5781_G1_IN_mergedAligned.sortedByCoord.out.bam
+ name=5781_G1_IN_mergedAligned.sortedByCoord.out
+ SC_all=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_all.bam
+ SC_no_Mito=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_no_Mito.bam
+ SC_VII=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_VII.bam
+ SC_XII=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_XII.bam
+ SC_VII_XII=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_VII_XII.bam
+ SC_Mito=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_Mito.bam
+ KL_all=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_KL_all.bam
+ virus_20S=./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_20S.bam
+++ convert_chr_lower SC_VII_XII
+++ what='
    convert_chr_lower()
    -----------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
+++ [[ -z SC_VII_XII ]]
+++ string_in=SC_VII_XII
++++ tr '[:upper:]' '[:lower:]'
++++ printf %s SC_VII_XII
+++ string_out=sc_vii_xii
+++ echo sc_vii_xii
++ echo sc_vii_xii
+ [[ sc_vii_xii == \s\c\_\a\l\l ]]
+++ convert_chr_lower SC_VII_XII
+++ what='
    convert_chr_lower()
    -----------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
+++ [[ -z SC_VII_XII ]]
+++ string_in=SC_VII_XII
++++ tr '[:upper:]' '[:lower:]'
++++ printf %s SC_VII_XII
+++ string_out=sc_vii_xii
+++ echo sc_vii_xii
++ echo sc_vii_xii
+ [[ sc_vii_xii == \s\c\_\n\o\_\m\i\t\o ]]
+++ convert_chr_lower SC_VII_XII
+++ what='
    convert_chr_lower()
    -----------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
+++ [[ -z SC_VII_XII ]]
+++ string_in=SC_VII_XII
++++ tr '[:upper:]' '[:lower:]'
++++ printf %s SC_VII_XII
+++ string_out=sc_vii_xii
+++ echo sc_vii_xii
++ echo sc_vii_xii
+ [[ sc_vii_xii == \s\c\_\v\i\i ]]
+++ convert_chr_lower SC_VII_XII
+++ what='
    convert_chr_lower()
    -----------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
+++ [[ -z SC_VII_XII ]]
+++ string_in=SC_VII_XII
++++ tr '[:upper:]' '[:lower:]'
++++ printf %s SC_VII_XII
+++ string_out=sc_vii_xii
+++ echo sc_vii_xii
++ echo sc_vii_xii
+ [[ sc_vii_xii == \s\c\_\x\i\i ]]
+++ convert_chr_lower SC_VII_XII
+++ what='
    convert_chr_lower()
    -----------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
+++ [[ -z SC_VII_XII ]]
+++ string_in=SC_VII_XII
++++ tr '[:upper:]' '[:lower:]'
++++ printf %s SC_VII_XII
+++ string_out=sc_vii_xii
+++ echo sc_vii_xii
++ echo sc_vii_xii
+ [[ sc_vii_xii == \s\c\_\v\i\i\_\x\i\i ]]
+ chr='VII XII'
+ split_with_samtools 1 ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam 'VII XII' ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_all.bam
+ what='
    split_with_samtools()
    ---------------------
    Use samtools to filter a bam file such that it contains only chromosome(s)
    specified with ../../bin/split_bam_by_species.sh argument -s

    :param 1: threads <int >= 1>
    :param 2: bam infile, including path <chr>
    :param 3: chromosomes to retain <chr>
    :param 4: bam outfile, including path <chr>
    :return: :param 2: filtered to include only :param 3: in :param 4:
    '
+ samtools view -@ 1 -h ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam VII XII -o ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.split_SC_all.bam
```
</details>

What does the output look like when running the script with `-u FALSE`?
```bash
#!/bin/bash
#DONTRUN

if [[ -f "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.split_KL_all.bam" ]]; then
    rm "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.split_KL_all.bam"
fi

bash ../../bin/split_bam_by_species.sh \
    -u FALSE \
    -i ${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam \
    -o ${dir_abbrev} \
    -s KL_all \
    -t 1
```

<a id="writing-and-testing-exclude_bam_reads-unmappedsh-2022-1117"></a>
#### Writing and testing `exclude_bam_reads-unmapped.sh` (2022-1117)
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest/default settings
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1101/"

module load SAMtools/1.16.1-GCC-11.2.0

dir_abbrev="./exp_alignment_STAR/files_bams"
if [[ ! -f "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam.bai" ]]; then
    samtools index "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam"
fi

bash ../../bin/exclude_bam_reads-unmapped.sh
# exclude_bam_alignments-unmapped.sh
# ----------------------------------
# Exclude unmapped alignments from bam infile. Name of bam outfile will be
# derived from the infile.
#
# Dependencies:
#   - samtools >= #TBD
#
# Arguments:
#   -h  print this help message and exit
#   -u  use safe mode: "TRUE" or "FALSE" <lgl; default: FALSE>
#   -i  bam infile, including path <chr>
#   -o  outfile directory, including path; if not found, will be mkdir'd <chr>
#   -f  run samtools flagstat on bams: "TRUE" or "FALSE" <lgl>
#   -t  number of threads <int >= 1; default: 1>

bash ../../bin/exclude_bam_reads-unmapped.sh \
    -u TRUE \
    -i "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam" \
    -o "${dir_abbrev}" \
    -f FALSE \
    -t 1
```

Text printed to terminal from running `-u TRUE`
<details>
<summary><i>Click here to expand</i></summary>

```txt
Running ../../bin/exclude_bam_reads-unmapped.sh...
-u: "Safe mode" is TRUE.
+ check_exists_file ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam
+ what='
    check_exists_file()
    -------------------
    Check that a file exists; exit if it doesn'\''t

    :param 1: file, including path <chr>
    :return: NA
    '
+ [[ -z ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam ]]
+ [[ ! -f ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam ]]
+ :
+ check_exists_directory TRUE ./exp_alignment_STAR/files_bams
+ what='
    check_exists_directory()
    ------------------------
    Check that a directory exists; if it doesn'\''t, then either make it or exit

    :param 1: create directory if not found: TRUE or FALSE
              <lgl; default: FALSE>
    :param 2: directory, including path <chr>
    '
+ case "$(convert_chr_lower "${1}")" in
++ convert_chr_lower TRUE
++ what='
    convert_chr_lower()
    -------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
++ [[ -z TRUE ]]
++ string_in=TRUE
+++ tr '[:upper:]' '[:lower:]'
+++ printf %s TRUE
++ string_out=true
++ echo true
+ [[ -f ./exp_alignment_STAR/files_bams ]]
+ printf '%s\n' './exp_alignment_STAR/files_bams doesn'\''t exist; mkdir'\''ing it.'
./exp_alignment_STAR/files_bams doesn't exist; mkdir'ing it.
+ mkdir -p ./exp_alignment_STAR/files_bams
+ check_argument_flagstat
+ case "$(echo "$(convert_chr_lower "${flagstat}")")" in
+++ convert_chr_lower FALSE
+++ what='
    convert_chr_lower()
    -------------------
    Convert alphabetical characters in a string to lowercase letters

    :param 1: string <chr>
    :return: converted string <stdout>
    '
+++ [[ -z FALSE ]]
+++ string_in=FALSE
++++ tr '[:upper:]' '[:lower:]'
++++ printf %s FALSE
+++ string_out=false
+++ echo false
++ echo false
+ flagstat=0
+ echo -e '-f: "Run samtools flagstat" is FALSE.'
-f: "Run samtools flagstat" is FALSE.
+ check_argument_threads
+ what='
    check_argument_threads()
    ---------------
    Check the value assigned to "${threads}" in script; assumes variable
    "${threads}" is defined

    :param "${threads}": value assigned to variable within script <int >= 1>
    :return: NA

    #TODO Checks...
    '
+ case "${threads}" in
+ :
+ echo ''

++ basename ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam
+ base=5781_G1_IN_mergedAligned.sortedByCoord.out.bam
+ outfile=5781_G1_IN_mergedAligned.sortedByCoord.out.primary.bam
+ echo 'Filtering out unmapped...'
Filtering out unmapped...
+ samtools view -@ 1 -b -f 0x4 -f 0x8 ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.bam -o ./exp_alignment_STAR/files_bams/5781_G1_IN_mergedAligned.sortedByCoord.out.primary.bam
+ check_exit 0 samtools
+ what='
    check_exit()
    ------------
    Check the exit code of a child process

    :param 1: exit code <int >= 0>
    :param 2: program/package <chr>

    #TODO Check that params are not empty or inappropriate formats or strings
    '
+ [[ 0 == \0 ]]
++ date
+ echo 'samtools completed: Thu Nov 17 15:05:46 PST 2022'
samtools completed: Thu Nov 17 15:05:46 PST 2022
+ [[ 0 -eq 1 ]]
```
</details>

Did the filtering work correctly? Check the alignment counts and flag tallies
```bash
samtools view -c "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam"
# 27977684

samtools view -c "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam"
# 10858952

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
        > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}

list_tally_flags "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.bam"
list_tally_flags "${dir_abbrev}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam"
```
Contents of `list_tally_flags` for `*.out.bam`
```txt
5276715 77
5276715 141
4691235 99
4691235 147
3755353 83
3755353 163
 152761 653
 152761 589
  62364 659
  62364 611
  50414 675
  50414 595
```
Contents of `list_tally_flags` for `*.out.exclude-unmapped.bam`
```txt
5276715 77
5276715 141
 152761 653
 152761 589
```

`#NOTE` Cleary, there's an issue in which only the unmapped reads were retained, so probably need to change -f to -F
<br />
<br />

<a id="miscellaneous"></a>
## Miscellaneous
<a id="figure-out-where-to-put-this"></a>
### Figure out where to put this
<a id="brief-discussion-with-toshi-about-yeast-blacklists"></a>
#### Brief discussion with Toshi about yeast blacklists
- He's not aware of any such blacklists for yeast
- He suggested to reach out to Christine and Alison
- He suggested that we could put together a blacklist from ChIP-seq input data
    + `#IDEA` Identify binding regions (which should be non-specific since these are input data) present in multiple or all samples
- `#TODO` Skim over the blacklist paper from Anshul Kundaje to understand precisely what the blacklist describes
    + e.g., `#QUESTION` Is it non-specific binding, and thus noise, because of something related to the reference, or is it because of something related to the wet-work behind the NGS data?
    + `#TODO` I think it is reference-related, but want to confirm
- `#TODO` Look into [the one example of the use of a yeast blacklist I found in the literature]((https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8407396/))
- Also, discussed the possibility of doing bench-work in the future
    + Mentioned how, after tackling the `Trinity` tasks, it'd be a fun and interesting bioinformatics experiment to compare yeast G2/M MicroC data (from the Koshland Lab) to the yeast Q MicroC data (from this lab)
    + From there, based on what we find, we could consider to design and perform wet experiments

<a id="google-searches-and-websites-to-follow-up-on"></a>
### Google searches and websites to follow up on
- ["add flag to multimapper"](https://www.google.com/search?q=add+flag+to+multimappers&oq=add+flag+to+multimappers&aqs=chrome..69i57j33i160l2.3704j0j7&sourceid=chrome&ie=UTF-8)
    + ["SAM FLAG for primary alignments, secondary alignments, and what's their relationships to uniqueness of mapping"](https://www.biostars.org/p/206396/)
- ["use star with trinity"](https://www.google.com/search?q=use+star+with+trinity&oq=use+star+with+trinity&aqs=chrome..69i57j33i160l2.2936j0j7&sourceid=chrome&ie=UTF-8)
- ["ty elements cerevisiae"](https://www.google.com/search?q=ty+elements+cerevisiae&ei=hRJsY_jDKfDL0PEPy9CMqAE&ved=0ahUKEwi4moHt_KH7AhXwJTQIHUsoAxUQ4dUDCBA&uact=5&oq=ty+elements+cerevisiae&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQogQyBQgAEKIEMgUIABCiBDIFCAAQogQ6CggAEEcQ1gQQsANKBAhNGAFKBAhBGABKBAhGGABQ9RtYpR1g1yFoAXABeACAAUSIAYYBkgEBMpgBAKABAcgBAsABAQ&sclient=gws-wiz-serp)
    + [Ty Elements of the Yeast *Saccharomyces Cerevisiae*](https://www.tandfonline.com/doi/abs/10.1080/13102818.2005.10817272)
    + [Transposable elements in yeasts](https://pubmed.ncbi.nlm.nih.gov/21819950/)
- ["repeatmasker yeast"](https://www.google.com/search?q=repeatmasker+yeast&oq=repeatmasker+yeast&aqs=chrome..69i57j0i546l5.5324j0j7&sourceid=chrome&ie=UTF-8)
    + [RepeatMasker for Fungi](https://www.biostars.org/p/171368/)
- [Dfam](https://www.dfam.org/home)

<a id="to-be-continued-after-the-completion-of-trinity-work"></a>
### To be continued after the completion of `Trinity` work
Remember, the overarching goal is to have appropriately processed bam files for experiments to determine the best way(s) to call `Trinity`
- `(...)` Continue the TPM work
    - `#DONE` Understand what needs to be run before/after what when working with the adapted code base from `slowkow` (the work started in early September, 2022)
    - `(   )` Adapt [this code](https://gist.github.com/slowkow/c6ab0348747f86e2748b#file-counts_to_tpm-r)
- `(...)` Review notes (e.g., from previous meetings), steps, written-by-me code, and emails (incorporating some into this or another notebook where necessary) prior to Alison's arrival to the lab tomorrow; we-ll likely touch base to talk about things when she comes
- `#DONE` Look into the detection of optical duplicates with `picardmetrics` or just `picard MarkDuplicates`
    - `#NOTE` Shouldn't do it with RNA-seq data: [reasoning here](https://gatk.broadinstitute.org/hc/en-us/articles/360036459932-MarkDuplicates-Picard-#--READ_NAME_REGEX)
- `(TBC)` Began to troubleshoot error in which `picardmetrics` could not access the header for `5781_G1_IN_*.bam` in the initial bam directory~~; continue with this tomorrow~~
    - Seems to have to do with this [line of code](https://github.com/slowkow/picardmetrics/blob/master/picardmetrics#L554)
- `(TBC)` Look into the detection and removal of PCR duplicates with UMI-tools as suggested by Alison: Need to figure out what that entails
    - Began to look into [this](https://umi-tools.readthedocs.io/en/latest/reference/dedup.html) at the end of the day~~; continue reading up on this tomorrow~~
- `(   )` Continue to build out the alignment and processing script you were working on at the end of last week
    + Function-ize it
    + Get major modules into separate scripts, which are in-turn function-ized
    + get the main work into some kind of driver script
    + Etc.
    + `(...)` Get an answer to the question, "When splitting a bam from an RNA-seq experiment by strand for visualization (two separate bw files, one for the forward strand, the other for the reverse strand), should the bam be normalized (for example, using one of the normalization options provided by deepTools' `bamCoverage --normalizeUsing`) before or after the split?"
        * Asked the question on the [Biostars forum](https://www.biostars.org/p/9543809/); thus far, no response
- `#DONE` Continue to put together a ["master list" of all of Alison's relevant file directories](#updated-list-of-alisons-paths-to-important-directories-and-files)
- `#DONE` Collect information on the [RNA-seq kits used by Alison](#information-on-the-rna-seq-kits-used-by-alison) to generate the libraries

<a id="discussion-with-alison-on-what-i-should-prioritize-2022-1103"></a>
#### Discussion with Alison on what I should prioritize (2022-1103)
- Need to address the important question on **how best to call Trinity**
    + For example...
        * Are we giving `.bam` or `.fastq` files?
        * Are we calling with the Jaccard option?
        * Are we running in genome-guided mode?
        * Are we running things on one chromosome at a time?
- Downstream of `Trinity`
    + "Match Trinity annotations with [Saccharomyces Genome Database (SGD)](https://www.yeastgenome.org/) annotations"
        * If an annotation is shared between Trinity and SGD, favor the Trinity annotation  `#TODO Seems like some kind of typo here; clarify this`
        * If the same, then discard the Trinity annotation, keeping only the Trinity annotation  `#TODO Some kind of typo here; clarify this`
        * This entails a comparison of `.gtf` files with appropriate logic implemented in the code
- Upstream of `Trinity`
    + All lower priority and to be done later; e.g.,
        * `.bam` file work (`split-bam-by-species.sh`, `split-bam-by-strand.sh`, `bamCoverage`, etc.)
        * `.fastq` work (UMI-tools, etc.)
        * TPM work
        * QC work (e.g., `picardmetrics`)
        * etc.
- Parameter that will likely need to change on a per-dataset basis (Alison's thinking)
    + "Linker k-mer number may vary from dataset to dataset"
        * Could be read-depth dependent

<a id="next-steps"></a>
### Next steps
- `( Y ) #MONDAY` Pick up with fine-tuning the initial call to `Bowtie2`: *Shifting focus to STAR, a splice-aware aligner*  
- `( Y ) #TUESDAY` Use the combined-reference .fasta, .gtf, and genome index files to try aligning one of the (symlinked) .fastq files using the parameters for *S. cerevisiae* you found on the `STAR` Google group  
    + First, sus out and describe the parameters (for example, are all of them needed, are the values appropriate, etc.?)
    + Once this is done, move on to "filtering" the bam file, including isolating unmapped reads, and stripping away chromosomes that are not needed  
- `( Y ) #TUESDAY` Do the same with `Bowtie 2`  
- `( Y ) #WEDNESDAT` Read over and take notes on the qualifying exam and research update documents sent by Alison  
- `( Y ) #WEDNESDAY` Pick up with the assessment of the `Bowtie 2` alignment test #2 experiment: Need to know, from the alignments, what reads are unimappers, multimappers, etc.  
- `(...) #TOMORROW` Adjust `STAR` parameters based on the repetitive-element work you did in 2020
- `( Y ) #THURSDAY` Organize all thoughts on multimappers, messages to/from Trinity Google group, etc.)  
- `(   ) #STUDYFIRST` Until I hear back from Brian Haas, or if I don't hear back, go ahead and move forward with altered `STAR` parameters (so that we don't have flags in high hundreds and, instead, get readouts more similar to what we see with the `Bowtie 2` test run #2 on 2022-1109)  
    + `(   ) #STUDYFIRST` After that's done, compare the kinds of alignments we're getting between the two aligners and then pick one for subsequent use  
- `(   ) #STUDYFIRST` After the alignment process is determined, implemented, and completed, move on to writing up code for filtering by chromosomes (build on/expand what you were working on before): Ultimately, we'll start by working with VII of S. cerevisiae  
- `(   ) #SOMETIME` Continue reading and note-taking based on the messages with Brian Haas; this includes...
    + Haas et al. (Wortman), Approaches to Fungal Genome Annotation, Mycology 2011-09, particularly the portions that pertain to
        * "Gene structure annotation using transcriptome sequences (2.1.1)"
        * Figure 2
        * any mentions of PASA
        * "2.7. Annotation of fungal genomes with few spliced genes"
        * "2.8. Annotation of non-coding RNA genes"  `#MAYBE`
        * "Summary"
    + [Conversations related to "PASA" on the Trinity Google group](https://groups.google.com/g/trinityrnaseq-users/search?q=pasa), e.g.,
        * "STAR option for DISCASM"
        * "genome guided trinity vs other tools"
        * "analysis biological replications" (linked from "Genome-guided Trinity - pooling vs. not pooling bam files?")
        * `#TODO` Determine the others
    + All (or nearly all) the material associated with the `PASA` wiki (but seems like I have covered most of the relevant material)
- `(   ) #SOMETIME` From there, move on to reading and taking notes on [the Harvard "best practices" document](https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html), which will inform the steps you need to take next
- `(   ) #SOMETIME` Read and take notes on [this paper sent by Alison](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-016-1406-x#Sec2), which makes use of `Trinity` for *de novo* transcriptome assembly  
- `(   ) #SOMETIME` Put together a "blacklist" for *S. cerevisiae*  
    + [Google search for "download bed file for telomere coordinates"](https://www.google.com/search?q=download+bed+file+for+telomere+coordinates&ei=89lrY6zaH8aO0PEPrsGseA&oq=download+telomere+coordinates&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAxgAMgsIIRDDBBCgARCLAzoKCAAQRxDWBBCwAzoNCCEQwwQQChCgARCLA0oECE0YAUoECEEYAEoECEYYAFClF1i0I2DnM2gBcAF4AIABS4gBzAOSAQE4mAEAoAEByAEIuAEDwAEB&sclient=gws-wiz-serp)
    + Christine has `.bed` files in her shared folder
        * It seems she got them from the UCSC table browser
        * `#TODO` Look into the possibility of getting them from Ensembl
    + Already have locations of rDNA from having run `picardmetrics`
- `( Y ) #DONE` Pick up with the comparison between the 'rna-star' Google group calling of STAR and multi-hit mode calling of STAR
    + Then, get line-by-line CL-call code written and running for a version of multi-hit mode adapted for yeast
    + Also, see how many mismatches Alison et al. are allowing when they call with Bowtie2: Use the info if you can
<br />
<br />
