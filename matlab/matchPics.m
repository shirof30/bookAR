function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
img1 = im2gray(I1);
img2 = im2gray(I2);

%% Detect features in both images

%FAST FEATURES
points1 = detectFASTFeatures(img1);
points2 = detectFASTFeatures(img2);

%SURFF FEATURES
%points1 = detectSURFFeatures(img1);
%points2 = detectSURFFeatures(img2);

%% Obtain descriptors for the computed feature locations
[desc1, valid_locs1] = computeBrief(img1, points1.Location);
[desc2, valid_locs2] = computeBrief(img2, points2.Location);
%% Match features using the descriptors
threshold = 10.0;
features = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', 0.85);

locs1 = valid_locs1(features(:,1),:);
locs2 = valid_locs2(features(:,2),:);
end

