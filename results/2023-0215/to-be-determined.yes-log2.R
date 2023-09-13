#!/usr/bin/env Rscript

#  to-be-determined.yes-log2.R
#  KA


#  Load libraries, set options ================================================
suppressMessages(library(ggplot2))
suppressMessages(library(gridExtra))
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

#  Keep only WTovn_*_SS samples and filter out zero-counts rows
min_counts <- 1
keep <- rowSums(
    t_mat[, stringr::str_detect(colnames(t_mat), "_SS")] >= min_counts
) >=
    length(t_mat[, stringr::str_detect(colnames(t_mat), "_SS")]) - 1
filt_mat <- t_mat[
    keep, c(1:11, which(stringr::str_detect(colnames(t_mat), "_SS")))
]

#  Check on things
test_for_NAs <- FALSE
if(base::isTRUE(test_for_NAs)) {
    which(is.na(filt_mat[, c(5, 12:ncol(filt_mat))]), arr.ind = TRUE)
}


#  Make a TPM matrix --------------------------------------
#  Calculate counts per kb of feature length (i.e., correct counts for feature
#+ length with an "RPK normalization"); then, divide RPK-normalized elements by
#+ the sum of sample RPK divided by one million
rpk <- filt_mat[, 12:ncol(filt_mat)] / filt_mat$width
tpm <- t( t(rpk) * 1e6 / colSums(rpk) ) %>% tibble::as_tibble()

norm_t <- dplyr::bind_cols(filt_mat[, 1:11], tpm)

#  Check on things
test_for_NAs <- FALSE
if(base::isTRUE(test_for_NAs)) {
    which(is.na(rpk), arr.ind = TRUE)
    which(is.na(norm_t[, c(5, 12:ncol(norm_t))]), arr.ind = TRUE)
}

#  Clean up
rm(rpk, tpm)


#  Add columns for sample-specific log2-regularized means per row -------------
geom_reg_val <- function(df, col_str, pseudocount = 1) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- norm_t
        col_str <- "WTovn_G1_SS"
        pseudocount <- 1
    }
    
    subset <- df[, stringr::str_detect(colnames(df), col_str)]
    row_means_subset <- rowMeans(subset)
    
    log2_row_means_subset <- log2(row_means_subset)
    
    return(log2_row_means_subset)
}


norm_t[["geom_WT_G1_SS"]] <- geom_reg_val(norm_t, "WTovn_G1_SS")
norm_t[["geom_WT_Q_SS"]] <- geom_reg_val(norm_t, "WTovn_Q_SS")


#  Kaam karna chahie ==========================================================
#  Initialize dataframes to work with -----------------------------------------
df <- norm_t
df_KL <- df[df[["genome"]] == "K_lactis", ]
df_SC <- df[df[["genome"]] == "S_cerevisiae", ]
df_20 <- df[df[["genome"]] == "20S", ]


#  Calculate summary statistics -----------------------------------------------
calculate_summary_stats <- function(vec) {
        reg <- vec
    summary <- data.frame(
          mean = mean(reg),
        median = median(reg),
           SEM = sd(reg) / sqrt(length(reg)),
            SD = sd(reg),
           MAD = mad(reg)
    )
    
    return(summary)
}


#  Calculate summary statistics for K.L.
sm_WT_G1_SS_KL <- calculate_summary_stats(df_KL[["geom_WT_G1_SS"]])
 sm_WT_Q_SS_KL <- calculate_summary_stats(df_KL[["geom_WT_Q_SS"]])

print_summary_stats <- TRUE
if(base::isTRUE(print_summary_stats)) {
    cat("\nsm_WT_G1_SS_KL\n")
    print(sm_WT_G1_SS_KL)
    cat("\nsm_WT_Q_SS_KL\n")
    print(sm_WT_Q_SS_KL)
}

#  Calculate summary statistics for S.C.
sm_WT_G1_SS_SC <- calculate_summary_stats(df_SC[["geom_WT_G1_SS"]])
 sm_WT_Q_SS_SC <- calculate_summary_stats(df_SC[["geom_WT_Q_SS"]])

print_summary_stats <- TRUE
if(base::isTRUE(print_summary_stats)) {
    cat("\nsm_WT_G1_SS_SC\n")
    print(sm_WT_G1_SS_SC)
    cat("\nsm_WT_Q_SS_SC\n")
    print(sm_WT_Q_SS_SC)
}


#  Perform linear regressions -------------------------------------------------
perform_linear_regression <- function(df, dv, iv) {
    lr <- lm(df[[dv]] ~ df[[iv]])
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


`lr-KL__dv-G1_on_iv-Q` <- perform_linear_regression(
    df = df_KL, dv = "geom_WT_G1_SS", iv = "geom_WT_Q_SS"
)
`lr-SC__dv-G1_on_iv-Q` <- perform_linear_regression(
    df = df_SC, dv = "geom_WT_G1_SS", iv = "geom_WT_Q_SS"
)

print_linear_equation <- TRUE
if(base::isTRUE(print_linear_equation)) {
    cat(
        "y =",
        round(coef(`lr-KL__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-KL__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "y =",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
}


#  Adjust joint distribution so that linear equation is x = y -----------------
calculate_xy_dv_values <- function(lr, dv) {
    #  Transform values for dependent-variable values such that joint distri-
    #+ bution has linear equation x = y (beta_0 = intercept, beta_1 = slope,
    #+ dv = y)
    beta_0 <- coef(lr)[1]
    beta_1 <- coef(lr)[2] 
    dv_adj <- (dv - beta_0) / beta_1
    
    return(dv_adj)
}


df_KL[["adj_WT_G1_SS"]] <- calculate_xy_dv_values(
    lr = `lr-KL__dv-G1_on_iv-Q`,
    dv = df_KL[["geom_WT_G1_SS"]]
)
df_SC[["adj_WT_G1_SS"]] <- calculate_xy_dv_values(
    lr = `lr-KL__dv-G1_on_iv-Q`,
    dv = df_SC[["geom_WT_G1_SS"]]
)
df_20[["adj_WT_G1_SS"]] <- as.numeric(calculate_xy_dv_values(
    lr = `lr-KL__dv-G1_on_iv-Q`,
    dv = df_20[["geom_WT_G1_SS"]]
))

compare_values <- TRUE
if(base::isTRUE(compare_values)) {
    cat("\ndf_KL\n")
    cat("\n-----\n")
    cat("\nmean:\n")
    print(head(df_KL[["geom_WT_G1_SS"]]))
    cat("\nadj:\n")
    print(head(df_KL[["adj_WT_G1_SS"]]))
    
    cat("\n\ndf_SC\n")
    cat("\n-----\n")
    cat("\nmean:\n")
    print(head(df_SC[["geom_WT_G1_SS"]]))
    cat("\nadj:\n")
    print(head(df_SC[["adj_WT_G1_SS"]]))
    
    cat("\n\ndf_20\n")
    cat("\n-----\n")
    cat("\nmean:\n")
    print(head(df_20[["geom_WT_G1_SS"]]))
    cat("\nadj:\n")
    print(head(df_20[["adj_WT_G1_SS"]]))
}


#  Perform linear regressions for regression-adjusted values ------------------
`lr-KL__dv-G1-adj_on_iv-Q` <- perform_linear_regression(
    df = df_KL, dv = "adj_WT_G1_SS", iv = "geom_WT_Q_SS"
)
`lr-SC__dv-G1-adj_on_iv-Q` <- perform_linear_regression(
    df = df_SC, dv = "adj_WT_G1_SS", iv = "geom_WT_Q_SS"
)

print_linear_equations <- TRUE
if(base::isTRUE(print_linear_equations)) {
    cat(
        "Unadjusted, KL: y =",
        round(coef(`lr-KL__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-KL__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "Adjusted, KL: y =",
        round(coef(`lr-KL__dv-G1-adj_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-KL__dv-G1-adj_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat("\n")
    cat(
        "Unadjusted, SC: y =",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "Adjusted, SC: y =",
        round(coef(`lr-SC__dv-G1-adj_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1-adj_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
}


#  Calculate and apply concentration-based scaling factor ---------------------
#+ ...to the to S. cerevisiae spike-in regression distribution values
vol_spike_Q <- 50
vol_spike_G1 <- 50
OD_Q <- 100
OD_G1 <- 12.5

vol_spike_rat <- vol_spike_Q / vol_spike_G1
OD_rat <- OD_Q / OD_G1

conc_sf <- vol_spike_rat * OD_rat
df_SC[["conc_WT_G1_SS"]] <- df_SC[["adj_WT_G1_SS"]] * conc_sf

check_scaled_values <- TRUE
if(base::isTRUE(check_scaled_values)) {
    head(df_SC[["adj_WT_G1_SS"]]) %>% print()
    head(df_SC[["conc_WT_G1_SS"]]) %>% print()
}


#  Perform linear regressions for concentration-adjusted values ---------------
`lr-SC__dv-G1-conc_on_iv-Q` <- perform_linear_regression(
    df = df_SC, dv = "conc_WT_G1_SS", iv = "geom_WT_Q_SS"
)

print_linear_equations <- TRUE
if(base::isTRUE(print_linear_equations)) {
    cat(
        "Unadjusted, KL: y =",
        round(coef(`lr-KL__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-KL__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "Adjusted, KL: y =",
        round(coef(`lr-KL__dv-G1-adj_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-KL__dv-G1-adj_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat("\n")
    cat(
        "Unadjusted, SC: y =",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "Adjusted, SC: y =",
        round(coef(`lr-SC__dv-G1-adj_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1-adj_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "Concentration-adjusted, SC: y =",
        round(coef(`lr-SC__dv-G1-conc_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1-conc_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
}


#  Calculate the adjusted fold-change difference between G1 and Q means -------
fold_change <- mean(df_SC[["conc_WT_G1_SS"]]) / mean(df_SC[["geom_WT_Q_SS"]])

print_fold_change <- TRUE
if(base::isTRUE(print_fold_change)) {
    cat("Mean RNA fold change", round(fold_change, 1), "\n")
}


#  Draw the expression distributions ------------------------------------------
exclude <- c("conc_WT_" = "", "geom_WT_" = "", "_SS" = "")

means <- df_SC %>%
    dplyr::select(conc_WT_G1_SS, geom_WT_Q_SS) %>%
    dplyr::summarize(
        dplyr::across(tidyselect::everything(), \(x) mean(x, na.rm = TRUE))
    ) %>%
    tidyr::gather(key = "state", value = "TPM") %>%
    dplyr::mutate(state = stringr::str_replace_all(state, exclude, ""))

exp_dist <- df_SC %>%
    dplyr::select(conc_WT_G1_SS, geom_WT_Q_SS) %>%
    tidyr::gather(key = "state", value = "TPM") %>%
    dplyr::mutate(state = stringr::str_replace_all(state, exclude, "")) %>%
    ggplot2::ggplot(., aes(x = state, y = TPM)) +
    geom_violin(aes(fill = state), alpha = 0.7) +
    geom_boxplot(
        width = 0.2, fill = "white", outlier.shape = NA
    ) +
    geom_jitter(
        data = means, aes(x = state, y = TPM),
        position = position_nudge(x = 0), color = "black", fill = "white",
        size = 3, shape = 22
    ) +
    geom_text(
        data = means,
        aes(x = state, y = TPM + 10, label = paste("mean:", round(2^TPM))),
        hjust = -0.35, vjust = 0.5, size = 3.5, color = "#3A3B3C"
    ) +
    scale_fill_manual(
        breaks = c("G1", "Q"),
        values = c("#89CF95", "#768CB8")
    ) +
    labs(x = NULL, y = "TPM") +
    ggtitle(
        "Adjusted TPM distributions",
        subtitle = "Steady-state mRNA expression"
    ) +
    ylim(c(0, 2500)) +
    theme_slick +
    theme(axis.text.x = element_text(angle = 0, hjust = 0.5))

print_exp_dist <- TRUE
if(base::isTRUE(print_exp_dist)) print(exp_dist)
