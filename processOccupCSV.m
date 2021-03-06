function [occup_mat] = processOccupCSV(csvname,wind_size,option,occup_levels)
%csvname is name of occupancy data containing CSV file in string format.
%Wind_size determines how many minutes is going to be considered at any
%given time. Wind_size must be a multiple of 60. Make sure CSV file
%includes an occupancy count at hour 0 min 0 sec 0, manually input it if
%needed. Option should be either 'coarse','fine','binary'. If it is 'coarse'
%then occup levels defines the splits of occupancy levels, e.g. 
%[1,3,8,15] 

    occup_times = csvread(csvname);
    occup_ranges = zeros(24*60,1);
    pruned_occup_times = [];
    
    for i=1:size(occup_times,1)-1
        if occup_times(i,3)+occup_times(i,4)~=occup_times(i+1,3)+occup_times(i+1,4)
            pruned_occup_times = [pruned_occup_times; occup_times(i,:)];
        end
    end
    
    pruned_occup_times = [pruned_occup_times; occup_times(size(occup_times,1),:)];
    occup_cnt = pruned_occup_times(:,7);
    num_occup_changes = size(pruned_occup_times,1);
    
    for i=1:num_occup_changes-1
        index=pruned_occup_times(i,3)*60+pruned_occup_times(i,4);
        next_index=pruned_occup_times(i+1,3)*60+pruned_occup_times(i+1,4);
        if index == 0
            index = 1;
        end
        
        for j=index:next_index%%%-1 took it out because last value was staying 0 even when its supposed to be a 1.
            if strcmp(option,'binary')
                if occup_cnt(i)>0 && occup_cnt(i)~=100
                    occup_ranges(j)=1;
                elseif occup_cnt(i)==100
                    occup_ranges(j)=100;
                else
                    occup_ranges(j)=0;
                end
            else
                occup_ranges(j)=occup_cnt(i);
            end
        end
        
    end
    
    occup_mat = zeros(1440,1);
    
    if strcmp(option,'fine')
        % occup_mat = downsample(occup_ranges,wind_size);
        for i=1:(1440)
            occup_mat(i) = min(occup_ranges((i-1)+1:i));
        end
            
        
    elseif strcmp(option,'coarse')
        %occup_mat = downsample(occup_ranges,wind_size);
        for i=1:(1440)
            count = min(occup_ranges((i-1)+1:i));
            for j=1:size(occup_levels,2)
                if j < size(occup_levels,2)
                    if count >= occup_levels(j) && count < occup_levels(j+1)
                        count = j-1;
                    end
                else
                    if count >= occup_levels(j) && count ~= 100
                        count = j-1;
                    end
                end
            end
            occup_mat(i) = count;
        end
        
        
%         max_cnt = max(occup_mat);
%         steps = 0:round(max_cnt/num_of_splits):max_cnt;
%         
%         if length(steps) <= num_of_splits
%             steps = [steps max_cnt];
%         end
%         
%         for i=1:length(occup_mat)
%             for j=1:length(steps)-1
%                 if occup_mat(i)>=steps(j) && occup_mat(i)<steps(j+1)
%                     occup_mat(i) = steps(j);
%                 end
%             end
%         end        

        
        

    elseif strcmp(option,'binary')
        %occup_mat = downsample(occup_ranges,wind_size);
        for i=1:(1440)
            occup_mat(i) = min(occup_ranges((i-1)+1:i));
        end
    else
        disp('Option argument must be "coarse", "fine" or "binary"');
    end    
    
    if wind_size < 1
        occup_mat = kron(occup_mat,ones(1/wind_size,1));
    else
        occup_mat = downsample(occup_mat,wind_size);
    end
    
end

