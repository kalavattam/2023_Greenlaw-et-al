#!/usr/bin/env Rscript

#  run_chi-sq_quantile-filtered-coding-assignments.R
#  KA
#  2023-0414

library(tidyverse)
library(readxl)

if(stringr::str_detect(getwd(), "kalavattam")) {
    p_local <- "/Users/kalavattam/Dropbox/FHCC"
} else {
    p_local <- "/Users/kalavatt/projects-etc"
}
p_wd <- "2022-2023_RRP6-NAB3/results/2023-0215"

setwd(p_wd)
# getwd()

test_20_30 <- readxl::read_xlsx("data-for-chi-sq.xlsx", sheet = "20_30")
test_25 <- readxl::read_xlsx("data-for-chi-sq.xlsx", sheet = "25")

test_20_30 <- column_to_rownames(test_20_30, var = "sample")
test_25 <- column_to_rownames(test_25, var = "sample")

chisq.test(test_20_30)
chisq.test(test_25)

test_20_30 %>% dplyr::select(-"ambiguous") %>% fisher.test()
test_25 %>% dplyr::select(-"ambiguous") %>% fisher.test()

test_20_30 %>% dplyr::select(-"ambiguous") %>% chisq.test()
test_25 %>% dplyr::select(-"ambiguous") %>% chisq.test()
