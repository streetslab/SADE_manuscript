
SCRIPT_DIR='/home/syyang/GitRepo/SADE_manuscript/EDA/reproduce_4_additional_datasets'
black_list_region_file='/home/syyang/GitRepo/SADE/ref/hg38/hg38-blacklist.bed'


bamfile='/mnt/hdd_bob/syy/adipose/atac/cr_goldstand/human_10k_1/10k_pbmc_ATACv1p1_nextgem_Chromium_X_possorted_bam.bam'

pres_dir='/mnt/hdd_bob/syy/adipose/atac/res/human_10k_1_WS3000'


output_dir=${pres_dir}/_cell_calling_comparison


Raw_peak_dir=${output_dir}/Rawpeaks

mkdir -p ${Raw_peak_dir}
## for Raw peaks that uses all reads 
bash ${SCRIPT_DIR}/call_peaks.sh -s ${bamfile} \
	-o ${Raw_peak_dir}
bedtools subtract -a ${Raw_peak_dir}/peaks_w_blacklistregion.bed  -b ${black_list_region_file} > ${Raw_peak_dir}/peaks.bed

