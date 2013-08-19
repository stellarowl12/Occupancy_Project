occup_5_24 = csvread('5_24_gtruth.csv');
occup_5_25 = csvread('5_25_gtruth.csv');
occup_5_26 = csvread('5_26_gtruth.csv');
occup_5_27 = csvread('5_27_gtruth.csv');
occup_5_28 = csvread('5_28_gtruth.csv');
occup_5_29 = csvread('5_29_gtruth.csv');
occup_5_30 = csvread('5_30_gtruth.csv');
occup_5_31 = csvread('5_31_gtruth.csv');
occup_6_1 = csvread('6_1_gtruth.csv');
occup_6_2 = csvread('6_2_gtruth.csv');
occup_6_3 = csvread('6_3_gtruth.csv');

num_changes = size(occup_6_2,1);
ppl_counts = [];
%seconds_count = zeros(length(num_changes),1);

% for i=1:num_changes
%     row = occup_6_2(i,:);
%     num_ppl = row(7);
%     sec = row(3)*60*60+row(4)*60+row(5)+1;
%     if i == num_changes
%         next_sec = 23*60*60+59*60+59+1; 
%     else
%         next_row = occup_6_2(i+1,:);
%         next_sec = next_row(3)*60*60+next_row(4)*60+next_row(5)+1;
%     end
%     seg_leng = next_sec-sec;
%     ppl_counts = [ppl_counts; ones(seg_leng,1)*num_ppl];
% end

count_24 = countPplPerSec(occup_5_24);
%count_26 = countPplPerSec(occup_5_26);
count_27 = countPplPerSec(occup_5_27);
count_28 = countPplPerSec(occup_5_28);
count_29 = countPplPerSec(occup_5_29);
count_31 = countPplPerSec(occup_5_31);
count_1 = countPplPerSec(occup_6_1);
%count_2 = countPplPerSec(occup_6_2);
count_3 = countPplPerSec(occup_6_3);

total_counts_sec = [count_24; count_27; count_28; count_29; count_31; count_1; count_3];

num_bins = unique(total_counts_sec);
hist(total_counts_sec,num_bins);
title('Histogram for number of seconds that corresponds to a certain occupancy level');
xlabel('Occupancy level');
ylabel('total number of seconds');




occup_mat(:,:,1) = occup_5_24;
occup_mat(:,:,2) = occup_5_25;
occup_mat(:,:,3) = occup_5_26;
occup_mat(:,:,4) = occup_5_27;
occup_mat(:,:,5) = occup_5_28;
occup_mat(:,:,6) = occup_5_29;
occup_mat(:,:,7) = occup_5_30;
occup_mat(:,:,8) = occup_5_31;
occup_mat(:,:,9) = occup_6_1;
occup_mat(:,:,10) = occup_6_2;
occup_mat(:,:,11) = occup_6_3;