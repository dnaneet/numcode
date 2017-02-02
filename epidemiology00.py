'''
This python program solves a basic viral epidemiology equation:
__Author__: Aneet Narendranath, PhD
'''
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

def f(y, t, params):
    #print('==inside function f==')
    #print('...unpack current values of y #p prey, q predator...')
    s, i, r = y      # unpack current values of y #p prey, q predator
    #print('...unpack params...')
    a, b = params  # unpack parameters
    #print('...define derivs...')
    derivs = [-b*s*i,      # list of dy/dt=f functions
               b*s*i - a*i,  
               a*i]
    #print('...return derivs...')
    return derivs

# Parameters
##print('==inside initialization portion==')
a=0.05
b=1.0 #coefficients that describe rates of processes

# Initial values
i0 = 0.001
s0 = 0.999
r0 = 0.

# Bundle parameters for ODE solver
params = [a, b]

# Bundle initial conditions for ODE solver
y0 = [s0, i0, r0]

# Make time array for solution
tStop = 150.
tInc = 0.2
t = np.arange(0., tStop, tInc)
##print('==finished init==')
#print t.size #printing for debugging


# Call the ODE solver
##print('...calling odeint...')
psoln = odeint(f, y0, t, args=(params,))
##print psoln.dtype #printing for debugging
##print psoln.size #printing for debugging
##print psoln #printing for debugging

# Plot results
fig = plt.figure(1, figsize=(8,8))
##
### Plot theta as a function of time
ax1 = fig.add_subplot(311)
ax1.plot(t, psoln[:,0], 'b.')
ax1.set_xlabel('time')
ax1.set_ylabel('Susceptible')
##
### Plot omega as a function of time
ax2 = fig.add_subplot(312)
ax2.plot(t, psoln[:,1], 'rx')
ax2.set_xlabel('time')
ax2.set_ylabel('Recovered')

ax3 = fig.add_subplot(313)
ax3.plot(t, psoln[:,2], 'go')
ax3.set_xlabel('time')
ax3.set_ylabel('Infected')


plt.tight_layout()
plt.show()
