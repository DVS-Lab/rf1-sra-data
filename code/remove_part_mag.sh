#!/bin/bash

# Set the root directory where sub-* directories are located
root_dir="/ZPOOL/data/projects/rf1-sra-data/bids"

# Loop through each subject directory (sub-*) in the root directory
for subject_dir in "$root_dir"/sub-*; do
    if [ -d "$subject_dir" ]; then
        echo "Processing directory: $subject_dir"

        # Delete part-mag files
        rm -f "$subject_dir"/func/sub-*_task-*_run-*_part-mag_events.tsv

        # Rename part-phase to meet BIDS standard
        for file in "$subject_dir"/func/sub-*_task-*_run-*_part-phase_events.tsv; do
            if [ -f "$file" ]; then
                # Extract the filename without the path
                filename=$(basename "$file")

                # Construct the new filename for renaming
                new_filename="${filename/_part-phase_events.tsv/_events.tsv}"

                # Rename the file
                mv "$file" "$(dirname "$file")/${new_filename}"
                echo "Renamed $filename to ${new_filename}"
            fi
        done
    else
        echo "Error: Directory '$subject_dir' not found."
    fi
done

echo "Script execution completed."
