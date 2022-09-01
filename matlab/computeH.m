function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
N = size(x1,2);

x1x = x1(1,:);
x1y = x1(2,:);
x2x = x2(1,:);
x2y = x2(2,:);

Hsize = (2.*N);
H = zeros(Hsize,9);
for i = 1:N
    index1 = 2.*i-1;
    index2 = 2.*i;
    H(index1,:) = [x2x(i), x2y(i), 1, 0, 0, 0,  -x1x(i).*x2x(i), -x1x(i).*x2y(i), -x1x(i)];
    H(index2,:)= [0,0,0, x2x(i), x2y(i), 1,   -x1y(i).*x2x(i), -x1y(i).*x2y(i), -x1y(i)];
end
[U, S, V] = svd(H, 'econ');

H2to1 = reshape(V(:,end),[3 3]);
H2to1 = H2to1';
end