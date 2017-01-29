import numpy as np
from math import sqrt
import matplotlib.pyplot as plt

'''
The following code solves the second order system:
        u' = x + v; u(0) = 0
        v' = u v^2; v(0) = 1
        
The second order Runge Kutta method is used to solve this system.
Here, x + v = f and u v^2 = g
'''
def f(x, v):
    return x + v #RHS of first order differential equation

def g(u, v):
    return u*v*v

def rk4(f, g, x0, u0, v0, x1, n): #Runge-Kutta fourth order
    #vx = [0] * (n + 1)
    vx=np.zeros((n+1,1)) #using numpy array to define vector x
    #print(vx) #for debugging only
    #vy = [0] * (n + 1)
    vu=np.zeros((n+1,1)) #using numpy array to define vector u
    vv=np.zeros((n+1,1)) #using numpy array to define vector v
    #print(vy) #for debugging only
    h = (x1 - x0) / float(n) #Step size
    vx[0] = x = x0 #x0 in (x0,x1)
    vu[0] = u = u0 #initial condition u(x=x0)=u0
    vv[0] = v = v0 #initial condition v(x=x0)=v0
    for i in range(1, n + 1): #RK4 loop
        #k1 = h * f(x, u, v) #this is a template for k1 for RK4
        k1 = h * f(x, v)
        #l1 = h * g(x, u, v) #this is a template for l1 for RK4
        l1 = h * g(u, v)
        
        #k2 = h * f(x + 0.5 * h, u + 0.5 * k1, v + 0.5 * l1) #this is a template for k2 for RK4
        k2 = h * f(x + 0.5 * h, v + 0.5 * l1)
        #l2 = h * g(x + 0.5 * h, u + 0.5 * k1, v + 0.5 * l1) #this is a template for l2 for RK4
        l2 = h * g(u + 0.5 * k1, v + 0.5 * l1)
        
        #k3 = h * f(x + 0.5 * h, u + 0.5 * k2, v + 0.5 * l2)
        k3 = h * f(x + 0.5 * h, v + 0.5 * l2)
        #l3 = h * g(x + 0.5 * h, u + 0.5 * k2, v + 0.5 * l2)
        l3 = h * g(u + 0.5 * k2, v + 0.5 * l2)
        
        #k4 = h * f(x + h, u + k3)
        k4 = h * f(x + h, v + l3)
        #l4 = h * g(x + h, u + k3)
        l4 = h * g(u + k3, v + l3)
        
        vx[i] = x = x0 + i * h #Proceed to next value of x
        vu[i] = u = u + (k1 + k2 + k2 + k3 + k3 + k4) / 6 #next value of u
        vv[i] = v = v + (l1 + l2 + l2 + l3 + l3 + l4) / 6 #next value of v
        
    return vx, vu, vv

x1=1
nodes=x1*20
vx, vu, vv = rk4(f, g, 0, 0, 1, x1, nodes) #f, g, u0, v0, x0, 
m=nodes/float(10)
print vu
print vv

#plt.plot(vu, vv, 'rp')
#plt.axis([0, 5, 0, 100])
#plt.show()


##print(vx)
##print(vu)
##print(vv)

##for x in list(zip(vx, vu, vv))[::1]:
##    print x

##for x, y in list(zip(vx, vu, vv))[::m]: #in [::m], prints every m elements
##    print("%4.1f %10.5f %10.5f" % (x, u, v))
##print('\n')

