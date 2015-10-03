function [ Conf_intervals ] = confidence_intervals( samples, interval )
%CONFIDENCE_INTERVALS Find the confidence intervals for a set of data for use with the errorbar function in MATLAB
% 
% Syntax:	[Conf_intervals] = CONFIDENCE_INTERVALS( samples, interval )
% Pass the samples to the function with the desired confidence interval (95
% for 95%). Samples should be in each row of a column where the column is 
% the dataset to analyse
% 
% Inputs: 
% 	samples - A 1D or 2D array of samples where each column is a dataset for
% 	which the confidence intervals are calculated.
% 	interval - The confidence interval as a percentage (e.g. 95 for 95%
% 	confidence intervals).
% 
% Outputs: 
% 	Conf_intervals - Confidence intervals for use with the errorbar
% 	function in MATLAB.
%
% Example Usage:
%       load count.dat;
%       samples = count';
%       X=1:size(samples,2);
%       ConfIntervals = confidence_intervals(samples,95);
%       errorbar(X,mean(samples),ConfIntervals(:,1),ConfIntervals(:,2),'rx');
%       axis([0 25 0 250]);
% 
% See also: errorbar.m
% 
% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2015
% Date: 12 June 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin <2
    interval = 95;	%  Confidence = 95%
end

L = length(samples);
a = 1 - interval/100;
ts = tinv([a/2,  1-a/2],L-1);	% T-Score

Conf_intervals(:,1) = ts(1)*std(samples)/sqrt(L);	% Confidence Intervals
Conf_intervals(:,2) = ts(2)*std(samples)/sqrt(L);	% <-'


end

