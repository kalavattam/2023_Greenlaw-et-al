#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

# Please review the variables below and update if needed.
THREADS=8
module purge
module load deepTools

computeMatrixOperations rbind -m Sample_CT4_6126_pIAA_Q_Nascent_sorted_fwd_scale_TTS_+_filtered.mat.gz Sample_CT4_6126_pIAA_Q_Nascent_sorted_rev_scale_TTS_-_filtered.mat.gz -o 6126_TTS_Sense.mat.gz

computeMatrixOperations rbind -m Sample_CT4_6126_pIAA_Q_Nascent_sorted_rev_scale_TTS_+_filtered.mat.gz Sample_CT4_6126_pIAA_Q_Nascent_sorted_fwd_scale_TTS_-_filtered.mat.gz -o 6126_TTS_Antisense.mat.gz

computeMatrixOperations rbind -m Sample_CT8_7716_pIAA_Q_Nascent_sorted_fwd_scale_TTS_+_filtered.mat.gz Sample_CT8_7716_pIAA_Q_Nascent_sorted_rev_scale_TTS_-_filtered.mat.gz -o 7716_TTS_Sense.mat.gz

computeMatrixOperations rbind -m Sample_CT8_7716_pIAA_Q_Nascent_sorted_rev_scale_TTS_+_filtered.mat.gz Sample_CT8_7716_pIAA_Q_Nascent_sorted_fwd_scale_TTS_-_filtered.mat.gz -o 7716_TTS_Antisense.mat.gz

computeMatrixOperations rbind -m Sample_CT6_7714_pIAA_Q_Nascent_sorted_fwd_scale_TTS_+_filtered.mat.gz Sample_CT6_7714_pIAA_Q_Nascent_sorted_rev_scale_TTS_-_filtered.mat.gz -o 7714_TTS_Sense.mat.gz

computeMatrixOperations rbind -m Sample_CT6_7714_pIAA_Q_Nascent_sorted_rev_scale_TTS_+_filtered.mat.gz Sample_CT6_7714_pIAA_Q_Nascent_sorted_fwd_scale_TTS_-_filtered.mat.gz -o 7714_TTS_Antisense.mat.gz


computeMatrixOperations rbind -m Sample_CT2_6125_pIAA_Q_Nascent_sorted_fwd_scale_TTS_+_filtered.mat.gz Sample_CT2_6125_pIAA_Q_Nascent_sorted_rev_scale_TTS_-_filtered.mat.gz -o 6125_TTS_Sense.mat.gz

computeMatrixOperations rbind -m Sample_CT2_6125_pIAA_Q_Nascent_sorted_rev_scale_TTS_+_filtered.mat.gz Sample_CT2_6125_pIAA_Q_Nascent_sorted_fwd_scale_TTS_-_filtered.mat.gz -o 6125_TTS_Antisense.mat.gz

computeMatrixOperations rbind -m Sample_CT10_7718_pIAA_Q_Nascent_sorted_fwd_scale_TTS_+_filtered.mat.gz Sample_CT10_7718_pIAA_Q_Nascent_sorted_rev_scale_TTS_-_filtered.mat.gz -o 7718_TTS_Sense.mat.gz

computeMatrixOperations rbind -m Sample_CT10_7718_pIAA_Q_Nascent_sorted_rev_scale_TTS_+_filtered.mat.gz Sample_CT10_7718_pIAA_Q_Nascent_sorted_fwd_scale_TTS_-_filtered.mat.gz -o 7718_TTS_Antisense.mat.gz


#6126 background
computeMatrixOperations cbind -m 6126_TTS_Sense.mat.gz 6126_TTS_Antisense.mat.gz 7716_TTS_Sense.mat.gz 7716_TTS_Antisense.mat.gz -o 6126_7716_TTS_sense_as.mat.gz

#all strains sense and antisense
computeMatrixOperations cbind -m 6126_TTS_Sense.mat.gz 6126_TTS_Antisense.mat.gz  6125_TTS_Sense.mat.gz 6125_TTS_Antisense.mat.gz 7714_TTS_Sense.mat.gz 7714_TTS_Antisense.mat.gz  7716_TTS_Sense.mat.gz 7716_TTS_Antisense.mat.gz 7718_TTS_Sense.mat.gz 7718_TTS_Antisense.mat.gz -o all_TTS_sense_as.mat.gz

#all strains AS
computeMatrixOperations cbind -m  6126_TTS_Antisense.mat.gz  6125_TTS_Antisense.mat.gz 7714_TTS_Antisense.mat.gz  7716_TTS_Antisense.mat.gz 7718_TTS_Antisense.mat.gz -o All_TTS_as.mat.gz


#6125 background
computeMatrixOperations cbind -m 6125_TTS_Sense.mat.gz 6125_TTS_Antisense.mat.gz 7718_TTS_Sense.mat.gz 7718_TTS_Antisense.mat.gz 7714_TTS_Sense.mat.gz 7714_TTS_Antisense.mat.gz -o 6125_7718_7714_TTS_sense_as.mat.gz


#all strains sense
computeMatrixOperations cbind -m 6126_TTS_Sense.mat.gz 6125_TTS_Sense.mat.gz 7714_TTS_Sense.mat.gz 7716_TTS_Sense.mat.gz 7718_TTS_Sense.mat.gz -o all_TTS_sense.mat.gz



plotHeatmap -m 6125_7718_7714_TTS_sense_as.mat.gz --outFileSortedRegions 6125_7718_7714_TTS_sense_as.bed --colorMap Purples --heatmapHeight 13 --dpi 600 -o 6125_7718_7714_TTS_sense_as_1.png

plotHeatmap -m all_TTS_sense.mat.gz --outFileSortedRegions all_TTS_sense.bed --colorMap Purples --heatmapHeight 13 --dpi 600 -o all_TTS_sense_1.png

plotHeatmap -m 6126_7716_TTS_sense_as.mat.gz --outFileSortedRegions 6126_7716_TTS_sense_as.bed --colorMap Purples --heatmapHeight 13 --dpi 600 -o 6126_7716_TTS_sense_as_1.png

plotHeatmap -m all_TTS_sense_as.mat.gz --outFileSortedRegions all_TTS_sense_as.bed --colorMap Purples --heatmapHeight 13 --dpi 600 -o All_TTS_sense_as_1.png

plotHeatmap -m All_TTS_as.mat.gz --outFileSortedRegions All_TTS_as.bed --colorMap Purples --heatmapHeight 13 --dpi 600 -o All_TTS_as_1.png


done
