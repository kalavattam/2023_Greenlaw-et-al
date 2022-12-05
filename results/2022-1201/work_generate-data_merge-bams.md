
# `work_generate-data_merge-bams.md`

## Run `grabnode` and get to the working directory
```bash
#!/bin/bash
#DONTRUN

grabnode  # Lowest and default settings

Trinity_env

#  Go to the main working directory
mwd() {
    transcriptome \
        && cd "./results/2022-1201" \
        || echo "cd'ing failed; check on this"
}


mwd
```

## Make and populate directories for merged `.bam`s
```bash
#!/bin/bash
#DONTRUN

mkdir -p files_unprocessed/bam_split_merge/{Local,EndToEnd}
mkdir -p files_processed/bam_trim_split_merge/{Local,EndToEnd}
mkdir -p files_processed-full/bam_trim-rcor-cor_split_merge/{Local,EndToEnd}
```
### Work with `files_unprocessed/`
```bash
#!/bin/bash
#DONTRUN

cd ./files_unprocessed

unset bams_5781
typeset -a bams_5781
while IFS=" " read -r -d $'\0'; do
    bams_5781+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5781*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
echoTest "${bams_5781[@]}"

unset bams_5782
typeset -a bams_5782
while IFS=" " read -r -d $'\0'; do
    bams_5782+=( "${REPLY}" )
done < <(\
    find . \
        -type f \
        -name "5782*.Aligned.sortedByCoord.out.sc_all.bam" \
        -print0 \
            | sort -z \
)
echoTest "${bams_5782[@]}"

unset bams_replicates
typeset -A bams_replicates
for i in $(seq 0 31); do
	# echo "${i}"
	bams_replicates[${bams_5781[i]}]=${bams_5782[i]}
done

#  Keys
for i in "${!bams_replicates[@]}"; do
	echo "${i}"
done

#  Values
for i in "${bams_replicates[@]}"; do
	echo "${i}"
done

# stackoverflow.com/questions/25748776/how-to-access-associative-arrays-in-bash
for i in ${!bams_replicates[$i]}; do
	echo "  Key: "
	echo "Value: ${bams_replicates[$i]}"
	echo ""
done


```