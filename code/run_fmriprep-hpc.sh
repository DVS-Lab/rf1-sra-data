#!/bin/bash

# ensure paths are correct
maindir=~/work/rf1-sra-data #this should be the only line that has to change if the rest of the script is set up correctly
scriptdir=$maindir/code

for sub in `cat ${scriptdir}/newsubs_rf1-sra-data.txt` ; do
	qsub -F $sub fmriprep-hpc.sh
done
