
`#work_model-variables.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Emails: Quick guide to know what 4tU-seq filenames represent what](#emails-quick-guide-to-know-what-4tu-seq-filenames-represent-what)
	1. [1](#1)
	1. [2](#2)
	1. [3](#3)
1. [Build variable matrix](#build-variable-matrix)
	1. [Identifying replicate numbers from Alison's descriptions](#identifying-replicate-numbers-from-alisons-descriptions)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="emails-quick-guide-to-know-what-4tu-seq-filenames-represent-what"></a>
## Emails: Quick guide to know what 4tU-seq filenames represent what
<a id="1"></a>
### 1
```
From: Alavattam, Kris <kalavatt@fredhutch.org>
Sent: Thursday, February 16, 2023 11:44 AM
To: Greenlaw, Alison C <agreenla@fredhutch.org>
Cc: Tsukiyama, Toshio <ttsukiya@fredhutch.org>
Subject: Quick guide to know what 4tU-seq filenames represent what
```

Hi Alison,
 
In this list of 55 datasets, can you give me a quick guide to know what filenames represent what? For example, things like, which are the NNS data, which are the rr-something data, which are the time-course data, how to read and interpret Sm and Sp, etc.?  For the code and analyses I am working on, it’d be good for me to know sometime today.
 
Also, are there other datasets of interest to the project that are not included below? If so, please let me know.
 
Thanks,
Kris
 
P.S. Of course, I know what the 578{1,2} files are already.

```txt
5781_G1_IN
5781_G1_IP
5781_Q_IN
5781_Q_IP
5782_G1_IN
5782_G1_IP
5782_Q_IN
5782_Q_IP
BM10_DSp48_5781
BM11_DSp48_7080
BM1_DSm2_5781
BM2_DSm2_7080
BM3_DSm2_7079
BM4_DSp2_5781
BM5_DSp2_7080
BM6_DSp2_7079
BM7_DSp24_5781
BM8_DSp24_7080
BM9_DSp24_7079
Bp10_DSp48_5782
Bp11_DSp48_7081
Bp12_DSp48_7078
Bp1_DSm2_5782
Bp2_DSm2_7081
Bp3_DSm2_7078
Bp4_DSp2_5782
Bp5_DSp2_7081
Bp6_DSp2_7078
Bp7_DSp24_5782
Bp8_DSp24_7081
Bp9_DSp24_7078
CT10_7718_pIAA_Q_Nascent
CT10_7718_pIAA_Q_SteadyState
CT2_6125_pIAA_Q_Nascent
CT2_6125_pIAA_Q_SteadyState
CT4_6126_pIAA_Q_Nascent
CT4_6126_pIAA_Q_SteadyState
CT6_7714_pIAA_Q_Nascent
CT6_7714_pIAA_Q_SteadyState
CT8_7716_pIAA_Q_Nascent
CT8_7716_pIAA_Q_SteadyState
CU11_5782_Q_Nascent
CU12_5782_Q_SteadyState
CW10_7747_8day_Q_IN
CW10_7747_8day_Q_PD
CW12_7748_8day_Q_IN
CW12_7748_8day_Q_PD
CW2_5781_8day_Q_IN
CW2_5781_8day_Q_PD
CW4_5782_8day_Q_IN
CW4_5782_8day_Q_PD
CW6_7078_8day_Q_IN
CW6_7078_8day_Q_PD
CW8_7079_8day_Q_IN
CW8_7079_8day_Q_PD
```

<a id="2"></a>
### 2
```
From: Greenlaw, Alison C <agreenla@fredhutch.org>
Date: Thursday, February 16, 2023 at 12:18 PM
To: Alavattam, Kris <kalavatt@fredhutch.org>
Cc: Tsukiyama, Toshio <ttsukiya@fredhutch.org>
Subject: Re: Quick guide to know what 4tU-seq filenames represent what
```

Hi Kris - 
 
Happy to help! This naming system was designed so that I know what everything is, but I can understand why it would not easily be interpretable without a bit of additional info. 
 
The letter code (starting with B or C here) ie Bp10/BM12/CT4 etc is how I name tubes so I always know what's in them and what day they were made. Each experiment gets a letter code and then all the samples are 1 through however many samples. I do this because I realized I was going to have hundreds of tubes with very similar labels since I work on the same genes for a long period of time. For your purposes these numbers are nonsense, but they mean I can track down the exact day and exact tube everything came from. 
 
Any 4 four digit number refers to strain. 
5781/2 - Wild Type
7078/7079 - rrp6 null 
7080/7081 - trf4 null 
6125/6 - Ostir depletion background parental
7714 - double tag Nrd1/Nab3 depletion 
7716/8 - single tag depletion of Nab3
7747/8 - rtr1 null 
 
There are also codes which refer to time point and condition:
DSm2 - diauxic shift minus two hours
DSp2 - diauxic shift plus two hours
DSp24 - diauxic shift plus 24 hours
DSp48 - diauxic shift plus 48 hours
Q - Quiescent
8day_Q - Quiescent but harvested on day 8 instead of day 7 (this is because rrp6 null hates growing)
pIAA - plus IAA (auxin used to deplete) 
 
There is also info about if it is steady state or nascent:
PD/IP/Nascent - all mean nascent
IN/SteadyState - all mean steady state
entire BP/BM time course is steady state so no modifiers here. 
 
Hope that helps! If renaming these files would be helpful to you, we can chat about how to do so. I am happy to make it more standard across experiments; my main goal as I was doing these was to standardize them within experiments. 
 
Alison

<a id="3"></a>
### 3
```
From: Alavattam, Kris <kalavatt@fredhutch.org>
Sent: Thursday, February 16, 2023 12:33 AM
To: Greenlaw, Alison C <agreenla@fredhutch.org>
Cc: Tsukiyama, Toshio <ttsukiya@fredhutch.org>
Subject: Re: Quick guide to know what 4tU-seq filenames represent what
```

Super helpful&mdash;thank you! No need to rename any of the files, and everything you typed up makes sense. I’ll use the details to make easy-to-read legends for the plots I am generating.
 
-Kris
<br />
<br />

<a id="build-variable-matrix"></a>
## Build variable matrix
<a id="identifying-replicate-numbers-from-alisons-descriptions"></a>
### Identifying replicate numbers from Alison's descriptions
5781: wild-type rep1
5782: wild-type rep2
7078: rrp6∆ rep1
7079: rrp6∆ rep2
7080: trf4∆ rep1
7081: trf4∆ rep2
6125: Ostir depletion rep1
6126: Ostir depletion rep2
7714: double tag Nrd1/Nab3 depletion rep1
7716: single tag depletion of Nab3 rep1
7718: single tag depletion of Nab3 rep2
7747: rtr1∆ rep1
7748: rtr1∆ rep2

*Work continued [here in variables.xlsx](./notebook/variables.xlsx)*
<br />
