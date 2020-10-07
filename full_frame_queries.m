framesdir = './frames/';
siftdir = './sift/';
load('kMeans.mat');
% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fnames = dir([siftdir '/*.mat']);

% get a random frame
rand_frameno = floor(rand*6612);
[im, im_descriptor] = read_frame(fnames,rand_frameno);

% get the top 5 similar images to im
max_indices = return_query(fnames,kMeans,im_descriptor,5);
 
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
    
