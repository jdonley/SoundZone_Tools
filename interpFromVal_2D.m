function [ interpolated_values ] = interpFromVal_2D( values, index_values1, index_values2, desired_index_values1, desired_index_values2 )
%INTERPVAL Summary of this function goes here
%   Detailed explanation goes here
interpolated_indices = zeros(length(desired_index_values1),1);
interpolated_values  = zeros(length(desired_index_values1),1);

[~, interpolated_indices] = Tools.interpVal(interpolated_indices, index_values1, desired_index_values1);

% for div = 1:length(desired_index_values1)
%     temp_ = interp2(values, interpolated_indices(div), 1:length(index_values2)); %interpolate data
%     temp = temp_ - desired_index_values2(div); % center desireable value
%     temp(temp >= 0) = NaN;
%     if sum(isnan(temp)) ~= length(temp)
%         [~, i_low] = min(abs(temp));
%     else
%         i_low = length(temp);
%     end
%     if i_low ~= length(temp)
%         i_high = i_low+1;
%         interpolated_values(div) = max( interp1(index_values2,  (desired_index_values2(div) - temp_(i_low)) / (temp_(i_high) - temp_(i_low)) + i_low  ), index_values2(1));
%     else
%         interpolated_values(div) = index_values2(i_low);
%     end
% end
    
    temp_ = interp2(values, interpolated_indices, 1:length(index_values2)); %interpolate data
    temp = temp_ - repmat(desired_index_values2, [size(temp_, 1) 1]); % center desireable value
    temp(temp >= 0) = NaN;
    
    i_low = zeros(1, size(temp,2));    
    [~, i_low(sum(isnan(temp), 1) ~= size(temp, 1))] = min(abs( temp(:, sum(isnan(temp), 1) ~= size(temp, 1))), [], 1);
    i_low(sum(isnan(temp), 1) == size(temp, 1)) = size(temp, 1);
    i_high = i_low(i_low ~= size(temp, 1)) + 1;
    
    low = diag(temp_(i_low(i_low ~= size(temp, 1)), i_low ~= size(temp, 1)))';
    high = diag(temp_(i_high,i_low ~= size(temp, 1)))';
    
    interpolated_values(i_low ~= size(temp, 1)) = max( interp2( repmat(index_values2, [size(temp_,2) 1]), ...
        (desired_index_values2(i_low ~= size(temp, 1)) - low) ./ ...
        ( high - low ) + i_low(i_low ~= size(temp, 1)), 1:size(low, 2))  , index_values2(1));
        
    interpolated_values(i_low == size(temp, 1)) = index_values2(i_low(i_low == size(temp, 1)));
    
end

