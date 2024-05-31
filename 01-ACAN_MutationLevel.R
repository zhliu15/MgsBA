setwd("/Path/to/file")
rm(list=ls())

###基于基因长度和突变数量的基因突变负荷计算/
# library(xlsx)
library(readxl)
# library(openxlsx)
library(writexl)
library(data.table)
library(reshape2)
library(dplyr)
library(stringr)


load("Ctrl.SNPIndel.22x.rdata")
ls()
#
# snp.flt.dat

##Genotype 提取
#snp.flt.dat$Otherinfo11[1]
#[1] "AC=2;AN=2;SF=78"

##snp.flt.dat# 本文件174列是otherinfo信息
nc11 <- which(colnames(snp.flt.dat) %in% "Otherinfo11")

snp.flt.dat <- subset(snp.flt.dat, select = c(1:7,nc11))

ac.dat <- data.frame(str_split_fixed(snp.flt.dat$Otherinfo11,pattern = ";",n = 3))

#AC
length(grep("AC=",x = ac.dat$X1)) == nrow(ac.dat)
length(grep(",",x = ac.dat$X1))
ac.dat$AC <- gsub("AC=","",ac.dat$X1)

#AN
length(grep("AN=",x = ac.dat$X2)) == nrow(ac.dat)
ac.dat$AN <- as.numeric(gsub("AN=","",ac.dat$X2))

#SF
ac.dat$SF <- gsub("SF=","",ac.dat$X3)

snp.flt.dat$AC <- as.numeric(ac.dat$AC)
snp.flt.dat$AN <- as.numeric(ac.dat$AN)
snp.flt.dat$SF <- ac.dat$SF
snp.flt.dat$mutSp <- sapply(snp.flt.dat$SF,function(x){length(unlist(strsplit(x, ",")))})


snp.flt.dat$snpID <- paste(snp.flt.dat$Chr,snp.flt.dat$Start,snp.flt.dat$End,snp.flt.dat$Ref,sep = "_")

save(snp.flt.dat,file = "Ctrl.SNPIndel.22x.ACAN.rdata")