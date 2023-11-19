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
% according to https://de.mathworks.com/matlabcentral/fileexchange/4372-fractal-fern
NumOfPts = 10000;
for j = 1:NumOfPts
	
	x = rand(1);
	y = rand(1);
	
	for i = 1:f
		
		p = rand(1);
				
		if p < .01
			xn = 0;
			yn = .16*y;
			x = xn;
			y = yn;
		elseif p < .08
			xn = .2*x-.26*y;
			yn = .23*x+.22*y+1.6;
			x = xn;
			y = yn;
		elseif p < .15
			xn = -.15*x+.28*y;
			yn = .26*x+.24*y+.44;
			x = xn;
			y = yn;
		else
			xn = .85*x+.04*y;
			yn = -.04*x+.85*y+1.6;
			x = xn;
			y = yn;
		end
    end
	xs(j) = x;
	ys(j) = y;
end
plot(xs,ys,'.','Color','g')
axis('off');
axis([-3,3,0,15]);
end