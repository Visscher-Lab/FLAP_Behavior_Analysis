function folderPaths = findFolder(subjectID, startDir)
    % FIND FOLDER Searches for a folder with a specified name in a directory tree.
    %
    % folderPaths = findFolder(folderName, startDir)
    % 
    % Inputs:
    %   folderName - Name of the folder to search for (string).
    %   startDir   - Starting directory for the search (string).
    %
    % Outputs:
    %   folderPaths - Cell array of full paths to the matching folders.

    if nargin < 2
        startDir = pwd; % Default to current directory if not specified
    end
    
    % Initialize the output
    folderPaths = {};
    
    % Get all entries in the current directory
    entries = dir(startDir);
    
    % Filter directories and remove '.' and '..'
    isDir = [entries.isdir];
    directories = entries(isDir);
    directories = directories(~ismember({directories.name}, {'.', '..'}));
    
    % Check if any folder matches the target name
    for i = 1:length(directories)
        if strcmpi(directories(i).name, subjectID) % Case-insensitive match
            folderPaths{end+1} = fullfile(startDir, directories(i).name); %#ok<AGROW>
        end
    end
    
    % Recur into subdirectories
    for i = 1:length(directories)
        subDir = fullfile(startDir, directories(i).name);
        folderPaths = [folderPaths, findFolder(subjectID, subDir)]; %#ok<AGROW>
    end
end
