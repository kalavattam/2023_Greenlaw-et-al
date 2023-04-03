
# tmp-gw.R
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
    # i <- 1
    cat(paste0(
        "#  --------------------------------------------------------\n",
        "#  Working with '", names(datasets_gw)[[i]], "'\n",
        "#  --------------------------------------------------------\n\n"
    ))
    
    res_gw[[names(datasets_gw)[[i]]]] <- list()
    

    #  0. Assign datasets -----------------------------------------------------
    cat("#+ 0. Datasets are...\n\n")
    print(datasets_gw[[i]])
    cat("\n")
    
    #  Initialize variable 'datasets'
    datasets <- datasets_gw[[i]]
    
    res_gw[[names(datasets_gw)[[i]]]][["n00_datasets"]] <- datasets
    
    
    #  1. Create 'counts_data' matrix -----------------------------------------
    cat(paste0(
        "#+ 1. Create 'counts_data' matrix for '",
        names(datasets_gw)[[i]],
        "'\n\n"
    ))
    counts_data <- t_hc[, colnames(t_hc) %in% datasets] %>%
        as.data.frame()
    counts_data <- sapply(counts_data, as.numeric)
    
    res_gw[[names(datasets_gw)[[i]]]][["n01_counts_data"]] <- counts_data
    
    
    #  2. Isolate datasets of interest ----------------------------------------
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
    
    
    #  3, 4. Do explicit ordering of relevant factors, etc. -------------------
    cat(paste0(
        "#+ 3, 4. Do explicit ordering of relevant factors for '",
        names(datasets_gw)[[i]],
        "', including factor-to-integer conversions\n\n"
    ))
    
    if(isTRUE(names(datasets_gw)[[i]] == "Q_N_wt_r1_r6")) {
        # datasets_gw[[1]]
        
        strain_1 <- "WT"
        strain_2 <- "r1-n"
        strain_3 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2, strain_3)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        rep_1 <- "rep1"
        rep_2 <- "rep2"
        col_data$replicate <- factor(
            col_data$replicate, levels = c(rep_1, rep_2)
        )
        string_replicate <- paste(levels(col_data$replicate), collapse = " ")
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_replicate"]] <- string_replicate
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "r1-n" = 2,
            "r6-n" = 3,
            USE.NAMES = FALSE
        )
        col_data$no_replicate <- sapply(
            as.character(col_data$replicate),
            switch,
            "rep1" = 1,
            "rep2" = 2,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_SS_wt_r1_r6")) {
        # datasets_gw[[2]]
        
        strain_1 <- "WT"
        strain_2 <- "r1-n"
        strain_3 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2, strain_3)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        rep_1 <- "rep1"
        rep_2 <- "rep2"
        col_data$replicate <- factor(
            col_data$replicate, levels = c(rep_1, rep_2)
        )
        string_replicate <- paste(levels(col_data$replicate), collapse = " ")
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_replicate"]] <- string_replicate
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_tech"]] <- string_tech
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "r1-n" = 2,
            "r6-n" = 3,
            USE.NAMES = FALSE
        )
        col_data$no_replicate <- sapply(
            as.character(col_data$replicate),
            switch,
            "rep1" = 1,
            "rep2" = 2,
            USE.NAMES = FALSE
        )
        col_data$no_technical <- sapply(
            as.character(col_data$technical),
            switch,
            "tech1" = 1,
            "tech2" = 2,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
        
        cat(paste0(
            "#+ 5. Make the DESeqDataSet (dds) object for '",
            names(datasets_gw)[[i]],
            "'\n\n"
        ))
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_SS_wt_ot_r1_r6_n3")) {
        # datasets_gw[[3]]
        
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
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_tech"]] <- string_tech
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "o-d" = 2,
            "r1-n" = 3,
            "r6-n" = 4,
            "n3-d" = 5,
            USE.NAMES = FALSE
        )
        col_data$no_technical <- sapply(
            as.character(col_data$technical),
            switch,
            "tech1" = 1,
            "tech2" = 2,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_N_wt_ot_r1_r6_n3")) {
        # datasets_gw[[4]]

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
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "o-d" = 2,
            "r1-n" = 3,
            "r6-n" = 4,
            "n3-d" = 5,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    } else if(isTRUE(names(datasets_gw)[[i]] == "tc_SS_wt_r6")) {
        # datasets_gw[[5]]

        strain_1 <- "WT"
        strain_2 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
        
        state_1 <- "DSm2"
        state_2 <- "DSp2"
        state_3 <- "DSp24"
        state_4 <- "DSp48"
        col_data$state <- factor(
            col_data$state, levels = c(state_1, state_2, state_3, state_4)
        )
        string_state <- paste(levels(col_data$state), collapse = " ")
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_tech"]] <- string_tech
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_state"]] <- string_state
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "r6-n" = 2,
            USE.NAMES = FALSE
        )
        col_data$no_technical <- sapply(
            as.character(col_data$technical),
            switch,
            "tech1" = 1,
            "tech2" = 2,
            USE.NAMES = FALSE
        )
        col_data$no_state <- sapply(
            as.character(col_data$state),
            switch,
            "DSm2" = 1,
            "DSp2" = 2,
            "DSp24" = 3,
            "DSp48" = 4,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    } else if(isTRUE(names(datasets_gw)[[i]] == "tc_SS_wt_t4_r6")) {
        # datasets_gw[[6]]
        
        strain_1 <- "WT"
        strain_2 <- "t4-n"
        strain_3 <- "r6-n"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1, strain_2, strain_3)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
        
        state_1 <- "DSm2"
        state_2 <- "DSp2"
        state_3 <- "DSp24"
        state_4 <- "DSp48"
        col_data$state <- factor(
            col_data$state, levels = c(state_1, state_2, state_3, state_4)
        )
        string_state <- paste(levels(col_data$state), collapse = " ")
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_tech"]] <- string_tech
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_state"]] <- string_state
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "t4-n" = 2,
            "r6-n" = 3,
            USE.NAMES = FALSE
        )
        col_data$no_technical <- sapply(
            as.character(col_data$technical),
            switch,
            "tech1" = 1,
            "tech2" = 2,
            USE.NAMES = FALSE
        )
        col_data$no_state <- sapply(
            as.character(col_data$state),
            switch,
            "DSm2" = 1,
            "DSp2" = 2,
            "DSp24" = 3,
            "DSp48" = 4,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    } else if(isTRUE(names(datasets_gw)[[i]] == "Q_tc_SS_wt_ot_r1_r6_n3")) {
        # datasets_gw[[7]]
        
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
        
        tech_1 <- "tech1"
        tech_2 <- "tech2"
        col_data$technical <- factor(
            col_data$technical, levels = c(tech_1, tech_2)
        )
        string_tech <- paste(levels(col_data$technical), collapse = " ")
        
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
        string_state <- paste(levels(col_data$state), collapse = " ")
        
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_tech"]] <- string_tech
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_state"]] <- string_state
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            "o-d" = 2,
            "r1-n" = 3,
            "r6-n" = 4,
            "n3-d" = 5,
            USE.NAMES = FALSE
        )
        col_data$no_technical <- sapply(
            as.character(col_data$technical),
            switch,
            "tech1" = 1,
            "tech2" = 2,
            USE.NAMES = FALSE
        )
        col_data$no_state <- sapply(
            as.character(col_data$state),
            switch,
            "Q" = 1,
            "DSm2" = 2,
            "DSp2" = 3,
            "DSp24" = 4,
            "DSp48" = 5,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    } else if(isTRUE(names(datasets_gw)[[i]] == "G1_Q_SS_N_wt")){
        # datasets_gw[[8]]
        
        strain_1 <- "WT"
        col_data$strain <- factor(
            col_data$strain, levels = c(strain_1)
        )
        string_strain <- paste(levels(col_data$strain), collapse = " ")
        
        state_1 <- "G1"
        state_2 <- "Q"
        col_data$state <- factor(col_data$state, levels = c(state_1, state_2))
        string_state <- paste(levels(col_data$state), collapse = " ")
        
        tx_1 <- "SS"
        tx_2 <- "N"
        col_data$transcription <- factor(
            col_data$transcription, levels = c(tx_1, tx_2)
        )
        string_tx <- paste(levels(col_data$transcription), collapse = " ")

        res_gw[[names(datasets_gw)[[i]]]][["n03_string_strain"]] <- string_strain
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_state"]] <- string_state
        res_gw[[names(datasets_gw)[[i]]]][["n03_string_tx"]] <- string_tx
        
        col_data$no_strain <- sapply(
            as.character(col_data$strain),
            switch,
            "WT" = 1,
            USE.NAMES = FALSE
        )
        col_data$no_state <- sapply(
            as.character(col_data$state),
            switch,
            "G1" = 1,
            "Q" = 2,
            USE.NAMES = FALSE
        )
        col_data$no_transcription <- sapply(
            as.character(col_data$transcription),
            switch,
            "SS" = 1,
            "N" = 2,
            USE.NAMES = FALSE
        )
        
        res_gw[[names(datasets_gw)[[i]]]][["n04_col_data"]] <- col_data
    }
    
    model_linear <- "~ 1"
    res_gw[[names(datasets_gw)[[i]]]] [["n03_model_linear"]] <- model_linear
    
    
    #  5. Make the DESeqDataSet (dds) object ----------------------------------
    cat(paste0(
        "#+ 5. Make the DESeqDataSet (dds) object for '",
        names(datasets_gw)[[i]],
        "'\n\n"
    ))
    
    dds <- DESeq2::DESeqDataSetFromMatrix(
        countData = counts_data,
        colData = col_data,
        design = ~ 1,
        rowRanges = pos_info
    )
    
    res_gw[[names(datasets_gw)[[i]]]][["n05_dds"]] <- dds
    res_gw[[names(datasets_gw)[[i]]]][["n05_design"]] <- dds@design
}


#     #  6 ------------------------------
#     cat(paste0(
#         "#+ 6. Create normalized counts for '",
#         names(datasets_gw)[[i]], "'\n\n"
#     ))
#     
#     if(isTRUE(names(datasets_gw)[[i]] == "Q_N_wt_r1_r6")) {
#         datasets_gw[[1]]
#         
#         #  ----------------
#         vsd <- DESeq2::vst(
#             dds[dds@rowRanges$genome == "S_cerevisiae", ],
#             blind = FALSE
#         ) %>%
#             SummarizedExperiment::assay() %>%
#             as.data.frame()
#         vsd$feature_init <- dds@rowRanges$feature_init[
#             dds@rowRanges$genome == "S_cerevisiae"
#         ]
#         
#         #  Associate normalized values with feature metadata
#         norm_v <- dplyr::full_join(
#             vsd,
#             t_hc[t_hc$genome == "S_cerevisiae", 1:9],
#             by = "feature_init"
#         ) %>%
#             dplyr::as_tibble()
#         
#         rm(vsd)
#         res_gw[[names(datasets_gw)[[i]]]][["n06_norm_v"]] <- norm_v
#         
#         #  ----------------
#         rld <- DESeq2::rlog(
#             dds[dds@rowRanges$genome == "S_cerevisiae", ],
#             blind = FALSE
#         ) %>%
#             SummarizedExperiment::assay() %>%
#             as.data.frame()
#         rld$feature_init <- dds@rowRanges$feature_init[
#             dds@rowRanges$genome == "S_cerevisiae"
#         ]
#         
#         #  Associate normalized values with feature metadata
#         norm_r <- dplyr::full_join(
#             rld,
#             t_hc[t_hc$genome == "S_cerevisiae", 1:9],
#             by = "feature_init"
#         ) %>%
#             dplyr::as_tibble()
#         
#         rm(rld)
#         res_gw[[names(datasets_gw)[[i]]]][["n06_norm_r"]] <- norm_r
#         
#         #TODO GeTMM, TPM normalizations
#     } else if(isTRUE(names(datasets_gw)[[i]] == "Q_SS_wt_r1_r6")) {
#         datasets_gw[[2]]
#         
#         #  ----------------
#         vsd <- DESeq2::vst(
#             dds[dds@rowRanges$genome == "S_cerevisiae", ],
#             blind = FALSE
#         )
#         
#         norm_v <- limma::removeBatchEffect(
#             SummarizedExperiment::assay(vsd),
#             batch = vsd$technical,
#             design = model.matrix(~strain, SummarizedExperiment::colData(vsd))
#         ) %>% 
#             as.data.frame()
#         norm_v$feature_init <- dds@rowRanges$feature_init[
#             dds@rowRanges$genome == "S_cerevisiae"
#         ]
#         
#         #  Associate normalized values with feature metadata
#         norm_v <- dplyr::full_join(
#             norm_v,
#             t_hc[t_hc$genome == "S_cerevisiae", 1:9],
#             by = "feature_init"
#         ) %>%
#             dplyr::as_tibble()
#         
#         rm(vsd)
#         
#         
#         #  ----------------
#         rld <- DESeq2::rlog(
#             dds[dds@rowRanges$genome == "S_cerevisiae", ],
#             blind = FALSE
#         )
#         
#         norm_r <- limma::removeBatchEffect(
#             SummarizedExperiment::assay(rld),
#             batch = rld$technical,
#             design = model.matrix(~strain, SummarizedExperiment::colData(rld))
#         ) %>% 
#             as.data.frame()
#         norm_r$feature_init <- dds@rowRanges$feature_init[
#             dds@rowRanges$genome == "S_cerevisiae"
#         ]
#         
#         #  Associate normalized values with feature metadata
#         norm_r <- dplyr::full_join(
#             norm_r,
#             t_hc[t_hc$genome == "S_cerevisiae", 1:9],
#             by = "feature_init"
#         ) %>%
#             dplyr::as_tibble()
#         
#         rm(rld)
#     } else if(isTRUE(names(datasets_gw)[[i]] == "Q_SS_wt_ot_r1_r6_n3")) {
#         datasets_gw[[3]]
#     } else if(isTRUE(names(datasets_gw)[[i]] == "Q_N_wt_ot_r1_r6_n3")) {
#         datasets_gw[[4]]
#     } else if(isTRUE(names(datasets_gw)[[i]] == "tc_SS_wt_r6")) {
#         datasets_gw[[5]]
#     } else if(isTRUE(names(datasets_gw)[[i]] == "tc_SS_wt_t4_r6")) {
#         datasets_gw[[6]]
#     } else if(isTRUE(names(datasets_gw)[[i]] == "Q_tc_SS_wt_ot_r1_r6_n3")) {
#         datasets_gw[[7]]
#     } else if(isTRUE(names(datasets_gw)[[i]] == "G1_Q_SS_N_wt")){
#         datasets_gw[[8]]
#     }
#     
#     #  7 ------------------------------
#     cat(paste0(
#         "#+ 7. Create a PCAtools 'pca' S4 object for the normalized counts ",
#         "associated with '", names(datasets_gw)[[i]], "'\n\n"
#     ))
#     norm <- norm_r
#     
#     #  Create a PCAtools "pca" S4 object for the normalized counts ------------
#     #+ Assign unique row names too
#     col_samp_TF <- stringr::str_detect(colnames(norm), "_tech")
#     col_samp_TF_N <- length(col_samp_TF[col_samp_TF ==  TRUE])
#     
#     obj_pca <- PCAtools::pca(
#         norm[, 1:col_samp_TF_N],
#         metadata = dds[dds@rowRanges$genome != "K_lactis", ]@colData
#     )
#     rownames(obj_pca$loadings) <- make.names(
#         dds[dds@rowRanges$genome != "K_lactis", ]@rowRanges$feature,
#         unique = TRUE
#     )
#     # colnames(obj_pca$loadings)
#     
#     #  8 ------------------------------
#     cat(paste0(
#         "#+ 8. Determine significant PCs for '",
#         names(datasets_gw)[[i]], "'\n\n"
#     ))
#     #  Determine "significant" PCs with Horn's parallel analysis
#     #+ See Horn, 1965
#     horn <- PCAtools::parallelPCA(mat = norm[, 1:col_samp_TF_N])
#     # horn$n
#     
#     
#     #  Determine "significant" principle components with the elbow method
#     #+ See Buja and Eyuboglu, 1992
#     elbow <- PCAtools::findElbowPoint(obj_pca$variance)
#     # elbow
#     
#     #  9 ------------------------------
#     cat(paste0(
#         "#+ 9. Draw a scree plot to evaluate cumulative proportion of ",
#         "explained variance for '", names(datasets_gw)[[i]], "'\n\n"
#     ))
#     #  Evaluate cumulative prop. of explained variance with a scree plot
#     scree <- draw_scree_plot(obj_pca, horn = horn$n, elbow = elbow)
#     scree
#     # save_title <- paste0("panel-plot", ".", "scree", ".pdf")
#     # ggplot2::ggsave(paste0(args$directory_out, "/", save_title), scree)
#     #TODO Work up some logic for location(s) for outfiles
#     
#     #  10 -----------------------------
#     cat(paste0(
#         "#+ 10. Evaluate the component loading vectors for the number of ",
#         "'significant' PCs for '", names(datasets_gw)[[i]], "'\n\n"
#     ))
#     
#     #  Save component loading vectors in their own data frame
#     loadings <- as.data.frame(obj_pca$loadings)
#     
#     #  Evaluate the component loading vectors for the number of significant PCs
#     #+ identified via the elbow method plus two
#     PCs <- paste0("PC", 1:(as.numeric(elbow) + 2))
#     top_loadings_all <- lapply(
#         PCs, get_top_loadings, x = loadings, z = "all", a = TRUE
#     )
#     top_loadings_pos <- lapply(
#         PCs, get_top_loadings, x = loadings, z = "pos", a = TRUE
#     )
#     top_loadings_neg <- lapply(
#         PCs, get_top_loadings, x = loadings, z = "neg", a = TRUE
#     )
#     
#     names(top_loadings_all) <-
#         names(top_loadings_pos) <-
#         names(top_loadings_neg) <-
#         PCs
#     # rm(PCs)
#     # top_loadings_all$PC1 %>% head(n = 20)
#     # top_loadings_pos$PC1 %>% head(n = 20)
#     # top_loadings_neg$PC1 %>% head(n = 20)
#     
#     #  11 -----------------------------
#     cat(paste0(
#         "#+ 11. Analyze positive, negative loadings on axes of biplots for ",
#         "'", names(datasets_gw)[[i]], "'\n\n"
#     ))
#     
#     # Look at the top 15 loading vectors per axis
#     images <- list()
#     mat <- combn(PCs, 2)
#     for(i in 1:ncol(mat)) {
#         # i <- 1
#         j <- mat[, i]
#         
#         PC_x <- x_label <- j[1]
#         PC_y <- y_label <- j[2]
#         
#         images[[paste0("PCAtools.", PC_x, ".v.", PC_y)]] <- plot_biplot(
#             pca = obj_pca,
#             PC_x = PC_x,
#             PC_y = PC_y,
#             loadings_show = FALSE,
#             loadings_n = 0,
#             meta_color = "strain",
#             meta_shape = "technical",
#             x_min = -100,  # -120000,  # -66,  # -20,
#             x_max = 100,  # 120000,  # 66,  # 20,
#             y_min = -100,  # -50000,  # -50,  # -20,
#             y_max = 100  # 50000  # 50  # 20
#         )
#         
#         #HERE
#         images[[paste0("KA.", PC_x, ".v.", PC_y)]] <-
#             plot_pos_neg_loadings_each_axis(
#                 df_all = loadings,
#                 df_pos = top_loadings_pos,
#                 df_neg = top_loadings_neg,
#                 PC_x = PC_x,
#                 PC_y = PC_y,
#                 row_start = 1,
#                 row_end = 15,  # 30
#                 x_min = -0.15,  # -0.15,  # -1.0,
#                 x_max = 0.15,  # 0.15,  # 1.0,
#                 y_min = -0.15,  # -0.1,  # -0.5,
#                 y_max = 0.15,  # 0.1,  # 0.5,
#                 x_nudge = 0.02,  # 0.02,  # 0.04,
#                 y_nudge = 0.04,  # 0.04,  # 0.02,
#                 x_label = x_label,
#                 y_label = y_label,
#                 col_line_pos = "black",
#                 col_line_neg = "red",
#                 col_seg_pos = "grey",
#                 col_seg_neg = "grey"
#             )
#         
#         images[[paste0("KA.", PC_x, ".v.", PC_y)]]
#     }
#     
#     #  How do things look?
#     images$PCAtools.PC1.v.PC2
#     images$KA.PC1.v.PC2$PC_x_pos
#     images$KA.PC1.v.PC2$PC_x_neg
#     images$KA.PC1.v.PC2$PC_y_pos
#     images$KA.PC1.v.PC2$PC_y_neg
#     
#     images$PCAtools.PC1.v.PC3
#     images$KA.PC1.v.PC3$PC_x_pos
#     images$KA.PC1.v.PC3$PC_x_neg
#     images$KA.PC1.v.PC3$PC_y_pos
#     images$KA.PC1.v.PC3$PC_y_neg
#     
#     # images$PCAtools.PC1.v.PC4
#     # images$KA.PC1.v.PC4$PC_x_pos
#     # images$KA.PC1.v.PC4$PC_x_neg
#     # images$KA.PC1.v.PC4$PC_y_pos
#     # images$KA.PC1.v.PC4$PC_y_neg
#     # 
#     # images$PCAtools.PC2.v.PC3
#     # images$KA.PC2.v.PC3$PC_x_pos
#     # images$KA.PC2.v.PC3$PC_x_neg
#     # images$KA.PC2.v.PC3$PC_y_pos
#     # images$KA.PC2.v.PC3$PC_y_neg
#     # 
#     # images$PCAtools.PC2.v.PC4
#     # images$KA.PC2.v.PC4$PC_x_pos
#     # images$KA.PC2.v.PC4$PC_x_neg
#     # images$KA.PC2.v.PC4$PC_y_pos
#     # images$KA.PC2.v.PC4$PC_y_neg
#     # 
#     # images$PCAtools.PC3.v.PC4
#     # images$KA.PC3.v.PC4$PC_x_pos
#     # images$KA.PC3.v.PC4$PC_x_neg
#     # images$KA.PC3.v.PC4$PC_y_pos
#     # images$KA.PC3.v.PC4$PC_y_neg
#     
#     # images$PCAtools.PC1.v.PC3
#     # images$KA.PC1.v.PC3
#     # images$PCAtools.PC1.v.PC4
#     # images$KA.PC1.v.PC4
#     # images$PCAtools.PC2.v.PC3
#     # images$KA.PC2.v.PC3
#     
#     # for(i in 1:length(names(images))) {
#     #     # i <- 2
#     #     vector_names <- names(images) %>% stringr::str_split("\\.")
#     #     
#     #     if(vector_names[[i]][1] == "PCAtools") {
#     #         save_title <- paste0("panel-plot", ".", names(images)[i], ".pdf")
#     #         ggplot2::ggsave(
#     #             paste0(args$directory_out, "/", save_title), images[[i]]
#     #         )
#     #     } else if(vector_names[[i]][1] == "KA") {
#     #         save_title <- paste0(
#     #             "panel-plot", ".", names(images)[i], ".1-x-positive.pdf"
#     #         )
#     #         ggplot2::ggsave(
#     #             paste0(args$directory_out, "/", save_title), images[[i]][[1]]
#     #         )
#     #         
#     #         save_title <- paste0(
#     #             "panel-plot", ".", names(images)[i], ".2-y-positive.pdf"
#     #         )
#     #         ggplot2::ggsave(
#     #             paste0(args$directory_out, "/", save_title), images[[i]][[2]]
#     #         )
#     #         
#     #         save_title <- paste0(
#     #             "panel-plot", ".", names(images)[i], ".3-x-negative.pdf"
#     #         )
#     #         ggplot2::ggsave(
#     #             paste0(args$directory_out, "/", save_title), images[[i]][[3]]
#     #         )
#     #         
#     #         save_title <- paste0(
#     #             "panel-plot", ".", names(images)[i], ".4-y-negative.pdf"
#     #         )
#     #         ggplot2::ggsave(
#     #             paste0(args$directory_out, "/", save_title), images[[i]][[4]]
#     #         )
#     #     }
#     # }
#     #TODO Work up some logic for location(s) for outfiles
#     
#     
#     #  Plot the top features on an axis of component loading range ----------------
#     #+ ...to visualize the top variables (features) that drive variance among
#     #+ principal components of interest
#     p_loadings <- PCAtools::plotloadings(
#         obj_pca,
#         components = getComponents(obj_pca, 1),
#         # components = getComponents(obj_pca, 1:5),
#         rangeRetain = 0.05,
#         absolute = FALSE,
#         col = c("#785EF075", "#FFFFFF75", "#FE610075"),
#         title = "Loadings plot",
#         subtitle = "Top 5% of variables (i.e., features)",
#         # shapeSizeRange = c(4, 16),
#         borderColour = "#000000",
#         borderWidth = 0.2,
#         gridlines.major = TRUE,
#         gridlines.minor = TRUE,
#         axisLabSize = 10,
#         labSize = 3,  # label_size
#         drawConnectors = TRUE,
#         widthConnectors = 0.2,
#         typeConnectors = 'closed',
#         colConnectors = 'black'
#     ) +
#         # ggplot2::coord_flip() +
#         theme_slick_no_legend
#     p_loadings
#     #TODO Work up some logic for saving the plot
#     
#     
#     #  Evaluate correlations between PCs and model variables ----------------------
#     #+ Answer, "What is driving biologically significant variance in our data?"
#     PC_cor <- PCAtools::eigencorplot(
#         obj_pca,
#         components = PCAtools::getComponents(obj_pca, 1:length(obj_pca$loadings)),
#         # metavars = c("strain", "state", "time", "replicate", "technical"),
#         metavars = c("no_strain", "no_replicate", "no_technical"),
#         # metavars = c("strain", "replicate", "technical"),
#         # metavars = c("strain", "replicate", "sample_name"),
#         col = c("#FFFFFF75", "#FE610075"),
#         # col = c("#785EF075", "#FFFFFF75", "#FE610075"),
#         scale = FALSE,
#         corFUN = "pearson",
#         corMultipleTestCorrection = "BH",
#         plotRsquared = TRUE,
#         colFrame = "#FFFFFF",
#         main = bquote(Pearson ~ r^2 ~ correlates),
#         # main = "PC Pearson r-squared correlates",
#         fontMain = 1,
#         titleX = "Principal components",
#         fontTitleX = 1,
#         fontLabX = 1,
#         titleY = "Model variables",
#         rotTitleY = 90,
#         fontTitleY = 1,
#         fontLabY = 1
#     )
#     PC_cor
#     
#     
#     #  Get lists of top loadings for GO analyses ----------------------------------
#     # for(i in c("PC1", "PC2", "PC3", "PC4")) {
#     for(i in c("PC1", "PC2")) {
#         #TODO Write results to list so that I only need to query a single object
#         # i <- "PC1"
#         #  Positive
#         loadings_pos_PC <- rownames(top_loadings_pos[[i]])[1:500]
#         save_title_pos_PC <- paste0(
#             "top-500.",
#             stringr::str_replace_all(get_name_of_var(loadings_pos_PC), "_", "-"),
#             ".", i, ".txt"
#         )
#         # readr::write_tsv(
#         #     dplyr::as_tibble(loadings_pos_PC),
#         #     paste0(args$directory_out, "/", save_title_pos_PC),
#         #     col_names = FALSE
#         # )
#         #TODO Work up some logic for location(s) for outfiles
#         
#         #  Negative
#         loadings_neg_PC <- rownames(top_loadings_neg[[i]])[1:500]
#         save_title_neg_PC <- paste0(
#             "top-500.",
#             stringr::str_replace_all(get_name_of_var(loadings_neg_PC), "_", "-"),
#             ".", i, ".txt"
#         )
#         # readr::write_tsv(
#         #     dplyr::as_tibble(loadings_neg_PC),
#         #     paste0(args$directory_out, "/", save_title_neg_PC),
#         #     col_names = FALSE
#         # )
#         #TODO Work up some logic for location(s) for outfiles
#     }
#     
#     #  How do things look?
#     images$PCAtools.PC1.v.PC2
#     images$KA.PC1.v.PC2$PC_x_pos
#     images$KA.PC1.v.PC2$PC_x_neg
#     images$KA.PC1.v.PC2$PC_y_pos
#     images$KA.PC1.v.PC2$PC_y_neg
#     
#     # images$PCAtools.PC1.v.PC3
#     # images$KA.PC1.v.PC3$PC_x_pos
#     # images$KA.PC1.v.PC3$PC_x_neg
#     # images$KA.PC1.v.PC3$PC_y_pos
#     # images$KA.PC1.v.PC3$PC_y_neg
#     # 
#     # images$PCAtools.PC1.v.PC4
#     # images$KA.PC1.v.PC4$PC_x_pos
#     # images$KA.PC1.v.PC4$PC_x_neg
#     # images$KA.PC1.v.PC4$PC_y_pos
#     # images$KA.PC1.v.PC4$PC_y_neg
#     # 
#     # images$PCAtools.PC2.v.PC3
#     # images$KA.PC2.v.PC3$PC_x_pos
#     # images$KA.PC2.v.PC3$PC_x_neg
#     # images$KA.PC2.v.PC3$PC_y_pos
#     # images$KA.PC2.v.PC3$PC_y_neg
#     # 
#     # images$PCAtools.PC2.v.PC4
#     # images$KA.PC2.v.PC4$PC_x_pos
#     # images$KA.PC2.v.PC4$PC_x_neg
#     # images$KA.PC2.v.PC4$PC_y_pos
#     # images$KA.PC2.v.PC4$PC_y_neg
#     # 
#     # images$PCAtools.PC3.v.PC4
#     # images$KA.PC3.v.PC4$PC_x_pos
#     # images$KA.PC3.v.PC4$PC_x_neg
#     # images$KA.PC3.v.PC4$PC_y_pos
#     # images$KA.PC3.v.PC4$PC_y_neg
#     # 
#     # images$PCAtools.PC1.v.PC3
#     # images$KA.PC1.v.PC3
#     # images$PCAtools.PC1.v.PC4
#     # images$KA.PC1.v.PC4
#     # images$PCAtools.PC2.v.PC3
#     # images$KA.PC2.v.PC3
# # }
# 
# 
# 
# # cat("Q_N_wt_r1_r6\n")
# # res_gw$Q_N_wt_r1_r6$n02_col_data
# # cat("\n")
# # 
# # cat("Q_SS_wt_r1_r6\n")
# # res_gw$Q_SS_wt_r1_r6$n02_col_data
# # cat("\n")
# # 
# # cat("Q_SS_wt_ot_r1_r6_n3\n")
# # res_gw$Q_SS_wt_ot_r1_r6_n3$n02_col_data
# # cat("\n")
# # 
# # cat("Q_N_wt_ot_r1_r6_n3\n")
# # res_gw$Q_N_wt_ot_r1_r6_n3$n02_col_data
# # cat("\n")
# # 
# # cat("tc_SS_wt_r6\n")
# # res_gw$tc_SS_wt_r6$n02_col_data
# # cat("\n")
# # 
# # cat("tc_SS_wt_t4_r6\n")
# # res_gw$tc_SS_wt_t4_r6$n02_col_data
# # cat("\n")
# # 
# # cat("Q_tc_SS_wt_ot_r1_r6_n3\n")
# # res_gw$Q_tc_SS_wt_ot_r1_r6_n3$n02_col_data
# # cat("\n")
# # 
# # cat("G1_Q_SS_N_wt\n")
# # res_gw$G1_Q_SS_N_wt$n02_col_data
# # cat("\n")
