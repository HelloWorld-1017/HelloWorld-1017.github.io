---
layout: single
title: "The Notion of Runs in Wald-Wolfowitz Runs Test"
date: 2023-11-06 13:01:26 +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - Hypothesis Test
 - Graph Theory
---

# Introduction

The notion of "run" is fundamental in Wald-Wolfowitz Runs Test [^3]. The NCSS statistical software [^1] provides a detailed documentation [^2] to explain what is “run” (BTW, maybe the most detailed one I could found on the Internet) and related hypothesis tests. So, in this blog, I want to learn how to compute "runs" in various cases and use MATLAB to realize it.

<br>

# Binary data

For the case of binary data consisting of two district categories, a run is defined as **a sequence where a single value is repeated one or more times**, and **a new run always occurs when the data value changes**. 

Definition of “run” from Wikipedia [^3]: A *run* of a sequence is a maximal non-empty segment of the sequence consisting of adjacent equal elements.
{: .notice--primary}

For example, in the following binary data series consisting of $n=16$ values:

$$
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{ 1\ 1\ 1}}\ 
\textcolor{red}{\underline{0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{red}{\underline{0}}\ 
\textcolor{green}{\underline{ 1\ 1\ 1\ 1\ 1}}\label{eq1}
$$

there are:

- $4$ runs for category $\textcolor{red}{0}$, whose lengths are $2$, $1$, $2$, and $1$;
- $4$ runs for $\textcolor{green}{1}$, whose lengths are $3$, $1$, $1$, and $5$,

and therefore totally $8$ distinct runs could be found. 

As can be seen, **the runs strongly relate to the $0$-$1$ joints**, and the most obvious pattern among which is that **the total number of runs equals to $0$-$1$ joint count plus one**. Based on these understandings, we could write the following MATLAB script to count runs automatically:

<div id="script1"></div>

```matlab
clc,clear,close all

samples = [0,0,1,1,1,0,1,0,0,1,0,1,1,1,1,1];

[data_1,data_2,lengths_1,runs_1,lengths_2,runs_2,totalRuns] = helperCountRuns(samples);

function [data_1,data_2,lengths_1,runs_1,lengths_2,runs_2,totalRuns] = helperCountRuns(samples)
num = numel(samples);

% Calculate total runs
idx1 = samples(1:num-1)~=samples(2:num);
totalRuns = sum(idx1)+1;

% Find each run slice
pos1 = find(idx1==1);
pos2 = [1,pos1+1];
pos1 = [pos1,num];
slices = arrayfun(@(x,y) samples(x:y),pos2,pos1,"UniformOutput",false);

% Count runs of each length
[classVariables1,lengths_1] = findgroups(cellfun(@numel,slices(1:2:end)));
runs_1 = splitapply(@numel,slices(1:2:end),classVariables1);
[classVariables2,lengths_2] = findgroups(cellfun(@numel,slices(2:2:end)));
runs_2 = splitapply(@numel,slices(2:2:end),classVariables2);

% Obtain binary data order in samples
data_1 = samples(1);
data_2 = samples(pos1(1)+1);

% Print results
fprintf("Total run(s): %d\n",totalRuns)
fprintf("%s's run(s): %d run(s)\n",num2str(data_1),sum(runs_1))
arrayfun(@(x,y) fprintf("Length = %d: %d run(s)\n",x,y),lengths_1,runs_1)
fprintf("\n")
fprintf("%s's run(s): %d run(s)\n",num2str(data_2),sum(runs_2))
arrayfun(@(x,y) fprintf("Length = %d: %d run(s)\n",x,y),lengths_2,runs_2)
end
```

```
Total run(s): 8
0's run(s): 4 run(s)
Length = 1: 2 run(s)
Length = 2: 2 run(s)

1's run(s): 4 run(s)
Length = 1: 2 run(s)
Length = 3: 1 run(s)
Length = 5: 1 run(s)
```

<br>

# Multiple categorical data

Similarly, for data consisting of $k$ distinct categories, a run is also defined as a sequence where a single value is repeated one or more times, and a new run occurs each time when the data value switches. For instance, iin he following categorical data series consisting of $k=3$ categories and $n=16$ values:

$$
\textcolor{red}{\underline{\text{A A}}}\ 
\textcolor{green}{\underline{\text{B}}}\ 
\textcolor{red}{\underline{\text{A}}}\ 
\textcolor{blue}{\underline{\text{C C C}}}\ 
\textcolor{red}{\underline{\text{A}}}\ 
\textcolor{green}{\underline{\text{B B B}}}\ 
\textcolor{blue}{\underline{\text{C}}}\ 
\textcolor{red}{\underline{\text{A A}}}\ 
\textcolor{blue}{\underline{\text{C}}}\ 
\textcolor{green}{\underline{\text{B}}}\label{eq3}
$$

there are:

1. $4$ runs for category $\textcolor{red}{\text{A}}$, whose lengths are $2$, $1$, $1$, and $2$;
2. $3$ runs for category $\textcolor{green}{\text{B}}$, whose lengths are $1$, $3$, and $1$;
3. $3$ runs for category $\textcolor{blue}{\text{C}}$, whose lengths are $3$, $1$, and $1$,

and therefore totally $10$ distinct runs could be found.

Obviously, "binary data" is a just a special case of "multiple categorical data". Therefore, starting from the implementation method of [Script 1](#script1), I rewrite the `helperCountRuns ` function, making it suitable for multi-category data series:

<div id="script2"></div>

```matlab
clc,clear,close all

samples = ["A","A","B","A","C","C","C","A",...
    "B","B","B","C","A","A","C","B"];

[totalRuns,runsInfo] = helperCountRuns(samples);

function [totalRuns,runsInfo] = helperCountRuns(samples)
% Count category number
categories = unique(samples);

% Calculate total runs
num = numel(samples);
idx1 = samples(1:num-1)~=samples(2:num);
totalRuns = sum(idx1)+1;

% Find each run slice
pos1 = find(idx1==1);
pos2 = [1,pos1+1];
pos1 = [pos1,num];
slices = arrayfun(@(x,y) samples(x:y),pos2,pos1,"UniformOutput",false);
categoryOfEachSlice = cellfun(@(x) categories(categories==unique(x)),slices);

% Count runs of each length
runsInfo = struct;
for i = 1:numel(categories)
    category = categories(i);
    runsInfo.("Category_"+category).("Category") = category;
    slice = slices(categoryOfEachSlice==category);
    [classVariables1,lengths_1] = findgroups(cellfun(@numel,slice));
    runs_1 = splitapply(@numel,slice,classVariables1);
    runsInfo.("Category_"+category).("Lengths") = lengths_1;
    runsInfo.("Category_"+category).("Runs") = runs_1;
end

% Print results
fprintf("Total run(s): %d\n",totalRuns)
for i = 1:numel(categories)
    category = categories(i);
    fprintf("%s's run(s): %d run(s)\n", ...
        runsInfo.("Category_"+category).("Category"),sum(runsInfo.("Category_"+category).("Runs")));
    arrayfun(@(x,y) fprintf("Length = %d: %d run(s)\n",x,y),runsInfo.("Category_"+category).("Lengths"),runsInfo.("Category_"+category).("Runs"));
    fprintf("\n")
end
end
```

```
Total run(s): 10
A's run(s): 4 run(s)
Length = 1: 2 run(s)
Length = 2: 2 run(s)

B's run(s): 3 run(s)
Length = 1: 2 run(s)
Length = 3: 1 run(s)

C's run(s): 3 run(s)
Length = 1: 2 run(s)
Length = 3: 1 run(s)
```

The function of  `helperCountRuns` defined in [Script 2](#script2) is more general that in [Script 1](#script1), therefore, it will be adopted in the following text. 

<br>

# Numeric data

For numerical data, two different kinds of runs can be computed: (1) "Runs above and below a reference value", and (2) "Runs up and down". The former is used in **Wald-Wolfwitz test**, while the latter is used in **computing the runs test for serial randomness**.

## Runs above and below a reference value

For numeric data, a *reference* is used to determine the runs in the data set relative to the reference. The reference value can be set as (1) statistics, like the mean, median, or mode of the data or as (2) any user-defined values. The reference value is used to create a binary series from the numeric data by assigning "1" to values above the reference and "0" to values below the reference. For example, for the following numeric data series consisting of $n=16$ values withe a median $28.5$ used as the reference value:


$$
\begin{equation}
\textcolor{green}{\underline{31}}\ 
\textcolor{red}{\underline{23}}\ 
\textcolor{green}{\underline{36\ 43\ 51\ 44}}\ 
\textcolor{red}{\underline{12\ 26}}\ 
\textcolor{green}{\underline{43\ 75}}\ 
\textcolor{red}{\underline{2\ 3\ 15\ 18}}\ 
\textcolor{green}{\underline{78}}\ 
\textcolor{red}{\underline{24}}\
\end{equation}
$$

$$
\begin{equation}
\textcolor{green}{\underline{1}}\ 
\textcolor{red}{\underline{0}}\ 
\textcolor{green}{\underline{1\ 1\ 1\ 1}}\ 
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1\ 1}}\ 
\textcolor{red}{\underline{0\ 0\ 0\ 0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{red}{\underline{0}}\ \label{eq2}
\end{equation}
$$

there are:

1. $4$ runs for category "$\textcolor{red}{\text{below}}$ reference value", whose lengths are $1$, $2$, $4$,  and $1$;
2. $4$ runs for category "$\textcolor{green}{\text{above}}$ reference value", whose lengths are $1$, $4$, $2$, and $1$,

and therefore totally $8$ distinct runs could be found:

```matlab
clc,clear,close all

samples = [31,23,36,43,51,44,12,26,...
    43,75,2,3,15,18,78,24];
samples = string(double(samples>median(samples)));
[totalRuns,runsInfo] = helperCountRuns(samples);
```

```
Total run(s): 8
0's run(s): 4 run(s)
Length = 1: 2 run(s)
Length = 2: 1 run(s)
Length = 4: 1 run(s)

1's run(s): 4 run(s)
Length = 1: 2 run(s)
Length = 2: 1 run(s)
Length = 4: 1 run(s)
```

As can be seen, this case $\eqref{eq2}$ is very similar to "binary data" case $\eqref{eq1}$, but there exists a slight difference, that is, for "numeric data" $\eqref{eq2}$, the third case, values equal to the reference, probably occurs.

### Handle values equal to the reference

When a value is exactly equal to the reference, a decision must be made whether to count it as "above" or "below" or whether to skip the value and discard it from the analysis.

For example, if we have a simple numeric data series with sample size $n=7$, and a median of $48$ is used as the reference value:

$$
\textcolor{red}{\underline{47\ 44}}\ 
\textcolor{green}{\underline{49}}\ 
\textcolor{black}{48}\ 
\textcolor{green}{\underline{50\ 51}}\ 
\textcolor{red}{45}
$$

and the fourth value in the series, $48$, is exactly equals to the reference. The resulting binary sequence is:

$$
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{black}{?}\ 
\textcolor{green}{\underline{1\ 1}}\ 
\textcolor{red}{0}
$$

If we just leave it in place and view it as "equal", we have a total of $4$ runs (only counting category $\textcolor{red}{0}$ and $\textcolor{green}{1}$):

```matlab
clc,clear,close all

samples = [47,44,49,48,50,51,45];
idx = samples == median(samples);
samples = string(double(samples>median(samples)));
samples(idx) = "equal";

[totalRuns,runsInfo] = helperCountRuns(samples);
```

```
Total run(s): 5
0's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 2: 1 run(s)

1's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 2: 1 run(s)

equal's run(s): 1 run(s)
Length = 1: 1 run(s)
```

If we view it as "$1$" (above), we have a total of $3$ runs:

$$
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{black}{\underline{1}}\ 
\textcolor{green}{\underline{1\ 1}}\ 
\textcolor{red}{0}
$$

```matlab
clc,clear,close all

samples = [47,44,49,48,50,51,45];
samples = string(double(samples>=median(samples)));
[totalRuns,runsInfo] = helperCountRuns(samples);
```

```
Total run(s): 3
0's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 2: 1 run(s)

1's run(s): 1 run(s)
Length = 4: 1 run(s)
```

If we view it as "$0$" (below), we have a total of $5$ runs:

$$
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{black}{\underline{0}}\ 
\textcolor{green}{\underline{1\ 1}}\ 
\textcolor{red}{0}
$$

```matlab
clc,clear,close all

samples = [47,44,49,48,50,51,45];
samples = string(double(samples>median(samples)));
[totalRuns,runsInfo] = helperCountRuns(samples);
```

```
Total run(s): 5
0's run(s): 3 run(s)
Length = 1: 2 run(s)
Length = 2: 1 run(s)

1's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 2: 1 run(s)
```

If we skip it and discard it, we have a total of $3$ runs:

$$
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1\ 1\ 1}}\ 
\textcolor{red}{0}
$$

```matlab
clc,clear,close all

samples = [47,44,49,48,50,51,45];
idx = samples == median(samples);
samples = string(double(samples>median(samples)));
samples(idx) = [];

[totalRuns,runsInfo] = helperCountRuns(samples);
```

```
Total run(s): 3
0's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 2: 1 run(s)

1's run(s): 1 run(s)
Length = 3: 1 run(s)
```

So, the treatment of these values on the reference line can have an impact on the number of runs and, therefore, on the results of hypothesis tests, particularly in the small-sample case. If the values before and after the value in question are on different sides of the reference line, it won't matter whether we count it as "above" or "below" since the run counts won't change, or rather, in this case, the choice is "non-critical". But, if the values before and after are on the same side, the run counts will depend on the way this value is treated, as described above. **A common practice is to see if the results change dramatically when these values are counted as "above" or as "below".** And, It is also *not uncommon* to skip these values.

## Runs up and down

To compute the runs up and down for $n$ numeric data values, the sign of the difference between each value and the one previous is recorded and used to create a binary series of $n-1$ signs. For example, for the following numeric data series consisting of $n=10$ values:

$$
\text{44, 40, 33, 26, 27, 44, 46, 54, 50, 51}
$$

the binary sequence of $n-1=9$ difference signs is:

$$
\textcolor{red}{\underline{-\ -\ -}}\ 
\textcolor{green}{\underline{+\ +\ +\ +}}\ 
\textcolor{red}{\underline{-}}\ 
\textcolor{green}{\underline{+}}
$$

There are:

1. $2$ runs for $\textcolor{red}{-}$, whose lengths are $3$ and $1$;
2. $2$ runs for $\textcolor{green}{+}$, whose lengths are $4$ and $1$,

and therefore totally $4$ distinct runs could be found:

```matlab
clc,clear,close all

samples = [44, 40, 33, 26, 27, 44, 46, 54, 50, 51];
signs = diff(samples);
idx_minus = signs<0;
idx_plus = signs>0;
signs = string(signs);
signs(idx_minus) = "minus";
signs(idx_plus) = "plus";

[totalRuns,runsInfo] = helperCountRuns(signs);
```

```
Total run(s): 4
minus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 3: 1 run(s)

plus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 4: 1 run(s)
```

<br>

### Handle tied values

Similarly, the case that two adjacent values are equal also has probabilities to occur, and in which case, we call these two values are "tied". If the values are tied, then a zero is recorded. A decision must be made whether to count the zero as "up ($+$)" or "down ($–$)" or  whether to skip it and discard it from the analysis.

For example, if the data series with $n = 11$ values is:

$$
\text{44, 40, 33, 26, 27, 44, 46, 54, 50, 50, 51}
$$

we could get corresponding sign series:

$$
\textcolor{red}{\underline{-\ -\ -}}\ 
\textcolor{green}{\underline{+\ +\ +\ +}}\ 
\textcolor{red}{\underline{-}}\ 
\textcolor{black}{0}\ 
\textcolor{green}{\underline{+}}
$$

If we just view the penultimate value as "0", we have a total of $4$ runs (only counting category $+$ and $-$):

```matlab
clc,clear,close all

samples = [44, 40, 33, 26, 27, 44, 46, 54, 50, 50, 51];
signs = diff(samples);
idx_minus = signs<0;
idx_plus = signs>0;
idx_zero = signs==0;
signs = string(signs);
signs(idx_minus) = "minus";
signs(idx_plus) = "plus";
signs(idx_zero) = "0";

[totalRuns,runsInfo] = helperCountRuns(signs);
```

```
Total run(s): 5
0's run(s): 1 run(s)
Length = 1: 1 run(s)

minus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 3: 1 run(s)

plus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 4: 1 run(s)
```

If we just view it as "+", we have a total of $4$ runs:

$$
\textcolor{red}{\underline{-\ -\ -}}\ 
\textcolor{green}{\underline{+\ +\ +\ +}}\ 
\textcolor{red}{\underline{-}}\ 
\textcolor{black}{\underline{+}}\ 
\textcolor{green}{\underline{+}}
$$

```matlab
clc,clear,close all

samples = [44, 40, 33, 26, 27, 44, 46, 54, 50, 50, 51];
signs = diff(samples);
idx_minus = signs<0;
idx_plus = signs>=0;
signs = string(signs);
signs(idx_minus) = "minus";
signs(idx_plus) = "plus";

[totalRuns,runsInfo] = helperCountRuns(signs);
```

```
Total run(s): 4
minus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 3: 1 run(s)

plus's run(s): 2 run(s)
Length = 2: 1 run(s)
Length = 4: 1 run(s)
```

and if we just view it as "$-$", we have a total of $4$ runs:

$$
\textcolor{red}{\underline{-\ -\ -}}\ 
\textcolor{green}{\underline{+\ +\ +\ +}}\ 
\textcolor{red}{\underline{-}}\ 
\textcolor{black}{\underline{-}}\ 
\textcolor{green}{\underline{+}}
$$

```matlab
clc,clear,close all

samples = [44, 40, 33, 26, 27, 44, 46, 54, 50, 50, 51];
signs = diff(samples);
idx_minus = signs<=0;
idx_plus = signs>0;
signs = string(signs);
signs(idx_minus) = "minus";
signs(idx_plus) = "plus";

[totalRuns,runsInfo] = helperCountRuns(signs);
```

```
Total run(s): 4
minus's run(s): 2 run(s)
Length = 2: 1 run(s)
Length = 3: 1 run(s)

plus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 4: 1 run(s)
```

In this example, this tie called a "non-critical tie"  since the runs are not influenced by the choice.

However, if we skip it and discard it:

$$
\textcolor{red}{\underline{-\ -\ -}}\ 
\textcolor{green}{\underline{+\ +\ +\ +}}\ 
\textcolor{red}{\underline{-}}\ 
\textcolor{green}{\underline{+}}
$$

```matlab
clc,clear,close all

samples = [44, 40, 33, 26, 27, 44, 46, 54, 50, 50, 51];
signs = diff(samples);
idx_minus = signs<0;
idx_plus = signs>0;
idx_zero = signs==0;
signs = string(signs);
signs(idx_minus) = "minus";
signs(idx_plus) = "plus";
signs(idx_zero) = [];

[totalRuns,runsInfo] = helperCountRuns(signs);
```

```
Total run(s): 4
minus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 3: 1 run(s)

plus's run(s): 2 run(s)
Length = 1: 1 run(s)
Length = 4: 1 run(s)
```

then there are still two runs up and two runs down for a total of four runs, **but the number if signs is  reduced to 9 instead of 10, which will influence test results.**

So, although not demonstrated by this example, the treatment of ties can have an impact on the run totals and, therefore, on the resulting hypothesis tests, particularly in small-sample case. If the signs before and after the tied values are different (like in this example) it won't matter whether we count the tie as "up" or "down" since the run counts won't change. This is called a "non-critical tie". On another hand, if the signs before and after the tie are the same, the run counts will depend on the way how the tie is treated. A common practice is to see if the results change dramatically when ties are counted as "up" as then as "down". It is also *not uncommon* to skip ties and exclude them from runs tests.

<br>

# Something else ...

At last, I what to explain why I decided to write this blog. The first reason is that, recently, I've been learning Wald-Wolfowitz Runs Test, where "run" is a basic notion, and this NCSS documentation [^2] indeed provides me a lot of information. Another motivation is that I think this notion may have relation to other more general notions and problems, because a data series seemingly corresponds a certain one-dimensional "topology". Actually, in 1979, Friedman and Rafsky [^4] generalized Wald-Wolfowitz test to multivariate case, using the notion of Minimal Spanning Tree in Graph theory, which may imply this idea. On another hand, when looking at these colorful data series, like $\eqref{eq1}$ and $\eqref{eq3}$, I feel it looks like a Graph Coloring Problem [^5]. Perhaps, there is a relationship between them. 

<br>

**References**

[^1]: [Statistical Software - NCSS](https://www.ncss.com/).
[^2]: [Analysis of Runs - NCSS](https://www.ncss.com/wp-content/themes/ncss/pdf/Procedures/NCSS/Analysis_of_Runs.pdf).
[^3]:[Wald-Wolfowitz runs test - Wikipedia](https://en.wikipedia.org/wiki/Wald%E2%80%93Wolfowitz_runs_test).
[^4]: J. H. Friedman and L. C. Rafsky, "Multivariate generalizations of the Wald-Wolfowitz and Smirnov two-sample tests," *Ann. Stat.*, vol. 7, no. 4, pp. 697-717, Jul. 1979, doi: [https://doi.org/10.1214/aos/1176344722.](https://doi.org/10.1214/aos/1176344722.)
[^5]: [Graph coloring - Wikipedia](https://en.wikipedia.org/wiki/Graph_coloring).
