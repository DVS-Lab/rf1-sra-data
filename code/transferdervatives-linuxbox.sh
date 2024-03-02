#!/bin/bash

# Ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"

read -p "Enter AccessNet ID: " destination_user

source_directory="/home/${destination_user}/work/rf1-sra-data/derivatives/fmriprep"
destination_server="@cla18994.tu.temple.edu:"
destination_path="/ZPOOL/data/projects/rf1-sra-data/derivatives/fmriprep"

for sub in `cat ${basedir}/code/sublist_new.txt`; do
	der_files="$source_directory/sub-$sub"
	html_files="$source_directory/sub-$sub.html"
	rsync -avh --no-compress --progress "$der_files" "$destination_user""$destination_server""$destination_path"
	rsync -avh --no-compress --progress "$html_files" "$destination_user""$destination_server""$destination_path"
done

exit   