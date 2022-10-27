#!/bin/bash
WRAP=""
RUNDIR=`pwd`;

# Please review the variables below and update if needed.
THREADS=8
module purge
module load deepTools

mkdir correlation

multiBamSummary bins --binSize 200 --bamfiles Sample_CT10_7718_pIAA_Q_Nascent_sorted.bam Sample_CT4_6126_pIAA_Q_Nascent_sorted.bam \
Sample_CT8_7716_pIAA_Q_Nascent_sorted.bam Sample_CT10_7718_pIAA_Q_SteadyState_sorted.bam Sample_CT4_6126_pIAA_Q_SteadyState_sorted.bam \
Sample_CT8_7716_pIAA_Q_SteadyState_sorted.bam Sample_CT2_6125_pIAA_Q_Nascent_sorted.bam Sample_CT6_7714_pIAA_Q_Nascent_sorted.bam \
Sample_CT2_6125_pIAA_Q_SteadyState_sorted.bam Sample_CT6_7714_pIAA_Q_SteadyState_sorted.bam -o bam_correlation.npz

plotCorrelation \
    -in bam_correlation.npz \
    --corMethod spearman --skipZeros \
    --plotTitle "Spearman Correlation of Read Counts" \
    --whatToPlot heatmap --colorMap Purples --plotNumbers \
    -o heatmap_SpearmanCorr_readCounts.png   \
    --outFileCorMatrix SpearmanCorr_readCounts.tab

plotCorrelation \
    -in bam_correlation.npz \
    --corMethod pearson --skipZeros \
    --plotTitle "Pearson Correlation of Read Counts" \
    --whatToPlot heatmap --colorMap Purples --plotNumbers \
    -o heatmap_pearsonCorr_readCounts.png   \
    --outFileCorMatrix pearsonCorr_readCounts.tab

plotPCA -in bam_correlation.npz \
    -o PCA_readCounts.png \
    -T "PCA Yeast Bams"


mv *.npz correlation
mv *.png correlation
mv *.tab correlation

done
