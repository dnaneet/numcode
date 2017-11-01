import numpy as np 
from scipy.linalg import eigh
import math
from matplotlib import pyplot as plt 
import time
import os

os.system('clear') #Clear screen on linux.  For Win, use os.system('cls')


## FUNCTION DECLARATION ##
#SpringElementStiffness: takes linear spring stiffness value as argument
def SpringElementStiffness(k):
    print 'stiffness matrix:\n', np.array([[k,-k],[-k,k]])
    
    return np.array([[k,-k],[-k,k]])

#Spring Assemble: takes K_global, k_local, nodes of connectivity (m,n) as arguments    
def SpringAssemble(K_global,k_local,m,n):
    K_global[m,m]+=k_local[0,0]
    K_global[m,n]+=k_local[0,1]
    K_global[n,m]+=k_local[1,0]
    K_global[n,n]+=k_local[1,1]
    
    return K_global    



## INITIALIZATION ##
nNodes=2 #Number of nodes in structure
Area=0.2
Ey=210.*10**9
L0=1.
k=Area*Ey/L0
restrained_dofs = [0,] #Fixed boundary condition
force=np.array([0,100000])
k_1=SpringElementStiffness(k)	#Creates local spring element 2x2 stifness matrix
#k_2=SpringElementStiffness(k) #Creates local spring element 2x2 stifness matrix
print('\n****************************\n')
K_global = np.zeros((nNodes,nNodes))
rows=K_global.shape[0]
cols=K_global.shape[1]
print 'Init K_global:\n', K_global
print('\n****************************\n')


#Calling spring assemble
SpringAssemble(K_global,k_1,0,1)
print 'K_global:\n', K_global
print('\n****************************\n')
#SpringAssemble(K_global,k_2,1,2)
#print 'K_global:\n', K_global
#print('\n****************************\n')

#Removal of fixed dofs in global stiffness matrix and force vector
#for dof in restrained_dofs:
#    for i in [0,1]:
#		K_global = np.delete(K_global, dof, axis=i)
K_global=np.delete(K_global,0,0)
K_global=np.delete(K_global,0,1)

print('force vector: \n'), force[1:nNodes]	
force=np.array(force[1:nNodes])
		
print 'K_global:\n', K_global
print('\n****************************\n\n')		

#print(K_global.shape, force.shape) #Assertion statement

## SOLUTION OF {F}=[K_global]{x} ##
x=np.linalg.solve(K_global,force)
print(x) #Print to screen displacement vector

#eof    
       
