
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
