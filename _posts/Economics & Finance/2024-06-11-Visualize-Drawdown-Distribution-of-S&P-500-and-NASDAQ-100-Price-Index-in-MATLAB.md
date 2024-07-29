---
title: "Visualize Drawdown Distribution of Several Main Stock Market Indexes in MATLAB: S&P 500, NASDAQ 100, and Dow Jones Industrial Average"
categories:
 - MATLAB
 - Mathematics
 - Economics & Finance
 - Time Series Analysis
tags:
 - MATLAB Computational Finance
 - Probability Theory and Mathematical Statistics
 - MATLAB Graphics
date: 2024-06-11 11:10:48 +0800
last_modified_at: 2024-07-28 17:06:30 +0800
---

# Definition of drawdown, maximum drawdown, and maximum drawdown duration

A figure in Ernest P. Chan’s book, *Quantitative trading: how to build your own algorithmic trading business*[^2], shows clearly what is drawdown, maximum drawdown, and maximum drawdown duration:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406281532133.png" alt="image-20240628153206958" style="zoom: 50%;" />

<br>

# By June 11, 2024

## S&P 500 price index (11 June, 2014 --- 10 June, 2024)

`script1.m`, to retrieve series from FRED server[^1]:

<div id="script-1"></div>

```matlab
clc,clear,close all

% Retrieve S&P 500 series
helperRetrieveAndSaveSeries("SP500")

function helperRetrieveAndSaveSeries(seriesID)
matName = sprintf("%s_%s.mat",seriesID,string(datetime("now","Format","yyyyMMdd")));

if ~exist(matName,"file")
    % Connect to the FRED data server
    connection = fred("https://research.stlouisfed.org/fred2/");

    % Retrieve series
    series = fetch(connection,seriesID);

    % Close FRED connection
    close(connection)

    % Preprocess Series
    dateOfSeries = datetime(series.Data(:,1),"ConvertFrom","datenum");
    indexOfSeries = series.Data(:,2);

    save(matName,"dateOfSeries","indexOfSeries")
end
end
```

`script2.m`, to visualize:

<div id="script-2"></div>

```matlab
clc,clear,close all

seriesID = "SP500";
matName = sprintf("%s_%s.mat",seriesID,string(datetime("now","Format","yyyyMMdd")));

if exist(matName,"file")
    series = load(matName);
    helperVisualize(series.dateOfSeries,series.indexOfSeries,seriesID)
end
exportgraphics(gcf,seriesID+".jpg","Resolution",900)
```

where the self-defined `helperVisualize` function is:

```matlab
function helperVisualize(date,index,seriesID)
% Preprocess index
index = fillmissing(index,"previous");

% Calculate drawdown for each day
maxIndexEver = nan(numel(index),1);
daysOfToday2PreviousHighest = nan(numel(index),1);
for i = 1:height(index)
    [maxIndexEver(i),idx] = max(index(1:i));
    daysOfToday2PreviousHighest(i) = days(date(i)-date(idx));
end
drawDown = (maxIndexEver-index)./maxIndexEver*100;

% Calculate and show the number of days to a new high
daysOfToday2PreviousHighest = diff(daysOfToday2PreviousHighest);
daysOfToday2PreviousHighest(daysOfToday2PreviousHighest>=0) = [];
daysOfToday2PreviousHighest = -daysOfToday2PreviousHighest;
daysOfToday2PreviousHighest = (daysOfToday2PreviousHighest-1);
daysOfToday2PreviousHighest(daysOfToday2PreviousHighest==0) = [];
[ecdff2,ecdfx2] = ecdf(daysOfToday2PreviousHighest);
dateList = 0.2:0.1:1;
fprintf("Statistical characteristics of maximum drawdown duration:\n")
for i = 1:numel(dateList)
    idx = find(ecdff2 >= dateList(i));
    idx = idx(1);
    fprintf("There is a %.2f%% possibility to reach a new high within %d days. \n", ...
        ecdff2(idx)*100,ecdfx2(idx))
end

figure("Color","w","Position",[103,206,1723,600]);
tiledlayout(1,2,"TileSpacing","tight")

% Visualize the price index as date
nexttile
set(gca,"FontName","Times New Roman","FontSize",15)
hold(gca,"on")
plot(date,index,"Color","b")
title("Historical data")
xlabel("Date")
xtickformat("yyyy")
ylabel("Price index")

% Visualize the distribution of maximum drawdown
nexttile
set(gca,"FontName","Times New Roman","FontSize",15)
xlabel("Drawdown (%)")
hold(gca,"on"),box(gca,"on")
xlim([0,max(drawDown)])

% Plot the histogram of drawdown
yyaxis left
histogram(drawDown,100,"FaceColor","b");
ylabel("Frequency")
set(gca,"YColor",[0,0,1])
% Plot the empirical cumulative distribution function
yyaxis right
hold(gca,"on")
set(gca,"YColor",[1,0,0])
ylim([0,1.1])
yticks(0:0.2:1)
yticklabels(0:0.2:1)
[ecdff,ecdfx] = ecdf(drawDown);
stairs(ecdfx',ecdff',"LineWidth",1.5,"Color","r","LineStyle","-")
ylabel("Cumulative probability")
title("Drawdown distribution")

helperLine(ecdfx,ecdff,0.9)
helperLine(ecdfx,ecdff,0.8)
helperLine(ecdfx,ecdff,0.5)
box(gca,"off")

% Add title
gridTitle = sprintf("%s price index (from %s to %s)", ...
    seriesID,date(1),date(end));
sgtitle(gridTitle)
end

function helperLine(x,y,k)
idx = find(y >= k);
xline(x(idx(1)),"--",sprintf("%.2f%%",x(idx(1))), ...
    "LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)
yline(y(idx(1)),"--",sprintf("%.2f",y(idx(1))), ...
    "LineWidth",1.5,"Color",0.2*ones(1,3),"FontSize",20)
scatter(x(idx(1)),y(idx(1)),100,"Marker","x","MarkerEdgeColor","r","LineWidth",2)
end
```

The results are:

![SP500](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406111035009.jpg)

```
Statistical characteristics of maximum drawdown duration:
There is a 28.10% possibility to reach a new high within 2 days. 
There is a 34.71% possibility to reach a new high within 3 days. 
There is a 43.80% possibility to reach a new high within 4 days. 
There is a 51.24% possibility to reach a new high within 5 days. 
There is a 62.81% possibility to reach a new high within 7 days. 
There is a 70.25% possibility to reach a new high within 10 days. 
There is a 80.99% possibility to reach a new high within 18 days. 
There is a 90.08% possibility to reach a new high within 46 days. 
There is a 100.00% possibility to reach a new high within 744 days. 
```

## NASDAQ 100 price index (02 Jan, 1986 --- 07 June, 2024)

Change `seriesID` in [Script 1](#script-1) and [Script 2](#script-2) as `"NASDAQ100"` to get the results for NASDAQ 100 price index:

![NASDAQ100](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406111035726.jpg)

```
Statistical characteristics of maximum drawdown duration:
There is a 23.92% possibility to reach a new high within 2 days. 
There is a 32.16% possibility to reach a new high within 3 days. 
There is a 46.27% possibility to reach a new high within 5 days. 
There is a 51.76% possibility to reach a new high within 6 days. 
There is a 61.57% possibility to reach a new high within 10 days. 
There is a 71.76% possibility to reach a new high within 14 days. 
There is a 80.39% possibility to reach a new high within 27 days. 
There is a 90.20% possibility to reach a new high within 56 days. 
There is a 100.00% possibility to reach a new high within 5697 days. 
```

<br>

# By June 28, 2024

## Dow Jones Industrial Average (30 June, 2014 --- 27 June 2024)

Change `seriesID` in [Script 1](#script-1) and [Script 2](#script-2) as `"DJIA"` to get the results for ‘Dow Jones Industrial Average’:

![DJIA](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406281522265.jpg)

```
Statistical characteristics of maximum drawdown duration:
There is a 20.45% possibility to reach a new high within 2 days. 
There is a 30.68% possibility to reach a new high within 3 days. 
There is a 47.73% possibility to reach a new high within 5 days. 
There is a 51.14% possibility to reach a new high within 6 days. 
There is a 62.50% possibility to reach a new high within 9 days. 
There is a 70.45% possibility to reach a new high within 13 days. 
There is a 81.82% possibility to reach a new high within 34 days. 
There is a 90.91% possibility to reach a new high within 73 days. 
There is a 100.00% possibility to reach a new high within 706 days. 
```

<br>

**References**

[^1]: [Fetch S&P 500 Price Index (or Other Available Series) from FRED (Federal Reserve Economic Data) Server in MATLAB - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-04-17/13-58-11.html).
[^2]: Chan, Ernest P. *Quantitative trading: how to build your own algorithmic trading business*. John Wiley & Sons, 2021, available at: [Quantitative Trading: How to Build Your Own Algorithmic Trading Business (Wiley Trading)](https://www.myquant.cn/uploads/default/original/1X/4c7037365a4bf1623734c1c899baed7855061ace.pdf).

- [Drawdown (economics) - Wikipedia](https://en.wikipedia.org/wiki/Drawdown_(economics)).
- [Empirical distribution function - Wikipedia](https://en.wikipedia.org/wiki/Empirical_distribution_function).
- [MATLAB `ecdf`: Empirical cumulative distribution function - MathWorks](https://ww2.mathworks.cn/help/stats/ecdf.html).



