---
title: Terminologies in Graph Theory
categories:
 - Mathematics
 - Collections
tag:
 - Graph Theory
date: 2023-10-20 22:08:34 +0800
last_modified_at: 2024-09-06 08:18:30 +0800
---

Recently, I've been learning multivariate normality test. During this process, I found Friedman-Rafsky test, which is proposed by J. H. Friedman and L. C. Rafsky in 1979[^1]. Friedman and Rafsky generalised Wald-Wolfowitz test and Smirnov two-sample test to multivariate case, by replacing the notion of univariate sorted list by **Minimal Spanning Tree** in graph theory. I think this generalisation is really artful and inspiring. I ever know the graph theory is an important branch of mathematics, but I rarely use it. The Friedman and Rafsky's paper gave a brief introduction about some terminology of graph theory, so I recorded down here, and more basic knowledge will be added if I meet it in the future.
{: .notice--warning}

# Terminologies

- A **graph** consists of a set of **nodes** and a set of node pairs called **edges**.
- An edge **links** the two nodes defining it and it is **incident** on both of them.
- The **degree** of a node is the number of edges incident on it.
- A **path** between two prescribed nodes is an alternating sequence of nodes and edges with the prescribed nodes as first and last elements, all other nodes distinct, and each edge linking the two nodes adjacent to it in the sequence. 
- The **length** of a path is the number of edges it contains.
- A **connected graph** has a path between any two distinct nodes.
- A **cycle** is a path beginning and ending with the same node.
- A **tree** is a connected graph with no cycles.
- A **subgraph** of a given graph is a graph with all of its nodes and edges in the given graph.
- **Connected subgraphs** of trees are trees and are called **subtrees**.
- Subgraphs having no nodes in common are called **disjoint**; subgraphs having no edges in common are called **orthogonal**
- A **spanning subgraph** of a given graph is a subgraph with node set identical to the node set of the given graph.
- A **spanning tree** of a graph is a spanning subgraph that is a tree.
- There is a (unique) path between every two nodes in a tree, and thus a spanning tree of a (connected) graph provides a path between every two nodes of the graph.
- An **edge weighted graph** is a graph with a real number assigned to each edge.
- A **minimal spanning tree (MST)** of an edge weighted graph is a spanning tree for which the sum of edge weights is a minimum.

<br>

# Theorems

- Theorem 1: An MST contains as a subgraph the “nearest neighbour graph”. That is, there is an edge linking each node and the node closet to it (or one of them if there are ties).

The edge between two nodes can also be called a **tie**[^2].
{: .notice--primary}

- Theorem 2: If any edge of an MST is deleted, thereby dividing the graph into two disjoint connected subgraphs, and thus dividing the points into two disjoint subsets, the deleted edge weight is the smallest interpoint distance between the two subsets.

<br>

**References**

[^1]: J. H. Friedman and L. C. Rafsky, "Multivariate generalizations of the Wald-Wolfowitz and Smirnov two-sample tests," *Ann. Stat.*, (1979): 697-717.
[^2]: [Glossary of SNA Terms - People of Medieval Scotland](https://www.poms.ac.uk/help/social-network-analysis/glossary-of-sna-terms/).
