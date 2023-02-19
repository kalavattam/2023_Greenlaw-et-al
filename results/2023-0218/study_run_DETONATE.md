
`#study_DETONATE.md`

## Install DETONATE, check on and install dependencies
### Code
<details>
<summary><i>Code: Install DETONATE, check on and install dependencies</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

mamba create -n detonate_env -c bioconda detonate
mamba activate detonate_env
which bowtie  # Not found
which bowtie2  # Not found
which rsem  # Not found

#  Try tab completion options for 'rse' (reported below)

```
</details>
<br />

### Printed
<details>
<summary><i>Printed: Install DETONATE, check on and install dependencies</i></summary>

```txt

                  __    __    __    __
                 /  \  /  \  /  \  /  \
                /    \/    \/    \/    \
███████████████/  /██/  /██/  /██/  /████████████████████████
              /  / \   / \   / \   / \  \____
             /  /   \_/   \_/   \_/   \    o \__,
            / _/                       \_____/  `
            |/
        ███╗   ███╗ █████╗ ███╗   ███╗██████╗  █████╗
        ████╗ ████║██╔══██╗████╗ ████║██╔══██╗██╔══██╗
        ██╔████╔██║███████║██╔████╔██║██████╔╝███████║
        ██║╚██╔╝██║██╔══██║██║╚██╔╝██║██╔══██╗██╔══██║
        ██║ ╚═╝ ██║██║  ██║██║ ╚═╝ ██║██████╔╝██║  ██║
        ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝

        mamba (0.25.0) supported by @QuantStack

        GitHub:  https://github.com/mamba-org/mamba
        Twitter: https://twitter.com/QuantStack

█████████████████████████████████████████████████████████████


Looking for: ['detonate']

bioconda/osx-64                                      3.8MB @   3.2MB/s  1.3s
bioconda/noarch                                      4.2MB @   3.2MB/s  1.4s
pkgs/r/osx-64                                                 No change
pkgs/r/noarch                                                 No change
pkgs/main/osx-64                                     4.9MB @   3.3MB/s  1.6s
pkgs/main/noarch                                   819.1kB @ 478.7kB/s  0.3s
conda-forge/noarch                                  11.3MB @   4.5MB/s  2.8s
conda-forge/osx-64                                  26.9MB @   4.6MB/s  6.6s
Transaction

  Prefix: /Users/kalavattam/miniconda3/envs/detonate_env

  Updating specs:

   - detonate


  Package                 Version  Build               Channel                  Size
──────────────────────────────────────────────────────────────────────────────────────
  Install:
──────────────────────────────────────────────────────────────────────────────────────

  + boost                  1.66.0  py27_1              conda-forge/osx-64      305kB
  + boost-cpp              1.66.0  1                   conda-forge/osx-64       18MB
  + bzip2                   1.0.8  h0d85af4_4          conda-forge/osx-64     Cached
  + c-ares                 1.18.1  h0d85af4_0          conda-forge/osx-64     Cached
  + ca-certificates     2022.12.7  h033912b_0          conda-forge/osx-64     Cached
  + certifi            2019.11.28  py27h8c360ce_1      conda-forge/osx-64     Cached
  + curl                   7.76.1  h06286d4_1          conda-forge/osx-64     Cached
  + detonate                 1.11  h4b68e70_3          bioconda/osx-64           1MB
  + icu                      58.2  h0a44026_1000       conda-forge/osx-64       23MB
  + krb5                   1.17.1  h1752a42_0          conda-forge/osx-64        1MB
  + libblas                 3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libcblas                3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libcurl                7.76.1  h8ef9fac_1          conda-forge/osx-64     Cached
  + libcxx                 14.0.6  hccf4f1f_0          conda-forge/osx-64     Cached
  + libedit          3.1.20170329  0                   conda-forge/osx-64      159kB
  + libev                    4.33  haf1e3a3_1          conda-forge/osx-64     Cached
  + libffi                  3.2.1  1                   bioconda/osx-64        Cached
  + libgfortran             5.0.0  11_3_0_h97931a8_27  conda-forge/osx-64     Cached
  + libgfortran5           11.3.0  h082f757_27         conda-forge/osx-64     Cached
  + liblapack               3.9.0  16_osx64_openblas   conda-forge/osx-64     Cached
  + libnghttp2             1.47.0  h942079c_0          conda-forge/osx-64     Cached
  + libopenblas            0.3.21  openmp_h429af6e_3   conda-forge/osx-64     Cached
  + libssh2                1.10.0  h52ee1ee_2          conda-forge/osx-64     Cached
  + libzlib                1.2.11  h6c3fc93_1014       conda-forge/osx-64     Cached
  + llvm-openmp            15.0.7  h61d9ccf_0          conda-forge/osx-64     Cached
  + ncurses                   5.9  10                  conda-forge/osx-64        1MB
  + numpy                  1.16.5  py27hde6bac1_0      conda-forge/osx-64     Cached
  + openssl                1.1.1t  hfd90126_0          conda-forge/osx-64        2MB
  + perl                   5.32.1  2_h0d85af4_perl5    conda-forge/osx-64     Cached
  + pip                    20.1.1  pyh9f0ad1d_0        conda-forge/noarch     Cached
  + python                 2.7.15  h932b40d_1008       conda-forge/osx-64       13MB
  + python_abi                2.7  1_cp27m             conda-forge/osx-64        4kB
  + readline                  7.0  0                   conda-forge/osx-64      392kB
  + samtools                  1.3  h7b56a33_5          bioconda/osx-64         462kB
  + setuptools             44.0.0  py27_0              conda-forge/osx-64     Cached
  + sqlite                 3.26.0  ha441bb4_0          pkgs/main/osx-64          1MB
  + tk                     8.6.12  h5dbffcc_0          conda-forge/osx-64     Cached
  + wheel                  0.37.1  pyhd8ed1ab_0        conda-forge/noarch     Cached
  + xz                      5.2.6  h775f41a_0          conda-forge/osx-64     Cached
  + zlib                   1.2.11  h6c3fc93_1014       conda-forge/osx-64     Cached

  Summary:

  Install: 40 packages

  Total download: 62MB

──────────────────────────────────────────────────────────────────────────────────────

Confirm changes: [Y/n] Y
libedit                                            158.8kB @ 542.7kB/s  0.3s
readline                                           392.2kB @   1.2MB/s  0.3s
python_abi                                           3.7kB @   8.6kB/s  0.1s
ncurses                                              1.2MB @   2.6MB/s  0.5s
openssl                                              1.7MB @   3.5MB/s  0.5s
krb5                                                 1.3MB @   1.6MB/s  0.5s
detonate                                             1.1MB @   1.2MB/s  0.6s
sqlite                                               1.3MB @   1.2MB/s  0.6s
boost                                              305.4kB @ 265.4kB/s  0.4s
samtools                                           461.9kB @ 174.1kB/s  1.6s
icu                                                 23.4MB @   6.8MB/s  3.4s
python                                              12.7MB @   2.7MB/s  4.2s
boost-cpp                                           18.1MB @   3.4MB/s  4.4s
Preparing transaction: done
Verifying transaction: done
Executing transaction: done

To activate this environment, use

     $ mamba activate detonate_env

To deactivate an active environment, use

     $ mamba deactivate


❯ rse
rSend                                              rSend-maturation                                   rsem-parse-alignments
rSend-4dn                                          rSend-maturation-bin                               rsem-plot-model
rSend-4dn-bin                                      rSend-results-drivers                              rsem-preref
rSend-HOME                                         rSend-thorough                                     rsem-sam-validator
rSend-bin                                          rsem-build-read-index                              rsem-scan-for-paired-end-reads
rSend-bin-data-drivers                             rsem-eval-calculate-score                          rsem-simulate-reads
rSend-bin-data-results-drivers                     rsem-eval-estimate-transcript-length-distribution  rsem-synthesis-reference-transcripts
rSend-bin-results-drivers                          rsem-eval-run-em                                   rsem_perl_utils.pm
rSend-data-drivers                                 rsem-extract-reference-transcripts
```
</details>
<br />
<br />

## Breaking down the DETONATE vignette
### <u>I</u> Run RSEM-EVAL on each assembly
#### Breakdown the command-line call
<details>
<summary><i>Notes: Breakdown the command-line call</i></summary>

1. Obtain the average fragment length for data with, e.g., [picard CollectInsertSizeMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360037055772-CollectInsertSizeMetrics-Picard-)
2. Run something like the following&mdash;except adapted for paired-end reads
```bash
./rsem-eval/rsem-eval-calculate-score \
	examples/toy_SE.fq \
	examples/toy_assembly_1.fa \
	examples/rsem_eval_1 \
	76 \
	--transcript-length-parameters \
	rsem-eval/true_transcript_length_distribution/mouse.txt \
	-p 16
```
...where
- positional argument 1: specify the reads
- positional argument 2: specify the assembly
- positional argument 3: specify the path and prefix for output
- positional argument 4:
	+ single-end RNA-seq reads: specify the read length; if there are multiple read lengths, then specify the mean
	+ paired-end RNA-seq reads: mean fragment length obtained from something like [picard CollectInsertSizeMetrics](https://gatk.broadinstitute.org/hc/en-us/articles/360037055772-CollectInsertSizeMetrics-Picard-)
</details>
<br />

### <u>II</u> Run RSEM-EVAL on each assembly


## etc.
```bash
#!/bin/bash

rsem-eval-calculate-score
```

```txt



❯ rsem-eval-calculate-score
Invalid number of arguments!
NAME
    rsem-eval-calculate-score

SYNOPSIS
     rsem-eval-calculate-score [options] upstream_read_file(s) assembly_fasta_file sample_name L
     rsem-eval-calculate-score [options] --paired-end upstream_read_file(s) downstream_read_file(s) assembly_fasta_file sample_name L
     rsem-eval-calculate-score [options] --sam/--bam [--paired-end] input assembly_fasta_file sample_name L

ARGUMENTS
    upstream_read_files(s)
        Comma-separated list of files containing single-end reads or
        upstream reads for paired-end data. By default, these files are
        assumed to be in FASTQ format. If the --no-qualities option is
        specified, then FASTA format is expected.

    downstream_read_file(s)
        Comma-separated list of files containing downstream reads which are
        paired with the upstream reads. By default, these files are assumed
        to be in FASTQ format. If the --no-qualities option is specified,
        then FASTA format is expected.

    input
        SAM/BAM formatted input file. If "-" is specified for the filename,
        SAM/BAM input is instead assumed to come from standard input.
        RSEM-EVAL requires all alignments of the same read group together.
        For paired-end reads, RSEM-EVAL also requires the two mates of any
        alignment be adjacent. See Description section for how to make input
        file obey RSEM-EVAL's requirements.

    assembly_fasta_file
        A multi-FASTA file contains the assembly used for calculating
        RSEM-EVAL score.

    sample_name
        The name of the sample analyzed. All output files are prefixed by
        this name (e.g., sample_name.isoforms.results).

    L   For single-end data, L represents the average read length. For
        paired-end data, L represents the average fragment length. It should
        be a positive integer (real value will be rounded to the nearest
        integer).

BASIC OPTIONS
    --overlap-size <int>
        The minimum overlap size required to join two reads together.
        (Default: 0)

    --transcript-length-parameters <file>
        Read the true transcript length distribution's mean and standard
        deviation from <file>. This option is mutually exclusive with
        '--transcript-length-mean' and '--transcript-length-sd'. (Default:
        off)

    --transcript-length-mean <double>
        The mean of true transcript length distribution. This option is used
        together with '--transcript-length-sd' and mutually exclusive with
        '--estimate-transcript-length-distribution'. (Default: learned from
        human Ensembl annotation and hg20 genome)

    --transcript-length-sd <double>
        The standard deviation of true transcript length distribution. This
        option is used together with '--transcript-length-mean' and mutually
        exclusive with '--estimate-transcript-length-distribution'.
        (Default: learned from human Ensembl annotation and hg20 genome)

    --paired-end
        Input reads are paired-end reads. (Default: off)

    --no-qualities
        Input reads do not contain quality scores. (Default: off)

    --strand-specific
        The RNA-Seq protocol used to generate the reads is strand specific,
        i.e., all (upstream) reads are derived from the forward strand. This
        option is equivalent to --forward-prob=1.0. With this option set, if
        RSEM-EVAL runs the Bowtie/Bowtie 2 aligner, the '--norc'
        Bowtie/Bowtie 2 option will be used, which disables alignment to the
        reverse strand of transcripts. (Default: off)

    --bowtie2
        Use Bowtie 2 instead of Bowtie to align reads. Since currently
        RSEM-EVAL does not handle indel, local and discordant alignments,
        the Bowtie2 parameters are set in a way to avoid those alignments.
        In particular, we use options '--sensitive --dpad 0 --gbar 99999999
        --mp 1,1 --np 1 --score-min L,0,-0.1' by default. "-0.1", the last
        parameter of '--score-min' is the negative value of the maximum
        mismatch rate allowed. This rate can be set by option
        '--bowtie2-mismatch-rate'. If reads are paired-end, we additionally
        use options '--no-mixed' and '--no-discordant'. (Default: off)

    --sam
        Input file is in SAM format. (Default: off)

    --bam
        Input file is in BAM format. (Default: off)

    -p/--num-threads <int>
        Number of threads to use. Both Bowtie/Bowtie2, expression estimation
        and 'samtools sort' will use this many threads. (Default: 1)

    --output-bam
        Generate BAM outputs. (Default: off)

    --sampling-for-bam
        When RSEM-EVAL generates a BAM file, instead of outputing all
        alignments a read has with their posterior probabilities, one
        alignment is sampled according to the posterior probabilities. The
        sampling procedure includes the alignment to the "noise" transcript,
        which does not appear in the BAM file. Only the sampled alignment
        has a weight of 1. All other alignments have weight 0. If the
        "noise" transcript is sampled, all alignments appeared in the BAM
        file should have weight 0. (Default: off)

    --seed <uint32>
        Set the seed for the random number generators used in calculating
        posterior mean estimates and credibility intervals. The seed must be
        a non-negative 32 bit interger. (Default: off)

    -q/--quiet
        Suppress the output of logging information. (Default: off)

    -h/--help
        Show help information.

    --version
        Show version information.

ADVANCED OPTIONS
    --sam-header-info <file>
        RSEM-EVAL reads header information from input by default. If this
        option is on, header information is read from the specified file.
        For the format of the file, please see SAM official website.
        (Default: "")

    --seed-length <int>
        Seed length used by the read aligner. Providing the correct value is
        important for RSEM-EVAL. If RSEM-EVAL runs Bowtie, it uses this
        value for Bowtie's seed length parameter. Any read with its or at
        least one of its mates' (for paired-end reads) length less than this
        value will be ignored. If the references are not added poly(A)
        tails, the minimum allowed value is 5, otherwise, the minimum
        allowed value is 25. Note that this script will only check if the
        value >= 5 and give a warning message if the value < 25 but >= 5.
        (Default: 25)

    --tag <string>
        The name of the optional field used in the SAM input for identifying
        a read with too many valid alignments. The field should have the
        format <tagName>:i:<value>, where a <value> bigger than 0 indicates
        a read with too many alignments. (Default: "")

    --bowtie-path <path>
        The path to the Bowtie executables. (Default: the path to the Bowtie
        executables is assumed to be in the user's PATH environment
        variable)

    --bowtie-n <int>
        (Bowtie parameter) max # of mismatches in the seed. (Range: 0-3,
        Default: 2)

    --bowtie-e <int>
        (Bowtie parameter) max sum of mismatch quality scores across the
        alignment. (Default: 99999999)

    --bowtie-m <int>
        (Bowtie parameter) suppress all alignments for a read if > <int>
        valid alignments exist. (Default: 200)

    --bowtie-chunkmbs <int>
        (Bowtie parameter) memory allocated for best first alignment
        calculation (Default: 0 - use Bowtie's default)

    --phred33-quals
        Input quality scores are encoded as Phred+33. (Default: on)

    --phred64-quals
        Input quality scores are encoded as Phred+64 (default for GA
        Pipeline ver. >= 1.3). (Default: off)

    --solexa-quals
        Input quality scores are solexa encoded (from GA Pipeline ver. <
        1.3). (Default: off)

    --bowtie2-path <path>
        (Bowtie 2 parameter) The path to the Bowtie 2 executables. (Default:
        the path to the Bowtie 2 executables is assumed to be in the user's
        PATH environment variable)

    --bowtie2-mismatch-rate <double>
        (Bowtie 2 parameter) The maximum mismatch rate allowed. (Default:
        0.1)

    --bowtie2-k <int>
        (Bowtie 2 parameter) Find up to <int> alignments per read. (Default:
        200)

    --bowtie2-sensitivity-level <string>
        (Bowtie 2 parameter) Set Bowtie 2's preset options in --end-to-end
        mode. This option controls how hard Bowtie 2 tries to find
        alignments. <string> must be one of "very_fast", "fast", "sensitive"
        and "very_sensitive". The four candidates correspond to Bowtie 2's
        "--very-fast", "--fast", "--sensitive" and "--very-sensitive"
        options. (Default: "sensitive" - use Bowtie 2's default)

    --forward-prob <double>
        Probability of generating a read from the forward strand of a
        transcript. Set to 1 for a strand-specific protocol where all
        (upstream) reads are derived from the forward strand, 0 for a
        strand-specific protocol where all (upstream) read are derived from
        the reverse strand, or 0.5 for a non-strand-specific protocol.
        (Default: 0.5)

    --fragment-length-min <int>
        Minimum read(SE)/fragment(PE) length allowed. This is also the value
        for the Bowtie/Bowtie2 -I option. (Default: 1)

    --fragment-length-max <int>
        Maximum read(SE)/fragment(PE) length allowed. This is also the value
        for the Bowtie/Bowtie 2 -X option. (Default: 1000)

    --estimate-rspd
        Set this option if you want to estimate the read start position
        distribution (RSPD) from data. Otherwise, RSEM-EVAL will use a
        uniform RSPD. (Default: off)

    --num-rspd-bins <int>
        Number of bins in the RSPD. Only relevant when '--estimate-rspd' is
        specified. Use of the default setting is recommended. (Default: 20)

    --samtools-sort-mem <string>
        Set the maximum memory per thread that can be used by 'samtools
        sort'. <string> represents the memory and accepts suffices 'K/M/G'.
        RSEM-EVAL will pass <string> to the '-m' option of 'samtools sort'.
        Please note that the default used here is different from the default
        used by samtools. (Default: 1G)

    --keep-intermediate-files
        Keep temporary files generated by RSEM-EVAL. RSEM-EVAL creates a
        temporary directory, 'sample_name.temp', into which it puts all
        intermediate output files. If this directory already exists,
        RSEM-EVAL overwrites all files generated by previous RSEM-EVAL runs
        inside of it. By default, after RSEM-EVAL finishes, the temporary
        directory is deleted. Set this option to prevent the deletion of
        this directory and the intermediate files inside of it. (Default:
        off)

    --temporary-folder <string>
        Set where to put the temporary files generated by RSEM-EVAL. If the
        folder specified does not exist, RSEM-EVAL will try to create it.
        (Default: sample_name.temp)

    --time
        Output time consumed by each step of RSEM-EVAL to
        'sample_name.time'. (Default: off)

DESCRIPTION
    In its default mode, this program builds indices, aligns input reads
    against a reference assembly with Bowtie and calculates RSEM-EVAL score
    and expression values using the alignments. RSEM-EVAL assumes the data
    are single-end reads with quality scores, unless the '--paired-end' or
    '--no-qualities' options are specified. Users may use an alternative
    aligner by specifying one of the --sam and --bam options, and providing
    an alignment file in the specified format. However, users should make
    sure that they align against 'assembly_fasta_file' and the alignment
    file satisfies the requirements mentioned in ARGUMENTS section.

    The SAM/BAM format RSEM-EVAL uses is v1.4. However, it is compatible
    with old SAM/BAM format. However, RSEM-EVAL cannot recognize 0x100 in
    the FLAG field. In addition, RSEM-EVAL requires SEQ and QUAL are not
    '*'.

    Please note that some of the default values for the Bowtie parameters
    are not the same as those defined for Bowtie itself.

    The temporary directory and all intermediate files will be removed when
    RSEM-EVAL finishes unless '--keep-intermediate-files' is specified.

OUTPUT
    sample_name.score, sample_name.score.isoforms.results and
    sample_name.score.genes.results
        'sample_name.score' stores the evaluation score for the evaluated
        assembly. It contains 13 lines and each line contains a name and a
        value separated by a tab.

        The first 6 lines provide: 'Score', the RSEM-EVAL score;
        'BIC_penalty', the BIC penalty term;
        'Prior_score_on_contig_lengths_(f_function_canceled)', the log score
        of priors of contig lengths, with f function values excluded (f
        function is defined in equation (4) at page 5 of Additional file 1,
        which is the supplementary methods, tables and figures of our
        DETONATE paper); 'Prior_score_on_contig_sequences', the log score of
        priors of contig sequence bases;
        'Data_likelihood_in_log_space_without_correction', the RSEM log data
        likelihood calculated with contig-level read generating
        probabilities mentioned in section 4 of Additional file 1;
        'Correction_term_(f_function_canceled)', the correction term, with f
        function values excluded. Score = BIC_penalty +
        Prior_score_on_contig_lengths + Prior_score_on_contig_sequences +
        Data_likelihood_in_log_space_without_correction - Correction_term.
        Because both 'Prior_score_on_contig_lengths' and 'Correction_term'
        share the same f function values for each contig, the f function
        values can be canceled out. Then
        'Prior_score_on_contig_lengths_(f_function_canceled)' is the sum of
        log $c_{\lambda}(\ell)$ terms in equation (9) at page 5 of
        Additional file 1. 'Correction_term_(f_function_canceled)' is the
        sum of log $(1 - p_{\lambda_i})$ terms in equation (23) at page 9 of
        Additional file 1. For the correction term, we use $\lambda_i$
        instead of $\lambda'_i$ to make f function canceled out.

        The next 7 lines provide statistics that may help users to
        understand the RSEM-EVAL score better. They are:
        'Number_of_contigs', the number of contigs contained in the
        assembly; 'Expected_number_of_aligned_reads_given_the_data', the
        expected number of reads assigned to each contig estimated using the
        contig-level read generating probabilities mentioned in section 4 of
        Additional file 1;
        'Number_of_contigs_smaller_than_expected_read/fragment_length', the
        number of contigs whose length is smaller than the expected
        read/fragment length; 'Number_of_contigs_with_no_read_aligned_to',
        the number of contigs whose expected number of aligned reads is
        smaller than 0.005; 'Maximum_data_likelihood_in_log_space', the
        maximum data likelihood in log space calculated from RSEM by
        treating the assembly as "true" transcripts;
        'Number_of_alignable_reads', the number of reads that have at least
        one alignment found by the aligner (Because
        'rsem-calculate-expression' tries to use a very loose criteria to
        find alignments, reads with only low quality alignments may also be
        counted as alignable reads here); 'Number_of_alignments_in_total',
        the number of total alignments found by the aligner.

        'sample_name.score.isoforms.results' and
        'sample_name.score.genes.results' output "corrected" expression
        levels based on contig-level read generating probabilities mentioned
        in section 4 of Additional file 1. Unlike
        'sample_name.isoforms.results' and 'sample_name.genes.results',
        which are calculated by treating the contigs as true transcripts,
        calculating 'sample_name.score.isoforms.results' and
        'sample_name.score.genes.results' involves first estimating expected
        read coverage for each contig and then convert the expected read
        coverage into contig-level read generating probabilities. This
        procedure is aware of that provided sequences are contigs and gives
        better expression estimates for very short contigs. In addtion, the
        'TPM' field is changed to 'CPM' field, which stands for contig per
        million.

        For 'sample_name.score.isoforms.results', one additional column is
        added. The additional column is named as 'contig_impact_score' and
        gives the contig impact score for each contig as described in
        section 5 of Additional file 1.

    sample_name.isoforms.results
        File containing isoform level expression estimates. The first line
        contains column names separated by the tab character. The format of
        each line in the rest of this file is:

        transcript_id gene_id length effective_length expected_count TPM
        FPKM IsoPct

        Fields are separated by the tab character.

        'transcript_id' is the transcript name of this transcript. 'gene_id'
        is the gene name of the gene which this transcript belongs to
        (denote this gene as its parent gene). If no gene information is
        provided, 'gene_id' and 'transcript_id' are the same.

        'length' is this transcript's sequence length (poly(A) tail is not
        counted). 'effective_length' counts only the positions that can
        generate a valid fragment. If no poly(A) tail is added,
        'effective_length' is equal to transcript length - mean fragment
        length + 1. If one transcript's effective length is less than 1,
        this transcript's both effective length and abundance estimates are
        set to 0.

        'expected_count' is the sum of the posterior probability of each
        read comes from this transcript over all reads. Because 1) each read
        aligning to this transcript has a probability of being generated
        from background noise; 2) RSEM-EVAL may filter some alignable low
        quality reads, the sum of expected counts for all transcript are
        generally less than the total number of reads aligned.

        'TPM' stands for Transcripts Per Million. It is a relative measure
        of transcript abundance. The sum of all transcripts' TPM is 1
        million. 'FPKM' stands for Fragments Per Kilobase of transcript per
        Million mapped reads. It is another relative measure of transcript
        abundance. If we define l_bar be the mean transcript length in a
        sample, which can be calculated as

        l_bar = \sum_i TPM_i / 10^6 * effective_length_i (i goes through
        every transcript),

        the following equation is hold:

        FPKM_i = 10^3 / l_bar * TPM_i.

        We can see that the sum of FPKM is not a constant across samples.

        'IsoPct' stands for isoform percentage. It is the percentage of this
        transcript's abandunce over its parent gene's abandunce. If its
        parent gene has only one isoform or the gene information is not
        provided, this field will be set to 100.

    sample_name.genes.results
        File containing gene level expression estimates. The first line
        contains column names separated by the tab character. The format of
        each line in the rest of this file is:

        gene_id transcript_id(s) length effective_length expected_count TPM
        FPKM

        Fields are separated by the tab character.

        'transcript_id(s)' is a comma-separated list of transcript_ids
        belonging to this gene. If no gene information is provided,
        'gene_id' and 'transcript_id(s)' are identical (the
        'transcript_id').

        A gene's 'length' and 'effective_length' are defined as the weighted
        average of its transcripts' lengths and effective lengths (weighted
        by 'IsoPct'). A gene's abundance estimates are just the sum of its
        transcripts' abundance estimates.

    sample_name.transcript.bam, sample_name.transcript.sorted.bam and
    sample_name.transcript.sorted.bam.bai
        Only generated when --output-bam is specified.

        'sample_name.transcript.bam' is a BAM-formatted file of read
        alignments in transcript coordinates. The MAPQ field of each
        alignment is set to min(100, floor(-10 * log10(1.0 - w) + 0.5)),
        where w is the posterior probability of that alignment being the
        true mapping of a read. In addition, RSEM-EVAL pads a new tag
        ZW:f:value, where value is a single precision floating number
        representing the posterior probability. Because this file contains
        all alignment lines produced by bowtie or user-specified aligners,
        it can also be used as a replacement of the aligner generated
        BAM/SAM file. For paired-end reads, if one mate has alignments but
        the other does not, this file marks the alignable mate as
        "unmappable" (flag bit 0x4) and appends an optional field "Z0:A:!".

        'sample_name.transcript.sorted.bam' and
        'sample_name.transcript.sorted.bam.bai' are the sorted BAM file and
        indices generated by samtools (included in RSEM-EVAL package).

    sample_name.time
        Only generated when --time is specified.

        It contains time (in seconds) consumed by building references,
        aligning reads, estimating expression levels and calculating
        credibility intervals.

    sample_name.stat
        This is a folder instead of a file. All model related statistics are
        stored in this folder. Use 'rsem-plot-model' can generate plots
        using this folder.

EXAMPLES
    We want to compute the RSEM-EVAL score for a contig assembly,
    'assembly1.fa'. Our data are 76bp single-end reads contained in
    '/data/reads.fq'. The related species is human and
    'human_transcripts.fa' contains all human transcripts. We use 8 threads
    and do not generate any BAM files. In addition, we set the overlap size
    w as 0 and 'sample_name' as 'assembly1_rsem_eval'.

    First, we need to estimate the true transcript length distribution using
    'human_transcripts.fa':

     rsem-eval-estimate-transcript-length-distribution human_transcripts.fa human.txt

    Now, we can calculate RSEM-EVAL score:

     rsem-eval-calculate-score -p 8 \
                               --transcript-length-parameters human.txt \
                               /data/reads.fq \
                               assembly1.fa \
                               assembly1_rsem_eval \
                               76

    The RSEM-EVAL score can be found in 'assembly1_rsem_eval.score' and the
    contig impact scores can be found in
    'assembly1_rsem_eval.score.isoforms.results'.
```

## Miscellaneous
- [The Concepts of Mean Fragment Length and Effective Length in RNA Sequencing](https://www.youtube.com/watch?v=BNVMVpToGsM&t)  `#WATCHED`
- [Calculating Gene Length for RNA Sequencing Experiment](https://www.youtube.com/watch?v=wbspK7ezV0A)  `#UNWATCHED`

