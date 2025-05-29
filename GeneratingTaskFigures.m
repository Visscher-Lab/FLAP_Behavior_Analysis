%% Created by Ava (with help from Elam & Paul) on 2/27/2025

% This is for creating figures for Pre and Post assessment in the 
% oculomotor task across all training types.

% DON'T JUST CLICK RUN. DO THIS SECTION BY SECTION FOR BEST RESULTS

% Figure 1 should have 4 plots, one for each training type, with individual
% data points and lines connecting pre and post (and box plots with means)
%   X axis: pre & post
%   Y axis: whatever measurement you're investigating (saccade precision,
%           fixation stability, etc). Set y limits to be the same across
%           all training types for better comparisons

% Figure 2 should be one plot, with a legend seperating lines by 
% training type based on color

%% STEP 1:

% vvvvvvvvvvvvvvvvvvvvv
% oculo_table = table();
% ^^^^^^^^^^^^^^^^^^^^^

% Delete the % from "oculo_table = table ();" above and run the line 
% ALONE to create a table. You can highlight it and click "Evaluate" or 
% just run this section alone.

% Once the table is created, open it from the workspace and input your
% data. Do this each time for each measurement you want to look at (for
% example, pre and post saccadic rereferencing). A complete neat list of
% assessment data can be found in the SPSS file in AnalysisUtilities

% Enter data in this format:
%   Column 1: subject ID (example: fb1024)
%   Column 2: training type (1, 2, 3, or 4)
%   Column 3: Pre data
%   Column 4: Post data

% DON'T run "oculo_table = table();" twice. 
% The command creates a blank table. It will erase your created table if 
% you run it again after inputting your data

%% STEP 2: Create seperate data tables for each training type

% This seperates the table into arrays based on training type (1, 2, 3, 4)
% so that data is presented on seperate plots
oculo_tt1 = oculo_table(table2array(oculo_table(:,2)==1),:)
oculo_tt2 = oculo_table(table2array(oculo_table(:,2)==2),:)
oculo_tt3 = oculo_table(table2array(oculo_table(:,2)==3),:)
oculo_tt4 = oculo_table(table2array(oculo_table(:,2)==4),:)

% daboxplot(table2array(oculo_table(:,3:4)))
% ^^^^^^ Above is an optional figure that can be run. It's a simple
% boxplot of the mean pre and post across all training types

%% STEP 3: Create Figure 1
% Written by Ava with Elam in Spring 2025
% Don't forget to edit ylim so your y-axis is consistent across trainings!

% Labels pre and post for y-axis
condition_names = {'Pre-Training', 'Post-Training'}

% Training 1 graph (edit y-label to match what's being measured)
plot1 = subplot(1,4,1)
daboxplot(table2array(oculo_tt1(:,3:4)),'xtlabels', condition_names, 'whiskers', 0, 'scatter', 1, 'scattersize',25,'scatteralpha',0.6,'withinlines', 1,'outliers',1);
ylim([0 100])
ylabel('Saccadic Re-referencing Percentage')
title([newline 'Training 1'])

% Training 2 graph
plot2 = subplot(1,4,2)
daboxplot(table2array(oculo_tt2(:,3:4)),'xtlabels', condition_names, 'whiskers', 0, 'scatter', 1, 'scattersize',25,'scatteralpha',0.6,'withinlines', 1,'outliers',1);
ylim([0 100])
title([newline 'Training 2'])

% Training 3 graph
plot3 = subplot(1,4,3)
daboxplot(table2array(oculo_tt3(:,3:4)),'xtlabels', condition_names, 'whiskers', 0, 'scatter', 1, 'scattersize',25,'scatteralpha',0.6,'withinlines', 1,'outliers',1);
ylim([0 100])
title([newline 'Training 3'])

% Training 4 graph
plot4 = subplot(1,4,4)
daboxplot(table2array(oculo_tt4(:,3:4)),'xtlabels', condition_names, 'whiskers', 0, 'scatter', 1, 'scattersize',25,'scatteralpha',0.6,'withinlines', 1,'outliers',1);
ylim([0 100])
title([newline 'Training 4'])

% Red x's on graphs = outliers

%% STEP 4: Create Figure 2
% Written by Ava with Paul in Spring 2025

% This graph is basically figure 1 but all on the same plot. Trainings are
% seperated by color. It's not pretty but it gets the job done.
% COLOR LEGEND:
%   Red = training 1
%   Blue = training 2
%   Magenta = training 3
%   Green = training 4

% The solid colored circles above pre and post are the means for each 
% training type

figure2 = figure
plot(table2array(oculo_tt1(:,3:4))','r-o')
figure2.CurrentAxes.XLim = [0 3]
figure2.CurrentAxes.XTick = [1,2]
figure2.CurrentAxes.XTickLabel = {'Pre-training'; 'Post-training'}
hold on
plot([1 2], mean(table2array(oculo_tt1(:,3:4))),'r-o', 'MarkerFaceColor', 'r')
plot(table2array(oculo_tt2(:,3:4))','b-o')
plot([1,2], mean(table2array(oculo_tt2(:,3:4))),'b-o', 'MarkerFaceColor','b')
plot(table2array(oculo_tt3(:,3:4))','m-o')
plot([1,2], mean(table2array(oculo_tt3(:,3:4))),'m-o', 'MarkerFaceColor','m')
plot(table2array(oculo_tt4(:,3:4))','g-o')
plot([1,2], mean(table2array(oculo_tt4(:,3:4))),'g-o', 'MarkerFaceColor','g')
