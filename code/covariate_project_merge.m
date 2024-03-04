% Read the data from the CSV files
rf1_data = readtable('rf1-data.csv');
island_data = readtable('island-data.csv');

% Merge the tables based on the identifier in column B
merged_data = innerjoin(rf1_data, island_data, 'Keys', 'tppid');

% Remove duplicates based on 'tppid' column
[~, idx] = unique(merged_data.tppid, 'stable');
merged_data = merged_data(idx, :);

% Write the merged data to a new CSV file
writetable(merged_data, 'merged-data.csv');