function out = convertSharedReward2BIDSevents(subj)
% This function converts the raw behavioral output from psychopy into
% the BIDS *_events.tsv file format. It also collects summary information
% about the subject's data in the "out" variable.


% set up paths
scriptname = matlab.desktop.editor.getActiveFilename;
[codedir,~,~] = fileparts(scriptname);
cd(codedir);
addpath(codedir);
cd ..
dsdir = pwd;

% make default output
out.ntrials(1) = 0;
out.ntrials(2) = 0;
out.nmisses(1) = 0;
out.nmisses(2) = 0;
out.nfiles = 0;

% get relative path for source data. repos should be in same dir
cd ../rf1-sra/stimuli/Scan-Card_Guessing_Game/logs
logdir = pwd;


for r = 0:1
    
    % not sure why, but started zero padding post pandemic
    if subj > 10000
        fname = fullfile(logdir,num2str(subj),sprintf('sub-%05d_task-sharedreward_run-%01d_raw.csv',subj,r+1));
    else
        fname = fullfile(logdir,num2str(subj),sprintf('sub-%05d_task-sharedreward_run-%d_raw.csv',subj,r));
    end
    
    if r == 0 % only needed for first pass through
        [sublogdir,~,~] = fileparts(fname);
        nfiles = dir([sublogdir '/*.csv']);
        out.nfiles = length(nfiles);
    end
    
    if exist(fname,'file')
        T = readtable(fname,'TreatAsEmpty','--');
    else
        fprintf('sub-%d_task-sharedreward_run-%d: No data found.\n', subj, r+1)
        continue
    end
    
    % strip out irrelevant information and missed trials
    T = T(:,{'rt','decision_onset','outcome_onset','trialDuration','Feedback','Partner','resp'});
    goodtrials =  ~isnan(T.resp);
    T = T(goodtrials,:);
    
    if height(T) < 54
        
        fprintf('incomplete data for sub-%d_run-%d\n', subj, r+1)
        continue
    end
    
    
    onset = T.decision_onset; % switch to outcome_onset? add regressor for decision? minimal spacing...
    RT = T.rt;
    duration = T.trialDuration; % switch to outcome duration? currently starts at decision onset and ends at outcome offset.
    outcome = T.outcome_onset;
    decision = T.decision_onset
    Partner = T.Partner;
    feedback = T.Feedback;
    
    out.ntrials(r+1) = height(T);
    out.nmisses(r+1) = sum(T.resp < 1);
    
    
    % output file
    fname = sprintf('sub-%05d_task-sharedreward_run-%d_events.tsv',subj,r+1); % need to make fMRI run number consistent with this?
    output = fullfile(dsdir,'bids',['sub-' num2str(subj)],'func');
    if ~exist(output,'dir')
        mkdir(output)
    end
    myfile = fullfile(output,fname);
    fid = fopen(myfile,'w');
    
    
    fprintf(fid,'onset\tduration\ttrial_type\tresponse_time\n');
    for t = 1:length(onset)
        
        % Partner is Friend=3, Stranger=2, Computer=1
        % Feedback is Reward=3, Neutral=2, Punishment=1
        
        %fprintf(fid,'onset\tduration\ttrial_type\tresponse_time\n');
        if (feedback(t) == 1) && (Partner(t) == 1)
            trial_type = 'computer_punish';
        elseif (feedback(t) == 1) && (Partner(t) == 2)
            trial_type = 'stranger_punish';
        elseif (feedback(t) == 1) && (Partner(t) == 3)
            trial_type = 'friend_punish';
        elseif (feedback(t) == 2) && (Partner(t) == 1)
            trial_type = 'computer_neutral';
        elseif (feedback(t) == 2) && (Partner(t) == 2)
            trial_type = 'stranger_neutral';
        elseif (feedback(t) == 2) && (Partner(t) == 3)
            trial_type = 'friend_neutral';
        elseif (feedback(t) == 3) && (Partner(t) == 1)
            trial_type = 'computer_reward';
        elseif (feedback(t) == 3) && (Partner(t) == 2)
            trial_type = 'stranger_reward';
        elseif (feedback(t) == 3) && (Partner(t) == 3)
            trial_type = 'friend_reward';
        end
       

        if RT(t) == 999 %missed response
            fprintf(fid,'%f\t%f\t%s\t%s\n',onset(t),duration(t),'missed_trial','n/a');
        else
            fprintf(fid,'%f\t%f\t%s\t%f\n',onset(t),duration(t),['event_' trial_type],RT(t))
            if Partner(t) == 1 % computer
                fprintf(fid,'%f\t%f\t%s\t%f\n',decision(t),RT(t),'computer_non-face',RT(t));
            elseif Partner(t) == 2 % stranger (face)
                fprintf(fid,'%f\t%f\t%s\t%f\n',decision(t),RT(t),'stranger_face',RT(t));
            elseif Partner(t) == 3
                fprintf(fid,'%f\t%f\t%s\t%f\n',decision(t),RT(t),'friend_face',RT(t));
            end
        end

        
    end
    fclose(fid);
    
end
cd(codedir);

