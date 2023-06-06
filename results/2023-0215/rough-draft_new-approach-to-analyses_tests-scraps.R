
#  rough-draft_new-approach-to-analyses_tests-scraps.R
#  KA

# `DGE-analysis_N-Q-nab3d_N-Q-parental` <- run_main(
N_Q_none <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "none",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_1samp <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-1-samp",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_2samp <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-2-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_3samp_1 <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-1-ct-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_3samp_2 <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-2-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_3samp_3 <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-3-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_3samp_4 <- run_main(
    t_sub = `N-Q-nab3d_N-Q-parental`,
    # t_sub = `N-Q-rrp6∆_N-Q-WT`,
    genotype_exp = "n3d",
    genotype_ctrl = "od",
    # genotype_exp = "r6n",
    # genotype_ctrl = "WT",
    filtering = "min-4-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_3samp_5 <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-5-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_3samp <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

N_Q_Asamp <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-all-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)


# `DGE-analysis_SS-Q-nab3d_SS-Q-parental` <- run_main(
SS_Q_none <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "none",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_1samp <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-1-samp",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_2samp <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-2-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_3samp_1 <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-1-ct-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_3samp_2 <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-2-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_3samp_3 <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-3-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_3samp_4 <- run_main(
    t_sub = `SS-Q-nab3d_SS-Q-parental`,
    # t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    genotype_exp = "n3d",
    genotype_ctrl = "od",
    # genotype_exp = "r6n",
    # genotype_ctrl = "WT",
    filtering = "min-4-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_3samp_5 <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-5-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_3samp <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)

SS_Q_Asamp <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-all-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)


# `DGE-analysis_SS-G1-nab3d_SS-G1-parental` <- run_main(
SS_G1_none <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "none",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_1samp <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-1-samp",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_2samp <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-2-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_3samp_1 <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-1-ct-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_3samp_2 <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-2-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_3samp_3 <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-3-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_3samp_4 <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-4-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_3samp_5 <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-5-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_3samp <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)

SS_G1_Asamp <- run_main(
    # t_sub = `SS-G1-nab3d_SS-G1-parental`,
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "min-10-cts-all-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 160,
    color = "#2E0C4A"
)


#  N_Q ========================================================================
#  lfc_0_fc_1 ---------------------------------------------
N_Q_none$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_1samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_2samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp_1$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp_2$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp_3$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp_4$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp_5$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_Asamp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`

N_Q_none$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_1samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_2samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_1$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_2$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_3$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_4$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_5$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_Asamp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  lfc_0.32_fc_1.25 ----------------------------------------
N_Q_none$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_1samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_2samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp_1$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp_2$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp_3$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp_5$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_Asamp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`

N_Q_none$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_1samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_2samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_1$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_2$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_3$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_5$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_Asamp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  lfc_0.58_fc_1.5 ----------------------------------------
N_Q_none$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_1samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_2samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_3samp_1$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_3samp_2$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_3samp_3$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_3samp_5$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_3samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
N_Q_Asamp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`

N_Q_none$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_1samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_2samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_1$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_2$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_3$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_5$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_Asamp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  putative-optimized_min-4-cts-3-samps -------------------
N_Q_3samp_4$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
N_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
N_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`

N_Q_3samp_4$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
N_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()


#  SS_Q =======================================================================
#  lfc_0_fc_1 ---------------------------------------------
SS_Q_none$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_1samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_2samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_1$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_2$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_3$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_4$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_5$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_Asamp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`

SS_Q_none$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_1samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_2samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_1$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_2$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_3$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_4$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_5$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_Asamp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  lfc_0.32_fc_1.25 ----------------------------------------
SS_Q_none$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_1samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_2samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_1$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_2$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_3$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_5$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_Asamp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`

SS_Q_none$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_1samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_2samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_1$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_2$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_3$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_5$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_Asamp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  lfc_0.58_fc_1.5 ----------------------------------------
SS_Q_none$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_1samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_2samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_1$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_2$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_3$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_5$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_3samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_Q_Asamp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`

SS_Q_none$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_1samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_2samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_1$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_2$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_3$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_5$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_Asamp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  putative-optimized_min-4-cts-3-samps -------------------
SS_Q_3samp_4$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`

SS_Q_3samp_4$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_4$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_Q_3samp_4$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()


#  SS_G1 ======================================================================
#  lfc_0_fc_1 ---------------------------------------------
SS_G1_none$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_1samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_2samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_1$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_2$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_3$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_4$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_5$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_Asamp$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`

SS_G1_none$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_1samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_2samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_1$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_2$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_3$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_4$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_5$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_Asamp$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  lfc_0.32_fc_1.25 ----------------------------------------
SS_G1_none$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_1samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_2samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_1$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_2$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_3$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_4$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_5$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_Asamp$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`

SS_G1_none$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_1samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_2samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_1$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_2$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_3$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_4$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_5$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_Asamp$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  lfc_0.58_fc_1.5 ----------------------------------------
SS_G1_none$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_1samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_2samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_1$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_2$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_3$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_4$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_5$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_3samp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
SS_G1_Asamp$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`

SS_G1_none$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_1samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_2samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_1$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_2$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_3$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_4$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_5$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_Asamp$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()

#  putative-optimized_min-4-cts-3-samps -------------------
SS_G1_3samp_4$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_4$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_G1_3samp_4$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`

SS_G1_3samp_4$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_4$`09_lfc_0.32_fc_1.25`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()
SS_G1_3samp_4$`09_lfc_0.58_fc_1.5`$`10_n_feat_gt_lfc_lt_padj_unshrunken` # %>% sum()


`DGE-analysis_N-Q-nab3d_N-Q-parental` <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    # filtering = ifelse(run == "mRNA", "min-10-cts-all-but-1-samps", "min-4-cts-3-samps"),
    filtering = "min-4-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)
print_volcano_unshrunken_AG(dataframe = `DGE-analysis_N-Q-nab3d_N-Q-parental`, lfc = "lfc-gt-0")
print_volcano_unshrunken_AG(dataframe = `DGE-analysis_N-Q-nab3d_N-Q-parental`, lfc = "lfc-gt-0.32")
print_volcano_unshrunken_AG(dataframe = `DGE-analysis_N-Q-nab3d_N-Q-parental`, lfc = "lfc-gt-0.58")

`DGE-analysis_SS-Q-nab3d_SS-Q-parental` <- run_main(
    # t_sub = `SS-Q-nab3d_SS-Q-parental`,
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    # filtering = ifelse(run == "mRNA", "min-10-cts-all-but-1-samps", "min-4-cts-3-samps"),
    filtering = "min-4-cts-3-samps",
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 60,
    color = "#2E0C4A"
)
print_volcano_unshrunken_AG(dataframe = `DGE-analysis_SS-Q-nab3d_SS-Q-parental`, lfc = "lfc-gt-0")
print_volcano_unshrunken_AG(dataframe = `DGE-analysis_SS-Q-nab3d_SS-Q-parental`, lfc = "lfc-gt-0.32")
print_volcano_unshrunken_AG(dataframe = `DGE-analysis_SS-Q-nab3d_SS-Q-parental`, lfc = "lfc-gt-0.58")


#  q filtering ================================================================
N_Q_none <- run_main(
    # t_sub = `N-Q-nab3d_N-Q-parental`,
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    # genotype_exp = "n3d",
    # genotype_ctrl = "od",
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    filtering = "none",
    threshold_p = 0.05,
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 40, 100),
    y_max = 60,
    color = "#113275"
)

SS_Q_none <- run_main(
    t_sub = `SS-Q-nab3d_SS-Q-parental`,
    # t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    genotype_exp = "n3d",
    genotype_ctrl = "od",
    # genotype_exp = "r6n",
    # genotype_ctrl = "WT",
    # filtering = "none",
    filtering = "min-4-cts-3-samps",
    # threshold_p = 0.05,
    # threshold_p = 0.01,
    # threshold_p = 0.005,
    threshold_p = 0.001,
    x_min = -5,
    x_max = ifelse(run == "mRNA", 10, 10),
    y_min = 0,
    # y_max = ifelse(run == "mRNA", 100, 100),
    y_max = 100,
    color = "#2E0C4A"
)
SS_Q_none$`09_lfc_0_fc_1`$`10_n_feat_gt_lfc_lt_padj_unshrunken`
SS_Q_none$`09_lfc_0_fc_1`$`08_p_vol_unshrunken_KA`
SS_Q_none$`09_lfc_0.32_fc_1.25`$`08_p_vol_unshrunken_KA`
SS_Q_none$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
