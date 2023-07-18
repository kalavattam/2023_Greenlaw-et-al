#!/usr/bin/env Rscript

#  rough-draft_new-approach-to-analyses.R
#  KA


#  Initialize arguments =======================================================
type <- "mRNA"  #ARGUMENT
# type <- "mRNA-AS"  #ARGUMENT
# type <- "coding-non-pa-ncRNA"  #ARGUMENT
# type <- "ncRNA-collapsed"  #ARGUMENT
# type <- "ncRNA-non-collapsed"  #ARGUMENT


#  Load libraries, set options ================================================
suppressMessages(library(apeglm))
suppressMessages(library(DESeq2))
# suppressMessages(library(edgeR))
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and themes ============================================
`%notin%` <- base::Negate(`%in%`)


write_plot_info <- function(
    dds_colData, dds_design, title, is_apeglm = FALSE, n_DE_up, n_DE_down
) {
    # ...
    #
    # :param dds_colData: ...
    # :param dds_design: ...
    # :param title: ...
    # :param is_apeglm: ...
    # :param n_DE_up: ...
    # :param n_DE_down: ...
    # :return title_list: ...
    if(base::isFALSE(title %in% c("volcano plot", "MA plot"))) {
        stop(
            "Argument \"title\" must be \"volcano plot\" or \"MA plot\" <chr>"
        )
    }
    if(base::isFALSE(is.logical(is_apeglm))) {
        stop("Argument \"is_apeglm\" must be TRUE or FALSE <lgl>")
    }
    
    sample_info <- dds_colData %>%
        rownames() %>%
        sort() %>%
        stringr::str_split("_") %>%
        as.data.frame()
    name_exp <- ifelse(
        title == "volcano plot",
        sample_info[1, 1],
        sample_info[1, ncol(sample_info)]
    )
    name_ctrl <- ifelse(
        title == "volcano plot",
        sample_info[1, ncol(sample_info)],
        sample_info[1, 1]
    )
    sample_info <- paste(
        sample_info[1, c(1, 4)],
        sample_info[3, 1],
        sample_info[2, 1]
    ) %>%
        paste(., collapse = " vs. ")
    model_info <- dds_design
    title <- title
    orient_ctrl <- ifelse(title == "volcano plot", "right", "top")
    orient_exp <- ifelse(title == "volcano plot", "left", "bottom")
    
    if(base::isFALSE(is_apeglm)) {
        subtitle <- paste0(
            "points: S. cerevisiae features ",
            "| size factors: K. lactis features ",
            "\nsamples: ", sample_info,
            " | model: ~ ", paste(
                as.character(model_info)[-1], collapse = " + "
            ),
            "\n", orient_ctrl, ": up in ", name_ctrl, " (", n_DE_down, ") ",
            "| ", orient_exp, ": up in ", name_exp, " (", n_DE_up, ")"
        )
    } else {
        subtitle <- paste0(
            "points: S. cerevisiae features ",
            "| size factors: K. lactis features ",
            "\nsamples: ", sample_info,
            " | model: ~ ", paste(
                as.character(model_info)[-1], collapse = " + "
            ),
            "| apeglm",
            "\n", orient_ctrl, ": up in ", name_ctrl, " (", n_DE_down, ") ",
            "| ", orient_exp, ": up in ", name_exp, " (", n_DE_up, ")"
        )
    }
    
    title_list <- list()
    title_list[["title"]] <- title
    title_list[["subtitle"]] <- subtitle
    
    return(title_list)
}


plot_volcano <- function(
    table,
    label,
    selection,
    label_size,
    p_cutoff,
    FC_cutoff,
    point_size = 1,
    cutoff_line_width = 0.2,
    xlim,
    ylim,
    color = c("#D3D3D3", "#D3D3D3", "#D3D3D3", "#A020F0"),
    title,
    subtitle,
    ...
) {
    # ...
    #
    # :param table: dataframe of test statistics <df>
    # :param label: character vector of all variable names in param table <vec>
    # :param selection: character vector of selected variable names in param
    #                   table <vec>
    # :param label_size: size of label font <float>
    # :param p_cutoff: cut-off for statistical significance; a horizontal line
    #                  will be drawn at -log10(pCutoff); p is actually padj
    #                  <float>
    # :param FC_cutoff: cut-off for absolute log2 fold-change; vertical lines
    #                   will be drawn at the negative and positive values of
    #                   log2FCcutoff
    #                   <float>
    # :param xlim: limits of the x-axis <float>
    # :param ylim: limits of the y-axis <float>
    # :param color: character vector of four hexcode colors <chr>
    # :param title: plot title <chr>
    # :param subtitle: plot subtitle <chr>
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
        cutoffLineWidth = cutoff_line_width,
        pointSize = point_size,
        shape = 16,
        colAlpha = 0.25,
        col = color,
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


plot_MA <- function(
    table,
    alpha = 0.05,
    selection,
    label_size = 0.25,
    x_min,
    x_max,
    legend_header = "q ≤ 0.05",
    title = "MA plot",
    subtitle,
    ...
) {
    MA <- ggplot(
        table,
        aes(
            x = ifelse(is.infinite(log10(baseMean)), NA, log10(baseMean)),
            y = log2FoldChange,
            colour = as.factor(padj <= alpha)
        )
    ) +
        geom_point(alpha = 0.25, size = 0.5) +
        ylim(c(x_min, x_max)) +
        xlab("log10(mean normalized counts)") +
        ylab("log2(FC)") +
        scale_colour_discrete(name = legend_header) +
        ggtitle(title, subtitle) +
        theme_slick +
        ggrepel::geom_label_repel(
            data = table[table$thorough %in% selection, ],
            aes(label = selection),
            label.size = label_size,
            color = "#000000",
            size = 2.5
        )
    
    return(MA)
}


call_DESeq2_results_run_analyses <- function(
    dds,
    independent_filtering = TRUE,
    threshold_p = 0.05,
    threshold_p_lessAbs = 0.99,
    threshold_lfc = 0.58,
    x_min = -14,
    x_max = 14,
    y_min = 0,
    y_max = 310,
    color = "#A020F0",
    selection = TRUE
) {
    # ...
    #
    # :param dds: ...
    # :param independent_filtering: ...
    # :param threshold_p: ...
    # :param threshold_lfc: ...
    # :param x_min: ...
    # :param x_max: ...
    # :param y_min: ...
    # :param y_max: ...
    # :param color: ...
    # :param selection: ...
    # :return results_list: ...
    
    #  Test  #HERE
    # dds <- dds
    # independent_filtering <- TRUE
    # threshold_p <- 0.05
    # threshold_p_lessAbs <- 0.99
    # threshold_lfc <- 0.58
    # x_min <- -5
    # x_max <- 10
    # y_min <- 0
    # y_max <- 100
    # color <- "#481A6C"
    # selection <- FALSE
    
    if(base::isFALSE(is.logical(selection))) {
        stop("Argument \"selection\" must be TRUE or FALSE <lgl>")
    }
    
    #  Perform standard tests of LFC difference (default "greaterAbs") ========
    #  Initialize a DESeq2 DataFrame object, which is necessary for some down-
    #+ stream functions
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
    #+ other formats
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
    
    
    #  Making plots *without* LFC shrinkage values ----------------------------
    #  Coerce GRanges object to tibble
    t_DGE_unshrunken <- DGE_unshrunken_GR %>% dplyr::as_tibble()
    
    #  Identify top 5 up- and downregulated significant features
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
    
    #  Tally number of features greater than LFC threshold and less than
    #+ padj threshold
    `n_feat_gte_abs-lfc_lt_padj_unshrunken` <- table(
        abs(t_DGE_unshrunken$log2FoldChange) >= threshold_lfc &
        t_DGE_unshrunken$padj < threshold_p
    )
    
    n_feat_gt_lfc_lt_padj_unshrunken <- table(
        t_DGE_unshrunken$log2FoldChange > threshold_lfc &
        t_DGE_unshrunken$padj < threshold_p
    )
    
    n_feat_lt_lfc_lt_padj_unshrunken <- table(
        t_DGE_unshrunken$log2FoldChange < threshold_lfc &
        t_DGE_unshrunken$padj < threshold_p
    )
    
    #  Make volcano plots
    info_volcano <- write_plot_info(
        dds_colData = colData(dds),
        dds_design = dds@design,
        title = "volcano plot",
        is_apeglm = FALSE,
        n_DE_up = as.character(n_feat_gt_lfc_lt_padj_unshrunken[2]),
        n_DE_down = as.character(n_feat_lt_lfc_lt_padj_unshrunken[2])
    )
    
    p_vol_unshrunken_KA <- plot_volcano(
        table = t_DGE_unshrunken,
        label = all_unshrunken,
        selection = selection_unshrunken,
        label_size = 2.5,
        p_cutoff = as.numeric(threshold_p),
        FC_cutoff = threshold_lfc,
        xlim = c(x_min, x_max),
        ylim = c(y_min, y_max),
        color = c("#D3D3D3", "#D3D3D3", "#D3D3D3", color),  #TODO More control
        title = info_volcano[1],
        subtitle = info_volcano[2]
    ) + 
        ylab("-log10(q)")
    
    p_vol_unshrunken_AG <- plot_volcano(
        table = t_DGE_unshrunken,
        label = all_unshrunken,
        selection = selection_unshrunken,
        label_size = 2.5,
        p_cutoff = as.numeric(threshold_p),
        FC_cutoff = threshold_lfc,
        xlim = c(x_min, x_max),
        ylim = c(y_min, y_max),
        color = c("#D3D3D3", "#D3D3D3", "#D3D3D3", color),  #TODO More control
        cutoff_line_width = 3,
        point_size = 2.5,
        title = "",
        subtitle = ""
    ) + 
        ylab("-log10(q)") +
        theme_AG_no_legend
    
    #  Make an MA plot
    info_MA <- write_plot_info(
        colData(dds),
        dds@design,
        "MA plot",
        FALSE,
        n_DE_up = as.character(n_feat_lt_lfc_lt_padj_unshrunken[2]),
        n_DE_down = as.character(n_feat_gt_lfc_lt_padj_unshrunken[2])
    )
    
    p_MA_unshrunken <- plot_MA(
        table = t_DGE_unshrunken,
        alpha =  threshold_p,
        selection = selection_unshrunken,
        x_min = x_min,
        x_max = x_max,
        legend_header = paste("q ≤", threshold_p),
        title = info_MA[1],
        subtitle = info_MA[2]
    )
    
    #  Plot p- and q-value distributions
    hist_unshrunken_p <- t_DGE_unshrunken %>%
    # hist_unshrunken_p <- t_DGE_unshrunken[
    #     t_DGE_unshrunken$pvalue != 1,
    # ] %>%
        ggplot(aes(x = pvalue)) +
        geom_histogram(
            binwidth = 0.025,  #TODO More control
            fill = "steelblue",
            color = "white"
        ) +
        labs(
            x = "p-value",
            y = "frequency",
            title = "p-value distribution"
        ) +
        theme_slick
    
    hist_unshrunken_q <- t_DGE_unshrunken[
        !is.na(t_DGE_unshrunken$padj), 
    ] %>%
    # hist_unshrunken_q <- t_DGE_unshrunken[
    #     t_DGE_unshrunken$pvalue != 1 &
    #     !is.na(t_DGE_unshrunken$padj), 
    # ] %>%
        ggplot(aes(x = padj)) +
        geom_histogram(
            binwidth = 0.025,  #TODO More control
            fill = "steelblue",
            color = "white"
        ) +
        labs(
            x = "q-value",
            y = "frequency",
            title = "q-value distribution"
        ) +
        theme_slick
    

    #  Making plots *with* LFC shrinkage values (apeglm) ----------------------
    #  Coerce GRanges object to tibble
    t_DGE_shrunken <- DGE_shrunken_GR %>% dplyr::as_tibble()
    if("svalue" %in% names(t_DGE_shrunken)) {
        names(t_DGE_shrunken)[9] <- "padj"  #HACK
        p_cutoff <- as.double(threshold_p) * 0.1
    } else {
        p_cutoff <- threshold_p
    }
    
    #  Identify top 5 up- and downregulated significant features
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
    
    #  Tally number of features greater than LFC threshold and less than
    #+ svalue threshold
    `n_feat_gte_abs-lfc_lt_s_shrunken` <- table(
        abs(t_DGE_shrunken$log2FoldChange) >= threshold_lfc &
        t_DGE_shrunken$padj < p_cutoff
    )
    
    n_feat_gt_lfc_lt_s_shrunken <- table(
        t_DGE_shrunken$log2FoldChange > threshold_lfc &
        t_DGE_shrunken$padj < p_cutoff
    )
    
    n_feat_lt_lfc_lt_s_shrunken <- table(
        t_DGE_shrunken$log2FoldChange < threshold_lfc &
        t_DGE_shrunken$padj < p_cutoff
    )
    
    #  Make volcano plots
    info_volcano <- write_plot_info(
        dds_colData = colData(dds),
        dds_design = dds@design,
        title = "volcano plot",
        is_apeglm = FALSE,
        n_DE_up = as.character(n_feat_gt_lfc_lt_s_shrunken[2]),
        n_DE_down = as.character(n_feat_lt_lfc_lt_s_shrunken[2])
    )
    
    p_vol_shrunken_KA <- plot_volcano(
        table = t_DGE_shrunken,
        label = all_shrunken,
        selection = selection_shrunken,
        label_size = 2.5,
        p_cutoff = as.numeric(p_cutoff),
        FC_cutoff = threshold_lfc,
        xlim = c(x_min, x_max),
        ylim = c(y_min, y_max),
        color = c("#D3D3D3", "#D3D3D3", "#D3D3D3", color),  #TODO More control
        title = info_volcano[1],
        subtitle = info_volcano[2]
    ) + 
        ylab("-log10(s)")
    
    p_vol_shrunken_AG <- plot_volcano(
        table = t_DGE_shrunken,
        label = all_shrunken,
        selection = selection_shrunken,
        label_size = 2.5,
        p_cutoff = as.numeric(p_cutoff),
        FC_cutoff = threshold_lfc,
        xlim = c(x_min, x_max),
        ylim = c(y_min, y_max),
        color = c("#D3D3D3", "#D3D3D3", "#D3D3D3", color),  #TODO More control
        cutoff_line_width = 3,
        point_size = 2.5,
        title = "",
        subtitle = ""
    ) + 
        ylab("-log10(s)") +
        theme_AG_no_legend
    
    #  Make an MA plot
    info_MA <- write_plot_info(
        dds_colData = colData(dds),
        dds_design = dds@design,
        title = "MA plot",
        is_apeglm = FALSE,
        n_DE_up = as.character(n_feat_lt_lfc_lt_s_shrunken[2]),
        n_DE_down = as.character(n_feat_gt_lfc_lt_s_shrunken[2])
    )
    
    p_MA_shrunken <- plot_MA(
        table = t_DGE_shrunken,
        alpha = p_cutoff,
        selection = selection_shrunken,
        x_min = x_min,
        x_max = x_max,
        legend_header = paste("s ≤", p_cutoff),
        title = info_MA[1],
        subtitle = info_MA[2]
    )
    
    #  Plot s-value histogram
    hist_shrunken_s <- t_DGE_shrunken %>%
        ggplot(aes(x = padj)) +
        geom_histogram(
            binwidth = 0.0033,  #TODO More control
            fill = "steelblue",
            color = "white"
        ) +
        labs(
            x = "s-value",
            y = "frequency",
            title = "s-value distribution"
        ) +
        theme_slick
    
    
    #  Perform LFC tests in which p are the max of upper, lower tests =========
    #+ (i.e., "lessAbs" tests)
    if(base::isTRUE(as.numeric(threshold_lfc) > 0)) {
        #  Initialize a DESeq2 DataFrame object
        DGE_lessAbs_unshrunken_DF <- DESeq2::results(
            dds,
            name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
            independentFiltering = independent_filtering,
            alpha = threshold_p_lessAbs,
            lfcThreshold = threshold_lfc,
            altHypothesis = "lessAbs",
            format = "DataFrame"
        )
        
        #  Initialize a GRanges object, which we can easily add to and convert
        #+ to other formats (such as a tibble)
        DGE_lessAbs_unshrunken_GR <- DESeq2::results(
            dds,
            name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
            independentFiltering = independent_filtering,
            alpha = threshold_p_lessAbs,
            lfcThreshold = threshold_lfc,
            altHypothesis = "lessAbs",
            format = "GRanges"
        )
        DGE_lessAbs_unshrunken_GR$features <- MatrixGenerics::rowRanges(dds)$features
        DGE_lessAbs_unshrunken_GR$names <- MatrixGenerics::rowRanges(dds)$names
        DGE_lessAbs_unshrunken_GR$thorough <- MatrixGenerics::rowRanges(dds)$thorough
        DGE_lessAbs_unshrunken_GR$type <- MatrixGenerics::rowRanges(dds)$type
        DGE_lessAbs_unshrunken_GR$genome <- MatrixGenerics::rowRanges(dds)$genome
        
        #  Coerce GRanges object to tibble
        t_DGE_lessAbs_unshrunken <- DGE_lessAbs_unshrunken_GR %>%
            dplyr::as_tibble()
        
        #  Identify top 5 up- and downregulated significant features
        all_lessAbs_unshrunken <- t_DGE_lessAbs_unshrunken$thorough
        if(base::isTRUE(selection)) {
            selection_down_lessAbs_unshrunken <- t_DGE_lessAbs_unshrunken %>%
                dplyr::filter(log2FoldChange < 0) %>%
                dplyr::arrange(padj) %>%
                dplyr::slice(1:5)
            selection_up_lessAbs_unshrunken <- t_DGE_lessAbs_unshrunken %>%
                dplyr::filter(log2FoldChange > 0) %>%
                dplyr::arrange(padj) %>%
                dplyr::slice(1:5)
            selection_lessAbs_unshrunken <- as.character(c(
                selection_down_lessAbs_unshrunken[["thorough"]],
                selection_up_lessAbs_unshrunken[["thorough"]]
            ))
        } else {
            selection_lessAbs_unshrunken <- ""
        }
        
        #  Tally number of features greater than LFC threshold and less than
        #+ pvalue threshold
        `n_feat_lt_abs-lfc_lt_padj_lessAbs_unshrunken` <- table(
            abs(t_DGE_lessAbs_unshrunken$log2FoldChange) <= threshold_lfc &
            t_DGE_lessAbs_unshrunken$padj < threshold_p_lessAbs
        )
        # table(abs(t_DGE_lessAbs_unshrunken$log2FoldChange) <= threshold_lfc)
        # table(t_DGE_lessAbs_unshrunken$padj < threshold_p_lessAbs)

        #  Make volcano plots
        info_volcano <- write_plot_info(
            dds_colData = colData(dds),
            dds_design = dds@design,
            title = "volcano plot",
            is_apeglm = FALSE,
            n_DE_up = 0,
            n_DE_down = 0
        )
        
        p_vol_lessAbs_unshrunken_KA <- plot_volcano(
            table = t_DGE_lessAbs_unshrunken,
            label = all_lessAbs_unshrunken,
            selection = selection_lessAbs_unshrunken,
            label_size = 2.5,
            p_cutoff = threshold_p_lessAbs,
            FC_cutoff = threshold_lfc,
            xlim = c(-2, 2),
            ylim = c(0, 5),
            color = c("#D3D3D3", "#D3D3D3", color, "#D3D3D3"),  #TODO More control
            title = info_volcano[1],
            subtitle = info_volcano[2]
        ) + 
            ylab("-log10(q)")
        
        p_vol_lessAbs_unshrunken_AG <- plot_volcano(
            table = t_DGE_lessAbs_unshrunken,
            label = all_lessAbs_unshrunken,
            selection = selection_lessAbs_unshrunken,
            label_size = 2.5,
            p_cutoff = threshold_p_lessAbs,
            FC_cutoff = threshold_lfc,
            xlim = c(-2, 2),
            ylim = c(0, 5),
            color = c("#D3D3D3", "#D3D3D3", color, "#D3D3D3"),  #TODO More control
            cutoff_line_width = 3,
            point_size = 2.5,
            title = "",
            subtitle = ""
        ) + 
            ylab("-log10(q)") +
            theme_AG_no_legend
        
        #  Make an MA plot
        info_MA <- write_plot_info(
            dds_colData = colData(dds),
            dds_design = dds@design,
            title = "MA plot",
            is_apeglm = FALSE,
            n_DE_up = 0,
            n_DE_down = 0
        )
        
        p_MA_lessAbs_unshrunken <- plot_MA(
            table = t_DGE_lessAbs_unshrunken,
            alpha = threshold_p_lessAbs,
            selection = selection_lessAbs_unshrunken,
            x_min = x_min,
            x_max = x_max,
            legend_header = paste("q ≤", threshold_p_lessAbs),
            title = info_MA[1],
            subtitle = info_MA[2]
        )
        
        #  Plot lessAbs p- and q-value histogram
        hist_lessAbs_unshrunken_p <- t_DGE_lessAbs_unshrunken %>%
            ggplot(aes(x = pvalue)) +
            geom_histogram(
                binwidth = 0.025,  #TODO More control
                fill = "steelblue",
                color = "white"
            ) +
            labs(
                x = "p-value",
                y = "frequency",
                title = "p-value distribution"
            ) +
            theme_slick
        
        hist_lessAbs_unshrunken_q <- t_DGE_lessAbs_unshrunken[
            !is.na(t_DGE_lessAbs_unshrunken$padj),
        ] %>%
            ggplot(aes(x = padj)) +
            geom_histogram(
                binwidth = 0.025,  #TODO More control
                fill = "steelblue",
                color = "white"
            ) +
            labs(
                x = "q-value",
                y = "frequency",
                title = "q-value distribution"
            ) +
            theme_slick
    }

    results_list <- list()
    results_list[["01_dds"]] <- dds
    
    results_list[["02_DGE_unshrunken_DF"]] <- DGE_unshrunken_DF
    results_list[["02_DGE_shrunken_DF"]] <- DGE_shrunken_DF
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["02_DGE_lessAbs_unshrunken_DF"]] <- DGE_lessAbs_unshrunken_DF
    }
    
    results_list[["03_DGE_unshrunken_GR"]] <- DGE_unshrunken_GR
    results_list[["03_DGE_shrunken_GR"]] <- DGE_shrunken_GR
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["03_DGE_lessAbs_unshrunken_GR"]] <- DGE_lessAbs_unshrunken_GR
    }
    
    results_list[["04_t_DGE_unshrunken"]] <- t_DGE_unshrunken
    results_list[["04_t_DGE_shrunken"]] <- t_DGE_shrunken
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["04_t_DGE_lessAbs_unshrunken"]] <- t_DGE_lessAbs_unshrunken
    }

    if(base::isTRUE(selection)) {
        results_list[["05_selection_down_unshrunken"]] <- selection_down_unshrunken
        results_list[["05_selection_down_shrunken"]] <- selection_down_shrunken
        if(as.numeric(threshold_lfc) > 0) {
            results_list[["05_selection_down_lessAbs_unshrunken"]] <- selection_down_lessAbs_unshrunken
        }
        
        results_list[["06_selection_up_unshrunken"]] <- selection_up_unshrunken
        results_list[["06_selection_up_shrunken"]] <- selection_up_shrunken
        if(as.numeric(threshold_lfc) > 0) {
            results_list[["06_selection_up_lessAbs_unshrunken"]] <- selection_up_lessAbs_unshrunken
        }
        
        results_list[["07_selection_unshrunken"]] <- selection_unshrunken
        results_list[["07_selection_shrunken"]] <- selection_shrunken
        if(as.numeric(threshold_lfc) > 0) {
            results_list[["07_selection_lessAbs_unshrunken"]] <- selection_lessAbs_unshrunken
        }
    }
    
    results_list[["08_p_vol_unshrunken_AG"]] <- p_vol_unshrunken_AG
    results_list[["08_p_vol_unshrunken_KA"]] <- p_vol_unshrunken_KA
    results_list[["08_p_vol_shrunken_AG"]] <- p_vol_shrunken_AG
    results_list[["08_p_vol_shrunken_KA"]] <- p_vol_shrunken_KA
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["08_p_vol_lessAbs_unshrunken_AG"]] <- p_vol_lessAbs_unshrunken_AG
        results_list[["08_p_vol_lessAbs_unshrunken_KA"]] <- p_vol_lessAbs_unshrunken_KA
    }
    
    results_list[["09_p_MA_unshrunken"]] <- p_MA_unshrunken
    results_list[["09_p_MA_shrunken"]] <- p_MA_shrunken
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["09_p_MA_lessAbs_unshrunken"]] <- p_MA_lessAbs_unshrunken
    }
    
    results_list[["10_hist_unshrunken_p"]] <- hist_unshrunken_p
    results_list[["10_hist_unshrunken_q"]] <- hist_unshrunken_q
    results_list[["10_hist_shrunken_s"]] <- hist_shrunken_s
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["10_hist_lessAbs_unshrunken_p"]] <- hist_lessAbs_unshrunken_p
        results_list[["10_hist_lessAbs_unshrunken_q"]] <- hist_lessAbs_unshrunken_q
    }
    
    results_list[["11.1_n_feat_gte_abs-lfc_lt_padj_unshrunken"]] <- `n_feat_gte_abs-lfc_lt_padj_unshrunken`
    results_list[["11.1_n_feat_gt_lfc_lt_padj_unshrunken"]] <- n_feat_gt_lfc_lt_padj_unshrunken
    results_list[["11.1_n_feat_lt_lfc_lt_padj_unshrunken"]] <- n_feat_lt_lfc_lt_padj_unshrunken
    
    results_list[["11.2_n_feat_gte_abs-lfc_lt_s_shrunken"]] <- `n_feat_gte_abs-lfc_lt_s_shrunken`
    results_list[["11.2_n_feat_gt_lfc_lt_s_shrunken"]] <- n_feat_gt_lfc_lt_s_shrunken
    results_list[["11.2_n_feat_lt_lfc_lt_s_shrunken"]] <- n_feat_lt_lfc_lt_s_shrunken
    
    if(as.numeric(threshold_lfc) > 0) {
        results_list[["11.3_n_feat_lt_abs-lfc_lt_padj_lessAbs_unshrunken"]] <- `n_feat_lt_abs-lfc_lt_padj_lessAbs_unshrunken`
    }
    
    return(results_list)
}


run_main <- function(
    t_sub,
    genotype_exp,
    genotype_ctrl,
    filtering = "min-10-cts-all-but-1-samps",
    threshold_p = 0.05,
    threshold_p_lessAbs = 0.99,
    x_min = -14,
    x_max = 14,
    y_min = 0,
    y_max = 310,
    color = "#3A538B"
) {
    # ...
    #
    # :param t_sub: ...
    # :param genotype_exp: ...
    # :param genotype_ctrl: ...
    # :param filtering: ...
    # :param x_min: ...
    # :param x_max: ...
    # :param y_min: ...
    # :param y_max: ...
    # :param color: ...
    # :return results_list: ...
    
    #  Debug code
    debug <- FALSE
    if(base::isTRUE(debug)) {
        t_sub <- `SS-Q-nab3d_SS-Q-parental`
        genotype_exp <- "n3d"
        genotype_ctrl <- "od"
        filtering <- "min-4-cts-3-samps"
        threshold_p <- 0.05
        threshold_p_lessAbs <- 0.99
        x_min <- -5
        x_max <- 10
        y_min <- 0
        y_max <- 100
        color <- "#481A6C"
    }
    
    
    #  Check arguments --------------------------------------------------------
    if(filtering %notin% c(
        "none", "filterByExpr.default", "min-10-cts-1-samp",
        "min-10-cts-2-samps", "min-1-ct-3-samps", "min-2-cts-3-samps",
        "min-3-cts-3-samps", "min-4-cts-3-samps", "min-5-cts-3-samps",
        "min-10-cts-3-samps", "min-4-cts-all-but-1-samps",
        "min-10-cts-all-but-1-samps", "min-10-cts-all-samps"
    )) {
        stop(paste(
            "Argument for 'filtering' must be \"none\",",
            "\"filterByExpr.default\", \"min-10-cts-1-samp\",",
            "\"min-10-cts-2-samps\", \"min-1-ct-3-samps\",",
            "\"min-2-cts-3-samps\", \"min-3-cts-3-samps\",",
            "\"min-4-cts-3-samps\", \"min-5-cts-3-samps\",",
            "\"min-10-cts-3-samps\", \"min-10-cts-all-but-1-samps\",",
             "or \"min-10-cts-all-samps\""
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
            no_genotype = as.factor(ifelse(genotype == genotype_ctrl, 0, 1)),
            state = factor(state, levels = c("G1", "Q")),
            no_state = as.factor(sapply(
                as.character(state),
                switch,
                "G1" = 0,
                "Q" = 1,
                USE.NAMES = FALSE
            )),
            transcription = factor(transcription, levels = c("SS", "N")),
            no_transcription = as.factor(sapply(
                as.character(transcription),
                switch,
                "SS" = 0,
                "N" = 1,
                USE.NAMES = FALSE
            )),
            replicate = factor(replicate, levels = c("rep1", "rep2")),
            no_replicate = as.factor(sapply(
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                USE.NAMES = FALSE
            )),
            technical = factor(technical, levels = c("tech1", "tech2")),
            no_technical = as.factor(sapply(
                as.character(technical),
                switch,
                "tech1" = 0,
                "tech2" = 1,
                USE.NAMES = FALSE
            ))
        ) %>%
        droplevels()
    
    
    #  Filter t_sub to remove features with low counts across samples ---------
    t_sub.bak <- t_sub
    # t_sub <- t_sub.bak
    
    if(filtering == "none"){
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
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
        
        #  Clean up
        rm(t_edge, group, eds, design, t_tmp)
        
        # dispose[dispose$genome == "S_cerevisiae", ] %>% nrow()
        # dispose[dispose$genome == "K_lactis", ] %>% nrow()
    } else {
        counts <- sapply(
            t_sub[t_sub$genome == "S_cerevisiae", 12:ncol(t_sub)], as.numeric
        )
        
        if(filtering == "min-10-cts-1-samp") {
            keep <- rowSums(counts >= 10) >= 1
        } else if(filtering == "min-10-cts-2-samps") {
            keep <- rowSums(counts >= 10) >= 2
        } else if(filtering == "min-1-ct-3-samps") {
            keep <- rowSums(counts >= 1) >= 3
        } else if(filtering == "min-2-cts-3-samps") {
            keep <- rowSums(counts >= 2) >= 3
        } else if(filtering == "min-3-cts-3-samps") {
            keep <- rowSums(counts >= 3) >= 3
        } else if(filtering == "min-4-cts-3-samps") {
            keep <- rowSums(counts >= 4) >= 3
        } else if(filtering == "min-5-cts-3-samps") {
            keep <- rowSums(counts >= 5) >= 3
        } else if(filtering == "min-10-cts-3-samps") {
            keep <- rowSums(counts >= 10) >= 3
        } else if(filtering == "min-4-cts-all-but-1-samps") {
            keep <- rowSums(counts >= 4) >= length(12:ncol(t_sub)) - 1
        } else if(filtering == "min-10-cts-all-but-1-samps") {
            keep <- rowSums(counts >= 10) >= length(12:ncol(t_sub)) - 1
        } else if(filtering == "min-10-cts-all-samps") {
            keep <- rowSums(counts >= 10) >= length(12:ncol(t_sub))
        }
        
        t_tmp <- t_sub[t_sub$genome == "S_cerevisiae", ]
        t_tmp <- t_tmp[keep, ]
    }
    
    t_sub <- dplyr::bind_rows(t_tmp, t_sub[t_sub$genome != "S_cerevisiae", ])
    
    
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
    # g_pos %>% tibble::as_tibble()
    
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

    #  Using default parameters (except for size-factor estimation), call
    #+ DESeq2() on S. cerevisiae features 
    dds <- DESeq2::DESeq(dds[dds@rowRanges$genome != "K_lactis", ])
    
    #  Record model information, etc.
    size_factors <- dds$sizeFactor %>% as.data.frame()
    size_factors_recip <- (1 / dds$sizeFactor) %>% as.data.frame()
    design <- dds@design
    col_data <- dds@colData
    model_info <- DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))]
    
    
    #  Call DESeq2 results() and generate volcano and MA plots ----------------
    lfc_0 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 0,  # i.e., 2^0 = 1
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.32 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 0.32,  # i.e., 2^0.32 ≈ 1.25
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.415 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 0.415,  # i.e., 2^0.415 ≈ 1.33
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.58 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 0.58,  # i.e., 2^0.58 ≈ 1.5
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.737 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 0.737,  # i.e., 2^0.737 ≈ 1.67
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_0.807 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 0.807,  # i.e., 2^0.807 ≈ 1.75
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    lfc_1 <- call_DESeq2_results_run_analyses(
        dds = dds,
        independent_filtering = TRUE,
        threshold_p = threshold_p,
        threshold_p_lessAbs = threshold_p_lessAbs,
        threshold_lfc = 1,  # i.e., 2^1 = 2
        x_min = x_min,
        x_max = x_max,
        y_min = y_min,
        y_max = y_max,
        color = color,
        selection = FALSE
    )
    
    run <- TRUE
    if(base::isTRUE(run)) {
        lfc_1.32 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 1.32,  # i.e., 2^1.32 ≈ 2.5
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
    
        lfc_1.58 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 1.58,  # i.e., 2^1.58 ≈ 3
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
    
        lfc_2 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 2,  # i.e., 2^2 = 4
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
    
        lfc_2.32 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 2.32,  # i.e., 2^2.32 ≈ 5
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
    
        lfc_2.58 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 2.58,  # i.e., 2^2.58 ≈ 6
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
    
        lfc_3 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 3,  # i.e., 2^3 = 8
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
        
        lfc_4 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 4,  # i.e., 2^4 = 16
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
        
        lfc_5 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 5,  # i.e., 2^5 = 32
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
        
        lfc_6 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 6,  # i.e., 2^6 = 64
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
        
        lfc_7 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 7,  # i.e., 2^7 = 128
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
        
        lfc_8 <- call_DESeq2_results_run_analyses(
            dds = dds,
            independent_filtering = TRUE,
            threshold_p = threshold_p,
            threshold_p_lessAbs = threshold_p_lessAbs,
            threshold_lfc = 8,  # i.e., 2^8 = 256
            x_min = x_min,
            x_max = x_max,
            y_min = y_min,
            y_max = y_max,
            color = color,
            selection = FALSE
        )
    }
    
    #  Return results ---------------------------------------------------------
    results_list <- list()
    results_list[["01_t_init"]] <- t_sub.bak
    results_list[["02_t_meta"]] <- t_meta
    results_list[["03_filtering"]] <- filtering
    
    if(filtering != "filterByExpr.default") {
        results_list[["04_counts"]] <- counts
        results_list[["04_keep"]] <- keep
        results_list[["04_t_tmp"]] <- t_tmp
    }
    
    if(filtering == "filterByExpr.default") {
        results_list[["04_t_edge"]] <- t_edge
        results_list[["04_group"]] <- group
        results_list[["04_eds"]] <- eds
        results_list[["04_design"]] <- design
        results_list[["04_keep"]] <- keep
        results_list[["04_t_tmp"]] <- t_tmp
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
    
    results_list[["09_lfc_0_fc_1"]] <- lfc_0
    results_list[["09_lfc_0.32_fc_1.25"]] <- lfc_0.32
    results_list[["09_lfc_0.415_fc_1.33"]] <- lfc_0.415
    results_list[["09_lfc_0.58_fc_1.5"]] <- lfc_0.58
    results_list[["09_lfc_0.737_fc_1.67"]] <- lfc_0.737
    results_list[["09_lfc_0.807_fc_1.75"]] <- lfc_0.807
    results_list[["09_lfc_1_fc_2"]] <- lfc_1
    
    if(base::isTRUE(run)) {
        results_list[["09_lfc_1.32_fc_2.5"]] <- lfc_1.32
        results_list[["09_lfc_1.58_fc_3"]] <- lfc_1.58
        results_list[["09_lfc_2_fc_4"]] <- lfc_2
        results_list[["09_lfc_2.32_fc_5"]] <- lfc_2.32
        results_list[["09_lfc_2.58_fc_6"]] <- lfc_2.58
        results_list[["09_lfc_3_fc_8"]] <- lfc_3
        results_list[["09_lfc_4_fc_16"]] <- lfc_4
        results_list[["09_lfc_5_fc_32"]] <- lfc_5
        results_list[["09_lfc_6_fc_64"]] <- lfc_6
        results_list[["09_lfc_7_fc_128"]] <- lfc_7
        results_list[["09_lfc_8_fc_256"]] <- lfc_8
    }
    
    return(results_list)
}


print_volcano_unshrunken <- function(
    dataframe,
    outpath = "/Users/kalavatt/Desktop",
    type_plot = "volcano",
    type_feature = "mRNA",
    lfc = "lfc-gt-0.58",
    width = 7,
    height = 7,
    style = "AG",
    type = type  # Must be "mRNA", "mRNA-AS", "Ovation", etc.
) {
    # ...
    #
    # :param dataframe: ...
    # :param outpath: ...
    # :param type_plot: ...
    # :param type_feature: ...
    # :param lfc: ...
    # :param dataframe: ...
    # :param width: ...
    # :param height: ...
    # :param style: ...
    # :param type: ...
    
    debug <- FALSE
    if(base::isTRUE(debug)) {
        dataframe <- `DGE-analysis_SS-Q-rrp6∆_SS-Q-WT`
        outpath <- "/Users/kalavatt/Desktop"
        type_plot <- "volcano"
        type_feature <- "mRNA"
        lfc <- "lfc-gt-0"
        width <- 7
        height <- 7
        style <- "AG"
        type <- "mRNA-AS"
    }
    
    part_1 <- unlist(stringr::str_split(deparse(substitute(dataframe)), "_"))[2]
    part_2 <- unlist(stringr::str_split(deparse(substitute(dataframe)), "_"))[3]
    part_3 <- lfc
    part_4 <- type_feature
    part_5 <- type_plot
    
    file_prefix <- paste(
        type, part_1, "vs", part_2, part_3, part_4, part_5,
        sep = "_"
    )
    
    outfile <- paste0(
        outpath, "/",
        file_prefix, ".",
        format(Sys.time(), format = "%F_%H.%M.%S"),
        ".pdf"
    )
    
    pdf(file = outfile, width = width, height = height)
    
    if(style %notin% c("AG", "KA")) {
        stop(paste("Argument \"lfc\" must be \"AG\" or \"KA\""))
    }
    
    if(style == "AG") {
        style <- "08_p_vol_unshrunken_AG"
    } else if(style == "KA") {
        style <- "08_p_vol_unshrunken_KA"
    }
    
    if(lfc %notin% c(
        "lfc-gt-0", "lfc-gt-0.32", "lfc-gt-0.415", "lfc-gt-0.58",
        "lfc-gt-0.737", "lfc-gt-0.807", "lfc-gt-1", "lfc-gt-1.32",
        "lfc-gt-1.58", "lfc-gt-2", "lfc-gt-2.32", "lfc-gt-2.58", "lfc-gt-3",
        "lfc-gt-4", "lfc-gt-5", "lfc-gt-6", "lfc-gt-7", "lfc-gt-8"
    )) {
        stop(paste0(
            "Argument \"lfc\" must be one of the following:\n\t- lfc-gt-0\n\t",
            "- lfc-gt-0.32\n\t- lfc-gt-0.415\n\t- lfc-gt-0.58\n\t",
            "- lfc-gt-0.737\n\t- lfc-gt-0.807\n\t- lfc-gt-1\n\t",
            "- lfc-gt-1.32\n\t- lfc-gt-1.58\n\t- lfc-gt-2\n\t",
            "- lfc-gt-2.32\n\t- lfc-gt-2.58\n\t- lfc-gt-3\n\t- lfc-gt-4\n\t",
            "- lfc-gt-5\n\t- lfc-gt-6\n\t- lfc-gt-7\n\t- lfc-gt-8"
        ))
    }
    
    if(base::isTRUE(lfc == "lfc-gt-0")) {
        print(dataframe[["09_lfc_0_fc_1"]][[style]])
    } else if(lfc == "lfc-gt-0.32") {
        print(dataframe[["09_lfc_0.32_fc_1.25"]][[style]])
    } else if(lfc == "lfc-gt-0.415") {
        print(dataframe[["09_lfc_0.415_fc_1.33"]][[style]])
    } else if(lfc == "lfc-gt-0.58") {
        print(dataframe[["09_lfc_0.58_fc_1.5"]][[style]])
    } else if(lfc == "lfc-gt-0.737") {
        print(dataframe[["09_lfc_0.737_fc_1.67"]][[style]])
    } else if(lfc == "lfc-gt-0.807") {
        print(dataframe[["09_lfc_0.807_fc_1.75"]][[style]])
    } else if(lfc == "lfc-gt-1") {
        print(dataframe[["09_lfc_1_fc_2"]][[style]])
    } else if(lfc == "lfc-gt-1.32") {
        print(dataframe[["09_lfc_1.32_fc_2.5"]][[style]])
    } else if(lfc == "lfc-gt-1.58") {
        print(dataframe[["09_lfc_1.58_fc_3"]][[style]])
    } else if(lfc == "lfc-gt-2") {
        print(dataframe[["09_lfc_2_fc_4"]][[style]])
    } else if(lfc == "lfc-gt-2.32") {
        print(dataframe[["09_lfc_2.32_fc_5"]][[style]])
    } else if(lfc == "lfc-gt-2.58") {
        print(dataframe[["09_lfc_2.58_fc_6"]][[style]])
    } else if(lfc == "lfc-gt-3") {
        print(dataframe[["09_lfc_3_fc_8"]][[style]])
    } else if(lfc == "lfc-gt-4") {
        print(dataframe[["09_lfc_4_fc_16"]][[style]])
    } else if(lfc == "lfc-gt-5") {
        print(dataframe[["09_lfc_5_fc_32"]][[style]])
    } else if(lfc == "lfc-gt-6") {
        print(dataframe[["09_lfc_6_fc_64"]][[style]])
    } else if(lfc == "lfc-gt-7") {
        print(dataframe[["09_lfc_7_fc_128"]][[style]])
    } else if(lfc == "lfc-gt-8") {
        print(dataframe[["09_lfc_8_fc_256"]][[style]])
    }
    
    dev.off()
}


output_rds <- function(
    dataframe,
    type
) {
    outfile <- paste0(
        "/Users/kalavatt/Desktop", "/",
        type, "_", deparse(substitute(dataframe)), ".rds"
    )
    readr::write_rds(dataframe, outfile)
}


#TODO Relocate to match order below
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


#TODO Relocate to match order below
#TODO Can these two functions be merged? Is one redundant?
subset_process_counts_matrix <- function(named_character_vector) {
    #  Test
    # named_character_vector <- `SS-Q-nab3d_SS-Q-parental`
    
    df <- dplyr::bind_cols(
        t_mat[, 1:11],
        t_mat[, colnames(t_mat) %in% named_character_vector]
    )
    df <- dplyr::bind_cols(
        df[, 1:11],
        df[, 12:ncol(df)][
            , match(named_character_vector, colnames(df)[12:ncol(df)])
        ]
    )
    names(df)[12:ncol(df)] <- names(named_character_vector)
    
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
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 2)
    )

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")

theme_AG_no_legend <- theme_AG + theme(legend.position = "none")

theme_AG_boxed_no_legend <- theme_AG_boxed + theme(legend.position = "none")


#  Get situated, load counts matrix ===========================================
p_base <- "/Users/kalavatt/projects-etc"
p_exp <- "2022_transcriptome-construction/results/2023-0215"

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

#  Determine counts matrix to work with, then load it
#+ Options: "mRNA" "ncRNA-collapsed" "ncRNA-non-collapsed"

#  Check on "run" option
if(base::isTRUE(type %notin% c(
    "mRNA", "mRNA-AS", "coding-non-pa-ncRNA", "ncRNA-collapsed",
    "ncRNA-non-collapsed"
))) {
    stop(paste(
        "Variable \"type\" must be \"mRNA\", \"mRNA-AS\",",
        "\"coding-non-pa-ncRNA\", \"ncRNA-collapsed\", or",
        "\"ncRNA-non-collapsed\""
    ))
}

#  Load counts matrix or matrices
if(base::isTRUE(type %in% c("mRNA", "mRNA-AS"))) {
    p_tsv <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
    
    if(base::isTRUE(type == "mRNA")) {
        #  (for mRNA)
        f_tsv <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
        # paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
        #     file.exists()  # [1] TRUE
    } else if(base::isTRUE(type == "mRNA-AS")) {
        #  (for mRNA-AS)
        f_tsv <- "all-samples.combined-SC-KL-20S.hc-strd-op.mRNA.tsv"
        # paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
        #     file.exists()  # [1] TRUE
    }
    
    #  Read in htseq-count counts matrix derived from combined_SC_KL_20S.gff3
    t_tsv <- paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE) %>%
        dplyr::slice(-1)  # Slice out the first row, which contains file info
    
    #  "Clean up" counts matrix column names and "features" elements
    colnames(t_tsv) <- colnames(t_tsv) %>%
        gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .) %>%
        gsub(".UT_prim_UMI.hc-strd-op.tsv", "", .)
    
    t_tsv <- t_tsv %>%
        dplyr::mutate(
            features = features %>%
                gsub("^transcript\\:", "", .) %>%
                gsub("_mRNA", "", .)
        )
} else if(base::isTRUE(type %notin% c("mRNA", "mRNA-AS"))) {
    if(base::isTRUE(type == "coding-non-pa-ncRNA")) {
        #  Handle R64 coding, noncoding, etc. features
        p_tsv <- "outfiles_htseq-count/representation/UT_prim_UMI"
        f_tsv <- "representative-coding-non-pa-ncRNA-transcriptome.hc-strd-eq.union-none.tsv"
    } else if(base::isTRUE(type == "ncRNA-collapsed")) {
        #  Handle pa-ncRNA, collapsed and merged
        p_tsv <- "outfiles_htseq-count/representation/UT_prim_UMI"
        f_tsv <- "representative-non-coding-transcriptome.hc-strd-eq.tsv"  # (collapsed, merged)
        # paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
        #     file.exists()  # [1] TRUE
    } else if(base::isTRUE(type == "ncRNA-non-collapsed")) {
        #  Handle pa-ncRNA, not collapsed and merged
        p_tsv <- "outfiles_htseq-count/representation/UT_prim_UMI"
        f_tsv <- "non-collapsed-non-coding-transcriptome.hc-strd-eq.tsv"  # (not collapsed, merged)
        # paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
        #     file.exists()  # [1] TRUE
    }
    
    t_tsv <- paste(p_base, p_exp, p_tsv, f_tsv, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE)
    
    colnames(t_tsv) <- colnames(t_tsv) %>%
        gsub("\\.\\.\\.1", "features", .) %>%
        gsub("bams_renamed/UT_prim_UMI/", "", .) %>%
        gsub(".UT_prim_UMI.bam", "", .)
    
    #  For size-effect estimation, load K. lactis counts
    p_KL <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
    f_KL <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
    # paste(p_base, p_exp, p_KL, f_KL, sep = "/") %>%
    #     file.exists()  # [1] TRUE
    
    t_KL <- paste(p_base, p_exp, p_KL, f_KL, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE) %>%
        dplyr::slice(-1)  # Slice out the first row, which contains file info
    
    #  "Clean up" t_KL column names and "features" elements
    colnames(t_KL) <- colnames(t_KL) %>%
        gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .)
    
    #  Isolate K. lactis specific rows and bind to feature-of-interest rows
    t_KL <- t_KL %>%
        dplyr::mutate(
            features = features %>% gsub("^transcript\\:", "", .)
        )
    rm(p_KL, f_KL)
    
    t_KL <- t_KL[!stringr::str_detect(t_KL$features, "mRNA|__"), ]
    t_KL[, 2:ncol(t_KL)] <- t_KL[, 2:ncol(t_KL)] %>% sapply(., as.numeric)
    
    #  Row-bind dataframes t_tsv and t_KL
    t_tsv <- dplyr::bind_rows(t_tsv, t_KL)
    rm(t_KL)
}

#  Clean up, correct, and abbreviate sample names
col_cor <- setNames(
    c(
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1",       #EXCLUDE
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1",      #EXCLUDE
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
        "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",       #FIXME* ∆ rep1 → rep2
        "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",       #FIXME* ∆ rep2 → rep1
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",      #FIXME* ∆ rep1 → rep2
        "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",      #FIXME* ∆ rep2 → rep1
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",   #FIXME* ∆ rep1 → rep2
        "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",   #FIXME* ∆ rep2 → rep1
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",  #FIXME* ∆ rep1 → rep2
        "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",  #FIXME* ∆ rep2 → rep1
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",   #FIXME* ∆ rep1 → rep2
        "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",   #FIXME* ∆ rep2 → rep1
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",  #FIXME* ∆ rep1 → rep2
        "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",  #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",     #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ tech1 → tech2
        "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",     #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",       #FIXME* ∆ rep1 → rep2
        "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",       #FIXME* ∆ rep2 → rep1
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",      #FIXME* ∆ rep1 → rep2  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",      #FIXME* ∆ rep1 → rep2  #OK
        "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",      #FIXME* ∆ rep2 → rep1
        "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
        "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
        "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
        "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",    #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",    #OK
        "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1",
        "WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1",
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",       #FIXME‡ ∆ tech1 → tech2
        "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",       #FIXME‡ ∆ tech1 → tech2
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1", 
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1",
        "WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1",         #FIXME† Duplicated #1
        "WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1",        #FIXME† Duplicated #2
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",         #FIXME† Duplicated #1
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
        "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"         #FIXME† Duplicated #2
    ),
    c(
        "n3d_Q_N_rep1_tech1", 
        "n3d_Q_N_rep2_tech1", 
        "n3d_Q_N_rep3_tech1",       #EXCLUDE
        "n3d_Q_SS_rep1_tech1", 
        "n3d_Q_SS_rep2_tech1", 
        "n3d_Q_SS_rep3_tech1",      #EXCLUDE
        "od_Q_N_rep1_tech1", 
        "od_Q_N_rep2_tech1", 
        "od_Q_SS_rep1_tech1", 
        "od_Q_SS_rep2_tech1", 
        "r1n_Q_N_rep2_tech1",       #DONE* ∆ rep1 → rep2
        "r1n_Q_N_rep1_tech1",       #DONE* ∆ rep2 → rep1
        "r1n_Q_SS_rep2_tech1",      #DONE* ∆ rep1 → rep2
        "r1n_Q_SS_rep1_tech1",      #DONE* ∆ rep2 → rep1
        "r6n_DSm2_SS_rep2_tech1",   #DONE* ∆ rep1 → rep2
        "r6n_DSm2_SS_rep1_tech1",   #DONE* ∆ rep2 → rep1
        "r6n_DSp24_SS_rep2_tech1",  #DONE* ∆ rep1 → rep2
        "r6n_DSp24_SS_rep1_tech1",  #DONE* ∆ rep2 → rep1
        "r6n_DSp2_SS_rep2_tech1",   #DONE* ∆ rep1 → rep2
        "r6n_DSp2_SS_rep1_tech1",   #DONE* ∆ rep2 → rep1
        "r6n_DSp48_SS_rep2_tech1",  #DONE* ∆ rep1 → rep2
        "r6n_DSp48_SS_rep1_tech2",  #DONE* ∆ rep2 → rep1  #DONE‡ ∆ tech1 → tech2
        "r6n_G1_SS_rep2_tech2",     #DONE* ∆ rep1 → rep2  #DONE‡ ∆ tech1 → tech2
        "r6n_G1_SS_rep1_tech2",     #DONE* ∆ rep2 → rep1  #DONE‡ ∆ tech1 → tech2
        "r6n_Q_N_rep2_tech1",       #DONE* ∆ rep1 → rep2
        "r6n_Q_N_rep1_tech1",       #DONE* ∆ rep2 → rep1
        "r6n_Q_SS_rep2_tech1",      #DONE* ∆ rep1 → rep2  #OK
        "r6n_Q_SS_rep2_tech2",      #DONE* ∆ rep1 → rep2  #OK
        "r6n_Q_SS_rep1_tech1",      #DONE* ∆ rep2 → rep1
        "t4n_DSm2_SS_rep1_tech1", 
        "t4n_DSm2_SS_rep2_tech1", 
        "t4n_DSp24_SS_rep1_tech1", 
        "t4n_DSp24_SS_rep2_tech1", 
        "t4n_DSp2_SS_rep1_tech1", 
        "t4n_DSp2_SS_rep2_tech1", 
        "t4n_DSp48_SS_rep1_tech1", 
        "t4n_DSp48_SS_rep2_tech1", 
        "WT_DSm2_SS_rep1_tech1", 
        "WT_DSm2_SS_rep2_tech1", 
        "WT_DSp24_SS_rep1_tech1", 
        "WT_DSp24_SS_rep2_tech1", 
        "WT_DSp2_SS_rep1_tech1", 
        "WT_DSp2_SS_rep2_tech1", 
        "WT_DSp48_SS_rep1_tech1",   #OK
        "WT_DSp48_SS_rep1_tech2",   #OK
        "WT_DSp48_SS_rep2_tech1", 
        "WTovn_G1_N_rep1_tech1", 
        "WTovn_G1_N_rep2_tech1", 
        "WTovn_G1_SS_rep1_tech1", 
        "WTovn_G1_SS_rep2_tech1", 
        "WT_G1_SS_rep1_tech2",      #DONE‡ ∆ tech1 → tech2
        "WT_G1_SS_rep2_tech2",      #DONE‡ ∆ tech1 → tech2
        "WTovn_Q_N_rep1_tech1", 
        "WTovn_Q_N_rep2_tech1", 
        "WTovn_Q_SS_rep1_tech1", 
        "WTovn_Q_SS_rep2_tech1", 
        "WTtest_Q_N_rep2_tech1",    #DONE† Duplicated #1
        "WTtest_Q_SS_rep2_tech1",   #DONE† Duplicated #2
        "WT_Q_N_rep1_tech1", 
        "WT_Q_N_rep2_tech1",        #DONE† Duplicated #1
        "WT_Q_SS_rep1_tech1", 
        "WT_Q_SS_rep2_tech1"        #DONE† Duplicated #2
    )
)

init_bak <- TRUE
if(base::isTRUE(init_bak)) {
    t_tsv.bak <- t_tsv
    # t_tsv <- t_tsv.bak
}
t_tsv <- filter_process_counts_matrix(t_tsv, col_cor)


#  Load Excel spreadsheet of samples names and variables ======================
load_xlsx <- FALSE
if(base::isTRUE(load_xlsx)) {
    p_xlsx <- "notebook"
    f_xlsx <- "variables.xlsx"
    # paste(p_base, p_exp, p_xlsx, f_xlsx, sep = "/") %>%
    #     file.exists()  # [1] TRUE
    
    t_xslx <- paste(p_base, p_exp, p_xlsx, f_xlsx, sep = "/") %>%
        readxl::read_xlsx()  
    #NOTE In this file, replicate info for 7079, 7078, 7747, 7748 is incorrect
    #NOTE It seems that we're no longer using the xlsx file, so this code can
    #     be removed
}


#  Associate features with metadata and format/munge dataframe(s) =============
#HERE
if(base::isTRUE(type %in% c("mRNA", "mRNA-AS"))) {
    #  Handle "mRNA"
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
    rm(p_gff3, f_gff3)
    
    #  Subset gff3 tibble to keep only relevant columns
    keep <- c(
        "chr", "start", "end", "width", "strand", "type", "features",
        "biotype", "names"
    )
    t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
    t_gff3 <- dplyr::relocate(
        t_gff3[, colnames(t_gff3) %in% keep],
        keep[-1],
        .after = "chr"
    )
    rm(keep)
    
    #  Convert column "names" from a list (data structure) to a character vector,
    #+ and replace empty fields with NA character values
    t_gff3$names <- ifelse(
        as.character(t_gff3$names) == "character(0)",
        NA_character_,
        as.character(t_gff3$names)
    )
    
    #  Create a column of "thorough" names: use the Y* name if there is no
    #+ "common"/"normal" name; otherwise, use the "common"/"normal" name
    t_gff3$thorough <- ifelse(
        is.na(t_gff3$names),
        t_gff3$features,
        t_gff3$names
    )
    
    #  Create a column of "thorough" names: use the Y* name if there is no
    #+ "common"/"normal" name; otherwise, use the "common"/"normal" name
    t_gff3$thorough <- ifelse(
        is.na(t_gff3$names),
        t_gff3$features,
        t_gff3$names
    )
} else if(base::isTRUE(type %notin% c("mRNA", "mRNA-AS"))) {
    if(base::isTRUE(type == "coding-non-pa-ncRNA")) {
        p_gff3 <- "outfiles_gtf-gff3/representation"
        f_gff3 <- "Greenlaw-et-al_representative-coding-non-pa-ncRNA-transcriptome.gtf"
        # paste(p_base, p_exp, p_gff3, f_gff3, sep = "/") %>%
            # file.exists()  # [1] TRUE
        
        #  Load, format gff3
        t_gff3 <- paste(p_gff3, f_gff3, sep = "/") %>%
            rtracklayer::import() %>%
            as.data.frame() %>%
            dplyr::as_tibble() %>%
            dplyr::rename(c(
                chr = seqnames,
                features = gene_id,
                biotype = type.1
            )) %>%
            dplyr::mutate(
                names = NA_character_,
                thorough = NA_character_
                # names = paste0(features),
                # thorough = paste(biotype, features, sep = "-")
            )
        rm(p_gff3, f_gff3)
        
        #  Subset gff3 tibble to keep only relevant columns, and order columns
        keep <- c(
            "chr", "start", "end", "width", "strand", "type", "features",
            "biotype", "names", "thorough"
        )
        t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
        t_gff3 <- dplyr::relocate(
            t_gff3[, colnames(t_gff3) %in% keep],
            keep[-1],
            .after = "chr"
        )
        rm(keep)
    } else if(base::isTRUE(type == "ncRNA-collapsed")) {
        #  Handle pa-ncRNA, collapsed and merged
        p_gff3 <- "outfiles_gtf-gff3/representation"
        f_gff3 <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
        # paste(p_base, p_exp, p_gff3, f_gff3, sep = "/") %>%
        #     file.exists()  # [1] TRUE
        
        #  Load, format gff3
        t_gff3 <- paste(p_gff3, f_gff3, sep = "/") %>%
            rtracklayer::import() %>%
            as.data.frame() %>%
            dplyr::as_tibble() %>%
            dplyr::rename(c(
                chr = seqnames,
                features = gene_id,
                biotype = details_type_alpha,
                names = details_id
            )) %>%
            dplyr::mutate(thorough = features)
        rm(p_gff3, f_gff3)
        
        #  Subset gff3 tibble to keep only relevant columns, and order columns
        keep <- c(
            "chr", "start", "end", "width", "strand", "type", "features",
            "biotype", "names", "thorough"
        )
        t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
        t_gff3 <- dplyr::relocate(
            t_gff3[, colnames(t_gff3) %in% keep],
            keep[-1],
            .after = "chr"
        )
        rm(keep)
    } else if(base::isTRUE(type == "ncRNA-non-collapsed")) {
        #  Handle pa-ncRNA, not collapsed and merged
        p_gff3 <- "outfiles_gtf-gff3/representation"
        f_gff3 <- "Greenlaw-et-al_non-collapsed-non-coding-transcriptome.gtf"
        # paste(p_base, p_exp, p_gff3, f_gff3, sep = "/") %>%
        #     file.exists()  # [1] TRUE
        
        #  Load, format gff3
        t_gff3 <- paste(p_gff3, f_gff3, sep = "/") %>%
            rtracklayer::import() %>%
            as.data.frame() %>%
            dplyr::as_tibble() %>%
            dplyr::rename(c(
                chr = seqnames,
                features = gene_id,
                biotype = type.1
            )) %>%
            dplyr::mutate(
                names = features,
                thorough = paste0(biotype, "_", features)
            )
        rm(p_gff3, f_gff3)
        
        #  Subset gff3 tibble to keep only relevant columns, and order columns
        keep <- c(
            "chr", "start", "end", "width", "strand", "type", "features",
            "biotype", "names", "thorough"
        )
        t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
        t_gff3 <- dplyr::relocate(
            t_gff3[, colnames(t_gff3) %in% keep],
            keep[-1],
            .after = "chr"
        )
        rm(keep)
    }
    
    #  Load in, subset, and "clean up" gff3 for K. lactis information
    p_gff3_KL <- "infiles_gtf-gff3/already"
    f_gff3_KL <- "combined_SC_KL_20S.gff3"
    # paste(p_base, p_exp, p_gff3_KL, f_gff3_KL, sep = "/") %>%
    #     file.exists()  # [1] TRUE
    
    t_gff3_KL <- paste(p_gff3_KL, f_gff3_KL, sep = "/") %>%
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
        dplyr::mutate(thorough = ifelse(is.na(names), features, names))
    rm(p_gff3_KL, f_gff3_KL)
    
    #  Subset K. lactis gff3 tibble to keep only relevant columns
    keep <- c(
        "chr", "start", "end", "width", "strand", "type", "features",
        "biotype", "names", "thorough"
    )
    t_gff3_KL <- t_gff3_KL[, colnames(t_gff3_KL) %in% keep]
    t_gff3_KL <- dplyr::relocate(
        t_gff3_KL[, colnames(t_gff3_KL) %in% keep],
        keep[-1],
        .after = "chr"
    )
    rm(keep)
    
    #  Convert columns "names" and "thorough" from lists (data structure) to 
    #+ character vectors, and replace empty fields with NA character values
    t_gff3_KL$names <- ifelse(
        as.character(t_gff3_KL$names) == "character(0)",
        NA_character_,
        as.character(t_gff3_KL$names)
    )
    t_gff3_KL$thorough <- ifelse(
        as.character(t_gff3_KL$thorough) == "character(0)",
        NA_character_,
        as.character(t_gff3_KL$thorough)
    )
    
    #  Exclude S. cerevisiae contextual information, then append K. lactis
    #+ information to features of interest
    chr_KL <- c("A", "B", "C", "D", "E", "F")
    t_gff3_KL <- t_gff3_KL[t_gff3_KL$chr %in% chr_KL, ]  # 5076
    t_gff3_KL$chr <- t_gff3_KL$chr %>% droplevels()
    t_gff3_KL$chr <- factor(t_gff3_KL$chr, levels = chr_KL)
    t_gff3_KL <- t_gff3_KL %>% dplyr::arrange(chr, start)
    
    t_gff3 <- dplyr::bind_rows(t_gff3, t_gff3_KL)
    rm(t_gff3_KL, chr_KL)
}

#  Order t_gff3 by chromosome names and feature start positions
chr_SC <- c(
    "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
    "XIII", "XIV", "XV", "XVI", "Mito"
)
chr_KL <- c("A", "B", "C", "D", "E", "F")
chr_20S <- "20S"
chr_order <- c(chr_SC, chr_KL, chr_20S)
t_gff3$chr <- t_gff3$chr %>% as.factor()
t_gff3$chr <- ordered(t_gff3$chr, levels = chr_order)
t_gff3 <- t_gff3 %>% dplyr::arrange(chr, start)

#  Categorize chromosomes by genome of origin
t_gff3$genome <- ifelse(
    t_gff3$chr %in% chr_SC,
    "S_cerevisiae",
    ifelse(
        t_gff3$chr %in% chr_KL,
        "K_lactis",
        ifelse(
            t_gff3$chr %in% chr_20S,
            "20S",
            NA
        )
    )
) %>%
    as.factor()
t_gff3 <- t_gff3 %>% dplyr::relocate("genome", .before = "chr")

rm(chr_20S, chr_KL, chr_SC, chr_order)


#  Combine "counts matrix tibble" and "gff3 tibble" ===========================
t_mat <- dplyr::full_join(t_gff3, t_tsv, by = "features")

#  Remove unneeded variables
if(base::isTRUE(load_xlsx)) {
    rm(f_tsv, f_xlsx, p_base, p_exp, p_tsv, p_xlsx, t_gff3, t_tsv)
} else {
    rm(f_tsv, p_base, p_exp, p_tsv, t_gff3, t_tsv)
}

#  Create a backup of t_mat
if(base::isTRUE(init_bak)) {
    t_mat.bak <- t_mat
    # t_mat <- t_mat.bak
}

#  For "mRNA" analyses, exclude htseq-count "summary metrics" (already excluded
#+ for "pa-ncRNA" analyses) and "Mito" chromosome counts (rows)
if(base::isTRUE(type %in% c("mRNA", "mRNA-AS"))) {
    t_mat <- t_mat %>%
        dplyr::filter(genome %notin% c(NA, "20S")) %>%
        dplyr::filter(chr != "Mito")
}

#  For non-"mRNA" analyses, change all column "type" assignments from "feature"
#+ to "mRNA"  #HACK
if(base::isTRUE(type %notin% c("mRNA", "mRNA-AS"))) {
    t_mat$type <- ifelse(t_mat$type == "feature", "mRNA", t_mat$type)
}

#  If any htseq-count metric rows remain in the dataframe, then remove them
t_mat <- t_mat[!is.na(t_mat$genome), ]
#TODO Move this logic to an approriate location associated with handling
#     non-mRNA/mRNA-AS-feature dataframe


#  Filter counts matrix for samples of interest ===============================
#NOTE Can no longer do the following; data column names changed with call to 
#     filter_process_counts_matrix() above
run_old_approach <- FALSE
if(base::isTRUE(run_old_approach)) {
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
    `N-Q-nab3d_N-Q-parental` <- subset_process_counts_matrix(
        `N-Q-nab3d_N-Q-parental`
    )
    
    `SS-Q-nab3d_SS-Q-parental` <- setNames(
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
    `SS-Q-nab3d_SS-Q-parental` <- subset_process_counts_matrix(
        `SS-Q-nab3d_SS-Q-parental`
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
    `SS-Q-rrp6∆_SS-Q-WT` <- subset_process_counts_matrix(
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
    `SS-G1-rrp6∆_SS-G1-WT` <- subset_process_counts_matrix(
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
    `N-Q-rrp6∆_N-Q-WT` <- subset_process_counts_matrix(
        `N-Q-rrp6∆_N-Q-WT`
    )
    
    # `SS-DSm2-rrp6∆_SS-DSm2-WT` <- setNames(
    #     c(
    #         "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    #         "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"
    #     ),
    #     c(
    #         "r6n_DSm2_SS_rep1_tech1",
    #         "r6n_DSm2_SS_rep2_tech1",
    #         "WT_DSm2_SS_rep1_tech1",
    #         "WT_DSm2_SS_rep2_tech1"
    #     )
    # )
    # `SS-DSm2-rrp6∆_SS-DSm2-WT` <- subset_process_counts_matrix(
    #     `SS-DSm2-rrp6∆_SS-DSm2-WT`
    # )
    # 
    # `SS-DSp2-rrp6∆_SS-DSp2-WT` <- setNames(
    #     c(
    #         "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    #         "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"
    #     ),
    #     c(
    #         "r6n_DSp2_SS_rep1_tech1",
    #         "r6n_DSp2_SS_rep2_tech1",
    #         "WT_DSp2_SS_rep1_tech1",
    #         "WT_DSp2_SS_rep2_tech1"
    #     )
    # )
    # `SS-DSp2-rrp6∆_SS-DSp2-WT` <- subset_process_counts_matrix(
    #     `SS-DSp2-rrp6∆_SS-DSp2-WT`
    # )
    # 
    # `SS-DSp24-rrp6∆_SS-DSp24-WT` <- setNames(
    #     c(
    #         "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    #         "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"
    #     ),
    #     c(
    #         "r6n_DSp24_SS_rep1_tech1",
    #         "r6n_DSp24_SS_rep2_tech1",
    #         "WT_DSp24_SS_rep1_tech1",
    #         "WT_DSp24_SS_rep2_tech1"
    #     )
    # )
    # `SS-DSp24-rrp6∆_SS-DSp24-WT` <- subset_process_counts_matrix(
    #     `SS-DSp24-rrp6∆_SS-DSp24-WT`
    # )
    # 
    # `SS-DSp48-rrp6∆_SS-DSp48-WT` <- setNames(
    #     c(
    #         "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    #         "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    #         "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
    #         "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"
    #     ),
    #     c(
    #         "r6n_DSp48_SS_rep1_tech1",
    #         "r6n_DSp48_SS_rep2_tech2",
    #         "WT_DSp48_SS_rep1_tech1",
    #         "WT_DSp48_SS_rep1_tech2",
    #         "WT_DSp48_SS_rep2_tech1"
    #     )
    # )
    # `SS-DSp48-rrp6∆_SS-DSp48-WT` <- subset_process_counts_matrix(
    #     `SS-DSp48-rrp6∆_SS-DSp48-WT`
    # )
}

run_new_approach <- TRUE
if(base::isTRUE(run_new_approach)) {
    col_meta <- colnames(t_mat)[1:11]
    
    `N-Q-nab3d_N-Q-parental` <- c(
        "n3d_Q_N_rep1_tech1",
        "n3d_Q_N_rep2_tech1",
        # "n3d_Q_N_rep3_tech1",  #EXCLUDE
        "od_Q_N_rep1_tech1",
        "od_Q_N_rep2_tech1"
    )
    `N-Q-nab3d_N-Q-parental` <- t_mat[
        , colnames(t_mat) %in% c(col_meta, `N-Q-nab3d_N-Q-parental`)
    ]
    
    `SS-Q-nab3d_SS-Q-parental` <- c(
        "n3d_Q_SS_rep1_tech1",
        "n3d_Q_SS_rep2_tech1",
        # "n3d_Q_SS_rep3_tech1",  #EXCLUDE
        "od_Q_SS_rep1_tech1",
        "od_Q_SS_rep2_tech1"
    )
    `SS-Q-nab3d_SS-Q-parental` <- t_mat[
        , colnames(t_mat) %in% c(col_meta, `SS-Q-nab3d_SS-Q-parental`)
    ]
    
    `SS-Q-rrp6∆_SS-Q-WT` <- c(
        "r6n_Q_SS_rep2_tech1",
        "r6n_Q_SS_rep2_tech2",
        "r6n_Q_SS_rep1_tech1",
        "WT_Q_SS_rep1_tech1",
        "WT_Q_SS_rep2_tech1"
    )
    `SS-Q-rrp6∆_SS-Q-WT` <- t_mat[
        , colnames(t_mat) %in% c(col_meta, `SS-Q-rrp6∆_SS-Q-WT`)
    ]
    
    `SS-G1-rrp6∆_SS-G1-WT` <- c(
        "r6n_G1_SS_rep2_tech2",
        "r6n_G1_SS_rep1_tech2",
        "WT_G1_SS_rep1_tech2",
        "WT_G1_SS_rep2_tech2"
    )
    `SS-G1-rrp6∆_SS-G1-WT` <- t_mat[
        , colnames(t_mat) %in% c(col_meta, `SS-G1-rrp6∆_SS-G1-WT`)
    ]
    
    `N-Q-rrp6∆_N-Q-WT` <- c(
        "r6n_Q_N_rep2_tech1",
        "r6n_Q_N_rep1_tech1",
        "WT_Q_N_rep1_tech1",
        "WT_Q_N_rep2_tech1"
    )
    `N-Q-rrp6∆_N-Q-WT` <- t_mat[
        , colnames(t_mat) %in% c(col_meta, `N-Q-rrp6∆_N-Q-WT`)
    ]
    
    # `SS-DSm2-rrp6∆_SS-DSm2-WT` <- c(
    #     "r6n_DSm2_SS_rep2_tech1",
    #     "r6n_DSm2_SS_rep1_tech1",
    #     "WT_DSm2_SS_rep1_tech1",
    #     "WT_DSm2_SS_rep2_tech1"
    # )
    # `SS-DSm2-rrp6∆_SS-DSm2-WT` <- t_mat[
    #     , colnames(t_mat) %in% c(col_meta, `SS-DSm2-rrp6∆_SS-DSm2-WT`)
    # ]
    # 
    # `SS-DSp2-rrp6∆_SS-DSp2-WT` <- c(
    #     "r6n_DSp2_SS_rep2_tech1",
    #     "r6n_DSp2_SS_rep1_tech1",
    #     "WT_DSp2_SS_rep1_tech1",
    #     "WT_DSp2_SS_rep2_tech1"
    # )
    # `SS-DSp2-rrp6∆_SS-DSp2-WT` <- t_mat[
    #     , colnames(t_mat) %in% c(col_meta, `SS-DSp2-rrp6∆_SS-DSp2-WT`)
    # ]
    # 
    # `SS-DSp24-rrp6∆_SS-DSp24-WT` <- c(
    #     "r6n_DSp24_SS_rep2_tech1",
    #     "r6n_DSp24_SS_rep1_tech1",
    #     "WT_DSp24_SS_rep1_tech1",
    #     "WT_DSp24_SS_rep2_tech1"
    # )
    # `SS-DSp24-rrp6∆_SS-DSp24-WT` <- t_mat[
    #     , colnames(t_mat) %in% c(col_meta, `SS-DSp24-rrp6∆_SS-DSp24-WT`)
    # ]
    # 
    # `SS-DSp48-rrp6∆_SS-DSp48-WT` <- c(
    #     "r6n_DSp48_SS_rep2_tech1",
    #     "r6n_DSp48_SS_rep1_tech2",
    #     "WT_DSp48_SS_rep1_tech1",
    #     "WT_DSp48_SS_rep1_tech2",
    #     "WT_DSp48_SS_rep2_tech1"
    # )
    # `SS-DSp48-rrp6∆_SS-DSp48-WT` <- t_mat[
    #     , colnames(t_mat) %in% c(col_meta, `SS-DSp48-rrp6∆_SS-DSp48-WT`)
    # ]
}


#  Analyze, graph datasets of interest ========================================
`DGE-analysis_N-Q-nab3d_N-Q-parental` <- run_main(
    #  See 230517_lab_meeting.pptx, slide 15
    t_sub = `N-Q-nab3d_N-Q-parental`,
    genotype_exp = "n3d",
    genotype_ctrl = "od",
    # filtering = "min-4-cts-3-samps",
    filtering = "min-4-cts-all-but-1-samps",
    threshold_p = 0.05,
    threshold_p_lessAbs = 0.99,
    x_min = -5,
    x_max = 10,
    y_min = 0,
    y_max = ifelse(type == "mRNA", 40, 100),
    color = "#3A538B"
)

`DGE-analysis_SS-Q-nab3d_SS-Q-parental` <- run_main(
    #  See 230517_lab_meeting.pptx, slide 15
    t_sub = `SS-Q-nab3d_SS-Q-parental`,
    genotype_exp = "n3d",
    genotype_ctrl = "od",
    # filtering = "min-4-cts-3-samps",
    filtering = "min-4-cts-all-but-1-samps",
    x_min = -5,
    x_max = 10,
    y_min = 0,
    y_max = 100,
    color = "#481A6C"
)

`DGE-analysis_SS-Q-rrp6∆_SS-Q-WT` <- run_main(
    #  See 230517_lab_meeting.pptx, slide 12
    t_sub = `SS-Q-rrp6∆_SS-Q-WT`,
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    # filtering = "min-4-cts-3-samps",
    filtering = "min-4-cts-all-but-1-samps",
    x_min = -5,
    x_max = 10,
    y_min = 0,
    y_max = 60,
    color = "#481A6C"
)

`DGE-analysis_SS-G1-rrp6∆_SS-G1-WT` <- run_main(
    #  See 230517_lab_meeting.pptx, slide 12
    t_sub = `SS-G1-rrp6∆_SS-G1-WT`,
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    # filtering = "min-4-cts-3-samps",
    filtering = "min-4-cts-all-but-1-samps",
    x_min = -5,
    x_max = 10,
    y_min = 0,
    y_max = 170,
    color = "#481A6C"
)

`DGE-analysis_N-Q-rrp6∆_N-Q-WT` <- run_main(
    #  See 230517_lab_meeting.pptx, slide 13
    t_sub = `N-Q-rrp6∆_N-Q-WT`,
    genotype_exp = "r6n",
    genotype_ctrl = "WT",
    # filtering = "min-4-cts-3-samps",
    filtering = "min-4-cts-all-but-1-samps",
    x_min = -5,
    x_max = 10,
    y_min = 0,
    y_max = 60,
    color = "#3A538B"
)

run_test <- FALSE
if(base::isTRUE(run_test)) {
    #  Run tests/check things
    test <- `DGE-analysis_N-Q-nab3d_N-Q-parental`
    # test <- `DGE-analysis_SS-Q-nab3d_SS-Q-parental`
    # test <- `DGE-analysis_SS-Q-rrp6∆_SS-Q-WT`
    # test <- `DGE-analysis_SS-G1-rrp6∆_SS-G1-WT`
    # test <- `DGE-analysis_N-Q-rrp6∆_N-Q-WT`

    # test$`01_t_init`
    # test$`02_t_meta`
    # test$`03_filtering`
    # test$`04_t_tmp`
    # test$`05_t_sub`
    # test$`06_g_pos` %>% tibble::as_tibble()
    # test$`07_t_counts` %>% tibble::as_tibble()
    # test$`08_size_factors`
    # test$`08_size_factors_recip`
    # test$`08_col_data`
    # test$`08_dds`@rowRanges %>% tibble::as_tibble()
    # test$`08_dds`@colData

    # test$`09_lfc_0.415_fc_1.33`$`01_dds`
    # test$`09_lfc_0.415_fc_1.33`$`02_DGE_unshrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.415_fc_1.33`$`02_DGE_shrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.415_fc_1.33`$`02_DGE_lessAbs_unshrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.415_fc_1.33`$`03_DGE_unshrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.415_fc_1.33`$`03_DGE_shrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.415_fc_1.33`$`03_DGE_lessAbs_unshrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.415_fc_1.33`$`04_t_DGE_unshrunken`
    # test$`09_lfc_0.415_fc_1.33`$`04_t_DGE_lessAbs_unshrunken`
    # as.numeric(table(test$`09_lfc_0.415_fc_1.33`$`04_t_DGE_lessAbs_unshrunken`$padj < 0.99)[2])
    # test$`09_lfc_0.415_fc_1.33`$`04_t_DGE_shrunken`
    test$`09_lfc_0.415_fc_1.33`$`08_p_vol_unshrunken_KA`
    # test$`09_lfc_0.415_fc_1.33`$`08_p_vol_shrunken_KA`
    # test$`09_lfc_0.415_fc_1.33`$`08_p_vol_lessAbs_unshrunken_KA`
    # test$`09_lfc_0.415_fc_1.33`$`09_p_MA_unshrunken`
    # test$`09_lfc_0.415_fc_1.33`$`09_p_MA_shrunken`
    # test$`09_lfc_0.415_fc_1.33`$`09_p_MA_lessAbs_unshrunken`
    # test$`09_lfc_0.415_fc_1.33`$`10_hist_unshrunken_p`
    # test$`09_lfc_0.415_fc_1.33`$`10_hist_unshrunken_q`
    # test$`09_lfc_0.415_fc_1.33`$`10_hist_shrunken_s`
    # test$`09_lfc_0.415_fc_1.33`$`10_hist_lessAbs_unshrunken_p`
    # test$`09_lfc_0.415_fc_1.33`$`10_hist_lessAbs_unshrunken_q`

    # test$`09_lfc_0.58_fc_1.5`$`01_dds`
    # test$`09_lfc_0.58_fc_1.5`$`02_DGE_unshrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.58_fc_1.5`$`02_DGE_shrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.58_fc_1.5`$`02_DGE_lessAbs_unshrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.58_fc_1.5`$`03_DGE_unshrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.58_fc_1.5`$`03_DGE_shrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.58_fc_1.5`$`03_DGE_lessAbs_unshrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.58_fc_1.5`$`04_t_DGE_unshrunken`
    # test$`09_lfc_0.58_fc_1.5`$`04_t_DGE_lessAbs_unshrunken`
    # as.numeric(table(test$`09_lfc_0.58_fc_1.5`$`04_t_DGE_lessAbs_unshrunken`$padj < 0.99)[2])
    # test$`09_lfc_0.58_fc_1.5`$`04_t_DGE_shrunken`
    test$`09_lfc_0.58_fc_1.5`$`08_p_vol_unshrunken_KA`
    # test$`09_lfc_0.58_fc_1.5`$`08_p_vol_shrunken_KA`
    # test$`09_lfc_0.58_fc_1.5`$`08_p_vol_lessAbs_unshrunken_KA`
    # test$`09_lfc_0.58_fc_1.5`$`09_p_MA_unshrunken`
    # test$`09_lfc_0.58_fc_1.5`$`09_p_MA_shrunken`
    # test$`09_lfc_0.58_fc_1.5`$`09_p_MA_lessAbs_unshrunken`
    # test$`09_lfc_0.58_fc_1.5`$`10_hist_unshrunken_p`
    # test$`09_lfc_0.58_fc_1.5`$`10_hist_unshrunken_q`
    # test$`09_lfc_0.58_fc_1.5`$`10_hist_shrunken_s`
    # test$`09_lfc_0.58_fc_1.5`$`10_hist_lessAbs_unshrunken_p`
    # test$`09_lfc_0.58_fc_1.5`$`10_hist_lessAbs_unshrunken_q`

    # test$`09_lfc_0.807_fc_1.75`$`01_dds`
    # test$`09_lfc_0.807_fc_1.75`$`02_DGE_unshrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.807_fc_1.75`$`02_DGE_shrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.807_fc_1.75`$`02_DGE_lessAbs_unshrunken_DF` %>% tibble::as_tibble()
    # test$`09_lfc_0.807_fc_1.75`$`03_DGE_unshrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.807_fc_1.75`$`03_DGE_shrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.807_fc_1.75`$`03_DGE_lessAbs_unshrunken_GR` %>% tibble::as_tibble()
    # test$`09_lfc_0.807_fc_1.75`$`04_t_DGE_unshrunken`
    # test$`09_lfc_0.807_fc_1.75`$`04_t_DGE_lessAbs_unshrunken`
    # as.numeric(table(test$`09_lfc_0.807_fc_1.75`$`04_t_DGE_lessAbs_unshrunken`$padj < 0.99)[2])
    # test$`09_lfc_0.807_fc_1.75`$`04_t_DGE_shrunken`
    test$`09_lfc_0.807_fc_1.75`$`08_p_vol_unshrunken_KA`
    # test$`09_lfc_0.807_fc_1.75`$`08_p_vol_shrunken_KA`
    # test$`09_lfc_0.807_fc_1.75`$`08_p_vol_lessAbs_unshrunken_KA`
    # test$`09_lfc_0.807_fc_1.75`$`09_p_MA_unshrunken`
    # test$`09_lfc_0.807_fc_1.75`$`09_p_MA_shrunken`
    # test$`09_lfc_0.807_fc_1.75`$`09_p_MA_lessAbs_unshrunken`
    # test$`09_lfc_0.807_fc_1.75`$`10_hist_unshrunken_p`
    # test$`09_lfc_0.807_fc_1.75`$`10_hist_unshrunken_q`
    # test$`09_lfc_0.807_fc_1.75`$`10_hist_shrunken_s`
    # test$`09_lfc_0.807_fc_1.75`$`10_hist_lessAbs_unshrunken_p`
    # test$`09_lfc_0.807_fc_1.75`$`10_hist_lessAbs_unshrunken_q`
    
    rm(test)
}


run <- FALSE
if(base::isTRUE(run)) {
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_N-Q-nab3d_N-Q-parental`,
        lfc = "lfc-gt-0",
        style = "AG",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-Q-nab3d_SS-Q-parental`,
        lfc = "lfc-gt-0",
        style = "AG",
        type = type
    )
    
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-Q-rrp6∆_SS-Q-WT`,
        lfc = "lfc-gt-0",
        style = "AG",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-G1-rrp6∆_SS-G1-WT`,
        lfc = "lfc-gt-0",
        style = "AG",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_N-Q-rrp6∆_N-Q-WT`,
        lfc = "lfc-gt-0",
        style = "AG",
        type = type
    )
}

run <- TRUE
if(base::isTRUE(run)) {
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_N-Q-nab3d_N-Q-parental`,
        lfc = "lfc-gt-0.58",
        style = "AG",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-Q-nab3d_SS-Q-parental`,
        lfc = "lfc-gt-0.58",
        style = "AG",
        type = type
    )
    
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-Q-rrp6∆_SS-Q-WT`,
        lfc = "lfc-gt-0.58",
        style = "AG",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-G1-rrp6∆_SS-G1-WT`,
        lfc = "lfc-gt-0.58",
        style = "AG",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_N-Q-rrp6∆_N-Q-WT`,
        lfc = "lfc-gt-0.58",
        style = "AG",
        type = type
    )
}

run <- FALSE
if(base::isTRUE(run)) {
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_N-Q-nab3d_N-Q-parental`,
        lfc = "lfc-gt-4",
        style = "KA",
        type = type
    )
    print_volcano_unshrunken(
        dataframe = `DGE-analysis_SS-Q-nab3d_SS-Q-parental`,
        lfc = "lfc-gt-4",
        style = "KA",
        type = type
    )
}

write_rds_files <- TRUE  #ARGUMENT
if(base::isTRUE(write_rds_files)) {
    output_rds(`DGE-analysis_N-Q-nab3d_N-Q-parental`, type)
    output_rds(`DGE-analysis_SS-Q-nab3d_SS-Q-parental`, type)
    
    output_rds(`DGE-analysis_SS-Q-rrp6∆_SS-Q-WT`, type)
    output_rds(`DGE-analysis_SS-G1-rrp6∆_SS-G1-WT`, type)
    output_rds(`DGE-analysis_N-Q-rrp6∆_N-Q-WT`, type)
}


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
