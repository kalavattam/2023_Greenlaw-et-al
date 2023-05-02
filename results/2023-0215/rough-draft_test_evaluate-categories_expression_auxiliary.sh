#!/bin/bash

#  rough-draft_test_evaluate-categories_expression_auxiliary.sh
#  KA

samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam A B C D E F Mito 20S \
    | gawk '$0 !~ /\<NH:i:1\>/' \
    | wc -l

samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam A B C D E F Mito 20S \
    | awk '!/\<NH:i:1\>/' \
    | wc -l

samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
        | awk '!/\<NH:i:1\>/' \
        | wc -l

samtools view -c \
    n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI

# ❯ samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam A B C D E F Mito 20S \
# >    | gawk '$0 !~ /\<NH:i:1\>/' \
# >    | wc -l
# 4233128

# ❯ samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam A B C D E F Mito 20S \
# >    | awk '!/\<NH:i:1\>/' \
# >    | wc -l
# 4233128

# ❯ samtools view n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
# >    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
# >        | awk '!/\<NH:i:1\>/' \
# >        | wc -l
# 6270758

# ❯ echo $(( (6270758 + 4233128) / 2 ))
# 5251943
#NOTE This is equal to the current value for __alignment_not_unique

#  We need to change __alignment_not_unique to 3135379
# ❯ echo $(( 6270758 / 2 ))  
# 3135379

# ❯ samtools view -c \
# >    n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam \
# >    I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI
# 25506768
#NOTE 1/2 This is the total (valid plus stuff in `underscore` number that we
#NOTE 2/2 need to care about: 12753384
# ❯ echo $(( 25506768 / 2 ))
# 12753384

#  Total minus multimapper minus "valid"
echo $(( 12753384 - 3135379 - 6765861 ))
