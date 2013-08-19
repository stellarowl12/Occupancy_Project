clear all;
power_mats = extractCSVs('pow_2weeks*.csv',1);
pf_mats = extractCSVs('pf_2weeks*.csv',1);
wind_size = 1;


%%%Normalization
for i=1:size(power_mats,3)
   mean_day = mean(power_mats(:,7,i));
   power_mats(:,7,i) = power_mats(:,7,i) - mean_day;
end

for i=1:size(pf_mats,3)
   mean_day = mean(pf_mats(:,7,i));
   pf_mats(:,7,i) = pf_mats(:,7,i) - mean_day;
end

%%%Creating days, hours, minutes vectors
mat_days = windowMat(power_mats(:,:,1),'day',wind_size);
mat_days = flipud(mat_days);
mat_hrs = windowMat(power_mats(:,:,1),'hour',wind_size);
mat_mins = windowMat(power_mats(:,:,1),'minute',wind_size);

%%%Creating month vector
for k=1:length(mat_days)
    if (mat_days(k) < 20)
        mat_mons(k)=6;
    else
        mat_mons(k)=5;
    end
end

%%%Creating UTC timestamps vector
utc_times = zeros(length(mat_days),1);

for i=1:length(mat_days)
    %disp(i);
    utc_times(i) = datetime_to_unix(2013,mat_mons(i),mat_days(i),mat_hrs(i),mat_mins(i));
end

%%%Creating Occupancy ground truth vectors
occup524 = [processOccupCSV('5_24_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_24_gtruth.csv',wind_size,'binary',5)];
occup525 = [processOccupCSV('5_25_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_25_gtruth.csv',wind_size,'binary',5)];
occup526 = [processOccupCSV('5_26_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_26_gtruth.csv',wind_size,'binary',5)];
occup527 = [processOccupCSV('5_27_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_27_gtruth.csv',wind_size,'binary',5)];
occup528 = [processOccupCSV('5_28_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_28_gtruth.csv',wind_size,'binary',5)];
occup529 = [processOccupCSV('5_29_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_29_gtruth.csv',wind_size,'binary',5)];
occup530 = [processOccupCSV('5_30_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_30_gtruth.csv',wind_size,'binary',5)];
occup531 = [processOccupCSV('5_31_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('5_31_gtruth.csv',wind_size,'binary',5)];
occup61 = [processOccupCSV('6_1_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('6_1_gtruth.csv',wind_size,'binary',5)];
occup62 = [processOccupCSV('6_2_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('6_2_gtruth.csv',wind_size,'binary',5)];
occup63 = [processOccupCSV('6_3_gtruth.csv',wind_size,'coarse',[0,1,2,4,8]) processOccupCSV('6_3_gtruth.csv',wind_size,'binary',5)];

occup_mat = vertcat(occup524,occup525,occup526,occup527,occup528,...
    occup529,occup530,occup531,occup61,occup62,occup63);

%%%Windowing the power and power factor matrices
for i=1:size(power_mats,3)
    pow_mats_mean(:,i) = windowMat(power_mats(:,:,i),'mean',wind_size,i);
    pow_mats_range(:,i) = windowMat(power_mats(:,:,i),'range',wind_size,i);
    pow_mats_peak(:,i) = windowMat(power_mats(:,:,i),'peak',wind_size,i);
end

for i=1:size(pf_mats,3)
    pf_mats_mean(:,i) = windowMat(pf_mats(:,:,i),'mean',wind_size,i);
    pf_mats_range(:,i) = windowMat(pf_mats(:,:,i),'range',wind_size,i);
    pf_mats_peak(:,i) = windowMat(pf_mats(:,:,i),'peak',wind_size,i);
end

%%%Creating light vectors
Light24 = [ones(20*60+56,1);zeros(1440-(20*60+56),1)];
Light25 = [zeros(6*60+8,1);ones((20*60+19)-(6*60+8),1);zeros(1440-(20*60+19),1)];
Light26 = [zeros(11*60+43,1);ones((16*60+27)-(11*60+43),1);zeros(1440-(16*60+27),1)];
Light27 = [zeros(5*60+56,1);ones((22*60+44)-(5*60+56),1);zeros(1440-(22*60+44),1)];
Light28 = [zeros(9*60+19,1);ones((20*60+44)-(9*60+19),1);zeros(1440-(20*60+44),1)];
Light29 = [zeros(7*60+26,1);ones((19*60+12)-(7*60+26),1);zeros(1440-(19*60+12),1)];
Light30 = [zeros(7*60+35,1);ones((22*60+55)-(7*60+35),1);zeros(1440-(22*60+55),1)];
Light31 = [zeros(8*60+47,1);ones((20*60+45)-(8*60+47),1);zeros((21*60+2)-(20*60+45),1);...    
    ones(1440-(21*60+2),1)];
Light1 = [ones((20*60+45),1);zeros(1440-(20*60+45),1)];
Light2 = [zeros(17*60+9,1);ones((19*60+59)-(17*60+9),1);zeros(1440-(19*60+59),1)];
Light3 = [zeros(9*60+23,1);ones((22*60+11)-(9*60+23),1);zeros((22*60+14)-(22*60+11),1);...
    ones((22*60+28)-(22*60+14),1);zeros((1440)-(22*60+28),1)];

Light_mat = downsample(vertcat(Light24,Light25,Light26,Light27,Light28,...
    Light29,Light30,Light31,Light1,Light2,Light3),wind_size);

%%%Creating intermediate vector so we can remove all rows with errors in
%%%them, errors are denoted as a value 100 (arbitrarily chosen)
shift = -8*60;

inter_mini_mat = [utc_times circshift(flipud(pow_mats_mean),shift)...
    circshift(flipud(pow_mats_range),shift) circshift(flipud(pow_mats_peak),shift)...
    circshift(flipud(pf_mats_mean),shift) circshift(flipud(pf_mats_range),shift)...
    circshift(flipud(pf_mats_peak),shift) Light_mat mat_hrs occup_mat];

inter_mini_mat(end-8*60:end,:)=[];
inter_mini_mat(any(inter_mini_mat==100,2),:)=[];

utc_times = inter_mini_mat(:,1);
Light_mat = inter_mini_mat(:,128);
mat_hrs = inter_mini_mat(:,129);
occup_mat = inter_mini_mat(:,130:131);

%%%Splitting up matrices into real and reactive power matrices
pow_mats_mean = inter_mini_mat(:,2:22);
pow_mats_range = inter_mini_mat(:,23:43);
pow_mats_peak = inter_mini_mat(:,44:64);
pf_mats_mean = inter_mini_mat(:,65:85);
pf_mats_range = inter_mini_mat(:,86:106);
pf_mats_peak = inter_mini_mat(:,107:127);

% pf_mats_mean(pf_mats_mean<.01)=0;
% pf_mats_range(pf_mats_range<.01)=0;
% pf_mats_peak(pf_mats_peak<.01)=0;



%%%%%Gotta do everything for mean and range separately...doesnt make sense
%%%%%to do it this way



%%%Initialize apparent power and reactive power matrices
% app_mats_mean = zeros(size(real_mats_mean,1),size(real_mats_mean,2));
% app_mats_range = zeros(size(real_mats_range,1),size(real_mats_range,2));
% app_mats_peak = zeros(size(real_mats_peak,1),size(real_mats_peak,2));
% reac_mats_mean = zeros(size(real_mats_mean,1),size(real_mats_mean,2));
% reac_mats_range = zeros(size(real_mats_range,1),size(real_mats_range,2));
% reac_mats_peak = zeros(size(real_mats_peak,1),size(real_mats_peak,2));
% 
% app_mats_mean = real_mats_mean ./ pf_mats_mean;
% app_mats_range = real_mats_range ./ pf_mats_range;
% app_mats_peak = real_mats_peak ./ pf_mats_peak;
% reac_mats_mean = sqrt(app_mats_mean.^2 - real_mats_mean.^2);
% reac_mats_range = sqrt(app_mats_range.^2 - real_mats_range.^2);
% reac_mats_peak = sqrt(app_mats_peak.^2 - real_mats_peak.^2);
% 
% %%%Change all the NaN and Inf to 0's since 0/0 = NaN and 0.0000001/0 = Inf
% real_mats_mean(isnan(real_mats_mean))=0;
% real_mats_range(isnan(real_mats_range))=0;
% real_mats_peak(isnan(real_mats_peak))=0;
% real_mats_mean(real_mats_mean==Inf)=0;
% real_mats_range(real_mats_range==Inf)=0;
% real_mats_peak(real_mats_peak==Inf)=0;
% 
% reac_mats_mean(isnan(reac_mats_mean))=0;
% reac_mats_range(isnan(reac_mats_range))=0;
% reac_mats_peak(isnan(reac_mats_peak))=0;
% reac_mats_mean(reac_mats_mean==Inf)=0;
% reac_mats_range(reac_mats_range==Inf)=0;
% reac_mats_peak(reac_mats_peak==Inf)=0;

%%%Reducing the number of channels considered to see its effect
pow_mats_mean2 = pow_mats_mean;%(:,[1:2 4:6 13 15 18:19 21]);
pow_mats_range2 = pow_mats_range;%(:,[1:2 4:6 13 15 18:19 21]);
pow_mats_peak2 = pow_mats_peak;%(:,[1:2 4:6 13 15 18:19 21]);
pf_mats_mean2 = pf_mats_mean;%(:,[1:2 4:6 13 15 18:19 21]);
pf_mats_range2 = pf_mats_range;%(:,[1:2 4:6 13 15 18:19 21]);
pf_mats_peak2 = pf_mats_peak;%(:,[1:2 4:6 13 15 18:19 21]);


pow_mats_chans = [pow_mats_mean2 pow_mats_range2 pow_mats_peak2];
pf_mats_chans = [pf_mats_mean2 pf_mats_range2 pf_mats_peak2];

pow_mats_aggr = [sum(pow_mats_mean2,2) sum(pow_mats_range2,2) sum(pow_mats_peak2,2)];
pf_mats_aggr = [sum(pf_mats_mean2,2) sum(pf_mats_range2,2) sum(pf_mats_peak2,2)];
pow_aggr_prev1 = pow_mats_aggr - circshift(pow_mats_aggr,1);
pow_aggr_prev3 = pow_mats_aggr - circshift(pow_mats_aggr,3);
pf_aggr_prev1 = pf_mats_aggr - circshift(pf_mats_aggr,1);
pf_aggr_prev3 = pf_mats_aggr - circshift(pf_mats_aggr,3);

%%%Recombine to a big matrix 
csv_mat = [utc_times pow_mats_aggr pf_mats_aggr ...
    pow_aggr_prev1 pow_aggr_prev3 pf_aggr_prev1 ...
    pf_aggr_prev3 Light_mat mat_hrs occup_mat];

csv_mat(1:3,:)=[];

%csv_mat = [utc_times pow_mats_aggr pf_mats_aggr ...
%     Light_mat mat_hrs occup_mat];


filename = 'CSVmat_wo_Strip.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute Aggr_pow_mean Numeric', ...
    '@Attribute Aggr_pow_range Numeric','@Attribute Aggr_pow_peak Numeric',...
    '@Attribute Aggr_pf_mean Numeric','@Attribute Aggr_pf_range Numeric',...
    '@Attribute Aggr_pf_peak Numeric');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute Aggr_pow_mean_prev1 Numeric', ...
     '@Attribute Aggr_pow_range_prev1 Numeric','@Attribute Aggr_pow_peak_prev1 Numeric',...
     '@Attribute Aggr_pow_mean_prev3 Numeric','@Attribute Aggr_pow_range_prev3 Numeric',...
     '@Attribute Aggr_pow_peak_prev3 Numeric');
 fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute Aggr_pf_mean_prev1 Numeric', ...
     '@Attribute Aggr_pf_range_prev1 Numeric','@Attribute Aggr_pf_peak_prev1 Numeric',...
     '@Attribute Aggr_pf_mean_prev3 Numeric','@Attribute Aggr_pf_range_prev3 Numeric',...
     '@Attribute Aggr_pf_peak_prev3 Numeric');
fprintf(fid,'%s\n','@Attribute light Numeric');
fprintf(fid,'%s\n','@Attribute Hour Numeric');
fprintf(fid,'%s\n','@Attribute Range_Occupants {0,1,2,3,4}');
fprintf(fid,'%s\n\n','@Attribute Binary_Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');

[r,c] = size(csv_mat);

for i=1:r
    for j=2:c-4
        fprintf(fid,'%f,',csv_mat(i,j));
    end
    fprintf(fid,'%d,%d,%d,%d\n',csv_mat(i,j+1),csv_mat(i,j+2),csv_mat(i,j+3),csv_mat(i,j+4));
end

fclose(fid);


% close all;
% figure(1);
% hold on;
% plot(csv_mat(:,1),csv_mat(:,2));
% plot(csv_mat(:,1),csv_mat(:,end-1),'r.-'); 
% plot(csv_mat(:,1),csv_mat(:,5),'k');
% hold off;

%%%big_mat = [big_mat(:,1:end-1) big_mat(:,end)];

% filename = 'Occupancy_data.csv';
% fid = fopen(filename, 'w');
% [r,c] = size(csv_mat);
% 
% for i=1:r
%     fprintf(fid,'%d,',csv_mat(i,1));
%     for j=2:c-3
%         fprintf(fid,'%f,',csv_mat(i,j));
%     end
%     fprintf(fid,'%d,%d,%d\n,',csv_mat(i,j+1),csv_mat(i,j+2),csv_mat(i,j+3));
% end
% fclose(fid);

% close all;
% figure(1);
% hold on;
% plot(csv_mat(:,1),csv_mat(:,end-1),'r.-');
% plot(csv_mat(:,1),csv_mat(:,end-9),'b.-');
% %plot(csv_mat(:,1),csv_mat(:,end-5),'k.-');
% hold off;



