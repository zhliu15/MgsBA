rm(list=ls())
setwd("/Path/to/your/file")

load("POI.SNPIndel.22x.ACAN.GeneSet.rdata")
ls()
gPOI <- gdat
gsPOI <- gs.dat

load("Ctrl.SNPIndel.22x.ACAN.GeneSet.rdata")
ls()
gCtrl <- gdat
gsCtrl <- gs.dat

  
#TRUE

mdat <- cbind(gPOI,gCtrl[,2:3])
colnames(mdat) <- c("Gene.set","POI.MutSp","POI.MutGene","GeneNum","Ctrl.MutSp","Ctrl.MutGene")

nCase=88;nCtrl=86;

mut.p <- c()
mut.odds <- c()
mut.g.p <- c()
mut.g.odds <- c()

for(i in 1:nrow(mdat)){

  edat <- matrix(c(mdat$POI.MutSp[i],nCase-mdat$POI.MutSp[i],mdat$Ctrl.MutSp[i],nCtrl-mdat$Ctrl.MutSp[i]), nrow = 2, ncol = 2)
  mt <- fisher.test(edat,alternative = "greater")
  mut.p[i] <- mt$p.value
  mut.odds[i] <- mt$estimate
  
  edat1 <- matrix(c(mdat$POI.MutGene[i],mdat$GeneNum[i] - mdat$POI.MutGene[i],mdat$Ctrl.MutGene[i],mdat$GeneNum[i] - mdat$Ctrl.MutGene[i]), nrow = 2, ncol = 2)
  mt1 <- fisher.test(edat1,alternative = "greater")
  mut.g.p[i] <- mt1$p.value
  mut.g.odds[i] <- mt1$estimate
  
}

mut.fdr <- p.adjust(mut.p,method = "fdr")
mut.g.fdr <- p.adjust(mut.g.p,method = "fdr")

mdat1 <- data.frame(mdat,mut.p,mut.odds,mut.fdr,mut.g.p,mut.g.odds,mut.g.fdr)

##for wilcox

gsPOI$Group <- "POI"
gsCtrl$Group <- "Ctrl"

library(tidyr)
gs.dat <- spread(rbind(gsPOI,gsCtrl), key = "Gene.set", value = "MutCount")
gs.dat[is.na(gs.dat)] <- 0

mut.gw.p <- c()
for(i in 3:ncol(gs.dat)){
  mt2 <- wilcox.test(gs.dat[gs.dat$Group %in% "POI",i],gs.dat[gs.dat$Group %in% "Ctrl",i],alternative="greater")
  nl <- length(mut.gw.p)
  mut.gw.p[nl+1] <- mt2$p.value
}
mut.gw.fdr <- p.adjust(mut.gw.p,method = "fdr")

mdat2 <- data.frame(Gene.set=colnames(gs.dat)[3:ncol(gs.dat)],mut.gw.p,mut.gw.fdr)

writexl::write_xlsx(list(mdat1,mdat2,gs.dat),path="SNPIndelGeneSet.22x.ACAN.POI_Ctrl.xlsx")

