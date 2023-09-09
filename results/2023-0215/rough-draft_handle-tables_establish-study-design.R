
#  rough-draft_handle-tables_establish-study-design.R
#  KA
#  2023-0403


#  Get situated ===============================================================
#  Load necessary libraries
library(DESeq2)
library(edgeR)
library(EnhancedVolcano)
library(GenomicRanges)
library(ggrepel)
library(IRanges)
library(PCAtools)
library(readxl)
library(sva)
library(tidyverse)

#  Set options
options(scipen = 999)
options(ggrepel.max.overlaps = Inf)

#  Set working directory
if(stringr::str_detect(getwd(), "kalavattam")) {
    p_local <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_local <- "/Users/kalavatt/projects-etc"
}
p_wd <- "2022-2023_RRP6-NAB3/results/2023-0215"

setwd(paste(p_local, p_wd, sep = "/"))
getwd()

rm(p_local, p_wd)


#  Load in and process `htseq-count` table ====================================
#  Load in htseq-count table --------------------------------------------------
p_hc <- "outfiles_htseq-count/already/combined-SC-KL-20S/UT_prim_UMI"
f_hc <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
t_hc <- readr::read_tsv(
    paste(p_hc, f_hc, sep = "/"), show_col_types = FALSE
) %>%
    dplyr::slice(-1)

rm(p_hc, f_hc)


#  Clean up tibble column names -----------------------------------------------
colnames(t_hc) <- colnames(t_hc) %>%
    gsub("\\.UT_prim_UMI\\.hc-strd-eq\\.tsv$", "", .) %>%
    gsub("\\.UT_prim_UMI\\.hc-strd-op\\.tsv$", "", .)

t_hc$features <- t_hc$features %>%
    gsub("^transcript\\:", "", .) %>%
    gsub("_mRNA", "", .)


#  To associate features (mRNA) with metadata, load combined_SC_KL_20S.gff3 ---
p_gff3 <- "./infiles_gtf-gff3/already"
f_gff3 <- "combined_SC_KL_20S.gff3"
t_gff3 <- rtracklayer::import(paste(p_gff3, f_gff3, sep = "/")) %>%
    as.data.frame() %>%
    dplyr::as_tibble()

rm(p_gff3, f_gff3)


#  Subset combined_SC_KL_20S.gff3 for ID "mRNA" -------------------------------
#+ (specified in the call to htseq-count)
t_gff3 <- t_gff3[t_gff3$type == "mRNA", ]
t_gff3$ID <- t_gff3$ID %>%
    gsub("^transcript\\:", "", .) %>%
    gsub("_mRNA", "", .)


#  Subset tibble to keep only relevant columns --------------------------------
keep <- c(
    "seqnames", "start", "end", "width", "strand", "type", "ID", "biotype",
    "Name"
)
t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep] %>%
    dplyr::rename(length = width)
rm(keep)


#  Convert column Name from list to character vector --------------------------
#+ ...and replace empty fields NA character values
t_gff3$Name <- ifelse(
    as.character(t_gff3$Name) == "character(0)",
    NA_character_,
    as.character(t_gff3$Name)
)


#  Rename column "seqnames" to "chr" and column "Name" to "names" -------------
t_gff3 <- t_gff3 %>% dplyr::rename(
    c(chr = seqnames, names = Name, features = ID)
)


#  Join t_hc and t_gff3 -------------------------------------------------------
t_hc <- dplyr::full_join(t_gff3, t_hc, by = "features") %>%
    dplyr::rename(feature = features)
rm(t_gff3)


#  Order tibble by chromosome names and feature start positions ---------------
chr_SC <- c(
    "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
    "XIII", "XIV", "XV", "XVI", "Mito"
)
chr_KL <- c("A", "B", "C", "D", "E", "F")
chr_20S <- "20S"
chr_order <- c(chr_SC, chr_KL, chr_20S)
t_hc$chr <- t_hc$chr %>% as.factor()
t_hc$chr <- ordered(t_hc$chr, levels = chr_order)

t_hc <- t_hc %>% dplyr::arrange(chr, start)


#  Categorize chromosomes by genome of origin ---------------------------------
t_hc$genome <- ifelse(
    t_hc$chr %in% chr_SC,
    "S_cerevisiae",
    ifelse(
        t_hc$chr %in% chr_KL,
        "K_lactis",
        ifelse(
            t_hc$chr %in% chr_20S,
            "20S",
            NA
        )
    )
) %>%
    as.factor()

rm(chr_KL, chr_SC, chr_20S, chr_order)


#  Move the new column "genome" to a better location in the tibble ------------
t_hc <- t_hc %>% dplyr::relocate("genome", .before = "chr")


#  Filter rows containing htseq-count metrics (m_hc) --------------------------
m_hc <- t_hc %>% dplyr::filter(grepl("__", feature)) %>%
    dplyr::select(-c(colnames(t_hc[c(1:7, 9:10)])))
t_hc <- t_hc %>% dplyr::filter(!grepl("__", feature))


#  Create a "complete" vector of feature names --------------------------------
#+ Also, move columns to better locations within the tibble
t_hc$complete <- ifelse(!is.na(t_hc$names), t_hc$names, t_hc$feature)

t_hc <- t_hc %>%
    dplyr::relocate(c(names, complete), .after = feature) %>%
    dplyr::relocate(type, .after = complete)


# Record tibble t_hc positional information in a GRanges object ===============
#+ (pos_info will be used in DESeq2 processing, post-processing, etc.)
pos_info <- GenomicRanges::GRanges(
    seqnames = t_hc$chr,
    ranges = IRanges::IRanges(t_hc$start, t_hc$end),
    strand = t_hc$strand,
    length = t_hc$length,
    feature = t_hc$feature,
    names = t_hc$names,
    complete = t_hc$complete,
    biotype = t_hc$biotype,
    type = t_hc$type,
    genome = t_hc$genome
)
pos_info


#  Load in Excel spreadsheet of samples names and variables ===================
p_xl <- "notebook"  #INPATH
f_xl <- "variables.xlsx"  #INFILE
t_xl <- readxl::read_xlsx(
    paste(p_xl, f_xl, sep = "/"), sheet = "master", na = "NA"
)

rm(p_xl, f_xl)


#  Make a master model matrix =================================================
#  Columns 12 through to the last column are composed of sample feature counts;
#+ get these column names into a vector
samples <- colnames(t_hc)[12:length(colnames(t_hc))]

#  Convert the vector of column names to a list by splitting each element at
#+ its underscores; thus, each vector element becomes a list of eight strings,
#+ with one string for 'strain', one for 'state', etc.; these 
samples <- stringr::str_split(samples, "_")

#  Convert the list to a dataframe, transpose it, then convert it to a tibble
#+ [R fun fact: 'tibble' data types can't be built directly from 'list' data
#+ types; in fact, it can difficult to build 'dataframe' types from 'list'
#+ types as well; the reason we have no issues doing this is because we have
#+ ensured ahead of time that each list element has the same number of
#+ subelements (8); the difficulty arises when lists elements have varying
#+ numbers of subelements]
samples <- samples %>%
    as.data.frame(
        .,
        #  Using numeric column names here because the columns will soon be
        #+ transposed to rows, and I don't want the rows to have proper names
        col.names = c(seq(1, 62)),
        #  Using proper row names here because the rows will soon be transposed
        #+ to columns, and I *do* want the columns to have proper names 
        row.names = c(
            "strain", "state", "time", "kit", "transcription", "auxin",
            "timecourse", "replicate", "technical"
        )
    ) %>%
    t() %>%
    tibble::as_tibble()

#  Add a keys variable for quickly accessing combinations of variable values
keys <- vector(mode = "character")
for(i in seq(1, nrow(samples))) {
    # i <- 1
    keys[i] <- paste(
        samples[i, 1], samples[i, 2], samples[i, 3],
        samples[i, 4], samples[i, 5], samples[i, 6],
        samples[i, 7], samples[i, 8], samples[i, 9],
        sep = "_"
    )
}
keys <- keys %>% as.data.frame()
colnames(keys) <- "keys"

samples <- dplyr::bind_cols(samples, keys) %>%
    dplyr::relocate("keys", .before = "strain")

rm(i)

#  Add Alison's original samples names to the 'samples' dataframe using the
#+ 't_xl' dataframe; here, we're just adding the original sample names, but we
#+ could potentially add in other information stored in the Excel file
t_xl <- t_xl %>%
    dplyr::rename(keys = name) %>%
    dplyr::select(., c(keys, sample_name))
samples <- dplyr::full_join(samples, t_xl, by = "keys")

rm(t_xl, keys)


#  Assess factors for study design ============================================
# colnames(samples)
# cat("\n")
# 
# cat("strain")
# table(as.factor(samples$strain))
# cat("\n")
# 
# cat("state")
# table(as.factor(samples$state))
# cat("\n")
# 
# cat("time")
# table(as.factor(samples$time))
# cat("\n")
# 
# cat("kit")
# table(as.factor(samples$kit))
# cat("\n")
# 
# cat("transcription")
# table(as.factor(samples$transcription))
# cat("\n")
# 
# cat("auxin")
# table(as.factor(samples$auxin))
# cat("\n")
# 
# cat("timecourse")
# table(as.factor(samples$timecourse))
# cat("\n")
# 
# cat("replicate")
# table(as.factor(samples$replicate))
# cat("\n")
# 
# cat("technical")
# table(as.factor(samples$technical))
# cat("\n")


#  Isolate samples by figure plans/requirements ===============================
samples_fig_1_5 <- samples %>%
    dplyr::filter(grepl("ovn", kit))
# batch-effect FALSE NA
# third-rep FALSE NA
# pairwise FALSE NA
# groupwise TRUE all

samples_fig_2 <- samples %>%
    dplyr::filter(grepl("DS", state)) %>%
    dplyr::filter(!grepl("t4", strain))
# batch-effect TRUE WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2
# third-rep FALSE NA
# pairwise TRUE #TODO
# groupwise TRUE all

samples_fig_3 <- samples %>%
    dplyr::filter(!grepl("DS", state)) %>%
    dplyr::filter(!grepl("CU", sample_name)) %>%
    dplyr::filter(grepl("tcn", kit)) %>%
    dplyr::filter(grepl("r6|WT", strain))
# batch-effect TRUE r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2
# third-rep FALSE NA
# pairwise TRUE #TODO
# groupwise #MAYBE #TODO

samples_fig_4 <- samples %>%
    dplyr::filter(grepl("o-|n3-", strain))
# batch-effect FALSE NA
# third-rep TRUE n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1
# pairwise TRUE #TODO
# groupwise #MAYBE #TODO


#  Read in functions ==========================================================
get_object_name <- function(object) {
    return(deparse(substitute(object)))
}


make_col_data <- function(tibble_samples) {
    col_data <- tibble_samples %>%
        # lapply(., gsub, pattern = "-", replacement = "") %>%
        as.data.frame() %>%
        tibble::column_to_rownames(., var = "keys") %>%
        droplevels()
    
    return(col_data)
}


make_dds_model_intercept <- function(counts_data, col_data, pos_info) {
    dds <- DESeq2::DESeqDataSetFromMatrix(
        countData = counts_data,
        colData = col_data,
        design = ~1,
        rowRanges = pos_info
    )
    
    return(dds)
}


#  Initialize and populate list for study-design data/metadata ================
sec_a <- "a_overview"
sec_b <- paste0("b_", get_object_name(samples_fig_1_5))
sec_c <- paste0("c_", get_object_name(samples_fig_2))
sec_d <- paste0("d_", get_object_name(samples_fig_3))
sec_e <- paste0("e_", get_object_name(samples_fig_4))
# rm(list = grep("sec_", names(.GlobalEnv), value = TRUE))

design <- list()

design[[sec_a]][["counts_metadata"]] <- t_hc
design[[sec_a]][["metrics"]] <- m_hc
design[[sec_a]][["positional"]] <- pos_info
design[[sec_a]][[get_object_name(samples)]] <- samples

design[[sec_b]][["samples"]] <- samples_fig_1_5
design[[sec_c]][["samples"]] <- samples_fig_2
design[[sec_d]][["samples"]] <- samples_fig_3
design[[sec_e]][["samples"]] <- samples_fig_4


#  Determine and record relevant data, metadata for each sample ===============
#  samples_fig_1_5 ------------------------------------------------------------
#  Subset t_hc by relevant samples ------------------------
datasets <- samples_fig_1_5$keys
keep <- c(colnames(t_hc)[1:11], datasets)
t_hc_fig_1_5 <- t_hc[, colnames(t_hc) %in% keep]
rm(keep)


#  Create a dds object ------------------------------------
counts_data <- t_hc_fig_1_5[, datasets] %>%
    as.data.frame() %>%
    sapply(., as.integer)

col_data <- make_col_data(samples_fig_1_5)

dds_intcp <- make_dds_model_intercept(counts_data, col_data, pos_info)
dds_intcp <- BiocGenerics::estimateSizeFactors(
    dds_intcp[dds_intcp@rowRanges$genome == "K_lactis", ]
)

#  Evaluate K. lactis-based size factors 
size_factors <- dds_intcp$sizeFactor


#  Save the size factors, etc. to object 'design' ---------
design[[sec_b]][[get_object_name(datasets)]] <- datasets
design[[sec_b]][["counts_metadata"]] <- t_hc_fig_1_5
design[[sec_b]][["metrics"]] <- m_hc[, colnames(m_hc) %in% c("feature", datasets)]
design[[sec_b]][["positional"]] <- pos_info
design[[sec_b]][[get_object_name(counts_data)]] <- counts_data
design[[sec_b]][[get_object_name(col_data)]] <- col_data
design[[sec_b]][[get_object_name(dds_intcp)]] <- dds_intcp
design[[sec_b]][[get_object_name(size_factors)]] <- size_factors

rm(datasets, t_hc_fig_1_5, counts_data, col_data, dds_intcp, size_factors)


#  samples_fig_2 --------------------------------------------------------------
#  Subset t_hc by relevant samples ------------------------
datasets <- samples_fig_2$keys
keep <- c(colnames(t_hc)[1:11], datasets)
t_hc_fig_2 <- t_hc[, colnames(t_hc) %in% keep]
rm(keep)


#  Create a dds object ------------------------------------
counts_data <- t_hc_fig_2[, datasets] %>%
    as.data.frame() %>%
    sapply(., as.integer)

col_data <- make_col_data(samples_fig_2)

dds_intcp <- make_dds_model_intercept(counts_data, col_data, pos_info)
dds_intcp <- BiocGenerics::estimateSizeFactors(
    dds_intcp[dds_intcp@rowRanges$genome == "K_lactis", ]
)

#  Evaluate K. lactis-based size factors 
size_factors <- dds_intcp$sizeFactor


#  Determine pairwise combinations for DE analyses --------
exp_details <- list()

comb_num <- outer("r6-n", samples_fig_2$state, "paste") %>%
    as.character() %>%
    unique()
comb_denom <- outer("WT", samples_fig_2$state, "paste") %>%
    as.character() %>%
    unique()
comb_pairwise <- outer(comb_num, comb_denom, "paste")

table_models <- matrix(data = NA, nrow = 4, ncol = 4)
for(i in 1:ncol(comb_pairwise)) {
    for(j in 1:ncol(comb_pairwise)) {
        # i <- 1
        # j <- 1
        tbl_num <- samples_fig_2 %>%
            dplyr::filter(
                grepl(
                    paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[1], "$"), strain
                )
            ) %>% 
            dplyr::filter(
                grepl(paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[2], "$"), state)
            ) %>%
            dplyr::select(keys, strain, state, technical)
        
        tbl_denom <- samples_fig_2 %>%
            dplyr::filter(
                grepl(paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[3], "$"), strain)
            ) %>% 
            dplyr::filter(
                grepl(paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[4], "$"), state)
            ) %>%
            dplyr::select(keys, strain, state, technical)
        
        # rstudio-pubs-static.s3.amazonaws.com/329027_593046fb6d7a427da6b2c538caf601e1.html
        if(any(c(tbl_num$technical, tbl_denom$technical) %in% "tech2")) {
            if(unique(tbl_num$state) == unique(tbl_denom$state)) {
                table_models[i, j] <- "~ technical + strain"
            } else {
                table_models[i, j] <- "\'~ technical + strain + state\', \'~ technical + strain + state + strain:state\', \'~ technical + state + strain\', etc."
            }
        } else {
            if(unique(tbl_num$state) == unique(tbl_denom$state)) {
                table_models[i, j] <- "~ state"
            } else {
                table_models[i, j] <- "\'~ strain + state\', \'~ strain + state + strain:state\', \'~ state + strain\', etc."
            }
        }
        
        exp_details[["numerator"]][[paste(i, "by", j)]] <- tbl_num
        exp_details[["denominator"]][[paste(i, "by", j)]] <- tbl_denom
    }
}
exp_details[["combinations"]] <- comb_pairwise
exp_details[["models"]] <- table_models

rm(comb_pairwise, tbl_num, tbl_denom, table_models, i, j)


#  Save the size factors, etc. to object 'design' ---------
design[[sec_c]][[get_object_name(datasets)]] <- datasets
design[[sec_c]][["counts_metadata"]] <- t_hc_fig_2
design[[sec_c]][["metrics"]] <- m_hc[, colnames(m_hc) %in% c("feature", datasets)]
design[[sec_c]][["positional"]] <- pos_info
design[[sec_c]][[get_object_name(counts_data)]] <- counts_data
design[[sec_c]][[get_object_name(col_data)]] <- col_data
design[[sec_c]][[get_object_name(dds_intcp)]] <- dds_intcp
design[[sec_c]][[get_object_name(size_factors)]] <- size_factors
design[[sec_c]][[get_object_name(exp_details)]] <- exp_details

rm(
    datasets, t_hc_fig_2, counts_data, col_data, dds_intcp, size_factors,
    exp_details
)


#INPROGRESS #PICKUPHERE
#  samples_fig_3 --------------------------------------------------------------
#  Subset t_hc by relevant samples ------------------------
datasets <- samples_fig_3$keys
keep <- c(colnames(t_hc)[1:11], datasets)
t_hc_fig_3 <- t_hc[, colnames(t_hc) %in% keep]
rm(keep)


#  Create a dds object ------------------------------------
counts_data <- t_hc_fig_3[, datasets] %>%
    as.data.frame() %>%
    sapply(., as.integer)

col_data <- make_col_data(samples_fig_3)

dds_intcp <- make_dds_model_intercept(counts_data, col_data, pos_info)
dds_intcp <- BiocGenerics::estimateSizeFactors(
    dds_intcp[dds_intcp@rowRanges$genome == "K_lactis", ]
)

#  Evaluate K. lactis-based size factors 
size_factors <- dds_intcp$sizeFactor


#  Determine pairwise combinations for DE analyses --------
exp_details <- list()

comb_num <- outer("r6-n", samples_fig_3$state, "paste") %>%
    as.character() %>%
    unique()
comb_denom <- outer("WT", samples_fig_3$state, "paste") %>%
    as.character() %>%
    unique()
comb_pairwise <- outer(comb_num, comb_denom, "paste")

table_models <- matrix(data = NA, nrow = 4, ncol = 4)
for(i in 1:ncol(comb_pairwise)) {
    for(j in 1:ncol(comb_pairwise)) {
        # i <- 1
        # j <- 1
        tbl_num <- samples_fig_3 %>%
            dplyr::filter(
                grepl(
                    paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[1], "$"), strain
                )
            ) %>% 
            dplyr::filter(
                grepl(paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[2], "$"), state)
            ) %>%
            dplyr::select(keys, strain, state, technical)
        
        tbl_denom <- samples_fig_3 %>%
            dplyr::filter(
                grepl(paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[3], "$"), strain)
            ) %>% 
            dplyr::filter(
                grepl(paste0("^", unlist(stringr::str_split(comb_pairwise[i, j], " "))[4], "$"), state)
            ) %>%
            dplyr::select(keys, strain, state, technical)
        
        # rstudio-pubs-static.s3.amazonaws.com/329027_593046fb6d7a427da6b2c538caf601e1.html
        if(any(c(tbl_num$technical, tbl_denom$technical) %in% "tech2")) {
            if(unique(tbl_num$state) == unique(tbl_denom$state)) {
                table_models[i, j] <- "~ technical + strain"
            } else {
                table_models[i, j] <- "\'~ technical + strain + state\', \'~ technical + strain + state + strain:state\', \'~ technical + state + strain\', etc."
            }
        } else {
            if(unique(tbl_num$state) == unique(tbl_denom$state)) {
                table_models[i, j] <- "~ state"
            } else {
                table_models[i, j] <- "\'~ strain + state\', \'~ strain + state + strain:state\', \'~ state + strain\', etc."
            }
        }
        
        exp_details[["numerator"]][[paste(i, "by", j)]] <- tbl_num
        exp_details[["denominator"]][[paste(i, "by", j)]] <- tbl_denom
    }
}
exp_details[["combinations"]] <- comb_pairwise
exp_details[["models"]] <- table_models

rm(comb_pairwise, tbl_num, tbl_denom, table_models, i, j)


#  Save the size factors, etc. to object 'design' ---------
design[[sec_c]][[get_object_name(datasets)]] <- datasets
design[[sec_c]][["counts_metadata"]] <- t_hc_fig_3
design[[sec_c]][["metrics"]] <- m_hc[, colnames(m_hc) %in% c("feature", datasets)]
design[[sec_c]][["positional"]] <- pos_info
design[[sec_c]][[get_object_name(counts_data)]] <- counts_data
design[[sec_c]][[get_object_name(col_data)]] <- col_data
design[[sec_c]][[get_object_name(dds_intcp)]] <- dds_intcp
design[[sec_c]][[get_object_name(size_factors)]] <- size_factors
design[[sec_c]][[get_object_name(exp_details)]] <- exp_details

rm(
    datasets, t_hc_fig_3, counts_data, col_data, dds_intcp, size_factors,
    exp_details
)




# rm(design)
# rm(list = grep("samples_fig", names(.GlobalEnv), value = TRUE))
