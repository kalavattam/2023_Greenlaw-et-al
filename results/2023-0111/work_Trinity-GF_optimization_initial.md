
`#work_Trinity-GF_optimization.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Set things up and run a trial `echo` test to test the setup](#set-things-up-and-run-a-trial-echo-test-to-test-the-setup)
    1. [Getting file, directory info into a deduplicated associative array](#getting-file-directory-info-into-a-deduplicated-associative-array)
1. [Build the script for submitting genome-free `Trinity` `echo` tests](#build-the-script-for-submitting-genome-free-trinity-echo-tests)
    1. [Define variables for `echo` test](#define-variables-for-echo-test)
    1. [Generate script for `echo` tests](#generate-script-for-echo-tests)
        1. [Run the script for `echo` tests](#run-the-script-for-echo-tests)
1. [Submit and run genome-free `Trinity` jobs](#submit-and-run-genome-free-trinity-jobs)
    1. [Define variables for submitting jobs](#define-variables-for-submitting-jobs)
    1. [Generate the submission script](#generate-the-submission-script)
    1. [Run the submission script](#run-the-submission-script)

<!-- /MarkdownTOC -->
</details>
<br />


<a id="set-things-up-and-run-a-trial-echo-test-to-test-the-setup"></a>
## Set things up and run a trial `echo` test to test the setup
<a id="getting-file-directory-info-into-a-deduplicated-associative-array"></a>
### Getting file, directory info into a deduplicated associative array
<details>
<summary><i>Click to view: Getting file, directory info into a deduplicated associative array</i></summary>

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

Trinity_env
ml Singularity


#  Symlink to directory of interest, ../2022-1201/files_processed-full --------
if [[ ! -d "./files_processed-full" ]]; then
    ln -s ../2022-1201/files_processed-full files_processed-full
fi
# .,


#  Create an array of files of interest, including relative paths -------------
unset d_in_base
typeset -a d_in_base=(
    files_processed-full/fastq*split/EndToEnd
)
# echoTest "${d_in_base[@]}"
# echo "${#d_in_base[@]}"


#  Get necessary file/path info into separate arrays ------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_in_base[@]}"; do
    # i="${d_in_base[0]}"
    echo "#  Working with files in... --------------------------------"
    echo "#+ ${i}"
    # ., "${i}"

    while IFS=" " read -r -d $'\0'; do
        f_in+=( "$(echo "$(basename "${REPLY%.?.fq.gz}")" | cut -d $'_' -f 2-)" )
        d_in+=( "$(dirname "${REPLY}")" )
    done < <(\
        find "${i}" \
            -type f \
            -name "*_Q_IP_*_1_*.?.fq.gz" \
            -print0
    )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"


#  Rejoin the path and file info before dedup'ing ---------
unset d_f_rejoin
typeset -a d_f_rejoin
for i in $(seq 0 $(echo "${#f_in[@]}" - 1 | bc)); do
    d_f_rejoin+=( "${d_in[${i}]}/${f_in[${i}]}" )
done
echoTest "${d_f_rejoin[@]}"


#  Remove duplicate elements from the "rejoin" array ------
IFS=" " read -r -a d_f_rejoin \
    <<< "$(\
        tr ' ' '\n' \
            <<< "${d_f_rejoin[@]}" \
                | sort -u \
                | tr '\n' ' '\
    )"
echoTest "${d_f_rejoin[@]}"


#  "Unjoin" the "rejoin" array ----------------------------
unset f_in
unset d_in
typeset -a f_in
typeset -a d_in
for i in "${d_f_rejoin[@]}"; do
    echo "#  Working with... ------------------------------------------"
    echo "#+ ${i}"

    f_in+=( "$(basename "${i%.?.fq.gz}")" )
    d_in+=( "$(dirname "${i}")" )

    echo ""
done
echoTest "${f_in[@]}"
echoTest "${d_in[@]}"

#NOTE 1/3 The above "unjoin", "rejoin", "unjoin" steps are necessary to maintain
#NOTE 2/3 the equivalent orders for directory paths and corresponding file-name
#NOTE 3/3 snippets
```
</details>
<br />
<br />

<a id="build-the-script-for-submitting-genome-free-trinity-echo-tests"></a>
## Build the script for submitting genome-free `Trinity` `echo` tests
<a id="define-variables-for-echo-test"></a>
### Define variables for `echo` test
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="echo_Trinity-GF_optimization.sh"
threads=8
SLURM_CPUS_ON_NODE="${threads}"
catalog="$(dirname "$(pwd)")/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
file_1="${d_in[0]}/5781_${f_in[0]}.1.fq.gz"
d_base="files_Trinity-GF/$(echo "${file_1}" | cut -d "/" -f 1)" 
d_mid="$(\
    echo $(basename "${file_1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
        | cut -d $'_' -f 2- \
)"
out="${d_base}/${d_mid}"
# intron="1002"  # Not needed for Trinity GF

(
    echo "       script_name  ${script_name}"
    echo "           threads  ${threads}"
    echo "SLURM_CPUS_ON_NODE  ${SLURM_CPUS_ON_NODE}"
    echo "           catalog  ${catalog}"
    echo "            file_1  ${file_1}"
    echo "            d_base  ${d_base}"
    echo "             d_mid  ${d_mid}"
    echo "               out  ${out}"
    echo "            intron  ${intron}"
)


#  Make sh_err_out and sh_err_out/err_out if they don't exist
if [[ ! -d "sh_err_out" ]]; then mkdir -p "sh_err_out/err_out"; fi
```

<a id="generate-script-for-echo-tests"></a>
### Generate script for `echo` tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

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


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_directory_exists() {
    # Check that a directory exists; exit if it does not
    # 
    # :param 1: directory, including path <chr>
    [[ -d "\${1}" ]] ||
        {
            echo -e "Exiting: Directory \${1} does not exist.\n"
            exit 1
        }
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


check_value_integer() {
    # Check that a value is an integer; exit if not
    # 
    # :param 1: value to be checked for positive \"integer\" data type
    # :param 2: string specifying what argument is being tests <chr> 
    [[ ! "\${1}" =~ ^[0-9]+$ ]] &&
        {
            echo -e "Exiting: Argument for \${2} must be a positive integer.\n"
            exit 1
        }
}


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    \$(( run_time/3600 )) \$(( run_time%3600/60 )) \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}
-c  {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
-l  {left_1}         first of two .fastq.gz files for 'left' reads <chr>
-b  {left_2}         second of two .fastq.gz files for 'left' reads <chr>
-r  {right_1}        first of two .fastq.gz files for 'right' reads <chr>
-d  {right_2}        second of two .fastq.gz files for 'right' reads <chr>
-o  {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
-k  {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1; default: 1>
-i  {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float;
                     default: 0.05>
-g  {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1; default: 2>
-f  {glue_factor}    fraction of maximum (Inchworm pair coverage) for read glue
                     support <float; default: 0.05>
"""

while getopts "c:l:b:r:d:o:k:i:g:f:" opt; do
    case "\${opt}" in
        c) catalog="\${OPTARG}" ;;
        l) left_1="\${OPTARG}" ;;
        b) left_2="\${OPTARG}" ;;
        r) right_1="\${OPTARG}" ;;
        d) right_2="\${OPTARG}" ;;
        o) out="\${OPTARG}" ;;
        k) min_kmer_cov="\${OPTARG}" ;;
        i) min_iso_ratio="\${OPTARG}" ;;
        g) min_glue="\${OPTARG}" ;;
        f) glue_factor="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${catalog}" ]] && print_message_exit "\${help}"
[[ -z "\${left_1}" ]] && print_message_exit "\${help}"
[[ -z "\${left_2}" ]] && print_message_exit "\${help}"
[[ -z "\${right_1}" ]] && print_message_exit "\${help}"
[[ -z "\${right_2}" ]] && print_message_exit "\${help}"
[[ -z "\${out}" ]] && print_message_exit "\${help}"
[[ -z "\${min_kmer_cov}" ]] && min_kmer_cov=1
[[ -z "\${min_iso_ratio}" ]] && min_iso_ratio=0.05
[[ -z "\${min_glue}" ]] && min_glue=2
[[ -z "\${glue_factor}" ]] && glue_factor=0.05


#  ------------------------------------
check_directory_exists "\${catalog}"
# check_file_exists "\${left_1}"
# check_file_exists "\${left_2}"
# check_file_exists "\${right_1}"
# check_file_exists "\${right_2}"
check_value_integer "\${min_kmer_cov}" "{min_kmer_cov}"
check_value_integer "\${min_glue}" "{min_glue}"

#TODO 1/2 In the echo test, check_file_exists() will lead to exit b/c not
#TODO 2/2 accessing container mount
#TODO Check that directory portion of {out} exists
#TODO check_value_float "\${min_iso_ratio}" "{min_iso_ratio}"
#TODO check_value_float "\${glue_factor}" "{glue_factor}"


#  ------------------------------------
time_start="\$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \\
    'singularity run \\
        --bind {catalog}:/data \\
        --bind {scratch}:/loc/scratch \\
        ~/singularity-docker-etc/Trinity.sif \\
            Trinity \\
                --verbose \\
                --max_memory {j_mem} \\
                --CPU {j_cor} \\
                --SS_lib_type FR \\
                --seqType fq \\
                --left {left_1},{left_2} \\
                --right {right_1},{right_2} \\
                --jaccard_clip \\
                --output {out} \\
                --full_cleanup \\
                --min_kmer_cov {min_kmer_cov} \\
                --min_iso_ratio {min_iso_ratio} \\
                --min_glue {min_glue} \\
                --glue_factor {glue_factor} \\
                --max_reads_per_graph 2000 \\
                --normalize_max_read_cov 200 \\
                --group_pairs_distance 700 \\
                --min_contig_length 200' \\
::: catalog "\${catalog}" \\
::: scratch "/fh/scratch/delete30/tsukiyama_t" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: left_1 "\${left_1}" \\
:::+ left_2 "\${left_2}" \\
:::+ right_1 "\${right_1}" \\
:::+ right_2 "\${right_2}" \\
:::+ out "\${out}" \\
::: min_kmer_cov "\${min_kmer_cov}" \\
::: min_iso_ratio "\${min_iso_ratio}" \\
::: min_glue "\${min_glue}" \\
::: glue_factor "\${glue_factor}"

time_end="\$(date +%s)"


#  ------------------------------------
echo ""
calculate_run_time "\${time_start}" "\${time_end}" "Completed: \${0}"
echo ""
script

# vi "./sh_err_out/${script_name}"  # :q
# bash "./sh_err_out/${script_name}"
```

<a id="run-the-script-for-echo-tests"></a>
#### Run the script for `echo` tests
```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel --header : --colsep " " -k -j 1 \
    'bash {script_name} \
        -c {catalog} \
        -l {left_1} \
        -b {left_2} \
        -r {right_1} \
        -d {right_2} \
        -o {out}/mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
        -k {min_kmer_cov} \
        -i {min_iso_ratio} \
        -g {min_glue} \
        -f {glue_factor}' \
::: script_name "./sh_err_out/${script_name}" \
::: catalog "${catalog}" \
:::+ left_1 "/data/5781_${f_in[0]}.1.fq.gz" \
:::+ left_2 "/data/5782_${f_in[0]}.1.fq.gz" \
:::+ right_1 "/data/5781_${f_in[0]}.2.fq.gz" \
:::+ right_2 "/data/5782_${f_in[0]}.2.fq.gz" \
:::+ out "${out}" \
::: min_kmer_cov 1 2 4 8 16 32 64 128 256 512 \
::: min_iso_ratio 0.01 0.05 \
::: min_glue 1 2 4 \
::: glue_factor 0.005 0.01 0.05 0.1
```
<br />
<br />

<a id="submit-and-run-genome-free-trinity-jobs"></a>
## Submit and run genome-free `Trinity` jobs
<a id="define-variables-for-submitting-jobs"></a>
### Define variables for submitting jobs
```bash
#!/bin/bash
#DONTRUN #CONTINUE

script_name="submit_Trinity-GF_optimization.sh"
threads=8
catalog="$(dirname "$(pwd)")/2022-1201/files_processed-full/fastq_trim-rcor-cor_split/EndToEnd"
file_1="${d_in[0]}/5781_${f_in[0]}.1.fq.gz"
d_base="files_Trinity-GF/$(echo "${file_1}" | cut -d "/" -f 1)" 
d_mid="$(\
    echo $(basename "${file_1}" ".Aligned.sortedByCoord.out.sc_all.1.fq.gz") \
        | cut -d $'_' -f 2- \
)"
out="${d_base}/${d_mid}"
# intron="1002"  # Not needed for Trinity GF

(
    echo "       script_name  ${script_name}"
    echo "           threads  ${threads}"
    echo "           catalog  ${catalog}"
    echo "            file_1  ${file_1}"
    echo "            d_base  ${d_base}"
    echo "             d_mid  ${d_mid}"
    echo "               out  ${out}"
    echo "            intron  ${intron}"
)


#  Make sh_err_out and sh_err_out/err_out if they don't exist
if [[ ! -d "sh_err_out" ]]; then mkdir -p "sh_err_out/err_out"; fi
```

<a id="generate-the-submission-script"></a>
### Generate the submission script
```bash
#!/bin/bash
#DONTRUN #CONTINUE

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


#  ------------------------------------
print_message_exit() {
    # Print a message and exit
    #
    # :param 1: message to be printed <chr>
    echo "\${1}"
    exit 1
}


check_directory_exists() {
    # Check that a directory exists; exit if it does not
    # 
    # :param 1: directory, including path <chr>
    [[ -d "\${1}" ]] ||
        {
            echo -e "Exiting: Directory \${1} does not exist.\n"
            exit 1
        }
}


check_file_exists() {
    # Check that a file exists; exit if it does not
    # 
    # :param 1: file, including path <chr>
    [[ -f "\${1}" ]] ||
        {
            echo -e "Exiting: File \${1} does not exist.\n"
            exit 1
        }
}


check_value_integer() {
    # Check that a value is an integer; exit if not
    # 
    # :param 1: value to be checked for positive \"integer\" data type
    # :param 2: string specifying what argument is being tests <chr> 
    [[ ! "\${1}" =~ ^[0-9]+$ ]] &&
        {
            echo -e "Exiting: Argument for \${2} must be a positive integer.\n"
            exit 1
        }
}


calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in <'date +%s' format>
    # :param 2: end time in <'date +%s' format>
    # :param 3: message to be displayed when printing the run time <chr>
    run_time="\$(echo "\${2}" - "\${1}" | bc -l)"
    
    echo ""
    echo "\${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    \$(( run_time/3600 )) \$(( run_time%3600/60 )) \$(( run_time%60 ))
    echo ""
}


#  ------------------------------------
help="""
\${0}
-c  {catalog}        directory containing .fastq.gz files, including path; to
                     be mounted to the Trinity container at '/data' <chr>
-l  {left_1}         first of two .fastq.gz files for 'left' reads <chr>
-b  {left_2}         second of two .fastq.gz files for 'left' reads <chr>
-r  {right_1}        first of two .fastq.gz files for 'right' reads <chr>
-d  {right_2}        second of two .fastq.gz files for 'right' reads <chr>
-o  {out}            path for Trinity outfiles; prefix for filenames derived
                     from the following four arguments <chr>
-k  {min_kmer_cov}   minimum count for k-mers to be assembled by Inchworm;
                     e.g., using a setting of 2 means that singleton k-mers
                     will not be included in initial Inchworm contigs
                     <int >= 1; default: 1>
-i  {min_iso_ratio}  minimum fraction of average k-mer coverage between two
                     Inchworm contigs; required for gluing <float;
                     default: 0.05>
-g  {min_glue}       minimum number of reads needed to glue two Inchworm
                     contigs together <int >= 1; default: 2>
-f  {glue_factor}    fraction of maximum (Inchworm pair coverage) for read glue
                     support <float; default: 0.05>
"""

while getopts "c:l:b:r:d:o:k:i:g:f:" opt; do
    case "\${opt}" in
        c) catalog="\${OPTARG}" ;;
        l) left_1="\${OPTARG}" ;;
        b) left_2="\${OPTARG}" ;;
        r) right_1="\${OPTARG}" ;;
        d) right_2="\${OPTARG}" ;;
        o) out="\${OPTARG}" ;;
        k) min_kmer_cov="\${OPTARG}" ;;
        i) min_iso_ratio="\${OPTARG}" ;;
        g) min_glue="\${OPTARG}" ;;
        f) glue_factor="\${OPTARG}" ;;
        *) print_message_exit "\${help}" ;;
    esac
done

[[ -z "\${catalog}" ]] && print_message_exit "\${help}"
[[ -z "\${left_1}" ]] && print_message_exit "\${help}"
[[ -z "\${left_2}" ]] && print_message_exit "\${help}"
[[ -z "\${right_1}" ]] && print_message_exit "\${help}"
[[ -z "\${right_2}" ]] && print_message_exit "\${help}"
[[ -z "\${out}" ]] && print_message_exit "\${help}"
[[ -z "\${min_kmer_cov}" ]] && min_kmer_cov=1
[[ -z "\${min_iso_ratio}" ]] && min_iso_ratio=0.05
[[ -z "\${min_glue}" ]] && min_glue=2
[[ -z "\${glue_factor}" ]] && glue_factor=0.05


#  ------------------------------------
check_directory_exists "\${catalog}"
# check_file_exists "\${left_1}"
# check_file_exists "\${left_2}"
# check_file_exists "\${right_1}"
# check_file_exists "\${right_2}"
check_value_integer "\${min_kmer_cov}" "{min_kmer_cov}"
check_value_integer "\${min_glue}" "{min_glue}"

#TODO 1/2 In the echo test and submission script, check_file_exists() will lead
#TODO 2/2 to exit b/c not accessing container mount
#TODO Check that directory portion of {out} exists
#TODO check_value_float "\${min_iso_ratio}" "{min_iso_ratio}"
#TODO check_value_float "\${glue_factor}" "{glue_factor}"


#  Echo -------------------------------
time_start="\$(date +%s)"

parallel --header : --colsep " " -k -j 1 echo \\
    'singularity run \\
        --bind {catalog}:/data \\
        --bind {scratch}:/loc/scratch \\
        ~/singularity-docker-etc/Trinity.sif \\
            Trinity \\
                --verbose \\
                --max_memory {j_mem} \\
                --CPU {j_cor} \\
                --SS_lib_type FR \\
                --seqType fq \\
                --left {left_1},{left_2} \\
                --right {right_1},{right_2} \\
                --jaccard_clip \\
                --output {out} \\
                --full_cleanup \\
                --min_kmer_cov {min_kmer_cov} \\
                --min_iso_ratio {min_iso_ratio} \\
                --min_glue {min_glue} \\
                --glue_factor {glue_factor} \\
                --max_reads_per_graph 2000 \\
                --normalize_max_read_cov 200 \\
                --group_pairs_distance 700 \\
                --min_contig_length 200' \\
::: catalog "\${catalog}" \\
::: scratch "/fh/scratch/delete30/tsukiyama_t" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: left_1 "\${left_1}" \\
:::+ left_2 "\${left_2}" \\
:::+ right_1 "\${right_1}" \\
:::+ right_2 "\${right_2}" \\
:::+ out "\${out}" \\
::: min_kmer_cov "\${min_kmer_cov}" \\
::: min_iso_ratio "\${min_iso_ratio}" \\
::: min_glue "\${min_glue}" \\
::: glue_factor "\${glue_factor}"


#  Run --------------------------------
parallel --header : --colsep " " -k -j 1 \\
    'singularity run \\
        --bind {catalog}:/data \\
        --bind {scratch}:/loc/scratch \\
        ~/singularity-docker-etc/Trinity.sif \\
            Trinity \\
                --verbose \\
                --max_memory {j_mem} \\
                --CPU {j_cor} \\
                --SS_lib_type FR \\
                --seqType fq \\
                --left {left_1},{left_2} \\
                --right {right_1},{right_2} \\
                --jaccard_clip \\
                --output {out} \\
                --full_cleanup \\
                --min_kmer_cov {min_kmer_cov} \\
                --min_iso_ratio {min_iso_ratio} \\
                --min_glue {min_glue} \\
                --glue_factor {glue_factor} \\
                --max_reads_per_graph 2000 \\
                --normalize_max_read_cov 200 \\
                --group_pairs_distance 700 \\
                --min_contig_length 200' \\
::: catalog "\${catalog}" \\
::: scratch "/fh/scratch/delete30/tsukiyama_t" \\
::: j_mem "50G" \\
::: j_cor "\${SLURM_CPUS_ON_NODE}" \\
::: left_1 "\${left_1}" \\
:::+ left_2 "\${left_2}" \\
:::+ right_1 "\${right_1}" \\
:::+ right_2 "\${right_2}" \\
:::+ out "\${out}" \\
::: min_kmer_cov "\${min_kmer_cov}" \\
::: min_iso_ratio "\${min_iso_ratio}" \\
::: min_glue "\${min_glue}" \\
::: glue_factor "\${glue_factor}"

time_end="\$(date +%s)"


#  ------------------------------------
echo ""
calculate_run_time "\${time_start}" "\${time_end}" "Completed: \${0}"
echo ""
script

# vi "./sh_err_out/${script_name}"  # :q
# bash "./sh_err_out/${script_name}"
```

<a id="run-the-submission-script"></a>
### Run the submission script
```bash
#!/bin/bash
#DONTRUN #CONTINUE

parallel --header : --colsep " " -k -j 1 \
    'sbatch {script_name} \
        -c {catalog} \
        -l {left_1} \
        -b {left_2} \
        -r {right_1} \
        -d {right_2} \
        -o {out}/trinity_mkc-{min_kmer_cov}_mir-{min_iso_ratio}_mg-{min_glue}_gf-{glue_factor} \
        -k {min_kmer_cov} \
        -i {min_iso_ratio} \
        -g {min_glue} \
        -f {glue_factor}' \
::: script_name "./sh_err_out/${script_name}" \
::: catalog "${catalog}" \
:::+ left_1 "/data/5781_${f_in[0]}.1.fq.gz" \
:::+ left_2 "/data/5782_${f_in[0]}.1.fq.gz" \
:::+ right_1 "/data/5781_${f_in[0]}.2.fq.gz" \
:::+ right_2 "/data/5782_${f_in[0]}.2.fq.gz" \
:::+ out "${out}" \
::: min_kmer_cov 1 2 4 8 16 32 64 128 256 512 \
::: min_iso_ratio 0.01 0.05 \
::: min_glue 1 2 4 \
::: glue_factor 0.005 0.01 0.05 0.1
# ::: min_kmer_cov 1 \
# ::: min_iso_ratio 0.01 \
# ::: min_glue 1 \
# ::: glue_factor 0.005
```
