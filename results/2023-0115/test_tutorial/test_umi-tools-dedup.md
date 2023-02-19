
`test_umitools-dedup-extract.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Run `umi_tools dedup` on...](#run-umi_tools-dedup-on)
    1. [Get situated](#get-situated)
        1. [Code](#code)
    1. [Prepare files for use with `umi_tools dedup`](#prepare-files-for-use-with-umi_tools-dedup)
        1. [Code](#code-1)
    1. [Run umi_tools dedup on the bams in `test_separate-bam/separate_bam_v2/`](#run-umi_tools-dedup-on-the-bams-in-test_separate-bamseparate_bam_v2)
        1. [Code](#code-2)
        1. [Printed](#printed)
    1. [Check on the results of the `umi_tools dedup` test runs](#check-on-the-results-of-the-umi_tools-dedup-test-runs)
        1. [Code](#code-3)
        1. [Printed](#printed-1)
    1. [Examine differences in alignment numbers between in- and outfiles](#examine-differences-in-alignment-numbers-between-in--and-outfiles)
        1. [Code](#code-4)
        1. [Printed](#printed-2)
    1. [Breakdown the differences in alignment numbers between in- and outfiles](#breakdown-the-differences-in-alignment-numbers-between-in--and-outfiles)
        1. [Notes 1](#notes-1)
        1. [Notes 2 \(and code\)](#notes-2-and-code)
1. [Having broke things down, a question](#having-broke-things-down-a-question)
    1. [Message](#message)
1. [Run `umi_tools dedup` again, but add `--unpaired-reads=discard`](#run-umi_tools-dedup-again-but-add---unpaired-readsdiscard)
    1. [Code](#code-5)
    1. [Selected, cleaned-up printed output](#selected-cleaned-up-printed-output)
1. [So, where does this leave us?](#so-where-does-this-leave-us)
    1. [Review `#NEXTSTEP`s from `test_separate-bam.md`](#review-nextsteps-from-test_separate-bammd)
        1. [Notes](#notes)
    1. [Moving forward: Option 1: Deduplicate primary alignments for use with `Trinity`](#moving-forward-option-1-deduplicate-primary-alignments-for-use-with-trinity)
        1. [Notes](#notes-1)
    1. [Moving forward: Option 2: *Don't* deduplicate primary alignments for use with `Trinity`](#moving-forward-option-2-dont-deduplicate-primary-alignments-for-use-with-trinity)
        1. [Notes](#notes-2)
    1. [Next steps](#next-steps)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="run-umi_tools-dedup-on"></a>
## Run `umi_tools dedup` on...
<a id="get-situated"></a>
### Get situated
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

grabnode  # 8, etc.
transcriptome
Trinity_env
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4
ml SAMtools/1.16.1-GCC-11.2.0

cd results/2023-0115 \
    || echo "cd'ing failed; check on this"
```

</details>
<br />

<a id="prepare-files-for-use-with-umi_tools-dedup"></a>
### Prepare files for use with `umi_tools dedup`
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Prepare files for use with umi_tools dedup</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Index bams from separate-bam tests
unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "./test_separate-bam" \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
# echo_test "${infiles[@]}"
# echo "${#infiles[@]}"

for i in "${infiles[@]}"; do
    if [[ ! -f "${i}.bai" ]]; then
        samtools index \
            -@ "${SLURM_CPUS_ON_NODE}" \
            "${i}"
    fi
done
```
</details>
<br />

<a id="run-umi_tools-dedup-on-the-bams-in-test_separate-bamseparate_bam_v2"></a>
### Run umi_tools dedup on the bams in `test_separate-bam/separate_bam_v2/`
<a id="code-2"></a>
#### Code
<details>
<summary><i>Code: Run umi_tools dedup on the bams in test_separate-bam/separate_bam_v2/</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Establish an outdirectory for test outfiles
outdir="test_umi-tools-dedup"
mkdir "${outdir}"

unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "test_separate-bam/separate_bam_v2" \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
# echo_test "${infiles[@]}"
# echo "${#infiles[@]}"

#  Variable for TMPDIR
scratch="/fh/scratch/delete30/tsukiyama_t"

#  Establish specific arrays for running GNU parallel
unset b_umi_dedu
unset b_umi_stats
unset b_umi_log
unset b_umi_error
unset b_umi_timeit
unset b_pos_dedu
unset b_pos_log
unset b_pos_error
unset b_pos_timeit

typeset -a b_umi_dedu
typeset -a b_umi_stats
typeset -a b_umi_log
typeset -a b_umi_error
typeset -a b_umi_timeit
typeset -a b_pos_dedu
typeset -a b_pos_log
typeset -a b_pos_error
typeset -a b_pos_timeit

for i in "${infiles[@]}"; do
    b_umi_dedu+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.bam" )
    b_umi_stats+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.stats" )
    b_umi_log+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.stdout.txt" )
    b_umi_error+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.stderr.txt" )
    b_umi_timeit+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.time.txt" )
    
    b_pos_dedu+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.bam" )
    b_pos_log+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.stdout.txt" )
    b_pos_error+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.stderr.txt" )
    b_pos_timeit+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.time.txt" )
done

echo_test "${infiles[@]}"
echo_test "${b_umi_dedu[@]}"
echo_test "${b_umi_stats[@]}"
echo_test "${b_umi_log[@]}"
echo_test "${b_umi_error[@]}"
echo_test "${b_umi_timeit[@]}"

echo_test "${infiles[@]}"
echo_test "${b_pos_dedu[@]}"
echo_test "${b_pos_log[@]}"
echo_test "${b_pos_error[@]}"
echo_test "${b_pos_timeit[@]}"

#  Echo tests
parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    echo \
        'umi_tools dedup \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --stdin={b_infile} \
            --stdout={b_umi_dedu} \
            --temp-dir={scratch} \
            --output-stats={b_umi_stats} \
            --log={b_umi_log} \
            --error={b_umi_error} \
            --timeit={b_umi_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_umi_dedu "${b_umi_dedu[@]}" \
:::+ b_umi_stats "${b_umi_stats[@]}" \
:::+ b_umi_log "${b_umi_log[@]}" \
:::+ b_umi_error "${b_umi_error[@]}" \
:::+ b_umi_timeit "${b_umi_timeit[@]}" \
::: scratch "${scratch}"

parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    echo \
        'umi_tools dedup \
            --ignore-umi \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --stdin={b_infile} \
            --stdout={b_pos_dedu} \
            --temp-dir={scratch} \
            --log={b_pos_log} \
            --error={b_pos_error} \
            --timeit={b_pos_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_pos_dedu "${b_pos_dedu[@]}" \
:::+ b_pos_log "${b_pos_log[@]}" \
:::+ b_pos_error "${b_pos_error[@]}" \
:::+ b_pos_timeit "${b_pos_timeit[@]}" \
::: scratch "${scratch}"

#  Run
parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
        'umi_tools dedup \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --stdin={b_infile} \
            --stdout={b_umi_dedu} \
            --temp-dir={scratch} \
            --output-stats={b_umi_stats} \
            --log={b_umi_log} \
            --error={b_umi_error} \
            --timeit={b_umi_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_umi_dedu "${b_umi_dedu[@]}" \
:::+ b_umi_stats "${b_umi_stats[@]}" \
:::+ b_umi_log "${b_umi_log[@]}" \
:::+ b_umi_error "${b_umi_error[@]}" \
:::+ b_umi_timeit "${b_umi_timeit[@]}" \
::: scratch "${scratch}"

parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
        'umi_tools dedup \
            --ignore-umi \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --stdin={b_infile} \
            --stdout={b_pos_dedu} \
            --temp-dir={scratch} \
            --log={b_pos_log} \
            --error={b_pos_error} \
            --timeit={b_pos_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_pos_dedu "${b_pos_dedu[@]}" \
:::+ b_pos_log "${b_pos_log[@]}" \
:::+ b_pos_error "${b_pos_error[@]}" \
:::+ b_pos_timeit "${b_pos_timeit[@]}" \
::: scratch "${scratch}"
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Run umi_tools dedup on the bams in test_separate-bam/separate_bam_v2/</i></summary>

```txt
❯ echo_test "${infiles[@]}"
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam

❯ echo_test "${b_umi_dedu[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam

❯ echo_test "${b_umi_stats[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.stats
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.stats
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.stats
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.stats

❯ echo_test "${b_umi_log[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.stdout.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.stdout.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.stdout.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.stdout.txt

❯ echo_test "${b_umi_error[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.stderr.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.stderr.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.stderr.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.stderr.txt

❯ echo_test "${b_umi_timeit[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.time.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.time.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.time.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.time.txt

❯ echo_test "${infiles[@]}"
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam

❯ echo_test "${b_pos_dedu[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam

❯ echo_test "${b_pos_log[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.stdout.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.stdout.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.stdout.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.stdout.txt

❯ echo_test "${b_pos_error[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.stderr.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.stderr.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.stderr.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.stderr.txt

❯ echo_test "${b_pos_timeit[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.time.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.time.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.time.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.time.txt

❯ #  Echo tests

❯ parallel \
>     --header : \
>     --colsep " " \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     echo \
>         'umi_tools dedup \
>             --paired \
>             --spliced-is-unique \
>             --unmapped-reads=discard \
>             --stdin={b_infile} \
>             --stdout={b_umi_dedu} \
>             --temp-dir={scratch} \
>             --output-stats={b_umi_stats} \
>             --log={b_umi_log} \
>             --error={b_umi_error} \
>             --timeit={b_umi_timeit} \
>             --timeit-header' \
> ::: b_infile "${infiles[@]}" \
> :::+ b_umi_dedu "${b_umi_dedu[@]}" \
> :::+ b_umi_stats "${b_umi_stats[@]}" \
> :::+ b_umi_log "${b_umi_log[@]}" \
> :::+ b_umi_error "${b_umi_error[@]}" \
> :::+ b_umi_timeit "${b_umi_timeit[@]}" \
> ::: scratch "${scratch}"
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --output-stats=test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.stats \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.time.txt \
    --timeit-header
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --output-stats=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.stats \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.time.txt \
    --timeit-header
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --output-stats=test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.stats \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.time.txt \
    --timeit-header
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --output-stats=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.stats \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.time.txt \
    --timeit-header

❯ parallel \
>     --header : \
>     --colsep " " \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>     echo \
>         'umi_tools dedup \
>             --ignore-umi \
>             --paired \
>             --spliced-is-unique \
>             --unmapped-reads=discard \
>             --stdin={b_infile} \
>             --stdout={b_pos_dedu} \
>             --temp-dir={scratch} \
>             --log={b_pos_log} \
>             --error={b_pos_error} \
>             --timeit={b_pos_timeit} \
>             --timeit-header' \
> ::: b_infile "${infiles[@]}" \
> :::+ b_pos_dedu "${b_pos_dedu[@]}" \
> :::+ b_pos_log "${b_pos_log[@]}" \
> :::+ b_pos_error "${b_pos_error[@]}" \
> :::+ b_pos_timeit "${b_pos_timeit[@]}" \
> ::: scratch "${scratch}"
umi_tools dedup \
    --ignore-umi \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.time.txt \
    --timeit-header
umi_tools dedup \
    --ignore-umi \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.time.txt \
    --timeit-header
umi_tools dedup \
    --ignore-umi \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.time.txt \
    --timeit-header
umi_tools dedup \
    --ignore-umi \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin=test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam \
    --stdout=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam \
    --temp-dir=/fh/scratch/delete30/tsukiyama_t \
    --log=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.stdout.txt \
    --error=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.stderr.txt \
    --timeit=test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.time.txt \
    --timeit-header

❯ #  Run

❯ parallel \
>     --header : \
>     --colsep " " \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>         'umi_tools dedup \
>             --paired \
>             --spliced-is-unique \
>             --unmapped-reads=discard \
>             --stdin={b_infile} \
>             --stdout={b_umi_dedu} \
>             --temp-dir={scratch} \
>             --output-stats={b_umi_stats} \
>             --log={b_umi_log} \
>             --error={b_umi_error} \
>             --timeit={b_umi_timeit} \
>             --timeit-header' \
> ::: b_infile "${infiles[@]}" \
> :::+ b_umi_dedu "${b_umi_dedu[@]}" \
> :::+ b_umi_stats "${b_umi_stats[@]}" \
> :::+ b_umi_log "${b_umi_log[@]}" \
> :::+ b_umi_error "${b_umi_error[@]}" \
> :::+ b_umi_timeit "${b_umi_timeit[@]}" \
> ::: scratch "${scratch}"

❯ parallel \
>     --header : \
>     --colsep " " \
>     -k \
>     -j "${SLURM_CPUS_ON_NODE}" \
>         'umi_tools dedup \
>             --ignore-umi \
>             --paired \
>             --spliced-is-unique \
>             --unmapped-reads=discard \
>             --stdin={b_infile} \
>             --stdout={b_pos_dedu} \
>             --temp-dir={scratch} \
>             --log={b_pos_log} \
>             --error={b_pos_error} \
>             --timeit={b_pos_timeit} \
>             --timeit-header' \
> ::: b_infile "${infiles[@]}" \
> :::+ b_pos_dedu "${b_pos_dedu[@]}" \
> :::+ b_pos_log "${b_pos_log[@]}" \
> :::+ b_pos_error "${b_pos_error[@]}" \
> :::+ b_pos_timeit "${b_pos_timeit[@]}" \
> ::: scratch "${scratch}"
```
</details>
<br />

<a id="check-on-the-results-of-the-umi_tools-dedup-test-runs"></a>
### Check on the results of the `umi_tools dedup` test runs
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Check on the results of the umi_tools dedup test runs</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

cd test_umi-tools-dedup \
    || echo "cd'ing failed; check on this"
.,

cd ..
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed: Check on the results of the umi_tools dedup test runs</i></summary>

```txt
❯ cd test_umi-tools-dedup \
>     || echo "cd'ing failed; check on this"
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/test_umi-tools-dedup

❯ .,
total 936M
drwxrws---  2 kalavatt 2.8K Feb 12 10:23 ./
drwxrws--- 14 kalavatt  751 Feb 12 09:51 ../
-rw-rw----  1 kalavatt 167M Feb 12 10:23 5781_Q_Is_UT.primary.pos-dedu.bam
-rw-rw----  1 kalavatt    0 Feb 12 10:21 5781_Q_Is_UT.primary.pos-dedu.stderr.txt
-rw-rw----  1 kalavatt 6.2K Feb 12 10:23 5781_Q_Is_UT.primary.pos-dedu.stdout.txt
-rw-rw----  1 kalavatt  307 Feb 12 10:23 5781_Q_Is_UT.primary.pos-dedu.time.txt
-rw-rw----  1 kalavatt 183M Feb 12 10:23 5781_Q_Is_UT.primary-secondary.pos-dedu.bam
-rw-rw----  1 kalavatt    0 Feb 12 10:21 5781_Q_Is_UT.primary-secondary.pos-dedu.stderr.txt
-rw-rw----  1 kalavatt 6.5K Feb 12 10:23 5781_Q_Is_UT.primary-secondary.pos-dedu.stdout.txt
-rw-rw----  1 kalavatt  307 Feb 12 10:23 5781_Q_Is_UT.primary-secondary.pos-dedu.time.txt
-rw-rw----  1 kalavatt 196M Feb 12 10:18 5781_Q_Is_UT.primary-secondary.UMI-dedu.bam
-rw-rw----  1 kalavatt  301 Feb 12 10:18 5781_Q_Is_UT.primary-secondary.UMI-dedu.stats_edit_distance.tsv
-rw-rw----  1 kalavatt  168 Feb 12 10:18 5781_Q_Is_UT.primary-secondary.UMI-dedu.stats_per_umi_per_position.tsv
-rw-rw----  1 kalavatt 1.6M Feb 12 10:18 5781_Q_Is_UT.primary-secondary.UMI-dedu.stats_per_umi.tsv
-rw-rw----  1 kalavatt    0 Feb 12 10:14 5781_Q_Is_UT.primary-secondary.UMI-dedu.stderr.txt
-rw-rw----  1 kalavatt 7.1K Feb 12 10:18 5781_Q_Is_UT.primary-secondary.UMI-dedu.stdout.txt
-rw-rw----  1 kalavatt  307 Feb 12 10:18 5781_Q_Is_UT.primary-secondary.UMI-dedu.time.txt
-rw-rw----  1 kalavatt 172M Feb 12 10:18 5781_Q_Is_UT.primary.UMI-dedu.bam
-rw-rw----  1 kalavatt  292 Feb 12 10:18 5781_Q_Is_UT.primary.UMI-dedu.stats_edit_distance.tsv
-rw-rw----  1 kalavatt  150 Feb 12 10:18 5781_Q_Is_UT.primary.UMI-dedu.stats_per_umi_per_position.tsv
-rw-rw----  1 kalavatt 1.6M Feb 12 10:18 5781_Q_Is_UT.primary.UMI-dedu.stats_per_umi.tsv
-rw-rw----  1 kalavatt    0 Feb 12 10:14 5781_Q_Is_UT.primary.UMI-dedu.stderr.txt
-rw-rw----  1 kalavatt 6.8K Feb 12 10:18 5781_Q_Is_UT.primary.UMI-dedu.stdout.txt
-rw-rw----  1 kalavatt  307 Feb 12 10:18 5781_Q_Is_UT.primary.UMI-dedu.time.txt
-rw-rw----  1 kalavatt  20M Feb 12 10:21 5781_Q_Is_UT.secondary.pos-dedu.bam
-rw-rw----  1 kalavatt    0 Feb 12 10:21 5781_Q_Is_UT.secondary.pos-dedu.stderr.txt
-rw-rw----  1 kalavatt 5.2K Feb 12 10:21 5781_Q_Is_UT.secondary.pos-dedu.stdout.txt
-rw-rw----  1 kalavatt  305 Feb 12 10:21 5781_Q_Is_UT.secondary.pos-dedu.time.txt
-rw-rw----  1 kalavatt  26M Feb 12 10:15 5781_Q_Is_UT.secondary.UMI-dedu.bam
-rw-rw----  1 kalavatt  283 Feb 12 10:15 5781_Q_Is_UT.secondary.UMI-dedu.stats_edit_distance.tsv
-rw-rw----  1 kalavatt  112 Feb 12 10:15 5781_Q_Is_UT.secondary.UMI-dedu.stats_per_umi_per_position.tsv
-rw-rw----  1 kalavatt 1.2M Feb 12 10:15 5781_Q_Is_UT.secondary.UMI-dedu.stats_per_umi.tsv
-rw-rw----  1 kalavatt    0 Feb 12 10:14 5781_Q_Is_UT.secondary.UMI-dedu.stderr.txt
-rw-rw----  1 kalavatt 5.8K Feb 12 10:15 5781_Q_Is_UT.secondary.UMI-dedu.stdout.txt
-rw-rw----  1 kalavatt  305 Feb 12 10:15 5781_Q_Is_UT.secondary.UMI-dedu.time.txt
-rw-rw----  1 kalavatt 1.9M Feb 12 10:21 5781_Q_Is_UT.unmapped.pos-dedu.bam
-rw-rw----  1 kalavatt    0 Feb 12 10:21 5781_Q_Is_UT.unmapped.pos-dedu.stderr.txt
-rw-rw----  1 kalavatt 5.2K Feb 12 10:21 5781_Q_Is_UT.unmapped.pos-dedu.stdout.txt
-rw-rw----  1 kalavatt  305 Feb 12 10:21 5781_Q_Is_UT.unmapped.pos-dedu.time.txt
-rw-rw----  1 kalavatt 2.0M Feb 12 10:15 5781_Q_Is_UT.unmapped.UMI-dedu.bam
-rw-rw----  1 kalavatt  233 Feb 12 10:15 5781_Q_Is_UT.unmapped.UMI-dedu.stats_edit_distance.tsv
-rw-rw----  1 kalavatt   70 Feb 12 10:15 5781_Q_Is_UT.unmapped.UMI-dedu.stats_per_umi_per_position.tsv
-rw-rw----  1 kalavatt 499K Feb 12 10:15 5781_Q_Is_UT.unmapped.UMI-dedu.stats_per_umi.tsv
-rw-rw----  1 kalavatt    0 Feb 12 10:14 5781_Q_Is_UT.unmapped.UMI-dedu.stderr.txt
-rw-rw----  1 kalavatt 5.6K Feb 12 10:15 5781_Q_Is_UT.unmapped.UMI-dedu.stdout.txt
-rw-rw----  1 kalavatt  305 Feb 12 10:15 5781_Q_Is_UT.unmapped.UMI-dedu.time.txt

❯ cd ..
```
</details>
<br />

<a id="examine-differences-in-alignment-numbers-between-in--and-outfiles"></a>
### Examine differences in alignment numbers between in- and outfiles
Now, I want to see the differences in initial numbers of alignments versus the numbers of alignments following UMI deduplication versus the numbers of alignments following positional deduplication

Also, I want `list_tally_flags` data for the outfiles

<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Examine differences in alignment numbers between in- and outfiles</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Functions
calculate_run_time() {
    what="""
    calculate_run_time()
    --------------------
    Calculate run time for chunk of code
    
    #TODO Check that params are not empty or inappropriate formats or strings

    :param 1: start time in \$(date +%s) format
    :param 2: end time in \$(date +%s) format
    :param 3: message to be displayed when printing the run time <chr>
    :return: message <chr>
    """
    local run_time
    
    run_time="$(echo "${2}" - "${1}" | bc -l)"
    
    echo ""
    echo "${3}"
    printf 'Run time: %dh:%dm:%ds\n' \
        $(( run_time/3600 )) \
        $(( run_time%3600/60 )) \
        $(( run_time%60 ))
    echo ""
}


display_spinning_icon() {
    what="""
    display_spinning_icon()
    -----------------------
    Display \"spinning icon\" while a background process runs
    
    #TODO Checks...
    
    :param 1: PID of the last program the shell ran in the background <int>
    :param 2: message to be displayed next to the spinning icon <chr>
    :return: spinning icon <chr>
    """
    local spin
    local i
    
    spin="/|\\–"
    i=0
    
    while kill -0 "${1}" 2> /dev/null; do
        i=$(( (i + 1) % 4 ))
        printf "\r${spin:$i:1} %s" "${2}"
        sleep .15
    done
}


list_tally_flags() {
    what="""
    list_tally_flags()
    ------------------
    List and tally flags in a bam infile; function acts on a bam infile to
    perform piped commands (samtools view, cut, sort, uniq -c, sort -nr) that
    list and tally flags; function writes the results to a txt outfile, the
    name of which is derived from the txt infile

    #TODO Checks...

    :param 1: name of bam infile, including path <chr>
    :param 2: name of txt outfile, including path <chr>
    :return: file \"\${2}\"
    """
    local start
    local end

    start="$(date +%s)"
    
    samtools view "${1}" \
        | cut -d$'\t' -f 2 \
        | sort \
        | uniq -c \
        | sort -nr \
            > "${2}" &
    display_spinning_icon $! \
    "Running piped commands (samtools view, cut, sort, uniq -c, sort -nr) on $(basename "${1}")... "
        
    end="$(date +%s)"
    echo ""
    calculate_run_time "${start}" "${end}"  \
    "List and tally flags in $(basename "${1}")."
}


#  Get files of interest into arrays (part 1)
unset infiles_in
typeset -a infiles_in
while IFS=" " read -r -d $'\0'; do
    infiles_in+=( "${REPLY}" )
done < <(\
    find "test_separate-bam/separate_bam_v2" \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${infiles_in[@]}"
echo "${#infiles_in[@]}"

unset infiles_out
typeset -a infiles_out
while IFS=" " read -r -d $'\0'; do
    infiles_out+=( "${REPLY}" )
done < <(\
    find "test_umi-tools-dedup/" \
        -type f \
        -name *".bam" \
        -print0 \
            | sort -z \
)
echo_test "${infiles_out[@]}"
echo "${#infiles_out[@]}"


#  Check on things (part 1)
for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
    echo "${i}"$'\t'$(samtools view -c "${i}")
done

for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
	list_tally_flags \
		"${i}" \
		"${outdir}/$(basename "${i}" .bam).list-tally-flags.txt"
done  # (not copying stdout below)


#  Get files of interest into arrays (part 2)
unset infiles_ltf
typeset -a infiles_ltf
while IFS=" " read -r -d $'\0'; do
    infiles_ltf+=( "${REPLY}" )
done < <(\
    find "test_umi-tools-dedup/" \
        -type f \
        -name *.list-tally-flags.txt \
        -print0 \
            | sort -z \
)
echo_test "${infiles_ltf[@]}"
echo "${#infiles_ltf[@]}"

#  Check on things (part 2)
for i in "${infiles_ltf[@]}"; do
	echo "${i}"
	cat "${i}"
	echo ""
done

for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
    echo "${i}"
    samtools view "${i}" | head
    echo ""
done
```
</details>
<br />

<a id="printed-2"></a>
#### Printed
<details>
<summary><i>Printed: Examine differences in alignment numbers between in- and outfiles</i></summary>

```txt
❯ unset infiles_in
❯ typeset -a infiles_in
❯ while IFS=" " read -r -d $'\0'; do
>     infiles_in+=( "${REPLY}" )
> done < <(\
>     find "test_separate-bam/separate_bam_v2" \
>         -type f \
>         -name *.bam \
>         -print0 \
>             | sort -z \
> )

❯ echo_test "${infiles_in[@]}"
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam

❯ echo "${#infiles_in[@]}"
4

❯ unset infiles_out
❯ typeset -a infiles_out
❯ while IFS=" " read -r -d $'\0'; do
>     infiles_out+=( "${REPLY}" )
> done < <(\
>     find "test_umi-tools-dedup/" \
>         -type f \
>         -name *".bam" \
>         -print0 \
>             | sort -z \
> )

❯ echo_test "${infiles_out[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam

❯ echo "${#infiles_out[@]}"
8

❯ for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
>     echo "${i}"$'\t'$(samtools view -c "${i}")
> done
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam	4090422
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam	4774802
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam	684380
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam	227242
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam	3907668
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam	4309541
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam	4712490
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam	4055122
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam	472542
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam	669477
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam	33794
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam	35433

❯ echo_test "${infiles_ltf[@]}"
test_umi-tools-dedup/5781_Q_Is_UT.primary.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.list-tally-flags.txt
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.list-tally-flags.txt

❯ echo "${#infiles_ltf[@]}"
12

❯ for i in "${infiles_ltf[@]}"; do
>     echo "${i}"
>     cat "${i}"
>     echo ""
> done
test_umi-tools-dedup/5781_Q_Is_UT.primary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147

test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.list-tally-flags.txt
 979507 83
 979507 163
 974327 99
 974327 147

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.list-tally-flags.txt
 973699 147
 973501 99
 962868 163
 962657 83
 177502 339
 169071 419
  49472 355
  40771 403

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.list-tally-flags.txt
1023714 163
1023516 83
1002890 147
1002695 99
 286338 339
 277696 419
  52292 355
  43349 403

test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.list-tally-flags.txt
1024479 83
1024479 163
1003082 99
1003082 147

test_umi-tools-dedup/5781_Q_Is_UT.secondary.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.list-tally-flags.txt
 190976 339
 186087 419
  50084 355
  45395 403

test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.list-tally-flags.txt
 287206 339
 282219 419
  52414 355
  47638 403

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.list-tally-flags.txt
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.list-tally-flags.txt
  17340 89
  16454 73

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.list-tally-flags.txt
  18457 89
  16976 73

❯ for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
>     echo "${i}"
>     samtools view "${i}" | head
>     echo ""
> done
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	151	CGCCACTTACCCTACCATTACCCTACCATCCACCATGTCCTACTCACCAT	GGGGGGIIIIIIIIIIGIIIIIIIIIIIIIIIGIIIIIIIIIIIIIIIII	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:2	MD:Z:0T36A12	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-151	ACACACGTACTTACCCTACCACTCTATACCACCACCACCACTACCACACC	GGIIIIGGIIGIIIIGGGGGGIIIIGIGIGGIIGGGGIGGGGGIIGGGGG	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:11	MD:Z:8G14T14A0T0G0C0C0A0T2T1A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	180	TTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTGGC	GGAAGIIGGGIIIIIIIIIIIGIIIIIIIIIIIIGIIGIGGIIIIIIIIG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-180	GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG	IIIIIGGAIGIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:49T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	328	CGGCAGATTGAGCTAGAGTGGTGGTTGCAGAAGCAGTAGCAGCAATGGCA	GGGGGIIIGIIIIGGGIIIIGGGGGIIIIGIIGIIGIIIIIGIIIIIIIA	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:2	MD:Z:2T40G6	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	171	GGGACAGAAGCAGCTCTATTTATACCCATTCCCTCATGGGTTGTTGCTAT	AGGGAIIGIIIIGGGIIIIIIIIIIGGGIIIIGGGIGGGGGIIGGIGIGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:6	MD:Z:0A0T0A0G0T0T44	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	83	I	2363	255	50M	=	2085	-328	TCATTATCACTATGGAGATGCCTTTGTTTCTGAACGAATCATACATCTTG	GGGGGIIIGIIGIIIIIGGIIGGIIIIIIIIIIIIIIGIIIIGGIGGGGG	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:5	MD:Z:8T12T0C20A5T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	83	I	2367	255	50M	=	2246	-171	TATCTCTATGGAGATGCTCTTGTTTCTGAACGAATCATACATCTTTCCAG	IGGGGGGGGIIIIIIIIGIIIIIIIIIIIIIIGIIIIIIIGGGIGGGGGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:4	MD:Z:39A7A0T0A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	163	I	2503	255	50M	=	2644	191	GTGCTTTATAAAACCCTTTTCTGTGCCTGTGACATTTCCTTTTTCGGTCA	GGAGGIIIGIIIIIIIIIIIIIIIIIIIIIAGIIGIIIIGIIIGGGGGGG	NH:i:1	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:4C45	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	83	I	2644	255	50M	=	2503	-191	GAAATATTTCCATCTCTTGAATTCGTACAACATTAAACGTGTGTTGGGAG	IIIIGIIGIGIIIIIIGIIGIIIIIIIIIIIIGGGGGIIIIGIIIGGGGG	NH:i:1	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	151	CGCCACTTACCCTACCATTACCCTACCATCCACCATGTCCTACTCACCAT	GGGGGGIIIIIIIIIIGIIIIIIIIIIIIIIIGIIIIIIIIIIIIIIIII	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:2	MD:Z:0T36A12	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-151	ACACACGTACTTACCCTACCACTCTATACCACCACCACCACTACCACACC	GGIIIIGGIIGIIIIGGGGGGIIIIGIGIGGIIGGGGIGGGGGIIGGGGG	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:11	MD:Z:8G14T14A0T0G0C0C0A0T2T1A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	184	TTTTTTTTTTGGTCAAATAGGTCTATAATATTAATATACATTTATATAA	GGGGGIIIIIGIIIIIIGGIIIIIIIIIIIIIIIGGGIIGIIIIIIIGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0C0A0C0C0G1C0A3A37	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-184	CGTAAAGGCGTTTTGTCTCTAGTTTGCGATAGTGTAGATACCGTCCTTGG	AIGGGAGGGGIGGGGGGIGGGGGAGGIIIIGIIIGGGAIGGIIGGGGGGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0T0A0A2T0T1G0C0G39	jM:B:c,-1	jI:B:i,-1	MC:Z:49M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	177	GTTTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTG	GAGGGGIIIIGIIIIGIGIIIIIIGIIIIIGIGGGIIIIAGGIGGIGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	180	TTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTGGC	GGAAGIIGGGIIIIIIIIIIIGIIIIIIIIIIIIGIIGIGGIIIIIIIIG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-177	GTGGTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTG	GIIIGIIIIIGIGGIIIGIIIIIIIIIIGIIGIIGIIIIIIIGGGGGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:1	MD:Z:49A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-180	GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG	IIIIIGGAIGIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:49T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	328	CGGCAGATTGAGCTAGAGTGGTGGTTGCAGAAGCAGTAGCAGCAATGGCA	GGGGGIIIGIIIIGGGIIIIGGGGGIIIIGIIGIIGIIIIIGIIIIIIIA	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:2	MD:Z:2T40G6	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	171	GGGACAGAAGCAGCTCTATTTATACCCATTCCCTCATGGGTTGTTGCTAT	AGGGAIIGIIIIGGGIIIIIIIIIIGGGIIIIGGGIGGGGGIIGGIGIGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:6	MD:Z:0A0T0A0G0T0T44	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	184	TTTTTTTTTTGGTCAAATAGGTCTATAATATTAATATACATTTATATAA	GGGGGIIIIIGIIIIIIGGIIIIIIIIIIIIIIIGGGIIGIIIIIIIGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0C0A0C0C0G1C0A3A37	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-184	CGTAAAGGCGTTTTGTCTCTAGTTTGCGATAGTGTAGATACCGTCCTTGG	AIGGGAGGGGIGGGGGGIGGGGGAGGIIIIGIIIGGGAIGGIIGGGGGGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0T0A0A2T0T1G0C0G39	jM:B:c,-1	jI:B:i,-1	MC:Z:49M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	177	GTTTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTG	GAGGGGIIIIGIIIIGIGIIIIIIGIIIIIGIGGGIIIIAGGIGGIGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-177	GTGGTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTG	GIIIGIIIIIGIGGIIIGIIIIIIIIIIGIIGIIGIIIIIIIGGGGGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:1	MD:Z:49A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1113:13297:70705_AAATCGAC	355	I	11780	3	41M1D9M	=	11914	184	CAACACTACTGCTGTGACCAATCACATCGGTCGCGGAAGCCTCTGTGTTT	GGGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIGIGIIIGIIIGIII	NH:i:2	HI:i:2	AS:i:90	nM:i:2	NM:i:1	MD:Z:41^G9	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2203:19089:60867_TACCGTCG	355	I	11780	3	50M	=	12030	300	CAACACTACTGCTGTGACCAATCACATCGGTCGCGGAAGCCGTCTGTGTT	GGGGGIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	NH:i:2	HI:i:2	AS:i:98	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	355	I	11805	3	50M	=	11893	138	CTCGGTCGCGGAAGCCGTCTGTGTTTCAGCATGATTGAATCTTGAAATTG	GGGGGGGGIIGAGGGIIGGAGGGGIIIIIGIIIGGIIGGGGIIIGIIGGG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	355	I	11835	3	50M	=	11912	127	CTGATTGAATCTTGAAATTGAAGAGGTGACTACTGTTTTCGTCTCAGCAG	GGGGGGGGGIIGIIIIIIIIIIIIGGGGGIIIIIIIIIIIIIIIIIIIII	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	403	I	11893	3	50M	=	11805	-138	CTGGTAGTTGTCTCAGCAGCTCCAGTATTGGTTGTTGTCTCACTGGTAGC	IGIIIIIIIGGGGIIIIGIIIIGGGGGIIIIIIGIIGGIIIGGGIAGAAG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	403	I	11912	3	50M	=	11835	-127	CTCCAGTATTGGTTGTTGTCTCACTGGTAGCACTGTTCATTTTAGAGCTG	GGIGIIIIGGGGGGIIIIGIIIIIIIIIIIIIIIIIIIIGGIIIIGGAGG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam
D00300:1007:HGV5NBCX3:1:2108:21170:89319_ACATTACG	89	I	4393	255	50M	*	0	0	TACTTGCCGAATAGTTACTTGTTAGTTGCAGATGCTTTTTGATGACAAAG	GGGIGGGGAGGGGIGGGGGIIGGGGGAGGGGGGGGIGGGAGGGAG.<AGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1202:1506:73114_TACGCTCA	89	I	4490	255	50M	*	0	0	CTTTGAGGGTGTATTAATTTTCATACAAATATTTGATTCATTATTCGTTT	GIGIGGGIIIIGIIIIIIIIIIIIIIIIIIIIGGGGIIIGIIIIIGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2210:5659:9423_TATTGCCC	89	I	4711	255	50M	*	0	0	CATCTCTGATAAACAATCTTTGCCACTGCTTTATCCTTTTAAATTGTATT	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIIIIIGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1115:9305:57948_GTCAATAT	89	I	6837	255	50M	*	0	0	ATAGATCGATATTTTGAATTCTAAATGATGAACTAGGGAAGTAATTTCAA	IIIIGGIIIIIIIIIIIIIIGIIIGIIIIGIIIIIIIIIIGGIIGGGGGG	NH:i:1	HI:i:1	AS:i:43	nM:i:3	NM:i:3	MD:Z:47A0G0G0	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2107:8657:86225_GGCCCTAT	137	I	7354	255	50M	*	0	0	TATAGAAGTAGAGTACAACAAAAGTCCAAATGGAGAGACAAAAAGCAGAA	A.GAAA.<GAGIGAGGIIIIIIIGIGGGAGAAGGAGGGAAGAGG.<GGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1201:13962:81431_TACTTACC	73	I	7781	255	50M	*	0	0	CTGATTGAGCTTAGGAATAGAGTATCTTTTCAAAGATTTCAACCATAGTA	GGGGGGGGAAA<GGAGAGGIGGIGGIGGII<A<GGA..<AGIAGGGGAGA	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2205:2963:18967_CAATTTAC	73	I	7872	255	50M	*	0	0	CTATTCCATAAAGTTAAAATGTATATTTTCCAATCACTGAAAATTGTTTT	GAAA.GGGGGGGGGGIGGGGGGGIIIIGGAAGGGGGGGGGIGGGGGIGGI	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1105:2950:78027_GACCAGCC	137	I	8509	0	13M	*	0	0	CTAAATCTTCCTT	GAGAAGAGA.<<G	NH:i:5	HI:i:1	AS:i:12	nM:i:0	NM:i:0	MD:Z:13	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2207:14116:49719_TATGGGAC	89	I	8803	255	50M	*	0	0	AGCTACTAGTCTCAAAATGTAGTTGATCTTTTTCACTTGTAGTCGTGATG	GIIGIIGIIGIGIIIIIIIIIIIIIIIIIIIIGGIIIIIIIIIIGGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2206:17784:29615_AAGTCGAT	73	I	10087	255	50M	*	0	0	TATCATGTTATCTCTTGTAAAAAGAAGTATTCTTCATTCAATACCAATTA	GGGGGGIGIIIIIIIIIIGIGGIIIIIIGIIIIIIIIIIIIGIIIIGIII	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0C49	jM:B:c,-1	jI:B:i,-1

test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	151	CGCCACTTACCCTACCATTACCCTACCATCCACCATGTCCTACTCACCAT	GGGGGGIIIIIIIIIIGIIIIIIIIIIIIIIIGIIIIIIIIIIIIIIIII	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:2	MD:Z:0T36A12	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-151	ACACACGTACTTACCCTACCACTCTATACCACCACCACCACTACCACACC	GGIIIIGGIIGIIIIGGGGGGIIIIGIGIGGIIGGGGIGGGGGIIGGGGG	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:11	MD:Z:8G14T14A0T0G0C0C0A0T2T1A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	180	TTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTGGC	GGAAGIIGGGIIIIIIIIIIIGIIIIIIIIIIIIGIIGIGGIIIIIIIIG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-180	GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG	IIIIIGGAIGIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:49T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	328	CGGCAGATTGAGCTAGAGTGGTGGTTGCAGAAGCAGTAGCAGCAATGGCA	GGGGGIIIGIIIIGGGIIIIGGGGGIIIIGIIGIIGIIIIIGIIIIIIIA	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:2	MD:Z:2T40G6	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	171	GGGACAGAAGCAGCTCTATTTATACCCATTCCCTCATGGGTTGTTGCTAT	AGGGAIIGIIIIGGGIIIIIIIIIIGGGIIIIGGGIGGGGGIIGGIGIGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:6	MD:Z:0A0T0A0G0T0T44	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	83	I	2363	255	50M	=	2085	-328	TCATTATCACTATGGAGATGCCTTTGTTTCTGAACGAATCATACATCTTG	GGGGGIIIGIIGIIIIIGGIIGGIIIIIIIIIIIIIIGIIIIGGIGGGGG	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:5	MD:Z:8T12T0C20A5T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	83	I	2367	255	50M	=	2246	-171	TATCTCTATGGAGATGCTCTTGTTTCTGAACGAATCATACATCTTTCCAG	IGGGGGGGGIIIIIIIIGIIIIIIIIIIIIIIGIIIIIIIGGGIGGGGGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:4	MD:Z:39A7A0T0A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	163	I	2503	255	50M	=	2644	191	GTGCTTTATAAAACCCTTTTCTGTGCCTGTGACATTTCCTTTTTCGGTCA	GGAGGIIIGIIIIIIIIIIIIIIIIIIIIIAGIIGIIIIGIIIGGGGGGG	NH:i:1	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:4C45	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	83	I	2644	255	50M	=	2503	-191	GAAATATTTCCATCTCTTGAATTCGTACAACATTAAACGTGTGTTGGGAG	IIIIGIIGIGIIIIIIGIIGIIIIIIIIIIIIGGGGGIIIIGIIIGGGGG	NH:i:1	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	151	CGCCACTTACCCTACCATTACCCTACCATCCACCATGTCCTACTCACCAT	GGGGGGIIIIIIIIIIGIIIIIIIIIIIIIIIGIIIIIIIIIIIIIIIII	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:2	MD:Z:0T36A12	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-151	ACACACGTACTTACCCTACCACTCTATACCACCACCACCACTACCACACC	GGIIIIGGIIGIIIIGGGGGGIIIIGIGIGGIIGGGGIGGGGGIIGGGGG	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:11	MD:Z:8G14T14A0T0G0C0C0A0T2T1A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	184	TTTTTTTTTTGGTCAAATAGGTCTATAATATTAATATACATTTATATAA	GGGGGIIIIIGIIIIIIGGIIIIIIIIIIIIIIIGGGIIGIIIIIIIGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0C0A0C0C0G1C0A3A37	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-184	CGTAAAGGCGTTTTGTCTCTAGTTTGCGATAGTGTAGATACCGTCCTTGG	AIGGGAGGGGIGGGGGGIGGGGGAGGIIIIGIIIGGGAIGGIIGGGGGGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0T0A0A2T0T1G0C0G39	jM:B:c,-1	jI:B:i,-1	MC:Z:49M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	177	GTTTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTG	GAGGGGIIIIGIIIIGIGIIIIIIGIIIIIGIGGGIIIIAGGIGGIGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	180	TTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTGGC	GGAAGIIGGGIIIIIIIIIIIGIIIIIIIIIIIIGIIGIGGIIIIIIIIG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-177	GTGGTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTG	GIIIGIIIIIGIGGIIIGIIIIIIIIIIGIIGIIGIIIIIIIGGGGGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:1	MD:Z:49A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-180	GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG	IIIIIGGAIGIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:49T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	328	CGGCAGATTGAGCTAGAGTGGTGGTTGCAGAAGCAGTAGCAGCAATGGCA	GGGGGIIIGIIIIGGGIIIIGGGGGIIIIGIIGIIGIIIIIGIIIIIIIA	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:2	MD:Z:2T40G6	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	171	GGGACAGAAGCAGCTCTATTTATACCCATTCCCTCATGGGTTGTTGCTAT	AGGGAIIGIIIIGGGIIIIIIIIIIGGGIIIIGGGIGGGGGIIGGIGIGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:6	MD:Z:0A0T0A0G0T0T44	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	151	CGCCACTTACCCTACCATTACCCTACCATCCACCATGTCCTACTCACCAT	GGGGGGIIIIIIIIIIGIIIIIIIIIIIIIIIGIIIIIIIIIIIIIIIII	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:2	MD:Z:0T36A12	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-151	ACACACGTACTTACCCTACCACTCTATACCACCACCACCACTACCACACC	GGIIIIGGIIGIIIIGGGGGGIIIIGIGIGGIIGGGGIGGGGGIIGGGGG	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:11	MD:Z:8G14T14A0T0G0C0C0A0T2T1A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	184	TTTTTTTTTTGGTCAAATAGGTCTATAATATTAATATACATTTATATAA	GGGGGIIIIIGIIIIIIGGIIIIIIIIIIIIIIIGGGIIGIIIIIIIGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0C0A0C0C0G1C0A3A37	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-184	CGTAAAGGCGTTTTGTCTCTAGTTTGCGATAGTGTAGATACCGTCCTTGG	AIGGGAGGGGIGGGGGGIGGGGGAGGIIIIGIIIGGGAIGGIIGGGGGGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0T0A0A2T0T1G0C0G39	jM:B:c,-1	jI:B:i,-1	MC:Z:49M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	177	GTTTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTG	GAGGGGIIIIGIIIIGIGIIIIIIGIIIIIGIGGGIIIIAGGIGGIGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	180	TTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTGGC	GGAAGIIGGGIIIIIIIIIIIGIIIIIIIIIIIIGIIGIGGIIIIIIIIG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-177	GTGGTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTG	GIIIGIIIIIGIGGIIIGIIIIIIIIIIGIIGIIGIIIIIIIGGGGGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:1	MD:Z:49A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-180	GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG	IIIIIGGAIGIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:49T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	328	CGGCAGATTGAGCTAGAGTGGTGGTTGCAGAAGCAGTAGCAGCAATGGCA	GGGGGIIIGIIIIGGGIIIIGGGGGIIIIGIIGIIGIIIIIGIIIIIIIA	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:2	MD:Z:2T40G6	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	171	GGGACAGAAGCAGCTCTATTTATACCCATTCCCTCATGGGTTGTTGCTAT	AGGGAIIGIIIIGGGIIIIIIIIIIGGGIIIIGGGIGGGGGIIGGIGIGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:6	MD:Z:0A0T0A0G0T0T44	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	151	CGCCACTTACCCTACCATTACCCTACCATCCACCATGTCCTACTCACCAT	GGGGGGIIIIIIIIIIGIIIIIIIIIIIIIIIGIIIIIIIIIIIIIIIII	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:2	MD:Z:0T36A12	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-151	ACACACGTACTTACCCTACCACTCTATACCACCACCACCACTACCACACC	GGIIIIGGIIGIIIIGGGGGGIIIIGIGIGGIIGGGGIGGGGGIIGGGGG	NH:i:1	HI:i:1	AS:i:72	nM:i:13	NM:i:11	MD:Z:8G14T14A0T0G0C0C0A0T2T1A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	180	TTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTGGC	GGAAGIIGGGIIIIIIIIIIIGIIIIIIIIIIIIGIIGIGGIIIIIIIIG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-180	GAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTAGGTTG	IIIIIGGAIGIIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIGGGGGGGGG	NH:i:4	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:49T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	328	CGGCAGATTGAGCTAGAGTGGTGGTTGCAGAAGCAGTAGCAGCAATGGCA	GGGGGIIIGIIIIGGGIIIIGGGGGIIIIGIIGIIGIIIIIGIIIIIIIA	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:2	MD:Z:2T40G6	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	171	GGGACAGAAGCAGCTCTATTTATACCCATTCCCTCATGGGTTGTTGCTAT	AGGGAIIGIIIIGGGIIIIIIIIIIGGGIIIIGGGIGGGGGIIGGIGIGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:6	MD:Z:0A0T0A0G0T0T44	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	83	I	2363	255	50M	=	2085	-328	TCATTATCACTATGGAGATGCCTTTGTTTCTGAACGAATCATACATCTTG	GGGGGIIIGIIGIIIIIGGIIGGIIIIIIIIIIIIIIGIIIIGGIGGGGG	NH:i:1	HI:i:1	AS:i:84	nM:i:7	NM:i:5	MD:Z:8T12T0C20A5T0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	83	I	2367	255	50M	=	2246	-171	TATCTCTATGGAGATGCTCTTGTTTCTGAACGAATCATACATCTTTCCAG	IGGGGGGGGIIIIIIIIGIIIIIIIIIIIIIIGIIIIIIIGGGIGGGGGG	NH:i:1	HI:i:1	AS:i:78	nM:i:10	NM:i:4	MD:Z:39A7A0T0A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	163	I	2503	255	50M	=	2644	191	GTGCTTTATAAAACCCTTTTCTGTGCCTGTGACATTTCCTTTTTCGGTCA	GGAGGIIIGIIIIIIIIIIIIIIIIIIIIIAGIIGIIIIGIIIGGGGGGG	NH:i:1	HI:i:1	AS:i:96	nM:i:1	NM:i:1	MD:Z:4C45	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	83	I	2644	255	50M	=	2503	-191	GAAATATTTCCATCTCTTGAATTCGTACAACATTAAACGTGTGTTGGGAG	IIIIGIIGIGIIIIIIGIIGIIIIIIIIIIIIGGGGGIIIIGIIIGGGGG	NH:i:1	HI:i:1	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	184	TTTTTTTTTTGGTCAAATAGGTCTATAATATTAATATACATTTATATAA	GGGGGIIIIIGIIIIIIGGIIIIIIIIIIIIIIIGGGIIGIIIIIIIGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0C0A0C0C0G1C0A3A37	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-184	CGTAAAGGCGTTTTGTCTCTAGTTTGCGATAGTGTAGATACCGTCCTTGG	AIGGGAGGGGIGGGGGGIGGGGGAGGIIIIGIIIGGGAIGGIIGGGGGGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0T0A0A2T0T1G0C0G39	jM:B:c,-1	jI:B:i,-1	MC:Z:49M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	177	GTTTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTG	GAGGGGIIIIGIIIIGIGIIIIIIGIIIIIGIGGGIIIIAGGIGGIGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-177	GTGGTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTG	GIIIGIIIIIGIGGIIIGIIIIIIIIIIGIIGIIGIIIIIIIGGGGGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:1	MD:Z:49A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1113:13297:70705_AAATCGAC	355	I	11780	3	41M1D9M	=	11914	184	CAACACTACTGCTGTGACCAATCACATCGGTCGCGGAAGCCTCTGTGTTT	GGGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIGIGIIIGIIIGIII	NH:i:2	HI:i:2	AS:i:90	nM:i:2	NM:i:1	MD:Z:41^G9	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2203:19089:60867_TACCGTCG	355	I	11780	3	50M	=	12030	300	CAACACTACTGCTGTGACCAATCACATCGGTCGCGGAAGCCGTCTGTGTT	GGGGGIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	NH:i:2	HI:i:2	AS:i:98	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	355	I	11805	3	50M	=	11893	138	CTCGGTCGCGGAAGCCGTCTGTGTTTCAGCATGATTGAATCTTGAAATTG	GGGGGGGGIIGAGGGIIGGAGGGGIIIIIGIIIGGIIGGGGIIIGIIGGG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	355	I	11835	3	50M	=	11912	127	CTGATTGAATCTTGAAATTGAAGAGGTGACTACTGTTTTCGTCTCAGCAG	GGGGGGGGGIIGIIIIIIIIIIIIGGGGGIIIIIIIIIIIIIIIIIIIII	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	403	I	11893	3	50M	=	11805	-138	CTGGTAGTTGTCTCAGCAGCTCCAGTATTGGTTGTTGTCTCACTGGTAGC	IGIIIIIIIGGGGIIIIGIIIIGGGGGIIIIIIGIIGGIIIGGGIAGAAG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	403	I	11912	3	50M	=	11835	-127	CTCCAGTATTGGTTGTTGTCTCACTGGTAGCACTGTTCATTTTAGAGCTG	GGIGIIIIGGGGGGIIIIGIIIIIIIIIIIIIIIIIIIIGGIIIIGGAGG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	184	TTTTTTTTTTGGTCAAATAGGTCTATAATATTAATATACATTTATATAA	GGGGGIIIIIGIIIIIIGGIIIIIIIIIIIIIIIGGGIIGIIIIIIIGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0C0A0C0C0G1C0A3A37	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-184	CGTAAAGGCGTTTTGTCTCTAGTTTGCGATAGTGTAGATACCGTCCTTGG	AIGGGAGGGGIGGGGGGIGGGGGAGGIIIIGIIIGGGAIGGIIGGGGGGG	NH:i:3	HI:i:3	AS:i:65	nM:i:16	NM:i:8	MD:Z:0T0A0A2T0T1G0C0G39	jM:B:c,-1	jI:B:i,-1	MC:Z:49M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	177	GTTTGCGATAGTGTAGATACCGTCCTTGGATAGAGCACTGGAGATGGCTG	GAGGGGIIIIGIIIIGIGIIIIIIGIIIIIGIGGGIIIIAGGIGGIGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-177	GTGGTGAAGTCACCGTAGTTGAAAACGGCTTCAGCAACTTCGACTGGGTG	GIIIGIIIIIGIGGIIIGIIIIIIIIIIGIIGIIGIIIIIIIGGGGGGGG	NH:i:4	HI:i:4	AS:i:96	nM:i:1	NM:i:1	MD:Z:49A0	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1113:13297:70705_AAATCGAC	355	I	11780	3	41M1D9M	=	11914	184	CAACACTACTGCTGTGACCAATCACATCGGTCGCGGAAGCCTCTGTGTTT	GGGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIGIGIIIGIIIGIII	NH:i:2	HI:i:2	AS:i:90	nM:i:2	NM:i:1	MD:Z:41^G9	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:2203:19089:60867_TACCGTCG	355	I	11780	3	50M	=	12030	300	CAACACTACTGCTGTGACCAATCACATCGGTCGCGGAAGCCGTCTGTGTT	GGGGGIIIIIGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	NH:i:2	HI:i:2	AS:i:98	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	355	I	11805	3	50M	=	11893	138	CTCGGTCGCGGAAGCCGTCTGTGTTTCAGCATGATTGAATCTTGAAATTG	GGGGGGGGIIGAGGGIIGGAGGGGIIIIIGIIIGGIIGGGGIIIGIIGGG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	355	I	11835	3	50M	=	11912	127	CTGATTGAATCTTGAAATTGAAGAGGTGACTACTGTTTTCGTCTCAGCAG	GGGGGGGGGIIGIIIIIIIIIIIIGGGGGIIIIIIIIIIIIIIIIIIIII	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	403	I	11893	3	50M	=	11805	-138	CTGGTAGTTGTCTCAGCAGCTCCAGTATTGGTTGTTGTCTCACTGGTAGC	IGIIIIIIIGGGGIIIIGIIIIGGGGGIIIIIIGIIGGIIIGGGIAGAAG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	403	I	11912	3	50M	=	11835	-127	CTCCAGTATTGGTTGTTGTCTCACTGGTAGCACTGTTCATTTTAGAGCTG	GGIGIIIIGGGGGGIIIIGIIIIIIIIIIIIIIIIIIIIGGIIIIGGAGG	NH:i:2	HI:i:2	AS:i:96	nM:i:1	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1	MC:Z:50M

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:2108:21170:89319_ACATTACG	89	I	4393	255	50M	*	0	0	TACTTGCCGAATAGTTACTTGTTAGTTGCAGATGCTTTTTGATGACAAAG	GGGIGGGGAGGGGIGGGGGIIGGGGGAGGGGGGGGIGGGAGGGAG.<AGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1202:1506:73114_TACGCTCA	89	I	4490	255	50M	*	0	0	CTTTGAGGGTGTATTAATTTTCATACAAATATTTGATTCATTATTCGTTT	GIGIGGGIIIIGIIIIIIIIIIIIIIIIIIIIGGGGIIIGIIIIIGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2210:5659:9423_TATTGCCC	89	I	4711	255	50M	*	0	0	CATCTCTGATAAACAATCTTTGCCACTGCTTTATCCTTTTAAATTGTATT	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIIIIIGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1115:9305:57948_GTCAATAT	89	I	6837	255	50M	*	0	0	ATAGATCGATATTTTGAATTCTAAATGATGAACTAGGGAAGTAATTTCAA	IIIIGGIIIIIIIIIIIIIIGIIIGIIIIGIIIIIIIIIIGGIIGGGGGG	NH:i:1	HI:i:1	AS:i:43	nM:i:3	NM:i:3	MD:Z:47A0G0G0	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1201:13962:81431_TACTTACC	73	I	7781	255	50M	*	0	0	CTGATTGAGCTTAGGAATAGAGTATCTTTTCAAAGATTTCAACCATAGTA	GGGGGGGGAAA<GGAGAGGIGGIGGIGGII<A<GGA..<AGIAGGGGAGA	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2205:2963:18967_CAATTTAC	73	I	7872	255	50M	*	0	0	CTATTCCATAAAGTTAAAATGTATATTTTCCAATCACTGAAAATTGTTTT	GAAA.GGGGGGGGGGIGGGGGGGIIIIGGAAGGGGGGGGGIGGGGGIGGI	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2207:14116:49719_TATGGGAC	89	I	8803	255	50M	*	0	0	AGCTACTAGTCTCAAAATGTAGTTGATCTTTTTCACTTGTAGTCGTGATG	GIIGIIGIIGIGIIIIIIIIIIIIIIIIIIIIGGIIIIIIIIIIGGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2206:17784:29615_AAGTCGAT	73	I	10087	255	50M	*	0	0	TATCATGTTATCTCTTGTAAAAAGAAGTATTCTTCATTCAATACCAATTA	GGGGGGIGIIIIIIIIIIGIGGIIIIIIGIIIIIIIIIIIIGIIIIGIII	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0C49	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2204:14309:62868_CTCCGCGG	73	I	11935	255	47M	*	0	0	CTGGTAGCACTGTTCATTTTAGAGCTGACAGACTCTTCATTCGTAGT	GGGGGIIIIIIIIIIIIGGIGGGGGGGGAGAAGG.AGGGGA.A.GGG	NH:i:1	HI:i:1	AS:i:46	nM:i:0	NM:i:0	MD:Z:47	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1213:11717:56806_GCCTACAT	73	I	12135	255	50M	*	0	0	CATAGGACACCATGTCGTGTATTCTGTGGTAACGCCGTTAATAGTAGCAG	GGGGAGGGGAAGGGGGGGGGGAGGIIAAAGG.AA<AGAGAGGIIGGAAGG	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:2108:21170:89319_ACATTACG	89	I	4393	255	50M	*	0	0	TACTTGCCGAATAGTTACTTGTTAGTTGCAGATGCTTTTTGATGACAAAG	GGGIGGGGAGGGGIGGGGGIIGGGGGAGGGGGGGGIGGGAGGGAG.<AGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1202:1506:73114_TACGCTCA	89	I	4490	255	50M	*	0	0	CTTTGAGGGTGTATTAATTTTCATACAAATATTTGATTCATTATTCGTTT	GIGIGGGIIIIGIIIIIIIIIIIIIIIIIIIIGGGGIIIGIIIIIGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2210:5659:9423_TATTGCCC	89	I	4711	255	50M	*	0	0	CATCTCTGATAAACAATCTTTGCCACTGCTTTATCCTTTTAAATTGTATT	IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIGIIIIIGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1115:9305:57948_GTCAATAT	89	I	6837	255	50M	*	0	0	ATAGATCGATATTTTGAATTCTAAATGATGAACTAGGGAAGTAATTTCAA	IIIIGGIIIIIIIIIIIIIIGIIIGIIIIGIIIIIIIIIIGGIIGGGGGG	NH:i:1	HI:i:1	AS:i:43	nM:i:3	NM:i:3	MD:Z:47A0G0G0	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1201:13962:81431_TACTTACC	73	I	7781	255	50M	*	0	0	CTGATTGAGCTTAGGAATAGAGTATCTTTTCAAAGATTTCAACCATAGTA	GGGGGGGGAAA<GGAGAGGIGGIGGIGGII<A<GGA..<AGIAGGGGAGA	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2205:2963:18967_CAATTTAC	73	I	7872	255	50M	*	0	0	CTATTCCATAAAGTTAAAATGTATATTTTCCAATCACTGAAAATTGTTTT	GAAA.GGGGGGGGGGIGGGGGGGIIIIGGAAGGGGGGGGGIGGGGGIGGI	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2207:14116:49719_TATGGGAC	89	I	8803	255	50M	*	0	0	AGCTACTAGTCTCAAAATGTAGTTGATCTTTTTCACTTGTAGTCGTGATG	GIIGIIGIIGIGIIIIIIIIIIIIIIIIIIIIGGIIIIIIIIIIGGGGGG	NH:i:1	HI:i:1	AS:i:49	nM:i:0	NM:i:0	MD:Z:50	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2206:17784:29615_AAGTCGAT	73	I	10087	255	50M	*	0	0	TATCATGTTATCTCTTGTAAAAAGAAGTATTCTTCATTCAATACCAATTA	GGGGGGIGIIIIIIIIIIGIGGIIIIIIGIIIIIIIIIIIIGIIIIGIII	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0C49	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:2204:14309:62868_CTCCGCGG	73	I	11935	255	47M	*	0	0	CTGGTAGCACTGTTCATTTTAGAGCTGACAGACTCTTCATTCGTAGT	GGGGGIIIIIIIIIIIIGGIGGGGGGGGAGAAGG.AGGGGA.A.GGG	NH:i:1	HI:i:1	AS:i:46	nM:i:0	NM:i:0	MD:Z:47	jM:B:c,-1	jI:B:i,-1
D00300:1007:HGV5NBCX3:1:1213:11717:56806_GCCTACAT	73	I	12135	255	50M	*	0	0	CATAGGACACCATGTCGTGTATTCTGTGGTAACGCCGTTAATAGTAGCAG	GGGGAGGGGAAGGGGGGGGGGAGGIIAAAGG.AA<AGAGAGGIIGGAAGG	NH:i:1	HI:i:1	AS:i:47	nM:i:1	NM:i:1	MD:Z:0A49	jM:B:c,-1	jI:B:i,-1
```
</details>
<br />

<a id="breakdown-the-differences-in-alignment-numbers-between-in--and-outfiles"></a>
### Breakdown the differences in alignment numbers between in- and outfiles
<a id="notes-1"></a>
#### Notes 1
<details>
<summary><i>Notes 1: Breakdown the differences in alignment numbers between in- and outfiles</i></summary>

Break things down...
```txt
❯ for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
>     echo "${i}"$'\t'$(samtools view -c "${i}")
> done
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam	4090422
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam	4055122
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam	3907668

test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam	4774802
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam	4712490
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam	4309541

test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam	684380
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam	669477
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam	472542

test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam	227242
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam	35433
test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam	33794


❯ for i in "${infiles_ltf[@]}"; do
>     echo "${i}"
>     cat "${i}"
>     echo ""
> done
test_umi-tools-dedup/5781_Q_Is_UT.primary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147

test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.list-tally-flags.txt
1024479 83
1024479 163
1003082 99
1003082 147

test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.list-tally-flags.txt
 979507 83
 979507 163
 974327 99
 974327 147


test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.list-tally-flags.txt
1023714 163
1023516 83
1002890 147
1002695 99
 286338 339
 277696 419
  52292 355
  43349 403

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.list-tally-flags.txt
 973699 147
 973501 99
 962868 163
 962657 83
 177502 339
 169071 419
  49472 355
  40771 403


test_umi-tools-dedup/5781_Q_Is_UT.secondary.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.list-tally-flags.txt
 287206 339
 282219 419
  52414 355
  47638 403

test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.list-tally-flags.txt
 190976 339
 186087 419
  50084 355
  45395 403


test_umi-tools-dedup/5781_Q_Is_UT.unmapped.list-tally-flags.txt
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.list-tally-flags.txt
  18457 89
  16976 73

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.list-tally-flags.txt
  17340 89
  16454 73


❯ for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
>     echo "${i}"
>     samtools view "${i}" | head
>     echo ""
> done
test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	1
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	83	I	2363	255	50M	=	2085	-3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	83	I	2367	255	50M	=	2246	-1
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	163	I	2503	255	50M	=	2644	1
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	83	I	2644	255	50M	=	2503	-1

test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	1
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	83	I	2363	255	50M	=	2085	-3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	83	I	2367	255	50M	=	2246	-1
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	163	I	2503	255	50M	=	2644	1
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	83	I	2644	255	50M	=	2503	-1

test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	1
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	83	I	2363	255	50M	=	2085	-3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	83	I	2367	255	50M	=	2246	-1
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	163	I	2503	255	50M	=	2644	1
D00300:1007:HGV5NBCX3:1:1210:14427:32647_GAGTCCTG	83	I	2644	255	50M	=	2503	-1


test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	1
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	1

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	1
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	1

test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	99	I	249	255	50M	=	350	1
D00300:1007:HGV5NBCX3:1:1203:2526:100799_TCACTTGC	147	I	350	255	50M	=	249	-1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	163	I	1812	1	50M	=	1942	1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-1
D00300:1007:HGV5NBCX3:1:2109:11624:69567_GAGACATA	83	I	1942	1	50M	=	1812	-1
D00300:1007:HGV5NBCX3:1:1216:19821:65041_ATTCAGCC	163	I	2085	255	50M	=	2363	3
D00300:1007:HGV5NBCX3:1:1110:9129:18452_CCACTAAA	163	I	2246	255	50M	=	2367	1


test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-1
D00300:1007:HGV5NBCX3:1:1113:13297:70705_AAATCGAC	355	I	11780	3	41M1D9M	=	11914	1
D00300:1007:HGV5NBCX3:1:2203:19089:60867_TACCGTCG	355	I	11780	3	50M	=	12030	3
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	355	I	11805	3	50M	=	11893	1
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	355	I	11835	3	50M	=	11912	1
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	403	I	11893	3	50M	=	11805	-1
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	403	I	11912	3	50M	=	11835	-1

test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-1
D00300:1007:HGV5NBCX3:1:1113:13297:70705_AAATCGAC	355	I	11780	3	41M1D9M	=	11914	1
D00300:1007:HGV5NBCX3:1:2203:19089:60867_TACCGTCG	355	I	11780	3	50M	=	12030	3
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	355	I	11805	3	50M	=	11893	1
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	355	I	11835	3	50M	=	11912	1
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	403	I	11893	3	50M	=	11805	-1
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	403	I	11912	3	50M	=	11835	-1

test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	419	I	1655	1	49M	=	1789	1
D00300:1007:HGV5NBCX3:1:2216:14317:24689_ACTTCTCT	339	I	1789	1	50M	=	1655	-1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	419	I	1810	1	50M	=	1937	1
D00300:1007:HGV5NBCX3:1:1111:11775:47905_ATTGGATG	339	I	1937	1	50M	=	1810	-1
D00300:1007:HGV5NBCX3:1:1113:13297:70705_AAATCGAC	355	I	11780	3	41M1D9M	=	11914	1
D00300:1007:HGV5NBCX3:1:2203:19089:60867_TACCGTCG	355	I	11780	3	50M	=	12030	3
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	355	I	11805	3	50M	=	11893	1
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	355	I	11835	3	50M	=	11912	1
D00300:1007:HGV5NBCX3:1:1206:6620:99847_TGGCGGAG	403	I	11893	3	50M	=	11805	-1
D00300:1007:HGV5NBCX3:1:1216:6221:51297_TGTAGGAG	403	I	11912	3	50M	=	11835	-1


test_separate-bam/separate_bam_v2/5781_Q_Is_UT.unmapped.bam
D00300:1007:HGV5NBCX3:1:2108:21170:89319_ACATTACG	89	I	4393	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1202:1506:73114_TACGCTCA	89	I	4490	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2210:5659:9423_TATTGCCC	89	I	4711	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1115:9305:57948_GTCAATAT	89	I	6837	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2107:8657:86225_GGCCCTAT	137	I	7354	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1201:13962:81431_TACTTACC	73	I	7781	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2205:2963:18967_CAATTTAC	73	I	7872	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1105:2950:78027_GACCAGCC	137	I	8509	0	13M	*	0	0
D00300:1007:HGV5NBCX3:1:2207:14116:49719_TATGGGAC	89	I	8803	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2206:17784:29615_AAGTCGAT	73	I	10087	255	50M	*	0	0

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.UMI-dedu.bam
D00300:1007:HGV5NBCX3:1:2108:21170:89319_ACATTACG	89	I	4393	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1202:1506:73114_TACGCTCA	89	I	4490	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2210:5659:9423_TATTGCCC	89	I	4711	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1115:9305:57948_GTCAATAT	89	I	6837	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1201:13962:81431_TACTTACC	73	I	7781	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2205:2963:18967_CAATTTAC	73	I	7872	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2207:14116:49719_TATGGGAC	89	I	8803	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2206:17784:29615_AAGTCGAT	73	I	10087	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2204:14309:62868_CTCCGCGG	73	I	11935	255	47M	*	0	0
D00300:1007:HGV5NBCX3:1:1213:11717:56806_GCCTACAT	73	I	12135	255	50M	*	0	0

test_umi-tools-dedup/5781_Q_Is_UT.unmapped.pos-dedu.bam
D00300:1007:HGV5NBCX3:1:2108:21170:89319_ACATTACG	89	I	4393	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1202:1506:73114_TACGCTCA	89	I	4490	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2210:5659:9423_TATTGCCC	89	I	4711	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1115:9305:57948_GTCAATAT	89	I	6837	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:1201:13962:81431_TACTTACC	73	I	7781	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2205:2963:18967_CAATTTAC	73	I	7872	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2207:14116:49719_TATGGGAC	89	I	8803	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2206:17784:29615_AAGTCGAT	73	I	10087	255	50M	*	0	0
D00300:1007:HGV5NBCX3:1:2204:14309:62868_CTCCGCGG	73	I	11935	255	47M	*	0	0
D00300:1007:HGV5NBCX3:1:1213:11717:56806_GCCTACAT	73	I	12135	255	50M	*	0	0
```
</details>
<br />

<a id="notes-2-and-code"></a>
#### Notes 2 (and code)
<details>
<summary><i>Notes 2 (and code): Breakdown the differences in alignment numbers between in- and outfiles</i></summary>

Interestingly, flags `89` and `73` in `.unmapped.` were deduplicated

Of the duplicates, what are biological and what are technical? The number of biological duplicates is assumed to be the <mark><i>(number of alignments minus <u>positional duplicates</u>)</i> minus the <i>(number of alignments minus <u>number of UMI duplicates)</u></i></mark>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary.bam	4090422
# test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.bam	4055122
# test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.bam	3907668
#
# test_separate-bam/separate_bam_v2/5781_Q_Is_UT.primary-secondary.bam	4774802
# test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.bam	4712490
# test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.bam	4309541
#
# test_separate-bam/separate_bam_v2/5781_Q_Is_UT.secondary.bam	684380
# test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.bam	669477
# test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.bam	472542

ps_no_umi_dup="$(( 4774802 - 4712490 ))"  # echo "${ps_no_umi_dup}"
ps_no_pos_dup="$(( 4774802 - 4309541 ))"  # echo "${ps_no_pos_dup}"
ps_no_bio_dup=$(( ps_no_pos_dup - ps_no_umi_dup ))  # echo "${ps_no_bio_dup}"
ps_no_inval_dup=$(( ps_no_umi_dup ))  # echo "${ps_no_inval_dup}"

p_no_umi_dup="$(( 4090422 - 4055122 ))"  # echo "${p_no_umi_dup}"
p_no_pos_dup="$(( 4090422 - 3907668 ))"  # echo "${p_no_pos_dup}"
p_no_bio_dup=$(( p_no_pos_dup - p_no_umi_dup ))  # echo "${p_no_bio_dup}"
p_no_inval_dup=$(( p_no_umi_dup ))  # echo "${p_no_inval_dup}"

s_no_umi_dup="$(( 684380 - 669477 ))"  # echo "${s_no_umi_dup}"
s_no_pos_dup="$(( 684380 - 472542 ))"  # echo "${s_no_pos_dup}"
s_no_bio_dup=$(( s_no_pos_dup - s_no_umi_dup ))  # echo "${s_no_bio_dup}"
s_no_inval_dup=$(( s_no_umi_dup ))  # echo "${s_no_inval_dup}"

echo "sample"$'\t'"no_pos_dup"$'\t'"no_bio_dup"$'\t'"no_inval_dup"
echo "5781_Q_Is_UT.primary-secondary"$'\t'"${ps_no_pos_dup}"$'\t'"${ps_no_bio_dup}"$'\t'"${ps_no_inval_dup}"
echo "5781_Q_Is_UT.primary"$'\t'"${p_no_pos_dup}"$'\t'"${p_no_bio_dup}"$'\t'"${p_no_inval_dup}"
echo "5781_Q_Is_UT.secondary"$'\t'"${s_no_pos_dup}"$'\t'"${s_no_bio_dup}"$'\t'"${s_no_inval_dup}"

echo $(( 182754 + 211838 ))
echo $(( 147454 + 196935 ))
echo $(( 35300 + 14903 ))
```

```txt
❯ ps_no_umi_dup="$(( 4774802 - 4712490 ))"  # echo "${ps_no_umi_dup}"
❯ ps_no_pos_dup="$(( 4774802 - 4309541 ))"  # echo "${ps_no_pos_dup}"
❯ ps_no_bio_dup=$(( ps_no_pos_dup - ps_no_umi_dup ))  # echo "${ps_no_bio_dup}"
❯ ps_no_inval_dup=$(( ps_no_umi_dup ))  # echo "${ps_no_inval_dup}"

❯ p_no_umi_dup="$(( 4090422 - 4055122 ))"  # echo "${p_no_umi_dup}"
❯ p_no_pos_dup="$(( 4090422 - 3907668 ))"  # echo "${p_no_pos_dup}"
❯ p_no_bio_dup=$(( p_no_pos_dup - p_no_umi_dup ))  # echo "${p_no_bio_dup}"
❯ p_no_inval_dup=$(( p_no_umi_dup ))  # echo "${p_no_inval_dup}"

❯ s_no_umi_dup="$(( 684380 - 669477 ))"  # echo "${s_no_umi_dup}"
❯ s_no_pos_dup="$(( 684380 - 472542 ))"  # echo "${s_no_pos_dup}"
❯ s_no_bio_dup=$(( s_no_pos_dup - s_no_umi_dup ))  # echo "${s_no_bio_dup}"
❯ s_no_inval_dup=$(( s_no_umi_dup ))  # echo "${s_no_inval_dup}"

❯ echo "sample"$'\t'"no_pos_dup"$'\t'"no_bio_dup"$'\t'"no_inval_dup"
❯ echo "5781_Q_Is_UT.primary-secondary"$'\t'"${ps_no_pos_dup}"$'\t'"${ps_no_bio_dup}"$'\t'"${ps_no_inval_dup}"
❯ echo "5781_Q_Is_UT.primary"$'\t'"${p_no_pos_dup}"$'\t'"${p_no_bio_dup}"$'\t'"${p_no_inval_dup}"
❯ echo "5781_Q_Is_UT.secondary"$'\t'"${s_no_pos_dup}"$'\t'"${s_no_bio_dup}"$'\t'"${s_no_inval_dup}"

sample	no_pos_dup	no_bio_dup	no_inval_dup
5781_Q_Is_UT.primary-secondary	465261	402949	62312
5781_Q_Is_UT.primary	182754	147454	35300
5781_Q_Is_UT.secondary	211838	196935	14903

❯ echo $(( 182754 + 211838 ))
394592
❯ echo $(( 147454 + 196935 ))
344389
❯ echo $(( 35300 + 14903 ))
50203
```
</details>
<br />
<br />

<a id="having-broke-things-down-a-question"></a>
## Having broke things down, a question
...about `umi_tools` and secondary alignments

Posed a question to the authors of `umi_tools` [here](https://github.com/CGATOxford/UMI-tools/issues/574)

<a id="message"></a>
### Message
<details>
<summary><i>Message: Having broke things down, a question about umi_tools and secondary alignments</i></summary>

> Examining the flags in bams (bulk RNA-seq, paired-end sequencing) composed of only (a) "proper" primary alignments, (b) both "proper" primary and secondary alignments, and (c) only "proper" secondary alignments, it looks like the multimappers are deduplicated along with the primary alignments, but pair status seems to not be maintained for primary and secondary alignments in the bam outfiles for (b) and (c). Why is this? Is there a way to call `umi_tools dedup` so that, when secondary alignments are present, the pair status is maintained?
> <br />
> <br />
> (column 1: counts; column 2: bam flag)
```txt
# (a) primary alignments ----------------------------------
# infile (not deduplicated)
test_umi-tools-dedup/5781_Q_Is_UT.primary.list-tally-flags.txt 
1033332 83
1033332 163
1011879 99
1011879 147

# UMI deduplication (method: directional)
test_umi-tools-dedup/5781_Q_Is_UT.primary.UMI-dedu.list-tally-flags.txt 
1024479 83
1024479 163
1003082 99
1003082 147

# "positional" deduplication (--ignore-umi)
test_umi-tools-dedup/5781_Q_Is_UT.primary.pos-dedu.list-tally-flags.txt 
 979507 83
 979507 163
 974327 99
 974327 147


# (b) primary and secondary alignments --------------------
# infile (not deduplicated)
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355

# UMI deduplication (method: directional)
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.UMI-dedu.list-tally-flags.txt
1023714 163
1023516 83
1002890 147
1002695 99
 286338 339
 277696 419
  52292 355
  43349 403

# "positional" deduplication (--ignore-umi)
test_umi-tools-dedup/5781_Q_Is_UT.primary-secondary.pos-dedu.list-tally-flags.txt
 973699 147
 973501 99
 962868 163
 962657 83
 177502 339
 169071 419
  49472 355
  40771 403


# (c) secondary alignments --------------------------------
# infile (not deduplicated)
test_umi-tools-dedup/5781_Q_Is_UT.secondary.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

# UMI deduplication (method: directional)
test_umi-tools-dedup/5781_Q_Is_UT.secondary.UMI-dedu.list-tally-flags.txt
 287206 339
 282219 419
  52414 355
  47638 403

# "positional" deduplication (--ignore-umi)
test_umi-tools-dedup/5781_Q_Is_UT.secondary.pos-dedu.list-tally-flags.txt
 190976 339
 186087 419
  50084 355
  45395 403
```
> How I did UMI deduplication (directional)
```bash
umi_tools dedup \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin={b_infile} \
    --stdout={b_umi_dedu} \
    --temp-dir={scratch} \
    --output-stats={b_umi_stats} \
    --log={b_umi_log} \
    --error={b_umi_error} \
    --timeit={b_umi_timeit} \
    --timeit-header
```
> How I did positional deduplication 
```bash
umi_tools dedup \
    --ignore-umi \
    --paired \
    --spliced-is-unique \
    --unmapped-reads=discard \
    --stdin={b_infile} \
    --stdout={b_pos_dedu} \
    --temp-dir={scratch} \
    --log={b_pos_log} \
    --error={b_pos_error} \
    --timeit={b_pos_timeit} \
    --timeit-header
```
</details>
<br />

<a id="run-umi_tools-dedup-again-but-add---unpaired-readsdiscard"></a>
## Run `umi_tools dedup` again, but add `--unpaired-reads=discard`
<a id="code-5"></a>
### Code
<details>
<summary><i>Code: Run umi_tools dedup again, but add --unpaired-reads=discard</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Clean up the test directory
cd test_umi-tools-dedup/
mkdir run_1/
mv *.{bam,txt,tsv} run_1/
cd ..

#  Establish an outdirectory for test outfiles
outdir="test_umi-tools-dedup/run_2"
mkdir "${outdir}"

unset infiles
typeset -a infiles
while IFS=" " read -r -d $'\0'; do
    infiles+=( "${REPLY}" )
done < <(\
    find "test_separate-bam/separate_bam_v2" \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
# echo_test "${infiles[@]}"
# echo "${#infiles[@]}"

#  Variable for TMPDIR
scratch="/fh/scratch/delete30/tsukiyama_t"

#  Establish specific arrays for running GNU parallel
unset b_umi_dedu
unset b_umi_stats
unset b_umi_log
unset b_umi_error
unset b_umi_timeit
unset b_pos_dedu
unset b_pos_log
unset b_pos_error
unset b_pos_timeit

typeset -a b_umi_dedu
typeset -a b_umi_stats
typeset -a b_umi_log
typeset -a b_umi_error
typeset -a b_umi_timeit
typeset -a b_pos_dedu
typeset -a b_pos_log
typeset -a b_pos_error
typeset -a b_pos_timeit

for i in "${infiles[@]}"; do
    b_umi_dedu+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.bam" )
    b_umi_stats+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.stats" )
    b_umi_log+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.stdout.txt" )
    b_umi_error+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.stderr.txt" )
    b_umi_timeit+=( "${outdir}/$(basename "${i}" .bam).UMI-dedu.time.txt" )
    
    b_pos_dedu+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.bam" )
    b_pos_log+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.stdout.txt" )
    b_pos_error+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.stderr.txt" )
    b_pos_timeit+=( "${outdir}/$(basename "${i}" .bam).pos-dedu.time.txt" )
done

echo_test "${infiles[@]}"
echo_test "${b_umi_dedu[@]}"
echo_test "${b_umi_stats[@]}"
echo_test "${b_umi_log[@]}"
echo_test "${b_umi_error[@]}"
echo_test "${b_umi_timeit[@]}"

echo_test "${infiles[@]}"
echo_test "${b_pos_dedu[@]}"
echo_test "${b_pos_log[@]}"
echo_test "${b_pos_error[@]}"
echo_test "${b_pos_timeit[@]}"

#  Echo tests
parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    echo \
        'umi_tools dedup \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --unpaired-reads=discard \
            --stdin={b_infile} \
            --stdout={b_umi_dedu} \
            --temp-dir={scratch} \
            --output-stats={b_umi_stats} \
            --log={b_umi_log} \
            --error={b_umi_error} \
            --timeit={b_umi_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_umi_dedu "${b_umi_dedu[@]}" \
:::+ b_umi_stats "${b_umi_stats[@]}" \
:::+ b_umi_log "${b_umi_log[@]}" \
:::+ b_umi_error "${b_umi_error[@]}" \
:::+ b_umi_timeit "${b_umi_timeit[@]}" \
::: scratch "${scratch}"

parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
    echo \
        'umi_tools dedup \
            --ignore-umi \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --unpaired-reads=discard \
            --stdin={b_infile} \
            --stdout={b_pos_dedu} \
            --temp-dir={scratch} \
            --log={b_pos_log} \
            --error={b_pos_error} \
            --timeit={b_pos_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_pos_dedu "${b_pos_dedu[@]}" \
:::+ b_pos_log "${b_pos_log[@]}" \
:::+ b_pos_error "${b_pos_error[@]}" \
:::+ b_pos_timeit "${b_pos_timeit[@]}" \
::: scratch "${scratch}"

#  Run
parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
        'umi_tools dedup \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --stdin={b_infile} \
            --stdout={b_umi_dedu} \
            --temp-dir={scratch} \
            --output-stats={b_umi_stats} \
            --log={b_umi_log} \
            --error={b_umi_error} \
            --timeit={b_umi_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_umi_dedu "${b_umi_dedu[@]}" \
:::+ b_umi_stats "${b_umi_stats[@]}" \
:::+ b_umi_log "${b_umi_log[@]}" \
:::+ b_umi_error "${b_umi_error[@]}" \
:::+ b_umi_timeit "${b_umi_timeit[@]}" \
::: scratch "${scratch}"

parallel \
    --header : \
    --colsep " " \
    -k \
    -j "${SLURM_CPUS_ON_NODE}" \
        'umi_tools dedup \
            --ignore-umi \
            --paired \
            --spliced-is-unique \
            --unmapped-reads=discard \
            --stdin={b_infile} \
            --stdout={b_pos_dedu} \
            --temp-dir={scratch} \
            --log={b_pos_log} \
            --error={b_pos_error} \
            --timeit={b_pos_timeit} \
            --timeit-header' \
::: b_infile "${infiles[@]}" \
:::+ b_pos_dedu "${b_pos_dedu[@]}" \
:::+ b_pos_log "${b_pos_log[@]}" \
:::+ b_pos_error "${b_pos_error[@]}" \
:::+ b_pos_timeit "${b_pos_timeit[@]}" \
::: scratch "${scratch}"


#  Get files of interest into arrays (part 1)
unset infiles_in
typeset -a infiles_in
while IFS=" " read -r -d $'\0'; do
    infiles_in+=( "${REPLY}" )
done < <(\
    find "test_separate-bam/separate_bam_v2" \
        -type f \
        -name *.bam \
        -print0 \
            | sort -z \
)
echo_test "${infiles_in[@]}"
echo "${#infiles_in[@]}"

unset infiles_out
typeset -a infiles_out
while IFS=" " read -r -d $'\0'; do
    infiles_out+=( "${REPLY}" )
done < <(\
    find "test_umi-tools-dedup/run_2" \
        -type f \
        -name *".bam" \
        -print0 \
            | sort -z \
)
echo_test "${infiles_out[@]}"
echo "${#infiles_out[@]}"


#  Check on things (part 1)
for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
    echo "${i}"$'\t'$(samtools view -c "${i}")
done

for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
	list_tally_flags \
		"${i}" \
		"${outdir}/$(basename "${i}" .bam).list-tally-flags.txt"
done  # (not copying stdout below)


#  Get files of interest into arrays (part 2)
unset infiles_ltf
typeset -a infiles_ltf
while IFS=" " read -r -d $'\0'; do
    infiles_ltf+=( "${REPLY}" )
done < <(\
    find "test_umi-tools-dedup/run_2" \
        -type f \
        -name *.list-tally-flags.txt \
        -print0 \
            | sort -z \
)
echo_test "${infiles_ltf[@]}"
echo "${#infiles_ltf[@]}"

#  Check on things (part 2)
for i in "${infiles_ltf[@]}"; do
	echo "${i}"
	cat "${i}"
	echo ""
done

for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
    echo "${i}"
    samtools view "${i}" | head
    echo ""
done
```
</details>
<br />

<a id="selected-cleaned-up-printed-output"></a>
### Selected, cleaned-up printed output
<details>
<summary><i>Selected, cleaned-up printed output: Run umi_tools dedup again, but add --unpaired-reads=discard</i></summary>

```txt
❯ for i in "${infiles_in[@]}" "${infiles_out[@]}"; do
>     echo "${i}"$'\t'$(samtools view -c "${i}")
> done

test_separate-bam/separate_bam_v2/5781_Q_IP_UT.primary.bam	4090422
test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary.UMI-dedu.bam	4055122
test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary.pos-dedu.bam	3907668

test_separate-bam/separate_bam_v2/5781_Q_IP_UT.primary-secondary.bam	4774802
test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary-secondary.pos-dedu.bam	4309539
test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary-secondary.UMI-dedu.bam	4712485

test_separate-bam/separate_bam_v2/5781_Q_IP_UT.secondary.bam	684380
test_umi-tools-dedup/run_2/5781_Q_IP_UT.secondary.UMI-dedu.bam	669480
test_umi-tools-dedup/run_2/5781_Q_IP_UT.secondary.pos-dedu.bam	472540

test_separate-bam/separate_bam_v2/5781_Q_IP_UT.unmapped.bam	227242
test_umi-tools-dedup/run_2/5781_Q_IP_UT.unmapped.UMI-dedu.bam	35433
test_umi-tools-dedup/run_2/5781_Q_IP_UT.unmapped.pos-dedu.bam	33794


❯ for i in "${infiles_ltf[@]}"; do
>     echo "${i}"
>     cat "${i}"
>     echo ""
> done
test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147

test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary.UMI-dedu.list-tally-flags.txt
1024479 83
1024479 163
1003082 99
1003082 147

test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary.pos-dedu.list-tally-flags.txt
 979507 83
 979507 163
 974327 99
 974327 147


test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary-secondary.list-tally-flags.txt
1033332 83
1033332 163
1011879 99
1011879 147
 289272 419
 289272 339
  52918 403
  52918 355

test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary-secondary.UMI-dedu.list-tally-flags.txt
1023710 163
1023513 83
1002886 147
1002695 99
 286341 339
 277700 419
  52292 355
  43348 403

test_umi-tools-dedup/run_2/5781_Q_IP_UT.primary-secondary.pos-dedu.list-tally-flags.txt
 973674 147
 973477 99
 962895 163
 962692 83
 177467 339
 169041 419
  49496 355
  40797 403


test_umi-tools-dedup/run_2/5781_Q_IP_UT.secondary.list-tally-flags.txt
 289272 419
 289272 339
  52918 403
  52918 355

test_umi-tools-dedup/run_2/5781_Q_IP_UT.secondary.UMI-dedu.list-tally-flags.txt
 287206 339
 282218 419
  52414 355
  47642 403

test_umi-tools-dedup/run_2/5781_Q_IP_UT.secondary.pos-dedu.list-tally-flags.txt
 190976 339
 186086 419
  50084 355
  45394 403


test_umi-tools-dedup/run_2/5781_Q_IP_UT.unmapped.list-tally-flags.txt
  74223 77
  74223 141
  18512 165
  18511 89
  17012 73
  17012 133
   1965 137
   1960 69
   1915 101
   1909 153

test_umi-tools-dedup/run_2/5781_Q_IP_UT.unmapped.UMI-dedu.list-tally-flags.txt
  18457 89
  16976 73

test_umi-tools-dedup/run_2/5781_Q_IP_UT.unmapped.pos-dedu.list-tally-flags.txt
  17340 89
  16454 73
```
</details>
<br />
<br />

<a id="so-where-does-this-leave-us"></a>
## So, where does this leave us?
<a id="review-nextsteps-from-test_separate-bammd"></a>
### Review `#NEXTSTEP`s from `test_separate-bam.md`
<a id="notes"></a>
#### Notes
<details>
<summary><i>Notes: Review #NEXTSTEPs from test_separate-bam.md</i></summary>

[Here](./test_separate-bam.md#observations-nextsteps), I wrote
> \[P\]erform `umi_tools dedup` experiments (determine if `.primary-secondary.` is properly handled; if not, then move forward with `.primary.` and determine the logic/steps for getting `.secondary.` back into the bam prior to running Trinity in genome-guided mode)

And
> \[W\]ork out the logic for, ultimately, what files need to undergo what to be adequate input for (a) 4tU-/RNA-seq analyses, (b) running Trinity in genome-free mode, and (c) running Trinity in genome-guided mode

So, for the time being, we see that `.primary-secondary.` and `.secondary.` are not appropriately handled in UMI (and positional) deduplication*; therefore, do UMI deduplication of `.primary.` only

\* This, it turns out, is because of the SAM specification itself; see [here](https://github.com/CGATOxford/UMI-tools/issues/574#issuecomment-1427675130)
</details>
<br />

<a id="moving-forward-option-1-deduplicate-primary-alignments-for-use-with-trinity"></a>
### Moving forward: Option 1: Deduplicate primary alignments for use with `Trinity`
<a id="notes-1"></a>
#### Notes
<details>
<summary><i>Notes: Moving forward: Option 1: Deduplicate primary alignments for use with Trinity</i></summary>

When calling `separate_bam.sh`, there's no longer a need to output a `.primary-secondary.` file (unless we decide not to do UMI deduplication, in which case we can use the `.primary-secondary.` file as input to Trinity genome-guided mode)

Thus, when calling `separate_bam.sh`, output the following:
- `.primary.`, which will be used as input for UMI deduplication, resulting in a `.primary.UMI-dedu.` file
- `.secondary.`, which will be `samtools merge`d with an appropriately processed `.primary.UMI-dedu.` to create a `.primary.UMI-dedu.secondary.` for use with Trinity genome-guided mode
- `.unmapped.`, which will be `samtools merge`d with an appropriately processed `.primary.UMI-dedu.` to create a `.primary.UMI-dedu.unmapped.` for use with Trinity genome-guided mode following bam-to-fastq conversion

To implement all of this for Trinity genome-{free,guided} mode, it's going to be perhaps more trouble than it's perhaps worth...
</details>
<br />

<a id="moving-forward-option-2-dont-deduplicate-primary-alignments-for-use-with-trinity"></a>
### Moving forward: Option 2: *Don't* deduplicate primary alignments for use with `Trinity`
<a id="notes-2"></a>
#### Notes
<details>
<summary><i>Notes: Moving forward: Option 2: Don't deduplicate primary alignments for use with Trinity</i></summary>

___Don't bother with UMI deduplication for the Trinity infiles;___ as a result, don't output the `.unmapped.` file

Thus, when calling `separate_bam.sh`, output the following:
- `.primary.`,
    + ...which will still be used as input for UMI deduplication,
    + ...resulting in a `.primary.UMI-dedu.` file
        * `.primary.UMI-dedu.` will be further processed for general 4tU-/RNA-seq work by removing *20S* alignments
        * The processed `.primary.UMI-dedu.` file ___will not___ be used for building transcriptomes with Trinity (and perhaps other transcriptome-assembly programs)
	+ Note that we want to keep the *K. lactis* alignments within the processed `.primary.UMI-dedu.` file for use in `DESeq2` normalization
        * Then, we will remove the *K. lactis* alignments prior to `DESeq2` statistical tests
        * Ultimately, I think it's OK for the *K. lactis* alignments to be in the bam when making genome-browser tracks
            - For other kinds of analyses that make use of the processed `.primary.UMI-dedu.` file, we'll want to be careful that we're subsetting to only *S. cerevisiae* information
- `.primary-secondary.`, which will be used as input for Trinity genome-guided mode
    + Exclude *K. lactis* and *20S* alignments
    + `samtools merge` resulting bam with replicate bam(s) that are also
        * ...`.primary-secondary.`
        * ...and subject to *K. lactis* and *20S* alignment exclusion
- To obtain files for use as input to Trinity genome-free mode, ~~start with the unseparated bam (i.e., the bam used as input to `separate_bam.sh`)~~*Can't because it contains multimappers*; so, instead, start with `.proper-etc.`, which contains primary alignments along with non-secondary singletons and unmapped reads
    + Exclude *K. lactis* and *20S* alignments
    + Convert the resulting bam to fastq
    + Use paired-end fastqs, together with paired-end fastqs derived from processed *replicate* bams, as input for Trinity genome-free mode

</details>
<br />

<a id="next-steps"></a>
### Next steps
- Move forward with option 2: <u><b>Don't bother with UMI deduplication for the Trinity infiles</b></u>
- Run `separate_bam.sh` to output `.primary.`, `.primary-secondary.`, `.proper-etc.` files
    + 4tU-/RNA-seq work
        * `.primary.`
            - [x] <mark>___Get these files for all 55 samples___</mark>
            - [x] <b><i>Use <mark>UT</mark> bam infiles</i></b>
            - [x] Perform UMI and positional deduplication on the `.primary.` files, collecting stats on the numbers of positional duplicates
                + [ ] Once statistics are collected and properly recorded, delete the position-deduplicated outfiles to save space *(hang on to them for a bit to do at least some of the below)*
                    * Number of lines in UMI- and position-deduplicated outfiles
                    * [ ] `samtools index` of the outfiles
                    * [ ] `samtools stats` of the outfiles
                    * [ ] `samtools flagstat` of the outfiles
                    * [ ] `samtools idxstats` of the outfiles
                    * [ ] `picard MarkDuplicates` of at least the UMI-deduplicated outfile
            - Use the UMI-deduplicated bams as input for the following steps (output of one step is used as input for the next)
                + [x] ~~Exclude *20S* alignments (make bams of only 20S alignments for AG's future work)~~ `#NOTE` *Actually, we can just leave 20S in there* (will need to take the same considerations for downstream as we would with the *K. lactis* information; of course, don't use *20S* for `DESeq2` analyses)
                + [ ] Count alignments to features (e.g., `htseq-count` or `featureCounts` with respect to AG's combined `gtf`)
                + [ ] Perform `DESeq2` size-factor normalization
                + [ ] Having obtained size factors, filter out the *K. lactis* information prior to `DESeq2` assignment of q-values
    + Trinity work
        * genome-guided assembly
            - `.primary-secondary.`
                + [x] ___Don't___ do UMI deduplication of the `.primary-secondary.` files
                + [x] ___<mark>Only need `.primary-secondary.` for the `578{1,2}` bams</mark> from <mark>UTK</mark> bam infiles___
                    * [x] Exclude *K. lactis* and *20S* alignments
                    * [ ] `samtools merge` resulting bam with replicate bam(s) that are also
                        - ...`.primary-secondary.`
                        - ...and subject to *K. lactis* and *20S* alignment exclusion
                    * [ ] Use the processed, merged bams as input for Trinity genome-guided mode
        * genome-free assembly
            - `.proper-etc.`
                + [x] ~~Use the "unseparated" bams for Trinity genome-free mode~~
                + [x] ___Don't___ do UMI deduplication of the `.proper-etc.` files
                + [x] ___<mark>Only need `.proper-etc.` `578{1,2}` bams</mark> from <mark>UTK</mark> bam infiles___
                    * [x] Exclude *K. lactis* and *20S* alignments
                    * [ ] Convert the resulting bam to fastq
                    * [ ] Use paired-end fastqs, together with paired-end fastqs from <u>processed *replicate* bams</u>, as input for Trinity genome-free mode

`#TOMORROW` Generate the `.primary.`, `.primary-secondary.`, and `.proper-etc.` files~~, and identify the appropiate "unseparated" bams for use~~
- Focus on processing the `.primary.`, `.primary-secondary.`, and `.proper-etc.` files, eventually using the for the submission of Trinity paramter-optimization jobs as described [here](../2023-0111/tutorial_job-arrays.md#write-out-the-list-ready-run-script-echo-test-using-a-heredoc-1) and [here](../2022-1101/notebook/trinity-parameters.xlsx)
- Will need to get together run and submission scripts for Trinity genome-guided calls, but already have the base scripts for Trinity genome-free calls, I think
