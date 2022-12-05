
# `work_generate-data_preprocessed.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Symlink to `.fastq` files of interest](#symlink-to-fastq-files-of-interest)
1. [Perform adapter and quality trimming of the `.fastq`s](#perform-adapter-and-quality-trimming-of-the-fastqs)
1. [Generate "unprocessed `.bam`s"](#generate-unprocessed-bams)
    1. [Align the adapter- and quality-trimmed `.fastq` files](#align-the-adapter--and-quality-trimmed-fastq-files)
    1. [Clean up results of `STAR` alignment, index `.bam`s](#clean-up-results-of-star-alignment-index-bams)
    1. [Filter out non-*S. cerevisiae* alignments](#filter-out-non-s-cerevisiae-alignments)
    1. [Index the *S. cerevisiae*-only `.bam`s](#index-the-s-cerevisiae-only-bams)
1. [Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s](#convert-_multi-hit-mode_1_bams-back-to-fastqs)

<!-- /MarkdownTOC -->

</details>
<br />

<a id="symlink-to-fastq-files-of-interest"></a>
## Symlink to `.fastq` files of interest
- `#DONE` See `work_generate-data_unprocessed.md`
- Files are in `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_fastq_symlinks`
<br />
<br />

<a id="perform-adapter-and-quality-trimming-of-the-fastqs"></a>
## Perform adapter and quality trimming of the `.fastq`s
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


#  Get fastq file prefixes into an array --------------------------------------
unset infile_bases
typeset -a infile_bases
while IFS=" " read -r -d $'\0'; do
    infile_bases+=( "${REPLY%_R?.fastq}" )
done < <(\
    find "files_fastq_symlinks" \
        -type l \
        -name *.fastq \
        -print0 \
            | sort -z \
)
# echoTest "${infile_bases[@]}"

IFS=" " read -r -a infile_bases \
	<<< "$(\
		tr ' ' '\n' \
			<<< "${infile_bases[@]}" \
				| sort -u \
				| tr '\n' ' '\
	)"
# echoTest "${infile_bases[@]}"


#  Generate job submission script ---------------------------------------------
script_name="submit_trim-fastqs.sh"
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

instring="\${1}"
outdir="\${2}"

#  Echo test
parallel --header : --colsep " " -k -j 1 echo -e \\
"trim_galore \\
    --paired \\
    --retain_unpaired \\
    --phred33 \\
    --output_dir {outdir} \\
    --length 36 \\
    --quality 5 \\
    --stringency 1 \\
    -e 0.1 \\
    {sample}_R1.fastq \\
    {sample}_R2.fastq" \\
::: sample "\${instring}" \\
::: outdir "\${outdir}"

#  Run trim_galore
parallel --header : --colsep " " -k -j 1 \\
"trim_galore \\
    --paired \\
    --retain_unpaired \\
    --phred33 \\
    --output_dir {outdir} \\
    --length 36 \\
    --quality 5 \\
    --stringency 1 \\
    -e 0.1 \\
    {sample}_R1.fastq \\
    {sample}_R2.fastq" \\
::: sample "\${instring}" \\
::: outdir "\${outdir}"

echo ""
script


#  Run the jobs ---------------------------------------------------------------
# script_name="submit_trim-fastqs.sh"  #NOTE Defined 
# threads=1  #NOTE Defined 
storage="./files_processed/fastq_trim"

count=1  # echo "${count}"
for i in "${infile_bases[@]}"; do
    # i="${infile_bases[0]}"  # echo "${i}"
    base=$(basename "${i}")  # echo "${base}"

    where="${storage}"  # echo "${where}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

            instring: ${base}
           outstring: ${base}
             storage: ${where}
             threads: ${threads}

     instring (full): ${i}
    outstring (full): ${where}/${base}
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    # mkdir: created directory './files_processed'
	# mkdir: created directory './files_processed/fastq_trim'
    
    # #  Echo test
    # bash "./sh_err_out/${script_name}" \
    #     "${i}" \
    #     "${where}"
        
    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
        "${i}" \
        "${where}"
    sleep 0.25
    #  To avoid tripping any alarms, slow down the rate of job submission
    
    echo ""
    echo ""
    
    (( count++ ))
done
```

<details>
<summary><i>Results of echo test:</i></summary>

```txt
trim_galore --paired --retain_unpaired --phred33 --output_dir ./files_processed/fastq_trim --length 36 --quality 5 --stringency 1 -e 0.1 files_fastq_symlinks/5781_G1_IN_merged_R1.fastq files_fastq_symlinks/5781_G1_IN_merged_R2.fastq
```
</details>
<br />
<br />

<a id="generate-unprocessed-bams"></a>
## Generate "unprocessed `.bam`s"
<a id="align-the-adapter--and-quality-trimmed-fastq-files"></a>
### Align the adapter- and quality-trimmed `.fastq` files
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
unset infiles_fastq_trimmed
typeset -a infiles_fastq_trimmed
while IFS=" " read -r -d $'\0'; do
    infiles_fastq_trimmed+=( "${REPLY%_R?_val_?.fq}" )
done < <(\
    find ./files_processed/fastq_trim \
        -type f \
        -name *_R?_val_?.fq \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_fastq_trimmed[@]}"

IFS=" " read -r -a infiles_fastq_trimmed \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infiles_fastq_trimmed[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# # echoTest "${infiles_fastq_trimmed[@]}"
# ./files_processed/fastq_trim/5781_G1_IN_merged
# ./files_processed/fastq_trim/5781_G1_IP_merged
# ./files_processed/fastq_trim/5781_Q_IN_merged
# ./files_processed/fastq_trim/5781_Q_IP_merged
# ./files_processed/fastq_trim/5782_G1_IN_merged
# ./files_processed/fastq_trim/5782_G1_IP_merged
# ./files_processed/fastq_trim/5782_Q_IN_merged
# ./files_processed/fastq_trim/5782_Q_IP_merged


#  Generate the job submission scripts ----------------------------------------
#NOTE 1/2 Script "submit_align_un_multi-hit-mode_${i}_${j}.sh" was generated in
#NOTE 2/2 work_generate-data_unprocessed.md


#  Run the jobs ---------------------------------------------------------------
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"
threads=8
storage="./files_processed/bam_trim"

count=1
for i in "${infiles_fastq_trimmed[@]}"; do
    for j in 1 10 100 1000; do
        for k in "Local" "EndToEnd"; do
            # j=1
            # k="Local"
            script_name="submit_align_un_multi-hit-mode_${j}_${k}.sh"
            pre="$(basename "${i}").trim"  # echo "${pre}"
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
                    read_1: ${i}_R1_val_1.fq
                    read_2: ${i}_R2_val_2.fq
                    prefix: ${where_etc}
                genome_dir: ${genome_dir}
            alignment mode: ${k}
            """
			echo "${message}"

            #  Make storage directories if they don't exist
            if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
            
            # #  Echo test
            # bash "./sh_err_out/${script_name}" \
            #     "${i}_R1_val_1.fq" \
            #     "${i}_R2_val_2.fq" \
            #     "${where_etc}" \
            #     "${genome_dir}"
            
            #  Submit the job
            sbatch "./sh_err_out/${script_name}" \
                "${i}_R1_val_1.fq" \
                "${i}_R2_val_2.fq" \
                "${where_etc}" \
                "${genome_dir}"
            
            #  To avoid tripping any alarms, slow down the rate of job
            #+ submission
            sleep 0.25
            
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

grabnode  # Four cores and default settings

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
find ./files_processed -iname "*Aligned.sortedByCoord.out.bam" -exec rename 's/Aligned./.Aligned./g' '{}' \;
find ./files_processed -iname "*Log.*" -exec rename 's/Log./.Log./g' '{}' \;
find ./files_processed -iname "*SJ.*" -exec rename 's/SJ./.SJ./g' '{}' \;

#  stackoverflow.com/questions/2810838/finding-empty-directories
cd files_processed/bam_trim
find . -depth -type d -empty -delete

#  Get back to the main working directory
mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find ./files_processed \
        -type f \
        -name *.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Run samtools index on each element of .bam array ---------------------------
for i in "${infiles_mapped[@]}"; do
    # echo "samtools index -@ 4 \"${i}\""
    samtools index -@ 4 "${i}"
done
```

`#DEKHO`
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
    find ./files_processed \
        -type f \
        -name *.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Generate job submission script ---------------------------------------------
#  NOTE 1/2 Necessary script, "submit_split-bam.sh", was generated in
#+ NOTE 2/2 work_generate-data_unprocessed.md


#  Run the jobs ---------------------------------------------------------------
script_name="submit_split-bam.sh"
threads=4
storage="./files_processed/bam_trim_split"  # ., "${storage}"
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
    find ./files_processed \
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
<br />
<br />

<a id="convert-_multi-hit-mode_1_bams-back-to-fastqs"></a>
## Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s
Convert the the adapter-/quality-trimmed, non-multi-hit-mode (i.e., those with the substring "`_multi-hit-mode_1_`"), *S. cerevisiae*-filtered `.bam`s to .`fastq`s
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
    find ./files_processed \
        -type f \
        -name *_multi-hit-mode_1_*.sc_all.bam \
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
storage="./files_processed/fastq_trim_split"

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
