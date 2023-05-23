#!/usr/bin/Rscript

#  rough-draft_timecourse-samples_processing_part-1b.R
#  KA

library(DESeq2)
library(GenomicRanges)
library(limma)
library(PCAtools)
library(rtracklayer)
library(tidyverse)

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions =======================================================
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
        col = c('#D3D3D3', '#D3D3D3', '#D3D3D3', color),
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


call_DESeq2_results_plot_volcano <- function(
    dds,
    independent_filtering =  TRUE,
    threshold_p = 0.05,
    threshold_lfc = 0
) {
    # ...
    # :param dds: ...
    # :return ...: ...
    
    #  Test
    # dds <- dds_DSm2
    # independent_filtering <- TRUE
    # threshold_p <- 0.05
    # threshold_lfc <- 0
    
    #  Initialize a DESeq2 DataFrame object
    DGE_unshrunken_DF <- DESeq2::results(
        dds,
        name = DESeq2::resultsNames(dds)[length(DESeq2::resultsNames(dds))],
        independentFiltering = independent_filtering,
        alpha = threshold_p,
        lfcThreshold = threshold_lfc,
        format = "DataFrame"
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
    DGE_unshrunken_GR$thorough <- ifelse(
        is.na(MatrixGenerics::rowRanges(dds)$names),
        MatrixGenerics::rowRanges(dds)$features,
        MatrixGenerics::rowRanges(dds)$names
    )
    DGE_unshrunken_GR$type <- MatrixGenerics::rowRanges(dds)$type
    DGE_unshrunken_GR$genome <- MatrixGenerics::rowRanges(dds)$genome
    
    #  Coerce GRanges object to tibble
    t_DGE <- DGE_unshrunken_GR %>% dplyr::as_tibble()
    
    
    #  Make a volcano plot ----------------------------------------------------
    all <- t_DGE$thorough
    selection_down <- t_DGE %>%
        dplyr::filter(log2FoldChange < 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection_up <- t_DGE %>%
        dplyr::filter(log2FoldChange > 0) %>%
        dplyr::arrange(padj) %>%
        dplyr::slice(1:5)
    selection <- c(selection_down[["thorough"]], selection_up[["thorough"]]) %>%
            as.character()
    
    sample_info <- colData(dds) %>%
        rownames() %>%
        sort() %>%
        stringr::str_split("_") %>%
        as.data.frame()
    sample_info <- paste(sample_info[1, c(1, 4)], sample_info[2, 1]) %>%
        paste(., collapse = " vs. ")
    
    model_info <- dds@design
    
    title <- paste0("volcano plot")
    subtitle <- paste(
        "points: S. cerevisiae features",
        "| size factors (RLE): K. lactis features",
        "\nsamples:", sample_info,
        "| model: ~", paste(as.character(model_info)[-1], collapse = " + "),
        "\nleft: up in WT",
        "| right: up in rrp6-null"
    )
    p <- plot_volcano(
        table = t_DGE,
        label = all,
        selection = selection,
        label_size = 2.5,
        p_cutoff = 0.05,
        FC_cutoff = 1,
        xlim = c(-14, 14),
        ylim = c(0, 310),
        color = "#A020F0",  #ARGUMENT
        title = title,
        subtitle = subtitle
    )
    p
    
    results_list <- list()
    results_list[["01_dds"]] <- dds
    results_list[["02_DGE_unshrunken_DF"]] <- DGE_unshrunken_DF
    results_list[["03_DGE_unshrunken_GR"]] <- DGE_unshrunken_GR
    results_list[["04_t_DGE"]] <- t_DGE
    results_list[["05_all"]] <- all
    results_list[["06_selection_down"]] <- selection_down
    results_list[["07_selection_up"]] <- selection_up
    results_list[["08_selection"]] <- selection
    results_list[["09_sample_info"]] <- sample_info
    results_list[["10_title"]] <- title
    results_list[["11_subtitle"]] <- subtitle
    results_list[["11_p"]] <- p
    
    return(results_list)
}


get_name_of_var <- function(v) {
    #TODO Write a description of this function
    #
    # :param v: ...
    # :return v: ...
    return(deparse(substitute(v)))
}
#TODO Add return description


get_top_loadings <- function(x, y, z, a) {
    #TODO Write a description of this function
    #
    # :param x: dataframe of PC loadings <data.frame>
    # :param y: character element for column in dataframe x <chr>
    # :param z: whether to select all loadings sorted from largest to smallest
    #           absolute value ('all'), positive loadings sorted from largest
    #           to smallest value ('pos'), or negative loadings sorted from
    #           largest to smallest absolute value ('neg') <str>
    # :param a: whether or not to keep 'sign' and 'abs' columns added in the
    #           course of processing the dataframe <logical>
    # :return b: ...
    b <- as.data.frame(x[[y]])
    rownames(b) <- rownames(x)
    colnames(b) <- y
    
    b[["sign"]] <- ifelse(
        b[[y]] > 0,
        "pos",
        ifelse(
            b[[y]] == 0,
            "zero",
            "neg"
        )
    )
    
    b[["abs"]] <- abs(b[[y]])
    
    if(z == "all") {
        b <- dplyr::arrange(b, by = desc(abs))
    } else if(z == "pos") {
        b <- b[b[[y]] > 0, ] %>% dplyr::arrange(., by = desc(abs))
    } else if(z == "neg") {
        b <- b[b[[y]] < 0, ] %>% dplyr::arrange(., by = desc(abs))
    } else {
        stop(paste0("Stopping: param z must be either 'all', 'pos', or 'neg'"))
    }
    
    if(isTRUE(a)) {
        paste0("Retaining 'sign' and 'abs' columns")
    } else if(isFALSE(a)) {
        b <- b %>% dplyr::select(-c(sign, abs))
    } else {
        stop(paste0("Stopping: param a must be either 'TRUE' or 'FALSE'"))
    }
    
    return(b)
}
#TODO Add return description


plot_biplot <- function(
    pca, PC_x, PC_y,
    loadings_show, loadings_n,
    meta_color, meta_shape,
    x_min, x_max, y_min, y_max
) {
    #TODO Write a description of this function
    #
    # :param pca: "pca" list object obtained by running PCAtools::pca()
    # :param PC_x: PC to plot on the x axis <chr>
    # :param PC_y: PC to plot on the y axis <chr>
    # :param loadings_show: whether to overlay component loadings or not <lgl>
    # :param loadings_n: number of top loadings to show <int >= 0>
    # :param meta_color: column in "pca" list metadata to color by <chr>
    # :param meta_shape: column in "pca" list metadata to shape by <chr>
    # :param x_min: minimum value on x axis <dbl>
    # :param x_max: maximum value on x axis <dbl>
    # :param y_min: minimum value on y axis <dbl>
    # :param y_max: maximum value on y axis <dbl>
    # :param title: title of biplot <dbl>
    # :return image: ...
    image <- pca %>% 
        PCAtools::biplot(
            x = PC_x,
            y = PC_y,
            lab = NULL,
            showLoadings = loadings_show,
            ntopLoadings = loadings_n,
            boxedLoadingsNames = TRUE,
            colby = meta_color,
            shape = meta_shape,
            encircle = FALSE,
            ellipse = FALSE,
            max.overlaps = Inf,
            xlim = c(x_min, x_max),
            ylim = c(y_min, y_max)
        ) +
            # theme_slick
            theme_bw() +
            theme(
                aspect.ratio = 1,
                panel.grid.minor = element_line(size = 0.5),
                panel.grid.major = element_line(size = 1),
                axis.text = element_text(size = 20, face = "bold", color="black"),
                axis.title = element_text(size =25, face = "bold")
            ) # +
            # coord_obs_pred()
    
    return(image)
}
#TODO Add return description


plot_pos_neg_loadings_each_axis <- function(
    df_all, df_pos, df_neg,
    PC_x, PC_y,
    row_start, row_end,
    x_min, x_max, y_min, y_max,
    x_nudge, y_nudge, x_label, y_label,
    col_line_pos, col_line_neg, col_seg_pos, col_seg_neg
) {
    #TODO Write a description of this function
    #
    # :param df_all: dataframe: all loadings (from, e.g., PCAtools)
    # :param df_pos: dataframe: positive loadings ordered largest to smallest
    # :param df_neg: dataframe: negative loadings ordered smallest to largest
    # :param PC_x: PC to plot on the x axis
    # :param PC_y: PC to plot on the y axis
    # :param row_start: row from which to begin subsetting the PCs on x and y
    # :param row_end: row at which to end subsetting the PCs on x and y
    # :param x_min: minimum value on x axis <dbl>
    # :param x_max: maximum value on x axis <dbl>
    # :param y_min: minimum value on y axis <dbl>
    # :param y_max: maximum value on y axis <dbl>
    # :param x_nudge: amount to nudge labels on the x axis <dbl>
    # :param y_nudge: amount to nudge labels on the y axis <dbl>
    # :param x_label: x axis label <chr>
    # :param y_label: y axis label <chr>
    # :param col_line_pos: color: lines, arrows for positive loadings <chr>
    # :param col_line_neg: color: lines, arrows for negative loadings <chr>
    # :param col_seg_pos: color: segments connecting arrowhead and text bubble
    #                     for positive loadings <chr>
    # :param col_seg_neg: color: segments connecting arrowhead and text bubble
    #                     for negative loadings <chr>
    # :return image: ...
    filter_pos_1 <- rownames(df_pos[[PC_x]][row_start:row_end, ])
    filter_pos_2 <- rownames(df_pos[[PC_y]][row_start:row_end, ])
    filter_neg_1 <- rownames(df_neg[[PC_x]][row_start:row_end, ])
    filter_neg_2 <- rownames(df_neg[[PC_y]][row_start:row_end, ])
    
    loadings_filter_pos_1 <- df_all[rownames(df_all) %in% filter_pos_1, ]
    loadings_filter_pos_2 <- df_all[rownames(df_all) %in% filter_pos_2, ]
    loadings_filter_neg_1 <- df_all[rownames(df_all) %in% filter_neg_1, ]
    loadings_filter_neg_2 <- df_all[rownames(df_all) %in% filter_neg_2, ]
    
    images <- list()
    images[["PC_x_pos"]] <- plot_loadings(
        loadings_filter_pos_1,
        loadings_filter_pos_1[[PC_x]],
        loadings_filter_pos_1[[PC_y]],
        x_min, x_max, y_min, y_max, x_nudge, y_nudge,
        x_label, y_label, col_line_pos, col_seg_pos
    )
    images[["PC_y_pos"]] <- plot_loadings(
        loadings_filter_pos_2,
        loadings_filter_pos_2[[PC_x]],
        loadings_filter_pos_2[[PC_y]],
        x_min, x_max, y_min, y_max, x_nudge, y_nudge,
        x_label, y_label, col_line_pos, col_seg_pos
    )
    images[["PC_x_neg"]] <- plot_loadings(
        loadings_filter_neg_1,
        loadings_filter_neg_1[[PC_x]],
        loadings_filter_neg_1[[PC_y]],
        x_min, x_max, y_min, y_max, -y_nudge, x_nudge,
        x_label, y_label, col_line_neg, col_seg_neg
    )
    images[["PC_y_neg"]] <- plot_loadings(
        loadings_filter_neg_2,
        loadings_filter_neg_2[[PC_x]],
        loadings_filter_neg_2[[PC_y]],
        x_min, x_max, y_min, y_max, x_nudge, -y_nudge,
        x_label, y_label, col_line_neg, col_seg_neg
    )
    return(images)
}
#TODO Add return description


plot_loadings <- function(x, y, z, a, b, d, e, f, g, h, i, j, k) {
    #TODO Write a description of this function
    #
    # :param x: dataframe of PC loadings w/gene names as rownames <data.frame>
    # :param y: column in dataframe to plot on x axis <dbl>
    # :param z: column in dataframe to plot on y axis <dbl>
    # :param a: minimum value on x axis <dbl>
    # :param b: maximum value on x axis <dbl>
    # :param d: minimum value on y axis <dbl>
    # :param e: maximum value on y axis <dbl>
    # :param f: amount to nudge labels on the x axis <dbl>
    # :param g: amount to nudge labels on the y axis <dbl>
    # :param h: x axis label <chr>
    # :param i: y axis label <chr>
    # :param j: color of line and arrow <chr>
    # :param k: color of segment connecting arrowhead and text bubble <chr>
    # :return l: ...
    l <- ggplot2::ggplot(x, ggplot2::aes(x = y, y = z)) +  #TODO #FUNCTION
        ggplot2::coord_cartesian(xlim = c(a, b), ylim = c(d, e)) +
        ggplot2::geom_segment(
            aes(xend = 0, yend = 0, alpha = 0.5),
            color = j, 
            arrow = ggplot2::arrow(
                ends = "first",
                type = "open",
                length = unit(0.125, "inches")
            )
        ) +
        ggrepel::geom_label_repel(
            mapping = ggplot2::aes(
                fontface = 1, segment.color = k, segment.size = 0.25
            ),
            label = rownames(x),
            label.size = 0.05,
            direction = "both",
            nudge_x = f,  # 0.02
            nudge_y = g,  # 0.04
            force = 4,
            force_pull = 1,
            hjust = 0
        ) +
        ggplot2::xlab(h) +
        ggplot2::ylab(i) +
        theme_slick_no_legend
    
    return(l)
}
#TODO Add return description


draw_scree_plot <- function(pca, horn, elbow) {
    #TODO Write a description of this function
    #
    # :param pca: "pca" list object obtained by running PCAtools::pca()
    # :param horn: ...
    # :param elbow: ...
    # :return scree: ...
    scree <- PCAtools::screeplot(
        pca,
        components = PCAtools::getComponents(pca),
        vline = c(horn, elbow),
        vlineWidth = 0.25,
        sizeCumulativeSumLine = 0.5,
        sizeCumulativeSumPoints = 1.5
    ) +
        geom_text(aes(horn + 1, 50, label = "Horn's", vjust = 2)) +
        geom_text(aes(elbow + 1, 50, label = "Elbow", vjust = -2)) +
        theme_slick +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

    return(scree)
}


run_PCA_pipeline <- function(
        counts, metadata, gene_id, transformed, transcription, meta_color,
        meta_shape
) {
    # ...
    # :param counts: ... <data.frame>
    # :param metadata: ... <data.frame>
    # :param gene_id: ... <character vector>
    # :param transformed: FALSE for raw counts, TRUE for rlog counts <logical>
    # :param transcription: TRUE if variable transcription is in model matrix <logical>
    # :param meta_color: ... <character>
    # :param meta_shape: ... <character>
    # :return results_list: ... <list>
    #  Checks arguments
    stopifnot(is.data.frame(counts))
    stopifnot(is.data.frame(metadata))
    stopifnot(isTRUE(tibble::has_rownames(metadata)))
    stopifnot(is.character(gene_id))
    stopifnot(is.logical(transformed))
    stopifnot(is.logical(transcription))

    #  Create a PCAtools "pca" S4 object
    pca <- PCAtools::pca(counts, metadata = metadata)
    rownames(pca$loadings) <- gene_id
    
    #  Determine "significant" PCs with Horn's parallel analysis (see
    #+ Horn, 1965)
    horn <- PCAtools::parallelPCA(counts[, 2:ncol(counts)])
    
    #  Determine "significant" principle components with the elbow
    #+ method (see Buja and Eyuboglu, 1992)
    elbow <- PCAtools::findElbowPoint(pca$variance)
    
    #  Evaluate cumulative proportion of explained variance with a
    #+ scree plot
    p_scree <- draw_scree_plot(pca, horn = horn$n, elbow = elbow)
    
    #  Save component loading vectors in their own dataframe
    loadings <- as.data.frame(pca$loadings)
    
    #  Evaluate the component loading vectors for the number of
    #+ "significant" PCs identified via the elbow method plus two
    PCs <- paste0("PC", 1:(as.numeric(elbow) + 2))
    top_loadings_all <- lapply(
        PCs, get_top_loadings, x = loadings, z = "all", a = TRUE
    )
    top_loadings_pos <- lapply(
        PCs, get_top_loadings, x = loadings, z = "pos", a = TRUE
    )
    top_loadings_neg <- lapply(
        PCs, get_top_loadings, x = loadings, z = "neg", a = TRUE
    )
    names(top_loadings_all) <-
        names(top_loadings_pos) <-
        names(top_loadings_neg) <-
        PCs
    
    #  Evaluate positive and negative loadings on axes of biplots; look at the
    #+ top 15 per axis
    p_images <- list()
    mat <- combn(PCs, 2)
    for(l in 1:ncol(mat)) {
        # l <- 1
        m<- mat[, l]
        
        PC_x <- x_label <- m[1]
        PC_y <- y_label <- m[2]
        
        if(isFALSE(transformed)) {
            x_min_biplot <- -350000
            x_max_biplot <- 350000
            y_min_biplot <- -350000
            y_max_biplot <- 350000
            x_min_loadings_plot <- -0.5
            x_max_loadings_plot <- 0.5
            y_min_loadings_plot <- -0.5
            y_max_loadings_plot <- 0.5
        } else if(isTRUE(transformed)) {
            x_min_biplot <- -150  # -75  # -100  # -200  #ARGUMENT?
            x_max_biplot <- 150  # 75  # 100  # 200  #ARGUMENT?
            y_min_biplot <- -150  # -75  # -100  # -200  #ARGUMENT?
            y_max_biplot <- 150  # 75  # 100  # 200  #ARGUMENT?
            x_min_loadings_plot <- -0.1
            x_max_loadings_plot <- 0.1
            y_min_loadings_plot <- -0.1
            y_max_loadings_plot <- 0.1
        }
        
        p_images[[paste0("PCAtools.", PC_x, ".v.", PC_y)]] <-
            plot_biplot(
                pca = pca,
                PC_x = PC_x,
                PC_y = PC_y,
                loadings_show = FALSE,
                loadings_n = 0,
                meta_color = meta_color,  #DONE
                meta_shape = meta_shape,  #DONE
                x_min = x_min_biplot,
                x_max = x_max_biplot,
                y_min = y_min_biplot,
                y_max = y_max_biplot
            )
        
        p_images[[paste0("KA.", PC_x, ".v.", PC_y)]] <-
            plot_pos_neg_loadings_each_axis(
                df_all = loadings,
                df_pos = top_loadings_pos,
                df_neg = top_loadings_neg,
                PC_x = PC_x,
                PC_y = PC_y,
                row_start = 1,
                row_end = 15,  # 30
                x_min = x_min_loadings_plot,
                x_max = x_max_loadings_plot,
                y_min = y_min_loadings_plot,
                y_max = y_max_loadings_plot,
                x_nudge = 0.02,  # 0.02,  # 0.04,
                y_nudge = 0.04,  # 0.04,  # 0.02,
                x_label = x_label,
                y_label = y_label,
                col_line_pos = "#229E37",
                col_line_neg = "#113275",
                col_seg_pos = "grey",
                col_seg_neg = "grey"
            )
        
        p_images[[paste0("KA.", PC_x, ".v.", PC_y)]]
    }
    
    
    #  Plot the top features on an axis of "component loading range" to
    #+ visualize the top variables (features) that drive variance among
    #+ PCs of interest
    p_loadings <- PCAtools::plotloadings(
        pca,
        components = PCAtools::getComponents(
            pca, 1:length(PCs)
        ),
        rangeRetain = 0.025,
        absolute = FALSE,
        col = c("#167C2875", "#FFFFFF75", "#7835AC75"),
        title = "Loadings plot",
        subtitle = "Top 2.5% of variables (i.e., features)",
        borderColour = "#000000",
        borderWidth = 0.2,
        gridlines.major = TRUE,
        gridlines.minor = TRUE,
        axisLabSize = 10,
        labSize = 3,  # label_size
        drawConnectors = TRUE,
        widthConnectors = 0.2,
        typeConnectors = "closed",
        colConnectors = "black"
    ) +
        # ggplot2::coord_flip() +
        # theme_slick_no_legend
        theme_bw() +
        theme(
            aspect.ratio = 1,
            panel.grid.minor = element_line(size = 0.5),
            panel.grid.major = element_line(size = 1),
            axis.text = element_text(
                size = 20, face = "bold", color = "black"
            ),
            axis.title = element_text(size = 25, face = "bold")
        ) # +
        # coord_obs_pred()
    p_loadings
    #TODO Work up some logic for saving the plot
    
    
    #  Evaluate correlations between PCs and model variables; answer
    #+ the question, "What is driving biologically significant variance
    #+ in our data?"
    p_cor <- PCAtools::eigencorplot(
        pca,
        components = PCAtools::getComponents(pca, 1:4),  #ARGUMENT
        metavars = if(transcription == FALSE) {
            c("genotype", "time", "intermediate", "replicate", "technical")
        } else if(transcription == TRUE) {
            c(
                "genotype", "time", "intermediate", "transcription",
                "replicate", "technical"
            )
        },  #ARGUMENT
        # col = viridisLite::viridis(n = 100) %>% rev(),
        col = c("#FFFFFF", "#7835AC"),
        scale = FALSE,
        corFUN = "pearson",
        corMultipleTestCorrection = "BH",
        plotRsquared = TRUE,
        colFrame = "#FFFFFF",
        main = bquote(Pearson ~ r^2 ~ correlates),
        fontMain = 1,
        titleX = "Principal components",
        fontTitleX = 1,
        fontLabX = 1,
        titleY = "Model variables",
        rotTitleY = 90,
        fontTitleY = 1,
        fontLabY = 1
    )
    p_cor
    
    results_list <- list()
    results_list[["01_pca"]] <- pca
    results_list[["02_horn"]]<- horn
    results_list[["03_elbow"]]<- elbow
    results_list[["04_p_scree"]]<- p_scree
    results_list[["05_loadings"]]<- loadings
    results_list[["06_PCs"]]<- PCs
    results_list[["07_top_loadings_all"]]<- top_loadings_all
    results_list[["08_top_loadings_pos"]]<- top_loadings_pos
    results_list[["09_top_loadings_neg"]]<- top_loadings_neg
    results_list[["10_p_images"]]<- p_images
    results_list[["11_p_loadings"]]<- p_loadings
    results_list[["12_p_cor"]]<- p_cor
    
    return(results_list)
}


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
getwd()

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
    readxl::read_xlsx()  #FIXME Replicate information is currently incorrect


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

#  Convert column names from list to character vector, and replace empty fields
#+ with NA character values
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

#  Remove unneeded variables again
rm(chr_20S, chr_KL, chr_SC, chr_order)


#  Subset t_mat for timecourse counts data ------------------------------------
t_tc <- dplyr::bind_cols(
    t_mat[, 1:11],
    t_mat[,
        stringr::str_detect(colnames(t_mat), "tc-T") &
        !stringr::str_detect(colnames(t_mat), "t4")
    ]
) 

#  Exclude 20S and htseq-count "summary values" from timecourse tibble
t_tc <- t_tc %>% dplyr::slice(1:(n() - 6))
# tail(t_tc, 10)

#  Explicitly rename the sample columns (give them straightforward names);
#+ later, we can use these name to populate a metadata matrix
better_sample_names <- c(
    "WT_DSm2_rep1_tech1",
    "WT_DSm2_rep2_tech1",
    "WT_DSp2_rep1_tech1",
    "WT_DSp2_rep2_tech1",
    "WT_DSp24_rep1_tech1",
    "WT_DSp24_rep2_tech1",
    "WT_DSp48_rep1_tech1",
    "WT_DSp48_rep1_tech2",
    "WT_DSp48_rep2_tech1",
    "r6n_DSm2_rep1_tech1",
    "r6n_DSm2_rep2_tech1",
    "r6n_DSp2_rep1_tech1",
    "r6n_DSp2_rep2_tech1",
    "r6n_DSp24_rep1_tech1",
    "r6n_DSp24_rep2_tech1",
    "r6n_DSp48_rep1_tech1",
    "r6n_DSp48_rep2_tech2"  # Previously, incorrectly labeled as "r6n_DSp48_rep2_tech1"
)

colnames(t_tc)[12:ncol(t_tc)] <- better_sample_names
rm(better_sample_names)

#  Names were derived from the following:
# c(
#     "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
#     "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
#     "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
#     "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"
# )


#  Make a dds object from t_tc ------------------------------------------------
#  Make a metadata matrix for DESeq2, etc.
t_meta <- colnames(t_tc)[12:ncol(t_tc)] %>%
    stringr::str_split("_") %>%
    as.data.frame() %>%
    t() %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    dplyr::rename(
        genotype = ...1, time = ...2, replicate = ...3, technical = ...4
    ) %>%
    dplyr::mutate(rownames = colnames(t_tc)[12:ncol(t_tc)]) %>%
    tibble::column_to_rownames("rownames") %>%  # DESeq2 requires rownames
    dplyr::mutate(
        genotype = factor(genotype, level = c("WT", "r6n")),
        no_genotype = sapply(
            as.character(genotype),
            switch,
            "WT" = 0,
            "r6n" = 1,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        time = factor(time, levels = c("DSm2", "DSp2", "DSp24", "DSp48")),
        no_time = sapply(
            as.character(time),
            switch,
            "DSm2" = 0,
            "DSp2" = 1,
            "DSp24" = 2,
            "DSp48" = 3,
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
            as.factor(),
        intermediate = ifelse(
            stringr::str_detect(rownames(.), "DSp2|DSp24"),
            "yes",
            "no"
        ) %>%
            as.factor(),
        no_intermediate = sapply(
            as.character(intermediate),
            switch,
            "yes" = 0,
            "no" = 1,
            USE.NAMES = FALSE
        ) %>%
            as.factor()
    ) %>%
    dplyr::relocate(intermediate, .after = technical)


#  Filter t_tc to remove features with low counts across samples --------------
# t_tc.bak <- t_tc
# t_tc <- t_tc.bak

filtering <- "none"
# filtering <- "filterByExpr.default"
# filtering <- "min-10-cts-3-samps"
# filtering <- "min-10-cts-all-but-1-samps"
# filtering <- "min-10-cts-all-samps"

if(filtering == "none"){
    #  Do nothing
} else if(filtering == "min-10-cts-3-samps") {
    counts <- sapply(t_tc[, 12:ncol(t_tc)], as.numeric)
    keep <- rowSums(counts >= 10) >= 3
    t_tc <- t_tc[keep, ]  # 10749
} else if(filtering == "min-10-cts-all-but-1-samps") {
    counts <- sapply(t_tc[, 12:ncol(t_tc)], as.numeric)
    keep <- rowSums(counts >= 10) >= length(12:ncol(t_tc)) - 1
    t_tc <- t_tc[keep, ]  # 9376
} else if(filtering == "min-10-cts-all-samps") {
    counts <- sapply(t_tc[, 12:ncol(t_tc)], as.numeric)
    keep <- rowSums(counts >= 10) >= length(12:ncol(t_tc))
    t_tc <- t_tc[keep, ]  # 8995
} else if(filtering == "filterByExpr.default") {
    # `S-cerevisiae_only` <- TRUE
    `S-cerevisiae_only` <- FALSE
    
    if(base::isTRUE(`S-cerevisiae_only`)) {
        t_edge <- t_tc[t_tc$genome == "S_cerevisiae", 12:ncol(t_tc)] %>%
            as.data.frame()
        t_edge <- sapply(t_edge, as.numeric)
        rownames(t_edge) <- t_tc[t_tc$genome == "S_cerevisiae", ]$features
        
        group <- t_meta$genotype
        eds <- edgeR::DGEList(
            t_edge,
            group = group,
            genes = t_tc[t_tc$genome == "S_cerevisiae", 1:11]
        )
    
        design <- model.matrix(~ 0 + group)
        colnames(design) <- levels(group)
        
        keep <- edgeR::filterByExpr.default(eds, design)
        table(keep)
        
        dispose <- dplyr::bind_cols(eds[!keep, ]$genes, eds[!keep, ]$counts)
        
        #  Remove low-counts features from t_tc
        t_tmp <- t_tc[t_tc$genome == "S_cerevisiae", ]
        t_tc <- t_tmp[keep, ]  # 5793
        
        #  Clean up variables
        rm(t_edge, group, eds, design, t_tmp)
        
        # dispose[dispose$genome == "S_cerevisiae", ] %>% nrow()
        # dispose[dispose$genome == "K_lactis", ] %>% nrow()
    } else {
        t_edge <- t_tc[, 12:ncol(t_tc)] %>%
            as.data.frame()
        t_edge <- sapply(t_edge, as.numeric)
        rownames(t_edge) <- t_tc[, ]$features
        
        group <- t_meta$genotype
        eds <- edgeR::DGEList(
            t_edge,
            group = group,
            genes = t_tc[, 1:11]
        )
    
        design <- model.matrix(~ 0 + group)
        colnames(design) <- levels(group)
        
        keep <- edgeR::filterByExpr.default(eds, design)
        table(keep)
        
        dispose <- dplyr::bind_cols(eds[!keep, ]$genes, eds[!keep, ]$counts)
        
        #  Remove low-counts features from t_tc
        t_tc <- t_tc[keep, ]  # 10410

        #  Clean up variables
        rm(t_edge, group, eds, design)
        
        # dispose[dispose$genome == "S_cerevisiae", ] %>% nrow()
        # dispose[dispose$genome == "K_lactis", ] %>% nrow()
    }

    rm(keep)
}

#  Make a GRanges object for positional information for DESeq2, etc.
g_pos <- GenomicRanges::GRanges(
    seqnames = t_tc$chr,
    ranges = IRanges::IRanges(t_tc$start, t_tc$end),
    strand = t_tc$strand,
    length = t_tc$width,
    type = t_tc$type,
    features = t_tc$features,
    biotype = t_tc$biotype,
    names = t_tc$names,
    genome = t_tc$genome
)
g_pos

#  Make a counts matrix for DESeq2, etc.
t_counts <- t_tc[, 12:ncol(t_tc)] %>%
    sapply(., as.integer) %>%
    as.data.frame()

#  Make the dds object; however, don't do any modeling yet
dds <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts,
    colData = t_meta,
    # design = ~1,
    design = ~ technical + genotype,
    rowRanges = g_pos
)
# dds@design

#  Do size-factor estimation using K. lactis control genes
dds <- BiocGenerics::estimateSizeFactors(
    # dds[dds@rowRanges$genome == "K_lactis", ]
    dds,
    controlGenes = (dds@rowRanges$genome == "K_lactis")
)
dds$sizeFactor %>% as.data.frame()
#  Compare to size factors *without* counts matrix pre-filtering 
# WT_DSm2_rep1_tech1   0.5682074
# WT_DSm2_rep2_tech1   0.4368905
# WT_DSp2_rep1_tech1   0.8104658
# WT_DSp2_rep2_tech1   0.8467238
# WT_DSp24_rep1_tech1  1.2374142
# WT_DSp24_rep2_tech1  1.2660357
# WT_DSp48_rep1_tech1  1.6936618
# WT_DSp48_rep1_tech2  1.7414215
# WT_DSp48_rep2_tech1  1.2492546
# r6n_DSm2_rep1_tech1  0.6313840
# r6n_DSm2_rep2_tech1  0.7714148
# r6n_DSp2_rep1_tech1  0.9944856
# r6n_DSp2_rep2_tech1  1.0158238
# r6n_DSp24_rep1_tech1 0.8680379
# r6n_DSp24_rep2_tech1 1.2141282
# r6n_DSp48_rep1_tech1 1.4169173
# r6n_DSp48_rep2_tech2 1.4839146

#  Size factors *with* counts matrix pre-filtering: Retain rows using the
#+ function edgeR::filterByExpr() with defaults settings
# WT_DSm2_rep1_tech1   0.5680170
# WT_DSm2_rep2_tech1   0.4363303
# WT_DSp2_rep1_tech1   0.8104599
# WT_DSp2_rep2_tech1   0.8464229
# WT_DSp24_rep1_tech1  1.2373439
# WT_DSp24_rep2_tech1  1.2660064
# WT_DSp48_rep1_tech1  1.6923965
# WT_DSp48_rep1_tech2  1.7414043
# WT_DSp48_rep2_tech1  1.2485457
# r6n_DSm2_rep1_tech1  0.6312976
# r6n_DSm2_rep2_tech1  0.7711372
# r6n_DSp2_rep1_tech1  0.9948248
# r6n_DSp2_rep2_tech1  1.0155787
# r6n_DSp24_rep1_tech1 0.8679065
# r6n_DSp24_rep2_tech1 1.2140250
# r6n_DSp48_rep1_tech1 1.4172227
# r6n_DSp48_rep2_tech2 1.4831554

#  Size factors *with* counts matrix pre-filtering: Retain rows in which at
#+ least three columns have a minimum of 10 counts
# WT_DSm2_rep1_tech1   0.5681531
# WT_DSm2_rep2_tech1   0.4366657
# WT_DSp2_rep1_tech1   0.8103852
# WT_DSp2_rep2_tech1   0.8466872
# WT_DSp24_rep1_tech1  1.2370772
# WT_DSp24_rep2_tech1  1.2660838
# WT_DSp48_rep1_tech1  1.6933694
# WT_DSp48_rep1_tech2  1.7419921
# WT_DSp48_rep2_tech1  1.2485825
# r6n_DSm2_rep1_tech1  0.6313985
# r6n_DSm2_rep2_tech1  0.7710638
# r6n_DSp2_rep1_tech1  0.9943727
# r6n_DSp2_rep2_tech1  1.0157794
# r6n_DSp24_rep1_tech1 0.8679175
# r6n_DSp24_rep2_tech1 1.2140612
# r6n_DSp48_rep1_tech1 1.4171700
# r6n_DSp48_rep2_tech2 1.4837329

#  Size factors *with* counts matrix pre-filtering: Retain rows in which at
#+ all but one of the columns (i.e., 16 of the 17 samples) have a minimum of 10
#+ counts
# WT_DSm2_rep1_tech1   0.5681895
# WT_DSm2_rep2_tech1   0.4358439
# WT_DSp2_rep1_tech1   0.8104599
# WT_DSp2_rep2_tech1   0.8458113
# WT_DSp24_rep1_tech1  1.2364644
# WT_DSp24_rep2_tech1  1.2652656
# WT_DSp48_rep1_tech1  1.6906770
# WT_DSp48_rep1_tech2  1.7364036
# WT_DSp48_rep2_tech1  1.2489903
# r6n_DSm2_rep1_tech1  0.6318586
# r6n_DSm2_rep2_tech1  0.7698361
# r6n_DSp2_rep1_tech1  0.9942766
# r6n_DSp2_rep2_tech1  1.0132396
# r6n_DSp24_rep1_tech1 0.8668341
# r6n_DSp24_rep2_tech1 1.2127578
# r6n_DSp48_rep1_tech1 1.4179183
# r6n_DSp48_rep2_tech2 1.4802340

#  Size factors *with* counts matrix pre-filtering: Retain rows in which at
#+ all the columns (i.e., all 17 samples) have a minimum of 10 counts
# WT_DSm2_rep1_tech1   0.5680183
# WT_DSm2_rep2_tech1   0.4383606
# WT_DSp2_rep1_tech1   0.8100495
# WT_DSp2_rep2_tech1   0.8456382
# WT_DSp24_rep1_tech1  1.2365164
# WT_DSp24_rep2_tech1  1.2642085
# WT_DSp48_rep1_tech1  1.6899930
# WT_DSp48_rep1_tech2  1.7350479
# WT_DSp48_rep2_tech1  1.2490908
# r6n_DSm2_rep1_tech1  0.6313643
# r6n_DSm2_rep2_tech1  0.7682162
# r6n_DSp2_rep1_tech1  0.9938231
# r6n_DSp2_rep2_tech1  1.0119526
# r6n_DSp24_rep1_tech1 0.8661957
# r6n_DSp24_rep2_tech1 1.2112014
# r6n_DSp48_rep1_tech1 1.4175975
# r6n_DSp48_rep2_tech2 1.4763992

(1 / dds$sizeFactor) %>% as.data.frame()
#  Size factor reciprocals for counts that *were not* pre-filtered
# WT_DSm2_rep1_tech1   1.7599208
# WT_DSm2_rep2_tech1   2.2889032
# WT_DSp2_rep1_tech1   1.2338584
# WT_DSp2_rep2_tech1   1.1810227
# WT_DSp24_rep1_tech1  0.8081369
# WT_DSp24_rep2_tech1  0.7898672
# WT_DSp48_rep1_tech1  0.5904367
# WT_DSp48_rep1_tech2  0.5742435
# WT_DSp48_rep2_tech1  0.8004773
# r6n_DSm2_rep1_tech1  1.5838222
# r6n_DSm2_rep2_tech1  1.2963194
# r6n_DSp2_rep1_tech1  1.0055450
# r6n_DSp2_rep2_tech1  0.9844227
# r6n_DSp24_rep1_tech1 1.1520234
# r6n_DSp24_rep2_tech1 0.8236362
# r6n_DSp48_rep1_tech1 0.7057575
# r6n_DSp48_rep2_tech2 0.6738932

#  Size factor reciprocals for counts that *were* pre-filtered to retain rows
#+ using edgeR::filterByExpr() with defaults settings
# WT_DSm2_rep1_tech1   1.7605108
# WT_DSm2_rep2_tech1   2.2918420
# WT_DSp2_rep1_tech1   1.2338673
# WT_DSp2_rep2_tech1   1.1814425
# WT_DSp24_rep1_tech1  0.8081827
# WT_DSp24_rep2_tech1  0.7898854
# WT_DSp48_rep1_tech1  0.5908781
# WT_DSp48_rep1_tech2  0.5742492
# WT_DSp48_rep2_tech1  0.8009318
# r6n_DSm2_rep1_tech1  1.5840390
# r6n_DSm2_rep2_tech1  1.2967861
# r6n_DSp2_rep1_tech1  1.0052021
# r6n_DSp2_rep2_tech1  0.9846603
# r6n_DSp24_rep1_tech1 1.1521979
# r6n_DSp24_rep2_tech1 0.8237063
# r6n_DSp48_rep1_tech1 0.7056054
# r6n_DSp48_rep2_tech2 0.6742382

#  Size factor reciprocals for counts that *were* pre-filtered to retain rows
#+ in which at least three columns have a minimum of 10 counts
# WT_DSm2_rep1_tech1   1.7600890
# WT_DSm2_rep2_tech1   2.2900814
# WT_DSp2_rep1_tech1   1.2339810
# WT_DSp2_rep2_tech1   1.1810737
# WT_DSp24_rep1_tech1  0.8083570
# WT_DSp24_rep2_tech1  0.7898371
# WT_DSp48_rep1_tech1  0.5905386
# WT_DSp48_rep1_tech2  0.5740554
# WT_DSp48_rep2_tech1  0.8009082
# r6n_DSm2_rep1_tech1  1.5837857
# r6n_DSm2_rep2_tech1  1.2969095
# r6n_DSp2_rep1_tech1  1.0056591
# r6n_DSp2_rep2_tech1  0.9844657
# r6n_DSp24_rep1_tech1 1.1521832
# r6n_DSp24_rep2_tech1 0.8236817
# r6n_DSp48_rep1_tech1 0.7056316
# r6n_DSp48_rep2_tech2 0.6739758

#  Size factor reciprocals for counts that *were* pre-filtered to retain rows
#+ in which at least all but one of the columns have a minimum of 10 counts
#+ (i.e., 16 of the 17 samples have a minimum of 10 counts)
# WT_DSm2_rep1_tech1   1.7599762
# WT_DSm2_rep2_tech1   2.2943996
# WT_DSp2_rep1_tech1   1.2338673
# WT_DSp2_rep2_tech1   1.1822969
# WT_DSp24_rep1_tech1  0.8087576
# WT_DSp24_rep2_tech1  0.7903479
# WT_DSp48_rep1_tech1  0.5914790
# WT_DSp48_rep1_tech2  0.5759030
# WT_DSp48_rep2_tech1  0.8006467
# r6n_DSm2_rep1_tech1  1.5826326
# r6n_DSm2_rep2_tech1  1.2989779
# r6n_DSp2_rep1_tech1  1.0057563
# r6n_DSp2_rep2_tech1  0.9869334
# r6n_DSp24_rep1_tech1 1.1536233
# r6n_DSp24_rep2_tech1 0.8245670
# r6n_DSp48_rep1_tech1 0.7052593
# r6n_DSp48_rep2_tech2 0.6755688

#  Size factor reciprocals for counts that *were* pre-filtered to retain rows
#+ in which at least all of the columns have a minimum of 10 counts (i.e., all
#+ of the 17 samples have a minimum of 10 counts)
# WT_DSm2_rep1_tech1   1.7605068
# WT_DSm2_rep2_tech1   2.2812267
# WT_DSp2_rep1_tech1   1.2344924
# WT_DSp2_rep2_tech1   1.1825389
# WT_DSp24_rep1_tech1  0.8087236
# WT_DSp24_rep2_tech1  0.7910087
# WT_DSp48_rep1_tech1  0.5917184
# WT_DSp48_rep1_tech2  0.5763530
# WT_DSp48_rep2_tech1  0.8005823
# r6n_DSm2_rep1_tech1  1.5838716
# r6n_DSm2_rep2_tech1  1.3017168
# r6n_DSp2_rep1_tech1  1.0062153
# r6n_DSp2_rep2_tech1  0.9881886
# r6n_DSp24_rep1_tech1 1.1544735
# r6n_DSp24_rep2_tech1 0.8256266
# r6n_DSp48_rep1_tech1 0.7054189
# r6n_DSp48_rep2_tech2 0.6773236


#  Run pairwise DGE analyses by timepoint (min-10-cts-all-but-1-samps) ========
#  DSm2 -----------------------------------------------------------------------
#  Adjust counts and metadata matrices
t_counts_DSm2 <- t_counts[
    , colnames(t_counts) %>% stringr::str_detect("DSm2_")
]
t_meta_DSm2 <- t_meta[rownames(t_meta) %>% stringr::str_detect("DSm2_"), ] %>%
    dplyr::mutate(genotype = factor(genotype, levels = c("WT", "r6n")))

#  Create the dds object
dds_DSm2 <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts_DSm2,
    colData = t_meta_DSm2,
    design = ~genotype,
    rowRanges = g_pos
)

#  Use K. lactis control genes to estimate size factors
dds_DSm2 <- BiocGenerics::estimateSizeFactors(
    dds_DSm2,
    controlGenes = (dds_DSm2@rowRanges$genome == "K_lactis")
)
dds_DSm2@colData

#  Call DESeq2 using default parameters
dds_DSm2 <- DESeq2::DESeq(dds_DSm2[dds_DSm2@rowRanges$genome != "K_lactis", ])

#  Check model information
DESeq2::resultsNames(dds_DSm2)[length(DESeq2::resultsNames(dds_DSm2))]


#  DSp2 -----------------------------------------------------------------------
#  Adjust counts and metadata matrices
t_counts_DSp2 <- t_counts[, colnames(t_counts) %>% stringr::str_detect("DSp2_")]
t_meta_DSp2 <- t_meta[rownames(t_meta) %>% stringr::str_detect("DSp2_"), ] %>%
    dplyr::mutate(genotype = factor(genotype, levels = c("WT", "r6n")))

#  Create the dds object
dds_DSp2 <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts_DSp2,
    colData = t_meta_DSp2,
    design = ~genotype,
    rowRanges = g_pos
)

#  Use K. lactis control genes to estimate size factors
dds_DSp2 <- BiocGenerics::estimateSizeFactors(
    dds_DSp2,
    controlGenes = (dds_DSp2@rowRanges$genome == "K_lactis")
)
dds_DSp2@colData

#  Call DESeq2 using default parameters
dds_DSp2 <- DESeq2::DESeq(dds_DSp2[dds_DSp2@rowRanges$genome != "K_lactis", ])

#  Check model information
DESeq2::resultsNames(dds_DSp2)[length(DESeq2::resultsNames(dds_DSp2))]


#  DSp24 ----------------------------------------------------------------------
#  Adjust counts and metadata matrices
t_counts_DSp24 <- t_counts[, colnames(t_counts) %>% stringr::str_detect("DSp24_")]
t_meta_DSp24 <- t_meta[rownames(t_meta) %>% stringr::str_detect("DSp24_"), ] %>%
    dplyr::mutate(genotype = factor(genotype, levels = c("WT", "r6n")))

#  Create the dds object
dds_DSp24 <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts_DSp24,
    colData = t_meta_DSp24,
    design = ~genotype,
    rowRanges = g_pos
)

#  Use K. lactis control genes to estimate size factors
dds_DSp24 <- BiocGenerics::estimateSizeFactors(
    dds_DSp24,
    controlGenes = (dds_DSp24@rowRanges$genome == "K_lactis")
)
dds_DSp24@colData

#  Call DESeq2 using default parameters
dds_DSp24 <- DESeq2::DESeq(dds_DSp24[dds_DSp24@rowRanges$genome != "K_lactis", ])

#  Check model information
DESeq2::resultsNames(dds_DSp24)[length(DESeq2::resultsNames(dds_DSp24))]


#  DSp48 -----------------------------------------------------------------------
#  Adjust counts and metadata matrices
t_counts_DSp48 <- t_counts[, colnames(t_counts) %>% stringr::str_detect("DSp48_")]
t_meta_DSp48 <- t_meta[rownames(t_meta) %>% stringr::str_detect("DSp48_"), ] %>%
    dplyr::mutate(
        genotype = factor(genotype, levels = c("WT", "r6n")),
        #  Include batch information in model
        technical = factor(technical, levels = paste0("tech", c("1", "2")))
    )

#  Create the dds object
dds_DSp48 <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts_DSp48,
    colData = t_meta_DSp48,
    design = ~technical + genotype,  # Include batch information in model
    rowRanges = g_pos
)

#  Use K. lactis control genes to estimate size factors
dds_DSp48 <- BiocGenerics::estimateSizeFactors(
    dds_DSp48,
    controlGenes = (dds_DSp48@rowRanges$genome == "K_lactis")
)
dds_DSp48@colData

#  Call DESeq2 using default parameters
dds_DSp48 <- DESeq2::DESeq(dds_DSp48[dds_DSp48@rowRanges$genome != "K_lactis", ])

#  Check model information
DESeq2::resultsNames(dds_DSp48)[length(DESeq2::resultsNames(dds_DSp48))]


#  Call DESeq2::results() and make volcano plots for each pairwise DGE test ---
results_DSm2 <- call_DESeq2_results_plot_volcano(dds_DSm2)
results_DSp2 <- call_DESeq2_results_plot_volcano(dds_DSp2)
results_DSp24 <- call_DESeq2_results_plot_volcano(dds_DSp24)
results_DSp48 <- call_DESeq2_results_plot_volcano(dds_DSp48)

results_DSm2[["11_p"]]
results_DSp2[["11_p"]]
results_DSp24[["11_p"]]
results_DSp48[["11_p"]]


#  Run PCA w/non-norm. and rlog-norm. counts (min-10-cts-all-but-1-samps) =====
#  non-normalized -------------------------------------------------------------
t_tc_SC <- t_tc %>%
    dplyr::filter(genome == "S_cerevisiae")
gene_id <- ifelse(is.na(t_tc_SC$names), t_tc_SC$features, t_tc_SC$names) %>%
    make.unique()

counts_raw <- t_tc_SC %>%
    dplyr::select(12:ncol(t_tc_SC)) %>%
    dplyr::mutate_if(is.character, as.numeric)
pca_exp_raw <- run_PCA_pipeline(
    counts = counts_raw,
    metadata = t_meta,
    gene_id = gene_id,
    transformed = FALSE,
    transcription = FALSE,
    meta_color = "genotype",
    meta_shape = "time"
)
# pca_exp_raw[["02_horn"]]$n
# pca_exp_raw[["03_elbow"]]
# pca_exp_raw[["04_p_scree"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# pca_exp_raw[["10_p_images"]][["KA.PC1.v.PC2"]]
# pca_exp_raw[["12_p_cor"]]


#  rlog-normalized (~ technical + genotype) -----------------------------------
rld <- DESeq2::rlog(
    dds[dds@rowRanges$genome == "S_cerevisiae", ],
    blind = FALSE
)
norm_r <- SummarizedExperiment::assay(rld) %>%
    as.data.frame()
norm_r$features <- dds@rowRanges$features[
    dds@rowRanges$genome == "S_cerevisiae"
]
norm_r <- dplyr::full_join(
    norm_r,
    t_tc_SC[, 1:9],
    by = "features"
) %>%
    dplyr::as_tibble() %>%
    dplyr::relocate(18:26, .before = WT_DSm2_rep1_tech1)

counts_rlog <- norm_r %>%
    dplyr::select(10:ncol(norm_r)) %>%
    dplyr::mutate_if(is.character, as.numeric)
pca_exp_rlog <- run_PCA_pipeline(
    counts = counts_rlog,
    metadata = t_meta,
    gene_id = gene_id,
    transformed = TRUE,
    transcription = FALSE,
    meta_color = "genotype",
    meta_shape = "time"
)
# pca_exp_rlog[["02_horn"]]$n
# pca_exp_rlog[["03_elbow"]]
# pca_exp_rlog[["04_p_scree"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC3.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["KA.PC1.v.PC2"]]
# pca_exp_rlog[["12_p_cor"]]


#  Write out dataframes of raw and rlog-normalized counts =====================
run <- FALSE
if(isTRUE(run)) {
    counts_raw.bak <- counts_raw
    counts_rlog.bak <- counts_rlog

    # counts_raw <- counts_raw.bak
    # counts_rlog <- counts_rlog.bak

    counts_raw$features <- t_tc_SC$features
    counts_rlog$features <- t_tc_SC$features
    
    counts_raw <- dplyr::full_join(
        counts_raw, t_tc_SC[, 1:10], by = "features"
    ) %>%
        dplyr::relocate(
            colnames(t_tc_SC[, 1:10]), .before = WT_DSm2_rep1_tech1
        )
    counts_rlog <- dplyr::full_join(
        counts_rlog, t_tc_SC[, 1:10], by = "features"
    ) %>%
        dplyr::relocate(
            colnames(t_tc_SC[, 1:10]), .before = WT_DSm2_rep1_tech1
        )
    
    counts_raw <- counts_raw %>%
        dplyr::mutate(gene_id = gene_id) %>%
        dplyr::relocate(gene_id, .after = names)
    counts_rlog <- counts_rlog %>%
        dplyr::mutate(gene_id = gene_id) %>%
        dplyr::relocate(gene_id, .after = names)
    
    readr::write_tsv(counts_raw, "./data_timecourse_counts-raw.tsv")
    readr::write_tsv(counts_rlog, "./data_timecourse_counts-rlog.tsv")
}


#  Create a clustered heatmap of rlog-normalized counts =======================
run = FALSE
if(isTRUE(run)) {
    counts_rlog_full <- counts_rlog
    counts_rlog_full$features <- t_tc_SC$features
    counts_rlog_full <- dplyr::full_join(
        counts_rlog_full, t_tc_SC[, 1:10], by = "features"
    ) %>%
        dplyr::relocate(
            colnames(t_tc_SC[, 1:10]), .before = WT_DSm2_rep1_tech1
        )
    
    table(rowSums(counts_rlog_full[, 11:ncol(counts_rlog_full)]) == 0)
    crf_no_0 <- counts_rlog_full[!rowSums(counts_rlog_full[, 11:ncol(counts_rlog_full)]) == 0, ]
    pheatmap::pheatmap(
        crf_no_0[, 11:ncol(crf_no_0)],
        scale = "row",
        border = "white",
        cluster_cols = TRUE,
        show_rownames = FALSE
    )
    
    colnames(crf_no_0[, 11:ncol(crf_no_0)])
    # "WT_DSm2_rep1_tech1" "WT_DSm2_rep2_tech1" 
    # "WT_DSp2_rep1_tech1" "WT_DSp2_rep2_tech1"
    # "WT_DSp24_rep1_tech1" "WT_DSp24_rep2_tech1"
    # "WT_DSp48_rep1_tech1" "WT_DSp48_rep1_tech2" "WT_DSp48_rep2_tech1"
    # "r6n_DSm2_rep1_tech1" "r6n_DSm2_rep2_tech1"
    # "r6n_DSp2_rep1_tech1" "r6n_DSp2_rep2_tech1"
    # "r6n_DSp24_rep1_tech1" "r6n_DSp24_rep2_tech1"
    # "r6n_DSp48_rep1_tech1" "r6n_DSp48_rep2_tech2"
    
    crf_no_0$mean_WT_DSm2 <- rowMeans(cbind(
        crf_no_0$WT_DSm2_rep1_tech1,
        crf_no_0$WT_DSm2_rep2_tech1
    ))
    crf_no_0$mean_WT_DSp2 <- rowMeans(cbind(
        crf_no_0$WT_DSp2_rep1_tech1,
        crf_no_0$WT_DSp2_rep2_tech1
    ))
    crf_no_0$mean_WT_DSp24 <- rowMeans(cbind(
        crf_no_0$WT_DSp24_rep1_tech1,
        crf_no_0$WT_DSp24_rep2_tech1
    ))
    crf_no_0$mean_WT_DSp48 <- rowMeans(cbind(
        crf_no_0$WT_DSp48_rep1_tech1,
        crf_no_0$WT_DSp48_rep2_tech1,
        crf_no_0$WT_DSp48_rep1_tech2
    ))
    
    crf_no_0$mean_r6n_DSm2 <- rowMeans(cbind(
        crf_no_0$r6n_DSm2_rep1_tech1,
        crf_no_0$r6n_DSm2_rep2_tech1
    ))
    crf_no_0$mean_r6n_DSp2 <- rowMeans(cbind(
        crf_no_0$r6n_DSp2_rep1_tech1,
        crf_no_0$r6n_DSp2_rep2_tech1
    ))
    crf_no_0$mean_r6n_DSp24 <- rowMeans(cbind(
        crf_no_0$r6n_DSp24_rep1_tech1,
        crf_no_0$r6n_DSp24_rep2_tech1
    ))
    crf_no_0$mean_r6n_DSp48 <- rowMeans(cbind(
        crf_no_0$r6n_DSp48_rep1_tech1,
        crf_no_0$r6n_DSp48_rep2_tech2
    ))
    
    pheatmap::pheatmap(
        crf_no_0[, 28:ncol(crf_no_0)],
        scale = "row",
        border = "white",
        cluster_cols = TRUE,
        show_rownames = FALSE
    )
    
    crf_no_0$`r6n-over-WT_DSm2` <- crf_no_0$mean_r6n_DSm2 / crf_no_0$mean_WT_DSm2
    crf_no_0$`r6n-over-WT_DSp2` <- crf_no_0$mean_r6n_DSp2 / crf_no_0$mean_WT_DSp2
    crf_no_0$`r6n-over-WT_DSp24` <- crf_no_0$mean_r6n_DSp24 / crf_no_0$mean_WT_DSp24
    crf_no_0$`r6n-over-WT_DSp48` <- crf_no_0$mean_r6n_DSp48 / crf_no_0$mean_WT_DSp48
    
    pheatmap::pheatmap(
        crf_no_0[, 36:ncol(crf_no_0)],
        scale = "row",
        border = "white",
        cluster_cols = FALSE,
        show_rownames = FALSE
    )
    
    pheatmap::pheatmap(
        crf_no_0[, 36:ncol(crf_no_0)],
        kmeans_k = 3,
        scale = "row",
        border = "white",
        cluster_cols = FALSE,
        show_rownames = FALSE
    )
}
