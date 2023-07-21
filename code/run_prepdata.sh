#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

sourcedir=/ZPOOLdata/sourcedata/rf1-sra/*
DLscript=${scriptdir}/downloadXNAT.py

python $DLscript

for sub in `cat ${scriptdir}/newsubs.txt` ; do
#for sub in 10701 10691 10674 10649 10317; do
	script=${scriptdir}/prepdata.sh
	NCORES=5
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		echo "made it here" $script $sub
		sleep 1m
	done
        echo "Running prepdata" $script $sub
	bash $script $sub &
	sleep 5s

done

NCORES=8
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		sleep 1s
	done
#bash ${scriptdir}/run_motioneval.sh
#python ${scriptdir}/IDoutliers.py --mriscDir "${sourcedir}/derivatives/mriqc"
#bash ${scriptdir}/run_gen3colfiles.sh

