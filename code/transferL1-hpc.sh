#!/bin/bash

# This script is used to transfer BIDS info from the local to cluster

# Ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"


#bids_directory="/ZPOOL/data/projects/rf1-datapaper-dev/bids"
fmriprep_dir=/ZPOOL/data/projects/rf1-sra-data/derivatives/fmriprep
destination_server="@owlsnest.hpc.temple.edu"
#destination_path=":work/rf1-sra-data/bids"

read -p "Enter AccessNet ID: " destination_user
	
for sub in `cat ${scriptdir}/sublist_new-flip.txt` ; do

	source_file="$fmriprep_dir/sub-$sub"
	
	# Transfer Preproc BOLD files
	rsync -avh --no-compress --progress --include='*/' --include='*MNI152NLin6Asym_desc-preproc_bold.nii.gz' --exclude='*' "${source_file}" "${destination_user}${destination_server}:work/rf1-sra-data/derivatives/fmriprep/sub-${sub}/"
	sleep 5

	# Transfer Confound files
	#rsync -avh --no-compress --progress --include='*/' --include='*_confounds_timeseries.tsv' --exclude='*' "${source_file}" "${destination_user}${destination_server}:work/rf1-sra-data/derivatives/fmriprep/sub-${sub}/"

	# Transfer events.tsv files
	#rsync -avh --no-compress --progress --include='*/' --include='*_events.tsv' --exclude='*' "${bids_directory}/sub-${sub}/" "${destination_user}${destination_server}${destination_path}/sub-${sub}"
done

exit
