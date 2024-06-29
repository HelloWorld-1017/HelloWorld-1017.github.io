---
layout: single
title: Physical Constants of Foundation Domain of MATLAB Simulink Simscape Components
date: 2022-08-26 10:35:17 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Simulink
toc: false
tagline: ""
header: 
  overlay_color: '#333'
---

MATLAB Simulink中的Simscape模块可以针对不同的物理场进行建模，由Simscape language编写的 .ssc 文件所定义。

例如，对于 `Reluctance Force Actuator` 模块：

![image-20220826104135660](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826104135660.png?raw=true)

它所对应的 `reluctance_force_actuator.ssc` 文件如下：

```matlab
component reluctance_force_actuator
% Reluctance Force Actuator :2.0
% Represents a generic magnetomotive device based on the reluctance force
%
% F = -0.5 * PHI^2 * dR/dx
%
% where R is the reluctance dependent on the thickness of, or length of,
% the air gap x, and PHI is the flux in the magnetic circuit.
%
% The magnetic force produced acts to close the air gap, i.e. the
% resulting force is negative acting from the mechanical C to R ports.

% Copyright 2009-2016 The MathWorks, Inc.

nodes
    N = foundation.magnetic.magnetic; % N:top
    S = foundation.magnetic.magnetic; % S:bottom
    R = foundation.mechanical.translational.translational; % R:top
    C = foundation.mechanical.translational.translational; % C:bottom
end

parameters
    x0 = { 2, 'mm' };               % Initial air gap
    xmin = { 1e-4, 'mm' };          % Minimum air gap
    CSA = { 0.01, 'm*m' };          % Cross-sectional area
    mur = { 1, '1' };               % Relative permeability of material
    K_contact = { 1e6, 'N/m'};      % Contact stiffness
    D_contact = { 500, 'N*s/m'};    % Contact damping
end

variables
    mmf =  { 0, 'A' };   % MMF
    phi =  { 0, 'Wb' };  % Flux
    f =    { 0, 'N' };   % Force
    u =    { 0, 'm/s' }; % Velocity
end

variables(Access=private)    
    x =  {value=x0, priority=priority.high}; % Air gap
end

branches
    phi : N.phi -> S.phi;
    f   : C.f   -> R.f;
end

equations
    assert(x0>=xmin)
    assert(xmin>0)
    assert(CSA>0)
    assert(mur>0)
    assert(K_contact>0)
    assert(D_contact>0)
    mmf == N.mmf - S.mmf;
    u   == R.v - C.v;
    u == x.der;
    if x > xmin
        mmf == phi*x/(N.mu0*mur*CSA);
        f == -0.5*phi^2*1/(N.mu0*mur*CSA);
    else
        mmf == phi*xmin/(N.mu0*mur*CSA);
        f == -0.5*phi^2*1/(N.mu0*mur*CSA) + K_contact*(xmin-x) - D_contact*u;
    end
end

end
```

其中，声明 `nodes` 的部分：

```matlab
nodes
    N = foundation.magnetic.magnetic; % N:top
    S = foundation.magnetic.magnetic; % S:bottom
    R = foundation.mechanical.translational.translational; % R:top
    C = foundation.mechanical.translational.translational; % C:bottom
end
```

可以看到这个部件是关于 magnetic domain 和 translational domain 的建模。在定义关系的 `equations` 部分中，该模块用到了 `N.mu0` 来调用真空磁导率：

```matlab
equations
    assert(x0>=xmin)
    assert(xmin>0)
    assert(CSA>0)
    assert(mur>0)
    assert(K_contact>0)
    assert(D_contact>0)
    mmf == N.mmf - S.mmf;
    u   == R.v - C.v;
    u == x.der;
    if x > xmin
        mmf == phi*x/(N.mu0*mur*CSA);
        f == -0.5*phi^2*1/(N.mu0*mur*CSA);
    else
        mmf == phi*xmin/(N.mu0*mur*CSA);
        f == -0.5*phi^2*1/(N.mu0*mur*CSA) + K_contact*(xmin-x) - D_contact*u;
    end
end
```

这样的操作在 MATLAB 命令行中是无效的，它只有在 .ssc 文件中才是可行的。所以，如果我们想要查看这个常数的具体值，可以电脑中的 `magnetic.ssc` 文件中找到，还可以在官方文档中找到：[Magnetic Domain - MathWorks](https://ww2.mathworks.cn/help/physmod/simscape/lang/magnetic-domain.html)：

```matlab
domain magnetic
% Magnetic Domain

% Copyright 2009 The MathWorks, Inc.

  parameters
    mu0 = { 4*pi*1e-7 'Wb/(m*A)' };   % Permeability constant
  end

  variables
    mmf = { 0 , 'A' }; % MMF
  end

  variables(Balancing = true)
    phi = { 0 , 'Wb' }; % Flux
  end

end

```

可以看到，在 `paramaters` 部分，该文件定义了 `mu0` 具体的值。

按照这个方法，同样可以查看其他物理域的内置常数，详见： [Foundation Domain Types and Directory Structure - MathWorks](https://ww2.mathworks.cn/help/physmod/simscape/lang/foundation-domain-types-and-directory-structure.html)。

