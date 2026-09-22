#!/bin/bash

sample='VIB_10xmultiome_2'
windowsize_list='500 1000 2000 3000'
windowsize_list='3000'



for ws in $windowsize_list; do
	echo $ws

	bash /home/syyang/GitRepo/SADE/sade.sh -f /mnt/hdd_bob/syy/adipose/atac/protocol_benchmark/cr_results/atac/${sample}/outs/fragments.tsv.gz \
		-o ~/adipose_ln/atac/res/${sample}_WS${ws}_chr2 \
		-w ${ws} \
		-c 'chr2' \
		-g 'hg38'
done

