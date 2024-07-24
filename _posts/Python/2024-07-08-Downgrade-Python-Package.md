---
title: Downgrade Package by Python `pip`
toc: false
categories:
 - Python
tags:
 - Python pip
 - Python NumPy
 - Python Dependency Conflicts
date: 2024-07-08 19:04:51 +0800
last_modified_at: 2024-07-08 19:04:51 +0800
---

Recently, when I execute a Python command, a warning occurred:

```
A module that was compiled using NumPy 1.x cannot be run in
NumPy 2.0.0 as it may crash. To support both 1.x and 2.x
versions of NumPy, modules must be compiled with NumPy 2.0.
Some module may need to rebuild instead e.g. with 'pybind11>=2.12'.

If you are a user of the module, the easiest solution will be to
downgrade to 'numpy<2' or try to upgrade the affected module.
We expect that some modules will need time to support NumPy 2.
```

which means that a Python package seems incompatible with Python NumPy 2.0.

According to the prompts, to solve this problem, I downgraded NumPy by the following command:

```powershell
pip install numpy<2
```

After it, `pip` uninstall previous NumPy package automatically, and download an old version, i.e.

```python
import numpy
numpy.__version__
```

```
'1.26.4'
```

By the way, NumPy 2.0.0 includes many breaking changes and new features according to the documentation[^1]:

<div class="quote--left" markdown="1">

NumPy 2.0.0 is the first major release since 2006. It is the result of 11 months of development since the last feature release and is the work of 212 contributors spread over 1078 pull requests. It contains a large number of exciting new features as well as changes to both the Python and C APIs.

This major release includes breaking changes that could not happen in a regular minor (feature) release - including an ABI break, changes to type promotion rules, and API changes which may not have been emitting deprecation warnings in 1.26.x. Key documents related to how to adapt to changes in NumPy 2.0, in addition to these release notes, include:

- The [NumPy 2.0 migration guide](https://numpy.org/devdocs/numpy_2_0_migration_guide.html#numpy-2-migration-guide)
- The [NumPy 2.0-specific advice](https://numpy.org/devdocs/dev/depending_on_numpy.html#numpy-2-abi-handling) in [For downstream package authors](https://numpy.org/devdocs/dev/depending_on_numpy.html#for-downstream-package-authors)

</div>

I think this is the reason for above packages clash problem.

<br>

**References**

[^1]: [NumPy 2.0.0 Release Notes — NumPy v2.1.dev0 Manual](https://numpy.org/devdocs/release/2.0.0-notes.html).

