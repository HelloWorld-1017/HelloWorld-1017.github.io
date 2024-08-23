---
title: THE ZEN OF PYTHON
toc: false
categories:
 - Python
 - Philosophy
tags:
 - Native Python
 - <i>Python Crash Course</i>
date: 2024-05-29 21:22:52 +0800
last_modified_at: 2024-08-21 04:13:18 +0800
---

By entering `import this`, we can get “The Zen of Python”[^1][^2] by Tim Peters:

```python
import this
```

```
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
```

<br>

<div class="quote--left" markdown="1">

```
There should be one-- and preferably only one --obvious way to do it.
```

If two Python programmers are asked to solve the same problem, they  should come up with fairly compatible solutions. This is not to say there’s no room for creativity in programming. On the contrary! But much of programming consists of using small, common approaches to simple situations within a larger, more creative project. The nuts and bolts of your programs should make sense to other Python programmers.[^3]

</div>

<div class="quote--left" markdown="1">

```
Now is better than never.
```

You could spend the rest of your life learning all the intricacies of Python and of programming in general, but then you’d never complete any projects. <i class="emphasize">Don’t try to write perfect code</i>; <i class="emphasize">write code that works</i>, and then decide whether to improve your code for that project or move on to something new.[^3]

</div>

<div class="quote--left" markdown="1">
**Model Real-World Objects**[^4]

... This brings you to an interesting point in your growth as a programmer. When you wrestle with questions like these, you’re thinking at a higher logical level rather than a syntax-focused level. You’re thinking not about Python, but about how to represent the real world in code. When you reach this point, <i class="emphasize">you’ll realize there are often no right or wrong approaches to modeling real-world situations</i>. Some approaches are more efficient than others, but it takes practice to find the most efficient representations. <i class="emphasize">If your code is working as you want it to, you’re doing well!</i> Don’t be discouraged if you find you’re ripping apart your classes and rewriting them several times using different approaches. In the quest to write accurate, efficient code, everyone goes through this process.

</div>

<div class="quote--left" markdown="1">

**Finding Your Own Workflow**[^5]

As you can see, Python gives you many options for how to structure code in a large project. It’s important to know all these possibilities so you can determine the best ways to organize your projects as well as understand other people’s projects.

<i class="emphasize">When you’re starting out, keep your code structure simple.</i> Try doing everything in one file and moving your classes to separate modules once everything is working. If you like how modules and files interact, try storing your classes in modules when you start a project. <i class="emphasize">Find an approach that lets you write code that works, and go from there.</i>

</div>

**References**

[^1]: [PEP 20 – The Zen of Python \| peps.python.org](https://peps.python.org/pep-0020/).
[^2]: Software engineer Tim Peters wrote this set of principles and posted it on the Python mailing list in 1999. [Zen of Python - Wikipedia](https://en.wikipedia.org/wiki/Zen_of_Python).
[^3]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 30-31.
[^4]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, p. 173.
[^5]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, p. 179.
