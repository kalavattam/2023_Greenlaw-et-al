#!/bin/env Rscript

#  tutorial_extract-non-overlapping-regions.R
#  AntoniosK, me
#  2015-0812

#  - See stackoverflow.com/questions/31968890/how-to-extract-non-overlapping-ranges-of-field-region-using-r
#  - See stackoverflow.com/questions/16957293/collapse-intersecting-regions


#  Initialize functions -------------------------------------------------------
`%+=%` <- function(x, y) eval.parent(substitute(x <- x + y))
# stackoverflow.com/questions/5738831/r-plus-equals-and-plus-plus-equivalent-from-c-c-java-etc


detect_overlap <- function(x, y) {
    # Detect overlaps
    # :param x: row number <numeric>
    # :param y: range start and end columns/vectors <numeric>
    # :return z: Boolean <0 or 1>
    z <- ifelse(x[2] >= y[1], 1, 0)
    return(z)
}


# delete_overlap <- function(x, y) {
#     # Delete row that overlaps previous row from dataframe/tibble
#     # :param x: dataframe/tibble
#     # :param y: range start and end columns/vectors <numeric>
#     # :return x: dataframe/tibble sans rows that overlapped previous row
#     i <- 2
#     while(i <= nrow(x)) {
#         # i <- 2
#         tmp <- x
#         if(detect_overlap(tmp[i - 1, y], tmp[i, y]) == 1) {
#             tmp[i, ] <- NA
#             x <- tmp[complete.cases(tmp), ]
#         } else {
#             x <- tmp
#             i %+=% 1
#         }
#     }
# 
#     return(x)
# }


#  Initialize example dataframe -----------------------------------------------
df <- data.frame(
    seqname = c(rep("I", 4), rep("II", 5)),
    start = c(1, 20, 101, 220, 1, 100, 130, 300, 301),
    end = c(100, 120, 200, 280, 50, 150, 180, 400, 350)
)

# order data based on minimum value of range (in case you don't have an order already)
df <- df[order(df$seqname, df$start, df$end), ]
df

# region start end
# 1       I     1 100
# 2       I    20 120
# 3       I   101 200
# 4       I   220 280
# 5      II     1  50
# 6      II   100 150
# 7      II   130 180
# 8      II   300 400
# 9      II   301 350


#  Compares each row with the previous one, deleting rows that overlap --------
#  Without accounting for chr/seqname ---------------------
# i <- 2  # Set starting row
# while(i <= nrow(df)) {
#     # i <- 4
#     df_tmp <- df
#     if(overlap(df_tmp[i - 1, 2:3], df_tmp[i, 2:3]) == 1) {
#         df_tmp[i, ] <- NA
#         df <- df_tmp[complete.cases(df_tmp), ]
#     } else {
#         df <- df_tmp
#         i %+=% 1
#     }
# }
# df

#  With accounting for chr/seqname ------------------------
out <- plyr::ddply(
    df,
    "seqname",
    function(x) {
        i <- 2
        while(i <= nrow(x)) {
            # i <- 2
            tmp <- x
            if(detect_overlap(tmp[i - 1, 2:3], tmp[i, 2:3]) == 1) {
                tmp[i, ] <- NA
                x <- tmp[complete.cases(tmp), ]
            } else {
                x <- tmp
                i %+=% 1
            }
        }

        return(x)
    }
)


out
#   seqname start end
# 1       I     1 100
# 2       I   101 200
# 3       I   220 280
# 4      II     1  50
# 5      II   100 150
# 6      II   300 400

df
#   seqname start end
# 1       I     1 100
# 2       I    20 120
# 3       I   101 200
# 4       I   220 280
# 5      II     1  50
# 6      II   100 150
# 7      II   130 180
# 8      II   300 400
# 9      II   301 350
