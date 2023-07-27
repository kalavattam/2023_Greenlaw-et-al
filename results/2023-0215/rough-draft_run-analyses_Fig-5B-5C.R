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


#  Load custom ggplot2 themes -------------------------------------------------
theme_slick <- theme_classic() +
    theme(
        panel.grid.major = ggplot2::element_line(linewidth = 0.4),
        panel.grid.minor = ggplot2::element_line(linewidth = 0.2),
        axis.line = ggplot2::element_line(linewidth = 0.2),
        axis.ticks = ggplot2::element_line(linewidth = 0.4),
        axis.text = ggplot2::element_text(color = "black"),
        axis.title.x = ggplot2::element_text(),
        axis.title.y = ggplot2::element_text(),
        plot.title = ggplot2::element_text(),
        text = element_text(family = "")
    )


theme_AG <- theme_classic() +
    theme(
        panel.grid.major = ggplot2::element_line(linewidth = 3),
        panel.grid.minor = ggplot2::element_line(linewidth = 2),
        axis.line = ggplot2::element_line(linewidth = 0.5),
        axis.ticks = ggplot2::element_line(linewidth = 1.0),
        axis.text = ggplot2::element_text(
            color = "black", size = 20, face = "bold"
        ),
        axis.title.x = ggplot2::element_text(size = 25, face = "bold"),
        axis.title.y = ggplot2::element_text(size = 25, face = "bold"),
        plot.title = ggplot2::element_text(size = 20),
        text = element_text(family = "")
    )

theme_AG_boxed <- theme_AG +
    theme(
        axis.line = ggplot2::element_line(linewidth = 0),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 2)
    )

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")

theme_AG_no_legend <- theme_AG + theme(legend.position = "none")

theme_AG_boxed_no_legend <- theme_AG_boxed + theme(legend.position = "none")


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

#TODO Note the scripts and parameters used to generate these files:
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
    dge_SS_Q_r6n_lfc_0.58$log2FoldChange > 0 &
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


#  Create a dataframe of sample-wise mean TPM values for r6n ÷ WT -------------
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

#  Convert Inf values to NA
mean_TPM_div <- do.call(
    data.frame,
    lapply(mean_TPM_div, function(x) replace(x, is.infinite(x), NA))
)

#  Convert from dataframe to tibble
mean_TPM_div_log2 <- log2(mean_TPM_div) %>% tibble::as_tibble()

#  Append feature information to object of mean TPM values for r6n ÷ WT
mean_TPM_div_log2 <- mean_TPM_div_log2 %>%
    dplyr::mutate(
        features = filt_TPM$features
    ) %>%
    dplyr::relocate(features, .before = r6n_div_WT_G1) %>%
    na.omit()
# max(mean_TPM_div_log2[2:ncol(mean_TPM_div_log2)])
# min(mean_TPM_div_log2[2:ncol(mean_TPM_div_log2)])

#  Draw KMC and HC heatmaps
draw_HC_heatmap <- function(tbl, col_range) {
    h <- pheatmap::pheatmap(
        tbl,
        cutree_rows = 3,
        cutree_cols = 3,
        scale = "row",
        border = "white",
        cluster_cols = FALSE,
        show_rownames = FALSE,
        color = col_range(100)
    )
    
    return(h)
}


draw_KMC_heatmap <- function(tbl, col_range) {
    k <- pheatmap::pheatmap(
        tbl,
        kmeans_k = 3,
        scale = "row",
        border = "white",
        cluster_rows = FALSE,
        cluster_cols = FALSE,
        show_rownames = TRUE,
        color = color_range(100)
    )
    
    return(k)
}


color_range <- colorRampPalette(c("#167C28", "#FFFFFF", "#7835AC"))
heat_h <- draw_HC_heatmap(
    mean_TPM_div_log2[, 2:ncol(mean_TPM_div_log2)],
    color_range
)

set.seed(24)
heat_k <- draw_KMC_heatmap(
    mean_TPM_div_log2[, 2:ncol(mean_TPM_div_log2)],
    color_range
)


mean_TPM_div_log2$cluster <- heat_k$kmeans$cluster

k <- 1
df_k1 <- mean_TPM_div_log2[
    mean_TPM_div_log2$cluster == k,
    1:(ncol(mean_TPM_div_log2) - 1)
]

k <- 2
df_k2 <- mean_TPM_div_log2[
    mean_TPM_div_log2$cluster == k,
    1:(ncol(mean_TPM_div_log2) - 1)
]

k <- 3
df_k3 <- mean_TPM_div_log2[
    mean_TPM_div_log2$cluster == k,
    1:(ncol(mean_TPM_div_log2) - 1)
]

draw_HC_heatmap_from_K <- function(tbl, col_range) {
    h_k <- pheatmap::pheatmap(
        tbl,
        cutree_rows = 1,
        cutree_cols = 1,
        scale = "row",
        border = "white",
        treeheight_row = 0,
        cluster_cols = FALSE,
        show_rownames = FALSE,
        color = color_range(100)
    )
    
    return(h_k)
}


heat_h_k1 <- draw_HC_heatmap_from_K(df_k1[, 2:ncol(df_k1)], color_range)
heat_h_k2 <- draw_HC_heatmap_from_K(df_k2[, 2:ncol(df_k2)], color_range)
heat_h_k3 <- draw_HC_heatmap_from_K(df_k3[, 2:ncol(df_k3)], color_range)



mean_TPM <- mean_TPM %>%
    dplyr::mutate(
        features = filt_TPM$features
    ) %>%
        dplyr::relocate(features, .before = mean_r6n_G1)

mean_TPM_k1 <- mean_TPM[mean_TPM$features %in% df_k1$features, ]
mean_TPM_k2 <- mean_TPM[mean_TPM$features %in% df_k2$features, ]
mean_TPM_k3 <- mean_TPM[mean_TPM$features %in% df_k3$features, ]


prepare_mean_TPM_plot <- function(mean_df) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        mean_df <- mean_TPM_k1
    }
    
    piv_k <- mean_df %>%
        pivot_longer(names_to = "samples", cols = c(
            "mean_r6n_G1", "mean_WT_G1", "mean_r6n_DSm2", "mean_WT_DSm2",
            "mean_r6n_DSp2", "mean_WT_DSp2", "mean_r6n_DSp24", "mean_WT_DSp24",
            "mean_r6n_DSp48", "mean_WT_DSp48", "mean_r6n_Q_SS", "mean_WT_Q_SS"
        ))
    piv_k$samples <- gsub("^mean_", "", piv_k$samples)
    piv_k$samples <- gsub("_SS$", "", piv_k$samples)
    piv_k$samples <- factor(
        piv_k$samples,
        levels = c(
            "WT_G1", "r6n_G1", "WT_DSm2", "r6n_DSm2", "WT_DSp2", "r6n_DSp2",
            "WT_DSp24", "r6n_DSp24", "WT_DSp48", "r6n_DSp48", "WT_Q",
            "r6n_Q"
        )
    )
    
    tmp <- piv_k$samples %>%
        stringr::str_split_fixed("_", n = Inf) %>%
        as.data.frame()
    colnames(tmp) <- c("genotype", "state")
    
    piv_k$genotype <- tmp$genotype
    piv_k$state <- tmp$state
    
    rm(tmp)
    
    return(piv_k)
}


piv_k1 <- prepare_mean_TPM_plot(mean_TPM_k1)
piv_k2 <- prepare_mean_TPM_plot(mean_TPM_k2)
piv_k3 <- prepare_mean_TPM_plot(mean_TPM_k3)


# plot_distributions <- function(piv_k, k)
plot_distributions <- function(piv_k) {
    debug <- FALSE
    if(base::isTRUE(debug)) piv_k <- piv_k1
    
    plot <- ggplot(
        piv_k, aes(x = samples, y = log2(value + 1), fill = genotype)
    ) +
        geom_violin(trim = FALSE) +
        geom_boxplot(width = 0.2, fill = "white") +
        labs(
            # title = paste("Comparisons of distributions, k =", k),
            x = "",
            y = "log2(TPM + 1)"
        ) +
        # scale_fill_discrete(limits = c("WT", "r6n")) +
        scale_fill_manual(
            values = c("#89CF95", "#8F68AF"), limits = c("WT", "r6n")
        ) +
        theme_AG_boxed +
        theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
    if(base::isTRUE(debug)) plot
    
    return(plot)
}


print_plot <- function(
    object,
    outpath = "/Users/kalavatt/Desktop",
    filename,
    width = 7,
    height = 7
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        object = etc$`09_lm_fit_plot`
        outpath = "/Users/kalavatt/Desktop"
        filename = "test.pdf"
        width = 7
        height = 7
    }
    
    outfile <- paste0(outpath, "/", filename)
    
    pdf(file = outfile, width = width, height = height)
    print(object)
    dev.off()
}


write_results <- FALSE  #ARGUMENT
if(base::isTRUE(write_results)) {
    filename <- "mean-TPM-dists.2023-0630.group-k1.pdf"
    plot_k1 <- plot_distributions(piv_k1)
    print_plot(object = plot_k1, filename = filename, width = 10, height = 7)
    
    filename <- "mean-TPM-dists.2023-0630.group-k2.pdf"
    plot_k2 <- plot_distributions(piv_k2)
    print_plot(object = plot_k2, filename = filename, width = 10, height = 7)
    
    filename <- "mean-TPM-dists.2023-0630.group-k3.pdf"
    plot_k3 <- plot_distributions(piv_k3)
    print_plot(object = plot_k3, filename = filename, width = 10, height = 7)
}




groups <- paste0("k", 1:3)
ks_results <- list()
for(i in 1:length(groups)) {
    # i <- 1
    cat(
        paste0("Running intra-state KS tests for group \"", groups[i], "\"\n")
    )
    if(groups[i] == "k1") {
        tbl <- mean_TPM_k1
    } else if(groups[i] == "k2") {
        tbl <- mean_TPM_k2
    } else if(groups[i] == "k3") {
        tbl <- mean_TPM_k3
    }
    
    ks_results[[groups[i]]][["G1"]][["full"]] <-
        ks.test(tbl[, 2], tbl[, 3])
    ks_results[[groups[i]]][["G1"]][["p"]] <-
        ks_results[[groups[i]]][["G1"]][["full"]][["p.value"]]
    
    ks_results[[groups[i]]][["DSm2"]][["full"]] <-
        ks.test(tbl[, 4], tbl[, 5])
    ks_results[[groups[i]]][["DSm2"]][["p"]] <-
        ks_results[[groups[i]]][["DSm2"]][["full"]][["p.value"]]
    
    ks_results[[groups[i]]][["DSp2"]][["full"]] <-
        ks.test(tbl[, 6], tbl[, 7])
    ks_results[[groups[i]]][["DSp2"]][["p"]] <-
        ks_results[[groups[i]]][["DSp2"]][["full"]][["p.value"]]
    
    ks_results[[groups[i]]][["DSp24"]][["full"]] <-
        ks.test(tbl[, 8], tbl[, 9])
    ks_results[[groups[i]]][["DSp24"]][["p"]] <-
        ks_results[[groups[i]]][["DSp24"]][["full"]][["p.value"]]
    
    ks_results[[groups[i]]][["DSp48"]][["full"]] <-
        ks.test(tbl[, 10], tbl[, 11])
    ks_results[[groups[i]]][["DSp48"]][["p"]] <-
        ks_results[[groups[i]]][["DSp48"]][["full"]][["p.value"]]
    
    ks_results[[groups[i]]][["Q"]][["full"]] <-
        ks.test(tbl[, 12], tbl[, 13])
    ks_results[[groups[i]]][["Q"]][["p"]] <-
        ks_results[[groups[i]]][["Q"]][["full"]][["p.value"]]
    
    ks_results[[groups[i]]][["all_p"]] <- c(
        ks_results[[groups[i]]][["G1"]][["p"]],
        ks_results[[groups[i]]][["DSm2"]][["p"]],
        ks_results[[groups[i]]][["DSp2"]][["p"]],
        ks_results[[groups[i]]][["DSp24"]][["p"]],
        ks_results[[groups[i]]][["DSp48"]][["p"]],
        ks_results[[groups[i]]][["Q"]][["p"]]
    )
    names(ks_results[[groups[i]]][["all_p"]]) <-
        c("G1", "DSm2","DSp2","DSp24","DSp48", "Q")
    
    ks_results[[groups[i]]][["all_p_adj"]] <-
        p.adjust(ks_results[[groups[i]]][["all_p"]], method = "BH")
}


p_val_k1 <- ks_results[["k1"]][["all_p"]]
p_val_k2 <- ks_results[["k2"]][["all_p"]]
p_val_k3 <- ks_results[["k3"]][["all_p"]]

q_val_k1 <- ks_results[["k1"]][["all_p_adj"]]
q_val_k2 <- ks_results[["k2"]][["all_p_adj"]]
q_val_k3 <- ks_results[["k3"]][["all_p_adj"]]

all_p <- c(p_val_k1, p_val_k2, p_val_k3)
names(all_p) <- paste(
    c(rep("AG2_k1", 6), rep("AG3_k2", 6), rep("AG1_k3", 6)),
    names(all_p),
    sep = "_"
)
all_p

all_q <- p.adjust(all_p, method = "BH")
all_q


AG_group_1 <- all_p[13:18]
AG_group_2 <- all_p[1:6]
AG_group_3 <- all_p[7:12]
tbl_KS_p <- tibble::tribble(
   ~group_AG, ~group_KMC, ~G1, ~DSm2, ~DSp2, ~DSp24, ~DSp48, ~Q,
   "AG_group_1", "KMC_group_3", AG_group_1[1], AG_group_1[2],
   AG_group_1[3], AG_group_1[4], AG_group_1[5], AG_group_1[6],
   "AG_group_2", "KMC_group_1", AG_group_2[1], AG_group_2[2],
   AG_group_2[3], AG_group_2[4], AG_group_2[5], AG_group_2[6],
   "AG_group_3", "KMC_group_2", AG_group_3[1], AG_group_3[2],
   AG_group_3[3], AG_group_3[4], AG_group_3[5], AG_group_3[6]
)

AG_group_1 <- all_q[13:18]
AG_group_2 <- all_q[1:6]
AG_group_3 <- all_q[7:12]
tbl_KS_q <- tibble::tribble(
   ~group_AG, ~group_KMC, ~G1, ~DSm2, ~DSp2, ~DSp24, ~DSp48, ~Q,
   "AG_group_1", "KMC_group_3", AG_group_1[1], AG_group_1[2],
   AG_group_1[3], AG_group_1[4], AG_group_1[5], AG_group_1[6],
   "AG_group_2", "KMC_group_1", AG_group_2[1], AG_group_2[2],
   AG_group_2[3], AG_group_2[4], AG_group_2[5], AG_group_2[6],
   "AG_group_3", "KMC_group_2", AG_group_3[1], AG_group_3[2],
   AG_group_3[3], AG_group_3[4], AG_group_3[5], AG_group_3[6]
)

tbl_KS_p
tbl_KS_q

tbl_KS_p_desc <- tibble::as_tibble(ifelse(
    tbl_KS_p[, 3:ncol(tbl_KS_p)] < 0.001,
    "q < 0.001",
    ifelse(
        tbl_KS_p[, 3:ncol(tbl_KS_p)] < 0.005,
        "q < 0.005",
        ifelse(
            tbl_KS_p[, 3:ncol(tbl_KS_p)] < 0.01,
            "q < 0.01",
            ifelse(
                tbl_KS_p[, 3:ncol(tbl_KS_p)] < 0.05,
                "q < 0.05",
                "n.s."
            )
        )
    )
))
tbl_KS_p_desc <- tbl_KS_p_desc %>%
    dplyr::mutate(
        group_AG = paste("AG_group", 1:3, sep = "_"),
        group_KMC = paste("KMC_group", c(3, 1, 2), sep = "_")
    ) %>%
    dplyr::relocate(c(group_AG, group_KMC), .before = G1)

tbl_KS_q_desc <- tibble::as_tibble(ifelse(
    tbl_KS_q[, 3:ncol(tbl_KS_q)] < 0.001,
    "q < 0.001",
    ifelse(
        tbl_KS_q[, 3:ncol(tbl_KS_q)] < 0.005,
        "q < 0.005",
        ifelse(
            tbl_KS_q[, 3:ncol(tbl_KS_q)] < 0.01,
            "q < 0.01",
            ifelse(
                tbl_KS_q[, 3:ncol(tbl_KS_q)] < 0.05,
                "q < 0.05",
                "n.s."
            )
        )
    )
))
tbl_KS_q_desc <- tbl_KS_q_desc %>%
    dplyr::mutate(
        group_AG = paste("AG_group", 1:3, sep = "_"),
        group_KMC = paste("KMC_group", c(3, 1, 2), sep = "_")
    ) %>%
    dplyr::relocate(c(group_AG, group_KMC), .before = G1)

tbl_KS_p_desc
tbl_KS_q_desc

#  Write out tables of statistical significance values
write_significance_values <- FALSE  #ARGUMENT
if(base::isTRUE(write_significance_values)) {
    date <- "2023-0702"
    
    tbl_KS_p
    tbl_KS_q
    tbl_KS_p_desc
    tbl_KS_q_desc
    
    write_stats_table <- function(tbl) {
        readr::write_tsv(
            tbl,
            paste(
                "dists-Fig5C",
                date,
                stringr::str_replace_all(deparse(substitute(tbl)), "_", "-"),
                "tsv",
                sep = "."
            )
        )
    }
    
    
    write_stats_table(tbl_KS_p)
    write_stats_table(tbl_KS_q)
    write_stats_table(tbl_KS_p_desc)
    write_stats_table(tbl_KS_q_desc)
}


#  Write out feature lists (e.g., for GO analyses)
write_feature_lists_for_GO <- FALSE  #ARGUMENT
if(base::isTRUE(write_feature_lists_for_GO)) {
    date <- "2023-0626"
    
    #  mean_TPM_k1$features %>% length()  # 313
    readr::write_tsv(
        mean_TPM_k1$features %>% as.data.frame(),
        paste("heatmap-Fig5B", date, "gene-group-1.txt", sep = ".")
    )
    #  mean_TPM_k2$features %>% length()  # 629
    readr::write_tsv(
        mean_TPM_k2$features %>% as.data.frame(),
        paste("heatmap-Fig5B", date, "gene-group-2.txt", sep = ".")
    )
    #  mean_TPM_k3$features %>% length()  # 308
    readr::write_tsv(
        mean_TPM_k3$features %>% as.data.frame(),
        paste("heatmap-Fig5B", date, "gene-group-3.txt", sep = ".")
    )
}


write_heatmaps_from_KMC_then_HC <- FALSE  #ARGUMENT
if(base::isTRUE(write_heatmaps_from_KMC_then_HC)) {
    # mean_TPM_k1 %>% nrow()  # 313
    # df_k1[, 2:ncol(df_k1)] %>% nrow()  # 313
    date <- "2023-0626"
    width <- 7
    height <- 6.9666  # 313
    outfile <- paste("heatmap-Fig5B", date, "k-means-cluster-1", "pdf", sep = ".")
    pdf(file = outfile, width = width, height = height)
    print(heat_h_k1)
    dev.off()
    
    # mean_TPM_k2 %>% nrow()  # 629
    # df_k2[, 2:ncol(df_k2)] %>% nrow()  # 629
    date <- "2023-0626"
    width <- 7
    height <- 14  # 629
    outfile <- paste("heatmap-Fig5B", date, "k-means-cluster-2", "pdf", sep = ".")
    pdf(file = outfile, width = width, height = height)
    print(heat_h_k2)
    dev.off()
    
    # mean_TPM_k3 %>% nrow()  # 308
    # df_k3[, 2:ncol(df_k3)] %>% nrow()  # 308
    date <- "2023-0626"
    width <- 7
    height <- 6.8553  # 308
    outfile <- paste("heatmap-Fig5B", date, "k-means-cluster-3", "pdf", sep = ".")
    pdf(file = outfile, width = width, height = height)
    print(heat_h_k3)
    dev.off()
}


load_and_plot_GO_results <- FALSE  #ARGUMENT
if(base::isTRUE(load_and_plot_GO_results)) {
    load_yeastmine_results <- function(file) {
        df <- readr::read_tsv(
            file,
            col_names = c("term", "q_BH", "features", "n_GO"),
            show_col_types = FALSE
        )
        
        return(df)
    }
    
    
    plot_top_terms <- function(df, top_n) {
        #  Perform debugging
        run <- FALSE
        if(base::isTRUE(run)) {
            top_n <- 15
            df <- group_1
        }
        
        p <- df %>%
            dplyr::mutate(q = -log10(q_BH)) %>%
            dplyr::arrange(desc(q)) %>%
            dplyr::slice_head(n = top_n) %>%
            ggplot2::ggplot(aes(x = reorder(term, q), y = q)) +
            geom_bar(stat = "identity") +
            coord_flip() +
            xlab("") +
            ylab("-log10(q)") +
            ggtitle(paste(
                "GO terms:",
                deparse(substitute(df)) %>%
                    gsub("df_", "", .) %>%
                    gsub("_", ", ", .) %>%
                    gsub("BP, ", "", .)
            )) +
            theme_minimal()
        
        return(p)
    }
    
    top_n <- 15
    date <- "2023-0626"
    p_GO <- "notebook/KA.2023-0626.Fig5.k-means-heatmaps_ratios-TPM"
    
    group <- 1
    f_GO <- paste(
        "heatmap-Fig5B",
        date,
        paste0("gene-group-", group),
        "yeastmine-GO.tsv",
        sep = "."
    )
    
    group_1 <- load_yeastmine_results(paste(p_GO, f_GO, sep = "/"))
    plot_GO_group_1 <- plot_top_terms(group_1, top_n)
    
    group <- 2
    f_GO <- paste(
        "heatmap-Fig5B",
        date,
        paste0("gene-group-", group),
        "yeastmine-GO.tsv",
        sep = "."
    )
    
    group_2 <- load_yeastmine_results(paste(p_GO, f_GO, sep = "/"))
    plot_GO_group_2 <- plot_top_terms(group_2, top_n)
    
    group <- 3
    f_GO <- paste(
        "heatmap-Fig5B",
        date,
        paste0("gene-group-", group),
        "yeastmine-GO.tsv",
        sep = "."
    )
    
    group_3 <- load_yeastmine_results(paste(p_GO, f_GO, sep = "/"))
    plot_GO_group_3 <- plot_top_terms(group_3, top_n)
}
