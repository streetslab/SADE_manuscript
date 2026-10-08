#!/bin/bash
cCREs_annotation_file='/home/syyang/GitRepo/atac/ref/hg38/GRCh38-cCREs.bed'


res_dir='/mnt/hdd_bob/syy/adipose/atac/res/VIB_10xmultiome_2_WS3000F/_cell_calling_comparison'

peak_set_list="lost_peaks newly_discovered_peaks recovered_peaks"

# CRpeak vs Rawpeaks 
cmp_peak_dir=${res_dir}/FRIPpeaks_vs_Rawpeaks

cCRE_subdir=${cmp_peak_dir}/cCRE_annotation
mkdir -p ${cCRE_subdir}
for f in $peak_set_list; do
    bedtools intersect -wao -a ${cmp_peak_dir}/${f}.bed \
    -b $cCREs_annotation_file > ${cCRE_subdir}/cCRE_annot_${f}.bed  #intersection
done


# SADEpeaks vs Rawpeaks 
cmp_peak_dir="${res_dir}/Entropypeaks_vs_Rawpeaks"

cCRE_subdir=${cmp_peak_dir}/cCRE_annotation
mkdir -p ${cCRE_subdir}
for f in $peak_set_list; do
    bedtools intersect -wao -a ${cmp_peak_dir}/${f}.bed \
    -b $cCREs_annotation_file > ${cCRE_subdir}/cCRE_annot_${f}.bed  #intersection
done

# TSSPeaks vs Rawpeaks 
cmp_peak_dir="${res_dir}/TSSpeaks_vs_Rawpeaks"

cCRE_subdir=${cmp_peak_dir}/cCRE_annotation
mkdir -p ${cCRE_subdir}
for f in $peak_set_list; do
    bedtools intersect -wao -a ${cmp_peak_dir}/${f}.bed \
    -b $cCREs_annotation_file > ${cCRE_subdir}/cCRE_annot_${f}.bed  #intersection
done