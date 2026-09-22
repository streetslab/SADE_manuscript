
library(ArchR)
packageVersion("ArchR") #[1] ‘1.0.3’
library(parallel)
set.seed(1)

inputFiles=c('/mnt/hdd_bob/syy/adipose/atac/cr_goldstand/human_10k_1/10k_pbmc_ATACv1p1_nextgem_Chromium_X_fragments.tsv.gz')
names(inputFiles)='human_10k'

addArchRGenome("hg38")
addArchRThreads(threads = 16) 

ArrowFiles <- createArrowFiles(
  inputFiles = inputFiles,
  sampleNames = names(inputFiles),
  minTSS = 4, #Dont set this too high because you can always increase later
  minFrags = 1000, 
  addTileMat = TRUE,
  addGeneScoreMat = TRUE
)


## Save ArchR results to dataframe
metadata=readRDS("/mnt/hdd_bob/syy/adipose/atac/res/human_10k_1_WS3000/_ArchR_TSS/QualityControl/human_10k/human_10k-Pre-Filter-Metadata.rds")
write.table(metadata, sep='\t', '/mnt/hdd_bob/syy/adipose/atac/res/human_10k_1_WS3000/_ArchR_TSS/QualityControl/human_10k_Metadata.tsv', row.names=FALSE)
