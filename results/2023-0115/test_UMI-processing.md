
`#test_UMI-processing.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
1. [Experiment description](#experiment-description)
1. [Install `fgbio`](#install-fgbio)
1. [Try a trial run with `AnnotateBamWithUmis`](#try-a-trial-run-with-annotatebamwithumis)
	1. [Make a directory for the trial with `AnnotateBamWithUmis`](#make-a-directory-for-the-trial-with-annotatebamwithumis)
	1. [Locations of datasets](#locations-of-datasets)
	1. [Set up necessary variables](#set-up-necessary-variables)
	1. [Run the command](#run-the-command)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="get-situated"></a>
## Get situated
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core, 100 GB memory, then default settings

transcriptome && cd results/2023-0115

source activate Trinity_env
```

<detials>
<summary><i>Printed: Get situated</i></summary>

```txt
❯ grabnode
How many CPUs/cores would you like to grab on the node? [1-36] 1
How much memory (GB) would you like to grab? [20]
Please enter the max number of days you would like to grab this node: [1-7]
Do you need a GPU ? [y/N]

You have requested 1 CPUs on this node/server for 1 days or until you type exit.

Warning: If you exit this shell before your jobs are finished, your jobs
on this node/server will be terminated. Please use sbatch for larger jobs.

Shared PI folders can be found in: /fh/fast, /fh/scratch and /fh/secure.

Requesting Queue: campus-new cores: 1 memory: 20 gpu: NONE
srun: job 8061283 queued and waiting for resources
srun: job 8061283 has been allocated resources


❯ transcriptome && cd results/2023-0115
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115


❯ source activate Trinity_env
```
</detials>
<br />
<br />

<a id="experiment-description"></a>
## Experiment description
Follow approach to add UMI sequences to `fastq` read names described [here](https://www.biostars.org/p/357359/#358546): Working directly with already-aligned data  
[`AnnotateBamWithUmis` documentation](https://fulcrumgenomics.github.io/fgbio/tools/latest/AnnotateBamWithUmis.html)
<br />
<br />

<a id="install-fgbio"></a>
## Install `fgbio`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mamba install -c bioconda fgbio
```

<details>
<summary><i>Printed: Install fgbio</i></summary>

```txt
                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (0.15.3) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['fgbio']

pkgs/r/linux-64          [====================] (00m:00s) No change
pkgs/main/noarch         [====================] (00m:00s) No change
pkgs/r/noarch            [====================] (00m:00s) No change
bioconda/noarch          [====================] (00m:00s) Done
pkgs/main/linux-64       [====================] (00m:01s) Done
bioconda/linux-64        [====================] (00m:01s) Done

Pinned packages:
  - python 3.9.*


Transaction

  Prefix: /home/kalavatt/miniconda3

  Updating specs:

   - fgbio
   - ca-certificates
   - certifi
   - openssl


  Package                                   Version  Build           Channel                  Size
────────────────────────────────────────────────────────────────────────────────────────────────────
  Install:
────────────────────────────────────────────────────────────────────────────────────────────────────

  + _r-mutex                                  1.0.0  anacondar_1     pkgs/main/linux-64     Cached
  + _sysroot_linux-64_curr_repodata_hack          3  haa98f57_10     pkgs/main/noarch       Cached
  + binutils_impl_linux-64                     2.38  h2a08ee3_1      pkgs/main/linux-64     Cached
  + binutils_linux-64                        2.38.0  hc2dff05_0      pkgs/main/linux-64     Cached
  + blas                                        1.0  openblas        pkgs/main/linux-64      46 KB
  + bwidget                                  1.9.11  1               pkgs/main/linux-64     Cached
  + cairo                                    1.16.0  h19f5f5c_2      pkgs/main/linux-64     Cached
  + curl                                     7.82.0  h7f8727e_0      pkgs/main/linux-64      95 KB
  + dbus                                    1.13.18  hb2f20db_0      pkgs/main/linux-64     Cached
  + expat                                     2.4.9  h6a678d5_0      pkgs/main/linux-64     Cached
  + fgbio                                     2.1.0  hdfd78af_0      bioconda/noarch         37 MB
  + fontconfig                               2.13.1  h6c09931_0      pkgs/main/linux-64     Cached
  + freetype                                 2.12.1  h4a9f257_0      pkgs/main/linux-64     Cached
  + fribidi                                  1.0.10  h7b6447c_0      pkgs/main/linux-64     Cached
  + gcc_impl_linux-64                        11.2.0  h1234567_1      pkgs/main/linux-64     Cached
  + gcc_linux-64                             11.2.0  h5c386dc_0      pkgs/main/linux-64     Cached
  + gfortran_impl_linux-64                   11.2.0  h1234567_1      pkgs/main/linux-64      10 MB
  + gfortran_linux-64                        11.2.0  hc2dff05_0      pkgs/main/linux-64     Cached
  + glib                                     2.69.1  h4ff587b_1      pkgs/main/linux-64     Cached
  + graphite2                                1.3.14  h295c915_1      pkgs/main/linux-64     Cached
  + gxx_impl_linux-64                        11.2.0  h1234567_1      pkgs/main/linux-64     Cached
  + gxx_linux-64                             11.2.0  hc2dff05_0      pkgs/main/linux-64     Cached
  + harfbuzz                                  4.3.0  hd55b92a_0      pkgs/main/linux-64     Cached
  + jpeg                                         9e  h7f8727e_0      pkgs/main/linux-64     Cached
  + kernel-headers_linux-64                  3.10.0  h57e8cba_10     pkgs/main/noarch       Cached
  + lerc                                        3.0  h295c915_0      pkgs/main/linux-64     Cached
  + libdeflate                                  1.8  h7f8727e_5      pkgs/main/linux-64     Cached
  + libgcc-devel_linux-64                    11.2.0  h1234567_1      pkgs/main/linux-64     Cached
  + libgfortran-ng                           11.2.0  h00389a5_1      pkgs/main/linux-64     Cached
  + libgfortran5                             11.2.0  h1234567_1      pkgs/main/linux-64     Cached
  + libopenblas                              0.3.21  h043d6bf_0      pkgs/main/linux-64       5 MB
  + libstdcxx-devel_linux-64                 11.2.0  h1234567_1      pkgs/main/linux-64     Cached
  + libtiff                                   4.4.0  hecacb30_0      pkgs/main/linux-64     Cached
  + libwebp-base                              1.2.4  h5eee18b_0      pkgs/main/linux-64     Cached
  + libxcb                                     1.15  h7f8727e_0      pkgs/main/linux-64     Cached
  + make                                      4.2.1  h1bed415_1      pkgs/main/linux-64     Cached
  + openjdk                                 11.0.13  h87a67e3_0      pkgs/main/linux-64     Cached
  + pango                                    1.50.7  h05da053_0      pkgs/main/linux-64     Cached
  + pcre                                       8.45  h295c915_0      pkgs/main/linux-64     Cached
  + pcre2                                     10.37  he7ceb23_1      pkgs/main/linux-64     839 KB
  + pixman                                   0.40.0  h7f8727e_1      pkgs/main/linux-64     Cached
  + r-base                                    4.2.0  h1ae530e_0      pkgs/r/linux-64        Cached
  + r-cli                                     3.3.0  r42h884c59f_0   pkgs/r/linux-64        Cached
  + r-colorspace                              2.0_3  r42h76d94ec_0   pkgs/r/linux-64          2 MB
  + r-crayon                                  1.5.1  r42h6115d3f_0   pkgs/r/noarch          158 KB
  + r-digest                                 0.6.29  r42h884c59f_0   pkgs/r/linux-64        Cached
  + r-ellipsis                                0.3.2  r42h76d94ec_0   pkgs/r/linux-64         40 KB
  + r-fansi                                   1.0.3  r42h76d94ec_0   pkgs/r/linux-64        315 KB
  + r-farver                                  2.1.0  r42h884c59f_0   pkgs/r/linux-64        Cached
  + r-ggplot2                                 3.3.6  r42h6115d3f_0   pkgs/r/noarch            4 MB
  + r-glue                                    1.6.2  r42h76d94ec_0   pkgs/r/linux-64        147 KB
  + r-gtable                                  0.3.0  r42h6115d3f_0   pkgs/r/noarch          391 KB
  + r-isoband                                 0.2.5  r42h884c59f_0   pkgs/r/linux-64        Cached
  + r-labeling                                0.4.2  r42h6115d3f_0   pkgs/r/noarch           65 KB
  + r-lattice                               0.20_45  r42h76d94ec_0   pkgs/r/linux-64          1 MB
  + r-lifecycle                               1.0.1  r42h142f84f_0   pkgs/r/noarch          Cached
  + r-magrittr                                2.0.3  r42h76d94ec_0   pkgs/r/linux-64        203 KB
  + r-mass                                   7.3_57  r42h76d94ec_0   pkgs/r/linux-64          1 MB
  + r-matrix                                  1.4_1  r42h76d94ec_0   pkgs/r/linux-64          4 MB
  + r-mgcv                                   1.8_40  r42h76d94ec_0   pkgs/r/linux-64          3 MB
  + r-munsell                                 0.5.0  r42h6115d3f_0   pkgs/r/noarch          238 KB
  + r-nlme                                  3.1_157  r42h640688f_0   pkgs/r/linux-64          2 MB
  + r-pillar                                  1.7.0  r42h6115d3f_0   pkgs/r/noarch          662 KB
  + r-pkgconfig                               2.0.3  r42h6115d3f_0   pkgs/r/noarch           23 KB
  + r-r6                                      2.5.1  r42h6115d3f_0   pkgs/r/noarch           86 KB
  + r-rcolorbrewer                            1.1_3  r42h6115d3f_0   pkgs/r/noarch           57 KB
  + r-rlang                                   1.0.2  r42h884c59f_0   pkgs/r/linux-64        Cached
  + r-scales                                  1.2.0  r42h6115d3f_0   pkgs/r/noarch          583 KB
  + r-tibble                                  3.1.7  r42h76d94ec_0   pkgs/r/linux-64        635 KB
  + r-utf8                                    1.2.2  r42h76d94ec_0   pkgs/r/linux-64        140 KB
  + r-vctrs                                   0.4.1  r42h884c59f_0   pkgs/r/linux-64        Cached
  + r-viridislite                             0.4.0  r42h6115d3f_0   pkgs/r/noarch            1 MB
  + r-withr                                   2.5.0  r42h6115d3f_0   pkgs/r/noarch          226 KB
  + sysroot_linux-64                           2.17  h57e8cba_10     pkgs/main/noarch       Cached
  + tktable                                    2.10  h14c3975_0      pkgs/main/linux-64     Cached

  Change:
────────────────────────────────────────────────────────────────────────────────────────────────────

  - ucsc-gtftogenepred                          357  1               installed
  + ucsc-gtftogenepred                          357  0               bioconda/linux-64        2 MB

  Upgrade:
────────────────────────────────────────────────────────────────────────────────────────────────────

  - certifi                               2022.9.24  py39h06a4308_0  installed
  + certifi                               2022.12.7  py39h06a4308_0  pkgs/main/linux-64     150 KB
  - ld_impl_linux-64                         2.35.1  h7274673_9      installed
  + ld_impl_linux-64                           2.38  h1181459_1      pkgs/main/linux-64     Cached
  - openssl                                  1.1.1q  h7f8727e_0      installed
  + openssl                                  1.1.1s  h7f8727e_0      pkgs/main/linux-64     Cached
  - zlib                                     1.2.11  h7f8727e_4      installed
  + zlib                                     1.2.13  h5eee18b_0      pkgs/main/linux-64     Cached
  - zstd                                      1.5.0  ha4553b6_1      installed
  + zstd                                      1.5.2  ha4553b6_0      pkgs/main/linux-64     Cached

  Summary:

  Install: 75 packages
  Change: 1 packages
  Upgrade: 5 packages

  Total download: 79 MB

────────────────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
Finished blas                                 (00m:00s)              46 KB    647 KB/s
Finished curl                                 (00m:00s)              95 KB      1 MB/s
Finished certifi                              (00m:00s)             150 KB      2 MB/s
Finished r-magrittr                           (00m:00s)             203 KB      2 MB/s
Finished r-ellipsis                           (00m:00s)              40 KB    403 KB/s
Finished pcre2                                (00m:00s)             839 KB      8 MB/s
Finished r-glue                               (00m:00s)             147 KB    873 KB/s
Finished r-pkgconfig                          (00m:00s)              23 KB    133 KB/s
Finished r-rcolorbrewer                       (00m:00s)              57 KB    320 KB/s
Finished r-munsell                            (00m:00s)             238 KB      1 MB/s
Finished r-viridislite                        (00m:00s)               1 MB      6 MB/s
Finished r-lattice                            (00m:00s)               1 MB      5 MB/s
Finished r-withr                              (00m:00s)             226 KB    903 KB/s
Finished r-labeling                           (00m:00s)              65 KB    244 KB/s
Finished r-colorspace                         (00m:00s)               2 MB      9 MB/s
Finished r-tibble                             (00m:00s)             635 KB      2 MB/s
Finished r-crayon                             (00m:00s)             158 KB    352 KB/s
Finished libopenblas                          (00m:00s)               5 MB     16 MB/s
Finished r-ggplot2                            (00m:00s)               4 MB      8 MB/s
Finished r-mass                               (00m:00s)               1 MB      2 MB/s
Finished r-pillar                             (00m:00s)             662 KB      1 MB/s
Finished r-r6                                 (00m:00s)              86 KB    141 KB/s
Finished r-matrix                             (00m:00s)               4 MB      7 MB/s
Finished r-scales                             (00m:00s)             583 KB    923 KB/s
Finished r-fansi                              (00m:00s)             315 KB    478 KB/s
Finished r-utf8                               (00m:00s)             140 KB    206 KB/s
Finished r-mgcv                               (00m:00s)               3 MB      4 MB/s
Finished r-gtable                             (00m:00s)             391 KB    560 KB/s
Finished r-nlme                               (00m:00s)               2 MB      3 MB/s
Finished gfortran_impl_linux-64               (00m:00s)              10 MB     14 MB/s
Finished ucsc-gtftogenepred                   (00m:00s)               2 MB      2 MB/s
Finished fgbio                                (00m:00s)              37 MB     26 MB/s
Downloading  [====================================================================================================] (00m:18s)   43.86 MB/s
Extracting   [====================================================================================================] (00m:17s)      32 / 32
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />
<br />

<a id="try-a-trial-run-with-annotatebamwithumis"></a>
## Try a trial run with `AnnotateBamWithUmis`
<a id="make-a-directory-for-the-trial-with-annotatebamwithumis"></a>
### Make a directory for the trial with `AnnotateBamWithUmis`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir test_UMI-processing_AnnotateBamWithUmis \
	&& cd test_UMI-processing_AnnotateBamWithUmis
```

<a id="locations-of-datasets"></a>
### Locations of datasets
- `WTQvsG1`: `~/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot`
- `TRF4_SSRNA_April2022`: `~/tsukiyamalab/alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla`
- `Nab3_Nrd1_Depletion`: `~/tsukiyamalab/alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119`
- `rtr1_rrp6_wt`: `~/tsukiyamalab/alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119`

<a id="set-up-necessary-variables"></a>
### Set up necessary variables
```bash
#!/bin/bash
#DONTRUN #CONTINUE

p_bam="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams/unmapped-w/SC_KL_20S"
f_bam="5782_Q_IN_S8.Aligned.sortedByCoord.out.bam"

p_fq="${HOME}/tsukiyamalab/alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot"
f_fq="5782_Q_IN_S8_R2_001.fastq.gz"

p_out="./test_UMI-processing_AnnotateBamWithUmis"
f_out="5782_Q_IN_S8.Aligned.sortedByCoord.out.w-UMIs.bam"

echo "${p_bam}"
echo "${f_bam}"
echo "${p_fq}"
echo "${f_fq}"
echo "${p_out}"
echo "${f_out}"
```

<a id="run-the-command"></a>
### Run the command
```bash
#!/bin/bash
#DONTRUN #CONTINUE

fgbio AnnotateBamWithUmis \
    --input="${p_bam}/${f_bam}" \
    --fastq="${p_fq}/${f_fq}" \
    --output="${p_out}/${f_out}"
```

