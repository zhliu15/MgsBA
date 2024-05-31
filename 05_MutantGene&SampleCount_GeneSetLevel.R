## 03 Source Files Combines for Gene burden calculate

rm(list=ls())

setwd("/Path/to/your/file")


load("Ctrl.SNPIndel.22x.ACAN.Gene.rdata")

ls()
# snp.flt.dat


library(reshape2)
library(dplyr)
library(data.table)
library(stringr)
library(tidyr)

##01 突变样本数 fisher 
##02 突变基因个数 fisher
##03 样本具有突变基因个数比较 wilcox

gs.file <- read.table("36GeneSetsAnalyzedUsed.txt",header = T)

gdat <- data.frame()
gs.dat <- data.frame()
for(gs in unique(gs.file$Gene.set)){
  gs.gene <- as.character(gs.file$Gene[gs.file$Gene.set %in% gs])
  mdat2 <- mdat1[mdat1$Gene %in% gs.gene,]
  
  sf1 <- paste(mdat2$SF,collapse = ",")
  sf2 <- sort(unique(unlist(str_split(sf1,","))))
  
  
  nr <- nrow(gdat)
  gdat[nr+1,1] <- gs
  gdat[nr+1,2] <- length(sf2)
  gdat[nr+1,3] <- length(unique(mdat2$Gene))
  gdat[nr+1,4] <- length(unique(gs.gene))
  
  gs.dat1 <- data.frame(table(unlist(str_split(sf1,","))))
  gs.dat1$Gene.set <- gs
  gs.dat <- rbind(gs.dat,gs.dat1)
  
}


##HPO

library(GSA)
hpo.file <- GSA.read.gmt("c5.hpo.v2023.2.Hs.symbols.gmt")

for(i in 1:length(hpo.file$genesets)){
  gs.gene <- hpo.file$genesets[[i]]
  mdat2 <- mdat1[mdat1$Gene %in% gs.gene,]
  
  sf1 <- paste(mdat2$SF,collapse = ",")
  sf2 <- sort(unique(unlist(str_split(sf1,","))))
  
  nr <- nrow(gdat)
  gdat[nr+1,1] <- hpo.file$geneset.names[i]
  gdat[nr+1,2] <- length(sf2)
  gdat[nr+1,3] <- length(unique(mdat2$Gene))
  gdat[nr+1,4] <- length(unique(gs.gene))
  
  gs.dat1 <- data.frame(table(unlist(str_split(sf1,","))))
  gs.dat1$Gene.set <- hpo.file$geneset.names[i]
  gs.dat <- rbind(gs.dat,gs.dat1)
  
}

colnames(gdat) <- c("Gene.set","MutSp","MutGene","GeneNum")
colnames(gs.dat) <- c("Sample","MutCount","Gene.set")

if("" %in% gs.dat$Sample){
  gs.dat <- gs.dat[-which(gs.dat$Sample %in% ""),]
}

save(gdat,gs.dat,file = "Ctrl.SNPIndel.22x.ACAN.GeneSet.rdata")

