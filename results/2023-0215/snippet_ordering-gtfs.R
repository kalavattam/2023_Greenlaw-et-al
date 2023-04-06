
#  snippet_ordering-gtfs.R

library(GenomicRanges)
library(IRanges)
library(readxl)
library(rtracklayer)
library(tidyverse)

options(scipen = 999)
options(ggrepel.max.overlaps = Inf)

if(stringr::str_detect(getwd(), "kalavattam")) {
    p_local <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_local <- "/Users/kalavatt/projects-etc"
}
p_wd <- "2022_transcriptome-construction/results/2023-0215"

setwd(paste(p_local, p_wd, sep = "/"))
getwd()

rm(p_local, p_wd)


gtf <- "Q_mkc-1_gte-pctl-40.gtf"
gtf <- rtracklayer::import(gtf)
gtf <- gtf %>%
    as.data.frame() %>%
    tibble::as_tibble() %>%
    dplyr::arrange(seqnames, start, end, desc(type))

rtracklayer::export(gtf, "Q_mkc-1_gte-pctl-40.ordered.gtf")
