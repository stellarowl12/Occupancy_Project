clear all;
power_mats = extractCSVs('pow_2weeks*.csv',1);

for i=1:size(power_mats,3)
   mean_day = mean(power_mats(:,7,i));
   power_mats(:,7,i) = power_mats(:,7,i) - mean_day;
end

days_mat = extractDays(power_mats);

%%% Remove June 1-3
days_trim = days_mat;

%%% Adding filler vectors for extra features
[x y z] = size(days_trim);
fill_vec = zeros(1440,6,z);
days_trim2 = [days_trim fill_vec];

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

Light_mat = cat(3,Light1,Light2,Light3,Light24,Light25,Light26,Light27,Light28,...
    Light29,Light30,Light31);


%%%Features that are exactly the same as the minute before a current
%%%time window.
for i=1:z
    for j=7:9
        shifted_vec = circshift(days_trim2(:,j-3,i),1);
        if i==1
            shifted_vec(1) = days_trim2(1,j-3,i);
        else
            shifted_vec(1) = days_trim2(end,j-3,i-1);
        end
        days_trim2(:,j,i) = shifted_vec; 
    end
end

%%%New features that are the exact same as the time slot 
%%%in the previous day.

for i=1:z
    for j=10:12
        if i==1
            days_trim2(:,j,i) = days_trim2(:,j-6,i); 
        else
            days_trim2(:,j,i) = days_trim2(:,j-6,i-1); 
        end
    end
end

occup524 = [processOccupCSV('5_24_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_24_gtruth.csv',1,'binary',5)];
occup525 = [processOccupCSV('5_25_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_25_gtruth.csv',1,'binary',5)];
occup526 = [processOccupCSV('5_26_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_26_gtruth.csv',1,'binary',5)];
occup527 = [processOccupCSV('5_27_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_27_gtruth.csv',1,'binary',5)];
occup528 = [processOccupCSV('5_28_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_28_gtruth.csv',1,'binary',5)];
occup529 = [processOccupCSV('5_29_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_29_gtruth.csv',1,'binary',5)];
occup530 = [processOccupCSV('5_30_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_30_gtruth.csv',1,'binary',5)];
occup531 = [processOccupCSV('5_31_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('5_31_gtruth.csv',1,'binary',5)];
occup61 = [processOccupCSV('6_1_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('6_1_gtruth.csv',1,'binary',5)];
occup62 = [processOccupCSV('6_2_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('6_2_gtruth.csv',1,'binary',5)];
occup63 = [processOccupCSV('6_3_gtruth.csv',1,'coarse',[0,1,2,4,8]) processOccupCSV('6_3_gtruth.csv',1,'binary',5)];

occup_mat = cat(3,occup61,occup62,occup63,occup524,occup525,occup526,occup527,occup528,...
    occup529,occup530,occup531);

days_3d_final = [days_trim2 Light_mat occup_mat];
train_days = [];
test_days = [];


for i=1:size(days_3d_final,3)
    if (days_3d_final(1,1,i) == 27 || days_3d_final(1,1,i) == 28 || days_3d_final(1,1,i) == 29)
        train_days = [train_days; days_3d_final(:,:,i)];
    elseif (days_3d_final(1,1,i) == 31)
        test_days = [test_days; days_3d_final(:,:,i)];
    end
end

for i=1:size(days_3d_final,3)
    if (days_3d_final(1,1,i) == 1)
        test_days = [test_days; days_3d_final(:,:,i)];
    elseif (days_3d_final(1,1,i) == 2)
        test_days = [test_days; days_3d_final(:,:,i)];
    elseif (days_3d_final(1,1,i) == 3)
        test_days = [test_days; days_3d_final(:,:,i)];
    end
end

train_days(any(train_days==100,2),:)=[];
test_days(any(test_days==100,2),:)=[];


filename = 'Train_Days.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,'%s\n','@Attribute Time_of_Day Numeric');
fprintf(fid,'%s\n','@Attribute m_kW Numeric');
fprintf(fid,'%s\n','@Attribute p_kW Numeric');
fprintf(fid,'%s\n','@Attribute r_kW Numeric');
fprintf(fid,'%s\n','@Attribute m_prev_min Numeric');
fprintf(fid,'%s\n','@Attribute p_prev_min Numeric');
fprintf(fid,'%s\n','@Attribute r_prev_min Numeric');
fprintf(fid,'%s\n','@Attribute m_prev_day Numeric');
fprintf(fid,'%s\n','@Attribute p_prev_day Numeric');
fprintf(fid,'%s\n','@Attribute r_prev_day Numeric');
fprintf(fid,'%s\n','@Attribute light Numeric');
fprintf(fid,'%s\n\n','@Attribute Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');

for i=1:length(train_days)
    fprintf(fid,'%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%d,%d\n',train_days(i,2), ...
        train_days(i,4),train_days(i,5),train_days(i,6),...
        train_days(i,7),train_days(i,8),train_days(i,9),...
        train_days(i,10),train_days(i,11),train_days(i,12),...
        train_days(i,13),train_days(i,15));
end

fclose(fid);

filename = 'Test_Days.arff';
fid = fopen(filename, 'w');
fprintf(fid,'%s\n\n','@RELATION Occupancy');
fprintf(fid,'%s\n','@Attribute Time_of_Day Numeric');
fprintf(fid,'%s\n','@Attribute m_kW Numeric');
fprintf(fid,'%s\n','@Attribute p_kW Numeric');
fprintf(fid,'%s\n','@Attribute r_kW Numeric');
fprintf(fid,'%s\n','@Attribute m_prev_min Numeric');
fprintf(fid,'%s\n','@Attribute p_prev_min Numeric');
fprintf(fid,'%s\n','@Attribute r_prev_min Numeric');
fprintf(fid,'%s\n','@Attribute m_prev_day Numeric');
fprintf(fid,'%s\n','@Attribute p_prev_day Numeric');
fprintf(fid,'%s\n','@Attribute r_prev_day Numeric');
fprintf(fid,'%s\n','@Attribute light Numeric');
fprintf(fid,'%s\n\n','@Attribute Occupants {0,1}');
fprintf(fid,'%s\n','@DATA');

for i=1:length(test_days)
    fprintf(fid,'%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%d,%d\n',test_days(i,2), ...
        test_days(i,4),test_days(i,5),test_days(i,6),...
        test_days(i,7),test_days(i,8),test_days(i,9),...
        test_days(i,10),test_days(i,11),test_days(i,12),...
        test_days(i,13),test_days(i,15));
end

fclose(fid);