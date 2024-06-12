#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


for sub in `cat ~/istart-eyeballs/code/sublist_rf1.txt`; do
	for task in doors socialdoors trust ugr sharedreward ; do
		for run in 1 2 ; do
			script=${scriptdir}/fakefmriprep.sh
			NCORES=35
			while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
				sleep 5s
			done
		   bash $script $sub $task $run &
		done
	done 
done
