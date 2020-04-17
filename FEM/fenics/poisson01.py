from fenics import *
print('fenics imported...\n')
from dolfin import * #mainly for mesh
print('dolfin for meshing imported...\n')
from mshr import Rectangle, Box, Sphere, generate_mesh
print('Imported packages from mshr...\n')

import matplotlib.pyplot as plt

#creating the domain
h=0.25
r=0.3*h
box1 = Box(Point(0,0,0),Point(1,h,h)) #the main block
sp1 = Sphere(Point(0.3,0.5*h,0.5*h),r) #Sphere 1
sp2 = Sphere(Point(0.5,0.65*h,0.65*h),r) #Sphere 2
sp3 = Sphere(Point(0.7,0.35*h,0.35*h),r) #Sphere 3
geo3d = box1 - sp1 - sp2 - sp3
print('geometry created...\n')

# Create mesh and define function space
mesh = generate_mesh(geo3d,5)
V = FunctionSpace(mesh, "Lagrange", 1) #Langrange Interpolation with piece-wise continuity or first order continous function
print('\nGeometry discretization complete...\n')


fig = plt.figure()
ax = fig.gca(projection='3d')
plot(mesh)
print('Close the plot window to continue...\n')
plt.show()
