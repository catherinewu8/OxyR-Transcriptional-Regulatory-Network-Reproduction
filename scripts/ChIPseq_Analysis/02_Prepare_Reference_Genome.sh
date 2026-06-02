#!/bin/bash

#SBATCH --chdir=/home/c/catherinewu/MidtermProject/
#SBATCH --job-name=refGenome
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

bowtie2-build /home/c/catherinewu/MidtermProject/genome/GCF_000005845.2_ASM584v2_genomic.fna /home/c/catherinewu/MidtermProject/genome/GCF_000005845.2_ASM584v2_genomic
