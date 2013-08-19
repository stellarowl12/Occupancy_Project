function [wind_matrix] = windowMat(input_mat,wind_type,wind_size)
%   Takes a matrix and windows it to be minute averages. So far can choose
%   from mean, peak, or range. Wind_size must be a factor of 60, it splits
%   up the hour into different time windows.

    vals_hr = 60/wind_size;
    vals_min = 1/wind_size;
    diff_days = myunique(input_mat(:,3,:));
    wind_matrix = zeros(length(diff_days)*24*vals_hr,1);

    for a=1:length(diff_days)

        day = input_mat(:,3) == diff_days(a);
        mat_day = input_mat(logical(day),:);
        %mean_day = mean(mat_day(:,7));
        %mat_day(:,7) = mat_day(:,7)-mean_day;

        for i=0:23

            hour = mat_day(:,4) == i;
            mat_hour = mat_day(logical(hour),:);
            
            if wind_size < 1
                min_indices = 0:1:59;
            else
                min_indices = 0:wind_size:59;
            end

            for j=min_indices
                
                if wind_size < 1
                    next_term = j+1;
                else
                    next_term = j+wind_size;
                end
                
                wind_min = mat_hour(:,5) >= j & mat_hour(:,5) < next_term;
                mat_min = mat_hour(logical(wind_min),:);
                
                sec_indices = 0:wind_size*60:59;

                for k=sec_indices
                    
                    wind_secs = mat_min(:,6) >= k & mat_min(:,6) < (k+(wind_size*60));
                    mat_win_final = mat_min(logical(wind_secs),:);
                    
                    if wind_size < 1
                        fine_term = (find(min_indices==j)-1)*vals_min+find(sec_indices==k);
                    else
                        fine_term = find(min_indices==j);
                    end

                    index = ((a-1)*24*vals_hr)+((i)*vals_hr)+fine_term; 

                    %fprintf('day = %d, hour = %d and minute = %d second = %d\n',a,i,j,k);

                    if ~isempty(mat_win_final)

                        power_vals = mat_win_final(:,7);

                        if strcmp(wind_type,'mean')
                            mean_power = mean(power_vals);
                            wind_matrix(index) = mean_power;
                        elseif strcmp(wind_type,'peak')
                            peak_power = max(power_vals);
                            wind_matrix(index) = peak_power;
                        elseif strcmp(wind_type,'range')
                            range_power = range(power_vals);
                            wind_matrix(index) = range_power;
                        elseif strcmp(wind_type,'sum')
                            sum_power = sum(power_vals);
                            wind_matrix(index) = sum_power;
                        elseif strcmp(wind_type,'minute')
                            wind_matrix(index) = j;
                        elseif strcmp(wind_type,'hour')
                            wind_matrix(index) = i;
                        elseif strcmp(wind_type,'day')
                            wind_matrix(index) = diff_days(a);
                        elseif strcmp(wind_type,'second')
                            wind_matrix(index) = k;
                        end

                        %energy or entropy of FFT coefficients
                    else
                        %fprintf('no data in day = %d hour = %d and minute = %d\n',input_mat(1,3,:),i,j);
                        if strcmp(wind_type,'mean')
                            wind_matrix(index) = wind_matrix(index-1); %100;
                        elseif strcmp(wind_type,'peak')
                            wind_matrix(index) = wind_matrix(index-1); %100;
                        elseif strcmp(wind_type,'range')
                            wind_matrix(index) = wind_matrix(index-1); %100;
                        elseif strcmp(wind_type,'sum')
                            wind_matrix(index) = wind_matrix(index-1); %100;
                        elseif strcmp(wind_type,'minute')
                            wind_matrix(index) = j;
                        elseif strcmp(wind_type,'hour')
                            wind_matrix(index) = i;
                        elseif strcmp(wind_type,'day')
                            wind_matrix(index) = diff_days(a);
                        elseif strcmp(wind_type,'second')
                            wind_matrix(index) = k;
                        end

                    end
                end
            end
        end
    end
end


