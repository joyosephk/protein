% Main script to explore amino acid transitions
% Written by Joseph Kim

clear; clc; close all;
addpath('functions');

% Load transition data
load('data.mat');
data = data_full(:,7);

% Preprocessing
data = data(~cellfun('isempty',data)) ;  % removes empty cells
id_remove = regexp(data,'del'); id_remove = cellfun('isempty',id_remove); % removes ones with 'del'
data = data(id_remove);
id_remove = regexp(data,'Ter'); id_remove = cellfun('isempty',id_remove); % remove ones with 'Ter'
data = data(id_remove);
id_remove = regexp(data,'ins'); id_remove = cellfun('isempty',id_remove); % remove ones with 'ins'
data = data(id_remove);
id_remove = regexp(data,'dup'); id_remove = cellfun('isempty',id_remove); % remove ones with 'dup'
data = data(id_remove);

% Parsing to extract transitions and their corresponding numeric positions
idx = regexp(data,'\d+','match');
positions = str2double([idx{:}]');
match = regexp(data,'[a-zA-Z]+','match');
transitions = vertcat(match{:});
transitions(:,1)=[];

% Get rid of all non-transitions (same amino acid)
id_remove = cellfun(@(x,y) isequal(x,y), transitions(:,1), transitions(:,2));
transitions = transitions(~id_remove,:);
positions = positions(~id_remove,:);
clear id_remove idx match;


% % Optional: Generate a histogram (unweighted) of transitions
% figure;
% nbins = 50;  % TODO: set number of bins here
% hist(positions,nbins); 
% xlabel('Positions');
% ylabel('Frequency of transitions');
% grid on;

% OPTIONAL:  Writing stuff out to spreadsheet
% output = horzcat(transitions, num2cell(positions));
% T = cell2table(output,'VariableNames',{'First','Second','Position'});
% writetable(T,'tabledata.dat');

% Load scores matrix
load('scores.mat');
[~,idx1] = ismember(transitions(:,1),names);
[~,idx2] = ismember(transitions(:,2),names);
transitions_scores = diag(scores_matrix(idx1,idx2));
clear idx1 idx2;

% Generate weighted histogram
nbins = 50; % TODO: set number of bins here
[histw, intervals] = histwc(positions, transitions_scores, nbins); 
figure;
bar(intervals,histw);
grid on;
xlabel('Positions');
ylabel('Weighted Frequency of Transitions');


