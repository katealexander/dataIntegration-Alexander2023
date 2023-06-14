setwd("~/Documents/dataIntegration-Alexander2023/ALYREFknockdown/")

library(ggplot2)
library(dplyr)
library(ggpubr)
library(viridis)

A <- read.table("../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt", sep="\t", header=T)
ALYup <- read.table("ALYup_top3000_5and8overlap")
ALYdown <- read.table("ALYdown_top3000_5and8overlap")
A$ALYREFchange <- "ns"
A[A$Gene %in% ALYup$V1,]$ALYREFchange <- "up"
A[A$Gene %in% ALYdown$V1,]$ALYREFchange <- "down"
Aup <- A[A$Gene %in% ALYup$V1,] 
Adown <- A[A$Gene %in% ALYdown$V1,]
A$log2Ratio <- log2(A$SigI/A$SigII)
HIFresponsiveGenes <- read.table("../HIF2Atargets_MCF7_786O_combined.txt")
B <- A[A$Gene %in% HIFresponsiveGenes$V1,] 

my_specific_comparisons <- list(c("down", "ns"), c("ns", "up"))

## All genes
p = ggplot(A, aes(x=ALYREFchange, y=log2Ratio, fill=factor(ALYREFchange))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.05, alpha= .05) +
  theme_classic() +
  theme(legend.position="none") +
  # stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.015, step.increase = 0.08, label = "p.signif", vjust = .6, hide.ns = T, label.y = 2) +
  scale_fill_manual(values = c("#D4A78E", "#BCBEC0", "#9CACB4")) + 
  ylim(-2,2)
filename = "ALYREFchangingGenes_speckleGroupRatio_boxplot_allGenes.pdf"
pdf(filename, width = 2, height = 2.75, onefile=FALSE)
print(p)
dev.off()

## HIF2A targets
p = ggplot(B, aes(x=ALYREFchange, y=log2Ratio, fill=factor(ALYREFchange))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.2, alpha= .5) +
  theme_classic() +
  theme(legend.position="none") +
  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.015, step.increase = 0.08, label = "p.signif", vjust = .6, hide.ns = T, ) +
  scale_fill_manual(values = c("#D4A78E", "#BCBEC0", "#9CACB4")) + 
  ylim(-2,2)
filename = "ALYREFchangingGenes_speckleGroupRatio_HIF2Atargs.pdf"
pdf(filename, width = 2, height = 2.75, onefile=FALSE)
print(p)
dev.off()

## All genes
p = ggplot(A, aes(x=ALYREFchange, y=(A$SONdmso1+A$SONdmso2)/2, fill=factor(ALYREFchange))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.05, alpha= .05) +
  theme_classic() +
  theme(legend.position="none") +
  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.015, step.increase = 0.08, label = "p.signif", vjust = .6, hide.ns = T, ) +
  scale_fill_manual(values = c("#D4A78E", "#BCBEC0", "#9CACB4"))
filename = "ALYREFchangingGenes_SONsignal_allGenes.pdf"
pdf(filename, width = 2, height = 2.75, onefile=FALSE)
print(p)
dev.off()


## HIF2A targets
p = ggplot(B, aes(x=ALYREFchange, y=(B$SONdmso1+B$SONdmso2)/2, fill=factor(ALYREFchange))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.2, alpha= .5) +
  theme_classic() +
  theme(legend.position="none") +
  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.015, step.increase = 0.08, label = "p.signif", vjust = .6, hide.ns = T, ) +
  scale_fill_manual(values = c("#D4A78E", "#BCBEC0", "#9CACB4"))
filename = "ALYREFchangingGenes_SONsignal_HIF2Atargs.pdf"
pdf(filename, width = 2, height = 2.75, onefile=FALSE)
print(p)
dev.off()
