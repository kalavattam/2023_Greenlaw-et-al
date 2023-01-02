
`#work_make-blacklist-etc.md`

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Commands used for initial processing on 2022-1206](#commands-used-for-initial-processing-on-2022-1206)
	1. [Look them up...](#look-them-up)
	1. [Pertinent results from the call to history](#pertinent-results-from-the-call-to-history)
1. [Downloading things... \(2022-1213\)](#downloading-things-2022-1213)
	1. [Grab a node, get to the right directory, etc.](#grab-a-node-get-to-the-right-directory-etc)
	1. [Get the SGD `_genome_Current_Release.tgz`](#get-the-sgd-_genome_current_releasetgz)
	1. [Get the SGD `other_features` files](#get-the-sgd-other_features-files)
1. [Parse the SGD `.fasta` headers to make dataframes, etc.](#parse-the-sgd-fasta-headers-to-make-dataframes-etc)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="commands-used-for-initial-processing-on-2022-1206"></a>
## Commands used for initial processing on 2022-1206
<a id="look-them-up"></a>
### Look them up...
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash

history | grep -i awk | less
```
</details>

<a id="pertinent-results-from-the-call-to-history"></a>
### Pertinent results from the call to history
<details>
<summary><i>Click to view</i></summary>

```txt
32894  2022-12-06 10:49:49 cat gene_names.txt | awk -F '\t' '{ print $9 }'
32895  2022-12-06 10:50:31 cat gene_names.txt | awk -F '\t' '{ print $9 }' > gene_names.ID-field.txt
32898  2022-12-06 10:51:58 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }'
32899  2022-12-06 10:52:11 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }' | grep -v "Name="
32900  2022-12-06 10:53:17 cat feature_names.ID-field.txt | awk -F ';' '{ print $2 }' | grep -v "Name=" -
32922  2022-12-06 11:01:39 cat KA.other_features_genomic.names.ID-field.txt | awk -F ';' '{ print $2 }' | sed 's/Name=//' | head
32923  2022-12-06 11:03:18 cat KA.other_features_genomic.names.ID-field.txt | awk -F ';' '{ print $2 }' | sed 's/Name=//' | sort | uniq -c > KA.other_feature
```
</details>
<br />
<br />

<a id="downloading-things-2022-1213"></a>
## Downloading things... (2022-1213)
- `#IMPORTANT` SGD files are derived from UCSC genome resources; see... `#TODO` Reference the source of this information
- `#TODO` Give this section a better name
<a id="grab-a-node-get-to-the-right-directory-etc"></a>
### Grab a node, get to the right directory, etc.
<details>
<summary><i>Click to view</i></summary>

```bash
#!/bin/bash
#DONTRUN


#  Move to work directory, establish work environment -------------------------
grabnode  # 1 and corresponding defaults

mwd() {
    transcriptome \
       && cd "./results/2022-1201" \
       || echo "cd'ing failed; check on this"
}


mwd

Trinity_env
ml Singularity
```
</details>
<br />
<br />

<a id="get-the-sgd-_genome_current_releasetgz"></a>
### [Get the SGD `_genome_Current_Release.tgz`](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/)
- The most recent genome release is from 2021-0427
```bash
#!/bin/bash
#DONTRUN #CONTINUE

mkdir -p files_features/SGD_genome-current-release
cd files_features/SGD_genome-current-release || \
	echo "cd'ing failed; check on this"

    # http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_Current_Release.tgz
link="http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases"
files=(
    genome_releases.README
    S288C_reference_genome_Current_Release.tgz
    README.html
)
for i in "${files[@]}"; do curl -L "${link}/${i}" -o "${i}"; done
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2157k      0 --:--:-- --:--:-- --:--:-- 2157k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2485k      0 --:--:-- --:--:-- --:--:-- 2507k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  278k  100  278k    0     0  2191k      0 --:--:-- --:--:-- --:--:-- 2191k
```

<a id="get-the-sgd-other_features-files"></a>
### [Get the SGD `other_features` files](http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features/)
```bash
#!/bin/bash
#DONTRUN #CONTINUE

../..

mkdir -p files_features/SGD_other-features
cd files_features/SGD_other-features || \
	echo "cd'ing failed; check on this"

link="http://sgd-archive.yeastgenome.org/sequence/S288C_reference/other_features"
files=(
	other_features_genomic_1000.fasta.gz
	other_features_genomic.fasta.gz
	other_features.README
	README.html
)
for i in "${files[@]}"; do curl -L "${link}/${i}" -o "${i}"; done
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  637k  100  637k    0     0  3125k      0 --:--:-- --:--:-- --:--:-- 3125k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  186k  100  186k    0     0  1023k      0 --:--:-- --:--:-- --:--:-- 1023k
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100   775  100   775    0     0   5827      0 --:--:-- --:--:-- --:--:--  5827
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100   311  100   311    0     0   4573      0 --:--:-- --:--:-- --:--:--  4573
```
<br />
<br />

<a id="parse-the-sgd-fasta-headers-to-make-dataframes-etc"></a>
## Parse the SGD `.fasta` headers to make dataframes, etc.
- `#INPROGRESS` Make a `python` script for using the headers in the SGD `other_features` `.fasta` to make a `pandas` dataframe, which can be used in turn to make `.bed`, `.gtf`, etc. files
- [Details about the `.bed` format](https://genome.ucsc.edu/FAQ/FAQformat.html#format1)

<details>
<summary><i>Scratch work for working with only the 'other_features' .fasta (2022-1214-1214)</i></summary>

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 13 10:14:09 2022

@author: kalavatt
"""

# bioinformatics.stackexchange.com/questions/5435/how-to-create-a-bed-file-from-fasta
import numpy as np
import pandas as pd
# import sys


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

# -----------------------------------------------------------------------------
# Drafting it all... ----------------------------------------------------------
# -----------------------------------------------------------------------------
# Read in .fasta
fasta = "other_features_genomic.fasta"

# Extract the headers
headers = []
with open(fasta) as f:
    header = None
    for line in f:
        if line.startswith('>'):  # Identifies fasta header line
            headers.append(line[1:-1])  # Append all of the line that isn't >
            header = line[1:]  # Reset header
del(fasta)
del(f)
del(line)

# Add a 'forward complement' designation to match the presence of a 'reverse
# complement' designation on certain lines
headers_fix_complement = []
for i in headers:
    if i.find('Genome Release 64-3-1, reverse complement,') != -1:
        headers_fix_complement.append(i)
    else:
        headers_fix_complement.append(
            i.replace(
                'Genome Release 64-3-1,',
                'Genome Release 64-3-1, forward complement,'
            )
        )
del(i)

header_list = []
for i in headers_fix_complement:
    # print(type(i))
    print(tokenize(i))
    header_list.append(tokenize(i))
del(i)

# -----------------------------------------------------------------------------
# Add columns names
# stackoverflow.com/questions/18915941/create-a-pandas-dataframe-from-generator
# sparkbyexamples.com/pandas/pandas-add-column-names-to-dataframe/
header_df = pd.DataFrame(
    header_list,
    columns=[
        'feature', 'coord_written', 'release', 'strand_written',
        'category', 'notes'
    ]
)

# Clean up variables
del(header)
del(headers)
del(header_list)
del(headers_fix_complement)

# There are leading spaces in string columns; strip these away
# stackoverflow.com/questions/49551336/pandas-trim-leading-trailing-white-space-in-a-dataframe
header_df = header_df.applymap(
    lambda x: x.strip() if isinstance(x, str) else x
)

# -----------------------------------------------------------------------------
# Split column 'feature' on space
# stackoverflow.com/questions/37333299/splitting-a-pandas-dataframe-column-by-delimiter
header_df[['name_systematic', 'name_standard', 'SGDID']] = header_df[
    'feature'
].str.split(' ', expand=True)

# Check that 'name_standard' is exactly the same as 'feature'
# geeksforgeeks.org/how-to-compare-two-columns-in-pandas/
header_df['name_standard'].equals(header_df['name_systematic'])  # False

# Return where two columns are different
header_df.query('name_standard != name_systematic')
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
# Strip string 'SGDID:' from column 'SGDID'
# stackoverflow.com/questions/13682044/remove-unwanted-parts-from-strings-in-a-column
header_df['SGDID'] = header_df['SGDID'].str.replace('SGDID:', '')

# Create 'coord_...' columns derived from 'coord_written'
header_df['coord_pre_y'] = header_df['coord_written']\
        .str.replace(' from ', ':').str.replace('Chr ', 'Chr')
header_df['coord_pre_n'] = header_df['coord_written']\
        .str.replace(' from ', ':').str.replace('Chr ', '')

# -----------------------------------------------------------------------------
# Populate new column based on value in other column
# towardsdatascience.com/create-new-column-based-on-other-columns-pandas-5586d87de73d
# stackoverflow.com/questions/10715519/conditionally-fill-column-values-based-on-another-columns-value-in-pandas
# numpy.org/doc/stable/reference/generated/numpy.where.html
header_df['strand'] = np.where(
    header_df['strand_written'] == 'reverse complement', '-', '+'
)

# -----------------------------------------------------------------------------
# Extracting substrings to populate columns 'chr', 'start', 'end'
# # Extract substring before colon for 'chr'
# header_df['coord_pre_n'].str.split(':').str[0]

header_df['chr'] = header_df['coord_pre_n']\
    .str.split(':').str[0]

# stackoverflow.com/questions/20025882/add-a-string-prefix-to-each-value-in-a-string-column-using-pandas
header_df['chr_pre_y'] = 'Chr' + header_df['chr']

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

header_df['start'] = np.where(
    header_df['strand'] == '+',
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[0],
    header_df['coord_pre_n']\
        .str.split(':').str[1].str.split('-').str[1]
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
```
</details>
<br />
<br />
