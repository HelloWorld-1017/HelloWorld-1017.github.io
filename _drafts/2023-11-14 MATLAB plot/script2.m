clc,clear,close all

rng("default")

dataLength = 10;
t = 1:dataLength;
numPerClass = [7,7,7];
data = randn(sum(numPerClass),dataLength);
labels = [repmat("a",numPerClass(1),1);
    repmat("b",numPerClass(2),1);
    repmat("c",numPerClass(3),1)];
Classes = unique(labels);

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
colors = get(gca,"ColorOrder");

% Initialize array for graphics objects with legends
legendh = gobjects(numel(Classes),1);

for i = 1:numel(Classes)
    color = colors(mod(i-1,height(colors))+1,:);
    data_per_class = data(labels==Classes(i),:);
    lines = plot(t,data_per_class,"Color",color,"LineWidth",1.5);
    
    % Store the line object needing legend
    legendh(i) = lines(1);
end
legend(legendh,Classes);

