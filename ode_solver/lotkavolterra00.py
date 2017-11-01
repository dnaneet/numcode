'''
This python program solves the Lotka-Volterra coupled population dynamics equation:
__Author__: Aneet Narendranath, PhD
'''
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

def f(y, t, params):
    #print('==inside function f==')
    #print('...unpack current values of y #p prey, q predator...')
    p, q = y      # unpack current values of y #p prey, q predator
    #print('...unpack params...')
    a, b, c, d = params  # unpack parameters
    #print('...define derivs...')
    derivs = [a*p - b*p*q,      # list of dy/dt=f functions
              c*p*q - d*q]
    #print('...return derivs...')
    return derivs

# Parameters
##print('==inside initialization portion==')
a=0.4
b=0.002
c=0.001
d=0.7 #coefficients that describe rates of processes

# Initial values
prey0 = 600.0     # initial population of prey
pred0 = 400.0     # initial pop. of predators

# Bundle parameters for ODE solver
params = [a, b, c, d]

# Bundle initial conditions for ODE solver
y0 = [prey0, pred0]

# Make time array for solution
tStop = 50.
tInc = 0.1
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
ax1 = fig.add_subplot(211)
ax1.plot(t, psoln[:,0], 'b.')
ax1.set_xlabel('time')
ax1.set_ylabel('Prey')
##
### Plot omega as a function of time
ax2 = fig.add_subplot(212)
ax2.plot(t, psoln[:,1], 'rx')
ax2.set_xlabel('time')
ax2.set_ylabel('Predator')


plt.tight_layout()
plt.show()
