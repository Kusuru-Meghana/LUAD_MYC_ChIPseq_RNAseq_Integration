setwd("C:/Users/megha/projects/MYC_Project/Layer _1 & 2/overlap")
getwd() 

#Get MYC-bound DEGs


overlap_genes <- read.csv("MYC_CHIP_RNA_overlap_genes.csv", header = TRUE)
overlap_genes <- overlap_genes[,1]   # ensure vector
length(overlap_genes)
head(overlap_genes)



#Convert SYMBOL → ENTREZ IDs

library(org.Hs.eg.db)
library(clusterProfiler)

entrez <- mapIds(org.Hs.eg.db,
                 keys = overlap_genes,
                 keytype = "SYMBOL",
                 column = "ENTREZID",
                 multiVals = "first")

entrez <- na.omit(unique(entrez))
length(entrez)


#GO Biological Process Enrichment
ego_overlap <- enrichGO(gene         = entrez,
                        OrgDb        = org.Hs.eg.db,
                        keyType      = "ENTREZID",
                        ont          = "BP",
                        pAdjustMethod = "BH",
                        pvalueCutoff  = 0.05,
                        qvalueCutoff  = 0.05)

head(ego_overlap)



png("GO_BP_MYC_overlap_dotplot.png", width=2000, height=1800, res=200)
dotplot(ego_overlap, showCategory = 20) +
  ggtitle("GO BP Enrichment: MYC-bound + RNA-regulated Genes")
dev.off()



#KEGG Pathway Enrichment
ekegg_overlap <- enrichKEGG(gene     = entrez,
                            organism = "hsa",
                            pvalueCutoff = 0.05)

head(ekegg_overlap)


png("KEGG_MYC_overlap_dotplot.png", width=2000, height=1800, res=200)
dotplot(ekegg_overlap, showCategory = 20) +
  ggtitle("KEGG Pathways: MYC-bound RNA-regulated Genes")
dev.off()




#Reactome Pathway Enrichment
library(ReactomePA)

ereact_overlap <- enrichPathway(
  gene = entrez,
  organism = "human",
  pvalueCutoff = 0.05
)

head(ereact_overlap)

png("Reactome_MYC_overlap_dotplot.png", width=2000, height=1800, res=200)
dotplot(ereact_overlap, showCategory = 20) +
  ggtitle("Reactome Enrichment: Direct MYC Target Pathways")
dev.off()



