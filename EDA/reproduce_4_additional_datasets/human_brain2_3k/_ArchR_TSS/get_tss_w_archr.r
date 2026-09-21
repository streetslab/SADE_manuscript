
library(ArchR)
packageVersion("ArchR") #[1] ‘1.0.3’
library(parallel)
set.seed(1)

#inputFiles=c('/mnt/hdd_bob/syy/adipose/atac/res/human_brain2_3k_WS3000/_ArchR_TSS/fragments.tsv.gz')
inputFiles=c('/mnt/hdd_bob/syy/adipose/atac/cr_goldstand/human_brain2_3k/atac_fragments.tsv.gz')
names(inputFiles)='human_brain2_3k'

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
metadata=readRDS("/mnt/hdd_bob/syy/adipose/atac/res/human_brain2_3k_WS3000/_ArchR_TSS/QualityControl/human_brain2_3k/human_brain2_3k-Pre-Filter-Metadata.rds")
write.table(metadata, sep='\t', '/mnt/hdd_bob/syy/adipose/atac/res/human_brain2_3k_WS3000/_ArchR_TSS/QualityControl/human_brain2_3k_Metadata.tsv', row.names=FALSE)
