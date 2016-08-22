% Similar to ismember with arrays, but compares whole row of cells
% 
% You should check that number of columns for both cell matrices are the same
%
% Inputs ---
%   A - cell matrix you would like to check entries
%   B - cell matrix where elements of A may be found
%
% Outpus ---
%   id - indicates whether rows of A are found or not
%   id2 - contains the highest index of B for each row in A that is a
%   member in B
%
% Elegant solution found from
%   http://www.mathworks.com/matlabcentral/newsreader/view_thread/167415
%
% Written by Joseph Kim

function [tf,loc] = ismemberCellRows(A,B)

% First check whether columns are of cell array of strings for both
for i = 1 : size(A,2)
    c = iscellstr(A(:,i));
    if ~c
        A(:,i) = cellfun(@num2str,A(:,i),'un',0);
    end
end
for i = 1 : size(B,2)
    c = iscellstr(B(:,i));
    if ~c
        B(:,i) = cellfun(@num2str,B(:,i),'un',0);
    end
end

C = union(A,B) ;
[~,ai] = ismember(A,C) ;
[~,bi] = ismember(B,C) ;
[tf,loc] = ismember(ai,bi,'rows') ;


end