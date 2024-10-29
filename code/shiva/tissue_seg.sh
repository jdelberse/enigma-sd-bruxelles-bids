#!/bin/bash
# v1.3

CPUS='2'
RAM='16G'
DISK='90G'

FREESURFER=/data/project/sleep_ENIGMA_glymphatic/enigma-sd/containers/images/bids/bids-freesurfer--6.0.1-6.1.sing
WORK_DIR=/tmp
BIDS_DIR=$(pwd)
OUTPUT_DIR=$(pwd)/derivatives
SYMLINK_DIR=$(pwd)/.git/annex/objects
LOGS_DIR=$OUTPUT_DIR/logs

# create the logs dir if it doesn't exist
[ ! -d "${LOGS_DIR}" ] && mkdir -p "${LOGS_DIR}"

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
SUB=$1
for SES in b9 sd9; do
    printf "arguments = run --cleanenv \
	-B ${SYMLINK_DIR},${WORK_DIR},${BIDS_DIR},${OUTPUT_DIR},/opt/freesurfer/7.4/license.txt:/opt/freesurfer/license.txt \
	${FREESURFER} ${BIDS_DIR} ${OUTPUT_DIR} participant \
	--participant_label ${SUB} \
	--license_file /opt/freesurfer/license.txt \
	--session_label ${SES} \
	--stages all \
	--skip_bids_validator \
	--3T true\n"
    printf "log       = ${LOGS_DIR}/\$(Cluster).\$(Process).${SUB}.${SES}.log\n"
    printf "output    = ${LOGS_DIR}/\$(Cluster).\$(Process).${SUB}.${SES}.out.txt\n"
    printf "error     = ${LOGS_DIR}/\$(Cluster).\$(Process).${SUB}.${SES}.err.txt\n"
    printf "Queue\n\n"
done

