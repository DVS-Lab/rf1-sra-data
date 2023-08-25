function convertTrust_BIDS(subj)
maindir = pwd;
%"C:\Users\tup54227\Documents\GitHub\rf1-sra\stimuli\Scan-Investment_Game\logs\10418\sub-10418_task-trust_run-1_raw.csv"
cd ../../rf1-sra/stimuli/Scan-Investment_Game/logs
logdir = pwd;
cd(maindir)
% Partner is Friend=3, Stranger=2, Computer=1
% Reciprocate is Yes=1, No=0
% cLeft is the left option
% cRight is the right option
% high/low value option will randomly flip between left/right
%
% subj = subject number

fname = sprintf('summary_misses_task-trust.csv');
fid2 = fopen(fname,'a');

try
    
    for r = 0:1
        run_misses = 0;
        %"logs\10418\sub-10418_task-trust_run-1_raw.csv"
        fname = fullfile(logdir,num2str(subj),sprintf('sub-%05d_task-trust_run-%d_raw.csv',subj,r));
        disp(fname)
        if exist(fname,'file')
            fid = fopen(fname,'r');
        else
            fprintf('sub-%d -- Investment Game, Run %d: No data found.\n', subj, r+1)
            continue;
        end
        
        C = textscan(fid,[repmat('%f',1,14) '%s' repmat('%f',1,9)],'Delimiter',',','HeaderLines',1,'EmptyValue', NaN);
        fclose(fid);
        %C = tblread(fid,[repmat('%f',1,14) '%s' repmat('%f',1,9)],'Delimiter',',','HeaderLines',1,'EmptyValue', NaN);
        
        outcomeonset = C{20}; % should be locked to the presentation of the partner cue (at least 500 ms before choice screen)
        choiceonset = C{11}; % should be locked to the presentation of the partner cue (at least 500 ms before choice screen)
        RT = C{18};
        Partner = C{5};
        reciprocate = C{6};
        response = C{15}; % high/low -- build in check below to check recording
        trust_val = C{13}; % 0-8 (with '999' for no response)
        cLeft = C{3};
        cRight = C{4};
        options = [cLeft cRight];
        
        fname = sprintf('sub-%05d_task-trust_run-%01d_events.tsv',subj,r+1);
        output = fullfile(maindir,'bids',['sub-' num2str(subj)],'func');
        if ~exist(output,'dir')
            mkdir(output)
        end
        fid = fopen(fullfile(output,fname),'w');
        fprintf(fid,'onset\tduration\ttrial_type\tresponse_time\ttrust_value\tchoice\tcLow\tcHigh\n');
        for t = 1:length(choiceonset)
            
            % output check
            if trust_val(t) == 999
                if strcmp(response{t},'high') && (max(options(t,:)) ~= trust_val(t))
                    error('response output incorrectly recorded for trial %d', t)
                end
            end
            
            if (Partner(t) == 1)
                trial_type = 'computer';
            elseif (Partner(t) == 2)
                trial_type = 'stranger';
            elseif (Partner(t) == 3)
                trial_type = 'friend';
            end
            
            % "String values containing tabs MUST be escaped using double quotes.
            % Missing and non applicable values MUST be coded as "n/a"."
            % http://bids.neuroimaging.io/bids_spec.pdf
            
            %fprintf(fid,'onset\tduration\ttrial_type\tresponse_time\ttrust_value\tchoice\n');
            if trust_val(t) == 999
                fprintf(fid,'%f\t%f\t%s\t%f\t%s\t%s\t%d\t%d\n',choiceonset(t),3,'missed_trial',3,'n/a','n/a',min(options(t,:)),max(options(t,:)));
                run_misses = run_misses + 1;
            else
                if trust_val(t) == 0
                    fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',choiceonset(t),RT(t),['choice_' trial_type ],RT(t),0,response{t},min(options(t,:)),max(options(t,:))); %should always be 'low'
                else
                    if reciprocate(t) == 1
                        fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',choiceonset(t),RT(t),['choice_' trial_type],RT(t),trust_val(t),response{t},min(options(t,:)),max(options(t,:)));
                        fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',outcomeonset(t),1,['outcome_' trial_type '_recip'],RT(t),trust_val(t),response{t},min(options(t,:)),max(options(t,:)));
                    else
                        fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',choiceonset(t),RT(t),['choice_' trial_type],RT(t),trust_val(t),response{t},min(options(t,:)),max(options(t,:)));
                        fprintf(fid,'%f\t%f\t%s\t%f\t%d\t%s\t%d\t%d\n',outcomeonset(t),1,['outcome_' trial_type '_defect'],RT(t),trust_val(t),response{t},min(options(t,:)),max(options(t,:)));
                    end
                end
            end
            
        end
        fclose(fid);
    
        fprintf(fid2,'sub-%d,run-%d,%d\n', subj, r+1, run_misses);
        
    end
    fclose(fid2);
catch ME
    disp(ME.message)
    msg = sprintf('check line %d', ME.stack.line);
    disp(msg);
    keyboard
end