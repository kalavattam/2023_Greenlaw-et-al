
`#work_make-presentation-etc.md`

<a id="scraps-to-be-incorporated"></a>
## Scraps to be incorporated
If a genome sequence is available, `Trinity` offers a method in which...
1. reads are aligned to the genome, partitioning mapped reads by locus
2. the alignments undergo local *de novo* transcriptome assembly at each locus

Thus, the genome serves as "a substrate" for grouping overlapping reads into clusters that will be separately fed into `Trinity` for *de novo* transcriptome assembly. This differs from other genome-guided approaches such as those implemented in `cufflinks` and `stringtie`, where aligned reads are stitched into transcript structures, and where <mark>transcript sequences are reconstructed based on the reference genome sequence</mark>. In the `Trinity` __GG__ approach, transcripts are reconstructed based on the actual read sequences.

Why do this? You may have a reference genome, but your sample likely comes from an organism with a genome that isn't an exact match to the reference genome. Genome-guided *de novo* assembly should capture the sequence variations contained in your RNA-Seq sample in the form of the transcripts that are *de novo* reconstructed. In comparison to genome-free *de novo* assembly, it can also help in cases where you have paralogs or other genes with shared sequences, since the genome is used to partition the reads according to locus prior to doing any *de novo* assembly. If you have a highly fragmented draft genome, then you are likely better off performing a genome-free *de novo* transcriptome assembly.
<br />
<br />

<a id="documentation-for-alisonme"></a>
## Documentation for Alison/me
I used [`PASA` (Program to Assemble Spliced Alignments)](https://github.com/PASApipeline/PASApipeline/wiki) to build our draft transcriptome assemblies following the *"comprehensive transcriptome database"* strategy documented [here](https://github.com/PASApipeline/PASApipeline/wiki/PASA_comprehensive_db).

<a id="the-comprehensive-transcriptome-database-strategy"></a>
### The *"comprehensive transcriptome database"* strategy
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

<a id="how-i-called-the-different-programs-including-rationale-and-other-details"></a>
### How I called the different programs, including rationale and other details
- Experiment begun `2022-1201`; rough draft work begun `2022-1101`
- Automated pipeline `#INPROGRESS`
<a id="%E2%98%85-pasa"></a>
#### <sup>★</sup> `PASA`
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
<a id="--gene_overlap-true"></a>
###### `--gene_overlap` `TRUE`
<details>
<summary><i>Click to view the bash script</i></summary>

The calls to both `Launch_PASA_pipeline.pl` and `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./sh_err_out/err_out/submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.%J.out.txt

#  submit_launch-PASA-pipeline_build-comprehensive-transcriptome_param_gene-overlap.sh
#  KA
#  2022-1213

str_experiment="${1}"
str_accessions="${2}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is ${PASAHOME}"
echo ""

cd "files_PASA_param_gene-overlap/${str_experiment}"
echo "Working directory from which the script is called: $(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \
    --no-home \
    --bind "${HOME}/genomes/sacCer3/Ensembl/108" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    "${HOME}/singularity-docker-etc/PASA.sif" \
        "${PASAHOME}/Launch_PASA_pipeline.pl" \
            --CPU ${SLURM_CPUS_ON_NODE} \
            -c "${str_experiment}.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "${str_experiment}.transcripts.fasta.clean" \
            -T \
            -u "${str_experiment}.transcripts.fasta" \
            --TDN "${str_accessions}" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            -L \
            --annots "Saccharomyces_cerevisiae.R64-1-1.108.gff3" \
            --gene_overlap 50.0  \
            --ALIGNERS "blat,gmap,minimap2" \
                1> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stdout.log") \
                2> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)

if [[ -f "${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
    #  cyberciti.biz/faq/linux-unix-script-check-if-file-empty-or-not/
    if [[ -s "${str_experiment}.pasa.sqlite.pasa_assemblies.gtf" ]]; then
        singularity run \
            --no-home \
            --bind "${HOME}/genomes/sacCer3/Ensembl/108" \
            --bind "$(pwd)" \
            --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
            "${HOME}/singularity-docker-etc/PASA.sif" \
                ${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \
                    -c "${str_experiment}.align_assembly.config" \
                    -t "${str_experiment}.transcripts.fasta" \
                    --prefix "${str_experiment}.compreh_init_build" \
                    --min_per_ID 95 \
                    --min_per_aligned 30 \
                        1> >(tee -a "${str_experiment}.build_comprehensive_transcriptome.stdout.log") \
                        2> >(tee -a "${str_experiment}.build_comprehensive_transcriptome.stderr.log" >&2)
    else
        echo "${str_experiment}.pasa.sqlite.pasa_assemblies.gtf is empty"
        echo "Check on things..."
    fi
fi
```
</details>
<br />

<a id="--gene_overlap-false"></a>
###### `--gene_overlap` `FALSE`

<details>
<summary><i>Click to view the bash scripts</i></summary>

The calls to `Launch_PASA_pipeline.pl`
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.out.txt

#  submit_launch-PASA-pipeline.sh
#  KA
#  2022-1212

str_experiment="${1}"
str_accessions="${2}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is ${PASAHOME}"
echo ""

cd "files_PASA_param_gene-overlap/${str_experiment}"
echo "Working directory from which the script is called: $(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \
    --no-home \
    --bind "${HOME}/genomes/sacCer3/Ensembl/108" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    "${HOME}/singularity-docker-etc/PASA.sif" \
        "${PASAHOME}/Launch_PASA_pipeline.pl" \
            --CPU ${SLURM_CPUS_ON_NODE} \
            -c "${str_experiment}.align_assembly.config" \
            -C \
            -R \
            -g "Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -I 1002 \
            -t "${str_experiment}.transcripts.fasta.clean" \
            -T \
            -u "${str_experiment}.transcripts.fasta" \
            --TDN "${str_accessions}" \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --ALIGNERS "blat,gmap,minimap2" \
                1> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stdout.log") \
                2> >(tee -a "${str_experiment}.Launch_PASA_pipeline.stderr.log" >&2)
```

The calls to `build_comprehensive_transcriptome.dbi`
```bash
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/submit_launch-PASA-pipeline.%J.out.txt

#  submit_launch-PASA-pipeline.sh
#  KA
#  2022-1212

str_experiment="${1}"

ml Singularity 

export PASAHOME="/usr/local/src/PASApipeline" 
echo "PASAHOME is ${PASAHOME}"
echo ""

cd "files_PASA/${str_experiment}"
echo "Working directory from which the script is called: $(pwd)"
echo ""

echo "All files in the working directory:"
ls -lhaFG
echo ""

singularity run \
    --no-home \
    --bind "${HOME}/genomes/sacCer3/Ensembl/108/DNA" \
    --bind "$(pwd)" \
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/${SLURM_JOB_ID}" \
    "${HOME}/singularity-docker-etc/PASA.sif" \
        ${PASAHOME}/scripts/build_comprehensive_transcriptome.dbi \
            -c "${str_experiment}.align_assembly.config" \
            -t "${str_experiment}.transcripts.fasta" \
            --prefix "${str_experiment}.compreh_init_build" \
            --min_per_ID 95 \
            --min_per_aligned 30 \
                1> >(tee -a "${str_experiment}.stdout.log") \
                2> >(tee -a "${str_experiment}.stderr.log" >&2)
```
</details>
<br />

<a id="the-meaning-of-the-parameters"></a>
###### The meaning of the parameters
`#TODO`
<br />
<br />

<a id="%E2%98%85-trinity"></a>
#### <sup>★</sup> `Trinity`
<a id="details-1"></a>

<a id="details-1"></a>
##### Details
<a id="the-how-1"></a>

<a id="the-how-1"></a>
##### The how
<a id="gg"></a>

<a id="gg"></a>
###### GG
<a id="gf"></a>

<a id="gf"></a>
###### GF
<br />
<br />

<a id="%E2%98%85-star"></a>
#### <sup>★</sup> `STAR`
<br />
<br />

<a id="%E2%98%85-rcorrector"></a>
#### <sup>★</sup> `rcorrector`
<br />
<br />

<a id="%E2%98%85-trim_galore"></a>
#### <sup>★</sup> `trim_galore`
<br />
<br />
