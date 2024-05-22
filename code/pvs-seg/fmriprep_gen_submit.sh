#!/bin/bash

CPUS='4'
RAM='32G'
DISK='90G'

ROOT=$(pwd)
LOGS=$ROOT/derivatives/logs
FMRIPREP=/data/project/sleep_ENIGMA_glymphatic/enigma-sd/containers/images/bids/bids-fmriprep--23.2.0.sing
WORK=/tmp
OUT=$ROOT/derivatives/fmriprep
SYMLINK=$ROOT/.git/annex/objects

# create the logs or out dir if it doesn't exist
[ ! -d "${LOGS}" ] && mkdir -p "${LOGS}"
[ ! -d "${OUT}" ] && mkdir -p "${OUT}"

# print the .submit header
printf "# The environment
universe       = vanilla
getenv         = True
request_cpus   = ${CPUS}
request_memory = ${RAM}
request_disk   = ${DISK}

# Execution
executable     = /usr/bin/singularity
\n"

# loop over all subjects
for dir in $ROOT/sub-001; do
    for ses in ses-bl ses-sd; do
    	sub=${dir#$ROOT/}
        printf "arguments = run \
        --cleanenv \
        -B ${SYMLINK},${WORK},${ROOT},${OUT},/opt/freesurfer/7.4/license.txt:/opt/freesurfer/license.txt \
        ${FMRIPREP} \
        --skull-strip-fixed-seed \
        --work-dir ${WORK} \
        ${ROOT} ${OUT}/${sub}/${ses} participant \
        --anat-only \
        --participant-label ${sub} \
        --bids-filter-file ${ROOT}/code/pvs-seg/filter_${ses}.json\n"
        printf "log       = ${LOGS}/\$(Cluster).\$(Process).${sub}.${ses}.log.txt\n"
        printf "output    = ${LOGS}/\$(Cluster).\$(Process).${sub}.${ses}.out.txt\n"
        printf "error     = ${LOGS}/\$(Cluster).\$(Process).${sub}.${ses}.err.txt\n"
        printf "Queue\n\n"
    done
done
