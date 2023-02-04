#!/usr/bin Rscript

#  check_umi-tools_dedup.R
#  KA

library(tidyverse)
library(beeswarm)

setwd("/Users/kalavatt/projects-etc/2022_transcriptome-construction/tmp/2023-0202_umi-tools_dedup")
list.files()

#  stackoverflow.com/questions/45665496/how-would-one-readlines-from-a-gzip-file-in-r
#  stackoverflow.com/questions/68197596/how-to-read-lines-in-r-starting-with-certain-string
sample <- "5782_Q_IN_S8.UMIs"
f_1 <- paste0(sample, ".dedu-adjusted.stdout.txt.gz")
f_2 <- paste0(sample, ".dedu-adjusted.stats_per_umi.tsv.gz")

rl <- readLines(gzcon(file(f_1, open="rb")))
stats_per_umi <- readr::read_tsv(f_2)

strings <- c(
    "INFO total_umis",
    "INFO #umis",
    "INFO Reads: Input Reads:",
    "INFO Number of reads out:",
    "INFO Total number of positions deduplicated:",
    "INFO Mean number of unique UMIs per position:",
    "INFO Max. number of unique UMIs per position:"
)

# stackoverflow.com/questions/31774086/extracting-text-after-last-period-in-string
UMIs_total <- rl[grep(strings[1], rl)] %>%
    sub('.*total_umis ', '', .) %>%
    as.integer()
UMIs_unique_pre <- rl[grep(strings[2], rl)] %>%
    sub('.*#umis ', '', .) %>%
    as.integer()
UMIs_unique_post <-
    stats_per_umi[stats_per_umi$median_counts_post > 0, ]$UMI %>%
        unique() %>%
        length() %>%
        as.integer()
UMIs_unique_post_pct <- round(
    (UMIs_unique_post / UMIs_unique_pre) * 100, digits = 2
)
UMIs_unique_rm <- UMIs_unique_pre - UMIs_unique_post
UMIs_unique_rm_pct <- round(
    (UMIs_unique_rm / UMIs_unique_pre) * 100, digits = 2
)

reads_pre <- rl[grep(strings[3], rl)] %>%
    sub('.*\\: ', '', .) %>%
    as.integer()
reads_post <- rl[grep(strings[4], rl)] %>%
    sub('.*\\: ', '', .) %>%
    as.integer()
reads_post_pct <- round((reads_post / reads_pre) * 100, digits = 2)
reads_rm <- reads_pre - reads_post
reads_rm_pct <- round((reads_rm / reads_pre) * 100, digits = 2)

pos_dedup <- rl[grep(strings[5], rl)] %>%
    sub('.*\\: ', '', .) %>%
    as.integer()
UMIs_pos_mean <- rl[grep(strings[6], rl)] %>%
    sub('.*\\: ', '', .) %>%
    as.double()
UMIs_pos_max <- rl[grep(strings[7], rl)] %>%
    sub('.*\\: ', '', .) %>%
    as.integer()

#  Plot the read deduplication rates: Stacked barchart ------------------------
x1 <- tibble::tibble(
    class = c("UMIs", "UMIs"),
    type = c("UMIs_unique_kp", "UMIs_unique_rm"),
    counts = c(UMIs_unique_post, UMIs_unique_rm)
)
#  Absolute
ggplot2::ggplot(x1, ggplot2::aes(x = class, y = counts, fill = type)) +
    ggplot2::geom_bar(position = "stack", stat = "identity")
#  Percent
ggplot2::ggplot(x1, ggplot2::aes(x = class, y = counts, fill = type)) +
    ggplot2::geom_bar(position = "fill", stat = "identity")
#TODO Flip UMIs_unique_kp and UMIs_unique_rm in plot


#  Plot the read removal rates: Stacked barchart ------------------------------
x2 <- tibble::tibble(
    class = c("reads", "reads"),
    type = c("reads_kp", "reads_rm"),
    counts = c(reads_post, reads_rm)
)
#  Absolute
ggplot2::ggplot(x2, ggplot2::aes(x = class, y = counts, fill = type)) +
    ggplot2::geom_bar(position = "stack", stat = "identity")
#  Percent
ggplot2::ggplot(x2, ggplot2::aes(x = class, y = counts, fill = type)) +
    ggplot2::geom_bar(position = "fill", stat = "identity")
#TODO Flip reads_kp and reads_rm in plot


#  Generate a swarmplot of umi stats ------------------------------------------
#TODO Need to read in data for multiple samples...
# "positions_deduplicated"
# "total_umis"
# "unique_umis"
# "mean_umi_per_pos"
# "max_umi_per_pos"

#STRATEGY Make a simple script to collect values from outfiles and print the
#+ results; append the results to a .txt dataframe in real time, with samples
#+ as column and features as rows; finally, use these data.frames as input to
#+ beeswarm in a separate script


#INPROGRESS Make a bar graph for reads in, reads out, and no. reads removed
#TODO Make a beeswarm plot for
#+  - pos_dedup
#+  - UMIs_total
#+  - 
#TODO Fr/f2, read in/calculate UMIs_total pre- and post-deduplication 
#DONE Fr/f2, read in/calculate UMIs_unique pre- and post-deduplication 
