#!/usr/bin/env Rscript

#  rough-draft_run-analyses_rlog-TPM-PCA_write_rds.R
#  KA


#  Initialize arguments =======================================================
#TODO Parser
# type <- "mRNA"  #ARGUMENT
# type <- "pa-ncRNA"  #ARGUMENT
# type <- "Trinity-Q"  #ARGUMENT
type <- "Trinity-G1"  #ARGUMENT
# type <- "Trinity-Q-unique"  #ARGUMENT
# type <- "Trinity-G1-unique"  #ARGUMENT
# type <- "representation"  #TODO

samples <- "Ovation"  #ARGUMENT
# samples <- "test.Ovation_Rrp6∆"  #ARGUMENT  #TODO Remove
# samples <- "test.Ovation_Tecan"  #ARGUMENT  #TODO Remove
# samples <- "Rrp6∆.G1-Q.N-SS"  #ARGUMENT
# samples <- "Rrp6∆.G1-Q.SS"  #ARGUMENT
# samples <- "Rrp6∆.Q.N-SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse"  #ARGUMENT
# samples <- "Rrp6∆.timecourse-G1-Q.SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse-G1.SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse-G1-Q.N-SS"  #ARGUMENT
# samples <- "Rrp6∆.timecourse.G1-SS.Q-N"  #ARGUMENT
# samples <- "Nab3AID.Q.N-SS"  #ARGUMENT
# samples <- "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS"  #ARGUMENT
# samples <- "Nab3AID.Q.SS_Rrp6∆.Q.SS"
# samples <- "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"  #ARGUMENT

# run_norm <- "rlog"  #ARGUMENT
run_norm <- "tpm"  #ARGUMENT

run_batch_correction <- FALSE  #ARGUMENT
run_PCA <- TRUE  #ARGUMENT
date <- "2023-0628"  #ARGUMENT

write_norm_counts_rds <- TRUE  #ARGUMENT
# write_norm_counts_rds <- FALSE  #ARGUMENT

# write_PCA_results <- TRUE  #ARGUMENT
write_PCA_results <- FALSE  #ARGUMENT

# write_pdfs <- TRUE  #ARGUMENT


#  Load libraries, set options ================================================
suppressMessages(library(DESeq2))
# suppressMessages(library(limma))
suppressMessages(library(PCAtools))
suppressMessages(library(tidyverse))

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Initialize functions and ggplot2 themes ====================================
`%notin%` <- base::Negate(`%in%`)


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


get_name_of_var <- function(v) {
    # ...
    #
    # :param v: ...
    # :return v: ...
    return(deparse(substitute(v)))
}


get_top_loadings <- function(x, y, z, a) {
    # ...
    #
    # :param x: dataframe of PC loadings <data.frame>
    # :param y: character element for column in dataframe x <chr>
    # :param z: whether to select all loadings sorted from largest to smallest
    #           absolute value ("all"), positive loadings sorted from largest
    #           to smallest value ("pos"), or negative loadings sorted from
    #           largest to smallest absolute value ("neg") <str>
    # :param a: whether or not to keep "sign" and "abs" columns added in the
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
        stop(paste("Stopping: param z must be either 'all', 'pos', or 'neg'"))
    }
    
    if(isTRUE(a)) {
        paste0("Retaining 'sign' and 'abs' columns")
    } else if(isFALSE(a)) {
        b <- b %>% dplyr::select(-c(sign, abs))
    } else {
        stop(paste("Stopping: param a must be either 'TRUE' or 'FALSE'"))
    }
    
    return(b)
}


plot_biplot <- function(
    pca, PC_x, PC_y,
    loadings_show, loadings_n,
    meta_color, meta_shape, shape_key = NULL,
    point_size = 6, encircle = FALSE,
    x_min, x_max, y_min, y_max
) {
    # ...
    #
    # :param pca: "pca" list object obtained by running PCAtools::pca()
    # :param PC_x: PC to plot on the x axis <chr>
    # :param PC_y: PC to plot on the y axis <chr>
    # :param loadings_show: whether to overlay component loadings or not <lgl>
    # :param loadings_n: number of top loadings to show <int >= 0>
    # :param meta_color: column in "pca" list metadata to color by <chr>
    # :param meta_shape: column in "pca" list metadata to shape by <chr>
    # :param shape_key: vector of name-value pairs relating to value passed to
    #                   "shape" <...>
    # :param point_size: size of plotted points <int>
    # :param encircle: draw a polygon around groups specified by "colby" <lgl>
    # :param x_min: minimum value on x axis <dbl>
    # :param x_max: maximum value on x axis <dbl>
    # :param y_min: minimum value on y axis <dbl>
    # :param y_max: maximum value on y axis <dbl>
    # :param title: title of biplot <dbl>
    # :return image: ...
    
    if(is.null(shape_key)) {
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
                pointSize = point_size,
                encircle = FALSE,
                ellipse = FALSE,
                max.overlaps = Inf,
                xlim = c(x_min, x_max),
                ylim = c(y_min, y_max)
            )
    } else {
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
                shapekey = shape_key,
                pointSize = point_size,
                encircle = FALSE,
                ellipse = FALSE,
                max.overlaps = Inf,
                xlim = c(x_min, x_max),
                ylim = c(y_min, y_max)
            )
    }

    image <- image + theme_AG_boxed
    
    return(image)
}


plot_loadings <- function(x, y, z, a, b, d, e, f, g, h, i, j, k) {
    # ...
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
    
    #  Perform debugging
    debug <- FALSE
    if(base::isTRUE(debug)) {
        # x = loadings_etc
        # y = coords_PC1
        # z = coords_PC2
        # a = x_min
        # b = x_max
        # d = y_min
        # e = y_max
        # f = x$nudge_x
        # g = x$nudge_y
        # h = x_label
        # i = y_label
        # j = x$color
        # k = col_seg_pos
        
        x = loadings_filter_pos_1
        y = loadings_filter_pos_1[[PC_x]]
        z = loadings_filter_pos_1[[PC_y]]
        a = x_min
        b = x_max
        d = y_min
        e = y_max
        f = loadings_etc[loadings_etc$label == "x_pos", ]$nudge_x[1]
        g = loadings_etc[loadings_etc$label == "x_pos", ]$nudge_y[1]
        h = x_label
        i = y_label
        j = loadings_etc[loadings_etc$label == "x_pos", ]$color[1]
        k = col_seg_pos
    }
    
    l <- ggplot2::ggplot(x, ggplot2::aes(x = y, y = z)) +
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
            label = x[["feature_names"]],
            label.size = 0.05,
            direction = "both",
            nudge_x = f,
            nudge_y = g,
            force = 4,
            force_pull = 1,
            hjust = 0
        ) +
        ggplot2::xlab(h) +
        ggplot2::ylab(i) +
        theme_slick_no_legend
    
    if(base::isTRUE(debug)) l
    return(l)
}


plot_pos_neg_loadings_each_axis <- function(
    df_all, df_pos, df_neg,
    PC_x, PC_y,
    row_start, row_end,
    x_min, x_max, y_min, y_max,
    x_pos_nudge_x, y_pos_nudge_x,
    x_neg_nudge_x, y_neg_nudge_x,
    x_pos_nudge_y, y_pos_nudge_y,
    x_neg_nudge_y, y_neg_nudge_y,
    x_label, y_label,
    col_x_pos = "#440154", col_y_pos = "#3B528B",
    col_x_neg = "#21918C", col_y_neg = "#5EC962",
    col_seg_pos, col_seg_neg
) {
    # ...
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
    # :param x_pos_nudge_x: amount to nudge labels for x positive loadings on x
    #                       axis <dbl>
    # :param y_pos_nudge_x: amount to nudge labels for y positive loadings on x
    #                       axis <dbl>
    # :param x_neg_nudge_x: amount to nudge labels for x negative loadings on x
    #                       axis <dbl>
    # :param y_neg_nudge_x: amount to nudge labels for y negative loadings on x
    #                       axis <dbl>
    # :param x_pos_nudge_y: amount to nudge labels for x positive loadings on y
    #                       axis <dbl>
    # :param y_pos_nudge_y: amount to nudge labels for y positive loadings on y
    #                       axis <dbl>
    # :param x_neg_nudge_y: amount to nudge labels for x negative loadings on y
    #                       axis <dbl>
    # :param y_neg_nudge_y: amount to nudge labels for y negative loadings on y
    #                       axis <dbl>
    # :param x_label: x axis label <chr>
    # :param y_label: y axis label <chr>
    # :param col_x_pos: color: lines, arrows for x positive loadings <chr>
    # :param col_y_pos: color: lines, arrows for y positive loadings <chr>
    # :param col_x_neg: color: lines, arrows for x negative loadings <chr>
    # :param col_y_neg: color: lines, arrows for y negative loadings <chr>
    # :param col_seg_pos: color: segments connecting arrowhead and text bubble
    #                     for positive loadings <chr>
    # :param col_seg_neg: color: segments connecting arrowhead and text bubble
    #                     for negative loadings <chr>
    # :return image: ...
    
    #  Perform debugging
    debug <- FALSE
    if(base::isTRUE(debug)) {
        df_all = loadings
        df_pos = top_loadings_pos
        df_neg = top_loadings_neg
        PC_x = PC_x
        PC_y = PC_y
        row_start = 1
        row_end = n_loadings
        x_min = x_min_loadings_plot
        x_max = x_max_loadings_plot
        y_min = y_min_loadings_plot
        y_max = y_max_loadings_plot
        x_pos_nudge_x = 0.04
        y_pos_nudge_x = 0
        x_neg_nudge_x = -0.04
        y_neg_nudge_x = -0.02
        x_pos_nudge_y = 0
        y_pos_nudge_y = 0.04
        x_neg_nudge_y = 0
        y_neg_nudge_y = -0.04
        x_label = x_label
        y_label = y_label
        col_x_pos = "#440154"
        col_y_pos = "#3B528B"
        col_x_neg = "#21918C"
        col_y_neg = "#5EC962"
        col_seg_pos = "grey"
        col_seg_neg = "grey"
    }
    
    filter_pos_1 <- rownames(df_pos[[PC_x]][row_start:row_end, ])
    filter_pos_2 <- rownames(df_pos[[PC_y]][row_start:row_end, ])
    filter_neg_1 <- rownames(df_neg[[PC_x]][row_start:row_end, ])
    filter_neg_2 <- rownames(df_neg[[PC_y]][row_start:row_end, ])
    
    loadings_filter_pos_1 <- df_all[rownames(df_all) %in% filter_pos_1, ]
    loadings_filter_pos_2 <- df_all[rownames(df_all) %in% filter_pos_2, ]
    loadings_filter_neg_1 <- df_all[rownames(df_all) %in% filter_neg_1, ]
    loadings_filter_neg_2 <- df_all[rownames(df_all) %in% filter_neg_2, ]
    
    loadings_etc <- dplyr::bind_rows(
        loadings_filter_pos_1,
        loadings_filter_pos_2,
        loadings_filter_neg_1,
        loadings_filter_neg_2
    )
    loadings_etc$label <- c(
        rep("x_pos", 10),
        rep("y_pos", 10),
        rep("x_neg", 10),
        rep("y_neg", 10)
    )
    loadings_etc$color <- c(
        rep(col_x_pos, 10),  # x pos
        rep(col_y_pos, 10),  # y pos
        rep(col_x_neg, 10),  # x neg
        rep(col_y_neg, 10)  # y neg
    )
    loadings_etc$nudge_x <- c(
        rep(x_pos_nudge_x, 10),  # x pos
        rep(y_pos_nudge_x, 10),  # y pos
        rep(x_neg_nudge_x, 10),  # x neg
        rep(y_neg_nudge_x, 10)  # y neg
    )
    loadings_etc$nudge_y <- c(
        rep(x_pos_nudge_y, 10),  # x pos
        rep(y_pos_nudge_y, 10),  # y pos
        rep(x_neg_nudge_y, 10),  # x neg
        rep(y_neg_nudge_y, 10)  # y neg
    )
    
    #  Move rownames to a column, then remove signs of duplicate rownames (but
    #+ keep the duplicate entries (at least for now))
    loadings_etc <- loadings_etc %>%
        tibble::rownames_to_column("feature_names")
    loadings_etc$feature_names <- loadings_etc$feature_names %>%
        stringr::str_remove_all("\\.\\.\\.[0-9]{1,2}$")
    
    loadings_filter_pos_1 <- loadings_filter_pos_1 %>%
        tibble::rownames_to_column("feature_names")
    loadings_filter_pos_1$feature_names <-
        loadings_filter_pos_1$feature_names %>%
        stringr::str_remove_all("\\.\\.\\.[0-9]{1,2}$")
    
    loadings_filter_pos_2 <- loadings_filter_pos_2 %>%
        tibble::rownames_to_column("feature_names")
    loadings_filter_pos_2$feature_names <-
        loadings_filter_pos_2$feature_names %>%
        stringr::str_remove_all("\\.\\.\\.[0-9]{1,2}$")
    
    loadings_filter_neg_1 <- loadings_filter_neg_1 %>%
        tibble::rownames_to_column("feature_names")
    loadings_filter_neg_1$feature_names <-
        loadings_filter_neg_1$feature_names %>%
        stringr::str_remove_all("\\.\\.\\.[0-9]{1,2}$")
    
    loadings_filter_neg_2 <- loadings_filter_neg_2 %>%
        tibble::rownames_to_column("feature_names")
    loadings_filter_neg_2$feature_names <-
        loadings_filter_neg_2$feature_names %>%
        stringr::str_remove_all("\\.\\.\\.[0-9]{1,2}$")
    
    if(base::isTRUE(debug)) {
        loadings_etc %>% head()
        loadings_filter_pos_1 %>% head()
        loadings_filter_pos_2 %>% head()
        loadings_filter_neg_1 %>% head()
        loadings_filter_neg_2 %>% head()
    }

    coords_PC1 <- c(
        loadings_filter_pos_1[[PC_x]],
        loadings_filter_pos_2[[PC_x]],
        loadings_filter_neg_1[[PC_x]],
        loadings_filter_neg_2[[PC_x]]
    )
    coords_PC2 <- c(
        loadings_filter_pos_1[[PC_y]],
        loadings_filter_pos_2[[PC_y]],
        loadings_filter_neg_1[[PC_y]],
        loadings_filter_neg_2[[PC_y]]
    )
    
    images <- list()
    images[["all"]] <- plot_loadings(
        loadings_etc,
        coords_PC1,
        coords_PC2,
        x_min,
        x_max,
        y_min,
        y_max,
        loadings_etc$nudge_x,
        loadings_etc$nudge_y,
        x_label,
        y_label,
        loadings_etc$color,
        col_seg_pos
    )
    images[["PC_x_pos"]] <- plot_loadings(
        loadings_filter_pos_1,
        loadings_filter_pos_1[[PC_x]],
        loadings_filter_pos_1[[PC_y]],
        x_min,
        x_max,
        y_min,
        y_max,
        loadings_etc[loadings_etc$label == "x_pos", ]$nudge_x[1],
        loadings_etc[loadings_etc$label == "x_pos", ]$nudge_y[1],
        x_label,
        y_label,
        loadings_etc[loadings_etc$label == "x_pos", ]$color[1],
        col_seg_pos
    )
    images[["PC_y_pos"]] <- plot_loadings(
        loadings_filter_pos_2,
        loadings_filter_pos_2[[PC_x]],
        loadings_filter_pos_2[[PC_y]],
        x_min,
        x_max,
        y_min,
        y_max,
        loadings_etc[loadings_etc$label == "y_pos", ]$nudge_x[1],
        loadings_etc[loadings_etc$label == "y_pos", ]$nudge_y[1],
        x_label,
        y_label,
        loadings_etc[loadings_etc$label == "y_pos", ]$color[1],
        col_seg_pos
    )
    images[["PC_x_neg"]] <- plot_loadings(
        loadings_filter_neg_1,
        loadings_filter_neg_1[[PC_x]],
        loadings_filter_neg_1[[PC_y]],
        x_min,
        x_max,
        y_min,
        y_max,
        loadings_etc[loadings_etc$label == "x_neg", ]$nudge_x[1],
        loadings_etc[loadings_etc$label == "x_neg", ]$nudge_y[1],
        x_label,
        y_label,
        loadings_etc[loadings_etc$label == "x_neg", ]$color[1],
        col_seg_neg
    )
    images[["PC_y_neg"]] <- plot_loadings(
        loadings_filter_neg_2,
        loadings_filter_neg_2[[PC_x]],
        loadings_filter_neg_2[[PC_y]],
        x_min,
        x_max,
        y_min,
        y_max,
        loadings_etc[loadings_etc$label == "y_neg", ]$nudge_x[1],
        loadings_etc[loadings_etc$label == "y_neg", ]$nudge_y[1],
        x_label,
        y_label,
        loadings_etc[loadings_etc$label == "y_neg", ]$color[1],
        col_seg_neg
    )
    
    if(base::isTRUE(debug)) images[["all"]]
    return(images)
}


draw_scree_plot <- function(pca, horn, elbow) {
    # ...
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
    counts,
    metadata,
    feat_id,
    x_min_biplot = -100,
    x_max_biplot = 100,
    y_min_biplot = -100,
    y_max_biplot = 100,
    x_min_loadings_plot = -0.1,
    x_max_loadings_plot = 0.1,
    y_min_loadings_plot = -0.1,
    y_max_loadings_plot = 0.1,
    n_loadings = 10,
    x_pos_nudge_x = 0.04,
    y_pos_nudge_x = 0,
    x_neg_nudge_x = -0.04,
    y_neg_nudge_x = -0.02,
    x_pos_nudge_y = 0,
    y_pos_nudge_y = 0.04,
    x_neg_nudge_y = 0,
    y_neg_nudge_y = -0.04,
    meta_color,
    meta_shape,
    shape_key = NULL,
    point_size = 6,
    encircle = FALSE,
    plot_loadings_pct = FALSE,
    drop_md_levels = NULL,
    PCs_cor_plot
) {
    # ...
    #
    # :param counts: ... <data.frame>
    # :param metadata: ... <data.frame>
    # :param feat_id: ... <chr>
    # :param x_min_biplot: ... <dbl> [default: -100]
    # :param x_max_biplot: ... <dbl> [default: 100]
    # :param y_min_biplot: ... <dbl> [default: -100]
    # :param y_max_biplot: ... <dbl> [default: 100]
    # :param x_min_loadings_plot: ... <dbl> [default: -0.1]
    # :param x_max_loadings_plot: ... <dbl> [default: 0.1]
    # :param y_min_loadings_plot: ... <dbl> [default: -0.1]
    # :param y_max_loadings_plot: ... <dbl> [default: 0.1]
    # :param n_loadings: Number of loading vectors to show per positive and 
    #                    negative x and y axis <int> [default: 10L]
    # :param x_pos_nudge_x: amount to nudge labels for x positive loadings on x
    #                       axis <dbl>
    # :param y_pos_nudge_x: amount to nudge labels for y positive loadings on x
    #                       axis <dbl>
    # :param x_neg_nudge_x: amount to nudge labels for x negative loadings on x
    #                       axis <dbl>
    # :param y_neg_nudge_x: amount to nudge labels for y negative loadings on x
    #                       axis <dbl>
    # :param x_pos_nudge_y: amount to nudge labels for x positive loadings on y
    #                       axis <dbl>
    # :param y_pos_nudge_y: amount to nudge labels for y positive loadings on y
    #                       axis <dbl>
    # :param x_neg_nudge_y: amount to nudge labels for x negative loadings on y
    #                       axis <dbl>
    # :param y_neg_nudge_y: amount to nudge labels for y negative loadings on y
    #                       axis <dbl>
    # :param meta_color: ... <chr>
    # :param meta_shape: ... <chr>
    # :param shape_key: ... <...>
    # :param point_size: size of plotted points <int>
    # :param encircle: draw a polygon around groups specified by "colby" <lgl>
    # :param plot_loadings_pct: Plot top 2.5% loadings for elbow + 2 number of
    #                           PCs <lgl> [default: FALSE]
    # :param drop_md_levels: Metadata variables to drop from correlation plot
    #                        <chr> [default: NULL]
    # :param PCs_cor_plot: PCs to include in correlation plot <dbl>
    #                      [default: NULL]
    # :return results_list: ... <list>
    
    #  Perform debugging  #SHORTCUT
    debug <- FALSE
    if(base::isTRUE(debug)) {
        counts = input_counts
        metadata = t_meta
        feat_id = pca_feat_id
        x_min_biplot = ifelse(run_norm == "rlog", -50, -100)
        x_max_biplot = ifelse(run_norm == "rlog", 50, 100)
        y_min_biplot = ifelse(run_norm == "rlog", -50, -100)
        y_max_biplot = ifelse(run_norm == "rlog", 50, 100)
        x_min_loadings_plot = ifelse(run_norm == "rlog", -0.1, -0.1)
        x_max_loadings_plot = ifelse(run_norm == "rlog", 0.1, 0.1)
        y_min_loadings_plot = ifelse(run_norm == "rlog", -0.1, -0.1)
        y_max_loadings_plot = ifelse(run_norm == "rlog", 0.1, 0.1)
        n_loadings = 10L
        x_pos_nudge_x = 0.04
        y_pos_nudge_x = 0
        x_neg_nudge_x = -0.04
        y_neg_nudge_x = -0.02
        x_pos_nudge_y = 0
        y_pos_nudge_y = 0.04
        x_neg_nudge_y = 0
        y_neg_nudge_y = -0.04
        meta_color = meta_color
        meta_shape = meta_shape
        plot_loadings_pct = FALSE
        drop_md_levels = c("gt_st", "gt_tx", "st_tx", "gt_st_tx", "tc", "day")
        PCs_cor_plot = 3
    }
    
    #  Check arguments
    stopifnot(is.data.frame(counts))
    stopifnot(is.data.frame(metadata))
    stopifnot(isTRUE(tibble::has_rownames(metadata)))
    stopifnot(is.character(feat_id))
    #TODO Checks for {x,y}_{min,max}_*
    stopifnot(is.logical(plot_loadings_pct))
    if(!is.null(drop_md_levels)) stopifnot(is.character(drop_md_levels))
    if(!is.null(PCs_cor_plot)) stopifnot(is.numeric(PCs_cor_plot))
    
    #  Create a PCAtools "pca" S4 object
    pca <- PCAtools::pca(counts, metadata = metadata)
    rownames(pca$loadings) <- feat_id
    
    #  Determine "significant" PCs with Horn's parallel analysis (see Horn,
    #+ 1965)
    horn <- PCAtools::parallelPCA(counts[, 2:ncol(counts)]) %>%
        suppressWarnings()
    if(base::isTRUE(debug)) print(horn$n)
    
    #  Determine "significant" principle components with the elbow method (see
    #+ Buja and Eyuboglu, 1992)
    elbow <- PCAtools::findElbowPoint(pca$variance)
    if(base::isTRUE(debug)) print(elbow)
    
    #  Evaluate cumulative proportion of explained variance with a scree plot
    p_scree <- draw_scree_plot(pca, horn = horn$n, elbow = elbow)
    if(base::isTRUE(debug)) print(p_scree)
    
    #  Save component loading vectors in their own dataframe
    loadings <- as.data.frame(pca$loadings)
    
    #  Evaluate the component loading vectors for the number of "significant"
    #+ PCs identified via the elbow method plus two
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
    if(base::isTRUE(debug)) print(names(top_loadings_all))
    
    #  Evaluate positive and negative loadings on axes of biplots; look at the
    #+ top 15 per axis
    p_images <- list()
    mat <- combn(PCs, 2)
    for(l in 1:ncol(mat)) {
        # l <- 2
        m <- mat[, l]
        
        PC_x <- x_label <- m[1]
        PC_y <- y_label <- m[2]
        
        p_images[[paste0("PCAtools.", PC_x, ".v.", PC_y)]] <-
            plot_biplot(
                pca = pca,
                PC_x = PC_x,
                PC_y = PC_y,
                loadings_show = FALSE,
                loadings_n = 0,
                meta_color = meta_color,  #DONE
                meta_shape = meta_shape,  #DONE
                shape_key = shape_key,
                point_size = point_size,
                encircle = encircle,
                x_min = x_min_biplot,
                x_max = x_max_biplot,
                y_min = y_min_biplot,
                y_max = y_max_biplot
            )
        if(base::isTRUE(debug)) p_images[[
            paste0("PCAtools.", PC_x, ".v.", PC_y)
        ]]
        
        p_images[[paste0("KA.", PC_x, ".v.", PC_y)]] <-
            plot_pos_neg_loadings_each_axis(  #DEBUGFROMHERE
                df_all = loadings,
                df_pos = top_loadings_pos,
                df_neg = top_loadings_neg,
                PC_x = PC_x,
                PC_y = PC_y,
                row_start = 1,
                row_end = n_loadings,
                x_min = x_min_loadings_plot,
                x_max = x_max_loadings_plot,
                y_min = y_min_loadings_plot,
                y_max = y_max_loadings_plot,
                x_pos_nudge_x = x_pos_nudge_x,
                y_pos_nudge_x = y_pos_nudge_x,
                x_neg_nudge_x = x_neg_nudge_x,
                y_neg_nudge_x = y_neg_nudge_x,
                x_pos_nudge_y = x_pos_nudge_y,
                y_pos_nudge_y = y_pos_nudge_y,
                x_neg_nudge_y = x_neg_nudge_y,
                y_neg_nudge_y = y_neg_nudge_y,
                x_label = x_label,
                y_label = y_label,
                col_x_pos = "#440154",
                col_y_pos = "#3B528B",
                col_x_neg = "#21918C",
                col_y_neg = "#5EC962",
                col_seg_pos = "grey",
                col_seg_neg = "grey"
            )
        
        if(base::isTRUE(debug)) p_images[[paste0("KA.", PC_x, ".v.", PC_y)]]
    }
    if(base::isTRUE(debug)) {
        # p_images$PCAtools.PC3.v.PC4 %>% print()
        # p_images$PCAtools.PC2.v.PC4 %>% print()
        # p_images$PCAtools.PC2.v.PC3 %>% print()
        # p_images$PCAtools.PC1.v.PC4 %>% print()
        # p_images$PCAtools.PC1.v.PC3 %>% print()
        # p_images$PCAtools.PC1.v.PC2 %>% print()
        
        run <- FALSE
        if(base::isTRUE(run)) p_images$KA.PC1.v.PC2 %>% print()
    }
    
    #  Plot the top features on an axis of "component loading range" to
    #+ visualize the top variables (features) that drive variance among
    #+ PCs of interest
    if(base::isTRUE(plot_loadings_pct)) {
        p_loadings <- PCAtools::plotloadings(
            pca,
            components = PCAtools::getComponents(pca, 1:length(PCs)),
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
                panel.grid.minor = element_line(linewidth = 0.5),
                panel.grid.major = element_line(linewidth = 1),
                axis.text = element_text(
                    size = 20, face = "bold", color = "black"
                ),
                axis.title = element_text(size = 25, face = "bold")
            ) # +
            # coord_obs_pred()
        if(base::isTRUE(debug)) p_loadings %>% print()
        #TODO Work up some logic for saving the plot
    }
    
    #  Evaluate correlations between PCs and model variables; answer
    #+ the question, "What is driving biologically significant variance
    #+ in our data?"
    metavars <- t_meta[stringr::str_detect(colnames(t_meta), "no_")]
    metavars <- metavars[
        , vapply(metavars, function(x) length(unique(x)) > 1, logical(1L))
    ]
    colnames(metavars) <- colnames(metavars) %>% gsub("no_", "", .)
    
    if(!is.null(drop_md_levels)) {
        metavars <- metavars %>%
            dplyr::select(-dplyr::any_of(drop_md_levels))
    }
    
    components <- if(is.null(PCs_cor_plot)) {
        PCAtools::getComponents(pca, 1:(elbow + 2))
    } else {
        paste0("PC", c(1:PCs_cor_plot))
    }
    
    p_cor <- PCAtools::eigencorplot(
        pca,
        components = components,
        metavars = colnames(metavars),
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
    ) %>%
        suppressWarnings()
    if(base::isTRUE(debug)) p_cor %>% print()
    
    results_list <- list()
    results_list[["01_pca"]] <- pca
    results_list[["02_horn"]] <- horn
    results_list[["03_elbow"]] <- elbow
    results_list[["04_p_scree"]] <- p_scree
    results_list[["05_loadings"]] <- loadings
    results_list[["06_PCs"]] <- PCs
    results_list[["07_top_loadings_all"]] <- top_loadings_all
    results_list[["08_top_loadings_pos"]] <- top_loadings_pos
    results_list[["09_top_loadings_neg"]] <- top_loadings_neg
    results_list[["10_p_images"]]<- p_images
    if(base::isTRUE(plot_loadings_pct)) {
        results_list[["11_p_loadings"]] <- p_loadings
    }
    results_list[["12_p_cor"]] <- p_cor
    
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
        panel.border = element_rect(linewidth = 2, color = "black", fill = NA)
    )

theme_slick_no_legend <- theme_slick + theme(legend.position = "none")

theme_AG_no_legend <- theme_AG + theme(legend.position = "none")

theme_AG_boxed_no_legend <- theme_AG_boxed + theme(legend.position = "none")


#  Get situated, load counts matrix ===========================================
if(stringr::str_detect(getwd(), "kalavattam")) {
    p_base <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_base <- "/Users/kalavatt/projects-etc"
}
p_exp <- "2022_transcriptome-construction/results/2023-0215"

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

#  Determine mRNA counts matrix to work with, then load it
#  Check on "type" option
if(base::isTRUE(type %notin% c(
    "mRNA", "pa-ncRNA", "Trinity-Q", "Trinity-G1", "Trinity-Q-unique",
    "Trinity-G1-unique", "representation"
))) {
    stop(paste(
        "Variable \"type\" must be \"mRNA\", \"pa-ncRNA\",",
        "\"Trinity-Q\", \"Trinity-G1\", \"Trinity-Q\", \"Trinity-G1\",",
        "\"representation\""
    ))
}

#  Load counts matrix
if(type == "mRNA") {
    p_cm <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
    f_cm <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
    
    p_gtf <- "infiles_gtf-gff3/already"
    f_gtf <- "combined_SC_KL_20S.gff3"
    
} else if(type == "pa-ncRNA") {
    p_cm <- "outfiles_htseq-count/representation/UT_prim_UMI"
    f_cm <- "representative-non-coding-transcriptome.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/representation"
    f_gtf <- "Greenlaw-et-al_representative-non-coding-transcriptome.gtf"
    
} else if(type == "Trinity-Q") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus"
    f_cm <- "Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
    f_gtf <- "Q_mkc-4_gte-pctl-25.clean.gtf"
    
} else if(type == "Trinity-G1") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/G_N/filtered/locus"
    f_cm <- "G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
    f_gtf <- "G1_mkc-4_gte-pctl-25.clean.gtf"
    
} else if(type == "Trinity-Q-unique") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus"
    f_cm <- "Q_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/Q_N/filtered/locus"
    f_gtf <- "Q_mkc-4_gte-pctl-25.clean.gtf"
    
} else if(type == "Trinity-G1-unique") {
    p_cm <- "outfiles_htseq-count/Trinity-GG/G_N/filtered/locus"
    f_cm <- "G1_mkc-4_gte-pctl-25.clean.hc-strd-eq.tsv"
    
    p_gtf <- "outfiles_gtf-gff3/Trinity-GG/G_N/filtered/locus"
    f_gtf <- "G1_mkc-4_gte-pctl-25.clean.gtf"
    
} else if(type == "representation") {
    #TODO p_cm <- "outfiles_htseq-count/comprehensive/..."
    #TODO f_cm <- "..."
    
    p_gtf <- "processed_features-intergenic_sense-antisense.gtf"
    f_gtf <- "outfiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203"
}


#  Read in htseq-count counts matrix ------------------------------------------
#  Check that counts matrix exists
run <- TRUE
if(base::isTRUE(run)) {
    paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        file.exists()  # [1] TRUE
}

if(type == "mRNA") {
    t_cm <- paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE) %>%
        dplyr::slice(-1)  # Slice out the first row, which contains file info
} else {
    t_cm <- paste(p_base, p_exp, p_cm, f_cm, sep = "/") %>%
        readr::read_tsv(show_col_types = FALSE)
}

#  "Clean up" counts matrix column names and "features" elements
if(base::isTRUE(type == "mRNA")) {
    colnames(t_cm) <- colnames(t_cm) %>%
        gsub(".UT_prim_UMI.hc-strd-eq.tsv", "", .)
} else {
    colnames(t_cm)[1] <- "features"
    colnames(t_cm) <- colnames(t_cm) %>%
        gsub("bams_renamed/UT_prim_UMI/", "", .) %>%
        gsub(".UT_prim_UMI.bam", "", .)
}

if(type == "mRNA") {
    t_cm <- t_cm %>%
        dplyr::mutate(
            features = features %>%
                gsub("^transcript\\:", "", .) %>%
                gsub("_mRNA", "", .)
        )
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

run <- TRUE
if(base::isTRUE(run)) {
    t_cm.bak <- t_cm
    # t_cm <- t_cm.bak
}
t_cm <- filter_process_counts_matrix(t_cm, col_cor)


#  To associate features with metadata, load gff3 or gtf file -----------------
run <- TRUE
if(base::isTRUE(run)) {
    paste(p_gtf, f_gtf, sep = "/") %>% file.exists()  # [1] TRUE
}

#  Load in, subset, and "clean up" gff3
if(type == "mRNA") {
    t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
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
} else {
    t_gtf <- paste(p_gtf, f_gtf, sep = "/") %>%
        rtracklayer::import() %>%
        as.data.frame() %>%
        dplyr::as_tibble() %>%
        dplyr::select(-c(score, phase))
    
    if(stringr::str_detect(type, "unique")) {
        #  Load dataframe for custom annotations that do not overlap R64 or
        #+ pa-ncRNA collapsed/merged annotations:
        #+ "Trinity_putative-transcripts.2023-0620.unique"
        p_df <- "notebook/KA.2023-0620.Trinity_putative-transcripts.Q_G1"
        
        if(stringr::str_detect(type, "Q")) {
            f_df <- "Trinity_putative-transcripts.2023-0620.unique.Q.tsv"
        } else if(stringr::str_detect(type, "G1")) {
            f_df <- "Trinity_putative-transcripts.2023-0620.unique.G1.tsv"
        }            
        
        df <- readr::read_tsv(
            paste(p_df, f_df, sep = "/"), show_col_types = FALSE
        )
        
        #  Filter gtf to retain only "unique" custom annotations
        t_gtf <- t_gtf[t_gtf$locus_id %in% df$feature, ]
        t_cm <- t_cm[t_cm$features %in% df$feature, ]
        
        rm(p_df, f_df, df)
    }
}

#  Subset gff3 tibble to keep only relevant columns
if(type == "mRNA") {
    keep <- c(
        "chr", "start", "end",
        "width", "strand", "type",
        "features", "biotype", "names"
    )
    t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]
} else if(type == "pa-ncRNA") {
    keep <- c(
        "seqnames", "start", "end",
        "width", "strand", "type",
        "gene_id", "details_type_alpha", "details_all"
    )
    t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]
    t_gtf <- t_gtf %>%
        dplyr::rename(
            "chr" = "seqnames",
            "features" = "gene_id",
            "biotype" = "details_type_alpha",
            "names" = "details_all"
        )
} else if(stringr::str_detect(type, "Trinity")) {
    keep <- c(
        "seqnames", "start", "end",
        "width", "strand", "locus_id",
        "type_detailed", "category_detailed", "category_full"
    )
    t_gtf <- t_gtf[, colnames(t_gtf) %in% keep]
    t_gtf <- t_gtf %>%
        dplyr::rename(
            "chr" = "seqnames",
            "type" = "category_detailed",
            "features" = "locus_id",
            "biotype" = "type_detailed",
            "names" = "category_full"
        )
}
rm(keep)

#  Convert column names from list to character vector, and replace empty fields
#+ with NA character values
t_gtf$names <- ifelse(
    as.character(t_gtf$names) == "character(0)",
    NA_character_,
    as.character(t_gtf$names)
)

#  Give Trinity annotations cleaner, clearer names
if(stringr::str_detect(type, "Trinity")) {
    t_gtf$names <- t_gtf$names %>%
        stringr::str_remove_all("antisense_gene: |antisense_ncRNA: ") %>%
        stringr::str_remove_all("antisense_PG: |antisense_rRNA: |") %>%
        stringr::str_remove_all("antisense_snoRNA: |antisense_TE: |") %>%
        stringr::str_remove_all("antisense_tRNA: |ARS: |gene: ") %>%
        stringr::str_remove_all("intergenic: |ncRNA: |PE: |rRNA: |snRNA: ") %>%
        stringr::str_remove_all("snoRNA: |TE: |telomere: |tRNA: ") %>%
        stringr::str_remove_all("-[0-9]*\\b")
}


#  Combine "counts matrix tibble" and "gff3 tibble" ---------------------------
t_mat <- dplyr::full_join(t_gtf, t_cm, by = "features")

#  Add column of "thorough" names
t_mat$thorough <- ifelse(!is.na(t_mat$names), t_mat$names, t_mat$features)
t_mat <- t_mat %>% dplyr::relocate(thorough, .after = names)

#  Sort counts columns by column names
tmp_A <- t_mat[, 1:10]
tmp_B <- t_mat[, 11:ncol(t_mat)][, order(names(t_mat[, 11:ncol(t_mat)]))]
t_mat <- dplyr::bind_cols(tmp_A, tmp_B)

#  Remove unneeded variables
rm(list = ls(pattern = "tmp_"))
rm(f_gtf, f_cm, p_base, p_exp, p_gtf, p_cm, t_gtf, t_cm)


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
            # t_mat$chr %in% chr_20S,
            t_mat$features %in% chr_20S,
            "20S",
            NA
        )
    )
) %>%
    as.factor()
t_mat <- t_mat %>% dplyr::relocate(genome, .before = chr)

t_mat$start[which(t_mat$genome == "20S")] <-
    t_mat$end[which(t_mat$genome == "20S")] <-
    0
t_mat$chr[which(t_mat$genome == "20S")] <- "20S"

#  Remove unneeded variables again
rm(chr_20S, chr_KL, chr_SC, chr_order)


#  For analyses of non-"unique" feat., extract htseq-count summary metrics ----
if(!stringr::str_detect(type, "unique")) {
    #  They are at the end of the matrices and have names that begin with two
    #+ underscore characters
    underscore <- t_mat[
        stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), 
    ]

    #  Exclude htseq-count summary metrics from t_mat
    t_mat <- t_mat[!stringr::str_detect(t_mat$features, "^__[a-zA-Z0-9_]*$"), ]
}

run <- FALSE
if(base::isTRUE(run)) t_mat %>% tail(10)


#  Subset t_mat to include counts only for samples of interest ----------------
run <- TRUE
if(base::isTRUE(run)) {
    t_mat.bak <- t_mat
    # t_mat <- t_mat.bak
    # colnames(t_mat)
}

if(samples %notin% c(
    "Ovation", "test.Ovation_Rrp6∆", "test.Ovation_Tecan", "Rrp6∆.G1-Q.N-SS",
    "Rrp6∆.G1-Q.SS", "Rrp6∆.Q.N-SS", "Rrp6∆.timecourse",
    "Rrp6∆.timecourse-G1-Q.SS", "Rrp6∆.timecourse-G1.SS",
    "Rrp6∆.timecourse-G1-Q.N-SS", "Rrp6∆.timecourse.G1-SS.Q-N",
    "Nab3AID.Q.N-SS", "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS",
    "Nab3AID.Q.SS_Rrp6∆.Q.SS", "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"
)) {
    stop(paste(
        "Variable \"samples\" must be \"Ovation\", \"test.Ovation_Rrp6∆\",",
        "\"test.Ovation_Tecan\", \"Rrp6∆.G1-Q.N-SS\", \"Rrp6∆.G1-Q.SS\",",
        "\"Rrp6∆.Q.N-SS\", \"Rrp6∆.timecourse\",",
        "\"Rrp6∆.timecourse-G1-Q.SS\", \"Rrp6∆.timecourse-G1.SS\",",
        "\"Rrp6∆.timecourse-G1-Q.N-SS\", \"Rrp6∆.timecourse.G1-SS.Q-N\",",
        "\"Nab3AID.Q.N-SS\", \"Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS\",",
        "\"Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS\""
    ))
}

tmp_A <- t_mat[, 1:11]
tmp_B <- t_mat[, 12:ncol(t_mat)]

if(samples == "Ovation") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn"
    )]
} else if(samples == "test.Ovation_Rrp6∆") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
} else if(samples == "test.Ovation_Tecan") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "ovn|test"
    )] %>%
        dplyr::select(-WTovn_Q_SS_rep1_tech1)
} else if(samples == "Rrp6∆.G1-Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
} else if(samples == "Rrp6∆.G1-Q.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "r6n_Q|r6n_G1|WT_Q|WT_G1"
    )] 
    tmp_C <- tmp_C[, -grep("_N_", colnames(tmp_C))]
} else if(samples == "Rrp6∆.Q.N-SS") {
        tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "r6n_Q|WT_Q"
    )] 
} else if(samples == "Rrp6∆.timecourse") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp"
    )]
    tmp_C <- tmp_C[, -grep("t4n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("_N_|t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_G1|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("_N_|t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1-Q.N") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("_N_|t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse-G1-Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("t4n|r1n", colnames(tmp_C))]
} else if(samples == "Rrp6∆.timecourse.G1-SS.Q-N") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("t4n|r1n|Q_SS", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od"
    )]
    tmp_C <- tmp_C[, -grep("rep3", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od|r6n_Q|WT_Q"
    )]
    tmp_C <- tmp_C[, -grep("rep3", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.SS_Rrp6∆.Q.SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od|r6n_Q|WT_Q"
    )]
    tmp_C <- tmp_C[, -grep("rep3|_N_", colnames(tmp_C))]
} else if(samples == "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS") {
    tmp_C <- tmp_B[, stringr::str_detect(
        colnames(tmp_B), "n3d|od|DSm|DSp|r6n_Q|r6n_G1|WT_Q|WT_G1"
    )]
    tmp_C <- tmp_C[, -grep("t4n|r1n|rep3", colnames(tmp_C))]
}

t_mat <- dplyr::bind_cols(tmp_A, tmp_C)
rm(list = ls(pattern = "tmp_"))

# tmp <- dplyr::bind_cols(tmp_A, tmp_C)
# colnames(tmp)
# colnames(t_mat)


#  Prepare metadata, data, etc. for running PCA ===============================
#  Make a dds object from t_mat -----------------------------------------------
#  Exclude features with row-wise sums of zero
t_mat[12:ncol(t_mat)] <- sapply(t_mat[12:ncol(t_mat)], as.numeric)
t_mat <- t_mat[rowSums(t_mat[12:ncol(t_mat)]) > 0, ]

#  Strip various strings from column names
colnames(t_mat) <- colnames(t_mat) %>%
    gsub("ovn", "", .)

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
    tibble::column_to_rownames("rownames")

if(samples %in% c(
    "Ovation", "Rrp6∆.G1-Q.N-SS", "Rrp6∆.G1-Q.SS", "Rrp6∆.Q.N-SS",
    "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS", "Nab3AID.Q.SS_Rrp6∆.Q.SS",
    "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"
)) {
     t_meta <- t_meta %>%
        dplyr::mutate(
            genotype = factor(genotype, levels = c("WT", "r6n", "od", "n3d")),
            
            state = factor(state, levels = c(
                "G1", "Q", "DSm2", "DSp2", "DSp24", "DSp48"
            )),
            
            transcription = factor(transcription, levels = c("N", "SS")),
            
            replicate = factor(replicate, levels = c("rep1", "rep2")),
            
            technical = factor(technical, levels = c("tech1", "tech2")),
            
            no_genotype = as.numeric(sapply( 
                as.character(genotype),
                switch,
                "WT" = 0,
                "r6n" = 1,
                "od" = 2,
                "n3d" = 3,
                USE.NAMES = FALSE
            )),
            
            no_state = as.numeric(sapply( 
                as.character(state),
                switch,
                "G1" = 0,
                "Q" = 1,
                "DSm2" = 2,
                "DSp2" = 3,
                "DSp24" = 4,
                "DSp48" = 5,
                USE.NAMES = FALSE
            )),
            
            no_transcription = as.numeric(sapply( 
                as.character(transcription),
                switch,
                "N" = 0,
                "SS" = 1,
                USE.NAMES = FALSE
            )),
            
            no_replicate = as.numeric(sapply( 
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                USE.NAMES = FALSE
            )),
            
            no_technical = as.numeric(sapply( 
                as.character(technical),
                switch,
                "tech1" = 0,
                "tech2" = 1,
                USE.NAMES = FALSE
            ))
        )
} else if(samples %in% c(
    "Rrp6∆.timecourse", "Rrp6∆.timecourse-G1-Q.SS", "Rrp6∆.timecourse-G1.SS",
    "Rrp6∆.timecourse-G1-Q.N-SS", "Rrp6∆.timecourse.G1-SS.Q-N"
)) {
    t_meta <- t_meta %>%
        dplyr::mutate(
            genotype = factor(genotype, levels = c("WT", "r6n")),
            
            state = factor(state, levels = c(
                "G1", "Q", "DSm2", "DSp2", "DSp24", "DSp48"
            )),
            
            transcription = factor(transcription, levels = c("N", "SS")),
            
            replicate = factor(replicate, levels = c("rep1", "rep2")),
            
            technical = factor(technical, levels = c("tech1", "tech2")),
            
            no_genotype = as.numeric(sapply( 
                as.character(genotype),
                switch,
                "WT" = 0,
                "r6n" = 1,
                USE.NAMES = FALSE
            )),
            
            no_state = as.numeric(sapply( 
                as.character(state),
                switch,
                "DSm2" = 0,
                "DSp2" = 1,
                "DSp24" = 2,
                "DSp48" = 3,
                "G1" = 4,
                "Q" = 5,
                USE.NAMES = FALSE
            )),
            
            no_transcription = as.numeric(sapply( 
                as.character(transcription),
                switch,
                "N" = 0,
                "SS" = 1,
                USE.NAMES = FALSE
            )),
            
            no_replicate = as.numeric(sapply( 
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                USE.NAMES = FALSE
            )),
            
            no_technical = as.numeric(sapply( 
                as.character(technical),
                switch,
                "tech1" = 0,
                "tech2" = 1,
                USE.NAMES = FALSE
            ))
        )
} else if(samples == "Nab3AID.Q.N-SS") {
    #  Create a metadata matrix for DESeq2, PCAtools, etc.
    t_meta <- t_meta %>%
        dplyr::mutate(
            genotype = factor(genotype, levels = c("od", "n3d")),
            
            state = factor(state, levels = "Q"),
            
            transcription = factor(transcription, levels = c("N", "SS")),
            
            replicate = factor(replicate, levels = c("rep1", "rep2")),
            
            technical = factor(technical, levels = "tech1"),
            
            no_genotype = as.numeric(sapply( 
                as.character(genotype),
                switch,
                "od" = 0,
                "n3d" = 1,
                USE.NAMES = FALSE
            )),
            
            no_state = as.numeric(sapply( 
                as.character(state),
                switch,
                "Q" = 0,
                USE.NAMES = FALSE
            )),
            
            no_transcription = as.numeric(sapply( 
                as.character(transcription),
                switch,
                "N" = 0,
                "SS" = 1,
                USE.NAMES = FALSE
            )),
            
            no_replicate = as.numeric(sapply( 
                as.character(replicate),
                switch,
                "rep1" = 0,
                "rep2" = 1,
                USE.NAMES = FALSE
            )),
            
            no_technical = as.numeric(sapply( 
                as.character(technical),
                switch,
                "tech1" = 0,
                USE.NAMES = FALSE
            ))
        )
}

#  Add columns of combined variables
t_meta <- t_meta %>%
    dplyr::mutate(
        gt_st = factor(paste(genotype, state, sep = "_")),
        gt_tx = factor(paste(genotype, transcription, sep = "_")),
        st_tx = factor(paste(state, transcription, sep = "_")),
        gt_st_tx = factor(paste(genotype, state, transcription, sep = "_")),
    ) %>%
    dplyr::relocate(c(gt_st, gt_tx, st_tx, gt_st_tx), .before = genotype)

#  Drop any unused factor levels
t_meta$genotype <- forcats::fct_drop(t_meta$genotype)
t_meta$state <- forcats::fct_drop(t_meta$state)
t_meta$transcription <- forcats::fct_drop(t_meta$transcription)
t_meta$replicate <- forcats::fct_drop(t_meta$replicate)
t_meta$technical <- forcats::fct_drop(t_meta$technical)


#  Add extra model variables for certain experiments --------------------------
#+ ...in particular, those that involve both Rrp6∆ and Nab3-AID 
if(samples %in% c(
    "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS", "Nab3AID.Q.SS_Rrp6∆.Q.SS",
    "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"
)) {
    t_meta <- t_meta %>%
        dplyr::mutate(
            day = factor(
                ifelse(
                    stringr::str_detect(
                        rownames(t_meta), "n3d|od"
                    ),
                    "day7",
                    ifelse(
                        stringr::str_detect(
                            rownames(t_meta), "DSm2_|DSp2_"
                        ),
                        "day2",
                        ifelse(
                            stringr::str_detect(
                                rownames(t_meta), "DSp24_"
                            ),
                            "day3",
                            ifelse(
                                stringr::str_detect(
                                    rownames(t_meta), "DSp48_"
                                ),
                                "day4",
                                ifelse(
                                    stringr::str_detect(
                                        rownames(t_meta), "r6n_G1|WT_G1"
                                    ),
                                    "day1",
                                    ifelse(
                                        stringr::str_detect(
                                            rownames(t_meta), "r6n_Q|WT_Q"
                                        ),
                                        "day8",
                                        NA_character_
                                    )
                                )
                            )
                        )
                    )
                ),
                levels = c("day7", "day1", "day8", "day2", "day3", "day4")
            ),
            
            no_day = as.numeric(sapply( 
                as.character(day),
                switch,
                "day7" = 0,
                "day1" = 1,
                "day8" = 2,
                "day2" = 3,
                "day3" = 4,
                "day4" = 5,
                USE.NAMES = FALSE
            )),
            
            aux = factor(
                ifelse(
                    stringr::str_detect(rownames(t_meta), "n3d|od"),
                    TRUE,
                    FALSE
                ),
                levels = c("TRUE", "FALSE")
            ),
            
            no_aux = as.numeric(sapply( 
                as.character(aux),
                switch,
                "TRUE" = 0,
                "FALSE" = 1,
                USE.NAMES = FALSE
            )),
            
            tc = factor(
                ifelse(
                    stringr::str_detect(rownames(t_meta), "DS"),
                    TRUE,
                    FALSE
                ),
                levels = c("TRUE", "FALSE")
            ),
            
            no_tc = as.numeric(sapply( 
                as.character(tc),
                switch,
                "TRUE" = 0,
                "FALSE" = 1,
                USE.NAMES = FALSE
            ))
        ) %>%
        dplyr::relocate(c(day, aux, tc), .after = technical)
    
    #  Drop any unused factor levels
    t_meta$day <- forcats::fct_drop(t_meta$day)
    t_meta$aux <- forcats::fct_drop(t_meta$aux)
    t_meta$tc <- forcats::fct_drop(t_meta$tc)
}


#  Make a GRanges object for positional information for DESeq2, etc. ----------
g_pos <- GenomicRanges::GRanges(
    seqnames = t_mat$chr,
    ranges = IRanges::IRanges(t_mat$start, t_mat$end),
    strand = t_mat$strand,
    length = t_mat$width,
    type = t_mat$type,
    features = t_mat$features,
    biotype = t_mat$biotype,
    names = t_mat$names,
    genome = t_mat$genome
)

run <- FALSE
if(base::isTRUE(run)) {
    g_pos %>% print()
    cat("\n")
    g_pos %>% as.data.frame() %>% tibble::as_tibble() %>% print()
}


#  Make a counts matrix for DESeq2, etc. --------------------------------------
t_counts <- t_mat[, 12:ncol(t_mat)] %>%
    sapply(., as.integer) %>%
    as.data.frame()


#  Perform either TPM or rlog normalization -----------------------------------
if(run_norm %notin% c("rlog", "tpm")) {
    stop(paste(
        "Argument \"run_norm\" must be \"rlog\" or \"tpm\". Stopping the",
        "script."
    ))
}

if(run_norm == "tpm") {
    #  Make the dds object --------------------------------
    dds <- DESeq2::DESeqDataSetFromMatrix(
        countData = t_counts,
        colData = t_meta,
        design = ~1,
        rowRanges = g_pos
    )
    
    #  Isolate raw S. cerevisiae counts -------------------
    counts_raw <- dds[dds@rowRanges$genome == "S_cerevisiae", ] %>%
        SummarizedExperiment::assay() %>%
        as.data.frame()
    counts_raw$features <- dds@rowRanges$features[
        dds@rowRanges$genome == "S_cerevisiae"
    ]

    #  Associate counts with feature metadata
    counts_raw <- dplyr::full_join(
        dplyr::filter(t_mat, genome == "S_cerevisiae")[, 1:11],
        counts_raw,
        by = "features"
    )
    
    #  Calculate counts per kb of feature length (i.e., correct counts for
    #+ feature length with an "RPK normalization"); then, divide RPK-normalized
    #+ elements by the sum of sample RPK divided by one million: this is what
    #+ facilitates the actual TPM normalization
    length <- (counts_raw$end - counts_raw$start) + 1
    rpk <- counts_raw[, 12:ncol(counts_raw)] / length
    tpm <- t((t(rpk) * 1e6) / colSums(rpk)) %>% tibble::as_tibble()
    
    norm_t <- dplyr::bind_cols(counts_raw[, 1:11], tpm)
    rm(length, counts_raw, rpk, tpm)
    
    #  Set up counts, feature IDs for PCAtools::pca() --
    pca_counts <- norm_t %>%
        dplyr::select(12:ncol(norm_t)) %>%
        dplyr::mutate_if(is.character, as.numeric)
    pca_feat_id <- ifelse(
        is.na(dplyr::filter(norm_t)$names),
        dplyr::filter(norm_t)$features,
        dplyr::filter(norm_t)$names
    ) %>%
        make.unique()
} else if(run_norm == "rlog") {
    #  Make the dds object --------------------------------
    use_model <- FALSE
    if(base::isTRUE(use_model)) {
        if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
            dds <- DESeq2::DESeqDataSetFromMatrix(
                countData = t_counts,
                colData = t_meta,
                design = ~technical + genotype,
                rowRanges = g_pos
            )
        } else {
            dds <- DESeq2::DESeqDataSetFromMatrix(
                countData = t_counts,
                colData = t_meta,
                design = ~1,
                rowRanges = g_pos
            )
        }
    } else {
        dds <- DESeq2::DESeqDataSetFromMatrix(
            countData = t_counts,
            colData = t_meta,
            design = ~1,
            rowRanges = g_pos
        )
    }
    
    #  Do size-factor estimation --------------------------
    if(samples %in% c(
        "Ovation", "test.Ovation_Rrp6∆", "test.Ovation_Tecan", "Rrp6∆",
        "Rrp6∆.timecourse-G1-Q.SS", "Rrp6∆.timecourse-G1.SS",
        "Rrp6∆.timecourse-G1-Q.N-SS", "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS",
        "Nab3AID.Q.SS_Rrp6∆.Q.SS",
        "Nab3AID.Q.N-SS_Rrp6∆.timecourse-G1-Q.N-SS"
    )) {
        use_KL <- FALSE
    } else {
        use_KL <- TRUE
    }
    
    if(base::isTRUE(use_KL)) {
        dds <- BiocGenerics::estimateSizeFactors(
            dds,
            controlGenes = (dds@rowRanges$genome == "K_lactis")
        )
    } else {
        dds <- BiocGenerics::estimateSizeFactors(dds)
    }
    
    sf <- dds$sizeFactor %>% as.data.frame()
    sf_recip <- (1 / dds$sizeFactor) %>% as.data.frame()
    
    #  Perform rlog transformation ------------------------
    rld <- DESeq2::rlog(
        dds[dds@rowRanges$genome == "S_cerevisiae", ],
        blind = FALSE
    )
    
    #  Remove batch effects in some samples ---------------
    if(base::isTRUE(run_batch_correction)) {
        if(samples %in% c(
            "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS", "Nab3AID.Q.SS_Rrp6∆.Q.SS"
        )) {
            norm_r <- limma::removeBatchEffect(
                SummarizedExperiment::assay(rld),
                batch = rld$aux,
                design = model.matrix(
                    ~1,
                    SummarizedExperiment::colData(rld)[
                        , colnames(SummarizedExperiment::colData(rld)) %in% c(
                            "genotype", "state", "transcription", "replicate",
                            "technical", "tc"
                        )
                    ]
                )
            ) %>%
                as.data.frame()
        } else if(samples %in% c(
            "Rrp6∆.timecourse-G1-Q.SS", "Rrp6∆.timecourse-G1.SS",
            "Rrp6∆.timecourse-G1-Q.N-SS"
        )) {
            norm_r <- limma::removeBatchEffect(
                SummarizedExperiment::assay(rld),
                batch = rld$technical,
                design = model.matrix(
                    ~1,
                    SummarizedExperiment::colData(rld)[
                        , colnames(SummarizedExperiment::colData(rld)) %in%
                            c("genotype", "state", "transcription", "replicate")
                    ]
                )
            ) %>%
                as.data.frame()
        } else {
            norm_r <- SummarizedExperiment::assay(rld) %>% as.data.frame()
        }
    } else {
        norm_r <- SummarizedExperiment::assay(rld) %>% as.data.frame()
    }
    
    norm_r$features <- dds@rowRanges$features[
        dds@rowRanges$genome == "S_cerevisiae"
    ]
    
    #  Associate normalized counts with feature metadata
    norm_r <- dplyr::full_join(
        dplyr::filter(t_mat, genome == "S_cerevisiae")[, 1:11],
        norm_r,
        by = "features"
    )
    
    #  Set up counts, feature IDs for PCAtools::pca() --
    pca_counts <- norm_r %>%
        dplyr::select(12:ncol(norm_r)) %>%
        dplyr::mutate_if(is.character, as.numeric)
    pca_feat_id <- ifelse(
        is.na(dplyr::filter(norm_r)$names),
        dplyr::filter(norm_r)$features,
        dplyr::filter(norm_r)$names
    ) %>%
        make.unique()
}


#SHORTCUT
#  Run PCA ====================================================================
if(base::isTRUE(run_PCA)) {
    if(run_norm == "rlog") {
        input_counts <- pca_counts
    } else {
        #  Transform TPM values: log2(TPM + 1)
        input_counts <- dplyr::mutate_if(pca_counts + 1, is.numeric, log2)
    }
    
    if(samples %in% c(
        "Rrp6∆.timecourse-G1.SS", "Rrp6∆.timecourse-G1-Q.SS",
        "Rrp6∆.timecourse.G1-SS.Q-N"
    )) {
        meta_color <- "genotype"
        meta_shape <- "state"
    } else if (samples == "Nab3AID.Q.N-SS_Rrp6∆.Q.N-SS") {
        meta_color <- "gt_st"
        meta_shape <- "transcription"
    } else if(samples == "Nab3AID.Q.SS_Rrp6∆.Q.SS") {
        meta_color <- "genotype"
        meta_shape <- "replicate"
    } else {
        meta_color <- "state"
        meta_shape <- "transcription"
    }
    
    #TODO Should this reordering of levels for "Rrp6∆.timecourse-G1-Q.SS" be
    #     somewhere up above?
    if(samples == "Rrp6∆.timecourse-G1-Q.SS") {
        t_meta$state <- factor(
            t_meta$state,
            levels = c("G1", "DSm2", "DSp2", "DSp24", "DSp48", "Q")
        )
        
        t_meta$period_start_end <- t_meta$state %>%
            gsub("G1$|DSm2$", "early", .) %>%
            gsub("DSp2$|DSp24$", "mid", .) %>%
            gsub("DSp48$|Q$", "late", .)
        t_meta$period_start_end <- factor(
            t_meta$period_start_end, levels = c("early", "mid", "late")
        )
        t_meta$no_period_start_end <- t_meta$period_start_end %>%
            gsub("early", 0, .) %>%
            gsub("mid", 1, .) %>%
            gsub("late", 2, .)
        
        t_meta$period_middle <- t_meta$state %>%
            gsub("G1$|DSm2$|DSp48$|Q$", "early_late", .) %>%
            gsub("DSp2$|DSp24$", "mid", .)
        t_meta$period_middle <- factor(
            t_meta$period_middle, levels = c("early_late", "mid")
        )
        t_meta$no_period_middle <- t_meta$period_middle %>%
            gsub("early_late", 0, .) %>%
            gsub("mid", 1, .)
    }
    
    if(samples == "Ovation") {
        shape_key <- c(N = 16, SS = 7)
    } else {
        shape_key <- NULL
    }
    
    pca_exp <- run_PCA_pipeline(
        counts = input_counts,
        metadata = t_meta,
        feat_id = pca_feat_id,
        x_min_biplot = ifelse(run_norm == "rlog", -100, -125),
        x_max_biplot = ifelse(run_norm == "rlog", 100, 125),
        y_min_biplot = ifelse(run_norm == "rlog", -100, -125),
        y_max_biplot = ifelse(run_norm == "rlog", 100, 125),
        x_min_loadings_plot = ifelse(run_norm == "rlog", -0.1, -0.1),
        x_max_loadings_plot = ifelse(run_norm == "rlog", 0.1, 0.1),
        y_min_loadings_plot = ifelse(run_norm == "rlog", -0.1, -0.1),
        y_max_loadings_plot = ifelse(run_norm == "rlog", 0.1, 0.1),
        n_loadings = 10L,
        x_pos_nudge_x = ifelse(samples == "Ovation", 0.04, 0.04),
        y_pos_nudge_x = ifelse(samples == "Ovation", 0, 0),
        x_neg_nudge_x = ifelse(samples == "Ovation", -0.04, -0.04),
        y_neg_nudge_x = ifelse(samples == "Ovation", -0.02, -0.02),
        x_pos_nudge_y = ifelse(samples == "Ovation", 0, 0),
        y_pos_nudge_y = ifelse(samples == "Ovation", 0.04, 0.04),
        x_neg_nudge_y = ifelse(samples == "Ovation", 0, 0),
        y_neg_nudge_y = ifelse(samples == "Ovation", -0.04, -0.04),
        meta_color = meta_color,
        meta_shape = meta_shape,
        shape_key = shape_key,
        plot_loadings_pct = FALSE,
        drop_md_levels = c("gt_st", "gt_tx", "st_tx", "gt_st_tx", "tc", "day"),
        PCs_cor_plot = ifelse(
            samples == "Ovation",
            3,
            ifelse(
                samples == "Rrp6∆.timecourse-G1-Q.SS",
                4,
                NULL
            )
        )
    )
}

run <- FALSE
if(base::isTRUE(run)) {
    # pca_exp$`02_horn`$n %>% print()
    # pca_exp$`03_elbow` %>% as.numeric() %>% print()
    pca_exp$`04_p_scree` %>% print()
    pca_exp$`12_p_cor` %>% print()
    
    # pca_exp$`10_p_images`$PCAtools.PC2.v.PC5 %>% print()
    # pca_exp$`10_p_images`$PCAtools.PC2.v.PC4
    pca_exp$`10_p_images`$PCAtools.PC2.v.PC3 %>% print()
    # pca_exp$`10_p_images`$PCAtools.PC1.v.PC5 %>% print()
    # pca_exp$`10_p_images`$PCAtools.PC1.v.PC4 %>% print()
    pca_exp$`10_p_images`$PCAtools.PC1.v.PC3 %>% print()
    pca_exp$`10_p_images`$PCAtools.PC1.v.PC2 %>% print()
    
    pca_exp$`10_p_images`$KA.PC2.v.PC3[["all"]] %>% print()
    pca_exp$`10_p_images`$KA.PC1.v.PC3[["all"]] %>% print()
    pca_exp$`10_p_images`$KA.PC1.v.PC2[["all"]] %>% print()
}

if(base::isTRUE(write_norm_counts_rds)) {
    if(base::isTRUE(exists("norm_r"))) {
        to_plot <- norm_r
        suffix <- ".counts-rlog.tsv"
    } else {
        to_plot <- norm_t
        suffix <- ".counts-TPM.tsv"
    }
    
    readr::write_tsv(
        to_plot,
        paste0(
            getwd(), "/",
            "data.", date, "__",
            samples, "__",
            type, suffix
        )
    )
}

#TODO Functionalize this code
if(base::isTRUE(write_PCA_results)) {
    # pca_exp$`02_horn`$n %>% print()
    # pca_exp$`03_elbow` %>% as.numeric() %>% print()
    
    run <- TRUE
    if(base::isTRUE(run)) {
        pca_exp$`04_p_scree` %>% print()
        ggsave(paste0(
            getwd(), "/",
            "PCA.", date, "__",
            samples, "__",
            type, ".scree.png"
        ))
    }
    
    
    run <- TRUE
    if(base::isTRUE(run)) {
        if(pca_exp$`03_elbow` >= 2) {
            #  PC1: Generate loading vector and feature lists
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`08_top_loadings_pos`$PC1 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC1-pos.tsv"
                    ))
                pca_exp$`09_top_loadings_neg`$PC1 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC1-neg.tsv"
                    ))
                
                run <- TRUE
                if(base::isTRUE(run)) {
                    #  Use "Y" gene names in lists for GO analyses
                    pca_exp$`08_top_loadings_pos`$PC1 <-
                        pca_exp$`08_top_loadings_pos`$PC1 %>%
                        tibble::rownames_to_column("thorough")
                    pca_exp$`09_top_loadings_neg`$PC1 <-
                        pca_exp$`09_top_loadings_neg`$PC1 %>%
                        tibble::rownames_to_column("thorough")
                    
                    if(run_norm == "rlog") {
                        pca_exp$`08_top_loadings_pos`$PC1 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC1,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC1 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC1,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                    } else {
                        pca_exp$`08_top_loadings_pos`$PC1 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC1,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC1 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC1,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                    }
                    
                    for(i in c(100, 200, 500)) {
                        pca_exp$`08_top_loadings_pos`$PC1 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC1-pos.tsv"
                            ))
                        pca_exp$`09_top_loadings_neg`$PC1 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC1-neg.tsv"
                            ))
                    }
                }
            }
            
            #  PC2: Generate loading vector and feature lists
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`08_top_loadings_pos`$PC2 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC2-pos.tsv"
                    ))
                pca_exp$`09_top_loadings_neg`$PC2 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC2-neg.tsv"
                    ))
                
                run <- TRUE
                if(base::isTRUE(run)) {
                    #  Use "Y" gene names in lists for GO analyses
                    pca_exp$`08_top_loadings_pos`$PC2 <-
                        pca_exp$`08_top_loadings_pos`$PC2 %>%
                        tibble::rownames_to_column("thorough")
                    pca_exp$`09_top_loadings_neg`$PC2 <-
                        pca_exp$`09_top_loadings_neg`$PC2 %>%
                        tibble::rownames_to_column("thorough")
                    
                    if(run_norm == "rlog") {
                        pca_exp$`08_top_loadings_pos`$PC2 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC2,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC2 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC2,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                    } else {
                        pca_exp$`08_top_loadings_pos`$PC2 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC2,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC2 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC2,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                    }
                    
                    for(i in c(100, 200, 500)) {
                        pca_exp$`08_top_loadings_pos`$PC2 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC2-pos.tsv"
                            ))
                        pca_exp$`09_top_loadings_neg`$PC2 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC2-neg.tsv"
                            ))
                    }
                }
            }
            
            #  PC1 vs PC2: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC1.v.PC2 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC1-vs-PC2.png"
                ))
            }
            
            #  PC1 vs PC2: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC1.v.PC2[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC1-vs-PC2.all.png"
                ))
            }
        }
        
        if(pca_exp$`03_elbow` >= 3) {
            #  PC3: Generate loading vector and feature lists
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`08_top_loadings_pos`$PC3 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC3-pos.tsv"
                    ))
                pca_exp$`09_top_loadings_neg`$PC3 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC3-neg.tsv"
                    ))
                
                run <- TRUE
                if(base::isTRUE(run)) {
                    #  Use "Y" gene names in lists for GO analyses
                    pca_exp$`08_top_loadings_pos`$PC3 <-
                        pca_exp$`08_top_loadings_pos`$PC3 %>%
                        tibble::rownames_to_column("thorough")
                    pca_exp$`09_top_loadings_neg`$PC3 <-
                        pca_exp$`09_top_loadings_neg`$PC3 %>%
                        tibble::rownames_to_column("thorough")
                    
                    if(run_norm == "rlog") {
                        pca_exp$`08_top_loadings_pos`$PC3 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC3,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC3 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC3,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                    } else {
                        pca_exp$`08_top_loadings_pos`$PC3 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC3,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC3 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC3,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                    }

                    for(i in c(100, 200, 500)) {
                        pca_exp$`08_top_loadings_pos`$PC3 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC3-pos.tsv"
                            ))
                        pca_exp$`09_top_loadings_neg`$PC3 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC3-neg.tsv"
                            ))
                    }
                }
            }
            
            #  PC1 vs PC3: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC1.v.PC3 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC1-vs-PC3.png"
                ))
            }
            
            #  PC1 vs PC3: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC1.v.PC3[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC1-vs-PC3.all.png"
                ))
            }
            
            #  PC2 vs PC3: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC2.v.PC3 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC2-vs-PC3.png"
                ))
            }
            
            #  PC2 vs PC3: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC2.v.PC3[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC2-vs-PC3.all.png"
                ))
            }
        }
        
        if(pca_exp$`03_elbow` >= 4) {
            #  PC4: Generate loading vector and feature lists
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`08_top_loadings_pos`$PC4 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC4-pos.tsv"
                    ))
                pca_exp$`09_top_loadings_neg`$PC4 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC4-neg.tsv"
                    ))
                
                run <- TRUE
                if(base::isTRUE(run)) {
                    #  Use "Y" gene names in lists for GO analyses
                    pca_exp$`08_top_loadings_pos`$PC4 <-
                        pca_exp$`08_top_loadings_pos`$PC4 %>%
                        tibble::rownames_to_column("thorough")
                    pca_exp$`09_top_loadings_neg`$PC4 <-
                        pca_exp$`09_top_loadings_neg`$PC4 %>%
                        tibble::rownames_to_column("thorough")
                    
                    if(run_norm == "rlog") {
                        pca_exp$`08_top_loadings_pos`$PC4 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC4,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC4 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC4,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                    } else {
                        pca_exp$`08_top_loadings_pos`$PC4 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC4,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC4 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC4,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                    }

                    for(i in c(100, 200, 500)) {
                        pca_exp$`08_top_loadings_pos`$PC4 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC4-pos.tsv"
                            ))
                        pca_exp$`09_top_loadings_neg`$PC4 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC4-neg.tsv"
                            ))
                    }
                }
            }
            
            #  PC1 vs PC4: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC1.v.PC4 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC1-vs-PC4.png"
                ))
            }
            
            #  PC1 vs PC4: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC1.v.PC4[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC1-vs-PC4.all.png"
                ))
            }
            
            #  PC2 vs PC4: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC2.v.PC4 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC2-vs-PC4.png"
                ))
            }
            
            #  PC2 vs PC4: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC2.v.PC4[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC2-vs-PC4.all.png"
                ))
            }
        
            #  PC3 vs PC4: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC3.v.PC4 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC3-vs-PC4.png"
                ))
            }
            
            #  PC3 vs PC4: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC3.v.PC4[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC3-vs-PC4.all.png"
                ))
            }
        }
        
        if(pca_exp$`03_elbow` >= 5) {
            #  PC5: Generate loading vector and feature lists
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`08_top_loadings_pos`$PC5 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC5-pos.tsv"
                    ))
                pca_exp$`09_top_loadings_neg`$PC5 %>%
                    tibble::rownames_to_column() %>%
                    readr::write_tsv(paste0(
                        getwd(), "/",
                        "PCA.", date, "__",
                        samples, "__",
                        type, ".loadings-list.PC5-neg.tsv"
                    ))
                
                run <- TRUE
                if(base::isTRUE(run)) {
                    #  Use "Y" gene names in lists for GO analyses
                    pca_exp$`08_top_loadings_pos`$PC5 <-
                        pca_exp$`08_top_loadings_pos`$PC5 %>%
                        tibble::rownames_to_column("thorough")
                    pca_exp$`09_top_loadings_neg`$PC5 <-
                        pca_exp$`09_top_loadings_neg`$PC5 %>%
                        tibble::rownames_to_column("thorough")
                    
                    if(run_norm == "rlog") {
                        pca_exp$`08_top_loadings_pos`$PC5 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC5,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC5 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC5,
                                norm_r[, c(8, 11)],
                                by = "thorough"
                            )
                    } else {
                        pca_exp$`08_top_loadings_pos`$PC5 <-
                            dplyr::full_join(
                                pca_exp$`08_top_loadings_pos`$PC5,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                        pca_exp$`09_top_loadings_neg`$PC5 <-
                            dplyr::full_join(
                                pca_exp$`09_top_loadings_neg`$PC5,
                                norm_t[, c(8, 11)],
                                by = "thorough"
                            )
                    }

                    for(i in c(100, 200, 500)) {
                        pca_exp$`08_top_loadings_pos`$PC5 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC5-pos.tsv"
                            ))
                        pca_exp$`09_top_loadings_neg`$PC5 %>%
                            tibble::rownames_to_column() %>%
                            dplyr::select("features") %>%
                            head(i) %>%
                            readr::write_tsv(paste0(
                                getwd(), "/",
                                "PCA.", date, "__",
                                samples, "__",
                                type, ".feature-list-", i,".PC5-neg.tsv"
                            ))
                    }
                }
            }
            
            #  PC1 vs PC5: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC1.v.PC5 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC1-vs-PC5.png"
                ))
            }
            
            #  PC1 vs PC5: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC1.v.PC5[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC1-vs-PC5.all.png"
                ))
            }
            
            #  PC2 vs PC5: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC2.v.PC5 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC2-vs-PC5.png"
                ))
            }
            
            #  PC2 vs PC5: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC2.v.PC5[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC2-vs-PC5.all.png"
                ))
            }

            #  PC3 vs PC5: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC3.v.PC5 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC3-vs-PC5.png"
                ))
            }
            
            #  PC3 vs PC5: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC3.v.PC5[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC3-vs-PC5.all.png"
                ))
            }

            #  PC4 vs PC5: Biplot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$PCAtools.PC4.v.PC5 %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".biplot.PC4-vs-PC5.png"
                ))
            }
            
            #  PC4 vs PC5: Loading vector plot
            run <- TRUE
            if(base::isTRUE(run)) {
                pca_exp$`10_p_images`$KA.PC4.v.PC5[["all"]] %>% print()
                ggsave(paste0(
                    getwd(), "/",
                    "PCA.", date, "__",
                    samples, "__",
                    type, ".loading-vector-plot.PC4-vs-PC5.all.png"
                ))
            }
        }
    }

    run <- TRUE
    if(base::isTRUE(run)) {
        png(
            width = 800,
            height = 638,
            units = "px",
            filename = paste0(
                getwd(), "/",
                "PCA.", date, "__",
                samples, "__",
                type, ".correlation.png"
            )
        )
        pca_exp$`12_p_cor` %>% print()
        dev.off()
    }
}

figure <- 2
# figure <- 5
if(base::isTRUE(write_pdfs)) {
    if(figure == 2) {
        width <- 10
        height <- 6
        outfile <- paste0(
            getwd(), "/", "PCA-Fig2A.", date, "__", samples, "__", type,
            ".scree.pdf"
        )
        pdf(file = outfile, width = width, height = height)
        pca_exp$`04_p_scree` %>% print()
        dev.off()
        
        width <- 8
        height <- 7
        outfile <- paste0(
            getwd(), "/", "PCA-Fig2A.", date, "__", samples, "__", type,
            ".correlation.pdf"
        )
        pdf(file = outfile, width = width, height = height)
        pca_exp$`12_p_cor` %>% print()
        dev.off()
        
        outfile <- paste0(
            getwd(), "/", "PCA-Fig2A.", date, "__", samples, "__", type,
            ".biplot.PC1-vs-PC2.pdf"
        )
        pdf(file = outfile, width = width, height = height)
        pca_exp$`10_p_images`$PCAtools.PC1.v.PC2 %>% print()
        dev.off()
        
        outfile <- paste0(
            getwd(), "/", "PCA-Fig2A.", date, "__", samples, "__", type,
            ".biplot.PC1-vs-PC3.pdf"
        )
        pdf(file = outfile, width = width, height = height)
        pca_exp$`10_p_images`$PCAtools.PC1.v.PC3 %>% print()
        dev.off()
        
        outfile <- paste0(
            getwd(), "/", "PCA-Fig2A.", date, "__", samples, "__", type,
            ".biplot.PC2-vs-PC3.pdf"
        )
        pdf(file = outfile, width = width, height = height)
        pca_exp$`10_p_images`$PCAtools.PC2.v.PC3 %>% print()
        dev.off()
    } else if(figure == 5) {
        outfile <- "PCA-Fig5A.2023-0626.PC1-vs-PC2.pdf"
        pdf(file = outfile, width = width, height = height)
        pca_exp$`10_p_images`$PCAtools.PC1.v.PC2 %>% print()
        dev.off()
        
        outfile <- "PCA-Fig5A.2023-0626.PC1-vs-PC3.pdf"
        pdf(file = outfile, width = width, height = height)
        pca_exp$`10_p_images`$PCAtools.PC1.v.PC3 %>% print()
        dev.off()
        
        outfile <- "PCA-Fig5A.2023-0626.PC2-vs-PC3.pdf"
        pdf(file = outfile, width = width, height = height)
        pca_exp$`10_p_images`$PCAtools.PC2.v.PC3 %>% print()
        dev.off()
    }
}
