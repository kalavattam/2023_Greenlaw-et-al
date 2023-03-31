
`#work_gff3_include-20S.md`
<br />
<br />

<details>
<summary><i>Printed: Contents of 20S_RNA_Narnavirus_1997_NC004051.fasta</i></summary>

```txt
❯ cat 20S_RNA_Narnavirus_1997_NC004051.fasta
>gi|21557564|ref|NC_004051.1| Saccharomyces 20S RNA narnavirus, complete genome
GGGGCTGATCCCATGAAGGAACCAGTAGACTGCCGTCTTTCGACGCCAGCCGGTTTCTCGGGGACAGTCC
CCCCTCCTGGTCGCACTAAGGCGGCCAGGCCGGGAACCATCCCTGTGAGGCGTTCGCGTGGAAGCGCGTC
TGCCTTACCGGGTAAAATCTACGGTTGGAGCCGTCGACAACGGGATAGGTTCGCGATGTTGCTGTCGTCT
TTCGACGCGGCTCTCGCGGCCTACTCCGGCGTCGTCGTCTCCAGAGGTACACGCTCTCTACCGCCATCGC
TCCGGTTATTCCGGGCGATGACGCGTAAGTGGCTTTCAGTGACCGCCCGCGGGAACGGGGTCGAGTTCGC
CATCGCTTCTGCGAAGGAGTTCTCAGCCGCGTGCCGCGCGGGTTGGATTTCGGGGACCGTTCCGGACCAC
TTCTTTATGAAGTGGCTTCCGGAACCCGTTCGCCGTAAATCCGGGTTGTGGGCCCAGCTTTCATTCATTG
GACGTTCGCTCCCCGAGGGGGGCGACCGCCATGAAATCGAGGCGTTGGCCAACCACAAGGCTGCGTTGTC
CAGTTCCTTTGAGGTTCCTGCGGACGTACTTACGTCTCTAAGGAATTACTCAGAGGACTGGGCCCGCCGC
CACCTCGCTGCGGATCCTGATCCTTCGCTGCTCTGTGAGCCCTGTACGGGTAACAGCGCAACGTTCGAAC
GGACTCGCCGCGAGGGTGGTTTTGCACAATCGATCACTGACTTGGTTTCGTCCTCACCCACTGACAACCT
CCCTCCCCTTGAGTCGATGCCCTTCGGGCCGACCCAAGGCCAGGCGTTGCCAGTGCACGTGCTCGAGGTC
TCTCTCTCTCGATACCACAATGGCTCAGACCCTAAGGGTAGAGTCTCTGTGGTGAGGGAGAGAGGCCACA
AGGTCCGTGTGGTCTCTGCAATGGAGACTCACGAACTTGTACTCGGTCACGCGGCTAGGCGCAGACTCTT
TAAGGGACTGCGTCGTGAGCGTCGTCTCAGGGACACCCTCAAGGGTGACTTCGAGGCGACAACCAAGGCC
TTTGTGGGTTGTGCTGGTACCGTTATCTCATCAGATATGAAATCTGCCTCGGACCTCATCCCTCTATCGG
TCGCTTCTGCGATCGTAGATGGTCTGGAGGCCTCTGGTAGACTCCTACCTGTCGAGATAGCTGGTCTTCG
GGCCTGTACTGGCCCTCAGCACTTAGTCTACCCTGACGGTTCTGAAATCACCACACGGCGAGGGATCCTT
ATGGGACTCCCCACCACGTGGGCGATTCTGAATCTCATGCACCTATGGTGCTGGGATTCTGCGGATCGTC
AGTATAGATTAGAGGGACATCCCTTCCGCGCCACGGTTAGATCGGATTGTCGCGTTTGCGGCGACGATCT
AATCGGCGTGGGTCCGGACTCCTTACTACGGTCTTATGACCGCAATTTGGGTCTGGTTGGGATGATCCTC
TCCCCTGGCAAGCACTTCCGCAGTAACAGGAGGGGGGTCTTCCTCGAGCGTTTACTCGAGTTCCAGACCC
GTAAAACCGTGTACGAACACGCTGTGATTTACCGTAAGGTAGGTCACCGTCGCGTGCCCGTGGATCGGTC
TCACATTCCCGTCGTCACCCGAGTGACCGTCCTGAATACCATCCCACTTAAAGGGTTGGTTCGGGCTTCG
GTTCTCGGTCGTGACGATCCTCCCGTTTGGTGGGCTGCGGCCGTGGCGGAGTCTTCACTGCTCAGTGACT
ATCCTCGTAAGAAGATATTCGCTGCAGCACGGACTCTCCGCCCTGGCCTCTCCCGCCAATTCAGAAGGTT
GGGAATCCCACCATTCCTCCCCCGTGAACTCGGGGGCGCAGGCTTGGTCGGACCTTCCGATCGTGTCGAC
GCCCCTGCGTTCCACAGGAAAGCCATTTCTTCCCTGGTGTGGGGCTCTGATGCCACTGCTGCATACAGTT
TTATCCGTATGTGGCAGGGGTTCGAGGGCCACCCTTGGAAGACGGCGGCCTCACAGGAGACGGACACTTG
GTTCGCCGACTATAAGGTCACCCGGCCGGGTAAGATGTACCCAGACCGTTACGGCTTTCTTGATGGAGAG
TCTCTTCGGACCAAGTCAACTATGTTGAACTCGGCCGTCTATGAGACTTTTCTCGGACCTGACCCTGACG
CCACCCATTACCCTTCCTTGCGAATCGTCGCCAGTAGACTGGCGAAGGTCCGGAAGGATTTGGTAAATCG
GTGGCCATCGGTCAAGCCCGTGGGGAAGGATCTTGGTACCATCTTAGAAGCTTTCGAAGAGTCAAAGTTG
TGCACCCTTTGGGTGACACCTTACGACGCTTCGGGCTACTTTGATGATTCCTTGTTACTGATGGATGAGA
GCGTGTACCAACGTAGATTCCGGCAACTGGTCATTGCCGGCTTGATGCGTGAGGGCCGGATGGGCGACTT
ATTGTTTCCCAACTGGCTTCCACCATCCACCGTGGTCTCGGGTTTCCCCTGAGGCCACGGCCCC
```
</details>
<br />

<details>
<summary><i>Code: Add 20S to combined_SC_KL.gff3 (new combined_SC_KL_20S.gff3)</i></summary>

```bash
#!/bin/bash

cd "${HOME}/genomes/combined_SC_KL_20S/gff3"
.,

mv combined_SC_KL.gff3 bak.combined_SC_KL.gff3
mv combined_SC_KL.gff3.gz bak.combined_SC_KL.gff3.gz
.,

cp bak.combined_SC_KL.gff3 combined_SC_KL_20S.gff3

tail -20 bak.combined_SC_KL.gff3

echo "20S sgd gene 1 2514 . + . ID=gene:20S;biotype=20S" \
	| tr ' ' '\t' \
		>> combined_SC_KL_20S.gff3

echo "20S sgd mRNA 1 2514 . + . ID=transcript:20S_mRNA;Parent=gene:20S;Name=20S;biotype=protein_coding;tag=custom_KA;transcript_id=20S_mRNA" \
	| tr ' ' '\t' \
		>> combined_SC_KL_20S.gff3

echo "20S sgd exon 1 2514 . + . ID=20S_mRNA-E1;Parent=transcript:20S_mRNA;Name=20S_mRNA-E1;constitutive=1;exon_id=20S_mRNA-E1;rank=1" \
	| tr ' ' '\t' \
		>> combined_SC_KL_20S.gff3

echo "20S sgd gene 1 2514 . + . ID=gene:20S;biotype=protein_coding;description=20S" \
	| tr ' ' '\t' \
		>> combined_SC_KL_20S.gff3

echo "20S sgd CDS 1 2514 . + 0 ID=CDS:20S;Parent=transcript:20S_mRNA;protein_id=20S" \
	| tr ' ' '\t' \
		>> combined_SC_KL_20S.gff3

tail combined_SC_KL_20S.gff3

gzip -k combined_SC_KL_20S.gff3
zcat combined_SC_KL_20S.gff3.gz | tail
.,

mv bak.combined_SC_KL.gff3 combined_SC_KL.gff3
mv bak.combined_SC_KL.gff3.gz combined_SC_KL.gff3.gz
.,
```
</details>
<br />

<details>
<summary><i>Printed: Add 20S to combined_SC_KL.gff3 (new combined_SC_KL_20S.gff3)</i></summary>

```txt
❯ cd "${HOME}/genomes/combined_SC_KL_20S/gff3" \
>     || echo "cd'ing failed; check on this"


❯ .,
total 10M
drwxrwx--- 2 kalavatt   77 Feb 15 21:17 ./
drwxrwx--- 7 kalavatt  113 Feb  1 15:11 ../
-rw-rw---- 1 kalavatt 8.5M Jan  5 13:32 combined_SC_KL.gff3
-rw-rw---- 1 kalavatt 1.4M Jan  5 13:32 combined_SC_KL.gff3.gz


❯ mv combined_SC_KL.gff3 bak.combined_SC_KL.gff3
renamed 'combined_SC_KL.gff3' -> 'bak.combined_SC_KL.gff3'


❯ mv combined_SC_KL.gff3.gz bak.combined_SC_KL.gff3.gz
renamed 'combined_SC_KL.gff3.gz' -> 'bak.combined_SC_KL.gff3.gz'


❯ .,
total 10M
drwxrwx--- 2 kalavatt   85 Feb 16 12:22 ./
drwxrwx--- 7 kalavatt  113 Feb  1 15:11 ../
-rw-rw---- 1 kalavatt 8.5M Jan  5 13:32 bak.combined_SC_KL.gff3
-rw-rw---- 1 kalavatt 1.4M Jan  5 13:32 bak.combined_SC_KL.gff3.gz


❯ cp bak.combined_SC_KL.gff3 combined_SC_KL_20S.gff3
'bak.combined_SC_KL.gff3' -> 'combined_SC_KL_20S.gff3'


❯ tail -20 bak.combined_SC_KL.gff3
VI	sgd	CDS	253429	253734	.	-	0	ID=CDS:YFR052C-A;Parent=transcript:YFR052C-A_mRNA;protein_id=YFR052C-A
VI	sgd	mRNA	253592	255049	.	-	.	ID=transcript:YFR053C_mRNA;Parent=gene:YFR052C-A;Name=HXK1;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR053C_mRNA
VI	sgd	exon	253592	255049	.	-	.	ID=YFR053C_mRNA-E1;Parent=transcript:YFR053C_mRNA;Name=YFR053C_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR053C_mRNA-E1;rank=1
VI	sgd	CDS	253592	255049	.	-	0	ID=CDS:YFR053C;Parent=transcript:YFR053C_mRNA;protein_id=YFR053C
VI	sgd	gene	258855	259433	.	-	.	ID=gene:YFR054C;biotype=protein_coding;description=Putative protein of unknown function%3B conserved among S. cerevisiae strains [Source:SGD%3BAcc:S000001950];gene_id=YFR054C;logic_name=sgd
VI	sgd	mRNA	258855	259433	.	-	.	ID=transcript:YFR054C_mRNA;Parent=gene:YFR054C;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR054C_mRNA
VI	sgd	exon	258855	259433	.	-	.	ID=YFR054C_mRNA-E1;Parent=transcript:YFR054C_mRNA;Name=YFR054C_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR054C_mRNA-E1;rank=1
VI	sgd	CDS	258855	259433	.	-	0	ID=CDS:YFR054C;Parent=transcript:YFR054C_mRNA;protein_id=YFR054C
VI	sgd	gene	263957	264325	.	-	.	ID=gene:YFR056C;biotype=protein_coding;description=Dubious open reading frame%3B unlikely to encode a functional protein%2C based on available experimental and comparative sequence data%3B partially overlaps the uncharacterized gene YFR055W [Source:SGD%3BAcc:S000001951];gene_id=YFR056C;logic_name=sgd
VI	sgd	mRNA	263957	264325	.	-	.	ID=transcript:YFR056C_mRNA;Parent=gene:YFR056C;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR056C_mRNA
VI	sgd	exon	263957	264325	.	-	.	ID=YFR056C_mRNA-E1;Parent=transcript:YFR056C_mRNA;Name=YFR056C_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR056C_mRNA-E1;rank=1
VI	sgd	CDS	263957	264325	.	-	0	ID=CDS:YFR056C;Parent=transcript:YFR056C_mRNA;protein_id=YFR056C
VI	sgd	gene	264204	265226	.	+	.	ID=gene:YFR055W;Name=IRC7;biotype=protein_coding;description=Beta-lyase involved in the production of thiols%3B null mutant displays increased levels of spontaneous Rad52p foci%3B expression induced by nitrogen limitation in a GLN3%2C GAT1-dependent manner and by copper levels in a Mac1-dependent manner [Source:SGD%3BAcc:S000001952];gene_id=YFR055W;logic_name=sgd
VI	sgd	mRNA	264204	265226	.	+	.	ID=transcript:YFR055W_mRNA;Parent=gene:YFR055W;Name=IRC7;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR055W_mRNA
VI	sgd	exon	264204	265226	.	+	.	ID=YFR055W_mRNA-E1;Parent=transcript:YFR055W_mRNA;Name=YFR055W_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR055W_mRNA-E1;rank=1
VI	sgd	CDS	264204	265226	.	+	0	ID=CDS:YFR055W;Parent=transcript:YFR055W_mRNA;protein_id=YFR055W
VI	sgd	gene	269061	269516	.	+	.	ID=gene:YFR057W;biotype=protein_coding;description=Putative protein of unknown function [Source:SGD%3BAcc:S000001953];gene_id=YFR057W;logic_name=sgd
VI	sgd	mRNA	269061	269516	.	+	.	ID=transcript:YFR057W_mRNA;Parent=gene:YFR057W;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR057W_mRNA
VI	sgd	exon	269061	269516	.	+	.	ID=YFR057W_mRNA-E1;Parent=transcript:YFR057W_mRNA;Name=YFR057W_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR057W_mRNA-E1;rank=1
VI	sgd	CDS	269061	269516	.	+	0	ID=CDS:YFR057W;Parent=transcript:YFR057W_mRNA;protein_id=YFR057W


❯ echo "20S sgd gene 1 2514 . . . ID=gene:20s;biotype=20s" \
>     | tr ' ' '\t' \
>         >> combined_SC_KL_20S.gff3


❯ echo "20S sgd mRNA 1 2514 . . . ID=transcript:20S_mRNA;Parent=gene:20S;Name=20S;biotype=protein_coding;tag=custom_KA;transcript_id=20S_mRNA" \
>     | tr ' ' '\t' \
>         >> combined_SC_KL_20S.gff3


❯ echo "20S sgd exon 1 2514 . . . ID=20S_mRNA-E1;Parent=transcript:20S_mRNA;Name=20S_mRNA-E1;constitutive=1;exon_id=20S_mRNA-E1;rank=1" \
>     | tr ' ' '\t' \
>         >> combined_SC_KL_20S.gff3


❯ echo "20S sgd gene 1 2514 . . . ID=CDS:20S;Parent=transcript:20S_mRNA;protein_id=20S" \
>     | tr ' ' '\t' \
>         >> combined_SC_KL_20S.gff3


❯ tail combined_SC_KL_20S.gff3
VI	sgd	CDS	264204	265226	.	+	0	ID=CDS:YFR055W;Parent=transcript:YFR055W_mRNA;protein_id=YFR055W
VI	sgd	gene	269061	269516	.	+	.	ID=gene:YFR057W;biotype=protein_coding;description=Putative protein of unknown function [Source:SGD%3BAcc:S000001953];gene_id=YFR057W;logic_name=sgd
VI	sgd	mRNA	269061	269516	.	+	.	ID=transcript:YFR057W_mRNA;Parent=gene:YFR057W;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR057W_mRNA
VI	sgd	exon	269061	269516	.	+	.	ID=YFR057W_mRNA-E1;Parent=transcript:YFR057W_mRNA;Name=YFR057W_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR057W_mRNA-E1;rank=1
VI	sgd	CDS	269061	269516	.	+	0	ID=CDS:YFR057W;Parent=transcript:YFR057W_mRNA;protein_id=YFR057W
20S	sgd	gene	1	2514	.	+	.	ID=gene:20S;biotype=20S
20S	sgd	mRNA	1	2514	.	+	.	ID=transcript:20S_mRNA;Parent=gene:20S;Name=20S;biotype=protein_coding;tag=custom_KA;transcript_id=20S_mRNA
20S	sgd	exon	1	2514	.	+	.	ID=20S_mRNA-E1;Parent=transcript:20S_mRNA;Name=20S_mRNA-E1;constitutive=1;exon_id=20S_mRNA-E1;rank=1
20S	sgd	gene	1	2514	.	+	.	ID=gene:20S;biotype=protein_coding;description=20S
20S	sgd	CDS	1	2514	.	+	0	ID=CDS:20S;Parent=transcript:20S_mRNA;protein_id=20S


❯ gzip -k combined_SC_KL_20S.gff3


❯ zcat combined_SC_KL_20S.gff3.gz | tail
VI	sgd	CDS	264204	265226	.	+	0	ID=CDS:YFR055W;Parent=transcript:YFR055W_mRNA;protein_id=YFR055W
VI	sgd	gene	269061	269516	.	+	.	ID=gene:YFR057W;biotype=protein_coding;description=Putative protein of unknown function [Source:SGD%3BAcc:S000001953];gene_id=YFR057W;logic_name=sgd
VI	sgd	mRNA	269061	269516	.	+	.	ID=transcript:YFR057W_mRNA;Parent=gene:YFR057W;biotype=protein_coding;tag=Ensembl_canonical;transcript_id=YFR057W_mRNA
VI	sgd	exon	269061	269516	.	+	.	ID=YFR057W_mRNA-E1;Parent=transcript:YFR057W_mRNA;Name=YFR057W_mRNA-E1;constitutive=1;ensembl_end_phase=0;ensembl_phase=0;exon_id=YFR057W_mRNA-E1;rank=1
VI	sgd	CDS	269061	269516	.	+	0	ID=CDS:YFR057W;Parent=transcript:YFR057W_mRNA;protein_id=YFR057W
20S	sgd	gene	1	2514	.	+	.	ID=gene:20S;biotype=20S
20S	sgd	mRNA	1	2514	.	+	.	ID=transcript:20S_mRNA;Parent=gene:20S;Name=20S;biotype=protein_coding;tag=custom_KA;transcript_id=20S_mRNA
20S	sgd	exon	1	2514	.	+	.	ID=20S_mRNA-E1;Parent=transcript:20S_mRNA;Name=20S_mRNA-E1;constitutive=1;exon_id=20S_mRNA-E1;rank=1
20S	sgd	gene	1	2514	.	+	.	ID=gene:20S;biotype=protein_coding;description=20S
20S	sgd	CDS	1	2514	.	+	0	ID=CDS:20S;Parent=transcript:20S_mRNA;protein_id=20S


❯ .,
total 16M
drwxrwx--- 2 kalavatt  170 Feb 16 13:29 ./
drwxrwx--- 7 kalavatt  113 Feb  1 15:11 ../
-rw-rw---- 1 kalavatt 8.5M Jan  5 13:32 bak.combined_SC_KL.gff3
-rw-rw---- 1 kalavatt 1.4M Jan  5 13:32 bak.combined_SC_KL.gff3.gz
-rw-rw---- 1 kalavatt 8.5M Feb 16 12:27 combined_SC_KL_20S.gff3
-rw-rw---- 1 kalavatt 1.4M Feb 16 12:27 combined_SC_KL_20S.gff3.gz


❯ mv bak.combined_SC_KL.gff3 combined_SC_KL.gff3
renamed 'bak.combined_SC_KL.gff3' -> 'combined_SC_KL.gff3'


❯ mv bak.combined_SC_KL.gff3.gz combined_SC_KL.gff3.gz
renamed 'bak.combined_SC_KL.gff3.gz' -> 'combined_SC_KL.gff3.gz'


❯ .,
total 23M
drwxrwx--- 2 kalavatt  162 Mar 31 05:57 ./
drwxrwx--- 7 kalavatt  169 Mar 31 05:35 ../
-rw-rw---- 1 kalavatt 8.5M Mar 31 05:53 combined_SC_KL_20S.gff3
-rw-rw---- 1 kalavatt 1.4M Mar 31 05:53 combined_SC_KL_20S.gff3.gz
-rw-rw---- 1 kalavatt 8.5M Jan  5 13:32 combined_SC_KL.gff3
-rw-rw---- 1 kalavatt 1.4M Jan  5 13:32 combined_SC_KL.gff3.gz
```
</details>
<br />
