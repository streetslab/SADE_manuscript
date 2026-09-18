
export Genrich='/home/syyang/GitRepo/Genrich/./Genrich'

bamfile='/mnt/hdd_bob/syy/adipose/atac/protocol_benchmark/cr_results/atac/VIB_10xmultiome_2/outs/possorted_bam.bam'
pres_dir='/mnt/hdd_bob/syy/adipose/atac/res/VIB_10xmultiome_2_WS3000F'

ref_blacklist_region='/home/syyang/GitRepo/SADE/ref/hg38/hg38-blacklist.bed'


output_dir=${pres_dir}/_cell_calling_comparison



Raw_peak_dir=${output_dir}/Rawpeaks
Entropy_peak_dir=${output_dir}/Entropy_cells_peaks
FRIP_peak_dir=${output_dir}/FRIP_cells_peaks
TSS_peak_dir=${output_dir}/TSS_cells_peaks


mkdir -p ${FRIP_peak_dir} ${TSS_peak_dir} 
mkdir -p ${Entropy_peak_dir} ${Raw_peak_dir}
cp /mnt/hdd_bob/syy/adipose/atac/res/VIB_10xmultiome_2_WS3000F/Entropy_filtered_bc_CBZ.txt  ${Entropy_peak_dir}/Entropy_filtered_bc_CBZ.txt
cp ${bamfile} ${Raw_peak_dir}/possorted_bam.bam

# for Raw peaks that uses all reads 
bash ${pres_dir}/scripts/call_peaks.sh -s ${Raw_peak_dir}/possorted_bam.bam \
	-o ${Raw_peak_dir}
bedtools subtract -a ${Raw_peak_dir}/peaks_w_blacklistregion.bed  -b ${ref_blacklist_region}  > ${Raw_peak_dir}/peaks.bed


# for FRIP filtered cells' peaks
cp '/mnt/hdd_bob/syy/adipose/atac/res/VIB_10xmultiome_2_WS3000F/_CR_FRIP/barcodes.tsv' ${FRIP_peak_dir}/CR_barcodes.tsv
awk -v OFS='' -v prefix='CB:Z:' '{print prefix, $1}'  ${FRIP_peak_dir}/CR_barcodes.tsv > ${FRIP_peak_dir}/CR_filtered_bc_CBZ.txt

bash ${pres_dir}/scripts/filter_bam_w_bc.sh -s ${bamfile} \
	                -o ${FRIP_peak_dir}  \
			-f ${FRIP_peak_dir}/CR_filtered_bc_CBZ.txt


bash ${pres_dir}/scripts/call_peaks.sh -s ${FRIP_peak_dir}/filtered.bam \
	-o ${FRIP_peak_dir}
bedtools subtract -a ${FRIP_peak_dir}/peaks_w_blacklistregion.bed  -b ${ref_blacklist_region}  > ${FRIP_peak_dir}/peaks.bed


# For TSS filtered cells' peaks
cp ${pres_dir}/_ArchR_TSS/TSS_pass_bc_CBZ.txt  ${TSS_peak_dir}/TSS_filtered_bc_CBZ.txt

bash ${pres_dir}/scripts/filter_bam_w_bc.sh -s ${bamfile} \
	                -o ${TSS_peak_dir} \
			-f ${TSS_peak_dir}/TSS_filtered_bc_CBZ.txt

bash /home/syyang/GitRepo/atac/call_peaks.sh -s ${TSS_peak_dir}/filtered.bam \
	-o  ${TSS_peak_dir} 
bedtools subtract -a ${TSS_peak_dir}/peaks_w_blacklistregion.bed  -b ${ref_blacklist_region}  > ${TSS_peak_dir}/peaks.bed

# for Entropy filtered cells' peaks 
cp ${pres_dir}/Entropy_filtered_bc_CBZ.txt  ${Entropy_peak_dir}/Entropy_filtered_bc_CBZ.txt
bash ${pres_dir}/scripts/filter_bam_w_bc.sh -s ${bamfile} \
	                -o ${Entropy_peak_dir}  \
			-f ${Entropy_peak_dir}/Entropy_filtered_bc_CBZ.txt

bash ${pres_dir}/scripts/call_peaks.sh -s ${Entropy_peak_dir}/filtered.bam \
	-o ${Entropy_peak_dir}
bedtools subtract -a ${Entropy_peak_dir}/peaks_w_blacklistregion.bed  -b ${ref_blacklist_region}  > ${Entropy_peak_dir}/peaks.bed




#
# --- Infer peaks with common cells (ie. those cells that are called by all 3 filtering methods)
Commoncells_peaks_dir=${output_dir}/Commoncells_peaks
mkdir -p ${Commoncells_peaks_dir}
awk -F '\t' -v OFS='' -v prefix='CB:Z:' '{if ($8=="common" ) print prefix, $1}'  ${output_dir}/Union_cell_3set.tsv > ${Commoncells_peaks_dir}/Commoncells_bc_CBZ.txt

bash ${pres_dir}/scripts/filter_bam_w_bc.sh -s ${bamfile} \
                        -o ${Commoncells_peaks_dir}  \
                        -f ${Commoncells_peaks_dir}/Commoncells_bc_CBZ.txt
bash ${pres_dir}/scripts/call_peaks.sh -s ${Commoncells_peaks_dir}/filtered.bam \
        -o ${Commoncells_peaks_dir}
bedtools subtract -a ${Commoncells_peaks_dir}/peaks_w_blacklistregion.bed  -b ${ref_blacklist_region}  > ${Commoncells_peaks_dir}/peaks.bed



# # --- Infer peaks with union cells 
# Unioncells_peak_dir=${output_dir}/Union_cells_peaks
# mkdir -p ${Unioncells_peak_dir}
# awk -F '\t' -v OFS='\t' '{if ($8 != "none") print $0}'  ${output_dir}/Union_cell_3set_all_info.tsv >  ${output_dir}/Union_cell_3set.tsv
# awk -F '\t' -v OFS="" -v prefix=CB:Z: 'NR>1 {print prefix, $1}' ${output_dir}/Union_cell_3set.tsv  > ${output_dir}/Union_cells_bc_CBZ.txt
# cp ${output_dir}/Union_cells_bc_CBZ.txt   ${Unioncells_peak_dir}/Union_cells_bc_CBZ.txt

# bash ${pres_dir}/scripts/filter_bam_w_bc.sh -s ${bamfile} \
# 	                -o ${Unioncells_peak_dir}  \
# 			-f ${Unioncells_peak_dir}/Union_cells_bc_CBZ.txt

# bash ${pres_dir}/scripts/call_peaks.sh -s ${Unioncells_peak_dir}/filtered.bam \
# 	-o ${Unioncells_peak_dir}
# bedtools subtract -a ${Unioncells_peak_dir}/peaks_w_blacklistregion.bed  -b ${ref_blacklist_region}  > ${Unioncells_peak_dir}/peaks.bed

# 
#
# Remove those filtered bam files to save space
# rm -rf ${FRIP_peak_dir}/filtered.bam 
# rm -f ${TSS_peak_dir}/filtered.bam 
# rm -f ${Entropy_peak_dir}/filtered.bam 
# rm -f ${Commoncells_peaks_dir}/filtered.bam
#rm -f ${Unioncells_peak_dir}/filtered.bam