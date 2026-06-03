#!/bin/bash

set -euo pipefail

# --------------------
# User inputs
# --------------------

BAM_DIR="./map_results_bow1"
GTF="./GCF_000005845.2_ASM584v2_genomic.gtf.gz"
OUTDIR="./raw_counts_bow1"
THREADS=8

# --------------------
# Create output 
# --------------------

mkdir -p "$OUTDIR"

# --------------------
# Find all BAM files
# --------------------

shopt -s nullglob

BAMS=("$BAM_DIR"/*.bam)

# Safety check
if [ ${#BAMS[@]} -eq 0 ]; then
    echo "ERROR: No BAM files found in $BAM_DIR"
    exit 1
fi

# --------------------
# Run featureCounts
# --------------------

featureCounts \
	-T "$THREADS" \
	-a "$GTF" \
	-o "$OUTDIR/raw_counts.txt" \
	-t gene \
	-g gene \
	-s 0 \
	-p --countReadPairs \
	"${BAMS[@]}"

echo "featureCounts finished. Output: $OUTDIR/raw_counts.txt"

