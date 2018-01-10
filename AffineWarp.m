%This function is used to warp I 
function Io=AffineWarp(I, p, window)
    %p2m(windows)=pts => windows=invp2m(pts)
    %m is invp2m
    m=p2m(AffineInverse(p));
    tform=maketform('affine', m');
    Io=imtransform(I, tform, 'bilinear', 'XData', [window(1, 1), window(2, 1)], 'YData', [window(1, 2), window(3, 2)]);
end