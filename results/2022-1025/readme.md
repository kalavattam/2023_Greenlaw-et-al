
# 2022-1025
## E-mail: "Additional Nab3 Analysis"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Date: Monday, October 24, 2022 at 11:34 PM
To: [Tsukiyama, Toshio](ttsukiya@fredhutch.org)
Cc: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Additional Nab3 Analysis

### File
- `more analysis.pptx`

### Contents
Hi Toshi - 

You have seen a lot of the analysis in the attached but there's some new stuff too, as well as what I am thinking of doing next. I am happy with what I am seeing so far. 

Kris - I will send you the code related to this analysis in the next few days. I want to get it organized and commented first. 

Alison

## Working through the bullets in "Five things to try out/work on" in `notebook.md` ("Going over Trinity assessments with Alison")
### Working on the bullet "Test the genome-guided bam approach to `Trinity` versus the fastq approach"
#### Snippets, etc. from searching the [`Trinity Google Group`](https://groups.google.com/g/trinityrnaseq-users)
##### Have searched for term "Jaccard" 
###### ["Genome-guided assembly questions"](https://groups.google.com/g/trinityrnaseq-users/c/HV-JK9xiC8E/m/tVyPJzpYBgAJ)
Post #2
> ...
> For drosophila, the `--jaccard_clip` can help. If you have strand-specific rna-seq, then I wouldn't bother, since the strand-specific rna-seq already solves a lot of the problems that jaccard-clip is meant to mitigate.
> ...

Post #3
> Brian,
> 
> Is it your recommendation to never use jaccard-clip with strand-specific RNA-seq? Or would you still use it with *very dense genomes like yeast*?
> 
> thanks,
> -Will

Post #4
> With very dense genomes, you'll always need it.   For moderately-dense genomes, you can probably get away w/out it if you have strand-specific data.
> 
> Jaccard clip is by no means a 'cure' for the issue....  it just mitigates it.  We still need a more effective approach for it ... someday.
> 
> \~b

##### Have searched for the term "antisense"
###### ["genome guided strand specific assembly"](https://groups.google.com/g/trinityrnaseq-users/c/DVnpAnhdNeA/m/RM5oT_PXAAAJ)
Post #6
> The process we support is to just give it a single coordinate sorted bam file, indicate the `--SS_lib_type` mode and let Trinity do the transcribed strand based separation of the alignments.

###### ["filtering 'fake' antisense and overly similar sequences" by Brian Haas](https://groups.google.com/g/trinityrnaseq-users/c/2Fe5dZu7FnY/m/r69jVJfSBAAJ)
> Hi all,
> 
> Attached is a little script you can drop into trinityrnaseq/util/misc and use (along with having cdhit installed) to filter out transcripts that might derive from 'fake' antisense in the context of > strand-specific rna-seq, or to weed out overly similar sequences that tend to be shorter and lowly expressed (possible artifacts).
> 
> It'll go into the next release as an option for additional filtering.
> 
> It's only been used lightly so far by myself, so let me know if you encounter any weirdness / bugs.
> 
> Run like so:
> ```bash
> filter_similar_seqs_expr_and_strand_aware.pl  \
>     --transcripts_fasta Trinity.fasta \
>     --expr_matrix  isoforms.expr.matrix \
>         > Trinity.filtered.fasta
> ```

###### [""]()
Post #2
- on removing the approximately 1% of fake antisense reads from strand-specific library preparation, sequencing, etc.
- I guess this pertains to `filter_similar_seqs_expr_and_strand_aware.pl` in `trinityrnaseq/util/misc` mentioned immediately above

> Hi Sjannie,
> 
> If it's a deeply sequenced data set, then I expect you'll see more of a spread, and it's because the strand-specificity is generally about 99% effective.  If you sequence deep enough, that remaining 1% can accumulate sufficient reads to have Trinity assemble the same transcript in the 'antisense' orientation in addition to the more dominantly supported sense orientation.  So, you end up with some artificial lowly expressed antisense transcript assemblies in the output, and these are presumably the transcripts that are shifting the distribution here.  They'll be lowly expressed in when quantified using a strand-specific quantification method.
> 
> I don't have a canned solution for dealing with this, mainly because I haven't needed to.  I just tend to ignore the lowly expressed contigs, as they don't tend to show up as significant in any downstream assay of DE, and are just passengers in the study.  But, I can imagine a simple protocol for cleaning them up, and we could implement something for it for the next release.  It would involve two steps (after having a strand-specific assembly and an expression matrix): 
>   1. running cdhit-est to cluster at high stringency (high identity and high percent length overlap of the shorter transcript), and
>   2. excluding entries in a cdhit cluster that have an expression value below some threshold of the dominantly expressed transcript and having a transcriptional orientation that's opposite from the dominantly expressed transcript (antisense).
> 
> You could assume an \~1% 'fake' antisense rate given what we know about the experimental protocols.
> 
> \~brian

#### Important links, etc.
- ["De novo RNA-Seq Assembly, Annotation, and Analysis Using Trinity and Trinotate," part of the "Informatics for RNA-Seq Analysis" Workshop](https://bioinformaticsdotca.github.io/rnaseq_2017_tutorial6)
- ["Informatics for RNA-Seq Analysis" Workshop home page](https://bioinformaticsdotca.github.io/rnaseq_2017)
- ["Transcriptome Assembly Quality Assessment" by Brian Haas, co-author and maintainer of Trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Transcriptome-Assembly-Quality-Assessment)

#### Check that libraries are indeed FR and not RF
- ["Strandness in RNASeq" by Hong Zheng, 2017-0817](https://littlebitofdata.com/en/2017/08/strandness_in_rnaseq/)
- ["signalbash/how_are_we_stranded_here"](https://github.com/signalbash/how_are_we_stranded_here)
```zsh
#  Install how_are_we_stranded_here in its own environment on rhino/gizmo -----

#NOTE Installation is finnicky; here's how I ultimately ended up doing it...
#  Building on advice at this link:
#+ github.com/signalbash/how_are_we_stranded_here/issues/13
mamba create -n strandedness_env
conda activate strandedness_env

mamba install -c conda-forge python=3.6.15  
mamba install -c conda-forge numpy=1.10
mamba install -c bioconda kallisto=0.44.0
mamba install -c bioconda bx-python  # python-lzo, a necessary package, is installed alognside bx-python
mamba install -c bioconda rseqc
mamba install -c bioconda how_are_we_stranded_here  # pandas, a necessary package, is installed alongside how_are_we_stranded_here


#  Download files needed by how_are_we_stranded_here --------------------------
#  These are (a) a genome-annotation gtf file and (b) a fasta of transcript
#+ sequences (cDNA), for S. cerevisiae
cd "${HOME}/genomes/sacCer3"
mkdir -p Ensembl/108
cd mkdir -p Ensembl/108

#  Get the gtf file(s)
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/CHECKSUMS
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/README
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gtf.gz
wget https://ftp.ensembl.org/pub/release-108/gtf/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.108.gtf.gz

mkdir gtf
mv CHECKSUMS README *.gtf.gz gtf/

#  Get the transcripts (cdna) file
wget https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/cdna/CHECKSUMS
wget https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/cdna/README
wget https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/cdna/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz

mkdir cDNA
mv CHECKSUMS README *.fa.gz cDNA/


#  Now, set up vartiables and run how_are_we_stranded_here --------------------
cd "${HOME}/tsukiyamalab/Kris/2022_transcriptome-construction/results/2022-1025"

pa_fastq="${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_157_G1_IN"
pa_gtf_cDNA="${HOME}/genomes/sacCer3/Ensembl/108"

check_strandedness \
	--gtf "${pa_gtf_cDNA}/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
	--transcripts "${pa_gtf_cDNA}/cDNA/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa" \
	--reads_1 "${pa_fastq}/5781_G1_IN_GTCGAGAA_L001_R1_001.fastq" \
	--reads_2 "${pa_fastq}/5781_G1_IN_GTCGAGAA_L001_R2_001.fastq"
```

Output of `how-are-we-stranded-here` printed to screen
```txt
Results stored in: stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001
converting gtf to bed
Checking if fasta headers and bed file transcript_ids match...
OK!
generating kallisto index

[build] loading fasta file /home/kalavatt/genomes/sacCer3/Ensembl/108/cDNA/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa
[build] k-mer length: 31
[build] counting k-mers ... done.
[build] building target de Bruijn graph ...  done
[build] creating equivalence classes ...  done
[build] target de Bruijn graph has 11489 contigs and contains 8243691 k-mers

creating fastq files with first 200000 reads
quantifying with kallisto

[quant] fragment length distribution will be estimated from the data
[index] k-mer length: 31
[index] number of targets: 6,612
[index] number of k-mers: 8,243,691
[index] number of equivalence classes: 8,064
Warning: 515 transcripts were defined in GTF file, but not in the index
[quant] running in paired-end mode
[quant] will process pair 1: stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/5781_G1_IN_GTCGAGAA_L001_R1_001_sample.fq
                             stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/5781_G1_IN_GTCGAGAA_L001_R2_001_sample.fq
[quant] finding pseudoalignments for the reads ... done
[quant] processed 200,000 reads, 108,480 reads pseudoaligned
[quant] estimated average fragment length: 229.667
[   em] quantifying the abundances ... done
[   em] the Expectation-Maximization algorithm ran for 270 rounds
[  bam] writing pseudoalignments to BAM format .. done
[  bam] sorting BAM files .. done
[  bam] indexing BAM file .. done

checking strandedness
Reading reference gene model stranded_test_5781_G1_IN_GTCGAGAA_L001_R1_001/Saccharomyces_cerevisiae.R64-1-1.108.bed ... Done
Loading SAM/BAM file ...  Finished
Total 177529 usable reads were sampled
This is PairEnd Data
Fraction of reads failed to determine: 0.0824
Fraction of reads explained by "1++,1--,2+-,2-+": 0.8990 (98.0% of explainable reads)
Fraction of reads explained by "1+-,1-+,2++,2--": 0.0186 (2.0% of explainable reads)
Over 90% of reads explained by "1 ++,1--,2+-,2-+"
Data is likely FR/fr-secondstrand
```
Sure enough, the library is likely to be `FR`, consistent with what Alison is invoking in `Trinity`

# 2022-1026
## E-mail: "Some R code"
### File
- `Analysis_sense_antisense.Rmd`
- `AS_mRNA_Nascent_Nab3.txt`
- `AS_TPM.txt`
- `deletionmeta_AS.txt`
- `deletionmeta.txt`
- `mRNA_Nascent_Nab3.txt`
- `res_order_AS_Diff_expression.txt`
- `WT_Q_G1_TPM.txt`

### Contents
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Date: Tuesday, October 25, 2022 at 6:56 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Some R code

I have attached the .Rmd that does most all the analysis we went over this afternoon with Toshi. I have also attached the 7 .txt files it needs to read in to work. Let me know if you have any questions or issues. 
 
Alison

## Creation of a combined reference genome comprised of *S. cerevisiae*, *K. lactis*, and 20 S narnavirus
### 1. The `fasta` for *Saccharomyces 20 S narnavirus* can be obtained from the [Saccharomyces Genome Database (SGD)](https://www.yeastgenome.org/)
	- In the search bar, input "20 S"
	- The second result (October 26, 2022) is "20S_RNA_Narnavirus_1997_NC004051.fsa"
	- Downloads for the `fasta` file and `README` are available; use the links to download the files
```zsh
grabnode

#  Saccharomyces cerevisiae narnavirus 20S RNA
#+ yeastgenome.org/search?q=20s&is_quick=true
cd "${HOME}/genomes"
mkdir -p 20S_RNA_Narnavirus_1997_NC004051 && cd 20S_RNA_Narnavirus_1997_NC004051

curl https://sgd-prod-upload.s3.amazonaws.com/S000209166/20S_RNA_Narnavirus_1997_NC004051.fsa > 20S_RNA_Narnavirus_1997_NC004051.fasta
curl https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README > yeast_viruses.README
curl https://sgd-prod-upload.s3.amazonaws.com/S000209349/20S_RNA_Narnavirus_1997_NC004051.gb > 20S_RNA_Narnavirus_1997_NC004051.gb
```
### 2. Go ahead and grab the other *S. cerevisiae* virus sequences available on [SGD](https://www.yeastgenome.org/)

```zsh
#  Saccharomyces cerevisiae virus L-A (L1)
#+ yeastgenome.org/search?q=L-A_L1_2002_NC003745&is_quick=true
cd "${HOME}/genomes"
mkdir -p L-A_L1_2002_NC003745 && cd L-A_L1_2002_NC003745

curl https://sgd-prod-upload.s3.amazonaws.com/S000209169/L-A_L1_2002_NC003745.fsa > L-A_L1_2002_NC003745.fasta
curl https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README > yeast_viruses.README
curl https://sgd-prod-upload.s3.amazonaws.com/S000209352/L-A_L1_2002_NC003745.gb > L-A_L1_2002_NC003745.gb

cd ..

#  Killer virus of S. cerevisiae
#+ yeastgenome.org/search?q=killer&is_quick=true
mkdir -p KillerVirusM1_1996_NC001782 && cd KillerVirusM1_1996_NC001782

curl https://sgd-prod-upload.s3.amazonaws.com/S000209168/KillerVirusM1_1996_NC001782.fsa > KillerVirusM1_1996_NC001782.fasta
curl https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README > yeast_viruses.README
curl https://sgd-prod-upload.s3.amazonaws.com/S000209351/KillerVirusM1_1996_NC001782.gb > KillerVirusM1_1996_NC001782.gb

cd ..

#  Saccharomyces cerevisiae narnavirus 23S RNA
#+ yeastgenome.org/search?q=23S&is_quick=true
mkdir -p 23S_RNA_Narnavirus_1997_NC004050 && cd 23S_RNA_Narnavirus_1997_NC004050

curl https://sgd-prod-upload.s3.amazonaws.com/S000209167/23S_RNA_Narnavirus_1997_NC004050.fsa > 23S_RNA_Narnavirus_1997_NC004050.fasta
curl https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README > yeast_viruses.README
curl https://sgd-prod-upload.s3.amazonaws.com/S000209350/23S_RNA_Narnavirus_1997_NC004050.gb > 23S_RNA_Narnavirus_1997_NC004050.gb

cd ..

#  Saccharomyces cerevisiae virus L-BC
#+ yeastgenome.org/search?q=L-BC&is_quick=true
mkdir -p L-BC_La_1993_NC001641 && cd L-BC_La_1993_NC001641

curl https://sgd-prod-upload.s3.amazonaws.com/S000209170/L-BC_La_1993_NC001641.fsa > L-BC_La_1993_NC001641.fasta
curl https://sgd-prod-upload.s3.amazonaws.com/S000208074/yeast_viruses.README > yeast_viruses.README
curl https://sgd-prod-upload.s3.amazonaws.com/S000209353/L-BC_La_1993_NC001641.gb > L-BC_La_1993_NC001641.gb

cd ..
```
### 3. Now, get the genome `fasta` for *S. cerevisiae* from [Ensembl release 108](https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/)
```zsh
cd "${HOME}/genomes/sacCer3" || echo "cd failed. Check on this."

alias .,="ls -lhaFG"
.,
```

Results:
```txt
total 19M
drwxrwx--- 4 kalavatt  105 Oct 26 13:15 ./
drwxrwx--- 8 kalavatt  247 Oct 26 13:08 ../
drwxrwx--- 3 kalavatt   21 Oct 25 16:19 Ensembl/
drwxrwx--- 3 kalavatt  628 Oct 24 15:07 GMAP/
-rw-rw---- 1 kalavatt 2.9M Oct 24 14:48 sacCer3.2bit
-rw-rw---- 1 kalavatt  12M Oct 24 14:52 sacCer3.fa
```

Looks we have a `fasta` already, `sacCer3.fa`, from converting the `2bit` to `fasta` with `twoBitToFa`. Technically, these files should be with the `Ensembl/108/` subdirectory, so go ahead and move them into there. Also, go ahead and rename the file to `sacCer3.fasta`, and grab the corresponding `README` for the file.
```zsh
mv sacCer.* Ensembl/108/

cd Ensembl/108/

mv sacCer3.fa sacCer3.fasta

#  Organize things a bit...
mkdir -p 2bit_fasta
mv *.2bit *.fasta  2bit_fasta/
```

The `2bit` was obtained from [this UCSC goldenPath link](https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips); thus, get the `README` from this spot too. Also, per the `README`, the `2bit` is dated 2011-08-24. This is quite old.
```zsh
cd 2bit_fasta || echo "cd failed. Check on this."

vi README  # Then, copy in the text from the above UCSC goldenPath link
curl https://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/md5sum.txt > md5sum.txt
```

Is there an updated genome fasta available from [Ensembl release 108](https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/)? Let's check.
```zsh
#  Move 2bit_fasta to a new, non-Ensembl-release-108 directory for clear
#+ indication of its status as an older assembly
cd "${HOME}/genomes/sacCer3" || echo "cd failed. Check on this."

mkdir -p UCSC
mv Ensembl/108/2bit_fasta ./UCSC/
#  OK, this is better...

cd Ensembl/108
mkdir -p DNA && cd DNA

#  It looks like 'Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz' is the
#+ file we want
curl https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz > Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
curl https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/README > README
curl https://ftp.ensembl.org/pub/release-108/fasta/saccharomyces_cerevisiae/dna/CHECKSUMS > CHECKSUMS

zcat Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz | head -5
```

Results:
```txt
>I dna:chromosome chromosome:R64-1-1:I:1:230218:1 REF
CCACACCACACCCACACACCCACACACCACACCACACACCACACCACACCCACACACACA
CATCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTT
ACCCTCCATTACCCTGCCTCCACTCGTTACCCTGTCCCATTCAACCATACCACTCCGAAC
CACCATCCATCCCTCTACTTACTACCACTCACCCACCGTTACCCTCCAATTACCCATATC
```
Note how the name of the chromosome is 'I' and not 'chrI' as it is in the UCSC `2bit`/`fasta`. `#NOTE` I may need to make a new version of the `*.toplevel.fa.gz` file with cleaned up, simplified chromosome names.

List all of the chromosome names in the Ensembl `fasta` file:
```zsh
fasta="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz"
zgrep "^>" "${fasta}"
```

Results:
```txt
>I dna:chromosome chromosome:R64-1-1:I:1:230218:1 REF
>II dna:chromosome chromosome:R64-1-1:II:1:813184:1 REF
>III dna:chromosome chromosome:R64-1-1:III:1:316620:1 REF
>IV dna:chromosome chromosome:R64-1-1:IV:1:1531933:1 REF
>V dna:chromosome chromosome:R64-1-1:V:1:576874:1 REF
>VI dna:chromosome chromosome:R64-1-1:VI:1:270161:1 REF
>VII dna:chromosome chromosome:R64-1-1:VII:1:1090940:1 REF
>VIII dna:chromosome chromosome:R64-1-1:VIII:1:562643:1 REF
>IX dna:chromosome chromosome:R64-1-1:IX:1:439888:1 REF
>X dna:chromosome chromosome:R64-1-1:X:1:745751:1 REF
>XI dna:chromosome chromosome:R64-1-1:XI:1:666816:1 REF
>XII dna:chromosome chromosome:R64-1-1:XII:1:1078177:1 REF
>XIII dna:chromosome chromosome:R64-1-1:XIII:1:924431:1 REF
>XIV dna:chromosome chromosome:R64-1-1:XIV:1:784333:1 REF
>XV dna:chromosome chromosome:R64-1-1:XV:1:1091291:1 REF
>XVI dna:chromosome chromosome:R64-1-1:XVI:1:948066:1 REF
>Mito dna:chromosome chromosome:R64-1-1:Mito:1:85779:1 REF
```

For thoroughness, let's go ahead and get `README` and `CHECKSUMS` files for everything else we've downloaded from Ensembl in the last couple of days:
```zsh
cd "${HOME}/genomes/sacCer3/Ensembl/108"
alias .,s="ls -lhaFG ./*"
.,s
```

Results:
```txt
./cDNA:
total 12M
drwxrwx--- 2 kalavatt  178 Oct 25 17:12 ./
drwxrwx--- 5 kalavatt   64 Oct 26 13:44 ../
-rw-rw---- 1 kalavatt   79 Sep  2 07:04 CHECKSUMS
-rw-rw---- 1 kalavatt 2.5K Jul 25 10:21 README
-rw-rw---- 1 kalavatt  12M Oct 25 17:12 Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa
-rw-rw---- 1 kalavatt 3.7M Jul 25 10:21 Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz

./DNA:
total 4.6M
drwxrwx--- 2 kalavatt  120 Oct 26 13:46 ./
drwxrwx--- 5 kalavatt   64 Oct 26 13:44 ../
-rw-rw---- 1 kalavatt 3.8K Oct 26 13:46 CHECKSUMS
-rw-rw---- 1 kalavatt 4.9K Oct 26 13:46 README
-rw-rw---- 1 kalavatt 3.7M Oct 26 13:46 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz

./gtf:
total 14M
drwxrwx--- 2 kalavatt  240 Oct 25 17:12 ./
drwxrwx--- 5 kalavatt   64 Oct 26 13:44 ../
-rw-rw---- 1 kalavatt  140 Aug 11 14:07 CHECKSUMS
-rw-rw---- 1 kalavatt 9.2K Jul 29 08:56 README
-rw-rw---- 1 kalavatt  116 Jul 29 08:56 Saccharomyces_cerevisiae.R64-1-1.108.abinitio.gtf.gz
-rw-rw---- 1 kalavatt  10M Oct 25 17:12 Saccharomyces_cerevisiae.R64-1-1.108.gtf
-rw-rw---- 1 kalavatt 582K Jul 29 08:56 Saccharomyces_cerevisiae.R64-1-1.108.gtf.gz
```
Looks like I already did. Nice.

### 4. Now, get the genome `fasta` for *K. lactis* from what appears to be a special version of Ensembl for fungi, e.g., [here](https://fungi.ensembl.org) and a specific page for [*K. lactis*](https://fungi.ensembl.org/Kluyveromyces_lactis_gca_000002515/Info/Index)

Click the link ["Download DNA sequence"](http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/). Site contents:
```txt

[ICO]	Name	Last modified	Size	Description
[PARENTDIR]	Parent Directory	 	-	 
CHECKSUMS	2022-09-21 11:02	1.7K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.A.fa.gz	2022-08-16 05:28	324K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.B.fa.gz	2022-08-16 05:28	403K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.C.fa.gz	2022-08-16 05:28	535K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.D.fa.gz	2022-08-16 05:28	520K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.E.fa.gz	2022-08-16 05:28	681K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.chromosome.F.fa.gz	2022-08-16 05:28	793K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz	2022-08-16 05:28	3.2M	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.A.fa.gz	2022-08-16 05:28	323K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.B.fa.gz	2022-08-16 05:28	402K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.C.fa.gz	2022-08-16 05:28	534K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.D.fa.gz	2022-08-16 05:28	520K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.E.fa.gz	2022-08-16 05:28	680K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.chromosome.F.fa.gz	2022-08-16 05:28	793K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_rm.toplevel.fa.gz	2022-08-16 05:28	3.2M	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.A.fa.gz	2022-08-16 05:28	324K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.B.fa.gz	2022-08-16 05:28	403K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.C.fa.gz	2022-08-16 05:29	535K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.D.fa.gz	2022-08-16 05:29	521K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.E.fa.gz	2022-08-16 05:29	682K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.chromosome.F.fa.gz	2022-08-16 05:29	794K	 
Kluyveromyces_lactis_gca_000002515.ASM251v1.dna_sm.toplevel.fa.gz	2022-08-16 05:29	3.2M	 
README
```
Cool. Looks like we need `Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz`, `README`, and `CHECKSUMS`:
```zsh
cd "${HOME}/genomes/" || echo "cd failed. Check on this."
mkdir -p kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA && cd kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA

curl http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz > Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz
curl http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/README > README
curl http://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/dna/CHECKSUMS > CHECKSUMS

#  Grab some other files too: transcripts and annotations
cd ..
mkdir -p {cDNA,gff3}
cd cDNA || echo "cd failed. Check on this."

#  Getting errors: "curl: (51) SSL: no alternative certificate subject name
#+ matches target host name 'ftp.ensemblgenomes.org'"; try running curl in
#+ "--insecure" option
curl --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/cdna/Kluyveromyces_lactis_gca_000002515.ASM251v1.cdna.all.fa.gz > Kluyveromyces_lactis_gca_000002515.ASM251v1.cdna.all.fa.gz
curl --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/cdna/CHECKSUMS > CHECKSUMS
curl --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/fasta/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/cdna/README > README

cd ../gff3 || echo "cd failed. Check on this."

curl --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/gff3/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz > Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3.gz
curl --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/gff3/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/README > README
curl --insecure https://ftp.ensemblgenomes.org/pub/fungi/release-55/gff3/fungi_ascomycota1_collection/kluyveromyces_lactis_gca_000002515/CHECKSUMS > CHECKSUMS

#  Let's see what the chromosomes look like in the K. lactis fasta
cd ../DNA || echo "cd failed. Check on this."

fasta="Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz"
zgrep "^>" "${fasta}"
```

Results for chromosome names in `Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz`:
```txt
>A dna:chromosome chromosome:ASM251v1:A:1:1062590:1 REF
>B dna:chromosome chromosome:ASM251v1:B:1:1320834:1 REF
>C dna:chromosome chromosome:ASM251v1:C:1:1753957:1 REF
>D dna:chromosome chromosome:ASM251v1:D:1:1715506:1 REF
>E dna:chromosome chromosome:ASM251v1:E:1:2234072:1 REF
>F dna:chromosome chromosome:ASM251v1:F:1:2602197:1 REF
```

And what is the "chromosome name" for the 20 S narnavirus?
```zsh
cd "${HOME}/genomes/20S_RNA_Narnavirus_1997_NC004051/" || echo "cd failed. Check on this."

fasta="20S_RNA_Narnavirus_1997_NC004051.fasta"
zgrep "^>" "${fasta}"
```

### 5. Clean up the headers for the 20S narnavirus, *S. cerevisisae*, and *K. lactis*
Results for `20S_RNA_Narnavirus_1997_NC004051.fasta`
```txt
>gi|21557564|ref|NC_004051.1| Saccharomyces 20S RNA narnavirus, complete genome
```

Try renaming the "chromosome name" for the 20 S narnavirus
```zsh
cd "${HOME}/genomes/20S_RNA_Narnavirus_1997_NC004051/"

fasta="20S_RNA_Narnavirus_1997_NC004051.fasta"
awk '/^>/ {$0=$1} 1' "${fasta}" > "${fasta%.fasta}.chr-rename.fasta"
```

It works, but let's give the header a more informative string:
```zsh
fasta="20S_RNA_Narnavirus_1997_NC004051.chr-rename.fasta"
cp "${fasta}" "${fasta}.bak"

change_to=">20S"
sed -i "1s/.*/${change_to}/" "${fasta}"

head -5 "${fasta}"
```

Results for `20S_RNA_Narnavirus_1997_NC004051.chr-rename.fasta`
```txt
>20S
GGGGCTGATCCCATGAAGGAACCAGTAGACTGCCGTCTTTCGACGCCAGCCGGTTTCTCGGGGACAGTCC
CCCCTCCTGGTCGCACTAAGGCGGCCAGGCCGGGAACCATCCCTGTGAGGCGTTCGCGTGGAAGCGCGTC
TGCCTTACCGGGTAAAATCTACGGTTGGAGCCGTCGACAACGGGATAGGTTCGCGATGTTGCTGTCGTCT
TTCGACGCGGCTCTCGCGGCCTACTCCGGCGTCGTCGTCTCCAGAGGTACACGCTCTCTACCGCCATCGC
```

Change the chromosome names (headers) for *S. cerevisiae* and *K.lactis* by removing everything after (and including) the first space
```zsh
cd "${HOME}/genomes/sacCer3/Ensembl/108/DNA" || echo "cd failed. Check on this."

fasta="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz"
gunzip < "${fasta}" > "${fasta%.gz}"
awk '/^>/ {$0=$1} 1' "${fasta%.gz}" > "${fasta%.fa.gz}.chr-rename.fasta"
rm "${fasta%.gz}"
zgrep "^>" "${fasta%.fa.gz}.chr-rename.fasta"
```

Results for `Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta`:
```txt
>I
>II
>III
>IV
>V
>VI
>VII
>VIII
>IX
>X
>XI
>XII
>XIII
>XIV
>XV
>XVI
>Mito
```

```zsh
#  K. lactis
cd "${HOME}/genomes/kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA" || echo "cd failed. Check on this."

fasta="Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.fa.gz"
gunzip < "${fasta}" > "${fasta%.gz}"
awk '/^>/ {$0=$1} 1' "${fasta%.gz}" > "${fasta%.fa.gz}.chr-rename.fasta"
rm "${fasta%.gz}"
zgrep "^>" "${fasta%.fa.gz}.chr-rename.fasta"
```

Results for `Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.chr-rename.fasta`:
```txt
>A
>B
>C
>D
>E
>F
```

## Concatenate the *S. cerevisiae*, *K. lactis*, and *S20* genomes, creating a combined genome for RNA-seq and related analyses
```zsh
#  Make a directory for the combined genome
cd "${HOME}/genomes" || echo "cd failed. Check on this."
mkdir -p combined_SC_KL_20S  # For S. cerevisiae, K. lactis, and the 20 S narnavirus

fasta_SC="Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"
fasta_KL="Kluyveromyces_lactis_gca_000002515.ASM251v1.dna.toplevel.chr-rename.fasta"
fasta_20S="20S_RNA_Narnavirus_1997_NC004051.chr-rename.fasta"
fasta_comb="combined_SC_KL_20S.fasta"

cp "${HOME}/genomes/sacCer3/Ensembl/108/DNA/${fasta_SC}" combined_SC_KL_20S/
cp "${HOME}/genomes/kluyveromyces_lactis_gca_000002515/Ensembl/55/DNA/${fasta_KL}" combined_SC_KL_20S/
cp "${HOME}/genomes/20S_RNA_Narnavirus_1997_NC004051/${fasta_20S}" combined_SC_KL_20S/

cat "${fasta_SC}" "${fasta_KL}" "${fasta_20S}" > "${fasta_comb}"
zgrep ">" "${fasta_comb}"
```

Results for `combined_SC_KL_20S.fasta`:
```txt
>I
>II
>III
>IV
>V
>VI
>VII
>VIII
>IX
>X
>XI
>XII
>XIII
>XIV
>XV
>XVI
>Mito
>A
>B
>C
>D
>E
>F
>20S
```

```zsh
#  Make a directory for the combined genome
pwd  # /home/kalavatt/genomes/combined_SC_KL_20S
mkdir -p fasta_individual  # For S. cerevisiae, K. lactis, and the 20 S narnavirus

mv "${fasta_SC}" "${fasta_KL}" "${fasta_20S}" fasta_individual/

#  Index the fasta file
ml SAMtools/1.16.1-GCC-11.2.0 Bowtie2/2.4.4-GCC-11.2.0
samtools faidx "${fasta_comb}"

#  Create a Bowtie2 index (e.g., metagenomics.wiki/tools/bowtie2/index)
mkdir -p Bowtie2 
bowtie2-build combined_SC_KL_20S.fasta Bowtie2/combined_SC_KL_20S 1> combined_SC_KL_20S.bowtie2-build.stdout.txt

cd Bowtie2 || echo "cd failed. Check on this."
bowtie2-inspect -n ecoli  # It looks correct
cd ..
```

