#!/bin/bash

#SBATCH --chdir=/home/c/catherinewu/MidtermProject/
#SBATCH --job-name=ChIPseqMapping
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=15000
#SBATCH -t 00:15:00
#SBATCH -o run.out
#SBATCH -e run.err
#SBATCH --mail-user=catherinewu@usf.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module purge

module add apps/bowtie/2.3.5.1

bowtie2 -x GCF_000005845.2_ASM584v2_genomic -3 2 -q SRR1796591.fastq.gq -S SRR1796591.sam 2> SRR1796591.out

module add apps/samtools/1.11

samtools view -u SRR1796591.sam | samtools sort -o SRR1796591.bam
samtools index SRR1796591.bam
