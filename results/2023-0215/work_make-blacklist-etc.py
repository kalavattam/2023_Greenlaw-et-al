#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 13 10:14:09 2022

@author: kalavatt
"""

# TODO Find a spot for this link
# bioinformatics.stackexchange.com/questions/5435/how-to-create-a-bed-file-from-fasta

import gzip
# import nltk.tokenize
import numpy as np
import os
import pandas as pd
# import pipe
import re
# import shutil
# import sys
import tarfile
import urllib.request


os.getcwd()
os.chdir('/Users/kalavattam/Dropbox/FHCC/2022-2023_RRP6-NAB3/results/2023-0215')
# os.chdir('/Users/kalavatt/projects-etc/2022-2023_RRP6-NAB3/results/2023-0215')
os.listdir(os.curdir)  # List files and directories

d_comprehensive = "infiles_gtf-gff3/comprehensive"
exists = os.path.exists(d_comprehensive)
if not exists:
    os.makedirs(d_comprehensive)

URL = "http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz"
f_comprehensive = d_comprehensive + "/" + "S288C_reference_genome_R64-1-1_20110203.tgz"
exists = os.path.isfile(f_comprehensive)
if not exists:
    urllib.request.urlretrieve(URL, f_comprehensive)

exists = os.path.exists(f_comprehensive.removesuffix(".tgz"))
if not exists:
    decompressed = tarfile.open(f_comprehensive)
    decompressed.extractall(d_comprehensive)
    del(decompressed)  # TODO Do it without initializing a variable

#  Clean up
d_comprehensive = f_comprehensive.removesuffix(".tgz")
del(exists, f_comprehensive, URL)


# Functions -------------------------------------------------------------------
# stackoverflow.com/questions/43067373/split-by-comma-and-how-to-exclude-comma-from-quotes-in-split
def tokenize(string, separator=',', quote='"'):
    """
    Split a comma separated string into a List of strings.

    Separator characters inside the quotes are ignored.

    :param string: A string to be split into chunks
    :param separator: A separator character
    :param quote: A character to define beginning and end of the quoted string
    :return: A list of strings, one element for every chunk
    """
    comma_separated_list = []

    chunk = ''
    in_quotes = False

    for character in string:
        if character == separator and not in_quotes:
            comma_separated_list.append(chunk)
            chunk = ''
        else:
            chunk += character
            if character == quote:
                in_quotes = False if in_quotes else True

    comma_separated_list.append(chunk)

    return comma_separated_list


# def parse_header(fasta):
#     headers = []
#
#     with open(fasta) as f:
#         header = None
#         for line in f:
#             if line.startswith('>'):  # Identifies fasta header line
#                 headers.append(line[1:-1])  # Append all of the line that isn't >
#                 header = line[1:]  # Reset header
#
#     # newHeader = (header.replace(':',',') for header in headers)  # Format to be accepted later
#     # newnewHeader = (header.replace('-',',') for header in newHeader)  # Format to accept later
#     # bed_head = (header.split(',') for header in newnewHeader)  # Separate by comma from format above
#
#     headers_A = []
#     for i in headers:
#         if i.find('Genome Release 64-1-1, reverse complement,') != -1:
#             print(i)
#             headers_A.append(i)
#         else:
#             headers_A.append(
#                 i.replace(
#                     'Genome Release 64-1-1,',
#                     'Genome Release 64-1-1, forward complement,'
#                 )
#             )
#     bed_head = (i.split(',') for i in headers_A)  # Separate by comma from format above        
#     return bed_head


# -----------------------------------------------------------------------------
# Drafting it all... ----------------------------------------------------------
# -----------------------------------------------------------------------------
# Read in fasta files
fa_not_fea = d_comprehensive + "/" + "NotFeature_R64-1-1_20110203.fasta"
fa_orf_cod = d_comprehensive + "/" + "orf_coding_all_R64-1-1_20110203.fasta"
fa_orf_tra = d_comprehensive + "/" + "orf_trans_all_R64-1-1_20110203.fasta"
fa_oth_fea = d_comprehensive + "/" + "other_features_genomic_R64-1-1_20110203.fasta"
fa_rna_cod = d_comprehensive + "/" + "rna_coding_R64-1-1_20110203.fasta"



# #NOTE As written, does not work for NotFeature_*

# #NOTE orf_coding_all_* works but has some features with two (or more)
#       coordinates (check if there are more than two)
# #NOTE orf_trans_all_* works in the same way orf_coding_all_* works: it has
#       some features with two (or more) coordinates (check if there are more
#       than two)
# #QUESTION Is orf_coding_all_* exactly the same as orf_trans_all_*?

# #NOTE rna_coding_* has some features with two (or more) coordinates (check if
#       there are more than two)

# #TODO Come up with some way to handle that
# #TODO Check the other files for any such weirdness, to see if they work with
#       the below, etc.
# #TODO Generalize the script: Make it reusable

# Extract the headers
fastas = [fa_not_fea, fa_orf_cod, fa_orf_tra, fa_oth_fea, fa_rna_cod]
headers_processed = []
for fasta in fastas:
    #  Check
    print(fasta + ": " + str(os.path.isfile(fasta)) + "\n")

    #  For tests
    # fasta = fa_not_fea  #OK
    # fasta = fa_orf_cod  #OK
    # fasta = fa_orf_tra  #OK
    # fasta = fa_oth_fea  #OK
    # fasta = fa_rna_cod  #OK

    headers = []
    if fasta[-2:]=='gz':
        with gzip.open(fasta, mode='rt') as f:
            header = None
            for line in f:
                if line.startswith('>'):  # Identifies fasta header line
                    headers.append(line[1:-1])  # Append all of the line that isn't >
                    header = line[1:]  # Reset header
    else:
        with open(fasta) as f:
            header = None
            for line in f:
                if line.startswith('>'):  # Identifies fasta header line
                    headers.append(line[1:-1])  # Append all of the line that isn't >
                    header = line[1:]  # Reset header
    del(f, line)
    
    # Add a 'forward complement' designation to match the presence of a 'reverse
    # complement' designation on certain lines
    headers_fix_complement = []
    if fasta != fa_not_fea:
        for i in headers:
            if re.search('^YPL236C', i):
                headers_fix_complement.append(
                    # CURRENT
                    re.sub(
                        # r', (Chr|2-micron)\b.+?\-[\d]+, ',
                        r', Uncharacterized ORF',
                        r'\g<0>, "KA, 2023-0420: No note present in fasta infile; adding this note to facilitate header parsing"',
                        i
                    )
                )
            elif i.find(', reverse complement,') != -1:
                headers_fix_complement.append(i)
            else:
                headers_fix_complement.append(
                    #NOTE This does not work with "orf_coding_all_R64-1-1_20110203.fasta", but does with
                    # "NotFeature_R64-1-1_20110203.fasta"
                    # "orf_trans_all_R64-1-1_20110203.fasta": Total number of underscores: 7; thus, need to make 14 additional columns
                    # "other_features_genomic_R64-1-1_20110203.fasta": empty sequence ∴ 0
                    # "rna_coding_R64-1-1_20110203.fasta": 2 ∴ 4
                    
                    # CURRENT
                    re.sub(
                        r', (Chr|2-micron)\b.+?\-[\d]+, ',
                        r'\g<0>forward complement, ',
                        i
                    )
                    # Chr\b.+?\-[\d]+,
                    # NOTE This seems to work with "orf_coding_all_R64-1-1_20110203.fasta", but does it work for the others?
        
                    # PREVIOUS Too greedy or non-specific?
                    # re.sub(r', Chr\b.+\-.+?[\d], ', r'\g<0>forward complement, ', i)
                    
                    
                    # i.replace(
                    #     ', ',
                    #     ', forward complement,'
                    # )
                )
            
            # i = headers[6407]
            # if re.search('^YPL236C', i):
            
            
        del(i)
    else:
        for i in headers:
            headers_fix_complement.append(
                re.sub(
                    r', Chr\b.+?\-[\d]+, ',
                    r'\g<0>both complements, sans-feature, ',
                    i
                )
            )
    
    
    pattern = re.compile(r'(?<=\d),(?=\d)')
    header_fix_comma = []
    for i in headers_fix_complement:
        header_fix_comma.append(pattern.sub('_', i))
    del(i, pattern)
    
    header_list = []
    for i in header_fix_comma:
        print(tokenize(i))
        header_list.append(tokenize(i))
        # headers_processed.append(tokenize(i))
    del(i)
    
    #  Exclude any subelements with value " intron sequence removed" (only present
    #+ in multi-exonic features)
    header_list = [
        [i for i in nested if i != " intron sequence removed"] for nested in header_list
    ]
    # headers_processed = [
    #     [i for i in nested if i != " intron sequence removed"] for nested in headers_processed
    # ]
    
    headers_processed.append(header_list)

# max(list(map(len, header_list)))
# min(list(map(len, header_list)))

#  For fixing the regex greediness and other issues
# headers[332]
# header_fix_comma[331]
# header_fix_comma[332]
# header_list[331]
# header_list[332]
# headers[404]
# header_list[404]

# headers[6715]
# headers[6407]
# header_list[6407]

# -----------------------------------------------------------------------------
# Add columns names
# stackoverflow.com/questions/18915941/create-a-pandas-dataframe-from-generator
# sparkbyexamples.com/pandas/pandas-add-column-names-to-dataframe/

header_df = pd.DataFrame(
    # header_list,
    headers_processed[0],
    columns=[
        "feature", "coord_written", "strand_written", "category", "notes"
    ]
)
#NOTE "orf_coding_all_R64-1-1_20110203.fasta": Some records have six fields, some four
#NOTE "NotFeature_R64-1-1_20110203.fasta": All records have four fields; there's no "category" entry

# Clean up variables
del(header)
del(headers)
del(headers_fix_complement)
del(header_fix_comma)
del(header_list)
# del(header_df)

# There are leading spaces in string columns; strip these away
# stackoverflow.com/questions/49551336/pandas-trim-leading-trailing-white-space-in-a-dataframe
# stackoverflow.com/questions/3232953/python-removing-spaces-from-list-objects
header_df = header_df.applymap(
    lambda x: x.strip() if isinstance(x, str) else x
)


# -----------------------------------------------------------------------------
# # Split column 'feature' on spaces (not needed for NotFeature dataframe)
# # stackoverflow.com/questions/37333299/splitting-a-pandas-dataframe-column-by-delimiter
# header_df[['name_systematic', 'name_standard', 'SGDID']] = header_df[
#     'feature'
# ].str.split(' ', expand=True)

# # Check that 'name_standard' is exactly the same as 'feature'
# geeksforgeeks.org/how-to-compare-two-columns-in-pandas/
# header_df['name_standard'].equals(header_df['name_systematic'])  # False

# # Return where two columns are different
# header_df.query('name_standard != name_systematic')
# e.g.,
#     feature                    coord  ... name_standard             SGDID
# 11   ARS109      Chr I from 159907-160127  ...    ARS101  SGDID:S000077372
# 86    RE301      Chr III from 29108-29809  ...        RE  SGDID:S000303804
# 142  ARS416     Chr IV from 462567-462622  ...      ARS1  SGDID:S000029652
# 405  ARS808   Chr VIII from 140349-141274  ...      ARS2  SGDID:S000029042
# 444  ARS913     Chr IX from 214624-214754  ...    ARS901  SGDID:S000007644

# Details on where there are differences:
# yeastgenome.org/locus/ARS101
# yeastgenome.org/locus/S000303804
# yeastgenome.org/locus/S000029652
# yeastgenome.org/locus/S000029042
# yeastgenome.org/locus/S000007644

# -----------------------------------------------------------------------------
# # Strip string 'SGDID:' from column 'SGDID' (not needed for NotFeature dataframe)
# # stackoverflow.com/questions/13682044/remove-unwanted-parts-from-strings-in-a-column
# header_df['SGDID'] = header_df['SGDID'].str.replace('SGDID:', '')

# Create 'coord_...' columns derived from 'coord_written'
header_df['coord_pre_y'] = header_df['coord_written']\
        .str.replace(' from ', ':').str.replace('Chr ', 'Chr')
header_df['coord_pre_n'] = header_df['coord_written']\
        .str.replace(' from ', ':').str.replace('Chr ', '')

# -----------------------------------------------------------------------------
# # Populate new column based on value in other column (not needed for NotFeature dataframe)
# # towardsdatascience.com/create-new-column-based-on-other-columns-pandas-5586d87de73d
# # stackoverflow.com/questions/10715519/conditionally-fill-column-values-based-on-another-columns-value-in-pandas
# # numpy.org/doc/stable/reference/generated/numpy.where.html
# header_df['strand'] = np.where(
#     header_df['strand_written'] == 'reverse complement', '-', '+'
# )

# -----------------------------------------------------------------------------
# Extracting substrings to populate columns 'chr', 'start', 'end'
# Extract substring before colon for 'chr'
# header_df['coord_pre_n'].str.split(':').str[0]

header_df['chr'] = header_df['coord_pre_n'].str.split(':').str[0]

# stackoverflow.com/questions/20025882/add-a-string-prefix-to-each-value-in-a-string-column-using-pandas
chr_pre_y = 'Chr' + header_df['chr']
# https://stackoverflow.com/a/3232962 (python-removing-spaces-from-list-objects)
header_df['chr_pre_y'] = [i.replace(' ', '') for i in chr_pre_y]
del(chr_pre_y)

# #TODO Write up logic to handle lines that contain an underscroe in 'coord_'*
#       columns
# -------------------------------------
# # Extract substring after colon for 'start', 'end'
# header_df['coord_pre_n'].str.split(':').str[1]

# start -----------
# #   if 'strand' is '+', take [0] for 'start'
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[0]  # '+' 'start'
#
# # elif 'strand' is '-', take [1] for 'start'
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[1]  # '-' 'start'

header_df['strand'] = '+'  # For NotFeature only
header_df['start'] = np.where(
    header_df['strand'] == '+',
    header_df['coord_pre_n'].str.split(':').str[1].str.split('-').str[0],
    header_df['coord_pre_n'].str.split(':').str[1].str.split('-').str[1]
)

# end -------------
# #   if 'strand' is '+', take [1] for 'end';
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[1]  # '+' 'end'
#
# # elif 'strand' is '-', take [0] for 'end'
# header_df['coord_pre_n']\
#     .str.split(':').str[1].str.split('-').str[0]  # '-' 'end'

header_df['end'] = np.where(
    header_df['strand'] == '+',
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[1],
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[0]
)

header_df.to_csv("infiles_gtf-gff3/comprehensive/S288C_reference_genome_R64-1-1_20110203/NotFeature_R64-1-1_20110203.dataframe.tsv", sep = "\t")


# -----------------------------------------------------------------------------
# If row contains specific text in specific field, then select it (not needed for NotFeature dataframe)
test = header_df[header_df['coord_written'].str.contains('_')]
test["no_us"] = test.coord_written.str.count("_")
print(
      "Total number of underscores: " + 
      str(max(test["no_us"])) + "; thus, need to make " +
      str(max(test["no_us"]) * 2) + " additional columns"
)
del(test)

#NOTES
# "NotFeature_R64-1-1_20110203.fasta":
# "orf_coding_all_R64-1-1_20110203.fasta":
# "orf_trans_all_R64-1-1_20110203.fasta": Total number of underscores: 7; thus, need to make 14 additional columns
# "other_features_genomic_R64-1-1_20110203.fasta": empty sequence ∴ 0
# "rna_coding_R64-1-1_20110203.fasta": 2 ∴ 4

# test['fir'] = test['coord_pre_n'].str.split(':').str[1].str.split('_').str[0]
# test['sec'] = test['coord_pre_n'].str.split(':').str[1].str.split('_').str[1]

test_no_us = header_df[~header_df['coord_written'].str.contains('_')]

# Delete column 'name_standard'  #NOTE Don't actually do this
# header_df = header_df.drop('name_standard', axis = 1)
header_df = header_df.drop('strand', axis=1)

# Copy columns for splitting, etc.  #NOTE Don't actually do this
# stackoverflow.com/questions/32675861/copy-all-values-in-a-column-to-a-new-column-in-a-pandas-dataframe


# geeksforgeeks.org/how-to-count-occurrences-of-specific-value-in-pandas-column/
# geeksforgeeks.org/convert-given-pandas-series-into-a-dataframe-with-its-index-as-another-column-on-the-dataframe/
# tally_0 = header_df[0].value_counts().to_frame().reset_index()
# tally_1 = header_df[1].value_counts().to_frame().reset_index()
# tally_2 = header_df[2].value_counts().to_frame().reset_index()
tally_3 = header_df[3].value_counts().to_frame().reset_index()
tally_4 = header_df[4].value_counts().to_frame().reset_index()
tally_5 = header_df[5].value_counts().to_frame().reset_index()


if __name__=="__main__":
    # Capture in- and outfile names from the command line
    # fasta_in = sys.argv[1]  # Take fasta name, including path, as positional argument #1
    # bed_out = sys.argv[2]  # Take bed name, including path, as positional argument #2

    fasta_in = "other_features_genomic.fasta"
    bed_out = "other_features_genomic.bed"

    # Run function parse_header()
    fasta_parsed = parse_header(fasta_in)

    # Go from generator to list
    headers = list(fasta_parsed)

    # Create dataframe that will be used to output bed files
    bed_file = pd.DataFrame(headers)

    # Output the bed file
    bed_file.to_csv(
        bed_out,
        sep='\t',
        index=False,
        header=None
    )
