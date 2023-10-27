#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#for sub in `cat ${scriptdir}/newsubs_rf1-sra-data.txt` ; do
#for sub in 10640 10718 10770 10801 10807 10809; do
for sub in 10713; do

	script=${scriptdir}/prepdata.sh
	NCORES=16
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		sleep 5s
	done
   bash $script $sub &
	sleep 5s
	
done
