# OxyR-Transcriptional-Regulatory-Network-Reproduction
Partial reproduction of the OxyR transcription factor regulatory network in E. coli under oxidative stress, based on Seo et al. (2015), including peak calling (using MACS2 instead of MACE) and identification of candidate target genes of the transcription factor from the ChIP-seq data. Differentially Expressed Genes in the bulk RNA-seq data were analyzed and used to investigate potential pathways. 

SLURM in an HPC system was used for the ChIP-seq data analysis whereas a local machine was used for bulk RNA-seq analysis while utilizing multiple cores for parallel computing. 

## License
This work is licensed under the terms of the MIT License:

Copyright (c) 2026 Catherine Wu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

# User Guide and Project Structure

## Requirements
- Linux/Unix environment
- BASH
- R (4.0+)
- Bowtie
- Bowtie 2
