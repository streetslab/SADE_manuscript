
output_dir='/home/syyang/adipose_ln/atac/res/mice_brain_5k_WS3000'
frag_file=${output_dir}/fragments.tsv
res_dir="${output_dir}/_cell_calling_comparison"


cmp_list2="$res_dir/Rawpeaks"
for comparison_subdir in $cmp_list2
do 
	peaks=$comparison_subdir/peaks.bed
	frag_out_dir=${comparison_subdir}/frag_overlap
	mkdir -p ${frag_out_dir}
	bedtools intersect -a $frag_file -b $peaks -u > $frag_out_dir/frag_in_peaks.tsv

done

exit 0 



