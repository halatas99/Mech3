% [MECH 305/6] Tutorial 5: Machine Learning
% Starter scripts for processing the red wine data
% Athena Liu 
% March 24, 2019
% Use this as a starter for your assignment
clear; clc;
%% 1. Load the data
redWine = readtable("trainRW");

%% 2. Examine the data by correlation plots and histograms
% Hint: Pick the variables with the greatest correlation with wine quality 
%   and the least correlation with each other, 
%   then check the description of the variables.  
%   Some variables are obviously closely related so they are likely redundant.  
%corrplot(redWine)
%{
We get these correlations to var12 from corrplot
v1 = .08;
v2 = .40;
v3 = .16;
v4 = .02;
v5 = .16;
v6 = .01;
v7 = .15;
v8 = .24;
v9 = .02;
v10 = .24;
v11 = .47;
%}

% Choose 5 out of the 11 features to build your ML model.
%{
% The 5 variables with highest correlation score are v11, v2, v10, v8, v3
%}
redWine_sigvars = [redWine(:,2) redWine(:,3) redWine(:,8) redWine(:,10) redWine(:,11) redWine(:,12)];
%% 3. Train machine learning model in the Classification App
% Examine plots within the app
% And export the model as trainedModel



%% 4. Make prediction on the validation data set using the exported model
% >>>>> IMPORTANT !!! <<<<<<<<<<<<
% Change the string to your student ID below:
StudentID = '16131161'; % NO ID, NO MAKR!!
% >>>>> IMPORTANT !!! <<<<<<<<<<<<

validation = readtable("validRWpredictors.csv");% load the validation data set
X = validation(:,1:11); % extract the features to predict wine quality

Yfit = trainedModel.predictFcn(X);
% For old MATLAB versions, Naive Bayes trainedModel may work with the following:
% Yfit=predict(trainedModel,X);

save(StudentID, 'Yfit', 'StudentID');
% Upload the saved .mat file to earn performance score