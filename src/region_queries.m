framesdir = './frames/';
siftdir = './sift/';
load('kMeans.mat');
% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fnames = dir([siftdir '/*.mat']);

frame_no = 279;
fname = [siftdir '/' fnames(frame_no).name];
load(fname, 'imname','descriptors','positions');
    
% read in the associated image
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);

% get the sifts for the selected region
region_idxs = selectRegion(im,positions);
region_descr = zeros(length(region_idxs),128);
for i=1:length(region_idxs)
    region_descr(i,:) = descriptors(region_idxs(i),:);
end

% find matches with words
max_indices = return_query(fnames,kMeans,region_descr,5);

% display the query image + 5 similar
subplot(2,3,1);
imshow(im);
title("Query");
    
subplot(2,3,2);
im1 = read_frame(fnames,max_indices(1));
imshow(im1);
title("BoW 1");
    
subplot(2,3,3);
im2 = read_frame(fnames,max_indices(2));
imshow(im2);
title("BoW 2");
    
subplot(2,3,4);
im3 = read_frame(fnames,max_indices(3));
imshow(im3);
title("BoW 3");
    
subplot(2,3,5);
im4 = read_frame(fnames,max_indices(4));
imshow(im4);
title("BoW 4");
    
subplot(2,3,6);
im5 = read_frame(fnames,max_indices(5));
imshow(im5);
title("BoW 5");
