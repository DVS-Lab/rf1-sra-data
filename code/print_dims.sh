#!bin/bash

# This script prints fslinfo for fmriprep data

# ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"
c=1

for sub in `cat ${scriptdir}/sublist_all.txt`; do	
	if test -f ${basedir}/derivatives/fmriprep/sub-${sub}/func/sub-${sub}_task-doors_run-1_space-MNI152NLin6Asym_desc-preproc_bold.nii.gz; then
		var=$(fslinfo ${basedir}/derivatives/fmriprep/sub-${sub}/func/sub-${sub}_task-doors_run-1_space-MNI152NLin6Asym_desc-preproc_bold.nii.gz)
		dim1=$(echo ${var} | awk '{print $4}')	
		dim2=$(echo ${var} | awk '{print $6}')
		dim3=$(echo ${var} | awk '{print $8}')
		dim4=$(echo ${var} | awk '{print $10}')
		echo "${c} sub-${sub}: dim1 ${dim1} dim2 ${dim2} dim3 ${dim3} dim4 ${dim4}"
	else
		echo "${c} sub-${sub}: File does not exist"
	fi
	c=$[$c +1]
done