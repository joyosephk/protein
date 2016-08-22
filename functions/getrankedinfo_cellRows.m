function [ranked_list, ranked_freq] = getrankedinfo_cellRows(input)

u = sortrows(input);
[u{end+1,:}] = deal('');
j = ~all(strcmp(u(1:end-1,:), u(2:end,:)),2);
unique_list=u(j,:);   % List of unique rows


% Now that we have our unique list, let's sort it and get the frequency
[~,b] = ismemberCellRows(input,unique_list);
[i,j] = getrankedinfo(b);



ranked_list = unique_list(i,:);
ranked_freq = j;


end