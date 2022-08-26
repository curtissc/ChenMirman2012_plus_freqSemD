function entropy=cee(target,input)
%% cee calculates cross-entropy value
%
% Input:  target   - The target activation value
%         input    - The current activation value
% Output: entropy  - The cross-entropy value

act=input+0.01; % some small boost for activation value to avoid log-zero problem 
entropy=sum(target.*log(act)+(1-target).*log(1-act));
entropy=-entropy;

