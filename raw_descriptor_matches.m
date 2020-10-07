% let user generate og_SIFT by selecting region in im1
% for each descriptor in og_SIFT, find close euclidean distances of all
% descriptors in descriptors2, match above certain threshold, include the sift
% Returns the indices of descriptors2 that have matches to sift 1 in the form of
% a vector

og_idxs = selectRegion(im1,positions1);
og_SIFT = zeros(length(og_idxs),128);
for i=1:length(og_idxs)
    og_SIFT(i,:) = descriptors1(og_idxs(i),:);
end

matched_descriptors = gen_matched_sifts(og_SIFT,descriptors2,1);

% generate positions, scales, orients
num_features_matched = length(matched_descriptors);
new_pos = zeros(num_features_matched,2);
new_orients = zeros(num_features_matched,1);
new_scales = zeros(num_features_matched,1);

for i=1:length(matched_descriptors)
    new_pos(i,1) = positions2(matched_descriptors(i),1);
    new_pos(i,2) = positions2(matched_descriptors(i),2);
    
    new_orients(i) = orients2(matched_descriptors(i));
    new_scales(i) = scales2(matched_descriptors(i));
end

imshow(im2);
hold on;
displaySIFTPatches(new_pos,new_scales,new_orients,im2);