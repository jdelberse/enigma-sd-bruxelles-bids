#!/bin/bash
# Args
SUB=$1
SES=$2

# Params
ROOT=$(pwd)
QSI=$ROOT/derivatives/qsiprep
DWI=$QSI/$SUB/$SES/dwi

# Get data
datalad get $QSI
datalad get $ROOT/code/alps

#Run alps.sh
$ROOT/code/alps/alps.sh \
	-a $DWI/${SUB}_${SES}_space-T1w_desc-preproc_dwi.nii.gz \
	-b $DWI/${SUB}_${SES}_space-T1w_desc-preproc_dwi.bval \
	-c $DWI/${SUB}_${SES}_space-T1w_desc-preproc_dwi.bvec \
	-d 0 \
	-e 0 \
	-v $QSI/$SUB/anat/${SUB}_desc-preproc_T1w.nii\
	-o $ROOT/derivatives/alps/$SUB/$SES




