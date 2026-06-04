# Set working directory
setwd('./')

# Load libraries
# BiocManager::install("DESeq2")
library("DESeq2")
library("gplots")
library("RColorBrewer")
library("dplyr")
library("ggplot2")

# Load data
inputF <- "./raw_counts_clean_bow1.txt"

df <- read.table(inputF,
                 header = T,
                 sep = "\t",
                 row.names = 1)

df <- df[,6:9]

# Check the distribution of each sample

head(df)

par(mfrow = c(3,3))
apply(df, 2, function(x) hist(log2(x), breaks = 100))

# Set cut off for gene expression

expressed.ids <- apply(df, 1, function(x) any(x > 20))
dfExp <- df[expressed.ids, ]

par(mar = c(4, 4, 2, 1))
apply(dfExp, 2, function(x) hist(log2(x), breaks = 100))

# Build a design matrix

dm <- data.frame(name = colnames(dfExp),
                 condition = c("WT", "WT", 
                               "delta_oxyR", "delta_oxyR"
                 )
)

dds <- DESeqDataSetFromMatrix(dfExp, 
                              colData = dm,
                              design = ~condition)

# Perform DESeq

dds$condition <- relevel(dds$condition, ref = "WT")
dds <- DESeq(dds)

resultsNames(dds)

dev.off()
plotDispEsts(dds)

# Extract statistical results for Differential Expression

res <- results(dds)
norCounts <- counts(dds, normalized = T)

# Plot MA plot and significance

y <- res$log2FoldChange
x <- rowMeans(norCounts)

plot(log2(x),
     y, 
     pch = 19, 
     cex = 0.2, 
     xlab = "log2(expression)", 
     ylab = "log2(FC)")

sig <- res$padj < 0.01
points(log2(x)[sig],
       y[sig],
       pch = 19,
       cex = 0.2,
       col = 'red')

# Only keep significant genes
resSig <- res[which(res$padj < 0.01), ]

# Extract normalized expression values for significantly differentially expressed genes

sigNorData <- norCounts[which(rownames(norCounts) %in% rownames(resSig)),]

# Heatmap Plot

hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100)

heatMapDF <- t(apply(sigNorData, 1, function(x) (x-mean(x))/sd(x)))

heatmap.2(heatMapDF, 
          col = hmcol, 
          trace = "none",
          margin = c(10, 5),
          labRow = F,
          labCol = c("WT_1", "WT_2", 
                     "delta_oxyR_1", "delta_oxyR_2"
          )
)
dev.off()

# Heatmap with all genes

hmDF <- t(apply(norCounts, 1, function(x) (x-mean(x))/sd(x)))

heatmap.2(hmDF,
          col = hmcol,
          trace = "none",
          margin = c(10,5),
          labRow = F,
          labCol = c("WT_1", "WT_2", 
                     "delta_oxyR_1", "delta_oxyR_2"
                     )
)
dev.off()

# Volcano Plot

res_plot <- data.frame(res)
res_plot$col <- 'grey40'

# Set parameters based on paper (log2 fold change ≥ 1 and false discovery rate [FDR] ≤ 0.01) 

res_plot$col[res_plot$log2FoldChange > 1 &
               res_plot$padj < 0.01] <- 'red'
res_plot$col[res_plot$log2FoldChange < -1 &
               res_plot$padj < 0.01] <- 'blue'

plot(res_plot$log2FoldChange, 
     -log2(res_plot$padj), 
     col = res_plot$col, 
     pch = 19, 
     xlab = "Log2(Fold Change)",
     ylab = "-Log2(Adjusted p-value)",
     xlim = c(-8,8),
     cex = 0.7)
## Add labels based on which are upregulated in which conditions

# Investigate top FC

sum(res$log2FoldChange >= 1, na.rm = TRUE)
sum(res$log2FoldChange <= -1, na.rm = TRUE)

head(resSig[order(resSig$log2FoldChange, decreasing = TRUE), ], 10)
head(resSig[order(resSig$log2FoldChange, decreasing = FALSE), ], 10)

# Extract each condition vs. WT
res_oxyR <- results(dds, contrast = c("condition", "delta_oxyR", "WT"))

sig_oxyR <- subset(res_oxyR, !is.na(padj) & padj < 0.01)

# Bar plot showing the differential expressed genes

barplot(c(nrow(sig_oxyR)), 
        col = "cornflowerblue",
        names = c("OxyR KO"),
        las = 1,
        ylab = "# Differentially Expressed Genes",
        )

# Plot with fold change >= 1
sig_abs_oxyR <- subset(res_oxyR, !is.na(padj) & padj < 0.01 & abs(log2FoldChange) >= 1)


# Bar plot showing the differential expressed genes

barplot(c(nrow(sig_abs_oxyR)), 
        col = "cornflowerblue",
        names = c("OxyR KO")
        las = 1,
        ylab = "# Differentially Expressed Genes",
)

# Plot PCA

vsd <- vst(dds, blind = TRUE)
plotPCA(vsd, 
        intgroup = "condition")

# Make Summary Tables

oxyR_summary <- data.frame(
  gene = rownames(res_oxyR), 
  log2FC = res_oxyR$log2FoldChange, 
  padj = res_oxyR$padj
)

oxyR_summary <- oxyR_summary[!is.na(oxyR_summary$padj), ]


# Build a summary table
all_genes <- union(
  rownames(res_oxyR)
)

summary_table <- data.frame(
  gene = all_genes,
  oxyR_log2FC = res_oxyR[all_genes, "log2FoldChange"]
)

all_sig_genes <- unique(c(rownames(sig_oxyR)))

summary_sig <- data.frame(
  gene = all_sig_genes, 
  oxyR_log2FC = res_oxyR[all_sig_genes, "log2FoldChange"]
)


# Volcano Plot - OxyR

res_plot_oxyR <- data.frame(res_oxyR)
res_plot_oxyR$col <- 'grey40'

# Set parameters based on paper (log2 fold change ≥ 1 and false discovery rate [FDR] ≤ 0.01) 

res_plot_oxyR$col[res_plot_oxyR$log2FoldChange > 1 &
               res_plot_oxyR$padj < 0.01] <- 'red'
res_plot_oxyR$col[res_plot_oxyR$log2FoldChange < -1 &
               res_plot_oxyR$padj < 0.01] <- 'blue'

plot(res_plot_oxyR$log2FoldChange, 
     -log2(res_plot_oxyR$padj), 
     col = res_plot_oxyR$col, 
     pch = 19, 
     xlab = "Log2(Fold Change)",
     ylab = "-Log2(Adjusted p-value)",
     xlim = c(-8,8),
     cex = 0.7,
     main = "Volcano Plot of ΔoxyR Mutant vs Wild-Type")


# Find genes with log2FC >= 1

filtered <- summary_table %>%
  filter(if_any(c(oxyR_log2FC), ~ abs(.) >= 1))

filtered_sig <- summary_sig %>%
  filter(if_any(c(oxyR_log2FC), ~ abs(.) >= 1))

filtered_all <- summary_table[
  apply(abs(summary_table[, c("oxyR_log2FC")]) >= 1, 1, all),
]

filtered_all_sig <- summary_sig[
  apply(abs(summary_sig[, c("oxyR_log2FC")]) >= 1, 1, all),
]

# Add absolute value of log2FC to summary tables
oxyR_summary$abs_log2FC <- abs(oxyR_summary$log2FC)


# Save summary tables 
write.table(oxyR_summary, 
            "./oxyR_summary.txt",
            sep = "\t",
            row.names = FALSE)

write.table(filtered_sig, 
            "./filtered_sig.txt",
            sep = "\t",
            row.names = FALSE)
