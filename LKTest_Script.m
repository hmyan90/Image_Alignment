%This script is used to test the Lucas Kanade inverse compositional algorithm
clear all; close all; clc;
rgb=imread('affine_prince.jpg');
img=ImageDataTypeConversion(rgb);   %Convert RGB to 1 channel
clear rgb;
sc=0.2; img=imresize(img, sc);

%Windows selected to get template image
pts=sc*[550, 1690, 550, 1690; 850, 850, 2420, 2420]';
xl=pts(1, 2); xr=pts(3, 2);
yl=pts(1, 1); yr=pts(2, 1);
%figure; imshow(img(xl:xr, yl:yr));
window=pts-100;
xl1=window(1, 2); xr1=window(3, 2);
yl1=window(1, 1); yr1=window(2, 1);
%figure; imshow(img(xl1:xr1, yl1:yr1));

%Get the transformation matrix parameters p2m(window)=pts
p=AffinePara4Points(window, pts);

T0=AffineWarp(img, p, window);
%figure; imshow(T0);

ptrue=p;
pini=ptrue;
%pini(1:4)=pini(1:4)+0.1;
pini(5)=pini(5)+50; pini(6)=pini(6)+50;

new_p=LucasKanadeIC(T0, img, pini, 1000, window);