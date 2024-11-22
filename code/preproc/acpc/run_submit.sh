#!/bin/bash
CPUS='1'
RAM='9G'
DISK='90G'

ROOT=/data/project/sleep_ENIGMA_glymphatic/enigma-sd/bruxelles-bids
CODE=$ROOT/code/preproc/acpc/run.sh
CONFIG=$ROOT/code/preproc/acpc/config.json
LOGS=$ROOT/derivatives/logs
FSL=docker://brainlife/fsl:6.0.4-patched
#FSL=$ROOT/../containers/images/neurodesk/neurodesk-fsl--6.0.7.14.simg
WORK=/tmp
SYMLINK=$ROOT/.git/annex/objects

# create the logs dir if it doesn't exist
[ ! -d "${LOGS}" ] && mkdir -p "${LOGS}"

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
        sub=${dir#$ROOT/}
        printf "arguments = exec \ 
                -B ${SYMLINK},${WORK},${ROOT} \
                $FSL \
                $CODE $CONFIG \n"
        printf "log       = ${LOGS}/\$(Cluster).\$(Process).${sub}.log.txt\n"
        printf "output    = ${LOGS}/\$(Cluster).\$(Process).${sub}.out.txt\n"
        printf "error     = ${LOGS}/\$(Cluster).\$(Process).${sub}.err.txt\n"
        printf "Queue\n\n"
done