 
`work_count_features_featureCounts.md`
<br />
<br />

<details>
<summary><font size="+2"><b><i>Table of Contents</i></b></font></summary>
<!-- MarkdownTOC -->

1. [Symlink to datasets](#symlink-to-datasets)
    1. [Symlink to datasets without renaming them](#symlink-to-datasets-without-renaming-them)
        1. [Code](#code)
    1. [Use symlinks to give the datasets intuitive names](#use-symlinks-to-give-the-datasets-intuitive-names)
        1. [Get situated, make necessary directories](#get-situated-make-necessary-directories)
            1. [Code](#code-1)
        1. [Determine the relative paths](#determine-the-relative-paths)
            1. [Code](#code-2)
            1. [Printed](#printed)
        1. [Set up associative arrays \(to be used in the symlinking\)](#set-up-associative-arrays-to-be-used-in-the-symlinking)
            1. [Code](#code-3)
        1. [Perform the symlinking](#perform-the-symlinking)
            1. [Code](#code-4)
1. [Run featureCounts on bams in bams_renamed/](#run-featurecounts-on-bams-in-bams_renamed)
    1. [Run featureCounts on bams in bams_renamed/ with combined_SC_KL.gff3](#run-featurecounts-on-bams-in-bams_renamed-with-combined_sc_klgff3)
        1. [Get situated](#get-situated)
            1. [Code](#code-5)
        1. [Set up arrays](#set-up-arrays)
            1. [Code](#code-6)
        1. [Run featureCounts with combined_SC_KL.gff3](#run-featurecounts-with-combined_sc_klgff3)
            1. [Code](#code-7)
    1. [Run featureCounts on bams in bams_renamed/ with combined_SC_KL.antisense.gff3](#run-featurecounts-on-bams-in-bams_renamed-with-combined_sc_klantisensegff3)
        1. [Get situated](#get-situated-1)
            1. [Code](#code-8)
        1. [Set up arrays](#set-up-arrays-1)
            1. [Code](#code-9)
        1. [Run featureCounts with combined_SC_KL.antisense.gff3](#run-featurecounts-with-combined_sc_klantisensegff3)
            1. [Code](#code-10)
    1. [Run featureCounts on bams in bams_renamed/ with combined_AG.gtf](#run-featurecounts-on-bams-in-bams_renamed-with-combined_aggtf)
        1. [Get situated](#get-situated-2)
            1. [Code](#code-11)
        1. [Set up arrays](#set-up-arrays-2)
            1. [Code](#code-12)
        1. [Run featureCounts with combined_AG.gff3](#run-featurecounts-with-combined_aggff3)
            1. [Code](#code-13)
1. [Generate MultiQC plots](#generate-multiqc-plots)
    1. [Get situated](#get-situated-3)
        1. [Code](#code-14)
    1. [Run MultiQC](#run-multiqc)
        1. [Code](#code-15)
1. [Miscellaneous](#miscellaneous)

<!-- /MarkdownTOC -->
</details>
<br />

<a id="symlink-to-datasets"></a>
## Symlink to datasets
<a id="symlink-to-datasets-without-renaming-them"></a>
### Symlink to datasets without renaming them
<a id="code"></a>
#### Code
<details>
<summary><i>Code: Symlink to datasets without renaming them</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

mkdir bams/ \
    && cd bams/ \
        || echo "cd'ing failed; check on this..."

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


path_UMI_UT="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI"
)"
echo "${path_UMI_UT}"

path_pos_UT="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-pos"
)"
echo "${path_pos_UT}"

path_no_UT="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UT_primary"
)"
echo "${path_no_UT}"

path_UMI_UTK="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-UMI"
)"
echo "${path_UMI_UTK}"

path_pos_UTK="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-pos"
)"
echo "${path_pos_UTK}"

path_no_UTK="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/bams_UMI-dedup/aligned_UTK_primary"
)"
echo "${path_no_UTK}"

ln -s "${path_UMI_UT}" "aligned_UT_primary_dedup-UMI"
ln -s "${path_pos_UT}" "aligned_UT_primary_dedup-pos"
ln -s "${path_no_UT}" "aligned_UT_primary"
ln -s "${path_UMI_UTK}" "aligned_UTK_primary_dedup-UMI"
ln -s "${path_pos_UTK}" "aligned_UTK_primary_dedup-pos"
ln -s "${path_no_UTK}" "aligned_UTK_primary"
```
</details>
<br />

<a id="use-symlinks-to-give-the-datasets-intuitive-names"></a>
### Use symlinks to give the datasets intuitive names
<a id="get-situated-make-necessary-directories"></a>
#### Get situated, make necessary directories
<a id="code-1"></a>
##### Code
<details>
<summary><i>Code: Get situated, make necessary directories</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  Get to and make appropriate directories ------------------------------------
transcriptome && 
    {
        cd "results/2023-0215/" \
            || echo "cd'ing failed; check on this..."
    }

mkdir -p bams_renamed/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}
# for i in $(find . -type l -name *.bam); do unlink "${i}"; done
```
</details>
<br />

<a id="determine-the-relative-paths"></a>
#### Determine the relative paths
<a id="code-2"></a>
##### Code
<details>
<summary><i>Code: Determine the relative paths</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

find_relative_path() {
    realpath --relative-to="${1}" "${2}"
}


#  UTK
cd bams_renamed/UTK_prim_no/
UTK_prim_no="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UTK_primary"
)"

cd ../UTK_prim_pos/
UTK_prim_pos="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UTK_primary_dedup-pos"
)"

cd ../UTK_prim_UMI/
UTK_prim_UMI="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UTK_primary_dedup-UMI"
)"

#  UT
cd ../UT_prim_no/
UT_prim_no="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary"
)"

cd ../UT_prim_pos/
UT_prim_pos="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary_dedup-pos"
)"

cd ../UT_prim_UMI/
UT_prim_UMI="$(
    find_relative_path \
        . \
        "${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0215/bams/aligned_UT_primary_dedup-UMI"
)"

echo "${UTK_prim_no}"
echo "${UTK_prim_pos}"
echo "${UTK_prim_UMI}"
echo "${UT_prim_no}"
echo "${UT_prim_pos}"
echo "${UT_prim_UMI}"
# ../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary
# ../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-pos
# ../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-UMI
# ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary
# ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-pos
# ../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI
```
</details>
<br />

<a id="printed"></a>
##### Printed
<details>
<summary><i>Printed: Determine the relative paths</i></summary>

```txt
❯ echo "${UTK_prim_no}"
../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary


❯ echo "${UTK_prim_pos}"
../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-pos


❯ echo "${UTK_prim_UMI}"
../../../2023-0115/bams_UMI-dedup/aligned_UTK_primary_dedup-UMI


❯ echo "${UT_prim_no}"
../../../2023-0115/bams_UMI-dedup/aligned_UT_primary


❯ echo "${UT_prim_pos}"
../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-pos


❯ echo "${UT_prim_UMI}"
../../../2023-0115/bams_UMI-dedup/aligned_UT_primary_dedup-UMI
```
</details>
<br />

<a id="set-up-associative-arrays-to-be-used-in-the-symlinking"></a>
#### Set up associative arrays (to be used in the symlinking)
<a id="code-3"></a>
##### Code
<details>
<summary><i>Code: Set up associative arrays (to be used in the symlinking)</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

#  UTK
unset array_UTK_prim_no
typeset -A array_UTK_prim_no
array_UTK_prim_no["${UTK_prim_no}/5781_G1_IN_UTK.primary.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5781_G1_IP_UTK.primary.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5781_Q_IN_UTK.primary.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5781_Q_IP_UTK.primary.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_G1_IN_UTK.primary.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_G1_IP_UTK.primary.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_Q_IN_UTK.primary.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/5782_Q_IP_UTK.primary.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM10_DSp48_5781_UTK.primary.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM11_DSp48_7080_UTK.primary.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM1_DSm2_5781_UTK.primary.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM2_DSm2_7080_UTK.primary.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM3_DSm2_7079_UTK.primary.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM4_DSp2_5781_UTK.primary.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM5_DSp2_7080_UTK.primary.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM6_DSp2_7079_UTK.primary.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM7_DSp24_5781_UTK.primary.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM8_DSp24_7080_UTK.primary.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM9_DSp24_7079_UTK.primary.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp10_DSp48_5782_UTK.primary.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp11_DSp48_7081_UTK.primary.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp12_DSp48_7078_UTK.primary.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp1_DSm2_5782_UTK.primary.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp2_DSm2_7081_UTK.primary.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp3_DSm2_7078_UTK.primary.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp4_DSp2_5782_UTK.primary.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp5_DSp2_7081_UTK.primary.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp6_DSp2_7078_UTK.primary.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp7_DSp24_5782_UTK.primary.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp8_DSp24_7081_UTK.primary.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/Bp9_DSp24_7078_UTK.primary.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT10_7718_pIAA_Q_Nascent_UTK.primary.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT10_7718_pIAA_Q_SteadyState_UTK.primary.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT2_6125_pIAA_Q_Nascent_UTK.primary.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT2_6125_pIAA_Q_SteadyState_UTK.primary.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT4_6126_pIAA_Q_Nascent_UTK.primary.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT4_6126_pIAA_Q_SteadyState_UTK.primary.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT6_7714_pIAA_Q_Nascent_UTK.primary.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT6_7714_pIAA_Q_SteadyState_UTK.primary.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT8_7716_pIAA_Q_Nascent_UTK.primary.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CT8_7716_pIAA_Q_SteadyState_UTK.primary.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CU11_5782_Q_Nascent_UTK.primary.bam"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CU12_5782_Q_SteadyState_UTK.primary.bam"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW10_7747_8day_Q_IN_UTK.primary.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW10_7747_8day_Q_PD_UTK.primary.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW12_7748_8day_Q_IN_UTK.primary.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW12_7748_8day_Q_PD_UTK.primary.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW2_5781_8day_Q_IN_UTK.primary.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW2_5781_8day_Q_PD_UTK.primary.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW4_5782_8day_Q_IN_UTK.primary.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW4_5782_8day_Q_PD_UTK.primary.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW6_7078_8day_Q_IN_UTK.primary.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW6_7078_8day_Q_PD_UTK.primary.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW8_7079_8day_Q_IN_UTK.primary.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW8_7079_8day_Q_PD_UTK.primary.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim.bam"

array_UTK_prim_no["${UTK_prim_no}/BM10_DSp48_5781_new_UTK.primary.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/BM12_DSp48_7079_UTK.primary.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/CW6_7078_day8_Q_SS_UTK.primary.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/DA1_5781_SS_G1_UTK.primary.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/DA2_5782_SS_G1_UTK.primary.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/DA3_7078_SS_G1_UTK.primary.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim.bam"
array_UTK_prim_no["${UTK_prim_no}/DA4_7079_SS_G1_UTK.primary.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim.bam"


unset array_UTK_prim_pos
typeset -A array_UTK_prim_pos
array_UTK_prim_pos["${UTK_prim_pos}/5781_G1_IN_UTK.primary.dedup-pos.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5781_G1_IP_UTK.primary.dedup-pos.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5781_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5781_Q_IP_UTK.primary.dedup-pos.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_G1_IN_UTK.primary.dedup-pos.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_G1_IP_UTK.primary.dedup-pos.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/5782_Q_IP_UTK.primary.dedup-pos.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM10_DSp48_5781_UTK.primary.dedup-pos.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM11_DSp48_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM1_DSm2_5781_UTK.primary.dedup-pos.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM2_DSm2_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM3_DSm2_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM4_DSp2_5781_UTK.primary.dedup-pos.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM5_DSp2_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM6_DSp2_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM7_DSp24_5781_UTK.primary.dedup-pos.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM8_DSp24_7080_UTK.primary.dedup-pos.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM9_DSp24_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp10_DSp48_5782_UTK.primary.dedup-pos.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp11_DSp48_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp12_DSp48_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp1_DSm2_5782_UTK.primary.dedup-pos.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp2_DSm2_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp3_DSm2_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp4_DSp2_5782_UTK.primary.dedup-pos.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp5_DSp2_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp6_DSp2_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp7_DSp24_5782_UTK.primary.dedup-pos.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp8_DSp24_7081_UTK.primary.dedup-pos.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/Bp9_DSp24_7078_UTK.primary.dedup-pos.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CU11_5782_Q_Nascent_UTK.primary.dedup-pos.bam"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CU12_5782_Q_SteadyState_UTK.primary.dedup-pos.bam"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW10_7747_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW10_7747_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW12_7748_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW12_7748_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW2_5781_8day_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW2_5781_8day_Q_PD_UTK.primary.dedup-pos.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW4_5782_8day_Q_IN_UTK.primary.dedup-pos.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW4_5782_8day_Q_PD_UTK.primary.dedup-pos.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW6_7078_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW6_7078_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW8_7079_8day_Q_IN_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW8_7079_8day_Q_PD_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"

array_UTK_prim_pos["${UTK_prim_pos}/BM10_DSp48_5781_new_UTK.primary.dedup-pos.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/BM12_DSp48_7079_UTK.primary.dedup-pos.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/CW6_7078_day8_Q_SS_UTK.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/DA1_5781_SS_G1_UTK.primary.dedup-pos.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/DA2_5782_SS_G1_UTK.primary.dedup-pos.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/DA3_7078_SS_G1_UTK.primary.dedup-pos.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_pos.bam"
array_UTK_prim_pos["${UTK_prim_pos}/DA4_7079_SS_G1_UTK.primary.dedup-pos.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_pos.bam"


unset array_UTK_prim_UMI
typeset -A array_UTK_prim_UMI
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_G1_IN_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_G1_IP_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5781_Q_IP_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_G1_IN_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_G1_IP_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/5782_Q_IP_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM10_DSp48_5781_UTK.primary.dedup-UMI.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM11_DSp48_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM1_DSm2_5781_UTK.primary.dedup-UMI.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM2_DSm2_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM3_DSm2_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM4_DSp2_5781_UTK.primary.dedup-UMI.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM5_DSp2_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM6_DSp2_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM7_DSp24_5781_UTK.primary.dedup-UMI.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM8_DSp24_7080_UTK.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM9_DSp24_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp10_DSp48_5782_UTK.primary.dedup-UMI.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp11_DSp48_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp12_DSp48_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp1_DSm2_5782_UTK.primary.dedup-UMI.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp2_DSm2_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp3_DSm2_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp4_DSp2_5782_UTK.primary.dedup-UMI.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp5_DSp2_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp6_DSp2_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp7_DSp24_5782_UTK.primary.dedup-UMI.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp8_DSp24_7081_UTK.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/Bp9_DSp24_7078_UTK.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT10_7718_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT10_7718_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT2_6125_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT2_6125_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT4_6126_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT4_6126_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT6_7714_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT6_7714_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT8_7716_pIAA_Q_Nascent_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CT8_7716_pIAA_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CU11_5782_Q_Nascent_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CU12_5782_Q_SteadyState_UTK.primary.dedup-UMI.bam"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW10_7747_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW10_7747_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW12_7748_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW12_7748_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW2_5781_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW2_5781_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW4_5782_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW4_5782_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW6_7078_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW6_7078_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW8_7079_8day_Q_IN_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW8_7079_8day_Q_PD_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"

array_UTK_prim_UMI["${UTK_prim_UMI}/BM10_DSp48_5781_new_UTK.primary.dedup-UMI.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/BM12_DSp48_7079_UTK.primary.dedup-UMI.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/CW6_7078_day8_Q_SS_UTK.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/DA1_5781_SS_G1_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/DA2_5782_SS_G1_UTK.primary.dedup-UMI.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/DA3_7078_SS_G1_UTK.primary.dedup-UMI.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UTK_prim_UMI.bam"
array_UTK_prim_UMI["${UTK_prim_UMI}/DA4_7079_SS_G1_UTK.primary.dedup-UMI.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UTK_prim_UMI.bam"


#  UT
unset array_UT_prim_no
typeset -A array_UT_prim_no
array_UT_prim_no["${UT_prim_no}/5781_G1_IN_UT.primary.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5781_G1_IP_UT.primary.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5781_Q_IN_UT.primary.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5781_Q_IP_UT.primary.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_G1_IN_UT.primary.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_G1_IP_UT.primary.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_Q_IN_UT.primary.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/5782_Q_IP_UT.primary.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM10_DSp48_5781_UT.primary.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM11_DSp48_7080_UT.primary.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM1_DSm2_5781_UT.primary.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM2_DSm2_7080_UT.primary.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM3_DSm2_7079_UT.primary.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM4_DSp2_5781_UT.primary.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM5_DSp2_7080_UT.primary.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM6_DSp2_7079_UT.primary.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM7_DSp24_5781_UT.primary.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM8_DSp24_7080_UT.primary.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM9_DSp24_7079_UT.primary.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp10_DSp48_5782_UT.primary.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp11_DSp48_7081_UT.primary.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp12_DSp48_7078_UT.primary.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp1_DSm2_5782_UT.primary.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp2_DSm2_7081_UT.primary.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp3_DSm2_7078_UT.primary.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp4_DSp2_5782_UT.primary.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp5_DSp2_7081_UT.primary.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp6_DSp2_7078_UT.primary.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp7_DSp24_5782_UT.primary.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp8_DSp24_7081_UT.primary.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/Bp9_DSp24_7078_UT.primary.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT10_7718_pIAA_Q_Nascent_UT.primary.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT10_7718_pIAA_Q_SteadyState_UT.primary.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT2_6125_pIAA_Q_Nascent_UT.primary.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT2_6125_pIAA_Q_SteadyState_UT.primary.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT4_6126_pIAA_Q_Nascent_UT.primary.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT4_6126_pIAA_Q_SteadyState_UT.primary.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT6_7714_pIAA_Q_Nascent_UT.primary.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT6_7714_pIAA_Q_SteadyState_UT.primary.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT8_7716_pIAA_Q_Nascent_UT.primary.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CT8_7716_pIAA_Q_SteadyState_UT.primary.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CU11_5782_Q_Nascent_UT.primary.bam"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CU12_5782_Q_SteadyState_UT.primary.bam"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW10_7747_8day_Q_IN_UT.primary.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW10_7747_8day_Q_PD_UT.primary.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW12_7748_8day_Q_IN_UT.primary.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW12_7748_8day_Q_PD_UT.primary.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW2_5781_8day_Q_IN_UT.primary.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW2_5781_8day_Q_PD_UT.primary.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW4_5782_8day_Q_IN_UT.primary.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW4_5782_8day_Q_PD_UT.primary.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW6_7078_8day_Q_IN_UT.primary.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW6_7078_8day_Q_PD_UT.primary.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW8_7079_8day_Q_IN_UT.primary.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW8_7079_8day_Q_PD_UT.primary.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim.bam"

array_UT_prim_no["${UT_prim_no}/BM10_DSp48_5781_new_UT.primary.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/BM12_DSp48_7079_UT.primary.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/CW6_7078_day8_Q_SS_UT.primary.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/DA1_5781_SS_G1_UT.primary.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/DA2_5782_SS_G1_UT.primary.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/DA3_7078_SS_G1_UT.primary.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim.bam"
array_UT_prim_no["${UT_prim_no}/DA4_7079_SS_G1_UT.primary.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim.bam"


unset array_UT_prim_pos
typeset -A array_UT_prim_pos
array_UT_prim_pos["${UT_prim_pos}/5781_G1_IN_UT.primary.dedup-pos.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5781_G1_IP_UT.primary.dedup-pos.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5781_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5781_Q_IP_UT.primary.dedup-pos.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_G1_IN_UT.primary.dedup-pos.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_G1_IP_UT.primary.dedup-pos.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/5782_Q_IP_UT.primary.dedup-pos.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM10_DSp48_5781_UT.primary.dedup-pos.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM11_DSp48_7080_UT.primary.dedup-pos.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM1_DSm2_5781_UT.primary.dedup-pos.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM2_DSm2_7080_UT.primary.dedup-pos.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM3_DSm2_7079_UT.primary.dedup-pos.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM4_DSp2_5781_UT.primary.dedup-pos.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM5_DSp2_7080_UT.primary.dedup-pos.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM6_DSp2_7079_UT.primary.dedup-pos.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM7_DSp24_5781_UT.primary.dedup-pos.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM8_DSp24_7080_UT.primary.dedup-pos.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM9_DSp24_7079_UT.primary.dedup-pos.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp10_DSp48_5782_UT.primary.dedup-pos.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp11_DSp48_7081_UT.primary.dedup-pos.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp12_DSp48_7078_UT.primary.dedup-pos.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp1_DSm2_5782_UT.primary.dedup-pos.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp2_DSm2_7081_UT.primary.dedup-pos.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp3_DSm2_7078_UT.primary.dedup-pos.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp4_DSp2_5782_UT.primary.dedup-pos.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp5_DSp2_7081_UT.primary.dedup-pos.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp6_DSp2_7078_UT.primary.dedup-pos.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp7_DSp24_5782_UT.primary.dedup-pos.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp8_DSp24_7081_UT.primary.dedup-pos.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/Bp9_DSp24_7078_UT.primary.dedup-pos.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-pos.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CU11_5782_Q_Nascent_UT.primary.dedup-pos.bam"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CU12_5782_Q_SteadyState_UT.primary.dedup-pos.bam"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW10_7747_8day_Q_IN_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW10_7747_8day_Q_PD_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW12_7748_8day_Q_IN_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW12_7748_8day_Q_PD_UT.primary.dedup-pos.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW2_5781_8day_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW2_5781_8day_Q_PD_UT.primary.dedup-pos.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW4_5782_8day_Q_IN_UT.primary.dedup-pos.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW4_5782_8day_Q_PD_UT.primary.dedup-pos.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW6_7078_8day_Q_IN_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW6_7078_8day_Q_PD_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW8_7079_8day_Q_IN_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW8_7079_8day_Q_PD_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"

array_UT_prim_pos["${UT_prim_pos}/BM10_DSp48_5781_new_UT.primary.dedup-pos.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/BM12_DSp48_7079_UT.primary.dedup-pos.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/CW6_7078_day8_Q_SS_UT.primary.dedup-pos.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/DA1_5781_SS_G1_UT.primary.dedup-pos.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/DA2_5782_SS_G1_UT.primary.dedup-pos.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/DA3_7078_SS_G1_UT.primary.dedup-pos.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_pos.bam"
array_UT_prim_pos["${UT_prim_pos}/DA4_7079_SS_G1_UT.primary.dedup-pos.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_pos.bam"


unset array_UT_prim_UMI
typeset -A array_UT_prim_UMI
array_UT_prim_UMI["${UT_prim_UMI}/5781_G1_IN_UT.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5781_G1_IP_UT.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5781_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5781_Q_IP_UT.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_G1_IN_UT.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_G1_IP_UT.primary.dedup-UMI.bam"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/5782_Q_IP_UT.primary.dedup-UMI.bam"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM10_DSp48_5781_UT.primary.dedup-UMI.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM11_DSp48_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM1_DSm2_5781_UT.primary.dedup-UMI.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM2_DSm2_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM3_DSm2_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM4_DSp2_5781_UT.primary.dedup-UMI.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM5_DSp2_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM6_DSp2_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM7_DSp24_5781_UT.primary.dedup-UMI.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM8_DSp24_7080_UT.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM9_DSp24_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp10_DSp48_5782_UT.primary.dedup-UMI.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp11_DSp48_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp12_DSp48_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp1_DSm2_5782_UT.primary.dedup-UMI.bam"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp2_DSm2_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp3_DSm2_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp4_DSp2_5782_UT.primary.dedup-UMI.bam"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp5_DSp2_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp6_DSp2_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp7_DSp24_5782_UT.primary.dedup-UMI.bam"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp8_DSp24_7081_UT.primary.dedup-UMI.bam"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/Bp9_DSp24_7078_UT.primary.dedup-UMI.bam"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT10_7718_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT10_7718_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT2_6125_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT2_6125_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT4_6126_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT4_6126_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT6_7714_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT6_7714_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT8_7716_pIAA_Q_Nascent_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CT8_7716_pIAA_Q_SteadyState_UT.primary.dedup-UMI.bam"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CU11_5782_Q_Nascent_UT.primary.dedup-UMI.bam"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CU12_5782_Q_SteadyState_UT.primary.dedup-UMI.bam"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW10_7747_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW10_7747_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW12_7748_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW12_7748_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW2_5781_8day_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW2_5781_8day_Q_PD_UT.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW4_5782_8day_Q_IN_UT.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW4_5782_8day_Q_PD_UT.primary.dedup-UMI.bam"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW6_7078_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW6_7078_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW8_7079_8day_Q_IN_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW8_7079_8day_Q_PD_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"

array_UT_prim_UMI["${UT_prim_UMI}/BM10_DSp48_5781_new_UT.primary.dedup-UMI.bam"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/BM12_DSp48_7079_UT.primary.dedup-UMI.bam"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/CW6_7078_day8_Q_SS_UT.primary.dedup-UMI.bam"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/DA1_5781_SS_G1_UT.primary.dedup-UMI.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/DA2_5782_SS_G1_UT.primary.dedup-UMI.bam"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/DA3_7078_SS_G1_UT.primary.dedup-UMI.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1.UT_prim_UMI.bam"
array_UT_prim_UMI["${UT_prim_UMI}/DA4_7079_SS_G1_UT.primary.dedup-UMI.bam"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1.UT_prim_UMI.bam"
```
</details>
<br />

<a id="perform-the-symlinking"></a>
#### Perform the symlinking
<a id="code-4"></a>
##### Code
<details>
<summary><i>Code: Perform the symlinking</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

transcriptome && 
    {
        cd "results/2023-0215/bams_renamed/" \
            || echo "cd'ing failed; check on this..."
    }

cd UT_prim_UMI/
for i in "${!array_UT_prim_UMI[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UT_prim_UMI["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UT_prim_UMI["${i}"]}"
done

cd ../UT_prim_pos/
for i in "${!array_UT_prim_pos[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UT_prim_pos["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UT_prim_pos["${i}"]}"
done

cd ../UT_prim_no/
for i in "${!array_UT_prim_no[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UT_prim_no["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UT_prim_no["${i}"]}"
done

cd ../UTK_prim_UMI/
for i in "${!array_UTK_prim_UMI[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UTK_prim_UMI["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UTK_prim_UMI["${i}"]}"
done

cd ../UTK_prim_no/
for i in "${!array_UTK_prim_no[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UTK_prim_no["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UTK_prim_no["${i}"]}"
done

cd ../UTK_prim_pos/
for i in "${!array_UTK_prim_pos[@]}"; do
    echo "  Key: ${i}"
    echo "Value: ${array_UTK_prim_pos["${i}"]}"
    echo ""

    ln -s "${i}" "${array_UTK_prim_pos["${i}"]}"
done
```
</details>
<br />
<br />

<a id="run-featurecounts-on-bams-in-bams_renamed"></a>
## Run featureCounts on bams in bams_renamed/
<a id="run-featurecounts-on-bams-in-bams_renamed-with-combined_sc_klgff3"></a>
### Run featureCounts on bams in bams_renamed/ with combined_SC_KL.gff3
<a id="get-situated"></a>
#### Get situated
<a id="code-5"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

alias tml="tmux ls"
alias tma="tmux a -t"

tmux new -s fC
# tma fC

hitparade
grabnode  # 28, defaults
source activate expression_env

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

mkdir -p outfiles_featureCounts/combined_SC_KL/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}
```
</details>
<br />

<a id="set-up-arrays"></a>
#### Set up arrays
<a id="code-6"></a>
##### Code
<details>
<summary><i>Code: Set up arrays</i></summary>

```bash
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

unset UTK_prim_UMI
typeset -a UTK_prim_UMI
while IFS=" " read -r -d $'\0'; do
    UTK_prim_UMI+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_UMI" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UT_prim_pos
typeset -a UT_prim_pos
while IFS=" " read -r -d $'\0'; do
    UT_prim_pos+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_pos" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_pos
typeset -a UTK_prim_pos
while IFS=" " read -r -d $'\0'; do
    UTK_prim_pos+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_pos" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UT_prim_no
typeset -a UT_prim_no
while IFS=" " read -r -d $'\0'; do
    UT_prim_no+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_no" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_no
typeset -a UTK_prim_no
while IFS=" " read -r -d $'\0'; do
    UTK_prim_no+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_no" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

echo_test "${UT_prim_UMI[@]}"
echo_test "${UTK_prim_UMI[@]}"
echo_test "${UT_prim_pos[@]}"
echo_test "${UTK_prim_pos[@]}"
echo_test "${UT_prim_no[@]}"
echo_test "${UTK_prim_no[@]}"

echo "${#UT_prim_UMI[@]}"
echo "${#UTK_prim_UMI[@]}"
echo "${#UT_prim_pos[@]}"
echo "${#UTK_prim_pos[@]}"
echo "${#UT_prim_no[@]}"
echo "${#UTK_prim_no[@]}"
```
</details>
<br />

<a id="run-featurecounts-with-combined_sc_klgff3"></a>
#### Run featureCounts with combined_SC_KL.gff3
<a id="code-7"></a>
##### Code
<details>
<summary><i>Code: Run featureCounts with combined_SC_KL.gff3</i></summary>

```bash
#  Set up unchanging variables
threads="${SLURM_CPUS_ON_NODE}"  # echo "${threads}"
strand=1  # echo "${strand}"
gff="${HOME}/genomes/combined_SC_KL_20S/gff3/combined_SC_KL.gff3"  # ., "${gff}"
indir="bams/aligned_UT_primary_dedup-UMI"  # ., "${indir}"

#  UT_prim_UMI
outfile="outfiles_featureCounts/combined_SC_KL/UT_prim_UMI/UT_prim_UMI.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UT_prim_UMI[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UTK_prim_UMI
outfile="outfiles_featureCounts/combined_SC_KL/UTK_prim_UMI/UTK_prim_UMI.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UTK_prim_UMI[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UT_prim_pos
outfile="outfiles_featureCounts/combined_SC_KL/UT_prim_pos/UT_prim_pos.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UT_prim_pos[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UTK_prim_pos
outfile="outfiles_featureCounts/combined_SC_KL/UTK_prim_pos/UTK_prim_pos.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UTK_prim_pos[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UT_prim_no
outfile="outfiles_featureCounts/combined_SC_KL/UT_prim_no/UT_prim_no.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UT_prim_no[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UTK_prim_no
outfile="outfiles_featureCounts/combined_SC_KL/UTK_prim_no/UTK_prim_no.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UTK_prim_no[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

echo "Done."
```
</details>
<br />

<a id="run-featurecounts-on-bams-in-bams_renamed-with-combined_sc_klantisensegff3"></a>
### Run featureCounts on bams in bams_renamed/ with combined_SC_KL.antisense.gff3
<a id="get-situated-1"></a>
#### Get situated
<a id="code-8"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

alias tml="tmux ls"
alias tma="tmux a -t"

tmux new -s fCa
# tma fCa

hitparade
grabnode  # 6, defaults
source activate expression_env

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

mkdir -p outfiles_featureCounts/combined_SC_KL_antisense/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}
```
</details>
<br />

<a id="set-up-arrays-1"></a>
#### Set up arrays
<a id="code-9"></a>
##### Code
<details>
<summary><i>Code: Set up arrays</i></summary>

```bash
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

unset UTK_prim_UMI
typeset -a UTK_prim_UMI
while IFS=" " read -r -d $'\0'; do
    UTK_prim_UMI+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_UMI" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UT_prim_pos
typeset -a UT_prim_pos
while IFS=" " read -r -d $'\0'; do
    UT_prim_pos+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_pos" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_pos
typeset -a UTK_prim_pos
while IFS=" " read -r -d $'\0'; do
    UTK_prim_pos+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_pos" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UT_prim_no
typeset -a UT_prim_no
while IFS=" " read -r -d $'\0'; do
    UT_prim_no+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UT_prim_no" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

unset UTK_prim_no
typeset -a UTK_prim_no
while IFS=" " read -r -d $'\0'; do
    UTK_prim_no+=( "${REPLY}" )
done < <(\
    find "bams_renamed/UTK_prim_no" \
        -type l \
        -name "*.bam" \
        -print0 \
            | sort -z \
)

echo_test "${UT_prim_UMI[@]}"
echo_test "${UTK_prim_UMI[@]}"
echo_test "${UT_prim_pos[@]}"
echo_test "${UTK_prim_pos[@]}"
echo_test "${UT_prim_no[@]}"
echo_test "${UTK_prim_no[@]}"

echo "${#UT_prim_UMI[@]}"
echo "${#UTK_prim_UMI[@]}"
echo "${#UT_prim_pos[@]}"
echo "${#UTK_prim_pos[@]}"
echo "${#UT_prim_no[@]}"
echo "${#UTK_prim_no[@]}"
```
</details>
<br />

<a id="run-featurecounts-with-combined_sc_klantisensegff3"></a>
#### Run featureCounts with combined_SC_KL.antisense.gff3
<a id="code-10"></a>
##### Code
<details>
<summary><i>Code: Run featureCounts with combined_SC_KL.antisense.gff3</i></summary>

```bash
#  Set up unchanging variables
threads="${SLURM_CPUS_ON_NODE}"  # echo "${threads}"
strand=1  # echo "${strand}"
gff="combined_SC_KL.antisense.gff3"  # echo "${gff}"
indir="bams/aligned_UT_primary_dedup-UMI"  # echo "${indir}"

#  UTK_prim_no
outfile="outfiles_featureCounts/combined_SC_KL_antisense/UTK_prim_no/UTK_prim_no.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UTK_prim_no[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UTK_prim_pos
outfile="outfiles_featureCounts/combined_SC_KL_antisense/UTK_prim_pos/UTK_prim_pos.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UTK_prim_pos[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UTK_prim_UMI
outfile="outfiles_featureCounts/combined_SC_KL_antisense/UTK_prim_UMI/UTK_prim_UMI.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UTK_prim_UMI[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UT_prim_no
outfile="outfiles_featureCounts/combined_SC_KL_antisense/UT_prim_no/UT_prim_no.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UT_prim_no[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UT_prim_pos
outfile="outfiles_featureCounts/combined_SC_KL_antisense/UT_prim_pos/UT_prim_pos.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UT_prim_pos[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

#  UT_prim_UMI
outfile="outfiles_featureCounts/combined_SC_KL_antisense/UT_prim_UMI/UT_prim_UMI.featureCounts"
featureCounts \
    --verbose \
    -T "${threads}" \
    -p \
    --countReadPairs \
    -s "${strand}" \
    -a "${gff}" \
    -F "GTF" \
    -g "ID" \
    -o "${outfile}" \
    ${UT_prim_UMI[*]} \
        > >(tee -a "${outfile}.stdout.txt") \
        2> >(tee -a "${outfile}.stderr.txt" >&2)

echo "Done."
```
</details>
<br />

<a id="run-featurecounts-on-bams-in-bams_renamed-with-combined_aggtf"></a>
### Run featureCounts on bams in bams_renamed/ with combined_AG.gtf
`#SKIP`
<a id="get-situated-2"></a>
#### Get situated
<a id="code-11"></a>
##### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

# alias tml="tmux ls"
# alias tma="tmux a -t"
#
# tmux new -s fC
# # tma fC
#
# grabnode  # 28, defaults
# source activate expression_env
#
# transcriptome && 
#     {
#         cd "results/2023-0215" \
#             || echo "cd'ing failed; check on this..."
#     }
#
# mkdir -p outfiles_featureCounts/combined_AG/mRNA/{UTK_prim_no,UTK_prim_pos,UTK_prim_UMI,UT_prim_no,UT_prim_pos,UT_prim_UMI}
```
</details>
<br />

<a id="set-up-arrays-2"></a>
#### Set up arrays
<a id="code-12"></a>
##### Code
<details>
<summary><i>Code: Set up arrays</i></summary>

```bash
# unset UTK_prim_no
# typeset -a UTK_prim_no
# while IFS=" " read -r -d $'\0'; do
#     UTK_prim_no+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UTK_prim_no" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UTK_prim_pos
# typeset -a UTK_prim_pos
# while IFS=" " read -r -d $'\0'; do
#     UTK_prim_pos+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UTK_prim_pos" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UTK_prim_UMI
# typeset -a UTK_prim_UMI
# while IFS=" " read -r -d $'\0'; do
#     UTK_prim_UMI+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UTK_prim_UMI" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UT_prim_no
# typeset -a UT_prim_no
# while IFS=" " read -r -d $'\0'; do
#     UT_prim_no+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UT_prim_no" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UT_prim_pos
# typeset -a UT_prim_pos
# while IFS=" " read -r -d $'\0'; do
#     UT_prim_pos+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UT_prim_pos" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# unset UT_prim_UMI
# typeset -a UT_prim_UMI
# while IFS=" " read -r -d $'\0'; do
#     UT_prim_UMI+=( "${REPLY}" )
# done < <(\
#     find "bams_renamed/UT_prim_UMI" \
#         -type l \
#         -name "*.bam" \
#         -print0 \
#             | sort -z \
# )
#
# echo_test "${UTK_prim_no[@]}"
# echo_test "${UTK_prim_pos[@]}"
# echo_test "${UTK_prim_UMI[@]}"
# echo_test "${UT_prim_no[@]}"
# echo_test "${UT_prim_pos[@]}"
# echo_test "${UT_prim_UMI[@]}"
#
# echo "${#UTK_prim_no[@]}"
# echo "${#UTK_prim_pos[@]}"
# echo "${#UTK_prim_UMI[@]}"
# echo "${#UT_prim_no[@]}"
# echo "${#UT_prim_pos[@]}"
# echo "${#UT_prim_UMI[@]}"
```
</details>
<br />

<a id="run-featurecounts-with-combined_aggff3"></a>
#### Run featureCounts with combined_AG.gff3
<a id="code-13"></a>
##### Code
<details>
<summary><i>Code: Run featureCounts with combined_AG.gff3</i></summary>

```bash
#  Set up unchanging variables
# threads="${SLURM_CPUS_ON_NODE}"
# strand=1
# gtf="${HOME}/genomes/combined_AG/gtf/combined_AG.gtf"
#
# echo "${threads}"
# echo "${strand}"
# echo "${gtf}"
#
# #  UTK_prim_no
# outfile="outfiles_featureCounts/combined_AG/mRNA/UTK_prim_no/UTK_prim_no.featureCounts"
# featureCounts \
#     --verbose \
#     -T "${threads}" \
#     -p \
#     --countReadPairs \
#     -s "${strand}" \
#     -a "${gtf}" \
#     -F "GTF" \
#     -t "mRNA" \
#     -o "${outfile}" \
#     ${UTK_prim_no[*]} \
#         >> >(tee -a "${outfile}.stdout.txt") \
#         2>> >(tee -a "${outfile}.stderr.txt" >&2)
#
# #  UTK_prim_pos
# outfile="outfiles_featureCounts/combined_AG/mRNA/UTK_prim_pos/UTK_prim_pos.featureCounts"
# featureCounts \
#     --verbose \
#     -T "${threads}" \
#     -p \
#     --countReadPairs \
#     -s "${strand}" \
#     -a "${gtf}" \
#     -F "GTF" \
#     -t "mRNA" \
#     -o "${outfile}" \
#     ${UTK_prim_pos[*]} \
#         >> >(tee -a "${outfile}.stdout.txt") \
#         2>> >(tee -a "${outfile}.stderr.txt" >&2)
#
# #  UTK_prim_UMI
# outfile="outfiles_featureCounts/combined_AG/mRNA/UTK_prim_UMI/UTK_prim_UMI.featureCounts"
# featureCounts \
#     --verbose \
#     -T "${threads}" \
#     -p \
#     --countReadPairs \
#     -s "${strand}" \
#     -a "${gtf}" \
#     -F "GTF" \
#     -t "mRNA" \
#     -o "${outfile}" \
#     ${UTK_prim_UMI[*]} \
#         >> >(tee -a "${outfile}.stdout.txt") \
#         2>> >(tee -a "${outfile}.stderr.txt" >&2)
#
# #  UT_prim_no
# outfile="outfiles_featureCounts/combined_AG/mRNA/UT_prim_no/UT_prim_no.featureCounts"
# featureCounts \
#     --verbose \
#     -T "${threads}" \
#     -p \
#     --countReadPairs \
#     -s "${strand}" \
#     -a "${gtf}" \
#     -F "GTF" \
#     -t "mRNA" \
#     -o "${outfile}" \
#     ${UT_prim_no[*]} \
#         >> >(tee -a "${outfile}.stdout.txt") \
#         2>> >(tee -a "${outfile}.stderr.txt" >&2)
#
# #  UT_prim_pos
# outfile="outfiles_featureCounts/combined_AG/mRNA/UT_prim_pos/UT_prim_pos.featureCounts"
# featureCounts \
#     --verbose \
#     -T "${threads}" \
#     -p \
#     --countReadPairs \
#     -s "${strand}" \
#     -a "${gtf}" \
#     -F "GTF" \
#     -t "mRNA" \
#     -o "${outfile}" \
#     ${UT_prim_pos[*]} \
#         >> >(tee -a "${outfile}.stdout.txt") \
#         2>> >(tee -a "${outfile}.stderr.txt" >&2)
#
# #  UT_prim_UMI
# outfile="outfiles_featureCounts/combined_AG/mRNA/UT_prim_UMI/UT_prim_UMI.featureCounts"
# featureCounts \
#     --verbose \
#     -T "${threads}" \
#     -p \
#     --countReadPairs \
#     -s "${strand}" \
#     -a "${gtf}" \
#     -F "GTF" \
#     -t "mRNA" \
#     -o "${outfile}" \
#     ${UT_prim_UMI[*]} \
#         >> >(tee -a "${outfile}.stdout.txt") \
#         2>> >(tee -a "${outfile}.stderr.txt" >&2)
#
# echo "Done."
```
</details>
<br />
<br />

<a id="generate-multiqc-plots"></a>
## Generate MultiQC plots
<a id="get-situated-3"></a>
### Get situated
<a id="code-14"></a>
#### Code
<details>
<summary><i>Code: Get situated</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

source activate Trinity_env

transcriptome && 
    {
        cd "results/2023-0215" \
            || echo "cd'ing failed; check on this..."
    }

mkdir -p MultiQC/{combined_SC_KL,combined_SC_KL_20S}
```
</details>
<br />

<a id="run-multiqc"></a>
### Run MultiQC
<a id="code-15"></a>
#### Code
<details>
<summary><i>Code: Run MultiQC</i></summary>

```bash
#!/bin/bash
#DONTRUN #CONTINUE

for i in $(find outfiles_featureCounts/combined_SC_KL -type d); do
    echo "#  Working with ${i}"
    echo "multiqc \\"
    echo "    --interactive \\"
    echo "    -o MultiQC/combined_SC_KL/$(basename "${i}") \\"
    echo "    ${i}"
    echo ""
    multiqc \
        --interactive \
        -o "MultiQC/combined_SC_KL/$(basename "${i}")" \
        "${i}"
done

for i in $(find outfiles_featureCounts/combined_SC_KL_20S -type d); do
    echo "#  Working with ${i}"
    echo "multiqc \\"
    echo "    --interactive \\"
    echo "    -o MultiQC/combined_SC_KL_20S/$(basename "${i}") \\"
    echo "    ${i}"
    echo ""
    multiqc \
        --interactive \
        -o "MultiQC/combined_SC_KL_20S/$(basename "${i}")" \
        "${i}"
done
```
</details>
<br />

<a id="miscellaneous"></a>
## Miscellaneous
Open link to come back to later: [featureCounts - paired-end data](https://support.bioconductor.org/p/67534/); details on counting "read pairs (fragments) rather than reads because counting fragments will give you more accurate counts" (from first main comment)
