# Directory where subject raw data is
main_dir="/ZPOOL/data/projects/rf1-sra-data/bids"

# Subjects without FLAIR data
subs_no_flair=""

# Iterate through each subdirectory beginning with "sub"
for sub_dir in "$main_dir"/sub*/anat; do
    # Check that directory exists
    if [ -d "$sub_dir" ]; then
        # Check if sub folder contains FLAIR data
        if ! ls "$sub_dir"/*FLAIR* 1> /dev/null 2>&1; then
            # Append the subject folder to list
            subs_no_flair+="${sub_dir%/*}\n"
        fi
    fi
done

# If there are subjects without FLAIR files, add to "flair_no_exist.txt"
if [ -n "$subs_no_flair" ]; then
    # Create .txt file with list of FLAIR-less subs
    echo -e "$subs_no_flair" > flair_no_exist.txt
    echo "Check flair_no_exist.txt for list of subs without FLAIR data"
else
    echo "All subs have FLAIR data"
fi