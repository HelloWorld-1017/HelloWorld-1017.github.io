clc,clear,close all
rng(7)

num = 10;
data = [randn(num,1),randn(num,1)];

idxs = nchoosek(1:height(data),2);
w = sqrt(sum((data(idxs(:,1),:)-data(idxs(:,2),:)).^2,2));

G = graph(idxs(:,1),idxs(:,2),w);
MST_Kruskal = minspantree(G,'Method','sparse');
MST_Prim = minspantree(G,'Type','forest');

figure
tiledlayout(1,2)
nexttile
p_Kruskal = plot(G,'EdgeLabel',G.Edges.Weight);
highlight(p_Kruskal,MST_Kruskal)

nexttile
p_Prim = plot(G,'EdgeLabel',G.Edges.Weight);
highlight(p_Prim,MST_Prim)


