#This is a python script for the 3 spring and 3 node assembly that is first solved in the course on "intro to the FEM" (MEEM 4405) at Michigan Tech.
#Code version 1.0. 1/25/2017.  Aneet Narendranath
#
#Please carefully read this license: https://creativecommons.org/licenses/by-nc-sa/4.0/
#You are free to:
#..Share - copy and redistribute the material in any medium or format
#..Adapt - remix, transform, and build upon the material
#..Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
#..NonCommercial - You may not use the material for commercial purposes.
#ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
#
#Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
#
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
nNodes=4 #Number of nodes in structure
restrained_dofs = [0,] #Fixed boundary condition
force=np.array([0,0,15000])
k_1=SpringElementStiffness(100000)	#Creates local spring element 2x2 stifness matrix
k_2=SpringElementStiffness(200000) #Creates local spring element 2x2 stifness matrix
k_3=SpringElementStiffness(200000) #Creates local spring element 2x2 stifness matrix
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
SpringAssemble(K_global,k_2,1,2)
print 'K_global:\n', K_global
print('\n****************************\n')
SpringAssemble(K_global,k_3,1,3)
print 'K_global:\n', K_global
print('\n****************************\n')

#Removal of fixed dofs in global stiffness matrix and force vector
#...in this example, nodes 0 2 and 3 are fixed.  To remove these dofs, first np.delete(...) is used to delete node 0.  Then a decrement is necessary for node 2->1 (also node 3->2).  Now, np.delete(...) removes the new node 1 (previously node 2).  Another decrement is necessary for node 3->2->1.  Finally, np.delete(...) removes the new node 1 (which was node 3 at the beginning)
for i in [0,1]:
    K_global = np.delete(K_global, 0, axis=i) #0 is removed.  2->1, 3->2
    K_global = np.delete(K_global, 1, axis=i) # 1 (in the beginning, node 2) is removed. 3->2->1
    K_global = np.delete(K_global, 1, axis=i) # 1 is removed (in the beginning, node 3)

print 'K_global:\n', K_global
#K_global=np.delete(K_global,0,1)

#print('force vector: \n'), force[1:nNodes]	
#force=np.array(force[1:nNodes])
		
#print 'K_global:\n', K_global
#print('\n****************************\n\n')		

#print(K_global.shape, force.shape) #Assertion statement

## SOLUTION OF {F}=[K_global]{x} ##
#x=np.linalg.solve(K_global,force)
#print(x) #Print to screen displacement vector

#eof    
       
