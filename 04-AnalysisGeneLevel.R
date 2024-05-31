rm(list=ls())
setwd("/Path/to/your/file")

load("POI.SNPIndel.22x.ACAN.Gene.rdata")
ls()
#"snpPOI"
load("Ctrl.SNPIndel.22x.ACAN.Gene.rdata")
ls()
# "snpPOI" "snpCtrl"


snpPOI <- snpPOI[,c("Gene","aSF","mutSP")]
snpCtrl <- snpCtrl[,c("Gene","aSF","mutSP")]

#基因水平进行match，也是只看POI中存在的突变基因。只在Ctrl组存在的突变基因，默认为与POI发生无关。
snpCtrl <- snpCtrl[match(snpPOI$Gene,snpCtrl$Gene),]

mdat <- data.frame(snpPOI$Gene,snpPOI$aSF,snpPOI$mutSP,snpCtrl$aSF,snpCtrl$mutSP)

nCase=88;nCtrl=86;

for(i in 1:nrow(mdat)){
  if(!is.na(mdat$snpCtrl.mutSP[i])){
    edat <- matrix(c(mdat$snpPOI.mutSP[i],nCase-mdat$snpPOI.mutSP[i],mdat$snpCtrl.mutSP[i],nCtrl-mdat$snpCtrl.mutSP[i]), nrow = 2, ncol = 2)
    mt <- fisher.test(edat,alternative = "greater")
    mdat$mut.p[i] <- mt$p.value
    mdat$mut.odds[i] <- mt$estimate
    
  } else {
    edat <- matrix(c(mdat$snpPOI.mutSP[i],nCase-mdat$snpPOI.mutSP[i],0,nCtrl), nrow = 2, ncol = 2)
    mt <- fisher.test(edat,alternative = "greater")
    mdat$mut.p[i] <- mt$p.value
    mdat$mut.odds[i] <- mt$estimate
    
  }
}

mdat$mut.fdr <- p.adjust(mdat$mut.p,method = "fdr")

writexl::write_xlsx(list(SNPGene=mdat),path="SNPIndelGene.22x.ACAN.POI_Ctrl.xlsx")
