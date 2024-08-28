---
title: "Takeaways from <i>Python Crash Course</i>: Python Class"
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
date: 2024-08-20 21:59:33 +0800
last_modified_at: 2024-08-24 18:33:38 +0800
---

This post is a record made while learning Chapter 9 “Classes” in Eric Matthes’s book, *Python Crash Course*.[^1]
{: .notice--primary}

# Create and use a class

In the <i class="term">object-oriented programming</i> we write <i class="term">classes</i> to model real-world things and situations, and then create <i class="term">objects</i> based on these classes. Making an object from a class is called <i class="term">instantiation</i>, and such objects are <i class="term">instances</i> of a class.

<div class="quote--left" markdown="1">

Understanding object-oriented programming will help you see the world as a programmer does. It’ll help you really know your code, not just what’s happening line by line, but also the bigger concepts behind it. Knowing the logic behind classes will train you to think logically so you can write programs that effectively address almost any problem you encounter.

</div>

## Define a class

To better illustrate ideas about Python class, here we define a `Dog` class ahead of time:


```python
class Dog:
    """A simple attempt to model a dog."""
    
    def __init__(self, name, age):
        """Initialize name and age attributes."""
        self.name = name
        self.age = age
        
    def sit(self):
        """Simulate a dog sitting in response to a command."""
        print(f"{self.name} is now sitting.")
        
    def roll_over(self):
        """Simulate rolling over in response to a command."""
        print(f"{self.name} rolled over!")
```

Note that there are no parentheses in the <i class="term">class definition</i> (that is `class Dog:` rather than `class Dog():`) because we’re creating this class <i class="emphasize">from scratch</i>. Which point is different from that when defining a function.[^4]

## The `__init__()` method of a class

Those functions defined in a class are called <i class="term">methods</i>. The `__init__()` method is a special method that Python runs automatically whenever we create a new instance based on the defined class.

In above `Dog` class, there are three parameters in `__init__()` method definition: `self`, `name`, and `age`. 

The `self` parameter must be included in the method definition, because when creating an instance Python will call the `__init__()` method, and this <i class="term">method call</i> will automatically pass the `self` argument. The `self` argument <i class="emphasize">must come first before the other parameters</i>. Every method call associated with an instance automatically passes `self`, which is <i class="emphasize">a reference to the instance itself</i>--it gives the individual instance access to the attributes and methods in the class--and which is why parameter `self` is also required when defining `sit()` method and `roll_over()` method. 

The other two variables, `self.name = name` and `self.age = age`, each have the prefix `self`. Any variable prefixed with `self` is available to every method in the class, and we’ll also be able to access these variables through any instance created from the class. Variables that are accessible through instances like this, `self.name` and `self.age`, are called <i class="term">attributes</i>.

In some context, the `__init__()` method is also called <i class="term">constructor</i>[^2] (just as in JavaScript[^3]):

<div class="quote--left" markdown="1">


In class-based, object-oriented programming, a constructor (abbreviation: ctor) is a special type of function called to create an object. It prepares the new object for use, often accepting arguments that the constructor uses to set required member variables.

</div>

## Make an instance from a class

We can think of a class as <i class="emphasize">a set of instructions</i>, or say, an <i class="emphasize">abstract template</i>, for how to make an instance. For example, the class `Dog` is a set of instructions that tells Python how to make individual instances representing specific dogs.


```python
my_dog = Dog('Willie', 6)

print(f"My dog's name is {my_dog.name}.")
print(f"My dog is {my_dog.age} years old.")
```

    My dog's name is Willie.
    My dog is 6 years old.


For `my_dog = Dog('Willie', 6)`, we tell Python to create a dog whose name is `'Willie'` and whose age is `6`. When Python reads this line, it calls the `__init__()` method in `Dog` with the arguments `'Willie'` and `6`. The `__init__()` method creates an instance representing this particular dog and sets the `name` and `age` attributes using the provided values. Python then returns an instance representing this dog. We assign that instance to the variable `my_dog`. The naming convention is helpful here: we can usually assume that a <i class="emphasize">capitalized name</i> like `Dog` refers to a class, and a <i class="emphasize">lowercase name</i> like `my_dog` refers to a single instance created from a class.

We can use <i class="term">dot notation</i> to access the attributes of an instance, otherwise:


```python
my_dog.name, my_dog.age
```


    ('Willie', 6)

<div class="notice--warning" markdown="1">

Parentheses are not needed when accessing attributes:

```python
my_dog.name(), my_dog.age()
```

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[22], line 1
----> 1 my_dog.name(), my_dog.age()

TypeError: 'str' object is not callable
```

</div>

and call the methods defined in the `Dog` class:


```python
my_dog.sit()
my_dog.roll_over()
```

    Willie is now sitting.
    Willie rolled over!

<div class="notice--warning" markdown="1">

Parentheses are necessary when calling methods even if there is no argument to pass, otherwise:

```python
my_dog.sit, my_dog.roll_over
```


    (<bound method Dog.sit of <__main__.Dog object at 0x000001987EFC46D0>>,
     <bound method Dog.roll_over of <__main__.Dog object at 0x000001987EFC46D0>>)

</div>

<br>

# Three ways to modify attribute values

We can change an attribute’s value in three ways: change the value directly through an instance, set the value through a method, or increment the value (add a certain amount to it) through a method. Take a `Car` class as an example as follows.

**(1) Modify an attribute's value directly**

The simplest way to modify the value of an attribute is to access the attribute directly through an instance.


```python
 class Car:
    """A simple attempt to represent a car."""

    def __init__(self, make, model, year):
        """Initialize attributes to describe a car."""
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0 # Set a default value for an attribute; assigned a default value

    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")
    
my_new_car = Car('audi', 'a4', 2019)
print(my_new_car.get_descriptive_name())
my_new_car.read_odometer()

my_new_car.odometer_reading = 23
my_new_car.read_odometer()
```

    2019 Audi A4
    This car has 0 miles on it.
    This car has 23 miles on it.

**(2) Modify an attribute's value through a method**

Instead of accessing the attribute directly, we can pass the new value to a method that handles the updating <i class="emphasize">internally</i>.


```python
 class Car:
    """A simple attempt to represent a car."""

    def __init__(self, make, model, year):
        """Initialize attributes to describe a car."""
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

my_new_car = Car('audi', 'a4', 2019)
print(my_new_car.get_descriptive_name())

my_new_car.update_odometer(23)
my_new_car.read_odometer()

my_new_car.update_odometer(21)
my_new_car.read_odometer()
```

    2019 Audi A4
    This car has 23 miles on it.
    You can't roll back an odometer!
    This car has 23 miles on it.

**(3) Increment an attribute's value through a method**

Sometimes we want to increment an attribute’s value by a certain amount rather than set an entirely new value.


```python
 class Car:
    """A simple attempt to represent a car."""

    def __init__(self, make, model, year):
        """Initialize attributes to describe a car."""
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles

my_used_car = Car('subaru', 'outback', 2015)
print(my_used_car.get_descriptive_name())

my_used_car.update_odometer(23_500)
my_used_car.read_odometer()

my_used_car.increment_odometer(100)
my_used_car.read_odometer()
```

    2015 Subaru Outback
    This car has 23500 miles on it.
    This car has 23600 miles on it.

<br>

# Inheritance

We don’t always have to start from scratch when writing a class. If the class we’re writing is a specialized version of another existing class, we can use <i class="term">inheritance</i>. When one class <i class="term">inherits</i> from another, it takes on the attributes and methods of the first class. The original class is called the <i class="term">parent class</i>, and the new class is the <i class="term">child class</i>. The child class can inherit any or all of the attributes and methods of its parent class, and on the other hand we can define some new attributes and methods only available for the child class.

## The `__init__()` method of a child class

In the following code, a child class called `ElectricCar` inherits from the parent class `Car`:


```python
class Car:
    """A simple attempt to represent a car."""

    def __init__(self, make, model, year):
        """Initialize attributes to describe a car."""
        self.make = make
        self.model = model
        self.year = year
        self.odometer_reading = 0

    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles

        
class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
 
    def __init__(self, make, model, year):
        """Initialize attributes of the parent class."""
        super().__init__(make, model, year)
 
my_tesla = ElectricCar('tesla', 'model s', 2019)
print(my_tesla.get_descriptive_name())
```

    2019 Tesla Model S

There are some points should be noted.

(1) When we create a child class, the parent class must <i class="emphasize">be part of the current file</i> and must <i class="emphasize">appear before the child class</i> in the file. 

(2) `class ElectricCar(Car):`: The name of parent class `Car` must be included in parentheses in the child class definition.

(3) `super().__init__(make, model, year)`: The `super()` function is a special function that allows us to call a method from the parent class. This line tells Python to call the `__init__()` method from the parent class `Car`, giving an `ElectricCar` instance all the attributes defined in the `__init__()` method of `Car` class. The name `super` comes from a convention of calling the parent class a <i class="term">superclass</i> and the child class a <i class="term">subclass</i>. When we’re writing a new class based on an existing class, it’s really common to call the `__init__()` method from the parent class.

(4) `my_tesla = ElectricCar('tesla', 'model s', 2019)`: This line calls the `__init__()` method defined in `ElectricCar`, which in turn tells Python to call the `__init__()` method defined in the parent class `Car`.

## Define attributes and methods for the child class

Then, we can add any some new attributes (`battery_size` in the following code) and methods (`describe_battery`) necessary to differentiate the child class `ElectricCar` from the parent class `Car`.


```python
class Car:
    """A simple attempt to represent a car."""
    def __init__(self, make, model, year):
            """Initialize attributes to describe a car."""
            self.make = make
            self.model = model
            self.year = year
            self.odometer_reading = 0
            
    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles

        
class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
 
    def __init__(self, make, model, year):
        """
        Initialize attributes of the parent class.
        Then initialize attributes specific to an electric car.
        """
        super().__init__(make, model, year)
        self.battery_size = 75
    
    def describe_battery(self):
        """Print a statement describing the battery size."""
        print(f"This car has a {self.battery_size}-kWh battery.")
 
my_tesla = ElectricCar('tesla', 'model s', 2019)
print(my_tesla.get_descriptive_name())
my_tesla.describe_battery()
```

    2019 Tesla Model S
    This car has a 75-kWh battery.


## Override methods from the parent class

We can override any method from the parent class, by defining a method in the child class with the same name as the method we want to override in the parent class, like `fill_gas_tank()` in the following code:

```python
class Car:
    """A simple attempt to represent a car."""
    def __init__(self, make, model, year):
            """Initialize attributes to describe a car."""
            self.make = make
            self.model = model
            self.year = year
            self.odometer_reading = 0
            
    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles
        
    def fill_gas_tank(self):
        print("OK!")

        
class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
 
    def __init__(self, make, model, year):
        """
        Initialize attributes of the parent class.
        Then initialize attributes specific to an electric car.
        """
        super().__init__(make, model, year)
        self.battery_size = 75
    
    def describe_battery(self):
        """Print a statement describing the battery size."""
        print(f"This car has a {self.battery_size}-kWh battery.")
        
    def fill_gas_tank(self):
        """Electric cars don't have gas tanks."""
        print("This car doesn't need a gas tank!")

my_used_car = Car('subaru', 'outback', 2015)
my_used_car.fill_gas_tank()

my_tesla = ElectricCar('tesla', 'model s', 2019)
my_tesla.fill_gas_tank()
```

```
OK!
This car doesn't need a gas tank!
```

## Take an instance as an attribute

We can rewrite parts of one class as a separate class, breaking a large class into smaller classes that work together. For example, in the following code, we create a new class named `Battery`, and make an instance from it and then use the instance as an attribute in the `__init__()` method of `ElectricCar` class.


```python
class Car:
    """A simple attempt to represent a car."""
    def __init__(self, make, model, year):
            """Initialize attributes to describe a car."""
            self.make = make
            self.model = model
            self.year = year
            self.odometer_reading = 0
            
    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles

        
class Battery:
    """A simple attempt to model a battery for an electric car."""
    
    def __init__(self, battery_size=75):
        """Initialize the battery's attributes."""
        self.battery_size = battery_size
        
    def describe_battery(self):
        """Print a statement describing the battery size."""
        print(f"This car has a {self.battery_size}-kWh battery.")
    
    def get_range(self):
        """Print a statement about the range this battery provides."""
        if self.battery_size == 75:
            range = 260
        elif self.battery_size == 100:
            range = 315

        print(f"This car can go about {range} miles on a full charge.")


class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
 
    def __init__(self, make, model, year):
        """
        Initialize attributes of the parent class.
        Then initialize attributes specific to an electric car.
        """
        super().__init__(make, model, year)
        self.battery = Battery()
    
my_tesla = ElectricCar('tesla', 'model s', 2019)

print(my_tesla.get_descriptive_name())
my_tesla.battery.describe_battery()
my_tesla.battery.get_range()
```

    2019 Tesla Model S
    This car has a 75-kWh battery.
    This car can go about 260 miles on a full charge.

<br>

# Import classes from a module

Here is a Python fie, or, a module, `car.py`, including aforementioned three classes:

<div id="car-module"></div>

```python
"""A set of classes used to represent gas and electric cars."""

class Car:
    """A simple attempt to represent a car."""
    def __init__(self, make, model, year):
            """Initialize attributes to describe a car."""
            self.make = make
            self.model = model
            self.year = year
            self.odometer_reading = 0
            
    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles


class Battery:
    """A simple attempt to model a battery for an electric car."""
    
    def __init__(self, battery_size=75):
        """Initialize the battery's attributes."""
        self.battery_size = battery_size
        
    def describe_battery(self):
        """Print a statement describing the battery size."""
        print(f"This car has a {self.battery_size}-kWh battery.")
    
    def get_range(self):
        """Print a statement about the range this battery provides."""
        if self.battery_size == 75:
            range = 260
        elif self.battery_size == 100:
            range = 315

        print(f"This car can go about {range} miles on a full charge.")


class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
 
    def __init__(self, make, model, year):
        """
        Initialize attributes of the parent class.
        Then initialize attributes specific to an electric car.
        """
        super().__init__(make, model, year)
        self.battery = Battery()
```

In the following text, some different ways of importing class are showed.

## Import a single class

```python
from car import ElectricCar

my_tesla = ElectricCar('tesla', 'model s', 2019)

print(my_tesla.get_descriptive_name())
my_tesla.battery.describe_battery()
my_tesla.battery.get_range()
```

    2019 Tesla Model S
    This car has a 75-kWh battery.
    This car can go about 260 miles on a full charge.

## Import multiple classes


```python
from car import Car, ElectricCar

my_beetle = Car('volkswagen', 'beetle', 2019)
print(my_beetle.get_descriptive_name())

my_tesla = ElectricCar('tesla', 'roadster', 2019)
print(my_tesla.get_descriptive_name())
```

    2019 Volkswagen Beetle
    2019 Tesla Roadster


## Import an entire module


```python
import car

my_beetle = car.Car('volkswagen', 'beetle', 2019)
print(my_beetle.get_descriptive_name())

my_tesla = car.ElectricCar('tesla', 'roadster', 2019)
print(my_tesla.get_descriptive_name())
```

    2019 Volkswagen Beetle
    2019 Tesla Roadster


## Import all classes from a module

We can import every class from a module using the following syntax:

```python
from module_name import *
```

However, this method is not recommended. 

## Import a module into another module

We can separate [`car.py`](#car-module) into two files `gas_car.py` and `electric_car.py`:

```python
# gas_car.py

class Car:
    """A simple attempt to represent a car."""
    def __init__(self, make, model, year):
            """Initialize attributes to describe a car."""
            self.make = make
            self.model = model
            self.year = year
            self.odometer_reading = 0
            
    def get_descriptive_name(self):
        """Return a neatly formatted descriptive name."""
        long_name = f"{self.year} {self.make} {self.model}"
        return long_name.title()

    def read_odometer(self):
        """Print a statement showing the car's mileage."""
        print(f"This car has {self.odometer_reading} miles on it.")

    def update_odometer(self, mileage):
        """
        Set the odometer reading to the given value.
        Reject the change if it attempts to roll the odometer back.
        """
        if mileage >= self.odometer_reading:
            self.odometer_reading = mileage
        else:
            print("You can't roll back an odometer!")

    def increment_odometer(self, miles):
        """Add the given amount to the odometer reading."""
        self.odometer_reading += miles
```

```python
# electric_car.py

from gas_car import Car # import the `gas_car` module.

class Battery:
    """A simple attempt to model a battery for an electric car."""
    
    def __init__(self, battery_size=75):
        """Initialize the battery's attributes."""
        self.battery_size = battery_size
        
    def describe_battery(self):
        """Print a statement describing the battery size."""
        print(f"This car has a {self.battery_size}-kWh battery.")
    
    def get_range(self):
        """Print a statement about the range this battery provides."""
        if self.battery_size == 75:
            range = 260
        elif self.battery_size == 100:
            range = 315

        print(f"This car can go about {range} miles on a full charge.")

        
class ElectricCar(Car):
    """Represent aspects of a car, specific to electric vehicles."""
 
    def __init__(self, make, model, year):
        """
        Initialize attributes of the parent class.
        Then initialize attributes specific to an electric car.
        """
        super().__init__(make, model, year)
        self.battery = Battery()
```

We can use two classes normally:

```python
import gas_car, electric_car

my_beetle = gas_car.Car('volkswagen', 'beetle', 2019)
print(my_beetle.get_descriptive_name())

my_tesla = electric_car.ElectricCar('tesla', 'roadster', 2019)
print(my_tesla.get_descriptive_name())
```

```
2019 Volkswagen Beetle
2019 Tesla Roadster
```

## Give a class an alias

```python
from electric_car import ElectricCar as EC

my_tesla = EC('tesla', 'roadster', 2019)
print(my_tesla.get_descriptive_name())
```

```
2019 Tesla Roadster
```

<br>

# Style classes

There are several conventions when styling classes.

- Class names should be written in <i class="term">CamelCase</i>. To do this, capitalize the first letter of each word in the name, and don’t use underscores. Instance and module names should be written in lowercase with underscores between words. 
- Every class should have a <i class="term">docstring</i> immediately following the class definition. The docstring should be a brief description of what the class does, and we should follow the same formatting conventions used for writing docstrings in functions[^5]. Each module should also have a docstring describing what the classes in a module can be used for.
- We can use blank lines to organize code, but don’t use them excessively. Within a class we can use <i class="emphasize">one blank line</i> between methods, and within a module use <i class="emphasize">two blank lines</i> to separate classes.
- If there is need to import a module from the standard library and a module that we ever wrote, <i class="emphasize">place the import statement for the standard library module first</i>. Then <i class="emphasize">add a blank line</i> and the import statement for the module we wrote. In programs with multiple import statements, this convention makes it easier to see where the different modules used in the program come from.

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 157-182.
[^2]: [Constructor (object-oriented programming) - Wikipedia](https://en.wikipedia.org/wiki/Constructor_(object-oriented_programming)).
[^3]: [constructor - JavaScript \| MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/constructor).

[^4]: [Python Function - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-08-19/15-58-32.html).

[^5]: [Python Function: Style functions and modules - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-08-19/15-58-32.html#style-functions-and-modules).
