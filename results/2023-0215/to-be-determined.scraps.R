#!/usr/bin/env Rscript

library(ggplot2)
library(gridExtra)

#  Set the number of rows
n_rows <- 200

#  Set the desired means
mean_col1 <- 2.1
mean_col2 <- 2.4

#  Set the standard deviations for both tails
sd_left <- 0.1  # Standard deviation for the left side (smaller tail)
sd_right <- 0.3  # Standard deviation for the right side (larger tail)

#  Generate random data with desired means and mixed tails
set.seed(24)  # For reproducibility
col1_left <- rnorm(n_rows, mean = mean_col1, sd = sd_left)
col1_right <- rnorm(n_rows, mean = mean_col1, sd = sd_right)
col2_left <- rnorm(n_rows, mean = mean_col2, sd = sd_left)
col2_right <- rnorm(n_rows, mean = mean_col2, sd = sd_right)

#  Combine the tails for each column
col1 <- ifelse(runif(n_rows) > 0.5, col1_left, col1_right)
col2 <- ifelse(runif(n_rows) > 0.5, col2_left, col2_right)

#  Create the dataframe
df <- data.frame(Column1 = col1, Column2 = col2)

#  Check the means of the generated columns
cat("Mean of Column 1:", mean(df$Column1), "\n")
cat("Mean of Column 2:", mean(df$Column2), "\n")

#  Check the head of the dataframe
head(df)

#  Create a density plot for Column1 with mean and median lines
plot_col1 <- ggplot(df, aes(x = Column1)) +
    geom_density(fill = "blue", alpha = 0.5, linewidth = 0) +
    geom_vline(aes(xintercept = mean(Column1)), color = "red", linetype = "dashed", linewidth = 1) +
    geom_vline(aes(xintercept = median(Column1)), color = "green", linetype = "dashed", linewidth = 1) +
    labs(title = "Density Plot for Column1 with Mean and Median", x = "Column1") +
    theme_minimal()

#  Create a density plot for Column2 with mean and median lines
plot_col2 <- ggplot(df, aes(x = Column2)) +
    geom_density(fill = "green", alpha = 0.5, linewidth = 0) +
    geom_vline(aes(xintercept = mean(Column2)), color = "red", linetype = "dashed", linewidth = 1) +
    geom_vline(aes(xintercept = median(Column2)), color = "blue", linetype = "dashed", linewidth = 1) +
    labs(title = "Density Plot for Column2 with Mean and Median", x = "Column2") +
    theme_minimal()

#  Display the density plots side by side
grid.arrange(plot_col1, plot_col2, ncol = 2)

#  Calculate the mean difference between Column2 and Column1
mean_diff <- mean(df$Column2) - mean(df$Column1)

#  Shift Column1 values to match the mean of Column2
df$Column1_shift <- df$Column1 + mean_diff

#  Check the new mean of Column1 to verify it matches the mean of Column2
cat("Mean of Column 1:", mean(df$Column1), "\n")
cat("Mean of shifted Column 1:", mean(df$Column1_shift), "\n")
cat("Mean of Column 2:", mean(df$Column2), "\n")

plot_col1_shift <- ggplot(df, aes(x = Column1_shift)) +
    geom_density(fill = "blue", alpha = 0.5, linewidth = 0) +
    geom_vline(aes(xintercept = mean(Column1_shift)), color = "red", linetype = "dashed", linewidth = 1) +
    geom_vline(aes(xintercept = median(Column1_shift)), color = "green", linetype = "dashed", linewidth = 1) +
    labs(title = "Density Plot for Column1 with Mean and Median", x = "Column1_shift") +
    theme_minimal()

#  Display the density plots side by side
grid.arrange(plot_col1, plot_col2, plot_col1_shift, ncol = 3)

#  Create a density plot for Column1_shift and overlay it on the Column2 plot
plot_combined <- plot_col2 +
    geom_density(data = df, aes(x = Column1_shift), fill = "blue", alpha = 0.5, linewidth = 0) +
    labs(title = "Density Plot for Column1_shift and Column2 with Mean and Median", x = "Column1_shift")

#  Display the combined density plot
print(plot_combined)

#  Create a scatter plot for Column1 vs. Column2
scatter_col1_vs_col2 <- ggplot(df, aes(x = Column1, y = Column2)) +
    geom_point(color = "blue", alpha = 0.5) +
    labs(title = "Scatter Plot: Column1 vs. Column2", x = "Column1", y = "Column2") +
    theme_minimal()

#  Create a scatter plot for Column1_shift vs. Column2
scatter_col1_shift_vs_col2 <- ggplot(df, aes(x = Column1_shift, y = Column2)) +
    geom_point(color = "red", alpha = 0.5) +
    labs(title = "Scatter Plot: Column1_shift vs. Column2", x = "Column1_shift", y = "Column2") +
    theme_minimal()

#  Display the scatter plots side by side
grid.arrange(scatter_col1_vs_col2, scatter_col1_shift_vs_col2, ncol = 2)

#  Overlay the scatter plots by adding a new layer with higher transparency
combined_scatter_plot <- scatter_col1_vs_col2 +
    geom_point(data = df, aes(x = Column1_shift, y = Column2), color = "red", alpha = 0.5) +
    labs(title = "Overlay of Scatter Plots", x = "Column1/Column1_shift", y = "Column2")

#  Display the overlay scatter plot
print(combined_scatter_plot)
