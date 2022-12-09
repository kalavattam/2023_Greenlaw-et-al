
# `work_PASA.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up and run a trial `echo` test to test the setup](#set-things-up-and-run-a-trial-echo-test-to-test-the-setup)
1. [Previous shell script for submitting genome-free `Trinity` jobs](#previous-shell-script-for-submitting-genome-free-trinity-jobs)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-things-up-and-run-a-trial-echo-test-to-test-the-setup"></a>
## Set things up and run a trial `echo` test to test the setup
```bash
#!/bin/bash
#DONTRUN



```

<a id="previous-shell-script-for-submitting-genome-free-trinity-jobs"></a>
## Previous shell script for submitting genome-free `Trinity` jobs
<details>
<summary><i>Click to view previous script, etc.</i></summary>

```bash
singularity run \
    --bind /loc/scratch \
    --bind $(pwd) \
    ~/singularity-docker-etc/PASA.sif \
        ${PASAHOME}/Launch_PASA_pipeline.pl \
            -c alignAssembly.config \
            -I 1002 \
            -C \
            -R \
            -g "${HOME}/genomes/sacCer3/Ensembl/108/DNA/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta" \
            -t transcripts.fasta.clean \
            -T \
            -u transcripts.fasta \
            --transcribed_is_aligned_orient \
            --stringent_alignment_overlap 30.0 \
            --TDN tdn.accs \
            --ALIGNERS blat,gmap \
            --CPU "${SLURM_CPUS_ON_NODE}" \
                > >(tee -a stdout.log.txt) \
                2> >(tee -a stderr.log.txt >&2)
```
