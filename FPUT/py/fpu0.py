import matplotlib.pyplot as plt
import numpy as np
from JSAnimation import IPython_display
from matplotlib import animation

m = 1.
k = 1.
J = 64
tend=100

x = np.linspace(0,1,J) # Equilibrium
x += 0.1*np.sin(2*np.pi*x)
#plt.plot(x,x*0,'or');
#plt.show()

xx = [x.copy()]
dt = 1.0
nsteps = 100
tt = [0.]

xx.append(x.copy())
tt.append(0.+dt)


for n in range(2,tend):
    x[1:-1] = 2*xx[-1][1:-1] - xx[-2][1:-1] + dt**2 * k/m * (x[2:]-2*x[1:-1]+x[:-2])
    xx.append(x.copy())
    tt.append(n*dt)

plt.plot(xx[99],'or');
plt.show()    
