# Set working directory
setwd('./')

# Load libraries


# Load data
df <- read.table("./raw_counts_clean_bow1.txt",
                     header = T, 
                     sep = "\t",
                     row.names = 1
                     )

# Make a table for the counts only
c <- df[,6:9]
rownames(c) <- rownames(df)

# Calculate FPKM

fpkm <- apply(c, 2, function(x) {x * 10^9/df$Length/sum(x)})

# Save FPKM table

write.table(fpkm, 
            "./raw_counts_bow1/fpkm_bow1.txt",
            sep = "\t",
            row.names = T)

# Identify infinite values

id <- which(apply(log2(fpkm), 1, function(x) all(is.finite(x))))

# Boxplot of FPKM

par(mar = c(8, 6, 4, 2))
colors = c("cornflowerblue", "cornflowerblue", "thistle", "thistle")
boxplot(log2(fpkm)[id,],
        col = colors, 
        medcol = rep('gray90', 4),
        border = colors,
        las = 2,
        cex.axis = 0.8, 
        ylab = "Log2(FPKM)",
        xlab = "",
        names = colnames(fpkm),
        main = "Boxplots of Wild-Type and Deletion Mutants")
mtext("Samples", 
      side = 1, 
      line = 6)
