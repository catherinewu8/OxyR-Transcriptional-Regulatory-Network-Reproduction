#!/bin/bash

mkdir -p qc_results

max_jobs=5

for file in ./RNAseq_files/*.fastq.gz
do
  fastqc "$file" -o qc_results -t 2 &

  # limit number of parallel jobs
  while [ "$(jobs -r | wc -l)" -ge "$max_jobs" ]; do
    sleep 1
  done
done

wait
