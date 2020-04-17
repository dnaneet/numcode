from fenics import *
from dolfin import *
import matplotlib.pyplot as plt
from math import *

#Creating a domain
from mshr import Rectangle, Circle, generate_mesh


#rec = Rectangle(Point(0,0),Point(10,5))
#cir = Circle(Point(5,2.5),1,500) #A Circle at (5,2.5) with radius 1 and divided into 500 elements 
#domain = rec - cir #Boolean Subtract Operation

#The domain can also be directly defined as follows instead of creating three separate lines as done above
domain = Rectangle(Point(0,0),Point(10,5)) - Circle(Point(5,2.5),1,1000)

#Generate the mesh and Plot it
mesh = generate_mesh(domain,100)

#This is our Sobolev Space
V=FunctionSpace(mesh,"CG",1)

plot(mesh,title="A 2D Plate with Center Hole")
print('close plot window to continue...\n')
plt.show()

'''
The Values of the co-dinates of the vertices can be plotted using
coordinates = mesh.coordinates()
print(coordinates)
'''

#Defining the boundary
def boundary(x, on_boundary):
    return on_boundary
#Defining the boundary conditions
#bc0= Expression('1 + x[0]*x[0] + 2*x[1]*x[1]', degree=2) #[This bc was randomly chosen and imposed and when simulated, L2 Norm of error = 34.88 and Max Error = 9.32]
bc0 = Constant(0.0)
bc = DirichletBC(V, bc0, boundary) #Essential Boundary Condition [At boundary u(x,y)=1+x^2+2y^2]

#Defining the approximation functions
u = TrialFunction(V) #Trial function
v = TestFunction(V) #Test function


#Variational formulation
from math import *
a = dot(grad(u), grad(v))*dx
#f = Expression("-sin(5*x[0])",degree=1) #Source term
#f = Expression("10*exp(-(pow(x[0] - 0.5, 2) + pow(x[1] - 0.5, 2)) / 0.02)", degree=1)
L = f*v*dx
u = Function(V)

#solution
solve(a == L, u, bc)

#Plotting the Solution
plot(u)
plt.show()
