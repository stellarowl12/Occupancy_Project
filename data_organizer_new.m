%%
clear all;
names = getfilenames('.','*.csv');

for i=1:length(names)
    M(:,:,i)=csvread(names{i});
end
%%
sum_M = sum(M,3);
fixed_M = sum_M(:,1:6).*(1/length(names));
final_M = [fixed_M sum_M(:,7)];
final_M = flipud(final_M);
%%
mean_wind = zeros(1,1380);
peak_wind = zeros(1,1380);
range_wind = zeros(1,1380);
time_of_day{1,1380}=[];
%%  Door1 events processing
door1_mat = csvread('out_Door_3_22_1.csv');
door1_mat_all = flipud(door1_mat);
rm_zero_hr = door1_mat_all(:,4) > 0;
door1_truncated = door1_mat_all(logical(rm_zero_hr),:);
door1_times = zeros(1,length(door1_truncated));
for i=1:length(door1_truncated)
    door1_times(i)=(door1_truncated(i,4)-1)*60+door1_truncated(i,5);
end
door1_times = door1_times';
door1_times = unique(door1_times);
%%Door2 events processing
door2_mat = csvread('out_Door_3_22_2.csv');
door2_mat_all = flipud(door2_mat);
rm_zero_hr = door2_mat_all(:,4) > 0;
door2_truncated = door2_mat_all(logical(rm_zero_hr),:);
door2_times = zeros(1,length(door2_truncated));
for i=1:length(door2_truncated)
    door2_times(i)=(door2_truncated(i,4)-1)*60+door2_truncated(i,5);
end
door2_times = door2_times';
door2_times = unique(door2_times);
%%Combining Door1 and Door2

door_times = [door1_times;door2_times];
door_times = sort(door_times);
door_times_full = zeros(1,1380);
for j=1:1380
    if any(door_times == j)
        door_times_full(j) = 2.4;
    else
        door_times_full(j) = 1.5;
    end
end

figure(1);
hold on;
plot(mean_wind);
plot(door_times_full,'r');
hold off;
xlabel('Minutes');
ylabel('kilowatts and door events');
title('Superimposed, power and door');


%%
for i=1:23
    val_hour = final_M(:,4) == i;
    M_hour = final_M(logical(val_hour),:);
    
    for j=1:60
        val_min = M_hour(:,5) == (j-1); %%%%Because minutes start at 0 end at 59
        M_minute = M_hour(logical(val_min),:);
        
        if ~isempty(M_minute)
            power_vals = M_minute(:,7);
            mean_power = mean(power_vals);
            peak_power = max(power_vals);
            range_power = range(power_vals);
            mean_wind(((i-1)*60)+j) = mean_power;
            peak_wind(((i-1)*60)+j) = peak_power;
            range_wind(((i-1)*60)+j) = range_power;
        else
            mean_wind(((i-1)*60)+j) = mean_wind(((i-1)*60)+j-1);
            peak_wind(((i-1)*60)+j) = peak_wind(((i-1)*60)+j-1);
            range_wind(((i-1)*60)+j) = range_wind(((i-1)*60)+j-1);
        end
    end
end
%%% Filtering out periodic, non-occupancy related energy changes
[B,A] = butter(1,[0.0001,0.01],'stop');
filt = filter(B,A,mean_wind);


%%%
for i=1:23
    for j=1:60
        if i >= 1 && i < 5
            time_of_day{(i-1)*60+j} = 'late_night';
        elseif i >= 5 && i < 12
            time_of_day{(i-1)*60+j} = 'morning';
        elseif i >= 12 && i < 18
            time_of_day{(i-1)*60+j} = 'afternoon';
        elseif i >= 18 && i <24
            time_of_day{(i-1)*60+j} = 'evening';
        end
    end
end
%%
for i=1:23
    for k=1:60
        val_min_light = Light_hour(:,5) == (k-1);
        Light_minute = Light_hour(logical(val_min_light),:);
        light_vals = Light_minute(:,7);
        ave_light = mean(light_vals);
        if ave_light>5
            light_onoff((i-1)*60+k) = 1;
        elseif ave_light<5
            light_onoff((i-1)*60+k) = 0;
        else
            light_onoff((i-1)*60+k) = light_onoff((i-1)*60+k-1);
        end
    end
end
%%

Light_info = csvread('out_light.csv');
light_onoff = zeros(1,1380);

for i=1:23
    val_hour_light = Light_info(:,4) == i;
    Light_hour = Light_info(logical(val_hour_light),:);
    
    for k=1:60
        val_min_light = Light_hour(:,5) == (k-1);
        Light_minute = Light_hour(logical(val_min_light),:);
        light_vals = Light_minute(:,7);
        ave_light = mean(light_vals);
        if ave_light>5
            light_onoff((i-1)*60+k) = 1;
        elseif ave_light<5
            light_onoff((i-1)*60+k) = 0;
        else
            light_onoff((i-1)*60+k) = light_onoff((i-1)*60+k-1);
        end
    end
end
%%
Occup_times = csvread('3-22-13-gtruth.csv');
Occup_ranges_fine = zeros(1,1380);
Occup_ranges_coarse = zeros(1,1380);

for i=1:23
    val = Occup_times(:,2) == i;
    Occup_hour = Occup_times(logical(val),:);
    [a,b] = size(Occup_hour);

    if a == 0
        for z=1:60
            Occup_ranges_fine((i-1)*60+z) = 0;
        end
    else
        Occup_min = Occup_hour(:,3);
        Occup_cnt = Occup_hour(:,1);
        x = 1;
        for z=1:(Occup_min(x)-1)
            Occup_ranges_fine((i-1)*60+z) = Occup_ranges_fine((i-1)*60+z-1);
        end
        
        while x<=size(Occup_hour,1)
            if x ~= size(Occup_hour,1)
                for z=Occup_min(x):(Occup_min(x+1)-1)
                    Occup_ranges_fine((i-1)*60+z) = Occup_cnt(x);
                end
                x = x+1;
            elseif x == size(Occup_hour,1)
                for z=Occup_min(x):60
                    Occup_ranges_fine((i-1)*60+z) = Occup_cnt(x);
                end
                x = x+1;
            end
        end
    end
end
%%
for a=1:length(Occup_ranges_fine)
    if Occup_ranges_fine(a)>=0 && Occup_ranges_fine(a)<3
        Occup_ranges_coarse(a) = 3;
    elseif Occup_ranges_fine(a)>=3 && Occup_ranges_fine(a)<6
        Occup_ranges_coarse(a) = 6;
    elseif Occup_ranges_fine(a)>=6 && Occup_ranges_fine(a)<9
        Occup_ranges_coarse(a) = 9;
    elseif Occup_ranges_fine(a)>=9 && Occup_ranges_fine(a)<12
        Occup_ranges_coarse(a) = 12;
    elseif Occup_ranges_fine(a)>=12 && Occup_ranges_fine(a)<15
        Occup_ranges_coarse(a) = 15;
    elseif Occup_ranges_fine(a)>=15 && Occup_ranges_fine(a)<18
        Occup_ranges_coarse(a) = 18;
    end
end

%%Occupied or not (binary 1 or 0)

%%
filename = 'powdata_3_22.txt';
fid = fopen(filename, 'w');

for j=1:length(mean_wind)
    fprintf(fid,'%d,%s,%f,%f,%f\n',Occup_ranges_fine(j),time_of_day{j},mean_wind(j),peak_wind(j),range_wind(j));
end

fclose(fid);

