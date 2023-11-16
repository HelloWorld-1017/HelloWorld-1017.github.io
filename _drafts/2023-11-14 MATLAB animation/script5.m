clc,clear,close all

img = imread("peppers.png");
imshow(img)
F = getframe(gca());

[A1,map1] = rgb2ind(F.cdata,4);
[A2,map2] = rgb2ind(F.cdata,50);
[A3,map3] = rgb2ind(F.cdata,256);

imwrite(A1,map1,"img-1.jpg")
imwrite(A2,map2,"img-2.jpg")
imwrite(A3,map3,"img-3.jpg")

[A4,map4] = rgb2ind(F.cdata,257);
imwrite(A4,map4,"img-4.jpg","BitDepth",16)