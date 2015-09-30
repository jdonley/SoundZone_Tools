function [n_] = generateNoise( x, level, type, add )
%ADDNOISE Summary of this function goes here
% 
% Syntax:	[OUTPUTARGS] = ADDNOISE(INPUTARGS) Explain usage here
% 
% Inputs: 
% 	x - The input signal to add noise to
% 	level - The noise in dB relative to the input signal
% 	type - The type of noise to add
%   add - true if input is added to noise, false otherwise
% 
% Outputs: 
% 	n_ - The generated noise signal
% 
%

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2015
% Date: 21 August 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
    type = 'UWGN'; % Uniform White Gaussian Noise
end
if nargin < 4
    add = false;
end

% Maximum value in input signal
max_val =  max( abs( x(:) ) );

% Level in magnitude
level_mag = db2mag(level);

% Seed random number generator based on the current time
rng('shuffle');

if strcmp(type,'UWGN')
   
    noise_ = rand( size(x) ) * 2 - 1; % UWGN: -1 to 1
    if ~add
        x = 0;
    end
    n_ = x + max_val * noise_ * level_mag;
    
else
    error('''type'' argument for noise not supported');
end

end
