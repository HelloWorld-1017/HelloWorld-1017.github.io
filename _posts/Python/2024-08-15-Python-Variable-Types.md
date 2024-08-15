---
title: "Python Variable Types: string, integer, float, and constant"
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
 - Numerical Analysis
 - Python decimal
date: 2024-08-15 10:04:56 +0800
last_modified_at: 2024-08-15 10:04:56 +0800
---

This post is a record made while learning Chapter 2 “Variables and Simple Data Types” in Eric Matthes’s book, Python Crash Course.[^1]
{: .notice--primary}

# String

## Create a string

A string is a series of characters, and anything inside quotes (single or double quotes) is considered a string in Python:


```python
"This is a string.", 'This is also a string.'
```


    ('This is a string.', 'This is also a string.')

This flexibility make it is easy to use quotes and apostrophes in a string:


```python
'I told my friend, "Python is my favorite language!"', "The language 'Python' is named after Monty Python, not the snake.", "One of Python's strengths is its diverse and supportive community."
```


    ('I told my friend, "Python is my favorite language!"',
     "The language 'Python' is named after Monty Python, not the snake.",
     "One of Python's strengths is its diverse and supportive community.")

## Change case in a string: `title()`, `upper()`, and `lower()`

`title()` method changes each word to title case, namely the first letter of each word uppercase and other letters lowercase.


```python
name = "aDA loVeLAce"
print(name.title())
```

    Ada Lovelace

```python
print("Ada".title(), "ADA".title(), "ada".title())
print("Ada".title() == "ADA".title(), "ADA".title() == "ada".title())
```

```
Ada Ada Ada
True True
```

Similarly, we can change a string to all uppercase by `upper()` method, and all lowercase by `lower()` method:


```python
name = "aDA loVeLAce"
print(name.upper())
print(name.lower())
```

    ADA LOVELACE
    ada lovelace

On the other hand, we should note that `title()`, `upper()`, and `lower()` methods won’t change the value that was originally stored in `name`:

```python
name = "aDA loVeLAce"
name.title()
print(name)

name = "aDA loVeLAce"
name.upper()
print(name)

name = "aDA loVeLAce"
name.lower()
print(name)
```

```
aDA loVeLAce
aDA loVeLAce
aDA loVeLAce
```

## Use variables in a string (*f-string*)

To insert a variable’s value into a string, place the letter “f” immediately before the opening quotation mark, and put braces around the name or names of any variable to be inserted:


```python
first_name = "ada"
last_name = "lovelace"
full_name = f"{first_name} {last_name}"
print(full_name)
print(f"Hello, {full_name.title()}!")
```

    ada lovelace
    Hello, Ada Lovelace!

These strings are called f-strings. The “f” is for format, because Python *formats* the string by replacing the name of any variable in braces with its value.

F-strings were first introduced in Python 3.6. In an earlier-version Python, we need to use the `format()` method rather than f-strings:


```python
full_name = "{} {}".format(first_name, last_name)
print(full_name)
```

    ada lovelace


## Add whitespace (tabs or newlines) to a string: `\t` and `\n`

In programming, *whitespace* refers to any nonprinting character, such as spaces, tabs, and end-of-line symbols.

To add a tab in a string, use the character combination `\t`; to add a newline, use the character combination `\n`:

```python
print("Languages:\n\tPython\n\tC\n\tJavaScript") 
```

    Languages:
    	Python
    	C
    	JavaScript

## Strip whitespace from a string: `rstrip()`, `lstrip()`, and `strip()`

Strip the extra whitespace on the right side of a string by `rstrip()` method, left ones by `lstrip()`, and both side by `strip()`:

```python
favorite_language = ' python '
favorite_language.rstrip(), favorite_language.lstrip(), favorite_language.strip()
```

```
(' python', 'python ', 'python')
```

However, it should be noted that the whitespace is only removed from the string temporarily. To make whitespace removed permanently, we should associate the stripped value with the variable name, like:


```python
favorite_language = 'python '
favorite_language = favorite_language.rstrip()
favorite_language
```


    'python'

In the real world, these stripping functions are often used to clean up user input before it’s stored in a program.

<br>

# Number

## Integer


```python
2+3, 3-2, 2*3, 3/2
```


    (5, 1, 6, 1.5)

In Python, two multiplication symbols are used to represent exponents:


```python
3 ** 2, 3 ** 3, 10 ** 6
```


    (9, 27, 1000000)

## Float

Python calls any number with a decimal point a float. This term is used in most programming languages, and it refers to the fact that a decimal point can appear at any position in a number.


```python
0.1 + 0.1, 0.2 + 0.2, 2 * 0.1, 2* 0.2
```


    (0.2, 0.4, 0.2, 0.4)

But sometimes we’ll get an arbitrary number of decimal places:


```python
(0.2 + 0.1), (3 * 0.1), (0.2 + 0.1 == 0.3), (3 * 0.1 == 0.3), (0.2 + 0.1) == (3 * 0.1)
```


    (0.30000000000000004, 0.30000000000000004, False, False, True)

This problem has to do with floating point representation[^4], and happens in all languages and is usually of little concern. A remedy to it is using native Python `decimal` module[^2][^3]:

```python
from decimal import *

a, b, c = Decimal('0.1'), Decimal('0.2'), Decimal('0.3')
a+b == c
```

```
True
```

## Mix integer and float in an operation

Python defaults to a float in any operation that uses a float, even if the output is a whole number (integer):


```python
4/2, 1 + 2.0,  2 * 3.0, 3.0 ** 2
```


    (2.0, 3.0, 6.0, 9.0)

## Underscores in number

Group digits using underscores to make large numbers more readable:

```python
universe_age = 14_000_000_000
universe_age1 = 14_000000000
print(universe_age, universe_age1)
print(universe_age == universe_age1)

universe_age2 = 1_4000000000.12_342
print(universe_age2)
```

```
14000000000 14000000000
True
14000000000.12342
```


As can be see, this feature works for both integer and float, but only available in Python 3.6 and later.

<br>

# Constant

A constant is like a variable whose value stays the same throughout the life of a program. Python doesn’t have built-in constant types, but Python programmers commonly use *all capital letters* to indicate a variable should be treated as a constant and never be changed:


```python
MAX_CONNECTIONS = 5000
print(MAX_CONNECTIONS)
```

    5000

<br>

# Make a long number readable

Method 1: by exponents

```python
1.234 * 10 ** 10
```

```
12340000000.0
```

Method 2: by inserting underscores

```python
12_340_000_000.0
```

```
12340000000.0
```

Method 3 (preferable): by scientific notation

```python
print(1.234e10)
print(1.234E10)
print(float("1.234e10"))
print(float("1.234E10"))
print(float('1.234e10'))
print(float('1.234E10'))
```

```
12340000000.0
12340000000.0
12340000000.0
12340000000.0
12340000000.0
12340000000.0
```

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 15-32.
[^2]: [python - Why doesn't 0.1+0.2-0.3 equal 0.0? - Stack Overflow](https://stackoverflow.com/questions/74139295/why-doesnt-0-10-2-0-3-equal-0-0).
[^3]: [decimal — Decimal fixed-point and floating-point arithmetic — Python 3.12.5 documentation](https://docs.python.org/3/library/decimal.html).
[^4]: [Floating Point Representation and Machine Representation of Decimal Digits (IEEE 754 Standards) - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2022-07-23/20-12-29.html).
