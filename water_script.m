clear all;

water_23 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-23T00_00_data-4.csv',',');
water_24 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-24T00_00_data-1.csv',',');
water_25 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-25T00_00_data.csv',',');
water_26 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-26T00_00_data.csv',',');
water_27 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-27T00_00_data.csv',',');
water_28 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-28T00_00_data.csv',',');
water_29 = extractHomeData('Various Sensors @ Home_house_water_flow_2013-07-29T00_00_data.csv',',');
app_pow23 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-23T00_00_data-1.csv',',');
app_pow24 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-24T00_00_data.csv',',');
app_pow25 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-25T00_00_data.csv',',');
app_pow26 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-26T00_00_data.csv',',');
app_pow27 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-27T00_00_data.csv',',');
app_pow28 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-28T00_00_data.csv',',');
app_pow29 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-29T00_00_data.csv',',');
real_pow23 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-23T00_00_data.csv',',');
real_pow24 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-24T00_00_data.csv',',');
real_pow25 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-25T00_00_data.csv',',');
real_pow26 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-26T00_00_data.csv',',');
real_pow27 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-27T00_00_data.csv',',');
real_pow28 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-28T00_00_data.csv',',');
real_pow29 = extractHomeData('eGauge and TED @ Home_RealPower_house_2013-07-29T00_00_data.csv',',');

wind_size = 1;
w23_m = windowMat(water_23,'mean',wind_size);
w23_m(w23_m==100)=[];
%ave_23 = mean(w23_m);
%w23_m = w23_m - ave_23;

w24_m = windowMat(water_24,'mean',wind_size);
w24_m(w24_m==100)=[];
%ave_24 = mean(w24_m);
%w24_m = w24_m - ave_24;

w25_m = windowMat(water_25,'mean',wind_size);
w25_m(w25_m==100)=[];
%ave_25 = mean(w25_m);
%w25_m = w25_m - ave_25;

w26_m = windowMat(water_26,'mean',wind_size);
w26_m(w26_m==100)=[];
%ave_26 = mean(w26_m);
%w26_m = w26_m - ave_26;

w27_m = windowMat(water_27,'mean',wind_size);
w27_m(w27_m==100)=[];
%ave_27 = mean(w27_m);
%w27_m = w27_m - ave_27;

w28_m = windowMat(water_28,'mean',wind_size);
w28_m(w28_m==100)=[];
%ave_28 = mean(w28_m);
%w28_m = w28_m - ave_28;

w29_m = windowMat(water_29,'mean',wind_size);
w29_m(w29_m==100)=[];
%ave_29 = mean(w29_m);
%w29_m = w29_m - ave_29;

a23_m = windowMat(app_pow23,'mean',wind_size);
a23_m(a23_m==100)=[];
%ave_23 = mean(a23_m);
%a23_m = a23_m - ave_23;

a24_m = windowMat(app_pow24,'mean',wind_size);
a24_m(a24_m==100)=[];
%ave_24 = mean(a24_m);
%a24_m = a24_m - ave_24;

a25_m = windowMat(app_pow25,'mean',wind_size);
a25_m(a25_m==100)=[];
%ave_25 = mean(a25_m);
%a25_m = a25_m - ave_25;

a26_m = windowMat(app_pow26,'mean',wind_size);
a26_m(a26_m==100)=[];
%ave_26 = mean(a26_m);
%a26_m = a26_m - ave_26;

a27_m = windowMat(app_pow27,'mean',wind_size);
a27_m(a27_m==100)=[];
%ave_27 = mean(a27_m);
%a27_m = a27_m - ave_27;

a28_m = windowMat(app_pow28,'mean',wind_size);
a28_m(a28_m==100)=[];
%ave_28 = mean(a28_m);
%a28_m = a28_m - ave_28;

a29_m = windowMat(app_pow29,'mean',wind_size);
a29_m(a29_m==100)=[];
%ave_29 = mean(a29_m);
%a29_m = a29_m - ave_29;

r23_m = windowMat(real_pow23,'mean',wind_size);
r23_m(r23_m==100)=[];
%ave_23 = mean(r23_m);
%r23_m = r23_m - ave_23;

r24_m = windowMat(real_pow24,'mean',wind_size);
r24_m(r24_m==100)=[];
%ave_24 = mean(r24_m);
%r24_m = r24_m - ave_24;

r25_m = windowMat(real_pow25,'mean',wind_size);
r25_m(r25_m==100)=[];
%ave_25 = mean(r25_m);
%r25_m = r25_m - ave_25;

r26_m = windowMat(real_pow26,'mean',wind_size);
r26_m(r26_m==100)=[];
%ave_26 = mean(r26_m);
%r26_m = r26_m - ave_26;

r27_m = windowMat(real_pow27,'mean',wind_size);
r27_m(r27_m==100)=[];
%ave_27 = mean(r27_m);
%r27_m = r27_m - ave_27;

r28_m = windowMat(real_pow28,'mean',wind_size);
r28_m(r28_m==100)=[];
%ave_28 = mean(r28_m);
%r28_m = r28_m - ave_28;

r29_m = windowMat(real_pow29,'mean',wind_size);
r29_m(r29_m==100)=[];
%ave_29 = mean(r29_m);
%r29_m = r29_m - ave_29;


w_m = vertcat(w23_m,w24_m,w25_m,w26_m,w27_m,w28_m,w29_m);
%w_m_prev1 = w_m - circshift(w_m,1);
%w_m_prev1440 = w_m - circshift(w_m,1440);
a_m = vertcat(a23_m,a24_m,a25_m,a26_m,a27_m,a28_m,a29_m);
%a_m_prev1 = a_m - circshift(a_m,1);
%a_m_prev1440 = a_m - circshift(a_m,1440);
r_m = vertcat(r23_m,r24_m,r25_m,r26_m,r27_m,r28_m,r29_m);
%r_m_prev1 = r_m - circshift(r_m,1);
%r_m_prev1440 = r_m - circshift(r_m,1440);


w_m(w_m>=0)=1;
a_m(a_m>=0)=1;
r_m(r_m>=0)=1;
w_m(w_m<0)=0;
a_m(a_m<0)=0;
r_m(r_m<0)=0;

savefile = 'homedata.mat';
save(savefile,'w_m','r_m','a_m');

occup_7_23 = processOccupCSV('7_23_home_gtruth.csv',1,'fine',[]);
occup_7_24 = processOccupCSV('7_24_home_gtruth.csv',1,'fine',[]);
occup_7_25 = processOccupCSV('7_25_home_gtruth.csv',1,'fine',[]);
occup_7_26 = processOccupCSV('7_26_home_gtruth.csv',1,'fine',[]);
occup_7_27 = processOccupCSV('7_27_home_gtruth.csv',1,'fine',[]);
occup_7_28 = processOccupCSV('7_28_home_gtruth.csv',1,'fine',[]);
occup_7_29 = processOccupCSV('7_29_home_gtruth.csv',1,'fine',[]);

occup_mat = vertcat(occup_7_23,occup_7_24,occup_7_25,occup_7_26, ...
    occup_7_27,occup_7_28,occup_7_29);

mat_hrs = windowMat(water_23,'hour',wind_size);
mat_hrs_fin = [mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs;mat_hrs];

csv_mat = [w_m a_m r_m w_m_prev1 w_m_prev1440 a_m_prev1 a_m_prev1440 r_m_prev1 r_m_prev1440 mat_hrs_fin occup_mat];
csv_mat(1:1441,:)=[];
csv_mat(any(csv_mat==100,2),:)=[];


csv_mat2 = csv_mat(1:1439,:);
csv_mat1 = csv_mat(1439:end,:);

filename = 'Home_data_training.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute water_mean Numeric', ...
    '@Attribute app_mean Numeric','@Attribute real_mean Numeric',...
    '@Attribute water_prev1 Numeric','@Attribute water_prev1440 Numeric',...
    '@Attribute app_prev1 Numeric');
fprintf(fid,['%s\n%s\n%s\n'],'@Attribute app_prev1440 Numeric', ...
     '@Attribute real_prev1 Numeric','@Attribute real_prev1440 Numeric');
fprintf(fid,'%s\n','@Attribute Hour {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}');
fprintf(fid,'%s\n\n','@Attribute Fine_Occupants {0,1,2,3,4}');
fprintf(fid,'%s\n','@DATA');

[r,c] = size(csv_mat1);

for i=1:r
    for j=1:c-2
        fprintf(fid,'%f,',csv_mat1(i,j));
    end
    fprintf(fid,'%d,%d\n',csv_mat1(i,j+1),csv_mat1(i,j+2));
end

fclose(fid);

filename = 'Home_data_testing.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,['%s\n%s\n%s\n%s\n%s\n%s\n'],'@Attribute water_mean Numeric', ...
    '@Attribute app_mean Numeric','@Attribute real_mean Numeric',...
    '@Attribute water_prev1 Numeric','@Attribute water_prev1440 Numeric',...
    '@Attribute app_prev1 Numeric');
fprintf(fid,['%s\n%s\n%s\n'],'@Attribute app_prev1440 Numeric', ...
     '@Attribute real_prev1 Numeric','@Attribute real_prev1440 Numeric');
fprintf(fid,'%s\n','@Attribute Hour {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}');
fprintf(fid,'%s\n\n','@Attribute Fine_Occupants {0,1,2,3,4}');
fprintf(fid,'%s\n','@DATA');

[r,c] = size(csv_mat2);

for i=1:r
    for j=1:c-2
        fprintf(fid,'%f,',csv_mat2(i,j));
    end
    fprintf(fid,'%d,%d\n',csv_mat2(i,j+1),csv_mat2(i,j+2));
end

fclose(fid);




