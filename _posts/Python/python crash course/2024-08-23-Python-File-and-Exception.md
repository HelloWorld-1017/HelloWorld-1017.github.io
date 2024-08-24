---
title: Read and Write Files, and Handle Exceptions in Python
categories:
 - Python
tags:
 - Native Python
 - <i>Python Crash Course</i>
 - JSON
 - Python Warnings and Errors
date: 2024-08-23 23:28:32 +0800
last_modified_at: 2024-08-24 20:31:03 +0800
---

This post is a record made while learning Chapter 10 “Files and Exceptions” in Eric Matthes’s book, Python Crash Course.[^1]
{: .notice--primary}

# Read text from a file

## Read an entire file

We can use the following code to open the file `pi_digits.txt`, read and print its contents to the screen:


```python
with open('pi_digits.txt') as file_object:
    contents = file_object.read()
print(contents)
```

    3.1415926535
       8979323846
       2643383279

where the `pi_digits.txt` file contains $\pi$ to 30 decimal places with 10 decimal places per line:

```
3.1415926535
   8979323846
   2643383279
```

### `open()` function

To do <i class="emphasize">any</i> work with a file, we first need to <i class="emphasize">open</i> the file to <i class="emphasize">access</i> it by `open()` function; the `open()` function always returns an <i class="term">file object</i> representing the file. Specifically in this case, `open('pi_digits.txt')` returns an object representing `pi_digits.txt`, and Python assigns this object to the variable `file_object`.

Once we have a file object representing `pi_digits.txt`, we can use the `read()` method to read the entire contents of the file and store it as one long string in `contents`. When we print the value of `contents`, we get the entire text file back.

The only difference between this output and the original file is <i class="emphasize">the extra blank line at the end of the output</i>. The blank line appears because `read()` returns an empty string when it reaches <i class="term">the end of the file</i>; this empty string shows up as a blank line. If we want to remove the extra blank line, use `rstrip()` function in the call to `print()`:

```python
with open('pi_digits.txt') as file_object:
    contents = file_object.read()
    print(contents.rstrip())
```

```
3.1415926535
   8979323846
   2643383279
```

### `with` keyword

The `with` keyword is used to automatically close the file that was opened by `open()` function, especially helpful when a bug (or an error) occurs after opening the file by `open()` but not yet close the file by `close()` function:

<div class="quote--left" markdown="1">

The keyword `with` closes the file once access to it is no longer needed. Notice how we call `open()` in this program but not `close()`. You could open and close the file by calling `open()` and `close()`, but if a bug in your program prevents the `close()` method from being executed, the file may never close. This may seem trivial, but improperly closed files can cause data to be lost or corrupted. And if you call `close()` too early in your program, you’ll find yourself trying to work with a closed file (a file you can’t access), which leads to more errors. It’s not always easy to know exactly when you should close a file, but with the structure shown here, Python will figure that out for you. All you have to do is open the file and work with it as desired, trusting that Python will close it automatically when the `with` block finishes execution.

</div>

<div class="notice--warning" markdown="1">
I think the easiest method to judge whether or not a file is closed normally is checking if it can be deleted successfully.

If we execute the following code:

```python
file_object = open('pi_digits.txt')
print('9' >= 1)
file_object.close()
```

As expected, we’ll get an error:

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[2], line 2
      1 file_object = open('pi_digits.txt')
----> 2 print('9' >= 1)
      3 file_object.close()

TypeError: '>=' not supported between instances of 'str' and 'int'
```

and at this time, if we try to delete the file `pi_digits.txt`, a Windows error will occur, “The action cannot be completed because the file is open in Python”. It’s easy to understand because Python didn’t execute `file_object.close()`. If we want to delete the file successfully, we should run `file_object.close()` again.

On the other hand, by `with` keyword we have following code snippet to do the same work:

```python
with open('pi_digits.txt') as file_object:
    contents = file_object.read()
    print('9' >= 1)
    
print(contents)
```

```
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
Cell In[1], line 3
      1 with open('pi_digits.txt') as file_object:
      2     contents = file_object.read()
----> 3     print('9' >= 1)
      5 print(contents)

TypeError: '>=' not supported between instances of 'str' and 'int'
```

although the same error occurs, we can directly delete `pi_digits.txt` at this point. From this small example we can better understand the advantage brought by using `with`. 

</div>

Technically, the `with` keyword is simplified version of a `try-catch` block (or `try-finally` block), and it is not only available by combining with `open()` function---<i class="term">context managers</i> all support `with` statement, and `open()` function is a special <i class="term">context manager</i>. To make a context manager, we should define `__enter__()` and `__exit__()` methods for the class.

<div class="quote--left" markdown="1">
In Python, the `with` statement replaces a `try-catch` block with a concise shorthand. More importantly, it ensures closing resources right after processing them. A common example of using the `with` statement is reading or writing to a file. A function or class that supports the `with` statement is known as a <i class="term">context manager</i>. <i class="term">A context manager allows you to open and close resources right when you want to</i>. For example, the `open()` function is a context manager. When you call the `open()` function using the `with` statement, the file closes automatically after you’ve processed the file.[^10]

<br>

... the `with` statement replaces this kind of `try-catch` block[^10]:

```python
f = open("example.txt", "w")

try:
    f.write("hello world")
finally:
    f.close()
```

<br>

The `with` statement is popularly used with file streams, as shown above [`open()` function] and with <i class="term">Locks</i>, <i class="term">sockets</i>, <i class="term">subprocesses</i> and <i class="term">telnets</i> etc.[^6]

<br>

There is nothing special in `open()` which makes it usable with the `with` statement and the same functionality can be provided in user defined objects. Supporting `with` statement in your objects will ensure that you never leave any resource open. <i class="emphasize" markdown="1">To use `with` statement in user defined objects you only need to add the methods `__enter__()` and `__exit__()` in the object methods.</i>[^6]

<br>

</div>

See also references [^7][^8][^9] for more information about `with` keyword.

## Absolute file path vs. relative file path

If the text file isn’t in the current folder where the script file is put, we need to provide a file path for `open()` function to tell Python to look in the specific directory.

For example, if the file `pi_digits.txt` is on the Desktop, we could provide an <i class="term">absolute file path</i>:

```python
file_path = 'C:/Users/whatastarrynight/Desktop/pi_digits.txt'
# file_path = 'C:\\Users\\whatastarrynight\\Desktop\\pi_digits.txt'

with open(file_path) as file_object:
    contents = file_object.read()
    print(contents.rstrip())
```

```
3.1415926535
   8979323846
   2643383279
```

It’s okay to use forward slash `/` or double backslash `\\` to separate the file path, but single back slash `\\` is not available:

```python
file_path = 'C:\Users\whatastarrynight\Desktop\pi_digits.txt'

with open(file_path) as file_object:
    contents = file_object.read()
    print(contents.rstrip())
```

```
  Cell In[1], line 1
    file_path = 'C:\Users\whatastarrynight\Desktop\pi_digits.txt'
                                                                 ^
SyntaxError: (unicode error) 'unicodeescape' codec can't decode bytes in position 2-3: truncated \UXXXXXXXX escape
```

The reason is that, the backslash is used to start a <i class="term">escape characters</i> in Python strings, which is not our intention. For example, in the path "`C:\path\to\file.txt`", the sequence `\t` is interpreted as a tab. This also explains why `\\` works: the first backslash <i class="term">escape</i> the second one. 

If `pi_digits.txt` is in a sub-folder, say `text_files`, under the current folder, we can choose to provide a <i class="term">relative file path</i> for `open()` function:

```python
file_path = 'text_files\pi_digits.txt'
# file_path = 'text_files/pi_digits.txt'
# file_path = 'text_files\\pi_digits.txt'

with open(file_path) as file_object:
    contents = file_object.read()
    print(contents.rstrip())
```

```
3.1415926535
   8979323846
   2643383279
```

In the relative file path, it’s all fine to take `\`, `/`, or `\\` as a path delimiter.

## Read an entire file line by line using `for` loop

We can use a `for` loop on the file object to examine each line from a file one at a time:


```python
filename = 'pi_digits.txt'
with open(filename) as file_object:
    for line in file_object: # Loop over the file object
        print(line)
```

    3.1415926535
    
       8979323846
    
       2643383279

These blank lines appear because an invisible newline character is at the end of each line in the text file. The `print` function adds its own newline each time we call it, so we end up with <i class="emphasize">two newline characters</i> at the end of each line: one from the file and one from `print()` function. Similarly, we can use `rstrip()` function on each line to eliminate these extra blank lines.


```python
filename = 'pi_digits.txt'
with open(filename) as file_object:
    for line in file_object: # Loop over the file object
        print(line.rstrip())
```

    3.1415926535
       8979323846
       2643383279


## Make a list of lines from a file: `readlines()` method


```python
filename = 'pi_digits.txt'

with open(filename) as file_object:
    # The `readlines()` method takes each line from the file and stores it in a list.
    lines = file_object.readlines()

print(lines)

for line in lines:
    print(line.rstrip())
```

    ['3.1415926535\n', '   8979323846\n', '   2643383279']
    3.1415926535
       8979323846
       2643383279

Afterwards, we can further work with file’s contents, like concatenating above three lines as one long string:


```python
filename = 'pi_digits.txt'

with open(filename) as file_object:
    lines = file_object.readlines()

pi_string = ''
for line in lines:
    pi_string += line.strip()
 
print(pi_string)
print(len(pi_string))
```

    3.141592653589793238462643383279
    32

When Python reads from a text file, it interprets <i class="emphasize">all</i> text in the file as a string. If we read in a number and want to work with that value in a numerical context, we should convert it to an integer by `int()` function or to a float by `float()`.

## Read in a large file

The $\pi$ in above file `pi_digits.txt` only contains 30 decimal places, while that in `pi_million_digits.txt` (which can be obtained from[^2]) has 1,000,000 decimal places. We can adopt a similar method to read `pi_million_digits.txt` and concatenate its content together into a long string:


```python
filename = 'pi_million_digits.txt'

with open(filename) as file_object:
    lines = file_object.readlines()
    
pi_string = ''
for line in lines:
    pi_string += line.strip()
    
print(f"{pi_string[:52]}...")
print(len(pi_string))
```

    3.14159265358979323846264338327950288419716939937510...
    1000002

Based on which we can make an interesting program to find if someone’s birthday appears in the first million digits of $\pi$. Take mine, `101798` (in date format `mmddyy`):

```python
filename = 'pi_million_digits.txt'

with open(filename) as file_object:
    lines = file_object.readlines()
    
pi_string = ''
for line in lines:
    pi_string += line.strip()
    
birthday = input("Enter your birthday, in the form mmddyy: ")

if birthday in pi_string:
    print("Your birthday appears in the first million digits of pi!")
else:
    print("Your birthday does not appear in the first million digits of pi.")
```

    Enter your birthday, in the form mmddyy: 101798
    Your birthday appears in the first million digits of pi!

Interesting!

<br>

# Write to a file: `open()` function

One of the simplest ways to save data is to write it to a file. To do this, we need to call `open()` function with a second argument.

## Write to an empty file: write mode `'w'`


```python
filename = 'programming.txt'

with open(filename, 'w') as file_object:
    file_object.write("I love programming.")
```

In the `open()` function, the second argument `'w'` tells Python that we want to open the file in <i class="term">write mode</i>. In the write mode, the `open()` function will automatically create the file `programming.txt` if it doesn’t already exist in the current folder, and will erase the file’s contents before returning the file object if the file already exist.

Besides write mode, there are also some others: <i class="term">read mode</i> `'r'` (default), <i class="term">write mode</i> `'w'`, <i class="term">append mode</i> `'a'`, and a mode that allows us to read and write to the file `'r+'`.
{: .notice--primary}

The `write()` method on the file object is used to write a string to the file. By running above script, there is no any terminal output, but we can see one line in `programming.txt`:

```
I love programming.
```

Python can only write <i class="emphasize">strings</i> to a text file. If we want to output numerical data to a text file, we need to convert the data to string format first using `str()` function.

The `write()` function doesn’t add any newlines to the text we write. So if we want to write the text more than one line to the file, we could add some newline characters:


```python
filename = 'programming.txt'

with open(filename, 'w') as file_object:
    file_object.write("I love programming.\n")
    file_object.write("I love creating new games.\n")
```

## Append content to a file: append mode, `'a'`

By opening a file in <i class="term">append mode</i> (with argument `'a'`), we can add content to the file rather than writing over existing content---Python doesn’t erase the contents of the file before returning the file object, and any lines we write to the file will be added at the end of the file. Similar to write mode, Python will create an empty file if the file doesn’t exist yet.


```python
filename = 'programming.txt'

with open(filename, 'a') as file_object:
    file_object.write("I also love finding meaning in large datasets.\n")
    file_object.write("I love creating apps that can run in a browser.\n")
```

```
I love programming.
I love creating new games.
I also love finding meaning in large datasets.
I love creating apps that can run in a browser.
```

<br>

# Exception

Python uses special <i class="emphasize">objects</i> called <i class="term">exceptions</i> to manage errors that arise during a program’s execution. If an error occurs that makes Python unsure what to do next, the program will halt, create an <i class="term">exception object</i>, and display a <i class="term">traceback</i>, which includes a report of the exception that was raised, but if we could write code to handle the exception properly, the program will continue running. 

Exceptions are handled with `try-except` blocks. A `try-except` block not only asks Python to do something, but also tells Python what to do if an exception is raised. When we use `try-except` blocks, our programs will continue running, without interrupting and exiting the program, even if things start to go wrong. Instead of tracebacks, which can be confusing for users to read, users will see friendly error messages that programmer write.

The function of Python `try-except` block is like MATLAB `try-catch` block[^4].
{: .notice--primary}

## Handle the `ZeroDivisionError` exception by `try-except` block

When we divide a number by zero in Python, an error will occur:

```python
print(5/0)
```


```
---------------------------------------------------------------------------
ZeroDivisionError                         Traceback (most recent call last)
Cell In[21], line 1
----> 1 print(5/0)

ZeroDivisionError: division by zero
```

In this example, `ZeroDivisionError` is a so-called <i class="term">exception object</i>, and we can use a `try-except` block to handle it, making Python provide a user-friendly prompt and not throw an error interrupting the program:

```python
try:
    print(5/0)
except ZeroDivisionError:
    print("You can't divide by zero!")
```

```
You can't divide by zero!
```

Generally, we put the code <i class="emphasize">(simple `print(5/0)` in this case)</i> which we think may raise an error into a `try` block. If the code in the `try` block work, Python will skip over the `except` block, otherwise, i.e. the code in the `try` block causes an error <i class="emphasize">(`ZeroDivisionError`)</i>, Python looks for an `except` block whose error matches the raised error <i class="emphasize">(`ZeroDivisionError`)</i> and runs the code in that block <i class="emphasize">(indented code followed by `except ZeroDivisionError:`, `print("You can't divide by zero!")`)</i>. As a result, users will see a friendly error message instead of a traceback.

We can put above code snippet into a more complicated case, showing as follows:

```python
print("Give me two numbers, and I'll divide them.")
print("Enter 'q' to quit.")

while True:
    first_number = input("\nFirst number: ")
    if first_number == 'q':
        break
    second_number = input("Second number: ")
    if second_number == 'q':
        break
        
    try:
        answer = int(first_number) / int(second_number)
    except ZeroDivisionError:
        print("You can't divide by 0!")
    else:
        print(answer)
```

```
Give me two numbers, and I'll divide them.
Enter 'q' to quit.

First number: 5
Second number: 0
You can't divide by 0!

First number: q
```

This example also shows how to use a complete `try-except-else` block. The additional `else` block contains any code that depends on the `try` block succeeding. 

Handling some particular errors correctly is especially important because the program usually has more work to do even if the error occurs, using exceptions to prevent crashes is practical. (This happens often in programs that prompt users for input. If the program responds to invalid input appropriately, it can prompt for more valid input instead of crashing.)

On the other hand, it’s also not a good idea to let users see tracebacks. Nontechnical users will be confused by them, and in a malicious setting, attackers will learn more than programmers want them to know from a traceback. For example, they’ll know the name of program file, and they’ll see a part of the code that isn’t working properly. A skilled attacker can sometimes use this information to determine which kind of attacks to use against the code.

Anyway, by anticipating likely sources of errors, we can write robust programs that continue to run even when they encounter invalid data and missing resources. The code will be resistant to innocent user mistakes and malicious attacks.

## Handle the `FileNotFoundError` exception


```python
filename = 'alice.txt'

try:
    with open(filename, encoding='utf-8') as f:
        contents = f.read()
except FileNotFoundError:
    print(f"Sorry, the file `{filename}` does not exist.")
```

    Sorry, the file `alice.txt` does not exist.

There are two changes here. One is the use of the variable `f` to represent the file object, which is a common convention. The second is the use of the <i class="term">encoding argument</i> of the `open()` function. This argument is needed when the system’s default encoding doesn’t match the encoding of the file that’s being read.

## A complicated example: count the approximate number of words in a text file

The following code snippet is used to count the approximate number of words in the text file `alice.txt` (*Alice in Wonderland*, the file can be also found in resource[^2]):


```python
filename = 'alice.txt'

try:
    with open(filename, encoding='utf-8') as f:
        contents = f.read()
except FileNotFoundError:
    print(f"Sorry, the file `{filename}` does not exist.")
else:
    # Count the approximate number of words in the file.
    words = contents.split()
    num_words = len(words)
    print(f"The file {filename} has about {num_words} words.")
```

    The file alice.txt has about 29461 words.

where the `split()` method separates a string into parts wherever it finds a space and stores all the parts of the string in a <i class="emphasize">list</i>. The result is a list of words from the string, although some punctuation may also appear with some of the words. BTW, the count is a little high because extra information is provided by the publisher in the text file.

Afterwards, by wrapping above code snippet in a function `count_words()`, we can easily work with multiple files:

Similarly, we can download text files `siddhartha.txt` and `little_women.txt` from resource[^2].
{: .notice--primary}


```python
def count_words(filename):
    """Count the approximate number of words in a file."""
    try:
        with open(filename, encoding='utf-8') as f:
            contents = f.read()
    except FileNotFoundError:
        print(f"Sorry, the file {filename} does not exist.")
    else:
        words = contents.split()
        num_words = len(words)
        print(f"The file {filename} has about {num_words} words.")


filenames = ['alice.txt', 'siddhartha.txt', 'moby_dict.txt', 'little_women.txt']
for filename in filenames:
    count_words(filename)
```

    The file alice.txt has about 29461 words.
    The file siddhartha.txt has about 42172 words.
    Sorry, the file moby_dict.txt does not exist.
    The file little_women.txt has about 189079 words.

Using the `try-except` block in this example provides two significant advantages: prevent users from seeing a traceback, and let the program continue analyzing the texts it’s able to find. If we don’t catch the `FileNotFoundError` that `moby_dict.txt` raised, the user would see a full traceback, and the program would stop running after trying to analyze `siddhartha.txt`, and hence would never analyze `little_women.txt`.

## Make a program fail silently: `pass` statement

We don’t need to report every exception. Sometimes, we probably want the program to fail silently when an exception occurs and continue on <i class="emphasize">as if nothing happened</i>. To make a program fail silently, we can write a `try` block as usual, but explicitly tell Python to do nothing in the `except` block by `pass` statement. 


```python
def count_words(filename):
    """Count the approximate number of words in a file."""
    try:
        with open(filename, encoding='utf-8') as f:
            contents = f.read()
    except FileNotFoundError:
        pass
    else:
        words = contents.split()
        num_words = len(words)
        print(f"The file {filename} has about {num_words} words.")


filenames = ['alice.txt', 'siddhartha.txt', 'moby_dict.txt', 'little_women.txt']
for filename in filenames:
    count_words(filename)
```

    The file alice.txt has about 29461 words.
    The file siddhartha.txt has about 42172 words.
    The file little_women.txt has about 189079 words.

The `pass` statement also acts as a placeholder. It’s a reminder that we’re <i class="emphasize">choosing</i> to do nothing <i class="emphasize">at a specific point</i> in the program’s execution and that we might want to <i class="emphasize">do something there later</i>. For example, in this program we might decide to write any missing filenames to a file called `missing_files.txt`. Our users wouldn’t see this file, but we, as a programmer, would be able to read the file and deal with any missing texts.

## Decide which errors to report

Well-written, properly tested code is not very prone to <i class="term">internal errors</i>, such as syntax or logical errors. But every time the program depends on something <i class="term">external</i>, such as user input, the existence of a file, or the availability of a network connection, there is a possibility of an exception being raised. A little experience will help us know where to include exception handling blocks in the program and how much to report to users about errors that arise.

<br>

# Save and read data by `json` module

## `json.dump()` and `json.load()` function

A simple way to save and read data is by using Python `json` module[^5]. Python `json` module allows us to dump simple Python data structures into a file (by `json.dump()` function):


```python
import json

numbers = [2, 3, 5, 7, 11, 13]

filename = 'numbers.json'

with open(filename, 'w') as f:
    json.dump(numbers, f)
```

 and load the data from that file (by `json.load()` function) the next time the program runs.


```python
import json

filename = 'numbers.json'
with open(filename) as f:
    numbers = json.load(f)

print(numbers)
```


## Save and read user-generated data

Saving data with JSON is useful when working with <i class="term">user-generated data</i> (i.e. user input in the following example):

<div id="script-1"></div>

```python
import json

# Load the username, if it has been stored previously.
# Otherwise, prompt for the username and store it.
filename = 'username.json'
try:
    with open(filename) as f:
        username = json.load(f)
except FileNotFoundError:
    username = input("What is your name? ")
    with open(filename, 'w') as f:
        json.dump(username, f)
        print(f"We'll remember you when you come back, {username}!")
else:
    print(f"Welcome back, {username}!")
```

If the file `username.json` doesn’t exist, 

```
What is your name? Eric
We'll remember you when you come back, Eric!
```

otherwise:

    Welcome back, Eric!

<br>

# Refactor an existing program

Often, we’ll come to a point where the program works, but we’ll recognize that we could improve the code by breaking it up into a series of functions that have specific jobs. This process is called <i class="term">refactoring</i>. Refactoring makes our code cleaner, easier to understand, and easier to extend.

For the above [script](#script-1), we can put the main code into a function `greet_user()`:

```python
import json

def greet_user():
    """Greet the user by name."""
    filename = 'username.json'
    try:
        with open(filename) as f:
            username = json.load(f)
    except FileNotFoundError:
        username = input("What is your name? ")
        with open(filename, 'w') as f:
            json.dump(username, f)
            print(f"We'll remember you when you come back, {username}!")
    else:
        print(f"Welcome back, {username}!")

greet_user()
```

Next, we can continue refactoring the `greet_user()` function so it’s not doing so many different tasks:

```python
import json

def get_stored_username():
    """Get stored username if available."""
    filename = 'username.json'
    try:
        with open(filename) as f:
            username = json.load(f)
    except FileNotFoundError:
        return None
    else:
        return username


def greet_user():
    """Greet the user by name."""
    username = get_stored_username()
    if username:
        print(f"Welcome back, {username}!")
    else:
        username = input("What is your name? ")
        filename = 'username.json'
        with open(filename, 'w') as f:
            json.dump(username, f)
            print(f"We'll remember you when you come back, {username}!")

greet_user()
```

At last, we could further make one more block of code out of the `greet_user()` function:

```python
import json

def get_stored_username():
    """Get stored username if available."""
    filename = 'username.json'
    try:
        with open(filename) as f:
            username = json.load(f)
    except FileNotFoundError:
        return None
    else:
        return username


def get_new_username():
    """Prompt for a new username."""
    username = input("What is your name? ")
    filename = 'username.json'
    with open(filename, 'w') as f:
        json.dump(username, f)
    return username


def greet_user():
    """Greet the user by name."""
    username = get_stored_username()
    if username:
        print(f"Welcome back, {username}!")
    else:
        username = get_new_username()
        print(f"We'll remember you when you come back, {username}!")

greet_user()
```

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 183-208.
[^2]: [Python编程：从入门到实践](https://www.ituring.com.cn/book/1861).
[^4]: [MATLAB `try-catch` Block - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-01-12/16-12-03.html).

[^5]: [json — JSON encoder and decoder — Python 3.12.5 documentation](https://docs.python.org/3/library/json.html).
[^6]: [`with` statement in Python - GeeksforGeeks](https://www.geeksforgeeks.org/with-statement-in-python/).
[^7]: [8. Compound statements — Python 3.12.5 documentation](https://docs.python.org/3/reference/compound_stmts.html#the-with-statement).
[^8]: [PEP 343 – The “with” Statement \| peps.python.org](https://peps.python.org/pep-0343/).
[^9]: [oop - Explaining Python's '`__enter__`' and '`__exit__`' - Stack Overflow](https://stackoverflow.com/questions/1984325/explaining-pythons-enter-and-exit)..
[^10]: [What Is the With Statement in Python? \| Built In](https://builtin.com/software-engineering-perspectives/what-is-with-statement-python).
