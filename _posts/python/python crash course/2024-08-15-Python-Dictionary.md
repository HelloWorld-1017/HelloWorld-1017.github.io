---
title: "Takeaways from <i>Python Crash Course</i>: Python Dictionary"
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
date: 2024-08-15 15:26:28 +0800
last_modified_at: 2024-08-15 15:26:28 +0800
---

This post is a record made while learning Chapter 6 “Dictionaries” in Eric Matthes’s book, *Python Crash Course*.[^1]
{: .notice--primary}

# Dictionary

A dictionary in Python is a collection of key-value pairs. Each key is connected to a value, and we can use a key to access the value associated with that key.

## Create a dictionary and access whose values


```python
alien_0 = {'color': 'green', 'points': 5}

print(alien_0)
print(alien_0['color'], alien_0['points'])
```

    {'color': 'green', 'points': 5}
    green 5


## Add new key-value pairs

Dictionaries are dynamic structures, and we can add new key-value pairs to a dictionary at any time.


```python
alien_0 = {'color': 'green', 'points': 5}
print(alien_0)

alien_0['x_position'], alien_0['y_position'] = 0, 25
print(alien_0)
```

    {'color': 'green', 'points': 5}
    {'color': 'green', 'points': 5, 'x_position': 0, 'y_position': 25}

Note: As of Python 3.7, dictionaries retain the order in which they were defined. 

## Start with an empty dictionary


```python
alien_0 = {} # define a dictionary with an empty set of braces

alien_0['color'], alien_0['points'] = 'green', 5
print(alien_0)
```

    {'color': 'green', 'points': 5}


Typically, empty dictionary is used when storing user-supplied data in a dictionary or when users write code that generates a large number of key-value pairs automatically.

## Modify values in a dictionary 


```python
alien_0 = {'color': 'green'}
print(f"The alien is {alien_0['color']}.")

alien_0['color'] = 'yellow'
print(f"The alien is now {alien_0['color']}.")
```

    The alien is green.
    The alien is now yellow.

## Remove key-value pairs


```python
alien_0 = {'color': 'green', 'points': 5}
print(alien_0)

del alien_0['points']
print(alien_0)
```

    {'color': 'green', 'points': 5}
    {'color': 'green'}

Note that the deleted key-value pair is removed permanently.

## A dictionary of similar objects


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python', # include a comma after the last key-value pair
    } # Add a closing brace on a new line after the last key-value pair and indent it one level so it aligns with the keys

language = favorite_languages['sarah'].title()
print(f"Sarah's favorite language is {language}.")
```

    Sarah's favorite language is C.


## `get()` method to access values

If the key we ask for doesn’t exist in the dictionary, an error will occur:

```python
alien_0 = {'color': 'green', 'speed': 'slow'}
print(alien_0['points'])
```

```
---------------------------------------------------------------------------
KeyError                                  Traceback (most recent call last)
Cell In[17], line 2
      1 alien_0 = {'color': 'green', 'speed': 'slow'}
----> 2 print(alien_0['points'])

KeyError: 'points'
```

For dictionaries, we can use the dictionary `get()` method to retrieve value to avoid this error:

<div class="quote--left" markdown="1">

**Syntax**: `Dict.get(key, Value)`[^2]

**Parameters**:

- **Key**: The key name of the item you want to return the value from
- **Value**: (Optional) Value to be returned if the key is not found. The default value is None.

**Returns**: Returns the value of the item with the specified key or the default value.

</div>


```python
alien_0 = {'color': 'green', 'speed': 'slow'}

point_value = alien_0.get('points', 'No point value assigned.')
print(point_value)

point_value1 = alien_0.get('points1')
print(point_value1)
```

```
No point value assigned.
None
```

<br>

# Loop through a dictionary

## Loop through all key-value pairs


```python
user_0 = {
    'username': 'efermi',
    'first': 'enrico',
    'last': 'fermi',
    }

for k, v in user_0.items():
    print(f"\nKey: {k}")
    print(f"Value: {v}")
```


    Key: username
    Value: efermi
    
    Key: first
    Value: enrico
    
    Key: last
    Value: fermi


## Loop through all the keys in a dictionary: `keys()` method


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

for name in favorite_languages.keys():
    print(name.title())
```

    Jen
    Sarah
    Edward
    Phil

<div class="notice--primary" markdown="1">

Actually, looping through the keys is the default behavior when looping through a dictionary:


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

for name in favorite_languages:
    print(name.title())
```

    Jen
    Sarah
    Edward
    Phil

</div>

On the other hand, the `keys()` method isn’t just for looping: it actually returns a list of all the keys.


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

favorite_languages.keys()
```


    dict_keys(['jen', 'sarah', 'edward', 'phil'])

In addition, we can loop through a dictionary’s keys in a particular order. Starting in Python 3.7, looping through a dictionary returns the items in the same order they were inserted. If we want to loop through a dictionary in alphabetical order, we can use `sorted()` function to get a copy of the keys returned in the `for` loop:


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

for name in sorted(favorite_languages.keys()):
    print(f"{name.title()}, thank you for taking the poll.")
```

    Edward, thank you for taking the poll.
    Jen, thank you for taking the poll.
    Phil, thank you for taking the poll.
    Sarah, thank you for taking the poll.

and similarly, in reverse alphabetical order:

```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

for name in sorted(favorite_languages.keys(), reverse=True):
    print(f"{name.title()}, thank you for taking the poll.")
```

```
Sarah, thank you for taking the poll.
Phil, thank you for taking the poll.
Jen, thank you for taking the poll.
Edward, thank you for taking the poll.
```

## Loop through all values in a dictionary: `values()` method


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

print("The following languages have been mentioned:")
for language in favorite_languages.values():
    print(language.title())
```

    The following languages have been mentioned:
    Python
    C
    Ruby
    Python

<div class="notice--primary" markdown="1">

Similar to `keys()` method, `values()` actually returns a list of all the values.

```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

favorite_languages.values()
```

```
dict_values(['python', 'c', 'ruby', 'python'])
```

</div>

This approach pulls all the values from the dictionary without checking for repeats. We can use Python set to avoid a repetitive list.

## Python set

A *set* is a collection in which each item must be unique:


```python
favorite_languages = {
    'jen': 'python',
    'sarah': 'c',
    'edward': 'ruby',
    'phil': 'python',
    }

print("The following languages have been mentioned:")
for language in set(favorite_languages.values()):
    print(language.title())
```

    The following languages have been mentioned:
    C
    Ruby
    Python


When we wrap `set()` around a list that contains duplicate items, Python identifies the unique items in the list and builds a set from those items.

Setting aside above example, in fact we can directly build a set using braces and separating the elements with commas:


```python
languages = {'python', 'ruby', 'python', 'c'}
print(languages)
```

    {'c', 'ruby', 'python'}

As can be seen, it’s easy to mistake “sets” for “dictionaries” because they’re both wrapped in braces. If we see a variable with braces `{}` but no key-value pairs in it, it’s probably a set. And, unlike lists and dictionaries, sets don’t retain items in any specific order.

<br>

# Nesting

Sometimes we want to store multiple dictionaries in a list, or a list of items as a value in a dictionary. This is called *nesting*.

## A list of dictionaries (dictionaries in a list)


```python
alien_0 = {'color': 'green', 'points': 5}
alien_1 = {'color': 'yellow', 'points': 10}
alien_2 = {'color': 'red', 'points': 15}

aliens = [alien_0, alien_1, alien_2]

for alien in aliens:
    print(alien)
```

    {'color': 'green', 'points': 5}
    {'color': 'yellow', 'points': 10}
    {'color': 'red', 'points': 15}

If we want to model a number of objects which have the same attributes, we can use a dictionary to represent each object and put all of dictionaries into a list.

```python
# Make an empty list for storing aliens.
aliens = []

# Make 30 green aliens.
for alien_number in range(30):
    new_alien = {'color': 'green', 'points': 5, 'speed': 'slow'}
    aliens.append(new_alien)
 
# Show the first 5 aliens.
for alien in aliens[:5]:
    print(alien)
    print("...")

# Show how many aliens have been created.
print(f"Total number of aliens: {len(aliens)}")
```

    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    Total number of aliens: 30

By this way, it’s easy to organize those objects. For example, we can use `for` loop and `if` statement to change values of particular attributes (keys) of some specified objects (dictionaries):


```python
# Make an empty list for storing aliens.
aliens = []

# Make 30 green aliens.
for alien_number in range(30):
    new_alien = {'color': 'green', 'points': 5, 'speed': 'slow'}
    aliens.append(new_alien)

# Modify the first three aliens
for alien in aliens[:3]:
    if alien['color'] == 'green':
        alien['color'] = 'yellow'
        alien['speed'] = 'medium'
        alien['points'] = 10

# Show the first 5 aliens.
for alien in aliens[:5]:
    print(alien)
    print("...")

# Show how many aliens have been created.
print(f"Total number of aliens: {len(aliens)}")
```

    {'color': 'yellow', 'points': 10, 'speed': 'medium'}
    ...
    {'color': 'yellow', 'points': 10, 'speed': 'medium'}
    ...
    {'color': 'yellow', 'points': 10, 'speed': 'medium'}
    ...
    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    {'color': 'green', 'points': 5, 'speed': 'slow'}
    ...
    Total number of aliens: 30

## A list in a dictionary (list in a dictionary)

```python
favorite_languages = {
    'jen': ['python', 'ruby'],
    'sarah': ['c'],
    'edward': ['ruby', 'go'],
    'phil': ['python', 'haskell'],
    }

for name, languages in favorite_languages.items():
    print(f"\n{name.title()}'s favorite languages are:")
    for language in languages:
        print(f"\t{language.title()}")
```


    Jen's favorite languages are:
    	Python
    	Ruby
    
    Sarah's favorite languages are:
    	C
    
    Edward's favorite languages are:
    	Ruby
    	Go
    
    Phil's favorite languages are:
    	Python
    	Haskell

It’s better not nest lists and dictionaries too deeply.

## A dictionary in a dictionary

We can nest a dictionary inside another dictionary, but the code will get complicated quickly as we do so.


```python
users = {
    'aeinstein': {
        'first': 'albert',
        'last': 'einstein',
        'location': 'princeton',
        },
    'mcurie': {
        'first': 'marie',
        'last': 'curie',
        'location': 'paris',
    },
}

for username, user_info in users.items():
    print(f"\nUsername: {username}")
    full_name = f"{user_info['first']} {user_info['last']}"
    location = user_info['location']

    print(f"\tFull name: {full_name.title()}")
    print(f"\tLocation: {location.title()}")
```


    Username: aeinstein
    	Full name: Albert Einstein
    	Location: Princeton
    
    Username: mcurie
    	Full name: Marie Curie
    	Location: Paris

Avoid the case that the structure of each dictionary is not the same. It’s not required by Python, but an identical structure makes nested dictionaries easier to work with. If each dictionary had different keys, the code inside the `for` loop (or other processes) would be more complicated.

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 91-112.
[^2]: [Python Dictionary `get()` Method - GeeksforGeeks](https://www.geeksforgeeks.org/python-dictionary-get-method/).

