#!/bin/bash

# This script is used to transfer BIDS info from the local to cluster

# Ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"

for sub in `cat ${basedir}/code/sublist_all.txt`; do
	cp /ZPOOL/data/projects/ds005123/bids/sub-${sub}/sub-${sub}_scans.tsv /ZPOOL/data/projects/rf1-sra-data/bids/sub-${sub}/sub-${sub}_scans.tsv
done

exit   
