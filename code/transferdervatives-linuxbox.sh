#!/bin/bash

# Ensure paths are correct irrespective from where user runs the script
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
basedir="$(dirname "$scriptdir")"

source_directory="/home/$destination_user/work/rf1-sra-data/derivatives/fmriprep"
destination_server="@cla18994.tu.temple.edu"
destination_path="/ZPOOL/data/projects/rf1-sra-data/derivatives/fmriprep"

read -p "Enter AccessNet ID: " destination_user

for sub in `cat ${basedir}/code/sublist_new.txt`; do
	source_file="$source_directory/sub-$sub"
	rsync -avh --no-compress --progress "$source_file" "$destination_user""$destination_server""$destination_path"
done

exit   