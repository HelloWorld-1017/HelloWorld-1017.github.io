The Terminology of Graph Theory









**Graph**: A graph consists of a set of **nodes** and set of node pairs called **edges**.

An edge **links** the two nodes defining it and it is **incident** on both of them.

The **degree** of a node is the number of edges incident on it.

A path between prescribed nodes as first and last elements, all other nodes distinct, and each edge linking the two nodes adjacent to it in the sequence. 

The **length** of a path is the number of edges it contains.

A connected graph has a path between any two distinct nodes.

A **cycle** is a path beginning and ending with the same node.

A **tree** is a connected graph with no cycles.

A **subgraph** of a given graph is a graph with all of its nodes and edges in the given graph.

**Connected subgraphs** of trees are trees and are called **subtrees**.

Subgraphs having no nodes in common are called **disjoint**; subgraphs having no edges in common are called **orthogonal**.

A **spanning subgraph** of a given graph is a subgaph with node set identical to the node set of the given graph.

A **spanning tree** of a graph is a spanning subgraph that is a tree.

There is a (unique) path between every two nodes in a tree, and thus a spanning tree of a (connected) graph provides a path between every two nodes of the graph.

An **edge weighted graph** is a graph with a real number assigned to each edge.

A **minimal spanning tree (MST)** of an edge weighted graph is a spanning tree for which the sum of edge weights is a minimum.













Theorem (1): An MST contains as as subgraph the “nearest neighbour graph”. That is, there is an edge linking each node and the node closet to it (or one of them if there are ties).

Theorem (2): If any edge of an MST is deleted, thereby dividing the graph into two disjoint connected subgraphs, and thus dividing the points into two disjoint subsets, the deleted edge weight is the smallest interpoint distance between the two subsets.

<br>

**References**

[1] J. H. Friedman and L. C. Rafsky, "Multivariate generalizations of the Wald-Wolfowitz and Smirnov two-sample tests," *Ann. Stat.*, (1979): 697-717.



