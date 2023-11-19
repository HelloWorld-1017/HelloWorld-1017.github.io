% [Falling - MATLAB Flipbook Mini Hack]
% (https://ww2.mathworks.cn/matlabcentral/communitycontests/contests/6/entries/13465)
clc,clear,close all

contestAnimator()

function contestAnimator()
    animFilename = 'animation.gif'; % Output file name
    firstFrame = true;
    framesPerSecond = 24;
    delayTime = 1/framesPerSecond;
    % Create the gif
    for frame = 1:48
        drawframe(frame)
        fig = gcf(); 
        fig.Units = 'pixels';
        fig.Position(3:4) = [300,300];
        im = getframe(fig);
        [A,map] = rgb2ind(im.cdata,256);
        if firstFrame
            firstFrame = false;
            imwrite(A,map,animFilename, LoopCount=Inf, DelayTime=delayTime);
        else
            imwrite(A,map,animFilename, WriteMode="append", DelayTime=delayTime);
        end
    end
end

function drawframe(f)
% Background plot
figure
axis([0 1 0 1]);
axis equal;
axis off
% Falling string
s = 'MATLAB';
% define the frames
frames = 48;
t = 1:frames; % define frame vector
% compute x
x = t/frames * .5 - 0.2;
% compute y
y = 1 - 0.5 * ((t * 10)/frames).^8; 
y = .5 + y / 10^8;
% compute rotation
a = (y - .5) * 180;
% draw the letters
for i=1:length(s)
    index = i * 4 + f;
    if index <= 48
        text( x(index) + .08 * i, y(index), s(i), ...
            'Rotation', a(index), ...
            'FontSize', 24, ...
            'Color', [47, 126, 178]/255);
    end
end
end
