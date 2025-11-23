---
title: Dependent Property and Its `get` Method and `set` Method of MATLAB `handle` Class
categories: 
 - MATLAB
tags: 
 - MATLAB Object-Oriented Programming
 - MATLAB Programming
date: 2023-01-26 18:33:31 +0800
last_modified_at: 2025-11-23 16:39:43 -0500
---

# Dynamic Calculation Properties

在实际编程中，有一些属性的值是依赖于其他属性的，当其他属性发生变化时，该属性也将相应地发生变化，这类属性通常称为Dependent属性（非独立属性）。例如，二维坐标中的点$p(x,y)$到原点的距离$r$可以表示成：

$$
r=\sqrt{x^2+y^2}
$$

$r$的值依赖于$x$和$y$。

一开始学习面对对象编程时，可能会编写出下面的代码：

```matlab
classdef Point2D < handle
    properties
        x
        y
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
            obj.r = sqrt(obj.x^2+obj.y^2);
        end
    end
end
```

但是这里的`r`值仅仅在Constructor中进行了计算，如果对象的`x`和`y`属性发生了变化，`r`值并不会随之改变。例如：

```matlab
% === Script ===
clc, clear, close all

p = Point2D(1,1);
disp([p.x, p.y, p.r])

p.x = 2;
p.y = 2;
disp([p.x, p.y, p.r])

% === Command line ===
1.0000    1.0000    1.4142

2.0000    2.0000    1.4142
```

一种很简单的做法是增加一个更新`r`的方法，当`x`或者`r`属性发生了改变就调用该方法更新：

```matlab
% === Point2D.m ===
classdef Point2D < handle
    properties
        x
        y
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
            CalculateR(obj);
        end
        function CalculateR(obj)
            obj.r = sqrt(obj.x^2+obj.y^2);
        end
    end
end

% === Script ===
clc, clear, close all

p = Point2D(1,1);
disp([p.x, p.y, p.r])

p.x = 2;
p.y = 2;
p.CalculateR();
disp([p.x, p.y, p.r])

% === Command line ===
1.0000    1.0000    1.4142

2.0000    2.0000    2.8284
```

但是很明显，如果这样设计程序，每次`x`和`y`属性发生改变都要调用`CalculateR`方法重新计算，这么做是很麻烦的，并且复杂一些得话，还需要编写监控`x`和`y`属性发生改变的函数。

一种解决方式是使用`Hanldle`类的Dependent属性和`get`方法实现属性的动态更新：

```matlab
classdef Point2D < handle
    properties
        x
        y
    end
    properties(Dependent)
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
        end
        function r = get.r(obj)
            r = sqrt(obj.x^2+obj.y^2);
            disp('get.r called');
        end
    end
end
```

在上面的用法中，对象内部并没有给Dependent属性分配物理的存储空间，而是**每次访问Dependent属性时，它们才有一个`get`方法动态计算出来**。

我们可以简单地通过脚本文件测试一下这样定义的效果：

```matlab
% === Script ===
p = Point2D(1,1);
disp([p.x, p.y, p.r])

p.x = 2;
p.y = 2;
disp([p.x, p.y, p.r])
disp([p.x, p.y, p.r])

p.x = 2;
p.y = 3;
disp([p.x, p.y])

% === Command line ===
get.r called
    1.0000    1.0000    1.4142

get.r called
    2.0000    2.0000    2.8284

get.r called
    2.0000    2.0000    2.8284

     2     3
```

可以看到：

（1）尽管`x`和`y`属性值不发生变化，我们再次访问`r`属性时，`r`属性所对应的`get`方法也会被重新调用；

（2）虽然`x`和`y`属性值发生了改变，但是如果我们不访问`r`属性，程序也不会调用`r.get`方法；但是，如果此时我们在工作空间中点开对象`p`：

![image-20230126143018838](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126143018838.png?raw=true)

可以看到实际上属性`r`的值已经重新进行了计算。

（3）用户每次查看对象`p`，程序都会调用`r.get`方法：

```matlab
>> p
p = 
get.r called
  Point2D with properties:
    x: 2
    y: 3
    r: 3.6056

>> p
p = 
get.r called
  Point2D with properties:
    x: 2
    y: 3
    r: 3.6056
```

<br>

# `set` and `get` of `Handle` Class

实际上，`get`方法是继承自`handle`类的一类方法，与此类似的还有`set`方法。`set`方法和`get`方法为**对象属性的赋值**和**对象属性的查询**提供了一个中间层。

## `set` Method

属性的`set`方法**通常用来检测属性的赋值是否符合要求**。例如：

```matlab
classdef A < handle
    properties
        a
    end
    methods
        function set.a(obj,val)
            if val >= 0
                obj.a = val;
                disp('Right value!')
            else
                error('a must be positive')
            end
        end
    end
end
```

**case 1：正确赋值**

```matlab
clc, clear, close all

Aobj = A();
Aobj.a = 10;
```

![image-20230126144925398](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126144925398.png?raw=true)

**case 2：错误赋值**

```matlab
clc, clear, close all

Aobj = A();
Aobj.a = -10;
```

程序报错：

![image-20230126144943600](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126144943600.png?raw=true)

**任何对属性`a`的赋值都会经过`set.a`的中间层**（由MATLAB负责调用）。

属性的`set`方法还常用于GUI的编写中。例如：假如某对象的某属性值来自于GUI界面上的用户输入值，那么在将用户输入值赋给该属性之前，就可以使用`set`方法检查该输入值（包括数据类型、阈值等）是否符合要求。

注：如果想要对函数的输入参数做更全面的系统的检查，可以使用`validateattributes`函数或者`inputParser`类。
{: .notice--primary}

## `get` Method

`get`方法提供对成员属性查询操作的一个中间层。例如：

```matlab
% === A.m ===
classdef A < handle
    properties
        b = 10;
    end
    methods
        function val = get.b(obj)
            val = obj.b;
            disp('getter called')
        end
    end
end

% === Command line ===
>> obj = A();
>> obj.b
getter called
ans =
    10
```

在类的外部，对属性`b`的查询（Query）都将经过这个中间方法。并且，和上面一样，一旦调用`A`类对象就会调用该`get`方法：

```matlab
>> obj
obj = 
getter called
  A with properties:
    b: 10
```

> 如果为两个属性都设置`get`方法，则两个`get`方法都会被调用：
>
> ```matlab
> % === A.m ===
> classdef A < handle
>     properties
>         a = 10;
>         b = 10;
>     end
>     methods
>         function val = get.a(obj)
>             val = obj.a;
>             disp('getter a called')
>         end
>         function val = get.b(obj)
>             val = obj.b;
>             disp('getter b called')
>         end
>     end
> end
> 
> % === Command line ===
> >> obj = A;
> >> obj
> obj = 
> getter a called
> getter b called
>   A with properties:
>     a: 10
>     b: 10
> ```

## Backward Compatibility of Programs

`set`方法和`get`方法为Dependent属性的赋值与查询操作定义了中间层，因此技术人员可以利用这一特性实现程序的向后兼容。

例如，最开始开发者定义了一个`Record`类，并且其中的一个属性`date`用来记录`Record`对象的时间：

```matlab
% === Record.m ===
classdef Record < handle
    properties
        date
    end
    methods
        function obj = Record(date)
            obj.date = date;
        end
    end
end

% === Script ===
R = Record(date);
disp(R.date)

% === Command line ===
26-Jan-2023
```

假设现在用户已经广泛使用了这个`Record`类，而技术人员想要修改升级`Record`类，例如想要把`Record`类中的`date`名字改得更有意义一些，比如叫做`timeStamp`。此时就可以提供一些`date`属性的中间层：

```matlab
classdef Record < handle
    properties
        timeStamp
    end
    properties(Dependent,Hidden)
        date
    end
    methods
        function obj = Record(timeStamp)
            obj.timeStamp = timeStamp;
        end
        function set.date(obj,val)
            obj.timeStamp = val;
        end
        function val = get.date(obj)
            val = obj.timeStamp;
        end
    end
end
```

面对此时的新版本，用户在外部初始化`Record`对象时，参数传递给`timeStamp`属性，并且推荐调用`timeStamp`属性查询记录日期：

```matlab
% === Command line ===
>> R = Record(date);
>> disp(R.timeStamp)
26-Jan-2023
```

另外，由于将`date`设置成为了Hidden属性，`timeStamp`属性成为了唯一的public属性：

```matlab
% === Command line ===
>> properties(R)
Properties for class Record:
    timeStamp
```

但尽管如此，老版本的程序同样可以运行：

```matlab
% === Command line ===
>> R = Record(date);
>> disp(R.date)
26-Jan-2023
```

只是此时程序会经过`get`方法中间层转而访问`timeStamp`属性。这样，旧程序能够不加修改而继续使用，实现了软件的向后兼容。

另外还需要注意一点，**类内部的赋值和查询也会调用`set`方法和`get`方法**。例如，我们在新版的Constructor中仍然给`date`属性赋值（有别于上面的给`timeStamp`属性赋值），并且直接查询此时的`date`属性和`timeStamp`属性：

```matlab
classdef Record < handle
    properties
        timeStamp
    end
    properties(Dependent,Hidden)
        date
    end
    methods
        function obj = Record(date)
            obj.date = date;
            disp("date: "+obj.date)
            disp("timeStamp: "+obj.timeStamp)
        end
        function set.date(obj,val)
            obj.timeStamp = val;
            disp("set method called")
        end

        function val = get.date(obj)
            val = obj.timeStamp;
            disp("get method called")
        end
    end
end
```

结果为：

![image-20230126155416730](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126155416730.png?raw=true)

可以看到，虽然我们在Constructor中给`date`属性赋值，但是程序仍然通过`set`方法**同样地**向`timeStamp`属性进行赋值；程序在解析`disp("date: "+obj.date)`中的`obj.date`时调用`get`方法，**转而**查询`timeStamp`属性值。

<br>

#  Dependent Property Features

在上文的`Pont2D`类的定义中：

```matlab
classdef Point2D < handle
    properties
        x
        y
    end
    properties(Dependent)
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
        end
        function r = get.r(obj)
            r = sqrt(obj.x^2+obj.y^2);
            disp('get.r called');
        end
    end
end
```

我们将变量`r`定义为了Dependent变量。实际上，这在我们上面所应用的场景中是不必要的。只要我们设置了`r.get`方法，就能够实现属性`r`的动态更新。例如：

```matlab
% === Point2D ===
classdef Point2D < handle
    properties
        x
        y
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
        end
        function r = get.r(obj)
            r = sqrt(obj.x^2+obj.y^2);
            disp('get.r called');
        end
    end
end

% === Command line ===
>> A = Point2D(1,1);
>> A.r
get.r called
ans =
    1.4142
>> A.x = 10;
>> A.r
get.r called
ans =
   10.0499
```

但是，当我们试图直接修改`r`的值（不合理的做法）时，两种定义的响应不同。

对于将`r`设置为Dependent属性的类（Class 1）：

```matlab
>> A = Point2D(1,1);
>> A.r = 10;
In class 'Point2D', no set method is defined for dependent property 'r'.  A dependent property needs a set method to assign its value.
```

对于将`r`设置为默认属性的类（Class 2）：

```matlab
>> A = Point2D(1,1);
>> A.r = 10;
>> A
A = 
get.r called
  Point2D with properties:
    x: 1
    y: 1
    r: 1.4142
```

可以看到，对于Class 1而言，程序会对“直接修改属性`r`”这一行为报错，报错信息提示我们：当我们没有为Dependent属性设置`set`方法时，程序无法直接给Dependent属性赋值；而对于Class 2，虽然语句`A.r = 10;`没有报错，但是也没有赋值，或者是赋值了，但是在我们调用的时候，程序又重新计算了`r`属性（我倾向于后者的情况）。

对比两种方法，我们会发现将`r`设置为Dependent属性更为合理，程序的报错信息会让我们去思考我们的程序设计是否有问题，以及是否完整地考虑了用户可能的行为。更进一步地，我们可以设置此时的`set`属性，向用户报出详细的报错信息。例如：

```matlab
% === Point2D ===
classdef Point2D < handle
    properties
        x
        y
    end
    properties(Dependent)
        r
    end
    methods
        function obj = Point2D(x0, y0)
            obj.x = x0;
            obj.y = y0;
        end
        function r = get.r(obj)
            r = sqrt(obj.x^2+obj.y^2);
            disp('get.r called');
        end
        function set.r(~,~)
            error("The value of 'r' cannot be assigned directly")
        end
    end
end

% === Command line ===
>> A = Point2D(1,1);
>> A.r = 10;
Error using Point2D/set.r
The value of 'r' cannot be assigned directly
```

上文程序向后兼容的例子就根据需要“向后兼容”的需要定义了Dependent属性`date`的`set`方法。

<br>

**References**

[1] 徐潇. MATLAB 面向对象编程: 从入门到设计模式. 北京航空航天大学出版社, 2017.