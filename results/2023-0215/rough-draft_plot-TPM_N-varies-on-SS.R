#!/usr/bin/env Rscript

#  rough-draft_plot-TPM_N-varies-on-SS.R
#  KA


#  Load libraries, set options ================================================
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
load_TPM <- function(
    p_TPM = "results/2023-0215/notebook/KA.2023-0628.Fig1-5.PCA-TPM", f_TPM
) {
    readr::read_tsv(
        paste(p_TPM, f_TPM, sep = "/"),
        show_col_types = FALSE
    )
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
        # geom_hline(  # y = 0
        #     yintercept = 0,
        #     linetype = "solid",
        #     color = "#000000",
        #     size = 1
        # ) +
        # geom_vline(  # x = 0
        #     xintercept = 0,
        #     linetype = "solid",
        #     color = "#000000",
        #     size = 1
        # ) +
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
    debug <- TRUE
    if(base::isTRUE(debug)) {
        df = t_Tr_G1
        features = "Q"
        color = "#3A538833"
        xlab = "log2(TPM + 1) SS"
        ylab = "log2(TPM + 1) N"
        draw_density = TRUE
        x_low = 0
        x_high = 15
        y_low = 0
        y_high = 15
    }
    
    #  Create dataframe of features present in both samples
    vec_LFC_x <- df[[paste0(features, "_SS")]]
    vec_LFC_y <- df[[paste0(features, "_N")]]
    df_xy <- tibble::tibble(x = log2(vec_LFC_x + 1), y = log2(vec_LFC_y + 1))
    # df_xy <- tibble::tibble(x = vec_LFC_x + 1, y = vec_LFC_y + 1)
    
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
    scatter
    
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
    scatter_density
    
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


calculate_mean_TPMs <- function(df) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- t_mRNA
    }
    
    mean_G1_N <- df[
        , colnames(df) %in% c("WT_G1_N_rep1_tech1", "WT_G1_N_rep2_tech1")
    ]
    df[["G1_N"]] <- rowMeans(mean_G1_N)
    
    mean_G1_SS <- df[
        , colnames(df) %in% c("WT_G1_SS_rep1_tech1", "WT_G1_SS_rep2_tech1")
    ]
    df[["G1_SS"]] <- rowMeans(mean_G1_SS)
    
    mean_Q_N <- df[
        , colnames(df) %in% c("WT_Q_N_rep1_tech1", "WT_Q_N_rep2_tech1")
    ]
    df[["Q_N"]] <- rowMeans(mean_Q_N)
    
    mean_Q_SS <- df[
        , colnames(df) %in% c("WT_Q_SS_rep1_tech1", "WT_Q_SS_rep2_tech1")
    ]
    df[["Q_SS"]] <- rowMeans(mean_Q_SS)
    
    return(df)
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
p_TPM <- "notebook/KA.2023-0628.Fig1-5.PCA-TPM"
f_mRNA <- "data.2023-0628__Ovation__mRNA.counts-TPM.tsv"
f_pancRNA <- "data.2023-0628__Ovation__pa-ncRNA.counts-TPM.tsv"
f_Tr_Q <- "data.2023-0628__Ovation__Trinity-Q.counts-TPM.tsv"
f_Tr_G1 <- "data.2023-0628__Ovation__Trinity-G1.counts-TPM.tsv"

t_mRNA <- load_TPM(p_TPM, f_mRNA)
t_pancRNA <- load_TPM(p_TPM, f_pancRNA)
t_Tr_Q <- load_TPM(p_TPM, f_Tr_Q)
t_Tr_G1 <- load_TPM(p_TPM, f_Tr_G1)

colnames(t_mRNA)
colnames(t_pancRNA)
colnames(t_Tr_Q)
colnames(t_Tr_G1)

t_mRNA <- calculate_mean_TPMs(t_mRNA)
t_pancRNA <- calculate_mean_TPMs(t_pancRNA)
t_Tr_Q <- calculate_mean_TPMs(t_Tr_Q)
t_Tr_G1 <- calculate_mean_TPMs(t_Tr_G1)
