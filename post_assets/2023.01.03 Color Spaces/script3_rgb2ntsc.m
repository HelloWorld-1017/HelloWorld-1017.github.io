clc, clear, close all

RGB = imread('board.tif');
YIQ = rgb2ntsc(RGB);

% Three components in YIQ Color Space
figure("Units", "pixels", "Position", [369,141,1010,580])
nexttile
imshow(YIQ(:,:,1));
title('Luminance in YIQ Color Space');
nexttile
imshow(YIQ(:,:,2));
title('In-phase in YIQ Color Space');
nexttile
imshow(YIQ(:,:,3));
title('Quadrature in YIQ Color Space');

% Constrast differenct conversion function
figure("Units", "pixels", "Position", [369,141,1010,580])
nexttile
imshow(RGB)
title('RGB Color Space')
nexttile
imshow(rgb2gray(RGB))
title('Converted by rgb2gray function')
nexttile
imshow(YIQ(:,:,1));
title('Luminance in YIQ Color Space');



