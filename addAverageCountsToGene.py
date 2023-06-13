#!/usr/bin/python 
## This script is for 4 samples. If you do not have 4 samples, edit line 24, add additional/subtract lines after/before line 52

import sys, os, re, numpy as np 

def main(args):
    if not len(args) >= 4: sys.exit("USAGE: python addAverageCountsToGene.py medianGeneExpression_KIRC_specklepatientGroups.txt hg19_TSS.txt ~/Desktop/Alexander2023_filesTooBigForGitub/SONdata/counts*.txt > outFile")

    indexOfGene = 1
    
    f = open(args[1])
    geneFileDict = {}
    line = f.readline()[:-1]
    header = "\t".join(line.split("\t")[1:]) + "\tSONdmso1\tSONdmso2\tSONpt2399-1\tSONpt2399-2"
    print header
    line = f.readline()[:-1]
    while line != "":
        line = line.strip()
        geneFileDict[line.split("\t")[indexOfGene]] = "\t".join(line.split("\t")[indexOfGene + 1:])
        line = f.readline()[:-1]
    f.close()
    
    genes = {}
    f = open(args[2])
    line = f.readline()[:-1]
    while line != "":
        if line.split("\t")[4] in geneFileDict.keys():
            ## add an empty list for every sample in DiffBind analysis, below is for 4 samples
            genes[line.split("\t")[4]] = [line.split("\t")[0], 0, [], [], [], []]
            
            ## example for 8 samples:
            #genes[line.split("\t")[4]] = [line.split("\t")[0], 0, [], [], [], [], [] ,[], [], []]
            
            if line.split("\t")[5] == "+":
                genes[line.split("\t")[4]][1] = line.split("\t")[1]
            else:
                genes[line.split("\t")[4]][1] = line.split("\t")[2]
        line = f.readline()[:-1]
    f.close()
    
    for file in args[3:]:
        f = open(file)
        line = f.readline()[:-1]
        line = f.readline()[:-1]
        while line != "":
            items = line.split("\t")
            chr = items[1]
            start = items[2]
            stop = items[3]
            for gene in genes.keys():
                if genes[gene][0] == chr and int(genes[gene][1]) >= int(start) and int(genes[gene][1]) <= int(stop):
                    genes[gene][2].append(items[6])
                    genes[gene][3].append(items[7])
                    genes[gene][4].append(items[8])
                    genes[gene][5].append(items[9])
                    ## add one additional line per sample added in Line 24
                    ## example for 8 samples:
                    # genes[gene][6].append(items[10])
                    # genes[gene][7].append(items[11])
                    # genes[gene][8].append(items[12])
                    # genes[gene][9].append(items[13])
                    
            line = f.readline()[:-1]
        f.close()

    for gene in geneFileDict.keys():
        averages = []
        if gene in genes.keys():
            for counts in genes[gene][2:]:
                average = np.mean(np.asarray(counts, dtype=np.float32))
                averages.append(average)
            if str(averages[1]) != 'nan':
                print gene + "\t" + str(geneFileDict[gene]) + "\t" + "\t".join(str(i) for i in averages)
        
    
    
if __name__ == "__main__": main(sys.argv)
