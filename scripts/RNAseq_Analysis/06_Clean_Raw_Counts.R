# Set working directory
setwd('./')

# Load libraries
library("dplyr")
library("stringr")

# Load data
rawcounts <- read.table('./raw_counts.txt',
                        header = TRUE, 
                        sep = "\t")
samplenames <- data.frame(
  run = c("SRR1796598", "SRR1796599", "SRR1796600", "SRR1796601"),
  sample = c("WT_1", "WT_2", "delta_oxyR_1", "delta_oxyR_2")
)

# Change column headers
runs <- str_extract(colnames(rawcounts[7:10]), "SRR[0-9]+")
colnames(rawcounts)[7:10] <- samplenames$sample[match(runs, samplenames$run)]

# Remove NA
rawcounts <- rawcounts[!is.na(rawcounts$Length), ]

# Save clean table
write.table(rawcounts,
            file = "./raw_counts_clean_bow1.txt", 
            sep = "\t", 
            row.names = F)
