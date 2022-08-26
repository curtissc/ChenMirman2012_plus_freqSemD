function [peak,latency]=find_peak_min_new(acts,thresh)
%% Finding first time step when any unit activation reaches (below) the threshold
% Input:  acts    - Activation matrix
%         thresh  - Threshold value
% Output: peak    - Which choic is selected
%         latency - Reaction times

peak=[];
latency=[];

for c=1:size(acts,1)
    is=find(acts(c,:)<=thresh);
    if ~isempty(is)
        peak=is;
        latency=c;
        return;
    end;
end;

peak=-1;
latency=-1;

