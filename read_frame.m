function [im,im_descr] = read_frame(fnames,frame_no)
framesdir = './frames/';
siftdir = './sift/';

% get a random frame
fname = [siftdir '/' fnames(frame_no).name];
load(fname, 'imname','descriptors');
    
% read in the associated image
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);
im_descr = descriptors;

end

