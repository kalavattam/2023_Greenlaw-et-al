#!/bin/bash

#  rough-draft_test_evaluate-categories_expression_auxiliary.sh
#  KA

#  Get situated
grabnode  # 1 CPU, defaults
ml SAMtools/1.16.1-GCC-11.2.0
cd /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams_renamed/UT_prim_UMI \
    || echo "cd'ing failed; check on this"


#  Assess the total number of reads in the bam --------------------------------
samtools view -c n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam
# 57187500

echo $(( 57187500 / 2 ))  # 28593750


#  Assess S. cerevisiae mitochondiral and non-S. cerevisiae reads -------------
#  Tally numbers of unimapping reads
samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    Mito A B C D E F 20S \
        | awk '/\<NH:i:1\>/' \
        | wc -l
# 27447604
echo $(( 27447604 / 2 ))  # 13723802 unimapping read pairs

#  Tally numbers multimapping reads
samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    Mito A B C D E F 20S \
        | awk '!/\<NH:i:1\>/' \
        | wc -l  # 4233128
echo $(( 4233128 / 2 ))  # 2116564 multimapping read pairs


#  Tally numbers of all reads
samtools view -c \
    n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    Mito A B C D E F 20S  # 31680732
echo $(( 31680732 / 2 ))  # 15840366 

[[ $(( 4233128 + 27447604 )) -eq 31680732 ]] && \
    {
        echo "Tally of total reads equals sum of numbers of multimapping" \
            "unimapping reads"
    }


#  Assess S. cerevisiae I-XVI reads -------------------------------------------
#  Tally numbers of unimapping reads
samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
        | awk '/\<NH:i:1\>/' \
        | wc -l  # 19236010
echo $(( 19236010 / 2 ))  # 9618005 unimapping read pairs

#  Tally numbers multimapping reads
samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
        | awk '!/\<NH:i:1\>/' \
        | wc -l  # 6270758
echo $(( 6270758 / 2 ))  # 3135379 multimapping read pairs

#  Tally numbers of all reads
samtools view -c \
    n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI  # 25506768
echo $(( 25506768 / 2 ))  # 12753384 total read pairs

[[ $(( 6270758 + 19236010 )) -eq 25506768 ]] && \
    {
        echo "Tally of total alignments equals sum of numbers of multimapping" \
            "unimapping alignments"
    }



echo $(( 9618005 + 13723802 ))  # 23341807 total unimapping read pairs
echo $(( 3135379 + 2116564 ))  # 5251943

# `underscore`
# __no_feature           14968733
# __ambiguous            1607213
# __too_low_aQual        0
# __not_aligned          0
# __alignment_not_unique 5251943

#  Steps for processing
#+ 1. From __alignment_not_unique, need to subtract multimappers against S. cerevisiae Mito, K. lactis, and 20S
#+ 2. From __no_feature, need to substract unimappers against S. cerevisiae Mito, K. lactis, and 20S

#  For example
hc_anu=$(( 5251943 - 2116564 ))  # 3135379: New value for __alignment_not_unique  # 1
hc_nf=$(( 14968733 - 13723802 ))  # 1244931: New value for __no_feature  # 2
hc_ambi=$(( 1607213 ))
echo $(( hc_anu + hc_nf + hc_ambi ))  # 5987523

# sum(counts$`n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1`) / 2  # 6765861
hc_val=6765861

echo $(( hc_val + hc_anu + hc_nf + hc_ambi ))  # 12753384
# It took all day, but I finally go this fucker reconciled. Nice.
