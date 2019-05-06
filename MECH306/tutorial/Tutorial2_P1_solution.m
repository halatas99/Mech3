%% Solution for Tutorial 2, P1
clc; clear; close all;
s = 1;
N = 1000;
M_values= [1 4 16 32];
M_size = size(M_values,2); % = 4
epsilon = zeros(M_size,N); % initialize epsilon matrix to store data

% generate the pdf for normal distribution to compare with our histograms:
x = -3:0.1:3;
norm = normpdf(x,0,1); 

for m = 1:M_size  % Loop over the assigned M values
    M = M_values(m); 
    for n = 1:N
        sign = (rand(1,M) > 0.5)*2-1; % generate M random plus / minus signs
        delta = sign * s/sqrt(M);
        epsilon(m, n) = sum(delta);
    end
    figure(m)
    histogram(epsilon(m, :),'Normalization','pdf','DisplayStyle','stairs')
    hold on
    plot(x,norm)
    legend(['M=' num2str(M) ', Histogram'], 'Normal Distribution')
end
