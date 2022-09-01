function [H2to1] = computeH_norm(x1, x2)

N = size(x1,1);

%% Compute centroids of the points

centroid1 = sum(x1,1)/N;
centroid2 = sum(x2,1)/N;


%% Shift the origin of the points to the centroid
shift1 = x1 - centroid1;
shift2 = x2 - centroid2;
    
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
distances1 = zeros(N,1);
distances2 = zeros(N,1);

for i = 1:N
    distances1(i) = sqrt(shift1(i,1).^2 + shift1(i,2).^2);
    distances2(i) = sqrt(shift2(i,1).^2 + shift2(i,2).^2);
end
distanceAvg1 = mean(distances1);
distanceAvg2 = mean(distances2);

normScale1 = sqrt(2)/distanceAvg1;
normScale2 = sqrt(2)/distanceAvg2;


%% similarity transform 1
T1 = [normScale1 0 -normScale1*centroid1(1);
      0 normScale1 -normScale1*centroid1(2);
      0 0 1];

%% similarity transform 2
T2 = [normScale2 0 -normScale2.*centroid2(1);
      0 normScale2 -normScale2.*centroid2(2);
      0 0 1];
%% Compute Homography
newX1 = [x1 ones(N,1)];
newX2 = [x2 ones(N,1)];
normX1 = T1 * newX1';
normX2 = T2 * newX2';

H = computeH(normX1,normX2);

%% Denormalization
H2to1 = inv(T1)*H*T2;
end