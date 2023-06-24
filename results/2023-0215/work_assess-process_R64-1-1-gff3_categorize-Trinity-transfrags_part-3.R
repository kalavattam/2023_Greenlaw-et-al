#!/usr/bin/env Rscript

#  work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-3.R
#  KA

#  Script for identification of "wholly unique" transfrags: those that do not
#+ overlap "previously annotated ncRNAs" (e.g., CUTs, XUTs, NUTs, etc.)


#  Get situated ---------------------------------------------------------------
suppressMessages(library(GenomicRanges))
suppressMessages(library(IRanges))
suppressMessages(library(plyr))
suppressMessages(library(readxl))
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


calculate_percent_overlap <- function(x_start, x_end, y_start, y_end) {
    x_length <- abs((x_end + 1) - x_start)
    
    #  Determine "largest" start
    max_start <- max(c(
        x_start, y_start
    ))
    
    #  Determine "smallest" end
    min_end <- min(c(
        (x_end + 1), (y_end + 1)
    ))
    
    overlap <- ifelse(
        (min_end - max_start) <= 0, 0, (min_end - max_start)
    )
    
    percent_overlap <- ((overlap / x_length) * 100)
    
    return(percent_overlap)
}


make_simple_df <- function(df_Tr) {
    tbl <- tibble::tibble(
        seqnames = df_Tr$seqnames,
        start = df_Tr$start,
        end = df_Tr$end,
        strand = df_Tr$strand,
        feature = df_Tr$id,
        assignment = df_Tr$assignment_detailed,
        R64 = df_Tr$detailed_easy
    )
    
    return(tbl)
}


analyze_feature_intersections <- function(
    overlap_Tr_v_ncRNA = overlap_Q_v_ncRNA,
    s_Tr = s_Q,
    s_ncRNA = s_ncRNA
) {
    #  Create a tibble of overlapping features --------------------------------
    #+ ...in "gtf_Tr" overlapping features in "gtf_all"
    wrt_Tr_ncRNA <- dplyr::bind_cols(
        s_Tr[queryHits(overlap_Tr_v_ncRNA), ],
        s_ncRNA[subjectHits(overlap_Tr_v_ncRNA), ]
    ) %>% dplyr::rename(
            seqnames = seqnames...1,
            start = start...2,
            end = end...3,
            strand = strand...4,
            feature = feature...5,
            seqnames_ncRNA = seqnames...8,
            start_ncRNA = start...9,
            end_ncRNA = end...10,
            strand_ncRNA = strand...11,
            feature_ncRNA = feature...12
        )
    
    #  For any rows that overlap after stratifying for 'chr' and 'strand', then 
    #+ organize said rows into groups
    wrt_Tr_ncRNA_group <- plyr::ddply(
        wrt_Tr_ncRNA,
        c("seqnames", "strand"),
        function(x) { 
            #  Check if a record should be linked with the previous record
            y <- c(NA, x$end[-nrow(x)])
            z <- ifelse(is.na(y), 0, y)
            z <- cummax(z)
            z[is.na(y)] <- NA
            x$previous_end <- z
            
            return(x)
        }
    )
    wrt_Tr_ncRNA_group <- wrt_Tr_ncRNA_group %>%
        dplyr::relocate(c(start_ncRNA, end_ncRNA), .after = end)
    wrt_Tr_ncRNA_group$new_group <-
        is.na(wrt_Tr_ncRNA_group$previous_end) | 
            (
                wrt_Tr_ncRNA_group$start >=
                wrt_Tr_ncRNA_group$previous_end
            )
    wrt_Tr_ncRNA_group$group <- cumsum(wrt_Tr_ncRNA_group$new_group)
    wrt_Tr_ncRNA_group <- wrt_Tr_ncRNA_group %>%
        dplyr::mutate(type_id_ncRNA = paste0(ncRNA, ": ", feature_ncRNA))
    
    
    #  Calculate pct. overlaps ------------------------------------------------
    #+ ...between "Q" or "G1" and "all" features, and vice versa 
    wrt_Tr_ncRNA_group$pct_Tr_over_ncRNA <- mapply(
        calculate_percent_overlap,
        wrt_Tr_ncRNA_group$start,
        wrt_Tr_ncRNA_group$end,
        wrt_Tr_ncRNA_group$start_ncRNA,
        wrt_Tr_ncRNA_group$end_ncRNA
    )
    wrt_Tr_ncRNA_group$pct_ncRNA_over_Tr <- mapply(
        calculate_percent_overlap,
        wrt_Tr_ncRNA_group$start_ncRNA,
        wrt_Tr_ncRNA_group$end_ncRNA,
        wrt_Tr_ncRNA_group$start,
        wrt_Tr_ncRNA_group$end
    )
    wrt_Tr_ncRNA_group <- wrt_Tr_ncRNA_group %>%
        dplyr::relocate(
            c(pct_Tr_over_ncRNA, pct_ncRNA_over_Tr, type_id_ncRNA, group),
            .after = end_ncRNA
        )
    
    
    #  Aggregate the data -----------------------------------------------------
    colnames(wrt_Tr_ncRNA_group)
    
    wrt_Tr_ncRNA_agg <- plyr::ddply(
        wrt_Tr_ncRNA_group,
        .(seqnames, strand, group),
        plyr::summarize, 
        start = min(start),
        end = max(end),
        width = (end - start) + 1,
        feature = paste0(feature, collapse = ", "),
        assignment = paste0(assignment, collapse = ", "),
        R64 = paste0(R64, collapse = ", "),
        feature_ncRNA = paste0(feature_ncRNA, collapse = " "),
        category = paste0(ncRNA, collapse = ", "),
        complete = paste0(type_id_ncRNA, collapse = ", "),
        pct_Tr_over_ncRNA = paste0(round(pct_Tr_over_ncRNA, 2), collapse = ", "),
        pct_ncRNA_over_Tr = paste0(round(pct_ncRNA_over_Tr, 2), collapse = ", ")
    ) %>%
        dplyr::select(-group) %>%
        dplyr::arrange(seqnames, start, strand) %>%
        dplyr::relocate(
            c(seqnames, start, end, width, strand), .before = feature
        ) %>%
        dplyr::mutate(
            n_features = stringr::str_count(complete, "\\:\ ")
        ) %>%
        tibble::as_tibble()
    
    #  Collapse redundant strings in cells of column "feature"
    wrt_Tr_ncRNA_agg$feature <- vapply(
        stringr::str_split(wrt_Tr_ncRNA_agg$feature, ", "),
        `[`,
        1,
        FUN.VALUE = character(1)
    )
    
    wrt_Tr_ncRNA_agg$assignment <- vapply(
        stringr::str_split(wrt_Tr_ncRNA_agg$assignment, ", "),
        `[`,
        1,
        FUN.VALUE = character(1)
    )
    
    wrt_Tr_not_ncRNA_agg <- s_Tr[s_Tr$feature %notin% wrt_Tr_ncRNA_agg$feature, ]
    
    
    #  Return the various data objects ----------------------------------------
    list_return <- list()
    list_return[["wrt_Tr_ncRNA"]] <- wrt_Tr_ncRNA
    list_return[["wrt_Tr_ncRNA_group"]] <- wrt_Tr_ncRNA_group
    list_return[["wrt_Tr_ncRNA_agg"]] <- wrt_Tr_ncRNA_agg
    list_return[["wrt_Tr_not_ncRNA_agg"]] <- wrt_Tr_not_ncRNA_agg
    
    return(list_return)
}


#  Load dataframes of Trinity putative transcripts ----------------------------
#+ (dataframes were generated in part-2 of series of scripts)
p_main <- "outfiles_gtf-gff3"

#  Load Trinity Q dataframe
p_Q <- paste(p_main, "Trinity-GG/Q_N/filtered/locus", sep = "/")
f_Q <- "dataframe_Trinity-assignments_Q.tsv"
df_Q <- readr::read_tsv(paste(p_Q, f_Q, sep = "/"), show_col_types = FALSE)

#  Load Trinity G1 dataframe
p_G1 <- paste(p_main, "Trinity-GG/G_N/filtered/locus", sep = "/")
f_G1 <- "dataframe_Trinity-assignments_G1.tsv"
df_G1 <- readr::read_tsv(paste(p_G1, f_G1, sep = "/"), show_col_types = FALSE)

#  Load pa-ncRNA gtf
p_ncRNA <- paste(p_main, "representation", sep = "/")
f_ncRNA <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
gtf_ncRNA <- rtracklayer::import(paste(p_ncRNA, f_ncRNA, sep = "/")) %>%
    tibble::as_tibble() %>%
    dplyr::select(-c(phase, score)) %>%
    dplyr::arrange(seqnames, start, strand)

rm(p_Q, f_Q, p_G1, f_G1, p_ncRNA, f_ncRNA)


#  Evaluate overlaps between custom-detected and R64 features -----------------
#  Generate "simplified" (s) dataframes
s_Q <- make_simple_df(df_Q)
s_Q <- s_Q[
    s_Q$assignment %in%
    c("noncoding: novel, antisense", "noncoding: novel, intergenic"), 
]

s_G1 <- make_simple_df(df_G1)
s_G1 <- s_G1[
    s_G1$assignment %in%
    c("noncoding: novel, antisense", "noncoding: novel, intergenic"), 
]

s_ncRNA <- gtf_ncRNA %>%
    dplyr::select(-c(
        width, source, type, transcript_id, details_type, details_id,
        details_all, n_types, n_features, n_types_features, length
    )) %>%
    dplyr::rename(
        feature = gene_id,
        ncRNA = details_type_alpha
    )

#  Identify the overlaps after initializing necessary variables
g_Q <- makeGRangesFromDataFrame(s_Q, keep.extra.columns = TRUE)
g_G1 <- makeGRangesFromDataFrame(s_G1, keep.extra.columns = TRUE)
g_ncRNA <- makeGRangesFromDataFrame(gtf_ncRNA, keep.extra.columns = TRUE)

run <- TRUE
if(base::isTRUE(run)) {
    g_Q %>% as.data.frame() %>% head() %>% print()
    cat("\n")
    
    g_G1 %>% as.data.frame() %>% head() %>% print()
    cat("\n")
    
    g_ncRNA %>% as.data.frame() %>% head() %>% print()
    cat("\n")
}

overlap_Q_v_ncRNA <- IRanges::findOverlaps(g_Q, g_ncRNA)
overlap_G1_v_ncRNA <- IRanges::findOverlaps(g_G1, g_ncRNA)

analyses_Q <- analyze_feature_intersections(
    overlap_Tr_v_ncRNA = overlap_Q_v_ncRNA,
    s_Tr = s_Q,
    s_ncRNA = s_ncRNA
)
agg_Q <- analyses_Q$wrt_Tr_ncRNA_agg
uniq_Q <- analyses_Q$wrt_Tr_not_ncRNA_agg

analyses_G1 <- analyze_feature_intersections(
    overlap_Tr_v_ncRNA = overlap_G1_v_ncRNA,
    s_Tr = s_G1,
    s_ncRNA = s_ncRNA
)
agg_G1 <- analyses_G1$wrt_Tr_ncRNA_agg
uniq_G1 <- analyses_G1$wrt_Tr_not_ncRNA_agg

run <- FALSE
if(base::isTRUE(run)) {
    agg_Q %>%
        readr::write_tsv(paste(
            getwd(),
            "Trinity_putative-transcripts.2023-0620.overlap-pa-ncRNA.Q.tsv",
            sep = "/"
        ))
    uniq_Q %>%
        readr::write_tsv(paste(
            getwd(),
            "Trinity_putative-transcripts.2023-0620.unique.Q.tsv",
            sep = "/"
        ))
    agg_G1 %>%
        readr::write_tsv(paste(
            getwd(),
            "Trinity_putative-transcripts.2023-0620.overlap-pa-ncRNA.G1.tsv",
            sep = "/"
        ))
    uniq_G1 %>%
        readr::write_tsv(paste(
            getwd(),
            "Trinity_putative-transcripts.2023-0620.unique.G1.tsv",
            sep = "/"
        ))
}
