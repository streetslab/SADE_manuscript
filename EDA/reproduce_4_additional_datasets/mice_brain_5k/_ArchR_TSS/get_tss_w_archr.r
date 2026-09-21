
library(ArchR)
packageVersion("ArchR") #[1] ‘1.0.3’
library(parallel)
set.seed(1)

#inputFiles=c('/mnt/hdd_bob/syy/adipose/atac/res/mice_brain_5k_WS3000/_ArchR_TSS/fragments.tsv.gz')
inputFiles=c('/mnt/hdd_bob/syy/adipose/atac/cr_goldstand/mice_brain_5k/fragments.tsv.gz')
names(inputFiles)='mice_brain_5k'

addArchRGenome("mm10")
addArchRThreads(threads = 32) 

ArrowFiles <- createArrowFiles(
  inputFiles = inputFiles,
  sampleNames = names(inputFiles),
  minTSS = 4, #Dont set this too high because you can always increase later
  minFrags = 1000, 
  addTileMat = TRUE,
  addGeneScoreMat = TRUE
)


## Save ArchR results to dataframe
metadata=readRDS("/mnt/hdd_bob/syy/adipose/atac/res/mice_brain_5k_WS3000/_ArchR_TSS/QualityControl/mice_brain_5k/mice_brain_5k-Pre-Filter-Metadata.rds")
write.table(metadata, sep='\t', '/mnt/hdd_bob/syy/adipose/atac/res/mice_brain_5k_WS3000/_ArchR_TSS/QualityControl/mice_brain_5k_Metadata.tsv', row.names=FALSE)
