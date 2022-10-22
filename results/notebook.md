
## 2022-1018

### Installing local instance of `Trinity`
[Instructions.](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-in-Docker#run-trinity-using-docker)
1. Install `Docker`; then, log in to `Docker`
2. `docker pull trinityrnaseq/trinityrnaseq`

### Use `Docker` to run local instance of `Trinity`
```zsh
docker run --rm -v`pwd`:`pwd` trinityrnaseq/trinityrnaseq Trinity \
	--seqType fq \
	--left `pwd`/reads_1.fq.gz \
	--right `pwd`/reads_2.fq.gz \
	--max_memory 1G \
	--CPU 4 \
	--output `pwd`/trinity_out_dir
```

#### Alias to prevent excessive typing
```zsh
unalias Trinity
alias Trinity="docker run --rm -v`pwd`:`pwd` --platform linux/amd64 trinityrnaseq/trinityrnaseq Trinity"
```

### Potentially interesting/useful links for studying `Trinity`
- https://biohpc.cornell.edu/doc/RNA-Seq-2019-exercise1-2.html
- https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity
- https://www.broadinstitute.org/broade/trinity-screencast
- https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-in-Docker#run-trinity-using-docker
- https://informatics.fas.harvard.edu/best-practices-for-de-novo-transcriptome-assembly-with-trinity.html

### Set up directory structure for 2022_transcriptome-construction
1. Create repo on Github per, e.g., [these instructions](https://github.com/prog4biol/pfb2022/blob/master/unix.md#creating-a-new-repository)
    a. Private (for now)
    b. R-styled `.gitignore` (to be updated)
    c. No license (for now)

```zsh
dir_proj="projects-etc"

cd  # Go home
mkdir "${dir_proj}" && cd "${dir_proj}"

#  Run first time only
# gh auth login
# ? What account do you want to log into? GitHub.com
# ? What is your preferred protocol for Git operations? HTTPS
# ? Authenticate Git with your GitHub credentials? Yes
# ? How would you like to authenticate GitHub CLI? Login with a web browser
#
# ! First copy your one-time code: A6F8-2289
# Press Enter to open github.com in your browser...
# ✓ Authentication complete.
# - gh config set -h github.com git_protocol https
# ✓ Configured git protocol
# ✓ Logged in as kalavattam

#  Clone 2022_transcriptome-construction repo  # If necessary, run `brew install gh`
gh repo clone kalavattam/2022_transcriptome-construction

mkdir -p 2022_transcriptome-construction/{bin,data,results}  # Start with only these directories for the time being
#  Save this mardown document to notebook.md in 2022_transcriptome-construction/results

#  Push it to 2022_transcriptome-construction/results
git add results/notebook.md
git commit -m 'Initial commit: Uploading notebook.md'
git push origin main
```

### Meeting with Alison, 2022-1018
- Label yeast (*S. cerevisiae*) with 4tU for 6 minutes: this allows us to identify nascent transcription
- Isolate RNA from frozen pellet
- *K. lactis* spiked in during the RNA-isolation step; thus, the RNA is comprised of two species
- Pull down 40 µg: biotin-streptavidin chemistry
- However, after biotin conjugation but before streptavidin-bead binding, take input: 10% taken out to examine steady-state transcription
- Perform column cleanups
- Use of "Universal Plus Total" kit with custom yeast rRNA probe set, allowing the isolation of stranded cDNA
- Align to *S. cerevisiae* and *K. lactis* separately
- Run `samtools` script that counts the number of alignments (successful) in bam files
- Calculate ratio of *K. lactis* counts to *S. cerevisiae* counts, e.g., `KL/SC`
- Calculate a "ratio of ratios," i.e., an additional normalization: `parent/mutant`

### Questions
- Where does Trinity transcriptome assembly/annotation fit in the above the steps?
- How do we evaluate the annotations output by Trinity? What is the "ground truth"? Is there a systematic means of evaluation?
- normalization_station.pptx, 2/14: calculation of "ratio of ratios" is described as `R_sample/R_parental`, but looks like `R_parental/R_sample` in the Excel slide (e.g., `parent/mutant`); which is correct and/or what is my misunderstanding here?
- What is the purpose of the scaling factor here? What is it doing and/or what is it correcting for?
- Are these antisense RNA molecules mRNAs (forgive my ignorance)?
- RPKM/FPKM normalization is a form of RNA-seq normalization that is known to perform poorly when assumptions for library-size normalization (namely, as assumption that extracted  mRNA/cell is the same `*`) are violated; have we considered trying other forms of normalization? I wonder if that's something I could try on the side while Alison moves forward with...
- What does "single tag" and "double tag" mean again?

### Meeting with Alison and Toshi, 2022-1019
#### Design
- With Alison's project, comparing three types of Q cells
- For parental and mutant strains, there are two lines (except double mutant strains)
- Add 4tU, label for 6 minutes: transcribed RNAs within this window will include 4tU
- Sequence all RNA
	- The total is considered "steady state" RNA
	- Pull down the transcripts that contain 4tU (using "click chemistry")
- Rationale for normalization: On a per-cell level, how much is transcription changing? Unless we normalize, we can't say if, e.g., "antisense is only increasing or sense is going down"
	- This rationale is not super clear
- From 40 µg total RNA, end up with 16 µL of nascent RNA at a concentration of approximately 5 ng/µL

#### Background
- In Q, many genes have highly elevated antisense transcription
- Want to establish what among these have functional significance
- Experimental system: Have depleted genetic factors with roles in the termination of antisense transcription
- We'll know this experimental system work if/when...
    - we see that antisense transcription is up for genes
    - antisense transcription termination is blocked, i.e., the ncRNA is longer

#### Goals for me
- Help Alison with normalization
    - "The logic for *ratio of ratios*: If *S. cerevisiae* goes up, we want the scaling factor to go up."
    - `#QUESTION` But surely there's another way to calculate a number with this property, right?
    - `#NOTE` Toshi requested that Alison try a different calculation/normalization scheme
    - `#TODO` Touch base with Alison on what she's doing now
    - I think this is it:
    	- First, normalize to depth
    	- Then, calculate size factor for the strain (take the ratio `KL/SC`)
    	- "One strain set as basis"  `#WHAT`
- Need to establish an automated way to annotate ncRNAs with Trinity
	- Non trivially difficult: No ORF as with sense transcripts

#### Next steps
- Get Alison's code running on the cluster
- Systematize it
- `#GENERAL` Learn how people do things and search for more streamlined ways to do things
- Look into additional programs to do transcriptome annotation like Trinity, but touch base with Alison before trying any of them: She may have tried them already and may then have input

## 2020-1020
### Brief notes on Fred Hutch's cluster resources
```
#  Log into FH cluster
ssh kalavatt@rhino.fhcrc.org
kalavatt@rhino.fhcrc.org's password: *******************
```
- `Rhino`: shared cluster node
- `Gizmo`: reserved cluster node

More details recorded in gists [here](https://gist.github.com/kalavattam).

### New slides from Alison
- The new normalization approach seems to be effective
- Results appear to be reproducible between replicates
- PC1 captures the vast majority of variance in the data but PC2 is the PC that actually separates nascent from steady state
	- The vast majority of variance may be the random-variable nature of the counts for low-expression genes, right?

### How Alison is calling Trinity
- See `trin4.1_adjusted_salmo.sh`
```
Trinity \
	--genome_guided_bam ${file} \
	--max_memory 50G \
	--SS_lib_type FR \
	--normalize_max_read_cov 200 \
	--jaccard_clip \
	--genome_guided_max_intron 1002 \
    --min_kmer_cov 2 \
    --max_reads_per_graph 500000 \
    --min_glue 2 \
    --group_pairs_distance 700 \
    --min_contig_length 200 \
    --full_cleanup \
    --output ./trinity_trin4s_${file%.bam_sorted_new.bam}
```
- `--genome_guided_bam`: "If a genome sequence is available, Trinity offers a method whereby reads are first aligned to the genome, partitioned according to locus, followed by *de novo* transcriptome assembly at each locus" ([more info](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Genome-Guided-Trinity-Transcriptome-Assembly))
	- "In this use-case, the genome is only being used as a substrate for grouping overlapping reads into clusters that will then be separately fed into Trinity for de novo transcriptome assembly."
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

## 2022-1021
### Working through HPC materials, tutorials
#### Logging on to `rhino` for the first time
[Tutorial here](https://sciwiki.fredhutch.org/compdemos/first_rhino/).
Command to request one's own compute node: `grabnode`
Follow the on-screen prompts

### More studying up on `Trinity`
(See 2013 *Nat Biotechnol* manuscript.)
1. What is Trinity and what does it do?
- Program that assembles full-length transcriptome *de novo*, i.e., without the need for a reference genome
- Additional breakdown of Inchworm, Chrysalis, and Butterfly in the 2013 *Nat Biotechnol* manuscript
2. What is a de Bruijn graph?
- In this type of graph, a node is defined by a sequence of a fixed length of k nucleotides (“k-mer”, with k considerably shorter than the read length), and nodes are connected by edges, if they perfectly overlap by k-1 nucleotides, and the sequence data supports this connection.
- This compact representation allows for enumerating all possible solutions by which linear sequences can be reconstructed given overlaps of k-1. For transcriptome assembly, each path in the graph represents a possible transcript.
- A scoring scheme applied to the graph structure can rely on the original read sequences and mate-pair information to discard nonsensical solutions (transcripts) and compute all plausible ones.

