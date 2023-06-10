
`#work_calculate_uni-multimappers-etc.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Get situated](#get-situated)
    1. [Code](#code)
1. [For bams, collect metrics on unimappers, multimappers, etc.](#for-bams-collect-metrics-on-unimappers-multimappers-etc)
    1. [Set up outfile directories](#set-up-outfile-directories)
        1. [Code](#code-1)
    1. [Set up arrays of bams](#set-up-arrays-of-bams)
        1. [Code](#code-2)
    1. [Index bams](#index-bams)
        1. [Code](#code-3)
    1. [Collect metrics on unimappers, multimappers, etc.](#collect-metrics-on-unimappers-multimappers-etc)
        1. [Code](#code-4)
        1. [Printed](#printed)

<!-- /MarkdownTOC -->
</details>
<br />
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

grabnode  # 4, defaults
source activate gff3_env
ml SAMtools/1.16.1-GCC-11.2.0

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

.,
```
</details>
<br />

<a id="for-bams-collect-metrics-on-unimappers-multimappers-etc"></a>
## For bams, collect metrics on unimappers, multimappers, etc.
<a id="set-up-outfile-directories"></a>
### Set up outfile directories
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash

for h in ./outfiles_htseq-count/already/combined-SC-KL-20S/U*; do
    if [[ ! -e "${h}" ]]; then
        mkdir -p outfiles_htseq-count
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
<summary><i>Code: Set up arrays</i></summary>

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
```
</details>
<br />

<a id="index-bams"></a>
### Index bams
<a id="code-3"></a>
#### Code
<details>
<summary><i>Code: Index all bams in arrays</i></summary>

```bash
#!/bin/bash

for h in ./bams_renamed/UT_prim_UMI/*.bai; do
    if [[ ! -e "${h}" ]]; then
        for i in "${UT_prim_UMI[@]}"; do
                echo "Indexing ${i}"
                samtools index -@ "${SLURM_CPUS_ON_NODE}" "${i}"
                echo ""
        done
    else
        echo "Bam indices exist; skipping the running of samtools index"
    fi

    break
done
```
</details>
<br />

<a id="collect-metrics-on-unimappers-multimappers-etc"></a>
### Collect metrics on unimappers, multimappers, etc.
<a id="code-4"></a>
#### Code
<details>
<summary><i>Code: Collect metrics on unimappers, multimappers, etc.</i></summary>

```bash
#!/bin/bash

if [[ -f outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt ]]; then
    rm outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt
fi

echo \
    "sample"$'\t'"sample_total"$'\t'"Mito-KL-20S_all"$'\t'"Mito-KL-20S_uni"$'\t'"Mito-KL-20S_multi"$'\t'"SC-I-XVI_all"$'\t'"SC-I-XVI_uni"$'\t'"SC-I-XVI_multi" \
        > outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt

for i in "${UT_prim_UMI[@]}"; do
    # i="${UT_prim_UMI[0]}"  # echo "${i}"
    
    #  Get sample name
    c_name="$(basename "${i}" ".UT_prim_UMI.bam")"  # echo "${c_name}"
    
    #  Get total number of counts (read pairs) for sample
    unset tmp
    tmp="$(samtools view -c "${i}")"  # echo "${tmp}"
    c_all=$(( tmp / 2 ))  # echo "${c_all}"

    #  Calculate number of unimappers for non-I-XIV chromosomes
    unset tmp
    tmp="$(
        samtools view -@ "${SLURM_CPUS_ON_NODE}" \
            "${i}" \
            Mito A B C D E F 20S \
                | awk '/\<NH:i:1\>/' \
                | wc -l
    )"  # echo "${tmp}"
    c_MK2_uni=$(( tmp / 2 ))  # echo "${c_MK2_uni}"

    #  Calculate number of multimappers for non-I-XIV chromosomes
    unset tmp
    tmp="$(
        samtools view -@ "${SLURM_CPUS_ON_NODE}" \
            "${i}" \
            Mito A B C D E F 20S \
                | awk '!/\<NH:i:1\>/' \
                | wc -l
    )"  # echo "${tmp}"
    c_MK2_multi=$(( tmp / 2 ))  # echo "${c_MK2_multi}"

    #  Get (and check) the sum of non-I-XIV chromosome counts
    c_MK2_sum=$(( c_MK2_uni + c_MK2_multi ))  # echo "${c_MK2_sum}"
    c_MK2_sum_check="$(
        samtools view -@ "${SLURM_CPUS_ON_NODE}" -c \
            "${i}" \
            Mito A B C D E F 20S
    )"  # echo "${c_MK2_sum_check}"
    [[ $(( c_MK2_sum_check / 2 )) -eq c_MK2_sum ]] ||
        {
            echo "Values are not equal; check on this..."
            return 1
        }

    #  Calculate number of unimappers for I-XIV chromosomes
    unset tmp
    tmp="$(
        samtools view -@ "${SLURM_CPUS_ON_NODE}" \
            "${i}" \
            I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
                | awk '/\<NH:i:1\>/' \
                | wc -l
    )"  # echo "${tmp}"
    c_chr_uni=$(( tmp / 2 ))  # echo "${c_chr_uni}"

    #  Calculate number of multimappers for I-XIV chromosomes
    unset tmp
    tmp="$(
        samtools view -@ "${SLURM_CPUS_ON_NODE}" \
            "${i}" \
            I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
                | awk '!/\<NH:i:1\>/' \
                | wc -l
    )"  # echo "${tmp}"
    c_chr_multi=$(( tmp / 2 ))  # echo "${c_chr_multi}"

    #  Get (and check) the sum of I-XIV chromosome counts
    c_chr_sum=$(( c_chr_uni + c_chr_multi ))  # echo "${c_chr_sum}"
    c_chr_sum_check="$(
        samtools view -@ "${SLURM_CPUS_ON_NODE}" -c \
            "${i}" \
            I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI
        )"  # echo "${c_chr_sum_check}"
    [[ $(( c_chr_sum_check / 2 )) -eq c_chr_sum ]] ||
        {
            echo "Values are not equal; check on this..."
            return 1
        }

    echo "Writing to dataframe..."
    echo "         c_name  ${c_name}"
    echo "          c_all  ${c_all}"
    echo "      c_MK2_uni  ${c_MK2_uni}"
    echo "    c_MK2_multi  ${c_MK2_multi}"
    echo "      c_MK2_sum  ${c_MK2_sum}"
    echo "c_MK2_sum_check  ${c_MK2_sum_check}"
    echo "      c_chr_uni  ${c_chr_uni}"
    echo "    c_chr_multi  ${c_chr_multi}"
    echo "      c_chr_sum  ${c_chr_sum}"
    echo "c_chr_sum_check  ${c_chr_sum_check}"
    echo ""

    echo \
        "${c_name}"$'\t'"${c_all}"$'\t'"${c_MK2_sum}"$'\t'"${c_MK2_uni}"$'\t'"${c_MK2_multi}"$'\t'"${c_chr_sum}"$'\t'"${c_chr_uni}"$'\t'"${c_chr_multi}" \
            >> outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt
done

cat outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt
```
</details>
<br />

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed: Collect metrics on unimappers, multimappers, etc.</i></summary>

```txt
❯ for i in "${UT_prim_UMI[@]}"; do
>     # i="${UT_prim_UMI[0]}"  # echo "${i}"
> 
>     #  Get sample name
>     c_name="$(basename "${i}" ".UT_prim_UMI.bam")"  # echo "${c_name}"
> 
>     #  Get total number of counts (read pairs) for sample
>     unset tmp
>     tmp="$(samtools view -c "${i}")"  # echo "${tmp}"
>     c_all=$(( tmp / 2 ))  # echo "${c_all}"
> 
>     #  Calculate number of unimappers for non-I-XIV chromosomes
>     unset tmp
>     tmp="$(
>         samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>             "${i}" \
>             Mito A B C D E F 20S \
>                 | awk '/\<NH:i:1\>/' \
>                 | wc -l
>     )"  # echo "${tmp}"
>     c_MK2_uni=$(( tmp / 2 ))  # echo "${c_MK2_uni}"
> 
>     #  Calculate number of multimappers for non-I-XIV chromosomes
>     unset tmp
>     tmp="$(
>         samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>             "${i}" \
>             Mito A B C D E F 20S \
>                 | awk '!/\<NH:i:1\>/' \
>                 | wc -l
>     )"  # echo "${tmp}"
>     c_MK2_multi=$(( tmp / 2 ))  # echo "${c_MK2_multi}"
> 
>     #  Get (and check) the sum of non-I-XIV chromosome counts
>     c_MK2_sum=$(( c_MK2_uni + c_MK2_multi ))  # echo "${c_MK2_sum}"
>     c_MK2_sum_check="$(
>         samtools view -@ "${SLURM_CPUS_ON_NODE}" -c \
>             "${i}" \
>             Mito A B C D E F 20S
>     )"  # echo "${c_MK2_sum_check}"
>     [[ $(( c_MK2_sum_check / 2 )) -eq c_MK2_sum ]] ||
>         {
>             echo "Values are not equal; check on this..."
>             return 1
>         }
> 
>     #  Calculate number of unimappers for I-XIV chromosomes
>     unset tmp
>     tmp="$(
>         samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>             "${i}" \
>             I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
>                 | awk '/\<NH:i:1\>/' \
>                 | wc -l
>     )"  # echo "${tmp}"
>     c_chr_uni=$(( tmp / 2 ))  # echo "${c_chr_uni}"
> 
>     #  Calculate number of multimappers for I-XIV chromosomes
>     unset tmp
>     tmp="$(
>         samtools view -@ "${SLURM_CPUS_ON_NODE}" \
>             "${i}" \
>             I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI \
>                 | awk '!/\<NH:i:1\>/' \
>                 | wc -l
>     )"  # echo "${tmp}"
>     c_chr_multi=$(( tmp / 2 ))  # echo "${c_chr_multi}"
> 
>     #  Get (and check) the sum of I-XIV chromosome counts
>     c_chr_sum=$(( c_chr_uni + c_chr_multi ))  # echo "${c_chr_sum}"
>     c_chr_sum_check="$(
>         samtools view -@ "${SLURM_CPUS_ON_NODE}" -c \
>             "${i}" \
>             I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI
>         )"  # echo "${c_chr_sum_check}"
>     [[ $(( c_chr_sum_check / 2 )) -eq c_chr_sum ]] ||
>         {
>             echo "Values are not equal; check on this..."
>             return 1
>         }
> 
>     echo "Writing to dataframe..."
>     echo "         c_name  ${c_name}"
>     echo "          c_all  ${c_all}"
>     echo "      c_MK2_uni  ${c_MK2_uni}"
>     echo "    c_MK2_multi  ${c_MK2_multi}"
>     echo "      c_MK2_sum  ${c_MK2_sum}"
>     echo "c_MK2_sum_check  ${c_MK2_sum_check}"
>     echo "      c_chr_uni  ${c_chr_uni}"
>     echo "    c_chr_multi  ${c_chr_multi}"
>     echo "      c_chr_sum  ${c_chr_sum}"
>     echo "c_chr_sum_check  ${c_chr_sum_check}"
>     echo ""
> 
>     echo \
>         "${c_name}"$'\t'"${c_all}"$'\t'"${c_MK2_sum}"$'\t'"${c_MK2_uni}"$'\t'"${c_MK2_multi}"$'\t'"${c_chr_sum}"$'\t'"${c_chr_uni}"$'\t'"${c_chr_multi}" \
>             >> outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt
> done
Writing to dataframe...
         c_name  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1
          c_all  28593750
      c_MK2_uni  13723802
    c_MK2_multi  2116564
      c_MK2_sum  15840366
c_MK2_sum_check  31680732
      c_chr_uni  9618005
    c_chr_multi  3135379
      c_chr_sum  12753384
c_chr_sum_check  25506768

Writing to dataframe...
         c_name  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1
          c_all  29274110
      c_MK2_uni  15496048
    c_MK2_multi  2628223
      c_MK2_sum  18124271
c_MK2_sum_check  36248542
      c_chr_uni  7740567
    c_chr_multi  3409272
      c_chr_sum  11149839
c_chr_sum_check  22299678

Writing to dataframe...
         c_name  n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1
          c_all  32294104
      c_MK2_uni  14561827
    c_MK2_multi  2808044
      c_MK2_sum  17369871
c_MK2_sum_check  34739742
      c_chr_uni  10839993
    c_chr_multi  4084240
      c_chr_sum  14924233
c_chr_sum_check  29848466

Writing to dataframe...
         c_name  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1
          c_all  29462906
      c_MK2_uni  17008920
    c_MK2_multi  1889446
      c_MK2_sum  18898366
c_MK2_sum_check  37796732
      c_chr_uni  5254921
    c_chr_multi  5309619
      c_chr_sum  10564540
c_chr_sum_check  21129080

Writing to dataframe...
         c_name  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1
          c_all  30485089
      c_MK2_uni  18942478
    c_MK2_multi  2022018
      c_MK2_sum  20964496
c_MK2_sum_check  41928992
      c_chr_uni  4284572
    c_chr_multi  5236021
      c_chr_sum  9520593
c_chr_sum_check  19041186

Writing to dataframe...
         c_name  n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1
          c_all  24769078
      c_MK2_uni  14275293
    c_MK2_multi  1712857
      c_MK2_sum  15988150
c_MK2_sum_check  31976300
      c_chr_uni  4164893
    c_chr_multi  4616035
      c_chr_sum  8780928
c_chr_sum_check  17561856

Writing to dataframe...
         c_name  o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1
          c_all  26199413
      c_MK2_uni  14487580
    c_MK2_multi  2574502
      c_MK2_sum  17062082
c_MK2_sum_check  34124164
      c_chr_uni  5897639
    c_chr_multi  3239692
      c_chr_sum  9137331
c_chr_sum_check  18274662

Writing to dataframe...
         c_name  o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1
          c_all  25614430
      c_MK2_uni  15243591
    c_MK2_multi  2613757
      c_MK2_sum  17857348
c_MK2_sum_check  35714696
      c_chr_uni  4329477
    c_chr_multi  3427605
      c_chr_sum  7757082
c_chr_sum_check  15514164

Writing to dataframe...
         c_name  o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1
          c_all  27546890
      c_MK2_uni  11997347
    c_MK2_multi  3331932
      c_MK2_sum  15329279
c_MK2_sum_check  30658558
      c_chr_uni  3428982
    c_chr_multi  8788629
      c_chr_sum  12217611
c_chr_sum_check  24435222

Writing to dataframe...
         c_name  o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1
          c_all  27650067
      c_MK2_uni  13663469
    c_MK2_multi  2765487
      c_MK2_sum  16428956
c_MK2_sum_check  32857912
      c_chr_uni  3564552
    c_chr_multi  7656559
      c_chr_sum  11221111
c_chr_sum_check  22442222

Writing to dataframe...
         c_name  r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1
          c_all  26074381
      c_MK2_uni  10085027
    c_MK2_multi  1957967
      c_MK2_sum  12042994
c_MK2_sum_check  24085988
      c_chr_uni  10241422
    c_chr_multi  3789965
      c_chr_sum  14031387
c_chr_sum_check  28062774

Writing to dataframe...
         c_name  r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1
          c_all  27859800
      c_MK2_uni  10797819
    c_MK2_multi  2237951
      c_MK2_sum  13035770
c_MK2_sum_check  26071540
      c_chr_uni  10653110
    c_chr_multi  4170920
      c_chr_sum  14824030
c_chr_sum_check  29648060

Writing to dataframe...
         c_name  r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1
          c_all  28872243
      c_MK2_uni  16807216
    c_MK2_multi  2337439
      c_MK2_sum  19144655
c_MK2_sum_check  38289310
      c_chr_uni  3483824
    c_chr_multi  6243764
      c_chr_sum  9727588
c_chr_sum_check  19455176

Writing to dataframe...
         c_name  r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1
          c_all  26452129
      c_MK2_uni  16482900
    c_MK2_multi  1935679
      c_MK2_sum  18418579
c_MK2_sum_check  36837158
      c_chr_uni  2959398
    c_chr_multi  5074152
      c_chr_sum  8033550
c_chr_sum_check  16067100

Writing to dataframe...
         c_name  r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  14862518
      c_MK2_uni  1751924
    c_MK2_multi  2030973
      c_MK2_sum  3782897
c_MK2_sum_check  7565794
      c_chr_uni  7189320
    c_chr_multi  3890301
      c_chr_sum  11079621
c_chr_sum_check  22159242

Writing to dataframe...
         c_name  r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  18842139
      c_MK2_uni  2040193
    c_MK2_multi  2471007
      c_MK2_sum  4511200
c_MK2_sum_check  9022400
      c_chr_uni  9406289
    c_chr_multi  4924650
      c_chr_sum  14330939
c_chr_sum_check  28661878

Writing to dataframe...
         c_name  r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  14693909
      c_MK2_uni  3677835
    c_MK2_multi  2704814
      c_MK2_sum  6382649
c_MK2_sum_check  12765298
      c_chr_uni  4644448
    c_chr_multi  3666812
      c_chr_sum  8311260
c_chr_sum_check  16622520

Writing to dataframe...
         c_name  r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  17701239
      c_MK2_uni  4535393
    c_MK2_multi  3011644
      c_MK2_sum  7547037
c_MK2_sum_check  15094074
      c_chr_uni  6119775
    c_chr_multi  4034427
      c_chr_sum  10154202
c_chr_sum_check  20308404

Writing to dataframe...
         c_name  r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  17676487
      c_MK2_uni  2748189
    c_MK2_multi  2810627
      c_MK2_sum  5558816
c_MK2_sum_check  11117632
      c_chr_uni  7713092
    c_chr_multi  4404579
      c_chr_sum  12117671
c_chr_sum_check  24235342

Writing to dataframe...
         c_name  r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  18673410
      c_MK2_uni  2774145
    c_MK2_multi  2951215
      c_MK2_sum  5725360
c_MK2_sum_check  11450720
      c_chr_uni  8210263
    c_chr_multi  4737787
      c_chr_sum  12948050
c_chr_sum_check  25896100

Writing to dataframe...
         c_name  r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  20109413
      c_MK2_uni  8170752
    c_MK2_multi  3805030
      c_MK2_sum  11975782
c_MK2_sum_check  23951564
      c_chr_uni  3853707
    c_chr_multi  4279924
      c_chr_sum  8133631
c_chr_sum_check  16267262

Writing to dataframe...
         c_name  r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  27172906
      c_MK2_uni  7306541
    c_MK2_multi  7449306
      c_MK2_sum  14755847
c_MK2_sum_check  29511694
      c_chr_uni  3856299
    c_chr_multi  8560760
      c_chr_sum  12417059
c_chr_sum_check  24834118

Writing to dataframe...
         c_name  r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1
          c_all  26649217
      c_MK2_uni  2288830
    c_MK2_multi  4437167
      c_MK2_sum  6725997
c_MK2_sum_check  13451994
      c_chr_uni  10633162
    c_chr_multi  9290058
      c_chr_sum  19923220
c_chr_sum_check  39846440

Writing to dataframe...
         c_name  r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1
          c_all  26995608
      c_MK2_uni  2223334
    c_MK2_multi  4088070
      c_MK2_sum  6311404
c_MK2_sum_check  12622808
      c_chr_uni  11425076
    c_chr_multi  9259128
      c_chr_sum  20684204
c_chr_sum_check  41368408

Writing to dataframe...
         c_name  r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1
          c_all  28279689
      c_MK2_uni  9184377
    c_MK2_multi  1925200
      c_MK2_sum  11109577
c_MK2_sum_check  22219154
      c_chr_uni  13364739
    c_chr_multi  3805373
      c_chr_sum  17170112
c_chr_sum_check  34340224

Writing to dataframe...
         c_name  r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1
          c_all  27494489
      c_MK2_uni  10814101
    c_MK2_multi  2067684
      c_MK2_sum  12881785
c_MK2_sum_check  25763570
      c_chr_uni  10933792
    c_chr_multi  3678912
      c_chr_sum  14612704
c_chr_sum_check  29225408

Writing to dataframe...
         c_name  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1
          c_all  37273438
      c_MK2_uni  14994726
    c_MK2_multi  4637440
      c_MK2_sum  19632166
c_MK2_sum_check  39264332
      c_chr_uni  3932961
    c_chr_multi  13708311
      c_chr_sum  17641272
c_chr_sum_check  35282544

Writing to dataframe...
         c_name  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2
          c_all  31127425
      c_MK2_uni  12492174
    c_MK2_multi  3876582
      c_MK2_sum  16368756
c_MK2_sum_check  32737512
      c_chr_uni  3226890
    c_chr_multi  11531779
      c_chr_sum  14758669
c_chr_sum_check  29517338

Writing to dataframe...
         c_name  r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1
          c_all  29051610
      c_MK2_uni  16215412
    c_MK2_multi  2377581
      c_MK2_sum  18592993
c_MK2_sum_check  37185986
      c_chr_uni  4427289
    c_chr_multi  6031328
      c_chr_sum  10458617
c_chr_sum_check  20917234

Writing to dataframe...
         c_name  t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  18639826
      c_MK2_uni  1538212
    c_MK2_multi  2614833
      c_MK2_sum  4153045
c_MK2_sum_check  8306090
      c_chr_uni  8938957
    c_chr_multi  5547824
      c_chr_sum  14486781
c_chr_sum_check  28973562

Writing to dataframe...
         c_name  t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  17426630
      c_MK2_uni  1326048
    c_MK2_multi  2385541
      c_MK2_sum  3711589
c_MK2_sum_check  7423178
      c_chr_uni  8391340
    c_chr_multi  5323701
      c_chr_sum  13715041
c_chr_sum_check  27430082

Writing to dataframe...
         c_name  t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  19276505
      c_MK2_uni  5191638
    c_MK2_multi  3463960
      c_MK2_sum  8655598
c_MK2_sum_check  17311196
      c_chr_uni  6151066
    c_chr_multi  4469841
      c_chr_sum  10620907
c_chr_sum_check  21241814

Writing to dataframe...
         c_name  t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  19092950
      c_MK2_uni  5445342
    c_MK2_multi  3303184
      c_MK2_sum  8748526
c_MK2_sum_check  17497052
      c_chr_uni  6102549
    c_chr_multi  4241875
      c_chr_sum  10344424
c_chr_sum_check  20688848

Writing to dataframe...
         c_name  t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  20391336
      c_MK2_uni  2240497
    c_MK2_multi  3286534
      c_MK2_sum  5527031
c_MK2_sum_check  11054062
      c_chr_uni  8515633
    c_chr_multi  6348672
      c_chr_sum  14864305
c_chr_sum_check  29728610

Writing to dataframe...
         c_name  t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  20894588
      c_MK2_uni  2541675
    c_MK2_multi  3351411
      c_MK2_sum  5893086
c_MK2_sum_check  11786172
      c_chr_uni  9126826
    c_chr_multi  5874676
      c_chr_sum  15001502
c_chr_sum_check  30003004

Writing to dataframe...
         c_name  t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  17788422
      c_MK2_uni  7287411
    c_MK2_multi  3310517
      c_MK2_sum  10597928
c_MK2_sum_check  21195856
      c_chr_uni  3628475
    c_chr_multi  3562019
      c_chr_sum  7190494
c_chr_sum_check  14380988

Writing to dataframe...
         c_name  t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  19014451
      c_MK2_uni  8176542
    c_MK2_multi  3560371
      c_MK2_sum  11736913
c_MK2_sum_check  23473826
      c_chr_uni  3533077
    c_chr_multi  3744461
      c_chr_sum  7277538
c_chr_sum_check  14555076

Writing to dataframe...
         c_name  WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  17528651
      c_MK2_uni  1291305
    c_MK2_multi  2025142
      c_MK2_sum  3316447
c_MK2_sum_check  6632894
      c_chr_uni  9170938
    c_chr_multi  5041266
      c_chr_sum  14212204
c_chr_sum_check  28424408

Writing to dataframe...
         c_name  WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  14354209
      c_MK2_uni  1025775
    c_MK2_multi  1828444
      c_MK2_sum  2854219
c_MK2_sum_check  5708438
      c_chr_uni  6997554
    c_chr_multi  4502436
      c_chr_sum  11499990
c_chr_sum_check  22999980

Writing to dataframe...
         c_name  WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  17870971
      c_MK2_uni  4821046
    c_MK2_multi  3748328
      c_MK2_sum  8569374
c_MK2_sum_check  17138748
      c_chr_uni  4704206
    c_chr_multi  4597391
      c_chr_sum  9301597
c_chr_sum_check  18603194

Writing to dataframe...
         c_name  WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  18187692
      c_MK2_uni  4874871
    c_MK2_multi  3593595
      c_MK2_sum  8468466
c_MK2_sum_check  16936932
      c_chr_uni  5105886
    c_chr_multi  4613340
      c_chr_sum  9719226
c_chr_sum_check  19438452

Writing to dataframe...
         c_name  WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  16268286
      c_MK2_uni  2069852
    c_MK2_multi  2594807
      c_MK2_sum  4664659
c_MK2_sum_check  9329318
      c_chr_uni  6924408
    c_chr_multi  4679219
      c_chr_sum  11603627
c_chr_sum_check  23207254

Writing to dataframe...
         c_name  WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  18162697
      c_MK2_uni  2144943
    c_MK2_multi  3056330
      c_MK2_sum  5201273
c_MK2_sum_check  10402546
      c_chr_uni  7185078
    c_chr_multi  5776346
      c_chr_sum  12961424
c_chr_sum_check  25922848

Writing to dataframe...
         c_name  WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1
          c_all  18353221
      c_MK2_uni  7388417
    c_MK2_multi  3934090
      c_MK2_sum  11322507
c_MK2_sum_check  22645014
      c_chr_uni  2984238
    c_chr_multi  4046476
      c_chr_sum  7030714
c_chr_sum_check  14061428

Writing to dataframe...
         c_name  WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2
          c_all  29105695
      c_MK2_uni  8020750
    c_MK2_multi  8496223
      c_MK2_sum  16516973
c_MK2_sum_check  33033946
      c_chr_uni  3374316
    c_chr_multi  9214406
      c_chr_sum  12588722
c_chr_sum_check  25177444

Writing to dataframe...
         c_name  WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1
          c_all  16959938
      c_MK2_uni  7036884
    c_MK2_multi  3351052
      c_MK2_sum  10387936
c_MK2_sum_check  20775872
      c_chr_uni  2789045
    c_chr_multi  3782957
      c_chr_sum  6572002
c_chr_sum_check  13144004

Writing to dataframe...
         c_name  WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1
          c_all  15634566
      c_MK2_uni  353542
    c_MK2_multi  61849
      c_MK2_sum  415391
c_MK2_sum_check  830782
      c_chr_uni  13188385
    c_chr_multi  2030790
      c_chr_sum  15219175
c_chr_sum_check  30438350

Writing to dataframe...
         c_name  WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1
          c_all  15755143
      c_MK2_uni  625995
    c_MK2_multi  75139
      c_MK2_sum  701134
c_MK2_sum_check  1402268
      c_chr_uni  12953728
    c_chr_multi  2100281
      c_chr_sum  15054009
c_chr_sum_check  30108018

Writing to dataframe...
         c_name  WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1
          c_all  10723500
      c_MK2_uni  753929
    c_MK2_multi  570797
      c_MK2_sum  1324726
c_MK2_sum_check  2649452
      c_chr_uni  6619041
    c_chr_multi  2779733
      c_chr_sum  9398774
c_chr_sum_check  18797548

Writing to dataframe...
         c_name  WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1
          c_all  10009120
      c_MK2_uni  1042420
    c_MK2_multi  307317
      c_MK2_sum  1349737
c_MK2_sum_check  2699474
      c_chr_uni  6866366
    c_chr_multi  1793017
      c_chr_sum  8659383
c_chr_sum_check  17318766

Writing to dataframe...
         c_name  WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1
          c_all  25720373
      c_MK2_uni  1349853
    c_MK2_multi  4608823
      c_MK2_sum  5958676
c_MK2_sum_check  11917352
      c_chr_uni  8283008
    c_chr_multi  11478689
      c_chr_sum  19761697
c_chr_sum_check  39523394

Writing to dataframe...
         c_name  WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1
          c_all  24063950
      c_MK2_uni  1304628
    c_MK2_multi  4304410
      c_MK2_sum  5609038
c_MK2_sum_check  11218076
      c_chr_uni  7746887
    c_chr_multi  10708025
      c_chr_sum  18454912
c_chr_sum_check  36909824

Writing to dataframe...
         c_name  WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1
          c_all  18858614
      c_MK2_uni  8740540
    c_MK2_multi  585307
      c_MK2_sum  9325847
c_MK2_sum_check  18651694
      c_chr_uni  8502909
    c_chr_multi  1029858
      c_chr_sum  9532767
c_chr_sum_check  19065534

Writing to dataframe...
         c_name  WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1
          c_all  17445726
      c_MK2_uni  6353848
    c_MK2_multi  448111
      c_MK2_sum  6801959
c_MK2_sum_check  13603918
      c_chr_uni  9697530
    c_chr_multi  946237
      c_chr_sum  10643767
c_chr_sum_check  21287534

Writing to dataframe...
         c_name  WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1
          c_all  9515191
      c_MK2_uni  2553353
    c_MK2_multi  611511
      c_MK2_sum  3164864
c_MK2_sum_check  6329728
      c_chr_uni  4374618
    c_chr_multi  1975709
      c_chr_sum  6350327
c_chr_sum_check  12700654

Writing to dataframe...
         c_name  WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1
          c_all  8394823
      c_MK2_uni  2519133
    c_MK2_multi  611776
      c_MK2_sum  3130909
c_MK2_sum_check  6261818
      c_chr_uni  3403427
    c_chr_multi  1860487
      c_chr_sum  5263914
c_chr_sum_check  10527828

Writing to dataframe...
         c_name  WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1
          c_all  29909019
      c_MK2_uni  14119767
    c_MK2_multi  2239800
      c_MK2_sum  16359567
c_MK2_sum_check  32719134
      c_chr_uni  10065665
    c_chr_multi  3483787
      c_chr_sum  13549452
c_chr_sum_check  27098904

Writing to dataframe...
         c_name  WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1
          c_all  27062659
      c_MK2_uni  15976322
    c_MK2_multi  1965855
      c_MK2_sum  17942177
c_MK2_sum_check  35884354
      c_chr_uni  3997078
    c_chr_multi  5123404
      c_chr_sum  9120482
c_chr_sum_check  18240964

Writing to dataframe...
         c_name  WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1
          c_all  27401884
      c_MK2_uni  9789534
    c_MK2_multi  2039370
      c_MK2_sum  11828904
c_MK2_sum_check  23657808
      c_chr_uni  11645493
    c_chr_multi  3927487
      c_chr_sum  15572980
c_chr_sum_check  31145960

Writing to dataframe...
         c_name  WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1
          c_all  27455219
      c_MK2_uni  9649998
    c_MK2_multi  2213197
      c_MK2_sum  11863195
c_MK2_sum_check  23726390
      c_chr_uni  11457622
    c_chr_multi  4134402
      c_chr_sum  15592024
c_chr_sum_check  31184048

Writing to dataframe...
         c_name  WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1
          c_all  26476817
      c_MK2_uni  15271102
    c_MK2_multi  2391643
      c_MK2_sum  17662745
c_MK2_sum_check  35325490
      c_chr_uni  2941561
    c_chr_multi  5872511
      c_chr_sum  8814072
c_chr_sum_check  17628144

Writing to dataframe...
         c_name  WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1
          c_all  27471330
      c_MK2_uni  16159674
    c_MK2_multi  2304666
      c_MK2_sum  18464340
c_MK2_sum_check  36928680
      c_chr_uni  3128807
    c_chr_multi  5878183
      c_chr_sum  9006990
c_chr_sum_check  18013980


❯ cat outfiles_htseq-count/calculate_uni-multimappers-etc.UT_prim_UMI.txt
sample  sample_total    Mito-KL-20S_all Mito-KL-20S_uni Mito-KL-20S_multi   SC-I-XVI_all    SC-I-XVI_uni    SC-I-XVI_multi
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1 28593750    15840366    13723802    2116564 12753384    9618005 3135379
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1 29274110    18124271    15496048    2628223 11149839    7740567 3409272
n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1 32294104    17369871    14561827    2808044 14924233    10839993    4084240
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1    29462906    18898366    17008920    1889446 10564540    5254921 5309619
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1    30485089    20964496    18942478    2022018 9520593 4284572 5236021
n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1    24769078    15988150    14275293    1712857 8780928 4164893 4616035
o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1  26199413    17062082    14487580    2574502 9137331 5897639 3239692
o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1  25614430    17857348    15243591    2613757 7757082 4329477 3427605
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1 27546890    15329279    11997347    3331932 12217611    3428982 8788629
o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1 27650067    16428956    13663469    2765487 11221111    3564552 7656559
r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1 26074381    12042994    10085027    1957967 14031387    10241422    3789965
r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1 27859800    13035770    10797819    2237951 14824030    10653110    4170920
r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1    28872243    19144655    16807216    2337439 9727588 3483824 6243764
r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1    26452129    18418579    16482900    1935679 8033550 2959398 5074152
r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1 14862518    3782897 1751924 2030973 11079621    7189320 3890301
r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1 18842139    4511200 2040193 2471007 14330939    9406289 4924650
r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1    14693909    6382649 3677835 2704814 8311260 4644448 3666812
r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1    17701239    7547037 4535393 3011644 10154202    6119775 4034427
r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1 17676487    5558816 2748189 2810627 12117671    7713092 4404579
r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1 18673410    5725360 2774145 2951215 12948050    8210263 4737787
r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1    20109413    11975782    8170752 3805030 8133631 3853707 4279924
r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1    27172906    14755847    7306541 7449306 12417059    3856299 8560760
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1   26649217    6725997 2288830 4437167 19923220    10633162    9290058
r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1   26995608    6311404 2223334 4088070 20684204    11425076    9259128
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1 28279689    11109577    9184377 1925200 17170112    13364739    3805373
r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1 27494489    12881785    10814101    2067684 14612704    10933792    3678912
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1    37273438    19632166    14994726    4637440 17641272    3932961 13708311
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2    31127425    16368756    12492174    3876582 14758669    3226890 11531779
r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1    29051610    18592993    16215412    2377581 10458617    4427289 6031328
t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1 18639826    4153045 1538212 2614833 14486781    8938957 5547824
t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1 17426630    3711589 1326048 2385541 13715041    8391340 5323701
t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1    19276505    8655598 5191638 3463960 10620907    6151066 4469841
t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1    19092950    8748526 5445342 3303184 10344424    6102549 4241875
t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1 20391336    5527031 2240497 3286534 14864305    8515633 6348672
t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1 20894588    5893086 2541675 3351411 15001502    9126826 5874676
t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1    17788422    10597928    7287411 3310517 7190494 3628475 3562019
t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1    19014451    11736913    8176542 3560371 7277538 3533077 3744461
WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1   17528651    3316447 1291305 2025142 14212204    9170938 5041266
WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1   14354209    2854219 1025775 1828444 11499990    6997554 4502436
WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1  17870971    8569374 4821046 3748328 9301597 4704206 4597391
WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1  18187692    8468466 4874871 3593595 9719226 5105886 4613340
WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1   16268286    4664659 2069852 2594807 11603627    6924408 4679219
WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1   18162697    5201273 2144943 3056330 12961424    7185078 5776346
WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1  18353221    11322507    7388417 3934090 7030714 2984238 4046476
WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2  29105695    16516973    8020750 8496223 12588722    3374316 9214406
WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1  16959938    10387936    7036884 3351052 6572002 2789045 3782957
WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1  15634566    415391  353542  61849   15219175    13188385    2030790
WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1  15755143    701134  625995  75139   15054009    12953728    2100281
WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1 10723500    1324726 753929  570797  9398774 6619041 2779733
WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1 10009120    1349737 1042420 307317  8659383 6866366 1793017
WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1 25720373    5958676 1349853 4608823 19761697    8283008 11478689
WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1 24063950    5609038 1304628 4304410 18454912    7746887 10708025
WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1   18858614    9325847 8740540 585307  9532767 8502909 1029858
WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1   17445726    6801959 6353848 448111  10643767    9697530 946237
WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1  9515191 3164864 2553353 611511  6350327 4374618 1975709
WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1  8394823 3130909 2519133 611776  5263914 3403427 1860487
WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1   29909019    16359567    14119767    2239800 13549452    10065665    3483787
WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1  27062659    17942177    15976322    1965855 9120482 3997078 5123404
WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1   27401884    11828904    9789534 2039370 15572980    11645493    3927487
WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1   27455219    11863195    9649998 2213197 15592024    11457622    4134402
WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1  26476817    17662745    15271102    2391643 8814072 2941561 5872511
WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1  27471330    18464340    16159674    2304666 9006990 3128807 5878183
```
</details>
<br />
