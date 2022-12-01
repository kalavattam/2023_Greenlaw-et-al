
# `work_Trinity-PASA_unprocessed-vs-preprocessed.md`


## ...
### Set up and cd into the directory for these experiments, `2022-1201/`
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

#  Coming from the previous results/ directory, 2022-1101/ to establish this
#+ new one: 2022-1201/
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101

cd .. \
	&& mkdir -p 2022-1201/ \
	&& cd 2022-1201/
```

### Symlink or copy the files from `2022-1101/` necessary for running `Trinity`
```bash
#!/bin/bash
#DONTRUN #CONTINUE

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201

#  Set up directories necessary for experiments (can trim this later)
mkdir -p data/{fastqs,bams}/{unprocessed,preprocessed}/{multi-hit-mode,rna-star}


#  Set up symlinks ------------------------------------------------------------
d_base="${HOME}/tsukiyamalab/kalavatt"
d_November="${d_base}/2022_transcriptome-construction/results/2022-1101"
d_December="${d_base}/2022_transcriptome-construction/results/2022-1201"

# -------------------------------------
#  Bam: unprocessed, multi-hit-mode ---
# -------------------------------------
d_STAR="${d_November}/exp_alignment_STAR_tags"
d_multi="${d_STAR}/multi-hit-mode/files_bams"
# ., "${d_multi}"

d_unproc="${d_December}/data/bams/unprocessed"
d_unproc_multi="${d_unproc}/multi-hit-mode"
# ., "${d_unproc_multi}"

ln -s \
	"${d_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam" \
	"${d_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_unproc_multi}"

# -------------------------------------
#  Bam: preprocessed, multi-hit-mode --
# -------------------------------------
d_N_prepro="${d_November}/exp_preprocessing"
d_N_prepro_multi="${d_N_prepro}/04b_star-genome-guided"
# ., "${d_N_prepro_multi}"

d_D_prero="${d_December}/data/bams/preprocessed"
d_D_prepro_multi="${d_D_prero}/multi-hit-mode"
# ., "${d_D_prepro_multi}"
```

- Observations, etc.
	- In `"${d_N_prepro_multi}"`, I can find only files with extension `*.out.sc_all.bam`, not `*.out.exclude-unmapped.sc_all.bam` as expected
	- Also, strangely, I gave files in which unmapped reads were excluded the extension `*.out.unmapped.bam`, which is very confusing: With this name, one would expect that the files are exclusively composed of unmapped reads, not alignments in which unmapped reads have been excluded
	- Thus, I am expecting to find files with the extension `*.out.unmapped.sc_all.bam`; but, as I mentioned, I see only files with this extension: `*.out.sc_all.bam`

- Question
	- `#QUESTION` `#IMPORTANT` Are unmapped reads excluded from this file?
	- `#ANSWER` Unfortunately, it seems that the answer is no, so I need to go back to the `2022-1101/` notebook, update the relevant code, and then rerun things...

- Addressing the above
	- `#DONE` It seems I made the error at line `4936`: `-name *out.bam`; change this to `-name *out.exclude-unmapped.bam`
	- `#TODO` Go back to [this spot](../2022-1101/scraps.md#set-up-the-star-alignment-steps-and-sub-steps-2022-1126) to start the above work
	- `#TODO` While we're at it, change the extension for `.bam`s in which unmapped reads have been excluded from `*.out.unmapped.bam` to `*.out.exclude-unmapped.bam`; importantly, change `"$(basename "${i}" ".bam").unmapped.bam"` to `"$(basename "${i}" ".bam").exclude-unmapped.bam"`; then rerun these lines of code~~; then delete the previous `*.out.unmapped.bam` files~~ 
		+ `#DONE` Regarding files for genome-free `Trinity`, change lines `4606`, `4611`, and `4624`
		+ `#DONE` Regarding files for genome-free `Trinity`, change lines `4822`, `4825`, and `4838`
	- `#TODO` Also, there are no `.bam` indices for `sc_all` `.bam`s in `"${d_N_prepro}/04b_star-genome-guided"`, so I need to run that here...

`#TODO #ENDOFDAY` Continue to address the issues, then run `Trinity`, then run `PASA`

<details>
<summary><i>Accomplishing the third TODO above, bullet 1</i></summary>

```bash
#!/bin/bash
#DONTRUN

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_preprocessing/04a_star-genome-free"

ls -lhaFG
# total 8.6G
# drwxrws---  4 kalavatt 1.6K Dec  1 13:22 ./
# drwxrws--- 13 kalavatt  13K Dec  1 13:22 ../
# -rw-rw----  1 kalavatt 1.2G Nov 26 12:23 5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  58K Nov 26 13:07 5781_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 679M Dec  1 13:23 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt 525M Nov 28 09:20 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt  40K Nov 28 12:35 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam.bai
# -rw-rw----  1 kalavatt 817M Nov 28 12:37 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.sort-n.bam
# -rw-rw----  1 kalavatt 687M Nov 26 13:34 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  56K Nov 26 13:37 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt 2.0K Nov 26 12:23 5781_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.2K Nov 26 12:23 5781_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  364 Nov 26 12:23 5781_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  36K Nov 26 12:22 5781_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 12:23 5781_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt 920M Nov 26 12:22 5782_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  60K Nov 26 13:07 5782_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 518M Dec  1 13:23 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt 435M Nov 28 09:20 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt  38K Nov 28 12:35 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam.bai
# -rw-rw----  1 kalavatt 667M Nov 28 12:37 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.sort-n.bam
# -rw-rw----  1 kalavatt 524M Nov 26 13:33 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  56K Nov 26 13:37 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt 2.0K Nov 26 12:22 5782_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.3K Nov 26 12:22 5782_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  246 Nov 26 12:22 5782_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  31K Nov 26 12:22 5782_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 12:22 5782_Q_IN_merged_STARtmp/
```

Somehow, `*.out.exclude-unmapped.bam` are not the same size as `*.out.unmapped.bam`... Do I need to restart the pipeline from step 4 then?

```bash
#!/bin/bash
#DONTRUN #CONTINUE

samtools view -c 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam  # 20069254
samtools view -c 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam  # 20069254
samtools view -c 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam  # 14834474
samtools view -c 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam  # 14834474
```

OK, so it must be a compression thing; however, let's do one more check just to be sure...

```bash
#!/bin/bash
#DONTRUN #CONTINUE

calculate_run_time() {
    # Calculate run time for chunk of code
    #
    # :param 1: start time in $(date +%s) format
    # :param 2: end time in $(date +%s) format
    # :param 3: message to be displayed when printing the run time (chr)
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
    $(( run_time/3600 )) $(( run_time%3600/60 )) $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    # Display "spinning icon" while a background process runs
    #
    # :param 1: PID of the last program the shell ran in the background (int)
    # :param 2: message to be displayed next to the spinning icon (chr)
    spin="/|\\–"
    i=0
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    # List and tally flags in a bam infile; function acts on a bam infile to
    # perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    # list and tally flags; function writes the results to a txt outfile, the
    # name of which is derived from the txt infile
    #
    # :param 1: name of bam infile, including path (chr)
    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
            > "${1/.bam/.flags.txt}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


list_tally_flags 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
list_tally_flags 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
list_tally_flags 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
list_tally_flags 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
#  Wait for the commands to complete...

head -20 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# 6396717 99
# 6396717 147
# 3547678 83
# 3547678 163
#   57025 659
#   57025 611
#   33207 675
#   33207 595

head -20 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# 6396717 99
# 6396717 147
# 3547678 83
# 3547678 163
#   57025 659
#   57025 611
#   33207 675
#   33207 595

head -20 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# 4764058 99
# 4764058 147
# 2589346 83
# 2589346 163
#   40236 659
#   40236 611
#   23597 675
#   23597 595

head -20 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# 4764058 99
# 4764058 147
# 2589346 83
# 2589346 163
#   40236 659
#   40236 611
#   23597 675
#   23597 595
```

OK, I think it's OK; there's no need to restart the pipeline from step 4 then (or do anything more drastic)

Clean up the work you did
```bash
#!/bin/bash
#DONTRUN #CONTINUE

ls -lhaFG
# total 8.6G
# drwxrws---  4 kalavatt 1.9K Dec  1 13:44 ./
# drwxrws--- 13 kalavatt  13K Dec  1 13:22 ../
# -rw-rw----  1 kalavatt 1.2G Nov 26 12:23 5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  58K Nov 26 13:07 5781_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 679M Dec  1 13:23 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt   94 Dec  1 13:44 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw----  1 kalavatt 525M Nov 28 09:20 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt  40K Nov 28 12:35 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam.bai
# -rw-rw----  1 kalavatt 817M Nov 28 12:37 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.sort-n.bam
# -rw-rw----  1 kalavatt 687M Nov 26 13:34 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  56K Nov 26 13:37 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt   94 Dec  1 13:44 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# -rw-rw----  1 kalavatt 2.0K Nov 26 12:23 5781_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.2K Nov 26 12:23 5781_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  364 Nov 26 12:23 5781_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  36K Nov 26 12:22 5781_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 12:23 5781_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt 920M Nov 26 12:22 5782_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  60K Nov 26 13:07 5782_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 518M Dec  1 13:23 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt   94 Dec  1 13:45 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw----  1 kalavatt 435M Nov 28 09:20 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt  38K Nov 28 12:35 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam.bai
# -rw-rw----  1 kalavatt 667M Nov 28 12:37 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.sort-n.bam
# -rw-rw----  1 kalavatt 524M Nov 26 13:33 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  56K Nov 26 13:37 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt   94 Dec  1 13:44 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# -rw-rw----  1 kalavatt 2.0K Nov 26 12:22 5782_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.3K Nov 26 12:22 5782_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  246 Nov 26 12:22 5782_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  31K Nov 26 12:22 5782_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 12:22 5782_Q_IN_merged_STARtmp/

for i in *.out.unmapped.bam *.out.unmapped.bam.bai; do
	mv "${i}" "mistake.${i}"
done

for i in *.flags.txt; do
	mv "${i}" "check.${i}"
done

ls -lhaFG
# total 8.6G
# drwxrws---  4 kalavatt 2.0K Dec  1 13:59 ./
# drwxrws--- 13 kalavatt  13K Dec  1 13:22 ../
# -rw-rw----  1 kalavatt 1.2G Nov 26 12:23 5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  58K Nov 26 13:07 5781_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 679M Dec  1 13:23 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt 525M Nov 28 09:20 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt  40K Nov 28 12:35 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam.bai
# -rw-rw----  1 kalavatt 817M Nov 28 12:37 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.sort-n.bam
# -rw-rw----  1 kalavatt 2.0K Nov 26 12:23 5781_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.2K Nov 26 12:23 5781_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  364 Nov 26 12:23 5781_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  36K Nov 26 12:22 5781_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 12:23 5781_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt 920M Nov 26 12:22 5782_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  60K Nov 26 13:07 5782_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 518M Dec  1 13:23 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt 435M Nov 28 09:20 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt  38K Nov 28 12:35 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam.bai
# -rw-rw----  1 kalavatt 667M Nov 28 12:37 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.sort-n.bam
# -rw-rw----  1 kalavatt 2.0K Nov 26 12:22 5782_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.3K Nov 26 12:22 5782_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  246 Nov 26 12:22 5782_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  31K Nov 26 12:22 5782_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 12:22 5782_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt   94 Dec  1 13:44 check.5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw----  1 kalavatt   94 Dec  1 13:44 check.5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# -rw-rw----  1 kalavatt   94 Dec  1 13:45 check.5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw----  1 kalavatt   94 Dec  1 13:44 check.5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# -rw-rw----  1 kalavatt 687M Nov 26 13:34 mistake.5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  56K Nov 26 13:37 mistake.5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt 524M Nov 26 13:33 mistake.5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  56K Nov 26 13:37 mistake.5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
```
</details>
<br />

<details>
<summary><i>Accomplishing the third TODO above, bullet 2</i></summary>

```bash
#!/bin/bash
#DONTRUN

Trinity_env

cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1101/exp_preprocessing/04b_star-genome-guided"

ls -lhaFG
# total 14G
# drwx--S---  4 kalavatt 1.5K Dec  1 14:31 ./
# drwxrws--- 13 kalavatt  13K Dec  1 14:31 ../
# -rw-rw----  1 kalavatt 2.0G Nov 26 13:55 5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  69K Nov 26 14:00 5781_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 1.5G Dec  1 14:27 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt  67K Dec  1 14:31 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw----  1 kalavatt 1.2G Nov 28 09:20 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt 1.5G Nov 26 14:01 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  67K Nov 26 14:02 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt 2.0K Nov 26 13:55 5781_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.9K Nov 26 13:55 5781_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  482 Nov 26 13:55 5781_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  74K Nov 26 13:55 5781_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 13:55 5781_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt 1.5G Nov 26 13:54 5782_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  68K Nov 26 14:00 5782_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 1.2G Dec  1 14:27 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt  65K Dec  1 14:31 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw----  1 kalavatt 878M Nov 28 09:20 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt 1.2G Nov 26 14:01 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  65K Nov 26 14:02 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt 2.0K Nov 26 13:54 5782_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.9K Nov 26 13:54 5782_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  364 Nov 26 13:54 5782_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  57K Nov 26 13:54 5782_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 13:54 5782_Q_IN_merged_STARtmp/

samtools view -c 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam  # 46262694
samtools view -c 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam  # 46262694
samtools view -c 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam  # 34997128
samtools view -c 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam  # 34997128

list_tally_flags 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
list_tally_flags 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
list_tally_flags 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
list_tally_flags 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam

head -20 5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# 6750615 99
# 6750615 147
# 6619384 419
# 6619384 339
# 6211950 83
# 6211950 163
# 3334429 403
# 3334429 355
#   60710 659
#   60710 611
#   60565 931
#   60565 851
#   57959 675
#   57959 595
#   35735 915
#   35735 867

head -20 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# 6750615 99
# 6750615 147
# 6619384 419
# 6619384 339
# 6211950 83
# 6211950 163
# 3334429 403
# 3334429 355
#   60710 659
#   60710 611
#   60565 931
#   60565 851
#   57959 675
#   57959 595
#   35735 915
#   35735 867

head -20 5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# 5902629 419
# 5902629 339
# 5194111 83
# 5194111 163
# 4888963 99
# 4888963 147
# 1366662 403
# 1366662 355
#   46863 931
#   46863 851
#   44177 675
#   44177 595
#   41156 659
#   41156 611
#   14003 915
#   14003 867

head -20 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# 5902629 419
# 5902629 339
# 5194111 83
# 5194111 163
# 4888963 99
# 4888963 147
# 1366662 403
# 1366662 355
#   46863 931
#   46863 851
#   44177 675
#   44177 595
#   41156 659
#   41156 611
#   14003 915
#   14003 867

for i in *.out.unmapped.bam *.out.unmapped.bam.bai; do
	mv "${i}" "mistake.${i}"
done

for i in *.flags.txt; do
	mv "${i}" "check.${i}"
done

ls -lhaFG
# total 14G
# drwx--S---  4 kalavatt 1.9K Dec  1 14:47 ./
# drwxrws--- 13 kalavatt  13K Dec  1 14:31 ../
# -rw-rw----  1 kalavatt 2.0G Nov 26 13:55 5781_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  69K Nov 26 14:00 5781_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 1.5G Dec  1 14:27 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt  67K Dec  1 14:31 5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw----  1 kalavatt 1.2G Nov 28 09:20 5781_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt 2.0K Nov 26 13:55 5781_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.9K Nov 26 13:55 5781_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  482 Nov 26 13:55 5781_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  74K Nov 26 13:55 5781_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 13:55 5781_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt 1.5G Nov 26 13:54 5782_Q_IN_mergedAligned.sortedByCoord.out.bam
# -rw-rw----  1 kalavatt  68K Nov 26 14:00 5782_Q_IN_mergedAligned.sortedByCoord.out.bam.bai
# -rw-rw----  1 kalavatt 1.2G Dec  1 14:27 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam
# -rw-rw----  1 kalavatt  65K Dec  1 14:31 5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.bam.bai
# -rw-rw----  1 kalavatt 878M Nov 28 09:20 5782_Q_IN_mergedAligned.sortedByCoord.out.sc_all.bam
# -rw-rw----  1 kalavatt 2.0K Nov 26 13:54 5782_Q_IN_mergedLog.final.out
# -rw-rw----  1 kalavatt 8.9K Nov 26 13:54 5782_Q_IN_mergedLog.out
# -rw-rw----  1 kalavatt  364 Nov 26 13:54 5782_Q_IN_mergedLog.progress.out
# -rw-rw----  1 kalavatt  57K Nov 26 13:54 5782_Q_IN_mergedSJ.out.tab
# drwx--S---  3 kalavatt   25 Nov 26 13:54 5782_Q_IN_merged_STARtmp/
# -rw-rw----  1 kalavatt  190 Dec  1 14:39 check.5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw----  1 kalavatt  190 Dec  1 14:38 check.5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# -rw-rw----  1 kalavatt  190 Dec  1 14:41 check.5782_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.flags.txt
# -rw-rw----  1 kalavatt  190 Dec  1 14:40 check.5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.flags.txt
# -rw-rw----  1 kalavatt 1.5G Nov 26 14:01 mistake.5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  67K Nov 26 14:02 mistake.5781_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
# -rw-rw----  1 kalavatt 1.2G Nov 26 14:01 mistake.5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam
# -rw-rw----  1 kalavatt  65K Nov 26 14:02 mistake.5782_Q_IN_mergedAligned.sortedByCoord.out.unmapped.bam.bai
```
</details>
<br />

`#TOBECONTINUED` After addressing the above
```bash
ln -s \
	"${d_N_prepro_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam" \
	"${d_D_prepro_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"

# -------------------------------------
#  Bam: unprocessed, rna-star --------- ### Not going to use these files ###
# -------------------------------------
d_rna="${d_STAR}/rna-star/files_bams"
# ., "${d_rna}"

d_unproc_rna="${d_unproc}/rna-star"
# ., "${d_unproc_rna}"

ln -s \
	"${d_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam" \
	"${d_unproc_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_unproc_rna}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_unproc_rna}"

# -------------------------------------
#  Bam: preprocessed, rna-star -------- ### These files do not exist ###
# -------------------------------------
# d_prero_rna=


```

