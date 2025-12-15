setwd("C:/Users/megha/projects/MYC_Project/LAYER1_ChIPseq/Annotation/")
list.files()


chip <- read.csv("MYC_A549_peak_annotations.csv")
head(chip)



#Find overlapping genes between ChIP-seq & DESeq2 DEGs

#Extract gene names from ChIP annotation
colnames(chip)



#extract MYC-bound genes:
chip_genes <- unique(chip$SYMBOL)
length(chip_genes)
head(chip_genes)



#Use your RNA-seq significant DEGs list

sig_genes <- rownames(sig)
length(sig_genes)


#Load the required packages

library(AnnotationDbi)
library(org.Hs.eg.db)



#Make sure sig_genes exists
length(sig_genes)
head(sig_genes)


#Clean the ENSG IDs by removing version numbers
clean_ids <- gsub("\\..*", "", sig_genes)

#check it
head(clean_ids)


# Convert ENSG → SYMBOL
rna_symbols <- mapIds(org.Hs.eg.db,
                      keys = clean_ids,
                      keytype = "ENSEMBL",
                      column = "SYMBOL",
                      multiVals = "first")



#Keep only valid gene symbols
rna_symbols <- unique(rna_symbols[!is.na(rna_symbols)])
length(rna_symbols)
head(rna_symbols)


#Now compute overlap with ChIP-seq genes
#ChIP genes are:
chip_genes <- unique(chip$SYMBOL)


#Compute overlap:
overlap <- intersect(rna_symbols, chip_genes)
length(overlap)
overlap[1:50]





#let's make the final volcano plot with MYC-bound DEGs highlighted in BLUE
#Add gene symbols to DESeq results
res_df$gene_symbol <- rna_symbols[match(rownames(res_df), clean_ids)]





#Define categories for coloring
res_df$category <- "NS"   # Not significant

res_df$category[
  res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1
] <- "DEG"

res_df$category[
  res_df$gene_symbol %in% overlap
] <- "MYC-bound DEG"




# Add clean ENSG IDs
clean_ids <- gsub("\\.\\d+$", "", rownames(res_df))

# Map ENSG → SYMBOL
res_df$gene_symbol <- mapIds(
  org.Hs.eg.db,
  keys = clean_ids,
  keytype = "ENSEMBL",
  column = "SYMBOL",
  multiVals = "first"
)




overlap <- overlap[!is.na(overlap)]




# Default: NS
res_df$category <- "NS"

# Regular DEGs
res_df$category[
  res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1
] <- "DEG"

# MYC-bound DEGs
res_df$category[
  !is.na(res_df$gene_symbol) & res_df$gene_symbol %in% overlap
] <- "MYC-bound DEG"








ggplot(res_df, aes(x = log2FoldChange, y = -log10(padj), color = category)) +
  geom_point(alpha = 0.7, size = 1.8) +
  scale_color_manual(values = c(
    "NS"         = "gray70",
    "DEG"        = "red",
    "MYC-bound DEG" = "blue"
  )) +
  geom_vline(xintercept = c(-1, 1), color = "black", linetype = "dashed") +
  geom_hline(yintercept = -log10(0.05), color = "black", linetype = "dashed") +
  labs(
    title = "Volcano Plot: MYC-bound DEGs Highlighted",
    x = "log2 Fold Change",
    y = "-log10 Adjusted p-value"
  ) +
  theme_bw(base_size = 14)




# Create folder if it doesn't exist
dir.create("plots", showWarnings = FALSE)

# Save volcano plot (with MYC-bound genes highlighted)
png("plots/Volcano_MYC_bound_DEGs.png", width = 2400, height = 2000, res = 200)

ggplot(res_df, aes(x = log2FoldChange, y = -log10(padj), color = category)) +
  geom_point(alpha = 0.7, size = 1.8) +
  scale_color_manual(values = c(
    "NS" = "gray70",
    "DEG" = "red",
    "MYC-bound DEG" = "blue"
  )) +
  geom_vline(xintercept = c(-1, 1), color = "black", linetype = "dashed") +
  geom_hline(yintercept = -log10(0.05), color = "black", linetype = "dashed") +
  labs(
    title = "Volcano Plot: MYC-bound DEGs Highlighted",
    x = "log2 Fold Change",
    y = "-log10 Adjusted p-value"
  ) +
  theme_bw(base_size = 14)

dev.off()
