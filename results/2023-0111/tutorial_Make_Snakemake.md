
`#tutorial_make_Snakemake.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Notes](#notes)
1. [Get situated](#get-situated)
	1. [Install dependencies](#install-dependencies)
1. [Run a test with `Make`](#run-a-test-with-make)
	1. [Use a `HEREDOC` to write the `Makefile`](#use-a-heredoc-to-write-the-makefile)
	1. [Run `Make` with the `Makefile`](#run-make-with-the-makefile)
	1. [Now, play around with it](#now-play-around-with-it)
	1. [On some important *automatic variables* made available in `Make`](#on-some-important-automatic-variables-made-available-in-make)
		1. [Clean up](#clean-up)
		1. [Make a new `Makefile` containing *automatic variables*](#make-a-new-makefile-containing-automatic-variables)
1. [On `Snakemake`](#on-snakemake)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="notes"></a>
## Notes
- Following along with information [here](https://vincebuffalo.com/blog/2020/03/04/understanding-snakemake.html), "Understanding Snakemake," by Vince Buffalo, 2020-03-04
- Run on local machine
<br />
<br />

<a id="get-situated"></a>
## Get situated
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd "/Users/kalavatt/projects-etc/2022_transcriptome-construction/results/2023-0111" \
	|| echo "cd'ing failed; check on this..."

source activate Trinity_env
```
</details>
<br />

<a id="install-dependencies"></a>
### Install dependencies
<details>
<summary><i>Code: Install dependencies</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mamba install -c bioconda bioawk
mamba install -c bioconda snakemake
```
</details>
<br />

<details>
<summary><i>Printed: Install dependencies</i></summary>

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['bioawk']

bioconda/osx-64                                      3.8MB @   4.1MB/s  1.0s
bioconda/noarch                                      4.2MB @   3.4MB/s  1.3s
conda-forge/noarch                                  11.1MB @   4.0MB/s  3.0s
conda-forge/osx-64                                  26.7MB @   4.9MB/s  6.1s

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - bioawk
   - ca-certificates
   - certifi
   - openssl


  Package    Version  Build       Channel                Size
───────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────

  + bioawk       1.0  h1f540d2_7  bioconda/osx-64        81kB

  Change:
───────────────────────────────────────────────────────────────

  - openssl    3.0.7  hfd90126_1  conda-forge
  + openssl    3.0.7  hfd90126_2  conda-forge/osx-64      2MB

  Summary:

  Install: 1 packages
  Change: 1 packages

  Total download: 2MB

───────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
openssl                                              2.3MB @  31.5MB/s  0.1s
bioawk                                              81.1kB @ 571.1kB/s  0.1s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done

❯ mamba install -c bioconda snakemake

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

        mamba (0.27.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['snakemake']

bioconda/osx-64                                               No change
bioconda/noarch                                               No change
conda-forge/noarch                                            No change
[+] 5.7s
conda-forge/osx-64                                  26.7MB @   4.7MB/s  6.4s

Pinned packages:
  - python 3.7.*


Transaction

  Prefix: /Users/kalavatt/mambaforge/envs/Trinity_env

  Updating specs:

   - snakemake
   - ca-certificates
   - certifi
   - openssl


  Package                        Version  Build              Channel                 Size
───────────────────────────────────────────────────────────────────────────────────────────
  Install:
───────────────────────────────────────────────────────────────────────────────────────────

  + aioeasywebdav                  2.4.0  py37hf985489_1001  conda-forge/osx-64      18kB
  + aiohttp                        3.8.3  py37h8052db5_0     conda-forge/osx-64     433kB
  + aiosignal                      1.3.1  pyhd8ed1ab_0       conda-forge/noarch      13kB
  + amply                          0.1.5  pyhd8ed1ab_0       conda-forge/noarch      21kB
  + async-timeout                  4.0.2  pyhd8ed1ab_0       conda-forge/noarch       9kB
  + asynctest                     0.13.0  py_0               conda-forge/noarch      25kB
  + attmap                        0.13.2  pyhd8ed1ab_0       conda-forge/noarch      14kB
  + bcrypt                         3.2.2  py37h994c40b_0     conda-forge/osx-64      45kB
  + boto3                        1.26.61  pyhd8ed1ab_0       conda-forge/noarch      77kB
  + botocore                     1.29.62  pyhd8ed1ab_0       conda-forge/noarch       6MB
  + cachetools                     5.3.0  pyhd8ed1ab_0       conda-forge/noarch      14kB
  + coin-or-cbc                   2.10.8  hc8a182d_0         conda-forge/osx-64       1MB
  + coin-or-cgl                   0.60.6  ha3c4b8c_2         conda-forge/osx-64     603kB
  + coin-or-clp                   1.17.7  hf0ee74e_2         conda-forge/osx-64       1MB
  + coin-or-osi                  0.108.7  hfef9e4d_2         conda-forge/osx-64     415kB
  + coin-or-utils                 2.11.6  h7a46149_2         conda-forge/osx-64     731kB
  + coincbc                       2.10.8  0_metapackage      conda-forge/noarch      10kB
  + configargparse                 1.5.3  pyhd8ed1ab_0       conda-forge/noarch      33kB
  + connection_pool                0.0.3  pyhd3deb0d_0       conda-forge/noarch       8kB
  + datrie                         0.8.2  py37h8052db5_4     conda-forge/osx-64     132kB
  + dpath                          2.0.6  py37hf985489_1     conda-forge/osx-64      24kB
  + dropbox                      11.36.0  pyhd8ed1ab_0       conda-forge/noarch     965kB
  + exceptiongroup                 1.1.0  pyhd8ed1ab_0       conda-forge/noarch      19kB
  + filechunkio                      1.8  py_2               conda-forge/noarch       5kB
  + filelock                       3.9.0  pyhd8ed1ab_0       conda-forge/noarch      14kB
  + frozenlist                     1.3.1  py37h74e8b7d_0     conda-forge/osx-64      42kB
  + ftputil                        5.0.4  pyhd8ed1ab_0       conda-forge/noarch      43kB
  + gitdb                         4.0.10  pyhd8ed1ab_0       conda-forge/noarch      52kB
  + gitpython                     3.1.30  pyhd8ed1ab_0       conda-forge/noarch     141kB
  + google-api-core               2.11.0  pyhd8ed1ab_0       conda-forge/noarch      77kB
  + google-api-python-client      2.75.0  pyhd8ed1ab_0       conda-forge/noarch       5MB
  + google-auth                   2.16.0  pyh1a96a4e_1       conda-forge/noarch      99kB
  + google-auth-httplib2           0.1.0  pyhd8ed1ab_1       conda-forge/noarch      14kB
  + google-cloud-core              2.3.2  pyhd8ed1ab_0       conda-forge/noarch      28kB
  + google-cloud-storage           2.7.0  pyh1a96a4e_0       conda-forge/noarch      79kB
  + google-crc32c                  1.1.2  py37h216aaf8_3     conda-forge/osx-64      23kB
  + google-resumable-media         2.4.1  pyhd8ed1ab_0       conda-forge/noarch      44kB
  + googleapis-common-protos      1.57.1  pyhd8ed1ab_0       conda-forge/noarch     117kB
  + grpc-cpp                      1.48.1  h966d1d5_1         conda-forge/osx-64       4MB
  + grpcio                        1.48.1  py37hed26be4_1     conda-forge/osx-64     770kB
  + httplib2                      0.21.0  pyhd8ed1ab_0       conda-forge/noarch      99kB
  + humanfriendly                   10.0  py37hf985489_2     conda-forge/osx-64     121kB
  + iniconfig                      2.0.0  pyhd8ed1ab_0       conda-forge/noarch      11kB
  + jmespath                       1.0.1  pyhd8ed1ab_0       conda-forge/noarch      21kB
  + libabseil                 20220623.0  cxx17_h844d122_6   conda-forge/osx-64     989kB
  + libcrc32c                      1.1.2  he49afe7_0         conda-forge/osx-64      20kB
  + liblapacke                     3.9.0  13_osx64_openblas  conda-forge/osx-64      13kB
  + libprotobuf                   3.21.8  hbc0c0cd_0         conda-forge/osx-64       2MB
  + logmuse                        0.2.6  pyh8c360ce_0       conda-forge/noarch      11kB
  + markdown-it-py                 2.1.0  pyhd8ed1ab_0       conda-forge/noarch      59kB
  + mdurl                          0.1.0  pyhd8ed1ab_0       conda-forge/noarch      14kB
  + multidict                      6.0.2  py37h69ee0a8_1     conda-forge/osx-64      46kB
  + oauth2client                   4.1.3  py_0               conda-forge/noarch      67kB
  + paramiko                       3.0.0  pyhd8ed1ab_0       conda-forge/noarch     148kB
  + peppy                         0.35.4  pyhd8ed1ab_0       conda-forge/noarch      32kB
  + plac                           1.3.5  pyhd8ed1ab_0       conda-forge/noarch      23kB
  + prettytable                    3.6.0  pyhd8ed1ab_0       conda-forge/noarch      29kB
  + protobuf                      4.21.8  py37hac51a3e_0     conda-forge/osx-64     316kB
  + pulp                           2.6.0  py37hf985489_1     conda-forge/osx-64     126kB
  + pyasn1                         0.4.8  py_0               conda-forge/noarch      54kB
  + pyasn1-modules                 0.2.7  py_0               conda-forge/noarch      61kB
  + pynacl                         1.5.0  py37h69ee0a8_1     conda-forge/osx-64       1MB
  + pysftp                         0.2.9  py_1               conda-forge/noarch      16kB
  + pytest                         7.2.0  py37hf985489_0     conda-forge/osx-64     512kB
  + python-irodsclient             1.1.6  pyhd8ed1ab_0       conda-forge/noarch     148kB
  + pyu2f                          0.1.5  pyhd8ed1ab_0       conda-forge/noarch      32kB
  + re2                       2022.06.01  hb486fe8_1         conda-forge/osx-64     183kB
  + reretry                       0.11.8  pyhd8ed1ab_0       conda-forge/noarch      12kB
  + rich                          13.3.1  pyhd8ed1ab_0       conda-forge/noarch     183kB
  + rsa                              4.9  pyhd8ed1ab_0       conda-forge/noarch      30kB
  + s3transfer                     0.6.0  pyhd8ed1ab_0       conda-forge/noarch      57kB
  + slacker                       0.14.0  py_0               conda-forge/noarch      16kB
  + smart_open                     6.3.0  pyhd8ed1ab_1       conda-forge/noarch      47kB
  + smmap                          3.0.5  pyh44b312d_0       conda-forge/noarch      23kB
  + snakemake                     7.20.0  hdfd78af_0         bioconda/noarch          8kB
  + snakemake-minimal             7.20.0  pyhdfd78af_0       bioconda/noarch        260kB
  + stone                          3.3.1  pyhd8ed1ab_0       conda-forge/noarch     149kB
  + stopit                         1.1.2  py_0               conda-forge/noarch      16kB
  + tabulate                       0.9.0  pyhd8ed1ab_1       conda-forge/noarch      36kB
  + throttler                      1.2.1  pyhd8ed1ab_0       conda-forge/noarch      11kB
  + toposort                         1.7  pyhd8ed1ab_0       conda-forge/noarch      13kB
  + ubiquerg                       0.6.2  pyhd8ed1ab_0       conda-forge/noarch      16kB
  + uritemplate                    4.1.1  pyhd8ed1ab_0       conda-forge/noarch      12kB
  + veracitools                    0.1.3  py_0               conda-forge/noarch       6kB
  + yarl                           1.7.2  py37h69ee0a8_2     conda-forge/osx-64     130kB
  + yte                            1.5.1  py37hf985489_0     conda-forge/osx-64      17kB

  Summary:

  Install: 86 packages

  Total download: 31MB

───────────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
toposort                                            12.6kB @ 199.4kB/s  0.1s
throttler                                           11.3kB @ 160.5kB/s  0.1s
configargparse                                      32.5kB @ 435.0kB/s  0.1s
filechunkio                                          5.1kB @  64.5kB/s  0.1s
connection_pool                                      8.3kB @  94.0kB/s  0.1s
mdurl                                               13.7kB @ 149.6kB/s  0.0s
ftputil                                             42.9kB @ 450.6kB/s  0.0s
asynctest                                           25.0kB @ 241.1kB/s  0.0s
uritemplate                                         12.3kB @ 114.9kB/s  0.0s
pyasn1                                              54.3kB @ 462.9kB/s  0.0s
async-timeout                                        9.3kB @  76.8kB/s  0.0s
exceptiongroup                                      18.6kB @ 146.2kB/s  0.0s
rsa                                                 29.9kB @ 227.6kB/s  0.0s
gitdb                                               51.6kB @ 385.4kB/s  0.0s
boto3                                               76.7kB @ 522.4kB/s  0.0s
gitpython                                          141.3kB @ 929.1kB/s  0.0s
libcrc32c                                           20.1kB @ 130.1kB/s  0.0s
multidict                                           46.2kB @ 269.5kB/s  0.0s
re2                                                182.9kB @   1.0MB/s  0.0s
libprotobuf                                          2.3MB @  12.6MB/s  0.1s
protobuf                                           315.7kB @   1.7MB/s  0.0s
coin-or-utils                                      730.6kB @   3.8MB/s  0.0s
coin-or-osi                                        415.3kB @   2.1MB/s  0.0s
veracitools                                          6.1kB @  29.1kB/s  0.0s
attmap                                              13.6kB @  62.7kB/s  0.0s
coincbc                                              9.9kB @  45.3kB/s  0.0s
coin-or-cbc                                          1.0MB @   4.7MB/s  0.0s
google-auth-httplib2                                13.7kB @  58.3kB/s  0.0s
snakemake                                            8.2kB @  32.5kB/s  0.0s
slacker                                             15.6kB @  60.3kB/s  0.0s
smmap                                               22.8kB @  80.3kB/s  0.0s
pyu2f                                               31.9kB @ 110.5kB/s  0.0s
pulp                                               126.1kB @ 425.4kB/s  0.1s
google-api-python-client                             5.3MB @  17.4MB/s  0.1s
plac                                                23.4kB @  74.4kB/s  0.0s
python-irodsclient                                 148.3kB @ 467.8kB/s  0.0s
pyasn1-modules                                      61.3kB @ 191.5kB/s  0.0s
s3transfer                                          56.7kB @ 175.2kB/s  0.0s
frozenlist                                          41.7kB @ 122.1kB/s  0.0s
humanfriendly                                      121.3kB @ 290.9kB/s  0.1s
dpath                                               23.6kB @  54.5kB/s  0.1s
paramiko                                           148.3kB @ 338.0kB/s  0.0s
yte                                                 17.2kB @  38.6kB/s  0.1s
grpcio                                             770.1kB @   1.7MB/s  0.1s
googleapis-common-protos                           117.1kB @ 253.4kB/s  0.0s
peppy                                               32.1kB @  69.0kB/s  0.0s
reretry                                             12.2kB @  26.1kB/s  0.2s
google-cloud-storage                                79.4kB @ 168.6kB/s  0.0s
google-auth                                         99.0kB @ 209.9kB/s  0.0s
tabulate                                            35.9kB @  73.6kB/s  0.0s
prettytable                                         29.0kB @  59.0kB/s  0.0s
httplib2                                            98.5kB @ 198.4kB/s  0.0s
iniconfig                                           11.1kB @  22.0kB/s  0.0s
oauth2client                                        67.5kB @ 132.9kB/s  0.0s
pynacl                                               1.4MB @   2.7MB/s  0.0s
aiosignal                                           12.7kB @  23.7kB/s  0.0s
pytest                                             512.4kB @ 947.9kB/s  0.0s
yarl                                               129.8kB @ 238.8kB/s  0.0s
ubiquerg                                            16.0kB @  29.2kB/s  0.0s
filelock                                            13.7kB @  24.4kB/s  0.0s
google-api-core                                     77.2kB @ 136.5kB/s  0.0s
logmuse                                             10.7kB @  18.9kB/s  0.0s
stone                                              149.0kB @ 257.6kB/s  0.0s
bcrypt                                              44.7kB @  76.3kB/s  0.0s
botocore                                             5.9MB @   9.7MB/s  0.1s
aiohttp                                            433.0kB @ 706.7kB/s  0.0s
dropbox                                            964.8kB @   1.6MB/s  0.1s
snakemake-minimal                                  260.5kB @ 415.4kB/s  0.0s
cachetools                                          14.3kB @  22.4kB/s  0.0s
markdown-it-py                                      58.7kB @  92.1kB/s  0.0s
google-resumable-media                              43.5kB @  66.3kB/s  0.0s
libabseil                                          988.6kB @   1.5MB/s  0.0s
google-crc32c                                       23.5kB @  35.0kB/s  0.1s
coin-or-clp                                          1.3MB @   1.9MB/s  0.0s
stopit                                              16.1kB @  23.5kB/s  0.0s
coin-or-cgl                                        603.1kB @ 880.9kB/s  0.1s
amply                                               20.9kB @  29.6kB/s  0.0s
rich                                               182.6kB @ 258.7kB/s  0.0s
pysftp                                              15.5kB @  21.9kB/s  0.0s
smart_open                                          47.4kB @  65.9kB/s  0.0s
jmespath                                            21.0kB @  28.6kB/s  0.0s
grpc-cpp                                             4.2MB @   5.8MB/s  0.1s
google-cloud-core                                   28.3kB @  38.1kB/s  0.0s
aioeasywebdav                                       18.4kB @  22.7kB/s  0.1s
liblapacke                                          12.6kB @  15.3kB/s  0.1s
datrie                                             132.4kB @ 159.3kB/s  0.1s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```
</details>
<br />
<br />

<a id="run-a-test-with-make"></a>
## Run a test with `Make`
<a id="use-a-heredoc-to-write-the-makefile"></a>
### Use a `HEREDOC` to write the `Makefile`

<details>
<summary><i>Code: Use a HEREDOC to write the Makefile</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tab="$(printf '\t')"

if [[ -f "Makefile" ]]; then rm "Makefile"; fi
cat << mf > "./Makefile"
all: Dmel_BDGP6.28_seqlens.tsv

Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz: 
${tab}wget ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz

Dmel_BDGP6.28_seqlens.tsv: Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
${tab}bioawk -c fastx '{print $\$name "\t" length($\$seq)}' Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz > Dmel_BDGP6.28_seqlens.tsv
mf
#  vi Makefile  # :q
# cat Makefile
```
</details>
<br />

<a id="run-make-with-the-makefile"></a>
### Run `Make` with the `Makefile`

<details>
<summary><i>Code: Run Make with the Makefile</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

make all
.,
```
</details>
<br />

<details>
<summary><i>Printed: Run Make with the Makefile</i></summary>

```txt
❯ make all
wget ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
--2023-02-01 16:46:58--  ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
           => ‘Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz’
Resolving ftp.ensembl.org (ftp.ensembl.org)... 193.62.193.139
Connecting to ftp.ensembl.org (ftp.ensembl.org)|193.62.193.139|:21... connected.
Logging in as anonymous ... Logged in!
==> SYST ... done.    ==> PWD ... done.
==> TYPE I ... done.  ==> CWD (1) /pub/release-99/fasta/drosophila_melanogaster/dna ... done.
==> SIZE Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz ... 43288810
==> PASV ... done.    ==> RETR Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz ... done.
Length: 43288810 (41M) (unauthoritative)

Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz              100%[========================================================================================================================================================>]  41.28M   364KB/s    in 1m 51s

2023-02-01 16:48:51 (380 KB/s) - ‘Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz’ saved [43288810]

bioawk -c fastx '{print $name "\t" length($seq)}' Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz > Dmel_BDGP6.28_seqlens.tsv
```
</details>
<br />

<a id="now-play-around-with-it"></a>
### Now, play around with it
<details>
<summary><i>Code: Now, play around with it</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

rm Dmel_BDGP6.28_seqlens.tsv
make all  # Since the genome hasn't been changed or deleted, only the last rule is run!

#  Change the timestamp of *.fa.gz to emulate changing the input file
touch Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
.,
make all  # Runs all downstream steps
```
</details>
<br />

<details>
<summary><i>Printed: </i></summary>

```txt
❯ rm Dmel_BDGP6.28_seqlens.tsv

❯ make all
bioawk -c fastx '{print $name "\t" length($seq)}' Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz > Dmel_BDGP6.28_seqlens.tsv

❯ touch Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz

❯ .,
total 43M
drwxr-xr-x 13 kalavatt  416 Feb  1 16:50 ./
drwxr-xr-x 11 kalavatt  352 Jan 25 17:16 ../
-rw-r--r--  1 kalavatt  39K Feb  1 16:50 Dmel_BDGP6.28_seqlens.tsv
-rw-r--r--  1 kalavatt  42M Feb  1 16:51 Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
-rw-r--r--  1 kalavatt  428 Feb  1 16:33 Makefile
-rw-r--r--  1 kalavatt  241 Jan 11 17:22 README.md
-rw-r--r--  1 kalavatt  64K Jan 25 17:10 assess_Trinity-GF_optimization_initial.md
-rw-r--r--  1 kalavatt  245 Jan 12 08:29 scratch.sh
-rw-r--r--  1 kalavatt  20K Jan 12 14:52 troubleshoot_Singularity-mounting.md
-rw-r--r--  1 kalavatt 3.6K Feb  1 16:49 tutorial_Make_Snakemake.md
-rw-r--r--  1 kalavatt  94K Jan 27 15:02 tutorial_job-arrays.md
-rw-r--r--  1 kalavatt  23K Jan 12 15:07 work_Trinity-GF_optimization_initial.md
-rw-r--r--  1 kalavatt  28K Jan 12 10:27 work_Trinity-GG_optimization.md

❯ make all  # Runs all downstream steps
bioawk -c fastx '{print $name "\t" length($seq)}' Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz > Dmel_BDGP6.28_seqlens.tsv
```
</details>
<br />

<a id="on-some-important-automatic-variables-made-available-in-make"></a>
### On some important *automatic variables* made available in `Make`
`$@`: placeholder for the filename of the target
`$<`: the name of the first prerequisite

<a id="clean-up"></a>
#### Clean up
<details>
<summary><i>Code: Clean up</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

rm \
	Makefile \
	Dmel_BDGP6.28_seqlens.tsv \
	Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
```
</details>
<br />

<a id="make-a-new-makefile-containing-automatic-variables"></a>
#### Make a new `Makefile` containing *automatic variables*
<details>
<summary><i>Code: Make a new Makefile containing automatic variables</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

tab="$(printf '\t')"

if [[ -f "Makefile" ]]; then rm "Makefile"; fi
cat << mf > "./Makefile"
all: Dmel_BDGP6.28_seqlens.tsv

Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz: 
${tab}wget ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz

Dmel_BDGP6.28_seqlens.tsv: Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
${tab}bioawk -c fastx '{print $\$name "\t" length($\$seq)}' \$< > \$@
mf

cat Makefile

make all
```
</details>
<br />

<details>
<summary><i>Printed: Make a new Makefile containing automatic variables</i></summary>

```txt
❯ cat Makefile
all: Dmel_BDGP6.28_seqlens.tsv

Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz:
	wget ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz

Dmel_BDGP6.28_seqlens.tsv: Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
	bioawk -c fastx '{print $$name "\t" length($$seq)}' $< > $@

❯ make all
wget ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
--2023-02-01 17:11:16--  ftp://ftp.ensembl.org/pub/release-99/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz
           => ‘Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz’
Resolving ftp.ensembl.org (ftp.ensembl.org)... 193.62.193.139
Connecting to ftp.ensembl.org (ftp.ensembl.org)|193.62.193.139|:21... connected.
Logging in as anonymous ... Logged in!
==> SYST ... done.    ==> PWD ... done.
==> TYPE I ... done.  ==> CWD (1) /pub/release-99/fasta/drosophila_melanogaster/dna ... done.
==> SIZE Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz ... 43288810
==> PASV ... done.    ==> RETR Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz ... done.
Length: 43288810 (41M) (unauthoritative)

Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz              100%[========================================================================================================================================================>]  41.28M  1.62MB/s    in 39s

2023-02-01 17:11:57 (1.05 MB/s) - ‘Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz’ saved [43288810]

bioawk -c fastx '{print $name "\t" length($seq)}' Drosophila_melanogaster.BDGP6.28.dna.toplevel.fa.gz > Dmel_BDGP6.28_seqlens.tsv
```
</details>
<br />
<br />

<a id="on-snakemake"></a>
## On `Snakemake`
e.g., see [here](https://vincebuffalo.com/blog/2020/03/04/understanding-snakemake.html#snakemake) to get to the appropriate part of the webpage