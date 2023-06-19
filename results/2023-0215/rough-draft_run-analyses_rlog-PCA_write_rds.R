#!/usr/bin/env Rscript

#  rough-draft_run-analyses_rlog-PCA_write_rds.R
#  KA


#  Load libraries, set options ================================================
suppressMessages(library(DESeq2))
suppressMessages(library(PCAtools))
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
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
    
    #  Debug
    run <- FALSE
    if(base::isTRUE(run)) {
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
        panel.border = element_rect(colour = "black", fill = NA, size = 2)
    )

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")

theme_AG_no_legend <- theme_AG + theme(legend.position = "none")

theme_AG_boxed_no_legend <- theme_AG_boxed + theme(legend.position = "none")


#  Get situated, load counts matrix ===========================================
p_base <- "/Users/kalavatt/projects-etc"
p_exp <- "2022_transcriptome-construction/results/2023-0215"

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

#IMPORTANT
#  Determine mRNA counts matrix to work with, then load it
#+ Options: "mRNA" "pa-ncRNA" "Trinity-Q" "Trinity-G1" "representation"
# type <- "mRNA"  #ARGUMENT
type <- "pa-ncRNA"  #ARGUMENT
# type <- "Trinity-Q"  #ARGUMENT
# type <- "Trinity-G1"  #ARGUMENT
# type <- "representation"  #ARGUMENT

#  Check on "type" option
if(base::isTRUE(type %notin% c(
    "mRNA", "pa-ncRNA", "Trinity-Q", "Trinity-G1", "representation"
))) {
    stop(paste(
        "Variable \"type\" must be \"mRNA\", \"pa-ncRNA\",",
        "\"Trinity-Q\", \"Trinity-G1\", \"representation\""
    ))
}

#  Load counts matrix
if(type == "mRNA") {
    p_cm <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
    f_cm <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
    
    p_gtf <- "infiles_gtf-gff3/already"
    f_gtf <- "combined_SC_KL_20S.gff3"
} else if(type == "pa-ncRNA") {
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "representative-non-coding-transcriptome.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/representation"
    f_gtf <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
} else if(type == "Trinity-Q") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus"
    f_cm <- "Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
    f_gtf <- "Q_mkc-4_gte-pctl-25.clean.gtf"
} else if(type == "Trinity-G1") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/G_N/filtered/locus"
    f_cm <- "G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
    f_gtf <- "G1_mkc-4_gte-pctl-25.clean.gtf"
} else if(type == "representation") {
    #TODO p_cm <- "outfiles_htseq-count/comprehensive/..."
    #TODO f_cm <- "..."
    
    p_gtf <- "processed_features-intergenic_sense-antisense.gtf"
    f_gtf <- "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203"
}


#  Read in htseq-count counts matrix ------------------------------------------
#  Check that counts matrix exists
run <- FALSE
if(base::isTRUE(run)) {
    paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        file.exists()  # [1] TRUE
}

if(type == "mRNA") {
    t_cm <- paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE) %>%
        dplyr::slice(-1)  # Slice out the first row, which contains file info
} else {
    t_cm <- paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE)
}

#  "Clean up" counts matrix column names and "features" elements
if(base::isTRUE(type == "mRNA")) {
    colnames(t_cm) <- colnames(t_cm) %>%
        gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .)
} else {
    colnames(t_cm)[1] <- "features"
    colnames(t_cm) <- colnames(t_cm) %>%
        gsub("bams_renamed/UT_prim_UMI/", "", .) %>%
        gsub(".UT_prim_UMI.bam", "", .)
}

if(type == "mRNA") {
    t_cm <- t_cm %>%
        dplyr::mutate(
            features = features %>%
                gsub("^transcript\\:", "", .) %>%
                gsub("_mRNA", "", .)
        )
}

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
if(type == "mRNA") {
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
} else {
    t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
        rtracklayer::import() %>%
        as.data.frame() %>%
        dplyr::as_tibble() %>%
        dplyr::select(-c(score, phase))
}

#  Subset gff3 tibble to keep only relevant columns
if(type == "mRNA") {
    keep <- c(
        "chr", "start", "end",
        "width", "strand", "type",
        "features", "biotype", "names"
    )
    t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]
} else if(type == "pa-ncRNA") {
    keep <- c(
        "seqnames", "start", "end",
        "width", "strand", "type",
        "gene_id", "details_type_alpha", "details_all"
    )
    t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]
    t_gtf <- t_gtf %>%
        dplyr::rename(
            "chr" = "seqnames",
            "features" = "gene_id",
            "biotype" = "details_type_alpha",
            "names" = "details_all"
        )
}
rm(keep)

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
t_mat <- t_mat %>%
    dplyr::relocate(thorough, .after = names)

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
            t_mat$chr %in% chr_20S,
            "20S",
            NA
        )
    )
) %>%
    as.factor()
t_mat <- t_mat %>% dplyr::relocate(genome, .before = chr)

#  Remove unneeded variables again
rm(chr_20S, chr_KL, chr_SC, chr_order)


#  Extract htseq-count summary metrics from t_mat -----------------------------
#  They are at the end of the matrices and have names that begin with two
#+ underscore characters
underscore <- t_mat[stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), ]


#  Exclude htseq-count summary metrics from t_mat -----------------------------
t_mat <- t_mat[!stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), ]

run <- FALSE
if(base::isTRUE(run)) t_mat %>% tail(10)


#  Subset t_mat to include counts only for samples of interest ----------------
run <- TRUE
if(base::isTRUE(run)) {
    t_mat.bak <- t_mat
    # t_mat <- t_mat.bak
}

samples <- "Ovation"  #ARGUMENT
if(samples %notin% c("Ovation")) {
    stop(paste("Variable \"samples\" must be \"Ovation\""))
}

if(samples == "Ovation") {
    tmp_A <- t_mat[, 1:11]
    tmp_B <- t_mat[, 12:ncol(t_mat)]
    tmp_C <- tmp_B[, stringr::str_detect(colnames(tmp_B), "ovn")]
    t_mat <- dplyr::bind_cols(tmp_A, tmp_C)
    
    rm(list = ls(pattern = "tmp_"))
}


#  Make a dds object from t_mat ===============================================
#  Make a metadata matrix for DESeq2, etc.
t_meta <- colnames(t_tc)[11:ncol(t_tc)] %>%
    stringr::str_split("_") %>%
    as.data.frame() %>%
    t() %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    dplyr::rename(
        genotype = ...1, time = ...2, replicate = ...3, technical = ...4
    ) %>%
    dplyr::mutate(rownames = colnames(t_tc)[11:ncol(t_tc)]) %>%
    tibble::column_to_rownames("rownames") %>%  # DESeq2 requires rownames
    dplyr::mutate(
        genotype = factor(genotype, level = c("WT", "r6n")),
        no_genotype = sapply(
            as.character(genotype),
            switch,
            "WT" = 0,
            "r6n" = 1,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        time = factor(time, levels = c("DSm2", "DSp2", "DSp24", "DSp48")),
        no_time = sapply(
            as.character(time),
            switch,
            "DSm2" = 0,
            "DSp2" = 1,
            "DSp24" = 2,
            "DSp48" = 3,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        replicate = factor(replicate, levels = c("rep1", "rep2")),
        no_replicate = sapply(
            as.character(replicate),
            switch,
            "rep1" = 0,
            "rep2" = 1,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        technical = factor(technical, levels = c("tech1", "tech2")),
        no_technical = sapply(
            as.character(technical),
            switch,
            "tech1" = 0,
            "tech2" = 1,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        intermediate = ifelse(
            stringr::str_detect(rownames(.), "DSp2|DSp24"),
            "yes",
            "no"
        ) %>%
            as.factor(),
        no_intermediate = sapply(
            as.character(intermediate),
            switch,
            "yes" = 0,
            "no" = 1,
            USE.NAMES = FALSE
        ) %>%
            as.factor()
    ) %>%
    dplyr::relocate(intermediate, .after = technical)


#  Make a GRanges object for positional information for DESeq2, etc.
g_pos <- GenomicRanges::GRanges(
    seqnames = t_tc$chr,
    ranges = IRanges::IRanges(t_tc$start, t_tc$end),
    strand = t_tc$strand,
    length = t_tc$width,
    type = t_tc$type,
    features = t_tc$features,
    biotype = t_tc$biotype,
    names = t_tc$names,
    genome = t_tc$genome
)
g_pos

#  Make a counts matrix for DESeq2, etc.
t_counts <- t_tc[, 11:ncol(t_tc)] %>%
    sapply(., as.integer) %>%
    as.data.frame()

#  Make the dds object; however, don't do any modeling yet
dds <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts,
    colData = t_meta,
    # design = ~1,
    design = ~ technical + genotype,
    rowRanges = g_pos
)

#  Do size-factor estimation using K. lactis control genes
dds <- BiocGenerics::estimateSizeFactors(
    # dds[dds@rowRanges$genome == "K_lactis", ]
    dds,
    controlGenes = (dds@rowRanges$genome == "K_lactis")
)
dds$sizeFactor %>% as.data.frame()
# WT_DSm2_rep1_tech1   0.5682074
# WT_DSm2_rep2_tech1   0.4368905
# WT_DSp2_rep1_tech1   0.8104658
# WT_DSp2_rep2_tech1   0.8467238
# WT_DSp24_rep1_tech1  1.2374142
# WT_DSp24_rep2_tech1  1.2660357
# WT_DSp48_rep1_tech1  1.6936618
# WT_DSp48_rep1_tech2  1.7414215
# WT_DSp48_rep2_tech1  1.2492546
# r6n_DSm2_rep1_tech1  0.6313840
# r6n_DSm2_rep2_tech1  0.7714148
# r6n_DSp2_rep1_tech1  0.9944856
# r6n_DSp2_rep2_tech1  1.0158238
# r6n_DSp24_rep1_tech1 0.8680379
# r6n_DSp24_rep2_tech1 1.2141282
# r6n_DSp48_rep1_tech1 1.4169173
# r6n_DSp48_rep2_tech2 1.4839146

#  And the reciprocal...
(1 / dds$sizeFactor) %>% as.data.frame()
# WT_DSm2_rep1_tech1   1.7599208
# WT_DSm2_rep2_tech1   2.2889032
# WT_DSp2_rep1_tech1   1.2338584
# WT_DSp2_rep2_tech1   1.1810227
# WT_DSp24_rep1_tech1  0.8081369
# WT_DSp24_rep2_tech1  0.7898672
# WT_DSp48_rep1_tech1  0.5904367
# WT_DSp48_rep1_tech2  0.5742435
# WT_DSp48_rep2_tech1  0.8004773
# r6n_DSm2_rep1_tech1  1.5838222
# r6n_DSm2_rep2_tech1  1.2963194
# r6n_DSp2_rep1_tech1  1.0055450
# r6n_DSp2_rep2_tech1  0.9844227
# r6n_DSp24_rep1_tech1 1.1520234
# r6n_DSp24_rep2_tech1 0.8236362
# r6n_DSp48_rep1_tech1 0.7057575
# r6n_DSp48_rep2_tech2 0.6738932
