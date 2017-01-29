import numpy as np 
from scipy.linalg import eigh
import math
from matplotlib import pyplot as plt 
import time

def bar2(num_elems):
	restrained_dofs = [0, ]

	# element mass and stiffness matrices
	k = np.array([[1,-1],[-1,1]]) * float(num_elems)

	# construct global mass and stiffness matrices
	K = np.zeros((num_elems+1,num_elems+1))

	# for each element, change to global coordinates
	for i in range(num_elems):
		K_temp = np.zeros((num_elems+1,num_elems+1))
		K_temp[i:i+2, i:i+2] = k
		K += K_temp

	# remove the fixed degrees of freedom
	for dof in restrained_dofs:
		for i in [0,1]:
			K = np.delete(K, dof, axis=i)

	return  K
	 #frequencies, evecs
	 
    print bar2(2)
