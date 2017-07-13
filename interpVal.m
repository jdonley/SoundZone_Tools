function [ interpolated_values,  interpolated_indices] = interpVal( values, index_values, desired_index_values )
% This function will interpolate from desired arbitrarily spaced index values
% 
% Syntax:	[ interpolated_values,  interpolated_indices] = interpVal( values, index_values, desired_index_values )
% 
% Inputs: 
% 	values - A 1D array of values to interpolate between
% 	index_values - The axis values of the array
%   desired_index_values - The desired axis values to interpolate to
%   (Can be spaced abitrarily)
% 
% Outputs: 
%   interpolated_values - The new interpolated values
% 	interpolated_indices - The new interpolated indices
% 
% Example: 
% 
% See also: List related files here

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2017
% Date: 03 October 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interpolated_indices = zeros(length(desired_index_values),1);

% interpolated_values  = zeros(length(desired_index_values),1);
% for div = 1:length(desired_index_values)
%     temp = index_values - desired_index_values( div ); % center desireable value
%     temp(temp >= 0) = NaN;
%     [~, i_low] = min(abs(temp));
%     if i_low ~= length(temp)
%         i_high = i_low+1;
%         interpolated_indices( div ) = (desired_index_values(1, div) - index_values(i_low)) / ...
%                                   (index_values(i_high) - index_values(i_low)) + i_low;
%     else
%         interpolated_indices( div ) = i_low;
%     end
%     interpolated_values( div ) = interp1(values, interpolated_indices( div ));
% end
% a = interpolated_indices;
% b = interpolated_values;

    temp = repmat(index_values, [length(desired_index_values) 1]) - repmat(desired_index_values', [1 length(index_values)]); % center desireable value
    temp(temp >= 0) = NaN;
    [~, i_low] = min(abs(temp), [], 2);
    i_low = i_low';
    i_high = zeros(size(i_low));
    i_high(i_low ~= length(temp)) = i_low(i_low ~= length(temp)) + 1;
    
    interpolated_indices(i_low ~= length(temp)) = (desired_index_values - index_values(i_low(i_low ~= length(temp)))) ./ ...
                                  (index_values(i_high(i_low ~= length(temp))) - index_values(i_low(i_low ~= length(temp)))) + i_low(i_low ~= length(temp));
    
    interpolated_indices(i_low == length(temp)) = i_low(i_low == length(temp));
                      

    interpolated_values = interp1(values, interpolated_indices);
    
   
end

