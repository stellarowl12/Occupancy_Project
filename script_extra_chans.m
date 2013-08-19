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
power_mats = extractCSVs('pow_2weeks*.csv',1);

days = unique(power_mats(:,3,:));

for i=1:length(days)
   pow_days(:,:,:,i) = power_mats( 
end

% fNorm = .017;                     %55Hz cutoff frequency, 6kHz sample rate
% [b,a] = butter(10, fNorm, 'low');          %generates some vectors, b and a, the filter needs, 
%                                            %which I don't care about, 10 being order, fnorm cutoff freq, lowpass
% filter_data = filtfilt(b, a, edata);             %filters my data  LVDT and creates array LVDT55 which
%                                            %has been filtered using a 10th order butterworth filter
% plot(filter_data);                                          
                                           
% light_mat = extractCSVs('light_*.csv',1);

% Y=medfilt1(edata,130);
% plot(Y);

diff_days_in_mat = unique(power_mats(:,3,1));
num_of_instances = [];

for i=1:length(diff_days_in_mat)
    count = sum(power_mats(:,3,1)==diff_days_in_mat(i));
    num_of_instances(i)=count;
end

to_delete = diff_days_in_mat(num_of_instances~=max(num_of_instances));

if ~(isempty(to_delete))
    for j=1:length(to_delete)
        for i=1:size(power_mats,3)
            power_mats_trim(:,:,i) = power_mats(power_mats(:,3,i)~=to_delete(j),:,i);
        end
    end
else
    power_mats_trim = power_mats;
end

% dim_3 = size(power_mats_trim,3);
% aggr_pow = sum(power_mats_trim,3);
% aggr_pow = [aggr_pow(:,1:6,:)./dim_3 medfilt1(aggr_pow(:,7,:),300)];
% aggr_pow = flipud(aggr_pow);

for i=1:size(power_mats_trim,3)
    pow_mats_mean(:,:,i) = windowMat(power_mats_trim(:,:,i),'mean',1);
    pow_mats_range(:,:,i) = windowMat(power_mats_trim(:,:,i),'range',1);
    pow_mats_peak(:,:,i) = windowMat(power_mats_trim(:,:,i),'peak',1);
end

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

close all;
data_mat = sum(power_mats_trim,3);
data = data_mat(:,7);

% [B,A] = butter(1,0.5);
% filt = filter(B,A,mean_wind);

% f=.5;%  sampling frequency
% f_cutoff = 1/(60*15); % cutoff frequency
% 
% fnorm =f_cutoff/(f/2); % normalized cut off freq, you can change it to any value depending on your requirements
% 
% [b1,a1] = butter(10,fnorm,'low'); % Low pass Butterworth filter of order 10
% low_data = filtfilt(b1,a1,data); % filtering
% 
% 
% freqz(b1,a1,128,f), title('low pass filter characteristics')
% figure
% subplot(2,1,1), plot(data), title('Actual data')
% subplot(2,1,2), plot(low_data), title('Filtered data')




occup_mat = processOccupCSV('3-22-13-gtruth.csv',1,'coarse',5);
m = pow_mats_mean; %+ (occup_mat.*2.128);
r = pow_mats_range;
p = pow_mats_peak; %+ (occup_mat.*2.128);


filename = 'powdata_3_22_fine.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
    '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute m1 Numeric', ...
    '@Attribute m2 Numeric','@Attribute m3 Numeric','@Attribute m4 Numeric', ...
    '@Attribute m5 Numeric','@Attribute m6 Numeric','@Attribute m7 Numeric', ... 
    '@Attribute m8 Numeric','@Attribute m9 Numeric','@Attribute m10 Numeric', ...
    '@Attribute m11 Numeric','@Attribute m12 Numeric','@Attribute m13 Numeric', ...
    '@Attribute m14 Numeric','@Attribute m15 Numeric','@Attribute m16 Numeric', ...
    '@Attribute m17 Numeric','@Attribute m18 Numeric','@Attribute m19 Numeric', ...
    '@Attribute m20 Numeric','@Attribute m21 Numeric');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
    '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute r1 Numeric', ...
    '@Attribute r2 Numeric','@Attribute r3 Numeric','@Attribute r4 Numeric', ...
    '@Attribute r5 Numeric','@Attribute r6 Numeric','@Attribute r7 Numeric', ... 
    '@Attribute r8 Numeric','@Attribute r9 Numeric','@Attribute r10 Numeric', ...
    '@Attribute r11 Numeric','@Attribute r12 Numeric','@Attribute r13 Numeric', ...
    '@Attribute r14 Numeric','@Attribute r15 Numeric','@Attribute r16 Numeric', ...
    '@Attribute r17 Numeric','@Attribute r18 Numeric','@Attribute r19 Numeric', ...
    '@Attribute r20 Numeric','@Attribute r21 Numeric');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n' ...
    '%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute p1 Numeric', ...
    '@Attribute p2 Numeric','@Attribute p3 Numeric','@Attribute p4 Numeric', ...
    '@Attribute p5 Numeric','@Attribute p6 Numeric','@Attribute p7 Numeric', ... 
    '@Attribute p8 Numeric','@Attribute p9 Numeric','@Attribute p10 Numeric', ...
    '@Attribute p11 Numeric','@Attribute p12 Numeric','@Attribute p13 Numeric', ...
    '@Attribute p14 Numeric','@Attribute p15 Numeric','@Attribute p16 Numeric', ...
    '@Attribute p17 Numeric','@Attribute p18 Numeric','@Attribute p19 Numeric', ...
    '@Attribute p20 Numeric','@Attribute p21 Numeric');
fprintf(fid,'%s\n\n','@Attribute Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');


for i=1:length(occup_mat)
    fprintf(fid,['%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,' ...
        '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,' ...
        '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,' ...
        '%f,%f,%f,%f,%f,%f,%f,%f,%f,%d\n'], ...
        m(i,1,1),m(i,1,2),m(i,1,3),m(i,1,4),m(i,1,5),m(i,1,6),m(i,1,7), ...
        m(i,1,8),m(i,1,9),m(i,1,10),m(i,1,11),m(i,1,12),m(i,1,13),m(i,1,14), ...
        m(i,1,15),m(i,1,16),m(i,1,17),m(i,1,18),m(i,1,19),m(i,1,20),m(i,1,21), ... 
        r(i,1,1),r(i,1,2),r(i,1,3),r(i,1,4),r(i,1,5),r(i,1,6),r(i,1,7), ...
        r(i,1,8),r(i,1,9),r(i,1,10),r(i,1,11),r(i,1,12),r(i,1,13),r(i,1,14), ...
        r(i,1,15),r(i,1,16),r(i,1,17),r(i,1,18),r(i,1,19),r(i,1,20),r(i,1,21), ... 
        p(i,1,1),p(i,1,2),p(i,1,3),p(i,1,4),p(i,1,5),p(i,1,6),p(i,1,7), ...
        p(i,1,8),p(i,1,9),p(i,1,10),p(i,1,11),p(i,1,12),p(i,1,13),p(i,1,14), ...
        p(i,1,15),p(i,1,16),p(i,1,17),p(i,1,18),p(i,1,19),p(i,1,20),p(i,1,21), ... 
        occup_mat(i));
end

fclose(fid);