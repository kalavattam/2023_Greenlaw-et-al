
# `work_generate-data_preprocessed-rcor-only.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Create data directory](#create-data-directory)
1. [Symlink to `.fastq` files of interest](#symlink-to-fastq-files-of-interest)
1. [Remove "erroneous k-mers" from `.fastq`s with `rcorrector`](#remove-erroneous-k-mers-from-fastqs-with-rcorrector)
    1. [Run `rcorrector`](#run-rcorrector)
    1. ["Correct" the `.fastq` outfiles fr/`rcorrector`](#correct-the-fastq-outfiles-frrcorrector)
1. [Generate "processed-rcor-only" \(`rcorrector`\) `.bam`s](#generate-processed-rcor-only-rcorrector-bams)
    1. [Align the k-mer-corrected `.fastq` files](#align-the-k-mer-corrected-fastq-files)
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

grabnode  # 1 core, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd

d_exp="files_processed-rcor-only"
mkdir -p ${d_exp}/{fastq_rcor,fastq_rcor-cor,bam_rcor-cor,bam_rcor-cor_split,fastq_rcor-cor_split}
# mkdir: created directory 'files_processed-rcor-only'
# mkdir: created directory 'files_processed-rcor-only/fastq_rcor'
# mkdir: created directory 'files_processed-rcor-only/fastq_rcor-cor'
# mkdir: created directory 'files_processed-rcor-only/bam_rcor-cor'
# mkdir: created directory 'files_processed-rcor-only/bam_rcor-cor_split'
# mkdir: created directory 'files_processed-rcor-only/fastq_rcor-cor_split'
```
<br />
<br />

<a id="symlink-to-fastq-files-of-interest"></a>
## Symlink to `.fastq` files of interest
- `#DONE` See `work_generate-data_unprocessed.md`
- Files are in `${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_fastq_symlinks`
<br />
<br />

<a id="remove-erroneous-k-mers-from-fastqs-with-rcorrector"></a>
## Remove "erroneous k-mers" from `.fastq`s with `rcorrector`
<a id="run-rcorrector"></a>
### Run `rcorrector`
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core,default settings

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


#  Get the symlinked .fastq file prefixes into an array -----------------------
unset infile_prefix
typeset -a infile_prefix
while IFS=" " read -r -d $'\0'; do
    infile_prefix+=( "${REPLY%_R?.fastq}" )
done < <(\
    find "./files_fastq_symlinks" \
        -type l \
        -name "*_R?.fastq" \
        -print0 \
            | sort -z \
)

IFS=" " read -r -a infile_prefix \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infile_prefix[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# echoTest "${infile_prefix[@]}"
# echo "${#infile_prefix[@]}"


# #  Generate job submission script ---------------------------------------------
# script_name="submit_run-rcorrector.sh"
# threads=8
#
# if [[ -f "./sh_err_out/${script_name}" ]]; then
#         rm "./sh_err_out/${script_name}"
# fi
# cat << script > "./sh_err_out/${script_name}"
# #!/bin/bash
#
# #SBATCH --nodes=1
# #SBATCH --cpus-per-task=${threads}
# #SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
# #SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt
#
# #  ${script_name}
# #  KA
# #  $(date '+%Y-%m%d')
#
# read_1="\${1}"
# read_2="\${2}"
# outdir="\${3}"
# threads="\${4}"
#
# parallel --header : --colsep " " -k -j 1 echo \\
# "run_rcorrector.pl \\
#     -t {threads} \\
#     -1 {read_1} \\
#     -2 {read_2} \\
#     -od {outdir}" \\
# ::: threads "\${threads}" \\
# ::: read_1 "\${read_1}" \\
# ::: read_2 "\${read_2}" \\
# ::: outdir "\${outdir}"
#
# parallel --header : --colsep " " -k -j 1 \\
# "run_rcorrector.pl \\
#     -t {threads} \\
#     -1 {read_1} \\
#     -2 {read_2} \\
#     -od {outdir}" \\
# ::: threads "\${threads}" \\
# ::: read_1 "\${read_1}" \\
# ::: read_2 "\${read_2}" \\
# ::: outdir "\${outdir}"
# script
# # vi "./sh_err_out/${script_name}"  # :q


#  Run the jobs ---------------------------------------------------------------
script_name="submit_run-rcorrector.sh"
threads=8
storage="./${d_exp}/fastq_rcor"

count=1  # echo "${count}"
for i in "${infile_prefix[@]}"; do
    # i="${infile_prefix[0]}"  # echo "${i}"
    base=$(basename "${i}")  # echo "${base}"

    where="${storage}"  # echo "${where}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

              read_1: ${base}_R1.fastq
              read_2: ${base}_R2.fastq
             storage: ${where}
             threads: ${threads}

       read_1 (full): ${i}_R1.fastq
       read_2 (full): ${i}_R2.fastq
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    
    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
        "${i}_R1.fastq" \
        "${i}_R2.fastq" \
        "${where}" \
        "${threads}"
    sleep 0.25
    #  To avoid tripping any alarms, slow down the rate of job submission

    echo ""
    echo ""
    
    (( count++ ))
done


#  Compress the rcorrector .fq outfiles ---------------------------------------
exit  # Leave the node with 1 core, get a node with 8 cores
grabnode  # 8 cores, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd
cd ./${d_exp}/fastq_rcor \
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

<a id="correct-the-fastq-outfiles-frrcorrector"></a>
### "Correct" the `.fastq` outfiles fr/`rcorrector`
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get .fastq prefixes for k-mer-corrected files into an array ----------------
unset infile_rcor_prefix
typeset -a infile_rcor_prefix
while IFS=" " read -r -d $'\0'; do
    infile_rcor_prefix+=( "${REPLY%_R?.cor.fq.gz}" )
done < <(\
    find "./${d_exp}/fastq_rcor" \
        -type f \
        -name *.cor.fq.gz \
        -print0 \
            | sort -z \
)
# echoTest "${infile_rcor_prefix[@]}"

IFS=" " read -r -a infile_rcor_prefix \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infile_rcor_prefix[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# # echoTest "${infile_rcor_prefix[@]}"
# ./files_processed-rcor-only/fastq_rcor/5781_G1_IN_merged
# ./files_processed-rcor-only/fastq_rcor/5781_G1_IP_merged
# ./files_processed-rcor-only/fastq_rcor/5781_Q_IN_merged
# ./files_processed-rcor-only/fastq_rcor/5781_Q_IP_merged
# ./files_processed-rcor-only/fastq_rcor/5782_G1_IN_merged
# ./files_processed-rcor-only/fastq_rcor/5782_G1_IP_merged
# ./files_processed-rcor-only/fastq_rcor/5782_Q_IN_merged
# ./files_processed-rcor-only/fastq_rcor/5782_Q_IP_merged


#  Generate job submission script ---------------------------------------------
#  First, check that we have/can access the Python script for correction of
#+ .fq outfiles from rcorrector
if [[ -f "../../bin/filter_rCorrector-treated-fastqs.py" ]]; then
	echo TRUE
else
	echo FALSE
fi
# TRUE


#  Run the jobs ---------------------------------------------------------------
script_name="submit_run-rcorrector-corrector.sh"
threads=1
storage="./${d_exp}/fastq_rcor-cor"  # ., "${storage}"
correction_script="../../bin/filter_rCorrector-treated-fastqs.py"  # ., "${correction_script}"

count=1  # echo "${count}"
for i in "${infile_rcor_prefix[@]}"; do
    # i="${infile_rcor_prefix[0]}"  # echo "${i}"
    base=$(basename "${i}")  # echo "${base}"

    where="${storage}"  # echo "${where}"

    #  Report the iteration we're on with relevant information
    echo "# ----------------------------------------"
    message="""Submitting iteration ${count} of ${script_name}

    correction script: $(basename "${correction_script}")
               read_1: ${base}_R1.cor.fq.gz
               read_2: ${base}_R2.cor.fq.gz
            sample ID: ${base}
              storage: ${where}
              threads: ${threads}

    correction script (full): ${correction_script}
               read_1 (full): ${i}_R1.cor.fq.gz
               read_2 (full): ${i}_R2.cor.fq.gz
    """
    echo "${message}"

    #  Make storage directories if they don't exist
    if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
    
    # #  Echo test
	# bash "./sh_err_out/${script_name}" \
	#     "${correction_script}" \
    #     "${i}_R1.cor.fq.gz" \
    #     "${i}_R2.cor.fq.gz" \
    #     "${base}" \
    #     "${where}"

    #  Submit the job
    sbatch "./sh_err_out/${script_name}" \
		"${correction_script}" \
        "${i}_R1.cor.fq.gz" \
        "${i}_R2.cor.fq.gz" \
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
#DEKHO #PICKBACKUP
mv -- *.txt "${storage}"


#  Rename the outfiles from "rcorrector correction" ---------------------------
#  Remove the new prefix, change the suffix to reflect the recent processing
#TODO 1/2 Change filter_rCorrector-treated-fastqs.py so that no prefix is added
#TODO 2/2 and, instead, the suffix is changed
unset infile_rcor_cor
typeset -a infile_rcor_cor
while IFS=" " read -r -d $'\0'; do
    infile_rcor_cor+=( "${REPLY}" )
done < <(\
    find "./${d_exp}/fastq_rcor-cor" \
        -type f \
        -name unfixrm.*.cor.fq.gz \
        -print0 \
            | sort -z \
)
echoTest "${infile_rcor_cor[@]}"
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_G1_IN_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_G1_IN_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_G1_IP_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_G1_IP_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_Q_IN_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_Q_IN_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_Q_IP_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5781_Q_IP_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_G1_IN_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_G1_IN_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_G1_IP_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_G1_IP_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_Q_IN_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_Q_IN_merged_R2.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_Q_IP_merged_R1.cor.fq.gz
# ./files_processed-rcor-only/fastq_rcor-cor/unfixrm.5782_Q_IP_merged_R2.cor.fq.gz

which rename
# /home/kalavatt/miniconda3/envs/Trinity_env/bin/rename

#  Test...
for i in "${infile_rcor_cor[@]}"; do
	echo "# ----------------------------------------"
	rename -n 's/unfixrm.//g' "${i}"
	rename -n 's/.cor.fq.gz/.unfixrm.cor.fq.gz/g' "${i}"
	echo ""
done

#  Rename things: Part 1
for i in "${infile_rcor_cor[@]}"; do
	rename 's/.cor.fq.gz/.unfixrm.cor.fq.gz/g' "${i}"
done

#  Rename things: Part 2
for i in "${infile_rcor_cor[@]}"; do
	rename 's/unfixrm.57/57/g' "${i%.cor.fq.gz}.unfixrm.cor.fq.gz"
done
```
<br />
<br />

<a id="generate-processed-rcor-only-rcorrector-bams"></a>
## Generate "processed-rcor-only" (`rcorrector`) `.bam`s
<a id="align-the-k-mer-corrected-fastq-files"></a>
### Align the k-mer-corrected `.fastq` files
`#DEKHO`
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Get .fastq-file prefixes for corrected rcor files into an array ------------
d_exp="files_processed-rcor-only"

unset infile_rcor_cor
typeset -a infile_rcor_cor
while IFS=" " read -r -d $'\0'; do
    infile_rcor_cor+=( "${REPLY%_R?.unfixrm.cor.fq.gz}" )
done < <(\
    find "./${d_exp}/fastq_rcor-cor" \
        -type f \
        -name *.unfixrm.cor.fq.gz \
        -print0 \
            | sort -z \
)

IFS=" " read -r -a infile_rcor_cor \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infile_rcor_cor[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echoTest "${infile_rcor_cor[@]}"
# ./files_processed-rcor-only/fastq_rcor-cor/5781_G1_IN_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5781_G1_IP_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5781_Q_IN_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5781_Q_IP_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5782_G1_IN_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5782_G1_IP_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5782_Q_IN_merged
# ./files_processed-rcor-only/fastq_rcor-cor/5782_Q_IP_merged


#  Generate the job submission scripts ----------------------------------------
#NOTE Can't use previous scripts! They can't handle gzipped files
#DONE Write new scripts with STAR argument --readFilesCommand zcat
threads=8
for i in 1 5 10 15 50 100 1000; do
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
storage="./${d_exp}/bam_rcor-cor"  # ., "${storage}"

count=1
for i in "${infile_rcor_cor[@]}"; do
    for j in 1 5 10 15 50 100 1000; do
        for k in "Local" "EndToEnd"; do
            # j=1
            # k="Local"
            script_name="submit_align_multi-hit-mode_${j}_${k}.sh"  # echo "${script_name}"
            pre="$(basename "${i}").rcor"  # echo "${pre}"
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
                    read_1: ${i}_R1.unfixrm.cor.fq.gz
                    read_2: ${i}_R2.unfixrm.cor.fq.gz
                    prefix: ${where_etc}
                genome_dir: ${genome_dir}
            alignment mode: ${k}
            """
			echo "${message}"

            #  Make storage directories if they don't exist
            if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
            
            # #  Echo test
            # bash "./sh_err_out/${script_name}" \
            #     "${i}_R1.unfixrm.cor.fq.gz" \
            #     "${i}_R2.unfixrm.cor.fq.gz" \
            #     "${where_etc}" \
            #     "${genome_dir}"
            
            #  Submit the job
            sbatch "./sh_err_out/${script_name}" \
                "${i}_R1.unfixrm.cor.fq.gz" \
                "${i}_R2.unfixrm.cor.fq.gz" \
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

grabnode  # 16 cores, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Clean up results of STAR alignment -----------------------------------------
d_exp="files_processed-rcor-only"

#  stackoverflow.com/questions/16541582/find-multiple-files-and-rename-them-in-linux
find "./${d_exp}/bam_rcor-cor" \
	-iname "*Aligned.sortedByCoord.out.bam" \
	-exec rename 's/Aligned./.Aligned./g' '{}' \;

find "./${d_exp}/bam_rcor-cor" \
	-iname "*Log.*" \
	-exec rename 's/Log./.Log./g' '{}' \;

find "./${d_exp}/bam_rcor-cor" \
	-iname "*SJ.*" \
	-exec rename 's/SJ./.SJ./g' '{}' \;

#  stackoverflow.com/questions/2810838/finding-empty-directories
cd ./${d_exp}/bam_rcor-cor
find . -depth -type d -empty -delete

#  Get back to the main working directory
mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find "./${d_exp}/bam_rcor-cor" \
        -type f \
        -name *rcor.*.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Run samtools index on each element of .bam array ---------------------------
for i in "${infiles_mapped[@]}"; do
    # echo "samtools index -@ 8 \"${i}\""
    samtools index -@ 16 "${i}"
done
```

<a id="filter-out-non-s-cerevisiae-alignments"></a>
### Filter out non-*S. cerevisiae* alignments
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Create an array for .bam files of interest ---------------------------------
d_exp="files_processed-rcor-only"

unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find "./${d_exp}/bam_rcor-cor" \
        -type f \
        -name *rcor.*.Aligned.sortedByCoord.out.bam \
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
storage="./${d_exp}/bam_rcor-cor_split"  # ., "${storage}"
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

grabnode  # 16 cores, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Create an array for .bam files of interest ---------------------------------
d_exp="files_processed-rcor-only"

unset infiles_mapped_sc
while IFS=" " read -r -d $'\0'; do
    infiles_mapped_sc+=( "${REPLY}" )
done < <(\
    find "./${d_exp}/bam_rcor-cor_split" \
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
    samtools index -@ 16 "${i}"
done
```
<br />
<br />

<a id="convert-_multi-hit-mode_1_bams-back-to-fastqs"></a>
## Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s
Convert the the k-mer-corrected, non-multi-hit-mode (i.e., those with the substring "`_multi-hit-mode_1_`"), *S. cerevisiae*-filtered `.bam`s to .`fastq`s
```bash
#!/bin/bash
#DONTRUN

grabnode  # 1 core, default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd


#  Create an array for .bam files of interest ---------------------------------
d_exp="files_processed-rcor-only"

unset infiles_multi_1_sc
while IFS=" " read -r -d $'\0'; do
    infiles_multi_1_sc+=( "${REPLY}" )
done < <(\
    find "./${d_exp}/bam_rcor-cor_split" \
        -type f \
        -name *rcor.multi-hit-mode_1_*.sc_all.bam \
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
storage="./${d_exp}/fastq_rcor-cor_split"  # ., "${storage}"

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
