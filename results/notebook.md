
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
- Where does `Trinity` transcriptome assembly/annotation fit in the above the steps?
- How do we evaluate the annotations output by `Trinity`? What is the "ground truth"? Is there a systematic means of evaluation?
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
    - The logic for *ratio of ratios*: "If *S. cerevisiae* goes up, we want the scaling factor to go up."
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

### Contents of `results/2022-1018/readme.md`
#### 2022-1018
##### E-mail 1: "Fred Hutch Server and a few of my scripts"
##### E-mail 2: "Fred Hutch Server and a few of my scripts"
##### E-mail 3: "Fred Hutch Server and a few of my scripts"
##### E-mail 4: "Fred Hutch Server and a few of my scripts"
#### 2022-1019
##### E-mail 1: "Nascent normalization remains baffling"


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

### Contents of `results/2022-1020/readme.md`
##### E-mail 1.1 (from Alison): "Quality control analysis"
##### E-mail 1.2 (from Kris): "Quality control analysis"
##### E-mail 1.3 (from Toshi): "Quality control analysis"
##### E-mail 2 (from Alison): "More Code!"
##### E-mail 3 (from Alison): "File Locations"
##### E-mail 4 (from Alison): "Hand Curation and so many annotation files"
##### E-mail 5 (from Alison): "Small fraction of AS transcripts functional on first pass"


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


## 2022-1024
### Miscellaneous SLURM-related things
#### Print the number of CPUs in use per job in SLURM
Per [this link](https://stackoverflow.com/questions/64928381/print-the-number-of-cpus-in-use-per-job-in-slurm), the `squeue` command has two parameters that allow choosing the columns displayed in the output, `--format` and `--Format`. Each has an option (respectively `%c` and `NumCPUs`) to display the number of cores requested by the job.

Try with
```
squeue -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %c"
```
This will show the default columns and add the number of cores as the last column. You can fiddle with the format string to arrange the columns as you want. Then, when you are happy with the output, you can set it as the value of the `SQUEUE_FORMAT` variable in your `.bash_profile` or `.bashrc`.
```
export SQUEUE_FORMAT='%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R %c'
```
See the `squeue` man page for more details.

### Going over Trinity assessments with Alison
- Can split gff3 by strand: `#TODO` Look into this (e.g., see [this link](https://www.biostars.org/p/215428/))
- Per-chromosome fastq approach: `#TODO` Look into this
	- We seem to do a "worse job when we do everything all at one," where here "everything" means running Trinity on the full genome versus running it with respect to one chromosome at a time

In the IGV instance that Alison had pulled up
- Each line is one strand of one replicate: `#TODO` Set up my readout like this too
- Alison obtained these tracks after having run `bam_split_paired_end.sh` (currently found in `results/2022-1018/sh`)
- It should be possible to obtain a similar such file using `deepTools bamCoverage` with appropriate arguments, e.g., `--filterRNAstrand` (e.g., see [this link](https://deeptools.readthedocs.io/en/develop/content/tools/bamCoverage.html)): `#TODO` Look into this

Other ideas
- Consider whether/how to filter data to remove transcripts below a certain value
- This kind of filtration should take place prior to running `Trinity`, right?

Goal/genereal approach
- Set up `Trinity` to do as well as it can
- Make assignments
	- Evaluate the assignments with respect to known annotations
	- Evaluate the assignments with respect to *de novo* (`Trinity`) annotations

On snoRNAs versus snRNAs
- snRNAs are associated with the spliceosome
- snoRNAs direct ribosome modifications

On the means to evaluate Trinity results by aligning reads back to the transcriptome assembly (e.g., as described [here](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6))
- From the above link: "Generally, in a high quality assembly, you would expect to see at least ~70% \[overall alignment rate\] and at least ~70% of the reads to exist as proper pairs."
- Alison: "100% of reads captured would be too much" (with respect to mapping back to the *de novo* assembly)
- Alison: "Giving it less to chew on may be better"
- Alison expects that we will get much higher than 70% overall alignment rate because of the very high coverage of the data (remember that the yeast genome is very small)
- `#TODO` Get these experiments up and running

#### Five things to try out/work on
1. `(   )` `deepTools bamCoverage` (see above)
2. `(   )` Ways/means to parameterize Trinity: Identify what paramter(s) to test, then set up experiments for the tests 
3. `(   )` Test the genome-guided bam approach to `Trinity` versus the fastq approach (with the Jaccard index parameter): The thinking here is that, based on the documentation, it's not clear that the Jaccard index parameter is working with genome-guided bam approach
4. `(   )` Evaluate the percent overall alignment rate and percent of reads as proper pairs after aligning the reads to the assembled transcriptome (again, see [here](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6))
5. `(   )` Re-review the tutorial ([link](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6)) to see if there are other general things we can evaluate; also, check for other tutorials and then check their contents
6. `(   )` Determine that running `Trinity` with respect to one chromosome at a time versus all chromosomes indeed makes a difference; for example, perhaps the spurious annotations observed in the telomeric region of chrVII in the 'full' approach come from transcripts associated with another chromosome; thus, they may show up when concatenating files from `Trinity` with respect to one chromosome at a time

### Meeting with Toshi about additional things to work on, above and beyond the `Trinity` work (above)
In Alison's eventual paper, we're focused on antisense transcription, but we need to say something about mRNA transcription too

#### mRNA: *steady-state* versus *nascent*
We can make direct comparisons between steady-state G1 and steady-state Q (or log and Q), because we can perform spike-in normalization. We *can't* do the same for nascent G1 and nascent Q. Instead, we can only make within-sample comparisons, e.g., can only make comparisons within Q or can only make comparisons within G1, and can't make comparisons between Q and G1.

`#TODO` However, see if you can think of anything for some kind of normalization that would allow for comparisons between Q and G1...

When labeling for 4tU in Q, there's nothing to compete for 4tU incorporation because Q cells are in water whereas G1 or log cells are in medium.

#### Strategy hit upon by Toshi and Alison
Rank steady-state mRNA and nascent mRNA, then just compare ranks
Some corresponding logic:
- N: mRNA is in top 10%; SS: mRNA is in bottom 10%; can assume transcript is actively degraded
- N: mRNA is in bottom 10%; SS: mRNA is in top 10%; can assume transcript is stablized

#### Goals (per Toshi)
1. Did we do this (rank comparison method) in the right way?
2. Also, we want to have something to say about mRNA in Q...

#### Additional things (low priority)
- Compare protein abundances to mRNA abundances
- Teach Rachel basic ChIP-seq analyses, e.g., RPD3

### Contents of `results/2022-1021/readme.md`
#### `Trinity`, etc. trial run
##### Copy the file to the directory for upcoming work
##### Filter the bam file such that it contains only chrVII
##### On how to call `Trinity`
##### On making a `GFF` from the `Trinity`-assembled transcriptome
###### Use `GMAP`
###### Generate genome indices for `GMAP`/build a "`GMAP` database"
###### Try making a `GFF` from the `Trinity`-assembled transcriptome based on the script from Alison
###### Relevant links on/related to the generation of a GFF from the `Trinity`-assembled transcriptome, etc.


## 2022-1025
### Miscellaneous
`#TODO` Look into [these Google search results for "spike-in normalization eli5"](https://www.google.com/search?q=spike-in+normalization+eli5&oq=spike-in+normalization+eli5&aqs=chrome..69i57j0i546l2.5874j0j7&sourceid=chrome&ie=UTF-8)
`#TODO` Look into [these Google search results for "s cerevisiae blacklist"](https://www.google.com/search?q=s+cerevisiae+blacklist&oq=s+cerevisiae+blacklist&aqs=chrome..69i57j69i64l3.4473j0j4&sourceid=chrome&ie=UTF-8)

### Notes from meeting with Alison and Toshi (with regards to `pptx` in e-mail "Additional Nab3 Analysis," sent 2022-1024)
- `#TODO` A more formal, polished implementation of the calculation of TPM (e.g., see *Slide 1*), building on what Alison did in `Analysis_sense_antisense.Rmd` (see directory `results/2022-1025/Rmd`)
- `#QUESTION` What does "gated at 14 TPM" mean?
	- `#ANSWER` Top 20% expressed antisense transcripts upon depletion of *Nab3*
	- If we do this analysis, per Toshi, we need to show...
		- Suggestion from Alison: Maybe stringent; try top 10%, top 30%
		- Suggestion from Toshi that Alison is going to move forward with: Try different quintiles; "it's possible at a certain level that fold change doesn't matter"
- Per Toshi, should not care about very lowly expressed transcripts (`#QUESTION` mRNA? AS? All?) because, `#REMEMBER`, our data are very, very deeply sequenced
	- The yeast genome is much, much smaller than mammalian genomes
- `#QUESTION` Is it the absolute level or relative increase of antisense transcription that matters?
	- Toshi suspects that absolute levels are the most important, per Alison, "for function"
	- If no increase from parent to depletion (child), then it may not be functional or, at least, we won't be to see it from this perspective
- Alison is calculation a "representation factor" statistic for set overlaps (e.g., Venn diagrams) using the web software and details here:
	- [Home](http://nemates.org/MA/): Click on "Statistical significance of the overlap between two groups of genes"
	- [The software](http://nemates.org/MA/progs/overlap_stats.html)
	- [The details](http://nemates.org/MA/progs/representation.stats.html) `#TODO`
	- These stats that are being generated: Are they legitimate/appropriate given the context of our analyses, the question(s) we ask? `#TODO`
- On *Slide 2*, both sense (S) and antisense (AS) transcripts (tx) are "from nascent"
- Per Toshi, ≤20 AS tx are biologically functional for their activity, not their RNA product, in budding yeast (*Saccharomyces cerevisiae*)
- Per Toshi and Alison, may be interesting to look into the following: AS nascent versus steady-state (SS) sense in "all combinations" `#TODO` Follow up on what they're talking about here
- *Slides 2 and 3*: Many of the AS tx that are up, corresponding S does not go down: `#QUESTION` From Toshi: Is this because there's no S to begin with?
- *Slide 4*: y-axis is S, and panel B is from a separate paper (the left panel is from Alison)
	- Panel B is not Q: it's "late log" (OD 0.6 to 3.0)
	- Alison depleted *Nab3*, the team behind the other paper (2013, I think?) depleted a factor that forms a dimer with Nab3, so it's expected to have a similar function
- *Slide 7* (the violin-plot slide): Shows changes in mRNA depletion
- *Slide 8* (the next violin-plot slide): Shows absolute levels of AS tx (in TPM)
	- Possibilities for "activating" AS tx or "neutral and everything is coming up" `#TODO` Get clarification on this second part?
	- Or it could be that Nab3 (which is currently depleted) would otherwise be degrading the currently upregulated mRNA (e.g., in "violins" 2 and 3)
	- "Are they tandem genes" because PolII keeps going (`#QUESTION` I presume they're talking about something like "slip-through tx" here?)
- Question from Toshi: "How much overlap to say that S/AS overlap?" Answer from Alison: "Whatever HTSeq says" `#NOTE` She'll look into precisely is going on here
- Point from Toshi: It's possible that, once we annotate in a formal way (i.e., optimize the `Trinity` work), things might change quite a bit
- *Slide 11* ("Sense up, AS up")
	- Is this because S was very low to begin with?
	- Per Toshi, it's hard to imagine both strands robustly transcribed
- `#QUESTION` from Toshi: Should we pause to get a "correct annotation" and then do "serious analyses?"
	- Alison wants to continue with the current work, which she and Toshi consider "rough draft analyses"
	- Alison: "It's interesting to play around with."
	- However, going to eventually need to redo everything with proper annotations
	- The main findings are unlikely change
- `#QUESTION` If AS is increased, then are you more likely to have S up, down, or unchanged?
- Some next steps for Alison
	- Re-do "bin analyses" (violin plot slides) with AS "bins" (categories, really)
	- Correlation analyses between nascent and steady

### Notes from meeting with Alison to discuss the `Trinity` work
- `#QUESTION` The `fastq` files in `${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot`, do I need to do anything with them (e.g., regarding the *K. lactis* spike-in and/or 20 S) prior to using them as input with `Trinity`?
	- Can try to give the fastq (contains *K. lactis* and 20 S information in addition to *S. cerevisiae* information)
	- The two species are largely conserved (if I copied down this note correctly), but there is some notable divergence between the two `#TODO` Follow up with Alison on this
	- Alison mentioned a genome duplication event: Did it occur prior to the airising of the two species? `#TODO` Follow up with Alison on this
	- Idea worked out with Alison: Create a combined genome comprised of *S. cerevisiae*, *K. lactis*, and 20 S
		- Align to it
		- Filter out reads aligned to *K. lactis* and 20 S
		- Use the remaining reads, aligned to *S. cerevisiae* as `bam` input to `Trinity`
			- Could convert from bam to fastq and split by chromosome too... `#TODO` Think about this...
- `#QUESTION` Are there *K. lactis* reads in these `fastq` files, in addition to *S. cerevisiae* reads? `#ANSWER` Yes, and 20 S reads too
- `#QUESTION` ...for the `fastq` and `bam` files prior to using them as input for `deepTools bamCoverage`?
- `#QUESTION` Alison is calling `Trinity` with `--SS_lib_type FR`; however, most strand-specific libraries are generated with the dUTP method, which means they need `--SS_lib_type RF`; therefore, are we sure that `--SS_lib_type FR` is correct here? `#ANSWER` Yes, see the results of your work with `how_are_we_stranded_here` in `results/2022-1025/readme.md`

#### `#TODOs` resulting from the meeting: Two things to try out/work on
1. `#TODO (   )` A "better way" to calculate TPM (see "Notes from meeting with Alison and Toshi" above)
2. `#TODO (   )` Create a combined genome comprised of *S. cerevisiae*, *K. lactis*, and 20 S (more details immediately above); then, select the *S. cerevisiae* alignments for downstream analyses

# 2022-1025-1028
## E-mail: "Additional Nab3 Analysis"
## Working through the bullets in "Five things to try out/work on" in `notebook.md` ("Going over Trinity assessments with Alison")
### Working on the bullet "Test the genome-guided bam approach to `Trinity` versus the fastq approach"
#### Snippets, etc. from searching the [`Trinity Google Group`](https://groups.google.com/g/trinityrnaseq-users)
##### Have searched for term "Jaccard" 
###### ["Genome-guided assembly questions"](https://groups.google.com/g/trinityrnaseq-users/c/HV-JK9xiC8E/m/tVyPJzpYBgAJ)
##### Have searched for the term "antisense"
###### ["genome guided strand specific assembly"](https://groups.google.com/g/trinityrnaseq-users/c/DVnpAnhdNeA/m/RM5oT_PXAAAJ)
###### ["filtering 'fake' antisense and overly similar sequences" by Brian Haas](https://groups.google.com/g/trinityrnaseq-users/c/2Fe5dZu7FnY/m/r69jVJfSBAAJ)
###### [""]()
#### Important links, etc.
#### Check that libraries are indeed FR and not RF
# 2022-1026
## E-mail: "Some R code"
### Contents of `results/2022-1025/readme.md`
## Creation of a combined reference genome comprised of *S. cerevisiae*, *K. lactis*, and 20 S narnavirus
### 1. The `fasta` for *Saccharomyces 20 S narnavirus* can be obtained from the [Saccharomyces Genome Database (SGD)](https://www.yeastgenome.org/)
### 2. Go ahead and grab the other *S. cerevisiae* virus sequences available on [SGD](https://www.yeastgenome.org/)
### 3. Now, get the genome `fasta` for *S. cerevisiae* from [Ensembl release 108](https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/)
### 4. Now, get the genome `fasta` for *K. lactis* from what appears to be a special version of Ensembl for fungi, e.g., [here](https://fungi.ensembl.org) and a specific page for [*K. lactis*](https://fungi.ensembl.org/Kluyveromyces_lactis_gca_000002515/Info/Index)
### 5. Clean up the headers for the 20S narnavirus, *S. cerevisisae*, and *K. lactis*
## Concatenate the *S. cerevisiae*, *K. lactis*, and *S20* genomes, creating a combined genome for RNA-seq and related analyses)
