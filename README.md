## 2022-2023_RRP6-NAB3
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Project description](#project-description)
1. [Dependencies](#dependencies)
1. [Directory structure](#directory-structure)
1. [What to make available, what not to make available](#what-to-make-available-what-not-to-make-available)
    1. [`2023-0111`](#2023-0111)
        1. [Make available](#make-available)
            1. [Directories](#directories)
            1. [Files](#files)
        1. [Don't make available](#dont-make-available)
            1. [Directories](#directories-1)
            1. [Files](#files-1)
    1. [`2023-0115`](#2023-0115)
        1. [Make available](#make-available-1)
            1. [Directories](#directories-2)
            1. [Files](#files-2)
        1. [Don't make available](#dont-make-available-1)
            1. [Directories](#directories-3)
            1. [Files](#files-3)
        1. [General](#general)
    1. [`2023-0215`](#2023-0215)
        1. [Make available](#make-available-2)
            1. [Directories](#directories-4)
            1. [Files](#files-4)
        1. [Don't make available](#dont-make-available-2)
            1. [Directories](#directories-5)
            1. [Files](#files-5)
        1. [Maybe](#maybe)
            1. [Directories](#directories-6)
            1. [Files](#files-6)
1. [Copyright](#copyright)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="project-description"></a>
### Project description
<details>
<summary><i>Project description</i></summary>
<br />

Using yeast as a model organism, this project aims to understand how the transcriptome changes during the entry into quiescence, a reversible non-replicative state. In comparison to the transcriptomes of cycling yeast, a significant portion of the quiescent transcriptome is dedicated to noncoding transcription. To explore this noncoding transcription, we used data from 4tU-seq, an NGS assay that enables the isolation of quick-decaying nascent transcription, for transcript assembly and annotation in quiescent yeast.

In addition to nascent transcription, 4tU-seq allows us to isolate steady-state transcripts. During our transcriptome analyses, we found distinct differences between the steady-state and nascent transcriptomes in quiescence, particularly in their compositions. These observation led us to generate and analyze 4tU-seq data from deletion and depletion models for post-transcriptional regulators. The scripts and notebooks in this repository detail the analysis portion of that work, including:
1. Pre-processing, aligning, and post-processing sequenced paired-end reads
2. Drafting nascent transcriptome assemblies for cells in the quiescent (Q) and G1 states
3. Filtering and annotating the draft assemblies
4. Conducting various bioinformatics and statistical analyses and visualizing the results
</details>
<br />

<a id="dependencies"></a>
### Dependencies
<details>
<summary><i>Dependencies</i></summary>
<br />

```bash
#TODO
```
</details>
<br />

<a id="directory-structure"></a>
### Directory structure
<details>
<summary><i>Directory structure</i></summary>
<br />

```txt
2022-2023_RRP6-NAB3
├── bin
├── data
└── results
      ├── 2023-0111  # Transcriptome assembly
      │     ├── tutorial_troubleshooting
      │     └── work_initial
      ├── 2023-0115  # Pre-processing, aligning, and post-processing sequenced paired-end reads
      │     ├── etc_QC
      │     ├── etc_cleaning
      │     ├── etc_initial
      │     ├── notebook
      │     └── test_tutorial
      └── 2023-0215  # Everything else
            ├── GEO
            ├── bws
            ├── infiles_gtf-gff3
            │     ├── Trinity-GG
            │     │     ├── G_N
            │     │     └── Q_N
            │     ├── already
            │     ├── comprehensive
            │     │     └── S288C_reference_genome_R64-1-1_20110203
            │     └── representation
            │         ├── CUTs-HMM_CUTs-4X
            │         ├── CUTs_SUTs
            │         ├── NUTs
            │         ├── SRATs
            │         ├── XUTs
            │         └── ncRNAs
            ├── notebook
            ├── outfiles_gtf-gff3
            │     ├── Trinity-GG
            │     │     ├── G_N
            │     │     │     ├── err_out
            │     │     │     └── filtered
            │     │     │         ├── CDS
            │     │     │         ├── exon
            │     │     │         ├── introns_filtered
            │     │     │         ├── locus
            │     │     │         └── mRNA
            │     │     └── Q_N
            │     │         ├── err_out
            │     │         └── filtered
            │     │             ├── CDS
            │     │             ├── exon
            │     │             ├── introns_filtered
            │     │             ├── locus
            │     │             └── mRNA
            │     ├── already
            │     │     └── sgd-related
            │     ├── comprehensive
            │     │     └── S288C_reference_genome_R64-1-1_20110203
            │     └── representation
            └── outfiles_htseq-count
                ├── Trinity-GG
                │     ├── G_N
                │     │     ├── err_out
                │     │     ├── filtered
                │     │     │     └── locus
                │     │     │         └── err_out
                │     │     ├── list
                │     │     └── sh
                │     └── Q_N
                │         ├── err_out
                │         ├── filtered
                │         │     └── locus
                │         │         └── err_out
                │         ├── list
                │         └── sh
                ├── already
                │     ├── combined-AG
                │     │     ├── CUT
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── CUT_2016
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── CUT_4X
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── NUTs
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── SRAT
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── SUT
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── XUT
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── antisense_transcript
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── mRNA
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── ncRNA
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── rRNA
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── snRNA
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     ├── snoRNA
                │     │     │     ├── UTK_prim_UMI
                │     │     │     │     └── err_out
                │     │     │     └── UT_prim_UMI
                │     │     │         └── err_out
                │     │     └── tRNA
                │     │         ├── UTK_prim_UMI
                │     │         │     └── err_out
                │     │         └── UT_prim_UMI
                │     │             └── err_out
                │     └── combined-SC-KL-20S
                │         ├── UTK_prim_UMI
                │         │     └── err_out
                │         ├── UTK_prim_no
                │         │     └── err_out
                │         ├── UTK_prim_pos
                │         │     └── err_out
                │         ├── UT_prim_UMI
                │         │     └── err_out
                │         ├── UT_prim_no
                │         │     └── err_out
                │         └── UT_prim_pos
                │             └── err_out
                └── representation
                    └── UT_prim_UMI
                        └── err_out
```
</details>
<br />

<a id="what-to-make-available-what-not-to-make-available"></a>
### For clean up
<a id=""></a>
<a id="2023-0111"></a>
#### [`2023-0111`](./results/2023-0111)
<details>
<summary><i>2023-0111</i></summary>

<a id="make-available"></a>
##### Make available
<a id="directories"></a>
###### Directories
<a id="files"></a>
###### Files
- [`work_GMAP_rough-draft.md`](./results/2023-0111/work_GMAP_rough-draft.md)
    + Has initial description
    + Makes and works with paths within directory `2023-0111`
- [`work_Trinity-GF-GG-optimization_submit-jobs.md`](./results/2023-0111/work_Trinity-GF-GG-optimization_submit-jobs.md)
    + Has initial description
    + Has absolute paths in `Code`
    + Has absolute paths in `Printed`
- [`README.md`](./results/2023-0111/README.md)  `#TODO` Needs to be rewritten to explain what is run with what and in what order

<a id="dont-make-available"></a>
##### Don't make available
<a id="directories-1"></a>
###### Directories
- [`tutorial_troubleshooting`](./results/2023-0111/tutorial_troubleshooting)
- [`work_initial`](./results/2023-0111/work_initial)  `#TODO #MAYBE` Delete contents and subdirectory

<a id="files-1"></a>
###### Files
- [`check_Trinity-jobs.md`](./results/2023-0111/check_Trinity-jobs.md)
</details>
<br />

<a id="2023-0115"></a>
#### [`2023-0115`](./results/2023-0115)
<details>
<summary><i>2023-0115</i></summary>

<a id="make-available-1"></a>
##### Make available
<a id="directories-2"></a>
###### Directories

<a id="files-2"></a>
###### Files
- [`README.md`](./results/2023-0111/README.md)  `#TODO` Needs to be rewritten to explain what is run with what and in what order
- [`work_MultiQC.md`](./results/2023-0115/work_MultiQC.md)
    + Has absolute and relative paths in `Code` and `Printed`
- [`work_process-data_4tU-seq_fastqs-UMI.md`](./results/2023-0115/work_process-data_4tU-seq_fastqs-UMI.md) and [`work_process-data_4tU-seq_fastqs-UMI-dedup_new-experiments-March.md`](./results/2023-0115/work_process-data_4tU-seq_fastqs-UMI-dedup_new-experiments-March.md)
    + `#TODO` Rename the scripts
    + `#TODO` Add variables from below to top initialization, but don't bother refactoring the parallel calls to `HEREDOC` submissions

<a id="dont-make-available-1"></a>
##### Don't make available
<a id="directories-3"></a>
###### Directories
- [`etc_cleaning`](./results/2023-0115/etc_cleaning)
- [`etc_initial`](./results/2023-0115/etc_initial)
- [`etc_QC`](./results/2023-0115/etc_QC)
- [`notebook`](./results/2023-0115/notebook)

<a id="files-3"></a>
###### Files
- [`work_env-building.md`](./results/2023-0115/work_env-building.md)  `#TODO` Include info in here in new notebook and/or yamls assoc. w/[Dependencies](#dependencies)

<a id="general"></a>
##### General
- `#TODO` Add top-of-file descriptions to all notebooks that are made available
</details>
<br />

<a id="2023-0215"></a>
#### [`2023-0215`](./results/2023-0215)
<details>
<summary><i>2023-0215</i></summary>

<a id="make-available-2"></a>
##### Make available
<a id="directories-4"></a>
###### Directories
- [`infiles_gtf-gff3`](./results/2023-0215/infiles_gtf-gff3)  `#TODO` Some, not all&mdash;determine what to make available and what to not
- [`outfiles_gtf-gff3`](./results/2023-0215/outfiles_gtf-gff3)  `#TODO` Some, not all&mdash;determine what to make available and what to not
- [`outfiles_htseq-count`](./results/2023-0215/outfiles_htseq-count)  `#TODO` Some, not all&mdash;determine what to make available and what to not
- 

<a id="files-4"></a>
###### Files
- README.md  `#TODO` Needs to be rewritten to explain what is run with what and in what order
- rough-draft_coverage-tracks_timecourse_size-effect.sh
- rough-draft_coverage-tracks.sh
- rough-draft_draw_scatter-plots.R
- rough-draft_evaluate-categories_expression_initial.Rmd
- rough-draft_evaluate-categories_expression.R
- rough-draft_new-approach-to-analyses.R
- rough-draft_plot-distributions_expression.R
- rough-draft_plot-distributions_length.R
- rough-draft_plot-TPM_N-varies-on-SS_LFC-varies-on-TPM.R
- rough-draft_run-analyses_Fig-5B-5C.R
- rough-draft_run-analyses_rlog-PCA_write-rds.R
- rough-draft_write-gtf-blacklist.R  `#MAYBE`
- run_chi-sq_quantile-filtered-coding-assignments.R  `#MAYBE` Need to check on this&mdash;associated with data-for-chi-sq.xlsx below?
- work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-0.Rmd  `#COMBINE?`
- work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-1.Rmd  `#COMBINE?`
- work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-2_legend.txt  `#COMBINE?`
- work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-2.R  `#COMBINE?`
- work_assess-process_R64-1-1-gff3_categorize-Trinity-transfrags_part-3.R  `#COMBINE?`
- work_assessment-processing_gtfs_part-0_Trinity-etc.md  `#COMBINE?`
- work_assessment-processing_gtfs_part-0.5_non-Trinity.Rmd  `#COMBINE?`
- work_assessment-processing_gtfs_part-1_Trinity.Rmd  `#COMBINE?`
- work_assessment-processing_gtfs_part-1.5_Trinity.R  `#COMBINE?`
- work_assessment-processing_gtfs_part-2_Trinity.md  `#COMBINE?`
- work_calculate_uni-multimappers-etc.md  `#COMBINE?`
- work_combine-gtfs_processed-ncRNA_part-0.Rmd  `#COMBINE?`
- work_combine-gtfs_processed-ncRNA_part-1.md  `#COMBINE?`
- work_combine-gtfs_processed-non-pa-ncRNA_part-0.Rmd  `#COMBINE?`
- work_combine-gtfs_processed-non-pa-ncRNA_part-1.md  `#COMBINE?`
- work_combine-gtfs_processed-pa-ncRNA_part-0.Rmd  `#COMBINE?`
- work_combine-gtfs_processed-pa-ncRNA_part-1.md  `#COMBINE?`
- work_count-features_assessed-processed-R64-1-1-gff3s.md  `#MAYBE`
- work_gff3_include-20S.md
- work_make-blacklist-etc.py  `#TODO` This needs to be rewritten for just the NotFeature file&mdash;can remain in Python, or may switch to R (whatever is faster)
- work_prepare-data_GEO_matrices.R
- work_prepare-data_GEO.md
- work_preprocess-prepare_htseq-counts-matrices_gtf-gff3_etc.Rmd  `#MAYBE` Create a directory for initial work and just keep it there w/o making it public? Not sure...
- work_representative-non-coding-transcriptome_part-0.md  `#COMBINE?`
- work_representative-non-coding-transcriptome_part-1.md  `#COMBINE?`
- work_representative-non-coding-transcriptome_part-2.Rmd  `#COMBINE?`
- work_representative-non-coding-transcriptome_part-3.md  `#COMBINE?`
- work_representative-non-coding-transcriptome_part-4.Rmd  `#COMBINE?`
- work_representative-non-coding-transcriptome_part-5.md  `#COMBINE?`

<a id="dont-make-available-2"></a>
##### Don't make available
<a id="directories-5"></a>
###### Directories
- [`bws`](./results/2023-0215/bws)
- [`GEO`](./results/2023-0215/GEO)
- [`notebook`](./results/2023-0215/notebook)

<a id="files-5"></a>
###### Files
- ~~data_timecourse_counts-raw.tsv~~  `#MAYBE` Delete?
- ~~data_timecourse_counts-rlog.tsv~~  `#TODO` Delete
- ~~data-for-chi-sq.xlsx~~  `#TODO` Delete
- rough-draft_estimate-RNA-degredation.R
- ~~rough-draft_evaluate-categories_expression_scraps_initial.Rmd~~  `#MAYBE` Delete?
- ~~rough-draft_new-approach-to-analyses_tests-scraps.R~~  `#TODO` Delete
- ~~rough-draft_plot-TPM_N-varies-on-SS.scraps.R~~  `#TODO` Delete
- ~~rough-draft_run-analyses_rlog-PCA_write-rds.notes-2.txt~~  `#TODO` Delete
- ~~rough-draft_run-analyses_rlog-PCA_write-rds.notes.txt~~  `#TODO` Delete
- ~~rough-draft_run-analyses_rlog-PCA_write-rds.scraps.R~~  `#TODO` Delete
- tutorial_collapse-intersecting-regions.R
- tutorial_extract-non-overlapping-regions.R
- work_env-building.md  `#TODO` Include info in here in new notebook and/or yamls assoc. w/[Dependencies](#dependencies)
- test_count_features.md  `#MAYBE` Delete it? Or maybe create a directory for initial work and just keep it there w/o making it public?
- work_count_features_featureCounts.md  `#MAYBE` Delete it? Or create a directory for initial work and just keep it there w/o making it public?
- work_count_features_htseq-count.md  `#TODO` Create a directory for initial work and just keep it there w/o making it public? (This is the work in prep for AG's FHCC seminar.)
- work_evaluation-etc_rough-draft_Rrp6-WT_SS_timecourse_groupwise.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public? (This is the work in prep for AG's FHCC seminar.)
- work_evaluation-etc_variables_pairwise-groupwise.Rmd  `#TODO` Delete
- work_evaluation-etc_variables_pairwise-groupwise.tmp-gw.R  `#TODO` Delete
- work_evaluation-etc_variables_pairwise-groupwise.tmp-pw.R  `#TODO` Delete
- work_evaluation-etc_variables_pairwise-groupwise.TODOs-scraps-etc.txt
- work_examine-snRNA-snoRNA-annotations_part-1.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public?  `#ORKEEP?`
- work_examine-snRNA-snoRNA-annotations_part-2.md  `#TODO` Create a directory for initial work and just keep it there w/o making it public?  `#ORKEEP?`
- work_gff3_convert-strand-designations.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public?
- work_model-variables.md  `#NOTE` Don't need to actually make this file available, but `#TODO` should include the information contained in this file in either the main or a sub README.md
- work_normalization-etc_rough-draft_NNS_vary-on-transcription.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public
- work_normalization-etc_rough-draft_OsTIR-NNS_vary-on-strain.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public
- work_normalization-etc_rough-draft_wild-type_vary-on-state_antisense.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public
- work_normalization-etc_rough-draft_wild-type_vary-on-state.Rmd  `#TODO` Create a directory for initial work and just keep it there w/o making it public
- 

<a id="maybe"></a>
##### Maybe
<a id="directories-6"></a>
###### Directories

<a id="files-6"></a>
###### Files
- collate_sea-tsv.sh  `#NOTE` AG used this for her bootstrapping thing
- rough-draft_handle-matrices-gtfs.R  `#NOTE` Do we use this for anything in the figures?
- rough-draft_handle-tables_establish-study-design.R  `#NOTE` Do we use this for anything in the figures?
- rough-draft_run-analyses_GO.R  `#NOTE` Not sure if we actually use this
- rough-draft_timecourse-samples_processing_part-1a.R  `#TODO` Need to check on this...
- rough-draft_timecourse-samples_processing_part-1b.R  `#TODO` Need to check on this...
- rough-draft_timecourse-samples_processing_part-1c.R  `#TODO` Need to check on this...
- rough-draft_timecourse-samples_processing_part-2a.R  `#TODO` Need to check on this...
</details>
<br />

<a id="copyright"></a>
### Copyright
Copyright © 2022-2023 Kris Alavattam

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
