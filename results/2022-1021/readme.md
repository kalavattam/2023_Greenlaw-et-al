
# 2022-1021-1024
## `Trinity`, etc. trial run
Work with this file, `5781_Q_IP_sorted.bam`, at this location, `/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1`

### Copy the file to the directory for upcoming work
```zsh
dir_from="/home/kalavatt/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation/test1"
dir_to="/home/kalavatt/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1021"
file="5781_Q_IP_sorted.bam"

cp "${dir_from}/${file}" "${dir_to}/${file}"
```

### Filter the bam file such that it contains only chrVII
```zsh
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

```zsh
samtools index "${file}"

samtools view -b "${file}" chrVII > "${file%.bam}.chrVII.bam"
samtools index "${file%.bam}.chrVII.bam"
```

### On how to call `Trinity`
Adapted from what Alison is doing: `submit-Trinity.sh`
```zsh
#DONTRUN

#!/bin/bash

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
Essentially, above contents saved to the script `submit-Trinity.sh` in directory `results/2022-1021`, which is where output from `Trinity` and output from SLURM (e.g., stderr and stdout) is saved as well.

Run time for the full genome
- start: Friday, October 21, 2022: 15:46:37
- stop: Friday, October 21, 2022: 17:37:29

### On making a `GFF` from the `Trinity`-assembled transcriptome
#### Use `GMAP`
For example, following the instructions [here](https://www.biostars.org/p/248479/).

However, this requires that we have `GMAP` genome indices (i.e., `GMAP` database) for the model organism of interest, *S. cerevisae*

#### Generate genome indices for `GMAP`/build a "`GMAP` database"
Apparently, we need to have only one chromosome per FASTA entry
```zsh
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
curl https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/sacCer3.2bit > sacCer3.2bit

conda create -n ucsc_env -c bioconda ucsc-twobittofa

grabnode
conda activate ucsc_env
twoBitToFa sacCer3.2bit sacCer3.fa
exit

```

Call `gmap_build` from a bespoke script, `submit-gmap_build.sh`, that submits a job to SLURM
```zsh
#DONTRUN

#!/bin/bash

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
```zsh
mv /home/kalavatt/genomes/sacCer3/GMAP/sacCer3/* /home/kalavatt/genomes/sacCer3/GMAP/
rmdir sacCer3

#  Also, go ahead and delete the individual chromosome fastas to save space (we
#+ didn't end up using them)
cd /home/kalavatt/genomes/sacCer3/chromosomes || echo "cd failed. Check on this."
rm *.{fa.gz,html,txt}
cd .. && rmdir chromosomes
pwd  # /home/kalavatt/genomes/sacCer3
```

#### Try making a `GFF` from the `Trinity`-assembled transcriptome based on the script from Alison
```zsh
#DONTRUN

#!/bin/bash

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
Save the above contents to `submit-gmap_chrVII.sh` in `${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1021`.

`#DONE` Also, make a version of the script for the full genome, i.e., not just chrVII.

#### Relevant links on/related to the generation of a GFF from the `Trinity`-assembled transcriptome, etc.
- [Fasta to gff with custom set of genes](https://www.biostars.org/p/248479/)
- [Generate GTF/GFF file (coordinates) from a FASTA annotated file](https://www.biostars.org/p/398693/)
- [How to make GFF file based on assembled transcriptome and genome sequence?](https://www.biostars.org/p/426969/)
- [Running gmap tool via gmapR package?](https://support.bioconductor.org/p/74613/)
- [juliangehring/GMAP-GSNAP (public archive)](https://github.com/juliangehring/GMAP-GSNAP)
- [Main page for GMAP/GSNAP](http://research-pub.gene.com/gmap/)
- [Main README for GMAP/GSNAP](http://research-pub.gene.com/gmap/src/README)
- [Convert Trinity transcriptome assembly to GTF/GFF](https://groups.google.com/g/trinityrnaseq-users/c/e5oKouOpvA0)
- [Gene Structure Annotation and Analysis Using PASA (GitHub wiki)](https://github.com/PASApipeline/PASApipeline/wiki)
- [Search results for "use gmap to make gff from fasta"](https://www.google.com/search?q=use+gmap+to+make+gff+from+fasta&ei=XO5WY5unIs_G0PEPvZ--yAk&ved=0ahUKEwibxe-00_n6AhVPIzQIHb2PD5kQ4dUDCBA&uact=5&oq=use+gmap+to+make+gff+from+fasta&gs_lcp=Cgdnd3Mtd2l6EAMyBwghEKABEApKBAhBGAFKBAhGGABQ9gRY9gRgowdoAXAAeACAAV2IAV2SAQExmAEAoAEBwAEB&sclient=gws-wiz)
