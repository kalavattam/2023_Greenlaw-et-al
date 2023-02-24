#!/bin/bash

#  analyze_flags.sh
#  KA

# 17633940  83
# 17633940  163
# 17172488  99
# 17172488  147
# 12581234  419  # not primary
# 12581234  339  # not primary
#  1642164  77   # not mapped
#  1642164  141  # not mapped
#   990420  403  # not primary, but is it valid?
#   990420  355  # not primary, but is it valid?
#     2780  89   # not mapped
#     2779  165
#     2587  133
#     2586  73
#     2188  345  # not mapped and not primary
#      124  329  # not mapped and not primary
#        6  409  # not mapped and not primary  
#        3  153  
#        3  101  # not mapped
#
# 419 Summary (not primary version of 163):
#     read paired (0x1)
#     read mapped in proper pair (0x2)
#     mate reverse strand (0x20)
#     second in pair (0x80)
#     not primary alignment (0x100)
#
# 339 Summary (not primary version of 83):
#     read paired (0x1)
#     read mapped in proper pair (0x2)
#     read reverse strand (0x10)
#     first in pair (0x40)
#     not primary alignment (0x100)
#
# 403 Summary (not primary version of 147):
#     read paired (0x1)
#     read mapped in proper pair (0x2)
#     read reverse strand (0x10)
#     second in pair (0x80)
#     not primary alignment (0x100)
#
# 355 Summary (not primary version of 99):
#     read paired (0x1)
#     read mapped in proper pair (0x2)
#     mate reverse strand (0x20)
#     first in pair (0x40)
#     not primary alignment (0x100)
#
# Cool, informative links of bam flags
#     - https://ppotato.wordpress.com/2010/08/25/samtool-bitwise-flag-paired-reads/
#     - https://www.samformat.info/sam-format-flag
#     - https://davetang.org/muse/2014/03/06/understanding-bam-flags/

{
    flags=(
        83
        163
        99
        147
        419
        339
        77
        141
        403
        355
        89
        165
        133
        73
        345
        329
        409
        153
        101
    )

    for i in "${flags[@]}"; do
        echo "❯ perl bin/parse_bam-flag.pl ${i}"
        perl bin/parse_bam-flag.pl "${i}"
        echo ""
    done
}

# ❯ perl bin/parse_bam-flag.pl 83
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the first segment in the template, i.e., first in pair (0x40)
#
# ❯ perl bin/parse_bam-flag.pl 163
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
# the last segment in the template, i.e., second in pair (0x80)
#
# ❯ perl bin/parse_bam-flag.pl 99
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
# the first segment in the template, i.e., first in pair (0x40)
#
# ❯ perl bin/parse_bam-flag.pl 147
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the last segment in the template, i.e., second in pair (0x80)
#
# ❯ perl bin/parse_bam-flag.pl 419
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
# the last segment in the template, i.e., second in pair (0x80)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 339
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the first segment in the template, i.e., first in pair (0x40)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 77
# template having multiple segments in sequencing, i.e., read paired (0x1)
# segment unmapped, i.e., read unmapped (0x4)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# the first segment in the template, i.e., first in pair (0x40)
#
# ❯ perl bin/parse_bam-flag.pl 141
# template having multiple segments in sequencing, i.e., read paired (0x1)
# segment unmapped, i.e., read unmapped (0x4)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# the last segment in the template, i.e., second in pair (0x80)
#
# ❯ perl bin/parse_bam-flag.pl 403
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the last segment in the template, i.e., second in pair (0x80)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 355
# template having multiple segments in sequencing, i.e., read paired (0x1)
# each segment properly aligned according to the aligner, i.e., read mapped in proper pair (0x2)
# SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
# the first segment in the template, i.e., first in pair (0x40)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 89
# template having multiple segments in sequencing, i.e., read paired (0x1)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the first segment in the template, i.e., first in pair (0x40)
#
# ❯ perl bin/parse_bam-flag.pl 165
# template having multiple segments in sequencing, i.e., read paired (0x1)
# segment unmapped, i.e., read unmapped (0x4)
# SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
# the last segment in the template, i.e., second in pair (0x80)
#
# ❯ perl bin/parse_bam-flag.pl 133
# template having multiple segments in sequencing, i.e., read paired (0x1)
# segment unmapped, i.e., read unmapped (0x4)
# the last segment in the template, i.e., second in pair (0x80)
#
# ❯ perl bin/parse_bam-flag.pl 73
# template having multiple segments in sequencing, i.e., read paired (0x1)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# the first segment in the template, i.e., first in pair (0x40)
#
# ❯ perl bin/parse_bam-flag.pl 345
# template having multiple segments in sequencing, i.e., read paired (0x1)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the first segment in the template, i.e., first in pair (0x40)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 329
# template having multiple segments in sequencing, i.e., read paired (0x1)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# the first segment in the template, i.e., first in pair (0x40)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 409
# template having multiple segments in sequencing, i.e., read paired (0x1)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the last segment in the template, i.e., second in pair (0x80)
# secondary alignment, i.e., not primary alignment (0x100)
#
# ❯ perl bin/parse_bam-flag.pl 153
# template having multiple segments in sequencing, i.e., read paired (0x1)
# next segment in the template unmapped, i.e., mate unmapped (0x8)
# SEQ being reverse complemented, i.e., read reverse strand (0x10)
# the last segment in the template, i.e., second in pair (0x80)
#
# ❯ perl bin/parse_bam-flag.pl 101
# template having multiple segments in sequencing, i.e., read paired (0x1)
# segment unmapped, i.e., read unmapped (0x4)
# SEQ of the next segment in the template being reversed, i.e., mate reverse strand (0x20)
# the first segment in the template, i.e., first in pair (0x40)

