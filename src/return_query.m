function [max_indices,frame_histos] = return_query(fnames,means,query_descriptor,numFrames)
% generate top similar frames for the query frame using kMeans
% descriptors as a reference

% construct histogram of query image
query_match = gen_matched_sifts(query_descriptor,means,0);
k = size(means,1);
query_histo = zeros(1,k);
for i=1:size(query_match) % generate histogram
    kth_idx = query_match(i);
    
    if kth_idx ~= 0
        query_histo(kth_idx) = query_histo(kth_idx) + 1;
    end
end

% get sift directories
siftdir = './sift/';

% generate histograms for all frames in the form of a F x k matrix
% (F = number of frames)
frame_histos = zeros(length(fnames),k);

for i=1:length(fnames)
    % load that file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'descriptors');
    
    frame_match = gen_matched_sifts(descriptors,means,0);
    frame_histo = zeros(1,k);
    for j=1:size(frame_match) % generate histogram
        kth_idx = frame_match(j);
    
        if kth_idx ~= 0
            frame_histo(kth_idx) = frame_histo(kth_idx) + 1;
        end
    end
    
    frame_histos(i,:) = frame_histo;
    fprintf('Generated histogram for frame %d/%d\n', i,length(fnames));
end

% generate vector that measures how close a frame is to the query
a_mag = sqrt(sum(query_histo.*query_histo));
closeness = zeros(size(frame_histos,1),1);
for i=1:size(frame_histos,1)
    frame_histo = frame_histos(i,:);
    b_mag = sqrt(sum(frame_histo.*frame_histo));
    
    % cosine of angle of 2 histograms
    cos = dot(query_histo,frame_histo)/(a_mag*b_mag);
    closeness(i) = cos;
end

% choose the closest frames
max_indices = zeros(numFrames,1);
for i=1:numFrames
    [~,idx] = max(closeness); % idx of closeness vector is the frame no.
    max_indices(i) = idx; % since frame # starts at frame# 60
    closeness(idx) = 0;
end

end

