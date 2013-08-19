function [ days_matrix ] = extractDays(full_matrix)
%This function takes a matrix that consists of several days worth of power
% data and splits it into individual days stacking it up into a 4D matrix.
        days = unique(full_matrix(:,3,:));
        
        summed_mat = sum(full_matrix,3);
        summed_mat = [summed_mat(:,1:6)/21 summed_mat(:,7)];
        summed_mat = flipud(summed_mat);
            
        for i=1:length(days)
            %fprintf('on day: %d\n',days(i));
            day = summed_mat(:,3) == days(i);
            days_mat = summed_mat(logical(day),:);

            power_mean = windowMat(days_mat,'mean',1);
            power_peak = windowMat(days_mat,'peak',1);
            power_range = windowMat(days_mat,'range',1);
            minutes = windowMat(days_mat,'minute',1);
            hours = windowMat(days_mat,'hour',1);
            day_vec = ones(length(hours),1)*days(i);
            days_matrix(:,:,i) = [day_vec hours minutes power_mean power_peak power_range];
        end
end

