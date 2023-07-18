
`#work_prepare-data_GEO.md`
<br />
<br />

<details>
<summary><b><font size="+2"><i>Table of contents</i></font></b></summary>
<!-- MarkdownTOC -->

1. [Prepare `fastq`s](#prepare-fastqs)
	1. [Get situated](#get-situated)
		1. [Code](#code)
	1. [Initialize dictionary](#initialize-dictionary)
		1. [Code](#code-1)
		1. [Printed](#printed)
		1. [Printed](#printed-1)

<!-- /MarkdownTOC -->
</details>
<br />
<br />

<a id="prepare-fastqs"></a>
## Prepare `fastq`s
<a id="get-situated"></a>
### Get situated
<a id="code"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

tmux new -t "t"
grabnode  # 4, 80, 1, N

d_proj="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"
d_exp_1201="results/2023-1201"
d_exp_0115="results/2023-0115"
d_exp_0215="results/2023-0215"

cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."
cd "fastqs_UMI-dedup/symlinks" || echo "cd'ing failed; check on this..."
```
</details>
<br />

<a id="initialize-dictionary"></a>
### Initialize dictionary
<a id="code-1"></a>
#### Code
<details>
<summary><i>Code</i></summary>

```bash
#!/bin/bash

unset A_fq; unset a_fq
typeset -A A_fq; typeset -a a_fq
A_fq["SAMPLE_BM11_DSp48_7080_S23"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM11_DSp48_7080_S23" )  #EXCLUDE
A_fq["SAMPLE_Bp11_DSp48_7081_S11"]="t4-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp11_DSp48_7081_S11" )    #EXCLUDE
A_fq["SAMPLE_BM8_DSp24_7080_S20"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM8_DSp24_7080_S20" )  #EXCLUDE
A_fq["SAMPLE_BM5_DSp2_7080_S17"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM5_DSp2_7080_S17" )  #EXCLUDE
A_fq["SAMPLE_BM2_DSm2_7080_S14"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM2_DSm2_7080_S14" )  #EXCLUDE
A_fq["SAMPLE_Bp2_DSm2_7081_S2"]="t4-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp2_DSm2_7081_S2" )  #EXCLUDE
A_fq["SAMPLE_Bp5_DSp2_7081_S5"]="t4-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp5_DSp2_7081_S5" )  #EXCLUDE
A_fq["SAMPLE_Bp8_DSp24_7081_S8"]="t4-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp8_DSp24_7081_S8" )  #EXCLUDE

A_fq["CW10_7747_8day_Q_IN_S5"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "CW10_7747_8day_Q_IN_S5" )  #EXCLUDE  #FIXME* ∆ rep1 → rep2
A_fq["CW10_7747_8day_Q_PD_S11"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1"; a_fq+=( "CW10_7747_8day_Q_PD_S11" )  #EXCLUDE  #FIXME* ∆ rep1 → rep2
A_fq["CW12_7748_8day_Q_IN_S6"]="r1-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "CW12_7748_8day_Q_IN_S6" )  #EXCLUDE  #FIXME* ∆ rep2 → rep1
A_fq["CW12_7748_8day_Q_PD_S12"]="r1-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"; a_fq+=( "CW12_7748_8day_Q_PD_S12" )  #EXCLUDE  #FIXME* ∆ rep2 → rep1

A_fq["5781_G1_IN_S5"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "5781_G1_IN_S5" )
A_fq["5781_G1_IP_S1"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep1_tech1"; a_fq+=( "5781_G1_IP_S1" )
A_fq["5781_Q_IN_S6"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "5781_Q_IN_S6" )
A_fq["5781_Q_IP_S2"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep1_tech1"; a_fq+=( "5781_Q_IP_S2" )
A_fq["5782_G1_IN_S7"]="WT_G1_day1_ovn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "5782_G1_IN_S7" )
A_fq["5782_G1_IP_S3"]="WT_G1_day1_ovn_N_aux-F_tc-F_rep2_tech1"; a_fq+=( "5782_G1_IP_S3" )
A_fq["5782_Q_IN_S8"]="WT_Q_day7_ovn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "5782_Q_IN_S8" )
A_fq["5782_Q_IP_S4"]="WT_Q_day7_ovn_N_aux-F_tc-F_rep2_tech1"; a_fq+=( "5782_Q_IP_S4" )



A_fq["SAMPLE_BM1_DSm2_5781_S13"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM1_DSm2_5781_S13" )
A_fq["SAMPLE_Bp1_DSm2_5782_S1"]="WT_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp1_DSm2_5782_S1" )
A_fq["SAMPLE_BM4_DSp2_5781_S16"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM4_DSp2_5781_S16" )
A_fq["SAMPLE_Bp4_DSp2_5782_S4"]="WT_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp4_DSp2_5782_S4" )
A_fq["SAMPLE_BM7_DSp24_5781_S19"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM7_DSp24_5781_S19" )
A_fq["SAMPLE_Bp7_DSp24_5782_S7"]="WT_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp7_DSp24_5782_S7" )
A_fq["SAMPLE_BM10_DSp48_5781_S22"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_BM10_DSp48_5781_S22" )
A_fq["BM10_5781_DSp48_S26"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech2"; a_fq+=( "BM10_5781_DSp48_S26" )
A_fq["SAMPLE_Bp10_DSp48_5782_S10"]="WT_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_Bp10_DSp48_5782_S10" )

A_fq["SAMPLE_Bp3_DSm2_7078_S3"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_Bp3_DSm2_7078_S3" )  #FIXME* ∆ rep1 → rep2
A_fq["SAMPLE_BM3_DSm2_7079_S15"]="r6-n_DSm2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_BM3_DSm2_7079_S15" )  #FIXME* ∆ rep2 → rep1
A_fq["SAMPLE_Bp6_DSp2_7078_S6"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_Bp6_DSp2_7078_S6" )  #FIXME* ∆ rep1 → rep2
A_fq["SAMPLE_BM6_DSp2_7079_S18"]="r6-n_DSp2_day2_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_BM6_DSp2_7079_S18" )  #FIXME* ∆ rep2 → rep1
A_fq["SAMPLE_Bp9_DSp24_7078_S9"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_Bp9_DSp24_7078_S9" )  #FIXME* ∆ rep1 → rep2
A_fq["SAMPLE_BM9_DSp24_7079_S21"]="r6-n_DSp24_day3_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "SAMPLE_BM9_DSp24_7079_S21" )  #FIXME* ∆ rep2 → rep1
A_fq["SAMPLE_Bp12_DSp48_7078_S12"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep1_tech1"; a_fq+=( "SAMPLE_Bp12_DSp48_7078_S12" )  #FIXME* ∆ rep1 → rep2
A_fq["BM12_7079_DSp48_S27"]="r6-n_DSp48_day4_tcn_SS_aux-F_tc-T_rep2_tech1"; a_fq+=( "BM12_7079_DSp48_S27" )  #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2
A_fq["CW6_7078_8day_Q_IN_S3"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "CW6_7078_8day_Q_IN_S3" )  #FIXME* ∆ rep1 → rep2
A_fq["CW6_7078_day8_Q_SS_S28"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech2"; a_fq+=( "CW6_7078_day8_Q_SS_S28" )  #FIXME* ∆ rep1 → rep2
A_fq["CW6_7078_8day_Q_PD_S9"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1"; a_fq+=( "CW6_7078_8day_Q_PD_S9" )  #FIXME* ∆ rep1 → rep2
A_fq["CW8_7079_8day_Q_IN_S4"]="r6-n_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "CW8_7079_8day_Q_IN_S4" )  #FIXME* ∆ rep2 → rep1
A_fq["CW8_7079_8day_Q_PD_S10"]="r6-n_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"; a_fq+=( "CW8_7079_8day_Q_PD_S10" )  #FIXME* ∆ rep2 → rep1
A_fq["DA3_7078_SS_G1_S24"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "DA3_7078_SS_G1_S24" )  #FIXME* ∆ rep1 → rep2  #FIXME‡ ∆ tech1 → tech2
A_fq["DA4_7079_SS_G1_S25"]="r6-n_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "DA4_7079_SS_G1_S25" )  #FIXME* ∆ rep2 → rep1  #FIXME‡ ∆ tech1 → tech2



A_fq["Sample_CT10_7718_pIAA_Q_Nascent_S5"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1"; a_fq+=( "Sample_CT10_7718_pIAA_Q_Nascent_S5" )
A_fq["Sample_CT10_7718_pIAA_Q_SteadyState_S10"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1"; a_fq+=( "Sample_CT10_7718_pIAA_Q_SteadyState_S10" )
A_fq["Sample_CT2_6125_pIAA_Q_Nascent_S1"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1"; a_fq+=( "Sample_CT2_6125_pIAA_Q_Nascent_S1" )
A_fq["Sample_CT2_6125_pIAA_Q_SteadyState_S6"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1"; a_fq+=( "Sample_CT2_6125_pIAA_Q_SteadyState_S6" )
A_fq["Sample_CT4_6126_pIAA_Q_Nascent_S2"]="o-d_Q_day7_tcn_N_aux-T_tc-F_rep2_tech1"; a_fq+=( "Sample_CT4_6126_pIAA_Q_Nascent_S2" )
A_fq["Sample_CT4_6126_pIAA_Q_SteadyState_S7"]="o-d_Q_day7_tcn_SS_aux-T_tc-F_rep2_tech1"; a_fq+=( "Sample_CT4_6126_pIAA_Q_SteadyState_S7" )
A_fq["Sample_CT6_7714_pIAA_Q_Nascent_S3"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep3_tech1"; a_fq+=( "Sample_CT6_7714_pIAA_Q_Nascent_S3" )  #EXCLUDE
A_fq["Sample_CT6_7714_pIAA_Q_SteadyState_S8"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep3_tech1"; a_fq+=( "Sample_CT6_7714_pIAA_Q_SteadyState_S8" )  #EXCLUDE
A_fq["Sample_CT8_7716_pIAA_Q_Nascent_S4"]="n3-d_Q_day7_tcn_N_aux-T_tc-F_rep1_tech1"; a_fq+=( "Sample_CT8_7716_pIAA_Q_Nascent_S4" )
A_fq["Sample_CT8_7716_pIAA_Q_SteadyState_S9"]="n3-d_Q_day7_tcn_SS_aux-T_tc-F_rep1_tech1"; a_fq+=( "Sample_CT8_7716_pIAA_Q_SteadyState_S9" )
A_fq["Sample_CU11_5782_Q_Nascent_S11"]="WT_Q_day7_tcn_N_aux-F_tc-F_rep2_tech1"; a_fq+=( "Sample_CU11_5782_Q_Nascent_S11" )
A_fq["Sample_CU12_5782_Q_SteadyState_S12"]="WT_Q_day7_tcn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "Sample_CU12_5782_Q_SteadyState_S12" )

A_fq["CW2_5781_8day_Q_IN_S1"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "CW2_5781_8day_Q_IN_S1" )
A_fq["CW2_5781_8day_Q_PD_S7"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep1_tech1"; a_fq+=( "CW2_5781_8day_Q_PD_S7" )
A_fq["CW4_5782_8day_Q_IN_S2"]="WT_Q_day8_tcn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "CW4_5782_8day_Q_IN_S2" )
A_fq["CW4_5782_8day_Q_PD_S8"]="WT_Q_day8_tcn_N_aux-F_tc-F_rep2_tech1"; a_fq+=( "CW4_5782_8day_Q_PD_S8" )

A_fq["DA1_5781_SS_G1_S22"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep1_tech1"; a_fq+=( "DA1_5781_SS_G1_S22" )
A_fq["DA2_5782_SS_G1_S23"]="WT_G1_day1_tcn_SS_aux-F_tc-F_rep2_tech1"; a_fq+=( "DA2_5782_SS_G1_S23" )

print_test=TRUE
[[ "${print_test}" == TRUE ]] &&
	{
		for i in "${a_fq[@]}"; do
			echo "  key  ${i}"
			echo "value  ${A_fq[${i}]}"
			echo ""
		done
	}
```

<a id="printed"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt


```
</details>
<br />

```bash










SAMPLE_BM10_DSp48_5781_S22
SAMPLE_BM11_DSp48_7080_S23
SAMPLE_BM1_DSm2_5781_S13
SAMPLE_BM2_DSm2_7080_S14
SAMPLE_BM3_DSm2_7079_S15
SAMPLE_BM4_DSp2_5781_S16
SAMPLE_BM5_DSp2_7080_S17
SAMPLE_BM6_DSp2_7079_S18
SAMPLE_BM7_DSp24_5781_S19
SAMPLE_BM8_DSp24_7080_S20
SAMPLE_BM9_DSp24_7079_S21
SAMPLE_Bp10_DSp48_5782_S10
SAMPLE_Bp11_DSp48_7081_S11
SAMPLE_Bp12_DSp48_7078_S12
SAMPLE_Bp1_DSm2_5782_S1
SAMPLE_Bp2_DSm2_7081_S2
SAMPLE_Bp3_DSm2_7078_S3
SAMPLE_Bp4_DSp2_5782_S4
SAMPLE_Bp5_DSp2_7081_S5
SAMPLE_Bp6_DSp2_7078_S6
SAMPLE_Bp7_DSp24_5782_S7
SAMPLE_Bp8_DSp24_7081_S8
SAMPLE_Bp9_DSp24_7078_S9
Sample_CT10_7718_pIAA_Q_Nascent_S5
Sample_CT10_7718_pIAA_Q_SteadyState_S10
Sample_CT2_6125_pIAA_Q_Nascent_S1
Sample_CT2_6125_pIAA_Q_SteadyState_S6
Sample_CT4_6126_pIAA_Q_Nascent_S2
Sample_CT4_6126_pIAA_Q_SteadyState_S7
Sample_CT6_7714_pIAA_Q_Nascent_S3
Sample_CT6_7714_pIAA_Q_SteadyState_S8
Sample_CT8_7716_pIAA_Q_Nascent_S4
Sample_CT8_7716_pIAA_Q_SteadyState_S9
Sample_CU11_5782_Q_Nascent_S11
Sample_CU12_5782_Q_SteadyState_S12


5781_G1_IN_S5_R1
5781_G1_IP_S1_R1
5781_Q_IN_S6_R1
5781_Q_IP_S2_R1
5782_G1_IN_S7_R1
5782_G1_IP_S3_R1
5782_Q_IN_S8_R1
5782_Q_IP_S4_R1
BM10_5781_DSp48_S26_R1
BM12_7079_DSp48_S27_R1
CW10_7747_8day_Q_IN_S5_R1
CW10_7747_8day_Q_PD_S11_R1
CW12_7748_8day_Q_IN_S6_R1
CW12_7748_8day_Q_PD_S12_R1
CW2_5781_8day_Q_IN_S1_R1
CW2_5781_8day_Q_PD_S7_R1
CW4_5782_8day_Q_IN_S2_R1
CW4_5782_8day_Q_PD_S8_R1
CW6_7078_8day_Q_IN_S3_R1
CW6_7078_8day_Q_PD_S9_R1
CW6_7078_day8_Q_SS_S28_R1
CW8_7079_8day_Q_IN_S4_R1
CW8_7079_8day_Q_PD_S10_R1
DA1_5781_SS_G1_S22_R1
DA2_5782_SS_G1_S23_R1
DA3_7078_SS_G1_S24_R1
DA4_7079_SS_G1_S25_R1
SAMPLE_BM10_DSp48_5781_S22_R1
SAMPLE_BM11_DSp48_7080_S23_R1
SAMPLE_BM1_DSm2_5781_S13_R1
SAMPLE_BM2_DSm2_7080_S14_R1
SAMPLE_BM3_DSm2_7079_S15_R1
SAMPLE_BM4_DSp2_5781_S16_R1
SAMPLE_BM5_DSp2_7080_S17_R1
SAMPLE_BM6_DSp2_7079_S18_R1
SAMPLE_BM7_DSp24_5781_S19_R1
SAMPLE_BM8_DSp24_7080_S20_R1
SAMPLE_BM9_DSp24_7079_S21_R1
SAMPLE_Bp10_DSp48_5782_S10_R1
SAMPLE_Bp11_DSp48_7081_S11_R1
SAMPLE_Bp12_DSp48_7078_S12_R1
SAMPLE_Bp1_DSm2_5782_S1_R1
SAMPLE_Bp2_DSm2_7081_S2_R1
SAMPLE_Bp3_DSm2_7078_S3_R1
SAMPLE_Bp4_DSp2_5782_S4_R1
SAMPLE_Bp5_DSp2_7081_S5_R1
SAMPLE_Bp6_DSp2_7078_S6_R1
SAMPLE_Bp7_DSp24_5782_S7_R1
SAMPLE_Bp8_DSp24_7081_S8_R1
SAMPLE_Bp9_DSp24_7078_S9_R1
Sample_CT10_7718_pIAA_Q_Nascent_S5_R1
Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1
Sample_CT2_6125_pIAA_Q_Nascent_S1_R1
Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1
Sample_CT4_6126_pIAA_Q_Nascent_S2_R1
Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1
Sample_CT6_7714_pIAA_Q_Nascent_S3_R1
Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1
Sample_CT8_7716_pIAA_Q_Nascent_S4_R1
Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1
Sample_CU11_5782_Q_Nascent_S11_R1
Sample_CU12_5782_Q_SteadyState_S12_R1


5781_G1_IN_S5_R2
5781_G1_IP_S1_R2
5781_Q_IN_S6_R2
5781_Q_IP_S2_R2
5782_G1_IN_S7_R2
5782_G1_IP_S3_R2
5782_Q_IN_S8_R2
5782_Q_IP_S4_R2
BM10_5781_DSp48_S26_R2
BM12_7079_DSp48_S27_R2
CW10_7747_8day_Q_IN_S5_R2
CW10_7747_8day_Q_PD_S11_R2
CW12_7748_8day_Q_IN_S6_R2
CW12_7748_8day_Q_PD_S12_R2
CW2_5781_8day_Q_IN_S1_R2
CW2_5781_8day_Q_PD_S7_R2
CW4_5782_8day_Q_IN_S2_R2
CW4_5782_8day_Q_PD_S8_R2
CW6_7078_8day_Q_IN_S3_R2
CW6_7078_8day_Q_PD_S9_R2
CW6_7078_day8_Q_SS_S28_R2
CW8_7079_8day_Q_IN_S4_R2
CW8_7079_8day_Q_PD_S10_R2
DA1_5781_SS_G1_S22_R2
DA2_5782_SS_G1_S23_R2
DA3_7078_SS_G1_S24_R2
DA4_7079_SS_G1_S25_R2
SAMPLE_BM10_DSp48_5781_S22_R2
SAMPLE_BM11_DSp48_7080_S23_R2
SAMPLE_BM1_DSm2_5781_S13_R2
SAMPLE_BM2_DSm2_7080_S14_R2
SAMPLE_BM3_DSm2_7079_S15_R2
SAMPLE_BM4_DSp2_5781_S16_R2
SAMPLE_BM5_DSp2_7080_S17_R2
SAMPLE_BM6_DSp2_7079_S18_R2
SAMPLE_BM7_DSp24_5781_S19_R2
SAMPLE_BM8_DSp24_7080_S20_R2
SAMPLE_BM9_DSp24_7079_S21_R2
SAMPLE_Bp10_DSp48_5782_S10_R2
SAMPLE_Bp11_DSp48_7081_S11_R2
SAMPLE_Bp12_DSp48_7078_S12_R2
SAMPLE_Bp1_DSm2_5782_S1_R2
SAMPLE_Bp2_DSm2_7081_S2_R2
SAMPLE_Bp3_DSm2_7078_S3_R2
SAMPLE_Bp4_DSp2_5782_S4_R2
SAMPLE_Bp5_DSp2_7081_S5_R2
SAMPLE_Bp6_DSp2_7078_S6_R2
SAMPLE_Bp7_DSp24_5782_S7_R2
SAMPLE_Bp8_DSp24_7081_S8_R2
SAMPLE_Bp9_DSp24_7078_S9_R2
Sample_CT10_7718_pIAA_Q_Nascent_S5_R2
Sample_CT10_7718_pIAA_Q_SteadyState_S10_R2
Sample_CT2_6125_pIAA_Q_Nascent_S1_R2
Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2
Sample_CT4_6126_pIAA_Q_Nascent_S2_R2
Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2
Sample_CT6_7714_pIAA_Q_Nascent_S3_R2
Sample_CT6_7714_pIAA_Q_SteadyState_S8_R2
Sample_CT8_7716_pIAA_Q_Nascent_S4_R2
Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2
Sample_CU11_5782_Q_Nascent_S11_R2
Sample_CU12_5782_Q_SteadyState_S12_R2


5781_G1_IN_S5_R3
5781_G1_IP_S1_R3
5781_Q_IN_S6_R3
5781_Q_IP_S2_R3
5782_G1_IN_S7_R3
5782_G1_IP_S3_R3
5782_Q_IN_S8_R3
5782_Q_IP_S4_R3
BM10_5781_DSp48_S26_R3
BM12_7079_DSp48_S27_R3
CW10_7747_8day_Q_IN_S5_R3
CW10_7747_8day_Q_PD_S11_R3
CW12_7748_8day_Q_IN_S6_R3
CW12_7748_8day_Q_PD_S12_R3
CW2_5781_8day_Q_IN_S1_R3
CW2_5781_8day_Q_PD_S7_R3
CW4_5782_8day_Q_IN_S2_R3
CW4_5782_8day_Q_PD_S8_R3
CW6_7078_8day_Q_IN_S3_R3
CW6_7078_8day_Q_PD_S9_R3
CW6_7078_day8_Q_SS_S28_R3
CW8_7079_8day_Q_IN_S4_R3
CW8_7079_8day_Q_PD_S10_R3
DA1_5781_SS_G1_S22_R3
DA2_5782_SS_G1_S23_R3
DA3_7078_SS_G1_S24_R3
DA4_7079_SS_G1_S25_R3
SAMPLE_BM10_DSp48_5781_S22_R3
SAMPLE_BM11_DSp48_7080_S23_R3
SAMPLE_BM1_DSm2_5781_S13_R3
SAMPLE_BM2_DSm2_7080_S14_R3
SAMPLE_BM3_DSm2_7079_S15_R3
SAMPLE_BM4_DSp2_5781_S16_R3
SAMPLE_BM5_DSp2_7080_S17_R3
SAMPLE_BM6_DSp2_7079_S18_R3
SAMPLE_BM7_DSp24_5781_S19_R3
SAMPLE_BM8_DSp24_7080_S20_R3
SAMPLE_BM9_DSp24_7079_S21_R3
SAMPLE_Bp10_DSp48_5782_S10_R3
SAMPLE_Bp11_DSp48_7081_S11_R3
SAMPLE_Bp12_DSp48_7078_S12_R3
SAMPLE_Bp1_DSm2_5782_S1_R3
SAMPLE_Bp2_DSm2_7081_S2_R3
SAMPLE_Bp3_DSm2_7078_S3_R3
SAMPLE_Bp4_DSp2_5782_S4_R3
SAMPLE_Bp5_DSp2_7081_S5_R3
SAMPLE_Bp6_DSp2_7078_S6_R3
SAMPLE_Bp7_DSp24_5782_S7_R3
SAMPLE_Bp8_DSp24_7081_S8_R3
SAMPLE_Bp9_DSp24_7078_S9_R3
Sample_CT10_7718_pIAA_Q_Nascent_S5_R3
Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3
Sample_CT2_6125_pIAA_Q_Nascent_S1_R3
Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3
Sample_CT4_6126_pIAA_Q_Nascent_S2_R3
Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3
Sample_CT6_7714_pIAA_Q_Nascent_S3_R3
Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3
Sample_CT8_7716_pIAA_Q_Nascent_S4_R3
Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3
Sample_CU11_5782_Q_Nascent_S11_R3
Sample_CU12_5782_Q_SteadyState_S12_R3


cd "${d_proj}/${d_exp_0215}/bams_renamed/UT_prim_UMI" \
	|| echo "cd'ing failed; check on this..."
```
</details>
<br />

<a id="printed-1"></a>
#### Printed
<details>
<summary><i>Printed</i></summary>

```txt
...


❯ d_proj="${HOME}/tsukiyamalab/kalavatt/2022_transcriptome-construction"


❯ d_exp_1201="results/2023-1201"


❯ d_exp_0115="results/2023-0115"


❯ d_exp_0215="results/2023-0215"


❯ cd "${d_proj}/${d_exp_0115}" || echo "cd'ing failed; check on this..."


❯ cd "fastqs_UMI-dedup/symlinks" || echo "cd'ing failed; check on this..."
/home/kalavatt/tsukiyamalab/kalavatt/2022_transcriptome-construction/results/2023-0115/fastqs_UMI-dedup/symlinks


❯ ls -lhaFG
...
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IN_S5_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_G1_IP_S1_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IN_S6_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5781_Q_IP_S2_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IN_S7_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_G1_IP_S3_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IN_S8_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/WTQvsG1/Unaligned_UMI/Project_ccucinot/5782_Q_IP_S4_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM10_5781_DSp48_S26_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/BM12_7079_DSp48_S27_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_IN_S5_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_IN_S5_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_IN_S5_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_PD_S11_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_PD_S11_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW10_7747_8day_Q_PD_S11_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_IN_S6_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_IN_S6_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_IN_S6_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_PD_S12_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_PD_S12_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW12_7748_8day_Q_PD_S12_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_IN_S1_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW2_5781_8day_Q_PD_S7_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_IN_S2_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW4_5782_8day_Q_PD_S8_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_IN_S3_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW6_7078_8day_Q_PD_S9_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/CW6_7078_day8_Q_SS_S28_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_IN_S4_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/rtr1_rrp6_wt/sequencing-data_updated_2023-0119/CW8_7079_8day_Q_PD_S10_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA1_5781_SS_G1_S22_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA2_5782_SS_G1_S23_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA3_7078_SS_G1_S24_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/RNAseq_rrp6_additional_March23/DA4_7079_SS_G1_S25_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM10_DSp48_5781_S22_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM11_DSp48_7080_S23_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM1_DSm2_5781_S13_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM2_DSm2_7080_S14_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM3_DSm2_7079_S15_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM4_DSp2_5781_S16_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM5_DSp2_7080_S17_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM6_DSp2_7079_S18_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM7_DSp24_5781_S19_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM8_DSp24_7080_S20_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_BM9_DSp24_7079_S21_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp10_DSp48_5782_S10_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp11_DSp48_7081_S11_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp12_DSp48_7078_S12_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp1_DSm2_5782_S1_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp2_DSm2_7081_S2_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp3_DSm2_7078_S3_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp4_DSp2_5782_S4_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp5_DSp2_7081_S5_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp6_DSp2_7078_S6_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp7_DSp24_5782_S7_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp8_DSp24_7081_S8_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/TRF4_SSRNA_April2022/UMI_information/Project_agreenla/SAMPLE_Bp9_DSp24_7078_S9_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_Nascent_S5_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT10_7718_pIAA_Q_SteadyState_S10_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_Nascent_S1_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_Nascent_S1_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_Nascent_S1_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT2_6125_pIAA_Q_SteadyState_S6_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_Nascent_S2_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_Nascent_S2_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_Nascent_S2_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT4_6126_pIAA_Q_SteadyState_S7_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT6_7714_pIAA_Q_Nascent_S3_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT6_7714_pIAA_Q_Nascent_S3_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT6_7714_pIAA_Q_Nascent_S3_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT6_7714_pIAA_Q_SteadyState_S8_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_Nascent_S4_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_Nascent_S4_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_Nascent_S4_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CT8_7716_pIAA_Q_SteadyState_S9_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CU11_5782_Q_Nascent_S11_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CU11_5782_Q_Nascent_S11_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CU11_5782_Q_Nascent_S11_R3_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CU12_5782_Q_SteadyState_S12_R1_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CU12_5782_Q_SteadyState_S12_R2_001.fastq.gz
_001.fastq.gz -> ../../../../../../alisong/Nab3_Nrd1_Depletion/sequencing-data_updated_2023-0119/Sample_CU12_5782_Q_SteadyState_S12_R3_001.fastq.gz
```
</details>
<br />

