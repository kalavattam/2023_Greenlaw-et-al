
i <- "k4"
j <- "below_05"
# k <- path_G_locus
# k <- path_G_mRNA
k <- path_G_exon
# k <- path_G_CDS
# k <- path_G_introns_filtered

outfile <- paste0(
    path_G_locus, "/G1_mkc-", gsub("k", "", i), "_",
    gsub("below_", "gte-pctl-", j), ".gtf"
)

cat("Saving G1", i, j, "in", k, "\n")
cat(paste0(outfile, "\n"))
cat("\n\n")

run <- "mRNA"
if(run == "locus") {
    test <- out_G_gtf_locus[[i]][[j]] %>%
        tibble::as_tibble() %>%
        dplyr::select(-c(
            "phase", "width", "geneID", "Name", "coverage", "identity",
            "matches", "mismatches", "indels", "unknowns", "Target",
            "CDS_Target", "locus", "Parent", "partialness", "InFrameStop"
        )) %>%
        dplyr::arrange(seqnames, start) %>%
        dplyr::rename(
            "feature" = "type",
            "id" = "ID",
            "gene_id" = "geneIDs",
            "transcript_id" = "transcripts"
        ) %>%
        dplyr::mutate(
            source = paste0("sacCer3; trinity; ", source, ", gffread; Greenlaw et al."),
            score = ".",
            frame = ".",
            gene_id = process_list_column(gene_id),
            transcript_id = process_list_column(transcript_id)
        ) %>%
        dplyr::relocate(c(source, feature), .after = seqnames) %>%
        dplyr::relocate(c(score, strand, frame), .after = end) %>%
        dplyr::mutate(
            attribute = paste(
                paste0("id \"", id, "\""),
                paste0("gene_id \"", gene_id, "\""),
                paste0("transcript_id \"", transcript_id, "\""),
                paste0("locus_source \"GffRead v0.12.7\""),
                paste0("gene_source \"Trinity v2.14\""),
                paste0("transcript_source \"Trinity v2.14\""),
                sep = "; "
            )
        ) %>%
        dplyr::select(-c(id, gene_id, transcript_id))
    test

    test %>% write_gtf(., "test.gtf")
} else if(run == "mRNA") {
    test <- out_G_gtf_mRNA[[i]][[j]] %>%
        tibble::as_tibble() %>%
        dplyr::select(-c(
            "phase", "width", "geneIDs", "transcripts", "Parent"
        )) %>%
        dplyr::arrange(seqnames, start) %>%
        dplyr::rename(
            "feature" = "type",
            "id" = "ID",
            "gene_id" = "geneID"
        ) %>%
        dplyr::mutate(
            source = paste0(source, "; trinity; gffread; Greenlaw et al."),
            score = ".",
            frame = "."
        ) %>%
        dplyr::relocate(c(source, feature), .after = seqnames) %>%
        dplyr::relocate(c(score, strand, frame), .after = end) %>%
        dplyr::mutate(
            attribute = paste(
                paste0("id \"", id, "\""),
                paste0("name \"", Name, "\""),
                paste0("gene_id \"", gene_id, "\""),
                paste0("locus_id \"", locus, "\""),
                paste0("mRNA_source \"Trinity v2.14\""),
                paste0("gene_source \"Trinity v2.14\""),
                paste0("locus_source \"GffRead v0.12.7\""),
                paste0("coverage \"", coverage, "\""),
                paste0("identity \"", identity, "\""),
                paste0("matches \"", matches, "\""),
                paste0("mismatches \"", mismatches, "\""),
                paste0("indels \"", indels, "\""),
                paste0("unknowns \"", unknowns, "\""),
                paste0("target \"", Target, "\""),
                paste0("CDS_target \"", CDS_Target, "\""),
                paste0("partialness \"", partialness, "\""),
                paste0("in_frame_stop \"", InFrameStop, "\""),
                sep = "; "
            )
        ) %>%
        dplyr::select(-c(
            id, Name, gene_id, locus, coverage, identity, matches, mismatches,
            indels, unknowns, Target, CDS_Target, partialness, InFrameStop
        ))
    test
    
    test %>% write_gtf(., "test.gtf")
} else if(run == "exon") { 
    test <- out_Q_gtf_exon[[i]][[j]] %>%
        tibble::as_tibble() %>%
        dplyr::select(-c(
            "width", "phase", "ID", "geneIDs", "transcripts", "geneID", "Name",
            "coverage", "identity", "matches", "mismatches", "indels",
            "unknowns", "CDS_Target", "partialness", "locus", "InFrameStop"
        )) %>%
        dplyr::arrange(seqnames, start) %>%
        dplyr::rename("id" = "Parent", "feature" = "type") %>%
        dplyr::mutate(
            source = paste0(source, "; trinity; gffread; Greenlaw et al."),
            frame = ".",
            id = process_list_column(id)
        ) %>%
        dplyr::relocate(c("source", "feature"), .after = "seqnames") %>%
        dplyr::relocate("frame", .after = "score") %>%
        dplyr::mutate(
            attribute = paste(
                paste0("id \"", id, "\""),
                paste0("source_id \"Trinity v2.14\""),
                paste0("source_additional \"GffRead v0.12.7\""),
                paste0("target \"", Target, "\""),
                sep = "; "
            )
        ) %>%
        dplyr::select(-c("Target", "id"))
    test
    
    test %>% write_gtf(., "test.gtf")
} else if(run == "CDS") { 
    test <- out_Q_gtf_CDS[[i]][[j]] %>%
        tibble::as_tibble() %>%
        dplyr::select(-c(
            "width", "ID", "geneIDs", "transcripts", "geneID", "Name",
            "coverage", "identity", "matches", "mismatches", "indels",
            "unknowns", "CDS_Target", "partialness", "locus", "InFrameStop"
        )) %>%
        dplyr::arrange(seqnames, start) %>%
        dplyr::rename("id" = "Parent", "feature" = "type") %>%
        dplyr::mutate(
            source = paste0(source, "; trinity; gffread; Greenlaw et al."),
            score = ".",
            frame = ".",
            id = process_list_column(id)
        ) %>%
        dplyr::relocate(c("source", "feature"), .after = "seqnames") %>%
        dplyr::relocate(c("strand", "frame"), .after = "score") %>%
        dplyr::mutate(
            attribute = paste(
                paste0("id \"", id, "\""),
                paste0("source_id \"Trinity v2.14\""),
                paste0("source_additional \"GffRead v0.12.7\""),
                paste0("phase \"", phase, "\""),
                paste0("target \"", Target, "\""),
                sep = "; "
            )
        ) %>%
        dplyr::select(-c("phase", "Target", "id"))
    test
    
    test %>% write_gtf(., "test.gtf")
} else if(run == "introns_filtered") { 
    test <- out_Q_gtf_introns_filtered[[i]][[j]] %>%
        tibble::as_tibble() %>%
        dplyr::select(-c("width", "phase", "Parent")) %>%
        dplyr::arrange(seqnames, start) %>%
        dplyr::rename("feature" = "type", "id" = "ID") %>%
        dplyr::mutate(
            source = paste0(source, "; trinity; gffread; Greenlaw et al."),
            score = ".",
            frame = "."
        ) %>%
        dplyr::relocate(c(source, feature), .after = seqnames) %>%
        dplyr::relocate(c(score, strand, frame), .after = end) %>%
        dplyr::mutate(
            attribute = paste(
                paste0("id \"", id, "\""),
                paste0("source_id \"Trinity v2.14\""),
                paste0("source_additional \"GffRead v0.12.7\""),
                sep = "; "
            )
        ) %>%
        dplyr::select(-id)
    test
    
    test %>% write_gtf(., "test.gtf")
}

rm(i, j, k, outfile, run, test)
