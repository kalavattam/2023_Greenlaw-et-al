
# `work_generate-data_preprocessed-full.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Create data directory](#create-data-directory)
1. [Symlink to `.fastq` files of interest](#symlink-to-fastq-files-of-interest)
1. [Symlink to trimmed `.fastq` files of interest](#symlink-to-trimmed-fastq-files-of-interest)
1. [Remove "erroneous k-mers" from trimmed `.fastq`s with `rcorrector`](#remove-erroneous-k-mers-from-trimmed-fastqs-with-rcorrector)
    1. [Run `rcorrector`](#run-rcorrector)
    1. ["Correct" the `.fastq` outfiles fr/`rcorrector`](#correct-the-fastq-outfiles-frrcorrector)
1. [Generate "processed-full" \(`trim_galore`, `rcorrector`\) `.bam`s](#generate-processed-full-trim_galore-rcorrector-bams)
    1. [Align the adapter-/quality-trimmed, k-mer-corrected `.fastq` files](#align-the-adapter-quality-trimmed-k-mer-corrected-fastq-files)
    1. [Clean up results of `STAR` alignment, index `.bam`s](#clean-up-results-of-star-alignment-index-bams)
    1. [Filter out non-*S. cerevisiae* alignments](#filter-out-non-s-cerevisiae-alignments)
    1. [Index the *S. cerevisiae*-only `.bam`s](#index-the-s-cerevisiae-only-bams)
1. [Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s](#convert-_multi-hit-mode_1_bams-back-to-fastqs)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="create-data-directory"></a>
## Create data directory
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd

mkdir -p files_processed-full/{fastq_trim,fastq_trim-rcor,fastq_trim-rcor-cor,bam_trim-rcor-cor,bam_trim-rcor-cor_split,fastq_trim-rcor-cor_split}
# mkdir: created directory 'files_processed-full'
# mkdir: created directory 'files_processed-full/fastq_trim'
# mkdir: created directory 'files_processed-full/fastq_trim-rcor'
# mkdir: created directory 'files_processed-full/fastq_trim-rcor-cor'
# mkdir: created directory 'files_processed-full/bam_trim-rcor-cor'
# mkdir: created directory 'files_processed-full/bam_trim-rcor-cor_split'
# mkdir: created directory 'files_processed-full/fastq_trim-rcor-cor_split'
```
<br />
<br />

<a id="symlink-to-fastq-files-of-interest"></a>
## Symlink to `.fastq` files of interest
- `#DONE` See `work_generate-data_unprocessed.md`
- Files are in `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_fastq_symlinks`
<br />
<br />

<a id="symlink-to-trimmed-fastq-files-of-interest"></a>
## Symlink to trimmed `.fastq` files of interest
- Code for performing this from scratch in `work_generate-data_processed.md`
- Symlinking to files in `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/fastq_trim`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd ./files_processed-full/fastq_trim ||
	echo "cd'ing failed; check on this"


#  Get the original trimmed .fastq files of interest into an array ------------
unset infile_trim
typeset -a infile_trim
while IFS=" " read -r -d $'\0'; do
    infile_trim+=( "${REPLY}" )
done < <(\
    find "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_processed/fastq_trim" \
        -type f \
        -name "*_R?_val_?.fq" \
        -print0 \
            | sort -z \
)
# echoTest "${infile_trim[@]}"
# echo "${#infile_trim[@]}"


#  Create symlinks to original trimmed .fastq files in "$(pwd)" ---------------
for i in "${infile_trim[@]}"; do ln -s "${i}" "./$(basename ${i})"; done

.,  # Check: Looks OK
```
<br />
<br />

<a id="remove-erroneous-k-mers-from-trimmed-fastqs-with-rcorrector"></a>
## Remove "erroneous k-mers" from trimmed `.fastq`s with `rcorrector`
<a id="run-rcorrector"></a>
### Run `rcorrector`
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

# which rcorrector
# # /home/kalavatt/miniconda3/envs/Trinity_env/bin/rcorrector
#
# which parallel
# # /home/kalavatt/miniconda3/envs/Trinity_env/bin/parallel

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get the symlinked trimmed .fastq file prefixes into an array ---------------
unset infile_trim_prefix
typeset -a infile_trim_prefix
while IFS=" " read -r -d $'\0'; do
    infile_trim_prefix+=( "${REPLY%_R?_val_?.fq}" )
done < <(\
    find "./files_processed-full/" \
        -type l \
        -name "*_R?_val_?.fq" \
        -print0 \
            | sort -z \
)

IFS=" " read -r -a infile_trim_prefix \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infile_trim_prefix[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# # echoTest "${infile_trim_prefix[@]}"
# ./files_processed-full/fastq_trim/5781_G1_IN_merged
# ./files_processed-full/fastq_trim/5781_G1_IP_merged
# ./files_processed-full/fastq_trim/5781_Q_IN_merged
# ./files_processed-full/fastq_trim/5781_Q_IP_merged
# ./files_processed-full/fastq_trim/5782_G1_IN_merged
# ./files_processed-full/fastq_trim/5782_G1_IP_merged
# ./files_processed-full/fastq_trim/5782_Q_IN_merged
# ./files_processed-full/fastq_trim/5782_Q_IP_merged

# # echo "${#infile_trim_prefix[@]}"
# 8


#  Generate job submission script ---------------------------------------------
script_name="submit_run-rcorrector.sh"
threads=8

if [[ -f "./sh_err_out/${script_name}" ]]; then
        rm "./sh_err_out/${script_name}"
fi
cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

read_1="\${1}"
read_2="\${2}"
outdir="\${3}"
threads="\${4}"

parallel --header : --colsep " " -k -j 1 echo \\
"run_rcorrector.pl \\
    -t {threads} \\
    -1 {read_1} \\
    -2 {read_2} \\
    -od {outdir}" \\
::: threads "\${threads}" \\
::: read_1 "\${read_1}" \\
::: read_2 "\${read_2}" \\
::: outdir "\${outdir}"

parallel --header : --colsep " " -k -j 1 \\
"run_rcorrector.pl \\
    -t {threads} \\
    -1 {read_1} \\
    -2 {read_2} \\
    -od {outdir}" \\
::: threads "\${threads}" \\
::: read_1 "\${read_1}" \\
::: read_2 "\${read_2}" \\
::: outdir "\${outdir}"
script
# vi "./sh_err_out/${script_name}"  # :q


#  Run the jobs ---------------------------------------------------------------
# script_name="submit_run-rcorrector.sh"  #NOTE Defined above
# threads=8  #NOTE Defined above
storage="./files_processed-full/fastq_trim-rcor"

count=1  # echo "${count}"
for i in "${infile_trim_prefix[@]}"; do
    # i="${infile_trim_prefix[0]}"  # echo "${i}"
    base=$(basename "${i}")  # echo "${base}"

    where="${storage}"  # echo "${where}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

              read_1: ${base}_R1_val_1.fq
              read_2: ${base}_R2_val_2.unfixrm.cor.fq.gz
             storage: ${where}
             threads: ${threads}

       read_1 (full): ${i}_R1_val_1.fq
       read_2 (full): ${i}_R2_val_2.unfixrm.cor.fq.gz
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    
    # #  Echo test
	# bash "./sh_err_out/${script_name}" \
    #     "${i}_R1_val_1.fq" \
    #     "${i}_R2_val_2.unfixrm.cor.fq.gz" \
    #     "${where}" \
    #     "${threads}"

    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
        "${i}_R1_val_1.fq" \
        "${i}_R2_val_2.unfixrm.cor.fq.gz" \
        "${where}" \
        "${threads}"
    sleep 0.25
    #  To avoid tripping any alarms, slow down the rate of job submission

    echo ""
    echo ""
    
    (( count++ ))
done


#  Compress the rcorrector .fq outfiles ---------------------------------------
exit
grabnode  # eight cores, default settings

Trinity_env

which pigz
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/pigz

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd
cd ./files_processed-full/fastq_trim-rcor \
	|| echo "cd'ing failed; check on this"

unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "*.fq" \
        -print0 \
            | sort -z \
)
# echoTest "${infiles[@]}"

for i in "${infiles[@]}"; do
	pigz -p "${SLURM_CPUS_ON_NODE}" "${i}"
done
```

<details>
<summary><i>Results of echo test:</i></summary>

```txt
run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5781_G1_IN_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5781_G1_IN_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5781_G1_IP_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5781_G1_IP_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5781_Q_IN_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5781_Q_IN_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5781_Q_IP_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5781_Q_IP_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5782_G1_IN_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5782_G1_IN_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5782_G1_IP_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5782_G1_IP_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5782_Q_IN_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5782_Q_IN_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor


run_rcorrector.pl -t 8 -1 ./files_processed-full/fastq_trim/5782_Q_IP_merged_R1_val_1.fq -2 ./files_processed-full/fastq_trim/5782_Q_IP_merged_R2_val_2.unfixrm.cor.fq.gz -od ./files_processed-full/fastq_trim-rcor
```
</details>
<br />

<a id="correct-the-fastq-outfiles-frrcorrector"></a>
### "Correct" the `.fastq` outfiles fr/`rcorrector`
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get .fastq-file prefixes for trimmed, k-mer-corrected files into an array --
unset infile_trim_rcor_prefix
typeset -a infile_trim_rcor_prefix
while IFS=" " read -r -d $'\0'; do
    infile_trim_rcor_prefix+=( "${REPLY%_R?_val_?.cor.fq.gz}" )
done < <(\
    find ./files_processed-full/fastq_trim-rcor \
        -type f \
        -name *.cor.fq.gz \
        -print0 \
            | sort -z \
)
# echoTest "${infile_trim_rcor_prefix[@]}"

IFS=" " read -r -a infile_trim_rcor_prefix \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infile_trim_rcor_prefix[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# # echoTest "${infile_trim_rcor_prefix[@]}"
# ./files_processed-full/fastq_trim-rcor/5781_G1_IN_merged
# ./files_processed-full/fastq_trim-rcor/5781_G1_IP_merged
# ./files_processed-full/fastq_trim-rcor/5781_Q_IN_merged
# ./files_processed-full/fastq_trim-rcor/5781_Q_IP_merged
# ./files_processed-full/fastq_trim-rcor/5782_G1_IN_merged
# ./files_processed-full/fastq_trim-rcor/5782_G1_IP_merged
# ./files_processed-full/fastq_trim-rcor/5782_Q_IN_merged
# ./files_processed-full/fastq_trim-rcor/5782_Q_IP_merged


#  Generate job submission script ---------------------------------------------
#  First, check that we have/can access the Python script for correction of
#+ .fq outfiles from rcorrector
if [[ -f "../../bin/filter_rCorrector-treated-fastqs.py" ]]; then
	echo TRUE
else
	echo FALSE
fi
# TRUE

# vi "../../bin/filter_rCorrector-treated-fastqs.py"  # :q
# python "../../bin/filter_rCorrector-treated-fastqs.py" --help  # It works
#TODO Return help and exit if missing argument(s)
#TODO 1/2 Split the work of filter_rCorrector-treated-fastqs.py over multiple
#TODO 2/2 cores if possible

#  Move on to the job-submission script
script_name="submit_run-rcorrector-corrector.sh"
threads=1

if [[ -f "./sh_err_out/${script_name}" ]]; then
        rm "./sh_err_out/${script_name}"
fi
cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

python_script="\${1}"
read_1="\${2}"
read_2="\${3}"
instring="\${4}"
outdir="\${5}"

parallel --header : --colsep " " -k -j 1 echo \\
"python {python_script} \\
     -1 {read_1} \\
     -2 {read_2} \\
     -s {instring} \\
     -o {outdir} \\
     -g True" \\
::: python_script \${python_script} \\
::: read_1 \${read_1} \\
::: read_2 \${read_2} \\
::: instring \${instring} \\
::: outdir \${outdir}

parallel --header : --colsep " " -k -j 1 \\
"python {python_script} \\
     -1 {read_1} \\
     -2 {read_2} \\
     -s {instring} \\
     -o {outdir} \\
     -g True" \\
::: python_script \${python_script} \\
::: read_1 \${read_1} \\
::: read_2 \${read_2} \\
::: instring \${instring} \\
::: outdir \${outdir}
script
# vi "./sh_err_out/${script_name}"  # :q


#  Run the jobs ---------------------------------------------------------------
# script_name="submit_run-rcorrector.sh"  #NOTE Defined above
# threads=8  #NOTE Defined above
storage="./files_processed-full/fastq_trim-rcor-cor"  # ., "${storage}"
correction_script="../../bin/filter_rCorrector-treated-fastqs.py"  # ., "${correction_script}"

count=1  # echo "${count}"
for i in "${infile_trim_rcor_prefix[@]}"; do
    # i="${infile_trim_rcor_prefix[0]}"  # echo "${i}"
    base=$(basename "${i}")  # echo "${base}"

    where="${storage}"  # echo "${where}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

    correction script: $(basename "${correction_script}")
               read_1: ${base}_R1_val_1.cor.fq.gz
               read_2: ${base}_R2_val_2.cor.fq.gz
            sample ID: ${base}
              storage: ${where}
              threads: ${threads}

    correction script (full): ${correction_script}
               read_1 (full): ${i}_R1_val_1.cor.fq.gz
               read_2 (full): ${i}_R2_val_2.cor.fq.gz
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    
    # #  Echo test
	# bash "./sh_err_out/${script_name}" \
	# 	"${correction_script}" \
    #     "${i}_R1_val_1.cor.fq.gz" \
    #     "${i}_R2_val_2.cor.fq.gz" \
    #     "${base}" \
    #     "${where}"

    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
		"${correction_script}" \
        "${i}_R1_val_1.cor.fq.gz" \
        "${i}_R2_val_2.cor.fq.gz" \
        "${base}" \
        "${where}"
    sleep 0.25
    #  To avoid tripping any alarms, slow down the rate of job submission

    echo ""
    echo ""
    
    (( count++ ))
done

#  Move *.counts.txt and *.proportions.txt files from "$(pwd)" to "${storage}"
#+ 
#+ This is the result of something that needs to be fixed in the Python script;
#+ details are included in the corresponding #TODO item below
mv *.txt "${storage}"
# renamed '5781_G1_IN_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_G1_IN_merged.counts.txt'
# renamed '5781_G1_IN_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_G1_IN_merged.proportions.txt'
# renamed '5781_G1_IP_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_G1_IP_merged.counts.txt'
# renamed '5781_G1_IP_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_G1_IP_merged.proportions.txt'
# renamed '5781_Q_IN_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_Q_IN_merged.counts.txt'
# renamed '5781_Q_IN_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_Q_IN_merged.proportions.txt'
# renamed '5781_Q_IP_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_Q_IP_merged.counts.txt'
# renamed '5781_Q_IP_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5781_Q_IP_merged.proportions.txt'
# renamed '5782_G1_IN_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_G1_IN_merged.counts.txt'
# renamed '5782_G1_IN_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_G1_IN_merged.proportions.txt'
# renamed '5782_G1_IP_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_G1_IP_merged.counts.txt'
# renamed '5782_G1_IP_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_G1_IP_merged.proportions.txt'
# renamed '5782_Q_IN_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_Q_IN_merged.counts.txt'
# renamed '5782_Q_IN_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_Q_IN_merged.proportions.txt'
# renamed '5782_Q_IP_merged.counts.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_Q_IP_merged.counts.txt'
# renamed '5782_Q_IP_merged.proportions.txt' -> './files_processed-full/fastq_trim-rcor-cor/5782_Q_IP_merged.proportions.txt'


#  Rename the outfiles from "rcorrector correction" ---------------------------
#  Remove the new prefix, change the suffix to reflect the recent processing
#TODO 1/2 Change filter_rCorrector-treated-fastqs.py so that no prefix is added
#TODO 2/2 and, instead, the suffix is changed
unset infile_trim_rcor_cor
typeset -a infile_trim_rcor_cor
while IFS=" " read -r -d $'\0'; do
    infile_trim_rcor_cor+=( "${REPLY}" )
done < <(\
    find ./files_processed-full/fastq_trim-rcor-cor \
        -type f \
        -name unfixrm.*.cor.fq.gz \
        -print0 \
            | sort -z \
)
# # echoTest "${infile_trim_rcor_cor[@]}"
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_G1_IN_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_G1_IN_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_G1_IP_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_G1_IP_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_Q_IN_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_Q_IN_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_Q_IP_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5781_Q_IP_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_G1_IN_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_G1_IN_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_G1_IP_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_G1_IP_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_Q_IN_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_Q_IN_merged_R2_val_2.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_Q_IP_merged_R1_val_1.cor.fq.gz
# ./files_processed-full/fastq_trim-rcor-cor/unfixrm.5782_Q_IP_merged_R2_val_2.cor.fq.gz

which rename
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/rename

#  Test...
for i in "${infile_trim_rcor_cor[@]}"; do
	echo "# ----------------------------------------"
	rename -n 's/unfixrm.//g' "${i}"
	rename -n 's/.cor.fq.gz/.unfixrm.cor.fq.gz/g' "${i}"
	echo ""
done

#  Rename things: Part 1
for i in "${infile_trim_rcor_cor[@]}"; do
	rename 's/.cor.fq.gz/.unfixrm.cor.fq.gz/g' "${i}"
done

#  Rename things: Part 2
for i in "${infile_trim_rcor_cor[@]}"; do
	rename 's/unfixrm.57/57/g' "${i%.cor.fq.gz}.unfixrm.cor.fq.gz"
done
```

<details>
<summary><i>Help message for filter_rCorrector-treated-fastqs.py:</i></summary>

```txt
Options for filtering, logging rCorrector fastq output

optional arguments:
  -h, --help            show this help message and exit
  -1 READS_LEFT, --reads_left READS_LEFT
                        R1 fastq infile (gzipped or not), including path
  -2 READS_RIGHT, --reads_right READS_RIGHT
                        R2 fastq infile (gzipped or not), including path
  -s SAMPLE_ID, --sample_id SAMPLE_ID
                        sample name to write to log file
  -o DIR_OUT, --dir_out DIR_OUT
                        outfile directory, including path
  -g GZIP_OUT, --gzip_out GZIP_OUT
                        write gzipped fastq outfiles (True or False)
```
</details>
<br />

<details>
<summary><i>Results of echo test:</i></summary>

```txt
python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5781_G1_IN_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5781_G1_IN_merged_R2_val_2.cor.fq.gz -s 5781_G1_IN_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5781_G1_IP_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5781_G1_IP_merged_R2_val_2.cor.fq.gz -s 5781_G1_IP_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5781_Q_IN_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5781_Q_IN_merged_R2_val_2.cor.fq.gz -s 5781_Q_IN_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5781_Q_IP_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5781_Q_IP_merged_R2_val_2.cor.fq.gz -s 5781_Q_IP_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5782_G1_IN_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5782_G1_IN_merged_R2_val_2.cor.fq.gz -s 5782_G1_IN_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5782_G1_IP_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5782_G1_IP_merged_R2_val_2.cor.fq.gz -s 5782_G1_IP_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5782_Q_IN_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5782_Q_IN_merged_R2_val_2.cor.fq.gz -s 5782_Q_IN_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True


python ../../bin/filter_rCorrector-treated-fastqs.py -1 ./files_processed-full/fastq_trim-rcor/5782_Q_IP_merged_R1_val_1.cor.fq.gz -2 ./files_processed-full/fastq_trim-rcor/5782_Q_IP_merged_R2_val_2.cor.fq.gz -s 5782_Q_IP_merged -o ./files_processed-full/fastq_trim-rcor-cor -g True
```
</details>
<br />

`#TODO` It looks as though `*counts.txt` and `*proportions.txt` from running `filter_rCorrector-treated-fastqs.py` are being saved to the current working directory; my incorrect assumption is that they'd be saved to `--dir_out DIR_OUT`; update the help message to note that the outpath must be included with the "sample name" update the Python script so that the `*counts.txt` and `*proportions.txt` outfiles are written to `--dir_out DIR_OUT` (however, this was a source of error earlier (see notebook in `results/2022-1101`), so you'll want to create some small test `.fq.gz` files in order to quickly run the `filter_rCorrector-treated-fastqs.py` over and over again while updating and testing it)

<details>

<summary><i>Look at home directory (results/2022-1201) while awaiting completion of "rcorrector correction" jobs</i></summary>

```txt
❯ .,
total 918K
drwxrws--- 7 kalavatt  978 Dec  5 09:47 ./
drwxrws--- 8 kalavatt  218 Dec  5 07:13 ../
-rw-rw---- 1 kalavatt  208 Dec  5 09:47 5781_G1_IN_merged.counts.txt
-rw-rw---- 1 kalavatt  292 Dec  5 09:47 5781_G1_IN_merged.proportions.txt
-rw-rw---- 1 kalavatt  208 Dec  5 09:45 5781_Q_IN_merged.counts.txt
-rw-rw---- 1 kalavatt  290 Dec  5 09:45 5781_Q_IN_merged.proportions.txt
-rw-rw---- 1 kalavatt  208 Dec  5 09:46 5782_G1_IN_merged.counts.txt
-rw-rw---- 1 kalavatt  292 Dec  5 09:46 5782_G1_IN_merged.proportions.txt
-rw-rw---- 1 kalavatt  207 Dec  5 09:39 5782_Q_IN_merged.counts.txt
-rw-rw---- 1 kalavatt  292 Dec  5 09:39 5782_Q_IN_merged.proportions.txt
drwxrws--- 2 kalavatt  696 Dec  3 08:57 files_fastq_symlinks/
drwxrws--- 6 kalavatt  176 Dec  5 08:06 files_processed/
drwxrws--- 8 kalavatt  273 Dec  5 08:44 files_processed-full/
drwxrws--- 5 kalavatt   77 Dec  4 18:54 files_unprocessed/
-rw-rw---- 1 kalavatt 4.3K Dec  3 15:56 links_TBD.md
-rw-rw---- 1 kalavatt   22 Dec  3 12:26 scratch.sh
drwxrws--- 3 kalavatt  792 Dec  5 09:15 sh_err_out/
-rw-rw---- 1 kalavatt  12K Dec  4 07:29 work_generate-data_alignment-calls_compare-update.md
-rw-rw---- 1 kalavatt    0 Dec  5 08:20 work_generate-data_compress-fastqs_fix-symlinks.md
-rw-rw---- 1 kalavatt  24K Dec  5 09:48 work_generate-data_preprocessed-full.md
-rw-rw---- 1 kalavatt  18K Dec  5 07:26 work_generate-data_preprocessed.md
-rw-rw---- 1 kalavatt  26K Dec  5 07:26 work_generate-data_unprocessed.md
-rw-rw---- 1 kalavatt 4.0K Dec  2 14:14 work_Trinity-PASA_unprocessed-vs-preprocessed.md

❯ skal

             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
           5291421 campus-ne submit_r kalavatt  R      31:37      1 gizmoj6 1
           5291423 campus-ne submit_r kalavatt  R      31:37      1 gizmoj6 1
           5291417 campus-ne submit_r kalavatt  R      31:40      1 gizmok88 1
           5291419 campus-ne submit_r kalavatt  R      31:40      1 gizmok88 1
           5291034 campus-ne grabnode kalavatt  R    1:23:45      1 gizmok14 1
```
</details>
<br />
<br />

<a id="generate-processed-full-trim_galore-rcorrector-bams"></a>
## Generate "processed-full" (`trim_galore`, `rcorrector`) `.bam`s
<a id="align-the-adapter-quality-trimmed-k-mer-corrected-fastq-files"></a>
### Align the adapter-/quality-trimmed, k-mer-corrected `.fastq` files
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get .fastq-file prefixes for trimmed files into an array -------------------
unset infile_trim_rcor_cor
typeset -a infile_trim_rcor_cor
while IFS=" " read -r -d $'\0'; do
    infile_trim_rcor_cor+=( "${REPLY%_R?_val_?.unfixrm.cor.fq.gz}" )
done < <(\
    find ./files_processed-full/fastq_trim-rcor-cor \
        -type f \
        -name *.unfixrm.cor.fq.gz \
        -print0 \
            | sort -z \
)

IFS=" " read -r -a infile_trim_rcor_cor \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infile_trim_rcor_cor[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# echoTest "${infile_trim_rcor_cor[@]}"
# ./files_processed-full/fastq_trim-rcor-cor/5781_G1_IN_merged
# ./files_processed-full/fastq_trim-rcor-cor/5781_G1_IP_merged
# ./files_processed-full/fastq_trim-rcor-cor/5781_Q_IN_merged
# ./files_processed-full/fastq_trim-rcor-cor/5781_Q_IP_merged
# ./files_processed-full/fastq_trim-rcor-cor/5782_G1_IN_merged
# ./files_processed-full/fastq_trim-rcor-cor/5782_G1_IP_merged
# ./files_processed-full/fastq_trim-rcor-cor/5782_Q_IN_merged
# ./files_processed-full/fastq_trim-rcor-cor/5782_Q_IP_merged


#  Generate the job submission scripts ----------------------------------------
#NOTE Can't use previous scripts! They can't handle gzipped files
#DONE Write new scripts with STAR argument --readFilesCommand zcat
for i in 1 10 100 1000; do
	for j in Local EndToEnd; do
		script_name="submit_align_multi-hit-mode_${i}_${j}.sh"

		if [[ -f "./sh_err_out/${script_name}" ]]; then
				rm "./sh_err_out/${script_name}"
		fi
cat << script > "./sh_err_out/${script_name}"
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

read_1="\${1}"
read_2="\${2}"
prefix="\${3}"
genome_dir="\${4}"

echo -e "STAR \\ \n\
    --runMode alignReads \\ \n\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\ \n\
    --outSAMtype BAM SortedByCoordinate \\ \n\
    --outSAMunmapped None \\ \n\
    --outSAMattributes All \\ \n\
    --genomeDir "\${genome_dir}" \\ \n\
    --readFilesIn "\${read_1}" "\${read_2}" \\ \n\
    --readFilesCommand zcat \\ \n\
    --outFileNamePrefix "\${prefix}" \\ \n\
    --limitBAMsortRAM 4000000000 \\ \n\
    --outFilterMultimapNmax ${i} \\ \n\
    --winAnchorMultimapNmax 1000 \\ \n\
    --alignSJoverhangMin 8 \\ \n\
    --alignSJDBoverhangMin 1 \\ \n\
    --outFilterMismatchNmax 999 \\ \n\
    --outMultimapperOrder Random \\ \n\
    --alignEndsType ${j} \\ \n\
    --alignIntronMin 4 \\ \n\
    --alignIntronMax 5000 \\ \n\
    --alignMatesGapMax 5000"

STAR \\
    --runMode alignReads \\
    --runThreadN "\${SLURM_CPUS_ON_NODE}" \\
    --outSAMtype BAM SortedByCoordinate \\
    --outSAMunmapped None \\
    --outSAMattributes All \\
    --genomeDir "\${genome_dir}" \\
    --readFilesIn "\${read_1}" "\${read_2}" \\
    --readFilesCommand zcat \\
    --outFileNamePrefix "\${prefix}" \\
    --limitBAMsortRAM 4000000000 \\
    --outFilterMultimapNmax ${i} \\
    --winAnchorMultimapNmax 1000 \\
    --alignSJoverhangMin 8 \\
    --alignSJDBoverhangMin 1 \\
    --outFilterMismatchNmax 999 \\
    --outMultimapperOrder Random \\
    --alignEndsType ${j} \\
    --alignIntronMin 4 \\
    --alignIntronMax 5000 \\
    --alignMatesGapMax 5000
script
	done
done


#  Run the jobs ---------------------------------------------------------------
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"  # ., "${genome_dir}"
threads=8  # echo "${threads}"
storage="./files_processed-full/bam_trim-rcor-cor"  # ., "${storage}"

count=1
for i in "${infile_trim_rcor_cor[@]}"; do
    for j in 1 10 100 1000; do
        for k in "Local" "EndToEnd"; do
            # j=1
            # k="Local"
            script_name="submit_align_multi-hit-mode_${j}_${k}.sh"  # echo "${script_name}"
            pre="$(basename "${i}").trim-rcor"  # echo "${pre}"
            suf=$(\
                echo "${script_name}" \
                    | awk -F "_" '{ print $3"_"$4"_"$5"_"$6 }' \
                    | awk -F "." '{ print $1 }'
            )  # echo "${suf}"
            where="${storage}/${k}/${pre}.${suf}"  # echo "${where}"
            where_etc="${where}/${pre}.${suf}"  # echo "${where_etc}"

            #  Report the iteration we're on with relevant information
            echo "# ----------------------------------------"
            message="""Submitting iteration ${count} of ${script_name}
            with the following arguments:
                    read_1: ${i}_R1_val_1.unfixrm.cor.fq.gz
                    read_2: ${i}_R2_val_2.unfixrm.cor.fq.gz
                    prefix: ${where_etc}
                genome_dir: ${genome_dir}
            alignment mode: ${k}
            """
			echo "${message}"

            #  Make storage directories if they don't exist
            if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
            
            # #  Echo test
            # bash "./sh_err_out/${script_name}" \
            #     "${i}_R1_val_1.unfixrm.cor.fq.gz" \
            #     "${i}_R2_val_2.unfixrm.cor.fq.gz" \
            #     "${where_etc}" \
            #     "${genome_dir}"
            
            #  Submit the job
            sbatch "./sh_err_out/${script_name}" \
                "${i}_R1_val_1.unfixrm.cor.fq.gz" \
                "${i}_R2_val_2.unfixrm.cor.fq.gz" \
                "${where_etc}" \
                "${genome_dir}"
            sleep 0.25
            #  To avoid tripping any alarms, slow down the rate of job submission
            
            echo ""
            echo ""
            
            (( count++ ))
        done
    done
done
```

<a id="clean-up-results-of-star-alignment-index-bams"></a>
### Clean up results of `STAR` alignment, index `.bam`s
```bash
#!/bin/bash
#DONTRUN

grabnode  # Eight cores, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Clean up results of STAR alignment -----------------------------------------
#  stackoverflow.com/questions/16541582/find-multiple-files-and-rename-them-in-linux
find ./files_processed-full/bam_trim-rcor-cor \
	-iname "*Aligned.sortedByCoord.out.bam" \
	-exec rename 's/Aligned./.Aligned./g' '{}' \;

find ./files_processed-full/bam_trim-rcor-cor \
	-iname "*Log.*" \
	-exec rename 's/Log./.Log./g' '{}' \;

find ./files_processed-full/bam_trim-rcor-cor \
	-iname "*SJ.*" \
	-exec rename 's/SJ./.SJ./g' '{}' \;

#  stackoverflow.com/questions/2810838/finding-empty-directories
cd ./files_processed-full/bam_trim-rcor-cor
find . -depth -type d -empty -delete

#  Get back to the main working directory
mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find ./files_processed-full/bam_trim-rcor-cor \
        -type f \
        -name *.trim-rcor.*.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Run samtools index on each element of .bam array ---------------------------
for i in "${infiles_mapped[@]}"; do
    # echo "samtools index -@ 8 \"${i}\""
    samtools index -@ 8 "${i}"
done
```
<br />
<br />

<a id="filter-out-non-s-cerevisiae-alignments"></a>
### Filter out non-*S. cerevisiae* alignments
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find ./files_processed-full/bam_trim-rcor-cor \
        -type f \
        -name *.trim-rcor.*.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Generate job submission script ---------------------------------------------
#  NOTE 1/2 Necessary script, "submit_split-bam.sh", was generated in
#+ NOTE 2/2 work_generate-data_unprocessed.md


#  Run the jobs ---------------------------------------------------------------
script_name="submit_split-bam.sh"  # ., "./sh_err_out/${script_name}"
threads=4
storage="./files_processed-full/bam_trim-rcor-cor_split"  # ., "${storage}"
chromosomes="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito"
split="sc_all"

count=1  # echo "${count}"
for i in "${infiles_mapped[@]}"; do
    # i="${infiles_mapped[0]}"  # ., "${i}"
    base=$(basename "${i}" .bam)  # echo "${base}"

    if [[ "${base}" == *"_EndToEnd"* ]]; then
        k="EndToEnd"
    elif [[ "${base}" == *"_Local"* ]]; then
        k="Local"
    else
        help="""
        Exiting: An error was encountered when determining STAR alignment mode;
        check on this
        """
        echo "${help}"
        # exit 1
    fi
    # echo "${k}"

    outfile="${base}.${split}.bam"  # echo "${outfile}"

    where="${storage}/${k}"  # echo "${where}"
    where_etc="${where}/${outfile}"  # echo "${where_etc}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

            bam infile: ${base}.bam
           bam outfile: ${outfile}
           chromosomes: ${chromosomes}
               storage: ${where}
               threads: ${threads}

     bam infile (full): ${i}
    bam outfile (full): ${where_etc}
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    # mkdir: created directory './files_unprocessed/bam_split'
    # mkdir: created directory './files_unprocessed/bam_split/EndToEnd'
    
    # #  Echo test
    # bash "./sh_err_out/${script_name}" \
    #     "${i}" \
    #     "${where_etc}" \
    #     "${chromosomes}" \
    #     "${threads}"
        
    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
        "${i}" \
        "${where_etc}" \
        "${chromosomes}" \
        "${threads}"
    sleep 0.25
    #  To avoid tripping any alarms, slow down the rate of job submission
    
    echo ""
    echo ""
    
    (( count++ ))
done
```

<a id="index-the-s-cerevisiae-only-bams"></a>
### Index the *S. cerevisiae*-only `.bam`s
```bash
#!/bin/bash
#DONTRUN

grabnode  # Eight cores, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_mapped_sc
while IFS=" " read -r -d $'\0'; do
    infiles_mapped_sc+=( "${REPLY}" )
done < <(\
    find ./files_processed-full/bam_trim-rcor-cor_split \
        -type f \
        -name *.sc_all.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped_sc[@]}"
# echo "${#infiles_mapped_sc[@]}"


#  Run samtools index on each element of .bam array ---------------------------
for i in "${infiles_mapped_sc[@]}"; do
    # echo "samtools index -@ 8 \"${i}\""
    samtools index -@ 8 "${i}"
done
```
<details>
<summary><i>Note on files that took a long time to filter to include only S. cerevisiae chromosomes</i></summary>

```txt
Interestingly, it took a very long time for the following to complete:
- 5781_G1_IN_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam
- 5781_G1_IP_merged.trim-rcor.multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam

These also took a long time to complete:
- 5782_G1_IP_merged.trim-rcor.multi-hit-mode_100_Local.Aligned.sortedByCoord.out.sc_all.bam
- 5782_Q_IP_merged.trim-rcor.multi-hit-mode_1_Local.Aligned.sortedByCoord.out.sc_all.bam
```
</details>
<br />
<br />

<a id="convert-_multi-hit-mode_1_bams-back-to-fastqs"></a>
## Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s
Convert the the adapter-/quality-trimmed, k-mer-correct, non-multi-hit-mode (i.e., those with the substring "`_multi-hit-mode_1_`"), *S. cerevisiae*-filtered `.bam`s to .`fastq`s
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_multi_1_sc
while IFS=" " read -r -d $'\0'; do
    infiles_multi_1_sc+=( "${REPLY}" )
done < <(\
    find ./files_processed-full/bam_trim-rcor-cor_split \
        -type f \
        -name *.trim-rcor.multi-hit-mode_1_*.sc_all.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_multi_1_sc[@]}"
# echo "${#infiles_multi_1_sc[@]}"


#  Generate job submission script ---------------------------------------------
#  NOTE 1/2 Necessary script, "submit_convert-bam-fastq.sh", was generated in
#+ NOTE 2/2 work_generate-data_unprocessed.md


#  Run the jobs ---------------------------------------------------------------
script_name="submit_convert-bam-fastq.sh"
threads=4
storage="./files_processed-full/fastq_trim-rcor-cor_split"  # ., "${storage}"

count=1  # echo "${count}"
for i in "${infiles_multi_1_sc[@]}"; do
    # i="${infiles_multi_1_sc[0]}"  # echo "${i}"
    base=$(basename "${i}" .bam)  # echo "${base}"

    if [[ "${base}" == *"_EndToEnd"* ]]; then
        k="EndToEnd"
    elif [[ "${base}" == *"_Local"* ]]; then
        k="Local"
    else
        help="""
        Exiting: An error was encountered when determining STAR alignment mode;
        check on this
        """
        echo "${help}"
        # exit 1
    fi
    # echo "${k}"

    where="${storage}/${k}"  # echo "${where}"
    where_etc="${where}/${base}"  # echo "${where_etc}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

          bam infile: ${base}.bam
    fastq outfile #1: ${base}.1.fq.gz
    fastq outfile #2: ${base}.2.fq.gz
             storage: ${where}
             threads: ${threads}

          bam infile (full): ${i}
    fastq outfile #1 (full): ${where_etc}.1.fq.gz
    fastq outfile #2 (full): ${where_etc}.2.fq.gz
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    # mkdir: created directory './files_unprocessed/fastq_split'
    # mkdir: created directory './files_unprocessed/fastq_split/EndToEnd'
    
    # #  Echo test
    # bash "./sh_err_out/${script_name}" \
    #     "${i}" \
    #     "${where_etc}" \
    #     "${threads}"
        
    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
        "${i}" \
        "${where_etc}" \
        "${threads}"
    sleep 0.25
    #  To avoid tripping any alarms, slow down the rate of job submission
    
    echo ""
    echo ""
    
    (( count++ ))
done
```
<br />
<br />

<details>
<summary><i>Code snippets for checking on jobs</i></summary>

```bash
list_running_IDs() {
    squeue -h -u "$(whoami)" \
        | tr -s ' ' \
        | sed 's/^ //g' \
        | tr ' ' '\t' \
        | cut -f 1,5 \
        | awk -F '\t' '{ $2 = R; print }'
}


alias count_running="list_running_IDs | wc -l"
```
</details>
<br />
