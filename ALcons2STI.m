function [ STI ] = ALcons2STI( ALcons )
%ALCONS2STI Converts Articulation Loss of Consonants (ALcons) to the Speech Transmission Index (STI)
% 
% Syntax:	[STI] = ALcons2STI( ALcons ) Pass the Articulation Loss of 
%Consonants (ALcons) value to the function to retrieve the STI value.
% 
% Inputs: 
% 	ALcons - Articulation Loss of Consonants value
% 
% Outputs: 
% 	STI - Corresponding Speech Transmission Index value
% 
% 
% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2015
% Date: 30 September 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

STI = -0.1845 * log(ALcons) + 0.9482;

end

