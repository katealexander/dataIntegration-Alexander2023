#!/usr/bin/python


import sys, re

def main(args):
    if len(args) != 7: sys.exit("USAGE: python formatFoldChangesForPlots.py ../HIF2Atargets_MCF7_786O_combined.txt speckleChangingGenes_C&RorTSA DPMvs1A2A.txt ../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt RTTAvsDPM.txt RTTAvs1A2A.txt > outFile.txt")
    
    padjCutoff = 0.05
    foldChangeCutoff = 0.2
    
    
    f = open(args[1])
    HIFtargs  = []
    line = f.readline()[:-1]
    while line != "":
        line = line.strip()
        HIFtargs.append(line)
        line = f.readline()[:-1]
    f.close()
    
    f = open(args[2])
    speckleChangingGenes  = []
    line = f.readline()[:-1]
    while line != "":
        line = line.strip()
        speckleChangingGenes.append(line)
        line = f.readline()[:-1]
    f.close()
    

    ## Make a dictionary with gene as key, fold change file as value (string)
    ## add HIF2A target boolean
    ## add dpm, 1a2a, or ns for significant genes
    ## add changing speckle association boolean
    
    f = open(args[3])
    geneDict = {}
    line = f.readline()[:-1]
    line = line.strip()
    header1 = "Gene\t" + line + "\tHIFtarg\tDPM_1A2A\tspeckleChangingPT2399"
    line = f.readline()[:-1]
    while line != "":
        line = line.strip()
        items = line.split("\t")
        gene = items[0]
        
        ## add boolean for HIF2A regulated gene
        if gene in HIFtargs:
            line = line + "\tYes"
        else:
            line = line + "\tNo"
        foldChange = items[2]
        padj = items[5]
        
        ## add annotation for dpm and 1a2a specific genes
        if float(padj) < padjCutoff and float(foldChange) > foldChangeCutoff:
            line = line + "\t1a2a"
        elif float(padj) < padjCutoff and float(foldChange) < -foldChangeCutoff:
            line = line + "\tdpm"
        else:
            line = line + "\tns"
            
        ## add boolean for gene changing speckle association
        if gene in speckleChangingGenes:
            line = line + "\tYes"
        else:
            line = line + "\tNo"
        
        geneDict[gene] = line
        line = f.readline()[:-1]
    f.close()

    ## Add ratios and SON signals from "allGenes_medianPatientGroups_KIRC_withSpeckleScores.txt" file
    f = open(args[4])
    line = f.readline()[:-1]
    line = line.strip()
    header2 = "\t".join(line.split("\t")[1:])
    header = header1 + "\t" + header2
    line = f.readline()[:-1]
    newDict = {}
    while line != "":
        line = line.strip()
        items = line.split("\t")
        gene = items[0]
        stringToAdd = "\t" + "\t".join(items[1:])
        if gene in geneDict.keys():
            newDict[gene] = geneDict[gene] + stringToAdd
        line = f.readline()[:-1]
    f.close()
    geneDict = newDict ## this was a lazy way to make sure geneDict was excluding the genes that didn't have values in medianPatientGroups file
    
    
    header = header + "\tRTTA_DPMfc\tRTTA_DPMpadj\tDPMup"
    f = open(args[5])
    line = f.readline()[:-1]
    line = f.readline()[:-1]
    while line != "":
        line = line.strip()
        items = line.split("\t")
        gene = items[0]
        fc = float(items[2])
        padj = float(items[5])
        if fc > foldChangeCutoff and padj < padjCutoff:
            up = "Yes"
        else:
            up = "No"
        stringToAdd = "\t" + str(fc) + "\t" + str(padj) + "\t" + up
        if gene in geneDict.keys():
            geneDict[gene] = geneDict[gene] + stringToAdd
        line = f.readline()[:-1]
    f.close()
    
    header = header + "\tRTTA_1A2A\tRTTA_1A2Apadj\t1A2Aup"
    print header
    f = open(args[6])
    line = f.readline()[:-1]
    line = f.readline()[:-1]
    while line != "":
        line = line.strip()
        items = line.split("\t")
        gene = items[0]
        fc = float(items[2])
        padj = float(items[5])
        if fc > foldChangeCutoff and padj < padjCutoff:
            up = "Yes"
        else:
            up = "No"
        stringToAdd = "\t" + str(fc) + "\t" + str(padj) + "\t" + up
        if gene in geneDict.keys():
            print geneDict[gene] + stringToAdd
        line = f.readline()[:-1]
    f.close()
        
    
if __name__ == "__main__": main(sys.argv)

