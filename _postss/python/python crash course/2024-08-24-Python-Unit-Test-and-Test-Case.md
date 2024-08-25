---
title: Python Unit Test and Test Case by `unittest` Module
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
 - Python Jupyter Notebook
 - Python unittest
date: 2024-08-24 16:42:33 +0800
last_modified_at: 2024-08-24 21:51:18 +0800
---

This post is a record made while learning Chapter 11 “Testing Your Code” in Eric Matthes’s book, Python Crash Course.[^1]
{: .notice--primary}

# Test a function

Here, we define a function `get_formatted_name()` and simply test its function:


```python
def get_formatted_name(first, last):
    """Generate a neatly formatted full name."""
    full_name = f"{first} {last}"
    return full_name.title()

print("Enter 'q' at any time to quit.")
while True:
    first = input("\nPlease give me a first name: ")
    if first == 'q':
        break
    last = input("Please give me a last name: ")
    if last == 'q':
        break
 
    formatted_name = get_formatted_name(first, last)
    print(f"\tNeatly formatted name: {formatted_name}.")
```

    Enter 'q' at any time to quit.
    
    Please give me a first name: tommy
    Please give me a last name: shelby
    	Neatly formatted name: Tommy Shelby.
    
    Please give me a first name: q

## Unit test and test case

Python module `unittest`[^4] from the Python standard library provides tools for testing the code. A <i class="term">unit test</i> verifies that <i class="emphasize">one specific aspect</i> of a function’s behavior is correct. A <i class="term">test case</i> is <i class="emphasize">a collection of</i> unit tests that together prove that a function behaves as it’s supposed to, within the full range of situations we expect it to handle.

A good test case considers all the possible kinds of input a function could receive and includes tests to represent each of these situations. A test case with <i class="term">full coverage</i> includes a full range of unit tests covering all the possible ways users can use a function. Achieving full coverage on a large project is usually ideal. It’s often good enough to write tests for code’s critical behaviors and then aim for full coverage <i class="emphasize">only if the project starts to see widespread use</i>.

## A passing test

To write a test case for a function, import the `unittest` module and the function to test. Then, create a class that inherits from the class `unittest.TestCase`, and write a series of methods to test different aspects of the function’s behavior.

Here’s a test case with one method that verifies that the function `get_formatted_name()` works correctly when given a first and last name:

<div id="script-1"></div>


```python
import unittest

def get_formatted_name(first, last):
    """Generate a neatly formatted full name."""
    full_name = f"{first} {last}"
    return full_name.title()

class NamesTestCase(unittest.TestCase):
    """Tests for 'name_function.py'."""
    
    def test_first_last_name(self):
        """Do names like 'Janis Joplin' work?"""
        formatted_name = get_formatted_name('janis', 'joplin')
        self.assertEqual(formatted_name, 'Janis Joplin')

if __name__ == '__main__':
#     unittest.main(argv=['first-arg-is-ignored'], exit=False)
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_first_last_name (__main__.NamesTestCase.test_first_last_name)
    Do names like 'Janis Joplin' work? ... ok
    
    ----------------------------------------------------------------------
    Ran 1 test in 0.001s
    
    OK

Note: To normally run `unittest`'s main function in Jupyter Notebook, simple `unittest.main()` is not necessary. We should use `unittest.main(argv=['ignored', '-v'], exit=False)` or `unittest.main(argv=['first-arg-is-ignored'], exit=False)` instead, which prevent `unittest.main` from trying to shutdown the kernel process[^2][^3].
{: .notice--warning}

As can be seen, we create a class called `NamesTestCase` (it’s better to make a class name relating to the function we’re about to test and containing the word “Test”). The class `NamesTestCase` contains one or some <i class="emphasize">unit tests</i> for `get_formatted_name()`, and it must inherit from the class `unittest.TestCase` so Python knows how to run the tests within it.

In this simple case, `NamesTestCase` only contains a single method `test_first_last_name()` to test one aspect of `get_formatted_name()`, that is verifying names with only a first and last name are formatted correctly. Any method that <i class="emphasize">starts with `test_`</i> will be run automatically when we run the `unittest.main(argv=['ignored', '-v'], exit=False)`. Within a test method, we call the function we want to test, like in this example we call `get_formatted_name()` with the arguments `'janis'` and `'joplin'`, and assign the result to the variable `formatted_name`.

Then, we use one of `unittest`’s most useful features: <i class="term">assert</i> method. Assert methods verify that a result <i class="emphasize">received</i> matches the result we <i class="emphasize">expected to receive</i>. In this example, we expect the value of `formatted_name` to be `Janis Joplin`, and in order to check if this is true, we use `unittest`’s `assertEqual()` method and pass it `formatted_name` and `'Janis Joplin'`.

After running the [script](#script-1), message `Ran 1 test in 0.001s` tells us the number of tests and elapsed time; final `OK` tells that unit tests in the test case passed.

## A failing test


```python
import unittest

def get_formatted_name(first, middle, last):
    """Generate a neatly formatted full name."""
    full_name = f"{first} {middle} {last}"
    return full_name.title()

class NamesTestCase(unittest.TestCase):
    """Tests for 'name_function.py'."""
    
    def test_first_last_name(self):
        """Do names like 'Janis Joplin' work?"""
        formatted_name = get_formatted_name('janis', 'joplin')
        self.assertEqual(formatted_name, 'Janis Joplin')

if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_first_last_name (__main__.NamesTestCase.test_first_last_name)
    Do names like 'Janis Joplin' work? ... ERROR
    
    ======================================================================
    ERROR: test_first_last_name (__main__.NamesTestCase.test_first_last_name)
    Do names like 'Janis Joplin' work?
    ----------------------------------------------------------------------
    Traceback (most recent call last):
      File "C:\Users\whatastarrynight\AppData\Local\Temp\ipykernel_13952\4024878731.py", line 13, in test_first_last_name
        formatted_name = get_formatted_name('janis', 'joplin')
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    TypeError: get_formatted_name() missing 1 required positional argument: 'last'
    
    ----------------------------------------------------------------------
    Ran 1 test in 0.001s
    
    FAILED (errors=1)

Here, the test `test_first_last_name()` in `NamesTestCase` causes an error, and the traceback reposts that the function call `get_formatted_name('janis', 'joplin')` no longer works because a required positional argument is missing.

Then, we should respond to this failed test. By modifying `get_formatted_name()` function as follows, we can make the unit test `test_first_last_name()` pass:


```python
import unittest

def get_formatted_name(first, last, middle=''):
    """Generate a neatly formatted full name."""
    if middle:
        full_name = f"{first} {middle} {last}"
    else:
        full_name = f"{first} {last}"
    return full_name.title()

class NamesTestCase(unittest.TestCase):
    """Tests for 'name_function.py'."""
    
    def test_first_last_name(self):
        """Do names like 'Janis Joplin' work?"""
        formatted_name = get_formatted_name('janis', 'joplin')
        self.assertEqual(formatted_name, 'Janis Joplin')

if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_first_last_name (__main__.NamesTestCase.test_first_last_name)
    Do names like 'Janis Joplin' work? ... ok
    
    ----------------------------------------------------------------------
    Ran 1 test in 0.001s
    
    OK


## Add more tests


```python
import unittest

def get_formatted_name(first, last, middle=''):
    """Generate a neatly formatted full name."""
    if middle:
        full_name = f"{first} {middle} {last}"
    else:
        full_name = f"{first} {last}"
    return full_name.title()

class NamesTestCase(unittest.TestCase):
    """Tests for 'name_function.py'."""
    
    def test_first_last_name(self):
        """Do names like 'Janis Joplin' work?"""
        formatted_name = get_formatted_name('janis', 'joplin')
        self.assertEqual(formatted_name, 'Janis Joplin')
        
    def test_first_last_middle_name(self):
        """Do names like 'Wolfgang Amadeus Mozart' work?"""
        formatted_name = get_formatted_name('wolfgang', 'mozart', 'amadeus')
        self.assertEqual(formatted_name, 'Wolfgang Amadeus Mozart')

if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_first_last_middle_name (__main__.NamesTestCase.test_first_last_middle_name)
    Do names like 'Wolfgang Amadeus Mozart' work? ... ok
    test_first_last_name (__main__.NamesTestCase.test_first_last_name)
    Do names like 'Janis Joplin' work? ... ok
    
    ----------------------------------------------------------------------
    Ran 2 tests in 0.001s
    
    OK

It’s fine to have long method names in the `TestCase` classes---they need to be descriptive so we can make sense of the output when the tests fail. On other hand, we don’t have to worry about the inconvenience of using long method names because we’ll never have to write code that calls these methods.

<br>

# Test a class

## A variety of assert methods

Python provides a number of assert methods in the `unittest.TestCase` class. Including above `assertEqual()`, there are six commonly used assert methods available from the `unittest` module:

- `assertEqual(a, b)`: Verify that `a == b`
- `assertNotEqual(a, b)`: Verify that `a != b`
- `assertTrue(x)`: Verify that `x` is `True`
- `assertFalse(x)`: Verify that `x` is `False`
- `assertIn(item, list)`: Verify that item is `in` list
- `assertNotIn(item, list)`: Verify that item is `not in` list

Of course, we can only use these methods in a class that inherits from `unittest.TestCase`.

## A class to test

Testing a class is similar to testing a function---much of the work involves testing the behavior of methods in a class. In the following code, we create a class named `AnonymousSurvey` and test its behaviors:


```python
class AnonymousSurvey:
    """Collect anonymous answers to a survey question."""
    
    def __init__(self, question):
        """Store a question, and prepare to store responses."""
        self.question = question
        self.responses = []
        
    def show_question(self):
        """Show the survey question."""
        print(self.question)
        
    def store_response(self, new_response):
        """Store a single response to the survey."""
        self.responses.append(new_response)
        
    def show_results(self):
        """Show all the responses that have been given."""
        print("Survey results:")
        for response in self.responses:
            print(f"- {response}")

# Define a question, and make a survey.
question = "What language did you first learn to speak?"
my_survey = AnonymousSurvey(question)

# Show the question, and store responses to the question.
my_survey.show_question()
print("Enter 'q' at any time to quit.\n")
while True:
    response = input("Language: ")
    if response == 'q':
        break
    my_survey.store_response(response)

# Show the survey results.
print("\nThank you to everyone who participated in the survey!")
my_survey.show_results()
```

    What language did you first learn to speak?
    Enter 'q' at any time to quit.
    
    Language: English
    Language: Spanish
    Language: English
    Language: Mandarin
    Language: q
    
    Thank you to everyone who participated in the survey!
    Survey results:
    - English
    - Spanish
    - English
    - Mandarin


## Test the `AnonymousSurvey` class

Following test `test_store_single_response()` uses the `assertIn()` method to verify whether a single response to the survey question is in the list of responses after it’s been stored:


```python
import unittest

class AnonymousSurvey:
    """Collect anonymous answers to a survey question."""
    
    def __init__(self, question):
        """Store a question, and prepare to store responses."""
        self.question = question
        self.responses = []
        
    def show_question(self):
        """Show the survey question."""
        print(self.question)
        
    def store_response(self, new_response):
        """Store a single response to the survey."""
        self.responses.append(new_response)
        
    def show_results(self):
        """Show all the responses that have been given."""
        print("Survey results:")
        for response in self.responses:
            print(f"- {response}")
            
class TestAnonymousSurvey(unittest.TestCase):
    """Tests for the class AnonymousSurvey"""
    def test_store_single_response(self):
        """Test that a single response is stored properly."""
        question = "What language did you first learn to speak?"
        my_survey = AnonymousSurvey(question) # make an instance of the class
        my_survey.store_response('English')
        self.assertIn('English', my_survey.responses)

if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_store_single_response (__main__.TestAnonymousSurvey.test_store_single_response)
    Test that a single response is stored properly. ... ok
    
    ----------------------------------------------------------------------
    Ran 1 test in 0.001s
    
    OK

Take it further, we can verify that three responses can be stored correctly, by following `test_store_three_responses()` method:

<div id="script-2"></div>

```python
import unittest

class AnonymousSurvey:
    """Collect anonymous answers to a survey question."""
    
    def __init__(self, question):
        """Store a question, and prepare to store responses."""
        self.question = question
        self.responses = []
        
    def show_question(self):
        """Show the survey question."""
        print(self.question)
        
    def store_response(self, new_response):
        """Store a single response to the survey."""
        self.responses.append(new_response)
        
    def show_results(self):
        """Show all the responses that have been given."""
        print("Survey results:")
        for response in self.responses:
            print(f"- {response}")
            
class TestAnonymousSurvey(unittest.TestCase):
    """Tests for the class AnonymousSurvey"""
    def test_store_single_response(self):
        """Test that a single response is stored properly."""
        question = "What language did you first learn to speak?"
        my_survey = AnonymousSurvey(question) # make an instance of the class
        my_survey.store_response('English')
        self.assertIn('English', my_survey.responses)
    
    def test_store_three_responses(self):
        """Test that three individual responses are stored properly."""
        question = "What language did you first learn to speak?"
        my_survey = AnonymousSurvey(question)  # make an instance of the class
        responses = ['English', 'Spanish', 'Mandarin']
        for response in responses:
            my_survey.store_response(response)
        
        for response in responses:
            self.assertIn(response, my_survey.responses)

if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_store_single_response (__main__.TestAnonymousSurvey.test_store_single_response)
    Test that a single response is stored properly. ... ok
    test_store_three_responses (__main__.TestAnonymousSurvey.test_store_three_responses)
    Test that three individual responses are stored properly. ... ok
    
    ----------------------------------------------------------------------
    Ran 2 tests in 0.001s
    
    OK

## `setUp()` method

In above [script](#script-2), when both defining `test_store_single_response()` method and `test_store_three_responses()` method, we create a new instance of `AnonymousSurvey` in each test method, and new responses in each method. It looks kind of repetitive.

The `unittest.TestCase` class has a `setUp()` method that allows us to create these objects once and then use them in every test method. If we set a `setUp()` method in a `TestCase` class, Python will run it <i class="emphasize">before running each method starting with `test_`</i>. Any objects created in the `setUp()` method are then available in each test method.


```python
import unittest

class AnonymousSurvey:
    """Collect anonymous answers to a survey question."""
    
    def __init__(self, question):
        """Store a question, and prepare to store responses."""
        self.question = question
        self.responses = []
        
    def show_question(self):
        """Show the survey question."""
        print(self.question)
        
    def store_response(self, new_response):
        """Store a single response to the survey."""
        self.responses.append(new_response)
        
    def show_results(self):
        """Show all the responses that have been given."""
        print("Survey results:")
        for response in self.responses:
            print(f"- {response}")
            
class TestAnonymousSurvey(unittest.TestCase):
    """Tests for the class AnonymousSurvey"""
    def setUp(self):
        """
        Create a survey and a set of responses for use in all test methods.
        """
        question = "What language did you first learn to speak?"
        self.my_survey = AnonymousSurvey(question)
        self.responses = ['English', 'Spanish', 'Mandarin']
    
    
    def test_store_single_response(self):
        """Test that a single response is stored properly."""
        self.my_survey.store_response(self.responses[0])
        self.assertIn(self.responses[0], self.my_survey.responses)
    
    def test_store_three_responses(self):
        """Test that three individual responses are stored properly."""
        for response in self.responses:
            self.my_survey.store_response(response)
        for response in self.responses:
            self.assertIn(response, self.my_survey.responses)

if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
```

    test_store_single_response (__main__.TestAnonymousSurvey.test_store_single_response)
    Test that a single response is stored properly. ... ok
    test_store_three_responses (__main__.TestAnonymousSurvey.test_store_three_responses)
    Test that three individual responses are stored properly. ... ok
    
    ----------------------------------------------------------------------
    Ran 2 tests in 0.002s
    
    OK

The method `setUp()` does two things: it creates a survey instance, and it creates a list of responses. Each of these is prefixed by `self`, so they can be used anywhere in the class. This makes the two test methods simpler, because neither one has to make a survey instance or a response. 

Anyway, when we’re testing our own classes, the `setUp()` method can make test methods easier to write. We can make one set of instances and attributes in `setUp()` and then use these instances in all test methods. This is much easier than making a new set of instances and attributes in each test method time and time again. From this perspective, this `setUp()` method resembles `__init__()` method of a Python class.

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 209-222.
[^2]: [python - Unable to run unittest's main function in ipython/jupyter notebook - Stack Overflow](https://stackoverflow.com/questions/37895781/unable-to-run-unittests-main-function-in-ipython-jupyter-notebook/38012249#38012249).
[^3]: [python ,unittest can't run . · Issue #2746 · jupyter/notebook](https://github.com/jupyter/notebook/issues/2746).

[^4]: [`unittest` — Unit testing framework — Python 3.12.5 documentation](https://docs.python.org/3/library/unittest.html).
