import json
import os

# Define paths
bidsdir = "/ZPOOL/data/projects/rf1-sra-data/bids/"

# Find all subject directories in the BIDS directory
subs = [d for d in os.listdir(bidsdir) if os.path.isdir(os.path.join(bidsdir, d)) and d.startswith('sub')]

for subj in subs:
    print("Running subject:", subj)

    func_dir = os.path.join(bidsdir, subj, 'func')

    # Check if the func directory exists
    if not os.path.exists(func_dir):
        print(f"Warning: {subj} does not have a 'func' directory. Skipping.")
        continue  # Skip this subject if no 'func' directory is found

    json_files = [f for f in os.listdir(func_dir) if f.endswith('bold.json') or f.endswith('sbref.json')]

    for json_file in json_files:
        json_path = os.path.join(func_dir, json_file)
        with open(json_path, 'r') as f:
            data = json.load(f)
            intended_for = []

            # Extract task and run numbers from the filename
            file_parts = json_file.split('_')
            task = file_parts[1].split('-')[1]
            run = file_parts[2].split('-')[1]

            # Check the file name for 'part-mag' or 'part-phase' and set units accordingly
            if 'part-mag' in json_file:
                data["Units"] = "Hz"
            elif 'part-phase' in json_file:
                data["Units"] = "rad"
            else:
                data["Units"] = "Hz"  # Default to Hz if neither is found

        with open(json_path, 'w') as f:
            json.dump(data, f, indent=4, sort_keys=True)

        print("Updated Units in", json_path)
