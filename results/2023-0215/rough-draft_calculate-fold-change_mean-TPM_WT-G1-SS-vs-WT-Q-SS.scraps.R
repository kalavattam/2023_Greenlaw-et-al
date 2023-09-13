#!/usr/bin/env Rscript

#  to-be-determined.R
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

# #  Filter out zero-count rows
# keep <- rowSums(t_mat[, 12:ncol(t_mat)] >= 10) >= length(12:ncol(t_mat)) - 1
# filt_mat <- t_mat[keep, ]

#  Keep only WTovn_*_SS samples and filter out zero-counts rows
keep <- rowSums(t_mat[, stringr::str_detect(colnames(t_mat), "_SS")] >= 10) >=
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


#  Set up sample stem strings -------------------------------------------------
# str_G1 <- "WT_G1_N"
# str_N <- "WT_Q_N"
str_G1 <- "WT_G1_SS"
str_Q <- "WT_Q_SS"


#  Add columns for sample-specific log2-regularized means per row -------------
mean_reg_val <- function(df, col_str) {
    mean_reg_val <- log2(
        rowMeans(df[
            , stringr::str_detect(colnames(df), col_str)
        ]) + 1
    )
    
    return(mean_reg_val)
}


# norm_t[["mlr_WT_G1_N"]] <- mean_reg_val(norm_t, "WTovn_G1_N")
# norm_t[["mlr_WT_Q_N"]] <- mean_reg_val(norm_t, "WTovn_Q_N")
norm_t[["mlr_WT_G1_SS"]] <- mean_reg_val(norm_t, "WTovn_G1_SS")
norm_t[["mlr_WT_Q_SS"]] <- mean_reg_val(norm_t, "WTovn_Q_SS")

# norm_t[[paste0("mlr_", str_G1)]] <- mean_reg_val(norm_t, "WTovn_G1_SS")
# norm_t[[paste0("mlr_", str_Q)]] <- mean_reg_val(norm_t, "WTovn_Q_SS")


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
 # sm_WT_G1_N_KL <- calculate_summary_stats(df_KL[["mlr_WT_G1_N"]])
 #  sm_WT_Q_N_KL <- calculate_summary_stats(df_KL[["mlr_WT_Q_N"]])
sm_WT_G1_SS_KL <- calculate_summary_stats(df_KL[["mlr_WT_G1_SS"]])
 sm_WT_Q_SS_KL <- calculate_summary_stats(df_KL[["mlr_WT_Q_SS"]])

print_summary_stats <- TRUE
if(base::isTRUE(print_summary_stats)) {
    # cat("\nsm_WT_G1_N_KL\n")
    # print(sm_WT_G1_N_KL)
    # cat("\nsm_WT_Q_N_KL\n")
    # print(sm_WT_Q_N_KL)
    cat("\nsm_WT_G1_SS_KL\n")
    print(sm_WT_G1_SS_KL)
    cat("\nsm_WT_Q_SS_KL\n")
    print(sm_WT_Q_SS_KL)
}

#  Calculate summary statistics for S.C.
 # sm_WT_G1_N_SC <- calculate_summary_stats(df_SC[["mlr_WT_G1_N"]])
 #  sm_WT_Q_N_SC <- calculate_summary_stats(df_SC[["mlr_WT_Q_N"]])
sm_WT_G1_SS_SC <- calculate_summary_stats(df_SC[["mlr_WT_G1_SS"]])
 sm_WT_Q_SS_SC <- calculate_summary_stats(df_SC[["mlr_WT_Q_SS"]])

print_summary_stats <- TRUE
if(base::isTRUE(print_summary_stats)) {
    # cat("\nsm_WT_G1_N_SC\n")
    # print(sm_WT_G1_N_SC)
    # cat("\nsm_WT_Q_N_SC\n")
    # print(sm_WT_Q_N_SC)
    cat("\nsm_WT_G1_SS_SC\n")
    print(sm_WT_G1_SS_SC)
    cat("\nsm_WT_Q_SS_SC\n")
    print(sm_WT_Q_SS_SC)
}


#  Draw density plots(s) ------------------------------------------------------
plot_density <- function(
    df, column, summary,
    x_low = 0, x_high = 17.5,
    col_density = "#00808075",
    col_mean = "#80008066", txt_mean = "#800080",
    col_median = "#00000066", txt_median = "#000000",
    title = paste0("Density plot, ", column),
    x_lab = "log2(TPM + 1)", y_lab = "density"
) {
    density <- ggplot(data = df, aes(x = .data[[column]])) +
        geom_density(fill = col_density, linewidth = 0) +
        xlim(c(x_low, x_high)) +
        labs(
            title = title,
            x = x_lab,
            y = y_lab
        ) +
        geom_vline(
            data = summary,
            aes(xintercept = mean),
            color = col_mean,
            linetype = "dashed",
            size = 1
        ) +
        geom_vline(
            data = summary,
            aes(xintercept = median),
            color = col_median,
            linetype = "dotted",
            size = 1
        ) +
        geom_text(
            data = summary,
            aes(x = mean, y = 0.25, label = paste("mean =", round(mean, 2))),
            color = txt_mean
        ) +
        geom_text(
            data = summary,
            aes(x = median, y = 0.20, label = paste("median =", round(median, 2))),
            color = txt_median
        ) +
        theme_slick
    
    return(density)
}


#  Plot log2(TPM + 1) densities for K.L.
dn_WT_G1_SS_KL <- plot_density(
    df = df_KL,
    column = "mlr_WT_G1_SS",
    summary = sm_WT_G1_SS_KL,
    title = "KL, mlr_WT_G1_SS"
)
dn_WT_Q_SS_KL <- plot_density(
    df = df_KL,
    column = "mlr_WT_Q_SS",
    summary = sm_WT_Q_SS_KL,
    title = "KL, mlr_WT_Q_SS"
)

#  Plot log2(TPM + 1) densities for S.C.
dn_WT_G1_SS_SC <- plot_density(
    df = df_SC,
    column = "mlr_WT_G1_SS",
    summary = sm_WT_G1_SS_SC,
    title = "SC, mlr_WT_G1_SS"
)
dn_WT_Q_SS_SC <- plot_density(
    df = df_SC,
    column = "mlr_WT_Q_SS",
    summary = sm_WT_Q_SS_SC,
    title = "SC, mlr_WT_Q_SS"
)

print_densities <- FALSE
if(base::isTRUE(print_densities)) {
    print(dn_WT_G1_SS_KL)
    print(dn_WT_Q_SS_KL)
}

print_densities <- FALSE
if(base::isTRUE(print_densities)) {
    print(dn_WT_G1_SS_SC)
    print(dn_WT_Q_SS_SC)
}

print_densities <- TRUE
if(base::isTRUE(print_densities)) {
    grid.arrange(
        dn_WT_G1_SS_KL, dn_WT_Q_SS_KL,
        dn_WT_G1_SS_SC, dn_WT_Q_SS_SC,
        nrow = 2, ncol = 2
    )
}


#  Determine mean difference, then adjust values for mean difference ----------
apply_mean_diff <- function(df, col, sm_1, sm_2) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- df_KL
        col <- "mlr_WT_G1_SS"
        sm_1 <- sm_WT_Q_SS_KL
        sm_2 <- sm_WT_G1_SS_KL
    }
    
    mean_diff <- sm_1[["mean"]] - sm_2[["mean"]]
    shifted <- df[[col]] + mean_diff
    return(shifted)
}


df_KL[["shift_WT_G1_SS"]] <- apply_mean_diff(
    df_KL, "mlr_WT_G1_SS", sm_WT_Q_SS_KL, sm_WT_G1_SS_KL
)
df_SC[["shift_WT_G1_SS"]] <- apply_mean_diff(
    df_SC, "mlr_WT_G1_SS", sm_WT_Q_SS_KL, sm_WT_G1_SS_KL
)
df_20[["shift_WT_G1_SS"]] <- apply_mean_diff(
    df_20, "mlr_WT_G1_SS", sm_WT_Q_SS_KL, sm_WT_G1_SS_KL
)

#  Plot log2(TPM + 1) spike-in mean-shifted densities
#+ ...for K.L.
sm_WT_G1_SS_KL_sh <- calculate_summary_stats(df_KL[["shift_WT_G1_SS"]])
dn_WT_G1_SS_KL_sh <- plot_density(
    df = df_KL,
    column = "shift_WT_G1_SS",
    summary = sm_WT_G1_SS_KL_sh,
    title = "KL, shift_WT_G1_SS"
)

#+ ...for S.C.
sm_WT_G1_SS_SC_sh <- calculate_summary_stats(df_SC[["shift_WT_G1_SS"]])
dn_WT_G1_SS_SC_sh <- plot_density(
    df = df_SC,
    column = "shift_WT_G1_SS",
    summary = sm_WT_G1_SS_SC_sh,
    title = "SC, shift_WT_G1_SS"
)

print_densities <- FALSE
if(base::isTRUE(print_densities)) {
    dn_WT_G1_SS_KL_sh %>% print()
    dn_WT_G1_SS_SC_sh %>% print()
}

print_densities <- TRUE
if(base::isTRUE(print_densities)) {
    grid.arrange(
        dn_WT_G1_SS_KL, dn_WT_G1_SS_KL_sh,
        dn_WT_G1_SS_SC, dn_WT_G1_SS_SC_sh,
        nrow = 2, ncol = 2
    )
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
    df = df_KL, dv = "mlr_WT_G1_SS", iv = "mlr_WT_Q_SS"
)
`lr-KL__dv-G1-sh_on_iv-Q` <- perform_linear_regression(
    df = df_KL, dv = "shift_WT_G1_SS", iv = "mlr_WT_Q_SS"
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
        round(coef(`lr-KL__dv-G1-sh_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-KL__dv-G1-sh_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
}

`lr-SC__dv-G1_on_iv-Q` <- perform_linear_regression(
    df = df_SC, dv = "mlr_WT_G1_SS", iv = "mlr_WT_Q_SS"
)
`lr-SC__dv-G1-sh_on_iv-Q` <- perform_linear_regression(
    df = df_SC, dv = "shift_WT_G1_SS", iv = "mlr_WT_Q_SS"
)

print_linear_equation <- TRUE
if(base::isTRUE(print_linear_equation)) {
    cat(
        "y =",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1_on_iv-Q`)[2], 2),
        "* x + e\n"
    )
    cat(
        "y =",
        round(coef(`lr-SC__dv-G1-sh_on_iv-Q`)[1], 2),
        "+",
        round(coef(`lr-SC__dv-G1-sh_on_iv-Q`)[2], 2),
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


df_KL[["tf_WT_G1_SS"]] <- calculate_xy_dv_values(
    lr = `lr-KL__dv-G1_on_iv-Q`,
    dv = df_KL[["mlr_WT_G1_SS"]]
)
df_SC[["tf_WT_G1_SS"]] <- calculate_xy_dv_values(
    lr = `lr-KL__dv-G1_on_iv-Q`,
    dv = df_SC[["mlr_WT_G1_SS"]]
)
df_20[["tf_WT_G1_SS"]] <- calculate_xy_dv_values(
    lr = `lr-KL__dv-G1_on_iv-Q`,
    dv = df_20[["mlr_WT_G1_SS"]]
)


#  Apply concentration-based scaling factor -----------------------------------
#+ ...to the to S. cerevisiae spike-in regression distribution values
vol_spike_Q <- 50
vol_spike_G1 <- 50
OD_Q <- 100
OD_G1 <- 12.5

vol_spike_rat <- vol_spike_Q / vol_spike_G1
OD_rat <- OD_Q / OD_G1

conc_sf <- vol_spike_rat * OD_rat
# df_SC[["conc_WT_G1_SS"]] <- df_SC[["tf_WT_G1_SS"]] + conc_sf
df_SC[["conc_WT_G1_SS"]] <- log2(2^df_SC[["tf_WT_G1_SS"]] * conc_sf)

check_scaled_values <- TRUE
if(base::isTRUE(check_scaled_values)) {
    head(df_SC[["tf_WT_G1_SS"]]) %>% print()
    head(df_SC[["conc_WT_G1_SS"]]) %>% print()
}


#  Draw scatter plot(s) -------------------------------------------------------
plot_scatter <- function(
    df, col_dv, col_iv, lr,
    color = "#00808010",
    color_reg = "#FF0000",
    draw_density = TRUE,
    x_low = 0, y_low = 0,
    x_high = 12.5, y_high = 12.5,
    title = "K. lactis transcripts"
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df <- df_KL
        col_dv <- "mlr_WT_G1_SS"
        col_iv <- "mlr_WT_Q_SS"
        lr <- `lr-KL__dv-G1_on_iv-Q`
        color = "#00808010"
        draw_density = TRUE
        x_low = -5
        y_low = -5
        x_high = 12.5
        y_high = 12.5
        title = "K. lactis transcripts"
    }
    
    scatter <- ggplot2::ggplot(
        df, aes(x = .data[[col_iv]], y = .data[[col_dv]])
    ) +
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
        labs(x = col_iv, y = col_dv, title = title) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        theme_slick
    
    return(scatter)
}


#+ ...for KL --------------------------
`scatter-KL__dv_G1_on_iv_Q` <- plot_scatter(
    df = df_KL,
    col_dv = "mlr_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr = `lr-KL__dv-G1_on_iv-Q`,
    color = "#00808010",
    title = "K. lactis transcripts"
)
`scatter-KL__dv_G1-sh_on_iv_Q` <- plot_scatter(
    df = df_KL,
    col_dv = "shift_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr = `lr-KL__dv-G1-sh_on_iv-Q`,
    color = "#8B008B10",
    title = "Spike-in mean-adjusted K. lactis transcripts"
)

`lr-KL__dv-G1-tf_on_iv-Q` <- perform_linear_regression(
    df = df_KL, dv = "tf_WT_G1_SS", iv = "mlr_WT_Q_SS"
)
`scatter-KL__dv_G1-tf_on_iv_Q` <- plot_scatter(
    df = df_KL,
    col_dv = "tf_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr = `lr-KL__dv-G1-tf_on_iv-Q`,
    color = "#185E9110",
    title = "Spike-in regression-adjusted K. lactis transcripts"
)

print_scatter_plots <- FALSE
if(base::isTRUE(print_scatter_plots)) {
    `scatter-KL__dv_G1_on_iv_Q` %>% print()
    `scatter-KL__dv_G1-sh_on_iv_Q` %>% print()
    `scatter-KL__dv_G1-tf_on_iv_Q` %>% print()
}

print_scatter_plots <- FALSE
if(base::isTRUE(print_scatter_plots)) {
    grid.arrange(
        `scatter-KL__dv_G1_on_iv_Q`,
        `scatter-KL__dv_G1-sh_on_iv_Q`,
        `scatter-KL__dv_G1-tf_on_iv_Q`,
        ncol = 3
    )
}

#+ ...for SC --------------------------
`scatter-SC__dv_G1_on_iv_Q` <- plot_scatter(
    df = df_SC,
    x_high = 20,
    y_high = 20,
    col_dv = "mlr_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr = `lr-SC__dv-G1_on_iv-Q`,
    color = "#00808010",
    title = "S. cerevisiae transcripts"
)
`scatter-SC__dv_G1-sh_on_iv_Q` <- plot_scatter(
    df = df_SC,
    x_high = 20,
    y_high = 20,
    col_dv = "shift_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr = `lr-SC__dv-G1-sh_on_iv-Q`,
    color = "#8B008B10",
    title = "Spike-in mean-adjusted S. cerevisiae transcripts"
)

`lr-SC__dv-G1-tf_on_iv-Q` <- perform_linear_regression(
    df = df_SC, dv = "tf_WT_G1_SS", iv = "mlr_WT_Q_SS"
)
`scatter-SC__dv_G1-tf_on_iv_Q` <- plot_scatter(
    df = df_SC,
    x_high = 20,
    y_high = 20,
    col_dv = "tf_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr = `lr-SC__dv-G1-tf_on_iv-Q`,
    color = "#185E9110",
    title = "Spike-in regression-adjusted S. cerevisiae transcripts"
)

print_scatter_plots <- FALSE
if(base::isTRUE(print_scatter_plots)) {
    `scatter-SC__dv_G1_on_iv_Q` %>% print()
    `scatter-SC__dv_G1-sh_on_iv_Q` %>% print()
    `scatter-SC__dv_G1-tf_on_iv_Q` %>% print()
}

print_scatter_plots <- FALSE
if(base::isTRUE(print_scatter_plots)) {
    grid.arrange(
        `scatter-SC__dv_G1_on_iv_Q`,
        `scatter-SC__dv_G1-sh_on_iv_Q`,
        `scatter-SC__dv_G1-tf_on_iv_Q`,
        ncol = 3
    )
}

print_scatter_plots <- FALSE
if(base::isTRUE(print_scatter_plots)) {
    grid.arrange(
        `scatter-KL__dv_G1_on_iv_Q`,
        `scatter-KL__dv_G1-sh_on_iv_Q`,
        `scatter-KL__dv_G1-tf_on_iv_Q`,
        `scatter-SC__dv_G1_on_iv_Q`,
        `scatter-SC__dv_G1-sh_on_iv_Q`,
        `scatter-SC__dv_G1-tf_on_iv_Q`,
        ncol = 3
    )
}


#  Plot combination of S.C. and K.L. dists., adj. and unadj. ------------------
plot_scatter_combined <- function(
    df_KL, df_SC, df_20S,
    col_dv, col_iv,
    lr_KL, lr_SC,
    color_KL = "#00808010",
    color_SC = "#185E9110",
    color_20 = "#00000050",
    color_reg = "#FF0000",
    draw_density = TRUE,
    plot_20S = FALSE,
    scale = FALSE, sf = 8,
    x_low = 0, y_low = 0,
    x_high = 20, y_high = 20,
    x_label = NULL, y_label = NULL,
    title = "Unadjusted transcripts"
) {
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df_KL <- df_KL
        df_SC <- df_SC
        df_20 <- df_20
        col_dv <- "tf_WT_G1_SS"
        col_iv <- "mlr_WT_Q_SS"
        lr_KL <- `lr-KL__dv-G1-tf_on_iv-Q`
        lr_SC <- `lr-SC__dv-G1-tf_on_iv-Q`
        color_KL <- "#00808010"
        color_SC <- "#185E9110"
        color_20 <- "#00000050"
        draw_density <- TRUE
        plot_20S <- TRUE
        scale <- TRUE
        sf <- 8
        x_low <- 0
        y_low <- 0
        x_high <- 15
        y_high <- 175
        title <- "Spike-in regression-adjusted,\nconcentration-scaled transcripts"
    }
    
    scatter_KL <- ggplot2::ggplot(
        df_KL, aes(x = .data[[col_iv]], y = .data[[col_dv]])
    ) +
        geom_point(size = 2.5, col = color_KL) +
        { if(base::isTRUE(draw_density)) geom_density_2d(color = "#FFFFFF") } +
        geom_abline(
            intercept = 0,
            slope = 1,
            color = "black",
            linetype = "solid"
        ) +
        geom_abline(
            intercept = coef(lr_KL)[1],
            slope = coef(lr_KL)[2],
            color = "red",
            linetype = "dashed"
        ) +
        labs(
            x = { 
                if(base::isTRUE(is.null(x_label))) {
                    col_iv
                } else {
                    x_label
                }
            },
            y = {
                if(base::isTRUE(is.null(y_label))) {
                    col_dv
                } else {
                    y_label
                }
            },
            title = title
        ) +
        xlim(c(x_low, x_high)) +
        ylim(c(y_low, y_high)) +
        theme_slick
    if(base::isTRUE(debug)) print(scatter_KL)
    
    #  If applicable, initialize variables necessary for working with scaled
    #+ (arithmetically y-shifted) data
    if(base::isTRUE(scale)) {
        col_conc <- colnames(df_SC)[
            stringr::str_detect(colnames(df_SC), "conc_")
        ]
    }
    if(base::isTRUE(scale)) {
        lr_scaled <- perform_linear_regression(
            df = df_SC, dv = col_conc, iv = col_iv
        )
    }
    
    scatter_comb <- scatter_KL +
        geom_point(
            df_SC,
            mapping = { 
                if(base::isFALSE(scale)) {
                    aes(x = .data[[col_iv]], y = .data[[col_dv]])
                } else if(base::isTRUE(scale)) {
                    aes(x = .data[[col_iv]], y = .data[[col_conc]])
                }
            },
            size = 2.5,
            col = color_SC
        ) +
        { 
            if(base::isTRUE(draw_density)) {
                geom_density_2d(
                    df_SC,
                    mapping = { 
                        if(base::isFALSE(scale)) {
                            aes(x = .data[[col_iv]], y = .data[[col_dv]])
                        } else if(base::isTRUE(scale)) {
                            aes(x = .data[[col_iv]], y = .data[[col_conc]])
                        }
                    },
                    color = "#FFFFFF"
                )
            }
        } +
        geom_abline(
            intercept = 0,
            slope = 1,
            color = "black",
            linetype = "solid"
        ) +
        {
            if(base::isFALSE(scale)) {
                geom_abline(
                    intercept = coef(lr_SC)[1],
                    slope = coef(lr_SC)[2],
                    color = "red",
                    linetype = "dashed"
                )
            } else if(base::isTRUE(scale)) {
                geom_abline(
                    intercept = coef(lr_scaled)[1],
                    slope = coef(lr_scaled)[2],
                    color = "red",
                    linetype = "dashed"
                )
            }
        } +
        { 
            if(base::isTRUE(plot_20S)) {
                geom_point(
                    df_20,
                    mapping = aes(x = .data[[col_iv]], y = .data[[col_dv]]),
                    size = 2.5,
                    col = color_20,
                    shape = 15
                )
            }
        } +
        { 
            if(base::isTRUE(is.null(y_label))) {
                if(base::isTRUE(scale)) {
                    ylab(col_conc)
                } else {
                    ylab(col_dv)
                }
            } else {
                ylab(y_label)
            }
        }
    if(base::isTRUE(debug)) print(scatter_comb)

    return(scatter_comb)
}


`scatter-comb__dv_G1_on_iv_Q` <- plot_scatter_combined(
    df_KL = df_KL,
    df_SC = df_SC,
    df_20S = df_20,
    col_dv = "mlr_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr_KL = `lr-KL__dv-G1_on_iv-Q`,
    lr_SC = `lr-SC__dv-G1_on_iv-Q`,
    draw_density = TRUE,
    plot_20S = FALSE,
    title = "Unadjusted transcripts\n",
    x_label = "WT Q SS:\nlog2(TPM + 1)",
    y_label = "WT G1 SS: log2(TPM + 1)"
)
`scatter-comb__dv_G1-sh_on_iv_Q` <- plot_scatter_combined(
    df_KL = df_KL,
    df_SC = df_SC,
    df_20S = df_20,
    col_dv = "shift_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr_KL = `lr-KL__dv-G1-sh_on_iv-Q`,
    lr_SC = `lr-SC__dv-G1-sh_on_iv-Q`,
    draw_density = TRUE,
    plot_20S = FALSE,
    title = "Spike-in mean-adjusted transcripts\n",
    x_label = "WT Q SS:\nlog2(TPM + 1)",
    y_label = "WT G1 SS: log2(TPM + 1)"
)
`scatter-comb__dv_G1-tf_on_iv_Q` <- plot_scatter_combined(
    df_KL = df_KL,
    df_SC = df_SC,
    df_20S = df_20,
    col_dv = "tf_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr_KL = `lr-KL__dv-G1-tf_on_iv-Q`,
    lr_SC = `lr-SC__dv-G1-tf_on_iv-Q`,
    draw_density = TRUE,
    plot_20S = FALSE,
    title = "Spike-in regression-adjusted\ntranscripts",
    x_label = "WT Q SS:\nlog2(TPM + 1)",
    y_label = "WT G1 SS: log2(TPM + 1)"
)
`scatter-comb__dv_G1-tf-sf_on_iv_Q` <- plot_scatter_combined(
    df_KL = df_KL,
    df_SC = df_SC,
    df_20S = df_20,
    col_dv = "tf_WT_G1_SS",
    col_iv = "mlr_WT_Q_SS",
    lr_KL = `lr-KL__dv-G1-tf_on_iv-Q`,
    lr_SC = `lr-SC__dv-G1-tf_on_iv-Q`,
    draw_density = TRUE,
    plot_20S = FALSE,
    scale = TRUE,
    sf = conc_sf,
    x_high = 20,
    y_high = 20,
    title = "Spike-in regression-adjusted,\nconcentration-scaled transcripts",
    x_label = "WT Q SS:\nlog2(TPM + 1)",
    y_label = "WT G1 SS: log2(TPM + 1)"
)

print_scatter_plots <- TRUE
if(base::isTRUE(print_scatter_plots)) {
    grid.arrange(
        `scatter-comb__dv_G1_on_iv_Q`,
        # `scatter-comb__dv_G1-sh_on_iv_Q`,
        `scatter-comb__dv_G1-tf_on_iv_Q`,
        `scatter-comb__dv_G1-tf-sf_on_iv_Q`,
        # ncol = 4
        ncol = 3
    )
}


#  Calculate fold change ------------------------------------------------------
mean(df_SC[["conc_WT_G1_SS"]])
mean(df_SC[["mlr_WT_Q_SS"]])

2^mean(df_SC[["conc_WT_G1_SS"]]) / 2^mean(df_SC[["mlr_WT_Q_SS"]])
