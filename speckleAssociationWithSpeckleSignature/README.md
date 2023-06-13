# Speckle Association with Speckle Signature
This pipeline relates speckle association status measured in cell lines from genomic datasets (as in [TSAseq-Alexander2020](https://github.com/katealexander/TSAseq-Alexander2020.git)) to the cancer [speckle signature](https://github.com/katealexander/speckleSignature.git) calculated from TCGA data. 

# Speckle decile plot
In this speckle decile plot, I split the genes into deciles depending on SON TSA-seq signal and graphed the log2 ratio of each gene's median expression in the speckle Signature I versus Signature II patient groups

```Rscript speckleDecileSignaturePlot.R```

The above script creates a decile plot with the log2 ratio of the speckle signatures, called "speckleDecilePlot_signatures.pdf", and a decile plot of the SON signal, called "speckleDecilePlot_SONsignal.pdf".

# Extract genes for scatterplot
As another method to compare SON signal to speckle signature group gene expression, I used a scatterplot (which I graphed in excel). The following script extracts genes from a gene list of interest that can be then used in excel. 

```python getGenes.py HIF2Atargets_MCF7_786O_combined.txt ../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt > medianGeneExpression_KIRC_HIF2Atargs.txt```

In this case, I am extracting the HIF2A target genes, called "HIF2Atargets_MCF7_786O_combined.txt"

# R session info
<img src="https://github.com/katealexander/dataIntegration-Alexander2023/images/RsessionInfo_speckleAssociationWithSpeckleSignature.png" alt="drawing" width="500"/>



