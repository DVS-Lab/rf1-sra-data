% Get the current working directory
currentFolder = pwd;

% Construct file paths relative to the current folder
inputFile = fullfile(currentFolder, 'input.csv');
templateFile = fullfile(currentFolder, 'template.csv');
outputFile = fullfile(currentFolder, 'output.csv');

%READING THE INPUT
input_data = readtable(inputFile);

%READING THE TEMPLATE
template_data = readtable(templateFile);

% Extract the variable names from the first row of template_data
templateVarNames = template_data.Properties.VariableNames;

% Initialize an empty cell array to store output data
outputDataCell = cell(height(input_data), numel(templateVarNames));

% Loop through each row in the input_data
for row = 1:height(input_data)
    % Loop through the variable names and copy data from input_data if it exists
    for i = 1:numel(templateVarNames)
        varName = templateVarNames{i};
        if ismember(varName, input_data.Properties.VariableNames)
            value = input_data{row, varName};
            % Replace NaN values with empty string
            if isnumeric(value) && isnan(value)
                value = '';
            end
            outputDataCell{row, i} = value;
        % Set the event name
        elseif strcmp(varName, 'redcap_event_name')
            outputDataCell{row, i} = 'subject_informatio_arm_1';
        % Copy data from the 'ClientID' column to the 'sub_id' column
        elseif strcmp(varName, 'sub_id')
            outputDataCell{row, i} = input_data{row, 'ClientID'};
        elseif strcmp(varName, 'estiq')
            outputDataCell{row, i} = input_data{row, 'CalibrationEstIQ'};
        elseif strcmp(varName, 'caliq')
            outputDataCell{row, i} = input_data{row, 'HARTEstIQ'};
        elseif strcmp(varName, 'cnnscorr___0')
            outputDataCell{row, i} = 1;
        elseif strcmp(varName, 'cnnscorr___2')
            outputDataCell{row, i} = 1;
        elseif strcmp(varName, 'cnnscorr___3')
            outputDataCell{row, i} = 1;
        elseif strcmp(varName, 'saltlt')
            outputDataCell{row, i} = input_data{row, 'lcsum_T'};
        elseif strcmp(varName, 'saltpt')
            outputDataCell{row, i} = input_data{row, 'pcsum_T'};
        elseif strcmp(varName, 'trailsat')
            outputDataCell{row, i} = input_data{row, 'trlsa_T'};
        elseif strcmp(varName, 'digft')
            outputDataCell{row, i} = input_data{row, 'dsf_T'};
        elseif strcmp(varName, 'trailsbt')
            outputDataCell{row, i} = input_data{row, 'trlsb_T'};
        elseif strcmp(varName, 'digbt')
            outputDataCell{row, i} = input_data{row, 'dsf_T'};
        elseif strcmp(varName, 'hvltdelt')
            outputDataCell{row, i} = input_data{row, 'hvlt4_T'};
        elseif strcmp(varName, 'hvltrec')
            outputDataCell{row, i} = input_data{row, 'hdiscrim_T'};
        elseif strcmp(varName, 'bvmtdelt')
            outputDataCell{row, i} = input_data{row, 'bvmt4_T'};
        elseif strcmp(varName, 'jakbondi_complete_yn')
            outputDataCell{row, i} = 1;
        elseif strcmp(varName, 'jakbondi_classification_complete')
            outputDataCell{row, i} = 2;
        else
            outputDataCell{row, i} = '';
        end
    end
end

% Create the output_data table with the variable names from template_data
% and data from input_data (where they match)
output_data = cell2table(outputDataCell, 'VariableNames', templateVarNames);

% Write the output_data to 'output.csv'
writetable(output_data, outputFile)