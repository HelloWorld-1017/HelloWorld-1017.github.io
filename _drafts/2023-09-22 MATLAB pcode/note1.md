MATLAB `.p` file is a content-obscured version of source file `.m` file [1], and it is commonly used in some scenarios where technicians only want to share some functions they have realised using MATLAB with other people, rather than the whole source code. This usually occurs during the procession of cooperation between different companies or organizations as some technologies are patented and protected by intellectual property.

The conversion of `.p` file from `.m` source file is very easy using MATLAB `pcode` function [2], and the performance of both files is equivalent [1]. 

![image-20230922165851519](https://raw.githubusercontent.com/Ma1017/blog-images/main/imgs/image-20230922165851519.png)



```
codegen myfunc -config:lib -args {1};
```

<br>

**References**

[1] [Create a Content-Obscured File with P-Code - MathWorks China](https://ww2.mathworks.cn/help/matlab/matlab_prog/building-a-content-obscured-format-with-p-code.html).

[2] [pcode - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/pcode.html).

[3] [codegen - MathWorks](https://ww2.mathworks.cn/help/coder/ref/codegen.html).