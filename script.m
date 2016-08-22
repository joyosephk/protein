clear; clc; close all;
addpath('functions');

% Load data
load('data.mat');
proteins = sample(:,7);

% Preprocessing
proteins = proteins(~cellfun('isempty',proteins)) ;  % remove empty cells
id_remove = regexp(proteins,'del'); id_remove = cellfun('isempty',id_remove); % Remove ones with 'del'
proteins = proteins(id_remove);
id_remove = regexp(proteins,'Ter'); id_remove = cellfun('isempty',id_remove); % Remove ones with 'Ter'
proteins = proteins(id_remove);
id_remove = regexp(proteins,'ins'); id_remove = cellfun('isempty',id_remove); % Remove ones with 'ins'
proteins = proteins(id_remove);
id_remove = regexp(proteins,'dup'); id_remove = cellfun('isempty',id_remove); % Remove ones with 'dup'
proteins = proteins(id_remove);

% Parse to extract transitions and their numeric positions
idx = regexp(proteins,'\d+','match');
positions = str2double([idx{:}]');
match = regexp(proteins,'[a-zA-Z]+','match');
transitions = vertcat(match{:});
transitions(:,1)=[];

% Get rid of non-transitions (same first and second)
id_remove = cellfun(@(x,y) isequal(x,y), transitions(:,1), transitions(:,2));
transitions = transitions(~id_remove,:);
positions = positions(~id_remove,:);

% OPTIONAL: produce a histogram
figure;
hist(positions,50);
xlabel('Positions');
ylabel('Frequency of transitions');
grid on;

% OPTIONAL:  Write out to spreadsheet
% output = horzcat(transitions, num2cell(positions));
% T = cell2table(output,'VariableNames',{'First','Second','Position'});
% writetable(T,'tabledata.dat');

% Load scores data
load('scores.mat');
[~,idx1] = ismember(transitions(:,1),names);
[~,idx2] = ismember(transitions(:,2),names);
transitions_scores = diag(scores(idx1,idx2));

% Generate weighted histogram
nbins = 50;
[histw, intervals] = histwc(positions, transitions_scores, nbins); 
figure;
bar(intervals,histw);

