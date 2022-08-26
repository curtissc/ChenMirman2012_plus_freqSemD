% Connection weights within semantic layer in the distant semantic neighbor
% condition

av=0.02; % 1 overlapping unit
bv=0.06; % 11 overlapping units
cv=0.03; % non-overlapping units (negative)
dv=0.002; % sometimes overlap (sometimes smell)
ev=0.052 % 9 overlapping units
fv=0.036 % 5 overlapping units
gv=0.024 % 2 overlapping units


%% High Diversity

    WLRHD=ones(70,70)*(-1*cv);
    WLRHD(1:6,1:6)=av;
    WLRHD(1:6,7:10)=dv;
    WLRHD(7:10,7:10)=ev;
    WLRHD(7:10,1:6)=dv;
    WLRHD(7:10,11:70)=dv;
    WLRHD(11:70,7:10)=dv;
    WLRHD(11:16,11:16)=av;
    WLRHD(17:22,17:22)=av;
    WLRHD(23:28,23:28)=av;
    WLRHD(29:34,29:34)=av;
    WLRHD(35:40,35:40)=av;
    WLRHD(41:46,41:46)=av;
    WLRHD(47:52,47:52)=av;
    WLRHD(53:58,53:58)=av;
    %WLRHD(59:64,59:64)=av;
    %WLRHD(65:70,65:70)=av;
    
    WLRHD10=ones(70,70)*(-1*cv);
    WLRHD10(1:6,1:6)=av;
    WLRHD10(1:6,7:10)=dv;
    WLRHD10(7:10,7:10)=bv;
    WLRHD10(7:10,1:6)=dv;
    WLRHD10(7:10,11:70)=dv;
    WLRHD10(11:70,7:10)=dv;
    WLRHD10(11:16,11:16)=av;
    WLRHD10(17:22,17:22)=av;
    WLRHD10(23:28,23:28)=av;
    WLRHD10(29:34,29:34)=av;
    WLRHD10(35:40,35:40)=av;
    WLRHD10(41:46,41:46)=av;
    WLRHD10(47:52,47:52)=av;
    WLRHD10(53:58,53:58)=av;
    WLRHD10(59:64,59:64)=av;
    WLRHD10(65:70,65:70)=av;

%% Low Diversity

    WLRLD=ones(70,70)*(-1*cv);
    WLRLD(1:6,1:6)=av;
    WLRLD(1:6,7:10)=dv;
    WLRLD(7:10,7:10)=fv;
    WLRLD(7:10,1:6)=dv;
    WLRLD(7:10,11:70)=dv;
    WLRLD(11:70,7:10)=dv;
    WLRLD(11:16,11:16)=av;
    WLRLD(17:22,17:22)=av;
    WLRLD(23:28,23:28)=av;
    WLRLD(29:35,29:35)=av;
        
    WLRLD1=ones(70,70)*(-1*cv);
    WLRLD1(1:6,1:6)=av;
    WLRLD1(1:6,7:10)=dv;
    WLRLD1(7:10,1:6)=dv;
    WLRLD1(7:10,7:10)=gv;
    WLRLD1(7:10,11:70)=dv;
    WLRLD1(11:70,7:10)=dv;
    WLRLD1(11:16,11:16)=av;
    
    WLRLD0=ones(70,70)*(-1*cv);
    WLRLD0(1:10,1:10)=av;

 
