function [ Conf_intervals ] = confidence_intervals( samples, interval )
%% Use return value with the errorbar function as follows
%errorbar(X,mean(samples),ConfIntervals(:,1),ConfIntervals(:,2));

% Samples should be in each row of a column where the column is the dataset to analyse

if nargin <2
 interval = 95; %  Confidence = 95%
end

    L = length(samples);
    a = 1 - interval/100;
    ts = tinv([a/2,  1-a/2],L-1);      % T-Score
    
    Conf_intervals(:,1) = ts(1)*std(samples)/sqrt(L);             % Confidence Intervals
    Conf_intervals(:,2) = ts(2)*std(samples)/sqrt(L);             % <-'
    
    
end

