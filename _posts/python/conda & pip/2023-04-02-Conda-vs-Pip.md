---
title: "Python Packages Installation Tools: Conda vs. Pip"
categories: 
 - Python
tags:
 - Python conda
 - Python pip
toc: false
date: 2023-04-02 14:40:39 +0800
last_modified_at: 2024-10-05 20:28:43 +0800
---

<div class="notice--primary" markdown="1">

注：本文翻译自Conda官方博客：[Understanding Conda and Pip](https://www.anaconda.com/blog/understanding-conda-and-pip.).

Conda and pip are often considered as being nearly identical. Although some of the functionality of these two tools overlap, they were designed and should be used for different purposes. [Pip](https://pip.pypa.io/en/stable/) is the Python Packaging Authority’s recommended tool for installing packages from the [Python Package Index](https://pypi.org/), PyPI. Pip installs Python software packaged as wheels or source distributions. The latter may require that the system have compatible compilers, and possibly libraries, installed before invoking pip to succeed.

[Conda](https://conda.io/docs/) is a cross platform package and environment manager that installs and manages conda packages from the [Anaconda repository](https://repo.anaconda.com/) as well as from the [Anaconda Cloud](https://anaconda.org/). Conda packages are binaries. There is never a need to have compilers available to install them. Additionally conda packages are not limited to Python software. They may also contain C or C++ libraries, R packages or any other software.

This highlights a key difference between conda and pip. Pip installs Python packages whereas conda installs packages which may contain software written in any language. For example, before using pip, a Python interpreter must be installed via a system package manager or by downloading and running an installer. Conda on the other hand can install Python packages as well as the Python interpreter directly.

Another key difference between the two tools is that conda has the ability to create isolated environments that can contain different versions of Python and/or the packages installed in them. This can be extremely useful when working with data science tools as different tools may contain conflicting requirements which could prevent them all being installed into a single environment. Pip has no built in support for environments but rather depends on other tools like [virtualenv](https://virtualenv.pypa.io/en/latest/) or [venv ](https://docs.python.org/3/library/venv.html)to create isolated environments. Tools such as [pipenv](https://pipenv.readthedocs.io/en/latest/), [poetry](https://poetry.eustace.io/), and [hatch ](https://github.com/ofek/hatch)wrap pip and virtualenv to provide a unified method for working with these environments.

Pip and conda also differ in how dependency relationships within an environment are fulfilled. When installing packages, pip installs dependencies in a recursive, serial loop. No effort is made to ensure that the dependencies of all packages are fulfilled simultaneously. This can lead to environments that are broken in subtle ways, if packages installed earlier in the order have incompatible dependency versions relative to packages installed later in the order. In contrast, conda uses a satisfiability (SAT) solver to verify that all requirements of all packages installed in an environment are met. This check can take extra time but helps prevent the creation of broken environments. As long as package metadata about dependencies is correct, conda will predictably produce working environments.

Given the similarities between conda and pip, it is not surprising that some try to combine these tools to create data science environments. A major reason for combining pip with conda is when one or more packages are only available to install via pip. Over 1,500 packages are available in the Anaconda repository, including the most popular data science, machine learning, and AI frameworks. These, along with thousands of additional packages available on Anaconda cloud from channeling including [conda-forge](https://conda-forge.org/) and [bioconda](https://bioconda.github.io/), can be installed using conda. Despite this large collection of packages, it is still small compared to the over 150,000 packages available on PyPI. Occasionally a package is needed which is not available as a conda package but is available on PyPI and can be installed with pip. In these cases, it makes sense to try to use both conda and pip.

</div>

Conda和pip通常被认为是几乎相同的。尽管这两个工具的一些功能重叠，但它们的设计目的是不同的。Pip是Python Packaging Authority推荐的安装Python packages的工具，它从Python Package Index(即PyPI)中下载Python包。Pip安装打包为轮子(wheels)或源发行版(source distributions)的Python软件。后者可能需要系统安装兼容的compilers，可能还有libraries，然后才能成功调用pip。

Conda是一个跨平台(cross platform)软件包和环境管理器，用于安装并管理Anaconda repository以及Anaconda Cloud中的Conda软件包。Conda软件包都是二进制的(binaries)，不需要安装额外的compilers去安装它们。另外，conda包不仅限于Python软件，它们还可能包含C或C++ libraries，R packages或者其他软件。

这是Conda和pip一个关键的差异：Pip只能安装Python软件包，而Conda安装的软件包可能包含用任何语言编写的软件。例如，在使用pip之前，必须通过system package manager或者下载运行installer安装Python interpreter；而Conda能够直接安装Python packages和Python interpreter。

这两个工具另外一个重要的区别是，Conda能够创建独立的环境，这些环境中可以包含不同版本的Python和(或者)安装在其中的packages。当使用data science tools时，这一特性是非常有用的，因为不同的工具可能会包含冲突的requirements，这会导致它们不能安装在一个环境中。Pip本身不提供对于环境的支持，但是可以依赖其他工具，例如virtualenv或者venv来创建独立的环境；类似pipenv，poetry和hatch之类的工具可以将pip和virtualenv集成在一起，以提供一个统一的方法来管理环境。

Pip和conda在如何实现环境中的依赖关系方面也有所不同。安装软件包时，pip会在递归串行循环中安装依赖项，并不保证所有packages的依赖能够同时满足。如果安装得比较早的packages相对于安装得比较晚的包具有不兼容的依赖版本，则环境会以一种微妙的方式遭到破坏。相反，conda使用satisfiability solver(SAT solver)来验证所有packages的所有requirements都得到了满足。这个检查会耗费一些额外的时间，但是能够帮助避免创建出broken环境。只要关于依赖的package metadata是正确的，conda就会产生可预测的工作环境。

考虑到conda和pip的相似性，一些人试图将这些工具结合起来创建data science environments，这并不奇怪。混合使用pip和conda的一个主要原因是：有些packages只能通过pip安装。在Anaconda仓库中，有超过1,500个packages可供安装，包括最流行的data science，machine learning和AI框架。这些packages以及数以千计的额外的packages可以通过channels，conda-forge和bioconda，从Anaconda cloud中获取，并使用conda安装。尽管这些包已经很多了，但是和PyPI上超过150,000个packages相比，还是太少了。因此，有些packages只能通过pip安装而无法使用conda安装，在这些情况下，混合使用conda和pip安装和合理的。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402143224972.png?raw=true" alt="image-20230402143224972" style="zoom: 50%;" />

