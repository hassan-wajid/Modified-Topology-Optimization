function [percentage_ones, percentage_zeros] = calculateVolumes(binaryArray)
    % Input: binaryArray - a binary array containing only 0's and 1's
    % Output: percentage_ones - percentage of 1's in the array
    %         percentage_zeros - percentage of 0's in the array

    % Check if the input array contains only 0's and 1's
    if any(binaryArray(:) ~= 0 & binaryArray(:) ~= 1)
        error('Input array must contain only 0''s and 1''s.');
    end

    % Calculate percentages
    total_elements = numel(binaryArray);
    percentage_ones = sum(binaryArray(:) == 1) / total_elements * 100;
    percentage_zeros = sum(binaryArray(:) == 0) / total_elements * 100;
end
