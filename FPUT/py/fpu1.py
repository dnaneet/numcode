import matplotlib.pyplot as plt
import numpy as np
from JSAnimation import IPython_display
from matplotlib import animation



# Implement nonlinear spring chain
m = 1.
k = 1.
J = 128
alpha = 0.1
tend=500

x = np.linspace(0,1,J) # Equilibrium
x = np.cumsum(np.exp(-300*(x-0.5)**2))
#x = x/x[-1]

###DEBUGGING
#plt.plot(np.diff(x));#x,x*0,'or');
###DEBUGGING

xx = [x.copy()]
dt = 0.001

# Euler for first step -- do nothing because initial velocity is zero
xx.append(x.copy())
for n in range(2,tend):
    x[1:-1] = 2*xx[-1][1:-1] - xx[-2][1:-1] + dt**2 * k/m * (x[2:]-2*x[1:-1]+x[:-2] 
                                        + alpha*((xx[-1][2:]-xx[-1][1:-1])**2-(xx[-1][1:-1]-xx[-1][:-2])**2))
    xx.append(x.copy())


#plt.plot(xx[J-2],'or');
#plt.show()

yy = xx[0:tend]
#for i in range(len(yy)):
#    plt.plot(yy[i])

#plt.show()    

##fig, ax = plt.subplots(1,1,figsize=(14,14))
tdarr = np.empty([len(yy[0])-1,len(yy)])
for i in range(len(yy)):
    tdarr[:,i] = np.diff(yy[i])
plt.imshow(tdarr,aspect=(float(tdarr.shape[1])/tdarr.shape[0]),cmap='RdBu');
###plt.colorbar(ax)
##plt.plot(yy[J])
plt.show()

