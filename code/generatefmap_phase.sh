#!/bin/bash

# Path to the input directory
input_dir="/ZPOOL/data/projects/rf1-sra-data/phasediff_test/bids"

# Loop through all subject folders
for subject_dir in "${input_dir}"/sub-*/; do
    subject=$(basename "${subject_dir}")
    fmap_dir="${subject_dir}/fmap"

    # Create the fmap directory if it doesn't exist
    mkdir -p "${fmap_dir}"

    # Loop through all tasks for each subject
    for task in trust doors socialdoors sharedreward ugr; do
        # Determine the number of runs for the current task
        if [[ "${task}" == "doors" || "${task}" == "socialdoors" ]]; then
            num_runs=1
        else
            num_runs=2
        fi

        # Loop through the runs for the current task
        for run in $(seq 1 "${num_runs}"); do
            # Path to the current subject's functional data for the task and run
            data="${subject_dir}/func/${subject}_task-${task}_run-${run}"

            # Check if the necessary files exist before proceeding
            if [[ -e "${data}_echo-2_part-phase_sbref.nii.gz" && -e "${data}_echo-1_part-phase_sbref.nii.gz" && -e "${data}_echo-2_part-mag_sbref.json" ]]; then
                # Perform subtraction for echo-2 - echo-1 for each run
                fslmaths "${data}_echo-2_part-phase_sbref.nii.gz" \
                -sub "${data}_echo-1_part-phase_sbref.nii.gz" \
                "${fmap_dir}/${subject}_acq-${task}_run-${run}_phasediff.nii.gz"

                # Copy the JSON files to the fmap directory and rename them
                cp "${data}_echo-1_part-mag_sbref.json" "${fmap_dir}/${subject}_acq-${task}_run-${run}_magnitude.json"
                cp "${data}_echo-1_part-mag_sbref.nii.gz" "${fmap_dir}/${subject}_acq-${task}_run-${run}_magnitude.nii.gz"
                cp "${data}_echo-2_part-phase_sbref.json" "${fmap_dir}/${subject}_acq-${task}_run-${run}_phasediff.json"
            else
                echo "Missing data for ${subject} task ${task} run ${run}"
            fi
        done
    done
done


# TODO

# create variable in task loop named prefix -- think about adding a conditional for missing runs 
# prefix variable should fill in for the whole path down to _echo
# add three other lines to copy over echo2.json files, rename to bids file format during this
# also copy over corresponding magnitude image (echo-1_part-mag with .json file)
# once images are output, compare OG and subbed fmap in fsleyes 
