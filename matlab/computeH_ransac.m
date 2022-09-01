function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

%%%

range = size(locs1,1);
val = 300;
npoints = 4;
%bestH2to1 = [];
bestH2to1 = zeros(3,3);
nPreinliers_nums = 0;
bestInliers = zeros(1,range); 

if range < npoints
    inliers = bestInliers;
    return; 
end

for i=1:val
    getPts = randperm(range,npoints);
    p1 = zeros(2,npoints);
    p2 = zeros(2,npoints);
    for j=1:npoints
        p1(:,j) = locs1(getPts(j),:)';
        p2(:,j) = locs2(getPts(j),:)';
    end
    
    
    [H2to1] = computeH(p1,p2);
    nx1 = locs1;
    nx1 = [nx1 ones(size(locs1,1),1)]';
    
    nx2 = locs2;
    nx2 = [nx2 ones(size(locs2,1),1)]';
    
    nx2 = H2to1 * nx2;
    nx2 = nx2 ./ nx2(3,:);
    
    distance = nx2 - nx1;
    getpointsdistance = sqrt(distance(1,:).*distance(1,:) + distance(2,:).*distance(2,:));
    distance = getpointsdistance;
    
    
    inliers = zeros(1,range);
    for k=1:range
        if distance(k) < 10
            inliers(k) = 1;
        end
    end
    
    total_inliers = sum(distance(:) < 10);
    
    if total_inliers > nPreinliers_nums
        bestInliers = inliers;
        nPreinliers_nums = total_inliers;
    end
end

inliers = bestInliers;
nlocs2 = locs2(inliers==1,:);
nlocs1 = locs1(inliers==1,:);
bestH2to1 = computeH_norm(nlocs1,nlocs2);
end