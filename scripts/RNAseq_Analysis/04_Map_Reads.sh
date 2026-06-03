#!/bin/bash

set -euo pipefail

INDEX="./GCF_000005845.2_ASM584v2_refgenomeindex_bow1"
BOW_THREADS=10
SAM_THREADS=6
INPUT_DIR="RNAseq_files"
OUTPUT_DIR="map_results_bow1"

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob

for R1 in "$INPUT_DIR"/*_1.fastq.gz; do
    SAMPLE=$(basename "$R1" _1.fastq.gz)
    R2="$INPUT_DIR/${SAMPLE}_2.fastq.gz"

    if [[ ! -f "$R2" ]]; then
        echo "Missing pair for $SAMPLE, skipping"
        continue
    fi

    echo "Processing $SAMPLE"

    bowtie -S -p "$BOW_THREADS" \
        -v 2 -X 1000 -3 3 \
        "$INDEX" \
        -1 "$R1" -2 "$R2" \
        2> "$OUTPUT_DIR/${SAMPLE}.out" | \
    samtools view -@ "$SAM_THREADS" -b - | \
    samtools sort -@ "$SAM_THREADS" -o "$OUTPUT_DIR/${SAMPLE}.bam"

    samtools index -@ "$SAM_THREADS" "$OUTPUT_DIR/${SAMPLE}.bam"

    echo "Finished: $SAMPLE"
done
