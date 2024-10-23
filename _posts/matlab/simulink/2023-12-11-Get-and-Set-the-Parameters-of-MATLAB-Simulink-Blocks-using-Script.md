---
layout: single
title: Get and Set the Parameters of MATLAB Simulink Blocks using Script
categories:
 - MATLAB
tags:
 - MATLAB Simulink
toc: false
date: 2023-12-11 12:19:06 +0800
last_modified_at0: 2023-12-11 12:19:06 +0800
last_modified_at1: 2024-02-29 23:07:23 +0800
last_modified_at: 2024-02-29 23:07:23 +0800
---

In MATLAB, users can use the script to set parameters and then run the Simulink model. Specifically, we could use `set_param`[^1] to set the parameters of Simulink blocks (correspondingly, use `get_param`[^2] to get current parameter values) and run the model by `sim`[^3] function. However, if we want to use `set_param` and `get_param` functions, we must exactly specify the parameter name. And I have to say, it is kind of hard to find them, because these parameter names are not given in their corresponding official documentations. But luckily, the parameter names of all Simulink blocks are listed together and can be found in web pages “Common Block Properties”[^4] and “Block-Specific Parameters”[^5].

**Added on February 29, 2024.**

In practice, we don’t need to look up the aforementioned documentation[^5] every time, instead we could use `get_param` function[^2] to get all parameter names by inputting `"ObjectParameters"` property[^6]:

```matlab
get_param(block_name,"ObjectParameters")
```

which returns a structure listing all model parameters, or

```matlab
fieldnames(get_param(block_name,"ObjectParameters"))
```

which returns a cell array that only contains the model parameter names.

<br>

**References**

[^1]: [MATLAB `set_param`: Set Simulink parameter value - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/set_param.html).
[^2]: [MATLAB `get_param`: Get parameter names and values - MathWorks](https://ww2.mathworks.cn/help/releases/R2022a/simulink/slref/get_param.html).
[^3]: [MATLAB `sim`: Simulate a Simulink model - MathWorks](https://ww2.mathworks.cn/help/releases/R2022a/simulink/slref/sim.html).
[^4]: [Common Block Properties - MathWorks](https://ww2.mathworks.cn/help/releases/R2022a/simulink/slref/common-block-parameters.html).
[^5]: [Block-Specific Parameters - MathWorks](https://ww2.mathworks.cn/help/releases/R2022a/simulink/slref/block-specific-parameters.html).
[^6]: [MATLAB `get_param`: Get parameter names and values - Get Model Parameter Names - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/get_param.html#mw_cbf712c7-8705-428e-9a20-8b1ee41d36af).



