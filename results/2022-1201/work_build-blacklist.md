
`#work_build-blacklist.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Look up the commands I used to do my initial processing on 2022-1206](#look-up-the-commands-i-used-to-do-my-initial-processing-on-2022-1206)
1. [Emails with Alison about blacklists: *"Blacklist file"*](#emails-with-alison-about-blacklists-blacklist-file)
	1. [1: Alison → me `Monday, December 5, 2022 3:45 PM`](#1-alison-%E2%86%92-me-monday-december-5-2022-345-pm)
	1. [2: Me → Alison `Monday, December 5, 2022 at 4:05 PM`](#2-me-%E2%86%92-alison-monday-december-5-2022-at-405-pm)
	1. [3: Me → Alison `Tuesday, December 6, 2022 at 11:10 AM`](#3-me-%E2%86%92-alison-tuesday-december-6-2022-at-1110-am)
	1. [4: Me → Alison `Tuesday, December 6, 2022 11:16 AM`](#4-me-%E2%86%92-alison-tuesday-december-6-2022-1116-am)
	1. [5: Alison → me `Tuesday, December 6, 2022 11:44 AM`](#5-alison-%E2%86%92-me-tuesday-december-6-2022-1144-am)
		1. [*Note on what to blacklist and what to not*](#note-on-what-to-blacklist-and-what-to-not)
	1. [6: Me → Alison `Tuesday, December 6, 2022 at 11:47 AM`](#6-me-%E2%86%92-alison-tuesday-december-6-2022-at-1147-am)
	1. [7: Me → Alison `Tuesday, December 6, 2022 3:34 PM`](#7-me-%E2%86%92-alison-tuesday-december-6-2022-334-pm)
	1. [8: Alison → me `Wednesday, December 7, 2022 at 12:20 PM`](#8-alison-%E2%86%92-me-wednesday-december-7-2022-at-1220-pm)
	1. [9: Me → Alison `Wednesday, December 7, 2022 at 12:31 PM`](#9-me-%E2%86%92-alison-wednesday-december-7-2022-at-1231-pm)
	1. [10: Me → Alison `Wednesday, December 7, 2022 at 12:39 PM`](#10-me-%E2%86%92-alison-wednesday-december-7-2022-at-1239-pm)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="look-up-the-commands-i-used-to-do-my-initial-processing-on-2022-1206"></a>
## Look up the commands I used to do my initial processing on 2022-1206
```bash
#!/bin/bash

history | grep -i awk | less
```

<details>
<summary><i>Pertinent results from the call to history</i></summary>

```txt
32894  2022-12-06 10:49:49 cat gene_names.txt | awk -F '\t' '{ print $9 }'
32895  2022-12-06 10:50:31 cat gene_names.txt | awk -F '\t' '{ print $9 }' > gene_names.ID-field.txt
32898  2022-12-06 10:51:58 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }'
32899  2022-12-06 10:52:11 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }' | grep -v "Name="
32900  2022-12-06 10:53:17 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }' | grep -v "Name=" -
32922  2022-12-06 11:01:39 cat KA.other_features_genomic.names.ID-field.txt | awk -F ';' '{ print $2 }' | sed 's/Name=//' | head
32923  2022-12-06 11:03:18 cat KA.other_features_genomic.names.ID-field.txt | awk -F ';' '{ print $2 }' | sed 's/Name=//' | sort | uniq -c > KA.other_feature
```
</details>
<br />
<br />

<a id="emails-with-alison-about-blacklists-blacklist-file"></a>
## Emails with Alison about blacklists: *"Blacklist file"*
<a id="1-alison-%E2%86%92-me-monday-december-5-2022-345-pm"></a>
### 1: Alison → me `Monday, December 5, 2022 3:45 PM`
Hi Kris - 

You can find the .gff file for other genomics regions in `~/tsukiyamalab/alisong/annotation_files/other_regions` I downloaded the .fasta file from sgd, and then mapped it to the reference using gmap. The gff needs to be filtered to pick out the black list regions. We don't want to blacklist origins of replication or centromeres for example. Everything is labeled pretty clearly so I would just run a few quick awk scripts to filter, but I'm sure their are other ways too. Let know if you have any questions or issues. 

Here is the source for the fasta:  
[http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/)

Alison

<a id="2-me-%E2%86%92-alison-monday-december-5-2022-at-405-pm"></a>
### 2: Me → Alison `Monday, December 5, 2022 at 4:05 PM`
Thanks, this is great!

<a id="3-me-%E2%86%92-alison-tuesday-december-6-2022-at-1110-am"></a>
### 3: Me → Alison `Tuesday, December 6, 2022 at 11:10 AM`
Hi Alison,
 
It looks like there are 850 unique `Name=Something` features in the .gff file. Is there a quick way for me to know which to include in the blacklist and which to not? No rush at all. You can see the unique elements in `~/tsukiyamalab/alisong/annotation_files/other_regions/KA.other_features_genomic.sort-uniq-tally.txt`.
 
Also, do you think that blacklisting the telomeric repeats in this file will be enough to prevent the weird Trinity annotations we see in telomeric regions, or should we go with a complete 10-kb blacklisting of the starts and ends of chromosomes? Or perhaps both?
 
Thanks,  
Kris

<a id="4-me-%E2%86%92-alison-tuesday-december-6-2022-1116-am"></a>
### 4: Me → Alison `Tuesday, December 6, 2022 11:16 AM`
Ah—-I temporarily forgot about Christine’s telomere annotations. I think they’re from the UCSC table browser. If they look reasonable, perhaps we can just use those in place of blanket 10-kb blacklistings...

<a id="5-alison-%E2%86%92-me-tuesday-december-6-2022-1144-am"></a>
### 5: Alison → me `Tuesday, December 6, 2022 11:44 AM`
Hi Kris - 

Here are some notes on those region names. Let me know if you have any questions. 

Alison

<a id="note-on-what-to-blacklist-and-what-to-not"></a>
#### *Note on what to blacklist and what to not*
```txt
Region names. How I think we should deal with each category of region as based on how the name starts: 

ARS - Autonomously Replicating Sequence, aka origin of replication, don’t blacklist

CEN - centromere, don’t blacklist

HML/HMR - silent mating type cassette array, don’t blacklist

MATALPHA - mating type locus. We use mata instead of mat@ so this can be blacklisted. Maybe ask Toshi if it is worth adjusting the reference to the correct mating type. He will probably say no.

NTS - Non-transcribed region of the rDNA repeat, probably depleted by depletion probes but can blacklist

ORI - mitochondrial origin of replication, don’t need to blacklist

RE301 - recombination enhancer, don’t blacklist

TEL - telomere, use Christine’s

VDE - intein encoding region, don’t blacklist

Y - every yeast chromosome named as Y (yeast) A-P (chromosome 1-16, with 1 being A, and 16 being P) and L or R (left or right of centromere). Fairly sure these are all long terminal repeats of some kind and should be blacklisted.
```

<a id="6-me-%E2%86%92-alison-tuesday-december-6-2022-at-1147-am"></a>
### 6: Me → Alison `Tuesday, December 6, 2022 at 11:47 AM`

Very clear, thanks!

<a id="7-me-%E2%86%92-alison-tuesday-december-6-2022-334-pm"></a>
### 7: Me → Alison `Tuesday, December 6, 2022 3:34 PM`

Hi Alison,
 
This is just a rough-draft thought we can talk about when you’re back in the lab: I feel a little frightened or wary to blacklist all the LTRs since they and other REs (repetitive elements) make up parts of some genes, especially lncRNA-coding ones, and some other features like TFBS. (At least, that’s the case for mammals; I’m not up on the bio of REs in yeast, so correct me if this is incorrect.) Although I don’t know, I’m thinking that it could affect the transcripts that we build at those particular genes and features with Trinity.
 
Also, forgive my ignorance, but is Ty1 a specific RE or is it a class of REs containing a bunch of individually named REs?
 
Thanks,  
Kris

<a id="8-alison-%E2%86%92-me-wednesday-december-7-2022-at-1220-pm"></a>
### 8: Alison → me `Wednesday, December 7, 2022 at 12:20 PM`

Thinking about this more, I think it's reasonable to make the least conservative blacklist, use that and then only go more aggressive if there are still issues a more extensive blacklist could fix. 

Alison

<a id="9-me-%E2%86%92-alison-wednesday-december-7-2022-at-1231-pm"></a>
### 9: Me → Alison `Wednesday, December 7, 2022 at 12:31 PM`

By most conservative, do you mean all telomere regions in the file from Christine plus the stuff associated with “Y” as mentioned in the .rtf file you sent? (And possibly mat@ too?)

```txt
Y - every yeast chromosome named as Y (yeast) A-P (chromosome 1-16, with 1 being A, and 16 being P) and L or R (left or right of centromere). Fairly sure these are all long terminal repeats of some kind and should be blacklisted.
```

<a id="10-me-%E2%86%92-alison-wednesday-december-7-2022-at-1239-pm"></a>
### 10: Me → Alison `Wednesday, December 7, 2022 at 12:39 PM`

For a least conservative version, I think we’d be good to start with just the telomere regions in Christine’s file (also, we need to confirm the source of this file and how it was generated--my initial work suggests it’s from the UCSC table browser, but I’m not yet certain about that).
 
For a more conservative version, I think we’d be good to try the regions in Christine’s file, Ty1-* sequences, and telomeric-repeat sequences.
 
For a very conservative version, I think we’d be good to try the above plus all other LTRs (or whatever each “Y” feature is).
 
In IGV, do you see any out-of-place spikes in 4tU-seq signal that look like they could be the result of non-specific alignment?

