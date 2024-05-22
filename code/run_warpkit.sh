#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "scriptdir: ${scriptdir}"

rm -rf $scriptdir/missingFiles-warpkit.log
touch $scriptdir/missingFiles-warpkit.log


for sub in 10317 10369 ; do
	for task in doors socialdoors trust ugr sharedreward ; do
		for run in 1 2 ; do
			script=${scriptdir}/warpkit.sh
			NCORES=5
			while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
				sleep 5s
			done
		   bash $script $sub $task $run &
		done
	done 
done
