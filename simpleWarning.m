function simpleWarning( warning_text, text_colour )
%SIMPLEWARNING Prints a coloured warning without the location information
% 
% Syntax:	SIMPLEWARNING(warning_text, text_colour)
% 
% Inputs: 
% 	warning_text - 2D cell array of warning text,
%                  each cell contains a line of text.
% 	text_colour  - RGB text colour as 1x3 matrix.
% 
% See also: warning, error, cprintf

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2017
% Date: 16 February 2017 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 2
    text_colour = [255,100,0]/255;
end

for l = 1:numel(warning_text)-1
    cprintf(text_colour, [warning_text{l} ' \n']);
end
if isempty(l),l=0;end
cprintf(text_colour, [warning_text{l+1}]);

end
