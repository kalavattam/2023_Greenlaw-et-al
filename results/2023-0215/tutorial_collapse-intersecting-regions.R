#!/bin/env Rscript

#  tutorial_collapse-intersecting-regions.R
#  VZ
#  2013-0606

#  See stackoverflow.com/questions/16957293/collapse-intersecting-regions


d <- data.frame(
    chrom = c(1, 1, 1, 14, 16, 16), 
    name  = c("a", "b", "c", "d", "e", "f"), 
    start = as.numeric(c(70001, 70203, 70060, 40004, 50000872, 50000872)), 
    stop  = as.numeric(c(71200, 80001, 71051, 42004, 50000890, 51000952))
)


#  Ignore chromosome ----------------------------------------------------------
#  Make sure the data is sorted
d <- d[order(d$start), ]

#  Check if a record should be linked with the previous
d$previous_stop <- c(NA, d$stop[-nrow(d)])
d$previous_stop <- cummax(ifelse(is.na(d$previous_stop), 0, d$previous_stop))
d$new_group <- is.na(d$previous_stop) | d$start >= d$previous_stop

#  The number of the current group of records is the number of times we have
#+ switched to a new group
d$group <- cumsum(d$new_group)

#  We can now aggregate the data
plyr::ddply(
    d,
    "group",
    summarize, 
    start = min(start),
    stop = max(stop),
    name = paste(name, collapse = ",")
)


#  Don't ignore chromosome ----------------------------------------------------
#  But this ignores the chrom column: To account for it, you can do the same
#+ thing for each chromosome, separately.
d <- d[order(d$chrom, d$start), ]
d <- plyr::ddply(
    d,
    "chrom",
    function(u) { 
        x <- c(NA, u$stop[-nrow(u)])
        y <- ifelse(is.na(x), 0, x)
        y <- cummax(y)
        y[is.na(x)] <- NA
        u$previous_stop <- y
        return(u)
    }
)
d$new_group <- is.na(d$previous_stop) | d$start >= d$previous_stop
d$group <- cumsum(d$new_group)
plyr::ddply(
    d,
    .(chrom, group),
    summarize, 
    start = min(start),
    stop = max(stop),
    name = paste(name, collapse = ",")
)
