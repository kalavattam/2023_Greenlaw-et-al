#!/usr/bin/env Rscript

#  rough-draft_run-analyses_rlog-PCA_write_rds.scraps.R
#  KA


if(samples == "test.Ovation_Rrp6∆") {
    #  Strip various strings from column names
    colnames(t_mat) <- colnames(t_mat) %>%
        gsub("WT_", "WT_tcn_", .) %>%
        gsub("r6n_", "r6n_tcn_", .) %>%
        gsub("ovn", "_ovn", .)
    
    #  Create a metadata matrix for DESeq2, PCAtools, etc.
    t_meta <- colnames(t_mat)[12:ncol(t_mat)] %>%
        stringr::str_split("_") %>%
        as.data.frame() %>%
        t() %>%
        tibble::as_tibble(.name_repair = "unique") %>%
        dplyr::rename(
            genotype = ...1, kit = ...2, state = ...3,
            transcription = ...4, replicate = ...5, technical = ...6
        ) %>%
        dplyr::mutate(rownames = colnames(t_mat)[12:ncol(t_mat)]) %>%
        tibble::column_to_rownames("rownames") %>%  # DESeq2 requires rownames
        dplyr::mutate(
            genotype = factor(genotype, level = c("WT", "r6n")),
            
            no_genotype = as.numeric(sapply( 
                as.character(genotype),
                switch,
                "WT" = 0,
                "r6n" = 1,
                USE.NAMES = FALSE
            )),
            
            gt_tx = factor(paste(genotype, transcription, sep = "_")),
            
            no_gt_tx = as.numeric(sapply( 
                as.character(gt_tx),
                switch,
                "r6n_SS" = 3,
                "r6n_N" = 2,
                "WT_SS" = 1,
                "WT_N" = 0,
                USE.NAMES = FALSE
            )),
            
            st_gt_tx = factor(
                paste(state, genotype, transcription, sep = "_")
            ),
            
            no_st_gt_tx = as.numeric(sapply( 
                as.character(st_gt_tx),
                switch,
                "G1_r6n_SS" = 7,
                "G1_r6n_N" = 6,
                "Q_r6n_SS" = 5,
                "Q_r6n_N" = 4,
                "G1_WT_SS" = 3,
                "G1_WT_N" = 2,
                "Q_WT_SS" = 1,
                "Q_WT_N" = 0,
                USE.NAMES = FALSE
            )),
            
            kit = factor(kit, levels = c("tcn", "ovn")),
            
            no_kit = as.numeric(sapply( 
                as.character(kit),
                switch,
                "tcn" = 0,
                "ovn" = 1,
                USE.NAMES = FALSE
            )),
            
            state = factor(state, levels = c("G1", "Q")),
            
            no_state = as.numeric(sapply( 
                as.character(state),
                switch,
                "G1" = 0,
                "Q" = 1,
                USE.NAMES = FALSE
            )),
            
            transcription = factor(transcription, levels = c("N", "SS")),
            
            no_transcription = as.numeric(sapply( 
                as.character(transcription),
                switch,
                "N" = 0,
                "SS" = 1,
                USE.NAMES = FALSE
            )),
            
            replicate = factor(replicate, levels = c("rep1", "rep2")),
            
            no_replicate = as.numeric(sapply( 
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                USE.NAMES = FALSE
            )),
            
            technical = factor(technical, levels = c("tech1", "tech2")),
            
            no_technical = as.numeric(sapply( 
                as.character(technical),
                switch,
                "tech1" = 0,
                "tech2" = 1,
                USE.NAMES = FALSE
            ))
        )
    
    #  For the sample with unexpected projected coordinates, add two extra
    #+ variables: "strange" and "no_strange"
    t_meta$strange <- ifelse(
        t_meta$state == "Q" &
        t_meta$genotype == "WT" &
        t_meta$transcription == "SS" &
        t_meta$kit == "ovn" &
        t_meta$replicate == "rep1" &
        t_meta$technical == "tech1",
        "strange",
        "not_strange"
    )
    
    t_meta$no_strange = as.numeric(sapply( 
        as.character(t_meta$strange),
        switch,
        "not_strange" = 0,
        "strange" = 1,
        USE.NAMES = FALSE
    ))
    
    t_meta <- t_meta %>%
        dplyr::relocate(
            c(
                genotype, gt_tx, st_gt_tx, kit, state, transcription,
                replicate, technical, strange, no_genotype, no_gt_tx,
                no_st_gt_tx, no_kit, no_state, no_transcription, no_replicate,
                no_technical
            ),
            .before = no_strange
        )
} else if(samples == "test.Ovation_Tecan") {
    #  If "test" is in column name, then convert label "rep2" to "rep2-Tecan"
    colnames(t_mat) <- ifelse(
        stringr::str_detect(colnames(t_mat), "test"),
        stringr::str_replace_all(
            colnames(t_mat)[stringr::str_detect(colnames(t_mat), "test")],
            "rep2",
            "rep2-Tecan"
        ),
        colnames(t_mat)
    )
    
    #  Strip strings "ovn" and "test" from column names
    colnames(t_mat) <- colnames(t_mat) %>%
        gsub("ovn", "", .) %>%
        gsub("test", "", .)
    
    #  Create a metadata matrix for DESeq2, PCAtools, etc.
    t_meta <- colnames(t_mat)[12:ncol(t_mat)] %>%
        stringr::str_split("_") %>%
        as.data.frame() %>%
        t() %>%
        tibble::as_tibble(.name_repair = "unique") %>%
        dplyr::rename(
            genotype = ...1, state = ...2, transcription = ...3,
            replicate = ...4, technical = ...5
        ) %>%
        dplyr::mutate(rownames = colnames(t_mat)[12:ncol(t_mat)]) %>%
        tibble::column_to_rownames("rownames") %>%  # DESeq2 requires rownames
        dplyr::mutate(
            genotype = factor(genotype, level = "WT"),
            
            no_genotype = as.numeric(sapply( 
                as.character(genotype),
                switch,
                "WT" = 0,
                USE.NAMES = FALSE
            )),
            
            state = factor(state, levels = c("G1", "Q")),
            
            no_state = as.numeric(sapply( 
                as.character(state),
                switch,
                "G1" = 0,
                "Q" = 1,
                USE.NAMES = FALSE
            )),
            
            transcription = factor(transcription, levels = c("N", "SS")),
            
            no_transcription = as.numeric(sapply( 
                as.character(transcription),
                switch,
                "N" = 0,
                "SS" = 1,
                USE.NAMES = FALSE
            )),
            
            st_tx = factor(
                paste(state, transcription, sep = "_")
            ),
            
            no_st_tx = as.numeric(sapply( 
                as.character(st_tx),
                switch,
                "G1_SS" = 3,
                "G1_N" = 2,
                "Q_SS" = 1,
                "Q_N" = 0,
                USE.NAMES = FALSE
            )),
            
            replicate = factor(
                replicate, levels = c("rep1", "rep2", "rep2-Tecan")
            ),
            
            no_replicate = as.numeric(sapply( 
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                "rep2-Tecan" = 2,
                USE.NAMES = FALSE
            )),
            
            technical = factor(technical, levels = "tech1"),
            
            no_technical = as.numeric(sapply( 
                as.character(technical),
                switch,
                "tech1" = 0,
                USE.NAMES = FALSE
            )),
            
            #  Add additional variables for library-prep kit
            kit = factor(
                ifelse(replicate != "rep2-Tecan", "ovn", "tcn"),
                levels = c("ovn", "tcn")
            ),
            
            no_kit = as.numeric(sapply( 
                as.character(kit),
                switch,
                "tcn" = 1,
                "ovn" = 0,
                USE.NAMES = FALSE
            ))
        ) %>% dplyr::relocate(
            c(
                genotype, state, transcription, st_tx, replicate, technical,
                kit, no_genotype, no_state, no_transcription, no_st_tx,
                no_replicate, no_technical
            ),
            .before = no_kit
        )
}


#  If necessary, remove batch effects
if(samples == "test.Ovation_Rrp6∆") {
    norm_r <- limma::removeBatchEffect(
        SummarizedExperiment::assay(rld),
        # batch = rld$technical,
        # batch = rld$replicate,
        # batch = rld$kit,
        batch = rld$strange,
        design = model.matrix(
            ~1,
            # SummarizedExperiment::colData(rld)[, 1:6]        # technical
            # SummarizedExperiment::colData(rld)[, c(1:5, 7)]  # replicate
            # SummarizedExperiment::colData(rld)[, c(1:9)]     # kit
            SummarizedExperiment::colData(rld)[, c(1:8)]       # strange
        )
    ) %>%
        as.data.frame()
} else {
    norm_r <- SummarizedExperiment::assay(rld) %>% as.data.frame()
}

