function [new_vec] = binVec(vec,num_bins)

new_vec = zeros(length(vec),1);
[~,centers] = hist(vec,num_bins);
for i=1:length(vec)
    dist2cent = [];
    for j=1:length(centers)
        dist2cent(j) = abs(vec(i)-centers(j));
    end
    [~,min_index] = min(dist2cent);
    new_vec(i)=min_index;
end

end

