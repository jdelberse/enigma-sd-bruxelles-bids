#!/bin/bash

ROOT=$(pwd)
SUBS=$(seq -w 1 70 | sed 's/^/0/')

for SUB in $SUBS; do
	if [ -d sub-${SUB} ]; then echo Getting data for sub-${SUB};
	else echo Oh! sub-${SUB} does not exist, skipping...
		continue; fi
	datalad get $ROOT/sub-${SUB}
	echo Submitting sub-${SUB}
	$ROOT/code/shiva/tissue_seg.sh $SUB | condor_submit
done

echo Done! Check back in like three thousand hours