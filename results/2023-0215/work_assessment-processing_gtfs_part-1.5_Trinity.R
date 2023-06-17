#!/usr/bin/env Rscript

#  work_assessment-processing_gtfs_part-1.5_Trinity.R
#  KA

#  Goal: Clean up custom Trinity-derived transcriptome annotations 
#+ 
#+ Tasks performed by this script
#+ 1. Remove Mito features from selected "G1_mkc-4_gte-pctl-25.gtf" and
#+    "Q_mkc-4_gte-pctl-25.gtf" custom transcriptome annotations
#+ 2. In "G1_mkc-4_gte-pctl-25.gtf", there is one autosomal features that
#+    failed GffRead-collapse into a greater feature: It needs to be removed;
#+    essentially, remove it by removing any feature not in the corresponding
#+    dataframe (see task #3 below)
#+ 3. Add to the transcriptome annotations appropriate information in the
#+    dataframes, which were generated with script
#+    "work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-2.R"
#+ 
#+ Once the above tasks are completed, use the "cleaned" gtfs to run htseq-
#+ count via "work_assessment-processing_gtfs_part-2_Trinity.md"


#  Get situated ---------------------------------------------------------------
suppressMessages(library(rtracklayer))
suppressMessages(library(tidyverse))

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
`%notin%` <- Negate(`%in%`)


filter_gtf <- function(gtf, df) {
    gtf_filt <- gtf[gtf$id %in% df$id, ]
    return(gtf_filt)
}


join_dataframe_info <- function(gtf, df) {
    gtf_join <- dplyr::full_join(
        gtf,
        df[, c(6, 8:10, 13, 16:18, 21)],
        by = "id"
    )
    return(gtf_join)
}


format_as_gtf <- function(tbl) {
    gtf <- tbl %>%
        dplyr::rename(feature = type) %>%
        dplyr::mutate(
            score = ".",
            frame = "."
        ) %>%
        dplyr::relocate(
            c("source", "feature", "start", "end", "score", "strand", "frame"),
            .after = seqnames
        ) %>%
        dplyr::mutate(
            attribute = paste(
                paste0("locus_id \"", id, "\""),
                paste0("gene_id \"", gene_id, "\""),
                paste0("transcript_id \"", transcript_id, "\""),
                paste0("type \"", assignment, "\""),
                paste0("type_detailed \"", assignment_detailed, "\""),
                paste0("category \"", category_abbrev, "\""),
                paste0("category_detailed \"", category_easy, "\""),
                paste0(
                    "category_full \"",
                    stringr::str_replace_all(complete, ";", ","),
                    "\""
                ),
                paste0("pct_Tr_over_all \"", pct_Tr_over_all, "\""),
                paste0("pct_all_over_Tr \"", pct_all_over_Tr, "\""),
                paste0("n_features \"", n_features, "\""),
                paste0("locus_source \"", locus_source, "\""),
                paste0("gene_source \"", gene_source, "\""),
                paste0("transcript_source \"", transcript_source, "\""),
                sep = "; "
            )
        ) %>%
        dplyr::select(-c(
            id, gene_id, transcript_id, assignment, assignment_detailed,
            category_abbrev, category_easy, complete, pct_Tr_over_all,
            pct_all_over_Tr, n_features, locus_source, gene_source,
            transcript_source
        ))
    
    return(gtf)
}


write_gtf <- function(x, y) {
    # ...
    # :param x: tibble
    # :param y: outfile
    # :return: NA
    readr::write_tsv(
        x,
        y,
        col_names = FALSE,
        quote = "none",
        escape = "none"
    )
}


#  Load and process gtfs, dataframes ------------------------------------------
p_gtf <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
f_gtf <- "G1_mkc-4_gte-pctl-25.gtf"
f_df <- "dataframe_Trinity-assignments_G1.tsv"
gtf_G1 <- paste(p_gtf, f_gtf, sep = "/") %>%
    rtracklayer::import() %>%
    tibble::as_tibble() %>%
    dplyr::arrange(seqnames, start) %>%
    dplyr::select(-c(width, score, phase))
df_G1 <- readr::read_tsv(paste(p_gtf, f_df, sep = "/"), show_col_types = FALSE)

p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
f_gtf <- "Q_mkc-4_gte-pctl-25.gtf"
f_df <- "dataframe_Trinity-assignments_Q.tsv"
gtf_Q <- paste(p_gtf, f_gtf, sep = "/") %>%
    rtracklayer::import() %>%
    tibble::as_tibble() %>%
    dplyr::arrange(seqnames, start) %>%
    dplyr::select(-c(width, score, phase))
df_Q <- readr::read_tsv(paste(p_gtf, f_df, sep = "/"), show_col_types = FALSE)

rm(p_gtf, f_gtf, f_df)


#  Remove Mito and other unneeded features ------------------------------------
filt_G1 <- filter_gtf(gtf_G1, df_G1)
filt_Q <- filter_gtf(gtf_Q, df_Q)

join_G1 <- join_dataframe_info(filt_G1, df_G1)
join_Q <- join_dataframe_info(filt_Q, df_Q)


#  Write out gtfs -------------------------------------------------------------
final_G1 <- format_as_gtf(join_G1)
final_Q <- format_as_gtf(join_Q)

p_gtf <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
f_gtf <- "G1_mkc-4_gte-pctl-25.clean.gtf"
write_gtf(
    final_G1,
    paste(p_gtf, f_gtf, sep = "/")
)

p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
f_gtf <- "Q_mkc-4_gte-pctl-25.clean.gtf"
write_gtf(
    final_Q,
    paste(p_gtf, f_gtf, sep = "/")
)

rm(p_gtf, f_gtf)
