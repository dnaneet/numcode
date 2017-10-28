#This is a Runge-Kutta method for vector-valued functions of any length
#The user input is an initial condition, vector-valued function, stepsize, and number of steps

def GenRK(t_init,x_init,F,h,n):
	state = x_init
	t = t_init
	for i in range(n):
		k1 = F(t,state)
		k2 = F(t + .5*h,state + .5*h*k1)
		k3 = F(t + .5*h,state + .5*h*k2)
		k4 = F(t + h,state + h*k3)
		phi = (1/6.)*k1 + (1/3.)*k2 + (1/3.)*k3 + (1/6.)*k4
		state = state+h*phi
		t=t+h
	return state