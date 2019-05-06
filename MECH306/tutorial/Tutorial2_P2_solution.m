% Tutorial 2 simulation of beam bending experiment
clear all
%% Here are the baseline measurements, in SI
L0=0.7 ;% beam length in m
h0=0.03;% beam depth in m
b0=0.04;% beam width in m
F0=80;% applied force at end of cantilever beam, N
delta0=0.008 ;% displacement at end
% put these into the beam bending equation to get baseline estimate of E
E0=F0*L0^3/3/delta0/(b0*h0^3/12);
% to construct random variables out of these, need standard deviations as
% as PERCENT OF MEAN
sLp=2;%
shp=10;
sbp=1;
sFp=1;
sdelp=1;
% express these now as standard deviations in the physical units (not
% relative values
sL=sLp*L0/100;% same units as L
sh=shp*h0/100;
sb=sbp*b0/100;
sF=sFp*F0/100;
sdel=sdelp*delta0/100;
%% simulation
N=  10000  ;% number of trials
L=L0+sL*randn(1,N);
h=h0+sh*randn(1,N);
b=b0+sb*randn(1,N);
F=F0+sF*randn(1,N);
del=delta0+sdel*randn(1,N);
% construct normally distributed variables for all parameters

E=F.*L.^3./3./del./(b.*h.^3/12);
   %this is now a vector of values for Young’s modulus

sErel=std(E)/E0  %Much easier to view results relative to E0
meanE=mean(E)/E0
%% All variables in one histogram
figure(1)
histogram(L/L0,'Normalization','pdf','DisplayStyle','stairs');
hold on
histogram(h/h0,'Normalization','pdf','DisplayStyle','stairs');
histogram(b/b0,'Normalization','pdf','DisplayStyle','stairs');
histogram(F/F0,'Normalization','pdf','DisplayStyle','stairs');
histogram(del/delta0,'Normalization','pdf','DisplayStyle','stairs');
histogram(E/E0,'Normalization','pdf','DisplayStyle','stairs');
legend('L/L0','h/h0','b/b0','F/F_0','delta/delta0','E/E0')


%% Histogram of E/E0
figure(2)
histogram(E/E0,'Normalization','pdf','DisplayStyle','stairs');
title('Normalized Histogram of E/E_0')

