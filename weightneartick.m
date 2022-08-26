% Connection weights within semantic layer in the near semantic neighbor
% condition

av=0.02;bv=0.024;cv=0.03;dv=0.002;

%% With neighors

WLR=ones(70,70)*(-1*cv);
WLR(1:8,1:8)=1*bv;
WLR(1:8,9:10)=dv;
WLR(9:10,9:10)=av;
WLR(9:10,1:8)=dv;
WLR(1:8,11:12)=dv;
WLR(11:12,1:8)=dv;
WLR(11:12,11:12)=av;

%% Without neighors

WLR1=ones(70,70)*(-1*cv);
WLR1(1:10,1:10)=1*av;
