#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"

for sub in `cat ${scriptdir}/newsubs.txt` ; do

	script=${scriptdir}/mriqc.sh
	NCORES=4
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		echo "made it here" $script $sub
		sleep 1m
	done
	bash $script $sub &
	sleep 5s

done
