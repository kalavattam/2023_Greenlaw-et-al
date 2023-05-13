#!/usr/bin/Rscript

#  rough-draft_timecourse-samples_scaled-coverage_DGE_PCA.R
#  KA

library(DESeq2)
library(GenomicRanges)
library(limma)
library(PCAtools)
library(rtracklayer)
library(tidyverse)

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


#  Get situated, load counts matrix -------------------------------------------
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

#  Remove unneeded variables again
rm(chr_20S, chr_KL, chr_SC, chr_order)


#  Subset t_mat for timecourse counts data ------------------------------------
t_tc <- dplyr::bind_cols(
    t_mat[, 1:10],
    t_mat[,
        stringr::str_detect(colnames(t_mat), "tc-T") &
        !stringr::str_detect(colnames(t_mat), "t4")
    ]
) 

#  Exclude 20S and htseq-count "summary values" from timecourse tibble
t_tc <- t_tc %>% dplyr::slice(1:(n() - 6))

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

colnames(t_tc)[11:ncol(t_tc)] <- better_sample_names
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
t_meta <- colnames(t_tc)[11:ncol(t_tc)] %>%
    stringr::str_split("_") %>%
    as.data.frame() %>%
    t() %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    dplyr::rename(
        genotype = ...1, time = ...2, replicate = ...3, technical = ...4
    ) %>%
    dplyr::mutate(rownames = colnames(t_tc)[11:ncol(t_tc)]) %>%
    tibble::column_to_rownames("rownames") %>%  # DESeq2 requires rownames
    dplyr::mutate(
        genotype = factor(genotype, level = c("WT", "r6n")),
        no_genotype = sapply(
            as.character(genotype),
            switch,
            "WT" = 1,
            "r6n" = 2,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        time = factor(time, levels = c("DSm2", "DSp2", "DSp24", "DSp48")),
        no_time = sapply(
            as.character(time),
            switch,
            "DSm2" = 1,
            "DSp2" = 2,
            "DSp24" = 3,
            "DSp48" = 4,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        replicate = factor(replicate, levels = c("rep1", "rep2")),
        no_replicate = sapply(
            as.character(replicate),
            switch,
            "rep1" = 1,
            "rep2" = 2,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        technical = factor(technical, levels = c("tech1", "tech2")),
        no_technical = sapply(
            as.character(technical),
            switch,
            "tech1" = 1,
            "tech2" = 2,
            USE.NAMES = FALSE
        ) %>%
            as.factor()
    )

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
t_counts <- t_tc[, 11:ncol(t_tc)] %>%
    sapply(., as.integer) %>%
    as.data.frame()

#  Make the dds object; however, don't do any modeling yet
dds <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts,
    colData = t_meta,
    design = ~1,
    rowRanges = g_pos
)

#  Do size-factor estimation using K. lactis control genes
dds <- BiocGenerics::estimateSizeFactors(
    # dds[dds@rowRanges$genome == "K_lactis", ]
    dds,
    controlGenes = (dds@rowRanges$genome == "K_lactis")
)
dds$sizeFactor %>% as.data.frame()
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

#  And the reciprocal...
(1 / dds$sizeFactor) %>% as.data.frame()
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


#  Run pairwise DGE analyses by timepoint -------------------------------------
#  DSm2 -------------------------------
#  Adjust counts and metadata matrices
t_counts_DSm2 <- t_counts[, colnames(t_counts) %>% stringr::str_detect("DSm2_")]
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


#  DSp2 -------------------------------
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


#  DSp24 -------------------------------
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


#  DSp48 -------------------------------
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
        "\n| left: up in WT",
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


results_DSm2 <- call_DESeq2_results_plot_volcano(dds_DSm2)
results_DSp2 <- call_DESeq2_results_plot_volcano(dds_DSp2)
results_DSp24 <- call_DESeq2_results_plot_volcano(dds_DSp24)
results_DSp48 <- call_DESeq2_results_plot_volcano(dds_DSp48)

# results_DSm2[["11_p"]]
# results_DSp2[["11_p"]]
# results_DSp24[["11_p"]]
# results_DSp48[["11_p"]]


#  Run PCA with non-normalized and rlog-normalized counts ---------------------
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
            theme_slick
    
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
        ggplot2::theme(axis.text.x = element_text(angle = 90, hjust = 1))

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
            x_min_biplot <- -100 # -200  #ARGUMENT?
            x_max_biplot <- 100 # 200  #ARGUMENT?
            y_min_biplot <- -100 # -200  #ARGUMENT?
            y_max_biplot <- 100 # 200  #ARGUMENT?
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
        theme_slick_no_legend
    p_loadings
    #TODO Work up some logic for saving the plot
    
    
    #  Evaluate correlations between PCs and model variables; answer
    #+ the question, "What is driving biologically significant variance
    #+ in our data?"
    p_cor <- PCAtools::eigencorplot(
        pca,
        components = PCAtools::getComponents(pca, 1:8),
        metavars = if(transcription == FALSE) {
            c("genotype", "time", "replicate", "technical")
        } else if(transcription == TRUE) {
            c("genotype", "time", "transcription", "replicate", "technical")
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

t_tc_SC <- t_tc %>%
    dplyr::filter(genome == "S_cerevisiae")
gene_id <- ifelse(is.na(t_tc_SC$names), t_tc_SC$features, t_tc_SC$names) %>%
    make.unique()

counts_raw <- t_tc_SC %>%
    dplyr::select(11:ncol(t_tc_SC)) %>%
    dplyr::mutate_if(is.character, as.numeric)
pca_exp_raw <- run_PCA_pipeline(
    counts = counts_raw,
    metadata = t_meta,
    gene_id = gene_id,
    transformed = FALSE
)
# pca_exp_raw[["02_horn"]]$n
# pca_exp_raw[["03_elbow"]]
# pca_exp_raw[["04_p_scree"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# pca_exp_raw[["10_p_images"]][["KA.PC1.v.PC2"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# pca_exp_raw[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# pca_exp_raw[["12_p_cor"]]


# #  TESTING --------------------------------------------------------------------
# # SummarizedExperiment::colData(dds)[17, 4] <- "tech1"  #TEST To reproduce how I originally did this work
# # t_meta[17, 4] <- "tech1"  #TEST To reproduce how I originally did this work
# rld <- DESeq2::vst(
#     dds[dds@rowRanges$genome == "S_cerevisiae", ],
#     blind = FALSE
# )
# norm_r <- limma::removeBatchEffect(
#     SummarizedExperiment::assay(rld),
#     batch = rld$ntechnical,
#     design = model.matrix(~genotype, SummarizedExperiment::colData(rld))
# ) %>% 
#     as.data.frame()
# norm_r$features <- dds@rowRanges$features[
#     dds@rowRanges$genome == "S_cerevisiae"
# ]
# norm_r <- dplyr::full_join(
#     norm_r,
#     t_tc_SC[, 1:9],
#     by = "features"
# ) %>%
#     dplyr::as_tibble() %>%
#     dplyr::relocate(18:26, .before = WT_DSm2_rep1_tech1)
# 
# counts_rlog <- norm_r %>%
#     dplyr::select(10:ncol(norm_r)) %>%
#     dplyr::mutate_if(is.character, as.numeric)
# pca_exp_rlog <- run_PCA_pipeline(
#     counts = counts_rlog,
#     metadata = t_meta,
#     gene_id = gene_id,
#     transformed = TRUE
# )
# pca_exp_rlog[["02_horn"]]$n
# pca_exp_rlog[["03_elbow"]]
# pca_exp_rlog[["04_p_scree"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["KA.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# pca_exp_rlog[["12_p_cor"]]

#NOTE Not sure why, but it's not working


#  ~ technical + genotype -----------------------------------------------------
dds_adj <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts,
    colData = t_meta,
    design = ~ technical + genotype,
    rowRanges = g_pos
)

rld <- DESeq2::rlog(
    dds_adj[dds_adj@rowRanges$genome == "S_cerevisiae", ],
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
    transformed = TRUE
)
# pca_exp_rlog[["02_horn"]]$n
# pca_exp_rlog[["03_elbow"]]
# pca_exp_rlog[["04_p_scree"]]
# pca_exp_rlog[["10_p_images"]][["KA.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC3.v.PC4"]]
# pca_exp_rlog[["12_p_cor"]]

#NOTE
#  We can nearly reproduce the PCA results in notebook/KA.2023-0324.presentation_QC with the following model supplied
#+ to DESeq2::DESeqDataSetFromMatrix(): ~ technical + genotype
#+
#+ PC3 is significant and accounts for ~9.5% of variation; it's tightly correlated with genotype
#+ 
#+ We seem to sidestep problems when we include technical in the model when making dds, rather than correcting after
#+ the fact as we do in the chunk immediately above this one


#  TESTING: ~ technical + time ------------------------------------------------
# dds_adj <- DESeq2::DESeqDataSetFromMatrix(
#     countData = t_counts,
#     colData = t_meta,
#     design = ~ technical + time,
#     rowRanges = g_pos
# )
# 
# rld <- DESeq2::rlog(
#     dds_adj[dds_adj@rowRanges$genome == "S_cerevisiae", ],
#     blind = FALSE
# )
# norm_r <- SummarizedExperiment::assay(rld) %>%
#     as.data.frame()
# norm_r$features <- dds@rowRanges$features[
#     dds@rowRanges$genome == "S_cerevisiae"
# ]
# norm_r <- dplyr::full_join(
#     norm_r,
#     t_tc_SC[, 1:9],
#     by = "features"
# ) %>%
#     dplyr::as_tibble() %>%
#     dplyr::relocate(18:26, .before = WT_DSm2_rep1_tech1)
# 
# counts_rlog <- norm_r %>%
#     dplyr::select(10:ncol(norm_r)) %>%
#     dplyr::mutate_if(is.character, as.numeric)
# pca_exp_rlog <- run_PCA_pipeline(
#     counts = counts_rlog,
#     metadata = t_meta,
#     gene_id = gene_id,
#     transformed = TRUE
# )
# pca_exp_rlog[["02_horn"]]$n
# pca_exp_rlog[["03_elbow"]]
# pca_exp_rlog[["04_p_scree"]]
# # pca_exp_rlog[["10_p_images"]][["KA.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC2.v.PC4"]]
# pca_exp_rlog[["10_p_images"]][["PCAtools.PC3.v.PC4"]]
# pca_exp_rlog[["12_p_cor"]]
# 
# #NOTE
# #  We can more or less reproduce the PCA results in notebook/KA.2023-0324.presentation_QC with the following model
# #+ supplied to DESeq2::DESeqDataSetFromMatrix(): ~ technical + time
# #+ 
# #+ PC3 is significant and accounts for ~7% of variation


#  Perform PCA, but now include Q and G1 states with timecourse states ========
#  Subset t_mat for Q, G1, and timecourse counts data -------------------------
keep <- c(
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1",
    "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"
)
t_tc_full <- dplyr::bind_cols(
    t_mat[, 1:10],
    t_mat[, colnames(t_mat) %in% keep]
) 

#  Exclude 20S and htseq-count "summary values" from timecourse tibble
t_tc_full <- t_tc_full %>% dplyr::slice(1:(n() - 6))
# tail(t_tc_full)

#  Explicitly rename the sample columns (give them straightforward names);
#+ later, we can use these name to populate a metadata matrix
better_sample_names <- c(
	"WT_DSm2_SS_rep1_tech1",
	"WT_DSm2_SS_rep2_tech1",
	"WT_DSp2_SS_rep1_tech1",
	"WT_DSp2_SS_rep2_tech1",
	"WT_DSp24_SS_rep1_tech1",
	"WT_DSp24_SS_rep2_tech1",
	"WT_DSp48_SS_rep1_tech1",
	"WT_DSp48_SS_rep1_tech2",
	"WT_DSp48_SS_rep2_tech1",
	"WT_G1_SS_rep1_tech2",  # Was incorrectly labeled as "WT_G1_SS_rep1_tech1"
	"WT_G1_SS_rep2_tech2",  # Was incorrectly labeled as "WT_G1_SS_rep2_tech1"
	"WT_Q_N_rep1_tech1",
	"WT_Q_N_rep2_tech1",
	"WT_Q_SS_rep1_tech1",
	"WT_Q_SS_rep2_tech1",
	"r6n_DSm2_SS_rep1_tech1",
	"r6n_DSm2_SS_rep2_tech1",
	"r6n_DSp2_SS_rep1_tech1",
	"r6n_DSp2_SS_rep2_tech1",
	"r6n_DSp24_SS_rep1_tech1",
	"r6n_DSp24_SS_rep2_tech1",
	"r6n_DSp48_SS_rep1_tech1",
	"r6n_DSp48_SS_rep2_tech2",  # Was incorrectly labeled as "r6n_DSp48_SS_rep2_tech1"
	"r6n_G1_SS_rep1_tech2",  # Was incorrectly labeled as "r6n_G1_SS_rep1_tech1"
	"r6n_G1_SS_rep2_tech2",  # Was incorrectly labeled as "r6n_G1_SS_rep2_tech1"
	"r6n_Q_N_rep1_tech1",
	"r6n_Q_N_rep2_tech1",
	"r6n_Q_SS_rep1_tech1",
	"r6n_Q_SS_rep1_tech2",
	"r6n_Q_SS_rep2_tech1"
)

colnames(t_tc_full)[11:ncol(t_tc_full)] <- better_sample_names
rm(better_sample_names)


#  Make a dds object from t_tc_full -------------------------------------------
#  Make a metadata matrix for DESeq2, etc.
t_meta_full <- colnames(t_tc_full)[11:ncol(t_tc_full)] %>%
    stringr::str_split("_") %>%
    as.data.frame() %>%
    t() %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    dplyr::rename(
        genotype = ...1, time = ...2, transcription = ...3, replicate = ...4,
        technical = ...5
    ) %>%
    dplyr::mutate(rownames = colnames(t_tc_full)[11:ncol(t_tc_full)]) %>%
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
        time = factor(
            time, levels = c("G1", "DSm2", "DSp2", "DSp24", "DSp48", "Q")
        ),
        no_time = sapply(
            as.character(time),
            switch,
            "G1" = 0,
            "DSm2" = 1,
            "DSp2" = 2,
            "DSp24" = 3,
            "DSp48" = 4,
            "Q" = 5,
            USE.NAMES = FALSE
        ) %>%
            as.factor(),
        transcription = factor(transcription, levels = c("N", "SS")),
        no_transcription = sapply(
            as.character(transcription),
            switch,
            "N" = 0,
            "SS" = 1,
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
    )

#  Make a GRanges object for positional information for DESeq2, etc.
g_pos_full <- GenomicRanges::GRanges(
    seqnames = t_tc$chr,
    ranges = IRanges::IRanges(t_tc$start, t_tc$end),
    strand = t_tc$strand,
    length = t_tc$width,
    type = t_tc$type,
    features = t_tc$features,
    names = t_tc$names,
    thorough = ifelse(is.na(t_tc$names), t_tc$features, t_tc$names),
    biotype = t_tc$biotype,
    genome = t_tc$genome
)
# g_pos_full %>% tibble::as_tibble()

#  Make a counts matrix for DESeq2, etc.
t_counts_full <- t_tc_full[, 11:ncol(t_tc_full)] %>%
    sapply(., as.integer) %>%
    as.data.frame()

#  Make the dds object; however, don't do any modeling yet
dds_full <- DESeq2::DESeqDataSetFromMatrix(
    countData = t_counts_full,
    colData = t_meta_full,
    design = ~ technical + genotype,
    rowRanges = g_pos_full
)

#  Perform rlog transformation
rld_full <- DESeq2::rlog(
    dds_full[dds_full@rowRanges$genome == "S_cerevisiae", ],
    blind = FALSE
)
# rlog() may take a few minutes with 30 or more samples,
# vst() is a much faster transformation
norm_r_full <- SummarizedExperiment::assay(rld_full) %>%
    as.data.frame()
norm_r_full$features <- dds_full@rowRanges$features[
    dds_full@rowRanges$genome == "S_cerevisiae"
]
norm_r_full <- dplyr::full_join(
    dplyr::filter(t_tc_full, genome == "S_cerevisiae")[, 1:10],
    norm_r_full,
    by = "features"
)

counts_rlog_full <- norm_r_full %>%
    dplyr::select(11:ncol(norm_r_full)) %>%
    dplyr::mutate_if(is.character, as.numeric)
gene_id_full <- ifelse(
    is.na(dplyr::filter(t_tc_full, genome == "S_cerevisiae")$names),
    dplyr::filter(t_tc_full, genome == "S_cerevisiae")$features,
    dplyr::filter(t_tc_full, genome == "S_cerevisiae")$names
) %>%
    make.unique()
pca_exp_rlog_full <- run_PCA_pipeline(
    counts = counts_rlog_full,
    metadata = t_meta_full,
    gene_id = gene_id_full,
    transformed = TRUE,
    transcription = TRUE,
    meta_color = "genotype",
    meta_shape = "time"
)
pca_exp_rlog_full[["02_horn"]]$n
pca_exp_rlog_full[["03_elbow"]]
pca_exp_rlog_full[["04_p_scree"]]
pca_exp_rlog_full[["10_p_images"]][["KA.PC1.v.PC2"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC2.v.PC4"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC3.v.PC4"]]
pca_exp_rlog_full[["12_p_cor"]]

test <- run_PCA_pipeline(
    counts = counts_rlog_full,
    metadata = t_meta_full,
    gene_id = gene_id_full,
    transformed = TRUE,
    transcription = TRUE,
    meta_color = "transcription",
    meta_shape = "time"
)
test[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
test[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
test[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
test[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
test[["10_p_images"]][["PCAtools.PC2.v.PC4"]]
test[["10_p_images"]][["PCAtools.PC3.v.PC4"]]

pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
test[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
