import json
import os

# Define paths
bidsdir = "/ZPOOL/data/projects/rf1-sra-data/bids/"
func_dir = "func"  # Directory containing the functional images

# Find all subject directories in the BIDS directory
subs = [d for d in os.listdir(bidsdir) if os.path.isdir(os.path.join(bidsdir, d)) and d.startswith('sub')]

for subj in subs:
    print("Running subject:", subj)

    fmap_dir = os.path.join(bidsdir, subj, 'fmap')
    json_files = [f for f in os.listdir(fmap_dir) if f.endswith('fieldmap.json') or f.endswith('magnitude.json')]

    for json_file in json_files:
        json_path = os.path.join(fmap_dir, json_file)
        with open(json_path, 'r') as f:
            data = json.load(f)
            intended_for = []

            # Extract task and run numbers from the filename
            file_parts = json_file.split('_')
            task = file_parts[1].split('-')[1]
            run = file_parts[2].split('-')[1]

            for echo in range(1, 5):
                intended_for.append(f"{func_dir}/{subj}_task-{task}_run-{run}_echo-{echo}_part-mag_bold.nii.gz")


            data["IntendedFor"] = intended_for
            data["Units"] = "Hz"
            data.pop("EchoTime1", None)
            data.pop("EchoTime2", None)

        with open(json_path, 'w') as f:
            json.dump(data, f, indent=4, sort_keys=True)

        print("Added IntendedFor field to", json_path)
