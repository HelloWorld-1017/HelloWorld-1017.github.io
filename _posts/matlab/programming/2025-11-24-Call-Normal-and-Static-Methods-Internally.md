---
title: Call Ordinary (Nonstatic) Methods and Static Methods in the MATLAB Class Definition File
categories:
 - MATLAB
tags:
 - MATLAB Programming
 - MATLAB Object-Oriented Programming
location: Buffalo, United States
date: 2025-11-24 17:34:32 -0500
last_modified_at: 2025-11-28 19:29:17 -0500
published: false
---

# Call ordinary (nonstatic) methods

In a MATLAB class, there are two ways to call the class's ordinary (nonstatic) method[^1]. For example, in the following case:

Class file `AddClass.m`:

```matlab
classdef AddClass < handle
    properties
        initialPoint = 0;
        finalValue = 0;
    end

    methods
        function obj = AddClass(value)
            obj.initialPoint = value;
        end

        function testHelperAdd(obj, addedvalue)
            % Method 1
            obj.helperAdd(addedvalue);

            % Method 2
            helperAdd(obj, addedvalue);
        end

        function  helperAdd(obj, addedvalue)
            obj.finalValue = obj.finalValue+addedvalue;
        end
    end
end
```

Script file `script.m` to instantiate class and call method method:

```matlab
clc, clear, close all

a = AddClass(0);
a.testHelperAdd(3);
a.finalValue
```

After running the script file, we'll get result:

```
ans =
     6
```

As can be seen, in the `testHelperAdd` method of defined class `AddClass`, we use two ways to call another class method, `helperAdd`:

- `obj.helperAdd(addedvalue);`
- `helperAdd(obj, addedvalue);`

Because `helperAdd` is an ordinary method[^1], when we call it internally, we need to pass the object variable `obj`. Above two syntax can realize this point. Either using dot notation, `obj.`, or making the object variable as the first argument to be passed.

However, it should be noted, if we combine the both ways, i.e.,

```
obj.helperAdd(obj, addedvalue);
```

then we'll get an error

```
Error using AddClass/helperAdd
Too many input arguments.
Error in AddClass/testHelperAdd (line 19)
            obj.helperAdd(obj, addedvalue);
Error in script (line 4)
a.testHelperAdd(3); 
```

this is because we pass the object variable `obj` twice, and `addedvalue` is viewed as redundant.

<br>

# Call static methods

By the way, a static method "do not require an object of the class as an input argument"[^2], so we don't need to include an explicit object variable as a function argument as nonstatic method[^1]. That being said, when we call it in the class definition file, we still need to pass the object variable `obj`, and ONLY dot-donation syntax is supported. For example:

```matlab
classdef AddClass < handle
    properties
        initialPoint = 0;
        finalValue = 0;
    end

    methods
        function obj = AddClass(value)
            obj.initialPoint = value;
        end

        function testHelperAdd(obj, addedvalue)
            % Method 1
            obj.helperAdd(addedvalue);

            % Method 2
            helperAdd(obj, addedvalue);

            % Call the static method
            obj.helperDisp();
        end

        function  helperAdd(obj, addedvalue)
            obj.finalValue = obj.finalValue+addedvalue;
        end
    end

    methods (Static)
        % Define a static method
        function helperDisp
            disp('This is a static method.')
        end
    end
end
```

```matlab
clc, clear, close all

a = AddClass(0);
a.testHelperAdd(3)
a.finalValue
```

```
This is a static method.
ans =
     6
```

<br>

In addition, we can directly call the static function in the script file, without need to instantiate the class:

```matlab
clc, clear, close all

AddClass.helperDisp();
```

```
This is a static method.
```

<br>

**References**

- [Methods in Class Design](https://www.mathworks.com/help/matlab/matlab_oop/how-to-use-methods.html).

[^1]: [Ordinary Methods](https://www.mathworks.com/help/matlab/matlab_oop/ordinary-methods.html).
[^2]: [Static Methods](https://www.mathworks.com/help/matlab/matlab_oop/static-methods.html).
