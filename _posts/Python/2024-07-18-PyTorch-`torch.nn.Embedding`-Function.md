---
title: Realize Word Embedding by PyTorch `torch.nn.Embedding` Function
toc: false
categories:
 - Python
 - Machine Learning
tags:
 - Python PyTorch
 - Natural Language Processing
 - PyTorch Warnings and Errors
date: 2024-07-18 15:45:09 +0800
last_modified_at: 2024-07-18 18:16:00 +0800
---

In Natural Language Processing, a word embedding is a representation of a word[^1], and it is a common way to represent a word by a unique real-valued vector. Although there are some advanced techniques to make these ‘real-valued vectors’ look more reasonable, like making those words have similar meanings get closer in the vector space[^1], some simple ones are also popular. One way is by random vectors.

Suppose that in a specific task the number of unique words in all sentences is $n$, then we can create $n$ $m$-dimensional random vectors to represent these $n$ words respectively, and hence get a $n$-by-$m$ random matrix (so-called a ‘completed’ dictionary). For such random matrix, a word corresponds a row vector and therefore a row index. On the other hand, every sentence in this application scenario can be represented as a row index series (because we make the dictionary complete); by replacing these indexes with corresponding random row vectors, a word embedding process is completed. 

In Python PyTorch framework, `torch.nn.Embedding` function[^2] is to create such $n$-by-$m$ random matrix:

<div class="quote--left" markdown="1">

**`torch.nn.Embedding`**

A simple lookup table that stores embeddings of a fixed dictionary and size.

This module is often used to store word embeddings and retrieve them using indices. The input to the module is a list of indices, and the output is the corresponding word embeddings.

</div>

An example shows as follows.

```python
import torch
import torch.nn as nn
torch.manual_seed(17) # For reproductivity

sentences = torch.LongTensor([[1, 2, 4, 5], [4, 3, 2, 9]])
print(sentences)
print(sentences.size())
```

```
tensor([[1, 2, 4, 5],
        [4, 3, 2, 9]])
torch.Size([2, 4])
```

```python
embedding = nn.Embedding(10, 3)
print(embedding.weight)
print(embedding(sentences))
print(embedding(sentences).size())
```

```
Parameter containing:
tensor([[-1.0462,  1.2305,  1.8662],
        [-0.3435,  0.0675,  0.4481],
        [-0.5986,  0.2515,  0.2113],
        [ 0.1331,  0.2522,  0.3827],
        [ 0.2344,  1.1805, -0.1851],
        [-0.4297,  0.1519, -0.1700],
        [-0.0601, -0.6294, -1.3345],
        [ 1.2675,  0.0667,  1.7792],
        [ 0.7402,  1.1313, -2.5713],
        [ 1.4333,  1.1304, -1.0084]], requires_grad=True)
tensor([[[-0.3435,  0.0675,  0.4481],
         [-0.5986,  0.2515,  0.2113],
         [ 0.2344,  1.1805, -0.1851],
         [-0.4297,  0.1519, -0.1700]],

        [[ 0.2344,  1.1805, -0.1851],
         [ 0.1331,  0.2522,  0.3827],
         [-0.5986,  0.2515,  0.2113],
         [ 1.4333,  1.1304, -1.0084]]], grad_fn=<EmbeddingBackward0>)
torch.Size([2, 4, 3])
```

In this example, we can see that:

-  An embedding named `embedding` is created by `torch.nn.Embedding` function, and a 10-by-3 random matrix is created and stored in `embedding.weight` attribute. 
- This 10-by-3 random matrix is the dictionary, which means that in this example there are 10 words in total, and each word is represented by a 3-dimensional row vector.
- Variable `sentences` is a 2-by-4 tensor, which represents two sentences with 4 words. And, both two sentences have been indexed in advance (as described before, these indexes are row indexes of corresponding words).
- `embedding(sentences)` is the final mapping process, that is find out each specific row vector in `embedding` by each index in `sentences` and then put it in the resulting matrix. At last, a 2-by-4-by-3 matrix is constructed to represent the two sentences in variable `sentences`.

And of course, if the number of words in dictionary (`9` in the following case) is less than the maximum index in the sentences plus 1 (`10`), an error will occur:

```python
import torch
import torch.nn as nn
torch.manual_seed(17) # For reproductivity

sentences = torch.LongTensor([[1, 2, 4, 5], [4, 3, 2, 9]])
embedding = nn.Embedding(9, 3)
embedding(sentences)
```

```
---------------------------------------------------------------------------
IndexError                                Traceback (most recent call last)
Cell In[6], line 7
      5 sentences = torch.LongTensor([[1, 2, 4, 5], [4, 3, 2, 9]])
      6 embedding = nn.Embedding(9, 3)
----> 7 embedding(sentences)

...
...

IndexError: index out of range in self
```

<br>

**References**

[^1]: [Word embedding - Wikipedia](https://en.wikipedia.org/wiki/Word_embedding).
[^2]: [`torch.nn.Embedding` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.nn.Embedding.html).

