
# Set working directory
setwd('./')

# Load libraries
BiocManager::install("org.EcK12.eg.db")
library(org.EcK12.eg.db)
BiocManager::install("clusterProfiler")
library(clusterProfiler)
library(dplyr)

# Load data
sig_genes <- read.table("filtered_sig.txt",
                        sep = "\t",
                        header = TRUE)
oR <- read.table("oxyR_summary.txt",
                 sep = "\t",
                 header = TRUE) 


# GO Enrichment Analysis
ego <- enrichGO(
  gene = sig_genes$gene,
  OrgDb = org.EcK12.eg.db,
  keyType = "SYMBOL",
  ont = "BP",
  pAdjustMethod = "BH",
  qvalueCutoff = 0.05
)

barplot(ego, showCategory = 10)

# GO Enrichment for OxyR
sg_oxyR <- oR %>%
  filter(padj < 0.01,
         abs_log2FC >= 1) %>%
  pull(gene)

ego_oxyR <- enrichGO(
  gene = sg_oxyR,
  OrgDb = org.EcK12.eg.db,
  keyType = "SYMBOL",
  ont = "BP",
  pAdjustMethod = "BH",
  qvalueCutoff = 0.05
)

barplot(ego_oxyR, showCategory = 10)


