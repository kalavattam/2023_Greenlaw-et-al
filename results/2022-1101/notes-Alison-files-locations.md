
`#2022-11`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Updated list of Alison's paths to important directories and files](#updated-list-of-alisons-paths-to-important-directories-and-files)
    1. [Locations of "processed `.bam` files"](#locations-of-processed-bam-files)
        1. [WTQvsG1](#wtqvsg1)
        1. [Nab3_Nrd1_Depletion](#nab3_nrd1_depletion)
        1. [Email chain between me and Alison](#email-chain-between-me-and-alison)
            1. [Message #1](#message-1)
            1. [Message #2](#message-2)
    1. [Locations of "raw `.fastq` files" and "UMI information"](#locations-of-raw-fastq-files-and-umi-information)
        1. [WTQvsG1](#wtqvsg1-1)
            1. [#1](#1)
            1. [#2](#2)
        1. [TRF4_SSRNA_April2022](#trf4_ssrna_april2022)
        1. [Nab3_Nrd1_Depletion](#nab3_nrd1_depletion-1)
                1. [#1](#1-1)
                1. [#2](#2-1)
        1. [Email chain between me and Alison on "raw" `.fastq` files and "UMI information"](#email-chain-between-me-and-alison-on-raw-fastq-files-and-umi-information)
            1. [Message #1](#message-1-1)
            1. [Message #2](#message-2-1)
    1. [Locations of other important files](#locations-of-other-important-files)
        1. [Email from Alison, 2022-1020](#email-from-alison-2022-1020)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="updated-list-of-alisons-paths-to-important-directories-and-files"></a>
## Updated list of Alison's paths to important directories and files
<a id="locations-of-processed-bam-files"></a>
### Locations of "processed `.bam` files"
...i.e., those that are ready for use with `htseq-count` or `featurecounts`

<a id="wtqvsg1"></a>
#### WTQvsG1
```bash
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/bam_resort
```

<a id="nab3_nrd1_depletion"></a>
#### Nab3_Nrd1_Depletion
```bash
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/SC_bams_all
```
- `#DONE` Double check that this is the correct location for "processed .bam files"
    + Seems not to be per [this email](#email-from-alison-2022-1020); for example, output of HTSeq `count` here:
```bash
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/S_cerevisiae_BamFiles/bam_resort/feature_counts_7716_6126
```

<a id="email-chain-between-me-and-alison"></a>
#### Email chain between me and Alison
<a id="message-1"></a>
##### Message #1
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Sent: Tuesday, November 1, 2022 10:19 AM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: .bam files for calculating TPM
 
Hi Alison,
 
In addition to Nab3_Nrd1_Depletion, was thinking to test my in-progress TPM code on some WTQvsG1 .bam files that you have processed (those that you’re using to run htseq-count/featurecounts). If there are any, can you let me know the location of some files?
 
Thanks,  
Kris

<a id="message-2"></a>
##### Message #2
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Tuesday, November 1, 2022 at 10:55 AM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: Re: .bam files for calculating TPM

Yes! 
 
There are bam files at:  
```bash
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq
```
Also resorted for HTseq:  
```bash
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/S_cerevisiae_BamFiles/HTSeq/bam_resort
```

I should be in in the next hour-ish so we can chat more then! 
 
Alison

<a id="locations-of-raw-fastq-files-and-umi-information"></a>
### Locations of "raw `.fastq` files" and "UMI information"
Notes and summary based on an email chain between me and Alison, [shown below](#email-chain-between-me-and-alison) and [above](#email-chains-between-alison-and-matt-fitzgibbon-fhcc-bioinformatician)
<a id="wtqvsg1-1"></a>
#### WTQvsG1
<a id="1"></a>
##### #1
```bash
~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot
```
- Demultiplexed but still contain PCR duplicates to be removed with UMI-tools
- The `.fastq` files in here look like this:
```txt
*_I1_001.fastq.gz
*_R1_001.fastq.gz
*_R2_001.fastq.gz
*_R3_001.fastq.gz
```

<a id="2"></a>
##### #2
```bash
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
```
- Demultiplexed but still contain PCR duplicates to be removed with UMI-tools
- These directories contain copies of the above `.fastq` files
```txt
*_R1_001.fastq
*_R1_002.fastq
*_R1_003.fastq
*_R1_004.fastq
*_R2_001.fastq
*_R2_002.fastq
*_R2_003.fastq
*_R2_004.fastq
```

<a id="trf4_ssrna_april2022"></a>
#### TRF4_SSRNA_April2022
```bash
~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla
#QUESTION What is this project?
#QUESTION Is this a project we're working on now? 
```

<a id="nab3_nrd1_depletion-1"></a>
#### Nab3_Nrd1_Depletion
<a id="1-1"></a>
###### #1
```bash
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}
```
- Demultiplexed but still contain PCR duplicates to be removed with UMI-tools
- Here, there are `.fastq` files with strings `*_R1_*` and `*_R3_*`, e.g.,
```txt
*_Nascent_S3_R1_001.fastq
*_Nascent_S3_R3_001.fastq
*_SteadyState_S8_R1_001.fastq
*_SteadyState_S8_R3_001.fastq
```

<a id="2-1"></a>
###### #2
```bash
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/5782_7714/UMI
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6125_7718/UMI
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/UMI

# i.e.,
# ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/UMI
```
- Here, there are .fastq files with strings: `*_R1_*`, `*_R2_*`, `*R3_`*, `*_I1_*`, and `*_I2_*`; how to handle them?
    + `#TODO (   )` Reference with [the email chains between Alison and Matt](#email-chains-between-alison-and-matt-fitzgibbon-fhcc-bioinformatician)
- How are these files different from the above?

<a id="email-chain-between-me-and-alison-on-raw-fastq-files-and-umi-information"></a>
#### Email chain between me and Alison on "raw" `.fastq` files and "UMI information"

<a id="message-1-1"></a>
##### Message #1
From: [Alavattam, Kris](kalavatt@fredhutch.org)  
Sent: Thursday, October 27, 2022 2:43 PM  
To: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Subject: Some questions about the fastq files
 
Hi Alison,
 
I just want to check my understanding regarding the fastq files: i.e., what is what, what I should try out for alignment and Trinity work, etc.

For the WT Q vs. G1 analyses, raw fastq files are in this directory:
```bash
~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot
```
1. These have not yet been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?
 
For the WT Q vs. G1 analyses as well, there are also raw fastq files in these directories:
```bash
~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
```
2. These files have been demultiplexed, but PCR duplicates remain in the fastq files—is that correct?
3. To save time, I am thinking I should use the `*_merged_R{1,2}.fastq` files for alignment to the combined reference (comprised of *S. cerevisiae*, *K. lactis*, and 20 S) and downstream steps: is that reasonable to you?
 
For WT vs. Nab3-depletion work, there are fastq files in these directories:
```bash
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}
```
4. These files have been demultiplexed, but PCR duplicates remain in the fastq files—is that correct?
 
Within each of the immediately above `{5782_7714,6125_7718,6126_7716}` directories, there are UMI subdirectories:
```bash
~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/UMI
```
5. These contain fastq files that have not been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?
 
Until I hear back from you, I will move forward with what I typed in question #3 above. I’ll appreciate any instructions, insights, and/or advice.
 
Thanks! And apologies for the questions while you’re off,
Kris

<a id="message-2-1"></a>
##### Message #2
From: [Greenlaw, Alison C](agreenla@fredhutch.or )  
Date: Thursday, October 27, 2022 at 2:58 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.or)  
Subject: Re: Some questions about the fastq files

Hi Kris! You caught me right before my flight so excellent timing. 
 
> To address your questions:  
> For the WT Q vs. G1 analyses, raw fastq files are in this directory:  
> ```bash
> ~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot
> ```
> 1. These have not yet been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?

Yes! They have been "demultiplexed" in that the core splits them by barcode but no UMI processing has been done. (Is this also known as demultiplexing?) PCR duplicates should be removed using UMI tools. Then, use those fastq files with UMI removed for alignment and Trinity work. 

> For the WT Q vs. G1 analyses as well, there are also raw fastq files in these directories:
> ```bash
> ~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_578*
> ```
> 2. These files have been demultiplexed, but PCR duplicates remain in the fastq files: is that correct?

Yep! 

> 3. To save time, I am thinking I should use the `*_merged_R{1,2}.fastq` files for alignment to the combined reference (comprised of *S. cerevisiae*, *K. lactis*, and 20 S) and downstream steps: is that reasonable to you?

This is definitely a good place to start! Perhaps we can re-do with UMI factored in later?

> For WT vs. Nab3-depletion work, there are fastq files in these directories:
> ```bash
> ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}
> ```
> 4. These files have been demultiplexed, but PCR duplicates remain in the fastq files: is that correct?

Yes!

> Within each of the immediately above `{5782_7714,6125_7718,6126_7716}` directories, there are UMI subdirectories:
> ```bash
> ~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/{5782_7714,6125_7718,6126_7716}/UMI
> ```
> 5. These contain fastq files that have not been demultiplexed and I should (perhaps not now but eventually) demultiplex them to remove PCR duplicates using UMI tools? Then, use the demultiplexed fastq files for alignment and Trinity work, right?

Yes - so R2 contains UMI info - it needs to be processed along with R1 and R3 to my knowledge if we are incorporating UMI info. 
 
Hopefully this is clarified for you! I think you are very much on the right track. I have not done any work to remove PCR duplicates, I have been saving UMI info for a future moment, that may or may not be soon depending on how much Trinity needs less coverage. 
 
Alison

<a id="locations-of-other-important-files"></a>
### Locations of other important files
<a id="email-from-alison-2022-1020"></a>
#### Email from Alison, 2022-1020
From: [Greenlaw, Alison C](agreenla@fredhutch.org)  
Date: Thursday, October 20, 2022 at 5:56 PM  
To: [Alavattam, Kris](kalavatt@fredhutch.org)  
Subject: File Locations

Hi Kris - 

Nab3 depletion data  
`~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla`

Folders of interest:
- I split samples for speed reasons. Raw fastq R1 and R3 reads in these 3 folders: 
    - 5782_7714
    - 6126_7716
    - 6125_7718
        - Within each folder is UMI folder with R2, I1 and I2 reads. We don't currently have a pipeline with includes them, but I have thought it would be good for a while. 
    - I copied all aligned bams into SC_bams_all
    - Output of HTSeq count (one for each folder above):
        - `~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/Sequencing/Project_agreenla/6126_7716/S_cerevisiae_BamFiles/bam_resort/feature_counts_7716_6126`

WT G1 vs Q data  
`~/tsukiyamalab/alisong/WTQvsG1/`

Folders of interest: 
- Raw fastq info
    - `~/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot`
    - each sample has a folder. The Bioinformatics core does it differently now. So fastq files used to need to be merged. 
    - "IP" = Nascent, "IN" = SteadyState
- Trinity Run Location
    - `~/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/all_at_once/correct_bams`
- Map trinity output to genome location
    - `~/tsukiyamalab/alisong/WTQvsG1/de_novo_annotation/map_trin_to_genome/try2`
- I started thinking about annotation automation. Not a ton here but some
    - `~/tsukiyamalab/alisong/WTQvsG1/automation_of_annotation`
- I attempted to break AS transcripts into Classes. That all happened here. This is probably the biggest mess of any of the above:
    - `~/tsukiyamalab/alisong/WTQvsG1/MANUAL/AS_CLASSES`
    - and: `~/tsukiyamalab/alisong/WTQvsG1/MANUAL/AS_CLASSES/jan2022_good`

Steady State Q entry Data
- `~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/Project_agreenla`
- This was all done for an old project but might be relevant to Toshi's interests and or the larger project

All the R stuff is local to my laptop/on my OneDrive. Happy to figure out a way to share than more easily. Also please let me know if there are file permission issues. 

Alison
