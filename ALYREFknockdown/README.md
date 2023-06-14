# ALYREF knockdown
This pipeline describes how to integrate knockdown data with speckle association and speckle signature data.

# SON signal decile plot with ALYREF knockdown data
Using fold change files, called "ALYkd5.txt" and "ALYkd8.txt", generated from Deseq2, I generated files with the average SON counts and ALYREF knockdown versus negative control gene expression data. 

```
python addAverageCountsToGene.py ALYkd5.txt hg19_TSS.txt ~/Desktop/Alexander2023_filesTooBigForGithub/SONdata/counts* > ALYkd5_withSONcounts.txt
python addAverageCountsToGene.py ALYkd8.txt hg19_TSS.txt ~/Desktop/Alexander2023_filesTooBigForGithub/SONdata/counts* > ALYkd8_withSONcounts.txt
```

The "ALYkd5_withSONcounts.txt" and "ALYkd8_withSONcounts.txt" files were then used to generate a SON signal decile plot of the log2 fold change upon ALYREF knockdown

```Rscript speckleDecilePlotMake.R```

The above script will generate "speckleDecile.pdf" and "SONsignalOfDecile.pdf" files for each knockdown.

# Relating the changing genes to SON signal and speckle signature
In the following script, I split genes up by how they change upon ALYREF knockdown (up, down, or not significant(ns)) and generate plots for the SON signal and speckle patient group expression ratios. 

```Rscript HIFresponsiveGenesALYREFchanges.R```

The above script will output boxplots of "ALYREFchangingGenes" for all genes and for HIF2A target genes.

# R session info
<img src="https://github.com/katealexander/dataIntegration-Alexander2023/blob/main/images/RsessionInfo_ALYREFknockdown.png" alt="drawing" width="500"/>
