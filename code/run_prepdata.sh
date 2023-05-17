#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

sourcedir=/data/sourcedata/rf1-sra/*
DLscript=${scriptdir}/downloadXNAT.py

python $DLscript

for sub_CB in "10391 3"; do 
        set -- $sub_CB
	sub=$1
	CB=$2
	

	script=${scriptdir}/prepdata.sh
	NCORES=4
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		echo "made it here" $script $sub $CB
		sleep 1m
	done
        echo "Running prepdata" $script $sub $CB
	bash $script $sub $CB &
	sleep 5s

done

NCORES=8
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		sleep 1s
	done
bash ${scriptdir}/run_motioneval.sh
python ${scriptdir}/IDoutliers.py --mriscDir "${sourcedir}/derivatives/mriqc"
bash ${scriptdir}/run_gen3colfiles.sh

