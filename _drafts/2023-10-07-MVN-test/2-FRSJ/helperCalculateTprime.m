function T_prime = helperCalculateTprime(X,Y)
N = height(X);
M = height(Y);

L = N+M;

mixed_XY = [X;Y];

idxs = nchoosek(1:L,2);
w = sqrt(sum((mixed_XY(idxs(:,1),:)-mixed_XY(idxs(:,2),:)).^2,2));

G = graph(idxs(:,1),idxs(:,2),w);
MST = minspantree(G, 'Method','sparse', 'Type','forest');

edges = MST.Edges.EndNodes;
T = 0;
for i = 1:height(edges)
    data = edges(i,:);
    if ((data(1)<=N) && (data(2)>N)) || ((data(2)<=N) && (data(1)>N))
        T = T+1;
    end
end
% C = 0;

% for i = 1:L
%     data = edges(:,1);
%     idx = data==i;
%     if sum(idx)>=2
%         C = C+height(nchoosek(1:sum(idx),2));
%     end
% end

C = 0;

NODES = unique(edges);
for i = 1:numel(NODES)
    data = NODES(i);
    degrees = sum(edges == data,"all");
    C = C+0.5*(degrees)*(degrees-1);
end

ET = (2*M*N)/L;
VarTC = (2*M*N)/(L*(L-1))*((2*M*N-L)/L+ ...
    (C-L+2)/((L-2)*(L-3))*(L*(L-1)-4*M*N+2));
T_prime = (T-ET)/(sqrt(VarTC));
end