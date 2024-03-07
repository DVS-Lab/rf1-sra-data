#!/bin/bash

# Set the directory path
directory="/ZPOOL/data/sourcedata/sourcedata/rf1-sequence-pilot/"

# Iterate through subjects, find the number of directories, and sort by count
for subject_dir in "${directory}"*/*; do
    # Get the subject ID from the directory name
    subject=$(basename "${subject_dir}")
    # Set the subdirectory path
    subdir="${subject_dir}/scans/"
    # Check if the scans directory exists
    if [ -d "${subdir}" ]; then
        # Find directories matching the pattern and count them
        dir_count=$(find "${subdir}" -type d -name '*-localizer' | wc -l)
        # Print the subject ID and directory count
        echo "${subject}: ${dir_count} localizers"
    fi
done | column -t
