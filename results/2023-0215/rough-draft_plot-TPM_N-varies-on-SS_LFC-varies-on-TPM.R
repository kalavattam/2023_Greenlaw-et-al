#!/usr/bin/env Rscript

#  rough-draft_plot-TPM_N-varies-on-SS_LFC-varies-on-TPM.R
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


calculate_mean_TPMs_n3d <- function(df) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- t_mRNA
        colnames(df)[12:ncol(df)]
    }
    
    mean_n3d_N <- df[
        , colnames(df) %in% c("n3d_Q_N_rep1_tech1", "n3d_Q_N_rep2_tech1")
    ]
    df[["n3d_N"]] <- rowMeans(mean_n3d_N)
    
    mean_n3d_SS <- df[
        , colnames(df) %in% c("n3d_Q_SS_rep1_tech1", "n3d_Q_SS_rep2_tech1")
    ]
    df[["n3d_SS"]] <- rowMeans(mean_n3d_SS)
    
    mean_od_N <- df[
        , colnames(df) %in% c("od_Q_N_rep1_tech1", "od_Q_N_rep2_tech1")
    ]
    df[["od_N"]] <- rowMeans(mean_od_N)
    
    mean_od_SS <- df[
        , colnames(df) %in% c("od_Q_SS_rep1_tech1", "od_Q_SS_rep2_tech1")
    ]
    df[["od_SS"]] <- rowMeans(mean_od_SS)
    
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
        df <- t_mRNA
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
        annotate(  # label the MWU p value
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
    
    
    #  Create table of features above, below, or at the regression line -------
    #+ With N on y and SS on x, values above the regression line are "actively
    #+ degraded" [higher in N (y), lower in SS (x)]; values below the
    #+ regression line are "stabilized" [lower in N (y), higher in SS (x)]
    df <- df %>%
        dplyr::mutate(
            log2_pseudo_G1_N = log2(G1_N + 1),
            log2_pseudo_G1_SS = log2(G1_SS + 1),
            log2_pseudo_Q_N = log2(Q_N + 1),
            log2_pseudo_Q_SS = log2(Q_SS + 1)
        )
    
    model_G1 <- lm(log2_pseudo_G1_N ~ log2_pseudo_G1_SS, data = df)
    model_Q <- lm(log2_pseudo_Q_N ~ log2_pseudo_Q_SS, data = df)
    
    df$G1_reg_line <- predict(model_G1, newdata = df)
    df$Q_reg_line <- predict(model_Q, newdata = df)
    
    df <- df %>%
        dplyr::mutate(
            est_trans_kin_G1 = dplyr::case_when(
                log2(G1_N + 1) > G1_reg_line ~ "degraded",
                log2(G1_N + 1) < G1_reg_line ~ "stabilized",
                TRUE ~ "same"
            ),
            est_trans_kin_Q = dplyr::case_when(
                log2(Q_N + 1) > Q_reg_line ~ "degraded",
                log2(Q_N + 1) < Q_reg_line ~ "stabilized",
                TRUE ~ "same"
            ),
            est_kin_together = dplyr::case_when(
                est_trans_kin_G1 == "stabilized" &
                    est_trans_kin_Q == "stabilized" ~ "stabilized in both",
                est_trans_kin_G1 == "degraded" &
                    est_trans_kin_Q == "degraded" ~ "degraded in both",
                est_trans_kin_G1 == "degraded" &
                    est_trans_kin_Q == "stabilized" ~ "stabilized in Q",
                est_trans_kin_G1 == "stabilized" &
                    est_trans_kin_Q == "degraded" ~ "degraded in Q"
            )
    )
    
    check_trans_kin <- FALSE
    if(base::isTRUE(check_trans_kin)) {
        df$est_trans_kin_G1 %>% table() %>% print()
        df$est_trans_kin_Q %>% table() %>% print()
        df$est_kin_together %>% table() %>% print()
    }
    
    
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
    results_list[["02_df"]] <- df
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
p_exp <- "2022-2023_RRP6-NAB3/results/2023-0215"

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


#HERE
#  Run linear and LOESS regressions, and statistical tests ====================
run <- TRUE  #ARGUMENT
if(base::isTRUE(run)) {
    etc_mRNA <- perform_lm_LOESS_MW_etc(t_mRNA)
    etc_pancRNA <- perform_lm_LOESS_MW_etc(t_pancRNA)
    etc_Tr_Q <- perform_lm_LOESS_MW_etc(t_Tr_Q)
    etc_Tr_G1 <- perform_lm_LOESS_MW_etc(t_Tr_G1)
    
    for(i in 1:4) {
        # i <- 1
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
        
        # print_regression_plot(
        #     object = etc[["12_loess_scatter_G1"]],
        #     filename = paste("loess-scatter", label, "G1.pdf", sep = "_")
        # )
        # print_regression_plot(
        #     object = etc[["12_loess_scatter_Q"]],
        #     filename = paste("loess-scatter", label, "Q.pdf", sep = "_")
        # )
        # print_regression_plot(
        #     object = etc[["12_loess_fit_plot"]],
        #     filename = paste0("loess-fit_", label, ".pdf")
        # )
        
        supp_tbl <- etc[["02_df"]]
        colnames(supp_tbl)[12:27] <- c(
            paste("TPM", c(
                "G1_N_rep1", "G1_N_rep2", "G1_SS_rep1", "G1_SS_rep2",
                "Q_N_rep1", "Q_N_rep2", "Q_SS_rep1", "Q_SS_rep2"
            ), sep = "_"),
            paste("mean_TPM", c("G1_N", "G1_SS", "Q_N", "Q_SS"), sep = "_"),
            paste("log2_pseudo_mean_TPM", c(
                "G1_N", "G1_SS", "Q_N", "Q_SS")
            , sep = "_")
        )
        
        supp_tbl_filename <- paste0("~/Desktop/", "supp-tbl_", label, ".tsv")
        readr::write_tsv(supp_tbl, supp_tbl_filename, na =  "#N/A")
    }
}


# etc_mRNA$`02_df`$est_trans_kin_G1 %>% table() %>% print()
# etc_mRNA$`02_df`$est_trans_kin_Q %>% table() %>% print()
# etc_mRNA$`02_df`$est_kin_together %>% table() %>% print()
# 
# etc_pancRNA$`02_df`$est_trans_kin_G1 %>% table() %>% print()
# etc_pancRNA$`02_df`$est_trans_kin_Q %>% table() %>% print()
# etc_pancRNA$`02_df`$est_kin_together %>% table() %>% print()


#  Examine Nab3-AID/Parent log2(FC) w/r/to Parent TPM =========================
#  Load necessary RDS file
p_RDS <- "notebook/KA.2023-0608-0703.rds-data-objects_min-4-cts-all-but-1-samps"
p_mRNA <- "rds_mRNA"

load_mRNA_N_Q_n3d <- TRUE  #ARGUMENT
if(base::isTRUE(load_mRNA_N_Q_n3d)) {
    mRNA_N_Q_n3d <- readRDS(paste(
        p_RDS,
        p_mRNA,
        "mRNA_DGE-analysis_N-Q-nab3d_N-Q-parental.rds",
        sep = "/"
    ))
    
    LFC_N_Q_n3d <- mRNA_N_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
    LFC_N_Q_n3d <- LFC_N_Q_n3d[, c(12, 7)]
}

load_mRNA_SS_Q_n3d <- TRUE  #ARGUMENT
if(base::isTRUE(load_mRNA_SS_Q_n3d)) {
    mRNA_SS_Q_n3d <- readRDS(paste(
        p_RDS,
        p_mRNA,
        "mRNA_DGE-analysis_SS-Q-nab3d_SS-Q-parental.rds",
        sep = "/"
    ))
    
    LFC_SS_Q_n3d <- mRNA_SS_Q_n3d$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
    LFC_SS_Q_n3d <- LFC_SS_Q_n3d[, c(12, 7)]
}

#  Load TPM tsv files
#  (TPM files are from running "rough-draft_run-analyses_rlog-PCA_write-rds.R")
p_TPM <- "notebook/KA.2023-0704.Fig4.PCA_TPM"
f_mRNA <- "data.2023-0704__Nab3AID.Q.N-SS__mRNA.counts-TPM.tsv"
t_mRNA <- load_TPM(p_TPM, f_mRNA)

#  Calculate columns of sample-specific mean TPM values
t_mRNA <- calculate_mean_TPMs_n3d(t_mRNA)
t_mRNA <- t_mRNA[, c(8, 20:23)]


#  Prepare the data for analyses ----------------------------------------------
run <- "N"
# run <- "SS"
if(run == "N") {
    TPM_parent <- t_mRNA[, c(1, 4)]
    LFC_on_TPM <- dplyr::full_join(
        LFC_N_Q_n3d[LFC_N_Q_n3d$features %in% TPM_parent$features,],
        TPM_parent[TPM_parent$features %in% LFC_N_Q_n3d$features, ],
        by = "features"
    ) %>%
        dplyr::rename(
            LFC = log2FoldChange,
            TPM = od_N
        )
} else if(run == "SS") {
    TPM_parent <- t_mRNA[, c(1, 5)]
    LFC_on_TPM <- dplyr::full_join(
        LFC_SS_Q_n3d[LFC_SS_Q_n3d$features %in% TPM_parent$features,],
        TPM_parent[TPM_parent$features %in% LFC_SS_Q_n3d$features, ],
        by = "features"
    ) %>%
        dplyr::rename(
            LFC = log2FoldChange,
            TPM = od_SS
        )
}


#  Evaluate and plot the relationship -----------------------------------------
df_LFC_on_TPM <- tibble::tibble(
    y = LFC_on_TPM[["LFC"]],
    x = log2(LFC_on_TPM[["TPM"]] + 1)
)

#  Fit linear regression models on regularized TPM values
lm_LFC_on_TPM <- lm(df_LFC_on_TPM$y ~ df_LFC_on_TPM$x)

#  Calculate lm metrics and other statistics
lm_LFC_on_TPM_summary <- summary(lm_LFC_on_TPM)
lm_LFC_on_TPM_coef <- lm_LFC_on_TPM$coefficients
lm_LFC_on_TPM_m <- lm_LFC_on_TPM_coef[2]
lm_LFC_on_TPM_intercept <- lm_LFC_on_TPM_coef[1]
lm_LFC_on_TPM_equation <- paste(
    "y =",
    paste(
        round(lm_LFC_on_TPM_intercept, 2),
        paste(
            round(lm_LFC_on_TPM_m, 2),
            "x",  # names(lm_LFC_on_TPM_coef[-1]),
            sep = "",  # sep = " * ",
            collapse =" + "
        ),
        sep = " + "
    ),
    "+ e"  # "+ ϵ"
)
lm_LFC_on_TPM_r_sq <- lm_LFC_on_TPM_summary$adj.r.squared
rho_LFC_on_TPM <- cor(df_LFC_on_TPM$y, df_LFC_on_TPM$x, method = "spearman")
r_LFC_on_TPM <- cor(df_LFC_on_TPM$y, df_LFC_on_TPM$x, method = "pearson")

draw_density <- FALSE
x_low <- 0
x_high <- 16
y_low <- -4
y_high <- 10
x_lab <- ifelse(
    run == "N",
    "Parent log2(TPM + 1) nascent",
    "Parent log2(TPM + 1) steady state"
)
y_lab <- ifelse(
    run == "N",
    "Nab3-AID/Parent\nlog2(FC) nascent",
    "Nab3-AID/Parent\nlog2(FC) steady state"
)
plot_LFC_on_TPM <- ggplot2::ggplot(
    LFC_on_TPM, aes(x = log2(TPM + 1), y = LFC)
) +
    geom_hline(  # y = 0
        yintercept = 0,
        linetype = "solid",
        color = "#000000",
        linewidth = 1
    ) +
    geom_vline(  # x = 0
        xintercept = 0,
        linetype = "solid",
        color = "#000000",
        linewidth = 1
    ) +
    geom_abline(  # x = y (example of one-to-one linear relationship)
        slope = 1,
        linetype = "solid",
        color = "#00000050",
        linewidth = 1
    ) +
    geom_point(size = 2.5, col = "#3A538833") +
    { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
    geom_smooth(
        method = "lm",
        formula = y ~ x,
        se = FALSE,
        color = "#B40400",
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
        label = paste("Pearson r =", round(r_LFC_on_TPM, 2)),
        fontface = "bold"
    ) +
    annotate(  # label the model equation
        "text",
        hjust = 0,
        x = x_low,
        y = y_high * 0.8,
        size = 7,
        label = lm_LFC_on_TPM_equation,
        fontface = "bold"
    ) +
    annotate(  # label the r-squared value
        "text",
        hjust = 0,
        x = x_low,
        y = y_high * 0.7,
        size = 7,
        label = bquote(r^2 ~ "=" ~ .(round(lm_LFC_on_TPM_r_sq, 2))),
        fontface = "bold"
    ) +
    xlim(c(x_low, x_high)) +
    ylim(c(y_low, y_high)) +
    labs(x = x_lab, y = y_lab) +
    theme_AG_boxed_no_legend
 
object <- plot_LFC_on_TPM
outpath <- "/Users/kalavatt/Desktop"
filename <- ifelse(
    run == "N",
    "scatter-plot_LFC-on-TPM.Q_N_n3d.pdf",
    "scatter-plot_LFC-on-TPM.Q_SS_n3d.pdf"
)
width <- 7
height <- 7
outfile <- paste0(outpath, "/", filename)

pdf(file = outfile, width = width, height = height)
print(object)
dev.off()
