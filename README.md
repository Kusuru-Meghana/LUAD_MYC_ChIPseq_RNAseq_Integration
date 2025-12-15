# LUAD_MYC_ChIPseq_RNAseq_Integration

## LUAD MYC ChIP-seq + RNA-seq Integration
## Why this project

MYC is a major oncogene in lung adenocarcinoma, but one challenge with MYC biology is that it binds thousands of places across the genome. Not every binding event leads to real changes in gene expression.

The goal of this project was simple: figure out which MYC-bound genes are actually functionally regulated in LUAD cells.

To do that, I integrated MYC ChIP-seq data with RNA-seq data following MYC knockdown in A549 cells. By combining where MYC binds with how gene expression changes when MYC is removed, I identified a high-confidence set of direct MYC target genes.


## Biological Question
Which genes are directly controlled by MYC in lung adenocarcinoma when considering both DNA binding and transcriptional response?

## Data Sources

This analysis builds on two separate pipelines that I ran independently:

MYC ChIP-seq analysis (peak calling and gene annotation):
https://github.com/Kusuru-Meghana/LUAD_MYC_ChIPseq

RNA-seq differential expression analysis (siMYC vs control):
https://github.com/Kusuru-Meghana/LUAD_MYC_RNAseq

For this repository, I only use the processed, gene-level outputs from those analyses.
