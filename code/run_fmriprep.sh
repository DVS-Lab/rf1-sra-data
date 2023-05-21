#!/bin/bash

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$(dirname "$scriptdir")"
bidsdir=$maindir/bids

#for sub in $bidsdir/sub*; do
for sub in 'sub-10555' 'sub-10584' 'sub-10596' 'sub-10603' 'sub-10608' 'sub-10617' 'sub-10656' 'sub-10663' 'sub-10677'; do

	sub="${sub##*/}"

	script=${scriptdir}/fmriprep.sh
	NCORES=2
	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
		sleep 1s
	done
	echo $script $sub
	bash $script $sub &
	sleep 5s
done
#python ${scriptdir}/MakeConfounds.py --fmriprepDir "${scriptdir}/../derivatives/fmriprep
