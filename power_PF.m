function [ total_power_mat, total_PF_mat ] = power_PF(light_mat,power_mat,light_PF_scal,power_PF_mat)
%   Takes in already windowed matrices of light, power, powerfactor, and
%   light power factor. Outputs a total power matrix and total power factor
%   matrix.
    light_mat_pow = zeros(length(light_mat),1);
    light_pow_real = zeros(length(light_mat),1);
    light_pow_imag = zeros(length(light_mat),1);
    
    for i=1:length(light_mat)
        if light_mat(i) > 5
            light_mat_pow(i) = 2.128;
        end
    end
     
    light_pow_real = light_mat_pow .* light_PF_scal;
    light_pow_imag = light_mat_pow - light_pow_real;
    
    [r,c,d] = size(power_mat);
    
    pow_mat_real=zeros(r,1,d);
    pow_mat_imag=zeros(r,1,d);
    
    for i=1:d
        pow_mat_real(:,:,d) = power_mat(:,:,d) .* power_PF_mat(:,:,d);
        pow_mat_imag(:,:,d) = power_mat(:,:,d) - pow_mat_real(:,:,d);
    end
    
    sum(pow_mat_real,3)
    tot_pow_real = sum(pow_mat_real,3) + light_pow_real;
    tot_pow_imag = sum(pow_mat_imag,3) + light_pow_imag;
    
    total_power_mat = tot_pow_real + tot_pow_imag;
    total_PF_mat = tot_pow_real ./ total_power_mat;
    

end

