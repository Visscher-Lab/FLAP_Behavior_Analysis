function [startDirectory] = UserPath(user)

% UserPath function EC (ecutts99@uab.edu) - 2/7/25
% This function takes the input of a prompt that identifies the "script user" of
% the script at the current moment. Multiple people use these scripts, and
% in its automated fashion, not everyone shares the same data directory
% path. 

% FOR USERS OF THIS SCRIPT: Add an "elseif user == '(Your Initials)' in the
% same fashion as the "EC". Then, just like the StartDirectory line, do
% this same thing with your own path!



if user == 'EC'
    startDirectory = 'C:\Users\VisLab\Documents\FlapData_\';
elseif user == 'YS'
    startDirectory = '/Users/yasminesaad/Desktop/FLAPAnalysis';
end