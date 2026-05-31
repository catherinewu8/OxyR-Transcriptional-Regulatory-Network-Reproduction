#!/bin/bash

#SBATCH --chdir=/home/c/catherinewu/MidtermProject/
#SBATCH --job-name=fastqc
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
module add apps/fastqc/0.11.5

# Perform Quality Control of the Reads

# OxyR
fastqc SRR1796591.fastq.gz
