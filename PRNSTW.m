%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%Effect of NEAR semantic neighbors on word production%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preparation

clear all;

%% Parameters

% the maximum activation
Fmax=1;

% the minimum activtion
Fmin=0;

% the resting activation level
rest=0;

% semantics layer decay
decay1=0.1;

% word layer decay
decay2=0.02;

% number of time steps
step=80;

% external input
ic=0.003;

% word to word inhiibition
inh=0.04;

% word and semantics excitation
extf=0.03;
extb=0.03;

% decision threshold
thresh=0.7;

% weights within semantics layer
weightneartick;


%% Target with many near neighbors

% semantics layer
SL=zeros(step,70);

% word layer
WL=zeros(step,11);

% weights btween Semantics and Word Layer
WLW=zeros(11,70);
WLW(1,1:10)=1;
WLW(2,1:8)=1;WLW(2,11:12)=1;
 
WLW5=extf*WLW;
WLW3=extb*WLW; 
 
% inhibitory weights
WIN=ones(11,11);
WIN=inh*WIN;
for j=1:11
    WIN(j,j)=0;
end;

% input
input=zeros(1,70);
input(1:10)=ic;

for i=1:step-1
    
    SL(i+1,:)=((WLW3'*WL(i,:)')'+(WLR*SL(i,:)')')+input; % semantics layer net input
    
    WL(i+1,:)=((WLW5*SL(i,:)')')-(WIN*inhkernel3(WL(i,:)'))'; % word layer net input
    
    SL(i+1,:)=SL(i,:)...
        +(SL(i+1,:)>0).*((Fmax-SL(i,:)).*SL(i+1,:)-decay1.*(SL(i,:)-rest))... % if net input>0
        +(SL(i+1,:)<=0).*((SL(i,:)-Fmin).*SL(i+1,:)-decay1.*(SL(i,:)-rest));  % if net input<=0
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))...
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));   
    
    SL(i+1,:)=max(SL(i+1,:),0);
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    SL(i+1,:)=min(SL(i+1,:),1);
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
end;

% reaction times
[peak1,t1]=find_peak(WL,thresh);
%t1=t1-1;

% plotting figure
figure;
hold on;
plot(WL(1:step,1),'b-*');
plot(WL(1:step,2),'m-*');



%% Target with few near neighbors

% semantics layer
SL=zeros(step,70);

% word layer
WL=zeros(step,11);

% weights btween Letter and Word Layer
WLW=zeros(11,70);
WLW(1,1:10)=1;
 
WLW5=extf*WLW;
WLW3=extb*WLW; 
 
% inhibitory weights
WIN=ones(11,11);
WIN=inh*WIN;
for j=1:11
    WIN(j,j)=0;
end;

% input
input=zeros(1,70);
input(1:10)=ic;

for i=1:step-1
   
    SL(i+1,:)=((WLW3'*WL(i,:)')'+(WLR1*SL(i,:)')')+input;
    
    WL(i+1,:)=((WLW5*SL(i,:)')')-(WIN*inhkernel3(WL(i,:)'))';
    
    SL(i+1,:)=SL(i,:)...
        +(SL(i+1,:)>0).*((Fmax-SL(i,:)).*SL(i+1,:)-decay1.*(SL(i,:)-rest))...
        +(SL(i+1,:)<=0).*((SL(i,:)-Fmin).*SL(i+1,:)-decay1.*(SL(i,:)-rest));
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))...
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));   
    
    SL(i+1,:)=max(SL(i+1,:),0);
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    SL(i+1,:)=min(SL(i+1,:),1);
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
end;

% reaction times
[peak2,t2]=find_peak(WL,thresh);
%t2=t2-1;

% plotting figure;
hold on;
plot(WL(1:step,1),'r-x');

%% Figure

axes('position', [.5, .2, .25, .25]);
bar([t1 t2]);
