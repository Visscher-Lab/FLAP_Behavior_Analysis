function x = readTrainingData(file_used)


disp('Reading training data')
%fileName_Training = 'Training.txt'
fileID_Training = fopen(file_used);
x = textscan(fileID_Training,'%f %f');
fclose(fileID_Training);
% x is cell array ... convert it to array.
x= cell2mat(x);
end