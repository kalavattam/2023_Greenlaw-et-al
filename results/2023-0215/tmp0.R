
# tmp1.R
# KA

Q_N_wt_r1_r6 <- c(
    "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"
)
Q_SS_wt_r1_r6 <- c(  #BATCH
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"
)
Q_SS_wt_ot_r1_r6_n3 <- c(  #BATCH
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
    "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
    "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1",
    "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1"
)
Q_N_wt_ot_r1_r6_n3 <- c(
    "WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
    "o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
    "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1",
    "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1",
    "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1",
    "n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1"
)
tc_SS_wt_r6 <- c(  #BATCH
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"
)
tc_SS_wt_t4_r6 <- c(  #BATCH
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"
)
Q_tc_SS_wt_ot_r1_r6_n3 <- c(  #BATCH
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2",
    "WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1",
    "o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2",
    "r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1",
    "r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1",
    "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1",
    "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1",
    "n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1"
)
G1_Q_SS_N_wt <- c(
    "WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1",
    "WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1",
    "WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1",
    "WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1",
    "WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1",
    "WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1",
    "WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1",
    "WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1"
)

#  Make a named list
datasets_gw <- list(
    "Q_N_wt_r1_r6" = Q_N_wt_r1_r6,
    "Q_SS_wt_r1_r6" = Q_SS_wt_r1_r6,
    "Q_SS_wt_ot_r1_r6_n3" = Q_SS_wt_ot_r1_r6_n3,
    "Q_N_wt_ot_r1_r6_n3" = Q_N_wt_ot_r1_r6_n3,
    "tc_SS_wt_r6" = tc_SS_wt_r6,
    "tc_SS_wt_t4_r6" = tc_SS_wt_t4_r6,
    "Q_tc_SS_wt_ot_r1_r6_n3" = Q_tc_SS_wt_ot_r1_r6_n3,
    "G1_Q_SS_N_wt" = G1_Q_SS_N_wt
)

res_gw <- list()
for (i in 1:length(datasets_gw)) {
    # i <- 7
    cat(paste0(
        "#  --------------------------------------------------------\n",
        "#  Working with '", names(datasets_gw)[[i]], "'\n",
        "#  --------------------------------------------------------\n\n"
    ))
    
    res_gw[[names(datasets_gw)[[i]]]] <- list()
    
    #  0 ------------------------------
    cat("#+ 0. Datasets are...\n\n")
    print(datasets_gw[[i]])
    cat("\n")
    
    #  Initialize variable 'datasets'
    datasets <- datasets_gw[[i]]
    
    res_gw[[names(datasets_gw)[[i]]]][["n00_datasets"]] <- datasets
    
    #  1 ------------------------------
    cat(paste0(
        "#+ 1. Creating 'counts_data' matrix for '",
        names(datasets_gw)[[i]],
        "'\n\n"
    ))
    counts_data <- t_fc[, colnames(t_fc) %in% datasets] %>%
        as.data.frame()
    
    res_gw[[names(datasets_gw)[[i]]]][["n01_counts_data"]] <- counts_data
    
    #  2 ------------------------------
    cat(paste0(
        "#+ 2. Isolate datasets of interest for '",
        names(datasets_gw)[[i]],
        "' ('col_data')\n\n"
    ))
    
    col_data <- samples[samples$keys %in% datasets, ] %>%
        as.data.frame() %>%  #IMPORTANT Output a dataframe, not a tibble
        tibble::column_to_rownames(., var = "keys") %>%  #IMPORTANT Have row names
        droplevels()
    col_data  #TBD
    
    #NOTE Version that drops hyphens from values
    # col_data <- samples[samples$keys %in% datasets, ] %>%
    #     lapply(., gsub, pattern = "-", replacement = "") %>%  # Get rid of hyphens
    #     as.data.frame() %>%  #IMPORTANT Output a dataframe, not a tibble
    #     tibble::column_to_rownames(., var = "keys") %>%  #IMPORTANT Have row names
    #     droplevels()  # Drop any unused factor levels
    
    res_gw[[names(datasets_gw)[[i]]]][["n02_col_data"]] <- col_data
    
    #  3 ------------------------------
    cat(paste0(
        "#+ 3. Do explicit ordering of relevant factors for '",
        names(datasets_gw)[[i]],
        "'\n\n"
    ))
    
    # strain_what_combos <- list(
    #     "WT_r1-n_r6-n" = c("WT", "r1-n", "r6-n"),
    #     "WT_o-d_r1-n_r6-n_n3-d" = c("WT", "o-d", "r1-n", "r6-n", "n3-d"),
    #     "WT_r6-n" = c("WT", "r6-n"),
    #     "WT_t4-n_r6-n" = c("WT", "t4-n", "r6-n"),
    #     "WT" = c("WT")
    # )
    # strain_what_levels <- col_data$strain %>% as.factor() %>% levels()
    
    #  Logic to carefully, correctly assign model numerators, denominators
    
    if(isTRUE(names(datasets_gw)[[i]] == "Q_N_wt_r1_r6")) {
        strain_1 <- "WT"
        strain_2 <- "r1-n"
        strain_3 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2, strain_3)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        if(all(col_data$technical %in% c("tech1", "tech2"))) {
            tech_1 <- "tech1"
            tech_2 <- "tech2"
            col_data$technical <- factor(
                col_data$technical, levels = c(tech_1, tech_2)
            )
            string_tech <- paste(levels(col_data$technical), collapse = " ")
        }
        
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_SS_wt_r1_r6")) {
        strain_1 <- "WT"
        strain_2 <- "o-d"
        strain_3 <- "r1-n"
        strain_4 <- "r6-n"
        strain_5 <- "n3-d"
        col_data$strain <- factor(
            col_data$strain, levels = c(
                strain_1, strain_2, strain_3, strain_4, strain_5
            )
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        if(all(col_data$technical %in% c("tech1", "tech2"))) {
            tech_1 <- "tech1"
            tech_2 <- "tech2"
            col_data$technical <- factor(
                col_data$technical, levels = c(tech_1, tech_2)
            )
            string_tech <- paste(levels(col_data$technical), collapse = " ")
        }
        
        if(all(col_data$state %in% c("Q", "DSm2", "DSp2", "DSp24", "DSp48"))) {
            state_1 <- "Q"
            state_2 <- "DSm2"
            state_3 <- "DSp2"
            state_4 <- "DSp24"
            state_5 <- "DSp48"
            col_data$state <- factor(
                col_data$state, levels = c(
                    state_1, state_2, state_3, state_4, state_5
                )
            )
        }
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_SS_wt_ot_r1_r6_n3")) {
        strain_1 <- "WT"
        strain_2 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        state_1 <- "DSm2"
        state_2 <- "DSp2"
        state_3 <- "DSp24"
        state_4 <- "DSp48"
        col_data$state <- factor(
            col_data$state, levels = c(state_1, state_2, state_3, state_4)
        )
        string_state <- paste(levels(col_data$state), collapse = " ")
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_N_wt_ot_r1_r6_n3")) {
        strain_1 <- "WT"
        strain_2 <- "t4-n"
        strain_3 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2, strain_3)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        state_1 <- "DSm2"
        state_2 <- "DSp2"
        state_3 <- "DSp24"
        state_4 <- "DSp48"
        col_data$state <- factor(
            col_data$strain, levels = c(state_1, state_2, state_3, state_4)
        )
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
    } else if(isTRUE(names(datasets_gw)[[i]] == "tc_SS_wt_r6")) {
        strain_1 <- "WT"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
    } else if(isTRUE(names(datasets_gw)[[i]] == "tc_SS_wt_t4_r6")) {
        
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_tc_SS_wt_ot_r1_r6_n3")) {
        
    } else if(isTRUE(names(datasets_gw)[[i]] == "G1_Q_SS_N_wt")){
        
    }

    #  Logic to include "technical" in the GLM or not
    if(isTRUE(any(unique(col_data$technical) %in% "tech2"))) {
        model_linear <- "~ 1"
    } else if(isFALSE(any(unique(col_data$technical) %in% "tech2"))) {
        model_linear <- "~ 1"
    }

    cat(paste0(
        "         levels, strain  ", paste(levels(col_data$strain), collapse = ", "), "\n",
        "    level order, strain  ", string_strain, "\n",
        "           linear model  ", model_linear, "\n\n"
    ))

    res_gw[[names(datasets_gw)[[i]]]][["n03_strain_levels_strain"]] <- paste(levels(col_data$strain), collapse = ", ")
    res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
    res_gw[[names(datasets_gw)[[i]]]][["n03_model_linear"]] <- model_linear
}

cat("Q_N_wt_r1_r6\n")
res_gw$Q_N_wt_r1_r6$n02_col_data
cat("\n")

cat("Q_SS_wt_r1_r6\n")
res_gw$Q_SS_wt_r1_r6$n02_col_data
cat("\n")

cat("Q_SS_wt_ot_r1_r6_n3\n")
res_gw$Q_SS_wt_ot_r1_r6_n3$n02_col_data
cat("\n")

cat("Q_N_wt_ot_r1_r6_n3\n")
res_gw$Q_N_wt_ot_r1_r6_n3$n02_col_data
cat("\n")

cat("tc_SS_wt_r6\n")
res_gw$tc_SS_wt_r6$n02_col_data
cat("\n")

cat("tc_SS_wt_t4_r6\n")
res_gw$tc_SS_wt_t4_r6$n02_col_data
cat("\n")

cat("Q_tc_SS_wt_ot_r1_r6_n3\n")
res_gw$Q_tc_SS_wt_ot_r1_r6_n3$n02_col_data
cat("\n")

cat("G1_Q_SS_N_wt\n")
res_gw$G1_Q_SS_N_wt$n02_col_data
cat("\n")




