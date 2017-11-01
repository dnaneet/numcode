import numpy as np
from math import sqrt

def rk4(f, x0, y0, x1, n): #Runge-Kutta fourth order
    #vx = [0] * (n + 1)
    vx=np.zeros((n+1,1)) #using numpy array instead of above list
    #print(vx) #for debugging only
    #vy = [0] * (n + 1)
    vy=np.zeros((n+1,1)) #using numpy array instead of above list
    #print(vy) #for debugging only
    h = (x1 - x0) / float(n)
    vx[0] = x = x0 #x0 in (x0,x1)
    vy[0] = y = y0 #initial condition y(x=x0)=y0
    for i in range(1, n + 1): #RK4 loop
        k1 = h * f(x, y) #calls function f(x,y) and evaluates it with x and y values
        k2 = h * f(x + 0.5 * h, y + 0.5 * k1)
        k3 = h * f(x + 0.5 * h, y + 0.5 * k2)
        k4 = h * f(x + h, y + k3)
        vx[i] = x = x0 + i * h
        vy[i] = y = y + (k1 + k2 + k2 + k3 + k3 + k4) / 6
        #print(i) #for debugging purposes only
    return vx, vy

def rk2(f, x0, y0, x1, n): #Runge-Kutta second order
    vx=np.zeros((n+1,1))
    vy=np.zeros((n+1,1))
    h = (x1 - x0) / float(n)
    vx[0] = x = x0 #x0 in (x0,x1)
    vy[0] = y = y0 #initial condition y(x=x0)=y0
    for i in range(1, n + 1): #RK4 loop
        k1 = h * f(x, y) #calls function f(x,y) and evaluates it with x and y values
        k2 = h * f(x + h, y + k1)
        vx[i] = x = x0 + i * h
        vy[i] = y = y + (k1 + k2) / 2
        #print(i) #for debugging purposes only
    return vx, vy

 
def f(x, y):
    return x * sqrt(y) #RHS of first order differential equation

nodes=100 
vx, vy = rk4(f, 0, 1, 10, nodes)
m=nodes/10
print('Fourth order Runge Kutta for dydx = x * sqrt(y), y(0)=0')
print("x,    Approx,       Exact,      Error")
for x, y in list(zip(vx, vy))[::m]: #in [::m], prints every m elements
    print("%4.1f %10.5f %10.5f %+12.4e" % (x, y, (4 + x * x)**2 / 16, y - (4 + x * x)**2 / 16))
print('\n')

vx, vy = rk2(f, 0, 1, 10, nodes)
print('Second order Runge Kutta for dydx = x * sqrt(y), y(0)=0')
print("x,    Approx,       Exact,      Error")
for x, y in list(zip(vx, vy))[::m]: #in [::m], prints every m elements
    print("%4.1f %10.5f %10.5f %+12.4e" % (x, y, (4 + x * x)**2 / 16, y - (4 + x * x)**2 / 16))    
