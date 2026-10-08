#!/bin/bash

res_dir='/mnt/hdd_bob/syy/adipose/atac/res/VIB_10xmultiome_2_WS3000F/_cell_calling_comparison'
genome_name='hg38'
peak_set_list="lost_peaks newly_discovered_peaks recovered_peaks"


# Rawpeaks
peak_dir="${res_dir}/Rawpeaks"

annotation_subdir="${peak_dir}/annotation"
mkdir -p $annotation_subdir
annotatePeaks.pl "${peak_dir}/peaks.bed" $genome_name \
    -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_peaks.bed"


# SADEpeaks
peak_dir="${res_dir}/Entropy_cells_peaks"

annotation_subdir="${peak_dir}/annotation"
mkdir -p $annotation_subdir
annotatePeaks.pl "${peak_dir}/peaks.bed" $genome_name \
    -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_peaks.bed"

# CRpeaks
peak_dir="${res_dir}/FRIP_cells_peaks"

annotation_subdir="${peak_dir}/annotation"
mkdir -p $annotation_subdir
annotatePeaks.pl "${peak_dir}/peaks.bed" $genome_name \
    -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_peaks.bed"

# TSSpeaks
peak_dir="${res_dir}/TSS_cells_peaks"

annotation_subdir="${peak_dir}/annotation"
mkdir -p $annotation_subdir
annotatePeaks.pl "${peak_dir}/peaks.bed" $genome_name \
    -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_peaks.bed"


# Commonpeaks 
peak_dir="${res_dir}/Commoncells_peaks"

annotation_subdir="${peak_dir}/annotation"
mkdir -p $annotation_subdir
annotatePeaks.pl "${peak_dir}/peaks.bed" $genome_name \
    -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_peaks.bed"


## peak comparison directories

# CRpeak vs Rawpeaks 
cmp_peak_dir="${res_dir}/FRIPpeaks_vs_Rawpeaks"

annotation_subdir="${cmp_peak_dir}/annotation"
mkdir -p $annotation_subdir
for f in $peak_set_list; do
    annotatePeaks.pl "${cmp_peak_dir}/${f}.bed" $genome_name \
        -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_${f}.bed"
    echo "${f}.bed"
done



# SADEpeaks vs Rawpeaks 
cmp_peak_dir="${res_dir}/Entropypeaks_vs_Rawpeaks"

annotation_subdir="${cmp_peak_dir}/annotation"
mkdir -p $annotation_subdir
for f in $peak_set_list; do
    annotatePeaks.pl "${cmp_peak_dir}/${f}.bed" $genome_name \
        -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_${f}.bed"
    echo "${f}.bed"
done

# TSSPeaks vs Rawpeaks 
cmp_peak_dir="${res_dir}/TSSpeaks_vs_Rawpeaks"
annotation_subdir="${cmp_peak_dir}/annotation"
mkdir -p $annotation_subdir
for f in $peak_set_list; do
    annotatePeaks.pl "${cmp_peak_dir}/${f}.bed" $genome_name \
        -annStats $annotation_subdir/"annStats_${f}.txt" > "$annotation_subdir/annotated_${f}.bed"
    echo "${f}.bed"
done

#
