#!/bin/bash

#SBATCH --chdir=/home/c/catherinewu/MidtermProject/
#SBATCH --job-name=CHIPseqPeakCalling
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=10000
#SBATCH -t 00:15:00
#SBATCH -o run.out
#SBATCH -e run.err
#SBATCH --mail-user=catherinewu@usf.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module purge
module add apps/miniconda/3.6.1-intel
unset PYTHONPATH
/shares/phc7736.001s26.cw/tools/macs2_env/bin/macs2 callpeak -t SRR1796591.bam -n MACSpeaks_OxyR -q 0.05 -g 4639675 --keep-dup 1 --nomodel --extsize 400
/shares/phc7736.001s26.cw/tools/macs2_env/bin/macs2 callpeak -t SRR1796593.bam -n MACSpeaks_SoxR -q 0.05 -g 4639675 --keep-dup 1 --nomodel --extsize 400
/shares/phc7736.001s26.cw/tools/macs2_env/bin/macs2 callpeak -t SRR1796595.bam -n MACSpeaks_SoxS -q 0.05 -g 4639675 --keep-dup 1 --nomodel --extsize 400
