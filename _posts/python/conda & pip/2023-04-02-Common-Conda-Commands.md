---
title: Common Conda Commands
categories: 
 - Python
tags:
 - Python conda
date: 2023-04-02 16:15:03 +0800
last_modified_at: 2024-10-05 20:27:46 +0800
---

# Manage environment

## Create environment

创建一个虚拟环境，并安装python：

```shell
conda create --name $ENVIRONMENT_NAME python
```

例如：

```shell
conda create --name newenv python
```

## Activate and deactivate environment

激活环境

```shell
conda activate $ENVIRONMENT_NAME
```

退出环境：

```shell
conda deactivate
```

例如：

![image-20230402150133736](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402150133736.png?raw=true)

## List all available environments


查看conda中的环境信息：

```shell
conda info --envs
```

例如：

![image-20230402150242734](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402150242734.png?raw=true)

注：其中的\*代表当前所处的环境。
{: .notice--primary}

## Modify default installment path

从上面的例子中可以看到，虽然Anaconda安装在D盘，但是新环境安装在了C盘，默认安装在`C:\Users\username\.conda\envs`下。可以按照博客 [2] 中提供的方法修改环境的默认安装路径。

首先找到`.condarc`文件（位于`C:\Users\username`文件夹下），用记事本打开该文件，添加以下的代码：

```
envs_dirs:
  - G:\anaconda3\envs
```

此时，查看`envs_dirs`信息：

```shell
conda config --show
```

可以看到其中的`envs_dirs`中的配置信息已经进行了修改：

![image-20230402155716982](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402155716982.png?raw=true)

新建的路径已经成为了首选的环境路径。此时，再创建一个新的环境`newevns2`，并查看它的路径信息：

```shell
conda create --name newevns2 python
...
conda info --envs
```

![image-20230402160009034](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402160009034.png?raw=true)

## Remove environment

删除指定环境：

```shell
conda remove -n newenv --all
...
conda remove -n newevns2 python
```

<br>

# Manage packages

## Install packages

安装包：

```shell
conda install $PACKAGE_NAME 
```

例如安装指定版本的python：

安装python：

```shell
conda install python=x.x
```

从特定channel安装包：

```shell
conda install --channel $URL $PACKAGE_NAME
```

安装其他包管理器，例如安装pip：

```shell
conda install pip
```


## Update packages

更新包：

```shell
conda update --name $ENVIRONMENT_NAME $PACKAGE_NAME 
```

## Update packages manager

更新包管理器

```shell
conda update conda
```

## Remove packages

卸载软件包

```shell
conda remove --name $ENVIRONMENT_NAME $PACKAGE_NAME
```

## Search available packages

搜索可用的包：

```shell
conda search $SEARCH_TERM
```

## List installed packages

列出已安装的包：

```shell
conda list --name $ENVIRONMENT_NAME
```

<br>

# Create requirements file

创建需求文件：

```shell
conda list --export
```

<br>

**References**

[1] [Spyder says: Don't mix pip and conda](https://www.youtube.com/watch?v=Ul79ihg41Rs).

[2] [Anaconda 安装及修改环境默认位置](https://www.iotword.com/10057.html#:~:text=Anaconda 安装及修改环境默认位置 1 1.官网下载安装包 2 2.安装 一路next即可，安装位置可改到D盘 3,如果安装在D盘，但是默认虚拟环境会在C盘 可用以下命令进行查看虚拟环境位置 conda info onda环境默认安装在用户目录C%3A\Users\username.conda\envs下，如果选择默认路径，那么之后创建虚拟环境，也是安装在用户目录下。 不想占用C盘空间，可以修改conda虚拟环境路径。 (1)首先，找到用户目录下的.condarc文件（C%3A\Users\username）。 ).

[3] [Command reference](https://docs.conda.io/projects/conda/en/latest/commands.html).
