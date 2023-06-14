library(ggplot2)
library(viridis)
library(dplyr)
library(ggpubr)

setwd("~/Documents/dataIntegration-Alexander2023/ALYREFknockdown/")

myFiles <- list.files(pattern="*_withSONcounts.txt")

for (file in myFiles){
  A <- read.table(file, sep = "\t", header=T, row.names = "Gene")
  A$speckleDecile <- ntile((A$SONdmso1+A$SONdmso2)/2, 10)
  A$speckleDecile <- as.factor(A$speckleDecile)
  my_specific_comparisons <- list( c("1","10"))
  KDname <- toString(file)
  KDname <- unlist(strsplit(KDname, "_"))[1]
  
  p = ggplot(A, aes(x=speckleDecile, y=log2FoldChange, fill=factor(speckleDecile))) + 
    geom_boxplot(col="black", size=1, outlier.size = 0) +
    geom_jitter(color="grey20", size=.001, alpha= .05) +
    theme_classic() +
    scale_fill_viridis(discrete = TRUE, alpha=0.5, option = "A") +
    theme(legend.position="none") +
    stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.01, label.y = 0.75) + 
    ylim(-1.25, 1.25) + 
    ggtitle(KDname)
  filename = paste(KDname, "_speckleDecile.pdf", sep="")
  pdf(filename, width = 3, height = 3.5, onefile=FALSE)
  print(p)
  dev.off()
  
  p = ggplot(A, aes(x=speckleDecile, y=(A$SONdmso1+A$SONdmso2)/2, fill=factor(speckleDecile))) + 
    geom_boxplot(col="black", size=1, outlier.size = 0) +
    geom_jitter(color="grey20", size=.001, alpha= .05) +
    theme_classic() +
    scale_fill_viridis(discrete = TRUE, alpha=0.5, option = "A") +
    theme(legend.position="none") +
    ggtitle(paste(KDname, "SONsignal"))
  filename = paste(KDname, "_SONsignalOfDecile.pdf", sep="")
  pdf(filename, width = 3, height = 2, onefile=FALSE)
  print(p)
  dev.off()
}