function [OcuMetrics,selectedIndex, FixationFiles] =  OculomotorSelector(subjectID,startDirectory)

% creates a gui that allows user to select which subject they want to
% analyze and which task they want to import data from to analyze
% oculomotor metrics


% Folder name to search for
targetFolder = subjectID;



addpath(genpath(startDirectory));

% Find the folder
SubjectDirectory = findFolder(targetFolder, startDirectory);


directoryPathPre = fullfile([SubjectDirectory{1,1}  '\pre']);
directoryPathPost = fullfile([SubjectDirectory{1,1}  '\post']);

AvailableTasks = {};
OcuMetrics = {'Saccadic Rereferencing & First Saccade Landing','Saccadic Precision, Latency & Useful Trials','Fixation Stability'};

if isempty(dir([directoryPathPre '\' subjectID '_FLAPfixationflicker*.mat'])) == 0 && isempty(dir([directoryPathPost '\' subjectID '_FLAPfixationflicker*.mat'])) == 0
    FixationFilePre = dir([directoryPathPre '\' subjectID '_FLAPfixationflicker*.mat']);
    FixationFilePost = dir([directoryPathPost '\' subjectID '_FLAPfixationflicker*.mat']);
    FixationFiles = {FixationFilePre(end).name FixationFilePost(end).name};
    AvailableTasks{1} = 'Fixation';

    [selectedIndex, isOk] = listdlg('ListString', OcuMetrics, ...
        'SelectionMode', 'single', ...
        'PromptString', 'Select the metric you would like to analyze.', ...
        'Name', 'Metric Selection','ListSize',[300 100]);
else
    AvailableTasks{1} = '';
    msgbox('There are no available tasks for this participant. Make sure their data is saved to your StartDirectory and SubjectDirectory!')
end




if isOk
    disp(['You selected: ', OcuMetrics{selectedIndex}]);
else
    disp('No selection was made.');
end





