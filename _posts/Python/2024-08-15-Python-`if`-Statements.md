---
title: Python `if` Statements
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
date: 2024-08-15 11:48:54 +0800
last_modified_at: 2024-08-15 11:48:54 +0800
---

This post is a record made while learning Chapter 5 “If Statements” in Eric Matthes’s book, Python Crash Course.[^1]
{: .notice--primary}

# Conditional tests (i.e. Boolean expression)

## Check equality for strings: `==`

Check equality for strings by equality operator (double equal sign, `==`):


```python
cars = ['audi', 'bmw', 'subaru', 'toyota']

for car in cars: 
    if car == 'bmw': # This is a "conditional test"
        print(car.upper())
    else:
        print(car.title())
```

    Audi
    BMW
    Subaru
    Toyota

Testing for equality is case sensitive in Python. We can use `lower()` method to ignore how the value is formatted, namely case insensitive, for example:

```python
car = 'Audi'
print(car == 'audi')
print(car.lower() == 'audi')
```

```
False
True
```

And, `lower()` method won’t change the original value of variable `car`.

## Check inequality for strings: `!=`

Check inequality for strings by inequality operator (an exclamation point and an equal sign, `!=`):


```python
requested_topping = 'mushrooms'

if requested_topping != 'anchovies':
    print("Hold the anchovies!")
```

    Hold the anchovies!

## Numerical comparisons: `==`, `<`, `<=`, `>`, and `>=`

```python
age = 19

age == 21, age < 21, age <= 21, age > 21, age >= 21
```


    (False, True, True, False, False)

## Check multiple conditions: `and`, `or`

**Keyword `and`**:


```python
age_0, age_1 = 22, 18
print((age_0 >= 21) and (age_1 >= 21))

age_0, age_1 = 22, 22
print((age_0 >= 21) and (age_1 >= 21))
```


    False
    True

Parentheses for individual tests are not required, just to improve readability.
{: .notice--primary}

**Keyword `or`**:


```python
age_0, age_1 = 22, 18
print(age_0 >= 21 or age_1 >= 21)

age_0, age_1 = 18, 18
print(age_0 >= 21 or age_1 >= 21)
```


    True
    False

## Check whether a value is or isn't in a list: `in`, `not in`

To find out whether a particular value is (or isn’t) already in a list, use the keyword `in` (or `not in`):


```python
requested_toppings = ['mushrooms', 'onions', 'pineapple']
print('mushrooms' in requested_toppings)
print('pepperoni' in requested_toppings)

print('mushrooms' not in requested_toppings)
print('pepperoni' not in requested_toppings)
```


    True
    False
    False
    True

<br>

# `if` statements

## `if` statement

```python
if conditional_test:
    do something
```


```python
age = 19
if age >= 18:
    print("You are old enough to vote!")
    print("Have you registered to vote yet?")
```

    You are old enough to vote!
    Have you registered to vote yet?


## `if-else` statements


```python
age = 17
if age >= 18:
    print("You are old enough to vote!")
    print("Have you registered to vote yet?")
else:
    print("Sorry, you are too young to vote.")
    print("Please register to vote as soon as you turn 18!")
```

    Sorry, you are too young to vote.
    Please register to vote as soon as you turn 18!


## `if-elif-else` chain


```python
age = 12
if age < 4:
    price = 0
elif age < 18:
    price = 25
elif age < 65:
    price = 40
else:
    price = 20

print(f"Your admission cost is ${price}.")
```

    Your admission cost is $25.


## Omit the `else` block

Python does not require an `else` block at the end of an `if-elif` chain. Sometimes an `else` block is useful; sometimes it is clearer to use an additional `elif` statement that catches the specific condition of interest:


```python
age = 12
if age < 4:
    price = 0
elif age < 18:
    price = 25
elif age < 65:
    price = 40
elif age >= 65:
    price = 20

print(f"Your admission cost is ${price}.")
```

    Your admission cost is $25.

## Test multiple conditions one by one

Check all of the conditions of interest one by one:


```python
requested_toppings = ['mushrooms', 'extra cheese']

if 'mushrooms' in requested_toppings:
    print("Adding mushrooms.")
if 'pepperoni' in requested_toppings:
    print("Adding pepperoni.")
if 'extra cheese' in requested_toppings:
    print("Adding extra cheese.")
 
print("\nFinished making your pizza!")
```

    Adding mushrooms.
    Adding extra cheese.
    
    Finished making your pizza!

Above three `if` statements are independent.

<br>

# Use `if` statements with lists

## Check special item


```python
requested_toppings = ['mushrooms', 'green peppers', 'extra cheese']

for requested_topping in requested_toppings:
    if requested_topping == 'green peppers':
        print("Sorry, we are out of green peppers right now.")
    else:
        print(f"Adding {requested_topping}.")
print("\nFinished making your pizza!")
```

    Adding mushrooms.
    Sorry, we are out of green peppers right now.
    Adding extra cheese.
    
    Finished making your pizza!


## Check whether or not a list is empty

Check whether a list is empty or not before running a `for` loop:


```python
requested_toppings = []

if requested_toppings:
    for requested_topping in requested_toppings:
        print(f"Adding {requested_topping}.")
    print("\nFinished making your pizza!")
else:
    print("Are you sure you want a plain pizza?")
```

    Are you sure you want a plain pizza?


## Use multiple lists


```python
available_toppings = ['mushrooms', 'olives', 'green peppers',
                      'pepperoni', 'pineapple', 'extra cheese']

requested_toppings = ['mushrooms', 'french fries', 'extra cheese']

for requested_topping in requested_toppings:
    if requested_topping in available_toppings:
        print(f"Adding {requested_topping}.")
    else:
        print(f"Sorry, we don't have {requested_topping}.")
 
print("\nFinished making your pizza!")
```

    Adding mushrooms.
    Sorry, we don't have french fries.
    Adding extra cheese.
    
    Finished making your pizza!

<div class="notice--primary" markdown="1">


We can use data structure `tuple` if the pizzeria has a stable selection of toppings.


```python
available_toppings = ('mushrooms', 'olives', 'green peppers',
                      'pepperoni', 'pineapple', 'extra cheese')

requested_toppings = ['mushrooms', 'french fries', 'extra cheese']

for requested_topping in requested_toppings:
    if requested_topping in available_toppings:
        print(f"Adding {requested_topping}.")
    else:
        print(f"Sorry, we don't have {requested_topping}.")
 
print("\nFinished making your pizza!")
```

    Adding mushrooms.
    Sorry, we don't have french fries.
    Adding extra cheese.
    
    Finished making your pizza!

</div>

<br>

# Style `if` statements

The only recommendation PEP 8 provides for styling conditional tests is to use a single space around comparison operators: for example, `if age < 4:` is better than `if age<4:`. Which point can be found in “Whitespace in Expressions and Statements” part of PEP 8 documentation.[^2]

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 71-90.
[^2]: [PEP 8: Whitespace in Expressions and Statements – Style Guide for Python Code \| peps.python.org](https://peps.python.org/pep-0008/#whitespace-in-expressions-and-statements).

