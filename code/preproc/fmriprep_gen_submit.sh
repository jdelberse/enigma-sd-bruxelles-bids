#!/bin/bash
CPUS='4'
RAM='32G'
DISK='90G'

ROOT=$(pwd)
LOGS=$ROOT/derivatives/logs
CONTAINERS=/data/project/sleep_ENIGMA_glymphatic/enigma-sd/containers/
FMRIPREP=$CONTAINERS/images/bids/bids-fmriprep--24.0.0.sing
WORK=/tmp
OUT=$ROOT/derivatives/fmriprep
SYMLINK=$ROOT/.git/annex/objects

# create the logs or out dir if it doesn't exist
[ ! -d "${LOGS}" ] && mkdir -p "${LOGS}"
[ ! -d "${OUT}" ] && mkdir -p "${OUT}"

export MPLCONFIGDIR=/tmp/matplotlib
export FONTCONFIG_PATH=/tmp/fontconfig

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
for dir in $ROOT/sub-*; do
    sub=${dir#$ROOT/}
    printf "arguments = run \
    --cleanenv \
    -B ${SYMLINK},${WORK},${ROOT},${OUT},/opt/freesurfer/7.4/license.txt:/opt/freesurfer/license.txt \
    ${FMRIPREP} \
    --anat-only \
    --longitudinal \
    --skull-strip-fixed-seed \
    --output-spaces MNI152NLin2009cAsym \
    --work-dir ${WORK} \
    ${ROOT} ${OUT}/${sub}/${ses} participant \
    --participant-label ${sub} \n"
    printf "log       = ${LOGS}/\$(Cluster).\$(Process).${sub}.log.txt\n"
    printf "output    = ${LOGS}/\$(Cluster).\$(Process).${sub}.out.txt\n"
    printf "error     = ${LOGS}/\$(Cluster).\$(Process).${sub}.err.txt\n"
    printf "Queue\n\n"
done
