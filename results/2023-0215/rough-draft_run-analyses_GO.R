#!/usr/bin/env Rscript

#  rough-draft_run-analyses_GO.R
#  KA


suppressMessages(library(tidyverse))


#  Initialize functions, ggplots themes =======================================
load_panther_results <- function(file) {
    df <- readr::read_tsv(
        file, skip = 11, show_col_types = FALSE
    )
    
    return(df)
}


plot_top_terms_pantherdb <- function(df, top_n) {
    #  Perform debugging
    run <- FALSE
    if(base::isTRUE(run)) {
        top_n <- 15
        df <- BP_PC1_pos_100
    }
    
    p <- df %>%
        dplyr::mutate(q = -log10(`upload_1 (FDR)`)) %>%
        dplyr::rename(GO_BP = `GO biological process complete`) %>%
        dplyr::arrange(desc(q)) %>%
        dplyr::slice_head(n = top_n) %>%
        ggplot2::ggplot(aes(x = reorder(GO_BP, q), y = q)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        xlab("GO BP") +
        ylab("-log10(q)") +
        ggtitle(paste(
            "GO BP:",
            deparse(substitute(df)) %>%
                gsub("df_", "", .) %>%
                gsub("_", ", ", .) %>%
                gsub("BP, ", "", .)
        )) +
        theme_slick
    
    return(p)
}


load_yeastmine_results <- function(file) {
    df <- readr::read_tsv(
        file,
        col_names = c("term", "q_BH", "features", "n_GO"),
        show_col_types = FALSE
    )
    
    return(df)
}


plot_top_terms_YeastMine <- function(df, top_n) {
    #  Perform debugging
    run <- FALSE
    if(base::isTRUE(run)) {
        top_n <- 15
        df <- group_1
    }
    
    p <- df %>%
        dplyr::mutate(q = -log10(q_BH)) %>%
        dplyr::arrange(desc(q)) %>%
        dplyr::slice_head(n = top_n) %>%
        ggplot2::ggplot(aes(x = reorder(term, q), y = q)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        xlab("") +
        ylab("-log10(q)") +
        ggtitle(paste(
            "GO terms:",
            deparse(substitute(df)) %>%
                gsub("df_", "", .) %>%
                gsub("_", ", ", .) %>%
                gsub("BP, ", "", .)
        )) +
        theme_minimal()
    
    return(p)
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
p_exp <- "2022-2023_RRP6-NAB3/results/2023-0215"

#  Set work dir
paste(p_base, p_exp, sep = "/") %>% setwd()
# getwd()

p_GO <- "notebook/KA.2023-0626-0627.PCA-GO-TPM_Ovation"
f_pre <- "PCA.2023-0625__Ovation__mRNA.feature-list-"
f_suf <- ".YeastMine-GO.tsv"

run <- FALSE
if(base::isTRUE(run)) dir.exists(p_GO)

#  GO using top 100 features
run <- FALSE
if(base::isTRUE(run)) {
    f_PC1_pos_BP_100 <- paste0(f_pre, "100.PC1-pos", f_suf)
    f_PC2_pos_BP_100 <- paste0(f_pre, "100.PC2-pos", f_suf)
    f_PC3_pos_BP_100 <- paste0(f_pre, "100.PC3-pos", f_suf)
    f_PC1_neg_BP_100 <- paste0(f_pre, "100.PC1-neg", f_suf)
    f_PC2_neg_BP_100 <- paste0(f_pre, "100.PC2-neg", f_suf)
    f_PC3_neg_BP_100 <- paste0(f_pre, "100.PC3-neg", f_suf)
}

#  GO using top 200 features
run <- FALSE
if(base::isTRUE(run)) {
    f_PC1_pos_BP_200 <- paste0(f_pre, "200.PC1-pos", f_suf)
    f_PC2_pos_BP_200 <- paste0(f_pre, "200.PC2-pos", f_suf)
    f_PC3_pos_BP_200 <- paste0(f_pre, "200.PC3-pos", f_suf)
    f_PC1_neg_BP_200 <- paste0(f_pre, "200.PC1-neg", f_suf)
    f_PC2_neg_BP_200 <- paste0(f_pre, "200.PC2-neg", f_suf)
    f_PC3_neg_BP_200 <- paste0(f_pre, "200.PC3-neg", f_suf)
}

#  GO using top 500 features
run <- TRUE
if(base::isTRUE(run)) {
    f_PC1_pos_BP_500 <- paste0(f_pre, "500.PC1-pos", f_suf)
    f_PC2_pos_BP_500 <- paste0(f_pre, "500.PC2-pos", f_suf)
    f_PC3_pos_BP_500 <- paste0(f_pre, "500.PC3-pos", f_suf)
    f_PC1_neg_BP_500 <- paste0(f_pre, "500.PC1-neg", f_suf)
    f_PC2_neg_BP_500 <- paste0(f_pre, "500.PC2-neg", f_suf)
    f_PC3_neg_BP_500 <- paste0(f_pre, "500.PC3-neg", f_suf)
}


#  Panther, 100 features
run <- FALSE
if(base::isTRUE(run)) {
    BP_PC1_pos_100 <- load_yeastmine_results(
        paste(p_GO, f_PC1_pos_BP_100, sep = "/")
    )
    BP_PC1_neg_100 <- load_yeastmine_results(
        paste(p_GO, f_PC1_neg_BP_100, sep = "/")
    )

    BP_PC2_pos_100 <- load_yeastmine_results(
        paste(p_GO, f_PC2_pos_BP_100, sep = "/")
    )
    BP_PC2_neg_100 <- load_yeastmine_results(
        paste(p_GO, f_PC2_neg_BP_100, sep = "/")
    )
    
    BP_PC3_pos_100 <- load_yeastmine_results(
        paste(p_GO, f_PC3_pos_BP_100, sep = "/")
    )
    BP_PC3_neg_100 <- load_yeastmine_results(
        paste(p_GO, f_PC3_neg_BP_100, sep = "/")
    )
}

#  Panther, 200 features
run <- FALSE
if(base::isTRUE(run)) {
    BP_PC1_pos_200 <- load_yeastmine_results(
        paste(p_GO, f_PC1_pos_BP_200, sep = "/")
    )
    BP_PC1_neg_200 <- load_yeastmine_results(
        paste(p_GO, f_PC1_neg_BP_200, sep = "/")
    )

    BP_PC2_pos_200 <- load_yeastmine_results(
        paste(p_GO, f_PC2_pos_BP_200, sep = "/")
    )
    BP_PC2_neg_200 <- load_yeastmine_results(
        paste(p_GO, f_PC2_neg_BP_200, sep = "/")
    )

    BP_PC3_pos_200 <- load_yeastmine_results(
        paste(p_GO, f_PC3_pos_BP_200, sep = "/")
    )
    BP_PC3_neg_200 <- load_yeastmine_results(
        paste(p_GO, f_PC3_neg_BP_200, sep = "/")
    )
}

#  Panther, 500 features
# run <- TRUE
# if(base::isTRUE(run)) {
    if(file.exists(paste(p_GO, f_PC1_pos_BP_500, sep = "/"))) {
        BP_PC1_pos_500 <- load_yeastmine_results(
            paste(p_GO, f_PC1_pos_BP_500, sep = "/")
        )
    } else {
        paste("File does not exists", paste(p_GO, f_PC1_pos_BP_500, sep = "/"))
    }
    
    if(file.exists(paste(p_GO, f_PC1_neg_BP_500, sep = "/"))) {
        BP_PC1_neg_500 <- load_yeastmine_results(
            paste(p_GO, f_PC1_neg_BP_500, sep = "/")
        )
    } else {
        paste("File does not exists", paste(p_GO, f_PC1_neg_BP_500, sep = "/"))
    }
    
    if(file.exists(paste(p_GO, f_PC2_pos_BP_500, sep = "/"))) {
        BP_PC2_pos_500 <- load_yeastmine_results(
            paste(p_GO, f_PC2_pos_BP_500, sep = "/")
        )
    } else {
        paste("File does not exists", paste(p_GO, f_PC2_pos_BP_500, sep = "/"))
    }
    
    if(file.exists(paste(p_GO, f_PC2_neg_BP_500, sep = "/"))) {
        BP_PC2_neg_500 <- load_yeastmine_results(
            paste(p_GO, f_PC2_neg_BP_500, sep = "/")
        )
    } else {
        paste("File does not exists", paste(p_GO, f_PC2_neg_BP_500, sep = "/"))
    }
    
    if(file.exists(paste(p_GO, f_PC3_pos_BP_500, sep = "/"))) {
        BP_PC3_pos_500 <- load_yeastmine_results(
            paste(p_GO, f_PC3_pos_BP_500, sep = "/")
        )
    } else {
        paste("File does not exists", paste(p_GO, f_PC3_pos_BP_500, sep = "/"))
    }
    
    if(file.exists(paste(p_GO, f_PC3_neg_BP_500, sep = "/"))) {
        BP_PC3_neg_500 <- load_yeastmine_results(
            paste(p_GO, f_PC3_neg_BP_500, sep = "/")
        )
    } else {
        paste("File does not exists", paste(p_GO, f_PC3_neg_BP_500, sep = "/"))
    }
# }

top_n <- 15
run <- TRUE
if(base::isTRUE(run)) {
    # bars_BP_PC1_neg_100 <- plot_top_terms_YeastMine(BP_PC1_neg_100, top_n)
    # bars_BP_PC1_neg_200 <- plot_top_terms_YeastMine(BP_PC1_neg_200, top_n)
    bars_BP_PC1_neg_500 <- plot_top_terms_YeastMine(BP_PC1_neg_500, top_n)
    
    # bars_BP_PC2_neg_100 <- plot_top_terms_YeastMine(BP_PC2_neg_100, top_n)
    # bars_BP_PC2_neg_200 <- plot_top_terms_YeastMine(BP_PC2_neg_200, top_n)
    # bars_BP_PC2_neg_500 <- plot_top_terms_YeastMine(BP_PC2_neg_500, top_n)  #DOESNOTEXIST

    # bars_BP_PC3_neg_100 <- plot_top_terms_YeastMine(BP_PC3_neg_100, top_n)
    # bars_BP_PC3_neg_200 <- plot_top_terms_YeastMine(BP_PC3_neg_200, top_n)
    bars_BP_PC3_neg_500 <- plot_top_terms_YeastMine(BP_PC3_neg_500, top_n)
    
    # bars_BP_PC1_pos_100 <- plot_top_terms_YeastMine(BP_PC1_pos_100, top_n)
    # bars_BP_PC1_pos_200 <- plot_top_terms_YeastMine(BP_PC1_pos_200, top_n)
    bars_BP_PC1_pos_500 <- plot_top_terms_YeastMine(BP_PC1_pos_500, top_n)
    
    # bars_BP_PC2_pos_100 <- plot_top_terms_YeastMine(BP_PC2_pos_100, top_n)
    # bars_BP_PC2_pos_200 <- plot_top_terms_YeastMine(BP_PC2_pos_200, top_n)
    bars_BP_PC2_pos_500 <- plot_top_terms_YeastMine(BP_PC2_pos_500, top_n)

    # bars_BP_PC3_pos_100 <- plot_top_terms_YeastMine(BP_PC3_pos_100, top_n)
    # bars_BP_PC3_pos_200 <- plot_top_terms_YeastMine(BP_PC3_pos_200, top_n)
    bars_BP_PC3_pos_500 <- plot_top_terms_YeastMine(BP_PC3_pos_500, top_n)
}

run <- TRUE
if(base::isTRUE(run)) {
    # print(bars_BP_PC1_neg_100)
    # print(bars_BP_PC2_neg_100)
    # print(bars_BP_PC3_neg_100)
    # 
    # print(bars_BP_PC1_neg_200)
    # print(bars_BP_PC2_neg_200)
    # print(bars_BP_PC3_neg_200)
    # 
    # print(bars_BP_PC1_neg_500)
    # print(bars_BP_PC2_neg_500)
    # print(bars_BP_PC3_neg_500)
    
    # print(bars_BP_PC1_neg_100)
    # print(bars_BP_PC1_neg_200)
    print(bars_BP_PC1_neg_500)
    
    # print(bars_BP_PC2_neg_100)
    # print(bars_BP_PC2_neg_200)
    # print(bars_BP_PC2_neg_500)  #DOESNOTEXIST
    
    # print(bars_BP_PC3_neg_100)
    # print(bars_BP_PC3_neg_200)
    print(bars_BP_PC3_neg_500)
    
    # print(bars_BP_PC1_pos_100)
    # print(bars_BP_PC2_pos_100)
    # print(bars_BP_PC3_pos_100)
    # 
    # print(bars_BP_PC1_pos_200)
    # print(bars_BP_PC2_pos_200)
    # print(bars_BP_PC3_pos_200)
    # 
    # print(bars_BP_PC1_pos_500)
    # print(bars_BP_PC2_pos_500)
    # print(bars_BP_PC3_pos_500)
    
    # print(bars_BP_PC1_pos_100)
    # print(bars_BP_PC1_pos_200)
    print(bars_BP_PC1_pos_500)
    
    # print(bars_BP_PC2_pos_100)
    # print(bars_BP_PC2_pos_200)
    print(bars_BP_PC2_pos_500)
    
    # print(bars_BP_PC3_pos_100)
    # print(bars_BP_PC3_pos_200)
    print(bars_BP_PC3_pos_500)
}

#  Save PC1 results
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC1_pos_100)), ".png"),
#     bars_BP_PC1_pos_100
# )
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC1_pos_200)), ".png"),
#     bars_BP_PC1_pos_200
# )
ggsave(
    paste0(getwd(), "/", deparse(substitute(bars_BP_PC1_pos_500)), ".png"),
    bars_BP_PC1_pos_500
)

# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC1_neg_100)), ".png"),
#     bars_BP_PC1_neg_100
# )
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC1_neg_200)), ".png"),
#     bars_BP_PC1_neg_200
# )
ggsave(
    paste0(getwd(), "/", deparse(substitute(bars_BP_PC1_neg_500)), ".png"),
    bars_BP_PC1_neg_500
)

#  Save PC2 results
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC2_pos_100)), ".png"),
#     bars_BP_PC2_pos_100
# )
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC2_pos_200)), ".png"),
#     bars_BP_PC2_pos_200
# )
ggsave(
    paste0(getwd(), "/", deparse(substitute(bars_BP_PC2_pos_500)), ".png"),
    bars_BP_PC2_pos_500
)

# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC2_neg_100)), ".png"),
#     bars_BP_PC2_neg_100
# )
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC2_neg_200)), ".png"),
#     bars_BP_PC2_neg_200
# )
# ggsave(
#     paste0(getwd(), "/", deparse(substitute(bars_BP_PC2_neg_500)), ".png"),
#     bars_BP_PC2_neg_500
# )  #DOESNOTEXIST

ggsave(
    paste0(getwd(), "/", deparse(substitute(bars_BP_PC3_pos_500)), ".png"),
    bars_BP_PC3_pos_500
)
ggsave(
    paste0(getwd(), "/", deparse(substitute(bars_BP_PC3_neg_500)), ".png"),
    bars_BP_PC3_neg_500
)
