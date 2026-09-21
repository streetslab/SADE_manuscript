#!/bin/bash

sample='mouse_cryo_brain_5k'
windowsize_list='3000'


source  ~/python_virtuenv/mrvi_3.11/bin/activate

for ws in $windowsize_list; do
	echo $ws

	bash /home/syyang/GitRepo/SADE/sade.sh -f /mnt/hdd_bob/syy/adipose/atac/cr_goldstand/${sample}/atac_v1_E18_brain_cryo_5k_fragments.tsv.gz \
		-o ~/adipose_ln/atac/res/${sample}_WS${ws} \
		-c 'chr1' \
		-w ${ws} \
		-g 'mm10'


done


