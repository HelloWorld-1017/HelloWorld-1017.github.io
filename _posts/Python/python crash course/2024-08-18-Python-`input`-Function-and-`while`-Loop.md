---
title: Python `input` Function and `while` Loop
categories:
 - Python
tags: 
 - Native Python
 - <i>Python Crash Course</i>
date: 2024-08-18 15:37:50 +0800
last_modified_at: 2024-08-20 18:42:40 +0800
---

This post is a record made while learning Chapter 7 “User Input and While Loops” in Eric Matthes’s book, Python Crash Course.[^1]
{: .notice--primary}

# `input()` function

Python `input()` function pauses the program and waits for user to enter some text, and then assigns user’s input to the specified variable. The `input()` function[^3] only takes one argument, that is the prompt, or say, instructions, e.g.

```python
prompt = "If you tell us who you are, we can personalize the messages you see."
prompt += "\nWhat is your first name? "
# prompt = "If you tell us who you are, we can personalize the messages you see.\nWhat is your first name? "

name = input(prompt)
print(f"\nHello, {name}!")
```

    If you tell us who you are, we can personalize the messages you see.
    What is your first name? Eric
    
    Hello, Eric!

The `input()` function will interpret whatever user enters as a string, which cannot be directly compared with numerical numbers, e.g.


```python
age = input("How old are you? ")
print(age, type(age))
print(age >= 19)
```

    How old are you? 21
    21 <class 'str'>
    ---------------------------------------------------------------------------
    TypeError                                 Traceback (most recent call last)
    Cell In[1], line 3
          1 age = input("How old are you? ")
          2 print(age, type(age))
    ----> 3 print(age >= 19)
    
    TypeError: '>=' not supported between instances of 'str' and 'int'

To make such comparisons (or other calculations) available, we can use `int()` function to convert user’s input to numerical representation first:

```python
age = input("How old are you? ")
age = int(age)
print(age, type(age))
print(age >= 19)
```

    How old are you? 21
    21 <class 'int'>
    True

<div class="notice--warning" markdown="1">
BTW, `int()` function is not available for floats:


```
How old are you? 21.21
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
Cell In[5], line 2
      1 age = input("How old are you? ")
----> 2 age = int(age)
      3 print(age, type(age))
      4 print(age >= 19)

ValueError: invalid literal for int() with base 10: '21.21'
```

we can use `float()` instead.

</div>

On the other hand, we can do more postprocess steps for the input, e.g.

```python
number = input("Enter a number, and I'll tell you if it's even or odd: ")
number = int(number)

if number % 2 == 0:
    print(f"\nThe number {number} is even.")
else:
    print(f"\nThe number {number} is odd.")
```

```
Enter a number, and I'll tell you if it's even or odd: 21

The number 21 is odd.
```

<div class="notice--primary" markdown="1">

The modulo operator `%` divides one number by another number and returns the remainder.

```python
4 % 3, 5 % 3, 6 % 3, 7 % 3
```

```
(1, 2, 0, 1)
```

</div>

<br>

# `while` loop

Python `while` loop runs as long as a certain condition is true, e.g.


```python
current_number = 1

while current_number <= 5:
    print(current_number)
    current_number += 1

print(current_number)
```

    1
    2
    3
    4
    5
    6


## Let users choose to quit a `while` loop


```python
prompt = "\nTell me something, and I will repeat it back to you:"
prompt += "\nEnter 'quit' to end the program. "

message = ""

while message != 'quit':
    message = input(prompt)
    
    if message != 'quit':
        print(message)
```


    Tell me something, and I will repeat it back to you:
    Enter 'quit' to end the program. Hello everyone!
    Hello everyone!
    
    Tell me something, and I will repeat it back to you:
    Enter 'quit' to end the program. Hello again.
    Hello again.
    
    Tell me something, and I will repeat it back to you:
    Enter 'quit' to end the program. quit


## Use a flag to quit a `while` loop

At times, there are several different events might occur to stop a `while` loop, trying to test all possible conditions in one `while` statement looks complicated, so in which case we can define a flag (i.e. a variable) to determine whether or not to exit the `while` loop, like variable `active` in the following example:


```python
prompt = "\nTell me something, and I will repeat it back to you:"
prompt += "\nEnter 'quit' to end the program. "
 
active = True

while active:
    message = input(prompt)
    
    if message == 'quit':
        active = False
    else:
        print(message)
```


    Tell me something, and I will repeat it back to you:
    Enter 'quit' to end the program. hello everyone!
    hello everyone!
    
    Tell me something, and I will repeat it back to you:
    Enter 'quit' to end the program. hello again!
    hello again!
    
    Tell me something, and I will repeat it back to you:
    Enter 'quit' to end the program. quit

This is a really simple example. We can add more tests, such as by `elif` statements, to determine whether to convert the flag `activate` to `False`.

## `break` statement in a `while` loop

In a `while` loop, the `break` statement will immediately exit the loop without running any remaining code in the loop, e.g.


```python
prompt = "\nPlease enter the name of a city you have visited:"
prompt += "\n(Enter 'quit' when you are finished.) "

while True:
    city = input(prompt)
    
    if city == 'quit':
        break
    else:
        print(f"I'd love to go to {city.title()}!")
```


    Please enter the name of a city you have visited:
    (Enter 'quit' when you are finished.) New York
    I'd love to go to New York!
    
    Please enter the name of a city you have visited:
    (Enter 'quit' when you are finished.) San Francisco
    I'd love to go to San Francisco!
    
    Please enter the name of a city you have visited:
    (Enter 'quit' when you are finished.) quit

Besides, the `break` statement has the same function in a `for` loop[^2]:

```python
for i in range(11):
    if i == 7:
        break
    print(i)
```

```
0
1
2
3
4
5
6
```

## `continue` statement in a `while` loop

In a `while` loop, the `continue` statement is used to ignore the remaining code and return to the beginning of the loop, e.g.


```python
current_number = 0

while current_number < 10:
    current_number += 1
    
    if current_number % 2 == 0:
        continue
    
    print(current_number)
```

    1
    3
    5
    7
    9

and it is also available in a `for` loop[^2]:

```python
for i in range(11):
    if i == 7:
        continue
    print(i)
```

```
0
1
2
3
4
5
6
8
9
10
```

<br>

# Use a `while` loop with list and dictionary

## Move items from one list to another


```python
# Start with users that need to be verified, 
# and an empty list to hold confirmed users.
unconfirmed_users = ['alice', 'brian', 'candace']
confirmed_users = []

# Verify each user until there are no more unconfirmed users.
# Move each verified user into the list of confirmed users.
while unconfirmed_users:
    current_user = unconfirmed_users.pop()
    print(f"Verifying user: {current_user.title()}")
    
    confirmed_users.append(current_user)
    
# Display all confirmed users.
print("\nThe following users have been confirmed:")
for confirmed_user in confirmed_users:
    print(confirmed_user.title())
```

    Verifying user: Candace
    Verifying user: Brian
    Verifying user: Alice
    
    The following users have been confirmed:
    Candace
    Brian
    Alice


## Remove all instances of specific values from a list


```python
pets = ['dog', 'cat', 'dog', 'goldfish', 'cat', 'rabbit', 'cat']
print(pets)

while 'cat' in pets:
    pets.remove('cat')

print(pets)
```

    ['dog', 'cat', 'dog', 'goldfish', 'cat', 'rabbit', 'cat']
    ['dog', 'dog', 'goldfish', 'rabbit']


## Fill a dictionary with user input


```python
responses = {}

# Set a flag to indicate that polling is active.
polling_active = True

while polling_active:
    # Prompt for the person's name and response.
    name = input("\nWhat is your name? ")
    response = input("Which mountain would you like to climb someday? ")
    
    # Store the response in the dictionary.
    responses[name] = response
    
    # Find out if anyone else is going to take the poll.
    repeat = input("Would you like to let another person respond? (yes/ no) ")
    if repeat == 'no':
        polling_active = False
 
# Polling is complete. Show the results
print("\n--- Poll Results ---")

for name, response in responses.items():
    print(f"{name} would like to climb {response}.")
```


    What is your name? Eric
    Which mountain would you like to climb someday? Denali
    Would you like to let another person respond? (yes/ no) yes
    
    What is your name? Lynn
    Which mountain would you like to climb someday? Devil's Thumb
    Would you like to let another person respond? (yes/ no) yes
    
    What is your name? Tommy
    Which mountain would you like to climb someday? Everest
    Would you like to let another person respond? (yes/ no) no
    
    --- Poll Results ---
    Eric would like to climb Denali.
    Lynn would like to climb Devil's Thumb.
    Tommy would like to climb Everest.

```python
print(responses)
```

    {'Eric': 'Denali', 'Lynn': "Devil's Thumb", 'Tommy': 'Everest'}

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 113-128.
[^2]: [Python `break` and `continue` (With Examples)](https://www.programiz.com/python-programming/break-continue).

[^3]: [Built-in Functions: `input()` — Python 3.12.5 documentation](https://docs.python.org/3/library/functions.html#input).

