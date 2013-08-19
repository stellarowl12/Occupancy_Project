%%%THIS IS OLD ONE USE EXTRACT CSVs


function [powerMat] = processPowerCSV(regex,downsamp_factor)
%regex is the expression that matches all the relevent CSVs (e.g. 'power_*.csv'),
%regex must be in string format.
    names = getfilenames('.',regex);

    for i=1:length(names)
        all_mats(:,:,i)=csvread(names{i});
    end

    sum_mats = sum(all_mats,3);
    fixed_dttime = sum_mats(:,1:6).*(1/length(names));
    comb_mats = [fixed_dttime sum_mats(:,7)];
    pre_ds_powerMat = flipud(comb_mats);
    
    powerMat = downsample(pre_ds_powerMat,downsamp_factor);

end

