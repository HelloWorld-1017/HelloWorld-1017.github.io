%% Demo file for base64 image encoding
% Loads a MATLAB image (peaks), encodes it in base64
% and takes advantage of the web browser's support for 
% base64-encoded images (win32 platform only).

surf(peaks)
base64img;
close(gcf);