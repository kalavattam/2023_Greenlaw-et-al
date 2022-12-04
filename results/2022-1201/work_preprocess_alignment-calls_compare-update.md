
# `work_preprocess_alignment-calls_compare-update.md`
Comparing, updating STAR alignment calls (2022-1203)
## On `multi-hit` mode
```bash
#!/bin/bash
#DONTRUN

#  Previous call (results/2022-1101/)
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMattributes All \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1000 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
#  19 lines

#  Updated call (results/2022-1201/): Addition of --outSAMunmapped to match
#+ rna-star call below; previously, it was not specified and thus set to
#+ default value of 'None'
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped None \
    --outSAMattributes All \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1000 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
#  20 lines
```

- Hold `--winAnchorMultimapNmax 1000` while changing `--outFilterMultimapNmax`
    + 1
        * `#QUESTION` Do we just do a separate call for the value of 1?
        * `#DECISION` Include it because it is different from `rna-star` mode, which aligns with `--alignEndsType Local` 
    + 10  `#NOTE` Default value for `--outFilterMultimapNmax`
    + 100
    + 1000
- `#NOTE` Default value for `--winAnchorMultimapNmax`: 50
- `#QUESTION` What is present in this call that's not present in the `rna-star`-mode call?
    + There are 19 lines here versus 15 for `rna-star` mode
    + `#ANSWER`
        * `--runMode alignReads`
        * `--outSAMattributes All`
        * `--winAnchorMultimapNmax`
        * `--outMultimapperOrder Random`
    + Although not explicitly defined in `rna-star` mode...
        * the following are still called:
            - `--runMode alignReads`
            - `--outSAMattributes Standard`
            - `--winAnchorMultimapNmax 50`
        * `#TODO` Make the above parameters explicit
        * `#TODO` Change `--outSAMattributes Standard` to `--outSAMattributes All`
        * Final `rna-star` call will have 18 lines b/c not adding `--outMultimapperOrder Random`
<br />
<br />

## On `rna-star` mode
```bash
#!/bin/bash
#DONTRUN

#  Previous call (results/2022-1101/)
STAR \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000

# STAR \
#     --runThreadN "${SLURM_CPUS_ON_NODE}" \  #SAMEASmulti-hit-mode
#     --outSAMtype BAM SortedByCoordinate \  #SAMEASmulti-hit-mode
#     --outSAMunmapped Within \  #SAMEASmulti-hit-mode
#     --genomeDir "${genome_dir}" \  #SAMEASmulti-hit-mode
#     --readFilesIn "${read_1}" "${read_2}" \  #SAMEASmulti-hit-mode
#     --outFileNamePrefix "${prefix}" \  #SAMEASmulti-hit-mode
#     --limitBAMsortRAM 4000000000 \  #SAMEASmulti-hit-mode
#     --outFilterMultimapNmax 1 \  #DIFFERENTmulti-hit-mode
#     --alignSJoverhangMin 8 \  #SAMEASmulti-hit-mode
#     --alignSJDBoverhangMin 1 \  #SAMEASmulti-hit-mode
#     --outFilterMismatchNmax 999 \  #SAMEASmulti-hit-mode
#     --alignIntronMin 4 \  #SAMEASmulti-hit-mode
#     --alignIntronMax 5000 \  #SAMEASmulti-hit-mode
#     --alignMatesGapMax 5000  #SAMEASmulti-hit-mode

#  Updated call (results/2022-1201/)
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped None \
    --outSAMattributes All \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1 \
    --winAnchorMultimapNmax 50 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --alignEndsType Local \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
#  19 lines
```

- `--alignEndsType` is not specified; thus, it's set to its default value of "Local"
- `--winAnchorMultimapNmax` is not specified; thus, it's set to its default value of "Local"

```bash
#  How is the updated call different from 'Updated call (results/2022-1201/)'?
# STAR \
#     --runMode alignReads \  #SAMEASmulti-hit-mode
#     --runThreadN "${SLURM_CPUS_ON_NODE}" \  #SAMEASmulti-hit-mode
#     --outSAMtype BAM SortedByCoordinate \  #SAMEASmulti-hit-mode
#     --outSAMunmapped None \  #SAMEASmulti-hit-mode
#     --outSAMattributes All \  #SAMEASmulti-hit-mode
#     --genomeDir "${genome_dir}" \  #SAMEASmulti-hit-mode
#     --readFilesIn "${read_1}" "${read_2}" \  #SAMEASmulti-hit-mode
#     --outFileNamePrefix "${prefix}" \  #SAMEASmulti-hit-mode
#     --limitBAMsortRAM 4000000000 \  #SAMEASmulti-hit-mode
#     --outFilterMultimapNmax 1 \    #SAMEASmulti-hit-mode (in some of the iterations)
#     --winAnchorMultimapNmax 50 \  #DIFFERENTmulti-hit-mode (but should be OK to increase to 1000 based on docs)
#     --alignSJoverhangMin 8 \  #SAMEASmulti-hit-mode
#     --alignSJDBoverhangMin 1 \  #SAMEASmulti-hit-mode
#     --outFilterMismatchNmax 999 \  #SAMEASmulti-hit-mode
#     --alignEndsType Local \  #DIFFERENTmulti-hit-mode
#     --alignIntronMin 4 \  #SAMEASmulti-hit-mode
#     --alignIntronMax 5000 \  #SAMEASmulti-hit-mode
#     --alignMatesGapMax 5000  #SAMEASmulti-hit-mode
```
Ultimately, for `results/2022-1201/` `rna-star` mode, the only difference is the absence of `--outMultimapperOrder Random` and the use of `--alignEndsType Local`

When `--outFilterMultimapNmax 1`, `--outMultimapperOrder Random` can be used without consequence

Thus, the only difference between the two is `Local` (which does soft-clipping) and `EndToEnd` alignment
<br />
<br />


## Smoking out a *bug*: Additional comparisons
Somehow, I am getting the following warnings in the `Log.out` files with today's run:  
`WARNING: not enough space allocated for transcript. Did not process all windows for read`
```bash
#  Today, in results/2022-1201/
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped None \
    --outSAMattributes All \
    --genomeDir "${genome_dir}" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1000 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000

#  In results/2022-1101/
STAR \
    --runMode alignReads \
    --runThreadN "${SLURM_CPUS_ON_NODE}" \
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes All \
    --genomeDir "/home/kalavatt/genomes/combined_SC_KL_20S/STAR" \
    --readFilesIn "${read_1}" "${read_2}" \
    --outFileNamePrefix "${prefix}" \
    --limitBAMsortRAM 4000000000 \
    --outFilterMultimapNmax 1000 \
    --winAnchorMultimapNmax 1000 \
    --alignSJoverhangMin 8 \
    --alignSJDBoverhangMin 1 \
    --outFilterMismatchNmax 999 \
    --outMultimapperOrder Random \
    --alignEndsType EndToEnd \
    --alignIntronMin 4 \
    --alignIntronMax 5000 \
    --alignMatesGapMax 5000
```
The two calls are almost exactly the same, yet somehow I am getting the warnings in the `Log.out` files...

```bash
#  2022-1201: ##### Command Line:
STAR --runMode alignReads --runThreadN 8 --outSAMtype BAM SortedByCoordinate --outSAMunmapped None --outSAMattributes All --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR --readFilesIn ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq --outFileNamePrefix ./files_unprocessed/bam/5781_G1_IN_merged.un_multi-hit-mode_1000/5781_G1_IN_merged.un_multi-hit-mode_1000 --limitBAMsortRAM 4000000000 --outFilterMultimapNmax 1000 --winAnchorMultimapNmax 1000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outMultimapperOrder Random --alignEndsType EndToEnd --alignIntronMin 4 --alignIntronMax 5000 --alignMatesGapMax 5000

#  2022-1101: ##### Command Line:
STAR --runMode alignReads --runThreadN 8 --outSAMtype BAM SortedByCoordinate --outSAMunmapped Within --outSAMattributes All --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR --readFilesIn ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq --outFileNamePrefix ./exp_alignment_STAR_tags/multi-hit-mode/files_bams/5781_G1_IN_merged --limitBAMsortRAM 4000000000 --outFilterMultimapNmax 1000 --winAnchorMultimapNmax 1000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outMultimapperOrder Random --alignEndsType EndToEnd --alignIntronMin 4 --alignIntronMax 5000 --alignMatesGapMax 5000


#  2022-1201: ##### Final effective command line:
STAR   --runMode alignReads      --runThreadN 8   --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR   --readFilesIn ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq   ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq      --limitBAMsortRAM 4000000000   --outFileNamePrefix ./files_unprocessed/bam/5781_G1_IN_merged.un_multi-hit-mode_1000/5781_G1_IN_merged.un_multi-hit-mode_1000   --outMultimapperOrder Random   --outSAMtype BAM   SortedByCoordinate      --outSAMattributes All      --outSAMunmapped None      --outFilterMultimapNmax 1000   --outFilterMismatchNmax 999   --winAnchorMultimapNmax 1000   --alignIntronMin 4   --alignIntronMax 5000   --alignMatesGapMax 5000   --alignSJoverhangMin 8   --alignSJDBoverhangMin 1   --alignEndsType EndToEnd

#  2022-1101: ##### Final effective command line:
STAR   --runMode alignReads      --runThreadN 8   --genomeDir /home/kalavatt/genomes/combined_SC_KL_20S/STAR   --readFilesIn ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq   ./files_fastq_symlinks/5781_G1_IN_merged_R2.fastq      --limitBAMsortRAM 4000000000   --outFileNamePrefix ./exp_alignment_STAR_tags/multi-hit-mode/files_bams/5781_G1_IN_merged   --outMultimapperOrder Random   --outSAMtype BAM   SortedByCoordinate      --outSAMattributes All      --outSAMunmapped Within      --outFilterMultimapNmax 1000   --outFilterMismatchNmax 999   --winAnchorMultimapNmax 1000   --alignIntronMin 4   --alignIntronMax 5000   --alignMatesGapMax 5000   --alignSJoverhangMin 8   --alignSJDBoverhangMin 1   --alignEndsType EndToEnd
```

The error is with `--readFilesIn ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq   ./files_fastq_symlinks/5781_G1_IN_merged_R1.fastq`: I was using `*_R1.fastq` for each pair!
