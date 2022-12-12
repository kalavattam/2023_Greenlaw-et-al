#!/bin/bash
#DONTRUN

#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=${threads}
#SBATCH --error=./sh_err_out/err_out/${script_name%.sh}.%J.err.txt
#SBATCH --output=./sh_err_out/err_out/${script_name%.sh}.%J.out.txt

#  ${script_name}
#  KA
#  $(date '+%Y-%m%d')

left_1="${1}"
left_2="${2}"
right_1="${3}"
right_2="${4}"
out="${5}"

# module load Singularity/3.5.3

parallel --header : --colsep " " -k -j 1 echo \
    singularity run \
        --no-home \
        --bind {d_exp} \
        --bind {d_scr} \
        ~/singularity-docker-etc/Trinity.sif \
            Trinity \
                --verbose \
                --max_memory {j_mem} \
                --CPU {j_cor} \
                --SS_lib_type FR \
                --left {left_1},{left_2} \
                --right {right_1},{right_2} \
                --jaccard_clip \
                --output {t_out} \
                --full_cleanup \
                --min_kmer_cov 1 \
                --min_iso_ratio 0.05 \
                --min_glue 2 \
                --glue_factor 0.05 \
                --max_reads_per_graph 2000 \
                --normalize_max_read_cov 200 \
                --group_pairs_distance 700 \
                --min_contig_length 200 \
::: d_exp "$(pwd)" \
::: d_scr "/loc/scratch" \
::: j_mem "50G" \
::: j_cor "${SLURM_CPUS_ON_NODE}" \
::: left_1 "${left_1}" \
:::+ left_2 "${left_2}" \
:::+ right_1 "${right_1}" \
:::+ right_2 "${right_2}" \
:::+ t_out "${out}"

#  2022-1212
# This seems to be an important conversation for how we can/should go about annotating novel transcripts...
# https://groups.google.com/g/pasapipeline-users/c/ka_Ue6WLogE/m/0cdqnSrnAQAJ
