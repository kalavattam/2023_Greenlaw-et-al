#!/usr/bin/env Rscript

#  to-be-determined.R
#  KA


#  Load libraries, set options ================================================
suppressMessages(library(ggplot2))
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and ggplot2 themes ====================================
`%notin%` <- base::Negate(`%in%`)


filter_process_counts_matrix <- function(
    counts_matrix,
    named_character_vector
) {
    # ...
    #
    # :param counts_matrix: counts matrix from htseq-count
    # :param named_character_vector: ...
    # :return df: counts matrix as tibble
    
    #  Perform debugging
    debug <- FALSE
    if(base::isTRUE(debug)) {
        counts_matrix <- t_cm
        named_character_vector <- col_cor
    }
    
    df <- dplyr::bind_cols(
        counts_matrix[, 1],
        counts_matrix[
            , colnames(counts_matrix) %in% named_character_vector
        ]
    )
    df <- dplyr::bind_cols(
        df[, 1],
        df[, 2:ncol(df)][
            , match(named_character_vector, colnames(df)[2:ncol(df)])
        ]
    )
    names(df)[2:ncol(df)] <- names(named_character_vector)
    
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
        panel.border = element_rect(linewidth = 2, color = "black", fill = NA)
    )

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")

theme_AG_no_legend <- theme_AG + theme(legend.position = "none")

theme_AG_boxed_no_legend <- theme_AG_boxed + theme(legend.position = "none")


#  Get situated, load counts matrix ===========================================
#  Set work directory
if(stringr::str_detect(getwd(), "kalavattam")) {
    p_base <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_base <- "/Users/kalavatt/projects-etc"
}
p_exp <- "2022-2023_RRP6-NAB3/results/2023-0215"

paste(p_base, p_exp, sep = "/") %>% setwd()

#  Initialize variables for matrix and gff3
p_cm <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
f_cm <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"

p_gtf <- "infiles_gtf-gff3/already"
f_gtf <- "combined_SC_KL_20S.gff3"


#  Read in htseq-count counts matrix ------------------------------------------
#  Check that counts matrix exists
run <- FALSE
if(base::isTRUE(run)) {
    paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        file.exists()  # [1] TRUE
}

#  Load matrix as tibble
t_cm <- paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
    readr::read_tsv(show_col_types = FALSE) %>%
    dplyr::slice(-1)  # Slice out the first row, which contains file info

#  Clean the data
colnames(t_cm) <- colnames(t_cm) %>%
    gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .)

t_cm <- t_cm %>%
    dplyr::mutate(
        features = features %>%
            gsub("^transcript\\:", "", .) %>%
            gsub("_mRNA", "", .)
    )

#  Clean up, correct, and abbreviate sample names
col_cor <- setNames(
    c(
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1",       #EXCLUDE
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1",      #EXCLUDE
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",       #FIXME* ∆ rep1 → rep2
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",       #FIXME* ∆ rep2 → rep1
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",      #FIXME* ∆ rep1 → rep2
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",      #FIXME* ∆ rep2 → rep1
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",   #FIXME* ∆ rep1 → rep2
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",   #FIXME* ∆ rep2 → rep1
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",  #FIXME* ∆ rep1 → rep2
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",  #FIXME* ∆ rep2 → rep1
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",   #FIXME* ∆ rep1 → rep2
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",   #FIXME* ∆ rep2 → rep1
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",  #FIXME* ∆ rep1 → rep2
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",  #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",     #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",     #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",       #FIXME* ∆ rep1 → rep2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",       #FIXME* ∆ rep2 → rep1
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",      #FIXME* ∆ rep1 → rep2  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",      #FIXME* ∆ rep1 → rep2  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",      #FIXME* ∆ rep2 → rep1
        "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
        "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",    #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",    #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",       #FIXME‡ ∆ tech1 → tech2
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",       #FIXME‡ ∆ tech1 → tech2
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1", 
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1",
        "WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1",         #FIXME† Duplicated #1
        "WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1",        #FIXME† Duplicated #2
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",         #FIXME† Duplicated #1
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"         #FIXME† Duplicated #2
    ),
    c(
        "n3d_Q_N_rep1_tech1", 
        "n3d_Q_N_rep2_tech1", 
        "n3d_Q_N_rep3_tech1",       #EXCLUDE
        "n3d_Q_SS_rep1_tech1", 
        "n3d_Q_SS_rep2_tech1", 
        "n3d_Q_SS_rep3_tech1",      #EXCLUDE
        "od_Q_N_rep1_tech1", 
        "od_Q_N_rep2_tech1", 
        "od_Q_SS_rep1_tech1", 
        "od_Q_SS_rep2_tech1", 
        "r1n_Q_N_rep2_tech1",       #DONE* ∆ rep1 → rep2
        "r1n_Q_N_rep1_tech1",       #DONE* ∆ rep2 → rep1
        "r1n_Q_SS_rep2_tech1",      #DONE* ∆ rep1 → rep2
        "r1n_Q_SS_rep1_tech1",      #DONE* ∆ rep2 → rep1
        "r6n_DSm2_SS_rep2_tech1",   #DONE* ∆ rep1 → rep2
        "r6n_DSm2_SS_rep1_tech1",   #DONE* ∆ rep2 → rep1
        "r6n_DSp24_SS_rep2_tech1",  #DONE* ∆ rep1 → rep2
        "r6n_DSp24_SS_rep1_tech1",  #DONE* ∆ rep2 → rep1
        "r6n_DSp2_SS_rep2_tech1",   #DONE* ∆ rep1 → rep2
        "r6n_DSp2_SS_rep1_tech1",   #DONE* ∆ rep2 → rep1
        "r6n_DSp48_SS_rep2_tech1",  #DONE* ∆ rep1 → rep2
        "r6n_DSp48_SS_rep1_tech2",  #DONE* ∆ rep2 → rep1  #DONE‡ ∆ tech1 → tech2
        "r6n_G1_SS_rep2_tech2",     #DONE* ∆ rep1 → rep2  #DONE‡ ∆ tech1 → tech2
        "r6n_G1_SS_rep1_tech2",     #DONE* ∆ rep2 → rep1  #DONE‡ ∆ tech1 → tech2
        "r6n_Q_N_rep2_tech1",       #DONE* ∆ rep1 → rep2
        "r6n_Q_N_rep1_tech1",       #DONE* ∆ rep2 → rep1
        "r6n_Q_SS_rep2_tech1",      #DONE* ∆ rep1 → rep2  #OK
        "r6n_Q_SS_rep2_tech2",      #DONE* ∆ rep1 → rep2  #OK
        "r6n_Q_SS_rep1_tech1",      #DONE* ∆ rep2 → rep1
        "t4n_DSm2_SS_rep1_tech1", 
        "t4n_DSm2_SS_rep2_tech1", 
        "t4n_DSp24_SS_rep1_tech1", 
        "t4n_DSp24_SS_rep2_tech1", 
        "t4n_DSp2_SS_rep1_tech1", 
        "t4n_DSp2_SS_rep2_tech1", 
        "t4n_DSp48_SS_rep1_tech1", 
        "t4n_DSp48_SS_rep2_tech1", 
        "WT_DSm2_SS_rep1_tech1", 
        "WT_DSm2_SS_rep2_tech1", 
        "WT_DSp24_SS_rep1_tech1", 
        "WT_DSp24_SS_rep2_tech1", 
        "WT_DSp2_SS_rep1_tech1", 
        "WT_DSp2_SS_rep2_tech1", 
        "WT_DSp48_SS_rep1_tech1",   #OK
        "WT_DSp48_SS_rep1_tech2",   #OK
        "WT_DSp48_SS_rep2_tech1", 
        "WTovn_G1_N_rep1_tech1", 
        "WTovn_G1_N_rep2_tech1", 
        "WTovn_G1_SS_rep1_tech1", 
        "WTovn_G1_SS_rep2_tech1", 
        "WT_G1_SS_rep1_tech2",      #DONE‡ ∆ tech1 → tech2
        "WT_G1_SS_rep2_tech2",      #DONE‡ ∆ tech1 → tech2
        "WTovn_Q_N_rep1_tech1", 
        "WTovn_Q_N_rep2_tech1", 
        "WTovn_Q_SS_rep1_tech1", 
        "WTovn_Q_SS_rep2_tech1", 
        "WTtest_Q_N_rep2_tech1",    #DONE† Duplicated #1
        "WTtest_Q_SS_rep2_tech1",   #DONE† Duplicated #2
        "WT_Q_N_rep1_tech1", 
        "WT_Q_N_rep2_tech1",        #DONE† Duplicated #1
        "WT_Q_SS_rep1_tech1", 
        "WT_Q_SS_rep2_tech1"        #DONE† Duplicated #2
    )
)

run <- FALSE
if(base::isTRUE(run)) {
    t_cm.bak <- t_cm
    # t_cm <- t_cm.bak
}
t_cm <- filter_process_counts_matrix(t_cm, col_cor)


#  To associate features with metadata, load gff3 or gtf file -----------------
run <- FALSE
if(base::isTRUE(run)) {
    paste(p_gtf, f_gtf, sep = "/") %>% file.exists()  # [1] TRUE
}

#  Load in, subset, and "clean up" gff3
t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
    rtracklayer::import() %>%
    as.data.frame() %>%
    dplyr::as_tibble() %>%
    dplyr::filter(type == "mRNA") %>%
    dplyr::mutate(
        ID = ID %>%
            gsub("^transcript\\:", "", .) %>%
            gsub("_mRNA", "", .)
    ) %>%
    dplyr::rename(
        c(chr = seqnames, names = Name, features = ID)
    )

#  Subset gff3 tibble to keep only relevant columns
keep <- c(
    "chr", "start", "end",
    "width", "strand", "type",
    "features", "biotype", "names"
)
t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]

#  Convert column names from list to character vector, and replace empty fields
#+ with NA character values
t_gtf$names <- ifelse(
    as.character(t_gtf$names) == "character(0)",
    NA_character_,
    as.character(t_gtf$names)
)


#  Combine "counts matrix tibble" and "gff3 tibble" ---------------------------
t_mat <- dplyr::full_join(t_gtf, t_cm, by = "features")

#  Add column of "thorough" names
t_mat$thorough <- ifelse(!is.na(t_mat$names), t_mat$names, t_mat$features)
t_mat <- t_mat %>% dplyr::relocate(thorough, .after = names)

#  Sort counts columns by column names
tmp_A <- t_mat[, 1:10]
tmp_B <- t_mat[, 11:ncol(t_mat)][, order(names(t_mat[, 11:ncol(t_mat)]))]
t_mat <- dplyr::bind_cols(tmp_A, tmp_B)

#  Remove unneeded variables
rm(list = ls(pattern = "tmp_"))
rm(f_gtf, f_cm, p_base, p_exp, p_gtf, p_cm, t_gtf, t_cm)


#  Order and categorize the combined counts matrix/gff3 tibble ----------------
#  Order tibble by chromosome names and feature start positions
chr_SC <- c(
    "I", "II", "III", "IV", "V", "VI",
    "VII", "VIII", "IX", "X", "XI", "XII",
    "XIII", "XIV", "XV", "XVI", "Mito"
)
chr_KL <- c("A", "B", "C", "D", "E", "F")
chr_20S <- "20S"
chr_order <- c(chr_SC, chr_KL, chr_20S)
t_mat$chr <- t_mat$chr %>% as.factor()
t_mat$chr <- ordered(t_mat$chr, levels = chr_order)

t_mat <- t_mat %>% dplyr::arrange(chr, start)

#  Categorize chromosomes by genome of origin
t_mat$genome <- ifelse(
    t_mat$chr %in% chr_SC,
    "S_cerevisiae",
    ifelse(
        t_mat$chr %in% chr_KL,
        "K_lactis",
        ifelse(
            # t_mat$chr %in% chr_20S,
            t_mat$features %in% chr_20S,
            "20S",
            NA
        )
    )
) %>%
    as.factor()
t_mat <- t_mat %>% dplyr::relocate(genome, .before = chr)

t_mat$start[which(t_mat$genome == "20S")] <-
    t_mat$end[which(t_mat$genome == "20S")] <-
    0
t_mat$chr[which(t_mat$genome == "20S")] <- "20S"

#  Remove unneeded variables again
rm(chr_20S, chr_KL, chr_SC, chr_order)


#  Extract htseq-count summary metrics ----------------------------------------
#  They are at the end of the matrices and have names that begin with two
#+ underscore characters
underscore <- t_mat[
    stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), 
]

#  Exclude htseq-count summary metrics from t_mat
t_mat <- t_mat[!stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), ]

run <- FALSE
if(base::isTRUE(run)) t_mat %>% tail(10)


#  Subset t_mat to include counts only for samples of interest ----------------
run <- FALSE
if(base::isTRUE(run)) {
    t_mat.bak <- t_mat
    # t_mat <- t_mat.bak
    # colnames(t_mat)
}

tmp_A <- t_mat[, 1:11]
tmp_B <- t_mat[, 12:ncol(t_mat)]

samples <- "Ovation"  #ARGUMENT
if(samples == "Ovation") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn"
    )]
}

t_mat <- dplyr::bind_cols(tmp_A, tmp_C)
rm(list = ls(pattern = "tmp_"))

#  Convert counts columns to type integer
t_mat[, 12:ncol(t_mat)] <- sapply(t_mat[, 12:ncol(t_mat)], as.integer)

#  Filter out zero-count rows
keep <- rowSums(t_mat[, 12:ncol(t_mat)] >= 10) >= length(12:ncol(t_mat)) - 1
filt_mat <- t_mat[keep, ]


#  Make a TPM matrix --------------------------------------
#  Calculate counts per kb of feature length (i.e., correct counts for feature
#+ length with an "RPK normalization"); then, divide RPK-normalized elements by
#+ the sum of sample RPK divided by one million
# rpk <- t_mat[, 12:ncol(t_mat)] / t_mat$width
# tpm <- t((t(rpk) * 1e6) / colSums(rpk)) %>% tibble::as_tibble()
# 
# norm_t <- dplyr::bind_cols(t_mat[, 1:11], tpm)
# rm(rpk, tpm)

rpk <- filt_mat[, 12:ncol(filt_mat)] / filt_mat$width
tpm <- t((t(rpk) * 1e6) / colSums(rpk)) %>% tibble::as_tibble()

norm_t <- dplyr::bind_cols(filt_mat[, 1:11], tpm)
rm(rpk, tpm)


#  Add columns for sample-specific means per row (feature) --------------------
norm_t$mean_WT_G1_N <- rowMeans(norm_t[
    , stringr::str_detect(colnames(norm_t), "WTovn_G1_N")
])
norm_t$mean_WT_G1_SS <- rowMeans(norm_t[
    , stringr::str_detect(colnames(norm_t), "WTovn_G1_SS")
])
norm_t$mean_WT_Q_N <- rowMeans(norm_t[
    , stringr::str_detect(colnames(norm_t), "WTovn_Q_N")
])
norm_t$mean_WT_Q_SS <- rowMeans(norm_t[
    , stringr::str_detect(colnames(norm_t), "WTovn_Q_SS")
])


###############################################################################
################################### SCRATCH ###################################
###############################################################################

#  Kaam karna chahie ==========================================================
# df <- norm_t_KL
# df <- filt_t_KL
df <- norm_t
df_KL <- df[df$genome == "K_lactis", ]
df_SC <- df[df$genome == "S_cerevisiae", ]


#  Calculate summary statistics -----------------------------------------------
calculate_summary_stats <- function(vec) {
    reg <- log2(vec + 1)
    summary <- data.frame(
          mean = mean(reg),
        median = median(reg),
           SEM = sd(reg) / sqrt(length(reg)),
            SD = sd(reg),
           MAD = mad(reg)
    )
    
    return(summary)
}


 sm_WT_G1_N <- calculate_summary_stats(df_KL$mean_WT_G1_N)
  sm_WT_Q_N <- calculate_summary_stats(df_KL$mean_WT_Q_N)
sm_WT_G1_SS <- calculate_summary_stats(df_KL$mean_WT_G1_SS)
 sm_WT_Q_SS <- calculate_summary_stats(df_KL$mean_WT_Q_SS)

print_summary_stats <- TRUE
if(base::isTRUE(print_summary_stats)) {
    print(sm_WT_G1_N)
    print(sm_WT_Q_N)
    print(sm_WT_G1_SS)
    print(sm_WT_Q_SS)
}


#  Draw histogram(s) ----------------------------------------------------------
determine_bin_width <- function(df, column, desired = 500) {
    data_range <- range(
        log2(df[[column]] + 1),
        na.rm = TRUE
    )
    bin_width <- diff(data_range) / desired
    
    return(bin_width)
}


bin_WT_G1_N <- determine_bin_width(df_KL, "mean_WT_G1_N")
bin_WT_Q_N <- determine_bin_width(df_KL, "mean_WT_Q_N")

plot_histogram <- function(df, column, bin_width) {
    histogram <- ggplot(df, aes(x = log2(.data[[column]] + 1))) +
        geom_histogram(binwidth = bin_width, fill = "#00808075") +
        labs(
            title = paste0("Histogram, ", column),
            x = "log2(TPM + 1)",
            y = "Frequency"
        ) +
        theme_minimal()
    
    return(histogram)
}


hist_WT_G1_N <- plot_histogram(
    df = df_KL,
    column = "mean_WT_G1_N",
    bin_width = bin_WT_G1_N
)
hist_WT_Q_N <- plot_histogram(
    df = df_KL,
    column = "mean_WT_Q_N",
    bin_width = bin_WT_Q_N
)

print_histograms <- TRUE
if(base::isTRUE(print_histograms)) {
    hist_WT_G1_N %>% print()
    hist_WT_Q_N %>% print()
}


#  Draw density plots(s) ------------------------------------------------------
plot_density <- function(df, column, summary) {
    density <- ggplot(data = df, aes(x = log2(.data[[column]] + 1))) +
        geom_density(fill = "#00808075", linewidth = 0) +
        labs(
            title = paste0("Density plot, ", column),
            x = "log2(TPM + 1)",
            y = "Density"
        ) +
        geom_vline(
            data = summary,
            aes(xintercept = mean),
            color = "#80008066",
            linetype = "dashed",
            size = 1
        ) +
        geom_vline(
            data = summary,
            aes(xintercept = median),
            color = "#00000066",
            linetype = "dotted",
            size = 1
        ) +
        geom_text(
            data = summary,
            aes(x = mean, y = 0.25, label = paste("mean =", round(mean, 2))),
            color = "#800080"
        ) +
        geom_text(
            data = summary,
            aes(x = median, y = 0.20, label = paste("median =", round(median, 2))),
            color = "#000000"
        ) +
        theme_slick
    
    return(density)
}


dn_WT_G1_N <- plot_density(
    df = df_KL,
    column = "mean_WT_G1_N",
    summary = sm_WT_G1_N
)
dn_WT_Q_N <- plot_density(
    df = df_KL,
    column = "mean_WT_Q_N",
    summary = sm_WT_Q_N
)

print_densities <- TRUE
if(base::isTRUE(print_densities)) {
    print(dn_WT_G1_N)
    print(dn_WT_Q_N)
}


#  Perform linear regressions -------------------------------------------------
perform_linear_regression <- function(df, dv, iv) {
    lr <- lm(log2(df[[dv]] + 1) ~ log2(df[[iv]]  + 1))
    return(lr)
}


`obtain_beta-0_intercept` <- function(obj_lm) {
    beta_0 <- coef(obj_lm)[1]
    return(beta_0)
}


`obtain_beta-1_slope` <- function(obj_lm) {
    beta_1 <- coef(obj_lm)[2]
    return(beta_1)
}


`lr__dv-G1-N_on_iv-Q-N` <- perform_linear_regression(
    df = df_KL, dv = "mean_WT_G1_N", iv = "mean_WT_Q_N"
)
beta_0 <- intercept <- `obtain_beta-0_intercept`(`lr__dv-G1-N_on_iv-Q-N`)
beta_1 <- slope <- `obtain_beta-1_slope`(`lr__dv-G1-N_on_iv-Q-N`)
cat("y =", round(beta_0, 2), "+", round(beta_1, 2), "* x + e\n")


#PICKUP with changing the x and y values to remove intercept of -2.51 and slope of 0.83


#  Draw scatter plot(s) -------------------------------------------------------
plot_scatter <- function(
    df, col_dv, col_iv, lr,
    col = "#00808010",
    draw_density = TRUE,
    x_low = -5, y_low = -5,
    x_high = 12.5, y_high = 12.5,
    title = "Scatter plot, K. lactis transcripts"
) {
    debug <- TRUE
    if(base::isTRUE) {
        df <- df_KL
        col_dv <- "mean_WT_G1_N"
        col_iv <- "mean_WT_Q_N"
        lr <- `lr__dv-G1-N_on_iv-Q-N`
        col = "#00808010"
        draw_density = TRUE
        x_low = -5
        y_low = -5
        x_high = 12.5
        y_high = 12.5
        title = "Scatter plot, K. lactis transcripts"
    }
    
    scatter <- ggplot2::ggplot(
        df, aes(x = log2(.data[[col_iv]] + 1), y = log2(.data[[col_dv]] + 1))
    ) +
        geom_point(size = 2.5, col = col) +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
        geom_abline(
            intercept = 0,
            slope = 1,
            color = "black",
            linetype = "solid"
        ) +
        geom_abline(
            intercept = coef(lr)[1],
            slope = coef(lr)[2],
            color = "red",
            linetype = "dashed"
        ) +
        labs(
            x = paste0("log2(", col_iv, " + 1)"),
            y = paste0("log2(", col_dv, " + 1)"),
            title = title
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        theme_slick
    
    return(scatter)
}


`dv_G1-N__iv_Q-N` <- plot_scatter(
    df = df_KL,
    col_dv = "mean_WT_G1_N",
    col_iv = "mean_WT_Q_N"
)

print_scatter_plots <- TRUE
if(base::isTRUE(print_scatter_plots)) {
    print(`dv_G1-N__iv_Q-N` )
}


#  Adjust scatter plot and linear regression on x = y -------------------------
adjust_distribution_KL <- function(df, col_iv, col_dv) {
    mean_iv <- mean(log2(df[[col_iv]] + 1))
    mean_dv <- mean(log2(df[[col_dv]] + 1))
    mean_diff <- mean_iv - mean_dv
    
    adj_iv <- log2(df_KL[["mean_WT_Q_N"]] + 1) - mean_diff
    adj_dv <- log2(df_KL[["mean_WT_G1_N"]] + 1) - mean_diff
    adj_lr <- lm(adj_dv ~ adj_iv)
    
    adj <- list()
    adj[["log2_adj_iv"]] <- adj_iv
    adj[["log2_adj_dv"]] <- adj_dv
    adj[["adj_lr"]] <- adj_lr
    
    return(adj)
}


`adj-WT-G1_on_adj-WT-Q` <- adjust_distribution_KL(
    df = df_KL,
    col_iv = "mean_WT_Q_N",
    col_dv = "mean_WT_G1_N"
)

df_KL[["adj_log2_WT_Q_N"]] <- `adj-WT-G1_on_adj-WT-Q`[["log2_adj_iv"]]
df_KL[["adj_log2_WT_G1_N"]] <- `adj-WT-G1_on_adj-WT-Q`[["log2_adj_dv"]]


plot_scatter_adj <- function(
    df, col_dv, col_iv, lr,
    color = "#185E9110",
    draw_density = TRUE,
    x_low = -5, y_low = -5,
    x_high = 12.5, y_high = 12.5,
    title = "Centered scatter plot and regression line"
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- df_KL
        col_iv <- "adj_log2_WT_Q_N"
        col_dv <- "adj_log2_WT_G1_N"
        lr <- `adj-WT-G1_on_adj-WT-Q`[["adj_lr"]]
        color <- "#185E9110"
        draw_density <- TRUE
        x_low <- -5
        y_low <- -5
        x_high <- 12.5
        y_high <- 12.5
        title <- "Centered scatter plot and regression line"
    }
    
    adj_scatter <- ggplot(df, aes(x = .data[[col_iv]], y = .data[[col_dv]])) +
        geom_point(size = 2.5, col = color) +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
        geom_abline(
            intercept = 0,
            slope = 1,
            color = "black",
            linetype = "solid"
        ) +
        geom_abline(
            intercept = coef(lr)[1],
            slope = coef(lr)[2],
            color = "red",
            linetype = "dashed"
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        labs(x = col_iv, y = col_dv, title = title) +
        theme_slick
    
    return(adj_scatter)
}


`adj-dv_G1-N__adj-iv_Q-N` <- plot_scatter_adj(
    df_KL,
    col_dv = "adj_log2_WT_G1_N",
    col_iv = "adj_log2_WT_Q_N",
    lr = `adj-WT-G1_on_adj-WT-Q`[["adj_lr"]]
)

print(`adj-dv_G1-N__adj-iv_Q-N`)

###############################################################################
################################### SCRATCH ###################################
###############################################################################
