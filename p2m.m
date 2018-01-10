%Parameter vector to affine matrix
%1+p(1)  p(3)  p(5)
% p(2)  1+p(4) p(6)
%  0      0     1
function m=p2m(p)
    p(1)=1+p(1);
    p(4)=1+p(4);
    m=[reshape(p, 2, 3); 0, 0, 1];
end