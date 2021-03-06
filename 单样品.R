library(Seurat)
library(dplyr)
library(patchwork)
library(cowplot)
library(ggplot2)

#载入数据
mgc.data <- Read10X(data.dir = "D:/R/Data/GSE106273_RAW/4groups/NP")
mgc1 <- CreateSeuratObject(counts = mgc.data, project = "mgc_NP", min.cells = 3, min.features = 200)

#预处理
mgc1[["percent.mt"]] <- PercentageFeatureSet(mgc1, pattern = "^MT-")

#可视化QC
VlnPlot(mgc1, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)

#根据QC指标进行细胞和基因的过滤
mgc1 <- subset(mgc1, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)

#数据归一化
mgc1 <- NormalizeData(mgc1, normalization.method = "LogNormalize", scale.factor = 10000)

#高可变基因
mgc1 <- FindVariableFeatures(mgc1, selection.method = "vst", nfeatures = 2000)
# Identify the 10 most highly variable genes
top10 <- head(VariableFeatures(mgc1), 10)
# plot variable features with and without labels
plot1 <- VariableFeaturePlot(mgc1)
plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
plot1 + plot2
plot_grid(plot1, plot2)

ceshi

                
