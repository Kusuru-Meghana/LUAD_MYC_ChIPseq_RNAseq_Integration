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


## How the integration works

- MYC ChIP-seq peaks were annotated to nearby genes to define a set of MYC-bound genes.

- RNA-seq was used to identify genes whose expression changes after MYC knockdown.

- Gene identifiers were matched and intersected to find genes that are both MYC-bound and differentially expressed.

- This overlapping gene set was analyzed using GO, KEGG, and Reactome pathway enrichment.

## Results

The genes directly regulated by MYC are strongly enriched for processes related to:

- Ribosome biogenesis

- rRNA processing

- Translation initiation and elongation

- RNA metabolism and quality control

This supports the idea that MYC directly drives the protein-production machinery needed for rapid cancer cell growth. The enrichment plots and integration visualizations are shown in the ```figures/``` folder.

## Repository layout
```
data/      Processed input data (ChIP annotations, RNA-seq DEGs)
scripts/   Integration and enrichment analysis code
results/   Final list of direct MYC target genes
figures/   Enrichment plots and visual summaries
```


## How to reproduce

Run the scripts in order:

```01_overlap_chip_rna.R``` - identifies MYC-bound DEGs

```02_enrichment_overlap.R``` - performs GO, KEGG, and Reactome enrichment


## Summary

By integrating MYC binding with transcriptional response, this project narrows thousands of MYC binding events down to a biologically meaningful set of direct MYC targets in lung adenocarcinoma. These targets are heavily involved in translation and ribosome biology, highlighting MYC’s role as a driver of cellular growth programs in cancer.


## Author

Meghana Kusuru
Bioinformatics & Computational Biology
University of Delaware
