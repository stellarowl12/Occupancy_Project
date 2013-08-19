function [final_mat] = extractHomeData(csv_name,delimiter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    data = read_mixed_csv(csv_name,delimiter);
    data(1,:) = [];
    values = data(:,2);

    for i=1:length(values)
        vals2(i) = str2double(values(i));
    end
    vals2 = vals2';

    vals2(vals2<1)=0;

    %plot(vals2);

    datetimes = data(:,1);

    split_times = regexp(datetimes,'[-T:.]','split');

    dt_mat = zeros(length(split_times),6);

    for i=1:length(split_times)
        dt_mat(i,1) = str2double(split_times{i}(1));      %%year
        dt_mat(i,2) = str2double(split_times{i}(2));      %%month
        dt_mat(i,3) = str2double(split_times{i}(3));      %%day
        dt_mat(i,4) = str2double(split_times{i}(4));      %%hour
        dt_mat(i,5) = str2double(split_times{i}(5));      %%minute
        dt_mat(i,6) = str2double(split_times{i}(6));      %%second
    end

    final_mat = [dt_mat vals2];


end

