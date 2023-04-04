#!/bin/bash

#  rough-draft_coverage-tracks.sh
#  KA
#  2023-0403-0404

cd ~/2022_transcriptome-construction/results/2023-0215 \
    || echo "cd'ing failed; check on this..."

# mamba create -n coverage_env -c bioconda deeptools  # Only if not installed
source activate coverage_env


#  Initialize variables ---------------------------------------
job_name="rough-draft_coverage-tracks"

p_bam="${HOME}/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI"
p_bw="${HOME}/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI"
p_eo="${p_bw}/err_out"

err_out="${p_eo}/${job_name}"

threads=8

p_excl="/home/kalavatt/2022_transcriptome-construction_2023-0215/outfiles_gtf-gff3/already"
f_excl="SC_features-rRNA-tRNA.gtf"
blacklist="${p_excl}/${f_excl}"

# unset a_bam
typeset -A a_bam
a_bam["${p_bam}/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_G1_rep1.TPM.bw"
a_bam["${p_bam}/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_G1_rep2.TPM.bw"
a_bam["${p_bam}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_G1_rep1.TPM.bw"
a_bam["${p_bam}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_G1_rep2.TPM.bw"
a_bam["${p_bam}/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_Q_rep1.TPM.bw"
a_bam["${p_bam}/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_Q_rep2.TPM.bw"
a_bam["${p_bam}/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_Q_rep1.TPM.bw"
a_bam["${p_bam}/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/WT_Q_rep2.TPM.bw"

# unset strand
typeset -a strand=("forward" "reverse")
# echo_test "${strand[@]}"

#  Create outdirectories if not present ---------------------------------------
# if [[ ! -d  "${p_bw}" ]]; then mkdir -p "${p_bw}"; fi
# if [[ ! -d  "${p_eo}" ]]; then mkdir -p "${p_eo}"; fi

for i in "${!a_bam[@]}"; do
    for j in "${strand[@]}"; do
        if [[ "${j}" == "forward" ]]; then
            ext="m.bw"
        elif [[ "${j}" == "reverse" ]]; then
            ext="p.bw"
        fi

        in="${i}"
        out="${a_bam[${i}]/.bw/.blck.${ext}}"
        filter="${j}"

        echo """
        ., ${in}

           in (key)  ${in}
        out (value)  ${out}
             strand  ${filter}
          blacklist  ${blacklist}
        """
        
        sbatch \
            --job-name="${job_name}" \
            --nodes=1 \
            --cpus-per-task="${threads}" \
            --error="${err_out}.%A.stderr.txt" \
            --output="${err_out}.%A.stdout.txt" \
            bamCoverage \
                --bam "${in}" \
                --numberOfProcessors "${threads}" \
                --binSize 1 \
                --normalizeUsing BPM \
                --filterRNAstrand="${filter}" \
                --blackListFileName "${blacklist}" \
                --outFileName "${out}"
    done
done

for i in "${!a_bam[@]}"; do
    for j in "${strand[@]}"; do
        if [[ "${j}" == "forward" ]]; then
            ext="m.bw"
        elif [[ "${j}" == "reverse" ]]; then
            ext="p.bw"
        fi

        in="${i}"
        out="${a_bam[${i}]/.bw/.${ext}}"
        filter="${j}"

        echo """
        ., ${in}

           in (key)  ${in}
        out (value)  ${out}
             strand  ${filter}
        """
        
        sbatch \
            --job-name="${job_name}" \
            --nodes=1 \
            --cpus-per-task="${threads}" \
            --error="${err_out}.%A.stderr.txt" \
            --output="${err_out}.%A.stdout.txt" \
            bamCoverage \
                --bam "${in}" \
                --numberOfProcessors "${threads}" \
                --binSize 1 \
                --normalizeUsing BPM \
                --filterRNAstrand="${filter}" \
                --outFileName "${out}"
    done
done

# in="${p_bam}/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"  # echo "${in}"
# out="${p_bw}/test.WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.TPM.chr12.bw"  # echo "${out}"

in="${p_bam}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
out="${p_bw}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.TPM.chr12.bw"
sbatch \
    --job-name="${job_name}" \
    --nodes=1 \
    --cpus-per-task="${threads}" \
    --error="${err_out}.%A.stderr.txt" \
    --output="${err_out}.%A.stdout.txt" \
    bamCoverage \
        --bam "${in}" \
        --numberOfProcessors "${threads}" \
        --binSize 1 \
        --normalizeUsing BPM \
        --filterRNAstrand=forward \
        --region="XII" \
        --blackListFileName "${blacklist}" \
        --outFileName "${out/.bw/.minus.bw}"
        # --outFileName "${a_bam[${i}]/.bw/.minus.bw}"

# in="${p_bam}/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"  # echo "${in}"
# out="${p_bw}/test.WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.TPM.chr12.bw"  # echo "${out}"

in="${p_bam}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
out="${p_bw}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.TPM.chr12.bw"
sbatch \
    --job-name="${job_name}" \
    --nodes=1 \
    --cpus-per-task="${threads}" \
    --error="${err_out}.%A.stderr.txt" \
    --output="${err_out}.%A.stdout.txt" \
    bamCoverage \
        --bam "${i}" \
        --numberOfProcessors "${threads}" \
        --binSize 1 \
        --normalizeUsing BPM \
        --filterRNAstrand=reverse \
        --region="XII" \
        --blackListFileName "${blacklist}" \
        --outFileName "${out/.bw/.plus.bw}"
        # --outFileName "${a_bam[${i}]/.bw/.plus.bw}"


#  The --filterRNAstrand "option assumes a standard dUTP-based library
#+ preparation (that is, --filterRNAstrand=forward keeps minus-strand reads,
#+ which originally came from genes on the forward strand using a dUTP-
#+ based method)."
#+ 
#+ Thus, in our context for RF libraries, --filterRNAstrand=forward gives us
#+ plus-strand reads; --filterRNAstrand=reverse gives us minus-strand reads.

#DONE For --blackListFileName, make a gtf of rRNA, tRNA, and Ty elements


