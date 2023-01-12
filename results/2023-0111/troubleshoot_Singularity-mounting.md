
`#troubleshoot_Singularity-mounting.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up](#set-things-up)
1. [Run `singularity shell` to understand the mounting issue](#run-singularity-shell-to-understand-the-mounting-issue)
    1. [Background](#background)
        1. [How I have been calling `PASA.sif` in `2022-1201/` experiments](#how-i-have-been-calling-pasasif-in-2022-1201-experiments)
        1. [How I was calling `Trinity.sif` on 2023-0111](#how-i-was-calling-trinitysif-on-2023-0111)
    1. [Troubleshooting `singularity shell ... Trinity.sif`](#troubleshooting-singularity-shell--trinitysif)
        1. [The initial call to `singularity shell ... Trinity.sif`](#the-initial-call-to-singularity-shell--trinitysif)
        1. [Remove `--bind "${d_data}"`, then see what happens](#remove---bind-%24d_data-then-see-what-happens)
        1. [Update `--bind "${d_data}"` based on the advice in a forum post](#update---bind-%24d_data-based-on-the-advice-in-a-forum-post)
        1. [Find the `*.fastq.gz` datasets through the container shell](#find-the-fastqgz-datasets-through-the-container-shell)
        1. [Find the `*.fastq.gz` datasets through the container shell](#find-the-fastqgz-datasets-through-the-container-shell-1)
        1. [Find the `*.fastq.gz` datasets through the container shell](#find-the-fastqgz-datasets-through-the-container-shell-2)

<!-- /MarkdownTOC -->
</details>
<br />

Problem: Container is unable to access symlinked files


<a id="set-things-up"></a>
## Set things up
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 core and defaults

mwd() {
    transcriptome \
        && cd "./results/2023-0111" \
        || echo "cd'ing failed; check on this"
}


mwd
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111

Trinity_env


#  Symlink to directory of interest, ../2022-1201/files_processed-full --------
if [[ ! -d "./files_processed-full" ]]; then
    ln -s "../2022-1201/files_processed-full" "files_processed-full"
fi
# .,
# total 128K
# drwxrws--- 3 kalavatt  66 Jan 12 10:39 ./
# drwxrws--- 9 kalavatt 189 Jan 11 15:44 ../
# lrwxrwxrwx 1 kalavatt  33 Jan 11 15:44 files_processed-full -> ../2022-1201/files_processed-full/
# drwxrws--- 3 kalavatt 148 Jan 11 17:10 sh_err_out/
```
</details>
<br />

<a id="run-singularity-shell-to-understand-the-mounting-issue"></a>
## Run `singularity shell` to understand the mounting issue
<a id="background"></a>
### Background
<a id="how-i-have-been-calling-pasasif-in-2022-1201-experiments"></a>
#### How I have been calling `PASA.sif` in `2022-1201/` experiments
*An excerpt from `2022-1201/work_PASA_un_trim_trim-rcor_stringent-alignment-overlap.sh` (part of a `HEREDOC`)*
<details>
<summary><i>Click to view</i></summary>

```txt
singularity run \\
    --no-home \\
    --bind "\${HOME}/genomes/sacCer3/Ensembl/108" \\
    --bind "\$(pwd)" \\
    --bind "/fh/scratch/delete30/tsukiyama_t:/loc/scratch/\${SLURM_JOB_ID}" \\
    "\${HOME}/singularity-docker-etc/PASA.sif" \\
    ...
```
</details>
<br />

<a id="how-i-was-calling-trinitysif-on-2023-0111"></a>
#### How I was calling `Trinity.sif` on 2023-0111
*An excerpt from `2023-0111/work_Trinity-GF_optimization.md` (part of a `HEREDOC`)*
<details>
<summary><i>Click to view</i></summary>

```txt
parallel --header : --colsep " " -k -j 1 \\
    'singularity run \\
        --no-home \\
        --bind {d_exp} \\
        --bind {d_data} \\
        --bind {d_scr} \\
        ~/singularity-docker-etc/Trinity.sif \\
        ...
```
</details>
<br />

- Where `{d_exp}` is `"\$(pwd)"`&mdash;i.e., it's essentially `$(pwd)`
- Where `{d_data}` is `"files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"`
- Where `{d_scr}` is `"/fh/scratch/delete30/tsukiyama_t:/loc/scratch"`

<a id="troubleshooting-singularity-shell--trinitysif"></a>
### Troubleshooting `singularity shell ... Trinity.sif`
<a id="the-initial-call-to-singularity-shell--trinitysif"></a>
#### The initial call to `singularity shell ... Trinity.sif`
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE #1/N

d_exp="$(pwd)"
d_data="files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
d_scr="/fh/scratch/delete30/tsukiyama_t:/loc/scratch"

ml Singularity

singularity shell \
    --bind "${d_exp}" \
    --bind "${d_data}" \
    --bind "${d_scr}" \
    ~/singularity-docker-etc/Trinity.sif
```

Printed to terminal: Singularity warning and error messages
```txt
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111, may not be available
FATAL:   container creation failed: mount /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd->/fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd error: while mounting /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd: destination /fh/fast/tsukiyama_t/grp/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd doesn't exist in container
```
</details>
<br />

`#NOTE` Singularity failed entirely

<a id="remove---bind-%24d_data-then-see-what-happens"></a>
#### Remove `--bind "${d_data}"`, then see what happens
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE #2/N

singularity shell \
    --bind "${d_exp}" \
    --bind "${d_scr}" \
    ~/singularity-docker-etc/Trinity.sif
```

Printed to terminal: Singularity warning message
```txt
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111, may not be available
```
</details>
<br />

`#NOTE` The call to singularity shell and concomitant mounting was successful

<a id="update---bind-%24d_data-based-on-the-advice-in-a-forum-post"></a>
#### Update `--bind "${d_data}"` based on the advice in a forum post
- [Link to the post](https://groups.google.com/a/lbl.gov/g/singularity/c/wJ_t3GDHGFA)
- Pertinent info: "This is an ongoing problem as Singularity can not automatically (at least not today) figure out home directories that exist on a symlink'ed path, so that path will have to be bound in via a bind path instead of relying on the home directory automatic mounting."
- __Try giving the full path to the director__

<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE #3/N

#  Exit the intra-container shell (Singularity>)
exit
# Singularity> exit
# exit

d_exp="$(pwd)"
d_data="$(pwd)/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
d_scr="/fh/scratch/delete30/tsukiyama_t:/loc/scratch"
# echo "${d_data}"  #OK
# ., "${d_data}"  #OK

singularity shell \
    --bind "${d_exp}" \
    --bind "${d_data}" \
    --bind "${d_scr}" \
    ~/singularity-docker-etc/Trinity.sif
```

Printed to terminal: Singularity warning message
```txt
WARNING: Bind mount '/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111 => /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111, may not be available
```
</details>
<br />

`#NOTE` The call to singularity shell and concomitant mounting was successful

<a id="find-the-fastqgz-datasets-through-the-container-shell"></a>
#### Find the `*.fastq.gz` datasets through the container shell
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE #4/N

#  Currently with the intra-container shell (Singularity>)
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111

ls -lhaFG
# total 96K
# drwxrws--- 3 kalavatt  66 Jan 12 10:39 ./
# drwxr-xr-x 3 kalavatt  60 Jan 12 11:21 ../
# lrwxrwxrwx 1 kalavatt  33 Jan 11 15:44 files_processed-full -> ../2022-1201/files_processed-full
# drwxrws--- 3 kalavatt 148 Jan 11 17:10 sh_err_out/

cd files_processed-full \
    || echo "cd'ing failed; check on this"
# bash: cd: files_processed-full: No such file or directory
# cd'ing failed; check on this

cd "$(pwd)/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd" \
    || echo "cd'ing failed; check on this"
# bash: cd: /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd: No such file or directory
# cd'ing failed; check on this

cd / \
    || echo "cd'ing failed; check on this"
# total 268K
# drwxr-xr-x   1 kalavatt  100 Jan 12 11:21 ./
# drwxr-xr-x   1 kalavatt  100 Jan 12 11:21 ../
# lrwxrwxrwx   1 root       27 Dec  7 11:20 .exec -> .singularity.d/actions/exec*
# lrwxrwxrwx   1 root       26 Dec  7 11:20 .run -> .singularity.d/actions/run*
# lrwxrwxrwx   1 root       28 Dec  7 11:20 .shell -> .singularity.d/actions/shell*
# drwxr-xr-x   5 root      127 Dec  7 11:20 .singularity.d/
# lrwxrwxrwx   1 root       27 Dec  7 11:20 .test -> .singularity.d/actions/test*
# lrwxrwxrwx   1 root        7 Oct 19 09:47 bin -> usr/bin/
# drwxr-xr-x   2 root        3 Apr 15  2020 boot/
# drwxr-xr-x  18 root     4.3K Dec 27 19:39 dev/
# lrwxrwxrwx   1 root       36 Dec  7 11:20 environment -> .singularity.d/env/90-environment.sh*
# drwxr-xr-x  55 root     1.9K Dec  3 05:46 etc/
# drwxr-xr-x   3 kalavatt   60 Jan 12 11:21 fh/
# drwxr-xr-x   1 kalavatt   60 Jan 12 11:21 home/
# lrwxrwxrwx   1 root        7 Oct 19 09:47 lib -> usr/lib/
# lrwxrwxrwx   1 root        9 Oct 19 09:47 lib32 -> usr/lib32/
# lrwxrwxrwx   1 root        9 Oct 19 09:47 lib64 -> usr/lib64/
# lrwxrwxrwx   1 root       10 Oct 19 09:47 libx32 -> usr/libx32/
# drwxr-xr-x   3 kalavatt   60 Jan 12 11:21 loc/
# drwxr-xr-x   2 root        3 Oct 19 09:47 media/
# drwxr-xr-x   2 root        3 Oct 19 09:47 mnt/
# drwxr-xr-x   2 root        3 Oct 19 09:47 opt/
# dr-xr-xr-x 452 root        0 Oct 13 09:25 proc/
# drwx------   5 root      136 Dec  1 10:34 root/
# drwxr-xr-x   5 root       67 Oct 19 09:50 run/
# lrwxrwxrwx   1 root        8 Oct 19 09:47 sbin -> usr/sbin/
# lrwxrwxrwx   1 root       24 Dec  7 11:20 singularity -> .singularity.d/runscript*
# drwxr-xr-x   2 root        3 Oct 19 09:47 srv/
# dr-xr-xr-x  13 root        0 Oct 13 09:25 sys/
# drwxrwxrwt  34 root     264K Jan 12 11:29 tmp/
# drwxr-xr-x  14 root      241 Nov 30 06:37 usr/
# drwxr-xr-x  11 root      160 Oct 19 09:50 var/

cd - \
    || echo "cd'ing failed; check on this"
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111

cd "../2022-1201/files_processed-full" \
    || echo "cd'ing failed; check on this"
# bash: cd: ../2022-1201/files_processed-full: No such file or directory
# cd'ing failed; check on this

#  Exit the intra-container shell (Singularity>)
exit
# Singularity> exit
# exit
```
</details>
<br />

`#NOTE` Clearly, the symlinked directory is not accessible from within the container

<a id="find-the-fastqgz-datasets-through-the-container-shell-1"></a>
#### Find the `*.fastq.gz` datasets through the container shell
__Try mounting the absolute path to the symlinked directory, in addition to the symlinked directory__
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE #5/N

d_exp="$(pwd)"
d_sym="$(pwd)/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
d_full="$(dirname "$(pwd)")/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
d_scr="/fh/scratch/delete30/tsukiyama_t:/loc/scratch"
# echo "${d_sym}"  #OK
# ., "${d_sym}"  #OK
# echo "${d_full}"  #OK
# ., "${d_full}"  #OK

singularity shell \
    --bind "${d_exp}" \
    --bind "${d_sym}" \
    --bind "${d_full}" \
    --bind "${d_scr}" \
    ~/singularity-docker-etc/Trinity.sif

#  Made it into the intra-container shell with the typical warning message;
#+ now, running commands within the container (Singularity>)
ls -lhaFG
# total 96K
# drwxrws--- 3 kalavatt  66 Jan 12 10:39 ./
# drwxr-xr-x 3 kalavatt  60 Jan 12 11:40 ../
# lrwxrwxrwx 1 kalavatt  33 Jan 11 15:44 files_processed-full -> ../2022-1201/files_processed-full
# drwxrws--- 3 kalavatt 148 Jan 11 17:10 sh_err_out/

cd files_processed-full \
    || echo "cd'ing failed; check on this"
# bash: cd: files_processed-full: No such file or directory
# cd'ing failed; check on this

cd .. \
    || echo "cd'ing failed; check on this"

ls -lhaFG
# total 32K
# drwxr-xr-x 3 kalavatt 60 Jan 12 11:40 ./
# drwxr-xr-x 3 kalavatt 60 Jan 12 11:40 ../
# drwxrws--- 3 kalavatt 66 Jan 12 10:39 2023-0111/

#  Did cd .. && ls -lhaFG all the way to root: Did not find "${d_full}"

#  Does this work?
cd \
    "/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd" \
        || echo "cd'ing failed; check on this"
# bash: cd: /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd: No such file or directory
# cd'ing failed; check on this

#  Exit the intra-container shell (Singularity>)
exit
# Singularity> exit
# exit
```
</details>
<br />

<a id="find-the-fastqgz-datasets-through-the-container-shell-2"></a>
#### Find the `*.fastq.gz` datasets through the container shell
__Try mounting the host bind path to a different (and simpler) container path__  
Also, no need to specify `{d_exp}` (`$(pwd`)&mdash;it's done automatically ([link](https://docs.sylabs.io/guides/3.1/user-guide/bind_paths_and_mounts.html))
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE #5/N

d_exp="$(pwd)"
d_dat="$(dirname "$(pwd)")/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
d_scr="/fh/scratch/delete30/tsukiyama_t:/loc/scratch"
# echo "${d_dat}"  #OK
# ., "${d_dat}"  #OK

singularity shell \
    --bind "${d_dat}:/data" \
    --bind "${d_scr}" \
    ~/singularity-docker-etc/Trinity.sif
# WARNING: Bind mount '/home/kalavatt => /home/kalavatt' overlaps container CWD /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111, may not be available

cd "files_processed-full"
# bash: cd: files_processed-full: No such file or directory

#  Did cd .. && ls -lhaFG all the way to root
pwd
# /

ls -lhaFG
# total 300K
# drwxr-xr-x   1 kalavatt  120 Jan 12 11:57 ./
# drwxr-xr-x   1 kalavatt  120 Jan 12 11:57 ../
# lrwxrwxrwx   1 root       27 Dec  7 11:20 .exec -> .singularity.d/actions/exec*
# lrwxrwxrwx   1 root       26 Dec  7 11:20 .run -> .singularity.d/actions/run*
# lrwxrwxrwx   1 root       28 Dec  7 11:20 .shell -> .singularity.d/actions/shell*
# drwxr-xr-x   5 root      127 Dec  7 11:20 .singularity.d/
# lrwxrwxrwx   1 root       27 Dec  7 11:20 .test -> .singularity.d/actions/test*
# lrwxrwxrwx   1 root        7 Oct 19 09:47 bin -> usr/bin/
# drwxr-xr-x   2 root        3 Apr 15  2020 boot/
# drwxrws---   2 kalavatt 1.8K Dec  5 13:00 data/
# drwxr-xr-x  18 root     4.3K Dec 27 19:39 dev/
# lrwxrwxrwx   1 root       36 Dec  7 11:20 environment -> .singularity.d/env/90-environment.sh*
# drwxr-xr-x  55 root     1.9K Dec  3 05:46 etc/
# drwxr-xr-x   3 kalavatt   60 Jan 12 11:57 fh/
# drwxr-xr-x   1 kalavatt   60 Jan 12 11:57 home/
# lrwxrwxrwx   1 root        7 Oct 19 09:47 lib -> usr/lib/
# lrwxrwxrwx   1 root        9 Oct 19 09:47 lib32 -> usr/lib32/
# lrwxrwxrwx   1 root        9 Oct 19 09:47 lib64 -> usr/lib64/
# lrwxrwxrwx   1 root       10 Oct 19 09:47 libx32 -> usr/libx32/
# drwxr-xr-x   3 kalavatt   60 Jan 12 11:57 loc/
# drwxr-xr-x   2 root        3 Oct 19 09:47 media/
# drwxr-xr-x   2 root        3 Oct 19 09:47 mnt/
# drwxr-xr-x   2 root        3 Oct 19 09:47 opt/
# dr-xr-xr-x 463 root        0 Oct 13 09:25 proc/
# drwx------   5 root      136 Dec  1 10:34 root/
# drwxr-xr-x   5 root       67 Oct 19 09:50 run/
# lrwxrwxrwx   1 root        8 Oct 19 09:47 sbin -> usr/sbin/
# lrwxrwxrwx   1 root       24 Dec  7 11:20 singularity -> .singularity.d/runscript*
# drwxr-xr-x   2 root        3 Oct 19 09:47 srv/
# dr-xr-xr-x  13 root        0 Jan 12 11:30 sys/
# drwxrwxrwt  34 root     264K Jan 12 11:59 tmp/
# drwxr-xr-x  14 root      241 Nov 30 06:37 usr/
# drwxr-xr-x  11 root      160 Oct 19 09:50 var/

cd data && ls -lhaFG
# total 6.4G
# drwxrws--- 2 kalavatt 1.8K Dec  5 13:00 ./
# drwxr-xr-x 1 kalavatt  120 Jan 12 11:57 ../
# -rw-rw---- 1 kalavatt 263M Dec  5 13:00 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 273M Dec  5 13:00 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 463M Dec  5 13:01 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 481M Dec  5 13:01 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 248M Dec  5 12:59 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 256M Dec  5 12:59 5781_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 329M Dec  5 13:00 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 343M Dec  5 13:00 5781_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 278M Dec  5 13:00 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 289M Dec  5 13:00 5782_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 453M Dec  5 13:01 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 470M Dec  5 13:01 5782_G1_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 198M Dec  5 13:00 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 205M Dec  5 13:00 5782_Q_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz
# -rw-rw---- 1 kalavatt 365M Dec  5 13:00 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz
# -rw-rw---- 1 kalavatt 379M Dec  5 13:00 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz

#  It seems to work!

which zcat
# /usr/bin/zcat

zcat \
    "5781_G1_IN_merged.trim-rcor.multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz" \
        | head
# @HISEQ:1007:HGV5NBCX3:1:1101:1194:67261
# CTTCTNATTCGATTTGCACACCNNCTGNTNTTACATCTGTGC
# +
# GGA.G#<<GGG<AGGAGGGGIG##<<<#<#<<.<AA<GGIGG
# @HISEQ:1007:HGV5NBCX3:1:1101:1197:14281
# AGATGNTTGGAATAGAGCTGACNACCANTNCAAGGACACTCATNGTTTCT
# +
# GGGGG#<GGAAGGGIAGGGIGG#<GGA#<#<<GGGGGGIIIIG#<GGGGA
# @HISEQ:1007:HGV5NBCX3:1:1101:1198:11232
# ACGAANGAAGCTTTGGACCTTTNAATTNAAAACGTCCGCAAATNCCATGC

#  It does work!

#  Exit the intra-container shell (Singularity>)
exit
# Singularity> exit
# exit
```
</details>
<br />

`#NOTE` __OK, this is the way to go about things__  
Still not clear how to address the warning message&mdash;can look into this later
<br />
