
#  rough-draft_handle-matrices-gtfs.R
#  KA
#  2023-0331


#  ============================================================================
#  Determine "types" in combined_AG.sans-chr.gtf ==============================
#  ============================================================================
# library(GenomicRanges)
# library(rtracklayer)
# library(tidyverse)
# 
# setwd("~/projects-etc/2022_transcriptome-construction/results/2023-0215")
# getwd()
# 
# list.dirs()
# list.files("./infiles_gtf-gff3/already")
# 
# combined_AG <- list.files("./infiles_gtf-gff3/already")[2]
# combined_AG <- rtracklayer::import(
#     paste("./infiles_gtf-gff3/already", combined_AG, sep = "/")
# )
# combined_AG <- combined_AG %>% as.data.frame()
# 
# types <- combined_AG$type %>% as.factor() %>% table() %>% names()
# types
# 
# rm(combined_AG, types)


#  ============================================================================
#  Load in and process htseq-count counts matrix ==============================
#+ ...associated with combined_SC_KL_20S.gff3
#  ============================================================================
library(GenomicRanges)
library(rtracklayer)
library(tidyverse)

setwd("~/projects-etc/2022_transcriptome-construction/results/2023-0215")
getwd()

t_mat <- "all-samples.combined-SC-KL-20S.hc-strd-eq.mRNA.tsv"
t_mat <- readr::read_tsv(t_mat, show_col_types = FALSE) %>%
    dplyr::slice(-1)  #  Need to remove the first row, which contains string
                      #+ for source bam

colnames(t_mat) <- colnames(t_mat) %>%
    gsub("\\.UT_prim_UMI\\.hc-strd-eq\\.tsv$", "", .) %>%
    gsub("\\.UT_prim_UMI\\.hc-strd-op\\.tsv$", "", .)

t_mat$features <- t_mat$features %>%
    gsub("^transcript\\:", "", .) %>%
    gsub("_mRNA", "", .)


#  Load in Excel spreadsheet of samples names and variables -------------------
#+ #NOTE To be used later, just loading it in now
p_xl <- "notebook"  #INPATH
f_xl <- "variables.xlsx"  #INFILE
t_xl <- readxl::read_xlsx(
    paste(p_xl, f_xl, sep = "/"), sheet = "master", na = "NA"
)

rm(p_xl, f_xl)


#  To associate features (mRNA) with metadata, load combined_SC_KL_20S.gff3 ---
list.files("./infiles_gtf-gff3/already")
t_gff3 <- list.files("./infiles_gtf-gff3/already")[3]
t_gff3 <- rtracklayer::import(
    paste("./infiles_gtf-gff3/already", t_gff3, sep = "/")
)
t_gff3 <- t_gff3 %>% as.data.frame() %>% dplyr::as_tibble()


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
t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
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


#  Join t_mat and t_gff3 ------------------------------------------------------
t_mat <- dplyr::full_join(t_gff3, t_mat, by = "features")
rm(t_gff3)


#  Order tibble by chromosome names and feature start positions ---------------
chr_SC <- c(
    "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
    "XIII", "XIV", "XV", "XVI", "Mito"
)
chr_KL <- c("A", "B", "C", "D", "E", "F")
chr_20S <- c("20S")
chr_order <- c(chr_SC, chr_KL, chr_20S)
t_mat$chr <- t_mat$chr %>% as.factor()
t_mat$chr <- ordered(t_mat$chr, levels = chr_order)

t_mat <- t_mat %>% dplyr::arrange(chr, start)


#  Categorize chromosomes by genome of origin ---------------------------------
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

#  Move the new column "genome" to a better location in the tibble ------------
t_mat <- t_mat %>% dplyr::relocate("genome", .before = "chr")


#  Check on variable/column "genome" ------------------------------------------
levels(t_mat$genome)
t_mat %>%
    dplyr::group_by(genome) %>%
    dplyr::summarize(tally = length(genome))
#  The code returns...
# 20S = 1, K_lactis = 5076, S_cerevisiae = 6600, NA = 5


#  Clean up -------------------------------------------------------------------
rm(chr_KL, chr_SC, chr_order)


#  ============================================================================
#  Load in and process htseq-count counts matrix ==============================
#+ ...associated with combined_AG.sans-chr.gff3
#  ============================================================================
library(GenomicRanges)
library(rtracklayer)
library(tidyverse)

setwd("~/projects-etc/2022_transcriptome-construction/results/2023-0215")
getwd()

t_mat <- "all-samples.combined-AG.hc-strd-eq.XUT.tsv"
t_mat <- readr::read_tsv(t_mat, show_col_types = FALSE) %>%
    dplyr::slice(-1)  #  Need to remove the first row, which contains string
                      #+ for source bam

colnames(t_mat) <- colnames(t_mat) %>%
    gsub("\\.UT_prim_UMI\\.hc-strd-eq\\.tsv$", "", .) %>%
    gsub("\\.UT_prim_UMI\\.hc-strd-op\\.tsv$", "", .)

#QUESTION 1/2 No processing needed with type XUT? How about other types in
#QUESTION 2/2 combined_AG.sans-chr.gff3?
# t_mat$features <- t_mat$features %>%
#     gsub("^transcript\\:", "", .) %>%
#     gsub("_mRNA", "", .)


#  Load in Excel spreadsheet of samples names and variables -------------------
#+ #NOTE To be used later, just loading it in now
p_xl <- "notebook"  #INPATH
f_xl <- "variables.xlsx"  #INFILE
t_xl <- readxl::read_xlsx(
    paste(p_xl, f_xl, sep = "/"), sheet = "master", na = "NA"
)

rm(p_xl, f_xl)


#  To associate features (mRNA) with metadata, load combined_SC_KL_20S.gff3 ---
list.files("./infiles_gtf-gff3/already")
t_gff3 <- list.files("./infiles_gtf-gff3/already")[2]
t_gff3 <- rtracklayer::import(
    paste("./infiles_gtf-gff3/already", t_gff3, sep = "/")
)
t_gff3 <- t_gff3 %>% as.data.frame() %>% dplyr::as_tibble()


#  Subset combined_SC_KL_20S.gff3 for ID "mRNA" -------------------------------
#+ (specified in the call to htseq-count)
t_gff3 <- t_gff3[t_gff3$type == "XUT", ]

#QUESTION 1/2 No processing needed with type XUT? How about other types in
#QUESTION 2/2 combined_AG.sans-chr.gff3?
# t_gff3$gene_id <- t_gff3$gene_id %>%
#     gsub("^transcript\\:", "", .) %>%
#     gsub("_mRNA", "", .)


#  Subset tibble to keep only relevant columns --------------------------------
keep <- c(
    "seqnames", "start", "end", "width", "strand", "type", "gene_id"
)
t_gff3 <- t_gff3[, colnames(t_gff3) %in% keep]
rm(keep)


#  Rename column "seqnames" to "chr" and column "Name" to "names" -------------
t_gff3 <- t_gff3 %>% dplyr::rename(c(chr = seqnames, features = gene_id))


#  Join t_mat and t_gff3 ------------------------------------------------------
t_mat <- dplyr::full_join(t_gff3, t_mat, by = "features")
rm(t_gff3)


#  Order tibble by chromosome names and feature start positions ---------------
chr_SC <- c(
    "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
    "XIII", "XIV", "XV", "XVI"
)
t_mat$chr <- t_mat$chr %>% as.factor()
t_mat$chr <- ordered(t_mat$chr, levels = chr_SC)

t_mat <- t_mat %>% dplyr::arrange(chr, start)


#  Categorize chromosomes by genome of origin ---------------------------------
t_mat$genome <- ifelse(
    t_mat$chr %in% chr_SC, "S_cerevisiae", NA
) %>%
    as.factor()

#  Move the new column "genome" to a better location in the tibble ------------
t_mat <- t_mat %>% dplyr::relocate("genome", .before = "chr")


#  Check on variable/column "genome" ------------------------------------------
levels(t_mat$genome)
t_mat %>%
    dplyr::group_by(genome) %>%
    dplyr::summarize(tally = length(genome))
#  The code returns...
# S_cerevisiae = 1657, NA = 5


#  Clean up -------------------------------------------------------------------
rm(chr_KL, chr_SC, chr_order)
