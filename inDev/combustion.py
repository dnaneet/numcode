import numpy as np
from scipy import integrate
from matplotlib.pylab import *
import matplotlib.pyplot as plt

'''
Stiff combustion equation
'''

def combustion(t,y):
    n = len(y)
    dydt = np.zeros((n,1))
    dydt[0] = -15*y
    return dydt

# The ``driver`` that will integrate the ODE(s):
if __name__ == '__main__':

    #backend = 'dopri5'
    backend = 'dop853'
    r = integrate.ode(combustion).set_integrator(backend)

    t_start=0.0
    t_final=1.0
    delta_t=0.01

    num_steps = np.floor((t_final - t_start)/delta_t) + 1

    y0=1.0
    r.set_initial_value([y0], t_start)

    t = np.zeros((int(num_steps), 1))
    y = np.zeros((int(num_steps), 1))
    t[0] = t_start
    y[0] = y0

    sol = []
    k = 1
    while r.successful() and k < num_steps:
        r.integrate(r.t + delta_t) 
        # Store the results to plot later
        t[k] = r.t
        y[k] = r.y[0]
        k += 1
        sol.append([r.t, r.y])

sol = np.array(sol)         
# All done!  Plot the trajectories:
plt.plot(t, y, 'bo')
ylim([-0.1,0.5])
grid('on')
xlabel('Time [minutes]')
ylabel('Concentration [mol/L]')
plt.show()
    
