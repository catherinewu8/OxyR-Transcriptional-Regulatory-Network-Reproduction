#!/bin/bash

#SBATCH --chdir=/~/
#SBATCH --job-name=refGenomeDownload
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

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gff.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gtf.gz
