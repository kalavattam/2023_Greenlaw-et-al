#!/usr/bin/env Rscript

#  rough-draft_run-analyses_Fig-5B.R
#  KA


#  Load libraries, set options ================================================
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
`%notin%` <- base::Negate(`%in%`)


load_RDS_mRNA <- function(
    p_RDS = "notebook/KA.2023-0608.rds-data-objects_min-4-cts-all-but-1-samps",
    p_mRNA = "rds_mRNA",
    f_RDS
) {
    readRDS(paste(p_RDS, p_mRNA, f_RDS, sep = "/"))
}


#  Get situated, load RDS files, and load TPM dataframe =======================
#  Set work dir
p_base <- "/Users/kalavatt/projects-etc"
p_exp <- "2022_transcriptome-construction/results/2023-0215"

paste(p_base, p_exp, sep = "/") %>% setwd()

#  Load RDS files
# mRNA_N_Q_r6n <- load_RDS_mRNA(
#     f_RDS = "DGE-analysis_mRNA_N-Q-rrp6∆_N-Q-WT.rds"
# )
mRNA_SS_Q_r6n <- load_RDS_mRNA(
    f_RDS = "DGE-analysis_mRNA_SS-Q-rrp6∆_SS-Q-WT.rds"
)
mRNA_SS_G1_r6n <- load_RDS_mRNA(
    f_RDS = "DGE-analysis_mRNA_SS-G1-rrp6∆_SS-G1-WT.rds"
)

p_TPM <- "notebook/KA.2023-0624.PCA-TPM_Rrp6∆-timecourse-G1-Q.SS"
f_TPM <- "data.2023-0624__Rrp6∆.timecourse-G1-Q.SS__mRNA.counts-TPM.tsv"
df_TPM <- readr::read_tsv(
    paste(p_TPM, f_TPM, sep = "/"), show_col_types = FALSE
)

rm(list = ls(pattern = "p_"))
rm(f_TPM)


#  Load dataframes, then remove rows with padj == NA --------------------------
#+ Features with padj == NA did not pass DESeq2 independent filtering
#  Do so for SS Q Rrp6∆-vs-WT
dge_SS_Q_r6n_lfc_0.58 <-
    mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_SS_Q_r6n_lfc_0.58 <-
    dge_SS_Q_r6n_lfc_0.58[!is.na(dge_SS_Q_r6n_lfc_0.58$padj), ]

#  Do so for SS G1 Rrp6∆-vs-WT
dge_SS_G1_r6n_lfc_0.58 <-
    mRNA_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_SS_G1_r6n_lfc_0.58 <-
    dge_SS_G1_r6n_lfc_0.58[!is.na(dge_SS_G1_r6n_lfc_0.58$padj), ]

#  Retain features with padj <= 0.05 and LFC > 0.58 (actually, 0 is fine)
filt_SS_Q_r6n_lfc_0.58 <- dge_SS_Q_r6n_lfc_0.58[
    dge_SS_Q_r6n_lfc_0.58$log2FoldChange > 0.58 &
    dge_SS_Q_r6n_lfc_0.58$padj <= 0.05,
]  # 1304 features
filt_SS_G1_r6n_lfc_0.58 <- dge_SS_G1_r6n_lfc_0.58[
    dge_SS_G1_r6n_lfc_0.58$log2FoldChange > 0 &
    dge_SS_G1_r6n_lfc_0.58$padj <= 0.05,
]  # 191 features


#  Create a dataframe of features up in SS Q that are not up in SS G1 ---------
#+ ...i.e., select features up in SS Q Rrp6∆-vs-WT that are not up in SS G1
#+ Rrp6∆-vs-WT
up_in_Q_not_G1 <- filt_SS_Q_r6n_lfc_0.58[
    filt_SS_Q_r6n_lfc_0.58$features %notin% filt_SS_G1_r6n_lfc_0.58$features, 
]  # 1251 features


#  Subset the TPM dataframe to retain only the above features -----------------
filt_TPM <- df_TPM[df_TPM$features %in% up_in_Q_not_G1$features, ]


#  Create a dataframe of sample-wise mean TPM values --------------------------
#  Initialize a list
mean_TPM <- list()

#  G1
mean_TPM$mean_r6n_G1 <- rowMeans(cbind(
    filt_TPM$r6n_G1_SS_rep1_tech2,
    filt_TPM$r6n_G1_SS_rep2_tech2
))
mean_TPM$mean_WT_G1 <- rowMeans(cbind(
    filt_TPM$WT_G1_SS_rep1_tech2,
    filt_TPM$WT_G1_SS_rep2_tech2
))

#  DSm2
mean_TPM$mean_r6n_DSm2 <- rowMeans(cbind(
    filt_TPM$r6n_DSm2_SS_rep1_tech1,
    filt_TPM$r6n_DSm2_SS_rep2_tech1
))
mean_TPM$mean_WT_DSm2 <- rowMeans(cbind(
    filt_TPM$WT_DSm2_SS_rep1_tech1,
    filt_TPM$WT_DSm2_SS_rep2_tech1
))

#  DSp2
mean_TPM$mean_r6n_DSp2 <- rowMeans(cbind(
    filt_TPM$r6n_DSp2_SS_rep1_tech1,
    filt_TPM$r6n_DSp2_SS_rep2_tech1
))
mean_TPM$mean_WT_DSp2 <- rowMeans(cbind(
    filt_TPM$WT_DSp2_SS_rep1_tech1,
    filt_TPM$WT_DSp2_SS_rep2_tech1
))

#  DSp24
mean_TPM$mean_r6n_DSp24 <- rowMeans(cbind(
    filt_TPM$r6n_DSp24_SS_rep1_tech1,
    filt_TPM$r6n_DSp24_SS_rep2_tech1
))
mean_TPM$mean_WT_DSp24 <- rowMeans(cbind(
    filt_TPM$WT_DSp24_SS_rep1_tech1,
    filt_TPM$WT_DSp24_SS_rep2_tech1
))

#  DSp48
mean_TPM$mean_r6n_DSp48 <- rowMeans(cbind(
    filt_TPM$r6n_DSp48_SS_rep1_tech2,
    filt_TPM$r6n_DSp48_SS_rep2_tech1
))
mean_TPM$mean_WT_DSp48 <- rowMeans(cbind(
    filt_TPM$WT_DSp48_SS_rep1_tech1,
    filt_TPM$WT_DSp48_SS_rep1_tech2,
    filt_TPM$WT_DSp48_SS_rep2_tech1
))

#  Q
mean_TPM$mean_r6n_Q_SS <- rowMeans(cbind(
    filt_TPM$r6n_Q_SS_rep1_tech1,
    filt_TPM$r6n_Q_SS_rep2_tech1,
    filt_TPM$r6n_Q_SS_rep2_tech2
))
mean_TPM$mean_WT_Q_SS <- rowMeans(cbind(
    filt_TPM$WT_Q_SS_rep1_tech1,
    filt_TPM$WT_Q_SS_rep2_tech1
))

#  Convert from list to dataframe
mean_TPM <- mean_TPM %>% as.data.frame()


#  Create a dataframe of sample-wise mean TPM values, r6n / WT ----------------
#  Initialize a list
mean_TPM_div <- list()

#  Perform division operations
mean_TPM_div$r6n_div_WT_G1 <-
    mean_TPM$mean_r6n_G1 / mean_TPM$mean_WT_G1
mean_TPM_div$r6n_div_WT_DSm2 <-
    mean_TPM$mean_r6n_DSm2 / mean_TPM$mean_WT_DSm2
mean_TPM_div$r6n_div_WT_DSp2 <-
    mean_TPM$mean_r6n_DSp2 / mean_TPM$mean_WT_DSp2
mean_TPM_div$r6n_div_WT_DSp24 <-
    mean_TPM$mean_r6n_DSp24 / mean_TPM$mean_WT_DSp24
mean_TPM_div$r6n_div_WT_DSp48 <-
    mean_TPM$mean_r6n_DSp48 / mean_TPM$mean_WT_DSp48
mean_TPM_div$r6n_div_WT_Q <-
    mean_TPM$mean_r6n_Q / mean_TPM$mean_WT_Q

#  Convert from list to dataframe
mean_TPM_div <- mean_TPM_div %>% as.data.frame()

#  Convert Inf values to 0
mean_TPM_div <- do.call(
    data.frame,
    lapply(mean_TPM_div, function(x) replace(x, is.infinite(x), NA))
)

mean_TPM_div_log2 <- log2(mean_TPM_div) %>% tibble::as_tibble()
mean_TPM_div_log2 <- mean_TPM_div_log2 %>%
    dplyr::mutate(
        features = filt_TPM$features
    ) %>%
    dplyr::relocate(features, .before = r6n_div_WT_G1) %>%
    na.omit()
# max(mean_TPM_div_log2[2:ncol(mean_TPM_div_log2)])
# min(mean_TPM_div_log2[2:ncol(mean_TPM_div_log2)])

color_range <- colorRampPalette(c("#167C28", "#FFFFFF", "#7835AC"))
heat_h <- pheatmap::pheatmap(
    mean_TPM_div_log2[, 2:ncol(mean_TPM_div_log2)],
    cutree_rows = 3,
    cutree_cols = 3,
    scale = "row",
    border = "white",
    cluster_cols = FALSE,
    show_rownames = FALSE,
    color = color_range(100)
)

heat_k <- pheatmap::pheatmap(
    mean_TPM_div_log2[, 2:ncol(mean_TPM_div_log2)],
    kmeans_k = 3,
    scale = "row",
    border = "white",
    cluster_rows = FALSE,
    cluster_cols = FALSE,
    show_rownames = TRUE,
    color = color_range(100)
)

mean_TPM_div_log2$cluster <- heat_k$kmeans$cluster

k <- 1
df_k1 <- mean_TPM_div_log2[
    mean_TPM_div_log2$cluster == k,
    1:(ncol(mean_TPM_div_log2) - 1)
]
heat_h_k1 <- pheatmap::pheatmap(
    df_k1[, 2:ncol(df_k1)],
    cutree_rows = 1,
    cutree_cols = 1,
    scale = "row",
    border = "white",
    cluster_cols = FALSE,
    show_rownames = FALSE,
    color = color_range(100)
)

k <- 2
df_k2 <- mean_TPM_div_log2[
    mean_TPM_div_log2$cluster == k,
    1:(ncol(mean_TPM_div_log2) - 1)
]
heat_h_k2 <- pheatmap::pheatmap(
    df_k2[, 2:ncol(df_k2)],
    cutree_rows = 1,
    cutree_cols = 1,
    scale = "row",
    border = "white",
    cluster_cols = FALSE,
    show_rownames = FALSE,
    color = color_range(100)
)

k <- 3
df_k3 <- mean_TPM_div_log2[
    mean_TPM_div_log2$cluster == k,
    1:(ncol(mean_TPM_div_log2) - 1)
]
heat_h_k3 <- pheatmap::pheatmap(
    df_k3[, 2:ncol(df_k3)],
    cutree_rows = 1,
    cutree_cols = 1,
    scale = "row",
    border = "white",
    cluster_cols = FALSE,
    show_rownames = FALSE,
    color = color_range(100)
)

mean_TPM <- mean_TPM %>%
    dplyr::mutate(
        features = filt_TPM$features
    ) %>%
        dplyr::relocate(features, .before = mean_r6n_G1)

mean_TPM_k1 <- mean_TPM[mean_TPM$features %in% df_k1$features, ]
mean_TPM_k2 <- mean_TPM[mean_TPM$features %in% df_k2$features, ]
mean_TPM_k3 <- mean_TPM[mean_TPM$features %in% df_k3$features, ]

prepare_mean_TPM_plot <- function(mean_df) {
    piv_k <- mean_df %>%
        pivot_longer(names_to = "samples", cols = c(
            "mean_r6n_G1", "mean_WT_G1", "mean_r6n_DSm2", "mean_WT_DSm2",
            "mean_r6n_DSp2", "mean_WT_DSp2", "mean_r6n_DSp24", "mean_WT_DSp24",
            "mean_r6n_DSp48", "mean_WT_DSp48", "mean_r6n_Q_SS", "mean_WT_Q_SS"
        ))
    piv_k$samples <- gsub("mean_", "", piv_k$samples)
    piv_k$samples <- factor(
        piv_k$samples,
        levels = c(
            "WT_G1", "r6n_G1", "WT_DSm2", "r6n_DSm2", "WT_DSp2", "r6n_DSp2",
            "WT_DSp24", "r6n_DSp24", "WT_DSp48", "r6n_DSp48", "WT_Q_SS",
            "r6n_Q_SS"
        )
    )
    
    return(piv_k)
}

piv_k1 <- prepare_mean_TPM_plot(mean_TPM_k1)
piv_k2 <- prepare_mean_TPM_plot(mean_TPM_k2)
piv_k3 <- prepare_mean_TPM_plot(mean_TPM_k3)


plot_distributions <- function(piv_k, k) {
    plot <- ggplot(
        piv_k, aes(x = samples, y = log2(value + 1), fill = samples)
    ) +
        geom_violin(trim = FALSE) +
        geom_boxplot(width = 0.2, fill = "white") +
        labs(
            title = paste("Comparisons of distributions, k =", k),
            x = "",
            y = "log2(TPM + 1)"
        ) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    
    return(plot)
}

plot_distributions(piv_k1, 1)
plot_distributions(piv_k2, 2)
plot_distributions(piv_k3, 3)

#  Write out feature lists (e.g., for GO analyses)
readr::write_tsv(
    mean_TPM_k1$features %>% as.data.frame(),
    "05_gene-list_k-1.tsv"
)
readr::write_tsv(
    mean_TPM_k2$features %>% as.data.frame(),
    "05_gene-list_k-2.tsv"
)
readr::write_tsv(
    mean_TPM_k3$features %>% as.data.frame(),
    "05_gene-list_k-3.tsv"
)
