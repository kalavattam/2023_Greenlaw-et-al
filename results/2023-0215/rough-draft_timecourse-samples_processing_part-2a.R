#!/usr/bin/Rscript

#  rough-draft_timecourse-samples_scaled-coverage_DGE_PCA_part-2.R
#  KA

library(DESeq2)
library(GenomicRanges)
library(limma)
library(PCAtools)
library(rtracklayer)
library(tidyverse)

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)


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
    # "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    # "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    # "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    # "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
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
	# "WT_Q_N_rep1_tech1",
	# "WT_Q_N_rep2_tech1",
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
	# "r6n_Q_N_rep1_tech1",
	# "r6n_Q_N_rep2_tech1",
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
t_meta_full

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
    transcription = FALSE,
    meta_color = "genotype",
    meta_shape = "time"
)
pca_exp_rlog_full[["02_horn"]]$n
pca_exp_rlog_full[["03_elbow"]]
pca_exp_rlog_full[["04_p_scree"]]
pca_exp_rlog_full[["10_p_images"]][["KA.PC1.v.PC2"]]
pca_exp_rlog_full[["10_p_images"]][["KA.PC1.v.PC3"]]
pca_exp_rlog_full[["10_p_images"]][["KA.PC2.v.PC3"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
pca_exp_rlog_full[["12_p_cor"]]

# test <- run_PCA_pipeline(
#     counts = counts_rlog_full,
#     metadata = t_meta_full,
#     gene_id = gene_id_full,
#     transformed = TRUE,
#     transcription = TRUE,
#     meta_color = "transcription",
#     meta_shape = "time"
# )
# test[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# test[["10_p_images"]][["PCAtools.PC1.v.PC4"]]
# test[["10_p_images"]][["PCAtools.PC1.v.PC3"]]
# test[["10_p_images"]][["PCAtools.PC2.v.PC3"]]
# test[["10_p_images"]][["PCAtools.PC2.v.PC4"]]
# test[["10_p_images"]][["PCAtools.PC3.v.PC4"]]
# 
# pca_exp_rlog_full[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
# test[["10_p_images"]][["PCAtools.PC1.v.PC2"]]
