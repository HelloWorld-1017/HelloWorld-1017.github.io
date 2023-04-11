clc,clear,close all

tic
YourName = VideoReader("yourname.mp4");
Centers = nan(YourName.NumFrames,3); % (153342,3)
i = 0;

% Read all the frames from the video, one frame at time
while hasFrame(YourName)
    i = i+1;
    frame = readFrame(YourName);

    Rchannel = frame(:, :, 1);
    Gchannel = frame(:, :, 2);
    Bchannel = frame(:, :, 3);
    RGBarray = double([Rchannel(:), Gchannel(:), Bchannel(:)]);

    % k-means cluster
    [idx, center] = kmeans(RGBarray, 1, ...
        'Distance', 'sqeuclidean', 'MaxIter', 1000);
    Centers(i,:) = round(center);
    fprintf("%s-th frame: (%d, %d, %d)\n", ...
        num2str(i),Centers(i,1),Centers(i,2),Centers(i,3))
end

save("RGBperframe.mat", "Centers") % 157 KB
toc % Elapsed time is 28497.274537 seconds (7.92 hours).