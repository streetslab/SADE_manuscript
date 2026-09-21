#!/bin/bash

sample='VIB_10xmultiome_2'
windowsize_list='3000'



for ws in $windowsize_list; do
	echo $ws

	bash /home/syyang/GitRepo/atac/sade.sh -f /mnt/hdd_bob/syy/adipose/atac/protocol_benchmark/cr_results/atac/${sample}/outs/fragments.tsv.gz \
		-o ~/adipose_ln/atac/res/${sample}_WS${ws}F \
		-w ${ws} \
		-c 'chr1' \
		-g 'hg38'
done
