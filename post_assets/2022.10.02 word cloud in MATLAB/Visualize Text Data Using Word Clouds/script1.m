clc, clear, close all

filename = "factoryReports.csv";
tbl = readtable(filename, 'TextType', 'string');

textData = tbl.Description;

figure
wordcloud(textData);
title("Factory Reports")

figure
labels = tbl.Category;
subplot(1,2,1)
idx = labels == "Leak";
wordcloud(textData(idx), 'Color', 'blue');
title("Leak")
subplot(1,2,2)
idx = labels == "Mechanical Failure";
wordcloud(textData(idx), 'Color', 'magenta');
title("Mechanical Failure")

cost = tbl.Cost;
idx = cost > 100;
figure
tiledlayout(1,2)
nexttile
wordcloud(textData(idx), 'HighlightColor', 'blue');
title("Cost > $100")
idx = cost > 1000;
nexttile
wordcloud(textData(idx), 'HighlightColor', 'red');
title("Cost > $1,000")

figure
wc = wordcloud(textData);
wc.MaxDisplayWords = 3;
title("Factory Reports")
