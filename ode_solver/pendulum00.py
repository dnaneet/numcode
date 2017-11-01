'''
This python program solves the following driven damped pendulum equation:
theta''(t) = (-1/Q)theta'(t) + sin(theta(t)) + d cos(Omega t)
Where   theta(t)        : angular position as a fn of time
        Q               : damping factor
        sin(theta(t))   : nonlinear term in Simple Harmonic motion equation
        d               : Driving force amplitude
        Omega           : Driving force frequency

This second order nonlinear differential equation is first transformed to a system of
2 first order diffeqs and then solved using scipy.odeint(...)

The first order diff eqs are:
theta'(t) = omega
omega'(t) = (-1/Q)omega + sin(theta(t)) + d cos(Omega t)
Where   omega = theta'(t) for convenience.

The new initial conditions are given by theta0 and omega0.  These are fed to the y0
argument in odeint as seen below.

For greater detail, please visit
http://www.physics.nyu.edu/pine/pymanual/html/chap9/chap9_scipy.html#solving-odes

__author__ : folks at physics.nyu.edu
'''
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

def f(y, t, params):
    #print('inside function f...')
    theta, omega = y      # unpack current values of y
    Q, d, Omega = params  # unpack parameters
    derivs = [omega,      # list of dy/dt=f functions
             -omega/Q + np.sin(theta) + d*np.cos(Omega*t)]
    return derivs

# Parameters
print('inside initialization portion...')
Q = 2.0          # quality factor (inverse damping)
d = 1.5          # forcing amplitude
Omega = 0.65     # drive frequency

# Initial values
theta0 = 0.0     # initial angular displacement
omega0 = 0.0     # initial angular velocity

# Bundle parameters for ODE solver
params = [Q, d, Omega]

# Bundle initial conditions for ODE solver
y0 = [theta0, omega0]

# Make time array for solution
tStop = 50.
tInc = 0.05
t = np.arange(0., tStop, tInc)
#print t.size #printing for debugging

# Call the ODE solver
psoln = odeint(f, y0, t, args=(params,))
#print psoln.dtype #printing for debugging
#print psoln.size #printing for debugging

# Plot results
fig = plt.figure(1, figsize=(8,8))

# Plot theta as a function of time
ax1 = fig.add_subplot(311)
ax1.plot(t, psoln[:,0])
ax1.set_xlabel('time')
ax1.set_ylabel('theta')

# Plot omega as a function of time
ax2 = fig.add_subplot(312)
ax2.plot(t, psoln[:,1])
ax2.set_xlabel('time')
ax2.set_ylabel('omega')

# Plot omega vs theta
ax3 = fig.add_subplot(313)
twopi = 2.0*np.pi
ax3.plot(psoln[:,0]%twopi, psoln[:,1], '.', ms=1)
ax3.set_xlabel('theta')
ax3.set_ylabel('omega')
ax3.set_xlim(0., twopi)

plt.tight_layout()
plt.show()
