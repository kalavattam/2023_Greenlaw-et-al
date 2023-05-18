
i <- "k2"
j <- "below_05"
k <- path_Q_locus

cat("Saving G1", i, j, "in", k, "\n")
cat(paste0(
    path_G_locus, "/G1_mkc-", gsub("k", "", i), "_",
    gsub("below_", "gte-pctl-", j), ".gtf"
))
cat("\n\n")

out_G_conv <- GenomicRanges::makeGRangesFromDataFrame(
    out_G_gtf_locus[[i]][[j]], keep.extra.columns = TRUE
)

rtracklayer::export(
    out_G_gtf_locus[[i]][[j]],
    paste0(
        path_G_locus, "/G1_mkc-", gsub("k", "", i), "_",
        gsub("below_", "gte-pctl-", j), ".gtf"
    )
)


#  ----------------------------------------------------------------------------
convert_character_0_NA <- function(x) {
    z <- lapply(
        x, function(y) if(identical(y, character(0))) NA_character_ else y
    ) %>%
        unlist()
    
    return(z)
}


flatten_elements_to_one <- function(x) {
    # For character list elements with two or more subelements, collapse
    # ("flatten") the subelements into a single character element
    # 
    # :param x: <list>
    # :return: character vector of collapsed list elements (list e)
    
    l_collapsed <- x[lengths(x) >= 2] %>% length()
    collapsed <- vector(mode = "character", length = l_collapsed)
    for(i in 1:l_collapsed) {
        # i <- 1
        # cat(i, "\n")
        # cat(x[lengths(x) >= 2][[i]], "\n")
        collapsed[i] <- stringr::str_c(
            x[lengths(x) >= 2][[i]],
            collapse = ", "
        )
    }
    
    return(collapsed)
}


process_list_column <- function(x) {
    x[lengths(x) == 0] <- NA_character_
    if(length(x[lengths(x) >= 2]) != 0) {
        x[lengths(x) >= 2] <- x[lengths(x) >= 2] %>%
            flatten_elements_to_one()
    }
    y <- x %>% unlist()
    return(y)
}

#PICKUPHERE
test <- out_G_gtf_locus[[i]][[j]] %>%
    tibble::as_tibble() %>%
    dplyr::select(-c(
        "width", "geneID", "Name", "coverage", "identity", "matches",
        "mismatches", "indels", "unknowns", "Target", "CDS_Target", "locus", "Parent",
        "partialness", "InFrameStop"
    )) %>%
    dplyr::arrange(seqnames, start) %>%
    dplyr::mutate(
        geneIDs = process_list_column(test$geneIDs),
        transcripts = process_list_column(test$transcripts)
    ) %>%
    dplyr::relocate(c(source, type), .after = seqnames)

