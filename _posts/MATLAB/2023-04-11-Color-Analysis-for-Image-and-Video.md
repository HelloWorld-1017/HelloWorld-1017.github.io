---
layout: single
title: Color Analysis for Image and Video
date: 2023-04-11 18:51:49 +0800
categories: 
 - MATLAB
 - Graphic Design and Typography
tags:
 - MATLAB Graphics
 - MATLAB Data Import and Analysis
toc: false
---

# Analysis for MATLAB `pepers.png`

今天在看MATLAB Graphics Documentation的时候，看到了一个分析RGB图像色彩的案例 [1]。该示例分析的是MATLAB的自带图像`peppers.png`：

![image-20230409224701368](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409224701368.png?raw=true)

采用的方法是`histogram2`函数 [2] 分别绘制R-G通道、R-B通道和G-B通道的二维频率直方图：

```matlab
clc,clear,close all

rgb = imread('peppers.png');

r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);

figure('Units','pixels','Position',[805,413.67,1406,420])
colormap('jet')
tiledlayout(1,3)
nexttile
histogram2(r,g,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
ax = gca;
ax.CLim = [0 500];
axis equal
colorbar
xlabel('Red Values')
ylabel('Green Values')
title('Green vs. Red Pixel Components')

nexttile
histogram2(r,b,'DisplayStyle','tile','ShowEmptyBins','on',...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
ax = gca;
ax.CLim = [0 500];
axis equal
colorbar
xlabel('Red Values')
ylabel('Blue Values')
title('Blue vs. Red Pixel Components')


nexttile
histogram2(g,b,'DisplayStyle','tile','ShowEmptyBins','on',...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
ax = gca;
ax.CLim = [0 500];
axis equal
colorbar
xlabel('Green Values')
ylabel('Blue Values')
title('Green vs. Blue Pixel Components')
```

![image-20230409225108488](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409225108488.png?raw=true)

这样的图像中可以分析出结论：

- In each case, blue is the least dominant color signal. 
- In each case, blue is the least dominant color signal. 

之后又分别分析了三个通道一维直方图：

```matlab
clc,clear,close all

rgb = imread('peppers.png');
r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);

hold(gca,"on")
box(gca,"on")
grid(gca,"on")
histogram(r,'BinMethod','integers','FaceColor','r','EdgeAlpha',0,'FaceAlpha',1)
histogram(g,'BinMethod','integers','FaceColor','g','EdgeAlpha',0,'FaceAlpha',0.5)
histogram(b,'BinMethod','integers','FaceColor','b','EdgeAlpha',0,'FaceAlpha',0.5)
xlabel('RGB value')
ylabel('Frequency')
title('Color histogram in RGB color space')
xlim([0 257])
```

![image-20230409225635701](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409225635701.png?raw=true)

可以看到，三个颜色分量的尖峰都在比较小的RGB值处出现。但是，当RGB值超过100时（意味着红色更加红色，绿色更加绿色，蓝色更加蓝色），明显R分量的出现的频率最多，G分量次之，蓝色分量最少，与上面得到的结论是类似的。

需要注意的一点的是，`histogram2`函数的默认设置是展示三维的柱状频率图，而上面的代码中设置了`'DisplayStyle','tile'`，使用了颜色这一信息来表示频率。从这个角度讲，这种做图方式有些类似我们在博客 [3] 中提到的二元函数的二维平面展示方法。我觉得这种展示方式是比较合理的，一是图像更加紧凑，二是3D bar diagram和3D pie chart会在视觉上误导读者，在某些情况下不利于读者理解数据的相对大小 [4]。

<br>

# Another Example

上周末去电影院看了新海诚导演新的电影《铃芽之旅》，画面很精美，配乐也很震撼，于是回来又重新刷了刷新海诚导演以前的作品。我找了《你的名字》的一张壁纸 [5]：

![image-20230409232116431](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409232116431.png?raw=true)

做了类似的图像分析：

![image-20230409232133844](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409232133844.png?raw=true)

![image-20230409232156571](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409232156571.png?raw=true)

可以看到这张图片中的B分量时更多的。

除此之外，我看到B站Up主 *影迷至下Filmlas* 在分析《你的名字》这篇影片时 [6] ，就分析了整部影片的调色盘，以讲述新海诚导演是如何通过影片的配色来渲染情绪的：

![](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409232826670.png?raw=true)

应该是有专业的软件来创建出上面调色盘，那么，如果让我做的话，我应该怎么做呢？我其实想到了之前在博客 [7] 学习到的一个例子。我们可以读取图片后，使用K-means方法找到这张图片的一个中心点，使用这个中心点的颜色作为这个图片的配色。

例如，对于上面这张图像：

```matlab
clc, clear, close all

% Read image
pic = imread('yourname.jfif');

% The number of colors in colormap
colorNum = 1;

Rchannel = pic(:, :, 1);
Gchannel = pic(:, :, 2);
Bchannel = pic(:, :, 3);
RGBarray = double([Rchannel(:), Gchannel(:), Bchannel(:)]);

% k-means cluster
[idx, Centers] = kmeans(RGBarray, colorNum, ...
    'Distance', 'sqeuclidean', 'MaxIter', 1000);
Centers = round(Centers);

figure("Units", "pixels", "Position", [492.33, 324.33, 1472, 674])
tiledlayout(1, 2)

nexttile
imshow(pic)

nexttile
view(3)
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
for i = 1:colorNum
    scatter3(RGBarray(idx==i, 1), RGBarray(idx==i, 2), RGBarray(idx==i, 3), ...
        'filled', 'CData', Centers(i,:)./255);
    legends{i}=[num2str(Centers(i,1)), ' ', num2str(Centers(i,2)), ' ', num2str(Centers(i,3))];
end
legend(legends, 'Color', [0.9412    0.9412    0.9412], ...
    'FontName','Cambria', 'LineWidth', 0.8, 'FontSize', 11)
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;

ax.XLabel.String = 'R channel';
ax.XLabel.FontSize = 13;
ax.XLabel.FontName = 'Cambria';

ax.YLabel.String = 'G channel';
ax.YLabel.FontSize = 13;
ax.YLabel.FontName = 'Cambria';

ax.ZLabel.String = 'B channel';
ax.ZLabel.FontSize = 13;
ax.ZLabel.FontName = 'Cambria';

exportgraphics(gcf, "pic.png")
```

![image-20230409234723609](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230409234723609.png?raw=true)

这张图片可以使用（120,122,160）来表示。

于是，下面就很自然地想到对于整部影片进行色彩的分析：

```matlab
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
```

注：在读取视频数据的时候，要使用`VideoReader`先创建对象 [8]，但是当读取`.mkv`格式的视频文件时，会报错*“Error using VideoReader/initReader Unable to determine the required codec.”*，之后转换为MP4的HEVC(H256)格式，仍然会报错“*Error using VideoReader/initReader. Failed to initialize internal resources.*”，后来在官网中查看了MATLAB所支持的视频格式 [9]，将视频转换成MP4的MPEG4(DivX)视频编码格式就可以正常读取。
{: .notice--primary}

```matlab
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
```

![image-20230411182754788](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230411182754788.png?raw=true)

和上面参考 [6] 得到的视频色彩分析结果是比较类似，但是参考 [6] 的结果好像更加平滑。可能是我使用的k-means聚类的方法太粗糙了，也可能是我展示的方式不太好，展示每一帧图像的色彩分析有些过于密集了。但总之，这也是一个差不多的结果，哈哈哈~



<br>

**References**

[1] [Color Analysis with Bivariate Histogram - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/color-analysis-with-bivariate-histogram.html).

[2] [histogram2 - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.graphics.chart.primitive.histogram2.html).

[3] [【Idea 3】2D Image of Grid Data - What a starry night~](http://whatastarrynight.com/ideas/uncertainty/matlab/circuit breaker/computational fluid dynamics/machine learning/2D-Image-of-Grid-Data/).

[4] [Some Caveats for Creating a Figure from TikZ Macro Package Documentation - What a starry night~](http://whatastarrynight.com/latex/graphic design and typography/some-caveats-for-creating-a-figure-from-TikZ-macro-package-documentation/).

[5] [《你的名字》精選20張精美wallpaper](https://www.hk01.com/遊戲動漫/54748/你的名字-精選20張精美wallpaper).

[6] [万字重温《你的名字。》：这是六年间最佳动画电影吗？- 影迷至下Filmlast](https://www.bilibili.com/video/BV1KL411R75a/?spm_id_from=333.337.search-card.all.click&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[7] [Generate colormap in MATLAB - What a starry night~](http://whatastarrynight.com/matlab/graphic design and typography/generate-colormap-in-MATALAB/).

[8] [Create object to read video files - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/videoreader.html).

[9] [Supported Video and Audio File Formats - MathWorks China](https://ww2.mathworks.cn/help/matlab/import_export/supported-video-file-formats.html).





