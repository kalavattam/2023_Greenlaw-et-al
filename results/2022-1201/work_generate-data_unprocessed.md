
# `work_generate-data_unprocessed.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Symlink to `.fastq` files of interest](#symlink-to-fastq-files-of-interest)
1. [Align `.fastq`s to generate "unprocessed `.bam`s"](#align-fastqs-to-generate-unprocessed-bams)
    1. [Set up a directory for unprocessed `.fastq`s and `.bam`s](#set-up-a-directory-for-unprocessed-fastqs-and-bams)
1. [Generate "unprocessed `.bam`s"](#generate-unprocessed-bams)
    1. [Perform the initial alignment](#perform-the-initial-alignment)
    1. [Clean up results of `STAR` alignment, index `.bam`s](#clean-up-results-of-star-alignment-index-bams)
    1. [Filter out non-*S. cerevisiae* alignments](#filter-out-non-s-cerevisiae-alignments)
    1. [Index the *S. cerevisiae*-only `.bam`s](#index-the-s-cerevisiae-only-bams)
1. [Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s](#convert-_multi-hit-mode_1_bams-back-to-fastqs)
1. [Rough-draft: Limit number of jobs submitted to `SLURM`](#rough-draft-limit-number-of-jobs-submitted-to-slurm)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="symlink-to-fastq-files-of-interest"></a>
## Symlink to `.fastq` files of interest
```bash
#!/bin/bash
#DONTRUN

# grabnode  # Can do this on rhino

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201"

#NOTE 1/2 Base directory containing subdirectories with original merged .fastq
#NOTE 2/2 files: "${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot"

#  Get the .fastq files into an array we can loop over
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find ${HOME}/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot \
        -type f \
        -name *578*merged*fastq* \
        -print0 \
            | sort -z \
)
# echoTest "${infiles[@]}"
# for i in "${infiles[@]}"; do echo "$(basename "${i}")"; done

#  Make symlinks to the .fastq files in 2022_transcriptome-contructions results
mkdir -p \
	"${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_fastq_symlinks"

for i in "${infiles[@]}"; do
    ln -s \
        "${i}" \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_fastq_symlinks/$(basename ${i})"
done

#  Check on things
., files_fastq_symlinks

```

<details>
<summary><i>., files_fastq_symlinks</i></summary>

```txt
total 544K
drwxrws--- 2 kalavatt 696 Dec  3 08:57 ./
drwxrws--- 3 kalavatt 302 Dec  3 08:57 ../
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5781_G1_IN_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5781_G1_IN_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IN/5781_G1_IN_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5781_G1_IP_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5781_G1_IP_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_G1_IP/5781_G1_IP_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5781_Q_IN_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5781_Q_IN_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IN/5781_Q_IN_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5781_Q_IP_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5781_Q_IP_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5781_Q_IP/5781_Q_IP_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5782_G1_IN_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5782_G1_IN_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IN/5782_G1_IN_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5782_G1_IP_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 105 Dec  3 08:57 5782_G1_IP_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_G1_IP/5782_G1_IP_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5782_Q_IN_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5782_Q_IN_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IN/5782_Q_IN_merged_R2.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5782_Q_IP_merged_R1.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_merged_R1.fastq
lrwxrwxrwx 1 kalavatt 103 Dec  3 08:57 5782_Q_IP_merged_R2.fastq -> /home/kalavatt/tsukiyamalab/alisong/WTQvsG1/Project_ccucinot/Sample_5782_Q_IP/5782_Q_IP_merged_R2.fastq
```
</details>
<br />
<br />

<a id="align-fastqs-to-generate-unprocessed-bams"></a>
## Align `.fastq`s to generate "unprocessed `.bam`s"
`#NOTE` Alignment will result in unprocessed `.bam` files (unprocessed `.fastq` files are available in `results/2022-1201/files_fastq_symlinks/`)

<a id="set-up-a-directory-for-unprocessed-fastqs-and-bams"></a>
### Set up a directory for unprocessed `.fastq`s and `.bam`s
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

.,
total 454K
# drwxrws--- 3 kalavatt  462 Dec  3 12:26 ./
# drwxrws--- 8 kalavatt  218 Dec  3 08:14 ../
# drwxrws--- 2 kalavatt  696 Dec  3 08:57 files_fastq_symlinks/
# -rw-rw---- 1 kalavatt   22 Dec  3 12:26 scratch.sh
# -rw-rw---- 1 kalavatt  39K Dec  2 13:16 work_fix-errors_2022-1101.md
# -rw-rw---- 1 kalavatt 4.2K Dec  3 12:26 work_preprocess_alignment-calls_compare-update.md
# -rw-rw---- 1 kalavatt 4.6K Dec  3 12:42 work_preprocessing_generate-un-and-preprocessed-data.md
# -rw-rw---- 1 kalavatt 4.0K Dec  2 14:14 work_Trinity-PASA_unprocessed-vs-preprocessed.md

#  Make the directories
mkdir -p files_unprocessed/bam/{Local,EndToEnd}
```
<br />
<br />

<a id="generate-unprocessed-bams"></a>
## Generate "unprocessed `.bam`s"
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Make a directory to store submission scripts and also capture STDERR, STDOUT
#+ .txt files
mkdir -p sh_err_out/err_out
```

<a id="perform-the-initial-alignment"></a>
### Perform the initial alignment
```bash
#!/bin/bash
#DONTRUN #CONTINUE


#  Establish variables, arrays, etc. ------------------------------------------
unset infiles_fastq_unprocessed
typeset -a infiles_fastq_unprocessed
while IFS=" " read -r -d $'\0'; do
    infiles_fastq_unprocessed+=( "${REPLY%_R?.fastq}" )
done < <(\
    find ./files_fastq_symlinks \
        -type l \
        -name *.fastq \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_fastq_unprocessed[@]}"

IFS=" " read -r -a infiles_fastq_unprocessed \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${infiles_fastq_unprocessed[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
# # echoTest "${infiles_fastq_unprocessed[@]}"
# ./files_fastq_symlinks/5781_G1_IN_merged
# ./files_fastq_symlinks/5781_G1_IP_merged
# ./files_fastq_symlinks/5781_Q_IN_merged
# ./files_fastq_symlinks/5781_Q_IP_merged
# ./files_fastq_symlinks/5782_G1_IN_merged
# ./files_fastq_symlinks/5782_G1_IP_merged
# ./files_fastq_symlinks/5782_Q_IN_merged
# ./files_fastq_symlinks/5782_Q_IP_merged


#  Generate the job submission scripts ----------------------------------------
for i in 1 10 100 1000; do
	for j in Local EndToEnd; do
		script_name="submit_align_un_multi-hit-mode_${i}_${j}.sh"

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
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"
threads=8
storage="./files_unprocessed/bam"

count=1
for i in "${infiles_fastq_unprocessed[@]}"; do
    for j in 1 10 100 1000; do
        for k in "Local" "EndToEnd"; do
            # j=1
            # k="Local"
            script_name="submit_align_un_multi-hit-mode_${j}_${k}.sh"
            pre=$(basename "${i}")
            suf=$(\
                echo "${script_name}" \
                    | awk -F "_" '{ print $3"_"$4"_"$5"_"$6 }' \
                    | awk -F "." '{ print $1 }'
            )
            where="${storage}/${k}/${pre}.${suf}"
            where_etc="${where}/${pre}.${suf}"

            #  Report the iteration we're on with relevant information
            echo "# ----------------------------------------"
            message="""Submitting iteration ${count} of ${script_name}
            with the following arguments:
                    read_1: ${i}_R1.fastq
                    read_2: ${i}_R2.fastq
                    prefix: ${where_etc}
                genome_dir: ${genome_dir}
            alignment mode: ${k}
            """
			echo "${message}"

            #  Make storage directories if they don't exist
            if [[ ! -d "${where}" ]]; then mkdir "${where}"; fi
            
            # #  Echo test
            # bash "./sh_err_out/${script_name}" \
            #     "${i}_R1.fastq" \
            #     "${i}_R1.fastq" \
            #     "${where_etc}" \
            #     "${genome_dir}"
            
            #  Submit the job
            sbatch "./sh_err_out/${script_name}" \
                "${i}_R1.fastq" \
                "${i}_R2.fastq" \
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

grabnode  # Lowest and default settings

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
find . -iname "*Aligned.sortedByCoord.out.bam" -exec rename 's/Aligned./.Aligned./g' '{}' \;
find . -iname "*Log.*" -exec rename 's/Log./.Log./g' '{}' \;
find . -iname "*SJ.*" -exec rename 's/SJ./.SJ./g' '{}' \;

# stackoverflow.com/questions/2810838/finding-empty-directories
cd files_unprocessed/bam
find . -depth -type d -empty -delete

#  Get back to the main working directory
mwd


#  Create an array for .bam files of interest ---------------------------------
unset infiles_mapped
while IFS=" " read -r -d $'\0'; do
    infiles_mapped+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name *.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Run samtools index on each element of .bam array ---------------------------
for i in "${infiles_mapped[@]}"; do
    # echo "samtools index \"${i}\""
    samtools index "${i}"
done
```

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
    find . \
        -type f \
        -name *.Aligned.sortedByCoord.out.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped[@]}"
# echo "${#infiles_mapped[@]}"


#  Generate job submission script ---------------------------------------------
script_name="submit_split-bam.sh"
threads=4

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

split_with_samtools() {
    what="""
    split_with_samtools()
    ---------------------
    Use samtools to filter a bam file such that it contains only specified
    chromosome(s)

    :param 1: threads <int >= 1>
    :param 2: bam infile, including path <chr>
    :param 3: chromosomes to retain <chr>
    :param 4: bam outfile, including path <chr>
    :return: param 2 filtered to include only param 3 in param 4
    """
    samtools view -@ "\${1}" -h "\${2}" \${3} -o "\${4}"
}


infile="\${1}"
outfile="\${2}"
chromosomes="\${3}"
threads="\${4}"

echo -e "split_with_samtools \\ \n\
    \"\${threads}\" \\ \n\
    \"\${infile}\" \\ \n\
    \"\${chromosomes}\" \\ \n\
    \"\${outfile}\""

split_with_samtools \\
    "\${threads}" \\
    "\${infile}" \\
    "\${chromosomes}" \\
    "\${outfile}"
script


#  Run the jobs ---------------------------------------------------------------
# script_name="submit_split-bam.sh"  #NOTE Defined above
# threads=4  #NOTE Defined above
storage="./files_unprocessed/bam_split"
chromosomes="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito"
split="sc_all"

count=1  # echo "${count}"
for i in "${infiles_mapped[@]}"; do
    # i="${infiles_mapped[0]}"  # echo "${i}"
    base=$(basename "${i}" .bam)  # echo "${base}"

    # if [[ "${base}" == *"_1000_"* ]]; then
    #     j=1000
    # elif [[ "${base}" == *"_100_"* ]]; then
    #     j=100
    # elif [[ "${base}" == *"_10_"* ]]; then
    #     j=10
    # elif [[ "${base}" == *"_1_"* ]]; then
    #     j=1
    # else
    #     help="""
    #     Exiting: An error was encountered when identifying multi-hit-mode
    #     integers; check on this
    #     """
    #     echo "${help}"
    #     # exit 1
    # fi
    # # echo "${j}"

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

<details>
<summary><i>Results of echo test</i></summary>

```txt
split_with_samtools \
    "4" \
    "./files_unprocessed/bam/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.bam" \
    "I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI Mito" \
    "./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1000_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam"
```
</details>

<a id="index-the-s-cerevisiae-only-bams"></a>
### Index the *S. cerevisiae*-only `.bam`s
```bash
#!/bin/bash
#DONTRUN

grabnode  # Two cores, default settings

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
    find . \
        -type f \
        -name *.sc_all.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_mapped_sc[@]}"
# echo "${#infiles_mapped_sc[@]}"


#  Run samtools index on each element of .bam array ---------------------------
for i in "${infiles_mapped_sc[@]}"; do
    # echo "samtools index -@ 2 \"${i}\""
    samtools index -@ 2 "${i}"
done
```
<br />
<br />

<a id="convert-_multi-hit-mode_1_bams-back-to-fastqs"></a>
## Convert `*_multi-hit-mode_1_*.bam`s back to `.fastq`s
Convert the the non-multi-hit-mode (i.e., those with the substring "`_multi-hit-mode_1_`"), *S. cerevisiae*-filtered `.bam`s from to .`fastq`s
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
    find . \
        -type f \
        -name *_multi-hit-mode_1_*.sc_all.bam \
        -print0 \
            | sort -z \
)
# echoTest "${infiles_multi_1_sc[@]}"
# echo "${#infiles_multi_1_sc[@]}"


#  Generate job submission script ---------------------------------------------
script_name="submit_convert-bam-fastq.sh"
threads=4

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

infile="\${1}"
outprefix="\${2}"
threads="\${3}"

if [[ ! -f "\${infile%.bam}.sort-n.bam" ]]; then
    echo -e "samtools sort -n -@ \"\${threads}\" \"\${infile}\" \\ \n\
        > \"\${infile%.bam}.sort-n.bam\""
    echo ""
fi

echo -e "samtools fastq \\ \n\
    -@ \"\${threads}\" \\ \n\
    -1 \"\${outprefix}.1.fq.gz\" \\ \n\
    -2 \"\${outprefix}.2.fq.gz\" \\ \n\
    \"\${infile%.bam}.sort-n.bam\""
echo ""

if [[ ! -f "\${infile%.bam}.sort-n.bam" ]]; then
    echo "QNAME-sorting \${infile}"
    samtools sort -n -@ "\${threads}" "\${infile}" \\
        > "\${infile%.bam}.sort-n.bam"
fi

echo "Converting QNAME-sorted bam to fastq files"
if [[ -f "\${infile%.bam}.sort-n.bam" ]]; then
    samtools fastq \\
        -@ "\${threads}" \\
        -1 "\${outprefix}.1.fq.gz" \\
        -2 "\${outprefix}.2.fq.gz" \\
        "\${infile%.bam}.sort-n.bam"
else
    echo "\${infile%.bam}.sort-n.bam is NOT present; check on this..."
fi
script
# find . -iname "*sort-n.bam" -exec ls -lhaFG '{}' \;
# find . -iname "*sort-n.bam" -exec rm '{}' \;


#  Run the jobs ---------------------------------------------------------------
# script_name="submit_convert-bam-fastq.sh"  #NOTE Defined above
# threads=4  #NOTE Defined above
storage="./files_unprocessed/fastq_split"

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

<details>
<summary><i>Results of echo test:</i></summary>

```txt
samtools sort -n -@ "4" "./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.bam" \
    > "./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.sort-n.bam"

samtools fastq \
    -@ "4" \
    -1 "./files_unprocessed/fastq_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.1.fq.gz" \
    -2 "./files_unprocessed/fastq_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.2.fq.gz" \
    "./files_unprocessed/bam_split/EndToEnd/5781_G1_IN_merged.un_multi-hit-mode_1_EndToEnd.Aligned.sortedByCoord.out.sc_all.sort-n.bam"
```
</details>
<br />
<br />

<a id="rough-draft-limit-number-of-jobs-submitted-to-slurm"></a>
## Rough-draft: Limit number of jobs submitted to `SLURM`
```bash
#!/bin/bash
#DONTRUN

# squeue -u "kalavatt"
list_running_IDs() {
    squeue -h -u "$(whoami)" \
        | tr -s ' ' \
        | sed 's/^ //g' \
        | tr ' ' '\t' \
        | cut -f 1,5 \
        | awk -F '\t' '{ $2 = R; print }'
}


alias count_running="list_running_IDs | wc -l"

jobs_tally="$(count_running)"  # echo "${jobs_tally}"
jobs_max=12
while [[ "$(count_running)" -ge "${jobs_max}" ]]; do
    sleep 5
    printf %s "."
done


#  Scraps, etc. ---------------------------------------------------------------
# while [[ "${jobs_tally}" -ge "${jobs_max}" ]]; do
#     sleep 5
#     printf %s "."
#     jobs_tally="$(count_running)"
# done

# if [[ "$(count_running)" -ge "${jobs_max}" ]]; then
#     echo TRUE
# else
#     echo FALSE
# fi

# max_jobs=1
# while read -r job; do
#     grid_jobs_tally="$(list_jobs | grep -c "${job_prefix}")"
#
#     while [[ "${grid_jobs_tally}" -ge "${max_jobs}" ]]; do
#         sleep 5
#         printf "."
#         grid_jobs_tally="$(list_jobs | grep -c "${job_prefix}")"
#     done
#
#     qsub "${job}"
#
#     printf "Job submission time: %s\n\n" "$(date)"
#     sleep 1
# done <(find ./path/to/files -name "${job_prefix}*" -type f | sort -V)

# checkJobs() { qstat -u "kga0" -xml | grep JB_name | sed 's#</*JB_name>##g'; }
```

<details>
<summary><i>Snippets</i></summary>

```txt
#!/bin/bash
#DONTRUN #CONTINUE

<details>
<summary><i>Sample</i></summary>
</details>
```
</details>
