setwd("~/Documents/dataIntegration-Alexander2023/speckleAssociationWithSpeckleSignature/")

library(ggplot2)
library(ggpubr)
library(viridis)
library(dplyr)

A <- read.table("../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt", sep="\t", header=T)
A$speckleDecile <- as.factor(ntile((A$SONdmso1 + A$SONdmso2)/2, 10))
A$sigLog2fc <- log(A$SigI/A$SigII, 2)
my_specific_comparisons <- list( c("1","10"))

## plot of signature log2ratio
p = ggplot(A, aes(x=speckleDecile, y=sigLog2fc, fill=factor(speckleDecile))) + 
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.001, alpha= .05) +
  theme_classic() +
  scale_fill_viridis(discrete = TRUE, alpha=0.5, option = "A") +
  theme(legend.position="none") +
  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.02, label.y = 1.9) + 
  ylim(-2.5, 2.5)
filename = "speckleDecilePlot_signatures.pdf"
pdf(filename, width = 3, height = 3.5, onefile=FALSE)
print(p)
dev.off()

## plot of SON signal
p = ggplot(A, aes(x=speckleDecile, y=(A$SONdmso1 + A$SONdmso2)/2, fill=factor(speckleDecile))) + 
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.001, alpha= .05) +
  theme_classic() +
  scale_fill_viridis(discrete = TRUE, alpha=0.5, option = "A") +
  theme(legend.position="none")
filename = "speckleDecilePlot_SONsignal.pdf"
pdf(filename, width = 3, height = 2, onefile=FALSE)
print(p)
dev.off()
