function actp=inhkernel3(acta)
%% INHKERNEL3 simgoid inhibition function
%
% Input:  acta  - Current activation value
% Output: actp  - Inhibition value transformed by sigmoid function

actp=15./(1.5+exp(-35.*(acta-0.3)));

