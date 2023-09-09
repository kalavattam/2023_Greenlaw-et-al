#!/bin/env Rscript

#  rough-draft_write-gtf-blacklist.R
#  KA
#  2023-0404


#  Load in combined_SC_KL_20S.gff3 ============================================
#  Get situated ---------------------------------------------------------------
library(GenomicRanges)
library(plyr)
library(rtracklayer)
library(tidyverse)

if(stringr::str_detect(getwd(), "kalavattam")) {
    p_local <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_local <- "/Users/kalavatt/projects-etc"
}
p_wd <- "2022-2023_RRP6-NAB3/results/2023-0215"

setwd(paste(p_local, p_wd, sep = "/"))
getwd()

rm(p_local, p_wd)


#  Load combined_SC_KL_20S.gff3 -----------------------------------------------
p_gff3 <- "./infiles_gtf-gff3/already"
f_gff3 <- "combined_SC_KL_20S.gff3"
t_gff3 <- rtracklayer::import(paste(p_gff3, f_gff3, sep = "/"))
t_gff3 <- t_gff3 %>% as.data.frame() %>% dplyr::as_tibble()

rm(p_gff3, f_gff3)


#  Isolate tibbles of rRNA and tRNA features ----------------------------------
t_gff3_rRNA_tRNA <- t_gff3 %>%
    dplyr::filter(grepl("rRNA|RDN|tRNA|t.\\(", ID)) %>%
    dplyr::arrange(seqnames, start, end, type, ID)


#  Write out t_gff3_rRNA_tRNA as a bed file -----------------------------------
#  gtf/gff3 are 1-based; bed is 0-based, as is bam
#+ More details: tidyomics.com/blog/2018/12/09/2018-12-09-the-devil-0-and-1-coordinate-system-in-genomics/

#  On the format of bed files
#+ - genome.ucsc.edu/FAQ/FAQformat.html#format1
#+ - en.wikipedia.org/wiki/BED_(file_format)

t_bed_rRNA_tRNA <- tibble::tibble(
    chr = t_gff3_rRNA_tRNA$seqnames,
    start = t_gff3_rRNA_tRNA$start,
    # start = t_gff3_rRNA_tRNA$start - 1,  # No need: rtracklayer handles this
    end = t_gff3_rRNA_tRNA$end,
    name = t_gff3_rRNA_tRNA$ID,
    score = rep(0, nrow(t_gff3_rRNA_tRNA)),
    strand = t_gff3_rRNA_tRNA$strand
)


#  Collapse overlapping chromosomal regions -----------------------------------
#  Retain only unique ranges
condensed <- unique(t_bed_rRNA_tRNA[, 1:3])

#  Sort by chromosome and start position
condensed <- condensed[order(condensed$chr, condensed$start), ]

#  Evaluate if records should be linked with previous records by evaluating
#+ current chromosome-specific start position by preceding same-chromosome end
#+ position
condensed <- plyr::ddply(
    condensed,
    "chr",
    function(u) { 
        x <- c(NA, u$end[-nrow(u)])
        y <- ifelse(is.na(x), 0, x)
        y <- cummax(y)
        y[is.na(x)] <- NA
        u$end_previous <- y
        return(u)
    }
)
condensed$new_group <- is.na(condensed$end_previous) | condensed$start >= condensed$end_previous

#  The number of groups of records is the number of times we have
#+ switched to a new group
condensed$group <- cumsum(condensed$new_group)

#  Aggregate the data by groups
condensed <- plyr::ddply(
    condensed,
    .(chr, group),
    summarize, 
    start = min(start),
    end = max(end)
) %>% 
    dplyr::select(-group)

p_out <- "./outfiles_gtf-gff3/already"
f_out <- "SC_features-rRNA-tRNA.bed"
rtracklayer::export(condensed, paste(p_out, f_out, sep = "/"))

rm(p_out, f_out)


#  Write out t_gff3_rRNA_tRNA as a gtf file -----------------------------------
p_out <- "./outfiles_gtf-gff3/already"
f_out <- "SC_features-rRNA-tRNA.gtf"
rtracklayer::export(t_gff3_rRNA_tRNA, paste(p_out, f_out, sep = "/"))

rm(p_out, f_out)


#  Looking into Ty* elements --------------------------------------------------
t_gff3$type %>% as.factor() %>% levels()

#  Downloaded list of features involved in S. cerevisiae retrotransposition:
#+ yeastgenome.org/go/GO:0032197

test <- t_gff3 %>% 
    dplyr::filter(grepl("YARCTyB1", ID))
