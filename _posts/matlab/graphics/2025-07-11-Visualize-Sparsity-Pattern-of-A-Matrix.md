---
title: Visualize Sparsity Pattern of A Matrix by MATLAB `spy` Function
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
date: 2025-07-11 13:14:10 +0800
last_modified_at: 2025-07-11 13:14:10 +0800
---

MATLAB `spy` function is to “visualize sparsity pattern of matrix”[^1], for example:

```matlab
clc, clear, close all

[B, ~] = bucky;
spy(B, 'r.', 10)

exportgraphics(gca, "fig.jpg", "Resolution", 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111517781.jpg" alt="fig" style="width:50%;" />

where the `bucky` function is to generate a bucky ball adjacency matrix, which is a 60-by-60 symmetric sparse matrix with only 180 nonzero elements (the density of this matrix is 5%)[^2].

<br>

Alternatively, I think maybe we can use another function, `imagesc`, to realize a similar effect (refer to[^3]):

```matlab
clc, clear, close all

[B, ~] = bucky;
imagesc(B)
% colorbar

exportgraphics(gca, "fig.jpg", "Resolution", 600)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111530488.jpg" alt="fig" style="width:50%;" />

Besides, `format +` is another way, a text-based alternative, to display the nonzero structure of a matrix[^1]:

```matlab
clc, clear, close all

[B, ~] = bucky;
B = full(B);

format +
B
```

```
 +  ++                                                      
+ +       +                                                 
 + +           +                                            
  + +               +                                       
+  +                     +                                  
+     +  +                                                  
     + +                     +                              
      + +                                +                  
       + +                           +                      
     +  +  +                                                
 +         +  +                                             
         ++ +                                               
           + +                      +                       
            + +                 +                           
          +  +  +                                           
  +             +  +                                        
              ++ +                                          
                + +            +                            
                 + +                                +       
               +  +  +                                      
   +                 +  +                                   
                   ++ +                                     
                     + +                           +        
                      + +                      +            
                    +  +  +                                 
    +                     +  +                              
                        ++ +                                
                          + +                 +             
                           + +            +                 
      +                  +  +                               
                               +  +                  +      
                 +            + +                           
             +                 + +                          
                                + ++                        
                              +  +                     +    
                                 +  +  +                    
            +                      + +                      
        +                           + +                     
                                     + ++                   
                                   +  +                 +   
                                      +  +  +               
       +                                + +                 
                            +            + +                
                                          + ++              
                                        +  +             +  
                                           +  +  +          
                           +                 + +            
                       +                      + +           
                                               + ++         
                                             +  +         + 
                                                +  +  +     
                      +                           + +       
                  +                                + +      
                              +                     + +     
                                                  +  +     +
                                  +                     +  +
                                       +               + +  
                                            +           + + 
                                                 +       + +
                                                      ++  + 
```

<br>

**References**

[^1]: [MATLAB `spy`: Visualize sparsity pattern of matrix](https://www.mathworks.com/help/matlab/ref/spy.html).
[^2]: [Graphs and Matrices](https://www.mathworks.com/help/matlab/math/graphs-and-matrices.html).
[^3]: [Wishart Distribution, Inverse-Wishart Distribution, Normal-Inverse-Wishart Distribution](/2022-10-22/14-29-56.html).
