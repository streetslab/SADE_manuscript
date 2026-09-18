source ~/python_virtuenv/atac_tobias3.13/bin/activate


output_dir="/mnt/hdd_bob/syy/adipose/atac/res/VIB_10xmultiome_2_WS3000F/_cell_calling_comparison"

frag_bam_file=$output_dir/sorted_tagged_union_bc_fragments.bam


res_dir=${output_dir}/cmp_3Set/filtering_method_set
set_annotation_file=$output_dir/Union_cell_3set.tsv
mkdir -p ${res_dir}

set_list=("atac_pass_CR" "atac_pass_entropy" "atac_pass_archr_TSS")
for i in {0..2}
do
	     set_name=${set_list[$i]}
	     col=$(($i+3))

	awk -F '\t' -v OFS='' -v col="${col}" '{ if ($col=="True") print $1 }' ${set_annotation_file} > $res_dir/${set_name}_bc.txt

	samtools view -h $frag_bam_file | awk -F '\t' -v OFS='\t'  '
        NR==FNR {
	bc_list[$1]; next
        }

	{ if ($1 ~ /^@/) { print $0; next }
	if (  $1 in bc_list ) print $0  
	}
	'  $res_dir/${set_name}_bc.txt  - |  samtools sort -@ 8 -o $res_dir/sorted_farg_${set_name}.bam 
	
	samtools index $res_dir/sorted_farg_${set_name}.bam
	bamCoverage -b $res_dir/sorted_farg_${set_name}.bam \
		    -o $res_dir/sorted_farg_${set_name}.bw \
		    -bs 1 \
		    -p 32

done



# For venn-digram set among the 3 filtering approaches
res_dir=${output_dir}/cmp_3Set
set_annotation_file=$output_dir/Union_cell_3set.tsv

set_list=("common" "CR unique" "SADE unique" "TSS unique" "SADE+CR, not TSS" "SADE+TSS, not CR" "CR+TSS, not SADE")
for i in {0..6}
do
	     set_name=${set_list[$i]}

	awk -F '\t' -v OFS='\t' -v clus="$set_name" '{ if ($8==clus) print $1 }' ${set_annotation_file} > $res_dir/${set_name//[" ",]/_}.txt

	samtools view -h $frag_bam_file | awk -F '\t' -v OFS='\t'  '
        NR==FNR {
	bc_list[$1]; next
        }

	{ if ($1 ~ /^@/) { print $0; next }
	if (  $1 in bc_list ) print $0  
	}
	'  $res_dir/${set_name//[" ",]/_}.txt  - |  samtools sort -@ 8 -o $res_dir/sorted_farg_${set_name//[" ",]/_}.bam 
	
	samtools index $res_dir/sorted_farg_${set_name//[" ",]/_}.bam
	bamCoverage -b $res_dir/sorted_farg_${set_name//[" ",]/_}.bam \
		    -o $res_dir/sorted_farg_${set_name//[" ",]/_}.bw \
		    -bs 1 \
		    -p 32

done



# For cmp_SC
res_dir=${output_dir}/cmp_SC
mkdir -p ${res_dir}

set_list="entropy_only both none cr_only"
for set_name in $set_list
do
    awk -F '\t' -v OFS="" -v SET_NAME="$set_name"  'NR>1 {if ($6==SET_NAME) print  $1}' ${set_annotation_file} > ${res_dir}/${set_name}.txt
    
	samtools view -h $frag_bam_file | awk -F '\t' -v OFS='\t'  '
        NR==FNR {
	bc_list[$1]; next
        }

	{ if ($1 ~ /^@/) { print $0; next }
	if (  $1 in bc_list ) print $0  
	}
	'  $res_dir/${set_name}.txt  - |  samtools sort -@ 8 -o $res_dir/sorted_farg_${set_name}.bam 
    
	samtools index $res_dir/sorted_farg_${set_name}.bam
	bamCoverage -b $res_dir/sorted_farg_${set_name}.bam \
		    -o $res_dir/sorted_farg_${set_name}.bw \
		    -bs 1 \
		    -p 32
done


# For cmp_ST
res_dir=${output_dir}/cmp_ST
mkdir -p ${res_dir}
set_list="both none tss_only entropy_only"
for set_name in $set_list
do

    awk -F '\t' -v OFS="" -v SET_NAME="$set_name"   'NR>1 {if ($7==SET_NAME) print  $1}'  ${set_annotation_file} > ${res_dir}/${set_name}.txt
    
	samtools view -h $frag_bam_file | awk -F '\t' -v OFS='\t'  '
        NR==FNR {
	bc_list[$1]; next
        }

	{ if ($1 ~ /^@/) { print $0; next }
	if (  $1 in bc_list ) print $0  
	}
	'  $res_dir/${set_name}.txt  - |  samtools sort -@ 8 -o $res_dir/sorted_farg_${set_name}.bam 
    
	samtools index $res_dir/sorted_farg_${set_name}.bam
	bamCoverage -b $res_dir/sorted_farg_${set_name}.bam \
		    -o $res_dir/sorted_farg_${set_name}.bw \
		    -bs 1 \
		    -p 32
done


# For cellular-debris 
res_dir=${output_dir}/cmp_DNAdebris_entropy
mkdir -p ${res_dir}
set_list="YES" 
# the non-annotated droplets in 
for set_name in $set_list
do

    awk -F '\t' -v OFS="" -v SET_NAME="$set_name"   'NR>1 {if ($10==SET_NAME) print  $1}'  ${set_annotation_file} > ${res_dir}/${set_name}_debris.txt
    # Note: the non-annotated droplets in Debris-flag column is NOT cellular-debirs. 
	#       This is because SADE only flags debris among those droplets passed entropy filtering step.

	samtools view -h $frag_bam_file | awk -F '\t' -v OFS='\t'  '
        NR==FNR {
	bc_list[$1]; next
        }

	{ if ($1 ~ /^@/) { print $0; next }
	if (  $1 in bc_list ) print $0  
	}
	'  $res_dir/${set_name}_debris.txt  - |  samtools sort -@ 8 -o $res_dir/sorted_farg_${set_name}_debris.bam 
    
	samtools index $res_dir/sorted_farg_${set_name}_debris.bam
	bamCoverage -b $res_dir/sorted_farg_${set_name}_debris.bam \
		    -o $res_dir/sorted_farg_${set_name}_debris.bw \
		    -bs 1 \
		    -p 32
done