function [ num_curr_char ] = showTimeToCompletion( percent_complete, num_prev_char )
%SHOWTIMETOCOMPLETION Prints the time to completion and expected finish of a looped simulation based on linear extrapolation.
% 
% Syntax:	[ num_curr_char ] = showTimeToCompletion( percent_complete, num_prev_char )
%   Note that before using this function in a loop the in-built MATLAB
%   function tic should be called.
% 
% Inputs: 
% 	percent_complete - A decimal number between 0 and 1 representing the
% 	percentage completion.
% 	num_prev_char - Number of previous characters printed to the screen
% 	(Usually ok to begin with 0 and then reuse num_curr_char)
% 
% Outputs: 
% 	num_curr_char - Number of characters printed to the screen. Usually
% 	feed this number back into this function on the next iteration or
% 	increment appropriately if other characters have been printed between
% 	function calls.
%
% Example: 
%       fprintf('\tCompletion: ');
%       n=0; tic;
%       len=1e2;
%       for i = 1:len
%           pause(1);
%           n = showTimeToCompletion( i/len, n);
%       end
% 
% See also: tic, toc
%
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

