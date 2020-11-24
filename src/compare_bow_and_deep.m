%Compares matched frames for frames 4503 and 394 between BoW and alexnet
framesdir = './frames/';
siftdir = './sift/';
load('kMeans.mat');
% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fnames = dir([siftdir '/*.mat']);

% get frame 4503
[im, im_descriptor] = read_frame(fnames,4444);

% get the top 10 similar images to im
[max_indices, frame_histos] = return_query(fnames,kMeans,im_descriptor,11);
 
% display the query image + 10 similar
subplot(8,6,1);
imshow(im);
title("BoW Query: 4503");
for i=2:11
    subplot(8,6,i);
    im = read_frame(fnames,max_indices(i));
    imshow(im);
    title(num2str(i-1));
end

% Load alexnet
closeness = zeros(1,length(fnames));  
load([siftdir '/friends_0000004503.jpeg.mat' ], 'deepFC7');
alex_query = deepFC7;
for i = 1:length(fnames)
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'deepFC7');
    closeness(i) = dot(alex_query, deepFC7) / (norm(alex_query) * norm(deepFC7));    
end 

% Display best matches
[~,indices] = maxk(closeness,11);
subplot(8,6,13);
[im, ~] = read_frame(fnames,4444);
imshow(im);
title("AlexNet Query: 4503");
for i=2:11
    subplot(8,6,12+i);
    im = read_frame(fnames,indices(i));
    imshow(im);
    title(num2str(i-1));
end

% get frame 394
[im, im_descriptor] = read_frame(fnames,335);

% get the top 10 similar images to im
max_indices = return_query_quick(kMeans,im_descriptor,frame_histos,11);
% display the query image + 10 similar
subplot(8,6,25);
imshow(im);
title("BoW Query: 394");
for i=2:11
    subplot(8,6,24+i);
    im = read_frame(fnames,max_indices(i));
    imshow(im);
    title(num2str(i-1));
end

% Load alexnet
closeness = zeros(1,length(fnames));  
load([siftdir '/friends_0000000394.jpeg.mat' ], 'deepFC7');
alex_query = deepFC7;
for i = 1:length(fnames)
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'deepFC7');
    closeness(i) = dot(alex_query, deepFC7) / (norm(alex_query) * norm(deepFC7));    
end 

% Display best matches
[~,indices] = maxk(closeness,11);
subplot(8,6,37);
[im, ~] = read_frame(fnames,335);
imshow(im);
title("AlexNet Query: 394");
for i=2:11
    subplot(8,6,36+i);
    im = read_frame(fnames,indices(i));
    imshow(im);
    title(num2str(i-1));
end


