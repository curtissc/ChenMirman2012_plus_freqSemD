%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Spoken word recognition%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preparation

clear all;

%% Parametes

% the maximum activation
Fmax=1;

% the minimum activation
Fmin=0;

% the resting activation level
rest=0;

% phoneme/letter layer decay
decay1=0.02;

% word layer decay
decay2=0.02;

% number of time steps
step=80;

% external input
ic=0.01;

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

 
for i=1:step-1 % when i=1, time=0 and so on, so time=i-1
    
    input=zeros(1,7); % reset input on each time step
    if i>=1 && i<=30  % First phoneme from time steps 1 through 30
       input(1)=ic;
    end;
    if i>=25 && i<=54 % Second phoneme from times steps 25 through 54
       input(2)=ic;
    end;

    LL(i+1,:)=input+(WLW3'*WL(i,:)')'; % phoneme layer net input
    
    WL(i+1,:)=(WLW5*LL(i,:)')'-(WIN*inhkernel3(WL(i,:)'))'; % word layer net input
    
    LL(i+1,:)=LL(i,:)...
        +(LL(i+1,:)>0).*((Fmax-LL(i,:)).*LL(i+1,:)-decay1.*(LL(i,:)-rest))... % if net input>0
        +(LL(i+1,:)<=0).*((LL(i,:)-Fmin).*LL(i+1,:)-decay1.*(LL(i,:)-rest));  % if net input<=0
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))... % if net input>0
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));  % if net input<=0
    
    LL(i+1,:)=max(LL(i+1,:),0); % not smaller than 0
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    LL(i+1,:)=min(LL(i+1,:),1); % not larger than 1
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
end;

% reaction times
[peak1,t1]=find_peak(WL,thresh);
%t1=t1-1;

% plotting figure
figure;
hold on;
plot(WL(1:step,1),'r-*');
plot(WL(1:step,2),'b-*');
%hold off;


%% Low Neighbors

% letter layer
LL=zeros(step,7);

% word layer
WL=zeros(step,5);

for i=1:step-1
    
    input=zeros(1,7);  % reset input on each time step
    if i>=1 && i <=30  % First Phoneme from time steps 1 through 30
       input(6)=ic;
    end;
    if i>=25 && i<=54  % Second Phoneme from times steps 25 through 54
       input(7)=ic;
    end;
    
    
    LL(i+1,:)=input+(WLW3'*WL(i,:)')'; % phoneme layer net input
    
    WL(i+1,:)=(WLW5*LL(i,:)')'-(WIN*inhkernel3(WL(i,:)'))'; % word layer net input
    
    LL(i+1,:)=LL(i,:)...
        +(LL(i+1,:)>0).*((Fmax-LL(i,:)).*LL(i+1,:)-decay1.*(LL(i,:)-rest))... % if net input>0
        +(LL(i+1,:)<=0).*((LL(i,:)-Fmin).*LL(i+1,:)-decay1.*(LL(i,:)-rest));  % if net input<=0
    
    WL(i+1,:)=WL(i,:)...
        +(WL(i+1,:)>0).*((Fmax-WL(i,:)).*WL(i+1,:)-decay2.*(WL(i,:)-rest))... % if net input>0
        +(WL(i+1,:)<=0).*((WL(i,:)-Fmin).*WL(i+1,:)-decay2.*(WL(i,:)-rest));  % if net input<=0
    
    LL(i+1,:)=max(LL(i+1,:),0); % not smaller than 0
    
    WL(i+1,:)=max(WL(i+1,:),0);
    
    LL(i+1,:)=min(LL(i+1,:),1); % not larger than 1
    
    WL(i+1,:)=min(WL(i+1,:),1);
    
end;

% reaction times
[peak2,t2]=find_peak(WL,thresh);
%t2=t2-1;

hold on;
plot(WL(1:step,5),'b-*');


%% Figure;

axes('position', [.5, .2, .25, .25]);
bar([t1,t2]);
