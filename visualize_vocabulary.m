%Gathers a percentage of features from each of the 6612 images and runs
%k-means on the resulting collection of data. Selects 2 random words from
%the generated vocabulary and retrieves 25 patches for each image

k = 1500; % Find k cluster centers in the data
ratio = 0.1; % The ratio of features to be sampled from each image

% Set up path
addpath('./');
framesdir = './frames/';
siftdir = './sift/';
fnames = dir([siftdir '/*.mat']);


% Declare feature space matrix (figure out how large it will need to be)
fprintf('Creating feature space matrix \n');
featureSpaceSize = 0;
for i=1:length(fnames)
    % load the file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    [numRows, ~] = size(descriptors);
    featureSpaceSize = featureSpaceSize + floor(numRows*ratio);
end
featureSpace = zeros(128, featureSpaceSize);

% Populate the feature space matrix
fprintf('Populating feature space \n');
count = 1;
for i=1:length(fnames)
    % load the file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    [numRows, ~] = size(descriptors);
    sampledFeatures = datasample(descriptors,floor(ratio*numRows),1,'Replace',false);
    numFeatures = size(sampledFeatures,1);
    featureSpace(:,count:count+numFeatures-1) = transpose(sampledFeatures);
    count = count + numFeatures;
end

% Calculate k-means clustering to create the vocabulary
fprintf('Calculating k-means clustering for %d cluster centers and %d descriptors \n',k, size(featureSpace,2));
[membership,means,rms] = kmeansML(k,featureSpace);

% Selects 2 random words and retrieves 25 relevant patches for each word
fprintf('Selecting 2 random words and retrieving 25 patches each')
retrievePatches(framesdir, siftdir, fnames, means);