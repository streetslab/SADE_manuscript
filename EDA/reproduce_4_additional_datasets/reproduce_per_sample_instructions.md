# Steps to Reproduce SADE Results on additional 4 datasets

1. Download each sample’s CellRanger output from 10x (link provided in the manuscript).

2. Run SADE using the scripts in:
   `GitRepo/SADE_manuscript/EDA/Step2_run_sade_on_samples/*sh`

   Update the output directory for each sample before running.

3. Copy the entire subfolder from:
   `GitRepo/SADE_manuscript/EDA/reproduce_4_additional_datasets/`
   into each sample’s SADE result directory.

4. Run the scripts from inside the result directory.

   **Note:** Run each script from the directory where you want the output saved, because outputs are written to the current working directory.

5. You would then be able to run the *ipynb files within `GitRepo/SADE_manuscript/EDA/`

   
## Example: `human_10k_1`

### Run SADE filtering on the fragments
```bash
bash GitRepo/SADE_manuscript/EDA/Step2_run_sade_on_samples/auto_process_human_10k_1.sh
## SADE Results is saved in human_10k_1_WS3000
```

### Copy scripts into SADE's output directory to prepare filtering comparison analysis
```
cp -r GitRepo/SADE_manuscript/EDA/reproduce_4_additional_datasets/human_10k_1 human_10k_1_WS3000/.
cd human_10k_1_WS3000
```

### Run ArchR TSSe filtering analysis (R required)
```R
cd human_10k_1_WS3000
Rscript human_10k_1_WS3000/_ArchR_TSS/get_tss_w_archr.r
```
### Get CellRanger filtering results from copying from your download
```
cd human_10k_1_WS3000
bash human_10k_1_WS3000/_CR_FRIP/get_CR_barcodes.sh
```

### Run Genrich to get raw-peak set inferred with all reads
```
bash human_10k_1_WS3000/_cell_calling_comparison/get_peak_sets.sh
bash human_10k_1_WS3000/_cell_calling_comparison/overlap_frag_peaks.sh
```

### Now you are able to run 
`sup_otherdataset2_comparison_human_10k.ipynb` within `GitRepo/SADE_manuscript/EDA/`
