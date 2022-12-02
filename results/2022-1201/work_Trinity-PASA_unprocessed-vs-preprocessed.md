
# `work_Trinity-PASA_unprocessed-vs-preprocessed.md`


## ... (2022-1201-1202)
### Set up and cd into the directory for these experiments, `2022-1201/`
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

transcriptome

#  Coming from the previous results/ directory, 2022-1101/ to establish this
#+ new one: 2022-1201/
pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction

if [[ -d ./results/2022-1201 ]]; then
    cd ./results/2022-1201/
else
    cd .. \
        && mkdir -p ./results/2022-1201/ \
        && cd ./results/2022-1201/
fi

pwd
# /home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2022-1201
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
d_N_unproc="${d_November}/exp_alignment_STAR_tags"
d_N_unproc_multi="${d_N_unproc}/multi-hit-mode/files_bams"
# ., "${d_N_unproc_multi}"

d_unproc="${d_December}/data/bams/unprocessed"
d_D_unproc_multi="${d_unproc}/multi-hit-mode"
# ., "${d_D_unproc_multi}"

ln -s \
	"${d_N_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam" \
	"${d_D_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_N_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_D_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_D_unproc_multi}"


# -------------------------------------
#  Bam: preprocessed, multi-hit-mode --
# -------------------------------------
d_N_prepro="${d_November}/exp_preprocessing"
d_N_prepro_multi="${d_N_prepro}/04b_star-genome-guided"
# ., "${d_N_prepro_multi}"

d_D_prero="${d_December}/data/bams/preprocessed"
d_D_prepro_multi="${d_D_prero}/multi-hit-mode"
# ., "${d_D_prepro_multi}"

ln -s \
	"${d_N_prepro_multi}/5781_Q_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.sc_all.bam" \
	"${d_D_prepro_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam"

ln -s \
	"${d_N_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai" \
	"${d_D_unproc_multi}/5781_G1_IN_mergedAligned.sortedByCoord.out.exclude-unmapped.SC_all.bam.bai"
# ., "${d_D_prepro_multi}"


# -------------------------------------
#  Bam: unprocessed, rna-star --------- ### Not going to use these files ###
# -------------------------------------
d_rna="${d_N_unproc}/rna-star/files_bams"
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

`#NOTE` `#IMPORTANT` Somehow this missed my observations until now: for the `exp_alignment_STAR_tags/` experiments, I used `*_G1_*.fastq.gz`, and not `*_Q_*.fastq.gz` files...

Let's take alignment anew, from the beginning...