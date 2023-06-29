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
        xlim(x_low, x_high) +
        ylim(y_low, y_high) +
        xlab(xlab) +
        ylab(ylab) +
        theme_AG_boxed_no_legend
    
    return(scatter)
}


model_plot_scatter_N_SS <- function(
    df,
    features,
    color = "#06636833",
    xlab = "log2(TPM + 1) SS",
    ylab = "log2(TPM + 1) N",
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
        df = t_mRNA
        features = "Q"
        color = "#06636833"
        xlab = "log2(TPM + 1) SS"
        ylab = "log2(TPM + 1) N"
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
    
    subset <- FALSE
    if(base::isTRUE(subset)) {
        df_xy <- df_xy[rowMeans(df_xy) > 5, ]
    }
    
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
    if(base::isTRUE(debug)) scatter
    
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
    if(base::isTRUE(debug)) scatter_density
    
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

#  Filter dataframes, retaining only those rows with mean TPM >2
run <- FALSE
if(base::isTRUE(run)) {
    t_mRNA <- t_mRNA[rowMeans(t_mRNA[, 20:23]) > 10, ]
    t_pancRNA <- t_pancRNA[rowMeans(t_pancRNA[, 20:23]) > 10, ]
    t_Tr_Q <- t_Tr_Q[rowMeans(t_Tr_Q[, 20:23]) > 10, ]
    t_Tr_G1 <- t_Tr_G1[rowMeans(t_Tr_G1[, 20:23]) > 10, ]
}

#  Draw scatter plots, make scatter-plot data objects
run <- TRUE
if(base::isTRUE(run)) {
    s_mRNA_Q <- model_plot_scatter_N_SS(df = t_mRNA, features = "Q")
    s_mRNA_G1 <- model_plot_scatter_N_SS(df = t_mRNA, features = "G1")
    
    s_mRNA_Q$`05_scatter`
    s_mRNA_G1$`05_scatter`
    
    # s_mRNA_Q$`05_scatter_density`
    # s_mRNA_G1$`05_scatter_density`
}

tmp_G <- t_mRNA[, 20:21]
tmp_G$type <- "G1"
tmp_Q <- t_mRNA[, 22:23]
tmp_Q$type <- "Q"

colnames(tmp_G) <- colnames(tmp_Q) <- c("N", "SS", "type")

tmp_all <- dplyr::bind_rows(tmp_G, tmp_Q)
tmp_all$type <- as.factor(tmp_all$type)

modl <- aov(N ~ SS*type, data = tmp_all)
modl2 <- aov(N ~ SS+type, data = tmp_all)

anova(modl,modl2)

car::scatterplot(log2(N + 1) ~ log2(SS + 1) | type, tmp_all, smooth = FALSE)

tmp_all$color <- ifelse(tmp_all$type == "G1", "#8F68AF10", "#6DB8BC10")

draw_density <- FALSE
lm_G1 <- lm(log2(t_mRNA$G1_N + 1) ~ log2(t_mRNA$G1_SS + 1))
lm_Q <- lm(log2(t_mRNA$Q_N + 1) ~ log2(t_mRNA$Q_SS + 1))

scatter <- ggplot(
    tmp_all,
    aes(x = log2(SS + 1), y = log2(N + 1))
) +
    geom_abline(  # x = y (example of one-to-one linear relationship)
        slope = 1,
        linetype = "solid",
        color = "#00000050",
        size = 1
    ) +
    geom_point(size = 2.5, color = tmp_all$color) +
    { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
    geom_abline(
        slope = coefficients(lm_G1)[2],
        intercept = coefficients(lm_G1)[1],
        linetype = "dotdash",
        color = "#7835AC",
        alpha = 0.8,
        size = 6
    ) +
    geom_abline(
        slope = coefficients(lm_Q)[2],
        intercept = coefficients(lm_Q)[1],
        linetype = "dotdash",
        color = "#167C28",
        alpha = 0.8,
        size = 6
    ) +
    theme_AG_boxed
scatter

summary(lm_G1)
summary(lm_Q)

b_G1 <- coef(lm_G1)["(Intercept)"]
b_Q <- coef(lm_Q)["(Intercept)"]

RSS_G1 <- sum(residuals(lm_G1)^2)
RSS_Q <- sum(residuals(lm_Q)^2)
deg_free_G1 <- df.residual(lm_G1)
deg_free_Q <- df.residual(lm_Q)

if(deg_free_G1 != deg_free_Q) {
    F_statistic <- ((RSS_G1 - RSS_Q) / (deg_free_G1 - deg_free_Q)) / (RSS_Q / deg_free_Q)
} else {
    F_statistic <- (RSS_G1 - RSS_Q) / RSS_Q
}

#  Invalid when degrees of freedom are equal
p_value <- 1 - pf(F_statistic, deg_free_G1 - deg_free_Q, deg_free_Q)

t_statistic <- (b_G1 - b_Q) / sqrt((RSS_G1 / deg_free_G1) + (RSS_Q / deg_free_Q))
p_value <- 2 * pt(abs(t_statistic), min(deg_free_G1, deg_free_Q), lower.tail = FALSE)


#  Evaluate homoscedasticity and normality of residuals
hist(residuals(lm_G1))
hist(residuals(lm_Q))

qqnorm(residuals(lm_G1))
qqnorm(residuals(lm_Q))

#  Subsample to 5000 elements, then run Shapiro test for normality
set.seed(24)
shapiro.test(sample(residuals(lm_G1), 5000))
shapiro.test(sample(residuals(lm_Q), 5000))

hist(sample(residuals(lm_Q), 5000))
hist(sample(residuals(lm_G1), 5000))

t.test(coef(lm_G1)["(Intercept)"], coef(lm_Q)["(Intercept)"])

diff <- merge(lm_G1$coefficients, lm_Q$coefficients)
diff$error <- abs(diff$x - diff$y)



####
results_list <- list()
for(idx in 1:2) {
    # idx <- 1
    if(idx == 1) {
        print("Testing for y intercept")
        descriptor <- "b"
    } else {
        print("Testing for slope")
        descriptor <- "m"
    }
    
    lm1 <- lm(log2(t_mRNA$G1_N + 1) ~ log2(t_mRNA$G1_SS + 1))
    lm2 <- lm(log2(t_mRNA$Q_N + 1) ~ log2(t_mRNA$Q_SS + 1))
    
    coef_lm1 <- coef(lm1)[idx]
    coef_lm2 <- coef(lm2)[idx]
    
    cov_lm1 <- vcov(lm1)
    cov_lm2 <- vcov(lm2)
    
    SE_lm1 <- sqrt(cov_lm1[idx, idx])
    SE_lm2 <- sqrt(cov_lm2[idx, idx])
    
    SE_diff <- sqrt(SE_lm1^2 + SE_lm2^2)
    
    t_statistic <- (coef_lm1 - coef_lm2) / SE_diff
    df <- nrow(t_mRNA) - 2
    p_value <- 2 * pt(-abs(t_statistic), df)
    
    results_list[[descriptor]][["lm1"]] <- lm1
    results_list[[descriptor]][["lm2"]] <- lm2
    results_list[[descriptor]][["coef_lm1"]] <- coef_lm1
    results_list[[descriptor]][["coef_lm2"]] <- coef_lm2
    results_list[[descriptor]][["cov_lm1"]] <- cov_lm1
    results_list[[descriptor]][["cov_lm2"]] <- cov_lm2
    results_list[[descriptor]][["SE_lm1"]] <- SE_lm1
    results_list[[descriptor]][["SE_lm2"]] <- SE_lm2
    results_list[[descriptor]][["SE_diff"]] <- SE_diff
    results_list[[descriptor]][["t_statistic"]] <- t_statistic
    results_list[[descriptor]][["df"]] <- df
    results_list[[descriptor]][["p_value"]] <- p_value
}

results_list$b$p_value
results_list$m$p_value

#     slope: P < 0.05 "****"
# intercept: p < 0.05 "****"

#  Check that assumptions are met
r1 <- residuals(lm1)
r2 <- residuals(lm2)

p1 <- fitted(lm1)
p2 <- fitted(lm2)

plot(p1, r1, xlab = "Predicted Values", ylab = "Residuals", main = "Residual Plot")
abline(h = 0, col = "red")  # Add a horizontal line at 0 (the expected value for homoscedasticity)

plot(p2, r2, xlab = "Predicted Values", ylab = "Residuals", main = "Residual Plot")
abline(h = 0, col = "red")  # Add a horizontal line at 0 (the expected value for homoscedasticity)

qqnorm(r1)
qqline(r1, col = "#A0DA39")
#  I think data are sparse at the extremes and hence the trend away from homoscedasticity

qqnorm(r2)
qqline(r2, col = "#277F8E")

plot_G1 <- ggplot(t_mRNA, aes(x = log2(G1_SS + 1), y = log2(G1_N + 1))) +
    geom_point() +
    geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "#A0DA39") +
    labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N")
plot_Q <- ggplot(t_mRNA, aes(x = log2(Q_SS + 1), y = log2(Q_N + 1))) +
    geom_point() +
    geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "#277F8E") +
    labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N")
plot_lines <- ggplot() +
    geom_smooth(data = t_mRNA, aes(x = log2(G1_SS + 1), y = log2(G1_N + 1)), method = "lm", formula = y ~ x, se = FALSE, color = "red") +
    geom_smooth(data = t_mRNA, aes(x = log2(Q_SS + 1), y = log2(Q_N + 1)), method = "lm", formula = y ~ x, se = FALSE, color = "blue") +
    labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N")

# Plot the graphs
plot_G1
plot_Q
plot_lines

calculate_test_statistic <- function(data) {
    lm1 <- lm(log2(G1_N + 1) ~ log2(G1_SS + 1), data = data)
    lm2 <- lm(log2(Q_N + 1) ~ log2(Q_SS + 1), data = data)
    
    coef_lm1 <- coef(lm1)[idx]
    coef_lm2 <- coef(lm2)[idx]
    
    SE_lm1 <- sqrt(vcov(lm1)[idx, idx])
    SE_lm2 <- sqrt(vcov(lm2)[idx, idx])
    
    SE_diff <- sqrt(SE_lm1^2 + SE_lm2^2)
    
    t_statistic <- (coef_lm1 - coef_lm2) / SE_diff
    return(t_statistic)
}

