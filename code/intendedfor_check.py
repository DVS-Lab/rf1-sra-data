import json
import os

# Define paths
bidsdir = "/ZPOOL/data/projects/rf1-sra-data/bids/"
func_dir = "func"  # Directory containing the functional images

# Find all subject directories in the BIDS directory
subs = [d for d in os.listdir(bidsdir) if os.path.isdir(os.path.join(bidsdir, d)) and d.startswith('sub')]

for subj in subs:
    print("Checking subject:", subj)

    fmap_dir = os.path.join(bidsdir, subj, 'fmap')
    json_files = [f for f in os.listdir(fmap_dir) if f.endswith('fieldmap.json') or f.endswith('magnitude.json')]

    for json_file in json_files:
        json_path = os.path.join(fmap_dir, json_file)
        with open(json_path, 'r') as f:
            data = json.load(f)
            intended_for = data.get("IntendedFor", [])

            for file in intended_for:
                # Ensure the path includes the subject's func directory
                file_path = os.path.join(bidsdir, subj, func_dir, os.path.basename(file))
                if not os.path.isfile(file_path):
                    print(f"File {file_path} listed in {json_path} does not exist.")

        print("Checked IntendedFor field in", json_path)

print("Finished checking all subjects.")
