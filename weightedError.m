function [ error_val ] = weightedError(confusion_mat, distance_vec)
%Takes a confusion matrix and a vector denoting distance
% between classes to output a new error metric. 
%%[0 1 2.5 5.5 10]

distance_mat = zeros(length(distance_vec),length(distance_vec));

for i=1:length(distance_vec)
    for j=1:length(distance_vec)
        
        distance_mat(i,j) = abs(distance_vec(i)-distance_vec(j));
        
        
    end
end

percentage_mat = confusion_mat ./ sum(sum(confusion_mat));

weighted_mat = distance_mat .* percentage_mat;

error_val = sum(sum(weighted_mat));


end

