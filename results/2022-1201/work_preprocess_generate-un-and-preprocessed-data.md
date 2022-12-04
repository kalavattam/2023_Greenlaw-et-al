
# `work_generating-unprocessed-preprocessed-data.md`

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

## Align `.fastq`s to generate "unprocessed `.bam`s"
`#NOTE` Alignment will result in unprocessed `.bam` files (unprocessed `.fastq` files are available in `results/2022-1201/files_fastq_symlinks/`)

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
mkdir -p files_unprocessed/fastq
mkdir -p files_unprocessed/bam/{Local,EndToEnd}

#  Populate files_unprocessed/fastq with symlinks (will make calling
#+ Trinity/PASA easier later)
cd ./files_unprocessed/fastq
for i in "${infiles[@]}"; do
    ln -s \
        "${i}" \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201/files_unprocessed/fastq/$(basename ${i})"
done
```

## Generate "unprocessed `.bam`s"
```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Make a directory to store submission scripts and also capture STDERR, STDOUT
#+ .txt files
mkdir -p sh_err_out/err_out

#  Establish variables, arrays, etc.
genome_dir="${HOME}/genomes/combined_SC_KL_20S/STAR"
threads=8

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

# #SBATCH --job-name=${script_name%.sh}

#  Generate the job submission scripts
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

#  Run the jobs
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
            
            #  Report the iteration we're on
            echo "# ----------------------------------------"
message="""Submitting iteration ${count} of ${script_name} with the following arguments:
        read_1: ${i}_R1.fastq
        read_2: ${i}_R2.fastq
        prefix: ${storage}/${k}/${pre}.${suf}/${pre}.${suf}
    genome_dir: ${genome_dir}
alignment mode: ${k}
"""
			echo "${message}"

            #  Make storage directories if they don't exist
            if [[ ! -d "${storage}/${k}/${pre}.${suf}" ]]; then
                mkdir "${storage}/${k}/${pre}.${suf}"
            fi
            
            # #  Echo test
            # bash "./sh_err_out/${script_name}" \
            #     "${i}_R1.fastq" \
            #     "${i}_R1.fastq" \
            #     "${storage}/${k}/${pre}.${suf}/${pre}.${suf}" \
            #     "${genome_dir}"
            
            sbatch "./sh_err_out/${script_name}" \
                "${i}_R1.fastq" \
                "${i}_R2.fastq" \
                "${storage}/${k}/${pre}.${suf}/${pre}.${suf}" \
                "${genome_dir}"
            sleep 0.25
            
            echo ""
            echo ""
            
            (( count++ ))
        done
    done
done
```

```bash
# checkJobs() { qstat -u "kga0" -xml | grep JB_name | sed 's#</*JB_name>##g'; }
# squeue -u "kalavatt"
list_running_job_IDs() {
    squeue -h -u "kalavatt" \
        | tr -s ' ' \
        | sed 's/^ //g' \
        | tr ' ' '\t' \
        | cut -f 1,5 \
        | awk -F '\t' '{ $2 = R; print }'
}

alias count_running_jobs="list_running_job_IDs | wc -l"

jobs_tally="$(list_running_job_IDs | wc -l)"
jobs_max=4
while [[ "${jobs_tally}" -ge "${jobs_max}" ]]; do
    sleep 5
    printf %s "."
    grid_jobs_tally="$(list_running_job_IDs | wc -l)"
done


max_jobs=1
while read -r job; do
    grid_jobs_tally="$(list_jobs | grep -c "${job_prefix}")"

    while [[ "${grid_jobs_tally}" -ge "${max_jobs}" ]]; do
        sleep 5
        printf "."
        grid_jobs_tally="$(list_jobs | grep -c "${job_prefix}")"
    done

    qsub "${job}"

    printf "Job submission time: %s\n\n" "$(date)"
    sleep 1
done <(find ./path/to/files -name "${job_prefix}*" -type f | sort -V)
```



<!--
#!/bin/bash
#DONTRUN #CONTINUE
 -->

<!--
<details>
<summary><i>Sample</i></summary>
</details>
 -->
