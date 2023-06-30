
#  rough-draft_plot-TPM_N-varies-on-SS.scraps.R
#  KA

####
#  Function arguments
degree <- 2
span <- 0.75

# ChatGPT: Can you give me a good, simple explanation for the code here?
loess_G1 <- loess(
    log2(t_mRNA$G1_N + 1) ~ log2(t_mRNA$G1_SS + 1),
    span = span,
    degree = degree
)
loess_Q <- loess(
    log2(t_mRNA$Q_N + 1) ~ log2(t_mRNA$Q_SS + 1),
    span = span,
    degree = degree
)

# Extract the LOESS fitted values for each group
fitted_values_G1 <- fitted(loess_G1)
fitted_values_Q <- fitted(loess_Q)

# Perform the Mann-Whitney U test
result <- wilcox.test(fitted_values_G1, fitted_values_Q)

# Extract the p-value from the test result
p_value <- result$p.value

# Plot the LOESS fits
custom_line_G1 <- data.frame(
    G1_SS = t_mRNA$G1_SS,
    G1_N = fitted_values_G1
)
custom_line_Q <- data.frame(
    Q_SS = t_mRNA$Q_SS,
    Q_N = fitted_values_Q
)

# Create the scatterplot and LOESS line
plot_G1 <- ggplot(t_mRNA, aes(x = log2(G1_SS + 1), y = log2(G1_N + 1))) +
    geom_point() +
    geom_line(data = custom_line_G1, aes(x = log2(G1_SS + 1), y = G1_N), color = "red") +
    labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N")  # Set axis labels
plot_Q <- ggplot(t_mRNA, aes(x = log2(Q_SS + 1), y = log2(Q_N + 1))) +
    geom_point() +
    geom_line(data = custom_line_Q, aes(x = log2(Q_SS + 1), y = Q_N), color = "blue") +
    labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N")  # Set axis labels

plot_lines <- ggplot() +
    geom_line(data = custom_line_G1, aes(x = log2(G1_SS + 1), y = G1_N), color = "red") +
    geom_line(data = custom_line_Q, aes(x = log2(Q_SS + 1), y = Q_N), color = "blue") +
    labs(x = "log2(TPM + 1) SS", y = "log2(TPM + 1) N")

# Plot the graph
plot_lines


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
