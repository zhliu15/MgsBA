Mutant Gene Set Burden Analysis (MgsBA)
===
Generally speaking, when we perform genomic or whole-exome analysis, we first consider whether the amino acid sequence of the gene has changed after transcription and translation, or whether it will directly affect the transcription and translation of the entire gene. However, in organisms, the number of genetic mutation sites is large, and its impact on the systemic regulation of organisms is complex, which is difficult to be directly deciphered.

Starting from the complex regulatory mechanism of organisms, we applied basic statistical methods to analyze the differences between the disease population and the control population from the perspectives of mutation sites, mutant genes and mutant gene sets.According to the data type, statistical analysis was performed by Fisher's exact test and wilcoxon rank sum test, respectively.

However, due to the large number of gene mutation loci, mutant genes or mutant gene sets, the adjusted p.value after multiple test correction is close to 1 after statistical analysis. In different levels of analysis, the threshold of statistical significance can be adjusted appropriately to obtain more information about disease-related loci, genes, or gene sets.

The input data in the analysis are the results of the GATK process call variant, which is annotated by ANNOVAR after multi-sample integration. After the analysis of this process, the results of the comparative analysis of each level were obtained.

A brief analysis flowchart is as follows:

![image](https://github.com/zhliu15/MgsBA/blob/main/MgsBA%E6%B5%81%E7%A8%8B%E5%9B%BE.png)


一般而言，我们在进行基因组或全外显子分析时，会首先考虑基因的转录翻译后的氨基酸序列是否改变，或者是否会直接影响整个基因的转录和翻译。但在生物体内，遗传突变位点数量较大，其对生物体内的系统性调控影响复杂，很难被直接破译。

从生物体的复杂调控机制出发，我们应用基础统计学方法，分别从突变位点、突变基因和突变基因集的角度对疾病人群和对照人群的差异进行分析。
根据数据类型，分别通过Fisher's exact test和wilcoxon rank sum test进行统计学分析。

但由于基因突变位点、突变基因或突变基因集的数量巨大，往往经统计学分析，多重检验校正后的adjust p.value接近1。
在不同水平的分析中，可以适当调整统计学显著性的阈值，以获取更多的疾病相关位点、基因或基因集信息。

分析中输入数据为GATK流程call variant的结果，经多样本整合后，通过ANNOVAR注释的结果。
经本流程分析后得到各个水平比较分析结果。

简要的分析流程图如下：

![image](https://github.com/zhliu15/MgsBA/blob/main/MgsBA%E6%B5%81%E7%A8%8B%E5%9B%BE.png)


