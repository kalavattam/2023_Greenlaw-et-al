#!/usr/bin/env Rscript

#  rough-draft_plot-distributions_expression.R
#  KA


#  Initialize arguments =======================================================
#TODO Parser
# type <- "mRNA"  #ARGUMENT
# type <- "pa-ncRNA"  #ARGUMENT
type <- "Trinity-Q"  #ARGUMENT
# type <- "Trinity-G1"  #ARGUMENT
# type <- "Trinity-Q-unique"  #ARGUMENT
# type <- "Trinity-G1-unique"  #ARGUMENT
# type <- "representation"  #TODO

samples <- "Ovation"  #ARGUMENT  #FIG1.5
# samples <- "test.Ovation_Rrp6∆"  #ARGUMENT  #TODO Remove
# samples <- "test.Ovation_Tecan"  #ARGUMENT  #TODO Remove
# samples <- "Rrp6∆.G1-Q.N-SS"  #ARGUMENT
# samples <- "Rrp6∆.G1-Q.SS"  #ARGUMENT
# samples <- "Rrp6∆.Q.N-SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse"  #ARGUMENT
# samples <- "Rrp6∆.timecourse-G1-Q.SS"  #ARGUMENT  #FIG5
# samples <- "Rrp6∆.timecourse-G1.SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse-G1-Q.N-SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse.G1-SS.Q-N"  #ARGUMENT
# samples <- "Nab3AID.Q.N-SS"  #ARGUMENT
# samples <- "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS"  #ARGUMENT
# samples <- "Nab3AID.Q.SS_Rrp6∆.Q.SS"
# samples <- "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"  #ARGUMENT

do_subsetting <- FALSE  #ARGUMENT


#  Load libraries, set options ================================================
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
if(stringr::str_detect(getwd(), "kalavattam")) {
    p_base <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_base <- "/Users/kalavatt/projects-etc"
}
p_exp <- "2022_transcriptome-construction/results/2023-0215"

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

#  Determine mRNA counts matrix to work with, then load it
#  Check on "type" option
if(base::isTRUE(type %notin% c(
    "mRNA", "pa-ncRNA", "Trinity-Q", "Trinity-G1", "Trinity-Q-unique",
    "Trinity-G1-unique", "representation"
))) {
    stop(paste(
        "Variable \"type\" must be \"mRNA\", \"pa-ncRNA\",",
        "\"Trinity-Q\", \"Trinity-G1\", \"Trinity-Q\", \"Trinity-G1\",",
        "\"representation\""
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
    
} else if(type == "Trinity-Q-unique") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus"
    f_cm <- "Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
    f_gtf <- "Q_mkc-4_gte-pctl-25.clean.gtf"
    
} else if(type == "Trinity-G1-unique") {
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
run <- TRUE
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
    
    if(stringr::str_detect(type, "unique")) {
        #  Load dataframe for custom annotations that do not overlap R64
        #+ annotations or pa-ncRNA collapsed/merged annotations:
        #+ "Trinity_putative-transcripts.2023-0620.unique"
        p_df <- "notebook/KA.2023-0620.Trinity_putative-transcripts.Q_G1"
        
        if(stringr::str_detect(type, "Q")) {
            f_df <- "Trinity_putative-transcripts.2023-0620.unique.Q.tsv"
        } else if(stringr::str_detect(type, "G1")) {
            f_df <- "Trinity_putative-transcripts.2023-0620.unique.G1.tsv"
        }            
        
        df <- readr::read_tsv(
            paste(p_df, f_df, sep = "/"), show_col_types = FALSE
        )
        
        #  Filter gtf to retain only "unique" custom annotations
        t_gtf <- t_gtf[t_gtf$locus_id %in% df$feature, ]
        t_cm <- t_cm[t_cm$features %in% df$feature, ]
        
        rm(p_df, f_df, df)
    }
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
} else if(stringr::str_detect(type, "Trinity")) {
    keep <- c(
        "seqnames", "start", "end",
        "width", "strand", "locus_id",
        "type_detailed", "category_detailed", "category_full"
    )
    t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]
    t_gtf <- t_gtf %>%
        dplyr::rename(
            "chr" = "seqnames",
            "type" = "category_detailed",
            "features" = "locus_id",
            "biotype" = "type_detailed",
            "names" = "category_full"
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

#  Give Trinity annotations cleaner, clearer names
if(stringr::str_detect(type, "Trinity")) {
    t_gtf$names <- t_gtf$names %>%
        stringr::str_remove_all("antisense_gene: |antisense_ncRNA: ") %>%
        stringr::str_remove_all("antisense_PG: |antisense_rRNA: |") %>%
        stringr::str_remove_all("antisense_snoRNA: |antisense_TE: |") %>%
        stringr::str_remove_all("antisense_tRNA: |ARS: |gene: ") %>%
        stringr::str_remove_all("intergenic: |ncRNA: |PE: |rRNA: |snRNA: ") %>%
        stringr::str_remove_all("snoRNA: |TE: |telomere: |tRNA: ") %>%
        stringr::str_remove_all("-[0-9]*\\b")
}


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


#  For analyses of non-"unique" feat., extract htseq-count summary metrics ----
if(!stringr::str_detect(type, "unique")) {
    #  They are at the end of the matrices and have names that begin with two
    #+ underscore characters
    underscore <- t_mat[
        stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), 
    ]

    #  Exclude htseq-count summary metrics from t_mat
    t_mat <- t_mat[!stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), ]
}

run <- FALSE
if(base::isTRUE(run)) t_mat %>% tail(10)


#  Subset t_mat to include counts only for samples of interest ----------------
run <- FALSE
if(base::isTRUE(run)) {
    t_mat.bak <- t_mat
    # t_mat <- t_mat.bak
    # colnames(t_mat)
}

if(samples %notin% c(
    "Ovation", "test.Ovation_Rrp6∆", "test.Ovation_Tecan", "Rrp6∆.G1-Q.N-SS",
    "Rrp6∆.G1-Q.SS", "Rrp6∆.Q.N-SS", "Rrp6∆.timecourse",
    "Rrp6∆.timecourse-G1-Q.SS", "Rrp6∆.timecourse-G1.SS",
    "Rrp6∆.timecourse-G1-Q.N-SS", "Rrp6∆.timecourse.G1-SS.Q-N",
    "Nab3AID.Q.N-SS", "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS",
    "Nab3AID.Q.SS_Rrp6∆.Q.SS", "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"
)) {
    stop(paste(
        "Variable \"samples\" must be \"Ovation\", \"test.Ovation_Rrp6∆\",",
        "\"test.Ovation_Tecan\", \"Rrp6∆.G1-Q.N-SS\", \"Rrp6∆.G1-Q.SS\",",
        "\"Rrp6∆.Q.N-SS\", \"Rrp6∆.timecourse\",",
        "\"Rrp6∆.timecourse-G1-Q.SS\", \"Rrp6∆.timecourse-G1.SS\",",
        "\"Rrp6∆.timecourse-G1-Q.N-SS\", \"Rrp6∆.timecourse.G1-SS.Q-N\",",
        "\"Nab3AID.Q.N-SS\", \"Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS\",",
        "\"Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS\""
    ))
}

tmp_A <- t_mat[, 1:11]
tmp_B <- t_mat[, 12:ncol(t_mat)]

if(samples == "Ovation") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn"
    )]
} else if(samples == "test.Ovation_Rrp6∆") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
} else if(samples == "test.Ovation_Tecan") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn|test"
    )] %>%
        dplyr::select(-WTovn_Q_SS_rep1_tech1)
} else if(samples == "Rrp6∆.G1-Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
} else if(samples == "Rrp6∆.G1-Q.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "r6n_Q|r6n_G1|WT_Q|WT_G1"
    )] 
    tmp_C <- tmp_C[, -grep("_N_", colnames(tmp_C))]
} else if(samples == "Rrp6∆.Q.N-SS") {
        tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "r6n_Q|WT_Q"
    )] 
} else if(samples == "Rrp6∆.timecourse") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp"
    )]
    tmp_C <- tmp_C[, -grep("t4n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("_N_|t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_G1|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("_N_|t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1-Q.N") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("_N_|t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1-Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse.G1-SS.Q-N") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("t4n|r1n|Q_SS", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od"
    )]
    tmp_C <- tmp_C[, -grep("rep3", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od|r6n_Q|WT_Q"
    )]
    tmp_C <- tmp_C[, -grep("rep3", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.SS_Rrp6∆.Q.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od|r6n_Q|WT_Q"
    )]
    tmp_C <- tmp_C[, -grep("rep3|_N_", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od|DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("t4n|r1n|rep3", colnames(tmp_C))]
}

t_mat <- dplyr::bind_cols(tmp_A, tmp_C)
rm(list = ls(pattern = "tmp_"))

# tmp <- dplyr::bind_cols(tmp_A, tmp_C)
# colnames(tmp)
# colnames(t_mat)


#  Make a TPM matrix --------------------------------------
#  Calculate counts per kb of feature length (i.e., correct counts for feature
#+ length with an "RPK normalization"); then, divide RPK-normalized elements by
#+ the sum of sample RPK divided by one million
rpk <- t_mat[, 12:ncol(t_mat)] / t_mat$width
tpm <- t((t(rpk) * 1e6) / colSums(rpk)) %>% tibble::as_tibble()

norm_t <- dplyr::bind_cols(t_mat[, 1:11], tpm)
rm(rpk, tpm)


#  Examine feature expression distributions ===================================
if(base::isTRUE(do_subsetting)) {
    df <- norm_t[, c(8, 12:ncol(norm_t))]
} else {
    df <- norm_t[, 12:ncol(norm_t)]
}

colnames(df) <- colnames(df) %>%
    gsub("ovn", "", .) %>%
    gsub("_tech1", "", .)

melt_t <- reshape2::melt(df)
melt_t$tx <- ifelse(stringr::str_detect(melt_t$variable, "SS"), "SS", "N")
melt_t$state <- ifelse(stringr::str_detect(melt_t$variable, "G1"), "G1", "Q")
melt_t$variable_meta <- ifelse(
    stringr::str_detect(melt_t$variable, "WT_Q_N"),
    "WT_Q_N",
    ifelse(
        stringr::str_detect(melt_t$variable, "WT_Q_SS"),
        "WT_Q_SS",
        ifelse(
            stringr::str_detect(melt_t$variable, "WT_G1_N"),
                "WT_G1_N",
                ifelse(
                    stringr::str_detect(melt_t$variable, "WT_G1_SS"),
                    "WT_G1_SS",
                    "#WARNING"
            )
        )
    )
)
if(base::isTRUE(do_subsetting)) melt_t$biotype <- as.factor(melt_t$biotype)

melt_t$variable <- factor(
    melt_t$variable,
    levels = c(
        "WT_Q_N_rep1", "WT_Q_N_rep2", "WT_Q_SS_rep1", "WT_Q_SS_rep2",
        "WT_G1_N_rep1", "WT_G1_N_rep2", "WT_G1_SS_rep1", "WT_G1_SS_rep2"
    )
)
melt_t <- melt_t %>% dplyr::arrange(variable)


if(base::isTRUE(do_subsetting)) {
    plot_dist_exp <- ggplot2::ggplot(
        melt_t, aes(x = variable, y = log2(value + 1))
    ) +
        geom_violin(aes(fill = biotype)) +
        geom_boxplot(
            aes(group = interaction(variable, biotype)),
            width = 0.2,
            fill = "#FFFFFF",
            position = position_dodge(width = 0.9)
        ) +
        {
            if(stringr::str_detect(type, "unique")) {
                scale_fill_manual(
                    breaks = c(
                        "noncoding: novel, intergenic",
                        "noncoding: novel, antisense"
                    ),
                    values = c("#768CD8", "#89CF95"),
                    labels = c("intergenic", "antisense")
                )
            } else {
                scale_fill_manual(
                    values = levels(melt_t$biotype) %>%
                        length() %>%
                        viridisLite::viridis()
                )
            }
        } +
        labs(x = "", y = "log2(TPM + 1)") +
        theme_AG_boxed +
        theme(
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
        )
} else {
    plot_dist_exp <- ggplot2::ggplot(
        melt_t,
        aes(x = variable, y = log2(value + 1), fill = variable_meta)
    ) +
        geom_violin() +
        geom_boxplot(width = 0.2, fill = "white") +
        labs(x = "", y = "log2(TPM + 1)") +
        scale_fill_manual(values = c(
            "#A0DA39", "#ECF7D7", "#277F8E", "#BED8DD"
        )) +
        # theme_slick +
        theme_AG_boxed_no_legend +
        theme(
            legend.position = "none",
            axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
        )
}

date <- "2023-0705"
width <- 7
height <- 7
filename <- paste(
    stringr::str_replace_all(deparse(substitute(plot_dist_exp)), "_", "-"),
    date,
    type,
    sep = "."
)

outfile <- paste0(getwd(), "/", filename, ".pdf")
pdf(file = outfile, width = width, height = height)
print(plot_dist_exp)
dev.off()
