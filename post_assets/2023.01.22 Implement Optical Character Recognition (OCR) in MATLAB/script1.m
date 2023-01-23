clc, clear, close all

% Read image
image = imread("before_sunrise.png");

% Implement OCR
ocrResults = ocr(image);
disp(ocrResults.Text)

% Diplay Bounding Boxes of Words and Recognition Confidences
Iocr = insertObjectAnnotation(image, "rectangle", ...
    ocrResults.WordBoundingBoxes, ...
    ocrResults.WordConfidences);
imshow(Iocr);