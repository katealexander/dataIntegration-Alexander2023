# Speckle targeting motif mutants
This pipeline describes how I integrated speckle association and speckle signature data with expression data from speckle targeting motif (STM) HIF2A mutants.

# Format data for plot making
The following Python script formats expression, speckle association, and speckle signature data

```python formatFoldChangesForPlots.py ../HIF2Atargets_MCF7_786O_combined.txt speckleChangingGenes_C\&RorTSA DPMvs1A2A.txt ../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt RTTAvsDPM.txt RTTAvs1A2A.txt > foldChangesFormattedForPlot.txt```

Input files are:
1. "HIF2Atargets_MCF7_786O_combined.txt" - list of HIF2A target genes defined as up in MCF7 cells with induced HIF2A expression or genes decreased in 786O cells with HIF2A inhibition with PT2399.
2. "speckleChangingGenes_C&RorTSA" - list of all genes that decrease SON signal in either SON C&R or SON TSA-seq experiment in 786O cells treated with HIF2A inhibitor PT2399.
3. "medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt" - file containing median gene expression for patient groups and normalized counts of SON TSA-seq data from 786O cells. 
4. "DPMvs1A2A.txt", "RTTAvsDPM.txt", and "RTTAvs1A2A.txt" are Deseq2 fold change output files for each comparison. DPM - double proline mutant HIF2A, which is stabilized against degradation, 1A2A - deletion of both speckle targeting motifs, also has double proline mutation, RTTA - null control with no HIF2A induction. 

# Make plots in R
The following script uses the file "foldChangesFormatedForPlot.txt" creates several files relating gene expression changes in MCF7 cells with induced expression of HIF2A

```Rscript plots.R```

Files generated:
- HIFtargets_MCFbias_signatureQuintiles.pdf - boxplot spliting HIF2A targets into quintiles based on their speckle signature bias. Genes more highly expressed in speckle Signature I are in quintile 5; genes more highly expressed in speckle Signature II are in quintile 1. Y-axis is log2 fold change of HIF2A-wtSTMs/HIF2A-mutSTMs (value above 0 means higher expression in HIF2A-wtSTM)
- HIFtargets_MCFbias_signatureRatio.pdf - boxplot splitting HIF2A target genes based on whether they were differentially expressed between HIF2A-wtSTM(dpm) and HIF2A-mutSTMs(1a2a), or not significant between the two (ns). Y-axis is the log2 ratio of the median expression of each gene in the speckle Signature I versus Signature II patient groups. 
- DPMvsRTTAfc_SONchangingWithPT2399.pdf and 1A2AvsRTTAfc_SONchangingWithPT2399.pdf - boxplots of HIF2A-wtSTM or HIF2A-mutSTM log2 fold change versus HIF2A null (RTTA) cells split based on whether the HIF2A target gene showed decreasing speckle association in 786O cells treated with HIF2A PT2399 inhibitor (yes means speckle association decreased, no means speckle association did not decrease) 
- DPMvsRTTAfc_SONquintiles.pdf and 1A2AvsRTTAfc_SONquintiles.pdf - boxplots of HIF2A target genes split based on speckle association status (quintile 5 is the most speckle associated, quintile 1 is the least speckle associated). Y-axis is the log2 fold change of either HIF2A-wtSTMs (DPM) or HIF2A-mutSTMs (1a2a) versus HIF2A null (RTTA).

# R session info
<img src="https://github.com/katealexander/dataIntegration-Alexander2023/blob/main/images/RsessionInfo_%STMmutants.png" alt="drawing" width="500"/>



