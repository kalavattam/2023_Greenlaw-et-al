
# tmp1.R
# KA

Q_SS_r1_r6 <- c(
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"
)
Q_SS_wt_r6 <- c(
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"
)
Q_SS_wt_r1 <- c(
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"
)
G1_SS_wt_r6 <- c(
    "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1"
)

#  Make a named list
datasets_pw <- list(
    "Q_SS_r1_r6" = Q_SS_r1_r6,
    "Q_SS_wt_r6" = Q_SS_wt_r6,
    "Q_SS_wt_r1" = Q_SS_wt_r1,
    "G1_SS_wt_r6" = G1_SS_wt_r6
)

res_pw <- list()
for (i in 1:length(datasets_pw)) {
    # i <- 4
    cat(paste0(
        "#  --------------------------------------------------------\n",
        "#  Working with '", names(datasets_pw)[[i]], "'\n",
        "#  --------------------------------------------------------\n\n"
    ))
    
    res_pw[[names(datasets_pw)[[i]]]] <- list()
    
    #  0. Assign datasets -----------------------------------------------------
    cat("#+ 0. Datasets are...\n\n")
    print(datasets_pw[[i]])
    cat("\n")
    
    #  Initialize variable 'datasets'
    datasets <- datasets_pw[[i]]
    
    res_pw[[names(datasets_pw)[[i]]]][["n00_datasets"]] <- datasets
    
    
    #  1. Create 'counts_data' matrix -----------------------------------------
    cat(paste0(
        "#+ 1. Creating 'counts_data' matrix for '",
        names(datasets_pw)[[i]],
        "'\n\n"
    ))
    counts_data <- t_fc[, colnames(t_fc) %in% datasets] %>%
        as.data.frame()
    
    res_pw[[names(datasets_pw)[[i]]]][["n01_counts_data"]] <- counts_data
    
    
    #  2. Isolate datasets of interest ----------------------------------------
    cat(paste0(
        "#+ 2. Isolate datasets of interest for '",
        names(datasets_pw)[[i]],
        "' ('col_data')\n\n"
    ))
    
    col_data <- samples[samples$keys %in% datasets, ] %>%
        as.data.frame() %>%  #IMPORTANT Output a dataframe, not a tibble
        tibble::column_to_rownames(., var = "keys") %>%  #IMPORTANT Have row names
        droplevels()
    
    #NOTE Version that drops hyphens from values
    # col_data <- samples[samples$keys %in% datasets, ] %>%
    #     lapply(., gsub, pattern = "-", replacement = "") %>%  # Get rid of hyphens
    #     as.data.frame() %>%  #IMPORTANT Output a dataframe, not a tibble
    #     tibble::column_to_rownames(., var = "keys") %>%  #IMPORTANT Have row names
    #     droplevels()  # Drop any unused factor levels
    
    res_pw[[names(datasets_pw)[[i]]]][["n02_col_data"]] <- col_data
    
    
    #  3. Assign model numerators and denominators ----------------------------
    cat(paste0(
        "#+ 3. Assign model numerators and denominators for '",
        names(datasets_pw)[[i]],
        "'\n\n"
    ))
    
    what_combos <- list(
        "r1-n_r6-n" = c("r1-n", "r6-n"),
        "WT_r1-n" = c("WT", "r1-n"),
        "WT_r6-n" = c("WT", "r6-n")
    )
    what_levels <- col_data$strain %>% as.factor() %>% levels()
    # samples$strain %>% as.factor() %>% levels()
    
    #  Logic to carefully, correctly assign model numerators, denominators
    if(
        what_levels %in% what_combos[["r1-n_r6-n"]] %>%
            all() %>%
            isTRUE()
    ) {
        model_n <- "r6-n"
        model_d <- "r1-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(model_d, model_n)
        )
        model_string <- paste(levels(col_data$strain), collapse = " ")
    } else if(
        what_levels %in% what_combos[["WT_r1-n"]] %>%
            all() %>%
            isTRUE()
    ) {
        model_n <- "r1-n"
        model_d <- "WT"
        col_data$strain <- factor(
            col_data$strain, levels = c(model_d, model_n)
        )
        model_string <- paste(levels(col_data$strain), collapse = " ")
    } else if(
        what_levels %in% what_combos[["WT_r6-n"]] %>%
            all() %>%
            isTRUE()
    ) {
        model_n <- "r6-n"
        model_d <- "WT"
        col_data$strain <- factor(
            col_data$strain, levels = c(model_d, model_n)
        )
        model_string <- paste(levels(col_data$strain), collapse = " ")
    }

    #  Logic to include "technical" in the GLM or not
    if(isTRUE(any(unique(col_data$technical) %in% "tech2"))) {
        model_linear <- "~ technical + strain"
    } else if(isFALSE(any(unique(col_data$technical) %in% "tech2"))) {
        model_linear <- "~ strain"
    }
    
    cat(paste0(
        "       numerator  ", model_n, "\n",
        "     denominator  ", model_d, "\n",
        "     level-order  ", model_string, "\n",
        "    model-linear  ", model_linear, "\n\n"
    ))
    
    res_pw[[names(datasets_pw)[[i]]]][["n03_model_n"]] <- model_n
    res_pw[[names(datasets_pw)[[i]]]][["n03_model_d"]] <- model_d
    res_pw[[names(datasets_pw)[[i]]]][["n03_model_string"]] <- model_string
    res_pw[[names(datasets_pw)[[i]]]][["n03_model_linear"]] <- model_string
    
    
    #  4. Perform appropriate factor-to-integer conversions -------------------
    cat(paste0(
        "#+ 4. Perform factor-to-integer conversions for '",
        names(datasets_pw)[[i]],
        "' variables 'strain', 'replicate', and 'technical' (i.e., batch)\n\n"
    ))
    
    #TODO I think this is fine; however, if not, then add if/else logic 
    col_data$no_strain <- sapply(
        as.character(col_data$strain),
        switch,
        "WT" = 1,
        "r1-n" = 2,
        "r6-n" = 3,
        USE.NAMES = FALSE
    )
    col_data$no_replicate <- sapply(
        as.character(col_data$replicate),
        switch,
        "rep1" = 1,
        "rep2" = 2,
        USE.NAMES = FALSE
    )
    col_data$no_technical <- sapply(
        as.character(col_data$technical),
        switch,
        "tech1" = 1,
        "tech2" = 2,
        USE.NAMES = FALSE
    )

    res_pw[[names(datasets_pw)[[i]]]][["n04_col_data"]] <- col_data
    
    
    #  5. Make DESeqDataSet (dds) object --------------------------------------
    cat(paste0(
        "#+ 5. Make the DESeqDataSet (dds) object for '",
        names(datasets_pw)[[i]],
        "'\n\n"
    ))
    
    dds <- DESeq2::DESeqDataSetFromMatrix(
        countData = counts_data,
        colData = col_data,
        design = as.formula(eval(model_linear)),
        rowRanges = pos_info
    )
    
    res_pw[[names(datasets_pw)[[i]]]][["n05_dds"]] <- dds
    res_pw[[names(datasets_pw)[[i]]]][["n05_design"]] <- dds@design
    
    
    #  6. Run DE analyses -----------------------------------------------------
    cat(paste0(
        "#+ 6. Run DE analyses for '", names(datasets_pw)[[i]],
        "', examining S. cerevisiae features and ",
        "using S. cerevisiae features for size-factor estimation\n\n"
    ))
    
    
    #  6a. Perform size-factor estimation -------
    cat(paste0(
        "#+ 6a. Perform size-factor estimation\n\n"
    ))

    dds_SC <- BiocGenerics::estimateSizeFactors(
        dds[dds@rowRanges$genome != "K_lactis", ]
    )

    sf_samples <- dds_SC$sizeFactor %>% names() %>% tibble::as_tibble()
    sf_values <- dds_SC$sizeFactor %>% tibble::as_tibble()
    sf_tbl_SC <- dplyr::bind_cols(sf_samples, sf_values)
    colnames(sf_tbl_SC) <- c("samples", "size_factors")
    rm(sf_samples, sf_values)

    res_pw[[names(datasets_pw)[[i]]]][["n06a_dds_SC"]] <- dds_SC
    res_pw[[names(datasets_pw)[[i]]]][["n06a_sf_tbl_SC"]] <- sf_tbl_SC
    
    
    #  6b. Call DESeq2 w/default parameters -----
    cat(paste0(
        "#+ 6b. Call DESeq2 using default parameters\n\n"
    ))

    dds_SC <- DESeq2::DESeq(dds_SC)

    #  Check model information
    cat(paste0(
        "DESeq2 model information: '", DESeq2::resultsNames(dds_SC)[2], "'\n\n",
        "Thus, the model varies on strain, the left sample is the numerator, ",
        "the right sample is the denominator\n",
        "    - Numerator: top in MA plots, right in volcano plots\n",
        "    - Denominator: bottom in MA plots, left in volcano plots\n\n"
    ))

    res_pw[[names(datasets_pw)[[i]]]][["n06b_dds_SC"]] <- dds_SC
    
    
    #  6c. Call DESeq2::results() ---------------
    cat(paste0(
        "#+ 6c. Call DESeq2::results()\n\n"
    ))

    #  Set up necessary parameters for generation of DESeq2 results table
    independent_filtering <- TRUE
    threshold_p <- 0.05
    threshold_lfc <- 0

    cat(paste0(
        "     independent_filtering  ", independent_filtering, "\n",
        "               threshold_p  ", threshold_p, "\n",
        "             threshold_lfc  ", threshold_lfc, "\n",
        "    DESeq2::results() name  ",
        DESeq2::resultsNames(dds_SC)[length(DESeq2::resultsNames(dds_SC))],
        "\n\n"
    ))

    #  Output a DESeq2 DataFrame object
    DGE_unshrunken_DF_SC <- DESeq2::results(
        dds_SC,
        name = DESeq2::resultsNames(dds_SC)[
            length(DESeq2::resultsNames(dds_SC))
        ],  #IMPORTANT Must select the last term for the reduced model!
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "DataFrame"
    )

    #  Output a GRanges object, which we can easily add to and convert to other
    #+ formats (such as a tibble)
    DGE_unshrunken_GR_SC <- DESeq2::results(
        dds_SC,
        name = DESeq2::resultsNames(dds_SC)[
            length(DESeq2::resultsNames(dds_SC))
        ],  #IMPORTANT Must select the last term for the reduced model!
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "GRanges"
    )
    DGE_unshrunken_GR_SC$length <- MatrixGenerics::rowRanges(
        dds_SC
    )$length
    DGE_unshrunken_GR_SC$feature <- MatrixGenerics::rowRanges(
        dds_SC
    )$feature
    DGE_unshrunken_GR_SC$feature_init <- MatrixGenerics::rowRanges(
        dds_SC
    )$feature_init
    DGE_unshrunken_GR_SC$type <- MatrixGenerics::rowRanges(
        dds_SC
    )$type
    DGE_unshrunken_GR_SC$genome <- MatrixGenerics::rowRanges(
        dds_SC
    )$genome

    t_DGE_SC <- DGE_unshrunken_GR_SC %>%
        dplyr::as_tibble() %>%
        dplyr::rename(chr = seqnames)

    res_pw[[names(datasets_pw)[[i]]]][["n06c_independent_filtering"]] <- independent_filtering
    res_pw[[names(datasets_pw)[[i]]]][["n06c_threshold_p"]] <- threshold_p
    res_pw[[names(datasets_pw)[[i]]]][["n06c_threshold_lfc"]] <- threshold_lfc
    res_pw[[names(datasets_pw)[[i]]]][["n06c_DGE_unshrunken_DF_SC"]] <- DGE_unshrunken_DF_SC
    res_pw[[names(datasets_pw)[[i]]]][["n06c_DGE_unshrunken_GR_SC"]] <- DGE_unshrunken_GR_SC
    res_pw[[names(datasets_pw)[[i]]]][["n06c_t_DGE_SC"]] <- t_DGE_SC

    rm(independent_filtering, threshold_p, threshold_lfc)
    
    
    #  6d. Make an MA plot ----------------------
    cat(paste0(
        "#+ 6d. Make an MA plot that colors features by ",
        "independent filtering\n\n"
    ))

    #  Set up temporary variable 'tbl', which will be passed to ggplot
    tbl <- t_DGE_SC
    tbl <- tbl[with(tbl, order(log2FoldChange)), ]
    tbl$threshold <- as.factor(tbl$padj <= 0.05)
    tbl$log10baseMean <- ifelse(
        is.infinite(log10(tbl$baseMean)), NA, log10(tbl$baseMean)
    )

    title <- names(datasets_pw)[[i]]
    subtitle <- paste(
        "MA plot",
        "| S. cerevisiae features",
        "| size factors estimated with all S. cerevisiae features",
        "|\npoints: S. cerevisiae features",
        "| top: up in", model_n,
        "| bottom: up in", model_d
    )
    MA_SC <- ggplot(
        tbl, aes(x = log10baseMean, y = log2FoldChange, colour = threshold)
    ) +
        geom_point(alpha = 0.25, size = 0.5) +
        geom_hline(aes(yintercept = 0), colour = "#000000", linewidth = 0.25) +
        xlim(c(0, 6)) +
        ylim(c(-14, 14)) +
        # ylim(c(min(tbl$log2FoldChange), max(tbl$log2FoldChange))) +
        xlab("log10(mean normalized counts)") +
        ylab("log2(fold change)") +
        scale_colour_discrete(name = "q ≤ 0.05") +
        ggtitle(title, subtitle) +
        theme_slick
    MA_SC

    #  Create a vector of features that both passed independent filtering (and
    #+ thus have an inherently high mean expression) and are not statistically
    #+ significant; this vector signifies features that are "stably expressed"
    #+ between conditions
    tbl$stably_expressed <- ifelse(
        !is.na(tbl$threshold) & tbl$padj > 0.05,
        TRUE,
        FALSE
    )
    stably_expressed_SC <- tbl$feature[tbl$stably_expressed == TRUE]

    res_pw[[names(datasets_pw)[[i]]]][["n06d_tbl"]] <- tbl
    res_pw[[names(datasets_pw)[[i]]]][["n06d_title"]] <- title
    res_pw[[names(datasets_pw)[[i]]]][["n06d_subtitle"]] <- subtitle
    res_pw[[names(datasets_pw)[[i]]]][["n06d_MA_SC"]] <- MA_SC
    res_pw[[names(datasets_pw)[[i]]]][["n06d_stably_expressed_SC"]] <- stably_expressed_SC

    rm(tbl, title, subtitle)
    
    
    #  6e. Make a volcano plot ------------------
    cat(paste0(
        "#+ 6e. Make a volcano plot\n\n"
    ))

    #  Identify and isolate the top 5 upregulated features and the top 5 down-
    #+ regulated features
    all <- t_DGE_SC$feature
    selection_down <- t_DGE_SC %>%
        dplyr::filter(log2FoldChange < 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection_up <- t_DGE_SC %>%
        dplyr::filter(log2FoldChange > 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection <- c(selection_down[["feature"]], selection_up[["feature"]]) %>%
            as.character()

    title <- names(datasets_pw)[[i]]
    subtitle <- paste(
        "volcano plot",
        "| S. cerevisiae features",
        "| size factors estimated with all S. cerevisiae features",
        "|\npoints: S. cerevisiae features",
        "| left: up in", model_d,
        "| right: up in", model_n,
        "|\nlabels: top 5", model_d, "and top 5", model_n, "features"
    )
    volcano_SC <- plot_volcano(
        table = t_DGE_SC,
        label = all,
        selection = selection,
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = 1,
        xlim = c(
            (max(abs(t_DGE_SC$log2FoldChange), na.rm = TRUE) * -1),
            max(abs(t_DGE_SC$log2FoldChange), na.rm = TRUE)
        ),
        # xlim = c(-14, 14),
        ylim = c(
            0,
            max((log10(t_DGE_SC$padj) * -1), na.rm = TRUE)
        ),
        # ylim = c(0, 10),
        # ylim = c(0, 310),
        color = "#52BE9B",
        title = title,
        subtitle = subtitle
    )
    volcano_SC

    res_pw[[names(datasets_pw)[[i]]]][["n06e_all"]] <- all
    res_pw[[names(datasets_pw)[[i]]]][["n06e_selection_down"]] <- selection_down
    res_pw[[names(datasets_pw)[[i]]]][["n06e_selection_up"]] <- selection_up
    res_pw[[names(datasets_pw)[[i]]]][["n06e_selection"]] <- selection
    res_pw[[names(datasets_pw)[[i]]]][["n06e_title"]] <- title
    res_pw[[names(datasets_pw)[[i]]]][["n06e_subtitle"]] <- subtitle
    res_pw[[names(datasets_pw)[[i]]]][["n06e_volcano_SC"]] <- volcano_SC

    rm(all, selection, selection_up, selection_down, title, subtitle)
    
    
    #  7. Run DE analyses --------------
    cat(paste0(
        "#+ 7. Run DE analyses for '", names(datasets_pw)[[i]],
        "', examining K. lactis features and ",
        "using K. lactis features for size-factor estimation\n\n"
    ))

    #  7a -----------------------------
    cat(paste0(
        "#+ 7a. Perform size-factor estimation\n\n"
    ))

    dds_KL <- BiocGenerics::estimateSizeFactors(
        dds[dds@rowRanges$genome != "S_cerevisiae", ]
    )

    sf_samples <- dds_KL$sizeFactor %>% names() %>% tibble::as_tibble()
    sf_values <- dds_KL$sizeFactor %>% tibble::as_tibble()
    sf_tbl_KL <- dplyr::bind_cols(sf_samples, sf_values)
    colnames(sf_tbl_KL) <- c("samples", "size_factors")
    rm(sf_samples, sf_values)

    res_pw[[names(datasets_pw)[[i]]]][["n07a_dds_KL"]] <- dds_KL
    res_pw[[names(datasets_pw)[[i]]]][["n07a_sf_tbl_KL"]] <- sf_tbl_KL

    #  7b -----------------------------
    cat(paste0(
        "#+ 7b. Call DESeq2 using default parameters\n\n"
    ))

    dds_KL <- DESeq2::DESeq(dds_KL)

    #  Check model information
    cat(paste0(
        "DESeq2 model information: '", DESeq2::resultsNames(dds_KL)[2], "'\n\n",
        "Thus, the model varies on strain, the left sample is the numerator, ",
        "the right sample is the denominator\n",
        "    - Numerator: top in MA plots, right in volcano plots\n",
        "    - Denominator: bottom in MA plots, left in volcano plots\n\n"
    ))

    res_pw[[names(datasets_pw)[[i]]]][["n07b_dds_KL"]] <- dds_KL

    #  7c -----------------------------
    cat(paste0(
        "#+ 7c. Call DESeq2::results()\n\n"
    ))

    #  Set up necessary parameters for generation of DESeq2 results table
    independent_filtering <- TRUE
    threshold_p <- 0.05
    threshold_lfc <- 0

    cat(paste0(
        "     independent_filtering  ", independent_filtering, "\n",
        "               threshold_p  ", threshold_p, "\n",
        "             threshold_lfc  ", threshold_lfc, "\n",
        "    DESeq2::results() name  ",
        DESeq2::resultsNames(dds_KL)[length(DESeq2::resultsNames(dds_KL))],
        "\n\n"
    ))

    #  Output a DESeq2 DataFrame object
    DGE_unshrunken_DF_KL <- DESeq2::results(
        dds_KL,
        name = DESeq2::resultsNames(dds_KL)[
            length(DESeq2::resultsNames(dds_KL))
        ],  #IMPORTANT Must select the last term for the reduced model!
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "DataFrame"
    )

    #  Output a GRanges object, which we can easily add to and convert to other
    #+ formats (such as a tibble)
    DGE_unshrunken_GR_KL <- DESeq2::results(
        dds_KL,
        name = DESeq2::resultsNames(dds_KL)[
            length(DESeq2::resultsNames(dds_KL))
        ],  #IMPORTANT Must select the last term for the reduced model!
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "GRanges"
    )
    DGE_unshrunken_GR_KL$length <- MatrixGenerics::rowRanges(
        dds_KL
    )$length
    DGE_unshrunken_GR_KL$feature <- MatrixGenerics::rowRanges(
        dds_KL
    )$feature
    DGE_unshrunken_GR_KL$feature_init <- MatrixGenerics::rowRanges(
        dds_KL
    )$feature_init
    DGE_unshrunken_GR_KL$type <- MatrixGenerics::rowRanges(
        dds_KL
    )$type
    DGE_unshrunken_GR_KL$genome <- MatrixGenerics::rowRanges(
        dds_KL
    )$genome

    t_DGE_KL <- DGE_unshrunken_GR_KL %>%
        dplyr::as_tibble() %>%
        dplyr::rename(chr = seqnames)

    res_pw[[names(datasets_pw)[[i]]]][["n07c_independent_filtering"]] <- independent_filtering
    res_pw[[names(datasets_pw)[[i]]]][["n07c_threshold_p"]] <- threshold_p
    res_pw[[names(datasets_pw)[[i]]]][["n07c_threshold_lfc"]] <- threshold_lfc
    res_pw[[names(datasets_pw)[[i]]]][["n07c_DGE_unshrunken_DF_KL"]] <- DGE_unshrunken_DF_KL
    res_pw[[names(datasets_pw)[[i]]]][["n07c_DGE_unshrunken_GR_KL"]] <- DGE_unshrunken_GR_KL
    res_pw[[names(datasets_pw)[[i]]]][["n07c_t_DGE_KL"]] <- t_DGE_KL

    rm(independent_filtering, threshold_p, threshold_lfc)

    #  7d -----------------------------
    cat(paste0(
        "#+ 7d. Make an MA plot that colors features by ",
        "independent filtering\n\n"
    ))

    #  Set up temporary variable 'tbl', which will be passed to ggplot
    tbl <- t_DGE_KL
    tbl <- tbl[with(tbl, order(log2FoldChange)), ]
    tbl$threshold <- as.factor(tbl$padj <= 0.05)
    tbl$log10baseMean <- ifelse(
        is.infinite(log10(tbl$baseMean)), NA, log10(tbl$baseMean)
    )

    title <- names(datasets_pw)[[i]]
    subtitle <- paste(
        "MA plot",
        "| K. lactis features",
        "| size factors estimated with all K. lactis features",
        "|\npoints: K. lactis features",
        "| top: up in", model_n,
        "| bottom: up in", model_d
    )
    MA_KL <- ggplot(
        tbl, aes(x = log10baseMean, y = log2FoldChange, colour = threshold)
    ) +
        geom_point(alpha = 0.25, size = 0.5) +
        geom_hline(aes(yintercept = 0), colour = "#000000", linewidth = 0.25) +
        # geom_hline(aes(yintercept = 0), colour = "#000000", size = 0.25) +
        xlim(c(0, 6)) +
        ylim(c(-14, 14)) +
        # ylim(c(min(tbl$log2FoldChange), max(tbl$log2FoldChange))) +
        xlab("log10(mean normalized counts)") +
        ylab("log2(fold change)") +
        scale_colour_discrete(name = "q ≤ 0.05") +
        ggtitle(title, subtitle) +
        theme_slick
    MA_KL
    #TODO 1/2 Explain and make a decision regarding use of 'size' or 'linewidth'
    #TODO 2/2 parameters

    #  Create a vector of features that both passed independent filtering (and
    #+ thus have an inherently high mean expression) and are not statistically
    #+ significant; this vector signifies features that are "stably expressed"
    #+ between conditions
    tbl$stably_expressed <- ifelse(
        !is.na(tbl$threshold) & tbl$padj > 0.05,
        TRUE,
        FALSE
    )
    stably_expressed_KL <- tbl$feature[tbl$stably_expressed == TRUE]

    res_pw[[names(datasets_pw)[[i]]]][["n07d_tbl"]] <- tbl
    res_pw[[names(datasets_pw)[[i]]]][["n07d_title"]] <- title
    res_pw[[names(datasets_pw)[[i]]]][["n07d_subtitle"]] <- subtitle
    res_pw[[names(datasets_pw)[[i]]]][["n07d_MA_KL"]] <- MA_KL
    res_pw[[names(datasets_pw)[[i]]]][["n07d_stably_expressed_KL"]] <- stably_expressed_KL

    rm(tbl, title, subtitle)

    #  7e -----------------------------
    cat(paste0(
        "#+ 7e. Make a volcano plot\n\n"
    ))

    #  Identify and isolate the top 5 upregulated features and the top 5 down-
    #+ regulated features
    all <- t_DGE_KL$feature
    selection_down <- t_DGE_KL %>%
        dplyr::filter(log2FoldChange < 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection_up <- t_DGE_KL %>%
        dplyr::filter(log2FoldChange > 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection <- c(selection_down[["feature"]], selection_up[["feature"]]) %>%
            as.character()

    title <- names(datasets_pw)[[i]]
    subtitle <- paste(
        "volcano plot",
        "| K. lactis features",
        "| size factors estimated with all K. lactis features",
        "|\npoints: K. lactis features",
        "| left: up in", model_d,
        "| right: up in", model_n,
        "|\nlabels: top 5", model_d, "and top 5", model_n, "features"
    )
    volcano_KL <- plot_volcano(
        table = t_DGE_KL,
        label = all,
        selection = selection,
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = 1,
        xlim = c(
            (max(abs(t_DGE_KL$log2FoldChange), na.rm = TRUE) * -1),
            max(abs(t_DGE_KL$log2FoldChange), na.rm = TRUE)
        ),
        # xlim = c(-14, 14),
        ylim = c(
            0,
            max((log10(t_DGE_KL$padj) * -1), na.rm = TRUE)
        ),
        # ylim = c(0, 10),
        # ylim = c(0, 310),
        color = "#52BE9B",
        title = title,
        subtitle = subtitle
    )
    volcano_KL

    res_pw[[names(datasets_pw)[[i]]]][["n07e_all"]] <- all
    res_pw[[names(datasets_pw)[[i]]]][["n07e_selection_down"]] <- selection_down
    res_pw[[names(datasets_pw)[[i]]]][["n07e_selection_up"]] <- selection_up
    res_pw[[names(datasets_pw)[[i]]]][["n07e_selection"]] <- selection
    res_pw[[names(datasets_pw)[[i]]]][["n07e_title"]] <- title
    res_pw[[names(datasets_pw)[[i]]]][["n07e_subtitle"]] <- subtitle
    res_pw[[names(datasets_pw)[[i]]]][["n07e_volcano_KL"]] <- volcano_KL

    rm(all, selection, selection_up, selection_down, title, subtitle)
    
    #  8 ------------------------------
    cat(paste0(
        "#+ 8. Run DE analyses for '", names(datasets_pw)[[i]],
        "', examining S. cerevisiae features and ",
        "using K. lactis features for size-factor estimation\n\n"
    ))
    
    #  8a -----------------------------
    cat(paste0(
        "#+ 8a. Perform size-factor estimation\n\n"
    ))
    
    dds_SC.ctrl_KL <- BiocGenerics::estimateSizeFactors(
        dds,
        controlGenes = (dds@rowRanges$genome == "K_lactis")
    )
    #OK
    
    sf_samples <- dds_SC.ctrl_KL$sizeFactor %>% names() %>% tibble::as_tibble()
    sf_values <- dds_SC.ctrl_KL$sizeFactor %>% tibble::as_tibble()
    sf_tbl_SC.ctrl_KL <- dplyr::bind_cols(sf_samples, sf_values)
    colnames(sf_tbl_SC.ctrl_KL) <- c("samples", "size_factors")
    rm(sf_samples, sf_values)
    
    res_pw[[names(datasets_pw)[[i]]]][["n08a_dds_SC.ctrl_KL"]] <- dds_SC.ctrl_KL
    res_pw[[names(datasets_pw)[[i]]]][["n08a_sf_tbl_SC.ctrl_KL"]] <- sf_tbl_SC.ctrl_KL
    
    #  8b -----------------------------
    cat(paste0(
        "#+ 8b. Call DESeq2 using default parameters\n\n"
    ))
    
    dds_SC.ctrl_KL <- DESeq2::DESeq(
        dds_SC.ctrl_KL[dds_SC.ctrl_KL@rowRanges$genome != "K_lactis", ]
    )
    
    #  Check model information
    #TODO #IMPORTANT Make message adaptable depending on if "tech2" is present
    cat(paste0(
        "DESeq2 model information: '",
        paste(DESeq2::resultsNames(dds_SC.ctrl_KL), collapse = ", "), "'\n\n",
        "If three terms are present above, then the model regresses out ",
        "'technical' (i.e., batch) and varies on 'strain' with no additional ",
        "regression. If only two terms are present, then the model varies on ",
        "'strain'. The left sample is the numerator, and the right sample is ",
        "the denominator.\n",
        "    - Numerator: top in MA plots, right in volcano plots\n",
        "    - Denominator: bottom in MA plots, left in volcano plots\n\n"
    ))
    
    res_pw[[names(datasets_pw)[[i]]]][["n08b_dds_SC.ctrl_KL"]] <- dds_SC.ctrl_KL

    #  8c -----------------------------
    cat(paste0(
        "#+ 8c. Call DESeq2::results()\n\n"
    ))
    
    #  Set up necessary parameters for generation of DESeq2 results table
    independent_filtering <- TRUE
    threshold_p <- 0.05
    threshold_lfc <- 0
    
    cat(paste0(
        "    independent_filtering  ", independent_filtering, "\n",
        "              threshold_p  ", threshold_p, "\n",
        "             threshold_lfc  ", threshold_lfc, "\n",
        "    DESeq2::results() name  ",
        DESeq2::resultsNames(dds_SC.ctrl_KL)[
            length(DESeq2::resultsNames(dds_SC.ctrl_KL))
        ], "\n\n"
    ))
    
    #  Output a DESeq2 DataFrame object
    DGE_unshrunken_DF_SC.ctrl_KL <- DESeq2::results(
        dds_SC.ctrl_KL,
        name = DESeq2::resultsNames(dds_SC.ctrl_KL)[
            length(DESeq2::resultsNames(dds_SC.ctrl_KL))
        ],  #IMPORTANT Must select the last term for the reduced model!
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "DataFrame"
    )
    
    #  Output a GRanges object, which we can easily add to and convert to other
    #+ formats (such as a tibble)
    DGE_unshrunken_GR_SC.ctrl_KL <- DESeq2::results(
        dds_SC.ctrl_KL,
        name = DESeq2::resultsNames(dds_SC.ctrl_KL)[
            length(DESeq2::resultsNames(dds_SC.ctrl_KL))
        ],  #IMPORTANT Must select the last term for the reduced model!
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "GRanges"
    )
    DGE_unshrunken_GR_SC.ctrl_KL$length <- MatrixGenerics::rowRanges(
        dds_SC.ctrl_KL
    )$length
    DGE_unshrunken_GR_SC.ctrl_KL$feature <- MatrixGenerics::rowRanges(
        dds_SC.ctrl_KL
    )$feature
    DGE_unshrunken_GR_SC.ctrl_KL$feature_init <- MatrixGenerics::rowRanges(
        dds_SC.ctrl_KL
    )$feature_init
    DGE_unshrunken_GR_SC.ctrl_KL$type <- MatrixGenerics::rowRanges(
        dds_SC.ctrl_KL
    )$type
    DGE_unshrunken_GR_SC.ctrl_KL$genome <- MatrixGenerics::rowRanges(
        dds_SC.ctrl_KL
    )$genome
    
    t_DGE_SC.ctrl_KL <- DGE_unshrunken_GR_SC.ctrl_KL %>%
        dplyr::as_tibble() %>%
        dplyr::rename(chr = seqnames)
    
    res_pw[[names(datasets_pw)[[i]]]][["n08c_independent_filtering"]] <- independent_filtering
    res_pw[[names(datasets_pw)[[i]]]][["n08c_threshold_p"]] <- threshold_p
    res_pw[[names(datasets_pw)[[i]]]][["n08c_threshold_lfc"]] <- threshold_lfc
    res_pw[[names(datasets_pw)[[i]]]][["n08c_DGE_unshrunken_DF_SC.ctrl_KL"]] <- DGE_unshrunken_DF_SC.ctrl_KL
    res_pw[[names(datasets_pw)[[i]]]][["n08c_DGE_unshrunken_GR_SC.ctrl_KL"]] <- DGE_unshrunken_GR_SC.ctrl_KL
    res_pw[[names(datasets_pw)[[i]]]][["n08c_t_DGE_SC.ctrl_KL"]] <- t_DGE_SC.ctrl_KL
    
    rm(independent_filtering, threshold_p, threshold_lfc)
    
    #  8d -----------------------------
    cat(paste0(
        "#+ 8d. Make an MA plot that colors features by ",
        "independent filtering\n\n"
    ))
    
    #  Set up temporary variable 'tbl', which will be passed to ggplot
    tbl <- t_DGE_SC.ctrl_KL
    tbl <- tbl[with(tbl, order(log2FoldChange)), ]
    tbl$threshold <- as.factor(tbl$padj <= 0.05)
    tbl$log10baseMean <- ifelse(
        is.infinite(log10(tbl$baseMean)), NA, log10(tbl$baseMean)
    )
    
    title <- names(datasets_pw)[[i]]
    subtitle <- paste(
        "MA plot",
        "| S. cerevisiae features",
        "| size factors estimated with all K. lactis features",
        "|\npoints: S. cerevisiae features",
        "| top: up in", model_n,
        "| bottom: up in", model_d
    )
    MA_SC.ctrl_KL <- ggplot(
        tbl, aes(x = log10baseMean, y = log2FoldChange, colour = threshold)
    ) +
        geom_point(alpha = 0.25, size = 0.5) +
        geom_hline(aes(yintercept = 0), colour = "#000000", linewidth = 0.25) +
        # geom_hline(aes(yintercept = 0), colour = "#000000", size = 0.25) +
        xlim(c(0, 6)) +
        ylim(c(-14, 14)) +
        # ylim(c(min(tbl$log2FoldChange), max(tbl$log2FoldChange))) +
        xlab("log10(mean normalized counts)") +
        ylab("log2(fold change)") +
        scale_colour_discrete(name = "q ≤ 0.05") +
        ggtitle(title, subtitle) +
        theme_slick
    MA_SC.ctrl_KL

    #  Create a vector of features that both passed independent filtering (and
    #+ thus have an inherently high mean expression) and are not statistically
    #+ significant; this vector signifies features that are "stably expressed"
    #+ between conditions
    tbl$stably_expressed <- ifelse(
        !is.na(tbl$threshold) & tbl$padj > 0.05,
        TRUE,
        FALSE
    )
    stably_expressed_SC.ctrl_KL <- tbl$feature[tbl$stably_expressed == TRUE]
    
    res_pw[[names(datasets_pw)[[i]]]][["n08d_tbl"]] <- tbl
    res_pw[[names(datasets_pw)[[i]]]][["n08d_title"]] <- title
    res_pw[[names(datasets_pw)[[i]]]][["n08d_subtitle"]] <- subtitle
    res_pw[[names(datasets_pw)[[i]]]][["n08d_MA_SC.ctrl_KL"]] <- MA_SC.ctrl_KL
    res_pw[[names(datasets_pw)[[i]]]][["n08d_stably_expressed_SC.ctrl_KL"]] <- stably_expressed_SC.ctrl_KL
    
    rm(tbl, title, subtitle)
    
    #  8e -----------------------------
    cat(paste0(
        "#+ 8e. Make a volcano plot\n\n"
    ))
    
    #  Identify and isolate the top 5 upregulated features and the top 5 down-
    #+ regulated features
    all <- t_DGE_SC.ctrl_KL$feature
    selection_down <- t_DGE_SC.ctrl_KL %>%
        dplyr::filter(log2FoldChange < 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection_up <- t_DGE_SC.ctrl_KL %>%
        dplyr::filter(log2FoldChange > 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection <- c(selection_down[["feature"]], selection_up[["feature"]]) %>%
            as.character()
    
    title <- names(datasets_pw)[[i]]
    subtitle <- paste(
        "volcano plot",
        "| S. cerevisiae features",
        "| size factors estimated with all K. lactis features",
        "|\npoints: S. cerevisiae features",
        "| left: up in", model_d,
        "| right: up in", model_n,
        "|\nlabels: top 5", model_d, "and top 5", model_n, "features"
    )
    volcano_SC.ctrl_KL <- plot_volcano(
        table = t_DGE_SC.ctrl_KL,
        label = all,
        selection = selection,
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = 1,
        xlim = c(
            (max(abs(t_DGE_SC.ctrl_KL$log2FoldChange), na.rm = TRUE) * -1),
            max(abs(t_DGE_SC.ctrl_KL$log2FoldChange), na.rm = TRUE)
        ),
        # xlim = c(-14, 14),
        ylim = c(
            0,
            max((log10(t_DGE_SC.ctrl_KL$padj) * -1), na.rm = TRUE)
        ),
        # ylim = c(0, 10),
        # ylim = c(0, 310),
        color = "#52BE9B",
        title = title,
        subtitle = subtitle
    )
    volcano_SC.ctrl_KL
    
    res_pw[[names(datasets_pw)[[i]]]][["n08e_all"]] <- all
    res_pw[[names(datasets_pw)[[i]]]][["n08e_selection_down"]] <- selection_down
    res_pw[[names(datasets_pw)[[i]]]][["n08e_selection_up"]] <- selection_up
    res_pw[[names(datasets_pw)[[i]]]][["n08e_selection"]] <- selection
    res_pw[[names(datasets_pw)[[i]]]][["n08e_title"]] <- title
    res_pw[[names(datasets_pw)[[i]]]][["n08e_subtitle"]] <- subtitle
    res_pw[[names(datasets_pw)[[i]]]][["n08e_volcano_SC.ctrl_KL"]] <- volcano_SC.ctrl_KL
    
    rm(all, selection, selection_up, selection_down, title, subtitle)
}
