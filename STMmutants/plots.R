setwd("~/Documents/dataIntegration-Alexander2023/STMmutants/")
library(ggplot2)
library(viridis)
library(dplyr)
library(ggpubr)

A <- read.table("foldChangesFormattedForPlot.txt", header=T, row.names = "Gene")

## get rid of low count genes
A <- A[A$baseMean > 300,]

A$log2Ratio <- log2(A$SigI/A$SigII)
A$signatureDeciles <- ntile(A$log2Ratio, 5)
A$signatureDeciles <- as.factor(A$signatureDeciles)
A$speckleDeciles <- ntile((A$SONdmso1 + A$SONdmso2)/2, 5)
A$speckleDeciles <- as.factor(A$speckleDeciles)


## ntile plot of 1a2a/dpm fold change with siganture ntile HIF2A targets
## made -log2FoldChange so that wt would be positive and dSTM would be negative
my_specific_comparisons <- list( c("1","5"))
p = ggplot(A[A$DPMup == "Yes" | A$X1A2Aup == "Yes",], aes(x=signatureDeciles, y=-log2FoldChange, fill=factor(signatureDeciles))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.1, alpha= .5) +
  theme_classic() +
  scale_fill_viridis(discrete = TRUE, alpha=0.7) +
  theme(legend.position="none") +
  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.015, step.increase = 0.08, label = "p.signif", vjust = .6, hide.ns = T, label.y = 1.1)+ 
  ylim(-1.5,1.5)
filename = "HIFtargets_MCFbias_signatureQuintiles.pdf"
pdf(filename, width = 2.5, height = 2.75, onefile=FALSE)
print(p)
dev.off()

## speckle signature ratio based on bias
A$DPM_1A2A <- factor(A$DPM_1A2A, levels = c("dpm", "ns", "1a2a"))
my_specific_comparisons <- list( c("dpm", "ns"), c("ns", "1a2a"))
p = ggplot(A[A$DPMup == "Yes" | A$X1A2Aup == "Yes",], aes(x=DPM_1A2A, y=log2Ratio, fill=factor(DPM_1A2A))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.1, alpha= .5) +
  theme_classic() +
  scale_fill_manual(values = c("#E0B170", "grey","#878DC1")) +
  theme(legend.position="none") +
  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.015, step.increase = 0.08, label = "p.signif", vjust = .6, hide.ns = T, ) +
  ylim(-2,2)
filename = "HIFtargets_MCFbias_signatureRatio.pdf"
pdf(filename, width = 2, height = 2.75, onefile=FALSE)
print(p)
dev.off()

  
## MCF7 HIF-responsive genes fold change DPM/RTTA with speckle changing boolean
my_specific_comparisons <- list( c("Yes","No"))
p = ggplot(A[A$DPMup == "Yes" | A$X1A2Aup == "Yes",], aes(x=speckleChangingPT2399, y=RTTA_DPMfc, fill=factor(speckleChangingPT2399))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.4, alpha= .5) +
  theme_classic() +
  scale_fill_manual(values = c("#E0B170", "#E0B170")) +
  theme(legend.position="none") +
  #  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.02, label.y = 3) + 
  ylim(0,2.5)
filename = "DPMvsRTTAfc_SONchangingWithPT2399.pdf"
pdf(filename, width = 2, height = 3.5, onefile=FALSE)
print(p)
dev.off()

## MCF7 HIF-responsive genes fold change DPM/RTTA with speckle changing boolean
my_specific_comparisons <- list( c("Yes","No"))
p = ggplot(A[A$DPMup == "Yes" | A$X1A2Aup == "Yes",], aes(x=speckleChangingPT2399, y=RTTA_1A2A, fill=factor(speckleChangingPT2399))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.4, alpha= .5) +
  theme_classic() +
  scale_fill_manual(values = c("#878DC1", "#878DC1")) +
  theme(legend.position="none") +
#  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.02, label.y = 3) + 
  ylim(0,2.5)
filename = "1A2AvsRTTAfc_SONchangingWithPT2399.pdf"
pdf(filename, width = 2, height = 3.5, onefile=FALSE)
print(p)
dev.off()

wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleChangingPT2399 == "Yes"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleChangingPT2399 == "Yes"])
wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleChangingPT2399 == "No"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleChangingPT2399 == "No"])

## ntile plot of dpm/rtta fold change with speckle ntile. HIF2A targets.
my_specific_comparisons <- list( c("1","5"))
p = ggplot(A[A$DPMup == "Yes" | A$X1A2Aup == "Yes",], aes(x=speckleDeciles, y=RTTA_DPMfc, fill=factor(speckleDeciles))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.5, alpha= .5) +
  theme_classic() +
  scale_fill_viridis(discrete = TRUE, alpha=0.5, option = "A") +
  theme(legend.position="none") +
#  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.02, label.y = 2) +
  ylim(0,2.5)
filename = "DPMvsRTTAfc_SONquintiles.pdf"
pdf(filename, width = 3, height = 3.5, onefile=FALSE)
print(p)
dev.off()
## ntile plot of 1a2a/rtta fold change with speckle ntile. HIF2A targets.
my_specific_comparisons <- list( c("1","5"))
p = ggplot(A[A$DPMup == "Yes" | A$X1A2Aup == "Yes",], aes(x=speckleDeciles, y=RTTA_1A2A, fill=factor(speckleDeciles))) +
  geom_boxplot(col="black", size=1, outlier.size = 0) +
  geom_jitter(color="grey20", size=.5, alpha= .5) +
  theme_classic() +
  scale_fill_viridis(discrete = TRUE, alpha=0.5, option = "A") +
  theme(legend.position="none") +
#  stat_compare_means(comparisons = my_specific_comparisons, method = "wilcox.test", size = 4, tip.length = 0.02, label.y = 2) +
  ylim(0,2.5)
filename = "1A2AvsRTTAfc_SONquintiles.pdf"
pdf(filename, width = 3, height = 3.5, onefile=FALSE)
print(p)
dev.off()
wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "5"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "5"])
wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "4"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "4"])
wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "3"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "3"])
wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "2"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "2"])
wilcox.test(A$RTTA_DPMfc[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "1"], A$RTTA_1A2A[(A$DPMup == "Yes" | A$X1A2Aup == "Yes") & A$speckleDeciles == "1"])


