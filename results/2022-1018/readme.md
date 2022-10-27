
# 2022-1018
## E-mail 1: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Monday, October 17, 2022 5:01 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Fred Hutch Server and a few of my scripts

### Scripts
- `New_101122_sc_bowtie_4tu.sh`
- `bam_split_paired_end.sh`
- `trin4.1_adjusted_salmo.sh`
- `map2genome_gff.sh`

### Contents
Hi Kris!

I know Toshi got a really fancy computer, so it may be better/faster to do this locally for you. For me, I use the server. 

Here is how you log in: [link](https://sciwiki.fredhutch.org/compdemos/first_rhino/)

Here are the modules available: [link](https://sciwiki.fredhutch.org/scicomputing/bio-modules-18.04/)

I attached some of the scripts I use for alignment and annotation. They are in brief:
1. Bowtie 4tU: does alignment and splits strands for paired end RNAseq
2. split paired end: called by bowtie 4tU makes strand specific bam files. Both 1 and 2 were mainly written by Christine's partner who is a software person. I have Frankensteined them to adjust a few things. 
3. trin4.1: the way I ran trinity. There are probably ways these settings could be tweaked. They were stollen from [this pre-print](https://www.biorxiv.org/content/10.1101/575837v1) and only changed slightly. 
4. map2genome: this takes the .fasta output and makes it a .gff annotation format aligned to the yeast genome 
5. Not included: bedtools classing of transcripts. I have messy notes on this but lots of it was directly in terminal. 

Trinity creates a lot of junk transcripts. It will connect things that overlap, and generally is oversensitive. I have tried filtering by mapping quality the bams that go into trinity, this helps but hasn't been the silver bullet. *I think running trinity with a bunch of different setting may be the solution*, but for me at least trinity takes a long long time to run so we will need to be strategic in our testing. 

Hope you feel better. Take your time with this; I know it's a lot of information. 

Best, 
Alison 

## E-mail 2: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Tuesday, October 18, 2022 2:11 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Re: Fred Hutch Server and a few of my scripts

### Attached files
- `heatmaps_nab3_nrd1.pptx`
- `20220928_lab_meeting.pptx`
- `scaling_factor.xlsx`

### Contents
NA

## E-mail 3: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Tuesday, October 18, 2022 2:12 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Re: Fred Hutch Server and a few of my scripts

### Attached files
NA

### Contents
(Concerns Nature Reviews on noncoding RNAs.)
- [How noncoding RNAs began to leave the junkyard | Nature Methods](https://www.nature.com/articles/s41592-022-01627-8?utm_source=nmeth_etoc&utm_medium=email&utm_campaign=toc_41592_19_10&utm_content=20221011)
- [Regulatory non-coding RNAs: everything is possible, but what is important? | Nature Methods](https://www.nature.com/articles/s41592-022-01629-6?utm_source=nmeth_etoc&utm_medium=email&utm_campaign=toc_41592_19_10&utm_content=20221011)
- [Some roads ahead for noncoding RNAs | Nature Methods](https://www.nature.com/articles/s41592-022-01628-7?utm_source=nmeth_etoc&utm_medium=email&utm_campaign=toc_41592_19_10&utm_content=20221011)

## E-mail 4: "Fred Hutch Server and a few of my scripts"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Tuesday, October 18, 2022 7:22 PM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Re: Fred Hutch Server and a few of my scripts

### Script
- `AG_CC_read_counts_RNA_April2022.sh`

### Contents
I realized I never gave you the script that counts reads for normalization. Here is that! (No need to look at it tonight!!!) 

Alison

# 2022-1019
## E-mail 1: "Nascent normalization remains baffling"
From: [Greenlaw, Alison C](agreenla@fredhutch.org)
Sent: Wednesday, October 19, 2022 7:30 AM
To: [Alavattam, Kris](kalavatt@fredhutch.org)
Subject: Nascent normalization remains baffling

### File
- `normalization_station.pptx`

### Contents
Hi Toshi - 

I messed around with the normalization, trying to get the big nascent discrepancy to make sense and I couldn't. I have attached the details. 

(Email scheduled for 7:30 am) 

Alison 

### Notes from meeting
(See notes in `notebook.md` for 2022-1019)
