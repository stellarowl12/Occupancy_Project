clear all;
power_mats = extractCSVs('pow_2weeks*.csv',1);
pf_mats = extractCSVs('pf_2weeks*.csv',1);
wind_size = 1;


%%have to flipud somehow

% for i=1:size(power_mats,3)
%    mean_day = mean(power_mats(:,7,i));
%    power_mats(:,7,i) = power_mats(:,7,i) - mean_day;
% end
% 
% for i=1:size(pf_mats,3)
%    mean_day = mean(pf_mats(:,7,i));
%    pf_mats(:,7,i) = pf_mats(:,7,i) - mean_day;
% end


for i=1:size(power_mats,3)
    pow_mats_mean(:,i) = windowMat(power_mats(:,:,i),'mean',wind_size,i);
    pow_mats_range(:,i) = windowMat(power_mats(:,:,i),'range',wind_size,i);
    pow_mats_peak(:,i) = windowMat(power_mats(:,:,i),'peak',wind_size,i);
end

mat_days = windowMat(power_mats(:,:,1),'day',wind_size,1);
mat_days = flipud(mat_days);
mat_hrs = windowMat(power_mats(:,:,1),'hour',wind_size,1);
mat_mins = windowMat(power_mats(:,:,1),'minute',wind_size,1);

for k=1:length(mat_days)
    if (mat_days(k) < 20)
        mat_mons(k)=6;
    else
        mat_mons(k)=5;
    end
end

for i=1:size(pf_mats,3)
    pf_mats_mean(:,i) = windowMat(pf_mats(:,:,i),'mean',wind_size,i);
    pf_mats_range(:,i) = windowMat(pf_mats(:,:,i),'range',wind_size,i);
    pf_mats_peak(:,i) = windowMat(pf_mats(:,:,i),'peak',wind_size,i);
end

real_mats_mean = pow_mats_mean;
real_mats_range = pow_mats_range;
real_mats_peak = pow_mats_peak;

app_mats_mean = zeros(size(real_mats_mean,1),size(real_mats_mean,2));
app_mats_range = zeros(size(real_mats_range,1),size(real_mats_range,2));
app_mats_peak = zeros(size(real_mats_peak,1),size(real_mats_peak,2));
reac_mats_mean = zeros(size(real_mats_mean,1),size(real_mats_mean,2));
reac_mats_range = zeros(size(real_mats_mean,1),size(real_mats_mean,2));
reac_mats_peak = zeros(size(real_mats_mean,1),size(real_mats_mean,2));

for i=1:size(app_mats_mean,1)
    for j=1:size(app_mats_mean,2)
        if real_mats_mean(i,j) && pf_mats_mean(i,j) ~= 100
            app_mats_mean(i,j) = real_mats_mean(i,j) ./ pf_mats_mean(i);
            app_mats_range(i,j) = real_mats_range(i,j) ./ pf_mats_range(i);
            app_mats_peak(i,j) = real_mats_peak(i,j) ./ pf_mats_peak(i);
        elseif real_mats_mean(i,j) || pf_mats_mean(i,j) == 0
            app_mats_mean(i,j) = 0;
            app_mats_range(i,j) = 0;
            app_mats_peak(i,j) = 0;
        elseif real_mats_mean(i,j) || pf_mats_mean(i,j) == 100
            app_mats_mean(i,j) = 100;
            app_mats_range(i,j) = 100;
            app_mats_peak(i,j) = 100;
        end
        reac_mats_mean(i,j) = sqrt(app_mats_mean(i,j).^2 - real_mats_mean(i,j).^2);
        reac_mats_range(i,j) = sqrt(app_mats_range(i,j).^2 - real_mats_range(i,j).^2);
        reac_mats_peak(i,j) = sqrt(app_mats_range(i,j).^2 - real_mats_range(i,j).^2);
    end 
end




real_mats_chans = [real_mats_mean real_mats_range real_mats_peak];
reac_mats_chans = [reac_mats_mean reac_mats_range reac_mats_peak];
% real_mats_chans(real_mats_chans==NaN)=0;
% reac_mats_chans(reac_mats_chans==NaN)=0;
% real_mats_chans(real_mats_chans==Inf)=0;
% reac_mats_chans(reac_mats_chans==Inf)=0;

real_mats_aggr = [sum(real_mats_mean,2) sum(real_mats_range,2) sum(real_mats_peak,2)];
reac_mats_aggr = [sum(reac_mats_mean,2) sum(reac_mats_range,2) sum(reac_mats_peak,2)];
% real_mats_aggr(real_mats_aggr==NaN)=0;
% reac_mats_aggr(reac_mats_aggr==NaN)=0;
% real_mats_aggr(real_mats_aggr==Inf)=0;
% reac_mats_aggr(reac_mats_aggr==Inf)=0;

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

%%%Light vectors
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

utc_times = zeros(length(mat_days),1);

for i=1:length(mat_days)
    disp(i)
    utc_times(i) = datetime_to_unix(2013,mat_mons(i),mat_days(i),mat_hrs(i),mat_mins(i));
end


%big_mat = [flipud(real_mats_chans) flipud(reac_mats_chans) flipud(real_mats_aggr)...
%    flipud(reac_mats_aggr) Light_mat mat_days mat_hrs mat_mins occup_mat];

csv_mat = [utc_times flipud(real_mats_chans) flipud(reac_mats_chans) flipud(real_mats_aggr)...
    flipud(reac_mats_aggr) Light_mat occup_mat];

csv_mat(any(csv_mat==100,2),:)=[];
%big_mat(any(big_mat==100,2),:)=[];

%%%big_mat = [big_mat(:,1:end-1) big_mat(:,end)];

filename = 'Occupancy_data.csv';
fid = fopen(filename, 'w');
[r,c] = size(csv_mat);

for i=1:r
    fprintf(fid,'%d,',csv_mat(i,1));
    for j=2:c-3
        fprintf(fid,'%f,',csv_mat(i,j));
    end
    fprintf(fid,'%d,%d,%d\n,',csv_mat(i,j+1),csv_mat(i,j+2),csv_mat(i,j+3));
end
fclose(fid);

% 
% filename = 'Real_and_Reac_v2.arff';
% fid = fopen(filename, 'w');
% fprintf(fid,'%s\n\n','@RELATION Occupancy');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
%     '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute m1 Numeric', ...
%     '@Attribute m2 Numeric','@Attribute m3 Numeric','@Attribute m4 Numeric', ...
%     '@Attribute m5 Numeric','@Attribute m6 Numeric','@Attribute m7 Numeric', ... 
%     '@Attribute m8 Numeric','@Attribute m9 Numeric','@Attribute m10 Numeric', ...
%     '@Attribute m11 Numeric','@Attribute m12 Numeric','@Attribute m13 Numeric', ...
%     '@Attribute m14 Numeric','@Attribute m15 Numeric','@Attribute m16 Numeric', ...
%     '@Attribute m17 Numeric','@Attribute m18 Numeric','@Attribute m19 Numeric', ...
%     '@Attribute m20 Numeric','@Attribute m21 Numeric');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
%     '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute r1 Numeric', ...
%     '@Attribute r2 Numeric','@Attribute r3 Numeric','@Attribute r4 Numeric', ...
%     '@Attribute r5 Numeric','@Attribute r6 Numeric','@Attribute r7 Numeric', ... 
%     '@Attribute r8 Numeric','@Attribute r9 Numeric','@Attribute r10 Numeric', ...
%     '@Attribute r11 Numeric','@Attribute r12 Numeric','@Attribute r13 Numeric', ...
%     '@Attribute r14 Numeric','@Attribute r15 Numeric','@Attribute r16 Numeric', ...
%     '@Attribute r17 Numeric','@Attribute r18 Numeric','@Attribute r19 Numeric', ...
%     '@Attribute r20 Numeric','@Attribute r21 Numeric');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
%     '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute p1 Numeric', ...
%     '@Attribute p2 Numeric','@Attribute p3 Numeric','@Attribute p4 Numeric', ...
%     '@Attribute p5 Numeric','@Attribute p6 Numeric','@Attribute p7 Numeric', ... 
%     '@Attribute p8 Numeric','@Attribute p9 Numeric','@Attribute p10 Numeric', ...
%     '@Attribute p11 Numeric','@Attribute p12 Numeric','@Attribute p13 Numeric', ...
%     '@Attribute p14 Numeric','@Attribute p15 Numeric','@Attribute p16 Numeric', ...
%     '@Attribute p17 Numeric','@Attribute p18 Numeric','@Attribute p19 Numeric', ...
%     '@Attribute p20 Numeric','@Attribute p21 Numeric');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
%     '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute pfm1 Numeric', ...
%     '@Attribute pfm2 Numeric','@Attribute pfm3 Numeric','@Attribute pfm4 Numeric', ...
%     '@Attribute pfm5 Numeric','@Attribute pfm6 Numeric','@Attribute pfm7 Numeric', ... 
%     '@Attribute pfm8 Numeric','@Attribute pfm9 Numeric','@Attribute pfm10 Numeric', ...
%     '@Attribute pfm11 Numeric','@Attribute pfm12 Numeric','@Attribute pfm13 Numeric', ...
%     '@Attribute pfm14 Numeric','@Attribute pfm15 Numeric','@Attribute pfm16 Numeric', ...
%     '@Attribute pfm17 Numeric','@Attribute pfm18 Numeric','@Attribute pfm19 Numeric', ...
%     '@Attribute pfm20 Numeric','@Attribute pfm21 Numeric');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
%     '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute pfr1 Numeric', ...
%     '@Attribute pfr2 Numeric','@Attribute pfr3 Numeric','@Attribute pfr4 Numeric', ...
%     '@Attribute pfr5 Numeric','@Attribute pfr6 Numeric','@Attribute pfr7 Numeric', ... 
%     '@Attribute pfr8 Numeric','@Attribute pfr9 Numeric','@Attribute pfr10 Numeric', ...
%     '@Attribute pfr11 Numeric','@Attribute pfr12 Numeric','@Attribute pfr13 Numeric', ...
%     '@Attribute pfr14 Numeric','@Attribute pfr15 Numeric','@Attribute pfr16 Numeric', ...
%     '@Attribute pfr17 Numeric','@Attribute pfr18 Numeric','@Attribute pfr19 Numeric', ...
%     '@Attribute pfr20 Numeric','@Attribute pfr21 Numeric');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
%     '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute pfp1 Numeric', ...
%     '@Attribute pfp2 Numeric','@Attribute pfp3 Numeric','@Attribute pfp4 Numeric', ...
%     '@Attribute pfp5 Numeric','@Attribute pfp6 Numeric','@Attribute pfp7 Numeric', ... 
%     '@Attribute pfp8 Numeric','@Attribute pfp9 Numeric','@Attribute pfp10 Numeric', ...
%     '@Attribute pfp11 Numeric','@Attribute pfp12 Numeric','@Attribute pfp13 Numeric', ...
%     '@Attribute pfp14 Numeric','@Attribute pfp15 Numeric','@Attribute pfp16 Numeric', ...
%     '@Attribute pfp17 Numeric','@Attribute pfp18 Numeric','@Attribute pfp19 Numeric', ...
%     '@Attribute pfp20 Numeric','@Attribute pfp21 Numeric');
% fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute Aggr_real_mean Numeric', ...
%     '@Attribute Aggr_real_range Numeric','@Attribute Aggr_real_peak Numeric',...
%     '@Attribute Aggr_reac_mean Numeric','@Attribute Aggr_reac_range Numeric',...
%     '@Attribute Aggr_reac_peak Numeric');
% fprintf(fid,'%s\n','@Attribute light Numeric');
% % fprintf(fid,'%s\n','@Attribute Day Numeric');
% % fprintf(fid,'%s\n','@Attribute Hour Numeric');
% % fprintf(fid,'%s\n','@Attribute Minute Numeric');
% fprintf(fid,'%s\n\n','@Attribute Occupants {0,1,2,3,4}');
% fprintf(fid,'%s\n\n','@Attribute Occupants {0,1}');
% fprintf(fid,'%s\n','@DATA');
% 
% [r,c] = size(big_mat);
% 
% for i=1:r
%     for j=1:c-2
%         fprintf(fid,'%f,',big_mat(i,j));
%     end
%     fprintf(fid,'%d\n',big_mat(i,j+1));
% end
% 
% for i=1:r
%     for j=1:c
%         fprintf(fid,'%f,',big_mat(i,j));
%     end
% end
% 
% 
% fclose(fid);
