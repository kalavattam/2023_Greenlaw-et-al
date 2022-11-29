#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
author: adam h freedman
afreedman405 at gmail.com
date: Fri Aug 26 10:55:18 EDT 2016

edited by Kris Aalavattam
kalavatt at fredhutch.org
kalavattam at gmail.com
date: Tue Nov 29 06:41:46 PST 2022

This script, which has been updated from Python 2 to 3, takes as input 
Rcorrector error-corrected Illumina paired-end reads in fastq format and does
the following:

    1. The script removes any reads that Rcorrector indentifed as containing an
       error that can't be corrected, typically low complexity sequences. For
       these, the fastq header contains 'unfixable'.

    2. To avoid issues created by certain header formats for downstream tools,
       the script strips the ' cor' from headers of reads that Rcorrector
       fixed.

    3. The script writes a log with counts of
       (a) read pairs that were removed because one end was unfixable,
       (b) corrected left and right reads, and
       (c) total number of read pairs containing at least one corrected read.

This script only handles paired-end reads. Also, the script handles
either unzipped or gzipped files on the fly, so long as the gzipped files end
with 'gz'. The script can write either uncompressed or gzipped fastq outfiles.
"""

import sys
import gzip
from itertools import zip_longest
import argparse
from os.path import basename

def get_input_streams(r1file,r2file):
    if r1file[-2:]=='gz':
        r1handle = gzip.open(r1file,'rt')
        r2handle = gzip.open(r2file,'rt')
    else:
        r1handle = open(r1file,'r')
        r2handle = open(r2file,'r')
    
    return r1handle,r2handle


def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    # grouper('ABCDEFG', 3, 'x') --> ABC DEF Gxx
    args = [iter(iterable)] * n
    return zip_longest(fillvalue=fillvalue, *args)


if __name__=="__main__":
    parser = argparse.ArgumentParser(
        description='Options for filtering, logging rCorrector fastq output'
    )
    parser.add_argument(
        '-1',
        '--reads_left',
        dest='reads_left',
        type=str,
        help='R1 fastq infile (gzipped or not), including path'
    )
    parser.add_argument(
        '-2',
        '--reads_right',
        dest='reads_right',
        type=str,
        help='R2 fastq infile (gzipped or not), including path'
    )
    parser.add_argument(
        '-s',
        '--sample_id',
        dest='sample_id',
        type=str,
        help='sample name to write to log file'
    )
    parser.add_argument(
        '-o',
        '--dir_out',
        dest='dir_out',
        type=str,
        help='outfile directory, including path'
    )
    parser.add_argument(
        '-g',
        '--gzip_out',
        dest='gzip_out',
        default=True,
        type=bool,
        help='write gzipped fastq outfiles (True or False)',
    )
    opts = parser.parse_args()

    if opts.gzip_out is False:
        r1out = open(
            opts.dir_out + '/unfixrm.%s' % basename(opts.reads_left).replace('.gz', ''),
            'w'
        )
        r2out = open(
            opts.dir_out + '/unfixrm.%s' % basename(opts.reads_right).replace('.gz', ''),
            'w'
        )
    elif opts.gzip_out is True:
        r1out = gzip.open(
            opts.dir_out + '/unfixrm.%s' % basename(opts.reads_left),
            'wt'
        )
        r2out = gzip.open(
            opts.dir_out + '/unfixrm.%s' % basename(opts.reads_right),
            'wt'
        )
    else:
        sys.exit('Exiting: --opts.gzip_out must be either True or False')

    r1_cor_count = 0
    r2_cor_count = 0
    pair_cor_count = 0
    unfix_r1_count = 0
    unfix_r2_count = 0
    unfix_both_count = 0   
    
    r1_stream, r2_stream = get_input_streams(opts.reads_left, opts.reads_right)

    with r1_stream as f1, r2_stream as f2:
        R1 = grouper(f1, 4)
        R2 = grouper(f2, 4)
        counter = 0
        for entry in R1:
            counter += 1
            if counter%100000 == 0:
                print("%s reads processed" % counter)

            head1,seq1,placeholder1,qual1=[i.strip() for i in entry]
            head2,seq2,placeholder2,qual2=[j.strip() for j in next(R2)]
            
            if 'unfixable' in head1 and 'unfixable' not in head2:
                unfix_r1_count += 1
            elif 'unfixable' in head2 and 'unfixable' not in head1:
                unfix_r2_count += 1
            elif 'unfixable' in head1 and 'unfixable' in head2:
                unfix_both_count += 1
            else:
                if 'cor' in head1:
                    r1_cor_count += 1
                if 'cor' in head2:
                    r2_cor_count += 1
                if 'cor' in head1 or 'cor' in head2:
                    pair_cor_count += 1

                head1=head1.split('l:')[0][:-1] 
                head2=head2.split('l:')[0][:-1]
                r1out.write('%s\n' % '\n'.join(
                    [head1, seq1, placeholder1, qual1]
                ))
                r2out.write('%s\n' % '\n'.join(
                    [head2, seq2, placeholder2, qual2]
                ))

    total_unfixable = unfix_r1_count + unfix_r2_count + unfix_both_count
    total_retained = counter - total_unfixable

    unfix_log = open(opts.dir_out + '/rm_unfixable.%s.log' % opts.sample_id, 'w')
    unfix_log.write(
        (
         'total PE reads\t%s\n'
         'removed PE reads\t%s\n'
         'retained PE reads\t%s\n'
         'R1 corrected\t%s\n'
         'R2 corrected\t%s\n'
         'pairs corrected\t%s\n'
         'R1 unfixable\t%s\n'
         'R2 unfixable\t%s\n'
         'both reads unfixable\t%s\n'
        ) % (
         counter,
         total_unfixable,
         total_retained,
         r1_cor_count,
         r2_cor_count,
         pair_cor_count,
         unfix_r1_count,
         unfix_r2_count,
         unfix_both_count
        )
    )

    unfix_pct=open(opts.dir_out + '/rm_unfixable.pct.%s.log' % opts.sample_id,'w')
    unfix_pct.write(
        (
         'total PE reads\t%s\n'
         'removed PE reads\t%s\n'
         'retained PE reads\t%s\n'
         'R1 corrected\t%s\n'
         'R2 corrected\t%s\n'
         'pairs corrected\t%s\n'
         'R1 unfixable\t%s\n'
         'R2 unfixable\t%s\n'
         'both reads unfixable\t%s\n'
        ) % (
         (counter / counter) * 100,
         (total_unfixable / counter) * 100,
         (total_retained / counter) * 100,
         (r1_cor_count / counter) * 100,
         (r2_cor_count / counter) * 100,
         (pair_cor_count / counter) * 100,
         (unfix_r1_count / counter) * 100,
         (unfix_r2_count / counter) * 100,
         (unfix_both_count / counter) * 100
        )
    )

    r1out.close()
    r2out.close() 
    unfix_log.close()
    unfix_pct.close()
