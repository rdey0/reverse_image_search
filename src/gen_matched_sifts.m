function [match] = gen_matched_sifts(in_descr,targ_descr,threshold)
% want to see which sifts in input image matches to target words
% returns vector where each element is the idx of sift in targ_descr that
% matches to corresponding sift of in_descr
% 0 means there was no match

sq_distances = dist2(in_descr,targ_descr);

[min_dist, match] = min(sq_distances,[],2);

if threshold == 1
    sq_distances = sort(sq_distances,2);
    for i=1:size(sq_distances,1)
        min2 = sq_distances(i,2);
        
        % check ratio between minimum and second minimum
        if min_dist(i) / min2 > 0.6
            match(i) = 0;
        end
    end
    
    match = unique(match); % remove all 0s from the match idx array
    match(1) = [];
end

end

