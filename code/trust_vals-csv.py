import os
import pandas as pd
import fnmatch

def extract_partner(trial_type):
    """Extract the partner type from the trial_type."""
    if 'computer' in trial_type:
        return 'computer'
    elif 'stranger' in trial_type:
        return 'stranger'
    elif 'friend' in trial_type:
        return 'friend'
    else:
        return None  # Exclude unknown types

def process_file(file_path):
    """Process a single TSV file to extract partner type and trust_value."""
    try:
        # Read the TSV file
        data = pd.read_csv(file_path, sep='\t')
        
        # Check if required columns are present
        if 'trust_value' not in data.columns or 'trial_type' not in data.columns:
            print(f"Required columns missing in {file_path}")
            return None

        # Extract partner type from trial_type column
        data['partner'] = data['trial_type'].apply(extract_partner)

        # Drop rows where partner is None (i.e., unknown)
        data = data.dropna(subset=['partner'])

        return data[['partner', 'trust_value']]
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        return None

def process_directory(root_dir):
    """Process all TSV files in the directory tree that match specific patterns."""
    all_results = []

    # Define the patterns to match
    patterns = ['sub-*_task-trust_run-2_events.tsv', 'sub-*_task-trust_run-1_events.tsv']

    # Walk through the directory tree
    for subdir, _, files in os.walk(root_dir):
        for pattern in patterns:
            for file in fnmatch.filter(files, pattern):
                file_path = os.path.join(subdir, file)
                print(f"Processing {file_path}...")
                result = process_file(file_path)
                if result is not None:
                    result['file'] = file_path  # Add file path for reference
                    all_results.append(result)

    if all_results:
        # Combine all results into a single DataFrame
        combined_results = pd.concat(all_results, ignore_index=True)
        return combined_results
    else:
        print("No results to display.")
        return pd.DataFrame()

def main():
    root_path = '/ZPOOL/data/projects/rf1-sra-data/bids'
    combined_results_df = process_directory(root_path)

    # Check if combined results are available
    if not combined_results_df.empty:
        # Extract subject ID from file paths and group data
        combined_results_df['subject'] = combined_results_df['file'].apply(lambda x: x.split('/')[6])  # Adjust based on your directory structure

        # Group by subject and partner, and calculate average trust_value
        summary = combined_results_df.groupby(['subject', 'partner'])['trust_value'].mean().reset_index()

        # Pivot the summary to have partners as columns
        pivot_table = summary.pivot(index='subject', columns='partner', values='trust_value').fillna(0)

        # Save to CSV
        output_csv_path = 'subject_partner_summary.csv'
        pivot_table.to_csv(output_csv_path)

        print(f"Results saved to {output_csv_path}")
    else:
        print("No data to display.")

if __name__ == '__main__':
    main()
