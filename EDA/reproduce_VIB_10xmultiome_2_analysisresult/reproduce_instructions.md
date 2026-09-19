# SADE / VIB_10xultiome_2 Workflow

## 1) Run SADE on the sample
```bash
bash sade.sh sample/fragments.tsv.gz -o VIB_10xultiome_2_WS3000F

```
Able to run 
```  /home/syyang/GitRepo/SADE/EDA/F1_demo_v.ipynb  ```

## 2) Prepare intermediate results

Go to the manuscript branch analysis folder:
```bash
bash local_SADE_manuscript/EDA/reproduce_VIB_10xmultiome_2_analysisresult/cp_scripts_to_resfolder.sh
```
Now you should have all the scripts in ```local_SADE_manuscript/EDA/Step3_script_for_intermediate_results/*``` copied into ```VIB_10xultiome_2_WS3000F```


### 2.1 ArchR TSS processing
```bash
cd VIB_10xultiome_2_WS3000F/_ArchR_TSS
bash prepare_frag_for_archr.sh 
```
Now you should have ArchR-TSSe filtering results, its filtered barcodes in the ```VIB_10xmultiome_2_WS3000F/_ArchR_TSS/``` subfolder

### 2.2 CellRanger (filtered with FRIP) barcodes
```bash
VIB_10xultiome_2_WS3000F/_CR_FRIP
bash get_CR_barcodes.sh
```
### 2.3 Prepare union-cell information    
Run:    
* ``` /home/syyang/GitRepo/SADE/EDA/F2_prepare_data.ipynb ```    
This creates:    
* ```Union_cell_3set_all_info.tsv``` within the ```VIB_10xmultiome_2_WS3000F/_cell_calling_comparison```   
**Notes**   Barcodes not in the union barcodes are flagged but still kept. 



## 3) Prepare peak sets

### 3.1 Generate peak sets 

```
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash get_peak_sets.sh
```
This produces:

* Raw peaks (use all reads in the experiment),
* SADE-peaks (use reads only in SADE-filtered bc),
* CR-peaks (also named as FRIP-peaks. use reads only in CellRanger-filtered bc),
* TSSe-peaks (use reads only in ArchR-TSSe-filtered bc),
* Common-peaks (use reads in bc retained by all three filtering methods)
* `Union_cell_3set_all_info.tsv` that does not record bc deemed to be noisy by all the 3 methods


### 3.1 Compare peak sets 

Run:
```bash
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash cmp_peak_sets.sh
```
This finds intersections and unique peaks between peak-set pairs.

### 3.1 Annotate peak sets  
Run:
```bash
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash  annotate_peaks.sh
```
This annotates all the peaks.


## 4) Prepare RNA modality info

### 4.1 
- Run
```
/home/syyang/GitRepo/SADE/EDA/F2_prepare_save_rna_in_atac_union_bc_v.ipynb
```
This creates
* RNA gene expression corresponding to the union bc into `Union_3set_rna.h5ad` within `VIB_10xultiome_2_WS3000F/_cell_calling_comparison`

### 4.2 
- Run
```
/home/syyang/GitRepo/SADE/EDA/F2_prepare_unionset_rna_clustering_v.ipynb
```
This creates:
* rna gene expression cluster info: _cell_calling_comparison/Union_cell_3set_with_RNA_cluster.tsv
* together with its h5ad that has the gene expression _cell_calling_comparison/Union_3set_rna_with_RNA_cluster.h5ad

### 4.3 
- Run 
```
/home/syyang/GitRepo/SADE/EDA/F2_prepare_save_rna_RNACR_QC_info_v.ipynb
```
This creates:
* `Union_cell_3set_w_RNAQC.tsv` within `VIB_10xultiome_2_WS3000F/_cell_calling_comparison/`    
   **Note** this files adds more column about RNA-quality 'rna_pass_cr' to 'Union_cell_3set_all_info.tsv' file 
 
## 5) Prepare fragments file for visualization

### 5.1
- Run 
```bash
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash filter_frag.sh
```
This creates: 
*  `union_bc_fragments.bed` within `VIB_10xultiome_2_WS3000F/_cell_calling_comparison/`    
**Note** this files has subset fragments corresponding to the union bc retained by any of the 3 methods

### 5.2
```bash
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash overlap_frag_peaks.sh
```
This creates:
* fragment subsets from barcodes that correspond to each peak set.
    

### 5.3
- Run 
```
/home/syyang/GitRepo/SADE/EDA/F2_union_set_comparison.ipynb
```

- Run
```
/home/syyang/GitRepo/SADE_manuscript/EDA/F3_peakset_comparison_v.ipynb
```

- Run

```
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash runAMULET.sh
```
This creates:
* flag ATAC doublets with AMULET among the union barcodes under `VIB_10xultiome_2_WS3000F/_cell_calling_comparison/AMULET_output`
     
- Now able to run
```
/home/syyang/GitRepo/SADE_manuscript/EDA/F3_unionset_rna_clustering_v.ipynb
/home/syyang/GitRepo/SADE_manuscript/EDA/F3_sup_unionset_gene_expression_v.ipynb
```


- Run 
```
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash convert_frag_to_bam.sh
```
This converts fragments .bed file into .bam so that we can do visualization like igv to see those fragments distribution along the 

- Able to run 
```
/home/syyang/GitRepo/SADE/EDA/F3_FRIP_union_3sets.ipynb
```

- Run
```
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash get_set_frag_bigwig.sh
```
This gets:
* fragments corresponding to each filtering methods's barcode set.
* converting them to `.bam` as well as `.bigwig` (For visualization purpose)

- Run
```
cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
bash  get_specific_bc_frag_bigwig_p2.sh
```
This gets:
* per barcode fragments
* in the format of .bam as well as .bigwig (For visualization purpose)
**Note** This step takes long (2 whole days or so) due to converting to .bigwig needs to be done per barcode 


- Able to run
```
/home/syyang/GitRepo/SADE/EDA/F3_frag_dist_union_3sets_perbarcode_v.ipynb
```
- Able to run the rest of the `.ipynb` files
