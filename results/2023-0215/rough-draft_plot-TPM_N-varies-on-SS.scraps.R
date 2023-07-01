
#  rough-draft_plot-TPM_N-varies-on-SS.scraps.R
#  KA


#  Scraps =====================================================================
#  Filter dataframes, retaining only those rows with mean TPM >2
run <- FALSE
if(base::isTRUE(run)) {
    t_mRNA <- t_mRNA[rowMeans(t_mRNA[, 20:23]) > 10, ]
    t_pancRNA <- t_pancRNA[rowMeans(t_pancRNA[, 20:23]) > 10, ]
    t_Tr_Q <- t_Tr_Q[rowMeans(t_Tr_Q[, 20:23]) > 10, ]
    t_Tr_G1 <- t_Tr_G1[rowMeans(t_Tr_G1[, 20:23]) > 10, ]
}


#  Rough approach to evaluating statistical significance of, e.g., intercept
run <- FALSE
if(base::isTRUE(run)) {
    lm_G1 <- lm(log2(t_mRNA$G1_N + 1) ~ log2(t_mRNA$G1_SS + 1))
    lm_Q <- lm(log2(t_mRNA$Q_N + 1) ~ log2(t_mRNA$Q_SS + 1))
    
    run <- FALSE
    if(base::isTRUE(run)) {
        summary(lm_G1)
        summary(lm_Q)
    }
    
    b_G1 <- coef(lm_G1)["(Intercept)"]
    b_Q <- coef(lm_Q)["(Intercept)"]
    
    RSS_G1 <- sum(residuals(lm_G1)^2)
    RSS_Q <- sum(residuals(lm_Q)^2)
    deg_free_G1 <- df.residual(lm_G1)
    deg_free_Q <- df.residual(lm_Q)
    
    if(deg_free_G1 != deg_free_Q) {
        F_stat <- ((RSS_G1 - RSS_Q) / (deg_free_G1 - deg_free_Q)) / (RSS_Q / deg_free_Q)
        p_value <- 1 - pf(F_stat, deg_free_G1 - deg_free_Q, deg_free_Q)
    } else {
        F_stat <- (RSS_G1 - RSS_Q) / RSS_Q
        t_stat <- (b_G1 - b_Q) / sqrt((RSS_G1 / deg_free_G1) + (RSS_Q / deg_free_Q))
        p_value <- 2 * pt(abs(t_stat), min(deg_free_G1, deg_free_Q), lower.tail = FALSE)
    }
    
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
}


calculate_test_stat <- function(data) {
    lm1 <- lm(log2(G1_N + 1) ~ log2(G1_SS + 1), data = data)
    lm2 <- lm(log2(Q_N + 1) ~ log2(Q_SS + 1), data = data)
    
    coef_lm1 <- coef(lm1)[idx]
    coef_lm2 <- coef(lm2)[idx]
    
    SE_lm1 <- sqrt(vcov(lm1)[idx, idx])
    SE_lm2 <- sqrt(vcov(lm2)[idx, idx])
    
    SE_diff <- sqrt(SE_lm1^2 + SE_lm2^2)
    
    t_stat <- (coef_lm1 - coef_lm2) / SE_diff
    return(t_stat)
}


#  Check that assumptions of t test are met
run <- FALSE
if(base::isTRUE(run)) {
    r1 <- residuals(lm1)
    r2 <- residuals(lm2)
    
    p1 <- fitted(lm1)
    p2 <- fitted(lm2)
    
    plot(
        p1,
        r1,
        xlab = "Predicted values",
        ylab = "Residuals",
        main = "Residual plot"
    )
    abline(h = 0, col = "red")
    #  Add a horizontal line at 0 (the expected value for homoscedasticity)
    
    plot(
        p2,
        r2,
        xlab = "Predicted values",
        ylab = "Residuals",
        main = "Residual plot"
    )
    abline(h = 0, col = "red")  # Add a horizontal line at 0 (the expected value for homoscedasticity)
    
    qqnorm(r1)
    qqline(r1, col = "#A0DA39")
    #  I think data are sparse at the extremes and hence the trend away from
    #+ homoscedasticity
    
    qqnorm(r2)
    qqline(r2, col = "#277F8E")
}


#  More scraps
eval_dists_nonparam_bi <- TRUE  #ARGUMENT
if(base::isTRUE(eval_dists_nonparam_bi)) {
    # Combine the "N" and "SS" columns from the G1 and Q dataframes
    joint_data <- data.frame(
        N = c(df[["G1_N"]], df[["Q_N"]]),
        SS = c(df[["G1_SS"]], df[["Q_SS"]]),
        group = rep(c("G1", "Q"), each = nrow(df))  # Add a grouping variable
    )
    
    # mean(joint_data[joint_data$group == "Q", ]$N)
    # mean(joint_data[joint_data$group == "G1", ]$N)
    
    #  Perform a paired Mann-Whitney U, comparing the joint
    #+ distributions of "N" with respect to "SS" between the G1 and Q
    #+ groups
    test <- wilcox.test(
        N ~ group,
        data = joint_data,
        paired = TRUE,
        alternative = "two.sided"
    )
    test$p.value
    
    test_SS <- wilcox.test(
        SS ~ group,
        data = joint_data,
        paired = TRUE,
        alternative = "two.sided"
    )
    test_SS$p.value
}


#  More scraps
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


run <- TRUE  #ARGUMENT
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
        
        x_high <- 16  #ARGUMENT
        y_high <- 16  #ARGUMENT
        
        model_scatter_G1 <- model_plot_scatter_N_SS(
            df = df,
            features = "G1",
            color = "#A0DA3990",
            x_high = x_high,
            y_high = y_high
        )
        model_scatter_Q <- model_plot_scatter_N_SS(
            df = df,
            features = "Q",
            color = "#277F8E90",
            x_high = x_high,
            y_high = y_high
        )
        lines_G1_Q <- plot_lines(df)
        
        #  Save plots of interest to list -------------------------------------
        list_lm_t[[types[i]]][["model_scatter_G1"]] <- model_scatter_G1
        list_lm_t[[types[i]]][["model_scatter_Q"]] <- model_scatter_Q
        list_lm_t[[types[i]]][["lines_G1_Q"]] <- lines_G1_Q
        
        eval_lm_coef_dists <- FALSE  #ARGUMENT
        if(base::isTRUE(eval_lm_coef_dists)) {
            for(j in 1:2) {
                # j <- 2
                if(j == 1) {
                    cat(paste0(types[i], ": Testing for y intercept\n"))  # 1
                    descriptor <- "b"
                } else {
                    cat(paste0(types[i], ": Testing for slope\n"))  # 2
                    descriptor <- "m"
                }
                
                
                
                
                
                
                
                #  Isolate coefficient (or intercept) for t tests
                coef_lm_G1 <- coef(lm_G1)[j]
                coef_lm_Q <- coef(lm_Q)[j]
                
                #  Isolate variance-covariance matrix for the coefficient estimates
                cov_lm_G1 <- vcov(lm_G1)
                cov_lm_Q <- vcov(lm_Q)
                
                #  Calculate standard error for coefficient estimates
                SE_lm_G1 <- sqrt(cov_lm_G1[j, j])
                SE_lm_Q <- sqrt(cov_lm_Q[j, j])
                SE_diff <- sqrt(SE_lm_G1^2 + SE_lm_Q^2)
                
                #  Calculate t statistic, degrees of freedom, and p-value from two-
                #+ tailed t test
                t_stat <- (coef_lm_G1 - coef_lm_Q) / SE_diff
                deg_free <- nrow(t_mRNA) - 2
                p_value <- 2 * pt(-abs(t_stat), deg_free)
                
                
                #  Save objects of interest to list -------------------------------
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
                list_lm_t[[types[i]]][[descriptor]][["p_value"]] <- format(
                    p_value, scientific = TRUE
                )
            }
        }
    }
}

run <- TRUE
if(base::isTRUE(run)) {
    list_lm_t$mRNA$model_scatter_G1$`05_scatter` %>% print()
    list_lm_t$mRNA$model_scatter_Q$`05_scatter` %>% print()
    list_lm_t$mRNA$lines_G1_Q %>% print()
}

run <- TRUE
if(base::isTRUE(run)) {
    list_lm_t$pancRNA$model_scatter_G1$`05_scatter` %>% print()
    list_lm_t$pancRNA$model_scatter_Q$`05_scatter` %>% print()
    list_lm_t$mRNA$lines_G1_Q %>% print()
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
