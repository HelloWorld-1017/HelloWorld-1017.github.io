clc, clear, close all

xp  = linspace(0, 10, 100);
mus = [1, 2, 4, 8];
pdfs = bsxfun(@(x, mu) exppdf(x, mu), xp', mus);
cdfs = bsxfun(@(x, mu) expcdf(x, mu), xp', mus);

nexttile
plot(repmat(xp', 1, width(pdfs)), pdfs, LineWidth=1.5);
legend('$1/\lambda=1$', '$1/\lambda=2$', ...
    '$1/\lambda=4$', '$1/\lambda=8$', ...
    Interpreter="latex", Location='best')
xlabel('x')
ylabel('PDF')
title('PDFs of Exponential Distribution')
grid on

nexttile
plot(repmat(xp', 1, width(cdfs)), cdfs, LineWidth=1.5);
legend('$1/\lambda=1$', '$1/\lambda=2$', ...
    '$1/\lambda=4$', '$1/\lambda=8$', ...
Interpreter="latex", Location='best')
xlabel('x')
ylabel('CDF')
title('Corresponding CDFs of Exponential Distribution')
grid on
