function [ interpolated_values ] = interpVal_2D( values, index_values1, index_values2, desired_index_values1, desired_index_values2, interpolation_type )
%INTERPVAL Summary of this function goes here
%   Detailed explanation goes here

if nargin < 6
    interpolation_type = 'linear';
end

interpolated_indices1 = zeros(length(desired_index_values1) + 1,1);
interpolated_indices2 = zeros(length(desired_index_values2) + 1,1);

[~, interpolated_indices1] = Tools.interpVal(interpolated_indices1, index_values1, desired_index_values1);
[~, interpolated_indices2] = Tools.interpVal(interpolated_indices2, index_values2, desired_index_values2);

%interpolated_values = interp2(values, interpolated_indices1, interpolated_indices2);
interpolated_values = interp2(values, interpolated_indices1, interpolated_indices2, interpolation_type);

end

