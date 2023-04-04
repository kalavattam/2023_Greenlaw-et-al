
#  Load in combined_SC_KL_20S.gff3 ============================================
#  Get situated ---------------------------------------------------------------
library(GenomicRanges)
library(rtracklayer)
library(tidyverse)

if(stringr::str_detect(getwd(), "kalavattam")) {
    p_local <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_local <- "/Users/kalavatt/projects-etc"
}
p_wd <- "2022_transcriptome-construction/results/2023-0215"

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


#  Write out t_gff3_rRNA_tRNA as a gtf file -----------------------------------
p_out <- "./outfiles_gtf-gff3/already"
f_out <- "SC_features-rRNA-tRNA.gtf"
rtracklayer::export(t_gff3_rRNA_tRNA, paste(p_out, f_out, sep = "/"))


#  Looking into Ty* elements --------------------------------------------------
t_gff3$type %>% as.factor() %>% levels()

#  Downloaded list of features involved in S. cerevisiae retrotransposition:
#+ yeastgenome.org/go/GO:0032197

test <- t_gff3 %>% 
    dplyr::filter(grepl("YARCTyB1", ID))
