# Download each Sample's CellRanger output from 10x (link is in manuscript)

# Run SADE with scripts in `GitRepo/SADE_manuscript/EDA/Step2_run_sade_on_samples/*sh` for each sample after you modify the output-directory

# Copy and paste the whole subfolder within `GitRepo/SADE_manuscript/EDA/reproduce_4_additional_datasets' into each sample's SADE resulting directory.
# bash `cd` to the directory and run the scripts within 
**Note** : run the script at the directory exactly where the script is because the output is saved to the current directory you executed the script.)
For example for sample 'human_10k_1' sample
```bash
bash GitRepo/SADE_manuscript/EDA/Step2_run_sade_on_samples/auto_process_human_10k_1.sh
## SADE Results is saved in human_10k_1_WS3000
```

You then 
```
cp -r GitRepo/SADE_manuscript/EDA/reproduce_4_additional_datasets/human_10k_1 human_10k_1_WS3000/.
cd human_10k_1_WS3000
```

```
# Run (Needs R)
```R
cd human_10k_1_WS3000
Rscript human_10k_1_WS3000/_ArchR_TSS/get_tss_w_archr.r
```
# and run
```
cd human_10k_1_WS3000
bash human_10k_1_WS3000/_CR_FRIP/get_CR_barcodes.sh
```

# and run 
```
bash human_10k_1_WS3000/_cell_calling_comparison/get_peak_sets.sh
bash human_10k_1_WS3000/_cell_calling_comparison/overlap_frag_peaks.sh
```