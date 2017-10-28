#This is a program to evaluate my business for the quadratic nonlinearity
from numpy import *
from GenRK import GenRK
from math import sin
from pylab import *



#I value user input, so here we ask for some
partition_number = raw_input("Number of partitions: ")
arpha = raw_input("Parameter value: ")
steps = raw_input("Time steps: ")

n = int(partition_number) 		#Converts the string input to integer variable
arpha = float(arpha)			#Converts the string input to a floating point
steps=int(steps)				#Converts the string input to integer variable
t_init = 0						#Sets the initial time at 0
x_init = []						#To be used for our initial conditions
h=.1							#Defines our time step
x = np.linspace(0,1,n)
#Defines function which is the dynamic describing the system
def dynamic(t,x):
	y = []
	y.append(0)						#Sets the first points velocity to 0
	for i in range(1,n):			#Sets points 1 to n-1 velocity to the appropriate variables
		placeholder=x[i+n+1]		
		y.append(placeholder)
	y.append(0)						#Sets point n's velocity to 0
	y.append(0)						#sets the acceleration of first point to 0
	for k in range(1,n):			#Sets points 1 to n-1 acceleration to the appropriate variables
		a = (x[k+1]-x[k]) + (x[k-1]-x[k])
		b = arpha * ( (x[k+1] - x[k])**2 - (x[k] - x[k-1])**2)
		c = a+b
		y.append(c)
	y.append(0)						#Sets point n's acceleration to 0
	work_dammit = array(y)
	return work_dammit

#Sets the initial conditions of the string's position
#blah = sin(2*pi*(float(k)/(n)))
for k in range(n+1):
	blah = np.cumsum(np.exp(-300*(x-0.5)**2))
	x_init.append(blah)

#Sets the initial conditions of the string's velocity
for k in range(n+1):
	blah = 0
	#blah = -.1*abs(sin(2*pi*5(float(k)/n)))
	x_init.append(blah)

x_init = array(x_init)
N = range(n+1)

#All this actually plans the plot
figure(1,(8,6))
title('Quadratic Nonlinear Terms')
xlabel('String Position')
ylabel('Displacement')

for l in range(steps):
	x_init = GenRK(t_init,x_init,dynamic,h,1)	#Integrates the system once
	xpl=[]
	for i in range(n+1):
		xpl.append(x_init[i])

plot(N,xpl)
show()
