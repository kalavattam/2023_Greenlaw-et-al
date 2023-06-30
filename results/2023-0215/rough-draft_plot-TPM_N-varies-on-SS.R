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


plot_scatter_N_SS <- function(
    df = t_mRNA,
    col_SS = G1_SS,
    col_N = G1_N,
    lm = linear_model,
    r = r,
    equation = lm_equation,
    r_sq = lm_r_sq,
    color = "#A0DA3990",
    x_lab = "log2(TPM + 1) SS",
    y_lab = "log2(TPM + 1) N",
    draw_density = FALSE,
    x_low = 0,
    x_high = 16,
    y_low = 0,
    y_high = 16
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df = t_mRNA
        col_SS = t_mRNA$G1_SS
        col_N = t_mRNA$G1_N
        lm = linear_model
        r = round(r, 2)
        equation = lm_equation
        r_sq = round(lm_r_sq, 3)
        color = "#A0DA3990"
        x_lab = "log2(TPM + 1) SS"
        y_lab = "log2(TPM + 1) N"
        draw_density = FALSE
        x_low = 0
        x_high = 16
        y_low = 0
        y_high = 16
    }
    
    if(base::isFALSE(debug)) {
        col_SS <- enquo(col_SS)
        col_N <- enquo(col_N)
    }
    
    scatter <- ggplot(
        df,
        aes(
            x = { if(base::isTRUE(debug)) col_SS else (!!col_SS) },
            y = { if(base::isTRUE(debug)) col_N else (!!col_N) }
        )
    ) +
        geom_point(size = 2.5, col = "#00000020") +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_smooth(
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            color = color,
            linetype = "dotdash",
            fullrange = TRUE,
            alpha = 0.8,
            size = 6
        ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste("Pearson r =", r),
            fontface = "bold"
        ) +
        annotate(  # label the model equation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = equation,
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.7,
            size = 7,
            label = bquote(r^2 ~ "=" ~ .(r_sq)),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    
    if(base::isTRUE(debug)) scatter
    return(scatter)
}


plot_lines <- function(df = t_mRNA) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df = t_mRNA
    }
    
    lines <- ggplot() +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_smooth(
            data = df,
            aes(x = log2(G1_SS + 1), y = log2(G1_N + 1)),
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            color = "#A0DA3990",
            linetype = "dotdash",
            fullrange = TRUE,
            size = 6
        ) +
        geom_smooth(
            data = df,
            aes(x = log2(Q_SS + 1), y = log2(Q_N + 1)),
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            color = "#277F8E90",
            linetype = "dotdash",
            fullrange = TRUE,
            size = 6
        ) +
        xlim(c(0, 16)) +
        ylim(c(0, 16)) +
        labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N") +
        theme_AG_boxed
    
    if(base::isTRUE(debug)) lines
    return(lines)
}


model_plot_scatter_N_SS <- function(
    df,
    features,
    color = "#06636833",
    x_lab = "log2(TPM + 1) SS",
    y_lab = "log2(TPM + 1) N",
    x_low = 0,
    x_high = 17,
    y_low = 0,
    y_high = 17
) {
    # ...
    # 
    # :param df: ... <data.frame>
    # :param features: ... <chr>
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
        df = t_pancRNA
        features = "Q"
        color = "#A0DA3990"
        x_lab = "log2(TPM + 1) SS"
        y_lab = "log2(TPM + 1) N"
        x_low = 0
        x_high = 17
        y_low = 0
        y_high = 17
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
    scatter <- plot_scatter_N_SS(
        df = df_xy,
        col_SS = x,
        col_N = y,
        lm = linear_model,
        r = round(r, 2),
        equation = lm_equation,
        r_sq = round(lm_r_sq, 3),
        color = color,
        x_lab = x_lab,
        y_lab = y_lab,
        draw_density = FALSE,
        x_low = x_low,
        x_high = x_high,
        y_low = y_low,
        y_high = y_high
    )
    if(base::isTRUE(debug)) scatter
    
    #  Draw scatter plot with density-line overlay
    scatter_density <- plot_scatter_N_SS(
        df = df_xy,
        col_SS = x,
        col_N = y,
        lm = linear_model,
        r = round(r, 2),
        equation = lm_equation,
        r_sq = round(lm_r_sq, 3),
        color = color,
        x_lab = x_lab,
        y_lab = y_lab,
        draw_density = TRUE,
        x_low = x_low,
        x_high = x_high,
        y_low = y_low,
        y_high = y_high
    )
    if(base::isTRUE(debug)) scatter_density
    
    compare_lines <- plot_lines(df)
    if(base::isTRUE(debug)) compare_lines
    
    #  Return results
    results_list <- list()
    results_list[["01_df"]] <- df
    results_list[["01_features"]] <- features
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
    results_list[["05_compare_lines"]] <- compare_lines
    
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
if(stringr::str_detect(getwd(), "kalavattam")) {
    p_base <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_base <- "/Users/kalavatt/projects-etc"
}
p_exp <- "2022_transcriptome-construction/results/2023-0215"

paste(p_base, p_exp, sep = "/") %>% setwd()

#  Load tsv files
p_TPM <- "notebook/KA.2023-0628.Fig1-5.PCA-TPM"
f_mRNA <- "data.2023-0628__Ovation__mRNA.counts-TPM.tsv"
f_pancRNA <- "data.2023-0628__Ovation__pa-ncRNA.counts-TPM.tsv"
f_Tr_Q <- "data.2023-0628__Ovation__Trinity-Q.counts-TPM.tsv"
f_Tr_G1 <- "data.2023-0628__Ovation__Trinity-G1.counts-TPM.tsv"

#  Initialize TPM dataframes for each assembly/annotation
t_mRNA <- load_TPM(p_TPM, f_mRNA)
t_pancRNA <- load_TPM(p_TPM, f_pancRNA)
t_Tr_Q <- load_TPM(p_TPM, f_Tr_Q)
t_Tr_G1 <- load_TPM(p_TPM, f_Tr_G1)

#  Calculate columns of sample-specific mean TPM values
t_mRNA <- calculate_mean_TPMs(t_mRNA)
t_pancRNA <- calculate_mean_TPMs(t_pancRNA)
t_Tr_Q <- calculate_mean_TPMs(t_Tr_Q)
t_Tr_G1 <- calculate_mean_TPMs(t_Tr_G1)


#  Draw scatter plots, make scatter-plot data objects
run <- FALSE
if(base::isTRUE(run)) {
    s_mRNA_Q <- model_plot_scatter_N_SS(df = t_mRNA, features = "Q")
    s_mRNA_G1 <- model_plot_scatter_N_SS(df = t_mRNA, features = "G1")
    
    s_mRNA_Q$`05_scatter`
    s_mRNA_G1$`05_scatter`
    
    # s_mRNA_Q$`05_scatter_density`
    # s_mRNA_G1$`05_scatter_density`
}

run <- FALSE
if(base::isTRUE(run)) {
    list_lm_t <- list()
    types <- c("mRNA", "pancRNA", "Tr_Q", "Tr_G1")
    for (i in 1:length(types)) {
        # i <- 2
        if(types[i] == "mRNA") {
            df <- t_mRNA
        } else if(types[i] == "pancRNA") {
            df <- t_pancRNA
        } else if(types[i] == "Tr_Q") {
            df <- t_Tr_Q
        } else if(types[i] == "Tr_G1") {
            df <- t_Tr_G1
        }
        
        model_scatter_G1 <- model_plot_scatter_N_SS(
            df = df,
            features = "G1",
            color = "#A0DA3990",
            x_high = 16,
            y_high = 16
        )
        model_scatter_Q <- model_plot_scatter_N_SS(
            df = df,
            features = "Q",
            color = "#277F8E90",
            x_high = 16,
            y_high = 16
        )
        lines_G1_Q <- plot_lines(df)
        
        list_lm_t[[types[i]]][["model_scatter_G1"]] <- model_scatter_G1
        list_lm_t[[types[i]]][["model_scatter_Q"]] <- model_scatter_Q
        list_lm_t[[types[i]]][["lines_G1_Q"]] <- lines_G1_Q
        
        for(j in 1:2) {
            # j <- 2
            if(j == 1) {
                cat(paste0(types[i], ": Testing for y intercept\n"))
                descriptor <- "b"
            } else {
                cat(paste0(types[i], ": Testing for slope\n"))
                descriptor <- "m"
            }
            
            lm_G1 <- lm(log2(df$G1_N + 1) ~ log2(df$G1_SS + 1))
            lm_Q <- lm(log2(df$Q_N + 1) ~ log2(df$Q_SS + 1))
            
            res_G1 <- residuals(lm_G1)
            res_Q <- residuals(lm_Q)
            
            #  Evaluate homoscedasticity and normality of residuals
            hist_G1 <- hist(res_G1)
            hist_Q <- hist(res_Q)
            
            qq_G1 <- car::qqPlot(res_G1, col.lines = "#A0DA39")
            qq_Q <- car::qqPlot(res_Q, col.lines = "#277F8E")
            
            qq_G1_val <- qqnorm(residuals(lm_G1))
            qq_Q_val <- qqnorm(residuals(lm_Q))
            
            coef_lm_G1 <- coef(lm_G1)[j]
            coef_lm_Q <- coef(lm_Q)[j]
            
            cov_lm_G1 <- vcov(lm_G1)
            cov_lm_Q <- vcov(lm_Q)
            
            SE_lm_G1 <- sqrt(cov_lm_G1[j, j])
            SE_lm_Q <- sqrt(cov_lm_Q[j, j])
            
            SE_diff <- sqrt(SE_lm_G1^2 + SE_lm_Q^2)
            
            t_stat <- (coef_lm_G1 - coef_lm_Q) / SE_diff
            deg_free <- nrow(t_mRNA) - 2
            p_value <- 2 * pt(-abs(t_stat), deg_free)
            
            
            list_lm_t[[types[i]]][[descriptor]][["lm_G1"]] <- lm_G1
            list_lm_t[[types[i]]][[descriptor]][["lm_Q"]] <- lm_Q
            list_lm_t[[types[i]]][[descriptor]][["res_G1"]] <- res_G1
            list_lm_t[[types[i]]][[descriptor]][["res_Q"]] <- res_Q
            list_lm_t[[types[i]]][[descriptor]][["hist_G1"]] <- hist_G1
            list_lm_t[[types[i]]][[descriptor]][["hist_Q"]] <- hist_Q
            list_lm_t[[types[i]]][[descriptor]][["qq_G1"]] <- qq_G1
            list_lm_t[[types[i]]][[descriptor]][["qq_Q"]] <- qq_Q
            list_lm_t[[types[i]]][[descriptor]][["qq_G1_val"]] <- qq_G1_val
            list_lm_t[[types[i]]][[descriptor]][["qq_Q_val"]] <- qq_Q_val
            list_lm_t[[types[i]]][[descriptor]][["coef_lm_G1"]] <- coef_lm_G1
            list_lm_t[[types[i]]][[descriptor]][["coef_lm_Q"]] <- coef_lm_Q
            list_lm_t[[types[i]]][[descriptor]][["cov_lm_G1"]] <- cov_lm_G1
            list_lm_t[[types[i]]][[descriptor]][["cov_lm_Q"]] <- cov_lm_Q
            list_lm_t[[types[i]]][[descriptor]][["SE_lm_G1"]] <- SE_lm_G1
            list_lm_t[[types[i]]][[descriptor]][["SE_lm_Q"]] <- SE_lm_Q
            list_lm_t[[types[i]]][[descriptor]][["SE_diff"]] <- SE_diff
            list_lm_t[[types[i]]][[descriptor]][["t_stat"]] <- t_stat
            list_lm_t[[types[i]]][[descriptor]][["deg_free"]] <- deg_free
            list_lm_t[[types[i]]][[descriptor]][["p_value"]] <-
                format(p_value, scientific = TRUE)
        }
    }
}

list_lm_t$mRNA$model_scatter_G1$`05_scatter`
list_lm_t$mRNA$model_scatter_Q$`05_scatter`

list_lm_t$pancRNA$model_scatter_G1$`05_scatter`
list_lm_t$pancRNA$model_scatter_Q$`05_scatter`

run <- TRUE
if(base::isTRUE(run)) {
    list_lm_t$mRNA$scatter_G1 %>% print()
    list_lm_t$mRNA$scatter_Q %>% print()
    list_lm_t$mRNA$lines_G1_Q %>% print()
}

run <- TRUE
if(base::isTRUE(run)) {
    list_lm_t$pancRNA$scatter_G1 %>% print()
    list_lm_t$pancRNA$scatter_Q %>% print()
    list_lm_t$pancRNA$lines_G1_Q %>% print()
}


run <- FALSE
if(base::isTRUE(run)) {
    list_lm_t$mRNA$b$p_value
    list_lm_t$pancRNA$b$p_value
    list_lm_t$Tr_Q$b$p_value
    list_lm_t$Tr_G1$b$p_value
    
    list_lm_t$mRNA$m$p_value
    list_lm_t$pancRNA$m$p_value
    list_lm_t$Tr_Q$m$p_value
    list_lm_t$Tr_G1$m$p_value
}
