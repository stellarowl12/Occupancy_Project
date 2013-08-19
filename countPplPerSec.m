function [count_vec] = countPplPerSec(input_mat)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    count_vec = [];
    num_changes = size(input_mat,1);

    for i=1:num_changes
        row = input_mat(i,:);
        num_ppl = row(7);
        sec = row(3)*60*60+row(4)*60+row(5)+1;
        if i == num_changes
            next_sec = 23*60*60+59*60+59+1;
        else
            next_row = input_mat(i+1,:);
            next_sec = next_row(3)*60*60+next_row(4)*60+next_row(5)+1;
        end
        seg_leng = next_sec-sec;
        count_vec = [count_vec; ones(seg_leng,1)*num_ppl];
    end

end

