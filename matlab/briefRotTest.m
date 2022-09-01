% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
cv_cover = imread('../data/cv_cover.jpg');
img = im2gray(cv_cover);
%% Compute the features and descriptors
points1 = detectFASTFeatures(img);
[desc1, valid_locs1] = computeBrief(img, points1.Location);

hist_val = zeros(1,37,'uint32');
for i = 0:36
    %% Rotate image
    rot_img = imrotate( img, (-10.*i));
    %% Compute features and descriptors
    points2 = detectFASTFeatures(rot_img);
    [desc2, valid_locs2] = computeBrief(rot_img, points2.Location);
    %% Match features
    threshold = 10.0;
    pairs = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', 0.65);
    locs1 = valid_locs1(pairs(:,1),:);
    locs2 = valid_locs2(pairs(:,2),:);
    %% Update histogram
        val = size(locs1);
    hist_val(i+1) = val(1);
    if mod(i,10) == 6
        %figure;
        %showMatchedFeatures(cv_cover, rot_img, locs1, locs2, 'montage');
        %title('Rotated Match points');
    end
end

%% Display histogram
%figure()
%histogram(hist_val(1,:),'NumBins', 25);

%%

% Detect SURFF
points1 = detectSURFFeatures(img);
[features1, validPoints1] = extractFeatures(img, points1.Location,'Method','SURF');
hist_val_surf = zeros(1,37,'uint32');
for i = 0:36
%% Rotate image
    rot_img = imrotate( img, (-10.*i));
    %% Compute features and descriptors
    points2 = detectFASTFeatures(rot_img);
    [features2, validPoints2] = extractFeatures(rot_img, points2.Location,'Method','SURF');
    %% Match features
    pairs = matchFeatures(features1, features2, 'MaxRatio', 0.8);
    locs1 = validPoints1(pairs(:,1),:);
    locs2 = validPoints2(pairs(:,2),:);
    
    %% Update histogram
    val = size(locs1);
    hist_val_surf(i+1) = val(1);
    if mod(i,10) == 6
        figure;
        showMatchedFeatures(cv_cover, rot_img, locs1, locs2, 'montage');
        title('Rotated Match Points SURF');
    end
end


figure()
histogram(hist_val_surf(1,:),'NumBins', 25);