`glyphplot` and `andrewplot`







```matlab
% Compute the terms for the curves.  The constant term goes with the first
% column of X, the lowest freq sin with the 2nd, the lowest freq cos with
% the third, and so on.
t = 0:.001:1;
omega = 2*pi*(1:floor(p/2));
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = X(:,[1 (2:2:p) (3:2:p)])*A;
```

<br>

**References**

https://ww2.mathworks.cn/help/stats/glyphplot.html

https://ww2.mathworks.cn/help/stats/andrewsplot.html

%  References:
 %   [1] Gnanadesikan, R. (1977) Methods for Statistical Data Analysis of Multivariate Observations, Wiley.
 %   [2] Chernoff, H. (1973) "The Use of Faces to Represent Points in k-Dimensional Space Graphically", J.Am.Stat.Assoc. 68:361-368.

https://en.wikipedia.org/wiki/Andrews_plot



