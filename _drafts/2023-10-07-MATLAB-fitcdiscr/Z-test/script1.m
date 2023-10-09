clc,clear,close all

rng(1)

num = 1000;
mu_bar = 0.1;
sigma_bar =1.1;
data = sigma_bar*randn(1,num)+mu_bar;

mu = 0;
sigma = 1;
[h,p,ci,zval] = ztest(data,mu,sigma)

disp((mean(data)-mu)/(sigma/sqrt(num)))

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
x = -10:0.1:10;
plot(x,normpdf(x,mu,sigma),"LineWidth",1.5,"DisplayName","Test norm")
plot(x,normpdf(x,mu_bar,sigma_bar),"LineWidth",1.5,"DisplayName","Real norm")
low_alpha = norminv(0.025,0,1);
stem([low_alpha,-low_alpha], ...
    [normpdf(low_alpha),normpdf(-low_alpha)],"filled","Color","k");
legend();

pp = 2*normcdf(-abs(zval),0,1)

mean(data)+sigma*low_alpha/sqrt(num)
mean(data)-sigma*low_alpha/sqrt(num)

% normcdf(zval,0,1)

% icdf("norm",0.025,0,1)

