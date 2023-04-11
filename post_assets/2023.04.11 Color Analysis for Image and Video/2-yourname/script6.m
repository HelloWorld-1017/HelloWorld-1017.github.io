clc,clear,close all

load RGBperframe.mat

YourName = VideoReader("yourname.mp4");

RGBTuple = reshape(Centers,height(Centers),[],3);
RGBTuple = uint8(RGBTuple);% ATTENTION here, NECESSARY!!
RGBTuple = permute(RGBTuple,[2,1,3]);

figure('Units','pixels','Position',[51.67,432.33,2334.67,420.00])
imagesc((1:YourName.NumFrames)/YourName.FrameRate/60,1,RGBTuple)
xlabel('Time (minute)')
set(gca,'ytick',[],'yticklabel',[],'FontSize',13)
