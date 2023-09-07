#!/bin/bash

#READ ME: This code outputs a list of subs who need to have fmriprep run

# ensure paths are correct irrespective from where user runs the script
#basedir is the code directory
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"


for sub in `ls -d ${basedir}/bids/sub-*/`; do

#extract the subID from the file path that is called in the for loop above
  sub=${sub#*sub-}
  sub=${sub%/}

	#check if anatomical folder is filled
	if [ -e ${basedir}/bids/sub-${sub}/anat/sub-${sub}_T1w.nii.gz ]; then
	
		#check if fmriprep has been run
		if [ ! -e ../derivatives/fmriprep/sub-${sub}.html ]; then 
			echo "sub-${sub} does not have their fmriprep"
		fi
		
	else 
		echo "sub-${sub} -- File does not exist"
	fi
done

