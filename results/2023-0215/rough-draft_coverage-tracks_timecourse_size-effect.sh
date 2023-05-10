#!/bin/bash

#  rough-draft_coverage-tracks_timecourse_size-effect.sh
#  KA
#  2023-0509

cd ~/2022_transcriptome-construction/results/2023-0215 \
    || echo "cd'ing failed; check on this..."

# mamba create -n coverage_env -c bioconda deeptools  # Only if not installed
#LATER Install bowtie2 as well:  mamba install -c bioconda bowtie2
#LATER Install samtools as well: mamba install -c bioconda samtools
source activate coverage_env


#  Initialize variables, arrays -----------------------------------------------
job_name="rough-draft_coverage-tracks_timecourse_size-effect"  # echo "${job_name}"

p_bam="${HOME}/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI"  # echo "${p_bam}"
p_bw="${HOME}/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI"  # echo "${p_bw}"  # ., "${p_bw}"
p_eo="${p_bw}/err_out"  # echo "${p_eo}"

err_out="${p_eo}/${job_name}"  # echo "${err_out}"

threads=8  # echo "${threads}"

#  Variables for blacklisting
# p_excl="/home/kalavatt/2022_transcriptome-construction_2023-0215/outfiles_gtf-gff3/already"
# f_excl="SC_features-rRNA-tRNA.bed"
# do_blacklist=FALSE
# blacklist="${p_excl}/${f_excl}"


#  Timecourse samples (calculated values described below)
unset a_bam
typeset -A a_bam=(
    ["${p_bam}/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSm2_rep1_tech1___1.7599208"
    ["${p_bam}/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSm2_rep2_tech1___2.2889032"
    ["${p_bam}/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp2_rep1_tech1___1.2338584"
    ["${p_bam}/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp2_rep2_tech1___1.1810227"
    ["${p_bam}/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp24_rep1_tech1___0.8081369"
    ["${p_bam}/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp24_rep2_tech1___0.7898672"
    ["${p_bam}/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp48_rep1_tech1___0.5904367"
    ["${p_bam}/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp48_rep1_tech2___0.5742435"
    ["${p_bam}/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/WT_DSp48_rep2_tech1___0.8004773"
    ["${p_bam}/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSm2_rep1_tech1___1.5838222"
    ["${p_bam}/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSm2_rep2_tech1___1.2963194"
    ["${p_bam}/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSp2_rep1_tech1___1.0055450"
    ["${p_bam}/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSp2_rep2_tech1___0.9844227"
    ["${p_bam}/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSp24_rep1_tech1___1.1520234"
    ["${p_bam}/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSp24_rep2_tech1___0.8236362"
    ["${p_bam}/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSp48_rep1_tech1___0.7057575"
    ["${p_bam}/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"]="${p_bw}/timecourse_rrp6_wt/r6n_DSp48_rep2_tech1___0.6738932"
)

unset strand
typeset -a strand=("forward" "reverse")
# echo_test "${strand[@]}"


#  Create outdirectories if not present ---------------------------------------
if [[ ! -d  "${p_bw}/timecourse_rrp6_wt_size-factor-scaled" ]]; then
    mkdir -p "${p_bw}/timecourse_rrp6_wt_size-factor-scaled"
fi
if [[ ! -d  "${p_eo}" ]]; then mkdir -p "${p_eo}"; fi

for i in "${!a_bam[@]}"; do
    for j in "${strand[@]}"; do
        if [[ "${j}" == "forward" ]]; then
            ext="m.bw"
        elif [[ "${j}" == "reverse" ]]; then
            ext="p.bw"
        fi

        in="${i}"
        coef="${a_bam[${i}]#*___}"
        out="${a_bam[${i}]%___*}_gsf-${coef}.${ext}"
        filter="${j}"

        echo "#  -------------------------------------"

        ., ${in}
        echo """
            in (key)  ${in}
         out (value)  ${out}
        scale factor  ${coef}
              strand  ${filter}"""
        
        echo """
        sbatch \\
            --job-name=\"${job_name}\" \\
            --nodes=1 \\
            --cpus-per-task=\"${threads}\" \\
            --error=\"${err_out}.%A.stderr.txt\" \\
            --output=\"${err_out}.%A.stdout.txt\" \\
            bamCoverage \\
                --bam \"${in}\" \\
                --numberOfProcessors \"${threads}\" \\
                --binSize 1 \\
                --scaleFactor \"${coef}\" \\
                --filterRNAstrand=\"${filter}\" \\
                --outFileName \"${out}\"
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
                --scaleFactor "${coef}" \
                --filterRNAstrand="${filter}" \
                --outFileName "${out}"
        sleep 0.33
        echo ""
    done
done


#  From RStudio: 
# > #  Size factors calculated with respect to all 17 samples
# > dds$sizeFactor %>% as.data.frame()
#                              .
# WT_DSm2_rep1_tech1   0.5682074
# WT_DSm2_rep2_tech1   0.4368905
# WT_DSp2_rep1_tech1   0.8104658
# WT_DSp2_rep2_tech1   0.8467238
# WT_DSp24_rep1_tech1  1.2374142
# WT_DSp24_rep2_tech1  1.2660357
# WT_DSp48_rep1_tech1  1.6936618
# WT_DSp48_rep1_tech2  1.7414215
# WT_DSp48_rep2_tech1  1.2492546
# r6n_DSm2_rep1_tech1  0.6313840
# r6n_DSm2_rep2_tech1  0.7714148
# r6n_DSp2_rep1_tech1  0.9944856
# r6n_DSp2_rep2_tech1  1.0158238
# r6n_DSp24_rep1_tech1 0.8680379
# r6n_DSp24_rep2_tech1 1.2141282
# r6n_DSp48_rep1_tech1 1.4169173
# r6n_DSp48_rep2_tech1 1.4839146
#
# > #  And the reciprocal...
# > (1 / dds$sizeFactor) %>% as.data.frame()
#                              .
# WT_DSm2_rep1_tech1   1.7599208
# WT_DSm2_rep2_tech1   2.2889032
# WT_DSp2_rep1_tech1   1.2338584
# WT_DSp2_rep2_tech1   1.1810227
# WT_DSp24_rep1_tech1  0.8081369
# WT_DSp24_rep2_tech1  0.7898672
# WT_DSp48_rep1_tech1  0.5904367
# WT_DSp48_rep1_tech2  0.5742435
# WT_DSp48_rep2_tech1  0.8004773
# r6n_DSm2_rep1_tech1  1.5838222
# r6n_DSm2_rep2_tech1  1.2963194
# r6n_DSp2_rep1_tech1  1.0055450
# r6n_DSp2_rep2_tech1  0.9844227
# r6n_DSp24_rep1_tech1 1.1520234
# r6n_DSp24_rep2_tech1 0.8236362
# r6n_DSp48_rep1_tech1 0.7057575
# r6n_DSp48_rep2_tech1 0.6738932


#  The job submission...
# ❯ for i in "${!a_bam[@]}"; do
# >     for j in "${strand[@]}"; do
# >         if [[ "${j}" == "forward" ]]; then
# >             ext="m.bw"
# >         elif [[ "${j}" == "reverse" ]]; then
# >             ext="p.bw"
# >         fi
# > 
# >         in="${i}"
# >         coef="${a_bam[${i}]#*___}"
# >         out="${a_bam[${i}]%___*}_gsf-${coef}.${ext}"
# >         filter="${j}"
# > 
# >         echo "#  -------------------------------------"
# > 
# >         ., ${in}
# >         echo """
# >             in (key)  ${in}
# >          out (value)  ${out}
# >         scale factor  ${coef}
# >               strand  ${filter}"""
# > 
# >         echo """
# >         sbatch \\
# >             --job-name=\"${job_name}\" \\
# >             --nodes=1 \\
# >             --cpus-per-task=\"${threads}\" \\
# >             --error=\"${err_out}.%A.stderr.txt\" \\
# >             --output=\"${err_out}.%A.stdout.txt\" \\
# >             bamCoverage \\
# >                 --bam \"${in}\" \\
# >                 --numberOfProcessors \"${threads}\" \\
# >                 --binSize 1 \\
# >                 --scaleFactor \"${coef}\" \\
# >                 --filterRNAstrand=\"${filter}\" \\
# >                 --outFileName \"${out}\"
# >         """
# > 
# >         sbatch \
# >             --job-name="${job_name}" \
# >             --nodes=1 \
# >             --cpus-per-task="${threads}" \
# >             --error="${err_out}.%A.stderr.txt" \
# >             --output="${err_out}.%A.stdout.txt" \
# >             bamCoverage \
# >                 --bam "${in}" \
# >                 --numberOfProcessors "${threads}" \
# >                 --binSize 1 \
# >                 --scaleFactor "${coef}" \
# >                 --filterRNAstrand="${filter}" \
# >                 --outFileName "${out}"
# >         sleep 0.33
# >         echo ""
# >     done
# > done
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp7_DSp24_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep2_tech1_gsf-0.7898672.m.bw
#         scale factor  0.7898672
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.7898672" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep2_tech1_gsf-0.7898672.m.bw"
#
# Submitted batch job 20186392
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp7_DSp24_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep2_tech1_gsf-0.7898672.p.bw
#         scale factor  0.7898672
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.7898672" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep2_tech1_gsf-0.7898672.p.bw"
#
# Submitted batch job 20186393
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM4_DSp2_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep1_tech1_gsf-1.2338584.m.bw
#         scale factor  1.2338584
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.2338584" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep1_tech1_gsf-1.2338584.m.bw"
#
# Submitted batch job 20186394
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM4_DSp2_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep1_tech1_gsf-1.2338584.p.bw
#         scale factor  1.2338584
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.2338584" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep1_tech1_gsf-1.2338584.p.bw"
#
# Submitted batch job 20186395
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp6_DSp2_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep1_tech1_gsf-1.0055450.m.bw
#         scale factor  1.0055450
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.0055450" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep1_tech1_gsf-1.0055450.m.bw"
#
# Submitted batch job 20186396
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp6_DSp2_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep1_tech1_gsf-1.0055450.p.bw
#         scale factor  1.0055450
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.0055450" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep1_tech1_gsf-1.0055450.p.bw"
#
# Submitted batch job 20186397
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 107 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech2_gsf-0.5742435.m.bw
#         scale factor  0.5742435
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.5742435" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech2_gsf-0.5742435.m.bw"
#
# Submitted batch job 20186398
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 107 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech2_gsf-0.5742435.p.bw
#         scale factor  0.5742435
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.5742435" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech2_gsf-0.5742435.p.bw"
#
# Submitted batch job 20186399
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM12_DSp48_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep2_tech1_gsf-0.6738932.m.bw
#         scale factor  0.6738932
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.6738932" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep2_tech1_gsf-0.6738932.m.bw"
#
# Submitted batch job 20186400
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM12_DSp48_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep2_tech1_gsf-0.6738932.p.bw
#         scale factor  0.6738932
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.6738932" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep2_tech1_gsf-0.6738932.p.bw"
#
# Submitted batch job 20186401
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM7_DSp24_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep1_tech1_gsf-0.8081369.m.bw
#         scale factor  0.8081369
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.8081369" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep1_tech1_gsf-0.8081369.m.bw"
#
# Submitted batch job 20186402
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM7_DSp24_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep1_tech1_gsf-0.8081369.p.bw
#         scale factor  0.8081369
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.8081369" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp24_rep1_tech1_gsf-0.8081369.p.bw"
#
# Submitted batch job 20186403
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp4_DSp2_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep2_tech1_gsf-1.1810227.m.bw
#         scale factor  1.1810227
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.1810227" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep2_tech1_gsf-1.1810227.m.bw"
#
# Submitted batch job 20186404
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp4_DSp2_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep2_tech1_gsf-1.1810227.p.bw
#         scale factor  1.1810227
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.1810227" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp2_rep2_tech1_gsf-1.1810227.p.bw"
#
# Submitted batch job 20186405
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp9_DSp24_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep1_tech1_gsf-1.1520234.m.bw
#         scale factor  1.1520234
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.1520234" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep1_tech1_gsf-1.1520234.m.bw"
#
# Submitted batch job 20186406
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp9_DSp24_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep1_tech1_gsf-1.1520234.p.bw
#         scale factor  1.1520234
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.1520234" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep1_tech1_gsf-1.1520234.p.bw"
#
# Submitted batch job 20186407
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech1_gsf-0.5904367.m.bw
#         scale factor  0.5904367
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.5904367" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech1_gsf-0.5904367.m.bw"
#
# Submitted batch job 20186408
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM10_DSp48_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech1_gsf-0.5904367.p.bw
#         scale factor  0.5904367
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.5904367" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep1_tech1_gsf-0.5904367.p.bw"
#
# Submitted batch job 20186409
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp10_DSp48_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep2_tech1_gsf-0.8004773.m.bw
#         scale factor  0.8004773
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.8004773" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep2_tech1_gsf-0.8004773.m.bw"
#
# Submitted batch job 20186410
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp10_DSp48_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep2_tech1_gsf-0.8004773.p.bw
#         scale factor  0.8004773
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.8004773" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSp48_rep2_tech1_gsf-0.8004773.p.bw"
#
# Submitted batch job 20186411
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp12_DSp48_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep1_tech1_gsf-0.7057575.m.bw
#         scale factor  0.7057575
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.7057575" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep1_tech1_gsf-0.7057575.m.bw"
#
# Submitted batch job 20186412
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 103 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp12_DSp48_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep1_tech1_gsf-0.7057575.p.bw
#         scale factor  0.7057575
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.7057575" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp48_rep1_tech1_gsf-0.7057575.p.bw"
#
# Submitted batch job 20186413
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM9_DSp24_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep2_tech1_gsf-0.8236362.m.bw
#         scale factor  0.8236362
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.8236362" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep2_tech1_gsf-0.8236362.m.bw"
#
# Submitted batch job 20186414
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 102 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM9_DSp24_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep2_tech1_gsf-0.8236362.p.bw
#         scale factor  0.8236362
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.8236362" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp24_rep2_tech1_gsf-0.8236362.p.bw"
#
# Submitted batch job 20186415
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp3_DSm2_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep1_tech1_gsf-1.5838222.m.bw
#         scale factor  1.5838222
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.5838222" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep1_tech1_gsf-1.5838222.m.bw"
#
# Submitted batch job 20186416
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp3_DSm2_7078_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep1_tech1_gsf-1.5838222.p.bw
#         scale factor  1.5838222
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.5838222" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep1_tech1_gsf-1.5838222.p.bw"
#
# Submitted batch job 20186417
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM1_DSm2_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep1_tech1_gsf-1.7599208.m.bw
#         scale factor  1.7599208
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.7599208" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep1_tech1_gsf-1.7599208.m.bw"
#
# Submitted batch job 20186418
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM1_DSm2_5781_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep1_tech1_gsf-1.7599208.p.bw
#         scale factor  1.7599208
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.7599208" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep1_tech1_gsf-1.7599208.p.bw"
#
# Submitted batch job 20186419
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM3_DSm2_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep2_tech1_gsf-1.2963194.m.bw
#         scale factor  1.2963194
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.2963194" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep2_tech1_gsf-1.2963194.m.bw"
#
# Submitted batch job 20186420
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM3_DSm2_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep2_tech1_gsf-1.2963194.p.bw
#         scale factor  1.2963194
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "1.2963194" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSm2_rep2_tech1_gsf-1.2963194.p.bw"
#
# Submitted batch job 20186421
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp1_DSm2_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep2_tech1_gsf-2.2889032.m.bw
#         scale factor  2.2889032
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "2.2889032" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep2_tech1_gsf-2.2889032.m.bw"
#
# Submitted batch job 20186422
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/Bp1_DSm2_5782_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep2_tech1_gsf-2.2889032.p.bw
#         scale factor  2.2889032
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "2.2889032" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/WT_DSm2_rep2_tech1_gsf-2.2889032.p.bw"
#
# Submitted batch job 20186423
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM6_DSp2_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep2_tech1_gsf-0.9844227.m.bw
#         scale factor  0.9844227
#               strand  forward
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.9844227" \
#                 --filterRNAstrand="forward" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep2_tech1_gsf-0.9844227.m.bw"
#
# Submitted batch job 20186424
#
# #  -------------------------------------
# lrwxrwxrwx 1 kalavatt 101 Mar 15 16:09 /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam -> ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI/BM6_DSp2_7079_UT.primary.dedup-UMI.bam
#
#             in (key)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam
#          out (value)  /home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep2_tech1_gsf-0.9844227.p.bw
#         scale factor  0.9844227
#               strand  reverse
#
#         sbatch \
#             --job-name="rough-draft_coverage-tracks_timecourse_size-effect" \
#             --nodes=1 \
#             --cpus-per-task="8" \
#             --error="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stderr.txt" \
#             --output="/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/err_out/rough-draft_coverage-tracks_timecourse_size-effect.%A.stdout.txt" \
#             bamCoverage \
#                 --bam "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI/r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam" \
#                 --numberOfProcessors "8" \
#                 --binSize 1 \
#                 --scaleFactor "0.9844227" \
#                 --filterRNAstrand="reverse" \
#                 --outFileName "/home/kalavatt/2022_transcriptome-construction/results/2023-0215/bws/UT_prim_UMI/timecourse_rrp6_wt/r6n_DSp2_rep2_tech1_gsf-0.9844227.p.bw"
#
# Submitted batch job 20186425
#
#
# ❯ skal
#              JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON) MIN_CPUS
#           20186422 campus-ne rough-dr kalavatt  R       0:22      1 gizmok66 8
#           20186423 campus-ne rough-dr kalavatt  R       0:22      1 gizmok78 8
#           20186424 campus-ne rough-dr kalavatt  R       0:22      1 gizmok78 8
#           20186425 campus-ne rough-dr kalavatt  R       0:22      1 gizmok81 8
#           20186414 campus-ne rough-dr kalavatt  R       0:25      1 gizmok64 8
#           20186415 campus-ne rough-dr kalavatt  R       0:25      1 gizmok65 8
#           20186416 campus-ne rough-dr kalavatt  R       0:25      1 gizmok65 8
#           20186417 campus-ne rough-dr kalavatt  R       0:25      1 gizmok65 8
#           20186418 campus-ne rough-dr kalavatt  R       0:25      1 gizmok65 8
#           20186419 campus-ne rough-dr kalavatt  R       0:25      1 gizmok66 8
#           20186420 campus-ne rough-dr kalavatt  R       0:25      1 gizmok66 8
#           20186421 campus-ne rough-dr kalavatt  R       0:25      1 gizmok66 8
#           20186406 campus-ne rough-dr kalavatt  R       0:28      1 gizmok62 8
#           20186407 campus-ne rough-dr kalavatt  R       0:28      1 gizmok63 8
#           20186408 campus-ne rough-dr kalavatt  R       0:28      1 gizmok63 8
#           20186409 campus-ne rough-dr kalavatt  R       0:28      1 gizmok63 8
#           20186410 campus-ne rough-dr kalavatt  R       0:28      1 gizmok63 8
#           20186411 campus-ne rough-dr kalavatt  R       0:28      1 gizmok64 8
#           20186412 campus-ne rough-dr kalavatt  R       0:28      1 gizmok64 8
#           20186413 campus-ne rough-dr kalavatt  R       0:28      1 gizmok64 8
#           20186398 campus-ne rough-dr kalavatt  R       0:31      1 gizmok46 8
#           20186399 campus-ne rough-dr kalavatt  R       0:31      1 gizmok61 8
#           20186400 campus-ne rough-dr kalavatt  R       0:31      1 gizmok67 8
#           20186401 campus-ne rough-dr kalavatt  R       0:31      1 gizmok67 8
#           20186402 campus-ne rough-dr kalavatt  R       0:31      1 gizmok67 8
#           20186403 campus-ne rough-dr kalavatt  R       0:31      1 gizmok62 8
#           20186404 campus-ne rough-dr kalavatt  R       0:31      1 gizmok62 8
#           20186405 campus-ne rough-dr kalavatt  R       0:31      1 gizmok62 8
#           20186392 campus-ne rough-dr kalavatt  R       0:34      1 gizmok9 8
#           20186393 campus-ne rough-dr kalavatt  R       0:34      1 gizmok17 8
#           20186394 campus-ne rough-dr kalavatt  R       0:34      1 gizmok73 8
#           20186395 campus-ne rough-dr kalavatt  R       0:34      1 gizmok46 8
#           20186396 campus-ne rough-dr kalavatt  R       0:34      1 gizmok46 8
#           20186397 campus-ne rough-dr kalavatt  R       0:34      1 gizmok46 8
