
#  rough-draft_draw_scatter-plots.R
#  KA

#  Load libraries, set options ================================================
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
plot_scatter <- function(
    x = x,
    y = y,
    lm = linear_model,
    r = r,
    m = m,
    color = "#06636833",
    xlab = "log2(FC) nascent",
    ylab = "log2(FC) steady state",
    x_low = -5,
    x_high = 7,
    y_low = -5,
    y_high = 7
) {
    z <- ggplot(tmp, aes(x = x, y = y)) +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            size = 1
        ) +
        geom_hline(  # y = 0
            yintercept = 0,
            linetype = "solid",
            color = "#000000",
            size = 1
        ) +
        geom_vline(  # x = 0
            xintercept = 0,
            linetype = "solid",
            color = "#000000",
            size = 1
        ) +
        geom_point(size = 2.5, color = color) +
        # geom_density_2d(color = "#FFFFFF") +
        geom_abline(  # linear regression (linear_model) slope and intercept
            slope = coefficients(lm)[2],
            intercept = coefficients(lm)[1],
            linetype = "dotdash",
            color = "#B40400",
            alpha = 0.8,
            size = 6
        ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste("Pearson =", r),
            fontface = "bold"
        ) +
        annotate(  # label the regression coefficient
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = paste("m =", m),
            fontface = "bold"
        ) +
        xlim(x_low, x_high) +
        ylim(y_low, y_high) +
        xlab(xlab) +
        ylab(ylab) +
        theme_AG_boxed_no_legend
    
    return(z)
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
        panel.border = element_rect(colour = "black", fill = NA, size = 2)
    )

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")

theme_AG_no_legend <- theme_AG + theme(legend.position = "none")

theme_AG_boxed_no_legend <- theme_AG_boxed + theme(legend.position = "none")


#  Get situated, load RDS files ===============================================
#  Set work dir
p_base <- "/Users/kalavatt/projects-etc"
p_exp <- "2022_transcriptome-construction/results/2023-0215"

paste(p_base, p_exp, sep = "/") %>% setwd()

#  Load RDS files
p_RDS <- "notebook/KA.2023-0608.rds-data-objects_min-4-cts-all-but-1-samps"
p_mRNA <- "rds_mRNA"
p_mRNA_AS <- "rds_mRNA_AS"
p_ncRNAcm <- "rds_pa-ncRNA-collapsed-merged"

mRNA_N_Q_r6n <- readRDS(paste(
    p_RDS,
    p_mRNA,
    "DGE-analysis_mRNA_N-Q-rrp6∆_N-Q-WT.rds",
    sep = "/"
))
mRNA_SS_Q_r6n <- readRDS(paste(
    p_RDS,
    p_mRNA,
    "DGE-analysis_mRNA_SS-Q-rrp6∆_SS-Q-WT.rds",
    sep = "/"
))
mRNA_SS_G1_r6n <- readRDS(paste(
    p_RDS,
    p_mRNA,
    "DGE-analysis_mRNA_SS-G1-rrp6∆_SS-G1-WT.rds",
    sep = "/"
))
mRNA_N_Q_n3d <- readRDS(paste(
    p_RDS,
    p_mRNA,
    "DGE-analysis_mRNA_N-Q-nab3d_N-Q-parental.rds",
    sep = "/"
))
mRNA_SS_Q_n3d <- readRDS(paste(
    p_RDS,
    p_mRNA,
    "DGE-analysis_mRNA_SS-Q-nab3d_SS-Q-parental.rds",
    sep = "/"
))

ncRNAcm_N_Q_r6n <- readRDS(paste(
    p_RDS,
    p_ncRNAcm,
    "DGE-analysis_pa-ncRNA-collapsed-merged_N-Q-rrp6∆_N-Q-WT.rds",
    sep = "/"
))
ncRNAcm_SS_Q_r6n <- readRDS(paste(
    p_RDS,
    p_ncRNAcm,
    "DGE-analysis_pa-ncRNA-collapsed-merged_SS-Q-rrp6∆_SS-Q-WT.rds",
    sep = "/"
))
ncRNAcm_SS_G1_r6n <- readRDS(paste(
    p_RDS,
    p_ncRNAcm,
    "DGE-analysis_pa-ncRNA-collapsed-merged_SS-G1-rrp6∆_SS-G1-WT.rds",
    sep = "/"
))
ncRNAcm_N_Q_n3d <- readRDS(paste(
    p_RDS,
    p_ncRNAcm,
    "DGE-analysis_pa-ncRNA-collapsed-merged_N-Q-nab3d_N-Q-parental.rds",
    sep = "/"
))
ncRNA_SS_Q_n3d <- readRDS(paste(
    p_RDS,
    p_ncRNAcm,
    "DGE-analysis_pa-ncRNA-collapsed-merged_SS-Q-nab3d_SS-Q-parental.rds",
    sep = "/"
))

`mRNA-AS_N_Q_n3d` <- readRDS(paste(
    p_RDS,
    p_mRNA_AS,
    "DGE-analysis_mRNA-antisense_N-Q-nab3d_N-Q-parental.rds",
    sep = "/"
))

rm(list = ls(pattern = "p_"))


#TODO Plot/assess the following comparisons ===================================
#+ 5 -  SS_Q_r6n ~ SS_Q_n3d    (y ~ x): 
#+ 4 -   N_Q_n3d ~  N_Q_n3d_AS (y ~ x): mRNA_N_Q_n3d,  `mRNA-AS_N_Q_n3d`
#+ 1 - SS_G1_r6n ~ SS_Q_r6n    (y ~ x): mRNA_SS_G1_r6n, mRNA_SS_Q_r6n; ncRNAcm_SS_G1_r6n, ncRNAcm_SS_Q_r6n
#+ 2 -  SS_Q_r6n ~  N_Q_r6n    (y ~ x): mRNA_SS_Q_r6n,  mRNA_N_Q_r6n; ncRNAcm_SS_G1_r6n,  ncRNAcm_N_Q_r6n
#+ 3 -  SS_Q_r6n ~  N_Q_n3d    (y ~ x): mRNA_SS_Q_r6n,  mRNA_N_Q_n3d; ncRNAcm_SS_G1_r6n,  ncRNAcm_N_Q_n3d

#  Color rules: "If all Steady State use purple 481A6C: if all Nascent, then 
#+ use blue 3A5388."


#  Draw volcanoes -------------------------------------------------------------
run <- FALSE
if(base::isTRUE(run)) {
    #  Draw volcano: N Q rrp6
    dge_N_Q_r6n <- N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
    plot_volcano(
        table = dge_N_Q_r6n,
        label = NA,
        selection = "",
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = 1.5,
        xlim = c(-5, 10),
        ylim = c(0, 60),
        color = c("#DFDFDF", "#DFDFDF", "#DFDFDF", "#3A538B"),
        pointSize = 2.5,
        title = "",
        subtitle = ""
    )
    
    #  Draw volcano: SS Q rrp6∆
    dge_SS_Q_r6n <- N_SS_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
    plot_volcano(
        table = dge_SS_Q_r6n,
        label = NA,
        selection = "",
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = 1.5,
        xlim = c(-5, 10),
        ylim = c(0, 60),
        color = c("#DFDFDF", "#DFDFDF", "#DFDFDF", "#481A6C"),
        pointSize = 2.5,
        title = "",
        subtitle = ""
    )
}


#  Draw scatter plots and do linear modeling ----------------------------------
#TODO "Function-ize" the following code
#TODO Save metrics, plot objects to list object that is output as rds

#  Look at N Q Nab3-AID (mRNA) ~ N Q Nab3-AID (mRNA antisense)
#+ (N_Q_n3d ~ N_Q_n3d_AS)
dge_mRNA_N_Q_n3d <- mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
`dge_mRNA-AS_N_Q_n3d` <- `mRNA-AS_N_Q_n3d`$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "x" = dge_mRNA_N_Q_n3d[
        dge_mRNA_N_Q_n3d$features %in% `dge_mRNA-AS_N_Q_n3d`$features, 
    ]$log2FoldChange,
    "y" = `dge_mRNA-AS_N_Q_n3d`[
        `dge_mRNA-AS_N_Q_n3d`$features %in% dge_mRNA_N_Q_n3d$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#3A538833",
    xlab = "log2(FC) mRNA antisense",
    ylab = "log2(FC) mRNA",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)


#  Look at SS Q rrp6∆ ~ N Q rrp6∆ (SS_Q_r6n ~ N_Q_r6n) for mRNA
dge_mRNA_N_Q_r6n <- mRNA_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_mRNA_SS_Q_r6n <- mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "y" = dge_mRNA_SS_Q_r6n[
        dge_mRNA_SS_Q_r6n$features %in% dge_mRNA_N_Q_r6n$features, 
    ]$log2FoldChange,
    "x" = dge_mRNA_N_Q_r6n[
        dge_mRNA_N_Q_r6n$features %in% dge_mRNA_SS_Q_r6n$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#06636833",
    xlab = "log2(FC) nascent",
    ylab = "log2(FC) steady state",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)


#  Look at SS Q rrp6∆ ~ N Q rrp6∆ (SS_Q_r6n ~ N_Q_r6n) for pa-ncRNA
dge_ncRNAcm_N_Q_r6n <- ncRNAcm_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_ncRNAcm_SS_Q_r6n <- ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "y" = dge_ncRNAcm_SS_Q_r6n[
        dge_ncRNAcm_SS_Q_r6n$features %in% dge_ncRNAcm_N_Q_r6n$features, 
    ]$log2FoldChange,
    "x" = dge_ncRNAcm_N_Q_r6n[
        dge_ncRNAcm_N_Q_r6n$features %in% dge_ncRNAcm_SS_Q_r6n$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#06636833",
    xlab = "log2(FC) nascent",
    ylab = "log2(FC) steady state",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)


#  Look at SS Q rrp6∆ ~ N Q nab3d for mRNA
dge_mRNA_N_Q_n3d <- mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_mRNA_SS_Q_r6n <- mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "y" = dge_mRNA_SS_Q_r6n[
        dge_mRNA_SS_Q_r6n$features %in% dge_mRNA_N_Q_n3d$features, 
    ]$log2FoldChange,
    "x" = dge_mRNA_N_Q_n3d[
        dge_mRNA_N_Q_n3d$features %in% dge_mRNA_SS_Q_r6n$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#06636833",
    xlab = "log2(FC) nascent nab3d/WT",
    ylab = "log2(FC) steady state rrp6n/WT",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)

#  Look at SS Q rrp6∆ ~ N Q nab3d for pa-ncRNA
dge_ncRNAcm_N_Q_n3d <- ncRNAcm_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_ncRNAcm_SS_Q_r6n <- ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "y" = dge_ncRNAcm_SS_Q_r6n[
        dge_ncRNAcm_SS_Q_r6n$features %in% dge_ncRNAcm_N_Q_n3d$features, 
    ]$log2FoldChange,
    "x" = dge_ncRNAcm_N_Q_n3d[
        dge_ncRNAcm_N_Q_n3d$features %in% dge_ncRNAcm_SS_Q_r6n$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#06636833",
    xlab = "log2(FC) nascent nab3d/WT",
    ylab = "log2(FC) steady state rrp6n/WT",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)


#  Look at SS_G1_r6n ~ SS_Q_r6n for mRNA
dge_mRNA_SS_G1_r6n <- mRNA_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_mRNA_SS_Q_r6n <- mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "y" = dge_mRNA_SS_G1_r6n[
        dge_mRNA_SS_G1_r6n$features %in% dge_mRNA_SS_Q_r6n$features, 
    ]$log2FoldChange,
    "x" = dge_mRNA_SS_Q_r6n[
        dge_mRNA_SS_Q_r6n$features %in% dge_mRNA_SS_G1_r6n$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#481A6C33",
    xlab = "Q log2(FC) steady state rrp6n/WT",
    ylab = "G1 log2(FC) steady state rrp6n/WT",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)

#  Look at SS_G1_r6n ~ SS_Q_r6n for pa-ncRNA
dge_ncRNAcm_SS_G1_r6n <- ncRNAcm_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
dge_ncRNAcm_SS_Q_r6n <- ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
tmp <- tibble::tibble(
    "y" = dge_ncRNAcm_SS_G1_r6n[
        dge_ncRNAcm_SS_G1_r6n$features %in% dge_ncRNAcm_SS_Q_r6n$features, 
    ]$log2FoldChange,
    "x" = dge_ncRNAcm_SS_Q_r6n[
        dge_ncRNAcm_SS_Q_r6n$features %in% dge_ncRNAcm_SS_G1_r6n$features, 
    ]$log2FoldChange
)

linear_model <- lm(tmp$y ~ tmp$x)
lm_summary <- summary(linear_model)
m <- linear_model$coefficients[["tmp$x"]]
r_sq <- lm_summary$adj.r.squared
rho <- cor(tmp$y, tmp$x, method = "spearman")
r <- cor(tmp$y, tmp$x, method = "pearson")

plot_scatter(
    x = x,
    y = y,
    lm = linear_model,
    r = round(r, 2),
    m = round(m, 2),
    color = "#481A6C33",
    xlab = "Q log2(FC) steady state rrp6n/WT",
    ylab = "G1 log2(FC) steady state rrp6n/WT",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)


#  Count the numbers of sig. up- and downregulated features ===================
#TODO Move to another script
count_sig_up <- function(df) {
    n_up <- df %>%
        dplyr::filter(padj < 0.05 & log2FoldChange > 1.5) %>%
        nrow()
    
    return(n_up)
}


count_sig_down <- function(df) {
    n_down <- df %>%
        dplyr::filter(padj < 0.05 & log2FoldChange < -1.5) %>%
        nrow()
    
    return(n_down)
}


count_sig_up(dge_mRNA_N_Q_n3d)
count_sig_down(dge_mRNA_N_Q_n3d)

count_sig_up(dge_mRNA_N_Q_r6n)
count_sig_down(dge_mRNA_N_Q_r6n)

count_sig_up(dge_mRNA_SS_G1_r6n)
count_sig_down(dge_mRNA_SS_G1_r6n)

count_sig_up(dge_mRNA_SS_Q_r6n)
count_sig_down(dge_mRNA_SS_Q_r6n)


count_sig_up(dge_ncRNAcm_N_Q_n3d)
count_sig_down(dge_ncRNAcm_N_Q_n3d)

count_sig_up(dge_ncRNAcm_N_Q_r6n)
count_sig_down(dge_ncRNAcm_N_Q_r6n)

count_sig_up(dge_ncRNAcm_SS_G1_r6n)
count_sig_down(dge_ncRNAcm_SS_G1_r6n)

count_sig_up(dge_ncRNAcm_SS_Q_r6n)
count_sig_down(dge_ncRNAcm_SS_Q_r6n)


count_sig_up(dge_mRNA_N_Q_n3d)
count_sig_down(`dge_mRNA-AS_N_Q_n3d`)
