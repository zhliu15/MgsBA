rm(list=ls())
setwd("/Path/to/your/file")

load("POI.SNPIndel.22x.ACAN.rdata")
ls()
#"snpPOI"

load("Ctrl.SNPIndel.22x.ACAN.rdata")
ls()
#"snpCtrl" "snpPOI"

##因为位点水平，只需要看snpPOI突变样本数高的位点，POI组没有的突变位点不需要看，所以，进行match，减少计算量。
snpCtrl <- snpCtrl[match(snpPOI$snpID,snpCtrl$snpID),]

mdat <- data.frame(snpPOI$snpID,snpPOI$AC,snpCtrl$AC,snpPOI$AN,snpCtrl$AN,snpPOI$mutSp,snpCtrl$mutSp,snpCtrl$Otherinfo11)

mdat <- cbind(snpPOI[,1:7],mdat)

mut.p <- c()
mut.odds <- c()
ac.p <- c()
ac.odds <- c()

nCase=88;nCtrl=86;

for(i in 1:nrow(mdat)){
  if(!is.na(mdat$snpCtrl.mutSp[i])){
    edat <- matrix(c(mdat$snpPOI.mutSp[i],nCase-mdat$snpPOI.mutSp[i],mdat$snpCtrl.mutSp[i],nCtrl-mdat$snpCtrl.mutSp[i]), nrow = 2, ncol = 2)
    mt <- fisher.test(edat,alternative = "greater")
    mut.p[i] <- mt$p.value
    mut.odds[i] <- mt$estimate
    
    edat <- matrix(c(mdat$snpPOI.AC[i],nCase * 2 - mdat$snpPOI.AC[i],mdat$snpCtrl.AC[i],nCtrl * 2 -mdat$snpCtrl.AC[i]), nrow = 2, ncol = 2)
    mt <- fisher.test(edat,alternative = "greater")
    ac.p[i] <- mt$p.value
    ac.odds[i] <- mt$estimate
    
  } else {
    edat <- matrix(c(mdat$snpPOI.mutSp[i],nCase-mdat$snpPOI.mutSp[i],0,nCtrl), nrow = 2, ncol = 2)
    mt <- fisher.test(edat,alternative = "greater")
    mut.p[i] <- mt$p.value
    mut.odds[i] <- mt$estimate
    
    edat <- matrix(c(mdat$snpPOI.AC[i],nCase * 2 - mdat$snpPOI.AC[i],0,nCtrl * 2), nrow = 2, ncol = 2)
    mt <- fisher.test(edat,alternative = "greater")
    ac.p[i] <- mt$p.value
    ac.odds[i] <- mt$estimate
    
  }
  if(i %% 1000 == 0){print(i);Sys.time()}
}

mut.fdr <- p.adjust(mut.p,method = "fdr")
ac.fdr <- p.adjust(ac.p,method = "fdr")

mdat <- cbind(mdat,data.frame(mut.p,mut.odds,ac.p,ac.odds,mut.fdr,ac.fdr))

writexl::write_xlsx(list(POI88Ctrl86=mdat),path="SNPIndel.22x.greater.ACAN.POI_Ctrl.xlsx")

