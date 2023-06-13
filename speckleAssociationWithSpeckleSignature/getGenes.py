#!/usr/bin/python
# Gets genes of interest from one gene list. 

import sys, os, re

def main(args):
    if not len(args) == 3: sys.exit("USAGE: python getGenes.py HIF2Atargets_MCF7_786O_combined.txt ../medianGeneExpression_KIRC_specklepatientGroups_withSONsignal.txt > medianGeneExpression_KIRC_HIF2Atargs.txt")

    #read geneList into dictionary
    gl = open(args[1]); line = gl.readline()
    genes = []
    while line != "":
        line = line.strip()
        genes.append(line)
        line = gl.readline()
    gl.close()
    
    #print genes from geneList
    ex = open(args[2]); line = ex.readline(); line = line.strip()
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
