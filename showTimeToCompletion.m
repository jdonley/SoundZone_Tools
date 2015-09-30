function [ num_curr_char ] = showTimeToCompletion( percent_complete, num_prev_char )
%SHOWTIMETOCOMPLETION Summary of this function goes here
% 
% Syntax:	SHOWTIMETOCOMPLETION(INPUTARGS) Explain usage here
% 
% Inputs: 
% 	input1 - Description
% 	input2 - Description
% 	input3 - Description
% 
% Outputs: 
% 	output1 - Description
% 	output2 - Description
% 
% Example: 
% 	Line 1 of example
% 	Line 2 of example
% 	Line 3 of example
% 
% See also: List related files here

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2015
% Date: 25 August 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    tElapsed = toc;
    ratio = percent_complete;
    tRem = (1-ratio) / ratio * tElapsed;
    tTot = tElapsed + tRem;
    fprintf(repmat('\b',1,num_prev_char));
    num_curr_char=fprintf('%.2f%% \n\tRemaining: %d mins %.0f secs \n\tTotal: %d mins %.0f secs\n\tExpected Finish: %s\n', ...
        ratio * 100, ...
        floor(tRem/60), ...
        rem(tRem,60), ...
        floor(tTot/60), ...
        rem(tTot,60), ...
        datestr(datetime + seconds(tRem),'dd-mmm-yyyy hh:MM:SS AM'));
end

