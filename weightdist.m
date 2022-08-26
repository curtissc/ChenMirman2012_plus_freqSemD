% Connection weights within semantic layer in the distant semantic neighbor
% condition

av=0.02;bv=0.06;cv=0.03;dv=0.002;

%% With neighors

WLR=ones(70,70)*(-1*cv);
WLR(1:6,1:6)=av;
WLR(1:6,7:10)=dv;
WLR(7:10,7:10)=bv;
WLR(7:10,1:6)=dv;
WLR(7:10,11:70)=dv;
WLR(11:70,7:10)=dv;
WLR(11:16,11:16)=av;
WLR(17:22,17:22)=av;
WLR(23:28,23:28)=av;
WLR(29:34,29:34)=av;
WLR(35:40,35:40)=av;
WLR(41:46,41:46)=av;
WLR(47:52,47:52)=av;
WLR(53:58,53:58)=av;
WLR(59:64,59:64)=av;
WLR(65:70,65:70)=av;

%% Without neighors

WLR1=ones(70,70)*(-1*cv);
WLR1(1:10,1:10)=1*av;
