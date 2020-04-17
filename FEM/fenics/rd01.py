#Reaction diffusion
from dolfin import *
print('dolfin import complete...\n')
import matplotlib.pyplot as plt


# Create mesh and define function space
mesh = UnitSquareMesh(32, 32)
V = FunctionSpace(mesh, "Lagrange", 1)
print('Unit square mesh created...\n')


plot(mesh);
print('close plot window to proceed...\n')
plt.show()

# Define variational problem
u = TrialFunction(V)
v = TestFunction(V)
f = Expression("exp(-(pow(x[0]-0.5, 2) + pow(x[1]-0.5, 2))/0.02)", degree=1)
a = dot(grad(u), grad(v))*dx + u*v*dx
L = f*v*dx
print('variational form definition complete...\n')

# Compute solution
u = Function(V)
solve(a == L, u)
print('solution complete...\n')

print('solution plot...\n')
plot(u)
print('close plot to end program...\n')
plt.show()
