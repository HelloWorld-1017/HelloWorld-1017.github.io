clc, clear, close all

% Read image
image = imread("before_sunrise.png");

% Implement OCR in Regions of Interest (ROI)
imshow(image)
roi = drawrectangle;
ocrResults = ocr(image, roi.Position);

% Diplay Bounding Boxes of Words and Recognition Confidences
Iocr = insertObjectAnnotation(image, "rectangle", ...
    ocrResults.WordBoundingBoxes, ...
    ocrResults.WordConfidences);
imshow(Iocr);




