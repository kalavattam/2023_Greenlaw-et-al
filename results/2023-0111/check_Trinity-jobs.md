
`#check_Trinity-jobs.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Check on STDERR, STDOUT, and Trinity outfiles](#check-on-stderr-stdout-and-trinity-outfiles)
	1. [Check on STDERR and STDOUT](#check-on-stderr-and-stdout)
		1. [Code](#code)
			1. [Trinity-GG/Q_N/](#trinity-ggq_n)
			1. [Trinity-GG/G_N/](#trinity-ggg_n)
			1. [Trinity-GF/Q_N/](#trinity-gfq_n)
			1. [Trinity-GF/G_N/](#trinity-gfg_n)
		1. [Printed, notes](#printed-notes)
			1. [Trinity-GG/Q_N/](#trinity-ggq_n-1)
			1. [Trinity-GG/G_N/](#trinity-ggg_n-1)
			1. [Trinity-GF/Q_N/](#trinity-gfq_n-1)
			1. [Trinity-GF/G_N/](#trinity-gfg_n-1)
	1. [Check on Trinity outfiles](#check-on-trinity-outfiles)
		1. [Code](#code-1)
			1. [Trinity-GG/Q_N/](#trinity-ggq_n-2)
			1. [Trinity-GG/G_N/](#trinity-ggg_n-2)
			1. [Trinity-GF/Q_N/](#trinity-gfq_n-2)
			1. [Trinity-GF/G_N/](#trinity-gfg_n-2)
		1. [Printed, notes](#printed-notes-1)
			1. [Trinity-GG/Q_N/](#trinity-ggq_n-3)
			1. [Trinity-GG/G_N/](#trinity-ggg_n-3)
			1. [Trinity-GF/Q_N/](#trinity-gfq_n-3)
			1. [Trinity-GF/G_N/](#trinity-gfg_n-3)
1. [Summary](#summary)
	1. [Trinity GG Q_N](#trinity-gg-q_n)
	1. [Trinity GG G_N](#trinity-gg-g_n)
	1. [Trinity GF Q_N](#trinity-gf-q_n)
	1. [Trinity GF G_N](#trinity-gf-g_n)
1. [Next steps](#next-steps)
	1. [General](#general)
	1. [Trinity GG Q_N](#trinity-gg-q_n-1)
	1. [Trinity GG G_N](#trinity-gg-g_n-1)
	1. [Trinity GF Q_N](#trinity-gf-q_n-1)
	1. [Trinity GF G_N](#trinity-gf-g_n-1)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="check-on-stderr-stdout-and-trinity-outfiles"></a>
## Check on STDERR, STDOUT, and Trinity outfiles
- `#QUESTION` What, if anything, looks off?  
- `#TODO` Need to compress these `STDOUT` files...
<br />

<a id="check-on-stderr-and-stdout"></a>
### Check on STDERR and STDOUT
<a id="code"></a>
#### Code

<a id="trinity-ggq_n"></a>
##### Trinity-GG/Q_N/
<details>
<summary><i>Code: Trinity-GG/Q_N/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "sh_err_out/err_out/Trinity-GG/Q_N/"

., *.out.txt
```
</details>
<br />

<a id="trinity-ggg_n"></a>
##### Trinity-GG/G_N/
<details>
<summary><i>Code: Trinity-GG/G_N/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "sh_err_out/err_out/Trinity-GG/G_N/"

., *.out.txt

ls -1 *.out.txt | wc -l  # 288
```
</details>
<br />

<a id="trinity-gfq_n"></a>
##### Trinity-GF/Q_N/
<details>
<summary><i>Code: Trinity-GF/Q_N/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "sh_err_out/err_out/Trinity-GF/Q_N/"

., *.out.txt
```
</details>
<br />

<a id="trinity-gfg_n"></a>
##### Trinity-GF/G_N/
<details>
<summary><i>Code: Trinity-GF/G_N/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "sh_err_out/err_out/Trinity-GF/G_N/"

., *.out.txt
```
</details>
<br />

<a id="printed-notes"></a>
#### Printed, notes
<a id="trinity-ggq_n-1"></a>
##### Trinity-GG/Q_N/
<details>
<summary><i>Printed: Trinity-GG/Q_N/</i></summary>

What did not complete?
- `trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.10397285-106.out.txt`
	+ Looks like it needs to be run from scratch

```txt
-rw-rw---- 2 kalavatt 1.3K Feb 15 16:45 submit_Trinity-GG_Q_N.10397285-106.out.txt
-rw-rw---- 1 kalavatt 137M Feb 16 13:26 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.10397285-193.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 13:32 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.10397285-194.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 13:40 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.10397285-195.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 13:43 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.10397285-196.out.txt
-rw-rw---- 1 kalavatt 137M Feb 16 14:08 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.10397285-197.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 14:28 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.10397285-198.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 14:17 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.10397285-199.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 14:23 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.10397285-200.out.txt
-rw-rw---- 1 kalavatt 137M Feb 16 14:53 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.10397285-201.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 15:27 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.10397285-202.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 15:27 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.10397285-203.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 15:27 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.10397285-204.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 15:36 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.10397285-205.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 15:31 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.10397285-206.out.txt
-rw-rw---- 1 kalavatt 132M Feb 16 17:47 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05.10397285-207.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 16:14 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.10397285-208.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 16:06 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.10397285-209.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:01 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.10397285-210.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:04 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.10397285-211.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:26 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.10397285-212.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:21 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.10397285-213.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:16 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.10397285-214.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:32 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.10397285-215.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 17:28 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.10397285-216.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 18:03 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.10397285-217.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 18:01 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.10397285-218.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:35 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.10397285-219.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 18:51 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.10397285-220.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:14 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.10397285-221.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:14 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.10397285-222.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:22 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.10397285-223.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:18 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.10397285-224.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:31 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.10397285-225.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:49 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.10397285-226.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:48 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.10397285-227.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 19:48 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.10397285-228.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 20:40 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.10397285-229.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 20:54 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.10397285-230.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 21:14 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.10397285-231.out.txt
-rw-rw---- 1 kalavatt 135M Feb 16 21:03 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.10397285-232.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 21:09 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.10397285-233.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 21:16 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.10397285-234.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 21:22 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.10397285-235.out.txt
-rw-rw---- 1 kalavatt 135M Feb 16 21:31 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.10397285-236.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 21:32 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.10397285-237.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 21:34 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.10397285-238.out.txt
-rw-rw---- 1 kalavatt 136M Feb 16 22:27 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.10397285-239.out.txt
-rw-rw---- 1 kalavatt 135M Feb 16 22:32 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.10397285-240.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 19:26 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.10397285-1.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 19:29 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.10397285-2.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 19:28 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.10397285-3.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.10397285-4.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.10397285-5.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.10397285-6.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.10397285-7.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.10397285-8.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 04:19 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.10397285-9.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 19:42 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.10397285-10.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 19:42 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.10397285-11.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 19:42 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.10397285-12.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 21:32 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.10397285-13.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 21:33 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.10397285-14.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 21:35 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.10397285-15.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 21:53 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.10397285-16.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 21:53 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.10397285-17.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 21:52 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.10397285-18.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 23:40 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.10397285-19.out.txt
-rw-rw---- 1 kalavatt 170M Feb 14 23:47 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.10397285-20.out.txt
-rw-rw---- 1 kalavatt 171M Feb 14 23:44 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.10397285-21.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 00:04 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.10397285-22.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 00:02 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.10397285-23.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 00:01 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.10397285-24.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 01:44 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.10397285-25.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 01:50 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.10397285-26.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 02:11 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.10397285-27.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 02:54 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.10397285-28.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 02:12 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.10397285-29.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 02:08 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.10397285-30.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 03:47 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.10397285-31.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 03:57 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.10397285-32.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 04:48 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.10397285-33.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 04:37 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.10397285-34.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 04:53 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.10397285-35.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 05:24 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.10397285-36.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 05:43 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.10397285-37.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 05:55 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.10397285-38.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 06:19 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.10397285-39.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 06:33 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.10397285-40.out.txt
-rw-rw---- 1 kalavatt 171M Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.10397285-41.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.10397285-42.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 06:37 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.10397285-43.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.10397285-44.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.10397285-45.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 07:02 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.10397285-46.out.txt
-rw-rw---- 1 kalavatt 170M Feb 15 07:11 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.10397285-47.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 07:38 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.10397285-48.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 07:38 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.10397285-49.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 07:52 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.10397285-50.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 08:18 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.10397285-51.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 08:46 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.10397285-52.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 09:46 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.10397285-53.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 09:11 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.10397285-54.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 09:11 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.10397285-55.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 09:11 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.10397285-56.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 09:14 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.10397285-57.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 10:54 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.10397285-58.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 09:47 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.10397285-59.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 10:00 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.10397285-60.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 10:24 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.10397285-61.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 10:30 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.10397285-62.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 10:44 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.10397285-63.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 11:24 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.10397285-64.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 12:02 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.10397285-65.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 11:32 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.10397285-66.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 11:34 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.10397285-67.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 11:43 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.10397285-68.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 12:24 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.10397285-69.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 12:21 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.10397285-70.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 12:15 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.10397285-71.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 14:47 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.10397285-72.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 12:37 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.10397285-73.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 12:47 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.10397285-74.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 13:20 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.10397285-75.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 13:30 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.10397285-76.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 13:31 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.10397285-77.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 13:38 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.10397285-78.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 13:59 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.10397285-79.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 14:19 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.10397285-80.out.txt
-rw-rw---- 1 kalavatt 169M Feb 15 14:23 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.10397285-81.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 14:25 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.10397285-82.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 14:34 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.10397285-83.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 14:42 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.10397285-84.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 14:47 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.10397285-85.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 15:27 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.10397285-86.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 15:36 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.10397285-87.out.txt
-rw-rw---- 1 kalavatt 167M Feb 15 15:32 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.10397285-88.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 15:48 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.10397285-89.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 16:18 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.10397285-90.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 16:33 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.10397285-91.out.txt
-rw-rw---- 1 kalavatt 167M Feb 15 16:45 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.10397285-92.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 16:35 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.10397285-93.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 16:44 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.10397285-94.out.txt
-rw-rw---- 1 kalavatt 168M Feb 15 16:47 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.10397285-95.out.txt
-rw-rw---- 1 kalavatt 167M Feb 15 17:20 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.10397285-96.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 22:41 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.10397285-241.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 22:45 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.10397285-242.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 22:51 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.10397285-243.out.txt
-rw-rw---- 1 kalavatt 126M Feb 16 22:47 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.10397285-244.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 22:53 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.10397285-245.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 23:10 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.10397285-246.out.txt
-rw-rw---- 1 kalavatt 127M Feb 17 00:22 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.10397285-247.out.txt
-rw-rw---- 1 kalavatt 126M Feb 16 23:12 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.10397285-248.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 23:15 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.10397285-249.out.txt
-rw-rw---- 1 kalavatt 127M Feb 16 23:57 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.10397285-250.out.txt
-rw-rw---- 1 kalavatt 127M Feb 17 00:01 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.10397285-251.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 00:28 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.10397285-252.out.txt
-rw-rw---- 1 kalavatt 127M Feb 17 00:19 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.10397285-253.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 00:22 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.10397285-254.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 00:29 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.10397285-255.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 00:24 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.10397285-256.out.txt
-rw-rw---- 1 kalavatt 127M Feb 17 00:45 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.10397285-257.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 00:46 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.10397285-258.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 00:52 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.10397285-259.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 01:43 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.10397285-260.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 01:41 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.10397285-261.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 01:56 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.10397285-262.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 02:02 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.10397285-263.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 02:10 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.10397285-264.out.txt
-rw-rw---- 1 kalavatt 127M Feb 17 01:57 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.10397285-265.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 02:12 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.10397285-266.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 02:07 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.10397285-267.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 02:20 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.10397285-268.out.txt
-rw-rw---- 1 kalavatt 127M Feb 17 02:24 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.10397285-269.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 02:32 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.10397285-270.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:33 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.10397285-271.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:22 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.10397285-272.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:30 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.10397285-273.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:32 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.10397285-274.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:35 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.10397285-275.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:37 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.10397285-276.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:48 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.10397285-277.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:47 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.10397285-278.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 03:57 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.10397285-279.out.txt
-rw-rw---- 1 kalavatt 125M Feb 17 04:20 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.10397285-280.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 04:06 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.10397285-281.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 04:53 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.10397285-282.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 05:04 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.10397285-283.out.txt
-rw-rw---- 1 kalavatt 125M Feb 17 05:07 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.10397285-284.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 05:16 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.10397285-285.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 05:10 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.10397285-286.out.txt
-rw-rw---- 1 kalavatt 126M Feb 17 05:12 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.10397285-287.out.txt
-rw-rw---- 1 kalavatt 125M Feb 17 05:17 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.10397285-288.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 16:40 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.10397285-97.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 18:02 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.10397285-98.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 17:53 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.10397285-99.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 18:23 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.10397285-100.out.txt
-rw-rw---- 1 kalavatt 159M Feb 16 21:31 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.10397285-101.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 18:53 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.10397285-102.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 19:04 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.10397285-103.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 18:56 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.10397285-104.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 19:24 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.10397285-105.out.txt
-rw-rw---- 2 kalavatt 1.3K Feb 15 16:45 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.10397285-106.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 19:46 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.10397285-107.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 19:29 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.10397285-108.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 19:48 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.10397285-109.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 20:01 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.10397285-110.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 20:28 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.10397285-111.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 20:51 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.10397285-112.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 20:58 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.10397285-113.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 21:13 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.10397285-114.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 21:11 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.10397285-115.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 21:23 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.10397285-116.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 21:37 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.10397285-117.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 21:59 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.10397285-118.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 21:51 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.10397285-119.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 22:00 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.10397285-120.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 22:35 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.10397285-121.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 22:49 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.10397285-122.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 23:08 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.10397285-123.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 23:14 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.10397285-124.out.txt
-rw-rw---- 1 kalavatt 159M Feb 15 23:18 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.10397285-125.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 23:23 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.10397285-126.out.txt
-rw-rw---- 1 kalavatt 158M Feb 15 23:45 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.10397285-127.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 00:06 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.10397285-128.out.txt
-rw-rw---- 1 kalavatt 159M Feb 16 00:06 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.10397285-129.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 00:03 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.10397285-130.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 00:37 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.10397285-131.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 00:48 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.10397285-132.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 01:14 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.10397285-133.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 01:14 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.10397285-134.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 01:18 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.10397285-135.out.txt
-rw-rw---- 1 kalavatt 157M Feb 16 01:30 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.10397285-136.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 01:50 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.10397285-137.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 02:01 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.10397285-138.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 02:20 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.10397285-139.out.txt
-rw-rw---- 1 kalavatt 157M Feb 16 02:19 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.10397285-140.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 02:41 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.10397285-141.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 02:49 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.10397285-142.out.txt
-rw-rw---- 1 kalavatt 158M Feb 16 03:20 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.10397285-143.out.txt
-rw-rw---- 1 kalavatt 157M Feb 16 03:16 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.10397285-144.out.txt
-rw-rw---- 1 kalavatt 146M Feb 16 03:26 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.10397285-145.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 03:35 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.10397285-146.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 03:56 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.10397285-147.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 03:53 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.10397285-148.out.txt
-rw-rw---- 1 kalavatt 146M Feb 16 04:21 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.10397285-149.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 04:31 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.10397285-150.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 04:36 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.10397285-151.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 04:37 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.10397285-152.out.txt
-rw-rw---- 1 kalavatt 146M Feb 16 05:04 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.10397285-153.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 05:14 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.10397285-154.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 05:18 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.10397285-155.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 05:38 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.10397285-156.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 05:41 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.10397285-157.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 05:57 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.10397285-158.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 06:34 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.10397285-159.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 06:30 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.10397285-160.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 06:35 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.10397285-161.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 06:32 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.10397285-162.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 06:54 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.10397285-163.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 07:24 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.10397285-164.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 07:34 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.10397285-165.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 07:42 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.10397285-166.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 07:43 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.10397285-167.out.txt
-rw-rw---- 1 kalavatt 144M Feb 16 08:09 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.10397285-168.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:38 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.10397285-169.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:38 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.10397285-170.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:38 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.10397285-171.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 08:36 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.10397285-172.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 08:42 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.10397285-173.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:15 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.10397285-174.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:26 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.10397285-175.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:48 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.10397285-176.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 09:35 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.10397285-177.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 10:15 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.10397285-178.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 10:26 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.10397285-179.out.txt
-rw-rw---- 1 kalavatt 144M Feb 16 10:28 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.10397285-180.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 11:04 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.10397285-181.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 11:42 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.10397285-182.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 11:26 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.10397285-183.out.txt
-rw-rw---- 1 kalavatt 144M Feb 16 11:45 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.10397285-184.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 11:45 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.10397285-185.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 11:24 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.10397285-186.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 11:48 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.10397285-187.out.txt
-rw-rw---- 1 kalavatt 144M Feb 16 12:34 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.10397285-188.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 12:38 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.10397285-189.out.txt
-rw-rw---- 1 kalavatt 144M Feb 16 12:34 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.10397285-190.out.txt
-rw-rw---- 1 kalavatt 145M Feb 16 13:02 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05.10397285-191.out.txt
-rw-rw---- 1 kalavatt 144M Feb 16 13:26 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.10397285-192.out.txt
```
</details>
<br />

<a id="trinity-ggg_n-1"></a>
##### Trinity-GG/G_N/
<details>
<summary><i>Printed: Trinity-GG/G_N/</i></summary>

```txt
-rw-rw---- 1 kalavatt 148M Feb 19 03:11 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.10887247-193.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 03:07 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.10887247-194.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 03:29 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.10887247-195.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 03:26 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.10887247-196.out.txt
-rw-rw---- 1 kalavatt 148M Feb 19 03:58 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.10887247-197.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 04:16 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.10887247-198.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 03:56 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.10887247-199.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 04:36 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.10887247-200.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:23 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.10887247-201.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:07 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.10887247-202.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:12 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.10887247-203.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:22 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.10887247-204.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:18 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.10887247-205.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:18 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.10887247-206.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:20 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05.10887247-207.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 05:36 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.10887247-208.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 05:46 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.10887247-209.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 06:22 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.10887247-210.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 06:20 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.10887247-211.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 06:42 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.10887247-212.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:12 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.10887247-213.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:17 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.10887247-214.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:06 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.10887247-215.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 07:32 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.10887247-216.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:18 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.10887247-217.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:27 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.10887247-218.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:49 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.10887247-219.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 07:46 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.10887247-220.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 07:40 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.10887247-221.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 08:54 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.10887247-222.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 08:35 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.10887247-223.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 09:25 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.10887247-224.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 08:54 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.10887247-225.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 09:06 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.10887247-226.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 09:11 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.10887247-227.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 09:16 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.10887247-228.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 09:22 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.10887247-229.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 09:44 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.10887247-230.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 09:33 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.10887247-231.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 09:59 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.10887247-232.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 10:03 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.10887247-233.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 10:59 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.10887247-234.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 11:02 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.10887247-235.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 10:48 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.10887247-236.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 12:10 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.10887247-237.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 11:18 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.10887247-238.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 11:12 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.10887247-239.out.txt
-rw-rw---- 1 kalavatt 146M Feb 19 11:43 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.10887247-240.out.txt
-rw-rw---- 1 kalavatt 188M Feb 17 14:30 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.10887247-1.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:15 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.10887247-2.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:00 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.10887247-3.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 13:58 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.10887247-4.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:26 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.10887247-5.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:02 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.10887247-6.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:40 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.10887247-7.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 14:42 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.10887247-8.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:05 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.10887247-9.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 14:05 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.10887247-10.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 13:59 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.10887247-11.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 14:27 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.10887247-12.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 16:17 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.10887247-13.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 16:17 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.10887247-14.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 16:18 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.10887247-15.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 16:33 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.10887247-16.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 16:36 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.10887247-17.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 16:33 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.10887247-18.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 16:41 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.10887247-19.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 16:52 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.10887247-20.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 16:53 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.10887247-21.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 17:14 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.10887247-22.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 17:12 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.10887247-23.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 17:18 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.10887247-24.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 18:36 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.10887247-25.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 18:30 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.10887247-26.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 18:56 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.10887247-27.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 18:58 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.10887247-28.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 19:01 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.10887247-29.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 19:08 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.10887247-30.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 19:06 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.10887247-31.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 19:03 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.10887247-32.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 19:07 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.10887247-33.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 19:52 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.10887247-34.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 19:33 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.10887247-35.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 19:49 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.10887247-36.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 20:47 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.10887247-37.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:12 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.10887247-38.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:50 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.10887247-39.out.txt
-rw-rw---- 1 kalavatt 185M Feb 17 21:25 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.10887247-40.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:37 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.10887247-41.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:20 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.10887247-42.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:32 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.10887247-43.out.txt
-rw-rw---- 1 kalavatt 185M Feb 17 21:37 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.10887247-44.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:46 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.10887247-45.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 22:09 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.10887247-46.out.txt
-rw-rw---- 1 kalavatt 186M Feb 17 21:59 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.10887247-47.out.txt
-rw-rw---- 1 kalavatt 185M Feb 17 22:15 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.10887247-48.out.txt
-rw-rw---- 1 kalavatt 185M Feb 17 23:01 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.10887247-49.out.txt
-rw-rw---- 1 kalavatt 184M Feb 17 23:37 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.10887247-50.out.txt
-rw-rw---- 1 kalavatt 184M Feb 17 23:38 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.10887247-51.out.txt
-rw-rw---- 1 kalavatt 184M Feb 17 23:45 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.10887247-52.out.txt
-rw-rw---- 1 kalavatt 185M Feb 17 23:51 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.10887247-53.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 00:03 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.10887247-54.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 00:02 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.10887247-55.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 00:02 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.10887247-56.out.txt
-rw-rw---- 1 kalavatt 185M Feb 18 00:14 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.10887247-57.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 00:13 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.10887247-58.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 00:29 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.10887247-59.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 00:25 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.10887247-60.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 03:20 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.10887247-61.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 01:56 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.10887247-62.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 01:50 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.10887247-63.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 01:58 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.10887247-64.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 02:06 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.10887247-65.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 02:20 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.10887247-66.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 02:27 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.10887247-67.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 02:20 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.10887247-68.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 02:23 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.10887247-69.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 02:30 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.10887247-70.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 02:31 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.10887247-71.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 02:48 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.10887247-72.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 12:39 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.10887247-73.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 04:15 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.10887247-74.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 04:13 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.10887247-75.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 04:22 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.10887247-76.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 05:11 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.10887247-77.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 04:41 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.10887247-78.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 04:31 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.10887247-79.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 04:56 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.10887247-80.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 04:47 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.10887247-81.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 04:47 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.10887247-82.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 05:14 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.10887247-83.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 06:05 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.10887247-84.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 06:27 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.10887247-85.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 06:37 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.10887247-86.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 06:40 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.10887247-87.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 06:42 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.10887247-88.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 07:03 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.10887247-89.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 06:59 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.10887247-90.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 07:09 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.10887247-91.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 07:14 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.10887247-92.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 07:37 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.10887247-93.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 07:33 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.10887247-94.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 08:41 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.10887247-95.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 10:14 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.10887247-96.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 11:53 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.10887247-241.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 11:15 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.10887247-242.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 11:31 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.10887247-243.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 11:49 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.10887247-244.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 12:07 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.10887247-245.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 12:33 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.10887247-246.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 12:59 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.10887247-247.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 13:11 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.10887247-248.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 13:02 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.10887247-249.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 12:59 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.10887247-250.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 13:04 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.10887247-251.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 13:19 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.10887247-252.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 13:27 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.10887247-253.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 13:40 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.10887247-254.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 13:50 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.10887247-255.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 13:55 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.10887247-256.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 14:02 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.10887247-257.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 14:18 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.10887247-258.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 14:44 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.10887247-259.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 14:41 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.10887247-260.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 14:48 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.10887247-261.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 14:56 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.10887247-262.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 14:52 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.10887247-263.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 15:03 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.10887247-264.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 15:16 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.10887247-265.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 15:24 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.10887247-266.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 15:51 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.10887247-267.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 15:41 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.10887247-268.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 16:06 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.10887247-269.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:07 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.10887247-270.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:22 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.10887247-271.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:29 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.10887247-272.out.txt
-rw-rw---- 1 kalavatt 139M Feb 19 16:36 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.10887247-273.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:33 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.10887247-274.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:49 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.10887247-275.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:43 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.10887247-276.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 16:59 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.10887247-277.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 17:22 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.10887247-278.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 17:31 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.10887247-279.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 17:38 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.10887247-280.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 17:53 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.10887247-281.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 17:57 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.10887247-282.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 18:02 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.10887247-283.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 18:48 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.10887247-284.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 18:20 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.10887247-285.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 18:17 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.10887247-286.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 18:34 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.10887247-287.out.txt
-rw-rw---- 1 kalavatt 138M Feb 19 18:34 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.10887247-288.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 10:05 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.10887247-97.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 08:57 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.10887247-98.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 08:49 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.10887247-99.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 09:09 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.10887247-100.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 09:38 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.10887247-101.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 09:18 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.10887247-102.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:07 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.10887247-103.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:22 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.10887247-104.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 09:43 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.10887247-105.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:50 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.10887247-106.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:56 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.10887247-107.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:59 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.10887247-108.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 11:12 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.10887247-109.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 11:20 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.10887247-110.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 11:48 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.10887247-111.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 11:43 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.10887247-112.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 12:06 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.10887247-113.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 12:21 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.10887247-114.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 12:42 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.10887247-115.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 12:42 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.10887247-116.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 14:32 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.10887247-117.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 13:39 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.10887247-118.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 13:06 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.10887247-119.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 13:19 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.10887247-120.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 13:27 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.10887247-121.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 13:41 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.10887247-122.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 14:43 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.10887247-123.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 14:17 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.10887247-124.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 15:09 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.10887247-125.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 15:08 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.10887247-126.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 14:53 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.10887247-127.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 15:26 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.10887247-128.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 15:22 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.10887247-129.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 15:59 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.10887247-130.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 15:28 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.10887247-131.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 15:59 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.10887247-132.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 15:39 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.10887247-133.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 16:36 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.10887247-134.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 17:01 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.10887247-135.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 16:54 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.10887247-136.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 16:58 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.10887247-137.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 17:17 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.10887247-138.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 17:31 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.10887247-139.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 17:32 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.10887247-140.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 17:53 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.10887247-141.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 17:36 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.10887247-142.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 17:37 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.10887247-143.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 18:14 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.10887247-144.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 18:06 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.10887247-145.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 18:45 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.10887247-146.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 19:07 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.10887247-147.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 19:10 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.10887247-148.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 19:10 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.10887247-149.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 19:45 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.10887247-150.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 20:01 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.10887247-151.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 19:43 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.10887247-152.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 19:47 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.10887247-153.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 19:40 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.10887247-154.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 20:19 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.10887247-155.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 20:14 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.10887247-156.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 20:29 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.10887247-157.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 20:44 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.10887247-158.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 21:14 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.10887247-159.out.txt
-rw-rw---- 1 kalavatt 156M Feb 18 21:14 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.10887247-160.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 21:21 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.10887247-161.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 21:32 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.10887247-162.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 21:42 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.10887247-163.out.txt
-rw-rw---- 1 kalavatt 156M Feb 18 22:25 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.10887247-164.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 21:51 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.10887247-165.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 22:43 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.10887247-166.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 22:40 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.10887247-167.out.txt
-rw-rw---- 1 kalavatt 156M Feb 18 22:55 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.10887247-168.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 23:02 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.10887247-169.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 23:15 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.10887247-170.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 23:23 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.10887247-171.out.txt
-rw-rw---- 1 kalavatt 156M Feb 18 23:20 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.10887247-172.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 23:41 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.10887247-173.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 23:28 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.10887247-174.out.txt
-rw-rw---- 1 kalavatt 157M Feb 18 23:40 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.10887247-175.out.txt
-rw-rw---- 1 kalavatt 156M Feb 18 23:57 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.10887247-176.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 00:51 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.10887247-177.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 01:01 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.10887247-178.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 01:08 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.10887247-179.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 01:20 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.10887247-180.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 01:41 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.10887247-181.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 01:54 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.10887247-182.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 01:20 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.10887247-183.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 01:31 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.10887247-184.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 01:21 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.10887247-185.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 01:35 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.10887247-186.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 02:12 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.10887247-187.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 02:02 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.10887247-188.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 03:01 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.10887247-189.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 03:20 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.10887247-190.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 03:21 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05.10887247-191.out.txt
-rw-rw---- 1 kalavatt 156M Feb 19 03:36 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.10887247-192.out.txt
```
</details>
<br />

<a id="trinity-gfq_n-1"></a>
##### Trinity-GF/Q_N/
<details>
<summary><i>Printed: Trinity-GF/Q_N/</i></summary>

```txt
-rw-rw---- 1 kalavatt 160M Feb 18 10:06 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.005.10396158-193.out.txt
-rw-rw---- 1 kalavatt 159M Feb 18 05:22 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.01.10396158-194.out.txt
-rw-rw---- 1 kalavatt 176M Feb 18 13:11 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.05.10396158-195.out.txt
-rw-rw---- 1 kalavatt 196M Feb 18 03:38 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.1.10396158-196.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 02:51 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.005.10396158-197.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 02:34 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.01.10396158-198.out.txt
-rw-rw---- 1 kalavatt 181M Feb 18 06:39 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.05.10396158-199.out.txt
-rw-rw---- 1 kalavatt 197M Feb 18 07:32 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.1.10396158-200.out.txt
-rw-rw---- 1 kalavatt 190M Feb 18 08:30 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.005.10396158-201.out.txt
-rw-rw---- 1 kalavatt 189M Feb 18 08:59 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.01.10396158-202.out.txt
-rw-rw---- 1 kalavatt 192M Feb 18 06:25 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.05.10396158-203.out.txt
-rw-rw---- 1 kalavatt 202M Feb 18 07:27 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.1.10396158-204.out.txt
-rw-rw---- 1 kalavatt 159M Feb 18 07:16 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.005.10396158-205.out.txt
-rw-rw---- 1 kalavatt 159M Feb 18 08:02 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.01.10396158-206.out.txt
-rw-rw---- 1 kalavatt 175M Feb 18 08:08 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.05.10396158-207.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 11:31 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.1.10396158-208.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:49 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.005.10396158-209.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 10:45 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.01.10396158-210.out.txt
-rw-rw---- 1 kalavatt 180M Feb 18 10:02 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.05.10396158-211.out.txt
-rw-rw---- 1 kalavatt 196M Feb 18 11:57 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.1.10396158-212.out.txt
-rw-rw---- 1 kalavatt 189M Feb 18 12:04 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.005.10396158-213.out.txt
-rw-rw---- 1 kalavatt 189M Feb 18 12:20 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.01.10396158-214.out.txt
-rw-rw---- 1 kalavatt 191M Feb 18 11:54 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.05.10396158-215.out.txt
-rw-rw---- 1 kalavatt 201M Feb 18 12:10 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.1.10396158-216.out.txt
-rw-rw---- 1 kalavatt 159M Feb 18 14:26 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.005.10396158-217.out.txt
-rw-rw---- 1 kalavatt 159M Feb 18 12:22 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.01.10396158-218.out.txt
-rw-rw---- 1 kalavatt 175M Feb 18 14:04 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.05.10396158-219.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 14:11 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.1.10396158-220.out.txt
-rw-rw---- 1 kalavatt 173M Feb 18 16:05 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.005.10396158-221.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 17:13 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.01.10396158-222.out.txt
-rw-rw---- 1 kalavatt 180M Feb 18 16:36 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.05.10396158-223.out.txt
-rw-rw---- 1 kalavatt 196M Feb 18 17:11 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.1.10396158-224.out.txt
-rw-rw---- 1 kalavatt 189M Feb 18 16:31 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.005.10396158-225.out.txt
-rw-rw---- 1 kalavatt 188M Feb 18 16:43 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.01.10396158-226.out.txt
-rw-rw---- 1 kalavatt 191M Feb 18 15:17 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.05.10396158-227.out.txt
-rw-rw---- 1 kalavatt 201M Feb 18 16:12 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.1.10396158-228.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 16:46 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.005.10396158-229.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 16:55 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.01.10396158-230.out.txt
-rw-rw---- 1 kalavatt 175M Feb 18 18:23 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.05.10396158-231.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 19:56 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.1.10396158-232.out.txt
-rw-rw---- 1 kalavatt 172M Feb 18 18:09 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.005.10396158-233.out.txt
-rw-rw---- 1 kalavatt 171M Feb 18 20:21 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.01.10396158-234.out.txt
-rw-rw---- 1 kalavatt 180M Feb 18 22:03 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.05.10396158-235.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 21:17 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.1.10396158-236.out.txt
-rw-rw---- 1 kalavatt 189M Feb 18 22:05 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.005.10396158-237.out.txt
-rw-rw---- 1 kalavatt 188M Feb 18 23:55 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.01.10396158-238.out.txt
-rw-rw---- 1 kalavatt 191M Feb 18 20:34 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.05.10396158-239.out.txt
-rw-rw---- 1 kalavatt 200M Feb 18 20:32 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.1.10396158-240.out.txt
-rw-rw---- 1 kalavatt 238M Feb 14 21:02 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.10396158-1.out.txt
-rw-rw---- 1 kalavatt 237M Feb 14 19:45 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.10396158-2.out.txt
-rw-rw---- 1 kalavatt 274M Feb 15 10:58 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.10396158-3.out.txt
-rw-rw---- 1 kalavatt 310M Feb 15 11:09 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.10396158-4.out.txt
-rw-rw---- 1 kalavatt 276M Feb 14 20:21 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.005.10396158-5.out.txt
-rw-rw---- 1 kalavatt 275M Feb 14 21:36 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.01.10396158-6.out.txt
-rw-rw---- 1 kalavatt 291M Feb 14 21:42 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.05.10396158-7.out.txt
-rw-rw---- 1 kalavatt 320M Feb 15 01:37 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.1.10396158-8.out.txt
-rw-rw---- 1 kalavatt 315M Feb 15 01:17 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.005.10396158-9.out.txt
-rw-rw---- 1 kalavatt 314M Feb 15 00:15 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.01.10396158-10.out.txt
-rw-rw---- 1 kalavatt 318M Feb 14 22:12 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.05.10396158-11.out.txt
-rw-rw---- 1 kalavatt 333M Feb 14 22:15 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.1.10396158-12.out.txt
-rw-rw---- 1 kalavatt 237M Feb 14 23:50 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.005.10396158-13.out.txt
-rw-rw---- 1 kalavatt 237M Feb 15 00:36 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.01.10396158-14.out.txt
-rw-rw---- 1 kalavatt 272M Feb 15 00:41 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.05.10396158-15.out.txt
-rw-rw---- 1 kalavatt 310M Feb 15 02:10 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.1.10396158-16.out.txt
-rw-rw---- 1 kalavatt 275M Feb 15 02:00 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.005.10396158-17.out.txt
-rw-rw---- 1 kalavatt 274M Feb 15 03:50 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.01.10396158-18.out.txt
-rw-rw---- 1 kalavatt 290M Feb 15 01:24 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.05.10396158-19.out.txt
-rw-rw---- 1 kalavatt 319M Feb 15 03:39 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.1.10396158-20.out.txt
-rw-rw---- 1 kalavatt 315M Feb 15 06:24 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.005.10396158-21.out.txt
-rw-rw---- 1 kalavatt 314M Feb 15 05:12 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.01.10396158-22.out.txt
-rw-rw---- 1 kalavatt 317M Feb 15 04:23 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.05.10396158-23.out.txt
-rw-rw---- 1 kalavatt 332M Feb 15 07:36 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.1.10396158-24.out.txt
-rw-rw---- 1 kalavatt 237M Feb 15 05:54 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.005.10396158-25.out.txt
-rw-rw---- 1 kalavatt 237M Feb 15 06:38 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.01.10396158-26.out.txt
-rw-rw---- 1 kalavatt 272M Feb 15 07:47 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.05.10396158-27.out.txt
-rw-rw---- 1 kalavatt 309M Feb 15 07:06 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.1.10396158-28.out.txt
-rw-rw---- 1 kalavatt 275M Feb 15 09:09 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.005.10396158-29.out.txt
-rw-rw---- 1 kalavatt 274M Feb 15 07:12 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.01.10396158-30.out.txt
-rw-rw---- 1 kalavatt 290M Feb 15 07:40 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.05.10396158-31.out.txt
-rw-rw---- 1 kalavatt 319M Feb 15 11:28 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.1.10396158-32.out.txt
-rw-rw---- 1 kalavatt 315M Feb 15 11:44 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.005.10396158-33.out.txt
-rw-rw---- 1 kalavatt 314M Feb 15 12:39 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.01.10396158-34.out.txt
-rw-rw---- 1 kalavatt 317M Feb 15 10:12 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.05.10396158-35.out.txt
-rw-rw---- 1 kalavatt 332M Feb 15 14:19 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.1.10396158-36.out.txt
-rw-rw---- 1 kalavatt 237M Feb 15 11:02 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.005.10396158-37.out.txt
-rw-rw---- 1 kalavatt 237M Feb 15 12:20 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.01.10396158-38.out.txt
-rw-rw---- 1 kalavatt 272M Feb 15 14:54 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.05.10396158-39.out.txt
-rw-rw---- 1 kalavatt 308M Feb 15 12:04 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.1.10396158-40.out.txt
-rw-rw---- 1 kalavatt 275M Feb 15 12:57 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.005.10396158-41.out.txt
-rw-rw---- 1 kalavatt 273M Feb 15 13:20 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.01.10396158-42.out.txt
-rw-rw---- 1 kalavatt 289M Feb 15 16:41 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.05.10396158-43.out.txt
-rw-rw---- 1 kalavatt 318M Feb 15 15:13 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.1.10396158-44.out.txt
-rw-rw---- 1 kalavatt 313M Feb 15 14:22 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.005.10396158-45.out.txt
-rw-rw---- 1 kalavatt 313M Feb 15 17:53 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.01.10396158-46.out.txt
-rw-rw---- 1 kalavatt 316M Feb 15 15:40 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.05.10396158-47.out.txt
-rw-rw---- 1 kalavatt 331M Feb 15 16:13 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.1.10396158-48.out.txt
-rw-rw---- 1 kalavatt 191M Feb 15 15:09 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.005.10396158-49.out.txt
-rw-rw---- 1 kalavatt 190M Feb 15 18:19 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.10396158-50.out.txt
-rw-rw---- 1 kalavatt 221M Feb 15 15:48 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.05.10396158-51.out.txt
-rw-rw---- 1 kalavatt 255M Feb 15 18:11 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.1.10396158-52.out.txt
-rw-rw---- 1 kalavatt 221M Feb 15 17:39 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.005.10396158-53.out.txt
-rw-rw---- 1 kalavatt 221M Feb 15 19:09 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.01.10396158-54.out.txt
-rw-rw---- 1 kalavatt 235M Feb 15 18:40 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.05.10396158-55.out.txt
-rw-rw---- 1 kalavatt 261M Feb 15 19:43 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.1.10396158-56.out.txt
-rw-rw---- 1 kalavatt 256M Feb 15 20:59 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.005.10396158-57.out.txt
-rw-rw---- 1 kalavatt 256M Feb 15 21:11 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.01.10396158-58.out.txt
-rw-rw---- 1 kalavatt 259M Feb 15 22:43 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.05.10396158-59.out.txt
-rw-rw---- 1 kalavatt 274M Feb 15 22:23 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.1.10396158-60.out.txt
-rw-rw---- 1 kalavatt 190M Feb 15 20:28 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.005.10396158-61.out.txt
-rw-rw---- 1 kalavatt 190M Feb 15 23:18 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.01.10396158-62.out.txt
-rw-rw---- 1 kalavatt 220M Feb 16 01:17 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.05.10396158-63.out.txt
-rw-rw---- 1 kalavatt 254M Feb 15 22:46 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.1.10396158-64.out.txt
-rw-rw---- 1 kalavatt 220M Feb 17 00:33 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.005.10396158-65.out.txt
-rw-rw---- 1 kalavatt 220M Feb 15 21:55 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.01.10396158-66.out.txt
-rw-rw---- 1 kalavatt 234M Feb 15 23:38 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.05.10396158-67.out.txt
-rw-rw---- 1 kalavatt 260M Feb 16 00:19 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.1.10396158-68.out.txt
-rw-rw---- 1 kalavatt 256M Feb 16 02:16 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.005.10396158-69.out.txt
-rw-rw---- 1 kalavatt 255M Feb 16 02:37 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.01.10396158-70.out.txt
-rw-rw---- 1 kalavatt 258M Feb 16 01:49 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.05.10396158-71.out.txt
-rw-rw---- 1 kalavatt 273M Feb 16 01:09 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.1.10396158-72.out.txt
-rw-rw---- 1 kalavatt 190M Feb 16 01:12 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.005.10396158-73.out.txt
-rw-rw---- 1 kalavatt 190M Feb 16 04:16 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.01.10396158-74.out.txt
-rw-rw---- 1 kalavatt 220M Feb 16 01:54 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.05.10396158-75.out.txt
-rw-rw---- 1 kalavatt 254M Feb 16 02:39 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.1.10396158-76.out.txt
-rw-rw---- 1 kalavatt 220M Feb 16 02:21 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.005.10396158-77.out.txt
-rw-rw---- 1 kalavatt 220M Feb 16 04:15 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.01.10396158-78.out.txt
-rw-rw---- 1 kalavatt 234M Feb 16 05:44 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.05.10396158-79.out.txt
-rw-rw---- 1 kalavatt 260M Feb 16 04:23 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.1.10396158-80.out.txt
-rw-rw---- 1 kalavatt 256M Feb 16 05:40 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.005.10396158-81.out.txt
-rw-rw---- 1 kalavatt 255M Feb 16 07:37 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.01.10396158-82.out.txt
-rw-rw---- 1 kalavatt 258M Feb 16 05:02 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.05.10396158-83.out.txt
-rw-rw---- 1 kalavatt 273M Feb 16 06:37 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.1.10396158-84.out.txt
-rw-rw---- 1 kalavatt 190M Feb 16 06:30 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.005.10396158-85.out.txt
-rw-rw---- 1 kalavatt 189M Feb 16 05:25 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.01.10396158-86.out.txt
-rw-rw---- 1 kalavatt 219M Feb 16 05:41 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.05.10396158-87.out.txt
-rw-rw---- 1 kalavatt 254M Feb 16 12:30 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.1.10396158-88.out.txt
-rw-rw---- 1 kalavatt 220M Feb 16 09:17 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.005.10396158-89.out.txt
-rw-rw---- 1 kalavatt 219M Feb 16 09:01 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.01.10396158-90.out.txt
-rw-rw---- 1 kalavatt 234M Feb 17 00:37 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.05.10396158-91.out.txt
-rw-rw---- 1 kalavatt 260M Feb 16 11:57 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.1.10396158-92.out.txt
-rw-rw---- 1 kalavatt 255M Feb 16 14:02 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.005.10396158-93.out.txt
-rw-rw---- 1 kalavatt 254M Feb 16 09:53 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.01.10396158-94.out.txt
-rw-rw---- 1 kalavatt 258M Feb 16 09:09 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.05.10396158-95.out.txt
-rw-rw---- 1 kalavatt 272M Feb 16 11:16 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.1.10396158-96.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 20:25 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.005.10396158-241.out.txt
-rw-rw---- 1 kalavatt 158M Feb 18 21:17 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.01.10396158-242.out.txt
-rw-rw---- 1 kalavatt 175M Feb 18 22:21 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.05.10396158-243.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 21:25 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.1.10396158-244.out.txt
-rw-rw---- 1 kalavatt 168M Feb 19 00:05 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.005.10396158-245.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 00:20 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.01.10396158-246.out.txt
-rw-rw---- 1 kalavatt 174M Feb 18 23:26 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.05.10396158-247.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 23:16 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.1.10396158-248.out.txt
-rw-rw---- 1 kalavatt 177M Feb 18 23:39 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.005.10396158-249.out.txt
-rw-rw---- 1 kalavatt 176M Feb 19 01:43 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.01.10396158-250.out.txt
-rw-rw---- 1 kalavatt 178M Feb 19 03:25 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.05.10396158-251.out.txt
-rw-rw---- 1 kalavatt 183M Feb 19 00:23 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.1.10396158-252.out.txt
-rw-rw---- 1 kalavatt 158M Feb 19 03:04 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.005.10396158-253.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 00:59 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.01.10396158-254.out.txt
-rw-rw---- 1 kalavatt 174M Feb 19 02:10 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.05.10396158-255.out.txt
-rw-rw---- 1 kalavatt 183M Feb 19 02:05 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.1.10396158-256.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 02:23 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.005.10396158-257.out.txt
-rw-rw---- 1 kalavatt 166M Feb 19 02:59 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.01.10396158-258.out.txt
-rw-rw---- 1 kalavatt 174M Feb 19 05:11 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.05.10396158-259.out.txt
-rw-rw---- 1 kalavatt 183M Feb 19 07:43 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.1.10396158-260.out.txt
-rw-rw---- 1 kalavatt 176M Feb 19 04:54 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.005.10396158-261.out.txt
-rw-rw---- 1 kalavatt 175M Feb 19 05:19 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.01.10396158-262.out.txt
-rw-rw---- 1 kalavatt 177M Feb 19 08:18 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.05.10396158-263.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 06:20 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.1.10396158-264.out.txt
-rw-rw---- 1 kalavatt 158M Feb 19 05:27 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.005.10396158-265.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 05:53 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.01.10396158-266.out.txt
-rw-rw---- 1 kalavatt 174M Feb 19 05:17 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.05.10396158-267.out.txt
-rw-rw---- 1 kalavatt 183M Feb 19 09:08 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.1.10396158-268.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 05:41 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.005.10396158-269.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 09:30 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.01.10396158-270.out.txt
-rw-rw---- 1 kalavatt 174M Feb 19 09:29 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.05.10396158-271.out.txt
-rw-rw---- 1 kalavatt 183M Feb 19 10:11 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.1.10396158-272.out.txt
-rw-rw---- 1 kalavatt 176M Feb 19 08:16 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.005.10396158-273.out.txt
-rw-rw---- 1 kalavatt 175M Feb 19 08:19 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.01.10396158-274.out.txt
-rw-rw---- 1 kalavatt 178M Feb 19 12:01 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.05.10396158-275.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 12:20 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.1.10396158-276.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 09:26 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.005.10396158-277.out.txt
-rw-rw---- 1 kalavatt 157M Feb 19 10:19 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.01.10396158-278.out.txt
-rw-rw---- 1 kalavatt 174M Feb 19 12:29 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.05.10396158-279.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 11:06 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.1.10396158-280.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 12:45 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.005.10396158-281.out.txt
-rw-rw---- 1 kalavatt 166M Feb 19 12:56 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.01.10396158-282.out.txt
-rw-rw---- 1 kalavatt 173M Feb 19 14:08 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.05.10396158-283.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 12:08 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.1.10396158-284.out.txt
-rw-rw---- 1 kalavatt 175M Feb 19 13:02 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.005.10396158-285.out.txt
-rw-rw---- 1 kalavatt 175M Feb 19 16:01 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.01.10396158-286.out.txt
-rw-rw---- 1 kalavatt 177M Feb 19 15:19 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.05.10396158-287.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 16:25 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.1.10396158-288.out.txt
-rw-rw---- 1 kalavatt 154M Feb 16 10:23 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.005.10396158-97.out.txt
-rw-rw---- 1 kalavatt 153M Feb 16 12:21 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.01.10396158-98.out.txt
-rw-rw---- 1 kalavatt 177M Feb 16 13:21 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.05.10396158-99.out.txt
-rw-rw---- 1 kalavatt 207M Feb 16 13:30 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.1.10396158-100.out.txt
-rw-rw---- 1 kalavatt 177M Feb 16 12:11 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.005.10396158-101.out.txt
-rw-rw---- 1 kalavatt 177M Feb 16 14:25 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.01.10396158-102.out.txt
-rw-rw---- 1 kalavatt 189M Feb 16 16:05 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.05.10396158-103.out.txt
-rw-rw---- 1 kalavatt 211M Feb 16 14:50 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.1.10396158-104.out.txt
-rw-rw---- 1 kalavatt 205M Feb 16 15:28 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.005.10396158-105.out.txt
-rw-rw---- 1 kalavatt 205M Feb 16 15:46 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.01.10396158-106.out.txt
-rw-rw---- 1 kalavatt 208M Feb 16 15:46 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.05.10396158-107.out.txt
-rw-rw---- 1 kalavatt 221M Feb 16 19:21 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.1.10396158-108.out.txt
-rw-rw---- 1 kalavatt 154M Feb 16 15:54 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.005.10396158-109.out.txt
-rw-rw---- 1 kalavatt 153M Feb 16 16:07 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.01.10396158-110.out.txt
-rw-rw---- 1 kalavatt 177M Feb 16 20:25 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.05.10396158-111.out.txt
-rw-rw---- 1 kalavatt 206M Feb 16 20:15 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.1.10396158-112.out.txt
-rw-rw---- 1 kalavatt  15K Feb 16 19:55 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005.10396158-113.out.txt
-rw-rw---- 1 kalavatt 176M Feb 16 18:27 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.10396158-114.out.txt
-rw-rw---- 1 kalavatt  15K Feb 16 20:47 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05.10396158-115.out.txt
-rw-rw---- 1 kalavatt 210M Feb 16 22:17 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.10396158-116.out.txt
-rw-rw---- 1 kalavatt 205M Feb 17 00:06 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.005.10396158-117.out.txt
-rw-rw---- 1 kalavatt 204M Feb 16 21:45 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.01.10396158-118.out.txt
-rw-rw---- 1 kalavatt 207M Feb 16 19:24 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.05.10396158-119.out.txt
-rw-rw---- 1 kalavatt 220M Feb 16 21:13 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.1.10396158-120.out.txt
-rw-rw---- 1 kalavatt 153M Feb 16 22:40 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.005.10396158-121.out.txt
-rw-rw---- 1 kalavatt 153M Feb 16 22:02 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.01.10396158-122.out.txt
-rw-rw---- 1 kalavatt 177M Feb 17 03:14 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.05.10396158-123.out.txt
-rw-rw---- 1 kalavatt 206M Feb 17 01:29 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.1.10396158-124.out.txt
-rw-rw---- 1 kalavatt 176M Feb 16 23:12 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.005.10396158-125.out.txt
-rw-rw---- 1 kalavatt 176M Feb 17 01:18 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.01.10396158-126.out.txt
-rw-rw---- 1 kalavatt 188M Feb 17 01:12 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.05.10396158-127.out.txt
-rw-rw---- 1 kalavatt 210M Feb 17 02:55 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.1.10396158-128.out.txt
-rw-rw---- 1 kalavatt 204M Feb 17 00:42 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.005.10396158-129.out.txt
-rw-rw---- 1 kalavatt 204M Feb 17 01:14 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.01.10396158-130.out.txt
-rw-rw---- 1 kalavatt 207M Feb 17 05:31 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.05.10396158-131.out.txt
-rw-rw---- 1 kalavatt 220M Feb 17 02:13 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.1.10396158-132.out.txt
-rw-rw---- 1 kalavatt 152M Feb 17 02:44 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.005.10396158-133.out.txt
-rw-rw---- 1 kalavatt 152M Feb 17 03:34 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.01.10396158-134.out.txt
-rw-rw---- 1 kalavatt 176M Feb 17 03:16 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.05.10396158-135.out.txt
-rw-rw---- 1 kalavatt 205M Feb 17 03:39 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.1.10396158-136.out.txt
-rw-rw---- 1 kalavatt 176M Feb 17 04:19 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.005.10396158-137.out.txt
-rw-rw---- 1 kalavatt 175M Feb 17 03:48 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.01.10396158-138.out.txt
-rw-rw---- 1 kalavatt 187M Feb 17 06:33 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.05.10396158-139.out.txt
-rw-rw---- 1 kalavatt 209M Feb 17 04:39 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.1.10396158-140.out.txt
-rw-rw---- 1 kalavatt 204M Feb 17 06:28 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.005.10396158-141.out.txt
-rw-rw---- 1 kalavatt 203M Feb 17 11:49 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.01.10396158-142.out.txt
-rw-rw---- 1 kalavatt 206M Feb 17 08:17 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.05.10396158-143.out.txt
-rw-rw---- 1 kalavatt 219M Feb 17 06:25 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.1.10396158-144.out.txt
-rw-rw---- 1 kalavatt 149M Feb 17 07:52 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.005.10396158-145.out.txt
-rw-rw---- 1 kalavatt 148M Feb 17 05:54 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.01.10396158-146.out.txt
-rw-rw---- 1 kalavatt 167M Feb 17 06:35 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.05.10396158-147.out.txt
-rw-rw---- 1 kalavatt 193M Feb 17 08:04 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.1.10396158-148.out.txt
-rw-rw---- 1 kalavatt 167M Feb 17 06:58 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.005.10396158-149.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 07:05 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.01.10396158-150.out.txt
-rw-rw---- 1 kalavatt 176M Feb 17 08:08 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.05.10396158-151.out.txt
-rw-rw---- 1 kalavatt 197M Feb 17 09:42 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.1.10396158-152.out.txt
-rw-rw---- 1 kalavatt 195M Feb 17 12:30 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.005.10396158-153.out.txt
-rw-rw---- 1 kalavatt 194M Feb 17 13:56 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.01.10396158-154.out.txt
-rw-rw---- 1 kalavatt 197M Feb 17 12:20 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.05.10396158-155.out.txt
-rw-rw---- 1 kalavatt 209M Feb 17 11:23 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.1.10396158-156.out.txt
-rw-rw---- 1 kalavatt 148M Feb 17 11:28 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.005.10396158-157.out.txt
-rw-rw---- 1 kalavatt 148M Feb 17 09:19 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.01.10396158-158.out.txt
-rw-rw---- 1 kalavatt 167M Feb 17 10:12 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.05.10396158-159.out.txt
-rw-rw---- 1 kalavatt 193M Feb 17 10:26 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.1.10396158-160.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 11:13 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.005.10396158-161.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 10:45 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.01.10396158-162.out.txt
-rw-rw---- 1 kalavatt 176M Feb 17 12:01 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.05.10396158-163.out.txt
-rw-rw---- 1 kalavatt 196M Feb 17 17:33 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.1.10396158-164.out.txt
-rw-rw---- 1 kalavatt 194M Feb 17 23:52 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.005.10396158-165.out.txt
-rw-rw---- 1 kalavatt 193M Feb 17 14:39 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.01.10396158-166.out.txt
-rw-rw---- 1 kalavatt 196M Feb 17 19:08 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.05.10396158-167.out.txt
-rw-rw---- 1 kalavatt 208M Feb 17 20:35 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.1.10396158-168.out.txt
-rw-rw---- 1 kalavatt 149M Feb 17 16:05 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.005.10396158-169.out.txt
-rw-rw---- 1 kalavatt 148M Feb 17 14:28 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.01.10396158-170.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 23:17 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.05.10396158-171.out.txt
-rw-rw---- 1 kalavatt 192M Feb 17 15:43 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.1.10396158-172.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 17:23 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.005.10396158-173.out.txt
-rw-rw---- 1 kalavatt 165M Feb 17 15:59 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.01.10396158-174.out.txt
-rw-rw---- 1 kalavatt 175M Feb 17 22:50 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.05.10396158-175.out.txt
-rw-rw---- 1 kalavatt 196M Feb 17 17:39 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.1.10396158-176.out.txt
-rw-rw---- 1 kalavatt 194M Feb 17 19:29 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.005.10396158-177.out.txt
-rw-rw---- 1 kalavatt 193M Feb 17 19:19 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.01.10396158-178.out.txt
-rw-rw---- 1 kalavatt 196M Feb 17 19:33 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.05.10396158-179.out.txt
-rw-rw---- 1 kalavatt 209M Feb 17 19:15 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.1.10396158-180.out.txt
-rw-rw---- 1 kalavatt 148M Feb 17 22:27 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.005.10396158-181.out.txt
-rw-rw---- 1 kalavatt 147M Feb 18 00:59 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.01.10396158-182.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 23:36 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.05.10396158-183.out.txt
-rw-rw---- 1 kalavatt 192M Feb 18 02:06 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.1.10396158-184.out.txt
-rw-rw---- 1 kalavatt 165M Feb 18 00:05 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.005.10396158-185.out.txt
-rw-rw---- 1 kalavatt 165M Feb 17 22:53 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.01.10396158-186.out.txt
-rw-rw---- 1 kalavatt 175M Feb 18 00:00 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.05.10396158-187.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 00:04 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.1.10396158-188.out.txt
-rw-rw---- 1 kalavatt 193M Feb 18 02:36 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.005.10396158-189.out.txt
-rw-rw---- 1 kalavatt 193M Feb 18 05:04 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.01.10396158-190.out.txt
-rw-rw---- 1 kalavatt 196M Feb 18 04:13 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.05.10396158-191.out.txt
-rw-rw---- 1 kalavatt 208M Feb 18 02:45 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.1.10396158-192.out.txt
```
</details>
<br />

<a id="trinity-gfg_n-1"></a>
##### Trinity-GF/G_N/
<details>
<summary><i>Printed: Trinity-GF/G_N/</i></summary>

Jobs are still running as of 2023-0224 at ~12:30 p.m.
```txt
-rw-rw---- 2 kalavatt 1.6K Feb 22 16:30 submit_Trinity-GF_G_N.10886118-142.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 07:03 submit_Trinity-GF_G_N.10886118-158.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 08:45 submit_Trinity-GF_G_N.10886118-160.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 09:20 submit_Trinity-GF_G_N.10886118-162.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 09:21 submit_Trinity-GF_G_N.10886118-163.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 09:30 submit_Trinity-GF_G_N.10886118-164.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 10:36 submit_Trinity-GF_G_N.10886118-166.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 10:44 submit_Trinity-GF_G_N.10886118-167.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 11:12 submit_Trinity-GF_G_N.10886118-168.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 11:46 submit_Trinity-GF_G_N.10886118-169.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 12:20 submit_Trinity-GF_G_N.10886118-170.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 12:21 submit_Trinity-GF_G_N.10886118-171.out.txt
-rw-rw---- 1 kalavatt 167M Feb 17 20:18 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.10886118-1.out.txt
-rw-rw---- 1 kalavatt 167M Feb 17 14:56 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.10886118-2.out.txt
-rw-rw---- 1 kalavatt 200M Feb 17 16:18 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.10886118-3.out.txt
-rw-rw---- 1 kalavatt 226M Feb 17 14:50 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.10886118-4.out.txt
-rw-rw---- 1 kalavatt 196M Feb 17 21:11 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.005.10886118-5.out.txt
-rw-rw---- 1 kalavatt 195M Feb 17 17:32 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.01.10886118-6.out.txt
-rw-rw---- 1 kalavatt 211M Feb 17 17:21 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.05.10886118-7.out.txt
-rw-rw---- 1 kalavatt 232M Feb 17 18:04 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.1.10886118-8.out.txt
-rw-rw---- 1 kalavatt 223M Feb 17 18:02 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.005.10886118-9.out.txt
-rw-rw---- 1 kalavatt 222M Feb 17 17:53 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.01.10886118-10.out.txt
-rw-rw---- 1 kalavatt 227M Feb 17 18:03 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.05.10886118-11.out.txt
-rw-rw---- 1 kalavatt 240M Feb 17 17:03 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.1.10886118-12.out.txt
-rw-rw---- 1 kalavatt 167M Feb 18 01:54 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.005.10886118-13.out.txt
-rw-rw---- 1 kalavatt 166M Feb 17 19:00 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.01.10886118-14.out.txt
-rw-rw---- 1 kalavatt 199M Feb 17 20:32 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.05.10886118-15.out.txt
-rw-rw---- 1 kalavatt 225M Feb 17 22:32 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.1.10886118-16.out.txt
-rw-rw---- 1 kalavatt 196M Feb 17 23:24 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.005.10886118-17.out.txt
-rw-rw---- 1 kalavatt 194M Feb 17 20:46 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.01.10886118-18.out.txt
-rw-rw---- 1 kalavatt 211M Feb 17 23:11 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.05.10886118-19.out.txt
-rw-rw---- 1 kalavatt 231M Feb 17 23:10 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.1.10886118-20.out.txt
-rw-rw---- 1 kalavatt 222M Feb 17 22:43 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.005.10886118-21.out.txt
-rw-rw---- 1 kalavatt 221M Feb 17 21:43 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.01.10886118-22.out.txt
-rw-rw---- 1 kalavatt 226M Feb 17 22:06 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.05.10886118-23.out.txt
-rw-rw---- 1 kalavatt 239M Feb 18 04:28 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.1.10886118-24.out.txt
-rw-rw---- 1 kalavatt 167M Feb 18 00:42 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.005.10886118-25.out.txt
-rw-rw---- 1 kalavatt 166M Feb 18 01:10 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.01.10886118-26.out.txt
-rw-rw---- 1 kalavatt 200M Feb 18 03:13 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.05.10886118-27.out.txt
-rw-rw---- 1 kalavatt 225M Feb 18 03:38 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.1.10886118-28.out.txt
-rw-rw---- 1 kalavatt 196M Feb 18 03:14 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.005.10886118-29.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 01:55 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.01.10886118-30.out.txt
-rw-rw---- 1 kalavatt 211M Feb 18 02:19 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.05.10886118-31.out.txt
-rw-rw---- 1 kalavatt 232M Feb 18 02:33 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.1.10886118-32.out.txt
-rw-rw---- 1 kalavatt 222M Feb 18 04:10 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.005.10886118-33.out.txt
-rw-rw---- 1 kalavatt 221M Feb 18 06:45 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.01.10886118-34.out.txt
-rw-rw---- 1 kalavatt 226M Feb 18 05:22 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.05.10886118-35.out.txt
-rw-rw---- 1 kalavatt 239M Feb 18 04:25 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.1.10886118-36.out.txt
-rw-rw---- 1 kalavatt 166M Feb 18 13:40 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.005.10886118-37.out.txt
-rw-rw---- 1 kalavatt 166M Feb 18 06:54 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.01.10886118-38.out.txt
-rw-rw---- 1 kalavatt 199M Feb 18 07:03 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.05.10886118-39.out.txt
-rw-rw---- 1 kalavatt 224M Feb 18 06:17 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.1.10886118-40.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 07:56 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.005.10886118-41.out.txt
-rw-rw---- 1 kalavatt 195M Feb 18 06:22 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.01.10886118-42.out.txt
-rw-rw---- 1 kalavatt 210M Feb 18 09:43 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.05.10886118-43.out.txt
-rw-rw---- 1 kalavatt 231M Feb 18 09:36 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.1.10886118-44.out.txt
-rw-rw---- 1 kalavatt 221M Feb 18 07:26 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.005.10886118-45.out.txt
-rw-rw---- 1 kalavatt 221M Feb 18 10:43 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.01.10886118-46.out.txt
-rw-rw---- 1 kalavatt 225M Feb 18 12:04 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.05.10886118-47.out.txt
-rw-rw---- 1 kalavatt 239M Feb 18 11:11 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.1.10886118-48.out.txt
-rw-rw---- 1 kalavatt 141M Feb 18 11:16 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.005.10886118-49.out.txt
-rw-rw---- 1 kalavatt 141M Feb 18 09:39 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.10886118-50.out.txt
-rw-rw---- 1 kalavatt 166M Feb 18 12:45 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.05.10886118-51.out.txt
-rw-rw---- 1 kalavatt 187M Feb 18 11:04 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.1.10886118-52.out.txt
-rw-rw---- 1 kalavatt 162M Feb 18 11:39 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.005.10886118-53.out.txt
-rw-rw---- 1 kalavatt 161M Feb 18 13:36 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.01.10886118-54.out.txt
-rw-rw---- 1 kalavatt 174M Feb 18 13:43 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.05.10886118-55.out.txt
-rw-rw---- 1 kalavatt 192M Feb 18 13:55 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.1.10886118-56.out.txt
-rw-rw---- 1 kalavatt 184M Feb 18 15:22 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.005.10886118-57.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 14:51 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.01.10886118-58.out.txt
-rw-rw---- 1 kalavatt 188M Feb 18 16:30 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.05.10886118-59.out.txt
-rw-rw---- 1 kalavatt 200M Feb 18 15:51 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.1.10886118-60.out.txt
-rw-rw---- 1 kalavatt 141M Feb 18 16:34 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.005.10886118-61.out.txt
-rw-rw---- 1 kalavatt 140M Feb 18 16:30 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.01.10886118-62.out.txt
-rw-rw---- 1 kalavatt 166M Feb 18 16:34 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.05.10886118-63.out.txt
-rw-rw---- 1 kalavatt 187M Feb 18 16:38 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.1.10886118-64.out.txt
-rw-rw---- 1 kalavatt 161M Feb 18 17:43 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.005.10886118-65.out.txt
-rw-rw---- 1 kalavatt 161M Feb 18 18:25 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.01.10886118-66.out.txt
-rw-rw---- 1 kalavatt 174M Feb 18 18:42 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.05.10886118-67.out.txt
-rw-rw---- 1 kalavatt 192M Feb 18 18:40 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.1.10886118-68.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 18:08 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.005.10886118-69.out.txt
-rw-rw---- 1 kalavatt 182M Feb 18 19:11 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.01.10886118-70.out.txt
-rw-rw---- 1 kalavatt 187M Feb 18 20:12 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.05.10886118-71.out.txt
-rw-rw---- 1 kalavatt 199M Feb 18 22:54 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.1.10886118-72.out.txt
-rw-rw---- 1 kalavatt 140M Feb 18 21:47 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.005.10886118-73.out.txt
-rw-rw---- 1 kalavatt 140M Feb 18 23:29 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.01.10886118-74.out.txt
-rw-rw---- 1 kalavatt 166M Feb 18 22:16 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.05.10886118-75.out.txt
-rw-rw---- 1 kalavatt 187M Feb 18 23:23 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.1.10886118-76.out.txt
-rw-rw---- 1 kalavatt 161M Feb 19 00:23 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.005.10886118-77.out.txt
-rw-rw---- 1 kalavatt 161M Feb 18 21:41 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.01.10886118-78.out.txt
-rw-rw---- 1 kalavatt 174M Feb 19 01:25 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.05.10886118-79.out.txt
-rw-rw---- 1 kalavatt 192M Feb 19 01:22 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.1.10886118-80.out.txt
-rw-rw---- 1 kalavatt 183M Feb 19 00:11 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.005.10886118-81.out.txt
-rw-rw---- 1 kalavatt 183M Feb 18 22:08 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.01.10886118-82.out.txt
-rw-rw---- 1 kalavatt 187M Feb 19 01:37 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.05.10886118-83.out.txt
-rw-rw---- 1 kalavatt 199M Feb 19 02:02 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.1.10886118-84.out.txt
-rw-rw---- 1 kalavatt 140M Feb 19 02:13 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.005.10886118-85.out.txt
-rw-rw---- 1 kalavatt 140M Feb 19 01:43 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.01.10886118-86.out.txt
-rw-rw---- 1 kalavatt 165M Feb 19 03:19 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.05.10886118-87.out.txt
-rw-rw---- 1 kalavatt 186M Feb 19 02:45 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.1.10886118-88.out.txt
-rw-rw---- 1 kalavatt 160M Feb 19 05:31 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.005.10886118-89.out.txt
-rw-rw---- 1 kalavatt 160M Feb 19 05:29 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.01.10886118-90.out.txt
-rw-rw---- 1 kalavatt 173M Feb 19 03:56 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.05.10886118-91.out.txt
-rw-rw---- 1 kalavatt 191M Feb 19 04:57 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.1.10886118-92.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 07:55 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.005.10886118-93.out.txt
-rw-rw---- 1 kalavatt 182M Feb 19 05:19 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.01.10886118-94.out.txt
-rw-rw---- 1 kalavatt 187M Feb 19 07:37 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.05.10886118-95.out.txt
-rw-rw---- 1 kalavatt 199M Feb 19 06:07 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.1.10886118-96.out.txt
-rw-rw---- 1 kalavatt 127M Feb 19 05:09 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.005.10886118-97.out.txt
-rw-rw---- 1 kalavatt 127M Feb 19 08:33 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.01.10886118-98.out.txt
-rw-rw---- 1 kalavatt 148M Feb 19 07:11 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.05.10886118-99.out.txt
-rw-rw---- 1 kalavatt 168M Feb 19 07:34 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.1.10886118-100.out.txt
-rw-rw---- 1 kalavatt 143M Feb 19 08:49 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.005.10886118-101.out.txt
-rw-rw---- 1 kalavatt 143M Feb 19 09:21 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.01.10886118-102.out.txt
-rw-rw---- 1 kalavatt 154M Feb 19 08:19 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.05.10886118-103.out.txt
-rw-rw---- 1 kalavatt 171M Feb 19 10:33 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.1.10886118-104.out.txt
-rw-rw---- 1 kalavatt 162M Feb 19 12:21 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.005.10886118-105.out.txt
-rw-rw---- 1 kalavatt 161M Feb 19 09:46 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.01.10886118-106.out.txt
-rw-rw---- 1 kalavatt 165M Feb 19 10:19 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.05.10886118-107.out.txt
-rw-rw---- 1 kalavatt 177M Feb 19 10:48 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.1.10886118-108.out.txt
-rw-rw---- 1 kalavatt 127M Feb 19 11:10 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.005.10886118-109.out.txt
-rw-rw---- 1 kalavatt 126M Feb 19 12:09 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.01.10886118-110.out.txt
-rw-rw---- 1 kalavatt 148M Feb 19 14:02 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.05.10886118-111.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 11:56 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.1.10886118-112.out.txt
-rw-rw---- 1 kalavatt 143M Feb 19 13:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005.10886118-113.out.txt
-rw-rw---- 1 kalavatt 142M Feb 19 14:06 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.10886118-114.out.txt
-rw-rw---- 1 kalavatt 154M Feb 19 14:28 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05.10886118-115.out.txt
-rw-rw---- 1 kalavatt 171M Feb 19 13:47 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.10886118-116.out.txt
-rw-rw---- 1 kalavatt 161M Feb 19 15:16 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.005.10886118-117.out.txt
-rw-rw---- 1 kalavatt 160M Feb 19 15:18 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.01.10886118-118.out.txt
-rw-rw---- 1 kalavatt 165M Feb 19 14:04 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.05.10886118-119.out.txt
-rw-rw---- 1 kalavatt 176M Feb 19 14:32 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.1.10886118-120.out.txt
-rw-rw---- 1 kalavatt 127M Feb 19 14:19 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.005.10886118-121.out.txt
-rw-rw---- 1 kalavatt 127M Feb 19 16:15 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.01.10886118-122.out.txt
-rw-rw---- 1 kalavatt 148M Feb 19 16:02 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.05.10886118-123.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 18:27 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.1.10886118-124.out.txt
-rw-rw---- 1 kalavatt 143M Feb 19 19:03 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.005.10886118-125.out.txt
-rw-rw---- 1 kalavatt 142M Feb 19 18:58 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.01.10886118-126.out.txt
-rw-rw---- 1 kalavatt 154M Feb 19 16:51 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.05.10886118-127.out.txt
-rw-rw---- 1 kalavatt 170M Feb 19 19:36 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.1.10886118-128.out.txt
-rw-rw---- 1 kalavatt 161M Feb 19 17:09 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.005.10886118-129.out.txt
-rw-rw---- 1 kalavatt 161M Feb 19 19:47 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.01.10886118-130.out.txt
-rw-rw---- 1 kalavatt 164M Feb 19 17:41 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.05.10886118-131.out.txt
-rw-rw---- 1 kalavatt 176M Feb 19 19:57 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.1.10886118-132.out.txt
-rw-rw---- 1 kalavatt 127M Feb 19 19:27 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.005.10886118-133.out.txt
-rw-rw---- 1 kalavatt 126M Feb 19 21:06 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.01.10886118-134.out.txt
-rw-rw---- 1 kalavatt 147M Feb 19 20:55 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.05.10886118-135.out.txt
-rw-rw---- 1 kalavatt 167M Feb 19 20:55 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.1.10886118-136.out.txt
-rw-rw---- 1 kalavatt 142M Feb 19 20:40 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.005.10886118-137.out.txt
-rw-rw---- 1 kalavatt 142M Feb 19 22:55 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.01.10886118-138.out.txt
-rw-rw---- 1 kalavatt 153M Feb 19 20:58 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.05.10886118-139.out.txt
-rw-rw---- 1 kalavatt 170M Feb 22 13:47 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.1.10886118-140.out.txt
-rw-rw---- 1 kalavatt 161M Feb 22 16:26 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.005.10886118-141.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 22 16:30 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.01.10886118-142.out.txt
-rw-rw---- 1 kalavatt 164M Feb 24 04:34 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.05.10886118-143.out.txt
-rw-rw---- 1 kalavatt 176M Feb 24 07:03 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.1.10886118-144.out.txt
-rw-rw---- 1 kalavatt 131M Feb 24 05:33 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.005.10886118-145.out.txt
-rw-rw---- 1 kalavatt 130M Feb 24 05:46 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.01.10886118-146.out.txt
-rw-rw---- 1 kalavatt 149M Feb 24 09:03 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.05.10886118-147.out.txt
-rw-rw---- 1 kalavatt 165M Feb 24 06:15 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.1.10886118-148.out.txt
-rw-rw---- 1 kalavatt 145M Feb 24 09:30 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.005.10886118-149.out.txt
-rw-rw---- 1 kalavatt 144M Feb 24 09:21 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.01.10886118-150.out.txt
-rw-rw---- 1 kalavatt 155M Feb 24 10:36 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.05.10886118-151.out.txt
-rw-rw---- 1 kalavatt 168M Feb 24 11:12 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.1.10886118-152.out.txt
-rw-rw---- 1 kalavatt 160M Feb 24 07:31 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.005.10886118-153.out.txt
-rw-rw---- 1 kalavatt 160M Feb 24 09:20 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.01.10886118-154.out.txt
-rw-rw---- 1 kalavatt 165M Feb 24 10:44 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.05.10886118-155.out.txt
-rw-rw---- 1 kalavatt 174M Feb 24 08:45 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.1.10886118-156.out.txt
-rw-rw---- 1 kalavatt 131M Feb 24 12:20 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.005.10886118-157.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 07:03 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.01.10886118-158.out.txt
-rw-rw---- 1 kalavatt 149M Feb 24 09:49 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.05.10886118-159.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 08:45 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.1.10886118-160.out.txt
-rw-rw---- 1 kalavatt 144M Feb 24 11:46 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.005.10886118-161.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 09:20 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.01.10886118-162.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 09:21 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.05.10886118-163.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 09:30 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.1.10886118-164.out.txt
-rw-rw---- 1 kalavatt 160M Feb 24 12:20 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.005.10886118-165.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 10:36 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.01.10886118-166.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 10:44 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.05.10886118-167.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 11:12 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.1.10886118-168.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 11:46 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.005.10886118-169.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 12:20 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.01.10886118-170.out.txt
-rw-rw---- 2 kalavatt 1.6K Feb 24 12:21 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.05.10886118-171.out.txt
```
</details>
<br />

<a id="check-on-trinity-outfiles"></a>
### Check on Trinity outfiles
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Check on Trinity outfiles</i></summary>

<a id="trinity-ggq_n-2"></a>
##### Trinity-GG/Q_N/
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "outfiles_Trinity-GG/Q_N/"

.,
```

<a id="trinity-ggg_n-2"></a>
##### Trinity-GG/G_N/
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "outfiles_Trinity-GG/G_N/"

.,
```

<a id="trinity-gfq_n-2"></a>
##### Trinity-GF/Q_N/
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "outfiles_Trinity-GF/Q_N/"

.,
```

<a id="trinity-gfg_n-2"></a>
##### Trinity-GF/G_N/
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "${HOME}/2022_transcriptome-construction/results/2023-0111/"

cd "outfiles_Trinity-GF/G_N/"

.,
```
</details>
<br />

<a id="printed-notes-1"></a>
#### Printed, notes
<a id="trinity-ggq_n-3"></a>
##### Trinity-GG/Q_N/
<details>
<summary><i>Printed, notes: Trinity-GG/Q_N/</i></summary>

```txt
❯ .,
total 3.5G
drwxr-sr-x 6 kalavatt  46K Feb 17 05:17 ./
drwxrws--- 4 kalavatt   42 Feb 14 11:51 ../
drwxrws--- 2 kalavatt 8.7K Feb 14 17:09 lists/
-rw-r--r-- 1 kalavatt 9.0M Feb 16 13:18 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 13:26 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 13:27 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 13:32 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 13:35 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 13:40 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 13:38 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 13:42 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 14:04 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 14:08 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 14:25 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 14:28 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 14:13 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 14:17 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 14:20 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 14:23 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 14:45 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 14:53 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 15:08 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 15:27 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 15:09 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 15:27 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 15:12 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 15:27 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 15:29 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 15:36 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 15:23 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 15:31 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
drwxr-sr-x 4 kalavatt 1.8K Feb 16 17:47 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05/
-rw-r--r-- 1 kalavatt 9.0M Feb 16 16:06 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 16:14 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 16:01 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 16:06 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 16:49 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 17:01 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 16:55 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 17:04 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 17:15 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 17:26 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 17:12 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 17:21 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 17:07 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 17:16 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 17:22 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 17:32 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 17:15 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 17:28 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 17:57 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 18:03 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 17:56 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 18:01 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:31 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 19:35 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 18:48 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 18:51 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:06 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 19:14 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:02 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 19:13 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:17 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 19:22 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 19:14 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 19:17 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:26 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 19:31 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:46 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 19:49 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 19:45 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 19:48 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 19:45 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 19:48 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 20:37 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 20:40 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 20:51 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 472K Feb 16 20:54 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 21:09 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 21:14 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 21:00 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 21:03 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 21:05 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 21:09 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 21:12 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 21:16 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 21:19 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 21:22 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 21:28 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 21:31 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 21:30 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 21:32 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 21:31 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 471K Feb 16 21:34 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.1M Feb 16 22:24 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 470K Feb 16 22:27 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 9.0M Feb 16 22:29 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 16 22:32 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 14 19:19 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 657K Feb 14 19:26 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 14 19:27 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 657K Feb 14 19:29 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 19:23 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 630K Feb 14 19:28 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:08 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 611K Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:07 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 633K Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:07 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 633K Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:08 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 623K Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:08 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 610K Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:09 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 618K Feb 15 04:18 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 19:39 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 618K Feb 14 19:42 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 19:39 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 616K Feb 14 19:42 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 19:39 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 608K Feb 14 19:42 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 14 21:28 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 657K Feb 14 21:32 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 14 21:30 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 657K Feb 14 21:33 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 21:33 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 630K Feb 14 21:35 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 21:50 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 611K Feb 14 21:53 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 21:49 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 633K Feb 14 21:53 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 21:48 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 633K Feb 14 21:52 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 23:34 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 623K Feb 14 23:40 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 23:42 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 610K Feb 14 23:47 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 23:39 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 618K Feb 14 23:44 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 23:58 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 618K Feb 15 00:04 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 23:56 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 616K Feb 15 00:02 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 14 23:54 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 608K Feb 15 00:01 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 15 01:39 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 648K Feb 15 01:44 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 15 01:45 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 648K Feb 15 01:50 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 02:04 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 630K Feb 15 02:11 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 02:49 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 611K Feb 15 02:54 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 02:06 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 630K Feb 15 02:12 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 02:02 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 631K Feb 15 02:08 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 03:43 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 623K Feb 15 03:47 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 03:53 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 610K Feb 15 03:56 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:43 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 618K Feb 15 04:48 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:32 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 618K Feb 15 04:37 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 04:49 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 616K Feb 15 04:53 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 05:18 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 608K Feb 15 05:24 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 05:40 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 635K Feb 15 05:43 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  17M Feb 15 05:52 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 635K Feb 15 05:55 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:13 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 625K Feb 15 06:18 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:29 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 610K Feb 15 06:32 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:32 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 626K Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:30 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 626K Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:35 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 621K Feb 15 06:37 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:30 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 609K Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:31 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 617K Feb 15 06:34 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 06:58 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 617K Feb 15 07:02 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 07:07 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 616K Feb 15 07:10 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  16M Feb 15 07:34 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 607K Feb 15 07:38 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 07:34 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 585K Feb 15 07:38 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 07:49 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 584K Feb 15 07:52 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 08:11 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 562K Feb 15 08:18 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 08:38 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 08:46 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 09:07 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 567K Feb 15 09:46 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 08:58 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 567K Feb 15 09:11 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 08:59 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 559K Feb 15 09:11 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 08:59 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 09:11 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 09:01 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 09:13 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 10:23 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 10:54 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 09:21 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 553K Feb 15 09:47 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 09:34 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 544K Feb 15 10:00 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 09:49 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 585K Feb 15 10:24 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 09:53 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 584K Feb 15 10:30 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 10:21 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 562K Feb 15 10:44 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 10:57 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 11:23 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 11:49 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 567K Feb 15 12:01 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 11:12 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 567K Feb 15 11:32 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 11:16 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 559K Feb 15 11:34 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 11:38 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 11:43 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 12:10 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 12:24 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 12:10 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 12:21 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 12:04 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 553K Feb 15 12:15 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:40 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 544K Feb 15 14:47 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 12:31 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 580K Feb 15 12:36 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 12:41 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 579K Feb 15 12:47 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 13:09 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 562K Feb 15 13:20 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 13:24 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 13:30 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 13:26 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 566K Feb 15 13:31 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 13:31 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 566K Feb 15 13:38 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 13:53 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 559K Feb 15 13:59 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:07 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 14:19 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:18 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 14:23 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:21 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 555K Feb 15 14:25 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:28 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 553K Feb 15 14:33 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:37 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 544K Feb 15 14:42 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 14:42 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 570K Feb 15 14:47 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 15:19 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 570K Feb 15 15:27 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 15:28 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 560K Feb 15 15:36 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 15:25 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 545K Feb 15 15:32 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 15:44 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 563K Feb 15 15:48 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:03 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 563K Feb 15 16:18 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:22 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 558K Feb 15 16:33 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:40 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 546K Feb 15 16:45 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:26 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 16:35 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:38 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 554K Feb 15 16:44 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:42 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 553K Feb 15 16:47 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  15M Feb 15 16:59 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 544K Feb 15 17:20 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 22:38 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 16 22:41 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 22:42 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 16 22:45 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 22:48 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 16 22:51 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 22:44 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 16 22:47 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 22:50 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 395K Feb 16 22:53 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 23:05 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 16 23:09 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:17 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:22 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 23:09 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 16 23:12 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 23:12 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 16 23:14 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 23:55 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 16 23:57 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 16 23:58 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:01 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:25 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 00:28 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:15 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:19 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:19 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:22 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:26 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:29 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:21 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 00:24 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:42 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 395K Feb 17 00:45 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:43 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:45 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 00:48 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 00:52 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 01:39 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 01:43 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 01:38 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 01:41 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 01:52 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 01:56 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 01:58 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 02:01 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 02:05 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 02:10 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 01:53 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 01:57 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 02:08 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 02:12 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 02:02 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 02:07 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 02:16 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 02:20 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 02:21 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 395K Feb 17 02:24 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 02:28 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 02:31 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:27 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:33 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:18 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 03:22 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:26 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:30 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:28 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:32 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:32 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:35 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:35 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 03:37 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:45 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:48 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:44 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:47 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 03:53 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 03:57 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 04:16 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 04:20 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 04:03 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 395K Feb 17 04:06 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 04:50 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 04:53 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 05:01 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 05:04 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 05:03 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 05:07 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 05:13 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 05:16 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 05:07 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 05:10 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 05:09 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 394K Feb 17 05:12 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 5.9M Feb 17 05:14 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 17 05:17 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 16:36 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 520K Feb 15 16:40 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 17:31 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 520K Feb 15 18:02 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 17:22 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 506K Feb 15 17:53 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 17:42 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 15 18:23 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 21:28 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 512K Feb 16 21:31 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 18:25 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 512K Feb 15 18:53 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 18:46 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 505K Feb 15 19:04 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 18:36 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 15 18:56 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 19:00 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 503K Feb 15 19:24 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
drwxr-sr-x 4 kalavatt 1.7K Feb 15 17:10 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01/
-rw-r--r-- 1 kalavatt  13M Feb 15 19:24 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 502K Feb 15 19:46 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 18:56 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 492K Feb 15 19:29 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 19:28 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 520K Feb 15 19:48 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 19:52 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 520K Feb 15 20:01 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 20:07 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 506K Feb 15 20:28 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 20:41 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 15 20:51 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 20:52 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 512K Feb 15 20:58 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:05 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 512K Feb 15 21:13 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:02 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 505K Feb 15 21:11 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:18 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 15 21:23 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:31 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 503K Feb 15 21:36 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:53 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 503K Feb 15 21:59 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:43 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 502K Feb 15 21:51 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 21:55 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 492K Feb 15 22:00 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 22:27 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 519K Feb 15 22:35 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 22:43 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 519K Feb 15 22:49 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 23:01 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 506K Feb 15 23:08 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 23:07 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 15 23:14 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 23:14 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 512K Feb 15 23:18 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 23:18 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 512K Feb 15 23:23 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 23:39 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 505K Feb 15 23:45 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 00:00 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 16 00:06 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 00:00 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 504K Feb 16 00:06 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 15 23:55 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 504K Feb 16 00:03 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 00:33 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 502K Feb 16 00:37 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 00:43 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 492K Feb 16 00:48 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 01:06 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 514K Feb 16 01:14 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 01:07 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 514K Feb 16 01:14 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 01:12 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 505K Feb 16 01:17 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 01:25 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 16 01:30 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 01:45 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 510K Feb 16 01:50 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 01:57 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 510K Feb 16 02:01 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 02:10 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 505K Feb 16 02:20 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 02:13 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 493K Feb 16 02:19 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 02:36 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 503K Feb 16 02:41 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 02:44 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 503K Feb 16 02:48 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 03:10 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 501K Feb 16 03:20 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 16 03:05 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 492K Feb 16 03:16 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 03:18 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 03:26 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 03:31 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 03:35 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 03:52 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 03:56 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 03:49 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 03:53 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 04:16 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 04:21 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 04:28 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 04:31 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 04:31 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 04:36 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 04:32 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 04:37 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 04:59 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 05:03 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 05:07 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 05:14 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 05:11 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 475K Feb 16 05:18 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 05:33 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 05:38 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 05:36 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 05:41 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 05:43 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 05:57 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 06:20 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 06:34 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 06:17 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 06:30 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 06:27 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 06:35 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 06:21 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 06:32 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 06:47 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 06:54 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 07:05 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 07:24 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 07:25 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 07:34 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 07:32 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 07:42 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 07:32 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 475K Feb 16 07:43 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 07:59 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 08:09 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:34 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 09:38 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:33 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 09:38 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:35 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 09:38 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 08:31 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 08:36 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 08:38 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 08:42 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:10 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 09:15 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:21 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 09:26 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:44 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 09:48 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 09:31 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 09:35 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 10:07 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 10:14 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 10:22 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 475K Feb 16 10:26 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 10:25 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 10:28 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:01 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 11:04 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:26 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 16 11:42 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:22 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 11:26 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:35 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 11:45 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:34 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 11:45 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:20 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 16 11:24 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 11:39 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 476K Feb 16 11:47 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 12:15 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 12:34 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 12:16 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 12:38 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 16 12:14 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 16 12:34 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
drwxr-sr-x 4 kalavatt 1.8K Feb 16 13:02 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05/
-rw-r--r-- 1 kalavatt  12M Feb 16 13:16 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 16 13:26 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
```
</details>
<br />

<a id="trinity-ggg_n-3"></a>
##### Trinity-GG/G_N/
<details>
<summary><i>Printed: Trinity-GG/G_N/</i></summary>

```txt
❯ .,
total 3.1G
drwxrws--- 3 kalavatt  46K Feb 19 18:48 ./
drwxrws--- 4 kalavatt   42 Feb 14 11:51 ../
drwxrws--- 2 kalavatt 8.7K Feb 17 11:37 lists/
-rw-r--r-- 1 kalavatt 8.8M Feb 19 03:09 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 03:11 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 03:06 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 03:07 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 03:27 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 03:29 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 03:25 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 03:26 trinity-gg_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 03:56 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 03:58 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 04:14 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 04:16 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 03:55 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 03:56 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 04:34 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 04:36 trinity-gg_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 05:21 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 05:23 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 05:05 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 05:07 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 05:10 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 05:11 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 05:20 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 05:22 trinity-gg_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 05:16 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 05:18 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 05:16 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 05:18 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 05:19 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 05:20 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 05:34 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 05:36 trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 05:45 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 05:46 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 06:19 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 06:22 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 06:19 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 06:20 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 06:41 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 06:42 trinity-gg_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 07:10 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 07:12 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 07:15 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 07:17 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 07:05 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 07:06 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 07:31 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 07:32 trinity-gg_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 07:17 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 07:18 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 07:26 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 07:27 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 07:48 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 07:49 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 07:44 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 07:45 trinity-gg_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 07:39 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 07:40 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 08:52 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 08:54 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 08:33 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 08:35 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 09:23 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 09:25 trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 08:53 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 08:54 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 09:04 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 09:06 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 09:09 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 09:10 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 09:14 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 09:16 trinity-gg_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 09:20 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 09:22 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 09:43 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 19 09:44 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 09:31 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 09:33 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 09:57 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 09:59 trinity-gg_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 10:00 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 10:03 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 10:57 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 389K Feb 19 10:59 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 11:01 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 11:02 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 10:46 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 10:48 trinity-gg_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 12:06 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 12:10 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 11:16 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 19 11:18 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.8M Feb 19 11:10 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 387K Feb 19 11:12 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 8.9M Feb 19 11:41 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 385K Feb 19 11:43 trinity-gg_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:26 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 517K Feb 17 14:30 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:09 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 517K Feb 17 14:15 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 13:56 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 17 13:59 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 13:54 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 17 13:58 trinity-gg_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:21 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 494K Feb 17 14:26 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 13:57 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 494K Feb 17 14:02 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:34 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 478K Feb 17 14:40 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:38 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 17 14:42 trinity-gg_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:02 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 14:05 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:02 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 14:05 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 13:56 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 474K Feb 17 13:59 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 14:23 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 466K Feb 17 14:27 trinity-gg_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:12 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 517K Feb 17 16:17 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:13 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 517K Feb 17 16:17 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:12 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 482K Feb 17 16:18 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:29 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 17 16:33 trinity-gg_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:34 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 494K Feb 17 16:36 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:28 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 494K Feb 17 16:33 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:39 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 478K Feb 17 16:41 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:51 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 17 16:52 trinity-gg_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 16:51 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 16:53 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 17:10 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 17:14 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 17:11 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 474K Feb 17 17:12 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 17:15 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 466K Feb 17 17:18 trinity-gg_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 18:35 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 507K Feb 17 18:36 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 18:29 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 506K Feb 17 18:30 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 18:53 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 481K Feb 17 18:56 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 18:56 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 17 18:58 trinity-gg_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 18:58 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 491K Feb 17 19:01 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:07 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 490K Feb 17 19:08 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:04 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 19:06 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:02 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 17 19:03 trinity-gg_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:06 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 19:07 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:51 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 477K Feb 17 19:52 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:32 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 474K Feb 17 19:33 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 19:47 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 466K Feb 17 19:49 trinity-gg_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 20:46 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 491K Feb 17 20:47 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:10 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 491K Feb 17 21:12 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:49 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 479K Feb 17 21:50 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:23 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 468K Feb 17 21:24 trinity-gg_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:35 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 17 21:37 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:19 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 484K Feb 17 21:20 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:31 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 476K Feb 17 21:32 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:35 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 467K Feb 17 21:36 trinity-gg_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:44 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 476K Feb 17 21:46 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 22:07 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 476K Feb 17 22:08 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 21:58 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 474K Feb 17 21:59 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 22:14 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 466K Feb 17 22:15 trinity-gg_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 22:59 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 464K Feb 17 23:01 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 17 23:35 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 464K Feb 17 23:37 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 17 23:36 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 434K Feb 17 23:38 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 17 23:43 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 420K Feb 17 23:45 trinity-gg_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 17 23:49 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 447K Feb 17 23:51 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:01 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 447K Feb 18 00:03 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:00 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 00:02 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:00 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 00:02 trinity-gg_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:13 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 432K Feb 18 00:14 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:12 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 432K Feb 18 00:13 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:26 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 428K Feb 18 00:29 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 00:24 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 418K Feb 18 00:25 trinity-gg_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 18 03:18 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 464K Feb 18 03:20 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 18 01:54 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 464K Feb 18 01:56 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 01:49 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 434K Feb 18 01:50 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 01:56 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 420K Feb 18 01:58 trinity-gg_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:05 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 447K Feb 18 02:06 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:19 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 447K Feb 18 02:20 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:26 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 02:27 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:18 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 02:20 trinity-gg_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:22 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 432K Feb 18 02:23 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:29 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 432K Feb 18 02:30 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:30 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 428K Feb 18 02:30 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 02:47 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 418K Feb 18 02:48 trinity-gg_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 18 12:38 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 458K Feb 18 12:39 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  13M Feb 18 04:13 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 458K Feb 18 04:15 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:11 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 434K Feb 18 04:13 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:21 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 420K Feb 18 04:22 trinity-gg_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 05:10 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 445K Feb 18 05:11 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:39 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 445K Feb 18 04:40 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:30 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 04:31 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:55 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 04:56 trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:46 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 04:47 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 04:46 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 04:47 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 05:12 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 428K Feb 18 05:14 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 06:01 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 418K Feb 18 06:04 trinity-gg_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 06:26 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 445K Feb 18 06:27 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 06:36 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 445K Feb 18 06:37 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 06:39 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 432K Feb 18 06:40 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 06:42 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 06:42 trinity-gg_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 07:02 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 439K Feb 18 07:03 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 06:58 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 439K Feb 18 06:59 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 07:07 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 430K Feb 18 07:08 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 07:13 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 07:14 trinity-gg_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 07:36 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 07:37 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 07:32 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 431K Feb 18 07:32 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 08:40 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 428K Feb 18 08:41 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:12 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 418K Feb 18 10:14 trinity-gg_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 11:50 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 11:53 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 11:14 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 11:15 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 11:30 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 11:31 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 11:47 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 11:49 trinity-gg_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 12:05 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 12:07 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 12:32 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 12:33 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 12:57 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 12:58 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:10 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 13:11 trinity-gg_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:00 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 13:02 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 12:57 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 12:59 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:03 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 13:04 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:17 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 13:19 trinity-gg_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:26 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 13:27 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:39 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 13:40 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:49 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 13:50 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 13:54 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 13:55 trinity-gg_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:01 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 14:02 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:16 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 14:18 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:42 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 14:44 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:39 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 14:41 trinity-gg_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:47 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 14:48 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:55 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 14:56 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 14:51 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 14:52 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 15:01 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 15:03 trinity-gg_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 15:15 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 15:16 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 15:23 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 15:24 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 15:49 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 15:51 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 15:39 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 15:41 trinity-gg_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:04 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:06 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:05 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:06 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:20 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:22 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:28 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 16:29 trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:35 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:36 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:32 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:33 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:48 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:49 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:42 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 16:43 trinity-gg_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 16:58 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 16:59 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 17:21 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 17:22 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 17:30 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 17:31 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 17:37 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 17:38 trinity-gg_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 17:52 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 17:53 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 17:56 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 17:57 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 18:01 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 18:01 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 18:46 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 18:48 trinity-gg_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 18:19 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 18:20 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 18:16 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 18:17 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 18:33 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 376K Feb 19 18:34 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt 6.7M Feb 19 18:33 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 18:34 trinity-gg_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:03 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 10:05 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 08:56 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 08:57 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 08:48 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 08:49 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 09:08 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 09:09 trinity-gg_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 09:37 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 09:38 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 09:17 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 09:18 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:05 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 399K Feb 18 10:07 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:20 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 10:22 trinity-gg_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 09:42 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 09:43 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:48 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 10:49 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:55 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 397K Feb 18 10:56 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 10:58 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 10:59 trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 11:11 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 11:12 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 11:19 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 419K Feb 18 11:20 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 11:47 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 11:48 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 11:42 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 11:43 trinity-gg_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 12:05 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 12:06 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 12:18 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 12:21 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 12:40 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 399K Feb 18 12:42 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 12:40 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 12:42 trinity-gg_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 14:30 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 14:32 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 13:37 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 13:39 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 13:04 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 397K Feb 18 13:05 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 13:18 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 13:19 trinity-gg_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 13:26 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 418K Feb 18 13:27 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 13:40 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 417K Feb 18 13:41 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 14:42 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 14:43 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 14:15 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 14:17 trinity-gg_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:07 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 15:09 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:07 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 409K Feb 18 15:08 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 14:52 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 399K Feb 18 14:53 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:25 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 15:26 trinity-gg_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:20 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 15:22 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:58 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 15:59 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:27 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 397K Feb 18 15:28 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:58 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 15:59 trinity-gg_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 15:38 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 15:39 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 16:34 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 410K Feb 18 16:36 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 16:59 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 399K Feb 18 17:00 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 16:52 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 16:54 trinity-gg_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 16:56 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 406K Feb 18 16:58 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 17:15 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 406K Feb 18 17:17 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 17:28 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 398K Feb 18 17:31 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 17:30 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 17:32 trinity-gg_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 17:50 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 399K Feb 18 17:53 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 17:34 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 400K Feb 18 17:36 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 17:36 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 397K Feb 18 17:37 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  12M Feb 18 18:12 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 388K Feb 18 18:14 trinity-gg_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 18:04 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 18 18:06 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 18:44 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 18 18:45 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:05 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 18 19:06 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:08 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 18 19:10 trinity-gg_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:09 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 18 19:10 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:43 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 18 19:44 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 20:00 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 18 20:01 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:42 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 18 19:43 trinity-gg_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:45 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 18 19:47 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 19:39 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 18 19:40 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 20:18 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 382K Feb 18 20:19 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 20:12 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 18 20:14 trinity-gg_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 20:27 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 18 20:29 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 20:43 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 18 20:44 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 21:12 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 18 21:14 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 21:13 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 18 21:14 trinity-gg_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 21:20 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 18 21:21 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 21:32 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 18 21:32 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 21:41 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 18 21:42 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 22:23 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 18 22:25 trinity-gg_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 21:49 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 18 21:51 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 22:41 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 18 22:43 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 22:37 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 382K Feb 18 22:40 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 22:54 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 18 22:55 trinity-gg_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:01 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 18 23:02 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:13 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 18 23:15 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:20 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 18 23:23 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:18 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 18 23:20 trinity-gg_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:40 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 18 23:41 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:27 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 391K Feb 18 23:28 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:39 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 18 23:40 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 18 23:55 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 18 23:57 trinity-gg_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 00:48 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 19 00:51 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 00:57 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 19 01:00 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:06 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 382K Feb 19 01:07 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:19 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 19 01:20 trinity-gg_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:39 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 19 01:41 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:52 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 392K Feb 19 01:53 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:19 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 19 01:20 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:29 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 19 01:31 trinity-gg_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:20 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 390K Feb 19 01:21 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:34 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 390K Feb 19 01:34 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 02:10 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 383K Feb 19 02:12 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 01:59 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 375K Feb 19 02:02 trinity-gg_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 02:59 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 19 03:01 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 03:17 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 384K Feb 19 03:20 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 03:18 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 382K Feb 19 03:21 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05.Trinity-GG.fasta.gene_trans_map
-rw-r--r-- 1 kalavatt  11M Feb 19 03:34 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta
-rw-r--r-- 1 kalavatt 374K Feb 19 03:36 trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity-GG.fasta.gene_trans_map
```

</details>
<br />

<a id="trinity-gfq_n-3"></a>
##### Trinity-GF/Q_N/
<details>
<summary><i>Printed: Trinity-GF/Q_N/</i></summary>

```txt
❯ .,
total 2.1G
drwxrws--- 10 kalavatt  44K Feb 19 16:25 ./
drwxrws---  4 kalavatt   42 Feb 14 11:51 ../
drwxrws---  2 kalavatt 8.7K Feb 14 16:51 lists/
-rw-r--r--  1 kalavatt 2.8M Feb 18 10:04 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 291K Feb 18 10:06 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 05:20 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 290K Feb 18 05:21 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.2M Feb 18 13:10 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 329K Feb 18 13:11 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 03:37 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 363K Feb 18 03:38 trinity-gf_mkc-16_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.1M Feb 18 02:51 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 315K Feb 18 02:51 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.1M Feb 18 02:33 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 315K Feb 18 02:34 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.3M Feb 18 06:38 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 334K Feb 18 06:39 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 07:30 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 364K Feb 18 07:31 trinity-gf_mkc-16_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 08:29 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 342K Feb 18 08:30 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 08:57 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 342K Feb 18 08:59 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 06:24 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 347K Feb 18 06:25 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 07:26 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 368K Feb 18 07:27 trinity-gf_mkc-16_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 07:16 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 291K Feb 18 07:16 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 08:01 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 289K Feb 18 08:02 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.2M Feb 18 08:06 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 329K Feb 18 08:08 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 11:30 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 362K Feb 18 11:31 trinity-gf_mkc-16_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.0M Feb 18 10:48 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 314K Feb 18 10:49 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.0M Feb 18 10:44 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 314K Feb 18 10:45 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.3M Feb 18 10:01 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 335K Feb 18 10:02 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 11:56 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 363K Feb 18 11:57 trinity-gf_mkc-16_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 12:02 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 342K Feb 18 12:03 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 12:19 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 342K Feb 18 12:20 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 11:53 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 347K Feb 18 11:54 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.7M Feb 18 12:08 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 369K Feb 18 12:09 trinity-gf_mkc-16_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 14:24 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 290K Feb 18 14:26 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 12:21 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 290K Feb 18 12:22 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.2M Feb 18 14:03 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 329K Feb 18 14:04 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 14:08 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 363K Feb 18 14:11 trinity-gf_mkc-16_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.1M Feb 18 16:04 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 315K Feb 18 16:05 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.1M Feb 18 17:11 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 315K Feb 18 17:12 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.3M Feb 18 16:36 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 335K Feb 18 16:36 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 17:10 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 364K Feb 18 17:11 trinity-gf_mkc-16_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 16:30 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 343K Feb 18 16:31 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 16:42 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 342K Feb 18 16:43 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 15:16 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 347K Feb 18 15:17 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 16:11 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 369K Feb 18 16:12 trinity-gf_mkc-16_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 16:45 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 290K Feb 18 16:46 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 2.8M Feb 18 16:54 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 290K Feb 18 16:55 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.2M Feb 18 18:22 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 329K Feb 18 18:23 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 19:55 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 362K Feb 18 19:56 trinity-gf_mkc-16_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.1M Feb 18 18:09 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 315K Feb 18 18:09 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.1M Feb 18 20:21 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 316K Feb 18 20:21 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.2M Feb 18 22:02 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 334K Feb 18 22:03 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 21:15 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 363K Feb 18 21:17 trinity-gf_mkc-16_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 22:03 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 343K Feb 18 22:04 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 23:53 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 343K Feb 18 23:55 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.4M Feb 18 20:33 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 348K Feb 18 20:33 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 3.6M Feb 18 20:31 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 369K Feb 18 20:32 trinity-gf_mkc-16_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
drwxr-sr-x  8 kalavatt 1.2K Feb 14 21:02 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005/
-rw-r--r--  1 kalavatt  12M Feb 14 21:02 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 755K Feb 14 21:02 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
drwxr-sr-x  8 kalavatt 1.2K Feb 14 19:45 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01/
-rw-r--r--  1 kalavatt  12M Feb 14 19:45 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 755K Feb 14 19:45 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
drwxr-sr-x  8 kalavatt 1.2K Feb 15 10:58 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05/
-rw-r--r--  1 kalavatt  12M Feb 15 10:58 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 752K Feb 15 10:58 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
drwxr-sr-x  8 kalavatt 1.2K Feb 15 11:09 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1/
-rw-r--r--  1 kalavatt  12M Feb 15 11:09 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 746K Feb 15 11:09 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 14 20:17 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 751K Feb 14 20:21 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 14 21:33 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 752K Feb 14 21:36 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 14 21:40 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 750K Feb 14 21:42 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 01:32 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 745K Feb 15 01:37 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 01:11 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 01:17 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 00:08 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 00:15 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 14 22:04 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 14 22:12 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 14 22:09 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 740K Feb 14 22:15 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 14 23:46 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 755K Feb 14 23:50 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 00:32 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 754K Feb 15 00:36 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 00:36 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 752K Feb 15 00:41 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 02:05 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 745K Feb 15 02:10 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 01:57 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 750K Feb 15 02:00 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 03:47 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 750K Feb 15 03:50 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 01:19 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 751K Feb 15 01:24 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 03:36 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 745K Feb 15 03:39 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 06:20 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 744K Feb 15 06:24 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 05:07 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 05:12 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 04:18 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 04:23 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 07:31 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 15 07:36 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 05:52 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 754K Feb 15 05:54 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 06:36 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 755K Feb 15 06:38 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 07:45 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 754K Feb 15 07:47 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 07:03 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 745K Feb 15 07:05 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 09:02 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 751K Feb 15 09:09 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 07:09 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 751K Feb 15 07:12 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 07:38 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 751K Feb 15 07:40 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 11:09 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 745K Feb 15 11:27 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 11:41 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 742K Feb 15 11:44 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 12:34 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 12:39 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 09:54 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 10:12 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 14:12 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 15 14:19 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 10:50 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 755K Feb 15 11:02 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 12:13 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 756K Feb 15 12:20 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 14:52 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 752K Feb 15 14:54 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 11:58 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 746K Feb 15 12:04 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 12:52 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 751K Feb 15 12:57 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 13:17 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 752K Feb 15 13:20 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 16:38 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 750K Feb 15 16:41 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 15:05 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 746K Feb 15 15:13 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 14:17 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 744K Feb 15 14:22 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 17:40 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 742K Feb 15 17:53 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  12M Feb 15 15:36 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 742K Feb 15 15:40 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  13M Feb 15 16:02 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 15 16:13 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 15 15:04 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 725K Feb 15 15:09 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
drwxr-sr-x  3 kalavatt   33 Feb 15 18:18 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01/
-rw-r--r--  1 kalavatt 9.2M Feb 15 18:02 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 724K Feb 15 18:18 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.8M Feb 15 15:45 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 740K Feb 15 15:48 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 17:55 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 746K Feb 15 18:11 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 15 17:25 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 735K Feb 15 17:39 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.8M Feb 15 19:01 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 735K Feb 15 19:09 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 15 18:20 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 740K Feb 15 18:40 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 19:17 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 15 19:43 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 20:55 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 15 20:59 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 21:08 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 15 21:11 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 22:38 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 15 22:43 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 22:17 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 15 22:23 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 15 20:23 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 724K Feb 15 20:28 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 15 23:15 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 726K Feb 15 23:18 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.8M Feb 16 01:11 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 739K Feb 16 01:17 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 15 22:40 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 746K Feb 15 22:46 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 17 00:30 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 736K Feb 17 00:33 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 15 21:50 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 736K Feb 15 21:55 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 15 23:36 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 15 23:38 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 00:15 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 16 00:19 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 02:12 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 742K Feb 16 02:16 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 02:33 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 16 02:37 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 01:46 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 743K Feb 16 01:49 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 01:04 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 16 01:09 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 16 01:09 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 725K Feb 16 01:12 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 16 04:13 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 724K Feb 16 04:16 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.8M Feb 16 01:52 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 16 01:54 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 02:36 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 746K Feb 16 02:39 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 16 02:18 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 735K Feb 16 02:21 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.8M Feb 16 04:12 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 736K Feb 16 04:15 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 16 05:40 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 16 05:43 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 04:20 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 16 04:23 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 05:36 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 16 05:40 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 07:33 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 742K Feb 16 07:37 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 04:58 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 744K Feb 16 05:02 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 06:27 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 16 06:37 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 16 06:22 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 726K Feb 16 06:30 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 16 05:22 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 726K Feb 16 05:25 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.8M Feb 16 05:39 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 740K Feb 16 05:41 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 12:17 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 745K Feb 16 12:30 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 16 09:14 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 736K Feb 16 09:16 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 16 08:58 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 735K Feb 16 09:01 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 17 00:35 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 740K Feb 17 00:37 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 11:48 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 748K Feb 16 11:57 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 13:58 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 16 14:02 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 09:50 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 741K Feb 16 09:53 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 09:05 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 744K Feb 16 09:09 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 16 11:11 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 747K Feb 16 11:16 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 987K Feb 18 20:24 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 18 20:25 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 987K Feb 18 21:15 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 18 21:16 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 18 22:20 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 138K Feb 18 22:21 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 18 21:24 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 148K Feb 18 21:25 trinity-gf_mkc-32_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 00:04 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 00:05 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 00:19 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 00:20 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 18 23:25 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 18 23:26 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 18 23:15 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 18 23:16 trinity-gf_mkc-32_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 18 23:38 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 18 23:39 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 01:42 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 01:43 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 03:24 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 142K Feb 19 03:25 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 00:22 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 00:23 trinity-gf_mkc-32_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 980K Feb 19 03:03 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 19 03:04 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 982K Feb 19 00:58 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 19 00:59 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 02:09 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 02:10 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 02:04 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 02:05 trinity-gf_mkc-32_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 02:22 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 02:23 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 02:58 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 02:59 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 05:10 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 05:11 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 07:41 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 148K Feb 19 07:43 trinity-gf_mkc-32_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 04:53 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 138K Feb 19 04:54 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 05:18 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 138K Feb 19 05:19 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 08:15 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 141K Feb 19 08:18 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 06:19 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 06:20 trinity-gf_mkc-32_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 985K Feb 19 05:26 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 19 05:27 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 988K Feb 19 05:52 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 19 05:53 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 05:16 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 05:17 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 09:07 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 09:08 trinity-gf_mkc-32_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 05:40 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 05:41 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 09:29 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 09:29 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 09:28 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 09:28 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 10:09 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 148K Feb 19 10:11 trinity-gf_mkc-32_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 08:15 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 138K Feb 19 08:16 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 08:18 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 138K Feb 19 08:19 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 12:00 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 142K Feb 19 12:01 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 12:18 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 12:20 trinity-gf_mkc-32_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 990K Feb 19 09:26 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 121K Feb 19 09:26 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 986K Feb 19 10:18 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 120K Feb 19 10:19 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 12:28 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 12:29 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 11:05 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 11:06 trinity-gf_mkc-32_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 12:44 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 12:45 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.1M Feb 19 12:55 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 130K Feb 19 12:56 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 14:07 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 14:08 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 12:07 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 12:08 trinity-gf_mkc-32_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 13:01 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 138K Feb 19 13:02 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 16:00 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 139K Feb 19 16:01 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.2M Feb 19 15:18 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 141K Feb 19 15:19 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 1.3M Feb 19 16:24 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 147K Feb 19 16:25 trinity-gf_mkc-32_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 16 10:21 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 604K Feb 16 10:23 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 16 12:12 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 605K Feb 16 12:21 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 16 13:16 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 641K Feb 16 13:21 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.3M Feb 16 13:27 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 678K Feb 16 13:30 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 16 12:00 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 635K Feb 16 12:11 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 16 14:23 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 636K Feb 16 14:25 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 16 16:03 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 652K Feb 16 16:05 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.4M Feb 16 14:45 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 680K Feb 16 14:50 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 16 15:25 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 664K Feb 16 15:28 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 16 15:44 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 663K Feb 16 15:46 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.2M Feb 16 15:43 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 668K Feb 16 15:45 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 16 19:17 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 688K Feb 16 19:21 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 16 15:52 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 603K Feb 16 15:54 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.0M Feb 16 16:04 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 607K Feb 16 16:07 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 16 20:22 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 642K Feb 16 20:25 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.3M Feb 16 20:12 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 677K Feb 16 20:15 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
drwxr-sr-x  4 kalavatt   72 Feb 16 14:50 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005/
-rw-r--r--  1 kalavatt 7.5M Feb 16 18:25 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 633K Feb 16 18:27 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
drwxr-sr-x  4 kalavatt   72 Feb 16 15:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05/
-rw-r--r--  1 kalavatt 8.4M Feb 16 22:14 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 680K Feb 16 22:17 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 17 00:03 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 664K Feb 17 00:06 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 16 21:43 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 664K Feb 16 21:45 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.2M Feb 16 19:21 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 668K Feb 16 19:24 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.6M Feb 16 21:10 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 688K Feb 16 21:13 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 16 22:38 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 604K Feb 16 22:40 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 16 22:00 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 604K Feb 16 22:02 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 17 03:07 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 641K Feb 17 03:14 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.3M Feb 17 01:26 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 678K Feb 17 01:29 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 16 23:10 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 634K Feb 16 23:12 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 17 01:16 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 635K Feb 17 01:18 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 17 01:08 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 654K Feb 17 01:12 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.4M Feb 17 02:53 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 680K Feb 17 02:55 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 17 00:39 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 664K Feb 17 00:41 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 17 01:10 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 664K Feb 17 01:14 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.2M Feb 17 05:30 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 669K Feb 17 05:31 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 17 02:10 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 687K Feb 17 02:13 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 17 02:42 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 603K Feb 17 02:44 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 17 03:32 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 603K Feb 17 03:34 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 17 03:14 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 639K Feb 17 03:16 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.3M Feb 17 03:37 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 678K Feb 17 03:39 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 17 04:17 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 636K Feb 17 04:18 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 17 03:46 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 635K Feb 17 03:48 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 17 06:31 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 652K Feb 17 06:32 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.4M Feb 17 04:36 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 680K Feb 17 04:39 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 17 06:26 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 663K Feb 17 06:28 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.1M Feb 17 11:46 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 664K Feb 17 11:49 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.2M Feb 17 08:15 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 669K Feb 17 08:17 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 17 06:23 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 687K Feb 17 06:24 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 4.9M Feb 17 07:51 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 464K Feb 17 07:52 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.0M Feb 17 05:53 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 465K Feb 17 05:54 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.5M Feb 17 06:33 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 507K Feb 17 06:35 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.2M Feb 17 08:02 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 549K Feb 17 08:04 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 06:56 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 497K Feb 17 06:58 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 07:03 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 495K Feb 17 07:04 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.7M Feb 17 08:06 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 518K Feb 17 08:08 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.3M Feb 17 09:41 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 555K Feb 17 09:42 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 17 12:27 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 536K Feb 17 12:30 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 17 13:49 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 536K Feb 17 13:56 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.1M Feb 17 12:17 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 541K Feb 17 12:20 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.5M Feb 17 11:21 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 566K Feb 17 11:23 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 4.9M Feb 17 11:26 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 464K Feb 17 11:28 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 4.9M Feb 17 09:17 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 463K Feb 17 09:19 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.5M Feb 17 10:09 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 507K Feb 17 10:11 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.2M Feb 17 10:25 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 548K Feb 17 10:26 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 11:06 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 496K Feb 17 11:13 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 10:43 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 497K Feb 17 10:44 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.7M Feb 17 11:58 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 518K Feb 17 12:01 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.3M Feb 17 17:30 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 554K Feb 17 17:32 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 17 23:50 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 535K Feb 17 23:52 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 17 14:36 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 537K Feb 17 14:39 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.1M Feb 17 19:04 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 542K Feb 17 19:08 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.4M Feb 17 20:29 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 564K Feb 17 20:35 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.0M Feb 17 16:03 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 466K Feb 17 16:05 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 4.9M Feb 17 14:26 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 464K Feb 17 14:28 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.5M Feb 17 23:15 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 504K Feb 17 23:17 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.2M Feb 17 15:41 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 549K Feb 17 15:43 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 17:21 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 496K Feb 17 17:23 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 15:56 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 495K Feb 17 15:59 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.7M Feb 17 22:46 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 517K Feb 17 22:49 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.3M Feb 17 17:38 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 554K Feb 17 17:38 trinity-gf_mkc-8_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 17 19:28 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 536K Feb 17 19:29 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 17 19:18 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 536K Feb 17 19:19 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.1M Feb 17 19:32 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 541K Feb 17 19:33 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.5M Feb 17 19:14 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 566K Feb 17 19:15 trinity-gf_mkc-8_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.0M Feb 17 22:27 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 465K Feb 17 22:27 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 4.9M Feb 18 00:56 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 465K Feb 18 00:59 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.5M Feb 17 23:35 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 505K Feb 17 23:36 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.2M Feb 18 02:04 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 548K Feb 18 02:06 trinity-gf_mkc-8_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 18 00:04 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 496K Feb 18 00:05 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 17 22:52 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 495K Feb 17 22:53 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.7M Feb 17 23:59 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 517K Feb 18 00:00 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.3M Feb 18 00:03 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 554K Feb 18 00:04 trinity-gf_mkc-8_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 18 02:35 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 536K Feb 18 02:36 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 18 05:03 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 537K Feb 18 05:04 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.1M Feb 18 04:12 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 542K Feb 18 04:13 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.5M Feb 18 02:45 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 566K Feb 18 02:45 trinity-gf_mkc-8_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
```
</details>
<br />

<a id="trinity-gfg_n-3"></a>
##### Trinity-GF/G_N/
<details>
<summary><i>Printed: Trinity-GF/G_N/</i></summary>

```txt
❯ .,
total 1.6G
drwxrws--- 15 kalavatt  25K Feb 24 12:21 ./
drwxrws---  4 kalavatt   42 Feb 14 11:51 ../
drwxrws---  2 kalavatt 8.7K Feb 17 11:32 lists/
-rw-r--r--  1 kalavatt 9.6M Feb 17 20:17 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 625K Feb 17 20:18 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.6M Feb 17 14:54 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 626K Feb 17 14:56 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 17 16:16 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 17 16:18 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 14:48 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 609K Feb 17 14:50 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.9M Feb 17 21:09 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 17 21:11 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.9M Feb 17 17:31 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 17 17:32 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 17:20 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 17 17:21 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 18:02 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 608K Feb 17 18:03 trinity-gf_mkc-1_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 18:00 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 17 18:02 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 17:51 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 611K Feb 17 17:52 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 18:02 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 17 18:03 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 17:02 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 606K Feb 17 17:03 trinity-gf_mkc-1_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.6M Feb 18 01:31 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 625K Feb 18 01:53 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 17 18:59 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 626K Feb 17 19:00 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 17 20:31 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 17 20:32 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 22:31 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 609K Feb 17 22:32 trinity-gf_mkc-1_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 17 23:21 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 17 23:24 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.9M Feb 17 20:45 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 617K Feb 17 20:45 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 23:10 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 17 23:11 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 23:09 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 608K Feb 17 23:10 trinity-gf_mkc-1_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 22:41 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 609K Feb 17 22:42 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 21:42 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 611K Feb 17 21:43 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 17 22:05 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 17 22:06 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 04:26 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 606K Feb 18 04:28 trinity-gf_mkc-1_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.7M Feb 18 00:41 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 626K Feb 18 00:42 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.6M Feb 18 01:09 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 626K Feb 18 01:10 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 18 03:11 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 617K Feb 18 03:13 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 03:37 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 609K Feb 18 03:38 trinity-gf_mkc-1_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.9M Feb 18 03:13 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 617K Feb 18 03:14 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.9M Feb 18 01:54 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 18 01:55 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 02:18 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 18 02:19 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 02:32 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 608K Feb 18 02:33 trinity-gf_mkc-1_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 04:09 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 18 04:10 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 06:44 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 18 06:44 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 05:21 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 18 05:22 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 04:24 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 606K Feb 18 04:25 trinity-gf_mkc-1_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.6M Feb 18 13:39 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 625K Feb 18 13:40 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.6M Feb 18 06:53 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 626K Feb 18 06:53 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 18 07:02 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 18 07:03 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 06:16 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 609K Feb 18 06:17 trinity-gf_mkc-1_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  10M Feb 18 07:55 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 619K Feb 18 07:56 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.9M Feb 18 06:22 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 18 06:22 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 09:41 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 18 09:43 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 09:35 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 608K Feb 18 09:36 trinity-gf_mkc-1_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 07:25 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 18 07:26 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 10:43 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 610K Feb 18 10:43 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 12:03 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 609K Feb 18 12:04 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt  11M Feb 18 11:10 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 606K Feb 18 11:11 trinity-gf_mkc-1_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 18 11:15 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 11:16 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 18 09:39 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 09:39 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.9M Feb 18 12:44 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 18 12:45 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 18 11:03 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 11:04 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 18 11:38 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 11:38 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 18 13:33 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 13:36 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 13:43 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 13:43 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 18 13:54 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 18 13:55 trinity-gf_mkc-2_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 15:22 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 18 15:22 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 14:50 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 14:51 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.1M Feb 18 16:29 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 16:30 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 18 15:50 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 15:51 trinity-gf_mkc-2_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 18 16:33 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 627K Feb 18 16:34 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 18 16:29 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 627K Feb 18 16:30 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.9M Feb 18 16:33 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 632K Feb 18 16:34 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 18 16:37 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 16:38 trinity-gf_mkc-2_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 18 17:41 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 18 17:43 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 18 18:23 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 18:25 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 18:41 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 18 18:42 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 18 18:36 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 18 18:39 trinity-gf_mkc-2_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 18:07 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 18:07 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 19:09 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 19:10 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.1M Feb 18 20:10 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 20:12 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 18 22:52 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 22:53 trinity-gf_mkc-2_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 18 21:46 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 21:47 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 18 23:28 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 23:29 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.9M Feb 18 22:15 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 18 22:16 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 18 23:22 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 18 23:23 trinity-gf_mkc-2_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 19 00:22 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 19 00:23 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 18 21:40 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 18 21:41 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 19 01:24 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 19 01:25 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 19 01:20 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 01:21 trinity-gf_mkc-2_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 19 00:10 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 00:11 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 18 22:07 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 18 22:08 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.1M Feb 19 01:36 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 19 01:37 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 19 02:01 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 19 02:02 trinity-gf_mkc-2_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 19 02:12 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 627K Feb 19 02:13 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.5M Feb 19 01:43 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 628K Feb 19 01:43 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.9M Feb 19 03:18 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 632K Feb 19 03:19 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 19 02:44 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 02:45 trinity-gf_mkc-2_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 19 05:30 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 05:31 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 8.8M Feb 19 05:26 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 05:29 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 19 03:54 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 631K Feb 19 03:55 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.2M Feb 19 04:55 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 04:57 trinity-gf_mkc-2_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 19 07:53 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 19 07:55 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.0M Feb 19 05:18 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 629K Feb 19 05:19 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.1M Feb 19 07:35 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 19 07:37 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 9.3M Feb 19 06:05 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 630K Feb 19 06:06 trinity-gf_mkc-2_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 05:08 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 575K Feb 19 05:09 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 08:31 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 573K Feb 19 08:33 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.4M Feb 19 07:10 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 598K Feb 19 07:11 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 19 07:33 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 613K Feb 19 07:34 trinity-gf_mkc-4_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 08:48 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 590K Feb 19 08:49 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 09:20 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 591K Feb 19 09:21 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 19 08:18 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 601K Feb 19 08:19 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 19 10:32 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 19 10:33 trinity-gf_mkc-4_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 19 12:18 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 603K Feb 19 12:21 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 19 09:44 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 602K Feb 19 09:46 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.7M Feb 19 10:17 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 605K Feb 19 10:19 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 19 10:47 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 19 10:48 trinity-gf_mkc-4_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 11:09 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 576K Feb 19 11:10 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 12:07 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 574K Feb 19 12:09 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.4M Feb 19 14:01 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 598K Feb 19 14:01 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 19 11:55 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 615K Feb 19 11:56 trinity-gf_mkc-4_mir-0.01_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 13:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 590K Feb 19 13:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 14:05 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 591K Feb 19 14:06 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 19 14:27 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 601K Feb 19 14:28 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 19 13:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 19 13:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 19 15:15 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 603K Feb 19 15:16 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 19 15:17 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 602K Feb 19 15:18 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.7M Feb 19 14:03 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 607K Feb 19 14:04 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 19 14:31 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 19 14:32 trinity-gf_mkc-4_mir-0.01_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 14:18 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 574K Feb 19 14:18 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 16:14 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 574K Feb 19 16:15 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.4M Feb 19 16:01 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 598K Feb 19 16:02 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 19 18:26 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 615K Feb 19 18:27 trinity-gf_mkc-4_mir-0.05_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 19:03 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 592K Feb 19 19:03 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.2M Feb 19 18:58 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 590K Feb 19 18:58 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 19 16:50 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 600K Feb 19 16:51 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 19 19:36 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 616K Feb 19 19:36 trinity-gf_mkc-4_mir-0.05_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 19 17:08 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 602K Feb 19 17:08 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 19 19:46 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 602K Feb 19 19:46 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.7M Feb 19 17:40 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 605K Feb 19 17:41 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 19 19:57 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 618K Feb 19 19:57 trinity-gf_mkc-4_mir-0.05_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 19:26 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 573K Feb 19 19:27 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.9M Feb 19 21:06 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 573K Feb 19 21:06 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.4M Feb 19 20:55 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 598K Feb 19 20:55 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.8M Feb 19 20:55 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 614K Feb 19 20:55 trinity-gf_mkc-4_mir-0.1_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 20:39 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 590K Feb 19 20:40 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.3M Feb 19 22:55 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 591K Feb 19 22:55 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.5M Feb 19 20:57 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 601K Feb 19 20:58 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 22 13:47 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 617K Feb 22 13:47 trinity-gf_mkc-4_mir-0.1_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.6M Feb 22 16:25 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 602K Feb 22 16:26 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
drwxr-sr-x  5 kalavatt 1.1K Feb 22 18:30 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.01/
-rw-r--r--  1 kalavatt 7.7M Feb 24 04:33 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 605K Feb 24 04:34 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 7.9M Feb 24 07:02 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 617K Feb 24 07:03 trinity-gf_mkc-4_mir-0.1_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.0M Feb 24 05:32 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 454K Feb 24 05:33 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.0M Feb 24 05:46 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 454K Feb 24 05:46 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.6M Feb 24 09:03 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 495K Feb 24 09:03 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 24 06:14 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 519K Feb 24 06:15 trinity-gf_mkc-8_mir-0.005_mg-1_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 24 09:29 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 480K Feb 24 09:30 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.4M Feb 24 09:21 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 480K Feb 24 09:21 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.7M Feb 24 10:35 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 499K Feb 24 10:36 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.0M Feb 24 11:11 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 520K Feb 24 11:12 trinity-gf_mkc-8_mir-0.005_mg-2_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.8M Feb 24 07:31 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 501K Feb 24 07:31 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.8M Feb 24 09:20 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity.fasta
-rw-r--r--  1 kalavatt 503K Feb 24 09:20 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.01.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.9M Feb 24 10:44 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 511K Feb 24 10:44 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.05.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 6.1M Feb 24 08:45 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity.fasta
-rw-r--r--  1 kalavatt 527K Feb 24 08:45 trinity-gf_mkc-8_mir-0.005_mg-4_gf-0.1.Trinity.fasta.gene_trans_map
-rw-r--r--  1 kalavatt 5.0M Feb 24 12:20 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 454K Feb 24 12:20 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.005.Trinity.fasta.gene_trans_map
drwxr-sr-x  5 kalavatt 1.1K Feb 24 11:48 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.01/
-rw-r--r--  1 kalavatt 5.6M Feb 24 09:49 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity.fasta
-rw-r--r--  1 kalavatt 494K Feb 24 09:49 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.05.Trinity.fasta.gene_trans_map
drwxr-sr-x  5 kalavatt 1.1K Feb 24 12:19 trinity-gf_mkc-8_mir-0.01_mg-1_gf-0.1/
-rw-r--r--  1 kalavatt 5.4M Feb 24 11:45 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 480K Feb 24 11:46 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.005.Trinity.fasta.gene_trans_map
drwxr-sr-x  4 kalavatt  820 Feb 24 12:30 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.01/
drwxr-sr-x  5 kalavatt 1.1K Feb 24 11:32 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.05/
drwxr-sr-x  4 kalavatt   72 Feb 24 09:30 trinity-gf_mkc-8_mir-0.01_mg-2_gf-0.1/
-rw-r--r--  1 kalavatt 5.8M Feb 24 12:19 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity.fasta
-rw-r--r--  1 kalavatt 501K Feb 24 12:20 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.005.Trinity.fasta.gene_trans_map
drwxr-sr-x  4 kalavatt   72 Feb 24 10:36 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.01/
drwxr-sr-x  5 kalavatt 1.1K Feb 24 12:30 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.05/
drwxr-sr-x  4 kalavatt   72 Feb 24 11:12 trinity-gf_mkc-8_mir-0.01_mg-4_gf-0.1/
drwxr-sr-x  4 kalavatt   72 Feb 24 11:46 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.005/
drwxr-sr-x  4 kalavatt   72 Feb 24 12:20 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.01/
drwxr-sr-x  4 kalavatt   72 Feb 24 12:21 trinity-gf_mkc-8_mir-0.05_mg-1_gf-0.05/
```
</details>
<br />
<br />

<a id="summary"></a>
## Summary
<a id="trinity-gg-q_n"></a>
### Trinity GG Q_N
Need to run/rerun the following:
1. `trinity-gg_mkc-4_mir-0.005_mg-4_gf-0.01`
2. `trinity-gg_mkc-8_mir-0.1_mg-4_gf-0.05`
3. `trinity-gg_mkc-16_mir-0.01_mg-1_gf-0.05`
<br />

<a id="trinity-gg-g_n"></a>
### Trinity GG G_N
Looks like everything completed successfully
<br />

<a id="trinity-gf-q_n"></a>
### Trinity GF Q_N
Need to run/rerun  
1. `trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005.10396158-113`
2. `trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05.10396158-115`

Interestingly, more than two directories remain in corresponding directory for outfiles:
```txt
drwxr-sr-x  8 kalavatt 1.2K Feb 14 21:02 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005/
-rw-r--r--  1 kalavatt  12M Feb 14 21:02 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005.Trinity.fasta
drwxr-sr-x  8 kalavatt 1.2K Feb 14 19:45 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01/
-rw-r--r--  1 kalavatt  12M Feb 14 19:45 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01.Trinity.fasta
drwxr-sr-x  8 kalavatt 1.2K Feb 15 10:58 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05/
-rw-r--r--  1 kalavatt  12M Feb 15 10:58 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05.Trinity.fasta
drwxr-sr-x  8 kalavatt 1.2K Feb 15 11:09 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1/
-rw-r--r--  1 kalavatt  12M Feb 15 11:09 trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1.Trinity.fasta
drwxr-sr-x  3 kalavatt   33 Feb 15 18:18 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01/
-rw-r--r--  1 kalavatt 9.2M Feb 15 18:02 trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01.Trinity.fasta
drwxr-sr-x  4 kalavatt   72 Feb 16 14:50 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005/
-rw-r--r--  1 kalavatt 7.5M Feb 16 18:25 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.01.Trinity.fasta
drwxr-sr-x  4 kalavatt   72 Feb 16 15:46 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05/
-rw-r--r--  1 kalavatt 8.4M Feb 16 22:14 trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.1.Trinity.fasta
```

The following seem to have completed successfully despite the presence of the corresponding outdirectories:
1. `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005`
2. `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01`
3. `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05`
4. `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1`
5. `trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01`

The following seem to have note completed successfully
<br />

<a id="trinity-gf-g_n"></a>
### Trinity GF G_N
The jobs for Trinity-GF/G_N/ are still running at the time of checking...

Anything to retry, etc.?  
- Job #142 (`10886118_142`) hasn't progressed since sometime on 2024-0222&mdash;it may be a good idea to kill it, delete what has been output so far, then restart from scratch; indeed the `FailedCommands` file within the directory is full of failed calls to `Trinity` (`#DONE` *See below*)
<br />
<br />

<a id="next-steps"></a>
## Next steps
<a id="general"></a>
### General
- Keep an eye on ongoing jobs to ensure there are no more hang-ups (`10886118_*` series for Trinity GF G_N)

<a id="trinity-gg-q_n-1"></a>
### Trinity GG Q_N
- For <b>Trinity GG Q_N</b>, rerun the three necessary samples 
	+ Find their associated files in directory `lists/` (`outfiles_Trinity-GG/Q_N/lists`), which are...
		* `106`
		* `191`
		* `207`
	+ Prior to doing that, check the contents of the associated out files

<a id="trinity-gg-g_n-1"></a>
### Trinity GG G_N
- Double check that all of the <b>Trinity GG G_N</b> STDOUT files and outfiles are good

<a id="trinity-gf-q_n-1"></a>
### Trinity GF Q_N
- For <b>Trinity GF Q_N</b>,
	+ Check on the following directories; delete them if appropriate (`#DONE` *See below*)
		* `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005/`
		* `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01/`
		* `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05/`
		* `trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1/`
		* `trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01/`
	+ Check on the following directories: restart or start anew as necessary
		* `trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005/`
		* `trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05/`

```bash
#!/bin/bash

#  ------------------------------------
., trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005/  # Completed successfully but cleanup did not take place
., trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01/  # Completed successfully but cleanup did not take place
., trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05/  # Completed successfully but cleanup did not take place
., trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1/  # Completed successfully but cleanup did not take place
., trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01/  # Completed successfully but one specific file was rm'd during cleanup

rmr trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.005/
rmr trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.01/
rmr trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.05/
rmr trinity-gf_mkc-1_mir-0.005_mg-1_gf-0.1/
rmr trinity-gf_mkc-2_mir-0.005_mg-1_gf-0.01/


#  ------------------------------------
., trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.005/  # Wipe and rerun from scratch
., trinity-gf_mkc-4_mir-0.01_mg-2_gf-0.05/  # Wipe and rerun from scratch
```

<a id="trinity-gf-g_n-1"></a>
### Trinity GF G_N
- For <b>Trinity GF G_N</b>...
	+ `scancel 10886118_142` `#DONE`

`#TODO` Assessment to be continued
