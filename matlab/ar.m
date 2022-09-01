% Q3.3.1
panda = loadVid('../data/ar_source.mov');
bookvid = loadVid('../data/book.mov');

cv_img = imread('../data/cv_cover.jpg');

newobj = VideoWriter('ar1.avi', 'Uncompressed AVI');
open(newobj)

for i = 1:length(panda)
    f = bookvid(i).cdata;
    p = panda(i).cdata;
    p = p(44:316,150:450,:);
    %% Extract features and match
    [locs1, locs2] = matchPics(cv_img, f);
    %% Compute homography using RANSAC
    [bestH2to1,~] = computeH_ransac(locs1, locs2);
    
    scaled_hp_img = imresize(p, [size(cv_img,1) size(cv_img,2)]);
    %% Display warped image.
    imshow(warpH(scaled_hp_img, inv(bestH2to1),size(f)));

    %% Display composite image
    imgdata = compositeH(inv(bestH2to1),scaled_hp_img,f);
    imshow(imgdata);
    writeVideo(newobj,imgdata)
    
end
close(newobj);

