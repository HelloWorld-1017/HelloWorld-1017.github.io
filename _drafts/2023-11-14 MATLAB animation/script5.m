clc,clear,close all

img = imread("peppers.png");
imshow(img)
F = getframe(gca());

[A4,map4] = rgb2ind(F.cdata,65536);
imwrite(A4,map4,"img-4.jpg","BitDepth",16)