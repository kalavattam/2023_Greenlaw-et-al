
`#work_assessment-processing_gtfs_part-2_Trinity.md`
<br />
<br />

<details>
<summary><b><font size="+2">Table of Contents</font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
	1. [Code](#code)
1. [Run `htseq-count` on bams in `bams_renamed/` with `.gtf`s in `outfiles_gtf-gff3/Trinity-GG`](#run-htseq-count-on-bams-in-bams_renamed-with-gtfs-in-outfiles_gtf-gff3trinity-gg)
	1. [Set up outfile directories](#set-up-outfile-directories)
		1. [Code](#code-1)
	1. [Set up arrays of bams](#set-up-arrays-of-bams)
		1. [Code](#code-2)
	1. [Index bams](#index-bams)
		1. [Code](#code-3)
	1. [Run `htseq-count` with `.gtf`s in `outfiles_gtf-gff3/representation`](#run-htseq-count-with-gtfs-in-outfiles_gtf-gff3representation)
		1. [Set up necessary arrays, variables](#set-up-necessary-arrays-variables)
			1. [Code](#code-4)
		1. [Set up and submit `htseq-count` jobs](#set-up-and-submit-htseq-count-jobs)
			1. [Code](#code-5)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="get-situated"></a>
## Get situated
<a id="code"></a>
### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

# tmux new -s htseq
# tmux a -t htseq

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

source activate gff3_env
```
</details>
<br />
<br />

<a id="run-htseq-count-on-bams-in-bams_renamed-with-gtfs-in-outfiles_gtf-gff3trinity-gg"></a>
## Run `htseq-count` on bams in `bams_renamed/` with `.gtf`s in `outfiles_gtf-gff3/Trinity-GG`
But only select `.gtf`s in `outfiles_gtf-gff3/Trinity-GG/{G_N,Q_N}`

<a id="set-up-outfile-directories"></a>
### Set up outfile directories
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Set up outfile directories</i></summary>

```bash
#!/bin/bash

for h in ./outfiles_htseq-count/Trinity-GG/G_N/filtered/locus; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p ./outfiles_htseq-count/Trinity-GG/G_N/filtered/locus/err_out
    else
        echo "Directories present; skipping mkdir'ing of outfile directories"
    fi

    break
done

for h in ./outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p ./outfiles_htseq-count/Trinity-GG/Q_N/filtered/locus/err_out
    else
        echo "Directories present; skipping mkdir'ing of outfile directories"
    fi

    break
done
```
</details>
<br />

<a id="set-up-arrays-of-bams"></a>
### Set up arrays of bams
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Set up arrays of bams</i></summary>

```bash
#!/bin/bash

unset UT_prim_UMI
typeset -a UT_prim_UMI
while IFS=" " read -r -d $'\0'; do
    UT_prim_UMI+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_UMI" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)
echo_test "${UT_prim_UMI[@]}"
echo "${#UT_prim_UMI[@]}"
echo "${UT_prim_UMI[*]}"
```
</details>
<br />

<a id="index-bams"></a>
### Index bams
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Index bams</i></summary>

```bash
#!/bin/bash

for h in ./bams_renamed/UT_prim_UMI/*.bai; do
    if [[ ! -e "${h}" ]]; then
        ml SAMtools/1.16.1-GCC-11.2.0

        for i in "${UT_prim_UMI[@]}"; do
                echo "${i}"
                samtools index -@ "${SLURM_CPUS_ON_NODE}" "${i}"

            module purge SAMtools/1.16.1-GCC-11.2.0
        done
    else
        echo "Bam indices exist; skipping the running of samtools index"
    fi

    break
done
```
</details>
<br />

<a id="run-htseq-count-with-gtfs-in-outfiles_gtf-gff3representation"></a>
### Run `htseq-count` with `.gtf`s in `outfiles_gtf-gff3/representation`
<a id="set-up-necessary-arrays-variables"></a>
#### Set up necessary arrays, variables
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Set up necessary variables</i></summary>

```bash
#!/bin/bash

f_gtf_G_N="${p_gtf}/G_N/filtered/locus/G1_mkc-4_gte-pctl-25.gtf"  # ls -1 "${f_gtf_G_N}"
f_gtf_Q_N="${p_gtf}/Q_N/filtered/locus/Q_mkc-4_gte-pctl-25.gtf"  # ls -1 "${f_gtf_Q_N}"
gtf=( "${f_gtf_G_N}" "${f_gtf_Q_N}" )
echo_test "${gtf[@]}"
echo "${#gtf[@]}"

job_name="run_htseq-count"  # echo "${job_name}"
threads=12  # echo "${threads}"

# echo_test "${UT_prim_UMI[@]}"
# echo "${#UT_prim_UMI[@]}"
```
</details>
<br />

<a id="set-up-and-submit-htseq-count-jobs"></a>
#### Set up and submit `htseq-count` jobs
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Set up and submit htseq-count jobs</i></summary>

```bash
#!/bin/bash

#  Echo tests for calls to htseq-count ----------------------------------------
h=0
# for i in "strd-eq" "strd-rv"; do
for i in "strd-eq"; do
    for j in "${gtf[@]}"; do
        # i="strd-eq"  # echo "${i}"
        # j="${gtf[1]}"  # echo "${j}"

        #  -------------------------------------
        count_against="${j}"  # echo "${count_against}"
        outdir=$(
            echo "$(dirname "${count_against}")" \
                | sed 's/outfiles_gtf-gff3/outfiles_htseq-count/g'
        )  # echo "${outdir}"  # ., "${outdir}"
        outfile="${outdir}/$(basename "${count_against}" .gtf).hc-${i}.tsv"  # echo "${outfile}"
        err_out="${outdir}/err_out/$(basename "${outfile}" .tsv)"  # echo "${err_out}"  # ., "$(dirname "${err_out}")"


        #  -------------------------------------
        let h++
        iter="${h}"
        echo "        #  -------------------------------------"
        printf "        Iteration '%d'\n" "${iter}"

        echo """
        Running htseq-count
                    directory                                                   file
               out  $(dirname ${outfile})          $(basename ${outfile})
            stdout  $(dirname ${err_out})  $(basename ${err_out}).stdout.txt
            stderr  $(dirname ${err_out})  $(basename ${err_out}).stderr.txt
        """

        if [[ "${i}" == "strd-eq" ]]; then
            hc_strd="yes"  # echo "${hc_strd}"
        elif [[ "${i}" == "strd-op" ]]; then
            hc_strd="reverse"  # echo "${hc_strd}"
        fi


        #  -------------------------------------
        echo """
        sbatch \\
            --job-name=${job_name} \\
            --nodes=1 \\
            --cpus-per-task=${threads} \\
            --error=${err_out}.%A.stderr.txt \\
            --output=${err_out}.%A.stdout.txt \\
            htseq-count \\
                --order \"pos\" \\
                --stranded \"${hc_strd}\" \\
                --nonunique \"none\" \\
                --type \"locus\" \\
                --idattr \"id\" \\
                --nprocesses ${threads} \\
                --counts_output \"${out}\" \\
                --with-header \\
                ${UT_prim_UMI[*]} \\
                \"${count_against}\"
        """
    done
done


#  Actual calls to htseq-count ------------------------------------------------
h=0
# for i in "strd-eq" "strd-rv"; do
for i in "strd-eq"; do
    for j in "${gtf[@]}"; do
        # i="strd-eq"  # echo "${i}"
        # j="${gtf[1]}"  # echo "${j}"

        #  -------------------------------------
        count_against="${j}"  # echo "${count_against}"
        outdir=$(
            echo "$(dirname "${count_against}")" \
                | sed 's/outfiles_gtf-gff3/outfiles_htseq-count/g'
        )  # echo "${outdir}"  # ., "${outdir}"
        outfile="${outdir}/$(basename "${count_against}" .gtf).hc-${i}.tsv"  # echo "${outfile}"
        err_out="${outdir}/err_out/$(basename "${outfile}" .tsv)"  # echo "${err_out}"  # ., "$(dirname "${err_out}")"


        #  -------------------------------------
        let h++
        iter="${h}"
        echo "        #  -------------------------------------"
        printf "        Iteration '%d'\n" "${iter}"

        echo """
        Running htseq-count
                    directory                                                   file
               out  $(dirname ${outfile})          $(basename ${outfile})
            stdout  $(dirname ${err_out})  $(basename ${err_out}).stdout.txt
            stderr  $(dirname ${err_out})  $(basename ${err_out}).stderr.txt
        """

        if [[ "${i}" == "strd-eq" ]]; then
            hc_strd="yes"  # echo "${hc_strd}"
        elif [[ "${i}" == "strd-op" ]]; then
            hc_strd="reverse"  # echo "${hc_strd}"
        fi


        #  -------------------------------------
        echo """
        sbatch \\
            --job-name=${job_name} \\
            --nodes=1 \\
            --cpus-per-task=${threads} \\
            --error=${err_out}.%A.stderr.txt \\
            --output=${err_out}.%A.stdout.txt \\
            htseq-count \\
                --order \"pos\" \\
                --stranded \"${hc_strd}\" \\
                --nonunique \"none\" \\
                --type \"locus\" \\
                --idattr \"id\" \\
                --nprocesses ${threads} \\
                --counts_output \"${out}\" \\
                --with-header \\
                ${UT_prim_UMI[*]} \\
                \"${count_against}\"

        """

        sbatch \
            --job-name=${job_name} \
            --nodes=1 \
            --cpus-per-task=${threads} \
            --error=${err_out}.%A.stderr.txt \
            --output=${err_out}.%A.stdout.txt \
            htseq-count \
                --order "pos" \
                --stranded "${hc_strd}" \
                --nonunique "none" \
                --type "locus" \
                --idattr "id" \
                --nprocesses ${threads} \
                --counts_output "${out}" \
                --with-header \
                ${UT_prim_UMI[*]} \
                "${count_against}"
        
        sleep 0.5
    done
done




#         sbatch \
#             --job-name=${job_name} \
#             --nodes=1 \
#             --cpus-per-task=${threads} \
#             --error=${err_out}.%A.stderr.txt \
#             --output=${err_out}.%A.stdout.txt \
#             htseq-count \
#                 --order "pos" \
#                 --stranded "${hc_strd}" \
#                 --nonunique "none" \
#                 --type "feature" \
#                 --idattr "gene_id" \
#                 --nprocesses ${threads} \
#                 --counts_output "${out}" \
#                 --with-header \
#                 ${UT_prim_UMI[*]} \
#                 "${count_against}"

```
</details>
<br />
