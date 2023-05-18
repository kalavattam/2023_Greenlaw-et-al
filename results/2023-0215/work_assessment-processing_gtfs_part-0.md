
`#work_assessment-processing_gtfs.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [0. Get situated](#0-get-situated)
    1. [Code](#code)
1. [0. Copy in files of interest](#0-copy-in-files-of-interest)
    1. [Code](#code-1)
1. [0. Make associated storage directories](#0-make-associated-storage-directories)
    1. [Code](#code-2)
1. [0. Create arrays of relevant `gff3` and `bam` files](#0-create-arrays-of-relevant-gff3-and-bam-files)
    1. [Code](#code-3)
1. [1. Run GffRead](#1-run-gffread)
    1. [Code](#code-4)
1. [2. Run `htseq-count`](#2-run-htseq-count)
    1. [Run `htseq-count` on bams in `bams_renamed/`](#run-htseq-count-on-bams-in-bams_renamed)
        1. [Call `htseq-count` with respect to `--type` locus, mRNA, exon, and CDS](#call-htseq-count-with-respect-to---type-locus-mrna-exon-and-cds)
            1. [Code](#code-5)
        1. [Call `htseq-count` with respect to the intron-filtering-only `gffread` files](#call-htseq-count-with-respect-to-the-intron-filtering-only-gffread-files)
            1. [Code](#code-6)
1. [2.5. Correct tsv outfiles with formatting errors](#25-correct-tsv-outfiles-with-formatting-errors)
    1. [Notes](#notes)
    1. [Code](#code-7)
1. [Next step](#next-step)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="0-get-situated"></a>
## 0. Get situated
<a id="code"></a>
### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

# tmux new -s gff3
# tmux attach -t gff3
grabnode  # 1, defaults

run=TRUE
# run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        transcriptome && 
            {
                cd "results/2023-0215" \
                    || echo "cd'ing failed; check on this..."
            }

        if [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then 
            conda deactivate
        fi
        source activate gff3_env
    }
```
</details>
<br />
<br />

<a id="0-copy-in-files-of-interest"></a>
## 0. Copy in files of interest
<a id="code-1"></a>
### Code
<details>
<summary><i>Code: Copy in files of interest</i></summary>

```bash
#!/bin/bash

# run=TRUE  # Only need to run the first time
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        #  Already ----------------------------
        p_gen="${HOME}/genomes"
        p_gtf="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3/already"

        if [[ ! -d "${p_gtf}" ]]; then mkdir -p "${p_gtf}"; fi

        #  Check that files exist with the given paths
        ., "${p_gen}/combined_AG/gtf/combined_AG.gtf"
        ., "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL_20S.gff3"
        ., "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"
        ., "${p_gen}/kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3"
        ., "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf"
        ., "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"

        #  Copy in necessary files
        if [[ ! -f "${p_gtf}/combined_AG.gtf" ]]; then
            cp \
                "${p_gen}/combined_AG/gtf/combined_AG.gtf" \
                "${p_gtf}/combined_AG.gtf"
        fi

        if [[ ! -f "${p_gtf}/combined_SC_KL_20S.gff3" ]]; then
            cp \
                "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL_20S.gff3" \
                "${p_gtf}/combined_SC_KL_20S.gff3"
        fi

        if [[ ! -f "${p_gtf}/combined_SC_KL.gff3" ]]; then
            cp \
                "${p_gen}/combined_SC_KL_20S/gff3/combined_SC_KL.gff3" \
                "${p_gtf}/combined_SC_KL.gff3"
        fi

        if [[ ! -f "${p_gtf}/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3" ]]; then
            cp \
                "${p_gen}/kluyveromyces_lactis_gca_000002515/Ensembl/55/gff3/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3" \
                "${p_gtf}/Kluyveromyces_lactis_gca_000002515.ASM251v1.55.gff3"
        fi

        if [[ ! -f "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.gtf" ]]; then
            cp \
                "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.gtf" \
                "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.gtf"
        fi

        if [[ ! -f "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" ]]; then
            cp \
                "${p_gen}/sacCer3/Ensembl/108/gtf/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf" \
                "${p_gtf}/Saccharomyces_cerevisiae.R64-1-1.108.plus-chr-rename.gtf"
        fi


        #  Trinity-GG -------------------------
        p_trinity="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0111/outfiles_GMAP_rough-draft/Trinity-GG"
        p_gtf="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/infiles_gtf-gff3"

        if [[ ! -d "${p_gtf}/Trinity-GG" ]]; then
            echo " No \${p_gtf}/Trinity-GG... Copying it in now"
            cp -r "${p_trinity}" "${p_gtf}"
        fi
    }
```
</details>
<br />
<br />

<a id="0-make-associated-storage-directories"></a>
## 0. Make associated storage directories
<a id="code-2"></a>
### Code
<details>
<summary><i>Code: Make associated storage directories</i></summary>

```bash
#!/bin/bash

# run=TRUE  # Only need to run the first time
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        mkdir -p outfiles_gtf-gff3/{already,Trinity-GG}
        mkdir -p outfiles_gtf-gff3/Trinity-GG/{G_N,Q_N}/err_out

        mkdir -p outfiles_htseq-count/{already,Trinity-GG}
        mkdir -p outfiles_htseq-count/Trinity-GG/{G_N,Q_N}/{sh,list,err_out}
    }
```
</details>
<br />
<br />

<a id="0-create-arrays-of-relevant-gff3-and-bam-files"></a>
## 0. Create arrays of relevant `gff3` and `bam` files
<a id="code-3"></a>
### Code
<details>
<summary><i>Code: Create arrays of relevant gff3 and bam files</i></summary>

```bash
#!/bin/bash

run=TRUE
# run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        unset stems
        typeset -a stems
        while IFS=" " read -r -d $'\0'; do
            stems+=( "${REPLY%.gff3}" )
        done < <(\
            find "infiles_gtf-gff3" \
                -type f \
                -name "trinity*.gff3" \
                -print0 \
                    | sort -z\
        )
        echo_test "${stems[@]}"
        echo "${#stems[@]}" && echo ""  # 12

        unset bams
        typeset -a bams
        while IFS=" " read -r -d $'\0'; do
            bams+=( "${REPLY}" )
        done < <(\
            find "bams_renamed/UT_prim_UMI" \
                -type l \
                -name "*ovn*bam" \
                -print0 \
                    | sort -z \
        )
        echo_test "${bams[@]}"
        echo "${#bams[@]}" && echo ""  # 8
    }
```
</details>
<br />
<br />

<a id="1-run-gffread"></a>
## 1. Run GffRead
<a id="code-4"></a>
### Code
<details>
<summary><i>Code: Run GffRead</i></summary>

```bash
#!/bin/bash

#  Echo test of GffRead -------------------------------------------------------
run=TRUE
# run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        h=0
        for i in "${stems[@]}"; do
            # i="${stems[10]}"  # echo "${i}"
            in="${i}.gff3"  # echo "${in}"
            out="$(echo "${i}" | sed 's/infiles/outfiles/g;s/\\.gff3//g' -).gffread.gff3"  # echo "${out}"
            err_out="$(dirname "${out}")/err_out/02-gffread.$(basename "${out}" .gff3)"  # echo "${err_out}"
            fasta_g="${HOME}/genomes/combined_SC_KL_20S/fasta/fasta_individual/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"  # ., "${fasta_g}"
            
            let h++
            echo "    #  ==============================================="
            printf "    Iteration '%d'\n\n" "${h}"

            echo """
            ---------------
            Running gffread
            ---------------
                        in  ${in}
                out (base)  ${out}
                    stdout  ${err_out}.stdout.txt
                    stderr  ${err_out}.stderr.txt
            
            ---------------------
            Call to gffread: Base
            ---------------------
            gffread \\
                -v \\
                -g ${fasta} \\
                -i 1000 \\
                -Z \\
                -M -K -Q \\
                -F -N -P \\
                --force-exons --gene2exon \\
                -o ${out} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}.stdout.txt) \\
                    2> >(tee -a ${err_out%.}.stderr.txt)

            --------------------------------------
            Call to gffread: Intron-filtering only
            --------------------------------------
            gffread \\
                -v -O \\
                -i 1000 \\
                -o ${out/.gff3/-intron-filtering-only.gff3} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}-intron-filtering-only.stdout.txt) \\
                    2> >(tee -a ${err_out%.}-intron-filtering-only.stderr.txt)

            ----------------------------
            Call to gffread: Coding only
            ----------------------------
            gffread \\
                -v \\
                -g ${fasta} \\
                -C -i 1000 \\
                -Z \\
                -M -K -Q \\
                -F -N -P \\
                --force-exons --gene2exon \\
                -o ${out/.gff3/-coding.gff3} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}-coding.stdout.txt) \\
                    2> >(tee -a ${err_out%.}-coding.stderr.txt)
            
            --------------------------------
            Call to gffread: Non-coding only
            --------------------------------
            gffread \\
                -v \\
                -g ${fasta} \\
                --nc -i 1000 \\
                -Z \\
                -M -K -Q \\
                -F -N -P \\
                --force-exons --gene2exon \\
                -o ${out/.gff3/-non-coding.gff3} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}-non-coding.stdout.txt) \\
                    2> >(tee -a ${err_out%.}-non-coding.stderr.txt)
            
            """
        done
    }


#  Running GffRead ------------------------------------------------------------
# run=TRUE
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        h=0
        for i in "${stems[@]}"; do
            # i="${stems[10]}"  # echo "${i}"
            in="${i}.gff3"  # echo "${in}"
            out="$(echo "${i}" | sed 's/infiles/outfiles/g;s/\\.gff3//g' -).gffread.gff3"  # echo "${out}"
            err_out="$(dirname "${out}")/err_out/02-gffread.$(basename "${out}" .gff3)"  # echo "${err_out}"
            fasta_g="${HOME}/genomes/combined_SC_KL_20S/fasta/fasta_individual/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.chr-rename.fasta"  # ., "${fasta_g}"
            
            let h++
            echo "    #  ==============================================="
            printf "    Iteration '%d'\n\n" "${h}"

            echo """
            ---------------
            Running gffread
            ---------------
                        in  ${in}
                out (base)  ${out}
                    stdout  ${err_out}.stdout.txt
                    stderr  ${err_out}.stderr.txt
            
            ---------------------
            Call to gffread: Base
            ---------------------
            gffread \\
                -v \\
                -g ${fasta} \\
                -i 1000 \\
                -Z \\
                -M -K -Q \\
                -F -N -P \\
                --force-exons --gene2exon \\
                -o ${out} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}.stdout.txt) \\
                    2> >(tee -a ${err_out%.}.stderr.txt)

            --------------------------------------
            Call to gffread: Intron-filtering only
            --------------------------------------
            gffread \\
                -v -O \\
                -i 1000 \\
                -o ${out/.gff3/-intron-filtering-only.gff3} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}-intron-filtering-only.stdout.txt) \\
                    2> >(tee -a ${err_out%.}-intron-filtering-only.stderr.txt)

            ----------------------------
            Call to gffread: Coding only
            ----------------------------
            gffread \\
                -v \\
                -g ${fasta} \\
                -C -i 1000 \\
                -Z \\
                -M -K -Q \\
                -F -N -P \\
                --force-exons --gene2exon \\
                -o ${out/.gff3/-coding.gff3} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}-coding.stdout.txt) \\
                    2> >(tee -a ${err_out%.}-coding.stderr.txt)
            
            --------------------------------
            Call to gffread: Non-coding only
            --------------------------------
            gffread \\
                -v \\
                -g ${fasta} \\
                --nc -i 1000 \\
                -Z \\
                -M -K -Q \\
                -F -N -P \\
                --force-exons --gene2exon \\
                -o ${out/.gff3/-non-coding.gff3} \\
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, \"\", \$1); gsub(/M/, \"Mito\", \$1); print }' "${in}") \\
                     > >(tee -a ${err_out%.}-non-coding.stdout.txt) \\
                    2> >(tee -a ${err_out%.}-non-coding.stderr.txt)
            
            """

            #  Base
            gffread \
                -v \
                -g "${fasta_g}" \
                -i 1000 \
                -Z \
                -M -K -Q \
                -F -N -P \
                --force-exons --gene2exon \
                -o "${out}" \
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, "", $1); gsub(/M/, "Mito", $1); print }' "${in}") \
                     > >(tee -a "${err_out%.}.stdout.txt") \
                    2> >(tee -a "${err_out%.}.stderr.txt")

            #  Intron-filtering only
            gffread \
                -v -O \
                -i 1000 \
                -o "${out/.gff3/-intron-filtering-only.gff3}" \
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, "", $1); gsub(/M/, "Mito", $1); print }' "${in}") \
                     > >(tee -a "${err_out%.}-intron-filtering-only.stdout.txt") \
                    2> >(tee -a "${err_out%.}-intron-filtering-only.stderr.txt")

            #  Coding only
            gffread \
                -v \
                -g "${fasta_g}" \
                -C -i 1000 \
                -Z \
                -M -K -Q \
                -F -N -P \
                --force-exons --gene2exon \
                -o "${out/.gff3/-coding.gff3}" \
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, "", $1); gsub(/M/, "Mito", $1); print }' "${in}") \
                     > >(tee -a "${err_out%.}-coding.stdout.txt") \
                    2> >(tee -a "${err_out%.}-coding.stderr.txt")
            
            #  Non-coding only
            gffread \
                -v \
                -g "${fasta_g}" \
                --nc -i 1000 \
                -Z \
                -M -K -Q \
                -F -N -P \
                --force-exons --gene2exon \
                -o "${out/.gff3/-non-coding.gff3}" \
                <(awk -F '\t' 'BEGIN {OFS = FS} { gsub(/chr/, "", $1); gsub(/M/, "Mito", $1); print }' "${in}") \
                     > >(tee -a "${err_out%.}-non-coding.stdout.txt") \
                    2> >(tee -a "${err_out%.}-non-coding.stderr.txt")
        done
    }
# find ./outfiles_gtf-gff3 -type f -name "*gffread*" -delete
# find ./outfiles_gtf-gff3 -type f -name "*intron-filtering-only*" -delete
```
</details>
<br />
<br />

<a id="2-run-htseq-count"></a>
## 2. Run `htseq-count`
<a id="run-htseq-count-on-bams-in-bams_renamed"></a>
### Run `htseq-count` on bams in `bams_renamed/`
<a id="call-htseq-count-with-respect-to---type-locus-mrna-exon-and-cds"></a>
#### Call `htseq-count` with respect to `--type` locus, mRNA, exon, and CDS
*...from "base" calls to `gffread`*

<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Call htseq-count with respect to --type locus, mRNA, exon, and CDS</i></summary>

```bash
#!/bin/bash

#  Echo tests for calls to htseq-count ----------------------------------------
run=TRUE
# run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        h=0
        for i in "strd-eq"; do
            for j in "${stems[@]}"; do
                # i="strd-eq"  # echo "${i}"
                # j="${stems[7]}"  # echo "${j}"
                in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffread.gff3"  # ., "${in}" # less "${in}" # Approach #2
                out="$(echo "${j}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).hc-${i}.tsv"  # echo "${out}"
                err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                if [[ "${i}" == "strd-eq" ]]; then
                    hc_strd="yes"
                elif [[ "${i}" == "strd-rv" ]]; then
                    hc_strd="reverse"
                fi

                let h++
                echo "    #  ==============================================="
                printf "    Iteration '%d'\n\n" "${h}"

                echo """
                --------------------------
                Call to htseq-count: locus
                --------------------------
                sbatch \\
                    --job-name=\"htseq-count-locus\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-locus.%A.stderr.txt\" \\
                    --output=\"${err_out}-locus.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"locus\" \\
                        --idattr \"ID\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-locus.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                -------------------------
                Call to htseq-count: mRNA
                -------------------------
                sbatch \\
                    --job-name=\"htseq-count-mRNA\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-mRNA.%A.stderr.txt\" \\
                    --output=\"${err_out}-mRNA.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"mRNA\" \\
                        --idattr \"ID\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-mRNA.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                -------------------------
                Call to htseq-count: exon
                -------------------------
                sbatch \\
                    --job-name=\"htseq-count-exon\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-exon.%A.stderr.txt\" \\
                    --output=\"${err_out}-exon.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"exon\" \\
                        --idattr \"Parent\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-exon.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                ------------------------
                Call to htseq-count: CDS
                ------------------------
                sbatch \\
                    --job-name=\"htseq-count-CDS\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-CDS.%A.stderr.txt\" \\
                    --output=\"${err_out}-CDS.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"CDS\" \\
                        --idattr \"Parent\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-CDS.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"
                
                """
            done
        done
    }


#  Calls to htseq-count -------------------------------------------------------
# run=TRUE
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        h=0
        for i in "strd-eq"; do
            for j in "${stems[@]}"; do
                # i="strd-eq"  # echo "${i}"
                # j="${stems[7]}"  # echo "${j}"
                in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffread.gff3"  # ., "${in}" # less "${in}" # Approach #2
                out="$(echo "${j}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).hc-${i}.tsv"  # echo "${out}"
                err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                if [[ "${i}" == "strd-eq" ]]; then
                    hc_strd="yes"
                elif [[ "${i}" == "strd-rv" ]]; then
                    hc_strd="reverse"
                fi

                let h++
                echo "    #  ==============================================="
                printf "    Iteration '%d'\n\n" "${h}"

                echo """
                --------------------------
                Call to htseq-count: locus
                --------------------------
                sbatch \\
                    --job-name=\"htseq-count-locus\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-locus.%A.stderr.txt\" \\
                    --output=\"${err_out}-locus.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"locus\" \\
                        --idattr \"ID\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-locus.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                -------------------------
                Call to htseq-count: mRNA
                -------------------------
                sbatch \\
                    --job-name=\"htseq-count-mRNA\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-mRNA.%A.stderr.txt\" \\
                    --output=\"${err_out}-mRNA.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"mRNA\" \\
                        --idattr \"ID\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-mRNA.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                -------------------------
                Call to htseq-count: exon
                -------------------------
                sbatch \\
                    --job-name=\"htseq-count-exon\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-exon.%A.stderr.txt\" \\
                    --output=\"${err_out}-exon.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"exon\" \\
                        --idattr \"Parent\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-exon.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                ------------------------
                Call to htseq-count: CDS
                ------------------------
                sbatch \\
                    --job-name=\"htseq-count-CDS\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-CDS.%A.stderr.txt\" \\
                    --output=\"${err_out}-CDS.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"CDS\" \\
                        --idattr \"Parent\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-CDS.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"
                
                """
                
                sbatch \
                    --job-name="htseq-count-locus" \
                    --nodes=1 \
                    --cpus-per-task=8 \
                    --error="${err_out}-locus.%A.stderr.txt" \
                    --output="${err_out}-locus.%A.stdout.txt" \
                    htseq-count \
                        --order "pos" \
                        --stranded "${hc_strd}" \
                        --nonunique "all" \
                        --type "locus" \
                        --idattr "ID" \
                        --nprocesses 8 \
                        --counts_output "${out/.tsv/-locus.tsv}" \
                        --with-header \
                        ${bams[*]} \
                        "${in}"
                sleep 0.33
                
                sbatch \
                    --job-name="htseq-count-mRNA" \
                    --nodes=1 \
                    --cpus-per-task=8 \
                    --error="${err_out}-mRNA.%A.stderr.txt" \
                    --output="${err_out}-mRNA.%A.stdout.txt" \
                    htseq-count \
                        --order "pos" \
                        --stranded "${hc_strd}" \
                        --nonunique "all" \
                        --type "mRNA" \
                        --idattr "ID" \
                        --nprocesses 8 \
                        --counts_output "${out/.tsv/-mRNA.tsv}" \
                        --with-header \
                        ${bams[*]} \
                        "${in}"
                sleep 0.33

                sbatch \
                    --job-name="htseq-count-exon" \
                    --nodes=1 \
                    --cpus-per-task=8 \
                    --error="${err_out}-exon.%A.stderr.txt" \
                    --output="${err_out}-exon.%A.stdout.txt" \
                    htseq-count \
                        --order "pos" \
                        --stranded "${hc_strd}" \
                        --nonunique "all" \
                        --type "exon" \
                        --idattr "Parent" \
                        --nprocesses 8 \
                        --counts_output "${out/.tsv/-exon.tsv}" \
                        --with-header \
                        ${bams[*]} \
                        "${in}"
                sleep 0.33

                sbatch \
                    --job-name="htseq-count-CDS" \
                    --nodes=1 \
                    --cpus-per-task=8 \
                    --error="${err_out}-CDS.%A.stderr.txt" \
                    --output="${err_out}-CDS.%A.stdout.txt" \
                    htseq-count \
                        --order "pos" \
                        --stranded "${hc_strd}" \
                        --nonunique "all" \
                        --type "CDS" \
                        --idattr "Parent" \
                        --nprocesses 8 \
                        --counts_output "${out/.tsv/-CDS.tsv}" \
                        --with-header \
                        ${bams[*]} \
                        "${in}"
                sleep 0.33
            done
        done
    }
```
</details>
<br />

<a id="call-htseq-count-with-respect-to-the-intron-filtering-only-gffread-files"></a>
#### Call `htseq-count` with respect to the intron-filtering-only `gffread` files
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: Call htseq-count with respect to the intron-filtering-only gffread files</i></summary>

```bash
#!/bin/bash

#  Echo tests for calls to htseq-count ----------------------------------------
run=TRUE
# run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        h=0
        for i in "strd-eq"; do
            for j in "${stems[@]}"; do
                # i="strd-eq"  # echo "${i}"
                # j="${stems[7]}"  # echo "${j}"
                in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffread-intron-filtering-only.gff3"  # ., "${in}" # less "${in}"
                out="$(echo "${j}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).gffread-intron-filtering-only.hc-${i}.tsv"  # echo "${out}"
                err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                if [[ "${i}" == "strd-eq" ]]; then
                    hc_strd="yes"
                elif [[ "${i}" == "strd-rv" ]]; then
                    hc_strd="reverse"
                fi

                let h++
                printf "    Iteration '%d'\n\n" "${h}"

                echo """
                -------------------------
                Call to htseq-count: gene
                -------------------------
                sbatch \\
                    --job-name=\"htseq-count-gene\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-gene.%A.stderr.txt\" \\
                    --output=\"${err_out}-gene.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"gene\" \\
                        --idattr \"ID\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-gene.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                """
            done
        done
    }


#  Calls to htseq-count -------------------------------------------------------
# run=TRUE
run=FALSE
[[ "${run}" == TRUE ]] &&
    {
        h=0
        for i in "strd-eq"; do
            for j in "${stems[@]}"; do
                # i="strd-eq"  # echo "${i}"
                # j="${stems[7]}"  # echo "${j}"
                in="$(echo "${j}" | sed 's/infiles/outfiles/g' - ).gffread-intron-filtering-only.gff3"  # ., "${in}" # less "${in}"
                out="$(echo "${j}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).gffread-intron-filtering-only.hc-${i}.tsv"  # echo "${out}"
                err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                if [[ "${i}" == "strd-eq" ]]; then
                    hc_strd="yes"
                elif [[ "${i}" == "strd-rv" ]]; then
                    hc_strd="reverse"
                fi

                let h++
                printf "    Iteration '%d'\n\n" "${h}"

                echo """
                -------------------------
                Call to htseq-count: gene
                -------------------------
                sbatch \\
                    --job-name=\"htseq-count-gene\" \\
                    --nodes=1 \\
                    --cpus-per-task=8 \\
                    --error=\"${err_out}-gene.%A.stderr.txt\" \\
                    --output=\"${err_out}-gene.%A.stdout.txt\" \\
                    htseq-count \\
                        --order \"pos\" \\
                        --stranded \"${hc_strd}\" \\
                        --nonunique \"all\" \\
                        --type \"gene\" \\
                        --idattr \"ID\" \\
                        --nprocesses 8 \\
                        --counts_output \"${out/.tsv/-gene.tsv}\" \\
                        --with-header \\
                        \${bams[*]} \\
                        \"${in}\"

                """

                sbatch \
                    --job-name="htseq-count-gene" \
                    --nodes=1 \
                    --cpus-per-task=8 \
                    --error="${err_out}-gene.%A.stderr.txt" \
                    --output="${err_out}-gene.%A.stdout.txt" \
                    htseq-count \
                        --order "pos" \
                        --stranded "${hc_strd}" \
                        --nonunique "all" \
                        --type "gene" \
                        --idattr "ID" \
                        --nprocesses 8 \
                        --counts_output "${out/.tsv/-gene.tsv}" \
                        --with-header \
                        ${bams[*]} \
                        "${in}"
                sleep 0.33
            done
        done
    }
```
</details>
<br />
<br />

<a id="25-correct-tsv-outfiles-with-formatting-errors"></a>
## 2.5. Correct tsv outfiles with formatting errors
<a id="notes"></a>
### Notes
<details>
<summary><i>Notes: Correct tsv outfiles with formatting errors</i></summary>

*For some reason, these files had formatting errors, so rerunning the `htseq-count` jobs in the hopes that it solves the problems:*

mRNA
- `G_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-mRNA.tsv`
- `Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.hc-strd-eq-mRNA.tsv`

CDS
- `Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-CDS.tsv`

exon
- `Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-exon.tsv`
- `Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.hc-strd-eq-exon.tsv`
</details>
<br />

<a id="code-7"></a>
### Code
<details>
<summary><i>Code: Correct tsv outfiles with formatting errors</i></summary>

```bash
#!/bin/bash

run=FALSE
[[ "${run}" == TRUE ]] &&
{
    cd "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/outfiles_htseq-count/Trinity-GG"
    cd G_N/
    mv \
        trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-mRNA.tsv \
        problem.trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-mRNA.tsv

    cd ../Q_N/
    mv \
        trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.hc-strd-eq-mRNA.tsv \
        problem.trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05.hc-strd-eq-mRNA.tsv
    mv \
        trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-CDS.tsv \
        problem.trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-CDS.tsv
    mv \
        trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-exon.tsv \
        problem.trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05.hc-strd-eq-exon.tsv
    mv \
        trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.hc-strd-eq-exon.tsv \
        problem.trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05.hc-strd-eq-exon.tsv

    #  mRNA ------------------------------------------
    run=TRUE
    [[ "${run}" == TRUE ]] &&
        {
            for i in "strd-eq"; do
                for k in \
                    "infiles_gtf-gff3/Trinity-GG/G_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05" \
                    "infiles_gtf-gff3/Trinity-GG/Q_N/trinity-gg_mkc-2_mir-0.05_mg-2_gf-0.05"
                do
                    # i="strd-eq"  # echo "${i}"
                    # k="${stems[7]}"  # echo "${k}"
                    in="$(echo "${k}" | sed 's/infiles/outfiles/g' - ).gffread.gff3"  # ., "${in}" # less "${in}" # Approach #2
                    out="$(echo "${k}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).hc-${i}.tsv"  # echo "${out}"
                    err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                    if [[ "${i}" == "strd-eq" ]]; then
                        hc_strd="yes"
                    elif [[ "${i}" == "strd-rv" ]]; then
                        hc_strd="reverse"
                    fi

                    echo """
                    # -------------------------
                    # Call to htseq-count: mRNA
                    # -------------------------
                    sbatch \\
                        --job-name=\"htseq-count-mRNA\" \\
                        --nodes=1 \\
                        --cpus-per-task=8 \\
                        --error=\"${err_out}-mRNA.%A.stderr.txt\" \\
                        --output=\"${err_out}-mRNA.%A.stdout.txt\" \\
                        htseq-count \\
                            --order \"pos\" \\
                            --stranded \"${hc_strd}\" \\
                            --nonunique \"all\" \\
                            --type \"mRNA\" \\
                            --idattr \"ID\" \\
                            --nprocesses 8 \\
                            --counts_output \"${out/.tsv/-mRNA.tsv}\" \\
                            --with-header \\
                            \${bams[*]} \\
                            \"${in}\"
                    """

                    sbatch \
                        --job-name="htseq-count-mRNA" \
                        --nodes=1 \
                        --cpus-per-task=8 \
                        --error="${err_out}-mRNA.%A.stderr.txt" \
                        --output="${err_out}-mRNA.%A.stdout.txt" \
                        htseq-count \
                            --order "pos" \
                            --stranded "${hc_strd}" \
                            --nonunique "all" \
                            --type "mRNA" \
                            --idattr "ID" \
                            --nprocesses 8 \
                            --counts_output "${out/.tsv/-mRNA.tsv}" \
                            --with-header \
                            ${bams[*]} \
                            "${in}"
                    sleep 0.33
                done
            done
        }

    #  CDS -------------------------------------------
    run=TRUE
    [[ "${run}" == TRUE ]] &&
        {
            for i in "strd-eq"; do
                for k in "infiles_gtf-gff3/Trinity-GG/Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05"; do
                    # i="strd-eq"  # echo "${i}"
                    # k="${stems[7]}"  # echo "${k}"
                    in="$(echo "${k}" | sed 's/infiles/outfiles/g' - ).gffread.gff3"  # ., "${in}" # less "${in}" # Approach #2
                    out="$(echo "${k}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).hc-${i}.tsv"  # echo "${out}"
                    err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                    if [[ "${i}" == "strd-eq" ]]; then
                        hc_strd="yes"
                    elif [[ "${i}" == "strd-rv" ]]; then
                        hc_strd="reverse"
                    fi

                    echo """
                    # -------------------------
                    # Call to htseq-count: CDS
                    # -------------------------
                    sbatch \\
                        --job-name=\"htseq-count-CDS\" \\
                        --nodes=1 \\
                        --cpus-per-task=8 \\
                        --error=\"${err_out}-CDS.%A.stderr.txt\" \\
                        --output=\"${err_out}-CDS.%A.stdout.txt\" \\
                        htseq-count \\
                            --order \"pos\" \\
                            --stranded \"${hc_strd}\" \\
                            --nonunique \"all\" \\
                            --type \"CDS\" \\
                            --idattr \"Parent\" \\
                            --nprocesses 8 \\
                            --counts_output \"${out/.tsv/-CDS.tsv}\" \\
                            --with-header \\
                            \${bams[*]} \\
                            \"${in}\"
                    """

                    sbatch \
                        --job-name="htseq-count-CDS" \
                        --nodes=1 \
                        --cpus-per-task=8 \
                        --error="${err_out}-CDS.%A.stderr.txt" \
                        --output="${err_out}-CDS.%A.stdout.txt" \
                        htseq-count \
                            --order "pos" \
                            --stranded "${hc_strd}" \
                            --nonunique "all" \
                            --type "CDS" \
                            --idattr "Parent" \
                            --nprocesses 8 \
                            --counts_output "${out/.tsv/-CDS.tsv}" \
                            --with-header \
                            ${bams[*]} \
                            "${in}"
                    sleep 0.33
                done
            done
        }

    #  exon ------------------------------------------
    run=TRUE
    [[ "${run}" == TRUE ]] &&
        {
            for i in "strd-eq"; do
                for k in \
                    "infiles_gtf-gff3/Trinity-GG/Q_N/trinity-gg_mkc-16_mir-0.05_mg-2_gf-0.05" \
                    "infiles_gtf-gff3/Trinity-GG/Q_N/trinity-gg_mkc-32_mir-0.05_mg-2_gf-0.05"
                do
                    # i="strd-eq"  # echo "${i}"
                    # k="${stems[7]}"  # echo "${k}"
                    in="$(echo "${k}" | sed 's/infiles/outfiles/g' - ).gffread.gff3"  # ., "${in}" # less "${in}" # Approach #2
                    out="$(echo "${k}" | sed 's/infiles_gtf-gff3/outfiles_htseq-count/g' - ).hc-${i}.tsv"  # echo "${out}"
                    err_out="$(dirname "${out}")/err_out/03-htseq-count-${i}.$(basename "${out}" .tsv)"  # echo "${err_out}"

                    if [[ "${i}" == "strd-eq" ]]; then
                        hc_strd="yes"
                    elif [[ "${i}" == "strd-rv" ]]; then
                        hc_strd="reverse"
                    fi

                    echo """
                    # -------------------------
                    # Call to htseq-count: exon
                    # -------------------------
                    sbatch \\
                        --job-name=\"htseq-count-exon\" \\
                        --nodes=1 \\
                        --cpus-per-task=8 \\
                        --error=\"${err_out}-exon.%A.stderr.txt\" \\
                        --output=\"${err_out}-exon.%A.stdout.txt\" \\
                        htseq-count \\
                            --order \"pos\" \\
                            --stranded \"${hc_strd}\" \\
                            --nonunique \"all\" \\
                            --type \"exon\" \\
                            --idattr \"Parent\" \\
                            --nprocesses 8 \\
                            --counts_output \"${out/.tsv/-exon.tsv}\" \\
                            --with-header \\
                            \${bams[*]} \\
                            \"${in}\"
                    """

                    sbatch \
                        --job-name="htseq-count-exon" \
                        --nodes=1 \
                        --cpus-per-task=8 \
                        --error="${err_out}-exon.%A.stderr.txt" \
                        --output="${err_out}-exon.%A.stdout.txt" \
                        htseq-count \
                            --order "pos" \
                            --stranded "${hc_strd}" \
                            --nonunique "all" \
                            --type "exon" \
                            --idattr "Parent" \
                            --nprocesses 8 \
                            --counts_output "${out/.tsv/-exon.tsv}" \
                            --with-header \
                            ${bams[*]} \
                            "${in}"
                    sleep 0.33
                done
            done
        }
}
```
</details>
<br />
<br />

<a id="next-step"></a>
## Next step
Proceed to [work_assessment-processing_gtfs_part-1.Rmd](./work_assessment-processing_gtfs_part-1.Rmd)
<br />
