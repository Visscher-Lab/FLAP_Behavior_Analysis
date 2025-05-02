%% Written by Elam (with comments by Ava 5/2/2025)
% FLAP Oculomotor analysis script. Runs all summary data for oculomotor task
% (find the flicker task) in pre and post assessment
% This script runs the following measurements, one part at a time:
%   Part 1
%       Saccadic rereferencing 
%       First saccade landing location
%   Part 2
%       Saccadic precision
%       Saccade latency
%       Percent of useful trials
%   Part 3
%       Fixation stability
%       BCEAx
%       BCEAy
% Input:
%   Your desktop directory and initials should be in UserPath
%   In order for script to run, participant data must be in folder labeled
%   "FLAPData" seperated by participant ID. "pre" and "post" folders should
%   be in each with imported data found in Box (Day 1 = pre, Day 2 = post)
% Output:
%   To view summary analysis, open "summaryDataSRFL" in the Workspace
%   Under "Value", first value in brackets is pre, second value is post
%   Figures will generate in folder in subject folder titled
%   OculomotorFigures

% If running new data, please put summary values into the oculomotor
% assessment analysis Google Sheet, the AssessmentAnaylsis SPSS file,
% and put figures generated in OculomotorFigures into the Google Drive!

clear;
clc;

% Prompt to enter subjectID and initals from UserPath
addpath(genpath(cd));
prompt = {'Subject','Script User'};
answer = inputdlg(prompt);

% If prompt is empty, do nothing
if isempty(answer)
    return;
else

    subjectID =  answer{1,1};
    user =  answer{2,1};
    [startDirectory] = UserPath(user);
end

% Pull information about this participant from participant assignment table 
% (which side were they trained on? which training type did they perform?)
% Institution changes ID slightly:
% If participant is from UAB, 2nd letter of ID should be 'b'
% If participant is from UCR, 2nd letter of ID should be 'r'
% If participant is from NEU, 2nd letter of ID should be 'n'

% IF THERE IS AN ERROR HERE: check the name of the .csv (Excel) file in
% FLAP_Behavior_Analysis > AnalysisUtilities

if subjectID(2) == 'b'

    ParticipantAssignment = readtable("ParticipantAssignmentsUAB_corr.csv");
    for q = 1:size(ParticipantAssignment,1)
        if string(ParticipantAssignment.participant(q)) == subjectID
            PRL_side = string(ParticipantAssignment.TRL(q));
        else
        end
    end
    for z = 1:size(ParticipantAssignment,1)
        if string(ParticipantAssignment.participant(z)) == subjectID
            TrainingTask = string(ParticipantAssignment.TrainingTask(z));
        else
        end
    end
elseif subjectID(2) == 'r'
    ParticipantAssignment = readtable("ParticipantAssignmentsUCR_corr.csv");
    for q = 1:size(ParticipantAssignment,1)
        if string(ParticipantAssignment.participant(q)) == subjectID
            PRL_side = string(ParticipantAssignment.TRL(q));
        else
        end
    end
    for z = 1:size(ParticipantAssignment,1)
        if string(ParticipantAssignment.participant(z)) == subjectID
            TrainingTask = string(ParticipantAssignment.TrainingTask(z));
        else
        end
    end
elseif subjectID(2) == 'n'
    ParticipantAssignment = readtable("ParticipantAssignmentsNEU_corr.csv");
    for q = 1:size(ParticipantAssignment,1)
        if string(ParticipantAssignment.participant(q)) == subjectID
            PRL_side = string(ParticipantAssignment.TRL(q));
        else
        end
    end
    for z = 1:size(ParticipantAssignment,1)
        if string(ParticipantAssignment.participant(z)) == subjectID
            TrainingTask = string(ParticipantAssignment.TrainingTask(z));
        else
        end
    end
end


% Folder name to search for based on subject ID entered in prompt
targetFolder = subjectID;

addpath(genpath(startDirectory));

% Find the subject's folder
SubjectDirectory = findFolder(targetFolder, startDirectory);


% Run analysis for pre and post assessment analysis
[OcuMetrics,selectedIndex, FixationFiles] = OculomotorSelector(subjectID,startDirectory);
if exist("FixationFiles","var")
    for j = 1:2
        load(FixationFiles{j});
        if selectedIndex == 1
            % PART 1
            % Highlight and select "open" to view editor for each part
            SaccadicReferencingFirstLanding
        elseif selectedIndex == 2
            % PART 2
            % Highlight and select "open" to view editor for each part
            SaccadicPrecision_Latency_UsefulTrials
        elseif selectedIndex == 3
            % PART 3
            % Highlight and select "open" to view editor for each part
            Fixation_Stability_Analysis
        end
    end
end