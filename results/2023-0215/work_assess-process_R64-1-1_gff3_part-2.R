

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


percent_overlap <- function(x_start, x_end, y_start, y_end) {
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


analyze_feature_intersections <- function(
    overlap_Tr_v_all = overlap_Q_v_all,
    gtf_Tr = gtf_Q,
    gtf_all = gtf_all
) {
    #  Test
    run <- FALSE
    if(base::isTRUE(run)) {
        gtf_Tr <- gtf_Q
        # gtf_Tr <- gtf_G1
        # gtf_Tr <- gtf_all
        overlap_Tr_v_all <- overlap_Q_v_all
        # overlap_Tr_v_all <- overlap_G1_v_all
    }
    
    #  Create a tibble of overlapping features --------------------------------
    #+ ...in "gtf_Tr" overlapping features in "gtf_all"
    wrt_Tr_all <- dplyr::bind_cols(
        gtf_Tr[queryHits(overlap_Tr_v_all), ],
        gtf_all[subjectHits(overlap_Tr_v_all), ]
    ) %>% dplyr::rename(
            seqnames = seqnames...1,
            start = start...2,
            end = end...3,
            width = width...4,
            strand = strand...5,
            source = source...6,
            type = type...7,
            gene_id = gene_id...9,
            transcript_id = transcript_id...10,
            seqnames_all = seqnames...14,
            start_all = start...15,
            end_all = end...16,
            width_all = width...17,
            strand_all = strand...18,
            source_all = source...19,
            type_all = type...20,
            gene_id_all = gene_id...21,
            transcript_id_all = transcript_id...22,
            category_all = type.1,
            orf_classification_all = orf_classification,
            source_id_all = source_id,
        )
    
    #  Cast dataframe types and alter names of ORF classifications
    wrt_Tr_all <- tibble::as_tibble(data.frame(
        lapply(wrt_Tr_all, function(x) gsub("^NA", NA_character_, x))
    ))
    
    wrt_Tr_all <- tibble::as_tibble(data.frame(lapply(
        wrt_Tr_all,
        function(x) gsub("Verified\\|silenced_gene", "verified", x)
    )))
    
    wrt_Tr_all <- tibble::as_tibble(data.frame(lapply(
        wrt_Tr_all,
        function(x) gsub("Dubious", "dubious", x)
    )))
    
    wrt_Tr_all <- tibble::as_tibble(data.frame(lapply(
        wrt_Tr_all,
        function(x) gsub("Verified", "verified", x)
    )))
    
    wrt_Tr_all <- tibble::as_tibble(data.frame(lapply(
        wrt_Tr_all,
        function(x) gsub("Uncharacterized", "uncharacterized", x)
    )))
    
    wrt_Tr_all$start <- as.numeric(wrt_Tr_all$start)
    wrt_Tr_all$end <- as.numeric(wrt_Tr_all$end)
    wrt_Tr_all$width <- as.numeric(wrt_Tr_all$width)
    wrt_Tr_all$start_all <- as.numeric(wrt_Tr_all$start_all)
    wrt_Tr_all$end_all <- as.numeric(wrt_Tr_all$end_all)
    wrt_Tr_all$width_all <- as.numeric(wrt_Tr_all$width_all)
    
    run <- FALSE
    if(base::isTRUE(run)) str(wrt_Tr_all)
    
    #  Clean up the names of ORF classifications
    index <-
        wrt_Tr_all$category_all == "antisense_gene" &
        wrt_Tr_all$orf_classification_all == "dubious"
    wrt_Tr_all[index, ]$orf_classification_all <- "antisense_dubious"
    
    index <-
        wrt_Tr_all$category_all == "antisense_gene" &
        wrt_Tr_all$orf_classification_all == "uncharacterized"
    wrt_Tr_all[index, ]$orf_classification_all <- "antisense_uncharacterized"
    
    index <-
        wrt_Tr_all$category_all == "antisense_gene" &
        wrt_Tr_all$orf_classification_all == "verified"
    wrt_Tr_all[index, ]$orf_classification_all <- "antisense_verified"
    
    rm(index)
    
    
    #  Check that all gtf_Tr "id" elements are found in the wrt_Tr_all "id" elements
    if(base::isFALSE(all(gtf_Tr$id %in% wrt_Tr_all$id))) {
        stop(paste(
            "Not all gtf_Tr$id %in% wrt_Tr_all$id. Stopping the script."
        ))
    }
    if(base::isFALSE(all(wrt_Tr_all$id %in% gtf_Tr$id))) {
        stop(paste(
            "Not all wrt_Tr_all$id %in% gtf_Tr$id. Stopping the script."
        ))
    }
    
    #  Add an additional "category_all" column, "detailed_all", that subsets the
    #+ "gene" category into ORF classifications
    wrt_Tr_all$detailed_all <- ifelse(
        wrt_Tr_all$category_all == "gene",
        wrt_Tr_all$orf_classification_all,
        ifelse(
            wrt_Tr_all$category_all == "antisense_gene",
            wrt_Tr_all$orf_classification_all,
            wrt_Tr_all$category_all
        )
    )
    wrt_Tr_all <- wrt_Tr_all %>%
        dplyr::relocate(detailed_all, .after = category_all)
    
    #  Create columns of categories that are a bit easier to read
    wrt_Tr_all$category_all_easy <- wrt_Tr_all$category_all %>%
        gsub("^antisense_gene", "AS (gene)", .) %>%
        gsub("^antisense_ncRNA", "AS (ncRNA)", .) %>%
        gsub("^antisense_PG", "AS (PG)", .) %>%
        gsub("^antisense_rRNA", "AS (rRNA)", .) %>%
        gsub("^antisense_snoRNA", "AS (snoRNA)", .) %>%
        gsub("^antisense_TE", "AS (TE)", .) %>%
        gsub("^antisense_tRNA", "AS (tRNA)", .) %>%
        gsub("^intergenic", "inter", .)
    
    wrt_Tr_all$detailed_all_easy <- wrt_Tr_all$detailed_all %>%
        gsub("^antisense_verified", "AS (verified)", .) %>%
        gsub("^antisense_dubious", "AS (dubious)", .) %>%
        gsub("^antisense_uncharacterized", "AS (unchar)", .) %>%
        gsub("^antisense_ncRNA", "AS (ncRNA)", .) %>%
        gsub("^antisense_PG", "AS (PG)", .) %>%
        gsub("^antisense_rRNA", "AS (rRNA)", .) %>%
        gsub("^antisense_snoRNA", "AS (snoRNA)", .) %>%
        gsub("^antisense_TE", "AS (TE)", .) %>%
        gsub("^antisense_tRNA", "AS (tRNA)", .) %>%
        gsub("^uncharacterized", "unchar", .) %>%
        gsub("^intergenic", "inter", .)
    
    wrt_Tr_all <- wrt_Tr_all %>%
        dplyr::relocate(category_all_easy, .after = category_all) %>%
        dplyr::relocate(detailed_all_easy, .after = detailed_all)
    
    #  For any rows that overlap after stratifying for 'chr' and 'strand', then 
    #+ organize said rows into groups
    wrt_Tr_all_group <- plyr::ddply(
        wrt_Tr_all,
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
    wrt_Tr_all_group <- wrt_Tr_all_group %>%
        dplyr::relocate(c(start_all, end_all), .after = end)
    wrt_Tr_all_group$new_group <-
        is.na(wrt_Tr_all_group$previous_end) | 
            (
                wrt_Tr_all_group$start >=
                wrt_Tr_all_group$previous_end
            )
    wrt_Tr_all_group$group <- cumsum(wrt_Tr_all_group$new_group)
    wrt_Tr_all_group <- wrt_Tr_all_group %>%
        dplyr::mutate(type_id_all = paste0(category_all, ": ", gene_id_all))
    
    #  Create abbreviated categories
    run <- FALSE
    if(base::isTRUE(run)) {
        #  Surveying our categories
        wrt_Tr_all_group %>%
            dplyr::group_by(category_all) %>%
            summarize(dplyr::n())
    }
    # # A tibble: 18 × 2
    #    category_all     `dplyr::n()`
    #    <chr>                   <int>
    #  1 ARS                       423
    #  2 PG                          7
    #  3 TE                        117
    #  4 antisense_PG                6
    #  5 antisense_TE               69
    #  6 antisense_gene           2327
    #  7 antisense_ncRNA             8
    #  8 antisense_rRNA              3
    #  9 antisense_snoRNA           22
    # 10 antisense_tRNA             14
    # 11 gene                     5901
    # 12 intergenic              10806
    # 13 ncRNA                       8
    # 14 rRNA                        2
    # 15 snRNA                       7
    # 16 snoRNA                     75
    # 17 tRNA                        5
    # 18 telomere                   24
    
    wrt_Tr_all_group$abbrev_all <- wrt_Tr_all_group$category_all %>%
        stringr::str_replace_all("^antisense_gene", "&G") %>%
        stringr::str_replace_all("^antisense_ncRNA", "&N") %>%
        stringr::str_replace_all("^antisense_PG", "&P") %>%
        stringr::str_replace_all("^antisense_rRNA", "&R") %>%
        stringr::str_replace_all("^antisense_snoRNA", "&O") %>%
        stringr::str_replace_all("^antisense_TE", "&M") %>%
        stringr::str_replace_all("^antisense_tRNA", "&T") %>%
        stringr::str_replace_all("^ARS", "A") %>%
        stringr::str_replace_all("^gene", "G") %>%
        stringr::str_replace_all("^intergenic", "I") %>%
        stringr::str_replace_all("^ncRNA", "N") %>%
        stringr::str_replace_all("^PG", "P") %>%
        stringr::str_replace_all("^rRNA", "R") %>%
        stringr::str_replace_all("^snRNA", "S") %>%
        stringr::str_replace_all("^snoRNA", "O") %>%
        stringr::str_replace_all("^TE", "M") %>%
        stringr::str_replace_all("^telomere", "E") %>%
        stringr::str_replace_all("^tRNA", "T")
    
    wrt_Tr_all_group$abbrev_detailed_all <- wrt_Tr_all_group$detailed_all %>%
        stringr::str_replace_all("^antisense_dubious", "&D") %>%
        stringr::str_replace_all("^antisense_ncRNA", "&N") %>%
        stringr::str_replace_all("^antisense_PG", "&P") %>%
        stringr::str_replace_all("^antisense_rRNA", "&R") %>%
        stringr::str_replace_all("^antisense_snoRNA", "&O") %>%
        stringr::str_replace_all("^antisense_TE", "&M") %>%
        stringr::str_replace_all("^antisense_tRNA", "&T") %>%
        stringr::str_replace_all("^antisense_uncharacterized", "&U") %>%
        stringr::str_replace_all("^antisense_verified", "&V") %>%
        stringr::str_replace_all("^ARS", "A") %>%
        stringr::str_replace_all("^dubious", "D") %>%
        stringr::str_replace_all("^intergenic", "I") %>%
        stringr::str_replace_all("^ncRNA", "N") %>%
        stringr::str_replace_all("^PG", "P") %>%
        stringr::str_replace_all("^rRNA", "R") %>%
        stringr::str_replace_all("^snRNA", "S") %>%
        stringr::str_replace_all("^snoRNA", "O") %>%
        stringr::str_replace_all("^TE", "M") %>%
        stringr::str_replace_all("^telomere", "E") %>%
        stringr::str_replace_all("^tRNA", "T") %>%
        stringr::str_replace_all("^uncharacterized", "U") %>%
        stringr::str_replace_all("^verified", "V")

    wrt_Tr_all_group <- wrt_Tr_all_group %>%
        dplyr::relocate(abbrev_all, .before = category_all) %>%
        dplyr::relocate(abbrev_detailed_all, .before = detailed_all)
    
    run <- TRUE
    if(base::isTRUE(run)) {
        wrt_Tr_all_group %>%
            dplyr::group_by(abbrev_all) %>%
            summarize(dplyr::n())
        # A tibble: 18 × 2
        # abbrev_all `dplyr::n()`
        #     <chr>             <int>
        #   1 &G                 2327
        #   2 &M                   69
        #   3 &N                    8
        #   4 &O                   22
        #   5 &P                    6
        #   6 &R                    3
        #   7 &T                   14
        #   8 A                   423
        #   9 E                    24
        #  10 G                  5901
        #  11 I                 10806
        #  12 M                   117
        #  13 N                     8
        #  14 O                    75
        #  15 P                     7
        #  16 R                     2
        #  17 S                     7
        #  18 T                     5
        
        wrt_Tr_all_group %>%
            dplyr::group_by(abbrev_detailed_all) %>%
            summarize(dplyr::n()) %>%
            print(n = 100)
        # A tibble: 22 × 2
        #    abbrev_detailed_all `dplyr::n()`
        #    <chr>                      <int>
        #  1 &D                           587
        #  2 &M                            69
        #  3 &N                             8
        #  4 &O                            22
        #  5 &P                             6
        #  6 &R                             3
        #  7 &T                            14
        #  8 &U                           303
        #  9 &V                          1437
        # 10 A                            423
        # 11 D                            287
        # 12 E                             24
        # 13 I                          10806
        # 14 M                            117
        # 15 N                              8
        # 16 O                             75
        # 17 P                              7
        # 18 R                              2
        # 19 S                              7
        # 20 T                              5
        # 21 U                            747
        # 22 V                           4867
    }
    
    #  Calculate pct. overlaps between "Q" and "all" features and vice versa --
    wrt_Tr_all_group$pct_Tr_over_all <- mapply(
        percent_overlap,
        wrt_Tr_all_group$start,
        wrt_Tr_all_group$end,
        wrt_Tr_all_group$start_all,
        wrt_Tr_all_group$end_all
    )
    wrt_Tr_all_group$pct_all_over_Tr <- mapply(
        percent_overlap,
        wrt_Tr_all_group$start_all,
        wrt_Tr_all_group$end_all,
        wrt_Tr_all_group$start,
        wrt_Tr_all_group$end
    )
    wrt_Tr_all_group <- wrt_Tr_all_group %>%
        dplyr::relocate(
            c(pct_Tr_over_all, pct_all_over_Tr, type_id_all, group),
            .after = end_all
        )
    
    
    #  Aggregate the data -----------------------------------------------------
    wrt_Tr_all_agg <- plyr::ddply(
        wrt_Tr_all_group,
        .(seqnames, strand, group),
        plyr::summarize, 
        start = min(start),
        end = max(end),
        width = (end - start) + 1,
        id = paste0(id, collapse = "; "),
        trinity = paste0(gene_id, collapse = "; "),
        category_abbrev = paste0(abbrev_all, collapse = " "),
        detailed_abbrev = paste0(abbrev_detailed_all, collapse = " "),
        category = paste0(category_all, collapse = "; "),
        category_easy = paste0(category_all_easy, collapse = ", "),
        detailed = paste0(detailed_all, collapse = "; "),
        detailed_easy = paste0(detailed_all_easy, collapse = ", "),
        complete = paste0(type_id_all, collapse = "; "),
        pct_Tr_over_all = paste0(round(pct_Tr_over_all, 2), collapse = ", "),
        pct_all_over_Tr = paste0(round(pct_all_over_Tr, 2), collapse = ", "),
        orf_classification = paste0(orf_classification_all, collapse = "; "),
        source_id = paste0(source_id_all, collapse = "; ")
    ) %>%
        dplyr::select(-group) %>%
        dplyr::arrange(seqnames, start, strand) %>%
        dplyr::relocate(
            c(seqnames, start, end, width, strand), .before = id
        ) %>%
        dplyr::mutate(
            n_features = stringr::str_count(complete, "\\:\ ")
        ) %>%
        tibble::as_tibble()
    
    #  Collapse redundant strings in cells of column "id"
    wrt_Tr_all_agg$id <- vapply(
        stringr::str_split(wrt_Tr_all_agg$id, "; "),
        `[`,
        1,
        FUN.VALUE = character(1)
    )
    
    
    #  Return the various data objects ----------------------------------------
    list_return <- list()
    list_return[["wrt_Tr_all"]] <- wrt_Tr_all
    list_return[["wrt_Tr_all_group"]] <- wrt_Tr_all_group
    list_return[["wrt_Tr_all_agg"]] <- wrt_Tr_all_agg
    
    return(list_return)
}


#  Load gtfs as tibbles -------------------------------------------------------
p_main <- "outfiles_gtf-gff3"

#  Load Trinity Q annotations
p_Q <- paste(p_main, "Trinity-GG/Q_N/filtered/locus", sep = "/")
f_Q <- "Q_mkc-4_gte-pctl-25.gtf"
gtf_Q <- rtracklayer::import(paste(p_Q, f_Q, sep = "/")) %>%
    tibble::as_tibble() %>%
    dplyr::select(-c(phase, score)) %>%
    dplyr::arrange(seqnames, start, strand) %>%
    dplyr::filter(seqnames != "Mito")

#  Load Trinity G1 annotations
p_G <- paste(p_main, "Trinity-GG/G_N/filtered/locus", sep = "/")
f_G <- "G1_mkc-4_gte-pctl-25.gtf"
gtf_G1 <- rtracklayer::import(paste(p_G, f_G, sep = "/")) %>%
    tibble::as_tibble() %>%
    dplyr::select(-c(phase, score)) %>%
    dplyr::arrange(seqnames, start, strand) %>%
    dplyr::filter(seqnames != "Mito")

#  Load "gtf_all" annotations
p_gtf_all <- paste(p_main, "comprehensive/S288C_reference_genome_R64-1-1_20110203", sep = "/")
f_gtf_all <- "processed_features-intergenic_sense-antisense.gtf"
gtf_all <- rtracklayer::import(paste(p_gtf_all, f_gtf_all, sep = "/")) %>%
    tibble::as_tibble() %>%
    dplyr::select(-c(phase, score)) %>%
    dplyr::arrange(seqnames, start, strand)

#  Load R64-1-1 ncRNA annotations
p_gtf_ncRNA_R64 <- paste(p_main, "representation", sep = "/")
f_gtf_ncRNA_R64 <- "Greenlaw-et-al_ncRNAs.gtf"
gtf_ncRNA <- rtracklayer::import(paste(p_gtf_ncRNA_R64, f_gtf_ncRNA_R64, sep = "/")) %>%
    tibble::as_tibble() %>%
    dplyr::select(-c(phase, score)) %>%
    dplyr::arrange(seqnames, start, strand)
gtf_ncRNA$source <- "SGD"
gtf_ncRNA <- gtf_ncRNA %>%
    dplyr::select(-c(liftOver)) %>%
    dplyr::mutate(
        orf_classification = "NA",
        source_id = "NA"
    )

#  Generate R64-1-1 ncRNA antisense annotations
gtf_ncRNA_AS <- gtf_ncRNA
gtf_ncRNA_AS$strand <- ifelse(gtf_ncRNA$strand == "+", "-", "+")
gtf_ncRNA_AS$source <- "SGD (KA)"
gtf_ncRNA_AS$gene_id <- 
    gtf_ncRNA_AS$transcript_id <-
    paste0("AS_", gtf_ncRNA$gene_id)
gtf_ncRNA_AS$type.1 <- paste0("antisense_", gtf_ncRNA$type.1)

#  Combine sense and antisense ncRNA annotations with "gtf_all"
gtf_all <- dplyr::bind_rows(gtf_all, gtf_ncRNA, gtf_ncRNA_AS) %>%
    dplyr::arrange(seqnames, start)

rm(
    p_main, p_Q, f_Q, p_G, f_G, p_gtf_all, f_gtf_all, p_gtf_ncRNA_R64,
    f_gtf_ncRNA_R64, gtf_ncRNA, gtf_ncRNA_AS
)


# Evaluate overlaps between newly documented and official features ------------
#  Identify the overlaps after initializing necessary variables
g_Q <- makeGRangesFromDataFrame(gtf_Q, keep.extra.columns = TRUE)
g_G1 <- makeGRangesFromDataFrame(gtf_G1, keep.extra.columns = TRUE)
g_all <- makeGRangesFromDataFrame(gtf_all, keep.extra.columns = TRUE)

overlap_Q_v_all <- IRanges::findOverlaps(g_Q, g_all)
overlap_G1_v_all <- IRanges::findOverlaps(g_G1, g_all)

analyses_Q <- analyze_feature_intersections(
    overlap_Tr_v_all = overlap_Q_v_all,
    gtf_Tr = gtf_Q,
    gtf_all = gtf_all
)
agg_Q <- analyses_Q$wrt_Tr_all_agg

analyses_G1 <- analyze_feature_intersections(
    overlap_Tr_v_all = overlap_G1_v_all,
    gtf_Tr = gtf_G1,
    gtf_all = gtf_all
)
agg_G1 <- analyses_G1$wrt_Tr_all_agg


#  View the numbers of overlap categories -------------------------------------
run <- TRUE
if(base::isTRUE(run)) {
    analyze_w_pct <- FALSE
    if(base::isTRUE(analyze_w_pct)) {
        cols <- c("category_abbrev", "category_easy", "pct_Tr_over_all")
    } else {
        cols <- c("category_abbrev", "category_easy")
    }
    
    feat_Q <- agg_Q %>%
        dplyr::group_by(dplyr::across(dplyr::all_of(cols))) %>%
        dplyr::summarize(tally = dplyr::n(), .groups = "keep") %>%
        dplyr::arrange(dplyr::desc(tally))
    
    feat_G1 <- agg_G1 %>%
        dplyr::group_by(dplyr::across(dplyr::all_of(cols))) %>%
        dplyr::summarize(tally = dplyr::n()) %>%
        dplyr::arrange(dplyr::desc(tally))
}

test <- TRUE
if(base::isTRUE(test)) {
    #  Tally number of "upstream expression" non-feature regions (associated
    #+ with intergenic, antisense, ARS, or telomeric regions) in categories
    feat_Q$up <- ifelse(
        #  Select for categories with listed features in interior or at end
        stringr::str_detect(
            feat_Q$category_abbrev,
            # " G | G$"
            " G | G$| N |N$| P |P$| R |R$| S |S$| O |O$| M |M$| T |T$"
        ) &
        #  While excluding categories that begin with listed features
        !stringr::str_detect(
            feat_Q$category_abbrev,
            "^G|^N|^P|^R|^S|^O|^M|^T"
        ) &
        #  And while excluding categories with string character counts less
        #+ than or equal to two
        nchar(feat_Q$category_abbrev) %notin% c(0, 1, 2),
        stringr::str_count(
            feat_Q$category_abbrev[
                stringr::str_detect(
                    #  Select for categories with listed features in interior
                    #+ or at end
                    feat_Q$category_abbrev,
                    # " G | G$"
                    " G | G$| N |N$| P |P$| R |R$| S |S$| O |O$| M |M$| T |T$"
                ) &
                !stringr::str_detect(
                    #  While excluding categories that begin with listed
                    #+ features
                    feat_Q$category_abbrev,
                    "^G|^N|^P|^R|^S|^O|^M|^T"
                ) &
                #  And while excluding categories with string character counts less
                #+ than or equal to two
                nchar(feat_Q$category_abbrev) %notin% c(0, 1, 2)
            ],
            "^I|^A|^&|^E"
        ),
        0
    )
    
    feat_Q$up_what <- ifelse(
        nchar(feat_Q$category_abbrev) >= 2,
        stringr::str_extract(feat_Q$category_abbrev, "^.{2}"),
        stringr::str_extract(feat_Q$category_abbrev, "^.{1}")
    ) %>%
        gsub(" ", "", .)
    
    #  Tally number of "downstream expression" non-feature regions (associated
    #+ with intergenic, antisense, ARS, or telomeric regions) in categories
    feat_Q$dn <- ifelse(
        #  Select for categories ending with features &?, I, A, or E
        stringr::str_detect(
            feat_Q$category_abbrev,
            "&.$|I$|A$|E$"
        ) &
        #  ...while excluding categories with string character counts less than or
        #+ equal to two
        nchar(feat_Q$category_abbrev) %notin% c(0, 1, 2),
        stringr::str_count(
            feat_Q$category_abbrev[
                #  Select for categories ending with features &?, I, A, or E
                stringr::str_detect(
                    feat_Q$category_abbrev,
                    "&.$|I$|A$|E$"
                ) &
                #  ...while excluding categories with string character counts less
                #+ than or equal to two
                nchar(feat_Q$category_abbrev) %notin% c(0, 1, 2)
            ],
            "&.$|I$|A$|E$"
        ),
        0
    )
    
    feat_Q$dn_what <- feat_Q$category_abbrev %>%
        stringr::str_sub(-2) %>%
        stringr::str_remove(" ")
    
    #  Initialize and define up_dn; it is assigned 1 if both up and dn are 1,
    #+ else it is assigned 0
    feat_Q$up_dn <- ifelse(
        feat_Q$up == 0 & (feat_Q$dn == 0 | feat_Q$dn == 1),
        0,
        ifelse(
            feat_Q$up == 1 & feat_Q$dn == 0,
            0,
            ifelse(
                feat_Q$up == 1 & feat_Q$dn == 1,
                1,
                NA_integer_
            )
        )
    )
    
    feat_Q$complete <- ifelse(
        feat_Q$up_dn == 1,
        "complete",
        ifelse(
            (feat_Q$up == 1 & feat_Q$dn == 0) |
            (feat_Q$up == 0 & feat_Q$dn == 1),
            "partial",
            "other"
        )
    )
    
    ifelse(
        feat_Q$complete == "other" &
        (nchar(feat_Q$category_abbrev) <= 2),
        
    )
    #PICKUPHERE Struggling with thinking through the logic at time of stop-
    #           ping
    ifelse(
        nchar(feat_Q[feat_Q$complete == "other", ]$category_abbrev) <= 2,
        "single",
        
        ifelse(
            nchar(feat_Q[feat_Q$complete == "other", ]$category_abbrev) > 2,
            "partial",
            "XXXXXXXX"
        )
    )
    
    tmp[nchar(feat_Q[feat_Q$complete == "other", ]$category_abbrev) > 2, ]
    
    
    #  Tally number of features in categories
    #  ARS
    feat_Q$no_A <- feat_Q$category_abbrev %>%
        stringr::str_count("^A | A | A$")
    
    #  gene
    feat_Q$no_G <- feat_Q$category_abbrev %>%
        stringr::str_count("^G | G | G$")
    
    #  intergenic
    feat_Q$no_I <- feat_Q$category_abbrev %>%
        stringr::str_count("^I | I | I$")
    
    #  ncRNA
    feat_Q$no_N <- feat_Q$category_abbrev %>%
        stringr::str_count("^N | N | N$")
    
    #  pseudogene
    feat_Q$no_P <- feat_Q$category_abbrev %>%
        stringr::str_count("^P | P | P$")
    
    #  rRNA
    feat_Q$no_R <- feat_Q$category_abbrev %>%
        stringr::str_count("^R | R | R$")
    
    #  snRNA
    feat_Q$no_S <- feat_Q$category_abbrev %>%
        stringr::str_count("^S | S | S$")
    
    #  snoRNA
    feat_Q$no_O <- feat_Q$category_abbrev %>%
        stringr::str_count("^O | O | O$")
    
    #  transposable element
    feat_Q$no_M <- feat_Q$category_abbrev %>%
        stringr::str_count("^M | M | M$")
    
    #  telomere
    feat_Q$no_E <- feat_Q$category_abbrev %>%
        stringr::str_count("^E | E | E$")
    
    #  tRNA
    feat_Q$no_T <- feat_Q$category_abbrev %>%
        stringr::str_count("^T | T | T$")
    
    #  antisense (gene)
    feat_Q$no_aG <- feat_Q$category_abbrev %>%
        stringr::str_count("^&G | &G | &G$")
    
    #  antisense (ncRNA)
    feat_Q$no_aN <- feat_Q$category_abbrev %>%
        stringr::str_count("^&N | &N | &N$")
    
    #  antisense (pseudogene)
    feat_Q$no_aP <- feat_Q$category_abbrev %>%
        stringr::str_count("^&P | &P | &P$")
    
    #  antisense (rRNA)
    feat_Q$no_aR <- feat_Q$category_abbrev %>%
        stringr::str_count("^&R | &R | &R$")
    
    #  antisense (snoRNA)
    feat_Q$no_aO <- feat_Q$category_abbrev %>%
        stringr::str_count("^&O | &O | &O$")
    
    #  antisense (transposable element)
    feat_Q$no_aM <- feat_Q$category_abbrev %>%
        stringr::str_count("^&M | &M | &M$")
    
    #  antisense (tRNA)
    feat_Q$no_aT <- feat_Q$category_abbrev %>%
        stringr::str_count("^&T | &T | &T$")
    
    feat_Q$lgl_G <- ifelse(feat_Q$no_G > 0, TRUE, FALSE)
    feat_Q$lgl_N <- ifelse(feat_Q$no_N > 0, TRUE, FALSE)
    feat_Q$lgl_P <- ifelse(feat_Q$no_P > 0, TRUE, FALSE)
    feat_Q$lgl_R <- ifelse(feat_Q$no_R > 0, TRUE, FALSE)
    feat_Q$lgl_S <- ifelse(feat_Q$no_S > 0, TRUE, FALSE)
    feat_Q$lgl_O <- ifelse(feat_Q$no_O > 0, TRUE, FALSE)
    feat_Q$lgl_M <- ifelse(feat_Q$no_M > 0, TRUE, FALSE)
    feat_Q$lgl_T <- ifelse(feat_Q$no_T > 0, TRUE, FALSE)
    
    feat_Q$mixed <- ifelse(
        rowSums(feat_Q[, 27:ncol(feat_Q)]) > 1,
        "mixed",
        ifelse(
            rowSums(feat_Q[, 27:ncol(feat_Q)]) == 0,
            NA_character_,
            "unmixed"
        )
    ) %>% 
        forcats::as_factor()
    
    #PICKUPHERE Is the number of mixed really just 46?
    tmp <- feat_Q[rowSums(feat_Q[, 27:ncol(feat_Q)]) > 1, ]
    
    run <- TRUE
    if(base::isTRUE(run)) {
        tmp <- feat_Q %>%
            # dplyr::filter(dn == 1)
            dplyr::filter(dn == 0)
        
        tmp <- tmp %>%
            dplyr::relocate(v, .after = category_abbrev)
        
        tmp_v <- tmp$v %>%
            forcats::as_factor() %>%
            table()
        # dn == 1
        # .
        #   I  &G   A  &M  &O  &N  &T  &R  &P 
        # 189  83  39  12   5   4   4   1   1
        
        # dn == 0
        # .
        #  G  I &G  M  O  T &M &O &R  A  E  N  S  P  R 
        # 54  1  1 17  4  3  1  1  1  1  1  2  2  1  1
    }
}

run <- TRUE
if(base::isTRUE(run)) rm(feat_Q)

#  Write out dataframes
run <- FALSE
if(base::isTRUE(run)) {
    readr::write_tsv(feat_Q, "dataframe_Q_categories.tsv")
    readr::write_tsv(feat_G1, "dataframe_G1_categories.tsv")
}

#  Examine the feature categories in one state not in the other
run <- FALSE
if(base::isTRUE(run)) {
    table(feat_Q$category_abbrev %notin% feat_G1$category_abbrev)
    table(feat_G1$category_abbrev %notin% feat_Q$category_abbrev)
}

feat_Q_uniq <- feat_Q[
    feat_Q$category_abbrev %notin% feat_G1$category_abbrev, 
]

feat_G1_uniq <- feat_G1[
    feat_G1$category_abbrev %notin% feat_Q$category_abbrev, 
]


#  Sketch work ================================================================
run <- FALSE
if(base::isTRUE(run)) list.files(pattern = "xlsx")

df_Q <- readxl::read_xlsx(
    "dataframe_Q_categories.xlsx",
    sheet = "dataframe_test-1_2023-0614"
)

df_G1 <- readxl::read_xlsx(
    "dataframe_G1_categories.xlsx",
    sheet = "dataframe_test-1_2023-0614"
)

#  Reviewing how to make stacked bar charts again...
run <- TRUE
if(base::isTRUE(run)) {
    #  Create a dataset
    specie <- c(
        rep("sorgho" , 3),
        rep("poacee" , 3),
        rep("banana" , 3),
        rep("triticum" , 3)
    )
    condition <- rep(c("normal", "stress", "Nitrogen"), 4)
    value <- abs(rnorm(12 , 0 , 15))
    data <- data.frame(specie, condition, value)
    
    run <- TRUE
    if(base::isTRUE(run)) data
    
    # Stacked
    ggplot(data, aes(fill = condition, y = value, x = specie)) + 
        geom_bar(position = "stack", stat = "identity")
    
    run <- FALSE
    if(base::isTRUE(run)) rm(specie, condition, value, data)
}

tibble::tibble(
    category = df_Q$rough,
    value = df_Q$tally,
    
)