#!/usr/bin/env Rscript

#  rough-draft_plot-distributions_length.R
#  KA


#  Initialize arguments =======================================================
#TODO Parser
# type <- "mRNA"  #ARGUMENT
# type <- "pa-ncRNA"  #ARGUMENT
type <- "Trinity-Q-G1"  #ARGUMENT
# type <- "Trinity-Q-G1_unique"  #ARGUMENT

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

# do_subsetting <- TRUE  #ARGUMENT
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
    "mRNA", "pa-ncRNA", "Trinity-Q-G1", "Trinity-Q-G1_unique"
))) {
    stop(paste(
        "Variable \"type\" must be \"mRNA\", \"pa-ncRNA\", \"Trinity-Q-G1\",",
        "\"Trinity-Q-G1_unique\""
    ))
}

#  Load counts matrix
if(type == "mRNA") {
    # p_cm <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
    # f_cm <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
    
    p_gtf <- "infiles_gtf-gff3/already"
    f_gtf <- "combined_SC_KL_20S.gff3"
} else if(type == "pa-ncRNA") {
    # p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    # f_cm <- "representative-non-coding-transcriptome.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/representation"
    f_gtf <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
} else if(type %in% c("Trinity-Q-G1", "Trinity-Q-G1_unique")) {
    # p_cm <- "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus"
    # f_cm_Q <- "Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    # f_cm_G1 <- "G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf_Q <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
    f_gtf_Q <- "Q_mkc-4_gte-pctl-25.clean.gtf"
    
    p_gtf_G1 <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
    f_gtf_G1 <- "G1_mkc-4_gte-pctl-25.clean.gtf"
}


#  Load gff3 or gtf files -----------------------------------------------------
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
} else if(type == "pa-ncRNA") {
    t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
        rtracklayer::import() %>%
        as.data.frame() %>%
        dplyr::as_tibble() %>%
        dplyr::select(-c(score, phase))
} else if(type %in% c("Trinity-Q-G1", "Trinity-Q-G1_unique")) {
    t_gtf_Q <- paste(p_gtf_Q, f_gtf_Q, sep = "/") %>%
        rtracklayer::import() %>%
        as.data.frame() %>%
        dplyr::as_tibble() %>%
        dplyr::select(-c(score, phase))
    
    t_gtf_G1 <- paste(p_gtf_G1, f_gtf_G1, sep = "/") %>%
        rtracklayer::import() %>%
        as.data.frame() %>%
        dplyr::as_tibble() %>%
        dplyr::select(-c(score, phase))
    
    if(stringr::str_detect(type, "unique")) {
        #  Load dataframe for custom annotations that do not overlap R64
        #+ annotations or pa-ncRNA collapsed/merged annotations:
        #+ "Trinity_putative-transcripts.2023-0620.unique"
        p_df <- "notebook/KA.2023-0620.Trinity_putative-transcripts.Q_G1"
        f_df_Q <- "Trinity_putative-transcripts.2023-0620.unique.Q.tsv"
        f_df_G1 <- "Trinity_putative-transcripts.2023-0620.unique.G1.tsv"
        
        df_Q <- readr::read_tsv(
            paste(p_df, f_df_Q, sep = "/"), show_col_types = FALSE
        )
        df_G1 <- readr::read_tsv(
            paste(p_df, f_df_G1, sep = "/"), show_col_types = FALSE
        )
        
        #  Filter gtf to retain only "unique" custom annotations
        t_gtf_Q <- t_gtf_Q[t_gtf_Q$locus_id %in% df_Q$feature, ]
        t_gtf_G1 <- t_gtf_G1[t_gtf_G1$locus_id %in% df_G1$feature, ]
        
        
        rm(p_df, f_df_Q, f_df_G1, df_Q, df_G1)
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
    t_gtf_Q <- t_gtf_Q[, colnames(t_gtf_Q) %in% keep]
    t_gtf_Q <- t_gtf_Q %>%
        dplyr::rename(
            "chr" = "seqnames",
            "type" = "category_detailed",
            "features" = "locus_id",
            "biotype" = "type_detailed",
            "names" = "category_full"
        )
    
    t_gtf_G1 <- t_gtf_G1[, colnames(t_gtf_G1) %in% keep]
    t_gtf_G1 <- t_gtf_G1 %>%
        dplyr::rename(
            "chr" = "seqnames",
            "type" = "category_detailed",
            "features" = "locus_id",
            "biotype" = "type_detailed",
            "names" = "category_full"
        )
}
rm(keep)

if(type %in% c("mRNA", "pa-ncRNA")) {
    #  Convert column names from list to character vector, and replace empty
    #+ fields with NA character values
    t_gtf$names <- ifelse(
        as.character(t_gtf$names) == "character(0)",
        NA_character_,
        as.character(t_gtf$names)
    )
} else {
    t_gtf_Q$names <- ifelse(
        as.character(t_gtf_Q$names) == "character(0)",
        NA_character_,
        as.character(t_gtf_Q$names)
    )
    t_gtf_G1$names <- ifelse(
        as.character(t_gtf_G1$names) == "character(0)",
        NA_character_,
        as.character(t_gtf_G1$names)
    )
}

#  Give Trinity annotations cleaner, clearer names
if(stringr::str_detect(type, "Trinity")) {
    t_gtf_Q$names <- t_gtf_Q$names %>%
        stringr::str_remove_all("antisense_gene: |antisense_ncRNA: ") %>%
        stringr::str_remove_all("antisense_PG: |antisense_rRNA: |") %>%
        stringr::str_remove_all("antisense_snoRNA: |antisense_TE: |") %>%
        stringr::str_remove_all("antisense_tRNA: |ARS: |gene: ") %>%
        stringr::str_remove_all("intergenic: |ncRNA: |PE: |rRNA: |snRNA: ") %>%
        stringr::str_remove_all("snoRNA: |TE: |telomere: |tRNA: ") %>%
        stringr::str_remove_all("-[0-9]*\\b")
    
    t_gtf_G1$names <- t_gtf_G1$names %>%
        stringr::str_remove_all("antisense_gene: |antisense_ncRNA: ") %>%
        stringr::str_remove_all("antisense_PG: |antisense_rRNA: |") %>%
        stringr::str_remove_all("antisense_snoRNA: |antisense_TE: |") %>%
        stringr::str_remove_all("antisense_tRNA: |ARS: |gene: ") %>%
        stringr::str_remove_all("intergenic: |ncRNA: |PE: |rRNA: |snRNA: ") %>%
        stringr::str_remove_all("snoRNA: |TE: |telomere: |tRNA: ") %>%
        stringr::str_remove_all("-[0-9]*\\b")
}


#  Examine feature length distributions =======================================
tmp_Q <- t_gtf_Q %>% dplyr::select(c(features, biotype, width))
tmp_Q$state <- "Q"

tmp_G1 <- t_gtf_G1 %>% dplyr::select(c(features, biotype, width))
tmp_G1$state <- "G1"

df_len <- dplyr::bind_rows(tmp_Q, tmp_G1)
rm(tmp_G1, tmp_Q)

df_len$biotype <- factor(df_len$biotype)
df_len$width <- df_len$width / 1000
df_len$state <- factor(df_len$state, levels = c("Q", "G1"))

if(base::isTRUE(do_subsetting)) {
    tally <- df_len %>%
        group_by(state, biotype) %>%
        summarize(count = n())

    plot_dist_len <- df_len %>%
        ggplot2::ggplot(aes(x = state, y = width)) +
        geom_violin(aes(fill = biotype)) +
        geom_boxplot(
            aes(group = interaction(state, biotype)),
            width = 0.2,
            fill = "#FFFFFF",
            position = position_dodge(width = 0.9),
            outlier.shape = NA
        ) +
        {
            if(stringr::str_detect(type, "unique")) {
                scale_fill_manual(
                    breaks = c(
                        "noncoding: novel, intergenic",
                        "noncoding: novel, antisense"
                    ),
                    values = c("#768CB8", "#89CF95")
                )
            } else {
                scale_fill_manual(
                    values = levels(df_len$biotype) %>%
                        length() %>%
                        viridisLite::viridis()
                )
            }
        } +
        labs(x = "", y = "feature length (kb)") +
        # geom_text(
        #     data = tally,
        #     aes(label = paste("n =", count)),
        #     y = max(df_len$width) + 0.4
        # ) +
        theme_AG_boxed
} else {
    df_len_tmp <- df_len
    if(stringr::str_detect(type, "unique")) {
        df_len_tmp$biotype <- "noncoding: novel"
        df_len_tmp$biotype <- factor(
            df_len_tmp$biotype,
            levels = "noncoding: novel"
        )
    } else {
        df_len_tmp$biotype <- ifelse(
            df_len$biotype %in% c(
                "noncoding: novel, antisense",
                "noncoding: novel, intergenic"
            ),
            "noncoding: novel",
            paste(df_len$biotype)
        )
        df_len_tmp$biotype <- factor(df_len_tmp$biotype)
    }
    tally <- df_len_tmp %>%
        group_by(state, biotype) %>%
        summarize(count = n())
    
    plot_dist_len <- df_len_tmp %>%
        ggplot2::ggplot(aes(x = state, y = width)) +
        {
            if(stringr::str_detect(type, "unique")) {
                geom_violin(aes(fill = state))
            } else {
                geom_violin(aes(fill = biotype))
            }
        } +
        geom_boxplot(
            aes(group = interaction(state, biotype)),
            width = 0.2,
            fill = "#FFFFFF",
            position = position_dodge(width = 0.9),
            outlier.shape = NA
        ) +
        {
            if(stringr::str_detect(type, "unique")) {
                scale_fill_manual(
                    breaks = c("Q", "G1"),
                    values = c("#277F8E", "#A0DA39")
                )
            } else {
                scale_fill_manual(
                    values = levels(df_len_tmp$biotype) %>%
                        length() %>%
                        viridisLite::viridis()
                )
            }
        } +
        labs(x = "", y = "feature length (kb)") +
        # geom_text(
        #     data = tally,
        #     aes(label = paste("n =", count)),
        #     y = max(df_len_tmp$width) + 0.2
        # ) +
        {
            if(stringr::str_detect(type, "unique")) {
                theme_AG_boxed_no_legend
            } else {
                theme_AG_boxed
            }
        }
    
    plot_dist_len_comb <- df_len_tmp %>%
        ggplot2::ggplot(aes(x = state, y = width)) +
        geom_violin(aes(fill = state)) +
        geom_boxplot(
            aes(group = state),
            width = 0.2,
            fill = "#FFFFFF",
            position = position_dodge(width = 0.9),
            outlier.shape = NA
        ) +
        scale_fill_manual(
            breaks = c("Q", "G1"),
            values = c("#277F8E", "#A0DA39")
        ) +
        labs(x = "", y = "feature length (kb)") +
        theme_AG_boxed_no_legend
}

plot_dist_len
plot_dist_len_comb

#NOTE Manually wrote 7" by 7" pdfs with the RStudio plots panel
