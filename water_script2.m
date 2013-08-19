clear all;

% water_23 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-23T00_00_data-4.csv',',');
% water_24 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-24T00_00_data-1.csv',',');
% water_25 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-25T00_00_data.csv',',');
% water_26 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-26T00_00_data.csv',',');
% water_27 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-27T00_00_data.csv',',');
% water_28 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-28T00_00_data.csv',',');
% water_29 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-29T00_00_data.csv',',');
% app23 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-23T00_00_data-1.csv',',');
% app24 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-24T00_00_data.csv',',');
% app25 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-25T00_00_data.csv',',');
% app26 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-26T00_00_data.csv',',');
% app27 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-27T00_00_data.csv',',');
% app28 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-28T00_00_data.csv',',');
% app29 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-29T00_00_data.csv',',');
% real23 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-23T00_00_data.csv',',');
% real24 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-24T00_00_data.csv',',');
% real25 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-25T00_00_data.csv',',');
% real26 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-26T00_00_data.csv',',');
% real27 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-27T00_00_data.csv',',');
% real28 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-28T00_00_data.csv',',');
% real29 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-29T00_00_data.csv',',');

load july23thrujuly31.mat;
load motion.mat;

% water_30 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-30T00_00_data.csv',',');
% water_31 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-31T00_00_data.csv',',');
% app30 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-30T00_00_data.csv',',');
% app31 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-31T00_00_data.csv',',');
% real30 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-30T00_00_data.csv',',');
% real31 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-31T00_00_data.csv',',');


water_23(:,7) = water_23(:,7) - mean(water_23(:,7));
water_24(:,7) = water_24(:,7) - mean(water_24(:,7));
water_25(:,7) = water_25(:,7) - mean(water_25(:,7));
water_26(:,7) = water_26(:,7) - mean(water_26(:,7));
water_27(:,7) = water_27(:,7) - mean(water_27(:,7));
water_28(:,7) = water_28(:,7) - mean(water_28(:,7));
water_29(:,7) = water_29(:,7) - mean(water_29(:,7));
water_30(:,7) = water_30(:,7) - mean(water_30(:,7));
water_31(:,7) = water_31(:,7) - mean(water_31(:,7));
app23(:,7) = app23(:,7) - mean(app23(:,7));
app24(:,7) = app24(:,7) - mean(app24(:,7));
app25(:,7) = app25(:,7) - mean(app25(:,7));
app26(:,7) = app26(:,7) - mean(app26(:,7));
app27(:,7) = app27(:,7) - mean(app27(:,7));
app28(:,7) = app28(:,7) - mean(app28(:,7));
app29(:,7) = app29(:,7) - mean(app29(:,7));
app30(:,7) = app30(:,7) - mean(app30(:,7));
app31(:,7) = app31(:,7) - mean(app31(:,7));
real23(:,7) = real23(:,7) - mean(real23(:,7));
real24(:,7) = real24(:,7) - mean(real24(:,7));
real25(:,7) = real25(:,7) - mean(real25(:,7));
real26(:,7) = real26(:,7) - mean(real26(:,7));
real27(:,7) = real27(:,7) - mean(real27(:,7));
real28(:,7) = real28(:,7) - mean(real28(:,7));
real29(:,7) = real29(:,7) - mean(real29(:,7));
real30(:,7) = real30(:,7) - mean(real30(:,7));
real31(:,7) = real31(:,7) - mean(real31(:,7));

wind_size = 1;
water = [water_23;water_24;water_25;water_26;water_27;water_28;water_29;water_30;water_31];
%water = circshift(water,-8*60);
water_mean = windowMat(water,'mean',wind_size);
water_peak = windowMat(water,'peak',wind_size);
water_prev1 = abs(water_mean - circshift(water_mean,1));
app_pow = [app23;app24;app25;app26;app27;app28;app29;app30;app31];
%app_pow = circshift(app_pow,-8*60);
app_mean = windowMat(app_pow,'mean',wind_size);
app_peak = windowMat(app_pow,'peak',wind_size);
app_prev1 = abs(app_mean - circshift(app_mean,1));
real_pow = [real23;real24;real25;real26;real27;real28;real29;real30;real31];
%real_pow = circshift(real_pow,-8*60);
real_mean = windowMat(real_pow,'mean',wind_size);
real_peak = windowMat(real_pow,'peak',wind_size);
real_prev1 = abs(real_mean - circshift(real_mean,1));



% new_power = zeros(length(app_mean),1);
% [num_inst,centers] = hist(app_mean,8);
% for i=1:length(app_mean)
%     dist2cent = [];
%     for j=1:length(centers)
%         dist2cent(j) = abs(app_mean(i)-centers(j));
%     end
%     [min_val,min_index] = min(dist2cent);
%     new_power(i)=min_index;
% end


occup_7_23 = [processOccupCSV('7_23_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_23_home_gtruth.csv',1,'binary',[])];
occup_7_24 = [processOccupCSV('7_24_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_24_home_gtruth.csv',1,'binary',[])];
occup_7_25 = [processOccupCSV('7_25_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_25_home_gtruth.csv',1,'binary',[])];
occup_7_26 = [processOccupCSV('7_26_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_26_home_gtruth.csv',1,'binary',[])];
occup_7_27 = [processOccupCSV('7_27_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_27_home_gtruth.csv',1,'binary',[])];
occup_7_28 = [processOccupCSV('7_28_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_28_home_gtruth.csv',1,'binary',[])];
occup_7_29 = [processOccupCSV('7_29_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_29_home_gtruth.csv',1,'binary',[])];
occup_7_30 = [processOccupCSV('7_30_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_30_home_gtruth.csv',1,'binary',[])];
occup_7_31 = [processOccupCSV('7_31_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_31_home_gtruth.csv',1,'binary',[])];

occup_mat = vertcat(occup_7_23,occup_7_24,occup_7_25,occup_7_26, ...
    occup_7_27,occup_7_28,occup_7_29,occup_7_30,occup_7_31);

mat_hrs = windowMat(water_23,'hour',wind_size);
mat_hrs_fin = [mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs];

csv_mat = [water_mean water_peak water_prev1 app_mean app_peak app_prev1...
    real_mean real_peak real_prev1 mat_hrs_fin motion occup_mat];

csv_mat(any(csv_mat==100,2),:)=[];

% close all;
% figure(2);
% hold on;
% %plot(csv_mat(:,1),'k');
% plot(csv_mat(:,end)*500+1000,'r');
% %plot(csv_mat(:,7),'b');
% plot(circshift(csv_mat(:,8),8*60),'k');
% hold off;


% 
% csv_mat1 = csv_mat([1:1440*1 1440*2+1:end],:);
% csv_mat2 = csv_mat((1440*1+1):(1440*2),:);



csv_mat1 = csv_mat(1:end-1440,:);
csv_mat2 = csv_mat(end-1440:end,:);
% 
% (sum(csv_mat2([1:(7*60) (20*60):end],12)==0)*3+sum(csv_mat2([1:(7*60) (20*60):end],12)==1)*2+sum(csv_mat2([1:(7*60) (20*60):end],12)==2)*1 ...
% +sum(csv_mat2(8*60:20*60,12)==1)*1+sum(csv_mat2(8*60:20*60,12)==2)*2+sum(csv_mat2(8*60:20*60,12)==3)*2)/1440

%(sum(csv_mat2(:,12)==0)*3+sum(csv_mat2(:,12)==1)*2+sum(csv_mat2(:,12)==2)*1)/1440

filename = 'Home_data_training_31v2.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute water_mean Numeric', ...
    '@Attribute water_peak Numeric','@Attribute water_prev1 Numeric',...
    '@Attribute app_mean Numeric','@Attribute app_peak Numeric',...
    '@Attribute app_prev1 Numeric');
fprintf(fid,['%s\n%s\n%s\n'],'@Attribute real_mean Numeric', ...
     '@Attribute real_peak Numeric','@Attribute real_prev1 Numeric');
fprintf(fid,'%s\n','@Attribute Hour Numeric'); %{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}');
fprintf(fid,'%s\n','@Attribute Motion Numeric');
fprintf(fid,'%s\n','@Attribute Fine_Occupants {0,1,2,3}');
fprintf(fid,'%s\n\n','@Attribute Binary_Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');

[r,c] = size(csv_mat1);

for i=1:r
    for j=1:c-4
        fprintf(fid,'%f,',csv_mat1(i,j));
    end
    fprintf(fid,'%d,%d,%d,%d\n',csv_mat1(i,j+1),csv_mat1(i,j+2),csv_mat1(i,j+3),csv_mat1(i,j+4));
end

fclose(fid);

filename = 'Home_data_testing_31v2.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute water_mean Numeric', ...
    '@Attribute water_peak Numeric','@Attribute water_prev1 Numeric',...
    '@Attribute app_mean Numeric','@Attribute app_peak Numeric',...
    '@Attribute app_prev1 Numeric');
fprintf(fid,['%s\n%s\n%s\n'],'@Attribute real_mean Numeric', ...
     '@Attribute real_peak Numeric','@Attribute real_prev1 Numeric');
fprintf(fid,'%s\n','@Attribute Hour Numeric'); %{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}');
fprintf(fid,'%s\n','@Attribute Motion Numeric');
fprintf(fid,'%s\n','@Attribute Fine_Occupants {0,1,2,3}');
fprintf(fid,'%s\n\n','@Attribute Binary_Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');

[r,c] = size(csv_mat2);

for i=1:r
    for j=1:c-4
        fprintf(fid,'%f,',csv_mat2(i,j));
    end
    fprintf(fid,'%d,%d,%d,%d\n',csv_mat2(i,j+1),csv_mat2(i,j+2),csv_mat2(i,j+3),csv_mat2(i,j+4));
end

fclose(fid);




