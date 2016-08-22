function [histw, histv] = histwv(v, w, bins) 
%Inputs: 
%vv - values 
%ww - weights 
%minV - minimum value 
%maxV - max value 
%bins - number of bins (inclusive) 

%Outputs: 
%histw - wieghted histogram 
%histv (optional) - histogram of values 
minV = min(v);
maxV = max(v);

delta = (maxV-minV)/(bins-1); 
subs = round((v-minV)/delta)+1; 

histv = accumarray(subs,1,[bins,1]); 
histw = accumarray(subs,w,[bins,1]); 
end