import numpy
import matplotlib.pyplot as plt
import sys, time
%matplotlib inline             
%config InlineBackend.figure_format = 'svg'

nx = 41
dx = 2/(nx-1) # deta x: 0.05
nt = 25       # nt is the number of timesteps we want to calculate
dt = .025     # delt t: 0.025
c = 1         # assume wavespeed of c = 1

u = numpy.ones(nx)
u[int(.5/dx):int(1/dx+1)] = 2 #s etting u = 2 between 0.5 and 1 as per our I.C.s (u0(x))
# print(u)

plt.plot(numpy.linspace(0,2,nx),u,label=r'$u^{t=0}$')   

un = numpy.ones(nx)

for n in range(nt):
    un = u.copy()
    for i in range(1,nx): # i begin at 1
        u[i] = un[i]-c*(dt/dx)*(un[i]-un[i-1])
        print(i)
        
plt.plot(numpy.linspace(0,2,nx),u,label=r'$u^{t=n}$')
plt.xlabel('x')
plt.ylabel('u')
plt.legend()