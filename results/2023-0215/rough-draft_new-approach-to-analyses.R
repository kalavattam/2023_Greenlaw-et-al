#!/usr/bin/env Rscript

#  rough-draft_new-approach-to-analyses.R
#  KA


#  Load libraries, set options ================================================
suppressMessages(library(apeglm))
suppressMessages(library(DESeq2))
suppressMessages(library(edgeR))
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
filter_process_counts_matrix <- function(named_character_vector) {
    #  Test
    # named_character_vector <- `N-SS-nab3d_N-SS-parental`
    
    df <- dplyr::bind_cols(
        t_mat[, 1:11],
        t_mat[, colnames(t_mat) %in% named_character_vector]
    )
    df <- dplyr::bind_cols(
        df[, 1:11],
        df[, 12:ncol(df)][, match(named_character_vector, colnames(df)[12:ncol(df)])]
    )
    names(df)[12:ncol(df)] <- names(named_character_vector)
    
    return(df)
}


plot_volcano <- function(
    table, label, selection, label_size, p_cutoff, FC_cutoff,
    xlim, ylim, color, title, subtitle, ...
) {
    # ...
    # :param table: dataframe of test statistics [df]
    # :param label: character vector of all variable names in param table [vec]
    # :param selection: character vector of selected variable names in param
    #                   table [vec]
    # :param label_size: size of label font [float]
    # :param p_cutoff: cut-off for statistical significance; a horizontal line
    #                  will be drawn at -log10(pCutoff); p is actually padj
    #                  [float]
    # :param FC_cutoff: cut-off for absolute log2 fold-change; vertical lines
    #                   will be drawn at the negative and positive values of
    #                   log2FCcutoff
    #                  [float]
    # :param xlim: limits of the x-axis [float]
    # :param ylim: limits of the y-axis [float]
    # :param color: color of DEGs, e.g., '#52BE9B' [hex]
    # :param title: plot title [chr]
    # :param subtitle: plot subtitle [chr]
    # :return volcano: ...
    volcano <- EnhancedVolcano::EnhancedVolcano(
        toptable = table,
        lab = label,
        selectLab = selection,
        x = "log2FoldChange",
        y = "padj",
        xlab = "log2(FC)",
        ylab = "-log10(padj)",
        pCutoff = p_cutoff,
        pCutoffCol = "padj",
        FCcutoff = FC_cutoff,
        xlim = xlim,
        ylim = ylim,
        cutoffLineType = "dashed",
        cutoffLineWidth = 0.2,
        pointSize = 1,
        shape = 16,
        colAlpha = 0.25,
        col = c("#D3D3D3", "#D3D3D3", "#D3D3D3", color),
        title = NULL,
        subtitle = NULL,
        caption = NULL,
        borderColour = "#000000",
        borderWidth = 0.2,
        gridlines.major = TRUE,
        gridlines.minor = TRUE,
        axisLabSize = 10,
        labSize = label_size,
        boxedLabels = TRUE,
        parseLabels = TRUE,
        drawConnectors = TRUE,
        widthConnectors = 0.2,
        colConnectors = 'black',
        max.overlaps = Inf
    ) +
        theme_slick_no_legend +
        ggplot2::ggtitle(title, subtitle = subtitle)
    
    return(volcano)
}


call_DESeq2_results_gt_run_analyses <- function(
    dds,
    independent_filtering =  TRUE,
    threshold_p = 0.05,
    threshold_lfc = 0.58,
    x_min = -14,
    x_max = 14,
    y_min = 0,
    y_max = 310,
    color = "#A020F0",
    selection = TRUE
) {
    # ...
    # :param dds: ...
    # :return ...: ...
    if(base::isFALSE(is.logical(selection))) {
        stop("Argument \"selection\" must be TRUE or FALSE <lgl>")
    }
        
    #  Test  #HERE
    # dds <- dds
    # independent_filtering <- TRUE
    # threshold_p <- 0.05
    # threshold_lfc <- 2
    # x_min <- -5
    # x_max <- 10
    # y_min <- 0
    # y_max <- 40
    # color <- "#113275"
    # selection <- FALSE
    
    
    #  Standard tests of LFC ==================================================
    #  Initialize a DESeq2 DataFrame object
    DGE_unshrunken_DF <- DESeq2::results(
        dds,
        name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "DataFrame"
    )
    
    DGE_shrunken_DF <- DESeq2::lfcShrink(
  	    dds,
  	    coef = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
  	    res = DGE_unshrunken_DF,
  	    type = "apeglm",
  	    lfcThreshold = threshold_lfc,
  	    format = "DataFrame",
  	    parallel = TRUE
    )
    
    #  Initialize a GRanges object, which we can easily add to and convert to
    #+ other formats (such as a tibble)
    DGE_unshrunken_GR <- DESeq2::results(
        dds,
        name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "GRanges"
    )
    DGE_unshrunken_GR$features <- MatrixGenerics::rowRanges(dds)$features
    DGE_unshrunken_GR$names <- MatrixGenerics::rowRanges(dds)$names
    DGE_unshrunken_GR$thorough <- MatrixGenerics::rowRanges(dds)$thorough
    DGE_unshrunken_GR$type <- MatrixGenerics::rowRanges(dds)$type
    DGE_unshrunken_GR$genome <- MatrixGenerics::rowRanges(dds)$genome
    
    DGE_shrunken_GR <- DESeq2::lfcShrink(
  	    dds,
  	    coef = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
  	    res = DGE_unshrunken_DF,
  	    type = "apeglm",
  	    lfcThreshold = threshold_lfc,
  	    format = "GRanges",
  	    parallel = TRUE
    )
    DGE_shrunken_GR$features <- MatrixGenerics::rowRanges(dds)$features
    DGE_shrunken_GR$names <- MatrixGenerics::rowRanges(dds)$names
    DGE_shrunken_GR$thorough <- MatrixGenerics::rowRanges(dds)$thorough
    DGE_shrunken_GR$type <- MatrixGenerics::rowRanges(dds)$type
    DGE_shrunken_GR$genome <- MatrixGenerics::rowRanges(dds)$genome
    
    
    #  Without LFC shrinkage ----------------------------------------------
    #  Coerce GRanges object to tibble
    t_DGE_unshrunken <- DGE_unshrunken_GR %>% dplyr::as_tibble()
    
    #  Make a volcano plot
    all_unshrunken <- t_DGE_unshrunken$thorough
    if(base::isTRUE(selection)) {
        selection_down_unshrunken <- t_DGE_unshrunken %>%
            dplyr::filter(log2FoldChange < 0) %>%
            dplyr::arrange(padj) %>%
            dplyr::slice(1:5)
        selection_up_unshrunken <- t_DGE_unshrunken %>%
            dplyr::filter(log2FoldChange > 0) %>%
            dplyr::arrange(padj) %>%
            dplyr::slice(1:5)
        selection_unshrunken <- as.character(c(
            selection_down_unshrunken[["thorough"]],
            selection_up_unshrunken[["thorough"]]
        ))
    } else {
        selection_unshrunken <- ""
    }
    
    sample_info <- colData(dds) %>%
        rownames() %>%
        sort() %>%
        stringr::str_split("_") %>%
        as.data.frame()
    name_exp <- sample_info[1, 1]
    name_ctrl <- sample_info[1, ncol(sample_info)]
    sample_info <- paste(
        sample_info[1, c(1, 4)],
        sample_info[3, 1],
        sample_info[2, 1]
    ) %>%
        paste(., collapse = " vs. ")
    model_info <- dds@design
    title <- paste0("volcano plot")
    subtitle <- paste(
        "points: S. cerevisiae features",
        "| size factors: K. lactis features",
        "\nsamples:", sample_info,
        "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
        "\nleft: up in", name_ctrl,
        "| right: up in", name_exp
    )
    
    p_vol_unshrunken <- plot_volcano(
        table = t_DGE_unshrunken,
        label = all_unshrunken,
        selection = selection_unshrunken,
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = threshold_lfc,
        xlim = c(x_min, x_max),
        ylim = c(0, y_max),
        color = color,
        title = title,
        subtitle = subtitle
    )
    
    #  Make an MA plot
    title <- "MA plot"
    subtitle <- paste(
        "points: S. cerevisiae features",
        "| size factors: K. lactis features",
        "\nsamples:", sample_info,
        "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
        "\nbottom: up in", name_ctrl,
        "| top: up in", name_exp
    )
    
    p_MA_unshrunken <- ggplot(
        t_DGE_unshrunken,
        aes(
            x = ifelse(is.infinite(log10(baseMean)), NA, log10(baseMean)),
            y = log2FoldChange,
            colour = as.factor(padj <= 0.05)
        )
    ) +
        geom_point(alpha = 0.25, size = 0.5) +
        ylim(c(x_min, x_max)) +
        xlab("log10(mean normalized counts)") +
        ylab("log2(fold change)") +
        scale_colour_discrete(name = "q ≤ 0.05") +
        ggtitle(title, subtitle) +
        theme_slick +
        ggrepel::geom_label_repel(
            data = t_DGE_unshrunken[
                t_DGE_unshrunken$thorough %in% selection_unshrunken,
            ],
            aes(label = selection_unshrunken),
            label.size = 0.25,
            color = "#000000",
            size = 2.5
        )
    
    #  Tally number of features greater than LFC threshold and less than
    #+ padj threshold
    n_feat_gt_lfc_lt_padj_unshrunken <- table(
        t_DGE_unshrunken$log2FoldChange > threshold_lfc &
        t_DGE_unshrunken$padj < threshold_p
    )
    
    
    #  With LFC shrinkage -------------------------------------------------
    #  Coerce GRanges object to tibble
    t_DGE_shrunken <- DGE_shrunken_GR %>% dplyr::as_tibble()
    if("svalue" %in% names(t_DGE_shrunken)) {
        names(t_DGE_shrunken)[9] <- "padj"
        p_cutoff <- 0.005
    } else {
        p_cutoff <- 0.05
    }
    
    #  Make a volcano plot
    all_shrunken <- t_DGE_shrunken$thorough
    if(base::isTRUE(selection)) {
        selection_down_shrunken <- t_DGE_shrunken %>%
            dplyr::filter(log2FoldChange < 0) %>%
            dplyr::arrange(padj) %>%
            dplyr::slice(1:5)
        selection_up_shrunken <- t_DGE_shrunken %>%
            dplyr::filter(log2FoldChange > 0) %>%
            dplyr::arrange(padj) %>%
            dplyr::slice(1:5)
        selection_shrunken <- as.character(c(
            selection_down_shrunken[["thorough"]],
            selection_up_shrunken[["thorough"]]
        ))
    } else {
        selection_shrunken <- ""
    }
    
    sample_info <- colData(dds) %>%
        rownames() %>%
        sort() %>%
        stringr::str_split("_") %>%
        as.data.frame()
    name_exp <- sample_info[1, 1]
    name_ctrl <- sample_info[1, ncol(sample_info)]
    sample_info <- paste(
        sample_info[1, c(1, 4)],
        sample_info[3, 1],
        sample_info[2, 1]
    ) %>%
        paste(., collapse = " vs. ")
    model_info <- dds@design
    title <- paste0("volcano plot")
    subtitle <- paste(
        "points: S. cerevisiae features",
        "| size factors: K. lactis features",
        "\nsamples:", sample_info,
        "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
        "| apeglm",
        "\nleft: up in", name_ctrl,
        "| right: up in", name_exp
    )
    
    p_vol_shrunken <- plot_volcano(
        table = t_DGE_shrunken,
        label = all_shrunken,
        selection = selection_shrunken,
        label_size = 2.5,
        p_cutoff = as.numeric(p_cutoff),
        FC_cutoff = threshold_lfc,
        xlim = c(x_min, x_max),
        ylim = c(y_min, y_max),
        color = color,
        title = title,
        subtitle = subtitle
    )
    
    #  Make an MA plot
    title <- "MA plot"
    subtitle <- paste(
        "points: S. cerevisiae features",
        "| size factors: K. lactis features",
        "\nsamples:", sample_info,
        "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
        "| apeglm",
        "\nbottom: up in", name_ctrl,
        "| top: up in", name_exp
    )
    
    p_MA_shrunken <- ggplot(
        t_DGE_shrunken,
        aes(
            x = ifelse(is.infinite(log10(baseMean)), NA, log10(baseMean)),
            y = log2FoldChange,
            colour = as.factor(padj <= 0.005)  # padj is actually svalue
        )
    ) +
        geom_point(alpha = 0.25, size = 0.5) +
        ylim(c(x_min, x_max)) +
        xlab("log10(mean normalized counts)") +
        ylab("log2(fold change)") +
        scale_colour_discrete(name = "q ≤ 0.005") +
        ggrepel::geom_label_repel(
            data = t_DGE_shrunken[
                t_DGE_shrunken$thorough %in% selection_shrunken,
            ],
            aes(label = selection_shrunken),
            label.size = 0.25,
            color = "#000000",
            size = 2.5
        ) +
        ggtitle(title, subtitle) +
        theme_slick
    
    #  Tally number of features greater than LFC threshold and less than
    #+ svalue threshold
    n_feat_gt_lfc_lt_padj_shrunken <- table(
        t_DGE_shrunken$log2FoldChange > threshold_lfc &
        t_DGE_shrunken$padj < (threshold_p * 0.1)
    )
    
    
    #  LFC tests in which p are the max of upper, lower tests ("lessAbs") =====
    if(as.numeric(threshold_lfc) > 0) {
        #  Initialize a DESeq2 DataFrame object
        DGE_alt_unshrunken_DF <- DESeq2::results(
            dds,
            name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
            independentFiltering = independent_filtering,
            alpha = threshold_p,
            lfcThreshold = threshold_lfc,
            altHypothesis = "lessAbs",
            format = "DataFrame"
        )
        
        #  Initialize a GRanges object, which we can easily add to and convert to
        #+ other formats (such as a tibble)
        DGE_alt_unshrunken_GR <- DESeq2::results(
            dds,
            name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
            independentFiltering = independent_filtering,
            alpha = threshold_p,
            lfcThreshold = threshold_lfc,
            altHypothesis = "lessAbs",
            format = "GRanges"
        )
        DGE_alt_unshrunken_GR$features <- MatrixGenerics::rowRanges(dds)$features
        DGE_alt_unshrunken_GR$names <- MatrixGenerics::rowRanges(dds)$names
        DGE_alt_unshrunken_GR$thorough <- MatrixGenerics::rowRanges(dds)$thorough
        DGE_alt_unshrunken_GR$type <- MatrixGenerics::rowRanges(dds)$type
        DGE_alt_unshrunken_GR$genome <- MatrixGenerics::rowRanges(dds)$genome
        
        #  Coerce GRanges object to tibble
        t_DGE_alt_unshrunken <- DGE_alt_unshrunken_GR %>% dplyr::as_tibble()
        
        #  Make a volcano plot
        all_alt_unshrunken <- t_DGE_alt_unshrunken$thorough
        if(base::isTRUE(selection)) {
            selection_down_alt_unshrunken <- t_DGE_alt_unshrunken %>%
                dplyr::filter(log2FoldChange < 0) %>%
                dplyr::arrange(padj) %>%
                dplyr::slice(1:5)
            selection_up_alt_unshrunken <- t_DGE_alt_unshrunken %>%
                dplyr::filter(log2FoldChange > 0) %>%
                dplyr::arrange(padj) %>%
                dplyr::slice(1:5)
            selection_alt_unshrunken <- as.character(c(
                selection_down_alt_unshrunken[["thorough"]],
                selection_up_alt_unshrunken[["thorough"]]
            ))
        } else {
            selection_alt_unshrunken <- ""
        }
        
        sample_info <- colData(dds) %>%
            rownames() %>%
            sort() %>%
            stringr::str_split("_") %>%
            as.data.frame()
        name_exp <- sample_info[1, 1]
        name_ctrl <- sample_info[1, ncol(sample_info)]
        sample_info <- paste(sample_info[1, c(1, 4)], sample_info[2, 1]) %>%
            paste(., collapse = " vs. ")
        model_info <- dds@design
        title <- paste0("volcano plot")
        subtitle <- paste(
            "points: S. cerevisiae features",
            "| size factors: K. lactis features",
            "\nsamples:", sample_info,
            "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
            "\nleft: up in", name_ctrl,
            "| right: up in", name_exp
        )
        
        p_vol_alt_unshrunken <- plot_volcano(
            table = t_DGE_alt_unshrunken,
            label = all_alt_unshrunken,
            selection = selection_alt_unshrunken,
            label_size = 2.5,
            p_cutoff = 0.05,
            FC_cutoff = threshold_lfc,
            xlim = c(x_min, x_max),
            ylim = c(0, y_max),
            color = color,
            title = title,
            subtitle = subtitle
        )
        
        #  Make an MA plot
        title <- "MA plot"
        subtitle <- paste(
            "points: S. cerevisiae features",
            "| size factors: K. lactis features",
            "\nsamples:", sample_info,
            "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
            "\nbottom: up in", name_ctrl,
            "| top: up in", name_exp
        )
        
        p_MA_alt_unshrunken <- ggplot(
            t_DGE_alt_unshrunken,
            aes(
                x = ifelse(is.infinite(log10(baseMean)), NA, log10(baseMean)),
                y = log2FoldChange,
                colour = as.factor(padj <= 0.05)
            )
        ) +
            geom_point(alpha = 0.25, size = 0.5) +
            ylim(c(x_min, x_max)) +
            xlab("log10(mean normalized counts)") +
            ylab("log2(fold change)") +
            scale_colour_discrete(name = "q ≤ 0.05") +
            ggtitle(title, subtitle) +
            theme_slick +
            ggrepel::geom_label_repel(
                data = t_DGE_alt_unshrunken[
                    t_DGE_alt_unshrunken$thorough %in% selection_alt_unshrunken,
                ],
                aes(label = selection_alt_unshrunken),
                label.size = 0.25,
                color = "#000000",
                size = 2.5
            )
        
        #  Tally number of features greater than LFC threshold and less than
        #+ padj threshold
        n_feat_lt_lfc_lt_padj_alt_unshrunken <- table(
            t_DGE_alt_unshrunken$log2FoldChange < threshold_lfc &
            t_DGE_alt_unshrunken$padj < threshold_p
        )
    }

    #  Checks  #TB∆
    # p_vol_unshrunken
    # p_vol_shrunken
    # p_vol_alt_unshrunken
    # p_MA_unshrunken
    # p_MA_shrunken
    # p_MA_alt_unshrunken
    # n_feat_gt_lfc_lt_padj_unshrunken
    # n_feat_gt_lfc_lt_padj_shrunken
    # n_feat_lt_lfc_lt_padj_alt_unshrunken
    
    results_list <- list()
    results_list[["01_dds"]] <- dds
    
    results_list[["02_DGE_unshrunken_DF"]] <- DGE_unshrunken_DF
    results_list[["02_DGE_shrunken_DF"]] <- DGE_shrunken_DF
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["02_DGE_alt_unshrunken_DF"]] <- DGE_alt_unshrunken_DF
    }
    
    results_list[["03_DGE_unshrunken_GR"]] <- DGE_unshrunken_GR
    results_list[["03_DGE_shrunken_GR"]] <- DGE_shrunken_GR
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["03_DGE_alt_unshrunken_GR"]] <- DGE_alt_unshrunken_GR
    }
    
    results_list[["04_t_DGE_unshrunken"]] <- t_DGE_unshrunken
    results_list[["04_t_DGE_shrunken"]] <- t_DGE_shrunken
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["04_t_DGE_alt_unshrunken"]] <- t_DGE_alt_unshrunken
    }

    if(base::isTRUE(selection)) {
        results_list[["05_selection_down_unshrunken"]] <- selection_down_unshrunken
        results_list[["05_selection_down_shrunken"]] <- selection_down_shrunken
        if(as.numeric(threshold_lfc) > 0) {
            results_list[["05_selection_down_alt_unshrunken"]] <- selection_down_alt_unshrunken
        }
        
        results_list[["06_selection_up_unshrunken"]] <- selection_up_unshrunken
        results_list[["06_selection_up_shrunken"]] <- selection_up_shrunken
        if(as.numeric(threshold_lfc) > 0) {
            results_list[["06_selection_up_alt_unshrunken"]] <- selection_up_alt_unshrunken
        }
        
        results_list[["07_selection_unshrunken"]] <- selection_unshrunken
        results_list[["07_selection_shrunken"]] <- selection_shrunken
        if(as.numeric(threshold_lfc) > 0) {
            results_list[["07_selection_alt_unshrunken"]] <- selection_alt_unshrunken
        }
    }
    
    results_list[["08_p_vol_unshrunken"]] <- p_vol_unshrunken
    results_list[["08_p_vol_shrunken"]] <- p_vol_shrunken
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["08_p_vol_alt_unshrunken"]] <- p_vol_alt_unshrunken
    }
    
    results_list[["09_p_MA_unshrunken"]] <- p_MA_unshrunken
    results_list[["09_p_MA_shrunken"]] <- p_MA_shrunken
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["09_p_MA_alt_unshrunken"]] <- p_MA_alt_unshrunken
    }
    
    results_list[["10_n_feat_gt_lfc_lt_padj_unshrunken"]] <- n_feat_gt_lfc_lt_padj_unshrunken
    results_list[["10_n_feat_gt_lfc_lt_padj_shrunken"]] <- n_feat_gt_lfc_lt_padj_shrunken
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["10_n_feat_lt_lfc_lt_padj_alt_unshrunken"]] <- n_feat_lt_lfc_lt_padj_alt_unshrunken
    }
    
    return(results_list)
}


run_main <- function(
    t_sub,
    genotype_exp,
    genotype_ctrl,
    filtering = "min-10-cts-all-but-1-samps",
    x_min = -14,
    x_max = 14,
    y_min = 0,
    y_max = 310,
    color = "#113275"
) {
    #  Test  #HERE
    # t_sub <- `N-Q-nab3d_N-Q-parental` %>%
    #     dplyr::slice(1:(nrow(.) - 6)) %>%
    #     dplyr::filter(chr != "Mito")
    # genotype_exp <- "n3d"
    # genotype_ctrl <- "od"
    # filtering <- "min-10-cts-all-but-1-samps"
    # x_min <- -5
    # x_max <- 10
    # y_min <- 0
    # y_max <- 40
    # color <- "#113275"
    
    #  Check arguments --------------------------------------------------------
    if(!filtering %in% c(
        "none",
        "filterByExpr.default",
        "min-10-cts-3-samps",
        "min-10-cts-all-but-1-samps",
        "min-10-cts-all-samps"
    )) {
        stop(paste(
            "Argument for 'filtering' must be \"none\",",
            "\"filterByExpr.default\", \"min-10-cts-3-samps\",",
            "\"min-10-cts-all-but-1-samps\", or \"min-10-cts-all-samps\""
        ))
    }
    
    
    #  Make a metadata matrix for DESeq2, etc. --------------------------------
    t_meta <- colnames(t_sub)[12:ncol(t_sub)] %>%
        stringr::str_split("_") %>%
        as.data.frame() %>%
        t() %>%
        tibble::as_tibble(.name_repair = "unique") %>%
        dplyr::rename(
            genotype = ...1, state = ...2, transcription = ...3,
            replicate = ...4, technical = ...5
        ) %>%
        dplyr::mutate(rownames = colnames(t_sub)[12:ncol(t_sub)]) %>%
        tibble::column_to_rownames("rownames") %>%  # DESeq2 requires rownames
        dplyr::mutate(
            genotype = factor(genotype, level = c(genotype_ctrl, genotype_exp)),
            no_genotype = ifelse(genotype == genotype_ctrl, 0, 1) %>% as.factor(),
            state = factor(state, levels = c("G1", "Q")),
            no_state = sapply(
                as.character(state),
                switch,
                "G1" = 0,
                "Q" = 1,
                USE.NAMES = FALSE
            ) %>%
                as.factor(),
            transcription = factor(transcription, levels = c("SS", "N")),
            no_transcription = sapply(
                as.character(transcription),
                switch,
                "SS" = 0,
                "N" = 1,
                USE.NAMES = FALSE
            ) %>%
                as.factor(),
            replicate = factor(replicate, levels = c("rep1", "rep2")),
            no_replicate = sapply(
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                USE.NAMES = FALSE
            ) %>%
                as.factor(),
            technical = factor(technical, levels = c("tech1", "tech2")),
            no_technical = sapply(
                as.character(technical),
                switch,
                "tech1" = 0,
                "tech2" = 1,
                USE.NAMES = FALSE
            ) %>%
                as.factor()
        ) %>%
        droplevels()
    
    
    #  Filter t_sub to remove features with low counts across samples ---------
    t_sub.bak <- t_sub
    # t_sub <- t_sub.bak
    
    if(filtering == "none"){
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
    } else if(filtering == "min-10-cts-3-samps") {
        counts <- sapply(
            t_sub[t_sub$genome == "S_cerevisiae", 12:ncol(t_sub)], as.numeric
        )
        keep <- rowSums(counts >= 10) >= length(12:ncol(t_sub)) - 1
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
        t_tmp <- t_tmp[keep, ]
    } else if(filtering == "min-10-cts-all-but-1-samps") {
        counts <- sapply(
            t_sub[t_sub$genome == "S_cerevisiae", 12:ncol(t_sub)], as.numeric
        )
        keep <- rowSums(counts >= 10) >= length(12:ncol(t_sub)) - 1
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
        t_tmp <- t_tmp[keep, ]
    } else if(filtering == "min-10-cts-all-samps") {
        counts <- sapply(
            t_sub[t_sub$genome == "S_cerevisiae", 12:ncol(t_sub)], as.numeric
        )
        keep <- rowSums(counts >= 10) >= length(12:ncol(t_sub)) - 1
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
        t_tmp <- t_tmp[keep, ]
    } else if(filtering == "filterByExpr.default") {
        #TODO Hasn't been tested since updates, refactoring
        t_edge <- t_sub[t_sub$genome == "S_cerevisiae", 12:ncol(t_sub)] %>%
            as.data.frame()
        t_edge <- sapply(t_edge, as.numeric)
        rownames(t_edge) <- t_sub[
            t_sub$genome == "S_cerevisiae", 
        ]$features
        
        group <- t_meta$genotype
        eds <- edgeR::DGEList(
            t_edge,
            group = group,
            genes = t_sub[t_sub$genome == "S_cerevisiae", 1:12]
        )
    
        design <- model.matrix(~ 0 + group)
        colnames(design) <- levels(group)
        
        keep <- edgeR::filterByExpr.default(eds, design)
        table(keep)
        
        dispose <- dplyr::bind_cols(eds[!keep, ]$genes, eds[!keep, ]$counts)
        
        #  Remove low-counts features from t_sub
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
        t_tmp <- t_tmp[keep, ]
        
        #  Clean up variables
        rm(t_edge, group, eds, design, t_tmp)
        
        # dispose[dispose$genome == "S_cerevisiae", ] %>% nrow()
        # dispose[dispose$genome == "K_lactis", ] %>% nrow()
    
    }
    
    t_sub <- dplyr::bind_rows(t_tmp, t_sub[t_sub$genome != "S_cerevisiae", ])
    rm(keep, t_tmp)
    
    
    #  Make a GRanges object for positional information for DESeq2, etc. ------
    g_pos <- GenomicRanges::GRanges(
        seqnames = t_sub$chr,
        ranges = IRanges::IRanges(t_sub$start, t_sub$end),
        strand = t_sub$strand,
        length = t_sub$width,
        type = t_sub$type,
        features = t_sub$features,
        biotype = t_sub$biotype,
        names = t_sub$names,
        thorough = t_sub$thorough,
        genome = t_sub$genome
    )
    # g_pos
    
    #  Make a counts matrix for DESeq2, etc.
    t_counts <- t_sub[, 12:ncol(t_sub)] %>%
        sapply(., as.integer) %>%
        as.data.frame()
    
    #  Make the dds object
    if(length(unique(t_meta$technical)) > 1) {
        dds <- DESeq2::DESeqDataSetFromMatrix(
            countData = t_counts,
            colData = t_meta,
            design = ~ technical + genotype,
            rowRanges = g_pos
        )
    } else {
        dds <- DESeq2::DESeqDataSetFromMatrix(
            countData = t_counts,
            colData = t_meta,
            design = ~ genotype,
            rowRanges = g_pos
        )
    }

    #  Do size-factor estimation using K. lactis control genes
    dds <- BiocGenerics::estimateSizeFactors(
        dds,
        controlGenes = (dds@rowRanges$genome == "K_lactis")
    )

    #  Call DESeq2 using default parameters
    dds <- DESeq2::DESeq(dds[dds@rowRanges$genome != "K_lactis", ])
    
    #  Record model information, etc.
    size_factors <- dds$sizeFactor %>% as.data.frame()
    size_factors_recip <- (1 / dds$sizeFactor) %>% as.data.frame()
    design <- dds@design
    col_data <- dds@colData
    model_info <- DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))]
    
    #  Checks
    # size_factors
    # size_factors_recip
    # design
    # col_data
    # model_info
    

    #  Call DESeq2 results() and generate volcano and MA plots ----------------
    lfc_0 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 0,  # i.e., 2^0 = 1
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.32 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 0.32,  # i.e., 2^0.32 ≈ 1.25
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.58 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 0.58,  # i.e., 2^0.58 ≈ 1.5
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_1 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 1,  # i.e., 2^1 = 2
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_1.32 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 1.32,  # i.e., 2^1.32 ≈ 2.5
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_1.58 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 1.58,  # i.e., 2^1.58 ≈ 3
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_2 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 2,  # i.e., 2^2 = 4
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_2.32 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 2.32,  # i.e., 2^2.32 ≈ 5
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_2.58 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 2.58,  # i.e., 2^2.58 ≈ 6
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_3 <- call_DESeq2_results_gt_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = 0.05,
        threshold_lfc = 3,  # i.e., 2^3 ≈ 8
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )

    
    #  Return results ---------------------------------------------------------
    results_list <- list()
    results_list[["01_t_init"]] <- t_sub.bak
    results_list[["02_t_meta"]] <- t_meta
    results_list[["03_filtering"]] <- filtering
    if(filtering != "filterByExpr.default") {
        results_list[["04_counts"]] <- counts
        results_list[["04_keep"]] <- keep
    }
    if(filtering == "filterByExpr.default") {
        results_list[["04_t_edge"]] <- t_edge
        results_list[["04_group"]] <- group
        results_list[["04_eds"]] <- eds
        results_list[["04_design"]] <- design
        results_list[["04_keep"]] <- keep
        results_list[["04_dispose"]] <- dispose
    }
    results_list[["05_t_sub"]] <- t_sub
    results_list[["06_g_pos"]] <- g_pos
    results_list[["07_t_counts"]] <- t_counts
    results_list[["08_dds"]] <- dds
    results_list[["08_size_factors"]] <- size_factors
    results_list[["08_size_factors_recip"]] <- size_factors_recip
    results_list[["08_design"]] <- design
    results_list[["08_col_data"]] <- col_data
    results_list[["08_model_info"]] <- model_info
    results_list[["09_lfc_0"]] <- lfc_0
    results_list[["09_lfc_0.32"]] <- lfc_0.32
    results_list[["09_lfc_0.58"]] <- lfc_0.58
    results_list[["09_lfc_1"]] <- lfc_1
    results_list[["09_lfc_1.32"]] <- lfc_1.32
    results_list[["09_lfc_1.58"]] <- lfc_1.58
    results_list[["09_lfc_2"]] <- lfc_2
    results_list[["09_lfc_2.32"]] <- lfc_2.32
    results_list[["09_lfc_2.58"]] <- lfc_2.58
    results_list[["09_lfc_3"]] <- lfc_3
    
    return(results_list)
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
theme_slick_no_legend <- theme_slick + theme(legend.position = "none")


#  Get situated, load counts matrix ===========================================
p_base <- "/Users/kalavatt/projects-etc"
p_exp <- "2022_transcriptome-construction/results/2023-0215"
p_tsv <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
f_tsv <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
# paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
#     file.exists()  # [1] TRUE

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

#  Read in htseq-count counts matrix derived from combined_SC_KL_20S.gff3
t_tsv <- paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
    readr::read_tsv(show_col_types = FALSE) %>%
    dplyr::slice(-1)  # Slice out the first row, which contains file info

#  "Clean up" counts matrix column names and "features" elements
colnames(t_tsv) <- colnames(t_tsv) %>%
    gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .)

t_tsv <- t_tsv %>%
    dplyr::mutate(
        features = features %>%
            gsub("^transcript\\:", "", .) %>%
            gsub("_mRNA", "", .)
    )


#  Load Excel spreadsheet of samples names and variables ----------------------
p_xlsx <- "notebook"
f_xlsx <- "variables.xlsx"
# paste(p_base, p_exp, p_xlsx, f_xlsx, sep = "/") %>%
#     file.exists()  # [1] TRUE

t_xslx <- paste(p_base, p_exp, p_xlsx, f_xlsx, sep = "/") %>%
    readxl::read_xlsx()  
#FIXME #LATER In this file, replicate information for 5781, 5782, 7079, 7078,
#             6125, 6126, 7718, and 7716 is incorrect


#  To associate features (mRNA) with metadata, load combined_SC_KL_20S.gff3 ---
p_gff3 <- "infiles_gtf-gff3/already"
f_gff3 <- "combined_SC_KL_20S.gff3"
# paste(p_base, p_exp, p_gff3, f_gff3, sep = "/") %>%
#     file.exists()  # [1] TRUE

#  Load in, subset, and "clean up" gff3
t_gff3 <- paste(p_gff3, f_gff3, sep = "/") %>%
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

#  Subset gff3 tibble to keep only relevant columns
keep <- c(
    "chr", "start", "end",
    "width", "strand", "type",
    "features", "biotype", "names"
)
t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
rm(keep)

#  Convert column "names" from a list (data structure) to a character vector,
#+ and replace empty fields with NA character values
t_gff3$names <- ifelse(
    as.character(t_gff3$names) == "character(0)",
    NA_character_,
    as.character(t_gff3$names)
)


#  Combine "counts matrix tibble" and "gff3 tibble" ---------------------------
t_mat <- dplyr::full_join(t_gff3, t_tsv, by = "features")

#  Remove unneeded variables
rm(f_gff3, f_tsv, f_xlsx, p_base, p_exp, p_gff3, p_tsv, p_xlsx, t_gff3, t_tsv)


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
            t_mat$chr %in% chr_20S,
            "20S",
            NA
        )
    )
) %>%
    as.factor()
t_mat <- t_mat %>% dplyr::relocate("genome", .before = "chr")

#  Create a column of "thorough" names: use the Y* name if there is no
#+ "common"/"normal" name; otherwise, use the "common"/"normal" name
t_mat$thorough <- ifelse(is.na(t_mat$names), t_mat$features, t_mat$names)
t_mat <- t_mat %>% dplyr::relocate(thorough, .after = names)

#  Create a backup of t_mat
t_mat.bak <- t_mat
# t_mat <- t_mat.bak

#  Remove unneeded variables
rm(chr_20S, chr_KL, chr_SC, chr_order)


#  Filter counts matrix for samples of interest ===============================
`N-Q-nab3d_N-Q-parental` <- setNames(
    c(
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1"
    ),
    c(
        "n3d_Q_N_rep1_tech1",
        "n3d_Q_N_rep2_tech1",
        "od_Q_N_rep1_tech1",
        "od_Q_N_rep2_tech1"
    )
)
`N-Q-nab3d_N-Q-parental` <- filter_process_counts_matrix(
    `N-Q-nab3d_N-Q-parental`
)

`N-SS-nab3d_N-SS-parental` <- setNames(
    c(
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1"
    ),
    c(
        "n3d_Q_SS_rep1_tech1",
        "n3d_Q_SS_rep2_tech1",
        "od_Q_SS_rep1_tech1",
        "od_Q_SS_rep2_tech1"
    )
)
`N-SS-nab3d_N-SS-parental` <- filter_process_counts_matrix(
    `N-SS-nab3d_N-SS-parental`
)

`SS-Q-rrp6∆_SS-Q-WT` <- setNames(
    c(
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"
    ),
    c(
        "r6n_Q_SS_rep1_tech1",
        "r6n_Q_SS_rep1_tech2",
        "r6n_Q_SS_rep2_tech1",
        "WT_Q_SS_rep1_tech1",
        "WT_Q_SS_rep2_tech1"
    )
)
`SS-Q-rrp6∆_SS-Q-WT` <- filter_process_counts_matrix(
    `SS-Q-rrp6∆_SS-Q-WT`
)

`SS-G1-rrp6∆_SS-G1-WT` <- setNames(
    c(
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1"
    ),
    c(
        "r6n_G1_SS_rep1_tech2",
        "r6n_G1_SS_rep2_tech2",
        "WT_G1_SS_rep1_tech2",
        "WT_G1_SS_rep2_tech2"
    )
)
`SS-G1-rrp6∆_SS-G1-WT` <- filter_process_counts_matrix(
    `SS-G1-rrp6∆_SS-G1-WT`
)

`N-Q-rrp6∆_N-Q-WT` <- setNames(
    c(
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"
    ),
    c(
        "r6n_Q_N_rep1_tech1",
        "r6n_Q_N_rep2_tech1",
        "WT_Q_N_rep1_tech1",
        "WT_Q_N_rep2_tech1"
    )
)
`N-Q-rrp6∆_N-Q-WT` <- filter_process_counts_matrix(
    `N-Q-rrp6∆_N-Q-WT`
)

`SS-DSm2-rrp6∆_SS-DSm2-WT` <- setNames(
    c(
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"
    ),
    c(
        "r6n_DSm2_SS_rep1_tech1",
        "r6n_DSm2_SS_rep2_tech1",
        "WT_DSm2_SS_rep1_tech1",
        "WT_DSm2_SS_rep2_tech1"
    )
)
`SS-DSm2-rrp6∆_SS-DSm2-WT` <- filter_process_counts_matrix(
    `SS-DSm2-rrp6∆_SS-DSm2-WT`
)

`SS-DSp2-rrp6∆_SS-DSp2-WT` <- setNames(
    c(
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"
    ),
    c(
        "r6n_DSp2_SS_rep1_tech1",
        "r6n_DSp2_SS_rep2_tech1",
        "WT_DSp2_SS_rep1_tech1",
        "WT_DSp2_SS_rep2_tech1"
    )
)
`SS-DSp2-rrp6∆_SS-DSp2-WT` <- filter_process_counts_matrix(
    `SS-DSp2-rrp6∆_SS-DSp2-WT`
)

`SS-DSp24-rrp6∆_SS-DSp24-WT` <- setNames(
    c(
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"
    ),
    c(
        "r6n_DSp24_SS_rep1_tech1",
        "r6n_DSp24_SS_rep2_tech1",
        "WT_DSp24_SS_rep1_tech1",
        "WT_DSp24_SS_rep2_tech1"
    )
)
`SS-DSp24-rrp6∆_SS-DSp24-WT` <- filter_process_counts_matrix(
    `SS-DSp24-rrp6∆_SS-DSp24-WT`
)

`SS-DSp48-rrp6∆_SS-DSp48-WT` <- setNames(
    c(
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"
    ),
    c(
        "r6n_DSp48_SS_rep1_tech1",
        "r6n_DSp48_SS_rep2_tech2",
        "WT_DSp48_SS_rep1_tech1",
        "WT_DSp48_SS_rep1_tech2",
        "WT_DSp48_SS_rep2_tech1"
    )
)
`SS-DSp48-rrp6∆_SS-DSp48-WT` <- filter_process_counts_matrix(
    `SS-DSp48-rrp6∆_SS-DSp48-WT`
)


#  Analyze, graph datasets of interest ========================================
# t_sub,
# genotype_exp,
# genotype_ctrl,
# filtering = "min-10-cts-all-but-1-samps",
# x_min = -14,
# x_max = 14,
# y_min = 0,
# y_max = 310,
# color = "#113275"

#NOTE Need to exclude 20S, "summary values", and Mito from tibble
`DGE-analysis_N-Q-nab3d_N-Q-parental` <- run_main(
    t_sub = `N-Q-nab3d_N-Q-parental` %>%
        dplyr::slice(1:(nrow(.) - 6)) %>%
        dplyr::filter(chr != "Mito"),
    genotype_exp = "n3d",
    genotype_ctrl = "od",
    filtering = "min-10-cts-all-but-1-samps",
    x_min = -5,
    x_max = 10,
    y_min = 0,
    y_max = 40,
    color = "#113275"
)    
test <- `DGE-analysis_N-Q-nab3d_N-Q-parental`
test$`09_lfc_0.32`$`09_p_MA_alt_unshrunken`
test$`09_lfc_0.58`$`09_p_MA_alt_unshrunken`
test$`09_lfc_1`$`09_p_MA_alt_unshrunken`
test$`09_lfc_1.32`$`09_p_MA_alt_unshrunken`
test$`09_lfc_1.58`$`09_p_MA_alt_unshrunken`
test$`09_lfc_2`$`09_p_MA_alt_unshrunken`
test$`09_lfc_2.32`$`09_p_MA_alt_unshrunken`
test$`09_lfc_2.58`$`09_p_MA_alt_unshrunken`
test$`09_lfc_3`$`09_p_MA_alt_unshrunken`

test$`09_lfc_1.58`$`10_n_feat_lt_lfc_lt_padj_alt_unshrunken`

#TODO #PICKUPHERE 
# `DGE_analysis_N-SS_nab3d-parental` <- process_data_perform_DGE_analyses(
#     t_sub = `N-SS-nab3d_N-SS-parental` %>% dplyr::slice(1:(n() - 6)),
#     genotype_exp = "n3d",
#     genotype_ctrl = "od"
# )
# `DGE_analysis_N-SS_nab3d-parental`
# 
# 
# `DGE_analysis_SS-G1-rrp6∆_SS-G1-WT` <- process_data_perform_DGE_analyses(
#     t_sub = `SS-G1-rrp6∆_SS-G1-WT` %>% dplyr::slice(1:(n() - 6)),
#     genotype_exp = "r6n",
#     genotype_ctrl = "WT"
# )
# `DGE_analysis_SS-G1-rrp6∆_SS-G1-WT`


#  Notes ======================================================================
#  Volcano plots in paper so far (2023-0519) ----------------------------------
#+     Figure 2
#+         - 2a: SS G1 rrp6∆ vs SS G1 WT: pa-ncRNA
#+         - 2a: SS G1 rrp6∆ vs SS G1 WT: mRNA
#+         - 2b: SS Q rrp6∆ vs SS Q WT: pa-ncRNA
#+         - 2b: SS Q rrp6∆ vs SS Q WT: mRNA
#+         - 2c: N Q rrp6∆ vs N Q WT: pa-ncRNA
#+         - 2c: N Q rrp6∆ vs N Q WT: mRNA
#+ 
#+     Figure 3
#+         - 3a: N Q nab3-d vs N Q parental: pa-ncRNA
#+         - 3a: N Q nab3-d vs N Q parental: mRNA
#+         - 3a: SS Q nab3-d vs SS Q parental: pa-ncRNA
#+         - 3a: SS Q nab3-d vs SS Q parental: mRNA


#  Breakdown of columns to subset in the counts matrix ------------------------
#  N Q nab3-d vs N Q parental: mRNA
# "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1"  #OK
# "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1"  #OK
# "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1"  #OK  #EXCLUDE from analyses
# "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1"  #OK
# "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1"  #OK

#  SS Q nab3-d vs SS Q parental: mRNA
# "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1"  #OK
# "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1"  #OK
# "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1"  #OK  #EXCLUDE from analyses
# "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1"  #OK
# "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1"  #OK

#  SS Q rrp6∆ vs SS Q WT: mRNA
# "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1"  #OK
# "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2"  #OK
# "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"  #OK
# "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1"  #OK
# "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"  #OK

#  SS G1 rrp6∆ vs SS G1 WT: mRNA
# "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1"  #FIXME Column name needs to be changed from "tech1" to "tech2" (matrix was made before I made corrections to variables.xlsx)
# "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1"  #FIXME Column name needs to be changed from "tech1" to "tech2" (matrix was made before I made corrections to variables.xlsx)
# "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1"  #FIXME Column name needs to be changed from "tech1" to "tech2" (matrix was made before I made corrections to variables.xlsx)
# "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1"  #FIXME Column name needs to be changed from "tech1" to "tech2" (matrix was made before I made corrections to variables.xlsx)

#  N Q rrp6∆ vs N Q WT: mRNA
# "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1"  #OK
# "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"  #OK
# "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1"  #OK
# "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"  #OK

#  SS DSm2 rrp6∆ vs SS DSm2 WT: mRNA
# "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK
# "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK

#  SS DSp2 rrp6∆ vs SS DSp2 WT: mRNA
# "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK
# "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK

#  SS DSp24 rrp6∆ vs SS DSp24 WT: mRNA
# "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK
# "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK

#  SS DSp48 rrp6∆ vs SS DSp48 WT: mRNA
# "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"  #FIXME #IMPORTANT Column name needs to be changed from "tech1" to "tech2" (matrix was made before I made corrections to variables.xlsx)
# "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1"  #OK
# "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2"  #OK
# "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"  #OK


#  Corrected/simplified names of above columns --------------------------------
#  N Q nab3-d vs N Q parental: mRNA
# "n3d_Q_N_rep1_tech1"
# "n3d_Q_N_rep2_tech1"
# "n3d_Q_N_rep3_tech1"  #EXCLUDE from analyses, I think?
# "od_Q_N_rep1_tech1"
# "od_Q_N_rep2_tech1"

#  SS Q nab3-d vs SS Q parental: mRNA
# "n3d_Q_SS_rep1_tech1"
# "n3d_Q_SS_rep2_tech1"
# "n3d_Q_SS_rep3_tech1"  #EXCLUDE from analyses, I think?
# "od_Q_SS_rep1_tech1"
# "od_Q_SS_rep2_tech1"

#  SS Q rrp6∆ vs SS Q WT: mRNA
# "r6n_Q_SS_rep1_tech1"
# "r6n_Q_SS_rep1_tech2"
# "r6n_Q_SS_rep2_tech1"
# "WT_Q_SS_rep1_tech1"
# "WT_Q_SS_rep2_tech1"

#  SS G1 rrp6∆ vs SS G1 WT: mRNA
# "r6n_G1_SS_rep1_tech2"  #FIXED
# "r6n_G1_SS_rep2_tech2"  #FIXED
# "WT_G1_SS_rep1_tech2"  #FIXED
# "WT_G1_SS_rep2_tech2"  #FIXED

#  N Q rrp6∆ vs N Q WT: mRNA
# "r6n_Q_N_rep1_tech1"
# "r6n_Q_N_rep2_tech1"
# "WT_Q_N_rep1_tech1"
# "WT_Q_N_rep2_tech1"

#  SS DSm2 rrp6∆ vs SS DSm2 WT: mRNA
# "r6n_DSm2_SS_rep1_tech1"
# "r6n_DSm2_SS_rep2_tech1"
# "WT_DSm2_SS_rep1_tech1"
# "WT_DSm2_SS_rep2_tech1"

#  SS DSp2 rrp6∆ vs SS DSp2 WT: mRNA
# "r6n_DSp2_SS_rep1_tech1"
# "r6n_DSp2_SS_rep2_tech1"
# "WT_DSp2_SS_rep1_tech1"
# "WT_DSp2_SS_rep2_tech1"

#  SS DSp24 rrp6∆ vs SS DSp24 WT: mRNA
# "r6n_DSp24_SS_rep1_tech1"
# "r6n_DSp24_SS_rep2_tech1"
# "WT_DSp24_SS_rep1_tech1"
# "WT_DSp24_SS_rep2_tech1"

#  SS DSp48 rrp6∆ vs SS DSp48 WT: mRNA
# "r6n_DSp48_SS_rep1_tech1"
# "r6n_DSp48_SS_rep2_tech2"  #FIXED
# "WT_DSp48_SS_rep1_tech1"
# "WT_DSp48_SS_rep1_tech2"
# "WT_DSp48_SS_rep2_tech1"
