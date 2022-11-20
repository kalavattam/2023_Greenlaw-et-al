
# 2022-1021-1024
<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [2022-1021-1023](#2022-1021-1023)
    1. [Working through HPC materials, tutorials](#working-through-hpc-materials-tutorials)
        1. [Logging on to `rhino` for the first time](#logging-on-to-rhino-for-the-first-time)
    1. [More studying up on `Trinity`](#more-studying-up-on-trinity)
    1. [Trial run, etc. for `Trinity`](#trial-run-etc-for-trinity)
        1. [Copy the file to the directory for upcoming work](#copy-the-file-to-the-directory-for-upcoming-work)
        1. [Filter the bam file such that it contains only chrVII](#filter-the-bam-file-such-that-it-contains-only-chrvii)
        1. [On how to call `Trinity`](#on-how-to-call-trinity)
        1. [On making a `.gff` from the `Trinity`-assembled transcriptome](#on-making-a-gff-from-the-trinity-assembled-transcriptome)
            1. [Use `GMAP`](#use-gmap)
            1. [Generate genome indices for `GMAP`/build a "`GMAP` database"](#generate-genome-indices-for-gmapbuild-a-gmap-database)
            1. [Try making a `.gff` from the `Trinity`-assembled transcriptome based on the script from Alison](#try-making-a-gff-from-the-trinity-assembled-transcriptome-based-on-the-script-from-alison)
            1. [Relevant links for the generation of a `.gff` from a `Trinity`-assembled transcriptome, etc.](#relevant-links-for-the-generation-of-a-gff-from-a-trinity-assembled-transcriptome-etc)
1. [2022-1024](#2022-1024)
    1. [Going over Trinity assessments with Alison](#going-over-trinity-assessments-with-alison)
        1. [Five things to try out/work on](#five-things-to-try-outwork-on)
    1. [Meeting with Toshi about additional things to work on](#meeting-with-toshi-about-additional-things-to-work-on)
        1. [mRNA: *steady-state* versus *nascent*](#mrna-steady-state-versus-nascent)
        1. [Strategy hit upon by Toshi and Alison](#strategy-hit-upon-by-toshi-and-alison)
        1. [Goals \(per Toshi\)](#goals-per-toshi)
        1. [Additional things \(low priority\)](#additional-things-low-priority)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="2022-1021-1023"></a>
## 2022-1021-1023
<a id="working-through-hpc-materials-tutorials"></a>
### Working through HPC materials, tutorials
<a id="logging-on-to-rhino-for-the-first-time"></a>
#### Logging on to `rhino` for the first time
[Tutorial here](https://sciwiki.fredhutch.org/compdemos/first_rhino/)
- Command to request one's own compute node: `grabnode`
- Follow the on-screen prompts
<br />
<br />

<a id="more-studying-up-on-trinity"></a>
### More studying up on `Trinity`
(See 2013 *Nat Biotechnol* manuscript.)
1. What is `Trinity` and what does it do?
    + Program that assembles full-length transcriptome *de novo*, i.e., without the need for a reference genome
    + Additional breakdown of Inchworm, Chrysalis, and Butterfly in the 2013 *Nat Biotechnol* manuscript
2. What is a de Bruijn graph?
    - In this type of graph, a node is defined by a sequence of a fixed length of k nucleotides (“k-mer”, with k considerably shorter than the read length), and nodes are connected by edges, if they perfectly overlap by k-1 nucleotides, and the sequence data supports this connection
    - This compact representation allows for enumerating all possible solutions by which linear sequences can be reconstructed given overlaps of k-1. For transcriptome assembly, each path in the graph represents a possible transcript
    - A scoring scheme applied to the graph structure can rely on the original read sequences and mate-pair information to discard nonsensical solutions (transcripts) and compute all plausible ones
<br />
<br />

<a id="trial-run-etc-for-trinity"></a>
### Trial run, etc. for `Trinity`
Work with this file, `5781_Q_IP_sorted.bam`, at this location, `/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1`

<a id="copy-the-file-to-the-directory-for-upcoming-work"></a>
#### Copy the file to the directory for upcoming work
```bash
#!/bin/bash
#DONTRUN

dir_from="/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1"
dir_to="/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1021"
file="5781_Q_IP_sorted.bam"

cp "${dir_from}/${file}" "${dir_to}/${file}"
```

<a id="filter-the-bam-file-such-that-it-contains-only-chrvii"></a>
#### Filter the bam file such that it contains only chrVII
```bash
#!/bin/bash
#DONTRUN

ml SAMtools/1.16.1-GCC-11.2.0

samtools view *.bam | head -5
```

Output to console
```txt
HISEQ:1007:HGV5NBCX3:1:1207:3282:88984	99	chrI	147	17	49M	=	307	209	TTACCCTGTCTCATTCAACCATACCACTCCCAACTACCATCCATCCCTC	GGGGIGIIIIGGIIIIIIIGIGIIIIIIIGIIIIIIIGIIIIIGIIIGI	AS:i:75	XS:i:52	XN:i:0	XM:i:3	XO:i:0	XG:i:0	NM:i:3	MD:Z:10C19G3C14	YS:i:90	YT:Z:CP
HISEQ:1007:HGV5NBCX3:1:1216:10817:56273	99	chrI	159	2	49M	=	234	123	ATTCAACTATACCACTCCCAACTACCATCCATCTCTCTACTTACTACCA	GGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGGIIIIIIIGIIIG	AS:i:66	XS:i:78	XN:i:0	XM:i:4	XO:i:0	XG:i:0	NM:i:4	MD:Z:7C10G3C10C15	YS:i:80	YT:Z:CP
HISEQ:1007:HGV5NBCX3:1:1112:7352:13135	99	chrI	226	2	19M1I29M	=	433	257	CCAATTACCCATATCCTACTCCACTGCCACTTACCCTACCATTCCCCTA	GGGGGGGIIIIIGIIIIIIIIIIIIIGIIIGIGGGGAGGIIIIGIIIII	AS:i:73	XS:i:75	XN:i:0	XM:i:2	XO:i:1	XG:i:1	NM:i:3	MD:Z:16A25A5	YS:i:73	YT:Z:CP
HISEQ:1007:HGV5NBCX3:1:2210:9324:79218	99	chrI	229	11	16M1I32M	=	295	115	ATTACCCATATCCTACTCCACTGCCACTTACCCTACCATTACCCTACCA	GGGGGGIIIIIIIIIIIIIIIIIIIGGGIIIIIIIIIGIIIIIIIIIIG	AS:i:80	XS:i:82	XN:i:0	XM:i:1	XO:i:1	XG:i:1	NM:i:2	MD:Z:13A34	YS:i:90	YT:Z:CP
HISEQ:1007:HGV5NBCX3:1:1216:10817:56273	147	chrI	234	2	11M1I37M	=	159	-123	CCATATCCTACTCCACTGCCACTTACCCTACCATTACCCTACCATCCAC	IIGGGIIIIGGGIGGGGIIIIIIGGGIIIGIIIGGGIIGGGIGGGGGGG	AS:i:80	XS:i:83	XN:i:0	XM:i:1	XO:i:1	XG:i:1	NM:i:2	MD:Z:8A39	YS:i:66	YT:Z:CP
```

```bash
#!/bin/bash
#DONTRUN

samtools index "${file}"

samtools view -b "${file}" chrVII > "${file%.bam}.chrVII.bam"
samtools index "${file%.bam}.chrVII.bam"
```

<a id="on-how-to-call-trinity"></a>
#### On how to call `Trinity`
Adapted from what Alison is doing: `submit-Trinity.sh`
```bash
#!/bin/bash
#DONTRUN

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-Trinity.sh
#  KA

module purge
module load Trinity/2.10.0-foss-2019b-Python-3.7.4

file="5781_Q_IP_sorted.chrVII.bam"  # Separately, try 5781_Q_IP_sorted.bam

Trinity \
    --genome_guided_bam "${file}" \
    --CPU "${SLURM_CPUS_ON_NODE}" \
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
    --output "./trinity_trin4s_${file%.bam}"
```
Essentially, above contents saved to the script `submit-Trinity.sh` in directory `results/2022-1021`, which is where output from `Trinity` and output from SLURM (e.g., `stderr` and `stdout`) is saved as well

Run time for the full genome
- start: Friday, October 21, 2022: 15:46:37
- stop: Friday, October 21, 2022: 17:37:29

<a id="on-making-a-gff-from-the-trinity-assembled-transcriptome"></a>
#### On making a `.gff` from the `Trinity`-assembled transcriptome
<a id="use-gmap"></a>
##### Use `GMAP`
For example, following the instructions [here](https://www.biostars.org/p/248479/)

However, this requires that we have `GMAP` genome indices (i.e., `GMAP` database) for the model organism of interest, *S. cerevisae*

<a id="generate-genome-indices-for-gmapbuild-a-gmap-database"></a>
##### Generate genome indices for `GMAP`/build a "`GMAP` database"
Apparently, we need to have only one chromosome per FASTA entry
```bash
#!/bin/bash
#DONTRUN

#  Download UCSC sacCer3 chromosomes from, e.g.,
#+ https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/chromosomes/

mkdir ~/genomes
cd genomes || echo "cd failed. Check on this."

wget --no-parent -r https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/chromosomes/

cd hgdownload.soe.ucsc.edu/goldenPath/sacCer3/chromosomes || echo "cd failed. Check on this."
cd ../..
mv sacCer3/ ../..  # Move sacCer3/chromosomes directly into directory 'genomes'

#  Do some cleanup
cd ..
rm robots.txt && rmdir goldenPath
cd ..
rmdir hgdownload.soe.ucsc.edu

cd sacCer3/chromosomes
rm *\?C=*  # Remove non-necessary index-related files

pwd
# /home/kalavatt/genomes/sacCer3/chromosomes  # Use this path for running 'gmap_build'
ls /home/kalavatt/genomes/sacCer3/chromosomes/*.fa.gz

#  Make a location to store the indices, etc. for GMAP
cd .. || echo "cd failed. Check on this."
mkdir GMAP

#  Get the twoBit file, convert it to fasta, then try building the genome from that
curl \
    https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/sacCer3.2bit \
    > sacCer3.2bit

conda create -n ucsc_env -c bioconda ucsc-twobittofa

grabnode
conda activate ucsc_env
twoBitToFa sacCer3.2bit sacCer3.fa
exit

```

Call `gmap_build` from a bespoke script, `submit-gmap_build.sh`, that submits a job to SLURM
```bash
#!/bin/bash
#DONTRUN

#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

#  submit-gmap_build.sh
#  KA

ml GMAP-GSNAP/2018-07-04-foss-2018b

location_for_output="${HOME}/genomes/sacCer3/GMAP"
fasta="${HOME}/genomes/sacCer3/sacCer3.fa"

# gmap_build -d <genome> [-k <kmer size>] <fasta_files...>
#  e.g., see section 4 of https://github.com/juliangehring/GMAP-GSNAP/blob/master/README
gmap_build \
	--dir "${location_for_output}" \
	--sort "none" \
	--db "sacCer3" \
	"${fasta}"

#NOTE 1/3 Switched to using the whole-genome fasta because trying to run
#NOTE 2/3 gmap_build with individual fastas for the chromosomes was throwing
#NOTE 3/3 inscrutable (to me) errors

#NOTE 1/3 Ran the script with '--cpus-per-task=2' in order to increase the
#NOTE 2/3 amount of memory to the job per the instructions here:
#NOTE 3/3 https://sciwiki.fredhutch.org/scicomputing/compute_jobs/#memory
```

Contents of `2436414.out.txt`
```txt
Opening file /home/kalavatt/genomes/sacCer3/sacCer3.fa
  Processed short contigs (<1000000 nt): ...
  Contig chrIV: concatenated at chromosome end: chrIV:1..1531933 (length = 1531933 nt)
  Processed short contigs (<1000000 nt): ...
  Contig chrVII: concatenated at chromosome end: chrVII:1..1090940 (length = 1090940 nt)
  Processed short contigs (<1000000 nt): ...
  Contig chrXII: concatenated at chromosome end: chrXII:1..1078177 (length = 1078177 nt)
  Processed short contigs (<1000000 nt): ..
  Contig chrXV: concatenated at chromosome end: chrXV:1..1091291 (length = 1091291 nt)
  Processed short contigs (<1000000 nt): ..
============================================================
Contig mapping information has been written to file /home/kalavatt/genomes/sacCer3/GMAP/sacCer3.coords.
You should look at this file, and edit it if necessary
If everything is okay, you should proceed by running
    make gmapdb
============================================================
No alternate scaffolds observed
```
Do I need to do anything more? This should be everything, right? I think so...

Let's clean things up by moving the contents of `/home/kalavatt/genomes/sacCer3/GMAP/sacCer3` to `/home/kalavatt/genomes/sacCer3/GMAP`
```bash
#!/bin/bash
#DONTRUN

mv /home/kalavatt/genomes/sacCer3/GMAP/sacCer3/* /home/kalavatt/genomes/sacCer3/GMAP/
rmdir sacCer3

#  Also, go ahead and delete the individual chromosome fastas to save space (we
#+ didn't end up using them)
cd /home/kalavatt/genomes/sacCer3/chromosomes || echo "cd failed. Check on this."
rm *.{fa.gz,html,txt}
cd .. && rmdir chromosomes
pwd  # /home/kalavatt/genomes/sacCer3
```

<a id="try-making-a-gff-from-the-trinity-assembled-transcriptome-based-on-the-script-from-alison"></a>
##### Try making a `.gff` from the `Trinity`-assembled transcriptome based on the script from Alison
```bash
#!/bin/bash
#DONTRUN

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

ml GMAP-GSNAP/2018-07-04-foss-2018b
ml SAMtools/1.16.1-GCC-11.2.0

d_Kris="${HOME}/tsukiyamalab/Kris"
d_proj="2022_transcriptome-construction/results"
d_exp="2022-1021/trinity_trin4s_5781_Q_IP_sorted.chrVII"
fasta="Trinity-GG.fasta"

gmap \
	-d "sacCer3" \
	-D "${HOME}/genomes/sacCer3/GMAP" \
    -A "${d_Kris}/${d_proj}/${d_exp}/${fasta}" \
    --format="gff3_gene" "samse" \
    	> "${d_Kris}/${d_proj}/${d_exp}/${fasta%.fasta}.GMAP.gff"
```
Save the above contents to `submit-gmap_chrVII.sh` in `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1021`

`#DONE` Also, make a version of the script for the full genome, i.e., not just chrVII

<a id="relevant-links-for-the-generation-of-a-gff-from-a-trinity-assembled-transcriptome-etc"></a>
##### Relevant links for the generation of a `.gff` from a `Trinity`-assembled transcriptome, etc.
- [`.fasta` to `.gff` with custom set of genes](https://www.biostars.org/p/248479/)
- [Generate `.gtf`/`.gff` file (coordinates) from a `.fasta` annotated file](https://www.biostars.org/p/398693/)
- [How to make `.gff` file based on assembled transcriptome and genome sequence?](https://www.biostars.org/p/426969/)
- [Running `gmap` tool via `gmapR` package?](https://support.bioconductor.org/p/74613/)
- [`juliangehring/GMAP-GSNAP` (public archive)](https://github.com/juliangehring/GMAP-GSNAP)
    + [Main page for `GMAP/GSNAP`](http://research-pub.gene.com/gmap/)
    + [Main `README` for `GMAP/GSNAP`](http://research-pub.gene.com/gmap/src/README)
- [Convert `Trinity` transcriptome assembly to `.gtf`/`.gff`](https://groups.google.com/g/trinityrnaseq-users/c/e5oKouOpvA0)
- [Gene Structure Annotation and Analysis Using `PASA` (`GitHub` wiki)](https://github.com/PASApipeline/PASApipeline/wiki)
- [Search results for "use gmap to make gff from fasta"](https://www.google.com/search?q=use+gmap+to+make+gff+from+fasta&ei=XO5WY5unIs_G0PEPvZ--yAk&ved=0ahUKEwibxe-00_n6AhVPIzQIHb2PD5kQ4dUDCBA&uact=5&oq=use+gmap+to+make+gff+from+fasta&gs_lcp=Cgdnd3Mtd2l6EAMyBwghEKABEApKBAhBGAFKBAhGGABQ9gRY9gRgowdoAXAAeACAAV2IAV2SAQExmAEAoAEBwAEB&sclient=gws-wiz)
<br />
<br />

<a id="2022-1024"></a>
## 2022-1024
<a id="going-over-trinity-assessments-with-alison"></a>
### Going over Trinity assessments with Alison
- Can split gff3 by strand: `#TODO Look into this` (e.g., see [this link](https://www.biostars.org/p/215428/))
- Per-chromosome fastq approach: `#TODO Look into this`
    - We seem to do a "worse job when we do everything all at one," where here "everything" means running Trinity on the full genome versus running it with respect to one chromosome at a time

*In the IGV instance that Alison had pulled up*
- Each line is one strand of one replicate: `#TODO Set up my readout like this too`
- Alison obtained these tracks after having run `bam_split_paired_end.sh` (currently found in `results/2022-1018/sh`)
- It should be possible to obtain a similar such file using `deepTools bamCoverage` with appropriate arguments, e.g., `--filterRNAstrand` (e.g., see [this link](https://deeptools.readthedocs.io/en/develop/content/tools/bamCoverage.html)): `#TODO Look into this`

*Other ideas*
- Consider whether/how to filter data to remove transcripts below a certain value
- This kind of filtration should take place prior to running `Trinity`, right?

*Goal/genereal approach*
- Set up `Trinity` to do as well as it can
- Make assignments
    - Evaluate the assignments with respect to known annotations
    - Evaluate the assignments with respect to *de novo* (`Trinity`) annotations

*On snoRNAs versus snRNAs*
- snRNAs are associated with the spliceosome
- snoRNAs direct ribosome modifications

*On the means to evaluate Trinity results by aligning reads back to the transcriptome assembly* (e.g., as described [here](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6))
- From the above link: "Generally, in a high quality assembly, you would expect to see at least ~70% \[overall alignment rate\] and at least ~70% of the reads to exist as proper pairs."
- Alison: "100% of reads captured would be too much" (with respect to mapping back to the *de novo* assembly)
- Alison: "Giving it less to chew on may be better"
- Alison expects that we will get much higher than 70% overall alignment rate because of the very high coverage of the data (remember that the yeast genome is very small)
- `#TODO Get these experiments up and running`

<a id="five-things-to-try-outwork-on"></a>
#### Five things to try out/work on
1. `#WAIT (...)` `deepTools bamCoverage` (see above)  `#NOTE See results/2022-1101/readme.md`
2. `#TODO (   )` Ways/means to parameterize `Trinity`: Identify what paramter(s) to test, then set up experiments for the tests 
3. `#TODO (   )` Test the genome-guided `.bam` approach to `Trinity` versus the `.fastq` approach (with the Jaccard index parameter): The thinking here is that, based on the documentation, it's not clear that the Jaccard index parameter is working with genome-guided bam approach
4. `#TODO (   )` Evaluate the percent overall alignment rate and percent of reads as proper pairs after aligning the reads to the assembled transcriptome (again, see [here](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6))
5. `#TODO (   )` Re-review the tutorial ([link](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6)) to see if there are other general things we can evaluate; also, check for other tutorials and then check their contents
6. `#TODO (   )` Determine that running `Trinity` with respect to one chromosome at a time versus all chromosomes indeed makes a difference; for example, perhaps the spurious annotations observed in the telomeric region of chrVII in the 'full' approach come from transcripts associated with another chromosome; thus, they may show up when concatenating files from `Trinity` with respect to one chromosome at a time
<br />
<br />

<a id="meeting-with-toshi-about-additional-things-to-work-on"></a>
### Meeting with Toshi about additional things to work on
...above and beyond the `Trinity` work (above)  
In Alison's eventual paper, we're focused on antisense transcription, but we need to say something about mRNA transcription too

<a id="mrna-steady-state-versus-nascent"></a>
#### mRNA: *steady-state* versus *nascent*
We can make direct comparisons between steady-state G1 and steady-state Q (or log and Q), because we can perform spike-in normalization. We *can't* do the same for nascent G1 and nascent Q. Instead, we can only make within-sample comparisons, e.g., can only make comparisons within Q or can only make comparisons within G1, and can't make comparisons between Q and G1

`#TODO (...)` `#MAYBE` However, see if you can think of anything for some kind of normalization that would allow for comparisons between Q and G1...
- `#NOTE 2022-1103` Could consider doing `DESeq2::estimateSizeFactors(controlGene = ...)` and then `DESeq2` RLE normalization
    + This could make the comparisons across the different conditions possible and valid, but does the RLE normalization lose otherwise important outliers?

When labeling for 4tU in Q, there's nothing to compete for 4tU incorporation because Q cells are in water whereas G1 or log cells are in medium

<a id="strategy-hit-upon-by-toshi-and-alison"></a>
#### Strategy hit upon by Toshi and Alison
Rank steady-state mRNA and nascent mRNA, then just compare ranks
Some corresponding logic:
- N: mRNA is in top 10%; SS: mRNA is in bottom 10%; can assume transcript is actively degraded
- N: mRNA is in bottom 10%; SS: mRNA is in top 10%; can assume transcript is stablized

<a id="goals-per-toshi"></a>
#### Goals (per Toshi)
1. Did we do this (rank comparison method) in the right way?
2. Also, we want to have something to say about mRNA in Q...

<a id="additional-things-low-priority"></a>
#### Additional things (low priority)
- Compare protein abundances to mRNA abundances
- Teach Rachel basic ChIP-seq analyses, e.g., RPD3
<br />
<br />
