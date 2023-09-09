#!/usr/bin/env Rscript

#  rough-draft_evaluate-categories_expression.R
#  KA


#  Initialize arguments =======================================================
samples <- "ovation"  #ARGUMENT
# samples <- "ovation_tecan_test"  #ARGUMENT
# samples <- "ovation_tecan_test_rrp6∆"  #ARGUMENT
# samples <- "ovation_tecan_updated"  #ARGUMENT
# samples <- "n3d_od"  #ARGUMENT
# samples <- "r6n"  #ARGUMENT
# samples <- "r6n_timecourse"  #ARGUMENT
# samples <- "Rrp6∆.timecourse-G1-Q.SS"

# tx <- "coding-non-pa-ncRNA"  #ARGUMENT  #IMPORTANT  #NOTE i.e., "R64"
# tx <- "noncoding-collapsed"  #ARGUMENT  #IMPORTANT
tx <- "noncoding-non-collapsed"  #ARGUMENT
# tx <- "Trinity-G1"  #ARGUMENT
# tx <- "Trinity-Q"  #ARGUMENT


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
p_wd <- "2022-2023_RRP6-NAB3/results/2023-0215"

setwd(paste(p_local, p_wd, sep = "/"))
getwd()

rm(p_local, p_wd)


#  Initialize functions -------------------------------------------------------
`%notin%` <- Negate(`%in%`)


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


derive_summary_metrics <- function(uni_multi, summary, counts) {
    #  Debug
    run <- FALSE
    if(base::isTRUE(run)) {
        uni_multi <- uni_multi_etc
        summary <- underscore
        counts <- t_cm
    }
    
    #  Step 1: Get multimappers associated with "Mito-KL-20S"
    `Mito-KL-20S_multi` <- uni_multi[
        stringr::str_detect(uni_multi[["sample"]], "Mito-KL-20S_multi"),
        2:ncol(uni_multi)
    ]
    
    if(base::isTRUE(run)) print(`Mito-KL-20S_multi`)
    
    #  Step 2: Get unimappers associated with "Mito-KL-20S"
    `Mito-KL-20S_uni` <- uni_multi[
        stringr::str_detect(uni_multi[["sample"]], "Mito-KL-20S_uni"),
        2:ncol(uni_multi)
    ]
    
    if(base::isTRUE(run)) print(`Mito-KL-20S_uni`)
    
    #  Step 3: Get unimappers associated with "SC-I-XVI"
    `SC-I-XVI_uni` <- uni_multi[
        stringr::str_detect(uni_multi[["sample"]], "SC-I-XVI_uni"),
        2:ncol(uni_multi)
    ]
    
    if(base::isTRUE(run)) print(`SC-I-XVI_uni`)
    
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
    
    if(base::isTRUE(run)) print(`__alignment_not_unique`)
    if(base::isTRUE(run)) print(`__alignment_not_unique_I-XVI`)
    
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
    
    if(base::isTRUE(run)) print(`__no_feature`)
    if(base::isTRUE(run)) print(`__no_feature_I-XVI`)
    
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
    
    if(base::isTRUE(run)) print(`__ambiguous`)
    if(base::isTRUE(run)) print(`__valid_counts`)
    if(base::isTRUE(run)) print(`__sum_I-XVI`)
    
    #  Step 7: Tally all counts associated with "SC-I-XVI" (`SC-I-XVI_all`)
    `SC-I-XVI_all` <- 
        uni_multi[
            stringr::str_detect(uni_multi[["sample"]], "SC-I-XVI_all"),
            2:ncol(uni_multi)
        ]
    `SC-I-XVI_all` <- `SC-I-XVI_all` %>% tibble::as_tibble()
    
    if(base::isTRUE(run)) print(`SC-I-XVI_all`)
    
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


#  Load and process gtf, counts matrix, and summary metrics ===================
#  Load gtf file of interest --------------------------------------------------
# ...which consists of collapsed/merged pa-ncRNAs and "processed" features
if(base::isFALSE(tx %in% c(
    "coding-non-pa-ncRNA", "noncoding-non-collapsed",
    "noncoding-collapsed", "Trinity-G1", "Trinity-Q"
))) {
    stop(paste(
        "Argument \"tx\" must be one of either \"coding\",",
        "\"noncoding-non-collapsed\", or \"noncoding-collapsed\""
    ))
}
if(tx == "coding-non-pa-ncRNA") {
    p_gtf <- "outfiles_gtf-gff3/representation"
    f_gtf <- "Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf"
} else if(tx == "noncoding-non-collapsed") {
    p_gtf <- "outfiles_gtf-gff3/representation"
    f_gtf <- "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf"  #DONE #IMPORTANT #FUTURE
} else if(tx == "noncoding-collapsed") {
    p_gtf <- "outfiles_gtf-gff3/representation"
    f_gtf <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"  #TODO #TOCOMPLETE
} else if(tx == "Trinity-G1") {
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
    f_gtf <- "G1_mkc-4_gte-pctl-25.clean.gtf"
} else if(tx == "Trinity-Q") {
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
    f_gtf <- "Q_mkc-4_gte-pctl-25.clean.gtf"
}

#DONOTUSE #TBD
# f_gtf <- "Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf"
# f_gtf <- "Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf"

run <- FALSE
if(base::isTRUE(run)) {
    dir.exists(p_gtf)
    file.exists(paste(p_gtf, f_gtf, sep = "/"))
}

t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
    rtracklayer::import() %>%
    tibble::as_tibble() %>%
    dplyr::arrange(seqnames, start) %>%
    dplyr::select(-c(width, score, phase))
if(tx %in% c("coding-non-pa-ncRNA", "noncoding-non-collapsed")) {
    t_gtf <- t_gtf %>% dplyr::rename(category = type.1)
}
    
t_gtf[t_gtf == "NA"] <- NA_character_
# t_gtf

rm(p_gtf)


# Load counts matrix file of interest -----------------------------------------
# ...which consists of collapsed/merged pa-ncRNAs and "processed" features
if(f_gtf == "Greenlaw-et-al_representative-coding-pa-ncRNA-transcriptome.gtf") {
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "representative-coding-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
    # f_cm <- "representative-coding-pa-ncRNA-transcriptome.hc-strd-eq.union-fraction.tsv"
} else if(f_gtf == "Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf") {
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
    # f_cm <- "representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-fraction.tsv"
} else if(f_gtf == "Greenlaw-et-al_representative-coding-ncRNA-transcriptome.gtf") {
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "representative-coding-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
} else if(f_gtf == "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf") { #DONE
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv"  #TODO #IMPORTANT
} else if(f_gtf == "Greenlaw-et-al_representative-non-coding-transcriptome.gtf") {
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "representative-non-coding-transcriptome.hc-strd-eq.tsv"
} else if(f_gtf == "G1_mkc-4_gte-pctl-25.clean.gtf") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/G_N/filtered/locus"
    f_cm <- "G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
} else if(f_gtf == "Q_mkc-4_gte-pctl-25.clean.gtf") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus"
    f_cm <- "Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
}

run <- FALSE
if(base::isTRUE(run)) {
    dir.exists(p_cm) %>% print()
    file.exists(paste(p_cm, f_cm, sep = "/")) %>% print()
}

t_cm <- read_in_counts_matrix(paste(p_cm, f_cm, sep = "/"))
if(base::isFALSE(nrow(unique(t_cm[1])) == nrow(t_cm))) {
    stop(paste(
        "There are non-unique elements in the \"gene_id\" column (i.e., the",
        "feature name vector). This will result in complications when running",
        "subsequent code/analyses. Stopping the script."
    ))
}


#  Clean up the tibble of counts ----------------------------------------------
#  Clean up, correct, and abbreviate sample names
colnames(t_cm) <- colnames(t_cm) %>%
    gsub("bams_renamed/UT_prim_UMI/", "", .) %>%
    gsub("\\.UT_prim_UMI\\.bam", "", .)
colnames(t_cm)

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

run <- TRUE
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
if(base::isTRUE(run)) t_cm %>% tail(10)


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
run <- TRUE
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
if(tx == "coding-non-pa-ncRNA") {
    t_full <- dplyr::full_join(
        t_gtf[, c(1:4, 7, 9, 10)],
        t_cm,
        by = "gene_id"
    )
} else if(tx == "noncoding-non-collapsed") {
    t_full <- dplyr::full_join(
        t_gtf[, c(1:4, 14, 9, 7)] %>%
            dplyr::rename(
                "original" = "gene_id",
                "gene_id" = "complete"
            ),
        t_cm,
        by = "gene_id"
    )
} else if(tx == "noncoding-collapsed") {
    t_full <- dplyr::full_join(
        t_gtf[, c(1:4, 7, 9, 11)] %>% 
            dplyr::rename(
                "category" = "details_type_alpha",
                "original" = "details_id"
            ),
        t_cm,
        by = "gene_id"
    )
    # table(t_gtf[, c(1:4, 7, 9, 11)]$gene_id %in% t_cm$gene_id)
} else if(tx %in% c("Trinity-G1", "Trinity-Q")) {  #TODO Need to build out code
    t_full <- dplyr::full_join(
        t_gtf[, c(1:4, 7, 10, 13)] %>%  #TODO Check that this is correct
            dplyr::rename(
                "gene_id" = "locus_id",
                "category" = "type.1",
                "R64_overlap" = "category_detailed"
            ),
        t_cm,
        by = "gene_id"
    )
    
    #  Simplify the "coding" categories
    t_full$category <- ifelse(
        t_full$category %in% c(
            "coding: partial", "coding: multiple, partial", "coding: multiple"
        ),
        "coding: miscellaneous",
        t_full$category
    )
}


#  Row-bind tibbles t_full and summary_relevant -------------------------------
t_full <- dplyr::bind_rows(t_full, summary_relevant)

#  Checks
# nrow(t_full)
# tail(t_full)
# tail(t_full[, -c(1:7)])
# tail(t_full[-c((nrow(t_full) - 3):nrow(t_full)), -c(1:7)])


#  Important check: Do sample-wise tallies equal __valid_counts? --------------
test_A <- sapply(
        t_full[-c((nrow(t_full) - 3):nrow(t_full)), -c(1:7)], sum
    ) %>%
    t() %>%
    tibble::as_tibble()

test_B <- summary_relevant[
        stringr::str_detect(summary_relevant$gene_id, "valid"), 
    ][
        , 2:ncol(summary_relevant)
    ]

if(base::isFALSE(identical(test_A, test_B))) {
    stop(paste(
        "Sample-wise tallies do not equal __valid_counts. Stopping the",
        "script."
    ))
}

rm(test_A, test_B)


#  Plot category proportions for the Ovation samples ==========================
#  Isolate categories and relevant samples, then process them -----------------
#TODO May need to be adapted for...
#    - "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf"
#    - "non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv"
tmp <- t_full[-nrow(t_full), -c(1:5, 7)]
# colnames(tmp)

if(samples == "ovation") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "ovn")]
} else if(samples == "ovation_tecan_test") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "ovn|test")]
} else if(samples == "ovation_tecan_test_rrp6∆") {
    tmp_samples <- tmp[, stringr::str_detect(
        colnames(tmp), "r6n_Q|r6n_G1|WT_Q|WT_G1|WTovn|WTtest"
    )]
} else if(samples == "ovation_tecan_updated") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "ovn|test")] %>%
        dplyr::select(-WTovn_Q_SS_rep1_tech1)
} else if(samples == "n3d_od") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "n3d|od")] %>%
        dplyr::select(-dplyr::contains("rep3"))
} else if(samples == "r6n") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "r6n|WT")] %>%
        dplyr::select(-dplyr::contains("DS")) %>%
        dplyr::select(-dplyr::contains("ovn")) %>%
        dplyr::select(-dplyr::contains("test")) %>%
        dplyr::select(-dplyr::contains("_N_"))
} else if(samples == "r6n_timecourse") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "DS")] %>%
        dplyr::select(-dplyr::contains("t4n"))
} else if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
    tmp_samples <- tmp[, stringr::str_detect(colnames(tmp), "r6n|WT|DS")] %>%
        dplyr::select(-dplyr::contains("t4n")) %>%
        dplyr::select(-dplyr::contains("ovn")) %>%
        dplyr::select(-dplyr::contains("test")) %>%
        dplyr::select(-dplyr::contains("_N_"))
}
# colnames(tmp_samples)

t_rel <- dplyr::bind_cols(tmp[, 1], tmp_samples)
t_rel[(nrow(t_rel) - 2), 1] <- "multimapper"
t_rel[(nrow(t_rel) - 1), 1] <- "no feature"
t_rel[nrow(t_rel), 1] <- "ambiguous"
if(base::isTRUE(colnames(t_rel)[1] != "category")) {
    colnames(t_rel)[1] <- "category"
}
# tail(t_rel)
# head(t_rel)

#  Rename category "PG" to "pseudogene" (if applicable)
if(tx == "coding-non-pa-ncRNA") {
    t_rel$category[stringr::str_detect(t_rel$category, "PG")] <- "pseudogene"
}
    
#  Further clean up the column names
if(samples %in% c("ovation", "n3d_od")) {
    colnames(t_rel) <- colnames(t_rel) %>%
        stringr::str_remove("ovn") %>%
        stringr::str_remove("_tech1")
} else if(samples %in% c("ovation_tecan_test", "ovation_tecan_updated")) {
    colnames(t_rel) <- colnames(t_rel) %>%
        gsub("WTovn", "WT_ovn", .) %>%
        gsub("WTtest", "WT_tcn", .) %>%
        gsub("_tech1", "", .)
} else if(samples == "ovation_tecan_test_rrp6∆") {
    colnames(t_rel) <- colnames(t_rel) %>%
        gsub("WT_", "WT_tcn_", .) %>%
        gsub("r6n_", "r6n_tcn_", .) %>%
        gsub("WTovn", "WT_ovn", .) %>%
        gsub("WTtest", "WT_test", .)
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
} else if(samples == "ovation_tecan_test") {
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_WT_ovn_G1_N_rep1 = sum(WT_ovn_G1_N_rep1),
            sum_WT_ovn_G1_N_rep2 = sum(WT_ovn_G1_N_rep2),
            sum_WT_ovn_G1_SS_rep1 = sum(WT_ovn_G1_SS_rep1),
            sum_WT_ovn_G1_SS_rep2 = sum(WT_ovn_G1_SS_rep2),
            sum_WT_ovn_Q_N_rep1 = sum(WT_ovn_Q_N_rep1),
            sum_WT_ovn_Q_N_rep2 = sum(WT_ovn_Q_N_rep2),
            sum_WT_tcn_Q_N_rep2 = sum(WT_tcn_Q_N_rep2),
            sum_WT_ovn_Q_SS_rep1 = sum(WT_ovn_Q_SS_rep1),
            sum_WT_ovn_Q_SS_rep2 = sum(WT_ovn_Q_SS_rep2),
            sum_WT_tcn_Q_SS_rep2 = sum(WT_tcn_Q_SS_rep2),
            number_of_features = dplyr::n()
        )
} else if(samples == "ovation_tecan_test_rrp6∆") {
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_WT_ovn_G1_N_rep2_tech1 = sum(WT_ovn_G1_N_rep2_tech1),
            sum_WT_ovn_G1_N_rep1_tech1 = sum(WT_ovn_G1_N_rep1_tech1),
            sum_WT_ovn_G1_SS_rep1_tech1 = sum(WT_ovn_G1_SS_rep1_tech1),
            sum_WT_ovn_G1_SS_rep2_tech1 = sum(WT_ovn_G1_SS_rep2_tech1),
            sum_WT_tcn_G1_SS_rep1_tech2 = sum(WT_tcn_G1_SS_rep1_tech2),
            sum_WT_tcn_G1_SS_rep2_tech2 = sum(WT_tcn_G1_SS_rep2_tech2),
            sum_WT_ovn_Q_N_rep1_tech1 = sum(WT_ovn_Q_N_rep1_tech1),
            sum_WT_ovn_Q_N_rep2_tech1 = sum(WT_ovn_Q_N_rep2_tech1),
            sum_WT_test_Q_N_rep2_tech1 = sum(WT_test_Q_N_rep2_tech1),
            sum_WT_tcn_Q_N_rep1_tech1 = sum(WT_tcn_Q_N_rep1_tech1),
            sum_WT_tcn_Q_N_rep2_tech1 = sum(WT_tcn_Q_N_rep2_tech1),
            sum_WT_ovn_Q_SS_rep1_tech1 = sum(WT_ovn_Q_SS_rep1_tech1),
            sum_WT_ovn_Q_SS_rep2_tech1 = sum(WT_ovn_Q_SS_rep2_tech1),
            sum_WT_test_Q_SS_rep2_tech1 = sum(WT_test_Q_SS_rep2_tech1),
            sum_WT_tcn_Q_SS_rep1_tech1 = sum(WT_tcn_Q_SS_rep1_tech1),
            sum_WT_tcn_Q_SS_rep2_tech1 = sum(WT_tcn_Q_SS_rep2_tech1),
            sum_r6n_tcn_G1_SS_rep2_tech2 = sum(r6n_tcn_G1_SS_rep2_tech2),
            sum_r6n_tcn_G1_SS_rep1_tech2 = sum(r6n_tcn_G1_SS_rep1_tech2),
            sum_r6n_tcn_Q_N_rep2_tech1 = sum(r6n_tcn_Q_N_rep2_tech1),
            sum_r6n_tcn_Q_N_rep1_tech1 = sum(r6n_tcn_Q_N_rep1_tech1),
            sum_r6n_tcn_Q_SS_rep2_tech1 = sum(r6n_tcn_Q_SS_rep2_tech1),
            sum_r6n_tcn_Q_SS_rep2_tech2 = sum(r6n_tcn_Q_SS_rep2_tech2),
            sum_r6n_tcn_Q_SS_rep1_tech1 = sum(r6n_tcn_Q_SS_rep1_tech1),
            number_of_features = dplyr::n()
        )
} else if(samples == "ovation_tecan_updated") {
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_WT_ovn_G1_N_rep1 = sum(WT_ovn_G1_N_rep1),
            sum_WT_ovn_G1_N_rep2 = sum(WT_ovn_G1_N_rep2),
            sum_WT_ovn_G1_SS_rep1 = sum(WT_ovn_G1_SS_rep1),
            sum_WT_ovn_G1_SS_rep2 = sum(WT_ovn_G1_SS_rep2),
            sum_WT_ovn_Q_N_rep1 = sum(WT_ovn_Q_N_rep1),
            sum_WT_ovn_Q_N_rep2 = sum(WT_ovn_Q_N_rep2),
            sum_WT_tcn_Q_N_rep2 = sum(WT_tcn_Q_N_rep2),
            sum_WT_ovn_Q_SS_rep2 = sum(WT_ovn_Q_SS_rep2),
            sum_WT_tcn_Q_SS_rep2 = sum(WT_tcn_Q_SS_rep2),
            number_of_features = dplyr::n()
        )
} else if(samples == "n3d_od") {
    t_rel <- t_rel %>% dplyr::relocate(
            c("n3d_Q_N_rep1", "n3d_Q_N_rep2"),
            .after = "od_Q_N_rep2"
        ) %>%
        dplyr::relocate(
            c("n3d_Q_SS_rep1", "n3d_Q_SS_rep2"),
            .after = "od_Q_SS_rep2"
        )
    
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_od_Q_N_rep1 = sum(od_Q_N_rep1),
            sum_od_Q_N_rep2 = sum(od_Q_N_rep2),
            sum_n3d_Q_N_rep1 = sum(n3d_Q_N_rep1),
            sum_n3d_Q_N_rep2 = sum(n3d_Q_N_rep2),
            sum_od_Q_SS_rep1 = sum(od_Q_SS_rep1),
            sum_od_Q_SS_rep2 = sum(od_Q_SS_rep2),
            sum_n3d_Q_SS_rep1 = sum(n3d_Q_SS_rep1),
            sum_n3d_Q_SS_rep2 = sum(n3d_Q_SS_rep2),
            number_of_features = dplyr::n()
        )
} else if(samples == "r6n") {
    t_rel <- t_rel %>%
        dplyr::relocate(
            c(
                "WT_G1_SS_rep1_tech2", "WT_G1_SS_rep2_tech2",
                "r6n_G1_SS_rep1_tech2", "r6n_G1_SS_rep2_tech2"
            ),
            .after = "category"
        ) %>%
        dplyr::relocate(
            c(
                "WT_Q_SS_rep1_tech1", "WT_Q_SS_rep2_tech1",
                "r6n_Q_SS_rep1_tech1", "r6n_Q_SS_rep2_tech1",
                "r6n_Q_SS_rep2_tech2"
            ),
            .after = "r6n_G1_SS_rep2_tech2"
        )
    
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_WT_G1_SS_rep1_tech2 = sum(WT_G1_SS_rep1_tech2),
            sum_WT_G1_SS_rep2_tech2 = sum(WT_G1_SS_rep2_tech2),
            sum_r6n_G1_SS_rep1_tech2 = sum(r6n_G1_SS_rep1_tech2),
            sum_r6n_G1_SS_rep2_tech2 = sum(r6n_G1_SS_rep2_tech2),
            sum_WT_Q_SS_rep1_tech1 = sum(WT_Q_SS_rep1_tech1),
            sum_WT_Q_SS_rep2_tech1 = sum(WT_Q_SS_rep2_tech1),
            sum_r6n_Q_SS_rep1_tech1 = sum(r6n_Q_SS_rep1_tech1),
            sum_r6n_Q_SS_rep2_tech1 = sum(r6n_Q_SS_rep2_tech1),
            sum_r6n_Q_SS_rep2_tech2 = sum(r6n_Q_SS_rep2_tech2),
            number_of_features = dplyr::n()
        )
} else if(samples == "r6n_timecourse") {
    t_rel <- t_rel %>% dplyr::relocate(
            c("r6n_DSm2_SS_rep1_tech1", "r6n_DSm2_SS_rep2_tech1"),
            .after = "WT_DSm2_SS_rep2_tech1"
        ) %>%
        # dplyr::relocate(
        #     c("r6n_DSp2_SS_rep1_tech1", "r6n_DSp2_SS_rep2_tech1"),
        #     .after = "WT_DSp2_SS_rep2_tech1"
        # ) %>%
        dplyr::relocate(
            c("r6n_DSp24_SS_rep1_tech1", "r6n_DSp24_SS_rep2_tech1"),
            .after = "WT_DSp24_SS_rep2_tech1"
        ) %>%
        dplyr::relocate(
            c("r6n_DSp48_SS_rep1_tech2", "r6n_DSp48_SS_rep2_tech1"),
            .after = "WT_DSp48_SS_rep2_tech1"
        ) %>%
        dplyr::relocate(
            c(
                "WT_DSp2_SS_rep1_tech1",
                "WT_DSp2_SS_rep2_tech1",
                "r6n_DSp2_SS_rep1_tech1",
                "r6n_DSp2_SS_rep2_tech1"
            ),
            .before = "WT_DSp24_SS_rep1_tech1"
        )
    
        t_rel_summarize <- t_rel %>%
            dplyr::group_by(category) %>%
            dplyr::summarize(
                sum_WT_DSm2_SS_rep1_tech1 = sum(WT_DSm2_SS_rep1_tech1),
                sum_WT_DSm2_SS_rep2_tech1 = sum(WT_DSm2_SS_rep2_tech1),
                sum_r6n_DSm2_SS_rep1_tech1 = sum(r6n_DSm2_SS_rep1_tech1),
                sum_r6n_DSm2_SS_rep2_tech1 = sum(r6n_DSm2_SS_rep2_tech1),
                sum_WT_DSp2_SS_rep1_tech1 = sum(WT_DSp2_SS_rep1_tech1),
                sum_WT_DSp2_SS_rep2_tech1 = sum(WT_DSp2_SS_rep2_tech1),
                sum_r6n_DSp2_SS_rep1_tech1 = sum(r6n_DSp2_SS_rep1_tech1),
                sum_r6n_DSp2_SS_rep2_tech1 = sum(r6n_DSp2_SS_rep2_tech1),
                sum_WT_DSp24_SS_rep1_tech1 = sum(WT_DSp24_SS_rep1_tech1),
                sum_WT_DSp24_SS_rep2_tech1 = sum(WT_DSp24_SS_rep2_tech1),
                sum_r6n_DSp24_SS_rep1_tech1 = sum(r6n_DSp24_SS_rep1_tech1),
                sum_r6n_DSp24_SS_rep2_tech1 = sum(r6n_DSp24_SS_rep2_tech1),
                sum_WT_DSp48_SS_rep1_tech1 = sum(WT_DSp48_SS_rep1_tech1),
                sum_WT_DSp48_SS_rep1_tech2 = sum(WT_DSp48_SS_rep1_tech2),
                sum_WT_DSp48_SS_rep2_tech1 = sum(WT_DSp48_SS_rep2_tech1),
                sum_r6n_DSp48_SS_rep1_tech2 = sum(r6n_DSp48_SS_rep1_tech2),
                sum_r6n_DSp48_SS_rep2_tech1 = sum(r6n_DSp48_SS_rep2_tech1),
                number_of_features = dplyr::n()
            )
} else if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
    t_rel <- t_rel %>%
        dplyr::relocate(
            c(
                "WT_G1_SS_rep1_tech2", "WT_G1_SS_rep2_tech2",
                "r6n_G1_SS_rep1_tech2", "r6n_G1_SS_rep2_tech2",
                "WT_DSm2_SS_rep1_tech1", "WT_DSm2_SS_rep2_tech1",
                "r6n_DSm2_SS_rep1_tech1", "r6n_DSm2_SS_rep2_tech1",
                "WT_DSp2_SS_rep1_tech1", "WT_DSp2_SS_rep2_tech1",
                "r6n_DSp2_SS_rep1_tech1", "r6n_DSp2_SS_rep2_tech1",
                "WT_DSp24_SS_rep1_tech1", "WT_DSp24_SS_rep2_tech1",
                "r6n_DSp24_SS_rep1_tech1", "r6n_DSp24_SS_rep2_tech1",
                "WT_DSp48_SS_rep1_tech1", "WT_DSp48_SS_rep1_tech2",
                "WT_DSp48_SS_rep2_tech1", "r6n_DSp48_SS_rep1_tech2",
                "r6n_DSp48_SS_rep2_tech1", "WT_Q_SS_rep1_tech1",
                "WT_Q_SS_rep2_tech1", "r6n_Q_SS_rep1_tech1",
                "r6n_Q_SS_rep2_tech1", "r6n_Q_SS_rep2_tech2"
            ),
            .after = "category"
        )
    
    t_rel_summarize <- t_rel %>%
        dplyr::group_by(category) %>%
        dplyr::summarize(
            sum_WT_G1_SS_rep1_tech2 = sum(WT_G1_SS_rep1_tech2),
            sum_WT_G1_SS_rep2_tech2 = sum(WT_G1_SS_rep2_tech2),
            sum_r6n_G1_SS_rep1_tech2 = sum(r6n_G1_SS_rep1_tech2),
            sum_r6n_G1_SS_rep2_tech2 = sum(r6n_G1_SS_rep2_tech2),
            sum_WT_DSm2_SS_rep1_tech1 = sum(WT_DSm2_SS_rep1_tech1),
            sum_WT_DSm2_SS_rep2_tech1 = sum(WT_DSm2_SS_rep2_tech1),
            sum_r6n_DSm2_SS_rep1_tech1 = sum(r6n_DSm2_SS_rep1_tech1),
            sum_r6n_DSm2_SS_rep2_tech1 = sum(r6n_DSm2_SS_rep2_tech1),
            sum_WT_DSp2_SS_rep1_tech1 = sum(WT_DSp2_SS_rep1_tech1),
            sum_WT_DSp2_SS_rep2_tech1 = sum(WT_DSp2_SS_rep2_tech1),
            sum_r6n_DSp2_SS_rep1_tech1 = sum(r6n_DSp2_SS_rep1_tech1),
            sum_r6n_DSp2_SS_rep2_tech1 = sum(r6n_DSp2_SS_rep2_tech1),
            sum_WT_DSp24_SS_rep1_tech1 = sum(WT_DSp24_SS_rep1_tech1),
            sum_WT_DSp24_SS_rep2_tech1 = sum(WT_DSp24_SS_rep2_tech1),
            sum_r6n_DSp24_SS_rep1_tech1 = sum(r6n_DSp24_SS_rep1_tech1),
            sum_r6n_DSp24_SS_rep2_tech1 = sum(r6n_DSp24_SS_rep2_tech1),
            sum_WT_DSp48_SS_rep1_tech1 = sum(WT_DSp48_SS_rep1_tech1),
            sum_WT_DSp48_SS_rep1_tech2 = sum(WT_DSp48_SS_rep1_tech2),
            sum_WT_DSp48_SS_rep2_tech1 = sum(WT_DSp48_SS_rep2_tech1),
            sum_r6n_DSp48_SS_rep1_tech2 = sum(r6n_DSp48_SS_rep1_tech2),
            sum_r6n_DSp48_SS_rep2_tech1 = sum(r6n_DSp48_SS_rep2_tech1),
            sum_WT_Q_SS_rep1_tech1 = sum(WT_Q_SS_rep1_tech1),
            sum_WT_Q_SS_rep2_tech1 = sum(WT_Q_SS_rep2_tech1),
            sum_r6n_Q_SS_rep1_tech1 = sum(r6n_Q_SS_rep1_tech1),
            sum_r6n_Q_SS_rep2_tech1 = sum(r6n_Q_SS_rep2_tech1),
            sum_r6n_Q_SS_rep2_tech2 = sum(r6n_Q_SS_rep2_tech2),
            number_of_features = dplyr::n()
        )
}  #HERE
# colnames(t_rel)
# colnames(t_rel_summarize)
# t_rel_summarize$category

#  For "noncoding-collapsed" measurements, combine categories with less than
#+ 100 feature elements into a new category: "other"
if(tx == "noncoding-collapsed") {
    run <- TRUE
    if(base::isTRUE(run)) {
        t_rel_summarize.bak <- t_rel_summarize
        
        feat_alignment <- t_rel_summarize[
            t_rel_summarize$category %in%
                c("ambiguous", "multimapper", "no feature"), 
        ]
        feat_ncRNA <- t_rel_summarize[
            t_rel_summarize$category %notin%
                c("ambiguous", "multimapper", "no feature"), 
        ]
        
        # colSums(feat_alignment[, 2:ncol(feat_alignment)])
        # colSums(feat_ncRNA[, 2:ncol(feat_ncRNA)])
        
        threshold <- 1000  #ARGUMENT
        
        if(samples == "ovation") {
            feat_ncRNA <- rbind(
                feat_ncRNA[feat_ncRNA$number_of_features >= threshold, ],
                list(
                    # category = "other",
                    category = "ncRNA",
                    sum_WT_G1_N_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_G1_N_rep1"
                    ]),
                    sum_WT_G1_N_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_G1_N_rep2"
                    ]),
                    sum_WT_G1_SS_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_G1_SS_rep1"
                    ]),
                    sum_WT_G1_SS_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_G1_SS_rep2"
                    ]),
                    sum_WT_Q_N_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_Q_N_rep1"
                    ]),
                    sum_WT_Q_N_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_Q_N_rep2"
                    ]),
                    sum_WT_Q_SS_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_Q_SS_rep1"
                    ]),
                    sum_WT_Q_SS_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_Q_SS_rep2"
                    ]),
                    number_of_features = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "number_of_features"
                    ])
                )
            )
        } else if(samples == "n3d_od") {
            feat_ncRNA <- rbind(
                feat_ncRNA[feat_ncRNA$number_of_features >= threshold, ],
                list(
                    # category = "other",
                    category = "ncRNA",
                    sum_od_Q_N_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_od_Q_N_rep1"
                    ]),
                    sum_od_Q_N_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_od_Q_N_rep2"
                    ]),
                    sum_n3d_Q_N_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_n3d_Q_N_rep1"
                    ]),
                    sum_n3d_Q_N_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_n3d_Q_N_rep2"
                    ]),
                    sum_od_Q_SS_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_od_Q_SS_rep1"
                    ]),
                    sum_od_Q_SS_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_od_Q_SS_rep2"
                    ]),
                    sum_n3d_Q_SS_rep1 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_n3d_Q_SS_rep1"
                    ]),
                    sum_n3d_Q_SS_rep2 = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_n3d_Q_SS_rep2"
                    ]),
                    number_of_features = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "number_of_features"
                    ])
                )
            )
        } else if(samples == "r6n_timecourse") {
            feat_ncRNA <- rbind(
                feat_ncRNA[feat_ncRNA$number_of_features >= threshold, ],
                list(
                    # category = "other",
                    category = "ncRNA",
                    sum_WT_DSm2_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSm2_SS_rep1_tech1"
                    ]),
                    sum_WT_DSm2_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSm2_SS_rep2_tech1"
                    ]),
                    sum_r6n_DSm2_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSm2_SS_rep1_tech1"
                    ]),
                    sum_r6n_DSm2_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSm2_SS_rep2_tech1"
                    ]),
                    sum_WT_DSp2_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp2_SS_rep1_tech1"
                    ]),
                    sum_WT_DSp2_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp2_SS_rep2_tech1"
                    ]),
                    sum_r6n_DSp2_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSp2_SS_rep1_tech1"
                    ]),
                    sum_r6n_DSp2_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSp2_SS_rep2_tech1"
                    ]),
                    sum_WT_DSp24_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp24_SS_rep1_tech1"
                    ]),
                    sum_WT_DSp24_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp24_SS_rep2_tech1"
                    ]),
                    sum_r6n_DSp24_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSp24_SS_rep1_tech1"
                    ]),
                    sum_r6n_DSp24_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSp24_SS_rep2_tech1"
                    ]),
                    sum_WT_DSp48_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp48_SS_rep1_tech1"
                    ]),
                    sum_WT_DSp48_SS_rep1_tech2= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp48_SS_rep1_tech2"
                    ]),
                    sum_WT_DSp48_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSp48_SS_rep2_tech1"
                    ]),
                    sum_r6n_DSp48_SS_rep1_tech2= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSp48_SS_rep1_tech2"
                    ]),
                    sum_r6n_DSp48_SS_rep2_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_r6n_DSp48_SS_rep2_tech1"
                    ]),
                    number_of_features = sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "number_of_features"
                    ])
                )
            )
        } else if(samples == "r6n") {
            feat_ncRNA <- rbind(
                feat_ncRNA[feat_ncRNA$number_of_features >= threshold, ],
                    list(
                        # category = "other",
                        category = "ncRNA",
                        sum_WT_G1_SS_rep1_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_G1_SS_rep1_tech2"
                        ]),
                        sum_WT_G1_SS_rep2_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_G1_SS_rep2_tech2"
                        ]),
                        sum_r6n_G1_SS_rep1_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_G1_SS_rep1_tech2"
                        ]),
                        sum_r6n_G1_SS_rep2_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_G1_SS_rep2_tech2"
                        ]),
                        sum_WT_Q_SS_rep1_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_Q_SS_rep1_tech1"
                        ]),
                        sum_WT_Q_SS_rep2_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_Q_SS_rep2_tech1"
                        ]),
                        sum_r6n_Q_SS_rep1_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_Q_SS_rep1_tech1"
                        ]),
                        sum_r6n_Q_SS_rep2_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_Q_SS_rep2_tech1"
                        ]),
                        sum_r6n_Q_SS_rep2_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_Q_SS_rep2_tech2"
                        ]),
                        number_of_features = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "number_of_features"
                        ])
                    )
                )
        } else if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
            feat_ncRNA <- rbind(
                feat_ncRNA[feat_ncRNA$number_of_features >= threshold, ],
                    list(
                        # category = "other",
                        category = "ncRNA",
                        sum_WT_G1_SS_rep1_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_G1_SS_rep1_tech2"
                        ]),
                        sum_WT_G1_SS_rep2_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_G1_SS_rep2_tech2"
                        ]),
                        sum_r6n_G1_SS_rep1_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_G1_SS_rep1_tech2"
                        ]),
                        sum_r6n_G1_SS_rep2_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_G1_SS_rep2_tech2"
                        ]),
                        sum_WT_DSm2_SS_rep1_tech1= sum(feat_ncRNA[
                        feat_ncRNA$number_of_features < threshold,
                        "sum_WT_DSm2_SS_rep1_tech1"
                        ]),
                        sum_WT_DSm2_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSm2_SS_rep2_tech1"
                        ]),
                        sum_r6n_DSm2_SS_rep1_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSm2_SS_rep1_tech1"
                        ]),
                        sum_r6n_DSm2_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSm2_SS_rep2_tech1"
                        ]),
                        sum_WT_DSp2_SS_rep1_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp2_SS_rep1_tech1"
                        ]),
                        sum_WT_DSp2_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp2_SS_rep2_tech1"
                        ]),
                        sum_r6n_DSp2_SS_rep1_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSp2_SS_rep1_tech1"
                        ]),
                        sum_r6n_DSp2_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSp2_SS_rep2_tech1"
                        ]),
                        sum_WT_DSp24_SS_rep1_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp24_SS_rep1_tech1"
                        ]),
                        sum_WT_DSp24_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp24_SS_rep2_tech1"
                        ]),
                        sum_r6n_DSp24_SS_rep1_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSp24_SS_rep1_tech1"
                        ]),
                        sum_r6n_DSp24_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSp24_SS_rep2_tech1"
                        ]),
                        sum_WT_DSp48_SS_rep1_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp48_SS_rep1_tech1"
                        ]),
                        sum_WT_DSp48_SS_rep1_tech2= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp48_SS_rep1_tech2"
                        ]),
                        sum_WT_DSp48_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_DSp48_SS_rep2_tech1"
                        ]),
                        sum_r6n_DSp48_SS_rep1_tech2= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSp48_SS_rep1_tech2"
                        ]),
                        sum_r6n_DSp48_SS_rep2_tech1= sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_DSp48_SS_rep2_tech1"
                        ]),
                        sum_WT_Q_SS_rep1_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_Q_SS_rep1_tech1"
                        ]),
                        sum_WT_Q_SS_rep2_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_WT_Q_SS_rep2_tech1"
                        ]),
                        sum_r6n_Q_SS_rep1_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_Q_SS_rep1_tech1"
                        ]),
                        sum_r6n_Q_SS_rep2_tech1 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_Q_SS_rep2_tech1"
                        ]),
                        sum_r6n_Q_SS_rep2_tech2 = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "sum_r6n_Q_SS_rep2_tech2"
                        ]),
                        number_of_features = sum(feat_ncRNA[
                            feat_ncRNA$number_of_features < threshold,
                            "number_of_features"
                        ])
                    )
                )
        }
        # feat_ncRNA %>% colnames()
        
        t_rel_summarize <- dplyr::bind_rows(feat_ncRNA, feat_alignment)
        
        if(base::isFALSE(identical(
            colSums(t_rel_summarize.bak[, 2:ncol(t_rel_summarize.bak)]),
            colSums(t_rel_summarize[, 2:ncol(t_rel_summarize)])
        ))) {
            stop(paste(
                "t_rel_summarize column sums are not equal. Stopping the",
                "script"
            ))
        } else {
            rm(feat_alignment, feat_ncRNA)
        }
    }
}  #HERE

#  Order the categories alphabetically without respect to case, and exclude
#+ the "multimapper (excluded)" and "pseudogene" categories
exclude <- FALSE
if(base::isTRUE(exclude)) {
    t_rel_summarize <- t_rel_summarize %>%
        dplyr::arrange(tolower(category)) %>%
        dplyr::filter(!stringr::str_detect(
            category, "^multimapper*"
        )) %>%  #TODO Determine whether to keep or not (same with TE)
        dplyr::filter(!stringr::str_detect(
            category, "^pseudogene"
        ))
} else {
    t_rel_summarize <- t_rel_summarize %>%
        dplyr::arrange(tolower(category)) %>%
        dplyr::filter(!stringr::str_detect(
            category, "^multimapper*"
        ))
}

#  Make "no feature" the first reported feature in proportional bar charts
if(tx == "noncoding-collapsed") {
    t_rel_summarize <- t_rel_summarize %>%
        dplyr::arrange(category %notin% c("no feature", "other"))
        
    match <- which(t_rel_summarize$category == "ambiguous")
    all <- 1:nrow(t_rel_summarize)
    swap <- ifelse(
        all %in% (match - 1),
        all + 1, 
        ifelse(all %in% match & all != 1, all - 1, all)
    )
    
    t_rel_summarize <- t_rel_summarize[swap, ]
    rm(match, all, swap)
} else {
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
if(samples %in% c("ovation", "ovation_tecan_test", "ovation_tecan_updated")) {
    colnames(t_rel_summarize) <- colnames(t_rel_summarize) %>%
        stringr::str_remove("sum_WT_")
} else if(samples %in% c(
    "n3d_od", "r6n", "r6n_timecourse", "ovation_tecan_test_rrp6∆",
    "Rrp6∆.timecourse-G1-Q.SS"
)) {
    colnames(t_rel_summarize) <- colnames(t_rel_summarize) %>%
        stringr::str_remove("sum_")
}


#  Plot per-replicate counts proportions --------------------------------------
run <- FALSE
if(base::isTRUE(run)) {
    t_rel_summarize.bak <- t_rel_summarize
    # t_rel_summarize <- t_rel_summarize.bak
}
t_rel_summarize$category <- t_rel_summarize$category %>% as_factor()

run <- TRUE
if(base::isTRUE(run)) {
    col_piv <- colnames(t_rel_summarize)[-c(1, ncol(t_rel_summarize))]
    
    #TODO "Function-ize" these calls, save them to variables
    tmp <- t_rel_summarize %>%
        tidyr::pivot_longer(col_piv) %>%
        dplyr::rename(samples = name, counts = value)
    tmp$samples <- tmp$samples %>% forcats::as_factor()
    
    `prop-plot_individual-replicates` <- tmp %>%
        ggplot(aes(fill = category, y = counts, x = samples)) +
        geom_bar(position = "fill", stat = "identity") +
        scale_fill_manual(
            values = length(t_rel_summarize$category) %>%
                viridisLite::viridis()
        ) +
        theme_slick +
        # theme_slick_no_legend +
        scale_x_discrete(guide = guide_axis(angle = 45))
    
    run <- FALSE
    if(base::isTRUE(run)) {
        `prop-plot_individual-replicates_non-viridis` <- tmp %>%
            ggplot(aes(fill = category, y = counts, x = samples)) +
            geom_bar(position = "fill", stat = "identity") +
            theme_slick +
            # theme_slick_no_legend +
            scale_x_discrete(guide = guide_axis(angle = 45))
    }
}
run <- TRUE
if(base::isTRUE(run)) print(`prop-plot_individual-replicates`)

prop_summarize <- sweep(
    t_rel_summarize[, 2:(ncol(t_rel_summarize) - 1)],
    2,
    colSums(t_rel_summarize[, 2:(ncol(t_rel_summarize) - 1)]),
    `/`
) %>%
    dplyr::mutate(
        category = t_rel_summarize$category,
        number_of_features = t_rel_summarize$number_of_features
    ) %>%
    dplyr::relocate(category)

col_piv <- colnames(t_rel_summarize)[-c(1, ncol(t_rel_summarize))]

`sample-by-category_pivoted` <- prop_summarize[
    , 1:(ncol(t_rel_summarize) - 1)
] %>%
    pivot_on_columns(col_piv)  #HERE

if(samples %in% c(
    "ovation_tecan_test", "ovation_tecan_test_rrp6∆", "ovation_tecan_updated"
)) {
    `sample-by-category_pivoted`$samples <-
        `sample-by-category_pivoted`$samples %>%
        stringr::str_remove_all(
            "ovn_|tcn_|test_|_rep1|_rep2|_tech1|_tech2"
        ) %>%
        as.factor()
} else if(samples == "n3d_od") {
    `sample-by-category_pivoted`$samples <-
        `sample-by-category_pivoted`$samples %>%
        stringr::str_remove_all("_rep1|_rep2") %>%
        as.factor()
} else if (samples %in% c("r6n", "r6n_timecourse", "Rrp6∆.timecourse-G1-Q.SS")) {
    `sample-by-category_pivoted`$samples <-
        `sample-by-category_pivoted`$samples %>%
        stringr::str_remove_all("_tech1|_tech2|_rep1|_rep2")
    
    if(samples == "r6n") {
        `sample-by-category_pivoted`$samples <- factor(
            `sample-by-category_pivoted`$samples,
            levels = c("WT_G1_SS", "r6n_G1_SS", "WT_Q_SS", "r6n_Q_SS")
        )
    } else if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
        `sample-by-category_pivoted`$samples <- factor(
            `sample-by-category_pivoted`$samples,
            levels = c(
                "WT_G1_SS", "r6n_G1_SS", "WT_DSm2_SS", "r6n_DSm2_SS",
                "WT_DSp2_SS", "r6n_DSp2_SS", "WT_DSp24_SS", "r6n_DSp24_SS",
                "WT_DSp48_SS", "r6n_DSp48_SS", "WT_Q_SS", "r6n_Q_SS"
            )
        )
    } else {
        `sample-by-category_pivoted`$samples <- factor(
            `sample-by-category_pivoted`$samples,
            levels = c(
                "WT_DSm2_SS", "r6n_DSm2_SS", "WT_DSp2_SS", "r6n_DSp2_SS",
                "WT_DSp24_SS", "r6n_DSp24_SS", "WT_DSp48_SS", "r6n_DSp48_SS"
            )
        )
    }
} else {
    `sample-by-category_pivoted`$samples <-
        `sample-by-category_pivoted`$samples %>%
        stringr::str_remove_all("_rep1|_rep2") %>%
        as.factor()
}


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
run <- FALSE
if(base::isTRUE(run)) {
    `sample-by-category_pivoted`
    `sample-by-category_stats`  #TODO Write out tsv of stats
}

if(samples == "ovation") {
    if(tx == "coding-non-pa-ncRNA") zoom <- 0.30  # 0.925
    if(tx == "noncoding-non-collapsed") zoom <- 0.30
    if(tx == "noncoding-collapsed") zoom <- 0.26
    if(tx %in% c("Trinity-G1", "Trinity-Q")) zoom <- 0.375  # 0.20  # 0.95
} else if(samples %in% c(
    "ovation_tecan_test", "ovation_tecan_test_rrp6∆", "ovation_tecan_updated"
)) {
    if(tx == "coding-non-pa-ncRNA") zoom <- 0.925
    if(tx == "noncoding-non-collapsed") zoom <- 0.30
    if(tx == "noncoding-collapsed") zoom <- 0.26
    if(tx %in% c("Trinity-G1", "Trinity-Q")) zoom <- 0.95
} else if(samples == "n3d_od") {
    if(tx == "coding-non-pa-ncRNA") zoom <- 0.875
    if(tx == "noncoding-non-collapsed") zoom <- 0.525
    if(tx == "noncoding-collapsed") zoom <- 0.525
    if(tx %in% c("Trinity-G1", "Trinity-Q")) zoom <- 0.95
} else if(samples %in% c("r6n", "Rrp6∆.timecourse-G1-Q.SS")) {
    if(tx == "coding-non-pa-ncRNA") zoom <- 0.90
    if(tx == "noncoding-non-collapsed") zoom <- 0.45
    if(tx == "noncoding-collapsed") zoom <- 0.45
    if(tx %in% c("Trinity-G1", "Trinity-Q")) zoom <- 0.95
} else if(samples == "r6n_timecourse") {
    if(tx == "coding-non-pa-ncRNA") zoom <- 0.90
    if(tx == "noncoding-non-collapsed") zoom <- 0.35
    if(tx == "noncoding-collapsed") zoom <- 0.35
    if(tx %in% c("Trinity-G1", "Trinity-Q")) zoom <- 0.95
}

#  Draw mean proportional bar plots with error bars
run <- TRUE
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
            ylab("mean proportion") +
            scale_x_discrete(guide = guide_axis(angle = 45)) +
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
            ylab("mean proportion") +
            scale_x_discrete(guide = guide_axis(angle = 45)) +
            theme_slick
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
            ylab("mean proportion") +
            scale_x_discrete(guide = guide_axis(angle = 45)) +
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
            ylab("mean proportion") +
            scale_x_discrete(guide = guide_axis(angle = 45)) +
            theme_slick
}

#  Checks
run <- TRUE
if(base::isTRUE(run)) {
    `prop-plot_individual-replicates` %>% print()
    `prop-plot_w-error_full` %>% print()
    `prop-plot_w-error_zoom` %>% print()
    # `prop-plot_no-error_full` %>% print()
    # `prop-plot_no-error_zoom` %>% print()
}


#  Individual replicates ----------------------------------
width <- 12  #ARGUMENT
height <- 7  #ARGUMENT

part_1 <- unlist(stringr::str_split(
    deparse(substitute(`prop-plot_individual-replicates`)), "_"
))[1]
part_2 <- samples
part_3 <- tx
part_4 <- unlist(stringr::str_split(
    deparse(substitute(`prop-plot_individual-replicates`)), "_"
))[2]
file_prefix <- paste(part_1, part_2, part_3, part_4, sep = "_")
outpath <- getwd()  #ARGUMENT
outfile <- paste0(
    outpath, "/",
    file_prefix,
    # ".", format(Sys.time(), format = "%F_%H.%M.%S"),
    ".pdf"
)

pdf(file = outfile, width = width, height = height)
print(`prop-plot_individual-replicates` + theme_AG_boxed)
dev.off()


#  Averaged replicates, full ------------------------------
width <- 9  #ARGUMENT
height <- 7  #ARGUMENT

part_1 <- unlist(stringr::str_split(
    deparse(substitute(`prop-plot_w-error_full`)), "_"
))[1]
part_2 <- samples
part_3 <- tx
part_4 <- unlist(stringr::str_split(
    deparse(substitute(`prop-plot_w-error_full`)), "_"
))[2]
file_prefix <- paste(part_1, part_2, part_3, part_4, sep = "_")
outpath <- getwd()  #ARGUMENT
outfile <- paste0(
    outpath, "/",
    file_prefix,
    # ".", format(Sys.time(), format = "%F_%H.%M.%S"),
    ".pdf"
)

pdf(file = outfile, width = width, height = height)
print(`prop-plot_w-error_full` + theme_AG_boxed)
dev.off()


#  Averaged replicates, zoomed ----------------------------
width <- 9  #ARGUMENT
height <- 7  #ARGUMENT

part_1 <- unlist(stringr::str_split(
    deparse(substitute(`prop-plot_w-error_zoom`)), "_"
))[1]
part_2 <- samples
part_3 <- tx
part_4 <- unlist(stringr::str_split(
    deparse(substitute(`prop-plot_w-error_zoom`)), "_"
))[-1] %>%
    paste(., collapse = "_")
file_prefix <- paste(part_1, part_2, part_3, part_4, sep = "_")
outpath <- getwd()  #ARGUMENT
outfile <- paste0(
    outpath, "/",
    file_prefix, 
    # ".", format(Sys.time(), format = "%F_%H.%M.%S"),
    ".pdf"
)

pdf(file = outfile, width = width, height = height)
print(`prop-plot_w-error_zoom` + theme_AG_boxed)
dev.off()


#TODO
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
