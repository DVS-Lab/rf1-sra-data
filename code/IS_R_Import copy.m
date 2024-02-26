% Get the current working directory
currentFolder = pwd;

% Construct file paths relative to the current folder
inputFile = fullfile(currentFolder, 'input.csv');
templateFile = fullfile(currentFolder, 'template.csv');
outputFile = fullfile(currentFolder, 'output.xlsx');

%READING THE INPUT
input_data = readtable(inputFile);

%READING THE TEMPLATE
template_data = readtable(templateFile);

% Extract the variable names from the first row of template_data
templateVarNames = template_data.Properties.VariableNames;

% Initialize an empty cell array to store output data
outputDataCell = cell(height(input_data), numel(templateVarNames));

% Get today's date
todayDate = datestr(datetime('now'), 'yyyy/MM/dd');

% Initialize gender variable
gender = cell(height(input_data), 1);

% Loop through each row in the input_data
for row = 1:height(input_data)

    % Get gender at birth
    if input_data.gender_at_birth(row)== 2
        gender{row} = 'Male';
    else
        gender{row} = 'Female';
    end

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
        elseif strcmp(varName, 'tania_subid')
            % Generate tania_subid based on sub_fn, sub_ln, and dob for each row
            fn = input_data.sub_fn{row};
            ln = input_data.sub_ln{row};
            dob = input_data.dob(row); % Access the date value
            dob = datestr(dob, 'mmddyy'); % Convert date to string
            
            %get the first letter of their first and last names
            fn_letter = upper(fn(1));
            ln_letter = upper(ln(1));
            %convert letters to corresponding number value
            alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            fn_num = strfind(alphabet, fn_letter);
            ln_num = strfind(alphabet, ln_letter);
            %pad the numbers with 0
            fn_padded_num = sprintf('%02d', fn_num);
            ln_padded_num = sprintf('%02d', ln_num);
            dob = char(dob); % Convert to a character array
            %get the last two digits of their dob
            dob_num = dob(end-1:end);
            % Generate tania_subid
            tania_subid = [fn_padded_num, ln_padded_num, dob_num];
            
            outputDataCell{row, i} = tania_subid;
       
        % Set the event name
        elseif strcmp(varName, 'redcap_event_name')
            outputDataCell{row, i} = 'subject_informatio_arm_1';
        % Set the rapport notes to age
        elseif strcmp(varName, 'recontact_notes')
            outputDataCell{row, i} = sprintf('%s, %d years old', gender{row}, round(input_data.age_mo(row)));
        % Set Recontact Status to 'Needs to be recontacted'
        elseif strcmp(varName, 'recontact_status')
            outputDataCell{row, i} = 1;
        % Set date_recontact to today's date
        elseif strcmp(varName, 'date_recontact')
            outputDataCell{row, i} = todayDate;
        % Set the contact step to 'needs to be recontacted'
        elseif strcmp(varName, 'com_contact_step')
            outputDataCell{row, i} = 2;
        % Set the Com Log to 'Complete'
        elseif strcmp(varName, 'communication_log_complete')
            outputDataCell{row, i} = 2; 

        else
            outputDataCell{row, i} = "";
        end
    end
end

% Create the output_data table with the variable names from template_data
% and data from input_data (where they match)
output_data = cell2table(outputDataCell, 'VariableNames', templateVarNames);

% Write the output_data to 'output.csv'
writetable(output_data, 'output.csv')