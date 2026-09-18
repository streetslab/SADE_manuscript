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

    - cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
    - bash get_peak_sets.sh
    ## running this to have the Raw peaks, SADE-peaks, CR-peaks, and TSSe-peaks, 
    ##         as well as the 'Union_cell_3set_all_info.tsv' that does not record bc deemed to be noisy by all the 3 methods


    - bash cmp_peak_sets.sh
    ## running this to see differences among peak-sets 

    - bash  annotate_peaks.sh
    ## running this to annotate all the peaks 


    - run /home/syyang/GitRepo/SADE/EDA/F2_prepare_save_rna_in_atac_union_bc_v.ipynb
    ## save rna modality info into h5:  _cell_calling_comparison/Union_3set_rna.h5ad

    - run /home/syyang/GitRepo/SADE/EDA/F2_prepare_unionset_rna_clustering_v.ipynb
    ## save rna gene expression cluster info: _cell_calling_comparison/Union_cell_3set_with_RNA_cluster.tsv
    ##                                        _cell_calling_comparison/Union_3set_rna_with_RNA_cluster.h5ad

    - run /home/syyang/GitRepo/SADE/EDA/F2_prepare_save_rna_RNACR_QC_info_v.ipynb
    ## Add one more column to the 'rna_pass_cr' to 'Union_cell_3set_all_info.tsv' file 
    ## resulting: _cell_calling_comparison/Union_cell_3set_w_RNAQC.tsv file

    - cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
    - bash filter_frag.sh
    ## run this to have the 'union_bc_fragments.bed' that has subset fragments corresponding to the union bc retained by any of the 3 methods

    - cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
    - bash overlap_frag_peaks.sh 
    ## run this to have subset fragments that overlap with each peak set.
    

    ## Able to run 
    ##  /home/syyang/GitRepo/SADE/EDA/F2_union_set_comparison.ipynb

    ## Able to run 
    ##  /home/syyang/GitRepo/SADE_manuscript/EDA/F3_peakset_comparison_v.ipynb

    - bash runAMULET.sh
    ## run this to flag ATAC doublets with AMULET among the union barcodes 
     
    ## Able to run 
    ##   /home/syyang/GitRepo/SADE_manuscript/EDA/F3_unionset_rna_clustering_v.ipynb
    ##   /home/syyang/GitRepo/SADE_manuscript/EDA/F3_sup_unionset_gene_expression_v.ipynb


    - cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
    - bash convert_frag_to_bam.sh
    ## convert fragments .bed file into .bam so that we can do visualization like igv to see those fragments


    ## Able to run 
    ##  /home/syyang/GitRepo/SADE/EDA/F3_FRIP_union_3sets.ipynb

    - bash get_set_frag_bigwig.sh
    ## get fragments corresponding to each filtering methods's barcode set.
    ##                 in the format of .bam as well as .bigwig (For visualization purpose)

    - cd VIB_10xultiome_2_WS3000F/_cell_calling_comparison
    - bash  get_specific_bc_frag_bigwig_p2.sh
    ## Get per barcode fragments
    ##                 in the format of .bam as well as .bigwig (For visualization purpose)
    ## This step takes long (2 whole days or so) due to converting to .bigwig needs to be done per barcode 


    ## Able to run 
    ##  /home/syyang/GitRepo/SADE/EDA/F3_frag_dist_union_3sets_perbarcode_v.ipynb

    ## Able to run the rest of the ipynb
