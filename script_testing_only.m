% for i=1:size(powerMat,3)
%     wind_matrix_pf(:,:,i) = windowMat(PFMat(:,:,i),'mean',1);
% end
% 
% [a,b,c] = size(wind_matrix_pf);
% for i=1:a
%     for j=1:b
%         for k=1:c
%             wind_matrix_pf(i,j,k)=.95;
%         end
%     end
% end
% 
% light_mat = [zeros(400,1);ones(800,1)*100;zeros(240,1)];

clear all;
power_mats = extractCSVs('power_*.csv',1);
% light_mat = extractCSVs('light_*.csv',1);

diff_days_in_mat = unique(power_mats(:,3,1));
num_of_instances = [];

for i=1:length(diff_days_in_mat)
    count = sum(power_mats(:,3,1)==diff_days_in_mat(i));
    num_of_instances(i)=count;
end

to_delete = diff_days_in_mat(num_of_instances~=max(num_of_instances));

for j=1:length(to_delete)
    for i=1:size(power_mats,3)
        power_mats_trim(:,:,i) = power_mats(power_mats(:,3,i)~=to_delete(j),:,i);
    end
end

dim_3 = size(power_mats_trim,3);
aggr_pow = sum(power_mats_trim,3);
aggr_pow = [aggr_pow(:,1:6,:)./dim_3 medfilt1(aggr_pow(:,7,:),300)];
aggr_pow = flipud(aggr_pow);

pow_mats_mean = windowMat(aggr_pow,'mean',1);
pow_mats_range = windowMat(aggr_pow,'range',1);
pow_mats_peak = windowMat(aggr_pow,'peak',1);


% light_mat_wind = windowMat(light_mat,'mean',1);
% 
% light_mat_pow = zeros(length(light_mat_wind),1);
% 
% for i=1:length(light_mat_wind)
%     if light_mat_wind(i) > 5
%         light_mat_pow(i) = 2.128;
%     end
% end

% shuffledArray = orderedArray(randperm(size(orderedArray,1)),:);


occup_mat = processOccupCSV('3-22-13-gtruth.csv',1,'binary',0);
tot_pow_mean = pow_mats_mean; %+ (occup_mat.*2.128);
tot_pow_range = pow_mats_range;
tot_pow_peak = pow_mats_peak; %+ (occup_mat.*2.128);


filename = 'powdata_3_22.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,'%s\n','@Attribute mean_kW Numeric');
fprintf(fid,'%s\n','@Attribute range_kW Numeric');
fprintf(fid,'%s\n','@Attribute peak_kW Numeric');
fprintf(fid,'%s\n\n','@Attribute Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');


for i=1:length(occup_mat)
    fprintf(fid,'%f,%f,%f,%d\n',tot_pow_mean(i),tot_pow_range(i),tot_pow_peak(i),occup_mat(i));
end

fclose(fid);