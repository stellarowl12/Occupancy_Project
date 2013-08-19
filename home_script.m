clear all;

% 
% app23 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-23T00_00_data.csv',',');
% app24 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-24T00_00_data.csv',',');
% app25 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-25T00_00_data.csv',',');
% app26 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-26T00_00_data.csv',',');
% app29 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-29T00_00_data.csv',',');
% app30 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-30T00_00_data.csv',','); 
% app31 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-07-31T00_00_data.csv',','); 
% app1 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-08-01T00_00_data.csv',','); 
% app2 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-08-02T00_00_data.csv',','); 
% app9 = extractHomeData('eGauge and TED @ Home_ApparentPower_house_2013-08-09T00_00_data.csv',','); 

load('App_power_23_9.mat');

wind_size = 1;
app23_mean = windowMat(app23,'mean',wind_size);
app24_mean = windowMat(app24,'mean',wind_size);
app25_mean = windowMat(app25,'mean',wind_size);
app26_mean = windowMat(app26,'mean',wind_size);
app29_mean = windowMat(app29,'mean',wind_size);
app30_mean = windowMat(app30,'mean',wind_size);
app31_mean = windowMat(app31,'mean',wind_size);
app1_mean = windowMat(app1,'mean',wind_size);
app2_mean = windowMat(app2,'mean',wind_size);
app9_mean = windowMat(app9,'mean',wind_size);

app23_prev = abs(app23_mean - circshift(app23_mean,1));
app24_prev = abs(app24_mean - circshift(app24_mean,1));
app25_prev = abs(app25_mean - circshift(app25_mean,1));
app26_prev = abs(app26_mean - circshift(app26_mean,1));
app29_prev = abs(app29_mean - circshift(app29_mean,1));
app30_prev = abs(app30_mean - circshift(app30_mean,1));
app31_prev = abs(app31_mean - circshift(app31_mean,1));
app1_prev = abs(app1_mean - circshift(app1_mean,1));
app2_prev = abs(app2_mean - circshift(app2_mean,1));
app9_prev = abs(app9_mean - circshift(app9_mean,1));

bin23 = [binVec(app23_mean,10) binVec(app23_prev,10)];
bin24 = [binVec(app24_mean,10) binVec(app24_prev,10)];
bin25 = [binVec(app25_mean,10) binVec(app25_prev,10)];
bin26 = [binVec(app26_mean,10) binVec(app26_prev,10)];
bin29 = [binVec(app29_mean,10) binVec(app29_prev,10)];
bin30 = [binVec(app30_mean,10) binVec(app30_prev,10)];
bin31 = [binVec(app31_mean,10) binVec(app31_prev,10)];
bin1 = [binVec(app1_mean,10) binVec(app1_prev,10)];
bin2 = [binVec(app2_mean,10) binVec(app2_prev,10)];
bin9 = [binVec(app9_mean,10) binVec(app9_prev,10)];

occup_7_23 = [processOccupCSV('7_23_home_gtruth.csv',1,'fine',[]) processOccupCSV('7_23_home_gtruth.csv',1,'binary',[])];

close all;
figure(1);
hold on;
plot(bin23(:,2));
plot(occup_7_23(:,1),'r');
hold off;

%save('Power_values.mat','bin23','bin24','bin25','bin26','bin29','bin30','bin31','bin1','bin2','bin9');


% new_power = zeros(length(app_mean),1);
% [num_inst,centers] = hist(app_mean,10);
% for i=1:length(app_mean)
%     dist2cent = [];
%     for j=1:length(centers)
%         dist2cent(j) = abs(app_mean(i)-centers(j));
%     end
%     [min_val,min_index] = min(dist2cent);
%     new_power(i)=min_index;
% end
