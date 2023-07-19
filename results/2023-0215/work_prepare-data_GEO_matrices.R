#!/usr/bin/env Rscript

#  work_prepare-data_GEO_matrices.R
#  KA

suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(rtracklayer)))


#  Initialize functions =======================================================
`%notin%` <- base::Negate(`%in%`)


read_in_matrices <- function(file) {
    tbl <- readr::read_tsv(file = file, show_col_types = FALSE)
    
    if("...1" %in% colnames(tbl)) {
        tbl <- tbl %>% dplyr::rename("features" = "...1")
    }
    
    colnames(tbl) <- colnames(tbl) %>%
        gsub("bams_renamed/UT_prim_UMI/", "", .) %>%
        gsub(".UT_prim_UMI.bam", "", .) %>%
        gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .) %>%
        gsub(".UT_prim_UMI.hc-strd-op.tsv", "", .)
    
    return(tbl)
}


read_in_gff3 <- function(file) {
    keep <- c(
        "chr", "start", "end", "width", "strand", "type", "features",
        "biotype", "names"
    )
    gff3 <- file %>%
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
        ) %>%
        dplyr::select(dplyr::all_of(keep)) %>%
        dplyr::mutate(
            names = ifelse(
                as.character(names) == "character(0)",
                NA_character_,
                as.character(names)
            ),
            thorough = ifelse(is.na(names), features, names)
        ) %>%
        dplyr::arrange(chr, start)
    
    return(gff3)
}


read_in_gtf <- function(file) {
    gtf <- file %>%
        rtracklayer::import() %>%
        tibble::as_tibble() %>%
        dplyr::arrange(seqnames, start) %>%
        dplyr::select(-c(width, score, phase)) %>%
        dplyr::rename(chr = seqnames)
    
    if(
        "type.1" %in% colnames(gtf) &&
        "category" %notin% colnames(gtf)
    ) {
        gtf <- gtf %>% dplyr::rename(category = type.1)
    } else if(
        "type.1" %in% colnames(gtf) &&
        "category" %in% colnames(gtf)
    ) {
        gtf <- gtf %>% dplyr::rename(
            class = type.1,
            class_detailed = type_detailed
        )
    }

    return(gtf)
}


#HERE
organize_gtf <- function(tbl) {
    chr_SC <- c(
        "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
        "XIII", "XIV", "XV", "XVI", "Mito"
    )
    chr_KL <- c("A", "B", "C", "D", "E", "F")
    chr_20S <- "20S"
    
    gtf_SC <- tbl[tbl$chr %in% chr_SC, ]  # 6600
    gtf_SC$chr <- gtf_SC$chr %>% droplevels()
    gtf_SC$chr <- factor(gtf_SC$chr, levels = chr_SC)
    gtf_SC <- gtf_SC %>% dplyr::arrange(chr, start)
    
    gtf_KL <- tbl[tbl$chr %in% chr_KL, ]  # 5076
    gtf_KL$chr <- gtf_KL$chr %>% droplevels()
    gtf_KL$chr <- factor(gtf_KL$chr, levels = chr_KL)
    gtf_KL <- gtf_KL %>% dplyr::arrange(chr, start)
    
    gtf_20S <- tbl[tbl$chr %in% chr_20S, ]  # 1
    gtf_20S$chr <- gtf_20S$chr %>% droplevels()
    gtf_20S$chr <- factor(gtf_20S$chr, levels = chr_20S)
    gtf_20S <- gtf_20S %>% dplyr::arrange(chr, start)
    
    gtf <- dplyr::bind_rows(gtf_SC, gtf_KL, gtf_20S) %>%
        dplyr::mutate(
            genome = ifelse(
                chr %in% chr_SC,
                "S_cerevisiae",
                ifelse(
                    chr %in% chr_KL,
                    "K_lactis",
                    ifelse(
                        chr %in% chr_20S,
                        "20S",
                        NA_character_
                    )
                )
            )
        ) %>%
        dplyr::relocate(genome, .before = chr)
    
    rm(chr_SC, chr_KL, chr_20S, gtf_SC, gtf_KL, gtf_20S)
    return(gtf)
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


remove_unused_samples <- function(cm, col_cor = col_cor) {
    tbl <- filter_process_counts_matrix(cm, col_cor)
    tbl <- tbl[, !stringr::str_detect(colnames(tbl), "#EXCLUDE")]
    
    return(tbl)
}


#  Get situated, load counts matrices and gff3s/gtfs ==========================
if(stringr::str_detect(getwd(), "kalavattam")) {
    p_base <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_base <- "/Users/kalavatt/projects-etc"
}
p_exp <- "2022_transcriptome-construction/results/2023-0215"

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

p_GEO_gtfs <- "GEO/gtfs"
p_GEO_cms <- "GEO/matrices"


#  Concatenated genome mRNA features, "equal" strand --------------------------
#  Counts matrix
cm_cat_eq <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices() %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(
        features = features %>%
            gsub("transcript:", "", .) %>%
            gsub("_mRNA", "", .)
        )

#  gff3
gtf_cat_eq <- paste(
    p_GEO_gtfs,
    "Greenlaw-et-al.concatenated-genome_SC-KL-20S.gff3",
    sep = "/"
) %>% 
    read_in_gff3() %>%
    organize_gtf()


#  Concatenated genome mRNA features, "opposite" strand -----------------------
cm_cat_op <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices() %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(
        features = features %>%
            gsub("transcript:", "", .) %>%
            gsub("_mRNA", "", .)
        )

#  gff3
gtf_cat_op <- gtf_cat_eq %>%
    dplyr::mutate(
        tmp = ifelse(
            strand == "+",
            "change_to_minus",
            ifelse(
                strand == "-",
                "change_to_plus",
                NA_character_
            )
        )
    ) %>%
    dplyr::mutate(
        strand = ifelse(
            tmp == "change_to_minus",
            "-",
            ifelse(
                tmp == "change_to_plus",
                "+",
                NA_character_
            )
        )
    ) %>%
    dplyr::select(-tmp)


#  Representative coding non-pa-ncRNA features --------------------------------
cm_c <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices()

gtf_c <- paste(
    p_GEO_gtfs,
    "Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.gtf",
    sep = "/"
) %>% 
    read_in_gtf() %>%
    dplyr::rename("features" = "gene_id") %>%
    dplyr::mutate(
        width = (end - start) + 1
    ) %>%
    dplyr::relocate(width, .after = end)


#  Representative pa-ncRNA features, collaped and merged ----------------------
cm_nc_merged <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices()

gtf_nc_merged <- paste(
    p_GEO_gtfs,
    "Greenlaw-et-al.txome_representative-pa-ncRNA.gtf",
    sep = "/"
) %>% 
    read_in_gtf() %>%
    dplyr::rename("features" = "gene_id") %>%
    dplyr::select(-length) %>%
    dplyr::mutate(
        width = (end - start) + 1
    ) %>%
    dplyr::relocate(width, .after = end)


#  Representative pa-ncRNA features, non-collaped/merged ----------------------
cm_nc_ind <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices()

gtf_nc_ind <- paste(
    p_GEO_gtfs,
    "Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.gtf",
    sep = "/"
) %>%
    read_in_gtf() %>%
    dplyr::rename(
        source_misc_5 = source_misc_4,
        source_misc_4 = source_misc_3,
        source_misc_3 = source_misc_2,
        source_misc_2 = source_misc_1,
        source_misc_1 = source_misc,
        features = complete
    ) %>%
    dplyr::relocate(c(
        source_misc_1, source_misc_2, source_misc_3, source_misc_4,
        source_misc_5
    ), .after = features) %>%
    dplyr::mutate(
        width = (end - start) + 1
    ) %>%
    dplyr::relocate(width, .after = end)


#  G1 nascent features --------------------------------------------------------
cm_N_G1 <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices()

gtf_N_G1 <- paste(
    p_GEO_gtfs,
    "Greenlaw-et-al.txome_nascent_G1.gtf",
    sep = "/"
) %>%
    read_in_gtf() %>%
    dplyr::mutate(
        width = (end - start) + 1
    ) %>%
    dplyr::relocate(width, .after = end)


#  Q nascent features ---------------------------------------------------------
cm_N_Q <- paste(
    p_GEO_cms,
    "Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.tsv",
    sep = "/"
) %>%
    read_in_matrices()

gtf_N_Q <- paste(
    p_GEO_gtfs,
    "Greenlaw-et-al.txome_nascent_Q.gtf",
    sep = "/"
) %>%
    read_in_gtf() %>%
    dplyr::mutate(
        width = (end - start) + 1
    ) %>%
    dplyr::relocate(width, .after = end)


#  Clean up, correct, and abbreviate sample names =============================
col_cor <- setNames(
    c(
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1",           #EXCLUDE
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1",          #EXCLUDE
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",           #FIXME* ∆ rep1 → rep2
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",           #FIXME* ∆ rep2 → rep1
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",          #FIXME* ∆ rep1 → rep2
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",          #FIXME* ∆ rep2 → rep1
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",       #FIXME* ∆ rep1 → rep2
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",       #FIXME* ∆ rep2 → rep1
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",      #FIXME* ∆ rep1 → rep2
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",      #FIXME* ∆ rep2 → rep1
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",       #FIXME* ∆ rep1 → rep2
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",       #FIXME* ∆ rep2 → rep1
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",      #FIXME* ∆ rep1 → rep2
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",      #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",         #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",         #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",           #FIXME* ∆ rep1 → rep2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",           #FIXME* ∆ rep2 → rep1
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",          #FIXME* ∆ rep1 → rep2  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",          #FIXME* ∆ rep1 → rep2  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",          #FIXME* ∆ rep2 → rep1
        "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",       #EXCLUDE
        "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",       #EXCLUDE
        "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",      #EXCLUDE
        "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",      #EXCLUDE
        "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",       #EXCLUDE
        "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",       #EXCLUDE
        "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",      #EXCLUDE
        "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",      #EXCLUDE
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",        #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",        #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",           #FIXME‡ ∆ tech1 → tech2
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",           #FIXME‡ ∆ tech1 → tech2
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1", 
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1",
        "WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1",             #EXCLUDE  #FIXME† Duplicated #1
        "WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1",            #EXCLUDE  #FIXME† Duplicated #2
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",             #FIXME† Duplicated #1
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"             #FIXME† Duplicated #2
    ),
    c(
        "Nab3AID_Q_day7_tcn_N_auxT_tcF_7716_rep1_batch1", 
        "Nab3AID_Q_day7_tcn_N_auxT_tcF_7718_rep2_batch1", 
        "#EXCLUDE_01", 
        "Nab3AID_Q_day7_tcn_SS_auxT_tcF_7716_rep1_batch1", 
        "Nab3AID_Q_day7_tcn_SS_auxT_tcF_7718_rep2_batch1", 
        "#EXCLUDE_02", 
        "OsTIRAID_Q_day7_tcn_N_auxT_tcF_6125_rep1_batch1", 
        "OsTIRAID_Q_day7_tcn_N_auxT_tcF_6126_rep2_batch1", 
        "OsTIRAID_Q_day7_tcn_SS_auxT_tcF_6125_rep1_batch1", 
        "OsTIRAID_Q_day7_tcn_SS_auxT_tcF_6126_rep2_batch1", 
        "#EXCLUDE_03", 
        "#EXCLUDE_04", 
        "#EXCLUDE_05", 
        "#EXCLUDE_06", 
        "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1",   #DONE* ∆ rep1 → rep2
        "rrp6_DSm2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1",   #DONE* ∆ rep2 → rep1
        "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7078_rep2_batch1",   #DONE* ∆ rep1 → rep2
        "rrp6_DSp2_day2_tcn_SS_auxF_tcT_7079_rep1_batch1",   #DONE* ∆ rep2 → rep1
        "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7078_rep2_batch1",  #DONE* ∆ rep1 → rep2
        "rrp6_DSp24_day3_tcn_SS_auxF_tcT_7079_rep1_batch1",  #DONE* ∆ rep2 → rep1
        "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7078_rep2_batch1",  #DONE* ∆ rep1 → rep2
        "rrp6_DSp48_day4_tcn_SS_auxF_tcT_7079_rep1_batch2",  #DONE* ∆ rep2 → rep1  #DONE‡ ∆ batch1 → batch2
        "rrp6_G1_day1_tcn_SS_auxF_tcF_7078_rep2_batch2",     #DONE* ∆ rep1 → rep2  #DONE‡ ∆ batch1 → batch2
        "rrp6_G1_day1_tcn_SS_auxF_tcF_7079_rep1_batch2",     #DONE* ∆ rep2 → rep1  #DONE‡ ∆ batch1 → batch2
        "rrp6_Q_day8_tcn_N_auxF_tcF_7078_rep2_batch1",       #DONE* ∆ rep1 → rep2
        "rrp6_Q_day8_tcn_N_auxF_tcF_7079_rep1_batch1",       #DONE* ∆ rep2 → rep1
        "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch1",      #DONE* ∆ rep1 → rep2  #OK
        "rrp6_Q_day8_tcn_SS_auxF_tcF_7078_rep2_batch2",      #DONE* ∆ rep1 → rep2  #OK
        "rrp6_Q_day8_tcn_SS_auxF_tcF_7079_rep1_batch1",      #DONE* ∆ rep2 → rep1
        "#EXCLUDE_07", 
        "#EXCLUDE_08", 
        "#EXCLUDE_09", 
        "#EXCLUDE_10", 
        "#EXCLUDE_11", 
        "#EXCLUDE_12", 
        "#EXCLUDE_13", 
        "#EXCLUDE_14", 
        "WT_DSm2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1", 
        "WT_DSm2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1", 
        "WT_DSp2_day2_tcn_SS_auxF_tcT_5781_rep1_batch1", 
        "WT_DSp2_day2_tcn_SS_auxF_tcT_5782_rep2_batch1", 
        "WT_DSp24_day3_tcn_SS_auxF_tcT_5781_rep1_batch1", 
        "WT_DSp24_day3_tcn_SS_auxF_tcT_5782_rep2_batch1", 
        "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch1",   #OK
        "WT_DSp48_day4_tcn_SS_auxF_tcT_5781_rep1_batch2",   #OK
        "WT_DSp48_day4_tcn_SS_auxF_tcT_5782_rep2_batch1", 
        "WT_G1_day1_ovn_N_auxF_tcF_5781_rep1_batch1", 
        "WT_G1_day1_ovn_N_auxF_tcF_5782_rep2_batch1", 
        "WT_G1_day1_ovn_SS_auxF_tcF_5781_rep1_batch1", 
        "WT_G1_day1_ovn_SS_auxF_tcF_5782_rep2_batch1", 
        "WT_G1_day1_tcn_SS_auxF_tcF_5781_rep1_batch2",      #DONE‡ ∆ batch1 → batch2
        "WT_G1_day1_tcn_SS_auxF_tcF_5782_rep2_batch2",      #DONE‡ ∆ batch1 → batch2
        "WT_Q_day7_ovn_N_auxF_tcF_5781_rep1_batch1", 
        "WT_Q_day7_ovn_N_auxF_tcF_5782_rep2_batch1", 
        "WT_Q_day7_ovn_SS_auxF_tcF_5781_rep1_batch1", 
        "WT_Q_day7_ovn_SS_auxF_tcF_5782_rep2_batch1", 
        "#EXCLUDE_15", 
        "#EXCLUDE_16", 
        "WT_Q_day8_tcn_N_auxF_tcF_5781_rep1_batch1", 
        "WT_Q_day8_tcn_N_auxF_tcF_5782_rep2_batch1",        #DONE† Duplicated #1
        "WT_Q_day8_tcn_SS_auxF_tcF_5781_rep1_batch1", 
        "WT_Q_day8_tcn_SS_auxF_tcF_5782_rep2_batch1"        #DONE† Duplicated #2
    )
)

cm_cat_eq <- remove_unused_samples(cm_cat_eq, col_cor)
cm_cat_op <- remove_unused_samples(cm_cat_op, col_cor)
cm_c <- remove_unused_samples(cm_c, col_cor)
cm_nc_merged <- remove_unused_samples(cm_nc_merged, col_cor)
cm_nc_ind <- remove_unused_samples(cm_nc_ind, col_cor)
cm_N_G1 <- remove_unused_samples(cm_N_G1, col_cor)
cm_N_Q <- remove_unused_samples(cm_N_Q, col_cor)


#  Cast counts matrices from character to double types ========================
cm_cat_eq[, 2:length(cm_cat_eq)] <- tibble::as_tibble(sapply(
    cm_cat_eq[, 2:length(cm_cat_eq)], as.numeric
))
cm_cat_op[, 2:length(cm_cat_op)] <- tibble::as_tibble(sapply(
    cm_cat_op[, 2:length(cm_cat_op)], as.numeric
))
cm_c[, 2:length(cm_c)] <- tibble::as_tibble(sapply(
    cm_c[, 2:length(cm_c)], as.numeric
))
cm_nc_merged[, 2:length(cm_nc_merged)] <- tibble::as_tibble(sapply(
    cm_nc_merged[, 2:length(cm_nc_merged)], as.numeric
))
cm_nc_ind[, 2:length(cm_nc_ind)] <- tibble::as_tibble(sapply(
    cm_nc_ind[, 2:length(cm_nc_ind)], as.numeric
))
cm_N_G1[, 2:length(cm_N_G1)] <- tibble::as_tibble(sapply(
    cm_N_G1[, 2:length(cm_N_G1)], as.numeric
))
cm_N_Q[, 2:length(cm_N_Q)] <- tibble::as_tibble(sapply(
    cm_N_Q[, 2:length(cm_N_Q)], as.numeric
))


#  Join cms with gtfs =========================================================
full_cat_eq <- dplyr::full_join(gtf_cat_eq, cm_cat_eq, by = "features")
full_cat_op <- dplyr::full_join(gtf_cat_op, cm_cat_op, by = "features")
full_c <- dplyr::full_join(gtf_c, cm_c, by = "features")
full_nc_merged <- dplyr::full_join(gtf_nc_merged, cm_nc_merged, by = "features")
full_nc_ind <- dplyr::full_join(gtf_nc_ind, cm_nc_ind, by = "features")
full_N_G1 <- dplyr::full_join(
    gtf_N_G1,
    cm_N_G1 %>% dplyr::rename(locus_id = features),
    by = "locus_id"
)
full_N_Q <- dplyr::full_join(
    gtf_N_Q, 
    cm_N_Q %>% dplyr::rename(locus_id = features),
    by = "locus_id"
)


#  Read in, process metrics from work_calculate_uni-multimappers-etc.md =======
p_uni_multi_etc <- "outfiles_htseq-count"
f_uni_multi_etc <- "calculate_uni-multimappers-etc.UT_prim_UMI.txt"
uni_multi_etc <- readr::read_tsv(
    paste(p_uni_multi_etc, f_uni_multi_etc, sep = "/"),
    show_col_types = FALSE
)

rm(f_uni_multi_etc, p_uni_multi_etc)


#  Clean up, organize the tibble of uni_multi_etc counts ----------------------
#  Clean up, correct, and abbreviate sample names
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

uni_multi_etc <- uni_multi_etc[
    , !stringr::str_detect(colnames(uni_multi_etc), "#EXCLUDE")
]

colnames(uni_multi_etc)[1] <- "features"


#  Join full_* with uni_multi_etc =============================================
full_cat_eq <- dplyr::bind_rows(full_cat_eq, uni_multi_etc)
full_cat_op <- dplyr::bind_rows(full_cat_op, uni_multi_etc)
full_c <- dplyr::bind_rows(full_c, uni_multi_etc)
full_nc_merged <- dplyr::bind_rows(full_nc_merged, uni_multi_etc)
full_nc_ind <- dplyr::bind_rows(full_nc_ind, uni_multi_etc)
full_N_G1 <- dplyr::bind_rows(
    full_N_G1,
    uni_multi_etc %>% dplyr::rename(locus_id = features)
)
full_N_Q <- dplyr::bind_rows(
    full_N_Q,
    uni_multi_etc %>% dplyr::rename(locus_id = features)
)

#     full_cat_eq  "Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.complete.tsv"
#+    full_cat_op  "Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.complete.tsv"
#+         full_c  "Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.complete.tsv"
#+ full_nc_merged  "Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.complete.tsv"
#+    full_nc_ind  "Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.complete.tsv"
#+      full_N_G1  "Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.complete.tsv"
#+       full_N_Q  "Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.complete.tsv"

readr::write_tsv(
    full_cat_eq,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-eq_nonuniq-none.complete.tsv",
        sep = "/"
    )
)

readr::write_tsv(
    full_cat_op,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.concatenated-genome_SC-KL-20S.mRNA.hc_strd-op_nonuniq-none.complete.tsv",
        sep = "/"
    )
)

readr::write_tsv(
    full_c,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.txome_representative-coding-non-pa-ncRNA.hc_strd-eq_nonuniq-none.complete.tsv",
        sep = "/"
    )
)

readr::write_tsv(
    full_nc_merged,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.txome_representative-pa-ncRNA.hc_strd-eq_nonuniq-none.complete.tsv",
        sep = "/"
    )
)

readr::write_tsv(
    full_nc_ind,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.txome_non-collapsed-pa-ncRNA.hc_strd-eq_nonuniq-none.complete.tsv",
        sep = "/"
    )
)

readr::write_tsv(
    full_N_G1,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.txome_nascent_G1.hc_strd-eq_nonuniq-none.complete.tsv",
        sep = "/"
    )
)

readr::write_tsv(
    full_N_Q,
    paste(
        p_GEO_cms,
        "Greenlaw-et-al.txome_nascent_Q.hc_strd-eq_nonuniq-none.complete.tsv",
        sep = "/"
    )
)
