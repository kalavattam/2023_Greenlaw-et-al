#!/usr/bin/env Rscript

#  rough-draft_evaluate-categories_expression.R
#  KA


#  Get situated ===============================================================
suppressMessages(library(ggplot2))
suppressMessages(library(ggpubr))
suppressMessages(library(PCAtools))
suppressMessages(library(rstatix))
suppressMessages(library(tidyverse))
suppressMessages(library(treemap))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)

if(stringr::str_detect(getwd(), "kalavattam")) {
    p_local <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_local <- "/Users/kalavatt/projects-etc"
}
p_wd <- "2022_transcriptome-construction/results/2023-0215"

setwd(paste(p_local, p_wd, sep = "/"))
getwd()

rm(p_local, p_wd)


#  Initialize functions -------------------------------------------------------
read_in_counts_matrix <- function(x) {
    # ...
    #
    # :param x: counts matrix from htseq-count
    # :return y: counts matrix as tibble
    y <- readr::read_tsv(x, show_col_types = FALSE) %>% 
        dplyr::rename(gene_id = ...1)
    return(y)
}


filter_process_counts_matrix <- function(
    counts_matrix,
    named_character_vector
) {
    # ...
    #
    # :param counts_matrix: counts matrix from htseq-count
    # :param named_character_vector: ...
    # :return df: counts matrix as tibble
    
    #  Test
    # counts_matrix <- t_cm
    # named_character_vector <- col_cor
    
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


`%notin%` <- Negate(`%in%`)


derive_summary_metrics <- function(uni_multi, summary, counts) {
    #  Tests
    # uni_multi <- uni_multi_etc
    # summary <- underscore
    # counts <- t_cm
    
    #  Step 1: Get multimappers associated with "Mito-KL-20S"
    `Mito-KL-20S_multi` <- uni_multi[
        stringr::str_detect(uni_multi[["sample"]], "Mito-KL-20S_multi"),
        2:ncol(uni_multi)
    ]
    
    #  Step 2: Get unimappers associated with "Mito-KL-20S"
    `Mito-KL-20S_uni` <- uni_multi[
        stringr::str_detect(uni_multi[["sample"]], "Mito-KL-20S_uni"),
        2:ncol(uni_multi)
    ]
    
    #  Step 3: Get unimappers associated with "SC-I-XVI"
    `SC-I-XVI_uni` <- uni_multi[
        stringr::str_detect(uni_multi[["sample"]], "SC-I-XVI_uni"),
        2:ncol(uni_multi)
    ]
    
    #  Step 4:
    #+ - Isolate and define `__alignment_not_unique`
    #+ - Define and calculate `__alignment_not_unique_I-XVI` by subtracting
    #+   `Mito-KL-20S_multi` from `__alignment_not_unique`
    `__alignment_not_unique` <- summary[
        stringr::str_detect(summary[["gene_id"]], "__alignment_not_unique"),
        2:ncol(summary)
    ] %>%
        tibble::as_tibble()
    `__alignment_not_unique_I-XVI` <-
        `__alignment_not_unique` - `Mito-KL-20S_multi`
    `__alignment_not_unique_I-XVI` <- `__alignment_not_unique_I-XVI` %>%
        tibble::as_tibble()
    
    #  Step 5:
    #+ - Isolate and define `__no_feature`
    #+ - Define and calculate `__no_feature_I-XVI` by subtracting
    #+   `Mito-KL-20S_uni` from "`__no_feature`"
    `__no_feature` <- summary[
        stringr::str_detect(summary[["gene_id"]], "__no_feature"),
        2:ncol(summary)
    ]
    `__no_feature_I-XVI` <- `__no_feature` - `Mito-KL-20S_uni`
    `__no_feature_I-XVI` <- `__no_feature_I-XVI` %>% tibble::as_tibble()
    
    
    #  Step 6: Define `__sum_I-XVI` by summing the following:
    #+    - "`__no_feature_I-XVI`"
    #+    - "`__ambiguous`"
    #+    - "`__alignment_not_unique_I-XVI`"
    #+    - "`__valid_counts`"
    `__ambiguous` <- summary[
        stringr::str_detect(summary[["gene_id"]], "__ambiguous"),
        2:ncol(summary)
    ]
    `__valid_counts` <- sapply(counts[, -1], sum) %>%
        t() %>%
        tibble::as_tibble() 
    
    `__sum_I-XVI` <- `__no_feature_I-XVI` +
        `__ambiguous` +
        `__alignment_not_unique_I-XVI` +
        `__valid_counts`
    `__sum_I-XVI` <- `__sum_I-XVI` %>% tibble::as_tibble()
    
    #  Step 7: Tally all counts associated with "SC-I-XVI" (`SC-I-XVI_all`)
    `SC-I-XVI_all` <- 
        uni_multi[
            stringr::str_detect(uni_multi[["sample"]], "SC-I-XVI_all"),
            2:ncol(uni_multi)
        ]
    `SC-I-XVI_all` <- `SC-I-XVI_all` %>% tibble::as_tibble()
    
    #  Step 8: Check that `__sum_I-XVI` and `SC-I-XVI_all` are equal; if not,
    #+ then there is a problem and troubleshooting needs to occur
    identical(
        as.numeric(`__sum_I-XVI`[, 2:ncol(`__sum_I-XVI`)]),
        as.numeric(`SC-I-XVI_all`[, 2:ncol(`SC-I-XVI_all`)])
    )  # [1] TRUE
    
    #  Step 9: Give all of the new tibbles appropriate "gene_id" columns
    `Mito-KL-20S_multi` <- `Mito-KL-20S_multi` %>%
        dplyr::mutate(gene_id = "Mito-KL-20S_multi") %>%
        dplyr::select(gene_id, dplyr::everything())
    `Mito-KL-20S_uni` <- `Mito-KL-20S_uni` %>%
        dplyr::mutate(gene_id = "Mito-KL-20S_uni") %>%
        dplyr::select(gene_id, dplyr::everything())
    `SC-I-XVI_uni` <- `SC-I-XVI_uni` %>%
        dplyr::mutate(gene_id = "SC-I-XVI_uni") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__alignment_not_unique` <- `__alignment_not_unique` %>%
        dplyr::mutate(gene_id = "__alignment_not_unique") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__alignment_not_unique_I-XVI` <- `__alignment_not_unique_I-XVI` %>%
        dplyr::mutate(gene_id = "__alignment_not_unique_I-XVI") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__no_feature` <- `__no_feature` %>%
        dplyr::mutate(gene_id = "__no_feature") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__no_feature_I-XVI` <- `__no_feature_I-XVI` %>%
        tibble::as_tibble() %>%
        dplyr::mutate(gene_id = "__no_feature_I-XVI") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__ambiguous` <- `__ambiguous` %>%
        dplyr::mutate(gene_id = "__ambiguous") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__valid_counts` <- `__valid_counts` %>%
        dplyr::mutate(gene_id = "__valid_counts") %>%
        dplyr::select(gene_id, dplyr::everything())
    `__sum_I-XVI` <- `__sum_I-XVI` %>%
        dplyr::mutate(gene_id = "__sum_I-XVI") %>%
        dplyr::select(gene_id, dplyr::everything())
    `SC-I-XVI_all` <- `SC-I-XVI_all` %>%
        dplyr::mutate(gene_id = "SC-I-XVI_all") %>%
        dplyr::select(gene_id, dplyr::everything())
    
    #  Step 10: Create a tibble of "thorough" summary metrics
    summary_thorough <- dplyr::bind_rows(
        `Mito-KL-20S_multi`, `Mito-KL-20S_uni`, `SC-I-XVI_uni`,
        `__alignment_not_unique`, `__alignment_not_unique_I-XVI`,
        `__no_feature`, `__no_feature_I-XVI`, `__ambiguous`, `__valid_counts`,
        `__sum_I-XVI`, `SC-I-XVI_all`
    )
    
    #  Step 11: Create a tibble of "relevant" summary metrics
    exclude <- c(
        "__no_feature", "__too_low_aQual", "__not_aligned",
        "__alignment_not_unique", "sample_total", "Mito-KL-20S_all",
        "Mito-KL-20S_uni", "Mito-KL-20S_multi", "SC-I-XVI_all", "SC-I-XVI_uni",
        "SC-I-XVI_multi", "__sum_I-XVI"
    )
    summary_relevant <- summary_thorough[
        summary_thorough$gene_id %notin% exclude, 
    ]
    
    #  Step 12: Return the "thorough" and "relevant" tibbles
    results_list <- list()
    results_list[["summary_thorough"]] <- summary_thorough
    results_list[["summary_relevant"]] <- summary_relevant
    
    return(results_list)
}


#  Set up custom ggplot2 plot themes ------------------------------------------
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

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")


# Load and process gtf, counts matrix, and summary metrics ====================
# Load gtf file of interest ---------------------------------------------------
# ...which consists of collapsed/merged pa-ncRNAs and "processed" features
p_gtf <- "outfiles_gtf-gff3/representation"

# f_gtf <- "Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf"
f_gtf <- "Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf"
# f_gtf <- "Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf"
# f_gtf <- "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf"  #DONE #IMPORTANT #FUTURE
# f_gtf <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"  #TODO #TOCOMPLETE

# dir.exists(p_gtf)
# file.exists(paste(p_gtf, f_gtf, sep = "/"))

t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
    rtracklayer::import() %>%
    tibble::as_tibble() %>%
    dplyr::arrange(seqnames, start) %>%
    dplyr::select(-c(width, score, phase))
if(base::isFALSE(f_gtf == "Greenlaw-et-al_representative-non-coding-transcriptome.gtf")) {
    t_gtf <- t_gtf %>% dplyr::rename(category = type.1)
}
    
t_gtf[t_gtf == "NA"] <- NA_character_
# t_gtf

rm(p_gtf)
# rm(p_gtf, f_gtf)


# Load counts matrix file of interest -----------------------------------------
# ...which consists of collapsed/merged pa-ncRNAs and "processed" features
p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"

if(f_gtf == "Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf") {
    f_cm <- "representative-coding-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
    # f_cm <- "representative-coding-pa-ncRNA-transcriptome.hc-strd-eq.union-fraction.tsv"
} else if(f_gtf == "Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf") {
    f_cm <- "representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
    # f_cm <- "representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-fraction.tsv"
} else if(f_gtf == "Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf") {
    f_cm <- "representative-coding-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
} else if(f_gtf == "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf") { #DONE
    f_cm <- "non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv"  #TODO #IMPORTANT
} else if(f_gtf == "Greenlaw-et-al_representative-non-coding-transcriptome.gtf") {
    f_cm <- "representative-non-coding-transcriptome.hc-strd-eq.tsv"
}

# dir.exists(p_cm)
# file.exists(paste(p_cm, f_cm, sep = "/"))

t_cm <- read_in_counts_matrix(paste(p_cm, f_cm, sep = "/"))
if(base::isFALSE(nrow(unique(t_cm[1])) == nrow(t_cm))) {
    stop(paste(
        "There are non-unique elements in the \"gene_id\" column (i.e., the",
        "feature name vector). This will result in complications when running",
        "subsequent code/analyses. Stopping the script."
    ))
}

rm(p_cm, f_cm)


#  Clean up the tibble of counts ----------------------------------------------
#  Clean up, correct, and abbreviate sample names
colnames(t_cm) <- colnames(t_cm) %>%
    gsub("bams_renamed/UT_prim_UMI/", "", .) %>%
    gsub("\\.UT_prim_UMI\\.bam", "", .)
colnames(t_cm)

col_cor <- setNames(  #DEKHO
    c(
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1", 
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1", 
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1",  #EXCLUDE
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1", 
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1", 
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1",  #EXCLUDE
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1", 
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1", 
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1", 
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1", 
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1", 
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1", 
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1", 
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1", 
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1", 
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1", 
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1", 
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1", 
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1", 
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1", 
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1", 
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",  #FIXME ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",  #FIXME ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",  #FIXME ∆ tech1 → tech2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1", 
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1", 
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1", 
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
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",  #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",  #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1", 
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1", 
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1", 
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1", 
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1", 
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",  #FIXME ∆ tech1 → tech2
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",  #FIXME ∆ tech1 → tech2
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1", 
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1", 
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1", 
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1", 
        "WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1",  #FIXME Duplicated #1
        "WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1",  #FIXME Duplicated #2
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1", 
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",  #FIXME Duplicated #1
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1", 
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"  #FIXME Duplicated #2
    ),
    c(
        "n3d_Q_N_rep1_tech1", 
        "n3d_Q_N_rep2_tech1", 
        "n3d_Q_N_rep3_tech1",  #EXCLUDE
        "n3d_Q_SS_rep1_tech1", 
        "n3d_Q_SS_rep2_tech1", 
        "n3d_Q_SS_rep3_tech1",  #EXCLUDE
        "od_Q_N_rep1_tech1", 
        "od_Q_N_rep2_tech1", 
        "od_Q_SS_rep1_tech1", 
        "od_Q_SS_rep2_tech1", 
        "r1n_Q_N_rep1_tech1", 
        "r1n_Q_N_rep2_tech1", 
        "r1n_Q_SS_rep1_tech1", 
        "r1n_Q_SS_rep2_tech1", 
        "r6n_DSm2_SS_rep1_tech1", 
        "r6n_DSm2_SS_rep2_tech1", 
        "r6n_DSp24_SS_rep1_tech1", 
        "r6n_DSp24_SS_rep2_tech1", 
        "r6n_DSp2_SS_rep1_tech1", 
        "r6n_DSp2_SS_rep2_tech1", 
        "r6n_DSp48_SS_rep1_tech1", 
        "r6n_DSp48_SS_rep2_tech2",  #DONE
        "r6n_G1_SS_rep1_tech2",  #DONE
        "r6n_G1_SS_rep2_tech2",  #DONE
        "r6n_Q_N_rep1_tech1", 
        "r6n_Q_N_rep2_tech1", 
        "r6n_Q_SS_rep1_tech1",  #OK
        "r6n_Q_SS_rep1_tech2",  #OK
        "r6n_Q_SS_rep2_tech1", 
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
        "WT_DSp48_SS_rep1_tech1",  #OK
        "WT_DSp48_SS_rep1_tech2",  #OK
        "WT_DSp48_SS_rep2_tech1", 
        "WTovn_G1_N_rep1_tech1", 
        "WTovn_G1_N_rep2_tech1", 
        "WTovn_G1_SS_rep1_tech1", 
        "WTovn_G1_SS_rep2_tech1", 
        "WT_G1_SS_rep1_tech2",  #DONE
        "WT_G1_SS_rep2_tech2",  #DONE
        "WTovn_Q_N_rep1_tech1", 
        "WTovn_Q_N_rep2_tech1", 
        "WTovn_Q_SS_rep1_tech1", 
        "WTovn_Q_SS_rep2_tech1", 
        "WTtest_Q_N_rep2_tech1",  #DONE
        "WTtest_Q_SS_rep2_tech1",  #DONE
        "WT_Q_N_rep1_tech1", 
        "WT_Q_N_rep2_tech1",  #DONE
        "WT_Q_SS_rep1_tech1", 
        "WT_Q_SS_rep2_tech1"  #DONE
    )
)

run <- FALSE
if(base::isTRUE(run)) {
    t_cm.bak <- t_cm
    # t_cm <- t_cm.bak
}
t_cm <- filter_process_counts_matrix(t_cm, col_cor)


#  Extract htseq-count summary metrics from t_cm ------------------------------
#  They are at the end of the matrices and have names that begin with two
#+ underscore characters
underscore <- t_cm[stringr::str_detect(t_cm$gene_id, "^__[a-zA-Z0-9_]*$"), ]


#  Exclude htseq-count summary metrics from t_cm ------------------------------
t_cm <- t_cm[!stringr::str_detect(t_cm$gene_id, "^__[a-zA-Z0-9_]*$"), ]

run <- FALSE
if(base::isTRUE(run)) {
    t_cm %>% tail(10)
}


#  Read in, process metrics from work_calculate_uni-multimappers-etc.md -------
p_uni_multi_etc <- "outfiles_htseq-count"
f_uni_multi_etc <- "calculate_uni-multimappers-etc.UT_prim_UMI.txt"
uni_multi_etc <- readr::read_tsv(
    paste(p_uni_multi_etc, f_uni_multi_etc, sep = "/"),
    show_col_types = FALSE
)

rm(f_uni_multi_etc, p_uni_multi_etc)


#  Clean up the tibble of uni_multi_etc counts --------------------------------
#  Clean up, correct, and abbreviate sample names
run <- FALSE
if(base::isTRUE(run)) {
    uni_multi_etc.bak <- uni_multi_etc
    # uni_multi_etc <- uni_multi_etc.bak
}
uni_multi_etc$sample[match(col_cor, uni_multi_etc$sample)] <- names(col_cor)

#  Transpose the dataframe, converting row #1 to column names
uni_multi_etc <- uni_multi_etc %>%
    t() %>%
    as.data.frame() %>%
    tibble::rownames_to_column() %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    `colnames<-`(.[1, ]) %>%
    .[-1,]

#  Convert counts from type character to type numeric
uni_multi_etc[, 2:length(uni_multi_etc)] <- tibble::as_tibble(sapply(
    uni_multi_etc[, 2:length(uni_multi_etc)], as.numeric
))


#  Generate tibbles of thorough and relevant summary metrics ------------------
summaries <- derive_summary_metrics(uni_multi_etc, underscore, t_cm)
summary_thorough <- summaries$summary_thorough
summary_relevant <- summaries$summary_relevant

rm(summaries)


#  Associate the counts-matrix features with appropriate gtf metadata ---------
if(base::isFALSE(f_gtf == "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf")) {
    t_full <- dplyr::full_join(
        t_gtf[, c(1:4, 7, 9, 10)],
        t_cm,
        by = "gene_id"
    )
} else {
    t_full <- dplyr::full_join(
        t_gtf[, c(1:4, 14, 9, 7)] %>%
            dplyr::rename(
                "original" = "gene_id",
                "gene_id" = "complete"
            ),
        t_cm,
        by = "gene_id"
    )
}


#  Row-bind tibbles t_full and summary_relevant -------------------------------
t_full <- dplyr::bind_rows(t_full, summary_relevant)

#  Checks
# nrow(t_full)
# tail(t_full)
# tail(t_full[, -c(1:7)])
# tail(t_full[-c((nrow(t_full) - 3):nrow(t_full)), -c(1:7)])


#  Check: Do sample-wise tallies equal __valid_counts? ------------------------
test_1 <- 
    sapply(
        t_full[-c((nrow(t_full) - 3):nrow(t_full)), -c(1:7)], sum
    ) %>%
    t() %>%
    tibble::as_tibble() 

test_2 <-
    summary_relevant[
        stringr::str_detect(summary_relevant$gene_id, "valid"), 
    ][
        , 2:ncol(summary_relevant)
    ]

if(base::isFALSE(identical(test_1, test_2))) {
    stop(paste(
        "Sample-wise tallies do not equal __valid_counts. Stopping the",
        "script."
    ))
} 

rm(test_1, test_2)


#  Plot category proportions for the Ovation samples ==========================
#  Isolate categories and relevant samples, then process them -----------------
tmp <- t_full[-nrow(t_full), -c(1:5, 7)]  #TODO May need to be adapted for "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf", "non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv"

# samples <- "ovation"  #ARGUMENT
samples <- "n3d_od"  #ARGUMENT
if(samples == "ovation") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "ovn")]
} else if(samples == "n3d_od") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "n3d|od")] %>%
        dplyr::select(-dplyr::contains("rep3"))
}
t_rel <- dplyr::bind_cols(tmp[, 1], tmp_samples)

rm(tmp, tmp_samples)

t_rel[(nrow(t_rel) - 2), 1] <- "multimapper"
t_rel[(nrow(t_rel) - 1), 1] <- "no feature"
t_rel[nrow(t_rel), 1] <- "ambiguous"
if(base::isTRUE(colnames(t_rel)[1] != "category")) {
    colnames(t_rel)[1] <- "category"
}
# tail(t_rel)
# head(t_rel)

#  Rename category "PG" to "pseudogene" (if applicable)
t_rel$category[stringr::str_detect(t_rel$category, "PG")] <- "pseudogene"

#  Exclude "not unique" alignments from plots
# t_rel <- t_rel %>% dplyr::slice(-(nrow(.) - 2))

#  Further clean up the column names
if(samples %in% c("ovation", "n3d_od")) {
    colnames(t_rel) <- colnames(t_rel) %>%
        stringr::str_remove("ovn") %>%
        stringr::str_remove("_tech1")
}

if(samples == "ovation") {
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_WT_G1_N_rep1 = sum(WT_G1_N_rep1),
            sum_WT_G1_N_rep2 = sum(WT_G1_N_rep2),
            sum_WT_G1_SS_rep1 = sum(WT_G1_SS_rep1),
            sum_WT_G1_SS_rep2 = sum(WT_G1_SS_rep2),
            sum_WT_Q_N_rep1 = sum(WT_Q_N_rep1),
            sum_WT_Q_N_rep2 = sum(WT_Q_N_rep2),
            sum_WT_Q_SS_rep1 = sum(WT_Q_SS_rep1),
            sum_WT_Q_SS_rep2 = sum(WT_Q_SS_rep2),
            number_of_features = dplyr::n()
        )
} else if(samples == "n3d_od") {
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_od_Q_N_rep1 = sum(od_Q_N_rep1),
            sum_od_Q_N_rep2 = sum(od_Q_N_rep2),
            sum_od_Q_SS_rep1 = sum(od_Q_SS_rep1),
            sum_od_Q_SS_rep2 = sum(od_Q_SS_rep2),
            sum_n3d_Q_N_rep1 = sum(n3d_Q_N_rep1),
            sum_n3d_Q_N_rep2 = sum(n3d_Q_N_rep2),
            sum_n3d_Q_SS_rep1 = sum(n3d_Q_SS_rep1),
            sum_n3d_Q_SS_rep2 = sum(n3d_Q_SS_rep2),
            number_of_features = dplyr::n()
        )
}


#  Order the categories alphabetically without respect to case, and exclude
#+ the "multimapper (excluded)" and "pseudogene" categories
if(samples %in% c("ovation", "n3d_od")) {
    t_rel_summarize <- t_rel_summarize %>%
        dplyr::arrange(tolower(category)) %>%
        dplyr::filter(!stringr::str_detect(
            category, "^multimapper*"
        )) %>%
        dplyr::filter(!stringr::str_detect(
            category, "^pseudogene"
        ))
}

#  For "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf" and
#+ "Greenlaw-et-al_representative-non-coding-transcriptome.gtf" counts, place
#+ "no feature" first
if(base::isTRUE(
    f_gtf == "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf" |
    f_gtf == "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
)) {
    t_rel_summarize <- t_rel_summarize %>%
        dplyr::arrange(category != "no feature")
}


#  Assign NA to "number of features" for the summary-value categories
t_rel_summarize$number_of_features <- ifelse(
    t_rel_summarize$category %in% c("no feature", "ambiguous"),
    NA_integer_,
    t_rel_summarize$number_of_features
)

#  Remove unnecessary string "sum_WT_" from the column names
if(samples == "ovation") {
    colnames(t_rel_summarize) <- colnames(t_rel_summarize) %>%
        stringr::str_remove("sum_WT_")
} else if(samples == "n3d_od") {
    colnames(t_rel_summarize) <- colnames(t_rel_summarize) %>%
        stringr::str_remove("sum_")
}

#  Test the piping of the dataframe
# t_rel_summarize %>%
#     dplyr::select(-number_of_features) %>%
#     tidyr::pivot_longer(cols = c(
#         G1_N_rep1, G1_N_rep2, G1_SS_rep1, G1_SS_rep2,
#         Q_N_rep1, Q_N_rep2, Q_SS_rep1, Q_SS_rep2
#     )) %>%
#     dplyr::rename(sample = name, counts = value)


#  Plot per-replicate counts proportions --------------------------------------
# t_rel_summarize.bak <- t_rel_summarize
t_rel_summarize$category <- t_rel_summarize$category %>% as_factor()

# t_rel_summarize %>%
#     tidyr::pivot_longer(cols = c(
#         G1_N_rep1, G1_N_rep2, G1_SS_rep1, G1_SS_rep2,
#         Q_N_rep1, Q_N_rep2, Q_SS_rep1, Q_SS_rep2
#     )) %>%
#     dplyr::rename(samples = name, counts = value) %>%
#     ggplot(aes(fill = category, y = counts, x = samples)) +
#     geom_bar(position = "fill", stat = "identity") +
#     scale_fill_manual(
#         values = length(t_rel_summarize$category) %>%
#             viridisLite::viridis()
#     ) +
#     theme_slick +
#     # theme_slick_no_legend +
#     scale_x_discrete(guide = guide_axis(angle = 45))
# 
# t_rel_summarize %>%
#     tidyr::pivot_longer(cols = c(
#         G1_N_rep1, G1_N_rep2, G1_SS_rep1, G1_SS_rep2,
#         Q_N_rep1, Q_N_rep2, Q_SS_rep1, Q_SS_rep2
#     )) %>%
#     dplyr::rename(samples = name, counts = value) %>%
#     ggplot(aes(fill = category, y = counts, x = samples)) +
#     geom_bar(position = "fill", stat = "identity") +
#     theme_slick +
#     # theme_slick_no_legend +
#     scale_x_discrete(guide = guide_axis(angle = 45))

pivot_on_columns <- function(
    tbl,
    vec_col,
    rename_n = "samples",
    rename_v = "counts"
) {
    # ...
    #
    # :param tbl: tibble/dataframe
    # :param vec_col: a vector of column names to long-pivot on
    # :param rename_n: what to rename new column "name"
    # :param rename_v: what to rename new column "value"
    
    # #  Test
    # tbl <- summary
    # vec_col <- col_piv
    # rename_n <- "samples"
    # rename_v <- "counts"
    # # rm(tbl, vec_col, rename_n, rename_v)
    
    if(length(vec_col) <= 1) {
        stop("Vector of column names must be greater than 1")
    } else if(isFALSE(any(vec_col %in% colnames(tbl)))) {
        stop("No column-name elements match tibble/dataframe column names")
    }
    tbl <- tbl %>%
        tidyr::pivot_longer(cols = vec_col) %>%
        dplyr::rename(
            !! dplyr::quo_name(rename_n) := name,
            !! dplyr::quo_name(rename_v) := value
        )
    
    return(tbl)
}


`plot-rep-prop_by-sample_stacked` <- function(tbl) {
    # ...
    # :param tbl: Pivoted summary tibble
    # :return plot: ...
    plot <- tbl %>%
        ggplot(aes(x = samples, y = counts, fill = category)) +
        geom_bar(position = "fill", stat = "identity") +
        theme_slick +
        ggpubr::rotate_x_text(45) +
        ggtitle(
            "Sample-wise proportions of counts",
            subtitle = "Stacked"
        )
    return(plot)
}


`plot-rep-prop_by-category_stacked` <- function(tbl) {
    # ...
    # :param tbl: Pivoted summary tibble
    # :return plot: ...
    plot <- tbl %>%
        ggplot(aes(x = category, y = counts, fill = samples)) +
            geom_bar(position = "fill", stat = "identity") +
            theme_slick +
            ggpubr::rotate_x_text(45) +
            ggtitle(
                "Category-wise proportions of counts",
                subtitle = "Stacked"
            )
    return(plot)
}

prop_summarize <- sweep(
    t_rel_summarize[, 2:9],
    2,
    colSums(t_rel_summarize[, 2:9]),
    `/`
) %>%
dplyr::mutate(
    category = t_rel_summarize$category,
    number_of_features = t_rel_summarize$number_of_features
) %>%
dplyr::relocate(category)

if(samples == "ovation") {
    col_piv <- c(
        "G1_N_rep1", "G1_N_rep2", "G1_SS_rep1", "G1_SS_rep2",
        "Q_N_rep1", "Q_N_rep2", "Q_SS_rep1", "Q_SS_rep2"
    )
} else if(samples == "n3d_od") {
    col_piv <- colnames(t_rel_summarize)[-c(1, 10)]
}

`sample-by-category_pivoted` <- prop_summarize[, 1:9] %>%
    pivot_on_columns(col_piv) %>%
    dplyr::mutate(
        samples = factor(stringr::str_remove(samples, "_rep1|_rep2"))
    )

`sample-by-category_stats` <- `sample-by-category_pivoted` %>%
    dplyr::group_by(category) %>%
    rstatix::t_test(
        counts ~ samples,
        alternative = "two.sided",
        p.adjust.method = "BH",
        var.equal = TRUE
    ) %>%
    dplyr::mutate(
        p.signif = ifelse(
            p <= 0.05 & p > 0.01,
            "*",
            ifelse(
                p <= 0.01 & p > 0.001,
                "**",
                ifelse(
                    p <= 0.001 & p > 0.0001,
                    "***",
                    ifelse(
                        p <= 0.0001 & p > 0.00001,
                        "****",
                        "ns"
                    )
                )
            )
        )
    ) %>%
    dplyr::relocate(p.signif, .after = p)

#  Checks
# `sample-by-category_pivoted`
# `sample-by-category_stats`

if(samples == "ovation") {
    zoom <- 0.30
} else if(samples == "n3d_od") {
    zoom <- 0.55
}

#  Draw mean proportional bar plots with error bars
run <- FALSE
if(base::isTRUE(run)) {
    `prop-plot_w-error_full` <- `sample-by-category_pivoted` %>%
        ggpubr::ggbarplot(
            x = "samples",
            y = "counts",
            color = "black",
            fill = "category",
            palette = viridisLite::viridis(nrow(t_rel_summarize)),
            label = FALSE,
            add = "mean_se"
        ) +
            xlab("") +
            ylab("proportion") +
            theme_slick
    
    `prop-plot_w-error_zoom` <- `sample-by-category_pivoted` %>%
        ggpubr::ggbarplot(
            x = "samples",
            y = "counts",
            color = "black",
            fill = "category",
            palette = viridisLite::viridis(nrow(t_rel_summarize)),
            label = FALSE,
            add = "mean_se"
        ) +
            coord_cartesian(ylim = c(0, zoom)) +
            xlab("") +
            ylab("proportion") +
            theme_slick
    
    #  Checks
    `prop-plot_w-error_full`
    `prop-plot_w-error_zoom`
}

#  Draw mean proportional bar plots without error bars
run <- TRUE
if(base::isTRUE(run)) {
    `prop-plot_no-error_full` <- `sample-by-category_pivoted` %>%
        ggpubr::ggbarplot(
            x = "samples",
            y = "counts",
            color = NA,
            fill = "category",
            palette = viridisLite::viridis(nrow(t_rel_summarize)),
            label = FALSE,
            add = "mean_se"
        ) +
            xlab("") +
            ylab("proportion") +
            theme_slick
    
    `prop-plot_no-error_zoom` <- `sample-by-category_pivoted` %>%
        ggpubr::ggbarplot(
            x = "samples",
            y = "counts",
            color = NA,
            fill = "category",
            palette = viridisLite::viridis(nrow(t_rel_summarize)),
            label = FALSE,
            add = "mean_se"
        ) +
            coord_cartesian(ylim = c(0, zoom)) +
            xlab("") +
            ylab("proportion") +
            theme_slick
    
    #  Checks
    `prop-plot_no-error_full` # + theme_slick_no_legend
    `prop-plot_no-error_zoom` # + theme_slick_no_legend
}


#TODO Get these plots into a format that's good for AG's work with Affinity

#INPROGRESS
# #  Write out t_rel_summarize, prop_summarize as tsvs
# readr::write_tsv(
#     t_rel_summarize,
#     file = "t_rel_summarize.tsv"
# )
# 
# readr::write_tsv(
#     prop_summarize,
#     file = "prop_summarize.tsv"
# )

#TBD
# #  For when f_gtf == "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
# test <- t_gtf %>%
#     dplyr::group_by(details_type_alpha) %>% 
#     dplyr::summarize(n = dplyr::n())
