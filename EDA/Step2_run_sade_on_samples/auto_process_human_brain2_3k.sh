#!/bin/bash

sample='human_brain2_3k'
windowsize_list='3000'


for ws in $windowsize_list; do
	echo $ws

	bash /home/syyang/GitRepo/SADE/sade.sh -f /mnt/hdd_bob/syy/adipose/atac/cr_goldstand/${sample}/atac_fragments.tsv.gz \
		-o ~/adipose_ln/atac/res/${sample}_WS${ws} \
		-w ${ws} \
		-c 'chr1' \
		-g 'hg38'
done

