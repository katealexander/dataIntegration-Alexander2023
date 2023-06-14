# Data Integration
This repository provides the details of how I integrated [speckle signature](https://github.com/katealexander/speckleSignature) data from the TCGA with gene expression and speckle association data from tissue culture experiments. It accompanies the manuscript, Alexander et al., which is under preparation (as of 05/31/2023).

# Requirements
Python 2.7
R - see session info in each subsection

# General approach
To assess relationships between datasets, I used two general approaches:
1. Split one dataset into n-tiles and graph values from another dataset. 
2. Take differential genes from one dataset and graph values from another dataset.

# Analyses
###STMmutants
STMmutants shows how expression data from a tissue culture experiemnt with HIF2A null, HIF2A-wtSTMs and HIF2A-mutSTMs was integrated with speckle association cell line genomic data and speckle signature TCGA data
###speckleAssociationWithSpeckleSignature
speckleAssociationWithSpeckleSignature provides instructions for integrating SON genomics signal with TCGA speckle signature biases in gene expression
###ALYREFknockdown

# Generating file with speckle signature and speckle association data
A file, "medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt", containing gene-level data on speckle signature and SON TSA-seq diffBind normalized counts was generated using the following script and used throughout these analyses:

```python addAverageCountsToGene.py medianGeneExpression_KIRC_specklepatientGroups.txt hg19_TSS.txt ~/Desktop/Alexander2023_filesTooBigForGithub/SONdata/counts* > medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt```

See [TSAseq-Alexander2020](https://github.com/katealexander/TSAseq-Alexander2020.git) for instructions on how to analyze SON TSA-seq data using diffBind.







