
## Trinity trial run
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

### On how I'll call Trinity
Adapted from what Alison is doing
```zsh
#DONTRUN

#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --error=./%J.err.txt
#SBATCH --output=./%J.out.txt

Trinity \
	--genome_guided_bam ${file} \
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

