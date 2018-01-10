%p2m(srcPoints)=dstPoints, get the map
%  1+p1  p3   p5    x1  x2  x3 x4   xx1  xx2   xx3 xx4
%[  p2  1+p4  p6 ]*[y1  y2  y3 y4]=[yy1  yy2   yy3 yy4]
%   0    0     1    1   1    1  1    1    1      1  1
%which is equivalent to
% p1  p3  p5   x1  x2   x3 x4   xx1-x1  xx2-x2   xx3-x3  xx4-x4
%[p2  p4  p6]*[y1  y2   y3 y4]=[yy1-y1  yy2-y2   yy3-y3  yy4-y4]
% 0   0    1    1   1    1  1     1       1        1       1
%which can be written as
%  x1  0   y1  0   1 0        xx1-x1
%  x2  0   y2  0   1 0   p1   xx2-x2
%  x3  0   y3  0   1 0   p2   xx3-x3
%[ x4  0   y4  0   1 0]*[p3]=[xx4-x4]
%  0   x1  0   y1  0 1   p4   yy1-y1
%  0   x2  0   y2  0 1   p5   yy2-y2
%  0   x3  0   y3  0 1   p6   yy3-y3
%  0   x4  0   y4  0 1        yy4-y4
function p=AffinePara4Points(srcPoints, dstPoints)
    u=srcPoints(:, 1);
    v=srcPoints(:, 2);
    N=size(srcPoints, 1);
    v0=zeros(N, 1);
    v1=ones(N, 1);
    A=[u v0 v v0 v1 v0; v0 u v0 v v0 v1];
    p=A\(dstPoints(:)-srcPoints(:));
end