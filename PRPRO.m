%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%Word production%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preparation

clear all;

%% Parameters

% the maximum activation
Fmax=1;

% the minimum activation
Fmin=0;

% the resting activation level
rest=0;

% phonem/letter layer decay
decay1=0.02;

% word layer decay
decay2=0.02;

% number of time steps
step=80;

% external input
ic=0.001;

% word to word inhibition
inh=0.04;

% word and phoneme/letter excitation
extf=0.1;
extb=0.1;

% decision threshold
thresh=0.7;

% weights btween Letter and Word Layer
 WLW=[1 1 0 0 0 0 0
      1 0 1 0 0 0 0
      1 0 0 1 0 0 0
      1 0 0 0 1 0 0
      0 0 0 0 0 1 1];
 WLW5=extf*WLW;
 WLW3=extb*WLW; 

% inhibitory weights
WIN=ones(5,5);
WIN=inh*WIN;
for j=1:5
    WIN(j,j)=0;
end;
  
%% High Neighbors

% letter layer
LL=zeros(step,7);

% word layer
WL=zeros(step,5);

% input
input=zeros(1,5);
input(1)=ic;

for i=1:step-1
    
    LL(i+1,:)=(WLW3'*WL(i,:)')'; % phoneme layer net input
    
    WL(i+1,:)=(WLW5*LL(i,:)')'-(WIN*inhkernel3(WL(i,:)'))'+input; % word layer net input
    
    LL(i+1,:)=LL(i,:)...
        +(LL(i+1,:)>0).*((Fmax-LL(i,:)).*LL(i+1,:)-decay1.*(LL(i,:)-rest))... % if input>0
        +(LL(i+1,:)<=0).*((LL(i,:)-Fmin).*LL(i+1,:)-decay1.*(LL(i,:)-rest));  % if input<=0
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))... % if input>0
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));  % if input<=0
    
    LL(i+1,:)=max(LL(i+1,:),0); % not smaller than 0
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    LL(i+1,:)=min(LL(i+1,:),1); % not larger than 1
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
end;

% reaction times
[peak1,t1]=find_peak(LL,thresh);
%t1=t1-1;

% plotting figure
figure;
hold on;
plot(LL(1:step,1),'r-*');
%plot(LL(1:step,2),'b-*');
%plot(LL(1:step,3),'y-o');
%plot(LL(1:step,4),'g-+');
%plot(LL(1:step,5),'b-*');
%plot(LL(1:step,6),'m-.');
%plot(LL(1:step,7),'c-x');
%hold off;

%% Low Neighbors

% letter layer
LL=zeros(step,7);

% word layer
WL=zeros(step,5);

% input
input=zeros(1,5);
input(5)=ic;

for i=1:step-1
    
    LL(i+1,:)=(WLW3'*WL(i,:)')'; % phoneme layer net input
    
    WL(i+1,:)=(WLW5*LL(i,:)')'-(WIN*inhkernel3(WL(i,:)'))'+input; % word layer net input
    
    LL(i+1,:)=LL(i,:)...
        +(LL(i+1,:)>0).*((Fmax-LL(i,:)).*LL(i+1,:)-decay1.*(LL(i,:)-rest))... % if net input>0
        +(LL(i+1,:)<=0).*((LL(i,:)-Fmin).*LL(i+1,:)-decay1.*(LL(i,:)-rest));  % if net input<=0
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))...
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));   
    
    LL(i+1,:)=max(LL(i+1,:),0); % not smaller than 0
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    LL(i+1,:)=min(LL(i+1,:),1); % not larger than 1
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
end;

% reaction times
[peak2,t2]=find_peak(LL,thresh);
%t2=t2-1;

hold on;
plot(LL(1:step,6),'g-*');

%% Figure;

axes('position', [.5, .2, .25, .25]);
bar([t1,t2]);
