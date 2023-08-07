#!/usr/bin/python
# Gets genes of interest from one gene list. In this case, two gene lists are loaded: HIF2A responsive genes from my experiments, and a published set of HIF2A targets (NIHMS1542745-supplement-7, Supp Table S4)

import sys, os, re

def main(args):
    if not len(args) == 4: sys.exit("USAGE: python getGenes.py ../HIF2Atargets_MCF7_786O_combined.txt ../HIF2A_publishedSet ../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt > medianGeneExpression_KIRC_HIF2Atargs.txt")

    #read geneList into dictionary
    gl = open(args[1]); line = gl.readline()
    genes = []
    while line != "":
        line = line.strip()
        genes.append(line)
        line = gl.readline()
    gl.close()
    
    gl = open(args[2]); line = gl.readline()
    while line != "":
        line = line.strip()
        genes.append(line)
        line = gl.readline()
    gl.close()
    
    #print genes from geneList
    ex = open(args[3]); line = ex.readline(); line = line.strip()
    print line
    line = ex.readline();
    while line != "":
        line = line.strip()
        gene = line.split("\t")[0]
        if gene in genes:
            print line
        line = ex.readline()
    ex.close()

if __name__ == "__main__": main(sys.argv)
