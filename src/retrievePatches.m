% Selects 2 random words and retrieves 25 relevant patches for each word 
function [] = retrievePatches(framesdir, siftdir, fnames, means)

randFeatures = randperm(size(means,2), 2);
word1 = means(:,randFeatures(1));
word2 = means(:,randFeatures(2));

% Display patches from word1
word1Matches = 0;
word2Matches = 0;
% Iterate through all images
for i=1:length(fnames)
    if word1Matches == 25 && word2Matches == 25
        break;
    end
    %fprintf('reading frame %d of %d\n', i, length(fnames));
    
    % Load the current file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    
    % Read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = rgb2gray(imread(imname));
    
    % Calculate matches for word 1
    sq_distances = dist2(transpose(word1),descriptors);
    avg = mean(sq_distances(1,:));
    std_dev = std(sq_distances(1,:));
    for j=1:size(sq_distances,2)
        if word1Matches == 25
            break;
        end
        
        % Plot the patch its distance is within threshold
        dist = sq_distances(j);
        if dist < avg - 3.3*std_dev
            patch = getPatchFromSIFTParameters(positions(j,:),scales(j),orients(j),im);
            word1Matches = word1Matches + 1;
            subplot(11,5,word1Matches);
            imshow(patch);
            box on;
        end
    end
    
    % Calculate matches for word 2
    sq_distances = dist2(transpose(word2),descriptors);
    avg = mean(sq_distances(1,:));
    std_dev = std(sq_distances(1,:));
    for j=1:size(sq_distances,2)
        if word2Matches == 25
            break;
        end
        
        % Plot the patch its distance is within threshold
        dist = sq_distances(j);
        if dist < avg - 3.3*std_dev
            patch = getPatchFromSIFTParameters(positions(j,:),scales(j),orients(j),im);
            word2Matches = word2Matches + 1;
            subplot(11,5, 30+word2Matches);
            imshow(patch);
        end
    end
    
end
subplot(11,5,3);
title('Word 1');
subplot(11,5,33);
title('Word 2');


