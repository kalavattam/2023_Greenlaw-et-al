#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
coding_lengths.py
Kamil Slowikowski
2014-0207

Modified: Kris Alavattam
2022-0904

Count the number of coding base pairs in each GENCODE gene.

GENCODE coordinates, including all exons with Ensembl identifiers.
(GENCODE release 17 corresponds to hg19)
    ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz
    ftp://ftp.sanger.ac.uk/pub/gencode/release_17/gencode.v17.annotation.gtf.gz
    chr1  HAVANA  gene        11869  14412  .  +  .  gene_id "ENSG00000223972.4";
    chr1  HAVANA  transcript  11869  14409  .  +  .  gene_id "ENSG00000223972.4";
    chr1  HAVANA  exon        11869  12227  .  +  .  gene_id "ENSG00000223972.4";
    chr1  HAVANA  exon        12613  12721  .  +  .  gene_id "ENSG00000223972.4";
    chr1  HAVANA  exon        13221  14409  .  +  .  gene_id "ENSG00000223972.4";
NCBI mapping from Entrez GeneID to Ensembl identifiers.
    ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene2ensembl.gz
    9606  1  ENSG00000121410  NM_130786.3     ENST00000263100  NP_570602.2     ENSP00000263100
    9606  2  ENSG00000175899  NM_000014.4     ENST00000318602  NP_000005.2     ENSP00000323929
    9606  3  ENSG00000256069  NR_040112.1     ENST00000543404  -               -
    9606  9  ENSG00000171428  NM_000662.5     ENST00000307719  NP_000653.3     ENSP00000307218
    9606  9  ENSG00000171428  XM_005273679.1  ENST00000517492  XP_005273736.1  ENSP00000429407
Output:
    Ensembl_gene_identifier  GeneID  length
    ENSG00000000005          64102   1339
    ENSG00000000419          8813    1185
    ENSG00000000457          57147   3755
    ENSG00000000938          2268    3167

USAGE:
    coding_lengths.py -g FILE -n FILE [-o FILE]

OPTIONS:
    -h          Show this help message.
    -g FILE     GENCODE annotation.gtf.gz file.
    -n FILE     NCBI gene2ensembl.gz file.
    -o FILE     Output file (gzipped).
"""


import GTF  # https://gist.github.com/slowkow/8101481

from docopt import docopt
import pandas as pd
import gzip
import time
import sys
from contextlib import contextmanager


def main(args):
    """
    #TODO Some description of the script.

    Parameters
    ----------
    #TODO Some description of the parameters.
    """
    # Input files.
    GENCODE = args['-g']
    NCBI_ENSEMBL = args['-n']

    # Output file prefix.
    GENE_LENGTHS = args['-o'] or "ncbi_ensembl_coding_lengths.txt.gz"

    with log("Reading the GENCODE annotation file: {}".format(GENCODE)):
        gc = GTF.dataframe(GENCODE)

    # Select just exons of protein coding genes, and columns that we want to
    # use.
    idx = (gc.feature == 'exon') & (gc.transcript_type == 'protein_coding')
    exon = gc.ix[idx, ['seqname', 'start', 'end', 'gene_id', 'gene_name']]

    # Convert columns to proper types.
    exon.start = exon.start.astype(int)
    exon.end = exon.end.astype(int)

    # Sort in place.
    exon.sort(['seqname', 'start', 'end'], inplace=True)

    # Group the rows by the Ensembl gene identifier (with version numbers.)
    groups = exon.groupby('gene_id')

    with log("Calculating coding region (exonic) length for each gene..."):
        lengths = groups.apply(count_bp)

    with log(
        "Reading NCBI mapping of Entrez GeneID "
        "to Ensembl gene identifier: {}".format(NCBI_ENSEMBL)
    ):
        g2e = pd.read_table(
            NCBI_ENSEMBL,
            compression="gzip",
            header=None,
            names=[
                'tax_id',
                'GeneID',
                'Ensembl_gene_identifier',
                'RNA_nucleotide_accession.version',
                'Ensembl_rna_identifier',
                'protein_accession.version',
                'Ensembl_protein_identifier'
            ]
        )

    # Create a new DataFrame with gene lengths and EnsemblID.
    ensembl_no_version = lengths.index.map(lambda x: x.split(".")[0])
    ldf = pd.DataFrame(
        {
            'length': lengths,
            'Ensembl_gene_identifier': ensembl_no_version
        },
        index=lengths.index
    )

    # Merge so we have EntrezGeneID with length.
    m1 = pd.merge(ldf, g2e, on='Ensembl_gene_identifier')
    m1 = m1[['Ensembl_gene_identifier', 'GeneID', 'length']].drop_duplicates()

    with log("Writing output file: {}".format(GENE_LENGTHS)):
        with gzip.open(GENE_LENGTHS, "wb") as out:
            m1.to_csv(out, sep="\t", index=False)


def count_bp(df):
    """
    Return the total number of coding bases in that gene.

    Makes use of a DataFrame with the exon coordinates from GENCODE for a
    single gene.

    Parameters
    ----------
    #TODO Some description of the parameters.

    Example
    -------
        >>> import numpy as np
        >>> n = 3
        >>> r = lambda x: np.random.sample(x) * 10
        >>> d = pd.DataFrame([np.sort([a,b]) for a,b in zip(r(n), r(n))], columns=['start','end']).astype(int)
        >>> d
           start  end
        0      6    9
        1      3    4
        2      4    9
        >>> count_bp(d)
        7
    Here is a visual representation of the 3 exons and the way they are added:
          123456789  Length
        0      ----       4
        1   --            2
        2    ------       6
            =======       7
    """
    start = df.start.min()
    end = df.end.max()
    bp = [False] * (end - start + 1)
    for i in range(df.shape[0]):
        s = df.iloc[i]['start'] - start
        e = df.iloc[i]['end'] - start + 1
        bp[s:e] = [True] * (e - s)
    return sum(bp)


@contextmanager
def log(message):
    """
    Log a timestamp, a message, and the elapsed time to stderr.

    Parameters
    ----------
    #TODO Some description of the parameters.
    """
    start = time.time()
    sys.stderr.write("{} # {}\n".format(time.asctime(), message))
    yield
    elapsed = int(time.time() - start + 0.5)
    sys.stderr.write("{} # done in {} s\n".format(time.asctime(), elapsed))
    sys.stderr.flush()


if __name__ == '__main__':
    args = docopt(__doc__)
    main(args)
