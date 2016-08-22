function [ranked_list, ranked_freq] = getrankedinfo(words)
% This function calculates the ranked information from a single/or more
% vector. It determines ranked_list and also its associated ranked frequency
%
% Author:  Joseph Kim (jokim@mit.edu)

if isrow(words)
    words = words';
end
if size(words,2) > 1
    [vocabulary,~,index] = unique(words,'rows');
else
    [vocabulary,~,index] = unique(words);
end
vocabulary_size = length(vocabulary);          %number of unique utterances
frequencies = hist(index, vocabulary_size);

[ranked_freq,ranking_index] = sort(frequencies,'descend');
ranked_freq = ranked_freq';                     %change to column vector
ranking_index = ranking_index';                 %change to column vector

if size(words,2) > 1
    ranked_list = vocabulary(ranking_index,:);
else
    ranked_list = vocabulary(ranking_index);
end

end