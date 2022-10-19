
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

### Meeting with Alison
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

