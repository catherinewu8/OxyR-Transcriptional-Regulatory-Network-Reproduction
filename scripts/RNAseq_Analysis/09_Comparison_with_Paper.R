
# Set working directory
setwd('./')

# Load libraries
library("openxlsx")

# Download data from paper
# https://www.cell.com/cms/10.1016/j.celrep.2015.07.043/attachment/f2708919-6f96-4a8f-8f0d-0a38c4908503/mmc3.xlsx

oxyR <- read.xlsx("./mmc3.xlsx",
                  startRow = 2) 

oxyR$abslog2FC <- abs(oxyR$`fold.change.(log2.DoxyR/wt)`)
