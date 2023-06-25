
#  rough-draft_draw_scatter-plots.R
#  KA

#  Load libraries, set options ================================================
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
load_RDS_mRNA <- function(
    p_RDS = "notebook/KA.2023-0608.rds-data-objects_min-4-cts-all-but-1-samps",
    p_mRNA = "rds_mRNA",
    f_RDS
) {
    readRDS(paste(p_RDS, p_mRNA, f_RDS, sep = "/"))
}


load_RDS_ncRNA <- function(
    p_RDS = "notebook/KA.2023-0608.rds-data-objects_min-4-cts-all-but-1-samps",
    p_ncRNAcm = "rds_pa-ncRNA-collapsed-merged",
    f_RDS
) {
    readRDS(paste(p_RDS, p_ncRNAcm, f_RDS, sep = "/"))
}


plot_scatter <- function(
    df = df_xy,
    x = x,
    y = y,
    lm = linear_model,
    r = r,
    equation = lm_equation,
    r_sq = lm_r_sq,
    color = "#06636833",
    xlab = "log2(FC) nascent",
    ylab = "log2(FC) steady state",
    draw_density = FALSE,
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
) {
    scatter <- ggplot(df, aes(x = x, y = y)) +
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
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
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
            label = paste("Pearson r =", r) #,
            # fontface = "bold"
        ) +
        annotate(  # label the model equation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = equation #,
            # fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.7,
            size = 7,
            label = bquote(r^2 ~ "=" ~ .(r_sq)) #,
            # fontface = "bold"
        ) +
        xlim(x_low, x_high) +
        ylim(y_low, y_high) +
        xlab(xlab) +
        ylab(ylab) +
        theme_AG_boxed_no_legend
    
    return(scatter)
}


model_plot_scatter_log2FC <- function(
    x, y, color, xlab, ylab, x_low, x_high, y_low, y_high
) {
    # ...
    # 
    # :param x: sample on x axis <data.frame>
    # :param y: sample on y axis <data.frame>
    # :param color: ... <chr>
    # :param xlab: ... <chr>
    # :param ylab: ... <chr> 
    # :param x_low: ... <int (neg)>
    # :param x_high: ... <int (pos)>
    # :param y_low: ... <int (neg)>
    # :param y_high: ... <int (pos)>
    # :return results_list: ... <list>
    
    #  Debug
    debug <- FALSE
    if(base::isTRUE(debug)) {
        x = mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
        y = `mRNA-AS_N_Q_n3d`$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
        color = "#3A538833"
        xlab = "log2(FC) mRNA antisense"
        ylab = "log2(FC) mRNA"
        draw_density = TRUE
        x_low = -9
        x_high = 9
        y_low = -9
        y_high = 9
    }
    
    #  Create dataframe of features present in both samples
    vec_LFC_x <- x[x[["features"]] %in% y[["features"]], ][["log2FoldChange"]]
    vec_LFC_y <- y[y[["features"]] %in% x[["features"]], ][["log2FoldChange"]]
    df_xy <- tibble::tibble(x = vec_LFC_x, y = vec_LFC_y)
    
    #  Calculate linear model and correlation coefficients
    linear_model <- lm(df_xy$y ~ df_xy$x)
    lm_summary <- summary(linear_model)
    lm_coef <- linear_model$coefficients
    lm_m <- lm_coef[["df_xy$x"]]
    lm_intercept <- lm_coef[["(Intercept)"]]
    lm_equation <- paste(
        "y =",
        paste(
            round(lm_intercept, 2),
            paste(
                round(lm_m, 2),
                "x",  # names(lm_coef[-1]),
                sep = "",  # sep = " * ",
                collapse =" + "
            ),
            sep = " + "
        ),
        "+ e"  # "+ ϵ"
    )
    lm_r_sq <- lm_summary$adj.r.squared
    rho <- cor(df_xy$y, df_xy$x, method = "spearman")
    r <- cor(df_xy$y, df_xy$x, method = "pearson")
    
    #  Draw scatter plot
    scatter <- plot_scatter(
        df = df_xy,
        x = x,
        y = y,
        lm = linear_model,
        r = round(r, 2),
        equation = lm_equation,
        r_sq = round(lm_r_sq, 3),
        color = color,
        xlab = xlab,
        ylab = ylab,
        draw_density = FALSE,
        x_low = x_low,
        x_high = x_high,
        y_low = y_low,
        y_high = y_high
    )
    
    #  Draw scatter plot with density-line overlay
    scatter_density <- plot_scatter(
        df = df_xy,
        x = x,
        y = y,
        lm = linear_model,
        r = round(r, 2),
        equation = lm_equation,
        r_sq = round(lm_r_sq, 3),
        color = color,
        xlab = xlab,
        ylab = ylab,
        draw_density = TRUE,
        x_low = x_low,
        x_high = x_high,
        y_low = y_low,
        y_high = y_high
    )
    
    #  Return results
    results_list <- list()
    results_list[["01_x"]] <- x
    results_list[["01_y"]] <- y
    results_list[["02_vec_LFC_x"]] <- vec_LFC_x
    results_list[["02_vec_LFC_y"]] <- vec_LFC_y
    results_list[["02_df_xy"]] <- df_xy
    results_list[["03_a_linear_model"]] <- linear_model
    results_list[["03_b_lm_summary"]] <- lm_summary
    results_list[["03_c_lm_m"]] <- lm_m
    results_list[["03_d_lm_r_sq"]] <- lm_r_sq
    results_list[["03_e_lm_equation"]] <- lm_equation
    results_list[["04_cor_rho"]] <- rho
    results_list[["04_cor_r"]] <- r
    results_list[["05_scatter"]] <- scatter
    results_list[["05_scatter_density"]] <- scatter_density
    
    return(results_list)
}


output_rds <- function(
    list_obj,
    outfile = paste0(
        "/Users/kalavatt/Desktop", "/",
        deparse(substitute(list_obj)), ".rds"
    )
) {
    readr::write_rds(list_obj, outfile)
}


print_scatter <- function(
    dataframe,
    outpath = "/Users/kalavatt/Desktop",
    width = 7,
    height = 7
) {
    # ...
    #
    # :param dataframe: ...
    # :param outpath: ...
    # :param density: ...
    # :param width: ...
    # :param height: ...
    
    debug <- FALSE
    if(base::isTRUE(debug)) {
        dataframe = dataframe
        outpath = "/Users/kalavatt/Desktop"
        width = 7
        height = 7
    }
    
    part_1 <- unlist(stringr::str_split(deparse(substitute(dataframe)), "_"))[2]
    part_2 <- unlist(stringr::str_split(deparse(substitute(dataframe)), "_"))[3]
    part_3 <- unlist(stringr::str_split(deparse(substitute(dataframe)), "_"))[1]

    part_0 <- "scatter-density"
    
    file_prefix <- paste(part_0, part_1, part_2, part_3, sep = "_")
    outfile <- paste0(
        outpath, "/",
        file_prefix, ".",
        format(Sys.time(), format = "%F_%H.%M.%S"),
        ".pdf"
    )
    
    pdf(file = outfile, width = width, height = height)
    print(dataframe$`05_scatter_density`)
    dev.off()
    
    part_0 <- "scatter"

    file_prefix <- paste(part_0, part_1, part_2, part_3, sep = "_")
    outfile <- paste0(
        outpath, "/",
        file_prefix, ".",
        format(Sys.time(), format = "%F_%H.%M.%S"),
        ".pdf"
    )

    pdf(file = outfile, width = width, height = height)
    print(dataframe$`05_scatter`)
    dev.off()
}


model_plot_scatter_ORFs <-  function(
    df, color, plot_kb, xlab, ylab, x_low, x_high, y_low, y_high
) {
    # ...
    # 
    # :param x: sample on x axis <data.frame>
    # :param y: sample on y axis <data.frame>
    # :param color: ... <chr>
    # :param plot_kb: ... <lgl> 
    # :param xlab: ... <chr>
    # :param ylab: ... <chr> 
    # :param x_low: ... <int (neg)>
    # :param x_high: ... <int (pos)>
    # :param y_low: ... <int (neg)>
    # :param y_high: ... <int (pos)>
    # :return results_list: ... <list>
    
    #  Debug
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df = dge_mRNA_N_Q_n3d
        color = "#3A538833"
        plot_kb = TRUE
        xlab = "ORF length (kb)"
        ylab = "Nab3-AID/Parent\nlog2(FC) nascent"
        x_low = 0
        x_high = 15
        y_low = -3.5
        y_high = 8.5
    }
    
    #  Create dataframe of features present in both samples
    if(base::isTRUE(plot_kb)) {
        vec_LFC_x <- df[["width"]] / 1000
    } else {
        vec_LFC_x <- df[["width"]]
    }
    vec_LFC_y <- df[["log2FoldChange"]]
    
    df_xy <- tibble::tibble(x = vec_LFC_x, y = vec_LFC_y)
    
    #  Calculate linear model and correlation coefficients
    linear_model <- lm(df_xy$y ~ df_xy$x)
    lm_summary <- summary(linear_model)
    lm_coef <- linear_model$coefficients
    lm_m <- lm_coef[["df_xy$x"]]
    lm_intercept <- lm_coef[["(Intercept)"]]
    lm_equation <- paste(
        "y =",
        paste(
            round(lm_intercept, 2),
            paste(
                round(lm_m, 2),
                "x",  # names(lm_coef[-1]),
                sep = "",  # sep = " * ",
                collapse =" + "
            ),
            sep = " + "
        ),
        "+ e"  # "+ ϵ"
    )
    lm_r_sq <- lm_summary$adj.r.squared
    rho <- cor(df_xy$y, df_xy$x, method = "spearman")
    r <- cor(df_xy$y, df_xy$x, method = "pearson")
    
    #  Draw scatter plot
    scatter <- plot_scatter(
        df = df_xy,
        x = df_xy$x,
        y = df_xy$y,
        lm = linear_model,
        r = round(r, 2),
        equation = lm_equation,
        r_sq = round(lm_r_sq, 2),
        color = color,
        xlab = xlab,
        ylab = ylab,
        draw_density = FALSE,
        x_low = x_low,
        x_high = x_high,
        y_low = y_low,
        y_high = y_high
    )
    
    #  Draw scatter plot with density-line overlay
    scatter_density <- plot_scatter(
        df = df_xy,
        x = x,
        y = y,
        lm = linear_model,
        r = round(r, 2),
        equation = lm_equation,
        r_sq = round(lm_r_sq, 2),
        color = color,
        xlab = xlab,
        ylab = ylab,
        draw_density = TRUE,
        x_low = x_low,
        x_high = x_high,
        y_low = y_low,
        y_high = y_high
    )
    
    #  Return results
    results_list <- list()
    results_list[["02_vec_LFC_x"]] <- vec_LFC_x
    results_list[["02_vec_LFC_y"]] <- vec_LFC_y
    results_list[["02_df_xy"]] <- df_xy
    results_list[["03_a_linear_model"]] <- linear_model
    results_list[["03_b_lm_summary"]] <- lm_summary
    results_list[["03_c_lm_m"]] <- lm_m
    results_list[["03_d_lm_r_sq"]] <- lm_r_sq
    results_list[["03_e_lm_equation"]] <- lm_equation
    results_list[["04_cor_rho"]] <- rho
    results_list[["04_cor_r"]] <- r
    results_list[["05_scatter"]] <- scatter
    results_list[["05_scatter_density"]] <- scatter_density
    
    return(results_list)
}


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
ncRNAcm_SS_Q_n3d <- readRDS(paste(
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


#  Draw scatter plots and do linear modeling ----------------------------------
#  Look at SS Q rrp6∆ ~ N Q rrp6∆ (SS_Q_r6n ~ N_Q_r6n) for mRNA
`mRNA_SS-Q-r6n_N-Q-r6n` <- model_plot_scatter_log2FC(
    x = mRNA_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent",
    ylab = "log2(FC) steady state",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)

#  Look at SS Q rrp6∆ ~ N Q rrp6∆ (SS_Q_r6n ~ N_Q_r6n) for pa-ncRNA
`ncRNAcm_SS-Q-r6n_N-Q-r6n` <- model_plot_scatter_log2FC(
    x = ncRNAcm_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent",
    ylab = "log2(FC) steady state",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)

#  Look at SS Q rrp6∆ ~ N Q nab3d for mRNA
`mRNA_SS-Q-r6n_N-Q-n3d` <- model_plot_scatter_log2FC(
    x = mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent nab3d/WT",
    ylab = "log2(FC) steady state rrp6n/WT",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)

#  Look at SS Q rrp6∆ ~ N Q nab3d for pa-ncRNA
`ncRNAcm_SS-Q-r6n_N-Q-n3d` <- model_plot_scatter_log2FC(
    x = ncRNAcm_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent nab3d/WT",
    ylab = "log2(FC) steady state rrp6n/WT",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)

#  Look at SS Q rrp6∆ ~ SS Q nab3d for mRNA
`mRNA_SS-Q-r6n_SS-Q-n3d` <- model_plot_scatter_log2FC(
    x = mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent nab3d/WT",
    ylab = "log2(FC) steady state rrp6n/WT",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)

#  Look at SS Q rrp6∆ ~ SS Q nab3d for pa-ncRNA
`ncRNAcm_SS-Q-r6n_SS-Q-n3d` <- model_plot_scatter_log2FC(
    x = ncRNAcm_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent nab3d/WT",
    ylab = "log2(FC) steady state rrp6n/WT",
    x_low = -10,
    x_high = 10,
    y_low = -10,
    y_high = 10
)


#  Look at SS_G1_r6n ~ SS_Q_r6n for mRNA
`mRNA_SS-G1-r6n_SS-Q-r6n` <- model_plot_scatter_log2FC(
    x = mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = mRNA_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#481A6C33",
    xlab = "Q log2(FC) steady state rrp6n/WT",
    ylab = "G1 log2(FC) steady state rrp6n/WT",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)

#  Look at SS_G1_r6n ~ SS_Q_r6n for pa-ncRNA
`ncRNAcm_SS-G1-r6n_SS-Q-r6n` <- model_plot_scatter_log2FC(
    x = ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = ncRNAcm_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#481A6C33",
    xlab = "Q log2(FC) steady state rrp6n/WT",
    ylab = "G1 log2(FC) steady state rrp6n/WT",
    x_low = -7,
    x_high = 7,
    y_low = -7,
    y_high = 7
)

#  Look at N Q Nab3-AID mRNA ~ N Q Nab3-AID mRNA antisense
#+ (N_Q_n3d ~ N_Q_n3d_AS)
`mRNA-mRNA-AS_N-Q-n3d` <- model_plot_scatter_log2FC(
    x = mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = `mRNA-AS_N_Q_n3d`$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#3A538833",
    xlab = "log2(FC) mRNA antisense",
    ylab = "log2(FC) mRNA",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)

#  Look at SS Q Nab3-AID ~ N Q Nab3-AID for mRNA
`mRNA_SS-Q-n3d_N-Q-n3d` <- model_plot_scatter_log2FC(
    x = mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent n3d/parent",
    ylab = "log2(FC) steady state n3d/parent",
    x_low = -9,
    x_high = 9,
    y_low = -9,
    y_high = 9
)

#  Look at N SS Nab3-AID ~ N Q Nab3-AID for pa-ncRNA
`ncRNAcm_SS-Q-n3d_N-Q-n3d` <- model_plot_scatter_log2FC(
    x = ncRNAcm_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    y = ncRNAcm_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#06636833",
    xlab = "log2(FC) nascent n3d/parent",
    ylab = "log2(FC) steady state n3d/parent",
    x_low = -10,
    x_high = 10,
    y_low = -10,
    y_high = 10
)


#  Write out scatter-plot-etc lists as rds objects ----------------------------
output_rds(`mRNA_SS-Q-r6n_N-Q-r6n`)
output_rds(`ncRNAcm_SS-Q-r6n_N-Q-r6n`)
output_rds(`mRNA_SS-Q-r6n_N-Q-n3d`)
output_rds(`ncRNAcm_SS-Q-r6n_N-Q-n3d`)
output_rds(`mRNA_SS-Q-r6n_SS-Q-n3d`)
output_rds(`ncRNAcm_SS-Q-r6n_SS-Q-n3d`)
output_rds(`mRNA_SS-G1-r6n_SS-Q-r6n`)
output_rds(`ncRNAcm_SS-G1-r6n_SS-Q-r6n`)
output_rds(`mRNA-mRNA-AS_N-Q-n3d`)
output_rds(`mRNA_SS-Q-n3d_N-Q-n3d`)
output_rds(`ncRNAcm_SS-Q-n3d_N-Q-n3d`)


#  Write out pdfs of scatter plots --------------------------------------------
print_scatter(dataframe = `mRNA_SS-Q-r6n_N-Q-r6n`)
print_scatter(dataframe = `ncRNAcm_SS-Q-r6n_N-Q-r6n`)
print_scatter(dataframe = `mRNA_SS-Q-r6n_N-Q-n3d`)
print_scatter(dataframe = `ncRNAcm_SS-Q-r6n_N-Q-n3d`)
print_scatter(dataframe = `mRNA_SS-Q-r6n_SS-Q-n3d`)
print_scatter(dataframe = `ncRNAcm_SS-Q-r6n_SS-Q-n3d`)
print_scatter(dataframe = `mRNA_SS-G1-r6n_SS-Q-r6n`)
print_scatter(dataframe = `ncRNAcm_SS-G1-r6n_SS-Q-r6n`)
print_scatter(dataframe = `mRNA-mRNA-AS_N-Q-n3d`)
print_scatter(dataframe = `mRNA_SS-Q-n3d_N-Q-n3d`)
print_scatter(dataframe = `ncRNAcm_SS-Q-n3d_N-Q-n3d`)


check <- FALSE
if(base::isTRUE(check)) {
    `mRNA_SS-Q-r6n_N-Q-r6n`$`05_scatter_density`
    `ncRNAcm_SS-Q-r6n_N-Q-r6n`$`05_scatter_density`
    `mRNA_SS-Q-r6n_N-Q-n3d`$`05_scatter_density`
    `ncRNAcm_SS-Q-r6n_N-Q-n3d`$`05_scatter_density`
    `mRNA_SS-Q-r6n_SS-Q-n3d`$`05_scatter_density`
    `ncRNAcm_SS-Q-r6n_SS-Q-n3d`$`05_scatter_density`
    `mRNA_SS-G1-r6n_SS-Q-r6n`$`05_scatter_density`
    `ncRNAcm_SS-G1-r6n_SS-Q-r6n`$`05_scatter_density`
    `mRNA-mRNA-AS_N-Q-n3d`$`05_scatter_density`
    `mRNA_SS-Q-n3d_N-Q-n3d`$`05_scatter_density`
    `ncRNAcm_SS-Q-n3d_N-Q-n3d`$`05_scatter_density`
}


#  Custom work: Plot Nab3-AID/parent log2FC w/r/to ORF length =================
#  Color rules: "If all Steady State use purple 481A6C: if all Nascent, then 
#+ use blue 3A5388."

#  ...for Nab3-AID Nascent Q ------------------------------
#  Analyze all ORFs
`LFC-ORF_N-Q-n3d` <- model_plot_scatter_ORFs(
    df = mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#3A538833",
    plot_kb = TRUE,
    xlab = "ORF length (kb)",
    ylab = "Nab3-AID/Parent\nlog2(FC) nascent",
    x_low = 0,
    x_high = 15,
    y_low = -3.5,
    y_high = 8.5
)

#  Analyze ORFs up to 625 bp 
`LFC-ORF-625_N-Q-n3d` <- model_plot_scatter_ORFs(
    df = mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`[
        mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`$width <= 625, 
    ],
    color = "#3A538833",
    plot_kb = FALSE,
    xlab = "ORF length (bp)",
    ylab = "Nab3-AID/Parent\nlog2(FC) nascent",
    x_low = 0,
    x_high = 625,
    y_low = -3.5,
    y_high = 8.5
)


#  ...for Nab3-AID Nascent SS -----------------------------
`LFC-ORF_SS-Q-n3d` <- model_plot_scatter_ORFs(
    df = mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`,
    color = "#481A6C33",
    plot_kb = TRUE,
    xlab = "ORF length (kb)",
    ylab = "Nab3-AID/Parent\nlog2(FC) nascent",
    x_low = 0,
    x_high = 15,
    y_low = -3.5,
    y_high = 8.5
)

`LFC-ORF-625_SS-Q-n3d` <- model_plot_scatter_ORFs(
    df = mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`[
        mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`$width <= 625, 
    ],
    color = "#481A6C33",
    plot_kb = FALSE,
    xlab = "ORF length (bp)",
    ylab = "Nab3-AID/Parent\nlog2(FC) nascent",
    x_low = 0,
    x_high = 625,
    y_low = -3.5,
    y_high = 8.5
)

check <- FALSE
if(base::isTRUE(check)) {
    `LFC-ORF_N-Q-n3d`$`05_scatter_density`
    `LFC-ORF_SS-Q-n3d`$`05_scatter_density`
    `LFC-ORF-625_N-Q-n3d`$`05_scatter_density`
    `LFC-ORF-625_SS-Q-n3d`$`05_scatter_density`
}

print_scatter_ORFs <- function(
    dataframe,
    outpath = "/Users/kalavatt/Desktop",
    width = 7,
    height = 7
) {
    # ...
    #
    # :param dataframe: ...
    # :param outpath: ...
    # :param width: ...
    # :param height: ...
    part_1 <- deparse(substitute(dataframe))
    
    part_0 <- "scatter-density"
    
    file_prefix <- paste(part_0, part_1, sep = "_")
    outfile <- paste0(
        outpath, "/",
        file_prefix, ".",
        format(Sys.time(), format = "%F_%H.%M.%S"),
        ".pdf"
    )
    pdf(file = outfile, width = width, height = height)
    print(dataframe$`05_scatter_density`)
    dev.off()
    
    part_0 <- "scatter"
    
    file_prefix <- paste(part_0, part_1, sep = "_")
    outfile <- paste0(
        outpath, "/",
        file_prefix, ".",
        format(Sys.time(), format = "%F_%H.%M.%S"),
        ".pdf"
    )
    pdf(file = outfile, width = width, height = height)
    print(dataframe$`05_scatter`)
    dev.off()
}

    
print_scatter(dataframe = `LFC-ORF_N-Q-n3d`)
print_scatter(dataframe = `LFC-ORF_SS-Q-n3d`)
print_scatter(dataframe = `LFC-ORF-625_N-Q-n3d`)
print_scatter(dataframe = `LFC-ORF-625_SS-Q-n3d`)


#  Count the numbers of sig. up- and downregulated features ===================
#TODO Move to another script?
count_sig_up(mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 1417
count_sig_down(mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 27

count_sig_up(mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 2916
count_sig_down(mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 18

count_sig_up(mRNA_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 4
count_sig_down(mRNA_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 2

count_sig_up(mRNA_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 144
count_sig_down(mRNA_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 21

# count_sig_up(mRNA_SS_Q_r6n$`09_lfc_0_fc_1`$`04_t_DGE_unshrunken`)  # 1287
count_sig_up(mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 890
count_sig_down(mRNA_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 4


count_sig_up(ncRNAcm_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 2536
count_sig_down(ncRNAcm_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 10

count_sig_up(ncRNAcm_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 9
count_sig_down(ncRNAcm_N_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 1

count_sig_up(ncRNAcm_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 1206
count_sig_down(ncRNAcm_SS_G1_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 1

count_sig_up(ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 928
count_sig_down(ncRNAcm_SS_Q_r6n$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 3


count_sig_up(mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 1417
count_sig_down(`mRNA-AS_N_Q_n3d`$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`)  # 6


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