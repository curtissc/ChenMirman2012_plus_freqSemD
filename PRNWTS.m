%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Effect of NEAR semantic neighbors on word recognition%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preparation

clear all;

%% Parameters

% the maximum activation
Fmax=1;

% the minimum activation
Fmin=0;

% the resting activation level
rest=0;

% semantic layer decay
decay1=0.1;

% word layer decay
decay2=0.02;

% number of time steps
step=80;

% external input
ic=0.001;

% word to word inhibition
inh=0.04;

% word and semantics excitation
extf=0.03;
extb=0.03;

% decision threshold
thresh=0.2;

% weights within semantics layer
weightneartick;

%% Target with many near

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

%initialization of cross-entropy value
en1=zeros(step,1);
en3=zeros(step,1);

% target
target=zeros(1,70);
target(1:10)=1;
target3=zeros(1,70);
target3(1:8)=1;target3(11:12)=1;

% cross-entroy value for the first (0) time step
en1(1)=cee(target,SL(1,:));
en3(1)=cee(target3,SL(1,:));

% input
input=zeros(1,11);
input(1)=ic;

for i=1:step-1
    
    SL(i+1,:)=((WLW3'*WL(i,:)')'+(WLR*SL(i,:)')'); % semantics layer net input
    
    WL(i+1,:)=((WLW5*SL(i,:)')')-(WIN*inhkernel3(WL(i,:)'))'+input; % word layer net input
    
    SL(i+1,:)=SL(i,:)...
        +(SL(i+1,:)>0).*((Fmax-SL(i,:)).*SL(i+1,:)-decay1.*(SL(i,:)-rest))... % if net input>0
        +(SL(i+1,:)<=0).*((SL(i,:)-Fmin).*SL(i+1,:)-decay1.*(SL(i,:)-rest));  % if net input<=0
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))...
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));   
    
    SL(i+1,:)=max(SL(i+1,:),0); % not smaller than 0
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    SL(i+1,:)=min(SL(i+1,:),1); % not larger than 1
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
    en1(i+1)=cee(target,SL(i+1,:)); %updating cross entropy value
    
    en3(i+1)=cee(target3,SL(i+1,:));
    
end;

% normalizating the cross-entropy value
en1=en1/max(en1);
en3=en3/max(en3);

% reaction time
[peak1,t1]=find_peak_min_new(en1,thresh);
%t1=t1-1;

%% Target with few near

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

% initialization of cross-entropy value
en2=zeros(step,1);

% target
target=zeros(1,70);
target(1:10)=1;

% cross-entroy value for the first (0) time step
en2(1)=cee(target,SL(1,:));

% input
input=zeros(1,11);
input(1)=ic;

for i=1:step-1
    
    SL(i+1,:)=((WLW3'*WL(i,:)')'+(WLR1*SL(i,:)')');
    
    WL(i+1,:)=((WLW5*SL(i,:)')')-(WIN*inhkernel3(WL(i,:)'))'+input;
    
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
    
    en2(i+1)=cee(target,SL(i+1,:));
    
end;

en2=en2/max(en2);

[peak2,t2]=find_peak_min_new(en2,thresh);
%t2=t2-1;

%% Figure

figure;
hold on;
plot(en1(1:step),'b-*');
plot(en2(1:step),'r-*');
plot(en3(1:step),'y-*');

axes('position', [.5, .2, .25, .25]);
bar([t1 t2]);
