function [x_n] = addNoise( x, level, type )
%ADDNOISE Summary of this function goes here
% 
% Syntax:	[OUTPUTARGS] = ADDNOISE(INPUTARGS) Explain usage here
% 
% Inputs: 
% 	x - The input signal to add noise to
% 	level - The noise in dB relative to the input signal
% 	type - The type of noise to add
% 
% Outputs: 
% 	x_n - The noisey output signal
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

x_n = Tools.generateNoise( x, level, type, true);

end
