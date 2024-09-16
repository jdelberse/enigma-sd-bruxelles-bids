#!/bin/bash
# v1.3

CPUS='2'
RAM='16G'
DISK='90G'

CONTAINERS=/data/project/sleep_ENIGMA_glymphatic/enigma-sd/containers/
FREESURFER=$CONTAINERS/images/bids/bids-freesurfer--7.4.1-unstable.sing
WORK_DIR=/tmp
BIDS_DIR=$(pwd)
OUTPUT_DIR=$(pwd)/derivatives/freesurfer
SYMLINK_DIR=$(pwd)/.git/annex/objects
LOGS_DIR=$BIDS_DIR/derivatives/logs

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
for dir in $BIDS_DIR/sub-001; do
    for ses in ses-b9 ses-sd9; do
		datalad get $dir
    	sub=${dir#$BIDS_DIR/}
    	printf "arguments = run --cleanenv \
		-B ${SYMLINK_DIR},${WORK_DIR},${BIDS_DIR},${OUTPUT_DIR},/opt/freesurfer/7.4/license.txt:/opt/freesurfer/license.txt \
		$FREESURFER $BIDS_DIR $OUTPUT_DIR participant \
		--participant_label ${sub} \
		--license_file /opt/freesurfer/license.txt \
		--session_label ${ses} \
		--stages all \
		--skip_bids_validator \
		--3T true\n"
    	printf "log       = ${LOGS_DIR}/\$(Cluster).\$(Process).${sub}.${ses}.log\n"
    	printf "output    = ${LOGS_DIR}/\$(Cluster).\$(Process).${sub}.${ses}.out.txt\n"
    	printf "error     = ${LOGS_DIR}/\$(Cluster).\$(Process).${sub}.${ses}.err.txt\n"
    	printf "Queue\n\n"
	done
done

