function [ interpolated_values,  interpolated_indices] = interpVal( values, index_values, desired_index_values )
%INTERPVAL Summary of this function goes here
%   Detailed explanation goes here
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
    
    
%     fprintf( 'interpVal:\t\t\tinterpolated_indices diff = %f\n', norm(a-interpolated_indices));
%     fprintf( 'interpVal:\t\t\tinterpolated_values  diff = %f\n', norm(b-interpolated_values));
end

