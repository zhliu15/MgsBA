Mutant Gene Set Burden Analysis (MgsBA)
===
一般而言，我们在进行基因组或全外显子分析时，会首先考虑基因的转录翻译后的氨基酸序列是否改变，或者是否会直接影响整个基因的转录和翻译。但在生物体内，遗传突变位点数量较大，其对生物体内的系统性调控影响复杂，很难被直接破译。

从生物体的角度出发，我们应用基础统计学方法，分别从突变位点、突变基因和突变基因集的角度对疾病人群和对照人群的差异进行分析。

但由于基因突变位点、突变基因或突变基因集的数量巨大，往往经统计学分析，多重检验校正后的adjust p.value接近1。
在不同水平的分析中，可以适当调整统计学显著性的阈值，以获取更多的疾病相关位点、基因或基因集信息。

分析中输入数据为GATK流程call variant的结果，经多样本整合后，通过ANNOVAR注释的结果。
经本流程分析后得到各个水平比较分析结果。

简要的分析流程图如下：

In order to facilitate researchers to study intercellular communication, we provide here two methods for constructing intercellular gene regulatory networks. Intercellular gene regulatory network (IGRN) includes (ligand-receptor-transcription factor-target gene). The number of signalling molecules is reduced after multiple filters are applied to the regulatory network, which means that overlapping genes are analysed by multiple communication tools Frequently used filters reduce the number of false-positive results that can be derived using a single tool. In this way, we can more accurately analyse the communication mechanisms between cells. The code for previously published tools is stored in the branch: CCnetwork, and the code for the tools in this study is stored in the branch: cIGRN.

cIGRN: This process can be constructed without setting up a control group, which is convenient for cell communication analysis of spatial transcriptome data.
![igrn](https://github.com/xukun01102021/cIGRN/assets/106895814/417c4339-e13e-456d-87ae-ea280da3e021)
