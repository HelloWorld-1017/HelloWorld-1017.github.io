---
title: "Takeaways from Eric Matthes's book, <i>Python Crash Course</i>: Python List and Tuple"
categories:
 - Python
tags: 
 - Native Python
 - Data Structure
 - <i>Python Crash Course</i>
date: 2024-08-13 09:05:43 +0800
last_modified_at: 2024-08-13 20:05:12 +0800
---

This post is a record made while learning Chapter 3 “Introducing Lists” and Chapter 4 “ Working with Lists” in Eric Matthes’s book, Python Crash Course.[^1]
{: .notice--primary}

# List

## Create a list


```python
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
print(bicycles)
```

    ['trek', 'cannondale', 'redline', 'specialized']

## Index a list element

The starting index (position) of Python list is `0`, rather than `1`, that is Python list is zero-based numbering, so we should note *off-by-one error*.

<div class="quote--left" markdown="1">

Off-by-one error[^2]: An off-by-one error or off-by-one bug (known by acronyms OBOE, OBO, OB1 and OBOB) is a logic error that involves a number that differs from its intended value by +1 or −1. An off-by-one error can sometimes appear in a mathematical context. It often occurs in computer programming when a loop iterates one time too many or too few, usually caused by the use of non-strict inequality (≤) as the terminating condition where strict inequality (<) should have been used, or vice versa. Off-by-one errors also stem from confusion over zero-based numbering.

</div>

```python
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
print(bicycles[0])
print(bicycles[0].title()) # Format the element, 'Trek' is capitalized.
print(bicycles[1])
print(bicycles[3])
print(bicycles[-1]) # Access the last element in a list
print(bicycles[-2])
```

    trek
    Trek
    cannondale
    specialized
    specialized
    redline

## Use individual values from a List


```python
# use f-strings to create a message based on a value from a list
message = f"My first bicycle was a {bicycles[0].title()}."
print(message)
```

    My first bicycle was a Trek.


## Modify elements in a list


```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

motorcycles[0] = 'ducati'
print(motorcycles)
```

    ['honda', 'yamaha', 'suzuki']
    ['ducati', 'yamaha', 'suzuki']

## Append elements to a list (`append` method)

Python `append` method makes new element added to the end of the list.


```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

motorcycles.append('ducati')
print(motorcycles)
```

    ['honda', 'yamaha', 'suzuki']
    ['honda', 'yamaha', 'suzuki', 'ducati']

It’s common to build a list from empty by appending item, which is unknown until after program is running, one by one during program execution.

```python
motorcycles = [] # Define an empty list to store values

motorcycles.append('honda')
motorcycles.append('yamaha')
motorcycles.append('suzuki')

print(motorcycles)
```

    ['honda', 'yamaha', 'suzuki']

## Extend elements to a list (`extend` method)

```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

motorcycles1 = ['yamaha', 'suzuki']
motorcycles.extend(motorcycles1)
print(motorcycles)
```

```
['honda', 'yamaha', 'suzuki']
['honda', 'yamaha', 'suzuki', 'yamaha', 'suzuki']
```

## Concatenate several lists

```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

motorcycles1 = ['yamaha', 'suzuki']
motorcycles2 = ['honda', 'yamaha']
print(motorcycles + motorcycles1 + motorcycles2)
```

```
['honda', 'yamaha', 'suzuki']
['honda', 'yamaha', 'suzuki', 'yamaha', 'suzuki', 'honda', 'yamaha']
```

## Insert elements into a list (`insert` method)

Insert elements into a list by `insert` method.


```python
motorcycles = ['honda', 'yamaha', 'suzuki']

motorcycles.insert(0, 'ducati')
print(motorcycles)

motorcycles.insert(2, 'ducati2')
print(motorcycles)
```

    ['ducati', 'honda', 'yamaha', 'suzuki']
    ['ducati', 'honda', 'ducati2', 'yamaha', 'suzuki']

The `insert` method opens a space at position `0` and stores the value `'ducati'` at that location. This operation shifts every other value in the list one position to the right.

## Remove elements from a list

### `del` statement


```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

del motorcycles[0]
print(motorcycles)
```

    ['honda', 'yamaha', 'suzuki']
    ['yamaha', 'suzuki']

```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

del motorcycles[1]
print(motorcycles)
```

    ['honda', 'yamaha', 'suzuki']
    ['honda', 'suzuki']

### `pop` method

The `pop` method removes the last item in a list, but the item is still available after removing.


```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles)

popped_motorcycles = motorcycles.pop()
# pop a value from the list and store that value in the variable `popped_motorcycles`
print(motorcycles) 
print(popped_motorcycles)
```

    ['honda', 'yamaha', 'suzuki']
    ['honda', 'yamaha']
    suzuki


Pop item from any position in a list:


```python
motorcycles = ['honda', 'yamaha', 'suzuki']

first_owned = motorcycles.pop(0)
print(motorcycles)
print(f"The first motorcycle I owned was a {first_owned.title()}.")
```

    ['yamaha', 'suzuki']
    The first motorcycle I owned was a Honda.

### `remove` method


```python
motorcycles = ['honda', 'yamaha', 'suzuki', 'ducati']
print(motorcycles)

motorcycles.remove('ducati')
print(motorcycles)
```

    ['honda', 'yamaha', 'suzuki', 'ducati']
    ['honda', 'yamaha', 'suzuki']

```python
motorcycles = ['honda', 'yamaha', 'suzuki', 'ducati']
print(motorcycles)

too_expensive = 'ducati'
motorcycles.remove(too_expensive)
print(motorcycles)
print(f"\nA {too_expensive.title()} is too expensive for me.")
```

    ['honda', 'yamaha', 'suzuki', 'ducati']
    ['honda', 'yamaha', 'suzuki']
    
    A Ducati is too expensive for me.

The value `'ducati'` has been removed from the list but is still accessible through the variable `too_expensive`.

The `remove` method deletes only the first occurrence of the specified value. If the value appears more than once in the list, we should use a loop to make sure all occurrences of the value are removed.


```python
motorcycles = ['honda', 'yamaha', 'honda', 'suzuki', 'honda', 'ducati', 'honda']

print(motorcycles)
while 'honda' in motorcycles:
    motorcycles.remove('honda')
 
print(motorcycles)
```

    ['honda', 'yamaha', 'honda', 'suzuki', 'honda', 'ducati', 'honda']
    ['yamaha', 'suzuki', 'ducati']


## Organize a list

### `sort` method

Sort a list *permanently* with the `sort` method.


```python
cars = ['bmw', 'audi', 'toyota', 'subaru']
cars.sort()
print(cars)
# The cars are now in alphabetical order, and we can never revert to the original order.
```

    ['audi', 'bmw', 'subaru', 'toyota']

and in reverse alphabetical order:

```python
cars = ['bmw', 'audi', 'toyota', 'subaru']
cars.sort(reverse=True)
print(cars)
```

    ['toyota', 'subaru', 'bmw', 'audi']

### `sorted` function

Sort a list temporarily with the `sorted` function: maintain the original order of a list but present it in a sorted order.

In alphabetical order:


```python
cars = ['bmw', 'audi', 'toyota', 'subaru']

print(cars)
print(sorted(cars))
print(cars)
```

    ['bmw', 'audi', 'toyota', 'subaru']
    ['audi', 'bmw', 'subaru', 'toyota']
    ['bmw', 'audi', 'toyota', 'subaru']

In reverse alphabetical order:

```python
cars = ['bmw', 'audi', 'toyota', 'subaru']

print(cars)
print(sorted(cars,reverse=True))
print(cars)
```

    ['bmw', 'audi', 'toyota', 'subaru']
    ['toyota', 'subaru', 'bmw', 'audi']
    ['bmw', 'audi', 'toyota', 'subaru']

It is more complicated to sort a list alphabetically when all the values are not in lowercase. There are several ways to interpret capital letters when determining a sort order.

### `reverse` method

To reverse the original order of a list, we can use the `reverse` method: `reverse` doesn’t sort backward alphabetically; it simply reverses the order of the list.

`reverse` method changes the order of a list *permanently*, but we can revert to the original order anytime by applying `reverse` to the same list a second time.


```python
cars = ['bmw', 'audi', 'toyota', 'subaru']
print(cars)
cars.reverse()
print(cars)
cars.reverse()
print(cars)
```

    ['bmw', 'audi', 'toyota', 'subaru']
    ['subaru', 'toyota', 'audi', 'bmw']
    ['bmw', 'audi', 'toyota', 'subaru']

### `len` function


```python
cars = ['bmw', 'audi', 'toyota', 'subaru']
len(cars)
```


    4

Python counts the items in a list starting with one, so off-by-one error doesn’t exist when determining the length of a list.

## Loop through an entire list by `for` loop


```python
magicians = ['alice', 'david', 'carolina']
for magician in magicians:
    print(magician)
    print(f"{magician.title()}, that was a great trick!")
    print(f"I can't wait to see your next trick, {magician.title()}.\n")
```

    alice
    Alice, that was a great trick!
    I can't wait to see your next trick, Alice.
    
    david
    David, that was a great trick!
    I can't wait to see your next trick, David.
    
    carolina
    Carolina, that was a great trick!
    I can't wait to see your next trick, Carolina.

## Numerical lists

### `range` function


```python
for value in range(1,5):
    print(value)
```

    1
    2
    3
    4

More of the same, note the off-by-one behavior in this case: the `range` function causes Python to start counting at the first value we give it, and it stops when it reaches the second value provided. Because it stops at that second value, the output never contains the end value, which would have been 5 in this case.


We can also pass `range` only one argument, and it will start the sequence of numbers at `0`. 


```python
for value in range(6):
    print(value)
```

    0
    1
    2
    3
    4
    5

### Create a numerical list by `range` + `list`


```python
numbers = list(range(1, 6))
print(numbers)
```

    [1, 2, 3, 4, 5]

Skip numbers in a given range by inputing the third argument (i.e. step size):


```python
even_numbers = list(range(2, 11, 2))
print(even_numbers)
```

    [2, 4, 6, 8, 10]

In this example, the `range` function starts with the value `2` and then adds` 2` to that value. It adds `2` repeatedly until it reaches or passes the end value `11`.

### Application of `range` function in `for` loop


```python
squares = []
for value in range(1, 11):
    squares.append(value ** 2)
    
print(squares)
```

    [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

### Simple statistics of a numerical list


```python
digits = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
print(min(digits), max(digits), sum(digits))
```

    0 9 45

### List comprehensions

A *list comprehension* allows you to generate this same list in just one line of code: a list comprehension combines the `for` loop and the creation of new elements into one line, and automatically appends each new element.


```python
squares = [value**2 for value in range(1, 11)]
print(squares)
```

    [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

## Slice a list

**Case 1**


```python
players = ['charles', 'martina', 'michael', 'florence', 'eli']
print(players)
print(players[0:3])
```

    ['charles', 'martina', 'michael', 'florence', 'eli']
    ['charles', 'martina', 'michael']

**Case 2: with no the first index**


```python
players = ['charles', 'martina', 'michael', 'florence', 'eli']
print(players[:4])
```

    ['charles', 'martina', 'michael', 'florence']

**Case 3: with no the last index**

```python
players = ['charles', 'martina', 'michael', 'florence', 'eli']
print(players[2:])
```

    ['michael', 'florence', 'eli']

**Case 4: output the last $n$ items**

```python
players = ['charles', 'martina', 'michael', 'florence', 'eli']
print(players[-3:])
```

    ['michael', 'florence', 'eli']

**Case 5: include a third value in the brackets indicating a step size**

If a third value is included, this tells Python how many items to skip between items in the specified range.

```python
players = ['charles', 'martina', 'michael', 'florence', 'eli', 'tommy', 'Merry']

print(players[1::2])
```

```
['martina', 'florence', 'tommy']
```

**Case 6: Loop through a slice**


```python
players = ['charles', 'martina', 'michael', 'florence', 'eli']

print("Here are the first three players on my team:")
for player in players[:3]:
    print(player.title())
```

    Here are the first three players on my team:
    Charles
    Martina
    Michael

More ways to slice list can be found in GeeksforGeeks blog[^5].

## Copy a list: `[:]`, `copy` method, and equal sign

To copy a list, we can make a slice that includes the entire original list by omitting the first index and the second index, i.e. `[:]`, and at this point we have two separate lists:


```python
my_foods = ['pizza', 'falafel', 'carrot cake']
friend_foods = my_foods[:]

print(my_foods)
print(friend_foods)

my_foods.append('cannoli')
friend_foods.append('ice cream')

print(my_foods)
print(friend_foods)
```

    ['pizza', 'falafel', 'carrot cake']
    ['pizza', 'falafel', 'carrot cake']
    ['pizza', 'falafel', 'carrot cake', 'cannoli']
    ['pizza', 'falafel', 'carrot cake', 'ice cream']

<div class="notice--primary" markdown="1">

And, `copy` method can reach the same effect:

```python
my_foods = ['pizza', 'falafel', 'carrot cake']
friend_foods = my_foods.copy()

print(my_foods)
print(friend_foods)

my_foods.append('cannoli')
friend_foods.append('ice cream')

print(my_foods)
print(friend_foods)
```

```
['pizza', 'falafel', 'carrot cake']
['pizza', 'falafel', 'carrot cake']
['pizza', 'falafel', 'carrot cake', 'cannoli']
['pizza', 'falafel', 'carrot cake', 'ice cream']
```

</div>

If we had simply set `friend_foods` equal to `my_foods` by an equal sign, we would NOT produce two separate lists.

<div id="script-1"></div>


```python
my_foods = ['pizza', 'falafel', 'carrot cake']

friend_foods = my_foods

my_foods.append('cannoli')
friend_foods.append('ice cream')

print(my_foods)
print(friend_foods)
```

    ['pizza', 'falafel', 'carrot cake', 'cannoli', 'ice cream']
    ['pizza', 'falafel', 'carrot cake', 'cannoli', 'ice cream']

This syntax (`friend_foods = my_foods`) actually tells Python to *associate* the new variable `friend_foods`. At this time, `my_foods` is a *reference* to `friend_foods`[^6], both variables pointing to the same list, so changes made in `my_foods` will automatically also be made in `friend_foods`, and vice versa.

<br>

# Tuple

## Create a tuple and index whose elements

A tuple looks just like a list except we use parentheses instead of square brackets.


```python
dimensions = (200, 50)
print(dimensions[0], dimensions[1])
```

    200 50

Tuples are technically defined by the presence of a comma; the parentheses make them look neater and more readable. If we want to define a tuple with one element, we need to include a trailing comma:


```python
my_t = (3,)
print(my_t)
```

    (3,)

It doesn’t often make sense to build a tuple with one element, but this can happen when tuples are generated automatically.

## Slice a tuple

The way to slice a tuple is the same as we do for list.

```python
my_t = (1, 3, 8, 7)
print(my_t)
print(my_t[:2])
```

```
(1, 3, 8, 7)
(1, 3)
```

## Create a numerical tuple by `range` + `tuple`

```python
numbers = tuple(range(1, 6))
print(numbers)
```

```
(1, 2, 3, 4, 5)
```

## Concatenate several tuples

```python
my_t1 = (1, 3, 8, 7)
my_t2 = (1, 3, 8, 7)
my_t3 = (1, 3, 8, 7)
print(my_t1 + my_t2 + my_t3)
```

```
(1, 3, 8, 7, 1, 3, 8, 7, 1, 3, 8, 7)
```

## Loop through all values in a tuple


```python
dimensions = (200, 50)
for dimension in dimensions:
    print(dimension)
```

    200
    50

## Tuple is an immutable object

Tuple is an immutable object, so it is useful when we want to create a list of items that cannot change.

```python
dimensions = (200, 50)
dimensions[0] = 250
```

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[43], line 2
      1 dimensions = (200, 50)
----> 2 dimensions[0] = 250

TypeError: 'tuple' object does not support item assignment
```

Although we can’t modify a tuple, we can reassign a new value to an existing variable to write over a tuple.


```python
dimensions = (200, 50)
for dimension in dimensions:
    print(dimension)
 
dimensions = (400, 100)
for dimension in dimensions:
    print(dimension)
```

    200
    50
    400
    100

Compared with list, Python tuple is a kind of simpler data structure, we can use them when we need specify a set of values that should not be changed through-out the life of a program.

<br>

# Python mutable vs. immutable objects

As described before, Python tuple is a kind of immutable object, and on the contrary, list is a kind of mutable object. Blog “Mutable vs Immutable Objects in Python”[^3] in GeeksforGeeks compares Python mutable and immutable objects in detail:

<div class="quote--left" markdown="1">

In Python, Every variable in Python holds an instance of an object. There are two types of objects in Python i.e. **Mutable** and **Immutable objects**. Whenever an object is instantiated, it is assigned a unique object id. The type of the object is defined at the runtime and it can’t be changed afterward. However, its state can be changed if it is a mutable object.

...

Immutable Objects are of in-built datatypes like **int**, **float**, **bool**, **string**, **Unicode**, and **tuple**. In simple words, an immutable object can’t be changed after it is created.

...

Mutable Objects are of type Python **list**, Python **dict**, or Python **set**. Custom classes are generally mutable.

...

**Python’s Mutable vs Immutable**

1. Mutable and immutable objects are handled differently in Python. **Immutable objects are quicker to access and are expensive to change because it involves the creation of a copy**. Whereas mutable objects are easy to change.
2. The use of mutable objects is recommended when there is a need to change the size or content of the object.
3. ... **The tuple itself isn’t mutable but contains items that are mutable.** As a rule of thumb, generally, Primitive-like types are probably immutable, and Customized Container-like types are mostly mutable.

</div>

Here are some verifications for above conclusions.

## Python string and int are immutable

```python
greeting = "Hello, world!"
greeting[0] = 'G'
print(greeting)
```

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[3], line 2
      1 greeting = "Hello, world!"
----> 2 greeting[0] = 'G'
      3 print(greeting)

TypeError: 'str' object does not support item assignment
```

```python
a = 2
a[0] = 3
```

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[4], line 2
      1 a = 2
----> 2 a[0] = 3

TypeError: 'int' object does not support item assignment
```

## Python dict and set are mutable

```python
my_dict = {"name": "Ram", "age": 25}
print(my_dict)

new_dict = my_dict
new_dict["age"] = 37
print(my_dict)
print(new_dict)
```

```
{'name': 'Ram', 'age': 25}
{'name': 'Ram', 'age': 37}
{'name': 'Ram', 'age': 37}
```

```python
my_set = {1, 2, 3}
print(my_set) 

new_set = my_set
new_set.add(4)
print(my_set)
print(new_set)
```

```
{1, 2, 3}
{1, 2, 3, 4}
{1, 2, 3, 4}
```

Features showed here is the same as [that of the list](#script-1).

## The tuple per se isn’t mutable but whose items are mutable

```python
tup = ([3, 4, 5], 'string1')
print(tup)

tup[0][1] = 101
print(tup)

tup[1] = 'string2'
```

```
([3, 4, 5], 'string1')
([3, 101, 5], 'string1')
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[1], line 7
      4 tup[0][1] = 101
      5 print(tup)
----> 7 tup[1] = 'string2'

TypeError: 'tuple' object does not support item assignment
```

## Space and time complexity of list and tuple

Tuple is more memory-efficient than list; the implication of iterations of list is more faster that of tuple:[^4]

<div class="quote--left" markdown="1" id="tuple-vs-list">

As tuples are stored in a single memory block therefore they don’t require extra space for new objects whereas the lists are allocated in two blocks, first the fixed one with all the Python object information and second a variable-sized block for the data which <font color="red"><b>makes them even faster</b></font>.

</div>

```python
import sys
a_list = []
a_tuple = ()
a_list = ["Geeks", "For", "Geeks"]
a_tuple = ("Geeks", "For", "Geeks")
print(sys.getsizeof(a_list))
print(sys.getsizeof(a_tuple))
```

```
88
64
```

```python
import timeit

print("Elapsed time is:",timeit.timeit(
    stmt='a = [a for a in list(range(500000))]',
    number=50000))

print("Elapsed time is:",timeit.timeit(
    stmt='a = [a for a in tuple(range(500000))]',
    number=50000))
```

```
Elapsed time is: 793.0124018999995
Elapsed time is: 822.4327848000003
```

However, in the same blog[^4], there are conflicting statements about the pros and cons of list and tuple performance:

<div class="quote--left" markdown="1">

List: The implication of iterations is Time-consuming

Tuple: The implication of iterations is comparatively Faster

...

**When to Use Tuples Over Lists?**

**Immutable Data**: Tuples are immutable, thus once they are generated, their contents cannot be changed. This makes tuples a suitable option for storing information that shouldn’t change, such as setup settings, constant values, or other information that should stay the same while your programme is running.

**Performance**: <font color="red"><b>Tuples are more lightweight than lists and might be quicker to generate, access, and iterate through since they are immutable.</b></font> Using a tuple can be more effective than using a list if you have a huge collection of data that you need to store, retrieve, and use regularly and that data does not need to be altered.

**Data integrity**: By ensuring that the data’s structure and contents stay consistent, tuples can be utilised to ensure data integrity. To make sure the caller is aware of how much data to expect, for instance, if a function returns a set amount of values, you might want to return them as a tuple rather than a list.

</div>

I’m not certain which is right, and at this moment I won’t step further about this point.

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 33-70.
[^2]: [Off-by-one error - Wikipedia](https://en.wikipedia.org/wiki/Off-by-one_error).
[^3]: [Mutable vs Immutable Objects in Python - GeeksforGeeks](https://www.geeksforgeeks.org/mutable-vs-immutable-objects-in-python/).
[^4]: [Difference Between List and Tuple in Python - GeeksforGeeks](https://www.geeksforgeeks.org/python-difference-between-list-and-tuple/).
[^5]: [Python List Slicing - GeeksforGeeks](https://www.geeksforgeeks.org/python-list-slicing/).
[^6]: [Python - Copy Lists](https://www.w3schools.com/python/python_lists_copy.asp).
