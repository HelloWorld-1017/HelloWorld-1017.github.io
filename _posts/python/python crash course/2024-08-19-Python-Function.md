---
title: "Takeaways from <i>Python Crash Course</i>: Python Function"
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
date: 2024-08-19 15:58:32 +0800
last_modified_at: 2024-08-20 23:17:23 +0800
---

This post is a record made while learning Chapter 8 “Functions” in Eric Matthes’s book, *Python Crash Course*.[^1]
{: .notice--primary}

# Python function terms


```python
def greet_user():
    """Display a simple greeting."""
    print("Hello!")
 
greet_user()
```

    Hello!

(1) `def` in `def greet_user():` is a Python keyword.

(2) `def greet_user():` is the <i class="term">function definition</i>, where `greet_user()` is the <i class="term">function name</i>. This function needs no information to receive, so there is nothing in its parentheses (even so, the parentheses are required). Finally, the definition ends in a colon.

<div class="notice--warning" markdown="1">

If forget parentheses, we’ll get an error:

```python
def greet_user:
    """Display a simple greeting."""
    print("Hello!")
 
greet_user()
```

```
  Cell In[1], line 1
    def greet_user:
                  ^
SyntaxError: expected '('
```

</div>

(3) Any indented lines that follow `def greet_user():` make up the <i class="term">body</i> of the function.

(4) The text `"""Display a simple greeting."""` enclosed in triple quotes is a comment called <i class="term">docstring</i>, which describes what the function does.[^2]

(5) `greet_user()` in the 5th line is a <i class="term">function call</i>. A <i class="term">function call</i> tells Python to execute the code in the function. To <i class="term">call</i> a function, we should write the function name, followed by any necessary information in parentheses. There is no information needed in this case, so we call the function simply by entering `greet_user()`.

Here is a case of passing information to a function:


```python
def greet_user(username):
    """Display a simple greeting."""
    print(f"Hello, {username.title()}!")

greet_user('jesse')
```

    Hello, Jesse!

The variable `username` in the function definition (1st line) is a <i class="term">parameter</i>, and the value `'jesse'` in the function call (5th line) is an <i class="term">argument</i>. An argument is a piece of information that’s passed from a <i class="term">function call</i> to a <i class="term">function</i>.

<br>

# Pass arguments

## Positional arguments

When we call a function, Python must match each argument in the function call with a parameter in the function definition. The simplest way to do this is based on the order of the arguments provided. Values matched up in this way are called <i class="term">positional arguments</i>. Definitely, arguments order matters in this case.


```python
def describe_pet(animal_type, pet_name):
    """Display information about a pet."""
    print(f"\nI have a {animal_type}.")
    print(f"My {animal_type}'s name is {pet_name.title()}.")
 
describe_pet('hamster', 'harry')
```


    I have a hamster.
    My hamster's name is Harry.

## Keyword arguments

A <i class="term">keyword argument</i> is a name-value pair that we pass to a function. Keyword arguments free us from worrying about having to worry about correctly ordering arguments in the function call because Python knows where each value should go.


```python
def describe_pet(animal_type, pet_name):
    """Display information about a pet."""
    print(f"\nI have a {animal_type}.")
    print(f"My {animal_type}'s name is {pet_name.title()}.")
    
describe_pet(pet_name='harry', animal_type='hamster')
```


    I have a hamster.
    My hamster's name is Harry.

## Specify default values

In the function definition, we can specify a <i class="term">default value</i> for each parameter. Using default values can simplify function calls and clarify the ways in which the functions are typically used.


```python
def describe_pet(pet_name, animal_type='dog'):
    """Display information about a pet."""
    print(f"\nI have a {animal_type}.")
    print(f"My {animal_type}'s name is {pet_name.title()}.")

describe_pet('willie')
describe_pet(pet_name='willie')
```


    I have a dog.
    My dog's name is Willie.
    
    I have a dog.
    My dog's name is Willie.


It should be noted that when use default values, any parameter with a default value needs to be listed after all the parameters that don’t have default values. This allows Python to continue interpreting positional arguments correctly, otherwise an error will occur, e.g.


```python
def describe_pet(animal_type='dog', pet_name):
    """Display information about a pet."""
    print(f"\nI have a {animal_type}.")
    print(f"My {animal_type}'s name is {pet_name.title()}.")
```

```
  Cell In[6], line 1
    def describe_pet(animal_type='dog', pet_name):
                                        ^
SyntaxError: non-default argument follows default argument
```


## Make an argument optional (1)

Sometimes it makes sense to make an argument optional so that people using the function can choose to provide extra information only if they want to. We can use default values to make an argument optional.


```python
def get_formatted_name(first_name, last_name, middle_name=''):
    """Return a full name, neatly formatted."""
    if middle_name:
        full_name = f"{first_name} {middle_name} {last_name}"
    else:
        full_name = f"{first_name} {last_name}"
    
    return full_name.title()
    
musician = get_formatted_name('jimi', 'hendrix')
print(musician)

musician = get_formatted_name('john', 'hooker', 'lee')
print(musician)
```

    Jimi Hendrix
    John Lee Hooker


As mentioned before, we have to make sure the middle name is the last argument passed (because the middle name is optional with default value an empty string) so that Python could match up the positional arguments correctly.

## Make an argument optional (2)


```python
def build_person(first_name, last_name, age=None):
    """Return a dictionary of information about a person."""
    person = {'first': first_name, 'last': last_name}
    if age:
        person['age'] = age
    return person

musician = build_person('jimi', 'hendrix')
print(musician)

musician = build_person('jimi', 'hendrix', age=27)
print(musician)
```

    {'first': 'jimi', 'last': 'hendrix'}
    {'first': 'jimi', 'last': 'hendrix', 'age': 27}

Here a new optional parameter `age` is added to the function definition and assigned the special value `None`, which is used when a variable has no specific value assigned to it. We can think of `None` as a placeholder value.

<br>

# Pass a list

When we pass a list to a function, the function gets direct access to the contents of the list.


```python
def greet_users(names):
    """Print a simple greeting to each user in the list."""
    for name in names:
        msg = f"Hello, {name.title()}!"
        print(msg)

usernames = ['hannah', 'ty', 'margot']
greet_users(usernames)
```

    Hello, Hannah!
    Hello, Ty!
    Hello, Margot!


## Modify a list in a function

We can modify a list by passing it to a defined function, and any changes made to the list inside the function’s body are <i class="term">permanent</i>, like `print_models()` function in the following example:

```python
def print_models(unprinted_designs, completed_models):
    """
    Simulate printing each design, until none are left.
    Move each design to completed_models after printing.
    """
    while unprinted_designs:
        current_design = unprinted_designs.pop()
        print(f"Printing model: {current_design}")
        completed_models.append(current_design)
 
def show_completed_models(completed_models):
    """Show all the models that were printed."""
    print("\nThe following models have been printed:")
    for completed_model in completed_models:
        print(completed_model)
 
unprinted_designs = ['phone case', 'robot pendant', 'dodecahedron']
completed_models = []

print_models(unprinted_designs, completed_models)
show_completed_models(completed_models)

# Display uncompleted models
print("\nThe following models have not been printed:")
print(unprinted_designs)
```

    Printing model: dodecahedron
    Printing model: robot pendant
    Printing model: phone case
    
    The following models have been printed:
    dodecahedron
    robot pendant
    phone case
    
    The following models have not been printed:
    []

This example also demonstrates the idea that every function should have one specific job. This is more beneficial than using one function to do all jobs.

## Prevent a function from modifying a list

We could preserve the original contents of a list by passing a copy of the list to the function:


```python
def print_models(unprinted_designs, completed_models):
    """
    Simulate printing each design, until none are left.
    Move each design to completed_models after printing.
    """
    while unprinted_designs:
        current_design = unprinted_designs.pop()
        print(f"Printing model: {current_design}")
        completed_models.append(current_design)
 
def show_completed_models(completed_models):
    """Show all the models that were printed."""
    print("\nThe following models have been printed:")
    for completed_model in completed_models:
        print(completed_model)
 
unprinted_designs = ['phone case', 'robot pendant', 'dodecahedron']
completed_models = []

print_models(unprinted_designs[:], completed_models)
show_completed_models(completed_models)

# The original list of unprinted designs will be unaffected by the function
print(f"\n{unprinted_designs}")
```

    Printing model: dodecahedron
    Printing model: robot pendant
    Printing model: phone case
    
    The following models have been printed:
    dodecahedron
    robot pendant
    phone case
    
    ['phone case', 'robot pendant', 'dodecahedron']

However, it’s not recommended unless we have a specific reason. It’s more efficient for a function to work with an existing list to avoid using the time and memory needed to make a separate copy, especially when we’re working with large lists.

<br>

# Pass arbitrary number of arguments

## Arbitrary number of arguments: `*args`


```python
def make_pizza(*toppings):
    """Print the list of toppings that have been requested."""
    print(toppings)
 
make_pizza('pepperoni')
make_pizza('mushrooms', 'green peppers', 'extra cheese')
```

    ('pepperoni',)
    ('mushrooms', 'green peppers', 'extra cheese')

The asterisk in the parameter name `*toppings` tells Python to make an <i class="term">empty tuple</i> called `toppings` and pack whatever values it receives into this tuple. Above results show that Python can handle a function call with one value and a call with three values. It treats different calls similarly. Note that Python packs the arguments into a tuple, even if the function only receives one value.

Besides, if we want a function to accept several different kinds of arguments (like mix positional arguments and arbitrary arguments for example), the parameter that accepts an arbitrary number of arguments must be placed last in the function definition. Python matches positional and keyword arguments first and then collects any remaining arguments in the final parameter.


```python
def make_pizza(size, *toppings): 
    """Summarize the pizza we are about to make."""
    print(f"\nMaking a {size}-inch pizza with the following toppings:") 
    for topping in toppings: 
        print(f"- {topping}") 
 
make_pizza(16, 'pepperoni') 
make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```


    Making a 16-inch pizza with the following toppings:
    - pepperoni
    
    Making a 12-inch pizza with the following toppings:
    - mushrooms
    - green peppers
    - extra cheese

Generally, generic parameter name `*args` is more often used (rather than specific name, `*toppings` in this case), which means collecting arbitrary positional arguments like this.

## Arbitrary number of keyword arguments: `**kwargs`

Sometimes we want to accept an arbitrary number of arguments, but we don’t know what kind of information will be passed to the function in advance. In this case, we can write functions that accept as many key-value pairs as the calling statement provides.


```python
def build_profile(first, last, **user_info):
    """Build a dictionary containing everything we know about a user."""
    user_info['first_name'] = first
    user_info['last_name'] = last
    return user_info

user_profile = build_profile('albert', 'einstein',
                             location='princeton',
                             field='physics')
print(user_profile)
```

    {'location': 'princeton', 'field': 'physics', 'first_name': 'albert', 'last_name': 'einstein'}

The double asterisks in the parameter `**user_info` inform Python to create an <i class="term">empty dictionary</i> called `user_info` and pack whatever name-value pairs it receives into this dictionary. Within the function, we can access the key-value pairs in `user_info` as other ordinary dictionaries.

Similarly, generic parameter name `**kwargs` is generally used, stating to collect non-specific keyword arguments.

## Mix `*args` and `**kwargs`

Using `*args` and `**kwargs` simultaneously when defining a function is really a common case, e.g.

```python
def helper_show_info(name, *args, **kwargs):
    print(name)
    print(args)
    print(kwargs)

helper_show_info('Tommy', 'man', '18', 
                 mobile='12345678900', address='Birmingham')
```

```
Tommy
('man', '18')
{'mobile': '12345678900', 'address': 'Birmingham'}
```

And, we should also note the order, including the order in the function definition (`*args` followed by `**kwargs`):

```python
def helper_show_info(name, **kwargs, *args):
    print(name)
    print(args)
    print(kwargs)

helper_show_info('Tommy', 'man', '18', 
                 mobile='12345678900', address='Birmingham')
```

```
  Cell In[4], line 1
    def helper_show_info(name, **kwargs, *args):
                                         ^
SyntaxError: arguments cannot follow var-keyword argument
```

and the order in the function call:

```python
def helper_show_info(name, *args, **kwargs):
    print(name)
    print(args)
    print(kwargs)

helper_show_info('Tommy',
                 mobile='12345678900', address='Birmingham',
                 'man', '18')
```

```
  Cell In[6], line 8
    'man', '18')
               ^
SyntaxError: positional argument follows keyword argument
```

<br>

# Store functions in the module

We can store all self-defined functions in a separate file (called a <i class="term">module</i>) and then <i class="term">import</i> the module into the main script file by the `import` statement.

For instance, one function named `make_pizza()` is defined and put in the module `pizza.py`:

```python
def make_pizza(size, *toppings):
    """Summarize the pizza we are about to make."""
    print(f"\nMaking a {size}-inch pizza with the following toppings:")
    for topping in toppings:
        print(f"- {topping}")
```

Here are several ways to import the module and functions within it.

## Import the entire module: `import module_name`


```python
import pizza

pizza.make_pizza(16, 'pepperoni')
pizza.make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```


    Making a 16-inch pizza with the following toppings:
    - pepperoni
    
    Making a 12-inch pizza with the following toppings:
    - mushrooms
    - green peppers
    - extra cheese

The line `import pizza` tells Python to <i class="term">open</i> the file `pizza.py` and <i class="term">copy</i> all the functions from it into the current script file before running the subsequent code.

## Import specific functions: `from module_name import function_0, function_1, function_2`


```python
from pizza import make_pizza
make_pizza(16, 'pepperoni')
make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```


    Making a 16-inch pizza with the following toppings:
    - pepperoni
    
    Making a 12-inch pizza with the following toppings:
    - mushrooms
    - green peppers
    - extra cheese


## Give a function an alias: `from module_name import function_name as fn`


```python
from pizza import make_pizza as mp

mp(16, 'pepperoni')
mp(12, 'mushrooms', 'green peppers', 'extra cheese')
```


    Making a 16-inch pizza with the following toppings:
    - pepperoni
    
    Making a 12-inch pizza with the following toppings:
    - mushrooms
    - green peppers
    - extra cheese

This method is useful when the name of imported function conflicts with an existing name in the current file, or the case that function name is long. 

## Give a module an alias: `import module_name as mn`


```python
import pizza as p

p.make_pizza(16, 'pepperoni')
p.make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```


    Making a 16-inch pizza with the following toppings:
    - pepperoni
    
    Making a 12-inch pizza with the following toppings:
    - mushrooms
    - green peppers
    - extra cheese

Calling the function by `p.make_pizza()` is not only more concise than `pizza.make_pizza()`, but also redirects our attention from the module name and allows us to focus on the descriptive names of its functions. This way is more readable. 

## Import all functions in a module: `from module_name import *`

We can tell Python to import all functions in a module by asterisk operator `*`:


```python
from pizza import *

make_pizza(16, 'pepperoni')
make_pizza(12, 'mushrooms', 'green peppers', 'extra cheese')
```


    Making a 16-inch pizza with the following toppings:
    - pepperoni
    
    Making a 12-inch pizza with the following toppings:
    - mushrooms
    - green peppers
    - extra cheese

Due to that every function in `pizza` module is imported, we can call each function by name without dot notation. However, this method is not that recommended, because we may get some unexpected results if function names conflict. 

<br>

# Style functions and modules

There are several conventions when styling functions and modules.

- Functions and modules should have <i class="term">descriptive names</i>, which can help others to understand what the function and module are trying to do.

- Function and module names should be composed of <i class="term">lowercase letters</i> and <i class="term">underscores</i>.

- Every function should have a comment that explains concisely what the function does. This comment should appear immediately after the function definition and use the <i class="term">docstring</i> format. In a well-documented function, other programmers can use the function by reading only the description in the docstring.

- When specifying a default value for a parameter, <i class="term">no spaces</i> should be used on either side of the equal sign:

  ```python
  def function_name(parameter_0, parameter_1='default value')
  ```

  and the same convention is used for keyword arguments in function calls:

  ```python
  function_name(value_0, parameter_1='value')
  ```

- PEP 8 recommends that programmers limit lines of code to <i class="term">79 characters</i> so every line is visible in a reasonably sized editor window[^3]. If a set of parameters causes a function definition longer than 79 characters, press `[Enter]` after the opening parenthesis on the definition line. On the next line, press `[Tab]` <i class="term">twice</i> to separate the list of arguments from the function body, which will only be indented one level.

  ```python
  def function_name(
          parameter_0, parameter_1, parameter_2,
          parameter_3, parameter_4, parameter_5):
      # function body ...
      pass
  ```

- If a module has more than one function, we can separate each by <i class="term">two blank lines</i> to make it easier to see where one function ends and the next one begins. 

- All `import` statements should be written <i class="term">at the beginning of a file</i>. The only exception is if we write comments at the beginning of the file to describe the overall script.

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 129-156.
[^2]: [Explore Python Module, Class, and Function by `help` Function, `__doc__` Attribute, and `dir` Function - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-08-05/16-41-24.html#docstrings).

[^3]: [PEP 8: Maximum Line Length – Style Guide for Python Code \| peps.python.org](https://peps.python.org/pep-0008/#maximum-line-length).

