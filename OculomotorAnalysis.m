clear;
clc;

addpath(genpath(cd));
prompt = {'Subject','Script User'};
answer = inputdlg(prompt);

%if they say nothing do nothing
if isempty(answer)
    return;
else

    subjectID =  answer{1,1};
    user =  answer{2,1};
    [startDirectory] = UserPath(user);
end
% pull information about this participant from participant assignment table (which side were they trained on?
% which training type did they perform?)

% if they were trained at uab the 2nd letter of their id should be 'b', but
% ucr should be 'r', make a distinction so we can load in the correct
% assignment table

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
    ParticipantAssignment = readtable("ParticipantAssignmentsUCR.csv");
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


% Folder name to search for
targetFolder = subjectID;

addpath(genpath(startDirectory));

% Find the folder
SubjectDirectory = findFolder(targetFolder, startDirectory);

[OcuMetrics,selectedIndex, FixationFiles] = OculomotorSelector(subjectID,startDirectory);
if exist("FixationFiles","var")
    for j = 1:2
        load(FixationFiles{j});
        if selectedIndex == 1
            SaccadicReferencingFirstLanding
        elseif selectedIndex == 2
            SaccadicPrecision_Latency_UsefulTrials
        elseif selectedIndex == 3
            Fixation_Stability_Analysis
        end
    end
end