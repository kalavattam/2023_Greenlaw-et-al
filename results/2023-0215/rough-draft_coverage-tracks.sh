#!/bin/bash

#  rough-draft_coverage-tracks.sh
#  KA
#  2023-0403-0404


cd ~/2022_transcriptome-construction/results/2023-0215 \
    || echo "cd'ing failed; check on this..."

# mamba create -n coverage_env -c bioconda deeptools  # Only if not installed
source activate coverage_env


#  Initialize variables, arrays -----------------------------------------------
job_name="rough-draft_coverage-tracks"

p_bam="${HOME}/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI"
p_bw="${HOME}/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI"
p_eo="${p_bw}/err_out"

err_out="${p_eo}/${job_name}"

threads=8

p_excl="/home/kalavatt/2022_transcriptome-construction_2023-0215/outfiles_gtf-gff3/already"
f_excl="SC_features-rRNA-tRNA.bed"
do_blacklist=FALSE
blacklist="${p_excl}/${f_excl}"

unset a_bam
typeset -A a_bam
#  samples_fig_1_5
a_bam["${p_bam}/WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_G1_N_rep1"
a_bam["${p_bam}/WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_G1_N_rep2"
a_bam["${p_bam}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_G1_SS_rep1"
a_bam["${p_bam}/WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_G1_SS_rep2"
a_bam["${p_bam}/WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_Q_N_rep1"
a_bam["${p_bam}/WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_Q_N_rep2"
a_bam["${p_bam}/WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_Q_SS_rep1"
a_bam["${p_bam}/WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/wt_ovn/WT_Q_SS_rep2"

#  samples_fig_2
a_bam["${p_bam}/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSm2_SS_rep1"
a_bam["${p_bam}/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSm2_SS_rep2"
a_bam["${p_bam}/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp2_SS_rep1"
a_bam["${p_bam}/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp2_SS_rep2"
a_bam["${p_bam}/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp24_SS_rep1"
a_bam["${p_bam}/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp24_SS_rep2"
a_bam["${p_bam}/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp48_SS_rep1"
a_bam["${p_bam}/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp48_SS_rep1"
a_bam["${p_bam}/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp48_SS_rep2"
a_bam["${p_bam}/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSm2_SS_rep1"
a_bam["${p_bam}/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSm2_SS_rep2"
a_bam["${p_bam}/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSp2_SS_rep1"
a_bam["${p_bam}/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSp2_SS_rep2"
a_bam["${p_bam}/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSp24_SS_rep1"
a_bam["${p_bam}/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSp24_SS_rep2"
a_bam["${p_bam}/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSp48_SS_rep1"
a_bam["${p_bam}/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6-n_DSp48_SS_rep2"

#  samples_fig_3
a_bam["${p_bam}/WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/WT_G1_SS_rep1"
a_bam["${p_bam}/WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/WT_G1_SS_rep2"
a_bam["${p_bam}/WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/WT_Q_N_rep1"
a_bam["${p_bam}/WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/WT_Q_N_rep2"
a_bam["${p_bam}/WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/WT_Q_SS_rep1"
a_bam["${p_bam}/WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/WT_Q_SS_rep2"
a_bam["${p_bam}/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_G1_SS_rep1"
a_bam["${p_bam}/r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_G1_SS_rep2"
a_bam["${p_bam}/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_Q_N_rep1"
a_bam["${p_bam}/r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_Q_N_rep2"
a_bam["${p_bam}/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_Q_SS_rep1"
a_bam["${p_bam}/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_Q_SS_rep1"
a_bam["${p_bam}/r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/rrp6_wt/r6-n_Q_SS_rep2"

#  samples_fig_4
a_bam["${p_bam}/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/n3-d_Q_N_rep1"
a_bam["${p_bam}/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/n3-d_Q_N_rep2"
a_bam["${p_bam}/n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/n3-d_Q_N_rep3"
a_bam["${p_bam}/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/n3-d_Q_SS_rep1"
a_bam["${p_bam}/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/n3-d_Q_SS_rep2"
a_bam["${p_bam}/n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/n3-d_Q_SS_rep3"
a_bam["${p_bam}/o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/o-d_Q_N_rep1"
a_bam["${p_bam}/o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/o-d_Q_N_rep2"
a_bam["${p_bam}/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/o-d_Q_SS_rep1"
a_bam["${p_bam}/o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/nab3_ostir/o-d_Q_SS_rep2"

unset strand
typeset -a strand=("forward" "reverse")
# echo_test "${strand[@]}"


#  Create outdirectories if not present ---------------------------------------
if [[ ! -d  "${p_bw}" ]]; then mkdir -p ${p_bw}/{wt_ovn,timecourse_rrp6_wt,rrp6_wt,nab3_ostir}; fi
if [[ ! -d  "${p_eo}" ]]; then mkdir -p "${p_eo}"; fi


#  Submit jobs ---------------------------------------------------------------- 
for i in "${!a_bam[@]}"; do
    for j in "${strand[@]}"; do
        if [[ "${do_blacklist}" == FALSE ]]; then
            if [[ "${j}" == "forward" ]]; then
                ext="TPM.m.bw"
            elif [[ "${j}" == "reverse" ]]; then
                ext="TPM.p.bw"
            fi

            in="${i}"
            out="${a_bam[${i}]}.${ext}"
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

            sleep 0.33
        elif [[ "${do_blacklist}" == TRUE ]]; then
            if [[ "${j}" == "forward" ]]; then
                ext="bl-TPM.m.bw"
            elif [[ "${j}" == "reverse" ]]; then
                ext="bl-TPM.p.bw"
            fi

            in="${i}"
            out="${a_bam[${i}]}.${ext}"
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
            
            sleep 0.33
        fi
    done
done


#  The --filterRNAstrand "option assumes a standard dUTP-based library
#+ preparation (that is, --filterRNAstrand=forward keeps minus-strand reads,
#+ which originally came from genes on the forward strand using a dUTP-
#+ based method)."
#+ 
#+ Thus, in our context for RF libraries, --filterRNAstrand=forward gives us
#+ plus-strand reads; --filterRNAstrand=reverse gives us minus-strand reads.

#DONE For --blackListFileName, make a gtf of rRNA, tRNA, and Ty elements
