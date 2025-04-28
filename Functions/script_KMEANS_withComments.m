% Script written by Marcello
% Ava commenting 
% Last updated 4/27/2025


addpath(genpath('C:\Users\avvie\OneDrive\Documents\GitHub\FlapData'));
% Find data
clear;
clc;

% Original
file_Name1 = 'fb1012_fixationprePixx_124_2_29_8_59.mat';
file_Name2 = 'dataset2.mat';
file_Name_test = 'dataset_test.mat';

% What is dataset1.txt and dataset2.txt?????? who knows
% Can edit these file names in the future for importing data

% Prompt that appears in command window
prompt = 'Please enter 1 for dataset1 and 2 for dataset2 ->>> ';

% sscanf = reads input from prompt and converts it into fileNumber.
% %d prints integer values
% fileNumber should be 1 or 2
fileNumber = sscanf(input(prompt, 's'), '%d');

% If 1, use dataset1. If anything else, use dataset2
if fileNumber == 1
    file_used = file_Name1;
else
  file_used = file_Name2;
end

% k = # of clusters
% k is the amount of PRLs (aka clusters/initial centroids)
% For example, if k = 2, we are assuming 2 different PRLs.

% Enter k value into command window
prompt = 'Select k value ->>> ';
% sscanf = reads input from prompt and converts it into variable called k
k =  sscanf(input(prompt, 's'), '%d');

% r = # of runs
% r is the amount of iterations for K-means clustering algorithm with different 
% initial centroids, to help find the most stable and the best (lowest sum 
% of squared error) clustering solution

% Enter r value into command window
prompt = 'Select r value ->>> ';
% sscanf = reads input from prompt and converts it into variable called r
r=  sscanf(input(prompt, 's'), '%d');

% Opens readTrainingData and opens and closes Training data file
x = readTrainingData(file_used);

% Calculates number of rows in x and labels it sizeX
% sizeX = number of fixation points collected
sizeX = size(x,1);

% Membership = 0, used later?
membership=0;

% Creates empty array to enter SSE (sum of squared error) values
sses = []

% Makes "i" = the number of iterations
for i = 1:r
        % datasample randomly selects k amount of rows from training data
        % to use as initial centroids and calls it centeroid_idx
        % Duplicates are removed
		centeroid_idx = datasample(1:sizeX,k,'Replace',false);

        % centeroid_inx_keeper has the randomly chosen centroids
        % From Marcello: instial centroid keeper.
        centeroid_idx_keeper{i} = centeroid_idx;

		% From Marcello: disp('final membership: ')
        % "sort" sorts it some way
        centeroid_idx = sort(centeroid_idx);
       
        % Opens KMEANS_Part1 with training data, initial centroids, and
        % iteration #
        % In KMEANS_Part1, the code sluters fixation points into PRLs
        % by K-means. More comments are within the function.
        % Returns from function with finalmembership = which cluster each
        % data point belongs to, finalcentroids = final centroid locations,
        % numOfIterations = how many to converge, and sse_self = sse
        [finalmembership,finalcentroids,numOfIterations,sse_self] = KMEANS_Part1(x,centeroid_idx,i);

        % From Marcello: keep track of centroids and membership arrays to 
        % select the one with lowest SSE
        % The code below saves the results from the run above
        membership_keeper{i} = finalmembership;
        centeroids_keeper{i} = finalcentroids;
        numOfIterations_keeper{i} = numOfIterations;
        sse_tracker{i} = sse_self;
        % computeSSE function uses min and realmax (returns the largest finite 
        % floating point number in IEEE double precision) to calculate SSE
        sse = computeSSE(x,finalcentroids);
        % Adds sse to the array sses, so all are tracked across all r runs
        % of k-means
        sses = [sses sse];
       
end

% From Marcello: now from best r runs we want to find the best cluster 
% with minimum SSE
[minSSE,min_idx] = min(sses);
best_membership = membership_keeper{min_idx};
best_centroids = centeroids_keeper{min_idx}
count = numOfIterations_keeper{min_idx};
doPlot(x,best_membership,best_centroids,r+1,count)
sse=sse_tracker{min_idx};

% From Marcello: Plot best results:
figure
SSEBySample = [sse minSSE]/sizeX
plot(0:(count),SSEBySample,'-');
xlabel('i')
ylabel('SSE/NumberoOfSamples');

% From Marcello: now plot the result


   if strcmp(file_used,file_Name1)
        membership_ideal = [];
        membership_ideal(1:800) = 1;
        membership_ideal(801:1600) = 2;
    else
        membership_ideal = [];
        membership_ideal(1:500) = 1;
        membership_ideal(501:1000) = 2;
        membership_ideal(1001:1500) = 3;
    end
    

r=r+1
doPlot(x,membership_ideal',best_centroids,r+1,count);
