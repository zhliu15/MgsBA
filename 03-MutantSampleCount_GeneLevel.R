## 03 Source Files Combines for Gene burden calculate

rm(list=ls())

setwd("/Path/to/your/file")


load("Ctrl.SNPIndel.22x.ACAN.rdata")
ls()
# snp.flt.dat


library(reshape2)
library(dplyr)
library(data.table)
library(stringr)

mdat <- data.frame(Gene=snp.flt.dat$Gene.refGene,SF=snp.flt.dat$SF)

mdat1 <- mdat %>% group_by(Gene) %>% summarise(SF = paste(SF, collapse = ","))
sf <- sapply(mdat1$SF,function(x){sort(unique(unlist(str_split(x,","))))})
mdat1$aSF <- sapply(sf,function(x){paste(x,collapse = ",")})
mdat1$mutSP <- sapply(sf,length)


save(mdat1,file = "Ctrl.SNPIndel.22x.ACAN.Gene.rdata")