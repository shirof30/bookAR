% Test For computeH.m
close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
img1 = im2gray(cv_cover);
img2 = im2gray(cv_desk);
[ locs1, locs2] = matchPics( img1, img2 );

%% Compute H
H_result = computeH( locs1' ,  locs2');
o_size = size(img2);
warp_im = warpH(cv_desk, H_result, o_size);

%% For test matching
img_test = im2gray(warp_im);
[ locs_temp1, locs_temp2] = matchPics( img2, img_test );
%%
figure;
showMatchedFeatures(cv_desk, warp_im, locs_temp1, locs_temp2, 'montage');
title('computeH matching');
