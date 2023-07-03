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


perform_lm_LOESS_MW_etc <- function(
    df = t_mRNA,
    degree = 2,
    span = 0.66,
    draw_density = FALSE,
    x_lab = "log2(TPM + 1) SS",
    y_lab = "log2(TPM + 1) N",
    x_low = 0,
    x_high = 16,
    y_low = 0,
    y_high = 16
) {
    #  Perform debugging
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- t_Tr_Q
        degree <- 2
        span <- 0.66
        draw_density <- FALSE
        x_lab <- "log2(TPM + 1) SS"
        y_lab <- "log2(TPM + 1) N"
        x_low <- 0
        x_high <- 17
        y_low <- 0
        y_high <- 17
    }
    
    #  Perform MWU test to compare N distributions to SS distributions --------
    `result_MWU_G1-N_Q-N` <- wilcox.test(
        log2(df[["G1_N"]] + 1), log2(df[["Q_N"]] + 1)
    )
    `result_MWU_G1-SS_Q-SS` <- wilcox.test(
        log2(df[["G1_SS"]] + 1), log2(df[["Q_SS"]] + 1)
    )
    `result_MWU_G1-N_G1-SS` <- wilcox.test(
        log2(df[["G1_N"]] + 1), log2(df[["G1_SS"]] + 1)
    )
    `result_MWU_Q-N_Q-SS` <- wilcox.test(
        log2(df[["Q_N"]] + 1), log2(df[["Q_SS"]] + 1)
    )
    
    `p_MWU_G1-N_Q-N` <- `result_MWU_G1-N_Q-N`[["p.value"]] %>%
        format(., scientific = TRUE) %>%
        as.numeric()
    `p_MWU_G1-SS_Q-SS` <- `result_MWU_G1-SS_Q-SS`[["p.value"]] %>%
        format(., scientific = TRUE) %>%
        as.numeric()
    `p_MWU_G1-N_G1-SS` <- `result_MWU_G1-N_G1-SS`[["p.value"]] %>%
        format(., scientific = TRUE) %>%
        as.numeric()
    `p_MWU_Q-N_Q-SS` <- `result_MWU_Q-N_Q-SS`[["p.value"]] %>%
        format(., scientific = TRUE) %>%
        as.numeric()
    
    
    #  Fit linear regression models on regularized TPM values -----------------
    df_G1 <- tibble::tibble(
        y = log2(df[["G1_N"]] + 1),
        x = log2(df[["G1_SS"]] + 1)
    )
    df_Q <- tibble::tibble(
        y = log2(df[["Q_N"]] + 1),
        x = log2(df[["Q_SS"]] + 1)
    )
    
    lm_G1 <- lm(df_G1$y ~ df_G1$x)
    lm_Q <- lm(df_Q$y ~ df_Q$x)
    
    #  Isolate residuals
    res_G1 <- residuals(lm_G1)
    res_Q <- residuals(lm_Q)
    
    #  For t tests, evaluate homoscedasticity and normality of
    #+ residuals (i.e., do some QC work)
    hist_G1 <- tibble::tibble(residuals = res_G1) %>%
        ggplot2::ggplot(aes(x = residuals)) +
        geom_histogram(color = "#00000090", fill = "#A0DA3990") +
        theme_AG_boxed_no_legend
    hist_Q <- tibble::tibble(residuals = res_Q) %>%
        ggplot2::ggplot(aes(x = residuals)) +
        geom_histogram(color = "#00000090", fill = "#277F8E90") +
        theme_AG_boxed_no_legend
    
    #  Draw QQ plots
    qq_G1 <- tibble::tibble(residuals = res_G1) %>%
        ggplot2::ggplot(aes(sample = residuals)) +
        stat_qq(color = "#A0DA3933", size = 2.5) +
        stat_qq_line() +
        xlab("theoretical quantiles") +
        ylab("G1 sample quantiles") +
        theme_AG_boxed_no_legend
    qq_Q <- tibble::tibble(residuals = res_Q) %>%
        ggplot2::ggplot(aes(sample = residuals)) +
        stat_qq(color = "#277F8E33", size = 2.5) +
        stat_qq_line() +
        xlab("theoretical quantiles") +
        ylab("Q sample quantiles") +
        theme_AG_boxed_no_legend

    #  Initialize objects for sample and theoretical residual quantiles
    qq_G1_val <- qqnorm(residuals(lm_G1), plot.it = FALSE)
    qq_Q_val <- qqnorm(residuals(lm_Q), plot.it = FALSE)
    
    #  Perform MWU test to compare distributions of lm predicted values
    lm_fitted_values_G1 <- fitted(lm_G1)
    lm_fitted_values_Q <- fitted(lm_Q)
    
    #  Perform the Mann-Whitney U test
    lm_result_MWU_fit <- wilcox.test(lm_fitted_values_G1, lm_fitted_values_Q)
    
    #  Extract the p-value by assessing the probability of the MWU statistic's
    #+ extremity given an approximated null distribution
    lm_p_MWU_fit <- lm_result_MWU_fit$p.value %>% format(., scientific = TRUE)
    
    #  Calculate lm metrics and other statistics
    lm_G1_summary <- summary(lm_G1)
    lm_G1_coef <- lm_G1$coefficients
    lm_G1_m <- lm_G1_coef[2]
    lm_G1_intercept <- lm_G1_coef[1]
    lm_G1_equation <- paste(
        "y =",
        paste(
            round(lm_G1_intercept, 2),
            paste(
                round(lm_G1_m, 2),
                "x",  # names(lm_G1_coef[-1]),
                sep = "",  # sep = " * ",
                collapse =" + "
            ),
            sep = " + "
        ),
        "+ e"  # "+ ϵ"
    )
    lm_G1_r_sq <- lm_G1_summary$adj.r.squared
    rho_G1 <- cor(df_G1$y, df_G1$x, method = "spearman")
    r_G1 <- cor(df_G1$y, df_G1$x, method = "pearson")
    
    lm_Q_summary <- summary(lm_Q)
    lm_Q_coef <- lm_Q$coefficients
    lm_Q_m <- lm_Q_coef[2]
    lm_Q_intercept <- lm_Q_coef[1]
    lm_Q_equation <- paste(
        "y =",
        paste(
            round(lm_Q_intercept, 2),
            paste(
                round(lm_Q_m, 2),
                "x",  # names(lm_Q_coef[-1]),
                sep = "",  # sep = " * ",
                collapse =" + "
            ),
            sep = " + "
        ),
        "+ e"  # "+ ϵ"
    )
    lm_Q_r_sq <- lm_Q_summary$adj.r.squared
    rho_Q <- cor(df_Q$y, df_Q$x, method = "spearman")
    r_Q <- cor(df_Q$y, df_Q$x, method = "pearson")
    
    
    #  Draw scatter, line plots with lm fits ----------------------------------
    #  To draw the lm fits, create dataframes of dependent-variable values
    #+ and fitted values
    lm_fit_G1 <- data.frame(
        G1_SS = log2(df[["G1_SS"]] + 1),
        fit_G1_N = lm_fitted_values_G1
    )
    lm_fit_Q <- data.frame(
        Q_SS = log2(df[["Q_SS"]] + 1),
        fit_Q_N = lm_fitted_values_Q
    )
    
    lm_scatter_G1 <- ggplot(df, aes(x = log2(G1_SS + 1), y = log2(G1_N + 1))) +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_point(size = 2.5, col = "#00000020") +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
        # geom_line(
        #     data = lm_fit_G1,
        #     aes(x = G1_SS, y = fit_G1_N),
        #     color = "#A0DA39",
        #     linetype = "dotdash",
        #     linewidth = 6
        # ) +
        geom_smooth(
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            color = "#A0DA39",
            linetype = "dotdash",
            fullrange = TRUE,
            alpha = 0.8,
            linewidth = 6
        ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste("Pearson r =", round(r_G1, 2)),
            fontface = "bold"
        ) +
        annotate(  # label the model equation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = lm_G1_equation,
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.7,
            size = 7,
            label = bquote(r^2 ~ "=" ~ .(round(lm_G1_r_sq, 2))),
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.6,
            size = 7,
            label = paste(
                "MWU p =",
                {
                    numb <- as.numeric(`p_MWU_G1-N_G1-SS`, 2)
                    formatC(numb, format = "e", digits = 2)
                }
            ),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    if(base::isTRUE(debug)) lm_scatter_G1
    
    lm_scatter_Q <- ggplot(df, aes(x = log2(Q_SS + 1), y = log2(Q_N + 1))) +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_point(size = 2.5, col = "#00000020") +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
        # geom_line(
        #     data = lm_fit_Q,
        #     aes(x = Q_SS, y = fit_Q_N),
        #     color = "#277F8E",
        #     linetype = "dotdash",
        #     linewidth = 6
        # ) +
        geom_smooth(
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            color = "#277F8E",
            linetype = "dotdash",
            fullrange = TRUE,
            alpha = 0.8,
            linewidth = 6
        ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste("Pearson r =", round(r_Q, 2)),
            fontface = "bold"
        ) +
        annotate(  # label the model equation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = lm_Q_equation,
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.7,
            size = 7,
            label = bquote(r^2 ~ "=" ~ .(round(lm_Q_r_sq, 2))),
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.6,
            size = 7,
            label = paste(
                "MWU p =",
                {
                    numb <- as.numeric(`p_MWU_Q-N_Q-SS`, 2)
                    formatC(numb, format = "e", digits = 2)
                }
            ),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    if(base::isTRUE(debug)) lm_scatter_Q
    
    lm_fit_plot <- ggplot() +
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
            color = "#A0DA39",
            linetype = "dotdash",
            fullrange = TRUE,
            linewidth = 6
        ) +
        geom_smooth(
            data = df,
            aes(x = log2(Q_SS + 1), y = log2(Q_N + 1)),
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            color = "#277F8E",
            linetype = "dotdash",
            fullrange = TRUE,
            linewidth = 6
        ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste(
                "MWU p =",
                {
                    numb <- as.numeric(lm_p_MWU_fit, 2)
                    formatC(numb, format = "e", digits = 2)
                }
            ),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    
    if(base::isTRUE(debug)) lm_fit_plot
    
    
    #  Fit LOESS models on regularized TPM values -----------------------------
    #+ ...where, for the G1 group, we're regressing log2(G1_N + 1) on
    #+ log2(G1_SS + 1) and, for the Q group, we're regressing log2(Q_N + 1) on
    #+ log2(Q_SS + 1)
    #+ 
    #+ The span parameter controls the degree of smoothing, and the degree
    #+ parameter specifies the degree of the LOESS polynomial (higher degrees
    #+ result in more flexible fits)
    loess_G1 <- loess(
        log2(df[["G1_N"]] + 1) ~ log2(df[["G1_SS"]] + 1),
        span = span,
        degree = degree
    )
    loess_Q <- loess(
        log2(df[["Q_N"]] + 1) ~ log2(df[["Q_SS"]] + 1),
        span = span,
        degree = degree
    )
    
    #  Perform MWU test to compare distributions of LOESS predicted values
    #  Extract the fitted (predicted) values from the LOESS models for each
    #+ group
    loess_fitted_values_G1 <- fitted(loess_G1)
    loess_fitted_values_Q <- fitted(loess_Q)
    
    #  Perform the Mann-Whitney U test, testing the H0 that that there is no
    #+ difference in the distributions of fitted values between the groups G1
    #+ and Q
    loess_result_MWU_fit <- wilcox.test(
        loess_fitted_values_G1, loess_fitted_values_Q
    )
    
    #  Extract the p-value by assessing the probability of the MWU statistic's
    #+ extremity given an approximated null distribution
    loess_p_MWU_fit <- loess_result_MWU_fit$p.value %>% format(., scientific = TRUE)
    
    
    #  Draw scatterplots with LOESS fits --------------------------------------
    #  To draw the LOESS fits, create dataframes of dependent-variable values
    #+ and fitted values
    loess_fit_G1 <- data.frame(
        G1_SS = df[["G1_SS"]],
        fit_G1_N = loess_fitted_values_G1
    )
    loess_fit_Q <- data.frame(
        Q_SS = df[["Q_SS"]],
        fit_Q_N = loess_fitted_values_Q
    )
    
    
    #  Draw scatter, line plots with LOESS fits -------------------------------
    loess_scatter_G1 <- ggplot(df, aes(x = log2(G1_SS + 1), y = log2(G1_N + 1))) +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_point(size = 2.5, col = "#00000020") +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
            geom_line(
                data = loess_fit_G1,
                aes(x = log2(G1_SS + 1), y = fit_G1_N),
                color = "#A0DA39",
                # linetype = "dotdash",
                linewidth = 6
            ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste("Pearson r =", round(r_G1, 2)),
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = paste(
                "MWU p =",
                {
                    numb <- as.numeric(`p_MWU_G1-N_G1-SS`, 2)
                    formatC(numb, format = "e", digits = 2)
                }
            ),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    if(base::isTRUE(debug)) loess_scatter_G1
    
    loess_scatter_Q <- ggplot(df, aes(x = log2(Q_SS + 1), y = log2(Q_N + 1))) +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_point(size = 2.5, col = "#00000020") +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
            geom_line(
                data = loess_fit_Q,
                aes(x = log2(Q_SS + 1), y = fit_Q_N),
                color = "#277F8E",
                # linetype = "dotdash",
                linewidth = 6
            ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste("Pearson r =", round(r_Q, 2)),
            fontface = "bold"
        ) +
        annotate(  # label the r-squared value
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.8,
            size = 7,
            label = paste(
                "MWU p =",
                {
                    numb <- as.numeric(`p_MWU_Q-N_Q-SS`, 2)
                    formatC(numb, format = "e", digits = 2)
                }
            ),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    if(base::isTRUE(debug)) loess_scatter_Q
    
    loess_fit_plot <- ggplot() +
        geom_abline(  # x = y (example of one-to-one linear relationship)
            slope = 1,
            linetype = "solid",
            color = "#00000050",
            linewidth = 1
        ) +
        geom_line(
            data = loess_fit_G1,
            aes(x = log2(G1_SS + 1), y = fit_G1_N),
            color = "#A0DA39",
            # linetype = "dotdash",
            linewidth = 6
        ) +
        geom_line(
            data = loess_fit_Q,
            aes(x = log2(Q_SS + 1), y = fit_Q_N),
            color = "#277F8E",
            # linetype = "dotdash",
            linewidth = 6
        ) +
        annotate(  # label the Pearson correlation
            "text",
            hjust = 0,
            x = x_low,
            y = y_high * 0.9,
            size = 7,
            label = paste(
                "MWU p =",
                {
                    numb <- as.numeric(loess_p_MWU_fit, 2)
                    formatC(numb, format = "e", digits = 2)
                }
            ),
            fontface = "bold"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = x_lab, y = y_lab) +
        theme_AG_boxed_no_legend
    
    if(base::isTRUE(debug)) loess_fit_plot
    
    
    #  Return results ---------------------------------------------------------
    results_list <- list()
    results_list[["01_result_MWU_G1-N_Q-N"]] <- `result_MWU_G1-N_Q-N`
    results_list[["01_result_MWU_G1-SS_Q-SS"]] <- `result_MWU_G1-SS_Q-SS`
    results_list[["01_result_MWU_G1-N_G1-SS"]] <- `result_MWU_G1-N_G1-SS`
    results_list[["01_result_MWU_Q-N_Q-SS"]] <- `result_MWU_Q-N_Q-SS`
    results_list[["01_p_MWU_G1-N_Q-N"]] <- `p_MWU_G1-N_Q-N`
    results_list[["01_p_MWU_G1-SS_Q-SS"]] <- `p_MWU_G1-SS_Q-SS`
    results_list[["01_p_MWU_G1-N_G1-SS"]] <- `p_MWU_G1-N_G1-SS`
    results_list[["01_p_MWU_Q-N_Q-SS"]] <- `p_MWU_Q-N_Q-SS`
    results_list[["02_df_G1"]] <- df_G1
    results_list[["02_df_Q"]] <- df_Q
    results_list[["03_lm_G1"]] <- lm_G1
    results_list[["03_lm_Q"]] <- lm_Q
    results_list[["03_res_G1"]] <- res_G1
    results_list[["03_res_Q"]] <- res_Q
    results_list[["04_hist_G1"]] <- hist_G1
    results_list[["04_hist_Q"]] <- hist_Q
    results_list[["05_qq_G1"]] <- qq_G1
    results_list[["05_qq_Q"]] <- qq_Q
    results_list[["05_qq_G1_val"]] <- qq_G1_val
    results_list[["05_qq_Q_val"]] <- qq_Q_val
    results_list[["06_lm_fitted_values_G1"]] <- lm_fitted_values_G1
    results_list[["06_lm_fitted_values_Q"]] <- lm_fitted_values_Q
    results_list[["06_lm_result_MWU_fit"]] <- lm_result_MWU_fit
    results_list[["06_lm_p_MWU_fit"]] <- lm_p_MWU_fit
    results_list[["07_lm_G1_summary"]] <- lm_G1_summary
    results_list[["07_lm_G1_coef"]] <- lm_G1_coef
    results_list[["07_lm_G1_m"]] <- lm_G1_m
    results_list[["07_lm_G1_intercept"]] <- lm_G1_intercept
    results_list[["07_lm_G1_equation"]] <- lm_G1_equation
    results_list[["07_lm_G1_r_sq"]] <- lm_G1_r_sq
    results_list[["07_rho_G1"]] <- rho_G1
    results_list[["07_r_G1"]] <- r_G1
    results_list[["08_lm_Q_summary"]] <- lm_Q_summary
    results_list[["08_lm_Q_coef"]] <- lm_Q_coef
    results_list[["08_lm_Q_m"]] <- lm_Q_m
    results_list[["08_lm_Q_intercept"]] <- lm_Q_intercept
    results_list[["08_lm_Q_equation"]] <- lm_Q_equation
    results_list[["08_lm_Q_r_sq"]] <- lm_Q_r_sq
    results_list[["08_rho_Q"]] <- rho_Q
    results_list[["08_r_Q"]] <- r_Q
    results_list[["09_lm_fit_G1"]] <- lm_fit_G1
    results_list[["09_lm_fit_Q"]] <- lm_fit_Q
    results_list[["09_lm_scatter_G1"]] <- lm_scatter_G1
    results_list[["09_lm_scatter_Q"]] <- lm_scatter_Q
    results_list[["09_lm_fit_plot"]] <- lm_fit_plot
    results_list[["10_loess_G1"]] <- loess_G1
    results_list[["10_loess_Q"]] <- loess_Q
    results_list[["11_loess_fitted_values_G1"]] <- loess_fitted_values_G1
    results_list[["11_loess_fitted_values_Q"]] <- loess_fitted_values_Q
    results_list[["11_loess_result_MWU_fit"]] <- loess_result_MWU_fit
    results_list[["11_loess_p_MWU_fit"]] <- loess_p_MWU_fit
    results_list[["12_loess_fit_G1"]] <- loess_fit_G1
    results_list[["12_loess_fit_Q"]] <- loess_fit_Q
    results_list[["12_loess_scatter_G1"]] <- loess_scatter_G1
    results_list[["12_loess_scatter_Q"]] <- loess_scatter_Q
    results_list[["12_loess_fit_plot"]] <- loess_fit_plot
    
    return(results_list)
}


print_regression_plot <- function(
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


#  Run linear and LOESS regressions, and statistical tests ====================
etc_mRNA <- perform_lm_LOESS_MW_etc(t_mRNA)
etc_pancRNA <- perform_lm_LOESS_MW_etc(t_pancRNA)
etc_Tr_Q <- perform_lm_LOESS_MW_etc(t_Tr_Q)
etc_Tr_G1 <- perform_lm_LOESS_MW_etc(t_Tr_G1)

for(i in 1:4) {
    if(i == 1) {
        etc <- etc_mRNA
        label <- "mRNA"
    } else if(i == 2) {
        etc <- etc_pancRNA
        label <- "pancRNA"
    } else if(i == 3) {
        etc <- etc_Tr_Q
        label <- "Tr_Q"
    } else if(i == 4) {
        etc <- etc_Tr_G1
        label <- "Tr_G1"
    }
    
    print_regression_plot(
        object = etc[["09_lm_scatter_G1"]],
        filename = paste("lm-scatter", label, "G1.pdf", sep = "_")
    )
    print_regression_plot(
        object = etc[["09_lm_scatter_Q"]],
        filename = paste("lm-scatter", label, "Q.pdf", sep = "_")
    )
    print_regression_plot(
        object = etc[["09_lm_fit_plot"]],
        filename = paste0("lm-fit_", label, ".pdf")
    )
    
    print_regression_plot(
        object = etc[["12_loess_scatter_G1"]],
        filename = paste("loess-scatter", label, "G1.pdf", sep = "_")
    )
    print_regression_plot(
        object = etc[["12_loess_scatter_Q"]],
        filename = paste("loess-scatter", label, "Q.pdf", sep = "_")
    )
    print_regression_plot(
        object = etc[["12_loess_fit_plot"]],
        filename = paste0("loess-fit_", label, ".pdf")
    )
}
